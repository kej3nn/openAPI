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
<html lang="en" class="no-js">
<head>
<%@ include file="/WEB-INF/jsp/nbportal/include/headEng.jsp" %>
<c:import url="messageStatEng.jsp"/>
<script type="text/javascript" src="<c:url value="/js/soportal/data/service/jquery.fileDownloadnoMsg.js" />"></script>	
<!-- 복수통계용  js추가  -->
<script type="text/javascript" src="<c:url value="/js/soportal/stat/multiStatEngSch.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/soportal/stat/multiStatSchSearch.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/soportal/stat/multiStatSchTree.js" />"></script>

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
<style type="text/css">
#mixHeader { width: 100%; overflow-x: hidden; overflow-y: hidden; }
#mixBody { width: 100%; height: 412px; overflow-x: auto; overflow-y: auto; }
#mixHeaderM { width: 100%; overflow-x: hidden; overflow-y: hidden; }
#mixBodyM { width: 100%; height: 800px; overflow-x: auto; overflow-y: auto; }
</style>
</head>
<body>

<div class="layout_A">
<%@ include file="/WEB-INF/jsp/nbportal/include/headerEng.jsp" %>
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
				<div class="fullSize"><button><spring:message code='hf.en.message.130'/></button></div>
				<input type="hidden" name="statsGB" id="statsGB" value="Mix" title="statsGB"/>
				<!-- searchTab -->
				<div class="searchTab" id="searchTab">
					<ul class="tabTitle" id="statTabArea">
						<li class="all"><a href="javascript:;" id="tab_title"><span><spring:message code='hf.en.message.170'/></span></a></li>
					</ul>
				</div>
				<!-- // searchTab -->
				<c:import  url="multiStatEngSchTab.jsp"/>

				<!-- easySearch -->
				<div class="tabArea" id="tabs-1">
				<div class="easySearch"> <!-- complex2 클래스추가 -->
					<!-- areaDv -->
					<div class="areaDv">
						<!-- leftArea -->
						<div class="leftArea">
							<div class="schTit"><strong><spring:message code='hf.en.message.102'/></strong></div>
							<div class="boxTab">
								<span class="tab">
									<a href="javascript:;" id="tabSubj" class="on" data-gubun="SUBJ"><spring:message code='hf.en.message.103'/></a>
									<a href="javascript:;" id="tabNm" data-gubun="NAME"><spring:message code='hf.en.message.104'/></a>
								</span>
							</div>
							<div class="box">
								<div class="schBar">
									<div>
										<label for="searchGubun" class="hide"></label>
										<select id="searchGubun" name="searchGubun">
											<option value="ENG_STATBL_NM"><spring:message code='hf.en.message.105'/></option>
											<option value="ENG_ITM_NM"><spring:message code='hf.en.message.106'/></option>
											<!-- option value="STATALL_NM">전체</option-->
										</select>
									</div>
									<div class="auto">
										<label for="statSearchVal"></label>
										<input type="text" name="statSearchVal" id="statSearchVal" value="" placeholder="<spring:message code='hf.en.message.107'/>" title="<spring:message code='hf.en.message.107'/>"/>
									</div>
									<div class="btn">
										<button type="button" class="btnSt1 btn2" title='<spring:message code='hf.en.message.108'/>' name='btn_statInquiry'><spring:message code='hf.en.message.108'/></button>
										<button type="button" class="btnSt1 btn1 mHide" title='<spring:message code='hf.en.message.109'/>' name='btn_statExcelDwon'><spring:message code='hf.en.message.109'/></button>
									</div>
								</div>

								<!-- 모바일용 통계주제 -->
								<!-- div class="schBar schSubject wHide">
									<div class="tit">
										<strong><spring:message code='hf.en.message.208'/></strong>
									</div>
									<div class="auto">
										<select name="mbSubject" id="mbSubject" title="mbSubject">
										</select>
									</div>
								</div-->
								<!-- // 모바일용 통계주제 -->
								
								<!-- treeCtrl -->
								<div class="treeCtrl mHide">
									<span class="onoff">
										<span class="tt"><spring:message code='hf.en.message.110'/>/<spring:message code='hf.en.message.111'/></span>
										<button type="button" class="on" name="statAllExpand"></button>
										<button type="button" class="off" name="statAllUnExpand"></button>
									</span>
								</div>
								<!-- // treeCtrl -->
								<!-- keyword -->
								<div class="keyword" style="display: none;">

									<input type="text" id="hdnKeywordVal" title="hdnKeywordVal" style="display:none;" />
									<ul>
										<li><button>A</button></li>
										<li><button>B</button></li>
										<li><button>C</button></li>
										<li><button>D</button></li>
										<li><button>E</button></li>
										<li><button>F</button></li>
										<li><button>G</button></li>
										<li><button>H</button></li>
										<li><button>I</button></li>
										<li><button>J</button></li>
										<li><button>K</button></li>
										<li><button>L</button></li>
										<li><button>M</button></li>
										<li><button>N</button></li>
										<li><button>O</button></li>
										<li><button>P</button></li>
										<li><button>Q</button></li>
										<li><button>R</button></li>
										<li><button>S</button></li>
										<li><button>T</button></li>
										<li><button>U</button></li>
										<li><button>V</button></li>
										<li><button>W</button></li>
										<li><button>X</button></li>
										<li><button>Y</button></li>
										<li><button>Z</button></li>
										<li class="name_last"><button>ETC</button></li>
									</ul>
								</div>

								<div class="tabSt2 wHide">
									<ul>
										<li class="on" id="L"><a href="javascript:;" id="mixStatList">List</a></li>
										<li class="" id="D"><a href="javascript:;" id="mixStatSelData"><spring:message code='hf.en.message.171'/></a></li>
									</ul>
									<div class="rSide"><a href="javascript:;" class="btnSt1 schBtn btn9" id="addMultiStatTab"><spring:message code='hf.en.message.129'/></a></div>
								</div>

								<!-- treeBox -->
								<div class="treeBox type1 size2">
									<div class="tree" id="tree">
										<ul id="treeStatData" class="ztree" style="height:622px;overflow-x:auto;margin-left:5px;"><li></li></ul>
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
									<button class="close" id="searchResultClose"></button>
									<p class="title"><spring:message code='hf.en.message.212'/></p>
									<ul></ul>
								</div>

								<div class="searchResult2 wHide" style="display:none;">
									<div class="schTit type2">
										<strong><spring:message code='hf.en.message.171'/></strong>
										<div class="right">
											<button type="button" class="btnMixDown" id="mixDownM"><img src="<c:url value="/images/soportal/btn_up.png" />" alt="내리기" /></button>
											<button type="button" class="btnMixUp" id="mixUpM"><img src="<c:url value="/images/soportal/btn_dn.png" />" alt="올리기" /></button>
											<button type="button" class="btnSt1 btn5 reset" id="mixResetM"><spring:message code='hf.en.message.172'/></button>
											<button type="button" class="btnSt1 btn1" id="itmMinusM"><spring:message code='hf.en.message.220'/></button>
										</div>
									</div>

									<!-- searchTbl -->
									<div class="searchTbl">
										<!-- table -->
										<div class="tblWrap">
											<div class="inner" style="height:830px" id="mixInnerM">
												<div class="tbl">
													<div id="mixHeaderM">
														<table>
															<caption>선택항목 Header</caption>
															<thead>
															  <tr>
																<th scope="col" style="width:10%" id="colwidth1M"><input type="checkbox" name="allMixCheckM" id="allMixCheckM" title="allMixCheckM"/></th>
																<th scope="col" style="width:40%" id="colwidth2M"><spring:message code='hf.en.message.105'/></th>
																<th scope="col" style="width:25%" id="colwidth3M"><spring:message code='hf.en.message.106'/></th>
																<th scope="col" style="width:25%" id="colwidth4M"><spring:message code='hf.en.message.155'/></th>
															  </tr>
															</thead>
														</table>
													</div>
													<div id="mixBodyM">
														<table id="mixListTableM" style="table-layout:fixed;">
															<caption>선택항목 Body</caption>
															<colgroup>
																<col style="width:10%" />
																<col style="width:40%" />
																<col style="width:25%" />
																<col style="width:25%" />
															</colgroup>
															<colgroup>
															     <col span="4" />
															</colgroup>
															<thead style="display:none"><tr><th scope="col" colspan="4">선택항목M</th></tr></thead>
															<tfoot><tr><td colspan="4"></td></tr></tfoot>
															<tbody><tr><td colspan="4"></td></tr></tbody>
														</table>
													</div>
												</div>
											</div>	
										</div>	
										<!-- //table -->
									</div>
									<!-- // reportTable -->
								</div>
							</div>
						</div>
						<!-- // leftArea -->
						<!-- rightArea -->
						<div class="rightArea">
							<!-- lSide -->
							<div class="lSide">
															<!-- dvBx -->
								<div class="dvBx">
									<div class="left">
										<div class="moveBtn2">
											<a href="javascript:;" class="btnSt1 btn5" id="itmPlusM1"><spring:message code='hf.en.message.213'/></a>
										</div>
									</div>
									<div class="right">	
										<a href="javascript:;" class="close" id="itmCloseM1">X</a>
									</div>
								</div>
								<!-- // dvBx -->
								<div class="schTit" id="itmTitle" style="margin-top:0px;"><strong><spring:message code='hf.en.message.112'/></strong></div>
								<div class="box" id="itmBox">
									<div class="schBar">
										<div>
											<label for="itmSearchVal"></label>
											<input type="text"  name="itmSearchVal" id="itmSearchVal" value="" placeholder="<spring:message code='hf.en.message.107'/>" title="<spring:message code='hf.en.message.107'/>"/>
										</div>
										<div class="btn">
											<button class="btnSt1 btn2" title='<spring:message code='hf.en.message.108'/>' name='btn_itmInquiry'><spring:message code='hf.en.message.108'/></button>
										</div>
									</div>
									<!-- treeCtrl -->
									<div class="treeCtrl">
										<span class="onoff">
											<span class="tt"><spring:message code='hf.en.message.110'/>/<spring:message code='hf.en.message.111'/></span>
											<button class="on" name="itmAllExpand"></button>
											<button class="off" name="itmAllUnExpand"></button>
										</span>
										<span class="chk">
											<span class="tt"><spring:message code='hf.en.message.114'/>/<spring:message code='hf.en.message.115'/></span>
											<button class="on" name="itmAllChk"></button>
											<button class="off" name="itmAllUnChk"></button>
										</span>
									</div>
									<!-- // treeCtrl -->
									<!-- treeBox -->
									<div class="treeBox size3" id="itmTreeBox">
										<div class="tree">
											<ul id="treeItmData" class="ztree" style="height:259px;overflow-x:auto;"><li></li></ul>
										</div>
									</div>
									<!-- // treeBox -->
								</div>
								<div class="schTit" id="clsTitle"><strong><spring:message code='hf.en.message.113'/></strong></div>
								<div class="box" id="clsBox">
									<div class="schBar">
										<div>
											<label for="clsSearchVal"></label>
											<input type="text" name="clsSearchVal" id="clsSearchVal" value="" placeholder="<spring:message code='hf.en.message.107'/>" title="<spring:message code='hf.en.message.107'/>"/>
										</div>
										<div class="btn">
											<button class="btnSt1 btn2" title='<spring:message code='hf.en.message.108'/>' name='btn_clsInquiry'><spring:message code='hf.en.message.108'/></button>
										</div>
									</div>
									<!-- treeCtrl -->
									<div class="treeCtrl">
										<span class="onoff">
											<span class="tt"><spring:message code='hf.en.message.110'/>/<spring:message code='hf.en.message.111'/></span>
											<button class="on" name="clsAllExpand"></button>
											<button class="off" name="clsAllUnExpand"></button>
										</span>
										<span class="chk">
											<span class="tt"><spring:message code='hf.en.message.114'/>/<spring:message code='hf.en.message.115'/></span>
											<button class="on" name="clsAllChk"></button>
											<button class="off" name="clsAllUnChk"></button>
										</span>
									</div>
									<!-- // treeCtrl -->
									<!-- treeBox -->
									<div class="treeBox size3" id="clsTreeBox">
										<div class="tree">
											<ul id="treeClsData" class="ztree" style="height:259px;overflow-x:auto;"><li></li></ul>
										</div>
									</div>
									<!-- // treeBox -->
								</div>

								<div class="moveBtn">
									<button type="button" class="left" id="itmPlus"></button>
									<button type="button" class="right" id="itmMinus"></button>
								</div>

								<!-- dvBx -->
								<div class="dvBx">
									<div class="left">
										<div class="moveBtn2">
											<a href="javascript:;" class="btnSt1 btn5" id="itmPlusM2"><spring:message code='hf.en.message.213'/></a>
										</div>
									</div>
									<div class="right">	
										<a href="javascript:;" class="close" id="itmCloseM2">X</a>
									</div>
								</div>
								<!-- // dvBx -->
							</div>
							<!-- // lSide -->
							<!-- rSide -->
							<div class="rSide">
								<div class="schTit c336699 align"><strong id='stat_title'></strong></div>
								<div class="box2">
									<!-- div class="dataInfo">
										<div><span id='stat_make'>자료  : 통계표를 선택하세요</span></div>
									</div-->
									<!-- searchCtrl -->
									<form method="post" name="searchForm" id="searchForm" >
									<div class="searchCtrl">
										<div class="ctrl">
										<!-- searchDv -->
										<div class="searchDv type1">
											<div class="dv">
												<p class="tit"><spring:message code='hf.en.message.108'/><br><spring:message code='hf.en.message.116'/></p>
												<div class="cellbox">
													<div class="cell auto">
														<label for="dtacycleCd" class="hide"></label>
														<select name="dtacycleCd" id="dtacycleCd">
															<option value="YY"><spring:message code='hf.en.message.121'/></option>
															<option value="HY"><spring:message code='hf.en.message.214'/></option>
															<option value="QY"><spring:message code='hf.en.message.122'/></option>
															<option value="MM"><spring:message code='hf.en.message.123'/></option>
														</select>
													</div>
													<div class="cell txt1"><spring:message code='hf.en.message.118'/></div>
													<div class="cell" style="width:40%">
														<label for="searchSort" class="hide"></label>
														<select name="searchSort" id="searchSort">
															<option value="A"><spring:message code='hf.en.message.119'/></option>
															<option value="D"><spring:message code='hf.en.message.120'/></option>
														</select>
													</div>
												</div>
											</div>
										</div>

										<div class="searchDv type2">
											<div class="dv">
												<p class="tit"><spring:message code='hf.en.message.108'/><br><spring:message code='hf.en.message.125'/></p>
												<div class="cellbox" id="searchEasyForm">

													<div class="cellrow">
														<div class="cell chk"><label for="wrttimeTypeB"></label><input type="radio" name="wrttimeType" id="wrttimeTypeB" value="B"/></div>
														<div class="cell">
															<input type="hidden" name="wrttimeMinYear" id="wrttimeMinYear" title="wrttimeMinYear"/>
															<input type="hidden" name="wrttimeMaxYear" id="wrttimeMaxYear" title="wrttimeMaxYear"/>
															<input type="hidden" name="wrttimeMinQt" id="wrttimeMinQt" title="wrttimeMinQt"/>
															<input type="hidden" name="wrttimeMaxQt" id="wrttimeMaxQt" title="wrttimeMaxQt"/>
															<div class="line">
																<label for="wrttimeStartYear" class="hide"></label>
																<select name="wrttimeStartYear" id="wrttimeStartYear" style="width:112px">
																	<option value="2017">2017</option>
																</select>
																<label for="wrttimeStartQt" class="hide"></label>
																<select name="wrttimeStartQt" id="wrttimeStartQt" style="width:80px; display: none;">
																</select>
															</div>
															<div class="line">
																<label for="wrttimeEndYear" class="hide"></label>
																<select name="wrttimeEndYear" id="wrttimeEndYear" style="width:112px">
																	<option value="2017">2017</option>
																</select>
																<select name="wrttimeEndQt" id="wrttimeEndQt" style="width:80px; display: none;" title="wrttimeEndQt">
																</select>
															</div>
														</div>
													</div>
													<div class="cellrow">
														<div class="cell chk"><label for="wrttimeTypeL"></label><input type="radio"  name="wrttimeType" id="wrttimeTypeL" value="L" checked/></div>
														<div class="cell">
															<label for="wrttimeLastestVal"></label><input type="text" style="width:112px" id="wrttimeLastestVal" name="wrttimeLastestVal" value="10"/> 
															<span><spring:message code='hf.en.message.128'/></span>
														</div>
													</div>

												</div>
											</div>
											</div>
										</div>
										<!-- // searchDv -->
										<div class="schBtnBx">

											<div class="cellbox">
												<div class="cell alignR">
													<a href="javascript:;" class="btnSt1 btn4" id="addStatTab"><spring:message code='hf.en.message.129'/></a>
												</div>
											</div>
										</div>
										
										<div class="schTit type2">
											<strong><spring:message code='hf.en.message.171'/></strong>
											<div class="right">
												<button class="btnMixDown" type="button" id="mixDown"><img src="<c:url value="/images/soportal/btn_up.png" />" alt="<spring:message code='hf.en.message.216'/>" /></button>
												<button class="btnMixUp" type="button" id="mixUp"><img src="<c:url value="/images/soportal/btn_dn.png" />" alt="<spring:message code='hf.en.message.217'/>" /></button>
												<button type="button" class="btnSt1 btn7 reset" id="mixReset"><spring:message code='hf.en.message.172'/></button>
											</div>
										</div>

										<!-- searchTbl -->
										<div class="searchTbl">
										<!-- table -->
											<div class="tblWrap">
												<div class="inner" style="height:442px" id="mixInner">
													<div class="tbl">
														<div id="mixHeader">
															<table>
																<caption>선택항목 Header</caption>
																<thead>
																  <tr>
																	<th scope="col" style="width:10%" id="colwidth1"><input type="checkbox" name="allMixCheck" id="allMixCheck" title="allMixCheck"/></th>
																	<th scope="col" style="width:40%" id="colwidth2"><spring:message code='hf.en.message.105'/></th>
																	<th scope="col" style="width:25%" id="colwidth3"><spring:message code='hf.en.message.106'/></th>
																	<th scope="col" style="width:25%" id="colwidth4"><spring:message code='hf.en.message.155'/></th>
																  </tr>
																</thead>
															</table>
														</div>
														<div id="mixBody">
															<table id="mixListTable" style="table-layout:fixed;">
																<caption>선택항목 Body</caption>
																<colgroup>
																	<col style="width:10%" />
																	<col style="width:40%" />
																	<col style="width:25%" />
																	<col style="width:25%" />
																</colgroup>
																<colgroup>
																     <col span="4" />
																</colgroup>
																<thead style="display:none"><tr><th scope="col" colspan="4"><spring:message code='hf.en.message.171'/></th></tr></thead>
																<tfoot><tr><td colspan="4"></td></tr></tfoot>
																<tbody><tr><td colspan="4"></td></tr></tbody>
															</table>
														</div>
													</div>
												</div>	
											</div>	
										<!-- //table -->
										</div>
										<!-- // reportTable -->
										
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
							<a href="#none" class="type01" id="confDown" style="display:none;">DownLoad</a>
							<a href="javascript:confirmAction();" class="type01" id="confAction">OK</a>
							<a href="javascript:messageDivClose();" class="type02">CLOSE</a>
						</div>
					</div>

					<button type="button" class="btn-layerpopup-close02">
						<img src="<c:url value="/images/soportal/btn/btn_close02@2x.gif"/>" alt="창닫기" />
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
							<a href="javascript:messageDivClose();" class="type02">OK</a>
						</div>
					</div>

					<button type="button" class="btn-layerpopup-close02">
						<img src="<c:url value="/images/soportal/btn/btn_close02@2x.gif"/>" alt="창닫기" />
					</button>
				</div>
			</div>
			<!-- // ALERT 페이지 -->

			<!-- 파일 변환 로딩 페이지 -->
			<div class="layerpopup-loading-wrapper" id="dataDown-box" style="z-index:12;">
				<div class="bg-opacity-black45"></div>
				<div class="layerpopup-loading-area">
					<img src="<c:url value="/images/soportal/icon/icon_loading.gif"/>" alt="" />
					<span>Converting the file. Please wait.</span>
				</div>
			</div>
			<!-- //파일 변환 로딩 페이지 -->

			<!-- 선택항목 등록 로딩 페이지 -->
			<div class="layerpopup-loading-wrapper" id="itmMix-box" style="z-index:13;">
				<div class="bg-opacity-black45"></div>
				<div class="layerpopup-loading-area">
					<img src="<c:url value="/images/soportal/icon/icon_loading.gif"/>" alt="Loding" />
					<span>Selected item is being registered. Please wait.</span>
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

<%@ include file="/WEB-INF/jsp/nbportal/include/footerEng.jsp" %>
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
<input type="hidden" name="langGb" id="langGb" title="langGb" value="ENG" />
</form>
</body>
</html>	