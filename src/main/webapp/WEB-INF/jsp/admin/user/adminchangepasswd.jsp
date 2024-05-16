<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%
// 캐쉬 사용안함.
response.setDateHeader("Expires", 0L);
response.setHeader("Prama", "no-cache");
if(request.getProtocol().equals("HTTP/1.1"))
	response.setHeader("Cache-Control", "no-cache");
%> 
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<title>열린국회정보 관리시스템</title>
<c:import  url="/WEB-INF/jsp/inc/headincludeportal.jsp"/>

<validator:javascript formName="adminlogin" staticJavascript="false" xhtml="true" cdata="false"/> 
<script type="text/javascript">
//<![CDATA[                   
$(document).ready(function() {  
	buttonSet();
	/****** 키보드 보안 설치 체크 ******/
	keyScriptCheck();
	/*********************************/
	
	
	var dep01 = $(".dep01");
	dep01.each(function(index,item){ 	//메인 left 메뉴 마우스 오버시
		$(item).hover(                                                                                  
				function(e){
						$(item).find("a").addClass("on");
				},           
				function(e){  
					$(item).find("a").removeClass("on");
				});                
	});
	
}); 

function buttonSet() {
	$("#btn_change").click(function(e) {
		if(nullCheckValdation($('input[name=usrPw]'),"현 비밀번호","")){
			return false;
		}
		if(nullCheckValdation($('input[name=pwdNew1]'),"새 비밀번호","")){
			return false;
		}
		if(nullCheckValdation($('input[name=pwdNew2]'),"새 비밀번호 확인","")){
			return false;
		}
		//패스워드 유효성 체크후 패스워드 변경
		if ( fncPwChk() )	doAction("passwdChange");
	});
}

function doAction(sAction) {
	switch(sAction)                  
	{                        
		case "passwdChange":
			$("form[name=adminChangePasswd]").attr("action","<c:url value='/admin/user/adminChangePasswdExec.do'/>").submit();
			break;
	}
}

function fncPwChk() {
	var pwdNew1 = $('input[name=pwdNew1]').val();
	var pwdNew2 = $('input[name=pwdNew2]').val();
	var check = /^(?=.*[a-z])(?=.*[A-Z])(?=.*[!@#$%^&*()-])(?=.*[0-9]).{8,20}$/; //비밀번호 체크
	if ( !check.test(pwdNew1) ) {
		alert("비밀번호는 8~20자리 대문자, 소문자, 숫자, 특수문자 조합으로 입력해 주세요");
		return false;
	}
// 	if ( pwdNew1.length < 8 || pwdNew1.length > 21 ) {
// 		alert("비밀번호는 8~20자리 영, 숫자, 특수문자 조합으로 입력해 주세요2");
// 		return false;
// 	}
	if ( pwdNew1 != pwdNew2 ) {
		alert("새 비밀번호와 새 비밀번호 확인이 서로 맞지 않습니다.");
		return false;
	}
	return true;
} 
 
      
//]]>                    
</script>        
</head>
<body onload="">
		<c:import  url="/WEB-INF/jsp/portal/portaltop.jsp"/>           
		

		<!-- CONTAINER -->
	<div class="container" id="container">
		<div class="wrap">
			<div class="location">
				<h2 title="회원가입">비밀번호 변경</h2>
				<span><spring:message code='top.MenuHome'/> &gt; <spring:message code='top.menu9'/> &gt; <strong><spring:message code='labal.pwdChange'/></strong></span>
			</div>
			<hr/>
			
			<!-- LEFT 탭 -->
<%-- 			<c:import  url="/WEB-INF/jsp/portal/portalleft.jsp"/> --%>
			<!-- 비밀번호 변경 페이지는 import 안하고 그냥... -->	
			<div class="left m08" name="gubun6" >
					<h3>관리자 서비스</h3>
					<ul class="left-menu">
						<li class="dep01"><a href="<c:url value='/admin/user/agmtReg.do?code=adminLogin&leftCd=28&subCd=&depCd='/>"  ><spring:message code='top.menu6_1'/></a></li><!-- 회원가입  -->
						<li class="dep01"><a href="<c:url value='/admin/user/memIdPwSearch.do?code=adminLogin&leftCd=29&subCd=&depCd='/>" ><spring:message code='top.menu6_2'/></a></li> <!-- 아이디/비밀번호 찾기  -->
						<li class="dep01"><a href="<c:url value='/portal/user/agmt.do?code=adminLogin&leftCd=30&subCd=&depCd='/>" ><spring:message code='top.tos'/></a></li> <!--이용약관  -->
						<li class="dep01"><a href="<c:url value='/admin/user/ksignReg.do?code=adminLogin&leftCd=31&subCd=&depCd='/>" ><spring:message code='top.ksignReg'/></a></li> <!--공인인증서 등록 -->
						<li class="dep01"><a href="<c:url value='/admin/user/ksignIssue.do?code=adminLogin&leftCd=32&subCd=&depCd='/>" ><spring:message code='top.ksignIssue'/></a></li> <!--공인인증서 발급  -->
					</ul>
			</div>
			<!-- END  -->

			
			<!-- 탭 내용 -->
			<form name="adminChangePasswd" method="post">
			<div class="left-content">
				<div class="left-content-header">
					<p class="img6">안전한 개인정보 보호를 위해 암호를 변경해 주시기 바랍니다.</p>
				</div>
				
				<div class="check-list" style="padding:50px 0 50px 140px;margin:40px 0 0 0;">
					<ul class="three-pwd">
						<li><label for="pwdCurr">현 비밀번호</label><input type="password" id="usrpw" name="usrPw" value="" size="25" maxlength="20" autocomplete="off"/></li>
						<li><label for="pwdNew1">새 비밀번호</label><input type="password" id="pwdNew1" name="pwdNew1" size="25" maxlength="20" autocomplete="off"/> <span>※ 8~20자리 대문자, 소문자, 숫자, 특수문자 조합</span></li>
						<li><label for="pwdNew2">새 비밀번호 확인</label><input type="password" id="pwdNew2" name="pwdNew2" size="25" maxlength="20" autocomplete="off"/></li>
					</ul>
					 
				</div>
			</div>
			<div class="buttons" style="margin:0;">
				<a href="#" class="btn02" id="btn_change">변경</a>
			</div>
			</form>
					
		</div>
 
	</div>
		
	<hr/>
		
	<c:import  url="/WEB-INF/jsp/portal/portalfooter.jsp"/>  
		
<!--nProtect KeyCrypt 적용 시작-->
<script type="text/javascript" src="../../../js/nprotect/npkfx.js"></script>
<!--nProtect KeyCrypt 적용 끝-->
</body>
</html>
