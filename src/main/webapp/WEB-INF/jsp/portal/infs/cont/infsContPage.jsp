<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>

<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%-- @(#)infsContPage.jsp 1.0 2019/08/12                                   --%>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%-- 사전정보공개 컨텐츠 리스트 화면이다. 				                    --%>
<%--                                                                        --%>
<%-- @author JHKIM                                                         --%>
<%-- @version 1.0 2019/08/12                                                --%>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<!DOCTYPE html>
<html lang="ko">
<head>
<!-- head include -->
<%@ include file="/WEB-INF/jsp/portal/sect/head.jsp" %>
<!-- jquery chart plugin [high charts] -->
<script type="text/javascript" src="<c:url value="/js/common/highcharts/highstock.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/common/highcharts/modules/exporting.js" />"></script>
</head>
<body>

<!-- header html -->
<%@ include file="/WEB-INF/jsp/portal/sect/header.jsp" %>

<!-- gnb -->
<%@ include file="/WEB-INF/jsp/portal/sect/gnb.jsp" %>

<div>
	<form id="form" >
		<input type="hidden" id="paramInfsId" value="<c:out value="${paramInfsId }"/>" title="paramInfsId">
		<input type="hidden" id="paramCateId" value="<c:out value="${paramCateId }"/>" title="paramCateId">
		<input type="hidden" id="paramOrderBy" value="" title="paramOrderBy">
		<input type="hidden" id="shareInfsId" value="<c:out value="${infsId }"/>" title="shareInfsId">
		<input type="hidden" id="shareCateId" value="<c:out value="${cateId }"/>" title="shareCateId">
		<input type="hidden" id="mobileParamCateId" value="<c:out value="${paramCateId }"/>" title="mobileParamCateId">
		<input type="hidden" id="kakaoKey" value="<spring:message code="Oauth2.Provider.Kakao.ClientId"/>" title="kaka oKey">
		<input type="hidden" name="page" title="page" value="<c:out value="${param.page}"/>">
		<input type="hidden" name="rows" title="rows" value="<c:out value="${param.rows}"/>">
		<input type="hidden" name="cateDataGubun" value="subj" title="cateDataGubun">
		
		<!-- container -->
		<section>
			<div class="container hide-pc-lnb" id="container">      
				<!-- contents  -->
				<article>
					<div class="contents" id="contents">
						<div class="contents-title-wrapper">
							<h3>정보공개</h3>
							<ul class="sns_link">
								<li><a href="javascript:;" id="shareFB" class="sns_facebook" title="새창열림_페이스북">페이스북</a></li>
								<li><a href="javascript:;" id="shareTW" class="sns_twitter" title="새창열림_트위터">트위터</a></li>
								<li><a href="javascript:;" id="shareBG" class="sns_blog" title="새창열림_네이버블로그">네이버블로그</a></li>
								<li><a href="javascript:;" id="shareKS" class="sns_kakaostory" title="새창열림_카카오스토리">카카오스토리</a></li>
								<li><a href="javascript:;" id="shareKT" class="sns_kakaotalk" title="새창열림_카카오톡">카카오톡</a></li>
							</ul>
						</div>
						
						<div class="contents-area">
							<div class="wrap_layout_flex fix_page">
								<div class="layout_easySearch layout_flex_100">
									<!-- top level TAB -->
									<div class="toplevel_tab">
										<ul>
											<li><a href="javascript:;" class="on" aria-selected="true" title="선택됨">정보공개 콘텐츠</a></li>
											<li><a href="/portal/infs/list/infsListPage.do" aria-selected="false">정보공개 목록</a></li>
										</ul>
									</div>
									<!-- //top level TAB -->
									
									<!-- 내용 -->
									<div class="content_all">
										<div class="content_tree">
											<div class="content_menu">
												<ul>
													<li><a href="#none" class="on" data-gubun="subj" aria-selected="true">테마별</a></li>
													<li><a href="#none" data-gubun="sorg" aria-selected="false">지원조직별</a></li>
												</ul>
											</div>
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
												<a href="#">콘텐츠 목록 다운로드</a>
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
														<li><a href="javascript:;" name=""><strong class="tit">중기 <span class="text-red">재정</span>수입 전망</strong></a></li>
														<li><a href="javascript:;" name=""><strong class="tit">중기 <span class="text-red">재정</span>수지 전망</strong></a></li>
														<li><a href="javascript:;" name=""><strong class="tit">중기 <span class="text-red">재정</span>지출 계획</strong></a></li>
														<li><a href="javascript:;" name=""><strong class="tit">교육 분야 <span class="text-red">재정</span>규모</strong></a></li>
														<li><a href="javascript:;" name=""><strong class="tit">농림·수산·식품 분야 <span class="text-red">재정</span>규모</strong></a></li>
														<li><a href="javascript:;" name=""><strong class="tit">보건·복지·고용 분야 <span class="text-red">재정</span>규모</strong></a></li>
													</ul>
												</div>
												<!-- //검색시 Layer -->
											</div>
											<!-- //트리 -->
										</div>
										<div class="content_text">
											<div id="main-text-sect">
												<h4 class="text_header" id="dtlTxt_infsNm"></h4>
												<div class="content_location">
												</div>
										        <div class="toggle_tab_B">
										        	<a href="javascript:;" class="toggle_metaInfo"><strong>콘텐츠 닫기</strong><img src="/img/ggportal/desktop/common/toggle_open_metaInfo.png" alt="콘텐츠 닫기"></a>
										        </div>
												<!-- <h5 class="text_subheader" id="dtlTxt_infsNm"></h5> -->
												<div class="tab_B m_none" id="exp-tab-sect">
										        </div>
										        <div class="tab_B_m">
										        	<select id="exp-mbTab-sect" title="선택"></select>
										        </div>
												<h5 class="hide" id="exp-cont-sect-header"></h5>
										        <div id="exp-cont-sect" class="economic_content">
												</div>
												<div class="tab_B" id="relDoc-sect-gubun">
										            <span class="on">관련 규정 및 지침</span>
										        </div>	
												<div class="themeB" id="relDoc-sect-wrapper">
													<table>
													<caption>관련 규정 및 지침 : 분류, 제목, 공개유형, 서비스유형, 공개일자</caption>
													<colgroup>
														<col style="">
													</colgroup>
													<thead class="m_none">
														<tr>
															<th scope="row" class="tcate">분류</th>
															<th scope="row" class="tsubject">제목</th>
															<th scope="row" class="ttype">공개유형</th>
															<th scope="row" class="tservice">서비스유형</th>
															<th scope="row" class="tdate">공개일자</th>
														</tr>
													</thead>
													<tbody id="relDoc-sect"></tbody>
													</table>
												</div>
												
												<div class="tab_B" id="relOpenNStts-sect-gubun">
										            <span class="on">관련 데이터</span>
										        </div>	
												<div class="themeB" id="relOpenNStts-sect-wrapper">
													<table>
													<caption>관련 데이터 : 분류,제목,공개유형,서비스유형,공개일자</caption>
													<colgroup>
														<col style="">
													</colgroup>
													<thead class="m_none">
														<tr>
															<th scope="row" class="tcate">분류</th>
															<th scope="row" class="tsubject">제목</th>
															<th scope="row" class="ttype">공개유형</th>
															<th scope="row" class="tservice">서비스유형</th>
															<th scope="row" class="tdate">최초공개일</th>
														</tr>
													</thead>
													<tbody id="relOpenNStts-sect"></tbody>
													</table>
												</div>
												<!-- 
												<div id="result-sect-list"></div>
												<div id="result-sect-pager"></div>
												 -->
											</div>
											
										<!-- content 첫화면 --> 
										<div id="main-img-sect" class="first_main"></div>
										<!-- //content 첫화면 -->
										
										<div class="content_text_btn">
											<a href="javascript:;" class="btn_A" id="btnMobileList">목록</a>
										</div>
									</div>
									<!-- //내용 -->
									
								</div>
									
								<!-- 내용 mobile  -->
								<div class="mobile_content_all">
									<!-- 상단 검색 -->
									<div class="mca_header">
										<div>
											<span class="mcah01"><strong>검색</strong></span>
											<span class="mcah02"><input type="text" id="txtMbSearchVal" name="txtMbSearchVal" title="검색어 입력"></span>
											<span class="mcah03"><button type="button" id="btnMbSearch">조회</button></span>
										</div>
										<div>
											<span class="mcah01"><strong>분류 선택</strong></span>
											<span class="mcah02"><input type="text" id="txtMbCate" readonly="readonly" title="분류선택"></span>
											<span class="mcah03"><button type="button" id="btnMbCate">선택</button></span>
										</div>
									</div>
									<!-- //상단 검색 -->
									
									<!-- 하단 리스트 -->
									<div class="mca_content" id="result-list-sect"></div>
									<!-- //하단 리스트 -->
									
									<!-- paging -->
									<div id="result-pages-sect"></div>
									<!-- //paging -->
									
									<!-- 분류선택창 -->
									<div class="bunya_modal" id="modelMbCate" style="display:none;">
										<div class="bunyu">
											<h5>분류선택</h5>
											<div class="bunyu_content">
												<div>
													<span><strong>대분류</strong></span>
													<span><select id="selMbCate1" name="selMbCate1" title="대분류 선택"><option value="">선택</option></select></span>
												</div>
												<div>
													<span><strong>중분류</strong></span>
													<span><select id="selMbCate2" name="selMbCate2" title="중분류 선택"><option value="">선택</option></select></span>
												</div>
												<!-- <div>
													<span><strong>소분류</strong></span>
													<span><select id="selMbCate3" name="selMbCate3" title="소분류 선택"><option value="">선택</option></select></span>
												</div>
												<div>
													<span><strong>세분류</strong></span>
													<span><select id="selMbCate4" name="selMbCate4" title="세분류 선택"><option value="">선택</option></select></span>
												</div> -->
											</div>
											<a href="javascript:;" class="sheet-close" id="btnMbCateClose">닫기</a>
											<div class="bunyu_btn">
												<a href="javascript:;" class="btn_A" id="btnMbCateSearch">확인</a>												
											</div>
										</div>
										<div class="bgshadow_modal">&nbsp;</div>
									</div>
									<!-- //분류선택창 -->
									
								</div>
								<!-- //내용 mobile -->
							</div>
						</div>
					</div>
					</div>
				</article>
				<!-- //contents  -->
			</div>
		</section>
	</form>
</div>


<!-- footer -->
<%@ include file="/WEB-INF/jsp/portal/sect/footer.jsp" %>
<script type="text/javascript" src="<c:url value="/js/portal/infs/cont/infsCont.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/portal/infs/cont/infsContEvent.js" />"></script>
<!-- jquery tree plugin [Dynatree] -->
<link rel="stylesheet" href="<c:url value="/js/soportal/tree/skin/ui.dynatree.css" />" type="text/css">
<script type="text/javascript" src="<c:url value="/js/soportal/tree/jquery.dynatree.js" />"></script> 
</body>
</html>