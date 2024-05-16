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
<!-- 간편통계용  js추가  -->
<script type="text/javascript" src="<c:url value="/js/soportal/stat/easyStatEngSch.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/soportal/stat/easyStatSchSearch.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/soportal/stat/easyStatSchTree.js" />"></script>

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
	<!-- 
	<div class="header">
		<img src="/images/soportal/@header.png" width="980" height="130" alt="상단" />
	</div> -->
<!-- layout_A -->
<div class="layout_A">
<%@ include file="/WEB-INF/jsp/nbportal/include/headerEng.jsp" %>
<%@ include file="/WEB-INF/jsp/nbportal/include/navigationEng.jsp" %>

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
			<div class="wrap_layout_flex fix_page">
			<div class="layout_easySearch layout_flex_100">
			<%-- <%@ include file="/WEB-INF/jsp/nbportal/include/gnb.jsp" %> --%>

			<!-- easySearchArea -->
			<div class="easySearchArea" id="tabs">
				<div class="fullSize"><button><spring:message code='hf.en.message.130'/></button></div>

				<!-- searchTab -->
				<div class="searchTab" id="searchTab">
					<ul class="tabTitle" id="statTabArea">
						<li class="all"><a href="javascript:;" id="tab_title"><span><spring:message code='hf.en.message.101'/></span></a></li>
					</ul>
				</div>
				<!-- // searchTab -->
				<c:import  url="easyStatEngSchTab.jsp"/>

				<!-- easySearch -->
				<div class="tabArea" id="tabs-1">
				<div class="easySearch">
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
								<!--  div class="schBar schSubject wHide">
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
										<button type="button" class="on" name="statAllExpand" title="on"></button>
										<button type="button" class="off" name="statAllUnExpand" title="off"></button>
									</span>
								</div>
								<!-- // treeCtrl -->
								<!-- keyword -->
								<div class="keyword" style="display: none;">
									<label for="hdnKeywordVal" class="hide"></label>
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
									<button class="close" id="searchResultClose" title="close"></button>
									<p class="title"><spring:message code='hf.en.message.212'/></p>
									<ul></ul>
								</div>
					
							</div>
						</div>
						<!-- // leftArea -->
						<!-- rightArea -->
						<div class="rightArea">
							<!-- lSide -->
							<div class="lSide">
								<div class="schTit" id="itmTitle"><strong><spring:message code='hf.en.message.112'/></strong></div>
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
											<button class="on" name="itmAllExpand" title="on"></button>
											<button class="off" name="itmAllUnExpand" title="off"></button>
										</span>
										<span class="chk">
											<span class="tt"><spring:message code='hf.en.message.114'/>/<spring:message code='hf.en.message.115'/></span>
											<button class="on" name="itmAllChk" title="on"></button>
											<button class="off" name="itmAllUnChk" title="off"></button>
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
											<button class="on" name="clsAllExpand" title="on"></button>
											<button class="off" name="clsAllUnExpand" title="off"></button>
										</span>
										<span class="chk">
											<span class="tt"><spring:message code='hf.en.message.114'/>/<spring:message code='hf.en.message.115'/></span>
											<button class="on" name="clsAllChk" title="on"></button>
											<button class="off" name="clsAllUnChk" title="off"></button>
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
												<p class="tit"><spring:message code='hf.en.message.108'/><br><spring:message code='hf.en.message.116'/></p>
												<div class="cellbox">
													<div class="cell auto">
														<label for="dtacycleCd" class="hide"></label>
														<select name="dtacycleCd" id="dtacycleCd" title="dtacycleCd">
															<option value=""><spring:message code='hf.en.message.117'/></option>
														</select>
													</div>
													<div class="cell txt1"><spring:message code='hf.en.message.118'/></div>
													<div class="cell" style="width:40%">
														<label for="searchSort" class="hide"></label>
														<select name="searchSort" id="searchSort" title="searchSort">
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
														<div class="cell chk"><label for="wrttimeTypeB"></label><input type="radio" name="wrttimeType" id="wrttimeTypeB" value="B" /></div>
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
										<div class="bg"></div>
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

					<button type="button" class="btn-layerpopup-close02" title="close">
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

					<button type="button" class="btn-layerpopup-close02" title="close">
						<img src="<c:url value="/images/soportal/btn/btn_close02@2x.gif"/>" alt="창닫기" />
					</button>
				</div>
			</div>
			<!-- // ALERT 페이지 -->

			<!-- 파일 변환 로딩 페이지 -->
			<div class="layerpopup-loading-wrapper" id="dataDown-box" style="z-index:12;">
				<div class="bg-opacity-black45"></div>
				<div class="layerpopup-loading-area">
					<img src="<c:url value="/images/soportal/icon/icon_loading.gif"/>" alt="Loding" />
					<span>Converting the file. Please wait.</span>
				</div>
			</div>
			<!-- //파일 변환 로딩 페이지 -->
			
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

	<c:import url="/WEB-INF/jsp/inc/iframepopup.jsp"/>

<form method="post" name="commonForm" id="commonForm" >
<input type="hidden" name="page" title="page" value="<c:out value="${param.page}" default="1" />" />
<input type="hidden" name="rows" title="rows" value="<c:out value="${param.rows}" default="10" />" />
<input type="hidden" name="statblId" id="sId" title="statblId" value="${statblId }" />
<input type="hidden" name="searchVal" title="searchVal" id="searchVal" />
<input type="hidden" name="searchGb" title="searchGb" id="searchGb" />
<input type="hidden" name="firParam" id="firParam" title="firParam" value="${firParam }" />
<input type="hidden" name="isFirst" id="searchType" title="searchType" value="${searchType }" />
<input type="hidden" name="langGb" id="langGb" title="langGb" value="ENG" />
</form>

</body>
</html>