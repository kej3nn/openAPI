/*
 * @(#)acsOpnzAplList.js 1.0 2020/06/03
 */

/**
 * 관리자 메뉴 청구인정보 열람 기록 목록 스크립트
 *
 * @author 최성빈
 * @version 1.0 2020/06/03
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
	$("input[name=aplDtFrom], input[name=aplDtTo]").datepicker(setCalendarFormat('yymmdd'));
	$("input[name=aplDtFrom], input[name=aplDtTo]").datepicker(com.wise.help.datepicker({
        buttonImage:com.wise.help.url("/images/admin/icon_calendar.png")
    }));
	$("input[name=aplDtFrom], input[name=aplDtTo]").attr("readonly", true);
	$('input[name=aplDtFrom]').datepicker('option', 'onClose',  function( selectedDate ) {$("input[name=aplDtTo]").datepicker( "option", "minDate", selectedDate );});
	$('input[name=aplDtTo]').datepicker('option', 'onClose',  function( selectedDate ) {	$("input[name=aplDtFrom]").datepicker( "option", "maxDate", selectedDate );});
	
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
	
	//조회
	$("button[name=btn_inquiry]").bind("click", function(event) {
		
		doAction("search");
    });
	
	//엑셀 다운로드
	$("button[name=btn_xlsDown]").bind("click", function(event) {
		doAction("excel");
    });
	
	//날짜 초기화 
	$("button[name=aplDt_reset]").bind("click", function(e) {
		$("input[name=aplDtFrom], input[name=aplDtTo]").val("");
	});
	
}


/**
 * 옵션을 로드한다.
 */
function loadOptions() {
	loadComboOptions2("acsPrssCd", "/admin/stat/ajaxOption.do", {grpCd:"B201P"}, "");
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
			sheet.DoSearchPaging(com.wise.help.url("/admin/expose/acsOpnzAplList.do"), { PageParam: "page", Param : "rows=50"+"&"+$("form[name=acsOpnzAplForm]").serialize() });
			break;
		case "excel":
			sheet.Down2Excel({FileName:'정보공개청구서 접근기록.xls',SheetName:'sheet'});
			break;
		
	}
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
		gridTitle +="|접수번호";
		gridTitle +="|청구일자";
		gridTitle +="|청구제목";
		gridTitle +="|청구인명";
		gridTitle +="|처리기관";
		gridTitle +="|상태";
		gridTitle +="|열람자명";
		gridTitle +="|열람IP";
		gridTitle +="|열람구분";
		gridTitle +="|처리구분";
		gridTitle +="|열람일자";
	
	with(sheet){
		                     
		var cfg = {SearchMode:3,Page:50,VScrollMode:1}; 
	    SetConfig(cfg);
	    var headers = [
		                {Text:gridTitle, Align:"Center"}
		            ];
		    var headerInfo = {Sort:0,ColMove:1,ColResize:1,HeaderCheck:0};
		    
		    InitHeaders(headers, headerInfo);
	   
	    var cols = [
	                 {Type:"Seq",	    SaveName:"seq",	            Width:40,	Align:"Center",		Edit:false}
	                ,{Type:"Text",	    SaveName:"aplNo",			Width:60,	Align:"Center",		Edit:false} 
	                ,{Type:"Text",	    SaveName:"aplDt",	        Width:60,	Align:"Center",		Edit:false, Format:"Ymd"}
	                ,{Type:"Text",	    SaveName:"aplSj",	        Width:250,	Align:"Left",		Edit:false}
	                ,{Type:"Text",	    SaveName:"aplPn",	        Width:60,	Align:"Center",		Edit:false}
	                ,{Type:"Text",	    SaveName:"aplDealInstNm",	Width:100,	Align:"Center",		Edit:false}
	                ,{Type:"Text",	    SaveName:"prgStatNm",	    Width:80,	Align:"Center",		Edit:false}
	                ,{Type:"Text",	    SaveName:"usrNm",	        Width:60,	Align:"Center",		Edit:false}
	                ,{Type:"Text",	    SaveName:"usrIp",	        Width:80,	Align:"Center",		Edit:false}
	                ,{Type:"Text",	    SaveName:"acsNm",	        Width:120,	Align:"Center",		Edit:false}
	                ,{Type:"Text",	    SaveName:"acsPrssNm",	    Width:100,	Align:"Center",		Edit:false}
	                ,{Type:"Text",	    SaveName:"regDttm",	        Width:80,	Align:"Center",		Edit:false}
	                
					
	            ];                                          
	    InitColumns(cols);
	    FitColWidth();
	    SetExtendLastCol(1);
	}               
	default_sheet(sheet);   
	
}

////////////////////////////////////////////////////////////////////////////////
//시트 서비스 함수
////////////////////////////////////////////////////////////////////////////////
function sheet_OnSearchEnd(code, message, statusCode, statusMessage) {
	
}

