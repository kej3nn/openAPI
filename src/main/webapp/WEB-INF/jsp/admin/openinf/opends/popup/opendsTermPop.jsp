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
<title>재정용어 선택 | 데이터셋관리ㅣ<spring:message code='wiseopen.title'/></title>             
<c:import  url="/WEB-INF/jsp/inc/headinclude.jsp"/>
<style type="text/css">
body{background:none;} /* 임시로 해놓은 것임 */
</style>                                         
<script type="text/javascript">
var tabContentClass= "content";

function setButton(){
	$("button[name=dtSearch]").click(function(){	doAction("search");	return false;});
	$("a[name=closePop]").click(function(){	window.close();	});
	$("a[name=apply]").click(function(){	applyTerm();	});
	$("a[name=initTerm]").click(function(){	initTerm();	});
}
$(document).ready(function()    {     
	$("input[name=searchWord]").focus();  
	LoadPage();                                                               
	doAction('search');      
	setButton();
	inputEnterKey();
});   

function LoadPage()                
{
	var gridTitle = "선택"
	     gridTitle +="|NO|NO";
	     gridTitle +="|"+"재정용어";
	     gridTitle +="|"+"설명";
	       
                    
    with(mySheet1){
    	                     
    	var cfg = {SearchMode:3,Page:50,VScrollMode:1};                       
        SetConfig(cfg);             
        var headers = [                                   
                    {Text:gridTitle, Align:"Center"}
                ];
        var headerInfo = {Sort:0, ColMove:0, ColResize:1, HeaderCheck:1};
        
        InitHeaders(headers, headerInfo);                           
            
        var cols = [          
					 {Type:"Radio",		SaveName:"useYn",		Width:10,	Align:"Center",		Edit:true, TrueValue:"Y", FalseValue:"N",  Sort:false}
					,{Type:"Seq",		SaveName:"SEQ",				Width:10,	Align:"Center",		Edit:false,  Sort:false}
					,{Type:"Text",		SaveName:"seq",			Width:100,	Align:"Center",		Edit:false, 		Hidden:true}
					,{Type:"Text",		SaveName:"bbsTit",			Width:50,	Align:"Left",		Edit:false}
					,{Type:"Text",		SaveName:"bbsCont",			Width:100,	Align:"Left",		Edit:false,  Sort:false}
                ];                                                                    
                                      
        InitColumns(cols);                                                                                               
        FitColWidth();                                                                       
        SetExtendLastCol(1);   
        ShowToolTip(1);
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
			var searchWord = $("input[name=searchWord]").val();
			ajaxBeforeSendAdmin("<c:url value='/admin/ajaxBeforeSendAdmin.do'/>"); //IbSheet 조회전 세션 체크
			var param = {PageParam: "ibpage", Param: "onepagerow=50&searchWord="+searchWord};         
			mySheet1.DoSearchPaging("<c:url value='/admin/openinf/opends/openDsTermPopList.do'/>", param);
			break;
			
	}
}


function applyTerm(){
	var rowCnt = mySheet1.RowCount();
	var sheetNm = $("input[name=sheetNm]").val();
	var toSheet = opener.window[sheetNm];
	var toRow = $("input[name=toRow]").val();
	var fromSeq = "";
	var bbsTit = "";
	var cnt = 0;
	for(var i = 1; i<= rowCnt ; i++){
		if(mySheet1.GetCellValue(i, "useYn") == "Y"){
			fromSeq = mySheet1.GetCellValue(i, "seq");
			bbsTit = mySheet1.GetCellValue(i, "bbsTit");
			cnt ++;
		}
	}
	if(cnt == 0){
		alert("재정용어를 선택해주세요.");
		return;
	}
	toSheet.SetCellValue(toRow, "termSeq", fromSeq);
	toSheet.SetCellValue(toRow, "bbsTit", bbsTit);
	
// 	window.close();	
}

function initTerm(){
	var sheetNm = $("input[name=sheetNm]").val();
	var toSheet = opener.window[sheetNm];
	var toRow = $("input[name=toRow]").val();
	var fromSeq = "";
	var bbsTit = "";
	toSheet.SetCellValue(toRow, "termSeq", fromSeq);
	toSheet.SetCellValue(toRow, "bbsTit", bbsTit);
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
			<h2>재정용어 선택</h2>
		</div>
		<!-- 팝업 내용 -->
		<div class="popup" style="padding: 20px;"> 
		<form name="popOpenDs"  method="post" action="#">
		<input type="hidden" name="sheetNm" value="${sheetNm }"/>
		<input type="hidden" name="toRow" value="${toSeq }"/>
			<table class="list01" style="position:relative;">
					<caption>재정용어 선택</caption>
					<colgroup>
						<col width="150"/>
						<col width=""/>
						<col width="150"/>
						<col width=""/>
						<col width="150"/>
						<col width=""/>
					</colgroup>
					<tr>
						<th><label class="">재정용어</label></th>
						<td colspan="5">
		                 	<input type="text" name="searchWord" class="input" maxlength="160"/>
							<button type="button" class="btn01" name="dtSearch">검색</button>
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
			<a href="#" class="btn02" name="initTerm">초기화</a>
			<a href="#" class="btn02" name="apply">적용</a>
			<a href="#" class="btn02" name="closePop">닫기</a>
		</div>	
	</div>

</div>

</body>
</html>