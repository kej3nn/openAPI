/*
 * @(#)manageOpenDttype.js 1.0 2015/06/01
 * 
 * COPYRIGHT (C) 2013 WISEITECH CO., LTD. ALL RIGHTS RESERVED.
 */

/**
 * 데이터 유형을 관리하는 스크립트이다.
 *
 * @author 김은삼
 * @version 1.0 2015/06/01
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
    // 데이터 유형 시트 그리드를 생성한다.
    initSheetGrid({
        ElementId:"dttype-sheet-section",
        SheetId:"DttypeSheet",
        Height:"338px"
    }, {
        SearchMode:smGeneral
    }, {
        Sort:0,
        HeaderCheck:0
    }, [
        { Header:"NO",         	 SaveName:"seq",   		Hidden:0, Width:80,  Align:"Center", Type:"Seq",   	  InsertEdit:0, UpdateEdit:0, KeyField:0 },
        { Header:"상태",         SaveName:"status",   	Hidden:0, Width:80,  Align:"Center", Type:"Status",   InsertEdit:0, UpdateEdit:0, KeyField:0 },
        { Header:"삭제",         SaveName:"del",   		Hidden:0, Width:80,  Align:"Center", Type:"DelCheck", InsertEdit:1, UpdateEdit:1, KeyField:0 },
        { Header:"검증유형ID",   SaveName:"verifyId", 	Hidden:0, Width:0,   Align:"Center", Type:"Text",     InsertEdit:0, UpdateEdit:0, KeyField:0 },
        { Header:"검증유형명",   SaveName:"verifyNm", 	Hidden:0, Width:380, Align:"Left",   Type:"Text",     InsertEdit:1, UpdateEdit:1, KeyField:1 },
        { Header:"컬럼형식",     SaveName:"coltyCd",   	Hidden:0, Width:140, Align:"Left",   Type:"Combo",    InsertEdit:1, UpdateEdit:1, KeyField:1 },
        { Header:"길이", 	     SaveName:"colSize",   	Hidden:0, Width:140, Align:"Right",  Type:"Int",      InsertEdit:1, UpdateEdit:1, KeyField:1 },
        { Header:"검증형식",     SaveName:"verifyCd",   Hidden:0, Width:120, Align:"Center", Type:"Combo",    InsertEdit:1, UpdateEdit:1, KeyField:1 },
        { Header:"검증패턴",     SaveName:"verifyPatn", Hidden:0, Width:300, Align:"Left",   Type:"Text",     InsertEdit:1, UpdateEdit:1, KeyField:1 },
        { Header:"정렬순서",     SaveName:"vOrder",     Hidden:1, Width:80,  Align:"Left",   Type:"Int",      InsertEdit:0, UpdateEdit:0, KeyField:1 },
        { Header:"사용여부",     SaveName:"useYn",   	Hidden:0, Width:80,  Align:"Center", Type:"CheckBox", InsertEdit:1, UpdateEdit:1, KeyField:0, TrueValue:"Y", FalseValue:"N"}
    ], {
        CountPosition:0
    });
    
    window["DttypeSheet"].FitColWidth();
    default_sheet(window["DttypeSheet"]);
}

/**
 * 마스크를 바인딩한다.
 */
function bindMask() {
    // Nothing to do.
}

/**
 * 이벤트를 바인딩한다.
 */
function bindEvent() {
    // 데이터 유형 추가 버튼에 클릭 이벤트를 바인딩한다.
    $("#dttype-add-button").bind("click", function(event) {
        // 데이터 유형을 추가한다.
        addOpenDttype();
        return false;
    });
    
    // 데이터 유형 저장 버튼에 클릭 이벤트를 바인딩한다.
    $("#dttype-save-button").bind("click", function(event) {
        // 데이터 유형을 저장한다.
        saveOpenDttype();
        return false;
    });
    
    // 데이터 유형 조회 버튼에 클릭 이벤트를 바인딩한다.
    $("button[name=btn_inquiry]").bind("click", function(event) {
        // 데이터 유형을 검색한다.
        searchOpenDttype();
        return false;
    });
  //조회 enter
	$("input[name=searchVal]").bind("keydown", function(event) {
        // 엔터키인 경우
        if (event.which == 13) {
        	searchOpenDttype();
            return false;
        }
    });
}

/**
 * 옵션을 로드한다.
 */
function loadOptions() {
    // 데이터 유형 시트 데이터타입 콤보 옵션을 초기화한다.
	loadSheetOptions("DttypeSheet", 0, "coltyCd", "/admin/stat/ajaxOption.do", {grpCd:"D2006"});
	//loadComboOptions("coltyCd", "/admin/stat/ajaxOption.do", {grpCd:"D2006"}, "");
    /*
	initSheetOptions("DttypeSheet", 0, "coltyCd", [{
        code:"INTEGER",
        name:"정수"
    }, {
        code:"DECIMAL",
        name:"실수"
    }, {
        code:"CHAR",
        name:"고정문자열"
    }, {
        code:"VARCHAR",
        name:"가변문자열"
    }]);*/
    
    // 데이터 유형 시트 검증방식 콤보 옵션을 초기화한다.
	//loadComboOptions("verifyCd", "/admin/stat/ajaxOption.do", {grpCd:"D2007"}, "");
	loadSheetOptions("DttypeSheet", 0, "verifyCd", "/admin/stat/ajaxOption.do", {grpCd:"D2007"});
	/*
    initSheetOptions("DttypeSheet", 0, "veriTy", [{
        code:"REG_EXP",
        name:"정규식"
    }]);*/
}

/**
 * 데이터를 로드한다.
 */
function loadData() {
    // 데이터 유형을 검색한다.
    searchOpenDttype();
}

////////////////////////////////////////////////////////////////////////////////
// 서비스 함수
////////////////////////////////////////////////////////////////////////////////
/**
 * 데이터 유형을 검색한다.
 */
function searchOpenDttype() {
    // 데이터 유형 시트 데이터를 로드한다.
    loadSheetData({
        SheetId:"DttypeSheet",
        SearchMode:smGeneral,
        PageUrl:"/admin/dtfile/searchOpenDttype.do"
    }, {
    	FormParam:"search-form"
    }, {
        // Nothing to do.
    });
}

/**
 * 데이터 유형을 추가한다.
 */
function addOpenDttype() {
	/*
    // 데이터 유형 시트 데이터를 추가한다.
    addSheetData("DttypeSheet", null, null, {
        // Nothing to do.
    });
    */
	var row = window["DttypeSheet"].DataInsert();
	window["DttypeSheet"].SetCellValue(row, "useYn", "Y");
    // 데이터 유형을 정렬한다.
    orderOpenDttype();
}

/**
 * 데이터 유형을 저장한다.
 */
function saveOpenDttype() {
    // 데이터 유형을 정렬한다.
    orderOpenDttype();
    
    // 데이터 유형 시트 데이터를 저장한다.
    saveSheetData({
        SheetId:"DttypeSheet",
        PageUrl:"/admin/dtfile/saveOpenDttype.do"
    }, {
        // Nothing to do.
    }, {
        // Nothing do do.
    });
}

/**
 * 데이터 유형을 정렬한다.
 */
function orderOpenDttype() {
    var sheet = window["DttypeSheet"];
    
    var count = sheet.RowCount();
    
    for (var i = 0, r = 1, n = 1; i < count; i++, r++) {
        if (sheet.GetCellValue(r, "status") == "D") {
            sheet.SetCellValue(r, "vOrder", "");
        }
        else {
            sheet.SetCellValue(r, "vOrder", n++);
        }
    }
}

////////////////////////////////////////////////////////////////////////////////
// 전처리 함수
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// 후처리 함수
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// 이벤트 함수
////////////////////////////////////////////////////////////////////////////////
/**
 * 데이터 유형 시트 조회 완료 이벤트를 처리한다.
 * 
 * @param code {Number} 코드
 * @param message {String} 메시지
 * @param statusCode {Number} 상태 코드
 * @param statusMessage {String} 상태 메시지
 */
function DttypeSheet_OnSearchEnd(code, message, statusCode, statusMessage) {
    if (code >= 0) {
        if (message) {
            alert(message);
        }
    }
    else {
        if (message) {
            alert(message);
        }
        else {
            handleSheetError(statusCode, statusMessage);
        }
    }
}

/**
 * 데이터 유형 시트 클릭 이벤트를 처리한다.
 * 
 * @param row {Number} 행
 * @param column {Number} 열
 * @param value {String} 값
 * @param left {Number} X좌표
 * @param top {Number} Y좌표
 * @param width {Number} 너비
 * @param height {Number} 높이
 */
function DttypeSheet_OnClick(row, column, value, left, top, width, height) {
    if (row > 0) {
        var sheet = window["DttypeSheet"];
        
        switch (sheet.ColSaveName(0, column)) {
            case "del":
                // 데이터 유형을 정렬한다.
                orderOpenDttype();
                break;
        }
    }
}

/**
 * 데이터 유형 시트 검증 이벤트를 처리한다.
 * 
 * @param row {Number} 행
 * @param column {Number} 열
 * @param value {Object} 값
 */
function DttypeSheet_OnValidation(row, column, value) {
    if (row > 0) {
        var sheet = window["DttypeSheet"];
        
        if (sheet.ExtendValidFail) {
            return;
        }
        
        switch (sheet.ColSaveName(0, column)) {
            case "dttypeNm":
                if (!com.wise.util.isBytes(value, 0, 400)) {
                    alert("데이터 타입명을 400바이트 이내로 입력하여 주십시오.");
                    sheet.ValidateFail(1);
                    sheet.ExtendValidFail = 1;
                    sheet.SelectCell(row, column);
                }
                break;
            case "dataSz":
                if (sheet.GetCellValue(row, "dataTy") == "CHAR" && (value || 0) < 1) {
                    alert("데이터 사이즈를 입력하여 주십시오.");
                    sheet.ValidateFail(1);
                    sheet.ExtendValidFail = 1;
                    sheet.SelectCell(row, column);
                }
                break;
        }
    }
}

/**
 * 데이터 유형 시트 저장 완료 이벤트를 처리한다.
 * 
 * @param code {Number} 코드
 * @param message {String} 메시지
 * @param statusCode {Number} 상태 코드
 * @param statusMessage {String} 상태 메시지
 */
function DttypeSheet_OnSaveEnd(code, message, statusCode, statusMessage) {
    if (code >= 0) {
        if (message) {
            alert(message);
        }
        
        // 데이터 유형을 검색한다.
        searchOpenDttype();
    }
    else {
        if (message) {
            alert(message);
        }
        else {
            handleSheetError(statusCode, statusMessage);
        }
    }
}