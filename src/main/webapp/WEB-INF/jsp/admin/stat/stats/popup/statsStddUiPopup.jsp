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
<title><spring:message code="labal.dtManagement"/>ㅣ<spring:message code='wiseopen.title'/></title>             
<c:import  url="/WEB-INF/jsp/inc/headinclude.jsp"/>
<style type="text/css">
body{background:none;} /* 임시로 해놓은 것임 */
</style>                   
<script type="text/javascript">
var tabContentClass= "content";

function setButton(){
	$("button[name=dtSearch]").click(function(){	doAction("search");	return false;});
	$("a[name=closePop]").click(function(){	window.close();	});
	
	$('input[name=chkTreeOpenClose]').click(function(){
		var sheet = window["sheet"];
		var isChecked = $(this).prop("checked");
		// 트리 항목 펼치기
		if ( isChecked ) {
			sheet.ShowTreeLevel(-1);
			$('label:contains(항목펼치기)').text('항목접기');
		}else  {
			sheet.ShowTreeLevel(0);
			$('label:contains(항목접기)').text('항목펼치기');
		}
	});
}
$(document).ready(function()    {     
	$("input[name=dtNm]").focus();  
	LoadPage();                                                               
	doAction('search');    
	setButton();
	inputEnterKey();
});   

function LoadPage()                
{
	var gridTitle = "NO"
	     gridTitle +="|단위코드";
	     gridTitle +="|단위명";
	     
                    
    with(sheet){
    	                     
    	var cfg = {SearchMode:2,Page:50,VScrollMode:1,ChildPage:20};                       
        SetConfig(cfg);          
        var headers = [                                   
                    {Text:gridTitle, Align:"Center"}
                ];
        var headerInfo = {Sort:0, ColMove:0, ColResize:1, HeaderCheck:1};
        
        InitHeaders(headers, headerInfo);                           
            
        var cols = [          
					 {Type:"Seq",		SaveName:"seq",				Width:0,	Align:"Center",		Edit:false}
					,{Type:"Text",		SaveName:"uiId",			Width:70,	Align:"Center",		Edit:false,	TreeCol:1}
					,{Type:"Text",		SaveName:"uiNm",			Width:130,	Align:"Left",		Edit:false}
                ];                                                                    
                                      
        InitColumns(cols);                                                                                               
        FitColWidth();                                                                       
        SetExtendLastCol(1);   
        
        ShowTreeLevel(0, 1);
        SetCountPosition(0);
    }                   
    default_sheet(sheet);                      
}

/*Sheet 각종 처리*/                  
function doAction(sAction)                                  
{
	var classObj = $("."+"popup"); //tab으로 인하여 form이 다건임
	var actObj = setTabForm(classObj); // 0: form data, 1: form 객체
	switch(sAction)
	{          
		case "search":      //조회   
			var dtNm = $("input[name=dtNm]").val();
			ajaxBeforeSendAdmin("<c:url value='/admin/ajaxBeforeSendAdmin.do'/>"); //IbSheet 조회전 세션 체크
			var param = {PageParam: "ibpage", Param: "onepagerow=50"+"&"+actObj[0]};         
			sheet.DoSearchPaging("<c:url value='/admin/stat/popup/selectStatsStddUiPopup.do'/>", param);
			break;
			
	}
}

function sheet_OnDblClick(row, col, value, cellx, celly) {
	if(row == 0) return;  
    var classObj = opener.$("."+tabContentClass); //부모 form class 확인
    var arrayValue = {};
    
    if ( "${param.gb}" === "ITM" ) {
    	arrayValue = {
    			itmUiId : sheet.GetCellValue(row, "uiId"),
    			itmUiNm : sheet.GetCellValue(row, "uiNm")
    	}
    } else if ( "${param.gb}" === "CATE" ) {
    	arrayValue = {
    			cateUiId : sheet.GetCellValue(row, "uiId"),
    			cateUiNm : sheet.GetCellValue(row, "uiNm")
    	}
    } else {
    	arrayValue = {
    			uiId : sheet.GetCellValue(row, "uiId"),
    			uiNm : sheet.GetCellValue(row, "uiNm")
    	}
    }
    
	
	
	return_pop(classObj, arrayValue);
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
<div class="wrap-popup">
	<!-- 내용 -->
	<div class="container">
		<!-- 상단 타이틀 -->
		<div class="title">
			<h2>단위 선택</h2>
		</div>
		<!-- 팝업 내용 -->
		<div class="popup" style="padding: 20px;"> 
		<form name="popOpenDs"  method="post" action="#">
			<table class="list01" style="position:relative;">
					<caption>단위 선택</caption>
					<colgroup>
						<col width="150"/>
						<col width=""/>
						<col width="150"/>
						<col width=""/>
						<col width="150"/>
						<col width=""/>
					</colgroup>
					<tr>
						<th><label class="">단위명</label></th>
						<td colspan="5">
		                 	<input type="text" name="dtNm" class="input" maxlength="160"/>
							<button type="button" class="btn01" name="dtSearch">검색</button>
						</td>
					</tr>
					<tr>
						<td colspan="6" align="right">
							<input type="checkbox" id="chkTreeOpen" name="chkTreeOpenClose"/>
							<label for="chkTreeOpen" name="chkTreeOpenCloseLabel">항목펼치기</label>
						</td>
					</tr>
				</table>
			</form>	
			<div style="clear: both;"></div>
			<div class="ibsheet_area_both">
				<script type="text/javascript">createIBSheet("sheet", "100%", "300px"); </script>
			</div>
		</div>
		<div class="buttons">
			<a href="#" class="btn02" name="closePop">닫기</a>
		</div>	
	</div>

</div>

</body>
</html>