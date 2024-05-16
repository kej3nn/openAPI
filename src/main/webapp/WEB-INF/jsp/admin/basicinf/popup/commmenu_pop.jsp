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
<title><spring:message code="labal.menuManagement"/>ㅣ<spring:message code="wiseopen.title"/></title>                    
<c:import  url="/WEB-INF/jsp/inc/headinclude.jsp"/>
<style type="text/css">
body{background:none;} /* 임시로 해놓은 것임 */
</style>                                               
<script type="text/javascript">
var tabContentClass= "content";

function setButton(){
	$("a[name=closePop]").click(function(){	window.close();	});
}

$(document).ready(function()    {          
	LoadPage();                                                               
	doAction('search');    
	setButton();
});   

function LoadPage()                
{
	var gridTitle = "NO";
		gridTitle +="|"+"<spring:message code='labal.menuId'/>";        
		gridTitle +="|"+"<spring:message code='labal.menuNm'/>";
		gridTitle +="|"+"최상위ID";
                    
    with(mySheet1){
    	                     
    	var cfg = {SearchMode:2,Page:50};                       
        SetConfig(cfg);          
        var headers = [                                   
                    {Text:gridTitle, Align:"Center"}
                ];
        var headerInfo = {Sort:0, ColMove:0, ColResize:1, HeaderCheck:1};
        
        InitHeaders(headers, headerInfo);                           
            
        var cols = [   {Type:"Seq",		SaveName:"seq",			Width:10,	Align:"Center",		Edit:false}
                      ,{Type:"Text",		SaveName:"menuNm",			Width:100,	Align:"Left",		Edit:false, TreeCol:1}                                                                    
                      ,{Type:"Text",		SaveName:"menuId",			Width:100,	Align:"Left",		Edit:false, Hidden:true}
                      ,{Type:"Text",		SaveName:"menuIdTop",			Width:50,	Align:"Left",		Edit:false, Hidden:false}
                   ];                                                                    
                                      
        InitColumns(cols);                                                                                               
        FitColWidth();                                                                       
        SetExtendLastCol(1);
        ShowTreeLevel(0, 0);
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
			//var tableName = $("input[name=tableName]").val();
			var menuSiteCd = $("#menuSiteCd").val();
			ajaxBeforeSendAdmin("<c:url value='/admin/ajaxBeforeSendAdmin.do'/>"); //IbSheet 조회전 세션 체크
			var param = {PageParam: "ibpage", Param: "onepagerow=<%=WiseOpenConfig.IBSHEETPAGENOW%>&menuSiteCd="+menuSiteCd};       
			mySheet1.DoSearchPaging("<c:url value='/admin/basicinf/commMenuRetr.do'/>", param);
			break;
			
	}
}

function mySheet1_OnDblClick(row, col, value, cellx, celly) {
    if(row == 0) return;     
    var classObj = opener.$("."+tabContentClass); //부모 form class 확인
    var arrayValue ={menuIdParDesc:mySheet1.GetCellValue(row, "menuNm"), menuIdPar:mySheet1.GetCellValue(row, "menuId"), menuIdTop:mySheet1.GetCellValue(row, "menuIdTop")}// json으로 부모창 input 이름, data
    return_pop(classObj,arrayValue); // 공통 javascirpt 호출(common.js)
}  

function treeOPenNClose() {
	if ( mySheet1.GetRowExpanded(1) ) {
		mySheet1.ShowTreeLevel(0);
	}
	else {
		mySheet1.ShowTreeLevel(-1);	
	}
	
}

</script>
</head>  
<body onload="">
<div class="wrap-popup">
	<!-- 내용 -->
	<div class="container">
		<!-- 상단 타이틀 -->
		<div class="title">
			<h2>메뉴검색</h2>
		</div>
		<!-- 팝업 내용 -->
		<div class="popup" style="padding: 20px;">
			<input type="hidden" id="menuSiteCd" name="menuSiteCd" value="${commMenu}"/>
			<button type="button" class="btn01" onclick="javascript:; treeOPenNClose();">메뉴 열기/닫기</button> 
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
</head>
</html>
