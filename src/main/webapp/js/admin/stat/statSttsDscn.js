/*
 * @(#)statSttsDscn.js 1.0 2017/09/07
 * 
 * COPYRIGHT (C) 2013 WISEITECH CO., LTD. ALL RIGHTS RESERVED.
 */

/**
 * 관리자 연계정보설정 스크립트 파일이다
 *
 * @author 김정호
 * @version 1.0 2017/09/07
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
	$("button[name=rowAdd]").bind("click", function(event) {
		doAction("rowAdd");
    });
	
	$("a[name=a_save]").bind("click", function(event) {
		doAction("update");
    });
	
	
}


/**
 * 옵션을 로드한다.
 */
function loadOptions() {
	initSheetOptions("sheet", 0, "useYn", 
    		[{code:"Y",name:"예"}, {code:"N",name:"아니오"}]);	//사용여부
    loadSheetOptions("sheet", 0, "dscntyCd", "/admin/stat/ajaxOption.do", 	{grpCd:"D2002"});	//연계방식 구분코드
    
    $.post(
            com.wise.help.url("/admin/stat/ajaxOption.do"),
            {grpCd:"D2001"},
            function(data, status, request) {
                if (data.data) {
                    // 시트 옵션을 초기화한다.
                    initSheetOptions("sheet", 0, "ownerCd", [{code:"",name:""}].concat(data.data));
                    initSheetOptions("sheet", 0, "srcOwnerCd", [{code:"",name:""}].concat(data.data));
                }
            },
            "json"
        );
    
    //loadSheetOptions("sheet", 0, "ownerCd", "/admin/stat/ajaxOption.do", 	{grpCd:"D2001"});	//대상 owner 구분코드
    //loadSheetOptions("sheet", 0, "srcOwnerCd", "/admin/stat/ajaxOption.do", {grpCd:"D2001"});	//원본 owner 구분코드
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
	var sheet = window["sheet"];

	switch(sAction) {                       
		case "search":
		    loadSheetData({
		        SheetId:"sheet",
		        PageUrl:"/admin/stat/statSttsDscnList.do"
		    }, {
		        ObjectParam : mainFormObj.serialize(),
		        FormParam:"statMainForm"
		    }, {
		        // Nothing to do.
		    });
			break;
		case "rowAdd" :
			var newRow = sheet.DataInsert(-1);	//제일 마지막 행에 추가
			sheet.SetCellEditable(newRow, "dscnId", true);	//추가한 행의 데이터셋 연계id는 수정가능 하도록 변경
			break;
		case "update" :
			saveSheetData({
                SheetId:"sheet",
                PageUrl:"/admin/stat/saveSttsDscn.do"
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

////////////////////////////////////////////////////////////////////////////////
//시트 로드
////////////////////////////////////////////////////////////////////////////////
function loadSheet() {
	
	createIBSheet2(document.getElementById("sheet-sect"),"sheet", "100%", "300px");
	
	var gridTitle ="NO";
	gridTitle +="|상태";
	gridTitle +="|삭제";
	gridTitle +="|데이터셋연계ID";
	gridTitle +="|데이터셋연계명";
	gridTitle +="|연계방식";
	gridTitle +="|대상 OWNER";
	gridTitle +="|대상 테이블";
	gridTitle +="|원본 OWNER";
	gridTitle +="|원본 테이블";
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
	                { Type:"Seq",		SaveName:"seq",   		Hidden:0, Width:50,		Align:"Center", 	Sort:0, Edit:1, KeyField:0},
			        { Type:"Status", 	SaveName:"Status",   	Hidden:0, Width:50, 	Align:"Center",		Sort:0, Edit:1, KeyField:0},
			        { Type:"DelCheck",	SaveName:"del", 		Hidden:0, Width:50,		Align:"Center", 	Sort:0, Edit:1, KeyField:0},
			        { Type:"Int",  		SaveName:"dscnId", 		Hidden:0, Width:90, 	Align:"Left", 		Sort:0, Edit:0, KeyField:0, EditLen:5},
			        { Type:"Text",  	SaveName:"dscnNm", 		Hidden:0, Width:170,	Align:"Left", 		Sort:0, Edit:1, KeyField:1},
			        { Type:"Combo",  	SaveName:"dscntyCd",   	Hidden:0, Width:90, 	Align:"Center", 	Sort:0, Edit:1, KeyField:1},
			        { Type:"Combo",  	SaveName:"ownerCd",   	Hidden:0, Width:90, 	Align:"Left", 		Sort:0, Edit:1, KeyField:1},
			        { Type:"Text",  	SaveName:"dsId",   		Hidden:0, Width:90, 	Align:"Left",   	Sort:0, Edit:1, KeyField:1},
			        { Type:"Combo",  	SaveName:"srcOwnerCd",  Hidden:0, Width:90, 	Align:"Left",   	Sort:0, Edit:1, KeyField:0},
			        { Type:"Text",  	SaveName:"srcDsId",  	Hidden:0, Width:90, 	Align:"Left",  		Sort:0, Edit:1, KeyField:0},
			        { Type:"Combo",  	SaveName:"useYn",    	Hidden:0, Width:60, 	Align:"Center",   	Sort:0, Edit:1, KeyField:1}
	            ];                                          
	    InitColumns(cols);
	    FitColWidth();
	    SetExtendLastCol(1);
	}               
	default_sheet(sheet);   
}
////////////////////////////////////////////////////////////////////////////////
//시트 서비스 함수
////////////////////////////////////////////////////////////////////////////////
function sheet_OnLoadData(data) {
	var data = JSON.parse(data);
	if ( data.success != null) {
		//시트 분류명 저장이 성공적으로 완료된 경우
		alert(data.success.message);
		doAction("search");
	}
}
////////////////////////////////////////////////////////////////////////////////
//이벤트 함수
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
//Validation 함수
////////////////////////////////////////////////////////////////////////////////
