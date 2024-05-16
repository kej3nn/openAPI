/**
 * 관리자 - 국회의원 URL 관리 스크립트 파일이다
 *
 * @author JHKIM
 * @version 1.0 2019/11/12
 */
var DEFAULT_URL = window.location.protocol + "//" + window.location.host + "/21stMembers/";

$(function() {
    // 컴포넌트를 초기화한다.
    initComp();
    
    // 이벤트를 바인딩한다.
    bindEvent();
    
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
	// 시트 초기화
	loadMainSheet();
	
	doAction("search");
}

/**
 * 이벤트를 바인딩한다.
 */
function bindEvent() {
	$("#btn_inquery").bind("click", function() {
		doAction('search');
		return false;
	});
	
	$("input[name=searchVal]").bind("keydown", function(event) {
		if ( event.which == 13 ) {
			doAction('search');
			return false;
		}
	});
	
	$("#btn_save").bind("click", function() {
		doAction('save');
		return false;
	});
}

/**
 * 데이터를 로드한다.
 */
function loadData() {
	doAction('search');
}

////////////////////////////////////////////////////////////////////////////////
// 시트 관련 함수
////////////////////////////////////////////////////////////////////////////////
function loadMainSheet() {
	createIBSheet2(document.getElementById("sheet"), "sheet", "100%", "500px");
	
	var gridTitle = "NO|상태|의원명|정당|기본URL|URL코드|바로가기|의원코드";
	
	with(sheet){
        
		var cfg = {SearchMode:3,Page:50,VScrollMode:1};
	    SetConfig(cfg);
	    var headers = [
	                {Text:gridTitle, Align:"Center"}
	            ];
	    var headerInfo = {Sort:0,ColMove:1,ColResize:1,HeaderCheck:0};
	    
	    InitHeaders(headers, headerInfo);
	   
	    var cols = [
	                 {Type:"Seq",		SaveName:"seq",				Width:30,	Align:"Center",	Edit:0}
	                ,{Type:"Status",	SaveName:"status",			Width:40,	Align:"Center",	Edit:0}
	                ,{Type:"Text",		SaveName:"hgNm",			Width:200,	Align:"Center",	Edit:0}
	                ,{Type:"Text",		SaveName:"polyNm",			Width:160,	Align:"Center",	Edit:0} 
	                ,{Type:"Text",		SaveName:"defaultUrl",		Width:220,	Align:"Left",	Edit:0}
	                ,{Type:"Text",		SaveName:"openNaId",		Width:150,	Align:"Left",	Edit:1,	EditLen: 50, KeyField: 1, AcceptKeys:"N|E|[@.-_]"}
					,{Type:"Button",	SaveName:"btnLink",			Width:80,	Align:"Center",	Edit:0}
					,{Type:"Text",		SaveName:"empNo",			Width:30,	Align:"Center",	Edit:0,	Hidden: 1} 
	            ];                                          
	    InitColumns(cols);
	    FitColWidth();
	    SetExtendLastCol(1);
	}               
	default_sheet(sheet);
	sheet.SetBasicImeMode(2);
}

////////////////////////////////////////////////////////////////////////////////
// 서비스 함수
////////////////////////////////////////////////////////////////////////////////
function doAction(action) {
	var formObj = $("form[name=form]");
	
	if ( _.isEqual(action, "search") ) {
		var param = {PageParam: "page", Param: "rows=50"+"&"+formObj.serialize()};
		sheet.DoSearchPaging(com.wise.help.url("/admin/nadata/assm/searchNaAssmMemberUrl.do"), param);
	}
	else if ( _.isEqual(action, "save") ) {
		saveSheetData({
            SheetId: "sheet",
            PageUrl: "/admin/nadata/assm/saveNaAssmMemberUrl.do"
        }, {
        }, {
            AllSave:0
        });
	}
}

/**
 * 서버로부터 데이터를 받은 후 수행되는 함수
 */
function sheet_OnLoadData(data) {
	var data = JSON.parse(data);
	if (data.success) {
        if (data.success.message) {
            alert(data.success.message);
            doAction("search");
        }
    } else if (data.error) {
    	if (data.error.message) {
    		alert(data.error.message);
    	}
    }
}

/**
 * 시트 클릭
 * @param row
 * @param col
 * @returns
 */
function sheet_OnClick(row, col) {
	// 헤더행은 제외하고 바로가기 버튼 클릭했을경우
	if ( sheet.HeaderRows() <= row && sheet.SaveNameCol("btnLink") === col ) {
		if ( sheet.GetCellValue(row, "status") === "R" ) {
			var url = sheet.GetCellValue(row, "defaultUrl") + sheet.GetCellValue(row, "openNaId");
			window.open(url, 'assmMemberUrl','height=' + screen.height + ',width=' + screen.width + 'fullscreen=yes');
		}
		else if ( sheet.GetCellValue(row, "status") === "U" ) {
			alert("코드가 수정중인 상태에서는 바로가기 할 수 없습니다.");
		}
	}
}