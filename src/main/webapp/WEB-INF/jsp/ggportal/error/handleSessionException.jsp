<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%-- @(#)handleSessionException.jsp 1.0 2015/05/05                          --%>
<%--                                                                        --%>
<%-- COPYRIGHT (C) 2013 WISEITECH CO., LTD. ALL RIGHTS RESERVED.            --%>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%-- 세션 오류를 처리하는 화면이다.                                         --%>
<%--                                                                        --%>
<%-- @author 김은삼                                                         --%>
<%-- @version 1.0 2015/05/05                                                --%>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<c:choose>
<c:when test="${!empty requestScope['ibuseragent']}">
{
    "Result":{
        "Code":-2,
        "Message":"<c:out value="${exception.message}" />"
    }
}
</c:when>
<c:when test="${!empty requestScope['X-Requested-With'] && 
					(requestScope['X-Requested-With'] != 'com.nhn.android.search' 
					&& requestScope['X-Requested-With'] != 'net.daum.android.daum' 
					&& requestScope['X-Requested-With'] != 'com.android.browser')
					}">
{
    "error":{
        "code":"<c:out value="${exception.code}" />",
        "message":"<c:out value="${exception.message}" />"
    }
}
</c:when>
<c:when test="${requestScope['responseType'] == 'json'}">
{
    "error":{
        "code":"<c:out value="${exception.code}" />",
        "message":"<c:out value="${exception.message}" />"
    }
}
</c:when>
<c:otherwise>
<jsp:forward page="/portal/user/loginPage.do" />
<%--
<c:choose>
<c:when test="${exception.code == 'portal.error.000051'}">
<jsp:forward page="/portal/user/oauth/registerPage.do" />
</c:when>
<c:otherwise>
<jsp:forward page="/portal/user/oauth/authorizePage.do" />
</c:otherwise>
</c:choose> --%>
</c:otherwise>
</c:choose>