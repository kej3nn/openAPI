<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
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
<script language="javascript">

$(document).ready(function()    {
	LoadPage();
	LoadPage2();
	setDate();
	doAction('search');
	doAction('search2');
	inputEnterKey();
	setButton();
});    

function setDate(){
	var formObj = $("form[name=menuLog]");
	var now = new Date();		
	var year = now.getFullYear();
	var mon = (now.getMonth()+1)>9?now.getMonth()+1:'0'+(now.getMonth()+1);
	var day = now.getDate()>9?now.getDate():'0'+now.getDate();
	var date=year+'-'+mon+'-'+day;
	formObj.find("input[name=fnlLoadDtm]").val(date);
	formObj.find("input[name=fnlLoadDtm]").datepicker(setCalendar()); 
	formObj.find("input[name=fnlLoadEndDtm]").val(date);             
	formObj.find("input[name=fnlLoadEndDtm]").datepicker(setCalendar());                        
}
function setButton(){
 	$("button[name=btn_search]").click(function(){
		doAction("search");
		doAction('search2');                 
		return false;
	});
}
function LoadPage()                
{      
  	//message-common_ko_KR.properties 선언 후 사용 or message-common_en_US.properties 선언 후 사용
	var gridTitle = "NO";
		gridTitle +="|"+"시스템";
		gridTitle +="|"+"메뉴명";  
		gridTitle +="|"+"사용자IP";
		gridTitle +="|"+"접속일시";  
	
    with(mySheet){    
    	                     
    	var cfg = {SearchMode:2,Page:50,VScrollMode:1};                                
        SetConfig(cfg);  
        var headers = [                                                      
                    {Text:gridTitle, Align:"Center"}                 
                ];
        var headerInfo = {Sort:0,ColMove:1,ColResize:1,HeaderCheck:0};
        InitHeaders(headers, headerInfo); 
        var cols = [                   
					 {Type:"Seq",			SaveName:"Seq",						Width:70,	Align:"Center",		Edit:false}
			 		,{Type:"Text",			SaveName:"sysTag",					Width:100,	Align:"Center",		Edit:false}
					,{Type:"Text",			SaveName:"menuNm",					Width:200,	Align:"Left",		Edit:false}
					,{Type:"Text",			SaveName:"userIp",					Width:120,	Align:"Center",		Edit:false}
					,{Type:"Text",			SaveName:"regDttm",				Width:200,	Align:"Center",		Edit:false}        
                ];
        InitColumns(cols);                                                                              
        SetExtendLastCol(1);            
    }                                
    default_sheet(mySheet);                   
    datepickerTrigger();
}    
      

function LoadPage2()                
{      
  	//message-common_ko_KR.properties 선언 후 사용 or message-common_en_US.properties 선언 후 사용
	var gridTitle = "NO";
		gridTitle +="|"+"시스템";
		gridTitle +="|"+"메뉴명";  
		gridTitle +="|"+"접속횟수";
		gridTitle +="|"+"접속일자";  
	
    with(mySheet2){                   
    	                     
    	var cfg = {SearchMode:3,Page:50};                                
        SetConfig(cfg);  
        var headers = [                                                      
                    {Text:gridTitle, Align:"Center"}                 
                ];
        var headerInfo = {Sort:0,ColMove:1,ColResize:1,HeaderCheck:0};
        InitHeaders(headers, headerInfo); 
        var cols = [                   
					 {Type:"Seq",			SaveName:"Seq",						Width:70,	Align:"Center",		Edit:false}
			 		,{Type:"Text",			SaveName:"sysTag",					Width:100,	Align:"Center",		Edit:false}
					,{Type:"Text",			SaveName:"menuNm",					Width:200,	Align:"Left",		Edit:false}
					,{Type:"Text",			SaveName:"logCnt",					Width:120,	Align:"Center",		Edit:false}
					,{Type:"Text",			SaveName:"regDttm",				Width:200,	Align:"Center",		Edit:false}        
                ];
        InitColumns(cols);                                                                              
        SetExtendLastCol(1);            
    }                                
    default_sheet(mySheet2);                   
}    
                         
/*Sheet 각종 처리*/                  
function doAction(sAction)                                  
{
	switch(sAction)
	{              
		case "search":      //조회   
			var formObj = $("form[name=menuLog]");        
			fromObj = formObj.find("input[name=fnlLoadDtm]");                          
			toObj = formObj.find("input[name=fnlLoadEndDtm]");
			dateValCheck(fromObj,toObj)// from , to 날짜 안맞을 경우 자동셋팅 
			ajaxBeforeSendAdmin("<c:url value='/admin/ajaxBeforeSendAdmin.do'/>"); //IbSheet 조회전 세션 체크
			var param = {PageParam: "ibpage", Param: "onepagerow=50&"+formObj.serialize()};     
			mySheet.DoSearchPaging("<c:url value='/admin/monitor/menuLogList.do'/>", param);   
			break;
			
		case "search2":      //조회   
			var formObj = $("form[name=menuLog]");        
			fromObj = formObj.find("input[name=fnlLoadDtm]");                          
			toObj = formObj.find("input[name=fnlLoadEndDtm]");
			dateValCheck(fromObj,toObj)// from , to 날짜 안맞을 경우 자동셋팅 
			ajaxBeforeSendAdmin("<c:url value='/admin/ajaxBeforeSendAdmin.do'/>"); //IbSheet 조회전 세션 체크
			var param = {PageParam: "ibpage", Param: "onepagerow=50&"+formObj.serialize()};     
			mySheet2.DoSearchPaging("<c:url value='/admin/monitor/menuLogList2.do'/>", param);                    
			break;
	}           
}   

//마우스 이벤트
function mySheet_OnSearchEnd(code, msg)
{                
	
	mySheet.FitColWidth("8|14|43|15|20");    
   if(msg != "")      
	{
	    alert(msg);
    }      
}   

function mySheet2_OnSearchEnd(code, msg)
{                
	                    
	mySheet2.FitColWidth("8|14|43|15|20");    
   if(msg != "")      
	{
	    alert(msg);
    }      
}   


function inputEnterKey(){
	$("input").keypress(function(e) {
		  if(e.which == 13) {
			  $("button[name=btn_search]").click();                  
			  return false;
		  }
	});
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
		
		<div class="popup" style="padding: 20px;"> 
			<form name="menuLog"  method="post" action="#">
			<table class="list01">              
				<caption>회원목록</caption>
				<colgroup>
					<col width="150"/>
					<col width=""/>
				</colgroup>
				<th>시스템</th>
				<td>
					<input type="radio" name="searchWd" id="A" value=""/>
					<label for="A">전체</label>
					<input type="radio" name="searchWd" id="K" value="K" checked="checked"/>
					<label for="K">PC</label>
					<!-- <input type="radio" name="searchWd" id="E" value="E"/>
					<label for="E">영문</label> -->
					<input type="radio" name="searchWd" id="M" value="M"/>
					<label for="M">모바일</label>
				</td>
				</tr>                               
				<tr>
					<th>메뉴명</th>
					<td>
						<input name="searchWord" type="text" value=""/>
						<button type="button" class="btn01B" name="btn_search"><spring:message code="btn.inquiry"/></button>
					</td>
				</tr>
				<tr>
					<th><label class="">접속일자</label></th>
					<td>
						<input type="text" name="fnlLoadDtm" value="" readonly="readonly"/>
						<input type="text" name="fnlLoadEndDtm" value="" readonly="readonly"/>
					</td>
				</tr>
			</table>	
			</form>		
				<!-- ibsheet 영역 -->
				
				<div style="width:50%;float:left;">
					<div style="border:1px solid #c0cbd4;padding:10px;margin:0 15px 0 0;">
						<script type="text/javascript">createIBSheet("mySheet", "100%", "500px"); </script> 
					</div>                                                      
				</div>
								                                              
				<div style="width:50%;float:right;">
					<div style="border:1px solid #c0cbd4;padding:10px;">
						<script type="text/javascript">createIBSheet("mySheet2", "100%", "500px"); </script>                                                            
					</div>        
				</div>                        
			</div>                                
	</div>	
</div>
</body>
</html>