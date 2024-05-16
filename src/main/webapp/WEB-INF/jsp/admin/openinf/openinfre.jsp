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
	openInfRe -> validateopenInfRe 체크함
	resources/validator/*.* xml을 만들어서 사용
  -->
<%-- <validator:javascript formName="openInfRe" staticJavascript="false" xhtml="true" cdata="false"/> --%>
<script language="javascript">   

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
	var formObj = $("form[name=openInfRe]");
	formObj.find("input[name=pubDttmTo]").datepicker(setCalendar());          
	formObj.find("input[name=pubDttmFrom]").datepicker(setCalendar());      
	datepickerTrigger();     
	formObj.find("button[name=btn_search]").click(function(e) { 
		doAction("search");
		 return false;        
	 }); 
	/*
	formObj.find("button[name=btn_search]").eq(1).click(function(e) { 
		doAction("poporgnm");
		return false;               
	 });
	*/
	$("button[name=btn_del]").click(function(e) {
		doAction("update");
	});
}

function setDate(){
	var formObj = $("form[name=openInfRe]");
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
	var gridTitle = "  "
		//gridTitle +="|"+"  ";

		gridTitle +="|"+"NO";
		gridTitle +="|"+"<spring:message code='labal.infNm'/>";  
		gridTitle +="|"+"조직명";  
		gridTitle +="|"+"댓글";
		gridTitle +="|"+"<spring:message code='labal.regDttm'/>";
		gridTitle +="|"+"<spring:message code='labal.delYn'/>";
		gridTitle +="|"+"  ";
		gridTitle +="|"+"  ";

	
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
					 {Type:"Status",	SaveName:"status",			Width:50,	Align:"Left",		Edit:false, Hidden:true}
					,{Type:"Seq",		SaveName:"seq",				Width:30,	Align:"Center",		Edit:false}
					,{Type:"Text",		SaveName:"infNm",			Width:80,	Align:"Left",		Edit:false}
					,{Type:"Text",		SaveName:"orgNm",			Width:50,	Align:"Left",		Edit:false}
					,{Type:"Text",		SaveName:"reCont",			Width:100,	Align:"Left",		Edit:false}
					,{Type:"Text",		SaveName:"regDttm",			Width:50,	Align:"Center",		Edit:false}
					,{Type:"CheckBox",	SaveName:"delYn",			Width:30,	Align:"Center",		Edit:true,TrueValue:"Y", FalseValue:"N", DefaultValue:"N"}
					,{Type:"Text",		SaveName:"infId",			Width:50,	Align:"Left",		Edit:false, Hidden:true}
					,{Type:"Text",		SaveName:"reSeq",			Width:50,	Align:"Left",		Edit:false, Hidden:true}
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
			var formObj = $("form[name=openInfRe]");        
			fromObj = formObj.find("input[name=pubDttmFrom]");                          
			toObj = formObj.find("input[name=pubDttmTo]");
			dateValCheck(fromObj,toObj)// from , to 날짜 안맞을 경우 자동셋팅
			ajaxBeforeSendAdmin("<c:url value='/admin/ajaxBeforeSendAdmin.do'/>"); //IbSheet 조회전 세션 체크
			var param = {PageParam: "ibpage", Param: "onepagerow=50&"+actObj[0]};
			mySheet.DoSearchPaging("<c:url value='/admin/openinf/openInfReListAll.do'/>", param);   
			break;
		case "update":
			ibsSaveJson = mySheet.GetSaveJson(0);	//트랜잭션 발생한 행의 데이터를 객체로 받기
			if(ibsSaveJson.data.length == 0) return;
			var url = "<c:url value='/admin/user/updateOpenInfRe.do'/>"; 
			var param = ""; 
			IBSpostJson(url, param, saveCallBack1);	
			break;
			/*case "poporgnm":
			var url="<c:url value="/admin/basicinf/popup/commOrg_pop.do"/>";
			var popup = OpenWindow(url,"orgPop","500","550","yes");	    
			break;
		case "popcatenm":
			alert("분류정보");
			break;*/
	}           
}   
function saveCallBack1(res){      
    alert(res.RESULT.MESSAGE);
    doAction("search");
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
				<!--<h2>댓글 관리</h2>                                      
				<p>고객센터 &gt; 댓글 관리</p>  -->         
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
			
			
			<!-- 목록내용 -->
			<div class="content"  >
			<form name="openInfRe"  method="post" action="#">
			<table class="list01">              
				<caption>회원목록</caption>
				<colgroup>
					<col width="150"/>
					<col width=""/>
				</colgroup>
				<tr>
					<th>검색어</th>
					<td colspan="3">
						<select name="searchWd">
							<option value="">선택</option>
							<option value="0" selected="selected">공공데이터명</option>
		                 	<option value="1">조직명</option>
						</select>
						<input name="searchWord" type="text" value=""/>
						<button type="button" class="btn01" name="btn_search"><spring:message code="btn.inquiry"/></button>
					</td>
				</tr>
				<tr>
					<th><label class=""><spring:message code="labal.keyRegDttm"/></label></th>
					<td colspan="3">
						<input type="text" name="pubDttmFrom" value="" readonly="readonly"/>
						<input type="text" name="pubDttmTo" value="" readonly="readonly"/>       
					</td>
				</tr>
				<tr>
					<th><label class=""><spring:message code="labal.status"/></label></th>
					<td colspan="3">
						<input type="radio" name="delYn" value="">전체&nbsp;&nbsp;&nbsp;
						<input type="radio" name="delYn" value="N" checked="checked">정상&nbsp;&nbsp;&nbsp;
						<input type="radio" name="delYn" value="Y">삭제&nbsp;&nbsp;&nbsp;	
					</td>
				</tr>
			</table>	
			</form>		
				<!-- ibsheet 영역 -->
				<div style="clear: both;"></div>
				<div class="ibsheet_area_both">
					<script type="text/javascript">createIBSheet("mySheet", "100%", "300px"); </script>             
				</div>
				
				<div align="right">
					<button type="button" class="btn01" name="btn_del"><spring:message code="btn.modify"/></button>   
				</div>
						
			</div>
			
		</div>
</div>
</body>
</html>