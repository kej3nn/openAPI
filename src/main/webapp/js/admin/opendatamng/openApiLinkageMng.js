/*
 * @(#)openApiLinkageMng.js 1.0 2017/07/03
 * 
 * COPYRIGHT (C) 2013 WISEITECH CO., LTD. ALL RIGHTS RESERVED.
 */

/**
 * 관리자 API연계설정 스크립트 파일이다
 *
 * @author 
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
	
	$("button[name=btn_xlsDown]").bind("click", function(event) {
		doAction("excel");
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
	
	$("button[name=dsIdSearch]").bind("click", function(event) {
		// 저장데이터셋 table_name 팝업
		doAction("dsIdPop");
    });
	
	$("button[name=statblIdSearch]").bind("click", function(event) {
		// 대상객체 팝업_통계데이터일때
		doAction("objSPop");
    });
	
	$("button[name=objIdSearch]").bind("click", function(event) {
		// 대상객체 팝업_공공데이터일때
		doAction("objOPop");
    });
	
}


/**
 * 옵션을 로드한다.
 */
function loadOptions() {
	//메인페이지 단위유형코드
	loadComboOptions("pageidxTag", "/admin/stat/ajaxOption.do", {grpCd:"D1107"}, "");		//페이지색인(탭)
	loadComboOptions("dsMode", "/admin/stat/ajaxOption.do", {grpCd:"D1108"}, "");			//저장방식(탭)
	loadComboOptions("ownerCd", "/admin/stat/ajaxOption.do", {grpCd:"D2001"}, "");			//OWNER(탭)
	loadComboOptions3("dmpointCnt", "/admin/stat/ajaxOption.do", {grpCd:"S1109"}, "");			//소숫점자리수(탭)
	
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
	var formObj = getTabFormObj("openApiLink-dtl-form");
	var classObj = $("."+tabContentClass);
	var actObj = setTabForm(classObj); // 0: form data, 1: form 객체
	var sheet = window["sheet"];

	switch(sAction) {                       
		case "search":
			ajaxBeforeSendAdmin(com.wise.help.url("/admin/ajaxBeforeSendAdmin.do")); //IbSheet 조회전 세션 체크
			var param = {PageParam: "ibpage", Param: "onepagerow=50"+"&"+actObj[0]};
			sheet.DoSearchPaging(com.wise.help.url("/admin/opendata/openApiLinkageMngList.do"), param);
			break;
		case "excel":
			sheet.Down2Excel({FileName:'Excel.xls',SheetName:'sheet'});
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
					url : "/admin/opendata/insertOpenApiLinkageMng.do",
					params : formObj.serialize(),
					callback : afterTabRemove
				});
			} 
			break;
		case "update" :
			if ( saveValidation() ) {
				if ( !confirm("저장 하시겠습니까?") )	return false;
				doAjax({
					url : "/admin/opendata/updateOpenApiLinkageMng.do",
					params : formObj.serialize(),
					callback : afterTabRemove
				});
			} 
			break;	
		case "delete" :
			if ( !confirm("삭제 하시겠습니까?") )	return false;
			doAjax({
				url : "/admin/opendata/deleteOpenApiLinkageMng.do",
				params : formObj.serialize(),
				callback : afterTabRemove
			});
			break;
			
		case "dsIdPop" :	// 저장 데이터셋 table_name 팝업
			var url = com.wise.help.url("/admin/opendata/popup/openApiLinkDsPopup.do");
			var data = "?parentFormNm=openApiLink-dtl-form";
			wWidth ="660";                                                    
			wHeight ="530";   
			openIframeStatPop("iframePopUp", url+data, wWidth, wHeight)
			break;	
		
		case "objSPop" :	// 대상객체 팝업_통계데이터일때 
			var url = com.wise.help.url("/admin/opendata/popup/openApiLinkObjSPopup.do");
			var data = "?parentFormNm=openApiLink-dtl-form";
			wWidth ="660";                                                    
			wHeight ="530";   
			openIframeStatPop("iframePopUp", url+data, wWidth, wHeight)
			break;
		
		case "objOPop" :	// 대상객체 팝업_공공데이터일때 
			var url = com.wise.help.url("/admin/opendata/popup/openApiLinkDsPopup.do");
			var ownerGb = formObj.find("select[name=ownerCd]").val();
			var data = "?parentFormNm=openApiLink-dtl-form&ownerGb="+ownerGb;
			wWidth ="660";                                                    
			wHeight ="530";   
			openIframeStatPop("iframePopUp", url+data, wWidth, wHeight)
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
	var formObj = getTabFormObj("openApiLink-dtl-form");
	
	$.each(data.DATA, function(key, val) {
		
		if(key=="objTagCd"){
			if(val=="O"){
				tab.ContentObj.find("tr[name=oData]").css("display","");
				tab.ContentObj.find("tr[name=sData]").css("display","none");
				var owner = tab.ContentObj.find("select[name=ownerCd]").val();
				tab.ContentObj.find("input[name=owner]").val(owner);
			}else{
				tab.ContentObj.find("tr[name=oData]").css("display","none");
				tab.ContentObj.find("tr[name=sData]").css("display","");
			}
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
	var formObj = getTabFormObj("openApiLink-dtl-form");
	formObj.each(function() { this.reset(); });
	formObj.find($("#objTagCdO")).val("O");
	formObj.find("tr[name=oData]").css("display","");
	formObj.find("tr[name=sData]").css("display","none");
	
	formObj.find("tr[name=execTable]").css("display","none");
	
	dynamicTabButton(tab);		//탭 이벤트를 바인딩한다(동적생성 element들)
}

//상세 탭 이벤트
function tabEvent(row){//탭 이벤트 실행  
	var title = sheet.GetCellValue(row, "apiNm");//탭 제목
	var id = sheet.GetCellValue(row, "apiSeq");//탭 id(유일한key))
	openTab.SetTabData(sheet.GetRowJson(row));//db data 조회시 조건 data
	var url =  com.wise.help.url('/admin/opendata/openApiLinkageMngDtl.do'); // Controller 호출 url 
	openTab.addTab(id, title, url, tabCallBack); 	// 탭 추가 시작함

} 

////////////////////////////////////////////////////////////////////////////////
//시트 로드
////////////////////////////////////////////////////////////////////////////////
function loadSheet() {
	
	createIBSheet2(document.getElementById("sheet"),"sheet", "100%", "300px");
	
	var gridTitle ="NO";
	gridTitle +="|연계번호";
	gridTitle +="|연계API명";
	gridTitle +="|대상 데이터셋";
	gridTitle +="|호출URL";
	gridTitle +="|대상 객체구분";
	gridTitle +="|실행모드";
	gridTitle +="|최종수집일자";
	
	with(sheet){
		                     
		var cfg = {SearchMode:2,Page:50,VScrollMode:1};
	    SetConfig(cfg);
	    var headers = [
	                {Text:gridTitle, Align:"Center"}
	            ];
	    var headerInfo = {Sort:1,ColMove:1,ColResize:1,HeaderCheck:0};
	    
	    InitHeaders(headers, headerInfo);
	   
	    var cols = [
	                 {Type:"Seq",		SaveName:"seq",			   Width:30,	Align:"Center",		Edit:false}
					,{Type:"Text",		SaveName:"apiSeq",	       Width:30,	Align:"Center",		Edit:false}
					,{Type:"Text",		SaveName:"apiNm",		   Width:200,	Align:"Left",		Edit:false}
					,{Type:"Text",		SaveName:"dsId",		   Width:70,	Align:"Center",		Edit:false}
					,{Type:"Text",		SaveName:"apiUrl",	       Width:160,	Align:"Left",		Edit:false}
					,{Type:"Text",		SaveName:"objTagCdNm",	   Width:50,	Align:"Center",		Edit:false}
					,{Type:"Text",		SaveName:"runModeNm",	   Width:50,	Align:"Center",		Edit:false}
					,{Type:"Text",		SaveName:"lastDataDttm",   Width:60,	Align:"Center",		Edit:false, Format:"Ymd"}
					
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
	var formObj = getTabFormObj("openApiLink-dtl-form");
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
	
	formObj.find("input[name=objTagCd]").bind("change", function(event) {
		if($(this).val() == "O"){
			formObj.find("tr[name=oData]").css("display","");
			formObj.find("tr[name=sData]").css("display","none");
			var owner = formObj.find("select[name=ownerCd]").val();
			formObj.find("input[name=owner]").val(owner);
		}else{
			formObj.find("tr[name=oData]").css("display","none");
			formObj.find("tr[name=sData]").css("display","");
		}
    });
	
}

/**
 * 탭 이벤트를 바인딩한다.(동적으로 생성된 selectBox등)
 */
function dynamicTabButton(tab) {
	
	
	/*tab.ContentObj.on("change", "input[name=objTagCd]", function() {
			alert(tab.ContentObj.find("input[name=objTagCd]").val());
		if(tab.ContentObj.find("input[name=objTagCd]").val() == "O"){
			alert(1);
			tab.ContentObj.find("tr[name=oData]").css("display","");
			tab.ContentObj.find("tr[name=sData]").css("display","none");
		}else{
			alert(2);
			tab.ContentObj.find("tr[name=oData]").css("display","none");
			tab.ContentObj.find("tr[name=sData]").css("display","");
		}
		
	});*/
	
	tab.ContentObj.find("input[name=pagesize]").keyup(function(){
		$(this).val( $(this).val().replace(/[^0-9]/g,"") );
		if($(this).val() > 10001){
			alert("10000이하 숫자만 입력하세요.");
			$(this).val("");
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
	var formObj = objTab.find("form[name=openApiLink-dtl-form]");
	
	if ( com.wise.util.isNull(formObj.find("input[name=apiNm]").val()) ) {
		alert("API연계명을 입력하세요.");
		formObj.find("input[name=apiNm]").focus();
		return false;
	}
	if ( com.wise.util.isNull(formObj.find("input[name=apiUrl]").val()) ) {
		alert("호출URL을 입력하세요.");
		formObj.find("input[name=apiUrl]").focus();
		return false;
	}
	
	if ( com.wise.util.isNull(formObj.find("input[name=dataid]").val()) ) {
		alert("사이트(API)고유ID를 입력하세요.");
		formObj.find("input[name=dataid]").focus();
		return false;
	}  
	
	if ( com.wise.util.isNull(formObj.find("input[name=authKeyNm]").val()) ) {
		alert("인증키 (명)를 입력하세요.");
		formObj.find("input[name=authKeyNm]").focus();
		return false;
	}
	
	if ( com.wise.util.isNull(formObj.find("input[name=authKey]").val()) ) {
		alert("인증키 (명)를 입력하세요.");
		formObj.find("input[name=authKey]").focus();
		return false;
	}

	if ( com.wise.util.isNull(formObj.find("input[name=charSet]").val()) ) {
		alert("출력문자집합을 입력하세요.");
		formObj.find("input[name=charSet]").focus();
		return false;
	}
	
	if ( com.wise.util.isNull(formObj.find("input[name=dsId]").val()) ) {
		alert("저장데이터셋을 입력하세요.");
		formObj.find("button[name=dsIdSearch]").focus();
		return false;
	}
	if( formObj.find("select[name=dsMode]").val() == "U" ){
		if ( com.wise.util.isNull(formObj.find("input[name=dsPk]").val()) ) {
			alert("저장조건을 입력하세요.");
			formObj.find("input[name=dsPk]").focus();
			return false;
		}
	}
	
	
	if ( formObj.find("input[name=objTagCd]:checked").val() == "O"  ) {
		if ( !com.wise.util.isBlank(formObj.find("input[name=callbackSp]").val()) ) {
			
			if ( com.wise.util.isNull(formObj.find("input[name=objIdO]").val()) ) {
				alert("대상객체를 입력하세요.");
				formObj.find("input[name=objIdO]").focus();
				return false;
			}
		}
	}else {
		if ( !com.wise.util.isBlank(formObj.find("input[name=callbackSp]").val()) ) {
			
			if ( com.wise.util.isNull(formObj.find("input[name=objIdS]").val()) ) {
				alert("대상객체를 입력하세요.");
				formObj.find("input[name=objIdS]").focus();
				return false;
			}
			
		}
	}

	return true;
}

