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
<script type="text/javascript" src="<c:url value="/js/ggportal/myPage/myPage.js" />"></script>
<style type="text/css">
a { cursor:pointer;}
</style>
</head>
<body>
<!-- layout_A -->
<div class="layout_A">
<%@ include file="/WEB-INF/jsp/portal/sect/header.jsp" %>
<!-- wrap_layout_flex -->
<div class="wrap_layout_flex"><div class="layout_flex_100">
<!-- layout_flex #################### -->
<div class="layout_flex">
<!-- leftmenu -->
<%@ include file="/WEB-INF/jsp/portal/sect/lnb.jsp" %>
<!-- //leftmenu -->
    <!-- content -->
    <div id="content" class="content">
        <h2 class="hide"><c:out value="${requestScope.menu.lvl1MenuPath}" /></h2>
		<div class="area_h3 area_h3_AB area_h3_AC deco_h3_4">
			<h3 class="ty_A"><span>정보공개포털</span><strong>마이페이지</strong></h3>
			<p><strong><strong>${sessionScope.portalUserNm}</strong>님 환영합니다.</p>
		</div>
        
        <section>
			<h4 class="ty_A">통계스크랩 <span class="num">(<strong id="totalCnt-scrap">0</strong>)</span></h4>
			<div class="area_btn_D">
				<a class="btn_D btn_D_more" id="scrap-page-btn" href="#">더보기</a>
			</div>
			<table id="scrap-data-table" class="table_boardList_A table_boardList_AB  mgTm10_mq_mobile">
			<caption>나의 질문내역 목록</caption>
			<colgroup>
				<col style="width:13%;"/>
				<col style="width:43%;"/> 
				<col style="width:15%;"/>
				<col style="width:18%;"/>
				<col style="width:11%;"/>
			</colgroup>
			<thead>
			<tr>
				<th scope="col">통계구분</th>
				<th scope="col">통계자료명</th>
				<th scope="col">조회구분</th>
				<th scope="col">등록일</th>
				<th scope="col">조회</th>
			</tr>
			</thead>
			<tbody>
			<tr><td colspan="5" class="noData">해당 자료가 없습니다.</td></tr>
			</tbody>
			</table>
		</section>
		
		<section>
			<h4 class="ty_A mgTm10_mq_mobile">인증키 발급 내역 <span class="num">(<strong id="totalCnt-0">0</strong>)</span></h4>
			<div class="area_btn_D">
				<a class="btn_D" id="actKey-insertpage-btn" href="#">인증키 발급</a>
				<a class="btn_D btn_D_more" id="actKey-page-btn" href="#">더보기</a>
			</div>
			<!-- PC, tablet -->
			<!-- <table id="actkey-data-table" class="table_boardList_A table_boardList_AB  mgTm10_mq_mobile"> -->
			<table class="table_boardList_A table_boardList_AB mq_tablet">
			<caption>인증키 발급내역</caption>
			<colgroup>
				<col style="width:33%;"/>
				<col style="width:36%;"/>
				<col style="width:14%;"/>
				<col style="width:9%;"/>
				<col style="width:8%;"/>
			</colgroup>
			<thead>
			<tr>
				<th scope="col">인증키</th>
				<th scope="col">활용용도</th>
				<th scope="col">발급일</th>
				<th scope="col">호출건수</th>
				<th scope="col">사용여부</th>
			</tr>
			</thead>
			<tbody id="actkey-list">
			</tbody>
			</table>
			<!-- // PC, tablet -->
			<!-- mobile -->
			<ul class="list_board_A mq_mobile" id="actkey-list-mob">
			</ul>
			<!-- // mobile -->
		</section>
		<section>
			<h4 class="ty_A">나의 질문 내역 <span class="num">(<strong id="totalCnt-1">0</strong>)</span></h4>
			<div class="area_btn_D">
				<a class="btn_D" id="qna-insertpage-btn" href="#">질문 작성하기</a>
				<a class="btn_D btn_D_more" id="qna-page-btn" href="#">더보기</a>
			</div>
			<table id="qna-data-table" class="table_boardList_A table_boardList_AB  mgTm10_mq_mobile">
			<caption>나의 질문내역 목록</caption>
			<colgroup>
				<col style="width:8%;"/>
				<col style="width:65%;"/> 
				<col style="width:10%;"/>
				<col style="width:10%;"/>
				<col style="width:7%;"/>
			</colgroup>
			<thead>
			<tr>
				<th scope="col">No</th>
				<th scope="col">제목</th>
				<th scope="col">작성일</th>
				<th scope="col">답변상태</th>
				<th scope="col">조회수</th>
			</tr>
			</thead>
			<tbody>
			<tr><td colspan="5" class="noData">해당 자료가 없습니다.</td></tr>
			</tbody>
			</table>
		</section>
		<section>
			<h4 class="ty_A mgTm10_mq_mobile">활용갤러리 <span class="num">(<strong id="totalCnt-2">0</strong>)</span></h4>
			<div class="area_btn_D">
				<a class="btn_D" id="gallery-insertpage-btn" href="#">활용갤러리 등록</a>
				<a class="btn_D btn_D_more" id="gallery-page-btn" href="#">더보기</a>
			</div>
			<div class="wrap_list_D wrap_list_DB">
			<ul id="gallery-data-list" class="list_D">
            	<li class="noData">해당 자료가 없습니다.</li>
            </ul>
			</div>
		</section>
<!-- 		<section> -->
<!-- 			<h4 class="ty_A mgTm10_mq_mobile">데이터 관련 소식 <span class="num">(<strong id="totalCnt-3">0</strong>)</span></h4> -->
<!-- 			<div class="area_btn_D"> -->
<!-- 				<a class="btn_D" id="blog-insertpage-btn">데이터 관련 소식 등록</a> -->
<!-- 				<a class="btn_D btn_D_more" id="blog-page-btn">더보기</a> -->
<!-- 			</div> -->
<!-- 			<div class="wrap_list_D wrap_list_DB"> -->
<!-- 			<ul id="blog-data-list" class="list_D"> -->
<!--             	<li class="noData">해당 자료가 없습니다.</li> -->
<!--             </ul> -->
<!-- 			</div> -->
<!-- 		</section> -->
		<form id="search-form" name="search-form" method="post">
            <input type="hidden" name="bbsCd" value="" />
            <input type="hidden" name="seq" value="" />
            <input type="hidden" name="noticeYn" value="" />
            <input type="hidden" name="tabIdx" value="" />
		</form>
	</div>
	<!-- // content -->
</div>
<!-- // layout_flex #################### -->
</div></div>		
<!-- // wrap_layout_flex ############################## -->
<%@ include file="/WEB-INF/jsp/portal/sect/footer.jsp" %>
</div>
<!-- // layout_A -->
</body>
</html>