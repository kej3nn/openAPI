<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>

<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%-- @(#)infsListPage.jsp 1.0 2019/08/12                                   --%>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>

<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%-- 활용 갤러리 목록 리스트 화면이다. 				                    --%>
<%--                                                                        --%>
<%-- @author JHKIM                                                         --%>
<%-- @version 1.0 2019/08/12                                                --%>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<!DOCTYPE html>
<html lang="ko">
<head>
<!-- head include -->
<%@ include file="/WEB-INF/jsp/portal/sect/head.jsp" %>
<!-- jquery tree plugin [Dynatree] -->
<link rel="stylesheet" href="/js/soportal/tree/skin/ui.dynatree.css" type="text/css">
<script type="text/javascript" src="/js/soportal/tree/jquery.dynatree.js"></script> 
<script type="text/javascript" src="<c:url value="/js/ggportal/kakao.min.js" />"></script>
</head>
<body>
<!-- layout_A -->
<div class="layout_A">

<!-- header html -->
<%@ include file="/WEB-INF/jsp/portal/sect/headerOpen.jsp" %>
<div class="container" id="container">
<!-- leftmenu -->
<%@ include file="/WEB-INF/jsp/portal/sect/lnb.jsp" %>
<!-- //leftmenu -->
	<form id="gallery-search-form">
		<!-- container -->
		<section>
			<!-- contents  -->
			<article>
				<div class="contents" id="contents">
					<div class="contents-title-wrapper">
						<h3><c:out value="${requestScope.menu.lvl3MenuPath}" /><span class="arrow"></span></h3>
						<ul class="sns_link">
							<li><a href="#" id="shareFB" class="sns_facebook" title="새창열림_페이스북">페이스북</a></li>
							<li><a href="#" id="shareTW" class="sns_twitter" title="새창열림_트위터">트위터</a></li>
							<li><a href="#" id="shareBG" class="sns_blog" title="새창열림_네이버블로그">네이버블로그</a></li>
							<li><a id="shareKS" href="javascript:shareStory();" title="새창열림_카카스토리" class="sns_kakaostory">카카오스토리</a></li>
							<li><a id="shareKT" href="javascript:sendLink();" title="새창열림_카카오톡" class="sns_kakaotalk">카카오톡</a></li>
						</ul>
					</div>
					
					<div class="contents-area">
						<div class="wrap_layout_flex fix_page">
							<div class="layout_easySearch layout_flex_100">
								<!-- 내용 mobile  -->
								<div class="mobile_content_all">
									<!-- 상단 검색 -->
									<div class="mca_header">
										<div>
											<span class="mcah01"><strong>검색</strong></span>
											<span class="mcah02"><input type="text" id="schMbInputVal" value="${schParams.schInputVal }" title="검색어 입력"></span>
											<span class="mcah03"><button type="button" id="btnMbSearch">조회</button></span>
										</div>
										<div>
											<span class="mcah01"><strong>활용 구분</strong></span>
											<ul class="bn_list">
												<li><a href="javascript:;" id="btnMbUsedAll" data-gubun="A" class="on">전체</a></li>
												<li><a href="javascript:;" id="btnMbUsedId1" data-gubun="APP">앱</a></li>
												<li><a href="javascript:;" id="btnMbUsedId2" data-gubun="WEB">웹사이트</a></li>
												<li><a href="javascript:;" id="btnMbUsedId3" data-gubun="INFO">인포그래픽</a></li>
											</ul>
										</div>
										<div>
											<span class="mcah01"><strong>분류 선택</strong></span>
											<span class="mcah02">
												<select id="selMbCateId" title="분류 선택">
													<option value="A">전체</option>
													<option value="NA10000">국회의원</option>
													<option value="NA40000">의정활동별 공개</option>
													<option value="NA20000">주제별 공개</option>
													<option value="NA50000">보고서ㆍ발간물</option>
													<!-- <option value="NA30000">지원조직별 공개</option> -->
												</select>
											</span>
										</div>
									</div>
									<!-- //상단 검색 -->
									
									<!-- 모바일 활용갤러리 등록 -->
									<div class="mobile_gallery_regist">
										<a href="#" class="gallery-insert-button">활용갤러리 등록</a>
									</div>
									<!-- //모바일 활용갤러리 등록 -->
								</div>
								<!-- //내용 mobile -->
								
								<!-- 내용 -->
								<!-- 상단 선택 -->
								<div id="search-sect">
									<input type="hidden" name="page" title="page" value="<c:out value="${schParams.page}"/>">
									<input type="hidden" name="rows" title="rows" value="<c:out value="${schParams.rows}"/>">
						            <input type="hidden" name="bbsCd" value="<c:out value="${schParam.bbsCd}" default="${data.bbsCd}" />" />
						            <input type="hidden" name="listSubCd" value="<c:out value="${schParam.listSubCd}" default="" />" />
						            <input type="hidden" name="list1SubCd" value="<c:out value="${schParam.list1SubCd}" default="" />" />
						            <input type="hidden" name="seq" value="<c:out value="${schParam.seq}" default="" />" />
						            <input type="hidden" name="noticeYn" value="<c:out value="${schParam.noticeYn}" default="" />" />
									<c:forEach var="entry" items="${schHdnParams}">
										<c:forEach var="value" items="${entry.value}">
											<input type="hidden" name="${entry.key }" value="${value }" title="검색어">
										</c:forEach>
									</c:forEach>
									<input type="hidden" name="cateId" title="cateId" value="<c:out value="${schParam.cateId}" default="" />">
									<input type="hidden" name="cateNm" title="cateNm" value="<c:out value="${schParam.cateNm}" default="" />">
									<div class="list_group">
										<ul class="group01">
											<li><strong>활용구분</strong></li>
											<li><button id="btnUsedAll" data-gubun="A" class="on" aria-selected="true">전체</button></li>
											<li><button id="btnUsedId1" data-gubun="APP" aria-selected="false">앱</button></li>
											<li><button id="btnUsedId2" data-gubun="WEB" aria-selected="false">웹사이트</button></li>
											<li><button id="btnUsedId3" data-gubun="INFO" aria-selected="false">인포그래픽</button></li>
										</ul>
									</div>
									<div class="list_group">
										<ul class="group03">
											<li><strong>분류체계</strong></li>
											<li><button id="btnCateAll" data-gubun="A" class="on" aria-selected="true">전체</button></li>
											<li><button id="btnCateId1" data-gubun="NA10000" aria-selected="false">국회의원</button></li>
											<li><button id="btnCateId4" data-gubun="NA40000" aria-selected="false">의정활동별 공개</button></li>
											<li><button id="btnCateId2" data-gubun="NA20000" aria-selected="false">주제별 공개</button></li>
											<li><button id="btnCateId5" data-gubun="NA50000" aria-selected="false">보고서ㆍ발간물</button></li>
											<li><button id="btnCateId6" data-gubun="NA99999" aria-selected="false">기타</button></li>
											<!-- <li><button id="btnCateId3" data-gubun="NA30000" aria-selected="false">지원조직별 공개</button></li> -->
										</ul>
									</div>
									<div class="list_group">
										<ul class="group05 group_gallery">
											<li><strong>검색어</strong></li>
											<li><select id="schInputGubun" name="schInputGubun" title="검색항목선택">
													<option value="">전체</option>
													<option value="bbsTit">제목</option>
													<option value="userNm">작성자</option>
													<option value="bbsTit+userNm">제목+작성자</option>
												</select>
											</li>
											<li>
												<div class="input_search_btn">
													<input type="text" id="schInputVal" name="schInputVal" placeholder="검색어를 입력하세요" value="${schParams.schInputVal }" title="검색">
												</div>
												<button id="btnSearch" class="group_btn">검색</button>
												<a href="#" class="btn_gallery_regist gallery-insert-button">활용사례 등록</a>
											</li>
											
										</ul>
									</div>
								</div>
								<!-- //상단 선택 -->
								
								<!-- 하단 목록 -->
								<div id="result-sect" class="platform_gallery">
									<div id="result-sect-total" class="result_total">
										<div>전체 <strong id="result-count-sect" class="totalNum"></strong>건 <span id="result-pages-sect" class="pageNum"></span></div>
									</div>
									<div class="result_view result_gallery_m">
										<ul>
											<c:if test="${schParams.schVOrder != null && schParams.schVOrder ne '' }">
											<input type="hidden" name="schVOrder" value="${schParams.schVOrder }" title="순서">
											</c:if>
											<li><button id="btnVOrderDate" 	data-gubun="D" class="${schParams.schVOrder == 'D' ? 'on' : '' }" title="선택됨">등록일자순</button></li>
											<li><button id="btnVOrderNm" 	data-gubun="N" class="${schParams.schVOrder == 'N' ? 'on' : '' }">명칭순</button></li>
											<li><button id="btnVOrderVcnt" 	data-gubun="V" class="${schParams.schVOrder == 'V' ? 'on' : '' }">높은조회순</button></li>
											<li><button id="btnVOrderGcnt" 	data-gubun="G" class="${schParams.schVOrder == 'G' ? 'on' : '' }">평가순</button></li>
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
									<!-- <div id="result-sect-list" class="result_list_box result_gallery"></div> -->
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
		</section>
	</form>
</div>



<!-- footer -->
<%@ include file="/WEB-INF/jsp/portal/sect/footer.jsp" %>

<script type="text/javascript" src="<c:url value="/js/ggportal/bbs/gallery/searchGallery.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/ggportal/bbs/gallery/searchGalleryEvent.js" />"></script>
</div>
</body>
</html>