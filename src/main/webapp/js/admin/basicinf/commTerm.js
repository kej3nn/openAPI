/**
 * 관리자 - 동의어 관리 스크립트 파일이다
 *
 * @author JHKIM
 * @version 1.0 2019/11/12
 */
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
}

/**
 * 이벤트를 바인딩한다.
 */
function bindEvent() {
	$("#btn_inquery").bind("click", function() {
		doAction('search');
		return false;
	});
	
	$("input[name=termNm]").bind("keydown", function(event) {
		if ( event.which == 13 ) {
			doAction('search');
			return false;
		}
	});
	
	$("#a_add").bind("click", function() {
		doAction('addrow');
		return false;
	});
	
	$("#a_save").bind("click", function() {
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
	createIBSheet2(document.getElementById("mainSheet"),"mainSheet", "100%", "500px");
	
	var gridTitle = "NO|상태|삭제|용어고유번호|용어구분|용어명|연결용어명|설명|사용여부";
	
	with(mainSheet){
        
		var cfg = {SearchMode:2,Page:50,VScrollMode:1};
	    SetConfig(cfg);
	    var headers = [
	                {Text:gridTitle, Align:"Center"}
	            ];
	    var headerInfo = {Sort:0,ColMove:1,ColResize:1,HeaderCheck:0};
	    
	    InitHeaders(headers, headerInfo);
	   
	    var cols = [
	                 {Type:"Seq",		SaveName:"seq",				Width:30,	Align:"Center",	Edit:false}
	                ,{Type:"DelCheck",	SaveName:"delChk",			Width:40,	Align:"Center",	Edit:true}
	                ,{Type:"Status",	SaveName:"status",			Width:40,	Align:"Center",	Edit:false,	Hidden: false}  
	                ,{Type:"Int",		SaveName:"termSeq",			Width:30,	Align:"Center",	Edit:false,	Hidden: true} 
	                ,{Type:"Combo",		SaveName:"termTagCd",		Width:90,	Align:"Center",	Edit:false, KeyField: true}
	                ,{Type:"Text",		SaveName:"termNm",			Width:120,	Align:"Left",	Edit:true,  KeyField: true}
	                ,{Type:"Text",		SaveName:"relTermNm",		Width:120,	Align:"Left",	Edit:true,  KeyField: true}
					,{Type:"Text",		SaveName:"termCont",		Width:250,	Align:"Left",	Edit:true}
					,{Type:"Combo",		SaveName:"useYn",			Width:80,	Align:"Center",	Edit:true}
	            ];                                          
	    InitColumns(cols);
	    FitColWidth();
	    SetExtendLastCol(1);
	    
	    loadSheetOptions("mainSheet", 0, "termTagCd", "/admin/stat/ajaxOption.do", {grpCd:"C1017"});	// 용어구분코드
	    SetColProperty(0, "useYn",	{ ComboCode: "Y|N", ComboText: "예|아니오" });
	}               
	default_sheet(mainSheet);
}

////////////////////////////////////////////////////////////////////////////////
// 서비스 함수
////////////////////////////////////////////////////////////////////////////////
function doAction(action) {
	var formObj = $("form[name=form]");
	
	if ( _.isEqual(action, "search") ) {
		var param = formObj.serialize();
		mainSheet.DoSearch(com.wise.help.url("/admin/basicinf/selectCommTerm.do"), param);
	}
	else if ( _.isEqual(action, "addrow") ) {
		var row = mainSheet.DataInsert(0);
		mainSheet.SetCellValue(row, "termTagCd", $("select[name=termTagCd]").val());
		mainSheet.ReNumberSeq();
	}
	else if ( _.isEqual(action, "save") ) {
		var dupRows = mainSheet.ColValueDupRows("termNm|relTermNm")
		if ( dupRows != "" || false ) {
			alert("[" + dupRows + "]번째 행에 동의어와 연관동의어가 중복되는 값이 있습니다.");
			
			var splitDupRow = dupRows.split(',');
			mainSheet.SetSelectRow(splitDupRow[0]);
			return false;
		}
		
		saveSheetData({
            SheetId: "mainSheet",
            PageUrl: "/admin/basicinf/saveCommTerm.do"
        }, {
        }, {
            AllSave:0
        });
	}
}

/**
 * 서버로부터 데이터를 받은 후 수행되는 함수
 */
function mainSheet_OnLoadData(data) {
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