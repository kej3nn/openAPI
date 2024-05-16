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
<!--  
	validate 사용시 반드시 선언
	formName명과 validate 함수명이 연결되어있음
	userList -> validateuserList 체크함
	resources/validator/*.* xml을 만들어서 사용
  -->
<%-- <validator:javascript formName="userList" staticJavascript="false" xhtml="true" cdata="false"/> --%>
<script language="javascript">   
function tabSet(){ //탭 객체 생성  
	openTab = new OpenTab(tabId,tabContentClass,tabBody); //headinclude.jsp 변수 있음
	openTab.TabObj = openTab;  
	openTab.addTabClickEvent();    
}	

$(document).ready(function()    {    
	LoadPage();                                                               
	//doAction('search');                                              
	inputEnterKey();       
//	tabSet();// tab 셋팅
	init();
//	setTabButton();		//탭 버튼
	setDate(); //날짜
	doAction("search");
}); 

function init(){
	var formObj = $("form[name=userList]");
	formObj.find("input[name=pubDttmTo]").datepicker(setCalendar());          
	formObj.find("input[name=pubDttmFrom]").datepicker(setCalendar());      
	datepickerTrigger();     
	formObj.find("button[name=btn_search]").click(function(e) { 
		doAction("search");
		 return false;        
	 }); 
	
	formObj.find("button[name=btn_search]").eq(1).click(function(e) { 
		doAction("poporgnm");
		return false;               
	 }); 
	formObj.find("button[name=btn_search]").eq(2).click(function(e) { 
		doAction("popcatenm");
		return false;                  
	 }); 
	
	// 날짜 초기화
	formObj.find("button[name=btn_dttm]").click(function(e) { 
		formObj.find("input[name=pubDttmFrom]").val("");
		formObj.find("input[name=pubDttmTo]").val("");
	}); 
	
}

function setDate(){
	var formObj = $("form[name=userList]");
	var nowTo = new Date();	
	var nowFrom = new Date(nowTo-(3600000*24*30));	
	var yearFrom = nowFrom.getFullYear();
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
	var gridTitle = "NO"
		//gridTitle +="|"+"<spring:message code='labal.userId'/>";  
		gridTitle +="|"+"회원명>";  
		// +="|"+"<spring:message code='labal.userEmail'/>";
		//gridTitle +="|"+"<spring:message code='labal.userTel'/>";
		//gridTitle +="|"+"<spring:message code='labal.userHp'/>";        
		//gridTitle +="|"+"<spring:message code='labal.areaNm'/>";        
		//gridTitle +="|"+"<spring:message code='labal.memberNm'/>";        
		gridTitle +="|"+"<spring:message code='labal.userRegDttm'/>";
		
	
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
					{Type:"Seq",		SaveName:"seq",				Width:30,	Align:"Center",		Edit:false}
					,{Type:"Text",		SaveName:"userNm",			Width:50,	Align:"Left",		Edit:false}
					,{Type:"Text",		SaveName:"regDttm",			Width:80,	Align:"Center",		Edit:false}
                ];       
                                      
        InitColumns(cols);                                                                           
        FitColWidth();                                                         
        SetExtendLastCol(1);   
    }               
    default_sheet(mySheet); 
    mySheet.SetCountPosition(0); 
} 

/*Sheet 각종 처리*/                  
function doAction(sAction)                                  
{
	var classObj = $("."+tabContentClass); //tab으로 인하여 form이 다건임
	var actObj = setTabForm(classObj); // 0: form data, 1: form 객체
	switch(sAction)
	{          
		case "search":      //조회   
			var formObj = $("form[name=userList]");        
			fromObj = formObj.find("input[name=pubDttmFrom]");                          
			toObj = formObj.find("input[name=pubDttmTo]");
			dateValCheck(fromObj,toObj)// from , to 날짜 안맞을 경우 자동셋팅
			ajaxBeforeSendAdmin("<c:url value='/admin/ajaxBeforeSendAdmin.do'/>"); //IbSheet 조회전 세션 체크
			var param = {PageParam: "ibpage", Param: "onepagerow=50&"+actObj[0]};
			mySheet.DoSearchPaging("<c:url value='/admin/user/userListAll.do'/>", param);   
			break;
	}           
}   
//마우스 이벤트
function mySheet_OnSearchEnd(code, msg)
{
   if(msg != "")
	{
	    alert(msg);
    }
}

//마우스 이벤트
function OnSaveEnd()
{
	doAction("search");     
}           

function inputEnterKey(){
	$("input").keypress(function(e) {
		  if(e.which == 13) {
			  doAction('search');   
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
			<!-- 탭 -->
			<ul class="tab">
				<li class="all_list"><a href="#">전체목록</a></li>
			</ul>
			<div class="more_list" style="display:none">
				<a href="#" class="more">0</a>                
				<ul class="other_list" style="display:none;">
					<li><a href="#">보유데이터목록</a><a href="#" class="line_close">x</a></li>
					<li><a href="#">공공데이터목록</a><a href="#" class="line_close">x</a></li>
				</ul>
			</div>
			
			<!-- 탭 내용 -->
			<!-- 목록내용 -->
			<div class="content"  >
			<form name="userList"  method="post" action="#">
			<table class="list01">              
				<caption>회원목록</caption>
				<colgroup>
					<col width="150"/>
					<col width=""/>
				</colgroup>
				<tr>
					<th>검 색 어</th>
					<td colspan="3">
						<select name="searchWd">
		                 	<option value="1">회원명</option>
						</select>
						<input name="searchWord" type="text" value=""/>
						<button type="button" class="btn01B" name="btn_search"><spring:message code="btn.inquiry"/></button>
					</td>
				</tr>
				<tr>
					<th><label class=""><spring:message code="labal.userRegDttm"/></label></th>
					<td colspan="3">
						<input type="text" name="pubDttmFrom" value="" readonly="readonly"/>
						<input type="text" name="pubDttmTo" value="" readonly="readonly"/>     
						<button type="button" class="btn01" name="btn_dttm">날짜초기화</button>  
					</td>
				</tr>
				<%-- <tr>
					<th><label class=""><spring:message code="labal.areaNm"/></label></th>
					<td>
						<select name="areaCd">
							<option value="">선택</option>
							<c:forEach var="Area" items="${codeMap.area }">
								<option value="${Area.ditcCd}">${Area.ditcNm }</option>
							</c:forEach>	
						</select>    
					</td>
					<th><label class=""><spring:message code="labal.memberNm"/></label></th>
					<td>
						<select name="memberCd">
							<option value="">선택</option>
							<c:forEach var="Member" items="${codeMap.member }">
								<option value="${Member.ditcCd}">${Member.ditcNm }</option>
							</c:forEach>	
						</select>    
					</td>
				</tr> --%>
			</table>	
			</form>		
				<!-- ibsheet 영역 -->
				<div style="clear: both;"></div>
				<div class="ibsheet_area_both">
					<script type="text/javascript">createIBSheet("mySheet", "100%", "300px"); </script>             
				</div>
			</div>
			
		</div>
</div>
</body>
</html>