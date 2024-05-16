<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="egovframework.common.WiseOpenConfig"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>  
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><spring:message code='wiseopen.title'/></title>                  
<c:import  url="/WEB-INF/jsp/inc/headinclude.jsp"/>
</head>                                                
<style type="text/css">
body{background:none;}
a{text-decoration:none; color:#000000;}         
a:hover{color:#ff0000;}        

ul {
    list-style:square inside;
    margin:2px;
    padding:0;
}

li {
    margin: 0 20px 2px 0;
    padding: 7px 7px 0 0;
    border : 0;
    float: left;
}
</style>                  
<script language="javascript">       

$(function() {
	// 컴포넌트를 초기화한다.
    initComp();
 	
	// 이벤트를 바인딩한다.
    bindEvent();
	
 	// 옵션을 로드한다.
    loadOptions();
 	
    // 데이터를 로드한다.
    loadData();
});

////////////////////////////////////////////////////////////////////////////////
//글로벌 변수
////////////////////////////////////////////////////////////////////////////////
var ctxPath = '<c:out value="${pageContext.request.contextPath}" />';

////////////////////////////////////////////////////////////////////////////////
//초기화 함수
////////////////////////////////////////////////////////////////////////////////

/**
 * 컴포넌트를 초기화한다.
 */
function initComp() {
	loadSheet();    
}


/**
 * 이벤트를 바인딩한다.
 */
function bindEvent() {
	//팝업창 닫기
	$("a[name=a_close]").bind("click", function(event) {
		window.close();
	});
}

/**
 * 옵션을 로드한다.
 */
function loadOptions() {
}

/**
 * 데이터를 로드한다.
 */
function loadData() {
	doAction("search");
}
////////////////////////////////////////////////////////////////////////////////
//서비스 함수
////////////////////////////////////////////////////////////////////////////////

/**
* 화면 액션
*/
function doAction(sAction) {
	var formObj = $("form[name=opnAplForm]");
	
	switch(sAction) {                       
	case "search":
		var param = formObj.serialize();
		ajaxBeforeSendAdmin(com.wise.help.url("/admin/ajaxBeforeSendAdmin.do")); //IbSheet 조회전 세션 체크
		
		var url = "";
		var dcsYn = $("input[name=dcsYn]").val();
		
		if(dcsYn == 'Y') url = com.wise.help.url("/admin/expose/selectAplDcsdtList.do"); //(통계) 공개여부 결정기간별 현황("Y" 여부에 따라 호출하는 URL변경)
		else url = com.wise.help.url("/admin/expose/opnApplyList.do");
		
		var param = {PageParam: "page", Param: "rows=50"+"&"+param};
		sheet.DoSearchPaging(url, param);
		break;
	}
}

//청구서 조회 이동
function goOpnAplPopup() {
	
	var form = $("form[name=opnAplForm]");
	
	form.attr("action", com.wise.help.url("/admin/expose/popup/viewOpnAplPopup.do"));
	form.attr("target", "_self");
	form.submit();
}

////////////////////////////////////////////////////////////////////////////////
//시트 로드
////////////////////////////////////////////////////////////////////////////////
function loadSheet() {
	
	createIBSheet2(document.getElementById("sheet"),"sheet", "100%", "650px");
	
	var gridTitle ="NO";
	gridTitle +="|상태";
	gridTitle +="|신청번호";
	gridTitle +="|접수번호";
	gridTitle +="|신청일자";
	gridTitle +="|청구제목";
	gridTitle +="|청구인";
	gridTitle +="|청구기관코드";
	gridTitle +="|청구기관";
	gridTitle +="|처리기관코드";
	gridTitle +="|처리기관";
	gridTitle +="|처리상태코드";
	gridTitle +="|공개여부";
	gridTitle +="|상태";
	gridTitle +="|종결여부";
	gridTitle +="|통지일자";
	
	with(sheet){
		                     
		var cfg = {SearchMode:3,Page:50,VScrollMode:1};
	    SetConfig(cfg);
	    var headers = [
	                {Text:gridTitle, Align:"Center"}
	            ];
	    var headerInfo = {Sort:0,ColMove:0,ColResize:1,HeaderCheck:1};
	    
	    InitHeaders(headers, headerInfo);
	   
	    var cols = [
	                 {Type:"Seq",		SaveName:"seq",			    Width:30,	Align:"Center",		Edit:false}
	                ,{Type:"Status",	SaveName:"status",		    Width:30,	Align:"Center",		Edit:false,	Hidden:true}
	                ,{Type:"Text",	    SaveName:"aplNo",		    Width:30,	Align:"Center",		Edit:false,	Hidden:true}
					,{Type:"Text",		SaveName:"rcpDtsNo",	    Width:80,	Align:"Center",		Edit:false}
					,{Type:"Text",		SaveName:"aplDt",	        Width:80,	Align:"Center",		Edit:false, Format:"Ymd"}
					,{Type:"Text",		SaveName:"aplSj",		    Width:150,	Align:"Left",		Edit:false}
					,{Type:"Text",		SaveName:"aplPn",		    Width:50,	Align:"Center",		Edit:false}
					,{Type:"Text",		SaveName:"aplInstCd",	    Width:90,	Align:"Center",		Edit:false,	Hidden:true}
					,{Type:"Text",		SaveName:"aplInstNm",	    Width:90,	Align:"Center",		Edit:false,	Hidden:true}
					,{Type:"Text",		SaveName:"aplDealInstCd",	Width:90,	Align:"Center",		Edit:false,	Hidden:true}
					,{Type:"Text",		SaveName:"aplDealInstNm",	Width:90,	Align:"Center",		Edit:false}
					,{Type:"Text",		SaveName:"prgStatCd",	    Width:90,	Align:"Center",		Edit:false,	Hidden:true}
					,{Type:"Text",		SaveName:"opbYnNm",	        Width:50,	Align:"Center",		Edit:false}
					,{Type:"Text",		SaveName:"prgStatNm",	    Width:90,	Align:"Center",		Edit:false}
					,{Type:"Text",		SaveName:"endNm",	        Width:50,	Align:"Center",		Edit:false}
					,{Type:"Text",		SaveName:"dcsNtcDt",	    Width:50,	Align:"Center",		Edit:false, Format:"Ymd", Hidden:true}
	            ];                                          
	    InitColumns(cols);
	    FitColWidth();
	    SetExtendLastCol(1);
	    

	}               
	default_sheet(sheet);   
	
}
////////////////////////////////////////////////////////////////////////////////
//시트 서비스 함수
////////////////////////////////////////////////////////////////////////////////
function sheet_OnDblClick(row, col, value, cellx, celly) {
	if(row < 1) return;   
	
	var id = sheet.GetCellValue(row, "aplNo");//탭 id(유일한key))
	$("input[name=aplNo]").val(id); 
	
	goOpnAplPopup(); //청구서 상세 (팝업) 이동
	    
}

function sheet_OnSearchEnd(code, message, statusCode, statusMessage) {
}
////////////////////////////////////////////////////////////////////////////////
//Validation 함수
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
//기타 함수
////////////////////////////////////////////////////////////////////////////////

</script>                
<body>
<div class="popup">
	<h3>청구서조회</h3>
	<div id="div-sect" style="padding:15px;">
		<form name="opnAplForm" method="post" action="#">
		 	<input type="hidden" name="aplNo" value="" />
		 	<input type="hidden" name="objtnSno" value="" />
		 	<!-- 공통  -->
			<input type="hidden" name="aplDealInstCd" value="<c:out value="${param.aplDealInstCd}"/>" />
			
			<!-- 청구서 처리현황 통계에서 넘겨주는 파라미터  -->
		 	<input type="hidden" name="opbYnp" value="<c:out value="${param.opbYnp}"/>" />
		 	<input type="hidden" name="trsf" value="<c:out value="${param.trsf}"/>" />
		 	<input type="hidden" name="prg" value="<c:out value="${param.prg}"/>" />
		 	<!-- // 청구서 처리현황 통계에서 넘겨주는 파라미터  -->	
		 	
		 	<!-- 처리방법별 현황 통계에서 넘겨주는 파라미터  -->
		 	<input type="hidden" name="aplTakMth" value="<c:out value="${param.aplTakMth}"/>" />
		 	<!-- // 처리방법별 현황 통계에서 넘겨주는 파라미터  -->
		 	
		 	<!-- 공개방법별 현황 통계에서 넘겨주는 파라미터  -->
		 	<input type="hidden" name="opbFomVAl" value="<c:out value="${param.opbFomVAl}"/>" />
		 	<input type="hidden" name="giveMth" value="<c:out value="${param.giveMth}"/>" />
		 	<input type="hidden" name="opbY" value="<c:out value="${param.opbY}"/>" />
		 	<!-- // 공개방법별 현황 통계에서 넘겨주는 파라미터  -->
		 	
		 	<!-- 비공개(부분공개) 사유별 현황 통계에서 넘겨주는 파라미터  -->
		 	<input type="hidden" name="clsdRsonCd" value="<c:out value="${param.clsdRsonCd}"/>" />
		 	<!--// 비공개(부분공개) 사유별 현황 통계에서 넘겨주는 파라미터  -->	
		 	
		 	<!-- 이의신청서처리 현황 통계에서 넘겨주는 파라미터  -->
		 	<input type="hidden" name="objtn" value="<c:out value="${param.objtn}"/>" />
		 	<!--// 이의신청서처리 현황 통계에서 넘겨주는 파라미터  -->	
		 	
		 	<!-- 공개여부 결정기간별 현황 통계에서 넘겨주는 파라미터  -->
		 	<input type="hidden" name="dcsYn" value="<c:out value="${param.dcsYn}"/>" /> <!-- "Y" 여부에 따라 호출하는 URL변경  -->
		 	<input type="hidden" name="aplDtFrom" value="<c:out value="${param.aplDtFrom}"/>" />
		 	<input type="hidden" name="aplDtTo" value="<c:out value="${param.aplDtTo}"/>" />
		 	<input type="hidden" name="fromDt" value="<c:out value="${param.fromDt}"/>" />
		 	<input type="hidden" name="toDt" value="<c:out value="${param.toDt}"/>" />
		 	<!-- //공개여부 결정기간별 현황 통계에서 넘겨주는 파라미터  -->
			<div style="clear: both;"></div>
			<div class="ibsheet_area_both">
				<div id="sheet" class="sheet"></div> 
			</div>	
			
			<div class="buttons">
				${sessionScope.button.a_close}
			</div> 
		</form>	
	</div>
	<form name="printForm" method="post">
	    <input type="hidden" name="mrdParam" value=""/>
		<input type="hidden" name="width" value=""/>
		<input type="hidden" name="height" value=""/>
		<input type="hidden" name="title" value=""/>
	</form>
</div>
<iframe id="download-frame" name="download-frame"  title="다운로드 처리" height="0" style="width:100%; display:none;"></iframe>
</body>

</html>                          