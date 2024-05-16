/*
 * @(#)manageOpenDttran.js 1.0 2015/06/01
 * 
 * COPYRIGHT (C) 2013 WISEITECH CO., LTD. ALL RIGHTS RESERVED.
 */

/**
 * 데이터 처리를 관리하는 스크립트이다.
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
/**
 * 검색 간격
 */
var SEARCH_INTERVAL = 60;

////////////////////////////////////////////////////////////////////////////////
// 초기화 함수
////////////////////////////////////////////////////////////////////////////////
/**
 * 컴포넌트를 초기화한다.
 */
function initComp() {
    // 데이터 처리 시트 그리드를 생성한다.
    initSheetGrid({
        ElementId:"dttran-sheet-section",
        SheetId:"DttranSheet"
    }, {
        // Nothing do do.
    }, {
        HeaderCheck:0
    }, [
		{ Header:"선택",         SaveName:"select",   Hidden:0, Width:60,  Align:"Center", Sort:0, Type:"Radio",  RadioIcon:0, Edit:1 },
		{ Header:"데이터처리ID", SaveName:"dttranId", Hidden:1, Width:0,   Align:"Center", Sort:0, Type:"Text",   RadioIcon:1, Edit:0 },
		{ Header:"데이터파일ID", SaveName:"dtfileId", Hidden:1, Width:0,   Align:"Center", Sort:0, Type:"Text",   RadioIcon:1, Edit:0 },
		{ Header:"업로드스케쥴번호", SaveName:"uplSchNo", Hidden:1, Width:0,   Align:"Center", Sort:0, Type:"Text",   RadioIcon:1, Edit:0 },
		{ Header:"업로드예정일",     SaveName:"loadYmd",   Hidden:0, Width:100,  Align:"Center", Sort:0, Type:"Text",  RadioIcon:1, Edit:0 },
		{ Header:"보유데이터명",     SaveName:"dtNm",   Hidden:0, Width:150,  Align:"Center", Sort:0, Type:"Text",  RadioIcon:1, Edit:0 },
		{ Header:"공공데이터명",     SaveName:"infNm",   Hidden:0, Width:150,  Align:"Center", Sort:0, Type:"Text",  RadioIcon:1, Edit:0 },
		{ Header:"파일명",       SaveName:"fileNm",   Hidden:0, Width:150, Align:"Left",   Sort:0, Type:"Text",   RadioIcon:1, Edit:0 },
		{ Header:"시트명",       SaveName:"shtNm",    Hidden:0, Width:150, Align:"Left",   Sort:0, Type:"Text",   RadioIcon:1, Edit:0 },
		{ Header:"파일형식",     SaveName:"fileTy",   Hidden:0, Width:80,  Align:"Center", Sort:0, Type:"Text",  RadioIcon:1, Edit:0 },
		{ Header:"파일크기",     SaveName:"fileSize",   Hidden:0, Width:80,  Align:"Right",  Sort:0, Type:"Int",    RadioIcon:1, Edit:0 },
		{ Header:"적재주기",     SaveName:"loadCd", Hidden:0, Width:80,  Align:"Center", Sort:0, Type:"Combo",  RadioIcon:1, Edit:0 },
		{ Header:"시작일시",     SaveName:"strtDttm", Hidden:0, Width:150, Align:"Center", Sort:0, Type:"Text",   RadioIcon:1, Edit:0 },
		{ Header:"종료일시",     SaveName:"endDttm",  Hidden:0, Width:150, Align:"Center", Sort:0, Type:"Text",   RadioIcon:1, Edit:0 },
		{ Header:"전체건수",     SaveName:"totCnt",   Hidden:0, Width:80,  Align:"Right",  Sort:0, Type:"Int",    RadioIcon:1, Edit:0 },
		{ Header:"정상건수",     SaveName:"valCnt",   Hidden:0, Width:80,  Align:"Right",  Sort:0, Type:"Int",    RadioIcon:1, Edit:0 },
		{ Header:"오류건수",     SaveName:"errCnt",   Hidden:0, Width:80,  Align:"Right",  Sort:0, Type:"Int",    RadioIcon:1, Edit:0 },
		{ Header:"검증결과",     SaveName:"chckYn",   Hidden:0, Width:80,  Align:"Center", Sort:0, Type:"Combo",  RadioIcon:1, Edit:0 },
		{ Header:"처리결과",     SaveName:"procRslt", Hidden:0, Width:347, Align:"Left",   Sort:0, Type:"Text",   RadioIcon:1, Edit:0 },
		{ Header:"처리상태",     SaveName:"procStat", Hidden:0, Width:80,  Align:"Center", Sort:0, Type:"Combo",  RadioIcon:1, Edit:0 },
        
    ], {
        // Nothing do do.
    });
    
    // window["DttranSheet"].FitColWidth();
    
    // 데이터 검증 시트를 생성한다.
    createDtchckSheet("Create");
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
//    $("#searchWord").bind("keydown", function(event) {
//        // 엔터키인 경우
//        if (event.which == 13) {
//            // 데이터 처리를 검색한다.
//            searchOpenDttran("");
//            return false;
//        }
//    });
    
    // 조회 버튼에 클릭 이벤트를 바인딩한다.
    $("#search-button").bind("click", function(event) {
        // 데이터 처리를 검색한다.
        searchOpenDttran("");
        return false;
    });
    
    // 엑셀97로 다운로드 버튼에 클릭 이벤트를 바인딩한다.
    $("#excel1997-download-button").bind("click", function(event) {
        // 데이터 검증을 다운로드한다.
        downOpenDtchck("xls");
        return false;
    });
    
    // 엑셀2007로 다운로드 버튼에 클릭 이벤트를 바인딩한다.
    $("#excel2007-download-button").bind("click", function(event) {
        // 데이터 검증을 다운로드한다.
        downOpenDtchck("xlsx");
        return false;
    });
    
    // 지우고 저장하기 버튼에 클릭 이벤트를 바인딩한다.
    $("#create-save-button").bind("click", function(event) {
        // 데이터 파일 테이블에 데이터를 저장한다.
        if(confirm("지우고 저장하기 버튼을 클릭할 경우 기존에 입력된 모든 데이터가 지워지고 저장됩니다.\n 정말로 저장하시겠습니까?")) {
        	saveOpenDtfileTb("create");
        }
        return false;
    });
    
    // 이어서 저장하기 버튼에 클릭 이벤트를 바인딩한다.
    $("#append-save-button").bind("click", function(event) {
        // 데이터 파일 테이블에 데이터를 저장한다.
        saveOpenDtfileTb("append");
        return false;
    });
}

/**
 * 옵션을 로드한다.
 */
function loadOptions() {
    // 처리상태 콤보 옵션을 초기화한다.
    initComboOptions("procStat", [{
        code:"",
        name:"전체"
    }, {
        code:"I",
        name:"처리중"
    }, {
        code:"C",
        name:"완료"
    }, {
        code:"E",
        name:"오류"
    }], "");
    
    // 검색어 콤보 옵션을 초기화한다.
//    initComboOptions("searchName", [{
//        code:"fileNm",
//        name:"파일명"
//    }, {
//        code:"shtNm",
//        name:"시트명"
//    }], "fileNm");
    
 // 적재주기 콤보 옵션을 초기화한다.
	loadComboOptions2("loadCd",
	"/admin/dtfile/ajaxCombo.do",
	{grpCd:"D1009"},
	"");
    
    // 데이터 처리 시트 파일양식 콤보 옵션을 초기화한다.
    initSheetOptions("DttranSheet", 0, "uploadTy", [{
        code:"P",
        name:"서버양식"
    }, {
        code:"T",
        name:"기본양식"
    }]);
    
    // 데이터 처리 시트 파일형식 콤보 옵션을 초기화한다.
    initSheetOptions("DttranSheet", 0, "fileTy", [{
        code:"xls",
        name:"엑셀97"
    }, {
        code:"xlsx",
        name:"엑셀2007"
    }]);
    
    // 데이터 처리 시트 처리상태 콤보 옵션을 초기화한다.
    initSheetOptions("DttranSheet", 0, "procStat", [{
        code:"I",
        name:"처리중"
    }, {
        code:"C",
        name:"완료"
    }, {
        code:"E",
        name:"오류"
    }]);
    
    // 데이터 처리 시트 검증결과 콤보 옵션을 초기화한다.
    initSheetOptions("DttranSheet", 0, "chckYn", [{
        code:"Y",
        name:"정상"
    }, {
        code:"N",
        name:"오류"
    }]);
    
    // 적재주기 콤보 옵션을 초기화한다.
	initComboOptions("procStat", [{
        code:"",
        name:"전체"
    }].concat([{
        code:"I",
        name:"처리중"
    }, {
        code:"C",
        name:"완료"
    }, {
        code:"E",
        name:"오류"
    }]), "");
	
	//적재주기 콤보 옵션을 설정한다.
	loadSheetOptions("DttranSheet",0,"loadCd",
	"/admin/dtfile/ajaxCombo.do",
	{grpCd:"D1009"});
	
}

/**
 * 데이터를 로드한다.
 */
function loadData() {
    // 데이터 처리를 검색한다.
    searchOpenDttran($("#dttranId").val());
}

////////////////////////////////////////////////////////////////////////////////
// 서비스 함수
////////////////////////////////////////////////////////////////////////////////
/**
 * 데이터 처리를 검색한다.
 * 
 * @param key {String} 키
 */
function searchOpenDttran(key) {
    $("#dttranId").val(key);
    
    // 데이터 처리 시트 데이터를 로드한다.
    loadSheetData({
        SheetId:"DttranSheet",
        PageUrl:"/admin/dtfile/searchOpenDttran.do"
    }, {
        FormParam:"search-form"
    }, {
        // Nothing to do.
    });
}

/**
 * 데이터 컬럼 정의를 검색한다.
 * 
 * @param params {Object} 행
 */
function searchOpenDtcolsDef(params) {
    // 데이터 컬럼 정의 검색 전처리를 실행한다.
    if (beforeSearchOpenDtcolsDef()) {
        $.post(
            com.wise.help.url("/admin/dtfile/searchOpenDtcolsDef.do"),
            {
                dtfileId:params.dtfileId
            },
            function(data, status, request) {
                // 데이터 컬럼 정의 검색 후처리를 실행한다.
                afterSearchOpenDtcolsDef(data, status, request, params);
            },
            "json"
        ).error(function(request, status, error) {
            handleError(status, error);
            
            // 데이터 검증 시트를 생성한다.
            createDtchckSheet("Reset");
        });
    }
}

/**
 * 데이터 검증 시트를 생성한다.
 * 
 * @param mode {String} 모드
 * @param data {Array} 데이터
 */
function createDtchckSheet(mode, data) {
    var columns = data || [{ Header:"", SaveName:"dummy", Align:"Center", Type:"Text", Edit:0 }];
    
    // 데이터 검증 시트 그리드를 생성한다.
    initSheetGrid({
        ElementId:"dtchck-sheet-section",
        SheetId:"DtchckSheet",
        CreateMode:mode
    }, {
        // Nothing do do.
    }, {
        Sort:0,
        HeaderCheck:0
    }, columns, {
        // Nothing do do.
    });
    
    var sheet = window["DtchckSheet"];
    
    var width = 0;
    
    for (var i = 0; i < columns.length; i++) {
        width += sheet.GetColWidth(i);
    }
    
    if (sheet.GetSheetWidth() > width) {
        sheet.FitColWidth();
    }
}

/**
 * 데이터 검증을 검색한다.
 * 
 * @param params {Object} 파라메터
 */
function searchOpenDtchck(params) {
    // 데이터 검증 시트 데이터를 로드한다.
    loadSheetData({
        SheetId:"DtchckSheet",
        PageUrl:"/admin/dtfile/searchOpenDtchck.do"
    }, {
        ObjectParam:params
    }, {
        // Nothing to do.
    });
}

/**
 * 데이터 검증을 다운로드한다.
 * 
 * @param ext {String} 확장자
 */
function downOpenDtchck(ext) {
    var sheet = window["DtchckSheet"];
    
    var count = sheet.GetTotalRows();
    
    if (count > 0) {
        var params = "";
        
        params += "?dtfileId=" + sheet.GetEtcData("dtfileId");
        params += "&dttranId=" + sheet.GetEtcData("dttranId");
        params += "&fileExt="  + ext;
        
        var iframe = document.getElementById("hidden-iframe");
        
        iframe.src = com.wise.help.url("/admin/dtfile/downOpenDtchck.do") + params;
    }
    else {
        alert("다운로드 할 데이터가 없습니다.");
    }
}

/**
 * 데이터 파일 테이블에 데이터를 저장한다.
 * 
 * @param mode {String} 모드
 */
function saveOpenDtfileTb(mode) {
    // 데이터 파일 테이블 데이터 저장 전처리를 실행한다.
    if (beforeSaveOpenDtfileTb()) {
    	/*
        $.post(
            com.wise.help.url("/admin/dtfile/saveOpenDtfileTb.do"),
            {
                insertTy:mode,
                dtfileId:window["DtchckSheet"].GetEtcData("dtfileId"),
                dttranId:window["DtchckSheet"].GetEtcData("dttranId"),
                uplSchNo:window["DtchckSheet"].GetEtcData("uplSchNo")
            },
            function(data, status, request) {
                // 데이터 파일 테이블 데이터 저장 후처리를 실행한다.
                afterSaveOpenDtfileTb(data, status, request);
            },
            "json"
        ).error(function(request, status, error) {
            handleError(status, error);
        });
        */
    	$.ajax({
    		type:"post"
   			, url : com.wise.help.url("/admin/dtfile/saveOpenDtfileTb.do")
            , data : {
                insertTy:mode,
                dtfileId:window["DtchckSheet"].GetEtcData("dtfileId"),
                dttranId:window["DtchckSheet"].GetEtcData("dttranId"),
                uplSchNo:window["DtchckSheet"].GetEtcData("uplSchNo")
            }
	        , beforeSend: function() {
	    		$('#loadingCircle').show();
	        }
    		, success: function(data) {
	    		$('#loadingCircle').hide()
                // 데이터 파일 테이블 데이터 저장 후처리를 실행한다.
                afterSaveOpenDtfileTb(data, status, request);
    		}
   			, error: function(request, status, error) {
	    		$('#loadingCircle').hide();
   	            handleError(status, error);
   	        }
   		    , complete: function() {
	    		$('#loadingCircle').hide();
   		    }
    	});
    }
}

/**
 * 선택 셀 값을 설정한다.
 */
function setCheckCellValue() {
    if (!com.wise.util.isBlank($("#dttranId").val())) {
        var sheet = window["DttranSheet"];
        
        var count = sheet.GetTotalRows();
        
        if (count > 0) {
            sheet.SetCellValue(1, "select", 1);
            
            if (sheet.GetCellValue(1, "procStat") == "I") {
                setCountdownValue();
            }
        }
    }
}

/**
 * 검색 카운트다운 값을 설정한다.
 */
function setCountdownValue() {
    if (!com.wise.util.isBlank($("#dttranId").val())) {
        var value = $("#countdown").text();
        
        if (value) {
            value = com.wise.util.toInteger(value) - 1;
        }
        else {
            value = SEARCH_INTERVAL;
        }
        
        if (value == 0) {
            $("#countdown").text("");
            
            // 데이터 처리를 검색한다.
            searchOpenDttran($("#dttranId").val());
        }
        else {
            $("#countdown").text(value + "초 후에 다시 조회합니다.");
            
            setTimeout(function() {
                // 검색 카운트다운 값을 설정한다.
                setCountdownValue();
            }, 1000);
        }
    }
    else {
        $("#countdown").text("");
    }
}

/**
 * 오류 셀 색상을 설정한다.
 * 
 * @param errors {Array} 오류
 */
function setErrorCellColor(errors) {
    if (errors) {
        var sheet = window["DtchckSheet"];
        
        for (var i = 0; i < errors.length; i++) {
            sheet.SetCellBackColor(errors[i].row + 1, errors[i].column, "yellow");
        }
    }
}

////////////////////////////////////////////////////////////////////////////////
// 전처리 함수
////////////////////////////////////////////////////////////////////////////////
/**
 * 데이터 컬럼 정의 검색 전처리를 실행한다.
 */
function beforeSearchOpenDtcolsDef() {
    return true;
}

/**
 * 데이터 파일 테이블 데이터 저장 전처리를 실행한다.
 */
function beforeSaveOpenDtfileTb() {
    var sheet = window["DtchckSheet"];
    
    var count = sheet.GetTotalRows();
    
    if (count > 0) {
        var valid = sheet.GetEtcData("chckYn") == "Y";
        
        if (!valid) {
            alert("데이터가 유효하지 않습니다.");
            return false;
        }
    }
    else {
        alert("저장 할 데이터가 없습니다.");
        return false;
    }
    
    return true;
}

////////////////////////////////////////////////////////////////////////////////
// 후처리 함수
////////////////////////////////////////////////////////////////////////////////
/**
 * 데이터 컬럼 정의 검색 후처리를 실행한다.
 * 
 * @param data {Object} 데이터
 * @param status {String} 상태
 * @param request {Object} 요청
 * @param params {Object} 파라메터
 */
function afterSearchOpenDtcolsDef(data, status, request, params) {
    if (data.data) {
        // 데이터 검증 시트를 생성한다.
        createDtchckSheet("Reset", data.data);
        
        // 데이터 검증을 검색한다.
        searchOpenDtchck(params);
    }
    else {
        if (data.error) {
            handleError(status, data.error);
        }
        
        // 데이터 검증 시트를 생성한다.
        createDtchckSheet("Reset");
    }
}

/**
 * 데이터 파일 테이블 데이터 저장 후처리를 실행한다.
 * 
 * @param data {Object} 데이터
 * @param status {String} 상태
 * @param request {Object} 요청
 */
function afterSaveOpenDtfileTb(data, status, request) {
    if (data.success) {
        if (data.success.message) {
            alert(data.success.message);
            location.href="<c:url value='/admin/dtfile/uploadLogPage.do'/>";
        }
    }
    else {
        if (data.error) {
            handleError(status, data.error);
            location.href="<c:url value='/admin/dtfile/manageOpenDttranPage.do'/>";
        }
    }
}

////////////////////////////////////////////////////////////////////////////////
// 이벤트 함수
////////////////////////////////////////////////////////////////////////////////
/**
 * 데이터 처리 시트 조회 완료 이벤트를 처리한다.
 * 
 * @param code {Number} 코드
 * @param message {String} 메시지
 * @param statusCode {Number} 상태 코드
 * @param statusMessage {String} 상태 메시지
 */
function DttranSheet_OnSearchEnd(code, message, statusCode, statusMessage) {
    // 데이터 검증 시트를 생성한다.
    createDtchckSheet("Reset");
    
    if (code >= 0) {
        if (message) {
            alert(message);
        }
        
        // 선택 셀 값을 설정한다.
        setCheckCellValue();
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
 * 데이터 처리 시트 변경 이벤트를 처리한다.
 * 
 * @param row {Number} 행
 * @param column {Number} 열
 * @param value {String} 값
 * @param previous {String} 이전 값
 * @param raise {Number} 발생
 */
function DttranSheet_OnChange(row, column, value, previous, raise) {
    if (row > 0) {
        var sheet = window["DttranSheet"];
        
        switch (sheet.ColSaveName(0, column)) {
            case "select":
                if (value == "1") {
                    // 데이터 컬럼 정의를 검색한다.
                    searchOpenDtcolsDef({
                        dtfileId:sheet.GetCellValue(row, "dtfileId"),
                        dttranId:sheet.GetCellValue(row, "dttranId"),
                        uplSchNo:sheet.GetCellValue(row, "uplSchNo"),
                        chckYn:sheet.GetCellValue(row, "chckYn")
                    });
                }
                else {
                    // 데이터 검증 시트를 생성한다.
                    createDtchckSheet("Reset");
                }
                break;
        }
    }
}

/**
 * 데이터 검증 시트 조회 완료 이벤트를 처리한다.
 * 
 * @param code {Number} 코드
 * @param message {String} 메시지
 * @param statusCode {Number} 상태 코드
 * @param statusMessage {String} 상태 메시지
 */
function DtchckSheet_OnSearchEnd(code, message, statusCode, statusMessage) {
    if (code >= 0) {
        if (message) {
            alert(message);
        }
        
        // 오류 셀 색상을 설정한다.
        setErrorCellColor(window["DtchckSheet"].GetEtcData("errors"));
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