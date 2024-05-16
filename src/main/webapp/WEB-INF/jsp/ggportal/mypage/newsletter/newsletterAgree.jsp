<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>

<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ 	--%>
<%-- 마이페이지 > 뉴스레터 수신동의 
<%-- 
<%-- @author jhkim
<%-- @version 1.0 2019/11/26
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ 	--%>
<!DOCTYPE html>
<html lang="ko">
<head>
<!-- head include -->
<%@ include file="/WEB-INF/jsp/portal/sect/head.jsp" %>
</head>
<body>
<!-- header html -->
<%@ include file="/WEB-INF/jsp/portal/sect/header.jsp" %>
<div class="container" id="container">
<!-- leftmenu -->
<%@ include file="/WEB-INF/jsp/portal/sect/lnb.jsp" %>
<!-- //leftmenu -->

<!-- contents -->
	<div class="contents" id="contents">
		<div class="contents-title-wrapper">
			<h3>뉴스레터 수신동의<span class="arrow"></span></h3>
        </div>

<div class="layout_flex">

    <!-- content -->
    <div class="layout_flex_100">
		<div class="area_h3 area_h3_AB deco_h3_3">
		<form id="formObj" method="post" action="/portal/myPage/saveNewsletterAgree.do">
			<input type="hidden" name="emailYn" value="${data.emailYn }">
			<div class="newsletter">
				열린국회정보는 국회 일정, 뉴스, 문화행사, 인기 공개 정보 등 다양한 정보에 대한 뉴스레터 메일링 서비스를 제공하고 있습니다.<br><br> 
				뉴스레터 수신 동의를 하시면 메일링 서비스를 받으실 수 있습니다. 
			</div>
			<div class="newsletter_email">
				<c:if test="${data.emailYn eq 'Y'}">
					<input type="text" title="이메일 입력" name="userEmail" value="${data.userEmail }">
					<button type="button" id="btnUpdate">정보변경</button>
					<button type="button" id="btnCancel">수신취소</button>
				</c:if>
				<c:if test="${data.emailYn eq 'N'}">
					<input type="text" title="이메일 입력" name="userEmail" value="">
					<button type="button" id="btnAgree">수신동의</button>
				</c:if>
				
			</div>
		</div>
		</form>

	</div>
	<!-- // content -->
</div>
<!-- // layout_flex #################### -->
</div></div>

<!-- footer -->
<%@ include file="/WEB-INF/jsp/portal/sect/footer.jsp" %>
<script type="text/javascript" src="<c:url value="/js/ggportal/myPage/newsletter/newsletterAgree.js" />"></script>
</body>
</html>