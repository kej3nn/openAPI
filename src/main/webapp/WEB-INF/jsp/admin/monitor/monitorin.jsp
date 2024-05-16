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
	LoadSheet();
	//setDate();
	doAction('search');
	inputEnterKey();
	setButton();
});    

/* function setDate(){
	var formObj = $("form[name=monitorIn]");
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
	formObj.find("input[name=fnlLoadDtm]").val(date1);                                              
	formObj.find("input[name=fnlLoadDtm]").datepicker(setCalendar()); 
	formObj.find("input[name=fnlLoadEndDtm]").val(date);             
	formObj.find("input[name=fnlLoadEndDtm]").datepicker(setCalendar());                   
	datepickerTrigger();                             
} */

function setButton(){
 	$("button[name=btn_search]").click(function(){
		doAction("search");
		return false;
	});
}

function LoadPage()                
{      
	//message-common_ko_KR.properties 선언 후 사용 or message-common_en_US.properties 선언 후 사용
	var gridTitle = "NO";
		gridTitle +="|"+"<spring:message code='labal.dsIdName'/>";  
		gridTitle +="|"+"<spring:message code='labal.dsTitle'/>";
		gridTitle +="|"+"<spring:message code='labal.systemCode'/>";
		gridTitle +="|"+"<spring:message code='labal.sDbCode'/>";
		gridTitle +="|"+"<spring:message code='labal.tDbCode'/>";
		gridTitle +="|"+"<spring:message code='labal.cateNmm'/>";
		gridTitle +="|"+"<spring:message code='labal.cApiDay'/>";
		gridTitle +="|"+"<spring:message code='labal.batchSchedule'/>";
		gridTitle +="|"+"<spring:message code='labal.batchDay'/>";
		gridTitle +="|"+"<spring:message code='labal.batchTm'/>";
	
    with(mySheet){    
    	                     
    	var cfg = {SearchMode:2,Page:50};                                
        SetConfig(cfg);  
        var headers = [                                                      
                    {Text:gridTitle, Align:"Center"}                 
                ];
        var headerInfo = {Sort:0,ColMove:1,ColResize:1,HeaderCheck:1};
        
        InitHeaders(headers, headerInfo); 
         
        var cols = [          
					 {Type:"Seq",			SaveName:"Seq",						Width:30,	Align:"Center",		Edit:false}
			 		,{Type:"Text",			SaveName:"dsIdName",					Width:100,	Align:"Center",		Edit:false}
					,{Type:"Text",			SaveName:"dsTitle",					Width:100,	Align:"Center",		Edit:false}
					,{Type:"Text",			SaveName:"systemCode",				Width:40,	Align:"Center",		Edit:false}
					,{Type:"Text",			SaveName:"sDbCode",					Width:40,	Align:"Center",		Edit:false}
					,{Type:"Text",			SaveName:"tDbCode",				Width:40,	Align:"Center",		Edit:false}
					,{Type:"Text",			SaveName:"cateNmm",					Width:40,	Align:"Center",		Edit:false}
					,{Type:"Text",			SaveName:"cApiDay",					Width:50,	Align:"Center",		Edit:false}
					,{Type:"Text",			SaveName:"batchSchedule",				Width:50,	Align:"Center",		Edit:false}
					,{Type:"Text",			SaveName:"batchDay",				Width:50,	Align:"Center",		Edit:false}
					,{Type:"Text",			SaveName:"batchTm",				Width:50,	Align:"Center",		Edit:false}
                ];
                                      
        InitColumns(cols);                                                                           
        FitColWidth();                                                         
        SetExtendLastCol(1);  
        default_sheet(mySheet);  
        
    }           
        
    //datepickerTrigger();
}    

function LoadSheet()                
{      
	//message-common_ko_KR.properties 선언 후 사용 or message-common_en_US.properties 선언 후 사용
	var gridTitle = "NO";
		gridTitle +="|"+"<spring:message code='labal.srcTableNm'/>";  
		gridTitle +="|"+"<spring:message code='labal.tgtTableNm'/>";
		gridTitle +="|"+"<spring:message code='labal.srcTableDivNm'/>";
		gridTitle +="|"+"<spring:message code='labal.startTm'/>";
		gridTitle +="|"+"<spring:message code='labal.endTm'/>";
		gridTitle +="|"+"<spring:message code='labal.jobTm'/>";
		gridTitle +="|"+"<spring:message code='labal.totalCnt'/>";
		gridTitle +="|"+"<spring:message code='labal.processCnt'/>";
		gridTitle +="|"+"<spring:message code='labal.insertCnt'/>";
		gridTitle +="|"+"<spring:message code='labal.updateCnt'/>";
		gridTitle +="|"+"<spring:message code='labal.deleteCnt'/>";
		gridTitle +="|"+"<spring:message code='labal.errorCnt'/>";
		gridTitle +="|"+"<spring:message code='labal.status'/>";
		gridTitle +="|"+"<spring:message code='labal.errorMsq'/>";
	
    with(loadSheet){    
    	                     
    	var cfg = {SearchMode:2,Page:50};                                
        SetConfig(cfg);  
        var headers = [                                                      
                    {Text:gridTitle, Align:"Center"}                 
                ];
        var headerInfo = {Sort:0,ColMove:1,ColResize:1,HeaderCheck:0};
        
        InitHeaders(headers, headerInfo); 
         
        var cols = [          
					 {Type:"Seq",			SaveName:"Seq",						Width:30,	Align:"Center",		Edit:false}
			 		,{Type:"Text",			SaveName:"srcTableNm",					Width:120,	Align:"Center",		Edit:false}
					,{Type:"Text",			SaveName:"tgtTableNm",					Width:120,	Align:"Center",		Edit:false}
					,{Type:"Text",			SaveName:"srcTableDivNm",				Width:80,	Align:"Center",		Edit:false}
					,{Type:"Text",			SaveName:"startTm",					Width:100,	Align:"Center",		Edit:false}
					,{Type:"Text",			SaveName:"endTm",				Width:100,	Align:"Center",		Edit:false}
					,{Type:"Text",			SaveName:"jobTm",					Width:50,	Align:"Center",		Edit:false}
					,{Type:"Text",			SaveName:"totalCnt",					Width:50,	Align:"Center",		Edit:false}
					,{Type:"Text",			SaveName:"processCnt",				Width:80,	Align:"Center",		Edit:false}
					,{Type:"Text",			SaveName:"insertCnt",				Width:80,	Align:"Center",		Edit:false}
					,{Type:"Text",			SaveName:"updateCnt",				Width:80,	Align:"Center",		Edit:false}
					,{Type:"Text",			SaveName:"deleteCnt",				Width:80,	Align:"Center",		Edit:false}
					,{Type:"Text",			SaveName:"errorCnt",				Width:80,	Align:"Center",		Edit:false}
					,{Type:"Text",			SaveName:"status",				Width:80,	Align:"Center",		Edit:false}
					,{Type:"Text",			SaveName:"errorMsq",				Width:80,	Align:"Center",		Edit:false}
                ];
                                      
        InitColumns(cols);                                                                           
        FitColWidth();                                                         
        SetExtendLastCol(1);   
    }               
    default_sheet(loadSheet);       
    //datepickerTrigger();
}    

function mySheet_OnDblClick(row, col, value, cellx, celly) {
    
	if(row == 0) return;    
	
	//var classObj = $("." +"content").eq(1); //tab으로 인하여 form이 다건임
	//var actObj = setTabForm(classObj); // 0: form data, 1: form 객체
	//var objTab = getTabShowObj();//탭이 oepn된 객체가져옴
	//var formObj = classObj.find("form[name=monitorIn]");
	
	var dsIdName = mySheet.GetCellValue(row, "dsIdName");
	
	ajaxBeforeSendAdmin("<c:url value='/admin/ajaxBeforeSendAdmin.do'/>"); //IbSheet 조회전 세션 체크
	var param = {PageParam: "ibpage", Param: "onepagerow=50&dsIdName="+dsIdName};     
	loadSheet.DoSearchPaging("<c:url value='/admin/monitor/monitorOutList.do'/>", param);
	
 	//doActionTab('search');
                 
}


/*Sheet 각종 처리*/                  
function doAction(sAction)                                  
{
	switch(sAction)
	{          
		case "search":      //조회      
		
			var classObj = $("." +"content").eq(0); //tab으로 인하여 form이 다건임
			//var actObj = setTabForm(classObj); // 0: form data, 1: form 객체
			//var objTab = getTabShowObj();//탭이 oepn된 객체가져옴
			var formObj = classObj.find("form[name=monitorIn]");
		
			//var formObj = $("form[name=monitorIn]");                      
			//fromObj = formObj.find("input[name=fnlLoadDtm]");                          
			//toObj = formObj.find("input[name=fnlLoadEndDtm]");
			//dateValCheck(fromObj,toObj)// from , to 날짜 안맞을 경우 자동셋팅   
			
			ajaxBeforeSendAdmin("<c:url value='/admin/ajaxBeforeSendAdmin.do'/>"); //IbSheet 조회전 세션 체크
			var param = {PageParam: "ibpage", Param: "onepagerow=50&"+formObj.serialize()};     
			mySheet.DoSearchPaging("<c:url value='/admin/monitor/monitorInList.do'/>", param);   
			break;
	}           
}   

function doActionTab(sAction)                                  
{
	
	var dsId = mySheet.GetCellValue(row, "dsIdName");
	
	switch(sAction)
	{          
		case "search":      //조회            
			var classObj = $("." +"content").eq(1); //tab으로 인하여 form이 다건임
			//var actObj = setTabForm(classObj); // 0: form data, 1: form 객체
			//var objTab = getTabShowObj();//탭이 oepn된 객체가져옴
			var formObj = classObj.find("form[name=monitorIn]");
			
			var dsId = 
			
			ajaxBeforeSendAdmin("<c:url value='/admin/ajaxBeforeSendAdmin.do'/>"); //IbSheet 조회전 세션 체크
			var param = {PageParam: "ibpage", Param: "onepagerow=50&dsId="+dsId};     
			loadSheet.DoSearchPaging("<c:url value='/admin/monitor/monitorOutList.do'/>", param);   
			break;
	}           
}   

//마우스 이벤트
/* function mySheet_OnSearchEnd(code, msg)
{
   if(msg != "")
	{
	    alert(msg);
    }
} */


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
		
		<div class="content"> 
			<form name="monitorIn"  method="post" action="#">
			<table class="list01">              
				
				<colgroup>
					<col width="150"/>
				</colgroup>
				<tr>
					<th>검 색 어</th>
					<td colspan="3">
						<select name="searchWd">
							<option value="">선택</option>
							<option value="0" selected="selected">데이터셋명</option>
							<option value="1">데이터셋ID</option>
						</select>
						<input name="searchWord" type="text" value=""/>
						<button type="button" class="btn01B" name="btn_search"><spring:message code="btn.inquiry"/></button>
					</td>
				</tr>
				<%-- <tr>
					<th><label class=""><spring:message code="labal.elapsedDay"/></label></th>
					<td colspan="3">
						<input type="text" name="fnlLoadDtm" value="" readonly="readonly"/>
						<input type="text" name="fnlLoadEndDtm" value="" readonly="readonly"/>
					</td>
				</tr> --%>
			</table>	
			</form>		
				<!-- ibsheet 영역 -->
				<div style="clear: both;"></div>
				<div class="ibsheet_area_both">
					<script type="text/javascript">createIBSheet("mySheet", "100%", "300px"); </script>             
				</div>
			</div>
			
			<!-- 탭 내용 --> 
		<div class="content">
			<h3 class="text-title2">상세 화면</h3>
			<form name="monitorIn"  method="post" action="#">
				
					<!-- ibsheet 영역 -->
				<!-- <div class="ibsheet-header">				
					<h3 class="text-title2">상세 내역</h3>
				</div> -->
				<!-- ibsheet 영역 -->
				<div style="clear: both;"></div>
				<div class="ibsheet_area_both">
					<script type="text/javascript">createIBSheet("loadSheet", "100%", "300px"); </script>             
		</div>
		</div>
			
	</div>	
	
	
		
	
		
	
</div>
</body>
</html>