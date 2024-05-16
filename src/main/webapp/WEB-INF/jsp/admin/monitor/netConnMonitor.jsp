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
	init();
	setDate(); //날짜
	doAction('search');
});

function init(){
	var formObj = $("form[name=net-conn-monitor]:eq(0)");
	formObj.find("input[name=endDttm]").datepicker(setCalendar());          
	formObj.find("input[name=startDttm]").datepicker(setCalendar());      
	datepickerTrigger();     
	formObj.find("button[name=btn_search]").click(function(e) { //조회
		doAction("search");
		 return false;
	 });
	formObj.find("input[name=searchWord]").bind("keydown", function(event) {
        if (event.which == 13) {
    		doAction("search");
    		return false;
        }
    });
}
function setDate(){
	var formObj = $("form[name=net-conn-monitor]:eq(0)");
	var now = new Date();
	var yester = new Date(Date.parse(new Date)-1*1000*60*60*24);
	var n_year = now.getFullYear();
	var y_year = yester.getFullYear();
	var n_mon = (now.getMonth()+1)>9?now.getMonth()+1:'0'+(now.getMonth()+1);
	var y_mon = (yester.getMonth()+1)>9?yester.getMonth()+1:'0'+(yester.getMonth()+1);
	var n_day = (now.getDate())>9?(now.getDate()):'0'+(now.getDate());
	var y_day = (yester.getDate())>9?(yester.getDate()):'0'+(yester.getDate());
	var dateFrom=y_year+'-'+y_mon+'-'+y_day;
	var dateTo=n_year+'-'+n_mon+'-'+n_day;
	formObj.find("input[name=startDttm]").val(dateFrom);
	formObj.find("input[name=endDttm]").val(dateTo);
}

function LoadPage() {      
	//message-common_ko_KR.properties 선언 후 사용 or message-common_en_US.properties 선언 후 사용
	var gridTitle = "NO";
		gridTitle +="|"+"원천DB";  
		gridTitle +="|"+"타겟DB";
		gridTitle +="|"+"WORKPLAN";
		gridTitle +="|"+"시작시간";
		gridTitle +="|"+"종료시간";
		gridTitle +="|"+"작업시간";
		gridTitle +="|"+"전체건수";
		gridTitle +="|"+"프로세스건수";
		gridTitle +="|"+"삽입";
		gridTitle +="|"+"수정";
		gridTitle +="|"+"삭제";
		gridTitle +="|"+"에러건수";
		gridTitle +="|"+"성공여부";
		gridTitle +="|"+"errorMsg";
		gridTitle +="|"+"";
	
    with(mySheet){    
    	                     
    	var cfg = {SearchMode:3,Page:50,VScrollMode:1};                                  
        SetConfig(cfg);  
        var headers = [                                                      
                    {Text:gridTitle, Align:"Center"}                 
                ];
        var headerInfo = {Sort:0,ColMove:1,ColResize:1,HeaderCheck:0};
        
        InitHeaders(headers, headerInfo); 
         
        var cols = [          
					 {Type:"Seq",			SaveName:"Seq",						Width:30,	Align:"Center",		Edit:false,  Sort:false}
			 		,{Type:"Text",			SaveName:"fromDB",					Width:50,	Align:"Center",		Edit:false}
					,{Type:"Text",			SaveName:"toDB",					Width:50,	Align:"Center",		Edit:false}
					,{Type:"Text",			SaveName:"workPlan",				Width:140,	Align:"Center",		Edit:false}
					,{Type:"Text",			SaveName:"startDttm",					Width:50,	Align:"Center",		Edit:false}
					,{Type:"Text",			SaveName:"endDttm",				Width:50,	Align:"Center",		Edit:false}
					,{Type:"Text",			SaveName:"workTime",					Width:50,	Align:"Center",		Edit:false}
					,{Type:"Text",			SaveName:"total",					width:30,	Align:"Center",		Edit:false}
					,{Type:"Text",			SaveName:"prcCnt",				width:30,	Align:"Center",		Edit:false}
					,{Type:"Text",			SaveName:"ins",				width:30,	Align:"Center",		Edit:false}
					,{Type:"Text",			SaveName:"mod",				width:30,	Align:"Center",		Edit:false}
					,{Type:"Text",			SaveName:"del",				width:30,	Align:"Center",		Edit:false}
					,{Type:"Text",			SaveName:"errCnt",				width:30,	Align:"Center",		Edit:false}
					,{Type:"Text",			SaveName:"successYN",				width:30,	Align:"Center",		Edit:false}
					,{Type:"Text",			SaveName:"errorMsg",				width:50,	Align:"Center",		Edit:false}
					,{Type:"Text",			SaveName:"progenitorId",				width:0,	Align:"Center",		Edit:false, Hidden:true}
                ];
                                      
        InitColumns(cols);                                                                           
        FitColWidth();                                                         
        SetExtendLastCol(1);  
        
    }           
    default_sheet(mySheet);  
        
    //datepickerTrigger();
}    

function LoadSheet() {      
	//message-common_ko_KR.properties 선언 후 사용 or message-common_en_US.properties 선언 후 사용
	var gridTitle = "NO";
		gridTitle +="|"+"테이블명";  
		gridTitle +="|"+"시작시간";
		gridTitle +="|"+"종료시간";
		gridTitle +="|"+"작업시간";
		gridTitle +="|"+"전체건수";
		gridTitle +="|"+"프로세스건수";
		gridTitle +="|"+"삽입";
		gridTitle +="|"+"수정";
		gridTitle +="|"+"삭제";
		gridTitle +="|"+"에러건수";
		gridTitle +="|"+"성공여부";
		gridTitle +="|"+"errorMsg";
		gridTitle +="|"+"";
	
    with(loadSheet){    
    	                     
    	var cfg = {SearchMode:3,Page:50,VScrollMode:1};
        SetConfig(cfg);  
        var headers = [                                                      
                    {Text:gridTitle, Align:"Center"}                 
                ];
        var headerInfo = {Sort:0,ColMove:1,ColResize:1,HeaderCheck:0};
        
        InitHeaders(headers, headerInfo); 
         
        var cols = [          
					 {Type:"Seq",			SaveName:"Seq",						Width:30,	Align:"Center",		Edit:false}
						,{Type:"Text",			SaveName:"tbNm",				Width:100,	Align:"Center",		Edit:false}
						,{Type:"Text",			SaveName:"startDttm",					Width:50,	Align:"Center",		Edit:false}
						,{Type:"Text",			SaveName:"endDttm",				Width:50,	Align:"Center",		Edit:false}
						,{Type:"Text",			SaveName:"workTime",					Width:50,	Align:"Center",		Edit:false}
						,{Type:"Text",			SaveName:"total",					width:30,	Align:"Center",		Edit:false}
						,{Type:"Text",			SaveName:"prcCnt",				width:30,	Align:"Center",		Edit:false}
						,{Type:"Text",			SaveName:"ins",				width:30,	Align:"Center",		Edit:false}
						,{Type:"Text",			SaveName:"mod",				width:30,	Align:"Center",		Edit:false}
						,{Type:"Text",			SaveName:"del",				width:30,	Align:"Center",		Edit:false}
						,{Type:"Text",			SaveName:"errCnt",				width:30,	Align:"Center",		Edit:false}
						,{Type:"Text",			SaveName:"successYN",				width:30,	Align:"Center",		Edit:false}
						,{Type:"Text",			SaveName:"errorMsg",				width:50,	Align:"Center",		Edit:false}
						,{Type:"Text",			SaveName:"progenitorId",				width:0,	Align:"Center",		Edit:false, Hidden:true}
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
	
	var progenitorId = mySheet.GetCellValue(row, "progenitorId");
	
	ajaxBeforeSendAdmin("<c:url value='/admin/ajaxBeforeSendAdmin.do'/>"); //IbSheet 조회전 세션 체크
	var param = {PageParam: "ibpage", Param: "onepagerow=50&progenitorId="+progenitorId};     
	loadSheet.DoSearchPaging("<c:url value='/admin/monitor/netConnMonitorDetail.do'/>", param);
	
 	//doActionTab('search');
                
}

function doAction(sAction) {
	switch(sAction) {          
		case "search":      //조회      
		
			var classObj = $("." +"content").eq(0); //tab으로 인하여 form이 다건임
			var formObj = classObj.find("form[name=net-conn-monitor]");
		
			ajaxBeforeSendAdmin("<c:url value='/admin/ajaxBeforeSendAdmin.do'/>"); //IbSheet 조회전 세션 체크
			var param = {PageParam: "ibpage", Param: "onepagerow=50&"+formObj.serialize()};     
			mySheet.DoSearchPaging("<c:url value='/admin/monitor/netConnMonitorList.do'/>", param);   
			break;
	}           
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
			<form name="net-conn-monitor"  method="post" action="#">
			<table class="list01">              
				
				<colgroup>
					<col width="150"/>
				</colgroup>
				<tr>
					<th><label class="">시작일</label></th>
					<td colspan="3">
						<input type="text" name="startDttm" value="" readonly="readonly"/>
						<input type="text" name="endDttm" value="" readonly="readonly"/>
					</td>
				</tr>
				<tr>
					<th>성공여부</th>
					<td colspan="3">
						<select name="successYN">
							<option value="">전체</option>
							<option value="S">성공</option>
							<option value="W">경고</option>
							<option value="F">실패</option>
						</select>
					</td>
				</tr>
				<tr>
					<th>WORKPLAN 명</th>
					<td colspan="3">
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
			<form name="net-conn-monitor"  method="post" action="#">
				
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