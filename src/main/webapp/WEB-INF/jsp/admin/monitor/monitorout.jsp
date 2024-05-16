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
<script language="javascript">

$(document).ready(function()    {
	LoadPage();
	setDate();
	doAction('search');    
	inputEnterKey();
	setButton();
});    

function setDate(){
	var formObj = $("form[name=monitorOut]");
	var now = new Date();		
	
	var prevNow =new Date(Date.parse(now) -6*1000*60*60*24);
	var year1 = prevNow.getFullYear();
	var mon1 = (prevNow.getMonth()+1)>9?prevNow.getMonth()+1:'0'+(prevNow.getMonth()+1);
	var day1 = prevNow.getDate()>9?prevNow.getDate():'0'+prevNow.getDate();
	var date1=year1+'-'+mon1+'-'+day1;
	
	var year = now.getFullYear();
	var mon = (now.getMonth()+1)>9?now.getMonth()+1:'0'+(now.getMonth()+1);
	var day = now.getDate()>9?now.getDate():'0'+now.getDate();
	var date=year+'-'+mon+'-'+day;    
	formObj.find("input[name=createDttm]").val(date1);                                              
	formObj.find("input[name=createDttm]").datepicker(setCalendar()); 
	formObj.find("input[name=fnlLoadEndDtm]").val(date);             
	formObj.find("input[name=fnlLoadEndDtm]").datepicker(setCalendar());          
}
function setButton(){
 	$("button[name=btn_search]").click(function(){
		doAction("search");
		return false;
	});
}
function LoadPage()                
{      
	//message-common_ko_KR.properties 선언 후 사용 or message-common_en_US.properties 선언 후 사용
	var gridTitle1 = "연계 정보";
		gridTitle1 +="|"+"연계 정보";  
		gridTitle1 +="|"+"연계 정보";  
		gridTitle1 +="|"+"연계 정보";  
		gridTitle1 +="|"+"<spring:message code='labal.monitorData'/>";
		gridTitle1 +="|"+"<spring:message code='labal.monitorData'/>";
		gridTitle1 +="|"+"<spring:message code='labal.monitorData'/>";
		gridTitle1 +="|"+"<spring:message code='labal.monitorFile'/>";
		gridTitle1 +="|"+"<spring:message code='labal.monitorFile'/>";
		gridTitle1 +="|"+"<spring:message code='labal.monitorFile'/>";  
	var gridTitle2 = "NO";
		gridTitle2 +="|"+"<spring:message code='labal.agency'/>";  
		gridTitle2 +="|"+"<spring:message code='labal.tableName'/>";  
		gridTitle2 +="|"+"<spring:message code='labal.createDttm'/>";     
		gridTitle2 +="|"+"<spring:message code='labal.sendCnt'/>";
		gridTitle2 +="|"+"<spring:message code='labal.successCnt'/>"; 
		gridTitle2 +="|"+"<spring:message code='labal.failCnt'/>"; 
		gridTitle2 +="|"+"<spring:message code='labal.sendCnt'/>"; 
		gridTitle2 +="|"+"<spring:message code='labal.successCnt'/>"; 
		gridTitle2 +="|"+"<spring:message code='labal.failCnt'/>"; 
	       
    with(mySheet){
    	                     
    	var cfg = {SearchMode:3,Page:50};                                
        SetConfig(cfg);  
        var headers = [                                             
                    {Text:gridTitle1, Align:"Center"},
                    {Text:gridTitle2, Align:"Center"}
                ];
        var headerInfo = {Sort:0,ColMove:1,ColResize:0,HeaderCheck:0};
        
        InitHeaders(headers, headerInfo); 
         
        var cols = [          
					 {Type:"Seq",			SaveName:"Seq",						Width:30,	Align:"Center",		Edit:false}
					,{Type:"Text",			SaveName:"agency",					Width:100,	Align:"Left",		Edit:false}
					,{Type:"Text",			SaveName:"tableName",				Width:100,	Align:"Left",		Edit:false}
					,{Type:"Text",			SaveName:"createDttm",				Width:100,	Align:"Center",		Edit:false,		Format:"YmdHm"}
					,{Type:"Text",			SaveName:"dataSendCnt",				Width:60,	Align:"Right",		Edit:false}
					,{Type:"Text",			SaveName:"dataSuccessCnt",			Width:60,	Align:"Right",		Edit:false}
					,{Type:"Text",			SaveName:"dataFailCnt",				Width:60,	Align:"Right",		Edit:false}
					,{Type:"Text",			SaveName:"fileSendCnt",				Width:60,	Align:"Right",		Edit:false}
					,{Type:"Text",			SaveName:"fileSuccessCnt",			Width:60,	Align:"Right",		Edit:false}
					,{Type:"Text",			SaveName:"fileFailCnt",				Width:60,	Align:"Right",		Edit:false}
                ];
                                           
        InitColumns(cols);                                                                           
        FitColWidth();                                                         
        SetExtendLastCol(1);   
    }               
    default_sheet(mySheet);
    mySheet.SetMergeSheet(5);
    datepickerTrigger();
}    


/*Sheet 각종 처리*/                  
function doAction(sAction)                                  
{
	switch(sAction)
	{          
		case "search":      //조회   
			var formObj = $("form[name=monitorOut]");   
		
			fromObj = formObj.find("input[name=createDttm]");                          
			toObj = formObj.find("input[name=fnlLoadEndDtm]");           
			dateValCheck(fromObj,toObj)// from , to 날짜 안맞을 경우 자동셋팅 
			
			ajaxBeforeSendAdmin("<c:url value='/admin/ajaxBeforeSendAdmin.do'/>"); //IbSheet 조회전 세션 체크
			var param = {PageParam: "ibpage", Param: "onepagerow=50&"+formObj.serialize()};     
			mySheet.DoSearchPaging("<c:url value='/admin/monitor/monitorOutList.do'/>", param);   
			break;
	}           
}   

//마우스 이벤트
function mySheet_OnSearchEnd(code, msg)
{
   if(msg != "")
	{
	    alert(msg);
    }
}


function inputEnterKey(){
	$("input").keypress(function(e) {
		  if(e.which == 13) {
			  doAction('search');   
			  return false;
		  }
	});
}    

</script>
</head>      
<body onload="">
<div class="wrap">
	<c:import  url="/admin/admintop.do"/>
	<!--##  메인  ##-->
	<div class="container">
		<!-- 상단 타이틀 -->   
		<div class="title">
			<h2>${MENU_NM}</h2>                                      
			<p>${MENU_URL}</p>             
		</div>
		
		<div class="popup" style="padding: 20px;"> 
			<form name="monitorOut"  method="post" action="#">
			<table class="list01">              
				<caption>회원목록</caption>
				<colgroup>
					<col width="150"/>
					<col width=""/>
				</colgroup>
				<tr>
					<th>검 색 어</th>
					<td colspan="3">
						<select name="searchWd">
							<option value="">선택</option>
							<option value="0" selected="selected">테이블명</option>
						</select>
						<input name="searchWord" type="text" value=""/>
						<button type="button" class="btn01B" name="btn_search"><spring:message code="btn.inquiry"/></button>
					</td>
				</tr>
				<tr>
					<th><label class=""><spring:message code="labal.elapsedDay"/></label></th>
					<td colspan="3">
						<input type="text" name="createDttm" value="" readonly="readonly"/>
						<input type="text" name="fnlLoadEndDtm" value="" readonly="readonly"/>                
					</td>
				</tr>
			</table>	
			</form>		
				<!-- ibsheet 영역 -->
				<div style="clear: both;"></div>
				<div class="ibsheet_area_both">
					<script type="text/javascript">createIBSheet("mySheet", "100%", "300px"); </script>             
				</div>
			</div>
	</div>	
</div>
</body>
</html>