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
<c:set var="lvl3MenuSuffix" value= "Map" />
<%@ include file="/WEB-INF/jsp/ggportal/sect/head.jsp" %>
<script type="text/javascript" src="//apis.daum.net/maps/maps3.js?apikey=73583d2598ddbea63004823759193e67"></script>
<script type="text/javascript" src="<c:url value="/js/ggportal/data/service/selectMap.js" />"></script>
<script type="text/javascript">

// history.pushState(null, null, location.href); 
// window.onpopstate = function(event) { 
// 	//history.go(1); 
// 	searchDataset();
// }

var isFirst = true;
/**
 * 우리 지역 찾기 목록 화면으로 이동
 */
function searchDataset() {
    goSearch({
        url:"/portal/data/village/selectListDataByCityPage.do",
        form:"dataset-search-form"
    });
}

/**
 * 공공데이터 맵 서비스 메타정보 조회 전처리를 실행한다.
 * 
 * @param options {Object} 옵션
 * @returns {Object} 데이터
 */
function beforeSelectMapMeta(options) {
	 
    var data = {
        // Nothing do do.
    };
    
    var form = $("#map-search-form");

    $.each(form.serializeArray(), function(index, element) {
        switch (element.name) {
            case "infId":
            case "infSeq":
                data[element.name] = element.value;
                break;
            case "sigunFlag":
                data[element.name] = element.value;
            
        }
    });
    
    if (com.wise.util.isBlank(data.infId)) {
        return null;
    }
    if (com.wise.util.isBlank(data.infSeq)) {
        return null;
    }
    
    return data;
}

/**
 * 공공데이터 맵 서비스 데이터 검색 전처리를 실행한다.
 * 
 * @param options {Object} 옵션
 * @returns {Object} 데이터
 */
function beforeSearchMapData(options) {
    var data = {
        // Nothing do do.
    };
    
    var form = $("#map-search-form");
    
    $.each(form.serializeArray(), function(index, element) {
        switch (element.name) {
            case "infId":
            case "infSeq":
                data[element.name] = element.value;
                break;
            case "sigunFlag":
                data[element.name] = element.value;
                break;
        }
    });
    
    if (com.wise.util.isBlank(data.infId)) {
        return null;
    }
    if (com.wise.util.isBlank(data.infSeq)) {
        return null;
    }
    
    var bounds = map.getBounds();
    
    var sw = bounds.getSouthWest();
    
    var ne = bounds.getNorthEast();
    
    data.Y_WGS84_FROM = sw.getLat();
    data.Y_WGS84_TO   = ne.getLat();
    data.X_WGS84_FROM = sw.getLng();
    data.X_WGS84_TO   = ne.getLng();
    
    return data;
}

 /**
  * 공공데이터 맵 서비스 데이터 검색 후처리를 실행한다.
  * 
  * @param data {Object} 데이터
  */
 function afterSearchMapData(data) {
	  
 	if(isFirst && data.length == 0) {
 		//alert("조회된 데이터가 없습니다.");
     	//history.back(0);
     	return false;
 	}
 	isFirst = false;
 	
    // 맵 마커를 초기화한다.
    initMapMarkers();
    
    // 맵 데이터를 로드한다.
    loadMapData(data);
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
<!-- layout_flex -->
<div class="layout_flex">
    <!-- content -->
    <div id="content" class="content_B">
        <%@ include file="/WEB-INF/jsp/ggportal/sect/navigation.jsp" %>
        <h2 class="hide"><c:out value="${requestScope.menu.lvl1MenuPath}" /></h2>
		<div class="area_h3 area_h3_AB area_h3_AC deco_h3_1">
			<h3 class="ty_A"><img src="<c:url value="/img/ggportal/desktop/data/h3_1_3.png"/>" alt="우리 지역 데이터 찾기" /><strong>우리 지역 데이터 찾기</strong></h3>
			<p>지도 기반으로 우리 지역 관련 공공데이터를 손쉽게 찾으실 수 있습니다.</p>
		</div>
        <%@ include file="/WEB-INF/jsp/ggportal/data/village/service/sect/meta.jsp" %>
        <%@ include file="/WEB-INF/jsp/ggportal/data/village/service/sect/tabs.jsp" %>
        <form id="map-search-form" name="map-search-form" method="post">
            <input type="hidden" name="infId" value="<c:out value="${param.infId}" default="" />" />
            <input type="hidden" name="infSeq" value="<c:out value="${param.infSeq}" default="" />" />
            <input type="hidden" name="sigunFlag" value="<c:out value="${param.sigunFlag}" default="" />" />
        </form>
        <!-- Map -->
        <section class="section_map">
            <h4 class="hide">Map</h4>
            <div class="area_map">
                <div id="map-object-sect" class="map">
                </div>
            </div>
            <div style="min-height: 22px; padding: 2px;">
            	<span id="marker-desc"></span>
            </div>
        </section>
        <!-- // Map -->
        <!-- btn_A -->
        <div class="area_btn_A">
            <a id="dataset-search-button" href="#" class="btn_A">목록</a>
        </div>
        <!-- // btn_A -->
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