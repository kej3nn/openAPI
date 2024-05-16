<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%-- @(#)selectMap.jsp 1.0 2015/06/15                                       --%>
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
<%-- 공공데이터 맵 서비스를 조회하는 화면이다.                              --%>
<%--                                                                        --%>
<%-- @author 김은삼                                                         --%>
<%-- @version 1.0 2015/06/15                                                --%>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<!DOCTYPE html>
<html lang="ko">
<head>
<c:set var="title" value="${data.infNm}" />
<c:set var="description" value="${fn:replace(data.infExp, constants.LINE_FEED, '')}" />
<c:set var="lvl3MenuSuffix" value= "지도" />
<%@ include file="/WEB-INF/jsp/portal/sect/head.jsp" %>

<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=c70dd25cb435fbd63f9e0fc6587302d5&libraries=services,clusterer,drawing"></script>
<script type="text/javascript" src="<c:url value="/js/ggportal/data/service/selectMap.js" />"></script>
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
<div class="wrap_layout_flex">
<div class="layout_flex_100">
<!-- layout_flex -->
<div class="layout_flex">
    <!-- content -->
    <div class="content_B">
		<a href="#none" id="content" class="hide">본문시작</a>
        <h2 class="hide"><c:out value="${requestScope.menu.lvl1MenuPath}" /></h2>
        <c:if test="${empty param.loc}" >
        	<h3 class="ty_B"><strong><c:out value="${requestScope.menu.lvl2MenuPath}" /></strong></h3>
        </c:if>
		<c:if test="${not empty param.loc}" >
			<h3 class="ty_B">위치기반 데이터 찾기</h3>
		</c:if>
        <%@ include file="/WEB-INF/jsp/ggportal/data/service/sect/meta.jsp" %>
        <%@ include file="/WEB-INF/jsp/ggportal/data/service/sect/tabs.jsp" %>
        
         <form id="dataset-search-form" name="dataset-search-form" method="post">
         	<input type="hidden" name="version" value="<c:out value="${param.version}" default="2" />" />
            <input type="hidden" name="page" value="<c:out value="${param.page}" default="1" />" />
            <input type="hidden" name="rows" value="<c:out value="${param.rows}" default="10" />" />
            <input type="hidden" name="infId" value="<c:out value="${param.infId}" default="" />" />
            <input type="hidden" name="infSeq" value="<c:out value="${param.infSeq}" default="" />" />
            <input type="hidden" name="order" value="<c:out value="${param.order}" default="" />" />
            <input type="hidden" name="loc" value="<c:out value="${param.loc}" default="" />" />
            <c:forEach items="${paramValues}" var="parameter">
            <c:set var="key" value="${parameter.key}" />
            <c:if test="${key == 'orgCd' || key == 'cateId' || key == 'srvCd' || key == 'infTag' || key == 'searchWord'}">
            <c:forEach items="${parameter.value}" var="value">
            <input type="hidden" name="${key}" value="${value}" />
            </c:forEach>
            </c:if>
            </c:forEach>
            
            <div id="map-search-sect" class="hide">
	            <fieldset style="padding-top: 30px;">
	            <legend>검색</legend>
	            <a href="#none" class="toggle_search_C">
					검색 <img src="<c:url value="/img/ggportal/desktop/common/toggle_open_search_C.png" />" alt="" />
	            </a>
	            <div id="search_C" class="close_search_C">
	                <table id="map-search-table" class="table_search_C width_A">
	                <caption>검색</caption>
	                </table>
	                <span class="area_btn_search_C"><a id="map-search-button" href="#none" class="btn_A">필터검색</a></span>
	            </div>
	            </fieldset>
            </div>
        </form>
        
        <!-- Map -->
        <section class="section_map">
            <h4 class="hide">Map</h4>
            
            <p class="kbUserGuid" style="text-align: right;">* 키보드 사용자는 좌측에 있는 Sheet 메뉴를 이용하시면 동일한 정보를 보실 수 있습니다.</p>
            <div class="area_map">
                <div id="map-object-sect" style="width: 100%; height: 480px;">
                	<div class="markerLegend" id="legendArea" style="display: none;"></div>
                </div>
            </div>
            <div style="padding: 2px;">
            	<span id="marker-desc"></span>
            </div>
        </section>
        <!-- // Map -->

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
        
        <form id="map-search-form" name="map-search-form" method="post">
            <input type="hidden" name="infId" value="<c:out value="${param.infId}" default="" />" />
            <input type="hidden" name="infSeq" value="<c:out value="${param.infSeq}" default="" />" />
            <input type="hidden" name="loc" value="<c:out value="${param.loc}" default="" />" />
            <input type="hidden" id="searchCd" value=""/>
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