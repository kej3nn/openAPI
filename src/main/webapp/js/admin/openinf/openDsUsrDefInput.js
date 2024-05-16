/*
 * @(#)openDsUsrDefInput.js 1.0 2019/09/26
 */

/**
 * 데이터셋 사용자정의 입력 스크립트 파일이다
 *
 * @author JHKIM
 * @version 1.0 2019/09/26
 */
$(function() {
    // 컴포넌트를 초기화한다.
    initComp();
    
    // 마스크를 바인딩한다.
    bindMask();
    
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
	
	loadMstSheetCol();
	
	initDtlInfoControl();
}

/**
 * 마스크를 바인딩한다.
 */
function bindMask() {
}

/**
 * 데이터를 로드한다.
 */
function loadData() {
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
			mainSheet.DoSearchPaging(com.wise.help.url("/admin/openinf/opends/openDsUsrDefData.do"), param);
			
//			initDtlInfo();
			break;
			
		case "reg" :
			var title = "신규등록"
			var id ="openUsrDefReg";
			openTab.addRegTab(id, title, tabCallRegBack);
			break;
		case "insert" :
			saveData("I");
			
			break;
			
		case "update" :
			saveData("U");
			break;
			
		case "delete" :
			if ( !confirm("데이터 전체가 삭제 됩니다.\n삭제 하시겠습니까?") )	return false
			
			doAjax({
				url: "/admin/openinf/opends/deleteOpenDsUsrDef.do",
				params: dtlFormObj.serialize(),
				callback: function(res) {
					if (res.success) {
						var tabOnId = $(".tab li.on").children(":eq(0)").attr("id") ;	//열려 있는 탭 id 찾기
						$("#"+tabOnId).closest("li").remove();							//열려 있는 탭 ID li 제거
					    $("a[id=tabs-main]").click();   //메인 탭 클릭 
					    $("button[name=btn_inquiry]").click();
					}
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
			sheetObj.DoSearch(com.wise.help.url("/admin/openinf/opends/selectOpenUsrDefFile.do"), param);
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
		case "saveOrder" :
			var params = "sheetData=" + encodeURIComponent(JSON.stringify(sheetObj.GetSaveJson().data));
			doAjax({
				url: "/admin/openinf/opends/saveOpenUsrDefFileOrder.do",
				params: params,
				callback : function() {
					doActionFile("select");
				}
			});
			break;
		case "download" :
			var downloadForm = $("#downloadForm");
			var dataSeqceNo = downloadForm.find("input[name=dataSeqceNo]").val();
			var fileSeq = downloadForm.find("input[name=fileSeq]").val();
			
			if ( com.wise.util.isNull(dataSeqceNo) && com.wise.util.isNull(fileSeq) ) {
				console.error("파라미터값 확인");
				return;
			}
			
			$("#downloadForm").submit()
			break;
		case "deleteFile" :
			if ( confirm("선택하신 파일을 삭제하시겠습니까?") ) {
				var params = "sheetData=" + encodeURIComponent(JSON.stringify(sheetObj.GetSaveJson().data));
				doAjax({
					url: "/admin/openinf/opends/deleteOpenUsrDefFile.do",
					params: params,
					callback : function() {
						doActionFile("select");
					}
				});
			}
			break;
	}
}
////////////////////////////////////////////////////////////////////////////////
//시트 로드
////////////////////////////////////////////////////////////////////////////////
function loadMstSheet(data) {
	createIBSheet2(document.getElementById("mainSheet"), "mainSheet", "100%", "500px");
	
	var options = {};
	
	var sheet = window["mainSheet"];
	
	options.Cfg = {
		MergeSheet: msHeaderOnly, Page: 10, SearchMode: smServerPaging, VScrollMode: 1
	};
	options.HeaderMode = {
		Sort: 1, ColMove: 0, ColReSize: 1
	};
	options.Cols = data;
	
	for ( var i in data ) {
		// 컬럼 참조코드가 정의된경우
		if ( !com.wise.util.isBlank(data[i].colRefCd) ) {
			loadSheetOptions("mainSheet", 0, data[i].SaveName, "/admin/stat/ajaxOption.do", {grpCd: data[i].colRefCd} );
		}
		// 등록일시 포맷적용
		if ( data[i].SaveName == "DATA_COLT_REG_DTTM" ) {
			data[i].Format = "YmdHm";
		}
	}
	
	IBS_InitSheet(sheet, options);
	
	sheet.FitColWidth();
	sheet.SetExtendLastCol(1);
	               
	default_sheet(sheet);   
}

function fileSheetCreate() {
	++GC_FILE_SHEET_CNT;
	var sheetNm = "fileSheet"+GC_FILE_SHEET_CNT;
	$("div[name=fileSheet]").eq(1).attr("id", "DIV_"+sheetNm);    
	createIBSheet2(document.getElementById("DIV_"+sheetNm),sheetNm, "100%", "200px");
	
	var sheetObj = window[sheetNm]; 
	var formObj = getTabFormObj("dtlForm");
 	formObj.find("input[name=fileSheetNm]").val(sheetNm);
 	loadFileSheet(sheetNm, sheetObj);
 	
 	window[sheetNm+ "_OnClick"] = fileSheetClick;
}

// 파일 시트 로드
function loadFileSheet(sheetNm, sheetObj) {
	
	var options = {};
	options.Cfg = { SearchMode: 2, Page: 50, VScrollMode: 1};
	options.HeaderMode = { Sort: 1, ColMove: 0, ColReSize: 1, HeaderCheck: 1 };
	options.Cols = [
			{ Header: "NO", 			Type: "Seq", 		SaveName: "seq", 		 width: 40, 	Align: "Center", 	Edit: false },
			{ Header: "상태", 			Type: "Status", 	SaveName: "Status", 	 width: 30, 	Align: "Center", 	Edit: true 	},
			{ Header: "삭제", 			Type: "DelCheck", 	SaveName: "delChk", 	 width: 30, 	Align: "Center", 	Edit: true  },
			{ Header: "고유번호",		Type: "Int", 		SaveName: "dataSeqceNo", width: 70,		Align: "Left", 		Edit: false ,	Hidden: true},
			{ Header: "파일번호",		Type: "Int", 		SaveName: "fileSeq",	 width: 70,		Align: "Left", 		Edit: false ,	Hidden: true},
			{ Header: "원본파일명",		Type: "Text", 		SaveName: "srcFileNm",	 width: 350,	Align: "Left", 		Edit: false},
			{ Header: "출력파일명",		Type: "Text", 		SaveName: "viewFileNm",	 width: 350,	Align: "Left", 		Edit: true },
			{ Header: "저장파일명",		Type: "Text", 		SaveName: "saveFileNm",	 width: 100,	Align: "Left", 		Edit: false ,	Hidden: true},
			{ Header: "파일크기",		Type: "Int", 		SaveName: "fileSize",	 width: 110, 	Align: "Center", 	Edit: false },
			{ Header: "확장자",			Type: "Text", 		SaveName: "fileExt",	 width: 90, 	Align: "Center", 	Edit: false },
			{ Header: "등록일",			Type: "Date", 		SaveName: "ftCrDttm",	 width: 70, 	Align: "Center", 	Edit: false, Format: "YmdHm" },
			{ Header: "순서",			Type: "Int", 		SaveName: "vOrder",	 	 width: 70, 	Align: "Center", 	Edit: false, Hidden: true },
			{ Header: "다운로드",		Type: "Text", 		SaveName: "downloadFile",width: 50,		Align: "Center", 	Edit: false ,	DefaultValue: "다운로드", FontUnderline : 1, FontColor : "blue", Cursor : "Pointer", FontBold: true},
		];
	
	IBS_InitSheet(sheetObj, options);
	sheetObj.FitColWidth();
	sheetObj.SetExtendLastCol(1);
	default_sheet(sheetObj);  
	
	doActionFile("select");
}

// 컬럼정보 로드(메인 헤더)
function loadMstSheetCol() {
	doSearch({
		url: "/admin/openinf/opends/openDsUsrDefHeaderData.do",
		before: beforeLoadMstSheetCol,
		after: afterLoadMstSheetCol
	});
}

// 컬럼정보 로드 전처리
function beforeLoadMstSheetCol(options) {
	var data = {};
	
	$.each($("form[name=mstForm]").serializeArray(), function(index, element) {
        switch (element.name) {
            case "dsId":	
                data[element.name] = element.value;
                break;
        }
    });
	return data;
	
}

// 컬럼정보 로드 후처리
function afterLoadMstSheetCol(datas) {
	
	loadMstSheet(datas);
	
	doAction("search");
}

/**
 * 파일시트 클릭 이벤트
 * @param row
 * @param col
 * @param value
 * @returns
 */
function fileSheetClick(row, col, value) {
	var formObj = getTabFormObj("dtlForm"),
 		sheetNm = formObj.find("input[name=fileSheetNm]").val(),
 		sheetObj = window[sheetNm],
 		downloadForm = $("#downloadForm");
	
	if ( col === sheetObj.SaveNameCol("downloadFile") ) {
		downloadForm.find("input").val("");
		var dataSeqceNo = sheetObj.GetCellValue(row, "dataSeqceNo");
		var fileSeq = sheetObj.GetCellValue(row, "fileSeq");
		
		downloadForm.find("input[name=dataSeqceNo]").val(dataSeqceNo);
		downloadForm.find("input[name=fileSeq]").val(fileSeq);
		
		doActionFile("download");
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

// 데이터 등록
function regUserFunction() {
	fileSheetCreate();
	
	initDtlInfo();
	
	setActionButton("I");
	
}

/**
 * 데이터 저장
 * @param action 등록/수정
 * @returns
 */
function saveData(action) {
	action = action || "";
	var url = "", msg = "";

	if ( action == "" ) return false;
	
	if ( action == "I" ) {
		url = "/admin/openinf/opends/insertOpenDsUsrDef.do";
		msg = "등록 하시겠습니까?";
	}
	else if ( action == "U" ) {
		url = "/admin/openinf/opends/updateOpenDsUsrDef.do";
		msg = "수정 하시겠습니까?";
	}
	else {
		return false;
	}
	
	var formObj = getTabFormObj("dtlForm");
	var tabSheetNm = formObj.find("input[name=fileSheetNm]").val();
	var sheetObj = window[tabSheetNm];
	
	if ( saveValidation() ) {
		ibsSaveJson = sheetObj.GetSaveJson();
		/*
		if(sheetObj.RowCount() == 0) {
			alert("파일을 등록해 주세요.");  
			return;
		}*/
		
		if ( !confirm(msg) )	return false;
		var param = formObj.serialize() + "&ibsSaveJson=" + replaceToEndoding(JSON.stringify(ibsSaveJson));
		
		$.ajax({
			url: com.wise.help.url(url),
			async: false, 
			type: 'POST', 
			data: param,
			dataType: 'json',
			beforeSend: function(obj) {
			},
			success: function(data) {
				if (data.success) {
					alert(data.success.message);
					var tabOnId = $(".tab li.on").children(":eq(0)").attr("id") ;	//열려 있는 탭 id 찾기
					$("#"+tabOnId).closest("li").remove();							//열려 있는 탭 ID li 제거
				    $("a[id=tabs-main]").click();   //메인 탭 클릭      
				    $("button[name=btn_inquiry]").click();
				}
				else {
					alert(data.error.message);
				}
			},
			error: function(request, status, error) {
			}, 
			complete: function(jqXHR) {}
		});
		
	}
}

/**
 * 입력/수정 VALIDATION
 */
function saveValidation() {
	var result = 0,
		isUTF8 = (($("#isUTF8").val() || "N") == "Y" ? true : false),
		objTab = getTabShowObj(),
		formObj = getTabFormObj("dtlForm"),
		table = objTab.find("#dtl-info-sect");
	
	table.find("input, select").each(function() {
		var name = $(this).attr("name") || "";
		var required = $(this).attr("data-required") || "";
		var colSize = $(this).attr("data-col-size") || 0;
		var colType = $(this).attr("data-col-Type") || "";
		
		if ( required == "Y" ) {
			if ( com.wise.util.isBlank($(this).val()) && result == 0 ) {
				var elementNm = $(this).closest("tr").find("label").text();
				alert(elementNm + "을(를) 입력하세요");
				$(this).focus();
				result++;
				return false;
			}
		}
		
		if ( colType == "NUMBER" ) {
			if ( !com.wise.util.isNumeric($(this).val()) && result == 0 ) {
				var elementNm = $(this).closest("tr").find("label").text();
				alert(elementNm + "는 숫자만 입력하세요");
				$(this).focus();
				result++;
				return false;
			}
		}
		
		if ( colSize > 0 ) {
			if ( isUTF8 ) {
				if ( !com.wise.util.isBytesUtf8($(this).val(), 0, colSize) ) {
					var elementNm = $(this).closest("tr").find("label").text();
					alert(elementNm + "는 " + colSize + "자 이내로 입력하세요.");
					$(this).focus();
					result++;
					return false;
				}
			}
			else {
				if ( !com.wise.util.isBytes($(this).val(), 0, colSize) ) {
					var elementNm = $(this).closest("tr").find("label").text();
					alert(elementNm + "는 " + colSize + "자 이내로 입력하세요.");
					$(this).focus();
					result++;
					return false;
				}
			}
			/*
			if ( !com.wise.util.isLength($(this).val(), 0, colSize) ) {
				var elementNm = $(this).closest("tr").find("label").text();
				alert(elementNm + "는 " + colSize + "자 이내로 입력하세요.");
				$(this).focus();
				result++;
				return false;
			}
			*/
		}
		
	});
	
	return result > 0 ? false : true;
}

/**
 * 시트 더블클릭시 이벤트
 * @param row
 * @returns
 */
function tabEvent(row) {
	var formObj = getTabFormObj("dtlForm");
	
	var id = mainSheet.GetCellValue(row, "DATA_SEQCE_NO");
	var title = "탭-" + (GC_FILE_SHEET_CNT);
	
	openTab.SetTabData(mainSheet.GetRowJson(row));
	openTab.addTab(id, title, "", function(tab) {
		tab.ContentObj.find("a[name=a_reg]").remove();
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
	var obj = tab.TabData;
	var elem = null;
	for (elem in obj) {
	    if ( tab.ContentObj.find("[name=" + elem + "]")[0]) {
	    	tab.ContentObj.find("[name=" + elem + "]").val(obj[elem]);
	    }
	}
	
	tab.ContentObj.find("input[name=dsId]").val($("#mstForm [name=dsId]").val());
	tab.ContentObj.find("input[name=dataSeqceNo]").val(obj.DATA_SEQCE_NO);
	
	setActionButton("U");	// 버튼처리 U
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
	
	var tabSheetNm = formObj.find("input[name=fileSheetNm]").val();
	var sheetObj = window[tabSheetNm];
	
	formObj.ajaxSubmit({
		url : com.wise.help.url("/admin/openinf/opends/insertOpenUsrDefFile.do")
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
			else {
				return true;
			}
		}	
		, success : function(res, status) {
			if ( res.data.RESULT > 0 ) {
				var row = sheetObj.DataInsert(-1);
				sheetObj.SetCellValue(row, "dataSeqceNo", formObj.find("input[name=dataSeqceNo]").val() || 0);
				sheetObj.SetCellValue(row, "srcFileNm", replaceToHTML(res.data.srcFileNm));
				sheetObj.SetCellValue(row, "viewFileNm", replaceToHTML(res.data.viewFileNm));
				sheetObj.SetCellValue(row, "saveFileNm", res.data.saveFileNm);
				sheetObj.SetCellValue(row, "fileExt", res.data.fileExt);
				sheetObj.SetCellValue(row, "fileSize", res.data.fileSize);
				sheetObj.SetCellValue(row, "downloadFile", "");
			}
			else {
				alert("업로드가 실패하였습니다.");
			}
			
			initDtlFile();
		}
		, error: function(jqXHR, textStatus, errorThrown) {
			alert("처리 도중 에러가 발생하였습니다.");
			initDtlFile();
		}
	});
}

function replaceToEndoding(str) {
	var returnStr;
	returnStr = str;

	returnStr = returnStr.replace(/&/g,"%26").replace(/\+/g,"%2B");

	return returnStr;
}

function replaceToHTML(str) {
	var returnStr;
	returnStr = str;

	returnStr = returnStr.replace(/&gt;/gi, "\>");

	returnStr = returnStr.replace(/&lt;/gi, "\<");

	returnStr = returnStr.replace(/&quot;/gi, "");

	returnStr = returnStr.replace(/&nbsp;/gi, " ");

	returnStr = returnStr.replace(/&amp;/gi, "\&");

	return returnStr;
}