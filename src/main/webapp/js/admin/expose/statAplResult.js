/*
 * @(#)statAplResult.js 1.0 2019/08/23
 */

/**
 * 관리자 메뉴 정보공개 처리현황 목록 스크립트 파일이다
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
		
		var frm = document.statAplForm;
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
			sheet.DoSearchPaging(com.wise.help.url("/admin/expose/statAplResult.do"), { PageParam: "page", Param : "rows=50"+"&"+$("form[name=statAplForm]").serialize() });
			break;
		case "excel":
			sheet.Down2Excel({FileName:'청구건별 처리현황.xls',SheetName:'sheet'});
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
	formPrint.find("input[name=title]").val("청구건별 처리현황");
	
	
	var mrdParamVal = "/rp [";
	mrdParamVal += $("input[name=aplDtFrom]").val();
	mrdParamVal += "] [";
	mrdParamVal += $("input[name=aplDtTo]").val();
	mrdParamVal += "] [";
	mrdParamVal += $("select[name=instCd]").val();
	mrdParamVal += "]";
	
	formPrint.find("input[name=mrdParam]").val(mrdParamVal);
			
	window.open('', 'popup', 'width=680, height=490, resizable=yes, location=no;');
	
	formPrint.attr("action", com.wise.help.url("/admin/expose/infoPrintPage/printNewStatAplResult.do"));
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
	
	var gridTitle ="일련번호\n(신청번호)";
	gridTitle +="|청구사항";
	gridTitle +="|청구사항";
	gridTitle +="|결정내용";
	gridTitle +="|결정내용";
	gridTitle +="|결정내용";
	gridTitle +="|결정내용";
	gridTitle +="|결정내용";
	gridTitle +="|결정내용";
	gridTitle +="|처리사항";
	gridTitle +="|처리사항";
	gridTitle +="|비고";
	gridTitle +="|비고";
	
	
	var gridTitle1 ="일련번호\n(신청번호)";
	gridTitle1 +="|청구내용";
	gridTitle1 +="|공개형태";
	gridTitle1 +="|담당부서";
	gridTitle1 +="|결정구분";
	gridTitle1 +="|공개내용";
	gridTitle1 +="|비공개(부분공개)\n내용 및 사유";
	gridTitle1 +="|정보 부존재 등 정보공개청구에\n 따를 수 없는 사유";
	gridTitle1 +="|결정통지 일자";
	gridTitle1 +="|공개일자";
	gridTitle1 +="|공개방법";
	gridTitle1 +="|비고";
	gridTitle1 +="|비고";
	
	with(sheet){
		                     
		var cfg = {SearchMode:3,Page:50,VScrollMode:1, MergeSheet :7}; 
	    SetConfig(cfg);
	   var headers = [
	                {Text:gridTitle, Align:"Center"},{Text:gridTitle1, Align:"Center"}
	            ];
	    var headerInfo = {Sort:0,ColMove:0,ColResize:1,HeaderCheck:1};
	    
	    InitHeaders(headers, headerInfo);
	   
	    var cols = [
	                 {Type:"Text",	    SaveName:"aplNo",	    Width:100,	Align:"Center",		Edit:false}
	                ,{Type:"Text",	    SaveName:"aplModSj",	Width:150,	Align:"Left",		Edit:false} 
	                ,{Type:"Text",	    SaveName:"opbFomNm",	Width:150,	Align:"Left",		Edit:false}
	                ,{Type:"Text",	    SaveName:"instNm",	    Width:150,	Align:"Left",		Edit:false}
	                ,{Type:"Text",	    SaveName:"opbYn",	    Width:100,	Align:"Left",		Edit:false}
	                ,{Type:"Text",	    SaveName:"opbCn",	    Width:150,	Align:"Left",		Edit:false}
	                ,{Type:"Text",	    SaveName:"clsdRsonNm",	Width:150,	Align:"Left",		Edit:false}
	                ,{Type:"Text",	    SaveName:"nonExt",	    Width:150,	Align:"Left",		Edit:false}
	                ,{Type:"Text",	    SaveName:"dcsNtcDt",	Width:80,	Align:"Center",		Edit:false, Format:"Ymd"}
	                ,{Type:"Text",	    SaveName:"opbDtm",	    Width:80,	Align:"Center",		Edit:false, Format:"Ymd"}
	                ,{Type:"Text",	    SaveName:"giveMthNm",	Width:80,	Align:"Left",		Edit:false}
	                ,{Type:"Text",	    SaveName:"memo",	    Width:80,	Align:"Left",		Edit:false}
	                
					
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

