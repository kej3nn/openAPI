<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%-- @(#)selectNotice.jsp 1.0 2015/06/15                                    --%>
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
<%-- 공지 게시판 내용을 조회하는 화면이다.                                  --%>
<%--                                                                        --%>
<%-- @author 김은삼                                                         --%>
<%-- @version 1.0 2015/06/15                                                --%>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<!DOCTYPE html>
<html lang="ko">
<head>
<%@ include file="/WEB-INF/jsp/portal/sect/head.jsp" %>
<script type="text/javascript" src="<c:url value="/js/ggportal/bbs/notice/selectNotice.js" />"></script>
</head>
<body>
<!-- layout_A -->
<div class="layout_A">
<c:choose>
<c:when test="${fn:indexOf(requestScope.uri, '/portal/bbs/noticeapi/') >= 0}">
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
			<h3>공지사항<span class="arrow"></span></h3>
		</div>
<!-- wrap_layout_flex -->
<div class="wrap_layout_flex"><div class="layout_flex_100">
<!-- layout_flex -->
<div class="layout_flex">
    <!-- content -->
    <div id="content" class="content">
        <h2 class="hide"><c:out value="${requestScope.menu.lvl1MenuPath}" /></h2>
        <h4 class="ty_A"><c:out value="${requestScope.menu.lvl2MenuPath}" /> 글보기</h4>
        <form id="notice-select-form" name="notice-select-form" method="post">
        <table class="table_datail_B w_1 fix_none">
        <%--<caption><c:out value="${requestScope.menu.lvl2MenuPath}" /> 상세</caption>--%>
        <tr>
            <td colspan="2" class="area_tit">
                <strong class="tit listSubNm bbsTit"></strong>
            </td>
        </tr>
        <tr>
            <td colspan="2" class="ty_B">
                <dl>
                <dt>등록일</dt>
                <dd class="userDttm"></dd>
                <dt>조회수</dt>
                <dd class="viewCnt"></dd>
                </dl>
            </td>
        </tr>
        <tr>
            <td colspan="2" class="cont">
            <pre class="bbsCont"></pre>
            </td>
        </tr>
        <c:if test="${data.atfileYn == 'Y'}">
        <tr>
            <td class="mq_tablet">첨부된 파일</td>
            <td id="notice-attach-sect">첨부 파일이 없습니다.</td>
        </tr>
        </c:if>
        </table>
        </form>
        <form id="notice-search-form" name="notice-search-form" method="post">
            <input type="hidden" name="page" value="<c:out value="${ param.page }" default="1" />" />
            <input type="hidden" name="rows" value="<c:out value="${ param.rows }" default="${data.listCnt}" />" />
            <input type="hidden" name="bbsCd" value="<c:out value="${ param.bbsCd }" default="${data.bbsCd}" />" />
            <input type="hidden" name="listSubCd" value="<c:out value="${ param.listSubCd }" default="" />" />
            <input type="hidden" name="searchType" value="<c:out value="${ param.searchType }" default="" />" />
            <input type="hidden" name="searchWord" value="<c:out value="${ param.searchWord }" default="" />" />
            <input type="hidden" name="seq" value="<c:out value="${ param.seq }" default="" />" />
            <input type="hidden" name="noticeYn" value="<c:out value="${ param.noticeYn }" default="" />" />
        </form>
        <div class="area_btn_A">
            <a id="notice-search-button" href="#" class="btn_A">목록</a>
        </div>
    </div>
    <!-- // content -->
</div>
<!-- // layout_flex -->
</div></div>        
<!-- // wrap_layout_flex -->

</div></div>   

<%@ include file="/WEB-INF/jsp/portal/sect/footer.jsp" %>
</div>
<!-- // layout_A -->
</body>
</html>