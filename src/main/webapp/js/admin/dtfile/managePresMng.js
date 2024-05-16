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
        { Header:"선택", SaveName:"select",   Hidden:0, Width:60,  Align:"Center", Sort:0, Type:"Radio", RadioIcon:0, Edit:1, Cursor:"Default", HoverUnderline:0 },
        { Header:"독촉관리번호", SaveName:"presMngNo", Hidden:1, Width:0,   Align:"Center", Sort:0, Type:"Text",  RadioIcon:1, Edit:0, Cursor:"Default", HoverUnderline:0 },
        { Header:"독촉스크립트명", SaveName:"scrtNm", Hidden:0, Width:0,   Align:"Left", Sort:0, Type:"Text",  RadioIcon:1, Edit:0, Cursor:"Default", HoverUnderline:0 },
        { Header:"독촉스크립트내용", SaveName:"scrtCont", Hidden:0, Width:0,   Align:"Left", Sort:0, Type:"Text",  RadioIcon:1, Edit:0, Cursor:"Default", HoverUnderline:0 },
        { Header:"실행일", SaveName:"useDtCd", Hidden:0, Width:0,   Align:"Left", Sort:0, Type:"Combo",  RadioIcon:1, Edit:0, Cursor:"Default", HoverUnderline:0 },
        { Header:"담당수신자", SaveName:"callerCd",   Hidden:0, Width:120, Align:"Left",   Sort:0, Type:"Combo",  RadioIcon:1, Edit:0, Cursor:"Default", HoverUnderline:0 },
        { Header:"배경HTML", SaveName:"htmlCont",   Hidden:0, Width:210, Align:"Center",   Sort:0, Type:"Combo",  RadioIcon:1, Edit:0, Cursor:"Default", HoverUnderline:0 },
        { Header:"사용여부", SaveName:"useYn",    Hidden:0, Width:210, Align:"Center",   Sort:0, Type:"Combo",  RadioIcon:1, Edit:0, Cursor:"Default", HoverUnderline:0 }
    ], {
        // Nothing do do.
    });
    
    window["DtfileSheet"].FitColWidth();
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
            searchPresMng();
            return false;
        }
    });
    
    // 조회 버튼에 클릭 이벤트를 바인딩한다.
    $("#search-button").bind("click", function(event) {
        // 데이터 파일을 검색한다.
    	searchPresMng();
        return false;
    });
        
    // 초기화 버튼에 클릭 이벤트를 바인딩한다.
    $("#template-init-button").bind("click", function(event) {
        // 폼 초기화
    	resetForm();
        return false;
    });
    
    // 저장 버튼에 클릭 이벤트를 바인딩한다.
    $("#template-save-button").bind("click", function(event) {
        // 스크립트를 저장한다.
    	savePresMng();
        return false;
    });
    
    // 삭제 버튼에 클릭 이벤트를 바인딩한다.
    $("#template-del-button").bind("click", function(event) {
        // 스크립트를 삭제한다.
    	deletePresMng();
        return false;
    });
    
    // 수정 버튼에 클릭 이벤트를 바인딩한다.
    $("#template-modify-button").bind("click", function(event) {
        // 스크립트를 수정한다.
    	updatePresMng();
        return false;
    });
}

/**
 * 옵션을 로드한다.
 */
function loadOptions() {
	// 사용여부 콤보 옵션을 초기화한다.
	initComboOptions("useYn", [{
	    code:"",
	    name:"전체"
	}, {
	    code:"Y",
	    name:"사용"
	}, {
	    code:"N",
	    name:"미사용"
	}], "");
	
	// 담당수신자 콤보 옵션을 초기화한다.
	loadComboOptions2("callerCd",
	"/admin/dtfile/ajaxCombo.do",
	{grpCd:"C1002"},
	"");
	
	// 실행일 콤보 옵션을 초기화한다.
	loadComboOptions2("useDtCd",
	"/admin/dtfile/ajaxCombo.do",
	{grpCd:"P1002"},
	"");
	
	// 배경HTML 콤보 옵션을 초기화한다.
	loadComboOptions2("htmlCont",
	"/admin/dtfile/ajaxCombo.do",
	{grpCd:"P1003"},
	"");
	
	// 입력폼 담당수신자 콤보 옵션을 초기화한다.
	loadComboOptions("formCallerCd",
	"/admin/dtfile/ajaxCombo.do",
	{grpCd:"C1002"},
	"");
	
	// 입력폼 실행일 콤보 옵션을 초기화한다.
	loadComboOptions("formUseDtCd",
	"/admin/dtfile/ajaxCombo.do",
	{grpCd:"P1002"},
	"");
	
	// 입력폼 배경HTML 콤보 옵션을 초기화한다.
	loadComboOptions("formHtmlCont",
	"/admin/dtfile/ajaxCombo.do",
	{grpCd:"P1003"},
	"");
	
	//담당수신자 시트 콤보 옵션을 초기화한다.
	loadSheetOptions("DtfileSheet",0,"callerCd",
	"/admin/dtfile/ajaxCombo.do",
	{grpCd:"C1002"});
	
	//실행일 시트 콤보 옵션을 초기화한다.
	loadSheetOptions("DtfileSheet",0,"useDtCd",
	"/admin/dtfile/ajaxCombo.do",
	{grpCd:"P1002"});
	
	//배경HTML 시트 콤보 옵션을 초기화한다.
	loadSheetOptions("DtfileSheet",0,"htmlCont",
	"/admin/dtfile/ajaxCombo.do",
	{grpCd:"P1003"});
	
	//사용여부 시트 콤보 옵션을 초기화한다.
	initSheetOptions("DtfileSheet",0,"useYn",[{
        code:"Y",
        name:"사용"
    }, {
        code:"N",
        name:"미사용"
    }]);
	
}

/**
 * 데이터를 로드한다.
 */
function loadData() {
    // 데이터 파일을 검색한다.
    searchPresMng();
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
 * 독촉관리 목록을 검색한다.
 */
function searchPresMng() {
    // 독촉관리 테이블에서 데이터를 로드한다.
    loadSheetData({
        SheetId:"DtfileSheet",
        PageUrl:"/admin/dtfile/searchPresMng.do"
    }, {
        ObjectParam:{
        },
        FormParam:"search-form"
    }, {
        // Nothing to do.
    });
}

/**
 * 스크립트를 저장합니다.
 * @returns
 */
function savePresMng() {
	var sheet = window["DtfileSheet"];
	var index = sheet.FindCheckedRow("select");
	var formObj = $("form[name=upload-form]");
	
	var scrtNm = formObj.find("input[name=scrtNm]").val();				//스크립트명
    var scrtCont = formObj.find("textarea[name=scrtCont]").val();			//스크립트내용
    var useYn = formObj.find("input[name=useYn]").val();				//사용여부
    var callerCd = formObj.find("select[name=callerCd]").val();			//담당자
    var useDtCd = formObj.find("select[name=useDtCd]").val();			//실행일
    var htmlCont = formObj.find("select[name=htmlCont]").val();			//배경HTML
    
	// 테이블 데이터 삭제 전처리를 수행한다.
	if (beforePresMng("I")) {
		$.post(
	        com.wise.help.url("/admin/dtfile/savePresMng.do"),
	        {
	            "scrtNm":scrtNm,
	            "scrtCont":scrtCont,
	            "useYn":useYn,
	            "callerCd":callerCd,
	            "useDtCd":useDtCd,
	            "htmlCont":htmlCont
	        },
	        function(data, status, request) {
        		alert("스크립트를 저장했습니다.");
        		resetForm();				//폼 초기화
        		searchPresMng();			//시트 조회
	        },
	        "json"
	    ).error(function(request, status, error) {
	        handleError(status, error);
	    });
	}
}

/**
 * 스크립트를 수정합니다.
 * @returns
 */
function updatePresMng() {
	var sheet = window["DtfileSheet"];
	var index = sheet.FindCheckedRow("select");
	var formObj = $("form[name=upload-form]");
	
	var presMngNo = formObj.find("input[name=presMngNo]").val();			//독촉관리번호
	var scrtNm = formObj.find("input[name=scrtNm]").val();				//스크립트명
    var scrtCont = formObj.find("textarea[name=scrtCont]").val();			//스크립트내용
    var useYn = formObj.find("input[name=useYn]").val();				//사용여부
    var callerCd = formObj.find("select[name=callerCd]").val();			//담당자
    var useDtCd = formObj.find("select[name=useDtCd]").val();			//실행일
    var htmlCont = formObj.find("select[name=htmlCont]").val();			//배경HTML
	
	// 테이블 데이터 삭제 전처리를 수행한다.
	if (beforePresMng("U")) {
		$.post(
	        com.wise.help.url("/admin/dtfile/updatePresMng.do"),
	        {
	            "presMngNo":presMngNo,
	            "scrtNm":scrtNm,
	            "scrtCont":scrtCont,
	            "useYn":useYn,
	            "callerCd":callerCd,
	            "useDtCd":useDtCd,
	            "htmlCont":htmlCont
	        },
	        function(data, status, request) {
        		alert("스크립트를 수정했습니다.");
        		resetForm();				//폼 초기화
        		searchPresMng();			//시트 조회
	        },
	        "json"
	    ).error(function(request, status, error) {
	        handleError(status, error);
	    });
	}
}

/**
 * 스크립트를 삭제합니다.
 * @returns
 */
function deletePresMng() {
	var sheet = window["DtfileSheet"];
	var index = sheet.FindCheckedRow("select");
	
	var presMngNo = sheet.GetCellValue(index,"presMngNo");
	
	// 테이블 데이터 삭제 전처리를 수행한다.
	if (beforePresMng("D")) {
		$.post(
	        com.wise.help.url("/admin/dtfile/deletePresMng.do"),
	        {
	            "presMngNo":presMngNo
	        },
	        function(data, status, request) {
        		alert("스크립트를 삭제했습니다.");
        		resetForm();				//폼 초기화
        		searchPresMng();			//시트 조회
	        },
	        "json"
	    ).error(function(request, status, error) {
	        handleError(status, error);
	    });
	}
}

/**
 *  폼 초기화
 */
function resetForm() {
	var sheet = window["DtfileSheet"];
	var index = sheet.FindCheckedRow("select");
	
	if(index > 0) {
		$("#template-save-button").hide();
	    $("#template-del-button").show();
	    $("#template-modify-button").show();
	} else {
		$("#template-save-button").show();
	    $("#template-del-button").hide();
	    $("#template-modify-button").hide();
	}
	
    var formObj = $("form[name=upload-form]");
    
    formObj.find("input[name=presMngNo]").val("");						//독촉관리번호
    formObj.find("input[name=scrtNm]").val("");							//스크립트명
    formObj.find("textarea[name=scrtCont]").val("");						//스크립트내용
    formObj.find("input[name=useYn][value=Y]").prop("checked",true);		//사용여부
    formObj.find("select[name=callerCd]").val("SYS");						//담당자
    formObj.find("select[name=useDtCd]").val("B7D");						//실행일
    formObj.find("select[name=htmlCont]").val("N");						//배경HTML
}

/**
 * 폼 데이터 셋팅
 * @param row
 */
function setForm(row) {
	var sheet = window["DtfileSheet"];
	var index = sheet.FindCheckedRow("select");
	
    var formObj = $("form[name=upload-form]");
    
	formObj.find("input[name=presMngNo]").val(sheet.GetCellValue(index,"presMngNo"));						//독촉관리번호
    formObj.find("input[name=scrtNm]").val(sheet.GetCellValue(index,"scrtNm"));							//스크립트명
    formObj.find("textarea[name=scrtCont]").val(sheet.GetCellValue(index,"scrtCont"));						//스크립트내용
    if(sheet.GetCellValue(index,"useYn") =="Y") {
    	formObj.find("input[name=useYn][value=Y]").prop("checked",true);		//사용여부
    } else {
    	formObj.find("input[name=useYn][value=N]").prop("checked",true);		//사용여부
    }
    formObj.find("select[name=callerCd]").val(sheet.GetCellValue(index,"callerCd"));						//담당자
    formObj.find("select[name=useDtCd]").val(sheet.GetCellValue(index,"useDtCd"));						//실행일
    formObj.find("select[name=htmlCont]").val(sheet.GetCellValue(index,"htmlCont"));						//배경HTML
}


////////////////////////////////////////////////////////////////////////////////
// 전처리 함수
////////////////////////////////////////////////////////////////////////////////
/**
 * 스크립트 저장,수정,삭제 전처리를 실행한다.
 * 
 * @param mode {String} 모드
 */
function beforePresMng(mode) {
    var sheet = window["DtfileSheet"];
    
    var index = sheet.FindCheckedRow("select");
    
    if(mode == "I") {
    	var formObj = $("form[name=upload-form]");
	    
	    var scrtNm = formObj.find("input[name=scrtNm]").val();				//스크립트명
	    var scrtCont = formObj.find("textarea[name=scrtCont]").val();			//스크립트내용
	    var useYn = formObj.find("input[name=useYn]").val();				//사용여부
	    var callerCd = formObj.find("select[name=callerCd]").val();			//담당자
	    var useDtCd = formObj.find("select[name=useDtCd]").val();			//실행일
	    var htmlCont = formObj.find("select[name=htmlCont]").val();			//배경HTML
	    
        if (com.wise.util.isBlank(scrtNm)) {
            alert("독촉스크립트명을 입력하세요.");
            return false;
        }
        if (com.wise.util.isBlank(scrtCont)) {
            alert("독촉스크립트를 입력하세요.");
            return false;
        }
        if (com.wise.util.isBlank(useYn)) {
            alert("사용여부를 선택하세요.");
            return false;
        }
        if (com.wise.util.isBlank(callerCd)) {
            alert("담당자를 선택하세요.");
            return false;
        }
        if (com.wise.util.isBlank(useDtCd)) {
            alert("실행일을 선택하세요.");
            return false;
        }
        if (com.wise.util.isBlank(htmlCont)) {
            alert("배경HTML을 선택하세요.");
            return false;
        }
        
        return true;
    }
    
    if(mode == "U") {
    	if (index) {
    		var formObj = $("form[name=upload-form]");
    	    
    	    var scrtNm = formObj.find("input[name=scrtNm]").val();				//스크립트명
    	    var scrtCont = formObj.find("textarea[name=scrtCont]").val();			//스크립트내용
    	    var useYn = formObj.find("input[name=useYn]").val();				//사용여부
    	    var callerCd = formObj.find("select[name=callerCd]").val();			//담당자
    	    var useDtCd = formObj.find("select[name=useDtCd]").val();			//실행일
    	    var htmlCont = formObj.find("select[name=htmlCont]").val();			//배경HTML
    	    
            if (com.wise.util.isBlank(scrtNm)) {
                alert("독촉스크립트명을 입력하세요.");
                return false;
            }
            if (com.wise.util.isBlank(scrtCont)) {
                alert("독촉스크립트를 입력하세요.");
                return false;
            }
            if (com.wise.util.isBlank(useYn)) {
                alert("사용여부를 선택하세요.");
                return false;
            }
            if (com.wise.util.isBlank(callerCd)) {
                alert("담당자를 선택하세요.");
                return false;
            }
            if (com.wise.util.isBlank(useDtCd)) {
                alert("실행일을 선택하세요.");
                return false;
            }
            if (com.wise.util.isBlank(htmlCont)) {
                alert("배경HTML을 선택하세요.");
                return false;
            }
            
            return true;
        }
        else {
            alert("스크립트를 선택하여 주십시오.");
            return false;
        }
    }
    
    if(mode == "D") {
    	if (index) {
            return true;
        }
        else {
            alert("스크립트를 선택하여 주십시오.");
            return false;
        }
    }
    
}

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
//    removeOpenDtcols();
    
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
                	//폼을 초기화한다.
                	resetForm();
                    //폼으로 조회한다.
                	setForm(row);
                	
                }
                else {
                	//폼을 초기화한다.
                	resetForm();
                }
                break;
        }
    }
}
