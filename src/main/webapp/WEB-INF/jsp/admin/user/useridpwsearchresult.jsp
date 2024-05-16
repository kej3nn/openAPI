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
	 setTabButton();
 });
 
 function setTabButton(){ //버튼 클릭시 
 
	  $("a[name=loginBtn]").click(function(e) {
		  location.href = "<c:url value='/admin/admLog.do?code=adminLogin'/>"; //관리자 로그인 창으로 이동                                              
		return false;                  
	  });
 
	  $("a[name=myInfoUpdLink]").click(function(e) {
		  location.href = "<c:url value='/admin/admLog.do?code=adminLogin&pwConfirmStatus=update'/>"; //관리자 비밀번호 수정페이지로 이동.                                             
		return false;                  
	  });
 }
           
//]]> 
</script> 
</head>
  
<body>
	<!-- HEADER -->	
	<c:import  url="/WEB-INF/jsp/portal/portaltop.jsp"/>
	<!-- HEADER END  -->
	
	<!-- CONTAINER -->
	<div class="container" id="container">
		<div class="wrap">
			<div class="location">
				<h2 title="<spring:message code='top.menu6_2'/>"><spring:message code='top.menu6_2'/></h2>
				<span><spring:message code='top.MenuHome'/> &gt;<spring:message code='top.menu9'/> &gt;<strong><spring:message code='top.menu6_2'/></strong></span>
			</div>
			<hr/>
			
			<!-- LEFT 탭 -->
			<c:import  url="/WEB-INF/jsp/portal/portalleft.jsp"/>
			<!-- END  -->
			
			<!-- 탭 내용 -->
			<div class="left-content">
				
				<div class="left-content-header">
					<p class="img6 line2">
					문의하신 비밀번호는 초기화 되었습니다.<br/>
					<c:if test="${CommUsr.hpYn == 'Y'}">
						회원가입 시 등록하신 번호에 문자메세지로 초기화된 정보를 보내 드렸습니다.<br/>
					</c:if>
					<strong>로그인 하신 후 반드시 <a href="#" name="myInfoUpdLink">마이페이지 > 비밀번호 수정</a> 에서 변경하시기 바랍니다.</strong>
					</p>
				</div>
				<%-- 
				<c:if test="${CommUsr.hpYn == 'Y'}">
					<ul class="pwd-reset">
						<li><p>아이디</p><span>${CommUsr.usrId}</span></li>
						<li><p>비밀번호 초기화</p><span>****************</span></li>
						<li><p>안내</p><span>등록하신 휴대전화번호로<br/>비밀번호가 발송되었습니다.</span></li>
					</ul>
				</c:if>
				
				<c:if test="${CommUsr.hpYn == 'N'}">
					<ul class="pwd-reset">
						<li><p>아이디</p><span>${CommUsr.usrId}</span></li>
						<li><p>비밀번호 초기화</p><span>${CommUsr.usrPw}</span></li>
					</ul>
				</c:if> --%>
				<c:choose>
					<c:when test="${CommUsr.messageCheck eq 'Y'}">	<!-- 메세지 수신 동의 했을 경우 -->
						<c:choose>
							<c:when test="${emptyHp eq 'Y'}">	<!-- 수신 동의지만 휴대폰 번호가 없을 경우 비밀번호 표시 -->
								<ul class="pwd-reset">
									<li><p>아이디</p><span>${CommUsr.usrId}</span></li>
									<li><p>비밀번호 초기화</p><span>${CommUsr.usrPw}</span></li>
								</ul>
							</c:when>
							<c:otherwise>
								<ul class="pwd-reset">
									<li><p>아이디</p><span>${CommUsr.usrId}</span></li>
									<li><p>비밀번호 초기화</p><span>****************</span></li>
									<li><p>안내</p><span>등록하신 휴대전화번호로<br/>비밀번호가 발송되었습니다.</span></li>
								</ul>
							</c:otherwise>
						</c:choose>
					</c:when>
					<c:otherwise>	<!-- 메세지 수신 미 동의시 무조건 표시-->
						<ul class="pwd-reset">
							<li><p>아이디</p><span>${CommUsr.usrId}</span></li>
							<li><p>비밀번호 초기화</p><span>${CommUsr.usrPw}</span></li>
						</ul>
					</c:otherwise>
				</c:choose>
									
				<div class="buttons">
					<a href="#" class="btn02" name="loginBtn">로그인</a>
				</div>
				
				<div class="btn-txt">
					재정정보 공개시스템의 회원정보는 <strong>개인정보처리방침</strong>에 의해 보호받고 있습니다.<br>
					자세한 문의는 사용자지원실로 문의하시기 바랍니다.
				</div>
				
			</div>
			<!-- END  -->
	
	</div>

	</div>
	
	<hr/>
	
	<!--##  푸터  ##-->                                       
	<c:import  url="/WEB-INF/jsp/portal/portalfooter.jsp"/>                                   
	<!--##  /푸터  ##-->

</body>
</html>