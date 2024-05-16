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
<title>분류 선택 | <spring:message code="wiseopen.title"/></title>                    
<c:import  url="/WEB-INF/jsp/inc/headinclude.jsp"/>
<style type="text/css">
body{background:none;} /* 임시로 해놓은 것임 */
</style>
<%
	// 조직정보에서 팝업 띄웠을 경우 name 바꿔서 부모창에 입력하기 위한 변수
	String cateGb = request.getParameter("cateGb") == null ? "" : EgovWebUtil.clearXSSMinimum(request.getParameter("cateGb")); 
	String cateIdTop = request.getParameter("cateIdTop") == null ? "" : EgovWebUtil.clearXSSMinimum(request.getParameter("cateIdTop"));
	String index = request.getParameter("index") == null ? "" : EgovWebUtil.clearXSSMinimum(request.getParameter("index"));
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
	createIBSheet2(document.getElementById("openCateParList"),"mySheet", "100%", "300px");                       
	var gridTitle1 ="NO"; 
	gridTitle1 +="|"+"<spring:message code='labal.cateId'/>";  
	gridTitle1 +="|"+"<spring:message code='labal.cateId'/>";  
	gridTitle1 +="|"+"<spring:message code='labal.cateNm'/>";
	gridTitle1 +="|"+"<spring:message code='labal.cateNmEng'/>";
	/* gridTitle1 +="|"+"<spring:message code='labal.cateNmEng'/>";
	gridTitle1 +="|"+"<spring:message code='labal.vOrder'/>";     
	gridTitle1 +="|"+"<spring:message code='labal.cateId'/>";      
	gridTitle1 +="|"+"<spring:message code='labal.cateId'/>";      
	gridTitle1 +="|"+"<spring:message code='labal.useYn'/>";
	 */
	with(mySheet){
           
    	var cfg = {SearchMode:2,Page:50};                                
        SetConfig(cfg);  
        var headers = [                               
                    {Text:gridTitle1, Align:"Center"}                 
                ];
        var headerInfo = {Sort:0,ColMove:1,ColResize:1,HeaderCheck:0};
        
        InitHeaders(headers, headerInfo); 
           
        var cols = [          
					 {Type:"Seq",		SaveName:"seq",				Width:50,	Align:"Center",		Edit:false}
					,{Type:"Text",		SaveName:"cateId",			Width:150,	Align:"Center",		Edit:false}
					,{Type:"Text",		SaveName:"cateIdTop",			Width:150,	Align:"Center",		Edit:false, Hidden:true}
					,{Type:"Text",		SaveName:"cateNm",			Width:350,	Align:"Left",		Edit:false, TreeCol:1}
					,{Type:"Text",		SaveName:"cateNmEng",			Width:350,	Align:"Left",		Edit:false, Hidden:true}
               ];            
                                      
        InitColumns(cols);                                                                                        
        SetExtendLastCol(1);                                     
    }
    default_sheet(mySheet);    
   doAction("search");
}      

function doAction(sAction)                                  
{
	var formObj = $("form[name=OpenCateParList]");                 
	switch(sAction)                                              
	{          
		case "search":      //조회                
			ajaxBeforeSendAdmin("<c:url value='/admin/ajaxBeforeSendAdmin.do'/>"); //IbSheet 조회전 세션 체크
			var param = {PageParam: "ibpage", Param: "onepagerow=50&"+formObj.serialize()};
			mySheet.DoSearchPaging("<c:url value='/admin/opendt/openCateParListTree.do'/>", param);
			break;                 
	}                                                                                                                 
}                         
                      
function colcallback(){
	                                                                    
}

function inputSet(){
	var formObj = $("form[name=OpenCateParList]");                  
	formObj.find("button[name=btn_inquiry]").click(function(e) {               
		doAction('search');                 
		return false;                                    
	});                  
	
	/* $("a[name=a_close]").click(function(e) {                
		parent.doActionTab("popclose");
		 return false;                             
	 }); */		//iframe 팝업 사용시
	 $("a[name=a_close]").click(function(){	window.close();	});		// 팝업창 닫기
}

function mySheet_OnDblClick(row, col, value, cellx, celly) {
	/* if(row > 0){               
		var classObj = parent.$("."+tabContentClass); //tab으로 인하여 form이 다건임
		var formObj = setTabFormObj(classObj,"adminOpenCateOne");                     
		formObj.find("input[name=cateIdPar]").val(mySheet.GetCellValue(row,"cateId"));
		formObj.find("input[name=cateNmPar]").val(mySheet.GetCellValue(row,"cateNm"));
		$("a[name=a_close]").click(); 
	}*/	//iframe 팝업 사용시
    if(row == 0) return;  
    var arrayValue, usrCd, usrNm;
    var classObj = opener.$("."+tabContentClass); //부모 form class 확인
    
    
    if ($("#cateGb").val() == "1") {		//담당자 관리화면에서 호출시
    	arrayValue = {cateIdPar:mySheet.GetCellValue(row, "cateId"), cateNmPar:mySheet.GetCellValue(row, "cateNm")}
    }else if($("#cateGb").val() == "2"){
    	arrayValue = {cateId:mySheet.GetCellValue(row, "cateId"), cateNm:mySheet.GetCellValue(row, "cateNm")}
    }else if($("#cateGb").val() == "3"){
    	arrayValue = {cateId:mySheet.GetCellValue(row, "cateId"), cateNm:mySheet.GetCellValue(row, "cateNm"), cateIdTop:mySheet.GetCellValue(row, "cateIdTop")}
	}else if($("#cateGb").val() == "4"){
    	arrayValue = {cateId2:mySheet.GetCellValue(row, "cateId"), cateNm2:mySheet.GetCellValue(row, "cateNm"), cateIdTop:mySheet.GetCellValue(row, "cateIdTop")}
	}
    else{
    	arrayValue = {cateIdPar:mySheet.GetCellValue(row, "cateId"), cateNmPar:mySheet.GetCellValue(row, "cateNm")}
    }
    
    var index = "<%=index.replaceAll("<", "&lt;").replaceAll(">", "&gt;")%>";
    if(index =="") {
    	return_pop(classObj,arrayValue); // 공통 javascirpt 호출(common.js)	
    } else {
    	return_popIndex(classObj,index,arrayValue); // 공통 javascirpt 호출(common.js)
    }
	
    
}

function dupCallBack(res){
}

function inputEnterKey(){
	var formObj = $("form[name=OpenCateParList]");
	formObj.find("input").keypress(function(e) {                   
		  if(e.which == 13) {
			  doAction('search');   
			  return false; 
		  }
	}); 
}  

function mySheet_OnSearchEnd(code, msg)
{
	mySheet.FitColWidth("10|20|35|35");                              
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
			<h2>분류 선택</h2>
		</div>
		<!-- 팝업 내용 -->
		<div class="popup" style="padding:20px;">
			<form name="OpenCateParList"  method="post" action="#">      
			<input type="hidden" id="cateGb" name="cateGb" value="<%=cateGb.replaceAll("<", "&lt;").replaceAll(">", "&gt;") %>"/>
			<input type="hidden" id="cateIdTop" name="cateIdTop" value="<%=cateIdTop.replaceAll("<", "&lt;").replaceAll(">", "&gt;") %>"/>  
				<table class="list01">
					<caption>상위분류목록리스트</caption>
						<colgroup>
							<col width="80"/>
							<col width=""/>
							<col width="150"/>
							<col width=""/>
						</colgroup>
						<tr>
							<th>검색어</th>
							<td colspan="3" style="width:310px;">
							<select name="serSel">
									<option value="ALL"><label class=""><spring:message code="etc.select"/></label></option>
									<option value="ID"><label class=""><spring:message code="labal.cateId"/></label></option>
				                 	<option value="NM" selected="selected"><label class=""><spring:message code="labal.cateNm"/></label></option>
				                 	<option value="ENG"><label class=""><spring:message code="labal.cateNmEng"/></label></option>
								</select>
								<input name="serVal" type="text" value="" maxlength="160"/>
								${sessionScope.button.btn_inquiry}
							</td>
						</tr>
				</table>                 
			</form>
			<div class="ibsheet_area" id="openCateParList">
			</div>
		</div>  
	</div>
	<div class="buttons">
		${sessionScope.button.a_close}        
	</div>  
</div>	
</body>	
</html>