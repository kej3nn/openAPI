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
<title>요청기록 | <spring:message code='wiseopen.title'/></title>                    
<c:import  url="/WEB-INF/jsp/inc/headinclude.jsp"/>
<style type="text/css">
body{background:none;} /* 임시로 해놓은 것임 */
</style>                                               
<script type="text/javascript">
$(document).ready(function()    {          
	LoadPage();                                                               
	doAction('search');    
	$("a[name=closePop]").click(function(){	window.close();	});
});   

function LoadPage()                
{
	var gridTitle = "NO"
	     gridTitle +="|"+"요청처리상태";
	     gridTitle +="|"+"<spring:message code='labal.prssExp'/>";
	     gridTitle +="|"+"<spring:message code='labal.prssOrgNm'/>";
	     gridTitle +="|"+"<spring:message code='labal.prssUsrNm'/>";
	     gridTitle +="|"+"<spring:message code='labal.prssDttm'/>";
                    
    with(mySheet1){
    	                     
    	var cfg = {SearchMode:2,Page:50};                       
        SetConfig(cfg);          
        var headers = [                                   
                    {Text:gridTitle, Align:"Center"}
                ];
        var headerInfo = {Sort:0, ColMove:0, ColResize:1, HeaderCheck:1};
        
        InitHeaders(headers, headerInfo);                           
            
        var cols = [          
					 {Type:"Seq",			SaveName:"seq",					Width:100,	Align:"Center",		Edit:false}
					,{Type:"Text",			SaveName:"newState",			Width:300,	Align:"Center",		Edit:false}
					,{Type:"Text",			SaveName:"prssExp",			Width:600,	Align:"Left",			Edit:false}
					,{Type:"Combo",		SaveName:"orgCd",				Width:300,	Align:"Center",		Edit:false}
					,{Type:"Text",			SaveName:"regId",				Width:300,	Align:"Center",		Edit:false}
					,{Type:"Date",			SaveName:"regDttm",			Width:300,	Align:"Center",		Edit:false}
					
                ];                                                                    
                                      
        InitColumns(cols);                                                                                               
        FitColWidth();                                                                       
        SetExtendLastCol(1);   
        SetColProperty("orgCd", 	${codeMap.orgCdIbs});           
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
			var infId = $("input[name=infId]").val();
			ajaxBeforeSendAdmin("<c:url value='/admin/ajaxBeforeSendAdmin.do'/>"); //IbSheet 조회전 세션 체크
			var param = {PageParam: "ibpage", Param: "onepagerow=50&infId="+infId};         
			mySheet1.DoSearchPaging("<c:url value='/admin/openinf/popup/openInfPrssLogPopList.do'/>", param);
			break;
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
			<h2>요청기록</h2>
		</div>
		<!-- 팝업 내용 -->
		<div class="popup" style="padding: 20px;">
		<form name="popOpenInfPrssLog"  method="post" action="#">
			<input type="hidden" name="infId" value ="${infId}"/>
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