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
<%-- 마이페이지 > Qna                      --%>
<%--                                                                        --%>
<%-- @author 장홍식                                                         --%>
<%-- @version 1.0 2015/08/11                                                --%>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<!DOCTYPE html>
<html lang="ko">
<head>
<%@ include file="/WEB-INF/jsp/portal/sect/head.jsp" %>
<script type="text/javascript" src="<c:url value="/js/ggportal/myPage/myQna/selectMyQna.js" />"></script>
</head>
<body>
<!-- layout_A -->
<div class="layout_A">
<%@ include file="/WEB-INF/jsp/portal/sect/header.jsp" %>


<section>
	<div class="container" id="container">
		<%@ include file="/WEB-INF/jsp/portal/sect/lnb.jsp" %>
		<article>
		    <div id="contents" class="contents">
				<div class="contents-title-wrapper">
					<h3>나의 질문내역<span class="arrow"></span></h3>
				</div>
				<div class="area_h3 area_h3_AB area_h3_AC deco_h3_4">
					<%-- <p> <strong>${sessionScope.portalUserNm}</strong>님 환영합니다.</p> --%>
				</div>
		        <h4 class="ty_A">질문 글보기</h4>
		        <form id="qna-select-form" name="qna-select-form" method="post">
		        <input type="hidden" name="bbsCd" />
		        <input type="hidden" name="seq" />
		        <table class="table_datail_B w_1">
		        <%--<caption><c:out value="${requestScope.menu.lvl2MenuPath}" /> 상세</caption>--%>
		        <tr>
		            <td class="area_tit">
		                <strong class="tit listSubNm bbsTit"></strong>
		            </td>
		        </tr>
		        <tr>
		            <td class="ty_B">
		                <dl>
		                <dt>등록일</dt>
		                <dd class="userDttm"></dd>
		                <dt>조회수</dt>
		                <dd class="viewCnt"></dd>
		                </dl>
		            </td>
		        </tr>
		        <tr>
		            <td class="cont bbsCont">
		            	<pre></pre>
		            <c:if test="${data.atfileYn == 'Y'}">
		            <dl class="ty_B hide">
		                <dt>첨부된 파일</dt>
		                <dd id="qna-attach-sect"></dd>
		            </dl>
		            </c:if>
		            </td>
		        </tr>
		        <tr class="hide">
		            <td class="answer">
		                <strong class="tit">답변</strong>
		                <pre class="cont ansCont">
		            	</pre>
		            </td>
		        </tr>
		        </table>
		        </form>
		        <div class="area_btn_A">
		            <a id="qna-search-button" href="#" class="btn_A">목록</a>
		            <a id="qna-update-button" href="#" class="btn_A hide">수정</a>
		            <a id="qna-delete-button" href="#" class="btn_A hide">삭제</a>
		        </div>
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
		</article>	
	</div>
</section>

<!-- // wrap_layout_flex -->
<%@ include file="/WEB-INF/jsp/portal/sect/footer.jsp" %>
</div>
<!-- // layout_A -->
</body>
</html>