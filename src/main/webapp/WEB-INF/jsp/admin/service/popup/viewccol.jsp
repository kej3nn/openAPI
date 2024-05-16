<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="egovframework.common.WiseOpenConfig"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%pageContext.setAttribute("crlf", "\r\n"); %>    
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
	inputSet();
	doAction("search");
	setButtons();
// 	initializeChart(false);	//차트 초기화

	changeSelect();
});     

function setButtons(){
	$("select[name=seriesCd]").change(function(){		//차트유형 변경시
		changeSelect();
	});
	
	$("select[name=colNm]").change(function(){	//시리즈명 변경시
		changeSeries();
	});
	
// 	$("input[name=chkStacking]").change(function(){		//누적보기
// 		stacking();
// 	});
}

var rytitNm = "";
var lytitNm = "";
var index = 0;

function initializeChart(data) {
	myChart.RemoveAll();      
	var obj = myChart;
	initChart(obj);
	rytitNm = data.srvChart[0].rytitNm;
	lytitNm = data.srvChart[0].lytitNm;
	if(rytitNm == null || data.chartDataRY == null){		// 오른쪽 Y축 이름이 Y-Values로 뜨는 것 방지 || 오른쪽 Y축 설정을 안했을 경우 이름 안나오게..
		rytitNm = "";
	}
	if(lytitNm == null || data.chartDataY == null){		// 왼쪽 Y축 이름이 Y-Values로 뜨는 것 방지 || 왼쪽 Y축 설정을 안했을 경우 이름 안나오게..
		lytitNm = "";
	}
	var append = "";			//차트유형 세팅
	$(".seriesCd").children().remove();
	if(data.srvChart[0].sgrpCd == "BAR"){
		append += "<c:forEach var='code' items='${codeMap.bar}' varStatus='status'>";
		append += "<option value='${code.valueCd}'>${code.ditcNm}</option>";
		append += "</c:forEach>";
	}else if(data.srvChart[0].sgrpCd == "PIE"){
		append += "<c:forEach var='code' items='${codeMap.pie}' varStatus='status'>";
		append += "<option value='${code.valueCd}'>${code.ditcNm}</option>";
		append += "</c:forEach>";
	}
	$(".seriesCd").append(append);       
	
	if(data.chartDataY != null || data.chartDataX != null){			// 데이터가 없을 때 alert창 띄우기
		if(data.chartDataX.length == 0 || data.chartDataY.length == 0) {
// 			alert("<spring:message code='msg.noData'/>");
			alert("해당 데이터가 존재하지 않습니다.");
		}
	}
/*  	initXaxisChart(obj, data.srvChart[0].xlnCd, data.srvChart[0].ylnCd, data.initX);	//X축 스타일
	initYaxisChart(obj, data.srvChart[0].xlnCd, data.srvChart[0].ylnCd, lytitNm);	// 왼쪽 y축 스타일
	initRYaxisChart(obj, data.srvChart[0].xlnCd, data.srvChart[0].ylnCd, rytitNm);	//오른쪽 y축 스타일      
	initToolTipStyle(obj);	//툴팁 스타일  
	initLegendStyle(obj, data.srvChart[0].seriesPosx, data.srvChart[0].seriesPosy, data.srvChart[0].seriesOrd, data.srvChart[0].seriesFyn);	//범례 스타일
	initLableStyle(obj);		//Label 스타일  */
	
	initXStyleChart(obj, data.srvChart[0].xlnCd, data.srvChart[0].ylnCd, data.initX);	//X축 스타일
	initYStyleChart(obj, data.srvChart[0].xlnCd, data.srvChart[0].ylnCd, data.srvChart[0].lytitNm );	// 왼쪽 y축 스타일
	initYStylechart2(obj, data.srvChart[0].xlnCd, data.srvChart[0].ylnCd, rytitNm);	//오른쪽 y축 스타일
	initToolTipSet(obj);	//툴팁 스타일
	initLegend(obj, data.srvChart[0].seriesPosx, data.srvChart[0].seriesPosy, data.srvChart[0].seriesOrd, data.srvChart[0].seriesFyn);	//범례 스타일
	initLable(obj);		//Label 스타일
	
	//차트 생성 및 추가
	var YcolNm = [];
	var XcolNm = [];
	var RYcolNm = [];
	var cnt = 0;
	var cnt2 = 0;
	
// 	alert(data.seriesResultCnt);
// 	if(data.chartDataY != null){  
// 		$.each(data.chartDataY,function(key,state){
// 			if(data.seriesResultCnt == YcolNm.length) return;
// 	 		$.each(state,function(key2,state2){
// 	 			if(data.seriesResultCnt == YcolNm.length) return;
// 	 			if (cnt==0) {
// 	 				alert("1. "+key2);
// 	 				YcolNm[cnt++] = key2;
// 	 			} 
// 	 			else {
// 	 				for (var i=0; i < data.seriesResultCnt; i++) {
// 	 					if (YcolNm[i] == key2){
// 	 						alert();
// 	 						break;
// 	 					}else{
// 	 						alert("2. "+key2);
// 	 						YcolNm[cnt++] = key2;
// 	 					}
// 	 				}
// 	 			}
// 	 		});
// 	 	});
// 	}
	
	if(data.chartDataY != null){  
		$.each(data.chartDataY,function(key,state){
			if(data.seriesResultCnt == YcolNm.length) return;
	 		$.each(state,function(key2,state2){
	 				YcolNm[cnt++] = key2;
	 		});
	 	});
	}
	
 	if(data.chartDataRY != null){  			// 오른쪽Y축이 있을경우..
		$.each(data.chartDataRY,function(key,state){
			if(data.seriesResultCnt2 == RYcolNm.length) return;
	 		$.each(state,function(key2,state2){
	 				RYcolNm[cnt2++] = key2;
	 		});
	 	}); 
 	}
	
	$.each(data.chartDataX,function(key,state){
		$.each(state,function(key2,state2){
			XcolNm[0] = key2;
		});
	});
	<c:forEach var="totSeries" items="${series}" begin="0" end="0">
		$("select[name=seriesCd]").val("${totSeries.valueNm}");   
	</c:forEach>
	if(data.chartDataY != null){   
		for(var i=0; i < data.seriesResultCnt ; i++){
			var tp = [];
			var name = [];
	       	for(var k=0; k < data.chartDataX.length ; k++){
	       		name[k] = data.chartDataX[k][XcolNm[0]];
	    	}   
	       	
			for(var j=0; j< data.chartDataY.length ; j++){ 
				var slicedValue = false;
				if (i == 0) slicedValue = false;
				var jsonobj = {X:j, Y:data.chartDataY[j][YcolNm[i]], Name:name[j], Sliced:slicedValue};
				tp.push(jsonobj);
			}
			
			var series = myChart.CreateSeries();  
			series.SetProperty({  Type: eval(data.seriesResult[i].valueNm) });
			series.AddPoints(tp);
			series.SetName(data.seriesResult[i].colNm);			
			myChart.AddSeries(series);
			
			var arr = [];
			for(var z=0; z<tp.length; z++) {
				arr.push( tp[z].Name );
			}
			
			myChart.SetXAxisLabelsText(0, arr);
			myChart.Draw();
			
			index++;            
		}
	}
	
	//오른쪽 y축 정보....      
	if(data.chartDataRY != null){  		// 오른쪽Y축이 있을경우..
		for(var i=0; i < data.seriesResultCnt2 ; i++){
			var tp = [];
			var name = [];
	       	for(var k=0; k < data.chartDataX.length ; k++){
	       		name[k] = data.chartDataX[k][XcolNm[0]];
	    	}   
			
			for(var j=0; j< data.chartDataRY.length ; j++){
				var slicedValue = false;
				if (i == 0) slicedValue = false;
				var jsonobj = {X:j, Y:data.chartDataRY[j][RYcolNm[i]], Name:name[j], Sliced:slicedValue};
				tp.push(jsonobj);
			}
			
			var series = myChart.CreateSeries();  
			series.SetProperty({  
				Type: eval(data.seriesResult2[i].valueNm)
				, YAxis :1 		// 오른쪽 y축에 값이 나타나게 한다.
			});
			series.AddPoints(tp);
			series.SetName(data.seriesResult2[i].colNm);			
			myChart.AddSeries(series);
			
			var arr = [];
			for(var z=0; z<tp.length; z++) {
				arr.push( tp[z].Name );
			}
			
			myChart.SetXAxisLabelsText(0, arr);
			myChart.Draw();
			
			index ++;
		}
	}
	if(index == 1) {
		$("#stacking").hide();
		$("input[name=seriesIdx]").val("0");	
		$("input[name=colNm]").val("0");
	}
	
// 	alert("index : "+index);
	
	
}

// 차트 유형 변경
function changeSelect(){
	if($("input[name=colNm] option:selected").val() == ""){
		alert("시리즈명을 선택하세요");
		return;
	 }else{
// 		$("input:checkbox[name=chkStacking]").prop("checked", false);
		var type = fnChartType("");
// 		if(type == IBChartType.SCATTER || index == 1){
// 			$("#stacking").hide();
// 		}else{
// 			$("#stacking").show();
// 		}
		var sindex = $("input[name=seriesIdx]").val();
		var list = myChart.GetSeries(sindex);
		list.SetProperty({
			Type:type
		})
		myChart.UpdateSeries(list,sindex);
        myChart.Draw();
        return;
	 }
}

//시리즈명 변경
function changeSeries(){
	 if($("select[name=colNm]").val() != ""){
		var changeSeries = $("select[name=colNm]").val();
		$("input[name=seriesIdx]").val(changeSeries);
		var type = fnChartType("");
		var sindex = $("input[name=seriesIdx]").val();
		var list = myChart.GetSeries(sindex);
		list.SetProperty({
			Type:type
		})
		myChart.UpdateSeries(list,sindex);
        myChart.Draw();
	}
}

//누적보기
function stacking(){
	var list = myChart.GetSeriesList();		//전체 시리즈 리스트를 가져옴	
	var index=0;
	var SeriesType = fnChartType("");
	//누적보기는 시리즈의 타입이 모두 같아야 한다. 그래서 차트유형에 선택된 유형으로 시리즈를 모두 변경한다.
	for(; index<list.length;index++){
		list[index].SetProperty({				
			Type:SeriesType
		});
		myChart.UpdateSeries(list[index],index);		
	}
	myChart.Draw();
}

function fnChartType(type)
{
	var Type = "";
	if(type == ""){
		Type  = val ? val : $("select[name=seriesCd] option:selected").val();
	}else{
		Type = type;
	}
	var val = null;
// 	var chk =  $("input:checkbox[name=chkStacking]").is(":checked");
// 	if(chk) val = IBStacking.NORMAL;	
	
	switch(Type){
		case "IBChartType.BAR":
			var plot = new BarPlotOptions();
			plot.SetStacking(val);
			myChart.SetBarPlotOptions(plot);
			YAxisDesignDefault();
			return IBChartType.BAR;
			break;

		case "IBChartType.BAR_Stacking_Normal":
			var plot = new BarPlotOptions();
			plot.SetStacking(IBStacking.NORMAL);
			myChart.SetBarPlotOptions(plot);
			YAxisDesignDefault();
			return IBChartType.BAR;
			break;

		case "IBChartType.BAR_Stacking":
			var plot = new BarPlotOptions();
			plot.SetStacking(IBStacking.PERCENT);
			myChart.SetBarPlotOptions(plot);
			YAxisDesignStacking();
			return IBChartType.BAR;
			break;

		case "IBChartType.COLUMN":
			var plot = new ColumnPlotOptions();
			plot.SetStacking(val);
			myChart.SetColumnPlotOptions(plot);
			YAxisDesignDefault();
			return IBChartType.COLUMN;
			break;

		case "IBChartType.COLUMN_Stacking_Normal":
			var plot = new ColumnPlotOptions();
			plot.SetStacking(IBStacking.NORMAL);
			myChart.SetColumnPlotOptions(plot);
			YAxisDesignDefault();
			return IBChartType.COLUMN;
			break;

		case "IBChartType.COLUMN_Stacking":
			var plot = new ColumnPlotOptions();
			plot.SetStacking(IBStacking.PERCENT);
			myChart.SetColumnPlotOptions(plot);
			YAxisDesignStacking();
			return IBChartType.COLUMN;
			break;
		
		case "IBChartType.LINE":
			var plot = new LinePlotOptions();
			plot.SetStacking(val);
			plot.SetMarker(true);
			plot.SetStep(false);
			myChart.SetLinePlotOptions(plot);
			return IBChartType.LINE;
			break;

		case "IBChartType.LINE_Stacking_Normal":
			var plot = new LinePlotOptions();
			plot.SetStacking(IBStacking.NORMAL);
			plot.SetMarker(false);
			plot.SetStep(false);
			myChart.SetLinePlotOptions(plot);
			return IBChartType.LINE;
			break;

		case "IBChartType.LINE_Stacking":
			myChart.SetMargin(50);
			
			var plot = new LinePlotOptions();
			plot.SetStacking(IBStacking.PERCENT);
			plot.SetMarker(false);
			plot.SetStep(false);
			myChart.SetLinePlotOptions(plot);
			YAxisDesignStacking();
			return IBChartType.LINE;
			break;

		case "IBChartType.LINE_Marker":
			var plot = new LinePlotOptions();
			plot.SetStacking(null);
			plot.SetMarker(true);
			plot.SetStep(false);
			myChart.SetLinePlotOptions(plot);
			return IBChartType.LINE;
			break;

		case "IBChartType.LINE_Stacking_Normal_Marker":
			var plot = new LinePlotOptions();
			plot.SetStacking(IBStacking.NORMAL);
			plot.SetMarker(true);
			plot.SetStep(false);
			myChart.SetLinePlotOptions(plot);
			return IBChartType.LINE;
			break;

		case "IBChartType.LINE_Stacking_Marker":
			myChart.SetMargin(50);
			
			var plot = new LinePlotOptions();
			plot.SetStacking(IBStacking.PERCENT);
			plot.SetMarker(true);
			plot.SetStep(false);
			myChart.SetLinePlotOptions(plot);
			YAxisDesignStacking();
			return IBChartType.LINE;
			break;
			
		case "IBChartType.LINE_Step":
			var plot = new LinePlotOptions();
			plot.SetStacking(val);
			plot.SetMarker(false);
			plot.SetStep(true);
			myChart.SetLinePlotOptions(plot);
			YAxisDesignDefault();
			return IBChartType.LINE;
			break;

		case "IBChartType.LINE_Step_Marker":
			var plot = new LinePlotOptions();
			plot.SetStacking(null);
			plot.SetMarker(true);
			plot.SetStep(true);
			myChart.SetLinePlotOptions(plot);
			YAxisDesignDefault();
			return IBChartType.LINE;
			break;
			
		case "IBChartType.SPLINE":
			var plot = new SplinePlotOptions();
			plot.SetStacking(val);
			plot.SetMarker(false);
			myChart.SetSplinePlotOptions(plot);
			return IBChartType.SPLINE;
			break;

		case "IBChartType.SPLINE_Marker":
			var plot = new SplinePlotOptions();
			plot.SetStacking(null);
			plot.SetMarker(true);
			myChart.SetSplinePlotOptions(plot);
			return IBChartType.SPLINE;
			break;

		case "IBChartType.SCATTER":
			var plot = new ScatterPlotOptions();
			plot.SetStacking(val);
			plot.SetMarker(true);
			myChart.SetScatterPlotOptions(plot);
			return IBChartType.SCATTER;
			break;
			
		case "IBChartType.AREA":
			var plot = new AreaPlotOptions();
			plot.SetStacking(val);
			plot.SetMarker(false);
			myChart.SetAreaPlotOptions(plot);
			YAxisDesignDefault();
			return IBChartType.AREA;
			break;

		case "IBChartType.AREA_Stacking_Normal":
			var plot = new AreaPlotOptions();
			plot.SetStacking(IBStacking.NORMAL);
			plot.SetMarker(false);
			myChart.SetAreaPlotOptions(plot);
			YAxisDesignDefault();
			return IBChartType.AREA;
			break;

		case "IBChartType.AREA_Stacking":
			myChart.SetMargin(50);
			
			var plot = new AreaPlotOptions();
			plot.SetStacking(IBStacking.PERCENT);
			plot.SetMarker(false);
			myChart.SetAreaPlotOptions(plot);
			YAxisDesignStacking();
			return IBChartType.AREA;
			break;

		case "IBChartType.AREA_SPLINE":
			var plot = new AreaSplinePlotOptions();
			plot.SetStacking(val);
			plot.SetMarker(false);
			myChart.SetAreaSplinePlotOptions(plot);
			YAxisDesignDefault();
			return IBChartType.AREA_SPLINE;
			break;
		
		case "IBChartType.PIE":
			var plot = new PiePlotOptions();
			plot.SetAllowPointSelect(true);
			plot.SetSlicedOffset(20);
			plot.SetInnerSize(0);
			
			var style = new Style();
			style.SetFontSize("12px");
			plot.SetShowInLegend(true);
			myChart.SetPiePlotOptions(plot);
			return IBChartType.PIE;
			break;

		case "IBChartType.PIE_Sliced":
			var plot = new PiePlotOptions();
			plot.SetAllowPointSelect(true);
			plot.SetSlicedOffset(20);
			plot.SetInnerSize(0);
			
			var style = new Style();
			style.SetFontSize("12px");
			plot.SetShowInLegend(true);
			myChart.SetPiePlotOptions(plot);
			return IBChartType.PIE;
			break;

		case "IBChartType.PIE_InnerSize":
			var plot = new PiePlotOptions();
			plot.SetAllowPointSelect(true);
			plot.SetSlicedOffset(20);
			plot.SetInnerSize(100);
			
			var style = new Style();
			style.SetFontSize("12px");
			plot.SetShowInLegend(true);
			myChart.SetPiePlotOptions(plot);
			return IBChartType.PIE;
			break;

		case "IBChartType.PIE_Sliced_InnerSize":
			var plot = new PiePlotOptions();
			plot.SetAllowPointSelect(true);
			plot.SetSlicedOffset(20);
			plot.SetInnerSize(100);
			
			var style = new Style();
			style.SetFontSize("12px");
			plot.SetShowInLegend(true);
			myChart.SetPiePlotOptions(plot);
			return IBChartType.PIE;
			break;
	}
}

function YAxisDesignDefault() {
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
}

function YAxisDesignStacking() {
	var Yaxis = myChart.GetYAxis(0);
	Yaxis.SetMax(100);
	var axislabels = new AxisLabels();
	axislabels.SetFormatter(PercentAxisLabelsFormatter);
	Yaxis.SetLabels(axislabels);
	if(rytitNm != null){
		var Yaxis1 = myChart.GetYAxis(1);
		Yaxis1.SetMax(100);
		var axislabels1 = new AxisLabels();
		axislabels1.SetFormatter(PercentAxisLabelsFormatter);
		Yaxis1.SetLabels(axislabels1);
	}
}

function doAction(sAction)                                  
{
	var formObj = $("form[name=OpenInfCColView]");       
	var flag = false;  
	
	var pattern =/[&]/gi;             
	var pattern2 =/[=]/gi;             
	var formData = formObj.serialize().replace(pattern,"~!@");     
	formData = formData.replace(pattern2,"@!~");   
	switch(sAction)                                              
	{      
		case "search":      //조회   
			//날짜 체크(max)
			//from to 체크       
			formObj.find("input[name=filtMaxDay]").each(function(index,item){              
				var fromObj = $(this).parent().find("input").eq(0);
				var toObj = $(this).parent().find("input").eq(1);
				var fromDt = fromObj.val(); //from
				var toDt =  toObj.val(); //to
				var pattern =/[^(0-9)]/gi;
				var fromReplace = fromDt.replace(pattern,"");                 
				var toReplace=toDt.replace(pattern,"");
				
				if(!(fromDt =="" && toDt == "")){//값이 있으면
					if(fromDt != "" && toDt == ""){
					 alert($(this).parent().prev().html()+" <spring:message code='msg.view1'/>");    
						toObj.val(fromDt); //to 값 넣음
						toReplace = fromReplace;
					}
					if(toDt != "" && fromDt == ""){
						alert($(this).parent().prev().html()+" <spring:message code='msg.view2'/>");    
						fromObj.val(toDt); //from 값 넣음
						fromReplace = toReplace;
					}
					if(toReplace < fromReplace ){              
						alert($(this).parent().prev().html()+" <spring:message code='msg.view3'/>");    
						toObj.val(fromDt); //from 값 넣음    
						toReplace = fromReplace;                                         
					}                                            
					var day =  getDateDiffVal(fromReplace,toReplace);    
					if(day >= $(this).val()){                
						alert($(this).parent().prev().html()+" <spring:message code='msg.view4'/>");    
						fromObj.focus();       
						flag =true;
						return;     
					}
				}               
			});   
			if(flag){
				return;
			}
			//check박스 필수 체크
			formObj.find("input[name=checkFiltNeed]").each(function(index,item){              
				if($(this).val() == "Y"){
					var checkObj = $(this).parent().find("input").eq(0);                 
					if(nullCheckValdation(checkObj,$(this).parent().prev().html().replace(" <span>*</span>",""),"")){
						flag =true;
						return;
					}
				}
			});
			if(flag){
				return;
			}
			//radio박스 필수 체크
			formObj.find("input[name=radioFiltNeed]").each(function(index,item){              
				if($(this).val() == "Y"){
					var checkObj = $(this).parent().find("input").eq(0);
					if(nullCheckValdation(checkObj,$(this).parent().prev().html().replace(" <span>*</span>",""),"")){
						flag =true;
						return;
					}
				}
			});
			if(flag){
				return;
			}
			formObj.find("input[name=comboFiltNeed]").each(function(index,item){              
				if($(this).val() == "Y"){
					var checkObj = $(this).parent().find("select").eq(0);
					if(nullCheckValdation(checkObj,$(this).parent().prev().html().replace(" <span>*</span>",""),"")){
						flag =true;
						return;
					}
				}
			});
			//팝업 
			if(flag){
				return;
			}
			formObj.find("input[name=popFiltNeed]").each(function(index,item){              
				if($(this).val() == "Y"){
					var checkObj = $(this).parent().find("input").eq(0);
					if(nullCheckValdation(checkObj,$(this).parent().prev().html().replace(" <span>*</span>",""),"")){
						flag =true;
						return;
					}
				}
			})
			//워드
			if(flag){
				return;
			}
			formObj.find("input[name=wordsFiltNeed]").each(function(index,item){              
				if($(this).val() == "Y"){
					var checkObj = $(this).parent().find("input").eq(0);
					if(nullCheckValdation(checkObj,$(this).parent().prev().html().replace(" <span>*</span>",""),"")){
						flag =true;
						return;
					}
				}
			});
			if(flag){         
				return;                 
			} 
			var param = $("form[name=OpenInfCColView]").serialize();
					param += "&queryString="+formData;
			ajaxCall("<c:url value='/admin/service/searchChartData.do'/>", param, initializeChart);
			break;   
		case "lang":            
			formObj.attr("action","<c:url value='/admin/service/openInfColViewPopUp.do'/>").submit();
			break;
		case "down":                       
				formObj.attr("action","<c:url value='/admin/service/download.do?"+"&queryString="+formData+"'/>").submit();        
			break;                           
	}                                                                                                                 
}  

function inputSet(){
	<c:forEach var="cond" items="${cond}" varStatus="status">
	switch("${cond.filtCd}")                                 
	{                                                
		case "FDATE":                          
			$("input[name=${cond.srcColId}]").datepicker(setCalendarView('yy-mm-dd'));                                                           
			break;
		case "LDATE":   
			$("input[name=${cond.srcColId}]").datepicker(setCalendarView('yy/mm/dd'));            
			break;
		case "PDATE": 
			$("input[name=${cond.srcColId}]").datepicker(setCalendarView('yy.mm.dd'));            
			break;          
		case "SDATE":   
			$("input[name=${cond.srcColId}]").datepicker(setCalendarView('yymmdd'));                            
			break;     
		case "CDATE":   
			$("input[name=${cond.srcColId}]").datepicker(setCalendarView('yymmdd'));                            
			break;  
	}
	</c:forEach>
	
	$(".list01 td").last().append("${sessionScope.button.btn_reSearch}");
	var formObj = $("form[name=OpenInfCColView]");                  
	formObj.find("button[name=btn_reSearch]").click(function(e) {               
		doAction('search');            
		return false;                                    
	});
	
	$("a[name=a_close]").click(function(e) { 
		window.close();
		 return false;                             
	 }); 
	
	$("#a_kr").click(function(e) { 
		formObj.find("input[name=viewLang]").val("");
		doAction("lang");
		 return false;                             
	 }); 
	$("#a_en").click(function(e) { 
		formObj.find("input[name=viewLang]").val("E");
		doAction("lang");
		 return false;                             
	 });      
	 
	var btn09 =  formObj.find(".btn09");
	btn09.each(function(index,item){  
		$(item).click(function(e) {    
			popupObj =$(item).prev().prev();             
			// 하드코딩(연결검색)
			var srcCol = popupObj.attr("name");
			var fsclYy = formObj.find("select[name=FSCL_YY]").val();
			if(formObj.find("input[name=fsYn]").val() =="Y"){
				switch(srcCol)                  
				{                                           
					case "OFFC_CD":      //중앙관서코드 
						if(fsclYy == "undefined" || fsclYy == undefined || fsclYy == ""){//회계년도 필수
							alert(fsclNm+"<spring:message code='msg.connSelect'/>");    
							return;
						}
						break;   
					case "FSCL_CD":      //회계코드
						if(fsclYy == "undefined" || fsclYy == undefined || fsclYy == ""){//회계년도 필수
							alert(fsclNm+"<spring:message code='msg.connSelect'/>");      
							return;
						}
						var offcCd = formObj.find("[name=OFFC_CD]").val();
						var offcNm =  formObj.find("[name=OFFC_CD]").parent().parent().find("th").text(); 
						if(offcCd == "undefined" || offcCd == undefined || offcCd == ""){//중앙관서코드 필수
							alert(offcNm+"<spring:message code='msg.connSelect'/>");           
							return;
						}
						break; 
					case "FSCL2_CD":      //회계코드
						if(fsclYy == "undefined" || fsclYy == undefined || fsclYy == ""){//회계년도 필수
							alert(fsclNm+"<spring:message code='msg.connSelect'/>");      
							return;
						}
						break; 
					case "ACCT_CD":      //계정코드
						if(fsclYy == "undefined" || fsclYy == undefined || fsclYy == ""){//회계년도 필수
							alert(fsclNm+"<spring:message code='msg.connSelect'/>");       
							return;
						}
						var fsclCd = formObj.find("[name=FSCL_CD]").val()
						var fsclCdNm =  formObj.find("[name=FSCL_CD]").parent().parent().find("th").text(); 
						if(fsclCd == "undefined" || fsclCd == undefined || fsclCd == ""){//회계코드 필수
							alert(fsclCdNm+"<spring:message code='msg.connSelect'/>");           
							return;
						}
						break; 
					case "FGO_CD":      //관서구분코드
						if(fsclYy == "undefined" || fsclYy == undefined || fsclYy == ""){//회계년도필수(데이터셋에 일선관서코드참조)
							alert(fsclNm+"<spring:message code='msg.connSelect'/>");  
							return;
						}
						var offcCd = formObj.find("[name=OFFC_CD]").val();
						var offcNm =  formObj.find("[name=OFFC_CD]").parent().parent().find("th").text(); 
						if(offcCd == "undefined" || offcCd == undefined || offcCd == ""){//중앙관서코드 필수
							alert(offcNm+"<spring:message code='msg.connSelect'/>");             
							return;
						}
						var fsclCd = formObj.find("[name=FSCL_CD]").val();
						var fsclCdNm =  formObj.find("[name=FSCL_CD]").parent().parent().find("th").text(); 
						if(fsclCd == "undefined" || fsclCd == undefined || fsclCd == ""){//회계코드 필수
							alert(fsclCdNm+"<spring:message code='msg.connSelect'/>");    
							return;
						}
						
						var acctCd = formObj.find("[name=ACCT_CD]").val();
						var acctNm =  formObj.find("[name=ACCT_CD]").parent().parent().find("th").text(); 
						if(acctCd == "undefined" || acctCd == undefined || acctCd == ""){//계정코드 필수
							alert(acctNm+"<spring:message code='msg.connSelect'/>");              
							return;           
						}
						break; 
						
					case "FLD_CD":      //분야코드
						if(fsclYy == "undefined" || fsclYy == undefined || fsclYy == ""){//회계년도 필수
							alert(fsclNm+"<spring:message code='msg.connSelect'/>");  
							return;
						}
						break; 
					case "SECT_CD":      //부문코드
						if(fsclYy == "undefined" || fsclYy == undefined || fsclYy == ""){//회계년도 필수
							alert(fsclNm+"<spring:message code='msg.connSelect'/>");  
							return;
						}
						var fldCd = formObj.find("[name=FLD_CD]").val();
						var fldNm =  formObj.find("[name=FLD_CD]").parent().parent().find("th").text(); 
						if(fldCd == "undefined" || fldCd == undefined || fldCd == ""){//분야코드 필수
							alert(fldNm+"<spring:message code='msg.connSelect'/>");         
							return;
						}
						break; 
					case "PGM_CD":      //프로그램코드
						if(fsclYy == "undefined" || fsclYy == undefined || fsclYy == ""){//회계년도 필수
							alert(fsclNm+"<spring:message code='msg.connSelect'/>");     
							return;
						}
						var fldCd = formObj.find("[name=FLD_CD]").val()
						var fldNm =  formObj.find("[name=FLD_CD]").parent().parent().find("th").text(); 
						if(fldCd == "undefined" || fldCd == undefined || fldCd == ""){//분야코드 필수
							alert(fldNm+"<spring:message code='msg.connSelect'/>");              
							return;
						}
						var sectCd = formObj.find("[name=SECT_CD]").val();
						var sectNm =  formObj.find("[name=SECT_CD]").parent().parent().find("th").text(); 
						if(sectCd == "undefined" || sectCd == undefined || sectCd == ""){//부문코드필수
							alert(sectNm+"<spring:message code='msg.connSelect'/>");              
							return;
						}
						break; 
					case "ACTV_CD":      //단위사업코드 
						if(fsclYy == "undefined" || fsclYy == undefined || fsclYy == ""){//회계년도 필수
							alert(fsclNm+"<spring:message code='msg.connSelect'/>");    
							return;
						}
						var fldCd = formObj.find("[name=FLD_CD]").val();
						var fldNm =  formObj.find("[name=FLD_CD]").parent().parent().find("th").text(); 
						if(fldCd == "undefined" || fldCd == undefined || fldCd == ""){//분야코드 필수
							alert(fldNm+"<spring:message code='msg.connSelect'/>");           
							return;
						}
						var sectCd = formObj.find("[name=SECT_CD]").val();
						var sectNm =  formObj.find("[name=SECT_CD]").parent().parent().find("th").text(); 
						if(sectCd == "undefined" || sectCd == undefined || sectCd == ""){//부문코드필수
							alert(sectNm+"<spring:message code='msg.connSelect'/>");              
							return;
						}
						var pgmCd = formObj.find("[name=PGM_CD]").val();
						var pgmNm =  formObj.find("[name=PGM_CD]").parent().parent().find("th").text(); 
						if(pgmCd == "undefined" || pgmCd == undefined || pgmCd == ""){//프로그램코드필수
							alert(pgmNm+"<spring:message code='msg.connSelect'/>");              
							return;
						}
						break; 
					case "IKWAN_CD":      //수입관 
						if(fsclYy == "undefined" || fsclYy == undefined || fsclYy == ""){//회계년도 필수
							alert(fsclNm+"<spring:message code='msg.connSelect'/>");      
							return;
						}
						break; 
					case "IHANG_CD":      //수입항
						if(fsclYy == "undefined" || fsclYy == undefined || fsclYy == ""){//회계년도 필수
							alert(fsclNm+"<spring:message code='msg.connSelect'/>");    
							return;
						}
					
						var ikwanCd = formObj.find("[name=IKWAN_CD]").val();
						var ikwanNm =  formObj.find("[name=IKWAN_CD]").parent().parent().find("th").text(); 
						if(ikwanCd == "undefined" || ikwanCd == undefined || ikwanCd == ""){//수입관 
							alert(ikwanNm+"<spring:message code='msg.connSelect'/>");       
							return;
						}
						break;
					case "IMOK_CD":      //수입목
						if(fsclYy == "undefined" || fsclYy == undefined || fsclYy == ""){//회계년도 필수
							alert(fsclNm+"<spring:message code='msg.connSelect'/>");    
							return;
						}
					
						var ikwanCd = formObj.find("[name=IKWAN_CD]").val();
						var ikwanNm =  formObj.find("[name=IKWAN_CD]").parent().parent().find("th").text(); 
						if(ikwanCd == "undefined" || ikwanCd == undefined || ikwanCd == ""){//수입관 
							alert(ikwanNm+"<spring:message code='msg.connSelect'/>");          
							return;
						}
						var ihangCd = formObj.find("[name=IHANG_CD]").val();
						var ihangNm =  formObj.find("[name=IHANG_CD]").parent().parent().find("th").text(); 
						if(ihangCd == "undefined" || ihangCd == undefined || ihangCd == ""){//수입항
							alert(ihangNm+"<spring:message code='msg.connSelect'/>");             
							return;
						}
						break;
					case "CITM_CD":      //지출목
						if(fsclYy == "undefined" || fsclYy == undefined || fsclYy == ""){//회계년도 필수
							alert(fsclNm+"<spring:message code='msg.connSelect'/>");        
							return;
						}
						break; 
					case "EITM_CD":      //지출세목
						if(fsclYy == "undefined" || fsclYy == undefined || fsclYy == ""){//회계년도 필수
							alert(fsclNm+"<spring:message code='msg.connSelect'/>");    
							return;
						}
						var citmCd = formObj.find("[name=CITM_CD]").val();
						var citmNm =  formObj.find("[name=CITM_CD]").parent().parent().find("th").text(); 
						if(citmCd == "undefined" || citmCd == undefined || citmCd == ""){//지출목
							alert(citmNm+"<spring:message code='msg.connSelect'/>");           
							return;
						}
						break;
					case "FSCL_YM":      //회계년월
						if(fsclYy == "undefined" || fsclYy == undefined || fsclYy == ""){//회계년도 필수
							alert(fsclNm+"<spring:message code='msg.connSelect'/>");    
							return;
						}
						break;
					case "ORG_CD":      //직제코드
						if(fsclYy == "undefined" || fsclYy == undefined || fsclYy == ""){//회계년도 필수
							alert(fsclNm+"<spring:message code='msg.connSelect'/>");         
							return;
						}
						break;
					case "MPB_FSCL_CD":      //예산편성회계코드
						if(fsclYy == "undefined" || fsclYy == undefined || fsclYy == ""){//회계년도 필수
							alert(fsclNm+"<spring:message code='msg.connSelect'/>");    
							return;
						}
						var orgCd = formObj.find("[name=ORG_CD]").val();
						var orgNm =  formObj.find("[name=ORG_CD]").parent().parent().find("th").text(); 
						if(orgCd == "undefined" || orgCd == undefined || orgCd == ""){//직제코드 필수
							alert(orgNm+"<spring:message code='msg.connSelect'/>");           
							return;
						}
						break;
					case "MPB_ACCT_CD":      //예산편성계정코드
						if(fsclYy == "undefined" || fsclYy == undefined || fsclYy == ""){//회계년도 필수
							alert(fsclNm+"<spring:message code='msg.connSelect'/>");    
							return;
						}
						var orgCd = formObj.find("[name=ORG_CD]").val();
						var orgNm =  formObj.find("[name=ORG_CD]").parent().parent().find("th").text(); 
						if(orgCd == "undefined" || orgCd == undefined || orgCd == ""){//직제코드 필수
							alert(orgNm+"<spring:message code='msg.connSelect'/>");    
							return;
						}
						var mpbFsclCd = formObj.find("[name=MPB_FSCL_CD]").val();
						var mpbFsclNm =  formObj.find("[name=MPB_FSCL_CD]").parent().parent().find("th").text(); 
						if(mpbFsclCd == "undefined" || mpbFsclCd == undefined || mpbFsclCd == ""){//예산편성회계코드 필수
							alert(mpbFsclNm+"<spring:message code='msg.connSelect'/>");             
							return;
						}
						break;
				}
			}
			
			               
			formObj.find("input[name=tblId]").val($(item).prev().val());
			formObj.find("input[name=popColId]").val(srcCol);
			
			var sb="";
			sb +="<colgroup>";                      
			sb +="<col width='50'/>";                   
			sb +="<col width='220'/>";      
			sb +="<col width='220'/>";                         
			sb +="</colgroup>";                
			sb +="<tr>";
			sb+="<th class='ac'>선택</th>";
			sb+="<th>CODE</th>";      
			sb+="<th>CODE VAL</th>";      
			sb+="</tr>";              
			formObj.find(".popup table").empty().append(sb);  
			
			var position = $(item).position();    
				formObj                             
					.find(".popup")
					.css("top",position.top)                       
					.css("left",position.left)
					.hide()
					.show();      
				 formObj.find("input[name=popupSerarch]").focus().val("");  
				 formObj.find(".btn01").click();            
				return false;                 
			});                                                          
	});
	 
	 formObj.find("[name=popBtn10]").each(function(index,item){  
			$(item).click(function(e) {    
				$(item).prev().prev().prev().val("");              
				$(item).prev().prev().prev().prev().val("");         
				initInputPopup($(item).prev().prev().prev().attr("name"));
			});                                                          
		})
		
		
	formObj.find("[name=dateBtn10]").each(function(index,item){  
		$(item).click(function(e) {    
			$(item).parent().find("input").eq(0).val("");              
			$(item).parent().find("input").eq(1).val("");              
		});                                                                         
	})
	
	 formObj.find(".popup_close").click(function(e) {    
			formObj.find(".popup").hide();           
			return false;                 
		});
	 
	 formObj.find(".btn01").click(function(e) {    
		/*  if(formObj.find("input[name=popupSerarch]").val() ==""){
			 alert("<spring:message code='labal.searchKeyWord'/>");            
			 return false;
		 }    */                                 
		 goPagePop("1");               
			return false;                      
		}); 
	 
	 formObj.find("input[name=popupSerarch]").keypress(function(e) {     
		  if(e.which == 13) {
			  formObj.find(".btn01").click();              
			  return false;    
		  }
	});
	 
}

function goPagePop(page) {
	var formObj = $("form[name=OpenInfCColView]");       
	var url ="<c:url value='/portal/service/selectChartTvPopupCode.do'/>";                    
	var param= "tblId="+formObj.find("input[name=tblId]").val();
	param+= "&popColId="+ formObj.find("input[name=popColId]").val();       
	param+= "&popupSerach="+ formObj.find("input[name=popupSerarch]").val();       
	param+= "&pageSize="+ "<%=WiseOpenConfig.PAGE_SIZE %>" 
	param+= "&currPage="+page;
	
	//조회조건
	param+= "&fsclYy="+ formObj.find("[name=FSCL_YY]").val();       
	param+= "&fsclCd="+ formObj.find("[name=FSCL_CD]").val();       
	param+= "&fscl2Cd="+ formObj.find("[name=FSCL2_CD]").val();       
	param+= "&fldCd="+ formObj.find("[name=FLD_CD]").val();       
	param+= "&sectCd="+ formObj.find("[name=SECT_CD]").val();       
	param+= "&pgmCd="+ formObj.find("[name=PGM_CD]").val();       
	param+= "&gofDivCd="+ formObj.find("[name=gofDivCd]").val();     
	param+= "&offcCd="+ formObj.find("[name=OFFC_CD]").val();      
	param+= "&acctCd="+ formObj.find("[name=ACCT_CD]").val(); 
	param+= "&fsYn="+ formObj.find("input[name=fsYn]").val();
	
	param+= "&ikwanCd="+ formObj.find("[name=IKWAN_CD]").val();       
	param+= "&ihangCd="+ formObj.find("[name=IHANG_CD]").val();       
	param+= "&citmCd="+ formObj.find("[name=CITM_CD]").val();      
	
	param+= "&orgCd="+ formObj.find("[name=ORG_CD]").val(); 
	param+= "&mpbFsclCd="+ formObj.find("[name=MPB_FSCL_CD]").val(); 
	ajaxCall(url,param,tbPopupCodeCallBack);                    
}

function tbPopupCodeCallBack(json){
	var formObj = $("form[name=OpenInfCColView]");    
	var sb="";
	sb +="<colgroup>";                      
	sb +="<col width='50'/>";
	sb +="<col width='120'/>";      
	sb +="<col width='320'/>";                         
	sb +="</colgroup>";                
	sb +="<tr>";
	sb +="<th class='ac'><spring:message code='etc.select'/></th>";                 
	sb +="<th><spring:message code='labal.code'/></th>";
	sb +="<th><spring:message code='labal.codeNm'/></th>";                
	sb+="</tr>";     
	if(json.list.length> 0){
		for(var i =0; i <json.list.length; i++){         
			sb+="<tr class='tr-bg' onclick=\"javascript:setPopupData('"+json.list[i].COL_ID+"','"+json.list[i].COL_NM+"')\">";     
			sb+="<td class='ac'><input type='radio' onclick=\"javascript:setPopupData('"+json.list[i].COL_ID+"','"+json.list[i].COL_NM+"')\"/></td>";     
			sb+="<td>"+json.list[i].COL_ID+"</td>";
			sb+="<td>"+json.list[i].COL_NM+"</td>";                           
			sb+="</tr>";                  
		}
		formObj.find(".paging").empty().append(json.paging);	
	}else{                       
		sb+="<tr><td colspan='3'><spring:message code='msg.notExitsData'/></td></tr>";
	}
	                
	formObj.find(".popup table").empty().append(sb);     
	formObj.find(".list-search p strong").html(json.totCnt);	
	      
}

var popupObj;
function setPopupData(value,valueNm){
	popupObj.val(value);
	popupObj.prev().val(valueNm);           
	var formObj = $("form[name=OpenInfCColView]");               
	formObj.find(".popup").hide();             
	if(formObj.find("input[name=fsYn]").val() =="Y"){
		initInputPopup(popupObj.attr("name"))
	} 
}

function initFsclYy(){
	var formObj = $("form[name=OpenInfCColView]");               
	if(formObj.find("input[name=fsYn]").val() =="Y"){
		formObj.find("[name=OFFC_CD]").val("");       
		formObj.find("[name=FSCL_CD]").val("");       
		formObj.find("[name=ACCT_CD]").val("");       
		formObj.find("[name=FGO_CD]").val("");       
		formObj.find("[name=FLD_CD]").val("");       
		formObj.find("[name=SECT_CD]").val("");       
		formObj.find("[name=PGM_CD]").val("");       
		formObj.find("[name=ACTV_CD]").val("");       
		formObj.find("[name=IKWAN_CD]").val("");       
		formObj.find("[name=IHANG_CD]").val("");       
		formObj.find("[name=IMOK_CD]").val("");       
		formObj.find("[name=CITM_CD]").val("");  
		formObj.find("[name=EITM_CD]").val(""); 
		formObj.find("[name=FSCL_YM]").val(""); 
		formObj.find("[name=ORG_CD]").val(""); 
		formObj.find("[name=MPB_FSCL_CD]").val(""); 
		formObj.find("[name=MPB_ACCT_CD]").val(""); 
		formObj.find("[name=OFFC_CDNm]").val("");       
		formObj.find("[name=FSCL_CDNm]").val("");       
		formObj.find("[name=ACCT_CDNm]").val("");       
		formObj.find("[name=FGO_CDNm]").val("");       
		formObj.find("[name=FLD_CDNm]").val("");       
		formObj.find("[name=SECT_CDNm]").val("");       
		formObj.find("[name=PGM_CDNm]").val("");       
		formObj.find("[name=ACTV_CDNm]").val("");       
		formObj.find("[name=IKWAN_CDNm]").val("");       
		formObj.find("[name=IHANG_CDNm]").val("");       
		formObj.find("[name=IMOK_CDNm]").val("");       
		formObj.find("[name=CITM_CDNm]").val("");  
		formObj.find("[name=EITM_CDNm]").val(""); 
		formObj.find("[name=FSCL_YMNm]").val(""); 
		formObj.find("[name=ORG_CDNm]").val(""); 
		formObj.find("[name=MPB_FSCL_CDNm]").val(""); 
		formObj.find("[name=MPB_ACCT_CDNm]").val(""); 
		
	}
}

function initInputPopup(colNm){
	var formObj = $("form[name=OpenInfCColView]");         
	switch(colNm)                    
	{                        
		case "OFFC_CD":      //중앙관서코드 
			formObj.find("[name=FSCL_CD]").val(""); 
			formObj.find("[name=FSCL_CDNm]").val(""); 
			formObj.find("[name=ACCT_CD]").val(""); 
			formObj.find("[name=ACCT_CDNm]").val(""); 
			formObj.find("[name=FGO_CD]").val(""); 
			formObj.find("[name=FGO_CDNm]").val(""); 
			break; 
		case "FSCL_CD":      //회계코드
			formObj.find("[name=ACCT_CD]").val(""); 
			formObj.find("[name=ACCT_CDNm]").val(""); 
			formObj.find("[name=FGO_CD]").val(""); 
			formObj.find("[name=FGO_CDNm]").val(""); 
			break; 
		case "ACCT_CD":      //계정코드
			formObj.find("[name=FGO_CD]").val(""); 
			formObj.find("[name=FGO_CDNm]").val(""); 
			break; 
		case "FLD_CD":      //분야코드
			formObj.find("[name=SECT_CD]").val(""); 
			formObj.find("[name=SECT_CDNm]").val(""); 
			formObj.find("[name=PGM_CD]").val(""); 
			formObj.find("[name=PGM_CDNm]").val(""); 
			formObj.find("[name=ACTV_CD]").val(""); 
			formObj.find("[name=ACTV_CDNm]").val(""); 
			break; 
		case "SECT_CD":      //부문코드
			formObj.find("[name=PGM_CD]").val(""); 
			formObj.find("[name=PGM_CDNm]").val(""); 
			formObj.find("[name=ACTV_CD]").val(""); 
			formObj.find("[name=ACTV_CDNm]").val(""); 
			break; 
		case "PGM_CD":      //프로그램코드
			formObj.find("[name=ACTV_CD]").val(""); 
			formObj.find("[name=ACTV_CDNm]").val(""); 
			break; 
		case "IKWAN_CD":      //수입관 
			formObj.find("[name=IHANG_CD]").val(""); 
			formObj.find("[name=IHANG_CDNm]").val(""); 
			formObj.find("[name=IMOK_CD]").val(""); 
			formObj.find("[name=IMOK_CDNm]").val(""); 
			break; 
		case "IHANG_CD":      //수입항
			formObj.find("[name=IMOK_CD]").val(""); 
			formObj.find("[name=IMOK_CDNm]").val(""); 
			break;
		case "CITM_CD":      //지출목
			formObj.find("[name=EITM_CD]").val(""); 
			formObj.find("[name=EITM_CDNm]").val(""); 
			break; 
		case "ORG_CD":      //직제코드
			formObj.find("[name=MPB_FSCL_CD]").val(""); 
			formObj.find("[name=MPB_FSCL_CDNm]").val("");                    
			formObj.find("[name=MPB_ACCT_CD]").val(""); 
			formObj.find("[name=MPB_ACCT_CDNm]").val(""); 
			break;
		case "MPB_FSCL_CD":      //예산편성회계코드
			formObj.find("[name=MPB_ACCT_CD]").val(""); 
			formObj.find("[name=MPB_ACCT_CDNm]").val(""); 
			break;
	}
}
//]]> 
</script>              
</head>
<body onload="">
<div class="wrap-popup">
		<!-- 내용 -->
		<div class="container">
			<!-- 상단 타이틀 -->
			<div class="title">
				<c:choose>
					<c:when test="${viewLang eq 'E'}">
						<h2>VIEW - Chart</h2>
					</c:when>
					<c:otherwise>         
						<h2>미리보기 - Chart</h2>
					</c:otherwise>
				</c:choose>
			</div>
			<!-- 탭 -->
			<ul class="tab-popup">
 			<%-- 	<c:choose>
					<c:when test="${viewLang eq 'E'}">
						<li class="first"><a href="#" id="a_kr">KOR VIEW</a></li>
						<li class="on"><a href="#" id="a_en">ENG VIEW</a></li>
					</c:when>
					<c:otherwise>         
						<li class="first on"><a href="#" id="a_kr">한글보기</a></li>
						<li><a href="#" id="a_en">영문보기</a></li>
					</c:otherwise>
				</c:choose> --%>
			</ul>
			
			<!-- 탭 내용 -->                 
			<div class="content-popup">
				<form name="OpenInfCColView"  method="post" action="#">             
						<input type="hidden" name="fileDownType" value=""/> 
						<input type="hidden" name="infId" value="${openInfSrv.infId}"/>
						<input type="hidden" name="srvCd" value="${openInfSrv.srvCd}"/>
						<input type="hidden" name="viewLang" value=""/> 
						<input type="hidden" name="seriesIdx" value=0 />
						<input type="hidden" name="tblId">          
						<input type="hidden" name="popColId">   
						<%-- <input type="hidden" name="fsYn" value="${fsObj.fsYn}"/>                  
						<input type="hidden" name="gofDivCd" value="${fsObj.fsCd}"/> --%>                 
					<div class="popup"style="display:none;width:500px;position:absolute;z-index:20;padding-bottom:20px;">        
					<h3 class="infNm">검색</h3>               
					<a href="#" class="popup_close">X</a>                                   
					<div style="padding:25px 15px 10px 15px;">
						<div class="list-search" style="margin-bottom:3px;">
							<p><strong>Total: 0</strong></p>             
							<div>
								<input type="text" name="popupSerarch"/>
								<button type="button" class="btn01"><spring:message code='btn.inquiry'/></button>
							</div>
						</div>         
						<table class="list02 op">
							<colgroup>
								<col width="50"/>
								<col width="220"/>
								<col width="220"/>
							</colgroup>                
							<tr>
								<th class="ac"><spring:message code='etc.select'/></th>                 
								<th><spring:message code='labal.code'/></th>
								<th><spring:message code='labal.codeNm'/></th>
							</tr>       
						</table>
						
					</div>
					
					<ul class="paging">
					</ul>
				</div>  
						<table class="list01" style="position:relative;">
						<caption>공공데이터목록리스트</caption>
						<colgroup>
							<col width="120"/>
							<col width=""/>             
							<col width="120"/>
							<col width=""/>             
						</colgroup>
						<tr>
						<th>시리즈명</th>
						<td>
							<select name="colNm">
							<c:forEach var="series" items="${series}"  varStatus="status">
								<option value="${status.index }">${series.colNm }</option>
							</c:forEach>
							</select>
						</td>
						<th>차트유형</th>
						<td>
							<select class="seriesCd" name="seriesCd">
							</select>
<!-- 							<span id="stacking"><input type="checkbox" name="chkStacking" /> 누적보기</span>  -->
						</td>
						</tr>
						<c:forEach var="cond" items="${cond}" varStatus="status">
						<tr>
							<th><c:out value="${cond.colNm}"/><c:if test="${cond.filtNeed eq 'Y'}"> <span>*</span></c:if></th>
							<c:choose>
								<c:when test="${cond.filtCd eq 'CHECK'}">
									<td colspan="3">        
									<c:forEach var="condDtl" items="${condDtl}" varStatus="status1">                
										<c:if test="${cond.srcColId eq condDtl.srcColId}">        
											<c:choose>
												<c:when test="${cond.filtDefault eq condDtl.ditcCd}">
													<input type="checkbox" id="${condDtl.ditcCd}" name="${condDtl.srcColId}" checked="checked" value="${condDtl.ditcCd}"/>                   
												</c:when>
												<c:otherwise>             
													<input type="checkbox" id="${condDtl.ditcCd}" name="${condDtl.srcColId}" value="${condDtl.ditcCd}"/>                   
												</c:otherwise>
											</c:choose>
											<label for="${condDtl.ditcCd}"/><c:out value="${condDtl.ditcNm}"/></label>      
										</c:if>                    
									</c:forEach>
									<input type="hidden" name="checkFiltNeed" value="${cond.filtNeed}"/>                          
								</c:when>
								
								<c:when test="${cond.filtCd eq 'COMBO'}">
								<td colspan="3">        
									<select name="${cond.srcColId}"><option value=''></option>
									<c:forEach var="condDtl" items="${condDtl}" varStatus="status1">            
										<c:if test="${cond.srcColId eq condDtl.srcColId}">    
											<c:set var="dataD"/>
											<fmt:formatDate value="<%=new java.util.Date()%>" pattern="yyyy" var="dateD"/>  
											<c:choose>               
												<c:when test="${cond.srcColId eq 'FSCL_YY' && cond.filtDefault eq ''}">
													<c:choose>
														<c:when test="${condDtl.ditcCd eq dateD}">
															<option value="<c:out value="${condDtl.ditcCd}"/>" selected="selected"><c:out value="${condDtl.ditcNm}"/></option>
														</c:when>
														<c:otherwise>
															<option value="<c:out value="${condDtl.ditcCd}"/>"><c:out value="${condDtl.ditcNm}"/></option>    
														</c:otherwise>
													</c:choose>
												</c:when>
												<c:otherwise>
													<c:choose>
														<c:when test="${cond.filtDefault eq condDtl.ditcCd}">
															<option value="<c:out value="${condDtl.ditcCd}"/>" selected="selected"><c:out value="${condDtl.ditcNm}"/></option>
														</c:when>
														<c:otherwise>
															<option value="<c:out value="${condDtl.ditcCd}"/>"><c:out value="${condDtl.ditcNm}"/></option>    
														</c:otherwise>
													</c:choose>
												</c:otherwise>
											</c:choose>
										</c:if>                                          
									</c:forEach> 
									</select>    
									<input type="hidden" name="comboFiltNeed" value="${cond.filtNeed}"/>      
								</c:when>
								
								<c:when test="${cond.filtCd eq 'RADIO'}">
									<td colspan="3">        
									<c:forEach var="condDtl" items="${condDtl}" varStatus="status1">    
									<c:if test="${cond.srcColId eq condDtl.srcColId}">  
										<c:choose>
											<c:when test="${cond.filtDefault eq condDtl.ditcCd}">
												<input type="radio" name="${condDtl.srcColId}" id="${condDtl.ditcCd}" checked="checked" value="${condDtl.ditcCd}">
											</c:when>
											<c:otherwise>
												<input type="radio" name="${condDtl.srcColId}" id="${condDtl.ditcCd}" value="${condDtl.ditcCd}">              
											</c:otherwise>
										</c:choose>
										<label for="${condDtl.ditcCd}"><c:out value="${condDtl.ditcNm}"/></label>          		
									</c:if>                                 
								</c:forEach> 
								<input type="hidden" name="radioFiltNeed" value="${cond.filtNeed}"/>      
								</c:when>
								
								<c:when test="${cond.filtCd eq 'FDATE' || cond.filtCd eq'LDATE' || cond.filtCd eq 'PDATE' || cond.filtCd eq 'SDATE' || cond.filtCd eq 'CDATE'}">
									<td colspan="3">        
									<input type="text" name="${cond.srcColId}" readonly="readonly"/> ~ <input type="text" name="${cond.srcColId}" readonly="readonly"/>
									<input type="hidden" name="filtMaxDay" value="${cond.filtMaxDay }"/>
									<button type='button' class='btn10' name="dateBtn10" title="<spring:message code='btn.init'/>"><spring:message code='btn.init'/></button>
								</c:when>
																
								<c:when test="${cond.filtCd eq 'WORDS'}">
									<td colspan="3">        
									<input type="text" name="${cond.srcColId}"/> 
								</c:when>
								<c:when test="${cond.filtCd eq 'POPUP'}">    
									<td colspan="3">             
									<input type='text' name="'${cond.srcColId}Nm'"  readonly='readonly' value="${cond.filtDefault}"/>                                
									<input type='hidden' name="${cond.srcColId}" value="${cond.filtDefault}"  readonly='readonly'/>                 
									<input type='hidden' name='realTblId' value="${cond.filtTblCd}" readonly='readonly'/>                   
									<button type='button' class='btn09' title="<spring:message code='btn.inquiry'/>"><spring:message code='btn.inquiry'/></button>
									<button type='button' class='btn10' name="popBtn10" title="<spring:message code='btn.init'/>"><spring:message code='btn.init'/></button>
									<input type='hidden' name='popFiltNeed' value="${cond.filtNeed}" />                     
								</c:when>
								              
								<c:when test="${cond.filtCd eq 'PLINK'}">
									<td colspan="3">        
									<a target='_blank' href=''${cond.filtDefault}' class='on' title=''${cond.filtDefault}'>${cond.filtDefault}</a>                        
								</c:when>
								
							</c:choose>                        
							</td>                   
							</tr>
						</c:forEach>                                                             
					</table>	
				</form>
				<div style="clear: both;"></div>
				<div class="ibsheet_area_both">
				<script type="text/javascript">createIBChart("myChart", "100%", "300px");</script>
				</div>
				 <c:if test="${!empty ds_exp && ds_exp ne ''}">                     
				 	<div class="comment">                                
				 		${fn:replace(ds_exp,crlf,'<br/>')}             
					</div>                                       
				 </c:if>
						
			</div>
			<div class="buttons">            
				<c:choose>
					<c:when test="${viewLang eq 'E'}">
						<a href='#' class='btn02' name='a_close'>close</a>       
					</c:when>
					<c:otherwise>         
						<a href='#' class='btn02' name='a_close'>닫기</a>       
					</c:otherwise>        
				</c:choose>         
			</div>	
		</div>		
	</div>
</html>