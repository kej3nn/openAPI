<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="egovframework.common.WiseOpenConfig"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><spring:message code='wiseopen.title'/></title>                                           
<c:import  url="/WEB-INF/jsp/inc/headinclude.jsp"/>
</head>    
<script language="javascript">              
//<![CDATA[                   
function tabSet(){ //탭 객체 생성  
	openTab = new OpenTab(tabId,tabContentClass,tabBody); //headinclude.jsp 변수 있음
	openTab.TabObj = openTab;  
	openTab.addTabClickEvent();            
}	   
$(document).ready(function()    {     
	setMainButton(); //메인 버튼
	setTreeButton(); //트리 버튼
 	LoadPage();//메인 sheet        
 	LoadPage2(); //트리 sheet                               
	doAction('search');//메인 바로조회                                              
	inputEnterKey();//엔터키 적용       
	tabSet();// tab 셋팅         
});    

function setMainButton(){
	var formObj = $("form[name=adminOpenInfTcolItemMain]");
	formObj.find("button[name=btn_inquiry]").eq(0).click(function(e) { //조회
		doAction("search");
		 return false;                                 
	 }); 
	formObj.find("a[name=a_add]").click(function(e) { //추가
		doAction("add");                
		 return false;                  
	 });                                              
	formObj.find("a[name=a_save]").click(function(e) { //저장                 
		doAction("save");
		 return false;                  
	 });
	formObj.find("a[name=a_del]").click(function(e) { //삭제
		doAction("delete");
		 return false;                  
	 });             
}

function LoadPage()                
{      
	//message-common_ko_KR.properties 선언 후 사용 or message-common_en_US.properties 선언 후 사용
	var gridTitle = "NO"
		gridTitle +="|"+"<spring:message code='labal.status'/>";  
		gridTitle +="|"+"상위항목코드";           
		gridTitle +="|"+"상위항목명";                     
		gridTitle +="|"+"상위항목명(영문)";        
		gridTitle +="|"+"<spring:message code='labal.dtNm'/>";        
		gridTitle +="|"+"<spring:message code='labal.dtId'/>";        
		gridTitle +="|"+"<spring:message code='labal.useYn'/>";       
		gridTitle +="|"+"<spring:message code='labal.itemCd'/>";           
		gridTitle +="|"+"<spring:message code='labal.vOrder'/>";           
	
    with(mySheet){
    	                     
    	var cfg = {SearchMode:3,Page:50};                                
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
					 {Type:"Seq",		SaveName:"seq",				Width:70,	Align:"Center",		Edit:false}
					,{Type:"Status",	SaveName:"status",			Width:30,	Align:"Center",		Hidden:false, Hidden:true	}
					,{Type:"Text",		SaveName:"itemCd",			Width:120,	Align:"Center",		Edit:true, KeyField:true}
					,{Type:"Text",		SaveName:"itemNm",			Width:200,	Align:"Left",		Edit:true, KeyField:true}
					,{Type:"Text",		SaveName:"itemNmEng",		Width:200,	Align:"Left",		Edit:true} 
					,{Type:"Popup",		SaveName:"dtNm",			Width:200,	Align:"Left",		Edit:true}                                
					,{Type:"Text",		SaveName:"dtId",			Width:150,	Align:"Right",		Edit:false, Hidden:true}
					,{Type:"CheckBox",	SaveName:"useYn",			Width:80,	Align:"Center",		Edit:true, TrueValue:"Y", FalseValue:"N", KeyField:true}
					,{Type:"Text",		SaveName:"itemCdCheck",		Width:100,	Align:"Center",		Edit:true, Hidden:true}
					,{Type:"Text",		SaveName:"vOrder",			Width:100,	Align:"Center",		Edit:true, Hidden:true}  
				];                                                             
                                                                                
        InitColumns(cols);                                                                                                                  
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
			ajaxBeforeSendAdmin("<c:url value='/admin/ajaxBeforeSendAdmin.do'/>"); //IbSheet 조회전 세션 체크
			var param = {PageParam: "ibpage", Param: "onepagerow=50&"+actObj[0]};         
			mySheet.DoSearchPaging("<c:url value='/admin/opendt/openInfTcolItemParListAll.do'/>", param);
			break;                          
		case "add":      //추가
			mySheet.DataInsert(-1);           
			break; 
		case "delete":      //삭제
			if ( !confirm("삭제 하시겠습니까? ") ) {
				return;
  			}
			//삭제 항목코드 체크
			var row = mySheet.GetSelectRow();        
			 if(row < 1){
				alert("삭제할 대상을 선택해주세요.");              
				return;
			 }              
			                       
			 if(mySheet.GetCellValue(row,"status") == "I"){
				 mySheet.RowDelete(row, 0);                
			 }else{
				 mySheet.SetCellValue(row,"itemCd",mySheet.GetCellValue(i,"itemCdCheck"));
				 setItmeCode(row);
				 ibsSaveJson = mySheet.GetRowJson(row);
	 			 var url ="<c:url value='/admin/opendt/openInfTcolItemParDel.do'/>";
				 IBSpostJson(url, param,ibscallback); 
			 }
			                        
			break;
		case "save":      //저장
			//변경시 항목코드 변경 체크
			//저장시 항목코드 중복 체크
			for(var i = 1 ; i < mySheet.RowCount()+1; i++){     
				if(mySheet.GetCellValue(i,"status") == "U" &&
						(mySheet.GetCellValue(i,"itemCd") != mySheet.GetCellValue(i,"itemCdCheck")))
				{
					alert(i+"번 항목코드는 변경할수 없습니다.");
					 setItmeCode(i);                    
					return;                              
				}else if(engNumCheck(mySheet.GetCellValue(i,"itemCd"))){                  
					alert(i+"번 항목코드는 영문과 숫자만 가능합니다.");                          
					return;                                               
				}                                                                     
			}
			var Row = mySheet.ColValueDup("itemCd");
			if(Row > 0){
				alert(Row+"번 항목코드가 중복됩니다.");
				return;       
			}
			ibsSaveJson = mySheet.GetSaveJson(0);                                          
			if(ibsSaveJson.data.length == 0) {
				alert("저장할 데이터가 없습니다.");  
				return;
			}
			var url = "<c:url value='/admin/opendt/openInfTcolItemParSave.do'/>";
			IBSpostJson(url, param, ibscallback);
			break;
		case "popclose":                  
			closeIframePop("iframePopUp");
			break;
		case "popdt":       
			var iframeNm ="iframePopUp";                 
			var wWidth ="660";                                                 
			var url = "<c:url value='/admin/opendt/openDtPopUp.do'/>";
			openIframePop(iframeNm,url,wWidth);//ifrmNm, url,width,height
			break;               
	}           
}       

function setItmeCode(row){
	mySheet.SetCellValue(row,"itemCd",mySheet.GetCellValue(row,"itemCdCheck"));//키값
}
function OnSaveEnd(){
	doAction("search");                 
}
// 마우스 이벤트
function mySheet_OnSearchEnd(code, msg)
{
   if(msg != "")
	{
	    alert(msg);
    }else{
    	doActionTree("search");                      
    }
}

function mySheet_OnPopupClick(Row,Col) {
	doAction("popdt");
}
                   

/* function mySheet_OnClick(row, col, value, cellx, celly) {
	if(mySheet.GetCellValue(row,"status") != "I" && col != 5){ // 신규는 하위없음
		$("#obj_open").attr("checked",true);             
		setParItemNm(row);                
		doActionTree("search");                                                
	}                      
}  */

function mySheet_OnDblClick(row, col, value, cellx, celly) {
	if(mySheet.GetCellValue(row,"status") != "I" && col != 5){ // 신규는 하위없음
		$("#obj_open").prop("checked",true);             
		setParItemNm(row);                
		doActionTree("search");                                                
	}                      
} 


function LoadPage2()                
{      
	//message-common_ko_KR.properties 선언 후 사용 or message-common_en_US.properties 선언 후 사용
	var gridTitle ="NO"; 
		gridTitle +="|"+"<spring:message code='labal.status'/>";  
		gridTitle +="|"+"<spring:message code='labal.itemCd'/>";  
		gridTitle +="|"+"<spring:message code='labal.itemNm'/>";                          
		gridTitle +="|"+"<spring:message code='labal.vOrder'/>";        
		gridTitle +="|"+"<spring:message code='labal.itemCd'/>";        
		gridTitle +="|"+"<spring:message code='labal.itemCd'/>";        
    with(mySheet2){      
    	                     
    	var cfg = {SearchMode:2,Page:50,ChildPage:10};      //tree searchMode 2로 선언해야함                                           
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
                     {Type:"Seq",		SaveName:"seq",				Width:30,	Align:"Right",		Edit:false,Hidden:true}
                    ,{Type:"Status",	SaveName:"status",		Width:30,	Align:"Center",		Hidden:false, Hidden:true	}
					,{Type:"Text",		SaveName:"itemCd",			Width:100,	Align:"Center",		Edit:false}
					,{Type:"Text",		SaveName:"itemNm",			Width:150,	Align:"Left",		Edit:false, TreeCol:1}                
					,{Type:"Text",		SaveName:"vOrder",			Width:200,	Align:"Left",		Edit:false,Hidden:true}               
					,{Type:"Text",		SaveName:"itemCdPar",			Width:200,	Align:"Left",		Edit:false,Hidden:true}
					,{Type:"Text",		SaveName:"itemNav",			Width:200,	Align:"Left",		Edit:false,Hidden:true}                             
					,{Type:"Text",		SaveName:"itemLevel",			Width:200,	Align:"Left",		Edit:false,Hidden:true}       
                ];                                          
                                                                       
        InitColumns(cols);                                                                                                                       
        SetExtendLastCol(1); 
    }               
    default_sheet(mySheet2);         
    mySheet2.SetCountPosition(0);          	
}         

function setTreeButton(){ 
	var formObj = $("form[name=adminOpenInfTcolItemMain]");
	formObj.find("button[name=btn_inquiry]").eq(1).click(function(e) { //조회
		doActionTree("reSearch");
		 return false;                                 
	 }); 
	formObj.find("a[name=a_up]").click(function(e) { //위로이동
		doActionTree("moveUp");                
		 return false;                  
	 });                                              
	formObj.find("a[name=a_down]").click(function(e) { //아래로이동               
		doActionTree("moveDown");
		 return false;                              
	 });
	formObj.find("a[name=a_modify]").click(function(e) { //수정
		doActionTree("modify");
		 return false;                  
	 });             
	formObj.find("button[name=btn_reg]").click(function(e) { //등록
		doActionTree("reg");              
		 return false;                  
	 });
	$("#obj_open").change(function(e) { //수정
		if(inputCheckYn("obj_open") =="Y"){              
			mySheet2.ShowTreeLevel(-1);     
			mySheet2.FitColWidth();                            
		}else{                
			mySheet2.ShowTreeLevel(0, 1);     
			mySheet2.FitColWidth();                            
		}                   
	 });               
}

function doActionTree(sAction)                                  
{
	var classObj = $("."+tabContentClass); //tab으로 인하여 form이 다건임
	var actObj = setTabForm(classObj); // 0: form data, 1: form 객체
	switch(sAction)                  
	{                        
		case "search":      //조회   
			var row = mySheet.GetSelectRow();      
			setParItemNm(row);                                
			if(row > 0){
				var itemCd = mySheet.GetCellValue(row,"itemCdCheck");        
			}else{
				var itemCd ="";              
			}              
			ajaxBeforeSendAdmin("<c:url value='/admin/ajaxBeforeSendAdmin.do'/>"); //IbSheet 조회전 세션 체크
			var param =actObj[0]+"&itemCd="+itemCd;        
			mySheet2.DoSearch("<c:url value='/admin/opendt/openInfTcolItemListTree.do'/>", param);
			break;                    
		case "reg":      //등록화면                 
			var row = mySheet2.GetSelectRow();                            
			$("input[name=ibSheetRow]").val(row);                                         
			var title = "통계항목 등록"
			var id ="itemRegTab";
		    openTab.addRegTab(id,title,tabCallRegBack); // 탭 추가 시작함
		    break;       
		case "modify":      //수정 
			if ( !confirm("수정 하시겠습니까? ") ) {
				return;
  			}
			ibsSaveJson = mySheet2.GetSaveJson(0);                                                    
			if(ibsSaveJson.data.length == 0) {
				alert("저장할 데이터가 없습니다.");  
				return;
			}
			var url = "<c:url value='/admin/opendt/openInfTcolItemOrderBySave.do'/>";
			IBSpostJson(url, param, ibscallback);
			break;
		case "moveUp":  
			gridTreeMoveUp(mySheet2,"itemLevel","vOrder","Y");
			break;                 
		case "moveDown":              
			gridTreeMoveDown(mySheet2,"itemLevel","vOrder","Y");
			break;
		case "reSearch":      //조회   
			var value = $("input[name=serVal2]").val();              
			var Row1 = mySheet2.FindText("itemNm", value, 0, 0, 0);                               
			mySheet2.SetSelectRow(Row1);                        
			break;              
		break;       
	}                         
}           
function regUserFunction(){ //등록 callback에서 사용함
	var row = $("input[name=ibSheetRow]").val();
	var itemCd = mySheet2.GetCellValue(row,"itemCd");
	var itemNav = mySheet2.GetCellValue(row,"itemNav");
	$("input[name=itemNav]").val(itemNav);                       
	$("input[name=itemCdPar]").val(itemCd);  
}

function tabFunction(tab, json){//tab callback에서 사용함     
	var row = $("input[name=ibSheetRow]").val();
	var itemNav = mySheet2.GetCellValue(row,"itemNav");
	$("input[name=itemNav]").val(itemNav);   
	var objTab = getTabShowObj();//탭이 oepn된 객체가져옴
	var formObj = objTab.find("form[name=adminOpenInfTcolItem]");
	formObj.find("button[name=btn_dup]").remove();            
	formObj.find("input[name=itemCd]").attr("readonly","readonly").addClass("readonly");     
	formObj.find("input[name=itemCd]").next().remove();         
	
	formObj.find("select[name=unitSubCd]").val(json.DATA.unitSubCd);                        
	                         
}                      

function setParItemNm(row){
	if(row > 0){
		var itemNm = mySheet.GetCellValue(row,"itemNm");
	}else{
		var itemNm ="";
	}
	$(".text-title2").empty().html("선택항목 : "+itemNm);          
	
}

function inputEnterKey(){
	var formObj = $("form[name=adminOpenInfTcolItemMain]");
	formObj.find("input[name=serVal]").keypress(function(e) {                   
		  if(e.which == 13) {
			  doAction('search');   
			  return false; 
		  }
	}); 
	formObj.find("input[name=serVal2]").keypress(function(e) {                   
		  if(e.which == 13) {
			  doActionTree('reSearch');                     
			  return false; 
		  }
	}); 
}   

function mySheet2_OnSearchEnd(code, msg)
{
   if(msg != "")
	{
	    alert(msg);
    }else{
    	mySheet2.ShowTreeLevel(-1);     
		mySheet2.FitColWidth();                             
    }
}

function mySheet2_OnDblClick(row, col, value, cellx, celly) {
	$("input[name=ibSheetRow]").val(row);        
	if(row < 2) return;                                         
	    tabEvent(row);                                                                       
} 
	                      
function tabEvent(row){//탭 이벤트 실행  
	var title = mySheet2.GetCellValue(row,"itemNm");//탭 제목                                                                                    
	var id = mySheet2.GetCellValue(row,"seq");//탭 id(유일한key))              
    openTab.SetTabData(mySheet2.GetRowJson(row));//db data 조회시 조건 data
    var url = "<c:url value='/admin/opendt/openInfTcolItemList.do'/>"; // Controller 호출 url              
    openTab.addTab(id,title,url,tabCallBack); // 탭 추가 시작함              
}                   
                      

//* 반드시 setTabButton() 메소드 사용해야함*//
// 탭 callback에서 사용하고 있음//
function setTabButton(){ 
	var objTab = getTabShowObj();//탭이 oepn된 객체가져옴
	var formObj = objTab.find("form[name=adminOpenInfTcolItem]");
	formObj.find("a[name=a_reg]").click(function(e) { //등록
		doActionTab("reg");
		 return false;                  
	 });
	formObj.find("a[name=a_modify]").click(function(e) { //수정               
		doActionTab("modify");
		 return false;                  
	 });
	formObj.find("a[name=a_del]").click(function(e) { //삭제
		doActionTab("delete");
		 return false;                  
	 });
	formObj.find("button[name=btn_dup]").click(function(e) { //중복
		doActionTab("dup");                                               
		 return false;                  
	 });
	formObj.find("input[name=itemCd]").keyup(function(e) {       
		ComInputEngNumObj(formObj.find("input[name=itemCd]"));    
		formObj.find("input[name=itemCdDup]").val("N");                
		 return false;                                                                      
	 }); 
	
	formObj.find("input[name=itemNm]").keyup(function(e) {                     
		ComInputKorObj(formObj.find("input[name=itemNm]"));    
		 return false;                                                                          
	 }); 
	
	formObj.find("input[name=itemNmEng]").keyup(function(e) {                     
		ComInputEngEtcObj2(formObj.find("input[name=itemNmEng]"));    
		 return false;                                                                          
	 }); 
	
	formObj.find("input[name=itemExp]").keyup(function(e) {                     
		ComInputKorObj(formObj.find("input[name=itemExp]"));    
		 return false;                                                                          
	 }); 
	
	formObj.find("input[name=itemExpEng]").keyup(function(e) {                                           
		ComInputEngEtcObj2(formObj.find("input[name=itemExpEng]"));    
		 return false;                                                                          
	 }); 
	
	formObj.find("input[name=weight]").keyup(function(e) {                     
		ComInputNumObj(formObj.find("input[name=weight]"));    
		 return false;                                                                          
	 });    
	
	
	
	formObj.find("input[name=unitCdYn]").change(function(e) { //수정
		if(formObj.find("input[name=unitCdYn]").is(":checked") ==true){ 
			//ajax 호출 후 상위 항목 단위가져옴
			var param = formObj.serialize();                 
			var url ="<c:url value='/admin/opendt/selectParUnitCd.do'/>";
			ajaxCallAdmin(url, param,setParUnitSubCd);                              
		}else{
			formObj.find("select[name=unitCd]").removeAttr("disabled").val("");    
			formObj.find("select[name=unitSubCd]").removeAttr("disabled").empty();                       
		}      
	 });
	
	
	formObj.find("select[name=unitCd]").change(function(e) { 
		 var param = formObj.serialize();                 
		 var url ="<c:url value='/admin/opendt/selectUnitCd.do'/>";
		 ajaxCallAdmin(url, param,setUnitSubCd);
	 });
}

function setUnitSubCd(data){
	var objTab = getTabShowObj();//탭이 oepn된 객체가져옴
	var formObj = objTab.find("form[name=adminOpenInfTcolItem]");                
	formObj.find("select[name=unitSubCd]").empty();         
	 if(data.unitSubCd != null){
		 obj = "";                               
		 for(var i = 0 ; i <data.unitSubCd.length; i++){
			 obj+="<option value='"+data.unitSubCd[i].ditcCd+"'>"+data.unitSubCd[i].ditcNm+"</option>"
		 }
		 formObj.find("select[name=unitSubCd]").append(obj);              
	 } 
}

function setParUnitSubCd(data){
	var objTab = getTabShowObj();//탭이 oepn된 객체가져옴
	var formObj = objTab.find("form[name=adminOpenInfTcolItem]");       
	formObj.find("select[name=unitCd]").val(data.DATA.unitCd).change();
	formObj.find("select[name=unitSubCd]").val(data.DATA.unitSubCd).attr("disabled","disabled");  
	formObj.find("select[name=unitCd]").attr("disabled","disabled");                                           
}
                 
function doActionTab(sAction)                                  
{
	var classObj = $("."+tabContentClass); //tab으로 인하여 form이 다건임
	var objTab = getTabShowObj();//탭이 oepn된 객체가져옴            
	var formObj = objTab.find("form[name=adminOpenInfTcolItem]");
	switch(sAction)                                           
	{                        
		case "reg":      //등록
			if(validateAdminOpenInfTcolItem(formObj)){
				return;
			}                      
			var actObj = setTabForm(classObj); // 0: form data, 1: form 객체                     
			var url = "<c:url value='/admin/opendt/openInfTcolItemReg.do'/>"; 
			ajaxCallAdmin(url,actObj[0],saveCallBack);
		    break;       
		case "modify":      //수정       
			if ( !confirm("수정 하시겠습니까? ") ) {
				return;
  			}
			if(validateAdminOpenInfTcolItem(formObj)){            
				return;                     
			}             
			var actObj = setTabForm(classObj); // 0: form data, 1: form 객체
			var url = "<c:url value='/admin/opendt/openInfTcolItemUpd.do'/>"; 
			ajaxCallAdmin(url,actObj[0],saveCallBack);
			break;
		case "delete":      //삭제  
			if ( !confirm("삭제 하시겠습니까? ") ) {
				return;
  			}
			var actObj = setTabForm(classObj); // 0: form data, 1: form 객체      
			var url = "<c:url value='/admin/opendt/openInfTcolItemDel.do'/>"; 
			ajaxCallAdmin(url,actObj[0],saveCallBack);
			break;       
		case "dup":    
			if(nullCheckValdation(formObj.find('input[name=itemCd]'),"<spring:message code='labal.itemCd'/>","")){
				return true;
			}
			var actObj = setTabForm(classObj); // 0: form data, 1: form 객체       
			var url = "<c:url value='/admin/opendt/openInfTcolItemDup.do'/>"; 
			ajaxCallAdmin(url,actObj[0],dupCallBack);
			break;
	}                         
}        

function dupCallBack(res){
	var objTab = getTabShowObj();//탭이 oepn된 객체가져옴
	var formObj = objTab.find("form[name=adminOpenInfTcolItem]");
	if(res.RESULT.CODE == -1){
		alert("중복된 통계항목이 존재합니다.");
		formObj.find("input[name=itemCdDup]").val("N");
	}else{                           
		alert("등록 가능합니다.");
		formObj.find("input[name=itemCdDup]").val("Y");
	}
}  

function buttonEventAdd(){ //버튼 이벤트 사라짐 overring하여 버튼 이벤트 추가사용
	setTabButton();                                  
}                

function validateAdminOpenInfTcolItem(formObj){
	if(nullCheckValdation(formObj.find('input[name=itemCd]'),"<spring:message code='labal.itemCd'/>","")){
		return true;        
	} 
	if(nullCheckValdation(formObj.find('input[name=itemNm]'),"<spring:message code='labal.itemNm'/>","")){
		return true;        
	} 
	if(nullCheckValdation(formObj.find('input[name=itemNmEng]'),"<spring:message code='labal.itemNmEng'/>","")){
		return true;        
	} 
	
	if(formObj.find('input[name=itemCd]').attr("readonly") != "readonly"){
		if(formObj.find('input[name=itemCdDup]').val() == "N"){
			alert("중복체크 버튼을 클릭해주세요.")
			return true;
		}
	}           
	formObj.find("select[name=unitCd]").removeAttr("disabled");                    
	formObj.find("select[name=unitSubCd]").removeAttr("disabled");                                 
	return false;                               
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
			<div class="more_list" style="display:none">
				<a href="#" class="more">0</a>                                        
				<ul class="other_list" style="display:none;">
					<li><a href="#">보유데이터목록</a><a href="#" class="line_close">x</a></li>
					<li><a href="#">공공데이터목록asdfsdfsfsdfsdfsdf</a><a href="#" class="line_close">x</a></li>
				</ul>
			</div>
			
			<div class="content" style="display:none">
				<form name="adminOpenInfTcolItem"  method="post" action="#">
				<input type="hidden" name="itemCdPar" value=""/>
				<input type="hidden" name="itemCdDup" value="N"/>
				<table class="list01">
					<caption>보유데이터목록리스트</caption>
					<colgroup>
						<col width="150"/>
						<col width=""/>
					</colgroup>
					
					<tr>
						<th><spring:message code='labal.itemParNav'/></th>
						<td>
							<input type="text" value="" name="itemNav" readonly="readonly" style="width: 700px;" class="readonly" />                             
						</td>
					</tr>         
					<tr>
						<th><spring:message code='labal.itemCd'/> <span>*</span></th>
						<td>   
							<input type="text" name="itemCd" value="" maxlength="10"  style="width: 100px;"/>
							${sessionScope.button.btn_dup}     
							<span>공백없이 영문자와 숫자로만 입력하세요. (10자이내)</span>
						</td>
					</tr>        
					<tr>
						<th><spring:message code='labal.itemNm'/> <span>*</span></th>
						<td>
							(한) <input type="text" value=""  name="itemNm" maxlength="160"  style="width: 344px;"/>
							(영) <input type="text" value=""  name="itemNmEng" maxlength="160" style="width: 344px;"/>
						</td>
					</tr>
					<tr>                 
						<th>초기선택여부</th>
						<td>
							<select name="defaultCheckYn">
								<option value="Y" selected="selected">Y</option>
								<option value="N">N</option>
							</select>
						</td>                  
					</tr>
				
					<tr>
						<th><spring:message code='labal.unitCd'/></th>
						<td>
							<input type="checkbox"  name="unitCdYn" value="Y"/> <span> 상위항목과 동일.</span>   
							<select name="unitCd">
								<option value=""></option>         
								<c:forEach var="code" items="${codeMap.unitCd}" varStatus="status">
									<option value="${code.ditcCd}">${code.ditcNm}</option>                 
								</c:forEach>  
							</select>
							<select name="unitSubCd">
								<option value=""></option>         
							</select>
						</td>                 
					</tr>                  
					<tr>                  
						<th><spring:message code='labal.itemExp'/></th>
						<td>
							(한) <input type="text" value=""  name="itemExp" maxlength="160" style="width: 344px;"/>
							(영) <input type="text" value=""  name="itemExpEng" maxlength="160" style="width: 344px;"/>
						</td>
					</tr>
					<tr>         
						<th><spring:message code='labal.useYn'/> </th>
						<td>
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
			
			<!-- 탭 내용 -->
			<div class="content">
				<form name="adminOpenInfTcolItemMain"  method="post" action="#">
				<input type="hidden" name="ibSheetRow" value=""/>             
				<table class="list01">
					<caption>보유데이터목록리스트</caption>
					<colgroup>
						<col width="150"/>
						<col width=""/>
					</colgroup>
					<tr>
						<th><spring:message code='labal.search'/></th>             
							<td>
								<select name="serSel">	
									<option value="ALL"><spring:message code='etc.select'/></option>
									<option value="DT" ><spring:message code='labal.dtNm'/></option>
									<option value="NM" selected="selected">상위항목명</option>
									<option value="ENG" >상위항목명(영문)</option>
									<input type="text" name="serVal" value="" style="width: 300px"/>
								</select> 
								${sessionScope.button.btn_inquiry}               
							</td>
					</tr>
					<tr>
						<th><spring:message code='labal.srvYn'/></th>
						<td>
							<input type="radio" name="useYn" id="useall"  value=""/>            
							<label for="useall"><spring:message code="labal.whole"/></label>
							<input type="radio" name="useYn" id="use" value="Y" checked="checked"/>
							<label for="use"><spring:message code='labal.yes'/></label>
							<input type="radio" name="useYn" id="unuse" value="N"/>
							<label for="unuse"><spring:message code='labal.no'/></label>
						</td>
					</tr>
				</table>		
				
				
				<div style="width:65%;float:left;">
					<div style="border:1px solid #c0cbd4;padding:10px;margin:0 15px 0 0;">
						<script type="text/javascript">createIBSheet("mySheet", "100%", "300px"); </script>             
					</div>
					<div class="buttons" style="margin-right:15px;">
						${sessionScope.button.a_add}     
						${sessionScope.button.a_save}     
						${sessionScope.button.a_del}     
					</div>
				</div>
								
				<div style="width:35%;float:right;">

					<div style="border:1px solid #c0cbd4;padding:10px;">
						<div class="ibsheet-header" style="margin:0 0 -4px 0;">				
							<h3 class="text-title2">선택항목 : </h3>
							<p>
								<input type="checkbox" id="obj_open"  name="obj_open"/>
								<label for="obj_open">항목 펼치기</label> 
							</p>                
						</div>
						<input type="text" value="" name="serVal2" placeholder="검색어를 입력하세요" style="width: 150px"/> 
						${sessionScope.button.btn_inquiry}
						${sessionScope.button.btn_reg}                  
						<div style="padding:10px 0 0 0;">
							<script type="text/javascript">createIBSheet("mySheet2", "100%", "240px"); </script>             
						</div>                                                          
					</div>        
					<div class="buttons">                         
						${sessionScope.button.a_up}     
						${sessionScope.button.a_down}     
						${sessionScope.button.a_modify}     
					</div>     
				</div>	
				</form>               	
			</div>
		</div>		
	</div>               
	<c:import  url="/WEB-INF/jsp/inc/iframepopup.jsp"/>
	<!--##  푸터  ##-->                                                                     
	<c:import  url="/WEB-INF/jsp/admin/adminfooter.jsp"/>                                   
	<!--##  /푸터  ##-->            
</body>
</html>