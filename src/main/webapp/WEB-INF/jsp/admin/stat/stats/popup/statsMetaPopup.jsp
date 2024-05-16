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
var popObj = "form[name=statsMetaPopup]";
 
$(document).ready(function()    {
	bindEvent();
	LoadStatMetaSheet();
});
 
function bindEvent() {
	$(popObj).find("a[name=a_close]").click(function(e) { 
		//parent.doActionMst("popClose");
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
function LoadStatMetaSheet() {
	
	createIBSheet2(document.getElementById("statsMetaPopSheet"),"metaPopSheet", "100%", "300px");
	
	var gridTitle ="NO";
		gridTitle +="|통계메타ID";
		gridTitle +="|한글통계메타명";
		gridTitle +="|영문통계메타명";
		
    with(metaPopSheet){
    	                     
    	var cfg = {SearchMode:2,Page:50,VScrollMode:1};
        SetConfig(cfg);
        var headers = [
                    {Text:gridTitle, Align:"Center"}
                ];
        var headerInfo = {Sort:0,ColMove:1,ColResize:1,HeaderCheck:0};
        
        InitHeaders(headers, headerInfo);
       
        var cols = [
                     {Type:"Seq",		SaveName:"seq",				Width:30,	Align:"Center",		Edit:false}
					,{Type:"Text",		SaveName:"statId",			Width:60,	Align:"Center",		Edit:false}
					,{Type:"Text",		SaveName:"statNm",			Width:200,	Align:"Left",		Edit:false}
					,{Type:"Text",		SaveName:"engsStatNm",		Width:150,	Align:"Left",		Edit:false}
                ];                                          
        InitColumns(cols);
        FitColWidth();
        SetExtendLastCol(1);
    }               
    default_sheet(metaPopSheet);   
    
    doAction("search");
} 

// 시트 더블클릭시
function metaPopSheet_OnDblClick(row, col, value, cellx, celly) {
	if(row == 0) return;  
	var arrayValue;
	
	arrayValue = {
			statId : metaPopSheet.GetCellValue(row, "statId"),
			statNm : metaPopSheet.GetCellValue(row, "statNm")
	}
	
	// 부모 폼으로 arrayValue에 있는 값을 넘겨준다.
	var parentFormNm = $("#parentFormNm").val();
	var parentObj = window.parent.$("form[name="+ parentFormNm +"]");
		           
	$.each(arrayValue,function(key,state){
		parentObj.find("[name="+key+"]").val(state);
	}); 
	
	//parent.doActionMst("popClose");	//창닫기
	parent.closeIframePop("iframePopUp");
}

//각족 action 함수
function doAction(sAction) {
	
	var formObj = $("form[name=statsMetaPopup]");  
	
	switch(sAction) {
		case "search" :
			ajaxBeforeSendAdmin("<c:url value='/admin/ajaxBeforeSendAdmin.do'/>"); //IbSheet 조회전 세션 체크
			var param = {PageParam: "ibpage", Param: "onepagerow=50"+"&"+formObj.serialize()};
			metaPopSheet.DoSearchPaging("<c:url value='/admin/stat/popup/selectStatMetaPopup.do'/>", param);
			break;
	}
}


</script>                
<body>
<form name="statsMetaPopup"  method="post" action="#">
	<input type="hidden" id="parentFormNm" value="${param.parentFormNm}"/>
	<div class="popup">
		<h3>통계메타명 팝업</h3>
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
							<option value="STAT_NM">한글통계메타명</option>
							<option value="ENG_STAT_NM">영문통계메타명</option>
						</select>
						<input type="text" id="searchVal" name="searchVal" value="" width="70%"/>
					</td>
				</tr>
			</table>
			<div align="right">
				<button type="button" class="btn01" title="검색" name="btn_search">검색</button>
			</div>
			
			<div class="ibsheet_area" id="statsMetaPopSheet">
			</div>
			
			<div class="buttons">
				${sessionScope.button.a_close}
			</div>         
		</div>
	</div>
</form>
</body>
</html>                             