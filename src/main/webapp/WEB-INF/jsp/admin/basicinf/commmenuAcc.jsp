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
	setMainButton(); //메인 버튼
	LoadPage();                                                                
	doAction('search');	
	inputEnterKey();       
});


/****************************************************************************************************
 * Main 관련
 ****************************************************************************************************/
// Setting
 function setMainButton(){
	$("button[name=btn_search]").click(function(e) {	doAction("search");	return false;	});
	$("a[name=a_modify]").click(function(e) {	doAction("update");			return false;	});
	$('input[name=chkTreeOpenClose]').click(function(){
		var isChecked = $(this).prop("checked");
		// 트리 항목 펼치기
		if ( isChecked ) {
			mySheet1.ShowTreeLevel(0);
			$('label:contains(항목펼치기)').text('항목접기');
		}else  {
			mySheet1.ShowTreeLevel(-1);
			$('label:contains(항목접기)').text('항목펼치기');
			
		}
	});
	
	// 일괄 변경
	$("button[name=btn_modifyAll]").click(function(e) {
		var selectVal = $("select[name=menuAcc]").val();
		//cyy 마지막 데이터 변경안됨 -1 제거
		for (var i=1; i<=mySheet1.RowCount(); i++) {
			mySheet1.SetCellValue(i, "menuAcc", selectVal);
		}
	});
}

function LoadPage()                
{      
	

	//message-common_ko_KR.properties 선언 후 사용 or message-common_en_US.properties 선언 후 사용
	var gridTitle = "NO"
		gridTitle +="|"+"<spring:message code='labal.status'/>";  
		gridTitle +="|"+"<spring:message code='labal.menuId'/>";        
		gridTitle +="|"+"<spring:message code='labal.menuNm'/>";        
		gridTitle +="|"+"<spring:message code='labal.menuUrl'/>";        
		gridTitle +="|"+"<spring:message code='labal.menuParam'/>";        
		gridTitle +="|"+"<spring:message code='labal.menuAcc'/>";        
		gridTitle +="|"+"<spring:message code='labal.useYn'/>";        
		gridTitle +="|"+"<spring:message code='labal.accCd'/>";        
	
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
					 {Type:"Seq",		SaveName:"seq",			Width:20,	Align:"Center",		Edit:false					}
					,{Type:"Status",	SaveName:"status",		Width:0,	Align:"Center",		Hidden:true					}
					,{Type:"Text",		SaveName:"menuId",		Width:0,	Align:"Left",		Edit:false, Hidden:true}
					,{Type:"Text",		SaveName:"menuNm",		Width:100,	Align:"Left",		Edit:0, TreeCol:1}
					,{Type:"Text",		SaveName:"menuUrl",		Width:120,	Align:"Left",		Edit:false}
					,{Type:"Text",		SaveName:"menuParam",	Width:70,	Align:"Left",		Edit:false}
					,{Type:"Combo",		SaveName:"menuAcc",		Width:50,	Align:"Center",		Edit:true}
					,{Type:"CheckBox",	SaveName:"useYn",		Width:20,	Align:"Center",		Edit:false, Hidden:false}
					,{Type:"Text",		SaveName:"accCd",		Width:0,	Align:"Center",		Edit:false, Hidden:true}
					
                                        
                ];                          

        InitColumns(cols);                                                                           
        FitColWidth();
        SetExtendLastCol(1);
        //SetColProperty("menuAcc", {ComboCode:"0|10|20|40|50|90", ComboText:"없음|조회/다운로드|등록/수정|승인|삭제|ALL"});
        SetColProperty("menuAcc", ${codeMap.accCdIbs});
        
    }               
    default_sheet(mySheet1);                      
}    

 
/*=====================================================================================================*
 * Action 처리
 =====================================================================================================*/
/**
 * Sheet 각종 처리
 */              
function doAction(sAction)                                  
{
	var classObj = $(".content"); //tab으로 인하여 form이 다건임
	var actObj = setTabForm(classObj); // 0: form data, 1: form 객체
	var formObj = $("form[name=adminCommMenuAcc]");
	switch(sAction)           
	{          
		case "search":      //조회
// 			if ( formObj.find("select[name=searchWd]").val() != "" ) {
// 				if ( formObj.find("input[name=searchWord]").val() == ""  ) {
// 					alert("검색어를 입력하세요.");
// 					return false;
// 				}
// 			}
			ajaxBeforeSendAdmin("<c:url value='/admin/ajaxBeforeSendAdmin.do'/>"); //IbSheet 조회전 세션 체크
			var param = {PageParam: "ibpage", Param: "onepagerow=50&"+actObj[0]};
			//alert(actObj[0]); return;
			mySheet1.DoSearchPaging("<c:url value='/admin/basicinf/commMenuAccRetr.do'/>", param);
			break;
			
		case "reg":	//등록
			tabNewEvent();
			break;
			
		case "update":
			if ( !confirm("수정 하시겠습니까? ") ) {
				return;
  			}
			ibsSaveJson = mySheet1.GetSaveJson(0);	//트랜잭션 발생한 행의 데이터를 객체로 받기
			if(ibsSaveJson.data.length == 0) return;
			var url = "<c:url value='/admin/basicinf/updateCommMenuAcc.do'/>"; 
			var param = ""; 
			IBSpostJson(url, param, saveCallBack1);	
			break;
	}
} 

function saveCallBack1(res) {
	alert(res.RESULT.MESSAGE);
    doAction("search");
}

function mySheet1_OnSearchEnd(code, msg)
{
	if (mySheet1.RowCount() >= 0) {
		var selectText = $("#menuGrpCd option:selected").text();
	//	alert(selectText + "의 메뉴권한 그룹을 설정합니다.");
	}
	if(msg != "")
	{
	    alert(msg);
    }
}


//엔터키 동작 
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
			
			<!-- 목록내용 -->
			<div class="content"  >
				<form name="adminCommMenuAcc"  method="post" action="#">
				<table class="list01">              
					<caption>보유데이터목록리스트</caption>
					<colgroup>
						<col width="150"/>
						<col width=""/>
					</colgroup>       
					<tr>
						<th>사이트</th>
						<td>
							<c:forEach var="menuSiteCd" items="${commMenu}" varStatus="status">
								<c:choose>
									<c:when test="${status.first }">
										<input type="radio" id="menuSiteCd_${status.count }" name="menuSiteCd" value="${menuSiteCd.ditcCd }"  checked="checked">
									</c:when>
									<c:otherwise>
										<input type="radio" id="menuSiteCd_${status.count }" name="menuSiteCd" value="${menuSiteCd.ditcCd }" >									
									</c:otherwise>
								</c:choose>
								<label for="menuSiteCd_"${status.count }">${menuSiteCd.ditcNm }</label>
							</c:forEach>
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							<button type="button" class="btn01B" name="btn_search"><spring:message code="btn.inquiry"/></button>
						</td>
					</tr>
					<tr>
						<th>검색어</th>
						<td>
							<select name="searchWd">
								<option value=""><spring:message code="etc.select"/></option>
								<option value="1"><spring:message code="labal.menuNm"/></option>
								<option value="2"><spring:message code="labal.menuUrl"/></option>
							</select>
							<input type="text" name="searchWord" value=""/>
						</td>
					</tr>
					<tr>
						<th><spring:message code="labal.menuAccGrp"/></th>
						<td>
							<select name="menuGrpCd" id="menuGrpCd">
								<c:forEach var="code" items="${codeMap.menuGrpCd}" varStatus="status">
								  <option value="${code.ditcCd}">${code.ditcNm}</option>
								</c:forEach>
							</select>
						</td>
					</tr>
					<tr>
						<th><spring:message code="labal.useYn"/></th>
						<td>
							<input type="radio" name="useYn" checked="checked"/>
							<label for="useAll"><spring:message code="labal.whole"/></label>
							<input type="radio" name="useYn"  value="Y"/>
							<label for="use"><spring:message code="labal.yes"/></label>
							<input type="radio" name="useYn" value="N"/>
							<label for="unuse"><spring:message code="labal.no"/></label>
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							<input type="checkbox" name="chkTreeOpenClose"/>
							<label for="chkTreeOpen" name="chkTreeOpenCloseLabel">항목펼치기</label>
						</td>
					</tr>
				</table>	
				
				<!-- ibsheet 영역 -->
				<div style="clear: both;"></div>
				<div class="ibsheet_area_both">
					<script type="text/javascript">createIBSheet("mySheet1", "100%", "300px"); </script>             
				</div>
				<div class="buttons">
					<select name="menuAcc" id="menuAcc">
						<c:forEach var="code" items="${codeMap.accCd}" varStatus="status">
						  <option value="${code.ditcCd}">${code.ditcNm}</option>
						</c:forEach>
					</select>
					<button type="button" class="btn01" name="btn_modifyAll"><spring:message code="labal.changeAll"/></button>
					<span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
					${sessionScope.button.a_modify}
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