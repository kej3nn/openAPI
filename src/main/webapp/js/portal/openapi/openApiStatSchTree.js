/*
 * @(#)openApiStatSchTree.js
 */

/**
 * 트리 로드
 * @param id	트리 ID
 * @param data	로드 할 데이터
 */
////////////////////////////////////////////////////////////////////////////////
// 트리 로드
////////////////////////////////////////////////////////////////////////////////
/**
 * 메인화면 통계표 항목/분류 트리 세팅
 * @Param gubun :	I=항목, C=분류
 */
function statsMainTreeLoad(gubun) {
	var param = {
		statblId : $("#sId").val(),
		itmTag : gubun
	};
	if (gubun == "I") {
		param.itmNmsearchVal = $("#itmSearchVal").val();
	} else if (gubun == "C") {
		param.itmNmsearchVal = $("#clsSearchVal").val();
	}
	$.ajax({
		url : com.wise.help.url("/portal/stat/statEasyItmJson.do"),
		async : false,
		type : 'POST',
		data : param,
		dataType : "json",
		beforeSend : function(obj) {
		}, // 서버 요청 전 호출 되는 함수 return false; 일 경우 요청 중단
		success : function(data) {
			if (gubun == "I") {
				setAfterTree("treeItmData", data.data);
				// 탭생성시 사용하기 위해 항목Data를 전역변수에 담아놓는다.
				itmData = data;
				makeTreeData("treeItmData", data);
			} else if (gubun == "C") {
				setAfterTree("treeClsData", data.data);
				// 탭생성시 사용하기 위해 분류Data를 전역변수에 담아놓는다.
				clsData = data;
				
				// 분류영역 처리를 위해 추가
				clsBoxDisplay((data.data).length);
				makeTreeData("treeClsData", data);
			}
		}, // 요청 완료 시
		error : function(request, status, error) {
			handleError(status, error);
		}, // 요청 실패.
		complete : function(jqXHR) {
		} // 요청의 실패, 성공과 상관 없이 완료 될 경우 호출
	});
}
/**
 * 탭 안의 통계표 항목/분류 트리 세팅
 * @Param gubun :	I=항목, C=분류
 */
function statsTreeLoad(gubun) {
	var param = {
		statblId : $("#sId").val(),
		itmTag : gubun
	};
	if (gubun == "I") {
		param.itmNmsearchVal = $("#itmSearchVal").val();
	} else if (gubun == "C") {
		param.itmNmsearchVal = $("#clsSearchVal").val();
	}
	$.ajax({
		url : com.wise.help.url("/portal/stat/statEasyItmJson.do"),
		async : false,
		type : 'POST',
		data : param,
		dataType : "json",
		beforeSend : function(obj) {
		}, // 서버 요청 전 호출 되는 함수 return false; 일 경우 요청 중단
		success : function(data) {
			if (gubun == "I") {
				afterStatsItmTree(data.data);
			} else if (gubun == "C") {
				afterStatsClsTree(data.data);
			}
		}, // 요청 완료 시
		error : function(request, status, error) {
			handleError(status, error);
		}, // 요청 실패.
		complete : function(jqXHR) {
		} // 요청의 실패, 성공과 상관 없이 완료 될 경우 호출
	});
}
/**
 * 항목 트리 후 처리
 * 
 * @param data
 */
function afterStatsItmTree(data) {
	// 항목 정보를 [통계검색]화면의 DIV에서 받아서 세팅한다.
	var itmIdNm = "itm" + formObj.find("input[name=statblId]").val();
	
	/* 탭 화면의 항목 부분 */
	setAfterTree(itmIdNm, data);
}
/**
 * 분류 트리 후 처리
 */
function afterStatsClsTree(data) {

	// 항목 정보를 [통계검색]화면의 DIV에서 받아서 세팅한다.
	var clsIdNm = "cls" + formObj.find("input[name=statblId]").val();
	var searchGb = $("#searchGb").val();
	
	if ( data.length > 0 ) {
		/* 탭 화면의 항목 부분 */
		setAfterTree(clsIdNm, data);
	} else {
		formObj.find("button[name=callPopCls]").hide(); // 데이터가 없으면 버튼을 보이지 않게
	}
	
}
/**
 * 트리 생성
 */
function setAfterTree(id, data) {
	// tree setting 값
	var setting = {
		// 데이터 타입 설정
		data : {
			key : {
				name : "viewItmNm"
			},
			simpleData : {
				enable : true,
				idKey : "datano",
				pIdKey : "parDatano"
			}
		},
		view : {
			dblClickExpand : false,
			showLine : true,
			selectedMulti : false,
			expandSpeed : "normal",
			fontCss : getMainFontCss
		},
		callback : {
			beforeClick : itmClick,
			onDblClick: myOnDblClick
		}
	};
	// 트리 로드
	$.fn.zTree.init($("#" + id), setting, data);
}
////////////////////////////////////////////////////////////////////////////////
// 트리 전처리 함수
////////////////////////////////////////////////////////////////////////////////
//통계 트리 전 처리함수
function beforeStatsTree(option) {
	$("button[name=statAllExpand]").bind("click", function() {
		treeNodeControl("treeStatData", "EXP")
	}); // 펼침
	$("button[name=statAllUnExpand]").bind("click", function() {
		treeNodeControl("treeStatData", "UN_EXP")
	}); // 닫기

	var data = {
		statblId : $("#sId").val(),
		searchVal : $("#searchVal").val(),
		searchGubun : $("#searchGubun").val(),
		searchKeywordVal : $("#hdnKeywordVal").val(),
		mbSubject : $("#mbSubject").find("option:selected").val()
	};

	return data;
}

//항목 트리 전 처리함수
function beforeStatsItmTree(option) {
	var data = {
		statblId : $("#sId").val(),
		itmNmsearchVal : $("#itmSearchVal").val(),
		itmTag : 'I'
	};

	return data;
}

// 분류 트리 전 처리함수
function beforeStatsClsTree(option) {
	var data = {
		statblId : $("#sId").val(),
		itmNmsearchVal : $("#clsSearchVal").val(),
		itmTag : 'C'
	};

	return data;
}

function beforeClick(treeId, treeNode, clickFlag) {
	$("#treeStatData").find("li").removeClass('curSelectedNode');
	$("#treeStatData").find("a").removeClass('curSelectedNode');
	
	var tId = treeNode.tId;
	$("#"+tId).addClass('curSelectedNode');
	
	if (treeNode.isParent) {
		// 폴더를 선택하면 항목선택/분류선택을 초기화한다.
		$("#treeItmData").empty();
		$("#treeClsData").empty();
	} else {
		selStat(treeNode.statblId); // 항목선택/분류선택 리스트 호출
	}
}

function itmClick(treeId, treeNode, clickFlag) {
	$("#"+treeId).find("li").removeClass('curSelectedNode');
	$("#"+treeId).find("a").removeClass('curSelectedNode');
	
	var tId = treeNode.tId;
	$("#"+tId).addClass('curSelectedNode');
}
////////////////////////////////////////////////////////////////////////////////
//트리 후처리
////////////////////////////////////////////////////////////////////////////////
function setStatTree(id, data) {
	// tree setting 값
	var setting = {
		view : {
			dblClickExpand : false,
			showLine : true,
			selectedMulti : false,
			expandSpeed : "normal"
		},
		// 데이터 타입 설정
		data : {
			key : {
				name : "statblNm"
			},
			simpleData : {
				enable : true,
				idKey : "statblId",
				pIdKey : "parStatblId"
			}
		},
		callback : {
			beforeClick : beforeClick,
			onDblClick: myOnDblClick
		}
	};
	// 트리 로드
	$.fn.zTree.init($("#" + id), setting, data);
}
/**
 * 트리 더블클릭 액션(클립보드)
 */
function myOnDblClick(event, treeId, treeNode) {
	var statCd = "";
	
	if(treeId == "treeStatData" ){
		statCd = treeNode.statId;
	}else{
		statCd = treeNode.datano;
	}
	prompt("Ctrl+C 후에 Ctrl+V하세요", statCd);
};


function makeTreeData(treeId, data){
	var zTree = $.fn.zTree.getZTreeObj(treeId);
	var keyType = "viewItmNm";
	 
	var zTreeData = zTree.getNodesByParamFuzzy(keyType, "");
	changeNodes(treeId, zTree.getNodesByParamFuzzy(keyType, ""));
}

function changeNodes(treeId, fuzzyList) {
	var zTree = $.fn.zTree.getZTreeObj(treeId);
	for (var i = 0, l = fuzzyList.length; i < l; i++) {
		var tId = fuzzyList[i].tId;
		var tNm = "<span>" + fuzzyList[i].viewItmNm + "</span>" + 
					"<strong style=\"color:blue;\" >"+ "(" + fuzzyList[i].datano + ")" + "</strong>";
		$("#"+tId+"_span").empty(); 
		$("#"+tId+"_span").append(tNm); 
	}
}

////////////////////////////////////////////////////////////////////////////////
// 트리 검색
////////////////////////////////////////////////////////////////////////////////
/**
 * 트리명칭 CSS 함수(탭 안의 TREE)
 */
function getFontCss(treeId, treeNode) {
	return (!!treeNode.highlight) ? {
		color : "#083a61",
		"font-weight" : "bold"		
	} : {
		color : "#333333",
		"font-weight" : "normal"
	};
}

/**
 * 트리명칭 CSS 함수(메인 TREE)
 */
function getMainFontCss(treeId, treeNode) {
	return (!!treeNode.highlight) ? {
		color : "#083a61",
		"font-weight" : "bold"		
	} : {
		color : "#333333",
		"font-weight" : "normal"
	};
}

////////////////////////////////////////////////////////////////////////////////
//트리 이벤트
////////////////////////////////////////////////////////////////////////////////
/**
* 트리 노드 컨트롤 함수
* @param id	tree가 담겨져 있는 <ul> id
* @param func	CHK : 전체 체크 UN_CHK : 전체 체크 해제 EXP : 트리 노드 전체 열기 UN_EXP : 트리 노드 전체 닫기
*/
function treeNodeControl(id, func) {
	var zTree = $.fn.zTree.getZTreeObj(id);

	if (func == "CHK") {
		zTree.checkAllNodes(true);
	} else if (func == "UN_CHK") {
		zTree.checkAllNodes(false);
	} else if (func == "EXP") {
		zTree.expandAll(true);
	} else if (func == "UN_EXP") {
		zTree.expandAll(false);
	}
}

/**
 * 분류 CLS가 없을경우 화면처리(메인화면 트리)
 */
function clsBoxDisplay(clsCount){
	var searchGb = $("#searchGb").val();
	var wHeight = $(window).height();
	var wWidth = $(window).width();

	if (clsCount == 0) { // 분류선택이 없을 경우 [항목선택 화면을 늘리고 분류선택 화면은 hidden 시킨다.]
		if (searchGb == "M") {
			$("#clsTitle").hide();
			$("#clsBox").hide();
			if ($('body').hasClass('wide')) {
				$('.wide .lSide .treeBox.size3').css("height", (wHeight - 186) + "px");
				$('#itmTreeBox').css("height", (wHeight - 186) + "px");
			} else {
				$('.lSide .treeBox.size3').css("height", "500x");
				$("#itmTreeBox").css('height', 500);
			}
		}
		$("#treeClsData").empty();

		// 탭생성시 사용하기 위해 분류Data를 전역변수에 담아놓는다.
		// 비어있을 경우도 담는다.
		clsData = "";
	} else {
		if (searchGb == "M") {
			$("#clsTitle").show();
			$("#clsBox").show();
			if ($('body').hasClass('wide')) {
				$('.wide .lSide .treeBox.size3').css("height", (wHeight / 2 - 145) + "px");
				$('#itmTreeBox').css("height", (wHeight / 2 - 145) + "px");
				$('#treeClsData').css("height", (wHeight / 2 - 145) + "px");
			} else {
				$('.lSide .treeBox.size3').css("height", "350px");
				$("#itmTreeBox").css('height', 310);
				$("#treeClsData").css('height', 210);
			}
		}
	}
}
