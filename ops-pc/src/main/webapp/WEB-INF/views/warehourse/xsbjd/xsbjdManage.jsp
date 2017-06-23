<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/common.jsp"%>
<c:set var="billCode" value="xsbjd" scope="page"></c:set>
<c:set var="billCodeName" value="销售报价单" scope="page"></c:set>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>${billCodeName}</title>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<link rel="stylesheet" href="${ctx}/resources/css/warehouseManage.css" />
<link rel="stylesheet" href="${ctx}/resources/css/warehousebill.css" />
<style>
  .open{
	background:url(/ops/resources/images/open.png) no-repeat;
	padding-left:0px;
	width:40px;
	background-position:0px -1px;
}

#goodsChooser{
  display: none;
  text-align: center;
}

#btnBox{
  text-align: center;
}

.form p.hideOut,.form1 p.hideOut{
    display: none;
  }
  
#userChooser,#customerChooser,#goodsChooser{
  display: none;

}

#userSearcher,#cusSearcher,#goodsSearcher{
  text-align: left;
  margin:10px;
}
#search-form{
display: inline-block; width: 98%;
}
#search-form span{
  margin-right: 5px;
  margin-bottom: 10px
}
#search-form a{
  margin-right: 5px;
  margin-bottom: 10px
}
.form,.form1{padding:5px 0px;}
.form1 p{margin:5px 0px}
.form p font,.form1 p font{width:115px;}
 .nav{margin-bottom: 10px;} 
#Inquiry{margin-left: 5px;}
#grabble{ float: right;}
#bolting{ width: 160px;height: 27px; position:relative; border: 1px solid #ccc; background: #fff; margin-right: 20px;}
.button_a{display:block; width:25px; height: 25px;background:#76D5FC; -moz-border-radius: 3px;/* Gecko browsers */-webkit-border-radius: 3px;/* Webkit browsers */
border-radius:3px;/* W3C syntax */float: right; right:23px; top:63px; position: absolute;}
.button_span{  width:0; height:0; border-left:8px solid transparent; border-right:8px solid transparent;border-top:8px solid #fff;top:10px; position: absolute;right:4px;}
.input_div{display: none;background:#F5F5F5; padding: 10px 0px 5px 0px; border: 1px solid #D5DBEA;position: absolute;right: 23px; top:93px;z-index: 1;}
.input_div p{ font-size: 12px; color:#747474;vertical-align: middle;text-align: right;  margin: 0 20px 0 10px;width:235px;}
.button_clear{ border-top: 1px solid #D5DBEA;padding-top:8px; text-align: right;}
.roed{
   -moz-transform:scaleY(-1);
   -webkit-transform:scaleY(-1);
   -o-transform:scaleY(-1);
   transform:scaleY(-1);
   filter:FlipV();
} 
#bill p.hideOut{
  display: none ;
}
</style>
</head>
<body>
	<div class="titleCustom">
                <div class="squareIcon">
                   <span class='Icon'></span>
                   <div class="trian"></div>
                   <h1>销售报价单</h1>
                </div>             
             </div>
	<div id="addBox"></div>
	<div style="margin:10px 0px 0px 0px;">	
	   <div class="nav">
	       <a href="javascript:;" id="addNew" class="btn-ora-add"  style="vertical-align: top;">新增</a>
			<input name="codeOrVoucherCode" id="search-code" _class="textbox"  data-options="{prompt:'单号',width:160,height:30}"/><a href="javascript:;" class="Inquiry btn-blue btn-s" style="margin-left: 5px">查询</a>
			<div id="grabble"><input type="text" name="inMemberId" id="bolting" value="请选择筛选条件"  readonly="readonly"/><a href="javascript:;" class="button_a"><span class="button_span"></span></a></div>
	   </div>			
			<div class="input_div">
			<form action="" id="search-form">
			<p>开始日期:<input name="startDay" id="startDay" data-options="{width:100,height:30,editable:false}"/></p>
			<p>结束日期:<input name="endDay" id="endDay" data-options="{width:100,height:30,editable:false}"/></p>
			<!-- <p><input name="recordStatus" _class="recordStatus"/></p> -->
			<p style="margin: 5px 20px 5px 0px;">状态：<input type=checkbox value='0' name="recordStatus">未审核
	<input type=checkbox value='1' name="recordStatus">已审核<input type=checkbox value='2' name="recordStatus">已作废</p>
			<p>客户:<input id="myCustomerName" name="customerName" data-options="{editable:false,width:160,height:32}"/><input id="myCustomerId" name="customerId" type="hidden"/></p>
			<p>业务员:<input id="myInMemberName" name="inMemberName" class="textBox" data-options="{editable:false,width:160,height:32}"/><input type="hidden" name="inMemberId" id="myInMemberId" /></p>			
			<p>货品:<input id="myGoodName" name="myGoodName" class="textBox" data-options="{novalidate:true,width:160,height:30,prompt:''}"/>
			<input id="myGoodsId" name="goodsId" type="hidden"/></p>
			<div class="button_clear">
			<a href="javascript:;" class="btn-blue btn-s" id="search-form-btn" style="vertical-align:middle;" onclick="refreshData()">查询</a>
			<a href="javascript:;" class="btn-blue btn-s" style="vertical-align:middle;" onclick="cleanBoxInput('#search-form')">清空</a> 
			<a href="javascript:;" id="clear-btndiv" class="btn-blue btn-s" style="vertical-align:middle;">关闭</a>
			</div>			
		</form>
		</div>
	</div>
	
	<table id="dataTable">
	</table>
	<div id="pager"></div>
<div id="my-window"></div>
</body>
</html>
<%@ include file="/WEB-INF/views/common/js.jsp"%>
<script type="text/javascript" src="${ctx}/resources/js/warehousebill.js?v=${js_v}"></script>
<script type="text/javascript" src="${ctx}/resources/js/warehouseEdit.js?v=${js_v}"></script>
<script type="text/javascript" src="${ctx}/resources/js/comm.js?v=${js_v}"></script>
<script type="text/javascript" src="${ctx}/resources/js/lodop/LodopFuncs.js?v=${js_v}"></script>
<script type="text/javascript">
initManage('${billCode}','${billCodeName}');
$("#search-code").textbox({
	prompt:'单号',
	width:160,
	height:32
});
enterSearch("Inquiry");//回车搜索
$('#dataTable').jqGrid({
	datatype:function(postdata){
		$.ajax({
			url:'${ctx}/warehouse/xsbjd/list',
			data:postdata,
	        dataType:"json",
	        complete: function(data,stat){
	        	if(stat=="success") {
	        		data.responseJSON.totalpages=Math.ceil(data.responseJSON.total/postdata.rows);
	        		$("#dataTable")[0].addJSONData(data.responseJSON);
	        	}
	        }
		});
	},
	forceFit:true,
	pager:'#pager',
	rowList:[ 10, 20, 30 ],
	viewrecords:true,
	rowNum:10,
	jsonReader:{
		records:"total",
		total: "totalpages",  
	}, 
	autowidth:true,//自动填满宽度
	height:$(window).outerHeight()-200+"px",
	colModel:[
	  		{name:'fid',label:'fid',align:"center",hidden:true,width:100},
	  		{name:'code',label:'单号',align:"center",sortable:true,width:150,formatter:codeLinkNew},
        	{name:'billDate',align:"center",label:'单据日期',width:40,sortable:true,formatter:dateFormatAction},
        	{name:'customerName',align:"center",label:'客户',sortable:true,width:100},
	  		{name:'inMemberName',align:"center",label:'业务员',sortable:true,width:100}, 
	  		{name:'creatorName',align:"center",label:'制单人',sortable:true,width:100},
	  		{name:'recordStatus',align:"center",label:'状态',width:40,sortable:true,formatter:recordStatusAction},
	  		{name:'action',align:"center",label:'操作',formatter:actionFormatNew}
	      ],
	      gridComplete:function(){
	    	  	warehouseAll();
	      }
}).navGrid('#pager',{add:false,del:false,edit:false,search:false,view:false});
if("${param.billId}"){
	viewRowNew("${param.billId}");
}
</script>
