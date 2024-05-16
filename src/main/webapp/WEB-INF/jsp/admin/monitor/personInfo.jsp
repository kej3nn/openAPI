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
	var formObj = $("form[name=person-info-monitor]:eq(0)");
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
	var formObj = $("form[name=person-info-monitor]:eq(0)");
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
		gridTitle +="|"+"구분";  
		gridTitle +="|"+"회차";  
		gridTitle +="|"+"작업명";
		gridTitle +="|"+"총테이블수";
		gridTitle +="|"+"총레코드수";
		gridTitle +="|"+"스캔레코드수";
		gridTitle +="|"+"검출레코드수";
		gridTitle +="|"+"개인정보검출합계";
		gridTitle +="|"+"스캔시작시간";
		gridTitle +="|"+"스캔종료시간";
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
					 {Type:"Seq",			SaveName:"Seq",						Width:30,	Align:"Center",		Edit:false}
			 		,{Type:"Text",			SaveName:"gubun",					Width:50,	Align:"Center",		Edit:false}
					,{Type:"Text",			SaveName:"time",					Width:50,	Align:"Center",		Edit:false}
					,{Type:"Text",			SaveName:"jobNm",				Width:70,	Align:"Center",		Edit:false}
					,{Type:"Text",			SaveName:"totalTbCnt",					Width:70,	Align:"Center",		Edit:false}
					,{Type:"Text",			SaveName:"totalRowCnt",				Width:70,	Align:"Center",		Edit:false}
					,{Type:"Text",			SaveName:"scanRowCnt",					Width:50,	Align:"Center",		Edit:false}
					,{Type:"Text",			SaveName:"detRowCnt",					width:30,	Align:"Center",		Edit:false}
					,{Type:"Text",			SaveName:"total",				width:30,	Align:"Center",		Edit:false}
					,{Type:"Text",			SaveName:"startDttm",				width:60,	Align:"Center",		Edit:false}
					,{Type:"Text",			SaveName:"endDttm",				width:60,	Align:"Center",		Edit:false}
					,{Type:"Text",			SaveName:"indvdlInfoResltSn",				width:0,	Align:"Center",		Edit:false, Hidden:true}
                ];
                                      
        InitColumns(cols);                                                                           
        FitColWidth();                                                         
        SetExtendLastCol(1);  
        default_sheet(mySheet);  
        
    }           
        
}    

function doAction(sAction) {
	switch(sAction) {          
		case "search":      //조회      
		
			var classObj = $("." +"content").eq(0); //tab으로 인하여 form이 다건임
			var formObj = classObj.find("form[name=person-info-monitor]");
		
			ajaxBeforeSendAdmin("<c:url value='/admin/ajaxBeforeSendAdmin.do'/>"); //IbSheet 조회전 세션 체크
			var param = {PageParam: "ibpage", Param: "onepagerow=50&"+formObj.serialize()};     
			mySheet.DoSearchPaging("<c:url value='/admin/monitor/personInfoList.do'/>", param);   
			break;
	}           
}   

function mySheet_OnDblClick(row, col, value, cellx, celly) {
	if(row == 0) return;    
	var indvdlInfoResltSn = mySheet.GetCellValue(row, "indvdlInfoResltSn");
	
	$.get("<c:url value='/admin/monitor/personInfoDetail.do'/>", {indvdlInfoResltSn:indvdlInfoResltSn}, function(data) {
		var info = data.DATA;
		$.each(info, function(key, value) {
			$('#'+key).text(value + " 건");
		});
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
			<form name="person-info-monitor"  method="post" action="#">
			<table class="list01">              
				
				<colgroup>
					<col width="150"/>
				</colgroup>
				<tr>
					<th><label class="">스캔시작일</label></th>
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
		
		<div class="content" style="min-height:235px;">
			<h3 class="text-title2">상세 화면</h3>
			<table class="list01">     
				<colgroup>
					<col width="150"/>
					<col width=""/>
					<col width="150"/>
					<col width=""/>
				</colgroup>         
				<tr>
					<th>주민등록번호</th>
					<td id="social"></td>
					<th>외국인등록번호</th>
					<td id="foreign"></td>
				</tr>
				<tr>
					<th>여권번호</th>
					<td id="passport"></td>
					<th>운전면허번호</th>
					<td id="liense"></td>
				</tr>
				<tr>
					<th>신용카드번호</th>
					<td id="credit"></td>
					<th>계좌번호</th>
					<td id="account"></td>
				</tr>
				<tr>
					<th>휴대폰번호</th>
					<td id="mobile"></td>
					<th>전화번호</th>
					<td id="phone"></td>
				</tr>
				<tr>
					<th>이메일</th>
					<td id="email"></td>
					<th>법인등록번호</th>
					<td id="corp"></td>
				</tr>
				<tr>
					<th>사업자등록번호</th>
					<td id="business"></td>
					<th>건강보험번호</th>
					<td id="healthInsurance"></td>
				</tr>
				<tr>
					<th>키워드</th>
					<td colspan="3" id="keyword"></td>
				</tr>
			</table>
		</div>
		
	</div>	
	
</div>
</body>
</html>