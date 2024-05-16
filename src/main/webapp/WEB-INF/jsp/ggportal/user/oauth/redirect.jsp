<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%-- @(#)redirect.jsp 1.0 2015/06/15                                        --%>
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
<%-- 리다이렉트를 처리하는 화면이다.                                        --%>
<%--                                                                        --%>
<%-- @author 김은삼                                                         --%>
<%-- @version 1.0 2015/06/15                                                --%>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<!DOCTYPE html>
<html lang="ko">
<head>
<%@ include file="/WEB-INF/jsp/ggportal/sect/head.jsp" %>
<script type="text/javascript">
    var reload = true;
</script>
<c:if test="${empty error}">
<c:if test="${requestScope.revokeType == 'script'}">
<c:choose>
<c:when test="${requestScope.revokeMethod == 'resource'}">
<script type="text/javascript" src="<c:out value="${requestScope.revokeUrl}" escapeXml="false" />"></script>
</c:when>
<c:when test="${requestScope.revokeMethod == 'function'}">
<c:choose>
<c:when test="${requestScope.revokeUrl == 'Kakao'}">
<script type="text/javascript" src="<c:url value="/js/ggportal/kakao.min.js" />"></script>
<script type="text/javascript">
    reload = false;
    
    $(function() {
        Kakao.init("<c:out value="${requestScope.revokeArgs.client_id}" />");
        Kakao.Auth.logout(function(data) {
            // 화면을 리로드한다.
            reloadPage();
        });
    });
</script>
</c:when>
<c:when test="${requestScope.revokeUrl == 'FB'}">
<script type="text/javascript">
    reload = false;
    
    window.fbAsyncInit = function() {
        FB.init({
            appId:"<c:out value="${requestScope.revokeArgs.client_id}" />",
            xfbml:true,
            version:"v2.3"
        });
        FB.getLoginStatus(function(response) {
        	/*
            FB.logout(function(response) {
                // 화면을 리로드한다.
                reloadPage();
            });
			*/
			if ( !response.session ) {
				// 화면을 리로드한다.
				reloadPage();
			} else {
				FB.logout(function(response) {
                    // 화면을 리로드한다.
					reloadPage();
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
<script type="text/javascript">
    var session = {
        userCd:"<c:out value="${sessionScope.portalUserCd}" />",
        userId:"<c:out value="${sessionScope.portalUserId}" />",
        userNm:"<c:out value="${sessionScope.portalUserNm}" />",
        userEmail:"<c:out value="${sessionScope.portalUserEmail}" />",
        userTel:"<c:out value="${sessionScope.portalUserTel}" />",
        agreeYn:"<c:out value="${sessionScope.portalAgreeYn}" />",
        contSiteCd:"<c:out value="${sessionScope.portalContSiteCd}" />",
        contSiteNm:"<c:out value="${sessionScope.portalContSiteNm}" />",
        providerName:"<c:out value="${sessionScope.portalProviderName}" />"
    };
</script>
</c:if>
<script type="text/javascript" src="<c:url value="/js/ggportal/user/oauth/redirect.js" />"></script>
</head>
<body>
<c:if test="${!empty error}">
<script type="text/javascript">
    (function() {
        alert("<c:out value="${error.message}" />");
    })();
</script>
</c:if>
</body>
</html>