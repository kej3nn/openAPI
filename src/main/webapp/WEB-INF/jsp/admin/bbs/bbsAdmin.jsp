<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="egovframework.common.WiseOpenConfig"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><spring:message code='wiseopen.title'/></title>
<c:import  url="/WEB-INF/jsp/inc/headinclude.jsp"/>
<!--
	validate 사용시 반드시 선언
	formName명과 validate 함수명이 연결되어있음
	adminCommOrg -> validateAdminCommOrg 체크함
	resources/validator/*.* xml을 만들어서 사용
  -->
<validator:javascript formName="bbsAdminAdd" staticJavascript="false" xhtml="true" cdata="false"/>
<script language="javascript">              
//<![CDATA[                              
function tabSet(){ //탭 객체 생성  
	openTab = new OpenTab(tabId,tabContentClass,tabBody); //headinclude.jsp 변수 있음
	openTab.TabObj = openTab;  
	openTab.addTabClickEvent();            
}	  
$(document).ready(function()    {
	LoadPage();	     	//메인 sheet
	setMainButton(); 	//메인 버튼
	inputEnterKey();	//엔터키
	setTabButton();		//탭 버튼
	doAction('search');	//조회 
	tabSet();			//tab 셋팅
});                                                       


/****************************************************************************************************
 * Main 관련
 ****************************************************************************************************/
// Setting
 function setMainButton(){
	var formObj = $("form[name=bbsAdmin]");
	/* $("button[name=btn_reg]").click(function(e) {	doAction("reg");	return false;	}); */
	
	$("button[name=btn_searchWd]").click(function(e) {
// 		if ( $("input[name=searchWord]").val() == "" ) {
// 			alert("검색어를 입력하세요."); return;
// 		} else if ( $("select[name=searchWd]").val() == "" ) {
// 			alert("검색항목을 선택하세요."); return;
// 		}
		doAction("search");	return false;	
	});
	
	formObj.find("button[name=btn_reg]").click(function(e) { 
		doAction("reg");
		 return false;                  
	 }); 
}

function buttonEventAdd(){
	setTabButton();
}

function LoadPage()                
{      
	//message-common_ko_KR.properties 선언 후 사용 or message-common_en_US.properties 선언 후 사용
	var gridTitle = "NO"
		gridTitle +="|"+"<spring:message code='labal.bbsCd'/>";  
		gridTitle +="|"+"<spring:message code='labal.bbsNm'/>";  
		gridTitle +="|"+"<spring:message code='labal.langCd'/>";        
		gridTitle +="|"+"<spring:message code='labal.typeCd'/>";        
		gridTitle +="|"+"<spring:message code='labal.useYn'/>";        
      
	
    with(mySheet1){
    	                     
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
					 {Type:"Seq",		SaveName:"seq",			Width:20,	Align:"Center",		Edit:false}
					,{Type:"Text",	 	SaveName:"bbsCd",		Width:40,	Align:"Center",		Edif:false}
					,{Type:"Text",		SaveName:"bbsNm",		Width:200,	Align:"Left",		Edit:false}
					,{Type:"Text",		SaveName:"langNm",		Width:50,	Align:"Center",		Edit:false}
					,{Type:"Text",		SaveName:"typeNm",		Width:50,	Align:"Left",		Edit:false}
					,{Type:"CheckBox",	SaveName:"useYn",		Width:30,	Align:"Center",		Edit:false, TrueValue:"Y", FalseValue:"N", DefaultValue:"Y"}
                ];       
                                      
        InitColumns(cols);                                                                           
        FitColWidth();                                                         
        SetExtendLastCol(1);   
    }               
    default_sheet(mySheet1);   
    mySheet1.SetCountPosition(0); 
}    


//Main Action                  
function doAction(sAction)                                  
{
	var classObj = $("."+tabContentClass); //tab으로 인하여 form이 다건임
	var actObj = setTabForm(classObj); // 0: form data, 1: form 객체
	ajaxBeforeSendAdmin("<c:url value='/admin/ajaxBeforeSendAdmin.do'/>"); //IbSheet 조회전 세션 체크
	switch(sAction)
	{          
		 case "search":      //조회   			
			mySheet1.DoSearch("<c:url value='/admin/bbs/bbsAdminListAll.do'/>", actObj[0]);
			break;
		 case "reg":      //등록화면
			var title = "등록하기"
			var id ="bbsCd";
			openTab.addRegTab(id,title,tabCallRegBack); // 탭 추가 시작함
			break;
		/*case "dup":  
			treeUp(mySheet1, true, "vOrder");	// obj, 순서설정플래그, 순서설정컬럼
			break;                 
		case "treeDown":              
			treeDown(mySheet1, true, "vOrder");
			break;
		case "updateTreeOrder" :
			ibsSaveJson = mySheet1.GetSaveJson(0);                                                    
			if(ibsSaveJson.data.length == 0) {
				alert("저장할 데이터가 없습니다.");  
				return;
			}
			var url = "<c:url value='/admin/basicinf/commOrgListUpdateTreeOrder.do'/>";
			IBSpostJson(url, ibsSaveJson, ibscallback);
			break; */
	}           
} 

/* 엔터조회*/
function inputEnterKey(){
	$("input").keypress(function(e) {
		  if(e.which == 13) {
			  doAction('search');   
			  return false;
		  }
	});
}  


function mySheet1_OnDblClick(row, col, value, cellx, celly) {
    if(row == 0) return;     
    tabEvent(row);                      
                          
}  

   
/****************************************************************************************************
 * Tab 관련
 ****************************************************************************************************/
 function tabEvent(row){//탭 이벤트 실행     
	var title = mySheet1.GetCellValue(row,"bbsNm");//탭 제목                                                    
	var id = mySheet1.GetCellValue(row,"bbsCd");//탭 id(유일한key))
    openTab.SetTabData(mySheet1.GetRowJson(row));//db data 조회시 조건 data
    var url = "<c:url value='/admin/bbs/selectBbsAdminList.do'/>"; // Controller 호출 url        
    openTab.addTab(id,title,url,tabAdminCallBack); // 탭 추가 시작함(callback함수 overring)          
} 

function tabAdminCallBack(tab,json){ //callBack 함수 
	tab.ContentObj.find("a[name=a_reg]").remove();
	
	if(json.DATA != null){
		$.each(json.DATA[0],function(key,state){
			if(key == 'langCd'){
				tab.ContentObj.find("[name="+key+"]"+":radio[value='"+state+"']").prop("checked",true);
			}
			if(tab.ContentObj.find("[name="+key+"]").attr("type") == 'radio'){ 
				tab.ContentObj.find("[name="+key+"]"+":radio[value='"+state+"']").prop("checked",true);
			}else if(tab.ContentObj.find("[name="+key+"]").attr("type") == 'checkbox'){          
				tab.ContentObj.find("[name="+key+"]"+":checkbox[value='"+state+"']").prop("checked",true);
			}else if(tab.ContentObj.find("[name="+key+"]").attr("type") == 'select'){
				tab.ContentObj.find("[name="+key+"]"+":select[value='"+state+"']").prop("checked",true);
			}else{          
				tab.ContentObj.find("[name="+key+"]").val(state).change();    
			}			
		});
		var classObj = $("."+tabContentClass); //tab으로 인하여 form이 다건임
	 	var actObj = setTabForm(classObj); // 0: form data, 1: form 객체
	 	var objTab = getTabShowObj();//탭이 oepn된 객체가져옴
		var formObj =objTab.find("form[name=bbsAdminAdd]");
	 	//언어,형태,코드,게시글분류 변경못하도록 속성변경
		formObj.find("select[name=bbsTypeCd]").attr("disabled",true);
		formObj.find("input[name=langCd]").attr("disabled",true);
		formObj.find("input[name=bbsCd]").attr("readonly",true);
		formObj.find("select[name=listCd]").attr("disabled",true);
		formObj.find("button[name=btn_dup]").attr("disabled",true);
		formObj.find("input[name=bbsCdDup]").val("Y");
	}
	
	setTabButton();
}
 function doTapAction(sAction)                                  
 {
 	var classObj = $("."+tabContentClass); //tab으로 인하여 form이 다건임
 	var actObj = setTabForm(classObj); // 0: form data, 1: form 객체
 	var objTab = getTabShowObj();//탭이 oepn된 객체가져옴
	var formObj =objTab.find("form[name=bbsAdminAdd]");
 	switch(sAction)
 	{          
 		 case "save":      //저장하기  
 			if ( formObj.find("select[name=bbsTypeCd]").val() == "" ) {
				alert("형태항목을 선택하세요."); return;
			}else if( formObj.find("input[name=bbsCd]").val() == "" ) {
				alert("코드를 입력하세요."); return;
			}else if(formObj.find("input[name=bbsNm]").val()==""){
				alert("게시판명을 입력하세요."); return;
			}else if(formObj.find('input[name=bbsCdDup]').val() == "N"){
				alert("중복확인 버튼을 클릭해주세요.")
				return;
			}
			if(formObj.find("input[name=atfileYn]").is(":checked")){
				 if(formObj.find("input[name=sizeLimit]").val() == ""){
					alert("최대크기를 입력하세요."); 
					return;
				 }
			}
// 			else{
// 				if(formObj.find("input[name=sizeLimit]").val() != ""){
// 					alert("첨부파일 사용을 선택하세요."); 
// 					return;
// 				 }
// 			}
			var url = "<c:url value='/admin/bbs/bbsAdminSave.do'/>";
			ajaxCallAdmin(url,actObj[0],saveCallBack);
 			break;
 		 case "dup": //코드 중복 체크
  			if(nullCheckValdation(formObj.find('input[name=usrNm]'),"코드","")){
				return true;
			}			
			var url = "<c:url value='/admin/bbs/bbsAdminCodeCheck.do'/>";			
			ajaxCallAdmin(url,actObj[0],dupCallBack);
 		 	break;
 		 case "modify": //수정
 			if ( !confirm("수정 하시겠습니까? ") ) {
				return;
  			}
	 		if ( formObj.find("select[name=bbsTypeCd]").val() == "" ) {
				alert("형태항목을 선택하세요."); return;
			}else if( formObj.find("input[name=bbsCd]").val() == "" ) {
				alert("코드를 입력하세요."); return;
			}else if(formObj.find("input[name=bbsNm]").val()==""){
				alert("게시판명을 입력하세요."); return;
			}else if(formObj.find('input[name=bbsCdDup]').val() == "N"){
				alert("중복확인 버튼을 클릭해주세요.")
				return;
			}
			if(formObj.find("input[name=atfileYn]").is(":checked")){
				 if(formObj.find("input[name=sizeLimit]").val() == ""){
					alert("최대크기를 입력하세요."); 
					return;
				 }
			}
// 			else{
// 				if(formObj.find("input[name=sizeLimit]").val() != ""){
// 					alert("첨부파일 사용을 선택하세요."); 
// 					return;
// 				 }
// 			}
			 var url = "<c:url value='/admin/bbs/bbsAdminUpdate.do'/>";
			 ajaxCallAdmin(url,actObj[0],saveCallBack);
			 break;
 		 case "delete":
 			if ( !confirm("삭제 하시겠습니까? ") ) {
				return;
  			}
 			 var url = "<c:url value='/admin/bbs/bbsAdminDelete.do'/>";
			 ajaxCallAdmin(url,actObj[0],deleteCallBack);
 			 break;
 	}
 }
 function setTabButton(){
 	var objTab = getTabShowObj();//탭이 oepn된 객체가져옴
	var formObj =objTab.find("form[name=bbsAdminAdd]");
	
	formObj.find("button[name=btn_dup]").click(function(e) {
		if ( formObj.find("input[name=bbsCd]").val() == "" ) {
			alert("검색어를 입력하세요."); return;
		}
		doTapAction("dup");	
		return false;	
	});
	
	formObj.find("a[name=a_reg]").click(function(e) {
		doTapAction("save");	
		return false;	
	});
	formObj.find("a[name=a_modify]").click(function(e) {
		doTapAction("modify");	
		return false;	
	});
	formObj.find("a[name=a_del]").click(function(e) {
		doTapAction("delete");	
		return false;	
	}); 
}


//코드 중복체크 콜백
function dupCallBack(res){
	var objTab = getTabShowObj();//탭이 oepn된 객체가져옴
	var formObj = objTab.find("form[name=bbsAdminAdd]");
	if(res.RESULT.CODE > 0){
		alert("중복된 코드가 존재합니다.");
		formObj.find("input[name=bbsCdDup]").val("N");
		return false;
	}else{                           
		alert("등록 가능합니다.");
		formObj.find("input[name=bbsCdDup]").val("Y");
		return;
	}
}

function OnSaveEnd(){
	doAction("search");
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
					<li><a href="#">공공데이터목록</a><a href="#" class="line_close">x</a></li>
				</ul>
			</div>
			-->
			
			              
			<!-- 탭 내용 -->
			<div class="content" style="display:none">
				<form name="bbsAdminAdd"  method="post" action="#">
				<input type="hidden" name="bbsCdDup" value="N"/>
				<input type="hidden" name="ansYn" value="Y"/>
				<table class="list01" id="commOrgTB">
					<caption>설문관리</caption>
					<colgroup>
						<col width="200"/>
						<col width=""/>
						<col width="200"/>
						<col width=""/>
					</colgroup>
					
					
					<!-- 등록 화면 -->
							<!-- 언어 -->
						<th><spring:message code="labal.langCd"/></th>
							<td>
								<input type="radio" name="langCd" value="LADE01" checked="checked"><spring:message code="labal.kor"/>
								<input type="radio" name="langCd" value="LADE02"><spring:message code="labal.eng"/>
							</td>
							<!-- 형태 -->
							<th><spring:message code="labal.typeCd"/></th>
							<td>							
								<select name="bbsTypeCd" sytle="width: 100px;">
									<option value=""></option>
									<c:forEach var="typeCd" items="${codeMap.typeCd }" varStatus="status">
											<option value="${typeCd.ditcCd }">${typeCd.ditcNm }</option>
											
									</c:forEach>
								</select>
								
							</td>
						<tr >
						<!-- ***************************************************************************************** -->
							<!-- 게시판코드 --> 
							<th><spring:message code="labal.code"/></th>
							<td colspan="3">
								<input type="text" name="bbsCd" value="" maxlength="25" style="width: 100px;"/>
								${sessionScope.button.btn_dup}
								<span >공백없이 영문자와 숫자로만 입력하세요. (20자이내)</span>
							</td>						
						</tr>
						<tr>
							<!-- 게시글 분류  -->
							<th><spring:message code="labal.ditcCd"></spring:message>
							<td colspan="3">
								<select name="listCd" sytle="width: 100px;">
									<option value=""></option>
									<c:forEach var="ditcCd" items="${codeMap.ditcCd }" varStatus="status">
											<option value="${ditcCd.ditcCd }">${ditcCd.ditcNm }</option>
												
									</c:forEach>
								</select>
								<select name="list1Cd" sytle="width: 100px;">
									<option value=""></option>
									<c:forEach var="ditcCd" items="${codeMap.ditcCd }" varStatus="status">
											<option value="${ditcCd.ditcCd }">${ditcCd.ditcNm }</option>
									</c:forEach>
								</select>&nbsp;
								<select name="list2Cd" sytle="width: 100px;">
									<option value=""></option>
									<c:forEach var="ditcCd" items="${codeMap.ditcCd }" varStatus="status">
											<option value="${ditcCd.ditcCd }">${ditcCd.ditcNm }</option>
									</c:forEach>
								</select>&nbsp;
								<select name="list3Cd" sytle="width: 100px;">
									<option value=""></option>
									<c:forEach var="ditcCd" items="${codeMap.ditcCd }" varStatus="status">
											<option value="${ditcCd.ditcCd }">${ditcCd.ditcNm }</option>
									</c:forEach>
								</select>&nbsp;
								<select name="list4Cd" sytle="width: 100px;">
									<option value=""></option>
									<c:forEach var="ditcCd" items="${codeMap.ditcCd }" varStatus="status">
											<option value="${ditcCd.ditcCd }">${ditcCd.ditcNm }</option>
									</c:forEach>
								</select>&nbsp;
													
							</td>
						</tr>
					
					<tr>
						<!-- 게시판명 -->
						<th><spring:message code="labal.bbsNm"/></th>
						<td colspan="3">
							<input type="text" name="bbsNm" value="" maxlength="100" style="width: 200px;"/>
						</td>
					</tr>
					<tr>
						<!-- 글쓰기 옵션 -->
						<th><spring:message code='labal.wtOption'/></th>
						<td colspan="3">
							<input type="checkbox" name="loginWtYn" value="Y"/>
								<spring:message code='labal.loginWtYn'/>&nbsp;&nbsp;&nbsp;
							<input type="checkbox" name="noticeYn" value="Y"/>
								<spring:message code='labal.noticeYn'/>&nbsp;&nbsp;&nbsp;
							<input type="checkbox" name="secretYn" value="Y"/>
								<spring:message code='labal.secretYn'/>&nbsp;&nbsp;&nbsp;
							<input type="checkbox" name="htmlYn" value="Y"/>
								<spring:message code='labal.htmlYn'/>&nbsp;&nbsp;&nbsp;
							<%-- <input type="checkbox" name="ansYn" value="Y"/>
								<spring:message code='labal.ansYn'/>&nbsp;&nbsp;&nbsp; --%>							
						</td>
					</tr>
					<tr>
						<!-- 첨부파일 -->
						<th><spring:message code='labal.atFile'/></th>
						<td>
							<input type="checkbox" name="atfileYn" value="Y"/>
								<spring:message code='labal.atfileYn'/>&nbsp;&nbsp;&nbsp;
								<spring:message code='labal.sizeLimit'/>
							<input type="text" name="sizeLimit" value="" style="width:50px"/>&nbsp;MB
								
						</td>
						<th><spring:message code='labal.extLimit'/></th>
						<td>
							<input type="radio" name="extLimit" value="BOTH" checked>
								<spring:message code='labal.exBoth'/>&nbsp;&nbsp;&nbsp;
							<input type="radio" name="extLimit" value="IMG">
								<spring:message code='labal.exImg'/>&nbsp;&nbsp;&nbsp;
							<input type="radio" name="extLimit" value="DOC">
								<spring:message code='labal.exDoc'/>&nbsp;&nbsp;&nbsp;
					</tr>
					<tr>
						<!-- 추가옵션 -->
						<th><spring:message code='labal.addOption'/></th>
						<td colspan="3">
							<input type="checkbox" name="linkYn" value="Y"/>
								<spring:message code='labal.linkYn'/>&nbsp;&nbsp;&nbsp;
							<input type="checkbox" name="infYn" value="Y"/>
								<spring:message code='labal.infYn'/>&nbsp;&nbsp;&nbsp;
								<spring:message code='labal.listCnt'/>
							<input type="text" name="listCnt" value="" style="width:20px"/>&nbsp;&nbsp;&nbsp;
								<spring:message code='labal.hlCnt'/>
							<input type="text" name="hlCnt" value="" style="width:40px"/>		
						</td>
					</tr>
					<tr>
						<!-- 이메일 -->
						<th><spring:message code='labal.email'/></th>
						<td colspan="3">
							<input type="checkbox" name="emailRegYn" value="Y">
								<spring:message code='labal.emailYn'/>&nbsp;&nbsp;&nbsp;
							<input type="checkbox" name="emailNeedYn" value="Y">
								<spring:message code='labal.needYn'/>	
						</td>						
					</tr>
					<tr>
						<!-- 연락처 -->
						<th><spring:message code='labal.tel'/></th>
						<td colspan="3">
							<input type="checkbox" name="telYn" value="Y">
								<spring:message code='labal.telYn'/>&nbsp;&nbsp;&nbsp;
							<input type="checkbox" name="telNeedYn" value="Y">
								<spring:message code='labal.needYn'/>	
						</td>
					</tr>
					<tr>
						<!-- 게시판설명 -->
						<th><spring:message code="labal.bbsExp"/></th>
						<td colspan="3">
<!-- 							<input type="text" name="bbsExp" value="" style="width: 200px;"/> -->
<!-- 							<span>게시판의 설명 메시지로 출력됩니다.</span> -->
							<textarea rows="2"   maxlength="2000" name="bbsExp" value="" maxlangth="660" style="width: 600px;"></textarea>
							<span>게시판의 설명 메시지로 출력됩니다.</span>
						</td>
					</tr>
					<tr>
						<!-- 게시물 처리 -->
						<th><spring:message code='labal.ansTag'/></th>
						<td colspan="3">
							<input type="radio" id="ansTagN" name="ansTag" value="N" checked="checked"/><spring:message code='labal.ansTagN'/>&nbsp;&nbsp;&nbsp;
							<input type="radio" id="ansTagA" name="ansTag" value="A"><spring:message code='labal.ansTagY'/>&nbsp;&nbsp;&nbsp;
							<input type="radio" id="ansTagR" name="ansTag" value="R"><spring:message code='labal.ansTagR'/>&nbsp;&nbsp;&nbsp;
							<input type="radio" id="ansTagB" name="ansTag" value="B">보고&nbsp;&nbsp;&nbsp;
					</tr>
					<tr>
						<!-- 사용여부 -->
						<th><spring:message code="labal.useYn"/></th>
						<td colspan="3">
							<input type="radio" name="useYn" value="Y" class="input" checked="checked"/>
							<label for="use"><spring:message code="labal.yes"/></label>
							<input type="radio" name="useYn" value="N" class="input"/>
							<label for="unuse"><spring:message code="labal.no"/></label>
						</td>
					</tr>
					
				</table>	
				
				<div class="buttons" >
					<!-- <input type="button" name="a_reg" class="btn03" value="등록"> -->
					${sessionScope.button.a_reg}
					${sessionScope.button.a_modify}
					${sessionScope.button.a_del}
				</div>
				</form>
			</div>

			<!-- 목록내용 -->
			<div class="content"  >
				<form name="bbsAdmin"  method="post" action="#">
				<table class="list01">              
					<caption>설문관리목록</caption>
					<colgroup>
						<col width="150"/>
						<col width=""/>
						<col width=""/>
					</colgroup>       
					<tr>
						<!-- 검색어 -->
						<th><spring:message code="labal.search"/></th>
						<td colspan="3">
							<select name="searchWd" style="width: 100px;">
								<option value="">선택</option>
								<option value="1" selected="selected"><spring:message code="labal.bbsNm"/></option>
							</select>
							<input type="text" name="bbsNm" value=""  style="width: 300px"/>
							<button type="button" class="btn01B" name="btn_searchWd">
								<spring:message code="btn.inquiry"/>
							</button>
							${sessionScope.button.btn_reg}    
						</td>
					</tr>
					<tr>
						<th>
							<spring:message code="labal.langCd"/>
						</th>
						<td >
							<select name="langCd" sytle="width: 100px;">
								<option value="">선택</option>
								<c:forEach var="langCd" items="${codeMap.langCd }" varStatus="status">
										<option value="${langCd.ditcCd }">${langCd.ditcNm }</option>
								</c:forEach>
							</select>
						</td>
						<th>
							<spring:message code="labal.typeCd"/>
						</th>
						<td>
							<select name="bbsTypeCd" sytle="width: 100px;">
								<option value="">선택</option>
								<c:forEach var="typeCd" items="${codeMap.typeCd }" varStatus="status">
										<option value="${typeCd.ditcCd }">${typeCd.ditcNm }</option>

								</c:forEach>
							</select>
							</select>&nbsp;
						</td>
					</tr>
					<tr>
						<!-- 사용여부 -->
						<th><spring:message code="labal.useYn"/></th>
						<td colspan="3">
							<input type="radio" name="useYn" checked="checked"/>
							<label for="useAll"><spring:message code="labal.whole"/></label>
							<input type="radio" name="useYn"  value="Y"/>
							<label for="use"><spring:message code="labal.yes"/></label>
							<input type="radio" name="useYn" value="N"/>
							<label for="unuse"><spring:message code="labal.no"/></label>
						</td>
					</tr>
				</table>	
				<!-- ibsheet 영역 -->
				<div style="clear: both;"></div>
				<div class="ibsheet_area_both">
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