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
	init();
}); 

function init(){
	var formObj = $("form[name=adminOpenInfPrss]");
	formObj.find("input[name=openDttmTo]").datepicker(setCalendar());          
	datepickerTrigger();     
	formObj.find("button[name=btn_inquiry]").eq(0).click(function(e) { 
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
	
}

function LoadPage()                
{      
	//message-common_ko_KR.properties 선언 후 사용 or message-common_en_US.properties 선언 후 사용
	var gridTitle = "NO"
		gridTitle +="|"+"<spring:message code='labal.infId'/>";  
		gridTitle +="|"+"<spring:message code='labal.dtNm'/>";  
		gridTitle +="|"+"<spring:message code='labal.infNm'/>";        
		gridTitle +="|"+"데이터셋 구분";        
		gridTitle +="|"+"<spring:message code='labal.cateNm'/>";        
		gridTitle +="|"+"<spring:message code='labal.orgNm'/>";        
// 		gridTitle +="|"+"<spring:message code='labal.usrNm'/>";        
		gridTitle +="|"+"<spring:message code='labal.prssState'/>";        
	
    with(mySheet){
    	                     
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
					 {Type:"Seq",		SaveName:"seq",				Width:30,	Align:"Center",		Edit:false}
					,{Type:"Text",		SaveName:"infId",			Width:100,	Align:"Center",		Edit:false, Hidden:true}
					,{Type:"Text",		SaveName:"dtNm",			Width:100,	Align:"Left",		Edit:false}
					,{Type:"Text",		SaveName:"infNm",			Width:100,	Align:"Left",		Edit:false}
					,{Type:"Text",		SaveName:"cateNm",			Width:100,	Align:"Left",		Edit:false}
					,{Type:"Text",		SaveName:"orgNm",			Width:100,	Align:"Left",		Edit:false}
					,{Type:"Combo",		SaveName:"prssState",		Width:100,	Align:"Left",		Edit:false}
                ];       
                                      
        InitColumns(cols);                                                                           
        FitColWidth();                                                         
        SetExtendLastCol(1);   
        SetColProperty("prssState", 	${codeMap.pressStateIbs});    	//공통코드가 안나와서 일단은 주석처리해놓음      
    }               
    default_sheet(mySheet);                      
} 
/**
 * 상세 조회시 IBS
 */
function LoadPage2(sheetName){
	var gridTitle = "NO"
		gridTitle +="|"+"<spring:message code='labal.infId'/>";
		gridTitle +="|"+"<spring:message code='labal.dtNm'/>";  
		gridTitle +="|"+"<spring:message code='labal.infNm'/>";        
		gridTitle +="|"+"<spring:message code='labal.oldState'/>";        
		gridTitle +="|"+"<spring:message code='labal.prssState'/>";        
		gridTitle +="|"+"<spring:message code='labal.openDttm'/>";        
		gridTitle +="|"+"<spring:message code='labal.orgNm'/>";
		gridTitle +="|"+"<spring:message code='labal.usrNm'/>";
		gridTitle +="|"+"<spring:message code='labal.regDttm'/>";
	
	with(sheetName){
      
  	var cfg = {SearchMode:3,Page:50,VScrollMode:1};                                
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
					 {Type:"Seq",		SaveName:"seq",				Width:30,	Align:"Center",		Edit:false}
					,{Type:"Text",		SaveName:"infId",			Width:100,	Align:"Center",		Edit:false, Hidden:true}
					,{Type:"Text",		SaveName:"dtNm",			Width:100,	Align:"Left",		Edit:false}
					,{Type:"Text",		SaveName:"infNm",			Width:100,	Align:"Left",		Edit:false}
					,{Type:"Text",		SaveName:"oldState",		Width:100,	Align:"Left",		Edit:false}
					,{Type:"Text",		SaveName:"newState",		Width:100,	Align:"Left",		Edit:false}
					,{Type:"Text",		SaveName:"openDttm",		Width:100,	Align:"Center",		Edit:false}
					,{Type:"Text",		SaveName:"orgNm",			Width:100,	Align:"Left",		Edit:false}
					,{Type:"Text",		SaveName:"usrNm",			Width:100,	Align:"Left",		Edit:false}
					,{Type:"Text",		SaveName:"regDttm",			Width:100,	Align:"Center",		Edit:false}
             ];         
                                    
      InitColumns(cols);                                                                           
      FitColWidth();                                                         
      SetExtendLastCol(1);
  	}
	
    default_sheet(sheetName);
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
			var url="<c:url value="/admin/basicinf/popup/commOrg_pop.do"/>" + "?orgNmGb=2";
			var popup = OpenWindow(url,"orgPop","550","550","yes");
			popup.focus();
			break;
		case "popcatenm":
			var url="<c:url value="/admin/opendt/openCateParListPopUp.do"/>" + "?cateGb=2";
			var popup = OpenWindow(url,"orgPop","550","550","yes");
			popup.focus();
			break;
	}           
}   

function mySheet_OnDblClick(row, col, value, cellx, celly) {
    if(row == 0) return;
    tabEvent(row);
}
//탭 추가 이벤트
function tabEvent(row){   
	var title = mySheet.GetCellValue(row,"infNm");//탭 제목 
	var id = mySheet.GetCellValue(row,"seq");//탭 id(유일한key))
	openTab.SetTabData(mySheet.GetRowJson(row));//db data 조회시 조건 data
	var url = "<c:url value='/admin/openinf/openInfListTab.do'/>"; // Controller 호출 url  
	openTab.addTab(id,title,url,tabPrssCallBack); // 탭 추가 시작함(callback함수 overring)          
	var cnt = sheetTabCnt++;
	SheetCreate(cnt); //시트
}
//탭 Sheet 생성
function SheetCreate(SheetCnt){       
 	var SheetNm = "mySheet2"+SheetCnt;          
 	$("div[name=openHisListSheet]").eq(1).attr("id","DIV_"+SheetNm);                                          
 	createIBSheet2(document.getElementById("DIV_"+SheetNm),SheetNm, "100%", "400px");               
 	var sheetObj = window[SheetNm]; 
 	var objTab = getTabShowObj();//탭이 oepn된 객체가져옴
 	var formObj = objTab.find("form[name=adminOpenInfTab]");
 	formObj.find("input[name=sheetNm]").val(SheetNm);
 	LoadPage2(sheetObj);
 	doSheetAction("searchList");
}

//탭 액션
function doSheetAction(sAction)
{
	var classObj = $("."+tabContentClass); //tab으로 인하여 form이 다건임
	var actObj = setTabForm(classObj); // 0: form data, 1: form 객체
	var sheetObj; //IbSheet 객체
	var objTab = getTabShowObj();//탭이 oepn된 객체가져옴
	var formObj = objTab.find("form[name=adminOpenInfTab]");
	sheetObj =formObj.find("input[name=sheetNm]").val();   
	ajaxBeforeSendAdmin("<c:url value='/admin/ajaxBeforeSendAdmin.do'/>"); //IbSheet 조회전 세션 체크
	var gridObj = window[sheetObj];
	var infId = formObj.find("[name=infId]").val();
	switch(sAction)                    
	{
		case "searchList" :	// 선택된 메티정보의 변경이력 List 출력
			var url = "<c:url value='/admin/openinf/openLogInfOneList.do'/>";
			var param = {PageParam: "ibpage", Param: "onepagerow=50&"+"infId="+infId};
			gridObj.DoSearchPaging(url, param); 
			break;
		case "metaView":
			var target = "<c:url value='/admin/openinf/popup/openInfViewPopUp.do'/>"+"?infId="+infId;
			var wName = "metaview"        
			var wWidth = "1024"
			var wHeight = "580"                            
			var wScroll ="no"
			OpenWindow(target, wName, wWidth, wHeight, wScroll);                     
			break;
	}
}

function tabPrssCallBack(tab,json){
	if(json.DATA != null){
		$.each(json.DATA,function(key,state){ 
			var srvCd = state.srvCd;
			var srvIndex = typeIndex(srvCd);     
			$.each(state,function(key2,state2){
				tab.ContentObj.find("a[name=a_reg]").remove();         
				if(key2 == "infState"){
					if(state2 == "Y"){
						tab.ContentObj.find(".icon-open1").attr("style", "");
						tab.ContentObj.find(".icon-open2").attr("style", "display:none;");
						tab.ContentObj.find(".icon-open3").attr("style", "display:none;");
						tab.ContentObj.find(".icon-open4").attr("style", "display:none;");
					}else if(state2 == "N"){
						tab.ContentObj.find(".icon-open1").attr("style", "display:none;");
						tab.ContentObj.find(".icon-open2").attr("style", "");
						tab.ContentObj.find(".icon-open3").attr("style", "display:none;");
						tab.ContentObj.find(".icon-open4").attr("style", "display:none;");
					}else if(state2 == "X"){
						tab.ContentObj.find(".icon-open1").attr("style", "display:none;");
						tab.ContentObj.find(".icon-open2").attr("style", "display:none;");
						tab.ContentObj.find(".icon-open3").attr("style", "");
						tab.ContentObj.find(".icon-open4").attr("style", "display:none;");
					}else if(state2 == "C"){
						tab.ContentObj.find(".icon-open1").attr("style", "display:none;");
						tab.ContentObj.find(".icon-open2").attr("style", "display:none;");
						tab.ContentObj.find(".icon-open3").attr("style", "display:none;");
						tab.ContentObj.find(".icon-open4").attr("style", "");
					}
				}
				if(key2 =="srvYn" && srvIndex > -1){ //사용여부 판단     
					if(state2 =="Y"){                                                 
						tab.ContentObj.find(".serviceYn").find("span").eq(srvIndex).removeClass("icon-no-service").addClass("icon-on");
					}else{
						tab.ContentObj.find(".serviceYn").find("span").eq(srvIndex).removeClass("icon-no-service").addClass("icon-service");            
					} 
				}
				if(key2 == "dsId"){
					if(state2 != null){
						tab.ContentObj.find("button[name=dsSearch]").hide();
					}
				}
				if(key2 == "srvCd"){
					if(state2 == null){
						tab.ContentObj.find("button[name=dsSearch]").show();
					}
				}
				if(tab.ContentObj.find("[name="+key2+"]").attr("type") == 'radio'){          
					tab.ContentObj.find("[name="+key2+"]"+":radio[value='"+state2+"']").prop("checked",true);                                                                          
				}else if(tab.ContentObj.find("[name="+key2+"]").attr("type") == 'checkbox'){          
					tab.ContentObj.find("[name="+key2+"]"+":checkbox[value='"+state2+"']").prop("checked",true); 
				}else{          
					tab.ContentObj.find("[name="+key2+"]").val(state2);
				}
			});
		});    
	}
	setTabButton();
}
function setTabButton(){		//버튼event
	var objTab = getTabShowObj();//탭이 oepn된 객체가져옴
 	var formObj = objTab.find("form[name=adminOpenInfTab]");
 	formObj.find("button[name=metaView]").click(function() {		// 메타상세
 		doSheetAction("metaView");          
 		return false;                 
 	});
 	
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
					<li><a href="#">공공데이터목록</a><a href="#" class="line_close">x</a></li>
				</ul>
			</div>
			
			<!-- 탭 내용 --> 
			<div class="content" style="display:none">
				<form name="adminOpenInfTab"  method="post" action="#">
				<input type="hidden" name="sheetNm"/>
				<%-- <table class="list01" style="position:relative;">
					<caption>공공데이터목록리스트</caption>
					<colgroup>
						<col width="150"/>
						<col width=""/>
						<col width="150"/>
						<col width=""/>
						<col width="150"/>
						<col width=""/>
					</colgroup>
					<tr>
						<th>서비스목록</th>
						<td colspan="5" class="serviceYn">
							<span class="icon-no-service">tsSheet</span> 
							<span class="icon-no-service">rawSheet</span> 
							<span class="icon-no-service">Chart</span>
							<span class="icon-no-service">Map</span>
							<span class="icon-no-service">Link</span>
							<span class="icon-no-service">File</span>
							<span class="icon-no-service">Open API</span>
							<span class="icon-open1" style="display:none;"><label class=""><spring:message code="labal.infStateY"/></span>					 <!-- 개방 -->
							<span class="icon-open2"  style="display:none;"><label class=""><spring:message code="labal.infStateN"/></label></span>		<!-- 미개방 -->
							<span class="icon-open3"  style="display:none;"><label class=""><spring:message code="labal.infStateX"/></label></span>		<!-- 개방불가 -->
							<span class="icon-open4"  style="display:none;"><label class=""><spring:message code="labal.infStateC"/></label></span>  	<!-- 개방취소 -->
						</td>
					</tr>
					
					<tr>
						<th><label class=""><spring:message code="labal.cateNm"/></label></th>
						<td><input type="text" name="cateNm" size="40" value="" class="readonly" readonly/></td>
						<th><label class=""><spring:message code="labal.dt"/></label></th>
						<td><input type="text"  name="dtNm" size="40" value="" class="readonly" readonly/></td>
						<th><label class=""><spring:message code="labal.dataSet"/></label></th>
						<td><input type="text" name="dsId" size="40" class="readonly" readonly/></td>
					</tr>
				</table> --%>
				<table class="list01" style="position:relative;">
					<caption>공공데이터목록리스트</caption>
					<colgroup>
						<col width="150"/>
						<col width=""/>
						<col width="150"/>
						<col width=""/>
						<col width="150"/>
						<col width=""/>
					</colgroup>
					<tr>
						<th><label class=""><spring:message code="labal.infId"/></label></th>
						<input type="hidden" name="seq"/>
						<input type="hidden" name="existinfId"/>
						<td colspan="6"><input type="text" name="infId" value="" size="40" class="readonly" readonly/></td>
						<td class="serviceYn">
							<!-- <span class="icon-no-service">tsSheet</span> 
							<span class="icon-no-service">rawSheet</span> 
							<span class="icon-no-service">Chart</span>
							<span class="icon-no-service">Map</span>
							<span class="icon-no-service">Link</span>
							<span class="icon-no-service">File</span>
							<span class="icon-no-service">Open API</span> -->
							<span class="icon-open1" style="display:none;"><label class=""><spring:message code="labal.infStateY"/></span>					 <!-- 개방 -->
							<span class="icon-open2"  style="display:none;"><label class=""><spring:message code="labal.infStateN"/></label></span>		<!-- 미개방 -->
							<span class="icon-open3"  style="display:none;"><label class=""><spring:message code="labal.infStateX"/></label></span>		<!-- 개방불가 -->
							<span class="icon-open4"  style="display:none;"><label class=""><spring:message code="labal.infStateC"/></label></span>  	<!-- 개방취소 -->
						</td>
					</tr>
					<tr>
						<th><label class=""><spring:message code="labal.infNm"/></label></th>
						<td colspan="7">
						<input type="text" name="infNm" value="" size="40"  class="readonly" readonly/>
						<button type="button" class="btn01" name="metaView">메타상세</button>
						</td>
						<!-- 메타정보 미리보기 버튼 구역 -->
						<%-- <th><label class=""><spring:message code="labal.metaInfo"/></label></th>
						<td colspan="2"><button type="button" class="btn01" name="metaView">메타상세</button></td> --%>
					</tr>
					<%-- <tr>
						<th><label class=""><spring:message code="labal.cateNm"/></label></th>
						<td><input type="text" name="cateNm" size="40" value="" class="readonly" readonly/></td>
						<th><label class=""><spring:message code="labal.dt"/></label></th>
						<td><input type="text"  name="dtNm" size="40" value="" class="readonly" readonly/></td>
						<th><label class=""><spring:message code="labal.dataSet"/></label></th>
						<td><input type="text" name="dsId" size="40" class="readonly" readonly/></td>
					</tr> --%>
				</table>
				
				
				
				<!-- ibsheet 영역 -->
				<div class="ibsheet_area" name="openHisListSheet">
					</div>
				</form>
			</div>
			
			<!-- 목록내용 -->
			<div class="content"  >
			<form name="adminOpenInfPrss"  method="post" action="#">
			<input type="hidden" name="prssGubun" value="AA" />
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
						<input type="text" name="orgNm" readonly/>
						${sessionScope.button.btn_search}
						<button type="button" class="btn01" name="btn_init">초기화</button>
					</td>
				</tr>
				<tr>
					<th><label class=""><spring:message code="labal.cateNm"/></label></th>
					<td>
						<input type="hidden" name="cateId" />
						<input type="text" name="cateNm" readonly/>
						${sessionScope.button.btn_search}
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
					<th><label class=""><spring:message code="labal.openDttm"/></label></th>
					<td>
						<input type="text" name="openDttmFrom" value="" readonly="readonly"/>
						<input type="text" name="openDttmTo" value="" readonly="readonly"/>       
					</td>
				</tr>
				<tr>
					<th><label class=""><spring:message code="labal.status"/></label></th>
					<td>
						<input type="radio"  name="infState" id="infStateA" value="" checked="checked"/>  
						<label for="infStateA"><spring:message code='labal.infStateA'/></label>
						<input type="radio"  name="infState" id="infStateN" value="N"/>       
						<label for="infStateN"><spring:message code='labal.infStateN'/></label>              
						<input type="radio"  name="infState" id="infStateY" value="Y"/>                        
						<label for="infStateY"><spring:message code='labal.infStateY'/></label>       
						<input type="radio"  name="infState" id="infStateC" value="C"/>          
						<label for="infStateC"><spring:message code='labal.infStateC'/></label>    
						${sessionScope.button.btn_inquiry}
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
</body>
</html>