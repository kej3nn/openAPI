<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%-- @(#)naDataSitemap.jsp 1.0 2019/09/11                                   --%>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%-- 정보서비스 사이트맵을 조회하는 화면이다.                                --%>
<%--                                                                        --%>
<%-- @author CSB                                                         --%>
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
	<form id="searchForm">
	<!-- container -->
	<section>
		<div class="container hide-pc-lnb" id="container">
			<nav>
				<div class="lnb">
					<h2>국회 정보나침반</h2> 
					<ul>
						<li>
							<span><a href="/portal/nadata/sitemap/naDataSitemapPage.do" class="on">정보서비스 사이트맵</a></span>
						</li>
						<li>
							<span><a href="/portal/nadata/catalog/naDataCatalogPage.do">정보서비스 카탈로그</a></span>
						</li>
					</ul>
				</div>
			</nav>	
	    <!-- content -->
	    <article>
			<div class="contents" id="contents">
	        	<div class="contents-title-wrapper">
		            <h3>국회 정보나침반<span class="arrow"></span></h3>
	        	</div>
	        
				<!-- CMS 시작 -->
		        <div class="layout_flex_100">
					<div class="toplevel_tab">
				        <ul>
						    <li><a href="/portal/nadata/sitemap/naDataSitemapPage.do" class="on">정보서비스 사이트맵</a></li>
							<li><a href="/portal/nadata/catalog/naDataCatalogPage.do">정보서비스 카탈로그</a></li>
					    </ul>
				    </div>

	       			<div class="area_h3 area_h3_AB deco_h3_3" style="margin-bottom: -15px;">
						<p><span style="color:#d10000;">정보서비스명</span>으로 검색과 바로가기가 가능합니다.</p>
					</div>
						
					<div id="search-sect" class="naData_mobile">
						<div class="list_group naDataonly">
							<ul class="group06">
								<li><strong>관리기관</strong></li>
								<li><button id="btnOrgAll" data-gubun="A" class="on"  aria-selected="true" title="선택됨">전체</button></li>
								<c:forEach var="list" items="${schOrg }" varStatus="status">
								<li><button id="btnOrgCd${status.count}" data-gubun="${list.orgCd }" aria-selected="false">${list.orgNm }</button></li>
								</c:forEach>
							</ul>
							<ul class="group05">
								<li>
									<div class="input_search_btn w298">
										<input type="text" id="schInputVal" name="schInputVal" placeholder="검색어를 입력하세요" value="" title="검색">
									</div>
									<button id="btnSearch" class="group_btn">검색</button>
									<button id="btnReset" class="reset_btn ml4">초기화</button>
								</li>
							</ul>
						</div>
					</div>

					<div id="result_srvm_gubun" class="result_srvm_list_mobile">
						<select id="result_srvm_list_mobile" title="구분선택">
						</select>
					</div>
					
					<div id="result_srvm_list" class="result_list_box">
					</div>
					
					<div id="result_srvm_sitemap" class="sitemap_content">
						<div class="sc_content">
							<div class="sc_content_img">
								<img id="tmnlImgFileNm" src="" alt="">
							</div>
							<div class="sc_content_url">
								<div>
									<h5 id="hSrvmNm"></h5>
								</div>
								<div>
									<strong>URL</strong>
									<span id="srcUrl"></span>
								</div>
								<div>
									<strong>주요 제공 서비스</strong>
									<span id="infoSmryExp"></span>
								</div>
								<div>
									<strong>관리기관</strong>
									<span id="orgNm"></span>
								</div>
							</div>
						</div>
						
						<!-- 탭추가 -->
						<!-- <div>
       						<div class="tab_B mt70" id="tab-btn-sect">
       							<a href="javascript:;" class="on" id="tab_siteMap">사이트맵</a>	
       							<a href="javascript:;" id="tab_menuList">메뉴목록</a>
       						</div>
       					</div> -->
       					<!-- //탭추가 -->

						<!-- 사이트맵 -->
						<div class="sc_sitemap">
							<div>
								<h5 id="srvmNmMenu"></h5>
								<a href="#" id="srcUrlGo" alt="새창열림" target="_blank">바로가기</a>
							</div>
							<img id="tmnl2ImgFileNm" src="" alt="">  
						</div>
						<!-- //사이트맵 -->
						
						<!-- 메뉴목록 -->
						<%-- <div class="sc_menulist" style="display:none;">
							<div class="themeCscrollx hline">
								<table id="sitemapMenu">
								<caption>메뉴목록 : 대메뉴, 중메뉴, 소메뉴, 세메뉴, URL</caption>
								<colgroup>
									<col style="">
								</colgroup>
								<thead>
									<tr>
										<th scope="col">대메뉴</th>
										<th scope="col">중메뉴</th>
										<th scope="col">소메뉴</th>
										<th scope="col">세메뉴</th>
										<th scope="col">URL</th>
									</tr>
								</thead>
								<tbody>
								</tbody>
								</table>
							</div>
						</div> --%>
						<!-- //메뉴목록 -->

					</div>

					<!-- 사이트맵 검색 시 결과 처리 AREA -->
			        <div id="result_search_sitemap" class="contents-area nada_sitemap">
					</div>
					
				</div>
				<!-- //CMS 끝 -->
							
			</div>
		</article>
		<!-- //contents  -->
	
	</div>
	</section>
	<!-- //container -->
	</form>
</div>
<%@ include file="/WEB-INF/jsp/portal/sect/footer.jsp" %>
<script type="text/javascript" src="<c:url value="/js/portal/nadata/naDataSitemap.js" />"></script>
</body>
</html>
