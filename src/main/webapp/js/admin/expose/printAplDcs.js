/*
 * @(#)printAplDcs.js 1.0 2019/08/23
 */

/**
 * 관리자 메뉴 결정통지서 기간별출력 목록 스크립트 파일이다
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
	
	//출력 및 저장
	$("button[name=btn_printSave]").bind("click", function(event) {
		
		var frm = document.printAplDcsForm;
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
}

////////////////////////////////////////////////////////////////////////////////
// 서비스 함수
////////////////////////////////////////////////////////////////////////////////


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
	formPrint.find("input[name=title]").val("결정통지서 기간별출력");
	
	
	var mrdParamVal = "/rp [";
	mrdParamVal += $("select[name=instCd]").val();
	mrdParamVal += "] [";
	mrdParamVal += $("input[name=aplDtFrom]").val();
	mrdParamVal += "] [";
	mrdParamVal += $("input[name=aplDtTo]").val();
	mrdParamVal += "]";
	console.log(mrdParamVal);
	formPrint.find("input[name=mrdParam]").val(mrdParamVal);
			
	window.open('', 'popup', 'width=680, height=490, resizable=yes, location=no;');
	
	formPrint.attr("action", com.wise.help.url("/admin/expose/infoPrintPage/printNewAplDcsFromTo.do"));
	formPrint.attr("target", "popup");
	formPrint.submit(); 
}


////////////////////////////////////////////////////////////////////////////////
// 전처리 함수
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// 후처리 함수
////////////////////////////////////////////////////////////////////////////////


