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
<style type="text/css">

.gong{border-bottom:1px solid #c0cbd4;width:100%;min-width:1050px;} 
.gong td{border-top:none;border-bottom:none;padding:0;width:80px;}

</style>
</head>               
<script language="javascript">          
function tabSet(){ //탭 객체 생성  
	openTab = new OpenTab(tabId,tabContentClass,tabBody); //headinclude.jsp 변수 있음
	openTab.TabObj = openTab;  
	openTab.addTabClickEvent();    
}	        
$(document).ready(function()    {        
	tabSet();// tab 셋팅
	LoadPage();                                                               
	doAction('search');                                              
	setMainButton();
	setTabButton();		//탭 버튼
	setCssPubMWD();
	inputEnterKey();
	tabFunction();
});    

function setMainButton(){
	var formObj = $("form[name=adminOpenPubCfg]");
	formObj.find("button[name=btn_inquiry]").click(function(e) { //조회
		doAction("search");
		 return false;
	 });
	formObj.find("button[name=btn_reg]").click(function(e) { //등록
		doAction("reg");
		 return false;
	 });
	formObj.find("input[name=monthCheck]" ).change(function(e) {
		if(inputCheckYn("monthCheck") =="Y"){
			formObj.find("[name=pubTagMonth]").val("M");
			formObj.find("input[name=pubTagCheck]").val("Y");
		}else{
			formObj.find("[name=pubTagMonth]").val(null);
		}
	 });
	formObj.find("input[name=weekCheck]" ).change(function(e) {
		if(inputCheckYn("weekCheck") =="Y"){
			formObj.find("[name=pubTagWeek]").val("W");
			formObj.find("input[name=pubTagCheck]").val("Y");
		}else{
			formObj.find("[name=pubTagWeek]").val(null);
		}
	 });
	formObj.find("input[name=dayCheck]" ).change(function(e) {
		if(inputCheckYn("dayCheck") =="Y"){
			formObj.find("[name=pubTagDay]").val("D");
			formObj.find("input[name=pubTagCheck]").val("Y");
		}else{
			formObj.find("[name=pubTagday]").val(null);
		}
	 });
}

function LoadPage()                
{      
	//message-common_ko_KR.properties 선언 후 사용 or message-common_en_US.properties 선언 후 사용
	var gridTitle = "NO"
		gridTitle +="|"+"<spring:message code='labal.pubNm'/>";  
		gridTitle +="|"+"<spring:message code='labal.pubNm'/>";  
		gridTitle +="|"+"<spring:message code='labal.langTag'/>";        
		gridTitle +="|"+"<spring:message code='labal.pubTag'/>";        
		gridTitle +="|"+"<spring:message code='labal.dsNm'/>";        
		gridTitle +="|"+"<spring:message code='labal.orgNm'/>";        
		gridTitle +="|"+"<spring:message code='labal.startDttm'/>";        
		gridTitle +="|"+"<spring:message code='labal.useYn'/>";        
	
    with(mySheet){
    	                     
    	var cfg = {SearchMode:2,Page:50,VScrollMode:1};                                
        SetConfig(cfg);  
        var headers = [                                             
                    {Text:gridTitle, Align:"Center"}                 
                ];
        var headerInfo = {Sort:0,ColMove:1,ColResize:1,HeaderCheck:0};
        
        InitHeaders(headers, headerInfo); 
         
      	//문자는 왼쪽정렬
        //숫자는 오른쪽정렬
        //코드값은 가운데정렬
        var cols = [          
					 {Type:"Seq",		SaveName:"seq",				Width:30,	Align:"Center",		Edit:false}
					,{Type:"Text",		SaveName:"pubId",			Width:100,	Align:"Center",		Edit:false, Hidden:true}
					,{Type:"Text",		SaveName:"pubNm",			Width:100,	Align:"Left",		Edit:false}
					,{Type:"Text",		SaveName:"langTag",			Width:100,	Align:"Left",		Edit:false}
					,{Type:"Text",		SaveName:"pubTag",			Width:100,	Align:"Left",		Edit:false}
					,{Type:"Text",		SaveName:"dsNm",			Width:100,	Align:"Left",		Edit:false}
					,{Type:"Text",		SaveName:"orgNm",			Width:100,	Align:"Left",		Edit:false}
					,{Type:"Text",		SaveName:"startDttm",		Width:100,	Align:"Center",		Edit:false}
					,{Type:"CheckBox",	SaveName:"useYn",			Width:50,	Align:"Center",		Edit:true, TrueValue:"Y", FalseValue:"N", KeyField:false}
                ];       
                                      
        InitColumns(cols);                                                                           
        FitColWidth();                                                         
        SetExtendLastCol(1);   
    }               
    default_sheet(mySheet);                      
}      

/*Sheet 각종 처리*/                  
function doAction(sAction)                                  
{
	var classObj = $("."+tabContentClass); //tab으로 인하여 form이 다건임
	var actObj = setTabForm(classObj); // 0: form data, 1: form 객체
	switch(sAction)
	{          
		case "search":      //조회
			var formObj = $("form[name=adminOpenPubCfg]");
			if(validationCheckPubTag(formObj)){ // 조회시 공표주기를 한개이상 선택해야함
			return true;	
			}
			ajaxBeforeSendAdmin("<c:url value='/admin/ajaxBeforeSendAdmin.do'/>"); //IbSheet 조회전 세션 체크
			var param = {PageParam: "ibpage", Param: "onepagerow=50&"+formObj.serialize()};
			mySheet.DoSearchPaging("<c:url value='/admin/openinf/openpub/openPubCfgListAll.do'/>", param);   
			break;
		case "reg":      //등록화면                 
			var title = "공표기준등록"
			var id ="openPubCfgReg";
			openTab.addRegTab(id,title,tabCallRegBack); // 탭 추가 시작함
			break;
	}           
}   

function regUserFunction(){ //등록 callback에서 사용함
}

function doTabAction(sAction){
	var classObj = $("."+tabContentClass); //tab으로 인하여 form이 다건임
	var actObj = setTabForm(classObj); // 0: form data, 1: form 객체
	var objTab = getTabShowObj();//탭이 oepn된 객체가져옴
	var formObj = objTab.find("form[name=adminOpenPubCfgOne]");
	ajaxBeforeSendAdmin("<c:url value='/admin/ajaxBeforeSendAdmin.do'/>"); //IbSheet 조회전 세션 체크
	var orgCd = formObj.find("[name=orgCd]").val();
	switch(sAction){
		
		case "save":      //등록
			if(validationOne(formObj)) return;
			basisDo(formObj);	// 공표주기 값 셋팅
			var url = "<c:url value='/admin/openinf/openpub/openPubCfgReg.do'/>"; 
			var param = openTab.ContentObj.find("[name=adminOpenPubCfgOne]").serialize();
			ajaxCallAdmin(url, param, saveCallBack);
			break;  
		case "dup":   		// 중복 
			if(nullCheckValdation(formObj.find('input[name=refDsId]'),"<spring:message code='labal.refDsId'/>","")){
				return true;
			}
			var url = "<c:url value='/admin/openinf/openpub/openPubCfgRefDsCheckDup.do'/>"; 
			ajaxCallAdmin(url,actObj[0],dupCallBack);
			break;
		case "update":      //수정 
			if ( !confirm("수정 하시겠습니까? ") ) {
				return;
  			}
			if(validationOne(formObj)) return;
			if(confirmBeforeUpd()) return;
			basisDo(formObj);	// 공표주기 값 셋팅
			var url = "<c:url value='/admin/openinf/openpub/openPubCfgUpd.do'/>";
			var param = openTab.ContentObj.find("[name=adminOpenPubCfgOne]").serialize();
			ajaxCallAdmin(url, param, saveCallBack);
			break; 
		case "delete":      //삭제
			if ( !confirm("삭제 하시겠습니까? ") ) {
				return;
  			}
			 var url = "<c:url value='/admin/openinf/openpub/openPubCfgDel.do'/>"; 
			 var param = openTab.ContentObj.find("[name=adminOpenPubCfgOne]").serialize();
			 ajaxCallAdmin(url, param, saveCallBack);
			 break;
		case "selectRefColId" :		//공표기준 컬럼 selectBox setting
			var param = actObj[0];
			var url =  "<c:url value='/admin/openinf/openpub/selectRefColId.do'/>";
			ajaxCallAdmin(url, param, refColIdCallBack);
			break;
		case "popclose":              
			closeIframePop("iframePopUp");
			break;
		case "popDataSet":
			var url="<c:url value="/admin/openinf/opends/popup/openPubCfgRefDsPopUp.do"/>" + "?refDsIdGb=1";
			var popup = OpenWindow(url,"openPubCfgRefDsPopUpList","700","550","yes");
			popup.focus();
			break;
		case "popOrgNm":
			var url="<c:url value="/admin/basicinf/popup/commOrg_pop.do"/>" + "?orgNmGb=5";
			var popup = OpenWindow(url,"orgPop","550","550","yes");
			popup.focus();
			break;
		case "popUsrNm":
			var url="<c:url value="/admin/basicinf/popup/commUsr_pop.do"/>" + "?usrGb=1&orgCd="+orgCd;
			var popup = OpenWindow(url,"orgPop","550","550","yes");
			popup.focus();
			break;
	}
}

// 공표기준컬럼 selectBox Setting 콜백
function refColIdCallBack(json){
	var objTab = getTabShowObj();
	var formObj = objTab.find("form[name=adminOpenPubCfgOne]");
	var append = "<select id=refColId name=refColId>";
	append += "<span>주의 ) 대용량 데이터일 경우 기준컬럼의 인덱스를  생성하세요.</span>";
	if(json.DATA.refColIdList.length != 0){
	for(var i = 0; i < json.DATA.refColIdList.length; i++){
		append += "<option value="+json.DATA.refColIdList[i].srcColId;
		if(json.DATA.refColIdList.refColId == json.DATA.refColIdList[i].srcColId){	// 해당 공표기준의 공표기준 컬럼이 list의 공표기준 컬럼값과 같으면 selected 설정해줌
			append += " selected=selected";
		}
		append += ">"+json.DATA.refColIdList[i].srcColId+" : "+json.DATA.refColIdList[i].colNm+"</option>"; 
	}
	}else{
		append += "<option value=>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</option>";
	}
	append += "</select>";
	formObj.find("td[id=refColIdTd]").empty().append(append);
	
	
}

function tabFunction(){//tab callback에서 사용함
	var row = $("input[name=ibSheetRow]").val();
	var pubId = mySheet.GetCellValue(row,"pubId");
	var objTab = getTabShowObj();//탭이 oepn된 객체가져옴
	var formObj = objTab.find("form[name=adminOpenPubCfgOne]");
	formObj.find("button[name=btn_dup]").remove();	// 중복 버튼 삭제
	formObj.find("button[name=btn_search]").eq(0).css("display","none");	// 관련데이터셋 검색 버튼 hidden

 	// 공표주기 셋팅 - 등록인지 수정인지를 체크함
	if(formObj.find("[name=pubTagSetYn]").val() == "N"){
 		PubTagSetMod(formObj);   
 	}    
	
	if(formObj.find("input[name=autoYn]").val() == "Y"){	// 자동공표 여부
		formObj.find("input[name=autoYnCheck]").prop("checked",true);	
	}
	
	if(formObj.find("input[name=refDsId]").val() != ""){
 		doTabAction('selectRefColId');
 	}
}      

function mySheet_OnDblClick(row, col, value, cellx, celly) {
    if(row == 0) return;     
    tabEvent(row);                      
}  

function tabEvent(row){	//탭 이벤트 실행                    
	var title = mySheet.GetCellValue(row,"pubNm");//탭 제목      
	var id = mySheet.GetCellValue(row,"pubId");//탭 id(유일해야함))     
    openTab.SetTabData(mySheet.GetRowJson(row));//db data 조회시 조건 data
    var url = "<c:url value='/admin/openinf/openpub/openPubCfgOne.do'/>"; // Controller 호출 url
    openTab.addTab(id,title,url,tabCallBack); // 탭 추가 시작함
}

function typeIndex(srvCd){          
	var srvIndex = -1
	switch(srvCd)                    
	{          
		case "T":      
			srvIndex = 0;
			break;      
		case "S":      
			srvIndex = 1;
			break;
		case "C":      
			srvIndex = 2;
			break; 
		case "M":      
			srvIndex = 3;
			break; 
		case "L":      
			srvIndex = 4;
			break; 
		case "F":      
			srvIndex = 5;
			break; 
		case "A":      
			srvIndex = 6;
			break;                                   
	}
	return srvIndex;
}

function regUserFunction(){		// 등록callback
	    
}

function setTabButton(){		//버튼event
	var objTab = getTabShowObj();//탭이 oepn된 객체가져옴
 	var formObj = objTab.find("form[name=adminOpenPubCfgOne]");       
	formObj.find("input[name=startDttm]").datepicker(setCalendar());    
	datepickerTrigger();     
	
 	formObj.find("a[name=a_reg]").click(function() {		// 신규등록
 		doTabAction("save");          
 		return false;                 
 	});
 	formObj.find("button[name=btn_dup]").click(function(e) { //중복
		doTabAction("dup");        
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
 	
 	formObj.find("button[name=btn_search]").eq(0).click(function(){		// 관련 데이터셋 검색 팝업
 		doTabAction("popDataSet");          
 		return false;         	            
 	});
 	formObj.find("button[name=btn_search]").eq(1).click(function(){		// 담당 조직 검색 팝업
 		doTabAction("popOrgNm");          
 		return false;         	            
 	});
 	formObj.find("button[name=btn_search]").eq(2).click(function(){		// 담당자 검색 팝업
 		doTabAction("popUsrNm");          
 		return false;         	               
 	});     
 	   
 	formObj.find("input[name=pubNm]").keyup(function(e) {
 		ComInputKorObj(formObj.find("input[name=pubNm]"));
		 return false;
	 });
 	formObj.find("textarea[name=pubExp]").keyup(function(e) {
 		ComInputKorObj(formObj.find("textarea[name=pubExp]"));
		 return false;
	 });
 	
	formObj.find("textarea[name=pubNmEng]").keyup(function(e) {
		ComInputEngBlankObj(formObj.find("textarea[name=pubNmEng]"));
		 return false;
	 });
	formObj.find("input[name=pubExpEng]").keyup(function(e) {
		ComInputEngBlankObj(formObj.find("input[name=pubExpEng]"));
		 return false;
	 });
	
 	
 	
 	
 	formObj.find("input[name=autoYnCheck]" ).change(function(e) { // 자동공표 여부 설정
		if(inputCheckYn("autoYnCheck") =="Y"){
			formObj.find("[name=autoYn]").val("Y");   
		}else{
			formObj.find("[name=autoYn]").val("N");
		}
	 });
 	
 	// 공표주기 셋팅 - 등록인지 수정인지를 체크함
 	if(formObj.find("[name=pubTagSetYn]").val() != "N"){	// 등록탭
 		PubTagSetReg(formObj);
 	}
	
 	
 	
 	//공표주기 radio버튼 선택에 따라 display 설정
	formObj.find("input:radio[name=pubMWDSel]").click(function(){
		if($(this).val() =='M'){
			ShowBasisModeMW(formObj);
		}else if($(this).val() =='W'){								// 월, 주, 일 중 주 선택
			ShowBasisModeW(formObj);
		}else if($(this).val() =='D'){								// 월, 주 , 일 중 일 선택
			ShowBasisModeD(formObj);
		}
	});
	
	//공표주기에서 월 선택 후 주단위, 일단위 선택시 display 설정
	formObj.find("input:radio[name=pubTagWDUnit]").click(function(){
		if($(this).val() == "W"){										// 주단위 선택
			ShowBasisModeMW(formObj);
		}else if($(this).val() == "D"){									// 일단위 선택
			ShowBasisModeMD(formObj)
		}
	});		
	
	AllCheckBox(formObj);	//월,주,일 선택 시 전체체크 및 해제 
}

//공표주기에서 월전체,주전체,일전체 등을 체크했을때 전체 선택 및 해제등을 다룸
function AllCheckBox(formObj){
	var monthFlag = false;
	// 월전체 체크 변경시 월전체 체크 및 해제하기
	formObj.find("input:checkbox[name=monthAllCheck]").change(function(e) {
		if(!monthFlag){
			formObj.find("input:checkbox[name=pubMonth]").prop("checked",true);
			monthFlag =true;
		}else{
			formObj.find("input:checkbox[name=pubMonth]").prop("checked",false);
			monthFlag =false;
		}
	 });
	
	// 월 체크시 월전체  체크 및 해제
	formObj.find("input:checkbox[name=pubMonth]").change(function(e){
		if(formObj.find("input:checkbox[name=pubMonth]:checked").length == 12){
			formObj.find("input:checkbox[name=monthAllCheck]").prop("checked",true);
			monthFlag =true;
		}else{
			formObj.find("input:checkbox[name=monthAllCheck]").prop("checked",false);
			monthFlag =false;
		}
	});
	
	var weekFlag = false;
	// 주전체 체크 변경시 주전체 체크 및 해제하기
	formObj.find("input:checkbox[name=weekAllCheck]").change(function(e) {
		if(!weekFlag){
			formObj.find("input:checkbox[name=pubWeek]").prop("checked",true);
				weekFlag =true;
		}else{
			formObj.find("input:checkbox[name=pubWeek]").prop("checked",false);
				weekFlag =false;
		}
	 });
	
	// 주 체크시 주전체  체크 및 해제
	formObj.find("input:checkbox[name=pubWeek]").change(function(e){
		if(formObj.find("input:checkbox[name=pubWeek]:checked").length == 5){
			formObj.find("input:checkbox[name=weekAllCheck]").prop("checked",true);
			weekFlag =true;
		}else{
			formObj.find("input:checkbox[name=weekAllCheck]").prop("checked",false);
			weekFlag =false;
		}
	});
	
	var weeksFlag = false;
	// 요일전체 체크 변경시 요일전체 체크 및 해제하기
	formObj.find("input:checkbox[name=weeksAllCheck]").change(function(e) {
		if(!weeksFlag){
			formObj.find("input:checkbox[name=pubWeeks]").prop("checked",true);
				weeksFlag =true;
		}else{
			formObj.find("input:checkbox[name=pubWeeks]").prop("checked",false);
				weeksFlag =false;
		}
	 });
	
	// 요일 체크시 요일전체  체크 및 해제
	formObj.find("input:checkbox[name=pubWeeks]").change(function(e){
		if(formObj.find("input:checkbox[name=pubWeeks]:checked").length == 7){
			formObj.find("input:checkbox[name=weeksAllCheck]").prop("checked",true);
			weeksFlag =true;
		}else{
			formObj.find("input:checkbox[name=weeksAllCheck]").prop("checked",false);
			weeksFlag =false;
		}
	});
	
	var dayFlag = false;
	// 일전체 체크 변경시 일전체 체크 및 해제하기
	formObj.find("input:checkbox[name=dayAllCheck]").change(function(e) {
		if(!dayFlag){
			formObj.find("input:checkbox[name=pubDay]").prop("checked",true);
			dayFlag =true;
		}else{
			formObj.find("input:checkbox[name=pubDay]").prop("checked",false);
			dayFlag =false;
		}
	 });
	
	// 일 체크시 일전체  체크 및 해제
	formObj.find("input:checkbox[name=pubDay]").change(function(e){
		if(formObj.find("input:checkbox[name=pubDay]:checked").length == 32){
			formObj.find("input:checkbox[name=dayAllCheck]").prop("checked",true);
			dayFlag =true;
		}else{
			formObj.find("input:checkbox[name=dayAllCheck]").prop("checked",false);
			dayFlag =false;
		}
	});
}
//공표주기 기본 셋팅	등록 탭에서 사용 - 기본적으로 월기준-주단위를 보여줌
function PubTagSetReg(formObj){	
	formObj.find("table[name=pubWeekDayTable]").css("display","block");
	formObj.find("table[name=pubMonthTable]").css("display","block");
	formObj.find("table[name=pubWeekTable]").css("display","block");
	formObj.find("table[name=pubWeeksTable]").css("display","block");
	formObj.find("table[name=pubDayTable]").css("display","none");
	formObj.find("table[name=pubDayTr2]").css("display","none");
	formObj.find("table[name=pubDayTr3]").css("display","none");
	formObj.find("input[name=basisMode]").val("MW");
	
}

//공표주기 기본 셋팅	수정탭에서 사용
function PubTagSetMod(formObj){
	if(formObj.find("input[name=basisMode]").val() == "MW"){
		formObj.find("input:radio[name=pubMWDSel]").eq(0).prop("checked",true);
		formObj.find("input:radio[name=pubTagWDUnit]").eq(0).prop("checked",true);
		ShowBasisModeMW(formObj);
	}
	if(formObj.find("input[name=basisMode]").val() == "MD"){
		formObj.find("input:radio[name=pubMWDSel]").eq(0).prop("checked",true);
		formObj.find("input:radio[name=pubTagWDUnit]").eq(1).prop("checked",true);
		ShowBasisModeMD(formObj);
	}
	if(formObj.find("input[name=basisMode]").val() == "W"){
		formObj.find("input:radio[name=pubMWDSel]").eq(1).prop("checked",true);
		ShowBasisModeW(formObj);
	}
	if(formObj.find("input[name=basisMode]").val() == "D"){
		formObj.find("input:radio[name=pubMWDSel]").eq(2).prop("checked",true);
		ShowBasisModeD(formObj);
	}
	
	var mm = formObj.find("input[name=basisMm]").val();
	var mmarr = [];
	for(var i=0;i<mm.length;i++){
		mmarr[i] = mm.substring(i,i+1);
	}       
	formObj.find("input:checkbox[name=pubMonth]").each(function(index){
			if(mmarr[index] == "Y"){
				formObj.find("input:checkbox[name=pubMonth]").eq(index).prop("checked",true);
			}else if(mmarr[index] == "N"){
				formObj.find("input:checkbox[name=pubMonth]").eq(index).prop("checked",false);
			}
	});
	
	var wk = formObj.find("input[name=basisWk]").val();
	var wkarr = [];
	for(var i=0;i<wk.length;i++){
		wkarr[i] = wk.substring(i,i+1);
	}
	formObj.find("input:checkbox[name=pubWeek]").each(function(index){
			if(wkarr[index] == "Y"){
				formObj.find("input:checkbox[name=pubWeek]").eq(index).prop("checked",true);
			}else if(wkarr[index] == "N"){
				formObj.find("input:checkbox[name=pubWeek]").eq(index).prop("checked",false);
			}
	});
	
	var wd = formObj.find("input[name=basisWd]").val();
	var wdarr = [];
	for(var i=0;i<wd.length;i++){
		wdarr[i] = wd.substring(i,i+1);
	}
	formObj.find("input:checkbox[name=pubWeeks]").each(function(index){
			if(wdarr[index] == "Y"){
				formObj.find("input:checkbox[name=pubWeeks]").eq(index).prop("checked",true);
			}else if(wdarr[index] == "N"){
				formObj.find("input:checkbox[name=pubWeeks]").eq(index).prop("checked",false);
			}
	});
	
	var dd = formObj.find("input[name=basisDd]").val();
	var ddarr = [];
	for(var i=0;i<dd.length;i++){
		ddarr[i] = dd.substring(i,i+1);
	}
	formObj.find("input:checkbox[name=pubDay]").each(function(index){
			if(ddarr[index] == "Y"){
				formObj.find("input:checkbox[name=pubDay]").eq(index).prop("checked",true);
			}else if(ddarr[index] == "N"){
				formObj.find("input:checkbox[name=pubDay]").eq(index).prop("checked",false);
			}
	});
	
	// 공표주기의 라디오,체크박스 모두 셋팅한 후에 해당 hidden값들을 모두 초기화함 - 어차피 등록할때에 체크된 것에 따라서 값이 다시 입력됨
	formObj.find("input[name=basisMm]").val(null);
	formObj.find("input[name=basisWk]").val(null);
	formObj.find("input[name=basisWd]").val(null);
	formObj.find("input[name=basisDd]").val(null);
}

//공표주기에서 선택한 값들을 DB에 넘기기 전에 해당 변수에 입력하기
function basisDo(formObj){	
	var basisMmTmp,basisMm,basisDdTmp,basisDd,basisWkTmp,basisWk,basisWdTmp,basisWd;
	
	//월선택 값 입력
	formObj.find("input:checkbox[name=pubMonth]").each(function(index){
		formObj.find("input:checkbox[name=pubMonth]").val("N");
		formObj.find("input:checkbox[name=pubMonth]:checked").val("Y");
		basisMmTmp += formObj.find("input:checkbox[name=pubMonth]").eq(index).val();
		});
		basisMm = basisMmTmp.substring(9,21);	// 앞에 undefined가 뜨기 때문에 9부터 시작함
	
	//주선택 값 입력
	formObj.find("input:checkbox[name=pubWeek]").each(function(index){
		formObj.find("input:checkbox[name=pubWeek]").val("N");
		formObj.find("input:checkbox[name=pubWeek]:checked").val("Y");
		basisWkTmp += formObj.find("input:checkbox[name=pubWeek]").eq(index).val();
		});
		basisWk = basisWkTmp.substring(9,14);	// 앞에 undefined가 뜨기 때문에 9부터 시작함
	//요일선택 값 입력
	formObj.find("input:checkbox[name=pubWeeks]").each(function(index){
		formObj.find("input:checkbox[name=pubWeeks]").val("N");
		formObj.find("input:checkbox[name=pubWeeks]:checked").val("Y");
		basisWdTmp += formObj.find("input:checkbox[name=pubWeeks]").eq(index).val();
		});
		basisWd = basisWdTmp.substring(9,16);	// 앞에 undefined가 뜨기 때문에 9부터 시작함
		
	//일선택 값 입력
	formObj.find("input:checkbox[name=pubDay]").each(function(index){
		formObj.find("input:checkbox[name=pubDay]").val("N");
		formObj.find("input:checkbox[name=pubDay]:checked").val("Y");
		basisDdTmp += formObj.find("input:checkbox[name=pubDay]").eq(index).val();
		});
		basisDd = basisDdTmp.substring(9,41);	// 앞에 undefined가 뜨기 때문에 9부터 시작함

		//basisMode를 기준으로 필요없는 값들은 모두 N으로 처리 ex) 월기준-주단위의 경우 basisDd의 값이 필요없으므로 모두 N으로 처리
	if(formObj.find("input[name=basisMode]").val()=="MW"){
		basisDd = "NNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNN";
	}
	if(formObj.find("input[name=basisMode]").val()=="MD"){
		basisWk = "NNNNN";
		basisWd = "NNNNNNN";
	}
	if(formObj.find("input[name=basisMode]").val()=="W"){
		basisMm = "NNNNNNNNNNNN";
		basisDd = "NNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNN";
	}
	if(formObj.find("input[name=basisMode]").val()=="D"){
		basisMm = "YYYYYYYYYYYY";
		basisWk = "YYYYY";
		basisWd = "YYYYYYY";
		basisDd = "YYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYY";
	}
	formObj.find("input[name=basisMm]").val(basisMm);
	formObj.find("input[name=basisWk]").val(basisWk);
	formObj.find("input[name=basisWd]").val(basisWd);
	formObj.find("input[name=basisDd]").val(basisDd);
	
	var basisMode = formObj.find("input[name=basisMode]").val();
	formObj.find("input[name=pubTag]").val(basisMode.substring(0,1));
}

// 해당 basisMode에 따라 공표주기의 view를 달리함
function ShowBasisModeMW(formObj){
	formObj.find("table[name=pubWeekDayTable]").css("display","block"); // 월, 주, 일 중 월 선택
	formObj.find("input:radio[id=pubTagWeekUnit]").prop("checked",true);	// 월기준 선택하면 월기준-주단위를 기본으로 보이게함
	formObj.find("table[name=pubMonthTable]").css("display","block");
	formObj.find("table[name=pubWeekTable]").css("display","block");
	formObj.find("table[name=pubWeeksTable]").css("display","block");
	formObj.find("table[name=pubDayTable]").css("display","none");
	formObj.find("input[name=basisMode]").val("MW");
}
function ShowBasisModeMD(formObj){
	formObj.find("table[name=pubWeekDayTable]").css("display","block");
	formObj.find("table[name=pubMonthTable]").css("display","block");
	formObj.find("table[name=pubWeekTable]").css("display","none");
	formObj.find("table[name=pubWeeksTable]").css("display","none");
	formObj.find("table[name=pubDayTable]").css("display","block");
	formObj.find("input[name=basisMode]").val("MD");
}
function ShowBasisModeW(formObj){
	formObj.find("table[name=pubWeekDayTable]").css("display","none");
	formObj.find("table[name=pubMonthTable]").css("display","none");
	formObj.find("table[name=pubWeekTable]").css("display","block");
	formObj.find("table[name=pubWeeksTable]").css("display","block");
	formObj.find("table[name=pubDayTable]").css("display","none");
	formObj.find("input[name=basisMode]").val("W");
}
function ShowBasisModeD(formObj){
	formObj.find("table[name=pubWeekDayTable]").css("display","none");
	formObj.find("table[name=pubMonthTable]").css("display","none");
	formObj.find("table[name=pubWeekTable]").css("display","none");
	formObj.find("table[name=pubWeeksTable]").css("display","none");
	formObj.find("table[name=pubDayTable]").css("display","none");
	formObj.find("input[name=basisMode]").val("D");
}

// 등록이나 수정시에 공표주기의 체크박스가 한개라도 체크되어있지 않음을 검사
function basisValidationNullCheck(formObj,labal){
	var  basisMode = formObj.find("input[name=basisMode]").val();
	switch(basisMode){
	case "MW":	//월기준-주단위
		if(formObj.find("input:checkbox[name=pubMonth]:checked").length<1 ||
			formObj.find("input:checkbox[name=pubWeek]:checked").length<1 ||
			formObj.find("input:checkbox[name=pubWeeks]:checked").length<1){
			alert(labal+"을(를) 선택해주세요");
			return true;
			 }
	break;
	case "MD":	//월기준-일단위
		if(formObj.find("input:checkbox[name=pubMonth]:checked").length<1 ||
			formObj.find("input:checkbox[name=pubDay]:checked").length<1){
			alert(labal+"을(를) 선택해주세요");
			return true;
			 }
	break;
	case "W":	//주기준
		if(formObj.find("input:checkbox[name=pubWeek]:checked").length<1 ||
			formObj.find("input:checkbox[name=pubWeeks]:checked").length<1){
			alert(labal+"을(를) 선택해주세요");
			return true;
			 }
	break;
	case "D":	//일기준 아무것도 하지 않지만 헷갈리지 모르니 남겨둠
	break;
}
}

// 등록이나 수정,삭제 전에 validation
function validationOne(formObj){
	if(nullCheckValdation(formObj.find('input[name=pubNm]'),"<spring:message code='labal.pubNm'/>","")) return true;
	if(nullCheckValdation(formObj.find('input[name=refDsId]'),"<spring:message code='labal.refDsId'/>","")) return true;
	if(nullCheckValdation(formObj.find('input[name=refColId]'),"<spring:message code='labal.pubStdCol'/>","")) return true;
	if(nullCheckValdation(formObj.find('input[name=langTag]'),"<spring:message code='labal.langTag'/>","")) return true;
	if(nullCheckValdation(formObj.find('select[name=basisHhmm]'),"<spring:message code='labal.pubStdTime'/>","")) return true;
	if(nullCheckValdation(formObj.find('input[name=autoYn]'),"<spring:message code='labal.autoYn'/>","")) return true;
	if(nullCheckValdation(formObj.find('input[name=orgCd]'),"<spring:message code='labal.orgCdNm'/>","")) return true;
	if(nullCheckValdation(formObj.find('input[name=usrCd]'),"<spring:message code='labal.usrNm'/>","")) return true;
	if(nullCheckValdation(formObj.find('input[name=startDttm]'),"<spring:message code='labal.startDttm'/>","")) return true;
	if(basisValidationNullCheck(formObj,"<spring:message code='labal.pubTag'/>")) return true;
	
	
	if(formObj.find('input[name=refDsId]').attr("readonly") != "readonly"){
		if(formObj.find('input[name=refDsIdDup]').val() == "N"){
			alert("중복체크 버튼을 클릭해주세요.")
			return true;
		}
	}
	return false;                               
}

function confirmBeforeUpd(){
		var msg = "수정된 공표기준에 대하여 현재일자 기준이후의 공표자료가 다시 작성됩니다. 저장하시겠습니까?";
		if(!confirm(msg)){
			return true;
	}
	
}


// 관련 데이터 셋 중복체크
function dupCallBack(res){
	var objTab = getTabShowObj();//탭이 oepn된 객체가져옴
	var formObj = objTab.find("form[name=adminOpenPubCfgOne]");
	if(res.RESULT.CODE == -1){
		alert("중복된 관련데이터셋이 존재합니다.");
		formObj.find("input[name=refDsIdDup]").val("N");
	}else{                           
		alert("등록 가능합니다.");
		formObj.find("input[name=refDsIdDup]").val("Y");
	}
}


// 마우스 이벤트
function mySheet_OnSearchEnd(code, msg)
{
   if(msg != "")
	{
	    alert(msg);
    }
}

function OnSaveEnd()
{
	doAction("search");     
}      

function OnSearchEnd()
{
	return;
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

// 리스트에서 조회시에 공표주기 체크박스를 하나도 선택하지 않았는지를 검사
function validationCheckPubTag(formObj){
	if(formObj.find("input[name=pubTagMonth]").val() == "" &&
		formObj.find("input[name=pubTagWeek]").val() == "" &&
		formObj.find("input[name=pubTagday]").val() == ""){
		formObj.find("input[name=pubTagCheck]").val("N")
		alert("주기를 선택해주세요");
		return true;
	}
}

function setCssPubMWD(){
	$(".gong td").eq(0).css("padding-left","8px");
	$("table[name=pubWeekDayTable] td").eq(0).css("padding-left","8px");
	$("table[name=pubMonthTable] td").eq(0).css("padding-left","8px");
	$("table[name=pubWeekTable] td").eq(0).css("padding-left","8px");
	$("table[name=pubWeeksTable] td").eq(0).css("padding-left","8px");
	$("table[name=pubDayTable] td").eq(0).css("padding-left","8px");
	$("table[name=pubWeeksTable]").css("border-bottom","0px");
	$("table[name=pubDayTable]").css("border-bottom","0px");
	$("table[name=pubWeekTable] td").css("width","150px");
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
				<h2>${MENU_NM}</h2>                                      
				<p>${MENU_URL}</p>             
			</div>
			<!-- 탭 -->
			<ul class="tab">
				<li class="all_list"><a href="#">전체목록</a></li>
			</ul>
			<div class="more_list" style="display:none">
				<a href="#" class="more">0</a>                
				<ul class="other_list" style="display:none;">
					<li><a href="#">보유데이터목록</a><a href="#" class="line_close">x</a></li>
					<li><a href="#">공공데이터목록</a><a href="#" class="line_close">x</a></li>
				</ul>
			</div>
			
			<!-- 탭 내용 --> 
			<div class="content" style="display:none">
			<div style="border:1px solid #c0cbd4;padding:10px;width:100%; float:left;">
				<form name="adminOpenPubCfgOne"  method="post" action="#">
				<input type="hidden" name="pubId" value=""/>
				<input type="hidden" name="refDsId" value=""/>
				<input type="hidden" name="basisMm" value=""/>
				<input type="hidden" name="basisDd" value=""/>
				<input type="hidden" name="basisWk" value=""/>
				<input type="hidden" name="basisWd" value=""/>
				<input type="hidden" name="basisMode" value=""/>
				<input type="hidden" name="pubTag" value=""/>
				<input type="hidden" name="refDsIdDup" value="N"/>
				<input type="hidden" name="autoYn" value="N"/>
				<input type="hidden" name="pubTagSetYn" value="Y"/>
				<%-- <input type="text" name="test" value="${data.basisHhmm}"/> --%>
				<table class="list01">
					<caption>공표기준설정</caption>
					<colgroup>
						<col width="150"/>
						<col width=""/>
						<col width="150"/>
						<col width=""/>
					</colgroup>
					
					<tr>
						<th><spring:message code='labal.pubTitle'/><span>*</span></th>
						<td colspan="3">
							(한) <input type="text" value=""  name="pubNm" maxlength="160"  style="width: 340px;"/>
							(영) <input type="text" value=""  name="pubNmEng" maxlength="160" style="width: 340px;"/>
						</td>
					</tr>         
					<tr>
						<th><spring:message code='labal.pubContent'/></th>
						<td colspan="3">
							(한) <textarea rows="5" style="width:500px;" name="pubExp"></textarea>
							(영) <textarea rows="5" style="width:500px;" name="pubExpEng"></textarea>
						</td>
					</tr>        
					<tr>
						<th><spring:message code='labal.refDsId'/><span>*</span></th>
						<td colspan="3">
							<input type="text" name="refDsNm" value="" class="readonly" readonly maxlength="30"  style="width: 344px;"/>
							${sessionScope.button.btn_search}
							${sessionScope.button.btn_dup}
						</td>
					</tr>
					<tr>                 
						<th><spring:message code='labal.pubStdCol'/><span>*</span></th>
						<td id="refColIdTd" colspan="3">
									<select id="refColId" name="refColId">
									<option value="">
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
									</option>
									</select>
								</select>
								<span>주의 ) 대용량 데이터일 경우 기준컬럼의 인덱스를  생성하세요.</span>			
						</td>
					</tr>
					<tr>         
						<th><spring:message code='labal.langTag'/><span>*</span></th>
						<td colspan="3">
							<input type="radio" name="langTag" id="lanKor" value="K" checked="checked"/>
							<label for="kor"><spring:message code='labal.kor'/></label>
							<input type="radio" name="langTag" id="lanEng" value="E"/>
							<label for="eng"><spring:message code='labal.eng'/></label>
							<input type="radio" name="langTag" id="lanBoth" value="B"/>
							<label for="korEng"><spring:message code='labal.korEng'/></label>                                
						</td>                             
					</tr>
					
					<!-- 공표주기 선택 시작 -->
					<!-- 공표주기 선택 (월,주,일) -->
					<tr>         
						<th><spring:message code='labal.pubTag'/><span>*</span></th>
						<td colspan="3" style="padding-left:0;padding-right:0;">
							<table class="gong" name="pubMWDSelTable">
								<tr>
									<td>
										<input type="radio" name="pubMWDSel" id="pubMonthSel" checked="checked" value="M"/>
										<label for="pubMonthSel"><spring:message code='labal.pubTagMonth'/></label>
									</td>
									<td>
										<input type="radio" name="pubMWDSel" id="pubWeekSel" value="W"/>
										<label for="pubWeekSel"><spring:message code='labal.pubTagWeek'/></label>
									</td>
									<td>
										<input type="radio" name="pubMWDSel" id="pubDaySel" value="D"/>
										<label for="pubDaySel"><spring:message code='labal.pubTagDay'/></label>
									</td>
									<td>&nbsp;</td>
									<td>&nbsp;</td>
									<td>&nbsp;</td>
									<td>&nbsp;</td>
									<td>&nbsp;</td>
									<td>&nbsp;</td>
									<td>&nbsp;</td>
									<td>&nbsp;</td>
									<td>&nbsp;</td>
									<td>&nbsp;</td>
								</tr>
							</table>                        
							
							<table class="gong" name="pubWeekDayTable"> 
								<tr>
									<td>
										<input type="radio" name="pubTagWDUnit" id="pubTagWeekUnit" checked="checked" value="W"/>
										<label for="pubTagWeekUnit"><spring:message code='labal.pubTagWeekUnit'/></label>
									</td>
									<td>
										<input type="radio" name="pubTagWDUnit" id="pubTagDayUnit" value="D"/>
										<label for="pubTagDayUnit"><spring:message code='labal.pubTagDayUnit'/></label>
									</td>
									<td>&nbsp;</td>
									<td>&nbsp;</td>
									<td>&nbsp;</td>
									<td>&nbsp;</td>
									<td>&nbsp;</td>
									<td>&nbsp;</td>
									<td>&nbsp;</td>
									<td>&nbsp;</td>
									<td>&nbsp;</td>
									<td>&nbsp;</td>
									<td>&nbsp;</td>
								</tr>
							</table>
							
							<table class="gong" name="pubMonthTable">
								<tr>
									<td>
										<input type="checkbox" id="monthAllCheck"  name="monthAllCheck"/>
										<label for="monthAllCheck"><spring:message code="labal.pubMonthCheckAll"/></label>
									</td>
									<td>
										<input type="checkbox" id="pubMonth1"  name="pubMonth"/>
										<label for="pubMonth1"><spring:message code="labal.pubMonth1"/></label>
									</td>
									<td>
										<input type="checkbox" id="pubMonth2"  name="pubMonth"/>
										<label for="pubMonth2"><spring:message code="labal.pubMonth2"/></label>
									</td>
									<td>
										<input type="checkbox" id="pubMonth3"  name="pubMonth"/>
										<label for="pubMonth3"><spring:message code="labal.pubMonth3"/></label>
									</td>
									<td>
										<input type="checkbox" id="pubMonth4"  name="pubMonth"/>
										<label for="pubMonth4"><spring:message code="labal.pubMonth4"/></label>
									</td>
									<td>
										<input type="checkbox" id="pubMonth5"  name="pubMonth"/>
										<label for="pubMonth5"><spring:message code="labal.pubMonth5"/></label>
									</td>
									<td>
										<input type="checkbox" id="pubMonth6"  name="pubMonth"/>
										<label for="pubMonth6"><spring:message code="labal.pubMonth6"/></label>
									</td>
									<td>
										<input type="checkbox" id="pubMonth7"  name="pubMonth"/>
										<label for="pubMonth7"><spring:message code="labal.pubMonth7"/></label>
									</td>
									<td>
										<input type="checkbox" id="pubMonth8"  name="pubMonth"/>
										<label for="pubMonth8"><spring:message code="labal.pubMonth8"/></label>
									</td>
									<td>
										<input type="checkbox" id="pubMonth9"  name="pubMonth"/>
										<label for="pubMonth9"><spring:message code="labal.pubMonth9"/></label>
									</td>
									<td>
										<input type="checkbox" id="pubMonth10"  name="pubMonth"/>
										<label for="pubMonth10"><spring:message code="labal.pubMonth10"/></label>
									</td>
									<td>
										<input type="checkbox" id="pubMonth11"  name="pubMonth"/>
										<label for="pubMonth11"><spring:message code="labal.pubMonth11"/></label>
									</td>
									<td>
										<input type="checkbox" id="pubMonth12"  name="pubMonth"/>
										<label for="pubMonth12"><spring:message code="labal.pubMonth12"/></label>
									</td>
								</tr>
							</table>
							
							<table class="gong" name="pubWeekTable">
								<tr>
									<td>
										<input type="checkbox" id="weekAllCheck" name="weekAllCheck"/>
										<label for="weekAllCheck"><spring:message code="labal.pubWeekCheckAll"/></label>
									</td>
									<td>
										<input type="checkbox" id="pubWeek1" name="pubWeek"/>
										<label for="pubWeek1"><spring:message code="labal.pubWeek1"/></label>
									</td>
									<td>
										<input type="checkbox" id="pubWeek2" name="pubWeek"/>
										<label for="pubWeek2"><spring:message code="labal.pubWeek2"/></label>
									</td>
									<td>
										<input type="checkbox" id="pubWeek3" name="pubWeek"/>
										<label for="pubWeek3"><spring:message code="labal.pubWeek3"/></label>
									</td>
									<td>
										<input type="checkbox" id="pubWeek4" name="pubWeek"/>
										<label for="pubWeek4"><spring:message code="labal.pubWeek4"/></label>
									</td>
									<td>
										<input type="checkbox" id="pubWeek5" name="pubWeek"/>
										<label for="pubWeek5"><spring:message code="labal.pubWeek5"/></label>
									</td>
								</tr>
							</table>
							
							<table class="gong" name="pubWeeksTable">
								<tr>
									<td>
										<input type="checkbox" id="weeksAllCheck"  name="weeksAllCheck"/>
										<label for="weeksAllCheck"><spring:message code="labal.pubWeeksCheckAll"/></label>
									</td>
									<td>
										<input type="checkbox" id="pubWeeks1"  name="pubWeeks"/>
										<label for="pubWeeks1"><spring:message code="labal.pubWeeks1"/></label>
									</td>
									<td>
										<input type="checkbox" id="pubWeeks2"  name="pubWeeks"/>
										<label for="pubWeeks2"><spring:message code="labal.pubWeeks2"/></label>
									</td>
									<td>
										<input type="checkbox" id="pubWeeks3"  name="pubWeeks"/>
										<label for="pubWeeks3"><spring:message code="labal.pubWeeks3"/></label>
									</td>
									<td>
										<input type="checkbox" id="pubWeeks4"  name="pubWeeks"/>
										<label for="pubWeeks4"><spring:message code="labal.pubWeeks4"/></label>
									</td>
									<td>
										<input type="checkbox" id="pubWeeks5"  name="pubWeeks"/>
										<label for="pubWeeks5"><spring:message code="labal.pubWeeks5"/></label>
									</td>
									<td>
										<input type="checkbox" id="pubWeeks6"  name="pubWeeks"/>
										<label for="pubWeeks6"><spring:message code="labal.pubWeeks6"/></label>
									</td>
									<td>
										<input type="checkbox" id="pubWeeks7"  name="pubWeeks"/>
										<label for="pubWeeks7"><spring:message code="labal.pubWeeks7"/></label>
									</td>
									<td>&nbsp;</td>
									<td>&nbsp;</td>
									<td>&nbsp;</td>
									<td>&nbsp;</td>
									<td>&nbsp;</td>
								</tr>
							</table>
							
							<table class="gong" name="pubDayTable">
								<tr>
									<td>
										<input type="checkbox" id="dayAllCheck"  name="dayAllCheck"/>
										<label for="dayAllCheck"><spring:message code="labal.pubDayCheckAll"/></label>
									</td>
									<td>
										<input type="checkbox" id="pubDay1"  name="pubDay"/>
										<label for="pubDay1"><spring:message code="labal.pubDay1"/></label>
									</td>
									<td>
										<input type="checkbox" id="pubDay2"  name="pubDay"/>
										<label for="pubDay2"><spring:message code="labal.pubDay2"/></label>
									</td>
									<td>
										<input type="checkbox" id="pubDay3"  name="pubDay"/>
										<label for="pubDay3"><spring:message code="labal.pubDay3"/></label>
									</td>
									<td>
										<input type="checkbox" id="pubDay4"  name="pubDay"/>
										<label for="pubDay4"><spring:message code="labal.pubDay4"/></label>
									</td>
									<td>
										<input type="checkbox" id="pubDay5"  name="pubDay"/>
										<label for="pubDay5"><spring:message code="labal.pubDay5"/></label>
									</td>
									<td>
										<input type="checkbox" id="pubDay6"  name="pubDay"/>
										<label for="pubDay6"><spring:message code="labal.pubDay6"/></label>
									</td>
									<td>
										<input type="checkbox" id="pubDay7"  name="pubDay"/>
										<label for="pubDay7"><spring:message code="labal.pubDay7"/></label>
									</td>
									<td>
										<input type="checkbox" id="pubDay8"  name="pubDay"/>
										<label for="pubDay8"><spring:message code="labal.pubDay8"/></label>
									</td>
									<td>
										<input type="checkbox" id="pubDay9"  name="pubDay"/>
										<label for="pubDay9"><spring:message code="labal.pubDay9"/></label>
									</td>
									<td>
										<input type="checkbox" id="pubDay10"  name="pubDay"/>
										<label for="pubDay10"><spring:message code="labal.pubDay10"/></label>
									</td>
									<td>
										<input type="checkbox" id="pubDay11"  name="pubDay"/>
										<label for="pubDay11"><spring:message code="labal.pubDay11"/></label>
									</td>
									<td>
										<input type="checkbox" id="pubDay12"  name="pubDay"/>
										<label for="pubDay12"><spring:message code="labal.pubDay12"/></label>
									</td>
								</tr>
								<tr>
									<td>&nbsp;</td>
									<td>
										<input type="checkbox" id="pubDay13"  name="pubDay"/>
										<label for="pubDay13"><spring:message code="labal.pubDay13"/></label>
									</td>
									<td>
										<input type="checkbox" id="pubDay14"  name="pubDay"/>
										<label for="pubDay14"><spring:message code="labal.pubDay14"/></label>
									</td>
									<td>
										<input type="checkbox" id="pubDay15"  name="pubDay"/>
										<label for="pubDay15"><spring:message code="labal.pubDay15"/></label>
									</td>
									<td>
										<input type="checkbox" id="pubDay16"  name="pubDay"/>
										<label for="pubDay16"><spring:message code="labal.pubDay16"/></label>
									</td>
									<td>
										<input type="checkbox" id="pubDay17"  name="pubDay"/>
										<label for="pubDay17"><spring:message code="labal.pubDay17"/></label>
									</td>
									<td>
										<input type="checkbox" id="pubDay18"  name="pubDay"/>
										<label for="pubDay18"><spring:message code="labal.pubDay18"/></label>
									</td>
									<td>
										<input type="checkbox" id="pubDay19"  name="pubDay"/>
										<label for="pubDay19"><spring:message code="labal.pubDay19"/></label>
									</td>
									<td>
										<input type="checkbox" id="pubDay20"  name="pubDay"/>
										<label for="pubDay20"><spring:message code="labal.pubDay20"/></label>
									</td>
									<td>
										<input type="checkbox" id="pubDay21"  name="pubDay"/>
										<label for="pubDay21"><spring:message code="labal.pubDay21"/></label>
									</td>
									<td>
										<input type="checkbox" id="pubDay22"  name="pubDay"/>
										<label for="pubDay22"><spring:message code="labal.pubDay22"/></label>
									</td>
									<td>
										<input type="checkbox" id="pubDay23"  name="pubDay"/>
										<label for="pubDay23"><spring:message code="labal.pubDay23"/></label>
									</td>
									<td>
										<input type="checkbox" id="pubDay24"  name="pubDay"/>
										<label for="pubDay24"><spring:message code="labal.pubDay24"/></label>
									</td>
								</tr>
								<tr>
									<td>&nbsp;</td>
									<td>
										<input type="checkbox" id="pubDay25"  name="pubDay"/>
										<label for="pubDay25"><spring:message code="labal.pubDay25"/></label>
									</td>
									<td>
										<input type="checkbox" id="pubDay26"  name="pubDay"/>
										<label for="pubDay26"><spring:message code="labal.pubDay26"/></label>
									</td>
									<td>
										<input type="checkbox" id="pubDay27"  name="pubDay"/>
										<label for="pubDay27"><spring:message code="labal.pubDay27"/></label>
									</td>
									<td>
										<input type="checkbox" id="pubDay28"  name="pubDay"/>
										<label for="pubDay28"><spring:message code="labal.pubDay28"/></label>
									</td>
									<td>
										<input type="checkbox" id="pubDay29"  name="pubDay"/>
										<label for="pubDay29"><spring:message code="labal.pubDay29"/></label>
									</td>
									<td>
										<input type="checkbox" id="pubDay30"  name="pubDay"/>
										<label for="pubDay30"><spring:message code="labal.pubDay30"/></label>
									</td>
									<td>
										<input type="checkbox" id="pubDay31"  name="pubDay"/>
										<label for="pubDay31"><spring:message code="labal.pubDay31"/></label>
									</td>
									<td>
										<input type="checkbox" id="pubDay32"  name="pubDay"/>
										<label for="pubDay32"><spring:message code="labal.pubDay32"/></label>
									</td>
									<td>&nbsp;</td>
									<td>&nbsp;</td>
									<td>&nbsp;</td>
									<td>&nbsp;</td>
								</tr>
							</table>

						</td>                             
					</tr>
					
					<tr>         
						<th><spring:message code='labal.pubStdTime'/><span>*</span></th>
						<td>
							<select id="basisHhmm" name="basisHhmm">
									<option value="00:00">00</option>	
									<option value="01:00">01</option>
									<option value="02:00">02</option>
									<option value="03:00">03</option>
									<option value="04:00">04</option>
									<option value="05:00">05</option>
									<option value="06:00">06</option>
									<option value="07:00">07</option>
									<option value="08:00">08</option>
									<option value="09:00">09</option>
									<option value="10:00">10</option>
									<option value="11:00">11</option>
									<option value="12:00">12</option>
									<option value="13:00">13</option>
									<option value="14:00">14</option>
									<option value="15:00">15</option>
									<option value="16:00">16</option>
									<option value="17:00">17</option>
									<option value="18:00">18</option>
									<option value="19:00">19</option>
									<option value="20:00">20</option>
									<option value="21:00">21</option>
									<option value="22:00">22</option>
									<option value="23:00">23</option>
								</select>                               
						</td>                             
					</tr>
					<tr>         
						<th><spring:message code='labal.autoYn'/></th>
						<td colspan="3">
							<input type="checkbox" id="autoYnCheck"  name="autoYnCheck" value="N"/>
							<label for="autoYnCheck"><spring:message code="labal.autoYn"/></label>
							<span>체크 시 담당자의 확인 없이 공표주기에 따라 자동으로 공표됩니다</span>						
						</td>                             
					</tr>
					<tr>
						<th><spring:message code="labal.orgCdNm"/><span>*</span></th>
						<td colspan="3">
							<input type="hidden" name="orgCd"/>
							<input type="text" name="orgNm" maxlength="160" readonly/>
							${sessionScope.button.btn_search}
							<input type="text" name="orgFullNm" maxlength="660" size="50" readonly/>
						</td>
					</tr>
					<tr>
						<th><spring:message code="labal.usrNm"/><span>*</span></th>
						<td colspan="3">
							<input type="hidden" name="usrCd" />
							<input type="text" name="usrNm" maxlength="30" value="" readonly/>
							${sessionScope.button.btn_search}
						</td>
					</tr>
					<tr>         
						<th><spring:message code="labal.startStdDttm"/><span>*</span></th>
						<td colspan="3">
							<input type="text" name="startDttm" value="" readonly/>
						</td>                             
					</tr>
					<tr>         
						<th><spring:message code='labal.useYn'/> </th>
						<td colspan="3">
							<input type="radio" name="useYn" id="use" checked="checked" value="Y"/>
							<label for="use"><spring:message code='labal.yes'/></label>
							<input type="radio" name="useYn" id="unuse" value="N"/>
							<label for="unuse"><spring:message code='labal.no'/></label>                                  
						</td>                             
					</tr>
				</table>	                       
				
				<div class="buttons">
					${sessionScope.button.a_reg}     
					${sessionScope.button.a_modify}     
					${sessionScope.button.a_del}                            
				</div>
				</form>		
				</div>
			</div>
			
			<!-- 목록내용 -->
			<div class="content"  >
			<form name="adminOpenPubCfg"  method="post" action="#">
			<input type="hidden" name="pubTagCheck" value="Y"/>
			<input type="hidden" name="pubTagMonth" value="M"/>
			<input type="hidden" name="pubTagWeek" value="W"/>
			<input type="hidden" name="pubTagDay" value="D"/>
			<input type="hidden" name="ibSheetRow" value=""/>
			<table class="list01">              
				<caption>공표기준</caption>
				<colgroup>
					<col width="150"/>
					<col width=""/>
				</colgroup>
				<tr>
					<th>검색어</th>
					<td colspan="7">
						<select name="serSel">	
									<option value="ALL"><spring:message code='etc.select'/></option>
									<option value="NM"  selected="selected"><spring:message code='labal.pubNm'/></option>
									<option value="DS" ><spring:message code='labal.dataSet'/></option>
									<input type="text" name="serVal" value="" maxlength="50" style="width: 300px"/>
								</select> 
								${sessionScope.button.btn_inquiry}               
								${sessionScope.button.btn_reg}
					</td>
				</tr>
				<tr>
					<th><label class=""><spring:message code="labal.pubTag"/></label></th>
					<td colspan="2">
						<input type="checkbox" id="monthCheck"  name="monthCheck" checked="checked" value="Y"/>
						<label for="monthCheck"><spring:message code="labal.pubTagMonth"/></label>
						<input type="checkbox" id="weekCheck"  name="weekCheck" checked="checked" value="Y"/>
						<label for="weekCheck"><spring:message code="labal.pubTagWeek"/></label>
						<input type="checkbox" id="dayCheck"  name="dayCheck" checked="checked" value="Y"/>
						<label for="dayCheck"><spring:message code="labal.pubTagDay"/></label>
					</td>
						
					<th><label class=""><spring:message code="labal.language"/></label></th>
							<td colspan="4">
							<input type="radio" name="langTag" id="lanAll"  value="A" checked="checked"/>            
							<label for="lanAll"><spring:message code="labal.whole"/></label>
							<input type="radio" name="langTag" id="lanKor" value="K"/>
							<label for="kor"><spring:message code='labal.kor'/></label>
							<input type="radio" name="langTag" id="lanEng" value="E"/>
							<label for="eng"><spring:message code='labal.eng'/></label>
							<input type="radio" name="langTag" id="lanBoth" value="B"/>
							<label for="korEng"><spring:message code='labal.korEng'/></label>
					</td>
				</tr>
				<tr>
						<th><spring:message code='labal.useYn'/></th>
						<td colspan="7">
							<input type="radio" name="useYn" id="useall"  value=""/>            
							<label for="useall"><spring:message code="labal.whole"/></label>
							<input type="radio" name="useYn" id="use" value="Y" checked="checked"/>
							<label for="use"><spring:message code='labal.yes'/></label>
							<input type="radio" name="useYn" id="unuse" value="N"/>
							<label for="unuse"><spring:message code='labal.no'/></label>
						</td>
					</tr>
			</table>	
			</form>		
				<!-- ibsheet 영역 -->
				<div style="clear: both;"></div>
				<div class="ibsheet_area_both">
					<script type="text/javascript">createIBSheet("mySheet", "100%", "300px"); </script>             
				</div>
			</div>
			
		</div>
</div>
	<!--##  푸터  ##-->                
	<c:import  url="/WEB-INF/jsp/admin/adminfooter.jsp"/>
	<!--##  /푸터  ##-->  
</body>
</html>