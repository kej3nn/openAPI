<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>
<%
	String apikey = "3dac3b05c02ee38e6f02898c63bf6f43";
   //치환 변수 선언
    pageContext.setAttribute("cr", "\r"); //Space
    pageContext.setAttribute("cn", "\n"); //Enter
    pageContext.setAttribute("crcn", "\r\n"); //Space, Enter
    pageContext.setAttribute("br", "<br/>"); //br 태그
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title><spring:message code="wiseopen.title" /></title>           
<c:import  url="/WEB-INF/jsp/inc/headinclude.jsp"/>
<script type="text/javascript" src="<c:url value="/js/common/base/commonness.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/common/base/delegation.js" />"></script>
<script type="text/javascript" src="//apis.daum.net/maps/maps3.js?apikey=<%=apikey%>" charset="utf-8"></script>
<style type="text/css">
body{background:none;}
.area_map {position:relative; overflow:hidden; width:100%; height:0; padding-bottom:48.98%;}
.area_map .map {position:absolute; top:0; left:0; width:100%; height:100%; background:#dbdbdb;}
</style>
<script type="text/javascript">
var dtfileId = "${data.dtfileId }";
var uplSchNo = "${data.uplSchNo }";

/**
 * X-축 컬럼
 */ 
var xaxes = null;

/**
 * Y-축 컬럼
 */
var yaxes = null;

/**
 * Y-축 갯수
 */
var count = 0;

/**
 * 데이터 수
 */
var total = 0;

var items;

/**
 * 맵
 */
var map;

/**
 * 이미지
 */
var image;

/**
 * 툴팁
 */
var tooltip;

/**
 * 마커
 */
var markers;
$(document).ready(function() {
	loadData();
	
	bindEvent();
});

function loadData() {
	selectSrvInfo();
}

function bindEvent() {
    $(".chart-series-combo").bind("change", function(event) {
        // 공공데이터 차트 서비스 시리즈를 변경한다.
        changeChartSeries();
    });
    
    $(".chart-types-combo").bind("change", function(event) {
        // 공공데이터 차트 서비스 차트유형을 변경한다.
        changeChartType();
    });
}

function selectSrvInfo() {
	// 제공 서비스를 조회한다.
	doSelect({
		url:"/admin/dtfile/uploadPreviewPopupSrvInfo.do",
		before:function() {return {dtfileId : dtfileId, uplSchNo : uplSchNo};},
		after:afterSelectSrvInfo
	});
}

function selectViewService(srvCd) {
	$('.content [id^=layout_]').hide();
	$('[id^=srvCd_]').removeClass('on');
	$('#srvCd_'+srvCd).addClass('on');
	if(srvCd == "S") {
		selectSheetMeta();
		$('.content #layout_sheet').show();
	} else if(srvCd == "C") {
		selectChartMeta();
		$('.content #layout_chart').show();
	} else if(srvCd == "M") {
		selectMapMeta();
		$('.content #layout_map').show();
	}
}
// 시트 정보 조회
function selectSheetMeta() {
    // 데이터를 조회한다.
    doSelect({
        url:"/admin/dtfile/uploadPreviewColumn.do",
        before:function() {return {dtfileId : dtfileId, uplSchNo : uplSchNo};},
        after:afterSelectSheetMeta
    });
}
// 차트 정보 조회
function selectChartMeta() {
	doSelect({
		url:"/admin/dtfile/uploadPreviewChartMeta.do",
		before:function() {return {dtfileId : dtfileId, uplSchNo : uplSchNo};},
		after:afterSelectChartMeta
	});
}
// 맵 정보 조회
function selectMapMeta() {
	doSelect({
		url:"/admin/dtfile/uploadPreviewMapMeta.do",
		before:function() {return {dtfileId : dtfileId, uplSchNo : uplSchNo};},
		after:afterSelectMapMeta
	});
}

function afterSelectSrvInfo(data) {
	var srvInfo = data.srvInfo;
	$.each(srvInfo, function(i, d) {
		$('#srvCd_'+d.srvCd).removeClass('no-service').addClass('service');
		if(i == 0) {
			$('#srvCd_'+d.srvCd).addClass('on');
			selectViewService(d.srvCd);
		}
	});
	
	$('.tab-inner .service').bind('click', function() {
		if(!$(this).hasClass("on")) {
			var srvCd = $(this).attr('id').substr(6);
			selectViewService(srvCd);
		}
	});
}

function afterSelectSheetMeta(data) {
    // 시트 그리드를 생성한다.
    initSheetGrid({
        ElementId:"preview-sheet",
        SheetId:"SheetObject"
    }, {
    }, {
        HeaderCheck:0
    }, data.columns, {
        // Nothing do do.
    });
    
    var sheet = window["SheetObject"];
    
    var width = 0;
    
    for (var i = 0; i < data.columns.length; i++) {
        width += sheet.GetColWidth(i);
    }
    
    if (sheet.GetSheetWidth() > width) {
        sheet.FitColWidth();
    }
    
    searchSheetData();
}

function searchSheetData() {
	loadSheetData({
		SheetId:"SheetObject",
        PageUrl:"/admin/dtfile/uploadPreviewData.do"
    }, {
    	QueryParam:"dtfileId="+dtfileId+"&uplSchNo="+uplSchNo
    }, {
	});
}

function afterSelectChartMeta(data) {
    // X-축 컬럼을 설정한다.
    xaxes = data.xaxes;
    
    // Y-축 컬럼을 설정한다.
    yaxes = data.yaxes;
    
    // Y-축 갯수를 설정한다.
    count = com.wise.util.isBlank(data.rytitNm) ? 1 : 2;
    
    // 공공데이터 차트 서비스 시리즈 옵션을 초기화한다.
    initChartSeriesOptions(data.yaxes);
    
    // 공공데이터 차트 서비스 차트유형 옵션을 초기화한다.
    initChartTypeOptions(data.types);
    
    // 차트 그리드를 생성한다.
    initChartGrid({
        ElementId:"preview-chart",
        ChartId:"ChartObject",
        Height:"100%"
    }, {
        xlnCd:data.xlnCd,
        ylnCd: data.ylnCd,
        xtitNm:data.xaxes.length > 0 ? data.xaxes[0].colNm : "",
        lytitNm:data.lytitNm,
        rytitNm:data.rytitNm,
        seriesPosx:data.seriesPosx,
        seriesPosy:data.seriesPosy,
        seriesOrd:data.seriesOrd,
        seriesFyn:data.seriesFyn
    });
    
    // 공공데이터 차트 서비스 데이터를 검색한다.
    searchChartData();
}

/*
 * 공공데이터 차트 서비스 시리즈 옵션을 초기화한다.
 * 
 * @param data {Array} 데이터
 */
function initChartSeriesOptions(data) {
    var options = [];
    
    for (var i = 0; i < data.length; i++) {
        options[i] = {
            code:data[i].srcColId,
            name:data[i].colNm
        };
    }
    
    var value = "";
    
    if (data.length > 0) {
        value = data[0].srcColId;
    }
    
    // 콤보 옵션을 초기화한다.
    initComboOptions("series", options, value);
    
    if (options.length > 0) {

    }
}

 /**
  * 공공데이터 차트 서비스 차트유형 옵션을 초기화한다.
  * 
  * @param data {Array} 데이터
  */
 function initChartTypeOptions(data) {
     var options = data;
     
     var value = "";
     
     if (yaxes.length > 0) {
         value = yaxes[0].seriesCd;
     }
     
     // 콤보 옵션을 초기화한다.
     initComboOptions("chartType", options, value);
 }

 
function searchChartData() {
	doSearch({
		url:"/admin/dtfile/uploadPreviewChartData.do",
		before:function() {return {dtfileId : dtfileId, uplSchNo : uplSchNo};},
		after:afterSearchChartData
	});
}

function afterSearchChartData(data) {
    total = data.length;
    
    // 차트 데이터를 로드한다.
    loadChartData({
        ChartId:"ChartObject"
    }, {
        xaxes:xaxes,
        yaxes:yaxes,
        data:data
    });
    
}
/**
 * 차트 그리드를 생성한다.
 * 
 * @param createOptions {Object} 생성 옵션
 * @param othersOptions {Object} 기타 옵션
 */
function initChartGrid(createOptions, othersOptions) {
    createOptions = createOptions || {};
    othersOptions = othersOptions || {};
    
    createOptions.ElementId  = createOptions.ElementId  != null ? createOptions.ElementId  : "chart-section";
    createOptions.ChartId    = createOptions.ChartId    != null ? createOptions.ChartId    : "chart";
    createOptions.Width      = createOptions.Width      != null ? createOptions.Width      : "100%";
    createOptions.Height     = createOptions.Height     != null ? createOptions.Height     : "300px";
    
    var element = document.getElementById(createOptions.ElementId);
    
    if (element) {
        createIBChart2(element, createOptions.ChartId, createOptions.Width, createOptions.Height);
        
        var chart = window[createOptions.ChartId];
        
        othersOptions.xtitNm   = othersOptions.xtitNm   != null ? othersOptions.xtitNm  : "";
        othersOptions.lytitNm  = othersOptions.lytitNm  != null ? othersOptions.lytitNm : "";
        othersOptions.rytitNm  = othersOptions.rytitNm  != null ? othersOptions.rytitNm : "";
        
        initChart(
            chart
        );
        initXStyleChart(
            chart,
            othersOptions.xlnCd,
            othersOptions.ylnCd,
            othersOptions.xtitNm
        );
        initYStyleChart(
            chart,
            othersOptions.xlnCd,
            othersOptions.ylnCd,
            othersOptions.lytitNm
        );
        initYStylechart2(
            chart,
            othersOptions.xlnCd,
            othersOptions.ylnCd,
            othersOptions.rytitNm
        );
        initToolTipSet(
            chart
        );
        initLegend(
            chart,
            othersOptions.seriesPosx,
            othersOptions.seriesPosy,
            othersOptions.seriesOrd,
            othersOptions.seriesFyn
        );
        initLable(
            chart
        );
    }
}

 /**
  * 차트 데이터를 로드한다.
  *
  * @param searchOptions {Object} 검색 옵션
  * @param seriesOptions {Object} 시리즈 옵션
  */
 function loadChartData(searchOptions, seriesOptions) {
     searchOptions = searchOptions || {};
     seriesOptions = seriesOptions || {};
     
     searchOptions.ChartId = searchOptions.ChartId != null ? searchOptions.ChartId : "chart";
     
     var chart = window[searchOptions.ChartId];
     
     if (chart) {
         seriesOptions.xaxes = seriesOptions.xaxes != null ? seriesOptions.xaxes : [];
         seriesOptions.yaxes = seriesOptions.yaxes != null ? seriesOptions.yaxes : [];
         seriesOptions.data  = seriesOptions.data  != null ? seriesOptions.data  : [];
         
         chart.RemoveAll();
         
         for (var x = 0; x < seriesOptions.xaxes.length; x++) {
             for (var y = 0; y < seriesOptions.yaxes.length; y++) {
                 var points = [];
                 var labels = [];
                 
                 for (var i = 0; i < seriesOptions.data.length; i++) {
                     var name  = seriesOptions.data[i][seriesOptions.xaxes[x].srcColId];
                     var value = seriesOptions.data[i][seriesOptions.yaxes[y].srcColId];
                     
                     points[points.length] = {
                         X:i,
                         Y:value ? value : 0,
                         Name:name,
                         Sliced:false
                     };
                     
                     labels[labels.length] = name;
                 }
                 
                 var series = chart.CreateSeries();

                 series.SetName(seriesOptions.yaxes[y].colNm);
                 series.AddPoints(points);
                 
                 if (seriesOptions.yaxes[y].yaxisPos == "R") {
                     series.SetProperty({
                         Type:eval(seriesOptions.yaxes[y].seriesCd),
                         YAxis:1
                     });
                 }
                 else {
                     series.SetProperty({
                         Type:eval(seriesOptions.yaxes[y].seriesCd)
                     });
                 }
                 
                 chart.AddSeries(series);
                 
                 chart.SetXAxisLabelsText(0, labels);
                 
                 chart.Draw();
             }
         }
     }
 }

/**
 * 공공데이터 차트 서비스 시리즈를 변경한다.
 */
function changeChartSeries() {
    var index = $(".chart-series-combo").prop("selectedIndex");
    
    $(".chart-types-combo").val(yaxes[index].seriesCd);
}

/**
 * 공공데이터 차트 서비스 차트유형을 변경한다.
 */
function changeChartType() {
    var index = $(".chart-series-combo").prop("selectedIndex");
    
    var value = $(".chart-types-combo").val();
    
    var chart = window["ChartObject"];
    
    var series = chart.GetSeries(index);
    
    series.SetProperty({
        Type:getChartType(value)
    });
    
    chart.UpdateSeries(series, index);
    
    chart.Draw();
    
    yaxes[index].seriesCd = value;
}


/**
 * 공공데이터 차트 서비스 차트유형을 반환한다.
 * 
 * @param type {String} 차트유형
 * @returns {String} 차트유형
 */
function getChartType(type) {
    var chart = window["ChartObject"];
    
    switch (type) {
        case "IBChartType.BAR":
            var plot = new BarPlotOptions();
            plot.SetStacking(null);
            chart.SetBarPlotOptions(plot);
            setDefaultYaxis();
            return IBChartType.BAR;
        case "IBChartType.BAR_Stacking_Normal":
            var plot = new BarPlotOptions();
            plot.SetStacking(IBStacking.NORMAL);
            chart.SetBarPlotOptions(plot);
            setDefaultYaxis();
            return IBChartType.BAR;
        case "IBChartType.BAR_Stacking":
            var plot = new BarPlotOptions();
            plot.SetStacking(IBStacking.PERCENT);
            chart.SetBarPlotOptions(plot);
            setStackingYaxis();
            return IBChartType.BAR;
        case "IBChartType.COLUMN":
            var plot = new ColumnPlotOptions();
            plot.SetStacking(null);
            chart.SetColumnPlotOptions(plot);
            setDefaultYaxis();
            return IBChartType.COLUMN;
        case "IBChartType.COLUMN_Stacking_Normal":
            var plot = new ColumnPlotOptions();
            plot.SetStacking(IBStacking.NORMAL);
            chart.SetColumnPlotOptions(plot);
            setDefaultYaxis();
            return IBChartType.COLUMN;
        case "IBChartType.COLUMN_Stacking":
            var plot = new ColumnPlotOptions();
            plot.SetStacking(IBStacking.PERCENT);
            chart.SetColumnPlotOptions(plot);
            setStackingYaxis();
            return IBChartType.COLUMN;
        case "IBChartType.LINE":
            var plot = new LinePlotOptions();
            plot.SetStacking(null);
            plot.SetMarker(true);
            plot.SetStep(false);
            chart.SetLinePlotOptions(plot);
            return IBChartType.LINE;
        case "IBChartType.LINE_Stacking_Normal":
            var plot = new LinePlotOptions();
            plot.SetStacking(IBStacking.NORMAL);
            plot.SetMarker(false);
            plot.SetStep(false);
            chart.SetLinePlotOptions(plot);
            return IBChartType.LINE;
        case "IBChartType.LINE_Stacking":
            var plot = new LinePlotOptions();
            plot.SetStacking(IBStacking.PERCENT);
            plot.SetMarker(false);
            plot.SetStep(false);
            chart.SetMargin(50);
            chart.SetLinePlotOptions(plot);
            setStackingYaxis();
            return IBChartType.LINE;
        case "IBChartType.LINE_Marker":
            var plot = new LinePlotOptions();
            plot.SetStacking(null);
            plot.SetMarker(true);
            plot.SetStep(false);
            chart.SetLinePlotOptions(plot);
            return IBChartType.LINE;
        case "IBChartType.LINE_Stacking_Normal_Marker":
            var plot = new LinePlotOptions();
            plot.SetStacking(IBStacking.NORMAL);
            plot.SetMarker(true);
            plot.SetStep(false);
            chart.SetLinePlotOptions(plot);
            return IBChartType.LINE;
        case "IBChartType.LINE_Stacking_Marker":
            var plot = new LinePlotOptions();
            plot.SetStacking(IBStacking.PERCENT);
            plot.SetMarker(true);
            plot.SetStep(false);
            chart.SetMargin(50);
            chart.SetLinePlotOptions(plot);
            setStackingYaxis();
            return IBChartType.LINE;
        case "IBChartType.LINE_Step":
            var plot = new LinePlotOptions();
            plot.SetStacking(null);
            plot.SetMarker(false);
            plot.SetStep(true);
            chart.SetLinePlotOptions(plot);
            setDefaultYaxis();
            return IBChartType.LINE;
        case "IBChartType.LINE_Step_Marker":
            var plot = new LinePlotOptions();
            plot.SetStacking(null);
            plot.SetMarker(true);
            plot.SetStep(true);
            chart.SetLinePlotOptions(plot);
            setDefaultYaxis();
            return IBChartType.LINE;
        case "IBChartType.SPLINE":
            var plot = new SplinePlotOptions();
            plot.SetStacking(null);
            plot.SetMarker(false);
            chart.SetSplinePlotOptions(plot);
            return IBChartType.SPLINE;
        case "IBChartType.SPLINE_Marker":
            var plot = new SplinePlotOptions();
            plot.SetStacking(null);
            plot.SetMarker(true);
            chart.SetSplinePlotOptions(plot);
            return IBChartType.SPLINE;
        case "IBChartType.SCATTER":
            var plot = new ScatterPlotOptions();
            plot.SetStacking(null);
            plot.SetMarker(true);
            chart.SetScatterPlotOptions(plot);
            return IBChartType.SCATTER;
        case "IBChartType.AREA":
            var plot = new AreaPlotOptions();
            plot.SetStacking(null);
            plot.SetMarker(false);
            chart.SetAreaPlotOptions(plot);
            setDefaultYaxis();
            return IBChartType.AREA;
        case "IBChartType.AREA_Stacking_Normal":
            var plot = new AreaPlotOptions();
            plot.SetStacking(IBStacking.NORMAL);
            plot.SetMarker(false);
            chart.SetAreaPlotOptions(plot);
            setDefaultYaxis();
            return IBChartType.AREA;
        case "IBChartType.AREA_Stacking":
            var plot = new AreaPlotOptions();
            plot.SetStacking(IBStacking.PERCENT);
            plot.SetMarker(false);
            chart.SetMargin(50);
            chart.SetAreaPlotOptions(plot);
            setStackingYaxis();
            return IBChartType.AREA;
        case "IBChartType.AREA_SPLINE":
            var plot = new AreaSplinePlotOptions();
            plot.SetStacking(null);
            plot.SetMarker(false);
            chart.SetAreaSplinePlotOptions(plot);
            setDefaultYaxis();
            return IBChartType.AREA_SPLINE;
        case "IBChartType.PIE":
            var plot = new PiePlotOptions();
            plot.SetAllowPointSelect(true);
            plot.SetSlicedOffset(20);
            plot.SetInnerSize(0);
            plot.SetShowInLegend(true);
            var style = new Style();
            style.SetFontSize("12px");
            chart.SetPiePlotOptions(plot);
            return IBChartType.PIE;
        case "IBChartType.PIE_Sliced":
            var plot = new PiePlotOptions();
            plot.SetAllowPointSelect(true);
            plot.SetSlicedOffset(20);
            plot.SetInnerSize(0);
            plot.SetShowInLegend(true);
            var style = new Style();
            style.SetFontSize("12px");
            chart.SetPiePlotOptions(plot);
            return IBChartType.PIE;
        case "IBChartType.PIE_InnerSize":
            var plot = new PiePlotOptions();
            plot.SetAllowPointSelect(true);
            plot.SetSlicedOffset(20);
            plot.SetInnerSize(100);
            plot.SetShowInLegend(true);
            var style = new Style();
            style.SetFontSize("12px");
            chart.SetPiePlotOptions(plot);
            return IBChartType.PIE;
        case "IBChartType.PIE_Sliced_InnerSize":
            var plot = new PiePlotOptions();
            plot.SetAllowPointSelect(true);
            plot.SetSlicedOffset(20);
            plot.SetInnerSize(100);
            plot.SetShowInLegend(true);
            var style = new Style();
            style.SetFontSize("12px");
            chart.SetPiePlotOptions(plot);
            return IBChartType.PIE;
    }
}

 /**
  * 디폴트 Y-축을 설정한다.
  */
 function setDefaultYaxis() {
     var chart = window["ChartObject"];
     
     var labels = new AxisLabels();
     
     labels.SetFormatter(AxisLabelsFormatter);
     
     var yaxis = chart.GetYAxis(0);
     
     yaxis.SetLabels(labels);
     
     if (count > 1) {
         labels = new AxisLabels();
         
         labels.SetFormatter(AxisLabelsFormatter);
         
         yaxis = chart.GetYAxis(1);
         
         yaxis.SetLabels(labels);
     }
 }

 /**
  * 스태킹 Y-축을 설정한다.
  */
 function setStackingYaxis() {
     var chart = window["ChartObject"];
     
     var labels = new AxisLabels();
     
     labels.SetFormatter(PercentAxisLabelsFormatter);
     
     var yaxis = chart.GetYAxis(0);
     
     yaxis.SetMax(100);
     yaxis.SetLabels(labels);
     
     if (count > 1) {
         labels = new AxisLabels();
         
         labels.SetFormatter(PercentAxisLabelsFormatter);
         
         yaxis = chart.GetYAxis(1);
         
         yaxis.SetMax(100);
         yaxis.SetLabels(labels);
     }
 }

function afterSelectMapMeta(data) {

    initMapItems(data.items);
    initMapComp(data);
    bindMapEvent();
    searchMapData();
}   

function initMapItems(data) {
    items = {
        // Nothing to do.
    };
    
    for (var i = 0; i < data.length; i++) {
        items[data[i].colCd] = data[i].colNm;
    }
}

function initMapComp(data) {
    data.yPos     = data.yPos     > 0 && data.xPos     > 0  ? data.yPos     : 37.27466697525489;
    data.xPos     = data.yPos     > 0 && data.xPos     > 0  ? data.xPos     : 127.00961997318083;
    data.mapLevel = data.mapLevel > 0 && data.mapLevel < 15 ? data.mapLevel : 9;
    
    if (data.first.length > 0) {
        if (data.first[0].Y_WGS84 > 0 && data.first[0].X_WGS84 > 0) {
            data.yPos = data.first[0].Y_WGS84;
            data.xPos = data.first[0].X_WGS84;
        }
    }
    
    map = new daum.maps.Map(document.getElementById("map-object-sect"), {
        center:new daum.maps.LatLng(data.yPos, data.xPos),
        level:data.mapLevel
    });
    
    map.addControl(new daum.maps.MapTypeControl(), daum.maps.ControlPosition.TOPRIGHT);
    map.addControl(new daum.maps.ZoomControl(), daum.maps.ControlPosition.BOTTOMRIGHT);
    
    map.setCopyrightPosition(daum.maps.CopyrightPosition.BOTTOMRIGHT, true);
    
    if (data.markerCd) {
        image = new daum.maps.MarkerImage(data.markerCd, new daum.maps.Size(32, 32), {
            offset:new daum.maps.Point(16, 32)
        });
    }
    
    tooltip = new daum.maps.InfoWindow({
        content:""
    });
    
    markers = [
        // Nothing to do.
    ];
}

function bindMapEvent() {
    daum.maps.event.addListener(map, "idle", function() {
        // 공공데이터 맵 서비스 데이터를 검색한다.
        searchMapData();
    });
}

function searchMapData() {
    doSearch({
        url:"/admin/dtfile/uploadPreviewMapData.do",
        before:function() {return {dtfileId : dtfileId, uplSchNo : uplSchNo};},
        after:afterSearchMapData
    });
}

function afterSearchMapData(data) {
    // 맵 마커를 초기화한다.
    initMapMarkers();
    
    // 맵 데이터를 로드한다.
    loadMapData(data);
}

/**
 * 맵 마커를 초기화한다.
 */
function initMapMarkers() {
    if (markers) {
        for (var i = 0; i < markers.length; i++) {
            markers[i].setMap(null);
        }
    }
    
    markers = [];
}

/**
 * 맵 데이터를 로드한다.
 * 
 * @param data {Array} 데이터
 */
function loadMapData(data) {
    // var count = 0;
    
    for (var i = 0; i < data.length; i++) {
        if (data[i].Y_WGS84 > 0 && data[i].X_WGS84 > 0) {
            // if (map == null) {
            //     config.yPos = data[i].Y_WGS84;
            //     config.xPos = data[i].X_WGS84;
            //     
            //     // 맵 컴포넌트를 생성한다.
            //     initMapComp(config);
            // }
            
            var options = {
                position:new daum.maps.LatLng(data[i].Y_WGS84, data[i].X_WGS84)
            };
            
            if (image) {
                options.image = image;
            }
            
            var marker = new daum.maps.Marker(options);
            
            marker.setMap(map);
            
            var content = "";
            
            for (var key in data[i]) {
                if (key != "Y_WGS84" && key != "X_WGS84") {
                    if (data[i][key] != null) {
                        if (content) {
                            content += "<br />";
                        }
                        
                         if (items[key]) {
                             content += "<strong>" + items[key] + " : </strong>";
                         }
                        
                        content += data[i][key];
                    }
                }
            }
            
            // if (content) {
            //     var tooltip = new daum.maps.InfoWindow({
            //         content:"<div style=\"padding:8px 8px 24px 8px;\">" + content + "</div>"
            //     });
            //     
            //     daum.maps.event.addListener(marker, "mouseover", (function(marker, tooltip) {
            //         return function() {
            //             tooltip.open(map, marker);
            //         };
            //     })(marker, tooltip));
            //     
            //     daum.maps.event.addListener(marker, "mouseout", (function(marker, tooltip) {
            //         return function() {
            //             tooltip.close();
            //         };
            //     })(marker, tooltip));
            // }
            daum.maps.event.addListener(marker, "mouseover", (function(marker, content) {
                return function() {
                    if (content) {
                        tooltip.setContent("<div style=\"padding:8px 8px 24px 8px;white-space:nowrap;\">" + content + "</div>");
                        tooltip.open(map, marker);
                        $('#marker-desc').html(content.split("<br />").join(" "));
                    }
                    else {
                        tooltip.close();
                        $('#marker-desc').empty();
                    }
                };
            })(marker, content));
            
            daum.maps.event.addListener(marker, "mouseout", (function() {
                return function() {
                    tooltip.close();
                    $('#marker-desc').empty();
                };
            })());
            
            markers[markers.length] = marker;
            
            // count++;
        }
    }
    
    // if (data.length > 0) {
    //     if (count > 0) {
    //         map.setCenter(new daum.maps.LatLng(data[0].Y_WGS84, data[0].X_WGS84));
    //     }
    // }
}

</script>
</head>
<body>
<div class="wrap-popup">
	<!-- 내용 -->
	<div class="container">
		<!-- 상단 타이틀 -->
		<div class="title">
			<h2>미리보기</h2>
		</div>
	</div>
	    		
	<div class="content">
		<ul class="tab-inner">   
			<li><a href="#" class="no-service" id="srvCd_S">Sheet</a></li>
<!-- 			<li><a href="#" class="no-service" id="srvCd_C">Chart</a></li>               -->
<!-- 			<li><a href="#" class="no-service" id="srvCd_M">Map</a></li> -->
		</ul>              
		
		<div id="layout_sheet" style="display:none;">
			<div class="ibsheet_area" id="preview-sheet"></div>
		</div>
		
		<div id="layout_chart" style="display:none;">
            시리즈 <select id="series" name="colNm" class="chart-series-combo" title="차트 시리즈 선택">
            </select>
			차트유형 <select id="chartType" name="seriesCd" class="chart-types-combo" title="차트 유형 선택">
            </select>
			<div class="chart" id="preview-chart" style="margin-top:5px;"></div>
		</div>
		
		<div id="layout_map" style="display:none;">
			<section class="section_map">
				<div class="area_map" style="position:relative; overflow:hidden; width:100%; height:0;">
	                <div class="map" id="map-object-sect" style="width:100%; height:100%; position:absolute;">
	                </div>
	            </div>
            </section>
		</div>
		
		<span style="color:#ff0000;">*</span> 당일 저장 한 데이터만 표시됩니다.
	</div>
</div>
</body>
</html>