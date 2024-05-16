/*
 * @(#)infSetMgmt.js 1.0 2019/07/29
 */

/**
 * 관리자에서 정보셋을 관리하는 스크립트
 *
 * @author JHKIM
 * @version 1.0 2019/07/29
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
var sheetExpTabCnt = 0;		// 설명 
var sheetCateTabCnt = 0;	// 분류
var sheetUsrTabCnt = 0;		// 유저
var sheetDocTabCnt = 0;		// 문서
var sheetOpenTabCnt = 0;	// 공공
var sheetStatTabCnt = 0;	// 통계

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
	openTab = new OpenTab(tabId,tabContentClass,tabBody); //headinclude.jsp 변수 있음
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
	var title = mainSheet.GetCellValue(row, "infsNm");	// 탭 제목
	var id = mainSheet.GetCellValue(row, "infsId");		// 탭 ID
	openTab.SetTabData(mainSheet.GetRowJson(row));
	var url = com.wise.help.url('/admin/infs/mgmt/infSetDtl.do'); 
	
	// 탭 추가 시작
	openTab.addTab(id, title, url, tabCallBack);
	
	// 탭 내 시트생성 시작
	expSheetCreate(sheetExpTabCnt++);			// 설명 시트생성
	cateSheetCreate(sheetCateTabCnt++);			// 분류 시트생성
	usrSheetCreate(sheetUsrTabCnt++);			// 유저 시트생성
	docSheetCreate(sheetDocTabCnt++);			// 문서 시트생성
	openSheetCreate(sheetOpenTabCnt++);			// 공공 시트생성
	statSheetCreate(sheetStatTabCnt++);			// 통계 시트생성
} 

/**
 * 정보셋 신규 탭 생성시
 */
function regUserFunction() {
	// 탭 내 시트생성 시작
	expSheetCreate(999);			// 설명 시트생성
	cateSheetCreate(999);			// 분류 시트생성
	usrSheetCreate(999);			// 유저 시트생성
	docSheetCreate(999);			// 문서 시트생성
	openSheetCreate(999);			// 공공 시트생성
	statSheetCreate(999);			// 통계 시트생성
	
	var formObj = getTabFormObj("mst-form");
	formObj.find("a[name=a_modify]").hide();	//저장버튼 숨김
	
	// 탭 버튼 이벤트 세팅
	setTabButtonEvent();
}

/**
 * 상세 탭 이벤트 후처리 
 */
function tabFunction(tab, data) {
	var formObj = getTabFormObj("mst-form");
	
	//추천 체크처리
	if ( data.DATA.fvtDataOrder > 0 ) {
		formObj.find("input[name=fvtDataYn]").prop("checked", true);
		formObj.find("select[name=fvtDataOrder]").show();
	}
	
	// 공개/공개취소 버튼 표시
	if ( data.DATA.openState == "Y" ) {
		formObj.find("a[name=a_openState]").hide();
	}
	else if ( data.DATA.openState == "N" ) {
		formObj.find("a[name=a_openStateCancel]").hide();
	}
	
	// 서비스 정보 표시(서비스가 등록되어있는경우)
	formObj.find(".serviceYn span").each(function(i, e) {
		var gubun = $(this).attr("data-srv-gubun");
		if ( gubun === "D" )	data.DATA.docCnt  > 0 ? $(this).removeClass("icon-no-service").addClass("icon-service") : "";
		if ( gubun === "O" )	data.DATA.infCnt > 0 ? $(this).removeClass("icon-no-service").addClass("icon-service") : "";
		if ( gubun === "S" )	data.DATA.statblCnt > 0 ? $(this).removeClass("icon-no-service").addClass("icon-service") : "";
	});
	
	// 탭 이벤트 처리
	setTabButtonEvent();
}

////////////////////////////////////////////////////////////////////////////////
// 탭 시트들 생성
////////////////////////////////////////////////////////////////////////////////
function expSheetCreate(sheetCnt) {
	var sheetNm = "expSheet"+sheetCnt;
	$("div[name=expSheet]").eq(1).attr("id", "DIV_"+sheetNm);                                          
 	createIBSheet2(document.getElementById("DIV_"+sheetNm), sheetNm, "100%", "200px");               
 	var sheetObj = window[sheetNm]; 
 	var formObj = getTabFormObj("mst-form");
 	formObj.find("#expSheetNm").val(sheetNm);
 	loadExpSheet(sheetNm, sheetObj);	// 시트 로드
 	window[sheetNm+ "_OnDblClick"] = expSheetOnDblClick		// 시트 더블클릭
}

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

function docSheetCreate(sheetCnt) {
	var sheetNm = "docSheet"+sheetCnt;
	$("div[name=docSheet]").eq(1).attr("id", "DIV_"+sheetNm);                                          
 	createIBSheet2(document.getElementById("DIV_"+sheetNm), sheetNm, "100%", "350px");               
 	var sheetObj = window[sheetNm]; 
 	var formObj = getTabFormObj("mst-form");
 	formObj.find("#docSheetNm").val(sheetNm);
 	loadDocSheet(sheetNm, sheetObj);
}

function openSheetCreate(sheetCnt) {
	var sheetNm = "openSheet"+sheetCnt;
	$("div[name=openSheet]").eq(1).attr("id", "DIV_"+sheetNm);                                          
 	createIBSheet2(document.getElementById("DIV_"+sheetNm), sheetNm, "100%", "350px");               
 	var sheetObj = window[sheetNm]; 
 	var formObj = getTabFormObj("mst-form");
 	formObj.find("#openSheetNm").val(sheetNm);
 	loadOpenSheet(sheetNm, sheetObj);
}

function statSheetCreate(sheetCnt) {
	var sheetNm = "statSheet"+sheetCnt;
	$("div[name=statSheet]").eq(1).attr("id", "DIV_"+sheetNm);                                          
 	createIBSheet2(document.getElementById("DIV_"+sheetNm), sheetNm, "100%", "350px");               
 	var sheetObj = window[sheetNm]; 
 	var formObj = getTabFormObj("mst-form");
 	formObj.find("#statSheetNm").val(sheetNm);
 	loadStatSheet(sheetNm, sheetObj);
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
			mainSheet.DoSearchPaging(com.wise.help.url("/admin/infs/mgmt/infSetMainListPaging.do"), param);
			break;
		case "regForm" :
			openTab.addRegTab("infSetReg", "신규등록", tabCallRegBack);
			break;
		case "catePop" :	// 분류정보 추가 팝업(선택 시 부모 시트로 데이터 이동)
			var url = com.wise.help.url("/admin/infs/mgmt/popup/infSetCateSearchPop.do");
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
				
				saveSheet("/admin/infs/mgmt/insertInfSet.do", datas, {
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
				
				saveSheet("/admin/infs/mgmt/updateInfSet.do", datas, {
						callback: function(data) {
							afterTabRemove(data);
						}
					});
				}
			break;
		case "delete" :
			if ( !confirm("삭제 하시겠습니까?") )	return false;
			doAjax({
				url : "/admin/infs/mgmt/deleteInfSet.do",
				params : "infsId=" + formObj.find("input[name=infsId]").val(),
				callback : afterTabRemove
			});
			break;
		case "open":		// 공개
			if (com.wise.util.isBlank(formObj.find("input[name=openDttm]").val())) {
		        alert("공개일을 선택하세요");
		        return false;
			}
			doAjax({
				url: "/admin/infs/mgmt/updateInfSetOpenState.do",
				params: "infsId="+formObj.find("#infsId").val(),
				callback: function() {
					formObj.find("a[name=a_openState]").hide();
					formObj.find("a[name=a_openStateCancel]").show();
				}
			});
			break;
		case "openCancel":	// 공개취소
			doAjax({
				url: "/admin/infs/mgmt/updateInfSetOpenStateCancel.do",
				params: "infsId="+formObj.find("#infsId").val(),
				callback: function() {
					formObj.find("a[name=a_openState]").show();
					formObj.find("a[name=a_openStateCancel]").hide();
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
	
	if ( com.wise.util.isBlank(formObj.find("#infsNm").val()) ) {
		alert("정보명을 입력하세요.");
		return false;
	}
	if ( formObj.find("input[name=fvtDataYn]").is(":checked") ) {
		if ( formObj.find("select[name=fvtDataOrder]").val() == "0" ) {
			alert("통계표를 추천하는 경우 순위를 입력하세요");
			formObj.find("select[name=fvtDataOrder]").focus();
			return false;
		}
	}
	if ( !com.wise.util.isLength(formObj.find("input[name=schwTagCont]"), 1, 1000)) {
    	alert("키워드는 1000자리 이내로 입력하세요.");
    	formObj.find("input[name=schwTagCont]").val("").focus();
        return false;
    }
	if ( !com.wise.util.isBlank(formObj.find("input[name=schwTagCont]").val()) && !com.wise.util.isKoreanAlphaNumeric(formObj.find("input[name=schwTagCont]").val(), ",") ) {
		alert("키워드는 한글, 영문, 숫자만 입력하세요.");
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

