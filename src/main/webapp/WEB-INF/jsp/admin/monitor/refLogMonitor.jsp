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
	init();
	setDate(); //날짜
	doAction('search');
});

function init(){
	var formObj = $("form[name=ref-monitor]:eq(0)");
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
	var formObj = $("form[name=ref-monitor]:eq(0)");
	var now = new Date();
	var yester = new Date();
	yester.setMonth(yester.getMonth()-1);
	var n_year = now.getFullYear();
	var y_year = yester.getFullYear();
	var n_mon = (now.getMonth()+1)>9?now.getMonth()+1:'0'+(now.getMonth()+1);
	var y_mon = (yester.getMonth()+1)>9?yester.getMonth()+1:'0'+(yester.getMonth()+1);
	var n_day = (now.getDate())>9?(now.getDate()):'0'+(now.getDate());
	var y_day = (yester.getDate())>9?(yester.getDate()):'0'+(yester.getDate());
	var dateFrom=y_year+'-'+y_mon+'-'+y_day;
	var dateTo=n_year+'-'+n_mon+'-'+n_day;
	formObj.find("input[name=startDttm]").val(dateTo);
	formObj.find("input[name=endDttm]").val(dateTo);
}

function LoadPage() {      
	//message-common_ko_KR.properties 선언 후 사용 or message-common_en_US.properties 선언 후 사용
	var gridTitle = "NO";
		gridTitle +="|"+"OWNER";  
		gridTitle +="|"+"데이터셋ID";
		gridTitle +="|"+"데이터셋명";
		gridTitle +="|"+"전체건수";
		gridTitle +="|"+"성공건수";
		gridTitle +="|"+"오류건수";
		gridTitle +="|"+"실패건수";
		gridTitle +="|"+"작업일시";
		gridTitle +="|"+"작업결과";
	
    with(mySheet){    
    	                     
    	var cfg = {SearchMode:3,Page:50,VScrollMode:1};                                  
        SetConfig(cfg);  
        var headers = [                                                      
                    {Text:gridTitle, Align:"Center"}                 
                ];
        var headerInfo = {Sort:0,ColMove:1,ColResize:1,HeaderCheck:0};
        
        InitHeaders(headers, headerInfo); 
         
        var cols = [          
					 {Type:"Text",			SaveName:"refineNo",				Width:20,	Align:"Center",		Edit:false}
			 		,{Type:"Text",			SaveName:"ownerCd",					Width:50,	Align:"Center",		Edit:false}
					,{Type:"Text",			SaveName:"dsId",					Width:80,	Align:"Center",		Edit:false}
					,{Type:"Text",			SaveName:"dsNm",					Width:50,	Align:"Left",		Edit:false}
					,{Type:"Int",			SaveName:"totCnt",					Width:30,	Align:"Right",		Edit:false, Format:"#,###"}
					,{Type:"Int",			SaveName:"valCnt",					Width:30,	Align:"Right",		Edit:false, Format:"#,###"}
					,{Type:"Int",			SaveName:"errCnt",					Width:30,	Align:"Right",		Edit:false, Format:"#,###"}
					,{Type:"Int",			SaveName:"wrCnt",					Width:30,	Align:"Right",		Edit:false, Format:"#,###"}
					,{Type:"Text",			SaveName:"workDttm",				Width:150,	Align:"Center",		Edit:false}
					,{Type:"Text",			SaveName:"ptocNm",					Width:30,	Align:"Center",		Edit:false}
               ];
                                      
        InitColumns(cols);                                                                           
        FitColWidth();                                                         
        SetExtendLastCol(1);  
        default_sheet(mySheet);  
        
    }           
        
    //datepickerTrigger();
}    

function doAction(sAction) {
	switch(sAction) {          
		case "search":      //조회      
		
			var classObj = $("." +"content").eq(0); //tab으로 인하여 form이 다건임
			var formObj = classObj.find("form[name=ref-monitor]");
		
			ajaxBeforeSendAdmin("<c:url value='/admin/ajaxBeforeSendAdmin.do'/>"); //IbSheet 조회전 세션 체크
			var param = {PageParam: "ibpage", Param: "onepagerow=50&"+formObj.serialize()};
			mySheet.DoSearchPaging("<c:url value='/admin/monitor/refMonitorList.do'/>", param);   
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
		
		<div class="content" style="min-height:500px;"> 
			<form name="ref-monitor"  method="post" action="#">
			<table class="list01">              
				
				<colgroup>
					<col width="150"/>
				</colgroup>
				<tr>
					<th><label class="">작업종료일</label></th>
					<td colspan="3">
						<input type="text" name="startDttm" value="" readonly="readonly"/>
						<input type="text" name="endDttm" value="" readonly="readonly"/>
					</td>
				</tr>
				<tr>
					<th>작업결과</th>
					<td colspan="3">
						<input type="radio" name="workResult" value="" checked="checked">전체 &nbsp;
						<input type="radio" name="workResult" value="S">성공 &nbsp;
						<input type="radio" name="workResult" value="F">실패 &nbsp;
					</td>
				</tr>
				<tr>
					<th>검색어</th>
					<td colspan="3">
						<select name="searchType">
							<option value="dsNm">데이터셋명</option>
							<option value="dsId">데이터셋ID</option>
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
					<script type="text/javascript">createIBSheet("mySheet", "100%", "500px"); </script>             
				</div>
			</div>
	</div>	
	
</div>
</body>
</html>