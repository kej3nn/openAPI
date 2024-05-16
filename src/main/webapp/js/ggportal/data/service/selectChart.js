/*
 * @(#)selectChart.js 1.0 2015/06/15
 * 
 * COPYRIGHT (C) 2013 WISEITECH CO., LTD. ALL RIGHTS RESERVED.
 */

/**
 * 공공데이터 차트 서비스를 조회하는 스크립트이다.
 *
 * @author 김은삼
 * @version 1.0 2015/06/15
 */
$(function() {
    // 컴포넌트를 초기화한다.
    initComp();
    
    // 마스크를 바인딩한다.
    bindMask();
    
    // 이벤트를 바인딩한다.
    bindEvent();
    
    // 옵션을 로드한다.
    loadOptions();
    
    // 데이터를 로드한다.
    loadData();
    
});

////////////////////////////////////////////////////////////////////////////////
// 글로벌 변수
////////////////////////////////////////////////////////////////////////////////
/**
 * 하이차트
 */ 
var highCharts = null;

/**
 * 하이차트 옵션
 */
var highChartsOptions = null;

/**
 * 차트 조회 데이터
 */
var chartData = null;

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

/**
 * 템플릿
 */
var templates = {
    data:
        "<tr>"                                                       +
            "<td align=\"center\"><input type=\"checkbox\" /></td>"  +
            "<td align=\"center\"><span class=\"code\"></span></td>" +
            "<td align=\"left\"><span class=\"name\"></span></td>"   +
        "</tr>",
    none:
        "<tr>"                                                                               +
            "<td colspan=\"3\"><span class=\"noData\">검색된 데이터가 없습니다.</span></td>" +
        "</tr>"
};

/**
 * 추천 템플릿
 */
var templates2 = {
	    data:
	        "<li><a href=\"#none\">"                                                       +
	            "<span class=\"img\"><img src=\"\" alt=\"\" class=\"thumbnail_dataSet metaImagFileNm\"></span>" +
	            "<div class=\"dataset_boxlist\">"                                               				+
	            "<div class=\"dataset_box_text\">"                                               					+
	            "<em class=\"m_cate\">의정활동</em>"                                               										+
	            "<i class=\"ot01 infsTag\">데이터</i>"                                               										+
	            "</div>"                                               											+
	            "<span class=\"txt\"></span>"                                               					+
	            "</div>"                                               											+
	        "</a></li>",  
	       none:
	           "<li><a href=\"#none\">"                                                       +
	           "<img src=\"\" alt=\"\">"                                                  +
	           "<span class=\"txt\">데이터가 없습니다.</span>" +
	       "</a></li>"  
	};

////////////////////////////////////////////////////////////////////////////////
// 초기화 함수
////////////////////////////////////////////////////////////////////////////////
/**
 * 컴포넌트를 초기화한다.
 */
//function initComp() {
//    // Nothing to do.
//}

function initComp() {
	// 윈도우 단위에서 키가 눌리면
    $(window).keyup(function (e) {
        // 발생한 이벤트에서 키 코드 추출, BackSpace 키의 코드는 8
    	if(e.target.nodeName != "INPUT" && e.target.nodeName != "TEXTAREA"){
        if (e.keyCode == 8) {
        	
        	 searchDataset();
        	
        }
    	}
    });
}

/**
 * 마스크를 바인딩한다.
 */
function bindMask() {
    // Nothing to do.
}

/**
 * 이벤트를 바인딩한다.
 */
function bindEvent() {
    // 공공데이터 차트 서비스 필터검색 버튼에 클릭 이벤트를 바이딩한다.
    $("#chart-search-button").bind("click", function(event) {
        // 공공데이터 차트 서비스 데이터를 검색한다.
        searchChartData();
        return false;
    });
    
    // 공공데이터 차트 서비스 필터검색 버튼에 키다운 이벤트를 바이딩한다.
    $("#chart-search-button").bind("keydown", function(event) {
        if (event.which == 13) {
            // 공공데이터 차트 서비스 데이터를 검색한다.
            searchChartData();
            return false;
        }
    });
    
    // 공공데이터 차트 서비스 시리즈 콤보박스에 변경 이벤트를 바인딩한다.
    $(".chart-series-combo").bind("change", function(event) {
        // 공공데이터 차트 서비스 시리즈를 변경한다.
//        changeChartSeries();
        updateChartSeries();
    });
    
    // 공공데이터 차트 서비스 차트유형 콤보박스에 변경 이벤트를 바인딩한다.
    $(".chart-xAxis-combo").bind("change", function(event) {
        // 공공데이터 차트 서비스 차트유형을 변경한다.
        updateChartAxis();
    });
    
    // 공공데이터 차트 서비스 XML 버튼에 클릭 이벤트를 바인딩한다.
    $("#chart-xml-button").bind("click", function(event) {
        // 공공데이터 차트 서비스 데이터를 다운로드한다.
        downloadChartData("X");
        return false;
    });
    
    // 공공데이터 차트 서비스 XML 버튼에 키다운 이벤트를 바인딩한다.
    $("#chart-xml-button").bind("keydown", function(event) {
        if (event.which == 13) {
            // 공공데이터 차트 서비스 데이터를 다운로드한다.
            downloadChartData("X");
            return false;
        }
    });
    
    // 공공데이터 차트 서비스 JSON 버튼에 클릭 이벤트를 바인딩한다.
    $("#chart-json-button").bind("click", function(event) {
        // 공공데이터 차트 서비스 데이터를 다운로드한다.
        downloadChartData("J");
        return false;
    });
    
    // 공공데이터 차트 서비스 JSON 버튼에 키다운 이벤트를 바인딩한다.
    $("#chart-json-button").bind("keydown", function(event) {
        if (event.which == 13) {
            // 공공데이터 차트 서비스 데이터를 다운로드한다.
            downloadChartData("J");
            return false;
        }
    });
    
    // 공공데이터 차트 서비스 EXCEL 버튼에 클릭 이벤트를 바인딩한다.
    $("#chart-excel-button").bind("click", function(event) {
        // 공공데이터 차트 서비스 데이터를 다운로드한다.
        downloadChartData("E");
        return false;
    });
    
    // 공공데이터 차트 서비스 EXCEL 버튼에 키다운 이벤트를 바인딩한다.
    $("#chart-excel-button").bind("keydown", function(event) {
        if (event.which == 13) {
            // 공공데이터 차트 서비스 데이터를 다운로드한다.
            downloadChartData("E");
            return false;
        }
    });
    
    // 공공데이터 차트 서비스 CSV 버튼에 클릭 이벤트를 바인딩한다.
    $("#chart-csv-button").bind("click", function(event) {
        // 공공데이터 차트 서비스 데이터를 다운로드한다.
        downloadChartData("C");
        return false;
    });
    
    // 공공데이터 차트 서비스 CSV 버튼에 키다운 이벤트를 바인딩한다.
    $("#chart-csv-button").bind("keydown", function(event) {
        if (event.which == 13) {
            // 공공데이터 차트 서비스 데이터를 다운로드한다.
            downloadChartData("C");
            return false;
        }
    });
    
    // 공공데이터 차트 서비스 TXT 버튼에 클릭 이벤트를 바인딩한다.
    $("#chart-txt-button").bind("click", function(event) {
        // 공공데이터 차트 서비스 데이터를 다운로드한다.
        downloadChartData("T");
        return false;
    });
    
    // 공공데이터 차트 서비스 TXT 버튼에 키다운 이벤트를 바인딩한다.
    $("#chart-txt-button").bind("keydown", function(event) {
        if (event.which == 13) {
            // 공공데이터 차트 서비스 데이터를 다운로드한다.
            downloadChartData("T");
            return false;
        }
    });
    
    // 공공데이터 데이터셋 목록 버튼에 클릭 이벤트를 바인딩한다.
    $("#dataset-search-button").bind("click", function(event) {
        // 공공데이터 데이터셋 전체목록을 검색한다.
        searchDataset();
        return false;
    });
    
    // 공공데이터 데이터셋 목록 버튼에 키다운 이벤트를 바인딩한다.
    $("#dataset-search-button").bind("keydown", function(event) {
        if (event.which == 13) {
            // 공공데이터 데이터셋 전체목록을 검색한다.
            searchDataset();
            return false;
        }
    });
}

/**
 * 옵션을 로드한다.
 */
function loadOptions() {
    // Nothing do do.
}

/**
 * 데이터를 로드한다.
 */
function loadData() {
    // 공공데이터 차트 서비스 메타정보를 조회한다.
    //selectChartMeta();
	selectChartMetaData();
}

////////////////////////////////////////////////////////////////////////////////
// 서비스 함수
////////////////////////////////////////////////////////////////////////////////

/**
 * 차트 메타정보를 조회한다.
 * @returns
 */
function selectChartMetaData() {
	// 데이터를 조회한다.
    doSelect({
        url:"/portal/data/chart/selectChartMeta.do",
        before:beforeSelectChartMeta,
        after:afterSelectChartMetaData
    });
}

/**
 * 하이차트 레전드 생성
 * @param data	레전드 메타정보
 * @returns
 */
function makeLegend(data) {
	var seriesFyn = (com.wise.util.isNull(data.seriesFyn) ? "N" : data.seriesFyn);	// 플로팅 여부
	var legend = {
		layout: data.seriesOrd,			// 방향
		align: data.seriesPosx,			// 가로위치
		verticalAlign: data.seriesPosy,	// 세로위치
		floating: (seriesFyn === "Y" ? true : false)
	};
	return legend;
}

/**
 * 하이차트 X축 설정
 * @param data	X축 메타정보 컬럼
 * @returns
 */
function makeXAxis(data) {
	var xAxis = [{
		dataKey: data[0].srcColId,		// 데이터키를 임시로 생성하여 시리즈 생성시 비교하여 사용(컬럼매핑)한다.
		categories: [],
		title: { text: data[0].colNm }
	}];
	
	return xAxis;
}

/**
 * 하이차트 Y축 설정
 * @param datas	Y축 메타정보 컬럼 리스트
 * @returns
 */
function makeYAxis(datas) {
	var yAxis = [];
	var isExist = false;	// 중복체크 여부
	
	// Y축 메타정보 컬럼 FOR LOOP
	for ( var i in datas ) {
		var data = datas[i];
		
		isExist = false;
		for ( var j in yAxis ) {
			// yAxis에 해당 단위가 담겨있는지 체크
			if ( yAxis[j].unitCd == data.unitCd ) {
				isExist = true;
				break;
			}
		}

		if ( !isExist ) {
			yAxis.push({
				unitCd: data.unitCd,
				title: {
					text: data.unitNm 
				},
				labels: {
					formatter: function() {
						return (com.wise.util.isNumeric(this.value) ? com.wise.util.toCommaWon(this.value) : this.value) + " " + data.unitNm;
					}
				},
				opposite: (data.yaxisPos == "R" ? true : false)		// Y축 LEFT/RIGHT
			});
		}
	}
	return yAxis;
}

/**
 * 하이차트 시리즈 세팅
 * @param yAxis	정의한 Y축 정보
 * @param ml	Y축 컬럼정보(DB)
 * @param dl	데이터값
 * @returns
 */
function makeSeries(yAxis, ml, dl) {
	var series = [];
//	var colNm = [];
	
	if ( ml.length > 0 ) {
		for ( var i in ml ) {
//			colNm.push(ml[i].srcColId);
			
			var yAxisIdx = 0;
			for ( var y in yAxis ) {
				if ( yAxis[y].unitCd == ml[i].unitCd ) {
					yAxisIdx = y;
					break;
				}
			}
			
			series.push({
				id: ml[i].srcColId,
				name: ml[i].colNm,
				//type: (ml[i].seriesCd == "IBChartType.LINE" ? "spline" : "column"),
				type : getHighChartType(ml[i].seriesCd),
				yAxis : Number(yAxisIdx)
			});
		}
	}
	
	if ( dl.length > 0 ) {
		for ( var s in series ) {
			var id = series[s].id;
			// 컬럼차트가 다른 차트유형보다 INDEX가 낮아야 차트영역을 가리지 않음
			if ( series[s].type === "column" || series[s].type === "bar" ) {
				series[s]["zIndex"] = 0;
			}
			else {
				series[s]["zIndex"] = 1;
			}
			
			// 데이터에서 X축에 정의한 데이터키값을 확인하여 데이터 생성
			var tmpData = [];
			for ( var d in dl ) {
				tmpData.push(dl[d][id]);
			}
			series[s].data = tmpData;
			//delete series[s]["dataKey"];
		}
	}
	
	return series;
}

function makePieSeries(meta, dl) {
	
	if ( dl == null || dl.length == 0 ) {
		return false;
	}
	
	var xAxisId = meta.xaxes[0].srcColId,
		xAxisNm  = dl[0][xAxisId],
		yAxisColId = meta.yaxes[0].srcColId,
		yAxisColNm = "",
		sDanwi = meta.yaxes[0].unitNm,
		series = [{
			key: xAxisId,
			name: dl[0][xAxisId] + " " + xAxisNm,
			colorByPoint: true,
			data: []
		}];
	
	var pdata = [{
		name: dl[0][xAxisId],
		y: dl[0][yAxisColId],
		danwi: sDanwi
	}];
	
	for ( var i=1; i < dl.length; i++ ) {
		var dld = dl[i];
		var dldId = dld[xAxisId];
		var dldVal = dld[yAxisColId];
		
		if ( !com.wise.util.isEmpty(dldVal) ) {
			var isExist = false;
			for ( var j in pdata ) {
				var pd = pdata[j];
				
				if ( pd.name == dldId ) {
					isExist = true;
				}
			}
			
			// 값이 있으면 더한다.
			if ( isExist ) {
				pd.y += dldVal;
			}
			else {
				pdata.push({
					name: dldId,
					y: dldVal,
					danwi: sDanwi
				});
			}
		}
		
	}
	
	series[0].data = pdata;
	
	return series;
	
}

function getHighChartType(s) {
	var returnVal = "";

	if(s != null) returnVal = s.replace("IBChartType.", "").replace("_", "").toLowerCase();
	
	return returnVal;
}

/**
 * 차트 데이터를 조회한다
 * @param chartMeta	하이차트 메타정보
 * @param meta		메타정보(DB)
 * @returns
 */
function selectChartData(chartMeta, meta) {
	var data = null;
	// 데이터를 검색한다.
    doSearch({
        url:"/portal/data/chart/searchChartData.do",
        before:beforeSearchChartData,
        after: function(data) {
        	chartData = data;
        	
        	// 차트 그룹(일반형, 파이형)
        	chartMeta.group = meta.sgrpCd || "";
        	
        	// 공공데이터 차트 X축 옵션을 초기화한다.
        	if ( chartMeta.group === "PIE" ) {
        		$(".chart-types-combo option:eq(0)").remove();	// 첫번째 요소(전체) 삭제
        		
        		// X축 설정(파이유형만 있음)
        		initChartXAxisptions(data, meta.xaxes[0].srcColId);
        		
        		// 시리즈 설정
        		chartMeta.series = makePieSeries(meta, data);		

        		$(".cBasic").hide();
        		$(".cPie").show();
        		
        		selectChartEvent();
        		
        	} 
        	else {
        		// 일반유형차트 시리즈 설정
        		chartMeta.series = makeSeries(chartMeta.yAxis, meta.yaxes, data);
        		
        		// X축 카테고리 설정
        		var dataKey = chartMeta.xAxis[0].dataKey;
        		for ( var i in data ) {
        			chartMeta.xAxis[0].categories.push(String(data[i][dataKey]));
        		}
        		delete chartMeta.xAxis[0].dataKey;
        		
        		$(".cBasic").show();
        		$(".cPie").hide();
        		
        		selectChartEvent();
        	}

        	///////////// 차트 초기화 /////////////
        	initHighChart(chartMeta);
        	///////////////////////////////////////
        	
        	//추천 데이터셋을 검색한다.
            //selectRecommandDataSet();
        }
    });
    
}

/**
 * 차트 메타정보 조회 후처리
 * @param data	차트 메타정보(DB)
 * @returns
 */
function afterSelectChartMetaData(data) {
	var chartMeta = {};
	
	// 공공데이터 차트 서비스 시리즈 옵션을 초기화한다.
	if ( data.sgrpCd != "PIE" ) {
		// 일반유형 차트 타입
		initChartSeriesOptions(data.yaxes);
		chartMeta.xAxis = makeXAxis(data.xaxes);
		chartMeta.yAxis = makeYAxis(data.yaxes);
	}
	else {
		$(".chart-series-combo").hide().parent().prev().hide();
	}
    
    // 공공데이터 차트 서비스 차트유형 옵션을 초기화한다.
    initChartTypeOptions(data.types);
	
    chartMeta.legend = makeLegend(data);
	selectChartData(chartMeta, data);
	
}

/**
 * 하이차트를 초기화한다.
 * @param data	차트 메타정보
 * @returns
 */
function initHighChart(chartMeta) {
	// 차트 옵션 세팅
	highChartsOptions = getChartOptions(chartMeta);
	
	if ( highChartsOptions == null ) {
		alert("차트그룹이 정의되지 않았습니다.");
		return false;
	}
	
	highCharts = new Highcharts.chart('chart-object-sect', highChartsOptions);
	$(".highcharts-credits").hide();
}

/**
 * 차트 옵션을 세팅한다
 * @param chartMeta
 * @returns
 */
function getChartOptions(chartMeta) {
	if ( chartMeta.group === "" ) {
		//highChartsOptions = null;
		highChartsOptions = {
				plotOptions: {
					spline: { marker: { enabled: true } },
					line: { dataLabels: { enabled: false }, marker: { enabled: true } }
				}
		}
	}
	else if ( chartMeta.group === "PIE" ) {
		highChartsOptions = {
			chart: {
				//height: 500,
				plotBackgroundColor: null,
				plotBorderWidth: null,
				plotShadow: false,
				type: 'pie'
			},	
			title: { text: ''},
			plotOptions: {
				series: {
					innerSize: 0, //  --innerSize: 100,
					depth: 35,
					showInLegend: true
				}
			},
			tooltip: {
				shared: false,
				formatter: function (tooltip) {
					return "<b>" + this.point.name + "<b> : " + (com.wise.util.isNumeric(this.y) ? com.wise.util.toCommaWon(this.y) : this.y) + " " + this.point.danwi; 
				}
			},
			exporting: {enabled: false},
			legend: chartMeta.legend,
			series: chartMeta.series
		}
		
	}
	else if ( chartMeta.group === "BAR" ) {
		highChartsOptions = {
			chart: {
//				height: 400,
				zoomType: 'xy'
			},
			plotOptions: {
				spline: { marker: { enabled: false } },
				line: { dataLabels: { enabled: false }, marker: { enabled: true } },
				area: { stacking: 'normal', lineColor: '#666666', lineWidth: 1, marker: { enabled: false, lineWidth: 1, lineColor: '#666666'} }
			},
			title: { text: ''},
			tooltip: {
				shared: true,
				formatter: function () {
					return ['<b>' + this.x + '</b>'].concat(
							this.points.map(function (point) {
								return '<b>' + point.series.name + '</b> : ' 
								+ (com.wise.util.isNumeric(point.y) ? com.wise.util.toCommaWon(point.y) : point.y) 
								+ point.series.yAxis.axisTitle.textStr + "<br>";
							})
					);
				},
				split: true
			},
		    exporting: {enabled: false},
			legend: chartMeta.legend,
			xAxis: chartMeta.xAxis,
			yAxis: chartMeta.yAxis,
			series: chartMeta.series,
			responsive: {
				rules: [{
					condition: {
						maxWidth: 500
					},
					chartOptions: {
						legend: {
							floating: false,
							layout: 'horizontal',
							align: 'center',
							verticalAlign: 'bottom',
							x: 0,
							y: 0
						}
					}
				}]
			}
		};
	}
	return highChartsOptions;
}



/**
 * 차트 시리즈/타입을 변경한다
 * @param param
 * @returns
 */
function updateChartSeries(type) {
	var series = null,
		zIndex = 0,
		inverted = true,
		seriesId = "ALL";
	
	if ( !com.wise.util.isNull(highCharts) ) {
		if ( !com.wise.util.isNull(seriesId) && !com.wise.util.isNull(type) ) {
			// 유형 전체를 바꾸는경우
			if ( seriesId === "ALL" ) {
				
				//  바 차트일경우 차트 X/Y를 바꿔준다
				if ( type === 'bar' ) {
					highCharts.inverted = true;
					highCharts.tooltip.update();
				}
				else {
					highCharts.inverted = false;
					highCharts.tooltip.update();
				}				

				if(type === 'donut'){
					type = "pie";
					highCharts.update({
						plotOptions: { series: {innerSize:200} }
	                });
				}else if(type === 'pie'){
					highCharts.update({
						plotOptions: { series: {innerSize:0} }
	                });
				}
				
				
				
				
				highCharts.xAxis.forEach(function(x) { x.update({}, false); });
				highCharts.yAxis.forEach(function(y) { y.update({}, false); });
				highCharts.series.forEach(function(s) {
					s.update({ type: type });
				});
				
			}
			else {
				series = highCharts.get(seriesId);
				if ( type === "column" || type === "bar" ) {	zIndex = 0;	}
				else {											zIndex = 1; }
				
				series.update({
					type: type,
					zIndex: zIndex
				});
			}
		}
	}else{
		
	}
}

/**
 * 파이형 X축/차트유형을 변경한다.
 */
function updateChartAxis() {
	
	var data = {},
		updateData = [],
		dataKey = "",
		innerSize = 0,
		axisVal = $(".chart-xAxis-combo :selected").val(),
		type = getHighChartType($(".chart-types-combo :selected").val());
	
	if ( !com.wise.util.isNull(highCharts) ) {
		if ( !com.wise.util.isNull(axisVal) && !com.wise.util.isNull(type) ) {
			if ( type === "pieinnersize" ) 	{	innerSize = 100;}	// 도넛
			else if ( type === "pie" )		{	innerSize = 0;	}	// 파이
			
			dataKey = highChartsOptions.series[0].key;	// X축 데이터 기준 키
			
			for ( var i in chartData ) {	// DB에서 조회된 데이터(전역변수에서) 확인
				if ( chartData[i][dataKey] == axisVal ) {	
					data = chartData[i];
					break;
				}1
			}

			// 시리즈에 데이터값이 어떤 컬럼을 참조하는지 키값이 담겨있다
			for ( var i in highChartsOptions.series[0].data ) {	
				var tmpDta = data[highChartsOptions.series[0].data[i].key] || 0;
				updateData.push(tmpDta);
			}

			// 데이터 업데이트
			highCharts.series[0].setData(updateData, true);
			
			// 옵션 업데이트
			highCharts.update({
				plotOptions: {
					series: {
						innerSize: innerSize
					}
				}
			});
		}
	}
}

/**
 * 공공데이터 차트 서비스 차트유형 옵션을 초기화한다. (사용)
 * 
 * @param data {Array} 데이터
 */
function initChartTypeOptions(data) {
    var options = data;
    
    options.unshift({code: "", name: ""});
    var value = "";
    
    if (options.length > 0) {
        value = options[0].seriesCd;
    }
    // 콤보 옵션을 초기화한다.
    initComboOptions("chartType", options, value);
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
    
    options.unshift({code: "ALL", name: "전체"});
    
    var value = "";
    /*
    if (data.length > 0) {
        value = data[0].srcColId;
    }
    */
    
    // 콤보 옵션을 초기화한다.
    initComboOptions("series", options, value);
    
    if (options.length > 0) {

    }
}

function initChartXAxisptions(data, dataKey) {
	var options = [];
	
	for ( var i in data ) {
		options.push({
			code: data[i][dataKey],
			name: data[i][dataKey]
		});
	}
	
	if (options.length > 0) {
        value = data[0][dataKey];
    }
	
	initComboOptions("xAxis", options, value);
}


///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////




/**
 * 공공데이터 차트 서비스 메타정보를 조회한다.
 */
function selectChartMeta() {
    // 데이터를 조회한다.
    doSelect({
        url:"/portal/data/chart/selectChartMeta.do",
        before:beforeSelectChartMeta,
        after:afterSelectChartMeta
    });
}

/**
 * 공공데이터 차트 서비스 데이터를 검색한다.
 */
function searchChartData() {
    // 공공데이터 차트 서비스 검색 필터를 검증한다.
    if (!checkSearchFilters("chart-search-table")) {
        return;
    }
    
    // 데이터를 검색한다.
    doSearch({
        url:"/portal/data/chart/searchChartData.do",
        before:beforeSearchChartData,
        after:afterSearchChartData
    });
}

/**
 * 공공데이터 차트 서비스 데이터를 다운로드한다.
 * 
 * @param type {String} 유형
 */
function downloadChartData(type) {
    // 공공데이터 차트 서비스 검색 필터를 검증한다.
    if (!checkSearchFilters("chart-search-table")) {
        return;
    }
    
    if (type == "E" && total > 10000) {
        alert("데이터 양이 많은 경우에는 엑셀저장이 제한됩니다. CSV로 받아 주시기 바랍니다.");
        return;
    }
    var form = $('#chart-search-form');
    form.find("[name=downloadType]").val(type);
    
    var downloadUrl = "/portal/data/chart/downloadChartData.do?"+form.serialize();
    $.fileDownload(downloadUrl);
    return false;
}

/**
 * 공공데이터 데이터셋 전체목록을 검색한다.
 */
function searchDataset() {
    // 데이터를 검색하는 화면으로 이동한다.
    /*
	goSearch({
        url:"/portal/data/dataset/searchDatasetPage.do",
        form:"dataset-search-form"
    });*/
	goSearch({
		url:"/portal/infs/list/infsListPage.do",
		form:"searchForm",
		method: "post"
	});
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
 * 공공데이터 차트 서비스 검색 필터를 추가한다.
 * 
 * @param filters {Array} 필터
 */
function addChartSearchFilters(filters) {
    if (filters.length > 0) {
        $("#chart-search-sect").removeClass("hide");
    }
    var form = $('#chart-search-form');
    var sigunFlag = form.find("[name=sigunFlag]").val();

    // 검색 필터를 추가한다.
    addSearchFilters("chart-search-table", filters, {
        idPrefix:"chart-filter-",
        idKey:"srcColId",
        onKeyDown:searchChartData
    }, sigunFlag);
}

////////////////////////////////////////////////////////////////////////////////
// 전처리 함수
////////////////////////////////////////////////////////////////////////////////
/**
 * 공공데이터 차트 서비스 메타정보 조회 전처리를 실행한다.
 * 
 * @param options {Object} 옵션
 * @returns {Object} 데이터
 */
function beforeSelectChartMeta(options) {
    var data = {
        // Nothing do do.
    };
    
    var form = $("#chart-search-form");
    var form2 = $("#dataset-search-form");
    var id = form2.find("input[name=infId]").val() || form.find("input[name=infId]").val();
    var seq = form2.find("input[name=infSeq]").val() || form.find("input[name=infSeq]").val();
    
    form.find("input[name=infId]").val(id);
    form.find("input[name=infSeq]").val(seq);
    
    $.each(form.serializeArray(), function(index, element) {
        switch (element.name) {
            case "infId":
            case "infSeq":
                data[element.name] = element.value;
                break;
        }
    });
    
    if (com.wise.util.isBlank(data.infId)) {
        return null;
    }
    if (com.wise.util.isBlank(data.infSeq)) {
        return null;
    }
    
    return data;
}

/**
 * 공공데이터 차트 서비스 데이터 검색 전처리를 실행한다.
 * 
 * @param options {Object} 옵션
 * @returns {Object} 데이터
 */
function beforeSearchChartData(options) {
    var data = {
        // Nothing do do.
    };
    
    var form = $("#chart-search-form");
    
    $.each(form.serializeArray(), function(index, element) {
        switch (element.name) {
            case "downloadType":
            case "colNm":
            case "seriesCd":
                break;
            case "infId":
            case "infSeq":
                data[element.name] = element.value;
                break;
            default:
                if (data[element.name] == null) {
                    data[element.name] = [];
                }
                
                data[element.name][data[element.name].length] = element.value;
                break;
        }
    });
    
    if (com.wise.util.isBlank(data.infId)) {
        return null;
    }
    if (com.wise.util.isBlank(data.infSeq)) {
        return null;
    }
    
    return data;
}

////////////////////////////////////////////////////////////////////////////////
// 후처리 함수
////////////////////////////////////////////////////////////////////////////////
/**
 * 공공데이터 차트 서비스 메타정보 조회 후처리를 실행한다.
 * 
 * @param data {Object} 데이터
 */
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
        ElementId:"chart-object-sect",
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
    
    // 공공데이터 차트 서비스 검색 필터를 추가한다.
    addChartSearchFilters(data.filters);
    
    // 공공데이터 차트 서비스 데이터를 검색한다.
    searchChartData();
}

/**
 * 공공데이터 차트 서비스 데이터 검색 후처리를 실행한다.
 * 
 * @param data {Object} 데이터
 */
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
    

    //----------------------------신익진 임시 수정 ------------ 차트화면 로드시 범례 표시 안되는경우 -------Start
    changeChartType();
    //----------------------------신익진 임시 수정 ------------ 차트화면 로드시 범례 표시 안되는경우 -------End
    
    //추천 데이터셋을 검색한다.
    selectRecommandDataSet();
}

/////////////// 추천
function selectRecommandDataSet() {
	doSelect({
        url:"/portal/data/sheet/selectRecommandDataSet.do",
        before:beforeSelectRecommandDataSet,
        after:afterSelectRecommandDataSet
    });
}

function beforeSelectRecommandDataSet(options) {
    var data = {
        // Nothing do do.
    };
    
    var form = $("#sheet-search-form");
    
    data["objId"] = form.find("#infId").val() || $("#searchForm [name=infId]").val();
   
    if (com.wise.util.isBlank(data.objId)) {
        return null;
    }
    
    return data;
}

/**
 * 연관 데이터셋 검색 후처리를 실행한다.
 * 
 * @param data {Object} 데이터
 */
function afterSelectRecommandDataSet(data) {
	  var table = $(".bxslider");
	//  var infsq = 1;
	  
	//데이터가 없다면
	  if (data.length == 0) {
		 $(".recommendDataset").remove();
	  }
	  for (var i = 0; i < data.length; i++) {
	      var row = $(templates2.data);
	     
	      table.append(row);
  
	     
	      if (data[i].metaImagFileNm || data[i].saveFileNm) {
	            var url = com.wise.help.url("/portal/data/dataset/selectThumbnail.do");
	            url += "?infId=" + data[i].objId;
//	            url += "?seq="            + data[i].seq;
//	            url += "&metaImagFileNm=" + (data[i].metaImagFileNm ? data[i].metaImagFileNm : "");
	            url += "&cateSaveFileNm=" + (data[i].saveFileNm ? data[i].saveFileNm : "");

	            row.find(".metaImagFileNm").attr("src", url);
				//row.find(".metaImagFileNm").attr("alt", data[i].objNm);
	      }
	      
	      row.find("span").eq(1).text(data[i].objNm);
	      row.find(".m_cate").text(data[i].topCateNm);
	      row.find(".infsTag").text(data[i].opentyTagNm);
	      
	      row.each(function(index, element) {
	            // 서비스 링크에 클릭 이벤트를 바인딩한다.   	  
	            $(this).bind("click", {
	                objId:data[i].objId,
	                opentyTag:data[i].opentyTag
	            }, function(event) {
	                // 공공데이터 서비스를 조회한다.
//	            	recoService(event.data);
	            	moveToRecommendDataset(event.data);
	                return false;
	            });
	            
	            // 서비스 링크에 키다운 이벤트를 바인딩한다.
	            $(this).bind("keydown", {
	                objId:data[i].objId,
	                opentyTag:data[i].opentyTag
	            }, function(event) {
	                if (event.which == 13) {
	                    // 공공데이터 서비스를 조회한다.
//	                	recoService(event.data);
	                	moveToRecommendDataset(event.data);
	                    return false;
	                }
	            });
	        });
	  	      
	  }
	  
	  var ww = ($('.recommendDataset').width()-75) / 4;
	  setTimeout(dataset, 700, ww);
	
	  function dataset(ww) {
		  dataSet = $('.dataSetSlider').bxSlider({
				mode : 'horizontal',
				speed : 500,
				moveSlider : 1,
				autoHover : true,
				controls : false,
				slideMargin : 0,
				startSlide : 0,
				slideWidth: ww,
				minSlides: 1,
				maxSlides: 4,
				moveSlides: 1
			});

			$( '#dataset_prev' ).on( 'click', function () {
				dataSet.goToPrevSlide();  //이전 슬라이드 배너로 이동
				return false;              //<a>에 링크 차단
			} );
			
			$( '#dataset_next' ).on( 'click', function () {
				dataSet.goToNextSlide();  //다음 슬라이드 배너로 이동
				return false;
			} );
			
			
			$('.dataSet ul.dataSetSlider li a').on('focus', function(){
				$('.dataSet').addClass('focus');
			});
			
			$('.dataSet ul.dataSetSlider li a').on('focusout', function(){
				$('.dataSet').removeClass('focus');
			});
	  }
}

/**
 * 연관(추천) 데이터셋으로 이동한다.
 * @param data
 * @returns
 */
function moveToRecommendDataset(data) {
	var obj = getOpentyTagData(data);
	
	$("#searchForm").append("<input type=\"hidden\" id=\""+obj.id+"\" name=\""+obj.id+"\" value=\""+data.objId+"\" />");
	
	goSelect({
		url: obj.url,
        form:"searchForm",
        method: "post"
    });
	
	function getOpentyTagData(data) {
		var obj = {};
		
		switch ( data.opentyTag ) {
		case "D":
			obj.url = "/portal/doc/docInfPage.do/" + data.objId;
			obj.id = "docId";
			obj.gubun = "seq";
			break;
		case "O":
			obj.url = "/portal/data/service/selectServicePage.do/" + data.objId;
			obj.id = "infId";
			obj.gubun = "infSeq";
			break;
		case "S":
			obj.url = "/portal/stat/selectServicePage.do/" + data.objId;
			obj.id = "statblId";
			obj.gubun = "";
			break;
		}
		return obj
	}
}

function recoService(data) {
    // 데이터를 조회하는 화면으로 이동한다.
    goSelect({
        url:"/portal/data/service/selectServicePage.do",
        form:"chart-search-form",
        data:[{
            name:"infId",
            value:data.infId
        }
        , {
            name:"infSeq",
            value:data.infSeq
        }
        ]
    });
}

////////////////////////////////////////////////////////////////////////////////
// 이벤트 함수
////////////////////////////////////////////////////////////////////////////////
function selectChartEvent(){
	var formObj = $("#chart-search-form");
	// 기본차트
	formObj.find("button[name=chartBasic]").bind("click", function(event) {
		updateChartSeries("");
		chartButtonReset("charbtn19");
	});
	
	//버튼선택에 따른 초기화
	function chartButtonReset(selNum){
		formObj.find($(".toparea")).find("button").each(function(event){
			var imgSrc = $(this).children("img").attr("src");
			if (imgSrc.indexOf("on.png") != -1 && imgSrc.indexOf("01") == -1) {
				$(this).children("img").attr("src", imgSrc.replace("on", ""));
			}
			
			if (imgSrc.indexOf(selNum) != -1){
				$(this).children("img").attr("src", "/images/soportal/chart/"+selNum+"on.png");
			}
		});
	}
	
	// 곡선
	formObj.find("button[name=chartSpline]").bind("click", function(event) {
		updateChartSeries("spline");
		chartButtonReset("charbtn04");
	});
	// 꺽은선
	formObj.find("button[name=chartLine]").bind("click", function(event) {
		updateChartSeries("line");
		chartButtonReset("charbtn05");
	});
	// 누적영역
	formObj.find("button[name=chartArea]").bind("click",	function(event) {
		updateChartSeries("area");
		chartButtonReset("charbtn06");
	});
	// 막대
	formObj.find("button[name=chartHbar]").bind("click", function(event) {
		updateChartSeries("column");
		chartButtonReset("charbtn07");
	});
	// 가로막대
	formObj.find("button[name=chartWbar]").bind("click", function(event) {
		updateChartSeries("bar");
		chartButtonReset("charbtn10");
	});
	// 차트 다운로드 버튼
	formObj.find("button[name=chartDownload]").bind("click", function(event) {
		
		var chartId = formObj.find($(".chart.statEasyChart")).attr('id');
		if (!formObj.find($('.chart')).hasClass('down')) {
			formObj.find($('.chart')).addClass('down');
			formObj.find($('.dropdown-content')).show();
		} else {
			formObj.find($('.chart')).removeClass('down');
			formObj.find($('.dropdown-content')).hide();
		}
	});
	// 차트 다운로드 버튼 -> chartPng
	formObj.find("a[name=chartPng]").bind("click", function(event) {
		highCharts.exportChart({
			type : 'image/png',
			filename : 'nasna-png'
		});
	});
	// 차트 다운로드 버튼 -> chartJpeg
	formObj.find("a[name=chartJpeg]").bind("click", function(event) {
		highCharts.exportChart({
			type : 'image/jpeg',
			filename : 'nasna-jpeg'
		});
	});
	// 차트 다운로드 버튼 -> chartPdf
	formObj.find("a[name=chartPdf]").bind("click", function(event) {
		highCharts.exportChart({
			type : 'application/pdf',
			filename : 'nasna-pdf'
		});
	});
	// 차트 다운로드 버튼 -> chartSvg
	formObj.find("a[name=chartSvg]").bind("click", function(event) {
		highCharts.exportChart({
			type : 'image/svg+xml',
			filename : 'nasna-svg'
		});
	});
	
	// 파이
	formObj.find("button[name=chartPie]").bind("click", function(event) {
		updateChartSeries("pie");
		chartButtonReset("charbtn13");
	});
	// 도넛
	formObj.find("button[name=chartDonut]").bind("click", function(event) {
		updateChartSeries("donut");
		chartButtonReset("charbtn14");
	});
	
}