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
<script type="text/javascript" src="<c:url value="/js/ggportal/myPage/myQna/searchMyQna.js" />"></script>
</head>
<body>
<!-- layout_A -->
<div class="layout_A">
<%@ include file="/WEB-INF/jsp/portal/sect/header.jsp" %>

<section>
	<div class="container" id="container">
	
		<%@ include file="/WEB-INF/jsp/portal/sect/lnb.jsp" %>
		
		<article>
			<div class="contents" id="contents">
				<div class="contents-title-wrapper">
					<h3>나의 질문내역<span class="arrow"></span></h3>
				</div>
				<div class="layout_flex">
					<div class="layout_flex_100">
						<div class="area_h3 area_h3_AB area_h3_AC deco_h3_4">
							<p><strong>${sessionScope.portalUserNm}</strong>님 환영합니다.</p>
						</div>
				        <form>
						<section>
							<ul class="search search_AC mmt20">
							<li class="ty_BB">
								<ul class="ty_A mq_tablet">
									<li>전체 <strong id="qna-count-sect" class="totalNum"></strong>건, <span id="qna-pages-sect" class="pageNum"></span></li>
								</ul>
							</li>
							</ul>
							<div class="area_btn_AC mq_tablet">
								<a href="" class="btn_AC qna-insert-button">질문 작성하기</a>
							</div>
							<table id="qna-data-table" class="table_boardList_A table_boardList_AB  mgTm10_mq_mobile">
							<caption>나의 질문내역 목록</caption>
							<colgroup>
								<col style="width:8%;"/>
								<col style="width:63%;"/> 
								<col style="width:10%;"/>
								<col style="width:10%;"/>
								<col style="width:9%;"/>
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
				            <tr>
				                <td colspan="5" class="noData">해당 자료가 없습니다.</td>
				            </tr>
							</tbody>
							</table>
				            <!-- page -->
				            <div id="qna-pager-sect" class="page"></div>
				            <!-- // page -->
						</section>
				        <div class="area_btn_AC  mq_mobile">
				            <a href="#" class="btn_AC qna-insert-button">질문 작성하기</a>
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
				</div>
			</div>
		</article>
	</div>
</section>
		
<!-- // wrap_layout_flex ############################## -->
<%@ include file="/WEB-INF/jsp/portal/sect/footer.jsp" %>
</div>
<!-- // layout_A -->
</body>
</html>