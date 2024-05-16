/*
 * @(#)statAreaDGG 1.0 2020/11/04
 */

/**
 * 관리자 구글 사이트 분석 현황 - 지역현황 상세 스크립트 파일이다
 *
 * @author WISE
 * @version 1.0 2020/11/04
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
	$("input[name=startYmd], input[name=endYmd]").datepicker(com.wise.help.datepicker({buttonImage:com.wise.help.url("/images/admin/icon_calendar.png")}));
	
	$('input[name=startYmd]').datepicker('option', 'onClose',  function( selectedDate ) {$("input[name=endYmd]").datepicker( "option", "minDate", selectedDate );});
	$('input[name=endYmd]').datepicker('option', 'onClose',  function( selectedDate ) {	$("input[name=startYmd]").datepicker( "option", "maxDate", selectedDate );});
	
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
			sheet.DoSearchPaging(com.wise.help.url("/admin/gaapi/selectStatAreaDGGList.do"), param);
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
    var day   = date.getDate() - 1 ;

    if (("" + day).length   == 1) { day   = "0" + day;   }
   
    return "" + year + "-" + month + "-" + day; 
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
	gridTitle +="|일련번호";
	gridTitle +="|기준일";
	gridTitle +="|국가코드";
	gridTitle +="|국가";
	gridTitle +="|지역코드";
	gridTitle +="|지역";
	gridTitle +="|사용자수";
	gridTitle +="|사용자수\n(전체대비비율)";
	gridTitle +="|신규방문자수";
	gridTitle +="|신규방문자수\n(전체대비비율)";
	gridTitle +="|세션";
	gridTitle +="|세션\n(전체대비비율)";
	
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
	                 {Type:"Seq",		SaveName:"seq",					Width:50,	Align:"Center",		Edit:false}
	                ,{Type:"Text",	    SaveName:"gaClctSeqceNo",		Width:100,	Align:"Center",		Edit:false,	Hidden:true}
	                ,{Type:"Text",		SaveName:"yyyymmdd",			Width:100,	Align:"Center",		Edit:false, Format:"Ymd" }
	                ,{Type:"Text",	    SaveName:"natId",				Width:100,	Align:"Center",		Edit:false,	Hidden:true}
	                ,{Type:"Text",	    SaveName:"natNm",				Width:100,	Align:"Left",		Edit:false,	Hidden:true}
	                ,{Type:"Text",	    SaveName:"areaId",				Width:100,	Align:"Center",		Edit:false,	Hidden:true}
	                ,{Type:"Text",	    SaveName:"areaNm",				Width:100,	Align:"Left",		Edit:false}
	                ,{Type:"Text",	    SaveName:"userCnt",				Width:100,	Align:"Center",		Edit:false}
	                ,{Type:"Text",	    SaveName:"userRto",				Width:100,	Align:"Center",		Edit:false}
					,{Type:"Text",	    SaveName:"newVstrCnt",			Width:100,	Align:"Center",		Edit:false}
					,{Type:"Text",	    SaveName:"newVstrRto",	    	Width:100,	Align:"Center",		Edit:false}
					,{Type:"Text",	    SaveName:"ssenCnt",				Width:100,	Align:"Center",		Edit:false}
					,{Type:"Text",	    SaveName:"ssenRto",	    		Width:100,	Align:"Center",		Edit:false}
					
				];
	    
	    InitColumns(cols);
	    FitColWidth();
	    SetExtendLastCol(1);
	   
	    
	}               
	default_sheet(sheet);   
	
}

function sheet_OnSearchEnd(code, message, statusCode, statusMessage) {
	
}

