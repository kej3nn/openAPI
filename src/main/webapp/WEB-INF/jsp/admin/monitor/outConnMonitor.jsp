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
	var formObj = $("form[name=out-conn-monitor]:eq(0)");
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
	var formObj = $("form[name=out-conn-monitor]:eq(0)");
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
	formObj.find("input[name=startDttm]").val(dateFrom);
	formObj.find("input[name=endDttm]").val(dateTo);
}

function LoadPage() {      
	//message-common_ko_KR.properties 선언 후 사용 or message-common_en_US.properties 선언 후 사용
	var gridTitle = "NO";
		gridTitle +="|"+"기관명";  
		gridTitle +="|"+"작업명";
		gridTitle +="|"+"테이블명";
		gridTitle +="|"+"데이터셋타입";
		gridTitle +="|"+"적재건수";
		gridTitle +="|"+"종료시간";
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
					 {Type:"Seq",			SaveName:"Seq",						Width:30,	Align:"Center",		Edit:false}
			 		,{Type:"Text",			SaveName:"orgNm",					Width:50,	Align:"Center",		Edit:false}
					,{Type:"Text",			SaveName:"jobNm",					Width:80,	Align:"Center",		Edit:false}
					,{Type:"Text",			SaveName:"tbNm",				Width:80,	Align:"Center",		Edit:false}
					,{Type:"Text",			SaveName:"dsType",				Width:50,	Align:"Center",		Edit:false}
					,{Type:"Text",			SaveName:"procCnt",					Width:50,	Align:"Center",		Edit:false}
					,{Type:"Text",			SaveName:"endDttm",				Width:50,	Align:"Center",		Edit:false}
					,{Type:"Text",			SaveName:"jobMsg",					Width:100,	Align:"Center",		Edit:false}
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
			var formObj = classObj.find("form[name=out-conn-monitor]");
		
			ajaxBeforeSendAdmin("<c:url value='/admin/ajaxBeforeSendAdmin.do'/>"); //IbSheet 조회전 세션 체크
			var param = {PageParam: "ibpage", Param: "onepagerow=50&"+formObj.serialize()};     
			mySheet.DoSearchPaging("<c:url value='/admin/monitor/outConnMonitorList.do'/>", param);   
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
			<form name="out-conn-monitor"  method="post" action="#">
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
					<th>작업명</th>
					<td colspan="3">
						<input name="searchWord" type="text" value=""/>
						<button type="button" class="btn01B" name="btn_search"><spring:message code="btn.inquiry"/></button>
					</td>
				</tr>
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