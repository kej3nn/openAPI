/*
 * @(#)devMng.js 1.0 2020/06/16
 */

/**
 * 관리자에서 개발자를 관리하는 스크립트
 *  @author JSSON
 *  @version 1.0 2020/06/16
 */

$(function() {
	// 컴포넌트를 초기화한다.
	initComp();
	
	// 이벤트를 바인딩한다.
	bindEvent();
	
	// 옵션을 로드한다.
	loadOptions();
	
	// 데이터를 로드한다.
	loadData();
});

/**
 * 컴포넌트를 초기화한다.
 */
function initComp() {
	// 시트 그리드를 생성한다.
	loadSheet();
}


/**
 * 이벤트를 바인딩한다.
 */

function bindEvent() {
	
	
	// 바이트 체크
	fn_textareaLengthChk($("#emailContent"), 'len1', 500);
	fn_textareaLengthChk($("#hpContent"), 'len2', 500);
	fn_textareaLengthChk($("#kakaoContent"), 'len3', 500);
	
	
	//전송 메시지 작성 팝업
    $("#btnEmail").bind("click", function() {
    	if (checkBoxNnullchk()) {
			return;
		}
    	
    	var sect = $("div[id=email-sect]");
    	sect.show().focus();
    	$("#email-sect-pop").css("top",  (($(window).height() - $("#email-sect-pop").height()) / 2) + "px");    	
    	
    });
    $("#btnHp").bind("click", function() {
    	if (checkBoxNnullchk()) {
			return;
		}
    	var sect = $("div[id=hp-sect]");
    	sect.show().focus();
    	$("#hp-sect-pop").css("top",  (($(window).height() - $("#hp-sect-pop").height()) / 2) + "px");    	
    });
    $("#btnKakao").bind("click", function() {
    	if (checkBoxNnullchk()) {
			return;
		}
    	var sect = $("div[id=kakao-sect]");
    	sect.show().focus();
    	$("#kakao-sect-pop").css("top",  (($(window).height() - $("#kakao-sect-pop").height()) / 2) + "px");    	
    });
	
	$("button[name=btn_inquiry]").bind("click", function(e) {
		doAction("search");
	});
	
	// 조회 enter
	$("input[name=searchVal]").bind("keydown", function(e){
		// 엔터키인 경우
		if (e.which == 13) {
			doAction("search");
			return false;
		}
	});
	
	/* 이메일 전송 팝업창 닫기 */
	$("#btnEmailPopX").bind("click", function(event) {
		$("#email-sect").hide();
	});
	/* SMS 전송 팝업창 닫기 */
	$("#btnHpPopX").bind("click", function(event) {
		$("#hp-sect").hide();
	});
	/* 카카오 전송 팝업창 닫기 */
	$("#btnKakaoPopX").bind("click", function(event) {
		$("#kakao-sect").hide();
	});
	/* 이메일 전송 팝업창 열기 */
	$("#sendEmail").bind("click", function(event) {
		
		doAction("sendEmail");
	});
	$("#sendKakao").bind("click", function(event) {
		doAction("sendKakao");
	});
	$("#sendHp").bind("click", function(event) {
		doAction("sendHp");
	});
	
}

/**
 * 데이터를 로드한다.
 */
function loadData() {
	doAction("search");
}

////////////////////////////////////////////////////////////////////////////////
//시트 로드
////////////////////////////////////////////////////////////////////////////////
function loadSheet() {
	
createIBSheet2(document.getElementById("sheet"),"sheet", "100%", "350px");	// InfoSetMain Sheet
	
	var gridTitle = "선택|개발자ID|개발자명|이메일(수신)|SMS(수신)|알림톡(수신)|갤러리등록|인증키등록|최종등록일자";
	
	with(sheet){
      
		var cfg = {SearchMode:3,Page:50,VScrollMode:1};
	    SetConfig(cfg);
	    var headers = [
	                {Text:gridTitle, Align:"Center", MergeSheet:msHeaderOnly, SumPosition:1}
	            ];
	    var headerInfo = {Sort:1,ColMove:1,ColResize:1,HeaderCheck:1};
	    
	    InitHeaders(headers, headerInfo);
	   
	    var cols = [
	                 {Type:"CheckBox",		SaveName:"dvpCheck",		Width:30,	Align:"Center",	 Edit:true}
	                ,{Type:"Text",			SaveName:"userId",			Width:50,	Align:"Center",	 Edit:false}
	                ,{Type:"Text",			SaveName:"userNm",			Width:200,	Align:"Center",	 Edit:false}
	                ,{Type:"Text",			SaveName:"dvpEmailYn",		Width:90,	Align:"Center",	 Edit:false}
	                ,{Type:"Text",			SaveName:"dvpHpYn",			Width:90,	Align:"Center",	 Edit:false}
	                ,{Type:"Text",			SaveName:"dvpKakaoYn",		Width:90,	Align:"Center",	 Edit:false}
	                ,{Type:"Text",			SaveName:"galleryCnt",		Width:90,	Align:"Center",	 Edit:false}
	                ,{Type:"Text",			SaveName:"keyCnt",			Width:90,	Align:"Center",	 Edit:false}
	                ,{Type:"Text",			SaveName:"userDttm",		Width:90,	Align:"Center",	 Edit:false}
	            ];                                          
	    InitColumns(cols);
	    FitColWidth();
	    SetExtendLastCol(1);
	    
	 //   initSheetOptions("sheet", 0, "useYn", [{code:"Y",name:"사용"}, {code:"N",name:"미사용"}]);
	 //   initSheetOptions("sheet", 0, "viewYn", [{code:"Y",name:"사용"}, {code:"N",name:"미사용"}]);
	}               
	default_sheet(sheet);
	
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
	var formObj = $("form[name=devMngForm");
	var emailFormObj = $("form[name=emailForm");
	var hpFormObj = $("form[name=hpForm");
	var kakaoFormObj = $("form[name=kakaoForm");
	var sheet = window["sheet"];
	
	var params = {};
	var strChkRows = sheet.FindCheckedRow("dvpCheck");
	var chkRows = strChkRows.split('|');
	
	
	switch(sAction) {
	case "search":
		ajaxBeforeSendAdmin(com.wise.help.url("/admin/ajaxBeforeSendAdmin.do"));  //IbSheet 조회전 세션 체크
		var param = {PageParam: "page", Param: "rows=50"+"&"+formObj.serialize()};
		sheet.DoSearchPaging(com.wise.help.url("/admin/dev/selectDevMngListPaging.do"), param);
		break;
	case "sendHp":
		var userId = [];
		var hpYn = [];
		for ( var i=0; i < chkRows.length; i++ ) {
			userId.push(sheet.GetCellValue(chkRows[i], "userId"));
			hpYn.push(sheet.GetCellValue(chkRows[i], "dvpHpYn"));
		}
		params["userId"] = userId;
		params["hpYn"] = hpYn;
		params["hpSendYn"] = 'Y';
		params["msg_body"] = $("#hpContent").val();
		
		if ( !confirm("전송 하시겠습니까?") )	return false;
		doAjax({
			url : "/admin/dev/insertDevReceive.do",
			params : params,
			//succUrl : "/admin/stat/statInputPage.do" + (valueCd ? "?valueCd=" + valueCd : "")
			callback : function(res){
				$("#hpContent").val("");
				$("#hp-sect").hide();
			}
		});
		break;
	case "sendKakao":
		var userId = [];
		var kakaoYn = [];
		for ( var i=0; i < chkRows.length; i++ ) {
			userId.push(sheet.GetCellValue(chkRows[i], "userId"));
			kakaoYn.push(sheet.GetCellValue(chkRows[i], "dvpKakaoYn"));
		}
		params["userId"] = userId;
		params["kakaoYn"] = kakaoYn;
		params["kakaoSendYn"] = 'Y';
		params["msg_body"] = $("#kakaoContent").val();
		
		
		if ( !confirm("전송 하시겠습니까?") )	return false;
		doAjax({
			url : "/admin/dev/insertDevReceive.do",
			params : params,
			//succUrl : "/admin/stat/statInputPage.do" + (valueCd ? "?valueCd=" + valueCd : "")
			callback : function(res){
				$("#kakaoContent").val("");
				$("#kakao-sect").hide();
			}
		});
		break;
	case "sendEmail":
		var userId = [];
		var emailYn = [];
		for ( var i=0; i < chkRows.length; i++) {
			userId.push(sheet.GetCellValue(chkRows[i], "userId"));
			emailYn.push(sheet.GetCellValue(chkRows[i], "dvpEmailYn"));
		}
		params["userId"] = userId;
		params["emailYn"] = emailYn;
		params["emailSendYn"] = 'Y';
		params["msg_body"] =  $("#emailContent").val();
		
		if ( !confirm("전송 하시겠습니까?") )	return false;
		doAjax({
			url : "/admin/dev/insertDevReceive.do",
			params : params,
			//succUrl : "/admin/stat/statInputPage.do" + (valueCd ? "?valueCd=" + valueCd : "")
			callback : function(res){
				$("#emailContent").val("");
				$("#email-sect").hide();
			}
		});
		
		break;
	}
	
}


/**
 * 관리자 팝업을 숨긴다. 
 */
function gfn_hidePopup() {
	//$(".btn_pop_x").closest("div").hide();
}
/**
 * 관리자 팝업열기. 
 */
function gfn_showPopup(popupNm) {
	var popupNm = $("." + popupNm);
	popupNm.css("position", "absolute");
    //영역 가운에데 레이어를 뛰우기 위해 위치 계산 
	popupNm.css("top",(($(window).height() - popupNm.outerHeight()) / 2) + popupNm.scrollTop());
	popupNm.css("left",(($(window).width() - popupNm.outerWidth()) / 2) + popupNm.scrollLeft());
	popupNm.draggable();
	popupNm.show();
}

function checkBoxNnullchk(){
	var sheet = window["sheet"];
	var strChkRows = sheet.FindCheckedRow("dvpCheck");
	
	if (strChkRows == null || strChkRows =="" ) {  
		alert("개발자를 선택해주세요");
		return true;
	}
	return false;
	
}


