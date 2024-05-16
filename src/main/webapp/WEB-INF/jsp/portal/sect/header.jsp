<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="egovframework.ggportal.user.web.PortalUserController" %>

<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%-- @(#)header.jsp 1.0 2019/08/12                                          --%>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>

<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%-- 상단 섹션 화면이다.                                                    --%>
<%--                                                                        --%>
<%-- @author JHKIM                                                         --%>
<%-- @version 1.0 2019/08/12                                                --%>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>


<!-- skip navigation -->
<p class="skip-navigation">
	<a href="#contents">본문으로 바로가기</a>
</p>
<!-- //skip navigation -->

<c:if test="${not empty homeTopA && not empty homeTopA}">
<!-- 상단 공지사항 -->
<div class="top_notice" style="display:none;">
	<div>
		<!-- <h3>공지사항</h3> -->
		<div class="top_notice_text">
			<ul id="topinfo-sect">
				<c:forEach var="homeTopA" items="${homeTopA }" varStatus="status">
				<li>
					<a href="${homeTopA.linkUrl}" target=_blank style="width: 750px;">
						<strong><em>공지사항</em> ${homeTopA.srvNm}</strong>
						<span>자세히보기</span>
					</a>
				</li>
				</c:forEach>
				<c:forEach var="homeTopB" items="${homeTopB }" varStatus="status">
				<li style="width: 750px;">
					<a href="${homeTopB.linkUrl}" target=_blank style="width: 750px;">
						<strong><em>새소식</em> ${homeTopB.srvNm}</strong>
						<span>자세히보기</span>
					</a>
				</li>
				</c:forEach>
			</ul>
		</div>
		<div class="top_notice_check">
			<ul>
				<li class="btn_top_prev"><a href="javascript:;" id="ti_prev">이전</a></li>
				<li class="btn_top_next"><a href="javascript:;" id="ti_next">다음</a></li>
			</ul>
			<div>
				<input type="checkbox" name="topNotice" id="topNotice">
				<label for="topNotice">오늘은 다시 보지 않음</label>
			</div>
			<a href="javascript:;" class="btn_top_x">닫기</a>
		</div>
	</div>
</div>
</c:if>

<!-- header -->
<header id="header">
	<div class="headers">
		
		<!-- gnb -->
		<div class="gnb-area">
			<div class="gnb-box clear">
				<ul class="left">
					<li><a target="_top" href="/" class="on">정보공개포털</a></li>
					<li><a target="_blank" href="${getContextPath }/portal/openapi/main.do" title="새창열림 Open API">Open API</a></li>
					<li><a target="_blank" href="https://www.assembly.go.kr" title="새창열림 대한민국국회">대한민국국회</a></li>
				</ul>
				<ul class="right">
					<c:choose>
				    <c:when test="${!empty sessionScope.portalUserCd}">
				    <li class="line-none"><a target="_top" href="${getContextPath }/portal/user/logout.do">로그아웃</a></li>
				    <li><a target="_top" href="${getContextPath }/portal/myPage/myQnaPage.do">마이페이지</a></li>
				    </c:when>
				    <c:otherwise>
				    <li class="line-none"><a target="_top" href="${getContextPath }/portal/user/loginPage.do">로그인</a></li>
				    <li><a href="https://member.assembly.go.kr/member/join/joinSelectPage.do" target="_blank">회원가입</a></li>
				    </c:otherwise>
				    </c:choose>

					<li><a target="_top" href="${getContextPath }/portal/bbs/faq01/searchBulletinPage.do">FAQ</a></li>
					<li><a target="_top" href="${getContextPath }/infonavi" class="icon_compass">국회 정보나침반</a></li>
					<li><a target="_top" href="${getContextPath }/portal/view/sitemapPage.do">사이트맵</a></li>
					<c:if test="${!empty sessionScope.loginRno1 && empty sessionScope.portalUserCd}">
					<li><a target="_top" href="${getContextPath }/portal/expose/certout.do">인증해제</a></li>
					</c:if>
				</ul>
			</div>
		</div>
		<!-- //gnb -->
			
		<!-- menu -->
		<div class="header-area">
			<div class="header-box">
				<h1>
					<a href="/"> <img src="/images/logo.png" alt="열린국회정보 정보공개포털">
					</a>
				</h1>
				<div class="menulayer01">				
					<ul class="top-menu">
						<li>
							<a target="_top" href="/portal/infs/cont/infsContPage.do?cateId=NA10000" class="top-menu-depth1 menu1" id="firstMenu">국회의원</a>
							<div class="menu1">
								<ul>
									<c:forEach var="menu" items="${requestScope.menuLst }">
										<c:if test="${menu.parId eq 'NA10000' and viewYn ne 'N' }">
											<li><a target="_top" href="${getContextPath }${menu.url }">${menu.title }</a></li>
										</c:if>
									</c:forEach>
								</ul>
							</div>
						</li>
						<li>
							<a target="_top" href="/portal/infs/cont/infsContPage.do?cateId=NA40000" class="top-menu-depth1 menu2">의정활동별 공개</a>
							<div class="menu2">
								<ul>
									<c:forEach var="menu" items="${requestScope.menuLst }">
										<c:if test="${menu.parId eq 'NA40000' and viewYn ne 'N' }">
											<li><a target="_top" href="${getContextPath }${menu.url }">${menu.title }</a></li>
										</c:if>
									</c:forEach>
								</ul>
							</div>
						</li>
						<li>
							<a target="_top" href="/portal/infs/cont/infsContPage.do?cateId=NA20000" class="top-menu-depth1 menu3">주제별 공개</a>
							<div class="menu3">
								<ul>
									<c:forEach var="menu" items="${requestScope.menuLst }">
										<c:if test="${menu.parId eq 'NA20000' and viewYn ne 'N' }">
											<li><a target="_top" href="${getContextPath }${menu.url }">${menu.title }</a></li>
										</c:if>
									</c:forEach>
								</ul>
							</div>
						</li>
						<li>
							<a target="_top" href="/portal/infs/cont/infsContPage.do?cateId=NA50000" class="top-menu-depth1 menu5">보고서·발간물</a>
							<div class="menu5">
								<ul>
									<c:forEach var="menu" items="${requestScope.menuLst }">
										<c:if test="${menu.parId eq 'NA50000' and viewYn ne 'N' }">
											<li><a target="_top" href="${getContextPath }${menu.url }">${menu.title }</a></li>
										</c:if>
									</c:forEach>
								</ul>
							</div>
						</li>
						<li>
							<a target="_top" href="/portal/exposeInfo/guideOpnInfoPage.do" class="top-menu-depth1 menu6">정보공개청구</a>
							<div class="menu6">
								<ul>
									<c:forEach var="menu" items="${requestScope.menuLst }">
										<c:if test="${menu.parId eq 'EX10000' and viewYn ne 'N'}">
											<li><a target="_top" href="${getContextPath }${menu.url }">${menu.title }</a></li>
										</c:if>
									</c:forEach>
								</ul>
							</div>
						</li>
						<li>
							<a href="javascript: gfn_showMindmap('fstMindmap');" class="top-menu-depth1 menu7" id="fstMindmap">마인드맵</a>
							<div class="menu7">
								<ul>
									<li><a href="javascript: gfn_showMindmap('fstEleMindmap');" id="fstEleMindmap">마인드맵</a></li>
									<li><a id="lastMenu01" target="_top" href="${getContextPath }/portal/infs/list/infsListDownPage.do">국회정보 일괄 다운로드</a></li>
								</ul>
							</div>
						</li>
					</ul>
					<div class="menu_new_more" id="moreFirst">
						<a href="javascript:;" title="전체메뉴 더보기">더보기</a>
					</div>
				</div>
				<div class="menulayer02">
					<ul class="top-menu">
						<li>
							<a target="_top" href="javascript: gfn_showTotalsch('fstTotalSch');" class="top-menu-depth1 menu1" id="fstTotalSch">통합검색</a>
							<div class="menu1">
								<ul>
									<li><a href="javascript: gfn_showTotalsch('trdTotalSch');" id="trdTotalSch">통합검색</a></li>
								</ul>
							</div>
						</li>
						<li>
							<a target="_top" href="/infonavi" class="top-menu-depth1 menu2">국회 정보나침반</a>
							<div class="menu2">
								<ul>
									<c:forEach var="menu" items="${requestScope.menuLst }">
										<c:if test="${menu.parId eq 'NO20000' and viewYn ne 'N' }">
											<li><a target="_top" href="${getContextPath }${menu.url }">${menu.title }</a></li>
										</c:if>
									</c:forEach>
								</ul>
							</div>
						</li>
						<li>
							<a target="_top" href="/portal/theme/visual/searchVisualPage.do" class="top-menu-depth1 menu3">테마 정보공개</a>
							<div class="menu3">
								<ul>
									<c:forEach var="menu" items="${requestScope.menuLst }">
										<c:if test="${menu.parId eq 'NO30000' and viewYn ne 'N' }">
											<li><a target="_top" href="${getContextPath }${menu.url }">${menu.title }</a></li>
										</c:if>
									</c:forEach>
								</ul>
							</div>
						</li>
						<li>
							<a target="_top" href="/portal/bbs/notice/searchBulletinPage.do" class="top-menu-depth1 menu4">알림마당</a>
							<div  class="menu4">
								<ul>
									<c:forEach var="menu" items="${requestScope.menuLst }">
										<c:if test="${menu.parId eq 'NO40000' and viewYn ne 'N' }">
											<li><a target="_top" href="${getContextPath }${menu.url }">${menu.title }</a></li>
										</c:if>
									</c:forEach>
								</ul>
							</div>
						</li>
						<li>
							<a target="_top" href="/portal/intro/serviceIntroPage.do" class="top-menu-depth1 menu5">서비스 소개</a>
							<div class="menu5">
								<ul>
									<c:forEach var="menu" items="${requestScope.menuLst }">
										<c:if test="${menu.parId eq 'NO50000' and viewYn ne 'N' }">
											<li><a target="_top" href="${getContextPath }${menu.url }">${menu.title }</a></li>
										</c:if>
									</c:forEach>
								</ul>
							</div>
						</li>
						<li>
							<a target="_top" href="/portal/myPage/myQnaPage.do" class="top-menu-depth1 menu6">마이페이지</a>
							<div class="menu6">
								<ul>
									<c:forEach var="menu" items="${requestScope.menuLst }">
										<c:if test="${menu.parId eq 'NO60000' and viewYn ne 'N' }">
											<li><a target="_top" href="${getContextPath }${menu.url }">${menu.title }</a></li>
										</c:if>
									</c:forEach>
								</ul>
							</div>
						</li>
						<li>
							<a href="javascript: gfn_showMindmap('secMindmap');" class="top-menu-depth1 menu7" id="secMindmap">마인드맵</a>
							<div class="menu7">
								<ul>
									<li><a href="javascript: gfn_showMindmap('secEleMindmap');" id="secEleMindmap">마인드맵</a></li>
									<li><a id="lastMenu02" target="_top" href="${getContextPath }/portal/infs/list/infsListDownPage.do">국회정보 일괄 다운로드</a></li>
								</ul>
							</div>
						</li>
					</ul>
					<div class="menu_new_more" id="moreSecond">
						<a href="javascript:;" title="전체메뉴 더보기">더보기</a>
					</div>
				</div>
				<div class="menu_more_btn">
					<a href="#" title="전체메뉴 더보기">더보기</a>
				</div>
			</div>
		</div>
		<!-- //menu -->
	</div>
</header>
<!-- //header -->

<!-- all menu -->
<div class="allmenu" style="display:none;">
	<div class="allmenu_inner">
	</div>
</div>
<!-- //all menu -->

<!-- mobile all menu button -->
<div class="mobile-header-btn">
	<ul>
		<li><a href="javascript: gfn_showTotalsch('quickTotalSch');" class="mh_search">검색</a></li>
		<li><a href="#" class="mh_allmenu">전체메뉴</a></li>
	</ul>
</div>
<!-- //mobile all menu button -->

<!-- 전체 메뉴 mobile -->
<div class="totalmenu-mobile" style="display:none;">
	<div class="totalmenu-wrapper-mobile">
		<p class="mobile-title">
			전체메뉴
		</p>
		<div class="totalmenu-area-mobile">
			<h2>
				<a target="_top" href="javascript:;" class="menu1">국회의원<span class="arrow"></span></a>
			</h2>
			<ul class="menu1">
				<c:forEach var="menu" items="${requestScope.menuLst }">
					<c:if test="${menu.parId eq 'NA10000' and viewYn ne 'N' }">
						<li><a target="_top" href="${getContextPath }${menu.url }">${menu.title }</a></li>
					</c:if>
				</c:forEach>
			</ul>
			<h2>
				<a target="_top" href="javascript:;" class="menu4">의정활동별 공개<span class="arrow"></span></a>
			</h2>
			<ul class="menu4" style="display: none;">
				<c:forEach var="menu" items="${requestScope.menuLst }">
					<c:if test="${menu.parId eq 'NA40000' and viewYn ne 'N' }">
						<li><a target="_top" href="${getContextPath }${menu.url }">${menu.title }</a></li>
					</c:if>
				</c:forEach>
			</ul>
			<h2>
				<a target="_top" href="javascript:;" class="menu2">주제별 공개<span class="arrow"></span></a>
			</h2>
			<ul class="menu2" style="display: none;">
				<c:forEach var="menu" items="${requestScope.menuLst }">
					<c:if test="${menu.parId eq 'NA20000' and viewYn ne 'N' }">
						<li><a target="_top" href="${getContextPath }${menu.url }">${menu.title }</a></li>
					</c:if>
				</c:forEach>
			</ul>
			<!--
			<h2>
				<a href="#" class="menu3">지원조직별 공개<span class="arrow"></span></a>
			</h2>
			<ul class="menu3" style="display: none;">
				<c:forEach var="menu" items="${requestScope.menuLst }">
					<c:if test="${menu.parId eq 'NA30000' and viewYn ne 'N' }">
						<li><a href="${getContextPath }${menu.url }">${menu.title }</a></li>
					</c:if>
				</c:forEach>
			</ul>
			 -->
			<h2>
				<a target="_top" href="javascript:;" class="menu5">보고서·발간물<span class="arrow"></span></a>
			</h2>
			<ul class="menu5" style="display: none;">
				<c:forEach var="menu" items="${requestScope.menuLst }">
					<c:if test="${menu.parId eq 'NA50000' and viewYn ne 'N' }">
						<li><a target="_top" href="${getContextPath }${menu.url }">${menu.title }</a></li>
					</c:if>
				</c:forEach>
			</ul>
			<h2>
				<a target="_top" href="javascript:;" class="menu6">정보공개 청구<span class="arrow"></span></a>
			</h2>
			<ul class="menu6" style="display: none;">
				<c:forEach var="menu" items="${requestScope.menuLst }">
					<c:if test="${menu.parId eq 'EX10000' and viewYn ne 'N' }">
						<li><a target="_top" href="${getContextPath }${menu.url }">${menu.title }</a></li>
					</c:if>
				</c:forEach>
			</ul>
			<h2>
				<a target="_top" href="javascript:;" class="menu8">정보나침반<span class="arrow"></span></a>
			</h2>
			<ul class="menu8" style="display: none;">
				<c:forEach var="menu" items="${requestScope.menuLst }">
					<c:if test="${menu.parId eq 'NO20000' and viewYn ne 'N' }">
						<li><a target="_top" href="${getContextPath }${menu.url }">${menu.title }</a></li>
					</c:if>
				</c:forEach>
			</ul>
			<h2>
				<a target="_top" href="javascript:;" class="menu9">테마 정보공개<span class="arrow"></span></a>
			</h2>
			<ul class="menu9" style="display: none;">
				<c:forEach var="menu" items="${requestScope.menuLst }">
					<c:if test="${menu.parId eq 'NO30000' and viewYn ne 'N' }">
						<li><a target="_top" href="${getContextPath }${menu.url }">${menu.title }</a></li>
					</c:if>
				</c:forEach>
			</ul>
			<h2>
				<a target="_top" href="javascript:;" class="menu10">알림마당<span class="arrow"></span></a>
			</h2>
			<ul class="menu10" style="display: none;">
				<c:forEach var="menu" items="${requestScope.menuLst }">
					<c:if test="${menu.parId eq 'NO40000' and viewYn ne 'N' }">
						<li><a target="_top" href="${getContextPath }${menu.url }">${menu.title }</a></li>
					</c:if>
				</c:forEach>
			</ul>
			<h2>
				<a target="_top" href="javascript:;" class="menu11">서비스 소개<span class="arrow"></span></a>
			</h2>
			<ul class="menu11" style="display: none;">
				<c:forEach var="menu" items="${requestScope.menuLst }">
					<c:if test="${menu.parId eq 'NO50000' and viewYn ne 'N' }">
						<li><a target="_top" href="${getContextPath }${menu.url }">${menu.title }</a></li>
					</c:if>
				</c:forEach>
			</ul>
			<h2>
				<a target="_top" href="javascript:;" class="menu12">마이페이지<span class="arrow"></span></a>
			</h2>
			<ul class="menu12" style="display: none;">
				<c:forEach var="menu" items="${requestScope.menuLst }">
					<c:if test="${menu.parId eq 'NO60000' and viewYn ne 'N' }">
						<li><a target="_top" href="${getContextPath }${menu.url }">${menu.title }</a></li>
					</c:if>
				</c:forEach>
			</ul>
		</div>
		<div class="mobile-another-site">
			<a target="_blank" href="/portal/openapi/main.do" class="fl">Open API</a>
			<a target="_blank" href="https://www.assembly.go.kr" class="fr">대한민국국회</a>
		</div>
		<c:choose>
	    <c:when test="${!empty sessionScope.portalUserCd}">
		
		<div class="login-mobile-area">
			<a target="_top" href="${getContextPath }/portal/user/logout.do">로그아웃</a>
		</div>
	    </c:when>
	    <c:otherwise>
		<div class="login-mobile-area">
		    <a target="_top" href="${getContextPath }/portal/user/loginPage.do">로그인</a>
		</div>
		</c:otherwise>
	    </c:choose>
	</div>
</div>
<!-- //전체 메뉴 mobile -->

<div class="moremenu" style="display:none;">
	<div class="moremenu_inner">
		<!-- 
		<div class="menu_new_more" id="moreSecond">
			<a href="javascript:;" title="전체메뉴 더보기">더보기</a>
		</div>
		 -->
	</div>
</div>

<!-- location -->
<div class="contents-navigation-area">
	<div class="contents-navigation-box">
		<p class="contents-navigation">
			<span class="icon-home">Home</span>
			<c:if test="${not empty requestScope.menu.lvl1MenuPath }">
				<span class="icon-gt">&gt;</span>
				<span class="location"><c:out value="${fn:replace(requestScope.menu.lvl1MenuPath, '&amp;', '&')}"/></span>
			</c:if>
			<c:if test="${not empty requestScope.menu.lvl2MenuPath }">
				<span class="icon-gt">&gt;</span>
				<span class="location"><c:out value="${requestScope.menu.lvl2MenuPath}" /></span>
			</c:if>
			<c:if test="${not empty requestScope.menu.lvl3MenuPath }">
				<span class="icon-gt">&gt;</span>
				<span class="location"><c:out value="${requestScope.menu.lvl3MenuPath}" /></span>
			</c:if>
			<!-- <strong>정보공개목록</strong> -->
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

<!-- quick menu -->
<div class="quick_menu">
	<div>
		<div class="quick_search">
			<a href="javascript: gfn_showTotalsch('quickTotalSch');" id="quickTotalSch">통합검색</a>
		</div>
		<div>
			<ul>
				<li class="qm01"><a target="_top" href="<c:url value="/portal/assm/search/memberSchPage.do"/>">제21대 국회의원 검색</a></li>
				<li class="qm02"><a target="_top" href="<c:url value="/portal/bpm/prc/prcMstPage.do"/>">의정활동 통합현황</a></li>
				<li class="qm03"><a target="_top" href="<c:url value="/portal/exposeInfo/guideOpnInfoPage.do"/>">정보공개청구</a></li>
				<li class="qm04"><a href="<c:url value="/portal/openapi/main.do"/>" target="_blank" title="새창열림_Open API">Open API</a></li>
				<li class="qm05"><a target="_top" href="<c:url value="/infonavi"/>">국회 정보나침반</a></li>
			</ul>
			<a href="#">TOP</a>
		</div>
	</div>
	<input type="hidden" name="showTotalSch" title="showTotalSch">
	<!-- <a href="#" class="new_alram">새글</a> -->
</div>
<!-- //quick menu -->

<!-- 통합검색 layer -->
<div class="all_search" style="display:none;" id="global-totalsch-sect">
	<div class="all_search_inner">
		<div class="visual_slogan">
			<strong>국회를 열다, 정보를 나누다.</strong>
			<p>
				"열린국회정보"는 굳게 닫혀있던 문을 활짝 열어,<br>
				국회의 모든 정보를 국민 여러분과 나누겠습니다.
			</p>
			<form id="global-sf1Form" method="post" action="/portal/search/searchPage.do">
				<div class="main_search">
					<input type="text" id="global-totalsch-val" name="query" title="검색어 입력">
					<button type="button" id="global-totalsch-btn">검색</button>
				</div>
			</form>
			<!-- 2020. 03. 19. 인기검색어 잠정 삭제 -->
			<!-- <div class="main_search_recent" id="global-totalSch-recent">
				<strong>인기</strong>
				<ul id="global-totalSch-recent-list"></ul>
			</div> -->
		</div>
		<a href="javascript: gfn_hideTotalsch();" class="btn_allmenu_x">close</a>
	</div>
	<div class="bgshadow"></div>
</div>
<!-- //통합검색 layer -->


<!-- 마인드맵 layer -->
<div class="mindmap_popup" style="display: none;" id="global-mindmap-sect">
	<div class="main_mindmap" style="width:1500px;">
		<div class="mindmap_header">
			<span>국회를 열다, 정보를 나누다.</span>
		</div>
		<div id="global-mindmap-obj" style="display:block;width:1500px; height:900px;" tabIndex="0"></div>
		<a href="javascript: gfn_hideMindmap();" class="btn_mindmap_close">close</a>
	</div>
	<div class="bgshadow"></div>
	<input type="hidden" name="mindmapCloseLoc" title="mindmapCloseLoc">
</div>
<!-- //마인드맵 layer -->

<c:set var="isInfsPop" value="${param.isInfsPop}"  scope="request"></c:set>