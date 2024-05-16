/*
 * @(#)naSetCase.js 1.0 2019/07/29
 * 
 * COPYRIGHT (C) 2013 WISEITECH CO., LTD. ALL RIGHTS RESERVED.
 */

/**
 * 관리자 정보카달로그분류 스크립트 파일이다
 *
 * @author 
 * @version 1.0 2019/09/18
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
	
	$('input[name=chkTreeOpenClose]').click(function(){
		var sheet = window["sheet"];
		var isChecked = $(this).prop("checked");
		// 트리 항목 펼치기
		if ( isChecked ) {
			sheet.ShowTreeLevel(-1);
			$('label:contains(항목펼치기)').text('항목접기');
		}else  {
			sheet.ShowTreeLevel(0);
			$('label:contains(항목접기)').text('항목펼치기');
		}
	});
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
}


/**
 * 옵션을 로드한다.
 */
function loadOptions() {
	
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
	var mainFormObj = $("form[name=naSetMainForm]");
	var formObj = getTabFormObj("naSetCate-dtl-form");
	var sheet = window["sheet"];
	var cateTag =  formObj.find("input[name=cateTag]").val();
	
	switch(sAction) {                       
		case "search":
			ajaxBeforeSendAdmin(com.wise.help.url("/admin/ajaxBeforeSendAdmin.do")); //IbSheet 조회전 세션 체크
			var param = {PageParam: "ibpage", Param: "onepagerow=50"+"&"+mainFormObj.serialize()};
			sheet.DoSearchPaging(com.wise.help.url("/admin/nadata/cate/naSetCateList.do"), param);
			break;
		case "regForm" :
			var title = "신규등록"
			var id ="statReg";
			openTab.addRegTab(id, title, tabCallRegBack);
			break;
		case "dupChk" : 
			doPost({
                url:"/admin/nadata/cate/naSetCateDupChk.do",
                before : beforeStatSttsCateDupChk,
                after : afterStatSttsCateDupChk
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
				url : "/admin/nadata/cate/deleteNaSetCate.do",
				params : "cateId=" + formObj.find("input[name=cateId]").val(),
				callback : afterTabRemove
			});
			break;	
		case "naSetCatePop" :
			//var url = com.wise.help.url("/admin/stat/popup/statSttsCatePop.do");
			//OpenWindow(url,"sttsCatePop","700","550","yes");
			var url = com.wise.help.url("/admin/nadata/cate/popup/naSetCatePop.do");
			var data = "?parentFormNm=naSetCate-dtl-form&cateTag="+cateTag;
			wWidth ="660";                                                    
			wHeight ="530";   
			openIframeStatPop("iframePopUp", url+data, wWidth, wHeight)
			break;
		case "naSetCateInit" : 
			formObj.find("input[name=parCateId]").val("T");
			formObj.find("input[name=parCateNm]").val("최상위");
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
                PageUrl:"/admin/nadata/cate/saveNaSetCateOrder.do"
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
	var formObj = getTabFormObj("naSetCate-dtl-form");
	formObj.ajaxSubmit({
		url : com.wise.help.url("/admin/nadata/cate/saveNaSetCate.do")
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
			//doAjaxMsg(res, "/admin/stat/statSttsCatePage.do");
			doAjaxMsg(res, "");
			afterTabRemove(res)
		}
		, error: function(jqXHR, textStatus, errorThrown) {
			alert("처리 도중 에러가 발생하였습니다.");
		}
	});
}


////////////////////////////////////////////////////////////////////////////////
// 전처리 함수
////////////////////////////////////////////////////////////////////////////////
/**
 * 분류ID 중복체크 전처리 함수
 */
function beforeStatSttsCateDupChk(options) {
	var formObj = getTabFormObj("naSetCate-dtl-form");
	var cateId = formObj.find("input[name=cateId]").val().trim().toUpperCase();
    var data = {
        "cateId" : cateId
    };
    if ( com.wise.util.isBlank(data.cateId) ) {
    	alert("분류ID를 입력하세요.");
    	formObj.find("input[name=cateId]").focus();
        return null;
    }
    
    formObj.find("input[name=cateId]").val(cateId);	//소문자로 입력되어있을경우 대문자로 변경해서 보여줌
    
    if ( !com.wise.util.isAlphaNumeric(data.cateId) || !com.wise.util.isLength(data.cateId, 1, 10) ) {
    	alert("영문, 숫자 10자리 이내로 입력하세요.");
    	formObj.find("input[name=cateId]").val("").focus();
        return null;
    }
    
    return data;
}

////////////////////////////////////////////////////////////////////////////////
// 후처리 함수
////////////////////////////////////////////////////////////////////////////////
//상세 탭 이벤트 후처리
function tabFunction(tab, data) {
	var formObj = getTabFormObj("naSetCate-dtl-form");
	formObj.find("button[name=sttsCate_dup]").hide();			//중복확인 버튼 숨김(수정못함)
	formObj.find("input[name=dupChk]").val("Y");				//중복체크 Y로
	formObj.find("input[name=cateId]").attr("readonly", true);	//분류ID 수정 못하도록 변경
	
	//이미지 표시
	formObj.find("#cateImg").attr("src", "/admin/nadata/cate/selectThumbnail.do?" + "cateId=" + data.DATA.cateId);
}
/**
 * 트리 자식 데이터 로드
 */
function sheet_OnTreeChild(row) {
	var itmId = sheet.GetCellValue(row, "itmId");
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
 * 분류ID 중복체크 후처리
 * @param data	return value
 */
function afterStatSttsCateDupChk(data) {
	var formObj = getTabFormObj("naSetCate-dtl-form");
	if ( data.dupCnt > 0 ) {
		alert("중복되는 ID가 있습니다.\n다른 ID를 입력해 주세요.");
		formObj.find("input[name=cateId]").focus();
		formObj.find("input[name=dupChk]").val("N");
	} else {
		alert("사용가능한 ID 입니다.");
		formObj.find("input[name=dupChk]").val("Y");
		formObj.find("input[name=cateId]").attr("readonly", true);	//중복체크 완료 후 단위ID변경 불가
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
function regUserFunction() {
	var formObj = getTabFormObj("naSetCate-dtl-form");
	formObj.find("input[name=cateId]").attr("readonly", false).removeClass("readonly");
	formObj.find("input[name=useYn][value=Y]").prop("checked", true);
	//등록시 초기세팅 최상위(1레벨)로..
	formObj.find("input[name=parCateId]").val('T');
	formObj.find("input[name=parCateNm]").val('최상위');
}
//상세 탭 이벤트
function tabEvent(row){//탭 이벤트 실행  
	var title = sheet.GetCellValue(row, "cateNm");//탭 제목
	var id = sheet.GetCellValue(row, "cateId");//탭 id(유일한key))
	openTab.SetTabData(sheet.GetRowJson(row));//db data 조회시 조건 data
	var url =  com.wise.help.url('/admin/nadata/cate/naSetCateDtl.do'); // Controller 호출 url 
	openTab.addTab(id, title, url, tabCallBack); 	// 탭 추가 시작함
} 

////////////////////////////////////////////////////////////////////////////////
//시트 로드
////////////////////////////////////////////////////////////////////////////////
function loadSheet() {
	
	createIBSheet2(document.getElementById("sheet"),"sheet", "100%", "300px");
	
	var gridTitle ="NO";
	gridTitle +="|상태";
	gridTitle +="|분류ID";
	gridTitle +="|한글분류명";
	gridTitle +="|영문분류명";
	gridTitle +="|분류 전체명";
	gridTitle +="|레벨";
	gridTitle +="|순서";
	gridTitle +="|사용여부";
	
	with(sheet){
		                     
		//var cfg = {SearchMode:2,Page:50,VScrollMode:1};
		var cfg = {SearchMode:smLazyLoad,ChildPage:5,VScrollMode:1};
	    SetConfig(cfg);
	    var headers = [
	                {Text:gridTitle, Align:"Center"}
	            ];
	    var headerInfo = {Sort:0,ColMove:1,ColResize:1,HeaderCheck:0};
	    
	    InitHeaders(headers, headerInfo);
	   
	    var cols = [
	                 {Type:"Seq",		SaveName:"seq",			Width:30,	Align:"Center",		Edit:false}
	                ,{Type:"Status",	SaveName:"status",		Width:30,	Align:"Center",		Edit:false} 
					,{Type:"Text",		SaveName:"cateId",		Width:70,	Align:"Center",		Edit:false}
					,{Type:"Text",		SaveName:"cateNm",		Width:260,	Align:"Left",		Edit:false,	TreeCol:1}
					,{Type:"Text",		SaveName:"engCateNm",	Width:230,	Align:"Left",		Edit:false}
					,{Type:"Text",		SaveName:"cateFullNm",	Width:200,	Align:"Left",		Edit:false}
					,{Type:"Int",		SaveName:"Level",		Width:60,	Align:"Center",		Edit:false,	Hidden:true}
					,{Type:"Int",		SaveName:"vOrder",		Width:60,	Align:"Center",		Edit:false,	Hidden:false}
					,{Type:"Combo",		SaveName:"useYn",		Width:60,	Align:"Center",		Edit:false, TrueValue:"N", FalseValue:"Y"}
	            ];                                          
	    InitColumns(cols);
	    FitColWidth();
	    SetExtendLastCol(1);
	    
	    initSheetOptions("sheet", 0, "useYn", [{code:"Y",name:"사용"}, {code:"N",name:"미사용"}]);
	    
	    ShowTreeLevel(0, 1);
	    SetCountPosition(0);
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
	//toggleShowHideOrderBtn("statMainForm");		//조회 후 순서관련 버튼 숨김
}
////////////////////////////////////////////////////////////////////////////////
//이벤트 함수
////////////////////////////////////////////////////////////////////////////////
/**
 * 탭 이벤트를 바인딩한다.
 */
function setTabButton() {
	var formObj = getTabFormObj("naSetCate-dtl-form");
	
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
	formObj.find("button[name=naSetCate_pop]").bind("click", function() {
		//분류 팝업
		doAction("naSetCatePop");
	});
	formObj.find("button[name=naSetCate_init]").bind("click", function() {
		//분류 초기화
		doAction("naSetCateInit");
	});
	formObj.find("button[name=naSetCate_dup]").bind("click", function() {
		//분류ID 중복체크
		doAction("dupChk");
	});
	formObj.find("input[name=cateId]").keypress(function(e) {
		  if(e.which == 13) {
			  doAction('dupChk');   
			  return false;        
		  }
	});
	
}
////////////////////////////////////////////////////////////////////////////////
//Validation 함수
////////////////////////////////////////////////////////////////////////////////
/**
 * 등록/수정 validation 
 */
function saveValidation(action) {
	var objTab = getTabShowObj();//탭이 oepn된 객체가져옴
	var formObj = objTab.find("form[name=naSetCate-dtl-form]");
	
	if ( formObj.find("input[name=dupChk]").val() == "N" ) {
		alert("분류ID 중복체크 하세요.");
		formObj.find("input[name=cateId]").focus();
		return false;
	}
	if ( com.wise.util.isNull(formObj.find("input[name=cateNm]").val()) ) {
		alert("분류명을 입력하세요.");
		formObj.find("input[name=cateNm]").focus();
		return false;
	} else if ( !com.wise.util.isLength(formObj.find("input[name=cateNm]").val(), 1, 200) ) {
		alert("200자 이내로 입력하세요.");
		formObj.find("input[name=cateNm]").focus();
		return false;
	}
	if ( com.wise.util.isNull(formObj.find("input[name=parCateId]").val()) ) {
		alert("상위분류를 선택하세요.");
		formObj.find("button[name=naSetCate_pop]").focus();
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
	
	if( !com.wise.util.isNull(formObj.find("input[name=cateFile]").val()) ) {
		var ext = formObj.find("input[name=cateFile]").val().split('.').pop().toLowerCase();
		if($.inArray(ext, ['gif','png','jpg','jpeg', 'bmp']) == -1) {
			 alert('gif, png, jpg, jpeg, bmp 파일만 업로드 할수 있습니다.');
			 return false;
		}
	}
	
	return true;
}

