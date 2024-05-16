<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%-- @(#)naDataCatalog.jsp 1.0 2019/09/11                                   --%>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%-- 정보서비스 카탈로그를 조회하는 화면이다.                                --%>
<%--                                                                        --%>
<%-- @author JHKIM                                                         --%>
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
	
	<!-- container -->
	<section>
		<div class="container hide-pc-lnb" id="container">
			<nav>
				<div class="lnb">
					<h2>국회 정보나침반</h2> 
					<ul>
						<li>
							<span><a href="/portal/nadata/sitemap/naDataSitemapPage.do">정보서비스 사이트맵</a></span>
						</li>
						<li>
							<span><a href="/portal/nadata/catalog/naDataCatalogPage.do" class="on">정보서비스 카탈로그</a></span>
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
			        <div class="contents-area">
			        <div class="layout_flex_100">
						<div class="toplevel_tab">
					        <ul>
							    <li><a href="/portal/nadata/sitemap/naDataSitemapPage.do">정보서비스 사이트맵</a></li>
								<li><a href="/portal/nadata/catalog/naDataCatalogPage.do" class="on">정보서비스 카탈로그</a></li>
						    </ul>
					    </div>	
					    <div id="tab-sect">
					        <div class="tab_J">
							    <a href="javascript:;" class="on">디렉토리</a>
								<a href="javascript:;">목록</a>
						    </div>
					    </div>    
					<!-- //CMS 끝 -->
					
				<form id="form">
					<input type="hidden" id="paramInfoId" name="paramInfoId" value="${paramInfoId }" title="paramInfoId">
					<input type="hidden" id="parCateId" name="parCateId" value="${paramCateId }" title="parCateId">
					<input type="hidden" id="paramOrderBy" value="" title="paramOrderBy">
					<input type="hidden" name="page" title="page" value="<c:out value="${param.page}"/>">
					<input type="hidden" name="rows" title="rows" value="10">
					<input type="hidden" id="cateTag" name="cateTag" value="${cateTag}" title="cateTag">	
					<!-- 내용 -->
					<div class="content_all">
						<div class="catePos">
							<ul id="naDataTopCate">
							<c:forEach items="${list}" var="list" varStatus="status">
								<li>									
									<a href="javascript:;" id="${list.cateId}">
										<div>
											<span>
												<img src="/portal/nadata/catalog/selectThumbnail.do?gb=cate&cateId=${list.cateId}" alt="${list.cateNm}">
											</span>
										</div>
										<strong>${list.cateNm}</strong>
									</a>
								</li>
							</c:forEach>
							</ul>
						</div>
						
						
						<!-- mobile 카탈로그 -->
						<div class="catePos_m" id="catePosMobile-sect">
							<select id="catePosMobile" title="구분 선택">
							<c:forEach items="${list}" var="list"  varStatus="status">
								<option value="${list.cateId }">${list.cateNm }</option>
							</c:forEach>
							</select>
						</div>
						
						<!-- //mobile 카탈로그 -->
						
						<div class="mobile_content_all">
							
							<!-- 하단 리스트 -->
							<div class="mca_content" id="mobile-list-sect"></div>
							<!-- //하단 리스트 -->
							
							<!-- paging -->
							<div id="mobile-list-pager-sect"></div>
							<!-- //paging -->
							
						</div>
								
						<div class="content_tree">
							<div class="content_tree_head">
								<div class="content_tree_search">
									<input type="text" id="txtSearchVal" name="txtSearchVal" title="검색어 입력">
									<button type="button" id="btnSearch">검색</button>
								</div>
								<div class="content_tree_control">
									<ul>
										<li><a href="javascript:;" class="btn_open">열기</a></li>
										<li><a href="javascript:;" class="btn_close">닫기</a></li>
									</ul>
								</div>
							</div>
							<div class="content_tree_down">
								<a href="#">목록 다운로드</a>
							</div>
							<!-- 트리 -->
							<div class="content_tree_area">
								<div id="treeObj"></div>
								<!-- 검색시 Layer -->
								<div class="searchResult" style="display: none;">
									<button class="close" id="btnSearchResultClose" title="닫기"></button>
									<p class="title">검색결과</p>
									<div class="sort_btn">
										<button id="btnSortAsc" title="내림차순">▼</button><button id="btnSortDesc" title="오름차순">△</button>
									</div>
									<ul id="result-search-sect">
										<li><a href="javascript:;" name=""><strong class="tit"><span class="text-red">재정</span>수지</strong></a></li>
									</ul>
								</div>
								<!-- //검색시 Layer -->
							</div>
							<!-- //트리 -->
						</div>
						<div class="content_text">
							<h4 class="text_header" id="dtlTxt_infoNm"></h4>
							<div class="content_location">
							</div>
							<div class="" id="relDoc-sect-wrapper">
								<table class="table_datail_CC w_1">
								<caption>정보명, 주요속성, 주제영역, 세부영역, 관리기관, 서비스 유형, 출처시스템, 바로가기 URL</caption>
								<colgroup>
									<col style="">
								</colgroup>
								<thead class="m_none">
								</thead>
								<tbody>
									<tr>
										<th scope="row">정보명</th>
										<td colspan="3" class="ty_AB" id="dtlVal_infoNm"></td>
									</tr>
									<tr>
										<th scope="row">주요속성</th>
										<td colspan="3" class="ty_AB" id="dtlVal_infoSmryExp"></td>
									</tr>
									<tr>
										<th>주제영역</th>
										<td id="dtlVal_cateFullnm"></td>
										<th>세부영역</th>
										<td id="dtlVal_cateNm"></td>
									</tr>
									<tr>
										<th scope="row">관리기관</th>
										<td id="dtlVal_orgNm"></td>
										<th scope="row">서비스 유형</th>
										<td id="dtlVal_srvInfoNm"></td>
									</tr>
									<tr>
										<th scope="row">출처시스템</th>
										<td colspan="3" class="ty_AB" id="dtlVal_menuFullnm"></td>
									</tr>
									<tr>
										<th scope="row">바로가기 URL</th>
										<td colspan="3" class="ty_AB" id="dtlVal_srcUrl"></td>
									</tr>
								</tbody>
								</table>
								<div id="tmnlImgFile"></div>
							</div>
							
							 <!-- content 첫화면 --> 
							 <div class="first_main"></div>
							 <!-- //content 첫화면 -->
							 
							 <div class="content_text_btn">
								<a href="javascript:;" class="btn_A" id="btnMobileList">목록</a>
							</div>
							 
					</div>
					<!-- //내용 -->
					</div>
				</form>
				
				<form id="listForm" method="post">
					<input type="hidden" name="page" title="page" value="<c:out value="${param.page}"/>" />
					<input type="hidden" name="rows" title="rows" value="${param.rows}" />
					<div class="content_all" style="display: none;">
						<section class="theme_select_box mt0">						
						<table>
				            <caption>주제영역, 관리기관, 서비스유형, 출처시스템, 정보명</caption>
				            <tbody>
					            <tr>
					                <th scope="row"><label for="topCateId">주제영역</label></th>
					                <td class="mh42x">
					                	<select name="topCateId" id="topCateId" title="주제영역 선택">
					                	<option value="">선택</option>
					                	<c:forEach items="${list }" var="code">
					                		<option value="${code.cateId }">${code.cateNm }</option>
					                	</c:forEach>
					                	</select>
					                </td>
					                <th scope="row"><label for="orgCd">관리기관</label></th>
					                <td class="mh64x">
					                	<select name="orgCd" id="orgCd" title="관리가관 선택">
					                	<option value="">선택</option>
					                	<c:forEach items="${orgList }" var="code">
					                		<option value="${code.orgCd }">${code.orgNm }</option>
					                	</c:forEach>
					                	</select>
					                </td>
					            </tr>
					             <tr>
					                <th scope="row"><label for="srvInfoCd">서비스유형</label></th>
					                <td class="mh42x">
					                	<select name="srvInfoCd" id="srvInfoCd" title="서비스유형 선택">
					                	<option value="">선택</option>
					                	<c:forEach items="${srvInfoList }" var="code">
					                		<option value="${code.code }">${code.name }</option>
					                	</c:forEach>
					                	</select>
					                </td>
					                <th scope="row"><label for="srcSysCd">출처시스템</label></th>
					                <td class="mh64x">
					                	<select name="srcSysCd" id="srcSysCd" title="출처시스템 선택">
					                	<option value="">선택</option>
					                	<c:forEach items="${srcSysList }" var="code">
					                		<option value="${code.code }">${code.name }</option>
					                	</c:forEach>
					                	</select>
					                </td>
					            </tr>
					             <tr>
					                <th scope="row"><label for="infoNm">정보명</label></th>
					                <td colspan="3">
					                	<input type="text" name="infoNm" id="infoNm" class="mw70p" title="정보명 입력">
					                </td>
					            </tr>
							</tbody>
						</table>
						</section>
						
						<div class="area_btn_A">
							<a id="btnListSch" href="javascript:;" class="btn_A">조회</a>
							<a id="btnListDown" href="javascript:;" class="btn_A">다운로드</a> 
	        			</div>
	        			
	        			<section>
	        			<h4 class="ty_A mgTm10_mq_mobile"></h4>
	        			<div>전체 <strong id="list-count-sect" class="totalNum"></strong>건 <span id="list-pages-sect" class="pageNum"></span></div>
	        			<div class="themeBscrollx scrollxFixd hline">
		        			<table>
		        			<input id='clip_tmp' type='text' style='position:absolute;top:-2000px;' />
		        			<caption>번호, 정보명, 주제영역, 관리기관, 서비스유형, 출처시스템, 바로가기 URL복사, 주요속성</caption>
		        			<colgroup>
		        			<col style="width:70px;">
		        			<col style="width:300px;">
		        			<col style="width:240px;">
		        			<col style="width:120px;">
		        			<col style="width:90px;">
		        			<col style="width:220px;">
		        			<col style="width:100px;">
		        			<col style="width:;">
		        			</colgroup>
	        				<thead>
	        					<tr>
	        						<th scope="row">번호</th>
									<th scope="row">정보명</th>
									<th scope="row">주제영역</th>
									<th scope="row">관리기관</th>
									<th scope="row">서비스유형</th>
									<th scope="row">출처시스템</th>
									<th scope="row">바로가기 URL복사</th>        					
									<th scope="row">주요속성</th>
	        					</tr>
	        				</thead>
	        				<tbody id="list-sect">
	        				</tbody>
		        			</table>
	        			</div>
	        			<div id="list-pager-sect"></div>
	        			</section>
					</div>
				</form>
				
				</div>
				</div>
			</article>
			<!-- //contents  -->
	
		</div>
	</section>
	
	<!-- //container -->
</div>
<%@ include file="/WEB-INF/jsp/portal/sect/footer.jsp" %>
<script type="text/javascript" src="<c:url value="/js/portal/nadata/naDataCatalog.js" />"></script>
<!-- jquery tree plugin [Dynatree] -->
<link rel="stylesheet" href="<c:url value="/js/soportal/tree/skin/ui.dynatree.css" />" type="text/css">
<script type="text/javascript" src="<c:url value="/js/soportal/tree/jquery.dynatree.js" />"></script> 
</body>
</html>
