/*
 * @(#)statStddItm.js 1.0 2017/06/26
 * 
 * COPYRIGHT (C) 2013 WISEITECH CO., LTD. ALL RIGHTS RESERVED.
 */

/**
 * 관리자 통계 표준항목 관리 스크립트 파일이다
 *
 * @author 김정호
 * @version 1.0 2017/06/26
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
	//var formObj = getTabFormObj("stddItm-dtl-form");
	//var objTab = getTabShowObj();//탭이 oepn된 객체가져옴
	//var formObj = objTab.find("form[name=stddItm-dtl-form]");
	
	// textarea placeholder text 유지 ie 문제 임시 해결
	$("textarea").on("click", function(event) {
		if ( $(this).val() == $(this).attr("placeholder") ) {
			$(this).val("");
		}
	});
	
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
	$("a[name=a_saveItmNm]").bind("click", function(event) {
		//doAction("saveItmNm");
		return false;
    });
}


/**
 * 옵션을 로드한다.
 */
function loadOptions() {
	
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
	var formObj = getTabFormObj("stddItm-dtl-form");
	var sheet = window["sheet"];

	switch(sAction) {                       
		case "search":
			var param = "searchGubun=" + $("select[name=searchGubun]").val()  
				+ "&searchVal=" + $("input[name=searchVal]").val() 
				+ "&useYn=" + $("form[name=statMainForm] input[name=useYn]:checked").val();
			var data = sheet.GetSearchData(com.wise.help.url("/admin/stat/statStddItmList.do"), param);
			sheet.LoadSearchData(data);
			break;
		case "saveItmNm" :
			//분류명 수정 저장
			saveSheetData({
                SheetId:"sheet",
                PageUrl:"/admin/stat/saveStatStddItmNm.do"
            }, {
            	//not thing to do
            }, {
                AllSave:0
            });
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
					url : "/admin/stat/insertStatStddItm.do",
					params : formObj.serialize(),
					//succUrl : "/admin/stat/statStddItmPage.do"
					callback : afterTabRemove
				});
			} 
			break;
		case "update" :
			if ( saveValidation() ) {
				if ( !confirm("저장 하시겠습니까?") )	return false;
				doAjax({
					url : "/admin/stat/updateStatStddItm.do",
					params : formObj.serialize(),
					//succUrl : "/admin/stat/statStddItmPage.do"
					callback : afterTabRemove
				});
			} 
			break;	
		case "delete" :
			if ( !confirm("삭제 하시겠습니까?") )	return false;
			doAjax({
				url : "/admin/stat/deleteStatStddItm.do",
				params : formObj.serialize(),
				//succUrl : "/admin/stat/statStddItmPage.do"
				callback : afterTabRemove
			});
			break;	
		case "itmPop" :
			//var url = com.wise.help.url("/admin/stat/popup/statStddItmPop.do");
			//OpenWindow(url,"stddItmPop","700","550","yes");
			var url = com.wise.help.url("/admin/stat/popup/statStddItmPop.do");
			var data = "?parentFormNm=stddItm-dtl-form";
			wWidth ="660";                                                    
			wHeight ="530";   
			openIframeStatPop("iframePopUp", url+data, wWidth, wHeight)
			break;
		case "itmInit" : 
			formObj.find("input[name=parItmId]").val("0");
			formObj.find("input[name=parItmNm]").val("");
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
			if(sheet.GetSaveJson(0).data.length == 0) {
				alert("저장할 데이터가 없습니다.");  
				return;
			} 
			doAjax({
				url : "/admin/stat/saveStatStddItmOrder.do",
				params : "ibsSaveJson=" + JSON.stringify(sheet.GetSaveJson(0)),
				succUrl : "/admin/stat/statStddItmPage.do",
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
/**
 * 트리 자식 데이터 로드
 */
function sheet_OnTreeChild(row) {
	var itmId = sheet.GetCellValue(row, "itmId");
	sheet.DoSearchChild(row, com.wise.help.url("/admin/stat/statStddItmList.do"), "parItmId="+itmId, {wait:1});
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
function regUserFunction() {
	var formObj = getTabFormObj("stddItm-dtl-form");
	formObj.find("input[name=parItmId]").val("0");	//등록시 처음에 상위항목구분 선택 안했을경우 최상위 레벨로 등록됨
	formObj.find("input[name=parItmNm]").val("최상위");
}
//상세 탭 이벤트
function tabEvent(row){//탭 이벤트 실행  
	var title = sheet.GetCellValue(row, "itmNm");//탭 제목
	var id = sheet.GetCellValue(row, "itmId");//탭 id(유일한key))
	openTab.SetTabData(sheet.GetRowJson(row));//db data 조회시 조건 data
	var url =  com.wise.help.url('/admin/stat/statStddItmDtl.do'); // Controller 호출 url 
	openTab.addTab(id, title, url, tabCallBack); 	// 탭 추가 시작함
} 

////////////////////////////////////////////////////////////////////////////////
//시트 로드
////////////////////////////////////////////////////////////////////////////////
function loadSheet() {
	
	createIBSheet2(document.getElementById("sheet"),"sheet", "100%", "300px");
	
	var gridTitle ="NO";
	gridTitle +="|상태";
	gridTitle +="|항목분류ID";
	gridTitle +="|한글 항목분류명";
	gridTitle +="|영문 항목분류명";
	gridTitle +="|분류 전체명";
	gridTitle +="|표준위치코드";
	gridTitle +="|레벨";
	gridTitle +="|순서";
	gridTitle +="|사용여부";
	
	with(sheet){
		                     
		//var cfg = {SearchMode:2,Page:50,VScrollMode:1};
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
					,{Type:"Text",		SaveName:"itmId",		Width:70,	Align:"Center",		Edit:false}
					,{Type:"Text",		SaveName:"itmNm",		Width:250,	Align:"Left",		Edit:true,	TreeCol:1}
					,{Type:"Text",		SaveName:"engItmNm",	Width:200,	Align:"Left",		Edit:true}
					,{Type:"Text",		SaveName:"itmFullnm",	Width:300,	Align:"Left",		Edit:false,	Hidden:true}
					,{Type:"Text",		SaveName:"geoCd",		Width:100,	Align:"Left",		Edit:false}
					,{Type:"Int",		SaveName:"Level",		Width:60,	Align:"Center",		Edit:false,	Hidden:true}
					,{Type:"Int",		SaveName:"vOrder",		Width:60,	Align:"Center",		Edit:false,	Hidden:false}
					,{Type:"Combo",		SaveName:"useYn",		Width:60,	Align:"Center",		Edit:false, TrueValue:"N", FalseValue:"Y"}
	            ];                                          
	    InitColumns(cols);
	    FitColWidth();
	    SetExtendLastCol(1);
	    
	    initSheetOptions("sheet", 0, "useYn", [{code:"Y",name:"사용"}, {code:"N",name:"미사용"}]);
	    
	    //ShowTreeLevel(0, 1);
	    //SetCountPosition(0);
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
	//표준항목은 검색어의 상위항목에 대한 하위항목이 모두 나오기 때문에 순서관련 버튼 숨기지 않음.
	//toggleShowHideOrderBtn("statMainForm");	//검색어가 있을경우 순서 관련 버튼 숨김
}
////////////////////////////////////////////////////////////////////////////////
//이벤트 함수
////////////////////////////////////////////////////////////////////////////////
/**
 * 탭 이벤트를 바인딩한다.
 */
function setTabButton() {
	var formObj = getTabFormObj("stddItm-dtl-form");
	
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
	formObj.find("button[name=itm_pop]").bind("click", function() {
		//상위 항목 팝업
		doAction("itmPop");
	});
	formObj.find("button[name=itm_init]").bind("click", function() {
		//상위 항목 초기화
		doAction("itmInit");
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
	var formObj = objTab.find("form[name=stddItm-dtl-form]");
	
	if ( com.wise.util.isNull(formObj.find("input[name=itmNm]").val()) ) {
		alert("항목분류명을 입력하세요.");
		formObj.find("input[name=itmNm]").focus();
		return false;
	}
	if ( formObj.find("input[name=parItmId]").val() != "0" && com.wise.util.isNull(formObj.find("input[name=parItmId]").val()) ) {
		alert("상위 항목 분류를 선택하세요.");
		formObj.find("button[name=itm_pop]").focus();
		return false;
	}
	if ( com.wise.util.isNull(formObj.find("input[name=vOrder]").val()) && !com.wise.util.isNumeric(formObj.find("input[name=vOrder]").val()) ) {
		alert("숫자형식이 아닙니다.");
		formObj.find("input[name=vOrder]").val("").focus();
		return false;
	}
	if ( !com.wise.util.isNull(formObj.find("input[name=geoCd]").val()) && !com.wise.util.isAlphaNumeric(formObj.find("input[name=geoCd]").val()) ) {
		alert("영문, 숫자형식만 입력하세요.");
		formObj.find("input[name=geoCd]").val("").focus();
		return false;
	}
	if ( com.wise.util.isNull(formObj.find("input[name=useYn]:checked").val()) ) {
		alert("사용여부를 선택하세요.");
		formObj.find("input[name=useYn]").focus();
		return false;
	}
	return true;
}

