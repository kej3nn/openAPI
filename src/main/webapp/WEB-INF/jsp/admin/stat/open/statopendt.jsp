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
<!--  
	validate 사용시 반드시 선언
	formName명과 validate 함수명이 연결되어있음
	statOpen -> validatestatOpen 체크함
	resources/validator/*.* xml을 만들어서 사용
  -->
<%-- <validator:javascript formName="statOpen" staticJavascript="false" xhtml="true" cdata="false"/> --%>
<script language="javascript">   
function tabSet(){ //탭 객체 생성  
	openTab = new OpenTab(tabId,tabContentClass,tabBody); //headinclude.jsp 변수 있음
	openTab.TabObj = openTab;  
	openTab.addTabClickEvent();    
}	

$(document).ready(function()    {    
	LoadPage();                                                               
//inputEnterKey();       
//	tabSet();// tab 셋팅
	init();
	setDate(); //날짜
	doAction('search');
}); 

function init(){
	var formObj = $("form[name=statOpen]");
	formObj.find("input[name=pubDttmTo]").datepicker(setCalendar());          
	formObj.find("input[name=pubDttmFrom]").datepicker(setCalendar());      
	datepickerTrigger();     
	formObj.find("button[name=btn_inquiry]").click(function(e) { //조회
		doAction("search");
		 return false;
	 });
	formObj.find("button[name=btn_xlsDown]").click(function(e) { //엑셀다운
		doAction("excel");
		 return false;
	 });
}

function setDate(){
	var formObj = $("form[name=statOpen]");
	var now = new Date();
	var year = now.getFullYear();
	var monTo = (now.getMonth()+1)>9?now.getMonth()+1:'0'+(now.getMonth()+1);
	var monFrom = (now.getMonth()+1)>9?now.getMonth()+1:'0'+(now.getMonth()+1);
	var day = now.getDate()>9?now.getDate():'0'+now.getDate();
	var dateTo=year+'-'+monTo+'-'+day;
	var dateFrom=year-1+'-'+monFrom+'-'+day;
	formObj.find("input[name=pubDttmFrom]").val(dateFrom);
	formObj.find("input[name=pubDttmTo]").val(dateTo);

}
function buttonEventAdd(){
	setTabButton();
}

function LoadPage()                
{      
	//message-common_ko_KR.properties 선언 후 사용 or message-common_en_US.properties 선언 후 사용
	var gridTitle = "NO";
		gridTitle +="|"+"<spring:message code='labal.dtNm'/>";		// 보유데이터명
		gridTitle +="|"+"<spring:message code='labal.SRV_CNT'/>";	// 서비스 수
		gridTitle +="|"+"<spring:message code='labal.S_CNT'/>";		// RAW Sheet 수
		gridTitle +="|"+"<spring:message code='labal.C_CNT'/>";		// Chart 수
		gridTitle +="|"+"<spring:message code='labal.M_CNT'/>";		// Map 수
		gridTitle +="|"+"<spring:message code='labal.F_CNT'/>";		// File 수
		gridTitle +="|"+"<spring:message code='labal.L_CNT'/>";		// Link 수
		gridTitle +="|"+"<spring:message code='labal.A_CNT'/>";		// Open API수 
		gridTitle +="|"+"<spring:message code='labal.V_CNT'/>";		// Open API수
		
	
    with(mySheet){
    	                     
    	var cfg = {SearchMode:3,Page:50,VScrollMode:1};                                
        SetConfig(cfg);  
        var headers = [                                             
                    {Text:gridTitle, Align:"Center"}                 
                ];
        var headerInfo = {Sort:0,ColMove:1,ColResize:1,HeaderCheck:0};
        
        InitHeaders(headers, headerInfo); 
      	//문자는 왼쪽정렬
        //숫자는 오른쪽정렬
        //코드값은 가운데정렬        
        var cols = [ 
					 {Type:"Seq",		SaveName:"seq",				Width:30,	Align:"Center",		Edit:false}
					,{Type:"Text",		SaveName:"dtNm",			Width:90,	Align:"Left",		Edit:false}
					,{Type:"AutoSum",		SaveName:"srvCnt",			Width:50,	Align:"Right",		Edit:false}
					,{Type:"AutoSum",		SaveName:"sCnt",			Width:50,	Align:"Right",		Edit:false}
					,{Type:"AutoSum",		SaveName:"cCnt",			Width:50,	Align:"Right",		Edit:false}
					,{Type:"AutoSum",		SaveName:"mCnt",			Width:50,	Align:"Right",		Edit:false}
					,{Type:"AutoSum",		SaveName:"fCnt",			Width:50,	Align:"Right",		Edit:false}
					,{Type:"AutoSum",		SaveName:"lCnt",			Width:50,	Align:"Right",		Edit:false}
					,{Type:"AutoSum",		SaveName:"aCnt",			Width:50,	Align:"Right",		Edit:false}	
					,{Type:"AutoSum",		SaveName:"vCnt",			Width:50,	Align:"Right",		Edit:false}
                   ];       
                                      
        InitColumns(cols);                                                                           
        FitColWidth();                                                         
        SetExtendLastCol(1);   
    }               
    default_sheet(mySheet); 
    mySheet.SetCountPosition(0); 
    mySheet.SetSumValue(0,"dtNm","합계"); 
    mySheet.SetAutoSumPosition("1"); //autoSum 위치 지정 1은 최하단 0은 최상단
} 

/*Sheet 각종 처리*/                  
function doAction(sAction)                                  
{
	var classObj = $("."+tabContentClass); //tab으로 인하여 form이 다건임
	var actObj = setTabForm(classObj); // 0: form data, 1: form 객체
	var formObj = $("form[name=statOpen]");
	var flag = false;  
	var pattern =/[&]/gi;             
	var pattern2 =/[=]/gi;             
	switch(sAction)
	{          
		case "search":      //조회
			        
			fromObj = formObj.find("input[name=pubDttmFrom]");
			toObj = formObj.find("input[name=pubDttmTo]");
			dateValCheck(fromObj,toObj)// from , to 날짜 안맞을 경우 자동셋팅
			
			ajaxBeforeSendAdmin("<c:url value='/admin/ajaxBeforeSendAdmin.do'/>"); //IbSheet 조회전 세션 체크

			//시트 조회
			var param = {PageParam: "ibpage", Param: "onepagerow=50&"+actObj[0]};
			mySheet.DoSearchPaging("<c:url value='/admin/stat/open/getOpenStatDtSheetAll.do'/>", param);   
			
			//차트 조회
			//ajaxCallAdmin("<c:url value='/admin/stat/open/getOpenStatDtChartAll.do'/>",formObj.serialize(),initializeChart);
			
			break;
			
			case "excel":      //엑셀다운 - 이 방법이 아니라 openinfccolview.jsp의 197라인을 참고해서 할수도있음(이방법은 현재 시트에 처리중입니다라고 뜸)
			/* mySheet.Down2Excel({FileName:'excel2',SheetName:'mySheet'});
			break; */
			//var param = {FileName:"Excel"+formObj.find("input[name=pubDttmTo]").val()+".xls",SheetName:"mySheet",Merge:1,SheetDesign:1 };
			mySheet.Down2Excel({FileName:'Excel.xls',SheetName:'mySheet'});
			break;
			
			/* formObj.find("input[name=queryString]").val(formObj.serialize());
			formObj.attr("action","<c:url value='/admin/stat/statOpenXlsdownload.do'/>").submit();        
			break; */
	}           
}   
var rytitNm = "";
var index = 0;

/* function initializeChart(data){    
	var varColor = "Purple";
	myChart.RemoveAll();
	var obj = myChart;
	initChart(obj);//차트 기본색상 셋팅
	rytitNm = "건수";
	//X축 스타일                   
	initXStyleChart(obj,varColor, varColor, "보유데이터");//chartObj, x색, y색, 이름
	// 왼쪽 Y축 스타일
	initYStyleChart(obj,varColor, varColor, "건수");//chartObj, x색, y색, 이름
	// 왼쪽 Y축 스타일2                              
	initYStylechart2(obj,varColor, varColor, "");//chartObj, x색, y색, 이름
	//툴팁 스타일
	initToolTipSet(obj);//chartObj               
	//범례 스타일                               
	initLegend(obj,"center","bottom","horizontal","N");//chartObj, 가로, 세로, 정렬, 플로팅
	//Label 스타일
	initLable(obj);//chartObj                          
	//chart 데이터 추가         
	fnChartAddSeries(data,0,false);	// 차트 생성 및 추가
	
}                 
function fnChartAddSeries(data,ix, slicedYN){
	var formObj = $("form[name=statOpen]");
	//차트 생성 및 추가
	var YcolNm = [];
	var Ycol = [];
	var XcolNm = [];
	var cnt = 0;
	
	//X축 column 이름 셋팅
	$.each(data.chartDataX,function(key,state){
		$.each(state,function(key2,state2){
			XcolNm[0] = key2;
		});
	});
	
	for(var i=0; i < data.seriesResult.length ; i++){    
		var tp = [];
		var name = [];

		//X축 column 이름 넣기 
       	for(var k=0; k < data.chartDataX.length ; k++){
       		name[k] = data.chartDataX[k][XcolNm[0]]
    	}
       	
       /*  //Y축 column 이름 셋팅
       	$.each(data.chartDataY,function(key,state){
    		if(data.seriesResult.length == YcolNm.length) return;
     		$.each(state,function(key2,state2){
     			if(data.seriesResult.length == YcolNm.length) return;
     			if (cnt==0) {
     				YcolNm[cnt++] = key2;
     			} 
     			else {
     				for (var i=0; i < data.seriesResult.length; i++) {
     					if (YcolNm[i] == key2){
     						break;
     					}else{
     						YcolNm[cnt++] = key2;
     					}
     				}
     			}
     		});
     	}); */
       	
      	//Y축 column 이름 셋팅
/*        	$.each(data.chartDataY,function(key,state){
    		if(data.seriesResult.length == YcolNm.length) return;
     		$.each(state,function(key2,state2){
     				YcolNm[cnt++] = key2;
     		});
     	});   
       	
       	//X,Y축 데이터 셋팅
		for(var j=0; j< data.chartDataY.length ; j++){
			var slicedValue = false;
			if (i == 0) slicedValue = false;
			var jsonobj = {X:j, Y:data.chartDataY[j][YcolNm[i]], Name:name[j], Sliced:slicedValue};
			tp.push(jsonobj);
		}
       	
       	//차트에 데이터 삽입 및 생성
		var series = myChart.CreateSeries();  
       	if(YcolNm[i] == "INF_CNT" || YcolNm[i] == "SRV_CNT"){	// 공공데이터 수와 서비스 수는 꺽은선 그래프로 표현
       		series.SetProperty({  Type: IBChartType.LINE_Step });	
       	}else{													// 나머지는 전부 막대그래프로 표현
       		series.SetProperty({  Type: IBChartType.COLUMN });
       	}
		series.AddPoints(tp);
		series.SetName(data.seriesResult[i].columnNm);			
		myChart.AddSeries(series);
		var arr = [];
		for(var z=0; z<tp.length; z++) {
			arr.push( tp[z].Name );
		}
		myChart.SetXAxisLabelsText(0, arr);
		//myChart.YAxisDesignDefault();
		myChart.Draw();
		//index++; 
	}
	
}  */

/* function YAxisDesignDefault() {
	var Yaxis = myChart.GetYAxis(0);
	var axislabels = new AxisLabels();
	axislabels.SetFormatter(AxisLabelsFormatter);
	Yaxis.SetLabels(axislabels);
	if(rytitNm != null){
		var Yaxis1 = myChart.GetYAxis(1);
		var axislabels1 = new AxisLabels();
		axislabels1.SetFormatter(AxisLabelsFormatter);
		Yaxis1.SetLabels(axislabels1);
	}
} */


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
			<!-- 탭 -->
			
			<div class="more_list" style="display:none">
				<a href="#" class="more">0</a>                
				<ul class="other_list" style="display:none;">
					<li><a href="#">보유데이터목록</a><a href="#" class="line_close">x</a></li>
					<li><a href="#">공공데이터목록</a><a href="#" class="line_close">x</a></li>
				</ul>
			</div>
			
			<!-- 목록내용 -->
			<div class="content">
			<form name="statOpen"  method="post" action="#">
			<table class="list01">              
				<caption>회원목록</caption>
				<colgroup>
					<col width="150"/>
					<col width=""/>
				</colgroup>
				<tr>
					<th><label class=""><spring:message code="labal.stdDttm"/></label></th>
					<td colspan="3">
						<input type="text" name="pubDttmFrom" value="" readonly="readonly"/>
						<input type="text" name="pubDttmTo" value="" readonly="readonly"/>
						${sessionScope.button.btn_inquiry}
						${sessionScope.button.btn_xlsDown}       
					</td>
				</tr>
			</table>	
			</form>
				
					
				<!-- ibsheet 영역 -->
				<div class="ibsheet_area">
					<!-- <script type="text/javascript">createIBChart("myChart", "100%", "300px");</script> -->
					
					<script type="text/javascript">createIBSheet("mySheet", "100%", "300px"); </script>             
				</div>
			</div>
			
		</div>
</div>
</body>
</html>