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
<script type="text/javascript" src="<c:url value="/js/soportal/data/service/jquery.fileDownloadnoMsg.js" />"></script>	
<!-- add css & js for slider -->
<link rel="stylesheet" href="<c:url value="/css/soportal/jquery-ui-1.10.0.custom.min.css" />" type="text/css">
<script type="text/javascript" src="<c:url value="/js/soportal/jquery-ui.js" />"></script>
<link rel="stylesheet" href="<c:url value="/css/soportal/slider.css" />" type="text/css">
<script type="text/javascript" src="<c:url value="/js/soportal/slider.js" />"></script>
<!-- 간편통계용  js추가  -->
<script type="text/javascript" src="<c:url value="/js/soportal/stat/directStatSch.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/soportal/stat/directStatSchSearch.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/soportal/stat/directStatSchTree.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/soportal/stat/directStatSchContents.js" />"></script>
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
<!-- chart 종류에 따른 호출  -->
<script type="text/javascript" src="<c:url value="/js/soportal/statCharts.js" />"></script>
<!-- jquery chart plugin [jquery confirm] -->
<link rel="stylesheet" href="<c:url value="/css/component/jquery-confirm.min.css" />" type="text/css">
<script type="text/javascript" src="<c:url value="/js/common/component/jquery-confirm.min.js" />"></script>

</head>
<body>

<!-- layout_A -->
<div class="layout_A">
<%@ include file="/WEB-INF/jsp/nbportal/include/header.jsp" %>
<%@ include file="/WEB-INF/jsp/nbportal/include/navigation.jsp" %>

<!-- container -->
<section>
	<div class="container hide-pc-lnb" id="container">
	<%@ include file="/WEB-INF/jsp/nbportal/include/lnb.jsp" %>

	<!-- contents  -->
	<article>
		<div class="contents" id="contents">
			
			<div class="contents-title-wrapper">
				<h3>간략조회<span class="arrow"></span></h3>				
			</div>

			<div class="contents-area">
			<!-- CMS 시작 -->
			
			<!-- wrap_layout_flex -->
			<div class="wrap_layout_flex fix_page">
			<div class="layout_easySearch layout_flex_100">
			<%-- <%@ include file="/WEB-INF/jsp/nbportal/include/gnb.jsp" %> --%>

			<!-- easySearchArea -->
			<div class="easySearchArea" id="tabs">
				<div class="fullSize directH"><button><spring:message code='stat.ko.message.130'/></button></div>

				<div class="contents-title-wrapper directTitle">
		            <h3>간략조회<span class="arrow"></span></h3>
	        	</div>
				<!-- // searchTab -->
				
				<%-- <c:import  url="easyStatSchTab.jsp"/> --%>

				<!-- easySearch -->
				<div class="tabArea" id="tabs-1">
				<div class="tab_location">
					<ul>
					</ul>
				</div>
				<div class="easySearch directBg">
					<!-- areaDv -->
					<div class="areaDv">
					<form name="statsEasy-mst-form" method="post">
						<input type="hidden" name="chartType" value="" title="chartType"/><!-- 차트 : 선택타입 -->
						<input type="hidden" name="chartStockType" value="HISTORY" title="chartStockType"/><!-- 차트 : HISTORY/SCROLL -->
						<input type="hidden" name="chart23Type" value="2D" title="chart23Type"/><!-- 차트 : 2D/3D -->
						<input type="hidden" name="chartLegend" value="" title="chartLegend"/><!-- 차트 : 범례 -->
						<input type="hidden" name="tabMapVal" value="" title="tabMapVal"/><!-- 지도유형 : KOREA / WORLD -->
						<input type="hidden" name="wrttimeOrder" value="A" title="wrttimeOrder"/><!-- 데이터 정렬순서 -->
						<!-- leftArea -->
						<div class="leftArea">
							<div class="schTit">
								<strong id="schTitTxt">통계표검색</strong>
							</div>
							<div class="left_bar">
								<a href="javascript:;" class="on">열기/닫기</a>
							</div>
							<div class="boxTab" style="display: none;">
								<div class="tab">
									<ul>
										<li><a href="javascript:;" id="tabSubj" class="on" data-gubun="SUBJ">주제별</a></li>
										<li><a href="javascript:;" id="tabNm" data-gubun="NAME">통계명</a></li>
										<li><a href="javascript:;" id="tabCt" data-gubun="NABOCIT">국회위원회별</a></li>
										<li><a href="javascript:;" id="tabOg" data-gubun="ORIGIN">출처별</a></li>
									</ul>
								</div>
							</div>
							<div class="box">
								<div class="schBar">
									<div>
										<label for="searchGubun" class="hide">검색구분</label>
										<select id="searchGubun" name="searchGubun" title="검색구분선택">
											<option value="STATBL_NM"><spring:message code='stat.ko.message.105'/></option>
											<option value="ITM_NM"><spring:message code='stat.ko.message.106'/></option>
											<!-- option value="STATALL_NM">전체</option-->
										</select>
									</div>
									<div class="auto">
										<input type="text" name="statSearchVal" id="statSearchVal" value="${searchVal }" placeholder="<spring:message code='stat.ko.message.107'/>" title="<spring:message code='stat.ko.message.107'/>"/>
									</div>
									<div class="btn">
										<button type="button" class="btnSt1 btn2" title='<spring:message code='stat.ko.message.108'/>' name='btn_statInquiry'><spring:message code='stat.ko.message.108'/></button>
										<button type="button" class="btnSt1 btn1 mHide" title='<spring:message code='stat.ko.message.109'/>' name='btn_statExcelDwon'><spring:message code='stat.ko.message.109'/></button>
									</div>
								</div>
								
								<!-- 모바일용 통계주제 -->
								<div class="schBar schSubject wHide">
									<div class="tit">
										<strong><spring:message code='stat.ko.message.208'/></strong>
									</div>
									<div class="auto">
										<select name="mbSubject" id="mbSubject" title="mbSubject">
											<option value="">전체</option>
											<c:forEach var="mb" items="${cateTopList }">
											<c:choose>
												<c:when test="${mb.cateId == treeCateId }">
													<option value="${mb.cateId }" selected="selected">${mb.cateNm }</option>	
												</c:when>
												<c:otherwise>
													<option value="${mb.cateId }">${mb.cateNm }</option>
												</c:otherwise>
											</c:choose>
											</c:forEach>
										</select>
									</div>
								</div>
								<!-- // 모바일용 통계주제 -->
								
								<!-- treeCtrl -->
								<div class="treeCtrl mHide">
									<ul class="tree_comm">
										<li><span class="tc01">통계표</span></li>
										<li><span class="tc02">콘텐츠</span></li>
										<li><span class="tc03">지도</span></li>
									</ul>
									<span class="onoff">
										<span class="tt"><spring:message code='stat.ko.message.110'/>/<spring:message code='stat.ko.message.111'/></span>
										<button type="button" class="on" name="statAllExpand" title="열기"></button>
										<button type="button" class="off" name="statAllUnExpand" title="닫기"></button>
									</span>
								</div>
								<!-- // treeCtrl -->
								<!-- keyword -->
								<div class="keyword" style="display: none;">
									<label for="hdnKeywordVal" class="hide">명칭별검색</label>
									<input type="text" id="hdnKeywordVal" title="명칭별검색어 입력" style="display:none;" />
									<ul>
										<li><button title="ㄱ">ㄱ</button></li>
										<li><button title="ㄴ">ㄴ</button></li>
										<li><button title="ㄷ">ㄷ</button></li>
										<li><button title="ㄹ">ㄹ</button></li>
										<li><button title="ㅁ">ㅁ</button></li>
										<li><button title="ㅂ">ㅂ</button></li>
										<li><button title="ㅅ">ㅅ</button></li>
										<li><button title="ㅇ">ㅇ</button></li>
										<li><button title="ㅈ">ㅈ</button></li>
										<li><button title="ㅊ">ㅊ</button></li>
										<li><button title="ㅋ">ㅋ</button></li>
										<li><button title="ㅌ">ㅌ</button></li>
										<li><button title="ㅍ">ㅍ</button></li>
										<li><button title="ㅎ">ㅎ</button></li>
									</ul>
									<div class="etc"><button title="기타">기<br />타</button></div>
								</div>
								
								<!-- treeBox -->
								<div class="treeBox type1 size2" id="leftTreeBox">
									<div class="tree" id="tree">
										<ul id="treeStatData" class="ztree" style="height:100%;overflow-x:auto;margin-left:5px;"><li></li></ul>
									</div>
								</div>
								
								<!-- 모바일 리스트 -->
								<div class="searchResult" id="mobileList">
									<ul></ul>
								</div>
								
								<!-- page -->
       							<div id="stat-pager-sect" class="page" style="display: none;'"></div>
								
								<!-- PC 검색결과 레이어 -->
								<div class="searchResult layerType" id="searchResult" style="display: none;">
									<button class="close" id="searchResultClose" title="닫기"></button>
									<p class="title">
										<spring:message code='stat.ko.message.212'/>
									</p>
									<div class="sort_btn">
										<button id="sortAsc" title="내림차순">▼</button><button id="sortDesc" title="오름차순">△</button>
									</div>
									<ul></ul>
								</div>
							</div>
						</div>
						<!-- // leftArea -->
						
						<div class="rightCont" style="display: none;">
							<div class="schTit"><strong id="contTitle">NABO 콘텐츠</strong><span class="txt cmmtIdtfr juseok"></span></div>
							<div class="content_year">
								<select id="fileSelect" title="년도선택"></select>
								<a href="javascript:;" class="btnSt1 btn11" id="detailAnalysis">상세분석</a>
								<a href="#" class="btnSt1 btn10" id="fileDownload">다운로드</a>
								<button class="btnSt1 btn3 m-on" type="button" name="list" title="목록" id="btnMobileList">목록</button>
							</div>
						    <div class="content_tab">
								<ul id="contTab">
									<li class="on" id="tab_A_G" data-link="graph-sect">
										<a href="javascript:;"><i>그래프</i></a>
									</li>
									<li id="tab_A_S" data-link="statTbl-sect">
										<a href="javascript:;"><i>통계표</i></a>
									</li>
									<li id="tab_A_T" data-link="statCont-sect">
										<a href="javascript:;"><em>통계</em><em>콘텐츠</em></a>
									</li>
									<li id="tab_A_E" data-link="statHaesul-sect">
										<a href="javascript:;"><em>통계</em><em>해설</em></a>
									</li>
									<li id="tab_A_D" data-link="wordExplantion-sect">
										<a href="javascript:;"><em>용어</em><em>설명</em></a>
									</li>
									<li id="tab_A_R" data-link="naboAnals-sect">
										<a href="javascript:;"><em>통계</em><em>설명</em></a>
									</li>
									<li id="tab_A_O" data-link="assemblyIdea-sect">
										<a href="javascript:;"><em>국회</em><em>부대의견</em></a>
									</li>
									<li id="tab_A_C" data-link="correct-sect">
										<a href="javascript:;"><em>시정</em><em>조치</em></a>
									</li>
								</ul>
							</div>
							<div class="content_body">
								<div class="content_inner">
								
									<!-- 그래프  -->
									<div id="graph-sect" class="mt-10x">
										<div class="conTitle">
											<h4 class="title0401">그래프</h4>
										</div>
										<div class="tabBx conTabox">
											<!-- <div class="tabSt">
												<ul>
													<li class="on"><a href="#chartTab" title="Chart">Chart</a></li>
													<li style="display:none"><a href="#mapTab" title="Map">Map</a></li>
												</ul>
											</div> -->
										</div>
										<div class="chartMenu">
											<select name="chartCategories" class="chartSel" title="차트 선택" ><option>선택</option></select>
											<button type="button" name="remarkControl" title="범례"><img src="<c:url value="/images/soportal/chart/charbtn01.png" />" alt="범례"/></button>										
											  <div class="remark-content" style="display:none;">
											    <ul>
											    	<li style="display:none;"><a href="javascript:;" name="remarkShow" title="범례보이기">범례 보이기</a></li>
												    <li><a href="javascript:;" name="remarkHide" title="범례숨기기">범례 숨기기</a></li>
												    <li><a href="javascript:;" name="legAllChk" title="범례 전체선택">범례 전체선택</a></li>
												    <li><a href="javascript:;" name="legAllNon" title="범례 전체선택해제">범례 전체선택해제</a></li>
											    </ul>
											  </div>						
											<!-- button type="button" name="chartStockType" title="차트스톡"><img src="<c:url value="/images/soportal/chart/charbtn02_on.png" />" alt="차트스톡"/></button-->			
											<button type="button" name="chartBasic" title="기본차트"><img src="<c:url value="/images/soportal/chart/charbtn19on.png" />"  alt="기본차트"/></button>								
											<button type="button" name="chartViewType" title="차트타입"><img src="<c:url value="/images/soportal/chart/charbtn03.png" />" alt="차트타입"/></button>										
											<button type="button" name="chartSpline" title="라인"><img src="<c:url value="/images/soportal/chart/charbtn04.png" />" alt="라인"/></button>										
											<button type="button" name="chartLine" title="스톡라인"><img src="<c:url value="/images/soportal/chart/charbtn05.png" />" alt="스톡라인"/></button>										
											<button type="button" name="chartArea" title="누적라인"><img src="<c:url value="/images/soportal/chart/charbtn06.png" />" alt="누적라인"/></button>										
											<button type="button" name="chartHbar" title="막대"><img src="<c:url value="/images/soportal/chart/charbtn07.png" />" alt="막대"/></button>										
											<button type="button" name="chartAccHbar" title="누적막대"><img src="<c:url value="/images/soportal/chart/charbtn08.png" />" alt="누적막대"/></button>										
											<button type="button" name="chartPAccHbar" title="퍼센트누적막대"><img src="<c:url value="/images/soportal/chart/charbtn09.png" />" alt="퍼센트누적막대"/></button>										
											<button type="button" name="chartWbar" title="가로막대"><img src="<c:url value="/images/soportal/chart/charbtn10.png" />" alt="가로막대"/></button>										
											<button type="button" name="chartAccWbar" title="가로누적막대"><img src="<c:url value="/images/soportal/chart/charbtn11.png" />" alt="가로누적막대"/></button>										
											<button type="button" name="chartPAccWbar" title="퍼센트가로누적막대"><img src="<c:url value="/images/soportal/chart/charbtn12.png" />" alt="퍼센트가로누적막대"/></button>										
											<button type="button" name="chartPie" title="파이"><img src="<c:url value="/images/soportal/chart/charbtn13.png" />" alt="파이"/></button>										
											<button type="button" name="chartDonut" title="도넛"><img src="<c:url value="/images/soportal/chart/charbtn14.png" />" alt="도넛"/></button>										
											<button type="button" name="chartTreeMap" title="TreeMap"><img src="<c:url value="/images/soportal/chart/charbtn15.png" />" alt="TreeMap"/></button>										
											<button type="button" name="chartSpiderWeb" title="Spiderweb"><img src="<c:url value="/images/soportal/chart/charbtn16.png" />" alt="Spiderweb"/></button>										
											<button type="button" name="chartSunburst" title="Sunburst"><img src="<c:url value="/images/soportal/chart/charbtn17.png" />" alt="Sunburst"/></button>										
											<button type="button" name="chartDownload" title="차트다운로드"><img src="<c:url value="/images/soportal/chart/charbtn18.png" />" alt="차트다운로드"/></button>
											  <div class="dropdown-content" style="display: none;">
											    <ul>
											    	<li><a href="#png" name="chartPng" title="PNG"><span>PNG</span> 다운로드</a></li>
												    <li><a href="#jpeg" name="chartJpeg" title="JPEG"><span>JPEG</span> 다운로드</a></li>
												    <li><a href="#pdf" name="chartPdf" title="PDF"><span>PDF</span> 다운로드</a></li>
												    <li><a href="#svg" name="chartSvg" title="SVG"><span>SVG</span> 다운로드</a></li>
											    </ul>
											  </div>
	
										</div>
										<div class="content_graph mb-15x" id="statChart">
											차트 및 맵 영역
										</div>
										<div id="slider"></div>
										
										<!-- maparea -->
										<div class="maparea" style="display:none">
											<div class="toparea">
											</div>
											<div class="mapDv">
												<div class="mapMenu">
													<select name="mapCategories" class="chartSel" title="map선택"><option value="">선택</option></select>
													<select name="mapItms" class="chartSel" title="map항목선택" ><option value="">선택</option></select>
												</div>								
												<div class="map statEasyMap" id="statMap"></div>
											</div>
										</div>
										<!-- /// maparea -->

									</div>
									<!-- //그래프  -->
								
									<!-- 통계표  -->
									<div id="statTbl-sect">
										<div class="conTitle conTitle_mb30x">
											<h4 class="title0401">통계표</h4>
										</div>
										<div class="mobile_wide_btn pageDir">
											<a href="#">전체화면</a>
											<div class="mdb_shadow"></div>
										</div>
										
										
										<div class="header_fixed header_fixed_direc">
											<input type="checkbox" id="chkFrozenCol">
											<label for="chkFrozenCol"> 좌측헤더고정</label>
										</div>
										
										<div class="sheetarea conSheet sheet_t40">
											<div class="toparea">
												<div class="cellbox">
													<div class="cell">
														<div class="fileChange">
															<span class="btns">
																<button type="button" name="downXLS" title="XLS">XLS</button>
																<!-- 숨김처리
																<button type="button" name="downCSV" title="CSV">CSV</button>
																<button type="button" name="downJSON" title="JSON">JSON</button>
																<button type="button" name="downXML" title="XML">XML</button>
																<button type="button" name="downTXT" title="TXT">TXT</button> -->
																<!-- <button type="button" name="downHWP" title="HWP">HWP</button> -->
															</span>
														</div>
													</div>
												</div>
											</div>
										</div>
										<div class="content_sheet">
											<script type="text/javascript">createIBSheet("statSheet", "100%", "100%"); </script>
										</div>
										<div class="conComment">
											<span class="cmmt"></span>
										</div>
									</div>
									<!-- //통계표  -->
									
									<!-- 통계콘텐츠  -->
									<div id="statCont-sect" class="mt-10x">
										<div class="conTitle">
											<h4 class="title0401">통계콘텐츠</h4>
										</div>
										<div class="content_free">
											<div class="free_cont"></div>
											<div class="free_cont"></div>
										</div>
									</div>
									<!-- //통계콘텐츠  -->
								
									<!-- 통계해설  -->
									<div id="statHaesul-sect">
										<div class="conTitle">
											<h4 class="title0401">통계해설</h4>
										</div>
										<div class="content_free">
											<div class="free_title"></div>
											<div class="free_cont"></div>
											<div class="content_down"></div>
											<div class="content_link"></div>
										</div>
									</div>
									<!-- //통계해설  -->
								
									<!-- 용어설명 -->
									<div id="wordExplantion-sect">
										<div class="conTitle">
											<h4 class="title0401">용어설명</h4>
										</div>
										<div class="content_desc">
											<div class="desc_title">
												<div class="desc01">용어</div>
												<div class="desc02">설명</div>
											</div>
											<div id="content_desc_text">
												<div class="desc_text">
													<div class="desc01 vamle"></div>
													<div class="desc03"></div>
												</div>
											</div>
										</div>
									</div>
									<!-- //용어설명  -->
								
									<!-- 통계설명 -->
									<div id="naboAnals-sect">
										<div class="conTitle">
											<h4 class="title0401">통계설명</h4>
										</div>
										<div class="content_free">
											<div class="free_title"></div>
											<div class="free_cont"></div>
											<div class="content_down"></div>
											<div class="content_link"></div>
										</div>
									</div>
									<!-- //통계설명  -->
								
									<!-- 국회부대의견 -->
									<div id="assemblyIdea-sect">
										<div class="conTitle">
											<h4 class="title0401">국회부대의견</h4>
										</div>
										<div class="content_free">
											<div class="free_title"></div>
											<div class="free_cont"></div>
											<div class="content_down"></div>
											<div class="content_link"></div>
										</div>
									</div>
									<!-- //국회부대의견  -->
								
									<!-- 시정조치 -->
									<div id="correct-sect">
										<div class="conTitle">
											<h4 class="title0401">시정조치</h4>
										</div>
										<div class="content_good">
											<div class="free_title"></div>
											<div class="good_title"></div>
											<div class="good_title_cont"></div>
											<div class="good_title bgred"></div>
											<div class="good_title_ans"></div>
											<div class="content_down"></div>
											<div class="content_link"></div>
										</div>	
									</div>								
									<!-- //시정조치  -->

								</div>
							</div>
						</div>
					</form>
					</div>
					<!-- // areaDv -->
				</div>

				<!-- // easySearch -->
			
			</div>
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
							
			<!-- //CMS 끝 -->
			</div>
			<!-- 상단으로 이동 -->
			<a href="#btn-top-go" class="btn-top-go directbtn">
				TOP
			</a>
			<!-- //상단으로 이동 -->
		</div>
	</article>
	<!-- //contents  -->

</div>
</section>
<!-- //container -->

<%@ include file="/WEB-INF/jsp/nbportal/include/footer.jsp" %>

</div>

<c:import  url="/WEB-INF/jsp/inc/iframepopup.jsp"/>

<form method="post" name="commonForm" id="commonForm" >
<input type="hidden" name="page" title="page" value="<c:out value="${param.page}" default="1" />" />
<input type="hidden" name="rows" title="rows" value="<c:out value="${param.rows}" default="10" />" />
<input type="hidden" name="statblId" id="sId" title="statblId" value="${statblId }" />
<input type="hidden" name="searchVal" title="searchVal" id="searchVal"/>
<input type="hidden" name="searchGb"  title="searchGb" id="searchGb" />
<input type="hidden" name="firParam" id="firParam" title="firParam" value="${firParam }" />
<input type="hidden" name="isFirst" id="searchType" title="searchType" value="${searchType }" />
<input type="hidden" name="mainCall" id="mainCall" title="mainCall" value="${mainCall}" />
<input type="hidden" name="statGb" id="statGb" title="statGb" value="${statGb }"/>
<input type="hidden" name="treeCateId" id="treeCateId" title="treeCateId" value="${treeCateId }"/>
<input type="hidden" name="sortGb" id="sortGb" title="sortGb" value="ASC"/>
<input type="hidden" name="seq" title="seq" id="seq" />
</form>

</body>
</html>