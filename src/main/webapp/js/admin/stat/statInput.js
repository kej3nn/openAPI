/*
 * @(#)statInput.js 1.0 2017/06/02
 * 
 * COPYRIGHT (C) 2013 WISEITECH CO., LTD. ALL RIGHTS RESERVED.
 */

/**
 * 관리자에서 통계표 입력관련 스크립트 파일이다
 *
 * @author 김정호
 * @version 1.0 2017/06/02
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
var sheetInputTabCnt = 0;						//통계데이터 입력 시트 갯수
var VERIFY_ERROR_CELL_FONT_COLOR = "#ff0000";	//검증결과 폰트 색상(빨간색)
var DEFAULT_CMMT_COLOR = "#FFF612";				//주석 색상
var BATCH_INPUT_STATES = ["WW", "PG", "RC", "RA"];	// 일괄 등록 가능한 입력 상태들(대기, 저장, 반려, 취소승인)

////////////////////////////////////////////////////////////////////////////////
// 초기화 함수
////////////////////////////////////////////////////////////////////////////////
/**
 * 컴포넌트를 초기화한다.
 */
function initComp() {
	tabSet();
	loadMainPage();
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
	
	//메인버튼 이벤트를 바인딩한다.
	setMainButton();
}

//메인버튼 이벤트
function setMainButton() {
	$("button[name=btn_reg]").bind("click", function(event) {
		// 신규등록 폼 탭을 추가한다.
		doActionMain("regForm");
    });
	//분류체계 팝업
	$("button[name=cate_pop]").bind("click", function(e) {
		doActionMain("catePop");
	});
	//분류체계 초기화
	$("button[name=cate_reset]").bind("click", function(e) {
		$("input[name=cateId], input[name=cateIds], input[name=cateNm]").val("");
	});
	//담당부서 팝업
	$("button[name=org_pop]").bind("click", function(e) {
		doActionMain("orgPop");
	});
	//담당부서 초기화
	$("button[name=org_reset]").bind("click", function(e) {
		$("input[name=orgCd], input[name=orgNm]").val("");
	});
	//입력기간 초기화
	$("button[name=wrtYmd_reset]").bind("click", function(e) {
		$("input[name=wrtStartYmd], input[name=wrtEndYmd]").val("");
	});
	//조회
	$("button[name=btn_inquiry]").bind("click", function(e) {
		doActionMain("search");
	});
	//조회 enter
	$("input[name=searchVal]").bind("keydown", function(event) {
        // 엔터키인 경우
        if (event.which == 13) {
            // 데이터 파일을 검색한다.
        	doActionMain("search");
            return false;
        }
    });
	//입력상태 체크박스 제어
	$("input[name=inputStatusAll]").bind("click", function(e) {
		var checked = $(this).is(":checked");
		$("input[name=inputStatus]").each(function(idx) {
			$(this).prop("checked", checked);
		});
	});
	$("input[name=inputStatus]").bind("click", function(e) {
		if ( !$(this).is(":checked") ) {
			$("input[name=inputStatusAll]").prop("checked", false);
		}
	});
	
	// 일괄처리 관련 버튼 이벤트
	$("#batchBtnDiv a").each(function(index, element) {
		var sAction = $(this).attr("name");				// 액션 명
		var wrtstateCd = $(this).attr("data-wrtstate");	// 자료입력코드
		var wrtstateNm = $(this).text();				// 자료입력코드설명
		
		if ( sAction == "batchInput" ) {
			$(this).bind("click", function(e) {
				doActionMain(sAction);
				return false;
			});
		}
		else {
			$(this).bind("click", function(e) { 
				updateWrtstate(wrtstateCd, wrtstateNm, "Y");
				return false;
			});
		}
		
	});
}

/**
 * 옵션을 로드한다.
 */
function loadOptions() {
	//캘린더 초기화
	datePickerInit();
	//자료시점기준
	loadComboOptions2("wrttime", "/admin/stat/ajaxOption.do", {grpCd:"S1103"}, "");
}

/**
 * 데이터를 로드한다.
 */
function loadData() {
}

////////////////////////////////////////////////////////////////////////////////
// 서비스 함수
////////////////////////////////////////////////////////////////////////////////

/**
 * 탭에 속해 있는 폼 객체를 가져온다.
 * @param formNm	폼 명
 */
function getTabFormObj(formNm) {
	var objTab = getTabShowObj();//탭이 oepn된 객체가져옴
	var formObj = objTab.find("form[name="+formNm+"]");
	return formObj
}

/**
 * 탭에 속해 있는 시트 객체를 가져온다.
 * @param formNm	폼 명
 * @param sheetNm	시트 명
 * @returns
 */
function getTabSheetObj(formNm, sheetNm) {
	var formObj = getTabFormObj(formNm);
	var tabSheetNm = formObj.find("input[name="+sheetNm+"]").val();
//	console.log(tabSheetNm);
	var sheetObj = window[tabSheetNm];
	return sheetObj;
}

/**
 * 메인화면 액션
 */
function doActionMain(sAction) {
	//console.log(sAction);
	var classObj = $("."+tabContentClass); //tab으로 인하여 form이 다건임
	var actObj = setTabForm(classObj); // 0: form data, 1: form 객체
	var formObj = $("form[name=statMainForm]");
	switch(sAction) {                       
		case "search":
			ajaxBeforeSendAdmin(com.wise.help.url("/admin/ajaxBeforeSendAdmin.do")); //IbSheet 조회전 세션 체크
			var param = {PageParam: "page", Param: "rows=50"+"&"+actObj[0]};
			statSheet.DoSearchPaging(com.wise.help.url("/admin/stat/statInputMainList.do"), param);
			break;
		case "regForm" :
			var title = "신규등록"
			var id ="statsReg";
			openTab.addRegTab(id,title,tabCallRegBack);
			break;
		case "catePop" :	//분류체계 팝업
			var url = com.wise.help.url("/admin/stat/popup/statsCatePopup.do");
			var data = "?parentFormNm=statMainForm";
			wWidth ="660";                                                    
			wHeight ="530";   
			openIframeStatPop("iframePopUp", url+data, wWidth, wHeight)
			break;	
		case "orgPop" :		//담당부서 팝업
			window.open(com.wise.help.url("/admin/basicinf/popup/commOrg_pop.do") + "?orgNmGb=2&sheetNm=statMainForm", "list" ,"fullscreen=no, width=500, height=550");
			break;
		case "batchInput" :	// 일괄 등록
			batchInput();
			break;
		case "" :
			
			break;
	}
}
/**
 * 입력 시트 관련 액션
 */
function doActionInput(sAction) {
	var classObj = $("."+tabContentClass); //tab으로 인하여 form이 다건임
	var actObj = setTabForm2(classObj, "statInput-dtl-form"); // 0: form data, 1: form 객체
	var formObj = getTabFormObj("statInput-dtl-form");
	var inputSheetObj = getTabSheetObj("statInput-dtl-form", "inputSheetNm");
	
	switch(sAction) {
		case "search" :	//조회
			ajaxBeforeSendAdmin(com.wise.help.url("/admin/ajaxBeforeSendAdmin.do")); //IbSheet 조회전 세션 체크
			var param = {PageParam: "ibpage", Param: "onepagerow=50"+"&"+actObj[0]};
			inputSheetObj.DoSearchPaging(com.wise.help.url("/admin/stat/statInputList.do"), param);
			break;
		case "batchSearch" :	// 일괄 등록 조회
			var strChkRows = statSheet.FindCheckedRow("chkbox");
			var chkRows = strChkRows.split('|');
		
			var wrttimeObj = new Object();
			var wrttimeArr = new Array();		// 자료시점 코드(Array)
			var wrttimeDescArr = new Array();	// 자료시점 코드 설명(Array)
			var wrtSeqArr = new Array();		// 스케쥴번호(Array) -> 데이터 검증 및 저장할때 log 입력시 사용
			
			for ( var i=0; i < chkRows.length; i++ ) {
				wrttimeArr.push(statSheet.GetCellValue(chkRows[i], "wrttimeIdtfrId"));
				wrttimeDescArr.push(statSheet.GetCellValue(chkRows[i], "wrttimeDesc"));
				wrtSeqArr.push(statSheet.GetCellValue(chkRows[i], "wrtSeq"))
			}
			wrttimeArr.sort();		// 시계열 순서대로 정렬한다.
			wrttimeDescArr.sort();	// 시계열 순서대로 정렬한다.
			
			for ( var n in wrttimeArr) {
				$('<input>').attr({
					type : 'hidden',
					name : "batchWrttimeIdtfrId",
					value : wrttimeArr[n]
				}).appendTo(formObj);
			}
			
			for ( var n in wrttimeDescArr) {
				$('<input>').attr({
					type : 'hidden',
					name : "batchWrttimeDesc",
					value : wrttimeDescArr[n]
				}).appendTo(formObj);
			}
			
			for ( var n in wrtSeqArr) {
				$('<input>').attr({
					type : 'hidden',
					name : "batchWrtSeq",
					value : wrtSeqArr[n]
				}).appendTo(formObj);
			}
			
			//wrttimeObj.batchWrttimeIdtfrId = wrttimeArr;
			//wrttimeObj.batchWrttimeDesc = wrttimeDescArr;
			
			formObj.find("input[name=wrttimeDesc]").val(wrttimeDescArr.join(", "));
			
			ajaxBeforeSendAdmin(com.wise.help.url("/admin/ajaxBeforeSendAdmin.do")); //IbSheet 조회전 세션 체크
			//var param = {PageParam: "ibpage", Param: "onepagerow=50"+"&"+actObj[0] + "&" + objParam2Serialize(wrttimeObj)};
			var param = {PageParam: "ibpage", Param: "onepagerow=50"+"&"+formObj.serialize()};
			inputSheetObj.DoSearchPaging(com.wise.help.url("/admin/stat/statInputList.do"), param);
			break;	
		case "verifyExcelSave" :
			verifyExcelSave();	//엑셀 검증 및 저장
			break;
		case "formDown" :		//양식 다운로드
			inputSheetFormDown();
			break;
		case "tableDown" :		//표 다운로드
			inputSheetTableDown();
			break;	
		case "verifySave" :		//검증 및 저장
			verifySave();
			break;
		case "statMetaExpPop" :	//통계 설명 팝업
			window.open(com.wise.help.url("/admin/stat/popup/statMetaExpPopup.do") + "?statblId=" + formObj.find("input[name=statblId]").val() , "list", "fullscreen=no, width=800, height=700");
			break;	
		case "statPreviewPop" :	//통계표 미리보기 팝업
			window.open(com.wise.help.url("/admin/stat/statPreviewPage") + "/" + formObj.find("input[name=statblId]").val() + ".do" , "list", "fullscreen=no, width=1280, height=768");
			break;	
		case "statMarkPop" :	//통계기호 입력시트 팝업
			var url = com.wise.help.url("/admin/stat/popup/statInputMarkPop.do");
			wWidth ="1024";                                                    
			wHeight ="768";   
			openIframePostStatPop(formObj, "iframePopUp", url, wWidth, wHeight)
			break;	
		case "statCmmtPop" :	//주석 입력시트 팝업
			var url = com.wise.help.url("/admin/stat/popup/statInputCmmtPop.do");
			wWidth ="1024";                                                    
			wHeight ="768";   
			openIframePostStatPop(formObj, "iframePopUp", url, wWidth, wHeight)
			break;	
		case "statDifPop" :	// 자료시점 주석 팝업
			var url = com.wise.help.url("/admin/stat/popup/statInputDifPop.do");
			wWidth ="1024";                                                    
			wHeight ="768";   
			openIframePostStatPop(formObj, "iframePopUp", url, wWidth, wHeight)
			break;
		case "wrtLogPop":	// 통계자료작성 처리기록
			var url = com.wise.help.url("/admin/stat/statLogSttsWrtListPopup.do");
			var param = "?statblId="+ formObj.find("input[name=statblId]").val();// + "&wrttimeIdtfrId=" + formObj.find("input[name=wrttimeIdtfrId]").val();
			
			// 일괄등록인 경우
			if ( formObj.find("input[name=batchWrttimeIdtfrId]").length > 0 ) {
				$.each(formObj.find("input[name=batchWrttimeIdtfrId]"), function(i, val) { 
					//param += "&wrttimeIdtfrId["+ i + "]=" + val.value;
					param += "&wrttimeIdtfrId=" + val.value;
				});
			}
			else {
				param += "&wrttimeIdtfrId=" + formObj.find("input[name=wrttimeIdtfrId]").val();
			}
			
	    	OpenWindow(url + param, "wrtLogPop", "1024", "550", "yes");
			break;
			
	}
}

/**
 * iframe POST로 열기
 * @param formObj
 * @param iframeNm
 * @param url
 * @param _width
 * @param _height
 */
function openIframePostStatPop(formObj, iframeNm, url, _width, _height){
	var width = _width || "660";
	var height = _height || "530";
	
	if(iframeNm == "" || iframeNm == undefined){
		iframeNm = "iframePopUp";               
	}  
	
	formObj.attr("target", "iframePopUp");
	
	$(".back").css("width",screen.width)                                                 
				.css("height",screen.height)
				.css("top", $(window).scrollTop())               
				.css("left", $(window).scrollLeft())
				.show();                    
	 $("iframe[name="+iframeNm+"]")
	 	.css("height", height + "px")                                         
	 	.css("width", width+"px")      
	 	.css("top", (($(window).height() - height) / 2) + $(window).scrollTop() + "px")
	 	.css("left", (($(window).width() - width) / 2) + $(window).scrollLeft() + "px").show();
	 
	 formObj.attr("action", url);       
	 formObj.submit();
}  

/**
 * 일괄 등록
 */
function batchInput() {
	
	var strChkRows = statSheet.FindCheckedRow("chkbox");
	var chkRows = strChkRows.split('|');
	
	if ( gfn_isNull(strChkRows) ) {
		alert("일괄 입력할 행을 선택하세요.");
		return false;
	} else if ( chkRows.length == 1 ) {
		alert("최소 2개 이상의 통계표를 선택하세요");
		return false;
	}
	
	// 통계표, 주기가 같은것만 입력가능(validation 추가해야함)
	var arrStatblId = [];
	var arrDtacycleCd = [];
	var arrWrtstateCd = [];
	
	for ( var row in chkRows ) {
		var statblId = statSheet.GetCellValue(chkRows[row], "statblId");
		if($.inArray(statblId, arrStatblId) === -1) arrStatblId.push(statblId);
		
		var dtacycleCd = statSheet.GetCellValue(chkRows[row], "dtacycleCd");
		if($.inArray(dtacycleCd, arrDtacycleCd) === -1) arrDtacycleCd.push(dtacycleCd);
		
		var wrtstateCd = statSheet.GetCellValue(chkRows[row], "wrtstateCd");
		if($.inArray(wrtstateCd, arrWrtstateCd) === -1) arrWrtstateCd.push(wrtstateCd);
	}
	
	if ( arrStatblId.length > 1 ) {
		alert("동일한 통계표를 선택해 주세요.");
		return false;
	}
	
	if ( arrDtacycleCd.length > 1 ) {
		alert("동일한 주기를 선택해 주세요.");
		return false;
	}
	
	// 입력 상태 체크
	for ( var r in arrWrtstateCd ) {
		
		if ( !includes(BATCH_INPUT_STATES, arrWrtstateCd[r]) ) {
			alert("[대기, 저장, 반려, 취소승인] 상태만 일괄등록 할 수 있습니다.");
			return false;
		}
	}
	
	var id = gfn_randomToFixed(6);
	openTab.SetTabData(statSheet.GetRowJson(chkRows[0]));//db data 조회시 조건 data
	var url =  com.wise.help.url('/admin/stat/statInputDtl.do'); // Controller 호출 url 
	openTab.addTab(id, "일괄 등록", url, tabCallBack); 	// 탭 추가 시작함
	inputSheetCreate(sheetInputTabCnt++, 'Y');
}

/**
 * 엑셀 검증 및 저장
 */
function verifyExcelSave() {
	var formObj = getTabFormObj("statInput-dtl-form");
	
	if ( formObj.find("input[name=uploadExcelFile]").val() == "" ) {
		alert("파일을 선택하세요.");
		return false;
	}
	//식별번호 숫자체크
	if ( !validCmmtIdtfr("sttsCmmtIdtfr") ) {
		return false;
	}
	
	formObj.attr("action", com.wise.help.url("/admin/stat/insertStatInputExcelData.do"));
	formObj.attr("target", "hidden-iframe");
	
	formObj.ajaxForm({
    	async: false
    	, beforeSend: function() {
    		formObj.find("#loadingCircle").show();
    	}
    	, success: function(data) {
    		//doAjaxMsg(JSON.parse(data), "/admin/stat/statInputPage.do");
    		afterVerifySave(JSON.parse(data));
    		formObj.find("#loadingCircle").hide();
    	}
    	, error: function(msg, a, b) {
    		alert(msg);
    	}
    });
	    
	formObj.submit();
}

/**
 * 시트 데이터 검증 및 저장
 */
function verifySave() {
	var formObj = getTabFormObj("statInput-dtl-form");
	var inputSheetObj = getTabSheetObj("statInput-dtl-form", "inputSheetNm");
	
	inputSheetObj.ExtendValidFail = 0;
	var inputSheetJson = inputSheetObj.GetSaveJson({AllSave:true, ValidKeyField: 1});
	
	if (inputSheetJson.Code) {
        switch (inputSheetJson.Code) {
            case "IBS000":
                alert("저장할 내역이 없습니다.");
                break;
            case "IBS010":
            case "IBS020":
                // Nothing to do.
                break;
        }
    }
	else {
		//식별번호 숫자체크
		
		if ( !validCmmtIdtfr("sttsCmmtIdtfr") ) {
			return false;
		}
		
		if ( !confirm("검증 및 저장 하시겠습니까?") ) {
			return false;
		}
    	var params = "&ibsSaveJson=" + encodeURIComponent(JSON.stringify(inputSheetJson));
			//+ "&ibsSaveJson2=" + encodeURIComponent(JSON.stringify(cmmtSheetObj.GetSaveJson({AllSave:true})))
		var datas = openTab.ContentObj.find("form[name=statInput-dtl-form]").serialize() + params;
    	
    	$.ajax({
    	    url: com.wise.help.url("/admin/stat/insertStatInputData.do"),
    	    async: false, 
    	    type: 'POST', 
    	    data: datas,
    	    dataType: 'json',
    	    beforeSend: function(obj) {
    	    }, 
    	    success: function(data, status, request) {
    	    	//handleResponse(data, status, request);
    	    	afterVerifySave(data);
    	    },
    	    error: function(request, status, error) {
    	    	handleError(status, error);
    	    },
    	    complete: function(jqXHR) {} 
    	});
    }
}

/**
 * 입력 시트 양식 저장
 */
function inputSheetFormDown() {
	/*
	var params = {
		
		URL : com.wise.help.url("/admin/stat/down2StatInputForm.do"),
		ExtendParam : "statblId="+ formObj.find("input[name=statblId]").val() 
			+"&wrttimeIdtfrId=" + formObj.find("input[name=wrttimeIdtfrId]").val()
			+"&wrttimeDesc=" + formObj.find("input[name=wrttimeDesc]").val() ,
		SheetDesign : 1,
	    Merge : 1,
	    Mode : -1,
	    NumberFormatMode : 1,
	    FileName : formObj.find("input[name=statblNm]").val() + ".xls",
	    SheetName : formObj.find("input[name=statblNm]").val(),
	    Multipart :0
	};
	//inputSheetObj.Down2Excel(params);
	inputSheetObj.DirectDown2Excel(params);
	*/
	var formObj = getTabFormObj("statInput-dtl-form");
	
    $(formObj).ajaxSubmit({
        beforeSubmit:function(data, form, options) {
        	showLoadingMask();
            return true;
        },
        url:com.wise.help.url("/admin/stat/down2ExcelForm.do"),
        dataType:"json",
        success:function(data, status, request, form) {
            handleResponse(data, status, options);
            
            hideLoadingMask();
        },
        error:function(request, status, error) {
            handleError(status, error);
            
            hideLoadingMask();
        }
    });
}

/**
 * 입력 시트 표 다운로드
 */
function inputSheetTableDown() {
	var formObj = getTabFormObj("statInput-dtl-form");
	var inputSheetObj = getTabSheetObj("statInput-dtl-form", "inputSheetNm");
	var params = {
		/*
		URL : com.wise.help.url("/admin/stat/down2StatInputForm.do"),
		ExtendParam : "statblId="+ formObj.find("input[name=statblId]").val() 
			+"&wrttimeIdtfrId=" + formObj.find("input[name=wrttimeIdtfrId]").val()
			+"&wrttimeDesc=" + formObj.find("input[name=wrttimeDesc]").val() ,
		*/
		SheetDesign : 1,
	    Merge : 1,
	    Mode : -1,	//	Status, DelCheck, Result 타입 및 Hidden 컬럼을 제외하고 다운로드
	    NumberFormatMode : 0,
	    FileName : formObj.find("input[name=statblNm]").val() + ".xls",
	    SheetName : formObj.find("input[name=statblNm]").val()
	   // Multipart :0
	};
	inputSheetObj.Down2Excel(params);
	//inputSheetObj.DirectDown2Excel(params);
	 
}

/**
 * 식별번호 숫자체크
 * @param objNm
 * @returns {Boolean}
 */
function validCmmtIdtfr(objNm) {
	var formObj = getTabFormObj("statInput-dtl-form");
	if (  !com.wise.util.isBlank(formObj.find("input[name="+objNm+"]").val()) 
			&& !com.wise.util.isNumeric(formObj.find("input[name="+objNm+"]").val()) ) {
		alert("식별번호는 숫자만 입력하세요.");
		formObj.find("input[name="+objNm+"]").focus();
		return false;
	}
	return true;
}

function validBatchProc(wrtstate, chkWrtstate) {
	var valid = { valid : false, msg : ""}
	
	switch(wrtstate) {
		case "AW" : 	
			// 승인요청 -> 저장, 반려상태만 가능
			valid.valid = includes(["PG", "RC"], chkWrtstate);
			valid.status = "저장";
			break;
		case "AC" :
		case "RC" :
			// 승인, 반려 -> 승인요청 상태만 가능
			valid.valid = includes(["AW"], chkWrtstate);
			valid.status = "승인, 반려";
			break;
		case "RQ" :
			// 취소요청 -> 승인상태만 가능
			valid.valid = includes(["AC"], chkWrtstate);
			valid.status = "승인";
			break;
		case "RA" :
		case "QR" :	
			// 취소승인, 취소반려 -> 취소요청 상태만 가능
			valid.valid = includes(["RQ"], chkWrtstate);
			valid.status = "취소요청";
			break;
		case "WL" :
			// 입력제한 -> 대기, 저장, 반려, 취소승인 상태만 가능
			valid.valid = includes(["WW", "PG", "RC", "RA"], chkWrtstate);
			valid.status = "대기, 저장";
			break;
		case "WW" :
			// 입력대기 -> 입력제한 상태만 가능
			valid.valid = includes(["WL"], chkWrtstate);
			valid.status = "입력제한";
			break;		
	}
	
	return valid;
}

/**
 * 자료작성상태코드 변경 처리
 * @param wrtstate		변경 할 자료작성상태코드
 * @param wrtstateNm	변경 할 자료작성상태코드명
 * @param batchYn		일괄 처리 여부
 * @returns {Boolean}
 */
function updateWrtstate(wrtstate, wrtstateNm, batchYn) {
	
	var batchYn = batchYn || "N";
	var valueCd = getParam("valueCd");	
	var params = {};
	
	// 배치 처리일 경우 분기 처리
	if ( batchYn == "Y" ) {
		
		var wrtSeqs = [];
		var strChkRows = statSheet.FindCheckedRow("chkbox");
		var chkRows = strChkRows.split('|');
		
		if ( gfn_isNull(strChkRows) ) {
			alert("일괄 처리할 행을 선택하세요.");
			return false;
		}
		
		for ( var row in chkRows ) {
			
			var valid = validBatchProc(wrtstate, statSheet.GetCellValue(chkRows[row], "wrtstateCd"));
			//console.log(valid);
			if ( !valid.valid ) {
				alert(wrtstateNm + "처리는\n[" + valid.status + "] 상태만 할 수 있습니다.");
				return false;
			}
			
			wrtSeqs.push(statSheet.GetCellValue(chkRows[row], "wrtSeq"));
		}
		
		params["batchYn"] = "Y";
		params["wrtSeqs"] = wrtSeqs;
		params["wrtStateCd"] = wrtstate;
		
	}
	// 단건 처리일 경우
	else {

		var formObj = getTabFormObj("statInput-dtl-form");
		var verifyErrCnt = formObj.find("div[name=verifyYnTxt] label").text();

		//검증오류 체크
		if ( wrtstate == "AW" && Number(verifyErrCnt) > 0 ) {	//승인요청시 검증오류체크
			alert(verifyErrCnt + "건의 검증오류가 발견되었습니다.\n["+ wrtstateNm +"]할 수 없습니다.");
			return false; 
		}
		
		$.each(formObj.serializeArray(), function(index, element) {
	        switch (element.name) {
	        	case "statblId":		case "wrttimeIdtfrId":	case "wrtSeq":	case "wrtMsgCont":	
	            	params[element.name] = element.value;
	            	break;
	        }
	    });
		
		params["wrtStateCd"] = wrtstate;
	}
	
	if ( !confirm(wrtstateNm +" 하시겠습니까?") )	return false;
	
	doAjax({
		url : "/admin/stat/updateWrtstate.do",
		params : params,
		//succUrl : "/admin/stat/statInputPage.do" + (valueCd ? "?valueCd=" + valueCd : "")
		callback : afterTabRemove
	});
}

/**
 * object to queryString
 * @param objParam
 * @returns
 */
function objParam2Serialize(objParam) {
	var params = Object.keys(objParam).map(function(key) {
		var d = "";
		if ( decodeURIComponent(objParam[key]).indexOf(",") > -1 ) {
			// 분류, 항목은 array로 되어있어서.
			var split = decodeURIComponent(objParam[key]).split(",");
			for ( var i=0; i < split.length; i++ ) {
				d += decodeURIComponent(key) + "=" + split[i];
				if ( i < split.length-1 ) {
					d += "&";
				}
			}
		} else {
			d = decodeURIComponent(key) + '=' + decodeURIComponent(objParam[key]); 
		}
	    return d;
	}).join('&');
	return params;
}
////////////////////////////////////////////////////////////////////////////////
// 전처리 함수
////////////////////////////////////////////////////////////////////////////////
function beforeVerifySave() {
	//필수 값 체크...
	return true;
}

////////////////////////////////////////////////////////////////////////////////
// 후처리 함수
////////////////////////////////////////////////////////////////////////////////
function afterVerifySave(data) {
	//doAjaxMsg(data, "/admin/stat/statInputPage.do");
	if (data.success) {
        if (data.success.message) {
            alert(data.success.message);
            //afterTabRemove(data);
            //탭을 닫지않고 시트 reload
            doActionInput("search");
        }
    } else if (data.error) {
    	if (data.error.message) {
    		alert(data.error.message);
    	}
    }
}
////////////////////////////////////////////////////////////////////////////////
//탭 관련 함수
////////////////////////////////////////////////////////////////////////////////
function tabSet(){ //탭 객체 생성  
	openTab = new OpenTab(tabId,tabContentClass,tabBody); //headinclude.jsp 변수 있음
	openTab.TabObj = openTab;  
	openTab.addTabClickEvent();            
}
//탭 버튼 이벤트
function buttonEventAdd() {
	setTabButton();     
}

//상세 탭 이벤트 후처리
function tabFunction(tab, data) {
	var formObj = getTabFormObj("statInput-dtl-form");
	var prssAccCd = 0;	//처리권한코드
	
	if ( data.DATA2.length > 0 ) {
		prssAccCd = data.DATA2[0].prssAccCd
	}
	
	$.each(data.DATA, function(key, val) {
		if ( key == "wrtDttm" ) {
			tab.ContentObj.find("input[name=wrtDttm]").val("( 제출일 : " + (com.wise.util.isBlank(val) ? "--" : val) + " )");
		} else if ( key == "accDttm" ) {
			tab.ContentObj.find("input[name=accDttm]").val("( 승인일 : " + (com.wise.util.isBlank(val) ? "--" : val) + " )");
		} else if ( key == "wrtStateCd" ) {	//입력상태
			setWrtStateButton(tab, val, prssAccCd);
		} else if ( key == "wrtUsrNm" ) {
			var wrtOrgNm = tab.ContentObj.find("input[name=wrtOrgNm]").val();
			if ( !com.wise.util.isBlank(val) ) {
				tab.ContentObj.find("input[name=wrtOrgNm]").val(wrtOrgNm + " ( " + val + " )");
			}
		} else if ( key == "wrtDttmDesc") {	//입력기간
			var wrtBetweenYmd = tab.ContentObj.find("input[name=wrtBetweenYmd]").val();
			if ( !com.wise.util.isBlank(val) ) {
				tab.ContentObj.find("input[name=wrtBetweenYmd]").val(wrtBetweenYmd + " ( " + val + " )");
			}
		}
	}); 
}

/**
 * 자료작성상태코드에 따른 버튼 show/hide 
 * @param tab   {Object} 탭
 * @param state {String} 상태값
 * @param prssAccCd {Number} 처리권한코드
 */
function setWrtStateButton(tab, state, prssAccCd) {
	if ( com.wise.util.isNull(prssAccCd) ) return;
	var formObj = getTabFormObj("statInput-dtl-form");
	
	switch(state) {
	case "WW" : 	//대기
		if ( prssAccCd > 10 ) {		//조회 권한 이상일 경우
			tab.ContentObj.find("a[name=a_verifySave]").show();			//검증 및 저장
			tab.ContentObj.find("a[name=a_verifyExcelSave]").show();	//업로드 및 검증
		}
		break;
	case "PG" :		//저장
	case "RC" : 	//반려
	case "RA" : 	//취소승인	
		if ( prssAccCd > 10 ) {
			tab.ContentObj.find("a[name=a_reqAprov]").show();			//승인요청
			tab.ContentObj.find("a[name=a_verifySave]").show();			//검증 및 저장
			tab.ContentObj.find("a[name=a_verifyExcelSave]").show();	//업로드 및 검증
			tab.ContentObj.find("a[name=a_inputLimit]").show();			//입력제한
		}
		break;
	case "AW" :		//제출(승인요청상태)
		if ( prssAccCd > 30 ) {		//승인 권한 이상일 경우
			tab.ContentObj.find("a[name=a_aprov]").show();			//승인(승인권한)
			tab.ContentObj.find("a[name=a_return]").show();			//반려(승인권한)
		}
		break;
	case "RQ" : 	//취소요청
		if ( prssAccCd > 30 ) {
			tab.ContentObj.find("a[name=a_cancelAprov]").show();	//취소승인(관리자)
			tab.ContentObj.find("a[name=a_cancelReturn]").show();	//취소반려(관리자)
		}
		break;
	case "AC" :		//승인
		if ( prssAccCd > 10 ) {
			tab.ContentObj.find("a[name=a_reqCancel]").show();		//취소요청(요청자)
		}
		break;
	case "WL" : 	//입력제한
		if ( prssAccCd > 10 ) {
			tab.ContentObj.find("a[name=a_inputWait]").show();		//입력대기
		}
	}
}

//신규등록 탭 추가시 callback 함수(tab.js에 정의되어있음....)
function regUserFunction() {
	var objTab = getTabShowObj();//탭이 oepn된 객체가져옴
	var formObj = objTab.find("form[name=statInput-dtl-form]");
	//formObj.find("a[name=a_save]").hide();	//저장버튼 숨김
}

//상세 탭 이벤트
function tabEvent(row){//탭 이벤트 실행  
	var title = statSheet.GetCellValue(row,"statblNm");//탭 제목
	title = title.substring(0, title.indexOf("<a"));	//아이콘 없앰
	var id = statSheet.GetCellValue(row, "wrtSeq");//탭 id(유일한key))
	openTab.SetTabData(statSheet.GetRowJson(row));//db data 조회시 조건 data
	var url =  com.wise.help.url('/admin/stat/statInputDtl.do'); // Controller 호출 url 
	openTab.addTab(id, title, url, tabCallBack); 	// 탭 추가 시작함
	inputSheetCreate(sheetInputTabCnt++);
}  


function inputSheetCreate(SheetCnt, batchYn){ 
	var batchYn = batchYn || "N";
 	var sheetNm = "inputSheet"+SheetCnt;  
 	$("div[name=inputSheet]").eq(1).attr("id","DIV_"+sheetNm);                                          
 	createIBSheet2(document.getElementById("DIV_"+sheetNm),sheetNm, "100%", "400px");               
 	var sheetobj = window[sheetNm]; 
 	var objTab = getTabShowObj();//탭이 oepn된 객체가져옴
 	var formObj = objTab.find("form[name=statInput-dtl-form]");
 	formObj.find("input[name=inputSheetNm]").val(sheetNm);
 	loadInputSheet(sheetNm, sheetobj, batchYn);
 	window[sheetNm + "_OnSearchEnd"] = inputSheetSearchEnd;
 	window[sheetNm + "_OnSaveEnd"] = inputSheetSaveEnd;
}

////////////////////////////////////////////////////////////////////////////////
//시트 로드
////////////////////////////////////////////////////////////////////////////////
function loadMainPage() {
	
	createIBSheet2(document.getElementById("statSheet"),"statSheet", "100%", "300px");
	
	var gridTitle ="NO";
	gridTitle +="|선택";
	gridTitle +="|자료작성ID";
	gridTitle +="|자료시점";
	gridTitle +="|통계표ID";
	gridTitle +="|통계표명(숨김)";
	gridTitle +="|통계표명";
	gridTitle +="|분류";
	gridTitle +="|담당부서(담당자)";
	gridTitle +="|자료시점";
	gridTitle +="|자료작성시점코드";
	gridTitle +="|입력기간";
	gridTitle +="|제출일";
	gridTitle +="|입력상태";
	gridTitle +="|입력상태코드";
	
	with(statSheet){
		                     
		var cfg = {SearchMode:3,Page:50,VScrollMode:1};
	    SetConfig(cfg);
	    var headers = [
	                {Text:gridTitle, Align:"Center"}
	            ];
	    var headerInfo = {Sort:0,ColMove:0,ColResize:1,HeaderCheck:1};
	    
	    InitHeaders(headers, headerInfo);
	   
	    var cols = [
	                 {Type:"Seq",		SaveName:"seq",				Width:30,	Align:"Center",		Edit:false}
	                ,{Type:"CheckBox",	SaveName:"chkbox",			Width:60,	Align:"Center",		Edit:true}
	                ,{Type:"Text",		SaveName:"wrtSeq",			Width:70,	Align:"Center",		Edit:false}
	                ,{Type:"Text",		SaveName:"dtacycleCd",		Width:70,	Align:"Center",		Edit:false,	Hidden:true} 
					,{Type:"Text",		SaveName:"statblId",		Width:70,	Align:"Center",		Edit:false}
					,{Type:"Text",		SaveName:"statblNm",		Width:100,	Align:"Left",		Edit:false,	Hidden:true}
					,{Type:"Html",		SaveName:"statblNmExp",		Width:300,	Align:"Left",		Edit:false}
					,{Type:"Text",		SaveName:"cateNm",			Width:90,	Align:"Center",		Edit:false}
					,{Type:"Text",		SaveName:"wrtOrgUsrNm",		Width:120,	Align:"Center",		Edit:false}
					,{Type:"Text",		SaveName:"wrttimeDesc",		Width:80,	Align:"Center",		Edit:false}
					,{Type:"Text",		SaveName:"wrttimeIdtfrId",	Width:80,	Align:"Center",		Edit:false,	Hidden:true}
					,{Type:"Text",		SaveName:"wrtBetweenYmd",	Width:150,	Align:"Center",		Edit:false}
					,{Type:"Text",		SaveName:"wrtDttm",			Width:80,	Align:"Center",		Edit:false}
					,{Type:"Text",		SaveName:"wrtstateNm",		Width:60,	Align:"Center",		Edit:false}
					,{Type:"Text",		SaveName:"wrtstateCd",		Width:60,	Align:"Center",		Edit:false, Hidden:true}
	            ];                                          
	    InitColumns(cols);
	    FitColWidth();
	    SetExtendLastCol(1);
	}               
	default_sheet(statSheet);   
	
	doActionMain("search");
}


function loadInputSheet(sheetNm, sheetObj, batchYn) {
	var batchYn = batchYn || "N";
	var objTab = getTabShowObj();//탭이 oepn된 객체가져옴
	var formObj = objTab.find("form[name=statInput-dtl-form]");
	$.ajax({
	    url: com.wise.help.url("/admin/stat/statInputItm.do"),
	    async: false, 
	    type: 'POST', 
	    data: formObj.serializeObject(),
	    dataType: 'json',
	    beforeSend: function(obj) {
	    }, // 서버 요청 전 호출 되는 함수 return false; 일 경우 요청 중단
	    success: function(data) {
	    	var rtnData = initStatInputSheet(data);		//통계표 입력시트 초기화
	    	//console.log(rtnData);
	    	with(sheetObj){
	    		var cfg = {SearchMode:2,	Page:50,	VScrollMode:1,	MergeSheet: 7};
	    	    SetConfig(cfg);
	    	    var headerInfo = {Sort:0,ColMove:1,ColResize:1,HeaderCheck:0};
	    	    
	    	    InitHeaders(rtnData.headTxt, headerInfo);
	    	    
	    	    InitColumns(rtnData.cols);
	    	    //validation 처리를 위해 항목의 마지막 레벨 text값 뿌려주고 실제로는 숨김처리
	    	    SetRowHidden(rtnData.gridRowLen - 1, true);	
	    	    //FitColWidth();
	    	    SetExtendLastCol(1);	//마지막열에 맞춰 넓이 맞추기
	    	}               
	    	default_sheet(sheetObj);  
	    	
	    	if ( batchYn == "Y" ) {
	    		formObj.find("input[name=batchYn]").val("Y");
	    		doActionInput("batchSearch");
	    	}
	    	else {
	    		doActionInput("search");
	    	}
	    }, // 요청 완료 시
	    error: function(request, status, error) {
	    	handleError(status, error);
	    }, // 요청 실패.
	    complete: function(jqXHR) {} // 요청의 실패, 성공과 상관 없이 완료 될 경우 호출
	});
}

////////////////////////////////////////////////////////////////////////////////
//시트 서비스 함수
////////////////////////////////////////////////////////////////////////////////
//메인 시트 더블클릭 이벤트
function statSheet_OnDblClick(row, col, value, cellx, celly) {
	if(row < 1) return;                                         
	    tabEvent(row);
}


/**
 * 입력 시트 조회 후 처리 함수 
 */
function inputSheetSearchEnd(code, message, statusCode, statusMessage) {
	var objTab = getTabShowObj();//탭이 oepn된 객체가져옴
	var formObj = objTab.find("form[name=statInput-dtl-form]");
	var inputSheetNm = formObj.find("input[name=inputSheetNm]").val();
	var inputSheetObj = window[inputSheetNm];	//통계데이터 시트
	
	// 검증 데이터 조회
	$.ajax({
	    url: com.wise.help.url("/admin/stat/statInputVerifyData.do"),
	    async: false, 
	    type: 'POST', 
	    data: formObj.serialize(),
	    dataType: 'json',
	    beforeSend: function(obj) {
	    }, 
	    success: function(data) {
	    	$.each(data.data, function(i, json) {
	    		var dtadvsCd = json.dtadvsCd;
	    		var clsDatano = String(json.clsDatano);
	    		var grpDatano = String(json.grpDatano);
	    		var wrttimeIdtfrId = json.wrttimeIdtfrId;
	    		var itmCol = inputSheetObj.SaveNameCol("iCol_" + json.itmDatano);	//항목 컬럼넘버
	    		setSheetChangeCellStyle(inputSheetObj, {
	    			"wrttimeIdtfrId" : wrttimeIdtfrId,
	    			"grpDatano" : grpDatano,
	    			"clsDatano" : clsDatano,
	    			"dtadvsCd" 	: dtadvsCd,
	    			"itmCol" 	: itmCol,
	    			"fontColor"	: VERIFY_ERROR_CELL_FONT_COLOR,
	    			"fontBold"	: true,
	    			"tooltip"	: json.verifyRslt
	    		});
	    	});
	    	
	    	if ( data.data.length > 0 ) {
	    		//오류 건수 표시
	    		formObj.find("[name=verifyYnTxt]").empty().append("※ <label style=\"color: red; vertical-align: baseline;\">"+data.data.length+"</label>건의 오류가 있습니다.");
	    	} else {
	    		formObj.find("[name=verifyYnTxt]").empty().text("※ 오류가 없습니다.");
	    	}
	    },
	    error: function(request, status, error) {
	    	handleError(status, error);
	    },
	    complete: function(jqXHR) {} 
	});	
	
	// 주석 데이터 조회(셀에 색 표시)
	$.ajax({
	    url: com.wise.help.url("/admin/stat/statInputCmmtList.do"),
	    async: false, 
	    type: 'POST', 
	    data: formObj.serialize(),
	    dataType: 'json',
	    beforeSend: function(obj) {
	    }, 
	    success: function(data) {
	    	$.each(data.data, function(i, json) {
	    		var dtadvsCd = json.dtadvsCd;
	    		var clsDatano = String(json.clsDatano);
	    		var grpDatano = String(json.grpDatano);
	    		var wrttimeIdtfrId = json.wrttimeIdtfrId;
	    		var itmCol = inputSheetObj.SaveNameCol("iCol_" + json.itmDatano);	//항목 컬럼넘버
	    		
	    		//주석 셀 색상변경
	    		setSheetChangeCellStyle(inputSheetObj, {
	    			"wrttimeIdtfrId" : wrttimeIdtfrId,
	    			"grpDatano" : grpDatano,
	    			"clsDatano" : clsDatano,
	    			"dtadvsCd" : dtadvsCd,
	    			"itmCol" : itmCol,
	    			"color"	: DEFAULT_CMMT_COLOR
	    		});
	    		
	    	});
	    },
	    error: function(request, status, error) {
	    	handleError(status, error);
	    },
	    complete: function(jqXHR) {} 
	});	
}

/**
 * 입력 시트 저장 후 처리 
 */
function inputSheetSaveEnd(code, message, statusCode, statusMessage) {
	var objTab = getTabShowObj();//탭이 oepn된 객체가져옴
	var formObj = objTab.find("form[name=statInput-dtl-form]");
	if(code >= 0) {
        alert("정상적으로 저장 되었습니다.");
        if ( "Y".equals(formObj.find("input[name=batchYn]").val()) ) {
        	doActionInput("batchSearch");
        } else {
        	doActionInput("search");
        }
        //doActionCmmt("search");
        //저장상태로 버튼 show/hide
    } else {
    	alert("저장에 실패하였습니다");
	}
}

/**
 * 통계표 입력 시트 셀 스타일을 지정한다.
 * @param sheet
 * @param param
 * @returns {Boolean}
 */
function setSheetChangeCellStyle(sheet, param) {
	var clsDatano 		= param.clsDatano 		|| "";			//항목 데이터번호
	var grpDatano 		= param.grpDatano 		|| "";			//그룹 데이터번호
	var wrttimeIdtfrId	= param.wrttimeIdtfrId 	|| "";			//자료시점 코드
	var dtadvsCd 		= param.dtadvsCd 		|| "";			//비교자료 구분코드
	var itmCol 			= param.itmCol 			|| "";			//항목 컬럼번호
	var fontColor 		= param.fontColor		|| "black";		//글 색상
	var fontBold 		= param.fontBold		|| false;		//글 굵기
	var tooltip  		= param.tooltip  		|| "";			//tooltip
	if ( dtadvsCd == "" || itmCol == "" ) {
		return false;
	}

	var wrttimeIdtfrId = sheet.FindText("wrttimeIdtfrId", wrttimeIdtfrId);
	
	// 그룹, 분류 모두 있는경우
	if ( !com.wise.util.isNull(grpDatano) && !com.wise.util.isNull(clsDatano) ) {
		var grpRow = sheet.FindText("gColDatano", grpDatano, wrttimeIdtfrId);	//그룹자료코드 Text 찾은후
		var clsRow = sheet.FindText("cColDatano", clsDatano, grpRow);			//분류자료코드 Text 찾은후
		var dtaRow = sheet.FindText("dtadvsCd", dtadvsCd, clsRow);		//분류자료코드 찾은 위치에서 통계자료 코드 찾음
	}	// 그룹만 있는경우
	else if ( !com.wise.util.isNull(grpDatano) && com.wise.util.isNull(clsDatano) ) {
		var grpRow = sheet.FindText("gColDatano", grpDatano, wrttimeIdtfrId);	//그룹자료코드 Text 찾은후
		var dtaRow = sheet.FindText("dtadvsCd", dtadvsCd, grpRow);		//그룹자료코드 찾은 위치에서 통계자료 코드 찾음
	}	// 분류만 있는경우
	else if ( !com.wise.util.isNull(clsDatano) ) {
		var clsRow = sheet.FindText("cColDatano", clsDatano, wrttimeIdtfrId);			//분류자료코드 Text 찾은후
		var dtaRow = sheet.FindText("dtadvsCd", dtadvsCd, clsRow);		//분류자료코드 찾은 위치에서 통계자료 코드 찾음
	} 	// 그룹, 분류값이 없는경우 자료구분코드로 컬럼위치 확인
	else {
		var dtaRow = sheet.FindText("dtadvsCd", dtadvsCd, wrttimeIdtfrId);
	}
	
	//셀 배경색 변경
	param.color && sheet.SetCellBackColor(dtaRow, itmCol, param.color);		
	
	//데이터 검증 오류가 있는 셀은 제외
	if ( sheet.GetCellFontColor(dtaRow, itmCol) != VERIFY_ERROR_CELL_FONT_COLOR ) {
		sheet.SetCellFontBold(dtaRow, itmCol, fontBold);	//볼드체 적용
		sheet.SetCellFontColor(dtaRow, itmCol, fontColor);	//글씨 색상
	}
	//tooltip 내용이 있는 경우 표시
	if ( tooltip ) {
		sheet.SetToolTipText(dtaRow, itmCol, tooltip);
	}
}

////////////////////////////////////////////////////////////////////////////////
//이벤트 함수
////////////////////////////////////////////////////////////////////////////////
/**
 * 탭 관련 버튼 이벤트
 */
function setTabButton() {
	var objTab = getTabShowObj();//탭이 oepn된 객체가져옴
	var formObj = objTab.find("form[name=statInput-dtl-form]");
	
	formObj.find("a[name=a_verifySave]").bind("click", function() {
		//검증 및 저장
		doActionInput("verifySave");
	});
	
	formObj.find("a[name=a_verifyExcelSave]").bind("click", function() {
		//업로드 및 저장
		doActionInput("verifyExcelSave");
	});
	
	formObj.find("button[name=formDownBtn]").bind("click", function() {
		//양식 다운로드
		doActionInput("formDown");
	});
	formObj.find("button[name=tableDownBtn]").bind("click", function() {
		//표 다운로드
		doActionInput("tableDown");
	});

	//승인처리 버튼들..
	formObj.find("a[name=a_reqAprov]").bind("click", function(e) {
		updateWrtstate("AW", "승인요청");
	});
	formObj.find("a[name=a_reqCancel]").bind("click", function(e) {
		updateWrtstate("RQ", "취소요청");
	});
	formObj.find("a[name=a_aprov]").bind("click", function(e) {
		updateWrtstate("AC", "승인");
	});
	formObj.find("a[name=a_return]").bind("click", function(e) {
		updateWrtstate("RC", "반려");
	});
	formObj.find("a[name=a_cancelAprov]").bind("click", function(e) {
		updateWrtstate("RA", "취소승인");
	});
	formObj.find("a[name=a_cancelReturn]").bind("click", function(e) {
		updateWrtstate("QR", "취소반려");
	});
	formObj.find("a[name=a_inputLimit]").bind("click", function(e) {
		updateWrtstate("WL", "입력제한");
	});
	formObj.find("a[name=a_inputWait]").bind("click", function(e) {
		updateWrtstate("WW", "입력대기");
	});
	//통계설명 팝업
	formObj.find("button[name=statMeta_pop]").bind("click", function(e) {
		doActionInput("statMetaExpPop");
	});
	//통계표 팝업
	formObj.find("button[name=statPreview_pop]").bind("click", function(e) {
		doActionInput("statPreviewPop");
	});
	//통계기호 작성 팝업
	formObj.find("button[name=statMark_pop]").bind("click", function(e) {
		doActionInput("statMarkPop");
	});
	//주석 작성 팝업
	formObj.find("button[name=statCmmt_pop]").bind("click", function(e) {
		doActionInput("statCmmtPop");
	});
	// 자료시점 주석 팝업
	formObj.find("button[name=statDif_pop]").bind("click", function(e) {
		doActionInput("statDifPop");
	});
	// 요청기록 팝업
	formObj.find("button[name=wrtLog_pop]").bind("click", function(e) {
		doActionInput("wrtLogPop");
	});
	
	// 입력탭에서 난수를 발생하여 시트데이터를 입력한다.(js가 import되어 있는경우만 실행)
	typeof randomInput === "function" && randomInput();		
}

function datePickerInit() {
	var objTab = getTabShowObj();//탭이 oepn된 객체가져옴
	var formObj = objTab.find("form[name=statMainForm]");
	
	formObj.find("input[name=wrtStartYmd],   input[name=wrtEndYmd]").datepicker(setCalendarFormat('yy-mm-dd'));
	
	datepickerTrigger(); 
	// 시작-종료 일자보다 이전으로 못가게 세팅
	formObj.find('input[name=wrtStartYmd]').datepicker('option', 'onClose',  function( selectedDate ) {$("input[name=wrtEndYmd]").datepicker( "option", "minDate", selectedDate );});
	formObj.find('input[name=wrtEndYmd]').datepicker('option', 'onClose',  function( selectedDate ) {	$("input[name=wrtStartYmd]").datepicker( "option", "maxDate", selectedDate );});
}

// IE includes 에러... 함수 추가
function includes(container, value) {
	var returnValue = false;
	var pos = container.indexOf(value);
	if (pos >= 0) {
		returnValue = true;
	}
	return returnValue;
}
////////////////////////////////////////////////////////////////////////////////
//Validation 함수
////////////////////////////////////////////////////////////////////////////////
