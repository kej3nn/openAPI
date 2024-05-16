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
	adminOpenInf -> validateadminOpenInf 체크함
	resources/validator/*.* xml을 만들어서 사용
  -->
<%-- <validator:javascript formName="adminOpenInf" staticJavascript="false" xhtml="true" cdata="false"/> --%> 
</head>                                                 
<script language="javascript">              
//<![CDATA[
var sheetTabCnt = 0;   
function tabSet(){ //탭 객체 생성  
	openTab = new OpenTab(tabId,tabContentClass,tabBody); //headinclude.jsp 변수 있음
	openTab.TabObj = openTab;  
	openTab.addTabClickEvent();    
}	   
        
$(document).ready(function()    {    
	LoadPage();                                                               
	LoadPage2();
	doAction('search');  
	
	inputEnterKey();       
	//tabSet();// tab 셋팅
	init();
	setTabButton();		//탭 버튼
	
});    
var dtId = "";
function init(){
	var formObj = $("form[name=adminOpenInf]");
	/* formObj.find("input[name=openDttmTo]").datepicker(setCalendar());          
	formObj.find("input[name=openDttmFrom]").datepicker(setCalendar()); */      
	//datepickerTrigger();     
	formObj.find("button[name=btn_inquiry]").eq(0).click(function(e) { 
		doAction("search");
		 return false;        
	 }); 
	formObj.find("button[name=btn_search]").eq(1).click(function(e) { 
		doAction("poporgnm");
		return false;               
	 }); 
	formObj.find("button[name=btn_search]").eq(0).click(function(e) { 
		doAction("popcatenm");
		return false;                  
	 }); 
	formObj.find("button[name=btn_init]").eq(1).click(function(e) { 
		formObj.find("input[name=orgNm]").val("");
		formObj.find("input[name=orgCd]").val("");
		return false;               
	}); 
	formObj.find("button[name=btn_init]").eq(0).click(function(e) { 
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
		gridTitle +="|"+"<spring:message code='labal.cclCd'/>";        
		gridTitle +="|"+"<spring:message code='labal.cateNm'/>";        
		gridTitle +="|"+"<spring:message code='labal.orgNm'/>";        
		gridTitle +="|"+"<spring:message code='labal.usrNm'/>";        
		gridTitle +="|"+"<spring:message code='labal.openDttm'/>";        
		gridTitle +="|"+"<spring:message code='labal.infState'/>";
		gridTitle +="|"+"개방서비스";   
		/* gridTitle +="|"+"<spring:message code='labal.infTag'/>"; */       
	
    with(mySheet){
    	                     
    	var cfg = {SearchMode:2,Page:50};                                
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
                    {Type:"Seq",		SaveName:"seq",				Width:40,	Align:"Center",		Edit:false}
					,{Type:"Text",		SaveName:"infId",			Width:0,	Align:"Center",		Edit:false, Hidden:true}
					,{Type:"Text",		SaveName:"dtNm",			Width:240,	Align:"Left",		Edit:false}
					,{Type:"Text",		SaveName:"infNm",			Width:240,	Align:"Left",		Edit:false}
					,{Type:"Text",		SaveName:"cclNm",			Width:220,	Align:"Left",		Edit:false}
					,{Type:"Text",		SaveName:"cateNm",			Width:140,	Align:"Left",		Edit:false}
					,{Type:"Text",		SaveName:"orgNm",			Width:140,	Align:"Left",		Edit:false}
					,{Type:"Text",		SaveName:"usrNm",			Width:90,	Align:"Left",		Edit:false}
					,{Type:"Text",		SaveName:"openDttm",			Width:140,	Align:"Center",		Edit:false}
					,{Type:"Combo",		SaveName:"infState",			Width:90,	Align:"Center",		Edit:false}
					,{Type:"Html",				SaveName:"openSrv",		Width:70,	Align:"Left",			Edit:false}
                ];       
                                      
        InitColumns(cols);                                                                           
        SetExtendLastCol(1);   
        SetColProperty("infState", ${codeMap.infStatsIbs} );           
    }               
    default_sheet(mySheet);                      
}      

/**
 * 상세 조회시 IBS
 */
function LoadPage2(){
	var gridTitle = "NO"
		gridTitle +="|"+"<spring:message code='labal.infId'/>";
		gridTitle +="|"+"<spring:message code='labal.infNm'/>";  
		gridTitle +="|"+"<spring:message code='labal.dtNm'/>";        
		gridTitle +="|"+"<spring:message code='labal.cateNm'/>";        
		gridTitle +="|"+"<spring:message code='labal.dsId'/>";        
		gridTitle +="|"+"<spring:message code='labal.cateNm'/>";        
		gridTitle +="|"+"<spring:message code='labal.orgNm'/>";        
		gridTitle +="|"+"<spring:message code='labal.usrNm'/>";        
		gridTitle +="|"+"<spring:message code='labal.infTag'/>";
		gridTitle +="|"+"<spring:message code='labal.post'/>";
		gridTitle +="|"+"<spring:message code='labal.infState'/>";
		gridTitle +="|"+"<spring:message code='labal.regDttm'/>";
	
	with(sheetName){
      
  	var cfg = {SearchMode:2,Page:50,VScrollMode:1};                                
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
					,{Type:"Text",		SaveName:"infId",			Width:0,	Align:"Center",		Edit:false, Hidden:true}
					,{Type:"Text",		SaveName:"infNm",			Width:100,	Align:"Left",		Edit:false}
					,{Type:"Text",		SaveName:"dtNm",			Width:100,	Align:"Left",		Edit:false}
					,{Type:"Text",		SaveName:"cateNm",			Width:100,	Align:"Left",		Edit:false}
					,{Type:"Text",		SaveName:"dsId",			Width:100,	Align:"Center",		Edit:false}
					,{Type:"Text",		SaveName:"cclNm",			Width:100,	Align:"Left",		Edit:false, Hidden:true}
					,{Type:"Text",		SaveName:"orgNm",			Width:100,	Align:"Left",		Edit:false}
					,{Type:"Text",		SaveName:"usrNm",			Width:100,	Align:"Left",		Edit:false}
					,{Type:"Text",		SaveName:"infTag",			Width:100,	Align:"Left",		Edit:false}
					,{Type:"Text",		SaveName:"post",			Width:100,	Align:"Left",		Edit:false}
					,{Type:"Text",		SaveName:"infState",		Width:40,	Align:"Center",		Edit:false}
					,{Type:"Text",		SaveName:"regDttm",			Width:100,	Align:"Center",		Edit:false}
					
             ];           
                                    
      InitColumns(cols);                                                                           
      FitColWidth();                                                         
      SetExtendLastCol(0);
  	}
	
    default_sheet(sheetName);
}

/*Sheet 각종 처리*/                  
function doAction(sAction)                                  
{
	var classObj = $("."+"content").eq(1); //tab으로 인하여 form이 다건임
	var actObj = setTabForm(classObj); // 0: form data, 1: form 객체
	switch(sAction)
	{          
		case "search":      //조회   
			var formObj = $("form[name=adminOpenInf]");        
			/* fromObj = formObj.find("input[name=openDttmFrom]");                          
			toObj = formObj.find("input[name=openDttmTo]"); */
			//dateValCheck(fromObj,toObj)// from , to 날짜 안맞을 경우 자동셋팅   
			ajaxBeforeSendAdmin("<c:url value='/admin/ajaxBeforeSendAdmin.do'/>"); //IbSheet 조회전 세션 체크
			var param = {PageParam: "ibpage", Param: "onepagerow=50&"+actObj[0]};         
			mySheet.DoSearchPaging("<c:url value='/admin/openinf/openInfListAll.do'/>", param);   
			break;
		case "popclose":              
			closeIframePop("iframePopUp");
			break;
		case "poporgnm":	//조직 팝업
			var url="<c:url value="/admin/basicinf/popup/commOrg_pop.do"/>" +  "?index=0";
			var popup = OpenWindow(url,"orgPop","550","550","yes");
			popup.focus();
			break;
		case "popcatenm":	//분류 팝업
			var url="<c:url value="/admin/opendt/openCateParListPopUp.do"/>" + "?cateGb=2&index=0";
			var popup = OpenWindow(url,"orgPop","550","550","yes");
			popup.focus();
			break;
	}           
}   

function mySheet_OnDblClick(row, col, value, cellx, celly) {
    if(row == 0) return;     
    
    /* $("input[name=infId]").val(mySheet.GetCellValue(row,"infId"));
    $("input[name=infNm]").val(mySheet.GetCellValue(row,"infNm")); 
    
    doSheetAction('searchList'); */
    
    //tabEvent(row);    
    
    var url = "<c:url value='/admin/openinf/openInfList.do'/>"; // Controller 호출 url   
	var param = "infId= " + mySheet.GetCellValue(row,"infId");
   
	ajaxCallAdmin(url, param, tabInfCallBack);
	doSheetAction('searchList'); 
}
//탭 추가 이벤트
function tabEvent(row){   
	var title = mySheet.GetCellValue(row,"infNm");//탭 제목 
	var id = mySheet.GetCellValue(row,"seq");//탭 id(유일한key))
	openTab.SetTabData(mySheet.GetRowJson(row));//db data 조회시 조건 data
	var url = "<c:url value='/admin/openinf/openInfList.do'/>"; // Controller 호출 url  
	openTab.addTab(id,title,url,tabInfCallBack); // 탭 추가 시작함(callback함수 overring)          
	var cnt = sheetTabCnt++;
	SheetCreate(cnt); //시트
}
//탭 Sheet 생성
function SheetCreate(){       
 	var SheetNm = "mySheet2";         
 	$("div[name=openHisListSheet]").eq(1).attr("id","DIV_"+SheetNm);                                          
 	createIBSheet2(document.getElementById("DIV_"+SheetNm),SheetNm, "100%", "400px");               
 	var sheetobj = window[SheetNm]; 
 	var objTab = getTabShowObj();//탭이 oepn된 객체가져옴
 	var formObj = objTab.find("form[name=adminOpenInfTab]");
 	formObj.find("input[name=sheetNm]").val(SheetNm);
 	LoadPage2(sheetobj);
 	doSheetAction("searchList");
	//window[SheetNm + "_OnDblClick"] =  onDblClick;
}

//탭 액션
function doSheetAction(sAction)
{
	var classObj = $("."+"content").eq(1); //tab으로 인하여 form이 다건임
	var actObj = setTabForm(classObj); // 0: form data, 1: form 객체
	var sheetObj; //IbSheet 객체         
	
	var formObj = classObj.find("form[name=adminOpenInf]");
	sheetObj =formObj.find("input[name=sheetNm]").val();   
	ajaxBeforeSendAdmin("<c:url value='/admin/ajaxBeforeSendAdmin.do'/>"); //IbSheet 조회전 세션 체크
	var gridObj = window[sheetObj];
	var infId = formObj.find("[name=infId]").val();
	switch(sAction)                    
	{
		case "searchList" :	// 선택된 메티정보의 변경이력 List 출력
			var url = "<c:url value='/admin/openinf/openHisInfOneList.do'/>";
			var param = {PageParam: "ibpage", Param: "onepagerow=50&"+"infId="+infId};
			sheetName.DoSearchPaging(url, param); 
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

function tabInfCallBack(json){
	if(json.DATA != null){
		var classObj = $("."+"content").eq(1); //tab으로 인하여 form이 다건임
		var formObj = classObj.find("form[name=adminOpenInf]");
		
		$.each(json.DATA,function(key,state){ 
			var srvCd = state.srvCd;
			var srvIndex = typeIndex(srvCd);     
			$.each(state,function(key2,state2){
			//	formObj.find("a[name=a_reg]").remove();         
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
				if(key2 == "dsId"){
					if(state2 != null){
						formObj.find("button[name=dsSearch]").hide();
					}
				}
				if(key2 == "srvCd"){
					if(state2 == null){
						formObj.find("button[name=dsSearch]").show();
					}
				}
				if(formObj.find("[name="+key2+"]").attr("type") == 'radio'){          
					formObj.find("[name="+key2+"]"+":radio[value='"+state2+"']").prop("checked",true);                                                                          
				}else if(formObj.find("[name="+key2+"]").attr("type") == 'checkbox'){          
					formObj.find("[name="+key2+"]"+":checkbox[value='"+state2+"']").prop("checked",true); 
				}else{          
					formObj.find("[name="+key2+"]").val(state2);
				}
			});
		});    
	}
	setTabButton();
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

function setTabButton(){		//버튼event
	var classObj = $("."+"content").eq(1); //탭이 oepn된 객체가져옴
 	var formObj = classObj.find("form[name=adminOpenInf]");
 	formObj.find("button[name=metaView]").click(function() {		// 메타상세
 		doSheetAction("metaView");          
 		return false;                 
 	});
 	
}

function getDtId(){
	var objTab = getTabShowObj();//탭이 oepn된 객체가져옴
 	var formObj = objTab.find("form[name=adminOpenInf]");    
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

function inputEnterKey(){
	$("input").keypress(function(e) {
		  if(e.which == 13) {
			  doAction('search');   
			  return false;
		  }
	});
}           
          
//]]> 
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
			<form name="adminOpenInf"  method="post" action="#">
			<input type="hidden" name="ibSheetRow" value=""/>     
			<table class="list01">              
				<caption>데이터셋 관리</caption>
				<colgroup>
					<col width="150"/>
					<col width=""/>
				</colgroup>
				<tr>
					<th><label class=""><spring:message code="labal.cateNm"/></label></th>
					<td>
						<input type="hidden" name="cateId" value=""/>
						<input type="text" name="cateNm" readonly ="readonly"/>
						<button type="button" class="btn01" name="btn_search"><spring:message code="btn.search"/></button>
					
						<button type="button" class="btn01" name="btn_init">초기화</button>
					</td>
					<th><label class=""><spring:message code="labal.orgNm"/></label></th>
					<td>
						<input type="hidden" name="orgCd"/>
						<input type="text" name="orgNm" readonly ="readonly"/>
						<button type="button" class="btn01" name="btn_search"><spring:message code="btn.search"/></button>
						<button type="button" class="btn01" name="btn_init">초기화</button>
					</td>
				
				
					<th><label class=""><spring:message code="labal.infState"/></label></th>
					<td>
						<select name="infState">
                  			<option value="" selected="selected"><spring:message code="labal.infStateA"/></option>
                  			<option value="N" ><spring:message code="labal.infStateN"/></option>
                       		<option value="Y"><spring:message code="labal.infStateY"/></option>
                       		<option value="C"><spring:message code="labal.infStateC"/></option>
               			</select>
						
					</td>
					
					
					
					
				</tr>
				<tr>
					<th><spring:message code="labal.search"/></th>
					<td colspan="5">
						<select name="searchWd">
							<option value=""><spring:message code="labal.allSelect"/></option>
							<option value="0">공공데이터명</option>
		                 	<option value="1">보유데이터명</option>
							<option value="2">태그명</option>
						</select>
						<input name="searchWord" type="text" value="" style="width:240px"/>
						<button type="button" class="btn01B" name="btn_search"><spring:message code="btn.inquiry"/></button>
						
						
					</td>
				</tr>
			</table>	


				<!-- ibsheet 영역 -->
				<div style="clear: both;"></div>
				<div class="ibsheet_area_both">
					<script type="text/javascript">createIBSheet("mySheet", "100%", "300px"); </script>             
				</div>
				
				</form>
			</div>
			<!-- 탭 내용 --> 
			<div class="content" >
				<form name="adminOpenInf"  method="post" action="#">
				<input type="hidden" name="sheetNm"/>
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
						<td colspan="5">
						<input type="text" name="infNm" value="" size="40" class="readonly" readonly/>
						<button type="button" class="btn01" name="metaView">메타상세</button>
						</td>
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
						<script type="text/javascript">createIBSheet("sheetName", "100%", "300px"); </script>
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