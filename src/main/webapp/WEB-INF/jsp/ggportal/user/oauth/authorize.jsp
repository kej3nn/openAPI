<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%-- @(#)authorize.jsp 1.0 2015/06/15                                       --%>
<%--                                                                        --%>
<%-- COPYRIGHT (C) 2013 WISEITECH CO., LTD. ALL RIGHTS RESERVED.            --%>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>

<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%-- 인증을 요청하는 화면이다.                                              --%>
<%--                                                                        --%>
<%-- @author 김은삼                                                         --%>
<%-- @version 1.0 2015/06/15                                                --%>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<!DOCTYPE html>
<html lang="ko">
<head>
<%@ include file="/WEB-INF/jsp/portal/sect/head.jsp" %>
<c:forEach items="${data}" var="provider" varStatus="status">
<c:if test="${provider.RevokeType == 'script'}">
<c:choose>
<c:when test="${provider.RevokeMethod == 'resource'}">
<script type="text/javascript" src="<c:out value="${provider.RevokeUrl}" escapeXml="false" />"></script>
</c:when>
<c:when test="${provider.RevokeMethod == 'function'}">
<c:choose>
<c:when test="${provider.RevokeUrl == 'Kakao'}">
<script type="text/javascript" src="<c:url value="/js/ggportal/kakao.min.js" />"></script>
<script type="text/javascript">
    $(function() {
        Kakao.init("<c:out value="${provider.RevokeArgs.client_id}" />");
        Kakao.Auth.logout(function(data) {
            // Nothing to do.
        });
    });
</script>
</c:when>
<c:when test="${provider.RevokeUrl == 'FB'}">
<script type="text/javascript">
    window.fbAsyncInit = function() {
        FB.init({
            appId:"<c:out value="${provider.RevokeArgs.client_id}" />",
            xfbml:true,
            version:"v2.3"
        });
        FB.getLoginStatus(function(response) {
        	/*
			FB.logout(function(response) {
                // Nothing to do.
            });
			*/
			if (response.status === 'connected') {
                FB.logout(function(response) {
                    // this part just clears the $_SESSION var
                    // replace with your own code
                    $.post("/logout").done(function() {
                        //
                    });
                });
            }
        });
    };

    (function(d, s, id) {
        var js, fjs = d.getElementsByTagName(s)[0];
        if (d.getElementById(id)) { return; }
        js = d.createElement(s); js.id = id;
        js.src = "//connect.facebook.net/en_US/sdk.js";
        fjs.parentNode.insertBefore(js, fjs);
    }(document, "script", "facebook-jssdk"));
</script>
</c:when>
</c:choose>
</c:when>
</c:choose>
</c:if>
</c:forEach>
<script type="text/javascript" src="<c:url value="/js/ggportal/user/oauth/authorize.js" />"></script>
</head>
<body>
<!-- layout_A -->
<div class="layout_A">
<%@ include file="/WEB-INF/jsp/portal/sect/header.jsp" %>
<div class="container" id="container">
	<!-- leftmenu -->
	<nav>
		<div class="lnb">
			<h2>SNS 로그인</h2>
			<ul>
	            <li><span><a href="/portal/openapi/openApiActKeyPage.do" class="menu_1 selected">SNS 로그인</a></span></li>
			</ul>
		</div>
	</nav>
	<!-- //leftmenu -->
<!-- contents -->
	<div class="contents" id="contents">
		<div class="contents-title-wrapper">
			<h3>SNS 로그인<span class="arrow"></span></h3>
		</div>
		
<!-- wrap_layout_flex -->
<div class="wrap_layout_flex">
<div class="layout_flex_100">
<!-- layout_flex -->
<div class="layout_flex">
    <!-- content -->
    <div id="content" class="content_B">
        <h2 class="hide"><c:out value="${requestScope.menu.lvl1MenuPath}" /></h2>
        <div class="area_h3 area_h3_AB deco_h3_4 mq_tablet">
            <p>복잡한 홈페이지 회원가입 절차없이 <abbr title="Social Network Service">SNS</abbr> 계정으로 인증 및 로그인하여<br />Open API 등의 서비스를 편리하게 이용하실 수 있습니다.</p>
        </div>
        <section class="section_socialLog">
            <h4 class="ty_A mq_mobile"><c:out value="${requestScope.menu.lvl1MenuPath}" /></h4>
            <p class="p_tyB">원하시는 소셜서비스를 선택해 주세요.</p>
            <ul class="socialLog">
            <li><a href="#naver" class="naver oauth-login-button" titile="새창열림">네이버로 로그인</a></li>
            <li><a href="#google" class="google oauth-login-button" titile="새창열림">구글로 로그인</a></li>
            <li><a href="#kakao" class="kakaotalk oauth-login-button" titile="새창열림">카카오톡으로 로그인</a></li>
            <li><a href="#facebook" class="facebook oauth-login-button" titile="새창열림">페이스북으로 로그인</a></li>
            <li><a href="#twitter" class="twitter oauth-login-button" titile="새창열림">트위터로 로그인</a></li>
            </ul>
            <p class="p_tyB">복잡한 회원가입 절차없이 SNS 계정으로 인증 및 로그인하여<br/>Open API 등의 서비스를 편리하게 이용하실 수 있습니다.</p>
        </section>
    </div>
    <!-- // content -->
</div>
<!-- // layout_flex -->
</div></div>        
<!-- // wrap_layout_flex -->
</div></div>       
<%@ include file="/WEB-INF/jsp/portal/sect/footer.jsp" %>
</div>
<!-- // layout_A -->
</body>
</html>