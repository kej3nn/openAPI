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
<title><spring:message code='wiseopen.title'/></title>
<c:import  url="/WEB-INF/jsp/inc/headinclude.jsp"/>
<!--
	validate 사용시 반드시 선언
	formName명과 validate 함수명이 연결되어있음
	adminCommOrg -> validateAdminCommOrg 체크함
	resources/validator/*.* xml을 만들어서 사용
  -->
<validator:javascript formName="adminCommOrg" staticJavascript="false" xhtml="true" cdata="false"/>
</head>                                                 
<script language="javascript">              
//<![CDATA[                              
function tabSet(){ //탭 객체 생성  
	openTab = new OpenTab(tabId,tabContentClass,tabBody); //headinclude.jsp 변수 있음
	openTab.TabObj = openTab;  
	openTab.addTabClickEvent();            
}	

$(document).ready(function()    {
	LoadPage();	     	//메인 sheet
	setMainButton(); 	//메인 버튼
//	setTabButton();		//탭 버튼
	inputEnterKey();	//엔터키
	doAction("search");
});                                                       


/****************************************************************************************************
 * Main 관련
 ****************************************************************************************************/
// Setting
 function setMainButton(){
	var formObj = $("form[name=adminSurvey]");
	/* $("button[name=btn_reg]").click(function(e) {	doAction("reg");	return false;	}); */
	
	$("button[name=btn_searchWd]").click(function(e) {
		if ( $("select[name=searchWd]").val() != "") {
			if ( $("input[name=searchWord]").val() == "" ) {
				alert("검색어를 입력하세요.");
				return false;	
			}
		}
		doAction("search");
		
	});
}

function LoadPage()                
{      
	//message-common_ko_KR.properties 선언 후 사용 or message-common_en_US.properties 선언 후 사용
	var gridTitle = "NO"
		gridTitle +="|"+"<spring:message code='labal.surveyId'/>";  
		gridTitle +="|"+"<spring:message code='labal.surveyNm'/>";  
		gridTitle +="|"+"<spring:message code='labal.langTag'/>";        
		gridTitle +="|"+"<spring:message code='labal.ipDupYn'/>";        
		gridTitle +="|"+"<spring:message code='labal.startDttm'/>";        
		gridTitle +="|"+"<spring:message code='labal.endDttm'/>";        
		gridTitle +="|"+"<spring:message code='labal.status'/>";
	
    with(mySheet1){
    	                     
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
					 {Type:"Seq",		SaveName:"seq",			Width:20,	Align:"Center",		Edit:false}
					,{Type:"Text",	 	SaveName:"surveyId",	Width:70,	Align:"Center",		Edif:false}
					,{Type:"Text",		SaveName:"surveyNm",	Width:280,	Align:"Left",		Edit:false}
					,{Type:"Text",		SaveName:"langTag",		Width:40,	Align:"Center",		Edit:false}
					,{Type:"Text",		SaveName:"ipDupYn",		Width:40,	Align:"Center",		Edit:false}
			 		,{Type:"Text",		SaveName:"startDttm",	Width:70,	Align:"Center",		Edit:false}
					,{Type:"Text",		SaveName:"endDttm",		Width:70,	Align:"Center",		Edit:false} 
					,{Type:"Text",		SaveName:"endYn",		Width:70,	Align:"Center",		Edit:false}
                ];       
                                      
        InitColumns(cols);                                                                           
        FitColWidth();                                                         
        SetExtendLastCol(1);   
    }
    default_sheet(mySheet1);   
    mySheet1.SetCountPosition(0);     
}    
//sheet 더블클릭
function mySheet1_OnDblClick(row, col, value, cellx, celly) {
   if(row == 0) return;     
	var url ="";
	var wWidth="1024";
	var wHeight="768";

	var data = "?surveyNm="+mySheet1.GetCellValue(row,"surveyNm");//탭 제목
	data += "&surveyId="+mySheet1.GetCellValue(row,"surveyId");//탭 id(유일한key))
		
	var target = "<c:url value='/admin/bbs/surveyAnsListPopup.do"+data+"'/>";
	var wName = "surveyview";
	var wScroll ="yes";
	OpenWindow(target, wName, wWidth, wHeight, wScroll); 
    
}				
//Main Action                  
function doAction(sAction)                                  
{
	var classObj = $("."+tabContentClass); //tab으로 인하여 form이 다건임
	var actObj = setTabForm(classObj); // 0: form data, 1: form 객체
	switch(sAction)
	{          
		case "search":      //조회   
			ajaxBeforeSendAdmin("<c:url value='/admin/ajaxBeforeSendAdmin.do'/>"); //IbSheet 조회전 세션 체크
			mySheet1.DoSearch("<c:url value='/admin/bbs/surveyAnsListAll.do'/>", actObj[0]);
			break;
	}           
} 

/* 엔터조회*/
function inputEnterKey(){
	$("input").keypress(function(e) {
		  if(e.which == 13) {
			  doAction('search');   
			  return false;
		  }
	});
}

   
/****************************************************************************************************
 * Tab 관련
 ****************************************************************************************************/

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
					<li><a href="#">설문결과목록</a><a href="#" class="line_close">x</a></li>
				</ul>
			</div>
			
			
			         
			<%-- 
			<!-- 탭 내용 -->
			<div class="content" style="display:none">
				<form name="adminCommOrg"  method="post" action="#">
				<input type="hidden" name="orgCdDup" value="N"/>
				<input type="hidden" name="orgLvl" value=""/>
			<div class="buttons">
				${sessionScope.button.a_reg}
				${sessionScope.button.a_save}				
			</div>
				<table class="list01" id="commOrgTB">
				
					<caption>설문관리</caption>
					<colgroup>
						<col width="200"/>
						<col width=""/>
						<col width="200"/>
						<col width=""/>
					</colgroup>
					<tr>
						<!-- 조직코드 -->
						<th><spring:message code="labal.orgCd"/> <span>*</span></th>
						<td colspan="3">
							<input type="text" name="orgCd" value="" maxlength="25" style="width: 200px;"/>
							${sessionScope.button.btn_dup}
							<span>공백없이 영문자와 숫자로만 입력하세요. (20자이내)</span>
						</td>
						
					</tr>
					<tr>
						<!-- 조직명 -->
						<th><spring:message code="labal.orgNm"/> <span>*</span></th>
						<td colspan="3">
							<input type="text" name="orgNm" value="" maxlength="100" style="width: 200px;"/>
							<input type="text" name="orgNmEng" value="" maxlength="100" style="width: 200px;"/>
						</td>
					</tr>
					<tr>
						<!-- 상위조직 -->
						<th><spring:message code='labal.orgParGrp'/> <span>*</span></th>
						<td colspan="3">
							<input type="checkbox" name="orgCdPar"/>
							<span>기관 여부(최고 상위 기관은 상위조직이 없습니다)</span>&nbsp;&nbsp;&nbsp;
							<input type="hidden" name="orgCdTopCd" value=""/>
							<input type="hidden" name="orgCdTopNm" value=""/>
							<input type="hidden" name="orgCdParCd" value=""/>
							<input type="text" name="orgCdParNm" class="readonly" value="" style="width: 150px;" disabled="true"/>
							<button type="button" class="btn01" name="btn_orgSearch">
								<spring:message code="btn.search"/>
							</button>
						</td>
					</tr>
					<tr>
						<!-- 전체조직명 -->
						<th><spring:message code='labal.orgFullnm' /></th>
						<td colspan="3">
							<input type="text" name="orgFullNm" value=""  style="width: 500px;"/>&nbsp;
							<input type="text" name="orgFullNmEng" value=""  style="width: 500px;"/>
						</td>
					</tr>
					
					<tr id="orgTypeTR" style="display: none;">
						<!-- 조직구분 -->
						<th><spring:message code="labal.orgTypeNm"/> <span>*</span></th>
						<td>
							<select class="" name="orgType" style="width: 100px;">
								<option value="">선택</option>
								<c:forEach var="code" items="${codeMap.typeCd}" varStatus="status">
									<option value="${code.ditcCd}">${code.ditcNm}</option>
								</c:forEach>
							</select>
						</td>
						<!-- 조직홈페이지 -->
						<th><spring:message code="labal.orgUrl"/></th>
						<td>
							<input type="text" name="orgUrl" value="" style="width: 300px;"/>
						</td>
					</tr>
					<tr id="orgAddrTR" style="display: none;">
						<!-- 조직주소 -->
						<th><spring:message code="labal.orgAddr" /></th>
						<td colspan="3" style="height: 60px; line-height: 30px;">
							<input type="text" name="orgAddr" value=""  style="width: 700px;"/>
							<br/>
							<input type="text" name="orgAddrEng" value=""  style="width: 700px;" />
						</td>
					</tr>
					<tr id="mngIdTR" style="display: none;">
						<!-- 공공데이터포털ID -->
						<th><spring:message code="labal.infPortalId" /></th>
						<td colspan="3">
							<input type="text" name="mngId" value="" style="width: 300px;"/>
						</td>
					</tr>
					<tr>
						<!-- 사용여부 -->
						<th><spring:message code="labal.useYn"/></th>
						<td colspan="3">
							<input type="radio" name="useYn" value="Y" class="input" checked/>
							<label for="use"><spring:message code="labal.yes"/></label>
							<input type="radio" name="useYn" value="N" class="input"/>
							<label for="unuse"><spring:message code="labal.no"/></label>
						</td>
					</tr>
					
				</table>	
				
				
				</form>
			</div>
			--%>
			
			<!-- 목록내용 -->
			<div class="content"  >
				<form name="adminSurvey"  method="post" action="#">
				<table class="list01">              
					<caption>설문관리목록</caption>
					<colgroup>
						<col width="150"/>
						<col width=""/>
					</colgroup>       
					<tr>
						<!-- 검색어 -->
						<th><spring:message code="labal.search"/></th>
						<td>
							<select name="searchWd" style="width: 100px;">
								<option value="">선택</option>
								<option value="1"><spring:message code="labal.surveyNm"/></option>
							</select>
							<input type="text" name="searchWord" value="" style="width: 300px"/>
							<button type="button" class="btn01B" name="btn_searchWd">
								<spring:message code="btn.inquiry"/>
							</button>
						</td>
					</tr>

				</table>	
				<!-- ibsheet 영역 -->
				<div style="clear: both;"></div>
				<div class="ibsheet_area_both">
					<script type="text/javascript">createIBSheet("mySheet1", "100%", "300px"); </script>             
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