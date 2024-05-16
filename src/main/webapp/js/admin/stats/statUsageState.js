/*
 * @(#)statUsageState.js 1.0 2018/01/29
 */

/**
 * 관리자 통계 활용현황 스크립트 파일이다
 *
 * @author 김정호
 * @version 1.0 2018/01/29
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
	//$("input[name=startYmd], input[name=endYmd]").removeClass('hasDatepicker').datepicker(setCalendar());
	$("input[name=startYmd], input[name=endYmd]").datepicker(com.wise.help.datepicker({
        buttonImage:com.wise.help.url("/images/admin/icon_calendar.png")
    }));
	
	$('input[name=startYmd]').datepicker('option', 'onClose',  function( selectedDate ) {$("input[name=endYmd]").datepicker( "option", "minDate", selectedDate );});
	$('input[name=endYmd]').datepicker('option', 'onClose',  function( selectedDate ) {	$("input[name=startYmd]").datepicker( "option", "maxDate", selectedDate );});
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
	//doAction("searchChart");
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
			sheet.DoSearchPaging(com.wise.help.url("/admin/stat/statUsageStateList.do"), { Param : $("form[name=statOpen]").serialize() });
			
			//doAction("searchChart");
			break;
		case "searchChart":
			doSelect({
				url:"/admin/stat/statUsageStateChart.do",
			    	before:function () {return {
			    		startYmd: $("input[name=startYmd]").val(),
			        	endYmd: $("input[name=endYmd]").val() 
			        };},
			        after: afterStatUsageStateChart
			    });
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
function afterStatUsageStateChart(data) {
	var varColor = "Purple";
	myChart.RemoveAll();
	var obj = myChart;
	initChart(obj);//차트 기본색상 셋팅
	rytitNm = "건수";
	//X축 스타일                   
	initXStyleChart(obj,varColor, varColor, "일자");//chartObj, x색, y색, 이름
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

	data.seriesResult = [
				{columnNm : "통계메타"}
				, {columnNm : "통계표"}
				, {columnNm : "Excel다운"}
				, {columnNm : "CSV다운"}
				, {columnNm : "JSON다운"}
				, {columnNm : "XML다운"}
				, {columnNm : "TXT다운"}
			];
	
	for(var i=0; i < data.seriesResult.length ; i++){    
		var tp = [];
		var name = [];

		//X축 column 이름 넣기 
       	for(var k=0; k < data.chartDataX.length ; k++){
       		name[k] = data.chartDataX[k][XcolNm[0]]
    	}
       	
       	
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
   		series.SetProperty({  Type: IBChartType.LINE });	                                
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
////////////////////////////////////////////////////////////////////////////////
//시트 로드
////////////////////////////////////////////////////////////////////////////////
function loadSheet() {
	
	createIBSheet2(document.getElementById("sheet"),"sheet", "100%", "600px");
	
	var gridTitle ="NO";
	gridTitle +="|월";
	gridTitle +="|구분";
	gridTitle +="|조회수";
	gridTitle +="|변환수(합계)";
	gridTitle +="|엑셀 변환";
	gridTitle +="|CSV 변환";
	gridTitle +="|JSON 변환";
	gridTitle +="|XML 변환";
	gridTitle +="|TXT 변환";
	gridTitle +="|HWP 변환";
	
	with(sheet){
		                     
		var cfg = {SearchMode:2,Page:50,VScrollMode:1,MergeSheet: 7}; 
	    SetConfig(cfg);
	    var headers = [
	                {Text:gridTitle, Align:"Center"}
	            ];
	    var headerInfo = {Sort:0,ColMove:1,ColResize:1,HeaderCheck:0};
	    
	    InitHeaders(headers, headerInfo);
	   
	    var cols = [
	                 {Type:"Seq",		SaveName:"seq",			Width:30,	Align:"Center",		Edit:false}
	                ,{Type:"Text",		SaveName:"yyyymmdd",	Width:120,	Align:"Center",		Edit:false} 
					,{Type:"Combo",		SaveName:"useIpTag",	Width:120,	Align:"Center",		Edit:false}
					,{Type:"AutoSum",	SaveName:"statblCnt",	Width:150,	Align:"Center",		Edit:false,	Format : "Integer"}
					,{Type:"AutoSum",	SaveName:"downCnt",		Width:150,	Align:"Center",		Edit:false,	Format : "Integer"}
					,{Type:"AutoSum",	SaveName:"excelCnt",	Width:150,	Align:"Center",		Edit:false,	Format : "Integer"}
					,{Type:"AutoSum",	SaveName:"csvCnt",		Width:150,	Align:"Center",		Edit:false,	Format : "Integer"}
					,{Type:"AutoSum",	SaveName:"jsonCnt",		Width:150,	Align:"Center",		Edit:false,	Format : "Integer"}
					,{Type:"AutoSum",	SaveName:"xmlCnt",		Width:150,	Align:"Center",		Edit:false,	Format : "Integer"}
					,{Type:"AutoSum",	SaveName:"txtCnt",		Width:150,	Align:"Center",		Edit:false,	Format : "Integer"}
					,{Type:"AutoSum",	SaveName:"hwpCnt",		Width:150,	Align:"Center",		Edit:false,	Format : "Integer"}
	            ];                                          
	    InitColumns(cols);
	    FitColWidth();
	    SetExtendLastCol(1);
	    
	    loadSheetOptions("sheet", 0, "useIpTag", "/admin/stat/ajaxOption.do", {grpCd:"C1023"});
	    
	    SetSumValue(0, "yyyymmdd", "합계"); 
	    SetAutoSumPosition("1"); //autoSum 위치 지정 1은 최하단 0은 최상단 
	}               
	default_sheet(sheet);   
	
}

function sheet_OnSearchEnd(code, message, statusCode, statusMessage) {
	// 검색구분이 전체인 경우
	if ( gfn_isNull($("#useIpTag").val()) ) {
		for ( var i=1; i <= sheet.RowCount(); i++ ) {
			// 전체만 합계 집계
			if ( sheet.GetCellValue(i, "useIpTag") != "A" ) {
				sheet.SetRowSumable(i, 0);
			}
		}
	}
}

