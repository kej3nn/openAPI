/*
 * @(#)apiUsageState.js 1.0 2020/10/14
 */

/**
 * 관리자 API 호출 현황 스크립트 파일이다
 *
 * @author WISE
 * @version 1.0 2020/09/14
 */
$(function() {
    // 컴포넌트를 초기화한다.
    initComp();
    
    // 마스크를 바인딩한다.
    bindMask();
    
    // 이벤트를 바인딩한다.
    bindEvent();
    
    // 옵션을 로드한다.
    loadOptions();
    
    // 데이터를 로드한다.
    loadData();
});

////////////////////////////////////////////////////////////////////////////////
// 글로벌 변수
////////////////////////////////////////////////////////////////////////////////


////////////////////////////////////////////////////////////////////////////////
// 초기화 함수
////////////////////////////////////////////////////////////////////////////////
/**
 * 컴포넌트를 초기화한다.
 */
function initComp() {
	$("input[name=startYmd], input[name=endYmd]").datepicker(com.wise.help.datepicker({
        buttonImage:com.wise.help.url("/images/admin/icon_calendar.png"),
        dateFormat: "yy-mm" 
    }));
	
	//$('input[name=startYmd]').datepicker('option', 'onClose',  function( selectedDate ) {$("input[name=endYmd]").datepicker( "option", "minDate", selectedDate );});
	//$('input[name=endYmd]').datepicker('option', 'onClose',  function( selectedDate ) {	$("input[name=startYmd]").datepicker( "option", "maxDate", selectedDate );});
	
	$("input[name=startYmd]").val(today(-1));
	$("input[name=endYmd]").val(today());	
	
	loadSheet();
}

/**
 * 마스크를 바인딩한다.
 */
function bindMask() {
}

/**
 * 이벤트를 바인딩한다.
 */
function bindEvent() {
	$("button[name=btn_inquiry]").bind("click", function(event) {
		doAction("search");
    });
	$("button[name=btn_xlsDown]").bind("click", function(event) {
		doAction("excel");
    });
}


/**
 * 옵션을 로드한다.
 */
function loadOptions() {
}

/**
 * 데이터를 로드한다.
 */
function loadData() {
	doAction("search");
}

////////////////////////////////////////////////////////////////////////////////
// 서비스 함수
////////////////////////////////////////////////////////////////////////////////

/**
 * 화면 액션
 */
function doAction(sAction) {

	switch(sAction) {                       
		case "search":
			ajaxBeforeSendAdmin(com.wise.help.url("/admin/ajaxBeforeSendAdmin.do")); //IbSheet 조회전 세션 체크
			var param = {PageParam: "page", Param: "rows=50"+"&"+$("form[name=statOpen]").serialize()};
			sheet.DoSearchPaging(com.wise.help.url("/admin/stat/apiUsageStateList.do"), param);
			//차트 조회
			ajaxCallAdmin(com.wise.help.url("/admin/stat/apiUsageStateList.do"),$("form[name=statOpen]").serialize(),initializeChart);

			break;
		case "excel":
			sheet.Down2Excel({FileName:'Excel.xls',SheetName:'sheet'});
			break;
		
	}
}

function today(year){
	var year = year || 0;
    var date = new Date();

    var year  = date.getFullYear() + year;
    var month = date.getMonth() + 1; // 0부터 시작하므로 1더함 더함
    var day   = date.getDate();

    if (("" + month).length == 1) { month = "0" + month; }
    //if (("" + day).length   == 1) { day   = "0" + day;   }
   
    //return "" + year + "-" + month + "-" + day; 
    return "" + year + "-" + month ; 
}


////////////////////////////////////////////////////////////////////////////////
// 전처리 함수
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// 후처리 함수
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
//시트 로드
////////////////////////////////////////////////////////////////////////////////
function loadSheet() {
	
	createIBSheet2(document.getElementById("sheet"),"sheet", "100%", "600px");
	
	var gridTitle ="NO";
	gridTitle +="|기준월";
	gridTitle +="|사용자수";
	gridTitle +="|공공데이터수";
	gridTitle +="|호출수";
	gridTitle +="|데이터행수";
	gridTitle +="|오류수";
	gridTitle +="|XML 변환수";
	gridTitle +="|JSON 변환수";
	gridTitle +="|평균응답시간";
	gridTitle +="|DB크기";
	gridTitle +="|전송출력크기";
	
	
	with(sheet){
		                     
		/*var cfg = {SearchMode:2,Page:50,VScrollMode:1}; */
		var cfg = {SearchMode:3,Page:50,VScrollMode:1};  
	    SetConfig(cfg);
	    var headers = [
	                {Text:gridTitle, Align:"Center"}
	            ];
	    var headerInfo = {Sort:0,ColMove:1,ColResize:1,HeaderCheck:0};
	    
	    InitHeaders(headers, headerInfo);
	   
	    var cols = [
	                 {Type:"Seq",		SaveName:"seq",				Width:50,	Align:"Center",		Edit:false}
	                ,{Type:"Text",		SaveName:"yyyymm",			Width:100,	Align:"Center",		Edit:false, Format:"Ym" }
					,{Type:"Text",	    SaveName:"userCnt",		    Width:100,	Align:"Center",		Edit:false}
					,{Type:"Text",	    SaveName:"infCnt",		    Width:100,	Align:"Center",		Edit:false}
					,{Type:"Text",	    SaveName:"callCnt",		    Width:100,	Align:"Center",		Edit:false}
					,{Type:"Text",	    SaveName:"rowCnt",		    Width:100,	Align:"Center",		Edit:false}
					,{Type:"Text",	    SaveName:"errCnt",		    Width:100,	Align:"Center",		Edit:false}
					,{Type:"Text",	    SaveName:"xmlCnt",		    Width:100,	Align:"Center",		Edit:false}
					,{Type:"Text",	    SaveName:"jsonCnt",		    Width:100,	Align:"Center",		Edit:false}
					,{Type:"Text",	    SaveName:"avgLt",		    Width:100,	Align:"Center",		Edit:false}
					,{Type:"Text",	    SaveName:"dbSize",		    Width:100,	Align:"Center",		Edit:false}
					,{Type:"Text",	    SaveName:"outSize",		    Width:100,	Align:"Center",		Edit:false}
					
				];
	    
	    InitColumns(cols);
	    FitColWidth();
	    SetExtendLastCol(1);
	   
	    
	}               
	default_sheet(sheet);   
	
}

function sheet_OnSearchEnd(code, message, statusCode, statusMessage) {
	
}

function initializeChart(data){    
	//mainChart.RemoveAll();

	afterStatUsageStateChart(data);	// 차트 생성 및 추가
} 
////////////////////////////////////////////////////////////////////////////////
// 후처리 함수
////////////////////////////////////////////////////////////////////////////////

function afterStatUsageStateChart(result) {
	var Columns = [];
	var Rows = [];
	// x축 레이블과 데이터 값 배열
	const categories = [];
	const usersData = [];
	const infsData = [];
	const callsData = [];
	const rowsData = [];
	const errsData = [];
	
	$.each(result.data, function(index, item){
	  categories.push(item.yyyymm); // x축 레이블에 월 추가
	  usersData.push(item.userCnt); // 데이터 값 배열에 사용자 수 추가
	  infsData.push(item.infCnt);
	  callsData.push(item.callCnt);
	  rowsData.push(item.rowCnt);
	  errsData.push(item.errCnt);
	});
	// Highcharts 그래프 생성
	Highcharts.chart('mainChart', {
	  chart: {
	    type: 'line' // 선 그래프로 설정
	  },
	  title: {
	    text: 'API 호출현황' // 그래프 제목
	  },
	  xAxis: {
	    categories:categories // x축 레이블 설정
	  },
	  yAxis: {
	    title: {
	      text: '사용자 수' // y축 레이블 설정
	    }
	  },
	  series: [{
	    name: '사용자 수', // 데이터 시리즈 이름
	    data: usersData // 데이터 값 설정
	  },{
	    name: '공공데이터 수', // 데이터 시리즈 이름
	    data: infsData // 데이터 값 설정
	  },{
	    name: '에러 수', // 데이터 시리즈 이름
	    data: errsData // 데이터 값 설정
	  }
	  ]
	});

}


