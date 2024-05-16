/*
 * @(#)docInfMgmtSheet.js 1.0 2019/08/05
 */

/**
 * 관리자에서 정보공개 정보관리화면의 시트처리를 관리하는 스크립트
 *
 * @author JHKIM
 * @version 1.0 2019/08/05
 */

////////////////////////////////////////////////////////////////////////////////
// 시트 초기화
////////////////////////////////////////////////////////////////////////////////
/**
 * 메인 시트 로드
 */
function loadMainSheet() {
	createIBSheet2(document.getElementById("mainSheet"),"mainSheet", "100%", "350px");	// docInfMain Sheet
	
	var gridTitle = "NO|정보ID|정보셋명|분류(대표)|담당부서|이용허락조건|공개일|공개상태";
	
	with(mainSheet){
        
		var cfg = {SearchMode:3,Page:50,VScrollMode:1};
	    SetConfig(cfg);
	    var headers = [
	                {Text:gridTitle, Align:"Center"}
	            ];
	    var headerInfo = {Sort:0,ColMove:1,ColResize:1,HeaderCheck:0};
	    
	    InitHeaders(headers, headerInfo);
	   
	    var cols = [
	                 {Type:"Seq",		SaveName:"seq",				Width:30,	Align:"Center",	Edit:false}
	                ,{Type:"Text",		SaveName:"docId",			Width:90,	Align:"Center",	Edit:false}
					,{Type:"Text",		SaveName:"docNm",			Width:280,	Align:"Left",	Edit:false}
					,{Type:"Text",		SaveName:"cateNm",			Width:100,	Align:"Center",	Edit:false}
					,{Type:"Text",		SaveName:"orgNm",			Width:90,	Align:"Left",	Edit:false}
					,{Type:"Combo",		SaveName:"cclCd",			Width:150,	Align:"Left",	Edit:false}
					,{Type:"Text",		SaveName:"openDttm",		Width:90,	Align:"Center",	Edit:false,	Format:"Ymd"}
					,{Type:"Combo",		SaveName:"openState",		Width:70,	Align:"Center",	Edit:false}
	            ];                                          
	    InitColumns(cols);
	    FitColWidth();
	    SetExtendLastCol(1);
	    
	    loadSheetOptions("mainSheet", 0, "cclCd", 	  "/admin/stat/ajaxOption.do", {grpCd:"D1008"});	// 이용허락조건
	    loadSheetOptions("mainSheet", 0, "openState", "/admin/stat/ajaxOption.do", {grpCd:"S1009"});	// 공개상태
	}               
	default_sheet(mainSheet);
}

/**
 * 탭 내의 분류시트 초기화
 * @param sheetNm	시트명
 * @param sheetObj	시트객체
 * @returns
 */
function loadCateSheet(sheetNm, sheetObj) {
	var gridTitle ="NO|상태|삭제|분류ID|분류|대표여부|사용여부";
	
	with(sheetObj){
		                     
		var cfg = {SearchMode:2,Page:50,VScrollMode:1};
	    SetConfig(cfg);
	    var headers = [
	                {Text:gridTitle, Align:"Center"}
	            ];
	    var headerInfo = {Sort:0,ColMove:1,ColResize:1,HeaderCheck:0};
	    
	    InitHeaders(headers, headerInfo);
	   
	    var cols = [
	                 {Type:"Seq",		SaveName:"seq",				Width:30,	Align:"Center",		Edit:false}
	                ,{Type:"Status",	SaveName:"status",			Width:40,	Align:"Center",		Edit:false} 
	                ,{Type:"DelCheck",	SaveName:"del",				Width:30,	Align:"Center",		Edit:true}
	                ,{Type:"Text",		SaveName:"cateId",			Width:80,	Align:"Center",		Edit:true,	Hidden:false, KeyField: 1}
					,{Type:"Text",		SaveName:"cateFullNm",		Width:300,	Align:"Left",		Edit:true,	Hidden:false, KeyField: 1}
					,{Type:"Radio",		SaveName:"rpstYn",			Width:30,	Align:"Center",		Edit:true, TrueValue:"Y", FalseValue:"N",  Sort:false}
					,{Type:"CheckBox",	SaveName:"useYn",			Width:30,   Align:"Center",		TrueValue:"Y", FalseValue:"N",Edit:true}
	            ];
	    
	    InitColumns(cols);
	    FitColWidth();
	    SetExtendLastCol(1);
	    
	}               
	default_sheet(sheetObj);   
	
	// 조회
	doActionCateSheet("search");	
}

/**
 * 탭 내의 유저시트 초기화
 * @param sheetNm	시트명
 * @param sheetObj	시트객체
 * @returns
 */
function loadUsrSheet(sheetNm, sheetObj) {
	var gridTitle ="NO|상태|삭제|시퀀스|정보ID|조직코드|조직명|직원코드|직원명|대표여부|업무권한|출처표시|사용여부";
	
	with(sheetObj){
		                     
		var cfg = {SearchMode:2,Page:50,VScrollMode:1};
	    SetConfig(cfg);
	    var headers = [
	                {Text:gridTitle, Align:"Center"}
	            ];
	    var headerInfo = {Sort:0,ColMove:1,ColResize:1,HeaderCheck:0};
	    
	    InitHeaders(headers, headerInfo);
	   
	    var cols = [
	                 {Type:"Seq",		SaveName:"seq",				Width:30,	Align:"Center",		Edit:false}
	                ,{Type:"Status",	SaveName:"status",			Width:40,	Align:"Center",		Edit:false} 
	                ,{Type:"DelCheck",	SaveName:"del",				Width:30,	Align:"Center",		Edit:true}
	                ,{Type:"Text",		SaveName:"seqceNo",			Width:30,	Align:"Center",		Edit:true,	Hidden:true}
					,{Type:"Text",		SaveName:"docId",			Width:30,	Align:"Center",		Edit:true,	Hidden:true}
					,{Type:"Text",		SaveName:"orgCd",			Width:30,	Align:"Left",		Edit:true,	Hidden:true}
					,{Type:"Popup",		SaveName:"orgNm",			Width:100,	Align:"Left",		Edit:true,	KeyField: 1}
					,{Type:"Text",		SaveName:"usrCd",			Width:50,	Align:"Left",		Edit:true,	Hidden:true}
					,{Type:"Popup",		SaveName:"usrNm",			Width:100,	Align:"Left",		Edit:true}
					,{Type:"Radio",		SaveName:"rpstYn",			Width:30,	Align:"Center",		Edit:true, TrueValue:"Y", FalseValue:"N",  Sort:false}
					,{Type:"Combo",		SaveName:"prssAccCd",		Width:80,	Align:"Center",		Edit:true,	KeyField: 1}
					,{Type:"CheckBox",	SaveName:"srcViewYn",		Width:30,   Align:"Center",		TrueValue:"Y", FalseValue:"N",Edit:true}
					,{Type:"CheckBox",	SaveName:"useYn",			Width:30,   Align:"Center",		TrueValue:"Y", FalseValue:"N",Edit:true}
	            ];
	    
	    InitColumns(cols);
	    FitColWidth();
	    SetExtendLastCol(1);
	    loadSheetOptions(sheetNm, 0, "prssAccCd", "/admin/stat/ajaxOption.do", {grpCd:"S2001"});
	    
	}               
	default_sheet(sheetObj);   
	
	// 조회
	doActionUsrSheet("search");	
}


/**
 * 탭 내의 첨부파일 시트 초기화
 * @param sheetNm	시트명
 * @param sheetObj	시트객체
 * @returns
 */
function loadFileSheet(sheetNm, sheetObj) {
	var gridTitle ="NO|상태|삭제|문서ID|문서SEQ|파일버전번호|원본파일명|출력파일명|파일크기(KB)|확장자(종류)|순서|생산일";
	
	with(sheetObj){
		                     
		var cfg = {SearchMode:2,Page:50,VScrollMode:1};
	    SetConfig(cfg);
	    var headers = [
	                {Text:gridTitle, Align:"Center"}
	            ];
	    var headerInfo = {Sort:0,ColMove:1,ColResize:1,HeaderCheck:0};
	    
	    InitHeaders(headers, headerInfo);
	   
	    var cols = [
	                 {Type:"Seq",		SaveName:"seq",				Width:30,	Align:"Center",		Edit:false}
	                ,{Type:"Status",	SaveName:"status",			Width:40,	Align:"Center",		Edit:false} 
	                ,{Type:"DelCheck",	SaveName:"del",				Width:60,	Align:"Center",		Edit:false, Hidden: true}
	                ,{Type:"Text",		SaveName:"docId",			Width:100,	Align:"Center",		Edit:false, Hidden: false}
	                ,{Type:"Text",		SaveName:"fileSeq",			Width:100,	Align:"Center",		Edit:false, Hidden: false}
	                ,{Type:"Int",		SaveName:"fileVerNo",		Width:100,	Align:"Center",		Edit:false}
					,{Type:"Text",		SaveName:"srcFileNm",		Width:250,	Align:"Left",		Edit:false}
					,{Type:"Text",		SaveName:"viewFileNm",		Width:250,	Align:"Left",		Edit:false}
					,{Type:"Text",		SaveName:"fileSize",		Width:150,	Align:"Center",		Edit:false}
					,{Type:"Text",		SaveName:"fileExt",			Width:120,	Align:"Center",		Edit:false}
					,{Type:"Int",		SaveName:"vOrder",			Width:100,	Align:"Center",		Edit:false}
					,{Type:"Text",		SaveName:"prdcYmd",			Width:120,	Align:"Center",		Edit:false,	Format:"Ymd"}
	            ];
	    
	    InitColumns(cols);
	    FitColWidth();
	    SetExtendLastCol(1);
	    
	}               
	default_sheet(sheetObj);   
	
	// 조회
	doActionFileSheet("search");	
}

////////////////////////////////////////////////////////////////////////////////
//시트 이벤트
////////////////////////////////////////////////////////////////////////////////
/**
 * 메인 시트 더블클릭 이벤트
 */
function mainSheet_OnDblClick(row, col, value, cellx, celly) {
	if (row < 1) return;
	tabEvent(row);
}

/**
 * 유저 시트 팝업클릭 이벤트 
 */
function usrSheetOnPopupClick(Row, Col){
	var formObj = getTabFormObj("mst-form");
	var usrSheetNm = formObj.find("input[id=usrSheetNm]").val();
	var usrSheetObj = window[usrSheetNm];
	
	if ( usrSheetObj.ColSaveName(Col) == "orgNm" ) {	//조직명 클릭
		window.open(com.wise.help.url("/admin/basicinf/popup/commOrg_pop.do") + "?orgNmGb=7&sheetNm="+usrSheetNm+"", "list" ,"fullscreen=no, width=500, height=550"); 
	} else if ( usrSheetObj.GetCellValue(Row, "orgNm") != "" && usrSheetObj.ColSaveName(Col) == "usrNm" ) {
		window.open(com.wise.help.url("/admin/basicinf/popup/commUsrPos_pop.do") + "?usrGb=4&sheetNm="+usrSheetNm+"&orgCd="+usrSheetObj.GetCellValue(Row, "orgCd") ,"list", "fullscreen=no, width=600, height=550");
	} else {
		alert("먼저 조직명을 선택하세요.");
	}
}

/**
 * 파일 시트 더블클릭 이벤트
 * @param row
 * @param col
 * @returns
 */
function fileSheetOnDblClick(row, col, value) {
	var formObj = getTabFormObj("mst-form");
	var sheetObj = getTabSheetObj("mst-form", "fileSheetNm");
	
	// 문서ID, SEQ 히든값으로 입력
	formObj.find("input[name=docId]").val(sheetObj.GetCellValue(row, "docId"));
	formObj.find("input[name=fileSeq]").val(sheetObj.GetCellValue(row, "fileSeq"));
	
	// 상세 조회
	doActionFileSheet("schDtl");
}

////////////////////////////////////////////////////////////////////////////////
// 시트 액션 함수들
////////////////////////////////////////////////////////////////////////////////
/**
 * 분류정보 시트 액션함수
 */
function doActionCateSheet(sAction) {
	var formObj = getTabFormObj("mst-form");
	var sheetObj = getTabSheetObj("mst-form", "cateSheetNm");
	switch(sAction) {
		case "search" :	//조회
			var params = "docId=" + formObj.find("#docId").val();
			sheetObj.DoSearch(com.wise.help.url("/admin/infs/doc/selectDocInfCate.do"), params);
			break;
		case "catePop" :	// 분류정보 추가 팝업(선택 시 부모 시트로 데이터 이동)
			var url = com.wise.help.url("/admin/infs/doc/popup/docInfCatePop.do");
			var data = "?parentFormNm=mst-form&docId=" + formObj.find("input[name=docId]").val();// + "&cateId=" + formObj.find("input[name=cateIds]").val();
			openIframeStatPop("iframePopUp", url+data, 660, 530);
			break;
		}
}

/**
 * 담당자정보 시트 액션함수
 */
function doActionUsrSheet(sAction) {
	var formObj = getTabFormObj("mst-form");
	var sheetObj = getTabSheetObj("mst-form", "usrSheetNm");
	switch(sAction) {
		case "search" :	//조회
			var params = "docId=" + formObj.find("#docId").val();
			sheetObj.DoSearch(com.wise.help.url("/admin/infs/doc/selectDocInfUsr.do"), params);
			break;
		case "addRow" :	//행 추가
			var newRow = sheetObj.DataInsert(-1);
			sheetObj.SetCellValue(newRow, "seqceNo", "0");
			sheetObj.SetCellValue(newRow, "useYn", true);
			break;
	}
}

/**
 * 첨부파일 시트 액션함수 
 */
function doActionFileSheet(sAction, args) {
	var formObj = getTabFormObj("mst-form");
	var sheetObj = getTabSheetObj("mst-form", "fileSheetNm");
	args = args || {};
	
	switch(sAction) {                       
		case "search" :	// 조회
			sheetObj.DoSearch(com.wise.help.url("/admin/infs/doc/selectDocInfFile.do"), "docId="+formObj.find("#docId").val() );
			break;
		case "schDtl" :
			doAjax({
				url: "/admin/infs/doc/selectDocInfFile.do",
				params: "docId="+formObj.find("input[name=docId]").val() + "&fileSeq="+formObj.find("input[name=fileSeq]").val(),
				callback: function(res) {
					var data = res.data[0];
					if ( data != null ) {
						var prdcYmd = data.prdcYmd;
						formObj.find("input[name=prdcYmd]").val(prdcYmd.substr(0, 4) + "-" + prdcYmd.substr(4, 2) + "-" + prdcYmd.substr(6, 2));
						formObj.find("input[name=viewFileNm]").val(data.viewFileNm);
						formObj.find("input[name=fileExt]").val(data.fileExt);
						formObj.find("#tmnlImgFile").val(data.tmnlImgFile);
						formObj.find("select[name=srcFileSeq]").val(data.srcFileSeq);
						formObj.find("input[name=srcFileDocId]").val(data.srcFileDocId);
						formObj.find("select[name=docKpDdayCd]").val(data.docKpDdayCd);
						formObj.find("select[name=srcFileDocId]").val(data.docKpDdayCd);
						formObj.find("input[name=fileUseYn][value="+data.useYn+"]").prop("checked", true);
						
						// 스마트 데이터 내용 입력(초기화 후 내용입력한다)
						oEditors.getById["fileDtlCont"].exec("SET_IR", ['']);		// 초기화
						oEditors.getById["fileDtlCont"].exec("PASTE_HTML", [data.fileDtlCont]);
						
						// 버튼처리
						formObj.find("a[name=a_save]:eq(1), a[name=a_del]:eq(1)").show();
						formObj.find("a[name=a_file_reg]").hide();
						
						// 문서공개 원본 파일 고유번호를 조회
						doActionFileSheet("schSrcFileSeq", {val: data.srcFileSeq});
					}
				}
			});
			break;
		case "schSrcFileSeq" :	// 문서공개 원본 파일 고유번호를 조회
			doAjax({
				url: "/admin/infs/doc/selectDocInfFileSrcFileSeq.do",
				async: true,
				params: "docId="+formObj.find("input[name=docId]").val() + "&fileSeq="+formObj.find("input[name=fileSeq]").val(),
				callback: function(res) {
					var srcFileSeq = formObj.find("select[name=srcFileSeq]");
					srcFileSeq.empty().append("<option value=\"\">선택</option>");
					
					var data = res.data;
					if ( data.length > 0 ) {
						for ( var i in data ) {
							srcFileSeq.append("<option value=\""+data[i].fileSeq+"\" "+(data[i].fileSeq==args.val?"selected":"")+">"+data[i].viewFileNm+"</option>");
						}
					}
				}
			});
			break;
		case "init" :	// 초기화
			formObj.find("a[name=a_file_reg]").show();
			formObj.find("a[name=a_save]:eq(1), a[name=a_del]:eq(1)").hide();
			formObj.find("input[name=docFile]").val("");
			formObj.find("input[name=imgFile]").val("");
			formObj.find("input[name=fileSeq]").val("");
			formObj.find("#tmnlImgFile").val("");
			formObj.find("input[name=srcFileDocId]").val("");
			formObj.find("input[name=viewFileNm]").val("");
			formObj.find("input[name=fileExt]").val("");
			formObj.find("input[name=prdcYmd]").val("");
			formObj.find("input[name=srcDocId]").val("");
			formObj.find("select[name=docKpDdayCd]").val("");
			formObj.find("select[name=srcFileDocId]").val("");
			formObj.find("textarea[name=fileDtlCont]").text("");
			
			// 스마트에디터 초기화
			oEditors.getById["fileDtlCont"].exec("SET_IR", ['']);
			oEditors.getById["fileDtlCont"].exec("PASTE_HTML", ['']);
			
			// 문서공개 원본 파일 고유번호를 조회
			doActionFileSheet("schSrcFileSeq");
			break;	
		case "reg" :
			oEditors.getById["fileDtlCont"].exec("UPDATE_CONTENTS_FIELD", []);
			
			formObj.ajaxSubmit({
				url : com.wise.help.url("/admin/infs/doc/insertDocInfFile.do")
				, async : false
				, type : 'post'
				, dataType: 'json' 
				, contentType : 'application/x-www-form-urlencoded;charset=UTF-8'
				, beforeSubmit : function() {
					//submit 전 validation 체크
					if ( !fileSaveValidation(sAction) )		return false;
					if ( !confirm("등록 하시겠습니까?") )	return false;
				}	
				, success : function(res, status) {
					doAjaxMsg(res, "");
					doActionFileSheet("search");
					doActionFileSheet("init");
				}
				, error: function(jqXHR, textStatus, errorThrown) {
					alert("처리 도중 에러가 발생하였습니다.");
				}
			});
			break;
		case "save" :
			oEditors.getById["fileDtlCont"].exec("UPDATE_CONTENTS_FIELD", []);
			
			formObj.ajaxSubmit({
				url : com.wise.help.url("/admin/infs/doc/saveDocInfFile.do")
				, async : false
				, type : 'post'
				, dataType: 'json' 
				, contentType : 'application/x-www-form-urlencoded;charset=UTF-8'
				, beforeSubmit : function() {
					//submit 전 validation 체크
					if ( !fileSaveValidation(sAction) ) 	return false;
					if ( !confirm("저장 하시겠습니까?") )	return false;
				}	
				, success : function(res, status) {
					doAjaxMsg(res, "");
					doActionFileSheet("search");
				}
				, error: function(jqXHR, textStatus, errorThrown) {
					alert("처리 도중 에러가 발생하였습니다.");
				}
			});
			break;
		case "del" :
			if ( !confirm("파일을 삭제 하시겠습니까?") )	return false;
			doAjax({
				url : "/admin/infs/doc/deleteDocInfFile.do",
				params: "docId="+formObj.find("#docId").val() + "&fileSeq="+formObj.find("input[name=fileSeq]").val(),
				callback: function(res) {
					doActionFileSheet("search");
					doActionFileSheet("init");
				}
			});
			break;
		case "rowUp" :
			sheetDataMove(sheetObj, "up");
			break;	
		case "rowDown" :
			sheetDataMove(sheetObj, "down");
			break;		
		case "saveOrder":
			saveTabSheetData(sheetObj, 
					"/admin/infs/doc/saveDocInfFileOrder.do", 
					"", 
					function(sheet, code) {
						doActionFileSheet("search");
					});
			break;
		case "thumbnail" :		// 썸네일 이미지 조회
			if ( com.wise.util.isBlank(formObj.find("input[name=fileSeq]").val()) ) {
				alert("시트에서 첨부파일을 선택해 주세요");
				return false;
			}
			if ( com.wise.util.isBlank(formObj.find("#tmnlImgFile").val()) ) {
				alert("등록된 이미지가 없습니다");
				return false;
			}
			window.open(com.wise.help.url("/admin/infs/doc/popup/docInfFileThumbnail.do") + "?docId="+formObj.find("#docId").val() + "&fileSeq="+formObj.find("input[name=fileSeq]").val(), "thumbnail" ,"location=no, fullscreen=no, width=350, height=400, menubar=no, status=no, toolbar=no");

			break;
	}
}
