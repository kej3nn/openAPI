<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="egovframework.common.WiseOpenConfig"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<!--
  직원정보 조회 jsp
  @author KJH
  @since 2014.07.23
 -->
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
	setMainButton(); 		//메인 버튼
	LoadPage();		        //조직 IBS                                                        
	LoadPage2();			//직원 IBS                                                    
	doAction('searchOrg');	//조직 검색
	doAction('searchUsr');	//직원 검색
	inputEnterKeyByOrg();	//조직 엔터키
	inputEnterKeyByUsr();	//직원 엔터키
});

/****************************************************************************************************
 * Main 관련
 ****************************************************************************************************/
// Setting
 function setMainButton(){
	$("button[name=btn_orgSearch]").click(function(e) {	doAction("searchOrg");	return false;	});
	$("button[name=btn_usrSearch]").click(function(e) {	doAction("searchUsr");	return false;	});
}

function LoadPage()                
{      
	//message-common_ko_KR.properties 선언 후 사용 or message-common_en_US.properties 선언 후 사용
	//var gridTitle = "조직코드|조직명|조직영문명|전체조직명|최상위조직코드|상위조직코드|레벨";    
	var gridTitle = ""
		gridTitle +="|"+"<spring:message code='labal.orgCd'/>";  
		gridTitle +="|"+"<spring:message code='labal.orgNm'/>";  
		gridTitle +="|"+"<spring:message code='labal.orgNmEng'/>";        
		gridTitle +="|"+"<spring:message code='labal.orgFullNm'/>";        
		gridTitle +="|"+"<spring:message code='labal.orgParTop'/>";        
		gridTitle +="|"+"<spring:message code='labal.orgParGrp'/>";        
		gridTitle +="|"+"<spring:message code='labal.orglvl'/>";        
	
    with(mySheet1) {
    	                     
    	var cfg = {SearchMode:2,Page:50,sizeMode:2};                                
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
					 {Type:"Text",		SaveName:"orgCd",			Width:0,	Align:"Center",		Edit:false, Hidden:true}
					,{Type:"Text",		SaveName:"orgNm",			Width:80,	Align:"Left",		Edit:false, TreeCol:1}
					,{Type:"Text",		SaveName:"orgNmEng",		Width:0,	Align:"Center",		Edit:false, Hidden:true}
					,{Type:"Text",		SaveName:"orgFullNm",		Width:0,	Align:"Center",		Edit:false, Hidden:true}
					,{Type:"Text",		SaveName:"orgCdTop",		Width:0,	Align:"Center",		Edit:false, Hidden:true}
					,{Type:"Text",		SaveName:"orgCdPar",		Width:0,	Align:"Center",		Edit:false, Hidden:true}
					,{Type:"Text",		SaveName:"orgLvl",			Width:0,	Align:"Center",		Edit:false,Hidden:true}
                ];                           

        InitColumns(cols);                                                                           
        FitColWidth();
        SetExtendLastCol(1);
        
    }               
    default_sheet(mySheet1);               
}    

function LoadPage2()                
{      
  //message-common_ko_KR.properties 선언 후 사용 or message-common_en_US.properties 선언 후 사용
	//var gridTitle = "NO|부서코드|부서|직원코드|직원명|영문직원명";
	var gridTitle = "NO"
		gridTitle +="|"+"<spring:message code='labal.orgCd'/>";  
		gridTitle +="|"+"<spring:message code='labal.orgNm'/>";  
		gridTitle +="|"+"<spring:message code='labal.usrCd'/>";  
		gridTitle +="|"+"<spring:message code='labal.orgNm'/>";
		gridTitle +="|"+"<spring:message code='labal.orgNmEng'/>";
	
    with(mySheet2){
    	                     
    	var cfg = {SearchMode:2,Page:50,sizeMode:2};                                
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
					 {Type:"Seq",		SaveName:"seq",				Width:10,	Align:"Center",		Edit:false}
					,{Type:"Text",		SaveName:"orgCd",			Width:0,	Align:"Center",		Edit:false, Hidden:true}
					,{Type:"Text",		SaveName:"orgNm",			Width:40,	Align:"Center",		Edit:false, Hidden:false}
					,{Type:"Text",		SaveName:"usrCd",			Width:0,	Align:"Center",		Edit:false, Hidden:true}
					,{Type:"Text",		SaveName:"usrNm",			Width:80,	Align:"Left",		Edit:false}
					,{Type:"Text",		SaveName:"usrNmEng",		Width:0,	Align:"Center",		Edit:false, Hidden:true}
                ];                         

        InitColumns(cols);                                                                           
        FitColWidth();
        SetExtendLastCol(1);
        
    }               
    default_sheet(mySheet2);   
}

            
function doAction(sAction)                                  
{
	var classObj = $(".content"); //tab으로 인하여 form이 다건임
	var actObj = setTabForm(classObj); // 0: form data, 1: form 객체
	
	switch(sAction)           
	{          
		case "searchOrg":      //조회
			var formParam = $("form[name=adminCommOrgSearch]").serialize();
			ajaxBeforeSendAdmin("<c:url value='/admin/ajaxBeforeSendAdmin.do'/>"); //IbSheet 조회전 세션 체크
			mySheet1.DoSearch("<c:url value='/admin/basicinf/commOrgSearcList.do'/>", formParam);
			break;
		
		case "searchUsr" :
			var formParam = $("form[name=adminCommUsrSearch]").serialize();     
			ajaxBeforeSendAdmin("<c:url value='/admin/ajaxBeforeSendAdmin.do'/>"); //IbSheet 조회전 세션 체크
			mySheet2.DoSearch("<c:url value='/admin/basicinf/commUsrSearchList.do'/>", formParam);
		
	}           
} 

function mySheet1_OnClick(Row, Col, Value, CellX, CellY, CellW, CellH) {
	$("input[name=orgCd]").val(mySheet1.GetCellValue(Row, "orgCd"));
	doAction("searchUsr");
}

function mySheet1_OnSearchEnd(code, msg)
{
	if(msg != "")
	{
	    alert(msg);
    }
}


//엔터키 동작 
function inputEnterKeyByOrg(){
	$("input[name=orgSearchWd]").keypress(function(e) {
		  if(e.which == 13) {
			  doAction('searchOrg');   
			  return false;
		  }
	});
}
function inputEnterKeyByUsr(){
	$("input[name=usrSearchWd]").keypress(function(e) {
		  if(e.which == 13) {
			  doAction('searchUsr');   
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
		<!-- 내용 -->
		<div class="container">
			<!-- 상단 타이틀 -->   
			<div class="title">
				<h2>${MENU_NM}</h2>                                      
				<p>${MENU_URL}</p>             
			</div>
			
			<!-- 목록내용 -->
			<div class="content"  >
				<form name="adminCommOrgSearch"  method="post" action="#">
					<div name="orgDiv" style="float:left;width:50%;">
					<!-- 탭 -->
					<ul class="tab" style="margin:0 7px 0 0;">
						<li class="one-tab">조직정보</li>
					</ul>
					
					<!-- 탭 내용 -->
					<div class="content" style="margin:0 7px 0 0;">
						<input type="text" name="orgSearchWd" value="" placeholder="조직명을 입력하세요" style="width:250px;"/>
						<button type="button" class="btn01" name="btn_orgSearch">조회</button>
						<div style="clear: both;"></div>
						<div class="ibsheet_area_both">
							<script type="text/javascript">createIBSheet("mySheet1", "100%", "300px"); </script> 
						</div>
					</div>
					</div>
				</form>
				<form name="adminCommUsrSearch"  method="post" action="#">
					<input type="hidden" name="orgCd" value=""/>
					<div name="usrDiv" style="float:right;width:50%;">
					<!-- 탭 -->
					<ul class="tab" style="margin:0 0 0 7px;">
						<li class="one-tab">직원정보</li>
					</ul>
					
					<!-- 탭 내용 -->
					<div class="content" style="margin:0 0 0 7px;">
						<p class="text-title">조직 : 조직명 Full 정보</p>
						<input type="text" name="usrSearchWd" value="" placeholder="직원명을 입력하세요" style="width:250px;"/>
						<button type="button" class="btn01" name="btn_usrSearch">조회</button>
						<div style="clear: both;"></div>
						<div class="ibsheet_area_both">
							<script type="text/javascript">createIBSheet("mySheet2", "100%", "300px"); </script> 
						</div>
					</div>
					</div>
				</form>
			</div>                  
			                        
		</div>		
	                              
	</div>      
	<iframe name="iframePopUp" scrolling="no" frameborder="0" style="display: none;position: absolute;" src="" />			                                           
	<!--##  푸터  ##-->                
	<c:import  url="/WEB-INF/jsp/admin/adminfooter.jsp"/>
	<!--##  /푸터  ##-->            
</body>
</html>