package cn.fooltech.fool_ops.domain.warehouse.service.bill;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import cn.fooltech.fool_ops.component.core.RequestResult;
import cn.fooltech.fool_ops.domain.warehouse.builder.BaseWarehouseWebServiceBuilder;
import cn.fooltech.fool_ops.domain.warehouse.service.BillRelationService;
import cn.fooltech.fool_ops.domain.warehouse.util.WarehouseBuilderCode;
import cn.fooltech.fool_ops.domain.warehouse.util.WarehouseBuilderCodeHelper;
import cn.fooltech.fool_ops.domain.warehouse.vo.WarehouseBillVo;


/**
 * <p>采购入库网页服务类</p>
 * @author xjh
 * @version 1.0
 * @date 2015年9月24日
 */
@Service("ops.PurchaseInWebService")
public class PurchaseInWebService extends BaseWarehouseWebServiceBuilder{
	
	
	@Override
	@Value("#{T(cn.fooltech.fool_ops.domain.warehouse.util.WarehouseBuilderCode).cgrk}")
	public void setBuilderCode(WarehouseBuilderCode builderCode) {
		super.setBuilderCode(builderCode);
	}
	
	/**
	 * 重写save，插入单据关联
	 * @param vo
	 * @return 
	 */
	@Override
	public RequestResult save(WarehouseBillVo vo) {
		RequestResult parentResult = super.save(vo);
		
		if(parentResult.getReturnCode()==RequestResult.RETURN_SUCCESS && 
				StringUtils.isNotBlank(vo.getRelationId())){

			String billId = parentResult.getData().toString();
			int refType = WarehouseBuilderCodeHelper.getBillType(WarehouseBuilderCode.cgdd);
			super.insertBillRelation(billId, vo.getRelationId(), vo.getBillType(), refType);
		}
		return parentResult;
	}
}
