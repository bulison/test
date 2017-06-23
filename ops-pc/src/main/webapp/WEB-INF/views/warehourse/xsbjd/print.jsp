<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/common.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>单据打印模板</title>
</head>
<body>
<div id="warp-div">

<table cellpadding="0" cellspacing="0" width="100%">
<thead>
<tr>
<td id="org-name-area" colspan="100" style="position: relative;">
<div id="theBillStat" style="font-size: 18px;position: absolute;right: 0px;">未审核</div>
<h1>${orgName}</h1>
<h2>
<c:choose>
<c:when test="${param.billCode eq 'qckc'}">期初库存</c:when>
<c:when test="${param.billCode eq 'cgdd'}">采购订单</c:when>
<c:when test="${param.billCode eq 'cgrk'}">采购入库</c:when>
<c:when test="${param.billCode eq 'cgth'}">采购退货</c:when>
<c:when test="${param.billCode eq 'cgxjd'}">采购询价单</c:when>
<c:when test="${param.billCode eq 'pdd'}">盘点单</c:when>
<c:when test="${param.billCode eq 'dcd'}">调仓单</c:when>
<c:when test="${param.billCode eq 'bsd'}">报损单</c:when>
<c:when test="${param.billCode eq 'scll'}">生产领料（原材料）</c:when>
<c:when test="${param.billCode eq 'cprk'}">成品入库</c:when>
<c:when test="${param.billCode eq 'xsdd'}">销售订单</c:when>
<c:when test="${param.billCode eq 'xsch'}">销售出货</c:when>
<c:when test="${param.billCode eq 'xsth'}">销售退货</c:when>
<c:when test="${param.billCode eq 'xsbjd'}">销售报价单</c:when>
<c:when test="${param.billCode eq 'skd'}">收款单</c:when>
<c:when test="${param.billCode eq 'fkd'}">付款单</c:when>
<c:when test="${param.billCode eq 'fyd'}">费用单</c:when>
</c:choose>
</h2>
</td></tr>
<tr><td colspan="100"><table id="text-area"></table></td></tr>
<!-- <tr><td colspan="100">&nbsp;</td></tr> -->
<tr id="table-th"></tr>
</thead>
<tbody id="table-tb"></tbody>
<tfoot id="table-tfoot">
<tr><td colspan="100" style="padding: 0px;"><table id="table-sum" cellpadding="0" cellspacing="0" width="100%"></table></td></tr>
<tr><td colspan="100">&nbsp;</td></tr>
<tr>
<td>制单人</td><td  id="zdr"></td>
<td>审核人</td><td id="shr"></td>
<td>签名</td><td id="qm"></td>
</tr>
<tr><td colspan="100">&nbsp;</td></tr>
<tr><td colspan="100" style="padding: 0px;margin: 0px;"><span tdata="PageNO">第#页</span>
&nbsp;&nbsp;/&nbsp;&nbsp;
<span tdata="PageCount">共#页</span></td></tr>
</tfoot>
</table>

<style>
#warp-div{
	position: relative;
}
#theBillStat1{
	position: absolute;
	top: 5px;
	right: 5px;
	font-size: 18px;
}
#warp-div table{
	width: 100%;
	font-size: 16px;
}
#warp-div td,#table-th th,#table-tb td,#table-tfoot td,#table-sum td{
	padding: 3px;
	text-align: center;
}
#table-th th{
	border: 1px solid #000000;
	border-right: none;
	font-size: 16px;
}
#table-th th.last-th,#table-tb td.last-th{
	border-right:1px solid #000000;
}
#table-tb td{
	border: 1px solid #000000;
	border-right: none;
	border-top: none;
	font-size: 16px;	
}
#org-name-area h1{
	text-align: center;
	font-size: 24px;
	padding: 0px;
	margin: 0px;
}
#org-name-area h2{
	text-align: center;
	font-size: 20px;
	font-weight: normal;
	padding: 0px;
	margin: 0px;
}
#text-area td{
	font-size: 16px;
}
#text-area td.title{
	width:100px; 
}
#text-area td.val{
	width:180px; 
}
#table-tfoot{
	font-size: 16px;
}
#table-sum{
	border-left: 1px solid #000000;
	border-right: 1px solid #000000;
}
#table-sum td{	
	border-bottom: 1px solid #000000;
	text-align: left;
}
</style>

<script type="text/javascript">
var vals = ${empty data?"''":data};
if("undefined" == typeof texts||"undefined" == typeof thead||"undefined" == typeof vals){
	$.fool.alert({msg:'必要参数不存在'});
}else{
	var _str = "";
	//文本区域
	_str = "<tr>";
	for (var i = 0; i < texts.length; i++) {
		if((i!=0&&i%3==0)||texts[i].br)_str+="</tr><tr>";
		_str+="<td class='title'>"+texts[i].title+"</td><td class='val'>"+vals[texts[i].key]+"</td>";	
	}
	$("#text-area").html(_str+"</tr>");
	
	//表格区域
	_str = "";
	var _tlen = thead.length;
	var _width = 100/_tlen;
	var _headKey = {};
	//表头
	for(var i=0;i<thead.length;i++){
		if(i+1==_tlen){
			_str += "<th width='"+_width+"%' class='last-th'>"+thead[i].title+"</th>";
		}else
			_str += "<th width='"+_width+"%'>"+thead[i].title+"</th>";
		_headKey[thead[i].key] = (i+1); 
	}
	$("#table-th").html(_str);
	
	//表体
	var _dt = vals.details;
	if(_dt){
		_str = "",_align="center";
		_dt = (new Function("return "+_dt))();
		for(var i=0;i<_dt.length;i++){
			_str += "<tr>";
			for(var j=0;j<thead.length;j++){
				_align = thead[j].textAlign == undefined ? _align : thead[j].textAlign;
				if(j+1==_tlen)
					_str += "<td width='"+_width+"%' style='text-align:"+_align+"' class='last-th'>"+_dt[i][thead[j].key]+"</td>";
				else
					_str += "<td width='"+_width+"%' style='text-align:"+_align+"'>"+_dt[i][thead[j].key]+"</td>";
				_align="center";
			}
			_str += "</tr>";
		}
		
		/* for(var i=0;i<7;i++){
			_str+=_str;
		} */ 
		
		$("#table-tb").html(_str);
		
		_str = "";
		if("undefined" != typeof tfoot){
			_str = "<tr>";
			var _ind;
			for(var i=0;i<tfoot.length;i++){
				_ind = _headKey[tfoot[i].key];
				if(i!=0&&i%3==0)_str+="</tr><tr>";
				if(tfoot[i].dtype==0){//当页统计
					_str += "<td tdata='SubCount' tindex='"+_ind+"'>"+tfoot[i].text+"</td>";
				}else if(tfoot[i].dtype==1){//统计全部
					_str += "<td tdata='AllCount' tindex='"+_ind+"'>"+tfoot[i].text+"</td>";
				}else if(tfoot[i].dtype==2){//当前页金额
					_str += "<td tdata='SubSum' tindex='"+_ind+"' format='0.00'>"+tfoot[i].text+"</td>";
				}else if(tfoot[i].dtype==3){//当前页金额大写
					_str += "<td tdata='SubSum' tindex='"+_ind+"' format='UpperMoney'>"+tfoot[i].text+"</td>";
				}else if(tfoot[i].dtype==4){//所有记录总金额
					_str += "<td tdata='AllSum' tindex='"+_ind+"' format='0.00'>"+tfoot[i].text+"</td>";
				}else if(tfoot[i].dtype==5){//所有记录总金额大写
					_str += "<td tdata='AllSum' tindex='"+_ind+"' format='UpperMoney'>"+tfoot[i].text+"</td>";
				}else{
					_str += "<td>&nbsp;</td>";
				}
			}
		}
		$("#table-sum").html(_str+"</tr>");
		
		$("#zdr").html(vals.creatorName);
		$("#shr").html(vals.auditorName);
		$("#theBillStat").html(vals.recordStatus==0?'未审核':(vals.recordStatus==2?'已作废':''));
	}
}
</script>
</div>
</body>
</html>