/*
 * @(#)openDsUsrDefInputEvent.js 1.0 2019/09/27
 */

/**
 * 데이터셋 사용자정의 입력 이벤트 스크립트 파일이다
 *
 * @author JHKIM
 * @version 1.0 2019/09/26
 */
$(function() {
    
});

/**
 * 이벤트를 바인딩한다.
 */
function bindEvent() {
	
	$("button[name=btn_inquiry]").bind("click", function(event) {
		doAction("search");
	});
	
	$("input[name=searchVal]").bind("keydown", function(event) {
		if (event.which == 13) {
			doAction("search");
			return false;
		}
	});
	
	$("button[name=btn_reg]").bind("click", function(event) {
		doAction("reg");
	});
}

/**
 * 탭 내의 이벤트를 바인딩한다.
 */
function setTabButton() {
	var formObj = getTabFormObj("dtlForm");
	
	formObj.find("a[name=a_reg]").bind("click", function(event) {
		doAction("insert");
	});
	
	formObj.find("a[name=a_save]").bind("click", function(event) {
		doAction("update");
	});
	
	formObj.find("a[name=a_del]").bind("click", function(event) {
		doAction("delete");
	});
	
	// 파일 추가
	formObj.find("button[name=fileAdd]").bind("click", function(event) {
		doActionFile("add");
	});
	// 파일 삭제
	formObj.find("a[name=a_file_del]").bind("click", function(event) {
		doActionFile("deleteFile");
	});
	formObj.find("a[name=a_up]").bind("click", function(event) {
		doActionFile("moveUp");
	});
	formObj.find("a[name=a_down]").bind("click", function(event) {
		doActionFile("moveDown");
	});
	// 순서저장
	formObj.find("a[name=a_order]").bind("click", function(event) {
		doActionFile("saveOrder");
	});
	
	// 파일 추가시 출력파일명 입력
	formObj.find("input[name=atchFile]").change(function(event) {
		var fileNm = $(this)[0].files[0].name;
		formObj.find("input[name=viewFileNm]").val(fileNm.substr(0, fileNm.lastIndexOf(".")));
	});
	
	
	// 캘린더 초기화
	initDtlInfoControl();
}

// 액션별로 버튼 설정한다.(등록/수정)
function setActionButton(action) {
	var formObj = getTabFormObj("dtlForm");
	
	formObj.find("div[class=buttons]:eq(1) a").hide();
	
	if ( action == "I" ) {
		formObj.find("a[name=a_reg]").show();
	}
	else if ( action == "U" || action == "D" ) {
		formObj.find("a[name=a_modify]").show();
		formObj.find("a[name=a_file_del]").show();
		formObj.find("a[name=a_del]").show();
	}
}

//화면 컨트롤 날짜컬럼 달력 패키지 로드
function initDtlInfoControl() {
	var objTab = getTabShowObj();
	var table = objTab.find("#dtl-info-sect");
	var formObj = getTabFormObj("dtlForm");

	formObj.find(".ui-datepicker-trigger").remove();	//달력 이미지 제거
	
	// 날짜컬럼
	table.find("[data-col-type=DATE]").each(function() {
		$(this).removeClass('hasDatepicker').datepicker(setCalendar());
	});
}

// 상세탭 초기화
function initDtlInfo() {
	var objTab = getTabShowObj();
	var table = objTab.find("#dtl-info-sect");
	
	table.find("input, select").val("");

	objTab.find("#dtlForm").find("input[name=dataSeqceNo]").val("");
	
	initDtlFile();
	
}

// 상세탭 - 파일 초기화
function initDtlFile() {
	var formObj = getTabFormObj("dtlForm");
	var agent = navigator.userAgent.toLowerCase();
	if ( (navigator.appName == 'Netscape' && navigator.userAgent.search('Trident') != -1) || (agent.indexOf("msie") != -1) ){
		formObj.find("input[name=atchFile]").replaceWith( formObj.find("input[name=atchFile]").clone(true) );
		formObj.find("input[name=viewFileNm]").val("");
	}
	else {
		formObj.find("input[name=atchFile]").val("");
		formObj.find("input[name=viewFileNm]").val("");
	}
}