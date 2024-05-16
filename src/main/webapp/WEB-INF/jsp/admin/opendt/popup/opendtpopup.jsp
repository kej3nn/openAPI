<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="egovframework.common.WiseOpenConfig"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><spring:message code='wiseopen.title'/></title>               
<c:import  url="/WEB-INF/jsp/inc/headinclude.jsp"/>
<style type="text/css">
body{background:none;} /* 임시로 해놓은 것임 */
</style>
</head>                                                 
<script language="javascript">              
//<![CDATA[                   
$(document).ready(function()    {           
	LoadPage();
	inputSet();
	inputEnterKey();
	reSizeIframePop();//페이지 size계산                                        
});                                      

function LoadPage()                
{      
	
	var gridTitle1 = "NO"
		gridTitle1 +="|"+"<spring:message code='labal.dtId'/>";
		gridTitle1 +="|"+"<spring:message code='labal.dtNm'/>";
		gridTitle1 +="|"+"<spring:message code='labal.dtNmEng'/>"; 
		gridTitle1 +="|"+"<spring:message code='labal.srcExpUrl'/>"; 
		gridTitle1 +="|"+"<spring:message code='labal.srcExp'/>"; 
		gridTitle1 +="|"+"<spring:message code='labal.srcExpEng'/>"; 
	
	with(mySheet1){
           
    	var cfg = {SearchMode:3,Page:50};                                
        SetConfig(cfg);  
        var headers = [                               
                    {Text:gridTitle1, Align:"Center"}                 
                ];
        var headerInfo = {Sort:0,ColMove:1,ColResize:1,HeaderCheck:0};
        
        InitHeaders(headers, headerInfo); 
         
        var cols = [          
					 {Type:"Seq",		SaveName:"seq",				Width:30,	Align:"Center",		Edit:false}
					,{Type:"Text",		SaveName:"dtId",			Width:70,	Align:"Center",		Edit:false}
					,{Type:"Text",		SaveName:"dtNm",			Width:120,	Align:"Left",		Edit:false}
					,{Type:"Text",		SaveName:"dtNmEng",		Width:100,	Align:"Left",		Edit:false}
					,{Type:"Text",		SaveName:"srcUrl",			Width:80,	Align:"Center",		Edit:false, Hidden:true}
					,{Type:"Text",		SaveName:"srcExp",			Width:80,	Align:"Center",		Edit:false, Hidden:true}
					,{Type:"Text",		SaveName:"srcExpEng",			Width:80,	Align:"Center",		Edit:false, Hidden:true}
					,{Type:"Text",		SaveName:"srcYn",			Width:80,	Align:"Center",		Edit:false, Hidden:true}
					
               ];            
                                      
        InitColumns(cols);                                                                                        
        SetExtendLastCol(1);                                     
    }
    default_sheet(mySheet1);    
   doAction("search");
}      

function doAction(sAction)                                  
{
	var formObj = $("form[name=OpenDt]");                 
	switch(sAction)                                              
	{          
		case "search":      //조회                
			ajaxBeforeSendAdmin("<c:url value='/admin/ajaxBeforeSendAdmin.do'/>"); //IbSheet 조회전 세션 체크
			var param = {PageParam: "ibpage", Param: "onepagerow=50&"+formObj.serialize()};    
			mySheet1.DoSearchPaging("<c:url value='/admin/openinf/opendt/openDtList.do'/>", param);
			break;                 
	}                                                                                                                 
}                         
                      
function colcallback(){
	                                                                    
}

function inputSet(){
	var formObj = $("form[name=OpenDt]");                  
	formObj.find("button[name=btn_search]").click(function(e) {               
		doAction('search');                 
		return false;                                    
	});                  
	
	$("a[name=a_close]").click(function(e) {                
		parent.doAction("popclose");
		 return false;                             
	 }); 
}

function mySheet1_OnDblClick(row, col, value, cellx, celly) {
	if(row > 0){               
		var parRow = parent.mySheet.GetSelectRow();
		parent.mySheet.SetCellValue(parRow,"dtNm",mySheet1.GetCellValue(row,"dtNm"));
		parent.mySheet.SetCellValue(parRow,"dtId",mySheet1.GetCellValue(row,"dtId"));
		$("a[name=a_close]").click(); 
	}             
} 

function inputEnterKey(){
	var formObj = $("form[name=OpenDt]");
	formObj.find("input").keypress(function(e) {                   
		  if(e.which == 13) {
			  doAction('search');   
			  return false; 
		  }
	}); 
}  

function mySheet1_OnSearchEnd(code, msg)
{
	mySheet1.FitColWidth("10|20|35|35");                              
}
//]]> 
</script>              
</head>                      
<body onload="">
	<div class="container">
			<div class="popup" style="padding:20px;">
			<form name="OpenDt"  method="post" action="#">      
				<table class="list01">
					<caption>공공데이터목록리스트</caption>
						<colgroup>
							<col width="150"/>
							<col width=""/>
							<col width="150"/>
							<col width=""/>
						</colgroup>
						<tr>
							<th>검색어</th>
							<td colspan="3">
								<select name="searchWd">
									<option value="0"><label class=""><spring:message code="labal.dtNm"/></label></option>
				                 	<option value="1"><label class=""><spring:message code="labal.srcExp"/></label></option>
								</select>
								<input name="searchWord" type="text" value=""/>
								${sessionScope.button.btn_search}        
							</td>
						</tr>
				</table>                 
			</from>
			<div style="clear: both;"></div>
			<div class="ibsheet_area_both">
				<script type="text/javascript">createIBSheet("mySheet1", "100%", "300px"); </script>     
			</div>
			<div class="buttons">
			${sessionScope.button.a_close}        
			</div>          
		</div>
	</div>
</html>