<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ page import="egovframework.common.WiseOpenConfig"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="validator"
	uri="http://www.springmodules.org/tags/commons-validator"%>
<%
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><spring:message code='wiseopen.title' /></title>
<c:import url="/WEB-INF/jsp/inc/headinclude.jsp" />
<!--
	validate 사용시 반드시 선언
	formName명과 validate 함수명이 연결되어있음
	adminCommUsr -> validateAdminCommUsr 체크함
	resources/validator/*.* xml을 만들어서 사용
  -->
<%-- <validator:javascript formName="adminCommUsr" staticJavascript="false"
	xhtml="true" cdata="false" /> --%>
</head>
<script language="javascript">              
//<![CDATA[                              
function tabSet(){ //탭 객체 생성  
	openTab = new OpenTab(tabId,tabContentClass,tabBody); //headinclude.jsp 변수 있음
	openTab.TabObj = openTab;  
	openTab.addTabClickEvent();            
}	   
        
$(document).ready(function()    {    
	
	Btn_Set();
	LoadPage();			//메인 sheet   
	buttonEventAdd();                                  
	
	doAction('search');	//조회  
	
	inputEnterKey();	//엔터키       
	
	$("button[name=btn_reg]").click(function(e) {	doAction("reg");	return false;	});
	$("button[name=btn_orgSearch]").click(function(e) {	doAction("orgPop");	return false;	});
	$("button[name=btn_searchWd]").click(function(e) {	doAction("search");	return false;	});
	$("button[name=btn_search]").click(function(e) {	doAction("orgPop2");	return false;	}); //부서검색 main에서..orgPop2
	$("select[name=notiStartHh]").val("09");
	$("select[name=notiEndHh]").val("18");
});                                                       


/****************************************************************************************************
 * Main 관련
 ****************************************************************************************************/
// Setting
 

function LoadPage()                
{      
	//message-common_ko_KR.properties 선언 후 사용 or message-common_en_US.properties 선언 후 사용
	var gridTitle = "NO"
		gridTitle +="|"+"<spring:message code='labal.usrCd'/>";  
		gridTitle +="|"+"<spring:message code='labal.usrNm'/>";        
		//gridTitle +="|"+"<spring:message code='labal.usrNmEng'/>";        
		gridTitle +="|"+"소속기관";               
		gridTitle +="|"+"부서(팀)";
		gridTitle +="|"+"부서(팀)전체명";    
		gridTitle +="|"+"직책코드";
		gridTitle +="|"+"직책";
		gridTitle +="|"+"<spring:message code='labal.usrEmail'/>";          
		gridTitle +="|"+"연락처";              
		gridTitle +="|"+"<spring:message code='labal.accYn'/>";        
		gridTitle +="|"+"<spring:message code='labal.accCd'/>";        
		gridTitle +="|"+"<spring:message code='labal.useYn'/>";        
	
    with(mysheet){
    	                     
    	var cfg = {SearchMode:3,Page:50,VScrollMode:1};                                
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
					 {Type:"Seq",			SaveName:"seq",					Width:70,		Align:"Center",		Edit:false}
					,{Type:"Text",			SaveName:"usrCd",				Width:0,			Align:"Center",		Edit:false,		Hidden:true}
					,{Type:"Text",			SaveName:"usrNm",				Width:150,		Align:"Left",			Edit:false}
					,{Type:"Text",			SaveName:"orgNm",				Width:100,		Align:"Left",			Edit:false}
					,{Type:"Text",			SaveName:"deptNm",				Width:100,		Align:"Left",			Edit:false}
					,{Type:"Text",			SaveName:"deptFullnm",			Width:200,		Align:"Left",			Edit:false}
					,{Type:"Text",			SaveName:"jobCd",				Width:100,		Align:"Left",			Edit:false,	Hidden:true}
					,{Type:"Text",			SaveName:"jobNm",				Width:100,		Align:"Left",			Edit:false}
					,{Type:"Text",			SaveName:"usrEmail",			Width:120,			Align:"Left",		Edit:false}
					,{Type:"Text",			SaveName:"usrTel",				Width:100,		Align:"Left",			Edit:false}
					,{Type:"CheckBox",	SaveName:"accYn",				Width:70,		Align:"Center",		Edit:false,		TrueValue:"Y", FalseValue:"N"}
					,{Type:"Combo",		SaveName:"accCd",				Width:0,			Align:"Left",			Edit:false,		Hidden:true}
					,{Type:"CheckBox",	SaveName:"useYn",				Width:70,		Align:"Center",		Edit:false }
                ];       
      	
        InitColumns(cols);                                                                           
        FitColWidth();                                                         
        SetExtendLastCol(1);   
    }               
    default_sheet(mysheet);                      
}    

/* 메인 이벤트 */
 function mysheet_OnSearchEnd(code, msg)
{
   if(msg != "") {	alert(msg);}
} 

function OnSaveEnd2() {	
	location.reload();
	}           

function inputEnterKey(){
	$("input").keypress(function(e) {
		  if(e.which == 13) {
			  doAction('search');   
			  return false;
		  }
	});
}  

/* 엔터조회 조직명 검색*/
// function orgInputEnterKey(){
// 	$("#orgNm1").keypress(function(e) {
// 		  if(e.which == 13) {
// 			  doAction('orgPop2');   
// 			  return false;
// 		  }
// 	});
// }

// function hpYnCheck(){ //문자메세지 수신동의 체크 Y/N
// 	  $("input:checkbox[name=hpYn]").change(function(){ 
// 		  if( $("input:checkbox[name=hpYn]").is(":checked") ){ //수신동의 했을때 Y
// 			  $("input:checkbox[name=hpYn]").attr("checked",true);
// 			  $("input:checkbox[name=hpYn]").val("Y");
// 		  }else{
// 			  $("input:checkbox[name=hpYn]").attr("checked",false);
// 			  $("input:checkbox[name=hpYn]").val("N");
// 		  }
// 	  });
//   }


function Btn_Set(){
	   $("a[name=a_modify]").hide();
	   $("a[name=a_del]").hide();
	   $("a[name=a_reg]").show();
}

// sheet 더블클릭
function mysheet_OnDblClick(row, col, value, cellx, celly) {
    if(row == 0) return;     
   
    $("a[name=a_modify]").show();
    $("a[name=a_del]").show();
    $("a[name=a_reg]").hide();
    
    var url = "<c:url value='/admin/basicinf/commUsrList.do'/>";
    var param = "usrCd= " + mysheet.GetCellValue(row,"usrCd");
    
    ajaxBeforeSendAdmin("<c:url value='/admin/ajaxBeforeSendAdmin.do'/>"); //IbSheet 조회전 세션 체크
    ajaxCallAdmin(url, param, tabFunction);
    //buttonEventAdd();                
} 

// Main Action                  
function doAction(sAction)                                  
{
	var classObj = $(".content").eq(0); //tab으로 인하여 form이 다건임
	var actObj = setTabForm(classObj); // 0: form data, 1: form 객체
	switch(sAction)
	{          
		case "search":      //조회   
			ajaxBeforeSendAdmin("<c:url value='/admin/ajaxBeforeSendAdmin.do'/>"); //IbSheet 조회전 세션 체크
			var param = {PageParam: "ibpage", Param: "onepagerow=50&"+actObj[0]};
			mysheet.DoSearchPaging("<c:url value='/admin/basicinf/commUsrListAll.do'/>",param);
			break;

		case "reg": //등록화면
			 $("form[name=adminOpenDt]")[0].reset();
	         Btn_Set(); //버튼 초기화
	         param = ""; //초기화
			break;

		case "orgPop": // 조직 팝업
			var popup = OpenWindow("<c:url value="/admin/basicinf/popup/commOrg_pop.do"/>"+ "?orgNmGb=8","orgPop", "500", "550", "yes")// +  "?index=1&";
			break;

		case "orgPop2": // 조직 팝업
			//var param = "?linkSearch=" + $("#orgNm1").val(); //입력하여 조직부서 검색방법.
			var url = "<c:url value="/admin/basicinf/popup/commOrg_pop.do"/>" +  "?index=0";
			var popup = OpenWindow(url, "orgPop", "500", "550", "yes");
			break;

		}
	}

	/****************************************************************************************************
	 * Tab 관련
	 ****************************************************************************************************/

	// 탭 추가 시 버튼 Setting
	function setTabButton() {
		var classObj = $("." +"content"); //tab으로 인하여 form이 다건임
		$("input, textarea").placeholder();
		var formObj = classObj.find("form[name=adminCommUsr]");

		// 수정
		formObj.find("a[name=a_modify]").eq(0).click(function() {
			doActionTab("update");
			return false;
		});

		// 등록
		formObj.find("a[name=a_reg]").eq(0).click(function() {
			doActionTab("save");
			return false;
		});

		// 삭제
		formObj.find("a[name=a_del]").eq(0).click(function() {
			doActionTab("delete");
			return false;
		});

		// 한글이름 한글만
		formObj.find("input[name=usrNm]").keyup(function(e) {
			ComInputKorObj(formObj.find("input[name=usrNm]"));
			return false;
		});
		// 영문이름 영문, 공백
		formObj.find("input[name=usrNmEng]").keyup(function(e) {
			ComInputEngBlankObj(formObj.find("input[name=usrNmEng]"));
			return false;
		});
		// 영문이름 영문, 공백
		formObj.find("input[name=emailId]").keyup(function(e) {
			ComInputEngEtcObj(formObj.find("input[name=emailId]"));
			return false;
		});
		// 이메일도메인 dot만 찍히게
		formObj.find("input[name=emailDomain]").keyup(function(e) {
			ComInputEngDcmObj(formObj.find("input[name=emailDomain]"));
			return false;
		});
		//전화번호 숫자만
		formObj.find("input[name=midUsrTel]").keyup(function(e) {
			ComInputNumObj(formObj.find("input[name=midUsrTel]"));
			return false;
		});
		formObj.find("input[name=lastUsrTel]").keyup(function(e) {
			ComInputNumObj(formObj.find("input[name=lastUsrTel]"));
			return false;
		});
		formObj.find("input[name=midUsrHp]").keyup(function(e) {
			ComInputNumObj(formObj.find("input[name=midUsrHp]"));
			return false;
		});
		formObj.find("input[name=lastUsrHp]").keyup(function(e) {
			ComInputNumObj(formObj.find("input[name=lastUsrHp]"));
			return false;
		});
		
		formObj.find("button[name=btn_dup]").click(function(e) {
			doActionTab("dup");                                               
			return false;                  
		});

		// 초기화
		formObj.find("a[name=a_init]").click(function() {
			doActionTab("init");
			return false;
		});
	}

	/* Tab Event */

	//탭 추가 시 버튼 이벤트
	function buttonEventAdd() {
		setTabButton();
	}

	// 탭 추가 이벤트
	function tabEvent(row) {
		var title = mysheet.GetCellValue(row, "usrNm");//탭 제목                                           
		var id = mysheet.GetCellValue(row, "usrCd");//탭 id(유일한key))
		openTab.SetTabData(mysheet.GetRowJson(row));//db data 조회시 조건 data
		var url = "<c:url value='/admin/basicinf/commUsrList.do'/>"; // Controller 호출 url              
		openTab.addTab(id, title, url, tabFunction); // 탭 추가 시작함(callback함수 overring)
		buttonEventAdd();
	}

	// Tab 조회콜백
	function tabFunction(json) {
		//tab.ContentObj.find("a[name=a_reg]").hide();
		
		var classObj = $("."+"content").eq(1); //tab으로 인하여 form이 다건임
		var formObj = classObj.find("form[name=adminCommUsr]");
		
		$.each(json.DATA[0], function(key, state) {
			// 사용 미사용여부 선택
			if (key == "useYn") {
				formObj.find(
						"input:radio[name=useYn][value=" + state + "]").attr(
						"checked", "checked");
				// 수신동의 체크
			} else if (key == "emailYn") {
				if (state == "Y")
					formObj.find("input:checkbox[name=emailYn]").attr(
							"checked", true);
				else
					formObj.find("input:checkbox[name=emailYn]").attr(
							"checked", false);
			} else if (key == "hpYn") {
				if (state == "Y")
					formObj.find("input:checkbox[name=hpYn]").attr(
							"checked", true);
				else
					formObj.find("input:checkbox[name=hpYn]").attr(
							"checked", false);
			} else if (key == "orgNm") {
				formObj.find("input[name=orgCdTopNm]").val(state);
			} else if (key == "deptNm") {
				formObj.find("input[name=orgNm]").val(state);	
			} else {
				formObj.find("[name=" + key + "]").val(state);
			}

		});
	}

	//Tab action
	function doActionTab(sAction) {
	
		var classObj = $("." +"content").eq(1); //tab으로 인하여 form이 다건임
		var actObj = setTabForm(classObj); // 0: form data, 1: form 객체
		//var objTab = getTabShowObj();//탭이 oepn된 객체가져옴
		var formObj = classObj.find("form[name=adminCommUsr]");
		ajaxBeforeSendAdmin("<c:url value='/admin/ajaxBeforeSendAdmin.do'/>"); //IbSheet 조회전 세션 체크
		//var gridObj = window[sheetObj];
		
		switch (sAction) {
		
		case "save": // 신규등록
			/*  if (!validateAdminCommUsr(actObj[1])) { //validation 체크         
				return;
			}  */
			
			/* if(formObj.find("input[name=emailDomain]").val("")){
				alert("이메일 정보를 등록하셔야합니다.");
				return false;
			} */
			if(validationChk(formObj)) {
				var url = "<c:url value='/admin/basicinf/commUsrReg.do'/>";
			
				var param = formObj.serialize();
				
				ajaxCallAdmin(url, param, saveCallBackUsr);
				
				location.reload();

			}
			//doAction('search');
			
			break;

		case "update": // 수정
			if (!confirm("수정 하시겠습니까? ")) {
				return;
			}

			if(validationChk(formObj)) {
				var url = "<c:url value='/admin/basicinf/commUsrUpd.do'/>";
				var param = formObj.serialize();
				ajaxCallAdmin(url, param, saveCallBackUsr);
			}
			break;

		case "delete": // 삭제
			if (!confirm("삭제 하시겠습니까? ")) {
				return;
			}
			var url = "<c:url value='/admin/basicinf/commUsrDel.do'/>";
			var param = formObj.find("[name=usrCd]").serialize();
			ajaxCallAdmin(url, param, saveCallBackUsr);
			
			break;
			
		case "init":
			
			formObj.find("select[name=jobCd]").val("");	
			formObj.find("input[name=usrNm]").val("");
			formObj.find("input[name=orgCd]").val("");
			formObj.find("input[name=orgCdTopNm]").val("");
			formObj.find("input[name=orgNm]").val("");
			formObj.find("input[name=emailId]").val("");
			formObj.find("input[name=emailDomain]").val("");
			formObj.find("select[name=firUsrTel]").val("");
			formObj.find("input[name=midUsrTel]").val("");
			formObj.find("input[name=lastUsrTel]").val("");
			formObj.find("select[name=firUsrHp]").val("");
			formObj.find("input[name=midUsrHp]").val("");
			formObj.find("input[name=lastUsrHp]").val("");
			formObj.find("select[name=useYn]").val("Y");
			formObj.find("input[name=emailYn]").val("");		
			formObj.find("input[name=usrWork]").val("");		
			formObj.find("select[name=notiStartHh]").val("09");
			formObj.find("select[name=notiEndHh]").val("18");
		
			
			
			
			Btn_Set();
			
			break;
			
		/*  case "dup":
			
			if(nullCheckValdation(formObj.find('input[name=usrNm]'),"직원명","")){
				return false;
			}	
			if(nullCheckValdation(formObj.find('input[name=usrId]'),"관리자 ID","")){
				return false;
			}
			if ( formObj.find('input[name=usrId]').val().length < 5 | formObj.find('input[name=usrId]').val().length > 20 ) {
				alert("5자 이상 20자 이내로 입력해 주세요.");
				formObj.find('input[name=usrId]').val("");
				return false;
			}
			var url = "<c:url value='/admin/basicinf/commUsrAdminUsrIdDup.do'/>"; 
			ajaxCallAdmin(url,actObj[0],dupCallBack);
			break; */	
			
		}
		
	}
	
		//직원정보용 saveCallBack
	function saveCallBackUsr(res){      
    	alert(res.RESULT.MESSAGE);
    	
    	OnSaveEnd2();
 
	}

	function validationChk(formObj) {
		
		if(formObj.find("input[name=usrNm]").val() == "") {
			alert("직원명은 필수입니다.");
			return false;
		}
		
		if(formObj.find("input[name=jobCd]").val() == "") {
			alert("직책은 필수입니다.");
			return false;
		}

		if(formObj.find("input[name=orgCd]").val() == "") {
			alert("소속기관은 필수입니다.");
			return false;
		}

		if(formObj.find("input[name=deptNm]").val() == "") {
			alert("부서는 필수입니다.");
			return false;
		}

		if(formObj.find("input[name=emailId]").val() == "" || formObj.find("input[name=emailDomain]").val() == "") {
			alert("이메일은 필수입니다.");
			return false;
		}
		
		if(formObj.find("select[name=firUsrTel]").val() == "" || formObj.find("input[name=midUsrTel]").val() == "" || formObj.find("input[name=lastUsrTel]").val() == "") {
			alert("연락처는 필수입니다.");
			return false;
		}
		
		if(formObj.find("select[name=notiStartHh]").val() > formObj.find("select[name=notiEndHh]").val()) {
			alert("알림시간이 잘못되었습니다.");
			return false;
		}
		
		return true;
	}
		
	//]]>
</script>
</head>
<body onload="">
	<div class="wrap">
		<c:import url="/admin/admintop.do" />
		<!-- 내용 -->
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
					<li><a href="#">공공데이터목록asdfsdfsfsdfsdfsdf</a><a href="#" class="line_close">x</a></li>
				</ul>
			</div>
			
		
			<!-- 목록내용 -->
			<div class="content">
				<form name="adminCommUsr" method="post" >
					<table class="list01">
						<caption>직원정보관리</caption>
						<colgroup>
							<col width="150" />
							<col width="" />
						</colgroup>
						<tr>
							<th>직원명</th>
							<td><%-- <select name="searchWd">
									<option value=""><spring:message code="etc.select" /></option>
									<option value="1" selected="selected"><spring:message code="labal.usrNm" /></option>
									
							</select>  --%><input type="text" name="searchWord" value="" style="width: 300px" />
							</td>
						</tr>
						<tr>
							<th>소속기관</th>
							<td>
								<!-- 							<input type="text" name="searchOrg" value="" placeholder="한글"/> -->
								<input type="text" id="orgNm1" name="orgNm" value="" readonly = "readonly" /> <input type="hidden" id="orgCd1" name="orgCd" value="" />
								<button type="button" class="btn01" name="btn_search">검색</button>
							</td>
						</tr>
						<tr>
							<th><spring:message code="labal.useYn" /></th>
							<td><input type="radio" name="useYn" /> <label for="useAll"><spring:message
										code="labal.whole" /></label> <input type="radio" name="useYn"
								value="Y" checked="checked" /> <label for="use"><spring:message
										code="labal.yes" /></label> <input type="radio" name="useYn" value="N" />
								<label for="unuse"><spring:message code="labal.no" /></label>
								 <button type="button" class="btn01B" name="btn_searchWd" style="margin-left:10px;">
									<spring:message code="btn.inquiry" />
								</button> </td>
						</tr>
						
					
					</table>
					
				</form>
				<!-- ibsheet 영역 -->
				   <div style="clear: both;"></div>
					<div class="ibsheet_area_both">
          			  <script type="text/javascript">createIBSheet("mysheet", "100%", "300px"); </script>             
        		   </div>
			</div>
			
			<!-- 탭 내용 -->
			<div class="content" style="min-height:235px;">
				<form name="adminCommUsr"  method="post" action="#">
				<input type="hidden" name="sheetNm"/>
				<input type="hidden" name="usrCd" value="0"/>
				
				<table class="list01">
					<caption>직원정보관리</caption>
					<colgroup>
						<col width="150"/>
						<col width=""/>
						<col width="150"/>
						<col width=""/>
					</colgroup>
					<tr>
						<th><spring:message code="labal.usrNm"/> <span>*</span></th>
						<td>
							<input type="text" name="usrNm" maxlength="30" value="" />
							
						</td>
						<th><spring:message code="labal.job"/> <span>*</span></th>
						<td>
							<select class="" name="jobCd">
							<c:forEach var="code" items="${codeMap.jobCd}" varStatus="status">
							  <option value="${code.ditcCd}">${code.ditcNm}</option>
							</c:forEach>
							<!-- <input type="text" name="jobCd" maxlength="10" value="" /> -->
						</select>
						</td>
					</tr>
					<tr>
						<th>소속기관 <span>*</span></th>
						<td>
							<input type="text" name="orgCdTopNm" value="" class="readonly"  readonly="readonly"/>
							<button type="button" class="btn01" name="btn_orgSearch">
								<spring:message code="btn.search"/>
							</button>
						</td>
						<th>부서 <span>*</span></th>
						<td>
							<input type="hidden" name="orgCd" value="" />
							<input type="text" name="orgNm" value="" maxlength="30" class="readonly"  readonly="readonly"/>
						</td>
					</tr>
					<tr>
						<th><spring:message code="labal.usrEmail"/> <span>*</span></th>
						<td colspan="3">
							<input type="text" name="emailId" maxlength="20" value=""/>
							@
							<input type="text" name="emailDomain"  maxlength="20" value=""/><%-- 
							<input type="checkbox" name="emailYn"/>
							<label for="agree"><spring:message code="labal.emailYn"/></label> --%>
						</td>
					</tr>
					<tr>
						<th>연락처 <span>*</span></th>
						<td>
							<select name="firUsrTel">
								<c:forEach var="code" items="${codeMap.usrTel}" varStatus="status">
										<option value="${code.ditcCd}">${code.ditcNm}</option>
								</c:forEach>
							</select>
							<input type="text" name="midUsrTel" value="" size="6" maxlength="4"/>
							<input type="text" name="lastUsrTel" value="" size="6" maxlength="4"/>
						</td>
						<th>휴대전화</th>
						<td>
							<select name="firUsrHp">
								<option value="">선택</option>
								<c:forEach var="code" items="${codeMap.usrHp}" varStatus="status">
										<option value="${code.ditcCd}">${code.ditcNm}</option>
								</c:forEach>
							</select>
							<input type="text" name="midUsrHp" value="" size="6" maxlength="4"/>
							<input type="text" name="lastUsrHp" value="" size="6" maxlength="4"/><!-- 
							<input type="checkbox" name="hpYn"/>
							<label for="sms"> 문자메세지 수신동의</label> -->
						</td>
					</tr>
					
				<%-- <tr>
						<th><spring:message code="labal.adminId"/> <span>*</span></th>
						<td >
							<!-- 관리자ID -->
							<input type="text" name="usrId" value="" style="width: 200px;" maxlength="20"/>
							<button type="button" class="btn01" name="btn_dup">
								<spring:message code="btn.dup"/>	<!-- 중복확인 -->
							</button>
							영문, 숫자 5자이상 ~ 20자 이내
						</td>
					
						<th><spring:message code="labal.pwd"/> <span>*</span></th>
						<td>
							<input type="password" name="usrPw" value="" style="width: 200px;" autocomplete="off"/>
						</td>					
					</tr> --%>
					<tr>
						<th>알림시간</th>
						<td>
							<select name="notiHhCd">
								<c:forEach var="code" items="${codeMap.notiHhCd}" varStatus="status">
									<c:choose> 
										<c:when test="${code.ditcCd == Usr.notiHhCd}">
											<option value="${code.ditcCd}" selected="selected">${code.ditcNm}</option>
										</c:when>
										<c:otherwise>
												<option value="${code.ditcCd}">${code.ditcNm}</option>
										</c:otherwise>
									</c:choose>
								</c:forEach>
							</select>
							<select name="notiStartHh">
								<c:forEach var="hh" begin="0" end="23" varStatus="status">
									<fmt:formatNumber var="no" value="${hh}" pattern="00"/>
									<c:choose> 
										<c:when test="${no == Usr.notiStartHh }">
											<option value="${no}" selected="selected">${no}시</option>
										</c:when>
										<c:otherwise>
											<option value="${no}">${no}시</option>
										</c:otherwise>
									</c:choose>
								</c:forEach>
							</select>
							<select name="notiEndHh">
								<c:forEach var="hh" begin="0" end="23" varStatus="status">
									<fmt:formatNumber var="no" value="${hh}" pattern="00"/>
									<c:choose> 
										<c:when test="${no == Usr.notiEndHh }">
											<option value="${no}" selected="selected">${no}시</option>
										</c:when>
										<c:otherwise>
											<option value="${no}">${no}시</option>
										</c:otherwise>
									</c:choose>
								</c:forEach>
							</select>
						</td>
						<th>담당업무</th>
						<td>
							<input type="text" name="usrWork" value="${Usr.usrWork}"  maxlength="100"/>
						</td>
					</tr>
					<tr>
						<th><spring:message code="labal.useYn"/></th>
						<td colspan="3">
							<input type="radio" name="useYn" value="Y" class="input" checked/>
							<label for="use"><spring:message code="labal.yes"/></label>
							<input type="radio" name="useYn" value="N" class="input"/>
							<label for="unuse"><spring:message code="labal.no"/></label>
						</td>
					</tr>
				</table>	
				
				<div class="buttons">
					${sessionScope.button.a_init}
					${sessionScope.button.a_reg}
					${sessionScope.button.a_modify}
					${sessionScope.button.a_del}
				</div>
				</form>
			</div>
	</div>
	</div>
	<iframe name="iframePopUp" scrolling="no" frameborder="0"
		style="display: none; position: absolute;" src="" />
	<!--##  푸터  ##-->
	<c:import url="/WEB-INF/jsp/admin/adminfooter.jsp" />
	<!--##  /푸터  ##-->
</body>
</html>