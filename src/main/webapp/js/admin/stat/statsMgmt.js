/*
 * @(#)statsMgmt.js 1.0 2017/05/30
 * 
 * COPYRIGHT (C) 2013 WISEITECH CO., LTD. ALL RIGHTS RESERVED.
 */

/**
 * 관리자에서 통계표를 관리하는 스크립트이다.
 *
 * @author 김정호
 * @version 1.0 2017/05/30
 */
$(function() {
    // 컴포넌트를 초기화한다.
    initComp();
    
    // 마스크를 바인딩한다.
    bindMask();
    
    // 이벤트를 바인딩한다.
    bindEvent();
    
    // 옵션을 로드한다.
    loadOptions();
    
    // 데이터를 로드한다.
    loadData();
});

////////////////////////////////////////////////////////////////////////////////
// 글로벌 변수
////////////////////////////////////////////////////////////////////////////////
var sheetTblTabCnt = 0;		//연관테이블 시트 갯수
var sheetUsrTabCnt = 0;		//유저시트 갯수
var sheetItmTabCnt = 0;		//항목시트 갯수
var sheetCateTabCnt = 0;	//분류시트 갯수
var sheetGroupTabCnt = 0;	//그룹시트 갯수 - 20190401/신규추가
var sheetCateInfoTabCnt = 0;	//분류시트 갯수

////////////////////////////////////////////////////////////////////////////////
// 초기화 함수
////////////////////////////////////////////////////////////////////////////////
/**
 * 컴포넌트를 초기화한다.
 */
function initComp() {
	tabSet();
	loadMainPage();
}

/**
 * 마스크를 바인딩한다.
 */
function bindMask() {
}

/**
 * 이벤트를 바인딩한다.
 */
function bindEvent() {
	
	//메인버튼 이벤트를 바인딩한다.
	$("button[name=btn_reg]").bind("click", function(event) {
		// 신규등록 폼 탭을 추가한다.
		doActionMain("regForm");
    });
	$("button[name=btn_inquiry]").bind("click", function(event) {
		doActionMain("search");
    });
	//조회 enter
	$("input[name=searchVal]").bind("keydown", function(event) {
        // 엔터키인 경우
        if (event.which == 13) {
        	doActionMain("search");
            return false;
        }
    });
	
	//분류체계 팝업
	$("button[name=cate_pop]").bind("click", function(e) {
		doActionMain("catePop");
	});
	//분류체계 초기화
	$("button[name=cate_reset]").bind("click", function(e) {
		$("input[name=cateId], input[name=cateIds], input[name=cateNm]").val("");
	});
	//담당부서 팝업
	$("button[name=org_pop]").bind("click", function(e) {
		doActionMain("orgPop");
	});
	//담당부서 초기화
	$("button[name=org_reset]").bind("click", function(e) {
		$("input[name=orgId], input[name=orgNm]").val("");
	});
	//입력기간 초기화
	$("button[name=openDttm_reset]").bind("click", function(e) {
		$("input[name=beginOpenDttm], input[name=endOpenDttm]").val("");
	});
	
	//작성주기 전체 선택시 전체 이외에 다른 주기 체크 해제 
	$("input[name=allDtacycle]").bind("click", function(e) {
		if ( $(this).is(":checked") ) {
			$("input:checkbox").each(function(idx) {
				if ( $(this).attr("name").indexOf("dtacycleYn") > 0 ) {
					$(this).prop("checked", false);
				}
			});
		} 
	});
	
	//시스템 전체 선택시 전체 이외에 다른 체크 해제 
	$("input[name=allSystem]").bind("click", function(e) {
		if ( $(this).is(":checked") ) {
			$("input:checkbox").each(function(idx) {
				if ( $(this).attr("name").indexOf("Yn") > 0 ) {
					$(this).prop("checked", false);
				}
			});
		} 
	});
	
	$("a[name=a_treeUp]").bind("click", function(event) {
		doActionMain("tblTreeUp");
    });
	$("a[name=a_treeDown]").bind("click", function(event) {
		doActionMain("tblTreeDown");
    });
	$("form[name=statMainForm] a[name=a_vOrderSave]").bind("click", function(event) {
		doActionMain("orderSave");
    });
	
	$("button[name=btn_sttsAnalsAll]").bind("click", function(event) {
		// 통계분석 생성
		doActionMain("analsAll");
	});
	
}

/**
 * 옵션을 로드한다.
 */
function loadOptions() {
	//메인 폼 공개일 from ~ to
	$("form[name=statMainForm]").find("input[name=beginOpenDttm], input[name=endOpenDttm]").datepicker(setCalendar());
	$("form[name=statMainForm]").find('input[name=beginOpenDttm]').datepicker('option', 'onClose',  function( selectedDate ) {$("input[name=endOpenDttm]").datepicker( "option", "minDate", selectedDate );});
	$("form[name=statMainForm]").find('input[name=endOpenDttm]').datepicker('option', 'onClose',  function( selectedDate ) {	$("input[name=beginOpenDttm]").datepicker( "option", "maxDate", selectedDate );});
	
	//자료시점기준
	loadComboOptions("wrtstddCd", "/admin/stat/ajaxOption.do", {grpCd:"S1108"}, "");
	//연계정보
	loadComboOptions("dscnId", "/admin/stat/ajaxSTTSOption.do", {grpCd:"ZE102"}, "");
	//통계자료 작성기간(from) 
	loadComboOptions("wrtStartYmd", "/admin/stat/ajaxSTTSOption.do", {grpCd:"ZE101"}, "");
	//통계자료 작성기간(to)
	loadComboOptions("wrtEndYmd", "/admin/stat/ajaxSTTSOption.do", {grpCd:"ZE101"}, "");
	//작성주기
	loadCheckOptions("dtaCycle-sect", "dtacycleCd", "/admin/stat/ajaxOption.do", {grpCd:"S1103"}, "", {isIdDiff:true});
	//통계자료
	loadCheckOptions("statsDataType-sect", "statsDataTypeCd", "/admin/stat/ajaxOption.do", {grpCd:"S1102"}, "OD", {isIdDiff:true, isDisEle:true, isAllChk:false});
	//검색자료주기
	loadRadioOptions("optDC-sect", "optDC", "/admin/stat/ajaxOption.do", {grpCd:"S1103"}, "YY", {isIdDiff:true});
	//검색 시계열 수(시트)
	loadComboOptions("optTN", "/admin/stat/ajaxOption.do", {grpCd:"S1104"}, "3");
	//검색 시계열 수(차트)
	loadComboOptions("optTC", "/admin/stat/ajaxOption.do", {grpCd:"S1104"}, "50");
	//시계열 정렬
	loadRadioOptions("optTO-sect", "optTO", "/admin/stat/ajaxOption.do", {grpCd:"D1104"}, "A", {});
	//시계열 합계출력
	loadRadioOptions("optTL-sect", "optTL", "/admin/stat/ajaxOption.do", {grpCd:"S1105"}, "N", {});
	//항목 단위출력
	loadRadioOptions("optIU-sect", "optIU", "/admin/stat/ajaxOption.do", {grpCd:"S1107"}, "Y", {});
	//표두/표측(시계열)
	loadRadioOptions("optST-sect", "optST", "/admin/stat/ajaxOption.do", {grpCd:"S1106"}, "H", {});
	//표두/표측(그룹) - 20190401/신규추가
	loadRadioOptions("optSG-sect", "optSG", "/admin/stat/ajaxOption.do", {grpCd:"S1106"}, "H", {});
	//표두/표측(분류)
	loadRadioOptions("optSC-sect", "optSC", "/admin/stat/ajaxOption.do", {grpCd:"S1106"}, "L", {});
	//표두/표측(항목)
	loadRadioOptions("optSI-sect", "optSI", "/admin/stat/ajaxOption.do", {grpCd:"S1106"}, "H", {});
	//항목 차트
	loadComboOptions3("itmSeriesCd", "/admin/stat/ajaxOption.do", {grpCd:"S1111"}, "");
	//항목 검증코드
	loadComboOptions3("itmChckCd", "/admin/stat/ajaxOption.do", {grpCd:"S1007"}, "");
	//보기 소수점
	loadComboOptions3("itmDmpointCd", "/admin/stat/ajaxOption.do", {grpCd:"S1109"}, "");
	//분류 차트
	loadComboOptions3("cateSeriesCd", "/admin/stat/ajaxOption.do", {grpCd:"S1111"}, "");
	//분류 검증코드
	loadComboOptions3("cateChckCd", "/admin/stat/ajaxOption.do", {grpCd:"S1007"}, "");
	//추천 순위
	loadComboOptions("fvtDataOrder", "/admin/stat/ajaxOption.do", {grpCd:"C1018"}, "");
	//시스템
	//loadCheckOptions("statSystem-sect", "statSystem", "/admin/stat/ajaxOption.do", {grpCd:"S1010"}, "K", {isIdDiff:true});
	// 맵 서비스 관리(콤보)
	loadComboOptions("mapSrvCd", "/admin/stat/ajaxOption.do", {grpCd:"S1112"}, "");
	// 콘텐츠 서비스 관리(콤보)
	loadComboOptions("ctsSrvCd", "/admin/stat/ajaxOption.do", {grpCd:"S1113"}, "");
	// 이용허락조건(콤보)
	loadComboOptions("cclCd", "/admin/stat/ajaxOption.do", {grpCd:"D1008"}, "");
	//통계자료
	loadCheckOptions("statsDvsView-sect", "dvsViewCd", "/admin/stat/ajaxOption.do", {grpCd:"S1102"}, "OD", {isIdDiff:true, isDisEle:true, isAllChk:false});
	
	//작성주기(월)
	var dayData = new Array();
	var dayVal = "";
	for ( var i=1; i <= 31; i++ ) {
		if ( i < 10 ) {
			dayVal = "0" + String(i);
		} else {
			dayVal = String(i);
		}
		dayData.push({code:dayVal, name:dayVal});
	}
	initComboOptions("wrtstartMdMM", dayData, "");	//from
	initComboOptions("wrtendMdMM", dayData, "");	//to
	
	// 시스템
	$.post(
        com.wise.help.url("/admin/stat/ajaxOption.do"),
        {grpCd:"S1010"},
        function(data, status, request) {
            if (data.data) {
            	var sect = $("#statSystem-sect");
            	var data = data.data;

            	for ( var i in data ) {
            		var checkbox = $("<span class=\"chk\"><input type=\"checkbox\" /> <label></label></span>");
            		var eleId = "statSystem_";
            		checkbox.find("input").attr("id", eleId + data[i].code).val("Y");
            		checkbox.find("label").attr("for", eleId + data[i].code).text(data[i].name);
            		
            		switch ( data[i].code ) {
            		case "K" :
            			checkbox.find("input").attr("name", "korYn").prop("checked", true);
            			break;
            		case "E" :
            			checkbox.find("input").attr("name", "engYn");
            			break; 
            		case "M" :
            			checkbox.find("input").attr("name", "korMobileYn");
            			break;
            		case "B" :
            			checkbox.find("input").attr("name", "engMobileYn");
            			break;		
            		}
            		sect.append(checkbox.append("&nbsp;&nbsp;"));
            	}
            }
        },
        "json"
    );
}

/**
 * 데이터를 로드한다.
 */
function loadData() {
	doActionMain("search");
}

////////////////////////////////////////////////////////////////////////////////
// 서비스 함수
////////////////////////////////////////////////////////////////////////////////
function doActionMain(sAction) {
	var classObj = $("."+tabContentClass); //tab으로 인하여 form이 다건임
	var actObj = setTabForm(classObj); // 0: form data, 1: form 객체
	var formObj = $("form[name=statMainForm]");
	switch(sAction) {                       
		case "search":
			ajaxBeforeSendAdmin(com.wise.help.url("/admin/ajaxBeforeSendAdmin.do")); //IbSheet 조회전 세션 체크
			var param = {PageParam: "ibpage", Param: "onepagerow=50"+"&"+actObj[0]};
			statSheet.DoSearchPaging(com.wise.help.url("/admin/stat/statsMgmtList.do"), param);
			break;
		case "regForm" :
			var title = "신규등록"
			var id ="statsReg";
			openTab.addRegTab(id,title,tabCallRegBack);
			break;
		case "catePop" :	//분류체계 팝업
			var url = com.wise.help.url("/admin/stat/popup/statsCatePopup.do");
			var data = "?parentFormNm=statMainForm";
			wWidth ="660";                                                    
			wHeight ="530";   
			openIframeStatPop("iframePopUp", url+data, wWidth, wHeight)
			break;	
		case "orgPop" :		//담당부서 팝업
			window.open(com.wise.help.url("/admin/basicinf/popup/commOrg_pop.do") + "?orgNmGb=2&sheetNm=statMainForm", "list" ,"fullscreen=no, width=500, height=550");
			break;	
		case "tblTreeUp" :		//위로이동
			tblTreeUp(statSheet, "vOrder");
			break;
		case "tblTreeDown" :	//아래로이동
			tblTreeDown(statSheet, "vOrder");
			break;	
		case "orderSave" :
			if(statSheet.GetSaveJson(0).data.length == 0) {
				alert("저장할 데이터가 없습니다.");  
				return;
			}
			doAjax({
				url : "/admin/stat/saveStatsMgmtOrder.do",
				params : formObj.serialize() + "&ibsSaveJson=" + encodeURIComponent(JSON.stringify(statSheet.GetSaveJson(0))),
				succUrl : "/admin/stat/statsMgmtPage.do",
			});
			break;
		case "analsAll" :	
			// 통계분석 일괄생성
			if ( !confirm("통계분석자료 일괄생성 호출 하시겠습니까?") ) {
				return;
  			}
			
			doAjax({
				url : "/admin/stat/execSttsAnlsAll.do",
				params : "",
				succUrl : "/admin/stat/statsMgmtPage.do"
			});
			break;
	}
}
	
//기본정보 서비스액션
function doActionMst(sAction) {
	var objTab = getTabShowObj();//탭이 oepn된 객체가져옴
	var formObj = objTab.find("form[name=statsMgmt-mst-form]");
	var usrSheetNm = formObj.find("input[name=usrSheetNm]").val();
	var usrSheetObj = window[usrSheetNm];
	var tblSheetNm = formObj.find("input[name=tblSheetNm]").val();
	var tblSheetObj = window[tblSheetNm];
	var cateInfoSheetNm = formObj.find("input[name=cateInfoSheetNm]").val();
	var cateInfoSheetObj = window[cateInfoSheetNm];
	
	switch(sAction) {      
		case "insert":	//입력
			if ( mstSaveValidation() ) {
				formObj.find("#statsDataType-sect-OD, #statsDvsView-sect-OD").prop("disabled", false);	//저장시 체크박스 비활성화 해제
				var datas = openTab.ContentObj.find("form[name=statsMgmt-mst-form]").serialize() + "&ibsSaveJson=" + JSON.stringify(usrSheetObj.GetSaveJson({AllSave:true}))
					+ "&ibsSaveJson2=" + JSON.stringify(tblSheetObj.GetSaveJson({AllSave:true})) + "&ibsSaveJson3=" + JSON.stringify(cateInfoSheetObj.GetSaveJson({AllSave:true}));
				$.ajax({
				    url: com.wise.help.url("/admin/stat/insertStatsMgmt.do"),
				    async: false, 
				    type: 'POST', 
				    //data: formObj.serializeObject(),
				    data: datas,
				    dataType: 'json',
				    beforeSend: function(obj) {
				    }, // 서버 요청 전 호출 되는 함수 return false; 일 경우 요청 중단
				    success: function(data) {
				    	//doAjaxMsg(data, "/admin/stat/statsMgmtPage.do");
				    	doAjaxMsg(data, "");
				    	formObj.find("#statsDataType-sect-OD, #statsDvsView-sect-OD").prop("disabled", true);	//저장시 체크박스 비활성화 처리
				    	afterTabRemove(data);
				    }, // 요청 완료 시
				    error: function(request, status, error) {
				    	formObj.find("#statsDataType-sect-OD, #statsDvsView-sect-OD").prop("disabled", true);	//저장시 체크박스 비활성화 처리
				    	handleError(status, error);
				    }, // 요청 실패.
				    complete: function(jqXHR) {} // 요청의 실패, 성공과 상관 없이 완료 될 경우 호출
				});
			}
			break;
		case "update":	//수정
			if ( mstSaveValidation() ) {
				formObj.find("#statsDataType-sect-OD, #statsDvsView-sect-OD").prop("disabled", false);
				var datas = openTab.ContentObj.find("form[name=statsMgmt-mst-form]").serialize() + "&ibsSaveJson=" + encodeURIComponent(JSON.stringify(usrSheetObj.GetSaveJson({AllSave:true})))
					+ "&ibsSaveJson2=" + encodeURIComponent(JSON.stringify(tblSheetObj.GetSaveJson({AllSave:true}))) + "&ibsSaveJson3=" + encodeURIComponent(JSON.stringify(cateInfoSheetObj.GetSaveJson({AllSave:true})));
				$.ajax({
				    url: com.wise.help.url("/admin/stat/updateStatsMgmt.do"),
				    async: false, 
				    type: 'POST', 
				    data: datas,
				    dataType: 'json',
				    beforeSend: function(obj) {
				    }, // 서버 요청 전 호출 되는 함수 return false; 일 경우 요청 중단
				    success: function(data, status, request) {
				    	doAjaxMsg(data, "");
 				    	formObj.find("#statsDataType-sect-OD, #statsDvsView-sect-OD").prop("disabled", true);	//저장시 체크박스 비활성화 처리
				    	afterTabRemove(data);
				    }, // 요청 완료 시
				    error: function(request, status, error) {
				    	handleError(status, error);
				    	formObj.find("#statsDataType-sect-OD, #statsDvsView-sect-OD").prop("disabled", true);	//저장시 체크박스 비활성화 처리
				    }, // 요청 실패.
				    complete: function(jqXHR) {} // 요청의 실패, 성공과 상관 없이 완료 될 경우 호출
				});
			}
			break;
		case "delete" :
			/*
			doDelete({
		        url:com.wise.help.url("/admin/stat/deleteStatsMgmt.do"),
		        before:beforeDeleteStatsMgmt,
		        after:afterDeleteStatsMgmt
		    });
		    */
			if ( !confirm("삭제 하시겠습니까?") )	return false;
			doAjax({
				url : "/admin/stat/deleteStatsMgmt.do",
				params : "statblId=" + formObj.find("input[name=statblId]").val(),
				callback : afterTabRemove
			});
			break;
		case "metaPop" :	//메타팝업
			var url = com.wise.help.url("/admin/stat/popup/statsMetaPopup.do");
			var data = "?parentFormNm=statsMgmt-mst-form";
			wWidth ="660";                                                    
			wHeight ="530";   
			openIframeStatPop("iframePopUp", url+data, wWidth, wHeight)
			break;
		case "catePop" :	//분류체계 팝업
			var url = com.wise.help.url("/admin/stat/popup/statsCatePopup.do");
			var data = "?parentFormNm=statsMgmt-mst-form&statblId=" + formObj.find("input[name=statblId]").val() + "&cateId=" + formObj.find("input[name=cateIds]").val();
			wWidth ="660";                                                    
			wHeight ="530";   
			openIframeStatPop("iframePopUp", url+data, wWidth, wHeight)
			break;
		case "stddUiItmPop" :	//항목 추가팝업
			//var url = com.wise.help.url("/admin/stat/opends/popup/statsStddUiPopup.do?gb=ITM");
			//OpenWindow(url,"stddUiItmPop","700","550","yes");
			var url = com.wise.help.url("/admin/stat/popup/statStddUiPop.do");
			var data = "?parentFormNm=statsMgmt-mst-form&gb=ITM";
			wWidth ="660";                                                    
			wHeight ="530";   
			openIframeStatPop("iframePopUp", url+data, wWidth, wHeight)
			break;
		case "stddUiCatePop" :	//분류 추가팝업
			//var url = com.wise.help.url("/admin/stat/opends/popup/statsStddUiPopup.do?gb=CATE");
			//OpenWindow(url,"stddUiCatePop","700","550","yes");
			var url = com.wise.help.url("/admin/stat/popup/statStddUiPop.do");
			var data = "?parentFormNm=statsMgmt-mst-form&gb=CATE";
			wWidth ="660";                                                    
			wHeight ="530";   
			openIframeStatPop("iframePopUp", url+data, wWidth, wHeight)
			break;	
		case "statMetaExpPop" :	//통계 설명 팝업
			window.open(com.wise.help.url("/admin/stat/popup/statMetaExpPopup.do") + "?statblId=" + formObj.find("input[name=statblId]").val() , "list", "fullscreen=no, width=800, height=700, scrollbars=yes");
			break;	
		case "statPreviewPop" :	//통계표 미리보기 팝업
			window.open(com.wise.help.url("/admin/stat/statPreviewPage") + "/" + formObj.find("input[name=statblId]").val() + ".do", "list", "fullscreen=no, width=1152, height=768, scrollbars=yes");
			break;
		case "openStateY" :		//공개버튼
			doPost({
		        url:"/admin/stat/updateOpenState.do",
		        before : beforeUpdateOpenStateY,
		        after : function() {
		        	location.href = com.wise.help.url("/admin/stat/statsMgmtPage.do");
		        }
		    });
			break;
		case "openStateC" :		//공개취소 버튼
			doPost({
		        url:"/admin/stat/updateOpenState.do",
		        before : beforeUpdateOpenStateN,
		        after : function() {
		        	location.href = com.wise.help.url("/admin/stat/statsMgmtPage.do");
		        }
		    });
			break;		
		case "popClose":		//항목/분류 추가팝업닫기     
			closeIframePop("iframePopUp");
			break;
		case "tblCopy" :		// 통계표 복사
			if ( !confirm("해당 통계표를 복사하시겠습니까?\n복사 완료시 [Copy of 통계표명]이 추가로 생성됩니다.") ) {
				return;
  			}
			
			doAjax({
				url : "/admin/stat/execCopySttsTbl.do",
				params : "statblId=" + formObj.find("input[name=statblId]").val(),
				succUrl : "/admin/stat/statsMgmtPage.do"
			});
			break;	
	}
}

//연관테이블시트 관련 서비스액션
function doActionTblSheet(sAction) {
	var classObj = $("."+tabContentClass); //tab으로 인하여 form이 다건임
	var actObj = setTabForm2(classObj, "statsMgmt-mst-form"); // 0: form data, 1: form 객체
	var objTab = getTabShowObj();//탭이 oepn된 객체가져옴
	var formObj = objTab.find("form[name=statsMgmt-mst-form]");
	var tblSheetNm = formObj.find("input[name=tblSheetNm]").val();
	var tblSheetObj = window[tblSheetNm];
	switch(sAction) {
		case "search" :	//조회
			ajaxBeforeSendAdmin(com.wise.help.url("/admin/ajaxBeforeSendAdmin.do")); //IbSheet 조회전 세션 체크
			var param = {PageParam: "ibpage", Param: "onepagerow=50"+"&"+actObj[0]};
			tblSheetObj.DoSearchPaging(com.wise.help.url("/admin/stat/selectSttsTblList.do"), param);
			break;
		case "addRow" :	//행 추가
			var newRow = tblSheetObj.DataInsert(-1);			//제일 마지막 행에 추가
			tblSheetObj.SetCellValue(newRow, "useYn", true);	//사용여부 기본값 체크
			break;
		case "tblPop":
			// 통계표 연결 추가 팝업
			var url = com.wise.help.url("/admin/stat/selectSttsTblPop.do"),
				param = "?statblId=" + formObj.find("input[name=statblId]").val();
	    	popwin = OpenWindow(url+param, "tblPop","700","550","yes"); 	
			break;	
		case "getSheet" :
			return tblSheetObj;
			break;
	}
}

//인원정보 관련 서비스액션
function doActionUsrSheet(sAction) {
	var classObj = $("."+tabContentClass); //tab으로 인하여 form이 다건임
	var actObj = setTabForm2(classObj, "statsMgmt-mst-form"); // 0: form data, 1: form 객체
	var objTab = getTabShowObj();//탭이 oepn된 객체가져옴
	var formObj = objTab.find("form[name=statsMgmt-mst-form]");
	var usrSheetNm = formObj.find("input[name=usrSheetNm]").val();
	var usrSheetObj = window[usrSheetNm];
	switch(sAction) {
		case "search" :	//조회
			ajaxBeforeSendAdmin(com.wise.help.url("/admin/ajaxBeforeSendAdmin.do")); //IbSheet 조회전 세션 체크
			var param = {PageParam: "ibpage", Param: "onepagerow=50"+"&"+actObj[0]};
			usrSheetObj.DoSearchPaging(com.wise.help.url("/admin/stat/statsUsrList.do"), param);
			break;
		case "addRow" :	//행 추가
			var newRow = usrSheetObj.DataInsert(-1);	//제일 마지막 행에 추가
			usrSheetObj.SetCellValue(newRow, "useYn", true);	//사용여부 기본값 체크
			break;
	}
}

//분류정보 관련 서비스액션
function doActionCateInfoSheet(sAction) {
	var classObj = $("."+tabContentClass); //tab으로 인하여 form이 다건임
	var actObj = setTabForm2(classObj, "statsMgmt-mst-form"); // 0: form data, 1: form 객체
	var objTab = getTabShowObj();//탭이 oepn된 객체가져옴
	var formObj = objTab.find("form[name=statsMgmt-mst-form]");
	var cateInfoSheetNm = formObj.find("input[name=cateInfoSheetNm]").val();
	var cateInfoSheetObj = window[cateInfoSheetNm];
	
	/*var formObj = getTabFormObj("statsMgmt-mst-form");
	var sheetObj = getTabSheetObj("statsMgmt-mst-form", "cateInfoSheetNm");*/
	switch(sAction) {
	case "search" :	//조회
		var params = "statblId=" + formObj.find("#statblId").val();
		cateInfoSheetObj.DoSearch(com.wise.help.url("/admin/stat/selectStatsCateInfoList.do"), params);
		break;
	case "catePop" :	// 분류정보 추가 팝업(선택 시 부모 시트로 데이터 이동)
		var url = com.wise.help.url("/admin/stat/popup/statsCateInfoPop.do");
		var data = "?parentFormNm=mst-form&statblId=" + formObj.find("input[name=statblId]").val();// + "&cateId=" + formObj.find("input[name=cateIds]").val();
		openIframeStatPop("iframePopUp", url+data, 660, 530);
		break;
	}
}

//항목/분류구성 관련 서비스 액션
function doActionItmSheet(sAction, gb) {
	var classObj = $("."+tabContentClass); //tab으로 인하여 form이 다건임
	var actObj = setTabForm2(classObj, "statsMgmt-mst-form"); // 0: form data, 1: form 객체
	var objTab = getTabShowObj();//탭이 oepn된 객체가져옴
	var formObj = objTab.find("form[name=statsMgmt-mst-form]");
	var itmSheetNm = formObj.find("input[name="+gb+"SheetNm]").val();	//항목/구성/그룹인지 구분값에 따라 시트 가져온다
	var itmSheetObj = window[itmSheetNm];
	switch(sAction) {
		case "search" :	//조회
			ajaxBeforeSendAdmin(com.wise.help.url("/admin/ajaxBeforeSendAdmin.do")); //IbSheet 조회전 세션 체크
			var param = {PageParam: "ibpage", Param: "onepagerow=50"+"&gb="+getGbStr(gb)+"&"+actObj[0]};
			itmSheetObj.DoSearchPaging(com.wise.help.url("/admin/stat/selectStatsTblItmList.do"), param);
			break;
		case "put" :	//팝업에서 추가한 item 부모 시트에 넣기
			closeIframePop("iframePopUp");
			setItmTree(gb);
			break;
		case "confirm" :	//반영
			setItmChgVal(gb);
			break;
		case "treeUp" :		//위로이동
			treeUp(itmSheetObj, false, "vOrder");
			break;
		case "treeDown" :	//아래로이동
			treeDown(itmSheetObj, false, "vOrder");
			break;
		case "treeOpen" :	//트리 전체 펼치기
			itmSheetObj.ShowTreeLevel(-1);
			break;	
		case "treeClose" :	//트리 전체 접기
			itmSheetObj.ShowTreeLevel(0);
			break;
		case "statsParItmPop" :
			// 부모 자료번호 팝업
			var selectRow = itmSheetObj.GetSelectRow();
			if ( selectRow < 0 && gfn_isNull(formObj.find("itmParDatano").val()) ) {
				alert("행을 선택하고 검색해 주세요.");
				return false;
			}
			
			var url = com.wise.help.url("/admin/stat/popup/statsParItmPopup.do");
			var data = "?parentFormNm=statsMgmt-mst-form"+
				  "&statblId="+formObj.find("input[name=statblId]").val()
				+ "&gb=" + getGbStr(gb)
				+ "&datano=" + itmSheetObj.GetCellValue(selectRow, "datano");
			wWidth ="660";                                                    
			wHeight ="756";   
			openIframeStatPop("iframePopUp", url+data, wWidth, wHeight)
			break;
		case "stddItmPop" :	//항목/분류 추가팝업
			//item sheet의 max 자료번호, 출력항목명, 레벨이 넘어가야함
			var maxDatano = 0;
			if ( !isFinite(itmSheetObj.GetColMaxValue("datano")) ) {	//최초 max 데이터가 없을경우
				if ( getGbStr(gb) == "I" ) {
					maxDatano = 10000;	//항목은 10000부터 시작
				} else if ( getGbStr(gb) == "C" ) {
					maxDatano = 50000;	//분류는 50000부터 시작
				} else if ( getGbStr(gb) == "G" ) {
					maxDatano = 60000;	//그룹은 60000부터 시작
				}
			} else {
				maxDatano = itmSheetObj.GetColMaxValue("datano");
			}
			
			var selDatano = 0;
			var viewItmNm = "";
			var checkedRows = "";
			var level = 0;
			var maxLevel = 0;
			if ( itmSheetObj.RowCount() > 0 ) {
				selDatano = itmSheetObj.GetCellValue(itmSheetObj.GetSelectRow(), "datano");
				viewItmNm = itmSheetObj.GetCellValue(itmSheetObj.GetSelectRow(), "viewItmNm");
				level = itmSheetObj.GetCellValue(itmSheetObj.GetSelectRow(), "Level");
				maxLevel = itmSheetObj.GetColMaxValue("Level");
				checkedRows = itmSheetObj.FindCheckedRow("chk");
			}
			
			var url = com.wise.help.url("/admin/stat/popup/statsStddItmPopup.do");
			var data = "?gb="+gb+"&parentFormNm=statsMgmt-mst-form&maxDatano="+maxDatano+"&selDatano="+selDatano+"&viewItmNm="+viewItmNm+"&level="+level+"&maxLevel="+maxLevel+"&checkedRows="+checkedRows;
			wWidth ="660";                                                    
			wHeight ="756";   
			openIframeStatPop("iframePopUp", url+data, wWidth, wHeight)
			break;	
		case "save" :	//저장(CUD 처리)
			if ( itmSaveValidation(gb) ) {
				if ( !confirm("수정 하시겠습니까? ") ) {
					return;
	  			}
	  			//현재 위치된 레벨 및 순서대로 트리 순서 재조정
				treeOrderSet(itmSheetObj);
				
				ibsSaveJson = itmSheetObj.GetSaveJson(0);

				if(ibsSaveJson.data.length == 0) {
					alert("저장할 데이터가 없습니다.");  
					return;
				}
				
				var url ="/admin/stat/saveStddTblItm.do";
				var param = "statblId=" + formObj.find("input[name=statblId]").val() + "&gb=" + getGbStr(gb);

				IBSpostJson(url, param , function(data) {
					if (data.error) {
				    	if (data.error.message) {
				    		alert(data.error.message);
				    	}
				    } else {
				    	alert("저장 되었습니다.");
				    	doActionItmSheet("search", gb);	//조회
				    }
				});
			}
			break;  
		case "orderSave" :	//순서저장
			for (var i=1; i <= itmSheetObj.RowCount(); i++) {
				if ( itmSheetObj.GetCellValue(i, "status") == "I" ) {
					alert("신규 추가항목을 먼저 저장하세요.");
					return false;
				}
			}
			//현재 위치된 레벨 및 순서대로 트리 순서 재조정
			treeOrderSet(itmSheetObj);
			
			ibsSaveJson = itmSheetObj.GetSaveJson(0);  
			if(ibsSaveJson.data.length == 0) {
				alert("저장할 데이터가 없습니다.");  
				return;
			}

			var url ="/admin/stat/saveStddTblItmOrder.do";
			var param = "statblId=" + formObj.find("input[name=statblId]").val() + "&gb=" + getGbStr(gb);
			IBSpostJson(url, param , function(data) {
				alert("순서가 변경되었습니다.");
				doActionItmSheet("search", gb);	//조회
			});
			break;
	}
}

////////////////////////////////////////////////////////////////////////////////
// 전처리 함수
////////////////////////////////////////////////////////////////////////////////
//항목/분류 구분에 따라 코드값을 가져온다.
function getGbStr(gb) {
	if ( !com.wise.util.isNull(gb) ) {
		if ( gb == "itm" ) {
			return "I";
		} else if ( gb == "cate" ) {
			return "C"
		} else if ( gb == "group" ) {
			return "G"
		}
	} else {
		return "";
	}
}

//공개처리
function beforeUpdateOpenStateY() {
	var data = {};
	var objTab = getTabShowObj();//탭이 oepn된 객체가져옴
	var formObj = objTab.find("form[name=statsMgmt-mst-form]");
	
    $.each(formObj.serializeArray(), function(index, element) {
        switch (element.name) {
        	case "statblId":
        	case "openState":	
            case "openDttm":
            	data[element.name] = element.value;
            	break;
        }
    });
    
    if ( data.openState == "Y" ) {
        alert("이미 공개 된 상태 입니다.");
        return null;
    }
    if (com.wise.util.isBlank(data.openDttm)) {
        alert("공개일을 선택하세요");
        return null;
    }
    
    if ( !confirm("공개처리 하시겠습니까?") )	return null;
    
    data["openState"] = "Y";
    return data;
}
//공개취소 처리
function beforeUpdateOpenStateN() {
	var data = {};
	var objTab = getTabShowObj();//탭이 oepn된 객체가져옴
	var formObj = objTab.find("form[name=statsMgmt-mst-form]");
	
    $.each(formObj.serializeArray(), function(index, element) {
        switch (element.name) {
        	case "statblId":
            case "openState":
            	data[element.name] = element.value;
            	break;
        }
    });
    
    if ( data.openState == "N" ) {
        alert("이미 공개취소 된 상태 입니다.");
        return null;
    }
    
    data["openState"] = "N";
    if ( !confirm("공개취소 처리 하시겠습니까?") )	return null;
    return data;
}

////////////////////////////////////////////////////////////////////////////////
//탭 관련 함수
////////////////////////////////////////////////////////////////////////////////
function tabSet(){ //탭 객체 생성  
	openTab = new OpenTab(tabId,tabContentClass,tabBody); //headinclude.jsp 변수 있음
	openTab.TabObj = openTab;  
	openTab.addTabClickEvent();            
}
//탭 버튼 이벤트

function buttonEventAdd() {
	setTabButtonEvent();
}

//탭 버튼 이벤트 추가
function setTabButtonEvent() {
	var objTab = getTabShowObj();//탭이 oepn된 객체가져옴
	var formObj = objTab.find("form[name=statsMgmt-mst-form]");
	
	// 통계자료 작성기간 시작일자 변경시
	formObj.find("select[name=wrtStartYmd]").bind("change", function() {
		if ( !formObj.find("input[name=wrtChk]").is(":checked") ) {	//종료 제한없읔 체크 되어있을경우
			if ( $(this).val() > formObj.find("select[name=wrtEndYmd]").val() ) { 
				alert("시작년도가 끝년도보다 클 수 없습니다.");
				$(this).val(formObj.find("select[name=wrtEndYmd]").val());
			}
		}
	});
	
	// 통계자료 작성기간 종료일자 변경시
	formObj.find("select[name=wrtEndYmd]").bind("change", function() {
		if ( $(this).val() < formObj.find("select[name=wrtStartYmd]").val() ) {
			alert("시작년도가 끝년도보다 클 수 없습니다.");
			$(this).val(formObj.find("select[name=wrtStartYmd]").val());
		}
	});
	
	// 통계자료 작성기간 종료제한없음 체크박스
	formObj.find("input[name=wrtChk]").bind("click", function() {
		if ( $(this).is(":checked") ) {
			formObj.find("select[name=wrtEndYmd]").attr("disabled", true);
		} else {
			formObj.find("select[name=wrtEndYmd]").attr("disabled", false);
		}
	});
	
	// 데이터를 등록한다.
	formObj.find("a[name=a_reg]").bind("click", function(event) {
		doActionMst("insert");
    });
	// 데이터를 수정한다.
	formObj.find("a[name=a_modify]:eq(0)").bind("click", function(event) {
		doActionMst("update");
    });
	// 데이터를 삭제한다.
	formObj.find("a[name=a_del]").bind("click", function(event) {
		doActionMst("delete");
    });
	//통계메타명 팝업
	formObj.find("button[name=statblNm_pop]").bind("click", function(e) {
		doActionMst("metaPop");
	});
	//분류체계 팝업
	formObj.find("button[name=cateId_pop]").bind("click", function(e) {
		doActionMst("catePop");
	});
	//항목정보 추가
	formObj.find("button[name=stddItm_pop]").bind("click", function(e) {
		doActionItmSheet("stddItmPop", "itm");
	});
	formObj.find("button[name=itmTreeOpen]").bind("click", function(e) {
		doActionItmSheet("treeOpen", "itm");
	});
	formObj.find("button[name=itmTreeClose]").bind("click", function(e) {
		doActionItmSheet("treeClose", "itm");
	});
	//분류정보 추가팝업
	formObj.find("button[name=stddCate_pop]").bind("click", function(e) {
		doActionItmSheet("stddItmPop", "cate");
	});
	formObj.find("button[name=cateTreeOpen]").bind("click", function(e) {
		doActionItmSheet("treeOpen", "cate");
	});
	formObj.find("button[name=cateTreeClose]").bind("click", function(e) {
		doActionItmSheet("treeClose", "cate");
	});
	//그룹정보 추가팝업
	formObj.find("button[name=stddGroup_pop]").bind("click", function(e) {
		doActionItmSheet("stddItmPop", "group");
	});
	formObj.find("button[name=groupTreeOpen]").bind("click", function(e) {
		doActionItmSheet("treeOpen", "group");
	});
	formObj.find("button[name=groupTreeClose]").bind("click", function(e) {
		doActionItmSheet("treeClose", "group");
	});
	//연관통계표추가
	formObj.find("button[name=tblAdd]").bind("click", function(e) {
		doActionTblSheet("tblPop");
	});
	//인원추가
	formObj.find("button[name=usrAdd]").bind("click", function(e) {
		doActionUsrSheet("addRow");
	});
	//분류정보추가
	formObj.find("button[name=cateInfoAdd]").bind("click", function(e) {
		doActionCateInfoSheet("catePop");
	});
	//항목상세정보 시트에 반영
	formObj.find("button[name=itmConfirmBtn]").bind("click", function(e) {
		doActionItmSheet("confirm", "itm");
	});
	//분류상세정보 시트에 반영
	formObj.find("button[name=cateConfirmBtn]").bind("click", function(e) {
		doActionItmSheet("confirm", "cate");
	});
	//그룹상세정보 시트에 반영
	formObj.find("button[name=groupConfirmBtn]").bind("click", function(e) {
		doActionItmSheet("confirm", "group");
	});
	//항목 추가 팝업
	formObj.find("button[name=stddItmUi_pop]").bind("click", function(e) {
		doActionMst("stddUiItmPop");
	});
	//분류 추가 팝업
	formObj.find("button[name=stddCateUi_pop]").bind("click", function(e) {
		doActionMst("stddUiCatePop");
	});
	//그룹 추가 팝업
	formObj.find("button[name=stddGroupUi_pop]").bind("click", function(e) {
		doActionMst("stddUiGroupPop");
	});
	//항목 수정
	formObj.find("a[name=a_save]:eq(1)").bind("click", function(event) {
		doActionItmSheet("save", "itm");
    });
	//분류 수정
	formObj.find("a[name=a_save]:eq(2)").bind("click", function(event) {
		doActionItmSheet("save", "cate");
    });
	//그룹 수정
	formObj.find("a[name=a_save]:eq(0)").bind("click", function(event) {
		doActionItmSheet("save", "group");
	});
	//항목 순서 위로이동
	formObj.find("a[name=a_itm_up]").bind("click", function(event) {
		doActionItmSheet("treeUp", "itm");
    });
	//항목 순서 아래로이동
	formObj.find("a[name=a_itm_down]").bind("click", function(event) {
		doActionItmSheet("treeDown", "itm");
    });
	//분류 순서 위로이동
	formObj.find("a[name=a_cate_up]").bind("click", function(event) {
		doActionItmSheet("treeUp", "cate");
    });
	//분류 순서 아래로이동
	formObj.find("a[name=a_cate_down]").bind("click", function(event) {
		doActionItmSheet("treeDown", "cate");
    });
	//그룹 순서 위로이동
	formObj.find("a[name=a_group_up]").bind("click", function(event) {
		doActionItmSheet("treeUp", "group");
    });
	//그룹 순서 아래로이동
	formObj.find("a[name=a_group_down]").bind("click", function(event) {
		doActionItmSheet("treeDown", "group");
    });
	//항목 순서 저장
	formObj.find("a[name=a_vOrderSave]:eq(1)").bind("click", function(event) {
		doActionItmSheet("orderSave", "itm");
    });
	//분류 순서 저장
	formObj.find("a[name=a_vOrderSave]:eq(2)").bind("click", function(event) {	
		doActionItmSheet("orderSave", "cate");
    });
	//그룹 순서 저장
	formObj.find("a[name=a_vOrderSave]:eq(0)").bind("click", function(event) {	
		doActionItmSheet("orderSave", "group");
    });
	//초기화
	formObj.find("button[name=stddItm_search]").bind("click", function(event) {
		doActionItmSheet("search", "itm");	//조회
    });
	//부모자료번호 선택 팝업(항목)
	formObj.find("button[name=statsParItm_pop]").bind("click", function(e) {
		doActionItmSheet("statsParItmPop", "itm");
	});
	//부모자료번호 선택 팝업(분류)
	formObj.find("button[name=statsParCate_pop]").bind("click", function(e) {
		doActionItmSheet("statsParItmPop", "cate");
	});
	//부모자료번호 선택 팝업(그룹)
	formObj.find("button[name=statsParGroup_pop]").bind("click", function(e) {
		doActionItmSheet("statsParItmPop", "group");
	});
	//추천 체크박스 이벤트
	formObj.find("input[name=fvtDataYn]").bind("click", function(event) {
		if ( !$(this).is(":checked") ) {
			formObj.find("select[name=fvtDataOrder]").val("0").hide();	//체크 해제시 추천안함으로
		} else {
			formObj.find("select[name=fvtDataOrder]").show();
		}
	});
	//추천 순위 selectbox 이벤트
	formObj.find("select[name=fvtDataOrder]").bind("change", function(event) {
		if ( $(this).val() == "0" ) {	//추천 안할경우
			$(this).hide();	//selectbox 숨김
			formObj.find("input[name=fvtDataYn]").prop("checked", false);	//추천 체크박스 언체크
		}
	});
	//통계설명 팝업
	formObj.find("button[name=statMeta_pop]").bind("click", function(e) {
		doActionMst("statMetaExpPop");
	});
	//통계표 팝업
	formObj.find("button[name=statPreview_pop]").bind("click", function(e) {
		doActionMst("statPreviewPop");
	});
	//공개버튼
	formObj.find("a[name=a_openState]").bind("click", function(e) {
		doActionMst("openStateY");
	});
	//공개취소 버튼
	formObj.find("a[name=a_openStateCancel]").bind("click", function(e) {
		doActionMst("openStateC");
	});
	//통계표 복사 버튼
	formObj.find("a[name=a_tblCopy]").bind("click", function(e) {
		doActionMst("tblCopy");
	});
	
	//상세 탭 관련 이벤트
	formObj.find(".tab-inner li").on('click', function(e){
		var statblId = formObj.find("input[name=statblId]").val();
		if ( com.wise.util.isBlank(statblId) ) {	//통계표 ID가 공백일경우(등록 전)
			alert("통계표 기본정보 등록 후 항목/분류/그룹 구성 해주세요");
		} else {
			var i = $(this).index();
			e.preventDefault();
			formObj.find('.tab-inner-sect').hide();
			formObj.find('.tab-inner-sect').eq(i).show()
			formObj.find('.tab-inner-li a').removeClass('on');
			$(this).children().addClass('on');
		}
	});
	
	/* 캘린더 초기화 */
	datePickerInit();
	
}

//상세 탭 이벤트 후처리
function tabFunction(tab, data) {
	var objTab = getTabShowObj();//탭이 oepn된 객체가져옴
	var formObj = objTab.find("form[name=statsMgmt-mst-form]");
	
	formObj.find("a[name=a_reg]").hide();	//등록버튼 숨김
	tab.ContentObj.find("a[name=a_openState]").hide();		//공개 숨김처리
	tab.ContentObj.find("a[name=a_openStateCancel]").hide();	//공개취소 숨김처리
	
	//추천 체크처리
	if ( data.DATA.fvtDataOrder > 0 ) {
		tab.ContentObj.find("input[name=fvtDataYn]").prop("checked", true);
		tab.ContentObj.find("select[name=fvtDataOrder]").show();
	}
	
	var openState = data.DATA.openState;	//공개상태
	if ( openState == "N" || openState == "C" ) {	//미공개, 공개취소
		tab.ContentObj.find("a[name=a_openState]").show();	//공개 버튼 표시
	} else if ( openState == "Y" ) {	//공개
		tab.ContentObj.find("a[name=a_openStateCancel]").show();	//공개취소 버튼 표시
		tab.ContentObj.find("button[name=openDttmInit]").hide();	//초기화 버튼 숨김
	}
	
	//자료작성종료년일
	var wrtEndYmd= data.DATA.wrtEndYmd;
	if ( wrtEndYmd == "9999" ) {	//9999(종료 제한없음) 
		tab.ContentObj.find("input[name=wrtChk]").prop("checked", true);	//종료 제한없음 체크박스에 체크
	}
	
	// 시스템값
	tab.ContentObj.find("input[name=korYn]").prop("checked", 		(data.DATA.korYn=="Y" ? true : false));
	tab.ContentObj.find("input[name=engYn]").prop("checked", 		(data.DATA.engYn=="Y" ? true : false));
	tab.ContentObj.find("input[name=korMobileYn]").prop("checked", (data.DATA.korMobileYn=="Y" ? true : false));
	tab.ContentObj.find("input[name=engMobileYn]").prop("checked", (data.DATA.engMobileYn=="Y" ? true : false));
	
	//OPT값 설정
	$.each(data.DATA2.OPT_DATA, function(i, json) {
		if ( json.optCd == "DD" ) {
			tab.ContentObj.find("input[name=statsDataTypeCd][value="+json.optVal+"]").prop("checked", true);
		} else if ( json.optCd == "DP" ) {	// 초기 통계분석자료 출력
			tab.ContentObj.find("input[name=dvsViewCd][value="+json.optVal+"]").prop("checked", true);
		} else if ( json.optCd == "TN" ) {	// 시계열 갯수(시트)
			tab.ContentObj.find("select[name=opt"+json.optCd+"]").val(json.optVal);
		} else if ( json.optCd == "TC" ) {	// 시계열 갯수(차트)
			tab.ContentObj.find("select[name=opt"+json.optCd+"]").val(json.optVal);	
		} else {
			tab.ContentObj.find("input[name=opt"+json.optCd+"][value="+json.optVal+"]").prop("checked", true);
		}
	});
	
	//SCHL값 설정
	var dtacycleArr = new Array();
	var isDtacycleMM = false;
	$.each(data.DATA2.SCHL_DATA, function(i, json) {
		//작성주기 확인하여 array에 재정의
		if ( $.inArray(json.dtacycleCd, dtacycleArr) == -1 ) {
			dtacycleArr.push(json.dtacycleCd);
		}
		
		if ( json.dtacycleCd == "YY" ) {	//년 인경우
			tab.ContentObj.find("input[name=wrtstartMd"+json.dtacycleCd+"]").val(json.wrtStartMd);
			tab.ContentObj.find("input[name=wrtendMd"+json.dtacycleCd+"]").val(json.wrtEndMd);
		} else if ( json.dtacycleCd == "MM" ) {
			if ( !isDtacycleMM ) {	//월은 한번만 호출
				isDtacycleMM = true;
				tab.ContentObj.find("select[name=wrtstartMd"+json.dtacycleCd+"]").val(json.wrtStartMd.substring(json.wrtStartMd.length-2, json.wrtStartMd.length));
				tab.ContentObj.find("select[name=wrtendMd"+json.dtacycleCd+"]").val(json.wrtEndMd.substring(json.wrtEndMd.length-2, json.wrtEndMd.length));
			}
		} else {
			tab.ContentObj.find("input[name=wrtstartMd"+json.dtacycleCd+json.wrttimeIdtfr+"]").val(json.wrtStartMd);
			tab.ContentObj.find("input[name=wrtendMd"+json.dtacycleCd+json.wrttimeIdtfr+"]").val(json.wrtEndMd);
		}
	});
	
	//재정의한 작성주기 checkbox 체크 및 캘린더 표시
	for ( var dc in dtacycleArr ) {
		tab.ContentObj.find("input[name=dtacycleCd][value="+dtacycleArr[dc]+"]").prop("checked", true);
		tab.ContentObj.find("tr[name=wrt"+ dtacycleArr[dc] +"TR]").show();
	}
	
	/* 탭 버튼 이벤트 세팅 */
	setTabButtonEvent();
	
}

//신규등록 탭 추가시 callback 함수(tab.js에 정의되어있음....)
function regUserFunction() {
	tblSheetCreate(999);	// 연관통계표 시트생성
	usrSheetCreate(999);	//유저정보 시트생성
    itmSheetCreate(999);	//항목 시트생성
    cateSheetCreate(999);	//분류 시트생성
    groupSheetCreate(999);	//그룹 시트생성 - 20190401/신규추가
    cateInfoSheetCreate(999);	//분류정보 시트생성
	
	var objTab = getTabShowObj();//탭이 oepn된 객체가져옴
	var formObj = objTab.find("form[name=statsMgmt-mst-form]");
	formObj.find("a[name=a_modify]").hide();	//저장버튼 숨김
	
	formObj.find("a[name=a_tblCopy]").hide();			//통계표복사 버튼 숨김
	formObj.find("button[name=statMeta_pop]").hide();	//통계설명 버튼 숨김
	formObj.find("h3[name=tblOpenH3]").hide();			//통계표 공개 숨김
	formObj.find("table[name=tblOpenTable]").hide();	//통계표 공개 숨김
	
	/* 탭 버튼 이벤트 세팅 */
	setTabButtonEvent();
	
}

//상세 탭 이벤트
function tabEvent(row){//탭 이벤트 실행  
	var title = statSheet.GetCellValue(row,"statblNm");//탭 제목
	//title = title.substring(0, title.indexOf("<a"));	//아이콘 없앰
	var id = statSheet.GetCellValue(row, "statblId");//탭 id(유일한key)) 
	openTab.SetTabData(statSheet.GetRowJson(row));//db data 조회시 조건 data
	var url =  com.wise.help.url('/admin/stat/selectStatsMgmtDtl.do'); // Controller 호출 url 
	openTab.addTab(id,title,url,tabCallBack); 	// 탭 추가 시작함
	tblSheetCreate(sheetTblTabCnt++);				//연관테이블 시트생성
	usrSheetCreate(sheetUsrTabCnt++);			//유저정보 시트생성
	itmSheetCreate(sheetItmTabCnt++);			//항목 시트생성
	cateSheetCreate(sheetCateTabCnt++);			//분류 시트생성
	groupSheetCreate(sheetGroupTabCnt++);		//그룹 시트생성 - 20190401/신규추가
	cateInfoSheetCreate(sheetCateInfoTabCnt++);			//분류정보 시트생성
}  

// 연관통계표 탭안 Sheet 생성
function tblSheetCreate(SheetCnt){       
 	var sheetNm = "tblSheet"+SheetCnt;  
 	$("div[name=statTblSheet]").eq(1).attr("id","DIV_"+sheetNm);                                          
 	createIBSheet2(document.getElementById("DIV_"+sheetNm),sheetNm, "100%", "200px");               
 	var sheetobj = window[sheetNm]; 
 	var objTab = getTabShowObj();//탭이 oepn된 객체가져옴
 	var formObj = objTab.find("form[name=statsMgmt-mst-form]");
 	formObj.find("input[name=tblSheetNm]").val(sheetNm);
 	loadTblSheet(sheetNm, sheetobj);
}

//유저 탭 Sheet 생성
function usrSheetCreate(SheetCnt){       
 	var sheetNm = "usrSheet"+SheetCnt;  
 	$("div[name=statUsrSheet]").eq(1).attr("id","DIV_"+sheetNm);                                          
 	createIBSheet2(document.getElementById("DIV_"+sheetNm),sheetNm, "100%", "200px");               
 	var sheetobj = window[sheetNm]; 
 	var objTab = getTabShowObj();//탭이 oepn된 객체가져옴
 	var formObj = objTab.find("form[name=statsMgmt-mst-form]");
 	formObj.find("input[name=usrSheetNm]").val(sheetNm);
 	loadUsrSheet(sheetNm, sheetobj);
 	window[sheetNm+ "_OnPopupClick"] = usrSheetOnPopupClick		//시트 팝업클릭
 	//window[sheetNm + "_OnValidation"] = usrSheetOnValidation;	//시트 Validation(시트 기능으로 수정)
}

//분류정보 탭 Sheet 생성
function cateInfoSheetCreate(SheetCnt){       
	var sheetNm = "cateInfoSheet"+SheetCnt;  
	$("div[name=statCateInfoSheet]").eq(1).attr("id","DIV_"+sheetNm);                                          
	createIBSheet2(document.getElementById("DIV_"+sheetNm),sheetNm, "100%", "200px");               
	var sheetobj = window[sheetNm]; 
	var objTab = getTabShowObj();//탭이 oepn된 객체가져옴
	var formObj = objTab.find("form[name=statsMgmt-mst-form]");
	formObj.find("input[name=cateInfoSheetNm]").val(sheetNm);
	loadCateInfoSheet(sheetNm, sheetobj);
	//window[sheetNm+ "_OnPopupClick"] = cateInfoSheetOnPopupClick		//시트 팝업클릭
}

//항목 탭 Sheet 생성
function itmSheetCreate(SheetCnt){       
 	var sheetNm = "itmSheet"+SheetCnt;  
 	$("div[name=statItmSheet]").eq(1).attr("id","DIV_"+sheetNm);                                          
 	createIBSheet2(document.getElementById("DIV_"+sheetNm),sheetNm, "100%", "400px");               
 	var sheetobj = window[sheetNm]; 
 	var objTab = getTabShowObj();//탭이 oepn된 객체가져옴
 	var formObj = objTab.find("form[name=statsMgmt-mst-form]");
 	formObj.find("input[name=itmSheetNm]").val(sheetNm);
 	loadItmSheet(sheetNm, sheetobj);
 	window[sheetNm + "_OnSelectCell"] = itmSheetOnSelectCell;	//항목 시트 셀 변경 이벤트
 	window[sheetNm + "_OnClick"] = itmSheetOnClick;				//클릭 이벤트
 	window[sheetNm + "_OnAfterEdit"] = itmSheetOnAfterEdit;		//편집완료 후 이벤트
}

//분류 탭 Sheet 생성
function cateSheetCreate(SheetCnt){      
 	var sheetNm = "cateSheet"+SheetCnt;  
 	$("div[name=statCateSheet]").eq(1).attr("id","DIV_"+sheetNm);                                          
 	createIBSheet2(document.getElementById("DIV_"+sheetNm),sheetNm, "100%", "400px");               
 	var sheetobj = window[sheetNm]; 
 	var objTab = getTabShowObj();
 	var formObj = objTab.find("form[name=statsMgmt-mst-form]");
 	formObj.find("input[name=cateSheetNm]").val(sheetNm);
 	loadCateSheet(sheetNm, sheetobj);
 	window[sheetNm + "_OnSelectCell"] = cateSheetOnSelectCell;	//분류 시트 셀 변경 이벤트
 	window[sheetNm + "_OnClick"] = cateSheetOnClick;			//클릭 이벤트
 	window[sheetNm + "_OnAfterEdit"] = cateSheetOnAfterEdit;	//편집완료 후 이벤트
}

// 그룹 탭 Sheet 생성
function groupSheetCreate(SheetCnt){      
 	var sheetNm = "groupSheet"+SheetCnt;  
 	$("div[name=statGroupSheet]").eq(1).attr("id","DIV_"+sheetNm);                                          
 	createIBSheet2(document.getElementById("DIV_"+sheetNm),sheetNm, "100%", "400px");               
 	var sheetobj = window[sheetNm]; 
 	var objTab = getTabShowObj();
 	var formObj = objTab.find("form[name=statsMgmt-mst-form]");
 	formObj.find("input[name=groupSheetNm]").val(sheetNm);
 	loadGroupSheet(sheetNm, sheetobj);
 	window[sheetNm + "_OnSelectCell"] = groupSheetOnSelectCell;	//그룹 시트 셀 변경 이벤트
 	window[sheetNm + "_OnClick"] = groupSheetOnClick;			//클릭 이벤트
 	window[sheetNm + "_OnAfterEdit"] = groupSheetOnAfterEdit;	//편집완료 후 이벤트
}

////////////////////////////////////////////////////////////////////////////////
//시트 로드
////////////////////////////////////////////////////////////////////////////////
function loadMainPage() {
	
	createIBSheet2(document.getElementById("statSheet"),"statSheet", "100%", "300px");
	
	var gridTitle ="NO";
	gridTitle +="|상태";
	gridTitle +="|분류통계구분";
	gridTitle +="|통계표ID";
	gridTitle +="|분류>통계표명(숨김)";
	gridTitle +="|분류>통계표명";
	gridTitle +="|통계메타ID"; 
	gridTitle +="|통계설명";
	gridTitle +="|담당부서";
	gridTitle +="|시스템";
	gridTitle +="|이용허락조건";
	gridTitle +="|연계정보";
	gridTitle +="|작성주기";
	gridTitle +="|공개일";
	gridTitle +="|공개상태";
	gridTitle +="|추천";
	gridTitle +="|순서";
	gridTitle +="|레벨";
	
	with(statSheet){
		                     
		var cfg = {SearchMode:2,Page:50,VScrollMode:1,ChildPage: 20};
	    SetConfig(cfg);
	    var headers = [
	                {Text:gridTitle, Align:"Center"}
	            ];
	    var headerInfo = {Sort:0,ColMove:1,ColResize:1,HeaderCheck:0};
	    
	    InitHeaders(headers, headerInfo);
	   
	    var cols = [
	                 {Type:"Seq",		SaveName:"seq",				Width:30,	Align:"Center",	Edit:false}
	                ,{Type:"Status",	SaveName:"status",			Width:40,	Align:"Center",	Edit:false}  
	                ,{Type:"Text",		SaveName:"statblTag",		Width:60,	Align:"Center",	Edit:false,	Hidden:true}
					,{Type:"Text",		SaveName:"statblId",		Width:60,	Align:"Center",	Edit:false}
					,{Type:"Text",		SaveName:"statblNm",		Width:100,	Align:"Left",	Edit:false,	Hidden:true}
					,{Type:"Html",		SaveName:"statblNmExp",		Width:300,	Align:"Left",	Edit:false,	TreeCol:1}
					,{Type:"Text",		SaveName:"statId",			Width:50,	Align:"Left",	Edit:false,	Hidden:true}
					,{Type:"Text",		SaveName:"statNm",			Width:150,	Align:"Left",	Edit:false,	Hidden:true}
					,{Type:"Text",		SaveName:"orgNm",			Width:80,	Align:"Center",	Edit:false}
					,{Type:"Text",		SaveName:"openSysNm",		Width:60,	Align:"Center",	Edit:false,	Hidden:true}
					,{Type:"Text",		SaveName:"cclNm",		Width:60,	Align:"Center",	Edit:false}
					,{Type:"Text",		SaveName:"dscnNm",			Width:150,	Align:"Left",	Edit:false}
					,{Type:"Text",		SaveName:"dtacycleNm",		Width:120,	Align:"Left",	Edit:false}
					,{Type:"Text",		SaveName:"openDttm",		Width:90,	Align:"Center",	Edit:false,	Format:"Ymd"}
					,{Type:"Combo",		SaveName:"openState",		Width:70,	Align:"Center",	Edit:false}
					,{Type:"Text",		SaveName:"fvtDataOrderNm",	Width:90,	Align:"Center",	Edit:false,	Hidden:false}
					,{Type:"Int",		SaveName:"vOrder",			Width:60,	Align:"Center",	Edit:false,	Hidden:false}
					,{Type:"Int",		SaveName:"Level",			Width:60,	Align:"Center",	Edit:false,	Hidden:true}
	            ];                                          
	    InitColumns(cols);
	    FitColWidth();
	    SetExtendLastCol(1);
	    
	    initSheetOptions("statSheet", 0, "openState", [
	        {code:"", name:""}                                           
	       ,{code:"N", name:"미공개"}
	       ,{code:"Y", name:"공개"}
	       ,{code:"X", name:"공개불가"}
	       ,{code:"C", name:"공개취소"}
	   ]);
	    
	    ShowTreeLevel(0, 1);
	}               
	default_sheet(statSheet);
	
}


// 연관통계표 시트 생성
function loadTblSheet(sheetNm, sheetObj) {
	
	var gridTitle ="NO";
	gridTitle +="|상태";
	gridTitle +="|삭제";
	gridTitle +="|연관통계표ID";
	gridTitle +="|연관통계표명";
	gridTitle +="|공개상태";
	gridTitle +="|사용여부";
	
	with(sheetObj){
		                     
		var cfg = {SearchMode:2,Page:50,VScrollMode:1};
	    SetConfig(cfg);
	    var headers = [
	                {Text:gridTitle, Align:"Center"}
	            ];
	    var headerInfo = {Sort:0,ColMove:1,ColResize:1,HeaderCheck:0};
	    
	    InitHeaders(headers, headerInfo);
	   
	    var cols = [
	                 {Type:"Seq",		SaveName:"seq",				Width:30,	Align:"Center",		Edit:false}
	                ,{Type:"Status",	SaveName:"status",			Width:40,	Align:"Center",		Edit:false} 
	                ,{Type:"DelCheck",	SaveName:"del",				Width:30,	Align:"Center",		Edit:true}
					,{Type:"Text",		SaveName:"relStatblId",		Width:100,	Align:"Center",		Edit:false,	KeyField: 1}
					,{Type:"Text",		SaveName:"relStatblNm",		Width:300,	Align:"Left",		Edit:false}
					,{Type:"Combo",		SaveName:"openState",		Width:70,	Align:"Center",		Edit:false}
					,{Type:"CheckBox",	SaveName:"useYn",			Width:30,   Align:"Center",		TrueValue:"Y", FalseValue:"N",Edit:true}
	            ];
	    
	    
	    InitColumns(cols);
	    FitColWidth();
	    SetExtendLastCol(1);
	    
	    initSheetOptions(sheetNm, 0, "openState", [                          
       	        {code:"N", name:"미공개"}
       	       ,{code:"Y", name:"공개"}
       	   ]);
	    
	}               
	default_sheet(sheetObj);   
	doActionTblSheet("search");	//조회
}

//유저 시트 생성
function loadUsrSheet(sheetNm, sheetObj) {
	
	var gridTitle ="NO";
	gridTitle +="|상태";
	gridTitle +="|삭제";
	gridTitle +="|통계표ID";
	gridTitle +="|조직코드";
	gridTitle +="|조직명";
	gridTitle +="|직원코드";
	gridTitle +="|직원명";
	gridTitle +="|대표여부";
	gridTitle +="|업무권한";
	gridTitle +="|출처표시";
	gridTitle +="|사용여부";
	
	with(sheetObj){
		                     
		var cfg = {SearchMode:2,Page:50,VScrollMode:1};
	    SetConfig(cfg);
	    var headers = [
	                {Text:gridTitle, Align:"Center"}
	            ];
	    var headerInfo = {Sort:0,ColMove:1,ColResize:1,HeaderCheck:0};
	    
	    InitHeaders(headers, headerInfo);
	   
	    var cols = [
	                 {Type:"Seq",		SaveName:"seq",				Width:30,	Align:"Center",		Edit:false}
	                ,{Type:"Status",	SaveName:"status",			Width:40,	Align:"Center",		Edit:false} 
	                ,{Type:"DelCheck",	SaveName:"del",				Width:30,	Align:"Center",		Edit:true}
					,{Type:"Text",		SaveName:"statblId",		Width:30,	Align:"Center",		Edit:true,	Hidden:true}
					,{Type:"Text",		SaveName:"orgCd",			Width:30,	Align:"Left",		Edit:true,	Hidden:true}
					,{Type:"Popup",		SaveName:"orgNm",			Width:100,	Align:"Left",		Edit:true,	KeyField: 1}
					,{Type:"Text",		SaveName:"usrCd",			Width:50,	Align:"Left",		Edit:true,	Hidden:true}
					,{Type:"Popup",		SaveName:"usrNm",			Width:100,	Align:"Left",		Edit:true}
					,{Type:"Radio",		SaveName:"rpstYn",			Width:30,	Align:"Center",		Edit:true, TrueValue:"Y", FalseValue:"N",  Sort:false}
					,{Type:"Combo",		SaveName:"prssAccCd",		Width:80,	Align:"Center",		Edit:true,	KeyField: 1}
					,{Type:"CheckBox",	SaveName:"srcViewYn",		Width:30,   Align:"Center",		TrueValue:"Y", FalseValue:"N",Edit:true}
					,{Type:"CheckBox",	SaveName:"useYn",			Width:30,   Align:"Center",		TrueValue:"Y", FalseValue:"N",Edit:true}
	            ];
	    
	    
	    InitColumns(cols);
	    FitColWidth();
	    SetExtendLastCol(1);
	    loadSheetOptions(sheetNm, 0, "prssAccCd", "/admin/stat/ajaxOption.do", {grpCd:"S2001"});
	    
	}               
	default_sheet(sheetObj);   
	doActionUsrSheet("search");	//조회
}

//분류 정보 시트 생성
function loadCateInfoSheet(sheetNm, sheetObj) {
	
	var gridTitle ="NO|상태|삭제|분류ID|분류|대표여부|사용여부";
	
	with(sheetObj){
		
		var cfg = {SearchMode:2,Page:50,VScrollMode:1};
		SetConfig(cfg);
		var headers = [
		               {Text:gridTitle, Align:"Center"}
		               ];
		var headerInfo = {Sort:0,ColMove:1,ColResize:1,HeaderCheck:0};
		
		InitHeaders(headers, headerInfo);
		
		var cols = [
	                 {Type:"Seq",		SaveName:"seq",				Width:30,	Align:"Center",		Edit:false}
	                ,{Type:"Status",	SaveName:"status",			Width:40,	Align:"Center",		Edit:false} 
	                ,{Type:"DelCheck",	SaveName:"del",				Width:30,	Align:"Center",		Edit:true}
	                ,{Type:"Text",		SaveName:"cateId",			Width:80,	Align:"Center",		Edit:true,	Hidden:false, KeyField: 1}
					,{Type:"Text",		SaveName:"cateFullNm",		Width:300,	Align:"Left",		Edit:true,	Hidden:false, KeyField: 1}
					,{Type:"Radio",		SaveName:"rpstYn",			Width:30,	Align:"Center",		Edit:true, TrueValue:"Y", FalseValue:"N",  Sort:false}
					,{Type:"CheckBox",	SaveName:"useYn",			Width:30,   Align:"Center",		TrueValue:"Y", FalseValue:"N",Edit:true}
	            ];
		
		
		InitColumns(cols);
		FitColWidth();
		SetExtendLastCol(1);
		
	}               
	default_sheet(sheetObj);   
	doActionCateInfoSheet("search");	//조회
	
	
}

//항목 시트 생성
function loadItmSheet(sheetNm, sheetObj) {
	
	var gridTitle ="NO";
	gridTitle +="|상태";
	gridTitle +="|\n선택";
	gridTitle +="|\n삭제";
	gridTitle +="|레벨";
	gridTitle +="|자료\n번호";
	gridTitle +="|시트항목명";
	gridTitle +="|영문출력항목명";
	gridTitle +="|차트항목명";
	gridTitle +="|영문차트항목명";
	gridTitle +="|단위";
	gridTitle +="|검증기준";
	gridTitle +="|\n필수\n입력";
	gridTitle +="|\n시트\n기본";
	gridTitle +="|\n차트\n기본";
	gridTitle +="|\nDUMMY";
	gridTitle +="|합계여부";
	gridTitle +="|\n사용\n여부";
	
	gridTitle +="|표준항목명";
	gridTitle +="|통계표ID";
	gridTitle +="|표준항목ID";
	gridTitle +="|상위자료번호";
	gridTitle +="|단위ID";
	gridTitle +="|주석식별자";
	gridTitle +="|주석";
	gridTitle +="|주석영문";
	gridTitle +="|차트유형";
	gridTitle +="|출력순서";
	gridTitle +="|맵핑코드";
	gridTitle +="|보기소수점";
	gridTitle +="|항목적용시작시점";
	gridTitle +="|항목적용종료년월";
	
	with(sheetObj){
		                     
		var cfg = {SearchMode:2,Page:50,VScrollMode:1, EditEnterBehavior:"none", ChildPage: 20};
	    SetConfig(cfg);
	    var headers = [
	                {Text:gridTitle, Align:"Center"}
	            ];
	    var headerInfo = {Sort:0,ColMove:1,ColResize:1,HeaderCheck:1};
	    
	    InitHeaders(headers, headerInfo);
	   
	    var cols = [
	                 {Type:"Seq",		SaveName:"seq",				Width:30,	Align:"Center",		Edit:false}
	                ,{Type:"Status",	SaveName:"status",			Width:40,	Align:"Center",		Edit:false}
	                ,{Type:"DummyCheck",SaveName:"chk",				Width:40,   Align:"Center",		Edit:true}
	                ,{Type:"DelCheck",	SaveName:"delChk",			Width:40,	Align:"Center",		Edit:true}
	                ,{Type:"Int",		SaveName:"Level",			Width:40,	Align:"Center",		Edit:false}
					,{Type:"Int",		SaveName:"datano",			Width:60,	Align:"Center",		Edit:false,	Format:"#####"}
					,{Type:"Text",		SaveName:"viewItmNm",		Width:230,	Align:"Left",		Edit:true,	TreeCol:1}
					,{Type:"Text",		SaveName:"engViewItmNm",	Width:60,	Align:"Left",		Edit:false,	Hidden:true}
					,{Type:"Text",		SaveName:"chartItmNm",		Width:200,	Align:"Left",		Edit:true,	Hidden:true}
					,{Type:"Text",		SaveName:"engChartItmNm",	Width:60,	Align:"Left",		Edit:false,	Hidden:true}
					,{Type:"Text",		SaveName:"uiNm",			Width:60,	Align:"Center",		Edit:false}
					,{Type:"Combo",		SaveName:"chckCd",			Width:80,	Align:"Center",		Edit:false,	Hidden:true}
					,{Type:"CheckBox",	SaveName:"inputNeedYn",		Width:60,   Align:"Center",		TrueValue:"Y", FalseValue:"N",	Edit:true}
					,{Type:"CheckBox",	SaveName:"defSelYn",		Width:60,   Align:"Center",		TrueValue:"Y", FalseValue:"N",	Edit:true}
					,{Type:"CheckBox",	SaveName:"cDefSelYn",		Width:60,   Align:"Center",		TrueValue:"Y", FalseValue:"N",	Edit:true}
					,{Type:"CheckBox",	SaveName:"dummyYn",			Width:60,	Align:"Center",		TrueValue:"Y", FalseValue:"N",	Edit:true}
					,{Type:"CheckBox",	SaveName:"sumavgYn",		Width:60,   Align:"Center",		TrueValue:"Y", FalseValue:"N",	Edit:true, Hidden:false}
					,{Type:"CheckBox",	SaveName:"useYn",			Width:60,   Align:"Center",		TrueValue:"Y", FalseValue:"N",	Edit:true}

					,{Type:"Text",		SaveName:"itmNm",			Width:110,	Align:"Left",		Edit:false,	Hidden:true}
					,{Type:"Text",		SaveName:"statblId",		Width:30,	Align:"Center",		Edit:false,	Hidden:true}
					,{Type:"Int",		SaveName:"itmId",			Width:30,	Align:"Center",		Edit:false,	Hidden:true}
					,{Type:"Int",		SaveName:"parDatano",		Width:30,	Align:"Center",		Edit:false,	Hidden:true}
					,{Type:"Text",		SaveName:"uiId",			Width:60,	Align:"Center",		Edit:false,	Hidden:true}
					,{Type:"Text",		SaveName:"cmmtIdtfr",		Width:30,	Align:"Center",		Edit:false,	Hidden:true}
					,{Type:"Text",		SaveName:"cmmtCont",		Width:80,	Align:"Left",		Edit:false,	Hidden:true}
					,{Type:"Text",		SaveName:"engCmmtCont",		Width:80,	Align:"Left",		Edit:false,	Hidden:true}
					,{Type:"Combo",		SaveName:"seriesCd",		Width:30,	Align:"Left",		Edit:false,	Hidden:true}
					,{Type:"Text",		SaveName:"vOrder",			Width:30,	Align:"Left",		Edit:false,	Hidden:true}
					,{Type:"Text",		SaveName:"refCd",			Width:30,	Align:"Left",		Edit:false,	Hidden:true}
					,{Type:"Text",		SaveName:"dmpointCd",		Width:30,	Align:"Left",		Edit:false,	Hidden:true}
					,{Type:"Text",		SaveName:"itmStartYm",		Width:30,	Align:"Left",		Edit:false,	Hidden:true}
					,{Type:"Text",		SaveName:"itmEndYm",		Width:30,	Align:"Left",		Edit:false,	Hidden:true}
					
	            ];
	    
	    
	    InitColumns(cols);
	    FitColWidth();
	    SetExtendLastCol(1);
	    
	    loadSheetOptions(sheetNm, 0, "chckCd", "/admin/stat/ajaxOption.do", {grpCd:"S1007"});	//검증코드
	    loadSheetOptions(sheetNm, 0, "seriesCd", "/admin/stat/ajaxOption.do", {grpCd:"S1111"});	//차트유형
	    
	}               
	default_sheet(sheetObj);
	
	doActionItmSheet("search", "itm");
}

//분류시트 생성
function loadCateSheet(sheetNm, sheetObj) {
	
	var gridTitle ="NO";
	gridTitle +="|상태";
	gridTitle +="|\n선택";
	gridTitle +="|\n삭제";
	gridTitle +="|레벨";
	gridTitle +="|자료\n번호";
	gridTitle +="|출력분류명";
	gridTitle +="|영문출력분류명";
	gridTitle +="|차트분류명";
	gridTitle +="|영문차트분류명";
	gridTitle +="|\n시트\n기본";
	gridTitle +="|\n차트\n기본";
	gridTitle +="|\nDUMMY";
	gridTitle +="|합계여부";
	gridTitle +="|\n사용\n여부";
	
	gridTitle +="|표준항목명";
	gridTitle +="|통계표ID";
	gridTitle +="|표준항목ID";
	gridTitle +="|상위자료번호";
	gridTitle +="|주석식별자";
	gridTitle +="|주석";
	gridTitle +="|영문주석";
	gridTitle +="|출력순서";
	gridTitle +="|맵핑코드";
	gridTitle +="|항목적용시작시점";
	gridTitle +="|항목적용종료년월";
	
	with(sheetObj){
		                     
		var cfg = {SearchMode:2,Page:50,VScrollMode:1};
	    SetConfig(cfg);
	    var headers = [
	                {Text:gridTitle, Align:"Center"}
	            ];
	    var headerInfo = {Sort:0,ColMove:1,ColResize:1,HeaderCheck:1, ChildPage: 20};
	    
	    InitHeaders(headers, headerInfo);
	   
	    var cols = [
	                 {Type:"Seq",		SaveName:"seq",				Width:30,	Align:"Center",		Edit:false}
	                ,{Type:"Status",	SaveName:"status",			Width:40,	Align:"Center",		Edit:false}
	                ,{Type:"DummyCheck",SaveName:"chk",				Width:40,   Align:"Center",		Edit:true}
	                ,{Type:"DelCheck",	SaveName:"delChk",			Width:40,	Align:"Center",		Edit:true}
	                ,{Type:"Int",		SaveName:"Level",			Width:40,	Align:"Center",		Edit:false}
					,{Type:"Int",		SaveName:"datano",			Width:60,	Align:"Center",		Edit:false,	Format:"#####"}
					,{Type:"Text",		SaveName:"viewItmNm",		Width:300,	Align:"Left",		Edit:true,	TreeCol:1}
					,{Type:"Text",		SaveName:"engViewItmNm",	Width:60,	Align:"Left",		Edit:true,	Hidden:true}
					,{Type:"Text",		SaveName:"chartItmNm",		Width:200,	Align:"Left",		Edit:true}
					,{Type:"Text",		SaveName:"engChartItmNm",	Width:60,	Align:"Left",		Edit:false,	Hidden:true}
					,{Type:"CheckBox",	SaveName:"defSelYn",		Width:60,   Align:"Center",		TrueValue:"Y", FalseValue:"N",	Edit:true}
					,{Type:"CheckBox",	SaveName:"cDefSelYn",		Width:60,   Align:"Center",		TrueValue:"Y", FalseValue:"N",	Edit:true}
					,{Type:"CheckBox",	SaveName:"dummyYn",			Width:60,	Align:"Center",		TrueValue:"Y", FalseValue:"N",	Edit:true}
					,{Type:"CheckBox",	SaveName:"sumavgYn",		Width:60,   Align:"Center",		TrueValue:"Y", FalseValue:"N",	Edit:true, Hidden:false}
					,{Type:"CheckBox",	SaveName:"useYn",			Width:60,   Align:"Center",		TrueValue:"Y", FalseValue:"N",	Edit:true}

					,{Type:"Text",		SaveName:"itmNm",			Width:110,	Align:"Left",		Edit:false,	Hidden:true}
					,{Type:"Text",		SaveName:"statblId",		Width:30,	Align:"Center",		Edit:false,	Hidden:true}
					,{Type:"Int",		SaveName:"itmId",			Width:30,	Align:"Center",		Edit:false,	Hidden:true}
					,{Type:"Int",		SaveName:"parDatano",		Width:30,	Align:"Center",		Edit:false,	Hidden:true}
					,{Type:"Text",		SaveName:"cmmtIdtfr",		Width:30,	Align:"Center",		Edit:false,	Hidden:true}
					,{Type:"Text",		SaveName:"cmmtCont",		Width:80,	Align:"Left",		Edit:false,	Hidden:true}
					,{Type:"Text",		SaveName:"engCmmtCont",		Width:80,	Align:"Left",		Edit:false,	Hidden:true}
					,{Type:"Text",		SaveName:"vOrder",			Width:30,	Align:"Left",		Edit:false,	Hidden:true}
					,{Type:"Text",		SaveName:"refCd",			Width:30,	Align:"Left",		Edit:false,	Hidden:true}
					,{Type:"Text",		SaveName:"itmStartYm",		Width:30,	Align:"Left",		Edit:false,	Hidden:true}
					,{Type:"Text",		SaveName:"itmEndYm",		Width:30,	Align:"Left",		Edit:false,	Hidden:true}
	            ];
	    
	    InitColumns(cols);
	    FitColWidth();
	    SetExtendLastCol(1);
	}               
	default_sheet(sheetObj);
	doActionItmSheet("search", "cate");
}

//그룹시트 생성
function loadGroupSheet(sheetNm, sheetObj) {
	
	var gridTitle ="NO";
	gridTitle +="|상태";
	gridTitle +="|\n선택";
	gridTitle +="|\n삭제";
	gridTitle +="|레벨";
	gridTitle +="|자료\n번호";
	gridTitle +="|출력그룹명";
	gridTitle +="|영문출력그룹명";
	gridTitle +="|차트그룹명";
	gridTitle +="|영문차트그룹명";
	gridTitle +="|\n시트\n기본";
	gridTitle +="|\n차트\n기본";
	gridTitle +="|\nDUMMY";
	gridTitle +="|합계여부";
	gridTitle +="|\n사용\n여부";
	
	gridTitle +="|표준항목명";
	gridTitle +="|통계표ID";
	gridTitle +="|표준항목ID";
	gridTitle +="|상위자료번호";
	gridTitle +="|주석식별자";
	gridTitle +="|주석";
	gridTitle +="|영문주석";
	gridTitle +="|출력순서";
	gridTitle +="|맵핑코드";
	gridTitle +="|항목적용시작시점";
	gridTitle +="|항목적용종료년월";
	
	with(sheetObj){
		                     
		var cfg = {SearchMode:2,Page:50,VScrollMode:1};
	    SetConfig(cfg);
	    var headers = [
	                {Text:gridTitle, Align:"Center"}
	            ];
	    var headerInfo = {Sort:0,ColMove:1,ColResize:1,HeaderCheck:1, ChildPage: 20};
	    
	    InitHeaders(headers, headerInfo);
	   
	    var cols = [
	                 {Type:"Seq",		SaveName:"seq",				Width:30,	Align:"Center",		Edit:false}
	                ,{Type:"Status",	SaveName:"status",			Width:40,	Align:"Center",		Edit:false}
	                ,{Type:"DummyCheck",SaveName:"chk",				Width:40,   Align:"Center",		Edit:true}
	                ,{Type:"DelCheck",	SaveName:"delChk",			Width:40,	Align:"Center",		Edit:true}
	                ,{Type:"Int",		SaveName:"Level",			Width:40,	Align:"Center",		Edit:false}
					,{Type:"Int",		SaveName:"datano",			Width:60,	Align:"Center",		Edit:false,	Format:"#####"}
					,{Type:"Text",		SaveName:"viewItmNm",		Width:300,	Align:"Left",		Edit:true,	TreeCol:1}
					,{Type:"Text",		SaveName:"engViewItmNm",	Width:60,	Align:"Left",		Edit:true,	Hidden:true}
					,{Type:"Text",		SaveName:"chartItmNm",		Width:200,	Align:"Left",		Edit:true}
					,{Type:"Text",		SaveName:"engChartItmNm",	Width:60,	Align:"Left",		Edit:false,	Hidden:true}
					,{Type:"CheckBox",	SaveName:"defSelYn",		Width:60,   Align:"Center",		TrueValue:"Y", FalseValue:"N",	Edit:true}
					,{Type:"CheckBox",	SaveName:"cDefSelYn",		Width:60,   Align:"Center",		TrueValue:"Y", FalseValue:"N",	Edit:true}
					,{Type:"CheckBox",	SaveName:"dummyYn",			Width:60,	Align:"Center",		TrueValue:"Y", FalseValue:"N",	Edit:true}
					,{Type:"CheckBox",	SaveName:"sumavgYn",		Width:60,   Align:"Center",		TrueValue:"Y", FalseValue:"N",	Edit:true, Hidden:false}
					,{Type:"CheckBox",	SaveName:"useYn",			Width:60,   Align:"Center",		TrueValue:"Y", FalseValue:"N",	Edit:true}

					,{Type:"Text",		SaveName:"itmNm",			Width:110,	Align:"Left",		Edit:false,	Hidden:true}
					,{Type:"Text",		SaveName:"statblId",		Width:30,	Align:"Center",		Edit:false,	Hidden:true}
					,{Type:"Int",		SaveName:"itmId",			Width:30,	Align:"Center",		Edit:false,	Hidden:true}
					,{Type:"Int",		SaveName:"parDatano",		Width:30,	Align:"Center",		Edit:false,	Hidden:true}
					,{Type:"Text",		SaveName:"cmmtIdtfr",		Width:30,	Align:"Center",		Edit:false,	Hidden:true}
					,{Type:"Text",		SaveName:"cmmtCont",		Width:80,	Align:"Left",		Edit:false,	Hidden:true}
					,{Type:"Text",		SaveName:"engCmmtCont",		Width:80,	Align:"Left",		Edit:false,	Hidden:true}
					,{Type:"Text",		SaveName:"vOrder",			Width:30,	Align:"Left",		Edit:false,	Hidden:true}
					,{Type:"Text",		SaveName:"refCd",			Width:30,	Align:"Left",		Edit:false,	Hidden:true}
					,{Type:"Text",		SaveName:"itmStartYm",		Width:30,	Align:"Left",		Edit:false,	Hidden:true}
					,{Type:"Text",		SaveName:"itmEndYm",		Width:30,	Align:"Left",		Edit:false,	Hidden:true}
	            ];
	    
	    InitColumns(cols);
	    FitColWidth();
	    SetExtendLastCol(1);
	}               
	default_sheet(sheetObj);
	doActionItmSheet("search", "group");
}

////////////////////////////////////////////////////////////////////////////////
//시트 서비스 함수
////////////////////////////////////////////////////////////////////////////////
//항목 시트 원본 데이터 가져오기
function getItmOriginData(itmSheetObj) {
	var jData = new Object();
	var jList = new Array();
	var jRow = null;
	
	if ( itmSheetObj.RowCount() > 0 ) {
		for ( var i=1; i <= itmSheetObj.RowCount(); i++ ) {
			jRow = itmSheetObj.GetRowData(i);
			jList.push(jRow);
		}
		jData.data = JSON.parse(JSON.stringify(jList));
	}
	return jData;
}

//항목 데이터 row 가져오기
function getItmData(itmData, idx, arrDataOpt) {	
	var itmDataLength = arrDataOpt.itmDataLength 	|| 0;
	var loopCnt = arrDataOpt.loopCnt 				|| 0;
	var parDatano = arrDataOpt.parDatano 			|| 0;
	var chkRowLvl = arrDataOpt.chkRowLvl 			|| 0;	//선택한(체크한) 행 레벨
	
	// loop 횟수에 따라 전체 자료번호가 증가
	var loopDatano = itmDataLength * loopCnt;
	
	var jRow = new Object();
	jRow.status = "I";
	//jRow.Level = itmData[idx].Level;	//ibs에서 tree구조 표현하려면 있어야함.
	jRow.Level = chkRowLvl == 0 ? itmData[idx].Level : itmData[idx].Level + chkRowLvl;	//ibs에서 tree구조 표현하려면 있어야함.
	jRow.itmId = itmData[idx].itmId;
	jRow.itmNm = itmData[idx].itmNm;
	jRow.parDatano = parDatano;
	jRow.datano = itmData[idx].datano + loopDatano;
	jRow.viewItmNm = itmData[idx].itmNm;
	jRow.engViewItmNm = itmData[idx].engItmNm;
	jRow.chartItmNm = itmData[idx].itmNm;
	jRow.engChartItmNm = itmData[idx].engItmNm;
	jRow.uiId = "";
	jRow.defSelYn = "Y";
	jRow.cDefSelYn = "Y";
	jRow.useYn = "Y";
	jRow.seriesCd = "";
	jRow.chckCd = "";
	jRow.vOrder = idx + 1;
	return jRow;
}

//선택한 항목 원본 sheet에 넣기
function setItmTree(gb) {
	var classObj = $("."+tabContentClass); //tab으로 인하여 form이 다건임
	var actObj = setTabForm2(classObj, "statsMgmt-mst-form"); // 0: form data, 1: form 객체
	var objTab = getTabShowObj();//탭이 oepn된 객체가져옴
	var formObj = objTab.find("form[name=statsMgmt-mst-form]");
	var itmSheetNm = formObj.find("input[name="+gb+"SheetNm]").val();
	var itmSheetObj = window[itmSheetNm];
	
	var jData = new Object();
	var jList = new Array();
	var jRow = new Object();
	
	//팝업에서 추가하려는 Json Data
	//var itmJsonTxt = formObj.find("input[name=itmJson]").val();
	var itmJsonTxt = formObj.find("input[name="+gb+"Json]").val();
	var itmJsonObj = JSON.parse(itmJsonTxt);
	var itmData = itmJsonObj.data;
	var iDataGb = itmJsonObj.gb;
	var iGbLvl = itmJsonObj.gbLvl;
	var iSelDatano = itmJsonObj.selDatano;
	var allLoopCnt = 0;

	if ( itmSheetObj.RowCount() > 0 ) {	//원본(기존) 데이터가 있는경우
		var jOriData = getItmOriginData(itmSheetObj).data;
		var arrDataOpt = new Array();
		for ( var i=0; i < jOriData.length; i++ ) {
			jRow = jOriData[i];
			jList.push(jRow);	//원본데이터 집어넣고

			if ( iDataGb == "FIX" ) {	//선택 항목 추가인경우
				if ( jRow.datano == iSelDatano ) {
					for ( var j=0; j < itmData.length; j++ ) {
						jList.push(getItmData(itmData, j, {
							itmDataLength : 0,
							loopCnt : 0,
							parDatano : jRow.datano
						}));
					}
				}
			} else if ( iDataGb == "FIX_CHK" ) {	
				//선택 항목 추가인 경우(부모창에 체크된 항목들에 추가할 경우)
				if ( jRow.chk == 1 ) {	//체크된 행 일경우
					for ( var j=0; j < itmData.length; j++ ) {	//itemdata 추가
						jList.push(getItmData(itmData, j, {
							itmDataLength : itmData.length,
							loopCnt : allLoopCnt++,
							parDatano : jRow.datano,
							chkRowLvl : jRow.Level
						}));
					}
				}
			} else if ( iDataGb == "ALL" ) {	//전체 항목추가인 경우
				if ( jRow.Level == iGbLvl ) {	//선택한 레벨이 같으면
					for ( var j=0; j < itmData.length; j++ ) {	//itemdata 추가
						jList.push(getItmData(itmData, j, {
							itmDataLength : itmData.length,
							loopCnt : allLoopCnt++,
							parDatano : jRow.datano
						}));
					}
				} 
			}
		}
		//선택한 레벨이 0이면(최상위)
		if ( iDataGb == "ALL" && iGbLvl == 0 ) {
			//이전 jList값 밑에 신규 데이터(최상위데이터) 합침.
			jList = jList.concat(setItmTreeTopLevel(itmData));
		}
	} else {
		jList = setItmTreeTopLevel(itmData);
	}
	jData.data = JSON.parse(JSON.stringify(jList));
	
	itmSheetObj.LoadSearchData(jData, {
        Sync : 1,
        CallBack : setItmTreeCallback
    });
}

//항목/분류 추가시 최상위 레벨로 추가할 경우
function setItmTreeTopLevel(itmData) {
	var jList = new Array();
	var preLvl = 0;
	var preDatano = 0;
	var parDatano = 0;
	var lvl = 0;
	var obj = null;
	for ( var i=0; i < itmData.length; i++ ) {
		obj = getItmData(itmData, i, {
			itmDataLength : 0,
			loopCnt : 0,
			parDatano : 0
		});
		jList.push(obj);
	}
	return jList;
}

/**
 * 항목/분류 팝업 적용 후 콜백 이벤트
 * 	부모-자식 관계에 따라 datano와 parDatano를 for loop을 통해 재 입력함.
 * @param treeSheet	작업중인 시트
 * @param code
 */
function setItmTreeCallback(treeSheet, code) {
	var jRow = new Object();
	var preLevel = 0;
	var level = 0;
	var parDatano = 0;
	
	if ( treeSheet.RowCount() > 0 ) {
		for ( var i=1; i <= treeSheet.RowCount(); i++ ) {
			jRow = treeSheet.GetRowData(i);
			level = jRow.Level;
			
			if ( level == 1 ) {	//레벨이 1인경우 부모 값은 0
				treeSheet.SetCellValue(i, "parDatano", 0);
			} else if ( preLevel < level ) {
				//이전 행의 레벨이 현재 행의 레벨보다 높은경우 이전행의 datano를 부모id로 한다.
				treeSheet.SetCellValue(i, "parDatano", preDatano);	
				parDatano = preDatano;
			} else if ( preLevel > level ) {
				//이전 행의 레벨이 현재 행의 레벨보다 작은경우 현재행의 동일레벨의 행을 가져와서 부모datano를 입력한다.
				var preSameLvlRow = treeSheet.GetPrevSiblingRow(i);
				var prevSameLvlParDatano = treeSheet.GetCellValue(preSameLvlRow, "parDatano");
				treeSheet.SetCellValue(i, "parDatano", prevSameLvlParDatano);
				parDatano = prevSameLvlParDatano;
			} else if ( preLevel == level ) {
				treeSheet.SetCellValue(i, "parDatano", parDatano);
			}
			preLevel = level;
			preDatano = jRow.datano;
		}
		
		treeSheet.CheckAll("chk", 0);	//시트 선택 체크 초기화(언체크시킴)
	}
}


//항목/분류 반영 버튼 이벤트
function setItmChgVal(gb) {
	var objTab = getTabShowObj();//탭이 oepn된 객체가져옴
	var formObj = objTab.find("form[name=statsMgmt-mst-form]");
	var itmSheetNm = formObj.find("input[name="+gb+"SheetNm]").val();
	var itmSheetObj = window[itmSheetNm];

	var selItmRow = Number(formObj.find("input[name=sel"+gb+"Row]").val());
	if ( selItmRow <= 0 ) {
		return;
	} else {
		if (  !com.wise.util.isBlank(formObj.find("input[name="+gb+"CmmtIdtfr]").val()) 
				&& !com.wise.util.isNumeric(formObj.find("input[name="+gb+"CmmtIdtfr]").val()) ) {
			alert("식별번호는 숫자만 입력하세요.");
			formObj.find("input[name="+gb+"CmmtIdtfr]").val("");
			return false;
		}
		itmSheetObj.SetCellValue(selItmRow, itmSheetObj.SaveNameCol("parDatano"), formObj.find("input[name="+gb+"ParDatano]").val());	// 부모자료번호
		itmSheetObj.SetCellValue(selItmRow, itmSheetObj.SaveNameCol("viewItmNm"), formObj.find("input[name="+gb+"ViewItmNm]").val());
		itmSheetObj.SetCellValue(selItmRow, itmSheetObj.SaveNameCol("engViewItmNm"), formObj.find("input[name="+gb+"EngViewItmNm]").val());
		itmSheetObj.SetCellValue(selItmRow, itmSheetObj.SaveNameCol("chartItmNm"), formObj.find("input[name="+gb+"ChartItmNm]").val());
		itmSheetObj.SetCellValue(selItmRow, itmSheetObj.SaveNameCol("engChartItmNm"), formObj.find("input[name="+gb+"EngChartItmNm]").val());
		itmSheetObj.SetCellValue(selItmRow, itmSheetObj.SaveNameCol("cmmtIdtfr"), formObj.find("input[name="+gb+"CmmtIdtfr]").val());
		itmSheetObj.SetCellValue(selItmRow, itmSheetObj.SaveNameCol("cmmtCont"), formObj.find("textarea[name="+gb+"CmmtCont]").val());
		itmSheetObj.SetCellValue(selItmRow, itmSheetObj.SaveNameCol("engCmmtCont"), formObj.find("textarea[name="+gb+"EngCmmtCont]").val());
		itmSheetObj.SetCellValue(selItmRow, itmSheetObj.SaveNameCol("useYn"), formObj.find("input[name="+gb+"UseYn]:checked").val());
		itmSheetObj.SetCellValue(selItmRow, itmSheetObj.SaveNameCol("dummyYn"), formObj.find("input[name="+gb+"DummyYn]").is(":checked") ? "Y" : "N");
		itmSheetObj.SetCellValue(selItmRow, itmSheetObj.SaveNameCol("defSelYn"), formObj.find("input[name="+gb+"DefSelYn]").is(":checked") ? "Y" : "N");
		itmSheetObj.SetCellValue(selItmRow, itmSheetObj.SaveNameCol("cDefSelYn"), formObj.find("input[name="+gb+"CDefSelYn]").is(":checked") ? "Y" : "N");
		itmSheetObj.SetCellValue(selItmRow, itmSheetObj.SaveNameCol("refCd"), formObj.find("input[name="+gb+"RefCd]").val());
		itmSheetObj.SetCellValue(selItmRow, itmSheetObj.SaveNameCol("sumavgYn"), formObj.find("input[name="+gb+"SumavgYn]").is(":checked") ? "Y" : "N");	//합계여부
		itmSheetObj.SetCellValue(selItmRow, itmSheetObj.SaveNameCol("itmStartYm"), formObj.find("input[name="+gb+"StartYm]").val());
		itmSheetObj.SetCellValue(selItmRow, itmSheetObj.SaveNameCol("itmEndYm"), formObj.find("input[name="+gb+"EndYm]").val());
		if ( getGbStr(gb) == "I"  ) {	//항목인 경우
			itmSheetObj.SetCellValue(selItmRow, itmSheetObj.SaveNameCol("inputNeedYn"), formObj.find("input[name="+gb+"InputNeedYn]").is(":checked") ? "Y" : "N");
			itmSheetObj.SetCellValue(selItmRow, itmSheetObj.SaveNameCol("uiId"), formObj.find("input[name="+gb+"UiId]").val());
			itmSheetObj.SetCellValue(selItmRow, itmSheetObj.SaveNameCol("uiNm"), formObj.find("input[name="+gb+"UiNm]").val());
			itmSheetObj.SetCellValue(selItmRow, itmSheetObj.SaveNameCol("seriesCd"), formObj.find("select[name="+gb+"SeriesCd]").val());
			itmSheetObj.SetCellValue(selItmRow, itmSheetObj.SaveNameCol("chckCd"), formObj.find("select[name="+gb+"ChckCd]").val());
			itmSheetObj.SetCellValue(selItmRow, itmSheetObj.SaveNameCol("dmpointCd"), formObj.find("select[name="+gb+"DmpointCd]").val());
			if ( formObj.find("input[name="+gb+"UiAllChk]:checked").val() == "Y" ) {	//선택항목 동일체크(단위) 버튼이 체크되어있으면
				var chkRows = itmSheetObj.FindCheckedRow("chk");	//체크한 rows
				var chkArr = chkRows.split('|');
				for ( var i=0; i < chkArr.length; i++ ) {
					itmSheetObj.SetCellValue(chkArr[i], itmSheetObj.SaveNameCol("uiId"), formObj.find("input[name="+gb+"UiId]").val());
					itmSheetObj.SetCellValue(chkArr[i], itmSheetObj.SaveNameCol("uiNm"), formObj.find("input[name="+gb+"UiNm]").val());
				}
				formObj.find("input[name="+gb+"UiAllChk]").prop("checked", false);	//체크 되어있으면 값 세팅하고 체크 푼다.
			}
			
			if ( formObj.find("input[name="+gb+"SeriesAllChk]:checked").val() == "Y" ) {	//선택항목 동일체크(차트시리즈) 버튼이 체크되어있으면
				var chkRows = itmSheetObj.FindCheckedRow("chk");	//체크한 rows
				var chkArr = chkRows.split('|');
				for ( var i=0; i < chkArr.length; i++ ) {
					itmSheetObj.SetCellValue(chkArr[i], itmSheetObj.SaveNameCol("seriesCd"), formObj.find("select[name="+gb+"SeriesCd]").val());	// 
				}
				formObj.find("input[name="+gb+"SeriesAllChk]").prop("checked", false);	//체크 되어있으면 값 세팅하고 체크 푼다.
			}
			
		}
	}
}

//트리순서 위로 이동
function tblTreeUp(ibsObj, sortColNm) {
	var moveCnt;
	var selectRow = ibsObj.GetSelectRow();						//현재 선택행
	var selectRowLevel = ibsObj.GetRowLevel(selectRow);			//현재 선택행 레벨
	var selectHighRowLevel = ibsObj.GetRowLevel(selectRow-1);	//현재 선택행 상위행레벨
	var childNodeCnt = ibsObj.GetChildNodeCount(selectRow);		//하위 노드숫자
	var selectTblTag = ibsObj.GetCellValue(selectRow, "statblTag");
	
	if ( selectRow == "" ) return;
	if ( selectRow == 1  ) return;
	
	if ( selectRowLevel == 0 || selectTblTag == "C" )  {
		alert("분류체계는 순서 이동 할 수 없습니다.");
		return false;
	}
	
	if ( childNodeCnt == 0 ) {		// 최 하위 레벨이면
		if ( selectRowLevel != selectHighRowLevel ) {
			alert("같은 레벨간에만 이동 가능합니다.");
			return;
		} else if ( ibsObj.GetCellValue(selectRow-1, "statblTag") == "C" ) {
			alert("상위 항목이 분류체계 입니다.\n분류체계는 순서 변경 할 수 없습니다.");
			return false;
		} else {
			ibsObj.DataMove(selectRow-1, selectRow);
		}
	} else {								// 중간 레벨이면
		for ( var i=selectRow; i>0; i-- ) {
			if ( selectRowLevel > ibsObj.GetRowLevel(i-1) ) {
				alert("같은 레벨간에만 이동 가능합니다.");
				return;
			} else if ( ibsObj.GetCellValue(selectRow-1, "statblTag") == "C" ) {
				alert("상위 항목이 분류체계 입니다.\n분류체계는 순서 변경 할 수 없습니다.");
				return false;
			} else if ( selectRowLevel == ibsObj.GetRowLevel(i-1) ) {
				moveCnt = i-1;
				break;
			}
		}
		ibsObj.DataMove(moveCnt, selectRow);
	}
	ibsObj.ReNumberSeq();	
	
	treeOrderSet(ibsObj, sortColNm);
	
}

//트리 순서 아래로 이동
function tblTreeDown(ibsObj, sortColNm) {
	var moveCnt;
	var selectRow = ibsObj.GetSelectRow();							//현재 선택행
	var selectRowLevel = ibsObj.GetRowLevel(selectRow);				//현재 선택행 레벨
	var selectLowRowLevel = ibsObj.GetRowLevel(selectRow+1);		//현재 선택행 상위행레벨
	var childNodeCnt = ibsObj.GetChildNodeCount(selectRow);			//하위 노드숫자
	var selectTblTag = ibsObj.GetCellValue(selectRow, "statblTag");
	
	if ( selectRow == "" ) return;
	if ( selectRow == ibsObj.RowCount() ) return;
	
	if ( selectRowLevel == 0 || selectTblTag == "C" )  {
		alert("분류체계는 순서 이동 할 수 없습니다.");
		return false;
	}
	
	if ( childNodeCnt == 0 ) {		// 최 하위 레벨이면
		if ( selectRowLevel != selectLowRowLevel ) {
			alert("같은 레벨간에만 이동 가능합니다."); 
			return;
		} else if ( ibsObj.GetCellValue(selectRow+1, "statblTag") == "C" ) {
			alert("하위 항목이 분류체계 입니다.\n분류체계는 순서 이동 할 수 없습니다.");
			return false;	
		} else {
			ibsObj.DataMove(selectRow+2, selectRow);
		}
	} else {								// 중간 레벨이면
		for ( var i=selectRow; i<ibsObj.RowCount(); i++ ) {
			if ( selectRowLevel > ibsObj.GetRowLevel(i+1) ) {
				alert("같은 레벨간에만 이동 가능합니다.");
				return;
			} else if ( ibsObj.GetCellValue(selectRow+1, "statblTag") == "C" ) {
				alert("하위 항목이 분류체계 입니다.\n분류체계는 순서 이동 할 수 없습니다.");
				return false;	
			} else if ( selectRowLevel == ibsObj.GetRowLevel(i+1) ) {
				moveCnt = i+2;
				break;
			}
		}
		ibsObj.DataMove(moveCnt, selectRow);
	}
	ibsObj.ReNumberSeq();
	
	treeOrderSet(ibsObj, sortColNm);
}

/**
 * 트리 레벨 및 순서에 맞게 재정의
 * @param sheetObj
 */
function treeOrderSet(sheetObj) {
	var topOrdCnt = 0;				//1 레벨 순서
	var arrOrdCnt = new Array();	//2 레벨 이상부터의 순서 배열
	
	//전체 ROW for
	for ( var i=1; i <= sheetObj.RowCount(); i++ ) {
		var lvl = sheetObj.GetCellValue(i, "Level");	//현재 row의 레벨
		var cntIdx = lvl - 2;	//숫자 배열 인덱스(배열은 0부터 시작해서 - 2 함)
		
		if ( lvl == 1 ) {
			//1 레벨이면
			arrOrdCnt = [];		//레벨 순서에 배열 초기화
			sheetObj.SetCellValue(i, "vOrder", ++topOrdCnt);
		} 
		else {
			//1 레벨이 아니면(2레벨 이상인경우)
			var ordCnt = arrOrdCnt[cntIdx];		//현재 레벨의 순서를 확인
			if ( gfn_isNull(ordCnt) ) {
				//공백인 경우 1로 시작
				arrOrdCnt[cntIdx] = 1;
			} 
			else {
				//값이 있는 경우 1 증가하여 입력
				arrOrdCnt[cntIdx] = ++ordCnt;
			}
			sheetObj.SetCellValue(i, "vOrder", arrOrdCnt[cntIdx]);
		}
	}
}

//메인 시트 더블클릭 이벤트
function statSheet_OnDblClick(row, col, value, cellx, celly) {
	if (row < 1) return;
	if ( statSheet.GetCellValue(row, "statblTag") != "T" )	{
		return false;	//통계표 데이터가 아닌경우 상세로 넘어가지 않음.
	}
	
	tabEvent(row);
}

/**
 * 부모 노드에서 트리 확장기능을 선택했을 때 이벤트가 발생(선택한 하위 노드 조회한다.)
 */
function statSheet_OnTreeChild(row) {	

	var statblId = statSheet.GetCellValue(row, "statblId");
	var params = $("form[name=statMainForm]").serialize() + "&parStatblId="+statblId;
	//하위 노드 조회
	statSheet.DoSearchChild(row, com.wise.help.url("/admin/stat/statsMgmtList.do"), params , {wait: 1, Sync: 2});
	
	statSheet.ReNumberSeq();
	
	// 하위 트리 모두 펼침
	var childRows = statSheet.GetChildRows(row).split("|");
	for ( var i=0; i < childRows.length; i++ ) 
	{
		var cRow = childRows[i];
		var statblTag = statSheet.GetCellValue(cRow, "statblTag");
		var haveChild = statSheet.IsHaveChild(cRow);
		if ( statblTag == "C" && haveChild > 0 ) {
			// 트리가 분류면서 자식이 있는 것들만  
			statSheet.SetRowExpanded(cRow, 1);	// 트리 항목 펼침
		}
	}
}

//항목 시트 클릭이벤트
function itmSheetOnClick(row, col, value) {
	var objTab = getTabShowObj();//탭이 oepn된 객체가져옴
	var formObj = objTab.find("form[name=statsMgmt-mst-form]");
	var itmSheetNm = formObj.find("input[name=itmSheetNm]").val();
	var itmSheetObj = window[itmSheetNm];
	itmCommSheetOnClick("itm", itmSheetObj, row);
}

/*
 * 항목 시트 셀 변경 이벤트
 *	- 폼에서 데이터 변경 후 다른 row 클릭 했을경우 변경한 데이터 자동 반영
 */
function itmSheetOnSelectCell(oldRow, oldCol, newRow, newCol, isDelete) {
	var objTab = getTabShowObj();//탭이 oepn된 객체가져옴
	var formObj = objTab.find("form[name=statsMgmt-mst-form]");
	var selItmRow = Number(formObj.find("input[name=selitmRow]").val());
	if ( oldRow <= 1 ) 	return;	//헤더 행은 제외
	if ( oldRow != newRow  && oldRow == selItmRow ) {	//이전 선택 행과 현재 선택 행이 다른경우
		setItmChgVal("itm");	//변경하던 데이터 반영한다.
	}
}

/**
 * 출력항목명 수정했을경우 폼 값에 수정된 내용 바로 반영하기 위한 이벤트
 */
function itmSheetOnAfterEdit(row, col) {
	if ( row < 1 ) return;
	var objTab = getTabShowObj();//탭이 oepn된 객체가져옴
	var formObj = objTab.find("form[name=statsMgmt-mst-form]");
	var itmSheetNm = formObj.find("input[name=itmSheetNm]").val();
	var itmSheetObj = window[itmSheetNm];
	
	var selItmRow = Number(formObj.find("input[name=selitmRow]").val());
	if ( selItmRow <= 0 ) {
		return;
	} else {
		formObj.find("input[name=itmViewItmNm]").val(itmSheetObj.GetCellValue(selItmRow, itmSheetObj.SaveNameCol("viewItmNm")));	//시트항목명
		formObj.find("input[name=itmChartItmNm]").val(itmSheetObj.GetCellValue(selItmRow, itmSheetObj.SaveNameCol("chartItmNm")));	//차트항목명
	}
}

//분류 시트 클릭이벤트
function cateSheetOnClick(row, col, value) {
	var objTab = getTabShowObj();//탭이 oepn된 객체가져옴
	var formObj = objTab.find("form[name=statsMgmt-mst-form]");
	var itmSheetNm = formObj.find("input[name=cateSheetNm]").val();
	var itmSheetObj = window[itmSheetNm];
	itmCommSheetOnClick("cate", itmSheetObj, row);
}

/*
 * 분류 시트 셀 변경 이벤트
 *	- 폼에서 데이터 변경 후 다른 row 클릭 했을경우 변경한 데이터 자동 반영
 */
function cateSheetOnSelectCell(oldRow, oldCol, newRow, newCol, isDelete) {
	var objTab = getTabShowObj();//탭이 oepn된 객체가져옴
	var formObj = objTab.find("form[name=statsMgmt-mst-form]");
	var selCateRow = Number(formObj.find("input[name=selcateRow]").val());
	if ( oldRow != newRow && oldRow == selCateRow ) {	//이전 선택 행과 현재 선택 행이 다른경우
		setItmChgVal("cate");	//변경하던 데이터 반영한다.
	}
}

//그룹 시트 클릭이벤트
function groupSheetOnClick(row, col, value) {
	var objTab = getTabShowObj();//탭이 oepn된 객체가져옴
	var formObj = objTab.find("form[name=statsMgmt-mst-form]");
	var itmSheetNm = formObj.find("input[name=groupSheetNm]").val();
	var itmSheetObj = window[itmSheetNm];
	itmCommSheetOnClick("group", itmSheetObj, row);
}

/*
 * 그룹 시트 셀 변경 이벤트
 *	- 폼에서 데이터 변경 후 다른 row 클릭 했을경우 변경한 데이터 자동 반영
 */
function groupSheetOnSelectCell(oldRow, oldCol, newRow, newCol, isDelete) {
	var objTab = getTabShowObj();//탭이 oepn된 객체가져옴
	var formObj = objTab.find("form[name=statsMgmt-mst-form]");
	var selGroupRow = Number(formObj.find("input[name=selgroupRow]").val());
	if ( oldRow != newRow && oldRow == selGroupRow ) {	//이전 선택 행과 현재 선택 행이 다른경우
		setItmChgVal("group");	//변경하던 데이터 반영한다.
	}
}

/**
 * 출력항목명 수정했을경우 폼 값에 수정된 내용 바로 반영하기 위한 이벤트
 */
function cateSheetOnAfterEdit(row, col) {
	if ( row < 1 ) return;
	var objTab = getTabShowObj();//탭이 oepn된 객체가져옴
	var formObj = objTab.find("form[name=statsMgmt-mst-form]");
	var itmSheetNm = formObj.find("input[name=cateSheetNm]").val();
	var itmSheetObj = window[itmSheetNm];
	
	var selItmRow = Number(formObj.find("input[name=selcateRow]").val());
	if ( selItmRow <= 0 ) {
		return;
	} else {
		formObj.find("input[name=cateViewItmNm]").val(itmSheetObj.GetCellValue(selItmRow, itmSheetObj.SaveNameCol("viewItmNm")));	//시트항목명
		formObj.find("input[name=cateChartItmNm]").val(itmSheetObj.GetCellValue(selItmRow, itmSheetObj.SaveNameCol("chartItmNm")));	//차트항목명
	}
}

/**
 * 출력항목명 수정했을경우 폼 값에 수정된 내용 바로 반영하기 위한 이벤트 - 그룹
 */
function groupSheetOnAfterEdit(row, col) {
	if ( row < 1 ) return;
	var objTab = getTabShowObj();//탭이 oepn된 객체가져옴
	var formObj = objTab.find("form[name=statsMgmt-mst-form]");
	var itmSheetNm = formObj.find("input[name=groupSheetNm]").val();
	var itmSheetObj = window[itmSheetNm];
	
	var selItmRow = Number(formObj.find("input[name=selgroupRow]").val());
	if ( selItmRow <= 0 ) {
		return;
	} else {
		formObj.find("input[name=groupViewItmNm]").val(itmSheetObj.GetCellValue(selItmRow, itmSheetObj.SaveNameCol("viewItmNm")));	//시트항목명
		formObj.find("input[name=groupChartItmNm]").val(itmSheetObj.GetCellValue(selItmRow, itmSheetObj.SaveNameCol("chartItmNm")));	//차트항목명
	}
}

function itmCommSheetOnClick(gb, itmSheetObj, row) {
	var objTab = getTabShowObj();//탭이 oepn된 객체가져옴
	var formObj = objTab.find("form[name=statsMgmt-mst-form]");
	var rowInit = itmSheetObj.RowCount() == 0 ? true : false;	//시트에 데이터가 없는경우 공백으로 표시
	formObj.find("input[name=sel"+gb+"Row]").val(row);
	formObj.find("input[name="+gb+"DummyYn], input[name="+gb+"DefSelYn], input[name="+gb+"CDefSelYn], input[name="+gb+"SumavgYn]").prop("checked", false);
	formObj.find("label[name=stdd"+gb+"Nm]").text(rowInit ? "" : itmSheetObj.GetCellValue(row, itmSheetObj.SaveNameCol("itmNm")));
	formObj.find("input[name="+gb+"Datano]").val(rowInit ? "" : itmSheetObj.GetCellValue(row, itmSheetObj.SaveNameCol("datano")));
	formObj.find("input[name="+gb+"ParDatano]").val(rowInit ? "" : itmSheetObj.GetCellValue(row, itmSheetObj.SaveNameCol("parDatano")));	// 부모자료번호
	formObj.find("input[name="+gb+"ViewItmNm]").val(rowInit ? "" : itmSheetObj.GetCellValue(row, itmSheetObj.SaveNameCol("viewItmNm")));
	formObj.find("input[name="+gb+"EngViewItmNm]").val(rowInit ? "" : itmSheetObj.GetCellValue(row, itmSheetObj.SaveNameCol("engViewItmNm")));
	formObj.find("input[name="+gb+"ChartItmNm]").val(rowInit ? "" : itmSheetObj.GetCellValue(row, itmSheetObj.SaveNameCol("chartItmNm")));
	formObj.find("input[name="+gb+"EngChartItmNm]").val(rowInit ? "" : itmSheetObj.GetCellValue(row, itmSheetObj.SaveNameCol("engChartItmNm")));
	formObj.find("input[name="+gb+"UseYn][value="+itmSheetObj.GetCellValue(row, itmSheetObj.SaveNameCol("useYn"))+"]").prop("checked", true);
	formObj.find("input[name="+gb+"CmmtIdtfr]").val(rowInit ? "" : itmSheetObj.GetCellValue(row, itmSheetObj.SaveNameCol("cmmtIdtfr")));
	formObj.find("textarea[name="+gb+"CmmtCont]").val(rowInit ? "" : itmSheetObj.GetCellValue(row, itmSheetObj.SaveNameCol("cmmtCont")));
	formObj.find("textarea[name="+gb+"EngCmmtCont]").val(rowInit ? "" : itmSheetObj.GetCellValue(row, itmSheetObj.SaveNameCol("engCmmtCont")));
	formObj.find("input[name="+gb+"DummyYn][value="+itmSheetObj.GetCellValue(row, itmSheetObj.SaveNameCol("dummyYn"))+"]").prop("checked", true);
	formObj.find("input[name="+gb+"DefSelYn][value="+itmSheetObj.GetCellValue(row, itmSheetObj.SaveNameCol("defSelYn"))+"]").prop("checked", true);
	formObj.find("input[name="+gb+"CDefSelYn][value="+itmSheetObj.GetCellValue(row, itmSheetObj.SaveNameCol("cDefSelYn"))+"]").prop("checked", true);
	formObj.find("input[name="+gb+"SumavgYn][value="+itmSheetObj.GetCellValue(row, itmSheetObj.SaveNameCol("sumavgYn"))+"]").prop("checked", true);	//합계여부
	formObj.find("input[name="+gb+"RefCd]").val(rowInit ? "" : itmSheetObj.GetCellValue(row, itmSheetObj.SaveNameCol("refCd")));	//맵핑코드
	formObj.find("input[name="+gb+"StartYm]").val(rowInit ? "" : itmSheetObj.GetCellValue(row, itmSheetObj.SaveNameCol("itmStartYm")));
	formObj.find("input[name="+gb+"EndYm]").val(rowInit ? "" : itmSheetObj.GetCellValue(row, itmSheetObj.SaveNameCol("itmEndYm")));
	if ( getGbStr(gb) == "I"  ) {	//항목인 경우
		formObj.find("input[name="+gb+"InputNeedYn], input[name="+gb+"UiAllChk]").prop("checked", false);
		formObj.find("input[name="+gb+"InputNeedYn][value="+itmSheetObj.GetCellValue(row, itmSheetObj.SaveNameCol("inputNeedYn"))+"]").prop("checked", true);
		formObj.find("input[name="+gb+"UiId]").val(rowInit ? "" : itmSheetObj.GetCellValue(row, itmSheetObj.SaveNameCol("uiId")));
		formObj.find("input[name="+gb+"UiNm]").val(rowInit ? "" : itmSheetObj.GetCellValue(row, itmSheetObj.SaveNameCol("uiNm")));
		formObj.find("select[name="+gb+"SeriesCd]").val(rowInit ? "" : itmSheetObj.GetCellValue(row, itmSheetObj.SaveNameCol("seriesCd")));
		formObj.find("select[name="+gb+"ChckCd]").val(rowInit ? "" : itmSheetObj.GetCellValue(row, itmSheetObj.SaveNameCol("chckCd")));
		formObj.find("select[name="+gb+"DmpointCd]").val(rowInit ? "" : itmSheetObj.GetCellValue(row, itmSheetObj.SaveNameCol("dmpointCd")));
	}
	
	//사용여부 체크 조작
	if ( itmSheetObj.GetCellValue(row, "useYn") == "Y" ) {
		//부모 확인하여 부모항목도 체크처리
		var parentRow = itmSheetObj.GetParentRow(row);
		while ( parentRow > 0 ) {
			itmSheetObj.SetCellValue(parentRow, "useYn", "Y");
			parentRow = itmSheetObj.GetParentRow(parentRow);
		}
	} else if ( itmSheetObj.GetCellValue(row, "useYn") == "N" ) {
		//선택한 항목 자식 모두 체크 해제
		var childRows = itmSheetObj.GetChildRows(row).split("|");
		for ( var i=0; i < childRows.length; i++ ) {
			itmSheetObj.SetCellValue(childRows[i], "useYn", "N");
		}
	}
}

//시트 팝업클릭 이벤트
function usrSheetOnPopupClick(Row, Col){
	var objTab = getTabShowObj();//탭이 oepn된 객체가져옴
	var formObj = objTab.find("form[name=statsMgmt-mst-form]");
	var usrSheetNm = formObj.find("input[name=usrSheetNm]").val();
	var usrSheetObj = window[usrSheetNm];
	
	if ( usrSheetObj.ColSaveName(Col) == "orgNm" ) {	//조직명 클릭
		window.open(com.wise.help.url("/admin/basicinf/popup/commOrg_pop.do") + "?orgNmGb=7&sheetNm="+usrSheetNm+"", "list" ,"fullscreen=no, width=500, height=550"); 
	} else if ( usrSheetObj.GetCellValue(Row, "orgNm") != "" && usrSheetObj.ColSaveName(Col) == "usrNm" ) {
		window.open(com.wise.help.url("/admin/basicinf/popup/commUsrPos_pop.do") + "?usrGb=4&sheetNm="+usrSheetNm+"&orgCd="+usrSheetObj.GetCellValue(Row, "orgCd") ,"list", "fullscreen=no, width=600, height=550");
	} else {
		alert("먼저 조직명을 선택하세요.");
	}
}

////////////////////////////////////////////////////////////////////////////////
// 이벤트 함수
////////////////////////////////////////////////////////////////////////////////
/**
 * 캘린더 초기화
 * 	탭 이동시마다 캘린더 초기화되어 removeClass('hasDatepicker') 로 제거하고 다시 이벤트를 추가한다.
 */
function datePickerInit() {
	var objTab = getTabShowObj();//탭이 oepn된 객체가져옴
	var formObj = objTab.find("form[name=statsMgmt-mst-form]");
	
	/* 탭 이동마다 호출 */
	formObj.find(".ui-datepicker-trigger").remove();	//달력 이미지 제거
	
	//공개일
	formObj.find("input[name=openDttm]").removeClass('hasDatepicker').datepicker(setCalendar()); 
	
	// 항목/분류 유효기간
	formObj.find("input[name=itmStartYm]").removeClass('hasDatepicker').datepicker(setCalendarView('yy-mm'));
	formObj.find("input[name=itmEndYm]").removeClass('hasDatepicker').datepicker(setCalendarView('yy-mm'));
	formObj.find("input[name=cateStartYm]").removeClass('hasDatepicker').datepicker(setCalendarView('yy-mm'));
	formObj.find("input[name=cateEndYm]").removeClass('hasDatepicker').datepicker(setCalendarView('yy-mm'));
	
	//공개일 초기화
	formObj.find("button[id=openDttmInit]").bind("click", function() {
		formObj.find("input[name=openDttm]").val("");		
	});
	
	//작성기준
	formObj.find("input[name=wrtstartMdYY],   input[name=wrtendMdYY]" +	// 작성기준 년
			", input[name=wrtstartMdHY01], input[name=wrtendMdHY01]" +	// 작성기준 반기01
			", input[name=wrtstartMdHY02], input[name=wrtendMdHY02]" +	// 작성기준 반기02
			", input[name=wrtstartMdQY01], input[name=wrtendMdQY01]" +	// 작성기준 분기01
			", input[name=wrtstartMdQY02], input[name=wrtendMdQY02]" +	// 작성기준 분기02
			", input[name=wrtstartMdQY03], input[name=wrtendMdQY03]" +	// 작성기준 분기03
			", input[name=wrtstartMdQY04], input[name=wrtendMdQY04]"	// 작성기준 분기04
			).removeClass('hasDatepicker').datepicker(setCalendarView('mm-dd'));
	
	// 시작-종료 일자보다 이전으로 못가게 세팅
	//년도
	formObj.find('input[name=wrtstartMdYY]').datepicker('option', 'onClose',  function( selectedDate ) {$("input[name=wrtendMdYY]").datepicker( "option", "minDate", selectedDate );});
	formObj.find('input[name=wrtendMdYY]').datepicker('option', 'onClose',  function( selectedDate ) {	$("input[name=wrtstartMdYY]").datepicker( "option", "maxDate", selectedDate );});
	// 반기
	formObj.find('input[name=wrtstartMdHY01]').datepicker('option', 'onClose',  function( selectedDate ) {$("input[name=wrtendMdHY01]").datepicker( "option", "minDate", selectedDate );});
	formObj.find('input[name=wrtendMdHY01]').datepicker('option', 'onClose',  function( selectedDate ) {$("input[name=wrtstartMdHY01]").datepicker( "option", "maxDate", selectedDate );});
	formObj.find('input[name=wrtstartMdHY02]').datepicker('option', 'onClose',  function( selectedDate ) {$("input[name=wrtendMdHY02]").datepicker( "option", "minDate", selectedDate );});
	formObj.find('input[name=wrtendMdHY02]').datepicker('option', 'onClose',  function( selectedDate ) {$("input[name=wrtstartMdHY02]").datepicker( "option", "maxDate", selectedDate );});
	// 분기
	formObj.find('input[name=wrtstartMdQY01]').datepicker('option', 'onClose',  function( selectedDate ) {$("input[name=wrtendMdQY01]").datepicker( "option", "minDate", selectedDate );});
	formObj.find('input[name=wrtendMdQY01]').datepicker('option', 'onClose',  function( selectedDate ) {$("input[name=wrtstartMdQY01]").datepicker( "option", "maxDate", selectedDate );});
	formObj.find('input[name=wrtstartMdQY02]').datepicker('option', 'onClose',  function( selectedDate ) {$("input[name=wrtendMdQY02]").datepicker( "option", "minDate", selectedDate );});
	formObj.find('input[name=wrtendMdQY02]').datepicker('option', 'onClose',  function( selectedDate ) {$("input[name=wrtstartMdQY02]").datepicker( "option", "maxDate", selectedDate );});
	formObj.find('input[name=wrtstartMdQY03]').datepicker('option', 'onClose',  function( selectedDate ) {$("input[name=wrtendMdQY03]").datepicker( "option", "minDate", selectedDate );});
	formObj.find('input[name=wrtendMdQY03]').datepicker('option', 'onClose',  function( selectedDate ) {$("input[name=wrtstartMdQY03]").datepicker( "option", "maxDate", selectedDate );});
	formObj.find('input[name=wrtstartMdQY04]').datepicker('option', 'onClose',  function( selectedDate ) {$("input[name=wrtendMdQY04]").datepicker( "option", "minDate", selectedDate );});
	formObj.find('input[name=wrtendMdQY04]').datepicker('option', 'onClose',  function( selectedDate ) {$("input[name=wrtstartMdQY04]").datepicker( "option", "maxDate", selectedDate );});
	
	//작성주기 체크시 캘린더표시/숨김(주기별 디폴드 값 부여)
	formObj.on("click", "input[id=dtaCycle-sect-YY], input[id=dtaCycle-sect-HY], input[id=dtaCycle-sect-QY], input[id=dtaCycle-sect-MM]", function() {
		if ( formObj.find("tr[name=wrt"+ $(this).val() +"TR]").css('display') == 'none' ){
			formObj.find("tr[name=wrt"+ $(this).val() +"TR]").show();
			
			if ( $(this).val() == "YY" ) {
				formObj.find("input[name=wrtstartMdYY]").val("01-01")
				formObj.find("input[name=wrtendMdYY]").val("12-31")
			}
			else if ( $(this).val() == "HY" ) {
				formObj.find("input[name=wrtstartMdHY01]").val("01-01");
				formObj.find("input[name=wrtendMdHY01]").val("06-30");
				formObj.find("input[name=wrtstartMdHY02]").val("07-01");
				formObj.find("input[name=wrtendMdHY02]").val("12-31");
			}
			else if ( $(this).val() == "QY" ) {
				formObj.find("input[name=wrtstartMdQY01]").val("01-01");
				formObj.find("input[name=wrtendMdQY01]").val("03-31");
				formObj.find("input[name=wrtstartMdQY02]").val("04-01");
				formObj.find("input[name=wrtendMdQY02]").val("06-30");
				formObj.find("input[name=wrtstartMdQY03]").val("07-01");
				formObj.find("input[name=wrtendMdQY03]").val("09-30");
				formObj.find("input[name=wrtstartMdQY04]").val("10-01");
				formObj.find("input[name=wrtendMdQY04]").val("12-31");
			}
		} else {
			formObj.find("tr[name=wrt"+ $(this).val() +"TR]").hide();
			if ( $(this).val() == "YY" ) {
				formObj.find("#dtacycleWrtTable input[name^=wrtstartMdYY]").val("");
				formObj.find("#dtacycleWrtTable input[name^=wrtendMdYY]").val("");
			}
			else if ( $(this).val() == "HY" ) {
				formObj.find("#dtacycleWrtTable input[name^=wrtstartMdHY]").val("");
				formObj.find("#dtacycleWrtTable input[name^=wrtendMdHY]").val("");
			}
			else if ( $(this).val() == "QY" ) {
				formObj.find("#dtacycleWrtTable input[name^=wrtstartMdQY]").val("");
				formObj.find("#dtacycleWrtTable input[name^=wrtendMdQY]").val("");
			}
		}
		
	});
}

////////////////////////////////////////////////////////////////////////////////
//Validation 함수
////////////////////////////////////////////////////////////////////////////////
function mstSaveValidation() {
	var objTab = getTabShowObj();//탭이 oepn된 객체가져옴
	var formObj = objTab.find("form[name=statsMgmt-mst-form]");
	var usrSheetNm = formObj.find("input[name=usrSheetNm]").val();
	var usrSheetObj = window[usrSheetNm];
	var cateInfoSheetNm = formObj.find("input[name=cateInfoSheetNm]").val();
	var cateInfoSheetObj = window[cateInfoSheetNm];
	
	if ( formObj.find("input[name=statblNm]").val() == "" ) {
		alert("통계표명을 입력하세요.");
		return false;
	}
	
	if ( formObj.find("input[name=statId]").val() == "" ) {
		alert("통계메타명을 선택하세요.");
		return false;
	}
	
	if ( formObj.find("select[name=dscnId]").val() == "" ) {
		alert("연계정보를 선택하세요.");
		return false;
	}
	
	/*if ( formObj.find("input[name=cateId]").val() == "" ) {
		alert("분류체계를 선택하세요.");
		return false;
	}*/
	
	if ( formObj.find("input[name=dtacycleCd]:checked").length < 1 ) {
		alert("작성주기를 선택하세요.");
		return false;
	}
	if ( formObj.find("#dtaCycle-sect-YY").is(":checked") ) {
		if ( formObj.find("[name=wrtstartMdYY]").val() == "" ) {
			alert("작성기준 년(시작)을 선택하세요.");
			formObj.find("[name=wrtstartMdYY]").focus();
			return false;
		}
		if ( formObj.find("[name=wrtendMdYY]").val() == "" ) {
			alert("작성기준 년(종료)을 선택하세요.");
			formObj.find("[name=wrtendMdYY]").focus();
			return false;
		}
	}
	if ( formObj.find("#dtaCycle-sect-HY").is(":checked") ) {
		if ( formObj.find("[name=wrtstartMdHY01]").val() == "" ) {
			alert("작성기준 상반기(시작) 일자를 선택하세요.");
			formObj.find("[name=wrtstartMdHY01]").focus();
			return false;
		}
		if ( formObj.find("[name=wrtendMdHY01]").val() == "" ) {
			alert("작성기준 상반기(종료) 일자를 선택하세요.");
			formObj.find("[name=wrtendMdHY01]").focus();
			return false;
		}
		if ( formObj.find("[name=wrtstartMdHY02]").val() == "" ) {
			alert("작성기준 하반기(시작) 일자를 선택하세요.");
			formObj.find("[name=wrtstartMdHY02]").focus();
			return false;
		}
		if ( formObj.find("[name=wrtendMdHY02]").val() == "" ) {
			alert("작성기준 하반기(종료) 일자를 선택하세요.");
			formObj.find("[name=wrtendMdHY02]").focus();
			return false;
		}
	}
	if ( formObj.find("#dtaCycle-sect-QY").is(":checked") ) {
		if ( formObj.find("[name=wrtstartMdQY01]").val() == "" ) {
			alert("작성기준 1분기(시작) 일자를 선택하세요.");
			formObj.find("[name=wrtstartMdQY01]").focus();
			return false;
		}
		if ( formObj.find("[name=wrtendMdQY01]").val() == "" ) {
			alert("작성기준 1분기(종료) 일자를 선택하세요.");
			formObj.find("[name=wrtendMdQY01]").focus();
			return false;
		}
		if ( formObj.find("[name=wrtstartMdQY02]").val() == "" ) {
			alert("작성기준 2분기(시작) 일자를 선택하세요.");
			formObj.find("[name=wrtstartMdQY02]").focus();
			return false;
		}
		if ( formObj.find("[name=wrtendMdQY02]").val() == "" ) {
			alert("작성기준 2분기(종료) 일자를 선택하세요.");
			formObj.find("[name=wrtendMdQY02]").focus();
			return false;
		}
		if ( formObj.find("[name=wrtstartMdQY03]").val() == "" ) {
			alert("작성기준 3분기(시작) 일자를 선택하세요.");
			formObj.find("[name=wrtstartMdQY03]").focus();
			return false;
		}
		if ( formObj.find("[name=wrtendMdQY03]").val() == "" ) {
			alert("작성기준 3분기(종료) 일자를 선택하세요.");
			formObj.find("[name=wrtendMdQY03]").focus();
			return false;
		}
		if ( formObj.find("[name=wrtstartMdQY04]").val() == "" ) {
			alert("작성기준 4분기(시작) 일자를 선택하세요.");
			formObj.find("[name=wrtstartMdQY04]").focus();
			return false;
		}
		if ( formObj.find("[name=wrtendMdQY04]").val() == "" ) {
			alert("작성기준 4분기(종료) 일자를 선택하세요.");
			formObj.find("[name=wrtendMdQY04]").focus();
			return false;
		}
	}
	
	if ( formObj.find("input[name=useYn]:checked").val() == "" ) {
		alert("사용여부를 선택하세요.");
		return false;
	}
	
	//작성주기 체크
	var existDtacycleCd = [];
	formObj.find("input[name=dtacycleCd]:checkbox").each(function() {
		if ( $(this).is(":checked") ) {
			existDtacycleCd.push($(this).val());
			
		}
	});
	var optDc = formObj.find("input[name=optDC]:checked").val();
	if($.inArray(optDc, existDtacycleCd) == -1) {
		 alert("선택하신 검색자료 주기가 작성주기에 없습니다.\n작성주기를 확인하세요");
		 return false;
	}
	
	if ( !com.wise.util.isLength(formObj.find("textarea[name=statblCmmt]"), 1, 1000)) {
    	alert("1000자리 이내로 입력하세요.");
    	formObj.find("textarea[name=statblCmmt]").val("").focus();
        return false;
    }
	
	if ( !com.wise.util.isLength(formObj.find("textarea[name=engStatblCmmt]"), 1, 1000)) {
    	alert("1000자리 이내로 입력하세요.");
    	formObj.find("textarea[name=engStatblCmmt]").val("").focus();
        return false;
    }
	
	if ( !com.wise.util.isLength(formObj.find("input[name=schwTagCont]"), 1, 1000)) {
    	alert("1000자리 이내로 입력하세요.");
    	formObj.find("input[name=schwTagCont]").val("").focus();
        return false;
    }
	if ( !com.wise.util.isBlank(formObj.find("input[name=schwTagCont]").val()) && !com.wise.util.isKoreanAlphaNumeric(formObj.find("input[name=schwTagCont]").val(), ",") ) {
		alert("한글과 숫자만 입력하세요.");
		return false;
	}
	
	if ( !com.wise.util.isLength(formObj.find("input[name=engSchwTagCont]"), 1, 1000)) {
    	alert("1000자리 이내로 입력하세요.");
    	formObj.find("input[name=engSchwTagCont]").val("").focus();
        return false;
    }
	if ( !com.wise.util.isBlank(formObj.find("input[name=engSchwTagCont]").val()) && !com.wise.util.isAlphaNumeric(formObj.find("input[name=engSchwTagCont]").val(), ",") ) {
		alert("영어과 숫자만 입력하세요.");
		return false;
	}
	
	if ( formObj.find("input[name=fvtDataYn]").is(":checked") ) {
		if ( formObj.find("select[name=fvtDataOrder]").val() == "0" ) {
			alert("통계표를 추천하는 경우 순위를 입력해 주세요");
			formObj.find("select[name=fvtDataOrder]").focus();
			return false;
		}
	}
	
	if ( !formObj.find("input[name=dtacycleCd][value="+formObj.find("input[name=optDC]:checked").val()+"]").is(":checked") ) {
		alert("검색자료주기(보기옵션)에 선택한 주기의 작성기준을 입력해 주세요.");
		return false;
	}
	
	// 인원정보 sheet validation
	if ( usrSheetObj.RowCount() == 0 ) {
		alert("인원정보를 입력해 주세요.");
		return false;
	}
	
	// 분류정보 sheet validation
	if ( cateInfoSheetObj.RowCount() == 0 ) {
		alert("분류정보를 입력해 주세요.");
		return false;
	}
	
	if ( !cateInfoSheetValidation(cateInfoSheetObj) )	return false;
	// 인원정보 시트 validation
	if ( !usrSheetValidation(usrSheetObj) ) {
		return false;
	}
	
	var rpstYns = "";
	for ( var i=1; i <= usrSheetObj.RowCount(); i++ ) {
		rpstYns = rpstYns + usrSheetObj.GetCellValue(i, "rpstYn");
	}
	if ( rpstYns.indexOf('Y') == -1 ) {
		alert("인원정보의 대표자(대표여부)를 선택해 주세요.");
		return false;
	}
	
	if ( !confirm("저장 하시겠습니까?") ) {
		return false;
	}
	
	return true;
}
//분류/인원 정보 등록 전 validation
function cateInfoSheetValidation(sheetObj) {
	sheetObj.ExtendValidFail = 0;
	var sheetJson = sheetObj.GetSaveJson({AllSave:true, ValidKeyField: 1});
	var rpstYns = "";	// 분류정보 대표여부 체크
	
	if (sheetJson.Code) {
        switch (sheetJson.Code) {
            case "IBS000":
                alert("저장할 내역이 없습니다.");
                break;
            case "IBS010":
            case "IBS020":
                // Nothing to do.
                break;
        }
        return false;
    } 
	
	// 대표여부 체크여부
	for ( var i=1; i <= sheetObj.RowCount(); i++ ) {
		if ( sheetObj.GetCellValue(i, "status") !== "D" ) {	// 삭제하는 행은 제외
			rpstYns = rpstYns + sheetObj.GetCellValue(i, "rpstYn");
		}
	}
	if ( rpstYns.indexOf('Y') == -1 ) {
		alert("대표자(대표여부)를 선택하세요.");
		return false;
	}
	
	return true;
}


//인원정보 등록 전 validation
function usrSheetValidation(sheetObj) {
	sheetObj.ExtendValidFail = 0;
	var sheetJson = sheetObj.GetSaveJson({AllSave:true, ValidKeyField: 1});
	
	if (sheetJson.Code) {
        switch (sheetJson.Code) {
            case "IBS000":
                alert("저장할 내역이 없습니다.");
                break;
            case "IBS010":
            case "IBS020":
                // Nothing to do.
                break;
        }
        return false;
    } else {
    	return true;
    }
}

//항목 시트 CUD Validation
function itmSaveValidation(gb) {
	var objTab = getTabShowObj();//탭이 oepn된 객체가져옴
	var formObj = objTab.find("form[name=statsMgmt-mst-form]");
	var itmSheetNm = formObj.find("input[name="+gb+"SheetNm]").val();
	var itmSheetObj = window[itmSheetNm];
	
	if ( itmSheetObj.RowCount() == 0 ) {
		alert("아이템을 추가해 주세요.");
		return false;
	}
	
	if ( getGbStr(gb) == "I"  ) {	//항목구성일 경우만 단위 체크
		for ( var i=1; i <= itmSheetObj.RowCount(); i++ ) {
			if ( itmSheetObj.GetCellValue(i, "uiId") == "" ) {
				alert( (i) + "째 행의 단위를 선택해 주세요.");
				return false;
			}
		}
	}
	
	return true;
}

/**
 * 탭에 속해 있는 폼 객체를 가져온다.
 * @param formNm	폼 명
 */
function getTabFormObj(formNm) {
	var objTab = getTabShowObj();//탭이 oepn된 객체가져옴
	var formObj = objTab.find("form[name="+formNm+"]");
	return formObj
}

/**
 * 탭에 속해 있는 시트 객체를 가져온다.
 * @param formNm	폼 명
 * @param sheetNm	시트 명
 * @returns
 */
function getTabSheetObj(formNm, sheetNm) {
	var formObj = getTabFormObj(formNm);
	var tabSheetNm = formObj.find("input[id="+sheetNm+"]").val();
	var sheetObj = window[tabSheetNm];
	return sheetObj;
}