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
	/****** 키보드 보안 설치 체크 ******/
	//keyScriptCheck();
	/*********************************/
	setTabButton();
	inputEnterKey();
	
	if("${pwPass}" == "F") {
		alert("비밀번호가 틀렸습니다.");
	}
}); 


/* 엔터 로그인 */
function inputEnterKey(){
	$("input[name=usrPw]").keypress(function(e) {
		  if(e.which == 13) {
			  doAction('login');
			  return false;
		  }
	});
}


function doAction(sAction)                                  
{
	  switch(sAction)
		{ 
			case "login":
				
					//관리자 아이디와 비밀번호 일치하는지 체크한다.
					$("form[name=adminPwConfirm]").attr("action","<c:url value='/admin/user/memUpd.do'/>").submit();
				break;
		}
}


           
function setTabButton(){ //버튼 클릭시 
	 
	 $("button[name=loginBtn]").click(function(e) { //비밀번호 요청 클릭시
		  	doAction("login");                                               
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
					
		<!-- 내용 -->
		<div class="container">
			<!-- 상단 타이틀 -->   
			<div class="title">
				<h2>개인정보수정</h2>                                  
				<p>홈 &gt; 개인정보수정</p> 
			</div>
			
			<!-- 탭 내용 -->
			<div class="content-default">
				<form name="adminPwConfirm"  method="post" action="#">
				<input type="hidden" name="usrId" value="${usrId}" />
				<div class="radius-box">
					<p class="reading">
						안전한 정보 보호를 위하여 다시 한번 비밀번호를 확인 합니다.<br/>
						비밀번호 노출에 주의하시기 바랍니다.
					</p> 
					<div class="idpw">
						<p><span class="id">아이디</span><strong> ${usrId}</strong></p>
						<p><label for="usrPw">비밀번호</label> <input type="password" name="usrPw" autocomplete="off"/></p>
						<button type="button" class="btn-login" name="loginBtn">확인</button>
					</div>
				</div>
				</form>
			</div>
			<!-- END  -->
			
		</div>		
	
	</div>
	
	<!--##  푸터  ##-->                
	<c:import  url="/WEB-INF/jsp/admin/adminfooter.jsp"/>
	<!--##  /푸터  ##-->
	
</body>
<!--nProtect KeyCrypt 적용 시작-->  
<script type="text/javascript" src="../../../js/nprotect/npkfx.js"></script>
<!--nProtect KeyCrypt 적용 끝-->
</html>

