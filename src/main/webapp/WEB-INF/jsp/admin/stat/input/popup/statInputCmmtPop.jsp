<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="egovframework.common.WiseOpenConfig"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>  
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><spring:message code='wiseopen.title'/></title>                  
<c:import  url="/WEB-INF/jsp/inc/headinclude.jsp"/>
</head>                                                
<style type="text/css">
body{background:none;}                                     
</style>                  
<script language="javascript">                
var popObj = "form[name=statInputCmmt]";

/* 등록 가능한 입력 상태들(대기, 저장, 반려, 취소승인) */
var BATCH_PP_STATE = ["WW", "PG", "RC", "RA"]; 

$(document).ready(function()    {
	/* 이벤트를 바인딩 한다 */
	bindEvent();
	
	/* 시트를 로드한다. */
	LoadSheet();
	
	// 필요 없을시 주석처리
	var wrtstateCd = $("#wrtStateCd").val();
	if ( !gfn_isNull(wrtstateCd) && BATCH_PP_STATE.includes(wrtstateCd) ) {	
		// 작업상태가 대기, 저장, 반려, 취소승인만 저장할 수 있음.
		$(popObj).find("a[name=a_save]").show();
	} else {
		$(popObj).find("a[name=a_save]").hide();
	}
});
 
function bindEvent() {
	$(popObj).find("a[name=a_close]").click(function(e) {
		//창닫기
		parent.closeIframePop("iframePopUp");
		parent.doActionInput("search");
		return false;                
	});
	
	$(popObj).find("a[name=a_save]").click(function(e) { 
		//데이터 저장
		doActionCmmt("cmmtSave");   
		return false;  
	});
	
	$(popObj).find(".popup_close").click(function(e) {
		//닫기
		$(popObj).find("a[name=a_close]").click();
		return false;                
	}); 
	
	$(popObj).find("input").keypress(function(e) {                   
		  if(e.which == 13) {
			  doAction('search');   
			  return false; 
		  }
	});
	
	$(popObj).find("button[name=cmmtApplyBtn]").click(function(e) { 
		// 주석 반영
		doActionCmmt("cmmtApply");   
		return false;  
	});
	
	$(popObj).find("button[name=cmmtDelBtn]").click(function(e) { 
		// 주석 삭제
		doActionCmmt("cmmtDel");   
		return false;  
	});
}

/**
 * 시트 초기화
 */
function LoadSheet() {
	
	// 주석 식별자 시트 조회
	//createIBSheet2(document.getElementById("statInputCmmtSheet"),"inputCmmtSheet", "100%", "400px");
	loadInputSheet(inputCmmtSheet);
	doAction("search");
	
	// 주석 입력 시트 조회
	loadCmmtSheet()
	doActionCmmt("search");
}

/**
 * 입력 시트 로드
 */
function loadInputSheet(sheetObj) {
	$.ajax({
	    url: com.wise.help.url("/admin/stat/statInputItm.do"),
	    async: false, 
	    type: 'POST', 
	    data: "statblId=" + $("#statblId").val() + "&cmmtYn=Y",
	    dataType: 'json',
	    beforeSend: function(obj) {
	    }, // 서버 요청 전 호출 되는 함수 return false; 일 경우 요청 중단
	    success: function(data) {
	    	var rtnData = initStatInputSheet(data);		//통계표 입력시트 초기화
	    	with(sheetObj){
	    		var cfg = {SearchMode:2,	Page:50,	VScrollMode:1,	MergeSheet:msAll, SelectionRowsMode: 1};
	    	    SetConfig(cfg);
	    	    var headerInfo = {Sort:0,ColMove:1,ColResize:1,HeaderCheck:0};
	    	    
	    	    InitHeaders(rtnData.headTxt, headerInfo);
	    	    
	    	    InitColumns(rtnData.cols);
	    	    //validation 처리를 위해 항목의 마지막 레벨 text값 뿌려주고 실제로는 숨김처리
	    	    SetRowHidden(rtnData.gridRowLen - 1, true);	
	    	    //FitColWidth();
	    	    SetExtendLastCol(1);
	    	    SetEditable(0);
	    	}               
	    	default_sheet(sheetObj);  

	    }, // 요청 완료 시
	    error: function(request, status, error) {
	    	handleError(status, error);
	    }, // 요청 실패.
	    complete: function(jqXHR) {} // 요청의 실패, 성공과 상관 없이 완료 될 경우 호출
	});
}

// action 함수
function doAction(sAction) {
	
	var formObj = $("form[name=statInputCmmt]");  
	
	switch(sAction) {
		case "search" :
			ajaxBeforeSendAdmin("<c:url value='/admin/ajaxBeforeSendAdmin.do'/>"); //IbSheet 조회전 세션 체크
			var param = {PageParam: "ibpage", Param: "onepagerow=50"+"&"+ formObj.serialize()};
			inputCmmtSheet.DoSearchPaging("<c:url value='/admin/stat/statInputList.do'/>", param);
			break;	
	}
}

/**
 * 주석 식별자 셀 클릭시
 */
function inputCmmtSheet_OnClick(row, col, Value, CellX, CellY, CellW, CellH) {
	
	var formObj = $("form[name=statInputCmmt]");  
	var inputSheetObj = inputCmmtSheet;	//통계데이터 시트
	var cmmtSheetObj = cmmtValSheet;	//주석 시트
	
	var wrttimeIdtfrId = inputSheetObj.GetCellValue(row, inputSheetObj.SaveNameCol("wrttimeIdtfrId"));	//자료시점코드
	var dtadvsCd = inputSheetObj.GetCellValue(row, inputSheetObj.SaveNameCol("dtadvsCd"));				//통계자료구분코드
	var itmDatano = inputSheetObj.ColSaveName(col);														//항목 자료번호(i500001로 시작되어 있는 savename에 i제거)
	var clsDatano = inputSheetObj.GetCellValue(row, (inputSheetObj.SaveNameCol("dtadvsNm") -1) );		//구분 자료번호(통계자료명 왼쪽 컬럼에 위치함)
	var grpDatano = inputSheetObj.GetCellValue(row, inputSheetObj.SaveNameCol("gColDatano"));	// 그룹 자료번호
	
	//hidden값으로 입력해 둔다.
	formObj.find("input[id=cmmtWrttime]").val(wrttimeIdtfrId);
	formObj.find("input[id=cmmtItm]").val(itmDatano);
	formObj.find("input[id=cmmtCls]").val(clsDatano);
	formObj.find("input[id=cmmtGrp]").val(grpDatano);
	formObj.find("input[id=cmmtDta]").val(dtadvsCd);
	
	var findRow = cmmtSheetObj.FindText("cmmtKey", itmDatano + dtadvsCd + wrttimeIdtfrId + clsDatano + grpDatano);	//키 값(분류할수 있게)으로 등록해 둔다.
	var delStatus = cmmtSheetObj.GetCellValue(findRow, "status");

	if ( findRow > -1 && delStatus != "D" ) {	//시트에 값이 있고 삭제인 경우가 아닐때
		//키 값이 주석 시트에 있을경우 값 표시
		formObj.find("input[id=cmmtIdtfr]").val(cmmtSheetObj.GetCellValue(findRow, "cmmtIdtfr"));
		formObj.find("textarea[id=cmmtCont]").val(cmmtSheetObj.GetCellValue(findRow, "cmmtCont"));
		formObj.find("textarea[id=engCmmtCont]").val(cmmtSheetObj.GetCellValue(findRow, "engCmmtCont"));
	} else {
		formObj.find("input[id=cmmtIdtfr]").val("");
		formObj.find("textarea[id=cmmtCont]").val("");
		formObj.find("textarea[id=engCmmtCont]").val("");
	}
}


/**
 * 주석 시트 생성
 */
function loadCmmtSheet() {

	var gridTitle ="NO";
	gridTitle +="|상태";
	gridTitle +="|자료시점코드";
	gridTitle +="|그룹자료번호";
	gridTitle +="|항목자료번호";
	gridTitle +="|분류자료번호";
	gridTitle +="|비교자료구분코드";
	gridTitle +="|그룹명";
	gridTitle +="|항목명";
	gridTitle +="|분류명";
	gridTitle +="|주석식별자";
	gridTitle +="|주석내용(한글)";
	gridTitle +="|주석내용(영문)";
	gridTitle +="|unique";
	
	with(cmmtValSheet){
		                     
		var cfg = {SearchMode:2,Page:50,VScrollMode:1};
	    SetConfig(cfg);
	    var headers = [
	                {Text:gridTitle, Align:"Center"}
	            ];
	    var headerInfo = {Sort:0,ColMove:1,ColResize:1,HeaderCheck:0};
	    
	    InitHeaders(headers, headerInfo);
	   
	    var cols = [
	                 {Type:"Seq",		SaveName:"seq",				Width:30,	Align:"Center",		Edit:false}
	                ,{Type:"Status",	SaveName:"status",			Width:40,	Align:"Center",		Edit:false,	Hidden: 0}
	                ,{Type:"Text",		SaveName:"wrttimeIdtfrId",	Width:60,	Align:"Center",		Edit:false,	Hidden: 0}
					,{Type:"Text",		SaveName:"grpDatano",		Width:60,	Align:"Center",		Edit:false,	Hidden: 0}
					,{Type:"Text",		SaveName:"itmDatano",		Width:60,	Align:"Center",		Edit:false,	Hidden: 0}
					,{Type:"Text",		SaveName:"clsDatano",		Width:60,	Align:"Center",		Edit:false,	Hidden: 0}
					,{Type:"Text",		SaveName:"dtadvsCd",		Width:60,	Align:"Center",		Edit:false,	Hidden: 0}
					,{Type:"Text",		SaveName:"grpFullNm",		Width:120,	Align:"Left",		Edit:false,	Hidden: 0}
					,{Type:"Text",		SaveName:"itmFullNm",		Width:120,	Align:"Left",		Edit:false,	Hidden: 0}
					,{Type:"Text",		SaveName:"clsFullNm",		Width:120,	Align:"Left",		Edit:false,	Hidden: 0}
					,{Type:"Text",		SaveName:"cmmtIdtfr",		Width:90,	Align:"Left",		Edit:false,	Hidden: 0}
					,{Type:"Text",		SaveName:"cmmtCont",		Width:350,	Align:"Left",		Edit:false,	Hidden: 0}
					,{Type:"Text",		SaveName:"engCmmtCont",		Width:200,	Align:"Left",		Edit:false,	Hidden: 0}
					,{Type:"Text",		SaveName:"cmmtKey",			Width:60,	Align:"Left",		Edit:false,	Hidden: 0}
	            ];
	    
	    InitColumns(cols);
	    SetExtendLastCol(1);
	    
	}               
	default_sheet(cmmtValSheet);   
	doActionCmmt("search");
}

function doActionCmmt(sAction) {
	var formObj = $("form[name=statInputCmmt]");  
	
	switch(sAction) {
	case "search" : 
		ajaxBeforeSendAdmin(com.wise.help.url("/admin/ajaxBeforeSendAdmin.do")); //IbSheet 조회전 세션 체크
		var param = {PageParam: "ibpage", Param: "onepagerow=300"+"&"+ formObj.serialize()};
		cmmtValSheet.DoSearchPaging(com.wise.help.url("/admin/stat/statInputCmmtList.do"), param);
		break;
	case "cmmtDel" :	//주석삭제
		cmmtDel();
		break;
	case "cmmtApply" : 	//주석반영
		cmmtApply();
		break;
	case "cmmtSave" :	// 주석 저장
		cmmtSave();
		break;
	}
}

/**
 * 주석 반영
 */
function cmmtApply() {
	
	var formObj = $("form[name=statInputCmmt]");  
	var inputSheetObj = inputCmmtSheet;	//통계데이터 시트
	var cmmtSheetObj = cmmtValSheet;	//주석 시트
	
	var cmmtItmNm = formObj.find("input[id=cmmtItm]").val()	//항목자료번호(SaveName)
	var cmmtItm = cmmtItmNm.substring(5);					//항목자료번호(시작 Text 'i' 제거)
	var cmmtWrttime = formObj.find("input[id=cmmtWrttime]").val();	//자료시점번호
	var cmmtCls = formObj.find("input[id=cmmtCls]").val();			//분류자료번호
	var cmmtGrp = formObj.find("input[id=cmmtGrp]").val();			//그룹자료번호
	var cmmtDta = formObj.find("input[id=cmmtDta]").val();			//자료구분코드
	
	if ( !isNaN(Number(cmmtItm)) && !com.wise.util.isNull(cmmtItm) ) {	//항목 컬럼을 선택했을 경우
		var findRow = cmmtSheetObj.FindText("cmmtKey", cmmtItmNm + cmmtDta + cmmtWrttime + cmmtCls  + cmmtGrp);
		var delStatus = cmmtSheetObj.GetCellValue(findRow, "status");
		var wrttimeIdtfrId = inputSheetObj.FindText("wrttimeIdtfrId", cmmtWrttime);
		
		// 식별자 값 주석시트에 입력
		// 그룹, 분류 모두 있는경우
		if ( !com.wise.util.isNull(cmmtGrp) && !com.wise.util.isNull(cmmtCls) ) {
			var grpRow = inputSheetObj.FindText("gColDatano", cmmtGrp, wrttimeIdtfrId);	// 그룹자료코드 TEXT 먼저 찾고
			var clsRow = inputSheetObj.FindText("cColDatano", cmmtCls, grpRow);			//분류자료코드 Text 찾은후
			var dtaRow = inputSheetObj.FindText("dtadvsCd", cmmtDta, clsRow);				//분류자료코드 찾은 위치에서 통계자료 코드 찾음
		}	// 그룹만 있는경우
		else if ( !com.wise.util.isNull(cmmtGrp) && com.wise.util.isNull(cmmtCls) ) {
			var grpRow = inputSheetObj.FindText("gColDatano", cmmtGrp, wrttimeIdtfrId);	// 그룹자료코드 TEXT 먼저 찾고
			var dtaRow = inputSheetObj.FindText("dtadvsCd", cmmtDta, grpRow);			//그룹자료코드 찾은 위치에서 통계자료 코드 찾음
		}	// 분류만 있는경우
		else if ( !com.wise.util.isNull(cmmtCls) ) {
			var clsRow = inputSheetObj.FindText("cColDatano", cmmtCls, wrttimeIdtfrId);		//분류자료코드 Text 찾은후
			var dtaRow = inputSheetObj.FindText("dtadvsCd", cmmtDta, clsRow);				//분류자료코드 찾은 위치에서 통계자료 코드 찾음
		} else {
			//분류값이 없는경우 자료구분코드로 컬럼위치 확인
			var dtaRow = inputSheetObj.FindText("dtadvsCd", cmmtDta, wrttimeIdtfrId);
		}
		inputSheetObj.SetCellValue(dtaRow, cmmtItmNm, formObj.find("input[id=cmmtIdtfr]").val());
		
		if ( findRow > -1 ) {
			cmmtSheetObj.SetCellValue(findRow, "itmFullNm", "저장 후 확인가능");
			cmmtSheetObj.SetCellValue(findRow, "clsFullNm", "저장 후 확인가능");
			cmmtSheetObj.SetCellValue(findRow, "grpFullNm", "저장 후 확인가능");
			cmmtSheetObj.SetCellValue(findRow, "cmmtIdtfr", formObj.find("input[id=cmmtIdtfr]").val());			//주석식별자
			cmmtSheetObj.SetCellValue(findRow, "cmmtCont", formObj.find("textarea[id=cmmtCont]").val());		//주석내용(한글)
			cmmtSheetObj.SetCellValue(findRow, "engCmmtCont", formObj.find("textarea[id=engCmmtCont]").val());	//주석내용(영문)
			//cmmtSheetObj.SetCellValue(findRow, "status", "");
			
			var itmCol = inputSheetObj.SaveNameCol(cmmtItmNm);	//항목 컬럼넘버
			
		} else {
			if ( formObj.find("input[id=cmmtIdtfr]").val() == "" ) {
				alert("주석 식별자를 입력해 주세요.");
				return false;
			}
			if ( !com.wise.util.isNumeric(formObj.find("input[id=cmmtIdtfr]").val()) ) {
				alert("식별자는 숫자만 입력하세요.");
				return false;
			}
			if ( formObj.find("input[id=cmmtCont]").val() == "" ) {
				alert("주석을 입력해 주세요.");
				return false;
			}
			
			// 입력 한 주석값 주석데이터 시트에 입력
			var newRow = cmmtSheetObj.DataInsert(-1);	//시트에 값 입력
			cmmtSheetObj.SetCellValue(newRow, "wrttimeIdtfrId", cmmtWrttime);
			cmmtSheetObj.SetCellValue(newRow, "itmDatano", cmmtItm);
			cmmtSheetObj.SetCellValue(newRow, "clsDatano", cmmtCls);
			cmmtSheetObj.SetCellValue(newRow, "grpDatano", cmmtGrp);
			cmmtSheetObj.SetCellValue(newRow, "dtadvsCd", cmmtDta);
			cmmtSheetObj.SetCellValue(newRow, "grpFullNm", "저장 후 확인가능");
			cmmtSheetObj.SetCellValue(newRow, "itmFullNm", "저장 후 확인가능");
			cmmtSheetObj.SetCellValue(newRow, "clsFullNm", "저장 후 확인가능");
			cmmtSheetObj.SetCellValue(newRow, "cmmtIdtfr", formObj.find("input[id=cmmtIdtfr]").val());		//주석식별자
			cmmtSheetObj.SetCellValue(newRow, "cmmtCont", formObj.find("textarea[id=cmmtCont]").val());		//주석내용(한글)
			cmmtSheetObj.SetCellValue(newRow, "engCmmtCont", formObj.find("textarea[id=engCmmtCont]").val());	//주석내용(영문)
			cmmtSheetObj.SetCellValue(newRow, "cmmtKey", cmmtItmNm + cmmtDta + cmmtWrttime + cmmtCls);			//키값세팅
		}
		
		//초기화
		formObj.find("input[id=cmmtIdtfr]").val("");
		formObj.find("textarea[id=cmmtCont]").val("");
		formObj.find("textarea[id=engCmmtCont]").val("");
	} else {
		alert("주석을 입력할 행을 정확히 선택해 주세요.");
		return false;
	}
}

/**
 * 주석 삭제
 */
function cmmtDel() {
	
	var formObj = $("form[name=statInputCmmt]");  
	var inputSheetObj = inputCmmtSheet;	//통계데이터 시트
	var cmmtSheetObj = cmmtValSheet;	//주석 시트

	var row = inputSheetObj.GetSelectRow();
	var col = inputSheetObj.GetSelectCol();
	var itmDatano =inputSheetObj.ColSaveName(col);
	var colDatano = inputSheetObj.GetCellValue(row, "cColDatano");
	var grpDatano = inputSheetObj.GetCellValue(row, "gColDatano");
	var dtadvsCd = inputSheetObj.GetCellValue(row, "dtadvsCd")	;
	var wrttimeIdtfrId = inputSheetObj.GetCellValue(row, "wrttimeIdtfrId")	;
	
	var findRow = cmmtSheetObj.FindText("cmmtKey", itmDatano+dtadvsCd+wrttimeIdtfrId+colDatano+grpDatano);
	if ( findRow > -1 ) {
		cmmtSheetObj.SetCellValue(findRow, "status", "D");		//삭제 상태로 변경
		inputSheetObj.SetCellBackColor(row, col, 'white');		//입력 시트 셀 흰색으로
		cmmtSheetObj.SetCellValue(findRow, "cmmtIdtfr", "");	//내용 초기화(시트의 빈 값이 update 되면 시트 값에 색 표시 되지 않음)
		cmmtSheetObj.SetCellValue(findRow, "cmmtCont", "");
		cmmtSheetObj.SetCellValue(findRow, "engCmmtCont", "");
		formObj.find("input[id=cmmtIdtfr]").val("");
		formObj.find("textarea[id=cmmtCont]").val("")
		formObj.find("textarea[id=engCmmtCont]").val("")
		
		inputSheetObj.SetCellValue(inputSheetObj.GetSelectRow(), inputSheetObj.GetSelectCol(), "");	// 식별자 제거
		
	} else {
		alert("주석을 입력한 셀이 아닙니다.");
	}
}

/**
 * 주석 저장
 */
function cmmtSave() {
	
	var formObj = $("form[name=statInputCmmt]");  
	var cmmtSheetObj = cmmtValSheet;	//주석데이터 시트
	
	var cmmtSheetJson = cmmtSheetObj.GetSaveJson();
	
	if (cmmtSheetJson.Code) {
        switch (cmmtSheetJson.Code) {
            case "IBS000":
                alert("저장할 내역이 없습니다.");
                break;
            case "IBS010":
            case "IBS020":
                // Nothing to do.
                break;
        }
    }
	else {
		
		if ( !confirm("저장 하시겠습니까?") ) {
			return false;
		}
		
		var params = "&ibsSaveJson=" + encodeURIComponent(JSON.stringify(cmmtSheetJson));
		var datas = formObj.serialize() + params;
	   	
	   	$.ajax({
	   	    url: com.wise.help.url("/admin/stat/saveStatInputCmmtData.do"),
	   	    async: false, 
	   	    type: 'POST', 
	   	    data: datas,
	   	    dataType: 'json',
	   	    beforeSend: function(obj) {
	   	    }, 
	   	    success: function(data, status, request) {
	   	    	alert("정상적으로 저장 되었습니다.");
	   	    	doAction("search");
	   	    	doActionCmmt("search");
	   	    },
	   	    error: function(request, status, error) {
	   	    	handleError(status, error);
	   	    },
	   	    complete: function(jqXHR) {} 
	   	});
	}
	
   	
}

</script>                
<body>
<form name="statInputCmmt"  method="post" action="#">
	<input type="hidden" id="parentFormNm" value="${param.parentFormNm}"/>
	<input type="hidden" id="cmmtYn" name="cmmtYn" value="Y"/>
	<input type="hidden" id="statblId" name="statblId" value="${param.statblId}"/>
	<input type="hidden" id="dtacycleCd" name="dtacycleCd" value="${param.dtacycleCd}"/>
	<input type="hidden" id="wrttimeIdtfrId" name="wrttimeIdtfrId" value="${param.wrttimeIdtfrId}"/>
	<input type="hidden" id="wrttimeDesc" name="wrttimeDesc" value="${param.wrttimeDesc}"/>
	<c:choose>
    <c:when test="${fn:length(data.batchWrttimeIdtfrId) > 0 }">
        <input type="hidden" id="batchYn" name="batchYn" value="Y"/>
    </c:when>
    <c:otherwise>
        <input type="hidden" id="batchYn" name="batchYn" value="N"/>
    </c:otherwise>
	</c:choose>
	<input type="hidden" id="wrtStateCd" value="${param.wrtStateCd}"/>
	<c:forEach var="wrttimdIdtfrId" items="${data.batchWrttimeIdtfrId}">
		<input type="hidden" id="batchWrttimeIdtfrId" name="batchWrttimeIdtfrId" value="${wrttimdIdtfrId }"/>
	</c:forEach>
	<c:forEach var="wrttimeDesc" items="${data.batchWrttimeDesc}">
		<input type="hidden" id="batchWrttimeDesc" name="batchWrttimeDesc" value="${wrttimeDesc }"/>
	</c:forEach>
	
	<div class="popup">
		<h3>통계값 주석</h3>
		<a href="#" class="popup_close">x</a>
		<div style="padding:15px;">
			<!-- <p class="text-title">조회조건</p> -->
			<table class="list01">              
			<colgroup>
				<col width="150"/>
				<col width=""/>
			</colgroup>
				<tr>
					<th>주석</th>
					<td>
						<table class="list01" style="position: relative;">
							<caption>주석</caption>
							<colgroup>
								<col width="" />
							</colgroup>
							<tr>
								<td>
									<input type="hidden" id="cmmtWrttime">
									<input type="hidden" id="cmmtCls">
									<input type="hidden" id="cmmtItm">
									<input type="hidden" id="cmmtGrp">
									<input type="hidden" id="cmmtDta">
									<div style="padding: 3px 0 0 0"><label>식별자 : </label><input type="text" id="cmmtIdtfr" size="10" value="" /></div>
									<div style="padding: 3px 0 0 0"><textarea id="cmmtCont" style="width: 75%;" rows="2" placeholder="(한글)통계값 주석을 입력하세요"></textarea></div>
									<div style="padding: 3px 0 3px 0">
										<textarea id="engCmmtCont" style="width: 75%;" rows="2" placeholder="(영문)통계값 주석을 입력하세요"></textarea>
										<span style="float: right;">
											<button type="button" class="btn01" name="cmmtApplyBtn">주석 반영</button>
											<button type="button" class="btn01" name="cmmtDelBtn" >주석 삭제</button> 
										</span>
									</div>
									<div class="ibsheet_area" id="statInputCmmtValSheet" style="display: none;">
										<script type="text/javascript">createIBSheet("cmmtValSheet", "100%", "200px"); </script>          
									</div>
								</td> 
							</tr>
						</table>
					</td>
				</tr>
			</table>
						
			<div class="ibsheet_area" id="statInputCmmtSheet">
				<script type="text/javascript">createIBSheet("inputCmmtSheet", "100%", "400px"); </script>
			</div>
			
			<div class="buttons">
				${sessionScope.button.a_save}
				${sessionScope.button.a_close}
			</div>         
		</div>
	</div>
</form>
</body>
</html>                             