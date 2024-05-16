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
		<input type="hidden" name="usrTblSeq" id="usrTblSeq" value="" title="usrTblSeq"/>
		<input type="hidden" name="chartType" value="" title="chartType"/>
		<input type="hidden" name="chartLegend" value="" title="chartLegend"/>
		<input type="hidden" name="optST" value="H" title="optST"/>
		<input type="hidden" name="optSI" value="H" title="optSI"/>
		<input type="hidden" name="optSC" value="L" title="optSC"/>
		<input type="hidden" name="statMulti" value="Y" title="statMulti"/>
		<input type="hidden" name="langGb" value="ENG" title="langGb"/>
		<!-- areaDv -->
		<div class="areaDv">
			<!-- areaDetail -->
			<div class="areaDetail">
				<div class="schTit c003399">
					<strong class="sheetTitle"></strong>
					<div class="right">
						<!-- button class="btnSt1 btn6 meta" type="button" name="metaData">메타데이터</button-->
						<button class="btnSt1 btn8 mHide" type="button" name="easySearch"><spring:message code='hf.en.message.129'/></button>
						<button class="btnSt1 btn3 sch wHide" type="button" name="easyEngClose"><spring:message code='hf.en.message.192'/></button>
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
										<span class="tt1 wHide"><spring:message code='hf.en.message.193'/></span>
										<label for="labelFor01" class="hide"></label>
										<select name="dtacycleCd" id="labelFor01"><option value=""><spring:message code='hf.en.message.123'/></option></select>
									</span>
									<span class="set">
										<span class="cellbox2">
											<span class="cell2 tt1 wHide"><spring:message code='hf.en.message.193'/></span>
											<span class="cell2 auto">
												<label for="labelFor02" class="hide"></label>
												<input type="radio" name="wrttimeType" id="labelFor02" value="B" />
												<span class="yearSet">
													<span class="line">
														<label for="labelFor03" class="hide"></label>
														<select name="wrttimeStartYear" id="labelFor03" title="<spring:message code='hf.en.message.114'/>"></select>
														<label for="labelFor04" class="hide"></label>
														<select name="wrttimeStartQt" id="labelFor04" style="display: none;"></select>
														<span class="slash mHide" id="labelFor07">~</span>
													</span>
													<span class="line">
														<label for="labelFor08" class="hide"></label>
														<select name="wrttimeEndYear" id="labelFor08"></select>
														<label for="labelFor05" class="hide"></label>
														<select name="wrttimeEndQt" id="labelFor05" style="display: none;"></select>
													</span>
												</span>
											</span>
										</span>
									</span>
									<span class="set">
										<span class="tt1 wHide">Amount</span>
										<span>
											<label for="labelFor12" class="hide"></label>
											<input type="radio" id="labelFor12" name="wrttimeType" value="L" />
											<label for="labelFor13" class="hide"></label>
											<input type="text" style="width:40px" id="labelFor13" name="wrttimeLastestVal" value="10"/> 
											<span class="tt"><spring:message code='hf.en.message.128'/></span>
										</span>
									</span>
									<span class="set">
										<span>
											<span class="tt2"><spring:message code='hf.en.message.118'/></span>
											<label for="labelFor14" class="hide"></label>
											<select name="wrttimeOrder" id="labelFor14">
												<option value="A"><spring:message code='hf.en.message.119'/></option>
												<option value="D"><spring:message code='hf.en.message.120'/></option>
											</select>
										</span>
									</span>
								</div>
								<div class="cell btn-stat right mr0 text-r0">
									<span class="set w4">
										<span><button name="callPopDvs" type="button"><spring:message code='hf.en.message.134'/></button></span>
										<span><button name="callPopOpt" type="button"><spring:message code='hf.en.message.145'/></button></span>
										
									<!--  select name="dtadvsVal" multiple="multiple" style="font-color: red;"></select-->
									</span>
									<span class="set w2">
										<span>
											<label for="labelFor15" class="hide"></label>
											<select name="uiChgVal" id="labelFor15" ></select>
										</span>	
										<span>
											<label for="labelFor16" class="hide"></label>
											<select name="dmPointVal" id="labelFor16"></select>
										</span>
									</span>
								</div>
							</div>
							
						</div>
						
						<!-- // searchBx -->
						<div class="searchBtn wHide">
							<button type="button" class="btnSt1 btn4 sch btnbefore_none" name="easySearch"><spring:message code='hf.en.message.129'/></button>
						</div>
					</div>
					<div class="schBtnTgl wHide">
						<button type="button"><spring:message code='hf.en.message.154'/></button>
					</div>
					<!-- tabBx -->
					<div class="tabBx">
						<div class="tabSt">
							<ul>
								<li class="on"><a href="#sheetTab">Sheet</a></li>
								<li><a href="#chartTab">Chart</a></li>
							</ul>
						</div>
						<div class="tabCont sheetTab">
							<!-- sheet -->
							<div class="sheetarea">
								<div class="toparea">
									<div class="cellbox">
										<!-- <div class="cell"><p class="txt" name="">칼럼명을 클릭하면 데이터 정렬이 가능합니다. <span>( ▲오름차순   ▼내림차순 )</span></p></div> -->
										<div class="cell"><p class="txt"><img src="<c:url value="/images/soportal/ico_pivot_1.png" />" alt="<spring:message code='hf.en.message.145'/>" class="pivotLocImg"><span class="rpstuiNm"></span></p></div>
										<div class="cell">
											<div class="fileChange">
												<span class="tt"><spring:message code='hf.en.message.169'/></span>
												<span class="btns">
													<button type="button" name="downXLS">XLS</button>
													<button type="button" name="downCSV">CSV</button>
													<button type="button" name="downJSON">JSON</button>
													<button type="button" name="downXML">XML</button>
													<button type="button" name="downTXT">TXT</button>
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
										<button type="button" name="remarkShow"><img src="<c:url value="/images/soportal/btn_chart1.png" />" title="범례숨기기" alt="범례숨기기"/></button>
										<button type="button" name="chartSpline"><img src="<c:url value="/images/soportal/btn_chart2.png" />" title="곡선" alt="곡선"/></button>
										<button type="button" name="chartArea"><img src="<c:url value="/images/soportal/btn_chart3.png" />" title="누적영역" alt="누적영역"/></button>
										<button type="button" name="chartHbar"><img src="<c:url value="/images/soportal/btn_chart4.png" />" title="막대형" alt="막대형"/></button>
										<button type="button" name="chartAccHbar"><img src="<c:url value="/images/soportal/btn_chart5.png" />" title="누적막대형" alt="누적막대형"/></button>
										<button type="button" name="chartWbar"><img src="<c:url value="/images/soportal/btn_chart6.png" />" title="가로막대형" alt="가로막대형"/></button>
										<button type="button" name="chartAccWbar"><img src="<c:url value="/images/soportal/btn_chart7.png" />" title="가로누적막대형" alt="가로누적막대형"/></button>
										<label for="labelFor17" class="hide"></label>
										<select name="chartChange" id="labelFor17">
											<option value="">3D <spring:message code='hf.en.message.196'/> <spring:message code='hf.en.message.198'/></option>
											<option value="3hcolumn">3D <spring:message code='hf.en.message.203'/></option>
											<option value="3acolumn">3D <spring:message code='hf.en.message.204'/></option>
											<option value="3hbar">3D <spring:message code='hf.en.message.205'/></option>
											<option value="3abar">3D <spring:message code='hf.en.message.206'/></option>
											<!-- option value="pie"> <spring:message code='hf.en.message.207'/></option-->
											
										</select>
										<button type="button" name="chartDownload"><img src="<c:url value="/images/soportal/btn_chart_file.png" />" title="차트다운로드"  alt="차트다운로드" /></button>
										  <div class="dropdown-content">
										    <ul>
										    	<li><a href="#png" name="chartPng"><span>PNG</span> <spring:message code='hf.en.message.197'/></a></li>
											    <li><a href="#jpeg" name="chartJpeg"><span>JPEG</span> <spring:message code='hf.en.message.197'/></a></li>
											    <li><a href="#pdf" name="chartPdf"><span>PDF</span> <spring:message code='hf.en.message.197'/></a></li>
											    <li><a href="#svg" name="chartSvg"><span>SVG</span> <spring:message code='hf.en.message.197'/></a></li>
										    </ul>
										  </div>
									</div>
								</div>
								<div class="chartDv">
									<div class="chart statEasyChart"></div>
								</div>
							</div>
							<!-- /// chartarea -->
						</div>
					</div>
					<!-- // tabBx -->
				</div>
				<!-- // viewBx -->
				<div class="remarkDv" style="z-index:2;">
					<div class="remark">
						<!-- p class="txt1">1.1. 주요 통화금융지표</p>
						<p class="txt2"><strong>통계담당 :</strong> 경제통계국</p-->
						<p class="txt3">
							<strong>comment : </strong>
							<span class="cmmt"></span>
						</p>
					</div>
					<button class="btn" type="button"></button>
				</div>
			</div>
			<!-- // areaDetail -->
		</div>
		<!-- // areaDv -->

		<!-- layerPop : optPop  -->
		<div class="layerPopup optPop" style="display: none; z-index:3;">
			<div class="popArea" style="width:190px;">
				<a href="javascript:;" class="close" name="optPopClose">X</a>
				<div class="popHeader">
					<p class="tit"><spring:message code='hf.en.message.145'/></p>
				</div>
				<div class="popConts">
					<!-- pivotSet -->
					<div class="pivotSet">
						<ul class="list1 viewLocOpt-sect" >
							<li>
								<div>
									<label><input type="radio" name="viewLocOpt" value="H" checked><span class="tag" for="viewLocOpt-sect-1"><spring:message code='hf.en.message.146'/></span></label>
									<i><img src="<c:url value="/images/soportal/ico_pivot_2.png" />" alt="ico_pivot_1"></i>
								</div>
							</li>
							<li>
								<div>
									<label><input type="radio" name="viewLocOpt" value="V"><span class="tag" for="viewLocOpt-sect-2"><spring:message code='hf.en.message.148'/></span></label>
									<i><img src="<c:url value="/images/soportal/ico_pivot_4.png" />" alt="ico_pivot_4"></i>
								</div>
							</li>
							<li>
								<div>
									<label><input type="radio" name="viewLocOpt" value="T"><span class="tag" for="viewLocOpt-sect-3"><spring:message code='hf.en.message.149'/></span></label>
									<i><img src="<c:url value="/images/soportal/ico_pivot_3.png" />" alt="ico_pivot_3"></i>
								</div>
							</li>
						</ul>
					</div>
					<!-- // pivotSet -->
	
					<div class="btnBox">
						<a href="javascript:;" class="btnSt2 btn1" name="optRefresh"><spring:message code='hf.en.message.132'/></a>
						<a href="javascript:;" class="btnSt2 btn2" name="optClose"><spring:message code='hf.en.message.133'/></a>
					</div>
				</div>
			</div>
	
		</div>	
		<!-- // layerPop : optPop -->
		
		<!-- layerPop : dvsPop  -->
		<div class="layerPopup dvsPop" style="display: none; z-index:4;">
			<div class="popArea" style="width:290px;">
				<a href="javascript:;" class="close" name="dvsPopClose">X</a>
				<div class="popHeader">
					<p class="tit"><spring:message code='hf.en.message.134'/></p>
				</div>
				<div class="popConts">
					<div class="PeasySearch">
						<div class="PschBar">
							<div>
								<input type="text" name="tabDvsKeyword" title="tabDvsKeyword">
							</div>
							<div class="btn">
								<button type="button" class="btnSt1 btn2" name="tabDvsSearch"><spring:message code='hf.en.message.108'/></button>
							</div>
						</div>
						<!-- treeCtrl -->
						<div class="PtreeCtrl">
							<span class="chk">
								<span class="tt"><spring:message code='hf.en.message.114'/>/<spring:message code='hf.en.message.115'/></span>
								<button type="button" class="on" name="tabDvsAllChk"></button>
								<button type="button" class="off" name="tabDvsAllUnChk"></button>
							</span>
						</div>
						<!-- // treeCtrl -->
						<!-- treeBox -->
						<div class="PtreeBox size3">
							<div class="tree" name="dvsZtree">
								<ul id="treeDvsDataTab" class="ztree" style="height:225px;"><li></li></ul>
							</div>
						</div>
						<!-- // treeBox -->
					</div>
	
					<div class="btnBox">
						<a href="javascript:;" class="btnSt2 btn1" name="dvsApply"><spring:message code='hf.en.message.132'/></a>
						<a href="javascript:;" class="btnSt2 btn2" name="dvsClose"><spring:message code='hf.en.message.133'/></a>
					</div>
				</div>
			</div>
	
		</div>
		<!-- // layerPop : dvsPop -->
		
		<!-- layerPop : usrTblPop -->
		<div class="layerPopup usrTblPop" style="display: none; z-index:5;">
			<div class="popArea" style="width:400px;">
				<a href="javascript:;" class="close" name="usrTblPopClose">X</a>
				<div class="popHeader">
					<p class="tit"><spring:message code='hf.en.message.164'/></p>
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
						<a href="javascript:;" name="usrTblApply" class="btnSt2 btn1">신규저장</a>
						<a href="javascript:;" name="usrTblUpd" class="btnSt2 btn1" style="display: none;">수정</a>
						<a href="javascript:;" name="usrTblClose" class="btnSt2 btn2">닫기</a>
					</div>
				</div>
			</div>
	
		</div>
		<!-- // layerPop : usrTblPop -->
	</form>
	</div>
	</div>
	<!-- // easySheet -->