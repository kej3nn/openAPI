<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="egovframework.common.WiseOpenConfig"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<c:import  url="/WEB-INF/jsp/inc/headinclude.jsp"/>

<style type="text/css">
body{background:none;} /* 임시로 해놓은 것임 */
</style>
<script language="javascript">
/*
sheet2chart()  함수   : 시트의 내용을 차트로 만들어 줌. (공통js 에 넣어 사용 할 것.)
params 내부 변수
datadirection : 데이터를 만들기 위해 시트의 내용을 읽어들이는 방향(vertical/horizontal 중 선택, default : vertical  )
labeldirection : x축 레이블을 읽어 들이는 방향(vertical/horizontal 중 선택, default : vertical  )
datarowcol : 데이터를 읽어들일 컬럼 혹은 로우,읽어들이는 방향이 vertical인 경우에는 col
                    ,horizontal인 경우에는 row를 구분자 "|" 연결하여 넣는다.(필수)
labelrowcol : x축 레이블이 될 행이나 열. 하나만 선택 한다.
startdatarowcol : 데이터가 될 시작 행 혹은 열 (default : 첫번째 행/열)
enddatarowcol : 데이터가 될 마지막 행 혹은 열(default : 마지막 행/열)
startlabelrowcol : x축 레이블이 될 첫번째 행이나 열  
endlabelrowcol : x축 레이블이 될 마지막 행이나 열 
legendtitle : 범례 타이틀 (default:범례)   
legendseriesname : 범례에 나올 시리즈별 이름 (datarowcol 의 개수와 동일해야 함.)
주의 : startlabelrowcol,endlabelrowcol,labelrowcol 중에 하나만 없어도 x축 레이블은 안만들어 진다.
*/
$(document).ready(function()    {         
	reSizeIframePop();
	LoadPage();
	LoadPage2();	//다운로드 하기위한 ibSheet 초기화
	
	$("a[name=a_close]").click(function(e) { 
		window.close();
		return false;                             
	 });
	
	$("a[name=btn_print]").click(function(e) { 
		printPage();
		return false;        
	});
	$("a[name=btn_excelDownload]").click(function(e) {  
		var info = {DownHeader:1, FileName:"Survey_Ans_Data", Merge:1, SheetDesign:1, ExcelFontSize:10};
		mySheet.Down2Excel(info);
		return false;        
	});
});  

//차트를 그린다.
function drawChart() {
	var totalQuestCnt = Number($("input[name=totalQuestCnt]").val());
	for ( var i=1; i < totalQuestCnt+1; i++ ) {
		initChart(eval("SurveyAnsChart_"+i), "SurveyAns_"+i, eval("SurveyAns_"+i));
	}
}

function LoadPage() {
	var formObj = $("form[name=surveyAnsPop]");
	var totalQuestCnt = Number($("input[name=totalQuestCnt]").val());
	var sheetName, chartName;
	var startDt = new Date();	//조회시작시간
	for ( var i=1; i < totalQuestCnt+1; i++ ) {		//문항 갯수만큼 시트, 차트 세팅
		formObj.find("input[name=questSeq]").val(i);
		sheetName = "SurveyAns_"+i;
		chartName = "SurveyAnsChart_"+i;
 		createIBSheet2(document.getElementById(sheetName), sheetName, "100%", "300px");		//시트 동적세팅
		createIBChart2(document.getElementById(chartName), chartName, "100%", "300px");		//차트 동적세팅
		sheetSet(window[sheetName]);
	}
	var endDt = new Date();		//조회종료시간
	//경과시간만큼(0.5초는 보너스) 딜레이 준다. 왜그런지 모르겠지만 동적으로 하다보니 딜레이 안주니 ibchart 오류남... 샹.. 함수를 밖으로 빼도 안됨.
	setTimeout("drawChart()", (endDt.getSeconds() - startDt.getSeconds() + 1)*500);	
}

//시트 세팅후 조회
function sheetSet(sheetName) {
	var gridTitle ="";//"NO";
	var gridEngTitle="NO";
	<c:forEach var="head" items="${head}" varStatus="status">
		//gridTitle +="|"+'${head.colNm}';  
		gridTitle +='${head.colNm}' + '|';  
	</c:forEach>
	//gridTitle += "|";
	with(sheetName)
	{
		var cfg = {SearchMode:2,Page:50};
		SetConfig(cfg);
		var headers = [                               
	                    {Text:gridTitle, Align:"Center"}                 
	                ];
		var headerInfo = {Sort:0,ColMove:1,ColResize:1,HeaderCheck:0};
        
        InitHeaders(headers, headerInfo); 
        
        var cols = [          
					 {Type:"Text",		SaveName:"EXAM_NM",			Width:180,	Align:"Center",		Edit:false}
					 <c:forEach var="head" items="${head}" varStatus="status">
					 <c:if test="${not status.first }" >
					 ,{Type:"Float",		SaveName:"${head.colId}",			Width:100,	Align:"Center",		Edit:false}
					 </c:if>
					</c:forEach>
               ];
        
        InitColumns(cols);
        FitColWidth();
        doAction("search", sheetName);
	}
}

function doAction(sAction, SheetName)
{
	var formObj = $("form[name=surveyAnsPop]");
	ajaxBeforeSendAdmin("<c:url value='/admin/ajaxBeforeSendAdmin.do'/>"); //IbSheet 조회전 세션 체크
	switch(sAction)
	{
		case "search" :
			var url ="<c:url value='/admin/bbs/surveyAnsListPopupListAll.do'/>";
			//alert(formObj.serialize());
 			//ajaxCallAdmin(url, formObj.serialize(), colcallback);
 			var param = {PageParam: "ibpage", Param: "onepagerow=50&"+formObj.serialize()};
 			SheetName.DoSearchPaging(url, param);
			break;
		case "exportSearch":      	//다운로드하기 위한 조회
			var param = {PageParam: "ibpage", Param: "onepagerow=50&"+formObj.serialize()};
			mySheet.DoSearchPaging("<c:url value='/admin/bbs/surveyAnsListPopupExport.do'/>", param);
			break; 
	}
	
}

//프린트
function printPage()
{
	var initBody;
	window.onbeforeprint = function() {
		initBody = document.body.innerHTML;
		document.body.innerHTML = document.getElementById('print').innerHTML;
	};
	window.onafterprint = function() {
		document.body.innerHTML = initBody;
	};
	window.print();
	return false;
}

function initChart(chartName, sheetNameId, sheetName){

	//건수(0:전체, 1:1개)
	var view = 0;
	//var type = getSeriesType();
	var type = IBChartType.COLUMN;
	
	var cnt = sheetNameId.substring(sheetNameId.indexOf("_")+1, sheetNameId.length);	//이름에 붙어있는 번호를 가져온다.
	var title = $("#questNm_"+cnt).text();	//차트 제목
	title = title.substring(title.indexOf(".")+1, title.length);	// 1. 제목(.이후부터 텍스트만 입력)
	if(view == 0){
		
		/* if(type=="pie"){				
			Row = mySheet.GetSelectRow();		
		}else{
			var start = mySheet.HeaderRows()
			,end = mySheet.LastRow()+1;
			
			Row = start+"-"+end;				
			
		} */
		
	}else{
		//Row = mySheet.GetSelectRow();
		Row = 1;
	}
	
	Row = "1-" + sheetName.LastRow();
	Col = "1-" + sheetName.LastCol();
	
	chartName.SetOptions({
			//1. 제목
			Title:{								//myChart.SetTitleOptions();
				Text:title
				
// 				,Align:"center" //가로정렬(left,right,center)
// 				,VerticalAlign:"top"//상하정렬(top,middle,bottom)
// 				,Floating:false//플로팅여부(true로 설정시 다른 객체와 겹쳐질수 있음)
				,Style:{ //글자 스타일(css형식)
					Color:"#6655FF"
					,FontWeight:700
				}
			}
			//2. 부제목
			/* 
			,SubTitle:{							//myChart.SetSubtitleOptions();
				Text:"부 제목 입니다."
// 				,Align:"center" //left,right,center
// 				,VerticalAlign:"top"//top,middle,bottom
// 				,Floating:false
			}
			 */
			//3. 차트 종류,크기 설정
			,Chart:{
				Type:type //차트유형(line,spline,pie,bar,area,scatter)
				,BackgroundColor:"#EDEDED" //차트 전체 배경색
				,PlotBackgroundColor:"#ADADAD" //Plot 영역에 대한 배경색
				,ZoomType:"y" //확대기능 사용 축 (x,y,xy)
			}
//				4. 범례영역 지정
//				,Legend:{					//myChart.SetLegendOptions();
//					Align:"right" //가로정렬(left,right,center)
//					,VerticalAlign:"middle"//상하정렬(top,middle,bottom)
//					,Layout:"vertical"//가로,세로 정렬(vertical,horizontal)
//				}
			//5. Y축설정
		    ,YAxis : [{
		    	Title : {
	 		    	Text : ""
		    	}
			    ,Labels:{
	 				Formatter:function(){
	 					return this.value + "%";
	 				}
	 			}
	 			,Min:0				// 최소값
				,Max:100			// 최대값
				,TickInterval:20			// 간격
		    }]
			//6. 시트연동
		    ,Data:{		    	
		    	Sheet: sheetNameId//대상 시트의 id
		    	,HeaderRow:0//헤더로 설정할 행의 Index (default: 헤더의 마지막 행)
		    	,HeaderCol:0//헤더로 설정할 컬럼의 Index 또는 SaveName (default: 헤더의 첫번째 컬럼)
		    	,Rows:Row//대상행의 Index
		    	,Cols:Col//대상컬럼의 Index
/* 		    	,Rows:"1-5"//대상행의 Index
		    	,Cols:"1-4"//대상컬럼의 Index */
		    	,SwitchRowCol:true//반전
		    }
			//7. X축설정
			,XAxis:{
				Categories:true   //X축 라벨
			}
			,PlotOptions:{
		    	Series:{
					DataLabels:{
						Enabled:true//데이터값 표시
					}			    		
		    		
		    	}    	
		    }
			
	});
	
	chartName.Draw();
}

function LoadPage2()
{   
	var gridTitle = "응답자 번호"
		gridTitle +="|응답자 유형";        
		gridTitle +="|설문번호";        
		gridTitle +="|문항타입";        
		gridTitle +="|문항";        
		gridTitle +="|답변";

		with(mySheet){
    	                     
    	var cfg = {SearchMode:3,Page:50,VScrollMode:1};                                
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
					 {Type:"Int",		SaveName:"ansSeq",			Width:100,	Align:"Center",		Edit:false}
					,{Type:"Text",		SaveName:"ansNm",			Width:100,	Align:"Center",		Edit:false}
					,{Type:"Text",		SaveName:"questNo",			Width:100,	Align:"Center",		Edit:false}
					,{Type:"Text",		SaveName:"examNm",			Width:100,	Align:"Center",		Edit:false}
					,{Type:"Text",		SaveName:"questNm",			Width:100,	Align:"Left",		Edit:false}
					,{Type:"Text",		SaveName:"examAns",			Width:100,	Align:"Left",		Edit:false}
                ];       
                                      
        InitColumns(cols);                                                                           
        FitColWidth();                                                         
        SetExtendLastCol(1);   
    }               
    doAction("exportSearch");	//IBS 조회
} 

</script>
</head>                                          
<body>
	<div class="wrap-popup">
		<!-- 내용 -->
		<div class="container" id="print">
			<div class="buttons">
				<a href="#" class="btn02" name="btn_excelDownload">엑셀 다운로드</a>
				<a href="#" class="btn02" name="btn_print">인쇄</a>
			</div>
			
			<!-- 상단 타이틀 -->
			<div class="title">
				<h2>설문 결과</h2>
			</div>
				<table class="list01" style="position:relative;">
					<tr>
						<td colspan="5" align="center">
							<b>${ansList.surveyNm }</b>
						</td >
					</tr>
					<tr>
						<td colspan="5">
							목적 : ${ansList.surveyPpose}
						</td>
					</tr>
					<tr>
						<td colspan="5">
							기간 : ${ansList.startDttm} ~ ${ansList.endDttm} 
						</td>
					</tr>
					<tr>
						<td colspan="5">
							참여 : 총 ${totalCnt }명 ( 
							<c:forEach var="aCnt" items="${cntList }" varStatus="status" step='1'>
								<c:if test="${status.last }"></c:if>
								${aCnt.ditcNm} : ${aCnt.ditcCnt }명<c:if test="${not status.last }">,</c:if>
							</c:forEach>
							)
						</td>
					</tr>
					<tr>
						<td colspan="5">
							<spring:message code="labal.orgCd"/> : ${ansList.orgNm }
						</td>
					</tr>
				</table>
			<a></a>
			
			<p class="text-title3">설문결과</p>
			<form name="surveyAnsPop" method="post" action="#">
				<input type="hidden" name="surveyId" value="${ansList.surveyId }">
				<input type="hidden" name="questSeq">
				<input type="hidden" name="totalQuestCnt" value="${totalQuestCnt }">
				
				
				<table class="list04">
					<caption>설문</caption>
					<colgroup>
						<col width=""/>
						<col width=""/>
					</colgroup>
					
					<c:forEach var="questCnt" items="${questCnt }" varStatus="status">
					<tr>
						<th id="questNm_${status.index+1 }">${status.index+1 }. ${questCnt.questNm }</th>
					</tr>
					<tr>
						<td>
							<ul>
								<div class="survey-box">
								<div style="width:50%;float:left;">
									<div class="ibsheet_area" name="SurveyAns_${status.index+1 }" id="SurveyAns_${status.index+1 }" style="margin:0 10px 0 0;">        
									</div>
								</div>
								
								<div style="width:50%;float:left;">
									<div class="ibsheet_area" name="SurveyAnsChart_${status.index+1 }" id="SurveyAnsChart_${status.index+1 }" value="${status.index+1 }" style="margin:0 10px 0 0;">        
									</div>
								</div>
							</ul>
						</td>
					</tr>
					</c:forEach>
					
				</table>
				<!-- ibsheet 영역 -->
				<div class="ibsheet_area" style="display:none;">
					<script type="text/javascript">createIBSheet("mySheet", "100%", "300px"); </script>             
				</div>     
			</div>
			</form>
			
	
	</div>
	
</body>
</html>

