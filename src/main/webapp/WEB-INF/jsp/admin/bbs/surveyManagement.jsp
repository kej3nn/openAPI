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
	tabSet();			//tab 셋팅
	doAction('search');	//조회
	orgInputEnterKey(); //탭에서 담당조직팝업 엔터키조회
	usrInputEnterKey(); //탭에서 담당자 팝업 엔터키조회
	
 	 
});
var oEditors = [];
function dHtmlYn(){
	nhn.husky.EZCreator.createInIFrame({ 
		oAppRef: oEditors, 
		elPlaceHolder: "surveyDesc",	// 에디터 적용할 textarea 이름
		sSkinURI: "/SmartEditor2/SmartEditor2Skin.html", 
		fCreator: "createSEditor2" ,
		htParams : { 
			fOnBeforeUnload : function(){ 
				//alert("onbeforeunload call"); 
			}
		},
		formObj: "adminSurvey"	// form 이름 
	});
}



/****************************************************************************************************
 * Main 관련
 ****************************************************************************************************/
// Setting
 function setMainButton(){
	$("button[name=btn_reg]").click(function(e) {	doAction("reg");	return false;	}); 
	
	$("button[name=btn_inquiry]").click(function(e) {
		doAction("search");	return false;	
	});
}

function LoadPage()                
{      
	//message-common_ko_KR.properties 선언 후 사용 or message-common_en_US.properties 선언 후 사용
	var gridTitle = "NO"
		gridTitle +="|"+"<spring:message code='labal.surveyId'/>";  
		gridTitle +="|"+"<spring:message code='labal.surveyNm'/>";  
		gridTitle +="|"+"<spring:message code='labal.langTag'/>";        
		gridTitle +="|"+"<spring:message code='labal.ipDupYn'/>";        
		gridTitle +="|"+"<spring:message code='labal.startDttm'/>";        
		gridTitle +="|"+"<spring:message code='labal.endDttm'/>";        
		gridTitle +="|"+"<spring:message code='labal.orgCd'/>";        
		gridTitle +="|"+"<spring:message code='labal.orgNm'/>";        
		gridTitle +="|"+"<spring:message code='labal.usrCd'/>";        
		gridTitle +="|"+"<spring:message code='labal.usrNm'/>";        
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
					,{Type:"Text",		SaveName:"surveyId",	Width:50,	Align:"Right",		Edit:false}
					,{Type:"Text",		SaveName:"surveyNm",	Width:200,	Align:"Left",		Edit:false}
					,{Type:"Text",		SaveName:"langTag",		Width:40,	Align:"Center",		Edit:false}
					,{Type:"Text",		SaveName:"ipDupYn",		Width:40,	Align:"Center",		Edit:false}
			 		,{Type:"Text",		SaveName:"startDttm",	Width:100,	Align:"Left",		Edit:false}
					,{Type:"Text",		SaveName:"endDttm",		Width:100,	Align:"Left",		Edit:false} 
					,{Type:"Text",		SaveName:"orgCd",		Width:80,	Align:"Center",		Edit:false,		Hidden:true}
					,{Type:"Text",		SaveName:"orgNm",		Width:80,	Align:"Center",		Edit:false}
					,{Type:"Text",		SaveName:"usrCd",		Width:60,	Align:"Right",		Edit:false,		Hidden:true}
					,{Type:"Text",		SaveName:"usrNm",		Width:60,	Align:"Center",		Edit:false}
					,{Type:"CheckBox",	SaveName:"useYn",		Width:40,	Align:"Center",		Edit:false, TrueValue:"Y", FalseValue:"N", DefaultValue:"Y"}
                ];       
                                      
        InitColumns(cols);                                                                           
        FitColWidth();                                                         
        SetExtendLastCol(1);   
    }               
    default_sheet(mySheet1);   
}

/* 탭 sheet 문항 */
function LoadDetail(sheetName)                
{      
	//message-common_ko_KR.properties 선언 후 사용 or message-common_en_US.properties 선언 후 사용
	var gridTitle = "상태|삭제"
		gridTitle +="|"+"<spring:message code='labal.questNo'/>";  
		gridTitle +="|"+"<spring:message code='labal.grpExp'/>";  
		gridTitle +="|"+"<spring:message code='labal.questNm'/>";        
		gridTitle +="|"+"<spring:message code='labal.questCd'/>";        
		gridTitle +="|"+"<spring:message code='labal.maxDupCnt'/>";        
		gridTitle +="|"+"<spring:message code='labal.useYn'/>";        
	
    with(sheetName){
    	                     
    	var cfg = {SearchMode:2,Page:50,VScrollMode:1};                                
        SetConfig(cfg);  
        var headers = [                               
                    {Text:gridTitle, Align:"Center"}                 
                ];
        var headerInfo = {Sort:0,ColMove:1,ColResize:1,HeaderCheck:1};
        
        InitHeaders(headers, headerInfo); 
        
         
      	//문자는 왼쪽정렬
        //숫자는 오른쪽정렬
        //코드값은 가운데정렬
        var cols = [ 
					 {Type:"Status",	SaveName:"status",			Width:20,	Align:"Center",		Edit:false}
					,{Type:"DelCheck",	SaveName:"delChk",			Width:20,	Align:"Center",		Edit:true}
					,{Type:"Text",		SaveName:"questNo",			Width:40,	Align:"Center",		Edit:true, KeyField:1}
					,{Type:"Text",		SaveName:"grpExp",			Width:170,	Align:"Left",		Edit:true}
					,{Type:"Text",		SaveName:"questNm",			Width:300,	Align:"Left",		Edit:true, KeyField:1}
					,{Type:"Combo",		SaveName:"examCd",			Width:70,	Align:"Center",		Edit:true, KeyField:1 , TrueValue:"Y", FalseValue:"N", DefaultValue:"Y"}
					,{Type:"Text",		SaveName:"maxDupCnt",		Width:30,	Align:"Left",		Edit:false}
					,{Type:"CheckBox",	SaveName:"useYn",			Width:30,	Align:"Center",		Edit:true, TrueValue:"Y", FalseValue:"N", DefaultValue:"Y"}
					,{Type:"Text",		SaveName:"surveyId",		Width:0,	Align:"Left",		Edit:false, Hidden:1}
					,{Type:"Text",		SaveName:"questSeq",		Width:0,	Align:"Center",		Edit:false, Hidden:1}
                ];       
                                      
        InitColumns(cols);                                                                           
        FitColWidth();                                                         
        SetExtendLastCol(1); 
        SetColProperty("examCd",${codeMap.examCdIbs});
    }               
    default_sheet(sheetName);   
}


/* 탭 sheet 지문 */
function LoadDetail2(sheetName)                
{      
	//message-common_ko_KR.properties 선언 후 사용 or message-common_en_US.properties 선언 후 사용
	var gridTitle = "상태|삭제|NO";
		gridTitle +="|"+"<spring:message code='labal.grpExp2'/>";  
		gridTitle +="|"+"<spring:message code='labal.questExamNm'/>";
		gridTitle +="|"+"<spring:message code='labal.questExamExp'/>";
		gridTitle +="|"+"<spring:message code='labal.etcYn'/>";        
		gridTitle +="|"+"<spring:message code='labal.useYn'/>";        
	
    with(sheetName){
    	                     
    	var cfg = {SearchMode:2,Page:50,VScrollMode:1};                                
        SetConfig(cfg);  
        var headers = [                               
                    {Text:gridTitle, Align:"Center"}                 
                ];
        var headerInfo = {Sort:0,ColMove:1,ColResize:1,HeaderCheck:1};
        
        InitHeaders(headers, headerInfo); 
        
         
      	//문자는 왼쪽정렬
        //숫자는 오른쪽정렬
        //코드값은 가운데정렬
        var cols = [ 
					 {Type:"Status",	SaveName:"status",			Width:20,	Align:"Center",		Edit:false}
					,{Type:"DelCheck",	SaveName:"delChk",			Width:20,	Align:"Center",		Edit:true}
					,{Type:"Int",		SaveName:"vOrder",			Width:30,	Align:"Center",		Edit:false}
					,{Type:"Text",		SaveName:"grpExp",		Width:150,	Align:"Left",		Edit:true}
					,{Type:"Text",		SaveName:"examNm",		Width:200,	Align:"Left",		Edit:true , KeyField:1}
					,{Type:"Text",		SaveName:"examExp",		Width:200,	Align:"Left",		Edit:true}
					,{Type:"CheckBox",	SaveName:"etcYn",		Width:30,	Align:"Left",		Edit:true, TrueValue:"Y", FalseValue:"N", DefaultValue:"Y"}
					,{Type:"CheckBox",	SaveName:"useYn",		Width:30,	Align:"Center",		Edit:true, TrueValue:"Y", FalseValue:"N", DefaultValue:"Y"}
					,{Type:"Text",		SaveName:"surveyId",		Width:0,	Align:"Left",		Edit:false, Hidden:1}
					,{Type:"Text",		SaveName:"questSeq",		Width:20,	Align:"Center",		Edit:false, Hidden:1}
					,{Type:"Text",		SaveName:"examSeq",		Width:20,	Align:"Left",		Edit:false, Hidden:1}
                ];       
                                      
        InitColumns(cols);                                                                           
        FitColWidth();                                                         
        SetExtendLastCol(1); 
    }               
    default_sheet(sheetName);   
}

 function OnSaveEnd(){
	doAction("search");
}
 

//Main Action                  
function doAction(sAction)                                  
{
	var classObj = $("."+tabContentClass); //tab으로 인하여 form이 다건임
	var actObj = setTabForm(classObj); // 0: form data, 1: form 객체
	
	switch(sAction)
	{          
		case "search":      //조회   
			ajaxBeforeSendAdmin("<c:url value='/admin/ajaxBeforeSendAdmin.do'/>"); //IbSheet 조회전 세션 체크
			mySheet1.DoSearch("<c:url value='/admin/bbs/surveyListAll.do'/>", actObj[0]);
			break;
			
		case "reg":      //등록화면 탭 생성
			tabEventReg();
			break;
	}           
} 

/* 엔터조회*/
function inputEnterKey(){
	$("input[name=searchWord]").keypress(function(e) {
		  if(e.which == 13) {
			  doAction('search');
			  return false;
		  }
	});
}
 
/* 엔터조회 담당조직 검색*/
function orgInputEnterKey(){
	$("input[name=orgCdSearch]").keypress(function(e) {
		  if(e.which == 13) {
			  doActionTab('orgPop');   
			  return false;
		  }
	});
}

/* 엔터조회 담당자 검색*/
function usrInputEnterKey(){
	$("input[name=usrNm]").keypress(function(e) {
		  if(e.which == 13) {
			  doActionTab('usrNmPop');   
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

//탭 추가 시 버튼 Setting
//등록하기 탭 
function tabEventReg(){
	var title = "등록하기";
	var id ="dsReg";
	openTab.addRegTab(id,title,tabCallRegBack); // 탭 추가 시작함
	
	//탭이 추가되면서 설문기간이 종료되었다면 수정,삭제 버튼 숨긴다.
    var objTab = getTabShowObj();//탭이 oepn된 객체가져옴1
	var formObj = objTab.find("form[name=adminSurvey]");
	formObj.find("div[name=examQuestDiv]").css("display","none");    
	formObj.find("a[name=a_up]").css("display","none");  //위로이동,아래로이동 버튼은 등록하기에선 숨긴다.
	formObj.find("a[name=a_down]").css("display","none");
	formObj.find("a[name=a_view]").css("display","none");
	dHtmlYn();
	buttonEventAdd();
}


function SheetCreate(SheetCnt){
	var SheetNm = "QuestSheet"+SheetCnt;   
	var SheetNmExam = "ExamSheet"+SheetCnt;   
	
	$("div[name=tapSheet1]").eq(1).attr("id","TAP1_"+SheetNm);   //id를 추가  
	createIBSheet2(document.getElementById("TAP1_"+SheetNm),SheetNm, "100%", "172px"); //sheet생성    
	$("div[name=tapSheet2]").eq(1).attr("id","TAP2_"+SheetNm);   //id를 추가                                       
 	createIBSheet2(document.getElementById("TAP2_"+SheetNm),SheetNmExam, "100%", "190px"); //sheet생성   
	
	var sheetobj = window[SheetNm]; // 변수에 sheet객체 저장하여 활용.문항
	var sheetobj2 = window[SheetNmExam]; // 변수에 sheet객체 저장하여 활용. 지문
	
	window[SheetNm + "_OnDblClick"] =  OnDblClick; //동적sheet명에서 onClick()사용하게 한다.
	window[SheetNm + "_OnValidation"] = OnValidation;
	window[SheetNm + "_OnChange"] = OnChange;
	
	var objTab = getTabShowObj();//탭이 oepn된 객체가져옴
	var formObj = objTab.find("form[name=adminSurvey]");
	
	formObj.find("input[name=sheetNm]").val(SheetNm);
	formObj.find("input[name=sheetNm2]").val(SheetNmExam);
	
	LoadDetail(sheetobj);	//sheet 설정 문항
	LoadDetail2(sheetobj2);	//sheet 설정 지문
	
	
}



 //탭 추가 이벤트
 var sheetNmCnt = 0; //sheet명 중복방지 
 function tabEvent(row){
 	var title = mySheet1.GetCellValue(row,"surveyNm");//탭 제목                                           
 	var id = mySheet1.GetCellValue(row,"surveyId");//탭 id(유일한key))
    openTab.SetTabData(mySheet1.GetRowJson(row));//db data 조회시 조건 data
    var url = "<c:url value='/admin/bbs/surveyRetr.do'/>"; // Controller 호출 url     
    var sheetYn = openTab.tabExits(id); //탭존재 여부   
    openTab.addTab(id,title,url,tabCallBack2); // 탭 추가 시작함(callback함수 overring)
    if(!sheetYn){//탭이 있을 경우 IBSheet 로드 방직     
	 	 var cnt = sheetNmCnt++;
	 	 SheetCreate(cnt);
	 	 doActionTab("questSearch");//탭이 생성되면 문항 자동조회.
	 	 dHtmlYn();

	 	 var param = "surveyId="+id;
	 	 ansRegCheck(param);
	 	
		 var objTab = getTabShowObj();//탭이 oepn된 객체가져옴
		 var formObj = objTab.find("form[name=adminSurvey]");
	     //지문의 버튼들은 초기에 안보이도록 한다. 문항유형에 따라 보이도록 설정함.
	     formObj.find("#examQuestDiv2").css("display","none"); //지문 sheet 숨김
	   	 //탭이 추가되면서 설문기간이 종료되었다면 수정,삭제,추가 ,등록 버튼 숨긴다.
	     if(!getTodayCheck("hide")){ //설문기간이 종료되었다면 실행
	    	 updateBlock();
	     }
	     buttonEventAdd();
    }else{
    	buttonEventAdd();
    }
 }
 
 function buttonEventAdd(){ //버튼 이벤트 사라짐 overring하여 버튼 이벤트 추가사용
		setTabButton();
}
 
 function tabCallBack2(tab,json){ //callBack 함수 그냥 tabCallBack으로 사용하니 setTabButton()호출하여 이중눌림발생.. 
		tab.ContentObj.find("a[name=a_reg]").remove();             
		if(json.DATA != null){               
			$.each(json.DATA,function(key,state){ 
				if(tab.ContentObj.find("[name="+key+"]").attr("type") == 'radio'){          
					tab.ContentObj.find("[name="+key+"]"+":radio[value='"+state+"']").prop("checked",true);                                                                          
				}else if(tab.ContentObj.find("[name="+key+"]").attr("type") == 'checkbox'){          
					tab.ContentObj.find("[name="+key+"]"+":checkbox[value='"+state+"']").prop("checked",true);                                                                          
				}else{          
					tab.ContentObj.find("[name="+key+"]").val(state).change();                           
				}
			}); 
		}        
	} 
 
//탭이 추가되면서  수정,삭제,추가 ,등록 등등 버튼들을 숨긴다.
 function updateBlock(){
	 var objTab = getTabShowObj();//탭이 oepn된 객체가져옴
	 var formObj = objTab.find("form[name=adminSurvey]");
	 
	 var sheetObj = formObj.find("input[name=sheetNm]").val(); //sheet명 가져온다.
	 var sheetObj2 = formObj.find("input[name=sheetNm2]").val(); //sheet명 가져온다.
	 var SheetNm = window[sheetObj];
	 var SheetNm2 = window[sheetObj2];
	 SheetNm.SetEditable(0); //sheet에서 수정 막는다. 0막기, 1 풀기
	 SheetNm2.SetEditable(0);
	 formObj.find("a[name=a_modify]").css("display","none"); //수정
	 formObj.find("a[name=a_del]").css("display","none"); //삭제
	 formObj.find("a[name=a_add]").css("display","none");  //추가
	 formObj.find("a[name=a_reg_quest]").css("display","none"); //등록
	 formObj.find("a[name=a_up]").css("display","none");  //위로이동
	 formObj.find("a[name=a_down]").css("display","none"); // 아래로이동
 }
 
 function ansRegCheck(param) { //ajax사용 해당설문에 대해 응답자가 있는지 확인..
   $.ajax({           
   url: "/admin/bbs/surveyAnsRegCheck.do",                 
   async: false,                    
   type: "POST",           
   data: param,                                    
   dataType: 'json', 
   beforeSend : function(xhr) {// ajax 호출시 사용자 인증정보가 잇는지 확인
			xhr.setRequestHeader("AJAX", "true");                  
		},
   success: function(res){ 
	   if(res.RESULT.CODE > 0){ //응답결과가 1명이라도 있으면 수정못하도록 막는다.
		   updateBlock();
	   }
	   
   },                             
   error:function(request,textStatus){
  	 if(request.status == 9999){                
  		 $("form").eq(0).attr("action",getContextPath+"/main.do").submit();
  	 }else{
  		 alert('에러발생...' + textStatus);
  	 }
   }
});
}
 

 
 
 function OnDblClick(Row, Col, Value, CellX, CellY, CellW, CellH) {
//	 var SheetNm = sheetobjTemp1;
 	 var objTab = getTabShowObj();//탭이 oepn된 객체가져옴
	 var formObj = objTab.find("form[name=adminSurvey]");
	 var sheetObj = formObj.find("input[name=sheetNm]").val(); //sheet명 가져온다.
	 var SheetNm = window[sheetObj];
	 var maxDupCnt = SheetNm.GetCellText(Row,"maxDupCnt"); //체크하려는 전체 row중 해당 컬럼지정
	
	 if('CHECK 버튼 지문'==SheetNm.GetCellText(Row,"examCd") ){
		 SheetNm.SetCellEditable(Row,"maxDupCnt",1); //check버튼눌렀을때만 edit 편집가능하도록
	 }else{
		 SheetNm.SetCellEditable(Row,"maxDupCnt",0); //check버튼아니라면 edit 편집불가
	 }
	 
	 if(SheetNm.GetCellText(Row,"status") == "입력" || SheetNm.GetCellText(Row,"status") == "수정"){ //입력,수정 하는상태라면 지문 조회가 안되게한다. 
		 return ; 
	 } 
		 
	 var objTab = getTabShowObj();//탭이 oepn된 객체가져옴
	 var formObj = objTab.find("form[name=adminSurvey]");
	 
	 if('CHECK 버튼 지문'==SheetNm.GetCellText(Row,"examCd") || 'RADIO 버튼 지문'==SheetNm.GetCellText(Row,"examCd")){ //지문추가가능
		 $("form[name=adminSurvey] input[name=questSeq]").val(SheetNm.GetCellText(Row,"questSeq")); //questSeq값 저장
		 
		 formObj.find("#examQuestDiv2").css("display","block"); //지문 sheet 보임
		// SheetNm.SetCellEditable(Row,"maxDupCnt",1); //check버튼눌렀을때만 edit 편집가능하도록
		 doActionTab("examSearch");//지문조회
	 }else{
		 formObj.find("#examQuestDiv2").css("display","none"); //지문 sheet 숨김
		 
	 }
	
	 
 }
 
 function OnValidation(Row, Col, Value) {
	 
	 //var SheetNm = sheetobjTemp1; //sheet객체 
	 var objTab = getTabShowObj();//탭이 oepn된 객체가져옴
	 var formObj = objTab.find("form[name=adminSurvey]");
	 var sheetObj = formObj.find("input[name=sheetNm]").val(); //sheet명 가져온다.
	 var SheetNm = window[sheetObj];
	 var questNo = SheetNm.GetCellText(Row,"questNo"); //체크하려는 전체 row중 해당 컬럼지정
	 var maxDupCnt = SheetNm.GetCellText(Row,"maxDupCnt"); //체크하려는 전체 row중 해당 컬럼지정
	 
	 if(numcheckQuest(questNo) ){  //문항번호 숫자와 - 만 사용가능.
		 SheetNm.ValidateFail(1);  //저장실패하게
		 SheetNm.SetCellValue(Row, "questNo", ""); //잘못기입된것 공백으로 초기화
		 alert("문항번호는 숫자, - 가능합니다. ");
	 }
	 
	 if('CHECK 버튼 지문'==SheetNm.GetCellText(Row,"examCd") ){
		 if( (numcheckQuest2(maxDupCnt) & maxDupCnt != "" ) || (maxDupCnt < 1 ) ){  //최대선택은 1이상의 숫자만 가능.
			 SheetNm.ValidateFail(1);  //저장실패하게
			 SheetNm.SetCellValue(Row, "maxDupCnt", "1"); //잘못기입된것 공백으로 초기화
			 alert("최대선택은 1이상의 숫자만 가능합니다. ");
		 }
	 }
	 
	 
 }
 
 function OnChange(Row, Col, Value, OldValue, RaiseFlag) {
//	 var SheetNm = sheetobjTemp1; //sheet객체
	 var objTab = getTabShowObj();//탭이 oepn된 객체가져옴
	 var formObj = objTab.find("form[name=adminSurvey]");
	 var sheetObj = formObj.find("input[name=sheetNm]").val(); //sheet명 가져온다.
	 var SheetNm = window[sheetObj];
	 var examCd = SheetNm.GetCellText(Row,"examCd");
	 var maxDupCnt = SheetNm.GetCellText(Row,"maxDupCnt"); //체크하려는 전체 row중 해당 컬럼지정
	 if(examCd == "CHECK 버튼 지문" ){
		  SheetNm.SetCellEditable(Row,"maxDupCnt",1); //check버튼눌렀을때만 edit 편집가능하도록
		  if( maxDupCnt < 1 ){
		  	SheetNm.SetCellValue(Row, "maxDupCnt", "1"); //기본설정 check는 1개이상 선택해야한다.
		  }
	 }else{
		 SheetNm.SetColEditable("maxDupCnt",0); //그외는 전부 편집못하도록 설정
		 SheetNm.SetCellValue(Row, "maxDupCnt", "0"); //초기화
	 }
 }
 
//숫자, - 하이픈으로  구성되어있는지 체크
 function numcheckQuest(val){
 	var pat = /^[0-9-]/g;
 	return check(val,pat);
 }
 
 function numcheckQuest2(val){ //오직 숫자만 입력가능
	 	var pat = /^[0-9]/g;
	 	return check(val,pat);
	 }
 
 
 //설문기간 달력체크에서 오늘날짜를 출력후 체크
 function getTodayCheck(statusInfo){
	 var objTab = getTabShowObj();//탭이 oepn된 객체가져옴
	 var formObj = objTab.find("form[name=adminSurvey]");
	 var status = statusInfo; //조건위한 상태값.
	 var result = true;
	 
	 var now = new Date;
	 var year = now.getFullYear();  //년도
	 var month =now.getMonth()+1;	//월
	 if((month + "").length < 2){   // 월의 자리수가 1인경우 앞에 0붙임.ex) 01,02,03..10,11,12
		 month = "0" + month;
	 }
	 var date = now.getDate();		//날
	 if((date + "").length < 2){
		 date = "0" + date;
	 }
	 var today = year + "-" + month + "-" + date; 
	 
	 var startDttm = formObj.find("input[name=startDttm]").val() ; //설문 시작날짜
	 var endDttm = formObj.find("input[name=endDttm]").val() ; //설문 종료날짜
	 if("check" == status){
		 //설문날짜
		 if(endDttm < today ){
			 alert("설문기간을 다시 확인해주세요.");
			 result = false;
		 }else if(startDttm > endDttm){
			 alert("설문기간을 다시 확인해주세요.");
			 result = false;
		 }
	 }else if("hide" == status){
		 if(endDttm < today ){
			 result = false;
		 }
	 }
	 
	 return result;
 }

 

//Tab action
 function doActionTab(sAction)
 {
 	var classObj = $("."+tabContentClass); //tab으로 인하여 form이 다건임
 	var actObj = setTabForm(classObj); // 0: form data, 1: form 객체
 	var objTab = getTabShowObj();//탭이 oepn된 객체가져옴
 	var formObj = objTab.find("form[name=adminSurvey]");
 	
 	var sheetObj = formObj.find("input[name=sheetNm]").val();  
 	var sheetObj2 = formObj.find("input[name=sheetNm2]").val(); 
 	
 	ajaxBeforeSendAdmin("<c:url value='/admin/ajaxBeforeSendAdmin.do'/>"); //IbSheet 조회전 세션 체크
 	var gridObj = window[sheetObj];
 	var gridObj2 = window[sheetObj2];
 	switch(sAction)                    
 	{
 		case "save" :		// 신규등록(insert)
 			if (validateAdminSurveyExam(formObj)) {	return false;	}	//validation 체크
 	
 		 	if(!getTodayCheck("check") ){ // 설문기간 문제시 실행.
 		 		return false;
 		 	}
 			
 		 	
 			var url =  "<c:url value='/admin/bbs/surveyReg.do'/>";
 			var param = openTab.ContentObj.find("[name=adminSurvey]").serialize(); //폼정보 serialize
 			ajaxCallAdmin(url, param, saveCallBack); //saveCallBackCheckbox 체크박스제거 및 자동조회가능.
 			doAction("search");
 			break;
 			
 		case "update" : 	// 수정(UPDATE)
 			if (validateAdminSurveyExam(formObj)) {	return false;	}	//validation 체크
 		
 		 	if(!getTodayCheck("check") ){ // 설문기간 문제시 실행.
 		 		return false;
 		 	}
 			
 			if ( confirm("수정 하시겠습니까? ") ) {
	 			var url = "<c:url value='/admin/bbs/surveyUpd.do'/>";
	 			var param = openTab.ContentObj.find("[name=adminSurvey]").serialize(); //폼정보 serialize
	 			ajaxCallAdmin(url, param, saveCallBack);  //saveCallBackCheckbox는 체크문제로 재정의하였음.
			}
 			break;
 		
 		case "delete" :		// 삭제
 			if ( confirm("삭제 하시겠습니까? ") ) {
 				var param = openTab.ContentObj.find("[name=adminSurvey]").serialize(); //폼정보 serialize
 				var url = "<c:url value='/admin/bbs/surveyDel.do'/>";
 				ajaxCallAdmin(url, param, saveCallBackCheckbox);
 			}
 			break;
 	
 			
 		case "addQuest" : //추가
 			var SheetNm = gridObj; //sheet명 가져온다.
 			var newRow = SheetNm.DataInsert(-1); //sheet 마지막행에 추가하도록 한다.
 			SheetNm.SetCellValue(newRow, "questSeq", 0);
 			break;
			
 			
 		case "addExam" : //추가
 			var SheetNm = gridObj2; //sheet명 가져온다.
 			SheetNm.DataInsert(-1); //sheet 마지막행에 추가하도록 한다.
 			break;
	
 		case "questSave" : //설문항목 등록/ 수정
 			if ( !confirm("수정 하시겠습니까? ") ) {
				return;
  			}
 			var SheetNm = gridObj; //sheet명 가져온다.
 			ibsSaveJson = SheetNm.GetSaveJson(0); //전체저장은 '1' 
 			if(ibsSaveJson.data.length == 0) {
				alert("저장할 데이터가 없습니다.");  
				return;
			}
 			var param = openTab.ContentObj.find("[name=adminSurvey]").serialize(); //폼정보 serialize
 			var url = "<c:url value='/admin/bbs/surveyQuestAdd.do'/>"+"?"+param;
 			IBSpostJson(url, ibsSaveJson, ibscallback);
 			doActionTab("questSearch");//문항조회
			break;
		
		case "examSave" : //지문 등록/수정
			if ( !confirm("수정 하시겠습니까? ") ) {
				return;
  			}
			var SheetNm = gridObj2; //sheet명 가져온다.
 			ibsSaveJson = SheetNm.GetSaveJson(1); //전체저장은 '1' 
 			if(ibsSaveJson.data.length == 0) {
				alert("저장할 데이터가 없습니다.");  
				return;
			}
 		 	var param = openTab.ContentObj.find("[name=adminSurvey]").serialize(); //폼정보 serialize
 			var url = "<c:url value='/admin/bbs/surveyExamAdd.do'/>"+"?"+param;
 			IBSpostJson(url, ibsSaveJson, ibscallback);
 			doActionTab("examSearch");//지문조회
			break;
		
		case "questSearch":      //조회
			var SheetNm = gridObj; //sheet명 가져온다.
			var param = openTab.ContentObj.find("[name=surveyId]").serialize(); //폼정보 serialize
			SheetNm.DoSearch("<c:url value='/admin/bbs/surveyQuestListAll.do'/>", param);
			$("form[name=adminSurvey] input[name=questSeq]").val("0"); //questSeq값 초기화
			SheetNm.SetColEditable("maxDupCnt",0); // change() 사용후 재조회시 편집못하도록 설정
			break;
		
		case "examSearch":      //조회
			var SheetNm = gridObj2; //sheet명 가져온다.
			var param ="questSeq="+ openTab.ContentObj.find("[name=questSeq]").val(); //폼정보 serialize
				param +="&surveyId="+openTab.ContentObj.find("[name=surveyId]").val(); //폼정보 serialize
			SheetNm.DoSearch("<c:url value='/admin/bbs/surveyExamListAll.do'/>", param);
			break;	
			
			
		case "deleteQuest":		//문항(삭제)
		if ( !confirm("삭제 하시겠습니까? ") ) {
				return;
  			}
			var SheetNm = gridObj; //sheet명 가져온다.
			ibsSaveJson = SheetNm.GetSaveJson(0, "delChk");	//선택한 행의 데이터를 객체로 받기
			if(ibsSaveJson.data.length == 0) return;
			var url = "<c:url value='/admin/bbs/surveyQuestDelete.do'/>";
			IBSpostJson(url,ibsSaveJson,ibscallback);
			doActionTab("questSearch");//문항조회
			doActionTab("examSearch");//지문조회
			break;	
		
			
		case "deleteExam":		//지문(삭제)
		if ( !confirm("삭제 하시겠습니까? ") ) {
				return;
  			}
			var SheetNm = gridObj2; //sheet명 가져온다.
			ibsSaveJson = SheetNm.GetSaveJson(0, "delChk");	//선택한 행의 데이터를 객체로 받기
			if(ibsSaveJson.data.length == 0) return;
			var url = "<c:url value='/admin/bbs/surveyExamDelete.do'/>";
			IBSpostJson(url,ibsSaveJson,ibscallback);
			doActionTab("examSearch");//지문조회
			break;	
			
			
 		case "orgPop" :	// 부서검색 팝업
 			var param = "?linkSearch="+openTab.ContentObj.find("[name=orgCdSearch]").val(); //정보 serialize
 			var url="<c:url value="/admin/basicinf/popup/commOrg_pop.do"/>" + param
			var popup = OpenWindow(url,"orgPop","500","550","yes");
 			$("input[name=orgCdSearch]").val(""); //담당조직input 검색어 초기화.
			break; 	
 			
 			
 		case "usrNmPop" :	//직원 팝업
 			var param = "?linkSearch="+openTab.ContentObj.find("[name=usrNm]").val(); //정보 serialize
			var url = "<c:url value="/admin/basicinf/popup/commUsr_pop.do"/>"+param;
			var popup = OpenWindow(url,"usrPop","500","550","yes");	                
			break;
	
			
 		case "moveUp":
 			var SheetNm = gridObj2; //sheet명 가져온다.
 			var row = SheetNm.GetSelectRow();
 			gridMove(SheetNm,row-1,"vOrder","Y"); //그리드객체, 이동번호, 정렬컬럼, 정렬여부
 			break;
 			
	
 		case "moveDown":
 			var SheetNm = gridObj2; //sheet명 가져온다.
 			var row = SheetNm.GetSelectRow();
 			gridMove(SheetNm,row+2,"vOrder","Y"); //그리드객체, 이동번호, 정렬컬럼, 정렬여부
 			break;
 		
 		case "view":
 			var SheetNm = gridObj2; //sheet명 가져온다. 
 		//	var param = openTab.ContentObj.find("[name=adminSurvey]").serialize(); //폼정보 serialize
 			var param = openTab.ContentObj.find("[name=surveyId]").val(); //폼정보 serialize
 			var url="<c:url value="/admin/bbs/popup/surveyPop.do"/>"+"?surveyId="+param+"&ansCd=";
			var popup = OpenWindow(url,"survey","700","750","yes");
 			
 			break;
 			
 			
 	}
 }
 
 

 function setTabButton(){
 	var objTab = getTabShowObj(); //탭이 oepn된 객체가져옴
 	var formObj = objTab.find("form[name=adminSurvey]");
 	
 	formObj.find("#sheetTap a[name=a_reg]").click(function(e) { //신규등록
	 	doActionTab("save");
 		return false;                 
 	});
 	
 	formObj.find("#sheetTap a[name=a_modify]").click(function() {		// 수정
 		doActionTab("update");          
 		return false;                 
 	});
 	
 	formObj.find("#sheetTap a[name=a_del]").click(function() {		// 삭제
 		doActionTab("delete");          
 		return false;                 
 	});
 	
 	formObj.find("#sheetTap a[name=a_view]").click(function() {	// 미리보기 탭
 		doActionTab("view");          
 		return false;                 
 	});
 	
 	
 	
 	formObj.find("#questSheetTap a[name=a_modify]").click(function(e) { //문항 등록/수정
	 	doActionTab("questSave");
 		return false;                 
 	});
 	
 	formObj.find("#questSheetTap a[name=a_del]").click(function() {		// 문항삭제
 		doActionTab("deleteQuest");          
 		return false;                 
 	}); 
 	
 	formObj.find("#questSheetTap a[name=a_add]").click(function(e) { //문항추가
 		doActionTab("addQuest");                 
		return false;                  
	});
 	
 	
 	formObj.find("#examSheetTap a[name=a_modify]").click(function(e) { //지문 등록/ 수정
	 	doActionTab("examSave");
 		return false;                 
 	});
 	
 	formObj.find("#examSheetTap a[name=a_del]").click(function() {		// 지문삭제
 		doActionTab("deleteExam");          
 		return false;                 
 	});
 	
 	formObj.find("#examSheetTap a[name=a_add]").click(function(e) { //지문추가
 		if( $("form[name=adminSurvey] input[name=questSeq]").val() != 0){ //questSeq값이 있어야 추가가능
 			doActionTab("addExam");                 
 		}else{
 			alert("문항을 선택하세요.");
 		}
 		                 
		return false;                 
	});
 	
 	formObj.find("#examSheetTap a[name=a_up]").click(function(e) { //위로이동
 		doActionTab("moveUp");                 
		return false;                 
	});
 	
 	formObj.find("#examSheetTap a[name=a_down]").click(function(e) { //아래로이동
 		doActionTab("moveDown");                 
		return false;                 
	});
 	
 	
 	
 	formObj.find("button[name=btn_orgSearch]").click(function() {	// 조직정보 팝업
 		doActionTab("orgPop");          
 		return false;                 
 	});
 	
 	formObj.find("button[name=btn_usrSearch]").click(function() {	// 담당자정보 팝업
 		doActionTab("usrNmPop");          
 		return false;                 
 	});
 	
 	
 
 	datepickerInitTab2(formObj.find("input[name=startDttm]")); //초기화
  	datepickerInitTab2(formObj.find("input[name=endDttm]")); //초기화
//  	formObj.find("input[name=startDttm]").datepicker(setCalendarView('yy-mm-dd')); //달력생성         
//   	formObj.find("input[name=endDttm]").datepicker(setCalendarView('yy-mm-dd'));
 	formObj.find("input[name=startDttm]").datepicker(setOpenCalendar('yy-mm-dd')); //달력생성 ,현재날짜 기준 이전날짜 선택못하도록 막음.       
  	formObj.find("input[name=endDttm]").datepicker(setOpenCalendar('yy-mm-dd'));
  	datepickerTrigger(); 
 	
 	//응답자 정보 체크 
  	formObj.find("input:checkbox[id='loginYn']").click(function(){ 
 		var chk = formObj.find("input:checkbox[id='loginYn']").is(":checked");
 		if(chk){
 			formObj.find("input:checkbox[id='loginYn']").prop("checked",true);
 		}else{
 			formObj.find("input:checkbox[id='loginYn']").prop("checked",false);
 		}
  	});
  	
  	formObj.find("input:checkbox[id='user1Yn']").click(function(){
 		var chk = formObj.find("input:checkbox[id='user1Yn']").is(":checked");
 		var chk2 = formObj.find("input:checkbox[id='user2Yn']").is(":checked"); //상세수집은 항상 기본수집도 체크해야 하기에 사용
 		if(chk){
 			formObj.find("input:checkbox[id='user1Yn']").prop("checked",true);
 		}else{
 			formObj.find("input:checkbox[id='user1Yn']").prop("checked",false);
 			if(chk2){
 				formObj.find("input:checkbox[id='user2Yn']").prop("checked",false);
 			}
 		}
  	});
  	
  	formObj.find("input:checkbox[id='user2Yn']").click(function(){
 		var chk = formObj.find("input:checkbox[id='user2Yn']").is(":checked");
 		if(chk){
 			formObj.find("input:checkbox[id='user2Yn']").prop("checked",true);
 			formObj.find("input:checkbox[id='user1Yn']").prop("checked",true);
 		}else{
 			formObj.find("input:checkbox[id='user2Yn']").prop("checked",false);
 			formObj.find("input:checkbox[id='user1Yn']").prop("checked",false);
 		}
  	});
 	
 }
 
//탭 사용시 달력초기화(초기화 하지 않으면 탭안에서 동작안됨), 달력2개 사용시..
 function datepickerInitTab2(obj) {
 //	obj.remove();  
 	obj.removeClass("hasDatepicker");  
 	$(".ui-datepicker-trigger").remove();  
 }
 
 
 function validateAdminSurveyExam(formObj){
	 	
		// 설문관리 목적 null체크
		if( !(formObj.find('input[name=surveyPpose]').val().length > 0 )){
			if ( nullCheckValdation( formObj.find('input[name=surveyPpose]'), "<spring:message code='labal.purpose'/>", "" ) ) {
				return true;
			}
		}
		
		// 설문관리 제목 null체크
		if( !(formObj.find('input[name=surveyNm]').val().length > 0 )){
			if ( nullCheckValdation( formObj.find('input[name=surveyNm]'), "<spring:message code='labal.surveyNm'/>", "" ) ) {
				return true;
			}
		}
		
		// 설문관리 설문기간 null체크
		if( !(formObj.find('input[name=startDttm]').val().length > 0 )){
			if ( nullCheckValdation( formObj.find('input[name=startDttm]'), "<spring:message code='labal.surveyDay'/>", "" ) ) {
				return true;
			}
		}
		
		// 설문관리 설문기간 null체크
		if( !(formObj.find('input[name=endDttm]').val().length > 0 )){
			if ( nullCheckValdation( formObj.find('input[name=endDttm]'), "<spring:message code='labal.surveyDay'/>", "" ) ) {
				return true;
			}
		}
		
		// 응답자 정보 최소 한개이상 선택해야한다.
		if( !($("input:checkbox[id='user1Yn']").is(":checked") || $("input:checkbox[id='user2Yn']").is(":checked")  || $("input:checkbox[id='loginYn']").is(":checked") ) ){
			alert("응답자 정보(을)를 최소 1개이상 선택해주세요.");
			return true;
		}
		
		// 설문관리 담당조직 null체크
		if( !(formObj.find('input[name=orgNm]').val().length > 0 )){
			if ( nullCheckValdation( formObj.find('input[name=orgNm]'), "<spring:message code='labal.orgCd'/>", "" ) ) {
				formObj.find('input[name=orgCdSearch]').focus();
				return true;
			}
		}
		
		
		// 설문관리 담당자 null체크
		if ( nullCheckValdation( formObj.find('input[name=usrCd]'), "<spring:message code='labal.usrCd'/>", "" ) ) {
			formObj.find('input[name=usrNm]').focus();
			return true;
		}
		
		oEditors.getById["surveyDesc"].exec("UPDATE_CONTENTS_FIELD", []); //editor 등록시 필요한것.
		return false;                               
	}
 
 

//]]> 
</script>              
</head>
<body onload="">
<div class="wrap">

		<!-- 상단 -->
		<c:import  url="/admin/admintop.do"/>
		<!--  -->
		
		
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
			              
			<!-- 탭 내용 -->
			<div class="content" style="display:none">
				<form name="adminSurvey"  method="post" action="#">
				
				
				<input type="hidden" value="0" name="surveyId" >
				<input type="hidden" value=0 name="questSeq" >
				<input type="hidden" name="sheetNm"/> 
				<input type="hidden" name="sheetNm2"/> 
				
				<table class="list01" id="surveyTB">
					<caption>설문관리</caption>
					<colgroup>
						<col width="200"/>
						<col width=""/>
						<col width="200"/>
						<col width=""/>
					</colgroup>
					<tr>
						<!-- 언어 -->
						<th><spring:message code="labal.langTag"/><span>*</span></th>
						<td colspan="3">
							<input type="radio" value="K" id="han" name="langTag" checked="checked"/>
							<label for="han">한글</label>
							<input type="radio" value="E" id="eng" name="langTag"/>
							<label for="eng">영어</label>
						</td>
					</tr>
					<tr>
						<!-- 목적 -->
						<th><spring:message code="labal.purpose"/><span>*</span></th>
						<td colspan="3">
							<input type="text" name="surveyPpose" maxlength="160" style="width: 600px;"/>
						</td>
					</tr>
					<tr>
						<!-- 제목 -->
						<th><spring:message code="labal.surveyNm"/><span>*</span></th>
						<td colspan="3">
							<input type="text" name="surveyNm" value="" maxlength="160" style="width: 600px;"/>
							<!-- <input type="text" name="orgNmEng" value="" maxlength="100" placeholder="영" style="width: 200px;"/> -->
							<input type="checkbox" name="ipDupYn" value="Y"/>
							<span>중복응답 허용(IP로 체크)</span>
						</td>
					</tr>
					<tr>
						<!-- 설명  -->
						<th><spring:message code="labal.desc"/></th>
						<td colspan="3" style="padding-top:4px;padding-bottom:4px;">
							<textarea rows="3" cols="100" placeholder="2000자 이내" maxlength="2000" name="surveyExp"   style="width: 600px;"></textarea>
							
						</td>
					</tr>
					<tr>
						<!-- 설명요지  -->
						<th><spring:message code="labal.surveyPoint"/></th>
						<td colspan="3" style="padding-top:4px;padding-bottom:4px;">
							<textarea rows="3" cols="100"   name="surveyDesc" id="surveyDesc"  style="width: 600px;"></textarea>
						</td>
					</tr>
					<tr>
						<!-- 설문기간 달력  -->
						<th><spring:message code='labal.surveyDay'/><span>*</span></th>
						<td  colspan="3">
							<input type="text" name="startDttm" value="" readonly="readonly"/> ~ 
							<input type="text" name="endDttm" 	 value="" readonly="readonly"/>
						</td>
					</tr>
					<tr>
						<!-- 응답자 정보  -->
						<th><spring:message code='labal.userInfo'/></th>
						<td  colspan="3">
							<input type="checkbox" name="loginYn" id="loginYn" value="Y"/>
							<span>로그인 후 응답(이름, 회원구분 자동수집)</span><br>
							<input type="checkbox" name="user1Yn" id="user1Yn" value="Y" />
							<span>기본수집(개인정보 수집 동의를 받습니다)</span><br>  
							&nbsp&nbsp&nbsp<span>- 수집정보: 성별, 연령대, 직업</span> <br> 
							<input type="checkbox" name="user2Yn" id="user2Yn" value="Y"/>
							<span>상세수집(암호화 대상 정보)</span> <br>
							&nbsp&nbsp&nbsp<span>- 수집정보: 연락처, 이메일</span><br>
						</td>
					</tr>
					<tr>
						<!-- 담당조직  -->
						<th><spring:message code="labal.orgCdNm"/><span>*</span></th>
						<td>
							<input type="text" name="orgCdSearch" style="width: 150px;" maxlength="160"/>
							<button type="button" class="btn01" name="btn_orgSearch">
								<spring:message code="btn.search"/>
							</button>
							<input type="text" name="orgNm" class="" value="" style="width: 250px;" class="readonly" disabled="true" />						
							<input type="hidden" name="orgCd" class="" value="" />	
						</td>
						
						<!-- 담당자 -->
						<th><spring:message code="labal.usrCd"/><span>*</span></th>
						<td>
							<input type="text" name="usrNm" class="" value="" style="width: 150px;" maxlength="30"/>
							<input type="hidden" name="usrCd" class="" value=""  />
							<button type="button" class="btn01" name="btn_usrSearch">
								<spring:message code="btn.search"/>
							</button>							
						</td>
					</tr>
					
					
					<tr>
						<!-- 사용여부 -->
						<th><spring:message code="labal.useYn"/></th>
						<td colspan="3">
							<input type="radio" name="useYn" value="Y" class="input" checked/>
							<label for="use"><spring:message code="labal.yes"/></label>
							<input type="radio" name="useYn" value="N" class="input"/>
							<label for="unuse"><spring:message code="labal.no"/></label>
						</td>
					</tr>
				</table>	
				
				<div class="buttons" id="sheetTap">
					${sessionScope.button.a_reg}
					${sessionScope.button.a_modify}
					${sessionScope.button.a_del}
					${sessionScope.button.a_view}
				</div>
				
				<!-- 설문문항  -->
			 <div name="examQuestDiv">	
				<div id="examQuestDiv1" style="border-radius:5px;border:2px solid #c0cbd4;margin:15px 0 0 0;overflow:hidden;padding:10px 15px 15px 15px;">
					<p class="text-title">설문문항 : 설문제목</p>
					<div style="width:100%;float:left;">
						<div style="padding:0 15px 0 0;">
							<!-- ibsheet 영역 -->
						 	<div class="ibsheet_area" name="tapSheet1">
								<!-- 이 영역에 sheet생성 한다. -->
							</div>
							<div class="buttons" id="questSheetTap">
								${sessionScope.button.a_add}
								${sessionScope.button.a_modify} 
								${sessionScope.button.a_del}
							</div>
						
						</div>
					</div>
				</div>
				
				
				<!-- 설문지문  -->
				 <div id="examQuestDiv2" style="border-radius:5px;border:2px solid #c0cbd4;margin:15px 0 0 0;overflow:hidden;padding:10px 15px 15px 15px;">
					<p class="text-title">설문지문 : 문항</p>
					<div style="width:100%;float:left;">
						<div style="padding:0 15px 0 0;">
							<!-- ibsheet 영역 -->
							<div class="ibsheet_area" name="tapSheet2">
								<!-- 이 영역에 sheet생성 한다. -->
							</div> 
										
							<div class="buttons" id="examSheetTap">
								${sessionScope.button.a_add}
								${sessionScope.button.a_up}
								${sessionScope.button.a_down}
								${sessionScope.button.a_modify}
								${sessionScope.button.a_del}
							</div>
						
						</div>
					</div>
				</div> 
			</div>	
				
				</form>
			</div>
			<!-- 탭 내용 END -->
			 
			<!-- 목록내용 -->
			<div class="content"  >
				<form name="adminSurvey"  method="post" action="#">
				<table class="list01">              
					<caption>설문관리목록</caption>
					<colgroup>
						<col width="150"/>
						<col width=""/>
					</colgroup>       
					<tr>
						<!-- 검색어 -->
						<th><spring:message code="labal.search"/></th>
						<td>
							<select name="searchWd" style="width: 100px;">
								<option value="">선택</option>
								<option value="1" selected="selected"><spring:message code="labal.surveyNm"/></option>
							</select>
							<input type="text" name="searchWord" value="" placeholder="검색어를 입력하세요" style="width: 300px" maxlength="160"/>
<!-- 							<button type="button" class="btn01" name="btn_searchWd"> -->
<%-- 								<spring:message code="btn.inquiry"/> --%>
<!-- 							</button> -->
							${sessionScope.button.btn_inquiry}
							${sessionScope.button.btn_reg}
						</td>
					</tr>
						<!-- 사용여부 -->
						<th><spring:message code="labal.useYn"/></th>
						<td>
							<input type="radio" name="useYn" />
							<label for="useAll"><spring:message code="labal.whole"/></label>
							<input type="radio" name="useYn"  value="Y" checked="checked"/>
							<label for="use"><spring:message code="labal.yes"/></label>
							<input type="radio" name="useYn" value="N"/>
							<label for="unuse"><spring:message code="labal.no"/></label>
							<input type="hidden" value="0" name="regAffterSearch" >
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
			<!-- 목록내용 END-->                  
			                        
		</div>		
	                              
	</div>      
<!-- 	<iframe name="iframePopUp" scrolling="no" frameborder="0" style="display: none;position: absolute;" src="" />			                                            -->
	<!--##  푸터  ##-->                
	<c:import  url="/WEB-INF/jsp/admin/adminfooter.jsp"/>
	<!--##  /푸터  ##-->  
</body>
</html>