<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>

<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%-- @(#)infsListPage.jsp 1.0 2019/08/12                                   --%>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>

<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%-- 사전정보공개 목록 리스트 화면이다. 				                    --%>
<%--                                                                        --%>
<%-- @author JHKIM                                                         --%>
<%-- @version 1.0 2019/08/12                                                --%>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<!DOCTYPE html>
<html lang="ko">
<head>
<!-- head include -->
<%@ include file="/WEB-INF/jsp/portal/sect/head.jsp" %>
</head>
<body>

<!-- header html -->
<%@ include file="/WEB-INF/jsp/portal/sect/headerOpen.jsp" %>

<!-- gnb -->
<%@ include file="/WEB-INF/jsp/portal/sect/gnb.jsp" %>

<div>
	<form method="post" name="searchForm" id="searchForm" >
		<!-- container -->
		<section>
			<div class="container hide-pc-lnb" id="container">
				<!-- contents  -->
				<article>
					<div class="contents" id="contents">
						<div class="contents-title-wrapper">
							<h3>Open API 목록<span class="arrow"></span></h3>
							<ul class="sns_link">
								<li><a title="새창열림_페이스북" href="#" id="shareFB" class="sns_facebook">페이스북</a></li>
								<li><a title="새창열림_트위터" href="#" id="shareTW" class="sns_twitter">트위터</a></li>
								<li><a title="새창열림_네이버블로그" href="#" id="shareBG" class="sns_blog">네이버블로그</a></li>
								<li><a title="새창열림_카카오스토리" id="shareKS" href="javascript:shareStory();" class="sns_kakaostory">카카오스토리</a></li>
								<li><a title="새창열림_카카오톡" id="shareKT" href="javascript:sendLink();" class="sns_kakaotalk">카카오톡</a></li>
							</ul>
						</div>
						
						<div class="contents-area">
							<div class="wrap_layout_flex fix_page">
								<div class="layout_easySearch layout_flex_100">
									<!-- top level TAB -->
									<div class="toplevel_tab">
										<ul>
											<li><a href="${getContextPath }/portal/openapi/openApiNaListPage.do">열린국회정보</a></li>
											<li><a href="javascript:;" class="on">국회 소속기관 제공 API 목록</a></li>
										</ul>
									</div>
									<!-- //top level TAB -->
									
									<!-- 내용 mobile  -->
									<div class="mobile_content_all line2bl">
										<!-- 상단 검색 -->
										<div class="mca_header">
											<div>
												<span class="mcah01"><strong>API명</strong></span>
												<span class="mcah02"><input type="text" id="schMbInputVal" value="${schParams.schInputVal }" title="API명 입력"" ></span>
												<span class="mcah03"><button type="button" id="btnMbSearch">조회</button></span>
											</div>
											<div>
												<span class="mcah01"><strong>기관 선택</strong></span>
												<span class="mcah02">
													<select id="selMbOrgCd" title=기관선택">
														<option value="A">전체</option>
														<option value="9710000">국회사무처</option>
														<option value="9720000">국회도서관</option>
														<option value="9700209">국회예산정책처</option>
														<option value="9735000">국회입법조사처</option>
														<!-- <option value="NA30000">지원조직별 공개</option> -->
													</select>
												</span>
											</div>
										</div>
										<!-- //상단 검색 -->
									</div>
									<!-- //내용 mobile -->
									<div class="content_txt2">
										행정안전부 공공데이터 포털(data.go.kr)등 타사이트에 등록된 국회 소속기관(국회사무처, 국회도서관, 국회예산정책처, 국회입법조사처)<br><em>Open API 서비스에 대해 링크 정보를 제공</em>합니다. 
									</div>
									<!-- 내용 -->
									<!-- 상단 선택 -->
									<div id="search-sect">
										<input type="hidden" name="page" title="page" value="<c:out value="${schParams.page}"/>" />
										<input type="hidden" name="rows" title="rows" value="<c:out value="${schParams.rows}"/>" />
										<c:forEach var="entry" items="${schHdnParams}">
											<c:forEach var="value" items="${entry.value}">
												<input type="hidden" name="${entry.key }" value="${value }" title="schHdnParams">
											</c:forEach>
										</c:forEach>
										<div class="list_group">
											<ul class="group01">
												<li><strong>기관</strong></li>
												<li><button id="btnOrgAll" data-gubun="A" class="on">전체</button></li>
												<li><button id="btnOrgCd1" data-gubun="9710000">국회사무처</button></li>
												<li><button id="btnOrgCd2" data-gubun="9720000">국회도서관</button></li>
												<li><button id="btnOrgCd3" data-gubun="9700209">국회예산정책처</button></li>
												<li><button id="btnOrgCd4" data-gubun="9735000">국회입법조사처</button></li>
											</ul>
										</div>
										<div class="list_group">
											<ul class="group05 group_api">
												<li><strong>API명</strong> 
												</li>
												<li>
													<div class="input_search_btn">
														<input type="text" id="schInputVal" name="schInputVal" placeholder="검색어를 입력하세요" value="${schParams.schInputVal }" title="검색">
													</div>
													<button id="btnSearch" class="group_btn">검색</button>
												</li>
											</ul>
											<ul class="group05">
												<li><strong>구분</strong></li>
												<li>
													<select id="schApiTagCd" name="schApiTagCd" title="구분선택">
														<option value="">전체</option>
														<c:forEach var="list" items="${apiTagCd }">
															<option value="${list.code }" ${list.code == schParams.apiTagCd ? 'selected=selected' : '' }>${list.name }</option>
														</c:forEach>
													</select>
												</li>
											</ul>
										</div>
									</div>
									<!-- //상단 선택 -->
									
									<!-- 하단 목록 -->
									<div id="result-sect">
										<div class="result_view pb0 platform_guide_sel">
											<div id="result-sect-total" class="result_total_count">
												전체 <strong id="result-count-sect" class="totalNum"></strong>건 <em id="result-pages-sect" class="pageNum"></em>
											</div>
											<span>
												<select id="selRows" title="리스트 갯수형식">
													<c:if test="${schParams.rows == '' }">
														<option value="12" selected="selected">12개씩 보기</option>
														<option value="24">24개씩 보기</option>
														<option value="48">48개씩 보기</option>
													</c:if>
													<c:if test="${schParams.rows != '' }">
														<option value="12" ${schParams.rows == 12 ? 'selected=selected' : '' }>12개씩 보기</option>
														<option value="24" ${schParams.rows == 24 ? 'selected=selected' : '' }>24개씩 보기</option>
														<option value="48" ${schParams.rows == 48 ? 'selected=selected' : '' }>48개씩 보기</option>
													</c:if>
												</select>
												<a href="javascript:;" class="btn_filedown" id="excelDown" title="다운로드">다운로드</a>
											</span>
										</div>
										<div class="themeBscrollx tdfs15 ">
										<table>
											<caption>국회 소속기관 제공 API 목록 : NO, 기관, API명, 구분, 바로가기 URL 제공</caption>
											<colgroup>
											<col style="">
											</colgroup>
											<thead class="m_none">
												<tr>
													<th scope="col">NO</th>
													<th scope="col">기관</th>
													<th scope="col">API명</th>
													<th scope="col">구분</th>
													<th scope="col">URL</th>
												</tr>
											</thead>
											<tbody id="result-sect-list" class="result_list_box">
											</tbody>
										</table>	
										</div>														
										<div id="result-sect-pager"></div>
									</div>
									<!-- //하단 목록 -->
									<!-- //내용 -->
									
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

<script type="text/javascript" src="<c:url value="/js/portal/openapi/openApiSupplyList.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/portal/openapi/openApiSupplyListEvent.js" />"></script>
</body>
</html>