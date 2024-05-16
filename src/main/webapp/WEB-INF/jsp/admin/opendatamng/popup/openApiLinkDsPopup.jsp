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
var popObj = "form[name=openApiLinkDsPopup]";
var ownerGb = "${param.ownerGb}";
 
$(document).ready(function()    {
	bindEvent();
	loadOptions();
	LoadDsSheet();
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

/**
 * 옵션을 로드한다.
 */
function loadOptions() {
	
	$("#titNm").text("");
	if(ownerGb == ""){
		$("#titNm").text("저장데이터셋 팝업");
		loadComboOptions("owner1Cd", "/admin/stat/ajaxOption.do", {grpCd:"D2001"}, "");//OWNER
		$("#owner2Cd").remove();
	} else{ 
		$("#titNm").text("대상객체 팝업");
		$("#owner1Cd").remove();
	}
	
	
}
//시트초기화
function LoadDsSheet() {
	
	createIBSheet2(document.getElementById("openApiLinkDsPopSheet"),"dsPopSheet", "100%", "300px");
	
	var gridTitle ="NO";
		gridTitle +="|OWNER";
		gridTitle +="|테이블명";
		
		
    with(dsPopSheet){
    	                     
    	var cfg = {SearchMode:2,Page:50,VScrollMode:1};
        SetConfig(cfg);
        var headers = [
                    {Text:gridTitle, Align:"Center"}
                ];
        var headerInfo = {Sort:1,ColMove:1,ColResize:1,HeaderCheck:0};
        
        InitHeaders(headers, headerInfo);
       
        var cols = [
                     {Type:"Seq",		SaveName:"seq",				Width:30,	Align:"Center",		Edit:false}
					,{Type:"Text",		SaveName:"owner",			Width:100,	Align:"Center",		Edit:false}
					,{Type:"Text",		SaveName:"tableName",		Width:100,	Align:"Left",		Edit:false}
					
                ];                                          
        InitColumns(cols);
        FitColWidth();
        SetExtendLastCol(1);
    }               
    default_sheet(dsPopSheet);   
    
    doAction("search");
} 

// 시트 더블클릭시
function dsPopSheet_OnDblClick(row, col, value, cellx, celly) {
	if(row == 0) return;  
	var arrayValue;
	
	if(ownerGb == ""){
		arrayValue = {ownerCd : dsPopSheet.GetCellValue(row, "owner"),
				owner : dsPopSheet.GetCellValue(row, "owner"),
				dsId : dsPopSheet.GetCellValue(row, "tableName")
		}
	}else{
		arrayValue = {objIdO : dsPopSheet.GetCellValue(row, "tableName")}
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
	
	var formObj = $("form[name=openApiLinkDsPopup]");  
	
	switch(sAction) {
		case "search" :
			ajaxBeforeSendAdmin("<c:url value='/admin/ajaxBeforeSendAdmin.do'/>"); //IbSheet 조회전 세션 체크
			var param = {PageParam: "ibpage", Param: "onepagerow=50"+"&"+formObj.serialize()};
			dsPopSheet.DoSearchPaging("<c:url value='/admin/opendata/popup/selectOpenApiLinkDsPopup.do'/>", param);
			break;
	}
}


</script>                
<body>
<form name="openApiLinkDsPopup"  method="post" action="#">
	<input type="hidden" id="parentFormNm" value="${param.parentFormNm}"/>
	<div class="popup">
		<h3 id="titNm"></h3>
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
						<select id="owner1Cd" name="ownerCd">
						</select>
						<input type="text" id="owner2Cd" name="ownerCd" size="10" readonly="readonly" value="${param.ownerGb}"/>
						<input type="text" id="searchVal" name="searchVal" value="" size="35"/>
					</td>
				</tr>
			</table>
			<div align="right">
				<button type="button" class="btn01" title="검색" name="btn_search">검색</button>
			</div>
			
			<div class="ibsheet_area" id="openApiLinkDsPopSheet">
			</div>
			
			<div class="buttons">
				${sessionScope.button.a_close}
			</div>         
		</div>
	</div>
</form>
</body>
</html>                             