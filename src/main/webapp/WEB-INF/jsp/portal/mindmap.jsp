<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%-- @(#)mindmap.jsp 1.0 2019/11/23											--%>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%-- 마인드맵 팝업 화면이다.
<%--
<%-- @author Softon
<%-- @version 1.0 2019/11/23
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<!DOCTYPE html>
<html lang="ko">
<head>
<%@ include file="/WEB-INF/jsp/portal/sect/head.jsp" %>
<!--  Mind Map -->
<link rel="stylesheet" type="text/css" href="<c:url value="/css/portal/default.css" />" />
<link rel="stylesheet" type="text/css" href="<c:url value="/css/portal/notokr.css" />" />
<link rel="stylesheet" type="text/css" href="<c:url value="/css/portal/layout.css" />" />
<link rel="stylesheet" type="text/css" href="<c:url value="/css/component/Jit/Spacetree.css" />" />
<link rel="stylesheet" type="text/css" href="<c:url value="/css/component/Jit/style.css" />" />
<%-- 
<script type="text/javascript">
    var getContextPath = "<c:out value="${pageContext.request.contextPath}" />";
</script>
<script type="text/javascript" src="<c:url value="/js/jquery/jquery-2.2.4.min.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/common/component/jquery.fittext.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/jquery/jquery-ui.min.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/jquery/json.min.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/jquery/jquery.form.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/common/Jit/jit.custom.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/common/Jit/mindMap_data.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/common/Jit/script.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/common/base/commonness.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/common/base/delegation.js" />"></script> --%>
<script type="text/javascript">
$(function() {
	startMindMap();
	loadMindMap();
});

</script>
</head>
<body>
<div class="mindmap_popup" id="global-mindmap-sect">
	<div class="main_mindmap" style="width:98%; height:98%">
		<div class="mindmap_header">
			<span>국회를 열다, 정보를 나누다.</span>
		</div>
		<div id="global-mindmap-obj" style="display:block;width:100%; height:100%;"></div>
		<a href="javascript: gfn_hideMindmap();" class="btn_mindmap_close">close</a>
	</div>
	<div class="bgshadow"></div>
</div>

</body>
</html>