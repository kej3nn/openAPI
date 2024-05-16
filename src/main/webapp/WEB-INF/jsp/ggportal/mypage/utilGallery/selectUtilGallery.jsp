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

<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%-- 마이페이지 > 활용갤러리 > 조회                      --%>
<%--                                                                        --%>
<%-- @author 장홍식                                                         --%>
<%-- @version 1.0 2015/08/17                                                --%>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<!DOCTYPE html>
<html lang="ko">
<head>
<%@ include file="/WEB-INF/jsp/portal/sect/head.jsp" %>
<script type="text/javascript" src="<c:url value="/js/ggportal/myPage/utilGallery/selectUtilGallery.js" />"></script>
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
			<h3><c:out value="${requestScope.menu.lvl2MenuPath}" /><span class="arrow"></span></h3>
		</div>
<!-- wrap_layout_flex -->
<div class="wrap_layout_flex fix_page">
<div class="layout_flex_100">
<!-- layout_flex -->
<div class="layout_flex">
    <!-- content -->
	<%@ include file="/WEB-INF/jsp/ggportal/mypage/sect/left.jsp" %>
    <!-- content -->
    <div id="content" class="content">
        <h2 class="hide"><c:out value="${requestScope.menu.lvl1MenuPath}" /></h2>
		<div class="area_h3 area_h3_AB area_h3_AC deco_h3_4">
			<p> <strong>${sessionScope.portalUserNm}</strong>님 환영합니다.</p>
		</div>
        <form id="gallery-select-form" name="gallery-select-form" method="post">
        <input type="hidden" name="bbsCd" />
        <input type="hidden" name="seq" />
		<input type="hidden" name="cateId" title="cateId" value="<c:out value="${param.cateId}" default="" />">
		<input type="hidden" name="cateNm" title="cateNm" value="<c:out value="${param.cateNm}" default="" />">
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
						<div class="make_grade" style="display: none;">
							<a href="#none" class="toggle_grade gallery-grade-combo">
								<img src="<c:url value="/img/ggportal/desktop/common/grade_s_1.png"/>" alt="총점 5점 중 평점 1점 아주 나쁨" />
								<img src="<c:url value="/img/ggportal/desktop/common/toggle_open_grade.png"/>" id="toggle_grade" alt="" />
							</a>
							<ul id="view_grade" class="view_grade" style="display:none;">
							<li><a href="#" class="gallery-grade-option"><img src="<c:url value="/img/ggportal/desktop/common/grade_s_1.png"/>" alt="총점 5점 중 평점 1점 아주 나쁨" /></a></li>
							<li><a href="#" class="gallery-grade-option"><img src="<c:url value="/img/ggportal/desktop/common/grade_s_2.png"/>" alt="총점 5점 중 평점 2점 나쁨" /></a></li>
							<li><a href="#" class="gallery-grade-option"><img src="<c:url value="/img/ggportal/desktop/common/grade_s_3.png"/>" alt="총점 5점 중 평점 3점 보통" /></a></li>
							<li><a href="#" class="gallery-grade-option"><img src="<c:url value="/img/ggportal/desktop/common/grade_s_4.png"/>" alt="총점 5점 중 평점 4점 좋음" /></a></li>
							<li><a href="#" class="gallery-grade-option"><img src="<c:url value="/img/ggportal/desktop/common/grade_s_5.png"/>" alt="총점 5점 중 평점 5점 아주 좋음" /></a></li>
							</ul>
						</div>
						<a href="#" class="btn_make_grade gallery-grade-button" style="display: none;">OK</a>
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
            <a href="#" id="gallery-search-button" class="btn_A">목록</a>
			<a href="#" id="gallery-update-button" class="btn_A">수정</a>
			<a href="#" id="gallery-delete-button" class="btn_AB">삭제</a>
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

</div>
</div>
   
<%@ include file="/WEB-INF/jsp/portal/sect/footer.jsp" %>
</div>
<!-- // layout_A -->
</body>
</html>