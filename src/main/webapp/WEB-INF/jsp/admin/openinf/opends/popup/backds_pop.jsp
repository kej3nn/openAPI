<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="egovframework.common.WiseOpenConfig"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><spring:message code="labal.dataSetManagement"/>ㅣ<spring:message code='wiseopen.title'/></title>                    
<c:import  url="/WEB-INF/jsp/inc/headinclude.jsp"/>
<style type="text/css">
body{background:none;} /* 임시로 해놓은 것임 */
</style>                                               
<script type="text/javascript">
var tabContentClass= "content";

function setButton(){
	$("button[name=dsSearch]").click(function(){	doAction("search");	return false;	});
	$("a[name=closePop]").click(function(){	window.close();	});
}

$(document).ready(function()    {          
	$("input[name=tableName]").focus();  
	LoadPage();                                                               
	setButton();
	inputEnterKey();
	doAction('search');    
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
	     gridTitle +="|"+"<spring:message code='labal.ownerCd'/>";
	     gridTitle +="|"+"<spring:message code='labal.ownTabId'/>";
	     gridTitle +="|"+"<spring:message code='labal.tabNm'/>";
	     gridTitle +="|"+"<spring:message code='labal.tabNm'/>";
                    
    with(mySheet1){
    	                     
    	var cfg = {SearchMode:2,Page:50};                       
        SetConfig(cfg);          
        var headers = [                                   
                    {Text:gridTitle, Align:"Center"}
                ];
        var headerInfo = {Sort:0, ColMove:0, ColResize:1, HeaderCheck:1};
        
        InitHeaders(headers, headerInfo);                           
            
        var cols = [          
					 {Type:"Seq",		SaveName:"seq",			Width:40,	Align:"Center",		Edit:false}
					,{Type:"Text",		SaveName:"owner",			Width:0,	Align:"Center",		Edit:false, Hidden:true}
					,{Type:"Text",		SaveName:"tableName",			Width:300,	Align:"Left",		Edit:false, Hidden:false}
					,{Type:"Text",		SaveName:"tableComments",			Width:300,	Align:"Left",		Edit:false}
					
                ];                                                                    
                                      
        InitColumns(cols);                                                                                               
        FitColWidth();                                                                       
        SetExtendLastCol(1);   
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
			var tableName = $("input[name=tableName]").val();
			var owner = $("[name=owner]").val();
			ajaxBeforeSendAdmin("<c:url value='/admin/ajaxBeforeSendAdmin.do'/>"); //IbSheet 조회전 세션 체크
			var param = {PageParam: "ibpage", Param: "onepagerow=50&tableName="+tableName+"&owner="+owner};         
			mySheet1.DoSearchPaging("<c:url value='/admin/openinf/opends/popup/backDsPopList.do'/>", param);
			break;
			
	}
}

function mySheet1_OnDblClick(row, col, value, cellx, celly) {
    if(row == 0) return;     
    var classObj = opener.$("."+tabContentClass); //부모 form class 확인
    var arrayValue ={bcpDsId:mySheet1.GetCellValue(row, "tableName"), backOwnerCd:mySheet1.GetCellValue(row, "owner"), bcpOwnerCd: mySheet1.GetCellValue(row, "owner")}// json으로 부모창 input 이름, data
    return_pop(classObj,arrayValue); // 공통 javascirpt 호출(common.js)
}  

</script>
</head>  
<body onload="">
<div class="wrap-popup">
	<!-- 내용 -->
	<div class="container">
		<!-- 상단 타이틀 -->
		<div class="title">
			<h2>데이터셋 선택</h2>
		</div>
		<!-- 팝업 내용 -->
		<div class="popup" style="padding: 20px;">
		<form name="popOpenDs"  method="post" action="#">
			<table class="list01" style="position:relative;">
					<caption>데이터셋 선택</caption>
					<colgroup>
						<col width="150"/>
						<col width=""/>
						<col width="150"/>
						<col width=""/>
						<col width="150"/>
						<col width=""/>
					</colgroup>
					<tr>
						<th>테이블명</th>
						<td colspan="5">
							<select name="owner">
			                 	<option value="">선택</option>
								<c:forEach var="code" items="${codeMap.ownerCd}" varStatus="status">
								  <option value="${code.ditcCd}">${code.ditcNm}</option>
								</c:forEach>
							</select>
		                 	<input type="text" name="backTableName" class="input" maxlength="40"/>
							<button type="button" class="btn01" name="dsSearch">검색</button>
						</td>
					</tr>
				</table>
			</form>	
			<div style="clear: both;"></div>
			<div class="ibsheet_area_both">
				<script type="text/javascript">createIBSheet("mySheet1", "100%", "300px"); </script>
			</div>
		</div>
		<div class="buttons">
			<a href="#" class="btn02" name="closePop">닫기</a>
		</div>	
	</div>

</div>














</body>
</html>