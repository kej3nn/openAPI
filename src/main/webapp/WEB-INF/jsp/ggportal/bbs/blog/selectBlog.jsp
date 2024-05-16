<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%-- @(#)selectGallery.jsp 1.0 2015/06/15                                   --%>
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
<%-- 갤러리 게시판 내용을 조회하는 화면이다.                                --%>
<%--                                                                        --%>
<%-- @author 김은삼                                                         --%>
<%-- @version 1.0 2015/06/15                                                --%>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<!DOCTYPE html>
<html lang="ko">
<head>
<%@ include file="/WEB-INF/jsp/ggportal/sect/head.jsp" %>
<script type="text/javascript" src="<c:url value="/js/ggportal/bbs/gallery/selectGallery.js" />"></script>
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
    <%@ include file="/WEB-INF/jsp/ggportal/bbs/board/sect/lnb.jsp" %>
    
    <!-- content -->
    <div id="content" class="content">
        <%@ include file="/WEB-INF/jsp/ggportal/sect/navigation.jsp" %>
        <h2 class="hide"><c:out value="${requestScope.menu.lvl1MenuPath}" /></h2>
        <div class="area_h3 deco_h3_2">
            <c:choose>
            <c:when test="${data.bbsCd == 'GALLERY'}">
            <h3 class="ty_A"><span>국회 통계관리 및 공공데이터</span><strong><c:out value="${requestScope.menu.lvl2MenuPath}" /></strong></h3>
            </c:when>
            </c:choose>
            <p><c:out value="${data.bbsExp}" escapeXml="false" /></p>
        </div>
        <form id="gallery-select-form" name="gallery-select-form" method="post">
        <!-- 상세 요약 -->
        <div class="detail_summary w_2">
            <figure class="thumbnail2">
                <figcaption>해당 서비스에 대한 thumbnail</figcaption>
                <img id="gallery-thumbnail-image" src="<c:url value="/img/ggportal/desktop/thumbnail/icon_gallery/icon_gallery_2.png" />"  alt="" />
            </figure>
            <div class="summary">
                <strong class="tit listSubNm bbsTit"></strong>
                <dl id="gallery-data-list">
                <dt>제작자</dt>
                <dd class="userNm"></dd>
                <dt>등록일</dt>
                <dd class="userDttm"></dd>
                </dl>
                <div class="area_grade clfix">
                    <div class="flL">   
                        <strong class="tit_totalGrade">총평점</strong>
                        <img src="<c:url value="/img/ggportal/desktop/common/grade_0.png" />" class="icon_grade gallery-grade-image" alt="총점 5점 중 평점 0점 아주 나쁨" />
                        <div class="make_grade">
                            <a href="#none" class="toggle_grade gallery-grade-combo">
                                <img src="<c:url value="/img/ggportal/desktop/common/grade_s_1.png" />" alt="총점 5점 중 평점 1점 아주 나쁨" />
                                <img src="<c:url value="/img/ggportal/desktop/common/toggle_open_grade.png" />" id="toggle_grade" alt="" />
                            </a>
                            <ul id="view_grade" class="view_grade" style="display:none;">
                            <li><a href="#" class="gallery-grade-option"><img src="<c:url value="/img/ggportal/desktop/common/grade_s_1.png" />" alt="총점 5점 중 평점 1점 아주 나쁨" /></a></li>
                            <li><a href="#" class="gallery-grade-option"><img src="<c:url value="/img/ggportal/desktop/common/grade_s_2.png" />" alt="총점 5점 중 평점 2점 나쁨" /></a></li>
                            <li><a href="#" class="gallery-grade-option"><img src="<c:url value="/img/ggportal/desktop/common/grade_s_3.png" />" alt="총점 5점 중 평점 3점 보통" /></a></li>
                            <li><a href="#" class="gallery-grade-option"><img src="<c:url value="/img/ggportal/desktop/common/grade_s_4.png" />" alt="총점 5점 중 평점 4점 좋음" /></a></li>
                            <li><a href="#" class="gallery-grade-option"><img src="<c:url value="/img/ggportal/desktop/common/grade_s_5.png" />" alt="총점 5점 중 평점 5점 아주 좋음" /></a></li>
                            </ul>
                        </div>
                        <a href="#" class="btn_make_grade gallery-grade-button">OK</a>
                    </div>
                </div>
            </div>
        </div>
        <!-- // 상세 요약 -->
        <section class="section_gallery_detail">
        <h4 class="hide"><c:out value="${requestScope.menu.lvl2MenuPath}" /> 상세</h4>
        <table class="table_datail_B w_1">
        <%--<caption><c:out value="${requestScope.menu.lvl2MenuPath}" /> 상세</caption>--%>
        <tr>
            <td class="cont">
            <div class="area_img_galleryDetail">
            <div class="img_galleryDetail">
                <ul id="gallery-image-list" class="imgGalleryDetail"></ul>
            </div>
            </div>
            <pre class="bbsCont"></pre>
            </td>
        </tr>
        </table>
        </section>
        </form>
        <div class="area_btn_A">
            <a id="gallery-search-button" href="#" class="btn_A">목록</a>
        </div>
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