<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%-- @(#)mindmap.jsp 1.0 2019/11/23											--%>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%-- 로그인 화면이다.
<%--
<%-- @author jhkim
<%-- @version 1.0 2019/11/26
<%-- @version 1.1 2022/05/23 login2.jsp로 파일 대체(SSO 로그인 연동)
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<!DOCTYPE html>
<html lang="ko">
<head>
<!-- head include -->
<%@ include file="/WEB-INF/jsp/portal/sect/head.jsp" %>

<c:if test="${not empty errMsg}">
	<script>
		alert("${errMsg}");
	</script>
</c:if>

</head>

<body>

<!-- header html -->
<%@ include file="/WEB-INF/jsp/portal/sect/header.jsp" %>
<div class="container" id="container">
	<!-- leftmenu -->
	<%-- <%@ include file="/WEB-INF/jsp/portal/sect/lnb.jsp" %> --%>
	<div class="lnb">
		<h2>회원관련</h2>
		<ul>
			<li><span><a href="/portal/user/loginPage.do" class="on">로그인</a></span></li>
			<li><span><a href="https://www.assembly.go.kr/assm/assmember/assjoin/join/joinAgree.do" target="_blank" title="새창열림_회원가입">회원가입</a></span></li>
			<li><span><a href="https://www.assembly.go.kr/assm/assmember/assfindid/login/findIdForm.do" target="_blank" title="새창열림_아이디 찾기">아이디 찾기</a></span></li>
			<li><span><a href="https://www.assembly.go.kr/assm/assmember/assfindpw/login/findPasswordForm.do" target="_blank" title="새창열림_비밀번호 찾기">비밀번호 찾기</a></span></li>
		</ul>
	</div>
	<!-- //leftmenu -->
	
	<!-- contents -->
	<div class="contents" id="contents">
		<div class="contents-title-wrapper">
			<h3>로그인<span class="arrow"></span></h3>
	    </div> 
	    
		<div class="layout_flex">
	        <!-- LOGIN -->
			<form id="mberForm" name="mberForm" method="post" action="/portal/user/loginProc.do">
				<div class="login">
					<div class="login_box">
						<div>
							<h2>LOGIN</h2>
							<strong>열린국회정보 정보공개포털 방문을 환영합니다.</strong>
						</div>
						<fieldset>
							<legend>로그인</legend>
							<div class="login_form">
								<div class="login_form_id">
									<input type="text" id="memberId" title="아이디" name="memberId" placeholder="아이디" class="login_id" value="">
								</div>
								<div class="login_form_pw">
									<input type="password" id="memberPw" title="비밀번호" name="memberPw" placeholder="비밀번호" class="login_pw" value="">
								</div>
							</div>
							<div class="login_form_btn">
	              					<input type="submit" value="로그인" title="로그인" class="btn_login">
							</div>
							<div class="login_form_save">
								<!-- <div>
									<input type="checkbox" id="loginidSave"> <label for="loginidSave">아이디 저장</label>
								</div> -->
								<div class="login_form_find">
									<a href="https://www.assembly.go.kr/assm/assmember/assfindid/login/findIdForm.do" target="_blank" title="새창열기_아이디 찾기">아이디 찾기</a>
									<a href="https://www.assembly.go.kr/assm/assmember/assfindpw/login/findPasswordForm.do" target="_blank" title="새창열기_비밀번호 찾기">비밀번호 찾기</a>
								</div>
							</div> 
						</fieldset>
					</div>
					<div class="login_form_regist">
						<a href="https://www.assembly.go.kr/assm/assmember/assjoin/join/joinAgree.do" target="new" title="새창열림_회원가입">회원가입</a>
					</div>
				</div>	
			</form>
			<!-- //LOGIN -->
		</div>
	</div>
</div>  
<%@ include file="/WEB-INF/jsp/portal/sect/footer.jsp" %>
</body>
</html>