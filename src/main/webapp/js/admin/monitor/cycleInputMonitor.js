/*
 * @(#)docInfMgmt.js 1.0 2019/08/05
 */

/**
 * 관리자에서 연계모니터링 스크립트
 *
 * @author JSSON
 * @version 1.0 2019/10/01
 */
$(function() {
    // 컴포넌트를 초기화한다.
    initComp();
    
    // 이벤트를 바인딩한다.
    bindEvent();
    
    // 옵션을 로드한다.
    loadOptions();
    
    // 데이터를 로드한다.
    loadData();
});

/**
 * 이벤트를 바인딩한다.
 */
function bindEvent() {
	// 메인화면 이벤트 처리
	bindEventMain();
}

/**
 * 컴포넌트를 초기화한다.
 */
function initComp() {
	loadMainPage();
}

/**
 * 데이터를 로드한다.
 */
function loadData() {
	doActionMain("search");
}

/**
 * 메인페이지 로드
 * @returns
 */
function loadMainPage() {
	loadMainSheet();
	//loadMainChart();
}


////////////////////////////////////////////////////////////////////////////////
// 화면 액션 함수들
////////////////////////////////////////////////////////////////////////////////
/**
 * 메인화면 관련 액션함수
 * @param sAction	액션명
 * @returns
 */
function doActionMain(sAction) {
	var formObj = $("form[name=mainForm]");
	switch(sAction) {                       
		case "search":
			
			var param = {PageParam: "page", Param: "rows=50"+"&"+formObj.serialize()};
			mainSheet.DoSearchPaging(com.wise.help.url("/admin/monitor/cycleInputMonitorListPaging.do"), param);
 			
			//차트 조회
			ajaxCallAdmin(com.wise.help.url("/admin/monitor/cycleInputMonitorChart.do"),formObj.serialize(),initializeChart);
			break;
		case "excel":
			mainSheet.Down2Excel({FileName:'Excel.xls',SheetName:'sheet'});
			break;
		case "orgPop" :		//담당부서 팝업
			window.open(com.wise.help.url("/admin/basicinf/popup/commOrg_pop.do") + "?orgNmGb=2&sheetNm=statMainForm", "list" ,"fullscreen=no, width=500, height=550");
			break;
	}
}

////////////////////////////////////////////////////////////////////////////////
//시트 초기화
////////////////////////////////////////////////////////////////////////////////
/**
* 메인 시트 로드
*/
function loadMainSheet() {
	createIBSheet2(document.getElementById("mainSheet"),"mainSheet", "100%", "350px");	
	
	var gridTitle1 = "NO|담당부서|데이터셋명|입력주기|입력현황|입력현황|입력현황|입력현황|입력현황|입력현황";
	var gridTitle2 = "NO|담당부서|데이터셋명|입력주기|합계|승인|제출|미제출|입력대기|입력률";
	
	with(mainSheet){
     
		var cfg = {SearchMode:3,Page:50,VScrollMode:1, MergeSheet:msHeaderOnly, SumPosition:1};
	    SetConfig(cfg);
	    var headers = [
	                 {Text:gridTitle1, Align:"Center"},
	                {Text:gridTitle2, Align:"Center"}
	            ];
	    var headerInfo = {Sort:0,ColMove:1,ColResize:1,HeaderCheck:0};
	    
	    InitHeaders(headers, headerInfo);
	   
	    var cols = [
	                 {Type:"Seq",		SaveName:"seq",				Width:30,	Align:"Center",	Edit:false}
	                ,{Type:"Text",		SaveName:"loadOrgNm",		Width:60,	Align:"Center",	Edit:false}
	                ,{Type:"Text",		SaveName:"dsNm",			Width:100,	Align:"Center",	Edit:false}
	                ,{Type:"Text",		SaveName:"loadNm",			Width:40,	Align:"Center",	Edit:false}
	                ,{Type:"AutoSum",		SaveName:"cnt",				Width:30,	Align:"Center",	Edit:false, Format:"Integer"}
	                ,{Type:"AutoSum",		SaveName:"acCnt",			Width:30,	Align:"Center",	Edit:false, Format:"Integer"}
	                ,{Type:"AutoSum",		SaveName:"awCnt",			Width:30,	Align:"Center",	Edit:false, Format:"Integer"}
	                ,{Type:"AutoSum",		SaveName:"nawCnt",			Width:30,	Align:"Center",	Edit:false, Format:"Integer"}
	                ,{Type:"AutoSum",		SaveName:"pnawCnt",			Width:30,	Align:"Center",	Edit:false, Format:"Integer"}
	                ,{Type:"Text",		SaveName:"inputRate",		Width:30,	Align:"Center",	Edit:false, Type:"Float", Format:"#,##0.0\\%", CalcLogic:"(|acCnt|+|awCnt|)/|cnt|*100"}
	            ];                                          
	    InitColumns(cols);
	    FitColWidth();
	    SetExtendLastCol(1);
	    SetSumText(1, "합  계")
	}               
	default_sheet(mainSheet);
}
/**
* 메인 차트 로드
*/
function loadMainChart() {
	
	
	createIBChart2(document.getElementById("mainChart"), "mainChart", "100%", "350px");
	
}
/**
 * 메인화면 이벤트 처리
 */
function bindEventMain() {
	
	// 조회
	$("button[name=btn_inquiry]").bind("click", function(event) {
		doActionMain("search");
    });
	$("input[name=searchVal]").bind("keydown", function(event) {
        // 엔터키인 경우
        if (event.which == 13) {
        	doActionMain("search");
            return false;
        }
    });
	// 입력기간 초기화 올해초 올해말
	var today = new Date();
	var Year = today.getFullYear();
	$("button[name=openDttm_reset]").bind("click", function(e) {
		$("input[name=beginOpenDttm]").val(Year+"-01-01");
		$("input[name=endOpenDttm]").val(Year+"-12-31");
	});
	$("input[name=beginOpenDttm]").val(Year+"-01-01");
	$("input[name=endOpenDttm]").val(Year+"-12-31");
	
	$("button[name=btn_xlsDown]").bind("click", function(event){
		doActionMain("excel");
	});	
	//담당부서 팝업
	$("button[name=org_pop]").bind("click", function(e) {
		doActionMain("orgPop");
	});
	//담당부서 초기화
	$("button[name=org_reset]").bind("click", function(e) {
		$("input[name=orgCd], input[name=orgNm]").val("");
	});
	//입력주기 체크박스 제어
	$("input[name=loadCdAll]").bind("click", function(e) {
		var checked = $(this).is(":checked");
		$("input[name=loadCd]").each(function(idx) {
			$(this).prop("checked", checked);
		});
	});
	$("input[name=loadCd]").bind("click", function(e) {
		if ( !$(this).is(":checked") ) {
			$("input[name=loadCdAll]").prop("checked", false);
		}
	});	
	
}

/**
 * 옵션을 로드한다.
 */
function loadOptions() {
	// 메인 폼 공개일 from ~ to
	$("form[name=mainForm]").find("input[name=beginOpenDttm], input[name=endOpenDttm]").datepicker(setDatePickerCalendar());
	$("form[name=mainForm]").find('input[name=beginOpenDttm]').datepicker('option', 'onClose',  function( selectedDate ) {$("input[name=endOpenDttm]").datepicker( "option", "minDate", selectedDate );});
	$("form[name=mainForm]").find('input[name=endOpenDttm]').datepicker('option', 'onClose',  function( selectedDate ) {	$("input[name=beginOpenDttm]").datepicker( "option", "maxDate", selectedDate );});
	$("form[name=mainForm]").find("input[name=loadCdAll]").prop("checked", true);	//입력주기 기본체크
	$("form[name=mainForm]").find("input[name=loadCd]").prop("checked", true);		
	// 처리구분
	loadComboOptions3("jobTagCd", "/admin/stat/ajaxOption.do", {grpCd:"C1024"}, "");
	loadComboOptions3("srcSysCd", "/admin/stat/ajaxOption.do", {grpCd:"A8010"}, "");
	
}

/**
 * 캘린더 초기화 및 이벤트생성
 */
function datePickerInit() {
	var formObj = getTabFormObj("mst-form");
	
	/* 탭 이동마다 호출 */
	formObj.find(".ui-datepicker-trigger").remove();	//달력 이미지 제거
	
	// 공개일
	formObj.find("input[name=openDttm]").removeClass('hasDatepicker').datepicker(setDatePickerCalendar());
	
	// 생산일(파일)
	formObj.find("input[name=prdcYmd]").removeClass('hasDatepicker').datepicker(setDatePickerCalendar());
	
	//공개일 초기화
	formObj.find("button[id=openDttmInit]").bind("click", function() {
		formObj.find("input[name=openDttm]").val("");		
	});
}
function setDatePickerCalendar() {
	var calendar = {
		monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
		dayNamesMin: ['일','월','화','수','목','금','토'],
		weekHeader: 'Wk',
		dateFormat: 'yy-mm-dd', //형식(20120303)
		autoSize: false, //오토리사이즈(body등 상위태그의 설정에 따른다)
		changeMonth: true, //월변경가능
		changeYear: true, //년변경가능
		showMonthAfterYear: true, //년 뒤에 월 표시
		buttonImageOnly: true, //이미지표시
		buttonText: '달력선택', //버튼 텍스트 표시
		buttonImage: "../../../../images/admin/icon_calendar.png", //이미지주소                                              
		showOn: "both", //엘리먼트와 이미지 동시 사용(both,button)                 
		yearRange: '1900:2100', //1990년부터 2020년까지
		showButtonPanel: true, 
		closeText: 'close'
	};
	return calendar;
}


var rytitNm = "";
var index = 0;

function initializeChart(data){    
	//mainChart.RemoveAll();

	fnChartAddSeries(data);	// 차트 생성 및 추가
}                 
/*function fnChartAddSeries(data){
	
	var AW_RATE = data.data["AW_RATE"]
	
	
	mainChart.SetSeriesOptions([{
			Name : "미제출",
			Stack : "summer",
			Data : [{Y : 100-AW_RATE}],
			Color : "red"
		},{
			Name : "입력률",
			Stack : "summer",
			Data : [{Y : AW_RATE}],
			Color : "blue"
		}
	], 1); 
	
	mainChart.SetToolTipOptions({
		Enabled:true,		// ToolTip 사용여부
		Formatter : function(){
			return this.series.name+'<br>['+this.y+'%]';
		}
	});
	
	
	mainChart.SetPlotOptions({
		Bar:{
			DashStyle:"Dot",
			PointPadding:0,
			Stacking:"percent" 
		}
	});
	mainChart.SetXAxisOptions({
		Categories:["전체"]
	});
	mainChart.SetYAxisOptions({
		Title:{Text:"입력률"},
		Categories:["%"],
		TickInterval : 5  // Tick 간격을 5으로 설정
	});
	
	mainChart.SetBaseOptions({
		Type:"bar"
	});
	
	//mainChart.SetOptions(initData);
	mainChart.Draw();
	
	
}*/
function fnChartAddSeries(data){
	var AW_RATE = data.data["AW_RATE"]
	
	Highcharts.chart('mainChart', {
	    chart: {
	        type: 'bar'
	    },
	    credits: {
            enabled: false
        },
	    title: {
	        text: ''
	    },
	    xAxis: {
	        categories: ['전체']
	    },
	    yAxis: {
	        min: 0,
	        title: {
	            text: '(%)'
	        }
	    },
	    legend: {
	        reversed: true
	    },
	    plotOptions: {
	        series: {
	            stacking: 'percent'
	        }
	    },
	    series: [{
	        name: '미제출',
	        color:'#FF7A5A',
	        data: [100 - AW_RATE]
	    }, {
	        name: '입력률',
	        color:'#00AAA0',
	        data: [AW_RATE]
	    }]
	});
}
