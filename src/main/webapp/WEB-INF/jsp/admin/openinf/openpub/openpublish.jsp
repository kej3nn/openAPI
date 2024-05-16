<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="egovframework.common.WiseOpenConfig"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%-- <%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %> --%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><spring:message code='wiseopen.title'/></title>
<c:import  url="/WEB-INF/jsp/inc/headinclude.jsp"/>
<style type="text/css">
#pubMonthTr>td{border-bottom:none;}
#pubWeekTr>td{border-top:none;
				border-bottom:none;}
#pubWeeksTr>td{border-top:none;}
#pubDayTr1>td{border-top:none;}
#pubDayTr2>td{border-top:none;}
#pubDayTr3>td{border-top:none;}
</style>
</head>               
<script language="javascript">     
var sheetTabCnt = 0;
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
	setMainButton();
	setTabButton();		//탭 버튼 
});    
function setMainButton(){
	var formObj = $("form[name=adminOpenPublish]");
		// 오늘날짜 fix
	var newDate = new Date();
	var yy = newDate.getFullYear();
	var mm = (newDate.getMonth()+1)>9 ? (newDate.getMonth()+1): '0'+(newDate.getMonth()+1);
	var dd = newDate.getDate();
	var today = yy + "-" +mm +"-" + dd;  
	formObj.find("input[name=pubDttmFrom]").val(today);
	formObj.find("input[name=pubDttmFrom]").datepicker(setOpenCalendar());
	formObj.find("input[name=pubDttmTo]").datepicker(setOpenCalendar());
	datepickerTrigger();
		
	formObj.find("button[name=btn_init]").click(function(e) { //조회
		formObj.find("input[name=pubDttmFrom]").val(today);
		formObj.find("input[name=pubDttmTo]").val(null);
		 return false;
	 });
		
	formObj.find("button[name=btn_inquiry]").click(function(e) { //조회
		doAction("search");
		 return false;
	 });
 	formObj.find("button[name=btn_search]").click(function(){		// 담당 조직 검색 팝업
 		doTabAction("popOrgNm");
 		return false;         	            
 	});
}

function LoadPage()                
{      
	//message-common_ko_KR.properties 선언 후 사용 or message-common_en_US.properties 선언 후 사용
	var gridTitle = "NO"
		gridTitle +="|"+"<spring:message code='labal.pubTitle'/>";  
		gridTitle +="|"+"<spring:message code='labal.pubTitle'/>";  
		gridTitle +="|"+"<spring:message code='labal.downYn'/>";  
		gridTitle +="|"+"<spring:message code='labal.langTag'/>";        
		gridTitle +="|"+"<spring:message code='labal.pubDttm'/>";        
		gridTitle +="|"+"<spring:message code='labal.dsNm'/>";        
		gridTitle +="|"+"<spring:message code='labal.orgNm'/>";        
		gridTitle +="|"+"<spring:message code='labal.usrNm'/>";
		gridTitle +="|"+"<spring:message code='labal.autoYn'/>";
		gridTitle +="|"+"담당자확인여부";
	
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
                    {Type:"Text",		SaveName:"seq",				Width:50,	Align:"Center",		Edit:false}
					,{Type:"Text",		SaveName:"pubId",			Width:0,	Align:"Center",		Edit:false, Hidden:true}
					,{Type:"Text",		SaveName:"pubNm",			Width:300,	Align:"Left",		Edit:false}
					,{Type:"CheckBox",		SaveName:"fileYn",			Width:50,	Align:"Center",		Edit:false, TrueValue:"Y", FalseValue:"N"}
					,{Type:"Text",		SaveName:"langTag",			Width:150,	Align:"Left",		Edit:false}
					,{Type:"Text",		SaveName:"pubDttm",			Width:130,	Align:"Center",		Edit:false}
					,{Type:"Text",		SaveName:"dsNm",			Width:240,	Align:"Left",		Edit:false}
					,{Type:"Text",		SaveName:"orgNm",			Width:170,	Align:"Left",		Edit:false}
					,{Type:"Text",		SaveName:"usrNm",			Width:170,	Align:"Left",		Edit:false}
					,{Type:"CheckBox",		SaveName:"autoYn",		Width:50,	Align:"Center",		Edit:false, TrueValue:"Y", FalseValue:"N", KeyField:false}
					,{Type:"CheckBox",		SaveName:"pubokYn",		Width:50,	Align:"Center",		Edit:false, TrueValue:"Y", FalseValue:"N", KeyField:false}
                ];       
                                      
        InitColumns(cols);                                                                           
         FitColWidth();                                                                        
        SetExtendLastCol(1);   
    }               
    default_sheet(mySheet);                      
}      
/**
 * 상세 조회시 IBS       
 */
function LoadPage2(sheetName,newYn){
	var	gridTitle ="<spring:message code='labal.status'/>";	
		gridTitle +="|"+"NO"; 
		gridTitle +="|"+"<spring:message code='labal.viewFileNm'/>";
		gridTitle +="|"+"<spring:message code='labal.viewFileNm'/>";  
		gridTitle +="|"+"<spring:message code='labal.viewFileNm'/>";        
		gridTitle +="|"+"<spring:message code='labal.viewFileNm'/>";        
		gridTitle +="|"+"<spring:message code='labal.viewFileNm'/>";        
		gridTitle +="|"+"<spring:message code='labal.fileExt'/>";
		gridTitle +="|"+"<spring:message code='labal.fileSize'/>";
		gridTitle +="|"+"<spring:message code='labal.regDttm'/>";
		gridTitle +="|"+"<spring:message code='labal.regDttm'/>";
	
	with(sheetName){
      
  	var cfg = {SearchMode:3,Page:50};                                
      SetConfig(cfg);        
      var headers = [                               
                  {Text:gridTitle, Align:"Center"}                 
              ];
      var headerInfo = {Sort:0,ColMove:1,ColResize:1,HeaderCheck:0};
      
      InitHeaders(headers, headerInfo); 
      SetEditable(1);
       
      //문자는 왼쪽정렬
      //숫자는 오른쪽정렬
      //코드값은 가운데정렬
      var cols = [
					{Type:"Status",	SaveName:"status",				Width:50,	Align:"Center",		Edit:false}
					,{Type:"Seq",		SaveName:"seq",				Width:30,	Align:"Center",		Edit:false}
					,{Type:"Text",		SaveName:"mstSeq",			Width:30,	Align:"Center",		Edit:false, Hidden:true}
					,{Type:"Text",		SaveName:"fileSeq",			Width:100,	Align:"Center",		Edit:false, Hidden:true}
					,{Type:"Text",		SaveName:"viewFileNm",		Width:500,	Align:"Left",		Edit:true}
					,{Type:"Text",		SaveName:"srcFileNm",		Width:500,	Align:"Left",		Edit:false, Hidden:true}
					,{Type:"Text",		SaveName:"saveFileNm",		Width:500,	Align:"Left",		Edit:false, Hidden:true}
					,{Type:"Text",		SaveName:"fileExt",			Width:100,	Align:"Left",		Edit:false}
					,{Type:"Text",		SaveName:"fileSize",		Width:100,	Align:"Right",		Edit:false,Format:"0,000 KB"}
					,{Type:"Text",		SaveName:"regDttm",			Width:100,	Align:"Center",		Edit:false, Hidden:true}
					,{Type:"Text",		SaveName:"updDttm",			Width:100,	Align:"Center",		Edit:false, Hidden:true}
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
    
}
/*Sheet 각종 처리*/                  
function doAction(sAction)                                  
{
	var classObj = $("."+tabContentClass); //tab으로 인하여 form이 다건임
	var actObj = setTabForm(classObj); // 0: form data, 1: form 객체
	switch(sAction)
	{          
		case "search":      //조회
			var formObj = $("form[name=adminOpenPublish]");
			fromObj = formObj.find("input[name=pubDttmFrom]");                          
			toObj = formObj.find("input[name=pubDttmTo]");
			dateValCheck(fromObj,toObj)// from , to 날짜 안맞을 경우 자동셋팅   
			ajaxBeforeSendAdmin("<c:url value='/admin/ajaxBeforeSendAdmin.do'/>"); //IbSheet 조회전 세션 체크
			var param = {PageParam: "ibpage", Param: "onepagerow=50&"+formObj.serialize()};
			mySheet.DoSearchPaging("<c:url value='/admin/openinf/openpub/openPublishListAll.do'/>", param);   
			break;
		case "popOrgNm":
			var url="<c:url value="/admin/basicinf/popup/commOrg_pop.do"/>" + "?orgNmGb=2";
			var popup = OpenWindow(url,"orgPop","500","550","yes");
			popup.focus();
			break;
	}           
}   

function doTabAction(sAction){
	var classObj = $("."+tabContentClass); //tab으로 인하여 form이 다건임
	var actObj = setTabForm(classObj); // 0: form data, 1: form 객체
	var objTab = getTabShowObj();//탭이 oepn된 객체가져옴
	var formObj = objTab.find("form[name=adminOpenPublishOne]");
	ajaxBeforeSendAdmin("<c:url value='/admin/ajaxBeforeSendAdmin.do'/>"); //IbSheet 조회전 세션 체크
	var sheetObj; //IbSheet 객체
	sheetObj =formObj.find("input[name=fileSheetNm]").val();   
	var gridObj = window[sheetObj];
	switch(sAction){
		case "pubok":      // 담당자확인
			if ( !confirm("담당자확인을 하시겠습니까? ") ) {
				return;
  			}
			var url = "<c:url value='/admin/openinf/openpub/openPublishPubOk.do'/>";
			var param = openTab.ContentObj.find("[name=adminOpenPublishOne]").serialize();
			ajaxCallAdmin(url, param);
			//ajaxCallAdmin(url, param, saveCallBack);
			if( gridObj.IsDataModified() ) {
				doActionFile('save');
			}else{
			}
			break;
		case "update":      // 담당자확인
			if ( !confirm("수정 하시겠습니까? ") ) {
				return;
  			}
			var url = "<c:url value='/admin/openinf/openpub/openPublishUpd.do'/>";
			var param = openTab.ContentObj.find("[name=adminOpenPublishOne]").serialize();
			ajaxCallAdmin(url, param);
			//ajaxCallAdmin(url, param, saveCallBack);
			if( gridObj.IsDataModified() ) {
				doActionFile('save');
			}else{
			}
			break;
		case "popclose":              
			closeIframePop("iframePopUp");
			break;
		case "popOrgNm":
			var url="<c:url value="/admin/basicinf/popup/commOrg_pop.do"/>" + "?orgNmGb=2";
			var popup = OpenWindow(url,"orgPop","500","550","yes");
			popup.focus();
			break;
		case "popUsrNm":
			var url="<c:url value="/admin/basicinf/popup/commUsr_pop.do"/>" + "?usrGb=1";
			var popup = OpenWindow(url,"orgPop","500","550","yes");
			popup.focus();
			break;
	}
}
function tabFunction(){//tab callback에서 사용함
	var row = $("input[name=ibSheetRow]").val();
	var pubId = mySheet.GetCellValue(row,"pubId");
	var objTab = getTabShowObj();//탭이 oepn된 객체가져옴
	var formObj = objTab.find("form[name=adminOpenPublishOne]");
	
}      

function mySheet_OnDblClick(row, col, value, cellx, celly) {
    if(row == 0) return;     
    tabEvent(row);                      
}  

function tabEvent(row){	//탭 이벤트 실행                
	var title = mySheet.GetCellValue(row,"pubNm");//탭 제목      
	var id = mySheet.GetCellValue(row,"pubId");//탭 id(유일해야함))
	var objTab = getTabShowObj();		//탭이 oepn된 객체가져옴
    openTab.SetTabData(mySheet.GetRowJson(row));//db data 조회시 조건 data
    var url = "<c:url value='/admin/openinf/openpub/openPublishOne.do'/>"; // Controller 호출 url
    openTab.addTab(id,title,url,tabCallBack); // 탭 추가 시작함
    var cnt = sheetTabCnt++;
    var sheetYn = openTab.tabExits(id);       
    if(sheetYn){//탭이 있을 경우 IBSheet 로드 방지
    	var SheetCnt = sheetTabCnt++;
	   			SheetCreate(SheetCnt, "150", false);
    }else{
    	buttonEventAdd();                      
    }
}
function buttonEventAdd(){
	setTabButton();
	//setFileButton();
}


//탭 Sheet 생성        
function SheetCreate(SheetCnt, sheetHeight, newYn){       
 	var SheetNm = "FileSheet"+SheetCnt;          
 	$("div[name=FileSheet]").eq(1).attr("id","DIV_"+SheetNm);                                          
 	createIBSheet2(document.getElementById("DIV_"+SheetNm),SheetNm, "100%", sheetHeight+"px");                    
 	var sheetObj = window[SheetNm];
 	var objTab = getTabShowObj();//탭이 oepn된 객체가져옴
	initFileSheet(sheetObj, SheetNm, newYn);   
}

function initFileSheet(sheetobj, SheetNm, newYn){
	//setFileButton();
	var objTab = getTabShowObj();
	var formObj = objTab.find("form[name=adminOpenPublishOne]");
	if(formObj.find("input[name=fileSheetNm]").val() == ""){
		formObj.find("input[name=fileSheetNm]").val(SheetNm);
	}
	formObj.find("input[name=initFlag]").val("N"); 	//파일 초기화 최초 세팅
	LoadPage2(sheetobj, newYn);
}

//초기화 버튼 클릭시
function fncInit(formObj, gridObj) {
// 	alert(typeof(gridObj));
	var currRow = gridObj.GetSelectRow();
	var rowCnt = gridObj.RowCount() + 1;
	var appendFile = "";
 	if ( formObj.find("input[name=initFlag]").val() == "Y" ) {
		alert("이미 초기화 하였습니다.");		return;
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
// 	formObj.find("span[id=fileDiv]").html(appendFile);
	//formObj.find("button[name=btn_init]").remove();	// 초기화 버튼 삭제
// 	formObj.find("div[id=fileDivIn]").append(appendFile);
	formObj.find("span[id=fileDiv]").append(appendFile);
	//파일객체 추가하고 보여준다
	formObj.find("input[id=saveFileNm_"+rowCnt+"]").show();
	formObj.find("input[id=file_"+rowCnt+"]").show();
}



function onClick(row, Col, Value, CellX, CellY, CellW, CellH) {
	var objTab = getTabShowObj();//탭이 oepn된 객체가져옴
	var formObj = objTab.find("form[name=adminOpenPublishOne]");
	var sshetNm =formObj.find("input[name=sheetNm]").val();
	var gridObj = window[sshetNm];
	formObj.find("input[name=viewFileNm]").val(gridObj.GetCellValue(row,"viewFileNm"));
	formObj.find("input[name=regFileDttm]").val(gridObj.GetCellValue(row,"regDttm"));
	formObj.find("input[name=updFileDttm]").val(gridObj.GetCellValue(row,"updDttm"));
}


//탭 액션
function doActionFile(sAction)
{
	var classObj = $("."+tabContentClass); //tab으로 인하여 form이 다건임
	var actObj = setTabForm(classObj); // 0: form data, 1: form 객체
	var sheetObj; //IbSheet 객체
	var param = actObj[0]  ;
	var objTab = getTabShowObj();//탭이 oepn된 객체가져옴
	var formObj = objTab.find("form[name=adminOpenPublishOne]");
	sheetObj =formObj.find("input[name=fileSheetNm]").val();   
	ajaxBeforeSendAdmin("<c:url value='/admin/ajaxBeforeSendAdmin.do'/>"); //IbSheet 조회전 세션 체크
	var gridObj = window[sheetObj];
	switch(sAction)                           
	{
		case "search" :	// 선택된 메티정보의 파일 List 출력
			gridObj.DoSearch("<c:url value='/admin/openinf/openpub/openPublishFileList.do'/>", param); 
			break;
		case "search2":
			ajaxCallAdmin("<c:url value='/admin/openinf/openpub/openPublishFileList2.do'/>", param, publishFileListCallBack);
			break;
		case "save":      //저장               
 			ibsSaveJson = gridObj.GetSaveString();
 			if( !gridObj.IsDataModified() ) {
				alert("저장할 내역이 없습니다.");
				return;
			}
 			var url = "<c:url value='/admin/service/openInfPublishFileSave.do'/>";
			IBSpostJsonFile(formObj,url, fileSaveCallBack);
 			break;
		case "init" : //초기화
 			fncInit(formObj, gridObj);
 			break;
 		case "add":
			var seq = formObj.find("input[name=seq]").val();
			if(seq == ""){
				alert("상세정보를 먼저 등록해주세요");	return false; 
			}	
			var rowCnt = gridObj.RowCount() + 1;
	
			if (formObj.find("input[name=initFlag]").val() == "N" ) {
				alert("입력 초기화 후 추가해 주세요.");		return false;
			}
			if (formObj.find('input[id=file_'+rowCnt+']').val() == "" ) {
				alert("파일을 선택해 주세요."); 	return false;
			}
			if(nullCheckValdation(formObj.find('input[name=viewFileNm]'),"출력파일명","")){
				return false;
			}
			formObj.find("input[name=mstSeq]").val(seq);
			var row = gridObj.DataInsert(-1);
			gridObj.SetCellValue(row, "mstSeq", seq);
			gridObj.SetCellValue(row, "viewFileNm", formObj.find('input[name=viewFileNm]').val());
			gridObj.SetCellValue(row, "srcFileNm", formObj.find("input[id=saveFileNm_"+row+"]").val()); 
			gridObj.SetCellValue(row, "fileExt", getFileExt(formObj.find("input[id=saveFileNm_"+row+"]").val()));
			doActionFile("reset");
			formObj.find("a[name=a_init]").show();
 			formObj.find("a[name=a_add]").show();
			break;
		case "reset":
			formObj.find("input[name=initFlag]").val("N");
			break;
 			
	}
}

//파일수정 콜백함수
function fileSaveCallBack(res) {
	var result = res.RESULT.CODE;
    if(result == 0) {
    	alert(res.RESULT.MESSAGE);
    } else {
    	alert(res.RESULT.MESSAGE);
    }   
    doActionFile("search");		//조회
    doActionFile("search2");	//파일타입 넣기위해 조회.
    doActionFile("reset");		//초기화
}


//파일객체 동적 생성
function publishFileListCallBack(tab, json, res) {
	var objTab = getTabShowObj();
	var formObj = objTab.find("form[name=adminOpenPublishOne]");
	if(json.DATA != null){               
		$.each(json.DATA,function(key,state){ 
			alert(key);
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
			//appendFile += "<input type='text' name='arrFileSeq' id='arrFileSeq_"+(i+1)+"' value='"+ tab[i].arrFileSeq +"' style='display:none; '/>";
		}
	}
	appendFile += "</div id='fileDivIn'>";
	formObj.find("span[id=fileDiv]").append(appendFile);
}
function setTabButton(){		//버튼event
	var objTab = getTabShowObj();//탭이 oepn된 객체가져옴
 	var formObj = objTab.find("form[name=adminOpenPublishOne]");
 	// 오늘날짜 fix
	var newDate = new Date();
 	var yy = newDate.getFullYear();
 	var mm = (newDate.getMonth()+1)>9 ? (newDate.getMonth()+1): '0'+(newDate.getMonth()+1);
 	var dd = (newDate.getDate()+1)>9 ? (newDate.getDate()+1): '0'+(newDate.getDate())
 	var today = yy + "-" +mm +"-" + dd;
	formObj.find("input[name=pubDttm]").datepicker(setOpenCalendar());
	datepickerTrigger();
    
	formObj.find("a[name=a_pubok]").click(function() {		// 담당자확인
 		doTabAction("pubok");          
 		return false;                    
 	});
	
 	formObj.find("a[name=a_modify]").click(function() {		// 수정
 		if(formObj.find("input[name=pubDttm]").val() < today){	// 공표일시가 오늘 날짜보다 작은경우 ==> 공표일시가 지났다는 뜻
 			if(formObj.find("input[name=pubokYn]").val()=="N"){	// 공표일시가 지났어도 자동공표가 아니면 담당자 확인이 되기 전에는 수정이 가능함
 				doTabAction("update");     
 				return false;
 			}
 			alert("공표일시가 지난 자료는 수정이 불가합니다");
 		}else{
 			doTabAction("update");          					// 공표일시가 지나지 않았기 떄문에 수정이 가능함
 		}
 		
 		return false;                 
 	});
 	
 	formObj.find("button[name=btn_search]").eq(0).click(function(){		// 관련 데이터셋 검색 팝업
 		doTabAction("popOrgNm");          
 		return false;         	            
 	});
 	formObj.find("button[name=btn_search]").eq(1).click(function(){		// 담당 조직 검색 팝업
 		doTabAction("popUsrNm");          
 		return false;         	            
 	});
 	
 	formObj.find("a[name=a_init]").click(function(){		//신규등록시 초기화
		doActionFile("init") ;  
		return false;		
	});
 	             
 	formObj.find("a[name=a_add]").click(function(){
		doActionFile("add");
		return false;
	});
 	HideButton(formObj);	// 해당 값에 따라 담당자확인과 수정 버튼 hide setting 
 	     
}      
//파일선택시
function fncFileChange(fileId) {
	var objTab = getTabShowObj();
	var formObj = objTab.find("form[name=adminOpenPublishOne]");
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

function HideButton(formObj){
	//자동공표일땐 담당자확인 버튼을 숨김
	if(formObj.find("input[name=autoYn]").val() == "Y"){ 
		formObj.find("input[name=autoYnCheck]").prop("checked",true);
		formObj.find("a[name=a_pubok]").css("display","none");	
	}
	//공표일시가 지났을땐 수정 버튼을 숨김
	if(formObj.find("input[name=pubDttmCheck]").val() == "Y"){
		formObj.find("a[name=a_modify]").css("display","none");
	}
}

  
//입력/수정 validation
function RowCheck(gridObj) {
	var rowCnt = gridObj.RowCount();
	
	if(gridObj.GetCellValue(rowCnt,"viewFileNm")==""){
		alert("파일을 선택해 주세요.");   
		return false;
	}else{
		return true;
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

function FileSheet_OnClick(Row, Col, Value, CellX, CellY, CellW, CellH) {
	
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
				<form name="adminOpenPublishOne"  method="post" action="#">
				<input type="hidden" name="fileSheetNm"/>
				<input type="hidden" name="seq" value=""/>
				<input type="hidden" name="mstSeq" value=""/>
				<input type="hidden" name="fileSeq" value=""/>
				<input type="hidden" name="fileSize" value=""/>
				<input type="hidden" name="pubYmd" value=""/>      
				<input type="hidden" name="pubId" value=""/>
				<input type="hidden" name="refDsId" value=""/>
				<input type="hidden" name="autoYn" value=""/>
				<input type="hidden" name="pubDttmCheck" value=""/>
				<input type="hidden" name="initFlag">
				<input type="hidden" name="dataModified">
				<input type="hidden" name="pubOkYn">
				<table class="list01">
					<caption>공표자료관리</caption>
					<colgroup>
						<col width="150"/>
						<col width=""/>
						<col width="150"/>
						<col width=""/>
					</colgroup>
					<tr>         
						<th><spring:message code='labal.autoYn'/></th>
						<td colspan="3">
							<input type="text" value="" name="langTag" size="10" readonly class="readonly" readonly style="width: 344px;"/>                                
							<input type="checkbox" id="autoYnCheck"  name="autoYnCheck" value="" disabled="true"/>
							<label for="autoYnCheck"><spring:message code="labal.autoYn"/></label>
						</td>                             
					</tr>
					<tr>
						<th><spring:message code='labal.pubTitle'/><span>*</span></th>
						<td colspan="3">
							<input type="text" value="" name="pubNm" maxlength="160"  style="width: 344px;"/>
						</td>
					</tr>  
					<tr>
						<th><spring:message code='labal.pubContent'/><span>*</span></th>
						<td colspan="3">
							<!-- <input type="text" name="pubExp" /> -->
							<textarea rows="5" style="width:500px;" name="pubExp"></textarea>
						</td>
					</tr>
					<tr>
						<th>관련 데이터셋</th>
						<td>
							<input type="text" name="refDsNm" value="" class="readonly" size="100" readonly/>
						</td>
						<th>관련 컬럼</th>
						<td>
							<input type="hidden" name="refColId" value="" class="readonly" readonly/>
							<input type="text" name="refColNm" value="" class="readonly" size="100" readonly/>
						</td>
					</tr>
					<tr>     
					    <th><spring:message code="labal.pubDttm"/><span>*</span></th>
						<td>
							<input type="text" name="pubDttm" value="" class=""/>
						</td>
						<th><spring:message code='labal.pubStdTime'/><span>*</span></th>
						<td>
							<select id="pubHhmm" name="pubHhmm">
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
						<th><spring:message code='labal.useYn'/><span>*</span></th>
						<td colspan="3">
							<input type="radio" name="useYn" id="use" checked="checked" value="Y"/>
							<label for="use"><spring:message code='labal.yes'/></label>
							<input type="radio" name="useYn" id="unuse" value="N"/>
							<label for="unuse"><spring:message code='labal.no'/></label>                                  
						</td>                             
					</tr>
					<tr>
						<th><spring:message code="labal.orgCdNm"/><span>*</span></th>
						<td colspan="3">
							<input type="hidden" name="orgCd"/>
							<input type="text" name="orgNm" maxlength="160" readonly/>
							${sessionScope.button.btn_search}
							<input type="text" name="orgFullNm" size="35" maxlength="660" readonly/>
						</td>
						</tr>
						<tr>
						<th><spring:message code="labal.usrNm"/><span>*</span></th>
						<td>
							<input type="hidden" name="usrCd" />
							<input type="text" name="usrNm" value="" maxlength="30" readonly/>
							${sessionScope.button.btn_search}
						</td>
						<th><spring:message code="labal.usrTel"/><span>*</span></th>
						<td>
							<input type="text" name="usrTel" value="" maxlength="13" readonly/>
						</td>
					</tr>
					<tr name="pubOkTd">
						<th>참고사항</th>
						<td colspan="3">
							<span>담당자확인은 제목,공표내용,공표일,공표시각을 변경할수 있지만 담당조직,담당자,연락처등은 수정이 불가하고. 파일첨부가 가능합니다. </span>
						</td>
					</tr>
					<tr name="modifyTd">
						<th>참고사항</th>
						<td colspan="3">
							<span>수정은 제목,공표내용,공표일,공표시각,담당조직,담당자,연락처등을 수정할수 있고 파일첨부가 가능합니다.</span>
						</td>
					</tr>
				</table>

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
									<%-- ${sessionScope.button.btn_init} --%>
									</span>
								</td>
							</tr>				
							<tr>
								<th><label class=""><spring:message code="labal.viewFileNm"/></label></th>
								<td>
									<input type="text" name="viewFileNm" size="80" maxlength="160" value="" /> (확장자제외)
									<%-- ${sessionScope.button.btn_add} --%>       
								</td>
							</tr>
						</table>
						<div class="buttons">
					${sessionScope.button.a_init}
					${sessionScope.button.a_add}
				</div>
						<!-- ibsheet 영역 -->
				<div class="ibsheet_area" name="FileSheet">
			











					</div>
				<div class="buttons">
					${sessionScope.button.a_pubok}
					${sessionScope.button.a_modify}
				</div>
				</form>		
				</div>
			</div>
			
			<!-- 목록내용 -->
			<div class="content"  >
			<form name="adminOpenPublish"  method="post" action="#">
			<input type="hidden" name="ibSheetRow" value=""/>
			<table class="list01">              
				<caption>공표자료</caption>
				<colgroup>
					<col width="150"/>
					<col width=""/>
				</colgroup>
				<tr>
					<th>검색어</th>
					<td colspan="7">
						<select name="serSel">	
									<option value="ALL" ><spring:message code='etc.select'/></option>
									<option value="NM" selected="selected"><spring:message code='labal.pubNm'/></option>
									<option value="DM" ><spring:message code='labal.dsNm'/></option>
									<input type="text" name="serVal" value="" maxlength="50" style="width: 300px"/>
								</select> 
								${sessionScope.button.btn_inquiry}               
					</td>
				</tr>
				<tr>         
					<th>공표일시</th>
					<td colspan="7">
						<input type="text" name="pubDttmFrom" value="" readonly="readonly"/>&nbsp;~&nbsp;
						<input type="text" name="pubDttmTo" value="" readonly="readonly"/>
						${sessionScope.button.btn_init} 
					</td>
				</tr>
				<tr>
					<th><label class=""><spring:message code="labal.language"/></label></th>
					<td colspan="7">
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
				<th><spring:message code="labal.orgCdNm"/></th>
						<td colspan="7">
							<input type="hidden" name="orgCd"/>
							<input type="text" name="orgNm"/>
							${sessionScope.button.btn_search}
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