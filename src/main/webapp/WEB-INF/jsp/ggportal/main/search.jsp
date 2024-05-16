<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%-- @(#)search.jsp 1.0 2015/06/15                                          --%>
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
<%-- 통합 검색 화면이다.                                                    --%>
<%--                                                                        --%>
<%-- @author 김은삼                                                         --%>
<%-- @version 1.0 2015/06/15                                                --%>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<!DOCTYPE html>
<html lang="ko">
<head>
<%@ include file="/WEB-INF/jsp/ggportal/sect/head.jsp" %>
<script type="text/javascript" src="<c:url value="/js/ggportal/main/search.js" />"></script>
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
    <!-- content -->
    <div id="content" class="content_B">
        <%@ include file="/WEB-INF/jsp/ggportal/sect/navigation.jsp" %>
        <h2 class="hide"><c:out value="${requestScope.menu.lvl1MenuPath}" /></h2>
        <div class="area_h4 mq_tablet">
			<p>통합검색</p>
		</div>
        <!-- <h3 class="ty_B"><strong><c:out value="${requestScope.menu.lvl1MenuPath}" /> <span class="num">(<strong class="unified-count-sect">0</strong>)</span></strong></h3>  -->
        <div class="box_AB searchResult">
            <p class="p_tyB">검색어 &#34;<strong class="point"><c:out value="${param.searchWord}" /></strong>&#34;에 대한 <strong class="point unified-count-sect">0</strong>건이 통합 검색되었습니다.</p>
        </div>
        <!-- 공공데이터 -->
        <h4 class="ty_A  mgTm10_mq_mobile">공공데이터 <span class="num">(<strong id="dataset-count-sect" class="single-count-sect">0</strong>)</span></h4>
        <div class="area_btn_D">
            <a id="dataset-search-button" href="#" class="btn_D btn_D_more">더보기</a>
        </div>
        <table id="dataset-data-table" class="table_boardList_A mgTm10_mq_mobile">
        <caption>데이터셋 목록</caption>
        <colgroup>
            <col style="width:59%;"/> 
            <col style="width:13%;"/>
            <col style="width:11%;"/>
            <col style="width:8%;"/>
            <col style="width:9%;"/>
        </colgroup>
        <thead>
        <tr>
            <th scope="col">서비스</th>
            <th scope="col">서비스 유형</th>
            <th scope="col">조회수</th>
            <th scope="col">등록일자<br>최종수정일자</th>
            <th scope="col">분류</th>
        </tr>
        </thead>
        <tbody>
        <tr>
            <td colspan="5" class="noData">해당 자료가 없습니다.</td>
        </tr>
        </tbody>
        </table>
        <form id="dataset-search-form" name="dataset-search-form" method="post">
            <input type="hidden" name="page" value="<c:out value="${param.page}" default="1" />" />
            <input type="hidden" name="rows" value="<c:out value="${param.rows}" default="5" />" />
            <input type="hidden" name="infId" value="<c:out value="${param.infId}" default="" />" />
            <input type="hidden" name="infSeq" value="<c:out value="${param.infSeq}" default="" />" />
            <c:forEach items="${paramValues}" var="parameter">
            <c:set var="key" value="${parameter.key}" />
            <c:if test="${key == 'orgCd' || key == 'cateId' || key == 'srvCd' || key == 'infTag' || key == 'searchWord'}">
            <c:forEach items="${parameter.value}" var="value">
            <input type="hidden" name="${key}" value="${value}" />
            </c:forEach>
            </c:if>
            </c:forEach>
        </form>
        <!-- // 공공데이터 -->
        <!-- 통계데이터 -->
        <h4 class="ty_A  mgTm10_mq_mobile">통계데이터 <span class="num">(<strong id="stat-count-sect" class="single-count-sect">0</strong>)</span></h4>
        <div class="area_btn_D">
            <a id="stat-search-button" href="#" class="btn_D btn_D_more">더보기</a>
        </div>
        <table id="stat-data-table" class="table_boardList_A table_boardList_AB mgTm10_mq_mobile">
        <caption>데이터셋 목록</caption>
        <colgroup>
            <col style="width:65%;"/> 
            <col style="width:15%;"/>
            <col style="width:20%;"/>
        </colgroup>
        <thead>
        <tr>
            <th scope="col">통계표명</th>
            <th scope="col">공개일자</th>
            <th scope="col">제공기관</th>
        </tr>
        </thead>
        <tbody>
        <tr>
            <td colspan="5" class="noData">해당 자료가 없습니다.</td>
        </tr>
        </tbody>
        </table>
        <form id="stat-search-form" name="stat-search-form" method="post">
            <input type="hidden" name="searchVal" value="<c:out value="${param.searchWord}" default="" />" />
        </form>
        <!-- // 통계데이터 -->

        <!-- 활용갤러리 -->
        <c:choose>
		<c:when test="${requestScope.systemAppType ne 'clb'}">
			<h4 class="ty_A  mgTm10_mq_mobile">활용갤러리 <span class="num">(<strong id="gallery-count-sect" class="single-count-sect">0</strong>)</span></h4>
	        <div class="area_btn_D">
	            <a id="gallery-search-button" href="#" class="btn_D btn_D_more">더보기</a>
	        </div>
	        <div class="wrap_list_D wrap_list_DC">
	        <ul id="gallery-data-list" class="list_D">
	        <li class="noData">해당 자료가 없습니다.</li>
	        </ul>
	        </div>
	        <form id="gallery-search-form" name="gallery-search-form" method="post">
	            <input type="hidden" name="page" value="<c:out value="${param.page}" default="1" />" />
	            <input type="hidden" name="rows" value="<c:out value="${param.rows}" default="5" />" />
	            <input type="hidden" name="bbsCd" value="<c:out value="${param.bbsCd}" default="GALLERY" />" />
	            <input type="hidden" name="listSubCd" value="<c:out value="${param.listSubCd}" default="" />" />
	            <input type="hidden" name="searchType" value="<c:out value="${param.searchType}" default="" />" />
	            <input type="hidden" name="searchWord" value="<c:out value="${param.searchWord}" default="" />" />
	            <input type="hidden" name="seq" value="<c:out value="${param.seq}" default="" />" />
            <input type="hidden" name="noticeYn" value="<c:out value="${param.noticeYn}" default="" />" />
       	 	</form> 
		</c:when>
		<c:otherwise>
		</c:otherwise>
		</c:choose>
        
        <!-- // 활용갤러리 -->
        <!-- 개발자공간 -->
        <%-- 
        <h4 class="ty_A  mgTm10_mq_mobile">개발자공간 <span class="num">(<strong id="develop-count-sect" class="single-count-sect">0</strong>)</span></h4>
        <div class="area_btn_D">
            <a id="develop-search-button" href="#" class="btn_D btn_D_more">더보기</a>
        </div>
        <table id="develop-data-table" class="table_boardList_A table_boardList_AB mgTm10_mq_mobile">
            <caption>개발자 공간 목록</caption>
            <colgroup>
                <col style="width:8%;"/>
                <col style="width:54%;"/> 
                <col style="width:10%;"/>
                <col style="width:11%;"/>
                <col style="width:8%;"/>
                <col style="width:9%;"/>
            </colgroup>
            <thead>
            <tr>
                <th scope="col">No</th>
                <th scope="col">제목</th>
                <th scope="col">작성자</th>
                <th scope="col">작성일</th>
                <th scope="col">조회수</th>
                <th scope="col">댓글</th>
            </tr>
            </thead>
            <tbody>
            <tr>
                <td colspan="6" class="noData">해당 자료가 없습니다.</td>
            </tr>
            </tbody>
        </table>
        <form id="develop-search-form" name="develop-search-form" method="post">
            <input type="hidden" name="page" value="<c:out value="${param.page}" default="1" />" />
            <input type="hidden" name="rows" value="<c:out value="${param.rows}" default="5" />" />
            <input type="hidden" name="bbsCd" value="<c:out value="${param.bbsCd}" default="DEVELOP" />" />
            <input type="hidden" name="listSubCd" value="<c:out value="${param.listSubCd}" default="" />" />
            <input type="hidden" name="searchType" value="<c:out value="${param.searchType}" default="" />" />
            <input type="hidden" name="searchWord" value="<c:out value="${param.searchWord}" default="" />" />
            <input type="hidden" name="seq" value="<c:out value="${param.seq}" default="" />" />
            <input type="hidden" name="noticeYn" value="<c:out value="${param.noticeYn}" default="" />" />
        </form> --%>
        <!-- // 개발자공간 -->
        <!-- 자료실 -->
        <%-- 
        <h4 class="ty_A  mgTm10_mq_mobile">자료실 <span class="num">(<strong id="data-count-sect" class="single-count-sect">0</strong>)</span></h4>
        <div class="area_btn_D">
            <a id="data-search-button" href="#" class="btn_D btn_D_more">더보기</a>
        </div>
        <table id="data-data-table" class="table_boardList_A table_boardList_AB mgTm10_mq_mobile">
        <caption>자료실 목록</caption>
        <colgroup>
            <col style="width:8%;"/>
            <col style="width:54%;"/> 
            <col style="width:10%;"/>
            <col style="width:11%;"/>
            <col style="width:8%;"/>
            <col style="width:9%;"/>
        </colgroup>
        <thead>
        <tr>
            <th scope="col">No</th>
            <th scope="col">제목</th>
            <th scope="col">작성자</th>
            <th scope="col">작성일</th>
            <th scope="col">조회수</th>
            <th scope="col">첨부파일</th>
        </tr>
        </thead>
        <tbody>
        <tr>
            <td colspan="6" class="noData">해당 자료가 없습니다.</td>
        </tr>
        </tbody>
        </table>
        <form id="data-search-form" name="data-search-form" method="post">
            <input type="hidden" name="page" value="<c:out value="${param.page}" default="1" />" />
            <input type="hidden" name="rows" value="<c:out value="${param.rows}" default="5" />" />
            <input type="hidden" name="bbsCd" value="<c:out value="${param.bbsCd}" default="DATA" />" />
            <input type="hidden" name="listSubCd" value="<c:out value="${param.listSubCd}" default="" />" />
            <input type="hidden" name="searchType" value="<c:out value="${param.searchType}" default="" />" />
            <input type="hidden" name="searchWord" value="<c:out value="${param.searchWord}" default="" />" />
            <input type="hidden" name="seq" value="<c:out value="${param.seq}" default="" />" />
            <input type="hidden" name="noticeYn" value="<c:out value="${param.noticeYn}" default="" />" />
        </form> --%>
        <!-- // 자료실 -->
        <!-- 묻고답하기 -->
        <h4 class="ty_A  mgTm10_mq_mobile">Q&A <span class="num">(<strong id="qna-count-sect" class="single-count-sect">0</strong>)</span></h4>
        <div class="area_btn_D">
            <a id="qna-search-button" href="#" class="btn_D btn_D_more">더보기</a>
        </div>
        <table id="qna-data-table" class="table_boardList_A table_boardList_AB mgTm10_mq_mobile">
        <caption>Q&A 목록</caption>
        <colgroup>
            <col style="width:8%;"/>
            <col style="width:54%;"/> 
            <col style="width:10%;"/>
            <col style="width:11%;"/>
            <col style="width:8%;"/>
            <col style="width:9%;"/>
        </colgroup>
        <thead>
        <tr>
            <th scope="col">No</th>
            <th scope="col">제목</th>
            <th scope="col">작성자</th>
            <th scope="col">작성일</th>
            <th scope="col">조회수</th>
            <th scope="col">답변상태</th>
        </tr>
        </thead>
        <tbody>
        <tr>
            <td colspan="6" class="noData">해당 자료가 없습니다.</td>
        </tr>
        </tbody>
        </table>
        <form id="qna-search-form" name="qna-search-form" method="post">
            <input type="hidden" name="page" value="<c:out value="${param.page}" default="1" />" />
            <input type="hidden" name="rows" value="<c:out value="${param.rows}" default="5" />" />
            <input type="hidden" name="bbsCd" value="<c:out value="${param.bbsCd}" default="QNA01" />" />
            <input type="hidden" name="listSubCd" value="<c:out value="${param.listSubCd}" default="" />" />
            <input type="hidden" name="searchType" value="<c:out value="${param.searchType}" default="" />" />
            <input type="hidden" name="searchWord" value="<c:out value="${param.searchWord}" default="" />" />
            <input type="hidden" name="seq" value="<c:out value="${param.seq}" default="" />" />
            <input type="hidden" name="noticeYn" value="<c:out value="${param.noticeYn}" default="" />" />
        </form>
        <!-- // 묻고답하기 -->
        <form id="unified-search-form" name="unified-search-form" method="post">
            <input type="hidden" name="searchWord" value="<c:out value="${param.searchWord}" default="" />" />
        </form>
    </div>
    <!-- // content -->
</div>
<!-- // layout_flex -->
</div></div>        
<!-- // wrap_layout_flex -->
<%@ include file="/WEB-INF/jsp/ggportal/sect/password.jsp" %>
<%@ include file="/WEB-INF/jsp/ggportal/sect/footer.jsp" %>
</div>
<!-- // layout_A -->
</body>
</html>