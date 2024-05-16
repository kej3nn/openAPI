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
var popObj = "form[name=statInputMark]";
/* 선택영역 선택 Flag값(선택영역일때 true) */
var selectionFlag = false;
/* 선택영역으로 설정된 Row들 */
var selectRows = [];
/* 선택영역으로 설정된 Column들 */
var selectCols = [];
/* 데이터 시작 컬럼행 번호 */
var dataStartCol = 0;
/* 셀 선택한 Row 번호 */
var onSelectRow = 0;
/* 셀 선택한 Column 번호*/
var onSelectCol = 0;
/* 등록 가능한 입력 상태들(대기, 저장, 반려, 취소승인) */
var BATCH_PP_STATE = ["WW", "PG", "RC", "RA"]; 

$(document).ready(function()    {
	/* 이벤트를 바인딩 한다 */
	bindEvent();
	
	/* 통계기호 옵션값을 생성한다. */
	loadRadioOptions("mark-sect", "mark", "/admin/stat/ajaxOption.do", {grpCd:"S1011"}, "e", {isIdDiff:true});
	
	// 통계기호 사용자 정의값 radio 를 추가한다.
	$("#td_customMark").prepend("<span class=\"radio\"><input type=\"radio\" autocomplete=\"on\" id=\"mark-sect-custom\" name=\"mark\" value=\"custom\"></span>");
	
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
		return false;                
	});
	
	$(popObj).find("button[name=btn_apply]").click(function(e) {
		//반영
		setSelectionMark();	//통계기호를 시트에 입력한다.
		return false;                
	});
	
	$(popObj).find("a[name=a_save]").click(function(e) { 
		//데이터 저장
		doAction("save");   
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
	
	$(popObj).find("#customMarkVal").click(function(e) {                   
		$("[name=mark][value=custom]").prop("checked", true);
	  	return false; 
	});
	
}

/**
 * 통계기호를 시트에 세팅한다.
 */
function setSelectionMark() {
	var mark = $("[name=mark]:checked").val();	//선택한 통계기호 값

	if ( mark == "custom" ) {
		var customMarkVal = $("#customMarkVal").val();

		if ( com.wise.util.isBlank(customMarkVal) || !com.wise.util.isLength(customMarkVal, 1, 50) ) {
			alert("사용자 정의 값이 비어있거나 50자 이내로 입력해 주세요.");
			return false;
		}
		if ( !com.wise.util.isAlpha(customMarkVal) ) {
			alert("사용자 정의 값은 영문만 입력해 주세요.");
			return false;
		}
		if ( customMarkVal == "x" ) {
			alert("[x]는 기호삭제 예약값이므로 사용 할 수 없습니다.");
			return false;
		}
		mark = customMarkVal;
	}
	
	//사용자가 영역을 드래그로 지정했을 경우
	if ( selectionFlag ) {
		var selectColsLen = selectCols.length;	//선택영역 컬럼 길이
		for ( var i=0; i < selectColsLen; i++ ) {
			if ( Number(selectCols[i]) < dataStartCol ) {
				//데이터 영역 체크
				alert("데이터 셀만 선택영역으로 지정 할 수 있습니다.");	
				inputMarkSheet.SetSelectRange();	//선택영역 초기화
				return false;
			}
		}
		//(value, startRow, startCol, endRow, endCol)
		inputMarkSheet.SetRangeValue(mark, Number(selectRows[0]), Number(selectCols[0]), selectRows[selectRows.length-1], selectCols[selectColsLen-1]);
	}
	//사용자가 셀값 1개에만 값을 설정할 경우
	else if ( !selectionFlag ) {
		if ( onSelectCol < dataStartCol ) {
			alert("통계기호는 데이터 셀만 지정 할 수 있습니다.");	
			return false;
		}
		inputMarkSheet.SetCellValue(onSelectRow, onSelectCol, mark);
	}
}

//시트초기화
function LoadSheet() {
	createIBSheet2(document.getElementById("statInputMarkSheet"),"inputMarkSheet", "100%", "400px");
	loadInputSheet("statInputMarkSheet", inputMarkSheet)
	doAction("search");
}

/**
 * 입력 시트 로드
 */
function loadInputSheet(sheetNm, sheetObj) {
	$.ajax({
	    url: com.wise.help.url("/admin/stat/statInputItm.do"),
	    async: false, 
	    type: 'POST', 
	    data: "statblId=" + $("#statblId").val() + "&markYn=Y",
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
	    	}               
	    	default_sheet(sheetObj);  

	    }, // 요청 완료 시
	    error: function(request, status, error) {
	    	handleError(status, error);
	    }, // 요청 실패.
	    complete: function(jqXHR) {} // 요청의 실패, 성공과 상관 없이 완료 될 경우 호출
	});
}

/**
 * 시트 조회 완료 후
 */
function inputMarkSheet_OnSearchEnd(code, message, statusCode, statusMessage) {
	inputMarkSheet.SetEditable(0);
	var lastCol = inputMarkSheet.LastCol();
	//데이터 시작 행 체크
	for ( var i=0; i <= lastCol; i++ ) {
		var colSaveNm = inputMarkSheet.ColSaveName(0, i);
		if ( colSaveNm.indexOf("iCol_") > -1 ) {
			dataStartCol = i;
			break;
		}
	}
}

//각족 action 함수
function doAction(sAction) {
	
	var formObj = $("form[name=statInputMark]");  
	
	switch(sAction) {
		case "search" :
			ajaxBeforeSendAdmin("<c:url value='/admin/ajaxBeforeSendAdmin.do'/>"); //IbSheet 조회전 세션 체크
			var param = {PageParam: "ibpage", Param: "onepagerow=50"+"&"+ formObj.serialize()};
			inputMarkSheet.DoSearchPaging("<c:url value='/admin/stat/statInputList.do'/>", param);
			break;	
		case "save" :
			inputMarkSheet.ExtendValidFail = 0;
			var inputSheetJson = inputMarkSheet.GetSaveJson();

			switch (inputSheetJson.Code) {
	            case "IBS000":
	                alert("저장할 내역이 없습니다.");
	                return false;
	                break;
	            case "IBS010":
	            case "IBS020":
	                // Nothing to do.
	                break;
	        }
			
			if ( !confirm("저장 하시겠습니까?") ) {
				return false;
			}
			/*
			var param = "&statblId=" + "${param.statblId}" + "&wrttimeIdtfrId=" + "${param.wrttimeIdtfrId}" + "&dtacycleCd=" + "${param.dtacycleCd}"
				+ "&ibsSaveJson=" + encodeURIComponent(JSON.stringify(inputSheetJson));
			*/
			var param = formObj.serialize() + "&ibsSaveJson=" + encodeURIComponent(JSON.stringify(inputSheetJson)); 
			$.ajax({
	    	    url: com.wise.help.url("/admin/stat/saveStatInputMark.do"),
	    	    async: false, 
	    	    type: 'POST', 
	    	    data: param,
	    	    dataType: 'json',
	    	    beforeSend: function(obj) {
	    	    }, 
	    	    success: function(data, status, request) {
	    	    	if (data.success) {
				        if (data.success.message) {
				            alert(data.success.message);
				            doAction("search");
				        }
				    } else if (data.error) {
				    	if (data.error.message) {
				    		alert(data.error.message);
				    	}
				    }
	    	    },
	    	    error: function(request, status, error) {
	    	    	handleError(status, error);
	    	    },
	    	    complete: function(jqXHR) {} 
	    	});
			break;
	}
}

/**
 * 선택영역 종료 후
 */
function inputMarkSheet_OnSelectEnd(rows, cols) {
    selectionFlag = true;
    selectRows = rows.split("|");
    selectCols = cols.split("|");
}

/**
 * 셀 클릭시
 */
function inputMarkSheet_OnClick(Row, Col, Value, CellX, CellY, CellW, CellH) {
	onSelectRow = Row;
	onSelectCol = Col;
	selectionFlag = false;
	selectRows = [];
    selectCols = [];
}

</script>                
<body>
<form name="statInputMark"  method="post" action="#">
	<input type="hidden" id="parentFormNm" value="${param.parentFormNm}"/>
	<input type="hidden" id="markYn" name="markYn" value="Y"/>
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
		<h3>통계기호</h3>
		<a href="#" class="popup_close">x</a>
		<div style="padding:15px;">
			<!-- <p class="text-title">조회조건</p> -->
			<table class="list01">              
			<colgroup>
				<col width="150"/>
				<col width=""/>
			</colgroup>
				<tr>
					<th>통계기호</th>
					<td>
						<div id="mark-sect"></div>
					</td>
				</tr>
				<tr>
					<th>사용자정의 값</th>
					<td id="td_customMark">
						<input type="text" id="customMarkVal"> (영문 50자 이내)
					</td>
				</tr>
			</table>
			
			<div align="right">
				<button type="button" class="btn01" title="반영" name="btn_apply">반영</button>
			</div>
			
			<div class="ibsheet_area" id="statInputMarkSheet">
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