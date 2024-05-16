<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%-- @(#)main.jsp 1.0 2018/01/08											--%>
<%--																		--%>
<%-- COPYRIGHT (C) 2013 WISEITECH CO., LTD. ALL RIGHTS RESERVED.			--%>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>

<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%-- 메인 화면이다.														--%>
<%--																		--%>
<%-- @author 김정호														--%>
<%-- @version 1.0 2018/01/08												--%>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<!DOCTYPE html>
<html lang="ko">
<head>
<%@ include file="/WEB-INF/jsp/portal/sect/head.jsp" %>
<!--  Mind Map -->
<link rel="stylesheet" type="text/css" href="<c:url value="/css/component/Jit/Spacetree.css" />" />
<link rel="stylesheet" type="text/css" href="<c:url value="/css/component/Jit/style.css" />" />

<script type="text/javascript" src="<c:url value="/js/ggportal/main/main.js" />"></script>
<style type="text/css">
	.contents-navigation-area{display:none;}
</style>
</head>
<body>
<!-- layout_A -->
<div class="layout_A layout_main">

<%@ include file="/WEB-INF/jsp/portal/sect/header.jsp" %>

<!-- wrap_layout_flex -->
<div class="wrap_layout_flex">
<div class="layout_flex_100">
	
	<!-- 마인드맵 -->
	<div class="main_mindmap">
		<div id="chart">xxxx</div>
	</div>
	<!-- //마인드맵 -->
	
	
	<!-- <div style="width:100%;height:1052px;background:url(/images/sample1.png) no-repeat center 0;"></div> -->
	<div style="width:100%;height:3313px;background:url(/images/sample2.png) no-repeat center 0;"></div>
	
	</div>
    </div>
    <!-- // content -->
</div>
<!-- // layout_flex -->

<div id="mainPopDiv" name="mainPopDiv" style="position:fixed; top:0px; left:0px; width:100%; height: 100%; z-index:9999999999; display:none;text-align:center;">
	<%-- <div style="position:relative;top:100px;z-index:10;display:inline-block;"><img src="<c:url value="/img/ggportal/desktop/common/opentest.png"/>" alt="loading" onclick=""></div> --%>
	<div class="bgshadow"></div>
</div>

</div></div>        
<!-- // wrap_layout_flex -->

<%@ include file="/WEB-INF/jsp/portal/sect/footer.jsp" %>

</div>
<!-- // layout_A -->
<script type="text/javascript" src="<c:url value="/js/common/Jit/jquery-latest.min.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/lodash.min.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/common/Jit/jit.custom.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/common/Jit/mindMap_data.js" />"></script>
<%-- <script type="text/javascript" src="<c:url value="/js/common/Jit/tree_data.js" />"></script> --%>
<script type="text/javascript" src="<c:url value="/js/common/Jit/script.js" />"></script>
</body>
</html>