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

$(document).ready(function(){                         
	btnSet();
	LoadPage();    
	LoadDetail(sheetName);
	doAction('search'); 

	inputEnterKey();       
	//tabSet();// tab 셋팅
	setButtons();
	

	$("button[name=btn_reg]").click(function(){	
		doSheetAction("reg"); return false;
	});	
	$("button[name=btn_inquiry]").click(function(){	
		doAction("search"); return false;
	});	
});  

function btnSet() { //버튼 초기화 함수
	   
	   $("a[name=a_import]").hide();
	   //$("a[name=a_reset]").show();
	   $("a[name=a_modify]").hide();
	   $("a[name=a_del]").hide();
	   
}



function LoadPage(){      
	
	//message-common_ko_KR.properties 선언 후 사용 or message-common_en_US.properties 선언 후 사용
	var gridTitle1 = "NO"
		gridTitle1 +="|"+"<spring:message code='labal.status'/>";
		gridTitle1 +="|"+"<spring:message code='btn.del'/>"
		gridTitle1 +="|"+"<spring:message code='labal.dtId'/>";
		gridTitle1 +="|"+"<spring:message code='labal.dtNm'/>";
		//gridTitle1 +="|"+"<spring:message code='labal.dtNmEng'/>"; 
		gridTitle1 +="|"+"<spring:message code='labal.srcExp'/>"; 
		gridTitle1 +="|"+"<spring:message code='labal.srcExpUrl'/>"; 
		//gridTitle1 +="|"+"<spring:message code='labal.srcExpEng'/>"; 
		gridTitle1 +="|"+"<spring:message code='labal.srcYn'/>";
		gridTitle1 +="|"+"<spring:message code='labal.useYn'/>"; 
		
		
	with(mySheet){
           
    	var cfg = {SearchMode:3,Page:50,VScrollMode:1};                                
        SetConfig(cfg);  
        var headers = [                               
                    {Text:gridTitle1, Align:"Center"}                 
                ];
        var headerInfo = {Sort:0,ColMove:1,ColResize:1,HeaderCheck:0};
        
        InitHeaders(headers, headerInfo); 
         
        var cols = [          
					 {Type:"Seq",		SaveName:"seq",				Width:15,	Align:"Center",		Edit:false,  Sort:false}
					,{Type:"Status",	SaveName:"status",			Width:20,	Align:"Center",		Edit:false}
					,{Type:"DelCheck",		SaveName:"delChk",			Width:10,	Align:"Center",		Edit:true}
					,{Type:"Text",		SaveName:"dtId",			Width:20,	Align:"Center",		Edit:false}
					,{Type:"Text",		SaveName:"dtNm",			Width:40,	Align:"Left",		Edit:true, KeyField:true}
					,{Type:"Text",		SaveName:"srcExp",			Width:30,	Align:"Left",		Edit:true}
					,{Type:"Text",		SaveName:"srcUrl",			Width:40,	Align:"Center",		Edit:true}
					,{Type:"Combo",		SaveName:"srcYn",			Width:20,	Align:"Left",		Edit:true}
					,{Type:"CheckBox",		SaveName:"useYn",		Width:20,	Align:"Center",		Edit:true, TrueValue:"Y", FalseValue:"N"}
                ];         
                                      
        InitColumns(cols);                                                                           
        FitColWidth();                                                         
        SetExtendLastCol(1);   
        SetColProperty("srcYn", {ComboCode:"N|Y", ComboText:"비공개|공개"});
    }
        default_sheet(mySheet);    	
	
}

function LoadDetail(sheetName){
	var gridTitle2 = "삭제|상태|NO"
		 gridTitle2 +="|"+"<spring:message code='labal.dtId'/>";
		 gridTitle2 +="|"+"<spring:message code='labal.ownTabId'/>";
		 gridTitle2 +="|"+"<spring:message code='labal.tbNm'/>";
		 gridTitle2 +="|"+"<spring:message code='labal.tbId'/>";
		 gridTitle2 +="|"+"<spring:message code='labal.ownerCd'/>";
		 gridTitle2 +="|"+"<spring:message code='labal.srcTblCd'/>";
		 gridTitle2 +="|"+"<spring:message code='labal.linkCd'/>";
		 gridTitle2 +="|"+"<spring:message code='labal.prssCd'/>";
		 gridTitle2 +="|"+"<spring:message code='labal.loadCd'/>";
		 gridTitle2 +="|"+"<spring:message code='labal.loadDttm'/>";
	
	with(sheetName){
      
  	var cfg = {SearchMode:2,Page:50,VScrollMode:1};                                
      SetConfig(cfg);  
      var headers = [                               
                  {Text:gridTitle2, Align:"Center"}                 
              ];
      var headerInfo = {Sort:0,ColMove:1,ColResize:1,HeaderCheck:0};
      
      InitHeaders(headers, headerInfo); 
      SetEditable(1);
       
      var cols = [          
					{Type:"DelCheck",	SaveName:"delChk",				Width:30,	Align:"Center",		Edit:true}
					,{Type:"Status",	SaveName:"status",				Width:30,	Align:"Center",		Edit:false}
					,{Type:"Seq",		SaveName:"seq",					Width:30,	Align:"Center",		Edit:false}
					,{Type:"Text",		SaveName:"dtId",				Width:140,	Align:"Center",		Edit:false, Hidden:true}
					,{Type:"Text",		SaveName:"ownTabId",			Width:140,	Align:"Left",		Edit:false}
					,{Type:"Text",		SaveName:"tbNm",				Width:80,	Align:"Left",		Edit:false}
					,{Type:"Text",		SaveName:"tbId",				Width:80,	Align:"Center",		Edit:false, Hidden:true}
					,{Type:"Text",		SaveName:"ownerCd",				Width:100,	Align:"Center",		Edit:false, Hidden:true}
					,{Type:"Combo",		SaveName:"srcTblCd",			Width:80,	Align:"Center",		Edit:true}
					,{Type:"Combo",		SaveName:"linkCd",				Width:80,	Align:"Center",		Edit:true}
					,{Type:"Combo",		SaveName:"prssCd",				Width:120,	Align:"Center",		Edit:true}
					,{Type:"Combo",		SaveName:"loadCd",				Width:80,	Align:"Center",		Edit:true}
					,{Type:"Date",		SaveName:"ltLoadDttm",			Width:80,	Align:"Center",		Edit:false}
              ];       
                                    
      InitColumns(cols);                                                                           
      FitColWidth();                                                         
      SetExtendLastCol(1);   
      SetColProperty("srcTblCd", 	${codeMap.srcTblCdIbs});
      SetColProperty("linkCd", 	${codeMap.linkCdIbs});
      SetColProperty("prssCd", 	${codeMap.prssCdIbs});
      SetColProperty("loadCd", 	${codeMap.loadCdIbs});
  }
      default_sheet(sheetName);
	
}

//기본 action
function doAction(sAction){
	var classObj = $("."+"content").eq(0); //tab으로 인하여 form이 다건임
	var actObj = setTabForm(classObj); // 0: form data, 1: form 객체
	switch(sAction) {          
		case "search":      //목록조회   
			ajaxBeforeSendAdmin("<c:url value='/admin/ajaxBeforeSendAdmin.do'/>"); //IbSheet 조회전 세션 체크
			var param = {PageParam: "ibpage", Param: "onepagerow=50&"+actObj[0]};    
			mySheet.DoSearchPaging("<c:url value='/admin/openinf/opendt/openDtList.do'/>", param);
			break;
	}
}

//detail sheet action
function doSheetAction(sAction){
	
	var classObj = $("."+"content").eq(1); //tab으로 인하여 form이 다건임
	var actObj = setTabForm(classObj); // 0: form data, 1: form 객체
	var sheetObj = "sheetName"; //IbSheet 객체         
	var objTab = getTabShowObj();//탭이 oepn된 객체가져옴 
	var formObj = classObj.find("form[name=adminOpenDt]"); 
	 
	ajaxBeforeSendAdmin("<c:url value='/admin/ajaxBeforeSendAdmin.do'/>"); //IbSheet 조회전 세션 체크
	
	var gridObj = window[sheetObj];
	var dtId = formObj.find("input[name=dtId]").val();
	
	switch(sAction){
		case "reg":	//등록
			tabNewEvent();
			break;
		<%-- case"searchDtl":	//상세목록조회    
			alert("!");
			var param = {PageParam: "ibpage", Param: "onepagerow=50&dtId="+dtId};    
			gridObj.DoSearchPaging("<c:url value='/admin/openinf/opendt/openDtblList.do'/>", param);
			break; --%>
		case "searchDtl":
			
// 			var row = mySheet.GetSelectionRows();
// 			var dtId = mySheet.GetCellValue(row,"dtId");
			ajaxBeforeSendAdmin("<c:url value='/admin/ajaxBeforeSendAdmin.do'/>"); //IbSheet 조회전 세션 체크
			var param = {PageParam: "ibpage", Param: "onepagerow=50&dtId="+dtId};   
			
			sheetName.DoSearchPaging("<c:url value='/admin/openinf/opendt/openDtblList.do'/>", param);
			break;
			
		case "import":		//불러오기
			var param = "&sheetNm="+sheetObj+"&dtId="+dtId;
			var url = "<c:url value="/admin/openinf/opendt/popup/openDtSrc_pop.do"/>";
	    	popwin = OpenWindow(url+"?"+param, "openDtSrcPop","700","550","yes"); 	
			break;
		case "save":	//신규 저장
			if (validateCheck(formObj)) {	return false;	}	//validation 체크
		
			//ibsSaveJson = gridObj.GetSaveJson(1);	//모든 행의 데이터를 객체로 받기
 			//alert(ibsSaveJson.data.length); 
			//if(ibsSaveJson.data.length < 0) return;
			//var url =  "<c:url value='/admin/openinf/opendt/saveOpenDt.do'/>";
			//var param = formObj.serialize();
			//ajaxCallAdmin(url,param,savecallbackprev); //등록을하고 다시 수정페이지로 오도록한다.
		//	IBSpostJson(url, param, sheetcallback);		
			//break;
			
			ibsSaveJson = mySheet.GetSaveJson();
			
			var url = "<c:url value='/admin/openinf/opendt/saveOpenDt.do'/>"; 
			var param = formObj.serialize();
			//param = param.replace(/%/g,'%25');					// parameter Encoding
			
			//ajaxCallAdmin(url, param, saveCallBack);
			IBSpostJson(url, param, sheetcallback);
			location.reload(); 
			break;
			
		case "updateDt":		//상세정보 수정
//			if (!validateAdminOpenDs(actObj[1])){  //validation 체크         
//				return;   
//			} 
			if ( !confirm("수정 하시겠습니까? ") ) {
				return;
  			}
			
			var url = "<c:url value='/admin/openinf/opendt/updateOpenDt.do'/>"; 
			var param = formObj.serialize();
			ajaxCallAdmin(url,param,savecallback);
			break;
		case"updateDtbl":	//테이블 목록 수정
			if ( !confirm("수정 하시겠습니까? ") ) {
				return;
  			}
		
			ibsSaveJson = gridObj.GetSaveJson(0);
// 			alert(ibsSaveJson.data.length);
			if(ibsSaveJson.data.length == 0) return;
			var url = "<c:url value='/admin/openinf/opendt/updateOpenDtbl.do'/>";
			var param = "&dtId="+formObj.find("input[name=dtId]").val();
			
			IBSpostJson(url, param, sheetcallback);		
			break;
		case "deleteDt":		// 보유데이터 삭제
			if ( !confirm("삭제 하시겠습니까? ") ) {
				return;
  			}
		
			var sheetCnt = gridObj.RowCount();
			if(sheetCnt > 0){
				alert("관련 테이블이 존재해서 삭제할 수 없습니다");
				return false;
			}else{
	 			var url = "<c:url value='/admin/openinf/opendt/deleteOpenDt.do'/>"; 
	 			var param = formObj.serialize();
	 			ajaxCallAdmin(url,param,savecallback);
			}
			break;
		case "deleteDtbl":	// 테이블 목록 삭제
			if ( !confirm("삭제 하시겠습니까? ") ) {
				return;
  			}
		
			ibsSaveJson = gridObj.GetSaveJson(0, "delChk");
// 			alert(ibsSaveJson.data.length);
			if(ibsSaveJson.data.length == 0) return;
			var url = "<c:url value='/admin/openinf/opendt/deleteOpenDtbl.do'/>";
			var param = "";
			IBSpostJson(url, param, sheetcallback);
			break;
	}    
}

function mySheet_OnClick(row, col, value, cellx, celly) {
    if(row == 0) return;     
	
    $("a[name=a_import]").show();
	//$("a[name=a_reset]").show();
	$("a[name=a_modify]").show();
	$("a[name=a_del]").show();
    
    var saveName = mySheet.ColSaveName(col);
    /* 
    if(saveName == "dtId"){
    	var url = "<c:url value='/admin/openinf/opendt/openDtblList.do'/>";
        var param = "dtId= " + mySheet.GetCellValue(row,"dtId");
        
     
        
        ajaxBeforeSendAdmin("<c:url value='/admin/ajaxBeforeSendAdmin.do'/>"); //IbSheet 조회전 세션 체크
        
        //ajaxCallAdmin(url, param, tabInfCallBack);
        
        //doTabAction("search");
        $("#dtId").val(mySheet.GetCellValue(row,"dtId"));
        doSheetAction('searchDtl');
    } else{
    	
    }
    
     */
                
} 

function mySheet_OnDblClick(row, col, value, cellx, celly) {
    if(row == 0) return;     
    //tabEvent(row);                      
}  

var sheetTabCnt = 0;
function tabEvent(row){//탭 이벤트 실행  
	var title = mySheet.GetCellValue(row,"dtNm");//탭 제목                                                    
	var id = mySheet.GetCellValue(row,"seq");//탭 id(유일한key))
    openTab.SetTabData(mySheet.GetRowJson(row));//db data 조회시 조건 data
    var url = "<c:url value='/admin/openinf/opendt/openDtDetail.do'/>"; // Controller 호출 url        
    var sheetYn = openTab.tabExits(id); //탭존재 여부      
    openTab.addTab(id,title,url,tabCallBack2); // 탭 추가 시작함(callback함수 overring)          
    if(!sheetYn){	//탭이 있을 경우 IBSheet 로드 방지                                  
    	var cnt = sheetTabCnt++;
    	SheetCreate(cnt); //시트
    	//doSheetAction('searchDtl');
    	buttonEventAdd();
    }else{
    	buttonEventAdd();
    }
}

function tabNewEvent(){
	var title = "등록하기"
	var id ="dtReg";
	var url = "";
	var sheetYn = openTab.tabExits(id); //탭존재 여부  
	openTab.addTab(id,title,url,tabCallRegBack2); // 탭 추가 시작함(callback함수 overring)          
		var cnt = sheetTabCnt++;
		SheetCreate(cnt);
		buttonEventAdd();
}

function tabCallRegBack2(tab){ 
	tab.ContentObj.find("a[name=a_modify]").hide();       
	tab.ContentObj.find("a[name=a_del]").hide();  
	tab.ContentObj.find("a[name=a_import]").hide();  //불러오기 숨김처리 
	
	
}

function tabCallBack2(tab,json){
	tab.ContentObj.find("a[name=a_reg]").hide();
	$.each(json.DATA,function(key,state){
		if(tab.ContentObj.find("form[name=adminOpenDt]").find("[name="+key+"]").attr("type") == 'checkbox'){  
			if(state == "Y"){
				tab.ContentObj.find("form[name=adminOpenDt]").find("[name="+key+"]").prop("checked",true);
			}
		}else{
			tab.ContentObj.find("form[name=adminOpenDt]").find("[name="+key+"]").val(state);
		}
	});                        
}

function SheetCreate(SheetCnt){       
	var SheetNm = "sheet"+SheetCnt;          
	$("div[name=mainSheet]").eq(1).attr("id","DIV_"+SheetNm);                                          
	createIBSheet2(document.getElementById("DIV_"+SheetNm),SheetNm, "100%", "300px");               
	var sheetobj = window[SheetNm]; 
	var objTab = getTabShowObj();//탭이 oepn된 객체가져옴
	var formObj = objTab.find("form[name=adminOpenDt]");
	formObj.find("input[name=sheetNm]").val(SheetNm);
	
	window[SheetNm + "_OnClick"] =  onClick;
	LoadDetail(sheetobj);	 
}

function buttonEventAdd(){
	setButtons();
}

function setButtons(){ 
	$("input, textarea").placeholder();
	/* var objTab = getTabShowObj();//탭이 oepn된 객체가져옴
	var formObj = objTab.find("form[name=adminOpenDt]"); */
	
	var classObj = $("."+"content") //tab으로 인하여 form이 다건임
	var formObj = classObj.find("form[name=adminOpenDt]");
	
	formObj.find("a[name=a_import]").click(function(e) { //불러오기
		doSheetAction('import');                 
		return false;                 
	});   
	formObj.find("a[name=a_reg]").eq(0).click(function(e) { //저장
		doSheetAction('save');                 
		return false;                 
	});          
	formObj.find("a[name=a_modify]").eq(0).click(function() { //테이블목록 수정
		doSheetAction('updateDtbl');
		location.reload(); 
		return false;                 
	});          
	       
	/* formObj.find("a[name=a_del]").eq(0).click(function() { //보유데이터 삭제
		doSheetAction('deleteDt');                     
		return false;                 
	});   */        
	formObj.find("a[name=a_del]").eq(0).click(function() { // 테이블 목록 삭제
		doSheetAction('deleteDtbl');    
		location.reload(); 
		return false;                 
	});
	
	
	formObj.find("input[name=dtNm]").keyup(function(e) {
		ComInputKorObj(formObj.find("input[name=dtNm]"));
		 return false;
	 });
	
	formObj.find("input[name=dtNmEng]").keyup(function(e) {
		ComInputEngBlankObj(formObj.find("input[name=dtNmEng]"));
		 return false;
	 });
	
	formObj.find("input[name=srcExp]").keyup(function(e) {
		ComInputKorObj(formObj.find("input[name=srcExp]"));
		 return false;
	 });
	
	formObj.find("input[name=srcExpEng]").keyup(function(e) {
		ComInputEngBlankObj(formObj.find("input[name=srcExpEng]"));
		 return false;
	 });
	
	formObj.find("input[name=srcUrl]").keyup(function(e) {
		ComInputEngUrlObj(formObj.find("input[name=srcUrl]"));
		 return false;
	 });
	
	formObj.find("button[name=a_orgAdd]").eq(0).click(function() {
		
		$("a[name=a_import]").hide();
		//$("a[name=a_reset]").show();
		$("a[name=a_modify]").hide();
		$("a[name=a_del]").hide();
		sheetName.RemoveAll();
		mySheet.DataInsert(0);
	});
	
	
} 

function sheetcallback(res){
    var result = res.RESULT.CODE;
    if(result == 0) {
    	alert(res.RESULT.MESSAGE);
    	doSheetAction('searchDtl');
    } else {                               
    	alert(res.RESULT.MESSAGE);
    }
}   

function savecallback(res){      
    alert(res.RESULT.MESSAGE);
    openTab.removeShowTab();
    $("a[id=tabs-main]").click();         
    doAction('search');
}

function savecallbackprev(res){   //등록하기를 통해 저장을 했을경우..   
    alert(res.RESULT.MESSAGE);
    openTab.removeShowTab();
    $("a[id=tabs-main]").click();
    doAction('search');
	$("input[name=tempRegValue]").val("1"); //값을 1로 하여 등록한 페이지 자동 click하도록 한다.    mySheet_OnSearchEnd() 로직 
}

function mySheet_OnSearchEnd(Code,Msg,StCode,StMsg){
	if( $("input[name=tempRegValue]").val() == "1" ){
		$("input[name=tempRegValue]").val("0"); //값을 0로 하여 조회시 페이지 자동 click하지 못하도록 한다.
		tabEvent(1);
	}
	
}


function onClick(row, col, value, cellx, celly) {
	
}

function inputEnterKey(){
	$("input").keypress(function(e) {
		  if(e.which == 13) {
			  doAction('search');   
			  return false;
		  }
	});
}  



function validateCheck(formObj){
 	
	// 보유데이터명 한글 필수입력
	if ( nullCheckValdation( formObj.find('input[name=dtNm]'), "<spring:message code='labal.dtNm'/>", "" ) ) {
		return true;
	}
	
// 	if ( nullCheckValdation( formObj.find('input[name=dtNmEng]'), "<spring:message code='labal.dtNmEng'/>", "" ) ) {
// 		return true;
// 	}
	
// 	if ( nullCheckValdation( formObj.find('input[name=srcUrl]'), "<spring:message code='labal.srcExpUrl'/>", "" ) ) {
// 		return true;
// 	}
	
// 	if ( nullCheckValdation( formObj.find('input[name=srcExp]'), "<spring:message code='labal.srcExp'/>", "" ) ) {
// 		return true;
// 	}
	
// 	if ( nullCheckValdation( formObj.find('input[name=srcExpEng]'), "<spring:message code='labal.srcExpEng'/>", "" ) ) {
// 		return true;
// 	}
	
	return false;                               
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
		
		<div class="more_list" style="display:none">
			<a href="#" class="more">0</a>                
			<ul class="other_list" style="display:none;">
				<li><a href="#">보유데이터목록</a><a href="#" class="line_close">x</a></li>
				<li><a href="#">공공데이터목록</a><a href="#" class="line_close">x</a></li>
			</ul>
		</div>
		
		<!-- 목록내용 -->
		<div class="content"  >
		<form name="adminOpenDt"  method="post" action="#">
		<table class="list01">              
			<caption>보유데이터목록리스트</caption>
			<colgroup>
				<col width="150"/>
				<col width=""/>
				<col width="150"/>
				<col width=""/>
			</colgroup>
			<tr>
				<th>검색어</th>
				<td colspan="3">
					<select name="searchWd">
						<option value="00">선택</option>
						<option value="0" selected="selected"><label class=""><spring:message code="labal.dtNm"/></label></option>
	                 	<option value="2"><label class=""><spring:message code="labal.srcExp"/></label></option>
					</select>
					<input type="text" name="searchWord" value="" maxlength="160" />
					${sessionScope.button.btn_inquiry}
					<%-- ${sessionScope.button.btn_reg} --%>        
				</td>
			</tr>
		</table>		
			
			
			<!-- ibsheet 영역 -->
			<div style="float: right; padding-bottom: 5px;">
				<button type="button" class="btn01" name="a_orgAdd" >추가</button>
			</div>
			<div style="clear: both;"></div>
			<div class="ibsheet_area_both">
				<script type="text/javascript">createIBSheet("mySheet", "100%", "300px"); </script>             
			</div>
			
			<div class="buttons">
					<a href="#" class="btn03" name="a_reg">저장</a>					
					<!-- <a href="#" class="btn03" name="a_modify">수정</a> -->
					<!-- <a href="#" class="btn03" name="a_del">삭제</a> -->
			</div>
			</form>	
		</div>
		
		<!-- 탭 내용 --> 
		<div class="content" style="display: none;">
			<form name="adminOpenDt"  method="post" action="#">
			<input type="hidden" name="sheetNm"/>
			<input type="hidden" name="tempRegValue" value="0"/> <!-- 등록완료 후 sheet등록하도록 값이 1이면 수행.  -->
			<input type="hidden" name="dtId" id="dtId" />
			
			<%-- <table class="list01">
					<caption>보유데이터목록리스트</caption>
					<colgroup>
						<col width="150"/>
						<col width=""/>
						<col width="150"/>
						<col width=""/>
					</colgroup>
					<tr>
						<th><label class=""><spring:message code="labal.dtId"/></label></th>
						<td colspan="3"><input type="text" name="dtId" value="" placeholder="자동생성" readonly class="readonly"/></td>
					</tr>
					<tr>
						<th><label class=""><spring:message code="labal.dtNm"/></label> <span>*</span></th>
						<td colspan="3">
						(한) <input type="text" name="dtNm" size="45" value=""  maxlength="160"/>    
						(영) <input type="text" name="dtNmEng" size="45" value=""  maxlength="160"/></td>
					</tr>
					<tr>
						<th><label class=""><spring:message code="labal.srcExpUrl"/></label> </th>
						<td colspan="3">
							<input type="text" size="49" name="srcUrl" placeholder="http://" maxlength="160"/>    
						</td>   
					</tr>
					<tr>
						<th><label class=""><spring:message code="labal.srcExp"/></label></th>
						<td colspan="3">
							(한) <input type="text" name="srcExp" value="" size="45" maxlength="160"/> 
							(영) <input type="text" name="srcExpEng" value="" size="45"  maxlength="160"/>
							<input type="checkbox" name="srcYn" value="Y" /> <label for="metaopen"><label class=""><spring:message code="labal.metaOpen"/></label></label>
						</td>
					</tr>
					
				</table> --%>
				
				
				
				<!-- ibsheet 영역 -->
				<div class="ibsheet-header">				
					<h3 class="text-title2">관련 테이블 목록</h3>
				</div>
				<!-- ibsheet 영역 -->
				<div style="clear: both;"></div>
				<div class="ibsheet_area_both">
					<script type="text/javascript">createIBSheet("sheetName", "100%", "300px"); </script>             
				</div>
				<!-- <div class="ibsheet_area" name="mainSheet"></div> -->
				<div class="buttons">
					<a href="#" class="btn02" name="a_import">불러오기</a>					
					<a href="#" class="btn03" name="a_modify" >수정</a>					
					<a href="#" class="btn03" name="a_del">삭제</a>
				</div>	
				
			</form>
		</div>
	
	
	</div>
	
	</div>
<!--##  푸터  ##-->                                       
<c:import  url="/WEB-INF/jsp/admin/adminfooter.jsp"/>                                   
<!--##  /푸터  ##-->     
</body>

</html>