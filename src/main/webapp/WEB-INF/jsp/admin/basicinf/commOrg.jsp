<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ page import="egovframework.common.WiseOpenConfig"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
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
	adminCommOrg -> validateAdminCommOrg 체크함
	resources/validator/*.* xml을 만들어서 사용
  -->
<validator:javascript formName="adminCommOrg" staticJavascript="false"
	xhtml="true" cdata="false" />
</head>
<script language="javascript">
	//<![CDATA[                              
	/* function tabSet() { //탭 객체 생성  
		openTab = new OpenTab(tabId, tabContentClass, tabBody); //headinclude.jsp 변수 있음
		openTab.TabObj = openTab;
		openTab.addTabClickEvent();
	} */

	$(document).ready(function() {
		setMainButton(); //메인 버튼
		setTabButton();		//탭 버튼
		LoadPage(); //메인 sheet                                                                 
		doAction('search'); //조회                                              
		inputEnterKey(); //엔터키       
		Btn_Set();
		//tabSet();			//tab 셋팅
	});
	
	function Btn_Set() { //버튼 초기화 함수
		   
		   $("a[name=a_reg]").show();
		   $("a[name=a_reset]").show();
		   
		   $("a[name=a_modify]").hide();
		   $("a[name=a_del]").hide();
		   
	}

	/****************************************************************************************************
	 * Main 관련
	 ****************************************************************************************************/
	// Setting
	function setMainButton() {
		var formObj = $("form[name=adminCommOrg]");
		$("button[name=btn_reg]").click(function(e) {
			doAction("reg");
			return false;
		});
		$("button[name=btn_searchWd]").click(function(e) {
			// 		if ( $("input[name=searchWord]").val() == "" ) {
			// 			alert("검색어를 입력하세요."); return;
			// 		} else if ( $("select[name=searchWd]").val() == "" ) {
			// 			alert("검색항목을 선택하세요."); return;
			// 		}
			doAction("search");
			return false;
		});
		$("#obj_open").change(function(e) { //수정
			if (inputCheckYn("obj_open") == "Y") {
				mySheet1.ShowTreeLevel(-1);
			} else {
				mySheet1.ShowTreeLevel(0, 1);
			}
			return false;
		});

		$("a[name=a_up]").click(function(e) { //위로이동
			doAction("treeUp");
			return false;
		});
		$("a[name=a_down]").click(function(e) { //아래로이동
			doAction("treeDown");
			return false;
		});

		formObj.find("a[name=a_save]").click(function(e) {
			doAction("updateTreeOrder");
			return false;
		});
	}

	function LoadPage() {
		//message-common_ko_KR.properties 선언 후 사용 or message-common_en_US.properties 선언 후 사용
		var gridTitle = "NO"
		gridTitle += "|" + "<spring:message code='labal.status'/>";
		gridTitle += "|" + "<spring:message code='labal.orgCd'/>";
		gridTitle += "|" + "<spring:message code='labal.orgNm'/>";
		gridTitle += "|" + "<spring:message code='labal.orgTypeCd'/>";
		gridTitle += "|" + "<spring:message code='labal.orgTypeNm'/>";
		gridTitle += "|" + "<spring:message code='labal.useYn'/>";
		gridTitle += "|" + "<spring:message code='labal.orglvl'/>";
		gridTitle += "|" + "<spring:message code='labal.vOrder'/>";

		with (mySheet1) {

			var cfg = {
				SearchMode : 2,
				Page : 50,
				VScrollMode : 1
			};
			SetConfig(cfg);
			var headers = [ {
				Text : gridTitle,
				Align : "Center"
			} ];
			var headerInfo = {
				Sort : 0,
				ColMove : 1,
				ColResize : 1,
				HeaderCheck : 0
			};

			InitHeaders(headers, headerInfo);

			//문자는 왼쪽정렬
			//숫자는 오른쪽정렬
			//코드값은 가운데정렬
			var cols = [ {
				Type : "Seq",
				SaveName : "seq",
				Width : 20,
				Align : "Center",
				Edit : false
			}, {
				Type : "Status",
				SaveName : "status",
				Width : 30,
				Align : "Center",
				Edif : false,
				Hidden : false
			}, {
				Type : "Text",
				SaveName : "orgCd",
				Width : 60,
				Align : "Center",
				Edit : false
			}, {
				Type : "Text",
				SaveName : "orgNm",
				Width : 150,
				Align : "Left",
				Edit : false,
				TreeCol :1
			}, {
				Type : "Text",
				SaveName : "orgTypeCd",
				Width : 100,
				Align : "Center",
				Edit : false,
				Hidden : true
			}, {
				Type : "Text",
				SaveName : "orgTypeNm",
				Width : 100,
				Align : "Left",
				Edit : false
			}, {
				Type : "CheckBox",
				SaveName : "useYn",
				Width : 30,
				Align : "Center",
				Edit : false
			}, {
				Type : "Text",
				SaveName : "orgLvl",
				Width : 30,
				Align : "Center",
				Edit : false,
				Hidden : true
			},  {
				Type : "Text",
				SaveName : "vOrder",
				Width : 30,
				Align : "Center",
				Edit : false,
				Hidden : false
			}

			];

			InitColumns(cols);
			FitColWidth();
			SetExtendLastCol(1);
		}
		default_sheet(mySheet1);
		mySheet1.SetCountPosition(0);
	}

	/* 메인 이벤트 */
	function mySheet1_OnSearchEnd(code, msg) {
		if (msg != "") {
			alert(msg);
		} else {
			mySheet1.ShowTreeLevel(0, 1);
		}
	}

	function OnSaveEndOrg() {
		
		//doAction("search");
		//$("#obj_open").attr("checked", false);
		location.reload();
	}

	function inputEnterKey() {
		$("input").keypress(function(e) {
			if (e.which == 13) {
				doAction('search');
				return false;
			}
		});
	}

	// Main Action                  
	function doAction(sAction) {
		var classObj = $("." + "content").eq(0); //tab으로 인하여 form이 다건임
		var actObj = setTabForm(classObj); // 0: form data, 1: form 객체
		switch (sAction) {
		case "search": //조회   
			ajaxBeforeSendAdmin("<c:url value='/admin/ajaxBeforeSendAdmin.do'/>"); //IbSheet 조회전 세션 체크
			mySheet1.DoSearch(
					"<c:url value='/admin/basicinf/commOrgListTree.do'/>", actObj[0]);
			break;
		case "reg": //등록화면
			var title = "등록하기";
			var id = "dsReg";
			openTab.addRegTab(id, title, tabCallRegBack); // 탭 추가 시작함

			break;
		case "treeUp":
			treeUp(mySheet1, true, "vOrder"); // obj, 순서설정플래그, 순서설정컬럼
			break;
		case "treeDown":
			treeDown(mySheet1, true, "vOrder");
			break;
		case "updateTreeOrder":
			if (!confirm("수정 하시겠습니까? ")) {
				return;
			}
			ibsSaveJson = mySheet1.GetSaveJson(0);
			if (ibsSaveJson.data.length == 0) {
				alert("저장할 데이터가 없습니다.");
				return;
			}
			var url = "<c:url value='/admin/basicinf/commOrgListUpdateTreeOrder.do'/>";
			IBSpostJson(url, ibsSaveJson, ibscallback);
			break;
		}
	}

	/****************************************************************************************************
	 * Tab 관련
	 ****************************************************************************************************/
	// 탭 추가 시 버튼 Setting
	function setTabButton() {
		var classObj = $("." + "content").eq(1); //탭이 oepn된 객체가져옴
		var formObj = classObj.find("form[name=adminCommOrg]");
		formObj.find("button[name=btn_dup]").click(function(e) { // 조직코드 중복체크
			
			doActionTab("dup");
			return false;
		});
		formObj.find("input[name=orgCdPar]").change(function(e) { // 상위조직 선택시 상세 항목 표시
			//chgOrgCdParShowHide(formObj);
			if (formObj.find("input[name=orgCdPar]").is(":checked") == true) {
				formObj.find("input[name=orgCdTopCd]").val(""); //최상위조직코드 초기화
				formObj.find("input[name=orgCdTopNm]").val(""); //최상위조직명 초기화
				formObj.find("input[name=orgCdParCd]").val(""); //상위조직코드 초기화
				formObj.find("input[name=orgCdParNm]").val(""); //상위조직명 초기화
				formObj.find("input[name=orgLvl]").val("1"); //레벨 최상위로 설정
			} else {
				formObj.find("select[name=orgType]").val(""); //조직구분 초기화
				formObj.find("input[name=orgLvl]").val(""); //레벨 초기화
			}
		});
		formObj.find("a[name=a_reg]").eq(0).click(function() { // 신규등록
			doActionTab("save");
			return false;
		});
		formObj.find("button[name=btn_orgSearch]").click(function() { // 조직정보 팝업
			doActionTab("orgPop");
			return false;
		});
		formObj.find("a[name=a_del]").eq(0).click(function() { // 삭제
			doActionTab("delete");
			return false;
		});
		formObj.find("a[name=a_modify]").eq(0).click(function() { // 수정
			doActionTab("update");
			return false;
		});
		formObj.find("input[name=orgCd]").keyup(function(e) { // 조직코드 영문, 숫자만 입력                 
			ComInputEngNumObj(formObj.find("input[name=orgCd]"));
			formObj.find("input[name=orgCdDup]").val("N");
			return false;
		});
		formObj.find("input[name=orgNm]").keyup(function(e) { // 한글조직명 특수문자 일부제외하고 전부가능                 
			ComInputKorObj(formObj.find("input[name=orgNm]"));
			return false;
		});
		formObj.find("input[name=orgNmEng]").keyup(function(e) { // 영문조직명 영문, 공백                 
			ComInputEngBlankObj(formObj.find("input[name=orgNmEng]"));
			return false;
		});
		formObj.find("input[name=orgFullNm]").keyup(function(e) { // 전체 한글조직명 특수문자 일부제외하고 전부가능               
			ComInputKorObj(formObj.find("input[name=orgFullNm]"));
			return false;
		});
		formObj.find("input[name=orgFullNmEng]").keyup(function(e) { // 전체 영문조직명 영문, 숫자만 입력                 
			ComInputEngBlankObj(formObj.find("input[name=orgFullNmEng]"));
			return false;
		});
		formObj.find("input[name=orgUrl]").keyup(function(e) { // 조직홈페이지 주소명입력가능        
			ComInputEngUrlObj(formObj.find("input[name=orgUrl]"));
			return false;
		});
		formObj.find("input[name=orgAddr]").keyup(function(e) { // 조직주소 입력 (한)       
			ComInputKorObj(formObj.find("input[name=orgAddr]"));
			return false;
		});
		formObj.find("input[name=orgAddrEng]").keyup(function(e) { // 조직주소 입력 (영)       
			ComInputEngBlankNumBarObj(formObj.find("input[name=orgAddrEng]"));
			return false;
		});
		
		formObj.find("a[name=a_init]").click(function() {
	 		doActionTab("init");          
	 		return false;                 
	 	});
		
		formObj.find("input[name=orgTel]").keyup(function(e) {                 
			ComInputNumDecObj(formObj.find("input[name=orgTel]"));   
	 		return false;                                                                          
	 	});

	}

	/* Tab Event */
	//탭 추가 시 버튼 이벤트
	function buttonEventAdd() {
		setTabButton();
	}

	// 상세보기시 상위조직 체크여부 확인하여 show, hide 설정
	function chgOrgCdParShowHide(formObj) {
		if (formObj.find("input[name=orgCdPar]").is(":checked") == true) {
			formObj.find("tr[id=orgTypeTR]").show();
			formObj.find("tr[id=orgAddrTR]").show();
			formObj.find("tr[id=mngIdTR]").show();
			formObj.find("input[name=orgCdParNm]").hide();
			formObj.find("button[name=btn_orgSearch]").hide();
		} else {
			formObj.find("tr[id=orgTypeTR]").hide();
			formObj.find("tr[id=orgAddrTR]").hide();
			formObj.find("tr[id=mngIdTR]").hide();
			formObj.find("input[name=orgCdParNm]").show();
			formObj.find("button[name=btn_orgSearch]").show();
		}
	}

	//sheet 더블클릭
	function mySheet1_OnDblClick(row, col, value, cellx, celly) {
		if (row == 0)
			return;
		
		   $("a[name=a_reg]").hide();
		   $("a[name=a_reset]").show();
		   
		   $("a[name=a_modify]").show();
		   $("a[name=a_del]").show();
		   
		
		var classObj = $("." + "content").eq(1); //탭이 oepn된 객체가져옴
		var formObj = classObj.find("form[name=adminCommOrg]");
		formObj.find("input[name=orgCdPar]").val();
		
		var param = "orgCd= " + mySheet1.GetCellValue(row, "orgCd");
		var url = "<c:url value='/admin/basicinf/commOrgRetr.do'/>"; // Controller 호출 url
		
		ajaxBeforeSendAdmin("<c:url value='/admin/ajaxBeforeSendAdmin.do'/>"); //IbSheet 조회전 세션 체크
		ajaxCallAdmin(url, param, tabCallBack);
		//doActionTab("search");

	}


	function tabCallBack(json) { //callBack 함수 

		var classObj = $("." + "content").eq(1); //탭이 oepn된 객체가져옴
		var formObj = classObj.find("form[name=adminCommOrg]");

		if (typeof (window["setTabButton"]) == "function") { //탭 이벤트 추가(반드시 선언해서 사용해야함)
		
			//setTabButton();
		}
		if (json.DATA[0] != null) {
			$
					.each(json.DATA[0],
							function(key, state) {
								if (formObj.find("[name=" + key + "]").attr(
										"type") == 'radio') {
									formObj.find(
											"[name=" + key + "]"
													+ ":radio[value='" + state
													+ "']").prop("checked",
											true);
								} else if (formObj.find("[name=" + key + "]")
										.attr("type") == 'checkbox') {
									formObj.find(
											"[name=" + key + "]"
													+ ":checkbox[value='"
													+ state + "']").attr(
											"checked", true);
								} else {
									formObj.find("[name=" + key + "]").val(
											state).change();
								}
							});
		}
		
		tabFunction(json);

	}

	// Tab 조회콜백
	function tabFunction(json) {

		var classObj = $("." + "content").eq(1); //tab으로 인하여 form이 다건임
		var formObj = classObj.find("form[name=adminCommOrg]");
   		
		$.each(json.DATA[0], function(key, state) {

			if (key == "orgCdParCd") {
				if (state == null) { //최상위 항목은 내용 전부 보여준다
					formObj.find("input:checkbox[name=orgCdPar]").attr(
							"checked", true);
					chgOrgCdParShowHide(formObj);
				}
			}
			if (key == "orgTypeCd") {
				formObj.find("select[name=orgType]").val(state);
			}
			// 최상위 항목 레벨변경 불가.
			formObj.find("input:checkbox[name=orgCdPar]")
					.attr("disabled", true);

		});
		// 조직코드, 전체조직명 readonly 처리
		formObj.find("input[name=orgCd]").attr("readonly", true).addClass(
				"readonly", true);
		formObj.find("input[name=orgFullNm]").attr("readonly", true).addClass(
				"readonly", true); 
		formObj.find("input[name=orgFullNmEng]").attr("readonly", true)
				.addClass("readonly", true);
		formObj.find("button[name=btn_dup]").hide();

	}

	// 중복체크 콜백
	function dupCallBack(res) {
		var objTab = getTabShowObj();//탭이 oepn된 객체가져옴
		var formObj = objTab.find("form[name=adminCommOrg]");
		if (res.RESULT.CODE == -1) {
			alert("중복된 조직코드가 존재합니다.");
			formObj.find("input[name=orgCdDup]").val("N");
			formObj.find("input[name=orgCd]").val("");
		} else {
			alert("등록 가능합니다.");
			formObj.find("input[name=orgCdDup]").val("Y");
		}
	}

	//Tab action
	function doActionTab(sAction) {
		var classObj = $("." + "content").eq(1); //tab으로 인하여 form이 다건임
		var actObj = setTabForm(classObj); // 0: form data, 1: form 객체
		var objTab = getTabShowObj();//탭이 oepn된 객체가져옴
		var formObj = classObj.find("form[name=adminCommOrg]");
		ajaxBeforeSendAdmin("<c:url value='/admin/ajaxBeforeSendAdmin.do'/>"); //IbSheet 조회전 세션 체크
		//var gridObj = window[sheetObj];
		switch (sAction) {
		case "dup": // 조직코드 중복확인
			if (nullCheckValdation(formObj.find('input[name=orgCd]'),
					"<spring:message code='labal.orgCd'/>", "")) {
				return true;
			}
			var url = "<c:url value='/admin/basicinf/commOrgCdDup.do'/>";
			ajaxCallAdmin(url, actObj[0], dupCallBack);
			break;

		case "orgPop": // 조직 팝업
			var url = "<c:url value='/admin/basicinf/popup/commOrg_pop.do'/>"
					+ "?orgNmGb=1"
			var popup = OpenWindow(url, "orgPop", "500", "550", "yes");
			break;

		case "save": // 신규등록
			if (!validateAdminCommOrg(actObj[1])) {
				return;
			} //validationXML 체크
			if (validateAdminCommOrgItem(formObj)) {
				return;
			} //validation 체크
			// 최상위조직은 최상위코드가 자기 자신임.
			if (formObj.find('input:checkbox[name=orgCdPar]').is(':checked')) {
				formObj.find('input[name=orgCdTopCd]').val(
						formObj.find('input[name=orgCd]').val());
				formObj.find('input[name=orgCdParCd]').val("");
			}
			
			var url = "<c:url value='/admin/basicinf/commOrgReg.do'/>";
			ajaxCallAdmin(url, actObj[0], saveCallBackOrg);
			break;

		case "delete": // 삭제
			if (!confirm("삭제 하시겠습니까? ")) {
				return;
			}
			if (confirm("하위구조가 있을 경우 하위조직도 삭제 처리 됩니다.\n삭제 하시겠습니까? ")) {
				var url = "<c:url value='/admin/basicinf/commOrgDel.do'/>";
				ajaxCallAdmin(url, actObj[0], saveCallBackOrg);
			}
			break;

		case "update": // 수정
			if (!confirm("수정 하시겠습니까? ")) {
				return;
			}
			if (!validateAdminCommOrg(actObj[1])) {
				return;
			} //validationXML 체크
			if (validateAdminCommOrgItem(formObj)) {
				return;
			} //validation 체크

			/* if (openTab.ContentObj.find("input:radio[name=useYn]:checked")
					.val() == "N") {
				if (!confirm("미사용 처리시 하위조직도 동시에 미사용 처리 됩니다.\n저장 하시겠습니까? ")) {
					return;
				}
			} */
			var url = "<c:url value='/admin/basicinf/commOrgUpd.do'/>";
			ajaxCallAdmin(url, actObj[0], saveCallBackOrg);
			break;
			
		case "init":
			
			formObj.find("input[name=orgCd]").val("");
			formObj.find("input[name=orgCd]").show("");
			formObj.find("input[name=orgNm]").val("");
			
			
			formObj.find("input[name=orgCdPar]").checked = false;
			formObj.find("input[name=orgFullNm]").val("");
			formObj.find("input[name=orgUrl]").val("");
			formObj.find("input[name=orgAddr]").val("");
			formObj.find("input[name=useYn]").val("");
			formObj.find("select[name=orgType]").val("");
			
			formObj.find("button[name=btn_dup]").show();
			formObj.find("button[name=btn_orgSearch]").show();
			formObj.find("input[name=orgCdParNm]").show();
			
			formObj.find("input[name=orgCd]").removeAttr("readonly", true).removeClass(
					"readonly", true);
			formObj.find("input[name=orgFullNm]").removeAttr("readonly", true).removeClass(
					"readonly", true);  
			formObj.find("input:checkbox[name=orgCdPar]").removeAttr(
					"checked", true);
			formObj.find("input:checkbox[name=orgCdPar]").removeAttr(
					"disabled");
			
			
			
			
			Btn_Set();
			break;
		}
	}

	function validateAdminCommOrgItem(formObj) {
		// 조직코드 중복체크 확인
		if (formObj.find('input[name=orgCd]').attr("readonly") != "readonly") {
			if (formObj.find('input[name=orgCdDup]').val() == "N") {
				alert("중복체크 버튼을 클릭해주세요.")
				return true;
			}
		}
		// 상위조직코드 체크 해제시
		if (!formObj.find('input:checkbox[name=orgCdPar]').is(':checked')) {
			if (nullCheckValdation(formObj.find('input[name=orgCdParCd]'),
					"<spring:message code='labal.orgParGrp'/>", "")) {
				return true; // 최상위조직코드 체크
			}
		} else {
			/* 선택입력으로 주석처리
			if ( nullCheckValdation( formObj.find('select[name=orgType]'), "<spring:message code='labal.orgTypeNm'/>", "" ) ) {
				return true;	// 조직구분 체크
			}
			 */
		}

		return false;
	}

	function saveCallBackOrg(res){      
	    alert(res.RESULT.MESSAGE);
	    location.reload();
	 
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

			<ul class="tab">
				<li class="all_list"><a href="#">전체목록</a></li>
			</ul>
			<!--
			<div class="more_list" style="display:none">
				<a href="#" class="more">0</a>                
				<ul class="other_list" style="display:none;">
					<li><a href="#">보유데이터목록</a><a href="#" class="line_close">x</a></li>
					<li><a href="#">공공데이터목록asdfsdfsfsdfsdfsdf</a><a href="#" class="line_close">x</a></li>
				</ul>
			</div>
			-->
			<!-- 목록내용 -->
			<div class="content">
				<form name="adminCommOrg" method="post" action="#">
					<table class="list01">
						<caption>조직정보목록</caption>
						<colgroup>
							<col width="150" />
							<col width="" />
							<col width="150" />
							<col width="" />
						</colgroup>
						<tr>
							<!-- 사용여부 -->
							<th><spring:message code="labal.useYn" /></th>
							<td colspan="3"><input type="radio" name="useYn" /> <label
								for="useAll"><spring:message code="labal.whole" /></label> <input
								type="radio" name="useYn" value="Y" checked="checked" /> <label
								for="use"><spring:message code="labal.yes" /></label> <input
								type="radio" name="useYn" value="N" /> <label for="unuse"><spring:message
										code="labal.no" /></label>
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <input
								type="checkbox" id="obj_open" name="obj_open" /> <label
								for="obj_open">항목 펼치기</label></td>

							<!-- 조직구분 -->
							<th><spring:message code="labal.orgTypeNm" /></th>
							<td colspan="3"><select name="orgTypeCd"
								style="width: 100px;">
									<option value="">선택</option>
									<c:forEach var="code" items="${codeMap.typeCd}"
										varStatus="status">
										<option value="${code.ditcCd}">${code.ditcNm}</option>
									</c:forEach>
							</select></td>
						</tr>
						<tr>
							<!-- 검색어 -->
							<th><spring:message code="labal.orgNm" /></th>
							<td colspan="7"><input type="text" name="searchWord"
								value="" style="width: 300px" maxlength="160" />
								<button type="button" class="btn01B" name="btn_searchWd">
									<spring:message code="btn.inquiry" />
								</button></td>
						</tr>


					</table>
					<!-- ibsheet 영역 -->
					<div style="clear: both;"></div>
					<div class="ibsheet_area_both">
						<script type="text/javascript">
							createIBSheet("mySheet1", "100%", "300px");
						</script>
					</div>
					<div class="buttons">${sessionScope.button.a_up}
						${sessionScope.button.a_down} ${sessionScope.button.a_save}</div>
				</form>
			</div>

			<!-- 탭 내용 -->
			<div class="content">
				<form name="adminCommOrg" method="post" action="#">
					<input type="hidden" name="orgCdDup" value="N" /> <input
						type="hidden" name="orgLvl" value="" />

					<table class="list01" id="commOrgTB">
						<caption>조직정보관리</caption>
						<colgroup>
							<col width="200" />
							<col width="400" />
							<col width="200" />
							<col width="400" />

						</colgroup>
						<tr>
							<!-- 조직코드 -->
							<th><spring:message code="labal.orgCd" /> <span>*</span></th>
							<td><input type="text" name="orgCd" value=""
								maxlength="20" style="width: 200px;" />
								${sessionScope.button.btn_dup} <br><span>공백없이 영문자와 숫자로만
									입력하세요. (20자이내)</span></td>


							<!-- 조직명 -->
							<th><spring:message code="labal.orgNm" /> <span>*</span></th>
							<td><input type="text" name="orgNm" value=""
								maxlength="160" style="width: 200px;" /></td>
						</tr>


						<tr id="orgTypeTR">
							<!-- 조직구분 -->
							<th><spring:message code="labal.orgTypeNm" /></th>
							<td><select class="" name="orgType"
								style="width: 100px;">
									<option value="">선택</option>
									<c:forEach var="code" items="${codeMap.typeCd}"
										varStatus="status">
										<option value="${code.ditcCd}">${code.ditcNm}</option>
									</c:forEach>
							</select></td>

							<!-- 상위조직 -->
							<th><spring:message code='labal.orgParGrp' /> <span>*</span></th>
							<td><input type="checkbox" name="orgCdPar" /> <span>기관
									여부(최고 상위 기관은 상위조직이 없습니다)</span>&nbsp;&nbsp;&nbsp; <input type="hidden"
								name="orgCdTopCd" value="" /> <input type="hidden"
								name="orgCdTopNm" value="" /> <input type="hidden"
								name="orgCdParCd" value="" /> <input type="text"
								name="orgCdParNm" class="readonly" value=""
								style="width: 150px;" disabled="true" />
								<button type="button" class="btn01" name="btn_orgSearch">
									<spring:message code="btn.search" />
								</button></td>
						</tr>
						<tr>
							<!-- 전체조직명 -->
							<th><spring:message code='labal.orgFullnm' /> <span>*</span></th>
							<td colspan="3"><input type="text" name="orgFullNm" value=""
								style="width: 330px;" maxlength="660" />&nbsp;</td>
						</tr>
						<tr>
							<!-- 조직홈페이지 -->
							<th><spring:message code="labal.orgUrl" /></th>
							<td><input type="text" name="orgUrl" value="http://"
								style="width: 300px;" maxlength="160" /></td>
							<th>대표전화번호</th>
							<td><input type="text" name="orgTel"
								style="width: 300px;" maxlength="160" /></td>

						</tr>
						<tr id="orgAddrTR">
							<!-- 조직주소 -->
							<th><spring:message code="labal.orgAddr" /></th>
							<td colspan="3"><input type="text" name="orgAddr" value=""
								style="width: 700px;" maxlength="160" /> <br /></td>
						</tr>
						<tr>
							<!-- 사용여부 -->
							<th><spring:message code="labal.useYn" /></th>
							<td colspan="3"><input type="radio" name="useYn" value="Y"
								class="input" checked /> <label for="use"><spring:message
										code="labal.yes" /></label> <input type="radio" name="useYn"
								value="N" class="input" /> <label for="unuse"><spring:message
										code="labal.no" /></label></td>
						</tr>

					</table>

					<div class="buttons">${sessionScope.button.a_init} ${sessionScope.button.a_reg}
						${sessionScope.button.a_modify} ${sessionScope.button.a_del} </div>
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