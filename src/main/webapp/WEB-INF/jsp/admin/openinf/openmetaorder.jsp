<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="egovframework.common.WiseOpenConfig"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%-- <%
	OpenMetaOrderVO openMetaOrderVO = new OpenMetaOrderVO();
	openMetaOrderVO = request.getAttribute("result");
%> --%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><spring:message code='wiseopen.title'/></title>
<c:import  url="/WEB-INF/jsp/inc/headinclude.jsp"/>
</head>    
<script language="javascript">                
$(document).ready(function()    {     
	//$("input[name=sysLang]").val("KOR");
	//$("input:radio[name=sysLangRadio]").eq(0).attr("checked",true);
	setMainButton(); //메인 버튼
	LoadPage();//메인 sheet
	doAction('search');//메인 바로조회
	inputEnterKey();//엔터키 적용
});

function setMainButton(){
	var formObj = $("form[name=adminOpenMetaOrderMain]");
	formObj.find("button[name=btn_inquiry]").click(function(e) { //조회  
		doAction("search");   
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
	formObj.find("button[name=btn_search]").click(function(e) { // 분류 검색
		doAction("popdt");  
		 return false;
	 });
	formObj.find("button[name=btn_init]").click(function(e) { // 분류 검색 초기화
		formObj.find("input[name=cateId]").val("");
		formObj.find("input[name=cateNm]").val("");
		return false;
	 });
          
	var sysLang = formObj.find("input:radio[name=sysLangRadio]"); 
		sysLang.each(function(index,item){			// sysLang라디오버튼의 길이만큼 each를 실행
			sysLang.eq(index).click(function(){		// sysLang라디오버튼중에서 선택한것만
				$("input[name=cateId]").val(null);	// sysLang을 선택하면 분류코드와 분류명은 초기화를 시켜줌
				$("input[name=cateNm]").val(null);
				sysLang.each(function(index2,item){	// 다시sysLang라디오버튼의 길이만큼 each를 실행
						sysLang.eq(index2).prop("checked",false);	// 일단 sysLang라디오버튼의 checked를 모두 false시킴
	 			});
			sysLang.eq(index).prop("checked",true);	// 선택된 sysLang라디오버튼만 다시 checked를 true시킴
			formObj.find("input[name=sysLang]").val(sysLang.eq(index).val());
			// 선택된 sysLang라디오버튼의 value값을 sysLang inputBox에다가 넣어줌
			});
		});
}   

function LoadPage()                
{      
	//message-common_ko_KR.properties 선언 후 사용 or message-common_en_US.properties 선언 후 사용
	var gridTitle = "NO"
		gridTitle +="|"+"<spring:message code='labal.status'/>"; 
		gridTitle +="|"+"<spring:message code='labal.infId'/>";  
		gridTitle +="|"+"카테고리 구분 태그";  
		gridTitle +="|"+"카테고리 아이디";  
		gridTitle +="|"+"<spring:message code='labal.cateNm'/>";  
		gridTitle +="|"+"<spring:message code='labal.infNm'/>";        
		//gridTitle +="|"+"<spring:message code='labal.cclCd'/>";  
		//gridTitle +="|"+"<spring:message code='labal.fvtDataOrder'/>"; 
		//gridTitle +="|"+"공공데이터순서";
	//	gridTitle +="|"+"데이터셋 구분";        
		gridTitle +="|"+"<spring:message code='labal.vOrder'/>";
		//gridTitle +="|"+"<spring:message code='labal.cateNm'/>";        
		//gridTitle +="|"+"<spring:message code='labal.orgNm'/>";        
// 		gridTitle +="|"+"<spring:message code='labal.usrNm'/>"; 
		//gridTitle +="|"+"<spring:message code='labal.useOrgCnt'/>";
		gridTitle +="|"+"<spring:message code='labal.openDttm'/>";        
		//gridTitle +="|"+"<spring:message code='labal.infState'/>";        
		gridTitle +="|"+"개방서비스";   
		//gridTitle +="|"+"<spring:message code='labal.aprvProcYn'/>";
		//gridTitle +="|"+"상태";   
	
    with(mySheet){
    	                      
    	var cfg = {SearchMode:2,Page:50,VScrollMode:1};                                 
        SetConfig(cfg);   
        var headers = [                                             
                    {Text:gridTitle, Align:"Center"}                 
                ];
        var headerInfo = {Sort:0,ColMove:1,ColResize:1,HeaderCheck:0};
        
        InitHeaders(headers, headerInfo); 
         
        var cols = [          
					 {Type:"Seq",		SaveName:"seq",				Width:140,	Align:"Center",		Edit:false,  Sort:false}
					,{Type:"Status",	SaveName:"status",		Width:30,	Align:"Center",		Hidden:true					}
					,{Type:"Text",		SaveName:"infId",			Width:0,	Align:"Center",		Edit:false, Hidden:true}
					,{Type:"Text",		SaveName:"cateDivTag",			Width:0,	Align:"Center",		Edit:false, Hidden:true}
					,{Type:"Text",		SaveName:"cateId2",			Width:0,	Align:"Center",		Edit:false, Hidden:true}
					,{Type:"Text",		SaveName:"cateNm",			Width:300,	Align:"Left",		Edit:false}
					,{Type:"Text",		SaveName:"infNm",			Width:440,	Align:"Left",		Edit:false}
					,{Type:"Text",		SaveName:"vOrder",			Width:0,	Align:"Center",		Edit:false,Hidden:true}
					,{Type:"Text",		SaveName:"openDttm",			Width:300,	Align:"Center",		Edit:false}
					,{Type:"Html",		SaveName:"openSrv",			Width:200,	Align:"Left",		Edit:false}
                ];       
                                      
        InitColumns(cols);                                                                           
        SetExtendLastCol(1);   
        
    }               
    default_sheet(mySheet); 
    mySheet.SetCountPosition(0);
}      

/*Sheet 각종 처리*/   
function doAction(sAction)                                  
{
	var classObj = $("."+tabContentClass); //tab으로 인하여 form이 다건임
	var actObj = setTabForm(classObj); // 0: form data, 1: form 객체
	var sheetObj = "mySheet"; //IbSheet 객체
	var gridObj = window[sheetObj];
	
	switch(sAction)                  
	{                    
		case "search":      //조회   
			var formObj = $("form[name=adminOpenMetaOrderMain]");   
			ajaxBeforeSendAdmin("<c:url value='/admin/ajaxBeforeSendAdmin.do'/>"); //IbSheet 조회전 세션 체크
			var param = {PageParam: "ibpage", Param: "onepagerow=50&"+actObj[0]};
			mySheet.DoSearchPaging("<c:url value='/admin/openinf/openMetaOrderPageListAllMainTree.do'/>", param);
			break;
		case "modify":      // 수정 : 순서변경저장
			if ( !confirm("수정 하시겠습니까? ") ) {
				return;
  			}
			ibsSaveJson = mySheet.GetSaveJson(0);
			if(ibsSaveJson.data.length == 0) {
				alert("저장할 데이터가 없습니다.");  
				return;
			}
			var url = "<c:url value='/admin/openinf/openMetaOrderBySave.do'/>";
			//var param = "";
			IBSpostJson(url, param, ibscallback);
			break;   
		case "moveUp":   
			//treeUp(mySheet, true, "vOrder");	// obj, 순서설정플래그, 순서설정컬럼
			
			/* if(mySheet.GetCellValue(mySheet.GetSelectRow(),"itemType")=='C'){	// infId가 아닌 cateId는 이동할수 없음
				alert("분류는 이동할수 없습니다.");
				return;
			}else{
			treeUp(mySheet, true, "vOrder");	// obj, 순서설정플래그, 순서설정컬럼
			} */
			var row = mySheet.GetSelectRow();
			gridMove(mySheet,row-1,"vOrder","Y"); //그리드객체, 이동번호, 정렬컬럼, 정렬여부
			break;
		case "moveDown":
			//treeDown(mySheet, true, "vOrder");	// obj, 순서설정플래그, 순서설정컬럼
			
			/* if(mySheet.GetCellValue(mySheet.GetSelectRow(),"itemType")=='C'){	// infId가 아닌 cateId는 이동할수 없음
				alert("분류는 이동할수 없습니다.");
				return;
			}else{
			treeDown(mySheet, true, "vOrder");	// obj, 순서설정플래그, 순서설정컬럼
			} */
			var row = mySheet.GetSelectRow();
			gridMove(mySheet,row+2,"vOrder","Y");
			break;
		case "popdt":			// 분류 선택 팝업        
			var url = "<c:url value="/admin/opendt/openCateParListPopUp.do"/>" + "?cateGb=2&cateIdTop="+$("input[name=sysLang]").val();
			var popup = OpenWindow(url,"openCateParListPopUp","700","550","yes");	
			popup.focus();
			break;
	}           
}       

function setOrder(objId){

	var order = 1;
	var tmpOrder = "";
	for(var i=1; i<=objId.LastRow(); i++){
		tmpOrder= "vOrder";
		objId.SetCellValue(i,tmpOrder, order);
		order++;
	};
}

function setDsId(){
	alert("1");
	var classObj = $("."+"content"); //tab으로 인하여 form이 다건임
	//var objTab = getTabShowObj(); //탭이 oepn된 객체가져옴
	var formObj = classObj.find("form[name=adminOpenMetaOrderMain]");    
	var sheetObj =formObj.find("input[name=ibSheetRow]").val();  
	//var sheetObj2=sheetObj+"table";
	var sheetObj2 = "mySheet";
	var gridObj2 = window[sheetObj2];
	var infId=formObj.find("[name=infId]").val();
	var status;
	for(var i=1; i<=gridObj2.LastRow(); i++){
		tmpOrder= "infId";
		gridObj2.SetCellValue(i,tmpOrder, infId);
		status=gridObj2.GetCellValue(i,"status");
		if(status == "U") gridObj2.SetCellValue(i,"status", "R");		
	};	
}


function inputEnterKey(){
	var formObj = $("form[name=adminOpenMetaOrderMain]");
	formObj.find("input[name=serVal]").keypress(function(e) {                   
		  if(e.which == 13) {
			  doAction('search');   
			  return false; 
		  }
	});
}
function OnSaveEnd(){
	doAction("search");                 
}


function mySheet_OnSearchEnd(code, msg)
{
    if(msg != "")
	{
	    alert(msg);
    }else{
			mySheet.ShowTreeLevel(-1);
    }
}

// 맞춤구분에 따른 분류 값 변경
$(function(){
	$('input[name=cd]').change(function(){
		var radio_val = $(this).val();
		if(radio_val == "L"){
			$('.cateCd').html("<c:forEach var='code' items='${codeMap.saCd}' varStatus='status'> <option value='${code.ditcCd}'>${code.ditcNm}</option> </c:forEach>");
			doAction("search");
		} else if (radio_val == "T"){
			$('.cateCd').html("<c:forEach var='code' items='${codeMap.themeCd}' varStatus='status'> <option value='${code.ditcCd}'>${code.ditcNm}</option> </c:forEach>");
			doAction("search");
		}
	});
});

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
			
			
			
			<!-- 리스트(트리) -->   
			<div class="content">
				<form name="adminOpenMetaOrderMain"  method="post" action="#">
				<input type="hidden" name="ibSheetRow" value=""/>
				<input type="hidden" name="vOrder" value=""/>
				<input type="hidden" name="sysLang" value=""/>
				<table class="list01">
					<caption>보유데이터목록리스트</caption>
					<colgroup>
						<col width="150"/>
						<col width=""/>
						<col width="150"/>
						<col width=""/>
					</colgroup>  
					<tr>
				<th>맞춤구분</th>
				<td>
					
								<input type="radio"  name=cd value="L" checked="checked"/>       
								<label for="themeCate">생애주기</label>&nbsp&nbsp&nbsp&nbsp                   
								<input type="radio"  name="cd" value="T" /> 
								<label for="themeCate">테마</label>&nbsp&nbsp&nbsp&nbsp
				</td>	
				<th>분류</th>
									<td colspan="3">
									<select name="cateCd" class="cateCd">
									<%-- <option value=""><spring:message
											code="labal.allSelect" /></option> --%>
									 <c:forEach var="code" items="${codeMap.saCd}"
										varStatus="status">
										<option value="${code.ditcCd}">${code.ditcNm}</option>
									</c:forEach>
									<%--<c:forEach var="code" items="${codeMap.themeCd}"
										varStatus="status">
										<option value="${code.ditcCd}">${code.ditcNm}</option>
									</c:forEach> --%>
							</select>
							<button type="button" class="btn01B" name="btn_inquiry">
									<spring:message code="btn.inquiry" />
								</button>
							</td>
							
			</tr> 
					<%-- <tr>
						<th><spring:message code='labal.cateNm'/></th>
						<td>
							<input type="hidden" name="cateId" value="" />  
							<input type="text" name="cateNm" value="" readonly sizemaxlength="6" style="width: 200px;"/>
							<!-- <button type="button" class="btn01B" name="btn_search">검색</button> -->
							<!-- <button type="button" class="btn01B" name="btn_inquiry">조회</a> -->
							${sessionScope.button.btn_search}
							<button type="button" class="btn01" name="btn_init">초기화</button>
							${sessionScope.button.btn_inquiry}
							
						</td>
					</tr>    --%>
					<%-- <tr>
				<th>구분</th>
			 <td>
					<select class="" name="dsCd">
	                 	<option value="">선택</option>
						<c:forEach var="code" items="${codeMap.dsCd}" varStatus="status">
						  <option value="${code.ditcCd}">${code.ditcNm}</option>
						</c:forEach>
					</select>
				</td> 
			</tr> --%>
					<%-- <tr>
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
					</td>
				</tr> --%>
				</table>		
				
				
						<script type="text/javascript">createIBSheet("mySheet", "100%", "300px"); </script>             
					<div class="buttons" style="margin-right:15px;">
						${sessionScope.button.a_up}
						${sessionScope.button.a_down}
						${sessionScope.button.a_modify}
						<!-- 
						<a href="#" class="btn03" title="위로" name="a_up">위로이동</a>
						<a href="#" class="btn03" title="아래로" name="a_down">아래로이동</a>
						<a href="#" class="btn03" title="수정" name="a_modify">수정</a>
						 -->
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