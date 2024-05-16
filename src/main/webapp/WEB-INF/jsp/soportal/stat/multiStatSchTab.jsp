<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

	<!-- easySheet -->
	<div class="tabArea" id="easySheet" style="clear: both; display: none;">
	
	<div class="easySearch">
		<form name="statsEasy-mst-form" method="post" action="#">
		<input type="hidden" name="firParam" title="firParam"/>
		<input type="hidden" name="deviceType" title="deviceType"/>
		<input type="hidden" name="statblId" title="statblId"/>
		<input type="hidden" name="statId" title="statId"/>
		<input type="hidden" name="statTitle" title="statTitle"/>
		<input type="hidden" name="wrttimeMinYear" value="" title="wrttimeMinYear"/>
		<input type="hidden" name="wrttimeMaxYear" value="" title="wrttimeMaxYear"/>
		<input type="hidden" name="wrttimeMinQt" value="" title="wrttimeMinQt"/>
		<input type="hidden" name="wrttimeMaxQt" value="" title="wrttimeMaxQt"/>
		<input type="hidden" name="chartType" value="" title="chartType"/><!-- 차트 : 선택타입 -->
		<input type="hidden" name="chartStockType" value="HISTORY" title="chartStockType"/><!-- 차트 : HISTORY/SCROLL -->
		<input type="hidden" name="chart23Type" value="2D" title="chart23Type"/><!-- 차트 : 2D/3D -->
		<input type="hidden" name="chartLegend" value="" title="chartLegend"/><!-- 차트 : 범례 -->
		<input type="hidden" name="usrTblSeq" id="usrTblSeq" value="" title="usrTblSeq"/>
		<input type="hidden" name="tabMapVal" value="" title="tabMapVal"/>
		<input type="hidden" name="optST" value="H" title="optST"/>
		<input type="hidden" name="optSI" value="H" title="optSI"/>
		<input type="hidden" name="optSC" value="L" title="optSC"/>
		<input type="hidden" name="statMulti" value="Y" title="statMulti"/>
		<!-- areaDv -->
		<div class="areaDv">
			<!-- areaDetail -->
			<div class="areaDetail">
				<div class="schTit c003399">
					<strong class="sheetTitle">석유류 소비량</strong>
					<div class="right">
						<c:choose>
					    <c:when test="${!empty sessionScope.portalUserCd}">
					    <button class="btnSt1 btn5" type="button" name="btnUsrTbl" title="통계스크랩"><spring:message code='stat.ko.message.164'/></button>
					    </c:when>
					    <c:otherwise>
					    <button class="btnSt1 btn5" type="button" name="btnUsrTblLogin" title="통계스크랩로그인"><spring:message code='stat.ko.message.164'/></button>
					    </c:otherwise>
					    </c:choose>
						<!-- button class="btnSt1 btn6 meta" type="button" name="metaData">메타데이터</button-->
						<!-- <button class="btnSt1 btn8 mHide" type="button" name="easySearch" title="조회"><spring:message code='stat.ko.message.129'/></button> -->
						<button class="btnSt1 btn65 sch wHide" type="button" name="bfOpen" title="선택항목">선택항목</button>
						<button class="btnSt1 btn3 sch wHide" type="button" name="easyClose" title="닫기"><spring:message code='stat.ko.message.192'/></button>
					</div>
				</div>
				<!-- metaData -->
				<div class="metaData">
				</div>
				<!-- // metaData -->
				<div class="viewBx pr">
					<div class="schBtnTglDv">
						<!-- searchBx -->
						<div class="searchBx">
							<div class="cellbox">
								<div class="cell" id="Ncell">
									<span class="set">
										<span class="tt1 wHide"><spring:message code='stat.ko.message.193'/></span>
										<select name="dtacycleCd" id="labelFor01" title="검색구분선택"><option value=""><spring:message code='stat.ko.message.123'/></option></select>
									</span>
									<span class="set">
										<span class="cellbox2">
											<span class="cell2 tt1 wHide"><spring:message code='stat.ko.message.193'/></span>
											<span class="cell2 auto">
												<input type="radio" name="wrttimeType" id="labelFor02" value="B" title="기간검색"/>
												<span class="yearSet">
													<span class="line">
														<select name="wrttimeStartYear" id="labelFor03" title="시작년도선택"></select>
														<select name="wrttimeStartQt" id="labelFor04" style="display: none;" title="시작월(분기)선택"></select>
														<span class="wHide">부터</span>
														<span class="slash mHide" id="labelFor07">~</span>
													</span>
													<span class="line">
														<select name="wrttimeEndYear" id="labelFor08" title="종료년도선택"></select>
														<select name="wrttimeEndQt" id="labelFor05" style="display: none;" title="종료월(분기)선택"></select>
														<span class="wHide">까지</span>
													</span>
												</span>
											</span>
										</span>
									</span>
									<span class="set">
										<span class="tt1 wHide">갯수</span>
										<span>
											<input type="radio" id="labelFor12" name="wrttimeType" value="L" title="최근시점기준"/>
											<input type="text" style="width:40px" id="labelFor13" name="wrttimeLastestVal" value="10" title="개수"/> 
											<span class="tt"><spring:message code='stat.ko.message.128'/></span>
										</span>
									</span>
									<span class="set">
										<span>
											<span class="tt2"><spring:message code='stat.ko.message.118'/></span>
											<select name="wrttimeOrder" id="labelFor14" title="정렬">
												<option value="A"><spring:message code='stat.ko.message.119'/></option>
												<option value="D"><spring:message code='stat.ko.message.120'/></option>
											</select>
										</span>
									</span>
									<span class="set onlysel">
										<span>
											<select name="uiChgVal" id="labelFor15" title="단위선택"></select>
										</span>	
										<span>
											<select name="dmPointVal" id="labelFor16" title="소숫점선택"></select>
										</span>
									</span>
									<span class="set_button">
										<button class="btnSt1 btn8 mHide" type="button" name="easySearch" title="조회"><spring:message code='stat.ko.message.129'/></button>
									</span>
								</div>
								<div class="cell btn-stat right mr0 text-r0">
									<span class="set w4">
										<span><button type="button" class="cell_right_btn" name="callPopDvs" title="증감분석"><spring:message code='stat.ko.message.134'/></button></span>
										<span><button type="button" class="cell_right_btn" name="callPopOpt" title="피벗설정"><spring:message code='stat.ko.message.145'/></button></span>
										
									<!--  select name="dtadvsVal" multiple="multiple" style="font-color: red;"></select-->
									</span>
								</div>
							</div>
							
						</div>
						
						<!-- // searchBx -->
						<div class="searchBtn wHide">
							<button type="button" class="btnSt1 btn4 sch btnbefore_none" name="easySearch" title="조회"><spring:message code='stat.ko.message.129'/></button>
						</div>
					</div>
					<div class="schBtnTgl wHide">
						<button type="button" title="분석기능"><spring:message code='stat.ko.message.154'/></button>
					</div>
					<!-- tabBx -->
					<div class="tabBx">
			
						<!-- 상세페이지용 전체화면 -->		
						<div class="mobile_wide_btn">
							<a href="#">전체화면</a>
							<div class="mdb_shadow"></div>
						</div>
						<!-- //상세페이지용 전체화면 -->
						
						<div class="tabSt with3tab">
							<ul>
								<li class="on"><a href="#sheetTab" title="표">표</a></li>
								<li><a href="#chartTab" title="차트">차트</a></li>
								<li style="display:none"><a href="#mapTab" title="Map">Map</a></li>
							</ul>
							<div class="header_fixed">
								<input type="checkbox" id="chkFrozenCol" checked="checked">
								<label for="chkFrozenCol"> 좌측헤더고정</label>
							</div>
						</div>
						<div class="tabCont sheetTab">
							<!-- sheet -->
							<div class="sheetarea">
								<div class="toparea">
									<div class="cellbox">
										<!-- <div class="cell"><p class="txt" name="">칼럼명을 클릭하면 데이터 정렬이 가능합니다. <span>( ▲오름차순   ▼내림차순 )</span></p></div> -->
										<div class="cell">
											<p class="txt pivot_icon">
												<span class="rpstuiNm"></span>
												<img src="<c:url value="/images/soportal/ico_pivot_2.png" />" title="기본보기" alt="<spring:message code='stat.ko.message.145'/>" class="pivotLocImg">
												<img src="<c:url value="/images/soportal/ico_pivot_4.png" />" title="세로보기" alt="<spring:message code='stat.ko.message.145'/>" class="pivotLocImg">
												<img src="<c:url value="/images/soportal/ico_pivot_3.png" />" title="년월보기" alt="<spring:message code='stat.ko.message.145'/>" class="pivotLocImg">
											</p>
										</div>
										<div class="cell">
											<div class="fileChange">
												<%-- <span class="tt"><spring:message code='stat.ko.message.169'/></span> --%>
												<!-- <span class="tt"><button type="button" name="btnFrozenCol" title="열고정">열고정</button></span> -->
												<span class="btns">
													<button type="button" name="downXLS" title="XLS">XLS</button>
													<!-- <button type="button" name="downCSV" title="CSV">CSV</button>
													<button type="button" name="downJSON" title="JSON">JSON</button>
													<button type="button" name="downXML" title="XML">XML</button>
													<button type="button" name="downTXT" title="TXT">TXT</button> -->
													<!-- <button type="button" name="downHWP" title="HWP">HWP</button> -->
												</span>
											</div>
										</div>
									</div>
								</div>
								
								<div class="ibsheet_area" style="clear: both; overflow:auto;">
										<div class="grid statEasySheet" style="height:600px"></div>
								</div>

							</div>
							<!-- // sheet -->
								
						</div>
						<div class="tabCont chartTab" style="display:none">
							<!-- chartarea -->
							<div class="chartarea">
								<div class="toparea">
									<div class="chartMenu">
										<select name="chartCategories" class="chartSel" title="차트선택"><option>선택</option></select>
										<button type="button" name="remarkShow" title="범례숨기기"><img src="<c:url value="/images/soportal/chart/charbtn01on.png" />" alt="범례숨기기"/></button>										
										<!-- button type="button" name="chartStockType" title="차트스톡" class="m1000none"><img src="<c:url value="/images/soportal/chart/charbtn02_on.png" />" alt="차트스톡"/></button-->										
										<button type="button" name="chartBasic" title="기본차트"><img src="<c:url value="/images/soportal/chart/charbtn19on.png" />" alt="기본차트"/></button>		
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
										<button type="button" name="chartDownload" title="차트다운로드"><img src="<c:url value="/images/soportal/chart/charbtn18.png" />" alt="차트다운로드"/></button>
										  <div class="dropdown-content">
										    <ul>
										    	<li><a href="#png" name="chartPng" title="PNG"><span>PNG</span> <spring:message code='stat.ko.message.197'/></a></li>
											    <li><a href="#jpeg" name="chartJpeg" title="JPEG"><span>JPEG</span> <spring:message code='stat.ko.message.197'/></a></li>
											    <li><a href="#pdf" name="chartPdf" title="PDF"><span>PDF</span> <spring:message code='stat.ko.message.197'/></a></li>
											    <li><a href="#svg" name="chartSvg" title="SVG"><span>SVG</span> <spring:message code='stat.ko.message.197'/></a></li>
										    </ul>
										  </div>

									</div>
								</div>
								<div class="chartDv">
									<div class="chart statEasyChart"></div>
								</div>
								<div style="height: 100px; overflow: hidden">
									<div class="statSlider"></div>
								</div>
							</div>
							<!-- /// chartarea -->
						</div>
						<div class="tabCont mapTab" style="display:none">
							<!-- maparea -->
							<div class="maparea">
								<div class="toparea">
								</div>
								<div class="mapDv">
									<div class="mapMenu">
										<select name="mapCategories" class="chartSel" title="map선택"><option value="">선택</option></select>
										<select name="mapItms" class="chartSel" title="map항목선택" ><option value="">선택</option></select>
									</div>								
									<div class="map statEasyMap"></div>
								</div>
							</div>
							<!-- /// maparea -->
						</div>
					</div>
					<!-- // tabBx -->
				</div>
				<!-- // viewBx -->
				<div class="remarkDv" style="z-index:2;">
					<div class="remark">
						<!-- 
						<p class="txt3">
							<strong>주 : </strong>
							<span class="cmmt"></span>
						</p> -->
						<span class="cmmt"></span>
					</div>
					<button class="btn" type="button" title="주석"></button>
				</div>
			</div>
			<!-- // areaDetail -->
		</div>
		<!-- // areaDv -->

		<!-- layerPop : optPop  -->
		<div class="layerPopup optPop" style="display: none; z-index:10;">
			<div class="popArea" style="width:190px;">
				<a href="javascript:;" class="close" name="optPopClose" title="닫기">X</a>
				<div class="popHeader">
					<p class="tit"><spring:message code='stat.ko.message.145'/></p>
				</div>
				<div class="popConts">
					<!-- pivotSet -->
					<div class="pivotSet">
						<ul class="list1 viewLocOpt-sect">
							<li>
								<div>
									<span><input type="radio" name="viewLocOpt" value="H" title="기본보기" checked><span class="tag"><spring:message code='stat.ko.message.146'/></span></span>
									<i><img src="<c:url value="/images/soportal/ico_pivot_2.png" />" alt="ico_pivot_1"></i>
								</div>
							</li>
							<li>
								<div>
									<span><input type="radio" name="viewLocOpt" value="V" title="세로보기"><span class="tag"><spring:message code='stat.ko.message.148'/></span></span>
									<i><img src="<c:url value="/images/soportal/ico_pivot_4.png" />" alt="ico_pivot_4"></i>
								</div>
							</li>
							<li>
								<div>
									<span><input type="radio" name="viewLocOpt" value="T" title="년월보기"><span class="tag"><spring:message code='stat.ko.message.149'/></span></span>
									<i><img src="<c:url value="/images/soportal/ico_pivot_3.png" />" alt="ico_pivot_3"></i>
								</div>
							</li>
						</ul>
					</div>
					<!-- // pivotSet -->
	
					<div class="btnBox">
						<a href="javascript:;" class="btnSt2 btn1" name="optRefresh" title="적용"><spring:message code='stat.ko.message.132'/></a>
						<a href="javascript:;" class="btnSt2 btn2" name="optClose" title="닫기"><spring:message code='stat.ko.message.133'/></a>
					</div>
				</div>
			</div>
	
		</div>	
		<!-- // layerPop : optPop -->
		
		<!-- layerPop : dvsPop  -->
		<div class="layerPopup dvsPop" style="display: none; z-index:10;">
			<div class="popArea" style="width:290px;">
				<a href="javascript:;" class="close" name="dvsPopClose" title="닫기">X</a>
				<div class="popHeader">
					<p class="tit"><spring:message code='stat.ko.message.134'/></p>
				</div>
				<div class="popConts">
					<div class="PeasySearch">
						<div class="PschBar">
							<div>
								<input type="text" name="tabDvsKeyword" title="검색어입력">
							</div>
							<div class="btn">
								<button type="button" class="btnSt1 btn2" name="tabDvsSearch" title="검색"><spring:message code='stat.ko.message.108'/></button>
							</div>
						</div>
						<!-- treeCtrl -->
						<div class="PtreeCtrl">
							<span class="chk">
								<span class="tt"><spring:message code='stat.ko.message.114'/>/<spring:message code='stat.ko.message.115'/></span>
								<button type="button" class="on" name="tabDvsAllChk" title="선택"></button>
								<button type="button" class="off" name="tabDvsAllUnChk" title="해제"></button>
							</span>
						</div>
						<!-- // treeCtrl -->
						<!-- treeBox -->
						<div class="PtreeBox size3">
							<div class="tree dvsZtree">
								<ul id="treeDvsDataTab" class="ztree" style="height:225px;"><li></li></ul>
							</div>
						</div>
						<!-- // treeBox -->
					</div>
	
					<div class="btnBox">
						<a href="javascript:;" class="btnSt2 btn1" name="dvsApply" title="적용"><spring:message code='stat.ko.message.132'/></a>
						<a href="javascript:;" class="btnSt2 btn2" name="dvsClose" title="닫기"><spring:message code='stat.ko.message.133'/></a>
					</div>
				</div>
			</div>
	
		</div>
		<!-- // layerPop : dvsPop -->
		
		<!-- layerPop : usrTblPop -->
		<div class="layerPopup usrTblPop" style="display: none; z-index:10;">
			<div class="popArea" style="width:400px;">
				<a href="javascript:;" class="close" name="usrTblPopClose" title="닫기">X</a>
				<div class="popHeader">
					<p class="tit"><spring:message code='stat.ko.message.164'/></p>
				</div>
				<div class="popConts">
					<div class="popBody">
						<div class="dataList">
							<ul>
								<li>
									<strong>통계명</strong>
									<span><input type="text" name="usrTblStatblNm" title="통계명"/></span>
								</li>
							</ul>
							<ul>
								<li>
									<strong>설명</strong>
									<span><input type="text" name="usrTblStatblExp" title="설명"/></span>
								</li>
							</ul>
						</div>
						<p class="txtSt1 arrOrg">
							<input type="radio" name="callTag" checked="checked" value="F" title="callTag"/>
							조회시점으로 최신 데이터 저장  <span class="bxOrg">최신 데이터</span> <br />
							※ 올해 <span class="cRed">5월</span>로 저장하고 <span class="cBlue">12월에 조회하면 12월</span> 데이터를 조회
						</p>
						<p class="txtSt1">
							<input type="radio" name="callTag" value="B" title="callTag"/>
							현재 설정된 조회기간을 기준으로 데이터 저장  <span class="bxBlue">기준데이터</span><br />
							※ 올해 <span class="cRed">5월</span>로 저장하고 <span class="cBlue">12월에 조회하면 5월</span> 데이터를 조회
						</p>
						<br />
					</div>
	
					<div class="btnBox">
						<a href="javascript:;" name="usrTblApply" class="btnSt2 btn1" title="신규저장">신규저장</a>
						<a href="javascript:;" name="usrTblUpd" class="btnSt2 btn1" style="display: none;" title="수정">수정</a>
						<a href="javascript:;" name="usrTblClose" class="btnSt2 btn2" title="닫기">닫기</a>
					</div>
				</div>
			</div>
	
		</div>
		<!-- // layerPop : usrTblPop -->
	</form>
	</div>
	</div>
	<!-- // easySheet -->