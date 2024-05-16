<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%-- @(#)main.jsp 1.0 2019/10/10											--%>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>

<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%-- OPEN API 메인 화면(임시)이다.												--%>
<%--																		--%>
<%-- @author SBCHOI														--%>
<%-- @version 1.0 2020/11/09												--%>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<!DOCTYPE html>
<html lang="ko">
<head>
<%@ include file="/WEB-INF/jsp/portal/sect/head.jsp" %>
<style type="text/css">
	.contents-navigation-area{display:none;}
</style>
</head>
<body>
<!-- layout_A -->
<div class="layout_A layout_main">

<%@ include file="/WEB-INF/jsp/portal/sect/headerOpen.jsp" %>

	<!-- wrap_layout_flex -->
	<div class="wrap_layout_flex openapi_newmain" id="contents">
		<div class="layout_flex_100">
			
			<!-- 상단 -->
			<div class="main_openapi_new">
				<div>
					<!-- 기능소개 및 개발자 가이드 -->
					<div class="main_openapi_slogan">
						<h2>
							<span>열린국회정보</span>
							<strong>OpenAPI 서비스를 제공합니다.</strong>
						</h2>
						<ul>
							<li><a href="/portal/openapi/openApiIntroPage.do">기능소개</a></li>
							<li><a href="/portal/openapi/openApiDevPage.do">개발자 가이드</a></li>
						</ul>
					</div>
					<!-- //기능소개 및 개발자 가이드 -->
					
					<div class="main_openapi_5">
						<img src="/images/main_openapi.png" alt="Open API 신청방법">
						<ul class="hide">
							<li><span>Open API 서비스접속</span></li>
							<li><span>로그인</span></li>
							<li><span>인증키 신청</span></li>
							<li><span>Open API 검색 <br>및 이용방법 확인</span></li>
							<li><span>Open API를 이용한 <br>어플리케이션 제작</span></li>
						</ul>
					</div>
				</div>
			</div>
			<!-- //상단 -->
			
			<!-- 중단 -->
			<div class="main_openapi_middle">
				<div>
					<!-- 공지사항 -->
					<div class="openapi_new_notice">
						<strong>공지사항</strong>
						<div id="notice-div-sect">
						<c:forEach var="bbs" items="${noticeList }" varStatus="status">
							<a href="/portal/bbs/noticeapi/selectBulletinPage.do?seq=${bbs.seq }">
								<em>[${bbs.userDttm }]</em>
								<span>${bbs.bbsTit }</span>
							</a>
						</c:forEach>
						</div>
						<ul>
							<li><a href="javascript:;" class="openapi_prev">이전</a></li>
							<li><a href="javascript:;" class="openapi_next">다음</a></li>
						</ul>
					</div>
					<!-- //공지사항 -->
					
					<!-- 주간, 월간, FAQ, Q&A -->
					<div class="openapi_etc_board">
						<!-- 주간인기 -->
						<div class="oeb01">
							<h3>
								<em>주간</em>
								<span>관심 정보</span>
							</h3>
							<ul>
							<c:forEach var="weekly" items="${popularWeeklyList }" varStatus="status">
								<li>
									<a href="/portal/data/service/selectServicePage.do/${weekly.INF_ID }" target="_blank">
										<em>${status.count}</em>
										<span>${weekly.INF_NM }</span>
									</a>
								</li>
							</c:forEach>	
							</ul>
						</div>
						<!-- //주간인기 -->
						
						<!-- 월간인기 -->
						<div class="oeb02">
							<h3>
								<em>월간</em>
								<span>관심 정보</span>
							</h3>
							<ul>
							<c:forEach var="monthly" items="${popularMonthlyList }" varStatus="status">
								<li>
									<a href="/portal/data/service/selectServicePage.do/${monthly.INF_ID }" target="_blank">
										<em>${status.count}</em>
										<span>${monthly.INF_NM }</span>
									</a>
								</li>
							</c:forEach>
							</ul>
						</div>
						<!-- //월간인기 -->
						
						<div class="oeb03" id="bbs-sect">
						
							<!-- FAQ -->
							<div class="oeb03_faq on">
								<h3><a href="javascript:;">FAQ</a></h3>
								<div>
									<ul>
									<c:forEach var="bbs" items="${faqList }" varStatus="status">
										<li><a href="/portal/bbs/faqapi/searchBulletinPage.do?seq=${bbs.seq }">${bbs.bbsTit }</a></li>
									</c:forEach>
									</ul>
									<a href="/portal/bbs/faqapi/searchBulletinPage.do">FAQ 더보기</a>
								</div>
							</div>
							<!-- //FAQ -->
						
							<!-- Q&A -->
							<div class="oeb03_qna">
								<h3><a href="javascript:;">Q&amp;A</a></h3>
								<div>
									<ul>
									<c:forEach var="bbs" items="${qnaList }" varStatus="status">
										<li><a href="/portal/bbs/qnaapi/selectBulletinPage.do?seq=${bbs.seq }">${bbs.bbsTit }</a></li>
									</c:forEach>
									</ul>
									<a href="/portal/bbs/qnaapi/searchBulletinPage.do">Q&A 더보기</a>
								</div>
							</div>
							<!-- //Q&A -->
						</div>
					</div>
					<!-- //주간, 월간, FAQ, Q&A -->
				</div>
			</div>
			<!-- //중단 -->
			
			<!-- 하단 -->
			<div class="main_openapi_btm">
				<div class="mob01">
					<div>
						<h3>열린국회정보 API 목록</h3>
						<span>열린국회정보 OpenAPI 제공 목록을 확인할 수 있습니다.</span>
					</div>
					<a href="/portal/openapi/openApiNaListPage.do" title="열린국회정보 API 목록 더보기">더보기</a>
				</div>
				<div class="mob02">
					<div>
						<h3>국회 소속기관 제공 API 목록</h3>
						<span>국회 소속기관에서 제공하는 OpenAPI를 확인할 수 있습니다.</span>
					</div>
					<a href="/portal/openapi/openApiSupplyListPage.do" title="국회 소속기관 제공 API 목록 더보기">더보기</a>
				</div>
			</div>
			<!-- //하단 -->
				
		</div>
	</div>
    <!-- // content -->
</div>
<!-- // layout_flex -->

<%@ include file="/WEB-INF/jsp/portal/sect/footer.jsp" %>
<script type="text/javascript" src="<c:url value="/js/portal/openapi/openApiMain.js" />"></script>

<!-- // layout_A -->
</body>
</html>