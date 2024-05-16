/*
 * @(#)orgUsageState.js 1.0 2018/09/06
 */

/**
 * 관리자 출처별 활용현황 스크립트 파일이다
 *
 * @author 김정호
 * @version 1.0 2018/09/06
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
        buttonImage:com.wise.help.url("/images/admin/icon_calendar.png")
    }));
	
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
			sheet.DoSearchPaging(com.wise.help.url("/admin/stat/orgUsageStateList.do"), { Param : $("form[name=statOpen]").serialize() });
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
	gridTitle +="|조직명";
	gridTitle +="|조회수";
	gridTitle +="|변환수(합계)";
	gridTitle +="|엑셀 변환";
	gridTitle +="|CSV 변환";
	gridTitle +="|JSON 변환";
	gridTitle +="|XML 변환";
	gridTitle +="|TXT 변환";
	gridTitle +="|HWP 변환";
	
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
	                ,{Type:"Text",		SaveName:"orgNm",		Width:230,	Align:"Left",		Edit:false}
					,{Type:"AutoSum",	SaveName:"useCnt",		Width:130,	Align:"Center",		Edit:false,	Format : "Integer"}
					,{Type:"AutoSum",	SaveName:"downCnt",		Width:130,	Align:"Center",		Edit:false,	Format : "Integer"}
					,{Type:"AutoSum",	SaveName:"excelCnt",	Width:130,	Align:"Center",		Edit:false,	Format : "Integer"}
					,{Type:"AutoSum",	SaveName:"csvCnt",		Width:130,	Align:"Center",		Edit:false,	Format : "Integer"}
					,{Type:"AutoSum",	SaveName:"jsonCnt",		Width:130,	Align:"Center",		Edit:false,	Format : "Integer"}
					,{Type:"AutoSum",	SaveName:"xmlCnt",		Width:130,	Align:"Center",		Edit:false,	Format : "Integer"}
					,{Type:"AutoSum",	SaveName:"txtCnt",		Width:130,	Align:"Center",		Edit:false,	Format : "Integer"}
					,{Type:"AutoSum",	SaveName:"hwpCnt",		Width:130,	Align:"Center",		Edit:false,	Format : "Integer"}
				];
	    
	    InitColumns(cols);
	    FitColWidth();
	    SetExtendLastCol(1);
	    
	    SetSumValue(0, "orgNm", "합계"); 
	    SetAutoSumPosition("1"); //autoSum 위치 지정 1은 최하단 0은 최상단 
	}               
	default_sheet(sheet);   
	
}

function sheet_OnSearchEnd(code, message, statusCode, statusMessage) {
	
}

