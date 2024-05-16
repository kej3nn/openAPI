/**
 * 국회의원 차트 관련 스크립트 파일이다.
 * 
 * @author SBCHOI
 * @version 1.0 2019/10/24
 */

////////////////////////////////////////////////////////////////////////////////
// SCRIPT INIT
////////////////////////////////////////////////////////////////////////////////
$(function() {

	// 이벤트를 바인딩한다.
	bindEvent();
	
	// 데이터를 조회한다.
	loadData();
});


/**
 * 데이터를 조회한다.
 */
function loadData() {
	
	//트리맵 데이터 조회(정당별)
	//selectTreeMapData();
	
	//컬럼데이터 조회(당선횟수별)
	selectColumnReeleData();
	
	//파이 데이터 조회(성별)
	selectPieData();
	
	//컬럼데이터 조회(연령별)
	selectColumnAgeData();
	
	//아이템차트 데이터 조회(정당별)
	selectParliamentData();
}


/**
 * 이벤트를 바인딩한다.
 * @returns
 */
function bindEvent() {
	//팝업창 닫기
	$("#btn_close").bind("click", function(event) {
		window.close();
	});
}

/** 
 * TreeMap 데이터 조회
* @returns
*/
function selectTreeMapData() {
	doAjax({
		url: "/portal/theme/visual/selectTreeMapData.do",
		callback: function(res) {
			var data = res.data;
			loadTreeMapChart(data);
		}
	});
}

/** 
 * Column 데이터 조회(당선횟수별)
* @returns
*/
function selectColumnReeleData() {
	doAjax({
		url: "/portal/theme/visual/selectColumnReeleData.do",
		callback: function(res) {
			var data = res.data;
			loadColumnReeleChart(data);
		}
	});
}

/** 
 * 파이 데이터 조회
* @returns
*/
function selectPieData() {
	doAjax({
		url: "/portal/theme/visual/selectPieData.do",
		callback: function(res) {
			var data = res.data;
			loadPieChart(data);
		}
	});
}

/** 
 * 컬럼 데이터 조회(연령별)
* @returns
*/
function selectColumnAgeData() {
	doAjax({
		url: "/portal/theme/visual/selectColumnAgeData.do",
		callback: function(res) {
			var data = res.data;
			loadColumnAgeChart(data);
		}
	});
}

/** 
 * Parliamen차트 데이터 조회
* @returns
*/
function selectParliamentData() {
	doAjax({
		url: "/portal/theme/visual/selectParliamentData.do",
		callback: function(res) {
			var data = res.data;
			loadParliamenChart(data);
		}
	});
}

/**
 * 트리맵 차트 로드
 * @param data	
 * @returns
 */
function loadTreeMapChart(data) {
	var chart = Highcharts.chart('chartTreeMapContainer', {
		series: [{
	        type: 'treemap',
	        layoutAlgorithm: 'squarified',
	        data: data,
	        dataLabels: {
	        	enabled: true,
			    formatter: function() {
			    	var key = this.key,
           			point = this.point,
           			value = point.value;
         			return value && point ? key + ': ' + value +'명': key;
         			}
	    		}
	    }],
	    title: {
	        text: ''
	    },
	    plotOptions: {
            series: {
                cursor: 'pointer',
                point: {
                    events: {
                        click: function () {
                             var name = this.name;
                        	goMemberSchPage(name);
                        }
                    }
                }
            }
        },
	    credits: {enabled: false},
	    exporting: {enabled: false}
	    
	});
}

/**
 * 컬럼 차트 로드
 * @param data	
 * @returns
 */
function loadColumnReeleChart(data) {
	var chart = Highcharts.chart('chartColumnContainer', {
		chart: {
			type: 'column'
		},
		title: {
			text: ''
		},
		credits: {
			enabled: false
		},
		exporting: {enabled: false},
		xAxis: {
			type: 'category',
			title: {
				text: ''
			}
		},
		yAxis: {
			tickInterval: 10,
			title: {
				text: ''
			}
		},
		legend: {
			enabled: false
		},
		tooltip: {
			pointFormat: '<b>{point.y} </b>'
		},
		plotOptions: {
            series: {
                cursor: 'pointer',
                point: {
                    events: {
                        click: function () {
                             var name = this.name;
                             goMemberSchPage(name);
                        }
                    }
                }
            }
        },
		series: [{
			name: '',
			color: '#8EC3A7',
			data: data,
			dataLabels: {
				enabled: true,
				format: '{point.y}명'

			}
		}]
	});
}

/**
 * 파이 차트 로드
 * @param data	
 * @returns
 */
function loadPieChart(data) {
	var chart = Highcharts.chart('chartPieContainer', {
		chart: {
	        plotBackgroundColor: null,
	        plotBorderWidth: null,
	        plotShadow: false,
	        type: 'pie'
	    },
	    
	    title: {
	        text: ''
	    },
	    tooltip: {
	        pointFormat: '{series.name}: <b>{point.y}명({point.percentage:.1f}%)</b>'
	    },
	    plotOptions: {
	        pie: {
	            allowPointSelect: true,
	            cursor: 'pointer',
	            point: {
                    events: {
                        click: function () {
                             var name = this.name;
                             goMemberSchPage(name);
                        }
                    }
                },
	            dataLabels: {
	                enabled: true,
	                format: '<span style="color:{point.color}">● </span><span>{point.name}</span>: <b>{point.y}명({point.percentage:.1f}%)</b><br>'
	            },
	            showInLegend: true
	        }
	    },
	    series: [{
	        name: '인원',
	        colorByPoint: true,
	        data: data
	    }],
	    credits: {enabled: false},
	    exporting: {enabled: false}
	});
}

/**
 * 컬럼 차트 로드(연령별)
 * @param data	
 * @returns
 */
function loadColumnAgeChart(data) {
	var chart = Highcharts.chart('chartColumnAgeContainer', {
		chart: {
			type: 'column'
		},
		title: {
			text: ''
		},
		credits: {
			enabled: false
		},
		exporting: {enabled: false},
		plotOptions: {
            series: {
                cursor: 'pointer',
                point: {
                    events: {
                        click: function () {
                             var name = this.name;
                             goMemberSchPage(name);
                        }
                    }
                }
            }
        },
		xAxis: {
			type: 'category',
			title: {
				text: ''
			}
		},
		yAxis: {
			tickInterval: 10,
			title: {
				text: ''
			}
		},
		legend: {
			enabled: false
		},
		tooltip: {
			pointFormat: '<b>{point.y} </b>'
		},
		series: [{
			name: '',
			data: data,
			dataLabels: {
				enabled: true,
				format: '{point.y}명'

			}
		}]
	});
}

/**
 * Parliamen차트 데이터 조회 로드
 * @param data	
 * @returns
 */
function loadParliamenChart(data) {
	
	var chart = Highcharts.chart('chartParliamenContainer', {
		chart: {
			type: 'item'
		},

	    title: {
	        text: ''
	    },
	    legend: {
	        labelFormat: '{name} <span style="opacity: 0.4">{y}</span>'
	    },
	    plotOptions: {
            series: {
                cursor: 'pointer',
                point: {
                    events: {
                        click: function () {
                             var name = this.name;
                             goMemberSchPage(name);
                        }
                    }
                }
            }
        },
	    series: [{
	    	name: '인원',
	        data: data,
	        dataLabels: {
	        	enabled: false,
	            format: '{point.label}'
	        },
	        center: ['50%', '88%'],
	        size: '170%',
	        startAngle: -100,
	        endAngle: 100
	    }],
	    credits: {enabled: false},
	    exporting: {enabled: false}
	});
}

function goMemberSchPage(name){
	
	//초기화
	$("input[name=name]").val("");
	 
	var form = $("form[name=searchForm]");
	 
    $("input[name=name]").val(name);
	
	
	//청구서(팝업) 조회 페이지 이동
	form.attr("action", com.wise.help.url("/portal/assm/search/memberSchPage.do"));
	form.attr("target", "_blank");
	form.submit();
}