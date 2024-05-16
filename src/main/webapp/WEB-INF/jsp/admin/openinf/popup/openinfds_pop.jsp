<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="egovframework.common.WiseOpenConfig"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ page import="egovframework.com.cmm.EgovWebUtil"%>
<%
	String dtId = request.getParameter("dtId") == null ? "" : EgovWebUtil.clearXSSMinimum(request.getParameter("dtId"));
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><spring:message code='wiseopen.title'/></title>                    
<c:import  url="/WEB-INF/jsp/inc/headinclude.jsp"/>
<style type="text/css">
body{background:none;} /* 임시로 해놓은 것임 */
<%
	String index = request.getParameter("index") == null ? "" : EgovWebUtil.clearXSSMinimum(request.getParameter("index"));
%>
</style>                                               
<script type="text/javascript">
var tabContentClass= "content";

function setButton(){
	$("a[name=closePop]").click(function(){	window.close();	});
	
	$("button[name=btn_inquiry]").bind("click", function(event) {
		doAction("search");
    });
}

$(document).ready(function()    {          
	$("input[name=tableName]").focus();  
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
	     gridTitle +="|"+"<spring:message code='labal.dtId'/>";
	     gridTitle +="|"+"<spring:message code='labal.dsId'/>";
	     gridTitle +="|"+"<spring:message code='labal.dsNm'/>";
                    
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
					,{Type:"Text",		SaveName:"dtId",			Width:0,	Align:"Center",		Edit:false, Hidden:true}
					,{Type:"Text",		SaveName:"dsId",			Width:300,	Align:"Left",		Edit:false}
					,{Type:"Text",		SaveName:"dsNm",			Width:300,	Align:"Left",		Edit:false}
					
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
			var dtId = $("input[name=dtId]").val();
			ajaxBeforeSendAdmin("<c:url value='/admin/ajaxBeforeSendAdmin.do'/>"); //IbSheet 조회전 세션 체크
			var param = {PageParam: "ibpage", Param: "onepagerow=50&dtId="+dtId+ "&searchGubun="+$("#searchGubun").val() + "&searchWord="+$("[name=searchWord]").val() };   
			mySheet1.DoSearchPaging("<c:url value='/admin/openinf/popup/openInfDsList.do'/>", param);
			break;
			
	}
}

function mySheet1_OnDblClick(row, col, value, cellx, celly) {
    if(row == 0) return;     
    var classObj = opener.$("."+tabContentClass); //부모 form class 확인
    var arrayValue ={dsId:mySheet1.GetCellValue(row, "dsId")}// json으로 부모창 input 이름, data
    
    var index = "<%=index.replaceAll("<", "&lt;").replaceAll(">", "&gt;")%>";
    if(index =="") {
    	return_pop(classObj,arrayValue); // 공통 javascirpt 호출(common.js)	
    } else {
    	return_popIndex(classObj,index,arrayValue); // 공통 javascirpt 호출(common.js)
    }
    
    //return_pop(classObj,arrayValue); // 공통 javascirpt 호출(common.js)
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
			<input type="hidden" name="dtId" value="<%=dtId.replaceAll("<", "&lt;").replaceAll(">", "&gt;") %>"	/>
			<table class="list01" style="position:relative;">
				<caption>데이터셋 선택</caption>
				<colgroup>
					<col width="80"/>
					<col width=""/>
					<col width="150"/>
					<col width=""/>
				</colgroup>
				<tr>
					<th>검색어</th>
					<td colspan="3">
						<select id="searchGubun" name="searchGubun">
							<option value="DS_ID">데이터셋ID</option>
							<option value="DS_NM">데이터셋명</option>
						</select>
						<input type="text" name="searchWord" value="" placeholder="검색어 입력" size="40" />
						${sessionScope.button.btn_inquiry}  
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