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
<%-- 마이페이지 > 활용갤러리                      --%>
<%--                                                                        --%>
<%-- @author 장홍식                                                         --%>
<%-- @version 1.0 2015/08/11                                                --%>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<!DOCTYPE html>
<html lang="ko">
<head>
<%@ include file="/WEB-INF/jsp/portal/sect/head.jsp" %>
<script type="text/javascript" src="<c:url value="/js/ggportal/myPage/utilGallery/searchUtilGallery.js" />"></script>
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
	<%@ include file="/WEB-INF/jsp/ggportal/mypage/sect/left.jsp" %>
    <!-- content -->
    <div id="content" class="content">
        <h2 class="hide"><c:out value="${requestScope.menu.lvl1MenuPath}" /></h2>
        <div class="area_h3 area_h3_AB area_h3_AC deco_h3_4">
			<p><strong>${sessionScope.portalUserNm}</strong>님 환영합니다.</p>
		</div>
        <form>
		<section>
            <h4 class="hide">활용갤러리 목록</h4>
			<ul class="search search_AC">
			<li class="ty_BB">
				<ul class="ty_A mq_tablet">
					<li class="mq_tablet">전체 <strong id="gallery-count-sect" class="totalNum"></strong>건, <span id="gallery-pages-sect" class="pageNum"></span></li>
				</ul>
			</li>
			</ul>
			<div class="area_btn_AC mq_tablet">
		            <a href="" class="btn_AC gallery-insert-button">활용사례  등록</a>
			</div>
			
			
			
			<table id="qna-data-table" class="table_boardList_A table_boardList_AB  mgTm10_mq_mobile">
			<caption>활용사례 : 활용구분, 제목, 상태, 처리일자</caption>
			<colgroup>
				<col style="width:15%;"/> 
				<col style="width:60%;"/>
				<col style="width:15%;"/>
				<col style="width:20%;"/>
			</colgroup>
			<thead>
			<tr>
				<th scope="col">활용구분</th>
				<th scope="col">제목</th>
				<th scope="col">상태</th>
				<th scope="col">처리일자</th>
			</tr>
			</thead>
			<tbody id="gallery-data-list" class="list_D mypage_new">
			</tbody>
			</table>
			<!-- <div class="wrap_list_D wrap_list_DC">
				<ul class="list_D" id="gallery-data-list">
				</ul>
			</div> -->
			
			
            <!-- page -->
            <div id="gallery-pager-sect" class="page"></div>
            <!-- // page -->
		</section>
		<div class="area_btn_AC  mq_mobile">
			<a href="#" class="btn_AC gallery-insert-button">활용갤러리 등록</a>
		</div>
		</form>
        <form id="gallery-search-form" name="gallery-search-form" method="post">
            <input type="hidden" name="page" value="<c:out value="${param.page}" default="1" />" />
            <input type="hidden" name="rows" value="<c:out value="${param.rows}" default="${data.listCnt}" />" />
            <input type="hidden" name="bbsCd" value="<c:out value="${param.bbsCd}" default="${data.bbsCd}" />" />
            <input type="hidden" name="listSubCd" value="<c:out value="${param.listSubCd}" default="" />" />
            <input type="hidden" name="list1SubCd" value="<c:out value="${param.list1SubCd}" default="" />" />
            <input type="hidden" name="searchType" value="<c:out value="${param.searchType}" default="" />" />
            <input type="hidden" name="searchWord" value="<c:out value="${param.searchWord}" default="" />" />
            <input type="hidden" name="seq" value="<c:out value="${param.seq}" default="" />" />
            <input type="hidden" name="noticeYn" value="<c:out value="${param.noticeYn}" default="" />" />
            <input type="hidden" name="cateId" title="cateId" value="<c:out value="${param.cateId}" default="" />">
			<input type="hidden" name="cateNm" title="cateNm" value="<c:out value="${param.cateNm}" default="" />">
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