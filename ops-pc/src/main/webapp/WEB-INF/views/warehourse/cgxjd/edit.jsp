<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/common.jsp"%>

<html>
<head>
</head>
<body>
          <div id="goodsSpecChooser" style="display: none;">
            <div id="goodsSpecSearcher">
              <input id="search-goodsSpecName"/> <a id="search-goodsSpecBtn" class="btn-blue btn-s">筛选</a>
            </div>
            <table id="goodsSpecTable"></table>
          </div>   
          <div id="goodsChooser">
            <div id="goodsSearcher">
              <input id="search-goodsCode"/>+<input id="search-goodsName"/>+<input id="search-goodsSpec"/> <a id="search-goodsBtn" class="btn-blue btn-s">筛选</a>
            </div>
            <table id="goodsTable"></table>
            <p style="margin-left:44px"><font><a id="ok" class="btn-blue btn-s">确认</a></font></p> 
          </div>
          <div class="form1" >
              <form id="form">
                <input id="fid" name="fid" type="hidden" value="${code!=null?'':obj.fid}"/>
                <input id="updateTime" name="updateTime" type="hidden" value="${obj.updateTime}"/>
                <input id="customerId" type="hidden" name="customerId" value="${obj.customerId}"/> 
                <input id="inMemberId" name="inMemberId" value="${obj.inMemberId}" type='hidden'/>
                <input id="supplierId" type="hidden" name="supplierId" value="${obj.supplierId}">
                <input id="deptId" type="hidden" name="deptId" value="${obj.deptId}">
				<p><font><em>*</em>单号：</font><input id="code"  class="textBox" ${code==null&&obj.code==null?"":"readonly='readonly'"} value="${code==null?(obj.code==null?'':obj.code):code}" name="code" /></p>
				<p><font><em>*</em>单据日期：</font><input id="billDate" name="billDate" class="textBox" value="${obj.billDate}"/></p>
				<p><font><em>*</em>供应商名称：</font><input id="supplierName" name="supplierName" value="${obj.supplierName}" class="textBox" readonly="readonly"/></p>
				<p><font>供应商编号：</font><input id="supplierCode" name="supplierCode" value="${obj.supplierCode}" class="textBox" readonly="readonly"/></p>
				<p><font>供应商电话：</font><input id="supplierPhone" class="textBox" validType="phone" name="supplierPhone"  value="${obj.supplierPhone}"/></p>
				<p><font><em>*</em>部门：</font><input id="deptName" class="textBox" value="${obj.deptName}"/></p>
				<p><font><em>*</em>询价人：</font><input id="inMemberName" name="inMemberName" value="${obj.inMemberName}" class="textBox"/></p>
				<p style="width:78%;"><font>备注：</font><input id="describe" validType='maxLength[200]' name="describe" class="textBox" style="width:80%;" value="${obj.describe}"/></p>
				<br/>
				<h3 style="display: inline-block;margin-left:44px">&emsp;其他信息：</h3><img id="openBtn" alt="展开" src="${ctx}/resources/images/openNode.png" style="vertical-align: middle;"><img id="closeBtn" alt="展开" src="${ctx}/resources/images/closeNode.png" style="vertical-align: middle;display: none"><br/>
				<p class="hideOut"><font>制单人：</font><input id="creatorName" name="creatorName" class="textBox" readonly="readonly" value="${obj.creatorName}"/></p>
				<p class="hideOut"><font>制单时间：</font><input id="createTime" name="createTime" class="textBox" readonly="readonly" value="${obj.createTime}"/></p>
				<p class="hideOut"><font>审核人：</font><input id="auditorName" name="auditorName" class="textBox" readonly="readonly" value="${obj.auditorName}"/></p>
				<p class="hideOut"><font>审核时间：</font><input id="auditTime" name="auditTime" class="textBox" readonly="readonly" value="${obj.auditTime}"/></p>
				<p class="hideOut"><font>作废人：</font><input id="cancelorName" name="cancelorName" class="textBox" readonly="readonly" value="${obj.cancelorName}"/></p>
				<p class="hideOut"><font>作废时间：</font><input id="cancelTime" name="cancelTime" class="textBox" readonly="readonly" value="${obj.cancelTime}"/></p>
              </form>
          </div>
          <table id="goodsList"></table>
          <div id="toolbar">
          ${(obj.recordStatus==null||obj.recordStatus==0)?'<a href="#" id="addGoods" class="btn-ora-add">添加</a> <a href="#" id="okAll" class="btn-ora-add" onclick="allConfirm();" style="display:none">一键确认</a>':''}
             <!--  <a href="#" class="easyui-linkbutton" id="addGoods" data-options="iconCls:'open',plain:true">添加</a>  -->
          </div>
          <div class="form1" id="btnBox">
            
          </div>
          <div id="pop-win"></div>
<script type="text/javascript">
var chooserWindow="";
var _data="";
//if($("#fid").val()){
	 _data= ${obj.details}
	 _data;
//}
var _id = '${obj.fid}';
var win;
var scaleValue="";
var unitIdValue="";
var goodsSpecIdValue="";
var unitNameValue="";
var edits = new Array();
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
	validateBox($("#code"),true);
	validateBox($("#voucherCode"),true);
	$('#deptName').fool('deptComBoxTree',{'valTarget':'#deptId',editable:false,onLoadSuccess:function(node,data){
		if(_id != ''){
			$('#deptName').combotree("setValue","${obj.deptId}");		 
			$("#deptId").val('${obj.deptId}');
			 _id = '';
		}
	}});
	validateBox($("#outUserName"),true); 
	//validateBox($("#describe"),true); 
	validateBox($("#customerName"),true); 
	validateBox($("#customerCode")); 
	validateBox($("#customerPhone")); 
	dateBox($("#billDate"),true);
	
	validateBox($("#totalAmount"));
	validateBox($("#freeAmount"));
	validateBox($("#creatorName"));
	validateBox($("#createTime"));
	textBox($("#search-goodsCode"),"编号");
	textBox($("#search-goodsName"),"名称");
	textBox($("#search-goodsSpec"),"规格");
	textBox($("#search-goodsSpecName"),"属性名");
	$("#search-goodsCode").textbox({
		inputEvents:$.extend({},$.fn.textbox.defaults.inputEvents,{
			keyup:function(e){
				if(e.keyCode==13){
					goodSearch();
				}
			}
		})
	});
	$("#search-goodsName").textbox({
		inputEvents:$.extend({},$.fn.textbox.defaults.inputEvents,{
			keyup:function(e){
				if(e.keyCode==13){
					goodSearch();
				}
			}
		})
	});
	$("#search-goodsSpec").textbox({
		inputEvents:$.extend({},$.fn.textbox.defaults.inputEvents,{
			keyup:function(e){
				if(e.keyCode==13){
					goodSearch();
				}
			}
		})
	});
	$("#supplierName").click(function(){
		memberChooserOpen = true;
		win = $("#pop-win").fool('window',{'title':"选择",height:480,width:780,
			href:getRootPath()+'/supplier/window?okCallBack=selectSupplier&onDblClick=selectSupplier2&singleSelect=true'});
	}).validatebox({required:true,novalidate:true});
	
		//业务员/采购员
	$("#inMemberName").click(function(){
		memberChooserOpen = true;
			 win = $("#pop-win").fool('window',{'title':"选择",height:480,width:780,
				href:getRootPath()+'/member/window?okCallBack=selectMember&onDblClick=selectMember2&singleSelect=true'});
    }).validatebox({required:true,novalidate:true});
		
	if('${obj.recordStatus}'==null||'${obj.recordStatus}'==''){
	   $("#btnBox").append(' <fool:tagOpt optCode="cgxjAdd"><p><input type="button" id="save" class="btn-blue2 btn-xs" value="保存" /></p></fool:tagOpt>');
	}else if('${obj.recordStatus}'==0){
		$("#btnBox").append('<fool:tagOpt optCode="cgxjAction1"><p><input type="button" id="save" class="btn-blue2 btn-xs" value="保存" /></p></fool:tagOpt> <fool:tagOpt optCode="cgxjAction3"><p><input type="button" id="copy" class="btn-blue2 btn-xs" value="复制" /></p></fool:tagOpt> <p><input type="button" id="print" class="btn-blue2 btn-xs" value="打印" /></p> <p><input type="button" id="refreshForm" class="btn-blue2 btn-xs" value="刷新"/></p> ');
	}else if('${obj.recordStatus}'==1){
		$("#deptName").combotree({hasDownArrow:false});
		$("#inWareHouseName").combotree({hasDownArrow:false});
		$("#billDate").datebox('disable');
		$("#form").find("input").attr('disabled','disabled');
		$("#addGoods").attr('disabled','disabled');
		$("#btnBox").append('<fool:tagOpt optCode="cgxjAction3"><p><input type="button" id="copy" class="btn-blue2 btn-xs" value="复制" /></p></fool:tagOpt> <p><input type="button" id="print" class="btn-blue2 btn-xs" value="打印" /></p> <p><input type="button" id="refreshForm" class="btn-blue2 btn-xs" value="刷新"/></p><fool:tagOpt optCode="cgxjAction5"><p><input type="button" id="cancel" class="btn-blue2 btn-xs" value="作废"/></p></fool:tagOpt>');
	}else if('${obj.recordStatus}'==2){
		$("#deptName").combotree({hasDownArrow:false});
		$("#inWareHouseName").combotree({hasDownArrow:false});
		$("#billDate").datebox('disable');
		$("#form").find("input").attr('disabled','disabled');
		$("#addGoods").attr('disabled','disabled');
		$("#btnBox").append('<fool:tagOpt optCode="cgxjAction3"><p><input type="button" id="copy" class="btn-blue2 btn-xs" value="复制" /></p></fool:tagOpt><p><input type="button" id="print" class="btn-blue2 btn-xs" value="打印" /></p>');
	}
	
	$.get("${ctx}/unitController/getChilds",function(data){
		unitData=data;
		$("#goodsList").datagrid({
			data:_data,
			fitColumns:true,
			toolbar:"#toolbar",
			columns:[[
				  		{field:'goodsId',title:'fid',hidden:true,width:100},
				  		{field:'barCode',title:'货品条码',sortable:true,width:100},
						{field:'goodsCode',title:'货品编号',sortable:true,width:100}, 
						{field:'goodsName',title:'货品名称',sortable:true,width:100},
						{field:'goodsSpec',title:'规格',sortable:true,width:100},
						{field:'goodsSpecId',sortable:true,hidden:true,width:100},
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
					    {field:'unitName',title:'单位',width:90,formatter:function(value){
					  		var unitData="";
					  		$.ajax({
					  			url:"${ctx}/unitController/getLeafUnit",
					  			async:false,
					  		    data:{},
					  		    success:function(data){
					  		    	unitData=data;
					  		    }
					  		});
					  		for(var i=0; i<unitData.length; i++){
					  			if (unitData[i].fid == value) return unitData[i].name;
					  		}
					  		return value;
					  	},editor:{type:'combobox',options:{
					  		valueField:"fid",
							textField:"name",
							required:true,
							readonly:false,
							mode:"remote",
							onBeforeLoad:function(param){
								if(!$(this).combobox('options').url||$(this).combobox('options').url==""){
									var index=$(this).parents("[field='unitName']").parent(".datagrid-row").attr("datagrid-row-index");
									$(this).combobox({
										url:"${ctx}/unitController/getChildsOfMatch?unitGroupId="+$(this).parents("[field='unitName']").siblings("[field='unitGroupId']").children().text(),
										validType:"unit["+index+"]"
												
									});
									param.q="";
								}
							},
							onSelect:function(record){
								var scaleField=$(this).parents("[field='unitName']").next().children();
								$(this).parents("[field='unitName']").prev().children().text(record.fid);
								$.post("${ctx}/unitController/get",{id:record.fid},function(data){scaleField.text(data.scale)});
								$(this).combobox('validate');
								$(this).combobox('textbox').focus();
							}
					  	}},sortable:true,width:100},
						{field:'scale',title:'换算关系',sortable:true,hidden:true,width:100},
						{field:'quentity',title:'数量',editor:{type:'numberbox',options:{required:true,precision:2,min:0}},sortable:true,width:100},
				  		{field:'unitPrice',title:'单价',editor:{type:'numberbox',options:{required:true,precision:2,min:0}},sortable:true,width:100},
				  		{field:'type',title:'金额',sortable:true,width:100,formatter:function(value,row,index){
				  			if(row.quentity&&row.unitPrice){
				  				return (row.quentity*row.unitPrice).toFixed(2);
				  			}else{
				  				return 0;
				  			}
				  		}},
						{field:'describe',title:'备注',editor:"text",sortable:true,width:100},
						{field:'unitGroupId',title:'单位组ID',hidden:true,width:100},
						{field:'goodsSpecGroupId',sortable:true,hidden:true,width:100},
						{field:'_isNew',hidden:true,title:"是否新增",editor:{type:'text'}},
						{field:'action',title:'操作',width:50,formatter:function(value,row,index){
				  			if (row.editing){
				  				btnDisabled();
				  				var s = '<a class="btn-save" title="确认" href="javascript:;" onclick="saverow(this)"></a>';
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
								//$.fool.alert({msg:'必须选取属性。'});
								$("#goodsList").datagrid('beginEdit',index);
							}else{
								row.editing = false;
								updateActions(index);
							}
						}
		});
		//键盘控制
		keyHandler();
	});
});
//回车键控制
enterController("form");

	

$("#addGoods").click(function(){
	if('${obj.recordStatus}'==0){
		goodsChooserOpen=true;
		 $('#goodsChooser').css("display","inline-block");
		 
		 $('#goodsChooser').window({
				title:'选择货品',
				top:100,  
				collapsible:false,
				minimizable:false,
				maximizable:false,
				resizable:false,
				width:1074,
				height:500,
				onBeforeOpen:function(){
					$('#goodsTable').datagrid({
						singleSelect:false,
						idField:'fid', 
						url:'${ctx}/goods/getChilds',
						pagination:true,
						fitColumns:true, 
						columns:[[  
	                            {field:'checkbox',title:'',checkbox:true},
	                            {field:'fid',title:'fid',hidden:true,width:100},
	           			  		{field:'barCode',title:'货品条码',sortable:true,width:100},
	           					{field:'code',title:'货品编号',sortable:true,width:100},
	           					{field:'name',title:'货品名称',sortable:true,width:100},
	           					{field:'spec',title:'规格',sortable:true,width:100},
	           					{field:'goodsSpecGroupId',title:'属性组Id',hidden:true,sortable:true,width:100},
	           					{field:'goodsSpecId',title:'属性Id',hidden:true,sortable:true,width:100},
	           					{field:'goodsSpecName',title:'属性',sortable:true,width:100},
	           					{field:'unitId',title:'单位Id',hidden:true,sortable:true,width:100},
	           			  		{field:'unitName',title:'单位',sortable:true,width:100},
	           			  	    {field:'unitGroupId',title:'单位组Id',hidden:true,sortable:true,width:100},
	           			  		{field:'unitScale',title:'换算关系',sortable:true,hidden:true,width:100},
	           					{field:'describe',title:'备注',sortable:true,width:100},
							      ]],
					   onDblClickRow:function(rowIndex, rowData){
								$("#goodsList").datagrid('appendRow',{
									goodsId:rowData.fid,
									barCode: rowData.barCode,
									goodsCode: rowData.code,
									goodsName: rowData.name,
									goodsSpec: rowData.spec,
									goodsSpecGroupId: rowData.goodsSpecGroupId,
									goodsSpecId: "",
									goodsSpecName: "",
									unitId:rowData.unitId,
									unitName: rowData.unitName,
									unitGroupId:rowData.unitGroupId,
									scale:rowData.unitScale,
									describe: rowData.describe,
									type:0,
									unitPrice:0,
									quentity:1,
									_isNew:true
								});
							getTotal();
							var rows=$("#goodsList").datagrid('getRows');
							var index=rows.length-1;
							$("#goodsList").datagrid('beginEdit',index);
							if(!rowData.goodsSpecId){
					    		  var editor=$("#goodsList").datagrid('getEditor',{index:index,field:'goodsSpecName'});
					    		  $(editor.target).combobox("destroy");
					    	}
							edits.push(index);
							hideOkAll();
							$('#goodsChooser').window('close');
							$('#goodsTable').datagrid('unselectAll');
							$('#goodsTable').datagrid('uncheckAll');
					   }
					});
				},
				onClose:function(){
					$('#goodsTable').datagrid('clearSelections');
					$('#goodsTable').datagrid('clearChecked');
				}
		 });
		 setPager($('#goodsTable'));
	}
});
function goodSearch(){
	var code=$("#search-goodsCode").textbox('getValue');
	var name=$("#search-goodsName").textbox('getValue');
	var spec=$("#search-goodsSpec").textbox('getValue');
	var options = {"code":code,"name":name,"spec":spec};
	$('#goodsTable').datagrid('load',options);
}
$("#search-goodsSpecBtn").click(function(){
	var name=$("#search-goodsSpecName").textbox('getValue');
	var options = {"name":name};
	$('#goodsSpecTable').datagrid('load',options);
});
$("#search-userBtn").click(function(){
	var code=$("#search-userCode").textbox('getValue');
	var name=$("#search-userName").textbox('getValue');
	var phone=$("#search-userPhone").textbox('getValue');
	var options = {"code":code,"name":name,"phone":phone};
	$('#userTable').datagrid('load',options);
});

$("#search-cusBtn").click(function(){
	var code=$("#search-cusCode").textbox('getValue');
	var name=$("#search-cusName").textbox('getValue');
	var phone=$("#search-cusPhone").textbox('getValue');
	var options = {"code":code,"name":name,"phone":phone};
	$('#customerTable').datagrid('load',options);
});

$("#search-goodsBtn").click(function(){
	var code=$("#search-goodsCode").textbox('getValue');
	var name=$("#search-goodsName").textbox('getValue');
	var spec=$("#search-goodsSpec").textbox('getValue');
	var options = {"code":code,"name":name,"spec":spec};
	$('#goodsTable').datagrid('load',options);
});
var goods = new Array();
$("#ok").click(function(){
	var nowLen = $("#goodsList").datagrid('getRows').length;
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
			goodsSpecGroupId: this.goodsSpecGroupId,
			unitId:this.unitId,
			unitName: this.unitName,
			unitGroupId:this.unitGroupId,
			scale:this.unitScale,
			describe: this.describe,
			type:0,
			unitPrice:0,
			quentity:1,
			_isNew:true
		});
	});
	getTotal();
	var rows=$("#goodsList").datagrid('getRows');
	var index="";
	for(var i=nowLen;i<rows.length;i++){
		index=$("#goodsList").datagrid('getRowIndex',rows[i]);
		$("#goodsList").datagrid('beginEdit',index);
		if(!rows[i].goodsSpecGroupId){
			  var editor=$("#goodsList").datagrid('getEditor',{index:index,field:'goodsSpecName'});
			  $(editor.target).combobox("destroy");
		}
		edits.push(index);
	}
	hideOkAll();
	$('#goodsChooser').window('close');
	$('#goodsTable').datagrid('unselectAll');
	$('#goodsTable').datagrid('uncheckAll');
});

$("#openBtn").click(
		function(e) {
			$(".hideOut").css("display","inline-block");
			$('#openBtn').css("display","none");
			$('#closeBtn').css("display","inline-block");
		});
$("#closeBtn").click(
		function(e) {
			$(".hideOut").css("display","none");
			$('#openBtn').css("display","inline-block");
			$('#closeBtn').css("display","none");	
		});
	$('#save').click(function(e) {
		var details=getGoods();
		if(details.length==0){
			$.fool.alert({msg:'货品明细不能为空'});
			return false;
		}
		var jsonuserinfo = $('#form').serializeJson();
		var obj = $.extend(jsonuserinfo,{details:JSON.stringify(details)});
		$('#form').form('enableValidation'); 
			 if($('#form').form('validate')){ 
				    $('#save').attr("disabled","disabled");
				    $.post('${ctx}/initialstock/cgxjd/save',obj,function(data){
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

$('#copy').click(function(e) {
	var fid=$("#fid").val();
	$('#addBox').window("refresh","${ctx}/warehouse/cgxjd/edit?id="+fid+"&mark=1");
});
$('#verify').click(function(e) {
	$.fool.confirm({title:'确认',msg:'确定要审核该记录吗？',fn:function(r){
		 if(r){
			 $.ajax({
					type : 'post',
					url : '${ctx}/purchaseinquiry/cgxjd/passAudit',
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
$('#print').click(function(e) {
	printBillDetail($("#fid").val(),'cgxjd');
});
$('#refreshForm').click(function(e) {
	$('#addBox').window("refresh");
});
$('#cancel').click(function(e) {
	var fid = $("#fid").val();
	$.fool.confirm({title:'确认',msg:'确定要废除该记录吗？',fn:function(r){
		 if(r){
			 $.ajax({
					type : 'post',
					url : '${ctx}/adjustpositions/cgxjd/cancel',
					data : {id : fid},
					dataType : 'json',
					success : function(data) {	
						if(data.returnCode == '0'){
							$.fool.alert({msg:'已作废！',fn:function(){
								$('#billList').datagrid('reload');
								$('#addBox').window("close");
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
function deleter(target){
	$("#goodsList").datagrid('deleteRow', getRowIndex(target));
	getTotal(); 
}
function editer(target){
	var index=getRowIndex(target);
	$("#goodsList").datagrid('beginEdit',getRowIndex(target));
	$("#goodsList").datagrid('unselectAll');
	$("#goodsList").datagrid('selectRow',index);
	var row=$("#goodsList").datagrid('getSelected');
	if(!row.goodsSpecGroupId){
		  var editor=$("#goodsList").datagrid('getEditor',{index:index,field:'goodsSpecName'});
		  $(editor.target).combobox("destroy");
	}
	edits.push(index);
	hideOkAll();
}

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
	var tarIndex=getRowIndex(target);
	$(target).closest('tr.datagrid-row').form('enableValidation');
	if($(target).closest('tr.datagrid-row').form('validate')){
		var scale=$(target).parents("[field='action']").siblings("[field='scale']").children().text();
		var unitId=$(target).parents("[field='action']").siblings("[field='unitId']").children().text();
		var goodsSpecId=$(target).parents("[field='action']").siblings("[field='goodsSpecId']").children().text();
		//更新新建标识
		getTableEditor(tarIndex,'_isNew').val('false');
		$('#goodsList').datagrid('endEdit', getRowIndex(target));
		$('#goodsList').datagrid('updateRow',{index:tarIndex,row:{scale:scale,unitId:unitId,goodsSpecId:goodsSpecId}});	
		if(getEditNumber()>0){
			btnDisabled();
		}else{
			btnEnabled();
		}
		removeEl(tarIndex);
		return true;
	}
	return false;
}
function cancelrow(target){
	var ind = $(target).fool('getRowIndex');
	var _isNew = getTableEditor(ind,'_isNew').val();
	
	if(_isNew=='true'||_isNew==true){
		$.fool.confirm({msg:'您确定要撤销该记录？',fn:function(r){
			if(r){ 
				$("#goodsList").datagrid('deleteRow',ind);
				removeEl(ind);
			}
		}});
	}else{
			$('#goodsList').datagrid('cancelEdit', getRowIndex(target));
			removeEl(ind);
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
function getTotal(){
	var rows=$('#goodsList').datagrid('getRows');
	var total=0;
	for(var i=0;i<rows.length;i++){
		rows[i].type=rows[i].quentity*rows[i].unitPrice;
		total+=rows[i].type;
	}
	$("#totalAmount").val(total);
}

function validateBox(obj,required,onLSFn){
	obj.validatebox({
		required:required,
		missingMessage:'该项不能为空！',
		novalidate:true,
		width:164,
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
		width:164,
		height:31,
		editable:false,
		onLoadSuccess:onLSFn
	});
}

function comboTree(obj,url,required,onLSFn){
	obj.combotree({
		required:required,
		missingMessage:'该项不能为空！',
		novalidate:true,
		url:url,
		width:164,
		height:31,
		editable:false,
		onLoadSuccess:onLSFn
	});
}

function dateBox(obj,required,onLSFn){
	if(_id==''){
		obj.datebox({
			required:required,
			missingMessage:'该项不能为空！',
			novalidate:true,
			width:164,
			height:31,
			editable:false,
			value:' ',
			onLoadSuccess:onLSFn
		});
	}else{
		obj.datebox({
			required:required,
			missingMessage:'该项不能为空！',
			novalidate:true,
			width:164,
			height:31,
			editable:false,
			onLoadSuccess:onLSFn
		});
	}
}

function textBox(obj,prompt){
	obj.textbox({
		'prompt':prompt,
		width:100,
		height:30
	});
}

function getGoods(){
	return $("#goodsList").datagrid('getRows');
}
//详细页。业务员
function selectUser(data){
	var _d = getData(data);
	$("#userId").val(_d.fid);
	$("#userName").val(_d.username);
	$("#userName").validatebox('validate');
	closeWin();
}

//详细页。销售商文本框
function selectCus(data){
	var _d = getData(data);
	$("#customerId").val(_d.fid);
	$("#customerCode").val(_d.code);
	$("#customerName").val(_d.name);
	$("#customerPhone").val(_d.tel);
	
	$("#inMemberId").val(_d.memberId);
	$("#inMemberName").val(_d.memberName);
	$("#deptId").val(_d.deptId);
	$('#deptName').fool('deptComBoxTree',{'valTarget':'#deptId',onLoadSuccess:function(node,data){
		if(_id != ''){
			$('#deptName').combotree("setValue","${obj.deptId}");		 
			$("#deptId").val('${obj.deptId}');
			 _id = '';
		}
	}});
	
	$("#customerName").validatebox('validate');
	win.window('close');
}

//详细页。采购员文本框
function selectMember(rowData){
	$("#inMemberName").focus();
	$("#inMemberId").val(rowData[0].fid);
	$("#inMemberName").val(rowData[0].username);
	win.window('close');
}

//详细页。货品列表 供应商文本框
function selectSupplier(rowData){
	$("#supplierName").focus();
	$("#supplierId").val(rowData[0].fid);
	$("#supplierName").val(rowData[0].name);
	$("#supplierCode").val(rowData[0].code);
	$("#supplierPhone").val(rowData[0].phone);
	win.window('close');
}
//详细页。采购员文本框
function selectMember2(rowData){
	$("#inMemberName").focus();
	$("#inMemberId").val(rowData.fid);
	$("#inMemberName").val(rowData.username);
	win.window('close');
}

//详细页。货品列表 供应商文本框
function selectSupplier2(rowData){
	$("#supplierName").focus();
	$("#supplierId").val(rowData.fid);
	$("#supplierName").val(rowData.name);
	$("#supplierCode").val(rowData.code);
	$("#supplierPhone").val(rowData.phone);
	win.window('close');
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
function getEditNumber(){
	var _dataPanel = $('#goodsList').datagrid('getPanel');
	var _editing = _dataPanel.find(".datagrid-editable");
	return _editing.length;
}
function removeEl(val){
	for(var i =0; i < edits.length;i++){
		if(edits[i]==val){
			var temp = edits[i];
			edits[i] = edits[edits.length-1];
			edits[edits.length-1] = temp;
		}
	}
	edits.pop();
	hideOkAll();
}
function allConfirm(){
	var obj = $(".datagrid-view2 .datagrid-body:eq(1) tr");
	var str = $(obj[0]).attr("id");
	var arrayStr = str.split("-");
	var datas = new Array(); 
	
	for(var i = 0;i<edits.length;i++){
	   datas.push(edits[i]); 
	}
	for(var i=0;i<datas.length;i++){
		var str = "#datagrid-row-"+arrayStr[2]+"-2-"+datas[i]+" td[field='action'] .datagrid-cell";
		if(!saverow(str)){
			   $.fool.alert({msg:"还有未填完的货品信息，请检查。"});
			   break;
		}
	}
	hideOkAll();
}
function hideOkAll(){
	if(edits.length>0){
		$("#okAll").show();
	}else{
		$("#okAll").hide();
	}
}
$.extend($.fn.validatebox.defaults.rules, {
    unit:{//判断有没有选单位
    	validator:function(value,param){
    		var ed=$('#goodsList').datagrid('getEditor', {index:param,field:'unitName'});
    		var text=$(ed.target).combobox("getText");
    		var unitId=$(ed.target).parents("[field='unitName']").siblings("[field='unitId']").children().text();
			var name="";
    		$.ajax({
	  			url:"${ctx}/unitController/get",
	  			async:false,
	  		    data:{id:unitId},
	  		    success:function(data){
	  		    	name=data.name;
	  		    }
	  		});
    		return name==text;
    	},
    	message:'请选择货品单位'
    }
});
 </script>
</body>
</html>