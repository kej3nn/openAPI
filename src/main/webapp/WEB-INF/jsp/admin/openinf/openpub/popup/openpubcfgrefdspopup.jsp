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
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>관련데이터셋 검색</title>                    
<c:import  url="/WEB-INF/jsp/inc/headinclude.jsp"/>
<style type="text/css">
body{background:none;}
</style>  
<%
	// 조직정보에서 팝업 띄웠을 경우 name 바꿔서 부모창에 입력하기 위한 변수
	//String refDsIdGb = request.getParameter("refDsIdGb") ? "" : EgovWebUtil.clearXSSMinimum(request.getParameter("refDsIdGb"));
	String refDsIdGb = "";
%>
<script language="javascript">              
//<![CDATA[          
var tabContentClass= "content";
$(document).ready(function()    {                                                
	LoadPage();                                                               
	doAction('search');                                                         
	$("input[name=dsId]").focus();
	$("a[name=closePop]").click(function(){	window.close();	});		// 팝업창 닫기
	$("button[name=btn_refSearch]").click(function(e) {	doAction("search");	return false;	});
	inputEnterKey();      
	document.getElementById("refDsIdGb");
});                                                       
            
function LoadPage()                
{         
	//message-common_ko_KR.properties 선언 후 사용 or message-common_en_US.properties 선언 후 사용
	var gridTitle = "NO"
		gridTitle +="|"+"<spring:message code='labal.dsNm'/>";
		gridTitle +="|"+"<spring:message code='labal.dsId'/>";
		/* gridTitle +="|"+"<spring:message code='labal.dsNm'/>"; */
	
    with(mySheet1){
    	                     
    	var cfg = {SearchMode:3,Page:50};                                
        SetConfig(cfg);  
        var headers = [                                             
                    {Text:gridTitle, Align:"Center"}                 
                ];
        var headerInfo = {Sort:0,ColMove:1,ColResize:1,HeaderCheck:0};
        
        InitHeaders(headers, headerInfo);                 
	
        var cols = [          
					{Type:"Seq",		SaveName:"seq",				Width:30,	Align:"Center",		Edit:false}
					,{Type:"Text",		SaveName:"dsNm",			Width:150,	Align:"Left",		Edit:false,}
					,{Type:"Text",		SaveName:"dsId",			Width:100,	Align:"Left",		Edit:false}
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
	switch(sAction)
	{          
	                   
		case "search":      //조회   
		                 
			var formParam = $("form[name=refDsIdPop]").serialize();     
			ajaxBeforeSendAdmin("<c:url value='/admin/ajaxBeforeSendAdmin.do'/>"); //IbSheet 조회전 세션 체크
			var param = {PageParam: "ibpage", Param: "onepagerow=50&"+formParam};
			mySheet1.DoSearchPaging("<c:url value='/admin/openinf/opends/popup/openPubCfgRefDsPopUpList.do'/>", param);
			break;
	}           
}         



// 마우스 이벤트
function mySheet1_OnSearchEnd(code, msg)
{
   if(msg != "")
	{                
	    alert(msg);
    }
}

function inputEnterKey(){
	$("input").keypress(function(e) {
		  if(e.which == 13) {
			  doAction('search');   
			  return false;        
		  }
	});
}           
                   
function mySheet1_OnDblClick(row, col, value, cellx, celly) {
	var pubYn = mySheet1.GetCellValue(row,"pubYn");
	if(pubYn=='Y'){
		alert("선택불가한 데이터셋입니다"); 
		return;
	}
	if(row == 0) return;  
	var arrayValue, refDsId, refDsNm,dsId;
	var classObj = opener.$("."+tabContentClass); //부모 form class 확인
   	if($("input[name=refDsIdGb]").val() == "1"){
    	dsId = mySheet1.GetCellValue(row,"dsId");
    	var openerForm = $(opener.document).find("form[name=adminOpenPubCfgOne]");
    	openerForm.find("input[name=refDsId]").val(dsId);
   		arrayValue = {refDsId:mySheet1.GetCellValue(row, "dsId"), refDsNm:mySheet1.GetCellValue(row, "dsNm")}// json으로 부모창 input 이름, data
    	$(opener.location).attr("href","javascript:doTabAction('selectRefColId');");
    }else {
    	arrayValue = {refDsId:mySheet1.GetCellValue(row, "dsId"), refDsNm:mySheet1.GetCellValue(row, "dsNm")}// json으로 부모창 input 이름, data
    }
    return_pop(classObj,arrayValue); // 공통 javascirpt 호출(common.js)
}   


//]]> 
</script>              
</head>
<body onload="">
<div class="wrap-popup">
	<!-- 내용 -->
	<div class="container">
		<!-- 상단 타이틀 -->
		<div class="title">
			<h2>관련데이터셋 검색</h2>
		</div>
		<!-- 팝업 내용 -->
		<div class="popup">
			<form name="refDsIdPop"  method="post" action="#">
				<input type="hidden" name="refDsIdGb" value="<%=refDsIdGb.replaceAll("<", "&lt;").replaceAll(">", "&gt;") %>"/>
				<div>	
					<table class="list01">
						<colgroup>
							<col width="100"/>
							<col width="235"/> 
							<col width=""/>
						</colgroup>
						<tr>
							<th><spring:message code="labal.dsNm"/></th>  
							<td>   
								<input type="text" name="searchWd" value=""/>
								<button type="button" class="btn01" name="btn_refSearch">
									<spring:message code="btn.search"/>
								</button>
							</td>
							<td style="padding-left:0;">   
								<span>공공데이터에 등록이 되어있고 컬럼타입이 'DATE'인 경우만 검색됩니다</span>
							</td>
						</tr>
					</table>	
				</div>
				<div style="clear: both;"></div>
				<div class="ibsheet_area_both">
					<script type="text/javascript">createIBSheet("mySheet1", "100%", "300px"); </script>
				</div>
			</form>
		</div>
		<div class="buttons">
			<a href="#" class="btn02" name="closePop">닫기</a>
		</div>	
	</div>

</div>

</body>
</html>