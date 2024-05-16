/*
 * @(#)docInfMgmt.js 1.0 2019/08/05
 */

/**
 * 관리자에서 정보공개 문서를 관리하는 스크립트
 *
 * @author JHKIM
 * @version 1.0 2019/08/05
 */
$(function() {
    // 컴포넌트를 초기화한다.
    initComp();
    
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
/* 시트 갯수 */
var sheetCateTabCnt = 0;	// 분류
var sheetUsrTabCnt = 0;		// 유저
var sheetFileTabCnt = 0;	// 첨부파일

/* 스마트데이터 객체 */
var oEditors = [];

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
 * 데이터를 로드한다.
 */
function loadData() {
	doActionMain("search");
}

/**
 * 메인페이지 로드
 * @returns
 */
function loadMainPage() {
	loadMainSheet();
}



////////////////////////////////////////////////////////////////////////////////
// 탭 관련 함수들
////////////////////////////////////////////////////////////////////////////////
function tabSet(){   
	openTab = new OpenTab(tabId,tabContentClass,tabBody);
	openTab.TabObj = openTab;  
	openTab.addTabClickEvent();            
}

/**
 * 탭 버튼 이벤트 처리
 */
function buttonEventAdd() {
	setTabButtonEvent();
}

/**
 * 메인에서 탭 더블클릭시 수행되는 이벤트
 */
function tabEvent(row){//탭 이벤트 실행  
	var title = mainSheet.GetCellValue(row, "docNm");	// 탭 제목
	var id = mainSheet.GetCellValue(row, "docId");		// 탭 ID
	openTab.SetTabData(mainSheet.GetRowJson(row));
	var url = com.wise.help.url('/admin/infs/doc/docInfDtl.do'); 
	
	// 탭 추가 시작
	openTab.addTab(id, title, url, tabCallBack);
	
	// 탭 내 시트생성 시작
	cateSheetCreate(sheetCateTabCnt++);			// 분류 시트생성
	usrSheetCreate(sheetUsrTabCnt++);			// 유저 시트생성
	fileSheetCreate(sheetFileTabCnt++);			// 첨부파일 시트생성
} 

/**
 * 정보셋 신규 탭 생성시 */
function regUserFunction() {
	// 탭 내 시트생성 시작
	cateSheetCreate(999);			// 분류 시트생성
	usrSheetCreate(999);			// 유저 시트생성
	fileSheetCreate(999);			// 첨부파일 시트생성
	
	var formObj = getTabFormObj("mst-form");
	formObj.find("a[name=a_save]").hide();	//저장버튼 숨김
	
	// 탭 버튼 이벤트 세팅
	setTabButtonEvent();
	
	formObj.find("#openCd").change();	// 공개구분에 따라 미공개사유 변경
}

/**
 * 상세 탭 이벤트 후처리 
 */
function tabFunction(tab, data) {
	var formObj = getTabFormObj("mst-form");
	
	//추천 체크처리
	if ( !com.wise.util.isNull(data.DATA.fvtDataOrder) ) {
		if ( data.DATA.fvtDataOrder > 0 ) {
			formObj.find("input[name=fvtDataYn]").prop("checked", true);
			formObj.find("select[name=fvtDataOrder]").show();
		}
	}
	
	// 공개/공개취소 버튼 표시
	if ( data.DATA.openState == "Y" ) {
		formObj.find("a[name=a_openState]").hide();
	}
	else if ( data.DATA.openState == "N" ) {
		formObj.find("a[name=a_openStateCancel]").hide();
	}
	
	// 전체공개일경우 미공개사유는 공개만 선택가능
	if ( data.DATA.openCd == "DT002" )  {
		formObj.find("#causeCd option:not([value=99])").attr("disabled", "disabled");
	}
	else {
		formObj.find("#causeCd option[value=99]").attr("disabled", "disabled");
	}
	
	// 파일 저장, 삭제버튼 숨김
	formObj.find("a[name=a_save]:eq(1), a[name=a_del]:eq(1), a[name=a_file_reg]").hide();	
	
	// 탭 이벤트 처리
	setTabButtonEvent();
}

////////////////////////////////////////////////////////////////////////////////
// 탭 시트들 생성
////////////////////////////////////////////////////////////////////////////////

function cateSheetCreate(sheetCnt) {
	var sheetNm = "cateSheet"+sheetCnt;
	$("div[name=cateSheet]").eq(1).attr("id", "DIV_"+sheetNm);                                          
 	createIBSheet2(document.getElementById("DIV_"+sheetNm), sheetNm, "100%", "200px");               
 	var sheetObj = window[sheetNm]; 
 	var formObj = getTabFormObj("mst-form");
 	formObj.find("#cateSheetNm").val(sheetNm);
 	loadCateSheet(sheetNm, sheetObj);
}

function usrSheetCreate(sheetCnt) {
	var sheetNm = "usrSheet"+sheetCnt;
	$("div[name=usrSheet]").eq(1).attr("id", "DIV_"+sheetNm);                                          
 	createIBSheet2(document.getElementById("DIV_"+sheetNm), sheetNm, "100%", "200px");               
 	var sheetObj = window[sheetNm]; 
 	var formObj = getTabFormObj("mst-form");
 	formObj.find("#usrSheetNm").val(sheetNm);
 	loadUsrSheet(sheetNm, sheetObj);
 	window[sheetNm+ "_OnPopupClick"] = usrSheetOnPopupClick		// 시트 팝업클릭
}

function fileSheetCreate(sheetCnt) {
	var sheetNm = "fileSheet"+sheetCnt;
	$("div[name=fileSheet]").eq(1).attr("id", "DIV_"+sheetNm);                                          
 	createIBSheet2(document.getElementById("DIV_"+sheetNm), sheetNm, "100%", "200px");               
 	var sheetObj = window[sheetNm]; 
 	var formObj = getTabFormObj("mst-form");
 	formObj.find("#fileSheetNm").val(sheetNm);
 	loadFileSheet(sheetNm, sheetObj);
 	window[sheetNm+ "_OnDblClick"] = fileSheetOnDblClick		// 시트 더블클릭
}

////////////////////////////////////////////////////////////////////////////////
// 화면 액션 함수들
////////////////////////////////////////////////////////////////////////////////
/**
 * 메인화면 관련 액션함수
 * @param sAction	액션명
 * @returns
 */
function doActionMain(sAction) {
	var formObj = $("form[name=mainForm]");
	switch(sAction) {                       
		case "search":
			var param = {PageParam: "page", Param: "rows=50"+"&"+formObj.serialize()};
			mainSheet.DoSearchPaging(com.wise.help.url("/admin/infs/doc/docInfMainListPaging.do"), param);
			break;
		case "regForm" :
			openTab.addRegTab("docInfReg", "신규등록", tabCallRegBack);
			break;
		case "catePop" :	// 분류정보 추가 팝업(선택 시 부모 시트로 데이터 이동)
			var url = com.wise.help.url("/admin/infs/mgmt/popup/docInfCateSearchPop.do");
			var data = "?parentFormNm=mainForm";// + "&cateId=" + formObj.find("input[name=cateIds]").val();
			openIframeStatPop("iframePopUp", url+data, 660, 530);
			break;
		case "orgPop" :		//담당부서 팝업
			window.open(com.wise.help.url("/admin/basicinf/popup/commOrg_pop.do") + "?orgNmGb=2&sheetNm=mainForm", "list" ,"fullscreen=no, width=500, height=550");
			break;
		case "excel":
			mainSheet.Down2Excel({FileName:'Excel.xls',SheetName:'sheet'});
			break;
	}
}

/**
 * 메인화면 관련 액션함수
 * @param sAction	액션명
 * @returns
 */
function doActionMst(sAction) {
	var formObj = getTabFormObj("mst-form");
	var cateSheetObj = getTabSheetObj("mst-form", "cateSheetNm");	// 분류정보 시트
	var usrSheetObj = getTabSheetObj("mst-form", "usrSheetNm");		// 유저정보 시트
	switch(sAction) {
		case "insert":
			if ( mstSaveValidation() ) {
				if ( !confirm("등록 하시겠습니까?") )	return false;
				
				var datas = formObj.serialize() + "&ibsSaveJson=" + encodeURIComponent(JSON.stringify(usrSheetObj.GetSaveJson({AllSave:true})))
				+ "&ibsSaveJson2=" + encodeURIComponent(JSON.stringify(cateSheetObj.GetSaveJson({AllSave:true})));
				
				saveSheet("/admin/infs/doc/insertDocInf.do", datas, {
						callback: function(data) {
							afterTabRemove(data);
						}
					});
				}
			break;
		case "update" :
			if ( mstSaveValidation() ) {
				if ( !confirm("수정 하시겠습니까?") )	return false;
				
				var datas = formObj.serialize() + "&ibsSaveJson=" + encodeURIComponent(JSON.stringify(usrSheetObj.GetSaveJson({AllSave:true})))
				+ "&ibsSaveJson2=" + encodeURIComponent(JSON.stringify(cateSheetObj.GetSaveJson({AllSave:true})));
				
				saveSheet("/admin/infs/doc/updateDocInf.do", datas, {
						callback: function(data) {
							afterTabRemove(data);
						}
					});
				}
			break;
		case "delete" :
			if ( !confirm("삭제 하시겠습니까?") )	return false;
			doAjax({
				url : "/admin/infs/doc/deleteDocInf.do",
				params : "docId=" + formObj.find("input[name=docId]").val(),
				callback : afterTabRemove
			});
			break;
		case "open":		// 공개
			if (com.wise.util.isBlank(formObj.find("input[name=openDttm]").val())) {
		        alert("공개일을 선택하세요");
		        return false;
			}
			doAjax({
				url: "/admin/infs/doc/updateDocInfOpenState.do",
				params: "docId="+formObj.find("#docId").val() + "&openDttm=" + formObj.find("input[name=openDttm]").val(),
				callback: function() {
					formObj.find("a[name=a_openState]").hide();
					formObj.find("a[name=a_openStateCancel]").show();
				}
			});
			break;
		case "openCancel":	// 공개취소
			doAjax({
				url: "/admin/infs/doc/updateDocInfOpenStateCancel.do",
				params: "docId="+formObj.find("#docId").val(),
				callback: function() {
					formObj.find("a[name=a_openState]").show();
					formObj.find("a[name=a_openStateCancel]").hide();
					formObj.find("button[id=openDttmInit]").click();
				}
			});
			break;
	}
}


////////////////////////////////////////////////////////////////////////////////
//서비스 함수
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
	var tabSheetNm = formObj.find("input[id="+sheetNm+"]").val();
	var sheetObj = window[tabSheetNm];
	return sheetObj;
}

/**
 * 시트 데이터 저장
 * @param url		URL
 * @param param		파라미터
 * @param options	옵션
 * @returns
 */
function saveSheet(url, param, options) {
	if ( com.wise.util.isBlank(url) )	return;
	
	options = options || {};
	
	$.ajax({
	    url: com.wise.help.url(url, param),
	    async: false, 
	    type: 'POST', 
	    data: param,
	    dataType: 'json',
	    beforeSend: function(obj) {
	    },
	    success: function(data) {
	    	doAjaxMsg(data, "");
	    	if ( typeof options.callback === 'function' ) {
	    		options.callback(data);
	    	}
	    },
	    error: function(request, status, error) {
	    	handleError(status, error);
	    },
	    complete: function(jqXHR) {}
	});
}

////////////////////////////////////////////////////////////////////////////////
//Validation 함수
////////////////////////////////////////////////////////////////////////////////
function mstSaveValidation() {
	var formObj = getTabFormObj("mst-form");
	var cateSheetObj = getTabSheetObj("mst-form", "cateSheetNm");	// 분류정보 시트
	var usrSheetObj = getTabSheetObj("mst-form", "usrSheetNm");		// 유저정보 시트
	var rpstYns = "";	// 분류정보 대표여부 체크
	
	if ( com.wise.util.isBlank(formObj.find("#docNm").val()) ) {
		alert("문서명을 입력하세요.");
		return false;
	}
	if ( formObj.find("input[name=fvtDataYn]").is(":checked") ) {
		if ( formObj.find("select[name=fvtDataOrder]").val() == "0" ) {
			alert("통계표를 추천하는 경우 순위를 입력하세요");
			formObj.find("select[name=fvtDataOrder]").focus();
			return false;
		}
	}
	
	if ( com.wise.util.isBlank(formObj.find("input[name=dtId]").val()) ) {
		alert("보유데이터를 선택하세요.");
		return false;
	}
	
	if ( com.wise.util.isBlank(formObj.find("select[name=openCd]").val()) ) {
		alert("공개구분을 선택하세요.");
		return false;
	}
	
	if ( (formObj.find("select[name=openCd]").val() == 'DT002' && formObj.find("select[name=causeCd]").val() != "99")
		|| (formObj.find("select[name=openCd]").val() != 'DT002' && formObj.find("select[name=causeCd]").val() == "99") ) {	
		alert("공개구분이 전체공개일경우 미공개사유는 공개로 설정해야 합니다.");
		return false;
	}
	
	// 전체공개일경우 미공개사유 공개로 변경
	formObj.find("#openCd").bind("change", function(event) {
		if ( $(this).value == "DT002" ) {
			formObj.find("#causeCd").val("99");
		}
	});
	
	if ( com.wise.util.isBlank(formObj.find("select[name=loadCd]").val()) ) {
		alert("적재주기를 선택하세요.");
		return false;
	}
	if ( com.wise.util.isBlank(formObj.find("select[name=cclCd]").val()) ) {
		alert("이용허락조건을 선택하세요.");
		return false;
	}
	if ( !com.wise.util.isLength(formObj.find("input[name=schwTagCont]"), 1, 1000)) {
    	alert("키워드는 1000자리 이내로 입력하세요.");
    	formObj.find("input[name=schwTagCont]").val("").focus();
        return false;
    }
	if ( com.wise.util.isBlank(formObj.find("input[name=schwTagCont]").val()) && !com.wise.util.isKoreanAlphaNumeric(formObj.find("input[name=schwTagCont]").val(), ",") ) {
		alert("키워드는 한글, 영문, 숫자만 입력하세요.");
		return false;
	}
	if ( com.wise.util.isEmpty(formObj.find("input[name=useYn]").val()) ) {
		alert("사용여부를 선택하세요.");
		return false;
	}
	// 분류정보 입력확인
	if ( cateSheetObj.RowCount() == 0 ) {
		alert("분류정보를 입력하세요.");
		return false;
	}
	// 인원정보 입력확인
	if ( usrSheetObj.RowCount() == 0 ) {
		alert("인원정보를 입력하세요.");
		return false;
	}
	// 분류/인원정보 시트 validation
	if ( !mstSheetValidation(cateSheetObj) )	return false;
	if ( !mstSheetValidation(usrSheetObj) )		return false;
	
	return true;
}

// 분류/인원 정보 등록 전 validation
function mstSheetValidation(sheetObj) {
	sheetObj.ExtendValidFail = 0;
	var sheetJson = sheetObj.GetSaveJson({AllSave:true, ValidKeyField: 1});
	var rpstYns = "";	// 분류정보 대표여부 체크
	
	if (sheetJson.Code) {
        switch (sheetJson.Code) {
            case "IBS000":
                alert("저장할 내역이 없습니다.");
                break;
            case "IBS010":
            case "IBS020":
                // Nothing to do.
                break;
        }
        return false;
    } 
	
	// 대표여부 체크여부
	for ( var i=1; i <= sheetObj.RowCount(); i++ ) {
		if ( sheetObj.GetCellValue(i, "status") !== "D" ) {	// 삭제하는 행은 제외
			rpstYns = rpstYns + sheetObj.GetCellValue(i, "rpstYn");
		}
	}
	if ( rpstYns.indexOf('Y') == -1 ) {
		alert("대표자(대표여부)를 선택하세요.");
		return false;
	}
	
	return true;
}

function fileSaveValidation(sAction) {
	var formObj = getTabFormObj("mst-form");
	var fileSheetObj = getTabSheetObj("mst-form", "fileSheetNm");	// 파일 시트
	
	if ( sAction == "reg" && com.wise.util.isBlank(formObj.find("input[name=docFile]").val()) ) {
		alert("문서파일을 선택하세요.");
		return false;
	}
	if ( com.wise.util.isBlank(formObj.find("input[name=viewFileNm]").val()) ) {
		alert("출력파일명을 입력하세요.");
		return false;
	}
	if ( com.wise.util.isBlank(formObj.find("input[name=prdcYmd]").val()) ) {
		alert("생산일을 선택하세요.");
		return false;
	}
	if ( com.wise.util.isBlank(formObj.find("select[name=docKpDdayCd]").val()) ) {
		alert("문서보존기한을 선택하세요.");
		return false;
	}
	
	return true;
}