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
<%
	//String mode = UtilString.replaceNull((String)request.getParameter("mode"),"D");
	String mode = "";
	if(request.getParameter("mode")!=null){
	mode = request.getParameter("mode");
	}else{
	mode = "D";
	}
%>
<script type="text/javascript" src="<c:url value="/js/common/highcharts/highcharts.js" />"></script>
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
	if($("input[name=mode]").val()=="D"){		// 일별 추이 
		var formObj = $("form[name=statOpen]");
		var now = new Date(Date.parse(new Date)-1*1000*60*60*24);
		var before = new Date(Date.parse(new Date)-1*1000*60*60*24);
		before.setMonth(before.getMonth()-1);
		var monTo = (now.getMonth()+1)>9?now.getMonth()+1:'0'+(now.getMonth()+1);
		var monFrom = (before.getMonth()+1)>9?before.getMonth()+1:'0'+(before.getMonth()+1);
		var day = (now.getDate())>9?(now.getDate()):'0'+(now.getDate());
		var dayFrom = (before.getDate())>9?(before.getDate()):'0'+(before.getDate());
		var dateTo=now.getFullYear()+'-'+monTo+'-'+day;
		var dateFrom=before.getFullYear()+'-'+monFrom+'-'+dayFrom;
		formObj.find("input[name=pubDttmFrom]").val(dateFrom);
		formObj.find("input[name=pubDttmTo]").val(dateTo);
	}else{
		var formObj = $("form[name=statOpen]");
		var now = new Date();
		var year = now.getFullYear();
		var monTo = (now.getMonth()+1)>9?now.getMonth()+1:'0'+(now.getMonth()+1);
		var monFrom = (now.getMonth()+1)>9?now.getMonth()+1:'0'+(now.getMonth()+1);
		var day = now.getDate()>9?now.getDate():'0'+now.getDate();
		if($("input[name=mode]").val()=="M"){		// 월별 추이	==> default 12개월전 
			var dateTo=year+'-'+monTo+'-'+day;
			var dateFrom=year-1+'-'+monFrom+'-'+day;
		}else if($("input[name=mode]").val()=="Y"){	// 연별 추이	==> default 10년전
			var dateTo=year+'-'+monTo+'-'+day;
			var dateFrom=year-10+'-'+monFrom+'-'+day;	
		}
	}
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
		if($("input[name=mode]").val()=="D"){
			gridTitle +="|"+"<spring:message code='labal.pubTagDay'/>";	// 일자
		}else if($("input[name=mode]").val()=="M"){
			gridTitle +="|"+"<spring:message code='labal.pubTagMonth'/>";
		}else if($("input[name=mode]").val()=="Y"){
			gridTitle +="|"+"<spring:message code='labal.pubTagYear'/>";
		}
		gridTitle +="|"+"전체활용수";
		gridTitle +="|"+"Sheet";
		gridTitle +="|"+"Chart";
		gridTitle +="|"+"Map";
		gridTitle +="|"+"File";
		gridTitle +="|"+"Link";
		gridTitle +="|"+"API";
		gridTitle +="|"+"시각화";
		gridTitle +="|"+"엑셀저장";
		gridTitle +="|"+"CVS저장";
		gridTitle +="|"+"JSON저장";
		gridTitle +="|"+"XML저장";
		gridTitle +="|"+"TXT저장";
		gridTitle +="|"+"FILE다운로드";
		gridTitle +="|"+"Link클릭";
		gridTitle +="|"+"API호출";
		gridTitle +="|"+"API샘플";
		//gridTitle +="|"+"도내타기관";
		//gridTitle +="|"+"시각화";
	
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
					 {Type:"Seq",		SaveName:"seq",				Width:30,	Align:"Center",		Edit:false}
					,{Type:"Text",		SaveName:"yyyyMmDd",				Width:80,	Align:"Center",		Edit:false}
					,{Type:"AutoSum",		SaveName:"totUseCnt",			Width:50,	Align:"Right",		Edit:false}
					,{Type:"AutoSum",		SaveName:"sUseCnt",			Width:50,	Align:"Right",		Edit:false}
					,{Type:"AutoSum",		SaveName:"cUseCnt",			Width:50,	Align:"Right",		Edit:false}
					,{Type:"AutoSum",		SaveName:"mUseCnt",			Width:50,	Align:"Right",		Edit:false}
					,{Type:"AutoSum",		SaveName:"fUseCnt",			Width:50,	Align:"Right",		Edit:false}
					,{Type:"AutoSum",		SaveName:"lUseCnt",			Width:50,	Align:"Right",		Edit:false}
					,{Type:"AutoSum",		SaveName:"aUseCnt",			Width:50,	Align:"Right",		Edit:false}
					,{Type:"AutoSum",		SaveName:"vUseCnt",			Width:50,	Align:"Right",		Edit:false}
					,{Type:"AutoSum",		SaveName:"excelCnt",			Width:50,	Align:"Right",		Edit:false}
					,{Type:"AutoSum",		SaveName:"csvCnt",			Width:50,	Align:"Right",		Edit:false}
					,{Type:"AutoSum",		SaveName:"jsonCnt",			Width:50,	Align:"Right",		Edit:false}
					,{Type:"AutoSum",		SaveName:"xmlCnt",			Width:50,	Align:"Right",		Edit:false}
					,{Type:"AutoSum",		SaveName:"txtCnt",			Width:50,	Align:"Right",		Edit:false}
					,{Type:"AutoSum",		SaveName:"fileUseCnt",			Width:50,	Align:"Right",		Edit:false}
					,{Type:"AutoSum",		SaveName:"linkUseCnt",			Width:50,	Align:"Right",		Edit:false}
					,{Type:"AutoSum",		SaveName:"apiUseCnt",			Width:50,	Align:"Right",		Edit:false}
					,{Type:"AutoSum",		SaveName:"apisUseCnt",			Width:50,	Align:"Right",		Edit:false}
                   ];       
                                      
        InitColumns(cols);                                                                           
        FitColWidth();                                                         
        SetExtendLastCol(1);   
    }               
    default_sheet(mySheet); 
    mySheet.SetCountPosition(0); 
    mySheet.SetSumValue(0,"yyyyMmDd","합계"); 
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
			mySheet.DoSearchPaging("<c:url value='/admin/stat/prgs/getUseStatPrgsSheetAll.do'/>", param);   
			
			//차트 조회
			ajaxCallAdmin("<c:url value='/admin/stat/prgs/getUseStatPrgsChartAll.do'/>",formObj.serialize(),initializeChart);
			
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

function initializeChart(data){    
// 	var varColor = "Purple";
// 	myChart.RemoveAll();
// 	var obj = myChart;
// 	initChart(obj);//차트 기본색상 셋팅
// 	rytitNm = "건수";
// 	//X축 스타일                   
// 	initXStyleChart(obj,varColor, varColor, "일자");//chartObj, x색, y색, 이름
// 	// 왼쪽 Y축 스타일
// 	initYStyleChart(obj,varColor, varColor, "건수");//chartObj, x색, y색, 이름
// 	// 왼쪽 Y축 스타일2                              
// 	initYStylechart2(obj,varColor, varColor, "");//chartObj, x색, y색, 이름
// 	//툴팁 스타일
// 	initToolTipSet(obj);//chartObj               
// 	//범례 스타일                               
// 	initLegend(obj,"center","bottom","horizontal","N");//chartObj, 가로, 세로, 정렬, 플로팅
// 	//Label 스타일
// 	initLable(obj);//chartObj                          
// 	//chart 데이터 추가         
// 	fnChartAddSeries(data,0,false);	// 차트 생성 및 추가
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
	console.log(1);
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
	const totDownData = [];
	
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
	  categories.push(item.YYYYMMDD); // x축 레이블에 월 추가
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
		totDownData.push(item.TOT_DOWN_CNT);
	});
	
	console.log(totUsesData);
	

	
	
	
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
	
	console.log(categories);
	console.log(DtotCnt);
	

	
Highcharts.chart('pieChart1', {
	colors: ['#08216E','#395DB2','#26837B','#06185C','#FF6E33','#727678','#836E95']
	,
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
	  chart: {
	    type: 'line' // 선 그래프로 설정
	  },
	  title: {
	    text: '월별 조회 수' // 그래프 제목
	  },
	  xAxis: {
	    categories: categories // x축 레이블 설정
	  },
	  yAxis: {
	    title: {
	      text: '' // y축 레이블 설정
	    }
	  },
	  series: [{
	  	name: '조회수합계',
	  	data: totUsesData,
	  	type: 'column'
	  },{
	    name: 'Sheet조회', // 데이터 시리즈 이름
	    data: sUsesData // 데이터 값 설정
	  },{
	    name: 'Chart조회', // 데이터 시리즈 이름
	    data: cUsesData // 데이터 값 설정
	  },{
	    name: 'Map조회', // 데이터 시리즈 이름
	    data: mUsesData // 데이터 값 설정
	  },{
	    name: 'File조회', // 데이터 시리즈 이름
	    data: fUsesData // 데이터 값 설정
	  },{
	    name: 'Link조회', // 데이터 시리즈 이름
	    data: lUsesData // 데이터 값 설정
	  },{
	    name: 'OpenAPI조회', // 데이터 시리즈 이름
	    data: aUsesData // 데이터 값 설정
	  },{
	    name: '멀티미디어조회', // 데이터 시리즈 이름
	    data: vUsesData // 데이터 값 설정
	  }
	  ]
	});
	
		// Highcharts 그래프 생성
	Highcharts.chart('mainChart2', {
	colors: ['#4CB699','#08216E','#395DB2','#26837B','#FF6E33','#06185C','#836E95','#727678']
	,
	  chart: {
	    type: 'line' // 선 그래프로 설정
	  },
	  title: {
	    text: '월별 다운로드 수' // 그래프 제목
	  },
	  xAxis: {
	    categories: categories // x축 레이블 설정
	  },
	  yAxis: {
	    title: {
	      text: '' // y축 레이블 설정
	    }
	  },
	  series: [{
	  	name: '다운로드합계',
	  	data: totDownData,
	  	type: 'column'
	  },{
	    name: 'EXCEL다운로드', // 데이터 시리즈 이름
	    data: excelDownData // 데이터 값 설정
	  },{
	    name: 'CSV다운로드', // 데이터 시리즈 이름
	    data: csvDownData // 데이터 값 설정
	  },{
	    name: 'JSON다운로드', // 데이터 시리즈 이름
	    data: jsonDownData // 데이터 값 설정
	  },{
	    name: 'XML다운로드', // 데이터 시리즈 이름
	    data: xmlDownData // 데이터 값 설정
	  },{
	    name: 'TXT다운로드', // 데이터 시리즈 이름
	    data: txtDownData // 데이터 값 설정
	  },{
	    name: 'FILE다운로드', // 데이터 시리즈 이름
	    data: fileDownData // 데이터 값 설정
	  }
	  ]
	});

	
		// Highcharts 그래프 생성
	Highcharts.chart('mainChart3', {
	colors: ['#08216E','#395DB2','#26837B','#FF6E33','#06185C','#727678','#836E95']
	,
	  chart: {
	    type: 'line' // 선 그래프로 설정
	  },
	  title: {
	    text: '월별 API 호출 수' // 그래프 제목
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
	    data: linkUsesData // 데이터 값 설정
	  },{
	    name: 'API호출', // 데이터 시리즈 이름
	    data: apisData // 데이터 값 설정
	  },{
	    name: 'API샘플호출', // 데이터 시리즈 이름
	    data: apissData // 데이터 값 설정
	  }
	  ]
	});

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
	
	data.seriesResult = [
				{columnNm : "Sheet"}
				, {columnNm : "Chart"}
				, {columnNm : "Map"}
				, {columnNm : "File"}
				, {columnNm : "Link"}
				, {columnNm : "API"}
				, {columnNm : "시각화"}
				, {columnNm : "엑셀저장"}
				, {columnNm : "CVS저장"}
				, {columnNm : "JSON저장"}
				, {columnNm : "XML저장"}
				, {columnNm : "TXT저장"}
				, {columnNm : "FILE저장"}
				, {columnNm : "Link클릭"}
				, {columnNm : "API호출"}
				, {columnNm : "API샘플"}
				//, {columnNm : "도내타기관"}
				//, {columnNm : "시각화"}
	                     ];
	
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
       	$.each(data.chartDataY,function(key,state){
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
		//if(YcolNm[i] == "INF_CNT" || YcolNm[i] == "SRV_CNT"){	// 공공데이터 수와 서비스 수는 꺽은선 그래프로 표현
   		series.SetProperty({  Type: IBChartType.LINE });	                                
   //	}else{													// 나머지는 전부 막대그래프로 표현
   //		series.SetProperty({  Type: IBChartType.COLUMN });
   //	}                        
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
	
}

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
						<input type="hidden" name="mode" value="<%=mode.replaceAll("<", "&lt;").replaceAll(">", "&gt;")%>"/>
						${sessionScope.button.btn_inquiry}
						${sessionScope.button.btn_xlsDown}       
					</td>
				</tr>
			</table>	
			</form>
				
					
				<!-- ibsheet 영역 -->
				<div style="display:flex; margin-bottom:50px;">
					<div id="pieChart1" class="chart" style="width:33%;"></div>
					<div id="pieChart2" class="chart" style="width:33%;"></div>
					<div id="pieChart3" class="chart" style="width:33%;"></div>
				</div>
				<div id="mainChart1" class="chart" style="margin-bottom:50px;"></div>
				<div id="mainChart2" class="chart" style="margin-bottom:50px;"></div>
				<div id="mainChart3" class="chart" style="margin-bottom:50px;"></div>
				<div class="ibsheet_area" style="height:600px;">
					<script type="text/javascript">createIBSheet("mySheet", "100%", "600px"); </script>             
				</div>
			</div>
			
		</div>
</div>
</body>
</html>