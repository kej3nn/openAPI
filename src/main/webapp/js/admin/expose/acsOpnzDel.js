/*
 * @(#)acsOpnzDel.js 1.0 2020/09/16
 * 
 * COPYRIGHT (C) 2013 WISEITECH CO., LTD. ALL RIGHTS RESERVED.
 */

/**
 * 청구인정보 기록삭제 스크립트 파일이다
 *
 * @author 최성빈
 * @version 1.0 2020/09/16
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
	
	$("input[name=startAplDt], input[name=endAplDt], input[name=startDcsNtcDt], input[name=endDcsNtcDt], input[name=startDelDt], input[name=endDelDt]")
		.datepicker(com.wise.help.datepicker({
        buttonImage:com.wise.help.url("/images/admin/icon_calendar.png")
    }));
	
	$("input[name=startAplDt]").datepicker("option", "onClose",  function( selectedDate ) {
		$("input[name=endAplDt]").datepicker( "option", "minDate", selectedDate );
	});
	$("input[name=endAplDt]").datepicker("option", "onClose",  function( selectedDate ) {	
		$("input[name=startAplDt]").datepicker( "option", "maxDate", selectedDate );
	});
	
	$("input[name=startDcsNtcDt]").datepicker("option", "onClose",  function( selectedDate ) {
		$("input[name=endDcsNtcDt]").datepicker( "option", "minDate", selectedDate );
	});
	$("input[name=endDcsNtcDt]").datepicker("option", "onClose",  function( selectedDate ) {	
		$("input[name=startDcsNtcDt]").datepicker( "option", "maxDate", selectedDate );
	});
	
	$("input[name=startDelDt]").datepicker("option", "onClose",  function( selectedDate ) {
		$("input[name=endDelDt]").datepicker( "option", "minDate", selectedDate );
	});
	$("input[name=endDelDt]").datepicker("option", "onClose",  function( selectedDate ) {	
		$("input[name=startDelDt]").datepicker( "option", "maxDate", selectedDate );
	});
	
	//$("input[name=startAplDt]").val(today());
	//$("input[name=endAplDt]").val(today());	
	
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

	//조회 enter
	$("form[name=statMainForm ] input:text").bind("keydown", function(event) {
        // 엔터키인 경우
        if (event.which == 13) {
        	doAction("search");
            return false;
        }
    });
	
	//엑셀 다운로
	$("button[name=btn_xlsDown]").bind("click", function(event) {
		doAction("excel");
    });
	
	//청구일자 초기화 
	$("button[name=aplDt_reset]").bind("click", function(e) {
		$("input[name=startAplDt], input[name=endAplDt]").val("");
	});
	
	//통지일자 초기화
	$("button[name=dcsNtcDt_reset]").bind("click", function(e) {
		$("input[name=startDcsNtcDt], input[name=endDcsNtcDt]").val("");
	});
	
	//삭제일자 초기화
	$("button[name=delDt_reset]").bind("click", function(e) {
		$("input[name=startDelDt], input[name=endDelDt]").val("");
	});
	
	//청구일기준 10년 이상 자료 버튼 날짜 세팅
	$("button[name=aplDt_set]").bind("click", function(e) {
		$("input[name=startAplDt]").val(today(-10));
		$("input[name=endAplDt]").val(today());
	});
	
	//통지일기준 10년 이상 자료 버튼 날짜 세팅
	$("button[name=dcsNtc_set]").bind("click", function(e) {
		$("input[name=startDcsNtcDt]").val(today(-10));
		$("input[name=endDcsNtcDt]").val(today());
	});
	
	//즉시처리건 조회 체크박스 보이기/숨기기 
	$("select[name=prgStatCd]").bind("change", function(event) {
		var val = $(this).val();
		$("input[name=imdDealDiv]").prop("checked",false);   
		
		if(val == "04"){ //처리상태가 결정통지일때
			$("#imdDealDivArea").css("display", "block");
		}else{
			$("#imdDealDivArea").css("display", "none");
		}
	});
	
	$("button[name=btn_del]").bind("click", function(event) {
		//수정
		doAction("update");
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
	switch(sAction) {                       
		case "search":
			ajaxBeforeSendAdmin(com.wise.help.url("/admin/ajaxBeforeSendAdmin.do")); //IbSheet 조회전 세션 체크
			var param = {PageParam: "page", Param: "rows=50"+"&"+$("form[name=statMainForm]").serialize()};
			sheet.DoSearchPaging(com.wise.help.url("/admin/expose/acsOpnzDelList.do"), param);
			break;
			
		case "update" :
			if ( !confirm("삭제 하시겠습니까?") )	return false;
			saveSheetData({
                SheetId:"sheet",
                PageUrl:"/admin/expose/saveAcsOpnzDel.do"
            }, {
            	//not thing to do
            }, {
                AllSave:0
            });
			break;	
			
		case "excel":
			sheet.Down2Excel({FileName:'청구인정보 기록삭제.xls',SheetName:'sheet'});
			break;	
	}
}

/**
 *  날짜 세팅
 */
function today(year){
	var year = year || 0;
    var date = new Date();

    var year  = date.getFullYear() + year;
    var month = date.getMonth() + 1; // 0부터 시작하므로 1더함 더함
    var day   = date.getDate();

    if (("" + month).length == 1) { month = "0" + month; }
    if (("" + day).length   == 1) { day   = "0" + day;   }
   
    return "" + year + "-" + month + "-" + day; 
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
	gridTitle +="|상태";
	gridTitle +="|삭제";
	gridTitle +="|신청번호";
	gridTitle +="|접수번호";
	gridTitle +="|신청일자";
	gridTitle +="|청구제목";
	gridTitle +="|청구인";
	gridTitle +="|청구기관코드";
	gridTitle +="|청구기관";
	gridTitle +="|처리기관코드";
	gridTitle +="|처리기관";
	gridTitle +="|처리상태코드";
	gridTitle +="|공개여부";
	gridTitle +="|상태";
	gridTitle +="|종결여부";
	gridTitle +="|삭제일자";
	
	with(sheet){
		                     
		var cfg = {SearchMode:3,Page:50,VScrollMode:1};
	    SetConfig(cfg);
	    var headers = [
	                {Text:gridTitle, Align:"Center"}
	            ];
	    var headerInfo = {Sort:0,ColMove:0,ColResize:1,HeaderCheck:1};
	    
	    InitHeaders(headers, headerInfo);
	   
	    var cols = [
	                 {Type:"Seq",		SaveName:"seq",			    Width:30,	Align:"Center",		Edit:false}
	                ,{Type:"Status",	SaveName:"Status",		    Width:30,	Align:"Center",		Edit:false,	Hidden:true}
	                ,{Type:"DelCheck",	SaveName:"del", 		    Width:50,	Align:"Center" 	}
	                ,{Type:"Text",	    SaveName:"aplNo",		    Width:30,	Align:"Center",		Edit:false,	Hidden:true}
					,{Type:"Text",		SaveName:"rcpDtsNo",	    Width:50,	Align:"Center",		Edit:false,	Hidden:true}
					,{Type:"Text",		SaveName:"aplDt",	        Width:50,	Align:"Center",		Edit:false, Format:"Ymd"}
					,{Type:"Text",		SaveName:"aplSj",		    Width:200,	Align:"Left",		Edit:false}
					,{Type:"Text",		SaveName:"aplPn",		    Width:50,	Align:"Center",		Edit:false}
					,{Type:"Text",		SaveName:"aplInstCd",	    Width:90,	Align:"Center",		Edit:false,	Hidden:true}
					,{Type:"Text",		SaveName:"aplInstNm",	    Width:90,	Align:"Center",		Edit:false,	Hidden:true}
					,{Type:"Text",		SaveName:"aplDealInstCd",	Width:90,	Align:"Center",		Edit:false,	Hidden:true}
					,{Type:"Text",		SaveName:"aplDealInstNm",	Width:90,	Align:"Center",		Edit:false}
					,{Type:"Text",		SaveName:"prgStatCd",	    Width:90,	Align:"Center",		Edit:false,	Hidden:true}
					,{Type:"Text",		SaveName:"opbYnNm",	        Width:50,	Align:"Center",		Edit:false}
					,{Type:"Text",		SaveName:"prgStatNm",	    Width:90,	Align:"Center",		Edit:false}
					,{Type:"Text",		SaveName:"endNm",	        Width:50,	Align:"Center",		Edit:false}
					,{Type:"Text",		SaveName:"pdpDttm",	    Width:50,	Align:"Center",		Edit:false, Format:"Ymd"}
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
}

function sheet_OnSearchEnd(code, message, statusCode, statusMessage) {
}

function sheet_OnLoadData(data) {
	var data = JSON.parse(data);
	if ( data.success != null) {
		//시트 저장이 성공적으로 완료된 경우
		alert(data.success.message);
		doAction("search");
	}
}
////////////////////////////////////////////////////////////////////////////////
//이벤트 함수
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
//Validation 함수
////////////////////////////////////////////////////////////////////////////////


////////////////////////////////////////////////////////////////////////////////
//기타 함수
////////////////////////////////////////////////////////////////////////////////




