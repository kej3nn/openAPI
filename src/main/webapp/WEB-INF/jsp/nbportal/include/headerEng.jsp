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
	<div class="header">
		<!-- skip navigation -->
		<p class="skip-navigation"> 
			<a href="#contents">Skip to Container</a> 
		</p>
		<!-- //skip navigation -->
		
		<!-- gnb -->
		<div class="gnb-area">
			<div class="gnb-box clear">
				<ul class="left">
					<li>
						<a target="_blank" href="<c:url value="https://www.hf.go.kr/ehf/index.do" />" class="on">HF</a>
					</li>
					<li>
						<a href="<c:url value="/portal/main/indexPage.do" />" class="line-none">Korean</a>
					</li>
				</ul>
	
				<ul class="right">
					<li class="line-none">
						<a href="<c:url value="/portal/main/indexEngPage.do" />">HOME</a>
					</li>
					<li>
						<a href="<c:url value="/portal/intro/siteMapEngPage.do"/>">Site Map</a>
					</li>
				</ul>				
			</div>
		</div>
		<!-- //gnb -->
	
		<!-- header -->
		<div class="header-area">
			<div class="header-box">
				<h1>
					<a href="<c:url value="/portal/main/indexEngPage.do" />">
						<img src="<c:url value='/images/hfportalEng/common/logo@2x.png' />" alt="HF 한국주택금융공사 - 주택금융통계정보시스템" />
					</a>
				</h1>
			
				<!-- top menu -->
				<ul class="top-menu">
					<li class="menu1">
						<a href="<c:url value="/portal/stat/easyStatEngPage.do" />" class="top-menu-depth1 menu1">Search Stat</a>
					</li>
					<li class="menu2">
						<a href="<c:url value="/portal/theme/indexStatEngPage.do" />" class="top-menu-depth1 menu2">Theme Stat</a>
					</li>
					<li class="menu3">
						<a href="<c:url value="/portal/bbs/noticeeng/searchBulletinPage.do" />" class="top-menu-depth1 menu3">Notice</a>
					</li>
					<li class="menu6">
						<a href="<c:url value="/portal/intro/serviceIntroEngPage.do" />" class="top-menu-depth1 menu6">Introduction</a>
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
									Total Search
								</legend>
								<div class="layerpopup-totalsearch-area">
									<h2>
										Enter to Search Keyword
									</h2>
	
									<div class="layerpopup-totalsearch-box">
										<label class="blind" for="search">Total Search</label>
										<input type="text"  id="search" name="search" title="Enter to Search Keyword" placeholder="Enter to Search Keyword" />
										<input type="submit" id="global-search-button" name="global-search-button" value="Search" />
									</div>
									
									<button type="button" class="btn-totalsearch-close">
										Total Search Close
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
				            var searchWord = $("#search").val();
				            
				            if (com.wise.util.isBlank(searchWord)) {
				                alert("Enter your search terms");
				                $("#search").focus();
				            }
				            else {
				                // 데이터를 검색하는 화면으로 이동한다.
				                goSearch({
				                    url:"/portal/searchEngPage.do",
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
					<button class="btn-totalmenu">Total Search</button>
					<div class="totalmenu">
						<div class="totalmenu-wrapper">
							<div class="totalmenu-area menu1">
								<ul>
									<li>
										<a href="<c:url value="/portal/stat/easyStatEngPage.do" />" class="menu1-1">
											Simple Search
										</a>
									</li>

									<li>
										<a href="<c:url value="/portal/stat/multiStatEngPage.do" />" class="menu1-2">
											Multiple Search
										</a>
									</li>

									<li>
										<a href="<c:url value="/portal/compose/announceEngPage.do" />" class="menu1-3">
											Statistical Calendar
										</a>
									</li>
								</ul>
							</div>

							<div class="totalmenu-area menu2">
								<ul>
									<li>
										<a href="<c:url value="/portal/theme/indexStatEngPage.do" />" class="menu2-1">
											Housing Finance Index
										</a>
									</li>

									<li>
										<a href="<c:url value="/portal/theme/lookStatEngPage.do" />" class="menu2-2">
											Principal Indicator
										</a>
									</li>
	
									<li>
										<a href="<c:url value="/portal/theme/mapStatEngPage.do" />" class="menu2-3">
											Map Stat
										</a>
									</li>
									
									<li>
										<a href="<c:url value="/portal/theme/hitStatEngPage.do" />" class="menu2-4">
											Popular Stat
										</a>
									</li>
								</ul>
							</div>

							<div class="totalmenu-area menu3">
								<ul>
									<li>
										<a href="<c:url value="/portal/bbs/noticeeng/searchBulletinPage.do" />" class="menu3-1">
											Notice
										</a>
									</li>
								</ul>
							</div>

							<div class="totalmenu-area menu6">
								<ul>
									<li>
										<a href="<c:url value="/portal/intro/serviceIntroEngPage.do" />" class="menu6-1">
											Introduction
										</a>
									</li>

									<li>
										<a href="<c:url value="/portal/intro/useIntroEngPage.do" />" class="menu6-2">
											Service Guide
										</a>
									</li>
								</ul>
							</div>


						</div>
					</div>
					<!-- //전체 메뉴 PC -->


					<!--  전체메뉴 mobile 버전 -->			
					<button class="btn-totalmenu-mobile">TOTAL MENU</button>
					<div class="totalmenu-mobile">
						<div class="totalmenu-wrapper-mobile">
							<p class="mobile-title">
								TOTAL MENU
							</p>

							<div class="totalmenu-area-mobile">
								<h2>
									<a href="#Search Stat" class="menu1">
										Search Stat 
										<span class="arrow"></span>
									</a>
								</h2>
								<ul class="menu1">
									<li>
										<a href="<c:url value="/portal/stat/easyStatEngPage.do" />" class="menu1-1">
											Simple Search
										</a>
									</li>

									<li>
										<a href="<c:url value="/portal/stat/multiStatEngPage.do" />" class="menu1-2">
											Multiple Search
										</a>
									</li>

									<li>
										<a href="<c:url value="/portal/compose/announceEngPage.do" />" class="menu1-3">
											Statistical Calendar
										</a>
									</li>
								</ul>

								<h2>
									<a href="#Theme Stat" class="menu2">
										Theme Stat
										<span class="arrow"></span>
									</a>
								</h2>
								<ul class="menu2">
									<li>
										<a href="<c:url value="/portal/theme/indexStatEngPage.do" />" class="menu2-1">
											Housing Finance Index
										</a>
									</li>
	
									<li>
										<a href="<c:url value="/portal/theme/lookStatEngPage.do" />" class="menu2-2">
											Principal Indicator
										</a>
									</li>
	
									<li>
										<a href="<c:url value="/portal/theme/mapStatEngPage.do" />" class="menu2-4">
											Map Stat
										</a>
									</li>
									
									<li>
										<a href="<c:url value="/portal/theme/hitStatEngPage.do" />" class="menu2-3">
											Popular Stat
										</a>
									</li>
								</ul>

								<h2>
									<a href="#Notice" class="menu3">
										Notice
										<span class="arrow"></span>
									</a>
								</h2>
								<ul class="menu3">
									<li>
										<a href="<c:url value="/portal/bbs/noticeeng/searchBulletinPage.do" />" class="menu3-1">
											Notice
										</a>
									</li>
								</ul>

								<h2>
									<a href="#Introduction" class="menu4">
										Introduction
										<span class="arrow"></span>
									</a>
								</h2>
								<ul class="menu6">
									<li>
										<a href="<c:url value="/portal/intro/serviceIntroEngPage.do" />" class="menu6-1">
											Introduction
										</a>
									</li>
									<li>
										<a href="<c:url value="/portal/intro/useIntroEngPage.do" />" class="menu6-2">
											Service Guide
										</a>
									</li>
									
								</ul>
							</div>
									

							<div class="mobile-another-site">
								<a href="<c:url value="/portal/main/indexPage.do" />" class="fl">
									Korean
								</a>

								<a target="_blank" href="<c:url value="http://www.nabo.go.kr" />" class="fr">
									About NABO
								</a>
							</div>
							
						</div>
					</div>
				</div>
			</div>
		</div>
		<!-- //header -->
	</div>


</header>
<!-- //header -->
			
	    