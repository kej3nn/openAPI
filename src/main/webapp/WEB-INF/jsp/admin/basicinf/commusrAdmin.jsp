<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="egovframework.common.WiseOpenConfig"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<!--
  담당자관리 jsp
  @author KJH
  @since 2014.07.23
 -->
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><spring:message code='wiseopen.title'/></title>
<c:import  url="/WEB-INF/jsp/inc/headinclude.jsp"/>
<!--
	validate 사용시 반드시 선언
	formName명과 validate 함수명이 연결되어있음
	adminCommUsrAdmin -> validateAdminCommUsrAdmin 체크함
	resources/validator/*.* xml을 만들어서 사용
  -->
<validator:javascript formName="adminCommUsrAdmin" staticJavascript="false" xhtml="true" cdata="false"/> 
</head>                                                 
<script language="javascript">              
//<![CDATA[                              
function tabSet(){ //탭 객체 생성  
	openTab = new OpenTab(tabId,tabContentClass,tabBody); //headinclude.jsp 변수 있음
	openTab.TabObj = openTab;  
	openTab.addTabClickEvent();            
}	   
        
$(document).ready(function()    {    
	setMainButton(); 	//메인 버튼
	LoadPage();			//메인 sheet                                                                 
	doAction('search');	//조회                                              
	inputEnterKey();	//엔터키       
	tabSet();			//tab 셋팅
});                                                       


/****************************************************************************************************
 * Main 관련
 ****************************************************************************************************/
// Setting
 function setMainButton(){
	$("button[name=btn_reg]").click(function(e) {	doAction("reg");	return false;	});
	$("button[name=btn_usrNmSearch]").click(function(e) {	
		formReset();
		doAction("usrNmPop");	return false;	
	});
	$("button[name=btn_searchWd]").click(function(e) {	doAction("search");	return false;	});
	$("button[name=btn_orgSearch]").click(function(e) {	doAction("orgPop");	return false;	});
	
}

//탭안에서 재 검색시 폼항목 초기화
function formReset() {
	var objTab = getTabShowObj();
	var formObj = objTab.find("form[name=adminCommUsrAdmin]");
	formObj.each(function() { this.reset(); });
	formObj.find("lable[name=usrPki]").text('');
	formObj.find("lable[name=pkiDttm]").text('');
	formObj.find("lable[name=useYn]").text('');
	formObj.find("lable[name=accokDttm]").text('');
}	

function LoadPage()                
{      
	//message-common_ko_KR.properties 선언 후 사용 or message-common_en_US.properties 선언 후 사용
	//관리자ID:직원명||직책|소속부서|연락처(회사)|권한|승인일자|승인여부
	var gridTitle = "NO"
		gridTitle +="|"+"<spring:message code='labal.adminId'/>";  
		gridTitle +="|"+"<spring:message code='labal.usrCd'/>";  
		gridTitle +="|"+"<spring:message code='labal.usrNm'/>";        
		gridTitle +="|"+"소속기관";      
		gridTitle +="|"+"부서";
		gridTitle +="|"+"<spring:message code='labal.job'/>";
		gridTitle +="|"+"연락처";
		gridTitle +="|"+"<spring:message code='labal.accCd'/>";
		gridTitle +="|"+"<spring:message code='labal.apprDttm'/>";
		gridTitle +="|승인여부";        
	
    with(mySheet1){
    	                     
    	var cfg = {SearchMode:3,Page:50,VScrollMode:1};                                
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
					 {Type:"Seq",		SaveName:"seq",				Width:20,	Align:"Center",		Edit:false}
					,{Type:"Text",		SaveName:"usrId",			Width:60,	Align:"Center",		Edit:false}
					,{Type:"Text",		SaveName:"usrCd",			Width:0,	Align:"Center",		Edit:false,		Hidden:true}
					,{Type:"Text",		SaveName:"usrNm",			Width:60,	Align:"Left",		Edit:false}
					,{Type:"Text",		SaveName:"orgNm",			Width:150,	Align:"Left",		Edit:false}
					,{Type:"Text",		SaveName:"deptNm",			Width:100,	Align:"Left",		Edit:false}
					,{Type:"Text",		SaveName:"jobNm",			Width:60,	Align:"Left",		Edit:false}
					,{Type:"Text",		SaveName:"usrTel",			Width:100,	Align:"Center",		Edit:false}
					,{Type:"Text",		SaveName:"accNm",			Width:60,	Align:"Center",		Edit:false}
					,{Type:"Text",		SaveName:"accokDttm",		Width:100,	Align:"Center",		Edit:false}
					,{Type:"CheckBox",	SaveName:"accokYn",			Width:40,	Align:"Center",		Edit:false}
                                        
                ];       
                                      
        InitColumns(cols);                                                                           
        FitColWidth();                                                         
        SetExtendLastCol(1);   
    }               
    default_sheet(mySheet1);                      
}    

/* 메인 이벤트 */
function mySheet1_OnSearchEnd(code, msg)
{
   if(msg != "") {	alert(msg);}
}

function OnSaveEnd() {	doAction("search");}           

function inputEnterKey(){
	$("input").keypress(function(e) {
		  if(e.which == 13) {
			  doAction('search');   
			  return false;
		  }
	});
}           

// sheet 더블클릭
function mySheet1_OnDblClick(row, col, value, cellx, celly) {
    if(row == 0) return;     
    tabEvent(row);                      
} 

// Main Action                  
function doAction(sAction)                                  
{
	var classObj = $("."+tabContentClass); //tab으로 인하여 form이 다건임
	var actObj = setTabForm(classObj); // 0: form data, 1: form 객체
	var objTab = getTabShowObj();//탭이 oepn된 객체가져옴
	var formObj = objTab.find("form[name=adminCommUsrAdmin]");
	switch(sAction)
	{          
		case "search":      	//조회   
			ajaxBeforeSendAdmin("<c:url value='/admin/ajaxBeforeSendAdmin.do'/>"); //IbSheet 조회전 세션 체크
			var param = {PageParam: "ibpage", Param: "onepagerow=50&"+actObj[0]};         
			mySheet1.DoSearchPaging("<c:url value='/admin/basicinf/commUsrAdminListAll.do'/>", param);
			break;
			
		case "reg":      	//등록화면
			var title = "등록하기"
			var id ="dsReg";
			openTab.addRegTab(id,title,tabCallRegBack); // 탭 추가 시작함
			break;
		
		case "usrNmPop" :	//직원 팝업
			var url = "<c:url value="/admin/basicinf/popup/commUsr_pop.do"/>" + "?usrGb=1";
			var popup = OpenWindow(url,"usrPop","800","650","yes");	                
			break;
		
		case "orgPop" :		//조직 팝업
			//var url="<c:url value="/admin/basicinf/popup/commOrg_pop.do"/>" + "?orgNmGb=1"
			var url="<c:url value="/admin/basicinf/popup/commOrg_pop.do"/>";
			var popup = OpenWindow(url,"orgPop","500","550","yes");	                
			break;
		
	}           
} 


/****************************************************************************************************
 * Tab 관련
 ****************************************************************************************************/
 
 // 탭 추가 시 버튼 Setting
 function setTabButton(){ 
 	var objTab = getTabShowObj();//탭이 oepn된 객체가져옴
 	var formObj = objTab.find("form[name=adminCommUsrAdmin]");    
 	
 	//신규등록(승인 동시에처리)
 	formObj.find("a[name=a_reg]").eq(0).click(function() {
 		doActionTab("reg");          
 		return false;                 
 	});
 	
 	//수정
 	formObj.find("a[name=a_modify]").eq(0).click(function() {
 		doActionTab("update");          
 		return false;                 
 	}); 
 	
 	//승인
 	formObj.find("a[name=a_appr]").eq(0).click(function() {
 		doActionTab("approval");          
 		return false;
 	}); 
 	
 	//승인취소
 	formObj.find("a[name=a_apprCancel]").eq(0).click(function() {
 		doActionTab("approvalCancel");          
 		return false;
 	});
 	
 	//중복체크
 	formObj.find("button[name=btn_dup]").click(function(e) {
		doActionTab("dup");                                               
		return false;                  
	});
 	
	//비밀번호 초기화
 	formObj.find("button[name=btn_initialPw]").click(function(e) {
		doActionTab("initialPw");                                               
		return false;                  
	});
 	
 	//유저ID 숫자, 영문
 	formObj.find("input[name=usrId]").keyup(function(e) {                 
 		ComInputEngNumObj(formObj.find("input[name=usrId]"));   
 		formObj.find("input[name=usrIdDup]").val("N");
 		return false;                                                                          
 	});
 	
 }

//등록 유저생성 콜백
function regUserFunction(tab) {
	tab.ContentObj.find("a[name=a_appr]").remove();   
	tab.ContentObj.find("a[name=a_apprCancel]").remove();   
	tab.ContentObj.find("a[name=a_modify]").remove();
	tab.ContentObj.find("button[name=btn_initialPw]").remove();
}
 
/* Tab Event */

//탭 추가 시 버튼 이벤트
function buttonEventAdd(){
	setTabButton();
}

// 탭 추가 이벤트
function tabEvent(row){
// 	if ( mySheet1.GetCellValue(row, "accokYn") == "0" ) {
// 		alert("담당자 등록이 되어야 수정 가능합니다.");
// 		return;
// 	}
	//if (mySheet1.GetCellValue(row, "useYn")) {}
	var title = mySheet1.GetCellValue(row,"usrNm");//탭 제목                                           
	var id = mySheet1.GetCellValue(row,"usrCd");//탭 id(유일한key))
    openTab.SetTabData(mySheet1.GetRowJson(row));//db data 조회시 조건 data
    var url =  "<c:url value='/admin/basicinf/commUsrAdminDtlTabInfo.do'/>";              
    openTab.addTab(id,title,url,tabCallBack); // 탭 추가 시작함(callback함수 overring)
    //buttonEventAdd();
}


//Tab action
function doActionTab(sAction)
{
	var classObj = $("."+tabContentClass); //tab으로 인하여 form이 다건임
	var actObj = setTabForm(classObj); // 0: form data, 1: form 객체
	var objTab = getTabShowObj();//탭이 oepn된 객체가져옴
	var formObj = objTab.find("form[name=adminCommUsrAdmin]");
	ajaxBeforeSendAdmin("<c:url value='/admin/ajaxBeforeSendAdmin.do'/>"); //IbSheet 조회전 세션 체크
	//var gridObj = window[sheetObj];
	switch(sAction)                    
	{
		case "searchUsrInfo" :		//담당자 단건 조회
			var param = actObj[0];
			var url =  "<c:url value='/admin/basicinf/commUsrAdminDtlInfo.do'/>";
			ajaxCallAdmin(url, param, usrInfoCallBack);
			break;
			
		case "dup" :		//관리자ID 중복체크
			if(nullCheckValdation(formObj.find('input[name=usrNm]'),"직원명","")){
				return false;
			}	
			if(nullCheckValdation(formObj.find('input[name=usrId]'),"관리자 ID","")){
				return false;
			}
			if ( formObj.find('input[name=usrId]').val().length < 5 | formObj.find('input[name=usrId]').val().length > 20 ) {
				alert("5자 이상 20자 이내로 입력해 주세요.");
				formObj.find('input[name=usrId]').val("");
				return false;
			}
			var url = "<c:url value='/admin/basicinf/commUsrAdminUsrIdDup.do'/>"; 
			ajaxCallAdmin(url,actObj[0],dupCallBack);
			break;	
			
		case "initialPw" :
			if ( confirm("초기화 하시겠습니까?") ) {
				var param = actObj[0];
				var url =  "<c:url value='/admin/basicinf/commUsrAdminInitialPw.do'/>";
				ajaxCallAdmin(url, param, initialPwCallBack);
			}
			break;
			
		case "approval" :		//승인	
			if ( !confirm("승인 하시겠습니까? ") ) {
				return;
  			}
			if ( formObj.find("input[name=accokYn]").val() == "Y" ) {
				alert("이미 승인된 상태 입니다.");
				return;
			} else if ( confirm("관리자로 승인되면 관리자시스템에 접근이 허용됩니다.\n정확한 정보가 입력되었는지 다시한번 확인해 주세요.\n승인하시겠습니까?") ) {
				var url =  "<c:url value='/admin/basicinf/commUsrAdminAppr.do'/>";
				ajaxCallAdmin(url, actObj[0], saveCallBack);
			}
			break;
			
		case "approvalCancel" :	//승인취소
			if ( !confirm("승인취소 하시겠습니까? ") ) {
				return;
  			}
			if ( formObj.find("input[name=accokYn]").val() == "N" ) {
				alert("이미 승인취소된 상태 입니다.");
				return;
			} else if ( confirm("관리자 승인이 취소됩니다.\n더 이상 관리시스템에 접근이 불가능합니다.\n승인취소하시겠습니까?") ) {
				var url =  "<c:url value='/admin/basicinf/commUsrAdminApprCancel.do'/>";
				ajaxCallAdmin(url, actObj[0], saveCallBack);
			}
			break;
			
		case "reg" :		// 신규등록
			if (!validateAdminCommUsrAdmin(actObj[1])){		return;	}		//필수입력 체크
			/*
			if(formObj.find('input[name=usrIdDup]').val() == "N"){
				alert("중복확인 버튼을 클릭해주세요.");
				return false;
			}
			*/
		
			var url =  "<c:url value='/admin/basicinf/commUsrAdminSave.do'/>";
			var param = openTab.ContentObj.find("[name=adminCommUsrAdmin]").serialize();
			ajaxCallAdmin(url, param, saveCallBack);
			break;
			
		case "update" : 	// 수정
			if ( !confirm("수정 하시겠습니까? ") ) {
				return;
  			}
			if(nullCheckValdation(formObj.find('select[name=accCd]'),"권한","")){
				//필수값 체크(권한)
				return false;
			}
			var url = "<c:url value='/admin/basicinf/commUsrAdminUpd.do'/>"; 
			var param = openTab.ContentObj.find("[name=adminCommUsrAdmin]").serialize();
			ajaxCallAdmin(url, param, saveCallBack);
			break;

	}
}

//Tab 조회콜백
function tabFunction(tab, json){
	tab.ContentObj.find("a[name=a_reg]").hide();
	$.each(json.DATA,function(key,state){
		if ( key=="usrPki" | key=="pkiDttm" | key=="accokYnDesc" | key=="accokDttm" ) {
			tab.ContentObj.find("lable[name="+key+"]").text(state);
		} else {
			if(tab.ContentObj.find("input:checkbox[name="+key+"]").attr("type") == 'checkbox'){
				if ( state == "Y" ) {
					tab.ContentObj.find("input:checkbox[name="+key+"]").prop("checked",true);
				} else {
					tab.ContentObj.find("input:checkbox[name="+key+"]").prop("checked",false);
				}
			} else {
				tab.ContentObj.find("[name="+key+"]").val(state);
			}
		}
	});
	tab.ContentObj.find("button[name=btn_usrNmSearch]").hide();
	tab.ContentObj.find("button[name=btn_dup]").hide();
	tab.ContentObj.find("input[name=usrId]").attr("readonly", true).addClass("readonly", true);
	tab.ContentObj.find("input[name=usrPw]").attr("readonly", true).addClass("readonly", true);
	tab.ContentObj.find("input[name=usrPw]").val("**************");
}

//직원명 조회 콜백
function usrInfoCallBack(tab, json){
	var objTab = getTabShowObj()
	var formObj = objTab.find("form[name=adminCommUsrAdmin]");
	$.each(tab.DATA,function(key,state){
		if ( key != "usrNm" & key != "usrCd" ) {
			//formObj.find("[name="+key+"]").val(state);
			if ( key=="usrPki" | key=="pkiDttm" | key=="accokYnDesc" | key=="accokDttm" ) {
				formObj.find("lable[name="+key+"]").text(state);
			} else if (formObj.find("input:checkbox[name="+key+"]").attr("type") == 'checkbox') {
				if ( state == "Y" ) {
					formObj.find("input:checkbox[name="+key+"]").prop("checked",true);
				} else {
					formObj.find("input:checkbox[name="+key+"]").prop("checked",false);
				}
			}else if (key == "hpYn") {
				if (state=="Y")
					tab.ContentObj.find("input:checkbox[name=hpYn]").prop("checked", true);
				else
					tab.ContentObj.find("input:checkbox[name=hpYn]").prop("checked", false);
			}
			else {
				formObj.find("[name="+key+"]").val(state);
			}
		} 
		
	});
}

//비밀번호 초기화 콜백
function initialPwCallBack(tab, json, res) {
	var objTab = getTabShowObj()
	var formObj = objTab.find("form[name=adminCommUsrAdmin]");
	formObj.find("input[name=initialPw]").val(tab.DATA.initialPw);
	alert("비밀번호가 " + tab.DATA.initialPw + " 으로 초기화 되었습니다.\n관리자에게 등록된 아이디와 암호를 알려주세요.");
	formObj.find("input[name=initialPw]").focus();
}

//ID 중복체크 콜백
function dupCallBack(res){
	var objTab = getTabShowObj();//탭이 oepn된 객체가져옴
	var formObj = objTab.find("form[name=adminCommUsrAdmin]");
	if(res.RESULT.CODE == -1){
		alert("중복된 ID가 존재합니다.");
		formObj.find("input[name=usrIdDup]").val("N");
		formObj.find("input[name=usrId]").val("");
	}else{                           
		alert("등록 가능합니다.");
		formObj.find("input[name=usrIdDup]").val("Y");
	}
} 


//]]> 
</script>              
</head>
<body onload="">
<div class="wrap">
		<c:import  url="/admin/admintop.do"/>
		<!-- 내용 -->
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
			<!--
			<div class="more_list" style="display:none">
				<a href="#" class="more">0</a>                
				<ul class="other_list" style="display:none;">
					<li><a href="#">보유데이터목록</a><a href="#" class="line_close">x</a></li>
					<li><a href="#">공공데이터목록asdfsdfsfsdfsdfsdf</a><a href="#" class="line_close">x</a></li>
				</ul>
			</div>
			-->
			
			              
			<!-- 탭 내용 -->
			<div class="content" style="display:none">
				<form name="adminCommUsrAdmin"  method="post" action="#">
				<input type="hidden" name="sheetNm"/>
				<input type="hidden" name="usrIdDup" value="N"/>
				<input type="hidden" name="accokYn" value=""/>
				
				<table class="list01">
					<caption>직원정보관리</caption>
					<colgroup>
						<col width="150"/>
						<col width=""/>
						<col width="150"/>
						<col width=""/>
					</colgroup>
					<tr>
						<!-- 직원명 -->
						<th><spring:message code="labal.usrNm"/> <span>*</span></th>
						<td>
							<input type="hidden" name="usrCd" style="width: 150px;"/>
							<input type="text" name="usrNm" value="" class="readonly" disabled="true" style="width: 150px;"/>
							<button type="button" class="btn01" name="btn_usrNmSearch">
								<spring:message code="btn.search"/>
							</button>
						</td>
						<!-- 직책 -->
						<th><spring:message code="labal.job"/></th>
						<td><input type="text" name="jobNm" value="" class="readonly" disabled="true" style="width: 150px;"/></td>
					</tr>
					<tr>
						<!-- 소속부서 -->
						<th>소속기관</th>
						<td>
							<input type="hidden" name="orgCd" value="" />
							<input type="text" name="orgNm" value="" class="readonly" disabled="true" style="width: 500px;"/>
						</td>
						<th>부서</th>
						<td>
							<input type="text" name="deptNm" value="" class="readonly" disabled="true" style="width: 500px;"/>
						</td>
					</tr>
					<tr>
						<!-- 이메일 -->
						<th><spring:message code="labal.usrEmail"/></th>
						<td colspan="3">
							<input type="text" name="usrEmail" value="" class="readonly" disabled="true" style="width: 350px;"/>
							<input type="checkbox" name="emailYn"/>
							<label for="agreeEmail"><spring:message code="labal.emailYn"/></label>
						</td>
					</tr>
					<tr>
						<!-- 사무실 연락처 -->
						<th>연락처</th>
						<td>
							<input type="text" name="usrTel" value="" class="readonly" disabled="true" style="width: 250px;"/>
						</td>
						<!-- 휴대폰(비공개) -->
						<th>휴대전화</th>
						<td>
							<input type="text" name="usrHp" value="" class="readonly" disabled="true" style="width: 150px;"/>
							<input type="checkbox" name="hpYn"/>
							<label for="agreeUsrHp">문자메세지 수신동의</label>
						</td>
					</tr>
					<tr>
						<th>담당업무</th>
						<td>
							<input type="text" name="usrWork" value="" class="readonly" disabled="true" style="width: 250px;"/>
						</td>
						<th>알림시간</th>
						<td>
							<input type="text" name="notiHh" value="" class="readonly" disabled="true" style="width: 250px;"/>
						</td>
					</tr>
					<tr>
					<th><spring:message code="labal.apprYn"/></th>
						<!-- 승인여부 -->
						<td colspan="3">
							<b><lable name="accokYnDesc"></lable></b>
							<b><label>(사용중지된 직원은 관리자로 로그인이 불가능 합니다)</label></b>
						</td>
					</tr>
					<tr>
						<th><spring:message code="labal.adminId"/> <span>*</span></th>
						<td colspan="3">
							<!-- 관리자ID -->
							<input type="text" name="usrId" value="" style="width: 200px;" maxlength="20"/>
							<button type="button" class="btn01" name="btn_dup">
								<spring:message code="btn.dup"/>	<!-- 중복확인 -->
							</button>
							영문, 숫자 5자이상 ~ 20자 이내
						</td>
					</tr>
					<tr>
						<th><spring:message code="labal.auth"/> <span>*</span></th>
						<td colspan="3">
							<!-- 권한 -->
							<select class="" name="accCd">
								<option value=""><spring:message code="etc.select"/></option>
								<c:if test="${sessionScope.loginVO.accCd eq 'SYS'}">
									<c:forEach var="code" items="${codeMap.accCd}" varStatus="status">
										<option value="${code.ditcCd}">${code.ditcNm}</option>
									</c:forEach>
								</c:if>
								<c:if test="${sessionScope.loginVO.accCd ne 'SYS'}">
									<c:forEach var="code" items="${codeMap.accCd}" varStatus="status">
										<c:choose>
										<c:when test="${code.ditcCd eq 'SYS'}"></c:when>
										<c:otherwise>
											<option value="${code.ditcCd}">${code.ditcNm}</option>
										</c:otherwise>
										</c:choose>
									</c:forEach>
								</c:if>
								
							</select>
						</td>
					</tr>
					<%-- <tr>
						<th><spring:message code="labal.pkiInfo"/></th>
						<td colspan="3">
							<b><lable name="usrPki"></lable><b>
							<lable name="pkiDttm"></lable>
						</td>
					</tr> --%>
					<tr>
						<th><spring:message code="labal.pwd"/> <span>*</span></th>
						<td colspan="3">
							<input type="password" name="usrPw" value="" style="width: 200px;" autocomplete="off"/>
						</td>
					</tr>
					<tr>
						<th><spring:message code="labal.initPw"/></th>							
						<td colspan="3">
<!-- 							<input type="text" name="initialPw" value="" class="readonly" style="width: 200px;" placeholder="초기화시 비밀번호가 표시됩니다."/> -->
							<input type="text" name="initialPw" value="" class="readonly" style="width: 200px;" readonly/>
							<button type="button" class="btn01" name="btn_initialPw">
								초기화	<!-- 초기화 -->
							</button>
							&nbsp;<b>초기화 시 암호변경이 요청됩니다.</b>
						</td>					
					</tr>
					<tr>
						<th><spring:message code="labal.apprDttm"/></th>
						<td colspan="3">
							<b><lable name="accokDttm"></lable></b>
						</td>
					</tr>
				</table>	
				
				<div class="buttons">
					${sessionScope.button.a_appr}
					${sessionScope.button.a_apprCancel}
					${sessionScope.button.a_reg}
					${sessionScope.button.a_modify}
				</div>
				</form>
			</div>
			
			<!-- 목록내용 -->
			<div class="content"  >
				<form name="adminCommUsrAdmin"  method="post" action="#">
				<table class="list01">              
					<caption>담당자정보관리</caption>
					<colgroup>
						<col width="150"/>
						<col width=""/>
					</colgroup>       
					<tr>
						<th>직원명</th>
						<td><%-- 
							<select name="searchWd">
								<option value=""><spring:message code="etc.select"/></option>
								<option value="1" selected="selected"><spring:message code="labal.usrNm"/></option>
								<option value="2"><spring:message code="labal.usrNmEng"/></option>
							</select> --%>
							<input type="text" name="searchWord" value="" style="width: 300px"/>
						</td>
					</tr>
					<tr>
						<!-- 조직명 -->
						<th>소속기관</th>
						<td>
							<input type="hidden" name="orgCd" value=""/>
							<input type="text" name="orgNm" value="" style="width:200px; "/>
							<button type="button" class="btn01" name="btn_orgSearch"><spring:message code="btn.search"/></button>
						</td>
					</tr>
					<tr>
						<!-- 권한 -->
						<th><spring:message code="labal.auth"/></th> 
						<td>
							<select name="accCd">
								<option value=""><spring:message code="etc.select"/></option>
								<c:if test="${sessionScope.loginVO.accCd eq 'SYS'}">
									<c:forEach var="code" items="${codeMap.accCd}" varStatus="status">
										<option value="${code.ditcCd}">${code.ditcNm}</option>
									</c:forEach>
								</c:if>
								<c:if test="${sessionScope.loginVO.accCd ne 'SYS'}">
									<c:forEach var="code" items="${codeMap.accCd}" varStatus="status">
										<c:choose>
										<c:when test="${code.ditcCd eq 'SYS'}"></c:when>
										<c:otherwise>
											<option value="${code.ditcCd}">${code.ditcNm}</option>
										</c:otherwise>
										</c:choose>
									</c:forEach>
								</c:if>
							</select>
						</td>
					</tr>
					<tr>
						<!-- 승인여부 -->
						<th><spring:message code="labal.apprYn"/></th>
						<td>
							<input type="radio" name="accokYn" />
							<label for="apprAll"><spring:message code="labal.whole"/></label>
							<input type="radio" name="accokYn"  value="Y" checked="checked"/>
							<label for="appr"><spring:message code="btn.appr"/></label>
							<input type="radio" name="accokYn" value="N"/>
							<label for="unAppr"><spring:message code="btn.unAppr"/></label>
							<button type="button" class="btn01B" name="btn_searchWd" style="margin-left:10px;">
								<spring:message code="btn.inquiry"/>
							</button>
							${sessionScope.button.btn_reg}    
						</td>
					</tr>
				</table>	
				
				<!-- ibsheet 영역 -->
				<div style="clear: both;"></div>
				<div class="ibsheet_area_both" >
					<script type="text/javascript">createIBSheet("mySheet1", "100%", "300px"); </script>             
				</div>            
				</form>
			</div>                  
			                        
		</div>		
	                              
	</div>      
	<iframe name="iframePopUp" scrolling="no" frameborder="0" style="display: none;position: absolute;" src="" />			                                           
	<!--##  푸터  ##-->                
	<c:import  url="/WEB-INF/jsp/admin/adminfooter.jsp"/>
	<!--##  /푸터  ##-->  
</body>
</html>