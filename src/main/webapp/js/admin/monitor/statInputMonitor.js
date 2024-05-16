/*
 * @(#)docInfMgmt.js 1.0 2019/08/05
 */

/**
 * 관리자에서 연계모니터링 스크립트
 *
 * @author JSSON
 * @version 1.0 2019/10/01
 */
$(function() {
    // 컴포넌트를 초기화한다.
    initComp();
    
    // 이벤트를 바인딩한다.
    bindEvent();
    
    // 옵션을 로드한다.
    loadOptions();
    
    // 데이터를 로드한다.
    loadData();
});

/**
 * 이벤트를 바인딩한다.
 */
function bindEvent() {
	// 메인화면 이벤트 처리
	bindEventMain();
}

/**
 * 컴포넌트를 초기화한다.
 */
function initComp() {
	loadMainPage();
}

/**
 * 데이터를 로드한다.
 */
function loadData() {
	doActionMain("search");
}

/**
 * 메인페이지 로드
 * @returns
 */
function loadMainPage() {
	loadMainSheet();
	//loadMainChart();
}


////////////////////////////////////////////////////////////////////////////////
// 화면 액션 함수들
////////////////////////////////////////////////////////////////////////////////
/**
 * 메인화면 관련 액션함수
 * @param sAction	액션명
 * @returns
 */
function doActionMain(sAction) {
	var formObj = $("form[name=mainForm]");
	switch(sAction) {                       
		case "search":
			
			var param = {PageParam: "page", Param: "rows=50"+"&"+formObj.serialize()};
			mainSheet.DoSearchPaging(com.wise.help.url("/admin/monitor/statInputMonitorListPaging.do"), param);
			
			//차트 조회
			ajaxCallAdmin(com.wise.help.url("/admin/monitor/statInputMonitorChart.do"),formObj.serialize(),initializeChart);
			ajaxCallAdmin(com.wise.help.url("/admin/stat/selectOpenInputMonitorwrtOrgList.do"),formObj.serialize(),initializewrtOrgChart);
			ajaxCallAdmin(com.wise.help.url("/admin/stat/selectOpenInputMonitorstatblList.do"),formObj.serialize(),initializestatChart);
			break;
		case "excel":
			mainSheet.Down2Excel({FileName:'Excel.xls',SheetName:'sheet'});
			break;
		case "orgPop" :		//담당부서 팝업
			window.open(com.wise.help.url("/admin/basicinf/popup/commOrg_pop.do") + "?orgNmGb=2&sheetNm=statMainForm", "list" ,"fullscreen=no, width=500, height=550");
			break;
	}
}

////////////////////////////////////////////////////////////////////////////////
//시트 초기화
////////////////////////////////////////////////////////////////////////////////
/**
* 메인 시트 로드
*/
function loadMainSheet() {
	createIBSheet2(document.getElementById("mainSheet"),"mainSheet", "100%", "350px");	
	
	var gridTitle1 = "NO|담당부서|통계표명|입력현황|입력현황|입력현황|입력현황|입력현황|입력현황";
	var gridTitle2 = "NO|담당부서|통계표명|합계|승인|제출|미제출|입력대기|입력률";
	
	with(mainSheet){
     
		var cfg = {SearchMode:3,Page:50,VScrollMode:1, MergeSheet:msHeaderOnly, SumPosition:1};
	    SetConfig(cfg);
	    var headers = [
	                 {Text:gridTitle1, Align:"Center"},
	                {Text:gridTitle2, Align:"Center"}
	            ];
	    var headerInfo = {Sort:0,ColMove:1,ColResize:1,HeaderCheck:0};
	    
	    InitHeaders(headers, headerInfo);
	    var cols = [
	                 {Type:"Seq",		SaveName:"seq",				Width:30,	Align:"Center",	Edit:false}
	                ,{Type:"Text",		SaveName:"wrtOrgNm",		Width:60,	Align:"Center",	Edit:false}
	                ,{Type:"Text",		SaveName:"statblNm",		Width:100,	Align:"Center",	Edit:false}
	                ,{Type:"AutoSum",		SaveName:"cnt",				Width:30,	Align:"Center",	Edit:false, Format:"Integer"}
	                ,{Type:"AutoSum",		SaveName:"acCnt",			Width:30,	Align:"Center",	Edit:false, Format:"Integer"}
	                ,{Type:"AutoSum",		SaveName:"awCnt",			Width:30,	Align:"Center",	Edit:false, Format:"Integer"}
	                ,{Type:"AutoSum",		SaveName:"nawCnt",			Width:30,	Align:"Center",	Edit:false, Format:"Integer"}
	                ,{Type:"AutoSum",		SaveName:"pnawCnt",			Width:30,	Align:"Center",	Edit:false, Format:"Integer"}
	                ,{Type:"Text",		SaveName:"inputRate",		Width:30,	Align:"Center",	Edit:false, Type:"Float", Format:"#,##0.0\\%", CalcLogic:"(|acCnt|+|awCnt|)/|cnt|*100"}
	            ];                                          
	    InitColumns(cols);
	    FitColWidth();
	    SetExtendLastCol(1);
	    SetSumText(1, "합  계")
	    
	}               
	default_sheet(mainSheet);
}
/**
* 메인 차트 로드
*/
function loadMainChart() {
	var varColor = "Purple";
	
	
	createIBChart2(document.getElementById("mainChart"), "mainChart", "100%", "350px");
	
}
/**
 * 메인화면 이벤트 처리
 */
function bindEventMain() {
	
	// 조회
	$("button[name=btn_inquiry]").bind("click", function(event) {
		doActionMain("search");
    });
	$("input[name=searchVal]").bind("keydown", function(event) {
        // 엔터키인 경우
        if (event.which == 13) {
        	doActionMain("search");
            return false;
        }
    });
	// 입력기간 초기화 올해초 올해말
	var today = new Date();
	var Year = today.getFullYear();
	$("button[name=openDttm_reset]").bind("click", function(e) {
		$("input[name=beginOpenDttm]").val(Year+"-01-01");
		$("input[name=endOpenDttm]").val(Year+"-12-31");
	});
	$("input[name=beginOpenDttm]").val(Year+"-01-01");
	$("input[name=endOpenDttm]").val(Year+"-12-31");
	
	$("button[name=btn_xlsDown]").bind("click", function(event){
		doActionMain("excel");
	});	
	//담당부서 팝업
	$("button[name=org_pop]").bind("click", function(e) {
		doActionMain("orgPop");
	});
	//담당부서 초기화
	$("button[name=org_reset]").bind("click", function(e) {
		$("input[name=orgCd], input[name=orgNm]").val("");
	});
	
	
}

/**
 * 옵션을 로드한다.
 */
function loadOptions() {
	// 메인 폼 공개일 from ~ to
	$("form[name=mainForm]").find("input[name=beginOpenDttm], input[name=endOpenDttm]").datepicker(setDatePickerCalendar());
	$("form[name=mainForm]").find('input[name=beginOpenDttm]').datepicker('option', 'onClose',  function( selectedDate ) {$("input[name=endOpenDttm]").datepicker( "option", "minDate", selectedDate );});
	$("form[name=mainForm]").find('input[name=endOpenDttm]').datepicker('option', 'onClose',  function( selectedDate ) {	$("input[name=beginOpenDttm]").datepicker( "option", "maxDate", selectedDate );});
	
	// 처리구분
	loadComboOptions3("jobTagCd", "/admin/stat/ajaxOption.do", {grpCd:"C1024"}, "");
	loadComboOptions3("srcSysCd", "/admin/stat/ajaxOption.do", {grpCd:"A8010"}, "");
	
}

/**
 * 캘린더 초기화 및 이벤트생성
 */
function datePickerInit() {
	var formObj = getTabFormObj("mst-form");
	
	/* 탭 이동마다 호출 */
	formObj.find(".ui-datepicker-trigger").remove();	//달력 이미지 제거
	
	// 공개일
	formObj.find("input[name=openDttm]").removeClass('hasDatepicker').datepicker(setDatePickerCalendar());
	
	// 생산일(파일)
	formObj.find("input[name=prdcYmd]").removeClass('hasDatepicker').datepicker(setDatePickerCalendar());
	
	//공개일 초기화
	formObj.find("button[id=openDttmInit]").bind("click", function() {
		formObj.find("input[name=openDttm]").val("");		
	});
}
function setDatePickerCalendar() {
	var calendar = {
		monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
		dayNamesMin: ['일','월','화','수','목','금','토'],
		weekHeader: 'Wk',
		dateFormat: 'yy-mm-dd', //형식(20120303)
		autoSize: false, //오토리사이즈(body등 상위태그의 설정에 따른다)
		changeMonth: true, //월변경가능
		changeYear: true, //년변경가능
		showMonthAfterYear: true, //년 뒤에 월 표시
		buttonImageOnly: true, //이미지표시
		buttonText: '달력선택', //버튼 텍스트 표시
		buttonImage: "../../../../images/admin/icon_calendar.png", //이미지주소                                              
		showOn: "both", //엘리먼트와 이미지 동시 사용(both,button)                 
		yearRange: '1900:2100', //1990년부터 2020년까지
		showButtonPanel: true, 
		closeText: 'close'
	};
	return calendar;
}


var rytitNm = "";
var index = 0;

function initializeChart(data){    
	//mainChart.RemoveAll();
	fnChartAddSeries(data);	// 차트 생성 및 추가
}  

// 부서별 합계 차트
function initializewrtOrgChart(data){    
	fnChartAddOrgSeries(data);	// 차트 생성 및 추가
}  

// 담당부서별 합계 차트
function initializestatChart(data){    
	fnChartAddDsSeries(data);	// 차트 생성 및 추가
}               



/* AC_CNT 승인 , AW_CNT 제출, NAW_CNT 미제출, pNAW_CNT 입력대기 */
function fnChartAddOrgSeries(result){
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

    const wrtOrgNmData = [];
    const acCntData = [];
    const awCntData = [];
    const nawCntData = [];
    const pnawCntData = [];
    
    
	$.each(result.data.reverse(), function(index, item){
	  wrtOrgNmData.push(item.wrtOrgNm); // x축 레이블에 월 추가
	  acCntData.push(item.acCnt); // 데이터 값 배열에 사용자 수 추가
	  awCntData.push(item.awCnt);
	  nawCntData.push(item.nawCnt);
	  pnawCntData.push(item.pnawCnt);

	});



Highcharts.chart('barChart1', {
	colors:['#06185C','#26837B','#727678','#836E95'],
	credits: {
        enabled: false
    },
    chart: {
        type: 'column'
    },
    title: {
        text: '담당부서별 입력현황',
        align: 'left'
    },
    xAxis: {
        categories: wrtOrgNmData
    },
    yAxis: {
        min: 0,
        title: {
            text: 'Count trophies'
        },
        stackLabels: {
            enabled: true
        }
    },
    legend: {
        align: 'left',
        x: 70,
        verticalAlign: 'top',
        y: 70,
        floating: true,
        backgroundColor:
            Highcharts.defaultOptions.legend.backgroundColor || 'white',
        borderColor: '#CCC',
        borderWidth: 1,
        shadow: false
    },
    tooltip: {
        headerFormat: '<b>{point.x}</b><br/>',
        pointFormat: '{series.name}: {point.y}<br/>합계: {point.stackTotal}'
    },
    plotOptions: {
        column: {
            stacking: 'normal',
            dataLabels: {
                enabled: true
            }
        }
    },
    series: [{
        name: '승인',
        data: acCntData
    }, {
        name: '제출',
        data: awCntData
    }, {
        name: '미제출',
        data: nawCntData
    }, {
        name: '입력대기',
        data: pnawCntData
        }
    
    ]
});

}


/* AC_CNT 승인 , AW_CNT 제출, NAW_CNT 미제출, pNAW_CNT 입력대기 */
function fnChartAddSeries(result){

	
	var totCnt = result.data.TOT_CNT;
	var acCnt = result.data.AC_CNT;
	var awCnt = result.data.AW_CNT;
	var nawCnt = result.data.NAW_CNT;
	var pnawCnt = result.data.PNAW_CNT;


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

Highcharts.chart('pieChart', {
	colors:['#06185C','#26837B','#727678','#836E95'],
	credits: {
        enabled: false
    },
    chart: {
        type: 'pie'
    },
    title: {
        text: '공공데이터 입력 현황'
    },
    tooltip: {
        valueSuffix: ''
    },
    subtitle: {
        text:
        ''
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
            name: '입력현황',
            colorByPoint: true,
            data: [
                {
                    name: '승인',
                    y: acCnt
                },
                {
                    name: '제출',
                    sliced: true,
                    selected: true,
                    y: awCnt
                },
                {
                    name: '미제출',
                    y: nawCnt
                },
                {
                    name: '입력대기',
                    y: pnawCnt
                }
            ]
        }
    ]
});
}

/* AC_CNT 승인 , AW_CNT 제출, NAW_CNT 미제출, pNAW_CNT 입력대기 */
function fnChartAddDsSeries(result){

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

    const statblNmData = [];
    const acCntData = [];
    const awCntData = [];
    const nawCntData = [];
    const pnawCntData = [];
    
    
	$.each(result.data.reverse(), function(index, item){
	  statblNmData.push(item.statblNm); // x축 레이블에 월 추가
	  acCntData.push(item.acCnt); // 데이터 값 배열에 사용자 수 추가
	  awCntData.push(item.awCnt);
	  nawCntData.push(item.nawCnt);
	  pnawCntData.push(item.pnawCnt);

	});

Highcharts.chart('barChart2', {
	colors:['#06185C','#26837B','#727678','#836E95'],
	credits: {
        enabled: false
    },
    chart: {
        type: 'column'
    },
    title: {
        text: '데이터셋별 입력현황',
        align: 'left'
    },
    xAxis: {
        categories: statblNmData
    },
    yAxis: {
        min: 0,
        title: {
            text: 'Count trophies'
        },
        stackLabels: {
            enabled: true
        }
    },
    legend: {
        align: 'left',
        x: 70,
        verticalAlign: 'top',
        y: 70,
        floating: true,
        backgroundColor:
            Highcharts.defaultOptions.legend.backgroundColor || 'white',
        borderColor: '#CCC',
        borderWidth: 1,
        shadow: false
    },
    tooltip: {
        headerFormat: '<b>{point.x}</b><br/>',
        pointFormat: '{series.name}: {point.y}<br/>합계: {point.stackTotal}'
    },
    plotOptions: {
        column: {
            stacking: 'normal',
            dataLabels: {
                enabled: true
            }
        }
    },
    series: [{
        name: '승인',
        data: acCntData
    }, {
        name: '제출',
        data: awCntData
    }, {
        name: '미제출',
        data: nawCntData
    }, {
        name: '입력대기',
        data: pnawCntData
        }
    
    ]
});
}