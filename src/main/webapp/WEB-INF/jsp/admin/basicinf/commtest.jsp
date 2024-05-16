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
	adminCommUsr -> validateAdminCommUsr 체크함
	resources/validator/*.* xml을 만들어서 사용
  -->
<validator:javascript formName="adminCommUsr" staticJavascript="false" xhtml="true" cdata="false"/> 
</head>                                                 
<script language="javascript">              
//<![CDATA[                              
function tabSet(){ //탭 객체 생성  
	openTab = new OpenTab(tabId,tabContentClass,tabBody); //headinclude.jsp 변수 있음
	openTab.TabObj = openTab;  
	openTab.addTabClickEvent();            
}	   

function setButton(){
	$("a[name=a_up]").click(function(e) {
		alert("up입니다.");
		return false;
	});  
	$("a[name=a_down]").click(function(e) {
		alert("down입니다.");
		return false;
	});  
	$("a[name=a_modify]").click(function(e) {
		alert("수정입니다.");
		return false;
	});                     
	$("button[name=btn_reg]").click(function(e) {
		alert("등록입니다.");
		return false;
	});              
}
$(document).ready(function()    {                            
	LoadPage();                                                               
	doAction('search');                                              
	$("input[name=usrId]").focus();         
	inputEnterKey();       
	tabSet();// tab 셋팅
	setButton();     
});                                                       
            
function LoadPage()                
{      
	//message-common_ko_KR.properties 선언 후 사용 or message-common_en_US.properties 선언 후 사용
	var gridTitle = "NO"
		gridTitle +="|"+"<spring:message code='labal.usrId'/>";  
		gridTitle +="|"+"<spring:message code='labal.usrNm'/>";        
		gridTitle +="|"+"<spring:message code='labal.usrNmEng'/>";        
		gridTitle +="|"+"<spring:message code='labal.usrEmail'/>";        
		gridTitle +="|"+"<spring:message code='labal.usrTel'/>";        
		gridTitle +="|"+"<spring:message code='labal.orgNm'/>";        
		gridTitle +="|"+"<spring:message code='labal.accYn'/>";        
		gridTitle +="|"+"<spring:message code='labal.accCd'/>";        
	
    with(mySheet1){
    	                     
    	var cfg = {SearchMode:1,Page:50};                                
        SetConfig(cfg);  
        var headers = [                               
                    {Text:gridTitle, Align:"Center"}                 
                ];
        var headerInfo = {Sort:0,ColMove:1,ColResize:1,HeaderCheck:0};
        
        InitHeaders(headers, headerInfo); 
         
        var cols = [          
					 {Type:"Seq",		SaveName:"seq",				Width:30,	Align:"Center",		Edit:false}
					,{Type:"Text",		SaveName:"usrId",			Width:100,	Align:"Center",		Edit:false}
					,{Type:"Text",		SaveName:"usrNm",			Width:100,	Align:"Center",		Edit:false}
					,{Type:"Text",		SaveName:"usrNmEng",		Width:100,	Align:"Center",		Edit:false}
					,{Type:"Text",		SaveName:"usrEmail",		Width:100,	Align:"Center",		Edit:false}
					,{Type:"Text",		SaveName:"usrTel",			Width:100,	Align:"Center",		Edit:false}
					,{Type:"Combo",		SaveName:"orgCd",			Width:100,	Align:"Center",		Edit:false}
					,{Type:"Text",		SaveName:"accYn",			Width:100,	Align:"Center",		Edit:false}
					,{Type:"Combo",		SaveName:"accCd",			Width:100,	Align:"Center",		Edit:false}
                                        
                ];       
                                      
        InitColumns(cols);                                                                           
        FitColWidth();                                                         
        SetExtendLastCol(1);   
        //SetColProperty("accCd", 	${codeMap.accCdIbs});    //InitColumns 이후에 셋팅       
       // SetColProperty("orgCd", 	${codeMap.orgCdIbs});    //InitColumns 이후에 셋팅            
    }               
    default_sheet(mySheet1);                      
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
			mySheet1.DoSearchPaging("<c:url value='/admin/basicinf/commUsrListAll.do'/>", param);
			break;
			
		case "reg":      //등록화면                 
			var title = "담당자등록"
			var id ="usrReg";
		    openTab.addRegTab(id,title,tabCallRegBack); // 탭 추가 시작함
			break;
		    
		case "save":      //등록             
			if (!validateAdminCommUsr(actObj[1])){  //validation 체크         
				return;   
			} 
			var url = "<c:url value='/admin/basicinf/commUsrReg.do'/>"; 
			ajaxCallAdmin(url,actObj[0],saveCallBack);
			break;  
			
		case "update":      //변경        
			if (!validateAdminCommUsr(actObj[1])){
				return;
			}
			var url = "<c:url value='/admin/basicinf/commUsrUpd.do'/>";
			ajaxCallAdmin(url,actObj[0],updateCallBack);
			break; 
			
		case "delete":      //삭제
			 var url = "<c:url value='/admin/basicinf/commUsrDel.do'/>"; 
			 ajaxCallAdmin(url,actObj[0],deleteCallBack);
			 break;
			 
		case "orgPop": //조직명 팝업
			var popup = OpenWindow("<c:url value="/admin/basicinf/popup/commOrg_pop.do"/>","orgPop","800","600","yes");	                
			break;
	}           
}         



// 마우스 이벤트
function mySheet1_OnSearchEnd(code, msg)
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
                   
function mySheet1_OnDblClick(row, col, value, cellx, celly) {
    if(row == 0) return;     
    tabEvent(row);                      
                          
}  

function tabEvent(row){//탭 이벤트 실행     
	var title = mySheet1.GetCellValue(row,"usrNm");//탭 제목                                                    
	var id = mySheet1.GetCellValue(row,"seq");//탭 id(유일한key))
    openTab.SetTabData(mySheet1.GetRowJson(row));//db data 조회시 조건 data
    var url = "<c:url value='/admin/basicinf/commUsrList.do'/>"; // Controller 호출 url              
    openTab.addTab(id,title,url,tabCallBack); // 탭 추가 시작함              
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
			<!-- 탭 내용 --> 
			
			<div class="content" style="display:none">
					<form name="adminCommUsr"  method="post" action="#">
	              				<ul style='overflow: hidden;'>                            
					                 <li style='float: left;'>
					                 	<label class=""><spring:message code="labal.usrNm"/></label>
					                 	<input type="text" name="usrNm" class="input" />
					                 </li>     
					               </ul>                  
	              			</form>                                                                
			</div>
			
			<div class="content"  >            
				<table class="list01">              
					<caption>보유데이터목록리스트</caption>
					<colgroup>
						<col width="150"/>
						<col width=""/>
					</colgroup>
					<tr>
						<th>검색어</th>
						<td>
							<select>
								<option selected>선택</option>
							</select>
							<input type="text" value=""/>
							<button type="button" class="btn01">조회</button>
							${sessionScope.button.btn_reg}                     
						</td>
					</tr>
					<tr>
						<th>사용여부</th>
						<td>
							<input type="radio" value="" id="useAll" checked/>
							<label for="useAll">전체</label>
							<input type="radio" value="" id="use"/>
							<label for="use">사용</label>
							<input type="radio" value="" id="unuse"/>
							<label for="unuse">미사용</label>
						</td>
					</tr>
				</table>	
				
				<!-- ibsheet 영역 -->
				<div style="clear: both;"></div>
				<div class="ibsheet_area_both">
					<script type="text/javascript">createIBSheet("mySheet1", "100%", "300px"); </script>             
				</div>
									             
				<div class="buttons">
					${sessionScope.button.a_up}       
					${sessionScope.button.a_down}                     
					${sessionScope.button.a_modify}                             
				</div>
				
			</div>
			
		</div>		
	                    
	</div>                          

	<!--##  푸터  ##-->                
	<c:import  url="/WEB-INF/jsp/admin/adminfooter.jsp"/>
	<!--##  /푸터  ##-->            
</body>
</html>