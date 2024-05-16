<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%-- @(#)header.jsp 1.0 2019/08/12                                          --%>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>

<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%-- 상단 섹션 화면이다.                                                    --%>
<%--                                                                        --%>
<%-- @author JHKIM                                                         --%>
<%-- @version 1.0 2019/08/12                                                --%>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>

	<!-- header --> 
	<header id="header">
		<div class="headers h-api">
			<!-- skip navigation -->
			<p class="skip-navigation"> 
				<a href="#contents">본문으로 바로가기</a> 
			</p>
			<!-- //skip navigation -->
			
			<!-- gnb -->
			<div class="gnb-area">
				<div class="gnb-box clear">
					<ul class="left">
						<li><a target="" href="/">정보공개포털</a></li>
						<li><a target="_blank" href="/portal/openapi/main.do" title="새창열림_Open API" class="on">Open API</a></li>
						<li><a target="_blank" href="http://www.assembly.go.kr" title="새창열림_대한민국국회">대한민국국회</a></li>
					</ul>
					<ul class="right">
						<c:choose>
					    <c:when test="${!empty sessionScope.portalUserCd}">
					    <li class="line-none"><a href="${getContextPath }/portal/user/logout.do">로그아웃</a></li>
					    <li><a href="${getContextPath }/portal/openapi/openApiActKeyPage.do">마이페이지</a></li>
					    </c:when>
					    <c:otherwise>
					    <li class="line-none"><a href="${getContextPath }/portal/user/loginPage.do">로그인</a></li>
					    </c:otherwise>
					    </c:choose>	
						<li><a href="${getContextPath }/portal/bbs/faqapi/searchBulletinPage.do">FAQ</a></li>
						<li><a href="/portal/view/openSitemapPage.do">Open API 사이트맵</a></li>
					</ul>
				</div>
			</div>
			<!-- //gnb -->
		
			<!-- menu -->
			<div class="header-area">
				<div class="header-box">
					<h1>
						<a href="/portal/openapi/main.do">
							<img src="/images/logo_openapi.png" alt="열린국회정보 정보공개포털 Open API">
						</a>
					</h1>
					<ul class="top-menu openapi-menu">
						<li><a href="/portal/openapi/openApiIntroPage.do" 			class="top-menu-depth1 menu1">Open API 소개</a></li>
			            <li><a href="/portal/openapi/openApiNaListPage.do" 			class="top-menu-depth1 menu2">Open API 목록</a></li>
			            <li><a href="/portal/openapi/openApiDevPage.do" 			class="top-menu-depth1 menu3">개발가이드</a></li>
			            <li><a href="/portal/gallery/galleryMainPage.do" 	        class="top-menu-depth1 menu4">참여형 플랫폼</a></li>
			            <li><a href="/portal/bbs/noticeapi/searchBulletinPage.do" 	class="top-menu-depth1 menu5">알림마당</a></li>
			            <!-- <li><a href="/portal/openapi/openApiActKeyPage.do" 			class="top-menu-depth1 menu4">마이페이지</a></li> -->
					</ul>
				</div>
			</div>
			<!-- //menu -->
		</div>
	</header>
	<!-- //header -->
	
	<!-- mobile all menu button -->
	<div class="mobile-header-btn">
		<ul>
			<!-- <li><a href="#" class="mh_search">검색</a></li> -->
			<li><a class="mh_allmenu">전체메뉴</a></li>
		</ul>
	</div>
	<!-- //mobile all menu button -->
	
	<div class="totalmenu-mobile">
		<div class="totalmenu-wrapper-mobile">
			<p class="mobile-title">
				전체메뉴
			</p>
			<div class="totalmenu-area-mobile">
				<h2>
					<a class="menu1">Open API 소개<span class="arrow"></span></a>
				</h2>
				<ul class="menu1">
					<li><a href="/portal/openapi/openApiIntroPage.do">Open API 소개</a></li>
					<li><a href="/portal/openapi/openApiFeaturePage.do">Open API 특징</a></li>
					<li><a href="/portal/policy/openUserAgreementPage.do">Open API 이용약관</a></li>
				</ul>
				<h2>
					<a class="menu2">Open API 목록<span class="arrow"></span></a>
				</h2>
				<ul class="menu2">
					<li><a href="/portal/openapi/openApiNaListPage.do">Open API 목록</a></li>
				</ul>
				<h2>
					<a class="menu3">개발가이드<span class="arrow"></span></a>
				</h2>
				<ul class="menu3">
					<li><a href="/portal/openapi/openApiDevPage.do">Open API 사용방법</a></li>
					<li><a href="/portal/openapi/openApiDevLangPage.do">개발소스예제</a></li>
					<li><a href="/portal/openapi/openApiDevSrcPage.do">언어별 개발가이드</a></li>
					
				</ul>
				<h2>
					<a class="menu6">참여형 플랫폼<span class="arrow"></span></a>
				</h2>
				<ul class="menu6">
					<li><a href="/portal/bbs/guide/searchBulletinPage.do">활용 가이드</a></li>
					<li><a href="javacript:;">개발자 공간</a></li>
					<li class="menu_sub_3depth"><a href="/portal/bbs/develop/searchBulletinPage.do">개발자 커뮤니티</a></li>
					<li class="menu_sub_3depth"><a href="/portal/bbs/qnaapi/searchBulletinPage.do">관리자문의</a></li>
					<li class="menu_sub_3depth"><a href="/portal/bbs/faqapi/searchBulletinPage.do">FAQ</a></li>
				</ul>
				<!-- <h2>
					<a class="menu4">마이페이지<span class="arrow"></span></a>
				</h2> -->
				<ul class="menu4">
					<li><a href="/portal/openapi/openApiActKeyPage.do">인증키 발급내역</a></li>
					<li><a href="/portal/openapi/openApiActKeyUsePage.do">인증키 이용내역</a></li>
					<li><a href="/portal/openapi/openApiActKeyIssPage.do">인증키 발급</a></li>
					<li><a href="/portal/openapi/openApiActKeyTestPage.do">Open API 테스트</a></li>
				</ul>
				<h2>
					<a class="menu5">알림마당<span class="arrow"></span></a>
				</h2>
				<ul class="menu5">
					<li><a href="/portal/bbs/noticeapi/searchBulletinPage.do">공지사항</a></li>
				</ul>
			</div>
			<div class="mobile-another-site">
				<a target="_blank" href="/portal/mainPage.do" class="fl">정보공개포털</a>
				<a target="_blank" href="http://www.assembly.go.kr" class="fr">대한민국국회</a>
			</div>
			<div class="login-mobile-area">
				<a href="${getContextPath }/portal/openapi/openApiActKeyPage.do">마이페이지</a>
			</div>
			<c:choose>
		    <c:when test="${!empty sessionScope.portalUserCd}">
			<div class="login-mobile-area">
				<a href="${getContextPath }/portal/user/logout.do">로그아웃</a>
			</div>
		    </c:when>
		    <c:otherwise>
			<div class="login-mobile-area">
			    <a href="${getContextPath }/portal/user/loginPage.do">로그인</a>
			</div>
			</c:otherwise>
		    </c:choose>
		</div>
	</div>
	
	<!-- location -->
	<div class="contents-navigation-area">
		<div class="contents-navigation-box">
			<p class="contents-navigation">
				<span class="icon-home">Home</span>
				<c:if test="${not empty requestScope.menu.lvl1MenuPath }">
					<span class="icon-gt">&gt;</span>
					<span class="location"><c:out value="${requestScope.menu.lvl1MenuPath}" /></span>
				</c:if>
				<c:if test="${not empty requestScope.menu.lvl2MenuPath }">
					<span class="icon-gt">&gt;</span>
					<span class="location"><c:out value="${requestScope.menu.lvl2MenuPath}" /></span>
				</c:if>
				<c:if test="${not empty requestScope.menu.lvl3MenuPath }">
					<span class="icon-gt">&gt;</span>
					<span class="location"><c:out value="${requestScope.menu.lvl3MenuPath}" /></span>
				</c:if>
			</p>
			<div class="sub-function-list">
				<button type="button" class="btn-font-bigger" aria-label="폰트 크기 증가" onclick="zoomOut(); return false;">
				</button>
				<button type="button" class="btn-font-reset" aria-label="폰트 크기 리셋" onclick="zoomReset(); return false;">
				</button>
				<button type="button" class="btn-font-small" aria-label="폰트 크기 감소" onclick="zoomIn(); return false;">
				</button>
			</div>
		</div>
	</div>
	<!-- //location -->