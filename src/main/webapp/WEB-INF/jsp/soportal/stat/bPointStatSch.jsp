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
<!-- 복수통계용  js추가  -->
<script type="text/javascript" src="<c:url value="/js/soportal/stat/multiStatSch.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/soportal/stat/multiStatSchSearch.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/soportal/stat/multiStatSchTree.js" />"></script>
<!-- 기준시점대비 변동분석   js추가  -->
<script type="text/javascript" src="<c:url value="/js/soportal/stat/bPointStatSch.js" />"></script>
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
				<h3> <c:out value="${requestScope.menu.lvl2MenuPath}" /><span class="arrow"></span></h3>
			</div>

			<div class="contents-area">
			<!-- CMS 시작 -->
			
			<!-- wrap_layout_flex -->
			<div class="wrap_layout_flex"> <!-- fix_page 클래스 달아야 하단에 페이징 자리생김 -->
			<div class="layout_easySearch layout_flex_100">

			<!-- easySearchArea -->
			<div class="easySearchArea" id="tabs">
				<div class="fullSize"><button><spring:message code='stat.ko.message.130'/></button></div>
				<input type="hidden" name="statsGB" id="statsGB" value="Mix" title="statsGB"/>
					
				<!-- searchTab -->
				<div class="searchTab" id="searchTab">
					<ul class="tabTitle" id="statTabArea">
						<li class="all"><a href="javascript:;" id="tab_title"><span>변동분석</span></a></li>
					</ul>
				</div>
				<!-- // searchTab -->
				<c:import  url="bPointStatSchTab.jsp"/>

				<!-- easySearch -->
				<div class="tabArea" id="tabs-1">
				<div class="box3header"  style="z-index:0;">
					<h4 id="stat_title_pop">통계표를 선택하세요.</h4>
					<div class="box3linebtn">						 
						<a href="javascript:;" class="btnSt1 btn4" id="addItmTab1" name="addItmTab1">추가</a> 
					</div> 
					<a id="centerClose" href="javascript:;" class="xbtn">닫기</a>
				</div>
				<div class="easySearch"> <!-- complex2 클래스추가 -->
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

								<div class="tabSt2 wHide">
									<ul>
										<li class="on" id="L"><a href="javascript:;" id="mixStatList">통계목록</a></li>
										<li class="" id="D"><a href="javascript:;" id="mixStatSelData"><spring:message code='stat.ko.message.171'/></a></li>
									</ul>
									<!-- <div class="rSide"><a href="javascript:;" class="btnSt1 schBtn btn9" id="addMultiStatTab"><spring:message code='stat.ko.message.129'/></a></div> -->
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
								<div class="schmobile">
									<strong id='stat_title_pop_m'></strong>
									<a href="javascript:;" class="btn_add_sch" id="itmPlusM1" name="itmPlusM1">추가</a>
									<a href="javascript:;" class="xbtn" id="itmCloseM1" name="itmCloseM1">닫기</a>
								</div>
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
											</div>
										</div>
										<!-- // treeBox -->
									</div>
								</div>
								<div class="moveBtn">
									<button type="button" class="left" id="itmPlus" title="추가"></button>
									<button type="button" class="right" id="itmMinus" title="제거"></button>
								</div>

								<!-- dvBx -->
								<div class="dvBx dvXv">
									<a href="javascript:;" class="btnSt1 btn5" id="itmPlusM2"><spring:message code='stat.ko.message.213'/></a>
									<a href="javascript:;" class="btn_close_sch" id="itmCloseM2">닫기</a>
								</div>
								<!-- // dvBx -->
							</div>
							<!-- // lSide -->
							<!-- rSide -->
							<div class="rSide">
								<div class="schTit c336699 align"><strong id='stat_title'></strong></div>
								<div class="box2">
									<div class="dataInfo">
										<ul>
											<li>
												<strong>주기 :</strong>
												<span id="dtacycleCdDisplay"></span>
											</li>
											<li>
												<strong>수록기간 :</strong>
												<span id="wrttimeDisplay"></span>
												<input type="hidden" id="hdnWrttimeDisplayMin"/>
												<input type="hidden" id="hdnWrttimeDisplayMax"/>
											</li>
										</ul>
									</div>
									<!-- searchCtrl -->
									<form method="post" name="searchForm" id="searchForm" >
									<div class="searchCtrl multi_ctrl">
										<div class="ctrl">
											<!-- searchDv -->
											<div class="searchDv type2">
												<div class="dv multi_dv">
													<p class="tit">기준 주기</p>
													<div class="cellbox">
														<div class="cellrow">
															<div class="cell auto">
																<label for="dtacycleCd" class="hide">기준주기</label>
																<select name="dtacycleCd" id="dtacycleCd" title="기준주기" style="">
																	<option value="">선택</option>
																</select>
															</div>
															<div class="cell txt1 cell_fixed">(최초 선택 시 고정)</div>
														</div>
													</div>
													<div class="cell_sel">※ 기준검색주기를 변경하시려면 선택 항목을 초기화 하시기 바랍니다.</div>
													
												</div>
											</div>

										</div> 
										<!-- // searchDv -->
										
										<div class="schBtnBx pr">

											<div class="cellbox">
												<div class="btnExp">
													<a href="javascript:;" class="btnSt1 btn2 btnExp" id="btn_centerExtend1" name="btn_centerExtend1">선택확장</a>
												</div>
												<div class="cell alignR">
													<a href="javascript:;" class="btnSt1 btn4" id="addStatTab1"><spring:message code='stat.ko.message.129'/></a>
												</div>
											</div>
										</div>
										
										<div class="schTit type2">
											<strong><spring:message code='stat.ko.message.171'/></strong>
											<div class="right">
												 <button class="btnMixDown" type="button" id="mixDown" title="내리기"><img src="<c:url value="/images/soportal/btn_up.png" />" alt="<spring:message code='stat.ko.message.216'/>" /></button>
												<button class="btnMixUp" type="button" id="mixUp" title="올리기"><img src="<c:url value="/images/soportal/btn_dn.png" />" alt="<spring:message code='stat.ko.message.217'/>" /></button>
												<button type="button" class="btnSt1 btn7 reset" id="mixReset" title="초기화"><spring:message code='stat.ko.message.172'/></button>
												<button type="button" class="btnSt1 btn7 delete" id="mixDelete" title="삭제">삭제</button>
											</div>
										</div>

										<!-- searchTbl -->
										<div class="searchTbl">
										<!-- table -->
											<div id='mixContainer' class="bpint"></div>
										<!-- //table -->
										</div>
										<!-- // reportTable -->
										
										<!-- b Point  -->
										<div class="bpoint">
											<div>
												<label class="bp01">기준<br>시점</label>
												<div class="bp02s">
													<span>
														<select id="dtaWrttimeYear" name="dtaWrttimeYear">
															<option id="">선택</option>
														</select>
													</span>
													<span>
														<select id="dtaWrttimeQt" name="dtaWrttimeQt">
															<option id="">선택</option>
														</select>
													</span>
												</div>
												<label for="dtaCalcNullToZero" class="left50">
													<input type="checkbox" id="dtaCalcNullToZero" name="dtaCalcNullToZero" value="Y" checked="checked">
													NULL값은 0으로 계산
												</label>
											</div>
										</div>
										<!-- //b Point  -->

											<div class="searchDv type2">
											
												<!-- 정렬 -->
												<div class="dv multi_dv">
													<p class="tit"><spring:message code='stat.ko.message.118'/></p>
													<div class="cellrow pl17">
														<div class="cell">
															<label for="searchSort" class="hide">정렬선택</label>
															<select name="searchSort" id="searchSort" title="정렬선택">
																<option value="A"><spring:message code='stat.ko.message.119'/></option>
																<option value="D"><spring:message code='stat.ko.message.120'/></option>
															</select>
														</div>
													</div>
												</div>
												
												<!-- 검색기간 -->
												<div class="dv multi_dv">
													<p class="tit"><spring:message code='stat.ko.message.108'/> <spring:message code='stat.ko.message.125'/></p>
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
																<label for="wrttimeLastestVal">검색갯수</label> <input type="text" id="wrttimeLastestVal" name="wrttimeLastestVal" value="10" title="검색갯수" class="w70"/> 
																<span><spring:message code='stat.ko.message.128'/></span>
															</div>
														</div>
	
													</div>
												</div>
											</div>

										<div class="schBtnBx pr">

											<div class="cellbox">
												<div class="btnExp">
													<a href="javascript:;" class="btnSt1 btn2 btnExp" id="btn_centerExtend2" name="btn_centerExtend2">선택확장</a>
												</div>
												<div class="cell alignR">
													<a href="javascript:;" class="btnSt1 btn4" id="addStatTab2"><spring:message code='stat.ko.message.129'/></a>
												</div>
											</div>
										</div>
										
										</div>
									
									</form>
									<!-- // searchCtrl -->
								</div>
							
							</div>
							<!-- // rSide -->
						</div>
						<!-- // rightArea -->
					</div>
					<!-- // areaDv -->
					<div class="box3linebtn">
						<a href="javascript:;" class="btnSt1 btn5" id="addItmTab2" name="addItmTab2">추가</a> 
						<a href="javascript:;" class="btnSt1 btn35" id="centerDivClose" name="centerDivClose">닫기</a> 
					</div>

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

			<!-- 선택항목 등록 로딩 페이지 -->
			<div class="layerpopup-loading-wrapper" id="itmMix-box" style="z-index:13;">
				<div class="bg-opacity-black45"></div>
				<div class="layerpopup-loading-area">
					<img src="<c:url value="/images/soportal/icon/icon_loading.gif"/>" alt="Loding" />
					<span>선택항목 등록중입니다. 잠시만 기다려 주세요</span>
				</div>
			</div>
			<!-- //선택항목 등록 로딩 페이지 -->
			
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
<!-- // layout_A -->
	<!-- <div class="footer">
		<img src="/images/soportal/@footer.png" width="982" height="170" alt="하단" />
	</div> -->

	<c:import  url="/WEB-INF/jsp/inc/iframepopup.jsp"/>

<form method="post" name="commonForm" id="commonForm" >
<input type="hidden" name="page" title="page" value="<c:out value="${param.page}" default="1" />"/>
<input type="hidden" name="rows" title="rows" value="<c:out value="${param.rows}" default="10" />" />
<input type="hidden" name="statblId" id="sId" title="statblId" value="${statblId }" />
<input type="hidden" name="searchVal" title="searchVal" id="searchVal" />
<input type="hidden" name="searchGb" title="searchGb" id="searchGb" />
<input type="hidden" name="firParam" id="firParam" title="firParam" value="${firParam }" />
<input type="hidden" name="isFirst" id="searchType" title="isFirst" value="${searchType }" />
<input type="hidden" name="mixCycleVal" id="mixCycleVal" title="mixCycleVal" value="" />
<input type="hidden" name="statGb" id="statGb" title="statGb" />
<input type="hidden" name="sortGb" id="sortGb" title="sortGb" value="ASC"/>
<input type="hidden" name="multiGb" id="multiGb" title="multiGb" />
</form>
</body>
</html>	