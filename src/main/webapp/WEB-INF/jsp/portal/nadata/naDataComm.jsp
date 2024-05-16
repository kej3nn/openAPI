<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%-- @(#)naDataComm.jsp 1.0 2019/09/11                                   --%>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%-- 보고서&발간물을 조회하는 화면이다.                                    --%>
<%--                                                                        --%>
<%-- @author JSSON                                                         --%>
<%-- @version 1.0 2019/09/11                                                --%>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>

<!DOCTYPE html>
<html lang="ko">
<head>
<%@ include file="/WEB-INF/jsp/portal/sect/head.jsp" %>
</head>
<body>
<!-- wrapper -->
<div class="wrapper" id="wrapper">
<%@ include file="/WEB-INF/jsp/portal/sect/header.jsp" %>
	<form id="form" name="form" method="post">
	<input type="hidden" name="page" value="<c:out value="${param.page}" default="1" />" />
    <input type="hidden" name="rows" value="<c:out value="${param.rows}" default="12" />" />
	<!-- container -->
	<section>
		<div class="container hide-pc-lnb" id="container">
		    <!-- content -->
			<article>
				<div class="contents" id="contents">
					<div class="contents-title-wrapper">
						<h3>보고서ㆍ발간물<span class="arrow"></span></h3>
					</div>
					<div class="wrap_layout_flex fix_page">
						<div class="layout_flex_100">
							<div class="report_view">
								<ul>
									<%-- <li>
									<c:set var="itmList" value="${requestScope.itmList}"/>
									<select name="searchItm" title="분류선택">
										<option value="">분류 전체</option>
									<c:forEach var="itmListDo" items="${itmList}">
										<option value="<c:out value="${itmListDo.DITC_CD}"/>"><c:out value="${itmListDo.DITC_NM}"/></option>
									</c:forEach>
									</select>
									</li> --%>
									<li>
									<c:set var="orgList" value="${requestScope.orgList}"/>
									<select name="searchOrg" title="기관선택">
										<option value="">국회 전체</option>
									<c:forEach var="orgListDo" items="${orgList}">
										<option value="<c:out value="${orgListDo.ORG_CD}"/>"><c:out value="${orgListDo.ORG_NM}"/></option>
									</c:forEach>
									</select>
									</li>
									<%-- <li>
									<c:set var="cycleList" value="${requestScope.cycleList}"/>
									<select name="searchCycle" title="발간주기선택">
										<option value="">발간주기 전체</option>
									<c:forEach var="cycleListDo" items="${cycleList}">
										<option value="<c:out value="${cycleListDo.DITC_CD}"/>"><c:out value="${cycleListDo.DITC_NM}"/></option>
									</c:forEach>
									</select>
									</li> --%>
									<li>
										<div class="input_search_btn">
											<input type="text" id="searchWord" name="searchWord" value="" title="검색">
										</div>
										<button type="button" class="group_btn">검색</button>
									</li>
								</ul>									
								<div>
									<div>전체 <strong id="result-count-sect" class="totalNum">0</strong>건 <span id="result-pages-sect" class="pageNum">(0/0 page)</span></div>
								</div>
							</div>
							<div class="report_list_box">
								<div class="rlbox">
									<ul>
									</ul>
								</div>														
							</div>
							<!-- 
							<div class="report_arrow">
								<ul>
									<li class="ra_left"><a href="#">이전</a></li>
									<li class="ra_right"><a href="#">다음</a></li>
								</ul>
							</div> -->
							<div id="result-pager-sect">
						</div>
					</div>
				</div>
			</article>
			<!-- //contents  -->
		</div>
	</section>
	</form>
	<!-- //container -->
</div>
<%@ include file="/WEB-INF/jsp/portal/sect/footer.jsp" %>
<script type="text/javascript" src="<c:url value="/js/portal/nadata/naDataComm.js" />"></script>
</body>
</html>
