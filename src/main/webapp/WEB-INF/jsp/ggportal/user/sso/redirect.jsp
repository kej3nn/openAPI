<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%-- SSO 리다이렉트를 처리하는 화면이다.                                    --%>
<%--                                                                        --%>
<%-- @author jhkim                                                         --%>
<%-- @version 1.0 2019/12/01                                                --%>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<!DOCTYPE html>
<html lang="ko">
<head>
<c:choose>
<c:when test="${not empty errMsg}">
<script>
alert("${errMsg}");
location.href = "/portal/mainPage.do";
</script>
</c:when>
<c:otherwise>
<script>
location.href = "/portal/mainPage.do";
</script>
</c:otherwise>
</c:choose>
</body>
</html>