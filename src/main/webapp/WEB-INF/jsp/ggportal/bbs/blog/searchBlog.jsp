<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%-- @(#)searchGallery.jsp 1.0 2015/06/15                                   --%>
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

<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%-- 갤러리 게시판 내용을 검색하는 화면이다.                                --%>
<%--                                                                        --%>
<%-- @author 김은삼                                                         --%>
<%-- @version 1.0 2015/06/15                                                --%>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<!DOCTYPE html>
<html lang="ko">
<head>
<%@ include file="/WEB-INF/jsp/ggportal/sect/head.jsp" %>
<script type="text/javascript" src="<c:url value="/js/ggportal/bbs/blog/searchBlog.js" />"></script>
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
    <%@ include file="/WEB-INF/jsp/ggportal/bbs/board/sect/lnb.jsp" %>
    <!-- content -->
    <div id="content" class="content">
        <%@ include file="/WEB-INF/jsp/ggportal/sect/navigation.jsp" %>
        <h2 class="hide"><c:out value="${requestScope.menu.lvl1MenuPath}" /></h2>
        <div class="area_h3 area_h3_AB deco_h3_2">
            <c:choose>
            <c:when test="${data.bbsCd == 'BLOG'}">
            <h3 class="ty_A"><span>공공데이터 </span><img src="<c:url value="/img/ggportal/desktop/communication/h3_2_8.png" />" alt="<c:out value="${requestScope.menu.lvl2MenuPath}" />" /><strong><c:out value="${requestScope.menu.lvl2MenuPath}" /></strong></h3>
            </c:when>
            </c:choose>
            <p><c:out value="${data.bbsExp}" escapeXml="false" /></p>
        </div>
         <ul class="search search_AC">
            <li class="ty_BB">
				<ul class="ty_A mq_tablet">
                    <li>전체 <strong id="qna-count-sect" class="totalNum">12</strong>건, <span id="qna-pages-sect" class="pageNum">(<strong>1</strong>/2 page)</span></li>
                </ul>
            </li>
            </ul>
        <form>
        <!-- // tab_AB -->
        <div class="area_btn_AC mq_tablet">
            <a href="#" class="btn_AC gallery-insert-button">데이터 관련 소식 등록</a>
        </div>
        <!-- 목록 -->
        <section class="tab_AB_cont">
            <h4 class="hide" id="nowStatusNm">데이터 관련 소식 전체 목록</h4>
            <div class="wrap_list_D type2">
            <ul id="gallery-data-list" class="list_D">
            	<li>해당자료가 없습니다.</li>
            </ul>
            </div>
            <fieldset>
            <legend><c:out value="${requestScope.menu.lvl2MenuPath}" /> 검색</legend>
            <div class="search_B search_BB">
                <span class="select">
                    <select id="gallery-searchtype-combo" title="검색 분류 선택">
                        <option value="">전체</option>
                        <option value="bbsTit">제목</option>
                        <%--
                        <option value="bbsCont">내용</option>
                        --%>
                        <option value="userNm">작성자</option>
                        <%--
                        <option value="bbsTit+bbsCont">제목+내용</option>
                        --%>
                        <option value="bbsTit+userNm">제목+작성자</option>
                    </select>
                </span>
                <span class="search">
                    <input type="search" id="gallery-searchword-field" autocomplete="on" placeholder="검색" title="검색" style="ime-mode:active;" /><a id="gallery-search-button" href="#" class="btn_search"><span>검색</span></a>
                </span>
            </div>
            </fieldset>
            <!-- page -->
            <div id="gallery-pager-sect" class="page"></div>
            <!-- // page -->
        </section>
        <!-- // 목록 -->
        <div class="area_btn_AC mq_mobile">
            <a href="#" class="btn_AC gallery-insert-button">데이터 관련 소식 등록하기</a>
        </div>
        </form>
        <form id="gallery-search-form" name="gallery-search-form" method="post">
            <input type="hidden" name="page" value="<c:out value="${param.page}" default="1" />" />
            <input type="hidden" name="rows" value="<c:out value="${param.rows}" default="${data.listCnt}" />" />
            <input type="hidden" name="bbsCd" value="<c:out value="${param.bbsCd}" default="${data.bbsCd}" />" />
            <input type="hidden" name="listSubCd" value="<c:out value="${param.listSubCd}" default="" />" />
            <input type="hidden" name="searchType" value="<c:out value="${param.searchType}" default="" />" />
            <input type="hidden" name="searchWord" value="<c:out value="${param.searchWord}" default="" />" />
            <input type="hidden" name="seq" value="<c:out value="${param.seq}" default="" />" />
            <input type="hidden" name="noticeYn" value="<c:out value="${param.noticeYn}" default="" />" />
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