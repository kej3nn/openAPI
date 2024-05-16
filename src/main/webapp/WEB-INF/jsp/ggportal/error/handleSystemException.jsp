<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%-- @(#)handleSystemException.jsp 1.0 2015/05/05                           --%>
<%--                                                                        --%>
<%-- COPYRIGHT (C) 2013 WISEITECH CO., LTD. ALL RIGHTS RESERVED.            --%>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%-- 시스템 오류를 처리하는 화면이다.                                       --%>
<%--                                                                        --%>
<%-- @author 김은삼                                                         --%>
<%-- @version 1.0 2015/05/05                                                --%>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<c:choose>
<c:when test="${!empty requestScope['ibuseragent']}">
{
    "Result":{
        "Code":-4,
        "Message":"시스템 오류가 발생하였습니다."
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
        "code":"portal.error.000002",
        "message":"시스템 오류가 발생하였습니다."
    }
}
</c:when>
<%-- 
<c:when test="${requestScope['responseType'] == 'json'}">
{
    "error":{
        "code":"portal.error.000002",
        "message":"시스템 오류가 발생하였습니다."
    }
}
</c:when> 
--%>
<c:otherwise>
<!DOCTYPE html>
<html lang="ko">
<head>
<%@ include file="/WEB-INF/jsp/ggportal/error/sect/head.jsp" %>
<script type="text/javascript">
    $(function() {
        alert("시스템 오류가 발생하였습니다.");
        
        if (window.parent && window.parent.jQuery && window.parent.jQuery(".layout_A").length > 0) {
            // Nothing to do.
        }
        else {
            if (window.opener && window.opener.jQuery && window.opener.jQuery(".layout_A").length > 0) {
                setTimeout(function() {
                    window.close();
                }, 2000);
            }
            else {
            	/* 
                setTimeout(function() {
                    window.location.href = "<c:url value="/" />";
                }, 2000); */
            }
        }
    });
</script>
</head>
<body>
<%@ include file="/WEB-INF/jsp/ggportal/error/sect/body.jsp" %>
</body>
</html>
</c:otherwise>
</c:choose>