/*
 * @(#)statStddMeta.js 1.0 2017/07/03
 * 
 * COPYRIGHT (C) 2013 WISEITECH CO., LTD. ALL RIGHTS RESERVED.
 */

/**
 * 관리자 통계 표준메타 관리 스크립트 파일이다
 *
 * @author 김정호
 * @version 1.0 2017/07/03
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
	
	// 표준항목 분류정의 시트 그리드를 생성한다.
	loadSheet();
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
	$("a[name=a_treeUp]").bind("click", function(event) {
		doAction("treeUp");
    });
	$("a[name=a_treeDown]").bind("click", function(event) {
		doAction("treeDown");
    });
	$("a[name=a_vOrderSave]").bind("click", function(event) {
		doAction("orderSave");
    });
	
}


/**
 * 옵션을 로드한다.
 */
function loadOptions() {
	//메인페이지 단위유형코드
	loadComboOptions("sttsCd", "/admin/stat/ajaxOption.do", {grpCd:"S1008"}, "");			//통계구분코드(탭)
	loadComboOptions("metaCd", "/admin/stat/ajaxOption.do", {grpCd:"S1001"}, "");			//메타구분코드(탭)
	loadComboOptions("metatyCd", "/admin/stat/ajaxOption.do", {grpCd:"S1002"}, "");			//메타입력유형코드(탭)
	loadComboOptions3("inputMaxCd", "/admin/stat/ajaxOption.do", {grpCd:"S4002"}, "");		//입력최대길이코드(탭)
	loadComboOptions3("grpCd", "/admin/stat/ajaxOption.do", {grpCd:"00000"}, "");			//선택유형공통코드(탭)
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
	var formObj = getTabFormObj("stddMeta-dtl-form");
	var classObj = $("."+tabContentClass);
	var actObj = setTabForm(classObj); // 0: form data, 1: form 객체
	var sheet = window["sheet"];

	switch(sAction) {                       
		case "search":
			ajaxBeforeSendAdmin(com.wise.help.url("/admin/ajaxBeforeSendAdmin.do")); //IbSheet 조회전 세션 체크
			var param = {PageParam: "ibpage", Param: "onepagerow=50"+"&"+actObj[0]};
			sheet.DoSearchPaging(com.wise.help.url("/admin/stat/statStddMetaList.do"), param);
			break;
		case "regForm" :
			var title = "신규등록"
			var id ="statReg";
			openTab.addRegTab(id, title, tabCallRegBack);
			break;
		case "insert" :
			if ( saveValidation() ) {
				if ( !confirm("등록 하시겠습니까?") )	return false;
				doAjax({
					url : "/admin/stat/insertStatStddMeta.do",
					params : formObj.serialize(),
					//succUrl : "/admin/stat/statStddMetaPage.do"
					callback : afterTabRemove
				});
			} 
			break;
		case "update" :
			if ( saveValidation() ) {
				if ( !confirm("저장 하시겠습니까?") )	return false;
				doAjax({
					url : "/admin/stat/updateStatStddMeta.do",
					params : formObj.serialize(),
					//succUrl : "/admin/stat/statStddMetaPage.do"
					callback : afterTabRemove
				});
			} 
			break;	
		case "delete" :
			if ( !confirm("삭제 하시겠습니까?") )	return false;
			doAjax({
				url : "/admin/stat/deleteStatStddMeta.do",
				params : formObj.serialize(),
				//succUrl : "/admin/stat/statStddMetaPage.do"
				callback : afterTabRemove
			});
			break;	
		case "treeUp" :		//위로이동
			gridMoveUpChgVal(sheet, "vOrder");
			break;
		case "treeDown" :	//아래로이동
			gridMoveDownChgVal(sheet, "vOrder");
			break;	
		case "orderSave" :
			/*
			if(sheet.GetSaveJson(0).data.length == 0) {
				alert("저장할 데이터가 없습니다.");  
				return;
			}
			*/
			saveSheetData({
                SheetId:"sheet",
                PageUrl:"/admin/stat/saveStatStddMetaOrder.do"
            }, {
            	//not thing to do
            }, {
                AllSave:0
            });
			break;	
	}
}

////////////////////////////////////////////////////////////////////////////////
// 전처리 함수
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// 후처리 함수
////////////////////////////////////////////////////////////////////////////////
//상세 탭 이벤트 후처리
function tabFunction(tab, data) {
	var formObj = getTabFormObj("stddMeta-dtl-form");
	
	$.each(data.DATA, function(key, val) {
		if ( key == "metatyCd" ) {	//메타입력유형코드가 SB(공통코드선택) 이면
			if ( val == "SB" ) {
				tab.ContentObj.find("select[name=grpCd] option").attr("disabled", false);
			} else if ( val == "ST" ) {
				tab.ContentObj.find("select[name=inputMaxCd] option").attr("disabled", false);
			} else {
				tab.ContentObj.find("select[name=grpCd] option").attr("disabled", true);
				tab.ContentObj.find("select[name=inputMaxCd] option").attr("disabled", true);
			}
		} else if ( key == "grpCd" ) {
			tab.ContentObj.find("input[name=preGrpCd]").val(val);
		} else if ( key == "inputMaxCd" ) {
			tab.ContentObj.find("input[name=preInputMaxCd]").val(val);
		}
			
	});
	
	dynamicTabButton(tab);		//탭 이벤트를 바인딩한다(동적생성 element들)
	
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
	var formObj = getTabFormObj("stddMeta-dtl-form");
	formObj.find("select[name=grpCd] option").attr("disabled", true);	//입력유형의 선택유형공통코드 초기화(선택하지 못하도록)
	
	dynamicTabButton(tab);		//탭 이벤트를 바인딩한다(동적생성 element들)
}

//상세 탭 이벤트
function tabEvent(row){//탭 이벤트 실행  
	var title = sheet.GetCellValue(row, "metaNm");//탭 제목
	var id = sheet.GetCellValue(row, "metaId");//탭 id(유일한key))
	openTab.SetTabData(sheet.GetRowJson(row));//db data 조회시 조건 data
	var url =  com.wise.help.url('/admin/stat/statStddMetaDtl.do'); // Controller 호출 url 
	openTab.addTab(id, title, url, tabCallBack); 	// 탭 추가 시작함
} 

////////////////////////////////////////////////////////////////////////////////
//시트 로드
////////////////////////////////////////////////////////////////////////////////
function loadSheet() {
	
	createIBSheet2(document.getElementById("sheet"),"sheet", "100%", "300px");
	
	var gridTitle ="NO";
	gridTitle +="|상태";
	gridTitle +="|통계구분";
	gridTitle +="|메타ID";
	gridTitle +="|메타항목명";
	gridTitle +="|영문메타항목명";
	gridTitle +="|메타구분";
	gridTitle +="|입력유형";
	gridTitle +="|순서";
	gridTitle +="|필수";
	gridTitle +="|공개";
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
	                ,{Type:"Status",	SaveName:"status",		Width:30,	Align:"Center",		Edit:false} 
					,{Type:"Text",		SaveName:"sttsCdNm",	Width:70,	Align:"Center",		Edit:false}
					,{Type:"Text",		SaveName:"metaId",		Width:70,	Align:"Center",		Edit:false}
					,{Type:"Text",		SaveName:"metaNm",		Width:200,	Align:"Left",		Edit:false}
					,{Type:"Text",		SaveName:"engMetaNm",	Width:160,	Align:"Left",		Edit:false}
					,{Type:"Text",		SaveName:"metaCdNm",	Width:90,	Align:"Center",		Edit:false}
					,{Type:"Text",		SaveName:"metatyCdNm",	Width:90,	Align:"Center",		Edit:false}
					,{Type:"Text",		SaveName:"vOrder",		Width:60,	Align:"Center",		Edit:false,	Hidden:true}
					,{Type:"Combo",		SaveName:"inputNeedYn",	Width:60,	Align:"Center",		Edit:false, TrueValue:"N", FalseValue:"Y"}
					,{Type:"Combo",		SaveName:"openYn",		Width:60,	Align:"Center",		Edit:false, TrueValue:"N", FalseValue:"Y"}
					,{Type:"Combo",		SaveName:"useYn",		Width:60,	Align:"Center",		Edit:false, TrueValue:"N", FalseValue:"Y"}
	            ];                                          
	    InitColumns(cols);
	    FitColWidth();
	    SetExtendLastCol(1);
	    
	    initSheetOptions("sheet", 0, "inputNeedYn", [{code:"Y", name:"예"}, {code:"N", name:"아니오"}]);
	    initSheetOptions("sheet", 0, "useYn", 		[{code:"Y", name:"사용"}, {code:"N", name:"미사용"}]);
	    initSheetOptions("sheet", 0, "openYn", 		[{code:"Y", name:"사용"}, {code:"N", name:"아니오"}]);
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
	toggleShowHideOrderBtn("statMainForm");	//검색어가 있을경우 순서 관련 버튼 숨김
}
////////////////////////////////////////////////////////////////////////////////
//이벤트 함수
////////////////////////////////////////////////////////////////////////////////
/**
 * 탭 이벤트를 바인딩한다.
 */
function setTabButton() {
	var formObj = getTabFormObj("stddMeta-dtl-form");
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
}

/**
 * 탭 이벤트를 바인딩한다.(동적으로 생성된 selectBox등)
 */
function dynamicTabButton(tab) {
	tab.ContentObj.on("change", "select[name=metatyCd]", function() {
		tab.ContentObj.find("select[name=grpCd]").val(tab.ContentObj.find("input[name=preGrpCd]").val());	//이전 option 값(db값) 으로 value 지정
		tab.ContentObj.find("select[name=inputMaxCd]").val(tab.ContentObj.find("input[name=preInputMaxCd]").val());	//이전 option 값(db값) 으로 value 지정
		if ( $(this).val() == "SB" ) {	//메타입력유형코드가 공통코드선택(SB)인 경우
			tab.ContentObj.find("select[name=inputMaxCd] option").attr("disabled", true);	//문자수 비활성화
			tab.ContentObj.find("select[name=grpCd] option").attr("disabled", false);		//그룹코드 활성화
			tab.ContentObj.find("select[name=grpCd]").focus();
		} else if ( $(this).val() == "ST" ) {	//메타입력유형코드가 문자열(ST)인 경우
			tab.ContentObj.find("select[name=inputMaxCd] option").attr("disabled", false);	//문자수 활성화
			tab.ContentObj.find("select[name=grpCd] option").attr("disabled", true);		//그룹코드 비활성화
			tab.ContentObj.find("select[name=inputMaxCd]").focus();
		} else {
			tab.ContentObj.find("select[name=inputMaxCd] option").attr("disabled", true);	//문자수 비활성
			tab.ContentObj.find("select[name=grpCd] option").attr("disabled", true);		//그룹코드 비활성
			
		}
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
	var formObj = objTab.find("form[name=stddMeta-dtl-form]");
	
	if ( com.wise.util.isNull(formObj.find("input[name=metaNm]").val()) ) {
		alert("메타명을 입력하세요.");
		formObj.find("input[name=metaNm]").focus();
		return false;
	}
	if ( com.wise.util.isNull(formObj.find("input[name=openYn]:checked").val()) ) {
		alert("공개여부를 선택하세요.");
		formObj.find("input[name=openYn]").eq(0).focus();
		return false;
	}
	
	//입력 유형 필수값 체크
	if ( formObj.find("select[name=metatyCd]").val() == "ST" ) {
		//문자열인 경우
		if ( com.wise.util.isBlank(formObj.find("select[name=inputMaxCd]").val()) ) {
			alert("글자수를 선택해 주세요.");
			formObj.find("select[name=inputMaxCd]").focus();
			return false;
		}
	} else if ( formObj.find("select[name=metatyCd]").val() == "SB" ) {
		//공통코드 인경우
		if ( com.wise.util.isBlank(formObj.find("select[name=grpCd]").val()) ) {
			alert("코드값을 선택해 주세요.");
			formObj.find("select[name=grpCd]").focus();
			return false;
		}
	} else {
		//나머지
		if ( com.wise.util.isBlank(formObj.find("textarea[name=metaExp]").val()) ) {
			alert("값을 입력해 주세요.");
			formObj.find("textarea[name=metaExp]").focus();
			return false;
		}
	}
	
	if ( com.wise.util.isNull(formObj.find("input[name=useYn]:checked").val()) ) {
		alert("사용여부를 선택하세요.");
		formObj.find("input[name=useYn]").eq(0).focus();
		return false;
	}
	return true;
}

