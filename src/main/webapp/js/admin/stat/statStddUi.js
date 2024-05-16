/*
 * @(#)statStddUi.js 1.0 2017/06/28
 * 
 * COPYRIGHT (C) 2013 WISEITECH CO., LTD. ALL RIGHTS RESERVED.
 */

/**
 * 관리자 통계 표준단위 관리 스크립트 파일이다
 *
 * @author 김정호
 * @version 1.0 2017/06/28
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
	//var formObj = getTabFormObj("stddUi-dtl-form");
	//var objTab = getTabShowObj();//탭이 oepn된 객체가져옴
	//var formObj = objTab.find("form[name=stddUi-dtl-form]");
	
	$('input[name=chkTreeOpenClose]').click(function(){
		var sheet = window["sheet"];
		var isChecked = $(this).prop("checked");
		// 트리 항목 펼치기
		if ( isChecked ) {
			sheet.ShowTreeLevel(-1);
			$('label:contains(항목펼치기)').text('항목접기');
		}else  {
			sheet.ShowTreeLevel(0);
			$('label:contains(항목접기)').text('항목펼치기');
		}
	});
	$("button[name=btn_inquiry]").bind("click", function(event) {
		doAction("search");
    });
	//조회 enter
	$("input[name=searchVal]").bind("keydown", function(event) {
        // 엔터키인 경우
        if (event.which == 13) {
        	doAction("search");
            return false;
        }
    });
	$("button[name=btn_reg]").bind("click", function(event) {
		// 신규등록 폼 탭을 추가한다.
		doAction("regForm");
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
	loadComboOptions2("searchUityCd", "/admin/stat/ajaxOption.do", {grpCd:"S1003"}, "");
	loadComboOptions3("uityCd", "/admin/stat/ajaxOption.do", {grpCd:"S1003"}, "");
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
	var mainFormObj = $("form[name=statMainForm]");
	var formObj = getTabFormObj("stddUi-dtl-form");
	var sheet = window["sheet"];

	switch(sAction) {                       
		case "search":
			ajaxBeforeSendAdmin(com.wise.help.url("/admin/ajaxBeforeSendAdmin.do")); //IbSheet 조회전 세션 체크
			var param = {PageParam: "ibpage", Param: "onepagerow=50"+"&"+mainFormObj.serialize()};
			sheet.DoSearchPaging(com.wise.help.url("/admin/stat/statStddUiList.do"), param);
			break;
		case "regForm" :
			var title = "신규등록"
			var id ="statReg";
			openTab.addRegTab(id, title, tabCallRegBack);
			break;
		case "dupChk" : 
			doPost({
                url:"/admin/stat/statStddUiDupChk.do",
                before : beforeStatStddUiDupChk,
                after : afterStatStddUiDupChk
            });
			break;
		case "insert" :
			if ( saveValidation() ) {
				if ( !confirm("등록 하시겠습니까?") )	return false;
				doAjax({
					url : "/admin/stat/insertStatStddUi.do",
					params : formObj.serialize(),
					//succUrl : "/admin/stat/statStddUiPage.do"
					callback : afterTabRemove
				});
			} 
			break;
		case "update" :
			if ( saveValidation() ) {
				if ( !confirm("저장 하시겠습니까?") )	return false;
				doAjax({
					url : "/admin/stat/updateStatStddUi.do",
					params : formObj.serialize(),
					//succUrl : "/admin/stat/statStddUiPage.do"
					callback : afterTabRemove
				});
			} 
			break;	
		case "delete" :
			if ( !confirm("삭제 하시겠습니까?") )	return false;
			doAjax({
				url : "/admin/stat/deleteStatStddUi.do",
				params : formObj.serialize(),
				//succUrl : "/admin/stat/statStddUiPage.do"
				callback : afterTabRemove
			});
			break;	
		case "uiPop" :
			//var url = com.wise.help.url("/admin/stat/popup/statStddUiPop.do");
			//OpenWindow(url,"stddUiPop","700","550","yes");
			var url = com.wise.help.url("/admin/stat/popup/statStddGrpUiPop.do");
			var data = "?parentFormNm=stddUi-dtl-form";
			wWidth ="660";                                                    
			wHeight ="530";   
			openIframeStatPop("iframePopUp", url+data, wWidth, wHeight)
			break;
		case "uiInit" : 
			formObj.find("input[name=grpUiId]").val("UICTLG");
			formObj.find("input[name=grpUiNm]").val("최상위");
			break;
		case "treeUp" :		//위로이동
			//treeUp(sheet, true, "vOrder");
			fncTreeUp(sheet, "vOrder");
			break;
		case "treeDown" :	//아래로이동
			//treeDown(sheet, true, "vOrder");
			fncTreeDown(sheet, "vOrder");
			break;	
		case "orderSave" :
			saveSheetData({
                SheetId:"sheet",
                PageUrl:"/admin/stat/saveStatStddUiOrder.do"
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
/**
 * 단위ID 중복체크 전처리 함수
 */
function beforeStatStddUiDupChk(options) {
	var formObj = getTabFormObj("stddUi-dtl-form");
	var uiId = formObj.find("input[name=uiId]").val().toUpperCase();
    var data = {
        "uiId" : uiId
    };
    if ( com.wise.util.isBlank(data.uiId) ) {
    	alert("단위ID를 입력하세요.");
    	formObj.find("input[name=uiId]").focus();
        return null;
    }
    
    formObj.find("input[name=uiId]").val(uiId);	//소문자로 입력되어있을경우 대문자로 변경해서 보여줌
    
    if ( !com.wise.util.isAlphaNumeric(data.uiId) || !com.wise.util.isLength(data.uiId, 1, 10) ) {
    	alert("영문, 숫자 10자리 이내로 입력하세요.");
    	formObj.find("input[name=uiId]").val("").focus();
        return null;
    }
    
    return data;
}
////////////////////////////////////////////////////////////////////////////////
// 후처리 함수
////////////////////////////////////////////////////////////////////////////////
//상세 탭 이벤트 후처리
function tabFunction(tab, data) {
	var formObj = getTabFormObj("stddUi-dtl-form");
	//console.log(data);
	formObj.find("button[name=ui_dup]").hide();		//중복확인 버튼 숨김(수정못함)
	formObj.find("input[name=dupChk]").val("Y");	//중복체크 Y로
	if ( data.DATA.uiCvsnYn == "Y" ) {
		formObj.find("input[name=uiCvsnYn]").prop("checked", true);
	}
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

/**
 * 단위ID 중복체크 후처리
 * @param data	return value
 */
function afterStatStddUiDupChk(data) {
	var formObj = getTabFormObj("stddUi-dtl-form");
	if ( data.dupCnt > 0 ) {
		alert("중복되는 ID가 있습니다.\n다른 ID를 입력해 주세요.");
		formObj.find("input[name=uiId]").focus();
		formObj.find("input[name=dupChk]").val("N");
	} else {
		alert("사용가능한 ID 입니다.");
		formObj.find("input[name=dupChk]").val("Y");
		formObj.find("input[name=uiId]").attr("readonly", true);	//중복체크 완료 후 단위ID변경 불가
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
function regUserFunction() {
	var formObj = getTabFormObj("stddUi-dtl-form");
	formObj.find("input[name=uiId]").attr("readonly", false).removeClass("readonly");
	formObj.find("input[name=uiCvsnYn]").prop("checked", true);
}
//상세 탭 이벤트
function tabEvent(row){//탭 이벤트 실행  
	var title = sheet.GetCellValue(row, "uiNm");//탭 제목
	var id = sheet.GetCellValue(row, "uiId");//탭 id(유일한key))
	openTab.SetTabData(sheet.GetRowJson(row));//db data 조회시 조건 data
	var url =  com.wise.help.url('/admin/stat/statStddUiDtl.do'); // Controller 호출 url 
	openTab.addTab(id, title, url, tabCallBack); 	// 탭 추가 시작함
} 

////////////////////////////////////////////////////////////////////////////////
//시트 로드
////////////////////////////////////////////////////////////////////////////////
function loadSheet() {
	
	createIBSheet2(document.getElementById("sheet"),"sheet", "100%", "300px");
	
	var gridTitle ="NO";
	gridTitle +="|상태";
	gridTitle +="|단위ID";
	gridTitle +="|한글단위명";
	gridTitle +="|영문단위명";
	gridTitle +="|단위전체명";
	gridTitle +="|단위유형";
	gridTitle +="|단위변환값";
	gridTitle +="|단위변환여부";
	gridTitle +="|레벨";
	gridTitle +="|순서";
	gridTitle +="|사용여부";
	
	with(sheet){
		                     
		var cfg = {SearchMode:smLazyLoad,ChildPage:5,VScrollMode:1,ChildPage: 20};
	    SetConfig(cfg);
	    var headers = [
	                {Text:gridTitle, Align:"Center"}
	            ];
	    var headerInfo = {Sort:0,ColMove:1,ColResize:1,HeaderCheck:0};
	    
	    InitHeaders(headers, headerInfo);
	   
	    var cols = [
	                 {Type:"Seq",		SaveName:"seq",			Width:30,	Align:"Center",		Edit:false}
	                ,{Type:"Status",	SaveName:"status",		Width:30,	Align:"Center",		Edit:false} 
					,{Type:"Text",		SaveName:"uiId",		Width:70,	Align:"Center",		Edit:false}
					,{Type:"Text",		SaveName:"uiNm",		Width:220,	Align:"Left",		Edit:false,	TreeCol:1}
					,{Type:"Text",		SaveName:"engUiNm",		Width:150,	Align:"Left",		Edit:false}
					,{Type:"Text",		SaveName:"uiFullNm",	Width:300,	Align:"Left",		Edit:false,	Hidden:true}
					,{Type:"Text",		SaveName:"uityNm",		Width:70,	Align:"Center",		Edit:false}
					,{Type:"Text",		SaveName:"uiCvsnVal",	Width:70,	Align:"Right",		Edit:false}
					,{Type:"Combo",		SaveName:"uiCvsnYn",	Width:60,	Align:"Center",		Edit:false, TrueValue:"N", FalseValue:"Y"}
					,{Type:"Int",		SaveName:"Level",		Width:60,	Align:"Center",		Edit:false,	Hidden:true}
					,{Type:"Int",		SaveName:"vOrder",		Width:60,	Align:"Center",		Edit:false,	Hidden:false}
					,{Type:"Combo",		SaveName:"useYn",		Width:60,	Align:"Center",		Edit:false, TrueValue:"N", FalseValue:"Y"}
	            ];                                          
	    InitColumns(cols);
	    FitColWidth();
	    SetExtendLastCol(1);
	    
	    initSheetOptions("sheet", 0, "uiCvsnYn", 	[{code:"Y",name:"사용"}, {code:"N",name:"미사용"}]);
	    initSheetOptions("sheet", 0, "useYn", 		[{code:"Y",name:"사용"}, {code:"N",name:"미사용"}]);
	    
	    ShowTreeLevel(0, 1);
	    SetCountPosition(0);
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
	//조회 후 순서관련 버튼 숨김
	/*
	var formObj = $("form[name=statMainForm]");
	//검색어가 없고, 단위유형이 전체or선택 되어있으면 순서버튼 보여준다.
	if ( ( !com.wise.util.isBlank(formObj.find("select[name=searchUityCd]").val()) || com.wise.util.isBlank(formObj.find("select[name=searchUityCd]").val()) ) 
			&& com.wise.util.isBlank(formObj.find("input[name=searchVal]").val())  ) {
		formObj.find("a[name=a_treeUp], a[name=a_treeDown], a[name=a_vOrderSave]").show();
	} else {
		formObj.find("a[name=a_treeUp], a[name=a_treeDown], a[name=a_vOrderSave]").hide();
	}
	*/
}
////////////////////////////////////////////////////////////////////////////////
//이벤트 함수
////////////////////////////////////////////////////////////////////////////////
/**
 * 탭 이벤트를 바인딩한다.
 */
function setTabButton() {
	var formObj = getTabFormObj("stddUi-dtl-form");
	
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
	formObj.find("button[name=ui_pop]").bind("click", function() {
		//단위그룹 팝업
		doAction("uiPop");
	});
	formObj.find("button[name=ui_init]").bind("click", function() {
		//단위그룹 초기화
		doAction("uiInit");
	});
	formObj.find("button[name=ui_dup]").bind("click", function() {
		//단위ID 중복체크
		doAction("dupChk");
	});
	formObj.find("input[name=uiId]").keypress(function(e) {
		  if(e.which == 13) {
			  doAction('dupChk');   
			  return false;        
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
	var formObj = objTab.find("form[name=stddUi-dtl-form]");
	
	if ( formObj.find("input[name=dupChk]").val() == "N" ) {
		alert("단위ID 중복체크 하세요.");
		formObj.find("input[name=uiId]").focus();
		return false;
	}
	if ( com.wise.util.isNull(formObj.find("input[name=uiNm]").val()) ) {
		alert("단위명을 입력하세요.");
		formObj.find("input[name=uiNm]").focus();
		return false;
	} else if ( !com.wise.util.isLength(formObj.find("input[name=uiNm]").val(), 1, 20) ) {
		alert("20자 이내로 입력하세요.");
		formObj.find("input[name=uiNm]").focus();
		return false;
	}
	
	if ( com.wise.util.isBlank(formObj.find("select[name=uityCd]").val()) ) {
		alert("단위유형을 선택하세요");
		formObj.find("select[name=uityCd]").focus();
		return false;
	}
	
	if ( com.wise.util.isNull(formObj.find("input[name=grpUiId]").val()) ) {
		alert("단위 그룹을 선택하세요.");
		formObj.find("button[name=ui_pop]").focus();
		return false;
	}
	if ( !com.wise.util.isNumeric(formObj.find("input[name=uiCvsnVal]").val())
			|| com.wise.util.isNull(formObj.find("input[name=uiCvsnVal]").val()) ) {
		alert("단위변환 값이 비어있거나 숫자형식이 아닙니다.");
		formObj.find("input[name=uiCvsnVal]").val("").focus();
		return false;
	}
	if ( !com.wise.util.isBlank(formObj.find("input[name=vOrder]").val()) 
			&& !com.wise.util.isNumeric(formObj.find("input[name=vOrder]").val()) ) {
		alert("출력순서 값이 숫자형식이 아닙니다.");
		formObj.find("input[name=vOrder]").val("").focus();
		return false;
	}
	if ( com.wise.util.isNull(formObj.find("input[name=useYn]:checked").val()) ) {
		alert("사용여부를 선택하세요.");
		formObj.find("input[name=useYn]").focus();
		return false;
	}
	
	return true;
}

