/*** Eclipse Class Decompiler plugin, copyright (c) 2016 Chen Chao (cnfree2000@hotmail.com) ***/
package org.springframework.data.jpa.repository.query;

import cn.fooltech.fool_ops.config.Constants;
import org.springframework.core.convert.converter.Converter;
import org.springframework.data.jpa.repository.query.JpaQueryExecution.*;
import org.springframework.data.jpa.util.JpaMetamodel;
import org.springframework.data.repository.query.ParametersParameterAccessor;
import org.springframework.data.repository.query.RepositoryQuery;
import org.springframework.data.repository.query.ResultProcessor;
import org.springframework.data.repository.query.ReturnedType;
import org.springframework.util.Assert;

import javax.persistence.*;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Abstract base class to implement {@link RepositoryQuery}s.
 * 
 * @author Oliver Gierke
 * @author Thomas Darimont
 */
public abstract class AbstractJpaQuery implements RepositoryQuery {
	
	private final JpaQueryMethod method;
	private final EntityManager em;
	private final JpaMetamodel metamodel;
	
	/**
	 * Creates a new {@link AbstractJpaQuery} from the given {@link JpaQueryMethod}.
	 * 
	 * @param method
	 * @param em
	 */
	public AbstractJpaQuery(JpaQueryMethod method, EntityManager em) {

		Assert.notNull(method);
		Assert.notNull(em);
	
		this.method = method;
		this.em = em;
		this.metamodel = new JpaMetamodel(em.getMetamodel());
	}

	/*
	 * (non-Javadoc)
	 * @see org.springframework.data.repository.query.RepositoryQuery#getQueryMethod()
	 */
	public JpaQueryMethod getQueryMethod() {
		return method;
	}
	
	/**
	 * Returns the {@link EntityManager}.
	 * 
	 * @return will never be {@literal null}.
	 */
	protected EntityManager getEntityManager() {
		return em;
	}
	
	/**
	 * Returns the {@link JpaMetamodel}.
	 * 
	 * @return
	 */
	protected JpaMetamodel getMetamodel() {
		return metamodel;
	}
	
	/*
	 * (non-Javadoc)
	 * @see org.springframework.data.repository.query.RepositoryQuery#execute(java.lang.Object[])
	 */
	public Object execute(Object[] parameters) {
		return doExecute(getExecution(), parameters);
	}
	
	/**
	 * @param execution
	 * @param values
	 * @return
	 */
	private Object doExecute(JpaQueryExecution execution, Object[] values) {
	
		Object result = execution.execute(this, values);
	
		ParametersParameterAccessor accessor = new ParametersParameterAccessor(method.getParameters(), values);
		ResultProcessor withDynamicProjection = method.getResultProcessor().withDynamicProjection(accessor);
	
		return withDynamicProjection.processResult(result, new TupleConverter(withDynamicProjection.getReturnedType()));
	}
	
	protected JpaQueryExecution getExecution() {

		List<QueryHint> x = method.getHints();
		for (QueryHint queryHint : x) {
			if(queryHint.name().equals(Constants.LIMIT)){

				final Integer top = Integer.valueOf(queryHint.value());

				if(top==1 && method.isQueryForEntity()){
					return new JpaQueryExecution() {
						@Override
						protected Object doExecute(AbstractJpaQuery query, Object[] values) {

							List list = query.createQuery(values).setFirstResult(0).setMaxResults(top).getResultList();
							if(list.size()>0)return list.get(0);
							return null;
						}
					};
				}else{
					return new JpaQueryExecution() {
						@Override
						protected Object doExecute(AbstractJpaQuery query, Object[] values) {
							return query.createQuery(values).setFirstResult(0).setMaxResults(top).getResultList();
						}
					};
				}
			}
		}
		
		
		if (method.isStreamQuery()) {
			return new StreamExecution();
		} else if (method.isProcedureQuery()) {
			return new ProcedureExecution();
		} else if (method.isCollectionQuery()) {
			return new CollectionExecution();
		} else if (method.isSliceQuery()) {
			return new SlicedExecution(method.getParameters());
		} else if (method.isPageQuery()) {
			return new PagedExecution(method.getParameters());
		} else if (method.isModifyingQuery()) {
			return method.getClearAutomatically() ? new ModifyingExecution(method, em) : new ModifyingExecution(method, null);
		} else {
			return new SingleEntityExecution();
		}
	}
	
	/**
	 * Applies the declared query hints to the given query.
	 * 
	 * @param query
	 * @return
	 */
	protected <T extends Query> T applyHints(T query, JpaQueryMethod method) {
	
		for (QueryHint hint : method.getHints()) {
			applyQueryHint(query, hint);
		}
	
		return query;
	}
	
	/**
	 * Protected to be able to customize in sub-classes.
	 * 
	 * @param query must not be {@literal null}.
	 * @param hint must not be {@literal null}.
	 */
	protected <T extends Query> void applyQueryHint(T query, QueryHint hint) {
	
		Assert.notNull(query, "Query must not be null!");
		Assert.notNull(hint, "QueryHint must not be null!");
	
		query.setHint(hint.name(), hint.value());
	}
	
	/**
	 * Applies the {@link LockModeType} provided by the {@link JpaQueryMethod} to the given {@link Query}.
	 * 
	 * @param query must not be {@literal null}.
	 * @param method must not be {@literal null}.
	 * @return
	 */
	private Query applyLockMode(Query query, JpaQueryMethod method) {
	
		LockModeType lockModeType = method.getLockModeType();
		return lockModeType == null ? query : query.setLockMode(lockModeType);
	}
	
	protected ParameterBinder createBinder(Object[] values) {
		return new ParameterBinder(getQueryMethod().getParameters(), values);
	}
	
	protected Query createQuery(Object[] values) {
		return applyLockMode(applyEntityGraphConfiguration(applyHints(doCreateQuery(values), method), method), method);
	}
	
	/**
	 * Configures the {@link EntityGraph} to use for the given {@link JpaQueryMethod} if the
	 * {@link EntityGraph} annotation is present.
	 * 
	 * @param query must not be {@literal null}.
	 * @param method must not be {@literal null}.
	 * @return
	 */
	private Query applyEntityGraphConfiguration(Query query, JpaQueryMethod method) {
	
		Assert.notNull(query, "Query must not be null!");
		Assert.notNull(method, "JpaQueryMethod must not be null!");
	
		Map<String, Object> hints = Jpa21Utils.tryGetFetchGraphHints(em, method.getEntityGraph(),
				getQueryMethod().getEntityInformation().getJavaType());
	
		for (Map.Entry<String, Object> hint : hints.entrySet()) {
			query.setHint(hint.getKey(), hint.getValue());
		}
	
		return query;
	}

	protected Query createCountQuery(Object[] values) {
		Query countQuery = doCreateCountQuery(values);
		return method.applyHintsToCountQuery() ? applyHints(countQuery, method) : countQuery;
	}

	/**
	 * Creates a {@link Query} instance for the given values.
	 * 
	 * @param values must not be {@literal null}.
	 * @return
	 */
	protected abstract Query doCreateQuery(Object[] values);


	/**
	 * Creates a {@link TypedQuery} for counting using the given values.
	 * 
	 * @param values must not be {@literal null}.
	 * @return
	 */
	protected abstract Query doCreateCountQuery(Object[] values);

	static class TupleConverter implements Converter<Object, Object> {

		private final ReturnedType type;

		/**
		 * Creates a new {@link TupleConverter} for the given {@link ReturnedType}.
		 * 
		 * @param type must not be {@literal null}.
		 */
		public TupleConverter(ReturnedType type) {

			Assert.notNull(type, "Returned type must not be null!");

			this.type = type;
		}

		/* 
		 * (non-Javadoc)
		 * @see org.springframework.core.convert.converter.Converter#convert(java.lang.Object)
		 */
		@Override
		public Object convert(Object source) {

			if (!(source instanceof Tuple)) {
				return source;
			}

			Tuple tuple = (Tuple) source;
			Map<String, Object> result = new HashMap<String, Object>();
			List<TupleElement<?>> elements = tuple.getElements();

			if (elements.size() == 1) {

				Object value = tuple.get(elements.get(0));

				if (type.isInstance(value)) {
					return value;
				}
			}

			for (TupleElement<?> element : elements) {

				String alias = element.getAlias();

				if (alias == null || isIndexAsString(alias)) {
					throw new IllegalStateException("No aliases found in result tuple! Make sure your query defines aliases!");
				}

				result.put(element.getAlias(), tuple.get(element));
			}

			return result;
		}

		private static boolean isIndexAsString(String source) {

			try {
				Integer.parseInt(source);
				return true;
			} catch (NumberFormatException o_O) {
				return false;
			}
		}
	}
}