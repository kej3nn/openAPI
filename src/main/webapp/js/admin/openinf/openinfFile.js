/**
 * 공공데이터 파일서비스 등록 스크립트 파일이다
 *
 * @author JHKIM
 * @version 1.0 2020/01/06
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
// 파일시트 갯수
var GC_FILE_SHEET_CNT = 0;

////////////////////////////////////////////////////////////////////////////////
// 초기화 함수
////////////////////////////////////////////////////////////////////////////////
/**
 * 컴포넌트를 초기화한다.
 */
function initComp() {
	tabSet();
	
	loadMstSheet();
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
 * 메인화면 액션
 */
function doAction(sAction) {
	var formObj = $("form[name=mstForm]");
	var dtlFormObj = getTabFormObj("dtlForm");
	
	switch(sAction) {                       
		case "search":
			var param = {PageParam: "page", Param: "onepagerow=50"+"&"+formObj.serialize()};
			mainSheet.DoSearchPaging(com.wise.help.url("/admin/openinf/selectOpenInfSrvList.do"), param);
			
			initDtlInfo();
			break;
		case "metaDtl":
 			var infId = dtlFormObj.find("input[name=infId]").val();                  
			var target = "/admin/openinf/popup/openInfViewPopUp.do?infId="+infId;
			var wName = "metaview";        
			var wWidth = "1024";
			var wHeight = "580";                            
			var wScroll ="no";
			OpenWindow(target, wName, wWidth, wHeight, wScroll);                     
			break;
		case "reg" :
			var title = "신규등록"
			var id ="openUsrDefReg";
			openTab.addRegTab(id, title, tabCallRegBack);
			break;
		case "update" :
			if ( com.wise.util.isEmpty(dtlFormObj.find("input[name=fileSeq]").val()) ) {
				alert("수정할 행을 선택해 주시기 바랍니다.");
				return false;
			}
			updateData();
			break;
			
		case "delete" :
			if ( !confirm("삭제 하시겠습니까?") )	return false
			
			doAjax({
				url: "/admin/openinf/deleteOpeninfFile.do",
				params: dtlFormObj.serializeObject(),
				callback: function(res) {
					doActionFile("select");
				}
			});
			break;
	}
}

/**
 * 파일 관련 액션
 * @param sAction
 * @returns
 */
function doActionFile(sAction) {
	var formObj = getTabFormObj("dtlForm");
	var tabSheetNm = formObj.find("input[name=fileSheetNm]").val();
	var sheetObj = window[tabSheetNm];
	
	switch(sAction) {     
		case "select" :
			var param = formObj.serialize();
			sheetObj.DoSearch(com.wise.help.url("/admin/openinf/selectOpenInfFileList.do"), param);
			break;
		case "add":
			addFile(formObj);
			break;
		case "moveUp":
			sheetDataMove(sheetObj, "up");
			break;	
		case "moveDown":
			sheetDataMove(sheetObj, "down");
			break;
		case "saveOrder":
			var params = "sheetData=" + encodeURIComponent(JSON.stringify(sheetObj.GetSaveJson().data));
			doAjax({
				url: "/admin/openinf/saveOpenInfFileOrder.do",
				params: params,
				callback : function() {
					doActionFile("select");
				}
			});
			break;
	}
}
////////////////////////////////////////////////////////////////////////////////
//시트 로드
////////////////////////////////////////////////////////////////////////////////
function loadMstSheet() {
	createIBSheet2(document.getElementById("mainSheet"), "mainSheet", "100%", "400px");
	
	var options = {};
	
	var sheet = window["mainSheet"];
	
	options.Cfg = {
		MergeSheet: msHeaderOnly, Page: 10, SearchMode: smServerPaging, VScrollMode: 1
	};
	options.HeaderMode = {
		Sort: 1, ColMove: 0, ColReSize: 1
	};
	
	var cols = [          
		 {Type:"Seq",	Header: "NO",			SaveName:"no",				Width:30,	Align:"Center",		Edit:false}
		,{Type:"Text",	Header: "공공데이터ID",	SaveName:"infId",			Width:100,	Align:"Center",		Edit:false}
		,{Type:"Int",	Header: "SEQ",			SaveName:"seq",				Width:100,	Align:"Center",		Edit:false, Hidden:true}
		,{Type:"Int",	Header: "공공데이터SEQ",SaveName:"infSeq",			Width:100,	Align:"Center",		Edit:false, Hidden:true} 
		,{Type:"Text",	Header: "보유데이터명",	SaveName:"dtNm",			Width:200,	Align:"Left",		Edit:false, Hidden:true}
		,{Type:"Text",	Header: "공공데이터명",	SaveName:"infNm",			Width:200,	Align:"Left",		Edit:false}
		,{Type:"Text",	Header: "데이터셋 구분",SaveName:"cateNm",			Width:0,	Align:"Left",		Edit:false, Hidden:true}
		,{Type:"Text",	Header: "분류",			SaveName:"cateFullnm",		Width:120,	Align:"Left",		Edit:false}
		,{Type:"Text",	Header: "담당부서",		SaveName:"orgNm",			Width:100,	Align:"Left",		Edit:false}
		,{Type:"Text",	Header: "이용허락조건",	SaveName:"cclNm",			Width:90,	Align:"Left",		Edit:false}
		,{Type:"Html",	Header: "서비스",		SaveName:"openSrv",			Width:70,	Align:"Left",		Edit:false, Hidden:true}
		,{Type:"Text",	Header: "개방일",		SaveName:"openDttm",		Width:70,	Align:"Center",		Edit:false, Format:"Ymd" }
		,{Type:"Combo",	Header: "개방상태",		SaveName:"infState",		Width:70,	Align:"Center",		Edit:false, Hidden:true}
	];   
	options.Cols = cols;
	
	initSheetOptions("mainSheet", 0, "infState", {
		ComboCode: ["N","Y","X","C"],
		ComboText: ["미개방","개방","개방불가","개방취소"],
	});
	
	IBS_InitSheet(sheet, options);
	
	sheet.FitColWidth();
	sheet.SetExtendLastCol(1);
	               
	default_sheet(sheet);   
}

/**
 * 탭내의 파일시트 생성 
 */
function fileSheetCreate() {
	++GC_FILE_SHEET_CNT;
	var sheetNm = "fileSheet"+GC_FILE_SHEET_CNT;
	$("div[name=fileSheet]").eq(1).attr("id", "DIV_"+sheetNm);    
	createIBSheet2(document.getElementById("DIV_"+sheetNm),sheetNm, "100%", "300px");
	
	var sheetObj = window[sheetNm]; 
	var formObj = getTabFormObj("dtlForm");
 	formObj.find("input[name=fileSheetNm]").val(sheetNm);
 	loadFileSheet(sheetNm, sheetObj);
 	
 	window[sheetNm + "_OnSelectCell"] = fileSheetOnSelectCell;	// 셀 변경 이벤트
}

/**
 * 파일시트 셀 선택시 상세내용 표시 
 */
function fileSheetOnSelectCell(orow, ocol, row, col) {
	if (row == 0) return; //헤더행일때는 폼에 반영 안함.
	var formObj = getTabFormObj("dtlForm");
	var tabSheetNm = formObj.find("input[name=fileSheetNm]").val();
	var sheetObj = window[tabSheetNm];
	
    var obj = sheetObj.GetRowData(row),
        elem = null;
    for (elem in obj) {
    	
        if ($("[name="+elem+"]")[0]) {
        	$("[name="+elem+"]").val(obj[elem]);
        }
    }
    
    // 파일 초기화
	var agent = navigator.userAgent.toLowerCase();
	if ( (navigator.appName == 'Netscape' && navigator.userAgent.search('Trident') != -1) || (agent.indexOf("msie") != -1) ){
		formObj.find("input[name=atchFile]").replaceWith( formObj.find("input[name=atchFile]").clone(true) );
	}
	else {
		formObj.find("input[name=atchFile]").val("");
	}
	
	formObj.find("#btnFileDown").text("");
	if ( !com.wise.util.isNull(obj["viewFileNm"]) && !com.wise.util.isNull(obj["fileExt"]) ) {
		formObj.find("#btnFileDown").text(obj["viewFileNm"]+"."+obj["fileExt"]);
	}
	
	formObj.find("a[name=a_reg]").hide();
	formObj.find("a[name=a_modify], a[name=a_del], button[name=fileInit]").show();
}

/**
 * 파일 시트 로드
 */
function loadFileSheet(sheetNm, sheetObj) {
	
	var options = {};
	options.Cfg = { SearchMode: 2, Page: 50, VScrollMode: 1};
	options.HeaderMode = { Sort: 1, ColMove: 0, ColReSize: 1, HeaderCheck: 0 };
	options.Cols = [
		{Type:"Status",			Header: "상태", 			SaveName:"Status",			Width:40,	Align:"Center",		Edit:false}               
		,{Type:"Seq",			Header: "No", 			SaveName:"rownum",			Width:30,	Align:"Center",		Edit:false}
		//,{Type:"DelCheck",		Header: "삭제", 		SaveName:"delChk",			Width:10,	Align:"Center",		Edit:false}               
		,{Type:"Text",			Header: "공공데이터ID",	SaveName:"infId",			Width:30,	Align:"Right",		Edit:false, Hidden:true}
		,{Type:"Int",			Header: "공공데이터SEQ",SaveName:"infSeq",			Width:30,	Align:"Right",		Edit:false,	Hidden:true}
		,{Type:"Int",			Header: "파일고유번호",	SaveName:"fileSeq",			Width:30,	Align:"Right",		Edit:false,	Hidden:true}
		,{Type:"Text",			Header: "원본파일명",	SaveName:"srcFileNm",		Width:100,	Align:"Left",		Edit:false, Hidden:true}
		//,{Type:"Text",		Header: "",	SaveName:"dpSrcFileNm",		Width:100,	Align:"Left",		Edit:false, Hidden:true}
		,{Type:"Text",			Header: "저장파일명",	SaveName:"saveFileNm",		Width:200,	Align:"Left",		Edit:false,	Hidden:true}
		,{Type:"Text",			Header: "출력파일명",	SaveName:"viewFileNm",		Width:200,	Align:"Left",		Edit:false}
		//,{Type:"Text",		Header: "",	SaveName:"dpViewFileNm",		Width:100,	Align:"Left",		Edit:false, Hidden:true}
		,{Type:"Int",			Header: "파일사이즈",	SaveName:"fileSize",		Width:90,	Align:"Right",		Edit:false}
		,{Type:"Text",			Header: "파일확장자",	SaveName:"fileExt",			Width:70,	Align:"Center",		Edit:false}
		,{Type:"Text",			Header: "작성자",		SaveName:"wrtNm",			Width:70,	Align:"Center",		Edit:false}
		,{Type:"Text",			Header: "최초생성일",	SaveName:"ftCrDttm",		Width:100,	Align:"Center",		Edit:false}
		,{Type:"Text",			Header: "최종수정일",	SaveName:"ltCrDttm",		Width:100,	Align:"Center",		Edit:false} 
		,{Type:"CheckBox",		Header: "사용여부",		SaveName:"useYn",			Width:60,	Align:"Center",		Edit:false, TrueValue:"Y", FalseValue:"N"}
		,{Type:"Int",			Header: "순서",			SaveName:"vOrder",			Width:70,	Align:"Center",		Edit:false, Hidden:true}
	];
	
	IBS_InitSheet(sheetObj, options);
	sheetObj.FitColWidth();
	sheetObj.SetExtendLastCol(1);
	 
	default_sheet(sheetObj);  
	
	doActionFile("select");
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

// 데이터 등록
function regUserFunction() {
	fileSheetCreate();
	
	initDtlInfo();
	
}
/**
 * 시트 더블클릭시 이벤트
 * @param row
 * @returns
 */
function tabEvent(row) {
	var formObj = getTabFormObj("dtlForm");
	
	var id = mainSheet.GetCellValue(row, "infId");
	var title = mainSheet.GetCellValue(row, "infNm");
	
	openTab.SetTabData(mainSheet.GetRowJson(row));
	openTab.addTab(id, title, "/admin/openinf/selectOpenInfSrvDtl.do", function(tab) {
		setTabButton(); 
		tabFunction(tab); 
	}); 
	
	// 파일 시트 생성
	fileSheetCreate();
}

/**
 * 탭 상세
 * @param tab	탭 객체
 * @returns
 */
function tabFunction(tab) {
	var formObj = getTabFormObj("dtlForm");
	var obj = tab.TabData;
	
	var elem = null;
	
	// 날짜
	datepickerInitTab(formObj.find("input[name=ftCrDttm]"));
	datepickerInitTab(formObj.find("input[name=ltCrDttm]"));
	formObj.find("input[name=ftCrDttm]").datepicker(setCalendarView('yy-mm-dd'));           
	formObj.find("input[name=ltCrDttm]").datepicker(setCalendarView('yy-mm-dd'));      
	datepickerTrigger();  
		
	for (elem in obj) {
	    if ( tab.ContentObj.find("[name=" + elem + "]")[0]) {
	    	tab.ContentObj.find("[name=" + elem + "]").val(obj[elem]);
	    }
	}
	
	// 탭 생성시 등록버튼 숨김
	formObj.find("a[name=a_reg]").hide();
}

////////////////////////////////////////////////////////////////////////////////
//시트 서비스 함수
////////////////////////////////////////////////////////////////////////////////
function mainSheet_OnDblClick(row, col, value) {
	if ( row < 1 ) return;
	
	tabEvent(row);
}

/**
 * 파일 추가 액션
 */
function addFile(formObj) {
	
	formObj.ajaxSubmit({
		url : com.wise.help.url("/admin/openinf/insertOpeninfFile.do")
		, async : false
		, type : 'post'
		, dataType: 'json' 
		, contentType : 'application/x-www-form-urlencoded;charset=UTF-8'
		, beforeSubmit : function() {
			if ( com.wise.util.isBlank(formObj.find("[name=atchFile]").val()) ) {
				alert("파일을 선택하세요");
				return false;
			} 
			else if ( com.wise.util.isBlank(formObj.find("[name=viewFileNm]").val()) ) {
				alert("출력파일명을 입력하세요");
				return false;
			}
			else if ( com.wise.util.isBlank(formObj.find("[name=ftCrDttm]").val()) ) {
				alert("최초생성일을 선택하세요");
				return false;
			}
			else if ( com.wise.util.isBlank(formObj.find("[name=ltCrDttm]").val()) ) {
				alert("최종수정일을 선택하세요");
				return false;
			}
			else {
				return true;
			}
		}	
		, success : function(res, status) {
			doAjaxMsg(res, "");
			doActionFile("select");
			initDtlFile();
			
			formObj.find("a[name=a_reg]").hide();
			formObj.find("a[name=a_modify]").show();
		}
		, error: function(jqXHR, textStatus, errorThrown) {
			alert("처리 도중 에러가 발생하였습니다.");
			initDtlFile();
		}
	});
}

/**
 * 데이터 수정
 */
function updateData() {
	var formObj = getTabFormObj("dtlForm");
 	
	formObj.ajaxSubmit({
		url : com.wise.help.url("/admin/openinf/updateOpeninfFile.do")
		, async : false
		, type : 'post'
		, dataType: 'json' 
		, contentType : 'application/x-www-form-urlencoded;charset=UTF-8'
		, beforeSubmit : function() {
			if ( com.wise.util.isBlank(formObj.find("[name=viewFileNm]").val()) ) {
				alert("출력파일명을 입력하세요");
				return false;
			}
			else if ( com.wise.util.isBlank(formObj.find("[name=ftCrDttm]").val()) ) {
				alert("최초생성일을 선택하세요");
				return false;
			}
			else if ( com.wise.util.isBlank(formObj.find("[name=ltCrDttm]").val()) ) {
				alert("최종수정일을 선택하세요");
				return false;
			}
			else {
				return true;
			}
		}	
		, success : function(res, status) {
			doAjaxMsg(res, "");
			doActionFile("select");
			initDtlFile();
		}
		, error: function(jqXHR, textStatus, errorThrown) {
			alert("처리 도중 에러가 발생하였습니다.");
			initDtlFile();
		}
	});
}
