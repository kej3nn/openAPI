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
 var gpkiLinkUrl =new Array("<c:url value='http://www.gpki.go.kr'/>" );          
           
 var npkiLinkUrl =new Array("<c:url value='http://www.signgate.com'/>"         /* 한국정보인증 */
		,"<c:url value='http://www.koscom.co.kr'/>"				 	   /* 한국증권전산  */
		,"<c:url value='http://www.kftc.or.kr' />"  /* 금융결제원  */
		,"<c:url value='http://www.crosscert.com' />"  /* 한국전자인증  */
		,"<c:url value='http://homepage.ktnet.co.kr' />"  /* 한국무역정보통신  */	 
		);
            
           
 $(document).ready(function(){
	 linkClick();
 });
 
 function linkClick(){
	 
	 //행정 / 공공기관 회원은 GPKI 인증서로 발급하세요.
	 $("a[name=gpkiLink]").click(function(e){ //npki 링크를 클릭했을때
		 var gpkiLink = $(this).attr("id").substring(8); //해당 a태그의 순서번호를 알아낸다.
		 window.open(gpkiLinkUrl[gpkiLink]); //해당하는 url로 새창을 띄어준다.
	 });
	 
	 //GPKI 인증서를 발급 받을 수 없는 회원은 NPKI 인증서로 발급 하세요.
	 $("a[name=npkiLink]").click(function(e){ //npki 링크를 클릭했을때
		 var npkiLink = $(this).attr("id").substring(8); //해당 a태그의 순서번호를 알아낸다.
		 window.open(npkiLinkUrl[npkiLink]); //해당하는 url로 새창을 띄어준다.
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
				<h2 title="<spring:message code='top.ksignIssue'/>"><spring:message code='top.ksignIssue'/></h2>
				<span><spring:message code='top.MenuHome'/> &gt;<spring:message code='top.menu9'/> &gt;<strong><spring:message code='top.ksignIssue'/></strong></span>
			</div>
			<hr/>
			
			
			<!-- LEFT 탭 -->
			<c:import  url="/WEB-INF/jsp/portal/portalleft.jsp"/>
			<!-- END  -->
		
		
			<!-- 탭 내용 -->
			<div class="left-content">
				
				<div class="left-content-header">
					<p class="img6 line2">관리자는 아이디/비밀번호 및 인증서 로그인을 하셔야 이용하실 수 있습니다.<br/>
					<span>인증서가 없으시면 먼저 공인인증서를 발급받으세요.</span> 
				</div>
				
				<div class="clause">
					<p class="clause-title" style="margin-bottom:10px;">행정 / 공공기관 회원은 GPKI 인증서로 발급하세요.</p>
					<span>GPKI 인증서 발급</span> <a href="#" class="btn01LD" name="gpkiLink" id="gpkiLink0">GPKI 공인인증서 발급</a>
				</div>
				
				<div class="clause">
					<p class="clause-title" style="margin-bottom:10px;">GPKI 인증서를 발급 받을 수 없는 회원은 NPKI 인증서로 발급 하세요.</p>
					<span>NPKI 인증서 발급</span> 
					<a href="#" class="btn01LD" name="npkiLink" id="npkiLink0">한국정보인증</a> 
					<a href="#" class="btn01LD" name="npkiLink" id="npkiLink1">한국증권전산</a> 
					<a href="#" class="btn01LD" name="npkiLink" id="npkiLink2">금융결제원</a> 
					<a href="#" class="btn01LD" name="npkiLink" id="npkiLink3">한국전자인증</a> 
					<a href="#" class="btn01LD" name="npkiLink" id="npkiLink4">한국무역정보통신</a>
				</div>
				
			</div>
			<!-- END  -->
			
			
		</div>		
	
	</div>
	
	
	<!--##  푸터  ##-->                                       
	<c:import  url="/WEB-INF/jsp/portal/portalfooter.jsp"/>                                   
	<!--##  /푸터  ##-->
	


</body>
</html>