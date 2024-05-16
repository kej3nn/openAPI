<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%-- <%@ page import="egovframework.common.util"%> --%>
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
<!--  
	validate 사용시 반드시 선언
	formName명과 validate 함수명이 연결되어있음
	statOpen -> validatestatOpen 체크함
	resources/validator/*.* xml을 만들어서 사용
  -->
<%-- <validator:javascript formName="statOpen" staticJavascript="false" xhtml="true" cdata="false"/> --%>
<script language="javascript">   
$(document).ready(function()    {
	LoadPage();
	doAction("search");
	setButton();
});

function setButton(){ //버튼클릭시..
	$("button[name=btn_xlsDown]").click(function(e) { //엑셀다운
		doAction("excel");
		 return false;
	 });
	
}


function LoadPage()                
{      
	//message-common_ko_KR.properties 선언 후 사용 or message-common_en_US.properties 선언 후 사용
	var gridTitle = "NO";
		gridTitle +="|"+"<spring:message code='labal.orgCd'/>";		// 조직코드
		gridTitle +="|"+"<spring:message code='labal.provideOrg'/>";		// 제공기관
		gridTitle +="|"+"<spring:message code='labal.dtCnt'/>";		// 보유데이터(건)
		gridTitle +="|"+"<spring:message code='labal.openDt'/>";		// 공공데이터(건)
		gridTitle +="|"+"<spring:message code='labal.srvTot'/>";		// 전체서비스(건)
		gridTitle +="|"+"<spring:message code='labal.stat_sheetCnt'/>";		// RAW Sheet(수)
		gridTitle +="|"+"<spring:message code='labal.stat_chartCnt'/>";		// Chart(수)
		gridTitle +="|"+"<spring:message code='labal.stat_mapCnt'/>";		// Map(수)
		gridTitle +="|"+"<spring:message code='labal.stat_fileCnt'/>";		// File(수)
		gridTitle +="|"+"<spring:message code='labal.stat_linkCnt'/>";		// Link(수)
		gridTitle +="|"+"<spring:message code='labal.stat_openApiCnt'/>";		// Open API(수)
		gridTitle +="|"+"<spring:message code='labal.stat_vCnt'/>";		// Open API(수)
	
    with(mySheet){
    	                     
    	var cfg = {SearchMode:2,Page:50,VScrollMode:1};                                
        SetConfig(cfg);  
        var headers = [                                             
                    {Text:gridTitle, Align:"Center"}                
                ];
        var headerInfo = {Sort:0,ColMove:1,ColResize:1,HeaderCheck:0};
        
        InitHeaders(headers, headerInfo); 
        var cols = [ 
					 {Type:"Seq",		SaveName:"seq",				Width:30,	Align:"Center",		Edit:false}
					,{Type:"Text",		SaveName:"orgCd",			Width:50,	Align:"Center",		Edit:false, Hidden:true }
					,{Type:"Text",		SaveName:"orgNm",			Width:130,	Align:"Left",		Edit:false}
					,{Type:"AutoSum",		SaveName:"dtCnt",			Width:60,	Align:"Right",		Edit:false}
					,{Type:"AutoSum",		SaveName:"infCnt",			Width:60,	Align:"Right",		Edit:false}
					,{Type:"AutoSum",		SaveName:"srvTot",			Width:60,	Align:"Right",		Edit:false}
					,{Type:"AutoSum",		SaveName:"sheetCnt",		Width:60,	Align:"Right",		Edit:false}
					,{Type:"AutoSum",		SaveName:"chartCnt",		Width:60,	Align:"Right",		Edit:false}
					,{Type:"AutoSum",		SaveName:"mapCnt",			Width:60,	Align:"Right",		Edit:false}
					,{Type:"AutoSum",		SaveName:"fileCnt",			Width:60,	Align:"Right",		Edit:false}
					,{Type:"AutoSum",		SaveName:"linkCnt",			Width:60,	Align:"Right",		Edit:false}
					,{Type:"AutoSum",		SaveName:"openApiCnt",		Width:60,	Align:"Right",		Edit:false}
					,{Type:"AutoSum",		SaveName:"vCnt",		Width:60,	Align:"Right",		Edit:false}
                   ];       
                                      
        InitColumns(cols);                                                                           
        FitColWidth();                                                         
        SetExtendLastCol(1);   
    }               
    default_sheet(mySheet); 
    mySheet.SetSumValue(0,"orgNm","합계"); 
    mySheet.SetAutoSumPosition("1"); //autoSum 위치 지정 1은 최하단 0은 최상단 
}


function doAction(sAction)                                  
{
	switch(sAction)
	{         
		case "search":      //조회  
			ajaxBeforeSendAdmin("<c:url value='/admin/ajaxBeforeSendAdmin.do'/>"); //IbSheet 조회전 세션 체크
			mySheet.DoSearch("<c:url value='/admin/stat/stats/getStatsSheetAll.do'/>");
			break;
			
		case "excel":      
			mySheet.Down2Excel({FileName:'Excel.xls',SheetName:'mySheet'});
			break;
	}           
} 



</script>
</head>     
<body >
<div class="wrap">
		<c:import  url="/admin/admintop.do"/>
		<!--##  메인  ##-->
		<div class="container">
			<!-- 상단 타이틀 -->   
			<div class="title">
				<h2>${MENU_NM}</h2>                                      
				<p>${MENU_URL}</p>             
			</div>
			
			<!-- 탭 내용 -->
			
			<div class="more_list" style="display:none">
				<a href="#" class="more">0</a>                
				<ul class="other_list" style="display:none;">
					<li><a href="#">보유데이터목록</a><a href="#" class="line_close">x</a></li>
					<li><a href="#">공공데이터목록</a><a href="#" class="line_close">x</a></li>
				</ul>
			</div>
			
			<div class="content-default">
				
				<div class="statistics">
					<div class="statistics-list" title="실시간">
						<h4>공공데이터 개방기관</h4>
						<p>${CNT.orgCnt}건</p>
					</div>
					<div class="statistics-list" title="실시간">
						<h4>보유데이터</h4>
						<p>${CNT.dtCnt}개</p>
					</div>
					<div class="statistics-list" title="실시간">
						<h4>공공데이터 개방</h4>
						<p>${CNT.infTotalCnt}건</p>
					</div>
					<div class="statistics-list" title="실시간">
						<h4>개방 서비스유형</h4>
						<p>${CNT.srvCnt}건</p>
					</div>
					<div class="statistics-list p2" title="통계">
						<h4>공공데이터 활용</h4>
						<p>${CNT.statUseDtCnt}건</p>
					</div>
					<div class="statistics-list p2" title="통계">
						<h4>활용피드백</h4>
						<p>${CNT.feedBackCnt}건</p>
					</div>
				</div>
 
				<div class="ibsheet-header">				
					<h3 class="text-title2">공공데이터 개방 현황</h3>
					<p class="title-txt">
<!-- 						(평균개방율 : 98%)					 -->
					</p>
					<p>
<!-- 						<span>Excel Download :</span> -->
						${sessionScope.button.btn_xlsDown}
					</p>
				</div>
				<div class="ibsheet_area" style="height:400px;">
 					<script type="text/javascript">createIBSheet("mySheet", "100%", "400px"); </script>              
 				</div>
				
			</div>
			
		</div>
		
		<!--##  푸터  ##-->
 			 <c:import  url="/WEB-INF/jsp/admin/adminfooter.jsp"/>
		<!--##  /푸터  ##-->
</div>
</body>
</html>