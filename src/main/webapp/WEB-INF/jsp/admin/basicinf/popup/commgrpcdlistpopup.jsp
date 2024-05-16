<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="egovframework.common.WiseOpenConfig"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page import="egovframework.com.cmm.EgovWebUtil"%> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><spring:message code="labal.commCodeManagement"/>ㅣ<spring:message code="wiseopen.title"/></title>                    
<c:import  url="/WEB-INF/jsp/inc/headinclude.jsp"/>
<%
	// 자신을 제외한 공통코드목록을 뿌리기 위해 부모창에서 값을 전달받음
	String grpIs = request.getParameter("grpIs") == null ? "" : EgovWebUtil.clearXSSMinimum(request.getParameter("grpIs"));
	String grpCd = request.getParameter("grpCd") == null ? "" : EgovWebUtil.clearXSSMinimum(request.getParameter("grpCd"));
	String ditcCd = request.getParameter("ditcCd") == null ? "" : EgovWebUtil.clearXSSMinimum(request.getParameter("ditcCd"));
%>
<style type="text/css">
body{background:none;} /* 임시로 해놓은 것임 */
</style>
</head>                                                 
<script language="javascript">              
//<![CDATA[                   
$(document).ready(function()    {
	reSizeIframePop();
	LoadPage();
	inputSet();
	inputEnterKey();
});                                      
                                 
function LoadPage()          
{
	createIBSheet2(document.getElementById("commCodeGrpCdList"),"mySheet", "100%", "300px");                       
	var gridTitle1 ="NO"; 
	gridTitle1 +="|"+"<spring:message code='labal.code'/>";
	gridTitle1 +="|"+"<spring:message code='labal.codeNm'/>";
	gridTitle1 +="|"+"<spring:message code='labal.codeNmEng'/>";
	gridTitle1 +="|"+"<spring:message code='labal.ditcNm'/>";      
	gridTitle1 +="|"+"<spring:message code='labal.useYn'/>";
	
	with(mySheet){
           
    	var cfg = {SearchMode:3,Page:50};                                   
        SetConfig(cfg);  
        var headers = [                               
                    {Text:gridTitle1, Align:"Center"}                 
                ];
        var headerInfo = {Sort:0,ColMove:1,ColResize:1,HeaderCheck:0};
        
        InitHeaders(headers, headerInfo);    
         
        var cols = [          
					 {Type:"Seq",		SaveName:"seq",				Width:50,	Align:"Right",		Edit:false,Hidden:true}
					,{Type:"Text",		SaveName:"ditcCd",			Width:150,	Align:"Center",		Edit:false}
					,{Type:"Text",		SaveName:"ditcNm",			Width:300,	Align:"Left",		Edit:false}
					,{Type:"Text",		SaveName:"ditcNmEng",		Width:300,	Align:"Left",		Edit:false}
					,{Type:"Text",		SaveName:"vOrder",			Width:50,	Align:"Left",		Edit:false,Hidden:true}
					,{Type:"CheckBox",		SaveName:"useYn",		Width:50,	Align:"Center",		Edit:true, TrueValue:"Y", FalseValue:"N", KeyField:true,Hidden:true}
					
               ];            
                                      
        InitColumns(cols);  
        FitColWidth();            
        SetExtendLastCol(0);                                     
    }
    default_sheet(mySheet);    
   doAction("search");
}      

function doAction(sAction){
	var formObj = $("form[name=commCodeGrpCdList]");
	switch(sAction)
	{
		case "search":      //조회
			var formParam = formObj.serialize();
			ajaxBeforeSendAdmin("<c:url value='/admin/ajaxBeforeSendAdmin.do'/>"); //IbSheet 조회전 세션 체크
			var param = {PageParam: "ibpage", Param: "onepagerow=50&"+formObj.serialize()};
			mySheet.DoSearchPaging("<c:url value='/admin/basicinf/commCodeGrpCdList.do'/>", param);
			break;
	}                                                                                                                 
}                         
                      

function inputSet(){
	var formObj = $("form[name=commCodeGrpCdList]");                  
	formObj.find("button[name=btn_search]").click(function(e) {               
		doAction('search');                 
		return false;                                    
	});                  
	
	/* $("a[name=a_close]").click(function(e) {                
		parent.doActionTab("popclose");
		 return false;                             
	 }); */ 	//ifram 팝업 사용시
	$("a[name=a_close]").click(function(){	window.close();	});		// 팝업창 닫기
}

function mySheet_OnDblClick(row, col, value, cellx, celly) {
	 
	if(row == 0) return;  
	    var arrayValue, grpCd, grpNm;
	    var classObj = opener.$("."+tabContentClass); //부모 form class 확인
    	arrayValue = {grpCd:mySheet.GetCellValue(row, "ditcCd"), grpNm:mySheet.GetCellValue(row, "ditcNm")}
	    return_pop(classObj,arrayValue); // 공통 javascirpt 호출(common.js)
}


function inputEnterKey(){
	var formObj = $("form[name=commCodeGrpCdList]");
	formObj.find("input").keypress(function(e) {                   
		  if(e.which == 13) {
			  doAction('search');   
			  return false; 
		  }
	}); 
}  

function mySheet_OnSearchEnd(code, msg)
{
	mySheet.FitColWidth("10|20|35|35");                              
}
//]]> 
</script>              
</head>                      
<body onload="">
	<div class="container">
			<div class="popup" style="padding:20px;">
			<form name="commCodeGrpCdList"  method="post" action="#"> 
			<input type="hidden" name="grpIs" value="<%=grpIs.replaceAll("<", "&lt;").replaceAll(">", "&gt;")%>"/>
			<input type="hidden" name="grpCd" value="<%=grpCd.replaceAll("<", "&lt;").replaceAll(">", "&gt;")%>"/>
			<input type="hidden" name="ditcCd" value="<%=ditcCd.replaceAll("<", "&lt;").replaceAll(">", "&gt;")%>"/>
				<table class="list01">
					<caption>상위분류목록리스트</caption>
						<colgroup>
							<col width="150"/>
							<col width=""/>
							<col width="150"/>
							<col width=""/>
						</colgroup>
						<tr>
							<th>검색어</th>
							<td colspan="3">
								<select name="serSel">
				                 	<option value="NM"><label class=""><spring:message code="labal.codeNm"/></label></option>
				                 	<option value="ENG"><label class=""><spring:message code="labal.codeNmEng"/></label></option>
								</select>
								<input name="serVal" type="text" value=""/>
								${sessionScope.button.btn_search}        
							</td>
						</tr>
				</table>                 
			</form>
			<div class="ibsheet_area" id="commCodeGrpCdList">
			</div>
			<div class="buttons">
			${sessionScope.button.a_close}        
			</div>          
		</div>
	</div>
</html>