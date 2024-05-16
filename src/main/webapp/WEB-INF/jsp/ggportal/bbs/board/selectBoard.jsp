<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%-- @(#)selectBoard.jsp 1.0 2015/06/15                                     --%>
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
<%-- 일반 게시판 내용을 조회하는 화면이다.                                  --%>
<%--                                                                        --%>
<%-- @author 김은삼                                                         --%>
<%-- @version 1.0 2015/06/15                                                --%>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<!DOCTYPE html>
<html lang="ko">
<head>
<%@ include file="/WEB-INF/jsp/portal/sect/head.jsp" %>
<script type="text/javascript" src="<c:url value="/js/ggportal/bbs/board/selectBoard.js" />"></script>
</head>
<body> 
<!-- layout_A -->
<div class="layout_A">
<c:choose>
<c:when test="${fn:indexOf(requestScope.uri, '/portal/bbs/guide/') >= 0}">
<%@ include file="/WEB-INF/jsp/portal/sect/headerOpen.jsp" %>
</c:when>
<c:when test="${fn:indexOf(requestScope.uri, '/portal/bbs/develop/') >= 0}">
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
   
<!-- content -->
    <div class="contents" id="contents">
    	<div class="contents-title-wrapper">
   		<c:choose>
           <c:when test="${data.bbsCd == 'DEVELOP'}">
           <h3><c:out value="${requestScope.menu.lvl3MenuPath}" /><span class="arrow"></span></h3>
           </c:when>
           <c:otherwise>
           <h3><c:out value="${requestScope.menu.lvl2MenuPath}" /><span class="arrow"></span></h3>
           </c:otherwise>
        </c:choose>
		</div>
<!-- wrap_layout_flex -->
<div class="wrap_layout_flex"><div class="layout_flex_100">
<!-- layout_flex -->
<div class="layout_flex">
	<!-- content -->
	<div id="content" class="content">
        <h2 class="hide"><c:out value="${requestScope.menu.lvl1MenuPath}" /></h2>
            <c:choose>
            <c:when test="${data.bbsCd == 'DATA'}">
            <h3 class="ty_A"><span>국회 통계관리 및 공공데이터</span><strong><c:out value="${requestScope.menu.lvl2MenuPath}" /></strong></h3>
            </c:when>
            <c:when test="${data.bbsCd == 'BLOG'}">
            <h3 class="ty_A"><span>국회 통계관리 및 공공데이터</span><strong><c:out value="${requestScope.menu.lvl2MenuPath}" /></strong></h3>
            </c:when>
            <c:when test="${data.bbsCd == 'SNS'}">
             <h4 class="ty_A"><c:out value="${requestScope.menu.lvl2MenuPath}" /> 글보기</h4>
            </c:when>
            </c:choose>
        </div>
        <form id="board-select-form" name="board-select-form" method="post">
        <input type="hidden" name="bbsCd" />
        <input type="hidden" name="seq" />
        <input type="hidden" name="listSubCd" />
        <input type="hidden" name="bbsTit" />
         <table class="table_datail_B w_1 fix_none">
        <%--<caption><c:out value="${requestScope.menu.lvl2MenuPath}" /> 상세</caption>--%>
        <tr>
            <td colspan="2" class="area_tit">
                <strong class="tit listSubNm bbsTit">
                    <%-- 댓글 게시판 --%>
                    <c:if test="${data.ansYn == 'Y' && data.ansTag == 'N'}">
                    <strong  class="replyNum">(<strong class="ansCnt"></strong>)</strong>
                    </c:if>
                </strong>
            </td>
        </tr>
        <tr>
            <td colspan="2" class="ty_B">
                <dl>
                <dt>작성자</dt>
                <dd class="userNm"></dd>
                <dt>등록일</dt>
                <dd class="userDttm"></dd>
                <dt>조회수</dt>
                <dd class="viewCnt"></dd>
                </dl>
                <%-- 댓글 게시판 --%>
                <%--
                <c:if test="${data.ansYn == 'Y' && data.ansTag == 'N'}">
                <span class="recommendationNum"><span class="mq_tablet">추천</span>(<strong>0</strong>)</span>
                </c:if>
                --%>
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
            <td id="board-attach-sect">첨부 파일이 없습니다.</td>
        </tr>
        </c:if>
        </table>
        </form>
        <%-- 댓글 게시판 --%>
        <c:if test="${data.ansYn == 'Y' && data.ansTag == 'N'}">
        <!-- 댓글 -->
        <form id="comment-insert-form" name="comment-insert-form" method="post">
        <input type="hidden" name="bbsCd" />
        <input type="hidden" name="seq" />
        <input type="hidden" name="pSeq" />
        <input type="hidden" name="listSubCd" />
        <input type="hidden" name="bbsTit" />
        <input type="hidden" name="bulletIdInfo" />
        <fieldset>
        <legend>댓글 입력</legend>
        <section class="reply platform_reply">
            <c:choose>
            <c:when test="${data.bbsCd == 'DEVELOP'}">
            <h5 class="ty_h4 h5_reply">댓글 <span class="num">(<strong class="ansCnt"></strong>)</span></h5>
            </c:when>
            <c:otherwise>
            <h4 class="ty_A h4_reply">댓글 <span class="num">(<strong class="ansCnt"></strong>)</span></h4>
            </c:otherwise>
            </c:choose>
            <%-- <div class="password">
                <label for="password">비밀번호</label>
                <c:choose>
                <c:when test="${empty sessionScope.PortalLoginVO.userId}">
                <input type="password" id="regUserPw" name="regUserPw" autocomplete="on" class="required" style="ime-mode:disabled;" />
                </c:when>
                <c:otherwise>
                <input type="password" id="regUserPw" name="regUserPw" autocomplete="on" class="disabled" style="ime-mode:disabled;" />
                </c:otherwise>
                </c:choose>
            </div> --%>
            <c:choose>
       		<c:when test="${data.bbsCd == 'SNS'}">
       		<!-- 라이브리 시티 설치 코드 -->
			<div id="lv-container" data-id="city" data-uid="MTAyMC80NzIzMi8yMzczMg==">
			</div>
			<!-- 시티 설치 코드 끝 -->
       		</c:when>
        	<c:otherwise>
            <div class="replyWrite">
                <textarea name="bbsCont" rows="5" title="댓글 입력" placeholder="댓글을 입력하세요." style="ime-mode:active;"></textarea>
                <span class="byte"><strong id="comment-bytes-sect">0</strong> / 200자</span>
                <a id="comment-insert-button" href="#">댓글쓰기</a>
            </div>
            <ul id="comment-data-list">
            	<li class="noData">댓글이 없습니다. 댓글을 남겨주세요.</li>
            </ul>
            </c:otherwise>
            </c:choose>
        </section>
        </fieldset>
        </form>
        <!-- // 댓글 -->
        </c:if>
        <c:choose>
        <c:when test="${data.bbsCd == 'DEVELOP'}">
        <div class="area_btn_A">
            <a id="board-search-button" href="#" class="btn_A">목록</a>
            <a id="board-update-button" href="#" class="btn_A hide">수정</a>
            <a id="board-delete-button" href="#" class="btn_AB hide">삭제</a>
        </div>
        </section>
        <!-- // 커뮤니티 -->
        </c:when>
        <c:otherwise>
        <div class="area_btn_A">
            <a id="board-search-button" href="#" class="btn_A">목록</a>
        </div>
        </c:otherwise>
        </c:choose>
        <form id="board-search-form" name="board-search-form" method="post">
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
</div>
<!-- // layout_flex -->
</div></div>        
<!-- // wrap_layout_flex -->
<%@ include file="/WEB-INF/jsp/ggportal/sect/password.jsp" %>
<%@ include file="/WEB-INF/jsp/portal/sect/footer.jsp" %>
</div>
<!-- // layout_A -->
</body>
</html>