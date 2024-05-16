<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="egovframework.common.WiseOpenConfig"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>

<!DOCTYPE html>
<html lang="ko">
<head>
<%@ include file="/WEB-INF/jsp/nbportal/include/head.jsp" %>
<c:import url="messageStat.jsp"/>
<%-- <script type="text/javascript" src="<c:url value="/js/soportal/data/service/jquery.fileDownloadnoMsg.js" />"></script> --%>
<!-- add css & js for slider -->
<link rel="stylesheet" href="<c:url value="/css/soportal/jquery-ui-1.10.0.custom.min.css" />" type="text/css">
<script type="text/javascript" src="<c:url value="/js/soportal/jquery-ui.js" />"></script>
<link rel="stylesheet" href="<c:url value="/css/soportal/slider.css" />" type="text/css">
<script type="text/javascript" src="<c:url value="/js/soportal/slider.js" />"></script>
<!-- 간편통계 팝업  js추가  -->
<script type="text/javascript" src="<c:url value="/js/soportal/stat/easyStatSchPop.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/soportal/stat/easyStatSchPopSearch.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/soportal/stat/easyStatSchPopTree.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/soportal/stat/easyStatSchPopEvent.js" />"></script>
<!-- jquery tree plugin [Dynatree] -->
<link rel="stylesheet" href="<c:url value="/js/soportal/tree/skin/ui.dynatree.css" />" type="text/css">
<script type="text/javascript" src="<c:url value="/js/soportal/tree/jquery.dynatree.js" />"></script> 
<!-- jquery chart plugin [high charts] -->
<script type="text/javascript" src="<c:url value="/js/common/highcharts/highstock.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/common/highcharts/highcharts-more.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/common/highcharts/highcharts-3d.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/common/highcharts/modules/exporting.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/common/highcharts/modules/data.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/common/highcharts/modules/drilldown.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/common/highcharts/modules/treemap.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/common/highcharts/modules/sunburst.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/common/highcharts/modules/map.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/common/highcharts/modules/data.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/lodash.min.js" />"></script>
<!-- jquery slider plugin [ionRangeSlider] -->
<script type="text/javascript" src="<c:url value="/js/common/ionRangeSlider/js/ion.rangeSlider.js" />"></script>
<link href="<c:url value="/js/common/ionRangeSlider/css/ion.rangeSlider.css" />" rel="stylesheet" type="text/css"/>
<link href="<c:url value="/js/common/ionRangeSlider/css/ion.rangeSlider.skinFlat.css" />" rel="stylesheet" type="text/css"/>
<!-- chart 종류에 따른 호출  -->
<script type="text/javascript" src="<c:url value="/js/soportal/statCharts.js" />"></script>
<!-- jquery chart plugin [jquery confirm] -->
<link rel="stylesheet" href="<c:url value="/css/component/jquery-confirm.min.css" />" type="text/css">
<script type="text/javascript" src="<c:url value="/js/common/component/jquery-confirm.min.js" />"></script>

</head>
<body>

<!-- layout_A -->
<div class="layout_A easy_popup">

<!-- container -->
<section>
	<div class="container hide-pc-lnb" id="container">
	<%@ include file="/WEB-INF/jsp/nbportal/include/lnb.jsp" %>

	<!-- contents  -->
	<article>
		<div class="contents" id="contents">

			<div class="contents-area">
			<!-- CMS 시작 -->
			
			<!-- wrap_layout_flex -->
			<div class="wrap_layout_flex fix_page">
			<div class="layout_easySearch layout_flex_100">

			<!-- easySearchArea -->
			<div class="easySearchArea" id="tabs">

				<c:import  url="easyStatSchPopDtl.jsp"/>

			<!-- lSide background shadow -->
			<div class="bg_shadow">&nbsp;</div>
			<!-- //lSide background shadow -->
			
			</div>
			<!-- // easySearchArea -->

			</div>		
			<!-- // layout_flex_100  -->
		
			<div id="loadingCircle" style="position:fixed; top:0px; left:0px; width:100%; height: 100%; z-index:9999999999; display:none;">
				<div style="position:relative; top:50%; left:50%; margin: -77px 0 0 -77px;z-index:10;"><img src="<c:url value="/images/soportal/desktop/ajax-loader.gif"/>" alt="loading"></div>
				<div class="bgshadow"></div>
			</div>
			
			</div>	<!-- // wrap_layout_flex ############################## -->

			<!-- CONFIRM 페이지 -->
			<div class="layerpopup-stat-wrapper" id="confirm-box" style="z-index:10;">
				<input type="hidden" id="confirm-box-focus">
				<div class="bg-opacity-black45"></div>
				<div class="layerpopup-stat-area">
					<div class="title-area">
						<h2>CONFIRM</h2>
					</div>

					<div class="layerpopup-stat-box">
						<p id="confirmMsg"></p>
						<div class="btns-right">
							<a href="#none" class="type01" id="confDown" style="display:none;">다운로드</a>
							<a href="javascript:confirmAction();" class="type01" id="confAction">확인</a>
							<a href="javascript:messageDivClose();" class="type02">취소</a>
						</div>
					</div>

					<button type="button" class="btn-layerpopup-close02" title="창닫기">
						<img src="<c:url value="/images/soportal/btn/btn_close02@2x.gif"/>" alt="닫기"/>
					</button>
				</div>
			</div>
			<!-- // CONFIRM 페이지 -->

			<!-- ALERT 페이지 -->
			<div class="layerpopup-stat-wrapper" id="alert-box" style="z-index:11;">
				<input type="hidden" id="alert-box-focus">
				<div class="bg-opacity-black45"></div>
				<div class="layerpopup-stat-area">
					<div class="title-area">
						<h2>ALERT</h2>
					</div>

					<div class="layerpopup-stat-box">
						<p id="alertMsg"></p>
						<div class="btns-right">
							<a href="javascript:messageDivClose();" class="type02">확인</a>
						</div>
					</div>

					<button type="button" class="btn-layerpopup-close02" title="창닫기">
						<img src="<c:url value="/images/soportal/btn/btn_close02@2x.gif"/>" alt="닫기"/>
					</button>
				</div>
			</div>
			<!-- // ALERT 페이지 -->
			
			<!-- 파일 변환 로딩 페이지 -->
			<div class="layerpopup-loading-wrapper" id="dataDown-box" style="z-index:12;">
				<div class="bg-opacity-black45"></div>
				<div class="layerpopup-loading-area">
					<img src="<c:url value="/images/soportal/icon/icon_loading.gif"/>" alt="Loding" />
					<span>파일 변환중입니다. 잠시만 기다려 주세요</span>
				</div>
			</div>
			<!-- //파일 변환 로딩 페이지 -->

			<!-- layerPop : naboContentPop -->
			<div class="layerPopup" id="statContent-box" style="display: none; z-index:13;">
				<div class="popArea npop" id="npop">
					<a href="javascript:;" class="close" name="statContentClose" title="닫기">X</a>
					<div class="popHeader mb0">
						<p class="tit">통계스크랩</p>
					</div>
					<div class="popConts newContentPup">

						<div class="popBody" id="bbsDetailDiv">
							<div class="ncontent_title">
								<ul>
									<li>
										<strong>통계명</strong>
										<span id="conStatNm">통계명칭</span>
									</li>
								</ul>
							</div>
					
					<!-- 통계콘텐츠 용어 설명 -->
							
							<div class="termList check-list" style="display:none;">
								<dl class="listFolder">
									<dt>	
										<span><a href="javascript:void(0);">회계연도</a></span>
									</dt>
									<dd style="display:none;">
										<p class="txtSt2"></p>
									</dd>
								</dl>
							</div>
					
					<!--  //통계콘텐츠 용어 설명 -->
					
							<div class="board-list09">
								<table style="width: 100%">
									<caption>통계콘텐츠 상세 : 제목, 등록자, 등록일자, 조회수</caption>
									<thead>
										<tr>
											<th scope="col" class="m767none" id="contentsTitle">제목</th>
											<th scope="col" class="orgNm m767none" id="contentsOrgNm" style="display:none;">대상기관</th>
											<th scope="col" class="writer m767none">등록자</th>
											<th scope="col" class="date m767none">등록일자</th>
											<th scope="col" class="hit m767none">조회수</th>
										</tr>
									</thead>
									<tbody>
										<tr>
											<td class="title left">
												<div class="mobile_title" id="bbsTit">2017년 인구현황 해설</div>
												<ul class="mobile_block">
													<li id="userNmM"></li>
													<li id="orgNmM" style="display:none;">대상기관</li>
													<li id="userDttmM"></li>
													<li id="viewCntM"></li>
												</ul>
												<div class="mobile_content" id="bbsContM">내용</div>
												<div class="mobile_content content_free">
													<div class="conDown"></div>
													<div class="conLink"></div>
												</div>
											</td>
											<td class="m767none" id="orgNm" style="display:none;"></td>
											<td class="m767none" id="userNm"></td>
											<td class="m767none" id="userDttm"></td>
											<td class="m767none" id="viewCnt"></td>
										</tr>
										<tr class="trhvnone">
											<td colspan="4" class="align_left m767none mhfix" id="tdContDetail">
												<div style="width:100%;height:100%;overflow:hidden;overflow-y:auto;" id="bbsCont">내용</div>
											</td>
										</tr>
										<tr class="bottomLink">
											<td colspan="4" class="align_left m767none" id="bottomLinkTd">
												<div class="content_free" id="contentFree">
												</div>
											</td>
										</tr>
									</tbody>
								</table>
							</div>
							<div class="ncontent_next">
								<ul>
									<li class="nc_next">
										<strong>다음글</strong>
										<span id="bbsNext"><a href="#" onclick="javascript:conDataCall(statblId, bbsCd, seqNo);">2018년 인구현황 해설</a></span>
									</li>
									<li class="nc_prev">
										<strong>이전글</strong>
										<span id="bbsPrev"><a href="#" onclick="javascript:conDataCall(statblId, bbsCd, seqNo);">2016년 인구현황 해설</a></span>
									</li>
								</ul>
							</div>
						</div>
						
						<!-- 목록 -->
						<div class="popBody" style="display:none;" id="bbsListDiv">
							<div class="pop_inner">
								<div class="board-area">
									<!-- board search -->
									<fieldset>
										<legend class="blind">검색</legend>
										<p class="total">
											총 <strong id="contents-count-sect"></strong> 건
										</p>
										<div class="search-wrapper">
											<div class="search-area fl">
												<label class="blind" for="bbs-searchtype-combo">검색</label>
												<select id="bbs-searchtype-combo" title="검색 선택창">
													<option value="">전체</option>
							                        <option value="bbsTit">제목</option>
							                        <option value="bbsCont">내용</option>
												</select>
												<div class="search-box">
													<label class="blind" for="bbs-searchword-field">검색어</label>
													<input type="search" id="bbs-searchword-field"  title="검색어 입력" placeholder="검색어를 입력하세요" />
													<input type="submit" id="bbs-search-button" value="검색" />
												</div>
											</div>
											</div>
										</fieldset>
									<!-- //board search -->
									<div class="board-list01 tdh">
										<table style="width: 100%" id="contents-data-table">
											<caption>통계콘텐츠 제공 : No, 제목, 등록자, 등록일자, 조회수</caption>
											<thead>
												<tr>
													<th class="number" scope="col">No</th>
													<th class="title" scope="col" id="contentsListTitle">제목</th>
													<th class="orgNm" scope="col" id="contentsListOrgNm" style="display:none;">대상기관</th>
													<th class="writer" scope="col">등록자</th>
													<th class="date" scope="col">등록일자</th>
													<th class="hit" scope="col">조회수</th>
													
												</tr>
											</thead>
											<tbody>
												<tr>
													<td colspan="5" id="tdContList">
														해당 내용이 없습니다.
													</td>
												</tr>
											</tbody>
										</table>
							            <!-- page -->
				            			<div id="contents-pager-sect"></div>
			            				<!-- // page -->
									</div>
									<form id="contents-search-form" name="contents-search-form" method="post">
							           <input type="hidden" name="page" value="<c:out value="${param.page}" default="1" />" />
							           <input type="hidden" name="rows" value="<c:out value="10" default="${data.listCnt}" />" />
							           <input type="hidden" name="bbsCd" value="<c:out value="${param.bbsCd}" default="${data.bbsCd}" />" />
							           <input type="hidden" name="statblId" value="<c:out value="${param.statblId}" default="${data.statblId}" />" />
							           <input type="hidden" name="listSubCd" value="<c:out value="${param.listSubCd}" default="" />" />
							           <input type="hidden" name="searchType" value="<c:out value="${param.searchType}" default="" />" />
							           <input type="hidden" name="searchWord" value="<c:out value="${param.searchWord}" default="" />" />
							           <input type="hidden" name="seq" value="<c:out value="${param.seq}" default="" />" />
							       	</form>
								</div>
							</div>
						</div>
		
						<div class="btnBox" id="bbsBtnDiv">
							<!-- <a href="javascript:;" name="statContentTblDown" class="btnSt2 btn1" title="다운로드">다운로드</a> -->
							<a href="javascript:;" name="statContentTblList" class="btnSt2 btn1" title="목록">목록</a>
							<a href="javascript:;" name="statContentTblClose" class="btnSt2 btn2" title="닫기">닫기</a>
						</div>
					</div>
				</div>
		
			</div>
			<!-- // layerPop : naboContentPop -->	
									
			<!-- //CMS 끝 -->
			</div>
		</div>
	</article>
	<!-- //contents  -->

</div>
</section>
<!-- //container -->

</div>		

<c:import  url="/WEB-INF/jsp/inc/iframepopup.jsp"/>

<form method="post" name="commonForm" id="commonForm" >
<input type="hidden" name="page" title="page" value="<c:out value="${param.page}" default="1" />" />
<input type="hidden" name="rows" title="rows" value="<c:out value="${param.rows}" default="10" />" />
<%-- <input type="hidden" name="statblId" id="statblId" title="statblId" value="${statblId }" /> --%>
<input type="hidden" name="searchVal" title="searchVal" id="searchVal" />
<input type="hidden" name="searchGb"  title="searchGb" id="searchGb" />
<input type="hidden" name="firParam" id="firParam" title="firParam" value="${firParam }" />
<input type="hidden" name="isFirst" id="searchType" title="searchType" value="${searchType }" />
<input type="hidden" name="mainCall" id="mainCall" title="mainCall" value="${mainCall}" />
<input type="hidden" name="statGb" id="statGb" title="statGb" value="${statGb }"/>
<input type="hidden" name="treeCateId" id="treeCateId" title="treeCateId" value="${treeCateId }"/>
<input type="hidden" name="sortGb" id="sortGb" title="sortGb" value="ASC"/>
<input type="hidden" name="seq" title="seq" id="seq" />
<input type="hidden" name="mapVal" title="mapVal" id="mapVal" />
</form>

</body>
</html>