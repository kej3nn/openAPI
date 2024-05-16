/**
 * 챠트화면 호출 적용
 * 
 * @param treeId
 * @param inputNm
 */
// //////////////////////////////////////////////////////////////////////////////
// 글로벌 변수
// //////////////////////////////////////////////////////////////////////////////
var hightChart = "";
var hightMap = "";
var isChartMobile = $(window).width() <= 980 ? true : false; // 모바일 접근 여부
var chartData = "";		//차트 데이터
var chartTgData = "";	//차트 항목 및 분류 정보
//var chartSaData = "";	//차트 항목 및 분류 중 > 합계및평균여부 Y가 아닌 데이터
var chartWrData = "";  //차트 데이터 시계열 정보
var directDivid = "";
var dtacycleCd = "";
var chartTypes = "";
var chartSid = "";
var chartCallMark = "T";
var chartClsDataYn = "N";
var yAxisData = new Array(); 
var valSeries = new Array();
var drillDown = new Array();
var chartItmData = new Array();
var chartClsData = new Array();
var chartGrpData = new Array();

var chartWrClsData = new Array();
var chartWrOneData = new Array();
var chartOneData = "";		//시계열 한개(컬럼), pie, donut, treemap, spiderweb, sunburst 의 경우..
var chartSaOneDAta = ""; //시계열 콤보에 따라서 데이터를 재호출한다.(재호출 데이터를 담기위한 변수 선언) 
var spiderwebCate = new Array();
var seriesVisible = {};

//Slider용 전역변수 선언
var minYear;
var maxYear;
var stepVal = 1;
var seriesSliderData = new Array();
var valSlider = new Array();
var sliderId = "";

function loadChart() {
	//글로벌 변수 초기화
	resetGlobal();	
	
	var objTab = getTabShowObj();// 탭이 open된 객체가져옴
	var formObj = objTab.find("form[name=statsEasy-mst-form]");
	chartSid = formObj.find("input[name=statblId]").val();
	var params = "displayType=T&selCategories=&"+formObj.serialize();
	
	var statMulti = formObj.find("input[name=statMulti]").val();
	if(statMulti == "Y"){//복수통계
		
		var sheetNm = formObj.find($(".grid.statEasySheet")).attr('id');
		sheetNm = sheetNm.replace("DIV_", "");
		params += "&multiStatType="+MULTI_STAT_TYPE+"&"+MAP_SELECT_ITEM[sheetNm]
	}

	doAjax({
		url : "/portal/stat/statChartItm.do",
		params : params,
		before : function() {
			showLoading();
		},
		callback : afterStatsChart
	});
}

// 차트용 데이터 호출 후 화면 처리함수
function afterStatsChart(res) {

	var data = res.data;
	var objTab = getTabShowObj();// 탭이 open된 객체가져옴
	var formObj = objTab.find("form[name=statsEasy-mst-form]");
	var statMulti = formObj.find("input[name=statMulti]").val();

	// 전역변수에 담아놓는다. 차트 종류 선택 시 가공을 위해..
	chartTgData = data.CHART_ITM;
	chartWrData = data.CHART_WRT;
	chartWrOneData = data.ONE_WRT;
	chartData = data.CHART_DATA;
	
	//시계열 한개(컬럼), pie, donut, treemap, spiderweb, sunburst 의 경우..
	//시계열 콤보에 따라서 데이터를 재호출한다.
	//chartOneData = data.CHART_DATA;
	//chartSaOneData = data.CHART_ITMSA;
	
	if(statMulti == "Y"){//복수통계
		chartCallMark = "M";
		dtacycleCd = formObj.find("select[name=dtacycleCd] option:selected").val();
	}else{
		$.each(data.OPT_DATA, function(key, value){
			if(value.optCd == "DC") dtacycleCd = value.optVal;
		});
	}

	dtacycleCd = formObj.find("select[name=dtacycleCd] option:selected").val();
	var chartType = formObj.find("input[name=chartType]").val();
	var chartDivId = formObj.find($(".chart.statEasyChart")).attr('id');
	sliderId = formObj.find($(".statSlider")).attr('id');
	
	// 차트를 생성한다.
	statChartCreate(chartType, chartDivId);
	
}


//[통계조회] 호출 함수
function directStatChart(sId, divId) {
	//글로벌 변수 초기화
	resetGlobal();
	
	var formObj = $('form[name="statsEasy-mst-form"]');
	//버튼 초기화
	formObj.find($(".chartMenu")).find("button").each(function(event){
		var imgSrc = $(this).children("img").attr("src");
		if (imgSrc.indexOf("on.png") != -1 && imgSrc.indexOf("01") == -1) {
			$(this).children("img").attr("src", imgSrc.replace("on", ""));
		}
	});
	
	//chartButtonReset("charbtn01");
	
	chartSid = sId;
	//var param = {statblId : sId, displayType : "S", selCategories : ""};
	var params = "displayType=S&selCategories=&"+formObj.serialize();
	
	//통계조회 적용 차트 ID를 전역변수에 담는다.
	directDivid = divId;
	
	//통계조회에 대한 구분 처리
	doAjax({
		url : "/portal/stat/statChartItm.do",
		params : params,
		callback : afterDirectStatChart
	});
}

//[통계조회] 차트용 데이터 호출 후 화면 처리함수
function afterDirectStatChart(res) {
	var data = res.data;

	// 전역변수에 담아놓는다. 차트 종류 선택 시 가공을 위해..
	chartTgData = data.CHART_ITM;
	chartWrData = data.CHART_WRT;
	chartWrOneData = data.ONE_WRT;
	chartData = data.CHART_DATA;
	
	//시계열 한개(컬럼), pie, donut, treemap, spiderweb, sunburst 의 경우..
	//시계열 콤보에 따라서 데이터를 재호출한다.
	chartOneData = data.CHART_DATA;
	chartSaOneData = data.CHART_ITMSA;
	
	$.each(data.OPT_DATA, function(key, value){
		if(value.optCd == "DC") dtacycleCd = value.optVal;
		if(value.optCd == "TC") chartTC = value.optVal;
		if(value.optCd == "TH") chartTH = value.optVal;
	});
	chartCallMark = "S";
	var chartType = $('form[name="statsEasy-mst-form"]').find("input[name=chartType]").val();
	// 차트를 생성한다.

	statChartCreate(chartType, directDivid);
}

//차트를 생성한다.
function statChartCreate(ctype, chartDivId){
	
	var chartLoad = new StatCharts(); //차트 JS함수 정의 statCharts.js

	//data를 확인하여 검증기준(CHG_UI_NM)의 건수 정보 확인용 변수 선언.
	var dataChguiNm = new Array();
	//data를 확인하여 자료시점 정보 확인용 변수 선언.
	var valCategories = new Array();
	//차트유형를 변수 선언.
	var valSeriesCd = new Array();

	//항목 및 분류 변수 선언 + 그룹
	var valItmArray = new Array();
	var valClsArray = new Array();
	var valGrpArray = new Array();
	
	$.each(chartTgData, function(key, value){	
		//항목 및 분류를 배열에 담는다. + 그룹
		valItmArray.push(value.ITM_CODE);
		valClsArray.push(value.CLS_CODE);
		valGrpArray.push(value.GRP_CODE);
		
		//차트유형을 배열에 담는다.
		if(value.SERIES_CD != null) valSeriesCd.push(value.SERIES_CD);
		else valSeriesCd.push("line");
		
		//분류(CLS) 데이터 여부확인
		if(value.CLS_CODE != null) chartClsDataYn = "Y";		
		
		//단위명칭(CHG_UI_NM)을 배열에 담는다.
		dataChguiNm.push(value.CHG_UI_NM);
	});

	//SERIES_CD(차트유형) 데이터의 중복을 제거한다.
	var uniqSeriesCd = valSeriesCd.reduce(function(a, b){ if(a.indexOf(b) < 0) a.push(b); return a;},[]);
	chartTypes = uniqSeriesCd;
	
	//CHG_UI_NM(단위명칭) 데이터의 중복을 제거한다.
	var uniqDataChguiNm = dataChguiNm.reduce(function(a, b){ if(a.indexOf(b) < 0) a.push(b); return a; },[]);
	
	//ITM 데이터 중복 제거한다.
	chartItmData = valItmArray.reduce(function(a, b){ if(a.indexOf(b) < 0) a.push(b); return a; },[]);
	//CLS 데이터 중복 제거한다.
	chartClsData = valClsArray.reduce(function(a, b){ if(a.indexOf(b) < 0) a.push(b); return a; },[]);
	//GRP 데이터 중복 제거한다.
	chartGrpData = valGrpArray.reduce(function(a, b){ if(a.indexOf(b) < 0) a.push(b); return a; },[]);
	
	var objTab = getTabShowObj();// 탭이 open된 객체가져옴
	var formObj = chartCallMark == "T" ? objTab.find("form[name=statsEasy-mst-form]") : $('form[name="statsEasy-mst-form"]');

	//자료시점 화면 노출 및 설정
	if(ctype == "pie" || ctype == "donut" || ctype == "treemap" || ctype == "spiderweb" || ctype == "sunburst"){
		
		if(formObj.find($("select[name='chartCategories']")).css("display") == "none"){
			wrtSelectDisplay();
		}
		
	}else{
		formObj.find($("select[name='chartCategories']")).hide();
	}

	var selCategories = formObj.find($("select[name='chartCategories'] option:selected")).val();
	
	if(ctype == ""){
		
		//차트유형이 선택되어 있지 않은 경우 항목관리의 차트 유형을 확인한다.
		//pie, donut, treemap, spiderweb, sunburst 가 있을 경우 해당 차트를 기본 차트로 display 한다.
		var setPie, setDonut, setTreemap, setSpiderweb, setSunburst = false;
		var setArea, setAcColumn, setPcColumn, setAcbar, setPcBar = false;
		var statMulti = formObj.find("input[name=statMulti]").val();
		if(statMulti != "Y"){
			for(var c=0; c<uniqSeriesCd.length; c++){
				if(uniqSeriesCd[c] == "pcbar") setPcBar = true;
				if(uniqSeriesCd[c] == "acbar") setAcbar = true;
				if(uniqSeriesCd[c] == "pccolumn") setPcColumn = true;
				if(uniqSeriesCd[c] == "accolumn") setAcColumn = true;
				if(uniqSeriesCd[c] == "area") setArea = true;
				
				if(uniqSeriesCd[c] == "pie") setPie = true;
				if(uniqSeriesCd[c] == "donut") setDonut = true;
				if(uniqSeriesCd[c] == "treemap") setTreemap = true;
				if(uniqSeriesCd[c] == "spiderweb") setSpiderweb = true;
				if(uniqSeriesCd[c] == "sunburst") setSunburst = true;
			}
		}
		
		//해당 차트 유형이면 자료시점(년도) 콤보를 세팅하여 노출한다.
		if(setPie || setDonut || setTreemap || setSpiderweb || setSunburst){
			wrtSelectDisplay();
		}
		
		//설정 우선순위 pie > donut > treemap > spiderweb > sunburst > area > column > bar
		if(setPie){
			pieDataCall("pie");
		}else if(setDonut){
			pieDataCall("donut");
		}else if(setTreemap){
			treemapDataCall();
		}else if(setSpiderweb){
			spiderwebDataCall();
		}else if(setSunburst){
			sunburstDataCall();
		}else if(setArea){
			valSeries = chartDataMake1(uniqDataChguiNm, "area");
			chartLoad.makeChartBasic("area", chartDivId);
		}else if(setAcColumn){
			valSeries = chartDataMake1(uniqDataChguiNm, "accolumn");
			chartLoad.makeChartBasic("accolumn", chartDivId);
		}else if(setPcColumn){
			valSeries = chartDataMake1(uniqDataChguiNm, "pccolumn");
			chartLoad.makeChartBasic("pccolumn", chartDivId);
		}else if(setAcbar){
			valSeries = chartDataMake1(uniqDataChguiNm, "acbar");
			chartLoad.makeChartBasic("acbar", chartDivId);
		}else if(setPcBar){
			valSeries = chartDataMake1(uniqDataChguiNm, "pcbar");
			chartLoad.makeChartBasic("pcbar", chartDivId);
		}else{
			
			if(chartWrData.length == 1){
				wrtSelectDisplay();
				goItmChart(); //항목을 시계열로 잡는다.
			}else{
				valSeries = chartDataMake2(uniqDataChguiNm, ctype);
				chartLoad.makeChartBasic(ctype, chartDivId);
			}
		}
	}else{
		
		if(ctype == "pie" || ctype == "donut"){ //pie 또는 donut 일 경우
			//차트를 위한 데이터를 생성한다.
			pieDataCall(ctype);
		}else if(ctype == "treemap"){
			//차트를 위한 데이터를 생성한다.
			treemapDataCall();
		}else if(ctype ==  "spiderweb"){
			//차트를 위한 데이터를 생성한다.
			spiderwebDataCall();
		}else if(ctype ==  "sunburst"){	
			//차트를 위한 데이터를 생성한다.
			sunburstDataCall();
		}else{
	
				if(uniqDataChguiNm.length > 1){
					valSeries = chartDataMake2(uniqDataChguiNm, ctype);
				}else{
					valSeries = chartDataMake1(uniqDataChguiNm, ctype);
				}
				chartLoad.makeChartBasic(ctype, chartDivId);
		}
	}
	
	

	//범례숨기기가 이미 설정 되어 있을 경우 범례를 숨긴다.
	var chartLegend = formObj.find("input[name=chartLegend]").val();
	if(chartLegend == "N"){
		for(i=0; i<hightChart.series.length; i++){
			hightChart.series[i].update({ showInLegend: false });
		}
	}
	
	//자료시점 콤보박스 생성(시계열 1개, pie, donut, treemap, spiderweb, sunburst)
	function wrtSelectDisplay(){
		
		formObj.find($("select[name='chartCategories']")).show();
		formObj.find($("select[name='chartCategories'] option")).remove();
		var lastOption = "";
		
		$.each(chartWrOneData, function(key, value){
			var option = $("<option value='"+value.code+"'>"+value.name+"</option>");
			formObj.find($("select[name='chartCategories']")).prepend(option);
			lastOption = value.code;
		});
		formObj.find("select[name=chartCategories] > option[value='"+ lastOption +"']").attr("selected", "true");
		
		// 자료시점 선택
		formObj.find($("select[name='chartCategories']")).change(function() {
			goActionChart();
		});
	}

};

//년도 콤보 선택에 따른 차트 재호출
function goActionChart(){
	
	var objTab = getTabShowObj();// 탭이 open된 객체가져옴
	var formObj = chartCallMark == "T" ? objTab.find("form[name=statsEasy-mst-form]") : $('form[name="statsEasy-mst-form"]');

	//차트 타입 확인
	var ctype = formObj.find($("input[name='chartType']")).val();
	
	if(ctype == undefined || ctype == "") goItmChart();
	if(ctype == "pie" || ctype == "donut") pieDataCall(ctype);
	if(ctype == "treemap")  	treemapDataCall();
	if(ctype == "spiderweb")  	spiderwebDataCall();
	if(ctype == "sunburst")  	sunburstDataCall();
}

//파이  데이터 호출 > 자료시점별
function pieDataCall(ctype){
	selCategories = selCgData();
	valSeries = chartDataPie(selCategories);
	
	var chartLoad = new StatCharts(); //차트 JS함수 정의 statCharts.js	
	if(valSeries.length == 0) alert("해당년도의 데이터가 없거나, \nPie차트로 노출될 수 없는 데이터 입니다.");
	chartLoad.makeChartPie(ctype);
}

//treemap  데이터 호출 > 자료시점별
function treemapDataCall(){
	selCategories = selCgData();
	valSeries = chartDataTreemap(selCategories);

	var chartLoad = new StatCharts(); //차트 JS함수 정의 statCharts.js
	if(valSeries.length == 0) alert("해당년도의 데이터가 없거나, \nTreemap차트로 노출될 수 없는 데이터 입니다.");
	chartLoad.makeChartTreemap();	
}

//spiderweb  데이터 호출 > 자료시점별
function spiderwebDataCall(){
	selCategories = selCgData();
	valSeries = chartDataSpiderweb(selCategories);

	var chartLoad = new StatCharts(); //차트 JS함수 정의 statCharts.js
	if(valSeries.length == 0) alert("해당년도의 데이터가 없거나, \nSpiderweb차트로 노출될 수 없는 데이터 입니다.");
	chartLoad.makeChartSpiderweb();
}

//Sunburst  데이터 호출 > 자료시점별
function sunburstDataCall(){
	selCategories = selCgData();
	valSeries = chartDataSunburst(selCategories);
	
	var chartLoad = new StatCharts(); //차트 JS함수 정의 statCharts.js
	if(valSeries.length == 0) alert("해당년도의 데이터가 없거나, \nSunburst차트로 노출될 수 없는 데이터 입니다.");
	chartLoad.makeChartSunburst();
}

//차트 범례 명칭
function makeTgName(itmItmNm, clsItmNm, dtaDvsNm, dtaDvsCd, statblNm){

	var tgName = "";

		if(clsItmNm == null){
			if(dtaDvsCd == "OD") tgName = itmItmNm;
			else tgName = itmItmNm+"-"+dtaDvsNm;
		}else{
			if(dtaDvsCd == "OD") tgName = itmItmNm+"["+clsItmNm+"]";
			else tgName = itmItmNm+"["+clsItmNm+"]-"+dtaDvsNm;
		}

	return tgName;
		
}

//차트를 위한 자료시점 명칭
function makeWrttimeNm(aData, bDAta){
	
	var wrttimeNm = "";
	if(dtacycleCd != "YY"){
		if(dtacycleCd == "MM"){
			wrttimeNm = aData + "년 " + bDAta + "월";
		}else if(dtacycleCd == "QY"){ //분기
			var strXX = bDAta;
			var strXXval = strXX.substr(strXX.length - 1, 1);
			wrttimeNm = aData + " " + strXXval + "/4";
		}else if(dtacycleCd == "HY"){ //반기
			var strXX = bDAta;
			var strXXval = strXX.substr(strXX.length - 1, 1);
			wrttimeNm = aData + " " + strXXval + "/2";			
		}else{
			wrttimeNm = aData + "년 " + bDAta;
		}
	}else{
		wrttimeNm = aData + "년";
	}
	return wrttimeNm;
}

//차트를 위한 자료시점 아이디로 전환
function makeWrttimeId(data){
	if(dtacycleCd == "YY") data = data.replace("년", "00");
	if(dtacycleCd == "QY") data = data.replace(" ", "0").replace("/4", "");
	if(dtacycleCd == "HY") data = data.replace(" ", "0").replace("/2", "");
	if(dtacycleCd == "MM") data = data.replace("년 ", "").replace("월", "");
	return data;
}

/* =================================================================================================
 * 챠트 종류에 따른 데이터 생성 처리
 * ================================================================================================= */

//차트를 위한 데이터를 생성한다. > 개별 차트유형 공통적용
function chartDataMake1(uniqChguinm, ctype){
	valSeries = new Array();

	if(ctype == "accolumn" || ctype == "acbar" || ctype == "pccolumn" || ctype == "pcbar") ctype = ctype.substring(2, 10);

	yAxisSetting(uniqChguinm);
		
	var allVisible = true;
	//상세분석 화면에서 호출했을 경우
	if(chartCallMark == "T"){
		var objTab = getTabShowObj();// 탭이 open된 객체가져옴
		var formObj = objTab.find("form[name=statsEasy-mst-form]");
		var sId = formObj.find("input[name=statblId]").val();	
		var itmNodes = $("#itm"+sId).dynatree("getTree");
		var itmNodesSel = $("#itm"+sId).dynatree("getSelectedNodes");

		//항목이 전체선택이 아닐 경우
		if(itmNodes.count() > itmNodesSel.length) allVisible = false;
	}

	$.each(chartTgData, function(tgkey, tgvalue){

		var valSeriesName = new Object();
		var valSeriesData = new Array();
		var dataCnt = 0;
		$.each(chartData, function(key, value){
			var mixData = new Array();
			if(tgvalue.TG_CODE == value.TG_CODE){
				var yAxisIndex = 0;
				for(var i=0; i<uniqChguinm.length; i++){
					if(uniqChguinm[i] == value.CHG_UI_NM) yAxisIndex = i;
					
					// 범례 클릭시 Y축 제목 없애는 event 추가 시작
					//valSeriesName.unit = uniqChguinm[i];
					valSeriesName.unit = tgvalue.CHG_UI_NM;
					valSeriesName.events = {
			        	// legend 를 클릭해서 series 가 가려질 때, Y축의 title 을 없앰
			            hide: function () {
			            	if (!this.yAxis.hasVisibleSeries) {	// 이 Y축을 사용하는 series 중 보이는 series 가 하나도 없을 때
			            		this.yAxis.setTitle(null);
			            	}
			            },
			            // legend 를 클릭해서 series 가 보여질 때, Y축의 title 을 생성
			            show: function () {
			            	// Y축의 title 은 valSeriesName.unit 값을 사용합니다.
			            	// valSeriesName.unit 값은 show 함수 안에서 this.userOptions.unit 으로 접근할 수 있습니다. 
			            	this.yAxis.setTitle({text: this.userOptions.unit});
			            }
			        };
					// 범례 클릭시 Y축 제목 없애는 event 추가 끝
					
				}
				valSeriesName.name = tgvalue.TG_FULLNAME;
				valSeriesName.type = ctype != "" ? ctype : "spline";
				valSeriesName.yAxis = yAxisIndex;
				valSeriesName.stack = tgvalue.CHG_UI_NM;
				if(allVisible){
					valSeriesName.visible = tgvalue.C_DEF_SEL_YN == "Y" ? true : false;
				}else{
					valSeriesName.visible = true;	
				}
				
				var wrttimeIdtfrId = value.WRTTIME_IDTFR_ID;
				var datetime = "";
				var slidertime = wrttimeIdtfrId.substr(0, 4);
				if(dtacycleCd == "YY"){
					// '200100' 을 '2001-01', '200200' 을 '2002-01' 과 같이 변경한 후 new Date() 를 사용하여 timestamp 로 만듬
					datetime = +(new Date(wrttimeIdtfrId.substr(0, 4) + '-01'));
				}else if (dtacycleCd === 'HY') {
				    // 상반기는 1월, 하반기는 7월로 변경
				    // '2001상반기' 을 '2001-01' 로 변경한 후 new Date() 를 사용하여 timestamp 로 만듬
				    var temp = wrttimeIdtfrId.substr(4, 2);
				    switch (temp) {
				    	case '01': datetime = +(new Date(wrttimeIdtfrId.substr(0, 4) + '-01'));	slidertime += ''+'1'; break;
				        case '02': datetime = +(new Date(wrttimeIdtfrId.substr(0, 4) + '-07'));	slidertime += ''+'6'; break;
				    }
				    stepVal = 5;
				}else if(dtacycleCd == "QY"){
					// 01 은 1월, 02 는 4월, 03 은 7월, 04 는 10월로 변경
		            // '200101' 을 '2001-01' 로 변경한 후 new Date() 를 사용하여 timestamp 로 만듬
		            var temp = wrttimeIdtfrId.substr(4, 2);
		            switch (temp) {
		            	case '01': datetime = +(new Date(wrttimeIdtfrId.substr(0, 4) + '-01')); slidertime += ''+'00'; break;
		                case '02': datetime = +(new Date(wrttimeIdtfrId.substr(0, 4) + '-04')); slidertime += ''+'25'; break;
		                case '03': datetime = +(new Date(wrttimeIdtfrId.substr(0, 4) + '-07')); slidertime += ''+'50'; break;
		                case '04': datetime = +(new Date(wrttimeIdtfrId.substr(0, 4) + '-10')); slidertime += ''+'75'; break;
		            }
		            stepVal = 25;
				}else if(dtacycleCd == "MM"){
					// '200101' 을 '2001-01' 로 변경한 후 new Date() 를 사용하여 timestamp 로 만듬
					datetime = +(new Date(wrttimeIdtfrId.substr(0, 4) + '-' + wrttimeIdtfrId.substr(4, 2)));
					slidertime += ''+wrttimeIdtfrId.substr(4, 2);
				}
				
				var dtaVal = value.DTA_VAL;
				if(dtaVal != null)	dtaVal = dataReplaceAll(dtaVal, ',', '');
				valSeriesData.push([datetime, parseFloat(dtaVal), Number(slidertime)]);
				
				if(dataCnt==0) minYear = Number(slidertime);
				maxYear = Number(slidertime);
				dataCnt++
			}
	    });
		valSeriesName.data = valSeriesData;
		// 다른 차트 타입에서 범례를 클릭해서 보이지 않게 처리하였었던 경우에는 보이지 않게 처리함
		if (typeof seriesVisible[valSeriesName.name + (valSeriesName.unit ? '_' + valSeriesName.unit : '')] !== 'undefined'){ 
			valSeriesName.visible = seriesVisible[valSeriesName.name + (valSeriesName.unit ? '_' + valSeriesName.unit : '')];
		}
		
		valSeries.push(valSeriesName);
		
	});

	// Y축에 대해서 해당 Y축을 사용하는 series 의 visible 이 모두 false 이면 Y축의 title 을 없앰
	// => Y축의 title 을 모두 없앤 후, series 가 하나라도 visible 이 true 이면 title 을 살림
	var yAxisTitles = [];
	$.each(yAxisData, function(i, item) {
		yAxisTitles.push(item.title.text);
		item.title.text = '';
	});
	$.each(valSeries, function(i, item) {
		if (item.visible) {
			yAxisData[item.yAxis].title.text = yAxisTitles[item.yAxis];
		}
	});

	return valSeries;	
}

//차트를 위한 데이터를 생성한다. > Dual 차트유형 공통적용
function chartDataMake2(uniqChguinm, ctype){
	
	valSeries = new Array();

	if(ctype == "accolumn" || ctype == "acbar" || ctype == "pccolumn" || ctype == "pcbar") ctype = ctype.substring(2, 10);

	yAxisSetting(uniqChguinm);
	
	var allVisible = true;
	//상세분석 화면에서 호출했을 경우
	if(chartCallMark == "T"){
		var objTab = getTabShowObj();// 탭이 open된 객체가져옴
		var formObj = objTab.find("form[name=statsEasy-mst-form]");
		var sId = formObj.find("input[name=statblId]").val();	
		var itmNodes = $("#itm"+sId).dynatree("getTree");
		var itmNodesSel = $("#itm"+sId).dynatree("getSelectedNodes");

		//항목이 전체선택이 아닐 경우
		if(itmNodes.count() > itmNodesSel.length) allVisible = false;
	}


	//차트 데이터 정렬 > 차트종류에 따라 정렬(column차트 우선)
	chartTgData.sort(function(a, b){
		return a.SERIES_CD < b.SERIES_CD ? -1 : a.SERIES_CD > b.SERIES_CD ? 1 : 0;
	});
	
	$.each(chartTgData, function(tgkey, tgvalue){
		var valSeriesData = new Array();
		var valSeriesName = new Object();
		var valTooltip = new Object();
		var type = "";
		var chguiNm = "";
		var dataCnt = 0;
		$.each(chartData, function(key, value){
			if(tgvalue.TG_CODE == value.TG_CODE){
				var wrttimeIdtfrId = value.WRTTIME_IDTFR_ID;
				var datetime = "";
				var slidertime = wrttimeIdtfrId.substr(0, 4);
				if(dtacycleCd === "YY"){
					// '200100' 을 '2001-01', '200200' 을 '2002-01' 과 같이 변경한 후 new Date() 를 사용하여 timestamp 로 만듬
					datetime = +(new Date(wrttimeIdtfrId.substr(0, 4) + '-01'));
				}	
		    	// (2) 반기 데이터 포맷
			    else if (dtacycleCd === 'HY') {
			    	// 상반기는 1월, 하반기는 7월로 변경
			    	// '2001상반기' 을 '2001-01' 로 변경한 후 new Date() 를 사용하여 timestamp 로 만듬
			    	var temp = wrttimeIdtfrId.substr(4, 2);
			                
			    	switch (temp) {
			    		case '01': datetime = +(new Date(wrttimeIdtfrId.substr(0, 4) + '-01'));	slidertime += ''+'1'; break;
			            case '02': datetime = +(new Date(wrttimeIdtfrId.substr(0, 4) + '-07'));	slidertime += ''+'6'; break;
			    	}
			    }
				// (3) 분기 데이터 포맷
			    else if(dtacycleCd === "QY"){
					// 01 은 1월, 02 는 4월, 03 은 7월, 04 는 10월로 변경
		            // '200101' 을 '2001-01' 로 변경한 후 new Date() 를 사용하여 timestamp 로 만듬
		            var temp = wrttimeIdtfrId.substr(4, 2);
		                
		            switch (temp) {
		            	case '01': datetime = +(new Date(wrttimeIdtfrId.substr(0, 4) + '-01')); slidertime += ''+'00'; break;
		                case '02': datetime = +(new Date(wrttimeIdtfrId.substr(0, 4) + '-04')); slidertime += ''+'25'; break;
		                case '03': datetime = +(new Date(wrttimeIdtfrId.substr(0, 4) + '-07')); slidertime += ''+'50'; break;
		                case '04': datetime = +(new Date(wrttimeIdtfrId.substr(0, 4) + '-10')); slidertime += ''+'75'; break;
		            }
				}else if(dtacycleCd === "MM"){
					// '200101' 을 '2001-01' 로 변경한 후 new Date() 를 사용하여 timestamp 로 만듬
					datetime = +(new Date(wrttimeIdtfrId.substr(0, 4) + '-' + wrttimeIdtfrId.substr(4, 2)));
					slidertime += ''+wrttimeIdtfrId.substr(4, 2);
				}
				var dtaVal = value.DTA_VAL;
				if(dtaVal != null)	dtaVal = dataReplaceAll(dtaVal, ',', '');
				valSeriesData.push([datetime, parseFloat(dtaVal), Number(slidertime)]);
				
				type = tgvalue.SERIES_CD;
				if(type == "accolumn" || type == "acbar" || type == "pccolumn" || type == "pcbar") type = type.substring(2, 10);
				if(type == "") type = "spline"; //차트유형이 설정되어 있지 않으면 초기설정 한다. 조건의 2번째값을 라인으로 한다.
				chguiNm = tgvalue.CHG_UI_NM;
				
				if(dataCnt==0) minYear = Number(slidertime);
				maxYear = Number(slidertime);
				dataCnt++
			}
		});
		
		if(valSeriesData.length > 0){
			var yAxisIndex = 0;
			for(var i=0; i<uniqChguinm.length; i++){
				if(uniqChguinm[i] == chguiNm) yAxisIndex = i;
			}
			valTooltip.valueSuffix = chguiNm;			
			valSeriesName.name = tgvalue.TG_FULLNAME;
			valSeriesName.data = valSeriesData;
			valSeriesName.tooltip = valTooltip;
			valSeriesName.yAxis = yAxisIndex;
			valSeriesName.type = ctype != "" ? ctype : type;	
			if(allVisible){
				valSeriesName.visible = tgvalue.C_DEF_SEL_YN == "Y" ? true : false;
			}else{
				valSeriesName.visible = true;	
			}

			// 범례 클릭시 Y축 제목 없애는 event 추가 시작
			valSeriesName.unit = chguiNm;
			valSeriesName.events = {
	        	// legend 를 클릭해서 series 가 가려질 때, Y축의 title 을 없앰
	            hide: function () {
	            	if (!this.yAxis.hasVisibleSeries) {	// 이 Y축을 사용하는 series 중 보이는 series 가 하나도 없을 때
	            		this.yAxis.setTitle(null);
	            	}
	            },
	            // legend 를 클릭해서 series 가 보여질 때, Y축의 title 을 생성
	            show: function () {
	            	// Y축의 title 은 valSeriesName.unit 값을 사용합니다.
	            	// valSeriesName.unit 값은 show 함수 안에서 this.userOptions.unit 으로 접근할 수 있습니다. 
	            	this.yAxis.setTitle({text: this.userOptions.unit});
	            }
	        };
			
			// 다른 차트 타입에서 범례를 클릭해서 보이지 않게 처리하였었던 경우에는 보이지 않게 처리함
			if (typeof seriesVisible[valSeriesName.name + (valSeriesName.unit ? '_' + valSeriesName.unit : '')] !== 'undefined'){ 
				valSeriesName.visible = seriesVisible[valSeriesName.name + (valSeriesName.unit ? '_' + valSeriesName.unit : '')];
			}
			
			valSeries.push(valSeriesName);

		}	
	});	

	// Y축에 대해서 해당 Y축을 사용하는 series 의 visible 이 모두 false 이면 Y축의 title 을 없앰
	// => Y축의 title 을 모두 없앤 후, series 가 하나라도 visible 이 true 이면 title 을 살림
	var yAxisTitles = [];
	$.each(yAxisData, function(i, item) {
		yAxisTitles.push(item.title.text);
		item.title.text = '';
	});
	$.each(valSeries, function(i, item) {
		if (item.visible) {
			yAxisData[item.yAxis].title.text = yAxisTitles[item.yAxis];
		}
	});

	return valSeries;
}

//차트를 위한 데이터를 생성한다. > 개별 차트유형 공통적용(pie)
function chartDataPie(selCategories){
	valSeries = new Array();
	drillDown = new Array();

	var drillDownName = new Object();
	var drillDownNameArr = new Array();
	var allVisible = true;
	//상세분석 화면에서 호출했을 경우
	if(chartCallMark == "T"){
		var objTab = getTabShowObj();// 탭이 open된 객체가져옴
		var formObj = objTab.find("form[name=statsEasy-mst-form]");
		var sId = formObj.find("input[name=statblId]").val();	
		var itmNodes = $("#itm"+sId).dynatree("getTree");
		var itmNodesSel = $("#itm"+sId).dynatree("getSelectedNodes");

		//항목이 전체선택이 아닐 경우
		if(itmNodes.count() > itmNodesSel.length) allVisible = false;
	}
	
	//파이차트는 선택 년도를 기준으로 한다. 년도와 동일한 데이터를 우선 담는다.
	var targetData = new Array();
	$.each(chartData, function(key, value){
		if(selCategories == value.WRTTIME_IDTFR_ID.substring(0,4)) targetData.push(value);
	});
	
	if(targetData.length > 0){
		var grpNull = targetData[0].GRP_DATANO; 	//그룹 여부 확인
		var clsNull = targetData[0].CLS_DATANO;		//분류 여부 확인
		
		if(grpNull != null){ //그룹이 있으면..
			valSeries = makePieData('S', selCategories, 'GRP', chartGrpData, targetData);
			var drillDownObj = new Object();
			var drillDownArr = new Array();
			for(var i=0; i<chartGrpData.length; i++){
				var grpNm = ""; //그룹 이름을 확인한다.
				//그룹 이름을 확인한다.
				$.each(chartTgData, function(key, value){
					if(chartGrpData[i] == value.GRP_CODE) grpNm = value.GRP_NAME;
				});
				var tgGrpData = new Array();
				$.each(targetData, function(key, value){
					if(chartGrpData[i] == value.GRP_DATANO) tgGrpData.push(value);
				});
				if(clsNull != null){ //그룹O+분류가 있으면..
					var makeDrillDownCls = makePieData('D', grpNm, 'CLS', chartClsData, tgGrpData);
					drillDownArr.push(makeDrillDownCls);

					//분류정보에 따른 항목정보를 추가적으로 가져온다. [그룹 + 분류 + 항목] 3개 모두 존재할때..
					for(var z=0; z<chartClsData.length; z++){
						//분류 이름을 확인한다.
						var clsNm = ""; //분류 이름을 확인한다.
						$.each(chartTgData, function(key, value){
							if(chartClsData[z] == value.CLS_CODE) clsNm = value.CLS_NAME;
						});
						var tgClsData = new Array();
						$.each(tgGrpData, function(key, value){
							if(chartClsData[z] == value.CLS_DATANO) tgClsData.push(value);
						});
						var makeDrillDownItm = makePieData(grpNm, clsNm, 'ITM', chartItmData, tgClsData);
						drillDownArr.push(makeDrillDownItm);
						
					}

				}else{ //그룹O+분류가 없으면..
					drillDownArr.push(makePieData('D', grpNm, 'ITM', chartItmData, tgGrpData));
				}
			}
			drillDownObj.series = drillDownArr;
			drillDown = drillDownObj;
		}else{ //그룹이 없으면..
			if(clsNull != null){ //그룹X+분류가 있으면..
				valSeries = makePieData('S', selCategories, 'CLS', chartClsData, targetData);
				var drillDownObj = new Object();
				var drillDownArr = new Array();
				for(var i=0; i<chartClsData.length; i++){
					var clsNm = ""; //분류 이름을 확인한다.
					$.each(chartTgData, function(key, value){
						if(chartClsData[i] == value.CLS_CODE) clsNm = value.CLS_NAME;
					});
					var tgClsData = new Array();
					$.each(targetData, function(key, value){
						if(chartClsData[i] == value.CLS_DATANO){
							tgClsData.push(value);
						}
					});
					drillDownArr.push(makePieData('D', clsNm, 'ITM', chartItmData, tgClsData));
				}
				drillDownObj.series = drillDownArr;
				drillDown = drillDownObj;
			}else{ //그룹X+분류가 없으면..
				valSeries = makePieData('S', selCategories, 'ITM', chartItmData, targetData);
			}
		}
		
	}
	
	return valSeries;
}

//차트를 위한 데이터를 생성한다. > 개별 차트유형 공통적용(treemap)
function chartDataTreemap(selCategories){
	valSeries = new Array();
	
	//선택 년도를 기준으로 한다. 년도와 동일한 데이터를 우선 담는다.
	var targetData = new Array();
	$.each(chartData, function(key, value){
		if(selCategories == value.WRTTIME_IDTFR_ID.substring(0,4)) targetData.push(value);
	});
	
	if(targetData.length > 0){
		var grpNull = targetData[0].GRP_DATANO; 	//그룹 여부 확인
		var clsNull = targetData[0].CLS_DATANO;		//분류 여부 확인
		
		if(grpNull != null){ //그룹이 있으면..
			makeTreemapData('S', selCategories, 'GRP', chartGrpData, targetData, 1);
			for(var i=0; i<chartGrpData.length; i++){
				var grpNm = ""; //그룹 이름을 확인한다.
				//그룹 이름을 확인한다.
				$.each(chartTgData, function(key, value){
					if(chartGrpData[i] == value.GRP_CODE) grpNm = value.GRP_NAME;
				});
				var tgGrpData = new Array();
				$.each(targetData, function(key, value){
					if(chartGrpData[i] == value.GRP_DATANO) tgGrpData.push(value);
				});
				if(clsNull != null){ //그룹O+분류가 있으면..
					makeTreemapData('D', grpNm, 'CLS', chartClsData, tgGrpData, 2);

					//분류정보에 따른 항목정보를 추가적으로 가져온다. [그룹 + 분류 + 항목] 3개 모두 존재할때..
					for(var z=0; z<chartClsData.length; z++){
						//분류 이름을 확인한다.
						var clsNm = ""; //분류 이름을 확인한다.
						$.each(chartTgData, function(key, value){
							if(chartClsData[z] == value.CLS_CODE) clsNm = value.CLS_NAME;
						});
						var tgClsData = new Array();
						$.each(tgGrpData, function(key, value){
							if(chartClsData[z] == value.CLS_DATANO) tgClsData.push(value);
						});
						makeTreemapData(grpNm, clsNm, 'ITM', chartItmData, tgClsData, 3);
					}

				}else{ //그룹O+분류가 없으면..
					makeTreemapData('D', grpNm, 'ITM', chartItmData, tgGrpData, 2);
				}
			}
		}else{ //그룹이 없으면..
			if(clsNull != null){ //그룹X+분류가 있으면..
				makeTreemapData('S', selCategories, 'CLS', chartClsData, targetData, 1);
				for(var i=0; i<chartClsData.length; i++){
					var clsNm = ""; //분류 이름을 확인한다.
					$.each(chartTgData, function(key, value){
						if(chartClsData[i] == value.CLS_CODE) clsNm = value.CLS_NAME;
					});
					var tgClsData = new Array();
					$.each(targetData, function(key, value){
						if(chartClsData[i] == value.CLS_DATANO){
							tgClsData.push(value);
						}
					});
					makeTreemapData('D', clsNm, 'ITM', chartItmData, tgClsData, 2);
				}
			}else{ //그룹X+분류가 없으면..
				makeTreemapData('S', selCategories, 'ITM', chartItmData, targetData, 1);
			}
		}
	}
	return valSeries;
}

//차트를 위한 데이터를 생성한다. > 개별 차트유형 공통적용(spiderweb)
function chartDataSpiderweb(selCategories){
	valSeries = new Array();
	
	//선택 년도를 기준으로 한다. 년도와 동일한 데이터를 우선 담는다.
	var targetData = new Array();
	$.each(chartData, function(key, value){
		if(selCategories == value.WRTTIME_IDTFR_ID.substring(0,4)) targetData.push(value);
	});
	
	if(targetData.length > 0){
		spiderwebCate = new Array();
		var grpNull = targetData[0].GRP_DATANO; 	//그룹 여부 확인
		var clsNull = targetData[0].CLS_DATANO;		//분류 여부 확인
		
		makeSpiderwebCate(grpNull, clsNull, chartTgData);
		makeSpiderwebData(grpNull, clsNull, targetData);
			
	}
	return valSeries;
}

//차트를 위한 데이터를 생성한다. > 개별 차트유형 공통적용(sunburst)
function chartDataSunburst(selCategories){
	valSeries = new Array();
	
	//선택 년도를 기준으로 한다. 년도와 동일한 데이터를 우선 담는다.
	var targetData = new Array();
	$.each(chartData, function(key, value){
		if(selCategories == value.WRTTIME_IDTFR_ID.substring(0,4)) targetData.push(value);
	});
	
	if(targetData.length > 0){
		//데이터가 있으면 선택연도를 가장 첫 Data로 세팅한다.
		var sObj = new Object();
		sObj.id = selCategories;
		sObj.parent = '';
		sObj.name = selCategories;
		valSeries.push(sObj);
		
		var grpNull = targetData[0].GRP_DATANO; 	//그룹 여부 확인
		var clsNull = targetData[0].CLS_DATANO;		//분류 여부 확인
		
		if(grpNull != null){ //그룹이 있으면..
			makeSunburstData('S', selCategories, 'GRP', chartGrpData, targetData, 1);
			for(var i=0; i<chartGrpData.length; i++){
				var grpNm = ""; //그룹 이름을 확인한다.
				//그룹 이름을 확인한다.
				$.each(chartTgData, function(key, value){
					if(chartGrpData[i] == value.GRP_CODE) grpNm = value.GRP_NAME;
				});
				var tgGrpData = new Array();
				$.each(targetData, function(key, value){
					if(chartGrpData[i] == value.GRP_DATANO) tgGrpData.push(value);
				});
				if(clsNull != null){ //그룹O+분류가 있으면..
					makeSunburstData('D', grpNm, 'CLS', chartClsData, tgGrpData, 2);

					//분류정보에 따른 항목정보를 추가적으로 가져온다. [그룹 + 분류 + 항목] 3개 모두 존재할때..
					for(var z=0; z<chartClsData.length; z++){
						//분류 이름을 확인한다.
						var clsNm = ""; //분류 이름을 확인한다.
						$.each(chartTgData, function(key, value){
							if(chartClsData[z] == value.CLS_CODE) clsNm = value.CLS_NAME;
						});
						var tgClsData = new Array();
						$.each(tgGrpData, function(key, value){
							if(chartClsData[z] == value.CLS_DATANO) tgClsData.push(value);
						});
						makeSunburstData(grpNm, clsNm, 'ITM', chartItmData, tgClsData, 3);
					}

				}else{ //그룹O+분류가 없으면..
					makeSunburstData('D', grpNm, 'ITM', chartItmData, tgGrpData, 2);
				}
			}
		}else{ //그룹이 없으면..
			if(clsNull != null){ //그룹X+분류가 있으면..
				makeSunburstData('S', selCategories, 'CLS', chartClsData, targetData, 1);
				for(var i=0; i<chartClsData.length; i++){
					var clsNm = ""; //분류 이름을 확인한다.
					$.each(chartTgData, function(key, value){
						if(chartClsData[i] == value.CLS_CODE) clsNm = value.CLS_NAME;
					});
					var tgClsData = new Array();
					$.each(targetData, function(key, value){
						if(chartClsData[i] == value.CLS_DATANO){
							tgClsData.push(value);
						}
					});
					makeSunburstData('D', clsNm, 'ITM', chartItmData, tgClsData, 2);
				}
			}else{ //그룹X+분류가 없으면..
				makeSunburstData('S', selCategories, 'ITM', chartItmData, targetData, 1);
			}
		}
	}
	return valSeries;
}

/* =================================================================================================
 * 챠트 종류에 따른 화면 노출 처리
 * ================================================================================================= */

/**
 * Chart prototype 
 */
StatCharts = function(){
 this.statCharts = new Object();
};   
StatCharts.prototype = {
	/* -----------------------------------------------------------------------------------------------------------------------
	 * makeChartBasic
	 * ----------------------------------------------------------------------------------------------------------------------- */	
	makeChartBasic : function(ctype, chartId){   //기본 차트
		
    	var $window = $(window);
		var objTab = getTabShowObj();// 탭이 open된 객체가져옴
		var formObj = chartCallMark != "S" ? objTab.find("form[name=statsEasy-mst-form]") : $('form[name="statsEasy-mst-form"]');
		var chartId = "";
		if(chartCallMark != "S"){
			chartId = formObj.find($(".chart.statEasyChart")).attr('id');
			sliderId = formObj.find($(".statSlider")).attr('id');
		}else{
			chartId = "statChart";
			sliderId =  "slider";
		}
    	valSlider = valSeries; //슬라이더 원본 데이터 처리를 위해 넣어놓는다.
		
		var isNavi = true;
		if(isMobile){ 
			$("#sliderArea").show(); isNavi = false;
			if($("#"+chartId).width() < 550){
				$(".ui-slider").css("width", $("#"+chartId).width()-50);
			}

			$("#statSlider").slider({
				
				min: minYear,
				max: maxYear,
				step: stepVal,
				range: false,
				tooltips: false,
				handles: [{value: Number(minYear), type: "wake"},
				          	{value: Number(maxYear), type: "wake"}],
				mainClass: 'sleep',
				slide: function(e, ui) { //slider 클릭 이벤트
					var setYear = ui.values;
					
					var scCnt = 0;
					var setChart = $('#'+chartId).highcharts();
					
					$.each(valSlider, function(key, value){
						
						var ndata = value.data;
						var nDataArr = new Array();
						var bDataArr = new Array();
						
						for(var i=0; i<ndata.length; i++){
							var rowData = ndata[i];
							bDataArr.push(rowData)
							if(setYear[0] <= rowData[2]  && setYear[1] >= rowData[2]) nDataArr.push(rowData);
						}
						setChart.series[scCnt].setData(nDataArr);
						setChart.redraw();
						valSlider[scCnt].data = bDataArr; //valSlider의 데이터에 원본 데이터를 계속 넣는다.
						scCnt++;
					});
					
				}
			});
			
		} else { $("#sliderArea").hide(); }
		
/*		console.log("[ makeChartBasic ] 데이터 콘솔 확인");
    	console.log("ctype:"+ctype);
    	console.log("chartId:"+chartId);
    	console.log(yAxisData);
    	console.log(valSeries);*/

		var $window = $(window);
		var objTab = getTabShowObj();// 탭이 open된 객체가져옴		
		//호출화면 form정의
		var formObj = ""; 
		if(chartCallMark != "S"){
			formObj = objTab.find("form[name=statsEasy-mst-form]");
		}else{
			formObj = $('form[name="statsEasy-mst-form"]');			
		}
		//차트 종류를 변수에 담는다.
		formObj.find("input[name=chartType]").val(ctype);
		
		//차트 3D 여부
		var isThreeD = false;
		var optionDepth, columnDepth = 0;
		if(formObj.find("input[name=chart23Type]").val() == "3D"){
			isThreeD = true;
			optionDepth = 20;
			columnDepth = 25;
		}

		var maxCateCnt = chartWrData.length;
		var naviCateCnt = maxCateCnt;
		if(naviCateCnt > 19) naviCateCnt = 20;
		var markerEnabled = false;
		var navigatorEnabled = true;
		
		if(maxCateCnt <= 1){
			markerEnabled = true;
			navigatorEnabled = false;
		}
		var stockNavi = true; //네비게이션 활성화
		var stockScrl = true; //스크롤바 활성화
		
		//차트 공통 옵션
		Highcharts.setOptions({
			plotOptions: {	
				spline: { marker: { enabled: markerEnabled } },
				line: { dataLabels: { enabled: false }, marker: { enabled: markerEnabled } },
				column: { pointPadding: 0.2, borderWidth: 0, depth: columnDepth },
				bar: { pointPadding: 0.2, borderWidth: 0, depth: columnDepth },
				area: { stacking: 'normal', lineColor: '#666666', lineWidth: 1, marker: { enabled: markerEnabled, lineWidth: 1, lineColor: '#666666'} }
			}, lang: { thousandsSep: ','}, yAxis: { labels: { format: '{value:,.0f}' } }
		});
		
		//차트 종류에 따른 기본 설정 적용
		if(ctype == ""){
			for(var z=0; z<chartTypes.length; z++){				
				var seriesOption =  new Array();
				var seriesOptionNm = new Object();
				var xAxisYval = 0;
				if(chartTypes[z] == "spline" || chartTypes[z] == "line"){
					var labelName = new Object();
					labelName.connectorAllowed = false;
					seriesOptionNm.stacking = "";
					seriesOptionNm.lable = labelName;
					seriesOption.push(seriesOptionNm);
				}else if(chartTypes[z] == "column" || chartTypes[z] == "bar"){
					seriesOptionNm.stacking = "";
					seriesOption.push(seriesOptionNm);
					if(chartTypes[z] == "bar") xAxisYval = 15
				}else if(chartTypes[z] == "accolumn" || chartTypes[z] == "acbar" || chartTypes[z] == "area"){
					seriesOptionNm.stacking = 'normal';
					seriesOption.push(seriesOptionNm);
					if(chartTypes[z] == "acbar") xAxisYval = 15
				}else if(chartTypes[z] == "pccolumn" || chartTypes[z] == "pcbar"){
					seriesOptionNm.stacking = 'percent';
					seriesOption.push(seriesOptionNm);
					if(chartTypes[z] == "pcbar") xAxisYval = 15
				}
				Highcharts.setOptions({ plotOptions: {	series: seriesOption[0] }, navigator: { xAxis: { labels: { y:xAxisYval } }} }); 
			}
		}else{
			var seriesOption =  new Array();
			var seriesOptionNm = new Object();
			var xAxisYval = 0;
			if(ctype == "spline" || ctype == "line"){
				var labelName = new Object();
				labelName.connectorAllowed = false;
				seriesOptionNm.stacking = "";
				seriesOptionNm.lable = labelName;
				seriesOption.push(seriesOptionNm);
			}else if(ctype == "column" || ctype == "bar"){
				seriesOptionNm.stacking = "";
				seriesOption.push(seriesOptionNm);
				if(ctype == "bar") xAxisYval = 15
			}else if(ctype == "accolumn" || ctype == "acbar" || ctype == "area"){
				seriesOptionNm.stacking = 'normal';
				seriesOption.push(seriesOptionNm);
				if(ctype == "acbar") xAxisYval = 15
			}else if(ctype == "pccolumn" || ctype == "pcbar"){
				seriesOptionNm.stacking = 'percent';
				seriesOption.push(seriesOptionNm);
				if(ctype == "pcbar") xAxisYval = 15
			}
			Highcharts.setOptions({ plotOptions: {	series: seriesOption[0] }, navigator: { xAxis: { labels: { y:xAxisYval } }} }); 
		}	
		
		//범례 visible 설정
		Highcharts.setOptions({
			plotOptions: {
				series: {
					events: {
						legendItemClick: function() {
							// 범례를 클릭하는 순간의 item.visible 이 true 이면 클릭 후 false 로 변경되기 때문에 !this.visible 을 저장함
							// 저장할 때의 key 는 [series 의 name _ series 의 unit] 형태로 함
							seriesVisible[this.userOptions.name + (this.userOptions.unit ? '_' + this.userOptions.unit : '')] = !this.visible;
						}
					}
				}
			}
		});
		
		Highcharts.dateFormats = {
				Q: function(timestamp) {
					var date = new Date(timestamp);
					switch(date.getMonth() + 1) {
						case 1: case 2: case 3: return 1;
						case 4: case 5: case 6: return 2;
						case 7: case 8: case 9: return 3;
						default: return 4;
					}
				},
				B: function(timestamp) {
				    var date = new Date(timestamp);
				    switch(date.getMonth() + 1) {
				    	case 1: case 2: case 3: case 4: case 5: case 6: return '상반기';
					    default: return '하반기';
				    }
				}
			};

		//* 차트 생성 처리
		hightChart = new Highcharts.chart(chartId, {
			chart: { 
				zoomType: 'xy', 
				options3d: { enabled: isThreeD, alpha:0, beta:0, depth:optionDepth },
				alignTicks: false,
				marginTop: 30,
				marginRight: 30,
				spacingLeft: 10,
				spacingBottom: 10,
			},
		    title: { text: "" }, 
		    xAxis: { 
	    		type: 'datetime',
	            labels: {
	        		formatter: function() {
	            		if(!this.axis.isDatetimeAxis) {		// xAxis type 이 datetime 이 아닌 경우 아래의 연산을 하지 않고 값을 그대로 return
	                		return this.value;
	            		}
	                
		                // this.axis.min - Highcharts 가 계산한 xAxis 최소값
		                // this.axis.max - Highcharts 가 계산한 xAxis 최대값
		                // this.axis.tickPositions.length - xAxis label 개수 (위에서 표시 안한 맨 좌측, 맨 우측 포함)
		                // 아래에서 계산한 tickDisLen 의 값에 따라 X 축에 년, 분기, 월, 일 단위로 표시하도록 수정하였습니다.
		                
		                var tickDisLen = Math.abs((this.axis.min - this.axis.max) / this.axis.tickPositions.length);
		                
		                // (1) 년 데이터 포맷
		        		if (dtacycleCd === 'YY') {
		                	this.dateTimeLabelFormat = '%Y년';
		                }
		                // (2) 반기 데이터 포맷
		                else if (dtacycleCd === 'HY') {
												// 반기 - 1년보다 작은 경우
		                    if(tickDisLen < (3600 * 24 * 365 * 1000)) {
		                        this.dateTimeLabelFormat = '%Y년 %B';
		                    }
		                    // 년 - 차이가 1년 이상인 경우
		                    else {
		                        this.dateTimeLabelFormat = '%Y년';
		                    }
		                }
		                // (3) 분기 데이터 포맷
		                else if (dtacycleCd === 'QY') {
		                	// 분기 - 1년보다 작은 경우
		                    if(tickDisLen < (3600 * 24 * 365 * 1000)) {
		                        this.dateTimeLabelFormat = '%Y년 %Q분기';
		                    }
		                    // 년 - 차이가 1년 이상인 경우
		                    else {
		                        this.dateTimeLabelFormat = '%Y년';
		                    }
		                }
		                // (4) 월 데이터 포맷
		        		else if (dtacycleCd === 'MM') {
		                	// 월 - 1년보다 작은 경우
		                    if(tickDisLen < (3600 * 24 * 365 * 1000)) {
		                        this.dateTimeLabelFormat = '%Y년 %m월';
		                    }
		                    // 년 - 차이가 1년 이상인 경우
		                    else {
		                        this.dateTimeLabelFormat = '%Y년';
		                    }
		                }
		                
		                return Highcharts.dateFormat(this.dateTimeLabelFormat, this.value);
		            }
		        }
		    },
		    yAxis: yAxisData,
		    tooltip: {
		    	formatter: function() {
	        		if (dtacycleCd === 'YY') {
	                	this.dateTimeLabelFormat = '%Y년';
	                }else if (dtacycleCd === 'HY') {
                        this.dateTimeLabelFormat = '%Y년 %B';
	                }else if (dtacycleCd === 'QY') {
                        this.dateTimeLabelFormat = '%Y년 %Q분기';
	                }else if (dtacycleCd === 'MM') {
                        this.dateTimeLabelFormat = '%Y년 %m월';
	                }
	                
		    		return Highcharts.dateFormat(this.dateTimeLabelFormat, this.x) + '<br />' + this.series.name + ' : ' + commaWon(this.y) + this.series.userOptions.unit;
		    	}
		    },
		    credits:{enabled : false},
		    legend: { enabled: true, maxHeight: 60 },
		    rangeSelector: { enabled: false },
		    
		    navigator: { enabled: isNavi,
		    	xAxis: { labels: { enabled: true } }
		    },
		    scrollbar: { enabled: isNavi },
		    colors: ['#2F7ED8', '#0D233A', '#8BBC21', '#910000', '#1AADCE', '#492970', '#F28F43', '#77A1E5', '#C42525', '#A6C96A',
		               '#058DC7', '#50B432', '#ED561B', '#DDDF00', '#24CBE5', '#64E572', '#FF9655', '#FFF263', '#6AF9C4',
		               '#4572A7', '#AA4643', '#89A54E', '#80699B', '#3D96AE', '#DB843D', '#92A8CD', '#A47D7C', '#B5CA92'],
		    navigation: { buttonOptions:{enabled: false}},
		    exporting: {width:800},
		    series: valSeries	
		});		
		
	}, 
	
	/* -----------------------------------------------------------------------------------------------------------------------
	 * makeChartPie
	 * ----------------------------------------------------------------------------------------------------------------------- */	
    makeChartPie : function(ctype){   

    	var $window = $(window);
		var objTab = getTabShowObj();// 탭이 open된 객체가져옴
		var formObj = chartCallMark != "S" ? objTab.find("form[name=statsEasy-mst-form]") : $('form[name="statsEasy-mst-form"]');
		var chartId = "";
		if(chartCallMark != "S"){
			chartId = formObj.find($(".chart.statEasyChart")).attr('id');
			sliderId = formObj.find($(".statSlider")).attr('id');
		}else{
			chartId = "statChart";
			sliderId =  "slider";
		}
    	$("#"+sliderId).hide(); //slider비활성화
    	
    	//chartWrData 사용
    	var seriesName = new Array();
		$.each(valSeries, function(key, value){
			seriesName.push(value.name);
		});

		//차트 3D 여부
		var isThreeD = false;
		if(formObj.find("input[name=chart23Type]").val() == "3D") isThreeD = true;
		
		var pieInnerSize = 0;
		if(ctype == "donut") pieInnerSize = 100;
		if(ctype == "donut" && isChartMobile) pieInnerSize = 30;
		
		formObj.find("input[name=chartType]").val(ctype);
		
		var selectWrtNm = formObj.find($("select[name='chartCategories'] option:selected")).text();

		Highcharts.getOptions().plotOptions.pie.colors=['#2F7ED8', '#0D233A', '#8BBC21', '#910000', '#1AADCE', '#492970', '#F28F43', '#77A1E5', '#C42525', '#A6C96A',
		                         		               '#058DC7', '#50B432', '#ED561B', '#DDDF00', '#24CBE5', '#64E572', '#FF9655', '#FFF263', '#6AF9C4',
		                        		               '#4572A7', '#AA4643', '#89A54E', '#80699B', '#3D96AE', '#DB843D', '#92A8CD', '#A47D7C', '#B5CA92'];
		
		if(drillDown.length == undefined){
		//if(chartClsDataYn == "Y"){
			hightChart = Highcharts.chart(chartId, {
			    chart: {
			    	plotBackgroundColor: null,
			        plotBorderWidth: null,
			        plotShadow: false,
			        type: 'pie',
			        options3d: { enabled: isThreeD, alpha: 45, beta: 0 },
			        events: {
			        	drilldown: function(e) {
			        		e.point.series.update({name: e.point.name});
			        	}
			        }
			    },
			    title: { text: '' },
			    tooltip: {
			    	formatter: function() {
			    		var chkDanWi = this.key.split('|');
			    		if(chkDanWi.length > 1) return chkDanWi[0] + " : " + commaWon(this.y) + " "+ chkDanWi[1];
			    		else return this.key + " : " + commaWon(this.y) + " " + this.series.userOptions.danWi;
			    	}
			    },
			    plotOptions: {
			        series: {
			        	innerSize: pieInnerSize,
			            depth: 35,
			            dataLabels: {
			                enabled: true,
				    		formatter: function() {
				    			var chkDanWi = this.key.split('|');
				    			if(chkDanWi.length > 1) return chkDanWi[0] + " : <b>" + commaWon(this.y) + "</b> "+ chkDanWi[1];
				    			else return this.key + " : <b>" + commaWon(this.y) + "</b> " + this.series.userOptions.danWi;
				    		}
			            },
			            showInLegend: true
			        }
			    },
			    
			    series: [valSeries],/*[{
			        name: selectWrtNm,
			        colorByPoint: true,
			        data: valSeries
			    }],*/
			    drilldown: drillDown,/*{ 
			    	series : drillDown.series
			    },*/
			    legend: { enabled: true, maxHeight: 60 },
			    lang: {thousandsSep: ','}, //천단위 콤마 처리
			    credits:{enabled : false},
			    navigation: { buttonOptions:{enabled: false}},
			    exporting: {
			        enabled: false
			    }
			});
			
		}else{
	    	//파이 데이터 정렬
	    	//valSeries.sort(function(a, b){return(a.y > b.y) ? -1 : (a.y < b.y) ? 1 : 0; });

			hightChart = Highcharts.chart(chartId, {
			    chart: {
			        plotBackgroundColor: null,
			        plotBorderWidth: null,
			        plotShadow: false,
			        type: 'pie',
			        options3d: { enabled: isThreeD, alpha: 45, beta: 0 }
			    },
			    title: { text: '' },
			    tooltip: {
			    	formatter: function() {
			    		return this.point.name + ' : <b>'+commaWon(this.point.y)+'</b> '+this.series.userOptions.danWi;
			    	}
			    },
			    plotOptions: {
			        series: {
			        	innerSize: pieInnerSize,
			            depth: 35,
			            dataLabels: {
			                enabled: true,
					    	formatter: function() {
					    		return this.point.name+' : '+commaWon(this.point.y)+' '+this.series.userOptions.danWi;
					    	}
			            },
			            showInLegend: true
			        }
			    },
			    series: [valSeries],/*[{
			        name: selectWrtNm,
			        colorByPoint: true,
			        data: valSeries
			    }]*/
			    legend: { enabled: true, maxHeight: 60 },
			    lang: {thousandsSep: ','}, //천단위 콤마 처리
			    credits:{enabled : false},
			    navigation: { buttonOptions:{enabled: false}},
			    exporting: {
			        enabled: false
			    }
			});
		}
    	
    },

	/* -----------------------------------------------------------------------------------------------------------------------
	 * makeChartTreemap
	 * ----------------------------------------------------------------------------------------------------------------------- */	
    makeChartTreemap : function(){   

    	var $window = $(window);
		var objTab = getTabShowObj();// 탭이 open된 객체가져옴
		var formObj = chartCallMark != "S" ? objTab.find("form[name=statsEasy-mst-form]") : $('form[name="statsEasy-mst-form"]');
		var chartId = "";
		if(chartCallMark != "S"){
			chartId = formObj.find($(".chart.statEasyChart")).attr('id');
			sliderId = formObj.find($(".statSlider")).attr('id');
		}else{
			chartId = "statChart";
			sliderId =  "slider";
		}
    	$("#"+sliderId).hide(); //slider비활성화
		
		var selectWrtNm = formObj.find($("select[name='chartCategories'] option:selected")).text();

		hightChart = new Highcharts.chart(chartId, {
			title: { text: selectWrtNm },
			credits:{enabled : false},
		    tooltip: { shared: true, 
	    		formatter: function(){
	    			if(this.key != undefined){
		    			if(this.points == undefined){
		    				return '<b>'+this.key+':</b>  ' + commaWon(this.point.value)+' '+this.point.danWi;
		    			}else{
		    				return '<b>'+this.key+':</b>  ' + commaWon(this.points.value)+' '+this.points.danWi;
		    			}
	    			}
	    		}
		    },	
	        series: [{
	            type: "treemap",
	            layoutAlgorithm: 'stripes',
	            allowDrillToNode: true,
	            alternateStartingDirection: true,
	            levelIsConstant: false,
	            dataLabels: {
	                enabled: false
	            },
	            levels: [{
	                level: 1,
	                layoutAlgorithm: 'sliceAndDice',
	                dataLabels: {
	                    enabled: true,
	                    style: {
	                        fontSize: '15px',
	                        fontWeight: 'bold',
	                        cursor: 'pointer'
	                    }
	                }
	            }],
	            data: valSeries
	        }],
	        exporting: {
		        enabled: false
		    }
		});
		
    },

	/* -----------------------------------------------------------------------------------------------------------------------
	 * makeChartSpiderweb
	 * ----------------------------------------------------------------------------------------------------------------------- */	
    makeChartSpiderweb : function(){   

    	var $window = $(window);
		var objTab = getTabShowObj();// 탭이 open된 객체가져옴
		var formObj = chartCallMark != "S" ? objTab.find("form[name=statsEasy-mst-form]") : $('form[name="statsEasy-mst-form"]');
		var chartId = "";
		if(chartCallMark != "S"){
			chartId = formObj.find($(".chart.statEasyChart")).attr('id');
			sliderId = formObj.find($(".statSlider")).attr('id');
		}else{
			chartId = "statChart";
			sliderId =  "slider";
		}
    	$("#"+sliderId).hide(); //slider비활성화
    	
		var selectWrtNm = formObj.find($("select[name='chartCategories'] option:selected")).text();

/*		console.log("[ makeChartSpiderweb ] 데이터 콘솔 확인");
    	console.log("chartId:"+chartId);
    	console.log(selectWrtNm);
    	console.log(spiderwebCate);
    	console.log(valSeries);*/
    	
    	var markerEnabled = true;
    	if(spiderwebCate.length > 2) markerEnabled = false;
    	
		//차트 옵션
		Highcharts.setOptions({
			plotOptions: {	
				line: { dataLabels: { enabled: false }, marker: { enabled: markerEnabled } },
			}
		});
		
    	hightChart = new Highcharts.chart(chartId, {	
			chart: {
		        polar: true,
		        type: 'line'
		    },
		    title: { text: selectWrtNm }, 
		    xAxis: { categories: spiderwebCate, tickmarkPlacement: 'on', lineWidth: 0 },
		    yAxis: { gridLineInterpolation: 'polygon', lineWidth: 0, min: 0 },
		    tooltip: { shared: true, 
		    		formatter: function(){
		    			return '<b>'+this.x.name+':</b> '+commaWon(this.y)+' '+this.x.userOptions.danWi+'<br/>';
		    		}
		    },	
		    credits:{enabled : false},
		    exporting: { enabled: false },
		    series: valSeries
		});
		
    },

	/* -----------------------------------------------------------------------------------------------------------------------
	 * makeChartSunburst
	 * ----------------------------------------------------------------------------------------------------------------------- */	
    makeChartSunburst : function(){   

    	var $window = $(window);
		var objTab = getTabShowObj();// 탭이 open된 객체가져옴
		var formObj = chartCallMark != "S" ? objTab.find("form[name=statsEasy-mst-form]") : $('form[name="statsEasy-mst-form"]');
		var chartId = "";
		if(chartCallMark != "S"){
			chartId = formObj.find($(".chart.statEasyChart")).attr('id');
			sliderId = formObj.find($(".statSlider")).attr('id');
		}else{
			chartId = "statChart";
			sliderId =  "slider";
		}
    	$("#"+sliderId).hide(); //slider비활성화
    	
/*		console.log("[ makeChartSunburst ] 데이터 콘솔 확인");
    	console.log("chartId:"+chartId);
    	console.log(valSeries);*/
    	
		Highcharts.getOptions().colors.splice(0, 0, 'transparent');
		
		hightChart = new Highcharts.chart(chartId, {	
		    title: { text: '' },
		    series: [{
		        type: "sunburst",
		        data: valSeries,
		        allowDrillToNode: true,
		        cursor: 'pointer',
		        dataLabels: {
		            format: '{point.name}',
		            filter: {
		                property: 'innerArcLength',
		                operator: '>',
		                value: 16
		            }
		        },
		        levels: [
		                 { level: 1, levelIsConstant: false, dataLabels: { filter: { property: 'outerArcLength', operator: '>', value: 164 },
			                rotationMode: 'parallel'	// rotationMode 의 기본값은 auto 인데, level 1 의 dataLabel (sunburst 차트의 가장 가운데 나타나는 글씨) 이 세로로 나오는 경우가 있어서 parallel 로 명시함 
		                    }
		                 }, 
		                 { level: 2, colorByPoint: true },
		                 { level: 3, colorVariation: { key: 'brightness', to: -0.5 } }, 
		                 { level: 4, colorVariation: { key: 'brightness', to: 0.5 } }
		        ]

		    }],
		    tooltip: { shared: true, pointFormat: '<b>{point.name} :</b> {point.value} {point.danWi}<br/>' },	
		    credits:{enabled : false},
		    exporting: {
		        enabled: false
		    }		    
		});
		
    },
    
	/* -----------------------------------------------------------------------------------------------------------------------
	 * makeChartColumn : 시계열이 한개 일 경우 항목을 X축값으로 잡는다. Column만 가능함.
	 * ----------------------------------------------------------------------------------------------------------------------- */	
    makeChartColumn : function(uiNm, wrttimeIdtfrNm){   

		var objTab = getTabShowObj();// 탭이 open된 객체가져옴
		var formObj = chartCallMark != "S" ? objTab.find("form[name=statsEasy-mst-form]") : $('form[name="statsEasy-mst-form"]');
		var chartId = "";
		if(chartCallMark != "S"){
			chartId = formObj.find($(".chart.statEasyChart")).attr('id');
			sliderId = formObj.find($(".statSlider")).attr('id');
		}else{
			chartId = "statChart";
			sliderId =  "slider";
		}
		$("#"+sliderId).hide(); //slider비활성화
		
/*		console.log("[ makeChartColumn ] 데이터 콘솔 확인");
    	console.log("chartId:"+chartId);
    	console.log(uiNm);
    	console.log(wrttimeIdtfrNm);
    	console.log(valSeries);*/
		
		//차트 3D 여부
		var isThreeD = false;
		if(formObj.find("input[name=chart23Type]").val() == "3D") isThreeD = true;
		
		Highcharts.setOptions({ plotOptions: { series: { stacking: 'normal'} } });
		
		hightChart = Highcharts.chart(chartId, {
		    chart: {
		        type: 'column',
		        options3d: { enabled: isThreeD, alpha: 45, beta: 0 }
		    },
		    title: { text: '' },
		    xAxis: {
		        type: 'category',
		        labels: {
		            rotation: -45,
		            style: {
		                fontSize: '11px',
		                fontFamily: 'Verdana, sans-serif',
		                fontWeight: 'bold'
		            }
		        }
		    },
		    yAxis: {
		        title: {
		            text: uiNm
		        }
		    },
		    legend: {
		        enabled: false
		    },
		    tooltip: {
		    	formatter: function() {
		    		return this.key+' : '+commaWon(this.y)+' '+uiNm;
		    	}
		    },
		    series: [{
		        name: wrttimeIdtfrNm,
		        data: valSeries
		    }],
		    lang: {thousandsSep: ','}, //천단위 콤마 처리
		    credits:{enabled : false},
		    exporting: {
		        enabled: false
		    }
		});
		
    },

    /* =================================================================================================
     * 챠트 종류에 따른 화면 노출 처리 - 지도서비스
     * ================================================================================================= */
    
	/* -----------------------------------------------------------------------------------------------------------------------
	 * makeMap 지도서비스
	 * ----------------------------------------------------------------------------------------------------------------------- */	
    makeMap: function(chartId, mode, code, name, parentCode, parentName) {
    	
    	var mapData;
    	
    	// 지도 label 위치 조정 참고 - https://www.highcharts.com/maps/demo/geojson-multiple-types
    	
    	// 시도
    	if (mode === 'sido') {
    		// 지도를 위한 데이터는 code 와 value 로 구성됨
        	/*mapProcessData = [{"code":"11","value":10.4},{"code":"26","value":65.2}];*/

    		$.getJSON('/js/common/geojson/sido.json', function(mapData) {
    			mapData = Highcharts.geojson(mapData, 'map');
    			
    			// geojson loop
    			$.each(mapData, function() {
    				// 지도 label 위치 조정
    				if (this.properties.code === '28') {		// 인천광역시
    					this.middleX = 0.8;
    				} else if (this.properties.code === '41') {	// 경기도
    					this.middleY = 0.7;
    				} else if (this.properties.code === '47') {	// 경상북도
    					this.middleX = 0.25;
    					this.middleY = 0.6;
    				}
    				
    				var item = _.find(mapProcessData, {	// 지도를 위한 데이터에서 현재 loop 의 geojson 과 code 가 맞는 item 을 찾음
    					code: this.properties.code
    				});
    				
    				this.unit = mapChgUiNm;	// tooltip 에서 사용하기 위해서 넣음
    				
    				if(item != undefined){
    					this.value = item.value;	// 데이터 설정
    				}else{
    					this.value = 0;
    				}
    			});
        		
        		drawMap(chartId, mapData, code, name, parentCode, parentName);
    		});
    	}
    	// 시군구
    	else if (mode === 'sigungu') {
    		$.getJSON('/js/common/geojson/sigungu.json', function(mapData) {
    			var newMapData = $.extend({}, mapData);	// 전체 시군구 복사
    			newMapData.features = [];				// 전체 시군구에서 선택한 시군구만 새로 생성하기 위해 features 를 비움
        		
        		_.forEach(mapData.features, function(item) {
        			if (item.properties.code.substr(0, 2) === code) {
        				// geojson 영역 생성
        				newMapData.features.push(item);
        			}
        		});
        		
        		newMapData = Highcharts.geojson(newMapData, 'map');
        		
        		// geojson loop
        		$.each(newMapData, function() {
    				// 지도 label 위치 조정
    				
    				var item = _.find(mapProcessData, {	// 지도를 위한 데이터에서 현재 loop 의 geojson 과 code 가 맞는 item 을 찾음
    					code: this.properties.code
    				});
    				
    				this.unit = mapChgUiNm;	// tooltip 에서 사용하기 위해서 넣음
    				
    				if(item != undefined){
    					this.value = item.value;	// 데이터 설정
    				}else{
    					this.value = 0;
    				}
    				
    				// random 데이터 생성 - 지역별로 예시 데이터를 생성해놓기 어려워서 random 데이터를 사용하였습니다.
    				// 실제로 필요한 데이터 형태는 "시도" mode === 'sido' 인 경우의 mapChart 데이터와 같습니다.
    				// mapProcessData 로 "시도" 의 geojson loop 내에서처럼 code 가 일치하는 item 을 찾아 value 를 넣어주면 됩십니다.
    				//this.value = parseFloat(Math.random() * 1000, 10) / 10;
    			});
        		
        		drawMap(chartId, newMapData, code, name, parentCode, parentName);
    		});
    	}
    	// 읍면동
    	else if (mode === 'emd') {
    		var sidoCode = code.substr(0, 2);
    		
    		$.getJSON('/js/common/geojson/emd_' + sidoCode + '.json', function(mapData) {
    			var newMapData = $.extend({}, mapData);	// 선택한 시도의 전체 읍면동 복사
    			newMapData.features = [];				// 선택한 시도의 전체 읍면동에서 선택한 시군구의 읍면동만 새로 생성하기 위해 features 를 비움
        		
        		_.forEach(mapData.features, function(item) {
        			if (item.properties.code.substr(0, 5) === code) {
        				// geojson 영역 생성
        				newMapData.features.push(item);
        			}
        		});
        		
        		newMapData = Highcharts.geojson(newMapData, 'map');
        		
        		// geojson loop
        		$.each(newMapData, function() {
    				// 지도 label 위치 조정
    				
    				var item = _.find(mapProcessData, {	// 지도를 위한 데이터에서 현재 loop 의 geojson 과 code 가 맞는 item 을 찾음
    					code: this.properties.code
    				});
    				
    				this.unit = mapChgUiNm;	// tooltip 에서 사용하기 위해서 넣음
    				
    				if(item != undefined){
    					this.value = item.value;	// 데이터 설정
    				}else{
    					this.value = 0;
    				}
    				
    				//this.unit = mapChgUiNm;
    				
    				// random 데이터 생성 - 지역별로 예시 데이터를 생성해놓기 어려워서 random 데이터를 사용하였습니다.
    				// 실제로 필요한 데이터 형태는 "시도" mode === 'sido' 인 경우의 mapChart 데이터와 같습니다.
    				// mapProcessData 로 "시도" 의 geojson loop 내에서처럼 code 가 일치하는 item 을 찾아 value 를 넣어주면 됩십니다.
    				//this.value = parseFloat(Math.random() * 1000, 10) / 10;
    			});
        		
        		drawMap(chartId, newMapData, code, name, parentCode, parentName);
    		});
    	}
    	// 세계지도
    	else if (mode === 'world') {
    		// 세계지도를 위한 데이터는 CountryCode 와 value 로 구성됨 - 혹시 국내지도와 데이터 일관성을 위해 CountryCode 를 code 로 변경하셔야 하시는 경우
    		// /js/common/geojson/pacific_centered_world.json 파일에서 CountryCode 를 모두 code 로 변경해주시면 되십니다.
    		//mapProcessData = [{"CountryCode":"ARE","value":87.4},{"CountryCode":"AFG","value":21.7},{"CountryCode":"ALB","value":69.1},{"CountryCode":"ARM","value":12.6},{"CountryCode":"AGO","value":1.7},{"CountryCode":"ARG","value":8.1},{"CountryCode":"AUT","value":59.2},{"CountryCode":"AUS","value":11.5},{"CountryCode":"AZE","value":67.8},{"CountryCode":"BIH","value":57.8},{"CountryCode":"BGD","value":17.3},{"CountryCode":"BEL","value":48.2},{"CountryCode":"BFA","value":81.7},{"CountryCode":"BGR","value":48.4},{"CountryCode":"BDI","value":12.3},{"CountryCode":"BEN","value":50},{"CountryCode":"BRN","value":36.8},{"CountryCode":"BOL","value":6.7},{"CountryCode":"BRA","value":95.3},{"CountryCode":"BHS","value":87.6},{"CountryCode":"BTN","value":31.5},{"CountryCode":"BWA","value":99.9},{"CountryCode":"BLR","value":51.7},{"CountryCode":"BLZ","value":34.1},{"CountryCode":"CAN","value":64.7},{"CountryCode":"ZAR","value":85.3},{"CountryCode":"CAF","value":68.6},{"CountryCode":"COG","value":97.6},{"CountryCode":"CHE","value":77.3},{"CountryCode":"CIV","value":26.8},{"CountryCode":"CHL","value":84.9},{"CountryCode":"CMR","value":28.5},{"CountryCode":"CHN","value":61},{"CountryCode":"COL","value":78.3},{"CountryCode":"CRI","value":21.8},{"CountryCode":"CUB","value":4.9},{"CountryCode":"CYP","value":11.7},{"CountryCode":"CZE","value":22.6},{"CountryCode":"DEU","value":0.3},{"CountryCode":"DJI","value":73},{"CountryCode":"DNK","value":89.3},{"CountryCode":"DOM","value":53.2},{"CountryCode":"DZA","value":61.3},{"CountryCode":"ECU","value":83.4},{"CountryCode":"EST","value":7.6},{"CountryCode":"EGY","value":84.8},{"CountryCode":"","value":80.8},{"CountryCode":"ERI","value":3.2},{"CountryCode":"ESP","value":15.4},{"CountryCode":"ETH","value":46.8},{"CountryCode":"","value":56.6},{"CountryCode":"FIN","value":63},{"CountryCode":"FJI","value":58.7},{"CountryCode":"FRA","value":64.2},{"CountryCode":"GAB","value":59.8},{"CountryCode":"GBR","value":13.4},{"CountryCode":"GEO","value":81.8},{"CountryCode":"","value":46.1},{"CountryCode":"GHA","value":52.7},{"CountryCode":"GRL","value":41},{"CountryCode":"GMB","value":79.3},{"CountryCode":"GIN","value":31.3},{"CountryCode":"GNQ","value":18.4},{"CountryCode":"GRC","value":95.6},{"CountryCode":"GTM","value":55.8},{"CountryCode":"GNB","value":88.2},{"CountryCode":"GUY","value":62.4},{"CountryCode":"HND","value":27.1},{"CountryCode":"HRV","value":84.3},{"CountryCode":"HTI","value":25.4},{"CountryCode":"HUN","value":76.3},{"CountryCode":"IDN","value":91.4},{"CountryCode":"IRL","value":27.6},{"CountryCode":"ISR","value":37.3},{"CountryCode":"IND","value":61.5},{"CountryCode":"IRQ","value":16.7},{"CountryCode":"IRN","value":36.2},{"CountryCode":"ISL","value":46.7},{"CountryCode":"ITA","value":86.1},{"CountryCode":"JAM","value":58},{"CountryCode":"JOR","value":39.7},{"CountryCode":"JPN","value":6.7},{"CountryCode":"KEN","value":56.9},{"CountryCode":"KGZ","value":41.8},{"CountryCode":"KHM","value":85.9},{"CountryCode":"PRK","value":36.2},{"CountryCode":"KOR","value":4.5},{"CountryCode":"KSV","value":88.7},{"CountryCode":"KWT","value":79},{"CountryCode":"KAZ","value":21},{"CountryCode":"LAO","value":56.4},{"CountryCode":"LBN","value":44.8},{"CountryCode":"LKA","value":6.3},{"CountryCode":"LBR","value":44.9},{"CountryCode":"LSO","value":85.7},{"CountryCode":"LTU","value":12.6},{"CountryCode":"LUX","value":69},{"CountryCode":"LBY","value":65.6},{"CountryCode":"LVA","value":25.4},{"CountryCode":"MAR","value":54},{"CountryCode":"MDA","value":6.1},{"CountryCode":"MNE","value":86.6},{"CountryCode":"MDG","value":22.9},{"CountryCode":"MKD","value":96},{"CountryCode":"MLI","value":91.9},{"CountryCode":"MMR","value":57.4},{"CountryCode":"MNG","value":48.3},{"CountryCode":"MUS","value":30.5},{"CountryCode":"MWI","value":42.1},{"CountryCode":"MEX","value":48.3},{"CountryCode":"MYS","value":73.9},{"CountryCode":"MOZ","value":11},{"CountryCode":"NAM","value":89.1},{"CountryCode":"NCL","value":72.4},{"CountryCode":"NER","value":4.5},{"CountryCode":"NGA","value":94.7},{"CountryCode":"NIC","value":20.5},{"CountryCode":"NLD","value":33.2},{"CountryCode":"NOR","value":73.7},{"CountryCode":"NPL","value":23.6},{"CountryCode":"NZL","value":47.6},{"CountryCode":"OMN","value":31.7},{"CountryCode":"PAN","value":3.3},{"CountryCode":"PER","value":12.6},{"CountryCode":"PNG","value":75.1},{"CountryCode":"PHL","value":7.1},{"CountryCode":"PAK","value":0.8},{"CountryCode":"POL","value":46.5},{"CountryCode":"PRI","value":52.5},{"CountryCode":"","value":9.8},{"CountryCode":"PRT","value":69.2},{"CountryCode":"PRY","value":90.4},{"CountryCode":"QAT","value":84.7},{"CountryCode":"ROM","value":75.7},{"CountryCode":"SRB","value":95},{"CountryCode":"RUS","value":60.1},{"CountryCode":"RWA","value":22},{"CountryCode":"SAU","value":40.7},{"CountryCode":"SLB","value":70.1},{"CountryCode":"SDN","value":0.6},{"CountryCode":"SWE","value":82.9},{"CountryCode":"SVN","value":44.4},{"CountryCode":"","value":42.3},{"CountryCode":"SVK","value":50.4},{"CountryCode":"SLE","value":87.2},{"CountryCode":"SEN","value":89.6},{"CountryCode":"SOM","value":63.8},{"CountryCode":"SUR","value":87.1},{"CountryCode":"SSD","value":22.5},{"CountryCode":"SLV","value":79.1},{"CountryCode":"SYR","value":97.5},{"CountryCode":"SWZ","value":40.2},{"CountryCode":"TCD","value":34.7},{"CountryCode":"","value":84.3},{"CountryCode":"TGO","value":97.9},{"CountryCode":"THA","value":46.8},{"CountryCode":"TJK","value":90.5},{"CountryCode":"TMP","value":0.9},{"CountryCode":"TKM","value":54.7},{"CountryCode":"TUN","value":78.6},{"CountryCode":"TUR","value":93},{"CountryCode":"TTO","value":67.5},{"CountryCode":"TWN","value":86},{"CountryCode":"TZA","value":73},{"CountryCode":"UKR","value":89.2},{"CountryCode":"UGA","value":18.1},{"CountryCode":"USA","value":42.3},{"CountryCode":"URY","value":52.8},{"CountryCode":"UZB","value":43},{"CountryCode":"VEN","value":71.1},{"CountryCode":"VNM","value":48.9},{"CountryCode":"VUT","value":56.9},{"CountryCode":"YEM","value":43.4},{"CountryCode":"ZAF","value":12.7},{"CountryCode":"ZMB","value":27},{"CountryCode":"ZWE","value":62.1}];
    		
    		$.getJSON('/js/common/geojson/pacific_centered_world.json', function(mapData) {
    			
    			// geojson loop
    			$.each(mapData, function() {
    				// 지도 label 위치 조정
    				
    				var item = _.find(mapProcessData, {	// 지도를 위한 데이터에서 현재 loop 의 geojson 과 CountryCode 가 맞는 item 을 찾음
    					CountryCode: this.CountryCode	// 국내지도는 item.properties.code 인데 세계지도는 geojson 형태가 달라서 item.CountryCode 입니다.
    				});
    				
    				this.unit = mapChgUiNm;	// tooltip 에서 사용하기 위해서 넣음
    				if(item != undefined){
    					this.value = item.value;	// 데이터 설정
    				}else{
    					this.value = null;
    				}
    			});
        		
        		drawMap(chartId, mapData, code, name, parentCode, parentName);
    		});
    	}
    	
    	function drawMap(chartId, mapData, code, name, parentCode, parentName) {
    		
    		$('#' + chartId).empty();
    		
    		// xAxis 에 min, max 값이 설정되면 지도의 위치가 움직이는데 다른 차트에서 설정되는 경우가 있으므로 지도를 그리기 전에 초기화함
    		Highcharts.setOptions({ xAxis: { min:undefined, max:undefined } });  
    		
    		hightMap =  new Highcharts.mapChart(chartId, {
    			chart: {
    				animation: false,
    				events: {
    					load: function() {
    						if (mode === 'world') {		// 세계지도의 경우 상위지역으로 복귀하기 위한 버튼 생성하지 않음
    							return;
    						}
    						
    						if (!code) {
    							name = '';
    							parentCode = '';
    							parentName = '전국';
    						}
    						
    						// 상위지역으로 복귀하기 위한 버튼 생성
    						if (mode === 'sido') {	// 시도의 경우 버튼 생성하지 않음
    							return;
    						} else {
    							var button = $('<button />', {
	    								type: 'button'
	    							})
    								.text('< ' + parentName)
    								.css({
    									position: 'absolute',
    									top: '170px',
    									right: '20px',
    									padding: '5px',
    									border: '1px solid #ccc',
    									backgroundColor: '#efefef',
    									borderRadius: '2px',
    									zIndex: 10
    								})
    								.appendTo('#' + chartId)
    								.on('click', function() {
    									var chartLoad = new StatCharts(); //차트 JS함수 정의 statCharts.js
    									
    									// 전국 지도 생성
    									if (!parentCode) {
    										chartLoad.makeMap(chartId, 'sido');
    									} else {
    										chartLoad.makeMap(chartId, 'sigungu', parentCode, parentName, '', '전국');
    									}
    								});
    						}
    					}
    				}
    			}, 
    			exporting: { enabled: false },
    			title: { text: '' },
    			mapNavigation: {
    	    		enabled: true, //+ - 버튼 안보이기
    	    		buttonOptions: {
    	    	    	verticalAlign: 'bottom'
    	    	    }
    			},
    	    	legend: {
    	        	align: 'left',
    	            verticalAlign: 'top',
    	            layout: 'vertical' 
    	        },
    	        colorAxis: { },
    	        plotOptions: {
    	        	series: {
    	        		events: {
    		        		click: function(e) {
    		        			var newMode,
    		        				parentCode,
    		        				parentName;
    		        			
    		        			if (mode === 'sido') {				// 현재 지도가 시도인 경우
    		        				newMode = 'sigungu';			// 클릭시 생성되는 지도는 시군구
    		        				parentCode = '';
    		        				parentName = '전국';
    		        			} else if (mode === 'sigungu') {	// 현재 지도가 시군구인 경우
    		        				newMode = 'emd';				// 클릭시 생성되는 지도는 읍면동
    		        				parentCode = code;
    		        				parentName = name;
    		        			} else {							// 읍면동의 경우 지도 클릭 이벤트 없음
    		        				return;
    		        			}
    		        			
    		        			var chartLoad = new StatCharts(); //차트 JS함수 정의 statCharts.js
    		        			chartLoad.makeMap(chartId, newMode, e.point.properties.code, e.point.properties.name, parentCode, parentName);
    		        		}
    		        	}
    	        	}
    	        },
    	       	series: [{
    	       		type: 'map',
    	    		data: mapData,
    			    states: {
    	    	    	hover: { color: '#BADA55' }
    	    	    },
    	    	    nullColor: 'white',
    	    	    dataLabels: {
    	    	    	enabled: (mode === 'world' ? false : true),		// 세계지도인 경우에는 너무 빽빽하여 보기 좋지 않아 지역 위에 레이블을 표시하지 않았습니다. 수정하셔도 되십니다.
    	    	    	format: '{point.name}', 
    	    	    	style: {
    	            		color: '#000000',
    	            		textOutline : 'none'
    	            	},
    	            	allowOverlap: true 
    	    	    },
	    	    	tooltip: {
	    	    		headerFormat: '',
	                	pointFormat: '{point.name} : {point.value}  {point.unit}'
	                }
    	    	}],
    	    	credits:{enabled : false}
    		});
    	}
    }

};

//원단위 콤마
function commaWon(n){
 	  var reg = /(^[+-]?\d+)(\d{3})/;   // 정규식
	 	  n += '';                          // 숫자를 문자열로 변환

	 	  while (reg.test(n))
	 	    n = n.replace(reg, '$1' + ',' + '$2');

	 	  return n;
}

/**
 * 지도서비스 관련 글로벌변수 설정
 */
var mapProcessData = new Array(); //조건에 따른 지도데이터
var mapChgUiNm = "";
// 지도서비스 화면 로딩
function loadMap(divId, mapVal, displayType){
	
	var objTab = getTabShowObj();// 탭이 open된 객체가져옴
	var formObj = displayType == "T" ? objTab.find("form[name=statsEasy-mst-form]") : $('form[name="statsEasy-mst-form"]');
	var param = "";
	if(displayType == "T"){
		param = "divId="+divId+"&mapVal="+mapVal+"&displayType="+displayType+"&"+formObj.serialize();
	}else{
		param = "divId="+divId+"&mapVal="+mapVal+"&displayType="+displayType+"&statblId="+$("#sId").val()+"&"+formObj.serialize();
	}
	//간편/복수통계에 대한 구분 처리는 Controller에서 처리한다.
	doAjax({
		//url : "/portal/stat/statEasyChartJson.do",
		url : "/portal/stat/statMapDataJson.do",
		params : param,
		callback : afterStatMap
	});
}

function afterStatMap(res) {
	var data = res.data;
	
	var mapDivId = data.divId;
	var displayType = data.displayType;
	var mapVal = data.mapVal;
	
	/****** 데이터를 확인하여 가공한다. [차트 정보와 동일하게 처리] ******/
	$.each(data.OPT_DATA, function(key, value){
		if(value.optCd == "DC") dtacycleCd = value.optVal;
	});
	
	//data를 확인하여 자료시점 정보 확인용 변수 선언.
	var valCategories = new Array();
	var valItmDataNo = "";
	var valClsDataNo = "";
	var valItmGeoCd = "";
	var valClsGeoCd = "";
	$.each(data.MAP_DATA, function(key, value){
		if(value.DTADVS_CD = "OD"){ //맵은 원자료만 처리한다.
			
			//자료시점(WRTTIME)을 배열에 담는다.
			var wrttimeNm = makeWrttimeNm(value.YYYY, value.XX);
			valCategories.push(wrttimeNm);
			
			//분류(CLS) 데이터 여부확인
			if(value.CLS_DATANO != null) chartClsDataYn = "Y";
			valItmDataNo = value.ITM_DATANO;
			valClsDataNo = value.CLS_DATANO;
			valItmGeoCd = value.ITM_GEO_CD;
			valClsGeoCd = value.CLS_GEO_CD;
			mapChgUiNm = value.CHG_UI_NM;
		}
	});
	
	//자료시점(WRTTIME) 데이터의 중복을 제거한다.
	var uniqCategories = valCategories.reduce(function(a, b){if(a.indexOf(b) < 0) a.push(b);return a;},[]);
	
	/****** 데이터에 따른 맵화면 처리 및 이벤트를 처리한다. ******/	
	var objTab = getTabShowObj();// 탭이 open된 객체가져옴
	var formObj = displayType == "T" ? objTab.find("form[name=statsEasy-mst-form]") : $('form[name="statsEasy-mst-form"]');

	//자료시점 화면 노출 및 설정
	formObj.find($("select[name='mapCategories'] option")).remove();
	var opCategorie = "";
	for(var i=0; i<uniqCategories.length; i++){
		var wrttimeIdtfrId = makeWrttimeId(uniqCategories[i]);
		var option = $("<option value='"+wrttimeIdtfrId+"'>"+uniqCategories[i]+"</option>");
		formObj.find($("select[name='mapCategories']")).prepend(option);
		opCategorie = wrttimeIdtfrId;
	}
	formObj.find("select[name=mapCategories] > option[value='"+ opCategorie +"']").attr("selected", "true");

	// 자료시점 콤보 변경
	formObj.find($("select[name='mapCategories']")).change(function() {
		var selCategorie = formObj.find($("select[name='mapCategories'] option:selected")).val();
		var selItm = formObj.find($("select[name='mapItms'] option:selected")).val();

		mapDataCall(mapDivId, mapVal, formObj, data.MAP_DATA, selCategorie, selItm, valItmGeoCd, valClsGeoCd, displayType);
		//alert("지도서비스 다시 읽는다. 자료시점 선택변경 / selCategorie : " + selCategorie + " / selItm : " + selItm +  "/ valItmGeoCd : " + valItmGeoCd + " / valClsGeoCd : " + valClsGeoCd);
	});
	
	var opItm = "";
	//항목 || 분류 모두 있으면 콤보를 화면 노출 및 설정
	if(valItmDataNo != null && valClsDataNo != null){
		var valItms = new Array();
		$.each(data.MAP_DATA, function(key, value){
			//자료시점(WRTTIME)을 배열에 담는다.
			var targetItm = "";
			if(opCategorie == value.WRTTIME_IDTFR_ID){
				if(valItmGeoCd == null) targetItm = value.ITM_ITM_NM;
				if(valClsGeoCd == null) targetItm = value.CLS_ITM_NM;
				valItms.push(targetItm);	
			}
		});
		
		//항목 || 분류 데이터의 중복을 제거한다.
		var uniqItms = valItms.reduce(function(a, b){if(a.indexOf(b) < 0) a.push(b);return a;},[]);
		
		formObj.find($("select[name='mapItms']")).show();
		formObj.find($("select[name='mapItms'] option")).remove();
		for(var i=0; i<uniqItms.length; i++){
			var option = $("<option value='"+uniqItms[i]+"'>"+uniqItms[i]+"</option>");
			formObj.find($("select[name='mapItms']")).append(option);
			if(i==0) opItm = uniqItms[i];
		}
		formObj.find("select[name=mapItms] > option[value='"+ opItm +"']").attr("selected", "true");
		
		// 항목 콤보 변경
		formObj.find($("select[name='mapItms']")).change(function() {
			var selCategorie = formObj.find($("select[name='mapCategories'] option:selected")).val();
			var selItm = formObj.find($("select[name='mapItms'] option:selected")).val();

			mapDataCall(mapDivId, mapVal, formObj, data.MAP_DATA, selCategorie, selItm, valItmGeoCd, valClsGeoCd, displayType);
			//alert("지도서비스 다시 읽는다. 자료시점 선택변경 / selCategorie : " + selCategorie + " / selItm : " + selItm +  "/ valItmGeoCd : " + valItmGeoCd + " / valClsGeoCd : " + valClsGeoCd);
		});
	}else{
		formObj.find($("select[name='mapItms']")).hide();
	}
	
	//$('#' + mapDivId).height(669);
	
	mapDataCall(mapDivId, mapVal, formObj, data.MAP_DATA, opCategorie, opItm, valItmGeoCd, valClsGeoCd, displayType); // 시도 데이터 생성
}

//차트를 위한 데이터를 생성한다.
function mapDataCall(mapDivId, mapVal, formObj, mapJsonData, opCategorie, opItm, valItmGeoCd, valClsGeoCd, displayType){
	mapProcessData = new Array();
	mapChgUiNm = "";
	
	var itmSelVal = "N";
	var clsSelVal = "N";
	if(valItmGeoCd != null && opItm != "") clsSelVal = "Y";
	if(valClsGeoCd != null && opItm != "") itmSelVal = "Y";
	
	// 기간
	var formData = formObj.serialize();
	var addData = "";
	if(displayType == "T"){
		addData = "&opCategorie="+opCategorie+"&itmSelVal="+itmSelVal+"&clsSelVal="+clsSelVal+"&opItm="+opItm;
	}else{
		addData = "&opCategorie="+opCategorie+"&itmSelVal="+itmSelVal+"&clsSelVal="+clsSelVal+"&opItm="+opItm+"&statblId="+$("#sId").val();
	}
	
	$.ajax({
		type : 'POST',
		dataType : 'json',
		async : false,
		url : com.wise.help.url("/portal/stat/statMapJsonDetail.do"),
		data : formObj.serialize() + addData,
		success : function(map) {
			mapProcessData = map.data;
			if( mapProcessData.length > 0 ){
				mapChgUiNm = mapProcessData[0].danWi;
				
				var chartLoad = new StatCharts(); //차트 JS함수 정의 statCharts.js
				if(mapVal == "KOREA"){
					chartLoad.makeMap(mapDivId, 'sido'); // 차트 생성 - 시도
				}
				if(mapVal == "WORLD"){
					chartLoad.makeMap(mapDivId, 'world'); // 차트 생성 - 세계지도
				}
			}
			
		}
	});
}

//시계열 선택 정보 확인
function selCgData(){
	var objTab = getTabShowObj();// 탭이 open된 객체가져옴
	
	var formObj = chartCallMark == "T" ? objTab.find("form[name=statsEasy-mst-form]") : $('form[name="statsEasy-mst-form"]');
	
	var selCategories = formObj.find($("select[name='chartCategories'] option:selected")).val();

	return selCategories;
}

//차트 or 맵의 DIV에 따라 사이즈 변경한다.
function chartResize(chartId){
    var resizeChart = $('#'+chartId).highcharts();
    var w = $('#'+chartId).closest(".wrapper").width();  
    
    if ( isMobile ) {
    	var hh = $(window).height();
    	var isWidePC = $('body').hasClass('wide');	// PC에서 전체화면 여부(true면 전체화면)
    	var isWideMobile = $("body").hasClass("wideMobile");	// 모바일에서 전체화면여부(true면 전체화면)
    	var chartHeight = isMobile ? hh-450 : hh-285; 
    	if ( isWideMobile || chartHeight <= 0 ) {	// 모바일 전체화면일경우 화면사이즈 늘림
    		chartHeight = chartHeight + 300;
    	}
    	resizeChart.setSize(w, chartHeight, false );
    }
    else {
    	resizeChart.setSize( w,w * (3/4),false );
    }
}

//차트 & 맵 전역변수 초기화
function resetGlobal(){
	hightChart = "";
	hightMap = "";
	isChartMobile = $(window).width() <= 980 ? true : false; // 모바일 접근 여부
	chartData = "";		//차트 데이터
	chartTgData = "";	//차트 항목 및 분류 정보
	//chartSaData = "";	//차트 항목 및 분류 중 > 합계및평균여부 Y가 아닌 데이터
	chartWrData = "";  //차트 데이터 시계열 정보
	directDivid = "";
	dtacycleCd = "";
	chartTypes = "";
	chartSid = "";
	chartCallMark = "T";
	chartClsDataYn = "N";
	yAxisData = new Array();
	valSeries = new Array();
	drillDown = new Array();
	chartItmData = new Array();
	chartClsData = new Array();
	chartWrClsData = new Array();
	chartWrOneData = new Array();
	chartOneData = "";
	chartSaOneDAta = "";
	spiderwebCate = new Array();
	seriesVisible = {};
}

//시계열이 1개인 경우 막대차트 만 노출한다.
function goItmChart(){
	
	selCategories = selCgData();
	
	var targetData = new Array();
	$.each(chartData, function(key, value){
		if(selCategories == value.WRTTIME_IDTFR_ID.substring(0,4)) targetData.push(value);
	});
	
/*	//select 선택을 통해서 넘어온 경우 data를 다시 호출한다.
	if(selCategories != ""){
		var paramData = "statblId="+chartSid+"&displayType=S&selCategories="+selCategories;
	
		$.ajax({
			type : 'POST',
			dataType : 'json',
			async : false,
			url : com.wise.help.url("/portal/stat/statChartItm.do"),
			data : paramData,
			success : function(res) {
				var data = res.data;
				
				//시계열 한개(컬럼), pie, donut, treemap, spiderweb, sunburst 의 경우..
				//시계열 콤보에 따라서 데이터를 재호출한다.
				chartOneData = data.CHART_DATA;
				//chartSaOneData = data.CHART_ITMSA;
			}
		});
	}
*/	
	valSeries = new Array();
	var uiNm = "";
	var wrttimeIdtfrNm = selCategories + "년"; 
	
	$.each(targetData, function(key, value){
		var dtaVal = value.DTA_VAL;
		if(dtaVal != null) dtaVal = dtaSumProcess(0, dtaVal);
		
		$.each(chartTgData, function(tgkey, tgvalue){
			if(tgvalue.TG_CODE == value.TG_CODE){ //&& tgvalue.C_DEF_SEL_YN == "Y"){
				valSeries.push([tgvalue.TG_NAME, parseFloat(dtaVal)]);
				uiNm = value.UI_NM;
			}
		});
		

    });
	
	valSeries.sort(function(a, b){
		return a[1] - b[1];
	});
	
	var chartLoad = new StatCharts(); //차트 JS함수 정의 statCharts.js
	chartLoad.makeChartColumn(uiNm, wrttimeIdtfrNm);	
}

//데이터 값에 따른 정렬
function sortJSON(data, key, way) {
    return data.sort(function(a, b) {
        var x = a[key]; var y = b[key];

        if (way === 'ASC' ) { return ((x < y) ? -1 : ((x > y) ? 1 : 0)); }
        if (way === 'DESC') { return ((x > y) ? -1 : ((x < y) ? 1 : 0)); }
    });
}

//데이터 replace 전체
function dataReplaceAll(str, key, val){	
	var returnVal = 0;
	if(str != 0){
		returnVal = String(str).replace(/,/g, val);
	}
	
	return returnVal;
}

//차트의 yAxis 세팅
function yAxisSetting(uniqChguinm){

	yAxisData = new Array(); //전역변수 초기화
	for(var z=0; z<uniqChguinm.length; z++){
		var yAxisName = new Object();
		var yAxisTitle = new Object();
		var yAxisLabels = new Object();
		
		var isCDefSel = false;
		$.each(chartTgData, function(tgkey, tgvalue){
			if(uniqChguinm[z] == tgvalue.CHG_UI_NM && tgvalue.C_DEF_SEL_YN == "Y") isCDefSel = true;
		});
		
		if(isCDefSel) yAxisTitle.text = uniqChguinm[z];
		else yAxisTitle.text = "";
		yAxisName.title = yAxisTitle;

		if(z == 0){
			yAxisName.opposite = false;
			yAxisName.tickAmount = 5;
		}else{
			yAxisName.opposite = true;
		}
		
		if(uniqChguinm[z] == "%"){
			yAxisLabels.format = '{value:.1f}'; //소숫점 하위가 필요할 경우 세팅
			yAxisName.labels = yAxisLabels;
		}
		yAxisData.push(yAxisName);
	}		

}

//데이터의 합산 처리
function dtaSumProcess(sumVal, dtaVal){

	var valSplit1 = String(sumVal).split('.');
	var valSplit2 = "";
	var cntVal1 = 0;
	var cntVal2 = 0;
	
	if(valSplit1.length > 1)  cntVal1 = valSplit1[1].length;

	if(dtaVal != null) {
		dtaVal = dtaVal.replace(/,/g, ''); //모든 콤마 제거
		dtaVal = String(dtaVal);
		valSplit2 = dtaVal.split('.');
	}
	
	if(valSplit2.length > 1)  cntVal2 = valSplit2[1].length;
	
	//소숫점 자리가 긴 값을 확인
	var count =  cntVal1 > cntVal2 ? cntVal1 : cntVal2;
	
	if(sumVal == null){
		sumVal = Number(parseFloat(dtaVal).toFixed(count));
	}else{
		sumVal = Number((parseFloat(sumVal) + parseFloat(dtaVal)).toFixed(count));
	}
	
	return sumVal;
}

//Pie 데이터의 생성
function makePieData(sType, sName, tNm, itmData, tgData){
	
	//var seriesArr = new Array();
	var seriesObj = new Object();
	var seriesDataArr = new Array();
	var drillDownDataArr = new Array();
	var arrDanWi = new Array();
	
	for(var i=0; i<itmData.length; i++){
		var sObj = new Object();
		var dataNm = "";
		//그룹 이름을 확인한다.
		$.each(chartTgData, function(key, value){
			if(tNm == "GRP") if(itmData[i] == value.GRP_CODE) dataNm = value.GRP_NAME;
			if(tNm == "CLS") if(itmData[i] == value.CLS_CODE) dataNm = value.CLS_NAME;
			if(tNm == "ITM") if(itmData[i] == value.ITM_CODE) dataNm = value.ITM_NAME;
		});
		
		if(tNm != "ITM"){ //항목아 아닌 경우 drillDown이 있는 것으로 처리한다.
			sObj.name = dataNm;
			if(sType=="D" && tNm=="CLS") sObj.drilldown = sName+"_"+dataNm;
			else sObj.drilldown = dataNm;
		}else{
			sObj.id = dataNm;
		}
		sObj.y = 0;
		
		var dataMix = 0;
		//해당하는 데이터 합산
		$.each(tgData, function(key, value){
			var chkDataNo = "";
			if(tNm == "GRP") chkDataNo = value.GRP_DATANO;
			if(tNm == "CLS") chkDataNo = value.CLS_DATANO;
			if(tNm == "ITM") chkDataNo = value.ITM_DATANO;
			if(itmData[i] == chkDataNo && value.DTA_VAL != null){
				
				if(tNm != "ITM") sObj.y = dtaSumProcess(sObj.y, value.DTA_VAL);
				else dataMix = dtaSumProcess(dataMix, value.DTA_VAL);
					//drillDownDataArr.push([dataNm, dtaSumProcess(0, value.DTA_VAL)]);
			}
			arrDanWi.push(value.UI_NM);
			//if(tNm == "ITM")  drillDownDataArr.push([dataNm, dataMix]);
		});
		seriesDataArr.push(sObj);
		if(tNm == "ITM")  drillDownDataArr.push([dataNm, dataMix]);
	}
	seriesObj.name = sName;
	if(tNm != "ITM") seriesObj.data = seriesDataArr;
	else  seriesObj.data = drillDownDataArr;
		
	if(sType=="S") seriesObj.colorByPoint = true;
	if(sType!="S" && sType!="D") seriesObj.id = sType+"_"+sName;
	else seriesObj.id = sName;
	
	//단위정보를 가공해서 추가한다. 먼저 데이터의 중복을 제거한다.
	var uniqDanWi = arrDanWi.reduce(function(a, b){ if(a.indexOf(b) < 0) a.push(b); return a;},[]);
	var makeDanwi = "";
	for(var w=0; w<uniqDanWi.length; w++){
		if(w==0) makeDanwi = uniqDanWi[w];
		else  makeDanwi += ", " +uniqDanWi[w];
	}
	seriesObj.danWi = makeDanwi;
	
	return seriesObj;
}

//Treemap 데이터의 생성
function makeTreemapData(sType, sName, tNm, itmData, tgData, sLevel){
	
	for(var i=0; i<itmData.length; i++){
		var arrDanWi = new Array();
		var sObj = new Object();
		var dataNm = "";
		//그룹 이름을 확인한다.
		$.each(chartTgData, function(key, value){
			if(tNm == "GRP") if(itmData[i] == value.GRP_CODE) dataNm = value.GRP_NAME;
			if(tNm == "CLS") if(itmData[i] == value.CLS_CODE) dataNm = value.CLS_NAME;
			if(tNm == "ITM") if(itmData[i] == value.ITM_CODE) dataNm = value.ITM_NAME;
		});
		sObj.name = dataNm;
		
		if(sType=="S"){
			sObj.id= dataNm;
			var colorR = Math.floor((gfn_random() * 256));
			var colorG = Math.floor((gfn_random() * 256));
			var colorB = Math.floor((gfn_random() * 256));
			var rand = "rgb(" + colorR + "," + colorG + "," + colorB + ")";
			sObj.color = rand;
		}else{
			if(sType=="D" && tNm=="CLS"){
				sObj.id=sName+"_"+dataNm;
				sObj.parent=sName;
			}else{
				sObj.id=dataNm
				if(sType!="S" && sType!="D") sObj.parent=sType+"_"+sName;
				else sObj.parent = sName;
			}
		}

		sObj.value = 0;
		//해당하는 데이터 합산
		$.each(tgData, function(key, value){
			var chkDataNo = "";
			if(tNm == "GRP") chkDataNo = value.GRP_DATANO;
			if(tNm == "CLS") chkDataNo = value.CLS_DATANO;
			if(tNm == "ITM") chkDataNo = value.ITM_DATANO;
			if(itmData[i] == chkDataNo && value.DTA_VAL != null){
				sObj.value = dtaSumProcess(sObj.value, value.DTA_VAL);
			}
			arrDanWi.push(value.UI_NM);
		});

		//단위정보를 가공해서 추가한다. 먼저 데이터의 중복을 제거한다.
		var uniqDanWi = arrDanWi.reduce(function(a, b){ if(a.indexOf(b) < 0) a.push(b); return a;},[]);
		var makeDanwi = "";
		for(var w=0; w<uniqDanWi.length; w++){
			if(w==0) makeDanwi = uniqDanWi[w];
			else  makeDanwi += ", " +uniqDanWi[w];
		}
		sObj.danWi = makeDanwi;
		valSeries.push(sObj);
	}

}

//Spiderweb의 카테고리 생성
function makeSpiderwebCate(grpNull, clsNull, tgData){
	
	var arrDanWi = new Array();
	spiderwebCate = new Array();
	var sObj = new Object();
	if(grpNull != null){ //그룹이 있으면..
		for(var g=0; g<chartGrpData.length; g++){
			var grpCd = chartGrpData[g];
			var grpNm = "";
			var grpDanWi = "";
			//그룹 이름을 확인한다.
			$.each(tgData, function(key, value){
				if(chartGrpData[g] == value.GRP_CODE){
					grpNm = value.GRP_NAME;
					grpDanWi = value.CHG_UI_NM;
				}
			});
			if(clsNull != null){ //그룹O+분류가 있으면..
				for(var c=0; c<chartClsData.length; c++){
					sObj = new Object();
					var clsCd = chartClsData[c];
					var clsNm = "";
					var clsDanWi = "";
					//분류 이름을 확인한다.
					$.each(tgData, function(key, value){
						if(chartGrpData[g] == value.GRP_CODE && chartClsData[c] == value.CLS_CODE){
							clsNm = value.CLS_NAME;
							clsDanWi = value.CHG_UI_NM;
						}
					});
					sObj.id = grpCd+""+clsCd;
					sObj.name = grpNm+"_"+clsNm;
					sObj.danWi = clsDanWi;
					spiderwebCate.push(sObj);
				}
			}else{ //그룹O+분류가 없으면..
				sObj = new Object();
				sObj.id = grpCd;
				sObj.name = grpNm;
				sObj.danWi = grpDanWi;
				spiderwebCate.push(sObj);
			}
		}
	}else{ //그룹이 없으면..
		if(clsNull != null){ //그룹X+분류가 있으면..
			for(var c=0; c<chartClsData.length; c++){
				sObj = new Object();
				var clsCd = chartClsData[c];
				var clsNm = "";
				var clsDanWi = "";
				//분류 이름을 확인한다.
				$.each(tgData, function(key, value){
					if(chartClsData[c] == value.CLS_CODE){
						clsNm = value.CLS_NAME;
						clsDanWi = value.CHG_UI_NM;
					}
				});
				sObj.id = clsCd;
				sObj.name = clsNm;
				sObj.danWi = clsDanWi;
				spiderwebCate.push(sObj);
			}
		}else{ //그룹X+분류가 없으면..
			sObj = new Object();
			sObj.id = "";
			sObj.name = "기본통계값"
			sObj.danWi = tgData[0].CHG_UI_NM;
			spiderwebCate.push(sObj);
		}
	}
}

//Spiderweb의 데이터 생성
function makeSpiderwebData(grpNull, clsNull, tgData){
	
	//항목을 기준으로 데이터를 생성한다.
	for(var i=0; i<chartItmData.length; i++){
		var sObj = new Object();
		var itmData = new Array();
		var itmNm = "";
		//항목 이름을 확인한다.
		$.each(chartTgData, function(key, value){
			if(chartItmData[i] == value.ITM_CODE){
				itmNm = value.ITM_NAME;
				itmData.push(value);
			}
		});
		sObj.name = itmNm;
		
		var dataArr = new Array();
		$.each(spiderwebCate, function(skey, svalue){
			var sumDataVal = 0;
			$.each(tgData, function(key, value){
				if(chartItmData[i]==value.ITM_DATANO){
					var grpCode = value.GRP_DATANO != null ? value.GRP_DATANO : "";
					var clsCode = value.CLS_DATANO != null ? value.CLS_DATANO : "";
					var chkCd = grpCode+""+clsCode;
					
					if(svalue.id == chkCd && value.DTA_VAL != null) sumDataVal = dtaSumProcess(sumDataVal, value.DTA_VAL);
				} 
			});
			dataArr.push(sumDataVal);
		});	
		sObj.data = dataArr;
		valSeries.push(sObj);
	}
}

//Sunburst 데이터의 생성
function makeSunburstData(sType, sName, tNm, itmData, tgData, sLevel){
	
	for(var i=0; i<itmData.length; i++){
		var arrDanWi = new Array();
		var sObj = new Object();
		var dataNm = "";
		//그룹 이름을 확인한다.
		$.each(chartTgData, function(key, value){
			if(tNm == "GRP") if(itmData[i] == value.GRP_CODE) dataNm = value.GRP_NAME;
			if(tNm == "CLS") if(itmData[i] == value.CLS_CODE) dataNm = value.CLS_NAME;
			if(tNm == "ITM") if(itmData[i] == value.ITM_CODE) dataNm = value.ITM_NAME;
		});
		sObj.name = dataNm;
		
		if(sType=="D" && tNm=="CLS"){
			sObj.id=sName+"_"+dataNm;
			sObj.parent=sName;
		}else{
			sObj.id=dataNm
			if(sType!="S" && sType!="D") sObj.parent=sType+"_"+sName;
			else sObj.parent = sName;
		}
		sObj.value = 0;
		//해당하는 데이터 합산
		$.each(tgData, function(key, value){
			var chkDataNo = "";
			if(tNm == "GRP") chkDataNo = value.GRP_DATANO;
			if(tNm == "CLS") chkDataNo = value.CLS_DATANO;
			if(tNm == "ITM") chkDataNo = value.ITM_DATANO;
			if(itmData[i] == chkDataNo && value.DTA_VAL != null){
				sObj.value = dtaSumProcess(sObj.value, value.DTA_VAL);
			}
			arrDanWi.push(value.UI_NM);
		});

		//단위정보를 가공해서 추가한다. 먼저 데이터의 중복을 제거한다.
		var uniqDanWi = arrDanWi.reduce(function(a, b){ if(a.indexOf(b) < 0) a.push(b); return a;},[]);
		var makeDanwi = "";
		for(var w=0; w<uniqDanWi.length; w++){
			if(w==0) makeDanwi = uniqDanWi[w];
			else  makeDanwi += ", " +uniqDanWi[w];
		}
		sObj.danWi = makeDanwi;
		valSeries.push(sObj);
	}

}

