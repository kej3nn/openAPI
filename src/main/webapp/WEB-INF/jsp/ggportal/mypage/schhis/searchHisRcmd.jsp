<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>

<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ 	--%>
<%-- 마이페이지 > 검색연혁 및 추천정보 
<%-- 
<%-- @author jhkim
<%-- @version 1.0 2019/11/26
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ 	--%>
<!DOCTYPE html>
<html lang="ko">
<head>
<!-- head include -->
<%@ include file="/WEB-INF/jsp/portal/sect/head.jsp" %>
</head>
<body>

<!-- header html -->
<%@ include file="/WEB-INF/jsp/portal/sect/header.jsp" %>
<div class="container" id="container">
<!-- leftmenu -->
<%@ include file="/WEB-INF/jsp/portal/sect/lnb.jsp" %>
<!-- //leftmenu -->

<!-- contents -->
	<div class="contents" id="contents">
		<div class="contents-title-wrapper">
			<h3>검색연혁 및 추천정보<span class="arrow"></span></h3>
        </div>

<div class="layout_flex">

    <!-- content -->
    <div class="layout_flex_100">
		<div class="area_h3 area_h3_AB deco_h3_3">
			<form id="searchForm" method="post">
			<input type="hidden" name="page" value="${param.page}">
			<input type="hidden" name="rows" value="5">
			<div>
				<section>
		            <h4 class="ty_A mgTm10_mq_mobile">검색연혁</h4>
		            <div class="mypage_searchHistory">
			            <div class="theme_select_box">
			            <table>
			            <caption>검색어,검색일자</caption>
			            <colgroup>
			            <col style="">
			            <col style="width:60px;">
			            </colgroup>
			            <thead>
			            	<tr>
			            		<th scope="row">검색어</th>
			            		<th scope="row">검색일자</th>
			            	</tr>
			            </thead>
			            <tbody id="search-list-sect"></tbody>
			            </table>
			            </div>
			            <div class="mypage_keyword">
			            	<div>
				            	<strong>연관검색어</strong>
				            	<div>
				            		<ul id="rel-list-sect">
				            			<li class="center">검색어를 선택하세요.</li>
				            		</ul>
				            	</div>
			            	</div>
			            </div>
			            <!-- search-pager-sect -->
			            <!-- 
			            <div id="" class="mypage_paging">
			            	<div class="paging-navigation">
								<strong class="page-number">1</strong>
								<a href="#" class="number page-number">2</a>
								<a href="#" class="number page-number">3</a>
								<a href="#" class="btn-next btn_page_next" title="다음 5페이지 이동"><strong>다음 5페이지 이동</strong></a>
								<a href="#" class="btn-last btn_page_last last" title="마지막페이지 이동"><strong>마지막페이지 이동</strong></a>
							</div>
						</div> -->
						<div id="search-pager-sect" class="mypage_paging"></div>
		            </div>
		        </section>
			</div>
			</form>
			
			<form id="hidden-search-form" method="post" action="/portal/search/searchPage.do">
				<input type="hidden" name="query" value="">
			</form>
		</div>

	</div>
	<!-- // content -->
</div>
<!-- // layout_flex #################### -->
</div></div>

<!-- footer -->
<%@ include file="/WEB-INF/jsp/portal/sect/footer.jsp" %>
<script type="text/javascript" src="<c:url value="/js/ggportal/myPage/schhis/searchHisRcmd.js" />"></script>
</body>
</html>