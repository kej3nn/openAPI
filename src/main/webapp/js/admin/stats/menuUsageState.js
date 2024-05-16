/*
 * @(#)menuUsageState.js 1.0 2018/09/05
 */

/**
 * 관리자 메뉴 활용현황 스크립트 파일이다
 *
 * @author 김정호
 * @version 1.0 2018/09/05
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
	//$("input[name=startYmd], input[name=endYmd]").removeClass('hasDatepicker').datepicker(setCalendar());
	$("input[name=startYmd], input[name=endYmd]").datepicker(com.wise.help.datepicker({
        buttonImage:com.wise.help.url("/images/admin/icon_calendar.png")
    }));
	
	$('input[name=startYmd]').datepicker('option', 'onClose',  function( selectedDate ) {$("input[name=endYmd]").datepicker( "option", "minDate", selectedDate );});
	$('input[name=endYmd]').datepicker('option', 'onClose',  function( selectedDate ) {	$("input[name=startYmd]").datepicker( "option", "maxDate", selectedDate );});
	$("input[name=startYmd]").val(today(-1));
	$("input[name=endYmd]").val(today());	
	
	loadSheet();
	
	loadSheetExcel();
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
		doAction("search2");
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
	doAction("search2");
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
			$("input[name=dateGb]").val("");
			sheet.DoSearchPaging(com.wise.help.url("/admin/stat/menuUsageStateList.do"), { Param : $("form[name=statOpen]").serialize() });
			break;
		case "search2":
			ajaxBeforeSendAdmin(com.wise.help.url("/admin/ajaxBeforeSendAdmin.do")); //IbSheet 조회전 세션 체크
			$("input[name=dateGb]").val("Y");
			sheet2.DoSearchPaging(com.wise.help.url("/admin/stat/menuUsageStateList.do"), { Param : $("form[name=statOpen]").serialize() });
			break;	
		case "excel":
			sheet2.Down2Excel({FileName:'Excel.xls',SheetName:'sheet'});
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
	gridTitle +="|메뉴명";
	gridTitle +="|조회수";
	/*gridTitle +="|국회내부";
	gridTitle +="|외부";*/
	gridTitle +="|기준월";
	
	with(sheet){
		                     
		var cfg = {SearchMode:2,Page:50,VScrollMode:1}; 
	    SetConfig(cfg);
	    var headers = [
	                {Text:gridTitle, Align:"Center"}
	            ];
	    var headerInfo = {Sort:0,ColMove:1,ColResize:1,HeaderCheck:0};
	    
	    InitHeaders(headers, headerInfo);
	   
	    var cols = [
	                 {Type:"Seq",		SaveName:"seq",			Width:30,	Align:"Center",		Edit:false}
	                ,{Type:"Text",		SaveName:"menuNm",		Width:350,	Align:"Left",		Edit:false} 
					,{Type:"AutoSum",	SaveName:"menuAllCnt",	Width:170,	Align:"Center",		Edit:false,	Format : "Integer"}
					/*,{Type:"AutoSum",	SaveName:"menuInCnt",	Width:150,	Align:"Center",		Edit:false,	Format : "Integer"}
					,{Type:"AutoSum",	SaveName:"menuOutCnt",	Width:150,	Align:"Center",		Edit:false,	Format : "Integer"}*/
					,{Type:"Text",		SaveName:"baseDate",	Width:150,	Align:"Center",		Edit:false, Format:"Ym" }
					
	            ];                                          
	    InitColumns(cols);
	    FitColWidth();
	    SetExtendLastCol(1);
	    
	    SetSumValue(0, "menuNm", "합계"); 
	    SetAutoSumPosition("1"); //autoSum 위치 지정 1은 최하단 0은 최상단 
	}               
	default_sheet(sheet);   
	
}

function loadSheetExcel() {
	
	createIBSheet2(document.getElementById("sheet2"),"sheet2", "100%", "600px");
	
	var gridTitle ="NO";
	gridTitle +="|메뉴명";
	gridTitle +="|조회수";
	/*gridTitle +="|국회내부";
	gridTitle +="|외부";*/
	gridTitle +="|기준일";
	
	with(sheet2){
		                     
		var cfg = {SearchMode:2,Page:50,VScrollMode:1}; 
	    SetConfig(cfg);
	    var headers = [
	                {Text:gridTitle, Align:"Center"}
	            ];
	    var headerInfo = {Sort:0,ColMove:1,ColResize:1,HeaderCheck:0};
	    
	    InitHeaders(headers, headerInfo);
	   
	    var cols = [
	                 {Type:"Seq",		SaveName:"seq",			Width:30,	Align:"Center",		Edit:false}
	                ,{Type:"Text",		SaveName:"menuNm",		Width:350,	Align:"Left",		Edit:false} 
					,{Type:"AutoSum",	SaveName:"menuAllCnt",	Width:170,	Align:"Center",		Edit:false,	Format : "Integer"}
					/*,{Type:"AutoSum",	SaveName:"menuInCnt",	Width:150,	Align:"Center",		Edit:false,	Format : "Integer"}
					,{Type:"AutoSum",	SaveName:"menuOutCnt",	Width:150,	Align:"Center",		Edit:false,	Format : "Integer"}*/
					,{Type:"Text",		SaveName:"baseDate",	Width:150,	Align:"Center",		Edit:false, Format:"Ymd" }
					
	            ];                                          
	    InitColumns(cols);
	    FitColWidth();
	    SetExtendLastCol(1);
	    
	    SetSumValue(0, "menuNm", "합계"); 
	    SetAutoSumPosition("1"); //autoSum 위치 지정 1은 최하단 0은 최상단 
	}               
	default_sheet(sheet2);   
	
}

function sheet_OnSearchEnd(code, message, statusCode, statusMessage) {
	
}

function sheet2_OnSearchEnd(code, message, statusCode, statusMessage) {
	
}

