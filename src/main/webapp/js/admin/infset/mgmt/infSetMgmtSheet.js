/*
 * @(#)infSetMgmtSheet.js 1.0 2019/07/29
 */

/**
 * 관리자에서 정보셋의 시트처리를 관리하는 스크립트
 *
 * @author JHKIM
 * @version 1.0 2019/07/29
 */
////////////////////////////////////////////////////////////////////////////////
// 시트 초기화
////////////////////////////////////////////////////////////////////////////////
/**
 * 메인 시트 로드
 */
function loadMainSheet() {
	createIBSheet2(document.getElementById("mainSheet"),"mainSheet", "100%", "350px");	// InfoSetMain Sheet
	
	var gridTitle = "NO|정보ID|정보셋명|분류(대표)|담당부서|문서(건)|공공(건)|통계(건)|공개일|공개상태";
	
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
	                ,{Type:"Text",		SaveName:"infsId",			Width:90,	Align:"Center",	Edit:false}
					,{Type:"Text",		SaveName:"infsNm",			Width:250,	Align:"Left",	Edit:false}
					,{Type:"Text",		SaveName:"cateNm",			Width:70,	Align:"Center",	Edit:false}
					,{Type:"Text",		SaveName:"orgNm",			Width:100,	Align:"Left",	Edit:false}
					,{Type:"Int",		SaveName:"docCnt",			Width:50,	Align:"Center",	Edit:false}
					,{Type:"Int",		SaveName:"infCnt",			Width:50,	Align:"Center",	Edit:false}
					,{Type:"Int",		SaveName:"statblCnt",		Width:50,	Align:"Center",	Edit:false}
					,{Type:"Text",		SaveName:"openDttm",		Width:90,	Align:"Center",	Edit:false,	Format:"Ymd"}
					,{Type:"Combo",		SaveName:"openState",		Width:70,	Align:"Center",	Edit:false}
	            ];                                          
	    InitColumns(cols);
	    FitColWidth();
	    SetExtendLastCol(1);
	    
	    loadSheetOptions("mainSheet", 0, "openState", "/admin/stat/ajaxOption.do", {grpCd:"S1009"});	// 공개상태
	}               
	default_sheet(mainSheet);
}

/**
 * 탭 내의 설명시트 초기화
 * @param sheetNm	시트명
 * @param sheetObj	시트객체
 * @returns
 */
function loadExpSheet(sheetNm, sheetObj) {
	var gridTitle ="NO|상태|삭제|정보셋ID|일련번호|제목|등록일|순서|사용여부";
	
	with(sheetObj){
		                     
		var cfg = {SearchMode:2,Page:50,VScrollMode:1};
	    SetConfig(cfg);
	    var headers = [
	                {Text:gridTitle, Align:"Center"}
	            ];
	    var headerInfo = {Sort:0,ColMove:1,ColResize:1,HeaderCheck:0};
	    
	    InitHeaders(headers, headerInfo);
	   
	    var cols = [
	                 {Type:"Seq",		SaveName:"seq",				Width:60,	Align:"Center",		Edit:false}
	                ,{Type:"Status",	SaveName:"status",			Width:80,	Align:"Center",		Edit:false} 
	                ,{Type:"DelCheck",	SaveName:"del",				Width:30,	Align:"Center",		Edit:false,	Hidden: true}
	                ,{Type:"Text",		SaveName:"infsId",			Width:100,	Align:"Center",		Edit:false,	Hidden: true}
	                ,{Type:"Text",		SaveName:"seqceNo",			Width:100,	Align:"Center",		Edit:false,	Hidden: false}
					,{Type:"Text",		SaveName:"infsExpTit",		Width:450,	Align:"Left",		Edit:false,	Hidden: false}
					,{Type:"Date",		SaveName:"regDttm",			Width:150,	Align:"Center",		Edit:false,	Format:"Ymd"}
					,{Type:"Int",		SaveName:"vOrder",			Width:70,	Align:"Center",		Edit:false, Hidden: true}
					,{Type:"CheckBox",	SaveName:"expUseYn",		Width:100,  Align:"Center",		Edit:false, TrueValue:"Y", FalseValue:"N"}
	            ];
	    
	    InitColumns(cols);
	    FitColWidth();
	    SetExtendLastCol(1);
	}               
	default_sheet(sheetObj);   
	
	// 조회
	doActionExpSheet("search");	
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
					,{Type:"Text",		SaveName:"infsId",			Width:30,	Align:"Center",		Edit:true,	Hidden:true}
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
 * 탭 내의 문서 시트 초기화
 * @param sheetNm	시트명
 * @param sheetObj	시트객체
 * @returns
 */
function loadDocSheet(sheetNm, sheetObj) {
var gridTitle ="NO|상태|\n삭제|문서ID|문서명|분류|담당부서|이용\n허락조건|공개일자|상태|순서|\n사용여부";
	
	with(sheetObj){
		                     
		var cfg = {SearchMode:2,Page:50,VScrollMode:1};
	    SetConfig(cfg);
	    var headers = [
	                {Text:gridTitle, Align:"Center"}
	            ];
	    var headerInfo = {Sort:0,ColMove:1,ColResize:1,HeaderCheck:1};
	    
	    InitHeaders(headers, headerInfo);
	   
	    var cols = [
	    	{Type:"Seq",		SaveName:"seq",				Width:30,	Align:"Center",		Edit:false}
	    	, {Type:"Status",	SaveName:"status",			Width:40,	Align:"Center",		Edit:false} 
            , {Type:"DelCheck",	SaveName:"del",				Width:60,	Align:"Center",		Edit:true}
            , {Type:"Text",		SaveName:"docId",			Width:100,	Align:"Center",		Edit:false,	Hidden:false}
			, {Type:"Text",		SaveName:"docNm",			Width:350,	Align:"Left",		Edit:false,	Hidden:false}
			, {Type:"Text",		SaveName:"cateNm",			Width:130,	Align:"Center",		Edit:false,	Hidden:false}
			, {Type:"Text",		SaveName:"orgNm",			Width:100,	Align:"Center",		Edit:false,	Hidden:false}
			, {Type:"Text",		SaveName:"cclNm",			Width:180,	Align:"Left",		Edit:false,	Hidden:false}
			, {Type:"Text",		SaveName:"openDttm",		Width:90,	Align:"Center",		Edit:false,	Format:"Ymd"}
			, {Type:"Combo",	SaveName:"openState",		Width:80,	Align:"Center",		Edit:false}
			, {Type:"Int",		SaveName:"vOrder",			Width:70,	Align:"Center",		Edit:false, Hidden:true}
			, {Type:"CheckBox",	SaveName:"useYn",			Width:30,   Align:"Center",		TrueValue:"Y", FalseValue:"N",Edit:true}
       ];

		InitColumns(cols);
		FitColWidth();
		SetExtendLastCol(1);
		
		loadSheetOptions(sheetNm, 0, "openState", "/admin/stat/ajaxOption.do", {grpCd:"I1009"});
	    
	}               
	default_sheet(sheetObj);    
	
	// 조회
	doActionDocSheet("search");	
}

/**
 * 탭 내의 오픈 시트 초기화
 * @param sheetNm	시트명
 * @param sheetObj	시트객체
 * @returns
 */
function loadOpenSheet(sheetNm, sheetObj) {
	var gridTitle ="NO|상태|\n삭제|공공\n데이터ID|공공\n데이터명|분류|담당부서|이용\n허락조건|개방일자|상태|순서|\n사용여부";
	
	with(sheetObj){
		                     
		var cfg = {SearchMode:2,Page:50,VScrollMode:1};
	    SetConfig(cfg);
	    var headers = [ {Text:gridTitle, Align:"Center"} ];
	    var headerInfo = {Sort:0,ColMove:1,ColResize:1,HeaderCheck:1};
	    
	    InitHeaders(headers, headerInfo);
	   
	    var cols = [
	    	{Type:"Seq",		SaveName:"seq",				Width:30,	Align:"Center",		Edit:false}
	    	, {Type:"Status",	SaveName:"status",			Width:40,	Align:"Center",		Edit:false} 
            , {Type:"DelCheck",	SaveName:"del",				Width:60,	Align:"Center",		Edit:true}
            , {Type:"Text",		SaveName:"infId",			Width:140,	Align:"Center",		Edit:false,	Hidden:false}
			, {Type:"Text",		SaveName:"infNm",			Width:350,	Align:"Left",		Edit:false,	Hidden:false}
			, {Type:"Text",		SaveName:"cateNm",			Width:130,	Align:"Center",		Edit:false,	Hidden:false}
			, {Type:"Text",		SaveName:"orgNm",			Width:100,	Align:"Center",		Edit:false,	Hidden:false}
			, {Type:"Text",		SaveName:"cclNm",			Width:180,	Align:"Left",		Edit:false,	Hidden:false}
			, {Type:"Text",		SaveName:"openDttm",		Width:90,	Align:"Center",		Edit:false, Format:"Ymd"}
			, {Type:"Combo",	SaveName:"infState",		Width:80,	Align:"Center",		Edit:false}
			, {Type:"Int",		SaveName:"vOrder",			Width:70,	Align:"Center",		Edit:false,	Hidden:true}
			, {Type:"CheckBox",	SaveName:"useYn",			Width:30,   Align:"Center",		TrueValue:"Y", FalseValue:"N",Edit:true}
       ];

		InitColumns(cols);
		FitColWidth();
		SetExtendLastCol(1);
		
		loadSheetOptions(sheetNm, 0, "infState", "/admin/stat/ajaxOption.do", {grpCd:"D1007"});
		
	}               
	default_sheet(sheetObj);   
	
	// 조회
	doActionOpenSheet("search");	
}

/**
 * 탭 내의 통계 시트 초기화
 * @param sheetNm	시트명
 * @param sheetObj	시트객체
 * @returns
 */
function loadStatSheet(sheetNm, sheetObj) {
	var gridTitle ="NO|상태|\n삭제|통계\n데이터ID|통계\n데이터명|분류|담당부서|이용\n허락조건|공개일자|상태|순서|\n사용여부";
	
	with(sheetObj){
		                     
		var cfg = {SearchMode:2,Page:50,VScrollMode:1};
	    SetConfig(cfg);
	    var headers = [
	                {Text:gridTitle, Align:"Center"}
	            ];
	    var headerInfo = {Sort:0,ColMove:1,ColResize:1,HeaderCheck:1};
	    
	    InitHeaders(headers, headerInfo);
	   
	    var cols = [
	    	{Type:"Seq",		SaveName:"seq",				Width:30,	Align:"Center",		Edit:false}
	    	, {Type:"Status",	SaveName:"status",			Width:40,	Align:"Center",		Edit:false} 
            , {Type:"DelCheck",	SaveName:"del",				Width:60,	Align:"Center",		Edit:true}
            , {Type:"Text",		SaveName:"statblId",		Width:140,	Align:"Center",		Edit:false,	Hidden:false}
			, {Type:"Text",		SaveName:"statblNm",		Width:350,	Align:"Left",		Edit:false,	Hidden:false}
			, {Type:"Text",		SaveName:"cateNm",			Width:130,	Align:"Center",		Edit:false,	Hidden:false}
			, {Type:"Text",		SaveName:"orgNm",			Width:100,	Align:"Center",		Edit:false,	Hidden:false}
			, {Type:"Text",		SaveName:"cclNm",			Width:180,	Align:"Left",		Edit:false,	Hidden:false}
			, {Type:"Text",		SaveName:"openDttm",		Width:90,	Align:"Center",		Edit:false,	Format:"Ymd"}
			, {Type:"Combo",	SaveName:"openState",		Width:80,	Align:"Center",		Edit:false}
			, {Type:"Int",		SaveName:"vOrder",			Width:70,	Align:"Center",		Edit:false, Hidden:true}
			, {Type:"CheckBox",	SaveName:"useYn",			Width:30,   Align:"Center",		TrueValue:"Y", FalseValue:"N",Edit:true}
       ];

		InitColumns(cols);
		FitColWidth();
		SetExtendLastCol(1);
		
		loadSheetOptions(sheetNm, 0, "openState", "/admin/stat/ajaxOption.do", {grpCd:"S1009"});
	    
	}               
	default_sheet(sheetObj);   
	
	// 조회
	doActionStatSheet("search");	
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
 * 설명 시트 더블클릭 이벤트
 * @param row
 * @param col
 * @returns
 */
function expSheetOnDblClick(row, col, value) {
	var formObj = getTabFormObj("mst-form");
	var sheetObj = getTabSheetObj("mst-form", "expSheetNm");
	
	// ID, SEQ 히든값으로 입력
	formObj.find("input[name=infsId]").val(sheetObj.GetCellValue(row, "infsId"));
	formObj.find("input[name=seqceNo]").val(sheetObj.GetCellValue(row, "seqceNo"));
	
	
	// 조회
	doActionExpSheet("schDtl");
}

////////////////////////////////////////////////////////////////////////////////
// 시트 액션 함수들
////////////////////////////////////////////////////////////////////////////////
/**
 * 설명 시트 액션함수 
 */
function doActionExpSheet(sAction) {
	var formObj = getTabFormObj("mst-form");
	var sheetObj = getTabSheetObj("mst-form", "expSheetNm");
	switch(sAction) {                       
		case "search" :	// 조회
			var params = "infsId=" + formObj.find("#infsId").val();
			sheetObj.DoSearch(com.wise.help.url("/admin/infs/mgmt/selectInfSetExp.do"), params);
			break;
		case "schDtl" :	// 상세조회
			doAjax({
				url: "/admin/infs/mgmt/selectInfSetExp.do",
				params: "infsId=" + formObj.find("#infsId").val() + "&seqceNo="+formObj.find("#seqceNo").val(),
				callback: function(res) {
					var data = res.data[0];
					if ( data != null ) {
						formObj.find("input[name=infsExpTit]").val(data.infsExpTit);
						formObj.find("input[name=expUseYn][value="+data.expUseYn+"]").prop("checked", true);
						// 스마트 데이터 내용 입력(초기화 후 내용입력한다)
						oEditors.getById["infsDtlCont"].exec("SET_IR", ['']);	// 초기화
						if(data.infsDtlCont != null) oEditors.getById["infsDtlCont"].exec("PASTE_HTML", [data.infsDtlCont]);
					}
				}
			});
			break;
		case "init" :	// 초기화
			formObj.find("input[name=seqceNo]").val("");
			formObj.find("input[name=infsExpTit]").val("");
			
			// 스마트 에디터 초기화
			oEditors.getById["infsDtlCont"].exec("SET_IR", ['']);
			oEditors.getById["infsDtlCont"].exec("PASTE_HTML", ['']);
			formObj.find("input[name=expUseYn][value=Y]").prop("checked", true);
			break;
		case "save":
			// 데이터 구분코드(등록/저장)
			var gubun = "update";
			if ( com.wise.util.isEmpty(formObj.find("input[name=seqceNo]").val()) )	gubun = "insert";
			
			oEditors.getById["infsDtlCont"].exec("UPDATE_CONTENTS_FIELD", []);
			
			var params = {};
			$.each(formObj.serializeArray(), function(index, element) {
		        switch (element.name) {
		        	case "infsId":
		        	case "seqceNo":
		        	case "expUseYn":
		        	case "infsExpTit":
		            case "infsDtlCont":
		            	params[element.name] = element.value;
		            	break;
		        }
		    });
			
			if ( com.wise.util.isBlank(params.infsExpTit) ) {
				alert("제목을 입력하세요.");
				return false;
			}
			
			doAjax({
				url: "/admin/infs/mgmt/"+gubun+"InfSetExp.do",
				params: params,
				callback: function(res) {
					doActionExpSheet("search");
					doActionExpSheet("init");
				}
			});
			break;
		case "delete" :
			if ( !confirm("삭제 하시겠습니까?") )	return false;
			doAjax({
				url : "/admin/infs/mgmt/deleteInfSetExp.do",
				params: "infsId=" + formObj.find("#infsId").val() + "&seqceNo="+formObj.find("#seqceNo").val(),
				callback: function(res) {
					doActionExpSheet("search");
					doActionExpSheet("init");
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
					"/admin/infs/mgmt/saveInfSetExpOrder.do", 
					"", 
					function(sheet, code) {
				doActionExpSheet("search");
					});
			break;
	}
}

/**
 * 분류정보 시트 액션함수
 */
function doActionCateSheet(sAction) {
	var formObj = getTabFormObj("mst-form");
	var sheetObj = getTabSheetObj("mst-form", "cateSheetNm");
	switch(sAction) {
		case "search" :	//조회
			var params = "infsId=" + formObj.find("#infsId").val();
			sheetObj.DoSearch(com.wise.help.url("/admin/infs/mgmt/selectInfoSetCate.do"), params);
			break;
		case "catePop" :	// 분류정보 추가 팝업(선택 시 부모 시트로 데이터 이동)
			var url = com.wise.help.url("/admin/infs/mgmt/popup/infSetCatePop.do");
			var data = "?parentFormNm=mst-form&infsId=" + formObj.find("input[name=infsId]").val();// + "&cateId=" + formObj.find("input[name=cateIds]").val();
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
			var params = "infsId=" + formObj.find("#infsId").val();
			sheetObj.DoSearch(com.wise.help.url("/admin/infs/mgmt/selectInfoSetUsr.do"), params);
			break;
		case "addRow" :	//행 추가
			var newRow = sheetObj.DataInsert(-1);
			sheetObj.SetCellValue(newRow, "seqceNo", "0");
			sheetObj.SetCellValue(newRow, "useYn", true);
			break;
	}
}

/**
 * 문서데이터 시트 액션함수
 */
function doActionDocSheet(sAction) {
	var formObj = getTabFormObj("mst-form");
	var sheetObj = getTabSheetObj("mst-form", "docSheetNm");
	switch(sAction) {                       
		case "search" :	//조회
			sheetObj.DoSearch(com.wise.help.url("/admin/infs/mgmt/selectInfoSetRelDoc.do"), "infsId="+formObj.find("#infsId").val());
			break;
		case "addPop" :	// 문서 추가 팝업(선택 시 부모 시트로 데이터 이동)
			var url = com.wise.help.url("/admin/infs/mgmt/popup/docListPop.do");
			var data = "?parentFormNm=mst-form&infsId=" + formObj.find("input[name=infsId]").val();
			openIframeStatPop("iframePopUp", url+data, 660, 530);
			break;	
		case "save" :	// 데이터 저장
			var params = "infsId=" + formObj.find("#infsId").val()
				+ "&ibsSaveJson=" + encodeURIComponent(JSON.stringify(sheetObj.GetSaveJson({AllSave:true})));
			
			saveSheet("/admin/infs/mgmt/saveInfoSetRelDoc.do", params, {
					callback: function() {
						doActionDocSheet("search");
					}
				});
			break;
		case "rowUp" :
			sheetDataMove(sheetObj, "up");
			break;	
		case "rowDown" :
			sheetDataMove(sheetObj, "down");
			break;	
	}
}

/**
 * 공공데이터 시트 액션함수
 */
function doActionOpenSheet(sAction) {
	var formObj = getTabFormObj("mst-form");
	var sheetObj = getTabSheetObj("mst-form", "openSheetNm");
	switch(sAction) {                       
		case "search" :	//조회
			sheetObj.DoSearch(com.wise.help.url("/admin/infs/mgmt/selectInfoSetRelOpen.do"), "infsId="+formObj.find("#infsId").val());
			break;
		case "addPop" :	// 공공데이터 추가 팝업(선택 시 부모 시트로 데이터 이동)
			var url = com.wise.help.url("/admin/infs/mgmt/popup/openListPop.do");
			var data = "?parentFormNm=mst-form&infsId=" + formObj.find("input[name=infsId]").val();
			openIframeStatPop("iframePopUp", url+data, 660, 530);
			break;	
		case "save" :	// 데이터 저장
			var params = "infsId=" + formObj.find("#infsId").val()
				+ "&ibsSaveJson=" + encodeURIComponent(JSON.stringify(sheetObj.GetSaveJson({AllSave:true})));
			
			saveSheet("/admin/infs/mgmt/saveInfoSetRelOpen.do", params, {
					callback: function() {
						doActionOpenSheet("search");
					}
				});
			break;
		case "rowUp" :
			sheetDataMove(sheetObj, "up");
			break;	
		case "rowDown" :
			sheetDataMove(sheetObj, "down");
			break;	
	}
}

/**
 * 통계데이터 시트 액션함수
 */
function doActionStatSheet(sAction) {
	var formObj = getTabFormObj("mst-form");
	var sheetObj = getTabSheetObj("mst-form", "statSheetNm");
	switch(sAction) {                       
		case "search" :	//조회
			sheetObj.DoSearch(com.wise.help.url("/admin/infs/mgmt/selectInfoSetRelStat.do"), "infsId="+formObj.find("#infsId").val());
			break;
		case "addPop" :	// 통계표 추가 팝업(선택 시 부모 시트로 데이터 이동)
			var url = com.wise.help.url("/admin/infs/mgmt/popup/statListPop.do");
			var data = "?parentFormNm=mst-form&infsId=" + formObj.find("input[name=infsId]").val();
			openIframeStatPop("iframePopUp", url+data, 660, 530);
			break;	
		case "save" :	// 데이터 저장
			var params = "infsId=" + formObj.find("#infsId").val()
				+ "&ibsSaveJson=" + encodeURIComponent(JSON.stringify(sheetObj.GetSaveJson({AllSave:true})));
			
			saveSheet("/admin/infs/mgmt/saveInfoSetRelStat.do", params, {
					callback: function() {
						doActionStatSheet("search");
					}
				});
			break;	
		case "rowUp" :
			sheetDataMove(sheetObj, "up");
			break;	
		case "rowDown" :
			sheetDataMove(sheetObj, "down");
			break;	
	}
}
