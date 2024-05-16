<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
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

<jsp:useBean id="constants" class="egovframework.common.base.constants.GlobalConstants" />

<!DOCTYPE html>
<html lang="ko">
<head>
<c:set var="title" value="${meta.vistnNm}" />
<c:set var="description" value="${fn:replace(meta.vistnSrvDesc, constants.LINE_FEED, '')}" />
<%@ include file="/WEB-INF/jsp/ggportal/sect/head.jsp" %>
<style type="text/css">
a {cursor:pointer;}
</style>
<script type="text/javascript" src="<c:url value="/js/ggportal/data/visual/selectVisual.js" />"></script>
</head>
<body>
<!-- layout_A -->
<div class="layout_A">
<%@ include file="/WEB-INF/jsp/ggportal/sect/header.jsp" %>
<!-- wrap_layout_flex -->
<div class="wrap_layout_flex fix_page"><div class="layout_flex_100">
<%@ include file="/WEB-INF/jsp/ggportal/sect/gnb.jsp" %>

<!-- layout_flex -->
<div class="layout_flex">
<%-- 
	<aside class="area_LNB">
        <%@ include file="/WEB-INF/jsp/ggportal/sect/snb.jsp" %>
    </aside>
     --%>
    <!-- content -->
    <div id="content" class="content_B">
        <%@ include file="/WEB-INF/jsp/ggportal/sect/navigation.jsp" %>
        <h2 class="hide"><c:out value="${requestScope.menu.lvl1MenuPath}" /></h2>
		<div class="area_h3 area_h3_AC deco_h3_1">
			<h3 class="ty_A"><span>공공데이터 개방포털</span><img src="<c:url value="/img/ggportal/desktop/data/h3_1_4.png"/>" alt="데이터 시각화" /><strong>데이터 시각화</strong></h3>
			<p>다양한 시각화 차트와 인포그래픽으로 데이터를 알기 쉽게 풀어줍니다.</p>
		</div>
        <form id="visual-select-form" name="visual-select-form" method="post">
		<section class="section_dataVisualization_detail">
			<input type="hidden" name="url" value="${data.url }"/>
			<h4 class="hide">데이터 시각화 상세</h4>
			<!-- 상세 요약 -->
			<div class="detail_summary w_1">
				<div class="summary">
					<strong class="tit visualNm"></strong>
					<span class="cont visualCont"></span>
					<dl class="ty_B">
					<dt>제작자</dt>
					<dd class="userNm"></dd>
					<dt>등록일</dt>
					<dd class="userDttm"></dd>
					<dt>시각화 유형</dt>
					<dd class="visualType"></dd>
					</dl>
				</div>
			</div>
			<!-- // 상세 요약 -->
			<table class="table_datail_B w_1">
			<caption>데이터 시각화 상세</caption>
			<tr>
				<td class="cont" id="chart_dataVisualization"><!-- 
					<div class="area_chart_dataVisualization">
						<div class="chart_dataVisualization">
						</div>
					</div> -->
				</td>
			</tr>
			</table>
		</section>
		</form>
		<div class="area_btn_A">
			<a class="btn_A" id="visual-search-btn">목록</a>
			<a class="btn_A w_100 w_120_mq_mobile" id="visual-dataset-btn" style="display:none;">상세데이터 보기</a>
		</div>
        <form id="visual-search-form" name="visual-search-form" method="post">
            <input type="hidden" name="page" value="<c:out value="${param.page}" default="1" />" />
            <input type="hidden" name="rows" value="8" />
            <input type="hidden" name="vistnSrvSeq" value="<c:out value="${param.vistnSrvSeq}" default="" />" />
            <input type="hidden" name="vistnCd" value="<c:out value="${param.vistnCd}" default="" />" />
            <input type="hidden" name="tabIdx" value="<c:out value="${param.tabIdx}" default="" />"/>
        </form>
        <form id="dataset-select-form" name="dataset-select-form" method="post">
        	<input type="hidden" name="infId" value=""/>
        	<input type="hidden" name="infSeq" value=""/>
        </form>
	</div>
	<!-- // content -->
</div>
<!-- // layout_flex -->
</div></div>        
<!-- // wrap_layout_flex -->
<%@ include file="/WEB-INF/jsp/ggportal/sect/footer.jsp" %>
</div>
<!-- // layout_A -->
</body>
</html>