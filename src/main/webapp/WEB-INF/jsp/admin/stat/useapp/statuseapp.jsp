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
	
	
	$.post(getContextPath+'/admin/mainmng/selectListCate.do', function(data){
		var formObj = $("form[name=statOpen]");
		var select = formObj.find("select[name=cateId]");
		$.each(data.DATA, function(i, data) {
			select.append('<option value="' + data.cateId + '">'+data.cateNm+'</option>');
		});
	});

}


function setDate(){
		var formObj = $("form[name=statOpen]");
		var nowTo = new Date();	
		var nowFrom = new Date();	
		var yearFrom = nowFrom.getFullYear()-1;
		var yearTo = nowTo.getFullYear();
		var monFrom = (nowFrom.getMonth()+1)>9?nowFrom.getMonth()+1:'0'+(nowFrom.getMonth()+1);
		var monTo = (nowTo.getMonth()+1)>9?nowTo.getMonth()+1:'0'+(nowTo.getMonth()+1);
		var dayFrom = nowFrom.getDate()>9?nowFrom.getDate():'0'+nowFrom.getDate();
		var dayTo = nowTo.getDate()>9?nowTo.getDate():'0'+nowTo.getDate();
		var dateFrom=yearFrom+'-'+monFrom+'-'+dayFrom;
		var dateTo=yearTo+'-'+monTo+'-'+dayTo;
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
	    gridTitle +="|"+"대분류"
		gridTitle +="|"+"소분류";
		gridTitle +="|"+"데이터셋명";
		gridTitle +="|"+"제공기관";	
		gridTitle +="|"+"개방서비스";	
		gridTitle +="|"+"평가횟수";	
		gridTitle +="|"+"평가평균점수";
	
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
					 ,{Type:"Text",		SaveName:"cateNmTop",			Width:50,	Align:"Center",		Edit:false}
					 ,{Type:"Text",		SaveName:"cateNm",			Width:50,	Align:"Center",		Edit:false}
					 ,{Type:"Text",		SaveName:"infNm",			Width:120,	Align:"Left",		Edit:false}
					 ,{Type:"Text",		SaveName:"orgNm",			Width:50,	Align:"Center",		Edit:false}
					 ,{Type:"Html",		SaveName:"openSrv",			Width:80,	Align:"Center",		Edit:false}
					,{Type:"Text",		SaveName:"apprCnt",			Width:50,	Align:"Right",		Edit:false}
					,{Type:"Text",		SaveName:"apprVal",			Width:50,	Align:"Right",		Edit:false}
					
                   ];       
                                      
        InitColumns(cols);                                                                           
        FitColWidth();                                                         
        SetExtendLastCol(1);   
    }               
    default_sheet(mySheet); 
    mySheet.SetCountPosition(0); 
//    mySheet.SetSumValue(0,"yyyyMmDd","합계");
//    mySheet.SetAutoSumPosition("1"); //autoSum 위치 지정 1은 최하단 0은 최상단
} 

/*Sheet 각종 처리*/                  
function doAction(sAction){
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
			mySheet.DoSearchPaging("<c:url value='/admin/stat/useapp/getUseAppStatSheetAll.do'/>", param);   
			break;

		case "excel": 
			mySheet.Down2Excel({FileName:'활용성평가내역.xls',SheetName:'mySheet'});
			break;
		
	}           
}
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
					</td>
				</tr>
					<tr>
						<th>대분류</th>
						<td colspan="3">
							<select name="cateId">
								<option value="">전체</option>							
							</select>
						</td>
					</tr>
					<tr>
						<th>공공데이터명</th>
						<td colspan="3">
							<input type="text" name="infNm" style="width:200px; ime-mode:active;" value=""/>
							${sessionScope.button.btn_inquiry}
							${sessionScope.button.btn_xlsDown}       
						</td>
					</tr>
			</table>	
			</form>
				
					
				<!-- ibsheet 영역 -->
				<div class="ibsheet_area" style="height:600px;">
					<script type="text/javascript">createIBSheet("mySheet", "100%", "600px"); </script>             
				</div>
			</div>
			
		</div>
</div>
</body>
</html>