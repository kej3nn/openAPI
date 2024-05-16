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
function tabSet(){ //탭 객체 생성  
	openTab = new OpenTab(tabId,tabContentClass,tabBody); //headinclude.jsp 변수 있음
	openTab.TabObj = openTab;  
	openTab.addTabClickEvent();    
}	   
        
$(document).ready(function()    {    
	LoadPage();                                                               
	doAction('search');                                              
	inputEnterKey();       
	//tabSet();// tab 셋팅
	init();
	setTabButton();		//탭 버튼
	
});    
var dtId = "";
function init(){
	var formObj = $("form[name=adminOpenInf]");
	    
	formObj.find("button[name=btn_search]").eq(2).click(function(e) { 
		doAction("search");
		 return false;        
	 }); 
	formObj.find("button[name=btn_search]").eq(1).click(function(e) { 	//목록 검색시 조직검색버튼
		doAction("poporgnm");
		return false;               
	 }); 
	formObj.find("button[name=btn_search]").eq(0).click(function(e) { 	//목록 검색시 분류검색버튼
		doAction("popcatenm");
		return false;                  
	 }); 
	formObj.find("button[name=btn_search]").eq(3).click(function(e) { 	// 담당자 일괄 변경시 조직검색버튼
		doAction("poporgnm2");
		return false;               
	 });    
	formObj.find("button[name=btn_search]").eq(4).click(function(e) { 	// 담당자 일괄 변경시 직원검색버튼
		if($("input[name=orgCdMod]").val()==''){
			alert("조직을 먼저 선택해주세요");
			return;
		}
		doAction("popusrnm");
		return false;                  
	 });
	formObj.find("button[name=btn_init]").eq(1).click(function(e) { // 조직 검색명 초기화
		formObj.find("input[name=orgCd]").val("");
		formObj.find("input[name=orgNm]").val("");
		return false;
	 });
	formObj.find("button[name=btn_init]").eq(0).click(function(e) { // 분류 검색명 초기화
		formObj.find("input[name=cateId]").val("");
		formObj.find("input[name=cateNm]").val("");
		return false;
	 });
	
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
		gridTitle +="|"+"";
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
	
    with(mySheet){
    	                     
    	var cfg = {SearchMode:3,Page:50};                                
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
					 {Type:"Seq",				SaveName:"seq",				Width:40,	Align:"Center",		Edit:false}
					,{Type:"CheckBox",		SaveName:"seq",				Width:40,	Align:"Center"					}
					,{Type:"Text",				SaveName:"infId",			Width:0,		Align:"Center",		Edit:false, Hidden:true}
					,{Type:"Text",				SaveName:"dtNm",			Width:240,	Align:"Left",			Edit:false}
					,{Type:"Text",				SaveName:"infNm",			Width:240,	Align:"Left",			Edit:false}
					,{Type:"Text",				SaveName:"cclNm",			Width:220,	Align:"Left",			Edit:false}
					,{Type:"Text",				SaveName:"cateNm",		Width:120,	Align:"Left",			Edit:false}
					,{Type:"Text",				SaveName:"orgNm",			Width:140,	Align:"Left",			Edit:false}
					,{Type:"Text",				SaveName:"usrNm",			Width:100,	Align:"Left",			Edit:false} 
					,{Type:"Text",				SaveName:"openDttm",		Width:140,	Align:"Center",		Edit:false}
					,{Type:"Combo",			SaveName:"infState",		Width:90,	Align:"Center",		Edit:false}
					,{Type:"Html",				SaveName:"openSrv",		Width:70,	Align:"Left",			Edit:false}
                ];       
                                      
        InitColumns(cols);                                                                           
        SetExtendLastCol(1);   
        SetColProperty("infState", ${codeMap.infStatsIbs} );           
    }               
    default_sheet(mySheet);                      
}      

/*Sheet 각종 처리*/                  
function doAction(sAction)                                  
{
	var classObj = $("."+"content").eq(0); //tab으로 인하여 form이 다건임
	var actObj = setTabForm(classObj); // 0: form data, 1: form 객체
	switch(sAction)
	{          
		case "search":      //조회   
			//var formObj = classObj.find("form[name=adminOpenInf]");        
			   
			ajaxBeforeSendAdmin("<c:url value='/admin/ajaxBeforeSendAdmin.do'/>"); //IbSheet 조회전 세션 체크
			//var param = {PageParam: "ibpage", Param: "onepagerow=50&"+actObj[0]};
			var param = {PageParam: "ibpage", Param: "onepagerow=50"+"&"+$("form[name=adminOpenInf]").serialize()}; 
			mySheet.DoSearchPaging("<c:url value='/admin/openinf/openInfListAll.do'/>", param);   
			break;
		case "popclose":              
			closeIframePop("iframePopUp");
			break;
		case "poporgnm":
			var url="<c:url value="/admin/basicinf/popup/commOrg_pop.do"/>";
			var popup = OpenWindow(url,"orgPop","550","550","yes");
			popup.focus();
			break;
		case "popcatenm":
			var url="<c:url value="/admin/opendt/openCateParListPopUp.do"/>" + "?cateGb=2";
			var popup = OpenWindow(url,"orgPop","550","550","yes");
			popup.focus();
			break;
		case "poporgnm2":
			var url="<c:url value="/admin/basicinf/popup/commOrg_pop.do"/>" + "?orgNmGb=3";
			var popup = OpenWindow(url,"orgPop","550","550","yes");
			
			popup.focus();
			break;
		case "popusrnm":
			var url="<c:url value="/admin/basicinf/popup/commUsr_pop.do"/>" + "?usrGb=2&orgCd="+$("input[name=orgCdMod]").val();
			//뒤에 orgCdMod를 붙이는 이유는 변경하고자 하는 담당조직내에 있는 직원만 검색하기 위해 orgCd를 GET방식으로 보내는 것임
			var popup = OpenWindow(url,"orgPop","550","550","yes");
			
			popup.focus();
			break;
	}           
}   

function doTabAction(sAction){
	var classObj = $("."+tabContentClass); //tab으로 인하여 form이 다건임
	var actObj = setTabForm(classObj); // 0: form data, 1: form 객체
	var objTab = getTabShowObj();//탭이 oepn된 객체가져옴
	var formObj = objTab.find("form[name=adminOpenInf]");
	ajaxBeforeSendAdmin("<c:url value='/admin/ajaxBeforeSendAdmin.do'/>"); //IbSheet 조회전 세션 체크
	switch(sAction){
		
		case "modifyAll":      //일괄변경
			if ( !confirm("일괄변경 하시겠습니까? ") ) {
				return;
  			}
			if(nullCheckValdation(formObj.find('input[name=orgNmMod]'),"<spring:message code='labal.orgCdNm'/>","")){
				return true;
			}
			if(nullCheckValdation(formObj.find('input[name=usrNmMod]'),"<spring:message code='labal.usrNm'/>","")){
				return true;
			}
			ibsSaveJson = mySheet.GetSaveJson(0,1);	// 체크된것만 Json으로 담기
			if(ibsSaveJson.data.length == 0) {
				alert("변경할 데이터가 없습니다.");  
				return;
			}
			var msg = "선택된 공공데이터의 담당조직 및 담당자 정보를 변경하시겠습니까?"+
					"\n"+"담당조직 : "+formObj.find("input[name=orgNmMod]").val()+
					"\n"+"담당자 : "+formObj.find("input[name=usrNmMod]").val()+
					"\n"+"일괄 변경 예정 건수 : "+ibsSaveJson.data.length+"건";
			if(!confirm(msg)){
				return true;
			}
			var formObj = $("form[name=adminOpenInf]");
			var formParam = "orgCdMod="+formObj.find("input[name=orgCdMod]").val()+"&"+"usrCdMod="+formObj.find("input[name=usrCdMod]").val();
			var url = "<c:url value='/admin/openinf/openInfModifyAll.do'/>";
			IBSpostJson(url, formParam, ibscallback);
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

function setTabButton(){		//버튼event
	var objTab = getTabShowObj();//탭이 oepn된 객체가져옴
 	var formObj = objTab.find("form[name=adminOpenInf]");       
	    
	
 	
 	formObj.find("button[name=orgSearch]").click(function(){		// 담당 조직 팝업
 		var url="<c:url value="/admin/basicinf/popup/commOrg_pop.do"/>" + "?orgNmGb=3"
		var popup = OpenWindow(url,"orgPop","500","550","yes");	            
 	});
 	
 	formObj.find("button[name=usrSearch]").click(function(){		// 직원명 검색 팝업
 		var url="<c:url value="/admin/basicinf/popup/commUsr_pop.do"/>" + "?usrGb=1"
		var popup = OpenWindow(url,"orgPop","500","550","yes");	            
 	});
 	
 	formObj.find("a[name=modifyAll]").click(function(){		// 일괄변경
// 		doTabAction("btn_modAll");          
 		doTabAction("modifyAll");      //이상함 수정함    btn_modAll - >   modifyAll
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
function OnSaveEnd(){
	doAction("search");                 
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
			
			<!-- 탭 내용 --> 
			<div class="content" style="display:none">
						</div> 
			
			
			<!-- 목록내용 -->
			<div class="content"  >
			<form name="adminOpenInf"  method="post" action="#">
			<table class="list01">              
				<caption>데이터셋 관리</caption>
				<colgroup>
					<col width="10%"/>  
					<col width="30%"/>
					<col width="10%"/>  
					<col width="30%"/>
					<col width="10%"/>  
					<col width="10%"/>
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
				
				<!-- 일괄변경 영역 -->
				<div>
				<table class="list01" style="position:relative;">   
				<tr>
						<th><label class=""><spring:message code="labal.orgCdNm"/></label></th>
						<td colspan="6">
							<input type="hidden" name="orgCdMod"/>
							<input type="text" name="orgNmMod"  readonly/>
							${sessionScope.button.btn_search}
							<input type="text" name="orgFullNm" placeholder="조직명" size="35" readonly/>
						</td>
						</tr>
						<tr>
						<th><label class=""><spring:message code="labal.usrNm"/></label></th>
						<td colspan="2">
							<input type="hidden" name="usrCdMod" />
							<input type="text" name="usrNmMod" value="" readonly/>
							${sessionScope.button.btn_search}
						</td>
					</tr>
					<tr>
					<td colspan="7" align="right" style="border-bottom:none;">
					<br>
					<a href="#" class="btn03" title="일괄변경" name="modifyAll" >일괄변경</a>
<%-- 					${sessionScope.button.btn_modAll} --%>
					<!-- <button type="button" class="btn01" name="modifyAll">일괄변경</button> -->
					</td>
					</tr>
				</table>
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