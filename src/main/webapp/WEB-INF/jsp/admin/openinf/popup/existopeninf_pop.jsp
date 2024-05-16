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
<title>메타정보 | <spring:message code='wiseopen.title'/></title>                     
<c:import  url="/WEB-INF/jsp/inc/headinclude.jsp"/>
<style type="text/css">
body{background:none;} /* 임시로 해놓은 것임 */
</style>                                               
<script type="text/javascript">
var tabContentClass= "content";

function setButton(){
	$("button[name=dtSearch]").click(function(){	doAction("search");	return false;});
	$("a[name=closePop]").click(function(){	window.close();	});
}

$(document).ready(function()    {          
	LoadPage();                                                               
	doAction('search');    
	setButton();
	inputEnterKey();
});   

function inputEnterKey(){
	$("input").keypress(function(e) {
		  if(e.which == 13) {
			  doAction('search');   
			  return false;
		  }
	});
}  

function LoadPage()                
{
	var gridTitle = "NO"
		gridTitle +="|"+"<spring:message code='labal.infId'/>";  
		gridTitle +="|"+"<spring:message code='labal.dtNm'/>";  
		gridTitle +="|"+"<spring:message code='labal.infNm'/>";        
		gridTitle +="|"+"<spring:message code='labal.cclCd'/>";        
		gridTitle +="|"+"<spring:message code='labal.cateNm'/>";        
		gridTitle +="|"+"<spring:message code='labal.orgNm'/>";        
		gridTitle +="|"+"<spring:message code='labal.usrNm'/>";        
		gridTitle +="|"+"<spring:message code='labal.openDttm'/>";        
		gridTitle +="|"+"<spring:message code='labal.infState'/>";   
                    
    with(mySheet1){
    	                     
    	var cfg = {SearchMode:2,Page:50};                       
        SetConfig(cfg);          
        var headers = [                                   
                    {Text:gridTitle, Align:"Center"}
                ];
        var headerInfo = {Sort:0, ColMove:0, ColResize:1, HeaderCheck:1};
        
        InitHeaders(headers, headerInfo);                           
            
        var cols = [          
                    {Type:"Seq",		SaveName:"seq",				Width:30,	Align:"Center",		Edit:false}
					,{Type:"Text",		SaveName:"infId",			Width:100,	Align:"Center",		Edit:false, Hidden:true}
					,{Type:"Text",		SaveName:"dtNm",			Width:100,	Align:"Left",		Edit:false}
					,{Type:"Text",		SaveName:"infNm",			Width:100,	Align:"Left",		Edit:false}
					,{Type:"Text",		SaveName:"cclNm",			Width:100,	Align:"Center",		Edit:false}
					,{Type:"Text",		SaveName:"cateNm",			Width:100,	Align:"Center",		Edit:false}
					,{Type:"Text",		SaveName:"orgNm",			Width:100,	Align:"Center",		Edit:false}
					,{Type:"Text",		SaveName:"usrNm",			Width:100,	Align:"Center",		Edit:false}
					,{Type:"Text",		SaveName:"openDttm",			Width:100,	Align:"Center",		Edit:false}
					,{Type:"Combo",		SaveName:"infState",			Width:100,	Align:"Center",		Edit:false}
					
                ];                                                                    
                                      
        InitColumns(cols);         
        FitColWidth();                                                                       
        SetExtendLastCol(1);   
        SetColProperty("infState", 	{ComboCode:"N|Y|X|C", 	ComboText:"미개방|개방|개방불가|개방취소"});         
    }                   
    default_sheet(mySheet1);                      
}

/*Sheet 각종 처리*/                  
function doAction(sAction)                                  
{
	var classObj = $("."+tabContentClass); //tab으로 인하여 form이 다건임
	var actObj = setTabForm(classObj); // 0: form data, 1: form 객체
	switch(sAction)
	{          
		case "search":      //조회   
			var infNm = $("input[name=infNm]").val();
			ajaxBeforeSendAdmin("<c:url value='/admin/ajaxBeforeSendAdmin.do'/>"); //IbSheet 조회전 세션 체크
			var param = {PageParam: "ibpage", Param: "onepagerow=50&infNm="+infNm};         
			mySheet1.DoSearchPaging("<c:url value='/admin/openinf/openInfListAll.do'/>", param);
			break;
	}
}

function mySheet1_OnDblClick(row, col, value, cellx, celly) {
    if(row == 0) return;     
    var classObj = opener.$("."+tabContentClass); //부모 form class 확인
    var arrayValue ={existinfId:mySheet1.GetCellValue(row, "infId")}// json으로 부모창 input 이름, data
    return_pop(classObj,arrayValue); // 공통 javascirpt 호출(common.js)
    $(opener.location).attr("href","javascript:doTabAction('import');");
}  

</script>
</head>  
<body onload="">
<div class="wrap-popup">
	<!-- 내용 -->
	<div class="container">
		<!-- 상단 타이틀 -->
		<div class="title">
			<h2>메타정보 선택</h2>
		</div>
		<!-- 팝업 내용 -->
		<div class="popup" style="padding: 20px;"> 
		<form name="popOpenDs"  method="post" action="#">
		<table class="list01" style="position:relative;">
			<caption>보유데이터 선택</caption>
			<colgroup>
				<col width="150"/>
				<col width=""/>
				<col width="150"/>
				<col width=""/>
				<col width="150"/>
				<col width=""/>
			</colgroup>
			<tr>
				<th><label class=""><spring:message code="labal.infNm"/></label></th>
				<td colspan="5">
                 	<input type="text" name="infNm" class="input" />
					<button type="button" class="btn01" name="dtSearch">검색</button>
				</td>
			</tr>
		</table>
		</form>	
			<div style="clear: both;"></div>
			<div class="ibsheet_area_both">
				<script type="text/javascript">createIBSheet("mySheet1", "100%", "320px"); </script>
			</div>
		</div>
		<div class="buttons">
			<a href="#" class="btn02" name="closePop">닫기</a>
		</div>	
	</div>

</div>

</body>
</html>