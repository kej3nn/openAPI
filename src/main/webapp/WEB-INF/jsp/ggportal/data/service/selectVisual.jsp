<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%-- @(#)selectLink.jsp 1.0 2015/06/15                                      --%>
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
<%-- 공공데이터 시각화 서비스를 조회하는 화면이다.                            --%>
<%--                                                                        --%>
<%-- @author 김은삼                                                         --%>
<%-- @version 1.0 2015/06/15                                                --%>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<!DOCTYPE html>
<html lang="ko">
<head>
<c:set var="title" value="${data.infNm}" />
<c:set var="description" value="${fn:replace(data.infExp, constants.LINE_FEED, '')}" />
<c:set var="lvl3MenuSuffix" value= "링크" />
<%@ include file="/WEB-INF/jsp/portal/sect/head.jsp" %>
<script type="text/javascript" src="<c:url value="/js/ggportal/data/service/selectVisual.js" />"></script>

<script type="text/javascript">
// 	history.pushState(null, null, location.href); 
// 	window.onpopstate = function(event) { 
// 		//history.go(1); 
// 		searchDataset();
// 	}
</script>
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
        <form id="visual-search-form" name="visual-search-form" method="post">
            <input type="hidden" name="infId" value="<c:out value="${data.infId}" default="" />" />
            <input type="hidden" name="infSeq" value="<c:out value="${data.infSeq}" default="" />" />
        </form>
        <!-- 시각화 -->
        <section class="section_link">
            <h4 class="hide">시각화</h4>
            <div class="area_link">
                <div id="visual-thumbnail-sect" class="link"></div>
            </div>
            <ul id="visual-data-list" class="list_A">
            <li class="noData">해당 자료가 없습니다.</li>
            </ul>
        </section>
        <!-- // 시각화 -->

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