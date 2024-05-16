/*
 * @(#)statObjtnDealRslt.js 1.0 2019/08/23
 */

/**
 * 관리자 메뉴 이의신청처리 현황 목록 스크립트 파일이다
 *
 * @author 최성빈
 * @version 1.0 2019/08/23
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
	//$("input[name=aplDtFrom]").val(today(-1));
	//$("input[name=aplDtTo]").val(today());	
	
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
		
		var frm = document.objtnDealRslForm;
		//============================================
		// 조회시날짜 입력이 안되어 있을면, 현재 날짜로 자동 세팅한다.
		var date = new Date();
		var year = date.getFullYear()+'';
		var month = (date.getMonth()+1)+'';
		var day = date.getDate()+'';
		if(month.length == 1) month = '0'+month;
		if(day.length == 1) day = '0'+day;
		
		var sysdate = year + month + day;
		
		if(!frm.aplDtFrom.value == '') {
			if(frm.aplDtTo.value == '') frm.aplDtTo.value = sysdate;
		}
		//============================================
		
		doAction("search");
    });
	
	//엑셀 다운로드
	$("button[name=btn_xlsDown]").bind("click", function(event) {
		doAction("excel");
    });
	
	//출력 및 저장
	$("button[name=btn_printSave]").bind("click", function(event) {
		fn_print();
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
			sheet.DoSearchPaging(com.wise.help.url("/admin/expose/statObjtnDealRslt.do"), { PageParam: "page", Param : "rows=50"+"&"+$("form[name=objtnDealRslForm]").serialize() });
			break;
		case "excel":
			sheet.Down2Excel({FileName:'이의신청 처리현황.xls',SheetName:'sheet'});
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

//출력 및 저장
function fn_print() {
	var formPrint = $("form[name=printForm]");
	 
	formPrint.find("input[name=width]").val("680");
	formPrint.find("input[name=height]").val("490");
	formPrint.find("input[name=title]").val("이의신청 처리현황");
	
	
	var mrdParamVal = "/rp [";
	mrdParamVal += $("input[name=aplDtFrom]").val();
	mrdParamVal += "] [";
	mrdParamVal += $("input[name=aplDtTo]").val();
	mrdParamVal += "] [";
	mrdParamVal += $("select[name=instCd]").val();
	mrdParamVal += "]";
	
	formPrint.find("input[name=mrdParam]").val(mrdParamVal);
			
	window.open('', 'popup', 'width=680, height=490, resizable=yes, location=no;');
	
	formPrint.attr("action", com.wise.help.url("/admin/expose/infoPrintPage/printNewStatObjtnDealRslt.do"));
	formPrint.attr("target", "popup");
	formPrint.submit();
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
	
	var gridTitle ="일련번호";
	gridTitle +="|사건명";
	gridTitle +="|처리일";
	gridTitle +="|청구인";
	gridTitle +="|피청구인";
	gridTitle +="|주문내용";
	gridTitle +="|신청취지";
	gridTitle +="|이유\n(처리결과요지)";
	
	with(sheet){
		                     
		var cfg = {SearchMode:3,Page:50,VScrollMode:1, MergeSheet :7}; 
	    SetConfig(cfg);
	   var headers = [
	                {Text:gridTitle, Align:"Center"}
	            ];
	    var headerInfo = {Sort:0,ColMove:0,ColResize:1,HeaderCheck:1};
	    
	    InitHeaders(headers, headerInfo);
	   
	    var cols = [
	                 {Type:"Text",	    SaveName:"aplNo",	         Width:60,	   Align:"Center",		Edit:false}
	                ,{Type:"Text",	    SaveName:"aplSj",	         Width:150,	   Align:"Left",		Edit:false} 
	                ,{Type:"Text",	    SaveName:"objtnNtcDt",	     Width:60,	   Align:"Center",		Edit:false, Format:"Ymd"}
	                ,{Type:"Text",	    SaveName:"aplPn",	         Width:60,	   Align:"Center",		Edit:false}
	                ,{Type:"Text",	    SaveName:"aplDealInstNm",	 Width:80,	   Align:"Center",		Edit:false}
	                ,{Type:"Text",	    SaveName:"objtnDealRsltCd",	 Width:60,	   Align:"Center",		Edit:false}
	                ,{Type:"Text",	    SaveName:"objtnRson",	     Width:150,	   Align:"Left",		Edit:false}
	                ,{Type:"Text",	    SaveName:"objtnAplRsltCn",	 Width:150,	   Align:"Left",		Edit:false}
	               
	                
					
	            ];                                          
	    InitColumns(cols);
	    FitColWidth();
	    SetExtendLastCol(1);
	    
	    SetSumValue(0, "instNm", "합계"); 
	    SetAutoSumPosition("0"); //autoSum 위치 지정 1은 최하단 0은 최상단 
	}               
	default_sheet(sheet);   
	
}

////////////////////////////////////////////////////////////////////////////////
//시트 서비스 함수
////////////////////////////////////////////////////////////////////////////////
function sheet_OnSearchEnd(code, message, statusCode, statusMessage) {
	
}

