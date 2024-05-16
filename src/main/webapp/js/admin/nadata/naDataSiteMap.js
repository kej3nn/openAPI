/*
 * @(#)naDataSiteMap.js 1.0 2019/09/09
 */

/**
 * 관리자에서 정보셋을 관리하는 스크립트
 *
 * @author JHKIM
 * @version 1.0 2019/07/29
 */
$(function() {
    // 컴포넌트를 초기화한다.
    initComp();
    
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
// 초기화 함수
////////////////////////////////////////////////////////////////////////////////
/**
 * 컴포넌트를 초기화한다.
 */
function initComp() {
	tabSet();
	
	// 정보서비스 사이트맵 시트 그리드를 생성한다.
	loadSheet();
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
	
	//분류체계 팝업
	$("button[name=cate_pop]").bind("click", function(e) {
		doAction("catePop");
	});
	
	//분류체계 초기화
	$("button[name=cate_reset]").bind("click", function(e) {
		$("input[name=cateId], input[name=cateIds], input[name=cateNm]").val("");
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
	var mainFormObj = $("form[name=siteMapMainForm]");
	var formObj = getTabFormObj("naDataSiteMap-dtl-form");
	var sheet = window["sheet"];
	var cateTag = "CT120"; 

	switch(sAction) {                       
		case "search":
			ajaxBeforeSendAdmin(com.wise.help.url("/admin/ajaxBeforeSendAdmin.do")); //IbSheet 조회전 세션 체크
			var param = {PageParam: "page", Param: "rows=50"+"&"+mainFormObj.serialize()};
			sheet.DoSearchPaging(com.wise.help.url("/admin/nadata/siteMap/siteMapMainListPaging.do"), param);
			break;
		case "regForm" :
			var title = "신규등록"
			var id ="siteMapReg";
			openTab.addRegTab(id, title, tabCallRegBack);
			break;
		case "catePop" :
			var url = com.wise.help.url("/admin/nadata/mgmt/popup/naSetCateSearchPop.do");
			var data = "?parentFormNm=siteMapMainForm&cateTag="+cateTag;
			openIframeStatPop("iframePopUp", url+data, 660, 530);
			break;	
		case "naSetCatePop" :
			var url = com.wise.help.url("/admin/nadata/mgmt/popup/naSetCatePop.do");
			var data = "?parentFormNm=naDataSiteMap-dtl-form&cateTag="+cateTag;
			wWidth ="660";                                                    
			wHeight ="530";   
			openIframeStatPop("iframePopUp", url+data, wWidth, wHeight)
			break;	
		case "dupChk" : 
			doPost({
                url:"/admin/nadata/siteMap/naDataSiteMapDupChk.do",
                before : beforeNaDataSiteMapDupChk,
                after : afterNaDataSiteMapDupChk
            });
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
				url : "/admin/nadata/siteMap/deleteNaDataSiteMap.do",
				params : "srvmId=" + formObj.find("input[name=srvmId]").val(),
				callback : afterTabRemove
			});
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
			saveSheetData({
                SheetId:"sheet",
                PageUrl:"/admin/nadata/siteMap/saveNaDataSiteMapOrder.do"
            }, {
            }, {
                AllSave:0
            });
			break;
	}
}

/**
 * 통계표 분류 데이터 저장
 * @param action	I:등록 / U:수정
 */
function saveData(action) {
	var formObj = getTabFormObj("naDataSiteMap-dtl-form");
	formObj.ajaxSubmit({
		url : com.wise.help.url("/admin/nadata/siteMap/saveNaDataSiteMap.do")
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
//전처리 함수
////////////////////////////////////////////////////////////////////////////////
/**
* 사이트맵ID 중복체크 전처리 함수
*/
function beforeNaDataSiteMapDupChk(options) {
	var formObj = getTabFormObj("naDataSiteMap-dtl-form");
	var srvmId = formObj.find("input[name=srvmId]").val().trim().toUpperCase();
 var data = {
     "srvmId" : srvmId
 };
 if ( com.wise.util.isBlank(data.srvmId) ) {
 	alert("서비스맵ID를 입력하세요.");
 	formObj.find("input[name=srvmId]").focus();
     return null;
 }
 
 formObj.find("input[name=srvmId]").val(srvmId);	//소문자로 입력되어있을경우 대문자로 변경해서 보여줌
 
 if ( !com.wise.util.isAlphaNumeric(data.srvmId) || !com.wise.util.isLength(data.srvmId, 1, 10) ) {
 	alert("영문, 숫자 10자리 이내로 입력하세요.");
 	formObj.find("input[name=srvmId]").val("").focus();
     return null;
 }
 
 return data;
}
////////////////////////////////////////////////////////////////////////////////
//후처리 함수
////////////////////////////////////////////////////////////////////////////////
//상세 탭 이벤트 후처리
function tabFunction(tab, data) {
	var formObj = getTabFormObj("naDataSiteMap-dtl-form");
	formObj.find("button[name=siteMapSrvm_dup]").hide();			//중복확인 버튼 숨김(수정못함)
	formObj.find("input[name=dupChk]").val("Y");				//중복체크 Y로
	formObj.find("input[name=srvmId]").attr("readonly", true);	//분류ID 수정 못하도록 변경
	
	//이미지 표시
	formObj.find("#tmnlImgFileImg").attr("src", "/admin/nadata/siteMap/selectThumbnail.do?" + "srvmId=" + data.DATA.srvmId + "&thumbKind=preView");
	formObj.find("#tmnl2ImgFileImg").attr("src", "/admin/nadata/siteMap/selectThumbnail.do?" + "srvmId=" + data.DATA.srvmId + "&thumbKind=siteMap");
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
	var formObj = getTabFormObj("naDataSiteMap-dtl-form");
	if ( data.dupCnt > 0 ) {
		alert("중복되는 ID가 있습니다.\n다른 ID를 입력해 주세요.");
		formObj.find("input[name=srvmId]").focus();
		formObj.find("input[name=dupChk]").val("N");
	} else {
		alert("사용가능한 ID 입니다.");
		formObj.find("input[name=dupChk]").val("Y");
		formObj.find("input[name=srvmId]").attr("readonly", true);	//중복체크 완료 후 단위ID변경 불가
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
	var formObj = getTabFormObj("naDataSiteMap-dtl-form");
	formObj.find("input[name=srvmId]").attr("readonly", false).removeClass("readonly");
	formObj.find("input[name=useYn][value=Y]").prop("checked", true);
}
//상세 탭 이벤트
function tabEvent(row){//탭 이벤트 실행  
	var title = sheet.GetCellValue(row, "srvmNm");//탭 제목
	var id = sheet.GetCellValue(row, "srvmId");//탭 id(유일한key))
	openTab.SetTabData(sheet.GetRowJson(row));//db data 조회시 조건 data
	var url =  com.wise.help.url('/admin/nadata/siteMap/naDataSiteMapDtl.do'); // Controller 호출 url 
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
	var formObj = getTabFormObj("naDataSiteMap-dtl-form");
	
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
	formObj.find("button[name=siteMapSrvm_dup]").bind("click", function() {
		//사이트맵ID 중복체크
		doAction("dupChk");
	});
	formObj.find("input[name=srvmId]").keypress(function(e) {
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
	
	var gridTitle = "NO|상태|서비스맵ID|서비스맵명|관련부서|URL|주요서비스|정상서비스여부|사용여부";
	
	with(sheet){
        
		var cfg = {SearchMode:3,Page:50,VScrollMode:1};
	    SetConfig(cfg);
	    var headers = [
	                {Text:gridTitle, Align:"Center"}
	            ];
	    var headerInfo = {Sort:1,ColMove:1,ColResize:1,HeaderCheck:0};
	    
	    InitHeaders(headers, headerInfo);
	   
	    var cols = [
	                 {Type:"Seq",		SaveName:"seq",				Width:30,	Align:"Center",	Edit:false}
	                ,{Type:"Status",	SaveName:"status",			Width:30,	Align:"Center",	Edit:false}
	                ,{Type:"Text",		SaveName:"srvmId",			Width:50,	Align:"Center",	Edit:false}
					,{Type:"Text",		SaveName:"srvmNm",			Width:100,	Align:"Left",	Edit:false}
					,{Type:"Text",		SaveName:"orgNm",			Width:60,	Align:"Center",	Edit:false}
					,{Type:"Text",		SaveName:"srcUrl",			Width:120,	Align:"Left",	Edit:false}
					,{Type:"Text",		SaveName:"infoSmryExp",		Width:150,	Align:"Left",	Edit:false}
					,{Type:"Combo",		SaveName:"viewYn",			Width:30,	Align:"Center",	Edit:false, TrueValue:"N", FalseValue:"Y"}
					,{Type:"Combo",		SaveName:"useYn",			Width:30,	Align:"Center",	Edit:false, TrueValue:"N", FalseValue:"Y"}
					,{Type:"Int",		SaveName:"vOrder",			Width:30,	Align:"Center",	Edit:false,	Hidden:true}
	            ];                                          
	    InitColumns(cols);
	    FitColWidth();
	    SetExtendLastCol(1);

	    initSheetOptions("sheet", 0, "useYn", [{code:"Y",name:"사용"}, {code:"N",name:"미사용"}]);
	    initSheetOptions("sheet", 0, "viewYn", [{code:"Y",name:"정상"}, {code:"N",name:"비정상"}]);
	    
	    loadSheetOptions("sheet", 0, "openState", "/admin/stat/ajaxOption.do", {grpCd:"S1009"});	// 공개상태
	    
	}               
	default_sheet(sheet);
	
}

////////////////////////////////////////////////////////////////////////////////
//Validation 함수
////////////////////////////////////////////////////////////////////////////////

function saveValidation(action) {
	var objTab = getTabShowObj();//탭이 oepn된 객체가져옴
	var formObj = objTab.find("form[name=naDataSiteMap-dtl-form]");
	
	if ( formObj.find("input[name=dupChk]").val() == "N" ) {
		alert("사이트맵ID 중복체크 하세요.");
		formObj.find("input[name=srvmId]").focus();
		return false;
	}
	if ( com.wise.util.isNull(formObj.find("input[name=srvmNm]").val()) ) {
		alert("사이트맵명을 입력하세요.");
		formObj.find("input[name=srvmNm]").focus();
		return false;
	} else if ( !com.wise.util.isLength(formObj.find("input[name=srvmNm]").val(), 1, 200) ) {
		alert("200자 이내로 입력하세요.");
		formObj.find("input[name=cateNm]").focus();
		return false;
	}
	if ( com.wise.util.isNull(formObj.find("select[name=orgCd]").val()) ) {
		alert("관련기관을 선택하세요.");
		formObj.find("button[name=orgCd]").focus();
		return false;
	}
	if ( com.wise.util.isNull(formObj.find("input[name=srcUrl]").val()) ) {
		alert("바로가기 url을 입력하세요");
		formObj.find("button[name=srcUrl]").focus();
		return false;
	}
	/* 필수체크 제거
	if ( action == "I" ) {	//등록인 경우 파일 필수
		if ( com.wise.util.isNull(formObj.find("input[name=cateFile]").val()) ) {
			alert("파일을 선택하세요.");
			formObj.find("input[name=cateFile]").focus();
			return false;
		} 
	}
	*/
	
	if( !com.wise.util.isNull(formObj.find("input[name=tmnlImgFile]").val()) ) {
		var ext = formObj.find("input[name=tmnlImgFile]").val().split('.').pop().toLowerCase();
		if($.inArray(ext, ['gif','png','jpg','jpeg', 'bmp']) == -1) {
			 alert('gif, png, jpg, jpeg, bmp 파일만 업로드 할수 있습니다.');
			 return false;
		}
	}
	if( !com.wise.util.isNull(formObj.find("input[name=tmnl2ImgFile]").val()) ) {
		var ext = formObj.find("input[name=tmnl2ImgFile]").val().split('.').pop().toLowerCase();
		if($.inArray(ext, ['gif','png','jpg','jpeg', 'bmp']) == -1) {
			 alert('gif, png, jpg, jpeg, bmp 파일만 업로드 할수 있습니다.');
			 return false;
		}
	}
	
	return true;
}

// 분류/인원 정보 등록 전 validation
function SheetValidation(sheetObj) {
	sheetObj.ExtendValidFail = 0;
	var sheetJson = sheetObj.GetSaveJson({AllSave:true, ValidKeyField: 1});
	var rpstYns = "";	// 분류정보 대표여부 체크
	
	if (sheetJson.Code) {
        switch (sheetJson.Code) {
            case "IBS000":
                alert("저장할 내역이 없습니다.");
                break;
            case "IBS010":
            case "IBS020":
                // Nothing to do.
                break;
        }
        return false;
    } 
	
	// 대표여부 체크여부
	for ( var i=1; i <= sheetObj.RowCount(); i++ ) {
		if ( sheetObj.GetCellValue(i, "status") !== "D" ) {	// 삭제하는 행은 제외
			rpstYns = rpstYns + sheetObj.GetCellValue(i, "rpstYn");
		}
	}
	if ( rpstYns.indexOf('Y') == -1 ) {
		alert("대표자(대표여부)를 선택하세요.");
		return false;
	}
	return true;
}

