<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%-- <%@page import="ksign.jce.util.Base64"%> --%>
<%@page import="java.security.SecureRandom"%>
<%
// 캐쉬 사용안함.
response.setDateHeader("Expires", 0L);
response.setHeader("Prama", "no-cache");
if(request.getProtocol().equals("HTTP/1.1"))
	response.setHeader("Cache-Control", "no-cache");

//인증서 로그인 난수값(인증서 로그인시 필요.)
/* SecureRandom sr= new SecureRandom();
sr.nextBoolean();
byte[]  bChallenge = new byte[30]; 
sr.nextBytes(bChallenge);
String sChallenge = Base64.encode2(bChallenge);
session.setAttribute("challenge", sChallenge); */


//세션에서 로그인성공 플래그 가지고온다.
String admLoginFlag = session.getAttribute("admLoginFlag") == null ? "" : (String)session.getAttribute("admLoginFlag");
String usrId = session.getAttribute("usrId") == null ? "" : (String)session.getAttribute("usrId");
String usrPw = session.getAttribute("usrPw") == null ? "" : (String)session.getAttribute("usrPw");
//System.out.println("admLoginFlag 1=================>" + admLoginFlag);
/* String url = request.getRequestURL().toString(); */
/* if(url.startsWith("http://")){          
	response.sendRedirect("https://www.openfiscaldata.go.kr/admin/admLog.do?code=adminLogin");                  
} */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no, target-densitydpi=medium-dpi" /> 
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="format-detection" content="telephone=no" /> 
<meta name="copyright" content="Gyeonggi Province. All Rights Reserved." />
<meta name="description" content="해당 사이트에서 필요한 자료를 손쉽게 찾아보세요. PC웹, 태블릿 PC, 모바일에서 편리하게 사용하실 수 있습니다." />
<meta name="keywords" content="데이터, data, 데이터셋, 멀티미디어, 데이터 시각화, 활용갤러리, 개방데이터 요청, 개발자 공간, 공공데이터 개방, 공공테이터 통계" />
<title>열린국회정보 관리시스템</title>
<%-- <script type="text/javascript" src="${pageContext.request.contextPath}/kSign/js/config.js"  charset="utf-8"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/kSign/js/ksign.js"  charset="utf-8"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/kSign/js/example.js"  charset="utf-8"></script> --%>
<c:import  url="/WEB-INF/jsp/inc/headincludeadmin.jsp"/>
<link type="text/css" href="${pageContext.request.contextPath}/css/ggportal/layout_admin.css" rel="stylesheet" type="text/css" /> 
<validator:javascript formName="adminlogin" staticJavascript="false" xhtml="true" cdata="false"/> 
<script type="text/javascript">
//<![CDATA[                   
$(document).ready(function() {  
	/****** 키보드 보안 설치 체크 ******/
	//keyScriptCheck();
	/*********************************/
	//$("#usrId").focus();                            
	buttonSet();
	//로그인 성공시 공인인증서 창 띄운다.
	<%-- if("<%=admLoginFlag%>" != ""){
		login($("#btn_login"));        // 공인인증서 ksign.js 띄운다.      
	} --%>
	
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
	

    // 저장된 쿠키값을 가져와서 ID 칸에 넣어준다. 없으면 공백으로 들어감.
    var userInputId = getCookie("userInputId");
    $("#userid").val(userInputId); 
     
    if($("#userid").val() != ""){ // 그 전에 ID를 저장해서 처음 페이지 로딩 시, 입력 칸에 저장된 ID가 표시된 상태라면,
        $("#IDsave").prop("checked", true); // ID 저장하기를 체크 상태로 두기.
    }
     
    $("#IDsave").change(function(){ // 체크박스에 변화가 있다면,
        if($("#IDsave").is(":checked")){ // ID 저장하기 체크했을 때,
            var userInputId = $("#userid").val();
            setCookie("userInputId", userInputId, 365); // 1년 동안 쿠키 보관
        }else{ // ID 저장하기 체크 해제 시,
            deleteCookie("userInputId");
        }
    });
     
    // ID 저장하기를 체크한 상태에서 ID를 입력하는 경우, 이럴 때도 쿠키 저장.
    $("#userid").keyup(function(){ // ID 입력 칸에 ID를 입력할 때,
        if($("#IDsave").is(":checked")){ // ID 저장하기를 체크한 상태라면,
            var userInputId = $("#userid").val();
            setCookie("userInputId", userInputId, 365); // 1년 동안 쿠키 보관
        }
    });
}); 

function buttonSet() {
	$("#btn_login").click(function(e) {
		
		doAction("login");    
	});
	 
// 	$('input[name=usrId]').keyup(function(e) {                 
//  		ComInputEngNumObj($('input[name=usrId]'));
//  		return false;                                                                          
//  	});
	 
	 
	$("#userpwd").keypress(function(e) {    //비밀번호 엔터로 로그인하기
		  if(e.which == 13) {
			  doAction("login");
			  return false;    
		  }
	});

	//회원가입 버튼 
	$("a[name=memRegLink]").click(function(e) { 
		  	location.href = "<c:url value='/admin/user/agmtReg.do?code=adminLogin&leftCd=28&subCd='/>"; // 회원가입 페이지로 이동.                                            
			return false;                  
	});
	
	//아이디/비밀번호 찾기 버튼
	$("a[name=memIdPwSearchLink]").click(function(e) { 
		  	location.href = "<c:url value='/admin/user/memIdPwSearch.do?code=adminLogin&leftCd=28&subCd='/>"; // 아이디/비밀번호 찾기 페이지로 이동.                                             
			return false;                  
	});
	  
	
	//회원 로그인 버튼
	$("a[name=portalLoginLink]").click(function(e) { 
	  	location.href = "<c:url value='/portal/portallogin.do?code=login'/>";                                           
		return false;                  
	});
	
	//공인인증서 등록 버튼
	$("button[name=ksignRegLink]").click(function(e) { 
	  	location.href = "<c:url value='/admin/user/ksignReg.do?code=adminLogin&leftCd=31&subCd='/>";                                            
		return false;                  
	});
	
	//공인인증서 발급 버튼
	$("a[name=ksignIssueLink]").click(function(e) { 
	  	location.href = "<c:url value='/admin/user/ksignIssue.do?code=adminLogin&leftCd=32&subCd='/>";                                             
		return false;                  
	});
	
	/* $("button[name=keyCryptInstallSet]").click(function(e) {
	    keyCryptInstall();                                               
		return false;                  
  	}); */
	
	
	
}

function doAction(sAction) {
	switch(sAction)                  
	{                        
		case "login":
			
			$("form[name=login]").attr("action","<c:url value='/admin/loginexec.do'/>").submit();
			break;
	}
}

function sessionNullCheck(){ //인증서 화면에서 취소시 실행하며 세션을 초기화한다.
	$("form[name=login]").attr("action","<c:url value='/admin/adminLoginCancel.do'/>").submit();
}
 


function setCookie(cookieName, value, exdays){
    var exdate = new Date();
    exdate.setDate(exdate.getDate() + exdays);
    var cookieValue = escape(value) + ((exdays==null) ? "" : "; expires=" + exdate.toGMTString());
    document.cookie = cookieName + "=" + cookieValue;
}
 
function deleteCookie(cookieName){
    var expireDate = new Date();
    expireDate.setDate(expireDate.getDate() - 1);
    document.cookie = cookieName + "= " + "; expires=" + expireDate.toGMTString();
}
 
function getCookie(cookieName) {
    cookieName = cookieName + '=';
    var cookieData = document.cookie;
    var start = cookieData.indexOf(cookieName);
    var cookieValue = '';
    if(start != -1){
        start += cookieName.length;
        var end = cookieData.indexOf(';', start);
        if(end == -1)end = cookieData.length;
        cookieValue = cookieData.substring(start, end);
    }
    return unescape(cookieValue);
}
      
//]]>                    
</script>        
</head>
<body>
	<!-- layout_main -->
<div class="layout_main">

<!-- header ############################## -->
<header id="header">
<div class="area_navi clfix">
	<nav id="navi">
	<ul class="clfix logofix">
		<li><img src="../img/ggportal/desktop/common/h1.png" align="top" alt="정보공개 관리시스템"></li>
		<li class="admin_txt"><span>정보공개 관리시스템</span></li>
	</ul>
	</nav>
	<form>
	<fieldset>
	<!-- <legend>검색</legend>
	<span class="search clfix">
		<input type="search" id="search" autocomplete="on" placeholder="검색" title="검색" /><a href="" class="btn_search"><span>검색</span></a>
	</span> -->
	</fieldset>
	</form>
</div>
</header>
<!-- // header ############################## -->

<!-- wrap_layout_flex ############################## -->
<div class="wrap_layout_flex"><div class="layout_flex_100">

<!-- layout_flex #################### -->
<div class="layout_flex">
	<!-- content -->
	<div id="contentAdmin" class="contentAdmin">
		<div class="area_log">
			<form name="login">
			<fieldset>
			<legend>로그인</legend>
			<table class="table_login">
			<caption>로그인</caption>
			<tr>
				<th scope="row"><label for="usrid"><img src="../img/admin/tit_ID.png" alt="아이디" /></label>
				</th>
				<td>
					<!-- <input type="text" id="ID" class="input" /> -->
					<input type="text" name="usrId" id="userid" size="20" value="" onkeydown="ComInputEngNum(this.id)" maxlength="15"/>
					<input type="checkbox" id="IDsave" class="chk" name="IDsave"/>
					<label for="IDsave" class="IDsave">아이디 저장</label>
				</td>
			</tr>
			<tr>
				<th scope="row"><label for="userpwd"><img src="../img/admin/tit_PW.png" alt="비밀번호" /></label>
				<td>
					<!-- <input type="text" id="PW" class="input" /> -->
					<input type="password" name="usrPw" id="userpwd" size="20" value="" maxlength="20" autocomplete="off"/>
					<input type="image" id="btn_login" name="btn_login" src="../img/admin/btn_login.png"  alt="로그인" /> 
				</td>
			</tr>
			</table>
			</fieldset>
			</form>
			<ul class="explanation_login">
			<li>관리자 등록 후 이용하시기 바랍니다.</li>
			<li>관리자 등록은 <strong>관리자</strong>에게 문의해주시기 바랍니다.</li>
			<li>문의: <a href="mailto:hotoasis74@korea.kr">hotoasis74@korea.kr</a>, 02-2680-6301</li>
			</ul>
		</div>
	</div>
	<!-- // content -->
</div>
<!-- // layout_flex #################### -->

</div></div>		
<!-- // wrap_layout_flex ############################## -->

<!-- footer ############################## -->
<footer>
<div class="area_menu_footer" style="display:none;">
	<div class="menu_footer">
		<a href="">이용약관</a> 
		<a href="">개인정보처리방침</a> 
		<a href="">저작권동의방침</a> 
		<a href="">이메일무단수집거부</a>
	</div>
</div>
<div class="area_address">
	<address>
	우)07233 | 서울시 영등포구 의사당대로 1(여의도동)<br />
	COPYRIGHT(C)2019 <strong>대한민국국회.</strong> ALL RIGHTS RESERVED.
	</address>
</div>
</footer>
<!-- // footer ############################## -->
</div>
<!-- // layout_main -->
</body>
</html>
