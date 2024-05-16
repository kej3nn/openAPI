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
    	
    }, {
        HeaderCheck:0
    }, [
		{ Header:"선택",         SaveName:"select",   Hidden:0, Width:60,  Align:"Center", Sort:0, Type:"Radio",  RadioIcon:0, Edit:1 },
		{ Header:"데이터처리ID", SaveName:"dttranId", Hidden:1, Width:0,   Align:"Center", Sort:0, Type:"Text",   RadioIcon:1, Edit:0 },
		{ Header:"데이터파일ID", SaveName:"dtfileId", Hidden:1, Width:0,   Align:"Center", Sort:0, Type:"Text",   RadioIcon:1, Edit:0 },
		{ Header:"업로드스케쥴번호", SaveName:"uplSchNo", Hidden:1, Width:0,   Align:"Left", Sort:0, Type:"Text",   RadioIcon:1, Edit:0 },
		{ Header:"보유데이터명",     SaveName:"dtNm",   Hidden:0, Width:150,  Align:"Left", Sort:0, Type:"Text",  RadioIcon:1, Edit:0 },
		{ Header:"공공데이터명",     SaveName:"infNm",   Hidden:0, Width:150,  Align:"Left", Sort:0, Type:"Text",  RadioIcon:1, Edit:0 },
		{ Header:"시트명",       SaveName:"shtNm",    Hidden:0, Width:150, Align:"Left",   Sort:0, Type:"Text",   RadioIcon:1, Edit:0 },
		{ Header:"적재주기",     SaveName:"loadCd", Hidden:0, Width:80,  Align:"Center", Sort:0, Type:"Combo",  RadioIcon:1, Edit:0 },
		{ Header:"조직코드",     SaveName:"orgCd",   Hidden:1, Width:0,  Align:"Center", Sort:0, Type:"Text",  RadioIcon:1, Edit:0 },
		{ Header:"조직명",     SaveName:"orgNm",   Hidden:0, Width:80,  Align:"Center", Sort:0, Type:"Text",  RadioIcon:1, Edit:0 },
		{ Header:"등록자명",     SaveName:"usrNm",   Hidden:0, Width:80,  Align:"Center",  Sort:0, Type:"Text",    RadioIcon:1, Edit:0 },
		{ Header:"전화번호",     SaveName:"usrTel", Hidden:0, Width:120, Align:"Center", Sort:0, Type:"Text",   RadioIcon:1, Edit:0 },
		{ Header:"E-mail",     SaveName:"usrEmail",  Hidden:0, Width:150, Align:"Center", Sort:0, Type:"Text",   RadioIcon:1, Edit:0 },
		{ Header:"검증일자",     SaveName:"chkDttm",   Hidden:0, Width:150, Align:"Center", Sort:0, Type:"Text",   RadioIcon:1, Edit:0 },
		{ Header:"검증소요시간(초)",     SaveName:"chkTm",   Hidden:1, Width:0, Align:"Center", Sort:0, Type:"Text",   RadioIcon:1, Edit:0 },
		{ Header:"검증결과",     SaveName:"chckYn",   Hidden:0, Width:80,  Align:"Center", Sort:0, Type:"Combo",  RadioIcon:1, Edit:0 },
		{ Header:"처리결과",     SaveName:"procRslt", Hidden:0, Width:347, Align:"Left",   Sort:0, Type:"Text",   RadioIcon:1, Edit:0 },
		{ Header:"저장여부",     SaveName:"saveYn", Hidden:0, Width:80,  Align:"Center", Sort:0, Type:"Text",  RadioIcon:1, Edit:0 }        
    ], {
        // Nothing do do.
    });
    
    window["DttranSheet"].FitColWidth();
    window["DttranSheet"].SetExtendLastCol(1);
    
    // 데이터 검증 시트를 생성한다.
    createDtchckSheet("Create");

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
//    $("#searchWord").bind("keydown", function(event) {
//        // 엔터키인 경우
//        if (event.which == 13) {
//            // 데이터 처리를 검색한다.
//            searchOpenDttran("");
//            return false;
//        }
//    });

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
    	 if(confirm("이어서 저장하기 버튼을 클릭할 경우 기존에 입력된에 데이터에 추가로 저장됩니다.\n 추가로 저장하시겠습니까?")) {        	
    		 saveOpenDtfileTb("append");
         }    	
        
        return false;
    });
    

    // 미리보기 버튼 클릭 시
    $('#upload-preview-button').bind("click", function() {
    	var dtfileId = $('input[name=dtfileId]').val();
    	var uplSchNo = $('input[name=uplSchNo]').val();
    	if(com.wise.util.isBlank(dtfileId) || com.wise.util.isBlank(uplSchNo)) {
    		alert("미리보기할 항목을 선택해 주세요.");
    		return false;
    	}
    	var popUrl = "/admin/dtfile/uploadPreviewPopup.do?dtfileId="+dtfileId+"&uplSchNo="+uplSchNo;
    	window.open(popUrl,"_uploadPrevPop","width=1024, height=600, resizable=1, scrollbars=no, menubar=no, toolbar=no, location=no, status=no");
    	return false;
    });

    // 이력 엑셀 다운로드
    $('#download-excel-button').bind("click", function() {
    	goDownload({
            url:"/admin/dtfile/downladUploadHistorySheetData.do",
            form:"search-form",
            target:"hidden-iframe"
        });
        return false;
    });
}

/**
 * 조직명 팝업
 */
function poporgnm() {
	var url="/admin/basicinf/popup/commOrg_pop.do";
	var popup = OpenWindow(url,"orgPop","500","550","yes");
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
    }, {
        code:"",
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
        PageUrl:"/admin/dtfile/searchOpenDttran2.do"
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

    window["DtchckSheet"].FitColWidth();
    window["DtchckSheet"].SetExtendLastCol(1);
    
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
    		, success: function(data, status, request) {
	    		$('#loadingCircle').hide()
                // 데이터 파일 테이블 데이터 저장 후처리를 실행한다.
	    		var tranId = window["DtchckSheet"].GetEtcData("dttranId");
                afterSaveOpenDtfileTb(data, status, tranId);
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
function afterSaveOpenDtfileTb(data, status, tranId) {	
	var data2 = JSON.parse(data) ;  // 2016.09.23 변환을 하지 않으면 인식을 못함
    if (data2.success) {
    	if (data2.success.message) {
            alert(data2.success.message);
        }
    	// 성공하면 등록결과  확인 페이지로 이동확인.
    	location.href =  com.wise.help.url("/admin/dtfile/manageOpenDttran2Page.do?dttranId=" + tranId); 
        //location.href="<c:url value='/admin/dtfile/uploadLogPage.do'/>";
    }
    else {
        if (data2.error) {
        	if (data2.error.message) {
        		alert(data2.error.message);
        		// handleError(status, data.error); //  사용안홤
        	}		
          //  location.href="<c:url value='/admin/dtfile/manageOpenDttranPage.do'/>";
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
                    
                    var rowData = sheet.GetRowJson(row);
                	$('input[name=uplSchNo]').val(rowData.uplSchNo);
                	$('input[name=dtfileId]').val(rowData.dtfileId);
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