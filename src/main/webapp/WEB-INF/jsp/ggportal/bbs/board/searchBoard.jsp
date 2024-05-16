<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%-- @(#)searchBoard.jsp 1.0 2015/06/15                                     --%>
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
<%-- 일반 게시판 내용을 검색하는 화면이다.                                  --%>
<%--                                                                        --%>
<%-- @author 김은삼                                                         --%>
<%-- @version 1.0 2015/06/15                                                --%>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<!DOCTYPE html>
<html lang="ko">
<head>
<%@ include file="/WEB-INF/jsp/portal/sect/head.jsp" %>
<script type="text/javascript" src="<c:url value="/js/ggportal/bbs/board/searchBoard.js" />"></script>
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
	<!-- contents -->
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
		<div class="wrap_layout_flex fix_page">
			<div class="layout_flex_100">
				<!-- layout_flex -->
				<div class="layout_flex">
					<div class="content_txt"><c:out value="${data.bbsExp}" escapeXml="false" /></div>
				    <!-- content -->
				    <div id="content" class="content">
				        <h2 class="hide"><c:out value="${requestScope.menu.lvl1MenuPath}" /></h2>
				        
				        <!-- 목록 -->
				        <section id="tab_B_cont_1" class="tab_AB_cont">
				            <h4 class="hide"><c:out value="${requestScope.menu.lvl3MenuPath}" /></h4>
				            
				            <div class="search_board_top platform">
					            <ul class="search search_AB">
						            <li class="ty_BB">
						                <ul class="ty_A mq_tablet">
						                    <li>전체 <strong id="board-count-sect" class="totalNum"></strong>건, <span id="board-pages-sect" class="pageNum"></span></li>
						                </ul>
						            </li>
					            </ul>
					            
					            <div class="search_view_down">
						             <span>
										<select id="selRows" title="리스트 갯수형식">
											<c:if test="${param.rows == '' }">
												<option value="10" selected="selected">10개씩 보기</option>
												<option value="15">15개씩 보기</option>
												<option value="20">20개씩 보기</option>
											</c:if>
											<c:if test="${param.rows != '' }">
												<option value="10" ${param.rows == 10 ? 'selected=selected' : '' }>10개씩 보기</option>
												<option value="15" ${param.rows == 15 ? 'selected=selected' : '' }>15개씩 보기</option>
												<option value="20" ${param.rows == 20 ? 'selected=selected' : '' }>20개씩 보기</option>
											</c:if>
										</select>
									</span>
						            <c:if test="${data.bbsCd == 'GUIDE'}">
						            	<a href="javascript:;" class="btn_filedown" id="excelDown" title="다운로드">다운로드</a>
						            </c:if>
						            <c:if test="${data.bbsCd == 'DEVELOP'}">
							        	<a href="#" class="btn_qwrite board-insert-button">질문 작성하기</a> 
							        </c:if>
					            </div>
							</div>
				            <%-- <div class="result_view pb0">
								<div id="result-sect-total" class="result_total_count">
									전체 <strong id="board-count-sect" class="totalNum"></strong>건 <em id="board-pages-sect" class="pageNum"></em>
								</div>
					            <span>
									<select id="selRows" title="리스트 갯수형식">
										<c:if test="${param.rows == '' }">
											<option value="12" selected="selected">12개씩 보기</option>
											<option value="24">24개씩 보기</option>
											<option value="48">48개씩 보기</option>
										</c:if>
										<c:if test="${param.rows != '' }">
											<option value="12" ${param.rows == 12 ? 'selected=selected' : '' }>12개씩 보기</option>
											<option value="24" ${param.rows == 24 ? 'selected=selected' : '' }>24개씩 보기</option>
											<option value="48" ${param.rows == 48 ? 'selected=selected' : '' }>48개씩 보기</option>
										</c:if>
									</select>
								</span>
							</div>	 --%>
				            <table id="data-table" class="table_boardList_A table_boardList_AB  mgTm10_mq_mobile">
				            <caption><c:out value="${requestScope.menu.lvl3MenuPath}" /></caption>
				            <c:choose>
				            <%-- 댓글 게시판 --%>
				            <c:when test="${data.ansYn == 'Y' && data.ansTag == 'N'}">
				            <colgroup>
				                <%--
				                <col style="width:8%;" />
				                <col style="width:50%;" />
				                <col style="width:9%;" />
				                <col style="width:10%;" />
				                <col style="width:9%;" />
				                <col style="width:7%;" />
				                <col style="width:7%;" />
				                --%>
				                <col style="width:8%;" />
				                <col style="width:57%;" />
				                <col style="width:9%;" />
				                <col style="width:10%;" />
				                <col style="width:9%;" />
				                <col style="width:7%;" />
				            </colgroup>
				            <thead>
				            <tr>
				                <%--
				                <th scope="col">No</th>
				                <th scope="col">제목</th>
				                <th scope="col">작성자</th>
				                <th scope="col">작성일</th>
				                <th scope="col">조회수</th>
				                <th scope="col">댓글</th>
				                <th scope="col">추천</th>
				                --%>
				                <th scope="col">No</th>
				                <th scope="col">제목</th>
				                <th scope="col">작성자</th>
				                <th scope="col">작성일</th>
				                <th scope="col">조회수</th>
				                <th scope="col" class="comment">댓글</th>
				            </tr>
				            </thead>
				            <tbody>
				            <tr>
				                <%--
				                <td colspan="7" class="noData">해당 자료가 없습니다.</td>
				                --%>
				                <td colspan="6" class="noData">해당 자료가 없습니다.</td>
				            </tr>
				            </tbody>
				            </c:when>
				            <%-- 일반 게시판 --%>
				            <c:otherwise>
				            <colgroup>
				                <col style="width:8%;" />
				                <col style="width:56%;" />
				                <col style="width:9%;" />
				                <col style="width:10%;" />
				                <col style="width:8%;" />
				                <col style="width:9%;" />
				            </colgroup>
				            <thead>
				            <tr>
				                <th scope="col">No</th>
				                <th scope="col">제목</th>
				                <th scope="col">작성자</th>
				                <th scope="col">작성일</th>
				                <th scope="col">첨부파일</th>
				                <th scope="col">조회수</th>
				            </tr>
				            </thead>
				            <tbody>
				            <tr>
				                <td colspan="6" class="noData">해당 자료가 없습니다.</td>
				            </tr>
				            </tbody>
				            </c:otherwise>
				            </c:choose>
				            </table>
				            <fieldset>
				            <legend><c:out value="${requestScope.menu.lvl2MenuPath}" /> 검색</legend>
				            <div class="search_B search_BB">
				                <span class="select">
				                    <select id="board-searchtype-combo" title="검색 분류 선택">
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
				                    <input type="search" id="board-searchword-field" autocomplete="on" placeholder="검색" title="검색" style="ime-mode:active;" /><a id="board-search-button" href="#" class="btn_search"><span>검색</span></a>
				                </span>
				            </div>
				            </fieldset>
				            <!-- page -->
				            <div id="board-pager-sect" class="page"></div>
				            <!-- // page -->
				            <c:if test="${data.bbsCd == 'DEVELOP'}">
				            <div class="area_btn_AC  mq_mobile">
				                <a href="<c:url value="/portal/myPage/actKeyPage.do?tabIdx=1" />" class="btn_AC apikey-issue-button">인증키발급</a>
				                <a href="#" class="btn_AC board-insert-button">글쓰기</a>
				            </div>
				            </c:if>
				        </section>
				        
				        <!-- // 목록 --><!-- // 커뮤니티 -->
				        <form id="board-search-form" name="board-search-form" method="post">
				            <input type="hidden" name="page" value="<c:out value="${param.page}" default="1" />" />
				            <input type="hidden" name="rows" value="<c:out value="${param.rows}" default="" />" />
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
			<!-- // layout_flex -->
			</div>
		</div>        
	<!-- // wrap_layout_flex -->
	</div>
</div>
<%@ include file="/WEB-INF/jsp/ggportal/sect/password.jsp" %>
<%@ include file="/WEB-INF/jsp/portal/sect/footer.jsp" %>
</div>
<!-- // layout_A -->
</body>
</html>