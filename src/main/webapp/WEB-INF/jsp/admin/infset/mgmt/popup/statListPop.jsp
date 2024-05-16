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
var popObj = "form[name=form]";
 
$(document).ready(function()    {
	bindEvent();
	LoadSheet();
});
 
function bindEvent() {
	$(popObj).find("a[name=a_close]").click(function(e) { 
		parent.closeIframePop("iframePopUp");
		return false;                
	});
	
	$(popObj).find(".popup_close").click(function(e) {             
		$(popObj).find("a[name=a_close]").click();
		return false;                
	}); 
	
	$(popObj).find("button[name=btn_search]").click(function(e) { 
		doAction("search");                
		return false;                
	});
	
	$(popObj).find("input").keypress(function(e) {                   
		  if(e.which == 13) {
			  doAction('search');   
			  return false; 
		  }
	});
	
	// 추가
	$(popObj).find("a[name=a_add]").bind("click", function(e) {
		add();
		return false;
	})
 }

//시트초기화
function LoadSheet() {
	
	createIBSheet2(document.getElementById("sheet"), "sheet", "100%", "300px");
	
	var gridTitle ="NO|선택|통계표ID|통계표명|분류|부서|이용\n허락조건|공개일|상태";
		
		
    with(sheet){
    	                     
    	var cfg = {SearchMode:2, Page:50, VScrollMode:1};
        SetConfig(cfg);
        var headers = [
                    {Text:gridTitle, Align:"Center"}
                ];
        var headerInfo = {Sort:0,ColMove:1,ColResize:1,HeaderCheck:1};
        
        InitHeaders(headers, headerInfo);
        
	    var cols = [
	    	{Type:"Seq",		SaveName:"seq",				Width:30,	Align:"Center",		Edit:false}
            , {Type:"CheckBox",	SaveName:"check",			Width:30,	Align:"Center",		Edit:true}
            , {Type:"Text",		SaveName:"statblId",		Width:100,	Align:"Center",		Edit:false,	Hidden:false}
			, {Type:"Text",		SaveName:"statblNm",		Width:200,	Align:"Left",		Edit:false,	Hidden:false}
			, {Type:"Text",		SaveName:"cateNm",			Width:100,	Align:"Left",		Edit:false,	Hidden:false}
			, {Type:"Text",		SaveName:"orgNm",			Width:120,	Align:"Left",		Edit:false,	Hidden:false}
			, {Type:"Text",		SaveName:"cclNm",			Width:100,	Align:"Left",		Edit:false,	Hidden:true}
			, {Type:"Text",		SaveName:"openDttm",		Width:90,	Align:"Center",		Edit:false,	Hidden:true, Format:"Ymd"}
			, {Type:"Combo",	SaveName:"openState",		Width:80,	Align:"Center",		Edit:false,	Hidden:false}
        ];
	    
        InitColumns(cols);
        FitColWidth();
        SetExtendLastCol(1);
        
        setSheetOptions();	// 상태 옵션처리
    }               
    default_sheet(sheet);
    
    doAction("search");
} 

/**
 * 시트 컬럼옵션을 설정한다.
 */
function setSheetOptions() {
	doAjax({
		url: "/admin/stat/ajaxOption.do",
		params: "grpCd=S1009",
		callback: function(res) {
			var data = res.data;
			var options = {};
			options.ComboCode = "";
			options.ComboText = "";
			
			for (var i = 0; i < data.length; i++) {
			    if (i > 0) {
			        options.ComboCode += "|";
			        options.ComboText += "|";
			    }
			    
			    options.ComboCode += data[i].code;
			    options.ComboText += data[i].name;
			}
			sheet.SetColProperty(0, "openState", options);
		}
	});
}

/**
 * 부모 시트에 선택한 데이터를 추가한다.
 */
function add() {
	var parentSheetObj = parent.getTabSheetObj("mst-form", "statSheetNm");	// 부모창의 통계데이터 탭 시트 객체
	
 	var strChkRows = sheet.FindCheckedRow("check");	// 체크된 행
 	if ( gfn_isNull(strChkRows) ) {
 		alert("추가하려는 통계표를 선택하세요.");
 		return false;
 	}
 	
	var chkRows = strChkRows.split('|');
	for ( var i=0; i < chkRows.length; i++ ) {
		var maxVal = getColMaxValue(parentSheetObj);
		var newRow = parentSheetObj.DataInsert(-1);
		
		parentSheetObj.SetCellValue(newRow, "statblId", 	sheet.GetCellValue(chkRows[i], "statblId"));
		
		// ID 중복체크하여 중복되면 입력하려고 추가한행 제거
		if ( parentSheetObj.ColValueDup("statblId") >= 0 ) {
			parentSheetObj.RowDelete(newRow);
			continue;
		}
		parentSheetObj.SetCellValue(newRow, "statblNm",	sheet.GetCellValue(chkRows[i], "statblNm"));
		parentSheetObj.SetCellValue(newRow, "cateNm", 	sheet.GetCellValue(chkRows[i], "cateNm"));
		parentSheetObj.SetCellValue(newRow, "orgNm", 	sheet.GetCellValue(chkRows[i], "orgNm"));
		parentSheetObj.SetCellValue(newRow, "cclNm", 	sheet.GetCellValue(chkRows[i], "cclNm"));
		parentSheetObj.SetCellValue(newRow, "openDttm", sheet.GetCellValue(chkRows[i], "openDttm"));
		parentSheetObj.SetCellValue(newRow, "openState", sheet.GetCellValue(chkRows[i], "openState"));
		parentSheetObj.SetCellValue(newRow, "useYn", 	true);
		parentSheetObj.SetCellValue(newRow, "vOrder", 	maxVal);
	}
	
	parent.closeIframePop("iframePopUp");
}
 
 
// 추가되는 항목 순서 지정
function getColMaxValue(parentSheetObj) {
	var maxVal = 1;
	if ( parentSheetObj.RowCount() > 0 ) {
		maxVal = parentSheetObj.GetColMaxValue("vOrder") + 1;
	}
	return maxVal;
}

//각족 action 함수
function doAction(sAction) {
	
	var formObj = $("form[name=form]");  
	
	switch(sAction) {
		case "search" :
			sheet.DoSearch("/admin/infs/mgmt/popup/selectStatListPop.do", formObj.serialize());
			break;
	}
}
</script>                
<body>
<form name="form"  method="post" action="#">
	<input type="hidden" id="parentFormNm" value="${param.parentFormNm}"/>
	<input type="hidden" id="infsId" name="infsId" value="${param.infsId}"/>
	<div class="popup">
		<h3>통계표 선택</h3>
		<a href="#" class="popup_close">x</a>
		<div style="padding:15px;">
			<!-- <p class="text-title">조회조건</p> -->
			<table class="list01">              
			<colgroup>
				<col width="150"/>
				<col width=""/>
			</colgroup>
				<tr>
					<th>검색어</th>
					<td>
						<select id="searchGubun" name="searchGubun">
							<option value="STATBL_NM">통계표명</option>
							<option value="STATBL_ID">통계표ID</option>
						</select>
						<input type="text" id="searchVal" name="searchVal" value="" width="70%"/>
					</td>
				</tr>
			</table>
			<div align="right">
				<button type="button" class="btn01" title="검색" name="btn_search">검색</button>
			</div>
			
			<div class="ibsheet_area" id="sheet">
			</div>
			
			<div class="buttons">
				${sessionScope.button.a_add}
				${sessionScope.button.a_close}
			</div>         
		</div>
	</div>
</form>
</body>
</html>                             