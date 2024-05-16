<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="egovframework.common.WiseOpenConfig"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%
String widthSize = "10";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><spring:message code='wiseopen.title'/></title>
<c:import  url="/WEB-INF/jsp/inc/headinclude.jsp"/>
</head>
<script language="javascript">              
$(document).ready(function()    {     
	setMainButton(); //메인 버튼
	LoadPage();//메인 sheet
	doAction('search');//메인 바로조회
	inputEnterKey();//엔터키 적용
	tabSet();// tab 셋팅
});

function setMainButton(){
	var formObj = $("form[name=commCodeFrm]");
	formObj.find("button[name=btn_inquiry]").click(function(e) { //조회
		doAction("search");
		 return false;
	 });
	formObj.find("button[name=btn_reg]").click(function(e) { //등록
		doAction("reg");
		 return false;
	 });
	formObj.find("a[name=a_modify]").click(function(e) { //수정 : 순서변경저장
		doAction("modify");
		 return false;
	 });
	formObj.find("a[name=a_up]").click(function(e) { //위로이동
		doAction("moveUp");
		 return false;
	 });
	formObj.find("a[name=a_down]").click(function(e) { //아래로이동
		doAction("moveDown");
		 return false;
	 });
}
function LoadPage()
{
	//message-common_ko_KR.properties 선언 후 사용 or message-common_en_US.properties 선언 후 사용
	var gridTitle ="NO"; 
		gridTitle +="|"+"<spring:message code='labal.status'/>";
		gridTitle +="|"+"<spring:message code='labal.codeNm'/>";
		gridTitle +="|"+"<spring:message code='labal.vOrder'/>";
		gridTitle +="|"+"<spring:message code='labal.code'/>";
		gridTitle +="|"+"<spring:message code='labal.codeNm'/>";
		gridTitle +="|"+"<spring:message code='labal.codeNmEng'/>";
		gridTitle +="|"+"<spring:message code='labal.refCd'/>";
		gridTitle +="|"+"<spring:message code='labal.useYn'/>";
		with(mySheet){
    	                     
			    	                     
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
					 {Type:"Seq",		SaveName:"seq",			Width:30,	Align:"Center",		Edit:false}
					,{Type:"Status",	SaveName:"status",		Width:30,	Align:"Center",		Hidden:true}
					,{Type:"Text",		SaveName:"grpCd",		Width:30,	Align:"Center",		Edit:false,	Hidden:true}
					,{Type:"Text",		SaveName:"vOrder",		Width:100,	Align:"Center",		Hidden:true}
					,{Type:"Text",		SaveName:"ditcCd",		Width:100,	Align:"Center",		Edit:true,	UpdateEdit:false,	InsertEdit:true}
					,{Type:"Text",		SaveName:"ditcNm",		Width:150,	Align:"Left",		Edit:false, 	UpdateEdit:false,	InsertEdit:true}
					,{Type:"Text",		SaveName:"ditcNmEng",	Width:150,	Align:"Left",		Edit:false, 	UpdateEdit:false,	InsertEdit:true}
					,{Type:"Text",		SaveName:"refCd",		Width:100,	Align:"Center",		Hidden:true}
					,{Type:"CheckBox",	SaveName:"useYn",		Width:30,   Align:"Center",		TrueValue:"Y", FalseValue:"N",Edit:false} 
                    
                ];                                                        
        InitColumns(cols);
        FitColWidth();
        SetExtendLastCol(0);
    }               
    default_sheet(mySheet);                                         
    mySheet.SetCountPosition(0);  
}

/*Sheet 각종 처리*/
function doAction(sAction)                                  
{
	var classObj = $("."+tabContentClass); //tab으로 인하여 form이 다건임
	var actObj = setTabForm(classObj); // 0: form data, 1: form 객체
	var formObj = $("form[name=commCodeFrm]");
	switch(sAction)                  
	{                        
		case "search":      //조회 
			if(formObj.find("input[name=serVal]").val() != "" && formObj.find("select[name=grpCd]").val() != ""){
				alert("그룹코드만 검색됩니다.")
			}
			ajaxBeforeSendAdmin("<c:url value='/admin/ajaxBeforeSendAdmin.do'/>"); //IbSheet 조회전 세션 체크
			var param = {PageParam: "ibpage", Param: "onepagerow=50&"+actObj[0]};
			mySheet.DoSearchPaging("<c:url value='/admin/basicinf/commCodeListAll.do'/>", param);
			break;          
		case "reg":      //등록화면        
			var title = "코드 등록"
			var id ="commCodeRegTab";
		    openTab.addRegTab(id,title,tabCallRegBack); // 탭 추가 시작함
		    break;
		/* case "reload":       
			mySheet.RemoveAll();
			break; */
		case "modify":      // 수정 : 순서변경저장
			if ( !confirm("수정 하시겠습니까? ") ) {
				return;
  			}
			ibsSaveJson = mySheet.GetSaveJson(0);
			if(ibsSaveJson.data.length == 0) {
				alert("저장할 데이터가 없습니다.");
				return;
			}
			var url = "<c:url value='/admin/basicinf/commCodeOrderBySave.do'/>";
			IBSpostJson(url, param, ibscallback);
			break;
		case "moveUp":
			var row = mySheet.GetSelectRow();
			gridMove(mySheet,row-1,"vOrder","Y"); //그리드객체, 이동번호, 정렬컬럼, 정렬여부
			break;
		case "moveDown":
			var row = mySheet.GetSelectRow();
			gridMove(mySheet,row+2,"vOrder","Y");
			break;
	}           
}       

function doActionTab(sAction)                                  
{
	var classObj = $("."+tabContentClass); //tab으로 인하여 form이 다건임
	var actObj = setTabForm(classObj); // 0: form data, 1: form 객체
	var objTab = getTabShowObj();//탭이 oepn된 객체가져옴
	var formObj = objTab.find("form[name=commCodeOne]");
	switch(sAction)                                           
	{                        
		case "reg":      //등록
			if(validateOne(formObj)){
				return;
			}
			var url = "<c:url value='/admin/basicinf/commCodeReg.do'/>"; 
			ajaxCallAdmin(url,actObj[0],saveCallBack);
		    break;       
		case "dup":   		// 중복 
			if(nullCheckValdation(formObj.find('input[name=ditcCd]'),"<spring:message code='labal.code'/>","")){
				return true;
			}
			var url = "<c:url value='/admin/basicinf/commCodeCheckDup.do'/>"; 
			ajaxCallAdmin(url,actObj[0],dupCallBack);
			break;
		case "modify":      //수정
			if ( !confirm("수정 하시겠습니까? ") ) {
				return;
  			}
			if(validateOne(formObj)){            
				return;
			}
			var url = "<c:url value='/admin/basicinf/commCodeUpd.do'/>"; 
			ajaxCallAdmin(url,actObj[0],saveCallBack);
			break;
		case "delete":      //삭제
			if(validateDel(formObj)){
				return;
			}
			var url = "<c:url value='/admin/basicinf/commCodeDel.do'/>"; 
			ajaxCallAdmin(url,actObj[0],deleteCallBack);
			break;       
		case "grp_del":   		// 그룹코드초기화 
			formObj.find('input[name=grpCd]').val(null);
			formObj.find('input[name=grpNm]').val(null);
			formObj.find('input[name=refCd]').val(null);
			break;
		case "popclose":                      
			closeIframePop("iframePopUp");
			break;
		case "popdt1":			// 그룹코드 선택 팝업     
			/* var iframeNm ="iframePopUp";
			var wWidth ="660";
			var wHeight ="530"
			var param = "?"+formObj.serialize();
			var url = "<c:url value='/admin/basicinf/commCodeGrpCdListPopUp.do'/>"+param;
			openIframePop(iframeNm,url,wWidth,wHeight);//ifrmNm, url,width,height
			break; */	// iframe 팝업 사용시
			var param = "?"+formObj.serialize();
			var url = "<c:url value="/admin/basicinf/commCodeGrpCdListPopUp.do"/>" + param;
			var popup = OpenWindow(url,"commCodeGrpCdListPopUp","550","550","yes");
			popup.focus();
			break;
	}
}

//* 반드시 setTabButton() 메소드 사용해야함*//
//탭 callback에서 사용하고 있음//
function setTabButton(){ 
	var objTab = getTabShowObj();//탭이 oepn된 객체가져옴
	var formObj = objTab.find("form[name=commCodeOne]");
	formObj.find("a[name=a_reg]").click(function(e) { //등록
		doActionTab("reg");
		return false;
	 });
	formObj.find("a[name=a_modify]").click(function(e) { //수정
		doActionTab("modify");
		 return false;
	 });
	formObj.find("a[name=a_del]").click(function(e) { //삭제
		doActionTab("delete");
		 return false;
	 });
	formObj.find("button[name=btn_dup]").click(function(e) { //중복
		doActionTab("dup");        
		 return false;
	 });
	formObj.find("button[name=grp_del]").click(function(e) { //상위분류삭제
		doActionTab("grp_del");
		 return false;
	 });
	formObj.find("button[name=btn_search]").eq(0).click(function(e) { // 상위분류 검색
		doActionTab("popdt1");
		 return false;
	 });
	formObj.find("button[name=btn_search]").eq(1).click(function(e) { // 표준맵핑 검색
		doActionTab("popdt2");
		 return false;
	 });
	formObj.find("input[name=lockYnCheck]" ).change(function(e) { // 잠금 여부 설정
		if(inputCheckYn("lockYnCheck") =="Y"){
			formObj.find("[name=lockYn]").val("Y");
		}else{
			formObj.find("[name=lockYn]").val("N");
		}
	 });	
	formObj.find("input[name=ditcCd]").keyup(function(e) {
		ComInputEngNumObj(formObj.find("input[name=ditcCd]"));
		formObj.find("input[name=ditcCdDup]").val("N");
		 return false;
	 });
// 	formObj.find("input[name=ditcNm]").keyup(function(e) {
// 		ComInputKorObj(formObj.find("input[name=ditcNm]"));
// 		 return false;
// 	 });
	formObj.find("input[name=ditcNmEng]").keyup(function(e) {
		ComInputEngEtcObj2(formObj.find("input[name=ditcNmEng]"));
		 return false;
	 });
// 	formObj.find("input[name=cdExp]").keyup(function(e) {
// 		ComInputKorObj(formObj.find("input[name=cdExp]"));
// 		 return false;
// 	 });
	formObj.find("input[name=cdExpEng]").keyup(function(e) {
		ComInputEngEtcObj2(formObj.find("input[name=cdExpEng]"));
		 return false;
	 });
}          
function inputEnterKey(){
	var formObj = $("form[name=commCodeFrm]");
	formObj.find("input[name=serVal]").keypress(function(e) {                   
		  if(e.which == 13) {
			  doAction('search');   
			  return false; 
		  }
	});
}
function tabSet(){ //탭 객체 생성  
	openTab = new OpenTab(tabId,tabContentClass,tabBody); //headinclude.jsp 변수 있음
	openTab.TabObj = openTab;  
	openTab.addTabClickEvent();            
}
function tabEvent(row){//탭 이벤트 실행  
	//var seq = mySheet.GetCellValue(mySheet.GetSelectRow(),"seq");                    
	var title = mySheet.GetCellValue(row,"ditcNm");//탭 제목
	var id = mySheet.GetCellValue(row,"seq");//탭 id(유일한key))
    openTab.SetTabData(mySheet.GetRowJson(row));//db data 조회시 조건 data
    var url = "<c:url value='/admin/opendt/commCodeOne.do'/>"; // Controller 호출 url 
    openTab.addTab(id,title,url,tabCallBack); // 탭 추가 시작함
	//var objTab = getTabShowObj();//탭이 oepn된 객체가져옴
}         
function tabFunction(){//tab callback에서 사용함
	var row = $("input[name=ibSheetRow]").val();
	var grpCd = mySheet.GetCellValue(row,"grpCd");
	var ditcCd = mySheet.GetCellValue(row,"ditcCd");
	var objTab = getTabShowObj();//탭이 oepn된 객체가져옴
	var formObj = objTab.find("form[name=commCodeOne]");
	formObj.find("button[name=btn_dup]").remove();    
	formObj.find("input[name=grpCd]").attr("readonly","readonly");
	formObj.find("input[name=ditcCd]").attr("readonly","readonly");
	
	if(formObj.find("input[name=grpIs]").val() == "N"){
		formObj.find("tr[id=refCdTr]").css("display","none");
		formObj.find("tr[id=lockYnTr]").css("display","none");
	}
	
	if(formObj.find("input[name=lockYn]").val() == "Y"){
		formObj.find("input[name=lockYnCheck]").prop("checked",true);	
	}

}
function mySheet_OnDblClick(row, col, value, cellx, celly) {
	$("input[name=ibSheetRow]").val(row);        
	if(row < 1) return;                                         
	    tabEvent(row);
}
 
function dupCallBack(res){
	var objTab = getTabShowObj();//탭이 oepn된 객체가져옴
	var formObj = objTab.find("form[name=commCodeOne]");
	if(res.RESULT.CODE == -1){
		alert("중복된 분류항목이 존재합니다.");
		formObj.find("input[name=ditcCdDup]").val("N");
	}else{                           
		alert("등록 가능합니다.");
		formObj.find("input[name=ditcCdDup]").val("Y");
	}
}

function buttonEventAdd(){ //버튼 이벤트 사라짐 overring하여 버튼 이벤트 추가사용
	setTabButton();                                  
}                
// 마우스 이벤트
<%-- function mySheet_OnSearchEnd(code, msg)
{
   if(msg != "")
	{
	    alert(msg);
    }else{
    	//mySheet_OnClick(2, 2, 0, 0, 0, 0);		              
    }
   mySheet.FitColWidth('<%=widthSize%>');
} --%>

function OnSaveEnd(){
	doAction("search");                 
}

function validateOne(formObj){
	if(nullCheckValdation(formObj.find('input[name=ditcCd]'),"<spring:message code='labal.code'/>","")){
		return true;
	}
	if(nullCheckValdation(formObj.find('input[name=ditcNm]'),"<spring:message code='labal.codeNm'/>","")){
		return true;
	}
	if(formObj.find('input[name=ditcCd]').attr("readonly") != "readonly"){	//중복체크
		if(formObj.find('input[name=ditcCdDup]').val() == "N"){
			alert("중복체크 버튼을 클릭해주세요.")
			return true;
		}
	}
	if(formObj.find('input[name=grpIs]').val() == "Y" && formObj.find('input[name=grpCib]').val() == "Y"){	// 해당 코드가 그룹코드이며 서브코드가 존재할경우
	if($("input:radio[id='unuse']:checked").val() == "N"){	// 미사용 처리 체크
		var msg = "미사용 처리시 하위 코드도 동시에 미사용 처리 됩니다. 저장하시겠습니까?";
		if(!confirm(msg)){
			return true;
		}
	}
	if(formObj.find("[name=lockYn]").val() == "Y"){		// 잠금 처리 체크
	msg = "잠금처리시 하위 코드도 동시에 잠금 처리 됩니다. 저장하시겠습니까?";
	if(!confirm(msg)){
		return true;
	}
	}
	}
	
	return false;                               
}
function validateDel(formObj){
	if(formObj.find('input[name=grpIs]').val() == "Y" && formObj.find('input[name=grpCib]').val() == "Y"){	// 해당 코드가 그룹코드이며 서브코드가 존재할경우
	var msg = "해당 코드의 하위코드들도 함께 삭제됩니다. 삭제하시겠습니까?";
	if(!confirm(msg)){
		return true;
		}
	}else{
	var msg = "삭제하시겠습니까?";
	if(!confirm(msg)){
		return true;
		}
		}
		return false;                               
}
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
			
			<!-- 공통코드 상세 내용 전체 DIV-->
			<div class="content" style="display:none;">
				<form name="commCodeOne"  method="post" action="#">
				<input type="hidden" name="vOrder" value=""/>
				<input type="hidden" name="preGrpCd" value=""/>
				<input type="hidden" name="grpCd" value=""/>
				<input type="hidden" name="grpIs" value=""/>
				<input type="hidden" name="grpCib" value=""/>
				<input type="hidden" name="lockYn" value="N"/>
				<input type="hidden" name="ditcCdDup" value="N"/>
				<table class="list01">
					<caption>보유데이터목록리스트</caption>
					<colgroup>
						<col width="150"/>
						<col width=""/>
					</colgroup>
					<tr>
						<th><spring:message code='labal.grpCd'/></th>
						<td>
							<input type="text" name="grpNm" value="" maxlength="160" size="100" style="width: 100px;"/>
							${sessionScope.button.btn_search}
							<span>선택하지 않으면 그룹코드로 등록됩니다.</span>
							${sessionScope.button.grp_del}
						</td>
					</tr>
					<tr>
						<th><spring:message code='labal.code'/><span>*</span></th>
						<td>
							<input type="text" value="" name="ditcCd" maxlength="160" style="width: 150px;"/>
							${sessionScope.button.btn_dup}
							<span>공백없이 영문자와 숫자로만 입력하세요. (20자이내)</span>
						</td>
					</tr>         
					<tr>
						<th><spring:message code='labal.codeNm'/> <span>*</span></th>
						<td>
							(한) <input type="text" value=""  name="ditcNm" maxlength="160"  style="width: 344px;"/>
							(영) <input type="text" value=""  name="ditcNmEng" maxlength="160" style="width: 344px;"/>
						</td>
					</tr>        
					<tr id="refCdTr" style="display:none;"> <!-- 나중에 살릴수도 있음 -->                 
						<th><spring:message code='labal.refCd'/></th>
						<td>
							<input type="text" name="refCd" value="" maxlength="13" style="width: 100px;"/>  
							${sessionScope.button.btn_search}
						</td>
					</tr>
					<tr>                 
						<th><spring:message code='labal.valueCd'/></th>
						<td>
							<input type="text" name="valueCd" value="" maxlength="160" style="width: 100px;"/>
							<span>별도의 코드값을 사용할 때 등록하세요.(50자 이내)</span>  
						</td>
					</tr>
					<tr>                 
						<th><spring:message code='labal.valueCd'/></th>
						<td>
							<input type="text" name="valueCd2" value="" maxlength="160"  style="width: 100px;"/>
							<span>별도의 코드값을 사용할 때 등록하세요.(50자 이내)</span>  
						</td>
					</tr>
					<tr>
						<th><spring:message code='labal.cdExp'/></th>
						<td>
							(한) <input type="text" value=""  name="cdExp" maxlength="160"  style="width: 344px;"/>
							(영) <input type="text" value=""  name="cdExpEng" maxlength="160" style="width: 344px;"/>
						</td>
					</tr>   
					<tr>         
						<th><spring:message code='labal.useYn'/> </th>
						<td>
							<input type="radio" name="useYn" id="use" checked="checked" value="Y"/>
							<label for="use"><spring:message code='labal.yes'/></label>
							<input type="radio" name="useYn" id="unuse" value="N"/>
							<label for="unuse"><spring:message code='labal.no'/></label>
							&nbsp;&nbsp;&nbsp;
							<span>주의) 미사용 처리시 사용중인 코드가 있는지 확인해 주세요</span>
						</td>
					</tr>
					<tr id="lockYnTr">         
						<th><spring:message code='labal.lockYn'/></th>
						<td>
						<input type="checkbox" name="lockYnCheck" id="lockYnCheck" value="N"/>
						<spring:message code='labal.lockYn'/>
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




						
			<!-- 리스트 -->
			<div class="content">
				<form name="commCodeFrm"  method="post" action="#">
				<input type="hidden" name="ibSheetRow" value=""/>             
				<table class="list01">
					<caption>보유데이터목록리스트</caption>
					<colgroup>
						<col width="150"/>
						<col width=""/>
					</colgroup>
					<tr>
						<th><spring:message code='labal.search'/></th>             
							<td>
								<select name="serSel">	
									<option value="ALL"><spring:message code='etc.select'/></option>
									<option value="NM" selected="selected"><spring:message code='labal.codeNm'/></option>
									<option value="ENG" ><spring:message code='labal.codeNmEng'/></option>
									<option value="CODE" >코드</option>
									<input type="text" name="serVal" value="" maxlength="50" style="width: 300px"/>
								</select> 
								${sessionScope.button.btn_inquiry}               
								${sessionScope.button.btn_reg}
							</td>
					</tr>
					<tr>
						<th><spring:message code='labal.grpCd'/></th>
							<td>
								<select name="grpCd">	
									<option value="">선택</option>
									<c:forEach var="code" items="${codeMap.grpCd}" varStatus="status">
									<option value="${code.ditcCd}">[${code.ditcCd}] ${code.ditcNm}</option>
								</c:forEach>
								</select>       
								<span>그룹코드를 선택하지 않으면 그룹코드 목록이 조회됩니다</span>
							</td>
					</tr>
					<tr>
						<th><spring:message code='labal.srvYn'/></th>
						<td>
							<input type="radio" name="useYn" id="useall"  value=""/>            
							<label for="useall"><spring:message code="labal.whole"/></label>
							<input type="radio" name="useYn" id="use" value="Y" checked="checked"/>
							<label for="use"><spring:message code='labal.yes'/></label>
							<input type="radio" name="useYn" id="unuse" value="N"/>
							<label for="unuse"><spring:message code='labal.no'/></label>
						</td>
					</tr>
				</table>		
				
				<div style="width:100%;float:left;">
					<div style="border:1px solid #c0cbd4;padding:10px;margin:0 15px 0 0;">
						<script type="text/javascript">createIBSheet("mySheet", "100%", "300px"); </script>             
					</div>
					<div class="buttons" style="margin-right:15px;">
						${sessionScope.button.a_up}
						${sessionScope.button.a_down}
						${sessionScope.button.a_modify}
					</div>
				</div>
				</form>               	
			</div>
		</div>		
	<c:import  url="/WEB-INF/jsp/inc/iframepopup.jsp"/>
	<!--##  푸터  ##-->                                       
	<c:import  url="/WEB-INF/jsp/admin/adminfooter.jsp"/>                                   
	<!--##  /푸터  ##-->   
</body>
</html>