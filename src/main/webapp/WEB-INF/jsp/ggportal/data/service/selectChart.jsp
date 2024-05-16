<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%-- @(#)selectChart.jsp 1.0 2015/06/15                                     --%>
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

<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%-- 공공데이터 차트 서비스를 조회하는 화면이다.                            --%>
<%--                                                                        --%>
<%-- @author 김은삼                                                         --%>
<%-- @version 1.0 2015/06/15                                                --%>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<!DOCTYPE html>
<html lang="ko">
<head>
<c:set var="title" value="${data.infNm}" />
<c:set var="description" value="${fn:replace(data.infExp, constants.LINE_FEED, '')}" />
<c:set var="lvl3MenuSuffix" value= "차트" />
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
<%-- <script type="text/javascript" src="<c:url value="/js/ggportal/data/service/jquery.fileDownload.js" />"></script> --%>
<script type="text/javascript" src="<c:url value="/js/ggportal/data/service/selectChart.js" />"></script>

</head>
<body>
<!-- layout_A -->
<div class="layout_A">
<%@ include file="/WEB-INF/jsp/portal/sect/header.jsp" %>

<div class="container hide-pc-lnb" id="container">
<!-- contents -->
	<div class="contents" id="contents">
		<div class="contents-title-wrapper">
			<h3>정보공개<span class="arrow"></span></h3>
		</div>
		
<!-- wrap_layout_flex -->
<div class="wrap_layout_flex"><div class="layout_flex_100">
<!-- layout_flex -->
<div class="layout_flex">
    <!-- content -->
    <div id="content" class="content_B">
        <h2 class="hide"><c:out value="${requestScope.menu.lvl1MenuPath}" /></h2>
        <h3 class="ty_B"><strong><c:out value="${requestScope.menu.lvl2MenuPath}" /></strong></h3>
        <%@ include file="/WEB-INF/jsp/ggportal/data/service/sect/meta.jsp" %>
        <%@ include file="/WEB-INF/jsp/ggportal/data/service/sect/tabs.jsp" %>
        <!-- Chart -->
        <form id="chart-search-form" name="chart-search-form" action="#" method="post">
        <input type="hidden" name="infId" value="<c:out value="${data.infId}" default="" />" />
        <input type="hidden" name="infSeq" value="<c:out value="${data.infSeq}" default="" />" />
        <input type="hidden" name="downloadType" value="<c:out value="${param.downloadType}" default="" />" />
        <fieldset>
        <legend>Chart 검색</legend>
        <section class="section_chart">
            <h4 class="hide">Chart</h4>
            <!-- search -->
            <div id="chart-search-sect" class="hide">
            <a href="#none" class="toggle_search_C">
                검색 <img src="<c:url value="/img/ggportal/desktop/common/toggle_open_search_C.png" />" alt="" />
            </a>
            <div id="search_C" class="close_search_C">
                <table id="chart-search-table" class="table_search_C width_A">
                <caption>검색</caption>
                </table>
                <span class="area_btn_search_C"><a id="chart-search-button" href="#" class="btn_A">필터검색</a></span>
            </div>
            </div>
            <!-- // search -->
            <ul class="search search_AB">
            <li class="ty_B">

                <div class="chartarea">
                	<div class="toparea">
		                <div class="chartMenu">
							<button class="cBasic" type="button" name="chartBasic" title="기본차트" style="display:none;"><img src="<c:url value="/images/soportal/chart/charbtn19on.png" />" alt="기본차트"/></button>								
							<button class="cBasic" type="button" name="chartSpline" title="라인" style="display:none;"><img src="<c:url value="/images/soportal/chart/charbtn04.png" />" alt="라인"/></button>										
							<button class="cBasic" type="button" name="chartLine" title="스톡라인" style="display:none;"><img src="<c:url value="/images/soportal/chart/charbtn05.png" />" alt="스톡라인"/></button>										
							<button class="cBasic" type="button" name="chartArea" title="누적라인" style="display:none;"><img src="<c:url value="/images/soportal/chart/charbtn06.png" />" alt="누적라인"/></button>										
							<button class="cBasic" type="button" name="chartHbar" title="막대" style="display:none;"><img src="<c:url value="/images/soportal/chart/charbtn07.png" />" alt="막대"/></button>										
							<button class="cBasic" type="button" name="chartWbar" title="가로막대" style="display:none;"><img src="<c:url value="/images/soportal/chart/charbtn10.png" />" alt="가로막대"/></button>
							
							<button class="cPie" type="button" name="chartPie" title="파이" style="display:none;"><img src="<c:url value="/images/soportal/chart/charbtn13.png" />" alt="파이"/></button>
							<button class="cPie" type="button" name="chartDonut" title="도넛" style="display:none;"><img src="<c:url value="/images/soportal/chart/charbtn14.png" />" alt="도넛"/></button>
															
							<button type="button" name="chartDownload" title="차트다운로드"><img src="<c:url value="/images/soportal/chart/charbtn18.png" />" alt="차트다운로드"/></button>
							  <div class="dropdown-content" style="display:none">
							    <ul>
							    	<li><a href="javascript:;" name="chartPng" title="PNG"><span>PNG </span> 다운로드</a></li>
								    <li><a href="javascript:;" name="chartJpeg" title="JPEG"><span>JPEG </span> 다운로드</a></li>
								    <li><a href="javascript:;" name="chartPdf" title="PDF"><span>PDF </span> 다운로드</a></li>
								    <li><a href="javascript:;" name="chartSvg" title="SVG"><span>SVG </span> 다운로드</a></li>
							    </ul>
							  </div>
						</div>

					</div>
				</div>

            </li>
            </ul>
            <div class="area_chart">
                <div id="chart-object-sect" class="chart"></div>
            </div>
        </section>

        <!-- btn_A -->
        <div class="area_btn_A">
        	<c:choose>
            <c:when test="${isInfsPop eq 'Y' }">
            	<a href="#" class="btn_A" onclick="javascript: window.close();">목록</a>
            </c:when>
            <c:otherwise>
            	<a id="dataset-search-button" href="#" class="btn_A">목록</a>
            </c:otherwise>
            </c:choose>
        </div>
        
					<!-- 추천 데이터 셋 -->
					<!-- 숨김처리
					<div class="recommendDataset">
						<dl>
							<dt>연관 데이터셋</dt>
							<dd>
								<div class="dataSet">
									<div class="btn_slide">
										<a href="#none" class="prev" id="dataset_prev" title="이전 갤러리 이동">이전</a>
										<a href="#none" class="next" id="dataset_next" title="다음 갤러리 이동">다음</a>
									</div>

									<ul class="dataSetSlider bxslider">

									</ul>
									
								</div>
							</dd>
						</dl>
					</div> -->
					<!-- // 추천 데이터 셋 -->
        
        
        <!-- // btn_A -->
        </fieldset>
        </form>
        <!-- // Chart -->
        <form id="dataset-search-form" name="dataset-search-form" method="post">
            <input type="hidden" name="page" value="<c:out value="${param.page}" default="1" />" />
            <input type="hidden" name="rows" value="<c:out value="${param.rows}" default="10" />" />
            <input type="hidden" name="infId" value="<c:out value="${param.infId}" default="" />" />
            <input type="hidden" name="infSeq" value="<c:out value="${param.infSeq}" default="" />" />
            <input type="hidden" name="order" value="<c:out value="${param.order}" default="" />" />
            <c:forEach items="${paramValues}" var="parameter">
            <c:set var="key" value="${parameter.key}" />
            <c:if test="${key == 'orgCd' || key == 'cateId' || key == 'srvCd' || key == 'infTag' || key == 'searchWord'}">
            <c:forEach items="${parameter.value}" var="value">
            <input type="hidden" name="${key}" value="${value}" />
            </c:forEach>
            </c:if>
            </c:forEach>
        </form>
        
        <form id="searchForm">
        	<c:if test="${empty param.infId}">
        		<input type="hidden" name="infId" value="${infId }">
        	</c:if>
        	<c:if test="${not empty param.infId}">
        		<input type="hidden" name="infId" value="${param.infId}">
        	</c:if>
        	<input type="hidden" name="infSeq" value="${param.infSeq}">
			<c:forEach var="entry" items="${schParams}">
				<c:forEach var="value" items="${entry.value}">
					<input type="hidden" name="${entry.key }" value="${value }">
				</c:forEach>
			</c:forEach>
			<c:forEach var="entry" items="${schHdnParams}">
				<c:forEach var="value" items="${entry.value}">
					<input type="hidden" name="${entry.key }" value="${value }">
				</c:forEach>
			</c:forEach>
		</form>
    </div>
    <!-- // content -->
</div>
<!-- // layout_flex -->
</div></div>        
<!-- // wrap_layout_flex -->

</div>
</div>

<%@ include file="/WEB-INF/jsp/portal/sect/footer.jsp" %>
</div>
<!-- // layout_A -->
</body>
</html>