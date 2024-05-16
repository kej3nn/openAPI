/**
 * 공공데이터 파일서비스 등록 이벤트 스크립트 파일이다
 *
 * @author JHKIM
 * @version 1.0 2020/01/06
 */
$(function() {
    
});

/**
 * 이벤트를 바인딩한다.
 */
function bindEvent() {
	
	$("button[name=btn_inquiry]").bind("click", function(event) {
		doAction("search");
		return false;
	});
	
	$("input[name=searchWord]").bind("keydown", function(event) {
		if (event.which == 13) {
			doAction("search");
			return false;
		}
	});
}

/**
 * 탭 내의 이벤트를 바인딩한다.
 */
function setTabButton() {
	var formObj = getTabFormObj("dtlForm");
	
	formObj.find("a[name=a_modify]").bind("click", function(event) {
		doAction("update");
	});
	
	formObj.find("a[name=a_del]").bind("click", function(event) {
		doAction("delete");
	});
	
	// 파일 추가
	formObj.find("a[name=a_reg]").bind("click", function(event) {
		doActionFile("add");
	});

	// 파일 초기화
	formObj.find("button[name=fileInit]").bind("click", function(event) {
		formObj.find("a[name=a_reg]").show();
		formObj.find("a[name=a_modify], a[name=a_del], button[name=fileInit]").hide();
		initDtlFile();
	});	
	
	// 파일 추가시 출력파일명 입력
	formObj.find("input[name=atchFile]").change(function(event) {
		var fileNm = $(this)[0].files[0].name;
		formObj.find("input[name=viewFileNm]").val(fileNm.substr(0, fileNm.lastIndexOf(".")));
	});
	
	formObj.find("button[name=btn_metaDtl]").click(function(e) { 
		doAction('metaDtl');                 
		return false;                            
	});
	
	// 파일다운로드
	formObj.find("#btnFileDown").bind("click", function(event) {
		var downloadForm = $("#downloadForm");
		var infId = formObj.find("input[name=infId]").val();
		var fileSeq = formObj.find("input[name=fileSeq]").val();
		if ( com.wise.util.isNull(infId) || com.wise.util.isNull(fileSeq) ) {
			console.error("파라미터값 미존재");
			return;
		}
		
		downloadForm.find("input[name=infId]").val(infId);
		downloadForm.find("input[name=fileSeq]").val(fileSeq);
		$("#downloadForm").submit()
	});
	
	// 첨부파일 위로이동
	formObj.find("a[name=a_exp_up]").bind("click", function(event) {
		doActionFile("moveUp");
	});
	// 첨부파일 아래로이동
	formObj.find("a[name=a_exp_down]").bind("click", function(event) {
		doActionFile("moveDown");
	});
	// 첨부파일 순서저장
	formObj.find("a[name=a_exp_order]").bind("click", function(event) {
		doActionFile("saveOrder");
	});
}

// 상세탭 초기화
function initDtlInfo() {
	var objTab = getTabShowObj();

	initDtlFile();
	
}

// 상세탭 - 파일 초기화
function initDtlFile() {
	var formObj = getTabFormObj("dtlForm");
	var agent = navigator.userAgent.toLowerCase();
	if ( (navigator.appName == 'Netscape' && navigator.userAgent.search('Trident') != -1) || (agent.indexOf("msie") != -1) ){
		formObj.find("input[name=atchFile]").replaceWith( formObj.find("input[name=atchFile]").clone(true) );
	}
	else {
		formObj.find("input[name=atchFile]").val("");
	}
	formObj.find("input[name=fileSeq]").val("");
	formObj.find("input[name=viewFileNm]").val("");
	formObj.find("input[name=wrtNm]").val("");
	formObj.find("input[name=ftCrDttm]").val("");
	formObj.find("input[name=ltCrDttm]").val("");
	formObj.find("#btnFileDown").text("");
}