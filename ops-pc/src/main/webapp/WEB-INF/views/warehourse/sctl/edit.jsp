<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/common.jsp"%>

<html>
<head>
</head>
<body>
          <!-- 货品属性选择框 -->
          <div id="goodsSpecChooser">
            <div id="goodsSpecSearcher">
              <input id="search-goodsSpecName"/><a id="search-goodsSpecBtn" class="btn-blue btn-s">筛选</a>
            </div>
            <table id="goodsSpecTable"></table>
          </div>
          
          <!-- 货品选择框 -->
          <div id="goodsChooser">
            <div id="goodsSearcher">
              <input id="search-goodsCode"/> <input id="search-goodsName"/> <input id="search-goodsSpec"/> <a id="search-goodsBtn" class="btn-blue btn-s">筛选</a>
            </div>
            <table id="goodsTable"></table>
            <p style="margin-left:44px"><font><a id="ok" class="btn-blue btn-s">确认</a></font></p> 
          </div>
          
          <!-- 表单 -->
          <div class="form1" >
              <form id="form">
                <input id="fid" type="hidden" value="${obj.fid}"/>
                <input id="updateTime" type="hidden" value="${obj.updateTime}"/>
                <input id="inMemberId" type="hidden" value="${obj.inMemberId}"/>
                <input id="relationId" type="hidden" value="${obj.relationId}"/>
                <p><font>凭证号：</font><input data-options="validType:'maxLength[50]'" id="voucherCode" class="textBox" value="${obj.voucherCode}"/></p>
				<p><font><em>*</em>单号：</font><input id="code" class="textBox" value="${obj.code}"/></p>
				<p><font><em>*</em>单据日期：</font><input id="billDate" class="textBox" value="${obj.billDate}"/></p>
				<p><font><em>*</em>部门：</font><input id="deptName" class="textBox"/></p>
				<p><font>仓库：</font><input id="inWareHouseName" class="textBox"/></p>
				<p><font><em>*</em>退料员：</font><input id="inMemberName" class="textBox" value="${obj.inMemberName}"/></p>
				<p><font><em>*</em>计划完成日期：</font><input id="planEnd" class="textBox" value="${obj.endDate}"/></p>
				<p><font>生产领料单：</font><input id="relationName" class="textBox" value="${obj.relationName}"/><a href="#" title="清除" class="clearBill"><img style="vertical-align:middle;" src="${ctx}/resources/images/cancel.png"></a></p>
				<p style="width:76.5%;"><font>备注：</font><input data-options="validType:'maxLength[200]'" id="describe" class="textBox" style="width:80%;" value="${obj.describe}"/></p><br/> 
				<h3 style="display: inline-block;margin-left:44px">&emsp;其他信息：</h3><img id="openBtn" alt="展开" src="${ctx}/resources/images/openNode.png" style="vertical-align: middle;"><img id="closeBtn" alt="展开" src="${ctx}/resources/images/closeNode.png" style="vertical-align: middle;display: none"><br/>
				<p class="hideOut"><font>制单人：</font><input id="creatorName" class="textBox" readonly="readonly" value="${obj.creatorName}"/></p>
				<p class="hideOut"><font>制单时间：</font><input id="createTime" class="textBox" readonly="readonly" value="${obj.createTime}"/></p>
				<p class="hideOut"><font>审核人：</font><input id="auditorName" class="textBox" readonly="readonly" value="${obj.auditorName}"/></p>
				<p class="hideOut"><font>审核时间：</font><input id="auditTime" class="textBox" readonly="readonly" value="${obj.auditTime}"/></p>
				<p class="hideOut"><font>作废人：</font><input id="cancelorName" class="textBox" readonly="readonly" value="${obj.cancelorName}"/></p>
				<p class="hideOut"><font>作废时间：</font><input id="cancelTime" class="textBox" readonly="readonly" value="${obj.cancelTime}"/></p>
              </form>
          </div>
          
          <!-- 货品明细列表 -->
          <form id="goodsForm">
            <table id="goodsList"></table>
          </form>
          <div id="toolbar">
          ${(obj.recordStatus==null||obj.recordStatus==0)?' <a href="#" id="addGoods" class="btn-ora-add">新增</a> <a href="#" id="okAll" class="btn-ora-add" style="display:none">一键确认</a>':''}
          </div>
          
          <!-- 按钮组 -->
          <div class="form1" id="btnBox">
          </div>

<script type="text/javascript">
var inWareHouseId1='';

$("input").attr('autocomplete','off');
var chooserWindow="";
var _data="";
if($("#fid").val()){
	 _data= ${obj.details}
	 _data;
}

var goodsSpecData="";
$.ajax({
	url:"${ctx}/goodsspec/getChidlList",
	async:false,
	data:{q:""},
	success:function(data){
		goodsSpecData=data;
	}
});

$(function(){	
	var unitData="";	
	//初始化表单控件
	validateBox($("#relationName"));
	validateBox($("#code"),true);
	validateBox($("#inMemberName"),true);
	validateBox($("#voucherCode"));
	validateBox($("#describe")); 
	dateBox($("#billDate"),true);
	validateBox($("#creatorName"));
	validateBox($("#createTime"));
	validateBox($("#auditorName"));
	validateBox($("#auditTime"));
	validateBox($("#cancelorName"));
	validateBox($("#cancelTime"));
	dateBox($("#planEnd"),true);
	comboTree($("#inWareHouseName"),"${ctx}/basedata/warehourseList",false,function(node,data){
		if(data[0].id!=""){
			var node=$(this).tree("find",data[0].id);
			$(this).tree('update',{
				target: node.target,
				text: '请选择',
				id:null
			});
		}
		$("#inWareHouseName").combotree("setValue","${obj.inWareHouseId}");
	},function(node){
		var root=$(this).tree('getRoot');
		if(node.id==root.id){
			$("#inWareHouseName").combotree('clear');
		};
	});
	comboTree($("#deptName"),"${ctx}/orgController/getAllTree",true,function(node, data){
		 if(data[0].id!=""){
			var node=$(this).tree("find",data[0].id);
			$(this).tree('update',{
				target: node.target,
				text: '请选择', 
				id:null
			});
		} 
		$("#deptName").combotree('setValue','${obj.deptId}');
	},function(node){
		var root=$(this).tree('getRoot');
		if(node.id==root.id){
			$("#deptName").combotree('clear');
		}; 
	});
	
	textBox($("#search-goodsCode"),"编号");
	textBox($("#search-goodsName"),"名称");
	textBox($("#search-goodsSpec"),"规格");
	textBox($("#search-goodsSpecName"),"属性名");
	
	if('${obj.totalAmount}'=="0E-8"){
		$("#totalAmount").val(0);
	}else{
		$("#totalAmount").val('${obj.totalAmount}');
	}
	
	//判断有无订单号生成规则
	if($("#fid").val()){
		$("#code").val('${obj.code}');
		$("#code").attr("readonly","readonly");
		if('${code}'){
			$("#fid").val("");
			$("#code").val('${code}');
			$("#code").attr("readonly","readonly");
		}
	}
	else if('${code}'){
		$("#code").val('${code}');
		$("#code").attr("readonly","readonly");
	}
	
	//判断订单状态
	if(${empty obj.recordStatus}){
		$("#btnBox").append('<p><input type="button" id="save" class="btn-blue2 btn-xs" value="保存" /></p>');	
	}else if(${obj.recordStatus eq 0}){	
		$("#btnBox").append('<p><input type="button" id="save" class="btn-blue2 btn-xs" value="保存" /></p> <p><input type="button" id="copy" class="btn-blue2 btn-xs" value="复制" /></p> <p><input type="button" id="print" class="btn-blue2 btn-xs" value="打印" /></p> <p><input type="button" id="refreshForm" class="btn-blue2 btn-xs" value="刷新"/></p>');
		/* if("${param.see}"==1){
			$("#inWareHouseId").combotree({hasDownArrow:false});
			$("#form").find("input").attr('disabled','disabled');
			$("#billDate").datebox('disable');
			$("#addGoods").attr('disabled','disabled');
			$("#btnBox").html("");
		}; */
	}else if(${obj.recordStatus eq 1}){
		$("#deptName").combotree({hasDownArrow:false});
		$("#inWareHouseName").combotree({hasDownArrow:false});
		$("#billDate,#planEnd").datebox('disable');
		$("#form").find("input").attr('disabled','disabled');
		$("#addGoods").attr('disabled','disabled');
		$("#btnBox").append('<p><input type="button" id="copy" class="btn-blue2 btn-xs" value="复制" /></p> <p><input type="button" id="print" class="btn-blue2 btn-xs" value="打印" /></p> <p><input type="button" id="refreshForm" class="btn-blue2 btn-xs" value="刷新"/></p><p><input type="button" id="cancel" class="btn-blue2 btn-xs dd" value="刷新"/></p>');
	}else if(${obj.recordStatus eq 2}){
		$("#deptName").combotree({hasDownArrow:false});
		$("#inWareHouseName").combotree({hasDownArrow:false});
		$("#billDate,#planEnd").datebox('disable');
		$("#form").find("input").attr('disabled','disabled');
		$("#addGoods").attr('disabled','disabled');
		$("#btnBox").append('<p><input type="button" id="copy" class="btn-blue2 btn-xs" value="复制" /></p> <p><input type="button" id="print" class="btn-blue2 btn-xs" value="打印" /></p>');
	}
	$.get("${ctx}/unitController/getLeafUnit",function(data){
		unitData=data;
		//初始化订单明细列表（货品列表）
		$("#goodsList").datagrid({
			singleSelect:true,
			data:_data,
			//pagination:true,
			scrollbarSize:0,
			fitColumns:true,
			toolbar:"#toolbar",
			columns:[[
				  		{field:'goodsId',title:'fid',hidden:true,width:100},
				  		{field:'barCode',title:'货品条码',sortable:true,width:100},
						{field:'goodsCode',title:'货品编号',sortable:true,width:100}, 
						{field:'goodsName',title:'货品名称',sortable:true,width:150},
						{field:'inWareHouseId',title:'仓库ID',hidden:true,width:100,editor:{type:'textbox'}},
						{field:'inWareHouseName',title:'仓库',sortable:true,width:100,editor:{type:'combotree',options:{required:true,novalidate:true,url:"${ctx}/basedata/warehourseList",onLoadSuccess:function(node,data){
							if(data[0].id!=""){
								var node=$(this).tree("find",data[0].id);
								$(this).tree('update',{
									target: node.target,
									text: '请选择',
									id:null
								});
							}										
						},onSelect:function(node){
							 var root=$(this).tree('getRoot');
							if(node.id==root.id){
								combotree('clear');
							}; 
						}}} ,formatter:function(value,row,index){
		                	if(value){
		                		var name="";
		                		$.ajax({
		                			url:"${ctx}/basedata/getById",
		                			async:false,
				                    data:{fid:value},
				                    success:function(data){
				                    	if(data){
				                    		name=data.name;
				                    	}
				                    }
		                		});
		                		if(name){
		                			return name;
		                		}else{
		                			return value;
		                		}
		                	}				  
		                }},
						{field:'goodsSpec',title:'规格',sortable:true,width:100},
						{field:'goodsSpecId',hidden:true,sortable:true,width:100},
						{field:'goodsSpecName',title:'属性',formatter:function(value){
					  		for(var i=0; i<goodsSpecData.length; i++){
					  			if (goodsSpecData[i].fid == value) return goodsSpecData[i].name;
					  		}
					  		return value;
					  	},editor:{type:'combobox',options:{required:true,valueField:"fid",textField:"name",mode:"remote",novalidate:true,onBeforeLoad:function(param){
							if(!$(this).combobox('options').url||$(this).combobox('options').url==""){
								var index=$(this).parents("[field='goodsSpecName']").parent(".datagrid-row").attr("datagrid-row-index");
								$(this).combobox({ 
									url:"${ctx}/goodsspec/getChidlList?groupId="+$(this).parents("[field='goodsSpecName']").siblings("[field='goodsSpecGroupId']").children().text(),
									validType:"goodsSpec["+index+"]"
											
								});
								param.q="";
							}
						},onSelect:function(record){
							$(this).parents("[field='goodsSpecName']").prev().children().text(record.fid);
						}}},sortable:true,width:100},
					    {field:'unitId',hidden:true,sortable:true,width:100},
				  		{field:'unitName',title:'单位',formatter:function(value){
							for(var i=0; i<unitData.length; i++){
								if (unitData[i].fid == value) return unitData[i].name;
							}
							return value;
						},editor:{type:'combobox',options:{
							valueField:"fid",
							textField:"name",
							required:true,
							editable:false,
							onShowPanel:function(){
								$(this).combobox('reload',"${ctx}/unitController/getChilds?unitGroupId="+$(this).parents("[field='unitName']").siblings("[field='unitGroupId']").children().text())
							},
							onSelect:function(record){
								var scaleField=$(this).parents("[field='unitName']").next().children();
							    var lowestPriceField=$(this).parents("[field='unitName']").siblings("[field='lowestPrice']").children();
							    var unitPriceField=$(this).parents("[field='unitName']").siblings("[field='unitPrice']").find(".numberbox-f");
							    var costPriceField=$(this).parents("[field='unitName']").siblings("[field='costPrice']").find(".numberbox-f");
							    var goodsId=$(this).parents("[field='unitName']").siblings("[field='goodsId']").children().text();
							    var goodsSpecId="";
							    goodsSpecId=$(this).parents("[field='unitName']").siblings("[field='goodsSpecId']").children().text();
							    $(this).parents("[field='unitName']").prev().children().text(record.fid);
							    $.post("${ctx}/unitController/get",{id:record.fid},function(data){scaleField.text(data.scale)});
							    $.post("${ctx}/goods/getOtherPrice",{billType:'sctl',fid:goodsId,unitId:record.fid,goodsSpecId:goodsSpecId},function(data){lowestPriceField.text(data.lowestPrice);unitPriceField.numberbox('setValue',data.referencePrice);costPriceField.numberbox('setValue',data.costPrice)});
						}}},sortable:true,width:100},
						{field:'scale',title:'换算关系',sortable:true,width:100},
						{field:'quentity',title:'数量',editor:{type:'numberbox',options:{precision:2,required:true,validType:'intOrFloat'}},sortable:true,width:100},
						{field:'lowestPrice',title:'最低价',hidden:true,width:100},
						{field:'unitPrice',title:'单价',editor:{type:'numberbox', options:{required:true,precision:2,validType:"priceVali",onChange:function(newValue,oldValue){
						   var cos = $('#goodsList').datagrid('getEditor', {index:getRowIndex(this),field:'costPrice'});
							$(cos.target).numberbox('setValue', newValue);  	
						}}},sortable:true,width:100,formatter:function(value){
				  			if(value=="0E-8"){
				  				return 0;
				  			}else{
				  				return value;
				  			}
				  		}},
				  		{field:'type',title:'金额',sortable:true,width:100,formatter:function(value,row,index){
				  			if(row.quentity&&row.unitPrice){
				  				return (row.quentity*row.unitPrice).toFixed(2);
				  			}else{
				  				return 0;
				  			}
				  		}},
				  		{field:'costPrice',title:'成本单价',hidden:true,editor:{type:'numberbox',options:{novalidate:true,precision:2,min:0}},sortable:true,width:100},
						{field:'describe',title:'备注',editor:{type:'textbox',options:{validType:'maxLength[200]'}},sortable:true,width:100},
						{field:'goodsSpecGroupId',title:'属性组ID',hidden:true,width:100},
						{field:'unitGroupId',title:'单位组ID',hidden:true,width:100},
						{field:'_isNew',hidden:true,title:"是否新增",editor:{type:'text'}},
						{field:'action',title:'操作',width:100,formatter:function(value,row,index){
				  			if (row.editing){
				  				btnDisabled();
				  				var s = '<a class="btn-save" title="确认" href="javascript:;" onclick="saverow(this)"></a> ';
								var c = '<a class="btn-back" title="撤销" href="javascript:;" onclick="cancelrow(this)"></a>';
								return s+c;
							} else {
								btnEnabled();
				  				if('${obj.recordStatus}'!=0){
				  					return "";
				  				}
								var e= '<a class="btn-edit" title="编辑" href="javascript:;" onclick="editer(this)"></a>'; 
					  			var d= '<a class="btn-del" title="删除" href="javascript:;" onclick="deleter(this)"></a>';
					  			return e+d;
							}
				  		}}
				      ]],
				      onLoadSuccess:function(){
					    	hideOkAll();
					    },
				      onBeforeEdit:function(index,row){
							row.editing = true;
							updateActions(index);
						},
						onAfterEdit:function(index,row){
							row.editing = false;
							updateActions(index);
							getTotal();
						},
						onCancelEdit:function(index,row){
							if(row.goodsSpecGroupId&&!row.goodsSpecName){
								$("#goodsList").datagrid('beginEdit',index);
								hideOkAll();
							}else{
								row.editing = false;
								updateActions(index);
							}
						}
		});
		//setPager($('#goodsList'));
		//键盘控制
		keyHandler();
	});
	//回车键控制
	enterController("form");	
});

//弹出选择货品页面
$("#addGoods").click(function(){
	var urlStr="";
	if($("#relationId").val()){
		urlStr='${ctx}/goods/getGoods?billType=sctl&billId='+$("#relationId").val();
	}else{
		urlStr='${ctx}/goods/getChilds?billType=sctl';
	}
	if('${obj.recordStatus}'==0){
		goodsChooserOpen=true; 
		 $('#goodsChooser').css("display","inline-block");
		 $('#goodsChooser').window({
				title:'选择货品',
				top:120,  
				collapsible:false,
				minimizable:false,
				maximizable:false,
				resizable:false,
				width:$("#addBox").width()-120,
				height:$("#addBox").height()-80,
				onBeforeOpen:function(){
					$('#goodsTable').datagrid({
						singleSelect:false,
						idField:'fid', 
						url:urlStr,
						pagination:true,
						fitColumns:true, 
						columns:[[  
	                                {field:'checkbox',title:'',checkbox:true},
	                                {field:'fid',title:'fid',hidden:true,width:100},
	            			  		{field:'barCode',title:'货品条码',sortable:true,width:100},
	            					{field:'code',title:'货品编号',sortable:true,width:100},
	            					{field:'name',title:'货品名称',sortable:true,width:100},
	            					{field:'spec',title:'规格',sortable:true,width:100},
	            					{field:'goodsSpecId',title:'属性Id',hidden:true,sortable:true,width:100},
	            					{field:'goodsSpecName',title:'属性组',sortable:true,width:100},
	            					{field:'unitId',title:'单位Id',hidden:true,sortable:true,width:100},
	            			  		{field:'unitName',title:'单位',sortable:true,width:100},
	            			  		{field:'unitScale',title:'换算关系',sortable:true,width:100},
	            			  		{field:'referencePrice',title:'推荐价格',hidden:true,width:100},
	           			  	        {field:'lowestPrice',title:'最低价格',hidden:true,width:100},
	            			  		{field:'describe',title:'备注',sortable:true,width:100},
							      ]],
					   onDblClickRow:function(rowIndex, rowData){
						   var customerId = $("#customerId").val();
						   var supplierId = $("#supplierId").val();
						   var referencePrice = 0;
						   var costPrice = 0;
						   $.post("${ctx}/goods/getOtherPrice",{billType:"sctl",fid:rowData.fid,unitId:rowData.unitId,customerId:customerId,supplierId:supplierId,goodsSpecId:rowData.goodsSpecId},function(data){
							   referencePrice = data.referencePrice;
							   costPrice = data.costPrice;							  
							});
								$("#goodsList").datagrid('appendRow',{
									goodsId:rowData.fid,
									barCode: rowData.barCode,
									goodsCode: rowData.code,
									goodsName: rowData.name,
									goodsSpec: rowData.spec,
									goodsSpecId:"",
									goodsSpecName: "",									
									unitId:rowData.unitId,
									unitName: rowData.unitName,
									scale:rowData.unitScale,
									describe: rowData.describe,
									type:0,
									lowestPrice:rowData.lowestPrice,
									unitPrice:rowData.referencePrice,
									quentity:1,
									goodsSpecGroupId:rowData.goodsSpecId,
									unitGroupId:rowData.unitGroupId,
									_isNew:true
								});
							getTotal();
							var rows=$("#goodsList").datagrid('getRows');
							var index=rows.length-1;
						 	$("#goodsList").datagrid('beginEdit',index); 
						 	devalue(index);
						 	hideOkAll();
							if(!rowData.goodsSpecId){
					    		  var editor=$("#goodsList").datagrid('getEditor',{index:index,field:'goodsSpecName'});
					    		  $(editor.target).combobox("destroy");
					    	}
							$('#goodsChooser').window('close');
							$('#goodsTable').datagrid('unselectAll');
							$('#goodsTable').datagrid('uncheckAll');
					   }
					});
				}
		 });
		 setPager($('#goodsTable'));
	}
});

//打开选取退料员界面
$("#inMemberName").click(function(){
	chooserWindow=$.fool.window({'title':"选择退料员",'width':"780",'heigth':"480",href:'${ctx}/member/window?okCallBack=selectUser&onDblClick=selectUserDBC&singleSelect=true'});
});

//打开选取销售订单界面
$("#relationName").click(function(){
	chooserWindow=$.fool.window({'title':"选择生产退料单",'width':"780",'heigth':"480",href:'${ctx}/salebill/xsdd/window?okCallBack=selectRelation&onDblClick=selectRelationDBC&singleSelect=true&billCode=scll'});
});

//筛选货品属性
$("#search-goodsSpecBtn").click(function(){
	var name=$("#search-goodsSpecName").textbox('getValue');
	var options = {"name":name};
	$('#goodsSpecTable').datagrid('load',options);
});

//筛选货品
$("#search-goodsBtn").click(function(){
	var code=$("#search-goodsCode").textbox('getValue');
	var name=$("#search-goodsName").textbox('getValue');
	var spec=$("#search-goodsSpec").textbox('getValue');
	var options = {"code":code,"name":name,"spec":spec};
	$('#goodsTable').datagrid('load',options);
});

//选取货品后添加到明细列表
$("#ok").click(function(){	
	var nodes=$('#goodsTable').datagrid('getSelections');
	$(nodes).each(function(){
		$("#goodsList").datagrid('appendRow',{
			goodsId:this.fid,
			barCode: this.barCode,
			goodsCode: this.code,
			goodsName: this.name,
			goodsSpec: this.spec,
			goodsSpecId:"",
			goodsSpecName: "",
			inWareHouseId:this.inWareHouseId,
			inWareHouseName:this.inWareHouseName,
			unitId:this.unitId,
			unitName: this.unitName,
			scale:this.unitScale,
			describe: this.describe,
			type:0,
			lowestPrice:this.lowestPrice,
			unitPrice:this.referencePrice,
			quentity:1,
			goodsSpecGroupId:this.goodsSpecId,
			unitGroupId:this.unitGroupId,
			_isNew:true
		});		 
		rows=$("#goodsList").datagrid('getRows');
		index=rows.length-1;
		$("#goodsList").datagrid('beginEdit',index);
		devalue(index);
		hideOkAll();
		if(!this.goodsSpecId){
			  var editor=$("#goodsList").datagrid('getEditor',{index:index,field:'goodsSpecName'});
			  $(editor.target).combobox("destroy");
		}		
	});
	getTotal();	
	/*  $.post("${ctx}/goods/getOtherPrice",{billType:"sctl",fid:rowData.fid,unitId:rowData.unitId,customerId:customerId,supplierId:supplierId,goodsSpecId:rowData.goodsSpecId},function(data){
		   referencePrice = data.referencePrice;
		   costPrice = data.costPrice;	
		
		}); 	 */  
	$('#goodsChooser').window('close');
	$('#goodsTable').datagrid('unselectAll');
	$('#goodsTable').datagrid('uncheckAll');
});

function devalue(index){
	   var warehouse=$('#inWareHouseName').combotree('getValue');
	   var ez = $('#goodsList').datagrid('getEditor', {index:index,field:'inWareHouseId'});
	   $(ez.target).textbox({value:warehouse});
	   var ed = $('#goodsList').datagrid('getEditor', {index:index,field:'inWareHouseName'});
	   $(ed.target).combotree({onLoadSuccess:function(node, data){
		   $(ed.target).combotree('setValue',warehouse);
	   }});
}

//展开、隐藏详细（审核人审核时间.....）
$("#openBtn").click(
		function(e) {
			$(".hideOut,#closeBtn").css("display","inline-block");
			$('#openBtn').css("display","none");
		});
$("#closeBtn").click(
		function(e) {
			$(".hideOut,#closeBtn").css("display","none");
			$('#openBtn').css("display","inline-block");
		});

//保存
$('#save').click(function(e) {
	var _dataPanel = $('#goodsList').datagrid('getPanel');
	var _editing = _dataPanel.find(".datagrid-editable");
	if(_editing.length>0){
		$.fool.alert({msg:'你还有没编辑完成的货品,请先确认！'});
		return false;
	};
	var rows=$('#goodsList').datagrid("getRows");
	if(rows.length<1){
		$.fool.alert({msg:'请至少添加一条商品信息！'});
		return false;
	}
	var details=getGoods();  
	var id=$("#fid").val();
	var updateTime=$("#updateTime").val();
	var inMemberId=$("#inMemberId").val();
	var relationId=$("#relationId").val();
	var deptId=$("#deptName").combobox("getValue");
	var endDate=$("#planEnd").datebox("getValue");
	var voucherCode=$("#voucherCode").val();
	var code=$("#code").val();
	var billDate=$("#billDate").datebox('getValue');
	var describe=$("#describe").val();
	var inWareHouseId=$("#inWareHouseName").combotree('getValue');	
	var planEndStr=endDate.slice(0,4)+endDate.slice(5,7)+endDate.slice(8,10);
	var billdateStr=billDate.slice(0,4)+billDate.slice(5,7)+billDate.slice(8,10);
	$('#form').form('enableValidation'); 
		if($('#form').form('validate')){
			if(planEndStr<billdateStr){
				$.fool.alert({msg:'计划完成日期须设定在单据日期后。',fn:function(){ 
	    		}});
				return false;
			}
			$('#save').attr("disabled","disabled");
			    $.post('${ctx}/warehouse/sctl/save',{details:JSON.stringify(details),fid:id,updateTime:updateTime,inMemberId:inMemberId,relationId:relationId,deptId:deptId,endDate:endDate,voucherCode:voucherCode,code:code,billDate:billDate,describe:describe,inWareHouseId:inWareHouseId,},function(data){
			    	if(data.returnCode =='0'){
			    		$.fool.alert({msg:'保存成功！',fn:function(){ 
			    			$('#addBox').window('close');
			    			$('#save').removeAttr("disabled");
			    			$('#billList').datagrid('reload');
			    		}});
			    	}else{
			    		$.fool.alert({msg:data.message});
			    		$('#save').removeAttr("disabled");
		    		}
			    	return true;
			    });
			}else{
				return false;
				}
});

//复制
$('#copy').click(function(e) {
	var fid=$("#fid").val();
	$('#addBox').window("refresh","${ctx}/warehouse/sctl/edit?id="+fid+"&mark=1");
});

//审核
$('#verify').click(function(e) {
	 $.fool.confirm({title:'确认',msg:'确定要审核通过此单据吗？',fn:function(r){
		 if(r){
			  $.ajax({
					type : 'post',
					url : '${ctx}/warehouse/sctl/passAudit',
					data : {id : $("#fid").val()},
					dataType : 'json',
					success : function(data) { 
						if(data.returnCode == '0'){
							$.fool.alert({msg:'审核成功！',fn:function(){
								$('#addBox').window("refresh");
								$('#billList').datagrid('reload');
							}});
						}else{
							$.fool.alert({msg:data.message,fn:function(){
								$('#billList').datagrid('reload');
							}});
						}
		    		},
		    		error:function(){
		    			$.fool.alert({msg:"系统繁忙，稍后再试!"});
		    		}
				});
		 }
	 }});

});

//打印
$('#print').click(function(e) {
	printBillDetail($("#fid").val(),'sctl');
});

//刷新
$('#refreshForm').click(function(e) {
	$('#addBox').window("refresh");
});

//作废
$('#cancel').click(function(e) {
	 $.fool.confirm({title:'确认',msg:'确定要作废此单据吗？',fn:function(r){
		 if(r){
			  $.ajax({
					type : 'post',
					url : '${ctx}/warehouse/sctl/cancel',
					data : {id : $("#fid").val()},
					dataType : 'json',
					success : function(data) { 
						if(data.returnCode == '0'){
							$.fool.alert({msg:'已作废！',fn:function(){
								$('#billList').datagrid('reload');
								$('#addBox').window("refresh");
							}});
						}else{
							$.fool.alert({msg:data.message,fn:function(){
								$('#billList').datagrid('reload');
								$('#addBox').window("refresh");
							}});
						}
		    		},
		    		error:function(){
		    			$.fool.alert({msg:"系统繁忙，稍后再试!"});
		    		}
				});
		 }
	 }});
});

//表单操作
function deleter(target){
	$("#goodsList").datagrid('deleteRow', getRowIndex(target));
	getTotal(); 
}
function editer(target){
	var index=getRowIndex(target);
	var quentity=$(target).closest('[field="action"]').siblings('[field="quentity"]').children().text();
	var inWareHouseId=$(target).closest('[field="action"]').siblings('[field="inWareHouseId"]').children().text();
	$("#goodsList").datagrid('beginEdit',getRowIndex(target));
	hideOkAll();
	var ed = $('#goodsList').datagrid('getEditor', {index:index,field:'inWareHouseName'});
	 $(ed.target).combotree({
		onLoadSuccess:function(none){
			$($("#goodsList").datagrid('getEditor',{index:index,field:'inWareHouseName'}).target).combotree('setValue',inWareHouseId);
		}
	}); 
	$("#goodsList").datagrid('selectRow',index);
	var row=$("#goodsList").datagrid('getSelected');
	if(!row.goodsSpecGroupId){
		  var editor=$("#goodsList").datagrid('getEditor',{index:index,field:'goodsSpecName'});
		  $(editor.target).combobox("destroy");
	}
	$($("#goodsList").datagrid('getEditor',{index:index,field:'quentity'}).target).numberbox('setValue',quentity);	
	
};

function updateActions(index){
	$('#goodsList').datagrid('updateRow',{
		index: index,
		row:{}
	});
}
function getRowIndex(target){
	var tr = $(target).closest('tr.datagrid-row');
	return parseInt(tr.attr('datagrid-row-index'));
}
function saverow(target){
	var unitPrice=$(target).parents("[field='action']").siblings("[field='unitPrice']").find("input.textbox-value").val();
	if(!unitPrice){
		$('#goodsList').datagrid('selectRow', getRowIndex(target));
		var row=$('#goodsList').datagrid('getSelected');
		unitPrice=row.unitPrice;
	}
	$(target).closest('tr.datagrid-row').form('enableValidation');
	if($(target).closest('tr.datagrid-row').form('validate')){
		var tarIndex=getRowIndex(target);
		var scale=$(target).parents("[field='action']").siblings("[field='scale']").children().text();
		var unitId=$(target).parents("[field='action']").siblings("[field='unitId']").children().text();
		var unitName=$(target).parents("[field='action']").siblings("[field='unitName']").find("input.datagrid-editable-input").combotree('getText');
		var goodsSpecId=$(target).parents("[field='action']").siblings("[field='goodsSpecId']").children().text();
		var inWareHouseId=$(target).parents("[field='action']").siblings("[field='inWareHouseName']").find("input.datagrid-editable-input").combotree('getValue');
		var inWareHouseName=$(target).parents("[field='action']").siblings("[field='inWareHouseName']").find("input.datagrid-editable-input").combotree('getText');
		if(unitPrice==0){
			$.fool.confirm({msg:'单价为0，确定保存吗？！',fn:function(r){
				if(r){
					if($(target).closest('tr.datagrid-row').form('validate')){
						getTableEditor(tarIndex,'_isNew').val('false');
						$('#goodsList').datagrid('endEdit', getRowIndex(target));
						hideOkAll();
						$('#goodsList').datagrid('updateRow',{index:tarIndex,row:{scale:scale,unitId:unitId,unitName:unitName,goodsSpecId:goodsSpecId,inWareHouseId:inWareHouseId,inWareHouseName:inWareHouseName}});
						if(getEditNumber()>0){
							btnDisabled();
						}else{
							btnEnabled();
						}
						if(tarIndex==0){ 
							var rows=$('#goodsList').datagrid('getRows');
							for(var i=1;i<rows.length;i++){
								if(!rows[i].editing){
									updateActions(i);
								}
							}
						}
					}
				}else{
					return false;
				}
			}});
		}else{
			if($(target).closest('tr.datagrid-row').form('validate')){
				getTableEditor(tarIndex,'_isNew').val('false');
				$('#goodsList').datagrid('endEdit', getRowIndex(target));
				hideOkAll();
				$('#goodsList').datagrid('updateRow',{index:tarIndex,row:{scale:scale,unitId:unitId,unitName:unitName,goodsSpecId:goodsSpecId,inWareHouseId:inWareHouseId,inWareHouseName:inWareHouseName}});
				if(getEditNumber()>0){
					btnDisabled();
				}else{
					btnEnabled();
				}
				if(tarIndex==0){ 
					var rows=$('#goodsList').datagrid('getRows');
					for(var i=1;i<rows.length;i++){
						if(!rows[i].editing){
							updateActions(i);
						}
					}
				}
			}
		}
	}else{
		return false;
	}
}
function cancelrow(target){
	var ind = $(target).fool('getRowIndex');
	var _isNew = getTableEditor(ind,'_isNew').val();
	if(_isNew=='true'||_isNew==true){
		$.fool.confirm({msg:'您确定要撤销该记录？',fn:function(r){
			if(r) 
				$("#goodsList").datagrid('deleteRow',ind);
			   hideOkAll(); 
		}});
	}else{
		$(target).closest('tr.datagrid-row').form('enableValidation');
		/* if($(target).parents("[field='action']").siblings("[field='goodsSpecId']").children().text()){ */
			$('#goodsList').datagrid('cancelEdit', getRowIndex(target));
			hideOkAll(); 
		/* }else{
			return false;
		} */
	}
}

//获取表格里面某个编辑器方法
function getTableEditor(index,field){
	return getTableEditorHelp($("#goodsList"),index,field);
}

function getTableEditorHelp(tbId,index,field){
	var $t =$.fool._get$(tbId);
	return $t.fool('getEditor$',{'index':index,'field':field});
}

function getEditNumber(){
	var _dataPanel = $('#goodsList').datagrid('getPanel');
	var _editing = _dataPanel.find(".datagrid-editable");
	return _editing.length;
}

function btnDisabled(){
    $("#save").attr('disabled','disabled');       
	$("#copy").attr('disabled','disabled');
	$("#print").attr('disabled','disabled');
	$("#refreshForm").attr('disabled','disabled');
	$("#cancel").attr('disabled','disabled');
	$("#verify").attr('disabled','disabled');
	$("#save").css('background-color','#D4D0C8');       
	$("#copy").css('background-color','#D4D0C8');
	$("#print").css('background-color','#D4D0C8');
	$("#refreshForm").css('background-color','#D4D0C8');
	$("#cancel").css('background-color','#D4D0C8');
	$("#verify").css('background-color','#D4D0C8');
}

function btnEnabled(){
	$("#save").removeAttr('disabled');       
	$("#copy").removeAttr('disabled');
	$("#print").removeAttr('disabled');
	$("#refreshForm").removeAttr('disabled');
	$("#cancel").removeAttr('disabled');
	$("#verify").removeAttr('disabled','disabled');
	$("#save").css('background-color','#85C0EA');       
	$("#copy").css('background-color','#85C0EA');
	$("#print").css('background-color','#85C0EA');
	$("#refreshForm").css('background-color','#85C0EA');
	$("#cancel").css('background-color','#85C0EA');
	$("#verify").css('background-color','#85C0EA');
}

//计算总金额
function getTotal(){
	var rows=$('#goodsList').datagrid('getRows');
	var total=0;
	for(var i=0;i<rows.length;i++){
		rows[i].type=rows[i].quentity*rows[i].unitPrice;
		total+=rows[i].type;
	}
	$("#totalAmount").val(total);
}

//控件初始化方法
function validateBox(obj,required,onLSFn){
	obj.validatebox({
		required:required,
		missingMessage:'该项不能为空！',
		novalidate:true,
		width:162,
		height:31,
		onLoadSuccess:onLSFn
	});
}
function comboBox(obj,url,required,onLSFn){
	obj.combobox({
		required:required,
		missingMessage:'该项不能为空！',
		novalidate:true,
		url:url,
		width:160,
		height:31,
		editable:false,
		onLoadSuccess:onLSFn
	});
}
function comboTree(obj,url,required,onLSFn,onStFn){
	obj.combotree({
		required:required,
		missingMessage:'该项不能为空！',
		novalidate:true,
		url:url,
		width:160,
		height:31,
		editable:false,
		onLoadSuccess:onLSFn,
		onSelect:onStFn
	});
}
function dateBox(obj,required,valid,onLSFn){
	if(!valid){valid="";};
	obj.datebox({
		required:required,
		missingMessage:'该项不能为空！',
		novalidate:true,
		width:160,
		height:31,
		editable:false,
		validType:valid,
		onLoadSuccess:onLSFn
	});
}
function textBox(obj,prompt){
	obj.textbox({
		'prompt':prompt,
		width:100,
		height:30
	});
}

//点击选取退料员方法
function selectUser(rowData){
	$("#inMemberName").focus();
	$("#inMemberId").val(rowData[0].fid);
	$("#inMemberName").val(rowData[0].username);
	chooserWindow.window('close');
}
function selectUserDBC(rowData){
	$("#inMemberName").focus();
	$("#inMemberId").val(rowData.fid);
	$("#inMemberName").val(rowData.username);
	chooserWindow.window('close');
}

//点击选取销售订单方法
function selectRelation(rowData){
	$("#relationName").focus();
	$("#relationId").val(rowData[0].fid);
	$("#relationName").val(rowData[0].code);
	$("#goodsList").datagrid('loadData',[]);
	chooserWindow.window('close');
}
function selectRelationDBC(rowData){
	$("#relationName").focus();
	$("#relationId").val(rowData.fid);
	$("#relationName").val(rowData.code);
	$("#goodsList").datagrid('loadData',[]);
	chooserWindow.window('close');
}
$(".clearBill").click(function(){
	if($("#relationName").val()){
		$("#relationId").val("");
		$("#relationName").val("");
	}
});
//获取所有明细
function getGoods(){
	return $("#goodsList").datagrid('getRows');
}

$.extend($.fn.validatebox.defaults.rules, {
        planEnd:{
        	validator: function (value, param) {
        		var valueStr=value.slice(0,4)+value.slice(5,7)+value.slice(8,10);
        		var billdate=$("#billDate").datebox("getValue");
        		var billdateStr="";
        		if(billdate){
        			billdateStr=billdate.slice(0,4)+billdate.slice(5,7)+billdate.slice(8,10);
        		}else{
        			billdateStr=0;
        		}
        		return parseInt(valueStr)>=parseInt(billdateStr);
        	},
               message:'计划完成时间不可早于单据日期。'
        },
        priceVali:{
        	validator: function (value, param){	
              	  return value>=0;
        	},
        	message:'单价不能为负数。'
        },  
});


function hideOkAll(){//一键确认按钮是否显示
	var _dataPanel = $('#goodsList').datagrid('getPanel');
	var _editing = _dataPanel.find(".datagrid-editable");
	if(_editing.length>0){
		$("#okAll").show();
	}else{
		$("#okAll").hide();
	}
}


//一键确认
$("#okAll").click(function(){
	var _dataPanel = $('#goodsList').datagrid('getPanel');
	var editingRows=_dataPanel.find(".datagrid-view").find(".datagrid-view2").find(".datagrid-body").find(".datagrid-row-editing");
	var index="";
	for(var i=0;i<editingRows.length;i++){
		$(editingRows[i]).form('enableValidation');
		if($(editingRows[i]).form('validate')){
			index=$(editingRows[i]).attr("datagrid-row-index");
			var scale=$(editingRows[i]).find("[field='action']").siblings("[field='scale']").children().text();
			var unitId=$(editingRows[i]).find("[field='action']").siblings("[field='unitId']").children().text();
			var goodsSpecId=$(editingRows[i]).find("[field='action']").siblings("[field='goodsSpecId']").children().text();
			var inWareHouseId=$(editingRows[i]).find("[field='action']").siblings("[field='inWareHouseName']").find("input.datagrid-editable-input").combotree('getValue');
			var inWareHouseName=$(editingRows[i]).find("[field='action']").siblings("[field='inWareHouseName']").find("input.datagrid-editable-input").combotree('getText');
			getTableEditor(index,'_isNew').val('false');
			$('#goodsList').datagrid('endEdit', index); 
			$('#goodsList').datagrid('updateRow',{index:index,row:{scale:scale,unitId:unitId,goodsSpecId:goodsSpecId,inWareHouseId:inWareHouseId,inWareHouseName:inWareHouseName}});
			hideOkAll();
		}else{
			$.fool.alert({msg:"还有未填完的货品信息，请检查。"});
			return false;
		}
	}
});
 </script>
</body>
</html>