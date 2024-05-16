/*
 * @(#)userUsageState.js 1.0 2020/09/14
 */

/**
 * 관리자 사용자별 로그 분석 스크립트 파일이다
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
        buttonImage:com.wise.help.url("/images/admin/icon_calendar.png")
    }));
	
	$('input[name=startYmd]').datepicker('option', 'onClose',  function( selectedDate ) {$("input[name=endYmd]").datepicker( "option", "minDate", selectedDate );});
	$('input[name=endYmd]').datepicker('option', 'onClose',  function( selectedDate ) {	$("input[name=startYmd]").datepicker( "option", "maxDate", selectedDate );});
	//$("input[name=startYmd]").val(today(-1));
	$("input[name=startYmd]").val(today());
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
			sheet.DoSearchPaging(com.wise.help.url("/admin/stat/userUsageStateListPaging.do"), param);
			ajaxCallAdmin(com.wise.help.url("/admin/stat/userUsageStatePie.do"),$("form[name=statOpen]").serialize(),initializeChart);
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
    if (("" + day).length   == 1) { day   = "0" + day;   }
   
    return "" + year + "-" + month + "-" + day; 
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
	gridTitle +="|시스템";
	gridTitle +="|메뉴URL";
	gridTitle +="|메뉴명";
	gridTitle +="|국회의원";
	gridTitle +="|사용자IP";
	gridTitle +="|접속일시";
	
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
	                 {Type:"Seq",		SaveName:"seq",			Width:50,	Align:"Center",		Edit:false}
	                ,{Type:"Text",		SaveName:"sysTag",		Width:80,	Align:"Center",		Edit:false}
					,{Type:"Text",	    SaveName:"menuUrl",		Width:150,	Align:"Left",		Edit:false}
					,{Type:"Text",	    SaveName:"menuNm",		Width:150,	Align:"Left",		Edit:false}
					,{Type:"Text",	    SaveName:"hgNm",		Width:150,	Align:"Left",		Edit:false}
					,{Type:"Text",	    SaveName:"userIp",		Width:100,	Align:"Center",		Edit:false}
					,{Type:"Text",	    SaveName:"regDttm",	    Width:80,	Align:"Center",		Edit:false}
				];
	    
	    InitColumns(cols);
	    FitColWidth();
	    SetExtendLastCol(1);
	   
	    
	}               
	default_sheet(sheet);   
	
}function initializeChart(data){    
	//mainChart.RemoveAll();
	afterStatUsageStateChart(data);	// 차트 생성 및 추가
} 


function afterStatUsageStateChart(result) {
	
	const memberData = result.data[0]["membersCount"];
	const infonaviData = result.data[0]["infonaviCount"];
	
	
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
	
	
	$.each(result.data.reverse(), function(index, item){
	});
	
Highcharts.chart('mainChart1', {
	colors: ['#395DB2','#08216E']
	,
	credits: {
        enabled: false
    },
    chart: {
        type: 'pie'
    },
    title: {
        text: '전체 URL 호출 수'
    },
    tooltip: {
        valueSuffix: '회'
    },
    plotOptions: {
        series: {
            allowPointSelect: true,
            cursor: 'pointer',
            showInLegend: true,
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
            name: '비율',
            colorByPoint: true,
            data: [
                {
                    name: '국회의원',
                    y: memberData
                },
                {
                    name: '국회 정보나침반',
                    sliced: true,
                    selected: true,
                    y: infonaviData
                }
            ]
        }
    ]
});
}

function sheet_OnSearchEnd(code, message, statusCode, statusMessage) {
	
}