/*
 * @(#)statObjtnDeal.js 1.0 2019/08/23
 */

/**
 * 관리자 메뉴 이의신청서처리 현황 스크립트 파일이다
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
		
		var frm = document.ObjtnDealForm;
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
			sheet.DoSearchPaging(com.wise.help.url("/admin/expose/statObjtnDeal.do"), { Param : $("form[name=ObjtnDealForm]").serialize() });
			break;
		case "excel":
			sheet.Down2Excel({FileName:'이의신청 처리결과.xls',SheetName:'sheet'});
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
	formPrint.find("input[name=title]").val("이의신청 처리결과");
	
	
	var mrdParamVal = "/rp [";
	mrdParamVal += $("input[name=aplDtFrom]").val();
	mrdParamVal += "] [";
	mrdParamVal += $("input[name=aplDtTo]").val();
	mrdParamVal += "] [";
	mrdParamVal += $("select[name=instCd]").val();
	mrdParamVal += "]";
	
	formPrint.find("input[name=mrdParam]").val(mrdParamVal);
			
	window.open('', 'popup', 'width=680, height=490, resizable=yes, location=no;');
	
	formPrint.attr("action", com.wise.help.url("/admin/expose/infoPrintPage/printNewStatObjtnDeal.do"));
	formPrint.attr("target", "popup");
	formPrint.submit();
}

//청구서(팝업) 조회 페이지 이동
function goOpnAplListPop(instCd, saveNm) {
	
	//초기화
	$("input[name=aplDealInstCd]").val("");
	$("input[name=objtn]").val("");
	 
	var form = $("form[name=ObjtnDealForm]");
	
	window.open('','popup', "width=800, height=800, scrollbars=yes");
	 
    $("input[name=aplDealInstCd]").val(instCd);
	
    //SaveName 따라 파라미터 세팅
	if(saveNm == "totSum1")   $("input[name=objtn]").val("all");
	else if(saveNm == "sum1") $("input[name=objtn]").val("99");
	else if(saveNm == "sum2") $("input[name=objtn]").val("02");
	else if(saveNm == "sum3") $("input[name=objtn]").val("03");
	else if(saveNm == "sum4") $("input[name=objtn]").val("04");
	else if(saveNm == "sum5") $("input[name=objtn]").val("05");
	else if(saveNm == "sum6") $("input[name=objtn]").val("01");
	
	//청구서(팝업) 조회 페이지 이동
	form.attr("action", com.wise.help.url("/admin/expose/popup/searchOpnAplPopup.do"));
	form.attr("target", "popup");
	form.submit();
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
	
	var gridTitle ="코드";
	gridTitle +="|구분";
	gridTitle +="|신청건수";
	gridTitle +="|처리결과";
	gridTitle +="|처리결과";
	gridTitle +="|처리결과";
	gridTitle +="|처리결과";
	gridTitle +="|처리결과";
	gridTitle +="|처리결과";
	
	var gridTitle1 ="코드";
	gridTitle1 +="|구분";
	gridTitle1 +="|신청건수";
	gridTitle1 +="|취하";
	gridTitle1 +="|각하";
	gridTitle1 +="|기각";
	gridTitle1 +="|인용";
	gridTitle1 +="|부분인용";
	gridTitle1 +="|기간연장";
	
	with(sheet){
		                     
		var cfg = {SearchMode:2,Page:50,VScrollMode:1, MergeSheet :7}; 
	    SetConfig(cfg);
	   var headers = [
	                {Text:gridTitle, Align:"Center"},{Text:gridTitle1, Align:"Center"}
	            ];
	    var headerInfo = {Sort:0,ColMove:0,ColResize:1,HeaderCheck:1};
	    
	    InitHeaders(headers, headerInfo);
	   
	    var cols = [
	                 {Type:"Text",	    SaveName:"instCd",	Width:150,	Align:"Center",		Edit:false,	Hidden:true}
	                ,{Type:"Text",	    SaveName:"instNm",	Width:150,	Align:"Left",		Edit:false} 
	                ,{Type:"AutoSum",	SaveName:"totSum1",	Width:150,	Align:"Center",		Edit:false,	Format : "Integer"}
	                ,{Type:"AutoSum",	SaveName:"sum1",	Width:150,	Align:"Center",		Edit:false,	Format : "Integer"}
					,{Type:"AutoSum",	SaveName:"sum2",	Width:150,	Align:"Center",		Edit:false,	Format : "Integer"}
					,{Type:"AutoSum",	SaveName:"sum3",	Width:150,	Align:"Center",		Edit:false,	Format : "Integer"}
					,{Type:"AutoSum",	SaveName:"sum4",	Width:150,	Align:"Center",		Edit:false,	Format : "Integer"}
					,{Type:"AutoSum",	SaveName:"sum5",	Width:150,	Align:"Center",		Edit:false, Format:  "Integer"}
					,{Type:"AutoSum",	SaveName:"sum6",	Width:150,	Align:"Center",		Edit:false,	Format : "Integer"}
					
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
function sheet_OnDblClick(row, col, value, cellx, celly) {
	if(row < 1) return;   
	
	var instCd = sheet.GetCellValue(row, "instCd"); //시트 기관코드값을 가져온다
	var saveNm = sheet.ColSaveName(0, col); // 시트 saveName을 가져온다
	
	goOpnAplListPop(instCd, saveNm); //팝업창 이동
}
function sheet_OnSearchEnd(code, message, statusCode, statusMessage) {
	
}

