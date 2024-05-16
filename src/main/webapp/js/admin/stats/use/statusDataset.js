
$(document).ready(function()    {    
	LoadPage();                                                               
	init();
	setDate(); //날짜
	setCate();
	doAction('search');
}); 

function init(){
	var formObj = $("form[name=statUse]");
	formObj.find("input[name=pubDttmTo]").datepicker(setCalendar());          
	formObj.find("input[name=pubDttmFrom]").datepicker(setCalendar());      
	datepickerTrigger();     
	formObj.find("button[name=btn_inquiry]").click(function(e) { //조회
		doAction("search");
		return false;
	});
	formObj.find("input[name=infNm]").bind("keydown", function(event) {
        if (event.which == 13) {
    		doAction("search");
    		return false;
        }
    });
	formObj.find("button[name=btn_xlsDown]").click(function(e) { //엑셀다운
		doAction("excel");
		return false;
	});
}

function setDate(){
	var formObj = $("form[name=statUse]");

	var now = new Date(Date.parse(new Date)-1*1000*60*60*24);
	var before = new Date(Date.parse(new Date)-1*1000*60*60*24);
	before.setMonth(before.getMonth()-12);
	var monTo = (now.getMonth()+1)>9?now.getMonth()+1:'0'+(now.getMonth()+1);
	var monFrom = (before.getMonth()+1)>9?before.getMonth()+1:'0'+(before.getMonth()+1);
	var day = (now.getDate())>9?(now.getDate()):'0'+(now.getDate());
	var dayFrom = (before.getDate())>9?(before.getDate()):'0'+(before.getDate());
	var dateTo=now.getFullYear()+'-'+monTo+'-'+day;
	var dateFrom=before.getFullYear()+'-'+monFrom+'-'+dayFrom;
	formObj.find("input[name=pubDttmFrom]").val(dateFrom);
	formObj.find("input[name=pubDttmTo]").val(dateTo);

}

function setCate() {
	$.post(getContextPath+'/admin/mainmng/selectListCate.do', function(data){
		var formObj = $("form[name=statUse]");
		var select = formObj.find("select[name=cateId]");
		$.each(data.DATA, function(i, data) {
			select.append('<option value="' + data.cateId + '">'+data.cateNm+'</option>');
		});
	});
}

function LoadPage()                
{      
	//message-common_ko_KR.properties 선언 후 사용 or message-common_en_US.properties 선언 후 사용
	var gridTitle = "NO";
		gridTitle +="|"+"대분류";
		gridTitle +="|"+"소분류";
		gridTitle +="|"+"데이터셋명";
//		gridTitle +="|"+"데이터셋아이디";
		gridTitle +="|"+"전체활용수";
		gridTitle +="|"+"조회수합계";
		gridTitle +="|"+"Sheet조회";
		gridTitle +="|"+"Chart조회";
		gridTitle +="|"+"Map조회";
		gridTitle +="|"+"File조회";
		gridTitle +="|"+"Link조회";
		gridTitle +="|"+"OpenAPI조회";
		gridTitle +="|"+"멀티미디어조회";
		gridTitle +="|"+"다운로드수합계";
		gridTitle +="|"+"EXCEL다운로드";
		gridTitle +="|"+"CSV다운로드";
		gridTitle +="|"+"JSON다운로드";
		gridTitle +="|"+"XML다운로드";
		gridTitle +="|"+"TXT다운로드";
		gridTitle +="|"+"FIle다운로드";
		gridTitle +="|"+"Link클릭";
		gridTitle +="|"+"API호출";
		gridTitle +="|"+"API샘플호출";
		
	
    with(mySheet){
    	                     
    	var cfg = {SearchMode:2,Page:50,VScrollMode:1};                                         
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
					 {Type:"Seq",		SaveName:"seq",				Width:30,	Align:"Center",		Edit:false, Sort:false}
					,{Type:"Text",		SaveName:"cateNmTop",			Width:50,	Align:"Left",		Edit:false, Sort:false}
					,{Type:"Text",		SaveName:"cateNm",			Width:50,	Align:"Left",		Edit:false, Sort:false}
					,{Type:"Text",		SaveName:"infNm",			Width:100,	Align:"Left",		Edit:false, Sort:false}
					,{Type:"AutoSum",		SaveName:"totUseCnt",			Width:50,	Align:"Right",		Edit:false, Sort:false}
					,{Type:"AutoSum",		SaveName:"totViewCnt",			Width:50,	Align:"Right",		Edit:false, Sort:false}
					,{Type:"AutoSum",		SaveName:"sUseCnt",			Width:50,	Align:"Right",		Edit:false, Sort:false}
					,{Type:"AutoSum",		SaveName:"cUseCnt",			Width:50,	Align:"Right",		Edit:false, Sort:false}
					,{Type:"AutoSum",		SaveName:"mUseCnt",			Width:50,	Align:"Right",		Edit:false, Sort:false}
					,{Type:"AutoSum",		SaveName:"fUseCnt",			Width:50,	Align:"Right",		Edit:false, Sort:false}
					,{Type:"AutoSum",		SaveName:"lUseCnt",			Width:50,	Align:"Right",		Edit:false, Sort:false}
					,{Type:"AutoSum",		SaveName:"aUseCnt",			Width:50,	Align:"Right",		Edit:false, Sort:false}
					,{Type:"AutoSum",		SaveName:"vUseCnt",			Width:50,	Align:"Right",		Edit:false, Sort:false}
					,{Type:"AutoSum",		SaveName:"totDownCnt",			Width:50,	Align:"Right",		Edit:false, Sort:false}
					,{Type:"AutoSum",		SaveName:"excelCnt",			Width:50,	Align:"Right",		Edit:false, Sort:false}
					,{Type:"AutoSum",		SaveName:"csvCnt",			Width:50,	Align:"Right",		Edit:false, Sort:false}
					,{Type:"AutoSum",		SaveName:"jsonCnt",			Width:50,	Align:"Right",		Edit:false, Sort:false}
					,{Type:"AutoSum",		SaveName:"xmlCnt",			Width:50,	Align:"Right",		Edit:false, Sort:false}
					,{Type:"AutoSum",		SaveName:"txtCnt",			Width:50,	Align:"Right",		Edit:false, Sort:false}
					,{Type:"AutoSum",		SaveName:"fileUseCnt",			Width:50,	Align:"Right",		Edit:false, Sort:false}
					,{Type:"AutoSum",		SaveName:"linkUseCnt",			Width:50,	Align:"Right",		Edit:false, Sort:false}
					,{Type:"AutoSum",		SaveName:"apiUseCnt",			Width:50,	Align:"Right",		Edit:false, Sort:false}
					,{Type:"AutoSum",		SaveName:"apisUseCnt",			Width:50,	Align:"Right",		Edit:false, Sort:false}
                   ];       
                                      
        InitColumns(cols);                                                                           
        FitColWidth();                                                         
        SetExtendLastCol(1);   
    }               
    default_sheet(mySheet); 
    mySheet.SetCountPosition(4); 
    mySheet.SetSumValue(0,"dtNm","합계"); 
    mySheet.SetAutoSumPosition("1"); //autoSum 위치 지정 1은 최하단 0은 최상단
} 

/*Sheet 각종 처리*/                  
function doAction(sAction)                                  
{
	var classObj = $("."+tabContentClass); //tab으로 인하여 form이 다건임
	var actObj = setTabForm(classObj); // 0: form data, 1: form 객체
	var formObj = $("form[name=statUse]");
//	var flag = false;  
//	var pattern =/[&]/gi;             
//	var pattern2 =/[=]/gi;             
	switch(sAction)
	{          
		case "search":      //조회
			ajaxCallAdmin(getContextPath+"/admin/stat/use/getUseStatDtChartAll.do",formObj.serialize(),initializeChart);         
			fromObj = formObj.find("input[name=pubDttmFrom]");
			toObj = formObj.find("input[name=pubDttmTo]");
			dateValCheck(fromObj,toObj)// from , to 날짜 안맞을 경우 자동셋팅
			
			ajaxBeforeSendAdmin(getContextPath+"/admin/ajaxBeforeSendAdmin.do"); //IbSheet 조회전 세션 체크

			//시트 조회
			var param = {PageParam: "ibpage", Param: "onepagerow="+IBSHEETPAGENOW+"&"+actObj[0]};
			mySheet.DoSearchPaging(getContextPath+"/admin/stat/use/getUseStatDatasetSheetAll.do", param);   
			
			//차트 조회
			
			//ajaxCallAdmin(getContextPath+"/admin/stat/use/getUseStatDatasetSheetAll.do",formObj.serialize(),initializeChart);
			//ajaxCallAdmin(com.wise.help.url("/admin/stat/use/getUseStatDatasetSheetAll.do"),$("form[name=statUse]").serialize(),initializeChart);
			break;
			
			case "excel":      //엑셀다운 - 이 방법이 아니라 openinfccolview.jsp의 197라인을 참고해서 할수도있음(이방법은 현재 시트에 처리중입니다라고 뜸)
			/* mySheet.Down2Excel({FileName:'excel2',SheetName:'mySheet'});
			break; */
			//var param = {FileName:"Excel"+formObj.find("input[name=pubDttmTo]").val()+".xls",SheetName:"mySheet",Merge:1,SheetDesign:1 };
			mySheet.Down2Excel({FileName:'데이터셋별활용현황.xls',SheetName:'mySheet'});
			break;
			
			/* formObj.find("input[name=queryString]").val(formObj.serialize());
			formObj.attr("action","<c:url value='/admin/stat/statUseXlsdownload.do'/>").submit();        
			break; */
	}           
}
function initializeChart(data){    
	//mainChart.RemoveAll();

	afterStatUsageStateChart(data);	// 차트 생성 및 추가
} 

function initializeCntChart(data){    

	afterStatUsageStateCntChart(data);	// 차트 생성 및 추가
} 

////////////////////////////////////////////////////////////////////////////////
// 후처리 함수
////////////////////////////////////////////////////////////////////////////////

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

	// x축 레이블과 데이터 값 배열
	const categories = [];
	const apissData = [];
	const apisData = [];
	const callsData = [];
	const sUsesData = [];
	const totUsesData = [];
	const linkUsesData = [];
	
	const cUsesData = [];
	const mUsesData = [];
	const fUsesData = [];
	const lUsesData = [];
	const aUsesData = [];
	const vUsesData = [];
	
	const excelDownData = [];
	const csvDownData = [];
	const jsonDownData = [];
	const xmlDownData = [];
	const txtDownData = [];
	const fileDownData = [];
	
	// 소분류별 조회수
	const Dcategories = [];
	const DtotCnt = [];
	const DsUseCnt = [];
	const DcUseCnt = [];
	const DmUseCnt = [];
	const DfUseCnt = [];
	const DlUseCnt = [];
	const DaUseCnt = [];
	const DvUseCnt = [];
	
	// 소분류별 다운로드수
	const DtotDown = [];
	const DexcelDown = [];
	const DcsvDown = [];
	const DjsonDown = [];
	const DxmlDown = [];
	const DtxtDown = [];
	const DfileDown = [];
	
	// 소분류별 API 호출 수
	const DlinkUse = [];
	const DapiUse = [];
	const DapisUse = [];
	

	$.each(result.chartDataX, function(index, item){
	  categories.push(item.CATE_NM); // x축 레이블에 월 추가
	});	
	$.each(result.chartDataY, function(index, item){
		apissData.push(item.APIS_USE_CNT); // 데이터 값 배열에 사용자 수 추가
		apisData.push(item.API_USE_CNT);
		linkUsesData.push(item.LINK_USE_CNT);
		sUsesData.push(item.S_USE_CNT);
		totUsesData.push(item.TOT_USE_CNT);
		cUsesData.push(item.C_USE_CNT);
		mUsesData.push(item.M_USE_CNT);
		fUsesData.push(item.F_USE_CNT);
		lUsesData.push(item.L_USE_CNT);
		aUsesData.push(item.A_USE_CNT);
		vUsesData.push(item.V_USE_CNT);
		
		excelDownData.push(item.EXCEL_CNT);
		csvDownData.push(item.CSV_CNT);
		jsonDownData.push(item.JSON_CNT);
		xmlDownData.push(item.XML_CNT);
		txtDownData.push(item.TXT_CNT);
		fileDownData.push(item.FILE_USE_CNT);
	});
	
	
	$.each(result.dataSetCnt, function(index, item){
		Dcategories.push(item.cateNm);
		DtotCnt.push(item.totViewCnt);
		DsUseCnt.push(item.sUseCnt); // 데이터 값 배열에 사용자 수 추가
		DcUseCnt.push(item.cUseCnt); // 데이터 값 배열에 사용자 수 추가
		DmUseCnt.push(item.mUseCnt); // 데이터 값 배열에 사용자 수 추가
		DfUseCnt.push(item.fUseCnt); // 데이터 값 배열에 사용자 수 추가
		DlUseCnt.push(item.lUseCnt); // 데이터 값 배열에 사용자 수 추가
		DaUseCnt.push(item.aUseCnt); // 데이터 값 배열에 사용자 수 추가
		DvUseCnt.push(item.vUseCnt); // 데이터 값 배열에 사용자 수 추가
		
		DtotDown.push(item.totDownCnt);
		DexcelDown.push(item.excelCnt);
		DcsvDown.push(item.csvCnt);
		DjsonDown.push(item.jsonCnt);
		DxmlDown.push(item.xmlCnt);
		DtxtDown.push(item.txtCnt);
		DfileDown.push(item.totDownCnt);
		
		DlinkUse.push(item.linkUseCnt);
		DapiUse.push(item.apiUseCnt);
		DapisUse.push(item.apisUseCnt);

	});
	
	
	
	const totalsUses = sUsesData.reduce((total, current) => total + current, 0);
	const totalcUses = cUsesData.reduce((total, current) => total + current, 0);
	const totalmUses = mUsesData.reduce((total, current) => total + current, 0);
	const totalfUses = fUsesData.reduce((total, current) => total + current, 0);
	const totallUses = lUsesData.reduce((total, current) => total + current, 0);
	const totalaUses = aUsesData.reduce((total, current) => total + current, 0);
	const totalvUses = vUsesData.reduce((total, current) => total + current, 0);
	
	const totaleDown = excelDownData.reduce((total, current) => total + current, 0);
	const totalcDown = csvDownData.reduce((total, current) => total + current, 0);
	const totaljDown = jsonDownData.reduce((total, current) => total + current, 0);
	const totalxDown = xmlDownData.reduce((total, current) => total + current, 0);
	const totaltDown = txtDownData.reduce((total, current) => total + current, 0);
	const totalfDown = fileDownData.reduce((total, current) => total + current, 0);
	
	const totalLinkCnt = linkUsesData.reduce((total, current) => total + current, 0);
	const totalapiCnt = apisData.reduce((total, current) => total + current, 0);
	const totalapisCnt = apissData.reduce((total, current) => total + current, 0);
	

	
Highcharts.chart('pieChart1', {
	colors: ['#08216E','#395DB2','#26837B','#06185C','#FF6E33','#727678','#836E95']
	,
	credits: {
        enabled: false
    },
    chart: {
        type: 'pie'
    },
    title: {
        text: '전체 조회 수'
    },
    tooltip: {
        valueSuffix: '회'
    },
    plotOptions: {
        series: {
            allowPointSelect: true,
            cursor: 'pointer',
            showInLegend: true,
            dataLabels: {
                enabled: true,
                format: '<b>{point.name}</b><br>{point.percentage:.2f}%',
                distance: 20
            }
        }
    },
    series: [
        {
            name: '횟수',
            colorByPoint: true,
            data: [
                {
                    name: 'Sheet조회',
                    y: totalsUses
                },
                {
                    name: 'Chart조회',
                    y: totalcUses
                },
                {
                    name: 'Map조회',
                    y: totalmUses
                },
                {
                    name: 'File조회',
                    y: totalfUses
                },
                {
                    name: 'Link조회',
                    y: totallUses
                },
                {
                    name: 'OpenAPI조회',
                    y: totalaUses
                },
                {
                    name: '멀티미디어조회',
                    sliced: true,
                    selected: true,
                    y: totalvUses
                }
            ]
        }
    ]
});
	
Highcharts.chart('pieChart2', {
	colors: ['#08216E','#395DB2','#26837B','#FF6E33','#06185C','#836E95','#727678']
	,
	credits: {
        enabled: false
    },
    chart: {
        type: 'pie'
    },
    title: {
        text: '전체 다운로드 수'
    },
    tooltip: {
        valueSuffix: '회'
    },
    plotOptions: {
        series: {
            allowPointSelect: true,
            cursor: 'pointer',
            showInLegend: true,
            dataLabels: {
                enabled: true,
                format: '<b>{point.name}</b><br>{point.percentage:.2f}%',
                distance: 20
            }
        }
    },
    series: [
        {
            name: '횟수',
            colorByPoint: true,
            data: [
                {
                    name: 'Excel다운로드',
                    y: totaleDown
                },
                {
                    name: 'CSV다운로드',
                    y: totalcDown
                },
                {
                    name: 'JSON다운로드',
                    y: totaljDown
                },
                {
                    name: 'XML다운로드',
                    y: totalxDown
                },
                {
                    name: 'TXT다운로드',
                    y: totaltDown
                },
                {
                    name: 'File다운로드',
                    sliced: true,
                    selected: true,
                    y: totalfDown
                }
            ]
        }
    ]
});

Highcharts.chart('pieChart3', {
	colors: ['#08216E','#395DB2','#26837B','#FF6E33','#06185C','#727678','#836E95']
	,
	credits: {
        enabled: false
    },
    chart: {
        type: 'pie'
    },
    title: {
        text: '전체 API 호출 수'
    },
    tooltip: {
        valueSuffix: '회'
    },
    plotOptions: {
        series: {
            allowPointSelect: true,
            cursor: 'pointer',
            showInLegend: true,
            dataLabels: {
                enabled: true,
                format: '<b>{point.name}</b><br>{point.percentage:.2f}%',
                distance: 20
            }
        }
    },
    series: [
        {
            name: '횟수',
            colorByPoint: true,
            data: [
                {
                    name: 'Link클릭',
                    y: totalLinkCnt
                },
                {
                    name: 'API호출',
                    y: totalapiCnt
                },
                {
                    name: 'API샘플호출',
                    sliced: true,
                    selected: true,
                    y: totalapisCnt
                }
            ]
        }
    ]
});
	
		// Highcharts 그래프 생성
	Highcharts.chart('mainChart1', {
	colors: ['#4CB699','#08216E','#395DB2','#26837B','#06185C','#FF6E33','#727678','#836E95']
	,
	credits: {
        enabled: false
    },
	  chart: {
	    type: 'line' // 선 그래프로 설정
	  },
	  title: {
	    text: '소분류별 조회 수' // 그래프 제목
	  },
	  xAxis: {
	    categories: Dcategories // x축 레이블 설정
	  },
	  yAxis: {
	    title: {
	      text: '' // y축 레이블 설정
	    }
	  },
	  series: [{
	  	name: '조회수합계',
	  	data: DtotCnt,
	  	type: 'column'
	  },{
	    name: 'Sheet조회', // 데이터 시리즈 이름
	    data: DsUseCnt // 데이터 값 설정
	  },{
	    name: 'Chart조회', // 데이터 시리즈 이름
	    data: DcUseCnt // 데이터 값 설정
	  },{
	    name: 'Map조회', // 데이터 시리즈 이름
	    data: DmUseCnt // 데이터 값 설정
	  },{
	    name: 'File조회', // 데이터 시리즈 이름
	    data: DfUseCnt // 데이터 값 설정
	  },{
	    name: 'Link조회', // 데이터 시리즈 이름
	    data: DlUseCnt // 데이터 값 설정
	  },{
	    name: 'OpenAPI조회', // 데이터 시리즈 이름
	    data: DaUseCnt // 데이터 값 설정
	  },{
	    name: '멀티미디어조회', // 데이터 시리즈 이름
	    data: DvUseCnt // 데이터 값 설정
	  }
	  ]
	});
	
		// Highcharts 그래프 생성
	Highcharts.chart('mainChart2', {
	colors: ['#4CB699','#08216E','#395DB2','#26837B','#FF6E33','#06185C','#836E95','#727678']
	,
	credits: {
        enabled: false
    },
	  chart: {
	    type: 'line' // 선 그래프로 설정
	  },
	  title: {
	    text: '소분류별 다운로드 수' // 그래프 제목
	  },
	  xAxis: {
	    categories: Dcategories // x축 레이블 설정
	  },
	  yAxis: {
	    title: {
	      text: '' // y축 레이블 설정
	    }
	  },
	  series: [{
	  	name: '다운로드합계',
	  	data: DtotDown,
	  	type: 'column'
	  },{
	    name: 'EXCEL다운로드', // 데이터 시리즈 이름
	    data: DexcelDown // 데이터 값 설정
	  },{
	    name: 'CSV다운로드', // 데이터 시리즈 이름
	    data: DcsvDown // 데이터 값 설정
	  },{
	    name: 'JSON다운로드', // 데이터 시리즈 이름
	    data: DjsonDown // 데이터 값 설정
	  },{
	    name: 'XML다운로드', // 데이터 시리즈 이름
	    data: DxmlDown // 데이터 값 설정
	  },{
	    name: 'TXT다운로드', // 데이터 시리즈 이름
	    data: DtxtDown // 데이터 값 설정
	  },{
	    name: 'FILE다운로드', // 데이터 시리즈 이름
	    data: DfileDown // 데이터 값 설정
	  }
	  ]
	});
	
		// Highcharts 그래프 생성
	Highcharts.chart('mainChart3', {
	colors: ['#08216E','#395DB2','#26837B','#FF6E33','#06185C','#727678','#836E95']
	,
	credits: {
        enabled: false
    },
	  chart: {
	    type: 'line' // 선 그래프로 설정
	  },
	  title: {
	    text: '소분류별 API 호출 수' // 그래프 제목
	  },
	  xAxis: {
	    categories:Dcategories // x축 레이블 설정
	  },
	  yAxis: {
	    title: {
	      text: '' // y축 레이블 설정
	    }
	  },
	  series: [{
	    name: 'link클릭', // 데이터 시리즈 이름
	    data: DlinkUse // 데이터 값 설정
	  },{
	    name: 'API호출', // 데이터 시리즈 이름
	    data: DapiUse // 데이터 값 설정
	  },{
	    name: 'API샘플호출', // 데이터 시리즈 이름
	    data: DapisUse // 데이터 값 설정
	  }
	  ]
	});

}   

