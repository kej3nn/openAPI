/*
 * @(#)openDsInput.js 1.0 2017/10/18
 * 
 * COPYRIGHT (C) 2013 WISEITECH CO., LTD. ALL RIGHTS RESERVED.
 */

/**
 * 관리자에서 공공데이터 입력관련 스크립트 파일이다
 *
 * @author 김정호
 * @version 1.0 2017/10/18
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
		$("input[name=cateId], input[name=cateNm]").val("");
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
	
	//입력주기 체크박스 제어
	$("input[name=loadCdAll]").bind("click", function(e) {
		var checked = $(this).is(":checked");
		$("input[name=loadCd]").each(function(idx) {
			$(this).prop("checked", checked);
		});
	});
	$("input[name=loadCd]").bind("click", function(e) {
		if ( !$(this).is(":checked") ) {
			$("input[name=loadCdAll]").prop("checked", false);
		}
	});
	//입력상태 체크박스 제어
	$("input[name=ldstateCdAll]").bind("click", function(e) {
		var checked = $(this).is(":checked");
		$("input[name=ldstateCd]").each(function(idx) {
			$(this).prop("checked", checked);
		});
	});
	$("input[name=ldstateCd]").bind("click", function(e) {
		if ( !$(this).is(":checked") ) {
			$("input[name=ldstateCdAll]").prop("checked", false);
		}
	});
	//입력마감일 초기화
	$("button[name=loadDttm_reset]").bind("click", function(e) {
		$("input[name=startLoadDttm], input[name=endLoadDttm]").val("");
	});
	//승인일 초기화
	$("button[name=accDttm_reset]").bind("click", function(e) {
		$("input[name=startAccDttm], input[name=endAccDttm]").val("");
	});
}

/**
 * 옵션을 로드한다.
 */
function loadOptions() {
	//메인폼-입력주기
	$("form[name=openMainForm]").find("input[name=startLoadDttm], input[name=endLoadDttm]").datepicker(setCalendar());
	$("form[name=openMainForm]").find('input[name=startLoadDttm]').datepicker('option', 'onClose',  function( selectedDate ) {$("input[name=endLoadDttm]").datepicker( "option", "minDate", selectedDate );});
	$("form[name=openMainForm]").find('input[name=endLoadDttm]').datepicker('option', 'onClose',  function( selectedDate ) {	$("input[name=startLoadDttm]").datepicker( "option", "maxDate", selectedDate );});
	//메인폼-입력마감일
	$("form[name=openMainForm]").find("input[name=startAccDttm], input[name=endAccDttm]").datepicker(setCalendar());
	$("form[name=openMainForm]").find('input[name=startAccDttm]').datepicker('option', 'onClose',  function( selectedDate ) {$("input[name=endAccDttm]").datepicker( "option", "minDate", selectedDate );});
	$("form[name=openMainForm]").find('input[name=endAccDttm]').datepicker('option', 'onClose',  function( selectedDate ) {	$("input[name=startAccDttm]").datepicker( "option", "maxDate", selectedDate );});
	
	$("form[name=openMainForm]").find("input[name=loadCdAll]").prop("checked", true);	//입력주기 기본체크
	$("form[name=openMainForm]").find("input[name=loadCd]").prop("checked", true);
	$("form[name=openMainForm]").find("input[name=ldstateCd]").prop("checked", true);	//입력상태 기본체크
	$("form[name=openMainForm]").find("input[name=ldstateCdAll]").prop("checked", true);
}

/**
 * 데이터를 로드한다.
 */
function loadData() {
	doActionMain("search");
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
	var sheetObj = window[tabSheetNm];
	return sheetObj;
}

/**
 * 메인화면 액션
 */
function doActionMain(sAction) {
	var classObj = $("."+tabContentClass); //tab으로 인하여 form이 다건임
	var actObj = setTabForm(classObj); // 0: form data, 1: form 객체
	var formObj = $("form[name=openMainForm]");
	switch(sAction) {                       
		case "search":
			ajaxBeforeSendAdmin(com.wise.help.url("/admin/ajaxBeforeSendAdmin.do")); //IbSheet 조회전 세션 체크
			var param = {PageParam: "ibpage", Param: "onepagerow=50&"+actObj[0]};
			mainSheet.DoSearchPaging(com.wise.help.url("/admin/openinf/opends/openDsInputList.do"), param);
			break;
		case "orgPop" :		//담당부서 팝업
			window.open(com.wise.help.url("/admin/basicinf/popup/commOrg_pop.do") + "?orgNmGb=2&sheetNm=statMainForm", "list" ,"fullscreen=no, width=500, height=550");
			break;
	}
}

/**
 * 입력 시트 관련 액션
 */
function doActionInput(sAction) {
	var classObj = $("."+tabContentClass); //tab으로 인하여 form이 다건임
	var actObj = setTabForm2(classObj, "openInput-dtl-form"); // 0: form data, 1: form 객체
	var formObj = getTabFormObj("openInput-dtl-form");
	var inputSheetObj = getTabSheetObj("openInput-dtl-form", "inputSheetNm");
	
	switch(sAction) {
		case "search" :	//조회
			ajaxBeforeSendAdmin(com.wise.help.url("/admin/ajaxBeforeSendAdmin.do")); //IbSheet 조회전 세션 체크
			var param = {PageParam: "ibpage", Param: "onepagerow=50&"+actObj[0]};
			inputSheetObj.DoSearchPaging(com.wise.help.url("/admin/openinf/opends/openDsInputData.do"), param);
			break;
		case "verifyExcelSave" :
			verifyExcelSave();	//엑셀 검증 및 저장
			break;
		case "formDown" :		//양식 다운로드
			inputSheetFormDown();
			break;
		case "excelDown" : 		//표(엑셀) 다운로드
			var params = {
				SheetDesign : 1,
			    Merge : 1,
			    Mode : -1,	//	Status, DelCheck, Result 타입 및 Hidden 컬럼을 제외하고 다운로드
			    NumberFormatMode : 0,
			    FileName : formObj.find("input[name=dsNm]").val() + ".xls",
			    SheetName : formObj.find("input[name=dsNm]").val()
			};
			inputSheetObj.Down2Excel(params);
			break;
		case "tableDown" :		//표 다운로드
			inputSheetTableDown();
			break;	
		case "verifySave" :		//검증 및 저장
			verifySave();
			break;	
	}
}

/**
 * 엑셀 검증 및 저장
 */
function verifyExcelSave() {
	var formObj = getTabFormObj("openInput-dtl-form");
	
	if ( formObj.find("input[name=uploadExcelFile]").val() == "" ) {
		alert("파일을 선택하세요.");
		return false;
	}
	
	if ( !confirm("선택하신 파일로 업로드 및 검증 하시겠습니까?") )	return false;
	
	formObj.attr("action", com.wise.help.url("/admin/openinf/opends/saveOpenInputExcelData.do"));
	formObj.attr("target", "hidden-iframe");
	
	formObj.ajaxForm({
    	async: false
    	, dataType: "json"
    	, beforeSend: function() {
    		formObj.find("#loadingCircle").show();
    	}
    	, success: function(data) {
    		if ( data.success ) {
    			if ( data.success.message ) {
    				alert(data.success.message);
    				doActionInput("search");	//시트 재 조회
    				//완료 후 대기 상태로 버튼 다시 세팅
    				setLdstateBtn("WW", Number(formObj.find("input[name=prssAccCd]").val()), formObj.find("input[name=autoAccYn]").val());
    			}
	    	} else {
	    		if ( data.error.message ) {
	    			alert(data.error.message);
	    		}
	    	}
    		formObj.find("#loadingCircle").hide();
    	}
    	, error: function(msg, a, b) {
    		alert("처리도중 에러가 발생하였습니다");
    	}
    });
	formObj.submit();
}

/**
 * 시트 데이터 검증 및 저장
 */
function verifySave() {
	var formObj = getTabFormObj("openInput-dtl-form");
	var inputSheetObj = getTabSheetObj("openInput-dtl-form", "inputSheetNm");
	var inputSheetNm = formObj.find("input[name=inputSheetNm]").val();
	/*
	var params = "&ibsSaveJson=" + encodeURIComponent(JSON.stringify(inputSheetObj.GetSaveJson({AllSave:true, ValidKeyField: 0})));	//시트 데이터
	var datas = openTab.ContentObj.find("form[name=openInput-dtl-form]").serialize() + params;					//시트 데이터 + 폼 데이터
	inputSheetObj.DoAllSave(com.wise.help.url("/admin/openinf/opends/saveOpenInputData.do"), {
		"Param" : datas,
		"ValidKeyField" : 1
	});
	*/
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
		if ( !confirm("검증 및 저장 하시겠습니까?") ) {
			return false;
		}
    	var params = "&ibsSaveJson=" + encodeURIComponent(JSON.stringify(inputSheetJson));
		var datas = openTab.ContentObj.find("form[name=openInput-dtl-form]").serialize() + params;
    	
    	$.ajax({
    	    url: com.wise.help.url("/admin/openinf/opends/saveOpenInputData.do"),
    	    async: false, 
    	    type: 'POST', 
    	    data: datas,
    	    dataType: 'json',
    	    beforeSend: function(obj) {
    	    }, 
    	    success: function(data, status, request) {
    	    	if (data.success) {
    	            if (data.success.message) {
    	                alert(data.success.message);
    	                doActionInput("search");
    	                // 완료 후 저장 상태로 버튼 다시 세팅
        				setLdstateBtn("PG", Number(formObj.find("input[name=prssAccCd]").val()), formObj.find("input[name=autoAccYn]").val());
    	            }
    	        } else if (data.error) {
    	        	if (data.error.message) {
    	        		alert(data.error.message);
    	        	}
    	        }
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
	var formObj = getTabFormObj("openInput-dtl-form");
	var inputSheetObj = getTabSheetObj("openInput-dtl-form", "inputSheetNm");
	 $(formObj).ajaxSubmit({
	        beforeSubmit:function(data, form, options) {
	        	showLoadingMask();
	            return true;
	        },
	        url:com.wise.help.url("/admin/openinf/opends/down2OpenDsInputForm.do"),
	        dataType:"json",
	        success:function(data, status, request, form) {
	            handleResponse(data, status, options);
	            
	            hideLoadingMask();
	            
	            if (data.success) {
	            	doActionInput("search");
	            }
	        },
	        error:function(request, status, error) {
	            handleError(status, error);
	            
	            hideLoadingMask();
	        }
	    });
}


/**
 * 입력상태코드 변경 처리
 * @param ldstateCd	변경 할 입력상태코드
 * @param ldstateNm	변경 할 입력상태코드명
 * @returns {Boolean}
 */
function updateLdstate(ldstateCd, ldstateNm) {
	var formObj = getTabFormObj("openInput-dtl-form");
	var inputSheetObj = getTabSheetObj("openInput-dtl-form", "inputSheetNm");
	/*
	var verifyErrCnt = formObj.find("[name=verifyErrCnt]").text();
	//검증오류 체크
	if ( Number(verifyErrCnt) > 0 ) {
		alert(verifyErrCnt + "건의 오류가 발견되었습니다.\n["+ ldstateNm +"]할 수 없습니다.");
		//return false;
	}
	*/
	var sheet = inputSheetObj.GetSaveJson();
	if ( sheet.data.length > 0 ) {
		alert("수정된 데이터가 있어 "+ ldstateNm +" 할 수 없습니다.\n수정한 데이터를 저장하거나 원래 데이터로 변경해 주세요");
		return false;
	}
	
	if ( !confirm(ldstateNm +" 하시겠습니까?") )	return false;
	
	var params = {};
	$.each(formObj.serializeArray(), function(index, element) {
        switch (element.name) {
	        case "dsId":
            case "ldlistSeq":
            case "loadType":
            case "dataDttmCont":
            case "delayCont":	
            case "prssMsgCont":
            case "autoAccYn" :	
            	params[element.name] = element.value;
            	break;
        }
    });
	params["ldstateCd"] = ldstateCd;
	params["ldstateNm"] = ldstateNm;
	
	$.ajax({
	    url: com.wise.help.url("/admin/openinf/opends/updateOpenLdlistCd.do"),
	    type: 'POST', 
	    data: params,
	    dataType: 'json',
	    success: function(data) {
	    	//console.log(data);
	    	if ( data.success ) {
	    		alert(data.success.message);
	    		if ( ldstateCd == "AC" || ( ldstateCd == "AW" && params.autoAccYn == "Y" ) ) {	//승인상태 이거나 승인요청이면서 데이터 자동승인일 경우
	    			//승인되었으면 페이지 새로고침
	    			location.href= com.wise.help.url("/admin/openinf/opends/openDsInputPage.do") + (com.wise.util.isBlank(location.search) ? "" : location.search);
	    		} else {
	    			//doActionMain("search");
	    			setLdstateBtn(ldstateCd, Number(formObj.find("input[name=prssAccCd]").val()), formObj.find("input[name=autoAccYn]").val());
	    		}
	    	} else if ( data.error ) {
	    		alert(data.error.message);
	    	}
	    	doActionInput("search");
	    }, // 요청 완료 시
	    error: function(request, status, error) {
	    	handleError(status, error); 
	    }
	});
}
////////////////////////////////////////////////////////////////////////////////
// 전처리 함수
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// 후처리 함수
////////////////////////////////////////////////////////////////////////////////

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
	var formObj = getTabFormObj("openInput-dtl-form");
	var prssAccCd = 0;	//처리권한코드
	
	if ( data.DATA2.length > 0 ) {
		//사용자 권한
		prssAccCd = data.DATA2[0].prssAccCd 
		tab.ContentObj.find("input[name=prssAccCd]").val(prssAccCd);
	}
	
	$.each(data.DATA, function(key, val) {
		if ( key == "loadDttm" ) {
			tab.ContentObj.find("input[name=loadDttm]").val("( 제출일 : " + (com.wise.util.isBlank(val) ? "--" : val) + " )");
		} else if ( key == "accDttm" ) {
			tab.ContentObj.find("input[name=accDttm]").val("( 승인일 : " + (com.wise.util.isBlank(val) ? "--" : val) + " )");
		} else if ( key == "autoAccYn") {	//자동승인여부
			tab.ContentObj.find("input[name=autoAccYn]").val(val);
			if ( val == "Y" ) {
				tab.ContentObj.find("input[name=autoAccYnDesc]").val("(자동승인)");
			} else {
				tab.ContentObj.find("input[name=autoAccYnDesc]").val("");
			}
		} else if ( key == "keyDbYn" ) {	//국가중점DB여부
			tab.ContentObj.find("input[name=keyDbYn]").val("국가표준");
		} else if ( key == "ldstateCd" ) {	//입력상태
			setLdstateBtn(val, prssAccCd, data.DATA.autoAccYn);
			if ( val == "AC" ) {	//승인상태시 입력마감일 숨김
				tab.ContentObj.find("input[name=loadDttmDesc]").hide();
			}
		}
	});
}

/**
 * 입력상태코드에 따른 버튼 show/hide 
 * @param state {String} 상태값
 * @param prssAccCd {Number} 처리권한코드
 * @param autoAccYn {String} 데이터 자동승인 여부
 */
function setLdstateBtn(state, prssAccCd, autoAccYn) {
	if ( com.wise.util.isNull(prssAccCd) ) return;
	
	var formObj = getTabFormObj("openInput-dtl-form");
	
	//버튼 숨기고 상태 값에 따라 필요한 버튼만 다시 보여준다
	formObj.find("a[name=a_verifySave], a[name=a_reqAprov], a[name=a_aprov], a[name=a_return], a[name=a_verifyExcelSave]").hide();
	switch(state) {
	case "WW" : 	//대기
		if ( prssAccCd > 10 ) {		//조회 권한 이상일 경우
			formObj.find("a[name=a_verifySave]").show();			//검증 및 저장
			formObj.find("a[name=a_verifyExcelSave]").show();	//업로드 및 검증
		}
		break;
	case "PG" :		//저장
	case "RC" : 	//반려
		if ( prssAccCd > 10 ) {
			//if ( autoAccYn == "N" ) {	//데이터 자동승인이 아닌경우 승인요청 버튼 보여준다
				formObj.find("a[name=a_reqAprov]").show();
			//}
			formObj.find("a[name=a_verifySave]").show();		//검증 및 저장
			formObj.find("a[name=a_verifyExcelSave]").show();	//업로드 및 검증
		}
		break;
	case "AW" :		//제출(승인요청상태)
		if ( prssAccCd > 30 && autoAccYn == "N" ) {			//승인 권한 이상이고 데이터 자동승인상태가 아닌경우
			formObj.find("a[name=a_aprov]").show();			//승인(승인권한)
			formObj.find("a[name=a_return]").show();			//반려(승인권한)
		}
		break;
	case "AC" :		//승인
		break;
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
	var title = mainSheet.GetCellValue(row,"dsNm");	//탭 제목
	var id = mainSheet.GetCellValue(row,"seq");		//탭 id(유일한key))
	openTab.SetTabData(mainSheet.GetRowJson(row));	//db data 조회시 조건 data
	var url =  com.wise.help.url('/admin/openinf/opends/openDsInputDtl.do'); // Controller 호출 url 
	openTab.addTab(id, title, url, tabCallBack); 	// 탭 추가 시작함
	inputSheetCreate(sheetInputTabCnt++);
}  

//입력 시트 생성
function inputSheetCreate(SheetCnt){       
 	var sheetNm = "inputSheet"+SheetCnt;  
 	$("div[name=inputSheet]").eq(1).attr("id","DIV_"+sheetNm);                                          
 	createIBSheet2(document.getElementById("DIV_"+sheetNm),sheetNm, "100%", "400px");               
 	var sheetobj = window[sheetNm]; 
 	var objTab = getTabShowObj();//탭이 oepn된 객체가져옴
 	var formObj = objTab.find("form[name=openInput-dtl-form]");
 	formObj.find("input[name=inputSheetNm]").val(sheetNm);
 	loadInputSheet(sheetNm, sheetobj);
 	window[sheetNm + "_OnSearchEnd"] = inputSheetSearchEnd;
 	window[sheetNm + "_OnSaveEnd"] = inputSheetSaveEnd;
}

////////////////////////////////////////////////////////////////////////////////
//시트 로드
////////////////////////////////////////////////////////////////////////////////
function loadMainPage() {
	
	createIBSheet2(document.getElementById("mainSheet"),"mainSheet", "100%", "300px");
	
	var gridTitle ="NO";
	gridTitle +="|입력스케쥴\n고유번호";
	gridTitle +="|데이터셋ID";
	gridTitle +="|데이터셋명";
	gridTitle +="|담당부서(담당자)";
	gridTitle +="|입력주기";
	gridTitle +="|입력마감일";
	gridTitle +="|제출일";
	//gridTitle +="|승인일";
	gridTitle +="|입력상태";
	
	with(mainSheet){
		                     
		var cfg = {SearchMode:2,Page:50,VScrollMode:1};
	    SetConfig(cfg);
	    var headers = [
	                {Text:gridTitle, Align:"Center"}
	            ];
	    var headerInfo = {Sort:0,ColMove:0,ColResize:1,HeaderCheck:0};
	    
	    InitHeaders(headers, headerInfo);
	   
	    var cols = [
	                 {Type:"Seq",		SaveName:"seq",			Width:30,	Align:"Center",		Edit:false}
	                ,{Type:"Int",		SaveName:"ldlistSeq",	Width:50,	Align:"Center",		Edit:false,	Hidden: true} 
					,{Type:"Text",		SaveName:"dsId",		Width:150,	Align:"Left",		Edit:false}
					,{Type:"Text",		SaveName:"dsNm",		Width:300,	Align:"Left",		Edit:false}
					,{Type:"Text",		SaveName:"orgUsrNm",	Width:90,	Align:"Center",		Edit:false}
					,{Type:"Text",		SaveName:"loadNm",		Width:90,	Align:"Center",		Edit:false}
					,{Type:"Text",		SaveName:"loadPlanYmd",	Width:100,	Align:"Center",		Edit:false}
					,{Type:"Text",		SaveName:"loadDttmDesc",Width:100,	Align:"Center",		Edit:false}
					,{Type:"Text",		SaveName:"ldstateNm",	Width:150,	Align:"Center",		Edit:false}
	            ];                                          
	    InitColumns(cols);
	    FitColWidth();
	    SetExtendLastCol(1);
	}               
	default_sheet(mainSheet);   
}

/**
 * 입력 시트 동적 생성
 * @param sheetNm	시트명
 * @param sheetObj	시트객체
 */
function loadInputSheet(sheetNm, sheetObj) {
	var objTab = getTabShowObj();//탭이 oepn된 객체가져옴
	var formObj = objTab.find("form[name=openInput-dtl-form]");
	$.ajax({
	    url: com.wise.help.url("/admin/openinf/opends/openDsInputCol.do"),
	    async: false, 
	    type: 'POST', 
	    data: formObj.serializeObject(),
	    dataType: 'json',
	    beforeSend: function(obj) {
	    }, // 서버 요청 전 호출 되는 함수 return false; 일 경우 요청 중단
	    success: function(res) {
	    	var data = res.data;
	    	var arrTitle = new Array(); 
	    	var cols = new Array();
	    	
	    	for ( var i=0; i < data.length; i++ ) {
	    		if ( i == 0 ) {
	    			//최초 1번만 입력(맨 앞 컬럼) => 일련번호, 상태(숨김)
	    			arrTitle.push("일련변호");
	    			cols.push({
		    			Type : "Text", SaveName	: "colSeq", Width : 70, Align : "Center", ColMerge : false, Edit : false
	    			});
	    			arrTitle.push("상태");
	    			cols.push({
		    			Type : "Status", SaveName	: "status", Width : 70, Align : "Center", Edit : false,	Hidden: true
	    			});
	    		}
	    		arrTitle.push(data[i].colNm);
	    		cols.push({
	    			Type 		: "Text",
					SaveName 	: "col_" + String(data[i].colSeq),
					Width 		: 120,
					Align 		: "Left",
					ColMerge	: false,
					KeyField	: (data[i].needYn == "Y" ? 1 : 0),
					Edit 		: true
	    		});
	    	}
	    	with(sheetObj){
	    		var cfg = {SearchMode:2,	Page:50,	VScrollMode:1,	MergeSheet:msAll};
	    	    SetConfig(cfg);
	    	    var headerInfo = {Sort:0,ColMove:1,ColResize:1,HeaderCheck:0};
	    	    
	    	    InitHeaders([{Text: arrTitle.join("|"), Align: "Center"}], headerInfo);
	    	                                      
	    	    InitColumns(cols);
	    	    //FitColWidth();
	    	    SetExtendLastCol(1);
	    	}               
	    	default_sheet(sheetObj);  
	    	
	    	doActionInput("search");
	    	
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
function mainSheet_OnDblClick(row, col, value, cellx, celly) {
	if(row < 1) return;                                         
	    tabEvent(row);
}

/**
 * 입력 시트 조회 후 처리
 */
function inputSheetSearchEnd(code, message, statusCode, statusMessage) {
	var objTab = getTabShowObj();//탭이 oepn된 객체가져옴
	var formObj = objTab.find("form[name=openInput-dtl-form]");
	var inputSheetNm = formObj.find("input[name=inputSheetNm]").val();
	var inputSheetObj = window[inputSheetNm];	//통계데이터 시트
	
	//검증결과 데이터 가져온다
	$.ajax({
	    url: com.wise.help.url("/admin/openinf/opends/openDsInputVerifyData.do"),
	    async: false,
	    type: 'POST', 
	    data: formObj.serialize(),
	    dataType: 'json',
	    beforeSend: function(obj) {
	    }, 
	    success: function(data) {
	    	if ( data.data.length > 0 ) {
	    		//오류 건수 표시
	    		formObj.find("span[name=verifyYnTxt]").show().children().text(data.data.length);
	    	} else {
	    		formObj.find("span[name=verifyYnTxt]").hide().children().text(data.data.length);
	    	}
	    	$.each(data.data, function(i, json) {
	    		var rowSeqceNo = String(json.rowSeqceNo);		//행 seq
	    		var colSeqceNo = inputSheetObj.SaveNameCol("col_" + json.colSeqceNo);	//컬럼 seq
	    		var row = inputSheetObj.FindText("colSeq", rowSeqceNo);
	    		//오류있는 데이터에 글자 빨간색 굵게 처리
	    		inputSheetObj.SetCellFontBold(row, colSeqceNo, true);
	    		//inputSheetObj.SetCellFontColor(row, colSeqceNo, 'red');
	    		inputSheetObj.SetCellBackColor(row, colSeqceNo, 'yellow');
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
	var formObj = objTab.find("form[name=openInput-dtl-form]");
	if(code >= 0) {
        alert("정상적으로 저장 되었습니다.");
        doActionInput("search");
        //저장상태로 버튼 show/hide
        setLdstateBtn("PG", Number(formObj.find("input[name=prssAccCd]").val()), formObj.find("input[name=autoAccYn]").val());
    } else {
    	alert("저장에 실패하였습니다");
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
	var formObj = objTab.find("form[name=openInput-dtl-form]");
	
	formObj.find("button[name=formDownBtn]").bind("click", function() {
		//양식 다운로드
		doActionInput("formDown");
	});
	formObj.find("button[name=excelDownBtn]").bind("click", function() {
		//양식 다운로드
		doActionInput("excelDown");
	});
	formObj.find("a[name=a_verifySave]").bind("click", function() {
		//검증 및 저장
		doActionInput("verifySave");
	});
	formObj.find("a[name=a_verifyExcelSave]").bind("click", function() {
		//업로드 및 저장
		doActionInput("verifyExcelSave");
	});
	formObj.find("a[name=a_reqAprov]").bind("click", function(e) {
		updateLdstate("AW", "승인요청");
	});
	formObj.find("a[name=a_aprov]").bind("click", function(e) {
		updateLdstate("AC", "승인");
	});
	formObj.find("a[name=a_return]").bind("click", function(e) {
		updateLdstate("RC", "반려");
	});
}


////////////////////////////////////////////////////////////////////////////////
//Validation 함수
////////////////////////////////////////////////////////////////////////////////
