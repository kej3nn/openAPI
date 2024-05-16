/*
 * @(#)linkMonitor.js 1.0 2019/08/05
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
			mainSheet.DoSearchPaging(com.wise.help.url("/admin/monitor/linkMonitorListPaging.do"), param);
			break;
		case "excel":
			mainSheet.Down2Excel({FileName:'Excel.xls',SheetName:'sheet'});
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
	createIBSheet2(document.getElementById("mainSheet"),"mainSheet", "100%", "350px");	// docInfMain Sheet
	
	var gridTitle = "NO|처리번호|DB 연계명|시스템|원천객체명|대상객체명|처리건수|처리 메세지|처리구분|처리일시";
	
	with(mainSheet){
     
		var cfg = {SearchMode:3,Page:50,VScrollMode:1};
	    SetConfig(cfg);
	    var headers = [
	                {Text:gridTitle, Align:"Center"}
	            ];
	    var headerInfo = {Sort:0,ColMove:1,ColResize:1,HeaderCheck:0};
	    
	    InitHeaders(headers, headerInfo);
	   
	    var cols = [
	                 {Type:"Seq",		SaveName:"seq",				Width:30,	Align:"Center",	Edit:false}
	                ,{Type:"int",		SaveName:"seqceNo",				Width:30,	Align:"Center",	Edit:false}
	                ,{Type:"Text",		SaveName:"dbConnJobNm",			Width:150,	Align:"Center",	Edit:false}
	                ,{Type:"Text",		SaveName:"srcSysNm",			Width:150,	Align:"Left",	Edit:false}
					,{Type:"Text",		SaveName:"srcObjNm",			Width:150,	Align:"Left",	Edit:false}
					,{Type:"Text",		SaveName:"targetObjNm",			Width:150,	Align:"Left",	Edit:false}
					,{Type:"Text",		SaveName:"prssCnt",			Width:50,	Align:"Right",	Edit:false}
					,{Type:"Text",		SaveName:"prssMsgCont",			Width:250,	Align:"Left",	Edit:false}
					,{Type:"Text",		SaveName:"jobTagNm",		Width:90,	Align:"Center",	Edit:false}
					,{Type:"Text",		SaveName:"regDtts",		Width:70,	Align:"Center",	Edit:false,	Format:"YmdHms"}
	            ];                                          
	    InitColumns(cols);
	    FitColWidth();
	    SetExtendLastCol(1);
	    
	    loadSheetOptions("mainSheet", 0, "jobTagCd", 	  "/admin/stat/ajaxOption.do", {grpCd:"C1024"});	// 처리구분
	    loadSheetOptions("mainSheet", 0, "srcSysCd", 	  "/admin/stat/ajaxOption.do", {grpCd:"A8010"});	// 시스템
	}               
	default_sheet(mainSheet);
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
	// 입력기간 초기화
	$("button[name=openDttm_reset]").bind("click", function(e) {
		$("input[name=beginOpenDttm], input[name=endOpenDttm]").val("");
	});
	
	$("button[name=btn_xlsDown]").bind("click", function(event){
		doActionMain("excel");
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
	
	$("form[name=mainForm]").find("input[name=beginOpenDttm]").val(today());
	$("form[name=mainForm]").find("input[name=endOpenDttm]").val(today());
	
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