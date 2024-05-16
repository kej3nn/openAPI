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
<script language="javascript"> 
//<![CDATA[      
$(document).ready(function() {  
	iPinCheck();
	aAndButtonSet();
}); 

function aAndButtonSet(){
	$(".logout").click(function(e) {
		location.href = "<c:url value='/admin/adminlogOut.do'/>"; //로그아웃
		return false;
	}); 
}
           
function iPinCheck(){ //ipin 인증시
	$("a[name = myInfoIPin]").click(function(e){
		/*
		var check = "";// 인증체크후 컨트롤거쳐 인증 update하고 페이지 이동하면 될듯
		
		location.href = "<c:url value='/admin/adminMain.do'/>"; // 아이디/비밀번호 찾기 페이지로 이동.                                             
		return false;
		*/
		var target = "<c:url value='/G-PIN/AuthRequest.jsp?rtnVal=ipinCheck'/>"; 
		var wName = "agreeReg";        
		var wWidth = "330";                                  
		var wHeight = "100";                                       
		var wScroll ="yes";    
		OpenWindow(target, wName, wWidth, wHeight, wScroll);
	});
}
	

           
//]]> 
</script> 
<body>
	
	<div class="wrap">
		
		<!-- 상단 -->
<%-- 		<c:import  url="/admin/admintop.do"/> --%>
		<div class="header">
			<!-- 로고 및 유틸메뉴 -->  
			<h1>
				<a href="#" name="mainHome">기획재정부 통합재정정보 공개관리시스템</a>
			</h1>
<!-- 		<ul class="gnb">
					<li class="none"></li>       
<!-- 				<li><a href="#">이용안내</a></li> --><!-- 일시적 숨김  -->
<!-- 				<li><a href="#">사이트맵</a></li>            --><!-- 일시적 숨김  -->
<!--			</ul>          -->                                                                                  
			<div class="user_info">   
			    <strong><c:out value="${sessionScope.loginVO.usrNm}"/>님</strong> 환영합니다        
			    <a href="#" name="myInfoUpd" class="set">개인정보수정</a>                                   
				<a href="#" class="logout"><spring:message code='a.logout'/></a>        
			</div>
		</div>    
		<!--  -->
					
		<!-- 내용 -->
		<div class="container" style="margin:40px 0 0 0;">
			<!-- 상단 타이틀 -->   
			<div class="title">
				<h2>공공 I-PIN인증</h2>                                  
				<p>홈 &gt; 공공 I-PIN인증</p> 
			</div>
		
			
			<!-- 탭 내용 -->
			<div class="content-default">
				
				<div class="radius-box">
					<p class="reading">
						시스템을 이용하기 위해서는 먼저 본인인증을 하셔야 합니다.<br/>
						본인인증 방법은 공공 I-PIN 으로 인증할 수 있습니다.<br/>
						공공 I-PIN 식별 ID가 없으면 먼저 안전행정부로 부터 발급 받으시기 바랍니다.
					</p> 
					<div class="buttons">
						<a href="#" class="btn02L" name="myInfoIPin">공공 I-PIN 인증</a>
					</div>
				</div>
				
			</div>
			<!-- END  -->
			
		</div>		
	
	</div>
	
	<!--##  푸터  ##-->                
	<c:import  url="/WEB-INF/jsp/admin/adminfooter.jsp"/>
	<!--##  /푸터  ##-->
	
</body>
</html>

