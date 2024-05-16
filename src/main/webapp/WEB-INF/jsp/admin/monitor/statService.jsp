<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%-- @(#)statService.jsp 1.0 2015/06/01                                --%>
<%--                                                                        --%>
<%-- COPYRIGHT (C) 2013 WISEITECH CO., LTD. ALL RIGHTS RESERVED.            --%>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>

<%@ page import="egovframework.common.WiseOpenConfig"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="validator"
	uri="http://www.springmodules.org/tags/commons-validator"%>
<%@ taglib uri="http://java.sun.com/jstl/fmt" prefix="fmt" %>
<!DOCTYPE>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><spring:message code='wiseopen.title' /></title>
<c:import url="/WEB-INF/jsp/inc/headinclude.jsp" />
<!--  
	validate 사용시 반드시 선언
	formName명과 validate 함수명이 연결되어있음
	adminOpenInf -> validateadminOpenInf 체크함
	resources/validator/*.* xml을 만들어서 사용
  -->
<validator:javascript formName="adminOpenInf" staticJavascript="false"
	xhtml="true" cdata="false" />
</head>
<script type="text/javascript" src="<c:url value="/js/common/base/commonness.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/common/base/delegation.js" />"></script>
<script language="javascript">              
//<![CDATA[                              
function tabSet(){ //탭 객체 생성  
	openTab = new OpenTab(tabId,tabContentClass,tabBody); //headinclude.jsp 변수 있음
	openTab.TabObj = openTab;  
	openTab.addTabClickEvent();    
}	   
        
$(document).ready(function()    {    
	//Btn_Set();
	LoadPage(); 
	LoadSearch(); 
	LoadUse();
	LoadRef();
	//LoadEmp();
	doAction('search');                                              
	inputEnterKey();       
	//tabSet();// tab 셋팅
	init();
	setTabButton();		//탭 버튼
	
	
	
});    

function Btn_Set() { //버튼 초기화 함수
	   
/* 	   $("a[name=a_reg]").show();
	   $("a[name=a_reset]").show();
	   
	   $("a[name=a_modify]").hide();
	   $("a[name=a_del]").hide(); */
	   
}

var dtId = "";
function init(){
	var formObj = $("form[name=adminStatService]");
	var formObj2 = $("form[name=adminStatDate]");
	var formSearchObj = $("form[name=adminStatServiceSearch]");
	formObj2.find("input[name=startDttm]").datepicker(setCalendar());  
	formObj2.find("input[name=endDttm]").datepicker(setCalendar());
// 	formObj.find("input[name=openDttmFrom]").datepicker(setCalendar());      
	datepickerTrigger();     
	formSearchObj.find("button[name=btn_search]").eq(2).click(function(e) { 
		doAction("search");
		 return false;        
	 }); 
	formSearchObj.find("button[name=btn_search]").eq(1).click(function(e) { 
		doAction("search");
		return false;               
	 }); 
	formSearchObj.find("button[name=btn_search]").eq(0).click(function(e) { 
		doAction("popcatenm");
		return false;                  
	 }); 
	formSearchObj.find("button[name=btn_init]").eq(0).click(function(e) { 
		/* formObj.find("input[name=orgNm]").val("");
		formObj.find("input[name=orgCd]").val("");
		return false;  */    
		//$("a[name=cateNm]").();
		$("input[name=cateId]").val(null);
		$("input[name=cateNm]").val(null);
	}); 
	formSearchObj.find("button[name=btn_init2]").eq(0).click(function(e) { 
		/* formObj.find("input[name=orgNm]").val("");
		formObj.find("input[name=orgCd]").val("");
		return false;  */    
		//$("a[name=cateNm]").();
		$("input[name=orgNm]").val(null);
	}); 
	formObj.find("button[name=btn_init]").eq(1).click(function(e) { 
		/* formObj.find("input[name=cateNm]").val("");
		formObj.find("input[name=cateId]").val("");
		return false;    */ 
		//$("a[name=orgNm]").blank();
		$("input[name=orgNm]").val(null);
		
	}); 
	formSearchObj.find("button[name=btn_reg]").click(function(e) { 
		doAction("reg");
		return false;                  
	 }); 
	formObj.find("button[name=btn_metadownload]").click(function(e) { 
		doAction("metadown");
		 return false;        
	 }); 
	formObj.find("button[name=btn_dttm]").click(function(e) { 
		formObj.find("input[name=openDttmFrom]").val("");
		formObj.find("input[name=openDttmTo]").val("");
	 }); 
	
	
}

function setDate(){
	var formObj = $("form[name=adminStatService]");
	var now = new Date();
	var yester = new Date();
	yester.setMonth(yester.getMonth()-1);
	var n_year = now.getFullYear();
	var y_year = yester.getFullYear();
	var n_mon = (now.getMonth()+1)>9?now.getMonth()+1:'0'+(now.getMonth()+1);
	var y_mon = (yester.getMonth()+1)>9?yester.getMonth()+1:'0'+(yester.getMonth()+1);
	var n_day = (now.getDate())>9?(now.getDate()):'0'+(now.getDate());
	var y_day = (yester.getDate())>9?(yester.getDate()):'0'+(yester.getDate());
	var dateFrom=y_year+'-'+y_mon+'-'+y_day;
	var dateTo=n_year+'-'+n_mon+'-'+n_day;
	formObj.find("input[name=startDttm]").val(dateTo);
	formObj.find("input[name=endDttm]").val(dateTo);
}



function buttonEventAdd(){
	setTabButton();
}
                                
function LoadPage()                
{      
	//message-common_ko_KR.properties 선언 후 사용 or message-common_en_US.properties 선언 후 사용
	var gridTitle = "NO"
		gridTitle +="|"+"<spring:message code='labal.infId'/>";  
		gridTitle +="|"+"<spring:message code='labal.dtNm'/>";  
		gridTitle +="|"+"<spring:message code='labal.infNm'/>";        
		gridTitle +="|"+"<spring:message code='labal.cclCd'/>";        
	//	gridTitle +="|"+"데이터셋 구분";        
		gridTitle +="|"+"<spring:message code='labal.cateNm'/>";        
		gridTitle +="|"+"<spring:message code='labal.useDeptNm'/>";
		//gridTitle +="|"+"<spring:message code='labal.orgNm'/>";        
// 		gridTitle +="|"+"<spring:message code='labal.usrNm'/>"; 
		gridTitle +="|"+"<spring:message code='labal.openDttm'/>";    
		gridTitle +="|"+"<spring:message code='labal.infState'/>";        
		gridTitle +="|"+"개방서비스";   
	
    with(mySheet){
    	                      
    	var cfg = {SearchMode:3,Page:50};                                 
        SetConfig(cfg);   
        var headers = [                                             
                    {Text:gridTitle, Align:"Center"}                 
                ];
        var headerInfo = {Sort:0,ColMove:1,ColResize:1,HeaderCheck:0};
        
        InitHeaders(headers, headerInfo); 
         
        var cols = [          
					 {Type:"Seq",		SaveName:"seq",				Width:40,	Align:"Center",		Edit:false,  Sort:false}
					,{Type:"Text",		SaveName:"infId",			Width:0,	Align:"Center",		Edit:false, Hidden:true}
					,{Type:"Text",		SaveName:"dtNm",			Width:240,	Align:"Left",		Edit:false}
					,{Type:"Text",		SaveName:"infNm",			Width:240,	Align:"Left",		Edit:false}
					,{Type:"Text",		SaveName:"cclNm",			Width:200,	Align:"Left",		Edit:false}
					,{Type:"Text",		SaveName:"cateFullNm",	Width:230,	Align:"Left",		Edit:false}
					,{Type:"Text",		SaveName:"useDeptNm",			Width:90,	Align:"Center",		Edit:false}
					,{Type:"Text",		SaveName:"openDttm",			Width:90,	Align:"Center",		Edit:false}
					,{Type:"Combo",		SaveName:"infState",			Width:80,	Align:"Left",		Edit:false}
					,{Type:"Html",		SaveName:"openSrv",			Width:210,	Align:"Left",		Edit:false}
                ];       
                                      
        InitColumns(cols);                                                                           
//         FitColWidth();                                                         
        SetExtendLastCol(1);   
        SetColProperty("infState", ${codeMap.infStatsIbs} );  
        SetColProperty("dsCd", {ComboCode:"RAW|TS", ComboText:"원시|통계"}	);    //InitColumns 이후에 셋팅
        
    }               
    default_sheet(mySheet);                      
}      


function LoadSearch()                
{      
	//message-common_ko_KR.properties 선언 후 사용 or message-common_en_US.properties 선언 후 사용
	var gridTitle = "합계(누적)";
		gridTitle +="|"+"Sheet"; 
		gridTitle +="|"+"Chart";
		gridTitle +="|"+"Map"; 
		gridTitle +="|"+"Open API";
		gridTitle +="|"+"File";
		gridTitle +="|"+"Link";
		
	
    with(mySheet2){
    	                      
    	var cfg = {SearchMode:3,Page:50};                                 
        SetConfig(cfg);   
        var headers = [                                             
                    {Text:gridTitle, Align:"Center"}                 
                ];
        var headerInfo = {Sort:0,ColMove:1,ColResize:1,HeaderCheck:0};
        
        InitHeaders(headers, headerInfo); 
         
        var cols = [          
					 {Type:"Text",		SaveName:"del",				Width:60,	Align:"Center",		Edit:false}
					,{Type:"Text",		SaveName:"seq",				Width:40,	Align:"Center",		Edit:false}
					,{Type:"Text",		SaveName:"seqceNo",			Width:40,	Align:"Center",		Edit:false}
					,{Type:"Text",		SaveName:"orgNm",			Width:40,	Align:"Center",		Edit:false}
					,{Type:"Text",		SaveName:"orgCd",			Width:40,	Align:"Center",		Edit:false}
					,{Type:"Text",		SaveName:"usrNm",			Width:40,	Align:"Center",		Edit:false}
					,{Type:"Text",		SaveName:"usrCd",			Width:40,	Align:"Center",		Edit:false}
					
                ];       
                                      
        InitColumns(cols);                                                                           
        FitColWidth();                                                         
        SetExtendLastCol(1);   
        SetColProperty("jobCd",${codeMap.jobCdIbs});
    }               
    default_sheet(mySheet2);                      
}    

function LoadUse()                
{      
	//message-common_ko_KR.properties 선언 후 사용 or message-common_en_US.properties 선언 후 사용
	var gridTitle = "합계(누적)";
		gridTitle +="|"+"XLS"; 
		gridTitle +="|"+"CSV";
		gridTitle +="|"+"JSON"; 
		gridTitle +="|"+"XML";
		gridTitle +="|"+"TXT";
		gridTitle +="|"+"Open API 호출";
		gridTitle +="|"+"파일다운로드";
		gridTitle +="|"+"링크연결";
	
    with(mySheet3){
    	                      
    	var cfg = {SearchMode:3,Page:50};                                 
        SetConfig(cfg);   
        var headers = [                                             
                    {Text:gridTitle, Align:"Center"}                 
                ];
        var headerInfo = {Sort:0,ColMove:1,ColResize:1,HeaderCheck:0};
        
        InitHeaders(headers, headerInfo); 
         
        var cols = [          
					 {Type:"Text",		SaveName:"del",				Width:60,	Align:"Center",		Edit:false}
					,{Type:"Text",		SaveName:"seq",				Width:40,	Align:"Center",		Edit:false}
					,{Type:"Text",		SaveName:"seqceNo",			Width:40,	Align:"Center",		Edit:false}
					,{Type:"Text",		SaveName:"orgNm",			Width:40,	Align:"Center",		Edit:false}
					,{Type:"Text",		SaveName:"orgCd",			Width:40,	Align:"Center",		Edit:false}
					,{Type:"Text",		SaveName:"usrNm",			Width:60,	Align:"Center",		Edit:false}
					,{Type:"Text",		SaveName:"usrCd",			Width:40,	Align:"Center",		Edit:false}
					,{Type:"Text",		SaveName:"jobCd",			Width:40,	Align:"Center",		Edit:false}
					,{Type:"Text",	SaveName:"status",			Width:40,	Align:"Center",		Edit:false}
					
                ];       
                                      
        InitColumns(cols);                                                                           
        FitColWidth();                                                         
        SetExtendLastCol(1);   
        SetColProperty("jobCd",${codeMap.jobCdIbs});
    }               
    default_sheet(mySheet3);                      
}    

function LoadRef()                
{      
	//message-common_ko_KR.properties 선언 후 사용 or message-common_en_US.properties 선언 후 사용
	var gridTitle = "주소데이터";
		//gridTitle +="|"+"주소데이터"; 
		gridTitle +="|"+"지번주소"; 
		gridTitle +="|"+"도로명주소";
		gridTitle +="|"+"우편번호"; 
		gridTitle +="|"+"좌표변환";
	
    with(mySheet4){
    	                      
    	var cfg = {SearchMode:3,Page:50};                                 
        SetConfig(cfg);   
        var headers = [                                             
                    {Text:gridTitle, Align:"Center"}                 
                ];
        var headerInfo = {Sort:0,ColMove:1,ColResize:1,HeaderCheck:0};
        
        InitHeaders(headers, headerInfo); 
         
        var cols = [          
					{Type:"Text",		SaveName:"del",				Width:60,	Align:"Center",		Edit:false}
					,{Type:"Text",		SaveName:"seq",				Width:60,	Align:"Center",		Edit:false}
					,{Type:"Text",		SaveName:"seqceNo",			Width:60,	Align:"Center",		Edit:false}
					,{Type:"Text",		SaveName:"orgNm",			Width:60,	Align:"Center",		Edit:false}
					,{Type:"Text",		SaveName:"orgCd",			Width:60,	Align:"Center",		Edit:false}
					
                ];       
                                      
        InitColumns(cols);                                                                           
        FitColWidth();                                                         
        SetExtendLastCol(1);   
        SetColProperty("jobCd",${codeMap.jobCdIbs});
    }               
    default_sheet(mySheet4);                      
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

function fncFileChange2() {
	var classObj = $('.'+'content').eq(1);
	var formObj = classObj.find("form[name=adminImgForm]");
	val = formObj.find("input[id=file]").val().split("\\");
	fileName = val[val.length-1];
	f_name = fileName.substring(0, fileName.indexOf("."));
	s_name = fileName.substring(fileName.length-3, fileName.length);
	formObj.find("input[id=saveFileNm]").val(fileName);
// 	alert("fileName==>"+fileName+" , f_name==>"+f_name+" , s_name==>"+s_name);
}

function fileSaveCallBack2(res) {		// 이미지 미리보기 추가 콜백
	
	var classObj = $("."+'content').eq(1); //tab으로 인하여 form이 다건임
	
	var formObj = classObj.find("form[name=adminOpenInf]");
	
	
	var url = "<c:url value='/admin/openinf/bbsImgDetailView.do'/>";
	param = formObj.serialize();
	ajaxCall(url, param, bbsDtlCallBack);       
	
}

function bbsDtlCallBack(tab, json, res){
	
	var classObj = $("."+'content').eq(1); //tab으로 인하여 form이 다건임
	var formObj = classObj.find("form[name=adminOpenInf]");
	var formImgObj = classObj.find("form[name=adminImgForm]");
	var delUse = "N";
	var cateId = formObj.find("input[name=cateId]").val();
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
			
			var param = "downCd=C&fileSeq=0&seq="+cateId;
			append += "<div class='img-box'>";
			append += "<p><input type='hidden' name='delUse' value='"+delUse+"' /> <label for='ceoImg"+i+"'>대표이미지</label></p>";
			append += "<p><img src=\"<c:url value='/admin/openinf/fileDownload.do?"+param+"'/>\" alt='"+tab.resultImg[i].viewFileNm+"' width='120' height='120'/></p>";
			append += "<p><input type='checkbox' name='del_yn' id='del"+i+"' value='"+cateId+"' onclick=\"javascript:checkDel('"+delUse+"', '"+cateId+"', '"+i+"');\" /> <label for='del"+i+"'>삭제</label></p>";
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
	
}

function checkDel(delUse, cateId, seq){
	var classObj = $("."+'content').eq(1); //tab으로 인하여 form이 다건임
	var formObj = classObj.find("form[name=adminOpenInf]");

	var formImgObj = classObj.find("form[name=adminImgForm]");
	
	if(delUse == "Y"){
 		formImgObj.find("input[name=delYnVal]").val(cateId);
 		var url = "<c:url value='/admin/opendt/deleteImg.do'/>"; 
		var param = formObj.serialize();
			param += formImgObj.serialize();
		ajaxCallAdmin(url, param, imgDeleteCallBack2);
	}else{
		if(formImgObj.find("input:checkbox[id=del"+seq+"]").is(":checked") == true){
			formImgObj.find("input[name=delYn"+seq+"]").val(cateId);
		}else{
			formImgObj.find("input[name=delYn"+seq+"]").val('0');
		}
	}
	
	
}

function imgDeleteCallBack(res){
//	 var result = res.RESULT.CODE;
//	alert(res.RESULT.CODE);
	if(res.RESULT.CODE == 0){
		alert("<spring:message code='MSG.SAVE'/>");
	}else{
		alert("<spring:message code='ERR.SAVE'/>");
	}
	
	var classObj = $("."+'content').eq(1); //tab으로 인하여 form이 다건임
	var formObj = classObj.find("form[name=adminOpenInf]");
	var url = "<c:url value='/admin/opendt/bbsImgDetailView.do'/>";
	param = formObj.serialize();
	ajaxCall(url, param, bbsDtlCallBack);  
}

function imgDeleteCallBack2(res){
	var classObj = $("."+'content').eq(1); //tab으로 인하여 form이 다건임
	var formObj = classObj.find("form[name=adminStatService]");
	var url = "<c:url value='/admin/opendt/bbsImgDetailView.do'/>";
	param = formObj.serialize();
	ajaxCall(url, param, bbsDtlCallBack);  
}

/*Sheet 각종 처리*/                  
function doAction(sAction)                                  
{
	var classObj = $("."+"content").eq(0); //tab으로 인하여 form이 다건임
	var actObj = setTabForm(classObj); // 0: form data, 1: form 객체
	var formObj = $("form[name=adminStatServiceSearch]");        
	switch(sAction)
	{          
		case "search":      //조회   
			
			/* fromObj = formObj.find("input[name=openDttmFrom]");                          
			toObj = formObj.find("input[name=openDttmTo]");
			dateValCheck(fromObj,toObj)// from , to 날짜 안맞을 경우 자동셋팅    */
			ajaxBeforeSendAdmin("<c:url value='/admin/ajaxBeforeSendAdmin.do'/>"); //IbSheet 조회전 세션 체크
			var param = {PageParam: "ibpage", Param: "onepagerow=50&"+actObj[0]};   
			mySheet.DoSearchPaging("<c:url value='/admin/monitor/statServiceListAll.do'/>", param);   
			break;
		case "reg":      //등록화면                 
			var title = "등록하기"
			var id ="statServiceReg";
			openTab.addRegTab(id,title,tabCallRegBack); // 탭 추가 시작함
			break;
		case "popclose":              
			closeIframePop("iframePopUp");
			break;
/* 		case "poporgnm":
			var url="<c:url value="/admin/basicinf/popup/commOrg_pop.do"/>" +  "?index=0";
			var popup = OpenWindow(url,"orgPop","500","550","yes");	    
			break; */
		case "popcatenm":
			var url = "<c:url value="/admin/opendt/openCateParListPopUp.do"/>" + "?cateGb=2&index=0";
			var popup = OpenWindow(url,"openCateParListPopUp","750","550","yes");	
			popup.focus();
			break;
		/* case "metadown":			//공공데이터포털용 엑셀 다운로드
			formObj.attr("action","<c:url value='/admin/openinf/metaDownload.do'/>").submit();   
			break; */
	}           
}   

function doTabAction(sAction){
	var classObj = $("."+"content").eq(1); //tab으로 인하여 form이 다건임
	var actObj = setTabForm(classObj); // 0: form data, 1: form 객체
	var formObj = classObj.find("form[name=adminStatService]");
	ajaxBeforeSendAdmin("<c:url value='/admin/ajaxBeforeSendAdmin.do'/>"); //IbSheet 조회전 세션 체크
	switch(sAction){
		
		case "save":      //등록 
			
			if (!validateAdminOpenInf(actObj[1])){	return;			}	//xml Validation체크
			if(!saveCheck(formObj)){	return;			}	//validation 체크
			
			var sheetCnt = mySheet2.RowCount();
			if(sheetCnt == 0) {
				alert("조직정보를 등록하셔야 합니다.");
				return false;
			} 
			
			var cateId = formObj.find("input[name=cateId]").val();

			var cateId2 = formObj.find("input[name=cateId2]").val();
					
			if(cateId == cateId2){
				alert("분류1의 값과 분류2의 값이 같으면 안됩니다.");
				formObj.find("input[name=cateId2]").val("");
				formObj.find("input[name=cateNm2]").val("");
				return false;
			}
			
			
			ibsSaveJson = mySheet2.GetSaveJson();
			
			var url = "<c:url value='/admin/monitor/statServiceReg.do'/>"; 
			var param = formObj.serialize();
			param = param.replace(/%/g,'%25');					// parameter Encoding
			
// 			ajaxCallAdmin(url, param, saveCallBack);
			IBSpostJson(url, param, sheetCallBack);
			location.reload(); 
			break;
				
		case "update":      //수정 
			if ( !confirm("수정 하시겠습니까? ") ) {
				return;
  			}
			
		
			if (!validateAdminOpenInf(actObj[1])){	return;			}	//xml Validation체크
			if(!saveCheck(formObj)){	return;			}	//validation 체크
			
			var sheetCnt = mySheet2.RowCount();
			if(sheetCnt == 0) {
				alert("조직정보를 등록하셔야 합니다.");
				return false;
			}
			
			if(mySheet2.RowCount("D") == mySheet2.RowCount()){
				alert("조직정보는 최소 1개이상 존재하여야 합니다.");
				return false;
			}
			
			
			ibsSaveJson = mySheet2.GetSaveJson({AllSave:true});
			
			var url = "<c:url value='/admin/monitor/statServiceUpd.do'/>";
			var param = formObj.serialize();
			param = param.replace(/%/g,'%25');
			
 			//param = encodeURIComponent(param);					// parameter Encoding
 			param = param + "&ibsSaveJson=" + JSON.stringify(ibsSaveJson);
			ajaxCallAdmin(url, param, sheetCallBack);
			
			//IBSpostJson(url, param, sheetCallBack);
			//formSubmit(url, param, sheetCallBack);
			location.reload(); 
			break;
			
			
		case "delete":      //삭제
			if ( !confirm("삭제 하시겠습니까? ") ) {
				return;
  			}
			
			ibsSaveJson = mySheet2.GetSaveJson({AllSave:true});
		
			 var url = "<c:url value='/admin/monitor/statServiceDel.do'/>"; 
			 var param = formObj.serialize();
			 param = param.replace(/%/g,'%25');
			 
			 //ajaxCallAdmin(url, param, saveCallBack);
			 IBSpostJson(url, param, sheetCallBack);
			 location.reload(); 
			 break;
			 
		case "view":                         
			var infId = formObj.find("input[name=infId]").val();                  
			var target = "<c:url value='/admin/monitor/popup/statServiceViewPopUp.do'/>"+"?infId="+infId;
			var wName = "metaview"        
			var wWidth = "1024"
			var wHeight = "580"                            
			var wScroll ="no"
			OpenWindow(target, wName, wWidth, wHeight, wScroll);                     
			break;
		
		case "import":
			var param = "infId="+formObj.find("input[name=existinfId]").val();
			var url =  "<c:url value='/admin/monitor/existStatServiceList.do'/>";
			ajaxCallAdmin(url, param, importCallBack);
			break;
			
		case "search":      //조회   
			var row = mySheet.GetSelectionRows();
			var infId = mySheet.GetCellValue(row,"infId");
			ajaxBeforeSendAdmin("<c:url value='/admin/ajaxBeforeSendAdmin.do'/>"); //IbSheet 조회전 세션 체크
			var param = {PageParam: "ibpage", Param: "onepagerow=50&infId="+infId};   
			
			mySheet2.DoSearchPaging("<c:url value='/admin/monitor/statServiceOrgUsrList.do'/>", param);
			break;
		
		case "init":
			
			formObj.find("input[name=infId]").val("");
			formObj.find("input[name=infNm]").val("");
			
			formObj.find("input[name=cateId]").val("");
			formObj.find("input[name=cateIdTop]").val("");
			formObj.find("input[name=cateNm]").val("");
			
			formObj.find("select[name=cclCd]").val("");
			
			formObj.find("input[name=dtId]").val("");
			formObj.find("input[name=dtNm]").val("");
			
			formObj.find("input[name=dsId]").val("");
			formObj.find("button[name=dsSearch]").show();
					
			
			formObj.find("select[name=openCd]").val("");
			
			formObj.find("select[name=causeCd]").val("");
			formObj.find("input[name=causeInfo]").val("");
			
			formObj.find("select[name=loadCd]").val("");
			
			formObj.find("input[name=infTag]").val("");
			formObj.find("input[name=openDttm]").val("");
			formObj.find("input[name=dataCondDttm]").val("");
			formObj.find("input[name=useDeptNm]").val("");
			formObj.find("textarea[name=infExp]").val("");
			formObj.find("div[name=infExp]").val("");
			
			formObj.find(".icon-open1").attr("style", "display:none;");
			formObj.find(".icon-open2").attr("style", "display:none;");
			formObj.find(".icon-open3").attr("style", "display:none;");
			formObj.find(".icon-open4").attr("style", "display:none;");
			
			formObj.find(".serviceYn").find("span").removeClass("icon-no-service").addClass("icon-no-service");
			formObj.find("select[name=cclCd]").val("");
			
			mySheet2.RemoveAll();
			
			Btn_Set();
			break;
	}
}

function sheetCallBack(res) {
	var result = res.RESULT.CODE;
	if(result == 0) {
		alert(res.RESULT.MESSAGE);		
	} else {
		alert(res.RESULT.MESSAGE);
	}
}

function mySheet_OnDblClick(row, col, value, cellx, celly) {
    if(row == 0) return;   
    
    
       $("a[name=a_modify]").show();
	   $("a[name=a_del]").show();
	   
	   $("a[name=a_reg]").hide();
	   $("a[name=a_reset]").show();
    //tabEvent(row);   
    
    var url = "<c:url value='/admin/monitor/statServiceList.do'/>";
    var param = "infId= " + mySheet.GetCellValue(row,"infId");
    
    ajaxBeforeSendAdmin("<c:url value='/admin/ajaxBeforeSendAdmin.do'/>"); //IbSheet 조회전 세션 체크
    ajaxCallAdmin(url, param, tabInfCallBack);
    doTabAction("search");
}


function mySheet2_OnPopupClick(Row, Col){
	
/* 	
			if(mySheet2.ColSaveName(Col) == "orgNm"){
					window.open("<c:url value="/admin/basicinf/popup/commOrg_pop.do"/>" + "?orgNmGb=7&sheetNm=mySheet2","list"
				, "fullscreen=no, width=500, height=550"); 
			}
			
			else if(mySheet2.GetCellValue(Row, "orgNm") != "" && mySheet2.ColSaveName(Col) == "usrNm"){
				window.open("<c:url value="/admin/basicinf/popup/commUsrPos_pop.do"/>" + "?usrGb=4&sheetNm=mySheet2&orgCd="+mySheet2.GetCellValue(Row, "orgCd") ,"list"
						, "fullscreen=no, width=600, height=550");
			}
			else{
				alert("조직명을 넣어주세요");
			}
			 */
			/* formObj.find("button[name=usrSearch]").click(function() {		// 직원명 팝업
		 		var orgCd = formObj.find("[name=orgCd]").val();   
		 		if(orgCd == ""){
		 			alert("담당조직을 먼저 선택해주세요.");
		 			return false;
		 		}
				var url = "<c:url value="/admin/basicinf/popup/commUsr_pop.do"/>" + "?usrGb=3&orgCd="+orgCd; 
				var popup = OpenWindow(url,"usrPop","500","550","yes");	        
		 		return false;    
		 	}); */
}

  /* function mySheet2_OnPopupClick(Row, Col) {
	//if(Row == 0) return;
	//var objTab = getTabShowObj(); //탭이 oepn된 객체가져옴
	var classObj = $("."+"content_dt");
	var formObj = classObj.find("form[name=adminOpenInf]");    
	//var sheetObj =formObj.find("input[name=sheetNm]").val();  
	var mySheet2 = formObj.find("[name=mySheet2]").val();
	var gridObj = window[mySheet2];
	var param = "?sheetNm="+sheetObj;
		param += "&toSeq="+Row;
	//mySheet2.DataInsert(0);
// 	var data = "?dsId="+gridObj.GetCellValue(Row,"dsId");       
// 		data += "&colSeq="+gridObj.GetCellValue(Row,"colSeq");                
	
	formObj.find("button[name=orgNm]").click(function(){		// 조직 추가 팝업
 		var mySheet2 = formObj.find("[name=mySheet2]").val();
 		var url="<c:url value="/admin/basicinf/popup/commOrg_pop.do"/>" + "?orgNmGb=7&sheetNm=mySheet2"; 
		var popup = OpenWindow(url,"orgPop","500","550","yes");	            
 	});  
	alert("1");
	if(gridObj.ColSaveName(Col) == "orgNm"){
		
		var target = "<c:url value="/admin/basicinf/popup/commOrg_pop.do"/>" + "?orgNmGb=7&sheetNm=mySheet2"; 
		//var wName = "ccolview";        
		//var wWidth = "900";            
		//var wHeight = "600" ;                           
		//var wScroll ="yes";
		OpenWindow(target, "orgPop","500","550","yes");
		
		
		
	}
	
	if(gridObj.ColSaveName(Col) == "empNm"){
		var target = "<c:url value='/admin/openinf/opends/openDsTermPop.do"+param+"'/>";
		var wName = "ccolview";        
		var wWidth = "900";            
		var wHeight = "600" ;                           
		var wScroll ="yes";
		OpenWindow(target, wName, wWidth, wHeight, wScroll);
		
	}
}   */


function tabInfCallBack(json){
	var classObj = $("."+"content").eq(1); //tab으로 인하여 form이 다건임
	var formObj = classObj.find("form[name=adminStatService]");
	formObj.find("input[name=themeCd]").removeAttr("checked",true);
	formObj.find("input[name=saCd]").removeAttr("checked",true);
	
	formObj.find(".ser	viceYn").find("span").removeClass("icon-no-service").addClass("icon-no-service");
	if(json.DATA != null){
		
		$.each(json.DATA,function(key,state){
			
			var srvCd = state.srvCd;
			var srvIndex = typeIndex(srvCd);
			var metaCate = state.metaCate;
			
			
			$.each(state,function(key2,state2){
// 				formObj.find("a[name=a_reg]").remove();
				
				if(key2 == "infState"){
					if(state2 == "Y"){
						formObj.find(".icon-open1").attr("style", "");
						formObj.find(".icon-open2").attr("style", "display:none;");
						formObj.find(".icon-open3").attr("style", "display:none;");
						formObj.find(".icon-open4").attr("style", "display:none;");
					}else if(state2 == "N"){
						formObj.find(".icon-open1").attr("style", "display:none;");
						formObj.find(".icon-open2").attr("style", "");
						formObj.find(".icon-open3").attr("style", "display:none;");
						formObj.find(".icon-open4").attr("style", "display:none;");
					}else if(state2 == "X"){
						formObj.find(".icon-open1").attr("style", "display:none;");
						formObj.find(".icon-open2").attr("style", "display:none;");
						formObj.find(".icon-open3").attr("style", "");
						formObj.find(".icon-open4").attr("style", "display:none;");
					}else if(state2 == "C"){
						formObj.find(".icon-open1").attr("style", "display:none;");
						formObj.find(".icon-open2").attr("style", "display:none;");
						formObj.find(".icon-open3").attr("style", "display:none;");
						formObj.find(".icon-open4").attr("style", "");
					}
				}
				if(key2 =="srvYn" && srvIndex > -1){ //사용여부 판단    
					
					if(state2 =="Y"){                                                 
						formObj.find(".serviceYn").find("span").eq(srvIndex).removeClass("icon-no-service").addClass("icon-on");
					}else{
						formObj.find(".serviceYn").find("span").eq(srvIndex).removeClass("icon-no-service").addClass("icon-service");            
					} 
				}
				
				if(key2 == "openCd"){
					if(state2 == "DT002"){
						formObj.find("select[name=causeCd]").attr("disabled", "disabled");
						formObj.find("input[name=causeInfo]").attr("readonly", "readonly");	
					}
				}
				if(key2 == "dsId"){
						formObj.find("[name=dsId]").val(state2);
						formObj.find("button[name=dsSearch]").hide();
					
				}else if(key2 == "srvCd"){
					if(state2 == null){
						formObj.find("button[name=dsSearch]").show();
					}
				}else if(key2 == "apiRes"){
					if(state2 != null){
						formObj.find("[name=apiRes]").val(state2);
					}
				}else if(key2 == "sgrpCd"){
					if(state2 != null){
						formObj.find("[name=sgrpCd]").val(state2);
					}
				}else if(key2 == "metaCate"){
					formObj.find("[id="+state2+"]"+":checkbox[value='"+state2+"']").prop("checked",true);
				}
				else{
					if(formObj.find("[name="+key2+"]").attr("type") == 'radio'){          
						formObj.find("[name="+key2+"]"+":radio[value='"+state2+"']").prop("checked",true);                                                                          
					}else if(formObj.find("[name="+key2+"]").attr("type") == 'checkbox'){          
						formObj.find("[name="+key2+"]"+":checkbox[value='"+state2+"']").prop("checked",true); 
					}else{  
						formObj.find("[name="+key2+"]").val(state2).change();
					}
				}
			});
		});    
	}
	//var objTab = getTabShowObj();//탭이 oepn된 객체가져옴
 	//var formObj = objTab.find("form[name=adminOpenInf]");    
	//formObj.find("a[name=a_import]").remove();
	//setTabButton();
}


function importCallBack(tab, json){
	var objTab = getTabShowObj();
	var formObj = objTab.find("form[name=adminStatService]");
	$.each(tab.DATA,function(key,state){
		if (formObj.find("input:checkbox[name="+key+"]").attr("type") == 'checkbox') {
			if ( state == "Y" ) {
				formObj.find("input:checkbox[name="+key+"]").prop("checked",true);
			} else {
				formObj.find("input:checkbox[name="+key+"]").prop("checked",false);
			}
		} 
		if( key == "infId"){
			formObj.find("input[name=infId]").val("");
		} else {
			formObj.find("[name="+key+"]").val(state);
		}
		
	});
}

function saveCheck(formObj){
	if( formObj.find('select[name=openCd]').val() == "DT003" || formObj.find('select[name=openCd]').val() == "DT004"){
 		if( formObj.find('select[name=causeCd]').val() == "" ){
 			alert("개방여부가 개방이 아닐 경우 미(부분)개방사유 선택은 필수입니다. ");
 			return false;
 		}	
	}
	var cateIdTop = formObj.find("input[name=cateIdTop]").val();
	if(cateIdTop == "KOR"){
		formObj.find("input[name=korYn]").val("Y");
		formObj.find("input[name=engYn]").val("N");
		formObj.find("input[name=korMobileYn]").val("N");
	}else if(cateIdTop == "ENG"){
		formObj.find("input[name=engYn]").val("Y");
		formObj.find("input[name=korYn]").val("N");
		formObj.find("input[name=korMobileYn]").val("N");
	}else if(cateIdTop == "MOB"){
		formObj.find("input[name=korMobileYn]").val("Y");
		formObj.find("input[name=engYn]").val("N");
		formObj.find("input[name=korYn]").val("N");
	}
	
	return true;
}






function tabEvent(row){	//탭 이벤트 실행                
	var title = mySheet.GetCellValue(row,"infNm");//탭 제목      
	var id = mySheet.GetCellValue(row,"infId");//탭 id(유일해야함))     
    openTab.SetTabData(mySheet.GetRowJson(row));//db data 조회시 조건 data
    var url = "<c:url value='/admin/monitor/statServiceList.do'/>"; // Controller 호출 url
    openTab.addTab(id,title,url,tabInfCallBack); // 탭 추가 시작함
}



function typeIndex(srvCd){          
	var srvIndex = -1
	switch(srvCd)                    
	{          
		    
		case "S":      
			srvIndex = 0;
			break;
		case "C":      
			srvIndex = 1;
			break; 
		case "M":      
			srvIndex = 2;
			break; 
		case "L":      
			srvIndex = 3;
			break; 
		case "F":      
			srvIndex = 4;
			break; 
		case "A":      
			srvIndex = 5;
			break;    
		case "V":      
			srvIndex = 6;
			break;  
	}
	return srvIndex;
}

function regUserFunction(){		// 등록callback
	var objTab = getTabShowObj();//탭이 oepn된 객체가져옴
 	var formObj = objTab.find("form[name=adminStatService]");    
 	formObj.find("a[name=a_view]").remove();
 	formObj.find("button[name=dsInfo]").remove();  
// 	formObj.find("input:checkbox[name=korYn]").attr("checked",true);		// 디폴트 게시위치 한글
	formObj.find("select[name=openCd]").val("DT002");		// 디폴트 적재주기 개방
	formObj.find("select[name=causeCd]").val("DS000");		 
	formObj.find("select[name=causeCd]").attr("disabled", "disabled");
	formObj.find("input[name=causeInfo]").attr("readonly", "readonly");	
//  	formObj.find("input[name=usrNm]").val('솔직원1(나중에 수정..)');
}

function viewPop(srvCd){
	var classObj = $("."+"content").eq(1); 
	//var objTab = getTabShowObj();//탭이 oepn된 객체가져옴
 	var formObj = classObj.find("form[name=adminStatService]");     
	var infId = formObj.find("input[name=infId]").val();       
	var apiRes = formObj.find("input[name=apiRes]").val();       
	var sgrpCd = formObj.find("input[name=sgrpCd]").val();       
	var data = "";
	if(srvCd == "F"){
		data = "&popupUse=Y";
	}else if(srvCd == "A"){
		data = "&popupUse=Y&apiRes="+apiRes;
	}else if(srvCd == "C"){
		data = "&sgrpCd="+sgrpCd
	}
	var target = "<c:url value='/admin/service/openInfColViewPopUp.do?infId="+infId+"&srvCd="+srvCd+""+data+" '/>";
	var wName = "colview"        
	var wWidth = "1024"
	var wHeight = "768"                            
	var wScroll ="no"
	OpenWindow(target, wName, wWidth, wHeight, wScroll);       
}

function setTabButton(){		//버튼event
/* 	var objTab = getTabShowObj();//탭이 oepn된 객체가져옴
 	var formObj = objTab.find("form[name=adminOpenInf]"); */     
 	
 	//var classObj = $("."+"content_dt"); //tab으로 인하여 form이 다건임
 	var classObj = $("."+"content").eq(1); //tab으로 인하여 form이 다건임
	var formObj = classObj.find("form[name=adminOpenInf]");
	var formObjImg = classObj.find("form[name=adminImgForm]");
 	
 	formObj.find("input, textarea").placeholder();
 	/* datepickerInitTab(formObj.find("input[name=openDttm]")); //초기화
	formObj.find("input[name=openDttm]").datepicker(setCalendar());    
	datepickerTrigger();  */    
	
 	/* formObj.find("[name=T]").click(function() {		// TsSheet미리보기
 		if(!formObj.find("[name=T]").hasClass("icon-no-service")){
 			viewPop('T');
 		}
 		return false;                 
 	}); */
 	formObj.find("[name=S]").click(function() {		//rawSheet미리보기
 		if(!formObj.find("[name=S]").hasClass("icon-no-service")){
 			viewPop('S');
 		}
 		return false;                 
 	});
 	formObj.find("[name=M]").click(function() {		//map미리보기
 		if(!formObj.find("[name=M]").hasClass("icon-no-service")){
 			viewPop('M');
 		}
 		return false;                 
 	});
 	formObj.find("[name=L]").click(function() {		//link미리보기
 		if(!formObj.find("[name=L]").hasClass("icon-no-service")){
 			viewPop('L');
 		}  
 		return false;                 
 	});
 	formObj.find("[name=F]").click(function() {		//file미리보기
 		if(!formObj.find("[name=F]").hasClass("icon-no-service")){
 			viewPop('F');
 		}  
 		return false;                 
 	});
 	formObj.find("[name=C]").click(function() {		//chart미리보기
 		if(!formObj.find("[name=C]").hasClass("icon-no-service")){
 			viewPop('C');
 		}     
 		return false;                 
 	});
 	formObj.find("[name=A]").click(function() {		//openAPI미리보기
 		if(!formObj.find("[name=A]").hasClass("icon-no-service")){
 			viewPop('A');
 		}     
 		return false;                 
 	});
 	formObj.find("[name=V]").click(function() {		//MultiMedia 미리보기
 		if(!formObj.find("[name=A]").hasClass("icon-no-service")){
 			viewPop('V');
 		}     
 		return false;                 
 	});

	
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
 	
 	
 	
 	formObj.find("button[name=dtSearch]").click(function() {		// 보유데이터 팝업
 		var url="<c:url value="/admin/openinf/opends/popup/openDt_pop.do"/>" + "?index=1";
		var popup = OpenWindow(url,"OpenInfdtPop","700","550","yes");	       
 		return false;    
 	});
 	
 	formObj.find("button[name=cateSearch]").click(function() {		// 분류명 팝업
 		var url = "<c:url value="/admin/opendt/openCateParListPopUp.do"/>" + "?cateGb=3&index=1";
		var popup = OpenWindow(url,"openCateParListPopUp","750","550","yes");	
		popup.focus();
 		return false;    
 	});
 	
 	formObj.find("button[name=cateSearch2]").click(function() {		// 분류명 팝업
 		
 		var cateId = formObj.find("input[name=cateId]").val();
 		
 		if(cateId == ""){
 			alert("먼저 분류1의 값을 넣어주세요");
 			return false;
 		}
 		
 		var url = "<c:url value="/admin/opendt/openCateParListPopUp.do"/>" + "?cateGb=4&index=1";
		var popup = OpenWindow(url,"openCateParListPopUp","750","550","yes");	
		popup.focus();
		
		var cateId2 = formObj.find("input[name=cateId2]").val();
		
		if(cateId == cateId2){
			alert("분류1의 값과 분류2의 값이 같으면 안됩니다.");
			formObj.find("input[name=cateId2]").val("");
			formObj.find("input[name=cateNm2]").val("");
			return false;
		}
		
 		return false;    
 	});
 	
 	formObj.find("button[name=dsSearch]").click(function() {		// 데이터셋 팝업
 		getDtId();
 		if(dtId == ""){
 			alert("보유데이터를 먼저 선택해주세요.");
 		}else{
	 		var url="<c:url value="/admin/openinf/popup/openInfDs_pop.do"/>" + "?dtId="+dtId + "&index=1";
			var popup = OpenWindow(url,"OpenInfdsPop","700","550","yes");	       
 		}
 		return false;    
 	});
 	
 	formObj.find("button[name=dsInfo]").click(function() {		// 데이터셋정보팝업
		var dsId = formObj.find("input[name=dsId]").val();                  
 		if(dsId == ""){
 			alert("데이터셋을 먼저 선택해주세요.");
 		}else{
 			var target = "<c:url value="/admin/openinf/opends/popup/opends_samplePop.do"/>";
 			var wName = "samplePop"        
 			var wWidth = "1024"
 			var wHeight = "580"                            
 			var wScroll ="no"
 			OpenWindow(target+"?dsId="+dsId, wName, wWidth, wHeight, wScroll);      
 		}
 		return false;    
 	});
 	formObj.find("button[name=usrSearch]").click(function() {		// 직원명 팝업
 		var orgCd = formObj.find("[name=orgCd]").val();   
 		if(orgCd == ""){
 			alert("담당조직을 먼저 선택해주세요.");
 			return false;
 		}
		var url = "<c:url value="/admin/basicinf/popup/commUsr_pop.do"/>" + "?usrGb=3&orgCd="+orgCd; 
		var popup = OpenWindow(url,"usrPop","500","550","yes");	        
 		return false;    
 	});
 	
 	formObj.find("select[name=openCd]").change(function(){
 		var openCdVal = formObj.find("select[name=openCd]").val();
 		if(openCdVal == "DT002"){
 			formObj.find("select[name=causeCd]").val("DS000");	
 			formObj.find("select[name=causeCd]").attr("disabled", "disabled");
 			formObj.find("input[name=causeInfo]").attr("readonly", "readonly");
 		}else{
 			formObj.find("select[name=causeCd]").removeAttr("disabled");
 			formObj.find("input[name=causeInfo]").removeAttr("readonly", "readonly");
 		}
 		return false;
 	});
 	
 	/* formObj.find("button[name=orgNm]").click(function(){		// 조직 추가 팝업
 		var mySheet2 = formObj.find("[name=mySheet2]").val();
 		var url="<c:url value="/admin/basicinf/popup/commOrg_pop.do"/>" + "?orgNmGb=7&sheetNm=mySheet2"; 
		var popup = OpenWindow(url,"orgPop","500","550","yes");	            
 	}); 
 	 */
 	formObj.find("a[name=a_import]").click(function(){		//불러오기
 		var url="<c:url value="/admin/openinf/popup/existOpenInfPop.do"/>";
		var popup = OpenWindow(url,"existOpenInfPop","900","550","yes");	 
 		return false;
 	});
 	
 	formObj.find("a[name=a_view]").click(function() {		// 미리보기
 		doTabAction("view");          
 		return false;                 
 	});
 	
 	formObj.find("textarea[name=infExp]").keyup(function(e) {         	//한글설명 글자수제한          
 		CheckMaxString(formObj.find("textarea[name=infExp]"), 4000, "kor");
 		return false;                                                                          
 	});
 	
 	formObj.find("textarea[name=infExpEng]").keyup(function(e) {         	//영문설명 글자수제한          
 		CheckMaxString(formObj.find("textarea[name=infExpEng]"), 4000, "eng");
 		return false;                                                                          
 	});
 	
 	formObj.find("textarea[name=loadDesc]").keyup(function(e) {         	//공표설명 글자수제한          
 		CheckMaxString(formObj.find("textarea[name=loadDesc]"), 1000, "kor");
 		return false;                                                                          
 	});
 	
	formObj.find("input[name=infNmEng]").keyup(function(e) {        
		ComInputEngEtcObj2(formObj.find("input[name=infNmEng]"));    
		 return false;                                                                          
	 });  
	
	formObj.find("input[name=infTagEng]").keyup(function(e) {
		ComInputEngBlankComObj(formObj.find("input[name=infTagEng]"));    
		return false;                                                                          
	 }); 
	
	
	formObj.find("button[name=orgAdd]").click(function() {
		mySheet2.DataInsert(0);
	});
	
	formObj.find("a[name=a_init]").click(function() {
 		doTabAction("init");          
 		return false;                 
 	});
	
	//img 관련 기능 구현
	formObjImg.find("button[name=btn_init]").click(function(e){		
		
		doActionImg("init");
		
		return false;		
	});
	
	formObjImg.find("button[name=btn_add]").click(function(){		//이미지 추가
		
		doActionImg("add");  
		return false;		
	});
	
	formObjImg.find("a[name=a_del]").click(function(){		//이미지 추가
		
		doActionImg("delete");  
		return false;		
	});
	
}





function CheckMaxString(obj, maxNum, ver){
	var ls_str = obj.val();
	var li_str_len = ls_str.length;
	var li_max = maxNum;
	var i =0;
	var li_byte = 0;
	var li_len = 0;
	var ls_one_char = "";
	var ls_str2 = "";
	for(i=0; i<li_str_len; i++){
		ls_one_char = ls_str.charAt(i);
		if(escape(ls_one_char).length > 4 ) {
			li_byte += 2;
		}else{
			li_byte++;
		}
		if(li_byte <= li_max){
			li_len = i+1;
		}
	}
	if(ver == "eng"){
		obj.css("ime-mode","disabled");
		strb = obj.val().toString();   
		strb = strb.replace(/[ㄱ-ㅎ가-힣]/g, '');
		obj.val(strb);
	}
	
	if(li_byte > li_max){
		alert(maxNum+"Byte를 초과할 수 없습니다.");
		ls_str2 = ls_str.substr(0, li_len);
		obj.val(ls_str2);
	}
	obj.focus();
}

function getDtId(){
	var objTab = getTabShowObj();//탭이 oepn된 객체가져옴
 	var formObj = objTab.find("form[name=adminStatService]");    
	dtId = formObj.find("input[name=dtId]").val();
}


// 마우스 이벤트
function mySheet_OnSearchEnd(code, msg)
{
   if(msg != "")
	{
	    alert(msg);
    }
}

//마우스 이벤트
function OnSaveEnd()
{
	doAction("search");     
}           

function inputEnterKey(){
	$("input").keypress(function(e) {
		  if(e.which == 13) {
			  doAction('search');   
			  return false;
		  }
	});
}           


/* function formSubmit(urls, param, CallBack) {
    var params = jQuery("#adminOpenInf").serialize(); // serialize() : 입력된 모든Element(을)를 문자열의 데이터에 serialize 한다.
    jQuery.ajax({
        url: '/admin/openinf/openInfReg.do',
        type: 'POST',
        data:params,
        contentType: 'application/x-www-form-urlencoded; charset=UTF-8', 
        dataType: 'html',
        success: CallBack,
        error:function(request,textStatus){
        	 if(request.status == 9999){                
        		 $("form").eq(0).attr("action",getContextPath+"/admin/admin.do").submit();
        	 }else{
        		 alert('에러발생...' + textStatus);
        	 }
         }
    });
} */
                   
          
//]]> 
</script>
</head>
<body onload="">
	<div class="wrap">
		<c:import url="/admin/admintop.do" />
		<!--##  메인  ##-->
		<div class="container">
			<!-- 상단 타이틀 -->
			<div class="title">
				<h2>${MENU_NM}</h2>
				<p>${MENU_URL}</p>
			</div>
			<!-- 탭 -->
			<!-- <ul class="tab">
				<li class="all_list"><a href="#">전체목록</a></li>
			</ul> -->
			<div class="more_list" style="display: none">
				<a href="#" class="more">0</a>
				<ul class="other_list" style="display: none;">
					<li><a href="#">보유데이터목록</a><a href="#" class="line_close">x</a></li>
					<li><a href="#">공공데이터목록asdfsdfsfsdfsdfsdf</a><a href="#"
						class="line_close">x</a></li>
				</ul>
			</div>

			<!-- 목록내용 -->
			<div class="content">
				<form name="adminStatServiceSearch" method="post" action="#">
					<table class="list01">
						<caption>데이터셋 관리</caption>
						<colgroup>
							<col width="10%" />
							<col width="25%" />
							<col width="10%" />
							<col width="25%" />
							<col width="10%" />
							<col width="30%" />
						</colgroup>
						
						<tr>
							<th><label class=""><spring:message
										code="labal.cateNm" /></label></th>
							<td colspan="5"><input type="hidden" name="cateId" value="" /> <input
								type="text" name="cateNm" readonly="readonly" />
								<button type="button" class="btn01" name="btn_search">
									<spring:message code="btn.search" />
								</button>

								<button type="button" class="btn01" name="btn_init">초기화</button>
							</td>
						</tr>
						<tr>
							<th><spring:message code="labal.search" /></th>
							<td colspan="5"><select name="searchWd">
									<option value="0">공공데이터명</option>
									<option value="1">보유데이터명</option>
									<option value="2">태그명</option>
							</select> <input name="searchWord" type="text" value=""
								style="width: 240px" />
								<button type="button" class="btn01B" name="btn_search">
									<spring:message code="btn.inquiry" />
								</button>
								<button type="button" class="btn01LD" name="xlsDown" >
									일괄 다운로드
							</button></td>
						</tr>
					</table>


					<!-- ibsheet 영역 -->
					<div style="clear: both;"></div>
					<div class="ibsheet_area_both">
						<script type="text/javascript">createIBSheet("mySheet", "100%", "300px"); </script>
					</div>
				</form>

			</div>

			<!----------------------------------------------- 탭 내용 -------------------------------------------------------------->

			<div class="content" style="clear: both;">				
			<form name="adminStatDate" method="post" action="#">
				<table class="list01" style="position: relative;">
				<h3 class="text-title2">메타정보
				</h3>
				
				<colgroup>
							<col width="150" />
							<col width="" />
							<col width="150" />
							<col width="" />
				</colgroup>
				<tr>
							<th><label class="">기간</label></th>
							<td colspan="3">
								<input type="text" name="startDttm" value="" readonly="readonly"/>
								<input type="text" name="endDttm" value="" readonly="readonly"/>
								<button type="button" class="btn01" name="btn_search">
									조회
								</button>
								<button type="button" class="btn01LD" name="xlsDown" >
									보고서 다운로드
							</button>
							</td>
						</tr>
				</table>
				</form>
				<form name="adminStatService" method="post" action="#">
					<input type="hidden" name="apiRes" />
					<input type="hidden" name="sgrpCd" />
					<input type="hidden" name="korYn" value="N" />
					<input type="hidden" name="engYn" value="N" />
					<input type="hidden" name="korMobileYn" value="N" />
					<table class="list01" style="position: relative;">
						<caption>공공데이터목록리스트</caption>
						<colgroup>
							<col width="150" />
							<col width="" />
							<col width="150" />
							<col width="" />
							

						</colgroup>
						
						<tr>
							<th><label class=""><spring:message
										code="labal.dsNm" /></label></th>
							<input type="hidden" name="seq" />
							<input type="hidden" name="existinfId" />
							<td><input type="text" name="infNm" value=""
								placeholder="CCTV 현황" readonly class="readonly" size="50" /></td>


							<th><label class=""><spring:message
										code="labal.branchOrganization" /></label></th>
							<td>
							<input type="text" name="topCateNm" style="width: 30%"
								maxlength="160" readonly class="readonly" value="재난안전" /> <span class="icon-open1"
								style="display: none;"><label class=""><spring:message
											code="labal.infStateY" /></span> <!-- 개방 --> 
							</td>

						</tr>

						<tr>
							<th><label class="">내용</label></th>
							<td colspan="3"><input type="text" name="infExp" style="width: 100%" readonly class="readonly" value="경기도내에 설치되어 있는 CCTV 정보(관리기관명, 위치, 설치목적, 카메라 대수, 촬영방면정보 등) 제공">
							</td>

						</tr>
						<tr>
							<th><label class=""><spring:message
										code="labal.infTag" /></label></th>
							<td colspan="3"><input type="text" name="infTag" style="width: 100%;"
								readonly class="readonly"  value="CCTV, 무인카메라, 카메라, 영상보관일수, 생활방범CCTV, 차량방범CCTV, 어린이보호CCTV, 쓰레기단속CCTV, 시설물관리CCTV, 재난재해CCTV, 교통단속CCTV, 교통정보수집CCTV, 다목적CCTV"/> <!-- (영) <input type="text" name="infTagEng" style="width:35%;" maxlength="160"/> -->
							</td>
						</tr>
						
						<tr>
							<th><label class="">DATA 개방일</label></th>
							<td><input type="text" name="openDttm" size="35" 
								readonly class="readonly"  value="2015-09-18"/></td>
							
							<th><label class="">최종수정일</label></th>
							<td><input type="text" name="loadNm" size="35" value="2016-09-01"
								readonly class="readonly" /></td>
						</tr>
						
						
						<tr>
						
							<th><label class=""><spring:message
										code="labal.provideOrg" /></label> </th>
							<td><input type="text" name="orgNm" size="35" value="경기도"
								readonly class="readonly" /></td>
								
							<th><label class=""><spring:message
										code="labal.useDeptNm" /></label> </th>
							<td><input type="text" name="useDeptNm" style="width: 35%"
								maxlength="160" readonly class="readonly" /> 
							</td>
							
						</tr>
						
						
						<tr>
							<th><label class=""><spring:message
											code="labal.srcExp"/></label></th>
							<td><input type="text" name="srcExp" size="35" value=""
								readonly class="readonly" /></td>
								
    						<th><label class="">갱신 주기</label></th>
							<td><input type="text" name="updatePeriod" size="35" value="수시"
								readonly class="readonly" /></td>
    				    </tr>
    				    
    				    <tr>
							<th><label class=""><spring:message
											code="labal.cclCd"/></label></th>
							<td> <input type="text" name="cclNm" size="35" value="상업적이용허용 및 콘텐츠변경허용" readonly class="readonly" />
							</td>
							
							<th><label class=""><spring:message
											code="labal.SRV_CNT"/></label></th>
							<td> <input type="text" name="srvCnt" size="35" value="Sheet, Map, Open API" readonly class="readonly" />
							</td>
							
    				    </tr>
    				    
						<tr>
							<th><label class="">개방데이터(건)</label></th>
							<td>
								<%-- <fmt:formatNumber value=”infCnt” groupingUsed=”true”/> --%>
								<input type="text" name="infCnt" size="35" value="21,197" readonly class="readonly" />
							</td>
							<th><label class="">평점 / 참여(명)</label></th>
							<td>
								<input type="text" name="appr" size="35" value="3.5 / 322" readonly class="readonly" />
							</td>
						</tr>

					</table>

					<!-- ibsheet 영역 -->
					<div style="width: 100%; float: left;">
						<div class="ibsheet-header">
							<h3 class="text-title2">조회현황</h3>							
							<th ><label class="" style="float: right">(건)</label></th>
							<input type="text" name="searchNum" style="float: right" readonly class="readonly" />										
						</div>
						<div class="ibsheet_area" style="clear: both;">
							<script type="text/javascript">createIBSheet("mySheet2", "100%", "100px"); </script>
						</div>
					</div>
					
					<div style="width: 100%; float: left;">
						<div class="ibsheet-header">
							<h3 class="text-title2">활용현황</h3>							
							<th ><label class="" style="float: right">(건)</label></th>		
							<input type="text" name="useNum" style="float: right" readonly class="readonly" />									
						</div>
						<div class="ibsheet_area" style="clear: both;">
							<script type="text/javascript">createIBSheet("mySheet3", "100%", "100px"); </script>
						</div>
					</div>
					
					<div style="width: 100%; float: left;">
						<div class="ibsheet-header">
							<h3 class="text-title2">주소데이터 품질 현황</h3>								
							<th ><label class="" style="float: right">(건)</label></th>			
							<input type="text" name="refNum" style="float: right" readonly class="readonly" />			
						</div>
						<div class="ibsheet_area" style="clear: both;">
							<script type="text/javascript">createIBSheet("mySheet4", "100%", "100px"); </script>
						</div>
					</div>

					<%-- <!-- ibsheet 영역 -->
				<div  style="width: 40%; float: right;">
					<div class="ibsheet-header">            
		          		<h3 class="text-title2">직원정보</h3>
		          		<button type="button" class="btn01" name="empAdd" style="float:right"><spring:message code="btn.add"/></button>
		          	</div>
					<div class="ibsheet_area" style="clear: both;">
						<script type="text/javascript">createIBSheet("mySheet3", "100%", "200px"); </script>             
					</div> 
				</div> --%>
					<div class="buttons">
						<%-- ${sessionScope.button.a_import} --%>
						<%--${sessionScope.button.a_init} ${sessionScope.button.a_reg}
						${sessionScope.button.a_modify}  ${sessionScope.button.a_del} --%>

						<%-- ${sessionScope.button.a_view} --%>
					</div>
					
					<!----------------------------------- IMG 처리 태그는 나중에........ 해제하면 이용 가능..... ------------------------------------>
					<%-- <form name="adminImgForm" method="post" action="#" enctype="multipart/form-data">
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
									${sessionScope.button.btn_init}
									</span>
									<button type="button" class="btn01" title="초기화" name="btn_init">초기화</button>
								<!-- <input type="text" name="viewFileNm" size="80" value="" /> (확장자제외) -->
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
						</form> --%>
					
				</form>






			</div>






		</div>
	</div>
</body>
<!--##  푸터  ##-->
<c:import url="/WEB-INF/jsp/admin/adminfooter.jsp" />
<!--##  /푸터  ##-->
</html>