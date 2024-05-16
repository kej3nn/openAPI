<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="egovframework.common.WiseOpenConfig"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>  
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><spring:message code='wiseopen.title'/></title>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/common.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery/jquery-2.2.4.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery/json.min.js"></script>
</head>
<style type="text/css">
@import url(http://fonts.googleapis.com/earlyaccess/notosanskr.css);
*{margin:0;padding:0;font-size:13px;font-family:'Noto Sans KR',sans-serif;}
a,a:hover,a:active,a:visited,a:focus{text-decoration:none;color:#000000;}
.print_pic{width:582px;margin:30px auto 0 auto;overflow:hidden;min-height:780px;}
.print_pic table{width:280px;border-collapse:collapse;padding:0;margin:2px 5px;table-layout:fixed;font-family:'Noto Sans KR',sans-serif;float:left;}
.print_pic th{border:1px solid #000000;border-top:3px solid #000000;background:#f6f6f6;font-size:12px;padding:3px 0;font-family:'Noto Sans KR',sans-serif;height:34px;line-height:1.2;}
.print_pic td{border:1px solid #000000;padding:0 0 0 8px;font-family:'Noto Sans KR',sans-serif;/* text-align: center; */}
.print_pic td img{width:100%;height:100%;box-sizing:border-box;display:block;}
.table_th td{border-top:0 none !important;border-bottom:0 none !important;}
.table_td .tdh{padding:0;height:100px;}

.btn_print{text-align:center;margin:0 0 20px 0;}
button#print{padding:5px 30px;border:1px solid #000000;background:#000000;color:#ffffff;cursor:pointer;
	border-radius:4px;
	-moz-border-radius:4px;
	-o-border-radius:4px;
}
.page{padding:10px 0;}
.justify-content-center{-webkit-box-pack:center !important;-ms-flex-pack:center !important;justify-content:center !important;}
.pagination{display: -webkit-box;display:-ms-flexbox;display:flex;padding-left:0;list-style:none;border-radius:0.25rem;}
.page-link {position:relative;display:block;padding:0.5rem 0.75rem;margin-left:-1px;line-height:1.25;color:#000000;background-color:#fff;border:1px solid #dee2e6;}
.page-link:hover{color:#0056b3;text-decoration:none;background-color:#e9ecef;border-color:#dee2e6;}
.page-link:focus{z-index:2;outline:0;box-shadow:0 0 0 0.2rem rgba(0, 123, 255, 0.25);}
.page-link:not(:disabled):not(.disabled){cursor:pointer;}
.page-item:first-child .page-link{margin-left:0;border-top-left-radius:0.25rem;border-bottom-left-radius:0.25rem;}
.page-item:last-child .page-link{border-top-right-radius:0.25rem;border-bottom-right-radius:0.25rem;}
.page-item.active .page-link{z-index:1;color:#fff;background-color:#007bff;border-color:#007bff;}
.page-item.disabled .page-link{color:#6c757d;pointer-events:none;cursor:auto;background-color:#fff;border-color:#dee2e6;}
.pagination-lg .page-link {padding:0.75rem 1.5rem;font-size:1.25rem;line-height:1.5;}
.pagination-lg .page-item:first-child .page-link{border-top-left-radius:0.3rem;border-bottom-left-radius:0.3rem;}
.pagination-lg .page-item:last-child .page-link{border-top-right-radius:0.3rem;border-bottom-right-radius:0.3rem;}
.pagination-sm .page-link{padding:0.25rem 0.5rem;font-size:0.875rem;line-height:1.5;}
.pagination-sm .page-item:first-child .page-link{border-top-left-radius:0.2rem;border-bottom-left-radius:0.2rem;}
.pagination-sm .page-item:last-child .page-link{border-top-right-radius:0.2rem;border-bottom-right-radius:0.2rem;}
</style>             
<script language="javascript">                
var popObj = "form[name=printForm]";
 
$(document).ready(function()    {
	$(".page-link").bind("click", function(event) {
		// 페이지 설정
		$("input[name=page]").val($(this).text());
		
		// 페이징 처리(현재 페이지 다시 호출)
		var pop_title = "usrPrintPop" ;
        window.open("", pop_title) ;
        var frmData = document.printForm ;
        frmData.target = pop_title ;
        frmData.action = "/admin/basicinf/popup/usrPrintPop.do";
        frmData.submit() ;
	});
	
	$("#print").bind("click", function(event) {
		window.print();
	});
	
});
    
</script>                
<body>
<form id="printForm" name="printForm"  method="post" action="#">
	<!-- 부모창에서 선택한 전체 직원 리스트 -->
	<c:forEach items="${allUsrList}" var="allUsr" varStatus="status">
		<input type="hidden" id="printRegno" name="printRegno" value="${allUsr}"/>
	</c:forEach>
	<input type="hidden" id="page" name="page" value="${param.page}"/>
	
	<div class="print_pic">
	<c:forEach items="${usrList}" var="usr" varStatus="status">
	    <table>
	    <colgroup>
	    <col style="width:100px;">
	    <col style="width:180px;">
	    </colgroup>
	      <tr class="table_th">
	      	<c:choose>
		      	<c:when test="${usr.job eq '' }">
		      		<th colspan="2">${usr.position } (${usr.curDeptDt })</th>
		      	</c:when>
		      	<c:otherwise>
		    		<th colspan="2">${usr.job } (${usr.curDeptDt })</th>  	
		      	</c:otherwise>
	      	</c:choose>
	      </tr>
	      <tr class="table_td">
	        <%-- <td rowspan="2" class="tdh"><img src="http://105.6.50.136:6100/sgpis/photo/${usr.regno }.jpg"></td> --%>
	        <td rowspan="2" class="tdh"><img src="sample.jpg"></td>
	        <td>${usr.rank }<br>(${usr.curJbPstnDt })</td>
	      </tr>
	      <tr>
	        <td>${usr.userName }<br>(${usr.birthDt })</td>
	      </tr>
	    </table>
	</c:forEach>	
	</div>
	
	<div class="btn_print">
		<button type="button" id="print">인쇄</button>
	</div>
	
	<div class="page">
	  <ul class="pagination justify-content-center">
	    <c:forEach varStatus="status" begin="1" end="${endPage }" step="1">
		    <c:choose>
		    	<c:when test="${param.page eq status.count }">
		    		<li class="page-item active">
		    	</c:when>
		    	<c:otherwise>
		    		<li class="page-item">
		    	</c:otherwise>	
		    </c:choose>
		    	<a class="page-link " href="#">${status.count }</a>
		    </li>
	    </c:forEach>
	  </ul>
	</div>
</form>
</body>
</html>                             