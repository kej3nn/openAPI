<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="egovframework.common.WiseOpenConfig"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page import="egovframework.common.util.PagingView"%>
<%
%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><spring:message code='wiseopen.portalTitle'/></title>                    
<c:import  url="/WEB-INF/jsp/inc/headincludeportal.jsp"/>

<script language="javascript">               
//<![CDATA[
  
  $(document).ready(function(){
	  setButton();
  });
  
  function setButton(){ //버튼 클릭시 
  
	  $("a[name=a_adminLogin]").click(function(e) { //관리자 로그인 화면으로 이동한다.
		  location.href = "<c:url value='/admin/admLog.do?code=adminLogin'/>";	
		  return false;                  
	  });
  }
           
//]]> 
</script>              
</head>
<body>

		
		<!-- 상단 -->
		<c:import  url="/WEB-INF/jsp/portal/portaltop.jsp"/>  
		
		
		<!-- CONTAINER -->
		<div class="container" id="container">
		<div class="wrap">
			<div class="location">
				<h2 title="<spring:message code='top.menu6_1'/>"><spring:message code='top.menu6_1'/></h2>
				<span><spring:message code='top.MenuHome'/> &gt;<spring:message code='top.menu9'/>&gt; <strong><spring:message code='top.menu6_1'/></span>
			</div>
			<hr/>
			
			<!-- LEFT 탭 -->
			<c:import  url="/WEB-INF/jsp/portal/portalleft.jsp"/>
			<!-- END  -->
			
			<!-- 탭 내용 -->
			<div class="left-content">
				
				<div class="left-content-header">
					<p class="img6">열린 재정 시스템의 회원으로 가입되셨습니다.<br/></p>
				</div>
				
				
				<div class="mem-box" style="padding:70px 0;margin-bottom:20px;">
					<p class="mem-id">아이디 : ${UsrId}</p>
				</div>
				
				<dl class="header-desc3">
<!-- 					<dd><a href="#" class="btn01D">자료취합 업무소개</a></dd> -->
<!-- 					<dd><a href="#" class="btn01D">국고보조금 업무소개</a></dd> -->
				</dl>
									
				<div class="btn-txt">
					열린 재정 시스템의 회원정보는 <strong>개인정보처리방침</strong>에 의해 보호받고 있습니다.<br>
					자세한 문의는 사용자지원실로 문의하시기 바랍니다.
				</div>
				
			</div>
			<!-- END -->
			
		</div>		
	
	</div>
	
	
	<c:import  url="/WEB-INF/jsp/inc/iframepopup.jsp"/>
	<!--##  푸터  ##-->                                       
	<c:import  url="/WEB-INF/jsp/portal/portalfooter.jsp"/>                                   
	<!--##  /푸터  ##--> 
	


</body>
</html>