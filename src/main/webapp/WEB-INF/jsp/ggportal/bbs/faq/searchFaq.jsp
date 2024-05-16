<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%-- @(#)searchFaq.jsp 1.0 2015/06/15                                       --%>
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
<%-- FAQ 게시판 내용을 검색하는 화면이다.                                   --%>
<%--                                                                        --%>
<%-- @author 김은삼                                                         --%>
<%-- @version 1.0 2015/06/15                                                --%>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<!DOCTYPE html>
<html lang="ko">
<head>
<%@ include file="/WEB-INF/jsp/portal/sect/head.jsp" %>
<script type="text/javascript" src="<c:url value="/js/ggportal/bbs/faq/searchFaq.js" />"></script>
</head>
<body>
<!-- layout_A -->
<div class="layout_A">
<c:choose>
<c:when test="${fn:indexOf(requestScope.uri, '/portal/bbs/faqapi/') >= 0}">
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
			<h3>FAQ<span class="arrow"></span></h3>
		</div>
<!-- wrap_layout_flex -->
<div class="wrap_layout_flex fix_page">
<div class="layout_flex_100">

<!-- layout_flex -->
<div class="layout_flex">
    <%@ include file="/WEB-INF/jsp/ggportal/bbs/board/sect/lnb.jsp" %>
    <!-- content -->
    <div id="content" class="content">        
        <h2 class="hide"><c:out value="${requestScope.menu.lvl1MenuPath}" /></h2>
        <form>
        <section>
        	<c:if test="${fn:indexOf(requestScope.uri, '/portal/bbs/faq01/') >= 0}">
	        <div id="tab_layout" class="tabmenu-type01 type02">
				<ul>
					<li id="tab_0" class="on"><a href="#none" title="확장됨">전체</a></li>
					<c:forEach var="faqGubun" items="${faqGubun}" varStatus="status">
						<li id="tab_${status.index+1 }" value="${faqGubun.code }"><a href="#none">${faqGubun.name }</a></li>
					</c:forEach>
				</ul>
			</div>
			</c:if>
            <h4 class="hide"><c:out value="${requestScope.menu.lvl3MenuPath}" /> 목록</h4>
            <ul class="search search_AC">
            <li class="ty_BB">
                <ul class="ty_A mq_tablet">
                    <li>전체 <strong id="faq-count-sect" class="totalNum"></strong>건</li>
                </ul>
            </li>
            </ul>
            <div id="faq-data-sect" class="wrap_dl_FAQ">
                <dl class="dl_FAQ">
                    <dt class="noData">해당 자료가 없습니다.</dt>
                </dl>
            </div>
            <fieldset>
            <legend><c:out value="${requestScope.menu.lvl2MenuPath}" /> 검색</legend>
            <div class="search_B search_BB">
                <span class="select">
                    <select id="faq-searchtype-combo" title="검색 분류 선택">
                        <option value="">전체</option>
                        <option value="bbsTit">질문</option>
                        <option value="bbsCont">답변</option>
                        <option value="bbsTit+bbsCont">질문+답변</option>
                    </select>
                </span>
                <span class="search">
                    <input type="search" id="faq-searchword-field" autocomplete="on" placeholder="검색" title="검색" style="ime-mode:active;" /><a id="faq-search-button" href="#" class="btn_search"><span>검색</span></a>
                </span>
            </div>
            </fieldset>
            <!-- page -->
            <div id="faq-pager-sect" class="page"></div>
            <!-- // page -->
        </section>
        <!-- // 목록 -->
        </form>
        <form id="faq-search-form" name="faq-search-form" method="post">
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

<%@ include file="/WEB-INF/jsp/portal/sect/footer.jsp" %>
</div>
<!-- // layout_A -->
</body>
</html>