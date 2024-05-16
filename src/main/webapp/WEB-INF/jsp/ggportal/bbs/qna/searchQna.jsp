<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%-- @(#)searchQna.jsp 1.0 2015/06/15                                       --%>
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
<%-- Q&A 게시판 내용을 검색하는 화면이다.                                   --%>
<%--                                                                        --%>
<%-- @author 김은삼                                                         --%>
<%-- @version 1.0 2015/06/15                                                --%>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<!DOCTYPE html>
<html lang="ko">
<head>
<%@ include file="/WEB-INF/jsp/portal/sect/head.jsp" %>
<script type="text/javascript" src="<c:url value="/js/ggportal/bbs/qna/searchQna.js" />"></script>
</head>
<body>
<!-- layout_A -->
<div class="layout_A">
<c:choose>
<c:when test="${fn:indexOf(requestScope.uri, '/portal/bbs/qnaapi/') >= 0}">
<%@ include file="/WEB-INF/jsp/portal/sect/headerOpen.jsp" %>
</c:when>
<c:otherwise>
<%@ include file="/WEB-INF/jsp/portal/sect/header.jsp" %>
</c:otherwise>
</c:choose>
<div class="container" id="container">
<!-- leftmenu -->
<%@ include file="/WEB-INF/jsp/portal/sect/lnb.jsp" %>
<!-- //leftmenu -->

<!-- contents -->
	<div class="contents" id="contents">
		<div class="contents-title-wrapper">
			<c:choose>
	            <c:when test="${data.bbsCd == 'QNA01'}">
	            <h3><c:out value="${requestScope.menu.lvl2MenuPath}" /><span class="arrow"></span></h3>
	            </c:when>
	            <c:when test="${data.bbsCd == 'QNAAPI'}">
	            <h3><c:out value="${requestScope.menu.lvl3MenuPath}" /><span class="arrow"></span></h3>
	            </c:when>
            </c:choose>
		</div>
<!-- wrap_layout_flex -->
<div class="wrap_layout_flex fix_page"><div class="layout_flex_100">
<!-- layout_flex -->
<div class="layout_flex">
    <!-- content -->
    <div id="content" class="content">
        <h2 class="hide"><c:out value="${requestScope.menu.lvl1MenuPath}" /></h2>
        <form>
        <section>
            <h4 class="hide"><c:out value="${requestScope.menu.lvl3MenuPath}" /></h4>
            <ul class="search search_AC">
            <li class="ty_BB">
                <ul class="ty_A mq_tablet">
                    <li>전체 <strong id="qna-count-sect" class="totalNum"></strong>건, <span id="qna-pages-sect" class="pageNum"></span></li>
                </ul>
            </li>
            </ul>
            <div class="area_btn_AC mq_tablet">
            	<c:choose>
	            <c:when test="${data.bbsCd == 'QNA01' or data.bbsCd == 'QNAAPI'}">
	            <a href="#" class="btn_qwrite qna-insert-button">질문 작성하기</a>
	            </c:when>
	            <c:when test="${data.bbsCd == 'IDEA'}">
	            <a href="#" class="btn_AC qna-insert-button">아이디어 작성하기</a>
	            </c:when>
	            </c:choose>
            </div>
            <table id="qna-data-table" class="table_boardList_A table_boardList_AB mgTm10_mq_mobile">
            <caption>Q&A_No,제목,작성자,작성일,답변상태,조회수</caption>
            <colgroup>
                <col style="width:8%;" />
                <col style="width:54%;" /> 
                <col style="width:9%;" />
                <col style="width:10%;" />
                <col style="width:10%;" />
                <col style="width:9%;" />
            </colgroup>
            <thead>
            <tr>
                <th scope="col">No</th>
                <th scope="col">제목</th>
                <th scope="col">작성자</th>
                <th scope="col">작성일</th>
                <th scope="col">답변상태</th>
                <th scope="col">조회수</th>
            </tr>
            </thead>
            <tbody>
            <tr>
                <td colspan="6" class="noData">해당 자료가 없습니다.</td>
            </tr>
            </tbody>
            </table>
            <fieldset>
            <legend><c:out value="${requestScope.menu.lvl2MenuPath}" /> 검색</legend>
            <div class="search_B search_BB">
                <span class="select">
                    <select id="qna-searchtype-combo" title="검색 분류 선택">
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
                    <input type="search" id="qna-searchword-field" autocomplete="on" placeholder="검색" title="검색" style="ime-mode:active;" /><a id="qna-search-button" href="#" class="btn_search"><span>검색</span></a>
                </span>
            </div>
            </fieldset>
            <!-- page -->
            <div id="qna-pager-sect" class="page"></div>
            <!-- // page -->
        </section>
        <!-- // 목록 -->
        <div class="area_btn_AC  mq_mobile">
            <c:choose>
            <c:when test="${data.bbsCd == 'QNA01'}">
            <a href="#" class="btn_AC qna-insert-button">질문 작성하기</a>
            </c:when>
            <c:when test="${data.bbsCd == 'IDEA'}">
            <a href="#" class="btn_AC qna-insert-button">아이디어 작성하기</a>
            </c:when>
            </c:choose>
        </div>
        </form>
        <form id="qna-search-form" name="qna-search-form" method="post">
            <input type="hidden" name="page" value="<c:out value="${ param.page }" default="1" />" />
            <input type="hidden" name="rows" value="<c:out value="${ param.rows }" default="${data.listCnt}" />" />
            <input type="hidden" name="bbsCd" value="<c:out value="${ param.bbsCd }" default="${data.bbsCd}" />" />
            <input type="hidden" name="listSubCd" value="<c:out value="${ param.listSubCd }" default="" />" />
            <input type="hidden" name="searchType" value="<c:out value="${ param.searchType }" default="" />" />
            <input type="hidden" name="searchWord" value="<c:out value="${ param.searchWord }" default="" />" />
            <input type="hidden" name="seq" value="<c:out value="${ param.seq }" default="" />" />
            <input type="hidden" name="noticeYn" value="<c:out value="${ param.noticeYn }" default="" />" />
        </form>
    </div>
    <!-- // content -->
</div>
<!-- // layout_flex -->
</div></div>        
<!-- // wrap_layout_flex -->

</div>
</div>

<%@ include file="/WEB-INF/jsp/ggportal/sect/password.jsp" %>
<%@ include file="/WEB-INF/jsp/portal/sect/footer.jsp" %>
</div>
<!-- // layout_A -->
</body>
</html>