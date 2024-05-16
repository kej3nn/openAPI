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
							<h3><c:out value="${requestScope.menu.lvl2MenuPath}" /><span class="arrow"></span></h3>
						</div>
	       				<div class="area_h3 area_h3_AB deco_h3_3" style="margin-bottom: 15px;">
							<p>국회정보 일괄 다운로드는 <span style="color:#d10000;">10개</span>까지 정보공개 목록을 선택하실 수 있습니다. <span style="color:#d10000;">문서파일(한글, PDF등)</span>은 일괄 다운로드를 제공하지 않습니다.</p>
						</div>
							
						<div class="contents-area">
							<div class="wrap_layout_flex fix_page">
								<div class="layout_easySearch layout_flex_100">
									<!-- 내용 -->
									<div class="content_all list_down_box">
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
											<!-- 트리 -->
											<div class="content_tree_area mt10">
												<div id="treeObj" class="h652"></div>
												<!-- 검색시 Layer -->
												<div class="searchResult" style="display: none;">
													<button class="close" id="btnSearchResultClose" title="닫기"></button>
													<p class="title">검색결과</p>
													<div class="sort_btn">
														<button id="btnSortAsc" title="내림차순">▼</button><button id="btnSortDesc" title="오름차순">△</button>
													</div>
													<ul id="result-search-sect">
													</ul>
												</div>
												<!-- //검색시 Layer -->
											</div>
											<!-- //트리 -->
										</div>
										
										<!-- content 첫화면 --> 
										<div id="main-img-sect" class="first_main"></div>
										<!-- //content 첫화면 -->
										
										<div class="content_text">
										
											<div id="main-text-sect" class="data_select">
												<div class="themeE" id="result-list-wrapper">
													<h4>※ 서비스를 선택해 주세요.</h4>
													<table>
													<caption>서비스 선택 - 선택, 분류,제목</caption>
													<colgroup>
														<col style="">
													</colgroup>
													<thead class="m_none">
														<tr>
															<th scope="row" class="tcheck">
															<lable for="tbResultAllChk"><span class="blind">전체선택</span></lable>	<input type="checkbox" id="tbResultAllChk"></th>
															<th scope="row" class="tcate">분류</th>
															<th scope="row" class="tsubject">제목</th>
														</tr>
													</thead>
													<tbody id="result-list-sect"></tbody>
													</table>
												</div>
											</div>
											<div class="content_tree_total_down">
												<a href="javascript:;" id="btnAddGrid">추가</a>
											</div>
											<div id="choice-text-sect" class="data_result">
												<div class="data_result_btn">
													<ul>
														<li><a href="javascript:;" class="btn_filedown" id="btnSelDelete">선택삭제</a></li>
														<li><a href="javascript:;" class="btn_inquiries" id="btnDownload">다운로드</a></li>
													</ul>
												</div>
												<div class="themeG" id="choice-list-wrapper">
													<table>
													<caption>서비스 선택 결과 - 선택, 번호,제목</caption>
													<colgroup>
														<col style="width:;">
													</colgroup>
													<thead class="m_none">
														<tr>
															<th scope="row" class="tcheck"><lable for="tbChoiceAllChk"><span class="blind">전체선택</span></lable><input type="checkbox" id="tbChoiceAllChk"></th>
															<th scope="row" class="tnumber">번호</th>
															<th scope="row" class="tsubject">제목</th>
														</tr>
													</thead>
													<tbody id="choice-list-sect"></tbody>
													</table>
												</div>
											</div>
											

										
									</div>
									<!-- //내용 -->
								</div>
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
<script type="text/javascript" src="<c:url value="/js/portal/infs/list/infsListDown.js" />"></script>
<!-- jquery tree plugin [Dynatree] -->
<link rel="stylesheet" href="<c:url value="/js/soportal/tree/skin/ui.dynatree.css" />" type="text/css">
<script type="text/javascript" src="<c:url value="/js/soportal/tree/jquery.dynatree.js" />"></script> 
</body>
</html>