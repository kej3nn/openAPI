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

<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%-- 공공데이터 시트 서비스를 조회하는 화면이다.                            --%>
<%--                                                                        --%>
<%-- @author 김은삼                                                         --%>
<%-- @Modifiers 장홍식                                                         --%>
<%-- @version 1.0 2015/08/06                                              --%>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<!DOCTYPE html>
<html lang="ko">
<head>
<c:set var="title" value="${data.infNm}" />
<c:set var="description" value="${fn:replace(data.infExp, constants.LINE_FEED, '')}" />
<c:set var="lvl3MenuSuffix" value= "Sheet" />
<%@ include file="/WEB-INF/jsp/ggportal/sect/head.jsp" %>
<script type="text/javascript" src="<c:url value="/js/ggportal/data/service/jquery.fileDownload.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/ggportal/data/service/selectChart.js" />"></script>
<script type="text/javascript">

// history.pushState(null, null, location.href); 
// window.onpopstate = function(event) { 
	//history.go(1); 
	//searchDataset();
// }

/**
 * 우리 지역 찾기 목록 화면으로 이동
 */
function searchDataset() {
    // 데이터를 검색하는 화면으로 이동한다.
    goSearch({
        url:"/portal/data/village/selectListDataByCityPage.do",
        form:"dataset-search-form"
    });
}

</script>
</head>
<body>
<!-- layout_A -->
<div class="layout_A">
<%@ include file="/WEB-INF/jsp/ggportal/sect/header.jsp" %>
<!-- wrap_layout_flex -->
<div class="wrap_layout_flex"><div class="layout_flex_100">
<%@ include file="/WEB-INF/jsp/ggportal/sect/gnb.jsp" %>

<!-- layout_flex #################### -->
<div class="layout_flex">
	<div id="content" class="content_B">
		<!-- location -->
        <%@ include file="/WEB-INF/jsp/ggportal/sect/navigation.jsp" %>
        <h2 class="hide"><c:out value="${requestScope.menu.lvl1MenuPath}" /></h2>
		<div class="area_h3 area_h3_AB area_h3_AC deco_h3_1">
			<h3 class="ty_A"><img src="<c:url value="/img/ggportal/desktop/data/h3_1_3.png"/>" alt="우리 지역 데이터 찾기" /><strong>우리 지역 데이터 찾기</strong></h3>
			<p>지도 기반으로 우리 지역 관련 공공데이터를 손쉽게 찾으실 수 있습니다.</p>
		</div>
        <%@ include file="/WEB-INF/jsp/ggportal/data/village/service/sect/meta.jsp" %>
        <%@ include file="/WEB-INF/jsp/ggportal/data/village/service/sect/tabs.jsp" %>
        <!-- Chart -->
        <form id="chart-search-form" name="chart-search-form" action="#" method="post">
        <input type="hidden" name="infId" value="<c:out value="${param.infId}" default="" />" />
        <input type="hidden" name="infSeq" value="<c:out value="${param.infSeq}" default="" />" />
        <input type="hidden" name="downloadType" value="<c:out value="${param.downloadType}" default="" />" />
        <input type="hidden" name="sigunFlag" value="<c:out value="${param.sigunFlag}" default="" />" />
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
                <dl id="chart-search-table-series" class="flL">
                <dt><label for="series">시리즈</label></dt>
                <dd>
                    <select id="series" name="colNm" class="chart-series-combo" title="차트 시리즈 선택">
                    </select>
                </dd>
                <dt><label for="chartType">차트유형</label></dt>
                <dd>
                    <select id="chartType" name="seriesCd" class="chart-types-combo" title="차트 유형 선택">
                    </select>
                </dd>
                </dl>
                <dl class="flR mq_tablet">
                <dt><label for="series">파일변환저장</label></dt>
                <dd>
                    <a id="chart-excel-button" href="#" class="btn_D">XLS</a>
                    <a id="chart-csv-button" href="#" class="btn_D">CSV</a>
                    <a id="chart-json-button" href="#" class="btn_D">JSON</a>
                    <a id="chart-xml-button" href="#" class="btn_D">XML</a>
                    <a id="chart-txt-button" href="#" class="btn_D">TXT</a>
                </dd>
                </dl>
            </li>
            </ul>
            <div class="area_chart">
                <div id="chart-object-sect" class="chart"></div>
            </div>
        </section>

        <!-- btn_A -->
        <div class="area_btn_A">
            <a id="dataset-search-button" href="#" class="btn_A">목록</a>
        </div>
        <!-- // btn_A -->
        </fieldset>
        </form>
        <!-- // Chart -->
        <form id="dataset-search-form" name="dataset-search-form" method="post">
            <input type="hidden" name="page" value="<c:out value="${param.page}" default="1" />" />
            <input type="hidden" name="rows" value="<c:out value="${param.rows}" default="10" />" />
            <input type="hidden" name="infId" value="<c:out value="${param.infId}" default="" />" />
            <input type="hidden" name="infSeq" value="<c:out value="${param.infSeq}" default="" />" />
            <c:forEach items="${paramValues}" var="parameter">
            <c:set var="key" value="${parameter.key}" />
            <c:if test="${key == 'orgCd' || key == 'cateId' || key == 'srvCd' || key == 'infTag' || key == 'searchWord' || key == 'sigunFlag'}">
            <c:forEach items="${parameter.value}" var="value">
            <input type="hidden" name="${key}" value="${value}" />
            </c:forEach>
            </c:if>
            </c:forEach>
        </form>
    </div>
    <!-- // content -->
</div>
<!-- // layout_flex -->
</div></div>        
<!-- // wrap_layout_flex -->
<%@ include file="/WEB-INF/jsp/ggportal/sect/footer.jsp" %>

<%@ include file="/WEB-INF/jsp/ggportal/data/village/popup/map.jsp" %>
</div>
<!-- // layout_A -->
</body>
</html>