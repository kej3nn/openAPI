/*
 * @(#)openApiLinkageMng.js 1.0 2017/07/03
 * 
 * COPYRIGHT (C) 2013 WISEITECH CO., LTD. ALL RIGHTS RESERVED.
 */

/**
 * 관리자 API연계모니터링 스크립트 파일이다
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
    
    //날짜를 로드한다.
    setDate();
    
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
	// API연계모니터링 시트 그리드를 생성한다.
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
	
	//조회 enter
	$("input[name=searchVal]").bind("keydown", function(event) {
        // 엔터키인 경우
        if (event.which == 13) {
        	doAction("search");
            return false;
        }
    });
	
}


/**
 * 날짜를 로드한다.
 */
function setDate() {
	var formObj = $("form[name=mail-monitor-form]");
	var now = new Date();		
	var year = now.getFullYear();
	var mon = (now.getMonth()+1)>9?now.getMonth()+1:'0'+(now.getMonth()+1);
	var day = now.getDate()>9?now.getDate():'0'+now.getDate();
	var date=year+'-'+mon+'-'+day;
	//formObj.find("input[name=regStartDtts]").val(date);
	formObj.find("input[name=regStartDtts]").datepicker(setCalendar()); 
	//formObj.find("input[name=regEndDtts]").val(date);             
	formObj.find("input[name=regEndDtts]").datepicker(setCalendar()); 
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
	var formObj = $("form[name=mail-monitor-form]"); 

	switch(sAction) {                       
		case "search":
			fromObj = formObj.find("input[name=regStartDtts]");                          
			toObj = formObj.find("input[name=regEndDtts]");
			dateValCheck(fromObj,toObj)// from , to 날짜 안맞을 경우 자동셋팅 
			ajaxBeforeSendAdmin(com.wise.help.url("/admin/ajaxBeforeSendAdmin.do")); //IbSheet 조회전 세션 체크
			var param = {PageParam: "page", Param: "rows=50"+"&"+formObj.serialize()};
			sheet.DoSearchPaging(com.wise.help.url("/admin/monitor/mailSendMonListPaging.do"), param);
			break;
		case "excel":
			sheet.Down2Excel({FileName:'Excel.xls',SheetName:'sheet'});
			
			break;
	}
}

////////////////////////////////////////////////////////////////////////////////
// 전처리 함수
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// 후처리 함수
////////////////////////////////////////////////////////////////////////////////




////////////////////////////////////////////////////////////////////////////////
//시트 로드
////////////////////////////////////////////////////////////////////////////////
function loadSheet() {
	
	createIBSheet2(document.getElementById("sheet"),"sheet", "100%", "300px");
	
	var gridTitle ="NO";
	gridTitle +="|메일SEQ";
	gridTitle +="|제목";
	gridTitle +="|수신자";
	gridTitle +="|전송요청일자";
	gridTitle +="|전송일자";
	gridTitle +="|상태";
	gridTitle +="|상태메세지";
	gridTitle +="|재전송";

	
	with(sheet){
		                     
		var cfg = {SearchMode:3,Page:50,VScrollMode:1};
	    SetConfig(cfg);
	    var headers = [
	                {Text:gridTitle, Align:"Center"}
	            ];
	    var headerInfo = {Sort:1,ColMove:1,ColResize:1,HeaderCheck:0};
	    
	    InitHeaders(headers, headerInfo);
	   
	    var cols = [
	                 {Type:"Seq",		SaveName:"seq",			   Width:30,	Align:"Center",		Edit:false}
					,{Type:"Text",		SaveName:"seqidx",	       Width:30,	Align:"Center",		Edit:false}
					,{Type:"Text",		SaveName:"subject",		   Width:80,	Align:"Left",		Edit:false}
					,{Type:"Text",		SaveName:"mailto",	   Width:80,	Align:"Left",		Edit:false}
					,{Type:"Text",		SaveName:"sdate",	   Width:40,	Align:"Center",		Edit:false}
					,{Type:"Text",		SaveName:"stime",	   Width:40,	Align:"Center",		Edit:false}
					//,{Type:"Text",		SaveName:"errcode",        Width:50,	Align:"Center",		Edit:false, }
					,{Type:"Text",		SaveName:"errname",        Width:50,	Align:"Center",		Edit:false, }
					,{Type:"Text",		SaveName:"message",        Width:50,	Align:"Center",		Edit:false, }
					,{Type:"Button",		SaveName:"reSendButton",        Width:50,	Align:"Center",		Edit:true, }
					
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


function sheet_OnSearchEnd(code, message, statusCode, statusMessage) {
	if(message != "")      
	{
	    alert(message);
    } 
}

function sheet_OnButtonClick(row, col) {
	console.log("row : " + row + ", col : " + col);
	var seqidx = sheet.GetCellValue(row,"seqidx");
	console.log(seqidx);
	$.ajax({
		url: "/admin/monitor/insertMailReSend.do",
		async: false,
		type: "POST",
		data: {seqidx : seqidx},
		dataType: "json",
	}).done(function(data) {
		//alert(data.success.message);
		alert("전송 완료.");
		doAction("search");
	}).fail(function(xhr) {
		console.log(xhr);
		alert("메세지 재전송에 실패 하였습니다.");
	})
}
////////////////////////////////////////////////////////////////////////////////
//이벤트 함수
////////////////////////////////////////////////////////////////////////////////
