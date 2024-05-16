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

var templates = {
	    data:
	    	"<tr id=\"dttm\">" +
        "<th>데이터 기준일자 정보</th>" +
        "<td>" +
            "<input type=\"text\" id=\"dataCondDttm\" name=\"dataCondDttm\" style=\"width:500px;\" /> 예시 : 2016년 9월7일 기준데이터입니다." +
        "</td>" +
        	"</tr>"
	};

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
        { Header:"선택|선택",                 SaveName:"select",   Hidden:0, Width:50,  Align:"Center", Sort:0, Type:"Radio", RadioIcon:0, Edit:1, Cursor:"Default", HoverUnderline:0 },
        { Header:"업로드스케쥴번호|업로드스케쥴번호", SaveName:"uplSchNo", Hidden:1, Width:0,   Align:"Center", Sort:0, Type:"Text",  RadioIcon:1, Edit:0, Cursor:"Default", HoverUnderline:0 },
        { Header:"데이터파일ID|데이터파일ID", SaveName:"dtfileId", Hidden:1, Width:0,   Align:"Center", Sort:0, Type:"Text",  RadioIcon:1, Edit:0, Cursor:"Default", HoverUnderline:0 },
        { Header:"상태|상태",             SaveName:"loadStatus",   Hidden:0, Width:60, Align:"Center",   Sort:0, Type:"Combo",  RadioIcon:1, Edit:0, Cursor:"Default", HoverUnderline:0 },
        { Header:"업로드예정일|업로드예정일",             SaveName:"loadYmd",   Hidden:0, Width:80, Align:"Center",   Sort:0, Type:"Text",  RadioIcon:1, Edit:0, Cursor:"Default", HoverUnderline:0 },
        { Header:"보유데이터명|보유데이터명",             SaveName:"dtNm",   Hidden:1, Width:0, Align:"Left",   Sort:0, Type:"Text",  RadioIcon:1, Edit:0, Cursor:"Default", HoverUnderline:0 },
        { Header:"데이터셋명|데이터셋명",           SaveName:"infNm",    Hidden:0, Width:210, Align:"Left",   Sort:0, Type:"Text",  RadioIcon:1, Edit:0, Cursor:"Default", HoverUnderline:0 },
        { Header:"조직명|조직명",           SaveName:"orgNm",    Hidden:0, Width:80, Align:"Left",   Sort:0, Type:"Text",  RadioIcon:1, Edit:0, Cursor:"Default", HoverUnderline:0 },
        { Header:"보유부서|보유부서",           SaveName:"useDeptNm",    Hidden:0, Width:120, Align:"Left",   Sort:0, Type:"Text",  RadioIcon:1, Edit:0, Cursor:"Default", HoverUnderline:0 },
        { Header:"파일명|파일명", SaveName:"fileNm",  Hidden:1, Width:0, Align:"Left",  Sort:0, Type:"Text",   RadioIcon:1, Edit:0, Cursor:"Default", HoverUnderline:0 },
        { Header:"시트명|시트명", SaveName:"shtNm",  Hidden:1, Width:0, Align:"Left",  Sort:0, Type:"Text",   RadioIcon:1, Edit:0, Cursor:"Default", HoverUnderline:0 },
        { Header:"적재주기|적재주기", SaveName:"loadCd",   Hidden:0, Width:70, Align:"Left",  Sort:0, Type:"Combo",   RadioIcon:1, Edit:0, Cursor:"Default", HoverUnderline:0 },
        { Header:"최종등록일|최종등록일", SaveName:"updDttm",   Hidden:0, Width:70, Align:"Center",  Sort:0, Type:"Text",   RadioIcon:1, Edit:0, Cursor:"Default", HoverUnderline:0 },
        { Header:"다운로드|엑셀2003",           SaveName:"downXls",  Hidden:0, Width:80,  Align:"Center", Sort:0, Type:"Text",  RadioIcon:1, Edit:0, Cursor:"Pointer", HoverUnderline:1 },
        { Header:"다운로드|엑셀2007",         SaveName:"downXlsx", Hidden:0, Width:80,  Align:"Center", Sort:0, Type:"Text",  RadioIcon:1, Edit:0, Cursor:"Pointer", HoverUnderline:1 }
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
            searchUploadSche();
            return false;
        }
    });
    
    // 조회 버튼에 클릭 이벤트를 바인딩한다.
    $("#search-button").bind("click", function(event) {
        // 데이터 파일을 검색한다.
    	searchUploadSche();
        return false;
    });
    
    // 서버양식 엑셀업로드 버튼에 클릭 이벤트를 바인딩한다.
    $("#predefined-upload-button").bind("click", function(event) {
        // 데이터 처리 아이디를 조회한다.
        selectOpenDttranDttranId("P");
        return false;
    });
    
    // 기본양식 엑셀업로드 버튼에 클릭 이벤트를 바인딩한다.
    $("#template-upload-button").bind("click", function(event) {
        // 데이터 처리 아이디를 조회한다.
        selectOpenDttranDttranId("T");
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
	  
	// 적재주기 콤보 옵션을 초기화한다.
	initComboOptions("loadStatus", [{
        code:"",
        name:"전체"
    }].concat([{
		code:"S",
		name:"적재예정"
	}, {
		code:"D",
		name:"적재지연"
	}]), "");
	
	//적재주기 콤보 옵션을 설정한다.
	loadSheetOptions("DtfileSheet",0,"loadCd",
	"/admin/dtfile/ajaxCombo.do",
	{grpCd:"D1009"});
	
	//상태 콤보 옵션을 설정한다.
	initSheetOptions("DtfileSheet",0,"loadStatus",[{
		code:"S",
		name:"적재예정"
	}, {
		code:"D",
		name:"적재지연"
	}]);
}

/**
 * 데이터를 로드한다.
 */
function loadData() {
    // 데이터 파일을 검색한다.
    searchUploadSche();
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
function searchUploadSche() {
    // 데이터 파일 시트 데이터를 로드한다.
    loadSheetData({
        SheetId:"DtfileSheet",
        PageUrl:"/admin/dtfile/searchUploadSche.do"
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
    // 데이터 처리 아이디 조회 전처리를 실행한다.
	var dttm = $("#dttm");
	//alert($("#dttmCheck").val());
	if($("#dttmCheck").val() == '1'){
		if(!dttm.find("input[name=dataCondDttm]").val()){
			alert("데이터 기준일자정보를 입력해야 합니다.");
			return false;
		}
	}
		
	
    if (beforeSelectOpenDttranDttranId(mode)) {
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
}

/**
 * 데이터 검증을 저장한다.
 * 
 * @param key {String} 키
 */
function saveOpenDtchck(key) {/*
    $("#dttranId").val(key);
    
    var form = $("#upload-form");
    
    form.attr("action", com.wise.help.url("/admin/dtfile/saveOpenDtchck.do"));
    form.attr("target", "hidden-iframe");
    
    form.submit();
    
    window.location.href = com.wise.help.url("/admin/dtfile/manageOpenDttranPage.do?dttranId=" + key);*/

    $("#dttranId").val(key);
    
    var form = $("#upload-form");
    form.attr("action", com.wise.help.url("/admin/dtfile/saveOpenDtchck.do"));
    form.attr("target", "hidden-iframe");
    form.ajaxForm({
    	async: false
    	, beforeSend: function() {
    		$('#loadingCircle').show();
    	}
    	, success: function(msg, a, b) {
    	    window.location.href = com.wise.help.url("/admin/dtfile/manageOpenDttran2Page.do?dttranId=" + key);
    	}
    	, error: function(msg, a, b) {
    		alert(msg);
    	}
    });
    
    form.submit();
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
 * 적재지연 테이블을 삭제한다.
 */
function setDelayRow() {
	var sheet = window["DtfileSheet"];
	
	var count = sheet.RowCount();
    
    for (var i = 0, r = 2; i < count; i++, r++) {
        if(sheet.GetCellValue(r,"loadStatus") == "D" && sheet.GetCellValue(r,"loadCd") != "RECY07") {
        	sheet.SetRowBackColor(r, "#FFFF00");
        }
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
	
	if(index) {			// 선택 여부
		if(sheet.GetCellValue(parseInt(index),"loadStatus") == "D") {		//지연상태
			$("#delayMsg").prop("disabled",false);
		} else {															//지연상태 아님
			$("#delayMsg").prop("disabled",true);
		}
	} else {
		$("#delayMsg").prop("disabled",false);
	}
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
        if (com.wise.util.isBlank($("#dtfile").val())) {
            alert("업로드 파일을 선택하여 주십시오.");
            $("#dtfile").focus();
            return false;
        }
        if (!new RegExp("\\.(xls|xlsx|csv)$", "i").test($("#dtfile").val())) {
            alert("엑셀 파일을 선택하여 주십시오.");
            $("#dtfile").focus();
            return false;
        }
        if(sheet.GetCellValue(parseInt(index), "loadStatus") == "D" && com.wise.util.isBlank($("#delayMsg").val())) {		//지연사유 필수 체크
        	alert("지연 사유를 입력하세요.");
        	$("#delayMsg").focus();
        	return false;
        }
        if (!$("#dttm").val()) {
        	//alert("데이터 기준일자를 넣어야 합니다.");
          //  $("#dttm").focus();
          //  return false;
        }
        
        $("#dtfileId").val(sheet.GetCellValue(parseInt(index), "dtfileId"));
        $("#uplSchNo").val(sheet.GetCellValue(parseInt(index), "uplSchNo"));
        $("#uploadTy").val(mode);
        
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
        
        // 적재지연 컬럼을 표시한다.
        setDelayRow();
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
        
        var id = sheet.GetCellValue(row, "dtfileId");
    	appendDataCondDttm(id);
        
        switch (sheet.ColSaveName(0, column)) {
            case "select":
                if (value == "1") {
                    // 데이터 컬럼을 검색한다.
//                    searchOpenDtcols(sheet.GetCellValue(row, "dtfileId"));
                	// 지연 상태인 경우 공공데이터명은 필수, 아닌경우 입력불가 처리
                	resetForm();
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

function appendDataCondDttm(id){

	$.post(
            com.wise.help.url("/admin/dtfile/searchAppendDataCondDttm.do"),
            {
                dtfileId:id
            },
            function(data, status, request) {
                // 데이터 컬럼 정의 검색 후처리를 실행한다.
                afterSearchAppendDataCondDttm(data, status, request);
            },
            "json"
        ).error(function(request, status, error) {
            handleError(status, error);
            
            // 데이터 검증 시트를 생성한다.
            //createDtchckSheet("Reset");
        });
}

function afterSearchAppendDataCondDttm(data, status, request){
	var num = data.data;
	var row = $(templates.data);			
	var table = $("#checkDttm");
	var dttm = $("#dttm");
	dttm.remove();
	
	
	
		if(data.data == 0){
			$("#dttmCheck").val(1);
			table.after(row);		
		}
}

