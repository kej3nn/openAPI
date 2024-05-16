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
<%@ include file="/WEB-INF/jsp/portal/sect/head.jsp" %>
<script type="text/javascript" src="<c:url value="/js/ggportal/bbs/gallery/selectGallery.js" />"></script>
</head>
<body>
<!-- layout_A -->
<div class="layout_A">
<%@ include file="/WEB-INF/jsp/portal/sect/headerOpen.jsp" %>
<div class="container" id="container">
<!-- leftmenu -->
<%@ include file="/WEB-INF/jsp/portal/sect/lnb.jsp" %>
<!-- //leftmenu -->

<!-- contents -->
	<div class="contents" id="contents">
		<div class="contents-title-wrapper">
			<h3><c:out value="${requestScope.menu.lvl3MenuPath}" /><span class="arrow"></span></h3>
		</div>
<!-- wrap_layout_flex -->
<div class="wrap_layout_flex fix_page">
<div class="layout_flex_100">
<!-- layout_flex -->
<div class="layout_flex">
    <!-- content -->
    <div id="content" class="content">
        <h2 class="hide"><c:out value="${requestScope.menu.lvl1MenuPath}" /></h2>
        <form id="gallery-select-form" name="gallery-select-form" method="post">
			<input type="hidden" name="cateId" value="<c:out value="${param.cateId}" default="" />" />
			<input type="hidden" name="cateNm" value="<c:out value="${param.cateNm}" default="" />" />
        <!-- 상세 요약 -->
        <div class="detail_summary w_2 detail_figure detail_gallery platform_gallery_select">
            <figure class="thumbnail2">
                <figcaption>해당 서비스에 대한 thumbnail</figcaption>
                <img id="gallery-thumbnail-image" src="<c:url value="/img/ggportal/desktop/thumbnail/icon_gallery/icon_gallery_2.png" />"  alt="" />
                <div class="summary gly_txt"><span id="bunyaNm" class=""></span></div>
            </figure>
            <div class="summary gly_txt">
            	<span class="list1SubNm"></span><br>
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
            <div class="btn_sns">
	                    <a id="shareFB" href="#" title="새창열림_페이스북" class="btn_facebook">페이스북 공유</a>
	                    <a id="shareTW" href="#" title="새창열림_트위터" class="btn_twitter">트위터 공유</a>
						<a id="shareBG" href="#" title="새창열림_네이버블로그" class="sns_blog">네이버블로그</a>
						<a id="shareKS" href="#" title="새창열림_카카오스토리" class="sns_kakaostory">카카오스토리</a>
						<a id="shareKT" href="#" title="새창열림_카카오톡" class="sns_kakaotalk">카카오톡</a>
            </div>
            </div>
        </div>
        <!-- // 상세 요약 -->
        <section class="section_gallery_detail">
        <h4 class="hide"><c:out value="${requestScope.menu.lvl3MenuPath}" />상세</h4>
        <table class="table_datail_B w_1">
        <caption><c:out value="${requestScope.menu.lvl3MenuPath}" /> 상세</caption>
        <tr>
            <td class="cont">
            <div class="area_img_galleryDetail">
            <div class="img_galleryDetail">
                <ul id="gallery-image-list" class="imgGalleryDetail"></ul>
            </div>
            </div>
            <pre class="bbsCont pd70"></pre>
            </td>
        </tr>
        </table>
        </section>
        <!-- // 활용 데이터 링크 -->
        <section class="section_gallery_usedLink">
		<span><strong>활용 데이터 링크</strong></span>
        <ul id= "gallery-usedLink">
        </ul>
        </section>
        </form>
        <div class="area_btn_A">
            <a id="gallery-search-button" href="#" class="btn_A">목록</a>
        </div>
        <form id="gallery-search-form" name="gallery-search-form" method="post">
            <input type="hidden" name="bbsCd" value="<c:out value="${param.bbsCd}" default="${data.bbsCd}" />" />
            <input type="hidden" name="seq" value="<c:out value="${param.seq}" default="" />" />
            <input type="hidden" name="noticeYn" value="<c:out value="${param.noticeYn}" default="" />" />
        	
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