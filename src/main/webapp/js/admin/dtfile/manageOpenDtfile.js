/*
 * @(#)manageOpenDtfile.js 1.0 2015/06/01
 * 
 * COPYRIGHT (C) 2013 WISEITECH CO., LTD. ALL RIGHTS RESERVED.
 */

/**
 * 데이터 파일을 관리하는 스크립트이다.
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
        { Header:"선택",             SaveName:"select",   Hidden:0, Width:80,  Align:"Center", Sort:0, Type:"DummyCheck", InsertEdit:0, UpdateEdit:1, KeyField:0 },
        { Header:"상태",             SaveName:"status",   Hidden:0, Width:80,  Align:"Center", Sort:0, Type:"Status",     InsertEdit:0, UpdateEdit:0, KeyField:0 },
        { Header:"데이터파일ID",       SaveName:"dtfileId", Hidden:1, Width:0,   Align:"Center", Sort:0, Type:"Text",       InsertEdit:0, UpdateEdit:0, KeyField:0 },
        { Header:"공공데이터ID",       SaveName:"infId",   Hidden:1, Width:320, Align:"Left",   Sort:0, Type:"Text",       InsertEdit:1, UpdateEdit:0, KeyField:1 },
        { Header:"테이블명",            SaveName:"tbNm",    Hidden:0, Width:320, Align:"Left",   Sort:0, Type:"Text",       InsertEdit:1, UpdateEdit:1, KeyField:1 },
        { Header:"보유데이터명",        SaveName:"dtNm",   Hidden:0, Width:320, Align:"Left",   Sort:0, Type:"Popup",       InsertEdit:1, UpdateEdit:0, KeyField:1 },
        { Header:"공공데이터명",        SaveName:"infNm",   Hidden:0, Width:320, Align:"Left",   Sort:0, Type:"Popup",       InsertEdit:1, UpdateEdit:0, KeyField:1 },
        { Header:"파일명",            SaveName:"fileNm",   Hidden:0, Width:320, Align:"Left",   Sort:0, Type:"Text",       InsertEdit:1, UpdateEdit:1, KeyField:1 },
        { Header:"시트명",            SaveName:"shtNm",    Hidden:0, Width:320, Align:"Left",   Sort:0, Type:"Text",       InsertEdit:1, UpdateEdit:1, KeyField:1 },
        { Header:"사용여부",         SaveName:"delYn",    Hidden:0, Width:80,  Align:"Center", Sort:0, Type:"Combo",      InsertEdit:0, UpdateEdit:1, KeyField:0 },
        { Header:"삭제",             SaveName:"delete",   Hidden:0, Width:80,  Align:"Center", Sort:0, Type:"DelCheck",   InsertEdit:1, UpdateEdit:1, KeyField:0 }
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
        { Header:"상태",         SaveName:"status",   Hidden:0, Width:80,  Align:"Center", Type:"Status",   TrueValue:"1", FalseValue:"0", InsertEdit:0, UpdateEdit:0, KeyField:0 },
        { Header:"데이터컬럼ID", SaveName:"dtcolsId", Hidden:1, Width:0,   Align:"Center", Type:"Text",     TrueValue:"1", FalseValue:"0", InsertEdit:0, UpdateEdit:0, KeyField:0 },
        { Header:"데이터파일ID", SaveName:"dtfileId", Hidden:1, Width:0,   Align:"Center", Type:"Text",     TrueValue:"1", FalseValue:"0", InsertEdit:0, UpdateEdit:0, KeyField:0 },
        { Header:"컬럼순서",     SaveName:"colSeq",   Hidden:0, Width:80,  Align:"Center", Type:"Int",      TrueValue:"1", FalseValue:"0", InsertEdit:0, UpdateEdit:0, KeyField:0 },
        { Header:"컬럼명",       SaveName:"colExp",   Hidden:0, Width:320, Align:"Left",   Type:"Text",     TrueValue:"1", FalseValue:"0", InsertEdit:1, UpdateEdit:1, KeyField:1 },
        { Header:"컬럼타입",   	SaveName:"type", Hidden:0, Width:160, Align:"Left",   Type:"Text",    TrueValue:"1", FalseValue:"0", InsertEdit:0, UpdateEdit:0, KeyField:0 },
        { Header:"데이터형식",   SaveName:"dttypeId", Hidden:0, Width:320, Align:"Left",   Type:"Combo",    TrueValue:"1", FalseValue:"0", InsertEdit:1, UpdateEdit:1, KeyField:1 },
        { Header:"데이터사이즈", SaveName:"srcColSize", Hidden:0, Width:120,   Align:"Center", Type:"Text",     TrueValue:"1", FalseValue:"0", InsertEdit:0, UpdateEdit:0, KeyField:0 },
        { Header:"단위", SaveName:"unitCd", Hidden:0, Width:120,   Align:"Center", Type:"Text",     TrueValue:"1", FalseValue:"0", InsertEdit:0, UpdateEdit:0, KeyField:0 },
        { Header:"필수여부",     SaveName:"nullYn",   Hidden:0, Width:80,  Align:"Center", Type:"CheckBox", TrueValue:"N", FalseValue:"Y", InsertEdit:1, UpdateEdit:1, KeyField:0 },
        { Header:"데이터정렬",   SaveName:"dataAli",  Hidden:0, Width:120, Align:"Center", Type:"Combo",    TrueValue:"1", FalseValue:"0", InsertEdit:1, UpdateEdit:1, KeyField:0 },
        { Header:"데이터포맷",   SaveName:"dataFrm",  Hidden:0, Width:240, Align:"Left",   Type:"Text",     TrueValue:"1", FalseValue:"0", InsertEdit:1, UpdateEdit:1, KeyField:0 },
        { Header:"사용여부",     SaveName:"delYn",   Hidden:0, Width:80,  Align:"Center", Type:"CheckBox", TrueValue:"N", FalseValue:"Y", InsertEdit:1, UpdateEdit:1, KeyField:0 },
//        { Header:"삭제",         SaveName:"delete",   Hidden:0, Width:80,  Align:"Center", Type:"DelCheck", TrueValue:"1", FalseValue:"0", InsertEdit:1, UpdateEdit:1, KeyField:0 }
        { Header:"colNm",     SaveName:"colNm",   Hidden:1, Width:0,  Align:"Center", Type:"Text", TrueValue:"1", FalseValue:"0", InsertEdit:0, UpdateEdit:0, KeyField:0 }
    ],
    {
        CountPosition:0
       
    }
    	
    );
    //InitColumns(initSheetGrid);                                                                                               
    //FitColWidth();                                                                       
   // SetExtendLastCol(1);     
    
    //SetColProperty("unitCd", ${codeMap.unitCdIbs});
    
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
    $("#infNm").bind("keydown", function(event) {
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
    
    // 데이터 파일 추가 버튼에 클릭 이벤트를 바인딩한다.
    $("#dtfile-add-button").bind("click", function(event) {
        // 데이터 파일을 추가한다.
        addOpenDtfile();
        return false;
    });
    
    // 데이터 파일 저장 버튼에 클릭 이벤트를 바인딩한다.
    $("#dtfile-save-button").bind("click", function(event) {
        // 데이터 파일을 저장한다.
        saveOpenDtfile();
        return false;
    });
    
    // 데이터 컬럼 추가 버튼에 클릭 이벤트를 바인딩한다.
    $("#dtcols-add-button").bind("click", function(event) {
        // 데이터 컬럼을 추가한다.
        addOpenDtcols();
        return false;
    });
    
    // 데이터 컬럼 저장 버튼에 클릭 이벤트를 바인딩한다.
    $("#dtcols-save-button").bind("click", function(event) {
        // 데이터 컬럼을 저장한다.
        saveOpenDtcols();
        return false;
    });
    
    
    // 분류, 조직 검색팝업 및 초기화 버튼 이벤트를 바인딩한다.
    var formObj = $("form[name=search-form]");
    
    formObj.find("button[name=btn_search]").eq(0).bind("click", function(e) { 
		popcatenm();
		 return false;               
	});
    
    formObj.find("button[name=btn_search]").eq(1).bind("click", function(e) { 
		poporgnm();
		 return false;        
	}); 
	 
	formObj.find("button[name=btn_init]").eq(0).bind("click", function(e) { 
		formObj.find("input[name=cateNm]").val("");
		formObj.find("input[name=cateId]").val("");
		return false;               
	}); 
	
	formObj.find("button[name=btn_init]").eq(1).bind("click", function(e) { 
		formObj.find("input[name=orgNm]").val("");
		formObj.find("input[name=orgCd]").val("");
		return false;               
	}); 
	
	// 위로 이동 버튼
	$('#dtcols-moveup-button').bind("click", function() {
		moveRow("up");
	});
	
	// 아래로 이동 버튼
	$('#dtcols-movedown-button').bind("click", function() {
		moveRow("down");
	});
}

/**
 * 옵션을 로드한다.
 */
function loadOptions() {
    // 검색어 콤보 옵션을 초기화한다.
//    initComboOptions("searchName", [{
//        code:"fileNm",
//        name:"파일명"
//    }, {
//        code:"shtNm",
//        name:"시트명"
//    }], "fileNm");
    
    // 데이터 파일 사용여부 콤보 옵션을 로드한다.
    initSheetOptions("DtfileSheet", 0, "delYn", [{
        code:"N",
        name:"Y"
    }, {
        code:"Y",
        name:"N"
    }]);
    
    // 데이터 파일 시트 승인여부 콤보 옵션을 로드한다.
    /*
    initSheetOptions("DtfileSheet", 0, "accYn", [{
        code:"Y",
        name:"승인"
    }, {
        code:"N",
        name:"미승인"
    }]);
    */
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
 * 데이터 파일을 추가한다.
 */
function addOpenDtfile() {
    // 데이터 파일 시트 데이터를 추가한다.
    addSheetData("DtfileSheet", 0, null, {
        fileNm:"Book1",
        shtNm:"Sheet1",
        accYn:"N"
    });
}

/**
 * 데이터 파일을 저장한다.
 */
function saveOpenDtfile() {
    // 데이터 파일 시트 데이터를 저장한다.
    saveSheetData({
        SheetId:"DtfileSheet",
        PageUrl:"/admin/dtfile/saveOpenDtfile.do"
    }, {
        // Nothing to do.
    }, {
        // Nothing do do.
    });
}

/**
 * 데이터 컬럼을 검색한다.
 * 
 * @param key {String} 키
 */
function searchOpenDtcols(key) {
    if (key) {
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
    else {
        var sheet = window["DtfileSheet"];
        
        var index = sheet.FindCheckedRow("select");
        
        if (index) {
            var value = sheet.GetCellValue(parseInt(index), "dtfileId");
            
            if (value) {
                // 데이터 컬럼을 검색한다.
                searchOpenDtcols(value);
            }
            else {
                // 데이터 컬럼을 제거한다.
                removeOpenDtcols();
            }
        }
        else {
            // 데이터 컬럼을 제거한다.
            removeOpenDtcols();
        }
    }
}

/**
 * 데이터 컬럼을 추가한다.
 */
function addOpenDtcols() {
    var sheet = window["DtfileSheet"];
    
    var index = sheet.FindCheckedRow("select");
    
    if (index) {
        var value = sheet.GetCellValue(parseInt(index), "dtfileId");
        
        if (value) {
            var state = sheet.GetCellValue(parseInt(index), "accYn");
            
            if (state == "N") {
                // 데이터 컬럼 시트 데이터를 추가한다.
                addSheetData("DtcolsSheet", null, null, {
                    dtfileId:value
                });
                
                // 데이터 컬럼을 정렬한다.
                orderOpenDtcols();
            }
            else {
                alert("승인된 데이터 파일의 컬럼은 변경할 수 없습니다.");
            }
        }
        else {
            alert("데이터 파일을 저장하여 주십시오.");
        }
    }
    else {
        alert("데이터 파일을 선택하여 주십시오.");
    }
}

/**
 * 데이터 컬럼을 저장한다.
 */
function saveOpenDtcols() {
    var sheet = window["DtfileSheet"];
    
    var index = sheet.FindCheckedRow("select");
    
    if (index) {
        var value = sheet.GetCellValue(parseInt(index), "dtfileId");
        
        if (value) {
//            var state = sheet.GetCellValue(parseInt(index), "accYn");
            
//            if (state == "N") {
                // 데이터 컬럼을 정렬한다.
                orderOpenDtcols();
                
                // 데이터 컬럼 시트 데이터를 저장한다.
                saveSheetData({
                    SheetId:"DtcolsSheet",
                    PageUrl:"/admin/dtfile/saveOpenDtcols.do"
                }, {
                    // Nothing to do.
                }, {
                    // Nothing do do.
                });
//            }
//            else {
//                alert("승인된 데이터 파일의 컬럼은 변경할 수 없습니다.");
//            }
        }
        else {
            alert("데이터 파일을 저장하여 주십시오.");
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

/**
 * 데이터 컬럼을 정렬한다.
 */
function orderOpenDtcols() {
    var sheet = window["DtcolsSheet"];
    
    var count = sheet.RowCount();
    
    for (var i = 0, r = 1, n = 1; i < count; i++, r++) {
        if (sheet.GetCellValue(r, "status") == "D") {
            sheet.SetCellValue(r, "colSeq", "");
        }
        else {
            sheet.SetCellValue(r, "colSeq", n++);
        }
    }
}

/**
 * 분류 팝업
 */
function popcatenm() {
	var url = "/admin/opendt/openCateParListPopUp.do?cateGb=2";
	var popup = OpenWindow(url,"openCateParListPopUp","500","550","yes");
}

/**
 * 조직명 팝업
 */
function poporgnm() {
	var url="/admin/basicinf/popup/commOrg_pop.do";
	var popup = OpenWindow(url,"orgPop","500","550","yes");
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
                    var array = sheet.FindCheckedRow(column).split("|");
                    
                    for (var i = 0; i < array.length; i++) {
                        if (array[i]) {
                            var index = parseInt(array[i]);
                            
                            if (index != row) {
                                sheet.SetCellValue(index, column, 0);
                            }
                        } 
                    }
                    
                    // 데이터 컬럼을 검색한다.
                    searchOpenDtcols(sheet.GetCellValue(row, "dtfileId"));
                }
                else {
                    // 데이터 컬럼을 제거한다.
                    removeOpenDtcols();
                }
                break;
            case "delete":
                if (value == "1") {
                    if (sheet.GetCellValue(row, "select") == "1") {
                        sheet.SetCellValue(row, "select", 0);
                        
                        // 데이터 컬럼을 제거한다.
                        removeOpenDtcols();
                    }
                }
                break;
        }
    }
}


/**
 * 데이터 파일 시트 팝업 클릭시 이벤트를 처리한다.
 * @param Row
 * @param Col
 */
function DtfileSheet_OnPopupClick(Row,Col) {
	var url="/admin/dtfile/popup/openDtfileIBS_pop.do?sheetId=DtfileSheet";
	var popup = OpenWindow(url,"OpenInfdtfilePop","700","550","yes");	
}

/**
 * 데이터 파일 시트 검증 이벤트를 처리한다.
 * 
 * @param row {Number} 행
 * @param column {Number} 열
 * @param value {Object} 값
 */
function DtfileSheet_OnValidation(row, column, value) {
    if (row > 0) {
        var sheet = window["DtfileSheet"];
        
        if (sheet.ExtendValidFail) {
            return;
        }
        
        switch (sheet.ColSaveName(0, column)) {
            case "fileNm":
                if (!com.wise.util.isBytes(value, 0, 400)) {
                    alert("파일명을 400바이트 이내로 입력하여 주십시오.");
                    sheet.ValidateFail(1);
                    sheet.ExtendValidFail = 1;
                    sheet.SelectCell(row, column);
                }
                break;
            case "shtNm":
                if (!com.wise.util.isBytes(value, 0, 400)) {
                    alert("시트명을 400바이트 이내로 입력하여 주십시오.");
                    sheet.ValidateFail(1);
                    sheet.ExtendValidFail = 1;
                    sheet.SelectCell(row, column);
                }
                break;
        }
    }
}

/**
 * 데이터 파일 시트 저장 완료 이벤트를 처리한다.
 * 
 * @param code {Number} 코드
 * @param message {String} 메시지
 * @param statusCode {Number} 상태 코드
 * @param statusMessage {String} 상태 메시지
 */
function DtfileSheet_OnSaveEnd(code, message, statusCode, statusMessage) {
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
 * 데이터 컬럼 시트 클릭 이벤트를 처리한다.
 * 
 * @param row {Number} 행
 * @param column {Number} 열
 * @param value {String} 값
 * @param left {Number} X좌표
 * @param top {Number} Y좌표
 * @param width {Number} 너비
 * @param height {Number} 높이
 */
function DtcolsSheet_OnClick(row, column, value, left, top, width, height) {
    if (row > 0) {
        var sheet = window["DtcolsSheet"];
        
        switch (sheet.ColSaveName(0, column)) {
            case "delete":
                // 데이터 컬럼을 정렬한다.
                orderOpenDtcols();
                break;
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
            case "colExp":
                if (!com.wise.util.isBytes(value, 0, 400)) {
                    alert("컬럼명을 400바이트 이내로 입력하여 주십시오.");
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
        
        // 데이터 컬럼을 검색한다.
        searchOpenDtcols();
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

function moveRow(flag) {
	var gridObj = window["DtcolsSheet"];
	if(flag == "up") {
		if(gridObj.GetSelectRow() < 2){
			alert("이동할 행을 선택하세요.");
		}else{
			var selRow = gridObj.GetSelectRow();	//선택된 Row 구하기
			gridObj.DataMove(selRow-1, selRow);		//행 이동
			setOrder(gridObj);	//순서 재설정
		}
	} else if(flag == "down") {
		if(gridObj.GetSelectRow() < 1){
			alert("이동할 행을 선택하세요.");
		}else{
			var selRow = gridObj.GetSelectRow();	//선택된 Row 구하기
			gridObj.DataMove(selRow+2, selRow);		//행 이동
			setOrder(gridObj);	//순서 재설정
		}
	}		
}

function setOrder(objId){
	var order = 1;
	var tmpOrder = "";
	for(var i=1; i<=objId.LastRow(); i++){
		tmpOrder= "colSeq";
		objId.SetCellValue(i,tmpOrder, order);
		order++;
	}
}
