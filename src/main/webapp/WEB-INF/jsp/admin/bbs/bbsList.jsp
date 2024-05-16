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
<title><spring:message code='wiseopen.title'/></title>                    
<c:import  url="/WEB-INF/jsp/inc/headinclude.jsp"/>
<script language="javascript">
function tabSet(){ //탭 객체 생성  
	openTab = new OpenTab(tabId,tabContentClass,tabBody); //headinclude.jsp 변수 있음
	openTab.TabObj = openTab;  
	openTab.addTabClickEvent();    
}

$(document).ready(function()    {   
	LoadPage();                                                               
	doAction('search');                                              
	inputEnterKey();       
	tabSet();// tab 셋팅
	init();
	setTabButton();		//탭 버튼
});    

var bbsCd ="${bbsCd}";
var bbsTypeCd = "${bbsTypeCd}";
var nView = "true";
var qView = "true";
var fView = "false";
var gView = "true";
var sView = "true";
var dView = "true";
var dView1 = "true";
var dView2 = "true";
var dView3 = "true";
var dView4 = "true";
var aView = "true";
var pView = "true";
var formView = false;
var typeVal = "";
var saveVal = "";
var ansTag ="";
var noticeYn = "";
var emailNeedYn = "";
var telNeedYn = "";
var htmlYn = "";
var atfileYn= "";
var linkYn = "";
var infYn = "";
var tblYn = "";
var extLimit = "";
var zView = "true";  // 활용갤러리 구분용

function init(){
	var formObj = $("form[name=adminBbsList]");
	formObj.find("button[name=btn_search]").click(function(e) { 
		doAction("search");
		 return false;        
	 }); 
	formObj.find("button[name=btn_reg]").click(function(e) { 
		doAction("reg");
		return false;                  
	 }); 
	
	if(bbsCd == ""){
		alert("호출 값이 없어 메인으로 이동합니다");
		location.href="<c:url value='/admin/adminMain.do'/>";
	}
	
	<c:forEach var="result" items="${result}" >
		ansTag = "${result.ansTag}";
		<c:if test="${result.atfileYn eq 'N' && result.linkYn eq 'N' && result.infYn eq 'N' && result.ansTag eq 'N' }">
			formView = true;
		</c:if>
		emailNeedYn = "${result.emailNeedYn}";
		telNeedYn = "${result.telNeedYn}";
		htmlYn = "${result.htmlYn}";
		atfileYn = "${result.atfileYn}";
		infYn	= "${result.infYn}";
		linkYn = "${result.linkYn}";
		tblYn = "${result.tblYn}";
		extLimit = "${result.extLimit}";
	</c:forEach>
	
	// 입력기간 초기화
	$("button[name=openDttm_reset]").bind("click", function(e) {
		$("input[name=regStartDtts], input[name=regEndDtts]").val("");
	});
	
	// 메인 폼 공개일 from ~ to
	$("form[name=adminBbsList]").find("input[name=regStartDtts], input[name=regEndDtts]").datepicker(setDatePickerCalendar());
	$("form[name=adminBbsList]").find('input[name=regStartDtts]').datepicker('option', 'onClose',  function( selectedDate ) {$("input[name=regEndDtts]").datepicker( "option", "minDate", selectedDate );});
	$("form[name=adminBbsList]").find('input[name=regEndDtts]').datepicker('option', 'onClose',  function( selectedDate ) {	$("input[name=regStartDtts]").datepicker( "option", "maxDate", selectedDate );});

	
}

function buttonEventAdd(){
	setTabButton();
	setUrlButton();
	setInfButton();
	setFileButton();
	setTblButton();		// 2018.04.26/softon 통계표 연결 버튼 이벤트
}

function checkView(){
	<c:forEach var="result" items="${result}" >
	ansTag = "${result.ansTag}";
	noticeYn = "${result.noticeYn}";
	<c:if test="${result.listCd != null}">
		dView = "false";
	</c:if>
	<c:if test="${result.list1Cd != null}">
		dView1 = "false";
	</c:if>
	<c:if test="${result.list2Cd != null}">
		dView2 = "false";
	</c:if>
	<c:if test="${result.list3Cd != null}">
		dView3 = "false";
	</c:if>
	<c:if test="${result.list4Cd != null}">
		dView4 = "false";
	</c:if>
	</c:forEach>

	if(noticeYn == "Y"){	//공지게시판
		nView = "false";
		pView = "false";
		zView = "true";
	}
	if(ansTag != "N"){	// 답변, 승인, 보고
		qView = "false";
		sView = "false";
		aView = "false";
	}
	if(bbsCd == 'FAQ01') {
		fView = "false";
		zView = "true";
	} 
	if(bbsCd == 'GALLERY') {
		fView = "false";
		zView = "false";
		qView = "true";
		gView = "true";
	}
}
var oEditors = [];
var fileEditors = [];

function dHtmlYn(){
	nhn.husky.EZCreator.createInIFrame({ 
		oAppRef: oEditors, 
		elPlaceHolder: "bbsCont",	// 에디터 적용할 textarea 이름
		sSkinURI: "/SmartEditor2/SmartEditor2Skin.html",
		fCreator: "createSEditor2" ,
		htParams : {
			fOnBeforeUnload : function(){ 
				//alert("onbeforeunload call"); 
			}
		}, 
		formObj: "adminBbsList"	// form 이름
	});
}

function convertIBSCol(data) {
	var options = {};
    
    options.ComboCode = "";
    options.ComboText = "";
    
    for (var i = 0; i < data.length; i++) {
        if (i > 0) {
            options.ComboCode += "|";
            options.ComboText += "|";
        }
        
        options.ComboCode += data[i].code;
        options.ComboText += data[i].name;
    }
    
    return options;
}

function LoadPage()                
{      
	checkView();
	//message-common_ko_KR.properties 선언 후 사용 or message-common_en_US.properties 선언 후 사용
	var gridTitle = "NO|NO"
		gridTitle +="|"+"<spring:message code='labal.bbsCd'/>";  
		gridTitle +="|" + (dView ? "${listMap.getListNm()}" : "게시글분류");
		gridTitle +="|" + (dView1 ? "${listMap.getList1Nm()}" : "분류1");
		gridTitle +="|" + (dView2 ? "${listMap.getList2Nm()}" : "분류2");
		gridTitle +="|" + (dView3 ? "${listMap.getList3Nm()}" : "분류3");
		gridTitle +="|" + (dView4 ? "${listMap.getList4Nm()}" : "분류4");
		gridTitle +="|"+"<spring:message code='labal.bbsTit'/>";  
		gridTitle +="|"+"<spring:message code='labal.noticeYn'/>"; 
		
		gridTitle +="|"+"<spring:message code='labal.secretYn1'/>";
		gridTitle +="|"+"팝업여부"; 
		if(qView == "false")		gridTitle +="|"+"<spring:message code='labal.ansState1'/>"; 
		if(gView == "false")		gridTitle +="|"+"<spring:message code='labal.ansState2'/>";
		if(qView == "true" && gView == "true") gridTitle +="|"+"<spring:message code='labal.ansState2'/>";
		gridTitle +="|"+"<spring:message code='labal.prssDttm'/>";        
		if(zView == "true" ) {
			gridTitle +="|"+"<spring:message code='labal.userOrg'/>"; 
		} else {
			gridTitle +="|"; 
		}
		
		gridTitle +="|"+"<spring:message code='labal.userNm'/>";        
		gridTitle +="|"+"<spring:message code='labal.userDttm'/>";        
		gridTitle +="|"+"<spring:message code='labal.viewCnt'/>";     
		if(zView == "false" ) {
			gridTitle +="|"+"평가점수";   
		} else {
			gridTitle +="|"; 
		}
	
    with(mySheet){
    	                     
    	var cfg = {SearchMode:3,Page:50,VScrollMode:1};                                
        SetConfig(cfg);  
        var headers = [                                             
                    {Text:gridTitle, Align:"Center"}                 
                ];
        var headerInfo = {Sort:0,ColMove:1,ColResize:1,HeaderCheck:0};
        
        InitHeaders(headers, headerInfo); 
         
        var cols = [          
					 {Type:"Seq",			SaveName:"bSeq",			Width:30,	Align:"Center",		Edit:false}
					,{Type:"Text",			SaveName:"seq",				Width:30,	Align:"Center",		Edit:false, Hidden:true}
					,{Type:"Text",			SaveName:"bbsCd",			Width:100,	Align:"Center",		Edit:false, Hidden:true}
					,{Type:"Combo",			SaveName:"listSubCd",		Width:100,	Align:"Center",		Edit:false, Hidden:dView}
					,{Type:"Combo",			SaveName:"list1SubCd",		Width:100,	Align:"Center",		Edit:false, Hidden:dView1}
					,{Type:"Combo",			SaveName:"list2SubCd",		Width:100,	Align:"Center",		Edit:false, Hidden:dView2}
					,{Type:"Combo",			SaveName:"list3SubCd",		Width:100,	Align:"Center",		Edit:false, Hidden:dView3}
					,{Type:"Combo",			SaveName:"list4SubCd",		Width:100,	Align:"Center",		Edit:false, Hidden:dView4}
					,{Type:"Text",			SaveName:"bbsTit",			Width:400,	Align:"Left",		Edit:false}
					,{Type:"CheckBox",		SaveName:"noticeYn",		Width:100,	Align:"Center",		Edit:false, TrueValue:"Y", FalseValue:"N", Hidden:nView}
					,{Type:"CheckBox",		SaveName:"secretYn",		Width:100,	Align:"Center",		Edit:false, TrueValue:"Y", FalseValue:"N", Hidden:qView}
					,{Type:"CheckBox",		SaveName:"popupYn",			Width:100,	Align:"Center",		Edit:false, TrueValue:"Y", FalseValue:"N", Hidden:pView}
					,{Type:"Text",			SaveName:"ansStateNm",		Width:100,	Align:"Center",		Edit:false, Hidden:aView}
					,{Type:"Text",			SaveName:"apprDttm",		Width:100,	Align:"Center",		Edit:false, Hidden:sView}
					,{Type:"Text",			SaveName:"deptNm",			Width:100,	Align:"Center",		Edit:false, Hidden:fView}
					,{Type:"Text",			SaveName:"userNm",			Width:100,	Align:"Center",		Edit:false}
					,{Type:"Text",			SaveName:"regDttm",			Width:100,	Align:"Center",		Edit:false} 
					,{Type:"Text",			SaveName:"viewCnt",			Width:100,	Align:"Center",		Edit:false, Hidden:fView}
					,{Type:"Text",			SaveName:"apprVal",			Width:100,	Align:"Center",		Edit:false,  Hidden:zView}
                ];
                                      
        InitColumns(cols);                                                                           
        FitColWidth();                                                         
        SetExtendLastCol(1);  
        
        
        
        if ( dView )	SetColProperty("listSubCd", ${ditcListIBS});
        if ( dView1 )	SetColProperty("list1SubCd", ${ditcList1IBS});
        if ( dView2 )	SetColProperty("list2SubCd", ${ditcList2IBS});
        if ( dView3 )	SetColProperty("list3SubCd", ${ditcList3IBS});
        if ( dView4 )	SetColProperty("list4SubCd", ${ditcList4IBS});

    }               
    default_sheet(mySheet);                      
}    

function LoadUrlPage(sheetName, newYn)                
{   
	var gridTitle = "삭제|상태|NO|NO"
		gridTitle +="|"+"<spring:message code='labal.bbsCd'/>";  
		gridTitle +="|"+"<spring:message code='labal.linkNm'/>";  
		gridTitle +="|"+"<spring:message code='labal.uri'/>";  
		gridTitle +="|"+"<spring:message code='labal.Seq'/>"; 
		gridTitle +="|"+"<spring:message code='labal.delYn'/>"; 
	  
    with(sheetName){
    	                     
    	var cfg = {SearchMode:2,Page:50,VScrollMode:1};                                
        SetConfig(cfg);  
        var headers = [                                             
                    {Text:gridTitle, Align:"Center"}                 
                ];
        var headerInfo = {Sort:0,ColMove:1,ColResize:1,HeaderCheck:0};
        
        InitHeaders(headers, headerInfo); 
         
        var cols = [       
					{Type:"DelCheck",		SaveName:"delChk",			Width:30,	Align:"Center",		Edit:true}
					,{Type:"Status",		SaveName:"status",			Width:30,	Align:"Center",		Edit:false}
					,{Type:"Seq",			SaveName:"bSeq",			Width:100,	Align:"Center",		Edit:false}
					,{Type:"Text",			SaveName:"seq",				Width:100,	Align:"Center",		Edit:false, Hidden:true}
					,{Type:"Text",			SaveName:"bbsCd",			Width:100,	Align:"Center",		Edit:false, Hidden:true}
					,{Type:"Text",			SaveName:"linkNm",			Width:400,	Align:"Left",			Edit:true}
					,{Type:"Text",			SaveName:"url",				Width:400,	Align:"Left",			Edit:true}
					,{Type:"Text",			SaveName:"linkSeq",			Width:400,	Align:"Left",			Edit:false, Hidden:true}
					,{Type:"CheckBox",		SaveName:"delYn",			Width:100,	Align:"Center",		Edit:false, TrueValue:"Y", FalseValue:"N"}
                ];
                                      
        InitColumns(cols);                                                                           
        FitColWidth();                                                         
        SetExtendLastCol(1);   
    }               
    default_sheet(sheetName);    
    
    if(!newYn){
	    doActionUrl("search");
    }
    sheetName.SetFocusAfterProcess(0);			// 조회 후 포커스 두지 않음
}
function LoadInfPage(sheetName, newYn)                
{         
 var gridTitle = "삭제|상태|NO|NO"
		gridTitle +="|"+"<spring:message code='labal.bbsCd'/>";  
		gridTitle +="|"+"<spring:message code='labal.infId'/>";  
		gridTitle +="|"+"<spring:message code='labal.infNm'/>";  
		gridTitle +="|"+"<spring:message code='labal.delYn'/>";  
	
    with(sheetName){
    	                     
    	var cfg = {SearchMode:2,Page:50,VScrollMode:1};                                
        SetConfig(cfg);  
        var headers = [                                             
                    {Text:gridTitle, Align:"Center"}                 
                ];
        var headerInfo = {Sort:0,ColMove:1,ColResize:1,HeaderCheck:0};
        
        InitHeaders(headers, headerInfo); 
         
        var cols = [ 
					{Type:"DelCheck",		SaveName:"delChk",			Width:30,	Align:"Center",		Edit:true}
					,{Type:"Status",			SaveName:"status",			Width:30,	Align:"Center",		Edit:false}
					,{Type:"Seq",				SaveName:"bSeq",			Width:100,	Align:"Center",		Edit:false}
					,{Type:"Text",				SaveName:"seq",				Width:100,	Align:"Center",		Edit:false}
					,{Type:"Text",				SaveName:"bbsCd",			Width:30,	Align:"Center",		Edit:false, Hidden:true}
					,{Type:"Text",				SaveName:"infId",			Width:200,	Align:"Center",		Edit:false}
					,{Type:"Text",				SaveName:"infNm",			Width:400,	Align:"Left",			Edit:false}
					,{Type:"CheckBox",		SaveName:"delYn",			Width:100,	Align:"Center",		Edit:false, TrueValue:"Y", FalseValue:"N"}
                ];
                                      
        InitColumns(cols);                                                                           
        FitColWidth();                                                         
        SetExtendLastCol(1);   
    }               
    default_sheet(sheetName);     
    
    if(!newYn){
	    doActionInf("search");
    }
    sheetName.SetFocusAfterProcess(0);			// 조회 후 포커스 두지 않음
}

// 2018.04.26/softon - 통계표 연결 시트 로드
function LoadTblPage(sheetName, newYn)                
{         
 var gridTitle = "삭제|상태|NO|NO"
		gridTitle +="|"+"<spring:message code='labal.bbsCd'/>";  
		gridTitle +="|통계표ID";  
		gridTitle +="|통계표명";  
		gridTitle +="|통계표연결구분";
		gridTitle +="|등록일자";
		gridTitle +="|삭제여부";
	
    with(sheetName){
    	                     
    	var cfg = {SearchMode:2,Page:50,VScrollMode:1};                                
        SetConfig(cfg);  
        var headers = [                                             
                    {Text:gridTitle, Align:"Center"}                 
                ];
        var headerInfo = {Sort:0,ColMove:1,ColResize:1,HeaderCheck:0};
        
        InitHeaders(headers, headerInfo); 
         
        var cols = [ 
					{Type:"DelCheck",		SaveName:"delChk",			Width:30,	Align:"Center",		Edit:true}
					,{Type:"Status",		SaveName:"status",			Width:30,	Align:"Center",		Edit:false}
					,{Type:"Seq",			SaveName:"bSeq",			Width:80,	Align:"Center",		Edit:false,	Hidden:0}
					,{Type:"Text",			SaveName:"seq",				Width:100,	Align:"Center",		Edit:false,	Hidden:1}
					,{Type:"Text",			SaveName:"bbsCd",			Width:30,	Align:"Center",		Edit:false, Hidden:1}
					,{Type:"Text",			SaveName:"statblId",		Width:300,	Align:"Center",		Edit:false}
					,{Type:"Text",			SaveName:"statblNm",		Width:450,	Align:"Left",		Edit:false}
					,{Type:"Combo",			SaveName:"tblLinkTag",		Width:100,	Align:"Center",		Edit:true, TrueValue:"Y", FalseValue:"N"}
					,{Type:"Text",			SaveName:"regDttm",			Width:200,	Align:"Center",		Edit:false}
					,{Type:"Combo",			SaveName:"delYn",			Width:100,	Align:"Center",		Edit:true, TrueValue:"Y", FalseValue:"N"}
                ];
                                      
        InitColumns(cols);                                                                           
        FitColWidth();                                                         
        SetExtendLastCol(1);   
        
        var options = {};
        options.ComboCode = "Y|N";
        options.ComboText = "예|아니오";
        SetColProperty(0, "delYn", 		{ ComboCode: "Y|N", ComboText: "예|아니오" });
        SetColProperty(0, "tblLinkTag", { ComboCode: "R|S", ComboText: "관련통계표|통계표상세분석" });
    }               
    default_sheet(sheetName);     
    
    if(!newYn){
	    doActionTbl("search");
    }
    sheetName.SetFocusAfterProcess(0);			// 조회 후 포커스 두지 않음
}

function LoadFilePage(sheetName, newYn)                
{      
 var gridTitle = "삭제|상태|NO|NO|NO"
		gridTitle +="|"+"<spring:message code='labal.bbsCd'/>";  
		gridTitle +="|"+"대표이미지";  
		<c:if test="${bbsCd eq 'FSL1004'}">
			gridTitle +="|"+"분류";  
		</c:if>	
		gridTitle +="|"+"<spring:message code='labal.viewFileNm'/>";  
		gridTitle +="|"+"원본파일명";  
		gridTitle +="|"+"저장파일명";  
		gridTitle +="|"+"<spring:message code='labal.fileExt'/>";  
		gridTitle +="|"+"<spring:message code='labal.fileSize'/>";  
		gridTitle +="|"+"<spring:message code='labal.regDttm'/>";
		gridTitle +="|내용";
		gridTitle +="|"+"<spring:message code='labal.delYn'/>";  
    with(sheetName){
    	                     
    	var cfg = {SearchMode:2,Page:50,VScrollMode:1};                                
        SetConfig(cfg);  
        var headers = [                                             
                    {Text:gridTitle, Align:"Center"}                 
                ];
        var headerInfo = {Sort:0,ColMove:1,ColResize:1,HeaderCheck:0};
        
        InitHeaders(headers, headerInfo); 
         
        var cols = [ 
					{Type:"DelCheck",			SaveName:"delChk",			Width:50,	Align:"Center",		Edit:true}
					,{Type:"Status",			SaveName:"status",			Width:50,	Align:"Center",		Edit:false}
					,{Type:"Seq",				SaveName:"bSeq",			Width:100,	Align:"Center",		Edit:false}
					,{Type:"Text",				SaveName:"fileSeq",			Width:100,	Align:"Center",		Edit:false, Hidden:true}
					,{Type:"Text",				SaveName:"mstSeq",			Width:100,	Align:"Center",		Edit:false, Hidden:true}
					,{Type:"Text",				SaveName:"bbsCd",			Width:30,	Align:"Center",		Edit:false, Hidden:true}
					,{Type:"Text",				SaveName:"topYn",			Width:30,	Align:"Left",		Edit:false, Hidden:true}
					,{Type:"Text",				SaveName:"viewFileNm",		Width:500,	Align:"Left",		Edit:false}
					,{Type:"Text",				SaveName:"srcFileNm",		Width:500,	Align:"Left",		Edit:false}
					,{Type:"Text",				SaveName:"saveFileNm",		Width:500,	Align:"Left",		Edit:false, Hidden:true}
					,{Type:"Text",				SaveName:"fileExt",			Width:200,	Align:"Left",		Edit:false}
					,{Type:"Text",				SaveName:"fileSize",		Width:200,	Align:"Center",		Edit:false}
					,{Type:"Text",				SaveName:"regDttm",			Width:200,	Align:"Left",		Edit:false}
					,{Type:"Text",				SaveName:"tmpFileCont",		Width:100,	Align:"Left",		Edit:false, Hidden:true}
					,{Type:"Combo",				SaveName:"delYn",			Width:100,	Align:"Center",		Edit:false, TrueValue:"Y", FalseValue:"N"}
                ];
                                      
        InitColumns(cols);                                                                           
        FitColWidth();                                                         
        SetExtendLastCol(1);   
        
        var options = {};
        options.ComboCode = "Y|N";
        options.ComboText = "예|아니오";
        SetColProperty(0, "delYn", options);
    }               
    default_sheet(sheetName);     
    
    if(!newYn){
	    doActionFile("search");
    }
    doActionFile("search2");
    sheetName.SetFocusAfterProcess(0);			// 조회 후 포커스 두지 않음
}

function LoadFilePage2(sheetName, newYn)                
{      
 var gridTitle = "삭제|상태|NO|NO|NO"
		gridTitle +="|"+"<spring:message code='labal.bbsCd'/>";  
		gridTitle +="|"+"<spring:message code='labal.viewFileNm'/>";  
		gridTitle +="|"+"원본파일명";  
		gridTitle +="|"+"저장파일명";  
		gridTitle +="|"+"<spring:message code='labal.fileExt'/>";  
		gridTitle +="|"+"<spring:message code='labal.fileSize'/>";  
		gridTitle +="|"+"<spring:message code='labal.regDttm'/>"; 
		gridTitle +="|"+"<spring:message code='labal.delYn'/>";  
    with(sheetName){
    	                     
    	var cfg = {SearchMode:2,Page:50,VScrollMode:1};                                
        SetConfig(cfg);  
        var headers = [                                             
                    {Text:gridTitle, Align:"Center"}                 
                ];
        var headerInfo = {Sort:0,ColMove:1,ColResize:1,HeaderCheck:0};
        
        InitHeaders(headers, headerInfo); 
         
        var cols = [ 
					{Type:"DelCheck",		SaveName:"delChk",				Width:30,	Align:"Center",		Edit:true}
					,{Type:"Status",			SaveName:"status",				Width:30,	Align:"Center",		Edit:false}
					,{Type:"Seq",				SaveName:"bSeq",				Width:100,	Align:"Center",		Edit:false}
					,{Type:"Text",				SaveName:"fileSeq",				Width:100,	Align:"Center",		Edit:false, Hidden:true}
					,{Type:"Text",				SaveName:"mstSeq",				Width:100,	Align:"Center",		Edit:false, Hidden:true}
					,{Type:"Text",				SaveName:"bbsCd",				Width:30,	Align:"Center",		Edit:false, Hidden:true}
					,{Type:"Text",				SaveName:"viewFileNm",		Width:500,	Align:"Left",		Edit:true}
					,{Type:"Text",				SaveName:"srcFileNm",			Width:500,	Align:"Left",		Edit:false}
					,{Type:"Text",				SaveName:"saveFileNm",		Width:500,	Align:"Left",		Edit:false, Hidden:true}
					,{Type:"Text",				SaveName:"fileExt",				Width:200,	Align:"Left",			Edit:false}
					,{Type:"Text",				SaveName:"fileSize",				Width:200,	Align:"Center",		Edit:false}
					,{Type:"Text",				SaveName:"regDttm",			Width:200,	Align:"Left",			Edit:false}
					,{Type:"CheckBox",		SaveName:"delYn",			Width:100,	Align:"Center",		Edit:false, TrueValue:"Y", FalseValue:"N"}
                ];
                                      
        InitColumns(cols);                                                                           
        FitColWidth();                                                         
        SetExtendLastCol(1);   
    }               
    default_sheet(sheetName);     
    
    if(!newYn){
	    doActionFile("search");
    }
    doActionFile("search2");
    sheetName.SetFocusAfterProcess(0);			// 조회 후 포커스 두지 않음
}



/*Sheet 각종 처리*/                  
function doAction(sAction)                                  
{
	var classObj = $("."+tabContentClass); //tab으로 인하여 form이 다건임
	var actObj = setTabForm(classObj); // 0: form data, 1: form 객체
	switch(sAction)
	{          
		case "search":      //조회   
			var formObj = $("form[name=adminBbsList]");        
			var formFileObj = $("form[name=adminFileForm]");        
			ajaxBeforeSendAdmin("<c:url value='/admin/ajaxBeforeSendAdmin.do'/>"); //IbSheet 조회전 세션 체크
			var param = {PageParam: "ibpage", Param: "onepagerow=50"+"&"+actObj[0]};
			mySheet.DoSearchPaging("<c:url value='/admin/bbs/selectBbsList.do'/>", param);   
			break;
		case "reg":      //등록화면                 
 			var title = "등록하기";
			var id ="bbsListReg";
			openTab.addRegTab(id,title,tabCallRegBack); // 탭 추가 시작함
			//alert(htmlYn);
		  	if(htmlYn == "Y"){
		  		//if($("iframe").length == 0){
		 			dHtmlYn();
		  		//}
			}  
		   	var cnt = sheetTabCnt++;
		   	if(atfileYn == "Y"){                           
		   		if(extLimit != "IMG"){  
		   			// 파일첨부일경우
		   			SheetCreate("FILESheet", cnt, "150", true);
		   			
		   			// 에디터 연다
		   			nhn.husky.EZCreator.createInIFrame({ 
		   				oAppRef: fileEditors, 
		   				elPlaceHolder: "fileCont",	// 에디터 적용할 textarea 이름
		   				sSkinURI: "/SmartEditor2/SmartEditor2Skin.html",
		   				fCreator: "createSEditor2" ,
		   				htParams : { 
		   					fOnBeforeUnload : function(){ 
		   						//alert("onbeforeunload call"); 
		   					}
		   				},
		   				formObj: "adminFileForm"	// form 이름
		   			});
		   		}
		   		
		   	}
		   	if(linkYn == "Y"){
			   	SheetCreate("URLSheet",cnt, "150", true);
		   	}
		   	if(infYn == "Y"){
			   	SheetCreate("INFSheet",cnt, "150", true);
		   	}     
		   	if(tblYn == "Y"){
			   	SheetCreate("TBLSheet",cnt, "200", true);
		   	} 
			break;
	}           
}   

function doTabAction(sAction){
	var classObj = $("."+tabContentClass); //tab으로 인하여 form이 다건임
	var actObj = setTabForm(classObj); // 0: form data, 1: form 객체
	var objTab = getTabShowObj();//탭이 oepn된 객체가져옴
	var formObj = objTab.find("form[name=adminBbsList]");
	var formAnsObj = objTab.find("form[name=adminAnsForm]");
	var formFileObj = objTab.find("form[name=adminFileForm]");
	ajaxBeforeSendAdmin("<c:url value='/admin/ajaxBeforeSendAdmin.do'/>"); //IbSheet 조회전 세션 체크
	
	
	switch(sAction){
		
		case "save":      //저장
			if(!saveCheck(formObj)){	return;			}	//validation 체크
			var url = "<c:url value='/admin/bbs/saveBbsList.do'/>"; 
			var param = formObj.serialize();
			var callbackForm = "";
			if(formView){
				ajaxCallAdmin(url, param, saveCallBack);
			}else{
				ajaxCallAdmin(url, param, saveBbsCallBack);
			}
			break;
		
		case "update":      //수정 
			var checkDel = formObj.find("input[name=delYn]").is(":checked");
			var message = "수정 하시겠습니까?";
			if(checkDel) {
				message = "삭제 상태로 수정하시겠습니까?"
			}
 			if ( !confirm(message) ) {
				return;
  			}
			if(!saveCheck(formObj)){	return;			}	//validation 체크
			var url = "<c:url value='/admin/bbs/updateBbsList.do'/>";
			var param = formObj.serialize();
			if(formView || checkDel){
				ajaxCallAdmin(url, param, saveCallBack);
			}else{
				ajaxCallAdmin(url, param, saveBbsCallBack);
			}
			break; 
			
		case "delete":      //삭제
			var fileSheetObj = window[formFileObj.find("input[name=fileSheetNm]").val()];
			if ( !gfn_isNull(fileSheetObj) ) {
				if ( fileSheetObj.RowCount() > 0 ) {
					alert("첨부파일 먼저 삭제해 주세요.");
					return;
				}
			}
 			if ( !confirm("데이터를 완전히 삭제 하시겠습니까? ") ) {
				return;
  			}
			 var url = "<c:url value='/admin/bbs/deleteBbsList.do'/>"; 
			 var param = openTab.ContentObj.find("[name=adminBbsList]").serialize();
			 ajaxCallAdmin(url, param, saveCallBack);
			 break;
			 
		case "AW":
			var ansState = "AW";
			var url = "<c:url value='/admin/bbs/updateAnsState.do'/>"; 
			var param = formObj.serialize();
				param += "&ansState="+ansState;
				param += "&"+formAnsObj.serialize();
			ajaxCallAdmin(url, param, saveCallBack);
			break;
			
		case "AK":
			var ansState = "AK";
			var url = "<c:url value='/admin/bbs/updateAnsState.do'/>"; 
			var param = formObj.serialize();
				param += "&ansState="+ansState;
				param += "&"+formAnsObj.serialize();
			ajaxCallAdmin(url, param, saveCallBack);
			break;
			
		case "AC":
			var ansState = "AC";
			var url = "<c:url value='/admin/bbs/updateAnsState.do'/>"; 
			var param = formObj.serialize();
				param += "&ansState="+ansState;
				param += "&"+formAnsObj.serialize();
			ajaxCallAdmin(url, param, saveCallBack);
			break;
		
		case "previewPop": // 미리보기
			var seq = formObj.find("input[name=seq]").val();
		
			window.open(com.wise.help.url("/admin/bbs/selectUtilGalleryPage.do") + "?seq=" + seq , "list", "fullscreen=no, width=1152, height=768, scrollbars=yes");
			break;
	}
}

function saveBbsCallBack(res){
	/* 
	var objTab = getTabShowObj();//탭이 oepn된 객체가져옴
	var formObj = objTab.find("form[name=adminBbsList]");
	formObj.find("input[name=seq]").val(res.RESULT.SEQ);
	doAction("search");
	//formObj.find("a[name=a_reg]").remove();
	alert(res.RESULT.MESSAGE);
	
	var formFileObj = objTab.find("form[name=adminFileForm]");
	formFileObj.find(".buttons").append("<a href=\"javascript:;\" class=\"btn03\" title=\"수정\" name=\"a_reg\">수정</a>");
	setFileButton();
	 */
	 // 게시물 등록 후 탭 닫고 메인으로
	 if ( res.RESULT.CODE > 0 ) {
		alert(res.RESULT.MESSAGE);
		var tabOnId = $(".tab li.on").children(":eq(0)").attr("id") ;	//열려 있는 탭 id 찾기
		$("#"+tabOnId).closest("li").remove();							//열려 있는 탭 ID li 제거
	    $("a[id=tabs-main]").click();   //메인 탭 클릭      
	    doAction("search");
	 }
}

function isValidURL(url) {
	var RegExp = /(ftp|http|https):\/\/(\w+:{0,1}\w*@)?(\S+)(:[0-9]+)?(\/\/([\w#!:.?+=%@!\-\/]))?/;
	return RegExp.test(url);
}

function doActionUrl(sAction){
	var classObj = $("."+tabContentClass); //tab으로 인하여 form이 다건임
	var actObj = setTabForm2(classObj,"adminBbsList"); // 0: form data, 1: form 객체
	var sheetObj; //IbSheet 객체         
	var param = actObj[0]  ;  
	var objTab = getTabShowObj();//탭이 oepn된 객체가져옴
	var formObj = objTab.find("form[name=adminBbsList]");
	var formLinkObj = objTab.find("form[name=adminLinkForm]");
	sheetObj =formLinkObj.find("input[name=linkSheetNm]").val();     
	ajaxBeforeSendAdmin("<c:url value='/admin/ajaxBeforeSendAdmin.do'/>"); //IbSheet 조회전 세션 체크
	var gridObj = window[sheetObj];
	
	switch(sAction)                    
	{          
		case "search":      //조회    
			gridObj.DoSearch("<c:url value='/admin/bbs/selectBbsLinkList.do'/>", param); 
			break;
			
		case "add":
			var url = formLinkObj.find("input[name=url]").val();
			var linkNm = formLinkObj.find("input[name=linkNm]").val();
			var seq = formObj.find("input[name=seq]").val();
			if(seq == ""){
				alert("상세정보를 먼저 등록해주세요");
				return false; 
			}
			if (linkNm ==""){
				alert("URL명을 입력해주세요");
				formLinkObj.find("input[name=linkNm]").focus();
				return false;
			}
			if(url == ""){
				alert("URL을 입력해주세요");
				formLinkObj.find("input[name=url]").focus();
				return false;
			}
			if ( !isValidURL(url) ) {
 				alert("URL 형식이 아닙니다.");
 				formLinkObj.find("input[name=url]").focus();
 				return false;
 			}
			var row = gridObj.DataInsert(-1);
			gridObj.SetCellValue(row, "bbsCd", bbsCd);
			gridObj.SetCellValue(row, "seq", seq);
			gridObj.SetCellValue(row, "url", url);
			gridObj.SetCellValue(row, "linkNm", linkNm);
			break;
		
		case "save":
			if ( !confirm("저장 하시겠습니까? ") ) {
				return;
  			}
			ibsSaveJson = gridObj.GetSaveJson(0);	
			if( !gridObj.IsDataModified() ) {
				alert("저장할 내역이 없습니다.");
				return;
			}
// 			if(ibsSaveJson.data.length == 0) return;
			for(var i=1; i<=gridObj.RowCount(); i++){ 
				var url = gridObj.GetCellValue(i, "url");
				if ( !isValidURL(url) ) {
	 				alert(i+"번째 행의 URL 형식을 확인해주세요.");
	 				return false;
	 			}
			}
			var url =  "<c:url value='/admin/bbs/saveBbsLinkList.do'/>";
			var param = "";
			IBSpostJson(url, param, ibsLinkcallback);
			break;
		
		case "delete":
			ibsSaveJson = gridObj.GetSaveJson(0);	
			if(ibsSaveJson.data.length == 0) return;
 			if ( !confirm("삭제 하시겠습니까? ") ) {
				return;
  			}
			var url =  "<c:url value='/admin/bbs/deleteBbsLinkList.do'/>";
			var param = "";
			IBSpostJson(url, param, ibsLinkcallback);
			break;
	}
}

function ibsLinkcallback(res){
/*     var result = res.RESULT.CODE;
    alert(result);    
    if(result == 0) {
    	alert(res.RESULT.MESSAGE);
    } else {
    	alert(res.RESULT.MESSAGE);
    } */
	if(res.RESULT.CODE == 0){
		alert("<spring:message code='MSG.SAVE'/>");
	}else{
		alert("<spring:message code='ERR.SAVE'/>");
	}
    
    OnBbsSaveEnd(res.RESULT.GUBUN);
} 

function OnBbsSaveEnd(gubun){
	if(gubun == "Url"){
		doActionUrl("search");
	}else if(gubun == "Inf"){
		doActionInf("search");
	}else if(gubun == "File"){
		doActionFile("search");
		doActionFile("search2");
	}else if(gubun == "File2"){
		
	}else if(gubun == "Img"){
		
	}else if(gubun == "tbl"){
		doActionTbl("search");
	}
}

function OnSaveEnd(){
	doAction("search");
}

function doActionInf(sAction){
	var classObj = $("."+tabContentClass); //tab으로 인하여 form이 다건임
	var actObj = setTabForm2(classObj,"adminBbsList"); // 0: form data, 1: form 객체
	var sheetObj; //IbSheet 객체         
	var param = actObj[0]  ;  
	var objTab = getTabShowObj();//탭이 oepn된 객체가져옴
	var formObj = objTab.find("form[name=adminBbsList]");
	var formInfObj = objTab.find("form[name=adminInfForm]");
	sheetObj =formInfObj.find("input[name=infSheetNm]").val();     
	ajaxBeforeSendAdmin("<c:url value='/admin/ajaxBeforeSendAdmin.do'/>"); //IbSheet 조회전 세션 체크
	var gridObj = window[sheetObj];
	switch(sAction)                    
	{          
		case "search":      //조회    
			gridObj.DoSearch("<c:url value='/admin/bbs/selectBbsInfList.do'/>", param); 
			break;      
		
		case "infPop":
			var url = "<c:url value="/admin/bbs/popup/bbsinf_pop.do"/>";
	    	popwin = OpenWindow(url, "infPop","700","550","yes"); 	
			break;
			
		case "add":		// 공공데이터 추가
			var infNm = formInfObj.find("input[name=infNm]").val();
			var infId = formInfObj.find("input[name=infId]").val();
			var seq = formObj.find("input[name=seq]").val();
			if(infNm == ""){
				alert("공공데이터명을 선택해주세요."); 
				formInfObj.find("input[name=infNm]").focus();
				return false;
			}else{
				var row = gridObj.DataInsert(-1);
				gridObj.SetCellValue(row, "bbsCd", bbsCd);
				gridObj.SetCellValue(row, "seq", seq);
				gridObj.SetCellValue(row, "infId", infId);
				gridObj.SetCellValue(row, "infNm", infNm);
				var dup = gridObj.ColValueDup("infId");
				if(dup > 0){
					alert("중복된 공공데이터가 존재하여 해당 데이터는 삭제됩니다.");
					gridObj.RowDelete(row, 0);
				}
			}
			break;
			
		case "save":
			ibsSaveJson = gridObj.GetSaveJson(0);	
// 			if(ibsSaveJson.data.length == 0) return;
			if( !gridObj.IsDataModified() ) {
				alert("저장할 내역이 없습니다.");
				return;
			}
			var url =  "<c:url value='/admin/bbs/saveBbsInfList.do'/>";
			var param = "";
			IBSpostJson(url, param, ibsLinkcallback);
			break;
			
		case "delete":
			ibsSaveJson = gridObj.GetSaveJson(0);	
// 			if(ibsSaveJson.data.length == 0) return;
			if( !gridObj.IsDataModified() ) {
				alert("삭제할 내역이 없습니다.");
				return;
			}
 			if ( !confirm("삭제 하시겠습니까? ") ) {
				return;
  			}
			var url =  "<c:url value='/admin/bbs/deleteBbsInfList.do'/>";
			var param = "";
			IBSpostJson(url, param, ibsLinkcallback);
			break;
	}
}

// 통계표 연결 시트를 가져온다(통계표연결 팝업에서 사용)
function getTblSheet() {
	var formTblObj = getTabShowObj().find("form[name=adminTblForm]");
	return window[formTblObj.find("input[name=tblSheetNm]").val()];
}

// 2018.04.26/softon - 통계표 연결 액션
function doActionTbl(sAction){
	var classObj = $("."+tabContentClass); //tab으로 인하여 form이 다건임
	var actObj = setTabForm2(classObj,"adminBbsList"); // 0: form data, 1: form 객체
	var sheetObj; //IbSheet 객체         
	var param = actObj[0]  ;  
	var objTab = getTabShowObj();//탭이 oepn된 객체가져옴
	var formObj = objTab.find("form[name=adminBbsList]");
	var formTblObj = objTab.find("form[name=adminTblForm]");
	sheetObj =formTblObj.find("input[name=tblSheetNm]").val();     
	ajaxBeforeSendAdmin("<c:url value='/admin/ajaxBeforeSendAdmin.do'/>"); //IbSheet 조회전 세션 체크
	var gridObj = window[sheetObj];
	switch(sAction)                    
	{          
		case "search":      //조회    
			gridObj.DoSearch("<c:url value='/admin/bbs/popup/selectBbsTblList.do'/>", param); 
			break;      
		case "tblPop":
			// 통계표 연결 추가 팝업
			var url = "<c:url value="/admin/bbs/popup/bbstbl_pop.do"/>";
			var params = "?seq=" + formObj.find("input[name=seq]").val() + "&bbsCd="+ formObj.find("input[name=bbsCd]").val();
	    	popwin = OpenWindow(url+params, "tblPop","700","550","yes"); 	
			break;
			
		case "save":
			// 통계표 연결 데이터 저장
			ibsSaveJson = gridObj.GetSaveJson(0);	
			if( !gridObj.IsDataModified() ) {
				alert("저장할 내역이 없습니다.");
				return;
			}
			
			if ( !confirm("저장 하시겠습니까?") ) {
				return;
  			}
			
			var url =  "<c:url value='/admin/bbs/saveBbsTbl.do'/>";
			var param = "";
			IBSpostJson(url, param, ibsLinkcallback);
			break;
		case "delete" :
			// 통계표 연결 데이터 삭제
			ibsSaveJson = gridObj.GetSaveJson(0);	
			if( !gridObj.IsDataModified() ) {
				alert("저장할 내역이 없습니다.");
				return;
			}
			
			if ( !confirm("삭제 하시겠습니까?") ) {
				return;
  			}
			
			var url =  "<c:url value='/admin/bbs/deleteBbsTbl.do'/>";
			var param = "";
			IBSpostJson(url, param, function(res) {
				if(res.RESULT.CODE == 0){
					alert(res.RESULT.MESSAGE);
				} else {
					alert("처리에 실패하였습니다.");
				}
				OnBbsSaveEnd(res.RESULT.GUBUN);
			});
			break;
	}
}


function doActionFile(sAction){
	var classObj = $("."+tabContentClass); //tab으로 인하여 form이 다건임
	var actObj = setTabForm2(classObj,"adminBbsList"); // 0: form data, 1: form 객체
	var sheetObj; //IbSheet 객체         
	var param = actObj[0]  ;  
	var objTab = getTabShowObj();//탭이 oepn된 객체가져옴
	var formObj = objTab.find("form[name=adminBbsList]");
	var formFileObj = objTab.find("form[name=adminFileForm]");
	sheetObj =formFileObj.find("input[name=fileSheetNm]").val();     
	ajaxBeforeSendAdmin("<c:url value='/admin/ajaxBeforeSendAdmin.do'/>"); //IbSheet 조회전 세션 체크
	var gridObj = window[sheetObj];
	
	switch(sAction){
	case "search":
		gridObj.DoSearch("<c:url value='/admin/bbs/selectBbsFileList.do'/>", param); 
		break;
		
	case "search2":
		ajaxCallAdmin("<c:url value='/admin/bbs/selectBbsFileList2.do'/>", param, bbsFileListCallBack);
		break;
		
	case "init":
		fncInit(formFileObj, gridObj);
		// 에디터 초기화
		formFileObj.find("[name=fileCont]").val("");
		fileEditors.getById["fileCont"].exec("LOAD_CONTENTS_FIELD");
		break;
	
	case "add":
		
		//doActionFile("reset");
		
		var seq = formObj.find("input[name=seq]").val();
		if(seq == ""){
			alert("상세정보를 먼저 등록해주세요");	return false; 
		}
		var rowCnt = gridObj.RowCount() + 1;

		if ( formFileObj.find("input[name=initFlag]").val() == "N" ) {
			alert("입력 초기화 후 추가해 주세요.");		return false;
		} 
		if ( formFileObj.find('input[id=file_'+rowCnt+']').val() == "" ) {
			alert("파일을 선택해 주세요."); 	return false;
		}
		
		if(nullCheckValdation(formFileObj.find('input[name=viewFileNm]'),"출력파일명","")){
			return false;
		}
		var row = gridObj.DataInsert(-1);
		var fileExt = getFileExt(formFileObj.find("input[id=saveFileNm_"+row+"]").val());
		if(fileExt.toLowerCase() == "do" || fileExt.toLowerCase() == "jsp" ||  fileExt.toLowerCase() == "ini" ||  fileExt.toLowerCase() == "java"){
			alert("첨부파일 확장자를 확인해주세요.");
			gridObj.RowDelete(row, 0);
		}
		if(extLimit == "BOTH"){
			var fileExt = getFileExt(formFileObj.find("input[id=saveFileNm_"+row+"]").val());
			if(fileExt.toLowerCase() == "jpg" || fileExt.toLowerCase() == "jpeg" ||  fileExt.toLowerCase() == "gif" || fileExt.toLowerCase() == "png"|| fileExt.toLowerCase() == "bmp"){
				gridObj.SetCellValue(row, "topYn", "Y");
			}else{
				gridObj.SetCellValue(row, "topYn", "N");
			}
			
			gridObj.SetCellValue(row, "fileExt", getFileExt(formFileObj.find("input[id=saveFileNm_"+row+"]").val()));  
			gridObj.SetCellValue(row, "bbsCd", bbsCd);
			gridObj.SetCellValue(row, "mstSeq", seq);
			gridObj.SetCellValue(row, "viewFileNm", formFileObj.find('input[name=viewFileNm]').val());
			gridObj.SetCellValue(row, "srcFileNm", formFileObj.find("input[id=saveFileNm_"+row+"]").val()); 
			
			var rowCnt = gridObj.GetSelectRow() + 1;
			var dup = 0;
			
			//통계간행물 수정
			if(bbsTypeCd == "G008"){ // 통계간행물일때 확장명처리
				var extArr = ["xls", "xlsx", "pdf", "zip", "hwp"];
				
				for(var i = 1 ; i < rowCnt ; i++){  
					if ( $.inArray(gridObj.GetCellValue(i, "fileExt").toLowerCase(), extArr) > -1 ) {
						dup ++;
					}
					
				}
				
			}else{ // 통계간행물아닐때 확장명처리
				for(var i = 1 ; i < rowCnt ; i++){  
					if(gridObj.GetCellValue(i, "fileExt").toLowerCase() == "jpg" || gridObj.GetCellValue(i, "fileExt").toLowerCase() == "jpeg" 
							|| gridObj.GetCellValue(i, "fileExt").toLowerCase() == "gif" || gridObj.GetCellValue(i, "fileExt").toLowerCase() == "png"
							|| gridObj.GetCellValue(i, "fileExt").toLowerCase() == "bmp"){
						dup ++;
					}
				}
				if(dup > 1){
					alert("이미지는 1개까지 등록가능합니다.");
					gridObj.RowDelete(row, 0);
				}
			}

		}else{
			gridObj.SetCellValue(row, "bbsCd", bbsCd);
			gridObj.SetCellValue(row, "mstSeq", seq);
			gridObj.SetCellValue(row, "viewFileNm", formFileObj.find('input[name=viewFileNm]').val());
			gridObj.SetCellValue(row, "srcFileNm", formFileObj.find("input[id=saveFileNm_"+row+"]").val()); 
			gridObj.SetCellValue(row, "fileExt", getFileExt(formFileObj.find("input[id=saveFileNm_"+row+"]").val()));
		}
		
		if(extLimit == "BOTH"){
			var rowCnt = gridObj.RowCount();
			var dup = 0;
			
			//통계간행물 수정
			if(bbsTypeCd == "G008"){ // 통계간행물일때 확장명처리
				var extArr = ["xls", "xlsx", "pdf", "zip", "hwp"];
				
				for(var i = 1 ; i < rowCnt ; i++){  
					if ( $.inArray(gridObj.GetCellValue(i, "fileExt").toLowerCase(), extArr) >-1 ) {
						dup ++;
					}
				}
			}else{ // 통계간행물아닐때 확장명처리
				for(var i = 1 ; i <= rowCnt ; i++){    
					if(gridObj.GetCellValue(i, "fileExt").toLowerCase() == "jpg" || gridObj.GetCellValue(i, "fileExt").toLowerCase() == "jpeg" 
							|| gridObj.GetCellValue(i, "fileExt").toLowerCase() == "gif" || gridObj.GetCellValue(i, "fileExt").toLowerCase() == "png"
								|| gridObj.GetCellValue(i, "fileExt").toLowerCase() == "bmp"){
						dup ++;
					}
				}
				if(dup == 0){
					alert("이미지를 등록해주세요.");
					return false;
				}
				
			}

		}
		
		fileEditors.getById["fileCont"].exec("UPDATE_CONTENTS_FIELD", []);
		
		gridObj.SetCellValue(gridObj.GetSelectRow(), "saveFileNm", formFileObj.find("input[name=viewFileNm]").val());
		gridObj.SetCellValue(gridObj.GetSelectRow(), "delYn", formFileObj.find("select[name=delYn]").val());
		gridObj.SetCellValue(gridObj.GetSelectRow(), "tmpFileCont", "tmp");
		
		ibsSaveJson = gridObj.GetSaveString();
		ibsSaveJson += "&tmpSeq="+gridObj.GetCellValue(1, "mstSeq");
		
		if( !gridObj.IsDataModified() ) {
			alert("저장할 내역이 없습니다.");
			//return;
		}
		var url = "<c:url value='/admin/bbs/saveBbsFile.do'/>";   
		//alert(ibsSaveJson);
		
		IBSpostJsonFile(formFileObj,url, fileSaveCallBack);

		break;
		
	case "save":
		if ( gridObj.RowCount() == 0 ) {
			alert("파일을 먼저 등록해 주세요.");
			return false;
		} 
		
		if(extLimit == "BOTH"){
// 			var rowCnt = gridObj.GetSelectRow() + 1;
			var rowCnt = gridObj.RowCount();
			var dup = 0;
			
			//통계간행물 수정
				
			if(bbsTypeCd == "G008"){ // 통계간행물일때 확장명처리 
				var extArr = ["xls", "xlsx", "pdf", "zip", "hwp"];
				
				for(var i = 1 ; i < rowCnt ; i++){  
					if ( $.inArray(gridObj.GetCellValue(i, "fileExt").toLowerCase(), extArr) >-1 ) {
						dup ++;
					}
				}
			}else{ // 통계간행물아닐때 확장명처리
				for(var i = 1 ; i <= rowCnt ; i++){    
					if(gridObj.GetCellValue(i, "fileExt").toLowerCase() == "jpg" || gridObj.GetCellValue(i, "fileExt").toLowerCase() == "jpeg" 
							|| gridObj.GetCellValue(i, "fileExt").toLowerCase() == "gif" || gridObj.GetCellValue(i, "fileExt").toLowerCase() == "png"
								|| gridObj.GetCellValue(i, "fileExt").toLowerCase() == "bmp"){
						dup ++;
					}
				}
				if(dup == 0){
					alert("이미지를 등록해주세요.");
					return false;
				}
				
			}

		}
		
		// 에디터내용 업데이트
		fileEditors.getById["fileCont"].exec("UPDATE_CONTENTS_FIELD", []);
		
		// 수정했다고 표시
		gridObj.SetCellValue(gridObj.GetSelectRow(), "saveFileNm", formFileObj.find("input[name=viewFileNm]").val());
		gridObj.SetCellValue(gridObj.GetSelectRow(), "delYn", formFileObj.find("select[name=delYn]").val());
		gridObj.SetCellValue(gridObj.GetSelectRow(), "tmpFileCont", "tmp");
		
		ibsSaveJson = gridObj.GetSaveString();
		ibsSaveJson += "&tmpSeq="+gridObj.GetCellValue(1, "mstSeq");
		
		if( !gridObj.IsDataModified() ) {
			alert("저장할 내역이 없습니다.");
			//return;
		}
		var url = "<c:url value='/admin/bbs/saveBbsFile.do'/>";   
		//alert(ibsSaveJson);
		IBSpostJsonFile(formFileObj,url, fileSaveCallBack);
		break;
	
	case "delete":
		ibsSaveJson = gridObj.GetSaveJson(0);	
// 		if(ibsSaveJson.data.length == 0) return;
		if( !gridObj.IsDataModified() ) {
			alert("삭제할 내역이 없습니다.");
			return;
		}
		if ( !confirm("삭제 하시겠습니까? ") ) {
			return;
		}
		var url =  "<c:url value='/admin/bbs/deleteBbsFileList.do'/>";
		var param = "";
		IBSpostJson(url, param, ibsLinkcallback);
		break;
		
	case "reset":
		formFileObj.find("input[name=initFlag]").val("N");
		break;
	}
}

//파일수정 콜백함수
function fileSaveCallBack(res) {
    var objTab = getTabShowObj();//탭이 oepn된 객체가져옴
	var formFileObj = objTab.find("form[name=adminFileForm]");
	var result = res.RESULT.CODE;
    if(result == 0) {
    	alert(res.RESULT.MESSAGE);
    } else {
    	alert(res.RESULT.MESSAGE);
    }   
    doActionFile("search");		//조회
    doActionFile("search2");	//파일타입 넣기위해 조회.
    doActionFile("reset");		//초기화
    formFileObj.find("span[id=fileDiv]").html("");		//파일객체 초기화
	var appendResetF = "";
	appendResetF = "<span id='fileInfo'>신규등록할 경우 초기화 버튼을 눌러서 등록해주세요</span>";		
	formFileObj.find("span[id=fileDiv]").append(appendResetF);	// 문구 삽입
	formFileObj.find("input[name=viewFileNm]").val("");	//출력파일명 초기화
	// 에디터 초기화
	formFileObj.find("[name=fileCont]").val("");
	fileEditors.getById["fileCont"].exec("LOAD_CONTENTS_FIELD");
}


function mySheet_OnDblClick(row, col, value, cellx, celly) {
    if(row == 0) return;     
    tabEvent(row);                      
}  

function regUserFunction(tab){		// 등록callback
	var objTab = getTabShowObj();		//탭이 oepn된 객체가져옴
	var formObj = objTab.find("form[name=adminBbsList]");
	
	formObj.find("span[name=delView]").remove();
	formObj.find("input[name=ansTag]").val(ansTag);
	
}

var sheetTabCnt = 0;   
function tabEvent(row){	//탭 이벤트 실행                
	var title = mySheet.GetCellValue(row,"bbsTit");//탭 제목
	var id = mySheet.GetCellValue(row,"seq");//탭 id(유일해야함))     
	var objTab = getTabShowObj();		//탭이 oepn된 객체가져옴
	var formObj = objTab.find("form[name=adminBbsList]");
	var formFileObj = objTab.find("form[name=adminFileForm]");
	formObj.find("input[name=ansTag]").val(ansTag);
    openTab.SetTabData(mySheet.GetRowJson(row));//db data 조회시 조건 data
    var url = "<c:url value='/admin/bbs/selectBbsDtlList.do'/>"+"?ansTag="+ansTag; // Controller 호출 url
    var sheetYn = openTab.tabExits(id);
    openTab.addTab(id,title,url,tabCallBack); // 탭 추가 시작함
    if(!sheetYn){//탭이 있을 경우 IBSheet 로드 방지
    	var cnt = sheetTabCnt++;
	  	if(htmlYn == "Y"){
	  	//	if($("iframe").length == 0){
	 			dHtmlYn();
	  		//}
		}  
	   	if(atfileYn == "Y"){                           
	   		if(extLimit != "IMG"){  
	   			SheetCreate("FILESheet", cnt, "150", false);
	   			
	   			nhn.husky.EZCreator.createInIFrame({ 
	   				oAppRef: fileEditors, 
	   				elPlaceHolder: "fileCont",	// 에디터 적용할 textarea 이름
	   				sSkinURI: "/SmartEditor2/SmartEditor2Skin.html",
	   				fCreator: "createSEditor2" ,
	   				htParams : { 
	   					fOnBeforeUnload : function(){ 
	   						//alert("onbeforeunload call"); 
	   					}
	   				},
	   				formObj: "adminFileForm"	// form 이름
	   			});
	   		}
	   		
	   	}
	   	if(linkYn == "Y"){
		   	SheetCreate("URLSheet",cnt, "150", false);
	   	}
	   	if(infYn == "Y"){
		   	SheetCreate("INFSheet",cnt, "150", false);
	   	}  
	   	if(tblYn == "Y"){
		   	SheetCreate("TBLSheet",cnt, "200", false);
	   	} 
    }else{
    	buttonEventAdd();                      
    }
}

function SheetCreate(Type,SheetCnt, sheetHeight, newYn){       
	var SheetNm = Type+SheetCnt;
	$("div[name="+Type+"]").eq(1).attr("id","DIV_"+SheetNm);
	createIBSheet2(document.getElementById("DIV_"+SheetNm),SheetNm, "100%", sheetHeight+"px");               
	var sheetobj = window[SheetNm]; 
	var initFunction = window["init"+Type]; // fucntion이름 가변적 생성 Type맞게 호출 (if else 하려다 코딩하기 귀찮았음...)
	var objTab = getTabShowObj();		//탭이 oepn된 객체가져옴
	initFunction(sheetobj, SheetNm, newYn);   
 	if(Type == "FILESheet") {
 		window[SheetNm + "_OnDblClick"] =  onDblClick;	
 		window[SheetNm + "_OnClick"] =  fileSheetOnClick;
 	}
	
}
//파일 다운로드 시작
function onDblClick(Row,Col,Value,CellX,CellY) {
	var objTab = getTabShowObj();//탭이 oepn된 객체가져옴
	var formObj = objTab.find("form[name=adminBbsList]");
	var formFileObj = objTab.find("form[name=adminFileForm]");
	var sheetObj =formFileObj.find("input[name=fileSheetNm]").val();
	var gridObj = window[sheetObj];
	var mstSeq = gridObj.GetCellValue(Row,"mstSeq");
	var fileSeq = gridObj.GetCellValue(Row,"fileSeq");
	goDownload(mstSeq, fileSeq)
}

// 파일시트 클릭이벤트
function fileSheetOnClick(row, col, value) {
	var objTab = getTabShowObj();//탭이 oepn된 객체가져옴
	var formObj = objTab.find("form[name=adminBbsList]");
	var formFileObj = objTab.find("form[name=adminFileForm]");
	var sheetObj =formFileObj.find("input[name=fileSheetNm]").val();
	var gridObj = window[sheetObj];
	formFileObj.find("input[name=fileSeq]").val(gridObj.GetCellValue(row, "fileSeq"));

	// 클릭시 파일내용을 가져온다
	doAjax({
		url : "/admin/bbs/selectBbsFileList.do",
		params : formFileObj.serialize() + "&bbsCd="+formObj.find("input[name=bbsCd]").val() + "&seq=" + formObj.find("input[name=seq]").val(),
		callback : function(res) {
			var data = res.DATA;
			formFileObj.find("[name=fileCont]").val(data[0].fileCont);
			fileEditors.getById["fileCont"].exec("LOAD_CONTENTS_FIELD");
			formFileObj.find("[name=viewFileNm]").val(data[0].viewFileNm);
			formFileObj.find("[name=delYn]").val(data[0].delYn);

		}
	});
	
}

//function goDownload(mstSeq, saveFileNm) {
function goDownload(mstSeq, fileSeq) {
	var wName = "url";
	var wWidth = "300";
	var wHeight = "200";
	var wScroll ="no";
	var url = "/portal/bbs/${bbsCd}/downloadAttachFile.do?fileSeq="+fileSeq;
	OpenWindow(url, wName, wWidth, wHeight, wScroll);
	
}
//파일 다운로드 끝

function tabFunction(tab, json){
	var objTab = getTabShowObj();		//탭이 oepn된 객체가져옴
	var formObj = objTab.find("form[name=adminBbsList]");
	var formFileObj = objTab.find("form[name=adminFileList]");
	formObj.find("[name=ansTag]").val(ansTag);
	
	if(json.DATA != null){               
		$.each(json.DATA,function(key,state){ 
			if(key == "delYn"){
				tab.ContentObj.find("[name=checkDel]").val(state);
			}
			if(key == "ansStateNm"){
				if(state != "접수대기")
					tab.ContentObj.find("[name=a_aw]").remove();
			}else	if(key == "seq"){
				tab.ContentObj.find("[name=mstSeq]").val(state);
			}else	if(key == "listSubCd"){ 
				tab.ContentObj.find("[name=listSubCd]").val(state);
			}else if(key == "apprNm"){
				if(state == null){
					tab.ContentObj.find("[name=apprNm]").val("${sessionScope.loginVO.usrNm}");
				}
			}else if(key == "orgNm"){
				if(state != null){
// 					tab.ContentObj.find("[name=apprOrgNm]").val(state);
					tab.ContentObj.find("[name=orgNm]").val(state);
				}else{
// 					tab.ContentObj.find("[name=apprOrgNm]").val("${sessionScope.loginVO.orgNm}");
					tab.ContentObj.find("[name=orgNm]").val("${sessionScope.loginVO.orgNm}");
				}
			}else if(key == "orgCd"){
				if(state != null){
// 					tab.ContentObj.find("[name=apprOrgCd]").val(state);
					tab.ContentObj.find("[name=orgCd]").val(state);
				}else{
// 					tab.ContentObj.find("[name=apprOrgCd]").val("${sessionScope.loginVO.orgCd}");
					tab.ContentObj.find("[name=orgCd]").val("${sessionScope.loginVO.orgCd}");
				}
			}else if(key == "bbsCont"){
				var bbsCont = state;
				if(bbsCont == null) bbsCont = "";
// 				bbsCont = bbsCont.replace(/\&lt;/g,"<").replace(/\&gt;/g,">");
				tab.ContentObj.find("[name=bbsCont]").val(bbsCont);
			}else if(key == "popupYn" && state=="Y"){
				formObj.find(".popupYnTr").show();                   
			}
		}); 
	}
	
	var delYn = formObj.find("input[name=checkDel]").val();
	var formObj = objTab.find("form[name=adminBbsList]");
	var formLinkObj = objTab.find("form[name=adminLinkForm]");
	var formInfObj = objTab.find("form[name=adminInfForm]");
	var formAnsObj = objTab.find("form[name=adminAnsForm]");
	var formFileObj = objTab.find("form[name=adminFileForm]");
	var formImgObj = objTab.find("form[name=adminImgForm]");
	var formTblObj = objTab.find("form[name=adminTblForm]");
	if(delYn == 'Y'){
		formObj.find("a[name=a_modify]").remove();
		formLinkObj.find(".btn03").remove();
		formLinkObj.find(".btn01B").remove();
		formInfObj.find(".btn03").remove();
		formInfObj.find(".btn01B").remove();
		formAnsObj.find(".btn03").remove();
		formFileObj.find(".btn03").remove();
		formFileObj.find(".btn01B").remove();
		formImgObj.find(".btn03").remove();
		formImgObj.find(".btn01B").remove();
		formTblObj.find(".btn03").remove();
		formTblObj.find(".btn01B").remove();
	}
	
// 	if(htmlYn == "Y"){
// 		if($("iframe").length == 0){
// 			dHtmlYn();
// 		}
// 	}  
	
	var url = "<c:url value='/admin/bbs/bbsImgDetailView.do'/>";
	param = formObj.serialize();
	ajaxCall(url, param, bbsDtlCallBack);         
}

function bbsDtlCallBack(tab, json, res){
	var objTab = getTabShowObj();		//탭이 oepn된 객체가져옴
	var formObj = objTab.find("form[name=adminBbsList]");
	var formImgObj = objTab.find("form[name=adminImgForm]");
	var delUse = "N";
	if(formImgObj.find("a[name=a_reg]").length > 0){		// 신규등록일 경우..
		delUse = "Y";
	}
// 	var newYn = formImgObj.find("a[name=a_reg]").length;
//  var oldYn = formImgObj.find("a[name=a_modify]").length;   

	var append = "";
	formImgObj.find(".appendImg div").remove();
	
	append += "<div>";                 
	if ( tab.resultImg != null ) {
		for( var i =0; i<tab.resultImg.length ; i++){
			var param = "downCd=B&fileSeq="+tab.resultImg[i].fileSeq+"&seq="+tab.resultImg[i].mstSeq;
			append += "<div class='img-box'>";
			append += "<p><input type='hidden' name='delUse' value='"+delUse+"' /><input type='radio' name='top_yn' id='ceoImg"+i+"' value='"+tab.resultImg[i].fileSeq+"' /> <label for='ceoImg"+i+"'>대표이미지</label></p>";
			append += "<p><img src=\"<c:url value='/portal/bbs/fileDownload.do?"+param+"'/>\" alt='"+tab.resultImg[i].viewFileNm+"' width='120' height='120'/></p>";
			append += "<p><input type='checkbox' name='del_yn' id='del"+i+"' value='"+tab.resultImg[i].fileSeq+"' onclick=\"javascript:checkDel('"+delUse+"', '"+tab.resultImg[i].fileSeq+"', '"+i+"');\" /> <label for='del"+i+"'>삭제</label></p>";
			append += "</div> ";
		}
	}
	append += "</div>"; 
	formImgObj.find(".appendImg").append(append);
	formImgObj.find("input[name=delYn0]").val('0');
	formImgObj.find("input[name=delYn1]").val('0');
	formImgObj.find("input[name=delYn2]").val('0');
	formImgObj.find("input[name=delYn3]").val('0');
	formImgObj.find("input[name=delYn4]").val('0');
	formImgObj.find("input[name=delYn5]").val('0');
	formImgObj.find("input[name=delYn6]").val('0');
	formImgObj.find("input[name=delYn7]").val('0');
	formImgObj.find("input[name=delYnVal]").val('0');
	
	if(tab.resultTopYn.length > 0){	//대표이미지 표시
		formImgObj.find("[name=top_yn]:radio[value='"+tab.resultTopYn[0].fileSeq+"']").prop("checked",true);   
		formImgObj.find("input[name=topYnSeq]").val(tab.resultTopYn[0].fileSeq);
	}else{
		formImgObj.find("input[name=topYnSeq]").val('0');
	}
	
 	formImgObj.find("input[name=top_yn]").click(function(){		// 대표이미지 선택
 		var topYnVal = formImgObj.find("input:radio[name=top_yn]:checked").val();
 		formImgObj.find("input[name=topYnSeq]").val(topYnVal);
	});
 	
	
}

function checkDel(delUse, fileSeq, seq){
	var objTab = getTabShowObj();		//탭이 oepn된 객체가져옴
	var formObj = objTab.find("form[name=adminBbsList]");
	var formImgObj = objTab.find("form[name=adminImgForm]");
	
	if(delUse == "Y"){
 		formImgObj.find("input[name=delYnVal]").val(fileSeq);
 		var url = "<c:url value='/admin/bbs/deleteImg.do'/>"; 
		var param = formObj.serialize();
			param += formImgObj.serialize();
		ajaxCallAdmin(url, param, imgDeleteCallBack2);
	}else{
		if(formImgObj.find("input:checkbox[id=del"+seq+"]").is(":checked") == true){
			formImgObj.find("input[name=delYn"+seq+"]").val(fileSeq);
		}else{
			formImgObj.find("input[name=delYn"+seq+"]").val('0');
		}
	}
	
	
}

function imgDeleteCallBack2(res){
	var objTab = getTabShowObj();//탭이 oepn된 객체가져옴
	var formObj = objTab.find("form[name=adminBbsList]");
	var url = "<c:url value='/admin/bbs/bbsImgDetailView.do'/>";
	param = formObj.serialize();
	ajaxCall(url, param, bbsDtlCallBack);  
}

function imgDeleteCallBack(res){
// 	 var result = res.RESULT.CODE;
// 	alert(res.RESULT.CODE);
	if(res.RESULT.CODE == 0){
		alert("<spring:message code='MSG.SAVE'/>");
	}else{
		alert("<spring:message code='ERR.SAVE'/>");
	}
	
	var objTab = getTabShowObj();//탭이 oepn된 객체가져옴
	var formObj = objTab.find("form[name=adminBbsList]");
	var url = "<c:url value='/admin/bbs/bbsImgDetailView.do'/>";
	param = formObj.serialize();
	ajaxCall(url, param, bbsDtlCallBack);  
}

function initURLSheet(sheetobj, SheetNm, newYn){
	setUrlButton();
	var objTab = getTabShowObj();		//탭이 oepn된 객체가져옴
	var formObj = objTab.find("form[name=adminLinkForm]");
	if(formObj.find("input[name=linkSheetNm]").val() ==""){
		formObj.find("input[name=linkSheetNm]").val(SheetNm);    
	}
	LoadUrlPage(sheetobj, newYn);
}

function initINFSheet(sheetobj, SheetNm, newYn){
	setInfButton();
	var objTab = getTabShowObj();//탭이 oepn된 객체가져옴
	var formObj = objTab.find("form[name=adminInfForm]");
	if(formObj.find("input[name=infSheetNm]").val() ==""){
		formObj.find("input[name=infSheetNm]").val(SheetNm);    
	}
	LoadInfPage(sheetobj, newYn);
}

// 2018.04.26/softon
function initTBLSheet(sheetobj, SheetNm, newYn){
	setTblButton();
	var objTab = getTabShowObj();//탭이 oepn된 객체가져옴
	var formObj = objTab.find("form[name=adminTblForm]");
	if(formObj.find("input[name=tblSheetNm]").val() ==""){
		formObj.find("input[name=tblSheetNm]").val(SheetNm);    
	}
	
	LoadTblPage(sheetobj, newYn);
}

function initFILESheet(sheetobj, SheetNm, newYn){
	setFileButton();
	var objTab = getTabShowObj();
	var formObj = objTab.find("form[name=adminFileForm]");
	if(formObj.find("input[name=fileSheetNm]").val() == ""){
		formObj.find("input[name=fileSheetNm]").val(SheetNm);
	}
	formObj.find("input[name=initFlag]").val("N"); 	//파일 초기화 최초 세팅
	LoadFilePage(sheetobj, newYn);
}

function initFILESheet2(sheetobj, SheetNm, newYn){
	setFileButton();
	var objTab = getTabShowObj();
	var formObj = objTab.find("form[name=adminFileForm2]");
	if(formObj.find("input[name=fileSheetNm2]").val() == ""){
		formObj.find("input[name=fileSheetNm2]").val(SheetNm);
	}
	formObj.find("input[name=initFlag]").val("N"); 	//파일 초기화 최초 세팅
	LoadFilePage2(sheetobj, newYn);
}

//파일객체 동적 생성
function bbsFileListCallBack(tab, json, res) {
	var objTab = getTabShowObj();
	var formObj = objTab.find("form[name=adminFileForm]");
	if(json.DATA != null){               
		$.each(json.DATA,function(key,state){ 
// 			alert(key);
// 			if(key == "mstSeq"){
// 				alert(state);
// 				tab.ContentObj.find("[name=mstSeq]").val(state);
// 			}
		}); 
	} 
	var appendFile = "";
	
	formObj.find("div[id=fileDivIn]").remove();
	
	appendFile = "<div id='fileDivIn'>";
	if ( tab.length == 0 ) {	//데이터가 없을경우(신규등록)
// 		appendFile = "<span id='fileInfo'>신규등록할 경우 초기화 버튼을 눌러서 등록해주세요</span>";
	} else {
		for (var i=0; i < tab.length; i++) {
			appendFile += "<input type='text' name='fileStatus' id='fileStatus_"+(i+1)+"' value='U' style='display:none;' readonly/>";
			appendFile += "<input type='text' name='saveFileNm' id='saveFileNm_"+(i+1)+"' style='display:none; width:200px;' value='"+tab[i].saveFileNm+"' readonly>";
			appendFile += "<input type='file' name='file' id='file_"+(i+1)+"' onchange='fncFileChange("+(i+1)+");' style='display:none; width:80px; color:#fff'/>";
// 			appendFile += "<input type='text' name='arrFileSeq' id='arrFileSeq_"+(i+1)+"' value='"+ tab[i].arrFileSeq +"' style='display:none; '/>";
		}
	}
	appendFile += "</div id='fileDivIn'>";
	formObj.find("span[id=fileDiv]").append(appendFile);
}

//파일선택시
function fncFileChange(fileId) {
	var objTab = getTabShowObj();
	var formObj = objTab.find("form[name=adminFileForm]");
	sheetObj =formObj.find("input[name=fileSheetNm]").val();  
 	var gridObj = window[sheetObj];
	val = formObj.find("input[id=file_"+fileId+"]").val().split("\\");
	fileName = val[val.length-1];
	f_name = fileName.substring(0, fileName.indexOf("."));
	s_name = fileName.substring(fileName.length-3, fileName.length);
	formObj.find("input[id=saveFileNm_"+fileId+"]").val(fileName);
	gridObj.SetCellValue(fileId, "srcFileNm", fileName);
	gridObj.SetCellValue(fileId, "viewFileNm", f_name);
	gridObj.SetCellValue(fileId, "fileExt", s_name);
}

//초기화 버튼 클릭시
function fncInit(formObj, gridObj) {
// 	alert(typeof(gridObj));
// 	alert(extLimit);
	var currRow = gridObj.GetSelectRow();
	var rowCnt = gridObj.RowCount() + 1;
// 	alert("currRow:"+currRow+", rowCnt:"+rowCnt);
	var appendFile = "";
 	if ( formObj.find("input[name=initFlag]").val() == "Y" ) {
		//alert("이미 초기화 하였습니다.");		
		return;
	} 
	//값 초기화
	formObj.find("input[name=viewFileNm]").val("");
	formObj.find("input[name=initFlag]").val("Y");		//초기화하였음.
	//현재파일객체 숨김
	formObj.find("input[id=saveFileNm_"+currRow+"]").hide();
	formObj.find("input[id=file_"+currRow+"]").hide();
	//빈 파일객체 현재 순서ID로 추가..
	appendFile += "<input type='text' name='fileStatus' id='fileStatus_" + rowCnt + "' value='C' style='display:none;' readonly/>";
			appendFile += "<input type='text' name='saveFileNm' id='saveFileNm_"+rowCnt+"' style='display:none; width:200px;' value='' readonly>";
			appendFile += "<input type='file' name='file' id='file_"+rowCnt+"' onchange='fncFileChange("+rowCnt+");' style='display:none; width:80px; color:#fff'/>";
	formObj.find("span[id=fileDiv]").find("span[id=fileInfo]").remove();	// 문구 삭제
//  	formObj.find("button[name=btn_init]").remove();	// 초기화 버튼 삭제
	formObj.find("span[id=fileDiv]").append(appendFile);
	//파일객체 추가하고 보여준다
// 	alert(formObj.find("input[id=saveFileNm_"+rowCnt+"]").length);
	if(formObj.find("input[id=saveFileNm_"+rowCnt+"]").length == 1){
		formObj.find("input[id=saveFileNm_"+rowCnt+"]").show();
		formObj.find("input[id=file_"+rowCnt+"]").show();
	}else{
		formObj.find("input[id=saveFileNm_"+rowCnt+"]").val("");
	}
}

function doActionImg(sAction){
	var classObj = $("."+tabContentClass); //tab으로 인하여 form이 다건임
	var actObj = setTabForm2(classObj,"adminBbsList"); // 0: form data, 1: form 객체
	var sheetObj; //IbSheet 객체         
	var param = actObj[0]  ;  
	var objTab = getTabShowObj();//탭이 oepn된 객체가져옴
	var formObj = objTab.find("form[name=adminBbsList]");
	var formImgObj = objTab.find("form[name=adminImgForm]");
	ajaxBeforeSendAdmin("<c:url value='/admin/ajaxBeforeSendAdmin.do'/>"); //IbSheet 조회전 세션 체크
	
	switch(sAction){
		case "init":
			fncInit2(formImgObj);
			break;
		
		case "add":
			var seq = formObj.find("input[name=seq]").val();
			if ( formImgObj.find("input[name=initFlag]").val() == "" ) { 
				alert("초기화 버튼을 눌러주세요.");		return;
			}
			if(seq == ""){
				alert("상세정보를 먼저 등록해주세요");	return false; 
			}
			if ( formImgObj.find('input[id=file]').val() == "" ) {
				alert("파일을 선택해 주세요."); 	return false;
			}
			if(nullCheckValdation(formImgObj.find('input[name=viewFileNm]'),"출력파일명","")){
				return false;
			}
			var listSubCd = formObj.find("select[name=listSubCd]").val();
			var imgLen = formImgObj.find(".img-box").length;
			if(listSubCd != undefined && listSubCd != "undefined"){
				if(listSubCd == "APP"){
					if(imgLen > 4){
						alert("대표이미지 1개를 포함해 총 5개까지 등록 가능합니다."); 
						return false;
					}
				}else{
					if(imgLen > 4){
						alert("대표이미지 1개를 포함해 총 5개까지 등록 가능합니다.");
						return false;
					}
				}
			}
			formImgObj.find("input[name=mstSeq]").val(seq);
			var srcFileNm = formImgObj.find("input[id=saveFileNm]").val();
			var fileExt = getFileExt(formImgObj.find("input[id=saveFileNm]").val());
			
			if(fileExt.toLowerCase() != "jpg" && fileExt.toLowerCase() != "jpeg" && fileExt.toLowerCase() != "gif" && fileExt.toLowerCase() != "png"){
				alert("이미지 파일[jpg/jpeg, gif, png]만 첨부가능 합니다.");
		        return false;
			}

 			ibsSaveJson = formImgObj.serialize(); 
 			ibsSaveJson += "&srcFileNm="+srcFileNm+"&fileExt="+fileExt+"&bbsCd="+bbsCd+"&delYn=N&status=I&fileSize=";
//  			alert(ibsSaveJson);    
			var url = "<c:url value='/admin/bbs/saveBbsFile.do'/>";                
			IBSpostJsonFile(formImgObj,url, fileSaveCallBack2);
			
			break;
			
		case "save":
			if(formImgObj.find("input[name=top_yn]").is(":checked") == false){
				alert("대표이미지를 지정해주세요.");
				return false;
			}
			var url = "<c:url value='/admin/bbs/updateTopYn.do'/>"; 
			var param = formObj.serialize();
				param += formImgObj.serialize();
			ajaxCallAdmin(url, param, ibsLinkcallback);
			break;
		
		case "modify":
		 	if ( !confirm("수정 하시겠습니까? ") ) {
				return;
  			}
			if(formImgObj.find("input[name=top_yn]").is(":checked") == false){
				alert("대표이미지를 지정해주세요.");
				return false;
			}
			var url = "<c:url value='/admin/bbs/updateDeleteImg.do'/>"; 
			var param = formObj.serialize();
				param += formImgObj.serialize();
// 				alert(param);
			ajaxCallAdmin(url, param, imgDeleteCallBack);
			break;
		
		case "delete":
 			if ( !confirm("삭제 하시겠습니까? ") ) {
				return;
  			}
 			if(formImgObj.find("input:checkbox[name=del_yn]").is(":checked") == false){
 				alert("삭제할 이미지를 선택해주세요."); 
 				return false;
 			}
			var url = "<c:url value='/admin/bbs/deleteImgDtl.do'/>"; 
			var param = formObj.serialize();
				param += formImgObj.serialize();
// 				alert(param);
			ajaxCallAdmin(url, param, imgDeleteCallBack);
			break;
	}
}

function fileSaveCallBack2(res) {		// 이미지 미리보기 추가 콜백
	var objTab = getTabShowObj();//탭이 oepn된 객체가져옴
	var formObj = objTab.find("form[name=adminBbsList]");
	var url = "<c:url value='/admin/bbs/bbsImgDetailView.do'/>";
	param = formObj.serialize();
	ajaxCall(url, param, bbsDtlCallBack);       
	
}


//초기화 버튼 클릭시
function fncInit2(formObj) {
// 	alert(typeof(gridObj));
	var appendFile = "";
/* 	if ( formObj.find("input[name=initFlag]").val() == "Y" ) {
		alert("이미 초기화 하였습니다.");		return;
	} */
	//값 초기화
	formObj.find("input[name=viewFileNm]").val("");
	formObj.find("input[name=initFlag]").val("Y");		//초기화하였음.
	//현재파일객체 숨김
	formObj.find("input[id=saveFileNm]").hide();
	formObj.find("input[id=file]").hide();
	//빈 파일객체 현재 순서ID로 추가..
	appendFile += "<input type='text' name='fileStatus' id='fileStatus' value='C' style='display:none;' readonly/>";
			appendFile += "<input type='text' name='saveFileNm' id='saveFileNm' style='display:none; width:200px;' value='' readonly>";
			appendFile += "<input type='file' name='file' id='file' onchange='fncFileChange2();' style='display:none; width:80px; color:#fff'/>";
	formObj.find("span[id=fileImgDiv]").find("span[id=fileImgInfo]").remove();	// 문구 삭제
	formObj.find("button[name=btn_init]").remove();	// 초기화 버튼 삭제
	formObj.find("span[id=fileImgDiv]").append(appendFile);
	//파일객체 추가하고 보여준다
	formObj.find("input[id=saveFileNm]").show();
	formObj.find("input[id=file]").show();
}

//파일선택시
function fncFileChange2() {
	var objTab = getTabShowObj();
	var formObj = objTab.find("form[name=adminImgForm]");
	val = formObj.find("input[id=file]").val().split("\\");
	fileName = val[val.length-1];
	f_name = fileName.substring(0, fileName.indexOf("."));
	s_name = fileName.substring(fileName.length-3, fileName.length);
	formObj.find("input[id=saveFileNm]").val(fileName);
// 	alert("fileName==>"+fileName+" , f_name==>"+f_name+" , s_name==>"+s_name);
}


function setTabButton(){		//버튼event
	var objTab = getTabShowObj();//탭이 oepn된 객체가져옴
 	var formObj = objTab.find("form[name=adminBbsList]");     
	var formAnsObj = objTab.find("form[name=adminAnsForm]");
	var formImgObj = objTab.find("form[name=adminImgForm]");

 	formObj.find("a[name=a_reg]").click(function() {		// 신규등록
 		doTabAction("save");          
 		return false;                 
 	});
 	formObj.find("a[name=a_modify]").click(function() {		// 수정
 		doTabAction("update");          
 		return false;                 
 	});
 	formObj.find("a[name=a_del]").click(function() {		// 삭제
 		doTabAction("delete");          
 		return false;                 
 	});
 	formAnsObj.find("a[name=a_aw]").click(function(){
 		doTabAction("AW");
		return false;
	});
 	formAnsObj.find("a[name=a_ak]").click(function(){
 		doTabAction("AK");
 		return false;
 	});
 	formAnsObj.find("a[name=a_view]").click(function(){
 		doTabAction("previewPop");
 		return false;
 	});
 	formAnsObj.find("a[name=a_ac]").click(function(){
 		doTabAction("AC");
 		return false;
 	});
 	
 	formImgObj.find("button[name=btn_init]").click(function(){		//신규등록시 초기화
		doActionImg("init");  
		return false;		
	});
 	formImgObj.find("button[name=btn_add]").click(function(){		//이미지 추가
		doActionImg("add");  
		return false;		
	});
 	formImgObj.find("a[name=a_reg]").click(function(){		//첨부이미지 등록
		doActionImg("save");  
		return false;		
	});
 	formImgObj.find("a[name=a_modify]").click(function(){		//첨부이미지 수정
		doActionImg("modify");  
		return false;		
	});
 	formImgObj.find("a[name=a_del]").click(function(){		//첨부이미지 삭제
		doActionImg("delete");  
		return false;		
	});
 	
 	
//  	formObj.find("input[name=userTel]").keyup(function(e) {                     
//  		ComInputNumDecObj(formObj.find("input[name=userTel]"));    
//  		return false;                                                                          
//  	});
 	
 	formObj.find("input[name=tel2]").keyup(function(e) {                     
 		ComInputNumObj(formObj.find("input[name=tel2]"));    
 		return false;                                                                          
 	});
 	formObj.find("input[name=tel3]").keyup(function(e) {                     
 		ComInputNumObj(formObj.find("input[name=tel3]"));    
 		return false;                                                                          
 	}); 
 	
 	formObj.find("input[name=email1]").keyup(function(e) {                     
 		ComInputEmailObj(formObj.find("input[name=email1]"));    
 		return false;                                                                          
 	});
 	formObj.find("input[name=email2]").keyup(function(e) {                     
 		ComInputEmailObj(formObj.find("input[name=email2]"));    
 		return false;                                                                          
 	});
 	
 	formObj.find("select[name=email3]").change(function(){		//email 선택 변경 시
		var eValue = formObj.find("select[name=email3]").val();
		if(eValue == "na"){
			formObj.find("input[name=email2]").val('');
			formObj.find("input[name=email2]").focus();
		}else{
			formObj.find("input[name=email2]").val(eValue);
		}
	});
 	
 	
 	//팝업여부 체크시
 	formObj.find("input[name=popupYn]").change(function(e) { //더미
		if(formObj.find("input[name=popupYn]").is(":checked") ==true){ 
			formObj.find(".popupYnTr").show();
		}else{
			formObj.find(".popupYnTr").hide();     
			formObj.find("input[name=weightSize]").val(""); 
			formObj.find("input[name=heightSize]").val("");
			formObj.find("input[name=popupStartDate]").val("");
			formObj.find("select[name=popupStartHh]").val("");
			formObj.find("select[name=popupStartMi]").val("");
			formObj.find("input[name=popupEndDate]").val("");
			formObj.find("select[name=popupEndHh]").val("");
			formObj.find("select[name=popupEndMi]").val("");             
		}      
	 });
 	
 	formObj.find("input[name=popupStartDate]").datepicker(setCalendar());          
	formObj.find("input[name=popupEndDate]").datepicker(setCalendar());          
	datepickerTrigger();                
	formObj.find("button[name=btn_dttm]").click(function(e) { 
		formObj.find("input[name=popupStartDate]").val("");
		formObj.find("input[name=popupEndDate]").val("");
	 });
	
	formObj.find("input[name=weightSize]").keyup(function(e) {                     
 		ComInputNumObj(formObj.find("input[name=weightSize]"));    
 		return false;                                                                          
 	}); 
	formObj.find("input[name=heightSize]").keyup(function(e) {                     
 		ComInputNumObj(formObj.find("input[name=heightSize]"));    
 		return false;                                                                          
 	}); 
}              

function setUrlButton(){	//	URL연결 버튼event
	var objTab = getTabShowObj();		//탭이 oepn된 객체가져옴
	var formObj = objTab.find("form[name=adminLinkForm]");
	
	formObj.find("button[name=btn_add]").click(function(){			//URL 추가
		doActionUrl("add");
		return false;
	});
	formObj.find("a[name=a_reg]").click(function(){		//URL 저장
		doActionUrl("save");
		return false;		
	});
	formObj.find("a[name=a_modify]").click(function(){		//URL 수정
		doActionUrl("save");
		return false;		
	});
	formObj.find("a[name=a_del]").click(function(){		//URL 삭제
		doActionUrl("delete");
		return false;		
	});
}

function setInfButton(){
	var objTab = getTabShowObj();//탭이 oepn된 객체가져옴
	var formObj = objTab.find("form[name=adminInfForm]");
	
	formObj.find("button[name=btn_infSearch]").click(function(){
		doActionInf("infPop");
		return false;
	});
	formObj.find("button[name=btn_add]").click(function(){		//공공데이터 추가
		doActionInf("add");
		return false;
	});
	formObj.find("a[name=a_reg]").click(function(){		// 공공데이터 저장
		doActionInf("save");
		return false;
	});
	formObj.find("a[name=a_modify]").click(function(){		//공공데이터 수정
		doActionInf("save");
		return false;		
	});
	formObj.find("a[name=a_del]").click(function(){		//공공데이터 삭제
		doActionInf("delete");
		return false;		
	});
}

/**
 * 2018.04.26/softon - 통계표 연결 버튼 이벤트 추가
 */
function setTblButton(){
	var objTab = getTabShowObj();//탭이 oepn된 객체가져옴
	var formObj = objTab.find("form[name=adminTblForm]");
	
	formObj.find("button[name=tblAdd]").click(function(){
		doActionTbl("tblPop");
		return false;
	});
	formObj.find("a[name=a_modify]").click(function(){		//통계표연결수정
		doActionTbl("save");
		return false;		
	});
	
	formObj.find("a[name=a_del]").click(function(){			//통계표연결삭제
		doActionTbl("delete");
		return false;		
	});

}

function setFileButton(){
	var objTab = getTabShowObj();//탭이 oepn된 객체가져옴
	var formObj = objTab.find("form[name=adminFileForm]");
	
	formObj.find("button[name=btn_init]").click(function(){		//신규등록시 초기화
		doActionFile("init") ;  
		return false;		
	});
	formObj.find("button[name=btn_add]").click(function(){
		doActionFile("add");
		return false;
	});
	formObj.find("a[name=a_reg]").click(function(){		// 파일 저장
		doActionFile("save");
		return false;
	});
	formObj.find("a[name=a_modify]").click(function(){		//파일 수정
		doActionFile("save");
		return false;		
	});
	formObj.find("a[name=a_del]").click(function(){		//파일 삭제
		doActionFile("delete");
		return false;		
	});
}

function saveCheck(formObj){
	
	if(formObj.find("input[name=bbsTit]").val() == ""){
		alert("제목을 입력해주세요.");
		formObj.find("input[name=bbsTit]").focus();
		return false;
	}
	if(emailNeedYn == "Y"){
		if(formObj.find("input[name=userEmail]").val() == ""){
			alert("이메일을 입력해주세요");
			formObj.find("input[name=userEmail]").focus();
			return false;
		}
	}
	if(telNeedYn == "Y"){
		if(formObj.find("input[name=userTel]").val() == ""){
			alert("연락처를 입력해주세요");
			formObj.find("input[name=userTel]").focus();
			return false;
		}
	}
	if(htmlYn == "Y"){
		oEditors.getById["bbsCont"].exec("UPDATE_CONTENTS_FIELD", []);  
	}
	
	// LIST_SUB_CD 필수값 체크 [시작]
	if ( formObj.find("select[name=listSubCd]").length > 0 ) {
		var listSubCd = formObj.find("select[name=listSubCd]");
		if ( listSubCd.val() == "" ) {
			alert(listSubCd.find("[value='']").text() + "하세요.");
			listSubCd.focus();
			return false;
		}
	}
	if ( formObj.find("select[name=list1SubCd]").length > 0 ) {
		var list1SubCd = formObj.find("select[name=list1SubCd]");
		if ( list1SubCd.val() == "" ) {
			alert(list1SubCd.find("[value='']").text() + "하세요.");
			list1SubCd.focus();
			return false;
		}
	}
	if ( formObj.find("select[name=list2SubCd]").length > 0 ) {
		var list2SubCd = formObj.find("select[name=list2SubCd]");
		if ( list2SubCd.val() == "" ) {
			alert(list2SubCd.find("[value='']").text() + "하세요.");
			list2SubCd.focus();
			return false;
		}
	}
	if ( formObj.find("select[name=list3SubCd]").length > 0 ) {
		var list3SubCd = formObj.find("select[name=list3SubCd]");
		if ( list3SubCd.val() == "" ) {
			alert(list3SubCd.find("[value='']").text() + "하세요.");
			list3SubCd.focus();
			return false;
		}
	}
	if ( formObj.find("select[name=list4SubCd]").length > 0 ) {
		var list4SubCd = formObj.find("select[name=list4SubCd]");
		if ( list4SubCd.val() == "" ) {
			alert(list4SubCd.find("[value='']").text() + "하세요.");
			list4SubCd.focus();
			return false;
		}
	}
	// LIST_SUB_CD 필수값 체크 [종료]
	
	//팝업이 체크되어있으면
	if(formObj.find("input[name=popupYn]").is(":checked") ==true){ 
		if(formObj.find("input[name=weightSize]").val() == ""){
			alert("팝업사이즈 가로를 입력하세요.");
			formObj.find("input[name=weightSize]").focus();
			return false;                       
		}
		if(formObj.find("input[name=heightSize]").val() == ""){
			alert("팝업사이즈 세로를 입력하세요.");
			formObj.find("input[name=heightSize]").focus();
			return false;
		}
		if(formObj.find("input[name=popupStartDate]").val() == ""){
			alert("팝업일시를 선택하세요.");
			formObj.find("input[name=popupStartDate]").focus();
			return false;
		}
		if(formObj.find("select[name=popupStartHh]").val() == ""){
			alert("팝업일시를 선택하세요.");
			formObj.find("select[name=popupStartHh]").focus();
			return false;
		}
		if(formObj.find("select[name=popupStartMi]").val() == ""){
			alert("팝업일시를 선택하세요.");
			formObj.find("select[name=popupStartMi]").focus();
			return false;
		}
		
		if(formObj.find("input[name=popupEndDate]").val() == ""){
			alert("팝업일시를 선택하세요.");
			formObj.find("input[name=popupEndDate]").focus();
			return false;
		}
		
		if(formObj.find("select[name=popupEndHh]").val() == ""){
			alert("팝업일시를 선택하세요.");
			formObj.find("select[name=popupEndHh]").focus();
			return false;
		}
		
		if(formObj.find("select[name=popupEndMi]").val() == ""){
			alert("팝업일시를 선택하세요.");
			formObj.find("select[name=popupEndMi]").focus();
			return false;
		}
		//일시 체크
	} 
	return true;
}

//마우스 이벤트
function mySheet_OnSearchEnd(code, msg)
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

function setDatePickerCalendar() {
	var calendar = {
		monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
		dayNamesMin: ['일','월','화','수','목','금','토'],
		weekHeader: 'Wk',
		dateFormat: 'yy-mm-dd', //형식(20120303)
		autoSize: false, //오토리사이즈(body등 상위태그의 설정에 따른다)
		changeMonth: true, //월변경가능
		changeYear: true, //년변경가능
		showMonthAfterYear: true, //년 뒤에 월 표시
		buttonImageOnly: true, //이미지표시
		buttonText: '달력선택', //버튼 텍스트 표시
		buttonImage: "../../../../images/admin/icon_calendar.png", //이미지주소                                              
		showOn: "both", //엘리먼트와 이미지 동시 사용(both,button)                 
		yearRange: '1900:2100', //1990년부터 2020년까지
		showButtonPanel: true, 
		closeText: 'close'
	};
	return calendar;
}
</script>
</head>      
<body onload="">
<div class="wrap">
	<c:import  url="/admin/admintop.do"/>
	<!--##  메인  ##-->
	<div class="container">
		<!-- 상단 타이틀 -->   
		<div class="title">
			<c:choose>
		    <c:when test="${bbsCd eq 'GALLERY'}">
				<c:choose>
				<c:when test="${bbsCdz eq 'N'}">
					<h2>활용사례 관리</h2>                                      
					<p>활용통계 > 참여형 플랫폼▶ > 활용사례 관리</p>      
				</c:when>
				<c:otherwise>
					<h2>활용사례 현황</h2>                                      
					<p>활용통계 > 참여형 플랫폼▶ > 활용사례 현황</p>       
		    	</c:otherwise>
				</c:choose>
		    </c:when>
		    <c:otherwise>
				<h2>${MENU_NM}</h2>                                      
				<p>${MENU_URL}</p>  
		    </c:otherwise>
		    </c:choose>
		</div>
		<!-- 탭 -->
		<ul class="tab">
			<li class="all_list"><a href="#">전체목록</a></li>
		</ul>
		<div class="more_list" style="display:none">
			<a href="#" class="more">0</a>                
			<ul class="other_list" style="display:none;">
				<li><a href="#">보유데이터목록</a><a href="#" class="line_close">x</a></li>
				<li><a href="#">공공데이터목록asdfsdfsfsdfsdfsdf</a><a href="#" class="line_close">x</a></li>
			</ul>
		</div>
		<!-- 탭 내용 --> 
		<c:forEach var="result" items="${result}" >
		<div class="content" style="display:none">
		<form name="adminBbsList"  method="post" action="#">
		<input type="hidden" name="bbsCd" value="${bbsCd }"/>
		<input type="hidden" name="ansTag"/>
		<input type="hidden" name="seq"/>
		<input type="hidden" name="checkDel"/>
		<table class="list01" style="position:relative;">
			<caption>게시판</caption>
			<colgroup>
				<col width="150"/>
				<col width=""/>
			</colgroup>
			<tr>
				<th><label class=""><spring:message code="labal.bbsTit"/></label><span> *</span></th>
				<td>
					<input type="text" name="bbsTit"	size="70"/>
					<c:if test="${result.noticeYn eq 'Y'}">
					<input type="checkbox" name="noticeYn" value="Y"/> <label class=""><spring:message code="labal.noticeYn"/></label>
					</c:if>
					<c:if test="${result.secretYn eq 'Y'}">
					<input type="checkbox" name="secretYn" value="Y"/> <label class=""><spring:message code="labal.secretYn1"/></label>
					</c:if>
					<c:if test="${bbsCd eq 'NOTICE'}">                         
					<input type="checkbox" name="popupYn" value="Y"/> <label class="">팝업여부</label>
					</c:if>
				</td>  
			</tr>
			
			<tr style="display:none" class="popupYnTr">                      
				<th><label class="">팝업사이즈</label></th>
				<td>
					(가로)
					<input type="text" name="weightSize"	size="4" maxlength="4"/>
					(세로)
					<input type="text" name="heightSize"	size="4" maxlength="4"/>
				</td>  
			</tr>
			
			<tr style="display:none" class="popupYnTr">              
				<th><label class="">팝업일시</label></th>
				<td>
					<input type="text" name="popupStartDate"	size="10" maxlength="10" readonly="readonly"/>
					<select name="popupStartHh">
						<option value="">선택</option>
						<c:forEach begin="0" end="23" step="1" varStatus="status">
								<c:if test="${status.index > 9}">     
										<option value="${status.index }">${status.index }</option>
								</c:if>
								<c:if test="${status.index < 10}">     
										<option value="0${status.index }">0${status.index }</option>
								</c:if> 
						</c:forEach>
					</select>
					:
					<select name="popupStartMi">
						<option value="">선택</option>
						<c:forEach begin="0" end="59" step="1" varStatus="status">
								<c:if test="${status.index > 9}">     
										<option value="${status.index }">${status.index }</option>
								</c:if>
								<c:if test="${status.index < 10}">     
										<option value="0${status.index }">0${status.index }</option>
								</c:if> 
						</c:forEach>
					</select>
					 ~
					<input type="text" name="popupEndDate"	size="10" maxlength="10" readonly="readonly"/>
					<select name="popupEndHh">
						<option value="">선택</option>
						<c:forEach begin="1" end="23" step="1" varStatus="status">
								<c:if test="${status.index > 9}">     
										<option value="${status.index }">${status.index }</option>
								</c:if>
								<c:if test="${status.index < 10}">     
										<option value="0${status.index }">0${status.index }</option>
								</c:if> 
						</c:forEach>
					</select>
					:
					<select name="popupEndMi">
						<option value="">선택</option>
						<c:forEach begin="0" end="59" step="1" varStatus="status">
								<c:if test="${status.index > 9}">     
										<option value="${status.index }">${status.index }</option>
								</c:if>
								<c:if test="${status.index < 10}">     
										<option value="0${status.index }">0${status.index }</option>
								</c:if> 
						</c:forEach>
					</select>
					<button type="button" class="btn01" name="btn_dttm">날짜초기화</button>    
				</td>  
			</tr>
			
			<c:if test="${result.listCd != null}">
			<tr>
				<th><label class="">
				<c:if test="${bbsCd == 'GALLERY'}">
					활용구분
				</c:if>
				<c:if test="${bbsCd != 'GALLERY'}">
					<spring:message code="labal.ditcCd"/>
				</c:if>
				</label><span> *</span></th>
				<td>
					<select name="listSubCd">
						<option value="">${listMap.getListNm()} 선택</option>
						<c:forEach var="code" items="${ditcList}" varStatus="status">
							<option value="${code.ditcCd}">${code.ditcNm}</option>
						</c:forEach>
					</select>
					
					<c:if test="${result.list1Cd != null}">
						<select name="list1SubCd">
						<option value="">${listMap.getList1Nm()} 선택</option>
							<c:forEach var="code" items="${ditcList1}" varStatus="status">
								<option value="${code.ditcCd}">${code.ditcNm}</option>
							</c:forEach>
						</select>&nbsp;
					</c:if>
					<c:if test="${result.list2Cd != null}">
						<select name="list2SubCd">
						<option value="">${listMap.getList2Nm()} 선택</option>
							<c:forEach var="code" items="${ditcList2}" varStatus="status">
								<option value="${code.ditcCd}">${code.ditcNm}</option>
							</c:forEach>
						</select>&nbsp;
					</c:if>
					<c:if test="${result.list3Cd != null}">
						<select name="list3SubCd">
						<option value="">${listMap.getList3Nm()} 선택</option>
							<c:forEach var="code" items="${ditcList3}" varStatus="status">
								<option value="${code.ditcCd}">${code.ditcNm}</option>
							</c:forEach>
						</select>&nbsp;
					</c:if>
					<c:if test="${result.list4Cd != null}">
						<select name="list4SubCd">
						<option value="">${listMap.getList4Nm()} 선택</option>
							<c:forEach var="code" items="${ditcList4}" varStatus="status">
								<option value="${code.ditcCd}">${code.ditcNm}</option>
							</c:forEach>
						</select>&nbsp;
					</c:if>
				</td>
			</tr>
			</c:if>
			<c:if test="${result.deptYn eq 'Y'}">
			<tr>
				<th><label class="">담당부서</label></th>
				<td>
					<input type="hidden" name="orgCd" />
					<input type="text" name="orgNm" size="70" value="${sessionScope.loginVO.orgNm}"/>
				</td>
			</tr>
			</c:if>
			<c:if test="${bbsCd eq 'GUIDE'}">
			<tr>
				<th><label class="">서브메인 안내</th>
				<td>
					<input type="text" name="ansCont" size="100"/>
				</td>
			</tr>
			</c:if>
			<tr>	
				<th><label class="">문의처</label></th>
				<td>
					<input type="text" name="userNm" size="70" value="${sessionScope.loginVO.usrNm}"/>
				</td>
			</tr>
			<c:if test="${result.emailRegYn eq 'Y'}">
			<tr>	
				<th><label class=""><spring:message code="labal.email"/></label></th>
				<td>
					<input type="text" size="10" name="email1"/> @
					<input type="text" size="16" name="email2"/>
					<select name="email3">
					<option value="">선택</option>
					<c:forEach var="code" items="${codeMap.emailCd}" varStatus="status">
						<option value="${code.ditcCd }">${code.ditcNm }</option>
					</c:forEach>
					</select>
				</td>
			</tr>
			</c:if>
			<c:if test="${result.telYn eq 'Y'}">
			<tr>	
				<th><label class=""><spring:message code="labal.tel"/></label></th>
				<td>
					<select name="tel1">
						<option value="">선택</option>
						<c:forEach var="code" items="${codeMap.telCd}" varStatus="status">
							<option value="${code.ditcCd }">${code.ditcNm }</option>
						</c:forEach>
					</select>
					<input type="text" name="tel2" size="8" maxlength="4"/>
					<input type="text" name="tel3" size="8" maxlength="4"/>
				</td>
			</tr>
			</c:if>
			<tr>
				<th><label class=""><spring:message code="labal.bbsCont"/></label></th>
				<td style="padding-top:4px;padding-bottom:4px;">
					<textarea id="bbsCont" name="bbsCont" style="width:100%;height:300px;" rows="20"></textarea>
				</td>
			</tr>
		</table>
		<div class="buttons">
			<span name="delView"><input type="checkbox" name="delYn"  value="Y"/><label class=""><spring:message code="labal.bbsDtlDel"/></label></span> 
			${sessionScope.button.a_reg}       
			${sessionScope.button.a_modify}     
			${sessionScope.button.a_del}  
		</div>		
		</form>
	<c:if test="${result.atfileYn eq 'Y'}">
			<c:choose>
				<c:when test="${result.extLimit ne 'IMG'}">
				<form name="adminFileForm" method="post" action="#" enctype="multipart/form-data">
				<input type="hidden" name="fileSheetNm"/>
				<input type="hidden" name="initFlag"/>
				<input type="hidden" name="mstSeq" value=0 />    
<!-- 				<input type="hidden" name="tmpSeq" value=0 />     -->
				<input type="hidden" name="fileSeq" value=0 />    
				<input type="hidden" name="fileSize" value=0 />    
				<input type="hidden" name="bSeq" value=0 />    
					<h3 class="text-title2">첨부파일명</h3>		
					<div class="ibsheet_area" name="FILESheet"></div>
					<table class="list01">
							<caption>첨부파일리스트</caption>
							<colgroup>
								<col width="150"/>
								<col width=""/>
							</colgroup>
							<tr>
								<th>파일</th>
								<td>
									<span id="fileDiv" style="display:inline-block;">
									<span id="fileInfo">신규등록할 경우 초기화 버튼을 눌러서 등록해주세요</span>
									</span>
									${sessionScope.button.btn_init}
								</td>
							</tr>	
							<tr>
								<th><label class=""><spring:message code="labal.viewFileNm"/></label></th>
								<td>
									(한) <input type="text" name="viewFileNm" size="80" value="" /> (확장자제외)
									${sessionScope.button.btn_add}       
								</td>
							</tr>
							<tr>
								<th>삭제여부</th>
								<td>
									<select id="delYn" name="delYn">
										<option value="Y">예</option>
										<option value="N">아니오</option>
									</select>
								</td>
							</tr>
							<tr>
								<th><label class="">내용</label></th>
								<td style="padding-top:4px;padding-bottom:4px;">
									<textarea id="fileCont" name="fileCont" style="width:100%;height:150px;" rows="15"></textarea>
								</td>
							</tr>
						</table>
						
						<div class="buttons">
							${sessionScope.button.a_modify}     
							${sessionScope.button.a_del}  
						</div>
				</form>
				</c:when>
				<c:when test="${result.extLimit eq 'IMG'}">	
					<form name="adminImgForm" method="post" action="#" enctype="multipart/form-data">
						<input type="hidden" name="initFlag"/>
						<input type="hidden" name="mstSeq" value=0 />    
						<input type="hidden" name="topYnSeq" value=0 />
						<input type="hidden" name="delYnVal"  value = 0 />
						<input type="hidden" name="delYn0"  value=0 />
						<input type="hidden" name="delYn1"  value=0 />
						<input type="hidden" name="delYn2"  value=0 />
						<input type="hidden" name="delYn3"  value=0 />
						<input type="hidden" name="delYn4"  value=0 />
						<input type="hidden" name="delYn5"  value=0 />
						<input type="hidden" name="delYn6"  value=0 />
						<input type="hidden" name="delYn7"  value=0 />
						<h3 class="text-title2">첨부이미지</h3>
						<table class="list01">
							<caption>첨부파일리스트</caption>
							<colgroup>
								<col width="150"/>
								<col width=""/>
							</colgroup>
							<tr>
								<th>파일</th>
								<td>
									<span id="fileImgDiv" style="display:inline-block;">
									<span id="fileImgInfo">신규등록할 경우 초기화 버튼을 눌러서 등록해주세요</span>
<%-- 									${sessionScope.button.btn_init} --%>
									</span>
									<button type="button" class="btn01" title="초기화" name="btn_init">초기화</button>
								</td>
							</tr>		
							<tr>
								<th><label class=""><spring:message code="labal.viewFileNm"/></label></th>
								<td>
									(한) <input type="text" name="viewFileNm" size="80" value="" /> (확장자제외)
									${sessionScope.button.btn_add}       
								</td>
							</tr>
						</table>
						<table class="list05">
							<caption>첨부이미지</caption>
							<colgroup>
								<col width="150"/>
								<col width=""/>
							</colgroup>
							<tr>
								<th>이미지</th>
								<td style="text-align:left;">
									<div class="appendImg"></div>
<!-- 									<div class="img-box"> -->
										<!-- <p><input type="radio" id="ceoImg0"/> <label for="ceoImg0">대표이미지</label></p>
										<p><img src = "" /></p>
										<p><input type="checkbox" id="del0"/> <label for="del0">삭제</label></p> -->
<!-- 									</div> -->
								</td>
							</tr>	
						</table>
						<div class="buttons">
							${sessionScope.button.a_reg} 
							${sessionScope.button.a_modify}     
							${sessionScope.button.a_del}  
						</div>
						</form>
					</c:when>
					</c:choose>	
			</c:if>
			<c:if test="${result.linkYn eq 'Y'}">
			<form name="adminLinkForm" method="post" action="#">
				<input type="hidden" name="linkSheetNm"> 
				<h3 class="text-title2">URL 연결</h3>		
				<table class="list01">
						<caption>URL</caption>
						<colgroup>
							<col width="150"/>
							<col width=""/>
						</colgroup>
						<tr>
							<th>URL명</th>
							<td>
								(한) <input type="text" name="linkNm" size="80" value="" /> 
							</td>
						</tr>
						<tr>
							<th>URL</th>
							<td>
								<input type="text" name="url" size="84" value="http://" />  
								${sessionScope.button.btn_add}           
							</td>
						</tr>	
					</table>
					<div class="ibsheet_area" name="URLSheet"></div>
					<div class="buttons">
						${sessionScope.button.a_reg} 
						${sessionScope.button.a_modify}     
						${sessionScope.button.a_del}  
					</div>
			</form>
			</c:if>	
			<c:if test="${result.infYn eq 'Y'}">
			<form name="adminInfForm" method="post" action="#">
			<input type="hidden" name="infSheetNm"/>
				<h3 class="text-title2">공공데이터 연결</h3>		
				<table class="list01">
						<caption>공공데이터</caption>
						<colgroup>
							<col width="150"/>
							<col width=""/>
						</colgroup>
						<tr>
							<th>공공데이터 명칭</th>
							<td>
								<input type="hidden" name="infId" size="80" />
								<input type="text" name="infNm" size="80"  readonly/>
								<button type="button" class="btn01" name="btn_infSearch">검색</button>
								${sessionScope.button.btn_add}       
							</td>
						</tr>				
					</table>
					<div class="ibsheet_area" name="INFSheet"></div>
					<div class="buttons">
						${sessionScope.button.a_reg} 
						${sessionScope.button.a_modify}     
						${sessionScope.button.a_del}  
					</div>
			</form>
			</c:if>	
			<!-- 2018.04.26/softOn - 통계표 연결 추가 -->
			<c:if test="${result.tblYn eq 'Y'}">
			<form name="adminTblForm" method="post" action="#">
			<input type="hidden" name="tblSheetNm"/>
				<h3 class="text-title2">
					통계표 연결	<button type="button" class="btn01" name="tblAdd" style="float: right;">추가</button>
				</h3>
				<div class="ibsheet_area" name="TBLSheet"></div>
				<div class="buttons">
					${sessionScope.button.a_modify}
					${sessionScope.button.a_del}  
				</div>
			</form>
			</c:if>	
			
			<form name="adminAnsForm" method="post" action="#">
			<input type="hidden" name="ansSheetNm"/>
			<c:if test="${result.ansTag ne 'N' }">
				<h3 class="text-title2">${result.ansTagNm }</h3>		
				<table class="list01">
						<caption>${result.ansTagNm }</caption>
						<colgroup>
							<col width="150"/>
							<col width=""/>
							<col width="150"/>
							<col width=""/>
							<col width="150"/>
							<col width=""/>
						</colgroup>
						<tr>
							<th>처리상태</th>
							<td><input type="text"  name="ansStateNm" style="width:100%;" class="text-read" readonly=""></td>
							<th>처리일자</th>
							<td colspan="3"><input type="text"  name="apprDttm" style="width:100%;" class="text-read" readonly=""></td>
						</tr>
						<tr>
							<th><label class=""><spring:message code="labal.orgCharge"/></label></th>
							<td>
								<input type="hidden" name="orgCd" value="${sessionScope.loginVO.orgCd}"/>
								<input type="text" name="orgNm" style="width:100%;" class="text-read" readonly="" value="${sessionScope.loginVO.orgNm}"/>
							</td>
							<th><label class=""><spring:message code="labal.orgChargeNm"/></label></th>
							<td>
								<input type="text" name="apprNm" value="${sessionScope.loginVO.usrNm}"/>
							</td>
							<th><label class=""><spring:message code="labal.tel"/></label></th>
							<td>
								<input type="text" name="apprTel" />
							</td>
						</tr>	
						<tr>
							<th><label class="">답변</th>
							<td colspan="5" style="padding-top:4px;padding-bottom:4px;">
								<textarea name="ansCont" style="width:100%;height:100px;" rows="20"></textarea>
							</td>
						</tr>		
					</table>
					<div class="buttons">
						<a href="#" class="btn02" name="a_view">미리보기</a>
						<a href="#" class="btn02" name="a_aw">접수</a>
						<a href="#" class="btn03" name="a_ak">승인</a>
						<a href="#" class="btn02" name="a_ac">승인불가</a>
					</div>
			</c:if>
			</form>
		</div>
		<!-- 탭 내용 끝 --> 
		
		<!-- 목록내용 -->
		<div class="content"  >
		<form name="adminBbsList"  method="post" action="#">
		<input type="hidden" name="bbsCd" value="${bbsCd }"/>
		<input type="hidden" name="ansTag" value="${result.ansTag }"/>
		<table class="list01">
			<caption>일반게시판</caption>
			<colgroup>
				<col width="150"/>
				<col width=""/>
			</colgroup>     
			<tr>
				<th>검색어</th>
				<td>
					<select name="searchGubun">
						<option value="BBS_TIT">제목</option>
	                 	<option value="USER_NM">작성자</option>
	                 	<c:if test="${result.tblYn eq 'Y' }">
							<option value="TAG_STATBL_NM">통계표명</option>
	                 	</c:if>
					</select>
					<input name="searchWord" type="text" value=""/>
					<button type="button" class="btn01B" name="btn_search"><spring:message code="btn.inquiry"/></button>
					${sessionScope.button.btn_reg}                     
				</td>
				<th>작성일자</th>
				<td>
					<input type="text" name="regStartDtts" id="regStartDtts" value="" readonly="readonly"/>
					<input type="text" name="regEndDtts" id="regEndDtts" value="" readonly="readonly"/>
					&nbsp;&nbsp;
					<button type="button" class="btn01" id="openDttm_reset" name="openDttm_reset">초기화</button>
				</td>
			</tr>
			<c:if test="${result.listCd != null}">
			<tr>
				<th><label class=""><spring:message code="labal.ditcCd"/></label></th>
				<td>
					<select name="ditcCode">
						<option value="">${listMap.getListNm()} 선택</option>
						<c:forEach var="code" items="${ditcList}" varStatus="status">
							<option value="${code.ditcCd}">${code.ditcNm}</option>
						</c:forEach>
					</select>&nbsp;
					
					<c:if test="${result.list1Cd != null}">
						<select name="ditc1Code">
							<option value="">${listMap.getList1Nm()} 선택</option>
							<c:forEach var="code" items="${ditcList1}" varStatus="status">
								<option value="${code.ditcCd}">${code.ditcNm}</option>
							</c:forEach>
						</select>&nbsp;
					</c:if>
					<c:if test="${result.list2Cd != null}">
						<select name="ditc2Code">
							<option value="">${listMap.getList2Nm()} 선택</option>
							<c:forEach var="code" items="${ditcList2}" varStatus="status">
								<option value="${code.ditcCd}">${code.ditcNm}</option>
							</c:forEach>
						</select>&nbsp;
					</c:if>
					<c:if test="${result.list3Cd != null}">
						<select name="ditc3Code">
						<option value="">${listMap.getList3Nm()} 선택</option>
							<c:forEach var="code" items="${ditcList3}" varStatus="status">
								<option value="${code.ditcCd}">${code.ditcNm}</option>
							</c:forEach>
						</select>&nbsp;
					</c:if>
					<c:if test="${result.list4Cd != null}">
						<select name="ditc4Code">
							<option value="">${listMap.getList4Nm()} 선택</option>
							<c:forEach var="code" items="${ditcList4}" varStatus="status">
								<option value="${code.ditcCd}">${code.ditcNm}</option>
							</c:forEach>
						</select>&nbsp;
					</c:if>
				</td>
				<th>상태</th>
				<td>
					<select name="ansStateNm">
							<option value="">전체</option>
							<option value="접수대기">접수대기</option>
							<option value="승인대기">승인대기</option>
							<option value="승인불가">승인불가</option>
							<option value="승인완료">승인완료</option>
					</select
				</td>
			</tr>
			</c:if>
		</table>
		</form>
		</c:forEach>
		<!-- ibsheet 영역 -->
		<div style="clear: both;"></div>
		<div class="ibsheet_area_both">
			<script type="text/javascript">createIBSheet("mySheet", "100%", "300px"); </script>             
		</div>
		</div>		
		<!--  목록내용 끝 -->
	</div>	
</div>
</body>
</html>