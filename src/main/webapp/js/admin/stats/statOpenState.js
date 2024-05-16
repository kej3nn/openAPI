/*
 * @(#)statStddUi.js 1.0 2018/01/26
 * 
 * COPYRIGHT (C) 2013 WISEITECH CO., LTD. ALL RIGHTS RESERVED.
 */

/**
 * 관리자 통계 공개현황 스크립트 파일이다
 *
 * @author 김정호
 * @version 1.0 2018/01/26
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
	// 표준항목 분류정의 시트 그리드를 생성한다.
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
	doAction("searchTbl");
	doAction("searchOpen");
}

////////////////////////////////////////////////////////////////////////////////
// 서비스 함수
////////////////////////////////////////////////////////////////////////////////

/**
 * 화면 액션
 */
function doAction(sAction) {

	switch(sAction) {                       
		case "searchTbl":
			ajaxBeforeSendAdmin(com.wise.help.url("/admin/ajaxBeforeSendAdmin.do")); //IbSheet 조회전 세션 체크
			sheet.DoSearchPaging(com.wise.help.url("/admin/stat/statOpenStateList.do"), {});
			break;
		case "searchOpen":
			 doSelect({
			        url:"/admin/stat/statTblStateList.do",
			        before:function () {return {};},
			        after: afterStatTblStateList
			    });
			break;	
		case "excel":      
			sheet.Down2Excel({FileName:'Excel.xls',SheetName:'mySheet'});
			break;	
	}
}
////////////////////////////////////////////////////////////////////////////////
// 전처리 함수
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// 후처리 함수
////////////////////////////////////////////////////////////////////////////////
//통계표 현황 후처리
function afterStatTblStateList(data) {
	iter = data[0];
	for (var key in iter) {
		$("#" + key).text(iter[key] + "건");
	}
}
////////////////////////////////////////////////////////////////////////////////
//시트 로드
////////////////////////////////////////////////////////////////////////////////
function loadSheet() {
	
	createIBSheet2(document.getElementById("sheet"),"sheet", "100%", "600px");
	
	var gridTitle ="NO";
	gridTitle +="|제공기관";
	gridTitle +="|합계";
	gridTitle +="|미공개";
	gridTitle +="|공개";
	gridTitle +="|공개불가";
	gridTitle +="|공개취소";
	
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
					,{Type:"Text",		SaveName:"orgNm",		Width:260,	Align:"Left",		Edit:false}
					,{Type:"AutoSum",	SaveName:"openTot",		Width:100,	Align:"Center",		Edit:false}
					,{Type:"AutoSum",	SaveName:"openN",		Width:80,	Align:"Center",		Edit:false}
					,{Type:"AutoSum",	SaveName:"openY",		Width:80,	Align:"Center",		Edit:false}
					,{Type:"AutoSum",	SaveName:"openX",		Width:80,	Align:"Center",		Edit:false}
					,{Type:"AutoSum",	SaveName:"openC",		Width:80,	Align:"Center",		Edit:false}
	            ];                                          
	    InitColumns(cols);
	    FitColWidth();
	    SetExtendLastCol(1);
	    
	    SetSumValue(0, "seq", "합계"); 
	    SetAutoSumPosition("1"); //autoSum 위치 지정 1은 최하단 0은 최상단 
	}               
	default_sheet(sheet);   
	
}

