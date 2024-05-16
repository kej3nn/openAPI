/*
 * @(#)acceptOpenDtfile.js 1.0 2015/06/01
 * 
 * COPYRIGHT (C) 2013 WISEITECH CO., LTD. ALL RIGHTS RESERVED.
 */

/**
 * 데이터 파일을 승인하는 스크립트이다.
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
    // 데이터 파일 시트 그리드를 생성한다.
    initSheetGrid({
        ElementId:"dtfile-sheet-section",
        SheetId:"DtfileSheet"
    }, {
        // Nothing do do.
    }, {
        HeaderCheck:0
    }, [
        { Header:"선택",             SaveName:"select",   Hidden:0, Width:80,  Align:"Center", Sort:0, Type:"Radio", RadioIcon:0, Edit:1 },
        { Header:"데이터파일ID",     SaveName:"dtfileId", Hidden:1, Width:0,   Align:"Center", Sort:0, Type:"Text",  RadioIcon:0, Edit:0 },
        { Header:"파일명",           SaveName:"fileNm",   Hidden:0, Width:240, Align:"Left",   Sort:0, Type:"Text",  RadioIcon:0, Edit:0 },
        { Header:"시트명",           SaveName:"shtNm",    Hidden:0, Width:240, Align:"Left",   Sort:0, Type:"Text",  RadioIcon:0, Edit:0 },
        { Header:"데이터시작행번호", SaveName:"strtRow",  Hidden:0, Width:120, Align:"Right",  Sort:0, Type:"Int",   RadioIcon:0, Edit:0 },
        { Header:"데이터시작열번호", SaveName:"strtCol",  Hidden:0, Width:120, Align:"Right",  Sort:0, Type:"Int",   RadioIcon:0, Edit:0 },
        { Header:"데이터종료행번호", SaveName:"endRow",   Hidden:0, Width:120, Align:"Right",  Sort:0, Type:"Int",   RadioIcon:0, Edit:0 },
        { Header:"승인여부",         SaveName:"accYn",    Hidden:0, Width:80,  Align:"Center", Sort:0, Type:"Combo", RadioIcon:0, Edit:0 },
        { Header:"테이블명",         SaveName:"tbNm",     Hidden:0, Width:240, Align:"Center", Sort:0, Type:"Text",  RadioIcon:0, Edit:0 }
    ], {
        // Nothing do do.
    });
    
    // 데이터 컬럼 시트 그리드를 생성한다.
    initSheetGrid({
        ElementId:"dtcols-sheet-section",
        SheetId:"DtcolsSheet",
        Height:"238px"
    }, {
        SearchMode:smGeneral
    }, {
        Sort:0,
        HeaderCheck:0
    }, [
        { Header:"데이터컬럼ID", SaveName:"dtcolsId", Hidden:1, Width:0,   Align:"Center", Type:"Text",     TrueValue:"1", FalseValue:"0", Edit:0, KeyField:0 },
        { Header:"데이터파일ID", SaveName:"dtfileId", Hidden:1, Width:0,   Align:"Center", Type:"Text",     TrueValue:"1", FalseValue:"0", Edit:0, KeyField:0 },
        { Header:"컬럼순서",     SaveName:"colSeq",   Hidden:0, Width:80,  Align:"Center", Type:"Int",      TrueValue:"1", FalseValue:"0", Edit:0, KeyField:0 },
        { Header:"컬럼명",       SaveName:"colExp",   Hidden:0, Width:240, Align:"Left",   Type:"Text",     TrueValue:"1", FalseValue:"0", Edit:0, KeyField:0 },
        { Header:"테이블컬럼명", SaveName:"colNm",    Hidden:0, Width:240, Align:"Left",   Type:"Text",     TrueValue:"1", FalseValue:"0", Edit:1, KeyField:1 },
        { Header:"데이터형식",   SaveName:"dttypeId", Hidden:0, Width:240, Align:"Left",   Type:"Combo",    TrueValue:"1", FalseValue:"0", Edit:0, KeyField:0 },
        { Header:"필수여부",     SaveName:"nullYn",   Hidden:0, Width:80,  Align:"Center", Type:"CheckBox", TrueValue:"N", FalseValue:"Y", Edit:0, KeyField:0 },
        { Header:"데이터정렬",   SaveName:"dataAli",  Hidden:0, Width:120, Align:"Center", Type:"Combo",    TrueValue:"1", FalseValue:"0", Edit:0, KeyField:0 },
        { Header:"데이터포맷",   SaveName:"dataFrm",  Hidden:0, Width:240, Align:"Left",   Type:"Text",     TrueValue:"1", FalseValue:"0", Edit:0, KeyField:0 }
    ], {
        CountPosition:0
    });
    
    window["DtfileSheet"].FitColWidth();
    window["DtcolsSheet"].FitColWidth();
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
    // 검색어 필드에 키다운 이벤트를 바인딩한다.
    $("#searchWord").bind("keydown", function(event) {
        // 엔터키인 경우
        if (event.which == 13) {
            // 데이터 파일을 검색한다.
            searchOpenDtfile();
            return false;
        }
    });
    
    // 조회 버튼에 클릭 이벤트를 바인딩한다.
    $("#search-button").bind("click", function(event) {
        // 데이터 파일을 검색한다.
        searchOpenDtfile();
        return false;
    });
    
    // 승인 버튼에 클릭 이벤트를 바인딩한다.
    $("#accept-button").bind("click", function(event) {
        // 데이터 파일을 승인한다.
        saveOpenDtfileAccYn();
        return false;
    });
}

/**
 * 옵션을 로드한다.
 */
function loadOptions() {
    // 승인여부 콤보 옵션을 초기화한다.
    initComboOptions("accYn", [{
        code:"",
        name:"전체"
    }, {
        code:"Y",
        name:"승인"
    }, {
        code:"N",
        name:"미승인"
    }], "");
    
    // 검색어 콤보 옵션을 초기화한다.
    initComboOptions("searchName", [{
        code:"fileNm",
        name:"파일명"
    }, {
        code:"shtNm",
        name:"시트명"
    }], "fileNm");
    
    // 데이터 파일 시트 승인여부 콤보 옵션을 초기화한다.
    initSheetOptions("DtfileSheet", 0, "accYn", [{
        code:"Y",
        name:"승인"
    }, {
        code:"N",
        name:"미승인"
    }]);
    
    // 데이터 컬럼 시트 데이터형식 콤보 옵션을 로드한다.
    loadSheetOptions("DtcolsSheet", 0, "dttypeId", "/admin/dtfile/searchOpenDttypeOpt.do", {
        // Nothing to do.
    });
    
    // 데이터 컬럼 시트 데이터정렬 콤보 옵션을 초기화한다.
    initSheetOptions("DtcolsSheet", 0, "dataAli", [{
        code:"Left",
        name:"좌측"
    }, {
        code:"Center",
        name:"중앙"
    }, {
        code:"Right",
        name:"우측"
    }]);
}

/**
 * 데이터를 로드한다.
 */
function loadData() {
    // 데이터 파일을 검색한다.
    searchOpenDtfile();
}

////////////////////////////////////////////////////////////////////////////////
// 서비스 함수
////////////////////////////////////////////////////////////////////////////////
/**
 * 데이터 파일을 검색한다.
 */
function searchOpenDtfile() {
    // 데이터 파일 시트 데이터를 로드한다.
    loadSheetData({
        SheetId:"DtfileSheet",
        PageUrl:"/admin/dtfile/searchOpenDtfile.do"
    }, {
        FormParam:"search-form"
    }, {
        // Nothing to do.
    });
}

/**
 * 데이터 컬럼을 검색한다.
 * 
 * @param key {String} 키
 */
function searchOpenDtcols(key) {
    // 데이터 컬럼 시트 데이터를 로드한다.
    loadSheetData({
        SheetId:"DtcolsSheet",
        SearchMode:smGeneral,
        PageUrl:"/admin/dtfile/searchOpenDtcols.do"
    }, {
        ObjectParam:{
            dtfileId:key
        }
    }, {
        // Nothing to do.
    });
}

/**
 * 데이터 파일을 승인한다.
 */
function saveOpenDtfileAccYn() {
    var sheet = window["DtfileSheet"];
    
    var index = sheet.FindCheckedRow("select");
    
    if (index) {
        var state = sheet.GetCellValue(parseInt(index), "accYn");
        
        if (state == "N") {
            var value = sheet.GetCellValue(parseInt(index), "dtfileId");
            
            // 데이터 파일을 승인한다.
            saveSheetData({
                SheetId:"DtcolsSheet",
                PageUrl:"/admin/dtfile/saveOpenDtfileAccYn.do"
            }, {
                ObjectParam:{
                    dtfileId:value
                }
            }, {
                AllSave:1
            });
        }
        else {
            alert("데이터 파일이 이미 승인되었습니다.");
        }
    }
    else {
        alert("데이터 파일을 선택하여 주십시오.");
    }
}

/**
 * 데이터 컬럼을 제거한다.
 */
function removeOpenDtcols() {
    window["DtcolsSheet"].RemoveAll();
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
 * 데이터 파일 시트 조회 완료 이벤트를 처리한다.
 * 
 * @param code {Number} 코드
 * @param message {String} 메시지
 * @param statusCode {Number} 상태 코드
 * @param statusMessage {String} 상태 메시지
 */
function DtfileSheet_OnSearchEnd(code, message, statusCode, statusMessage) {
    // 데이터 컬럼을 제거한다.
    removeOpenDtcols();
    
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
 * 데이터 파일 시트 클릭 이벤트를 처리한다.
 * 
 * @param row {Number} 행
 * @param column {Number} 열
 * @param value {String} 값
 * @param left {Number} X좌표
 * @param top {Number} Y좌표
 * @param width {Number} 너비
 * @param height {Number} 높이
 */
function DtfileSheet_OnClick(row, column, value, left, top, width, height) {
    if (row > 0) {
        var sheet = window["DtfileSheet"];
        
        switch (sheet.ColSaveName(0, column)) {
            case "select":
                if (value == "1") {
                    // 데이터 컬럼을 검색한다.
                    searchOpenDtcols(sheet.GetCellValue(row, "dtfileId"));
                }
                else {
                    // 데이터 컬럼을 제거한다.
                    removeOpenDtcols();
                }
                break;
        }
    }
}

/**
 * 데이터 컬럼 시트 조회 완료 이벤트를 처리한다.
 * 
 * @param code {Number} 코드
 * @param message {String} 메시지
 * @param statusCode {Number} 상태 코드
 * @param statusMessage {String} 상태 메시지
 */
function DtcolsSheet_OnSearchEnd(code, message, statusCode, statusMessage) {
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
 * 데이터 컬럼 시트 검증 이벤트를 처리한다.
 * 
 * @param row {Number} 행
 * @param column {Number} 열
 * @param value {Object} 값
 */
function DtcolsSheet_OnValidation(row, column, value) {
    if (row > 0) {
        var sheet = window["DtcolsSheet"];
        
        if (sheet.ExtendValidFail) {
            return;
        }
        
        switch (sheet.ColSaveName(0, column)) {
            case "colNm":
                if (!com.wise.util.isBytes(value, 0, 400)) {
                    alert("테이블컬럼명을 400바이트 이내로 입력하여 주십시오.");
                    sheet.ValidateFail(1);
                    sheet.ExtendValidFail = 1;
                    sheet.SelectCell(row, column);
                }
                break;
        }
    }
}

/**
 * 데이터 컬럼 시트 저장 완료 이벤트를 처리한다.
 * 
 * @param code {Number} 코드
 * @param message {String} 메시지
 * @param statusCode {Number} 상태 코드
 * @param statusMessage {String} 상태 메시지
 */
function DtcolsSheet_OnSaveEnd(code, message, statusCode, statusMessage) {
    if (code >= 0) {
        if (message) {
            alert(message);
        }
        
        // 데이터 파일을 검색한다.
        searchOpenDtfile();
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