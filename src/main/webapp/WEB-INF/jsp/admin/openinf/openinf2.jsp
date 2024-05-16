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
<title>Insert title here</title>                    
<c:import  url="/WEB-INF/jsp/inc/headinclude.jsp"/>
<!--
	validate 사용시 반드시 선언
	formName명과 validate 함수명이 연결되어있음
	adminOpenInf -> validateadminOpenInf 체크함
	resources/validator/*.* xml을 만들어서 사용
  -->
<validator:javascript formName="adminOpenInf" staticJavascript="false" xhtml="true" cdata="false"/> 
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
	doAction('search');                                                      
	$("input[name=usrId]").focus();
	inputEnterKey();       
	tabSet();// tab 셋팅                           
});                                                       
                                
function LoadPage()                
{      
	//message-common_ko_KR.properties 선언 후 사용 or message-common_en_US.properties 선언 후 사용
	var gridTitle = "NO"
		gridTitle +="|"+"<spring:message code='labal.infId'/>";  
		gridTitle +="|"+"<spring:message code='labal.infState'/>";        
		gridTitle +="|"+"<spring:message code='labal.prssState'/>";        
		gridTitle +="|"+"<spring:message code='labal.infNm'/>";        
	
    with(mySheet){
    	                     
    	var cfg = {SearchMode:3,Page:50};                                
        SetConfig(cfg);  
        var headers = [                                             
                    {Text:gridTitle, Align:"Center"}                 
                ];
        var headerInfo = {Sort:0,ColMove:1,ColResize:1,HeaderCheck:0};
        
        InitHeaders(headers, headerInfo); 
         
        var cols = [          
					 {Type:"Seq",		SaveName:"seq",				Width:30,	Align:"Center",		Edit:false}
					,{Type:"Text",		SaveName:"infId",			Width:100,	Align:"Center",		Edit:false, Hidden:true}
					,{Type:"Combo",		SaveName:"infState",			Width:100,	Align:"Center",		Edit:false}
					,{Type:"Combo",		SaveName:"prssState",		Width:100,	Align:"Center",		Edit:false}
					,{Type:"Text",		SaveName:"infNm",		Width:100,	Align:"Center",		Edit:false}
                                        
                ];       
                                      
        InitColumns(cols);                                                                           
        FitColWidth();                                                         
        SetExtendLastCol(1);   
        SetColProperty("infState", 	{ComboCode:"R|Y|N", 	ComboText:"개방예정|개발|개방취소"});    //InitColumns 이후에 셋팅       
        SetColProperty("prssState", 	{ComboCode:"AO|AC", 	ComboText:"요청|개방취소"});    //InitColumns 이후에 셋팅        
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
			mySheet.DoSearchPaging("<c:url value='/admin/openinf/openInfListAll.do'/>", param);   
			break;
			         
		case "reg":      //등록화면                 
			var title = "서비스등록"
			var id ="openInfReg";
		    openTab.addRegTab(id, title,tabCallRegBack); // 탭 추가 시작함
			break;
		    
		case "save":      //등록             
			if (!validateAdminOpenInf(actObj[1])){  //validation 체크         
				return;   
			} 
			var url = "<c:url value='/admin/openinf/openInfReg.do'/>"; 
			ajaxCallAdmin(url,actObj[0],saveCallBack);
			break;  
			
		case "update":      //변경        
			if (!validateAdminOpenInf(actObj[1])){
				return;
			}
			var url = "<c:url value='/admin/openinf/openInfUpd.do'/>";
			ajaxCallAdmin(url,actObj[0],updateCallBack);
			break; 
			
		case "delete":      //삭제
			 var url = "<c:url value='/admin/openinf/openInfDel.do'/>"; 
			 ajaxCallAdmin(url,actObj[0],deleteCallBack);
			 break;
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
                   
function mySheet_OnDblClick(row, col, value, cellx, celly) {
    if(row == 0) return;     
    tabEvent(row);                      
                               
}  

function tabEvent(row){//탭 이벤트 실행                
	var title = mySheet.GetCellValue(row,"infNm");//탭 제목   
	var id = mySheet.GetCellValue(row,"infId");//탭 id(유일해야함))     
    openTab.SetTabData(mySheet.GetRowJson(row));//db data 조회시 조건 data
    var url = "<c:url value='/admin/openinf/openInfList.do'/>"; // Controller 호출 url
    openTab.addTab(id,title,url,tabCallBack2); // 탭 추가 시작함
}


function LoadPage2(sheetName)                
{      
	//message-common_ko_KR.properties 선언 후 사용 or message-common_en_US.properties 선언 후 사용
	var gridTitle = "NO"
		gridTitle +="|"+"<spring:message code='labal.infId'/>";  
		gridTitle +="|"+"<spring:message code='labal.infState'/>";        
		gridTitle +="|"+"<spring:message code='labal.prssState'/>";        
		gridTitle +="|"+"<spring:message code='labal.infNm'/>";        
	
    with(sheetName){
    	                     
    	var cfg = {SearchMode:3,Page:50};                                        
        SetConfig(cfg);  
        var headers = [                                                                   
                    {Text:gridTitle, Align:"Center"}                          
                ];
        var headerInfo = {Sort:0,ColMove:1,ColResize:1,HeaderCheck:0};         
        
        InitHeaders(headers, headerInfo); 
                          
        var cols = [          
					 {Type:"Seq",		SaveName:"seq",				Width:30,	Align:"Center",		Edit:false}
					,{Type:"Text",		SaveName:"infId",			Width:100,	Align:"Center",		Edit:false, Hidden:true}
					,{Type:"Combo",		SaveName:"infState",			Width:100,	Align:"Center",		Edit:false}
					,{Type:"Combo",		SaveName:"prssState",		Width:100,	Align:"Center",		Edit:false}
					,{Type:"Text",		SaveName:"infNm",		Width:100,	Align:"Center",		Edit:false}
                                        
                ];       
                                      
        InitColumns(cols);                                                                           
        FitColWidth();                                                         
        SetExtendLastCol(1);   
        SetColProperty("infState", 	{ComboCode:"R|Y|N", 	ComboText:"개방예정|개발|개방취소"});    //InitColumns 이후에 셋팅       
        SetColProperty("prssState", 	{ComboCode:"AO|AC", 	ComboText:"요청|개방취소"});    //InitColumns 이후에 셋팅        
    }               
    default_sheet(sheetName);                                    
}                   

//상세 callback 함수                   
function tabCallBack2(test,json){ //callBack 함수                             
	openTab.ContentObj.find("a").eq(0).parent().remove();                                                   
	$.each(json.DATA,function(key,state){                                    
		openTab.ContentObj.find("[name="+key+"]").val(state);
	});          
	
	var sheet = "sheet"+sheetTabCnt++;
	$("div[name=mainSheet]").eq(1).attr("id","DIV_"+sheet);                    
	createIBSheet2(document.getElementById("DIV_"+sheet),sheet, "100%", "300px");               
	var sheetobj = window[sheet];                                               
	LoadPage2(sheetobj);                                               
	var param = {PageParam: "ibpage", Param: "onepagerow=<%=WiseOpenConfig.IBSHEETPAGENOW%>"};         
	sheetobj.DoSearchPaging("<c:url value='/admin/openinf/openInfListAll.do'/>", param);                   
	
	window[sheet + "_OnClick"] =  onClick;
}

           
function onClick(Row, Col, Value, CellX, CellY, CellW, CellH) {
	alert(Row+"=="+Col+"=="+Value);
}

                           
//]]> 
</script>              
</head>
<body onload="">
<div id="wrap">
	<!--##  메인  ##-->
	<div id="container_wrap">
		<div id="container">                    
			<c:import  url="/admin/admintop.do"/>
			<!--내용-->           
			<h3 class="dp_none">본문시작</h3>
      		<div id="contents">
      			<div class="tit"><div class="tit_txt">${MENU_URL}</div></div>
      			<div class="cont_wrap">                              
      					<ul id="tab" style="overflow: hidden;">
					    	<li style="float: left;"><a title="tabs-main">조회</a></li>
					 	</ul>
					<div class="box_in" name="tabs-Template" style="display:none">                
						<div>                
				            <div class="btn_wrap m_bottom1">              
	              				<ul class="m_bottom1">
	              					<li><a href="javascript:doAction('save')"> <img src="<c:url value='/images/main/btn_save.gif'/>" alt="<spring:message code='btn.save'/>" /></a></li>
	              					<li><a href="javascript:doAction('update')"><img src="<c:url value='/images/main/btn_modify.gif'/>" alt="<spring:message code='btn.modify'/>" /></a></li>
	              					<li><a href="javascript:doAction('delete')"><img src="<c:url value='/images/main/btn_del.gif'/>" alt="<spring:message code='btn.del'/>" /></a></li>
	              				</ul>        
	              			</div>                                                             
	              			<div>   
	              			<form name="adminOpenInf"  method="post" action="#">
	              				<input type="hidden" name="infId"/>
	              				<ul style='overflow: hidden;'>
					                 <li style='float: left;'>          
					                 	<label class=""><spring:message code="labal.infNm"/></label>
					                 	<input type="text" name="infNm" class="input" />
					                 </li>                     
					                 <li style='float: left;'>                                 
					                 	<label class=""><spring:message code="labal.infNmEng"/></label>
					                 	<input type="text" name="infNmEng" class="input" />
					                 </li>  
	              			</form>                               
	              			</div>                  
	              			<div name="mainSheet"></div>
  						</div> <!--##  box_left 끝 ##-->         
   						<div class="clear"></div>             
      				</div>                         
      				<div class="box_in" name="tabs-main">                           
						<div>                           
				            <div class="btn_wrap m_bottom1">
	              				<ul class="m_bottom1">
	              					<li><a href="javascript:doAction('reg')"><img src="<c:url value='/images/main/btn_reg.gif'/>" alt="<spring:message code='btn.reg'/>" /></a></li>
	              					<li><a href="javascript:doAction('search')"><img src="<c:url value='/images/main/btn_inquiry.gif'/>" alt="<spring:message code='btn.inquiry'/>" /></a></li>
	              				</ul>        
	              			</div>                                        
	              			<div>
	              			<form name="adminOpenInf"  method="post" action="#">
	              				<ul>      
					                 <li class="id"><label class=""><spring:message code="labal.infNm"/></label>
					                 <input name="infNm" class="input" />
					                 </li>                                   
					               </ul>                                  
	              			</form>
	              			</div>        
   				  			<div><script type="text/javascript">createIBSheet("mySheet", "100%", "300px"); </script></div>
  						</div> <!--##  box_left 끝 ##-->
   						<div class="clear"></div>
      				</div> <!--##  /box_in 끝 ##-->
      			</div> <!--##  /cont_wrap bg_line 끝 ##-->
      		</div> <!--##  /contents 끝 ##-->		
      		<!--/내용-->	
                      
      		<div class="clear"></div>                    
      </div> <!--##  /container 끝 ##-->	
      </div> <!--##  /container_wrap 끝 ##-->	
  	  <!--##  메인  끝 ##-->

	<!--##  푸터  ##-->
   footer.
	<!--##  /푸터  ##-->
</div>
</body>
</html>