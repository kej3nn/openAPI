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
	adminCommMenu -> validateadminCommMenu 체크함
	resources/validator/*.* xml을 만들어서 사용
  -->
<validator:javascript formName="adminCommMenu" staticJavascript="false" xhtml="true" cdata="false"/> 
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
	setMainButton();		//메인 버튼
	setTabButton();			//탭 버튼
	LoadPage();				// 메인 sheet
	doAction('search');     // 조회                            
	tabSet();				// tab 셋팅           
	inputEnterKey();		//엔터키		
}); 

/****************************************************************************************************
 * Main 관련
 ****************************************************************************************************/
// setting
function setMainButton() {
	var formObj = $("form[name=adminCommMenu]");
	$("button[name=btn_reg]").click(function(e) {	doAction("reg");	return false;	}); 
	$("button[name=btn_search]").click(function(e) {	
		if ( formObj.find("input[name=searchWord]").val() == "" ) {
			doAction("search");	//검색어 입력안할 경우 전체 조회(메뉴형식으로)
		} else {
			doAction("searchKeywd");	
		}
		return false;	
	});
	$("button[name=btn_reset]").click(function(e) {	doAction("search");	return false;	});
	$('input[name=chkTreeOpenClose]').click(function(){
		var isChecked = $(this).prop("checked");
		// 트리 항목 펼치기
		if ( isChecked ) {
			mySheet1.ShowTreeLevel(-1);
			$('label:contains(항목펼치기)').text('항목접기');
		}else  {
			mySheet1.ShowTreeLevel(0);
			$('label:contains(항목접기)').text('항목펼치기');
		}
	});
	$("a[name=a_up]").click(function(e) { 						//위로이동
		doAction("treeUp");                
		return false;                  
	});                                              
	$("a[name=a_down]").click(function(e) {		 				//아래로이동
		doAction("treeDown");
		return false;                              
	});  
	
	$("a[name=a_save]").click(function(e) {		 				//트리순서 수정
		doAction("updateCommMenuTreeOrder");
		return false;                              
	}); 
	
}

/**
 * 전체화면 Sheet
 */
function LoadPage()                
{      
	var gridTitle = "NO"
		gridTitle +="|"+"<spring:message code='labal.status'/>";  
		gridTitle +="|"+"<spring:message code='labal.menuId'/>";        
		gridTitle +="|"+"<spring:message code='labal.menuNm'/>";        
		gridTitle +="|"+"<spring:message code='labal.menuUrl'/>";        
		gridTitle +="|"+"<spring:message code='labal.menuParam'/>";        
		gridTitle +="|"+"<spring:message code='labal.menuLv'/>";        
		gridTitle +="|"+"<spring:message code='labal.useYn'/>";        
		gridTitle +="|"+"<spring:message code='labal.vOrder'/>";        
		gridTitle +="|사이트구분";        
	
    with(mySheet1){
    	                     
    	var cfg = {SearchMode:2,Page:50};                                
        SetConfig(cfg);  
        var headers = [                               
                    {Text:gridTitle, Align:"Center"}                 
                ];
        var headerInfo = {Sort:0,ColMove:1,ColResize:1,HeaderCheck:0};
        
        InitHeaders(headers, headerInfo); 
                 
        var cols = [          
					 {Type:"Seq",		SaveName:"seq",			Width:20,	Align:"Center",		Edit:false}
					,{Type:"Status",	SaveName:"status",		Width:30,	Align:"Center",		Hidden:false					}
					,{Type:"Text",		SaveName:"menuId",		Width:0,	Align:"Center",		Edit:false, Hidden:true}
					,{Type:"Text",		SaveName:"menuNm",		Width:50,	Align:"Left",		Edit:0, TreeCol:1 }
					,{Type:"Text",		SaveName:"menuUrl",		Width:80,	Align:"Left",		Edit:false}
					,{Type:"Text",		SaveName:"menuParam",	Width:80,	Align:"Left",		Edit:false}
					,{Type:"Text",		SaveName:"menuLv",		Width:20,	Align:"Center",		Edit:false, Hidden:false}
					,{Type:"CheckBox",	SaveName:"useYn",		Width:20,	Align:"Center",		Edit:false, Hidden:false}
					,{Type:"Text",		SaveName:"vOrder",		Width:20,	Align:"Center",		Edit:false, Hidden:true}
					,{Type:"Text",		SaveName:"menuSiteCd",		Width:20,	Align:"Center",		Edit:false, Hidden:true}
                ];                          
                                      
        InitColumns(cols);                                                                           
        FitColWidth();
        ShowTreeLevel(2,1);
        SetExtendLastCol(1);   
    }               
    default_sheet(mySheet1);                      
}    

/**
 * 상세 조회시 IBS
 */
function LoadDetail(sheetName){
	var gridTitle2 = "<spring:message code='labal.LowmenuNm'/>"
	
	with(sheetName){
      
  	var cfg = {SearchMode:2,Page:50};                                
      SetConfig(cfg);  
      var headers = [                               
                  {Text:gridTitle2, Align:"Center"}                 
              ];
      var headerInfo = {Sort:0,ColMove:1,ColResize:1,HeaderCheck:0};
      
      InitHeaders(headers, headerInfo); 
      SetEditable(1);
       
      var cols = [   {Type:"Text",		SaveName:"menuNm",			Width:100,	Align:"Left",		Edit:false, TreeCol:1}];       
                                    
      InitColumns(cols);                                                                           
      FitColWidth();                                                         
      SetExtendLastCol(1);
  	}
    default_sheet(sheetName);
}

 
/**
 * 메인 각종 처리
 */              
function doAction(sAction)                                  
{
	var classObj = $("."+tabContentClass); //tab으로 인하여 form이 다건임
	var actObj = setTabForm(classObj); // 0: form data, 1: form 객체
	
	switch(sAction)           
	{          
		case "search":      //조회   
			ajaxBeforeSendAdmin("<c:url value='/admin/ajaxBeforeSendAdmin.do'/>"); //IbSheet 조회전 세션 체크
			var param = {PageParam: "ibpage", Param: "onepagerow=50&"+actObj[0]};         
			mySheet1.DoSearchPaging("<c:url value='/admin/basicinf/commMenuRetr.do'/>", param);
			break;   
		case "searchKeywd" : // 검색어 조회
			ajaxBeforeSendAdmin("<c:url value='/admin/ajaxBeforeSendAdmin.do'/>"); //IbSheet 조회전 세션 체크
			var param = {PageParam: "ibpage", Param: "onepagerow=50&"+actObj[0]};
			mySheet1.DoSearchPaging("<c:url value='/admin/basicinf/commMenuRetrKeywd.do'/>", param);
			break;
		case "reg":	//등록
			var title = "등록하기";
			var id ="dsReg";
			openTab.addRegTab(id,title,tabCallRegBack); // 탭 추가 시작함
			break;	
		case "treeUp":
			treeUp(mySheet1, true, "vOrder");	// obj, 순서설정플래그, 순서설정컬럼
			break;                 
		case "treeDown":              
			treeDown(mySheet1, true, "vOrder");
			break;
		case "updateCommMenuTreeOrder" :
			ibsSaveJson = mySheet1.GetSaveJson(0);                                                    
			if(ibsSaveJson.data.length == 0) {
				alert("저장할 데이터가 없습니다.");  
				return;
			}
			var url = "<c:url value='/admin/basicinf/commMenuListUpdateTreeOrder.do'/>";
			IBSpostJson(url, ibsSaveJson, ibscallback);
			break;
	}           
}

/**
 * 마우스 이벤트
 */
function mySheet1_OnSearchEnd(code, msg)
{
   if(msg != "")
	{
	    alert(msg);
    } else { 
    	mySheet1.ShowTreeLevel(0, 1); 
    }
}


//엔터키 동작 
function inputEnterKey(){
	var formObj = $("form[name=adminCommMenu]");
	$("input").keypress(function(e) {
		  if(e.which == 13) {
			if ( formObj.find("input[name=searchWord]").val() == "" ) {
				doAction("search");	//검색어 입력안할 경우 전체 조회(메뉴형식으로)
			} else {
				doAction("searchKeywd");	
			}
			return false;
		  }
	});
}   

function OnSaveEnd() {	
	doAction("search");
}  


function mySheet1_OnDblClick(row, col, value, cellx, celly) {
    if(row == 0) return;
    tabEvent(row);
} 

/****************************************************************************************************
 * Tab 관련
 ****************************************************************************************************/
 /**
  * 탭 추가 시 버튼 Setting
  */
 function setTabButton(){ 
 	var objTab = getTabShowObj();//탭이 oepn된 객체가져옴
 	var formObj = objTab.find("form[name=adminCommMenu]");    
 	
 	// 신규 등록
 	formObj.find("a[name=a_reg]").click(function(e) { //저장
 		doSheetAction("save");
 		return false;                 
 	}); 
 	
 	// 수정
 	formObj.find("a[name=a_modify]").eq(0).click(function() {
 		doSheetAction("update");          
 		return false;                 
 	});   
 	
 	// 메뉴 팝업(검색)
 	formObj.find("button[name=dtSearch ]").click(function() {
 		doSheetAction("commMenuPop");               
 		return false;                 
 	}); 

 	// 삭제
 	formObj.find("a[name=a_del]").eq(0).click(function() {
 		doSheetAction("delete");          
 		return false;                 
 	});
 	
 }

// 탭 액션
function doSheetAction(sAction)
{
	var classObj = $("."+tabContentClass); //tab으로 인하여 form이 다건임
	var actObj = setTabForm(classObj); // 0: form data, 1: form 객체
	var sheetObj; //IbSheet 객체         
	var objTab = getTabShowObj();//탭이 oepn된 객체가져옴
	var formObj = objTab.find("form[name=adminCommMenu]");
	sheetObj =formObj.find("input[name=sheetNm]").val();   
	ajaxBeforeSendAdmin("<c:url value='/admin/ajaxBeforeSendAdmin.do'/>"); //IbSheet 조회전 세션 체크
	var gridObj = window[sheetObj];
	switch(sAction)                    
	{
		case "save" :		// 저장
			if (!validateAdminCommMenu(actObj[1])){  //validation 체크         
				return;   
			}
			var url =  "<c:url value='/admin/basicinf/commMenuSave.do'/>";
			var param = openTab.ContentObj.find("[name=adminCommMenu]").serialize();
			ajaxCallAdmin(url, param, saveCallBack);
			break;
		
		case "update" :		// 수정
			if ( !confirm("수정 하시겠습니까? ") ) {
				return;
  			}
			var url = "<c:url value='/admin/basicinf/updateCommMenu.do'/>"; 
			var param = openTab.ContentObj.find("[name=adminCommMenu]").serialize();
			ajaxCallAdmin(url,param,saveCallBack);
			break;
		
		case "searchDtl" :	// 메뉴 하위 트리 조회
			formObj.find("td[name=mainSheet]").css("display", "block");		//숨긴 IBsheet 보여줌
			<%-- 
			var menuIdParVal = formObj.find("[name=menuIdPar]").val();
			var url = "<c:url value='/admin/basicinf/commLowMenuList.do'/>"; 
			var param = {PageParam: "ibpage", Param: "onepagerow=50&"+"menuIdPar="+menuIdParVal};
			 --%>
			var menuId = formObj.find("[name=menuId]").val();
			var url = "<c:url value='/admin/basicinf/commLowMenuList.do'/>"; 
			var param = {PageParam: "ibpage", Param: "onepagerow=50&"+"menuId="+menuId};
			gridObj.DoSearchPaging(url, param); 
			break;
			
		case "delete":		// 트리 메뉴 삭제
			if ( !confirm("삭제 하시겠습니까? ") ) {
				return;
  			}
		
			var mainSelectRow = formObj.find("input[name=mainSelectRow]").val();	//메인의 선택행
			var nodeCount = mySheet1.GetChildNodeCount(mainSelectRow);				//선택한 행의 하위메뉴 존재갯수
			// 하위메뉴 존재 시 삭제 불가처리
			if(nodeCount == 0){
				var url = "<c:url value='/admin/basicinf/deleteCommMenu.do'/>"; 
	 			var param = formObj.serialize();
	 			ajaxCallAdmin(url,param,saveCallBack);
	 			
			} else{
				alert("하위 메뉴가 존재합니다. 삭제할 수 없습니다");
				return false;
			}
			
			break;	
			
		case "commMenuPop":
			var menuSiteCd = formObj.find("input:radio[name=menuSiteCd]:checked").val();
	 		OpenWindow("<c:url value="/admin/basicinf/popup/commmenu_pop.do?menuSiteCd="/>"+menuSiteCd,"commMenuPop","550","550","yes");
			break;
	}
}
 
//탭 Sheet 생성
function SheetCreate(SheetCnt){       
 	var SheetNm = "sheet"+SheetCnt;          
 	$("div[name=mainSheet]").eq(1).attr("id","DIV_"+SheetNm);                                          
 	createIBSheet2(document.getElementById("DIV_"+SheetNm),SheetNm, "100%", "200px");               
 	var sheetobj = window[SheetNm]; 
 	var objTab = getTabShowObj();//탭이 oepn된 객체가져옴
 	var formObj = objTab.find("form[name=adminCommMenu]");
 	formObj.find("input[name=sheetNm]").val(SheetNm);
 	LoadDetail(sheetobj);
 	doSheetAction("searchDtl");
 	formObj.find("input[name=mainSelectRow]").val(mySheet1.GetSelectRow());
}


//탭 추가 시 버튼 이벤트
function buttonEventAdd(){
	setTabButton();
}

//탭 추가 이벤트
function tabEvent(row){   
	var title = mySheet1.GetCellValue(row,"menuNm");//탭 제목 
	var id = mySheet1.GetCellValue(row,"seq");//탭 id(유일한key))
    var aa = mySheet1.GetRowJson(row);
    openTab.SetTabData(mySheet1.GetRowJson(row));//db data 조회시 조건 data
    var url = "<c:url value='/admin/basicinf/commMenuRetrInfo.do'/>"; // Controller 호출 url  
    openTab.addTab(id,title,url,tabCallBack); // 탭 추가 시작함(callback함수 overring)          
    var cnt = sheetTabCnt++;
    SheetCreate(cnt); //시트
}

//Tab 조회콜백
function tabFunction(tab, json){
	//tab.ContentObj.find("button[name=dtSearch]").hide();
	tab.ContentObj.find("input[name=menuSiteCd]").attr("disabled", 'true');
	if(tab.ContentObj.find("input[name=beforeMenuSiteCd]").val() == 'Y'){	// 포탈일때
		tab.ContentObj.find("input[name=menuSiteCd]:input[value='PN201']").prop('checked', 'checked');
		
	};
	
}

//tab 추가시(tabCallRegBack 오버라이드)
function regUserFunction(tab) {
	var objTab = getTabShowObj();//탭이 oepn된 객체가져옴
	var formObj = objTab.find("form[name=adminCommMenu]");
	formObj.find("div[name=mainSheet]").remove();		//등록시 sheet 없앰.
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
					<li><a href="#">공공데이터목록</a><a href="#" class="line_close">x</a></li>
				</ul>
			</div>
			              
			<!-- 탭 내용 -->
			<div class="content" style="display:none">
				<form name="adminCommMenu"  method="post" action="#">
				<input type="hidden" name="sheetNm"/>
				<input type="hidden" name="mainSelectRow"/>
				<table class="list01">
					<colgroup>
						<col width="150"/>
						<col width=""/>
					</colgroup>
					<tr>
						<!-- 메뉴명 -->
						<th><spring:message code="labal.menuNm"/> <span>*</span></th>
						<td>
							<input type="text" value="" name="menuNm" style="width: 200px;"/>
							<!-- menuId 신규 입력시 필요하여 value 박아둠 -->
							<input type="hidden" name="menuId" value="999999999"/>
							<input type="hidden" name="menuIdTop" value=""/>
							<input type="hidden" name="beforeMenuSiteCd"/>
							<span><spring:message code="labal.menuId"/></span>
						</td>
						<!-- <td rowspan="6" name="mainSheet" style="display:none;">
							<div class="ibsheet_area" name="mainSheet"></div>
						</td> -->
					</tr>
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
						</td>
					</tr>
					<tr>
						<!-- 상위메뉴 -->
						<th><spring:message code="labal.menuIdPar"/> <span>*</span></th>
						<td>
							<input type="hidden" name="menuIdPar" value=""/>
							<input type="text" value="" name="menuIdParDesc" class="readonly" readonly disabled="true" style="width: 200px;"/>
							<button type="button" class="btn01" name="dtSearch"><spring:message code="btn.search"/></button>
							
							<span>선택하지 않으면 최상위 메뉴로 등록됩니다.</span>
						</td>
					</tr>
					<tr>
						<!-- 메뉴URL -->
						<th><spring:message code="labal.menuUrl"/></th>
						<td>
							<input type="text" value="" name="menuUrl" size="60"/>
						</td>
					</tr>
					<tr>
						<!-- 호출인자 -->
						<th><spring:message code="labal.menuParam"/></th>
						<td>
							<input type="text" value="" name="menuParam" size="60"/>
						</td>
					</tr>
					<tr>
						<!-- 설명 -->
						<th><spring:message code="labal.desc"/></th>
						<td>
							<input type="text" value="" name="menuDesc" size="90"/>
						</td>
					</tr>
					<tr>
						<!-- 표시여부 -->
						<th>표시여부(포털)</th>
						<td>
							<input type="radio" name="viewYn" value="Y" class="input" checked/>
							<label for="use">예</label>
							<input type="radio" name="viewYn" value="N" class="input"/>
							<label for="unuse">아니오</label>
						</td>
					</tr>
					<tr>
						<!-- 사용여부 -->
						<th><spring:message code="labal.useYn"/></th>
						<td>
							<input type="radio" name="useYn" value="Y" class="input" checked/>
							<label for="use"><spring:message code="labal.yes"/></label>
							<input type="radio" name="useYn" value="N" class="input"/>
							<label for="unuse"><spring:message code="labal.no"/></label>
						</td>
					</tr>
				</table>
				<div class="buttons">
					${sessionScope.button.a_reg}
					${sessionScope.button.a_modify}
					${sessionScope.button.a_del}
				</div>
				</form>
			</div>
			
			<!-- 목록내용 -->
			<div class="content"  >
				<form name="adminCommMenu"  method="post" action="#">
				<table class="list01">              
					<caption>메뉴관리</caption>
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
								<label for="menuSiteCd_${status.count }">${menuSiteCd.ditcNm }</label>
							</c:forEach>
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
							<button type="button" class="btn01B" name="btn_search"><spring:message code="btn.inquiry"/></button>
							<%-- <button type="button" class="btn01" name="btn_reset"><spring:message code="btn.init"/></button> --%>
							${sessionScope.button.btn_reg}    
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
					${sessionScope.button.a_up}     
					${sessionScope.button.a_down}     
					${sessionScope.button.a_save}     
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