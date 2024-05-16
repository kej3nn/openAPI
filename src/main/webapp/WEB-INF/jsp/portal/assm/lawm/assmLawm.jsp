<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%-- 국회의원 입법활동 화면 - 탭			                   
<%-- 
<%-- @author JHKIM
<%-- @version 1.0 2019/10/16
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<!DOCTYPE html>
<html lang="ko">
<head>
<%@ include file="/WEB-INF/jsp/portal/sect/head.jsp" %>
<!-- jquery chart plugin [high charts] -->
<script type="text/javascript" src="<c:url value="/js/common/highcharts/highstock.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/common/highcharts/highcharts-more.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/common/highcharts/highcharts-3d.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/common/highcharts/modules/exporting.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/common/highcharts/modules/data.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/common/highcharts/modules/drilldown.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/common/highcharts/modules/treemap.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/common/highcharts/modules/sunburst.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/common/highcharts/modules/map.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/common/highcharts/modules/data.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/lodash.min.js" />"></script>
<style type="text/css">
/* 페이징 네비게이션 */
.paging-navigation {
	clear: both; 
	text-align: center; 
	padding-bottom: 0;
	margin-top: 35px;
}

.paging-navigation a {
	display: inline-block; 
	line-height: 35px; 
	min-width: 29px; 
	height: 35px; 
	padding: 0 3px;
	color: #4c4c50;
	border: 1px solid #c5c7cc; 
	vertical-align: middle; 
	background: #fff;
}
.paging-navigation a:hover {
	border: 1px solid #636363; 
	color: #fff;
	background: #636363;
	text-decoration: none;
}
.paging-navigation strong {
	display: inline-block; 
	line-height: 35px; 
	min-width: 29px; 
	height: 35px; 
	padding: 0 3px; 
	border: 1px solid #636363; 
	color: #fff; 
	vertical-align: middle;
	background: #636363;
}
.paging-navigation a.btn-first {
	width: 35px;
	padding: 0;
	text-indent: -5000em;
	background: transparent url(/images/btn_first.gif) no-repeat center center;
	background: -webkit-linear-gradient(transparent, transparent), url(/images/btn_first@2x.gif) no-repeat center center;
	background: linear-gradient(transparent, transparent), url(/images/btn_first@2x.gif) no-repeat center center;
	background-size: 12px 10px;
}
.paging-navigation a.btn-pre {
	width: 35px;
	padding: 0;
	text-indent: -5000em; 
	background: transparent url(/images/btn_previous.gif) no-repeat center center;
	background: -webkit-linear-gradient(transparent, transparent), url(/images/btn_previous@2x.gif) no-repeat center center;
	background: linear-gradient(transparent, transparent), url(/images/btn_previous@2x.gif) no-repeat center center;
	background-size: 6px 10px;
}
.paging-navigation a.btn-next {
	width: 35px;
	padding: 0;
	text-indent: -5000em; 
	background: transparent url(/images/btn_next.gif) no-repeat center center;
	background: -webkit-linear-gradient(transparent, transparent), url(/images/btn_next@2x.gif) no-repeat center center;
	background: linear-gradient(transparent, transparent), url(/images/btn_next@2x.gif) no-repeat center center;
	background-size: 6px 10px;
}
.paging-navigation a.btn-last {
	width: 35px;
	padding: 0;
	text-indent: -5000em; 
	background: transparent url(/images/btn_last.gif) no-repeat center center;
	background: -webkit-linear-gradient(transparent, transparent), url(/images/btn_last@2x.gif) no-repeat center center;
	background: linear-gradient(transparent, transparent), url(/images/btn_last@2x.gif) no-repeat center center;
	background-size: 12px 10px;
}
</style>
</head>
<body>
<div class="tab_B mt30" id="lawm-tab-btn">
	<a href="javascript:;" class="on" data-bindForm="degt">대표발의법률안</a>
	<a href="javascript:;" data-bindForm="clbo">공동발의법률안</a>
	<a href="javascript:;" data-bindForm="vote">${unitNm } 표결현황</a>
</div>
<!-- 대표발의 법률안 -->
<%@ include file="/WEB-INF/jsp/portal/assm/lawm/lawmDegtMotnLgsb.jsp" %>
<!-- //대표발의 법률안 -->
			
<!-- 공동발의 법률안 -->
<%@ include file="/WEB-INF/jsp/portal/assm/lawm/lawmClboMotnLgsb.jsp" %>
<!-- //공동발의 법률안 -->

<!-- 표결현황 -->
<%@ include file="/WEB-INF/jsp/portal/assm/lawm/lawmVoteCond.jsp" %>
<!-- //표결현황 -->

<script type="text/javascript" src="<c:url value="/js/portal/assm/lawm/assmLawm.js" />"></script>
</body>
</html>