<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="egovframework.common.WiseOpenConfig"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><spring:message code="labal.dataSetManagement"/>ㅣ<spring:message code='wiseopen.title'/></title>                    
<c:import  url="/WEB-INF/jsp/inc/headinclude.jsp"/>
<style type="text/css">
body{background:none;} /* 임시로 해놓은 것임 */
</style>                                               
<script type="text/javascript">
var tabContentClass= "content";

function setButton(){
	var formObj = $("form[name=openDsSamplePop]");                  
	$("a[name=a_close]").click(function(){	window.close();	});
	$("#a_kr").click(function(e) { 
		formObj.find("input[name=viewLang]").val("");
		doAction("lang");
		 return false;                             
	 }); 
	$("#a_en").click(function(e) { 
		formObj.find("input[name=viewLang]").val("E");
		doAction("lang");
		 return false;                             
	 });   
	
	if( $("input[name=fsYn]").val() == 'Y' ){  //이메일 수신동의 
		$("input[name=fsYn]").prop("checked",true);
	}
}

$(document).ready(function()    {       
	setButton();
});   


/*Sheet 각종 처리*/                  
function doAction(sAction)                                  
{
	var classObj = $("."+tabContentClass); //tab으로 인하여 form이 다건임
	var actObj = setTabForm(classObj); // 0: form data, 1: form 객체
	var formObj = $("form[name=openDsSamplePop]");   
	switch(sAction)
	{          
		case "lang":
			formObj.attr("action","<c:url value='/admin/openinf/opends/popup/opends_samplePop.do'/>").submit();
			break;
			
	}
}


</script>
</head>  
<body onload="">
<div class="wrap-popup">
	<!-- 내용 -->
	<div class="container">
		<!-- 상단 타이틀 -->
		<div class="title">
			<c:choose>
				<c:when test="${viewLang eq 'E'}">
					<h2>Dataset Sample</h2>
				</c:when>
				<c:otherwise>         
					<h2>데이터셋 정보</h2>
				</c:otherwise>
			</c:choose>
		</div>
		<!-- 탭 -->
			<ul class="tab-popup">
<%--  				<c:choose> --%>
<%-- 					<c:when test="${viewLang eq 'E'}"> --%>
<!-- 						<li class="first"><a href="#" id="a_kr">KOR VIEW</a></li> -->
<!-- 						<li class="on"><a href="#" id="a_en">ENG VIEW</a></li> -->
<%-- 					</c:when> --%>
<%-- 					<c:otherwise>          --%>
<!-- 						<li class="first on"><a href="#" id="a_kr">한글보기</a></li> -->
<!-- 						<li><a href="#" id="a_en">영문보기</a></li> -->
<%-- 					</c:otherwise> --%>
<%-- 				</c:choose> --%>
			</ul>
			<!-- 탭 내용 -->
			<div class="content-popup">
			<form name="openDsSamplePop"  method="post" action="#">
			<input type="hidden" name="viewLang" value=""/> 
			<c:forEach var="result" items="${result}" varStatus="status">
			<table class="list01" style="position:relative;">
					<caption>공공데이터목록리스트</caption>
					<colgroup>
						<col width="150"/>
						<col width=""/>
					</colgroup>
					<tr>
					<c:choose>
						<c:when test="${viewLang eq 'E'}">
							<th>DataSet</th>
						</c:when>
						<c:otherwise>         
							<th>데이터셋 ID</th>
						</c:otherwise>
					</c:choose>
						<td>
							<input type="hidden" name="dsId" value="${result.dsId }"/>							
							${result.ownTabId }
						</td>
					</tr>
					
					<tr>
					<c:choose>
						<c:when test="${viewLang eq 'E'}">
							<th>데이터셋명</th>
						</c:when>
						<c:otherwise>         
							<th>데이터셋명</th>
						</c:otherwise>
					</c:choose>
						<td>
						${result.dsNm}
						</td>
					</tr>
					<%-- 
					<tr>
					<c:choose>
						<c:when test="${viewLang eq 'E'}">
							<th>데이터셋구분</th>
						</c:when>
						<c:otherwise>         
							<th>데이터셋구분</th>
						</c:otherwise>
					</c:choose>
						<td>
						<c:forEach var="code" items="${codeMap.dsCd}" varStatus="status">
							<c:if test="${code.ditcCd eq result.dsCd}">
								${code.ditcNm}
							</c:if>							  
						</c:forEach>
						</td>
					</tr>
					
					<tr>
					<c:choose>
						<c:when test="${viewLang eq 'E'}">
							<th>보유데이터명</th>
						</c:when>
						<c:otherwise>         
							<th>보유데이터명</th>
						</c:otherwise>
					</c:choose>
						<td>
						${result.dtNm}
						</td>
					</tr>
					
					<tr>
					<c:choose>
						<c:when test="${viewLang eq 'E'}">
							<th>Comment</th>
						</c:when>
						<c:otherwise>         
							<th>주석</th>
						</c:otherwise>
					</c:choose>
						<td>
							${result.dsExp }						
						</td>
					</tr>
					
					<tr>
						<c:choose>
							<c:when test="${viewLang eq 'E'}">
								<th>재정 전용 검색</th>
							</c:when>
							<c:otherwise>         
								<th>재정 전용 검색</th>
							</c:otherwise>
						</c:choose>
						<td>
						<input type="checkbox" value="${result.fsYn}" name="fsYn"  disabled="disabled" />
						<c:forEach var="code" items="${codeMap.fsCd}" varStatus="status">
							<c:if test="${code.ditcCd eq result.fsCd}">
								${code.ditcNm}
							</c:if>							  
						</c:forEach>
						</td>
					</tr>
					 --%>
					<tr>
						<c:choose>
							<c:when test="${viewLang eq 'E'}">
								<th>데이터셋 항목</th>
							</c:when>
							<c:otherwise>         
								<th>데이터셋 항목</th>
							</c:otherwise>
						</c:choose>
						<td>
							${result.colNm }	
						</td>
					</tr>
<!-- 					<tr> -->
<!-- 						<th>연계정보</th> -->
<!-- 						<td></td> -->
<!-- 					</tr> -->
<!-- 					<tr> -->
<!-- 						<th>연계방법</th> -->
<!-- 						<td></td> -->
<!-- 					</tr> -->
<!-- 					<tr> -->
<!-- 						<th>적재주기</th> -->
<!-- 						<td></td> -->
<!-- 					</tr> -->
				</table>
				</c:forEach>
				</form>
			</div>
			<div class="buttons">            
				<c:choose>
					<c:when test="${viewLang eq 'E'}">
						<a href='#' class='btn02' name='a_close'>close</a>       
					</c:when>
					<c:otherwise>         
						<a href='#' class='btn02' name='a_close'>닫기</a>       
					</c:otherwise>        
				</c:choose>         
			</div>
	</div>
</div>
</body>
</html>