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
<!--  
	validate 사용시 반드시 선언
	formName명과 validate 함수명이 연결되어있음
	adminOpenInfPrss -> validateadminOpenInfPrss 체크함
	resources/validator/*.* xml을 만들어서 사용
  -->
<%-- <validator:javascript formName="adminOpenInfPrss" staticJavascript="false" xhtml="true" cdata="false"/> --%>
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

function init(){
	var formObj = $("form[name=adminOpenInfPrss]");
	formObj.find("input[name=openDttmTo]").datepicker(setCalendar());          
	formObj.find("input[name=openDttmFrom]").datepicker(setCalendar());      
	datepickerTrigger();     
	formObj.find("button[name=btn_search]").eq(2).click(function(e) { 
		doAction("search");
		 return false;        
	 }); 
	formObj.find("button[name=btn_search]").eq(0).click(function(e) { 
		doAction("poporgnm");
		return false;               
	 }); 
	formObj.find("button[name=btn_search]").eq(1).click(function(e) { 
		doAction("popcatenm");
		return false;                  
	 }); 
	formObj.find("button[name=btn_init]").eq(0).click(function(e) { 
		formObj.find("input[name=orgNm]").val("");
		formObj.find("input[name=orgCd]").val("");
		return false;               
	}); 
	formObj.find("button[name=btn_init]").eq(1).click(function(e) { 
		formObj.find("input[name=cateNm]").val("");
		formObj.find("input[name=cateId]").val("");
		return false;               
	}); 
	
	formObj.find("select[name=searchWd]").val("0");
	
	formObj.find("button[name=btn_dttm]").click(function(e) { 
		formObj.find("input[name=openDttmFrom]").val("");
		formObj.find("input[name=openDttmTo]").val("");
	 }); 
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
		//gridTitle +="|"+"데이터셋 구분";        
		gridTitle +="|"+"<spring:message code='labal.cateNm'/>";        
		gridTitle +="|"+"<spring:message code='labal.orgNm'/>";        
// 		gridTitle +="|"+"<spring:message code='labal.usrNm'/>";        
		gridTitle +="|"+"<spring:message code='labal.infState'/>";        
		gridTitle +="|"+"<spring:message code='labal.prssState'/>";        
		gridTitle +="|개방일자";    
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
                 	{Type:"Seq",			SaveName:"seq",					Width:40,	Align:"Center",		Edit:false,  Sort:false}
					,{Type:"Text",			SaveName:"infId",				Width:0,		Align:"Center",		Edit:false, Hidden:true}
					,{Type:"Text",			SaveName:"dtNm",				Width:290,	Align:"Left",			Edit:false}
					,{Type:"Text",			SaveName:"infNm",				Width:290,	Align:"Left",			Edit:false}
					,{Type:"Text",			SaveName:"cateFullnm",		Width:160,	Align:"Left",			Edit:false}
					,{Type:"Text",			SaveName:"orgNm",				Width:160,	Align:"Left",			Edit:false}
					,{Type:"Combo",		SaveName:"infState",			Width:110,	Align:"Left",			Edit:false}
					,{Type:"Combo",		SaveName:"prssState",			Width:110,	Align:"Left",			Edit:false}
					,{Type:"Text",			SaveName:"openDttm",			Width:90,	Align:"Center",		Edit:false}
					,{Type:"Html",		SaveName:"openSrv",			Width:70,	Align:"Left",		Edit:false}
                ];       
                                      
        InitColumns(cols);                                                                           
        SetExtendLastCol(1);   
        SetColProperty("prssState", 	${codeMap.pressStateIbs});           
        SetColProperty("infState", 	${codeMap.infStateIbs});      
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
			var formObj = $("form[name=adminOpenInfPrss]");        
			fromObj = formObj.find("input[name=openDttmFrom]");                          
			toObj = formObj.find("input[name=openDttmTo]");
			dateValCheck(fromObj,toObj)// from , to 날짜 안맞을 경우 자동셋팅   
			ajaxBeforeSendAdmin("<c:url value='/admin/ajaxBeforeSendAdmin.do'/>"); //IbSheet 조회전 세션 체크
			var param = {PageParam: "ibpage", Param: "onepagerow=50&"+actObj[0]};         
			mySheet.DoSearchPaging("<c:url value='/admin/openinf/openInfPrssListAll.do'/>", param);   
			break;
		case "popclose":              
			closeIframePop("iframePopUp");
			break;
		case "poporgnm":
			var url="<c:url value="/admin/basicinf/popup/commOrg_pop.do"/>";
			var popup = OpenWindow(url,"orgPop","500","550","yes");	    
			break;
		case "popcatenm":
			var url = "<c:url value="/admin/opendt/openCateParListPopUp.do"/>" + "?cateGb=2";
			var popup = OpenWindow(url,"openCateParListPopUp","750","550","yes");	
			break;
	}           
}   

function mySheet_OnDblClick(row, col, value, cellx, celly) {
    if(row == 0) return;     
    tabEvent(row);                      
}  

function tabEvent(row){	//탭 이벤트 실행                
	var title = mySheet.GetCellValue(row,"infNm");//탭 제목      
	var id = mySheet.GetCellValue(row,"infId");//탭 id(유일해야함))     
    openTab.SetTabData(mySheet.GetRowJson(row));//db data 조회시 조건 data
    var url = "<c:url value='/admin/openinf/openInfPrssDtl.do'/>"; // Controller 호출 url
    openTab.addTab(id,title,url,tabPrssCallBack); // 탭 추가 시작함
}

function tabPrssCallBack(tab,json){
	if(json.DATA != null){
// 		tab.ContentObj.find("a[name=prssAK]").hide();
// 		tab.ContentObj.find("a[name=prssAC]").hide();
		$.each(json.DATA,function(key,state){ 
			var srvCd = state.srvCd;
			var srvIndex = typeIndex(srvCd);     
			$.each(state,function(key2,state2){
				if(key2 =="srvYn" && srvIndex > -1){ //사용여부 판단     
					if(state2 =="Y"){                                                 
						tab.ContentObj.find(".serviceYn").find("span").eq(srvIndex).removeClass("icon-no-service").addClass("icon-on");
					}else{
						tab.ContentObj.find(".serviceYn").find("span").eq(srvIndex).removeClass("icon-no-service").addClass("icon-service");            
					} 
				}
/* 				if((key2 == "infState" && state2 == "N")){
					tab.ContentObj.find("a[name=prssAK]").show();
				}
				if(key2 == "prssState" && state2 == "AA"){
					tab.ContentObj.find("a[name=prssAC]").show();
				} */
				if(key2 == "apiRes"){
					if(state2 != null){
						tab.ContentObj.find("[name=apiRes]").val(state2);
					}
				}else if(key2 == "sgrpCd"){
					if(state2 != null){
						tab.ContentObj.find("[name=sgrpCd]").val(state2);
					}
				}
// 				if(key2 == "orgCd") alert(state2);
				if(tab.ContentObj.find("[name="+key2+"]").attr("type") == 'checkbox'){          
					tab.ContentObj.find("[name="+key2+"]"+":checkbox[value='"+state2+"']").prop("checked",true); 
				}else{          
					tab.ContentObj.find("[name="+key2+"]").val(state2);
				}
			});
		}); 
		
		//승인 권한 이상일 경우 버튼 보여줌
		var prssAccCd = json.DATA[0].prssAccCd;
		if ( prssAccCd >= 40 ) {
			tab.ContentObj.find("a[name=prssAK]").show();	
			tab.ContentObj.find("a[name=prssAC]").show();
		}
	}
	setTabButton();
}

function viewPop(srvCd){
	var objTab = getTabShowObj();//탭이 oepn된 객체가져옴
 	var formObj = objTab.find("form[name=adminOpenInfPrss]");     
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
	var objTab = getTabShowObj();//탭이 oepn된 객체가져옴
 	var formObj = objTab.find("form[name=adminOpenInfPrss]");       
//  	var newDate = new Date();
//  	var yy = newDate.getFullYear();
//  	var mm = (newDate.getMonth()+1)>9 ? '' + (newDate.getMonth()+1) : '0' + (newDate.getMonth()+1);
//  	var dd = newDate.getDate()>9 ? '' + newDate.getDate() : '0' + newDate.getDate();
//  	var today = yy + "-" +mm +"-" + dd;
// 	formObj.find("input[name=openDttm]").datepicker(setOpenCalendar());    
// 	formObj.find("input[name=openDttm]").val(today);
	datepickerInitTab(formObj.find("input[name=openDttm]")); //초기화
	formObj.find("input[name=openDttm]").datepicker(setCalendar());    
	datepickerTrigger();
	
	formObj.find("a[name=prssAK]").click(function() {		// 개방승인
 		doTabAction("prssAK");          
 		return false;                 
 	});
	
	formObj.find("a[name=prssAC]").click(function() {		// 개방불가
 		doTabAction("prssAC");          
 		return false;                 
 	});
	
	formObj.find("a[name=prssLog]").click(function() {		// 요청기록
 		doTabAction("prssLog");          
 		return false;                 
 	});
	
	formObj.find("button[name=metaView]").click(function() {		// 메타상세
 		doTabAction("metaView");          
 		return false;                 
 	});
	
	formObj.find("button[name=datasetView]").click(function() {		// 데이터셋상세
 		doTabAction("datasetView");          
 		return false;                 
 	});
	
	formObj.find("[name=T]").click(function() {		// TsSheet미리보기
 		if(!formObj.find("[name=T]").hasClass("icon-no-service")){
 			viewPop('T');
 		}
 		return false;                 
 	});
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
	
}

function doTabAction(sAction){	
	var classObj = $("."+tabContentClass); //tab으로 인하여 form이 다건임
	var actObj = setTabForm(classObj); // 0: form data, 1: form 객체
	var objTab = getTabShowObj();//탭이 oepn된 객체가져옴
	var formObj = objTab.find("form[name=adminOpenInfPrss]");
	var infId = formObj.find("input[name=infId]").val();
	ajaxBeforeSendAdmin("<c:url value='/admin/ajaxBeforeSendAdmin.do'/>"); //IbSheet 조회전 세션 체크
	switch(sAction){
	
		case "prssAK":
 			if ( !confirm("개방승인 하시겠습니까? ") ) {
 				return;
  			}
			var url = "<c:url value='/admin/openinf/openInfPrssReg.do'/>"; 
			var param = formObj.serialize();
					param += "&newState=AK";
			ajaxCallAdmin(url, param, saveCallBack);
			break;
			
		case "prssAC":
 			if ( !confirm("개방불가처리 하시겠습니까? ") ) {
 				return;
  			}
			var url = "<c:url value='/admin/openinf/openInfPrssReg.do'/>"; 
			var param = formObj.serialize();
					param += "&newState=AC";
			ajaxCallAdmin(url, param, saveCallBack);
			break;
			
		case "prssLog":
			var param = "infId="+infId;
			var url="<c:url value="/admin/openinf/popup/openInfPrssLogPop.do"/>";
	    	var popup = OpenWindow(url+"?"+param, "prssLogPop","800","550","yes"); 	
			break;
		
		case "metaView":
			var target = "<c:url value='/admin/openinf/popup/openInfViewPopUp.do'/>"+"?infId="+infId;
			var wName = "metaview"        
			var wWidth = "1024"
			var wHeight = "580"                            
			var wScroll ="no"
			OpenWindow(target, wName, wWidth, wHeight, wScroll);                     
			break;
			
		case "datasetView":
			var dsId = formObj.find("input[name=dsId]").val();                  
	 		if(dsId == ""){
	 			alert("데이터셋 정보가 없습니다.");
	 		}else{
	 			var target = "<c:url value="/admin/openinf/opends/popup/opends_samplePop.do"/>";
	 			var wName = "samplePop"        
	 			var wWidth = "1024"
	 			var wHeight = "580"                            
	 			var wScroll ="no"
	 			OpenWindow(target+"?dsId="+dsId, wName, wWidth, wHeight, wScroll);      
	 		}
			break;
		
	}
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

//마우스 이벤트
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
					<li><a href="#">공공데이터목록asdfsdfsfsdfsdfsdf</a><a href="#" class="line_close">x</a></li>
				</ul>
			</div>
			
			<!-- 탭 내용 --> 
			<div class="content" style="display:none">
				<form name="adminOpenInfPrss"  method="post" action="#">
				<input type="hidden" name="infId"/>
				<input type="hidden" name="seq"/>
				<input type="hidden" name="apiRes" />
				<input type="hidden" name="sgrpCd" />
				<table class="list01">
					<caption></caption>
					<colgroup>
						<col width="150"/>
						<col width=""/>
						<col width="150"/>
						<col width=""/>
					</colgroup>
					<tr>
						<th><label class=""><spring:message code="labal.infNm"/></label></th>
						<td colspan="3">
							<div style="float:left;width:70%;"><input type="text" name="infNm" size="50" class="text-read" readonly/></div> 
							<div style="float:right;width:30%;text-align:right;"><button type="button" class="btn01L" name="datasetView">데이터셋상세</button>
							<button type="button" class="btn01" name="metaView">메타상세</button></div>
						</td>
					</tr>
					<tr>
						<th><label class=""><spring:message code="labal.dataSet"/></label></th>
						<td colspan="3">
							<input type="hidden" name="dsId" class="text-read" readonly/>
							<input type="text" name="dsNm" class="text-read" style="width:50%;" readonly/>
						</td>
					</tr>
					<tr>
						<th>분류명</th>
						<td colspan="3">
						<input type="text" name="cateFullnm" class="text-read" style="width:50%;" readonly/>
						</td>
					</tr>
<!-- 					<tr> -->
<%-- 						<th><label class=""><spring:message code="labal.post"/></label></th> --%>
<!-- 						<td colspan="3"> -->
<%-- 							<input type="checkbox" name="korYn" value="Y"/> <label class=""><spring:message code="labal.kor"/></label> --%>
<%-- 							<input type="checkbox" name="engYn" value="Y"/> <label class=""><spring:message code="labal.eng"/></label> --%>
<%-- 							<input type="checkbox" name="korMobileYn" value="Y"/> <label class=""><spring:message code="labal.mobile"/></label> --%>
<!-- 						</td> -->
<!-- 					</tr> -->
					<tr>
						<th><label class=""><spring:message code="labal.serviceCd"/></label></th>
						<td colspan="3" class="serviceYn">
							<span class="icon-no-service" name="T" style="display:none;"><a href="#" >tsSheet</a></span> 
							<span class="icon-no-service" name="S"><a href="#" >Sheet</a></span> 
							<span class="icon-no-service" name="C"><a href="#" >Chart</a></span>
							<span class="icon-no-service" name="M"><a href="#" >Map</a></span>
							<span class="icon-no-service" name="L"><a href="#" >Link</a></span>
							<span class="icon-no-service" name="F"><a href="#" >File</a></span>
							<span class="icon-no-service" name="A"><a href="#" >Open API</a></span>
							서비스유형을 클릭하시면 서비스를 미리보실 수 있습니다.
						</td>
					</tr>
					<tr>
						<th><label class=""><spring:message code="labal.orgCdNm"/></label></th>
						<td colspan="3">
							<input type="hidden" name="orgFullnm" />
							<input type="hidden" name="orgCd"/>
							<input type="text" name="orgNm" class="text-read" readonly/>
						</td>
					</tr>
					<tr>
						<th><label class=""><spring:message code="labal.usrNm"/></label></th>
						<td>
							<input type="text" name="usrNm" class="text-read" readonly/>
						</td>
						<th>연락처</th>
						<td>
							<input type="text"  class="text-read" readonly/>
						</td>
					</tr>
					<tr>
						<th><label class=""><spring:message code="labal.status"/></label></th>
						<td colspan="3">
							<input type="hidden" name="prssState" />
							<input type="hidden" name="infState" />
							<input type="text" name="infStateNm" class="text-read" readonly/>
						</td>
					</tr>
					<tr>
						<td colspan="4"></td>
					</tr>
					<tr>
						<th>담당자</th>
						<td colspan="3">
							<input type="text" name=""  class="text-read" readonly/><!-- 세션처리 -->
						</td>
					</tr>
					<tr>
						<th><label class=""><spring:message code="labal.prssExp"/></label></th>
						<td colspan="3" style="padding-top:4px;padding-bottom:4px;">
							<textarea rows="3" style="width:570px;" name="prssExp"></textarea>
						</td>
					</tr>
					<tr>
						<th><label class="">개방일자</label></th>
						<td colspan="3">
							<input type="text" name="openDttm" readonly="readonly"> <span class="text-red">알림 : 개방 승인이 되어도 개방일자가 되어야 홈페이지에 개방됩니다.</span>
						</td>
					</tr>
				</table>	
				<div class="buttons">
					<a href="#" class="btn03" name="prssAK" style="display: none;">개방승인</a>					
					<a href="#" class="btn03" name="prssAC" style="display: none;">개방불가</a>
					<a href="#" class="btn02" name="prssLog">요청기록</a>
				</div>	
				</form>
			</div>
			
			<!-- 목록내용 -->
			<div class="content"  >
			<form name="adminOpenInfPrss"  method="post" action="#">
			<input type="hidden" name="prssGubun" value="AK" />
			<input type="hidden" name="searchGubun" value="Y"/>
			<table class="list01">              
				<caption>공공데이터 개방요청</caption>
				<colgroup>
					<col width="150"/>
					<col width=""/>
				</colgroup>
				<tr>
					<th>검색어</th>
					<td>
						<select name="searchWd">
							<option value=""><spring:message code="labal.allSelect"/></option>
							<option value="0">공공데이터명</option>
		                 	<option value="1">보유데이터명</option>
		                 	<option value="2">태그명</option>
						</select>
						<input name="searchWord" type="text" value=""/>
					</td>
				</tr>
				<tr>
					<th><label class=""><spring:message code="labal.orgNm"/></label></th>
					<td>
						<input type="hidden" name="orgCd"/>
						<input type="text" name="orgNm" readonly="readonly"/>
						<button type="button" class="btn01" name="btn_search">검색</button>
						<button type="button" class="btn01" name="btn_init">초기화</button>
					</td>
				</tr>
				<tr>
					<th><label class=""><spring:message code="labal.cateNm"/></label></th>
					<td>
						<input type="hidden" name="cateId"/>
						<input type="text" name="cateNm" readonly="readonly"/>
						<button type="button" class="btn01" name="btn_search">검색</button>
						<button type="button" class="btn01" name="btn_init">초기화</button>
					</td>
				</tr>
				<!-- 
				<tr>
					<th><label class="">데이터셋 구분</label></th>
					<td>
						<input type="radio"  name="dsCd" id="dsCdA" value="" checked="checked"/>  
						<label for="dsCdA">전체</label>
						<input type="radio"  name="dsCd" id="dsCdR" value="RAW"/>       
						<label for="dsCdR">원시</label>              
						<input type="radio"  name="dsCd" id="dsCdT" value="TS"/>                        
						<label for="dsCdT">통계</label>       
					</td>
				</tr> -->				
				<tr>
					<th><label class="">개방일자</label></th>
					<td>
						<input type="text" name="openDttmFrom" value="" readonly="readonly"/>
						<input type="text" name="openDttmTo" value="" readonly="readonly"/>   
						<button type="button" class="btn01" name="btn_dttm">날짜초기화</button>    
						<button type="button" class="btn01B" name="btn_search"><spring:message code="btn.inquiry"/></button>
					</td>
				</tr>
<!-- 				<tr> -->
<%-- 					<th><label class=""><spring:message code="labal.status"/></label></th> --%>
<!-- 					<td> -->
<!-- 						<input type="radio"  name="infState" id="infStateA" value="" checked="checked"/>   -->
<%-- 						<label for="infStateA"><spring:message code='labal.infStateA'/></label> --%>
<!-- 						<input type="radio"  name="infState" id="infStateN" value="N"/>        -->
<%-- 						<label for="infStateN"><spring:message code='labal.infStateN'/></label>               --%>
<!-- 						<input type="radio"  name="infState" id="infStateY" value="Y"/>                         -->
<%-- 						<label for="infStateY"><spring:message code='labal.infStateY'/></label>        --%>
<!-- 						<input type="radio"  name="infState" id="infStateC" value="C"/>           -->
<%-- 						<label for="infStateC"><spring:message code='labal.infStateC'/></label>     --%>
<!-- 					</td> -->
<!-- 				</tr> -->
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