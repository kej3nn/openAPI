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

<title><spring:message code='wiseopen.title'/></title>
<c:import  url="/WEB-INF/jsp/inc/headinclude.jsp"/>
</head>
<style type="text/css">
</style>   
<script language="javascript"> 
//<![CDATA[
$(document).ready(function(){
	setButton();
});       
           
           
function setButton(){ //버튼 클릭시 

	$("a[name=qnaLink]").click(function(e) {
		location.href = "<c:url value='/admin/bbs/bbsListPage.do?bbsCd=QNA01'/>"; //Q&A 이동                                       
		return false;                  
	});
	
	$("a[name=galleryLink]").click(function(e) {
		location.href = "<c:url value='/admin/bbs/bbsListPage.do?bbsCd=GALLERY'/>"; //활용사례 이동.                                         
		return false;                  
	});
	
	 

}           
           
           
//]]> 
</script>         
<body>
	<div class="wrap">
		
		<!-- 상단 -->
		<c:import  url="/admin/admintop.do"/>
		<!--  -->
	</div>				
	
	<div class="wrap" style="margin:0;height:800px;  background:#ffffff no-repeat center 0;">
	
		<!-- 내용 -->
		<div class="container" style="margin:0 30px;">
			
			<!-- 상단 타이틀 -->
			<div class="title">
<!-- 				<h2>관리자 홈페이지</h2> -->
<!-- 				<p>홈</p> -->
			</div>
			
			<div class="admin-home">
				<p style="padding-top: 400px;">
				정보공개 관리시스템은 국회가 보유한 다양한 데이터를 <br/>국민에게 빠르고 쉽게 공개할 수 있도록 지원하는 시스템입니다.
				</p>
				<%-- 
				<c:if test="${AccCd == '1'}">
				<div class="admin-info">
					<strong>업무처리정보</strong>
					<ul>
						<li><a href="#" name ="qnaLink" >Q&amp;A 답변 요청 (${QnA}건)</a></li>
						<li><a href="#" name ="galleryLink">활용사레 등록 요청 (${GALLERY}건)</a></li>
					</ul>
				</div>
				</c:if>
			 --%>
			</div>
			
		</div>		
		
	</div>




	<!--##  푸터  ##-->                
	<c:import  url="/WEB-INF/jsp/admin/adminfooter.jsp"/>
	<!--##  /푸터  ##-->


</body>
</html>