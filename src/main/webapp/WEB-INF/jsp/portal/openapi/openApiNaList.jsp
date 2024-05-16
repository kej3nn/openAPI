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
	<form id="searchForm">
		<!-- container -->
		<input type="hidden" id="kakaoKey" title="카카오톡키" value="<spring:message code='Oauth2.Provider.Kakao.ClientId'/>">
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
											<li><a href="javascript:;"class="on">열린국회정보</a></li>
											<li><a href="${getContextPath }/portal/openapi/openApiSupplyListPage.do">국회 소속기관 제공 API 목록</a></li>
										</ul>
									</div>
									<!-- //top level TAB -->
									
									<!-- 내용 mobile  -->
									<div class="mobile_content_all">
										<!-- 상단 검색 -->
										<div class="mca_header">
											<div>
												<span class="mcah01"><strong>검색</strong></span>
												<span class="mcah02"><input type="text" id="schMbInputVal" value="${schParams.schInputVal }" title="검색어 입력" ></span>
												<span class="mcah03"><button type="button" id="btnMbSearch">조회</button></span>
											</div>
											<div>
												<span class="mcah01"><strong>분류 선택</strong></span>
												<span class="mcah02">
													<select id="selMbCateId" title="분류선택">
														<option value="A">전체</option>
														<option value="NA10000">국회의원</option>
														<option value="NA40000">의정활동별 공개</option>
														<option value="NA20000">주제별 공개</option>
														<option value="NA50000">보고서ㆍ발간물</option>
														<!-- <option value="NA30000">지원조직별 공개</option> -->
													</select>
												</span>
											</div>
											<!-- 
											<div>			
												<span class="mcah01"><strong>서비스유형</strong></span>									
												<ul class="sv_list">
													<li><a href="javascript:;" class="on" id="btnMbSrvAll" data-gubun="ALL">전체</a></li>
													<li><a href="javascript:;" id="btnMbSrvIdS" data-gubun="S">표</a></li>
													<li><a href="javascript:;" id="btnMbSrvIdC" data-gubun="C">차트</a></li>
													<li><a href="javascript:;" id="btnMbSrvIdV" data-gubun="V">시각화</a></li>
													<li><a href="javascript:;" id="btnMbSrvIdM" data-gubun="M">지도</a></li>
													<li><a href="javascript:;" id="btnMbSrvIdO" data-gubun="A">API</a></li>
													<li><a href="javascript:;" id="btnMbSrvIdF" data-gubun="F">파일</a></li>
													<li><a href="javascript:;" id="btnMbSrvIdL" data-gubun="L">링크</a></li>
												</ul>
											</div>-->
											<!-- 
											<div>
												<span class="mcah01"><strong>공개유형</strong></span>
												<ul class="bn_list">
													<li><a href="javascript:;" id="btnMbTagAll" data-gubun="A" class="on">전체</a></li>
													<li><a href="javascript:;" id="btnMbTagIdD" data-gubun="D">규정지침</a></li>
													<li><a href="javascript:;" id="btnMbTagIdO" data-gubun="O">통계</a></li>
													<li><a href="javascript:;" id="btnMbTagIdS" data-gubun="S">데이터</a></li>
												</ul>
											</div> --> 
										</div>
										<!-- //상단 검색 -->
									</div>
									<!-- //내용 mobile -->
									
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
												<li><strong>분류체계</strong></li>
												<li><button id="btnCateAll" data-gubun="A" class="on">전체</button></li>
												<li><button id="btnCateId1" data-gubun="NA10000">국회의원</button></li>
												<li><button id="btnCateId4" data-gubun="NA40000">의정활동별 공개</button></li>
												<li><button id="btnCateId2" data-gubun="NA20000">주제별 공개</button></li>
												<li><button id="btnCateId5" data-gubun="NA50000">보고서ㆍ발간물</button></li>
												<!-- <li><button id="btnCateId3" data-gubun="NA30000">지원조직별 공개</button></li> -->
											</ul>
											<ul class="group02">
												<li><strong>기관</strong></li>
												<li>
													<select id="schOrgCd" name="schOrgCd" title="기관선택">
														<option value="">전체</option>
														<c:forEach var="list" items="${schOrg }">
															<option value="${list.orgCd }" ${list.orgCd == schParams.schOrgCd ? 'selected=selected' : '' }>${list.orgNm }</option>
														</c:forEach>
													</select>
												</li>
											</ul>
										</div>
										<!-- 
										<div class="list_group">
											<ul class="group03">
												<li><strong>서비스유형</strong></li>
												<li><button id="btnSrvAll" data-gubun="ALL" class="on">전체</button></li>
												<li><button id="btnSrvIdS" data-gubun="S">표</button></li>
												<li><button id="btnSrvIdC" data-gubun="C">차트</button></li>
												<li><button id="btnSrvIdV" data-gubun="V">시각화</button></li>
												<li><button id="btnSrvIdM" data-gubun="M">지도</button></li>
												<li><button id="btnSrvIdO" data-gubun="A">API</button></li>
												<li><button id="btnSrvIdF" data-gubun="F">파일</button></li>
												<li><button id="btnSrvIdL" data-gubun="L">링크</button></li>
											</ul>
										</div> -->
										<div class="list_group">
											<!-- 
											<ul class="group04">
												<li><strong>공개유형</strong></li>
												<li><button id="btnTagAll" data-gubun="A" class="on">전체</button></li>
												<li><button id="btnTagIdD" data-gubun="D">규정(지침)</button></li>
												<li><button id="btnTagIdO" data-gubun="O">데이터</button></li>
												<li><button id="btnTagIdS" data-gubun="S">통계</button></li>
											</ul> -->
											<ul class="group05 ml0">
												<li><select id="schInputGubun" name="schInputGubun" title="검색 분류 선택">
														<option value="">전체</option>
														<option value="schTagInfaNm">제목</option>
														<option value="schSchwTagCont">태그</option>
														<option value="schInfaExp">설명</option>
													</select>
												</li>
												<li>
													<div class="input_search_btn">
														<input type="text" id="schInputVal" name="schInputVal" placeholder="검색어를 입력하세요" value="${schParams.schInputVal }" title="검색">
													</div>
													<button id="btnSearch" class="group_btn">검색</button>
												</li>
											</ul>
										</div>
									</div>
									<!-- //상단 선택 -->
									
									<!-- 하단 목록 -->
									<div id="result-sect">
										<div id="result-sect-total" class="result_total">
											<div>전체 <strong id="result-count-sect" class="totalNum"></strong>건 <span id="result-pages-sect" class="pageNum"></span></div>
										</div>
										<div class="result_view">
											<ul>
												<c:if test="${schParams.schVOrder != null && schParams.schVOrder ne '' }">
												<input type="hidden" name="schVOrder" value="${schParams.schVOrder }" title="schVOrder">
												</c:if>
												<li><button id="btnVOrderDate" 	data-gubun="D" class="${schParams.schVOrder == 'D' ? 'on' : '' }">공개일자순</button></li>
												<li><button id="btnVOrderNm" 	data-gubun="N" class="${schParams.schVOrder == 'N' ? 'on' : '' }">명칭순</button></li>
												<li><button id="btnVOrderVcnt" 	data-gubun="V" class="${schParams.schVOrder == 'V' ? 'on' : '' }">높은조회순</button></li>
											</ul>
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
											</span>
										</div>
										<div id="result-sect-list" class="result_list_box"></div>															
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

<script type="text/javascript" src="<c:url value="/js/portal/openapi/openApiNaList.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/portal/openapi/openApiNaListEvent.js" />"></script>
</body>
</html>