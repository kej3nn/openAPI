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
<!-- 간편통계용  js추가  -->
<script type="text/javascript" src="<c:url value="/js/soportal/stat/easyStatSch.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/soportal/stat/easyStatSchSearch.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/soportal/stat/easyStatSchTree.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/soportal/stat/easyStatSchContents.js" />"></script>
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
				<h3>상세분석<span class="arrow"></span></h3>
				
			</div>

			<div class="contents-area">
			<!-- CMS 시작 -->
			
			<!-- wrap_layout_flex -->
			<div class="wrap_layout_flex fix_page">
			<div class="layout_easySearch layout_flex_100">

			<!-- easySearchArea -->
			<div class="easySearchArea" id="tabs">
				<div class="fullSize"><button><spring:message code='stat.ko.message.130'/></button></div>

				<!-- searchTab -->
				<div class="searchTab" id="searchTab">
					<ul class="tabTitle" id="statTabArea">
						<li class="all"><a href="javascript:;" id="tab_title"><span>상세분석</span></a></li>
					</ul>
				</div>
				<!-- // searchTab -->
				<c:import  url="easyStatSchTab.jsp"/>

				<!-- easySearch -->
				<div class="tabArea" id="tabs-1">
				<div class="box3header"  style="z-index:0;">
					<h4 id="stat_title_pop">통계표를 선택하세요.</h4>
					<div class="box3linebtn">						 
						<a href="javascript:;" class="btnSt1 btn4" id="addStatTab_pop" name="addStatTab_pop">조회</a> 
					</div> 
					<a id="centerClose" href="javascript:;" class="xbtn">닫기</a>
				</div>
				<div class="easySearch">
					<!-- areaDv -->
					<div class="areaDv">
						<!-- leftArea -->
						<div class="leftArea">
							<div class="schTit">
								<strong>통계표검색</strong>
							</div>
							<div class="left_bar2">
								<a id="fullOpen" href="javascript:;">열기/닫기</a>
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
										<input type="text" name="statSearchVal" id="statSearchVal" value="" placeholder="<spring:message code='stat.ko.message.107'/>" title="<spring:message code='stat.ko.message.107'/>"/>
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
										<label for="mbSubject" class="hide">통계주제</label>
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
								<div class="treeBox type1 size2">
									<div class="tree" id="tree">
										<ul id="treeStatData" class="ztree" style="height:624px;overflow-x:auto;margin-left:5px;"><li></li></ul>
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
						<!-- rightArea -->
						<div class="rightArea">
							<!-- lSide -->
							<div class="lSide">
								<div class="box1s">
									<div class="schTit" id="grpTitle"><strong><spring:message code='stat.ko.group'/>선택</strong></div>
									<div class="box" id="grpBox">
										<div class="schBar">
											<div>
												<input type="text"  name="grpSearchVal" id="grpSearchVal" value="" placeholder="<spring:message code='stat.ko.message.107'/>" title="<spring:message code='stat.ko.message.107'/>"/>
											</div>
											<div class="btn">
												<button class="btnSt1 btn2" title='<spring:message code='stat.ko.message.108'/>' name='btn_grpInquiry'><spring:message code='stat.ko.message.108'/></button>
												<button type="button" class="btnSt1 btn1" title='초기화' name='btn_grpReset'>초기화</button>
											</div>
										</div>
										<!-- treeCtrl -->
										<div class="treeCtrl">
											<span class="onoff">
												<span class="tt"><spring:message code='stat.ko.message.110'/>/<spring:message code='stat.ko.message.111'/></span>
												<button class="on" name="grpAllExpand" title="열기"></button>
												<button class="off" name="grpAllUnExpand" title="닫기"></button>
											</span>
											<span class="chk">
												<span class="tt"><spring:message code='stat.ko.message.114'/>/<spring:message code='stat.ko.message.115'/></span>
												<button class="on" name="grpAllChk" title="선택"></button>
												<button class="off" name="grpAllUnChk" title="해제"></button>
											</span>
										</div>
										<!-- // treeCtrl -->
										<!-- treeBox -->
										<div class="treeBox size6" id="grpTreeBox">
											<div class="tree">
												<ul id="treeGrpData" class="ztree" style="height:144px;overflow-x:auto;"><li></li></ul>
											</div>
										</div>
										<!-- // treeBox -->
									</div>
								</div>
								<div class="box2s">
									<div class="schTit" id="clsTitle"><strong><spring:message code='stat.ko.message.113'/></strong></div>
									<div class="box" id="clsBox">
										<div class="schBar">
											<div>
												<input type="text" name="clsSearchVal" id="clsSearchVal" value="" placeholder="<spring:message code='stat.ko.message.107'/>" title="<spring:message code='stat.ko.message.107'/>"/>
											</div>
											<div class="btn">
												<button class="btnSt1 btn2" title='<spring:message code='stat.ko.message.108'/>' name='btn_clsInquiry'><spring:message code='stat.ko.message.108'/></button>
												<button type="button" class="btnSt1 btn1" title='초기화' name='btn_clsReset'>초기화</button>
											</div>
										</div>
										<!-- treeCtrl -->
										<div class="treeCtrl">
											<span class="onoff">
												<span class="tt"><spring:message code='stat.ko.message.110'/>/<spring:message code='stat.ko.message.111'/></span>
												<button class="on" name="clsAllExpand" title="열기"></button>
												<button class="off" name="clsAllUnExpand" title="닫기"></button>
											</span>
											<span class="chk">
												<span class="tt"><spring:message code='stat.ko.message.114'/>/<spring:message code='stat.ko.message.115'/></span>
												<button class="on" name="clsAllChk" title="선택"></button>
												<button class="off" name="clsAllUnChk" title="해제"></button>
											</span>
										</div>
										<!-- // treeCtrl -->
										<!-- treeBox -->
										<div class="treeBox size6" id="clsTreeBox">
											<div class="tree">
												<ul id="treeClsData" class="ztree" style="height:144px;overflow-x:auto;"><li></li></ul>
											</div>
										</div>
										<!-- // treeBox -->
									</div>
								</div>
								<div class="box3s">
									<div class="schTit" id="itmTitle"><strong><spring:message code='stat.ko.message.112'/></strong></div>
									<div class="box" id="itmBox">
										<div class="schBar">
											<div>
												<input type="text"  name="itmSearchVal" id="itmSearchVal" value="" placeholder="<spring:message code='stat.ko.message.107'/>" title="<spring:message code='stat.ko.message.107'/>"/>
											</div>
											<div class="btn">
												<button class="btnSt1 btn2" title='<spring:message code='stat.ko.message.108'/>' name='btn_itmInquiry'><spring:message code='stat.ko.message.108'/></button>
												<button type="button" class="btnSt1 btn1" title='초기화' name='btn_itmReset'>초기화</button>
											</div>
										</div>
										<!-- treeCtrl -->
										<div class="treeCtrl">
											<span class="onoff">
												<span class="tt"><spring:message code='stat.ko.message.110'/>/<spring:message code='stat.ko.message.111'/></span>
												<button class="on" name="itmAllExpand" title="열기"></button>
												<button class="off" name="itmAllUnExpand" title="닫기"></button>
											</span>
											<span class="chk">
												<span class="tt"><spring:message code='stat.ko.message.114'/>/<spring:message code='stat.ko.message.115'/></span>
												<button class="on" name="itmAllChk" title="선택"></button>
												<button class="off" name="itmAllUnChk" title="해제"></button>
											</span>
										</div>
										<!-- // treeCtrl -->
										<!-- treeBox -->
										<div class="treeBox size6" id="itmTreeBox">
											<div class="tree">
												<ul id="treeItmData" class="ztree" style="height:144px;overflow-x:auto;"><li></li></ul>
												<ul id="treeDvsData" class="ztree" style="display:none;"><li></li></ul>
											</div>
										</div>
										<!-- // treeBox -->
									</div>
								</div>
							</div>
							<!-- // lSide -->
							<!-- rSide -->
							<div class="rSide">
								<div class="schTit c336699 align"><strong id='stat_title'></strong></div>
								<div class="box2">
									<!-- searchCtrl -->
									<form method="post" name="searchForm" id="searchForm" >
									<div class="searchCtrl">
										<div class="ctrl">
										<!-- searchDv -->
										<div class="searchDv type1">
											<div class="dv">
												<p class="tit"><spring:message code='stat.ko.message.108'/><br><spring:message code='stat.ko.message.116'/></p>
												<div class="cellbox">
													<div class="cell auto">
														<label for="dtacycleCd" class="hide">주기선택</label>
														<select name="dtacycleCd" id="dtacycleCd" title="주기선택">
															<option value=""><spring:message code='stat.ko.message.117'/></option>
														</select>
													</div>
													<div class="cell txt1"><spring:message code='stat.ko.message.118'/></div>
													<div class="cell" style="width:40%">
														<label for="searchSort" class="hide">정렬선택</label>
														<select name="searchSort" id="searchSort" title="정렬선택">
															<option value="A"><spring:message code='stat.ko.message.119'/></option>
															<option value="D"><spring:message code='stat.ko.message.120'/></option>
														</select>
													</div>
												</div>
											</div>
										</div>

										<div class="searchDv type2">
											<div class="dv">
												<p class="tit"><spring:message code='stat.ko.message.108'/><br><spring:message code='stat.ko.message.125'/></p>
												<div class="cellbox" id="searchEasyForm">
	
													<div class="cellrow">
														<div class="cell chk"><input type="radio" name="wrttimeType" id="wrttimeTypeB" value="B" title="기간검색"/></div>
														<div class="cell">
															<input type="hidden" name="wrttimeMinYear" id="wrttimeMinYear" title="wrttimeMinYear"/>
															<input type="hidden" name="wrttimeMaxYear" id="wrttimeMaxYear" title="wrttimeMaxYear"/>
															<input type="hidden" name="wrttimeMinQt" id="wrttimeMinQt" title="wrttimeMinQt"/>
															<input type="hidden" name="wrttimeMaxQt" id="wrttimeMaxQt" title="wrttimeMaxQt"/>
															<div class="line">
																<label for="wrttimeStartYear" class="hide">시작년도검색</label>
																<select name="wrttimeStartYear" id="wrttimeStartYear" style="width:112px" title="시작년도검색">
																	<option value="">-</option>
																</select>
																<label for="wrttimeStartQt" class="hide">시작분기검색</label>
																<select name="wrttimeStartQt" id="wrttimeStartQt" style="width:80px; display: none;" title="시작분기검색">
																</select>
																<span>부터</span>
															</div>
															<div class="line">
																<label for="wrttimeEndYear" class="hide">종료년도검색</label>
																<select name="wrttimeEndYear" id="wrttimeEndYear" style="width:112px" title="종료년도검색">
																	<option value="">-</option>
																</select>
																<select name="wrttimeEndQt" id="wrttimeEndQt" style="width:80px; display: none;" title="종료분기검색">
																</select>	
																<span>까지</span>															
															</div>
														</div>
													</div>
													<div class="cellrow">
														<div class="cell chk"><input type="radio"  name="wrttimeType" id="wrttimeTypeL" value="L" title="시점검색" checked/></div>
														<div class="cell">
															<label for="wrttimeLastestVal" class="hide">검색갯수</label><input type="text" style="width:112px" id="wrttimeLastestVal" name="wrttimeLastestVal" value="10" title="검색갯수"/> 
															<span><spring:message code='stat.ko.message.128'/></span>
														</div>
													</div>
	
												</div>
											</div>
											</div>
										</div>
										<!-- // searchDv -->
										<div class="schBtnBx pr">

											<div class="cellbox">
												<div class="btnExp">
													<a href="javascript:;" class="btnSt1 btn2 btnExp" id="btn_centerExtend" name="btn_centerExtend">선택확장</a>
												</div>
												<div class="cell alignR">
													<a href="javascript:;" class="btnSt1 btn4" id="addStatTab" name="addStatTab"><spring:message code='stat.ko.message.129'/></a>
												</div>
											</div>
										</div>
										<div class="bg">차트이미지</div>
										</div>
									
									</form>
									<!-- // searchCtrl -->
								</div>
							
							</div>
							<!-- // rSide -->
						</div>
						<!-- // rightArea -->
						
						<div class="rightCont" style="display:none;">
							<div class="schTit"><strong id="contTitle">NABO 콘텐츠</strong></div>
						    <div class="content_year" id="content_year">
						    	<label for="fileSelect" class="hide">년도선택</label>
								<select id="fileSelect" title="년도선택" style="display: none;">
								</select>
								<a href="#" class="btnSt1 btn10" id="fileDownload" style="display: none;">다운로드</a>
								<a href="#" class="btnSt1 btn19" name="statDic">용어설명</a>
								<a href="#" class="btnSt1 btn11" id="detailAnalysis">상세분석</a>
								<button class="btnSt1 btn3 m-on" type="button" name="list" title="목록">목록</button>
							</div>
							<div class="content_body">
								<ul class="content_btn" id="content_button">
									<li><button class="btnSt1 btnX" type="button">통계해설</button></li>
									<li><button class="btnSt1 btn82" type="button">용어설명</button></li>
									<li><button class="btnSt1 btnX" type="button">통계설명</button></li>
									<li><button class="btnSt1 btnX" type="button">국회부대의견</button></li>
									<li><button class="btnSt1 btnX" type="button">시정조치</button></li>
									<li><button class="btnSt1 btnX" type="button">질의/답변</button></li>
									<li><button class="btnSt1 btn6 meta" type="button">메타데이터</button></li>									
								</ul>
								<div class="content_txt" id="content_txt"> 
									<div id="content_detail"></div>
									<div id="file_detail" class="free_cont"></div>
								</div>
							</div>
						</div>
						
					</div>
					<!-- // areaDv -->

					<div class="box3linebtn">
						<a href="javascript:;" class="btnSt1 btn4" id="addStatTab" name="addStatTab">조회</a> 
						<a href="javascript:;" class="btnSt1 btn35" id="centerDivClose" name="centerDivClose">닫기</a> 
					</div>
					
				</div>

				<!-- // easySearch -->
			
			</div>
			
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

<%@ include file="/WEB-INF/jsp/nbportal/include/footer.jsp" %>

</div>		

<c:import  url="/WEB-INF/jsp/inc/iframepopup.jsp"/>

<form method="post" name="commonForm" id="commonForm" >
<input type="hidden" name="page" title="page" value="<c:out value="${param.page}" default="1" />" />
<input type="hidden" name="rows" title="rows" value="<c:out value="${param.rows}" default="10" />" />
<input type="hidden" name="statblId" id="sId" title="statblId" value="${statblId }" />
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