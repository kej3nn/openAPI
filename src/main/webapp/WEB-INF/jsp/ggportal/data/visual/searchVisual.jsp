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

<!DOCTYPE html>
<html lang="ko">
<head>
<%@ include file="/WEB-INF/jsp/ggportal/sect/head.jsp" %>
<script type="text/javascript" src="<c:url value="/js/ggportal/data/visual/searchVisual.js" />"></script>
<style type="text/css">
a {cursor:pointer;}
</style>
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
	<aside class="area_LNB">
        <%@ include file="/WEB-INF/jsp/ggportal/sect/snb.jsp" %>
    </aside>
    <!-- content -->
    <div id="content" class="content">
        <%@ include file="/WEB-INF/jsp/ggportal/sect/navigation.jsp" %>
        <h2 class="hide"><c:out value="${requestScope.menu.lvl1MenuPath}" /></h2>
		<div class="area_h3 area_h3_AB area_h3_AC deco_h3_1">
			<h3 class="ty_A"><span>공공데이터 개방포털</span><img src="<c:url value="/img/ggportal/desktop/data/h3_1_4.png"/>" alt="데이터 시각화" /><strong>데이터 시각화</strong></h3>
			<p>다양한 시각화 차트와 인포그래픽으로 데이터를 알기 쉽게 풀어줍니다.</p>
		</div>
		<h4 class="hide">데이터 시각화 목록</h4>
        <!-- tab_AB -->
        <!-- 인포그래픽이 추가되면 해당 탭 주석을 해제합니다. -->
        <div class="tab_AB">
            <a class="gallery-section-tab" href="#visual-data-list">전체</a>
            <a class="gallery-section-tab" href="#visual-data-list">인포그래픽</a>
            <a class="gallery-section-tab" href="#visual-data-list">차트</a>
        </div>
        <!-- // tab_AB -->
		<div class="wrap_list_D">
		<h5 class="hide"  id="nowStatusNm">전체</h5>
		<ul class="list_D" id="visual-data-list">
		</ul>
		</div>
		
        <!-- page -->
        <div id="visual-pager-sect" class="page"></div>
		<!-- // page -->	
        <form id="visual-search-form" name="visual-search-form" method="post">
            <input type="hidden" name="page" value="<c:out value="${param.page}" default="1" />" />
            <input type="hidden" name="rows" value="8" />
            <input type="hidden" name="vistnSrvSeq" value="<c:out value="${param.vistnSrvSeq}" default="" />" />
            <input type="hidden" name="vistnCd" value="<c:if test="${not empty param.tabIdx && param.tabIdx != 0}"><c:out value="${param.vistnCd}" default="" /></c:if>"/>
            <input type="hidden" name="tabIdx" value="<c:out value="${param.tabIdx}" default="0" />"/>
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