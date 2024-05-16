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
	
	var gridTitle ="NO|선택|공공데이터ID|공공데이터명|분류|부서|이용\n허락조건|개방일|상태";
		
		
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
            , {Type:"Text",		SaveName:"infId",			Width:100,	Align:"Center",		Edit:false,	Hidden:true}
			, {Type:"Text",		SaveName:"infNm",			Width:160,	Align:"Left",		Edit:false,	Hidden:false}
			, {Type:"Text",		SaveName:"cateNm",			Width:100,	Align:"Left",		Edit:false,	Hidden:false}
			, {Type:"Text",		SaveName:"orgNm",			Width:190,	Align:"Left",		Edit:false,	Hidden:true}
			, {Type:"Text",		SaveName:"cclNm",			Width:100,	Align:"Left",		Edit:false,	Hidden:true}
			, {Type:"Text",		SaveName:"openDttm",		Width:90,	Align:"Center",		Edit:false,	Hidden:false, Format:"Ymd"}
			, {Type:"Combo",	SaveName:"infState",		Width:80,	Align:"Center",		Edit:false,	Hidden:false}
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
	loadSheetOptions("sheet", 0, "infState", "/portal/common/code/searchCommCode.do", 	{grpCd:"D1007"});	//공개상태 구분코드
}

/**
 * 부모 시트에 선택한 데이터를 추가한다.
 */
function add() {
	var	html = "",
		strChkRows = sheet.FindCheckedRow("check"),
		chkRows = strChkRows.split('|'),
		parentDiv = parent.$("ul[name=openInfList]");
		
 	if ( gfn_isNull(strChkRows) ) {
 		alert("추가하려는 공공데이터를 선택하세요.");
 		return false;
 	}
 	
 	parentDiv.empty();
 	
	for ( var i=0; i < chkRows.length; i++ ) {
		html += "<li>" +sheet.GetCellValue(chkRows[i], "infNm")
		html += "<a href=\"javascript:;\" onclick=\"goDel(this);\" title=\"활용데이터 행 삭제\" style=\"cursor:pointer;\"><img src=\"" + com.wise.help.url("/img/ggportal/desktop/common/btn_delete.png") + "\"  alt=\"\" /></a>"
		html += "<input type=\"hidden\" name=\"infId\" value=\""+sheet.GetCellValue(chkRows[i], "infId") +"\">";
		html += "</li>"
	}
	parentDiv.append(html);
	
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
			sheet.DoSearch("/portal/myPage/popup/selectOpenInfSearchPop.do", formObj.serialize());
			break;
	}
}

/**
 * 시트 조회 후처리
 */
function sheet_OnSearchEnd() {
	// 선택한 데이터 체크
	var $infId = $("input[id=infId]");
	if ( $infId.length > 0 ) {
		$infId.each(function(i, v) {
			var findRow = sheet.FindText("infId", v.value, 0);
			sheet.SetCellValue(findRow, "check", 1);
		});
	}
}
</script>                
<body>
<form name="form"  method="post" action="#">
	<input type="hidden" id="parentFormNm" value="${param.parentFormNm}"/>
	<c:if test="${not empty paramValues.infId }">
		<c:forEach var="infId" items="${paramValues.infId }">
			<input type="hidden" id="infId" value="${infId}"/>
		</c:forEach>
	</c:if>
	<div class="popup">
		<h3>활용데이터 선택</h3>
		<a href="#" class="popup_close">x</a>
		<div style="padding:15px;">
			<table class="list01">
			<colgroup>
				<col width="150"/>
				<col width=""/>
			</colgroup>
				<tr>
					<th>검색어</th>
					<td>
						<select id="searchGubun" name="searchGubun">
							<option value="INF_NM">활용데이터명</option>
							<option value="INF_ID">활용데이터ID</option>
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
				<a href='#' class='btn03'  title='추가' name='a_add'>추가</a>
				<a href='#' class='btn02'  title='닫기' name='a_close'>닫기</a>
			</div>         
		</div>
	</div>
</form>
</body>
</html>                             