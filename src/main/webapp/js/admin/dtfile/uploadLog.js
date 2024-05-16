/*
 * @(#)uploadOpenDtfile.js 1.0 2015/06/01
 * 
 * COPYRIGHT (C) 2013 WISEITECH CO., LTD. ALL RIGHTS RESERVED.
 */

/**
 * 데이터 파일을 업로드하는 스크립트이다.
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
        SheetId:"DtfileSheet",
        Height:"296px"
    }, {
        // Nothing do do.
    }, {
        HeaderCheck:0
    }, [
        { Header:"선택|선택",                 SaveName:"select",   Hidden:0, Width:60,  Align:"Center", Sort:0, Type:"Radio", RadioIcon:0, Edit:1, Cursor:"Default", HoverUnderline:0 },
        { Header:"업로드스케쥴번호|업로드스케쥴번호", SaveName:"uplSchNo", Hidden:1, Width:0,   Align:"Center", Sort:0, Type:"Text",  RadioIcon:1, Edit:0, Cursor:"Default", HoverUnderline:0 },
        { Header:"데이터파일ID|데이터파일ID", SaveName:"dtfileId", Hidden:1, Width:0,   Align:"Center", Sort:0, Type:"Text",  RadioIcon:1, Edit:0, Cursor:"Default", HoverUnderline:0 },
        { Header:"데이터처리ID|데이터처리ID", SaveName:"dttranId", Hidden:1, Width:0,   Align:"Center", Sort:0, Type:"Text",  RadioIcon:1, Edit:0, Cursor:"Default", HoverUnderline:0 },
        { Header:"테이블명|테이블명", SaveName:"tbNm", Hidden:1, Width:0,   Align:"Center", Sort:0, Type:"Text",  RadioIcon:1, Edit:0, Cursor:"Default", HoverUnderline:0 },
        { Header:"업로드일자|업로드일자",             SaveName:"uploadDttm",   Hidden:0, Width:120, Align:"Center",   Sort:0, Type:"Text",  RadioIcon:1, Edit:0, Cursor:"Default", HoverUnderline:0 },
        { Header:"보유데이터명|보유데이터명",             SaveName:"dtNm",   Hidden:0, Width:210, Align:"Left",   Sort:0, Type:"Text",  RadioIcon:1, Edit:0, Cursor:"Default", HoverUnderline:0 },
        { Header:"공공데이터명|공공데이터명",           SaveName:"infNm",    Hidden:0, Width:210, Align:"Left",   Sort:0, Type:"Text",  RadioIcon:1, Edit:0, Cursor:"Default", HoverUnderline:0 },
        { Header:"조직명|조직명",             SaveName:"orgNm",   Hidden:0, Width:150, Align:"Left",   Sort:0, Type:"Text",  RadioIcon:1, Edit:0, Cursor:"Default", HoverUnderline:0 },
        { Header:"파일명|파일명", SaveName:"fileNm",  Hidden:0, Width:200, Align:"Left",  Sort:0, Type:"Text",   RadioIcon:1, Edit:0, Cursor:"Default", HoverUnderline:0 },
        { Header:"시트명|시트명", SaveName:"shtNm",  Hidden:0, Width:200, Align:"Left",  Sort:0, Type:"Text",   RadioIcon:1, Edit:0, Cursor:"Default", HoverUnderline:0 },
        { Header:"적재주기|적재주기", SaveName:"loadCd",   Hidden:0, Width:80, Align:"Left",  Sort:0, Type:"Combo",   RadioIcon:1, Edit:0, Cursor:"Default", HoverUnderline:0 },
        { Header:"다운로드|엑셀2003버전",           SaveName:"downXls",  Hidden:0, Width:80,  Align:"Center", Sort:0, Type:"Text",  RadioIcon:1, Edit:0, Cursor:"Pointer", HoverUnderline:1 },
        { Header:"다운로드|엑셀2007버전이상",         SaveName:"downXlsx", Hidden:0, Width:80,  Align:"Center", Sort:0, Type:"Text",  RadioIcon:1, Edit:0, Cursor:"Pointer", HoverUnderline:1 }
    ], {
        // Nothing do do.
    });
    
    // 데이터 컬럼 시트 그리드를 생성한다.
//    initSheetGrid({
//        ElementId:"dtcols-sheet-section",
//        SheetId:"DtcolsSheet",
//        Height:"238px"
//    }, {
//        SearchMode:smGeneral
//    }, {
//        Sort:0,
//        HeaderCheck:0
//    }, [
//        { Header:"데이터컬럼ID", SaveName:"dtcolsId", Hidden:1, Width:0,   Align:"Center", Type:"Text",     TrueValue:"1", FalseValue:"0", Edit:0 },
//        { Header:"데이터파일ID", SaveName:"dtfileId", Hidden:1, Width:0,   Align:"Center", Type:"Text",     TrueValue:"1", FalseValue:"0", Edit:0 },
//        { Header:"컬럼순서",     SaveName:"colSeq",   Hidden:0, Width:80,  Align:"Center", Type:"Int",      TrueValue:"1", FalseValue:"0", Edit:0 },
//        { Header:"컬럼명",       SaveName:"colExp",   Hidden:0, Width:320, Align:"Left",   Type:"Text",     TrueValue:"1", FalseValue:"0", Edit:0 },
//        { Header:"데이터형식",   SaveName:"dttypeId", Hidden:0, Width:320, Align:"Left",   Type:"Combo",    TrueValue:"1", FalseValue:"0", Edit:0 },
//        { Header:"필수여부",     SaveName:"nullYn",   Hidden:0, Width:80,  Align:"Center", Type:"CheckBox", TrueValue:"N", FalseValue:"Y", Edit:0 },
//        { Header:"데이터정렬",   SaveName:"dataAli",  Hidden:0, Width:120, Align:"Center", Type:"Combo",    TrueValue:"1", FalseValue:"0", Edit:0 },
//        { Header:"데이터포맷",   SaveName:"dataFrm",  Hidden:0, Width:240, Align:"Left",   Type:"Text",     TrueValue:"1", FalseValue:"0", Edit:0 }
//    ], {
//        CountPosition:0
//    });
    
    window["DtfileSheet"].FitColWidth();
//    window["DtcolsSheet"].FitColWidth();
    
    var formObj = $('#search-form');
	formObj.find("input[name=endDttm]").datepicker(setCalendar());          
	formObj.find("input[name=startDttm]").datepicker(setCalendar());     
	datepickerTrigger();
	setDate();
}

function setDate(){
	var formObj = $('#search-form');
	var now = new Date();
	var yester = new Date();
	yester.setMonth(yester.getMonth()-12);
	var n_year = now.getFullYear();
	var y_year = yester.getFullYear();
	var n_mon = (now.getMonth()+1)>9?now.getMonth()+1:'0'+(now.getMonth()+1);
	var y_mon = (yester.getMonth()+1)>9?yester.getMonth()+1:'0'+(yester.getMonth()+1);
	var n_day = (now.getDate())>9?(now.getDate()):'0'+(now.getDate());
	var y_day = (yester.getDate())>9?(yester.getDate()):'0'+(yester.getDate());
	var dateFrom=y_year+'-'+y_mon+'-'+y_day;
	var dateTo=n_year+'-'+n_mon+'-'+n_day;
	formObj.find("input[name=startDttm]").val(dateFrom);
	formObj.find("input[name=endDttm]").val(dateTo);
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
            searchUploadLog();
            return false;
        }
    });
    
    // 조회 버튼에 클릭 이벤트를 바인딩한다.
    $("#search-button").bind("click", function(event) {
        // 데이터 파일을 검색한다.
    	searchUploadLog();
        return false;
    });
    
    // 테이블에 적재한 데이터를 삭제한다.
    $("#template-del-button").bind("click", function(event) {
        // 데이터 처리 아이디를 조회한다.
        delOpenDtRecord("D");
        return false;
    });
    
    // 테이블에 적재한 데이터를 수정한다. (업로드)
    $("#template-modify-button").bind("click", function(event) {
        // 데이터 처리 아이디를 조회한다.
        delOpenDtRecord("M");
        return false;
    });
    
    // 분류, 조직 검색팝업 및 초기화 버튼 이벤트를 바인딩한다.
    var formObj = $("form[name=search-form]");
    
    formObj.find("button[name=btn_search]").bind("click", function(e) { 
    	poporgnm();
		return false;               
	});
    
    formObj.find("button[name=btn_init]").bind("click", function(e) { 
		formObj.find("input[name=orgNm]").val("");
		formObj.find("input[name=orgCd]").val("");
		return false;               
	}); 
    
    // 미리보기 버튼 클릭 시
    $('#upload-preview-button').bind("click", function() {
    	var form = $('#upload-form');
    	var dtfileId = form.find('input[name=dtfileId]').val();
    	var uplSchNo = form.find('input[name=uplSchNo]').val();
    	if(com.wise.util.isBlank(dtfileId) || com.wise.util.isBlank(uplSchNo)) {
    		alert("미리보기할 항목을 선택해 주세요.");
    		return false;
    	}
    	var popUrl = "/admin/dtfile/uploadPreviewPopup.do?dtfileId="+dtfileId+"&uplSchNo="+uplSchNo;
    	window.open(popUrl,"_uploadPrevPop","width=1024, height=600, resizable=1, scrollbars=no, menubar=no, toolbar=no, location=no, status=no");
    	return false;
    });
    
    $('#download-excel-button').bind("click", function() {
    	/*
        var form = $('#search-form');
        
        var downloadUrl = "/admin/dtfile/downladUploadHistorySheetData.do?"+form.serialize();
        $.fileDownload(downloadUrl);
        */
    	goDownload({
            url:"/admin/dtfile/downladUploadHistorySheetData.do",
            form:"search-form",
            target:"hidden-iframe"
        });
        return false;
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
    
    // 데이터 컬럼 시트 데이터형식 콤보 옵션을 로드한다.
//    loadSheetOptions("DtcolsSheet", 0, "dttypeId", "/admin/dtfile/searchOpenDttypeOpt.do", {
//        // Nothing to do.
//    });
    
    // 데이터 컬럼 시트 데이터정렬 콤보 옵션을 초기화한다.
//    initSheetOptions("DtcolsSheet", 0, "dataAli", [{
//        code:"Left",
//        name:"좌측"
//    }, {
//        code:"Center",
//        name:"중앙"
//    }, {
//        code:"Right",
//        name:"우측"
//    }]);
	// 적재주기 콤보 옵션을 초기화한다.
	loadComboOptions2("loadCd",
	"/admin/dtfile/ajaxCombo.do",
	{grpCd:"D1009"},
	"");
	
	//적재주기 콤보 옵션을 설정한다.
	loadSheetOptions("DtfileSheet",0,"loadCd",
	"/admin/dtfile/ajaxCombo.do",
	{grpCd:"D1009"});
	
}

/**
 * 데이터를 로드한다.
 */
function loadData() {
    // 데이터 파일을 검색한다.
    searchUploadLog();
}

////////////////////////////////////////////////////////////////////////////////
// 서비스 함수
////////////////////////////////////////////////////////////////////////////////
/**
 * 데이터 파일을 검색한다.
 */
//function searchOpenDtfile() {
//    // 데이터 파일 시트 데이터를 로드한다.
//    loadSheetData({
//        SheetId:"DtfileSheet",
//        PageUrl:"/admin/dtfile/searchOpenDtfile.do"
//    }, {
//        ObjectParam:{
//            accYn:"Y"
//        },
//        FormParam:"search-form"
//    }, {
//        // Nothing to do.
//    });
//}

/**
 * 업로드 스케쥴러를 검색한다.
 */
function searchUploadLog() {
    // 데이터 파일 시트 데이터를 로드한다.
    loadSheetData({
        SheetId:"DtfileSheet",
        PageUrl:"/admin/dtfile/searchUploadLog.do"
    }, {
        ObjectParam:{
            accYn:"Y"
        },
        FormParam:"search-form"
    }, {
        // Nothing to do.
    });
}

/**
 * 데이터 파일 템플릿을 다운로드한다.
 * 
 * @param key {String} 키
 * @param ext {String} 확장자
 */
function downOpenDtfileTpl(key, ext) {
    var iframe = document.getElementById("hidden-iframe");
    
    iframe.src = com.wise.help.url("/admin/dtfile/downOpenDtfileTpl.do") + "?dtfileId=" + key + "&fileExt=" + ext;
}

/**
 * 데이터 컬럼을 검색한다.
 * 
 * @param key {String} 키
 */
//function searchOpenDtcols(key) {
//    // 데이터 컬럼 시트 데이터를 로드한다.
//    loadSheetData({
//        SheetId:"DtcolsSheet",
//        SearchMode:smGeneral,
//        PageUrl:"/admin/dtfile/searchOpenDtcols.do"
//    }, {
//        ObjectParam:{
//            dtfileId:key
//        }
//    }, {
//        // Nothing to do.
//    });
//}

/**
 * 데이터 컬럼을 제거한다.
 */
//function removeOpenDtcols() {
//    window["DtcolsSheet"].RemoveAll();
//}

/**
 * 데이터 처리 아이디를 조회한다.
 * 
 * @param mode {String} 모드
 */
function selectOpenDttranDttranId(mode) {
    $.post(
        com.wise.help.url("/admin/dtfile/selectOpenDttranDttranId.do"),
        {
            // Nothing to do.
        },
        function(data, status, request) {
            // 데이터 처리 아이디 조회 후처리를 실행한다.
            afterSelectOpenDttranDttranId(data, status, request);
        },
        "json"
    ).error(function(request, status, error) {
        handleError(status, error);
        
        // 업로드 폼을 초기화한다.
        resetUploadForm();
    });
}

/**
 * 데이터 검증을 저장한다.
 * 
 * @param key {String} 키
 */
function saveOpenDtchck(key) {
	
    $("#dttranId").val(key);
    
    var form = $("#upload-form");
    
    form.attr("action", com.wise.help.url("/admin/dtfile/saveOpenDtchck.do"));
    form.attr("target", "hidden-iframe");
    
    form.submit();
    
    window.location.href = com.wise.help.url("/admin/dtfile/manageOpenDttranPage.do?dttranId=" + key);
}

/**
 * 테이블에 적재된 데이터를 삭제합니다.
 * @param mode
 * @returns
 */
function delOpenDtRecord(mode) {
	var sheet = window["DtfileSheet"];
	var index = sheet.FindCheckedRow("select");
	
	var dttranId = sheet.GetCellValue(parseInt(index), "dttranId");
	var tbNm = sheet.GetCellValue(parseInt(index), "tbNm");
	
	// 테이블 데이터 삭제 전처리를 수행한다.
	if (beforeSelectOpenDttranDttranId(mode)) {
		$.post(
	        com.wise.help.url("/admin/dtfile/deleteOpenDtRecord.do"),
	        {
	            "tbNm":tbNm,
	        	"dttranId":dttranId,
	        	"procStat":mode
	        },
	        function(data, status, request) {
	        	if(mode == "D") {		//삭제 버튼
	        		alert("테이블에 적재된 데이터를 삭제했습니다.");
	        		resetUploadForm();				//폼 초기화
	        	} else {				//수정 버튼
	        		// 데이터 처리 아이디 조회를 수행한다.
		        	selectOpenDttranDttranId(mode);
	        	}
	        },
	        "json"
	    ).error(function(request, status, error) {
	        handleError(status, error);
	        
	        // 업로드 폼을 초기화한다.
	        resetUploadForm();
	    });
	}
}

/**
 * 다운로드 컬럼 값을 설정한다.
 */
function setDownColumnValue() {
    var sheet = window["DtfileSheet"];
    
    var count = sheet.RowCount();
    
    for (var i = 0, r = 2; i < count; i++, r++) {
        sheet.SetCellValue(r, "downXls",  "다운로드");
        sheet.SetCellValue(r, "downXlsx", "다운로드");
    }
}

/**
 * 업로드 폼을 초기화한다.
 */
function resetUploadForm() {
    $("#dttranId").val("");
    $("#dtfileId").val("");
    $("#uplSchNo").val("");
    $("#uploadTy").val("");
}

/**
 *  선택 클릭시 업로드 폼 초기화
 */
function resetForm() {
	var sheet = window["DtfileSheet"];
	var index = sheet.FindCheckedRow("select");
	
	$("form[name=upload-form]")[0].reset();
	resetUploadForm();
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
/**
 * 데이터 처리 아이디 조회 전처리를 실행한다.
 * 
 * @param mode {String} 모드
 */
function beforeSelectOpenDttranDttranId(mode) {
    var sheet = window["DtfileSheet"];
    
    var index = sheet.FindCheckedRow("select");
    
    if (index) {
        if (!com.wise.util.isBlank($("#dtfileId").val())) {
            alert("잠시만 기다려 주십시오.");
            return false;
        }
        if(mode == "M") {
        	if (com.wise.util.isBlank($("#dtfile").val())) {
                alert("업로드 파일을 선택하여 주십시오.");
                $("#dtfile").focus();
                return false;
            }
            if (!new RegExp("\\.(xls|xlsx)$", "i").test($("#dtfile").val())) {
                alert("엑셀 파일을 선택하여 주십시오.");
                $("#dtfile").focus();
                return false;
            }
        }
        
        if(com.wise.util.isBlank($("#delayMsg").val())) {		//지연사유 필수 체크
        	alert("지연 사유를 입력하세요.");
        	$("#delayMsg").focus();
        	return false;
        }
        
        $("#dtfileId").val(sheet.GetCellValue(parseInt(index), "dtfileId"));
        $("#uplSchNo").val(sheet.GetCellValue(parseInt(index), "uplSchNo"));
        if(mode == "M") {
        	$("#uploadTy").val("T");
        }
        
        
        return true;
    }
    else {
        alert("데이터 파일을 선택하여 주십시오.");
        return false;
    }
}

////////////////////////////////////////////////////////////////////////////////
// 후처리 함수
////////////////////////////////////////////////////////////////////////////////
/**
 * 데이터 처리 아이디 조회 후처리를 실행한다.
 * 
 * @param data {Object} 데이터
 * @param status {String} 상태
 * @param request {Object} 요청
 */
function afterSelectOpenDttranDttranId(data, status, request) {
    if (data.data) {
        // 데이터 검증을 저장한다.
        saveOpenDtchck(data.data);
    }
    else {
        if (data.error) {
            handleError(status, data.error);
        }
        
        // 업로드 폼을 초기화한다.
        resetUploadForm();
    }
}

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
//    removeOpenDtcols();
    
    if (code >= 0) {
        if (message) {
            alert(message);
        }
        
        // 다운로드 컬럼 값을 설정한다.
        setDownColumnValue();
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
//                    searchOpenDtcols(sheet.GetCellValue(row, "dtfileId"));
                	// 지연 상태인 경우 공공데이터명은 필수, 아닌경우 입력불가 처리
//                	resetForm();
                	var rowData = sheet.GetRowJson(row);
                	var form = $('#upload-form');
                	form.find('input[name=uplSchNo]').val(rowData.uplSchNo);
                	form.find('input[name=dtfileId]').val(rowData.dtfileId);
                }
                else {
                    // 데이터 컬럼을 제거한다.
//                    removeOpenDtcols();
                	//폼을 초기화한다.
                	resetForm();
                }
                break;
            case "downXls":
                // 데이터 파일 템플릿을 다운로드한다.
                downOpenDtfileTpl(sheet.GetCellValue(row, "dtfileId"), "xls");
                break;
            case "downXlsx":
                // 데이터 파일 템플릿을 다운로드한다.
                downOpenDtfileTpl(sheet.GetCellValue(row, "dtfileId"), "xlsx");
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
//function DtcolsSheet_OnSearchEnd(code, message, statusCode, statusMessage) {
//    if (code >= 0) {
//        if (message) {
//            alert(message);
//        }
//    }
//    else {
//        if (message) {
//            alert(message);
//        }
//        else {
//            handleSheetError(statusCode, statusMessage);
//        }
//    }
//}