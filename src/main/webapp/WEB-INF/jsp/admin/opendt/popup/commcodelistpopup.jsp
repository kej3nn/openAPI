<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="egovframework.common.WiseOpenConfig"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page import="egovframework.com.cmm.EgovWebUtil"%> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>표준맵핑 | <spring:message code="wiseopen.title"/></title>                    
<c:import  url="/WEB-INF/jsp/inc/headinclude.jsp"/>
<style type="text/css">
body{background:none;} /* 임시로 해놓은 것임 */
</style>
<%
	// 조직정보에서 팝업 띄웠을 경우 name 바꿔서 부모창에 입력하기 위한 변수
	String ditcGb = request.getParameter("ditcGb") == null ? "" : EgovWebUtil.clearXSSMinimum(request.getParameter("ditcGb"));                      

%>
</head>                                                 
<script language="javascript">              
//<![CDATA[                   
$(document).ready(function()    {  
	reSizeIframePop();
	LoadPage();
	inputSet();
	inputEnterKey();
	
});                                      

function LoadPage()                
{      
	
	var gridTitle1 = "NO"
		gridTitle1 +="|"+"<spring:message code='labal.ditcNm'/>";
		gridTitle1 +="|"+"<spring:message code='labal.ditcNm'/>";
	
	with(mySheet1){
           
    	var cfg = {SearchMode:2,Page:50};                                
        SetConfig(cfg);  
        var headers = [                               
                    {Text:gridTitle1, Align:"Center"}                 
                ];
        var headerInfo = {Sort:0,ColMove:1,ColResize:1,HeaderCheck:0};
        
        InitHeaders(headers, headerInfo); 
         
        var cols = [          
					 {Type:"Seq",		SaveName:"seq",				Width:30,	Align:"Center",		Edit:false}
					,{Type:"Text",		SaveName:"ditcCd",			Width:70,	Align:"Center",		Edit:false,Hidden:true}
					,{Type:"Text",		SaveName:"ditcNm",			Width:120,	Align:"Left",		Edit:false}
               ];            
                                      
        InitColumns(cols);                                                                                        
        SetExtendLastCol(1);                                     
    }
    default_sheet(mySheet1);    
   doAction("search");
}      

function doAction(sAction)                                  
{
	var formObj = $("form[name=openCateDitcList]");                 
	switch(sAction)                                              
	{          
		case "search":      //조회                
			ajaxBeforeSendAdmin("<c:url value='/admin/ajaxBeforeSendAdmin.do'/>"); //IbSheet 조회전 세션 체크
			var param = {PageParam: "ibpage", Param: "onepagerow=50&"+formObj.serialize()};    
			mySheet1.DoSearchPaging("<c:url value='/admin/basicinf/opencate/openCateDitcList.do'/>", param);
			break;                 
	}                                                                                                                 
}                         
                      


function inputSet(){
	var formObj = $("form[name=openCateDitcList]");                  
	formObj.find("button[name=btn_inquiry]").click(function(e) {               
		doAction('search');                 
		return false;                                    
	});                  
	
	/* $("a[name=a_close]").click(function(e) {                
		parent.doActionTab("popclose");
		 return false;                             
	 });  */	//iframe 팝업 사용시
	 $("a[name=a_close]").click(function(){	window.close();	});		// 팝업창 닫기
}

function mySheet1_OnDblClick(row, col, value, cellx, celly) {
/* 	if(row > 0){               
		var classObj = parent.$("."+tabContentClass); //tab으로 인하여 form이 다건임
		var formObj = setTabFormObj(classObj,"adminOpenCateOne");                     
		formObj.find("input[name=niaId]").val(mySheet1.GetCellValue(row,"ditcCd"));
		formObj.find("input[name=ditcNm]").val(mySheet1.GetCellValue(row,"ditcNm"));
		$("a[name=a_close]").click(); 
	}*/	//iframe 팝업 사용시
	
	 if(row == 0) return;  
	    var arrayValue, usrCd, usrNm;
	    var classObj = opener.$("."+tabContentClass); //부모 form class 확인
	    
	    if ($("#ditcGb").val() == "1") {		//담당자 관리화면에서 호출시
	    	arrayValue = {niaId:mySheet1.GetCellValue(row, "ditcCd"), ditcNm:mySheet1.GetCellValue(row, "ditcNm")}
	    }else{
	    	arrayValue = {niaId:mySheet1.GetCellValue(row, "ditcCd"), ditcNm:mySheet1.GetCellValue(row, "ditcNm")}
	    }
		return_pop(classObj,arrayValue); // 공통 javascirpt 호출(common.js)
} 

function inputEnterKey(){
	var formObj = $("form[name=openCateDitcList]");
	formObj.find("input").keypress(function(e) {                   
		  if(e.which == 13) {
			  doAction('search');   
			  return false; 
		  }
	}); 
}  

function mySheet1_OnSearchEnd(code, msg)
{
	mySheet1.FitColWidth("10|20|35|35");                              
}
//]]> 
</script>              
</head>                      
<body onload="">
<div class="wrap-popup">
	<div class="container">
		<!-- 상단 타이틀 -->
		<div class="title">
			<h2>분류 선택</h2>
		</div>  
			<div class="popup" style="padding:20px;">
			<form name="openCateDitcList"  method="post" action="#">
			<input type="hidden" id="ditcGb" name="ditcGb" value="<%=ditcGb.replaceAll("<", "&lt;").replaceAll(">", "&gt;") %>"/>      
				<table class="list01">
					<caption>표준맵핑목록리스트</caption>
						<colgroup>
							<col width="150"/>
							<col width=""/>
							<col width="150"/>
							<col width=""/>
						</colgroup>
						<tr>
							<th>검색어</th>
							<td colspan="3">
								<select name="serSel">
									<option value="0"><spring:message code='etc.select'/></option>
				                 	<option value="1" selected="selected"><label class=""><spring:message code="labal.ditcNm"/></label></option>
								</select>
								<input type="text" name="serVal" value="" maxlength="160"/>
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
	</div>
	<div class="buttons">
		${sessionScope.button.a_close}        
	</div>  
</div>	
</body>	
</html>