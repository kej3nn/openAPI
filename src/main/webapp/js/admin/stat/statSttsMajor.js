/*
 * @(#)statStddMeta.js 1.0 2017/08/10
 * 
 * COPYRIGHT (C) 2013 WISEITECH CO., LTD. ALL RIGHTS RESERVED.
 */

/**
 * 관리자 주요통계지표관리 스크립트 파일이다
 *
 * @author 김정호
 * @version 1.0 2017/08/10
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
	tabSet();
	
	loadSheet();	//주요통계지표관리 시트 그리드를 생성한다.
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

	$("button[name=btn_inquiry]").bind("click", function(event) {
		//조회
		doAction("search");
    });
	$("button[name=btn_reg]").bind("click", function(event) {
		// 신규등록 폼 탭을 추가한다.
		doAction("regForm");
    });
	//조회 enter
	$("input[name=searchVal]").bind("keydown", function(event) {
        // 엔터키인 경우
        if (event.which == 13) {
        	doAction("search");
            return false;
        }
    });
	//시트 row 위로 이동
	$("a[name=a_treeUp]").bind("click", function(event) {
		doAction("gridUp");
    });
	//시트 row 아래로 이동
	$("a[name=a_treeDown]").bind("click", function(event) {
		doAction("gridDown");
    });
	//시트 순서 저장
	$("a[name=a_vOrderSave]").bind("click", function(event) {
		doAction("orderSave");
    });
}


/**
 * 옵션을 로드한다.
 */
function loadOptions() {
	loadComboOptions2("searchMajorStatCd", "/admin/stat/ajaxOption.do", {grpCd:"S1005"}, "");	//주요통계그룹코드(메인페이지)
}

/**
 * 데이터를 로드한다.
 */
function loadData() {
	doAction("search");
}

////////////////////////////////////////////////////////////////////////////////
// 서비스 함수
////////////////////////////////////////////////////////////////////////////////

/**
 * 화면 액션
 */
function doAction(sAction) {
	var formObj = getTabFormObj("sttsMajor-dtl-form");
	var classObj = $("."+tabContentClass);
	var actObj = setTabForm(classObj); // 0: form data, 1: form 객체
	var sheet = window["sheet"];

	switch(sAction) {                       
		case "search":
			ajaxBeforeSendAdmin(com.wise.help.url("/admin/ajaxBeforeSendAdmin.do")); //IbSheet 조회전 세션 체크
			var param = {PageParam: "ibpage", Param: "onepagerow=50"+"&"+actObj[0]};
			sheet.DoSearchPaging(com.wise.help.url("/admin/stat/statSttsMajorList.do"), param);
			break;
		case "regForm" :
			var title = "신규등록"
			var id ="statReg";
			openTab.addRegTab(id, title, tabCallRegBack);
			break;
		case "insert" :
			saveData();
			break;
		case "update" :
			saveData();
			break;	
		case "delete" :
			if ( !confirm("삭제 하시겠습니까?") )	return false;
			doAjax({
				url : "/admin/stat/deleteStatSttsMajor.do",
				params : formObj.serialize(),
				//succUrl : "/admin/stat/statSttsMajorPage.do"
				callback : afterTabRemove
			});
			break;	
		case "gridUp" :		//위로이동
			gridMoveUpChgVal(sheet, "vOrder");
			break;
		case "gridDown" :	//아래로이동
			gridMoveDownChgVal(sheet, "vOrder");
			break;	
		case "orderSave" :	//순서저장
			if(sheet.GetSaveJson(0).data.length == 0) {
				alert("저장할 데이터가 없습니다.");  
				return;
			}
			doAjax({
				url : "/admin/stat/saveStatSttsMajorOrder.do",
				params : formObj.serialize() + "&ibsSaveJson=" + encodeURIComponent(JSON.stringify(sheet.GetSaveJson(0))),
				succUrl : "/admin/stat/statSttsMajorPage.do",
			});
			break;		
		case "statTblPop" :	//통계표 팝업
			var url = com.wise.help.url("/admin/stat/popup/statTblPopup.do");
			var data = "?parentFormNm=sttsMajor-dtl-form";
			wWidth ="660";                                                    
			wHeight ="530";   
			openIframeStatPop("iframePopUp", url+data, wWidth, wHeight)
			break;	
		case "statPreviewPop" :	//통계표 미리보기 팝업
			window.open(com.wise.help.url("/admin/stat/statPreviewPage") + "/" + formObj.find("input[name=statblId]").val() + ".do", "list", "fullscreen=no, width=1152, height=768");
			break;	
	}
}

/**
 * 데이터 등록/수정(파일처리)
 */
function saveData() {
	var formObj = getTabFormObj("sttsMajor-dtl-form");
	formObj.ajaxSubmit({
		url : com.wise.help.url("/admin/stat/saveStatSttsMajor.do")
		, async : false
		, type : 'post'
		, dataType: 'json' 
		, contentType : 'application/x-www-form-urlencoded;charset=UTF-8'
		, beforeSubmit : function() {
			//submit 전 validation 체크
			if ( saveValidation() ) {
				if ( !confirm("저장 하시겠습니까?") )	return false;
			} else {
				return false;
			}
		}	
		, success : function(res, status) {
			doAjaxMsg(res, "");
			afterTabRemove(res)
		}
		, error: function(jqXHR, textStatus, errorThrown) {
			alert("처리 도중 에러가 발생하였습니다.");
		}
	});
}

////////////////////////////////////////////////////////////////////////////////
// 전처리 함수
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// 후처리 함수
////////////////////////////////////////////////////////////////////////////////
//상세 탭 이벤트 후처리
function tabFunction(tab, data) {
	var formObj = getTabFormObj("sttsMajor-dtl-form");
	
	loadTabComboOptions(formObj, "majorStatCd", "/admin/stat/ajaxOption.do", {grpCd:"S1005"}, data.DATA.majorStatCd);		//주요통계 그룹코드(탭)
	
	//통계표 콤보값 세팅
	setStatblComboValues(formObj, data.DATA);
}

/**
 * 통계표 콤보값 세팅
 * @param formObj	탭 form object
 * @param data		입력될 데이터들
 */
function setStatblComboValues(formObj, data) {
	var statblId = data.statblId;	//통계표 ID
	//항목
	doAjax({
		url : "/admin/stat/statTblItmCombo.do",
		params : {statblId:statblId, itmTag:'I'},
		callback : function(res) {
			initTabComboOptions(formObj, "itmDatano", res.data, data.itmDatano);
		}
	});
	//분류
	doAjax({
		url : "/admin/stat/statTblItmCombo.do",
		params : {statblId:statblId, itmTag:'C'},
		callback : function(res) {
			var msg = res.data.length > 0 ? "분류선택" : "분류없음"; 
			res.data = [{
    			code:"",
                name:msg
    		}].concat(res.data)
			initTabComboOptions(formObj, "clsDatano", res.data, data.clsDatano);
		}
	});
	// 그룹
	doAjax({
		url : "/admin/stat/statTblItmCombo.do",
		params : {statblId:statblId, itmTag:'G'},
		callback : function(res) {
			var msg = res.data.length > 0 ? "그룹선택" : "그룹없음"; 
			res.data = [{
    			code:"",
                name:msg
    		}].concat(res.data)
			initTabComboOptions(formObj, "grpDatano", res.data, data.grpDatano);
		}
	});
	//자료구분
	doAjax({
		url : "/admin/stat/statTblOptDtadvsCombo.do",
		params : {statblId:statblId},
		callback : function(res) {
			initTabComboOptions(formObj, "dtadvsCd", res.data, data.dtadvsCd);
		}
	});
	
	//주기(통계표 관리에서 선택된 주기만 표시)
	doAjax({
		url : "/admin/stat/statCheckedDtacycleList.do",
		params : {statblId:statblId},
		callback : function(res) {
			initTabComboOptions(formObj, "dtacycleCd", res.data, data.dtacycleCd);
		}
	});
	//loadTabComboOptions(formObj, "dtacycleCd", "/admin/stat/ajaxOption.do", {grpCd:"S1103"}, data.dtacycleCd);			//자료주기 구분코드(탭)
}

/**
 * 데이터 저장 완료 후
 */
function sheet_OnLoadData(data) {
	var data = JSON.parse(data);
	if ( data.success != null) {
		//시트 분류명 저장이 성공적으로 완료된 경우
		alert(data.success.message);
		doAction("search");
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
//등록 탭 이벤트
function regUserFunction(tab) {
	var formObj = getTabFormObj("sttsMajor-dtl-form");
	loadTabComboOptions(formObj, "majorStatCd", "/admin/stat/ajaxOption.do", {grpCd:"S1005"}, "");		//주요통계 그룹코드(탭)
	loadTabComboOptions(formObj, "dtacycleCd", "/admin/stat/ajaxOption.do", {grpCd:"S1103"}, "");		//자료주기 구분코드(탭)
	//formObj.find("select[name=grpCd] option").attr("disabled", true);	//입력유형의 선택유형공통코드 초기화(선택하지 못하도록)
}

//상세 탭 이벤트
function tabEvent(row){//탭 이벤트 실행  
	var title = sheet.GetCellValue(row, "majorNm");//탭 제목
	var id = sheet.GetCellValue(row, "majorId");//탭 id(유일한key))
	openTab.SetTabData(sheet.GetRowJson(row));//db data 조회시 조건 data
	var url =  com.wise.help.url('/admin/stat/statSttsMajorDtl.do'); // Controller 호출 url 
	openTab.addTab(id, title, url, tabCallBack); 	// 탭 추가 시작함
} 

////////////////////////////////////////////////////////////////////////////////
//시트 로드
////////////////////////////////////////////////////////////////////////////////
function loadSheet() {
	
	createIBSheet2(document.getElementById("sheet"),"sheet", "100%", "300px");
	
	var gridTitle ="NO";
	gridTitle +="|상태";
	gridTitle +="|주요통계ID";
	gridTitle +="|한글주요통계명";
	gridTitle +="|영문주요통계명";
	gridTitle +="|주요통계그룹";
	gridTitle +="|통계표";
	gridTitle +="|자료주기";
	gridTitle +="|" + $("#statGroupTxt").val();
	gridTitle +="|분류";
	gridTitle +="|항목";
	gridTitle +="|자료구분";
	gridTitle +="|순서";
	gridTitle +="|사용여부";
	
	with(sheet){
		                     
		var cfg = {SearchMode:2,Page:50,VScrollMode:1};
	    SetConfig(cfg);
	    var headers = [
	                {Text:gridTitle, Align:"Center"}
	            ];
	    var headerInfo = {Sort:0,ColMove:1,ColResize:1,HeaderCheck:0};
	    
	    InitHeaders(headers, headerInfo);
	   
	    var cols = [
	                 {Type:"Seq",		SaveName:"seq",			Width:30,	Align:"Center",		Edit:false}
	                ,{Type:"Status",	SaveName:"status",		Width:50,	Align:"Center",		Edit:false}
					,{Type:"Text",		SaveName:"majorId",		Width:70,	Align:"Center",		Edit:false}
					,{Type:"Text",		SaveName:"majorNm",		Width:200,	Align:"Left",		Edit:false}
					,{Type:"Text",		SaveName:"engMajorNm",	Width:150,	Align:"Left",		Edit:false}
					,{Type:"Text",		SaveName:"majorStatNm",	Width:100,	Align:"Center",		Edit:false}
					,{Type:"Text",		SaveName:"statblNm",	Width:200,	Align:"Left",		Edit:false,	Hidden:true}
					,{Type:"Text",		SaveName:"dtacycldNm",	Width:80,	Align:"Center",		Edit:false}
					,{Type:"Text",		SaveName:"grpDataNm",	Width:90,	Align:"Left",		Edit:false, TrueValue:"N", FalseValue:"Y"}
					,{Type:"Text",		SaveName:"clsDataNm",	Width:90,	Align:"Left",		Edit:false, TrueValue:"N", FalseValue:"Y"}
					,{Type:"Text",		SaveName:"itmDataNm",	Width:90,	Align:"Left",		Edit:false}
					,{Type:"Text",		SaveName:"dtadvsNm",	Width:80,	Align:"Center",		Edit:false, TrueValue:"N", FalseValue:"Y"}
					,{Type:"Number",	SaveName:"vOrder",		Width:60,	Align:"Center",		Edit:false,	Hidden:true}
					,{Type:"Combo",		SaveName:"useYn",		Width:60,	Align:"Center",		Edit:false, TrueValue:"N", FalseValue:"Y"}
	            ];                                          
	    InitColumns(cols);
	    FitColWidth();
	    SetExtendLastCol(1);
	    
	    initSheetOptions("sheet", 0, "useYn", 		[{code:"Y", name:"사용"}, {code:"N", name:"미사용"}]);
	}               
	default_sheet(sheet);   
	
}
////////////////////////////////////////////////////////////////////////////////
//시트 서비스 함수
////////////////////////////////////////////////////////////////////////////////
function sheet_OnDblClick(row, col, value, cellx, celly) {
	if(row < 1) return;                                         
	    tabEvent(row);
}

function sheet_OnSearchEnd(code, message, statusCode, statusMessage) {
	toggleShowHideOrderBtn("statMainForm");
}
////////////////////////////////////////////////////////////////////////////////
//이벤트 함수
////////////////////////////////////////////////////////////////////////////////
/**
 * 탭 이벤트를 바인딩한다.
 */
function setTabButton() {
	var formObj = getTabFormObj("sttsMajor-dtl-form");
	formObj.find("a[name=a_init]").bind("click", function(event) {
		//초기화
		formObj.find("input[name=majorNm], input[name=engMajorNm], input[name=statblId], input[name=statblNm], input[name=majorNm]").val("");
		formObj.find("select[name=majorStatCd], select[name=dtacycleCd], select[name=itmDatano], select[name=dtadvsCd]").find('option:first').attr('selected', 'selected');	//첫번째 항목 선택
		
    });
	formObj.find("a[name=a_reg]").bind("click", function(event) {
		// 등록
		doAction("insert");
    });
	formObj.find("a[name=a_modify]").bind("click", function(event) {
		// 수정
		doAction("update");
    });
	formObj.find("a[name=a_del]").bind("click", function(event) {
		// 삭제
		doAction("delete");
    });
	formObj.find("button[name=statbl_pop]").bind("click", function(e) {
		//통계표 검색 팝업
		doAction("statTblPop");
	});
	formObj.find("button[name=statPreview_pop]").bind("click", function(e) {
		//통계표 팝업
		doAction("statPreviewPop");
	});
	formObj.find("input[name=statblId]").bind("change", function(event) {
		//통계표 변경 이벤트(통계표 팝업에서 선택시 호출됨)
		setStatblComboValues(formObj, {statblId : $(this).val()});
    });
	
}
////////////////////////////////////////////////////////////////////////////////
//Validation 함수
////////////////////////////////////////////////////////////////////////////////
/**
 * 등록/수정 validation 
 */
function saveValidation() {
	var objTab = getTabShowObj();//탭이 oepn된 객체가져옴
	var formObj = objTab.find("form[name=sttsMajor-dtl-form]");
	return tabFormObjValidChk({
			formObj : formObj,
			validObj : [
				{ type : "text",	name : "majorNm", 		title : "주요통계명" },
				{ type : "combo", 	name : "majorStatCd", 	title : "주요통계그룹" },
				{ type : "text", 	name : "statblId", 		title : "통계표" },
				{ type : "combo", 	name : "itmDatano", 	title : "통계표 항목" },
				{ type : "combo", 	name : "dtadvsCd", 		title : "자료구분" },
				{ type : "radio", 	name : "useYn", 		title : "사용여부" }
			]
		});
}

/**
 * 탭 form object validation 체크
 * @param param
 * @returns {Boolean}
 */
function tabFormObjValidChk(param) {
	var formObj = param.formObj;		//탭내의 폼object
	var validObj = param.validObj;		//검증할 object들
	var result = true;
	
	if ( validObj.length <= 0 )	return false;
	
	for ( var valid in validObj ) {
		var type = validObj[valid].type;
		var name = validObj[valid].name;
		var title = validObj[valid].title;
		
		if ( type == "text" ) {
			//input box
			if ( com.wise.util.isNull(formObj.find("input[name="+ name +"]").val()) ) {
				alert(title + "을(를) 입력하세요.");
				formObj.find("input[name="+ name +"]").focus();
				result = false;
				break;
			}
		} else if ( type == "combo" ) {
			//select box
			if ( com.wise.util.isNull(formObj.find("select[name="+ name +"]").val()) ) {
				alert(title + "을(를) 선택하세요.");
				formObj.find("select[name="+ name +"]").focus();
				result = false;
				break;
			}
		} else if ( type == "radio" ) {
			//input radio
			if ( com.wise.util.isNull(formObj.find("input[name="+ name +"]:checked").val()) ) {
				alert(title + "을(를) 선택하세요.");
				formObj.find("input[name="+ name +"]").eq(0).focus();
				result = false;
				break;
			}
		}
	}
	return result;
}