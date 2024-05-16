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
<%-- 마이페이지 > 통계스크랩 							                     --%>
<%--                                                                        --%>
<%-- @author 김정호                                                         --%>
<%-- @version 1.0 2017/12/12                                                --%>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<!DOCTYPE html>
<html lang="ko">
<head>
<%@ include file="/WEB-INF/jsp/ggportal/sect/head.jsp" %>
<script type="text/javascript" src="<c:url value="/js/ggportal/myPage/statScrap/searchStatScrap.js" />"></script>
</head>
<body>
<!-- layout_A -->
<div class="layout_A">
<%@ include file="/WEB-INF/jsp/ggportal/sect/header.jsp" %>
<!-- wrap_layout_flex -->
<div class="wrap_layout_flex fix_page"><div class="layout_flex_100">
<%@ include file="/WEB-INF/jsp/ggportal/sect/gnb.jsp" %>
<!-- layout_flex #################### -->
<div class="layout_flex">
	<%@ include file="/WEB-INF/jsp/ggportal/mypage/sect/left.jsp" %>
    <!-- content -->
    <div id="content" class="content">
        <%@ include file="/WEB-INF/jsp/ggportal/sect/navigation.jsp" %>
        <h2 class="hide"><c:out value="${requestScope.menu.lvl1MenuPath}" /></h2>
		<div class="area_h3 area_h3_AB area_h3_AC deco_h3_4">
			<h3 class="ty_A"><span>국회 나눔데이터</span><strong>통계스크랩</strong></h3>
			<p> <strong>${sessionScope.portalUserNm}</strong>님 환영합니다.</p>
		</div>
        <form>
		<section>
			<h4 class="hide">통계스크랩 목록</h4>
			<ul class="search search_AC">
			<li class="ty_BB">
				<ul class="ty_A mq_tablet">
					<li>전체 <strong id="scrap-count-sect" class="totalNum"></strong>건, <span id="scrap-pages-sect" class="pageNum"></span></li>
				</ul>
			</li>
			</ul>
			<!-- <div class="area_btn_AC mq_tablet">
				<a href="" class="btn_AC qna-insert-button">질문 작성하기</a>
			</div> -->
			<table id="scrap-data-table" class="table_boardList_A table_boardList_AB  mgTm10_mq_mobile">
			<caption>통계스크랩 목록</caption>
			<colgroup>
				<col style="width:13%;"/>
				<col style="width:35%;"/> 
				<col style="width:15%;"/>
				<col style="width:18%;"/>
				<col style="width:11%;"/>
				<col style="width:8%;"/>
			</colgroup>
			<thead>
			<tr>
				<th scope="col">통계구분</th>
				<th scope="col">통계자료명</th>
				<th scope="col">조회구분</th>
				<th scope="col">등록일</th>
				<th scope="col">조회</th>
				<th scope="col">삭제</th>
			</tr>
			</thead>
			<tbody>
            <tr>
                <td colspan="6" class="noData">해당 자료가 없습니다.</td>
            </tr>
			</tbody>
			</table>
            <!-- page -->
            <div id="scrap-pager-sect" class="page"></div>
            <!-- // page -->
		</section>
        
        </form>
        <form id="scrap-search-form" name="scrap-search-form" method="post">
            <input type="hidden" name="page" value="<c:out value="${param.page}" default="1" />" />
            <input type="hidden" name="rows" value="<c:out value="${param.rows}" default="10" />" />
            <%-- 
            <input type="hidden" name="bbsCd" value="<c:out value="${param.bbsCd}" default="${data.bbsCd}" />" />
            <input type="hidden" name="listSubCd" value="<c:out value="${param.listSubCd}" default="" />" />
            <input type="hidden" name="searchType" value="<c:out value="${param.searchType}" default="" />" />
            <input type="hidden" name="searchWord" value="<c:out value="${param.searchWord}" default="" />" />
            <input type="hidden" name="seq" value="<c:out value="${param.seq}" default="" />" />
            <input type="hidden" name="noticeYn" value="<c:out value="${param.noticeYn}" default="" />" /> --%>
        </form>
	</div>
	<!-- // content -->
</div>
<!-- // layout_flex -->
</div></div>		
<!-- // wrap_layout_flex ############################## -->
<%@ include file="/WEB-INF/jsp/ggportal/sect/footer.jsp" %>
</div>
<!-- // layout_A -->
</body>
</html>