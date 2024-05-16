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
	var gridTitle = "NO";
		gridTitle +="|자료시점";
		gridTitle +="|요청처리상태";
		gridTitle +="|처리메세지";
		gridTitle +="|처리부서";
		gridTitle +="|처리자";
		gridTitle +="|처리일시";
                    
    with(mySheet1){
    	                     
    	var cfg = {SearchMode:2,Page:50};                       
        SetConfig(cfg);          
        var headers = [                                   
                    {Text:gridTitle, Align:"Center"}
                ];
        var headerInfo = {Sort:0, ColMove:0, ColResize:1, HeaderCheck:1};
        
        InitHeaders(headers, headerInfo);                           
            
        var cols = [          
					 {Type:"Seq",			SaveName:"seq",				Width:60,	Align:"Center",		Edit:false}
					,{Type:"Text",			SaveName:"wrttimeDesc",		Width:110,	Align:"Center",		Edit:false} 
					,{Type:"Text",			SaveName:"wrtstateNm",		Width:100,	Align:"Center",		Edit:false} 
					,{Type:"Text",			SaveName:"wrtMsgCont",		Width:300,	Align:"Left",		Edit:false}
					,{Type:"Text",			SaveName:"wrtOrgNm",		Width:130,	Align:"Center",		Edit:false}
					,{Type:"Text",			SaveName:"wrtUsrNm",		Width:100,	Align:"Center",		Edit:false}
					,{Type:"Text",			SaveName:"wrtDttm",			Width:170,	Align:"Center",		Edit:false}
					
                ];                                                                    
                                      
        InitColumns(cols);                                                                                               
        FitColWidth();                                                                       
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
			var param = {PageParam: "ibpage", Param: "onepagerow=50&"+ $("form[name=wrtLogPopForm]").serialize() };         
			mySheet1.DoSearchPaging(com.wise.help.url("/admin/stat/popup/selectStatLogSttsWrtList.do"), param);
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
		<form name="wrtLogPopForm"  method="post" action="#">
			<input type="hidden" name="statblId" value ="${statblId}"/>
			<c:forEach var="wrttime" items="${wrttimeIdtfrId }">
				<input type="hidden" name="wrttimeIdtfrId" value ="${wrttime}"/>
			</c:forEach>
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