/*
 * @(#)openApiStatSch.js
 * 
 */

// //////////////////////////////////////////////////////////////////////////////
// 글로벌 변수
// //////////////////////////////////////////////////////////////////////////////
var isMobile = $(window).width() <= 980 ? true : false; // 모바일 접근 여부

// 모바일 메인 리스트 템플릿(검색결과도 같이 사용)
var mbListTemplate = {
	row : "<li>"
			+ "<a href=\"javascript:;\" name=\"\"><strong class=\"tit\"></strong></a>"
			+ "</li>",
	none : "<li><strong class=\"tit\">조회된 데이터가 없습니다.</strong></li>"
}
// //////////////////////////////////////////////////////////////////////////////
// Script Init Loading...
// //////////////////////////////////////////////////////////////////////////////
$(function() {
	/* 컴포넌트를 초기화한다. */
	initComp();

	/* 통계화면 컨트롤 정의(이벤트) */
	eventControl();
});

////////////////////////////////////////////////////////////////////////////////
// 초기화 함수
////////////////////////////////////////////////////////////////////////////////
/**
 * 컴포넌트를 초기화한다.
 */
function initComp() {
	loadMainPage();
}
////////////////////////////////////////////////////////////////////////////////
// 메인화면 리스트 관련 함수들
////////////////////////////////////////////////////////////////////////////////
function loadMainPage(searchFlag) {
	var searchFlag = searchFlag || false;
	$("#searchVal").val($("#statSearchVal").val());

	/* 항목선택/분류선택을 초기화한다. */
	$("#treeItmData").empty();
	$("#treeClsData").empty();
	
	loadMainTreeList();
}
/**
 *  통계표 목록 트리 리스트
 */
function loadMainTreeList() {
	doSearch({
		url : "/portal/stat/easyStatList.do",
		before : beforeStatsTree,
		after : afterStatsTree
	});
}
/**
 * 메인 통계표 리스트 후처리
 */
function afterStatsTree(data) {
	if (data.length > 0) {
		setStatTree("treeStatData", data);
		
		var treeId = "treeStatData";
		var zTree = $.fn.zTree.getZTreeObj(treeId);
		var keyType = "statblTag";
		 
		var zTreeData = zTree.getNodesByParamFuzzy(keyType, "T")
		zTree.expandAll(true);
		updateNodes(treeId, zTree.getNodesByParamFuzzy(keyType, "T"));
		
		
	}else{
		$("#treeStatData").empty().append($(mbListTemplate.none));
	}
}

function updateNodes(treeId, fuzzyList) {
	var zTree = $.fn.zTree.getZTreeObj(treeId);
	for (var i = 0, l = fuzzyList.length; i < l; i++) {
		var tId = fuzzyList[i].tId;
		var tNm = "<span>" + fuzzyList[i].statblNm + "</span>" + 
					"<strong style=\"color:blue;\" >"+ "(" + fuzzyList[i].statblId + ")" + "</strong>";
		$("#"+tId+"_span").empty(); 
		$("#"+tId+"_span").append(tNm); 
	}
}


////////////////////////////////////////////////////////////////////////////////
//이벤트 관련 함수들
////////////////////////////////////////////////////////////////////////////////
/**
* 통계화면 컨트롤 정의
*/
function eventControl() {
	// 통계표 조회
	$("button[name=btn_statInquiry]").bind("click", function(event) {
		loadMainPage(true);
	});
	// 통계표 조회 enter
	$("input[name=statSearchVal]").bind("keydown", function(event) {
		// 엔터키인 경우
		if (event.which == 13) {
			loadMainPage(true);
			return false;
		}
	});
}

/**
 * 메인리스트에서 통계표 선택시 항목, 분류 및 검색주기, 검색기간 세팅 
 */
function selStat(sId) {
	$("#sId").val(sId);

	// 통계표를 선택시 항목선택 및 분류선택의 검색란 내용을 지운다.
	$("#itmSearchVal").val("");
	$("#clsSearchVal").val("");

	// 통계표를 선택시 항목선택 및 분류선택의 검색란 내용을 지운다.
	$("#itmSearchVal").val("");
	$("#clsSearchVal").val("");

	var processChk1;

	// 항목선택/분류선택 확인 Display
	processChk1 = selectStats();


	if (processChk1) {
		return true;
	} else {
		return false;
	}
}
/**
 * 통계표 선택시 항목, 분류정보 세팅 및 이벤트 생성
 */
function selectStats() {
	$("#searchGb").val("M");

	statsMainTreeLoad("I");	 //항목 선택 트리 로드
	statsMainTreeLoad("C");	//분류 선택 트리 로드


	return true;
}
