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
	loadPage();
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
 }

//시트초기화
function loadPage() {
	
	createIBSheet2(document.getElementById("sheet"),"sheet", "100%", "300px");
	
	var gridTitle ="NO";
		gridTitle +="|항목분류ID";
		gridTitle +="|한글항목분류명";
		gridTitle +="|영문항목분류명";
		gridTitle +="|레벨";
		gridTitle +="|사용여부";
		
    with(sheet){
    	                     
    	var cfg = {SearchMode:2,Page:50,VScrollMode:1};
        SetConfig(cfg);
        var headers = [
                    {Text:gridTitle, Align:"Center"}
                ];
        var headerInfo = {Sort:0, ColMove:0, ColResize:1};
        
        InitHeaders(headers, headerInfo);
       
        var cols = [          
					 {Type:"Seq",		SaveName:"seq",				Width:30,	Align:"Center",		Edit:false}
					,{Type:"Text",		SaveName:"itmId",			Width:50,	Align:"Center",		Edit:false}
					,{Type:"Text",		SaveName:"itmNm",			Width:120,	Align:"Left",		Edit:false, TreeCol:1}
					,{Type:"Text",		SaveName:"engItmNm",		Width:100,	Align:"Left",		Edit:false}
					,{Type:"Text",		SaveName:"Level",			Width:30,	Align:"Center",		Edit:false,	Hidden:true}
					,{Type:"Combo",		SaveName:"useYn",			Width:40,	Align:"Center",		Edit:false}
               ];  
        InitColumns(cols);
        FitColWidth();
        SetExtendLastCol(1);
        
        initSheetOptions("sheet", 0, "useYn", [{
	        code:"Y",
	        name:"예"
	    }, {
	        code:"N",
	        name:"아니오"
	    }]);
    }               
    default_sheet(sheet);   
    
    doAction("search");
} 

//action 함수
function doAction(sAction) {
	
	var formObj = $("form[name=form]");  
	
	switch(sAction) {
		case "search":      //조회   
			var param = "searchGubun="+ $("#searchGubun").val() +"&searchVal=" + $("input[name=searchVal]").val();
			var data = sheet.GetSearchData(com.wise.help.url("/admin/stat/statStddItmList.do"), param);
			sheet.LoadSearchData(data);
			break;
	}
}

/**
 * 트리 자식 데이터 로드
 */
function sheet_OnTreeChild(row) {
	var itmId = sheet.GetCellValue(row, "itmId");
	sheet.DoSearchChild(row, com.wise.help.url("/admin/stat/statStddItmList.do"), "parItmId="+itmId, {wait:1});
}
     
//시트 더블클릭 선택시
function sheet_OnDblClick(row, col, value, cellx, celly) {
    if(row == 0) return;  
	var arrayValue;
	
	var parentType = $("#parentType").val();
	switch(parentType) {
		case "itm" :
			arrayValue = {
				itmId : sheet.GetCellValue(row, "itmId"),
				itmNm : sheet.GetCellValue(row, "itmNm")
			}
			break;
		case "cls" :
		arrayValue = {
				clsId : sheet.GetCellValue(row, "itmId"),
				clsNm : sheet.GetCellValue(row, "itmNm")
			}
			break;
		default :
			arrayValue = {
				parItmId : sheet.GetCellValue(row, "itmId"),
				parItmNm : sheet.GetCellValue(row, "itmNm")
			}
	}
	
	// 부모 폼으로 arrayValue에 있는 값을 넘겨준다.
	var parentFormNm = $("#parentFormNm").val();
	var parentObj = window.parent.$("form[name="+ parentFormNm +"]");
		           
	$.each(arrayValue,function(key,state){
		parentObj.find("[name="+key+"]").val(state);
	}); 
	
	//parentObj.find("input[name=statblId]").trigger("change");	//통계표 ID 변경 이벤트 호출
	parent.closeIframePop("iframePopUp");
   
} 

function sheet_OnSearchEnd(code, msg)
{
   if(msg != "")
	{                
	    alert(msg);
    }
}
</script>                
<body>
<form name="form"  method="post" action="#">
	<input type="hidden" id="parentFormNm" value="${param.parentFormNm}"/>
	<input type="hidden" id="parentType" value="${param.parentType}"/>
	<div class="popup">
		<h3>표준항목 팝업</h3>
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
							<option value="ITM_NM">한글항목분류명</option>
							<option value="ENG_ITM_NM">영문항목분류명</option>
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
				${sessionScope.button.a_close}
			</div>         
		</div>
	</div>
</form>
</body>
</html>                             