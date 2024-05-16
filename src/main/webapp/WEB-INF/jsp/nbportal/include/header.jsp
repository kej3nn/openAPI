<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%-- @(#)header.jsp 1.0 2018/02/01                                          --%>
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
<%-- 상단 섹션 화면이다.                                                    		--%>
<%--                                                                        --%>
<%-- @author SoftOn                                                         --%>
<%-- @version 1.0 2018/02/01                                                --%>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>

<!-- header --> 
<header id="header">
	<div class="headers">
		<!-- skip navigation -->
		<p class="skip-navigation"> 
			<a href="#contents">본문으로 바로가기</a> 
		</p>
		<!-- //skip navigation -->
		
		<!-- gnb -->
		<div class="gnb-area">
			<div class="gnb-box clear">
				<%-- <ul class="left">
					<li>
						<a target="_blank" href="<c:url value="http://www.nabo.go.kr" />" class="on">국회예산정책처</a>
					</li>
					<li>
						<a target="_blank" href="<c:url value="http://www.assembly.go.kr" />">대한민국 국회</a>
					</li>
				</ul> --%>
	
				<ul class="right">
					<li class="line-none">
						<a href="<c:url value="/portal/main/indexPage.do" />">홈으로</a>
					</li>
					<li>
						<c:choose>
					    <c:when test="${!empty sessionScope.portalUserCd}">
					    <a href="<c:url value="/portal/user/oauth/logout.do" />">로그아웃</a>
					    </c:when>
					    <c:otherwise>
					    <a href="<c:url value="/portal/user/oauth/authorizePage.do" />">로그인</a>
					    </c:otherwise>
					    </c:choose>
					</li>
					<li>
						<a href="<c:url value="/portal/myPage/myPage.do"/>">마이페이지</a>
					</li>
					<li>
						<a href="<c:url value="/portal/intro/siteMapPage.do"/>">사이트맵</a>
					</li>
				</ul>
			</div>
		</div>
		<!-- //gnb -->
	
		<!-- header -->
		<div class="header-area">
			<div class="header-box">
				<h1>
					<a href="<c:url value="/portal/main/indexPage.do" />">
						<img src="<c:url value='/images/soportal/common/logo@2x.png' />" alt="재정경제통계시스템" />
					</a>
				</h1>

				<!-- top menu -->
				<ul class="top-menu">
					<li>
						<a href="<c:url value="/portal/stat/directStatPage.do" />" class="top-menu-depth1 menu1">재정·경제통계</a>
						<ol class="tm01">
							<li><a href="<c:url value="/portal/stat/directStatPage.do" />">간략조회</a></li>
							<li><a href="<c:url value="/portal/stat/easyStatPage.do" />">상세분석</a></li>
							<li><a href="<c:url value="/portal/stat/multiStatPage.do" />">복수통계분석</a></li>
						</ol>
					</li>
					<li>
						<a href="<c:url value="/portal/nabo/naboEvaluationHis1Page.do" />" class="top-menu-depth1 menu2">국회심사연혁</a>
						<ol class="tm02">
							<li><a href="<c:url value="/portal/nabo/naboEvaluationHis1Page.do" />">총수입·총지출 심사연혁</a></li>
							<li><a href="<c:url value="/portal/nabo/naboEvaluationHis2Page.do" />">세입·세출예산 심사연혁</a></li>
							<li><a href="<c:url value="/portal/nabo/naboEvaluationHis3Page.do" />">기금운용계획 심사연혁</a></li>
							<li><a href="<c:url value="/portal/nabo/naboEvaluationHis4Page.do" />">예산부대의견</a></li>
							<li><a href="<c:url value="/portal/nabo/naboEvaluationHis5Page.do" />">결산시정요구 및 조치결과</a></li>
						</ol>
					</li>
					<li>
						<a href="<c:url value="/portal/stat/nabocitDirectStatPage.do" />" class="top-menu-depth1 menu3">위원회별 통계</a>
						<ol class="tm03">
							<li><a href="<c:url value="/portal/stat/nabocitDirectStatPage.do" />">간략조회</a></li>
							<li><a href="<c:url value="/portal/stat/nabocitEasyStatPage.do" />">상세분석</a></li>
						</ol>
					</li>
					<li>
						<a href="<c:url value="/portal/nabo/financeSchoolPage.do" />" class="top-menu-depth1 menu4">지식 자료실</a>
						<ol class="tm04">
							<li><a href="<c:url value="/portal/nabo/financeSchoolPage.do" />">재정·경제교실</a></li>
							<li><a href="<c:url value="/portal/compose/surveyBulletinPage.do" />">통계간행물</a></li>
							<li><a href="<c:url value="/portal/bbs/dic/searchBulletinPage.do" />">용어사전</a></li>
							<li><a href="<c:url value="/portal/nabo/financeIssuePage.do" />">데이터로 보는 재정이슈</a></li> 
						</ol>
					</li>
					<li class="line-none">
						<a href="<c:url value="/portal/bbs/notice/searchBulletinPage.do" />" class="top-menu-depth1 menu5">알림</a>
						<ol class="tm05">
							<li><a href="<c:url value="/portal/bbs/notice/searchBulletinPage.do" />">공지사항</a></li>
							<li><a href="<c:url value="/portal/bbs/faq01/searchBulletinPage.do" />">FAQ</a></li>
							<li><a href="<c:url value="/portal/intro/serviceIntroPage.do" />">서비스 소개</a></li>
							<li><a href="<c:url value="/portal/intro/useIntroPage.do" />">이용안내</a></li>
						</ol>
					</li>
					
				</ul>
				<!-- //top menu -->
	
	
				<!--  통합검색, 전체메뉴 PC 버전 -->
				<div class="search-totalmenu">
					<button class="btn-search">검색</button>
					<div class="mask"></div>
	
					<!-- 통합검색 -->
					<div class="layerpopup-totalsearch-wrapper">
						 <form id="global-search-form" name="global-search-form" method="post">
	       				 <input type="hidden" name="searchWord" />
							<fieldset>
								<legend class="blind">
									통합검색
								</legend>
								<div class="layerpopup-totalsearch-area">
									<h2>
										찾으시는 검색어를 입력해주세요
									</h2>
	
									<div class="layerpopup-totalsearch-box">
										<label class="blind" for="search">통합검색</label>
										<input type="text"  id="search" name="search" title="검색어를 입력하세요." placeholder="검색어를 입력하세요." />
										<input type="submit" id="global-search-button" name="global-search-button" value="검색" />
									</div>
									
									<button type="button" class="btn-totalsearch-close">
										통합검색 창닫기
									</button>
								</div>
							</fieldset>
						</form>
					</div>
					<script type="text/javascript">
				        $(function() {
				            
				            // 통합 검색 검색어 필드에 키다운 이벤트를 바인딩한다.
				            $("#search").bind("keydown", function(event) {
				                if (event.which == 13) {
				                    // 통합 검색을 처리한다.
				                    search();
				                    return false;
				                }
				            });
				            
				            // 통합 검색 버튼에 클릭 이벤트를 바인딩한다.
				            $("#global-search-button").bind("click", function(event) {
				                // 통합 검색을 처리한다.
				                search();
				                return false;
				            });
				            
				            // 통합 검색 버튼에 키다운 이벤트를 바인딩한다.
				            $("#global-search-button").bind("keydown", function(event) {
				                if (event.which == 13) {
				                    // 통합 검색을 처리한다.
				                    search();
				                    return false;
				                }
				            });
				        });
				        
				        /**
				         * 통합 검색을 처리한다.
				         */
				        function search() {
				            
				            var searchWord = htmlTagFilter($("#search").val());
					        if(searchWord == false) {
					        	$("#search").val(""); 
					        	return false;  
					        }
				            
				            if (com.wise.util.isBlank(searchWord)) {
				                alert("검색어를 입력하여 주십시오.");
				                $("#search").focus();
				            }
				            else {
				                // 데이터를 검색하는 화면으로 이동한다.
				                goSearch({
				                    url:"/portal/searchPage.do",
				                    form:"global-search-form",
				                    data:[{
				                        name:"searchWord",
				                        value:searchWord
				                    }]
				                });
				            }
				        }
				
			
				    </script>
					
					<!-- //통합검색 -->
					
					<p class="icon-bar01"></p>
	
					<!-- 전체 메뉴 PC -->
					<button class="btn-totalmenu">전체메뉴</button>
					<div class="totalmenu">
						<div class="totalmenu-wrapper">
							<div class="totalmenu-area menu1">
								<h2>
									<a href="<c:url value="/portal/stat/directStatPage.do" />">
										재정·경제통계
										<span class="arrow"></span>
									</a>
								</h2>
								<ul>
									<li>
										<a href="<c:url value="/portal/stat/directStatPage.do" />" class="menu1-1">
											간략조회
										</a>
									</li>
									<li>
										<a href="<c:url value="/portal/stat/easyStatPage.do" />" class="menu1-2">
											상세분석
										</a>
									</li>
	
									<li>
										<a href="<c:url value="/portal/stat/multiStatPage.do" />" class="menu1-3">
											복수통계분석
										</a>
									</li>
								</ul>
							</div>
	
							<div class="totalmenu-area menu2">
								<h2>
									<a href="<c:url value="/portal/nabo/naboEvaluationHis1Page.do" />">
										국회심사연혁
									</a>
								</h2>
								<ul>
									<li>
										<a href="<c:url value="/portal/nabo/naboEvaluationHis1Page.do" />" class="menu2-1">
											총수입·총지출 심사연혁
										</a>
									</li>	
									<li>
										<a href="<c:url value="/portal/nabo/naboEvaluationHis2Page.do" />" class="menu2-2">
											세입·세출예산 심사연혁
										</a>
									</li>	
									<li>
										<a href="<c:url value="/portal/nabo/naboEvaluationHis3Page.do" />" class="menu2-3">
											기금운용계획 심사연혁
										</a>
									</li>
									<li>
										<a href="<c:url value="/portal/nabo/naboEvaluationHis4Page.do" />" class="menu2-4">
											예산부대의견
										</a>
									</li>
									<li>
										<a href="<c:url value="/portal/nabo/naboEvaluationHis5Page.do" />" class="menu2-5">
											결산시정요구 및 조치결과
										</a>
									</li>
								</ul>
							</div>
							
							<div class="totalmenu-area menu3">
								<h2>
									<a href="<c:url value="/portal/stat/nabocitDirectStatPage.do" />">
										위원회별 통계          
									</a>
								</h2>
								<ul>
									<li>
										<a href="<c:url value="/portal/stat/nabocitDirectStatPage.do" />" class="menu3-1">
											간략조회
										</a>
									</li>
	
									<li>
										<a href="<c:url value="/portal/stat/nabocitEasyStatPage.do" />" class="menu3-2">
											상세분석
										</a>
									</li>
								</ul>
							</div>
	
							<div class="totalmenu-area menu4">
								<h2>
									<a href="<c:url value="/portal/nabo/financeSchoolPage.do" />">
										지식 자료실          
									</a>
								</h2>
								<ul>
									<li>
										<a href="<c:url value="/portal/nabo/financeSchoolPage.do" />" class="menu4-1">
											재정·경제교실
										</a>
									</li>
	
									<li>
										<a href="<c:url value="/portal/compose/surveyBulletinPage.do" />" class="menu4-2">
											통계간행물
										</a>
									</li>
	
									<li>
										<a href="<c:url value="/portal/bbs/dic/searchBulletinPage.do" />" class="menu4-3">
											용어사전
										</a>
									</li>
									
									<li>
										<a href="<c:url value="/portal/nabo/financeIssuePage.do" />" class="menu4-4">
											데이터로 보는 재정이슈
										</a>
									</li>
								</ul>
							</div>

							<div class="totalmenu-area menu5">
								<h2>
									<a href="<c:url value="/portal/bbs/notice/searchBulletinPage.do" />">
										알림
									</a>
								</h2>
	
								<ul>
									<li>
										<a href="<c:url value="/portal/bbs/notice/searchBulletinPage.do" />" class="menu5-1">
											공지사항
										</a>
									</li>
	
									<li>
										<a href="<c:url value="/portal/bbs/faq01/searchBulletinPage.do" />" class="menu5-2">
											FAQ
										</a>
									</li>
									
									<li>
										<a href="<c:url value="/portal/intro/serviceIntroPage.do" />" class="menu5-3">
											서비스 소개
										</a>
									</li>
										<li>
										<a href="<c:url value="/portal/intro/useIntroPage.do" />" class="menu5-4">
											이용안내
										</a>
									</li>
	
								</ul>
							</div>
	
						</div>
					</div>
					<!-- //전체 메뉴 PC -->
	
	
					<!--  전체메뉴 mobile 버전 -->			
					<button class="btn-totalmenu-mobile">전체메뉴</button>
					<div class="totalmenu-mobile">
						<div class="totalmenu-wrapper-mobile">
							<p class="mobile-title">
								전체메뉴
							</p>
	
							<div class="totalmenu-area-mobile">
								<h2>
									<a href="#재정·경제통계" class="menu1">
										재정·경제통계
										<span class="arrow"></span>
									</a>
								</h2>
								<ul class="menu1">
									<li>
										<a href="<c:url value="/portal/stat/directStatPage.do" />" class="menu1-1">
											간략조회
										</a>
									</li>
									<li>
										<a href="<c:url value="/portal/stat/easyStatPage.do" />" class="menu1-2">
											상세분석
										</a>
									</li>
	
									<li>
										<a href="<c:url value="/portal/stat/multiStatPage.do" />" class="menu1-3">
											복수통계분석
										</a>
									</li>
								</ul>
	
								<h2>
									<a href="#국회심사연혁" class="menu2">
										국회심사연혁 
										<span class="arrow"></span>
									</a>
								</h2>
								<ul class="menu2">
									<li>											
										<a href="<c:url value="/portal/nabo/naboEvaluationHis1Page.do" />" class="menu2-1">
											총수입·총지출 심사연혁
										</a>
									</li>
									<li>											
										<a href="<c:url value="/portal/nabo/naboEvaluationHis2Page.do" />" class="menu2-2">
											세입·세출예산 심사연혁
										</a>
									</li>
									<li>											
										<a href="<c:url value="/portal/nabo/naboEvaluationHis3Page.do" />" class="menu2-3">
											기금운용계획 심사연혁
										</a>
									</li>
									<li>											
										<a href="<c:url value="/portal/nabo/naboEvaluationHis4Page.do" />" class="menu2-4">
											예산부대의견
										</a>
									</li>
									<li>											
										<a href="<c:url value="/portal/nabo/naboEvaluationHis5Page.do" />" class="menu2-5">
											결산시정요구 및 조치결과
										</a>
									</li>

								</ul>
								
								<h2>
									<a href="#위원회별통계" class="menu3">
										위원회별 통계
										<span class="arrow"></span>
									</a>
								</h2>
								<ul class="menu3">
									<li>
										<a href="<c:url value="/portal/stat/nabocitDirectStatPage.do" />" class="menu3-1">
											간략조회
										</a>
									</li>
	
									<li>
										<a href="<c:url value="/portal/stat/nabocitEasyStatPage.do" />" class="menu3-2">
											상세조회
										</a>
									</li>
	
								</ul>
								
								<h2>
									<a href="#지식자료실" class="menu4">
										지식 자료실
										<span class="arrow"></span>
									</a>
								</h2>
								<ul class="menu4">
									<li>
										<a href="<c:url value="/portal/nabo/financeSchoolPage.do" />" class="menu4-1">
											재정·경제교실
										</a>
									</li>
	
									<li>
										<a href="<c:url value="/portal/compose/surveyBulletinPage.do" />" class="menu4-2">
											통계간행물
										</a>
									</li>
	
									<li>
										<a href="<c:url value="/portal/bbs/dic/searchBulletinPage.do" />" class="menu4-3">
											용어사전
										</a>
									</li>
									
									<li>
										<a href="<c:url value="/portal/nabo/financeIssuePage.do" />" class="menu4-4">
											데이터로 보는 재정이슈
										</a>
									</li>
								</ul>
								<h2>
									<a href="#알림" class="menu5">
										알림
										<span class="arrow"></span>
									</a>
								</h2>
								<ul class="menu5">
									<li>
										<a href="<c:url value="/portal/bbs/notice/searchBulletinPage.do" />" class="menu5-1">
											공지사항
										</a>
									</li>
	
									<li>
										<a href="<c:url value="/portal/bbs/faq01/searchBulletinPage.do" />" class="menu5-2">
											FAQ
										</a>
									</li>
									
									<li>
										<a href="<c:url value="/portal/intro/serviceIntroPage.do" />" class="menu5-3">
											서비스 소개
										</a>
									</li>
										<li>
										<a href="<c:url value="/portal/intro/useIntroPage.do" />" class="menu5-4">
											이용안내
										</a>
									</li>
	
								</ul>
	
							</div>
									
	
							<div class="mobile-another-site">
								<a target="_blank" href="<c:url value="http://www.nabo.go.kr" />">
									국회예산정책처
								</a>
							</div>
							<c:choose>
						    <c:when test="${!empty sessionScope.portalUserCd}">
							<div class="mobile-another-site">
								<a href="<c:url value="/portal/myPage/myPage.do" />">
									마이페이지
								</a>
							</div>
							<div class="login-mobile-area">
								<a href="<c:url value="/portal/user/oauth/logout.do" />">로그아웃</a>
							</div>
						    </c:when>
						    <c:otherwise>
							<div class="login-mobile-area">
							    <a href="<c:url value="/portal/user/oauth/authorizePage.do" />">로그인</a>
							</div>
							</c:otherwise>
						    </c:choose>
						</div>
					</div>
				</div>
			</div>
		</div>
		<!-- //header -->
	</div>
	
</header>
<!-- //header -->
			
	    