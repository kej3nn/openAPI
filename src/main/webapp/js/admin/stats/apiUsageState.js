/*
 * @(#)apiUsageState.js 1.0 2020/10/14
 */

/**
 * 관리자 API 호출 현황 스크립트 파일이다
 *
 * @author WISE
 * @version 1.0 2020/09/14
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


////////////////////////////////////////////////////////////////////////////////
// 초기화 함수
////////////////////////////////////////////////////////////////////////////////
/**
 * 컴포넌트를 초기화한다.
 */
function initComp() {
	$("input[name=startYmd], input[name=endYmd]").datepicker(com.wise.help.datepicker({
        buttonImage:com.wise.help.url("/images/admin/icon_calendar.png"),
        dateFormat: "yy-mm" 
    }));
	
	//$('input[name=startYmd]').datepicker('option', 'onClose',  function( selectedDate ) {$("input[name=endYmd]").datepicker( "option", "minDate", selectedDate );});
	//$('input[name=endYmd]').datepicker('option', 'onClose',  function( selectedDate ) {	$("input[name=startYmd]").datepicker( "option", "maxDate", selectedDate );});
	
	$("input[name=startYmd]").val(today(-1));
	$("input[name=endYmd]").val(today());	
	
	loadSheet();
	
}

/**
 * 마스크를 바인딩한다.
 */
function bindMask() {
}

/**
 * 이벤트를 바인딩한다.
 */
function bindEvent() {
	$("button[name=btn_inquiry]").bind("click", function(event) {
		doAction("search");
    });
	$("button[name=btn_xlsDown]").bind("click", function(event) {
		doAction("excel");
    });
}


/**
 * 옵션을 로드한다.
 */
function loadOptions() {
}

/**
 * 데이터를 로드한다.
 */
function loadData() {
	doAction("search");
}

////////////////////////////////////////////////////////////////////////////////
// 서비스 함수
////////////////////////////////////////////////////////////////////////////////

/**
 * 화면 액션
 */
function doAction(sAction) {

	switch(sAction) {                       
		case "search":
		
			ajaxBeforeSendAdmin(com.wise.help.url("/admin/ajaxBeforeSendAdmin.do")); //IbSheet 조회전 세션 체크
			var param = {PageParam: "page", Param: "rows=50"+"&"+$("form[name=statOpen]").serialize()};
			sheet.DoSearchPaging(com.wise.help.url("/admin/stat/apiUsageStateList.do"), param);
			//차트 조회
			ajaxCallAdmin(com.wise.help.url("/admin/stat/apiUsageStateGraph.do"),$("form[name=statOpen]").serialize(),initializeChart);

			break;
		case "excel":
			sheet.Down2Excel({FileName:'Excel.xls',SheetName:'sheet'});
			break;
		
	}
}

function today(year){
	var year = year || 0;
    var date = new Date();

    var year  = date.getFullYear() + year;
    var month = date.getMonth() + 1; // 0부터 시작하므로 1더함 더함
    var day   = date.getDate();

    if (("" + month).length == 1) { month = "0" + month; }
    //if (("" + day).length   == 1) { day   = "0" + day;   }
   
    //return "" + year + "-" + month + "-" + day; 
    return "" + year + "-" + month ; 
    
}


////////////////////////////////////////////////////////////////////////////////
// 전처리 함수
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// 후처리 함수
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
//시트 로드
////////////////////////////////////////////////////////////////////////////////
function loadSheet() {
	
	createIBSheet2(document.getElementById("sheet"),"sheet", "100%", "600px");
	
	var gridTitle ="NO";
	gridTitle +="|기준월";
	gridTitle +="|사용자수";
	gridTitle +="|공공데이터수";
	gridTitle +="|호출수";
	gridTitle +="|데이터행수";
	gridTitle +="|오류수";
	gridTitle +="|XML 변환수";
	gridTitle +="|JSON 변환수";
	gridTitle +="|평균응답시간";
	gridTitle +="|DB크기";
	gridTitle +="|전송출력크기";
	
	
	with(sheet){
		                     
		/*var cfg = {SearchMode:2,Page:50,VScrollMode:1}; */
		var cfg = {SearchMode:3,Page:50,VScrollMode:1};  
	    SetConfig(cfg);
	    var headers = [
	                {Text:gridTitle, Align:"Center"}
	            ];
	    var headerInfo = {Sort:0,ColMove:1,ColResize:1,HeaderCheck:0};
	    
	    InitHeaders(headers, headerInfo);
	   
	    var cols = [
	                 {Type:"Seq",		SaveName:"seq",				Width:50,	Align:"Center",		Edit:false}
	                ,{Type:"Text",		SaveName:"yyyymm",			Width:100,	Align:"Center",		Edit:false, Format:"Ym" }
					,{Type:"Text",	    SaveName:"userCnt",		    Width:100,	Align:"Center",		Edit:false}
					,{Type:"Text",	    SaveName:"infCnt",		    Width:100,	Align:"Center",		Edit:false}
					,{Type:"Text",	    SaveName:"callCnt",		    Width:100,	Align:"Center",		Edit:false}
					,{Type:"Text",	    SaveName:"rowCnt",		    Width:100,	Align:"Center",		Edit:false}
					,{Type:"Text",	    SaveName:"errCnt",		    Width:100,	Align:"Center",		Edit:false}
					,{Type:"Text",	    SaveName:"xmlCnt",		    Width:100,	Align:"Center",		Edit:false}
					,{Type:"Text",	    SaveName:"jsonCnt",		    Width:100,	Align:"Center",		Edit:false}
					,{Type:"Text",	    SaveName:"avgLt",		    Width:100,	Align:"Center",		Edit:false}
					,{Type:"Text",	    SaveName:"dbSize",		    Width:100,	Align:"Center",		Edit:false}
					,{Type:"Text",	    SaveName:"outSize",		    Width:100,	Align:"Center",		Edit:false}
					
				];
	    
	    InitColumns(cols);
	    FitColWidth();
	    SetExtendLastCol(1);
	   
	    
	}               
	default_sheet(sheet);   
	
}

function sheet_OnSearchEnd(code, message, statusCode, statusMessage) {
	
}

function initializeChart(data){    
	//mainChart.RemoveAll();
	afterStatUsageStateChart(data);	// 차트 생성 및 추가
} 

function afterStatUsageStateChart(result) {

Highcharts.setOptions({
    lang: {
        thousandsSep: ","
    }
    , exporting: {
        menuItemDefinitions: {
            printChart: {
                text: "차트 인쇄",
                onclick: function () {
                    this.print();
                }
            },
            downloadPNG: {
                text: "다운로드 PNG",
                onclick: function () {
                    this.exportChart();
                }
            }
            , downloadJPEG: {
                text: "다운로드 JPG",
                onclick: function () {
                    this.exportChart({
                        type: 'image/jpeg'
                    });
                }
            }
            , downloadPDF: {
                text: "다운로드 PDF",
                onclick: function () {
                    this.exportChart({
                        type: 'application/pdf'
                    });
                }
            }
            , downloadSVG: {
                text: "다운로드 SVG",
                onclick: function () {
                    this.exportChart({
                        type: 'image/svg+xml'
                    });
                }
            }
        },
        buttons: {
            contextButton: {
                menuItems: ["printChart", "separator", "downloadPNG", "downloadJPEG", "downloadPDF", "downloadSVG"]
            }
        }
    }
});

	var Columns = [];
	var Rows = [];
	// x축 레이블과 데이터 값 배열
	const categories = [];
	const usersData = [];
	const infsData = [];
	const callsData = [];
	const rowsData = [];
	const errsData = [];
	const xmlData = [];
	const jsonData = [];
	const rowsizeData = [];
	const dbData = [];
	const outData = [];
	const avgltData = [];
	
	
	$.each(result.data.reverse(), function(index, item){
	  categories.push(item.yyyymm); // x축 레이블에 월 추가
	  usersData.push(item.userCnt); // 데이터 값 배열에 사용자 수 추가
	  infsData.push(item.infCnt);
	  callsData.push(item.callCnt);
	  rowsData.push(item.rowCnt);
	  errsData.push(item.errCnt);
	  xmlData.push(item.xmlCnt);
	  jsonData.push(item.jsonCnt);
	  rowsizeData.push(item.rowCnt);
	  dbData.push(item.dbSize);
	  outData.push(item.outSize);
	  avgltData.push(item.avgLt);
	});
	
	
	const callsSum = callsData.reduce((acc, curr) => acc + curr, 0); // callsData 배열의 모든 요소를 더함
	const errsSum = errsData.reduce((acc, curr) => acc + curr, 0); // errsData 배열의 모든 요소를 더함
	const xmlSum = xmlData.reduce((acc, curr) => acc + curr, 0); // errsData 배열의 모든 요소를 더함
	const jsonSum = jsonData.reduce((acc, curr) => acc + curr, 0); // errsData 배열의 모든 요소를 더함
	


Highcharts.chart('mainChart', {
	colors: ['#08216E']
	,
	credits: {
        enabled: false
    },
    title: {
        text: '사용자수 현황',
        align: 'center'
    },
    xAxis: {
        categories: categories,
        dateFormat: "YYYY/mm"
    },
    yAxis: [{
    title:{
    	text: undefined
    	}
    }, 
    ],
    tooltip: {
        valueSuffix: ' 명'
    },
    plotOptions: {
        series: {
            borderRadius: '25%',
            dataLabels: {
                enabled: true
            },
        }
    },
    series: [{
        type: 'column',
        name: '사용자수',
        data: usersData
    }]
});

Highcharts.chart('mainChart2', {
	colors: ['#395DB2']
	,
	credits: {
        enabled: false
    },
    title: {
        text: '공공데이터수 현황',
        align: 'center'
    },
    xAxis: {
        categories: categories,
        dateFormat: "YYYY/mm"
    },
    yAxis: [{
    title:{
    	text: undefined
    	}
    }, 
    ],
    tooltip: {
        valueSuffix: ' 회'
    },
    plotOptions: {
        series: {
            borderRadius: '25%',
            dataLabels: {
                enabled: true
            },
        }
    },
    series: [{
        type: 'column',
        name: '공공데이터수',
        data: infsData
    }]
});


Highcharts.chart('mainChart3', {
	colors: ['#26837B','#FF6E33'],
	credits: {
        enabled: false
    },
    title: {
        text: '호출수 현황',
        align: 'center'
    },
    xAxis: {
        categories: categories,
        dateFormat: "YYYY/mm"
    },
    yAxis: [{
    title:{
    	text: '호출수'
    	}
    }, 
    {
        title: {
            text: '오류수'
        },
        max:60000,
        opposite: true
    }
    ],
    tooltip: {
        valueSuffix: ' 회'
    },
    plotOptions: {
        series: {
            borderRadius: '25%',
            turboThreshold:5000,
            dataLabels: {
                enabled: true
            },
        }
    },
    series: [{
        type: 'column',
        name: '호출수',
        data: callsData
    },
    {
        type: 'line',
        name: '오류수',
        data: errsData,
		color: '#d33730',
        yAxis : 1
    },
    ]
});

Highcharts.chart('mainChart4', {
	colors: ['#26837B','#FF6E33']
	,
	credits: {
        enabled: false
    },
    chart: {
        type: 'pie'
    },
    title: {
        text: '호출수/오류수 비율'
    },
    tooltip: {
        valueSuffix: '회'
    },
    plotOptions: {
        series: {
            allowPointSelect: true,
            cursor: 'pointer',
            dataLabels: [{
                enabled: true,
                distance: 20
            }, {
                enabled: true,
                distance: -40,
                format: '{point.percentage:.2f}%',
                style: {
                    fontSize: '1.2em',
                    textOutline: 'none',
                    opacity: 0.7
                },
                filter: {
                    operator: '>',
                    property: 'percentage',
                    value: 10
                }
            }]
        }
    },
    series: [
        {
            name: '횟수',
            colorByPoint: true,
            data: [
                {
                    name: '호출수',
                    y: callsSum
                },
                {
                    name: '오류수',
                    sliced: true,
                    selected: true,
                    y: errsSum
                }
            ]
        }
    ]
});

Highcharts.chart('mainChart5', {
	colors: ['#395DB2','#08216E']
	,
	credits: {
        enabled: false
    },
    title: {
        text: 'XML 변환수, JSON 변환수',
        align: 'center'
    },
    xAxis: {
        categories: categories,
        dateFormat: "YYYY/mm"
    },
    yAxis: [{
    title:{
    	text: undefined
    	}
    }, 
    ],
    tooltip: {
        valueSuffix: ' 회'
    },
    plotOptions: {
        series: {
            borderRadius: '25%',
            dataLabels: {
                enabled: true
            },
        }
    },
    series: [{
        type: 'column',
        name: 'XML 변환수',
        data: xmlData
    },
    {
        type: 'column',
        name: 'JSON 변환수',
        data: jsonData
    }
    ]
});

Highcharts.chart('mainChart6', {
	colors: ['#395DB2','#08216E']
	,
	credits: {
        enabled: false
    },
    chart: {
        type: 'pie'
    },
    title: {
        text: 'XML 변환수/JSON 변환수 비율'
    },
    tooltip: {
        valueSuffix: '회'
    },
    plotOptions: {
        series: {
            allowPointSelect: true,
            cursor: 'pointer',
            dataLabels: [{
                enabled: true,
                distance: 20
            }, {
                enabled: true,
                distance: -40,
                format: '{point.percentage:.1f}%',
                style: {
                    fontSize: '1.2em',
                    textOutline: 'none',
                    opacity: 0.7
                },
                filter: {
                    operator: '>',
                    property: 'percentage',
                    value: 10
                }
            }]
        }
    },
    series: [
        {
            name: '변환수',
            colorByPoint: true,
            data: [
                {
                    name: 'XML 변환수',
                    y: xmlSum
                },
                {
                    name: 'JSON 변환수',
                    sliced: true,
                    selected: true,
                    y: jsonSum
                }
            ]
        }
    ]
});

Highcharts.chart('mainChart7', {
	colors:['#395DB2','#08216E','#FF6E33'],
	credits: {
        enabled: false
    },
    title: {
        text: '데이터행수, DB크기, 전송출력크기',
        align: 'center'
    },
    xAxis: {
        categories: categories,
        dateFormat: "YYYY/mm"
    },
    yAxis: [{
    title:{
    	text: undefined
    	},
    	opposite: true
    }, 
    {
    title:{
    	text: '데이터행수'
    },
    	opposite: true
    }
    ],
    tooltip: {
        valueSuffix: ' 회'
    },
	plotOptions: {
	    series: {
	        dataLabels: {
	            enabled: true,
	            formatter: function() {
	                // 값이 10억 이상인 경우
	                if (this.y >= 1000000000) {
	                    // B로 표시
	                    return Highcharts.numberFormat(this.y / 1000000000, 1) + 'B';
	                }
	                // 값이 100만 이상인 경우
	                else if (this.y >= 1000000) {
	                    // 소수점 두 자리 유지하고 M으로 표시
	                    return Highcharts.numberFormat(this.y / 1000000, 1) + 'M';
	                }
	                // 그 외의 경우
	                else {
	                    return this.y;
	                }
	            }
	        }
	    }
	},
    series: [
    {
        type: 'column',
        name: 'DB크기',
        data: dbData,
        yAxis : 1
    },
    {
        type: 'column',
        name: '전송출력크기',
        data: outData,
        yAxis : 1
    }
    ,
    {
        type: 'line',
        name: '데이터행수',
        data: rowsizeData,
        yAxis : 0
    }
    ]
});

Highcharts.chart('mainChart8', {
	colors:['#395DB2','#08216E','#FF6E33'],
	credits: {
        enabled: false
    },
    title: {
        text: '평균응답시간',
        align: 'center'
    },
    xAxis: {
        categories: categories,
        dateFormat: "YYYY/mm"
    },
    yAxis: [{
    title:{
    	text: undefined
    	}
    }, 
    ],
    tooltip: {
        valueSuffix: ' 초'
    },
    plotOptions: {
        series: {
            borderRadius: '25%',
            dataLabels: {
                enabled: true
            },
        }
    },
    series: [{
        type: 'line',
        name: '평균응답시간',
        data: avgltData
    }]
});
}