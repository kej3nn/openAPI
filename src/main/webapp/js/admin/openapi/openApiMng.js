/*
 * @(#)naCmps.js 1.0 2019/09/09
 */

/**
 * 관리자에서 정보 카달로그를 관리하는 스크립트
 *
 * @author 
 * @version 1.0 2019/07/29
 */
$(function() {
    // 컴포넌트를 초기화한다.
    initOpenApi();
    
    // 마스크를 바인딩한다.
    //bindMask();
    
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
function initOpenApi() {
	tabSet();
	// 시트 그리드를 생성한다.
	loadSheet();
}

/**
 * 이벤트를 바인딩한다.
 */
function bindEvent() {
	
	
	$("button[name=btn_inquiry]").bind("click", function(e) {
		doAction("search");
    });
	
	//조회 enter
	$("input[name=searchVal]").bind("keydown", function(e) {
        // 엔터키인 경우
        if (e.which == 13) {
        	doAction("search");
            return false;
        }
    });
	
	$("button[name=btn_reg]").bind("click", function(e) {
		// 신규등록 폼 탭을 추가한다.
		doAction("regForm");
    });
	
	
	//분류체계 초기화
	$("button[name=cate_reset]").bind("click", function(e) {
		$("input[name=cateId], input[name=cateIds], input[name=cateNm]").val("");
	});
	
	$("button[name=btn_xlsDown]").bind("click", function(event) {
		//엑셀다운
		doAction("excel");
    });
	
}

/**
 * 데이터를 로드한다.
 */
function loadData() {
	doAction("search");
}


/**
 * 옵션을 로드한다.
 */
function loadOptions() {
	
}

/**
 * 화면 액션
 */
function doAction(sAction) {
	var mainFormObj = $("form[name=openApiMngMainForm]");
	var formObj = getTabFormObj("openApi-dtl-form");
	var sheet = window["sheet"];

	switch(sAction) {                       
		case "search":
			ajaxBeforeSendAdmin(com.wise.help.url("/admin/ajaxBeforeSendAdmin.do")); //IbSheet 조회전 세션 체크
			var param = {PageParam: "page", Param: "rows=50"+"&"+mainFormObj.serialize()};
			sheet.DoSearchPaging(com.wise.help.url("/admin/openapi/selectOpenApiMngListPaging.do"), param);
			break;
		case "regForm" :
			var title = "신규등록"
			var id ="siteMapReg";
			openTab.addRegTab(id, title, tabCallRegBack);
			break;
		case "insert" :
			saveData("I");
			break;
		case "update" :
			saveData("U");
			break;	
		case "delete" :
			if ( !confirm("삭제 하시겠습니까?") )	return false;
			doAjax({
				url : "/admin/openapi/deleteOpenApiMng.do",
				params : "apiSeq=" + formObj.find("input[name=apiSeq]").val(),
				callback : afterTabRemove
			});
			break;
		case "excel":
			sheet.Down2Excel({FileName:'제공 오픈 API 관리.xls',SheetName:'sheet',DownCols:"0|2|3|4"});
			break;
	}
}

/**
 * 통계표 분류 데이터 저장
 * @param action	I:등록 / U:수정
 */
function saveData(action) {
	var formObj = getTabFormObj("openApi-dtl-form");
	formObj.ajaxSubmit({
		url : com.wise.help.url("/admin/openapi/saveOpenApiMng.do")
		, async : false
		, type : 'post'
		, dataType: 'json' 
		, contentType : 'application/x-www-form-urlencoded;charset=UTF-8'
		, beforeSubmit : function() {
			//submit 전 validation 체크
			if ( saveValidation(action) ) {
				if ( !confirm("저장 하시겠습니까?") )	return false;
			} else {
				return false;
			}
		}	
		, success : function(res, status) {
			doAjaxMsg(res, "");
			afterTabRemove(res)
		}
		, error: function(jqXHR, textStatus, errorThrown) {
			alert("처리 도중 에러가 발생하였습니다.");
		}
	});
}

////////////////////////////////////////////////////////////////////////////////
//후처리 함수
////////////////////////////////////////////////////////////////////////////////
//상세 탭 이벤트 후처리
function tabFunction(tab, data) {
	var formObj = getTabFormObj("openApi-dtl-form");
	
	//이미지 표시
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
* 사이트맵ID 중복체크 후처리
* @param data	return value
*/
function afterNaDataSiteMapDupChk(data) {
	var formObj = getTabFormObj("naCmps-dtl-form");
	if ( data.dupCnt > 0 ) {
		alert("중복되는 ID가 있습니다.\n다른 ID를 입력해 주세요.");
		formObj.find("input[name=infoId]").focus();
		formObj.find("input[name=dupChk]").val("N");
	} else {
		alert("사용가능한 ID 입니다.");
		formObj.find("input[name=dupChk]").val("Y");
		formObj.find("input[name=infoId]").attr("readonly", true);	//중복체크 완료 후 단위ID변경 불가
	}
}



////////////////////////////////////////////////////////////////////////////////
// 탭 관련 함수들
////////////////////////////////////////////////////////////////////////////////
function tabSet(){   
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
	var formObj = getTabFormObj("openApi-dtl-form");
	formObj.find("input[name=useYn][value=Y]").prop("checked", true);
}
//상세 탭 이벤트
function tabEvent(row){//탭 이벤트 실행  
	var title = sheet.GetCellValue(row, "apiNm");//탭 제목
	var id = sheet.GetCellValue(row, "apiSeq");//탭 id(유일한key))
	openTab.SetTabData(sheet.GetRowJson(row));//db data 조회시 조건 data
	var url =  com.wise.help.url('/admin/openapi/openApiMngDtl.do'); // Controller 호출 url 
	openTab.addTab(id, title, url, tabCallBack); 	// 탭 추가 시작함
} 



////////////////////////////////////////////////////////////////////////////////
//시트 서비스 함수
////////////////////////////////////////////////////////////////////////////////


function sheet_OnDblClick(row, col, value, cellx, celly) {
	if(row < 1) return;                                         
	    tabEvent(row);
}

function sheet_OnSearchEnd(code, message, statusCode, statusMessage) {
	//toggleShowHideOrderBtn("statMainForm");		//조회 후 순서관련 버튼 숨김
}



////////////////////////////////////////////////////////////////////////////////
//이벤트 함수
////////////////////////////////////////////////////////////////////////////////
/**
* 탭 이벤트를 바인딩한다.
*/
function setTabButton() {
	var formObj = getTabFormObj("openApi-dtl-form");
	
	formObj.find("a[name=a_reg]").bind("click", function(e) {
		// 등록
		doAction("insert");
  });
	formObj.find("a[name=a_modify]").bind("click", function(e) {
		// 수정
		doAction("update");
  });
	formObj.find("a[name=a_del]").bind("click", function(e) {
		// 삭제
		doAction("delete");
  });
	formObj.find("button[name=naCmpsInfoId_dup]").bind("click", function() {
		//사이트맵ID 중복체크
		doAction("dupChk");
	});
	formObj.find("input[name=infoId]").keypress(function(e) {
		  if(e.which == 13) {
			  doAction('dupChk');   
			  return false;        
		  }
	});
	
	formObj.find("button[name=naSetCate_pop]").bind("click", function() {
		//분류 팝업
		doAction("naSetCatePop");
	});
	
}


////////////////////////////////////////////////////////////////////////////////
//시트 로드
////////////////////////////////////////////////////////////////////////////////
function loadSheet() {
	
createIBSheet2(document.getElementById("sheet"),"sheet", "100%", "350px");	// InfoSetMain Sheet
	
	var gridTitle = "NO|apiSeq|API명|구분|URL";
	
	with(sheet){
        
		var cfg = {SearchMode:3,Page:50,VScrollMode:1};
	    SetConfig(cfg);
	    var headers = [
	                {Text:gridTitle, Align:"Center"}
	            ];
	    var headerInfo = {Sort:1,ColMove:1,ColResize:1,HeaderCheck:0};
	    
	    InitHeaders(headers, headerInfo);
	   
	    var cols = [
	                 {Type:"Seq",		SaveName:"seq",				Width:30,	Align:"Center",	 Edit:false}
	                ,{Type:"Number",	SaveName:"apiSeq",			Width:30,	Align:"Center",	 Edit:false, Hidden:true}
	                ,{Type:"Text",		SaveName:"apiNm",			Width:200,	Align:"Left",	 Edit:false}
	                ,{Type:"Text",		SaveName:"apiTagNm",		Width:90,	Align:"Center",	 Edit:false}
	                ,{Type:"Text",		SaveName:"apiUrl",		Width:90,	Align:"Center",	 Edit:false}
	            ];                                          
	    InitColumns(cols);
	    FitColWidth();
	    SetExtendLastCol(1);
	    
	}               
	default_sheet(sheet);
	
}

////////////////////////////////////////////////////////////////////////////////
//Validation 함수
////////////////////////////////////////////////////////////////////////////////

function saveValidation(action) {
	var objTab = getTabShowObj();//탭이 oepn된 객체가져옴
	var formObj = objTab.find("form[name=openApi-dtl-form]");
	
	if ( com.wise.util.isNull(formObj.find("input[name=apiNm]").val()) ) {
		alert("API명을 입력하세요.");
		formObj.find("input[name=apiNm]").focus();
		return false;
	} else if ( !com.wise.util.isLength(formObj.find("input[name=apiNm]").val(), 1, 200) ) {
		alert("200자 이내로 입력하세요.");
		formObj.find("input[name=apiNm]").focus();
		return false;
	}
	if ( com.wise.util.isNull(formObj.find("select[name=apiTagCd]").val()) ) {
		alert("구분을 선택하세요.");
		formObj.find("input[name=apiTagCd]").focus();
		return false;
	} 
	if ( com.wise.util.isNull(formObj.find("input[name=apiUrl]").val()) ) {
		alert("url을 입력하세요");
		formObj.find("input[name=srcUrl]").focus();
		return false;
	}
	if ( !com.wise.util.isLength(formObj.find("textarea[name=apiSmryExp]").val(), 1, 300) ) {
		alert("300자 이내로 입력하세요.");
		formObj.find("textarea[name=apiSmryExp]").focus();
		return false;
	}
	if(!checkUrl(formObj.find("input[name=apiUrl]").val())) {
    	alert("URL 형식이 맞지 않습니다.");
    	formObj.find("input[name=srcUrl]").focus();
    	return false;
    }
	
	return true;
}

function checkUrl(url){
    return url.match(/(http|ftp|https):\/\/[\w\-_]+(\.[\w\-_]+)+([\w\-\.,@?^=%&amp;:/~\+#]*[\w\-\@?^=%&amp;/~\+#])?/);
}
