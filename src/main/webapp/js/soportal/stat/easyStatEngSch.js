/*
 * @(#)easyStatSch.js 1.0 2017/11/30
 * 
 * COPYRIGHT (C) 2013 WISEITECH CO., LTD. ALL RIGHTS RESERVED.
 */

/**
 * 간편통계 관련 스크립트 파일이다.
 * 
 * @author 김정호
 * @version 1.0 2017/11/30
 */
// //////////////////////////////////////////////////////////////////////////////
// 글로벌 변수
// //////////////////////////////////////////////////////////////////////////////
var isMobile = $(window).width() <= 980 ? true : false; // 모바일 접근 여부
var isFirst = false; 		// 최초 조회 여부(파라미터로 통계표 ID 넘어와서 조회한 경우)
var sheetUsrTabCnt = 0; 	// 유저시트 갯수
var sheetItmTabCnt = 0; 	// 항목시트 갯수
var sheetCateTabCnt = 0; 	// 분류시트 갯수
var statTabCnt = 0; 		// 통계화면 갯수(탭)
var dtadvsLoc = null; 		// 단위 위치
var MOBILE_CD = "M";		// 모바일 코드
var PC_CD = "P";			// PC 코드

var itmData = "";
var clsData = "";
var chartData = "";
var hightChart = "";
var gridH;
var nodeList = [];
var selectNode = "";

var SEARCH_LIMIT_CNT = 20000;		// 셀 검색 제한 갯수
var DOWN_LIMIT_CNT = 200000;		// 셀 다운로드 제한 갯수
var confirmAction = "";
// 모바일 메인 리스트 템플릿(검색결과도 같이 사용)
var mbListTemplate = {
	row : "<li>"
			+ "<a href=\"javascript:;\" name=\"\"><strong class=\"tit\"></strong></a>"
			+ "</li>",
	none : "<li><strong class=\"tit\">"+jsMsg01+"</strong></li>"
}

//통계이력 리스트 템플릿
var histTemplates = {
	row : 
		"<tr>"+
		"	<td class=\"dtacycleCdNm\"></td>" +
		"	<td class=\"wrttimeIdtfrIdNm\"></td>" +
		"	<td class=\"regDttm\"></td>" +
		"</tr>",
	none : "<td colspan=\"3\" class=\"noData\">해당 이력이 없습니다.</td>"
};

// //////////////////////////////////////////////////////////////////////////////
// Script Init Loading...
// //////////////////////////////////////////////////////////////////////////////
$(function() {
	/* 컴포넌트를 초기화한다. */
	initComp();

	/* 통계화면 컨트롤 정의(이벤트) */
	eventControl();

	$(window).resize(function() {
		remarkInit();
	});
	
	// GNB메뉴 바인딩한다.
	menuOn(1, 1);
});

////////////////////////////////////////////////////////////////////////////////
// 초기화 함수
////////////////////////////////////////////////////////////////////////////////
/**
 * 컴포넌트를 초기화한다.
 */
function initComp() {
	tabSet();
	
	if ( gfn_isNull($("#statSearchVal").val()) ) {
		loadMainPage();
	} else {
		//통합검색에서 검색어가 넘어온 경우 검색된 항목을 표시한다.
		loadMainPage(true);
	}
	
	loadMainMobileTopCate();

	/* 화면 로드시 파라미터 값으로 전달받은경우 바로 관련 탭 연다. */
	if (!com.wise.util.isBlank($("#firParam").val())) {
		isFirst = true;
		if (isMobile) {
			tabStatEvent(MOBILE_CD);
		} else {
			tabStatEvent(PC_CD);
		}
	}
	
	/* PC일때만 페이져 보여준다. */
	if ( !isMobile ) {
		$("#stat-pager-sect").hide();
	} else {
		$("#stat-pager-sect").show();
	}
	
	/* 화면 로드시 검색값 searchVal이 있는 경우 확인 */
	searchGetVal();
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

	/* 검색하였거나, PC이거나, 검색어가 있는경우 */
	if (searchFlag && !isMobile && ( !gfn_isNull($("#searchVal").val()) || !gfn_isNull($("#hdnKeywordVal").val()) ) ) {
		// PC에서 조회한 경우
		loadMainMobileList($("#commonForm [name=page]").val());
		loadMainSearchList();
	} else {
		loadMainMobileList($("#commonForm [name=page]").val());
		loadMainTreeList();
	}
}
/**
 * PC 메인 통계표 목록 트리 리스트
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
		
		// 2018.04.24 김정호 - 웹 접근성 인증마크 관련 Tree에 탭 이벤트 및 클릭이벤트를 바인드한다
		//eventZTreeTabFocus("treeStatData", true);
	}
	$("#hdnKeywordVal").val(""); // 명칭별(키워드) 검색 히든값 초기화
	// 모바일 통계주제 로드(콤보박스)
	//setStatMobileSubj(data);
}
/**
 * 모바일 메인 통계표 목록 리스트 조회
 */
function loadMainMobileList(page) {
	doSearch({
		url : "/portal/stat/easyStatMobileList.do",
		page : page ? page : "1",
		before : beforeMobileList,
		after : afterMobileList,
		pager : "stat-pager-sect"
	});
}

/**
 * 모바일용 통계주제 세팅
 */
function loadMainMobileTopCate() {
	doSearch({
		url : "/portal/stat/statCateTopList.do",
		before : function() {
			return {statblId : $("#sId").val()}
		},
		after : afterMobileTopCate
	});
}

/**
 * 메인 통계표 목록 검색 결과 조회
 */
function loadMainSearchList() {
	doSearch({
		url : "/portal/stat/easyStatSearchList.do",
		before : beforeSearchList,
		after : afterSearchList
	});
}
/**
 * 메인 모바일 리스트 조회 전처리(페이징 처리)
 */
function beforeMobileList(options) {
	var form = $("#commonForm");
	if (com.wise.util.isBlank(options.page)) {
		form.find("[name=page]").val("1");
	} else {
		form.find("[name=page]").val(options.page);
	}
	var data = {
		statblId : $("#sId").val(),
		searchVal : $("#searchVal").val(),
		searchGubun : $("#searchGubun").val(),
		searchKeywordVal : $("#hdnKeywordVal").val(),
		mbSubject : $("#mbSubject").find("option:selected").val(),
		page : form.find("[name=page]").val(),
		langGb : $("#langGb").val()
	};
	return data;
}
/**
 * 메인 검색결과 전처리
 */
function beforeSearchList(options) {
	var data = {
		statblId : $("#sId").val(),
		searchVal : $("#searchVal").val(),
		searchGubun : $("#searchGubun").val(),
		searchKeywordVal : $("#hdnKeywordVal").val(),
		langGb : $("#langGb").val()
		/*mbSubject : $("#mbSubject").find("option:selected").val()*/
	};
	return data;
}
/**
 * 메인 모바일 리스트 후처리
 */
function afterMobileList(data) {
	setMainStatListNEvent("mobileList", data);
}
/**
 * 메인 검색결과 후처리
 */
function afterSearchList(data) {
	setMainStatListNEvent("searchResult", data);
}
/**
 * 메인 리스트 표시 및 이벤트
 * @param id 	표시 할 element id
 * @param data	리스트 data
 */
function setMainStatListNEvent(id, data) {

	if (id.indexOf("search") > -1) {
		// 검색결과로 들어온 경우 검색결과 창 보여준다
		$("#searchResult").show();
	}
	if (data.length > 0) {
		$("#" + id + " ul").empty();
		// 데이터 length 별로 템플릿에 row단위로 입력
		for (var i = 0; i < data.length; i++) {
			var template = $(mbListTemplate.row);
			template.find("a").attr("name", data[i].statblId); // 통계표 ID
			template.find(".tit").text(data[i].statblNm); // 통계표 명
			$("#" + id + " ul").append(template);
		}
		$("#" + id + " ul li:eq(0) a").focus();		// 2018.04.24 김정호 - 검색창 팝업시 첫번째 검색결과에 focus를 준다.

		// 모바일 통계선택 이벤트(row단위로 이벤트 준다)
		$(".leftArea #" + id + " li").each(function(index, element) {
			$(this).bind("click", function(event) {
				if (id.indexOf("search") > -1) {
					// 리스트 선택시 항목, 분류 보여준다.(PC에서)
					selStat($(this).find("a").attr('name'));
				} else {
					$("#sId").val($(this).find("a").attr('name'));
					$('#stat_title').text($(this).find("a strong").text());

					if ($("#statsGB").val() == "Mix") { // 모바일 화면 복수 통계 일 경우
						// 항목/분류 선택화면을 노출한다.
						$('.easySearch').addClass('complex2');
					} else {
						// 조회 검색 셀 갯수 제한 validation		
						var chkParam = {
							type : 1,
							obj : $("form[name=searchForm]"),
							itmDataNm : "treeItmData",
							clsDataNm : "treeClsData"
						};
						if ( validSearchLimit(chkParam) ) {
							tabStatEvent(MOBILE_CD); // 통계 탭 생성
						}
					}
				}
			});
		});
	} else {
		$("#" + id + " ul").empty().append($(mbListTemplate.none));
	}
}
////////////////////////////////////////////////////////////////////////////////
// 액션 처리 함수들
////////////////////////////////////////////////////////////////////////////////
/**
 * 통계스크랩으로 접근한 경우 수행 Action
 * @param id	통계표 ID
 */
function doUsrTblAction(id) {
	/* 항목, 분류 트리 로드 */
	statsTreeLoad("I");
	statsTreeLoad("C");
	/* 항목, 분류 트리 통계스크랩에 선택된 항목으로 체크 */
	setUsrTblChk(id, "Itm");
	setUsrTblChk(id, "Cls");
	/* 항목 분류 이벤트 설정 */
	itmStatDivEvent();
	/* 소수점 값 세팅 */
	loadComboOptionsDef("dmPointVal", "/portal/stat/statOption.do", {grpCd : "S1109"}, getStringParam("dmPointVal"), jsMsg02);
	/* 단위 값 세팅 */
	loadComboOptionsDef("uiChgVal", "/portal/stat/statTblUi.do", {statblId : id}, getStringParam("uiChgVal"), jsMsg03);
	/* 탭 메인화면에 통계표 선택처리 */
	selStat(id);
}
/**
 * 통계스크랩으로 접근한 경우 수행 Action
 * @Param id	통계표 ID
 * @param datas	기본 세팅 데이터(탭 추가시 callback으로 넘어온다)
 */
function doMobileNFirstAction(id, datas) {
	/* 항목, 분류 트리 로드 */
	statsTreeLoad("I");
	statsTreeLoad("C");
	/* 항목 분류 이벤트 설정 */
	itmStatDivEvent();
	/* 소수점 값 세팅 */
	loadComboOptionsDef("dmPointVal", "/portal/stat/statOption.do", {grpCd : "S1109"}, (datas != null ? datas.dmPointVal : ""), jsMsg02);
	/* 단위 값 세팅 */
	loadComboOptionsDef("uiChgVal", "/portal/stat/statTblUi.do", {statblId : id}, (datas != null ? datas.uiChgVal : ""), jsMsg03);
	/* 탭 메인화면에 통계표 선택처리 */
	selStat(id);
}
/**
 * 통계스크랩 신규저장
 */
function doUsrTblApply() {
	var objTab = getTabShowObj();// 탭이 open된 객체가져옴
	var formObj = objTab.find("form[name=statsEasy-mst-form]");

	doPost({
		url : "/portal/stat/insertStatUserTbl.do",
		before : beforeUsrTblApply,
		after : function(data) {
			jAlert(data.messages);
			if ( data.success ) {
				formObj.find("input[name=usrTblSeq]").val(data.usrTblSeq);
				// 통계스크랩 창 숨기고 수정버튼 보이도록
				formObj.find($(".layerPopup.usrTblPop")).hide();
				formObj.find("a[name=usrTblUpd]").show();
			} else {
				formObj.find("a[name=usrTblUpd]").hide();
			}
		}
	});
}
/**
 * 통계스크랩 수정
 */
function doUsrTblUpd() {
	var objTab = getTabShowObj();// 탭이 open된 객체가져옴
	var formObj = objTab.find("form[name=statsEasy-mst-form]");

	doPost({
		url : "/portal/stat/updateStatUserTbl.do",
		before : beforeUsrTblUpd,
		after : function(data) {
			jAlert(data.messages);
			if ( data.success ) {
				formObj.find("input[name=usrTblSeq]").val(data.usrTblSeq);
				// 통계스크랩 창 숨김
				formObj.find($(".layerPopup.usrTblPop")).hide();
			}
		}
	});
}
/**
 * 항목선택 조회 
 */
function doItmSearch() {
	/*
	// 항목선택 초기화한다.
	$("#treeItmData").empty();
	$("#searchGb").val("S");

	statsMainTreeLoad("I");*/
	$("#searchGb").val("S");
	searchNode("treeItmData", $("#itmSearchVal").val());
}
/**
 * 분류선택 조회
 */
function doClsSearch() {
	/*
	// 분류선택 초기화한다.
	$("#treeClsData").empty();
	$("#searchGb").val("S");

	statsMainTreeLoad("C");*/
	$("#searchGb").val("S");
	searchNode("treeClsData", $("#clsSearchVal").val());
}
/**
 * 통계표 엑셀 다운
 */
function doStatExcelDown() {
	var f = document.commonForm;
	var action = com.wise.help.url("/portal/stat/easyStatListExcel.do");
	f.target = "iframePopUp";
	f.action = action;
	f.submit();
}
////////////////////////////////////////////////////////////////////////////////
// 시트 관련 함수들
////////////////////////////////////////////////////////////////////////////////
/**
 * 시트 재생성
 */
function reCreateSheet() {
	var objTab = getTabShowObj();// 탭이 open된 객체가져옴
	var formObj = objTab.find("form[name=statsEasy-mst-form]");
	var sheetNm = formObj.find($(".grid.statEasySheet")).attr('id');
	sheetNm = sheetNm.replace("DIV_", "");

	formObj.find(".txtHistory").hide();	//통계이력 통계일자 숨김
	formObj.find($(".grid")).empty(); // 화면에 Display하기전에 해당 위치의 내용을 초기화한다.

	var sheetobj = window[sheetNm];
	sheetobj.Reset(); 			// 윈도우 객체에 담은 해당 DIV객체를 초기화한다.
	setTimeout("statSheetCreate(\""+sheetNm+"\")", 100); 	// 통계 시트 새로조회
}
/**
 * 통계 조회 탭 Sheet 생성
 * @Param sheetNm	통계표 시트명
 */
function statSheetCreate(sheetNm) {
	var objTab = getTabShowObj();// 탭이 open된 객체가져옴
	var formObj = objTab.find("form[name=statsEasy-mst-form]");
	
	createIBSheet2(document.getElementById("DIV_" + sheetNm), sheetNm, "100%", "500px"); 

	var sheetobj = window[sheetNm];
	
	/* 통계 시트 컬럼 세팅(헤더설정) */
	loadEasySheet(sheetNm, sheetobj);

	// 시트 조회후 이벤트
	window[sheetNm + "_OnSearchEnd"] = sheetOnSearchEnd;

	// 파라미터로 접근 한 경우 java에서 넘어온 파라미터값으로 param 값 넘겨준다.
	var param = null;
	if ( isFirst ) {
		param = $("#firParam").val();
		if($("#mainCall").val() == "Y") param += "&dtadvsVal=PD&dtadvsVal=PR";
	} else {
		param = formObj.serialize();
	}
	var params = {
		PageParam : "ibpage",
		Param : "onepagerow=50&" + param
	};
	sheetobj.SetWaitImageVisible(0);	//조회중 이미지 보이지 않게 설정
	
	sheetobj.DoSearchPaging(com.wise.help.url("/portal/stat/ststPreviewList.do"), params);

	// 조회 완료 후 시트 및 차트의 사이즈 조절
	remarkInit();
}
/**
 * 통계 시트 컬럼 세팅(헤더설정)
 * @param sheetNm	통계표 시트명
 * @param sheetobj	시트객체
 */
function loadEasySheet(sheetNm, sheetobj) {
	var objTab = getTabShowObj();// 탭이 open된 객체가져옴
	var formObj = objTab.find("form[name=statsEasy-mst-form]");

	var gridArr = [];
	var iArr = null;
	var sheetCols = [];

	// 파라미터로 접근 한 경우 java에서 넘어온 파라미터값으로 param 값 넘겨준다.
	var params = null;
	if (isFirst) {
		params = $("#firParam").val() + "&searchType=" + $("#searchType").val();
		if($("#mainCall").val() == "Y") params += "&dtadvsVal=PD&dtadvsVal=PR&mainCall=Y";
	} else {
		params = formObj.serializeObject();
	}

	$.ajax({
			url : com.wise.help.url("/portal/stat/statTblItm.do"),
			async : false,
			type : 'POST',
			data : params,
			dataType : 'json',
			beforeSend : function(obj) {
				$("#loadingCircle").show();	//조회중 표시
			}, // 서버 요청 전 호출 되는 함수 return false; 일 경우 요청 중단
			success : function(data) {
				var text = data.data.Text; // 헤더 컬럼 text 정보
				var cols = data.data.Cols; // 헤더 컬럼 속성정보
				var cmmtRowCol = data.data.cmmtRowCol;
				var loadDtadvsLoc = data.data.dtadvsLoc;
				for (var i = 0; i < text.length; i++) {
					var tdata = text[i];
					iArr = new Array();
					for ( var t in tdata) {
						iArr.push(tdata[t]);
					}
					gridArr.push({
						Text : iArr.join("|"),
						Align : "Center"
					});
				}

				for ( var c in cols) {
					sheetCols.push({
						Type : cols[c].Type,
						SaveName : cols[c].SaveName,
						Width : cols[c].Width,
						Align : cols[c].Align,
						Edit : cols[c].Edit,
						Hidden : cols[c].Hidden,
						ColMerge : cols[c].ColMerge,
						RowMerge : cols[c].ColMerge
					});
				}

				with (sheetobj) {
					var cfg = { SearchMode : 0, Page : 10, MouseHoverMode : 1, VScrollMode:0, SelectionRowsMode : 1, MergeSheet : msAll, DataRowMerge: 1, ColPage: 20 };

					SetConfig(cfg);
					
					InitHeaders(gridArr, {Sort : 0, ColMove : 0, ColResize : 0, HeaderCheck : 0});
					InitColumns(sheetCols);
				}

				default_sheet(sheetobj);
				portal_sheet(sheetobj);	//포털화면 시트 별도 로딩바 생성 안되도록 처리

				// 헤더에 주석식별자 입력
				for ( var cmmt in cmmtRowCol) {
					sheetobj.SetHtmlHeaderValue(cmmtRowCol[cmmt].row, cmmtRowCol[cmmt].col, cmmtRowCol[cmmt].cmmt);
				}

				// 통계자료 행or열 숨김 처리(원자료만 있는 경우)
				if ( loadDtadvsLoc.LOC != "" ) {
					dtadvsLoc = loadDtadvsLoc
				}

				// 모바일 접근이거나 파라미터로 direct로 접근한 경우
				if ( formObj.find("input[name=deviceType]").val() == "M" || isFirst ) {
					// 탭 화면에 통계정보를 display 한다
					statTabDisplay(sheetNm, data.data.statCond);
				}

				// 바닥라인 삭제
				//formObj.find($('.GMFillRow')).closest('tr').remove();
				//formObj.find($('.GMHScrollMid')).closest('tr').remove();
				formObj.find($('.GMCountRowBottom')).closest('tr').remove();
				
				// 데이터 로드 후 포커스를 설정하지 않도록 설정
				sheetobj.SetFocusAfterProcess(0);
				
			}, // 요청 완료 시
			error : function(request, status, error) {
				handleError(status, error);
			}, // 요청 실패.
			complete : function(jqXHR) {
			} // 요청의 실패, 성공과 상관 없이 완료 될 경우 호출
		});
}
/**
 * 시트 조회 후 처리
 */
function sheetOnSearchEnd(code, message, statusCode, statusMessage) {
	var objTab = getTabShowObj();// 탭이 open된 객체가져옴
	var formObj = objTab.find("form[name=statsEasy-mst-form]");
	var sheetNm = formObj.find($(".grid.statEasySheet")).attr('id');
	sheetNm = sheetNm.replace("DIV_", "");
	var sheetObj = window[sheetNm];

	if (isFirst) {
		// 파라미터로 다이렉트 접근시 세팅값 초기화
		isFirst = false;
		$("#firParam").val("");
		$("#searchType").val("");
	}

	// 통계자료 hidden 처리(원자료만 존재할 경우)
	if (dtadvsLoc.LOC != "") {
		if (dtadvsLoc.LOC == "HEAD") {
			sheetObj.SetRowHidden(dtadvsLoc.CNT, 1);
		} else if (dtadvsLoc.LOC == "LEFT") {
			sheetObj.SetColHidden(dtadvsLoc.CNT, 1);
		}
	}

	// 컬럼 열 고정
	var frozenCol = -1
	if ( sheetObj.LastCol() > -1 ) {
		for ( var i=0; i < sheetObj.LastCol(); i++ ) {
			var colSaveNm = sheetObj.ColSaveName(i);
			if ( colSaveNm.indexOf("COL_") > -1 ) {
				frozenCol = i;
				break;
			}
		}
		sheetObj.SetFrozenCol(frozenCol);
	}
	   
	formObj.find("input[name=deviceType]").val("");

	//통계표 이력 조회 CycleNo(키값) => 값이 있으면 통계표 이력에서 조회한다.(조회 할때마다 초기화 해준다.)
	formObj.find("input[name=hisCycleNo]").val("");	
	
	//sheet 상단에 피봇 값에 따라 설정한 값 이미지 표시 
	showSheetPivotImg();
	
	formObj.find(".tabBx .tabSt li").removeClass("on");
	formObj.find(".tabBx .tabSt li").eq(0).addClass("on").click();
	
	// 20180508/김정호 - 조회 완료후 무조건 최상단으로 focus
	$(".gnb-area .left li:eq(0) a").attr("tabindex", -1).focus();

	hideLoading();
	
}
////////////////////////////////////////////////////////////////////////////////
// 사용자 정의 공통 함수
////////////////////////////////////////////////////////////////////////////////
/**
 * 콤보박스를 로드한다(코드 ""(공백) 추가)
 * 
 * @param id 	element id
 * @param url	url
 * @param data	parameter
 * @param value 콤보박스에 선택될 값
 * @param txt 	공백 코드일 경우 text값
 */
function loadComboOptionsDef(id, url, data, value, txt) {
	var objTab = getTabShowObj();// 탭이 open된 객체가져옴

	$.post(com.wise.help.url(url), data, function(data, status, request) {
		if (data.data) {
			// 콤보 옵션을 초기화한다.
			initTabComboOptions(objTab, id, [ {
				code : "",
				name : txt
			} ].concat(data.data), value);
		}
	}, "json");
}

/**
 * GET으로 입력된 parameter를 array단위로 추출
 * @param key	추출하려는 키값
 * @returns 	{Array}
 */
function getStringParamArr(key) {
	var key = key || ""
	var arr = [];
	var s = $("#firParam").val().split("&"); // 설정하려는 파라미터 값들
	
	for (var i = 0; i < s.length; i++) {
		var el = s[i]; // ex) dtacycleCd=MM
		var elDt = el.substr(el.indexOf("=") + 1); // key를 뺀 값
		if (!gfn_isNull(key)) {
			if (el.indexOf(key) > -1) {
				// 키 값이 str에 있으면
				arr.push(elDt);
			}
		} else {
			arr.push(elDt);
		}
	}
	return arr;
}

/**
 * GET으로 입력된 parameter를 값으로 추출
 * @param key	추출하려는 키값
 * @returns 	{String}
 */
function getStringParam(key) {
	var val = "";
	var key = key || "";
	var s = $("#firParam").val().split("&"); // 설정하려는 파라미터 값들
	for (var i = 0; i < s.length; i++) {
		var el = s[i];
		var elDt = el.substr(el.indexOf("=") + 1); // key를 뺀 값
		if (el.indexOf(key) > -1) {
			val = elDt;
		}
	}
	return val;
}
////////////////////////////////////////////////////////////////////////////////
// 통계스크랩 관련 함수
////////////////////////////////////////////////////////////////////////////////
/**
 * 통계스크랩 신규등록 전처리 
 */
function beforeUsrTblApply() {
	var objTab = getTabShowObj();// 탭이 open된 객체가져옴
	var formObj = objTab.find("form[name=statsEasy-mst-form]");

	if ( gfn_isNull(formObj.find("input[name=usrTblStatblNm]").val()) ) {
		jAlert(alertMsg11);
		return null;
	}
	var params = jsonfy(formObj);
	params["statTitle"] = formObj.find("input[name=usrTblStatblNm]").val(); 	// 통계자료명
	params["statblExp"] = formObj.find("input[name=usrTblStatblExp]").val(); 	// 통계자료설명
	params["chkItms"] = getChkedStatArrVal("itm"); // 체크한 항목
	params["chkClss"] = getChkedStatArrVal("cls"); // 체크한 분류
	params["dtadvsVals"] = getChkedStatArrVal("dvs"); // 체크한 증감분석
	return params;
}
/**
 * 통계스크랩 수정 전처리 
 */
function beforeUsrTblUpd() {
	var objTab = getTabShowObj();// 탭이 open된 객체가져옴
	var formObj = objTab.find("form[name=statsEasy-mst-form]");
	var usrTblSeq = formObj.find("input[name=usrTblSeq]").val();
	if ( gfn_isNull(usrTblSeq) ) {
		alert(alertMsg12);
		return null;
	}
	if ( gfn_isNull(formObj.find("input[name=usrTblStatblNm]").val()) ) {
		jAlert(alertMsg11);
		return null;
	}
	var params = jsonfy(formObj);
	params["statTitle"] = formObj.find("input[name=usrTblStatblNm]").val(); 	// 통계자료명
	params["statblExp"] = formObj.find("input[name=usrTblStatblExp]").val(); 	// 통계자료설명
	params["chkItms"] = getChkedStatArrVal("itm"); // 체크한 항목
	params["chkClss"] = getChkedStatArrVal("cls"); // 체크한 분류
	params["dtadvsVals"] = getChkedStatArrVal("dvs"); // 체크한 증감분석
	params["seqceNo"]  = usrTblSeq;
	
	return params;
}
/**
 * 통계스크랩 화면 접근시 통계스크랩된 항목/분류 데이터로 tree 체크
 * @param id :	통계표 ID
 * @param gubun	Itm : 항목, Cls : 분류, dvs : 증감분석
 */
function setUsrTblChk(id, gubun) {
	var chkVals = null;
	if (gubun == "Itm" || gubun == "Cls") {
		chkVals = getStringParamArr("chk" + gubun + "s");
		treeObj = $("#"+id).dynatree("getTree");
	} else {
		chkVals = getStringParamArr(gubun);
		treeObj = $("#"+id).dynatree("getTree");
	}
	
	// 트리 노드를 가져와서 array 값에 있는 것만 체크함
/*	if ( treeObj != null ) {
		var nodes = treeObj.tnRoot.childList;
		for (var i = 0; i < nodes.length; i++) {
			if ($.inArray(String(nodes[i].data.key), chkVals) == -1) {
				// array에 값이 없을경우 체크 해제
				nodes[i].select(false); 
			} else {
				nodes[i].select(true); 
			}
		}
	}*/
}
/**
 * 항목, 분류에 체크된 항목들을 가져와서 배열로 만든다.(통계스크랩 저장시 사용) 
 */
function getChkedStatArrVal(gubun) {
	var results = [];
	var objTab = getTabShowObj();// 탭이 open된 객체가져옴
	var formObj = objTab.find("form[name=statsEasy-mst-form]");

	var treeId = gubun + formObj.find("input[name=statblId]").val();
	var liCnt = $("#"+treeId).find("li").length;

	if(liCnt > 1){		
		var treeObj = $("#"+treeId).dynatree("getSelectedNodes");
	
		if (treeObj.length > 0) {
			for ( var n in treeObj) {
				results.push(treeObj[n].data.key);
			}
		}
	}
	return results;
}
// //////////////////////////////////////////////////////////////////////////////
// 탭 관련 함수
// //////////////////////////////////////////////////////////////////////////////
function tabSet() { // 탭 객체 생성
	openTab = new OpenTab(tabId, tabContentClass, tabBody); // headinclude.jsp
															// 변수 있음
	openTab.TabObj = openTab;
	openTab.addTabClickEvent();
}
// 탭 버튼 이벤트(오픈 된 탭을 선택시) => 탭 이동시마다 선택됨(메인탭은 제외)
function buttonEventAdd() {
	setTabButton();

	var objTab = getTabShowObj();// 탭이 open된 객체가져옴
	var formObj = objTab.find("form[name=statsEasy-mst-form]");
	
	//탭 이동시 트리 관련 obj 재생성
	treeRefreshEvent("I");	//항목트리
	treeRefreshEvent("C");	//분류트리
	treeRefreshEvent("D");	//증감분석 트리
	
	itmStatDivEvent();		//항목 팝업 버튼 이벤트 생성
	statTblEvent();			//증감분석 팝업 버튼 이벤트 생성
	viewOptionStatEvent();	//피봇설정 팝업 버튼이벤트 설정
	
	// 탭선택 시 차트를 다시 읽는다.
	//loadChart();
}

// 탭 버튼 이벤트 추가
function setTabButtonEvent() {
}

/**
 * 탭 생성 후 콜백
 * @param tab	탭 객체
 * @param data	콜백 데이터
 */
function tabSetDataFunc(tab, data) {
	var params={statblId: $("#sId").val(), metaCallYn : "Y", langGb: $("#langGb").val() };
	$.ajax({
		url : com.wise.help.url("/portal/stat/selectEasyStatDtl.do"),
		async : false,
		type : 'POST',
		data : params,
		dataType : 'json',
		beforeSend : function(obj) {
		}, // 서버 요청 전 호출 되는 함수 return false; 일 경우 요청 중단
		success : function(res) {
			var data = res.data;
			var statData = data.DATA; // 통계표 기본 정보
			
			$("#stat_title").text(statData.statblNm);
			tab.ContentObj.find("input[name=statId]").val(statData.statId);		//통계ID(메타데이터 열기 로그 남길시 필요)
			tab.ContentObj.find($(".txt.cmmtIdtfr")).text(gfn_isNull(statData.cmmtIdtfr) ? "" : statData.cmmtIdtfr); // 통계표 식별번호
			
			// 메타데이터 Display
			var metaData = data.META_DATA;
			//메타항목이 정해져 있어서 metaId로 하드코딩 했어요...
			for ( r in metaData ) {
				var metaId = metaData[r].metaId;
				var metaCont = openRealceAll(metaData[r].metaCont).replace("null", "");
				if ( metaId == 81000244 ) {	//제공부서
					var orgNm = tab.ContentObj.find($(".meta_81000106")).text();
					tab.ContentObj.find($(".meta_81000106")).text(orgNm + " " + metaCont);
				} else {
					tab.ContentObj.find($(".meta_"+metaId)).text(metaCont);
				}
			}

			var chk = JSON.stringify(data.DATA2);
			var chkData = JSON.parse(chk);

			var optData = chkData.OPT_DATA; // 통계표 옵션 정보
			var optCdDc = ""; 			// 검색자료주기 선택값
			var wrttimeLastestVal = ""; // 검색 시계열 수
			var optIU = "";				//항목단위 출력여부

			if (optData.length > 0) {
				for (var i = 0; i < optData.length; i++) {
					if (optData[i].optCd == "DC") {
						optCdDc = optData[i].optVal; // 검색자료주기 선택 확인
					} else if (optData[i].optCd == "TN") {
						wrttimeLastestVal = optData[i].optVal; // 검색시계열 수 확인
					} else if (optData[i].optCd == "IU") {	//항목단위 출력
						optIU = optData[i].optVal;
					}
				}
			}
			
			//항목단위 출력여부가 'N'일 경우만 대표단위 표시
			if ( optIU == "N" && statData.rpstuiNm ) {
				tab.ContentObj.find($(".rpstuiNm")).text("  ("+jsMsg04+" : " + statData.rpstuiNm + ")");
			}

			//주기별 이력생성여부 Y인경우 통계이력 버튼 표시
			if ( statData.hisCycleYn == "Y" ) {
				tab.ContentObj.find("button[name=btnStatHist]").show();
			}

			// 메타데이터 Display - 작성주기
			//$('#easySheet').find("span[name=meta06]").text($("form[name=searchForm]").find("[name=dtacycleCd]").text()); // 작성주기
			
			// 주석 Display
			var cmmtData = "";
			$.each(chkData.CMMT_DATA, function(key, value) {

				if (value.cmmtGubun == "TBL") {
					cmmtData += "<br/><span style='color: blue; font-weight:bold;'>" + (gfn_isNull(value.cmmtIdtfr) ? "" : value.cmmtIdtfr) + "</span>" + openRealceAll(value.cmmtCont, "\n","<br/>");
				} else {
					cmmtData += "<br /><span style='color: blue; font-weight:bold;'>"+ (gfn_isNull(value.cmmtIdtfr) ? "" : value.cmmtIdtfr) + "</span> "+ openRealceAll(value.cmmtCont, "\n","<br/>") ;
				}    
			});
			$('.remark').find($(".cmmt")).empty().append(cmmtData);
			
			//통계표 열람 확인 로그 남김
			insertStatLogs("TBL", {statblId: statData.statblId});
		}, // 요청 완료 시
		error : function(request, status, error) {
			handleError(status, error);
		}, // 요청 실패.
		complete : function(jqXHR) {
		} // 요청의 실패, 성공과 상관 없이 완료 될 경우 호출
	});
}
////////////////////////////////////////////////////////////////////////////////
// 포털 서비스 함수들
////////////////////////////////////////////////////////////////////////////////
/**
 * 로딩바 보여준다.
 */
function showLoading() {
	$("#loadingCircle").show();
}

/**
 * 로딩바 숨긴다.
 */
function hideLoading() {
	$("#loadingCircle").hide();
}
/**
 * alert 메시지 생성
 * @Param msg	메시지 text 
 */
function jAlert(msg) {
	$("#alertMsg").text(msg);
	$("#alert-box").show();
	$("#alert-box-focus").val(document.activeElement.name);	// 창 닫기 후 이동할 focus 위치 지정
	$("#alert-box .type02").focus();						// 확인 버튼으로 focus
}

/**
 * confirm 메시지 생성
 * @param msg
 * @param okFunc
 */
function jConfirm(msg, okFunc) {
	$("#confDown").hide();
	$("#confAction").show();
	$("#confirmMsg").text(msg);
	$("#confirm-box").show();
	$("#confirm-box-focus").val(document.activeElement.name);	// 창 닫기 후 이동할 focus 위치 지정
	$("#confirm-box .type02").focus();							// 취소 버튼으로 focus
	
	confirmAction = okFunc;
}

function confirmAction(){
	confirmAction();
}

/**
 * 메세지 창을 닫는다.
 */
function messageDivClose(){
	$("body").addClass("remove-body");
	$("#alert-box").hide();
	$("#confirm-box").hide();
	
	// 20180508/김정호 - alert 메시지 박스 포커스
	var alertboxFocus = $("#alert-box-focus").val();
	if ( !gfn_isNull(alertboxFocus) ) {
		messageDivCloseFocus(alertboxFocus)
		$("#alert-box-focus").val("");
	}
	
	// 20180508/김정호 - confirm 메시지 박스 포커스
	var confirmboxFocus = $("#confirm-box-focus").val();
	if ( !gfn_isNull(confirmboxFocus) ) {
		messageDivCloseFocus(confirmboxFocus)
		$("#confirm-box-focus").val("");
	}
}

/**
 * 20180508/김정호
 * 메세지 창을 닫을때 이전에 선택한 element로 포커스를 이동한다.
 * @param focusElement	이동할 포커스 element
 */
function messageDivCloseFocus(focusElement) {
	var objTab = getTabShowObj();// 탭이 open된 객체가져옴
	
	var tabId = objTab.attr("id");
	if ( tabId.indexOf("tabs-") > -1 ) {	// 메인 탭일 경우
		var formObj = objTab.find("form[name=searchForm]");
	} 
	else {
		var formObj = objTab.find("form[name=statsEasy-mst-form]");
	}
	
	formObj.find("[name="+ focusElement +"]").attr("tabindex", -1).focus();
}

/**
 * 포털 액션시 로그를 남김
 * @Param	type 액션타입 
 */
function insertStatLogs(type, param) {
	var url = "";
	var sysTag = param.sysTag || "K";			//시스템 구분
	var simmixTag = param.simmixTag || "S";		//간편, 복수통계 구분
	
	switch (type) {
	case "STAT":	//메타데이터 열기
		url = "/portal/stat/insertLogSttsStat.do";
		break;
	case "TBL" :	//통계표 열람시
		url = "/portal/stat/insertLogSttsTbl.do";
		param["simmixTag"] = simmixTag
		break;
	}
	param["sysTag"] = sysTag;
	
	if ( !gfn_isNull(url) ) {
		doAjax({url: url, params: param});
	}
}

/**
 * 포털에서 시트 데이터 다운로드 하는 서비스 => 5가지 파일형식 모두 Down2Excel 공통으로 사용(sheet의 데이터구조 그대로
 * 활용하기 위해)
 */
function PortalDownFile(type, fileNm) {
	var objTab = getTabShowObj();// 탭이 open된 객체가져옴
	var formObj = objTab.find("form[name=statsEasy-mst-form]");
	var sheetNm = formObj.find($(".grid.statEasySheet")).attr('id');
	var sheetobj = window[sheetNm.replace("DIV_", "")];

	var url = "";
	switch (type) {
	case "EXCEL":
		url = com.wise.help.url("/portal/stat/down2Excel.do");
		break;
	case "CSV":
		url = com.wise.help.url("/portal/stat/down2Csv.do");
		break;
	case "JSON":
		url = com.wise.help.url("/portal/stat/down2Json.do");
		break;
	case "XML":
		url = com.wise.help.url("/portal/stat/down2Xml.do");
		break;
	case "TXT":
		url = com.wise.help.url("/portal/stat/down2Text.do");
		break;
	default:
		jAlert(alertMsg13);
		return;
		break;
	}
	var params = {
		URL : url,
		ExtendParam : formObj.serialize() + "&fileNm=" + fileNm + "&sysTag=K",
		ExtendParamMethod : "POST",
		SheetDesign : 1,
		Merge : 1,
		Mode : -1,
		NumberFormatMode : 1,
		FileName : fileNm + ".xls",
		SheetName : "excelsheet",
		Multipart : 0
	};
	sheetobj.Down2Excel(params);
	sheetobj.HideProcessDlg();
}
/**
 * 시트 및 차트화면의 사이즈 조절 
 */
function remarkInit() {
	var objTab = getTabShowObj();// 탭이 open된 객체가져옴
	var formObj = objTab.find("form[name=statsEasy-mst-form]");

	var remark = formObj.find($('.remarkDv .remark'));

	var ww = $(window).width();
	if (formObj.find($(".tabCont.sheetTab")).is(':hidden')) {// chart
		if ($('body').hasClass('wide')) {
			(ww > 980) ? gridH = 622 : gridH = 313;
		} else {
			(ww > 980) ? gridH = 502 : gridH = 313;
		}
		
	} else if (formObj.find($(".tabCont.chartTab")).is(':hidden')) {// sheet
		if ($('body').hasClass('wide')) {
			(ww > 980) ? gridH = 642 : gridH = 350;
		} else {
			(ww > 980) ? gridH = 522 : gridH = 350;
		}

	}

	var obj = formObj.find($(".tabCont.sheetTab")).is(':hidden') ? formObj.find(
			$(".tabCont.chartTab")).find($('.chart')) : formObj.find(
					$(".tabCont.sheetTab")).find($('.grid'));
			
	remark.hide();
	formObj.find($('.remarkDv .btn')).removeClass('on');
	formObj.find($('.chartarea')).css({'padding-bottom' : 0});
	formObj.find($('.sheetarea')).css({'padding-bottom' : 0});
	obj.css({
		height : gridH
	});
	
	//chart탭이 선택되어 있는 경우 사이즈 조절시 차트를 새로고침한다.
	if (formObj.find($(".tabCont.sheetTab")).is(':hidden')) loadChart();
		
	//sheetobj.SetSheetWidth(gridH);	//시트 width 조절

	// 글로벌 변수 수정(모바일 여부)
	isMobile = ww <= 980 ? true : false;

	// PC에서 조회한 조회결과가 있는경우 PC모드일때 조회결과 보여준다.
	if ( !isMobile ) {
		$("#stat-pager-sect").hide();
		if ( $("#searchResult li a").size() > 0 ) {
			$("#searchResult").show();
		} else {
			$("#searchResult").hide();
		}
	} else {
		$("#stat-pager-sect").show();
	}
}

////////////////////////////////////////////////////////////////////////////////
//이벤트 관련 함수들
////////////////////////////////////////////////////////////////////////////////
/**
* 통계화면 컨트롤 정의
*/
function eventControl() {
	//최근시점 숫자만
	$("#wrttimeLastestVal").keyup(function(e) {
		statComInputNumObj($("#wrttimeLastestVal"));
		return false;
	});
	$("a[id=addStatTab]").bind("click", function(event) {
		var statblId = $("#sId").val();
		if ( gfn_isNull(statblId) ) {
			jAlert(alertMsg10);
			return false;
		}
		
		var itmDataChkedLen = $("#treeItmData").dynatree("getSelectedNodes").length;
		var clsDataChkedLen = $("#treeClsData").dynatree("getSelectedNodes").length;
		var clsDataLen = $("#treeClsData").find("li").length;
		if ( itmDataChkedLen <= 0 ) {
			jAlert(alertMsg03);
			return false;
		}
		
		if ( clsDataLen > 0 && clsDataChkedLen <= 0 ) {
			jAlert(alertMsg04)
			return false;
		}
		
		// 조회 검색 셀 갯수 제한 validation		
		var chkParam = {
			type : 1,
			obj : $("form[name=searchForm]"),
			itmDataNm : "treeItmData",
			clsDataNm : "treeClsData"
		};
		if ( validSearchLimit(chkParam) ) {
			tabStatEvent();
		}
		
	});
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
	// 전체목록받기
	$("button[name=btn_statExcelDwon]").bind("click", function(event) {
		doStatExcelDown();
	});
	// 항목선택 조회
	$("button[name=btn_itmInquiry]").bind("click", function(event) {
		doItmSearch();
	});
	// 항목선택 조회 enter
	$("input[name=itmSearchVal]").bind("keydown", function(event) {
		// 엔터키인 경우
		if (event.which == 13) {
			doItmSearch();
			return false;
		}
	});
	// 분류선택 조회
	$("button[name=btn_clsInquiry]").bind("click", function(event) {
		doClsSearch();
	});
	// 분류선택 조회 enter
	$("input[name=clsSearchVal]").bind("keydown", function(event) {
		// 엔터키인 경우
		if (event.which == 13) {
			doClsSearch();
			return false;
		}
	});
	//검색주기 변경 이벤트
	$("form[name=searchForm]").find("select[name=dtacycleCd]").bind("change", function(event) {
		selectWrttimeVal($("form[name=searchForm"), $(this).val());
	});
	// 주제별/명칭별 탭 이벤트
	$(".boxTab .tab a").each(function(index, element) {
		$(this).bind("click", function(event) {
			$(".boxTab .tab a").removeClass("on");
			$(this).addClass("on");
			// 명칭별 검색 키워드 div 표시
			var gubun = $(this).attr("data-gubun");

			var wSizeHeight = $('.wide .easySearch .treeBox.size2').height();
			var bSizeHeight = $('.easySearch .treeBox.size2').height();
			var treeHeight = $('#treeStatData').height();
			
			//tabs의 크기에 따라 DIV크기를 조절한다.
			var tabsHeight = $('#tabs').height();
			
			var resultHeight = tabsHeight - 214;
			$("#hdnKeywordVal").val("");	//키워드 검색값 초기화
			
			if (gubun == "NAME") {
				//명칭별 검색시 검색결과창 사이즈조절때문에 클래스 변경
				$("#searchResult").removeClass("layerType").addClass("layerType2");	
				$(".leftArea .keyword").show();
				$(".leftArea .box .treeCtrl").hide(); // 트리 열기/닫기

				if ($('body').hasClass('wide')) {
					$('.wide .easySearch .treeBox.size2').css("height", resultHeight + "px");
				} else {
					$('.easySearch .treeBox.size2').css("height", resultHeight + "px");
				}
				$('#treeStatData').css("height", resultHeight + "px");

			} else {
				resultHeight += 70;
				//주제별 검색시 검색결과창 사이즈조절때문에 클래스 변경
				$("#searchResult").removeClass("layerType2").addClass("layerType");
				$(".leftArea .keyword").hide();
				$(".leftArea .box .treeCtrl").show(); // 트리 열기/닫기

				if ($('body').hasClass('wide')) {
					$('.wide .easySearch .treeBox.size2').css("height", resultHeight + "px");
				} else {
					$('.easySearch .treeBox.size2').css("height", resultHeight + "px");
				}
				$('#treeStatData').css("height", resultHeight + "px");
			}
		})
	});
	// 명칭별(키워드) 검색 자음 클릭이벤트
	$(".leftArea .keyword li").each(function(index, element) {
		$(this).bind("click", function(event) {
			$("#hdnKeywordVal").val($(this).find("button").text());
			loadMainPage(true);
		});
	});
	// 명칭별(키워드) 검색 기타 클릭이벤트
	$(".leftArea .etc").bind("click", function(event) {
		$("#hdnKeywordVal").val($(this).find("button").text());
		loadMainPage(true);
	});
	// 모바일 통계주제 선택
	$("#mbSubject").change(function() {
		loadMainPage(true);
	});
	// 메인 검색결과 팝업 닫기
	$("#searchResultClose").bind("click", function(event) {
		$("#sId").val(""); // 통계표 ID
		$("#stat_title").text(""); // title 초기화
		$("#searchVal, #statSearchVal").val(""); // 검색값 초기화
		$("#searchResult li").remove(); // 검색한 항목 삭제
		$("#searchResult").hide();

		// 항목선택/분류선택을 초기화한다.
		$("#treeItmData").empty();
		$("#treeClsData").empty();

		// 닫기 버튼 눌렀을때 모바일 리스트 재 검색(반응형 때문에.....)
		loadMainMobileList($("#commonForm [name=page]").val());
	});
	// 통계화면 크기 컨트롤 정의 - 전체화면 및 DIV크기
	$('.fullSize button').on('click', function() {
		var wHeight = $(window).height();
		var wWidth = $(window).width();

		var header = $('#header');
		var loc = $('.contents-navigation-area');
		var tit = $('.contents-title-wrapper m-on');
		var footer = $('.footer');

		if ($('body').hasClass('wide')) {
			$('body').removeClass('wide');
			$(this).text(jsMsg09);
			header.show();
			loc.show();
			tit.show();
			footer.show();

			// 통계검색 DIV
			if($("#tabSubj").hasClass('on')){ //주제별 보기일때
				$('.easySearch .treeBox.size2').css("height", "622px");
				$('#treeStatData').css("height", "622px");
			}else{ //명칭별 보기일때
				$('.easySearch .treeBox.size2').css("height", "596px");
				$('#treeStatData').css("height", "596px");
			}
			$('.easySearch .rightArea .searchCtrl').css("height", "678px");

			if ($('#clsTitle').attr('style') == "display: block;"
					|| $('#clsTitle').attr('style') == undefined) {
				$('.lSide .treeBox.size3').css("height", "259px");
				$('#treeItmData').css("height", "259px");
				$('#treeClsData').css("height", "259px");
			} else {
				$('.lSide .treeBox.size3').css("height", "622px");
				$('#treeItmData').css("height", "622px");
			}	

			remarkInit();
			
		} else {
			$('body').addClass('wide');
			$('.container.hide-pc-lnb').css("max-width", "100%");
			
			$(this).text(jsMsg10);
			header.hide();
			loc.hide();
			tit.hide();
			footer.hide();

			// 통계검색 DIV
			if($("#tabSubj").hasClass('on')){ //주제별 보기일때
				$('.wide .easySearch .treeBox.size2').css("height", (wHeight - 184) + "px");
				$('#treeStatData').css("height", (wHeight - 184) + "px");
			}else{ //명칭별 보기일때
				$('.wide .easySearch .treeBox.size2').css("height", (wHeight - 212) + "px");
				$('#treeStatData').css("height", (wHeight - 212) + "px");
			}
			$('.wide .easySearch .rightArea .searchCtrl').css("height", (wHeight - 129) + "px");

			if ($('#clsTitle').attr('style') == "display: block;" || $('#clsTitle').attr('style') == undefined) {
				$('.wide .lSide .treeBox.size3').css("height", (wHeight / 2 - 144) + "px");
				$('#treeItmData').css("height", (wHeight / 2 - 144) + "px");
				$('#treeClsData').css("height", (wHeight / 2 - 144) + "px");
			} else {
				$('.wide .lSide .treeBox.size3').css("height", (wHeight - 185) + "px");
				$('#treeItmData').css("height", (wHeight - 185) + "px");
			}
			
			remarkInit();
		}
		
	});
	
	$(".btn-layerpopup-close02").on("click", function() {
		$("body").addClass("remove-body");
		$(".layerpopup-stat-wrapper").hide();
	});
	
}

/**
 * 탭 추가후 탭 안에 컨트롤 이벤트 생성
 */
function setTabButton() {
	var objTab = getTabShowObj();// 탭이 open된 객체가져옴
	var formObj = objTab.find("form[name=statsEasy-mst-form]");

	// 메타데이터 열기 버튼
	formObj.find("button[name=metaData]").bind("click", function(event) {

		if (formObj.find($(".metaData")).is(":hidden")) {
			formObj.find($(".metaData")).slideDown();
			//메타데이터 확인 로그 남김
			insertStatLogs("STAT", {
				statblId: formObj.find("input[name=statblId]").val(),
				statId: formObj.find("input[name=statId]").val()
			});
		} else {
			formObj.find($(".metaData")).slideUp();
		}
	});
	// 조회 버튼
	formObj.find("button[name=easySearch]").bind("click", function(event) {
		var sheetNm = formObj.find($(".grid.statEasySheet")).attr('id');
		sheetNm = sheetNm.replace("DIV_", "");
		if (searchValidation(formObj)) {
			var statblId = formObj.find("input[name=statblId]").val();
			treeChkApply("itm"+statblId, "chkItms");	//항목
			treeChkApply("cls"+statblId, "chkClss");	//분류
			treeChkApply("dvs"+statblId, "dtadvsVal");	//증감분석 트리 현재 상태대로 다시 읽음			
			reCreateSheet();							//통계 시트 새로조회
		}

	});
	// 모바일 목록 버튼
	formObj.find("button[name=easyClose]").bind("click", function(event) {
		location.href = com.wise.help.url("/portal/stat/easyStatPage.do");
	});
	// 모바일 목록 버튼[영문]
	formObj.find("button[name=easyEngClose]").bind("click", function(event) {
		location.href = com.wise.help.url("/portal/stat/easyStatEngPage.do");
	});
	// Shee & Chart tab
	formObj.find($('.tabSt li')).on('click', function() {
		var id = $(this).find('a').attr('href');

		formObj.find($('.tabSt li')).removeClass('on');
		$(this).addClass('on');

		if (id == "#sheetTab") {
			formObj.find($(".tabCont.sheetTab")).show();
			formObj.find($(".tabCont.chartTab")).hide();
			//remarkInit();
		} else {
			formObj.find($(".tabCont.sheetTab")).hide();
			formObj.find($(".tabCont.chartTab")).show();

			formObj.find("select[name=chartChange] > option[value='']").attr("selected", "true");
			formObj.find("div[class=dropdown-content]").hide();
			//loadChart();
		}

		remarkInit();

		return false;
	});
	// 주석 열기 버튼
	formObj.find($('.remarkDv .btn')).on('click', function() {
		var remark = formObj.find($('.remarkDv .remark'));
		var remarkH = formObj.find($('.remarkDv .remark')).outerHeight();
		var obj = formObj.find($(".tabCont.sheetTab")).is(':hidden') ? formObj.find($(".tabCont.chartTab")).find($('.chart')) : formObj.find($(".tabCont.sheetTab")).find($('.grid'));
		var pat = formObj.find($(".tabCont.sheetTab")).is(':hidden') ? formObj.find($('.chartarea')): formObj.find($('.sheetarea'));
		if (remark.is(':hidden')) {
			// remarkOn(obj, pat);
			gridH = obj.outerHeight();
			remark.slideDown(10);//0.01
			formObj.find($('.remarkDv .btn')).addClass('on');
			pat.animate({
				'padding-bottom' : remarkH
			});
			obj.animate({
				height : gridH - remarkH
			});
			
			// 20180508/김정호 - 주석 DIV 창으로 포커스 이동
			formObj.find('.remarkDv .remark').attr("tabindex", -1).focus(); 
		} else {
			// remarkOff(obj, pat);
			remark.slideUp(10);//0.01
			formObj.find($('.remarkDv .btn')).removeClass('on');
			pat.animate({
				'padding-bottom' : 0
			});
			obj.animate({
				height : gridH
			});
		}
		setTimeout(function() {
			//loadChart()
		}, 500);
	});
	// 검색주기 선택
	formObj.find($('.viewBx .searchBx .cellbox .cell')).find("select[name=dtacycleCd]").change(function() {
		selectWrttimeVal(formObj, $(this).val());
	});
	// 항목선택 버튼
	formObj.find("button[name=callPopItm]").bind("click", function(event) {
		formObj.find($(".layerPopup.itmPop")).show();
		formObj.find($(".layerPopup.itmPop .PschBar input")).focus();	// 2018.04.24 김정호 - 레이어 팝업 오픈시 검색창에 focus를 준다.
	});
	// 분류선택 버튼
	formObj.find("button[name=callPopCls]").bind("click", function(event) {
		formObj.find($(".layerPopup.clsPop")).show();
		formObj.find($(".layerPopup.clsPop .PschBar input")).focus();	// 2018.04.24 김정호 - 레이어 팝업 오픈시 검색창에 focus를 준다.
	});
	// 증감분석 버튼
	formObj.find("button[name=callPopDvs]").bind("click", function(event) {
		formObj.find($(".layerPopup.dvsPop")).show();
		formObj.find($(".layerPopup.dvsPop .PschBar input")).focus();	// 2018.04.24 김정호 - 레이어 팝업 오픈시 검색창에 focus를 준다.
	});
	// 보기옵션선택 버튼
	formObj.find("button[name=callPopOpt]").bind("click", function(event) {
		formObj.find($(".layerPopup.optPop")).show();
		formObj.find($(".layerPopup.optPop .list1 li input:eq(0)")).focus();	// 2018.04.24 김정호 - 레이어 팝업 오픈시 첫번째 radio에 focus를 준다.
	});
	// 항목/분류/증감분석/피봇설정 DIV 팝업 X버튼
	formObj.find(".layerPopup .popArea .close").bind("click", function(event) {
		var closeNm = $(this).attr("name").substring(0, 3);
		closeNm = initCap(closeNm);
		formObj.find($(".layerPopup.itmPop")).hide();
		formObj.find($(".layerPopup.clsPop")).hide();
		formObj.find($(".layerPopup.optPop")).hide();
		formObj.find($(".layerPopup.dvsPop")).hide();
		formObj.find("button[name=callPop"+closeNm+"]").focus();	// 2018.04.24 김정호 - 레이어 팝업 닫을경우 레이어 버튼에 포커스를 준다.
	});
	// 항목설정 팝업 닫기버튼
	formObj.find("a[name=itmClose]").bind("click", function(event) {
		formObj.find($(".layerPopup.itmPop")).hide();
		formObj.find("button[name=callPopItm]").focus();	// 2018.04.24 김정호 - 레이어 팝업 닫을경우 레이어 버튼에 포커스를 준다.
	});
	// 분류설정 팝업 닫기버튼
	formObj.find("a[name=clsClose]").bind("click", function(event) {
		formObj.find($(".layerPopup.clsPop")).hide();
		formObj.find("button[name=callPopCls]").focus();	// 2018.04.24 김정호 - 레이어 팝업 닫을경우 레이어 버튼에 포커스를 준다.
	});
	// 증감분석 팝업 닫기버튼
	formObj.find("a[name=dvsClose]").bind("click", function(event) {
		formObj.find($(".layerPopup.dvsPop")).hide();
		formObj.find("button[name=callPopDvs]").focus();	// 2018.04.24 김정호 - 레이어 팝업 닫을경우 레이어 버튼에 포커스를 준다.
	});
	// 피봇설정 팝업 닫기버튼
	formObj.find("a[name=optClose], a[name=optPopClose]").bind("click", function(event) {
		formObj.find($(".layerPopup.optPop")).hide();
		formObj.find("button[name=callPopOpt]").focus();	// 2018.04.24 김정호 - 레이어 팝업 닫을경우 레이어 버튼에 포커스를 준다.
	});
	// 통계스크랩 레이어 팝업(로그인 했을경우)
	formObj.find("button[name=btnUsrTbl]").bind("click", function(event) {
		if ( formObj.find(".txtHistory").css("display") != "none" ) {
			jAlert(alertMsg01);
			return false;
		}
		formObj.find($(".layerPopup.usrTblPop")).show();
		formObj.find("input[name=usrTblStatblNm]").focus();
	});
	formObj.find("button[name=btnUsrTbl]").bind("keydown", function(event) {
		if (event.which == 13) {
			if ( formObj.find(".txtHistory").css("display") != "none" ) {
				jAlert(alertMsg01);
				return false;
			}
			formObj.find($(".layerPopup.usrTblPop")).show();
			formObj.find("input[name=usrTblStatblNm]").focus();
		}
	});
	
	// 통계이력 레이어 팝업
	formObj.find("button[name=btnStatHist]").bind("click", function(event) {
		getStatHistDtacycle(formObj.find("select[name=dtacycleCd]").val());
	});
	// 통계스크랩 레이어 팝업(로그인 안했을 경우)
	formObj.find("button[name=btnUsrTblLogin]").bind("click", function(event) {
		jConfirm("로그인 후 이용 가능합니다.\n\n로그인 하시겠습니까?", function() {
			location.href = com.wise.help.url("/portal/user/authorizePage.do");
		});
	});
	formObj.find("button[name=btnUsrTblLogin]").bind("keydown", function(event) {
        if (event.which == 13) {
        	jConfirm("로그인 후 이용 가능합니다.\n\n로그인 하시겠습니까?", function() {
    			location.href = com.wise.help.url("/portal/user/authorizePage.do");
    		});
        }
    });
	
	// 통계스크랩 신규저장
	formObj.find("a[name=usrTblApply]").bind("click", function(event) {
		doUsrTblApply();
		return false;
	});
	
	// 통계스크랩 수정
	formObj.find("a[name=usrTblUpd]").bind("click", function(event) {
		doUsrTblUpd();
	});
	formObj.find("a[name=usrTblUpd]").bind("keydown", function(event) {
		if (event.which == 13) {
			doUsrTblUpd();
			return false;
		}
	});
	// 통계스크랩 닫기
	formObj.find("a[name=usrTblClose], a[name=usrTblPopClose]").bind("click", function(event) {
		formObj.find($(".layerPopup.usrTblPop")).hide();
		formObj.find("button[name=btnUsrTbl]").attr("tabindex", -1).focus();
		return false;
	});
	formObj.find("a[name=usrTblClose], a[name=usrTblPopClose]").bind("keydown", function(event) {
		if (event.which == 13) {
			formObj.find($(".layerPopup.usrTblPop")).hide();
			formObj.find("button[name=btnUsrTbl]").attr("tabindex", -1).focus();
			return false;
		}
	});
	
	// 통계이력 닫기
	formObj.find("a[name=statHistPopClose]").bind("click", function(event) {
		formObj.find($(".layerPopup.statHistPop")).hide();
	});
	// 다운로드[XLS] 버튼
	formObj.find("button[name=downXLS]").bind("click", function(event) {
		PortalDownFile("EXCEL", "excel");
	});
	// 다운로드[CSV] 버튼
	formObj.find("button[name=downCSV]").bind("click", function(event) {
		PortalDownFile("CSV", "csv");
	});
	// 다운로드[JSON] 버튼
	formObj.find("button[name=downJSON]").bind("click", function(event) {
		PortalDownFile("JSON", "json");
	});
	// 다운로드[XML] 버튼
	formObj.find("button[name=downXML]").bind("click", function(event) {
		PortalDownFile("XML", "xml");
	});
	// 다운로드[TXT] 버튼
	formObj.find("button[name=downTXT]").bind("click", function(event) {
		PortalDownFile("TXT", "txt");
	});
	// 차트 범례 버튼
	formObj.find("button[name=remarkShow]").bind("click", function(event) {
		if (formObj.find($('.chart')).hasClass('wide')) {
			formObj.find("input[name=chartLegend]").val("Y");
			formObj.find($('.chart')).removeClass('wide');
			for (i = 0; i < hightChart.series.length; i++) {
				hightChart.series[i].update({
					showInLegend : true
				});
			}
		} else {
			formObj.find("input[name=chartLegend]").val("N");
			$('.chart').addClass('wide');
			for (i = 0; i < hightChart.series.length; i++) {
				hightChart.series[i].update({
					showInLegend : false
				});
			}
		}
	});
	// 차트 곡선
	formObj.find("button[name=chartSpline]").bind(
			"click",
			function(event) {
				statChartCreate("spline");
				formObj.find("input[name=chartType]").val("spline");
				// statChartCreate("line"); //꺾은선
				formObj.find("select[name=chartChange]").val("");
			});
	// 누적영역
	formObj.find("button[name=chartArea]").bind(
			"click",
			function(event) {
				statChartCreate("area");
				formObj.find("input[name=chartType]").val("area");
				formObj.find("select[name=chartChange]").val("");
			});
	// 차트 막대형
	formObj.find("button[name=chartHbar]").bind(
			"click",
			function(event) {
				statChartCreate("column");
				formObj.find("input[name=chartType]").val("column");
				formObj.find("select[name=chartChange]").val("");
			});
	// 차트 누적막대형
	formObj.find("button[name=chartAccHbar]").bind(
			"click",
			function(event) {
				statChartCreate("accolumn");
				formObj.find("input[name=chartType]").val("accolumn");
				formObj.find("select[name=chartChange]").val("");
			});
	// 차트 가로막대형
	formObj.find("button[name=chartWbar]").bind(
			"click",
			function(event) {
				statChartCreate("bar");
				formObj.find("input[name=chartType]").val("bar");
				formObj.find("select[name=chartChange]").val("");
			});
	// 차트 가로누적막대형
	formObj.find("button[name=chartAccWbar]").bind(
			"click",
			function(event) {
				statChartCreate("acbar");
				formObj.find("input[name=chartType]").val("acbar");
				formObj.find("select[name=chartChange]").val("");
			});
	// 3D 차트 보기(onchange)
	formObj.find("select[name=chartChange]").change(function(event) {
		var chartGb = $(this).val();
		if (chartGb != "") {
			statChartCreate(chartGb);
			formObj.find("input[name=chartType]").val(chartGb);
		}
	});

	// 차트 다운로드 버튼
	formObj.find("button[name=chartDownload]").bind("click", function(event) {
		if (!formObj.find($('.chart')).hasClass('down')) {
			formObj.find($('.chart')).addClass('down');
			formObj.find($('.dropdown-content')).show();
		} else {
			formObj.find($('.chart')).removeClass('down');
			formObj.find($('.dropdown-content')).hide();
		}
	});

	// 차트 다운로드 버튼 -> chartPrint
	formObj.find("a[name=chartPrint]").bind("click", function(event) {
		hightChart.print();
	});
	// 차트 다운로드 버튼 -> chartPng
	formObj.find("a[name=chartPng]").bind("click", function(event) {
		if ( formObj.find("select[name=chartChange]").val() == "pie" ) {
			jAlert("No Service.");
			return false;
		}
		hightChart.exportChart({
			type : 'image/png',
			filename : 'nasna-png'
		});
	});
	// 차트 다운로드 버튼 -> chartJpeg
	formObj.find("a[name=chartJpeg]").bind("click", function(event) {
		if ( formObj.find("select[name=chartChange]").val() == "pie" ) {
			jAlert("No Service.");
			return false;
		}
		hightChart.exportChart({
			type : 'image/jpeg',
			filename : 'nasna-jpeg'
		});
	});
	// 차트 다운로드 버튼 -> chartPdf
	formObj.find("a[name=chartPdf]").bind("click", function(event) {
		if ( formObj.find("select[name=chartChange]").val() == "pie" ) {
			jAlert("No Service.");
			return false;
		}
		hightChart.exportChart({
			type : 'application/pdf',
			filename : 'nasna-pdf'
		});
	});
	// 차트 다운로드 버튼 -> chartSvg
	formObj.find("a[name=chartSvg]").bind("click", function(event) {
		if ( formObj.find("select[name=chartChange]").val() == "pie" ) {
			jAlert("No Service.");
			return false;
		}
		hightChart.exportChart({
			type : 'image/svg+xml',
			filename : 'nasna-svg'
		});
	});
	
	//분석기능(모바일)
	formObj.find(".schBtnTgl").bind("click", function() {
		var elem = formObj.find('.schBtnTglDv');
		if (!$(this).hasClass('on')) {
			$(this).addClass('on');
			elem.show();
		} else {
			$(this).removeClass('on');
			elem.hide();
		}
	});

}

// //////////////////////////////////////////////////////////////////////////////
// 모바일 화면 처리 함수
// //////////////////////////////////////////////////////////////////////////////
/**
 * 모바일용 통계주제 세팅
 */
function afterMobileTopCate(data) {
	if (data.length > 0) {
		$("#mbSubject").empty();
		$("#mbSubject").append("<option value=\"\">Total</option>");
		$.each(data, function(key, value) {
			$("#mbSubject").append("<option value=" + value.cateId + ">"+ value.cateNm + "</option>");
		});
	}
}
////////////////////////////////////////////////////////////////////////////////
//Validation 함수
////////////////////////////////////////////////////////////////////////////////
function searchValidation(formObj) {
	//트리 체크관련 validation
	var statblId = formObj.find("input[name=statblId]").val();
	if ( !isTreeChk("itm" + statblId) ) {
		jAlert(alertMsg03);
		return false;
	}
	
	var clsDataLen = $("#treeClsData").find("li").length;
	if(clsDataLen > 0){
		if ( !isTreeChk("cls" + statblId) ) {	
			jAlert(alertMsg04);
			return false;
		}
	}
	
	if ( !isTreeChk("dvs" + statblId) ) {	
		jAlert(alertMsg05);
		return false;
	}
	
	if (formObj.find("input:radio[name=wrttimeType]:checked").val() == "L") {
		// 주기가 최근시점인 경우 필수값 체크
		if (com.wise.util.isNull(formObj.find("input[name=wrttimeLastestVal]").val())
				|| !com.wise.util.isNumeric(formObj.find("input[name=wrttimeLastestVal]").val())) {
			jAlert(alertMsg06);
			formObj.find("input[name=wrttimeLastestVal]").val("").focus();
			return false;
		}
	}
	if (formObj.find("input:radio[name=viewLocOpt]:checked").val() == "T") {
		// 표로 보기 일 경우
		if (formObj.find("select[name=dtacycleCd]").val() == "YY") {
			jAlert(alertMsg07);
			formObj.find("select[name=dtacycleCd]:checked").focus();
			return false;
		}
	}
	
	// 조회 검색 셀 갯수 제한 validation
	var searchLimitChk = validSearchLimit({obj : formObj});
	if ( !searchLimitChk ) {
		return false;
	}
	return true;
}


/**
 * 조회 검색 셀 갯수 제한 validation 하는 함수이다.
 * @param param
 * 		- type : 조회 타입, 0:탭 화면 조회, 1:시작화면 조회
 * 		- obj : form 오브젝트
 *		- itmTreeNm : 항목 트리 id
 *		- clsTreeNm : 분류 트리 id
 *		- dvsTreeNm : 증감분석 트리 id
 * @returns {Boolean}
 */
function validSearchLimit(param) {
	if (param.obj == null) return false;
	
	param.type 		= param.type 		|| 0;
	param.itmTreeNm = param.itmDataNm 	|| "itm";
	param.clsTreeNm = param.clsDataNm 	|| "cls";
	param.dvsTreeNm = param.dvsDataNm 	|| "dvs";
	
	var itmDataLen, clsDataLen, dvsDataLen = 1;
	if ( param.type > 0 ) {
		itmDataLen = getCheckedTreeLen(param.itmTreeNm) > 0 ? getCheckedTreeLen(param.itmTreeNm) : 1;
		clsDataLen = getCheckedTreeLen(param.clsTreeNm) > 0 ? getCheckedTreeLen(param.clsTreeNm) : 1;
	} else {
		var statblId = param.obj.find("input[name=statblId]").val();
		itmDataLen = getCheckedTreeLen(param.itmTreeNm+statblId) > 0 ? getCheckedTreeLen(param.itmTreeNm+statblId) : 1;
		clsDataLen = getCheckedTreeLen(param.clsTreeNm+statblId) > 0 ? getCheckedTreeLen(param.clsTreeNm+statblId) : 1;
		dvsDataLen = getCheckedTreeLen(param.dvsTreeNm+statblId) > 0 ? getCheckedTreeLen(param.dvsTreeNm+statblId) : 1;
	}

	// 체크된 트리 갯수를 가져온다.
	function getCheckedTreeLen(treeId) {
		var dataChkedLen = 0;
		var liCnt = $("#"+treeId).find("li").length;
		if(liCnt > 1){
			dataChkedLen = $("#"+treeId).dynatree("getSelectedNodes").length;
		}
		return dataChkedLen;
	}
	
	// 체크된 트리 데이터 번호를 가져온다.
	function getCheckedTreeDatano(treeId) {
		var data = new Array();
		
		if ( getCheckedTreeLen(treeId) > 0 ) {
			var chkNodes = $.fn.zTree.getZTreeObj(treeId).getCheckedNodes();
			for ( d in chkNodes ) {
				data.push(String(chkNodes[d].datano));
			}
		} 
		return data;
	}
	
	// 검색주기 갯수를 구한다.
	function dtacycleCnt() {
		var d = 0;
		switch ( param.obj.find("select[name=dtacycleCd]").val() ) {
			case "YY":
				d = 1;
				break;
			case "QY":
				d = 2;
				break;
			case "HY":
				d = 4;
				break;
			case "MM":
				d = 12;
				break;
			}
		return d;
	};
	
	// 검색기간(시계열 갯수)를 구한다.
	function wrttimeCnt() {
		var d = 0;
		var type = param.obj.find("input:radio[name=wrttimeType]:checked").val();
		if ( type == "B" ) {
			// 기간 검색일 경우
			iYear = Number(param.obj.find("select[name=wrttimeEndYear]").val()) - Number(param.obj.find("select[name=wrttimeStartYear]").val()) + 1;	//종료년 - 시작년 + 1(자기자신은 +1)
			iQt = 0;
			if ( dtacycleCnt() > 1 ) {
				// 검색주기가 년도 이상부터 쿼터 존재함.
				iQt = Number(param.obj.find("select[name=wrttimeEndQt]").val()) - Number(param.obj.find("select[name=wrttimeStartQt]").val()) + 1;
			}
			d = iYear * iQt;
		} else if ( type == "L" ) {
			// 최근시점인 경우
			d = Number(param.obj.find("input[name=wrttimeLastestVal]").val());
		}
		return d;
	};
	
	// Object를 queryString으로 변환한다.
	function objParam2Serialize(objParam) {
		var params = Object.keys(objParam).map(function(key) {
			var d = "";
			if ( decodeURIComponent(objParam[key]).indexOf(",") > -1 ) {
				// 분류, 항목은 array로 되어있어서.
				var split = decodeURIComponent(objParam[key]).split(",");
				for ( var i=0; i < split.length; i++ ) {
					d += decodeURIComponent(key) + "=" + split[i];
					if ( i < split.length-1 ) {
						d += "&";
					}
				}
			} else {
				d = decodeURIComponent(key) + '=' + decodeURIComponent(objParam[key]); 
			}
		    return d;
		}).join('&');
		return params;
	}
	
	// 검색주기 * 검색기간 * 항목 * 분류 * 증감분석 트리 체크 갯수
	var cellCnt = wrttimeCnt()  
	   * itmDataLen * clsDataLen * dvsDataLen;
	
	// 다운로드 건수 제한
	if ( cellCnt > DOWN_LIMIT_CNT ) {
		if ( param.type> 0 ) {
		}else{
			var objTab = getTabShowObj();
			var formObj = objTab.find("form[name=statsEasy-mst-form]");
			// 레이어 숨김
			formObj.find($(".layerPopup.itmPop")).hide();
			formObj.find($(".layerPopup.clsPop")).hide();
			formObj.find($(".layerPopup.dvsPop")).hide();
		}
		
		jAlert("More than " +commaWon(String(DOWN_LIMIT_CNT))+ " downloads causes delayed inquiry speed and server overload and prevents further downloads.");
		return false;
		
	// 조회 건수 제한
	} else if ( cellCnt > SEARCH_LIMIT_CNT ) {	

		if ( param.type> 0 ) {
		}else{
			var objTab = getTabShowObj();
			var formObj = objTab.find("form[name=statsEasy-mst-form]");
			// 레이어 숨김
			formObj.find($(".layerPopup.itmPop")).hide();
			formObj.find($(".layerPopup.clsPop")).hide();
			formObj.find($(".layerPopup.dvsPop")).hide();
		}
		
		$("#confDown").show();
		$("#confAction").hide();
		$("#confirmMsg").text("More than " +commaWon(String(SEARCH_LIMIT_CNT))+ " downloads causes delayed inquiry speed and server overload and prevents further downloads.");
		$(".layerpopup-stat-wrapper").hide();
		$("#confirm-box").show();
		
		$("#confDown").bind("click", function(event) {
			$("#confirm-box").hide();
			
			var params = "";
			var objTab = getTabShowObj();
			
			// 메인에서 조회시
			if ( param.type> 0 ) {
				var formObj = objTab.find("form[name=searchForm]");
				var objParam = formObj.serializeObject();
				objParam.statblId = $("#sId").val();
				objParam.deviceType = "P";
				objParam.firParam = "";
				objParam.wrttimeOrder = objParam.searchSort;
				objParam.dtadvsVal = "OD";
				objParam.viewLocOpt = "B";
				objParam.chkItms = getCheckedTreeDatano("treeItmData");
				
				if ( getCheckedTreeDatano("treeClsData").length > 0 ) {
					// 분류가 없는경우 null값이 아닌 아에 파라미터가 안넘어가야 하네요.
					objParam.chkClss = getCheckedTreeDatano("treeClsData");	
				}

				// Object를 queryString으로 변환한다.
				params = objParam2Serialize(objParam)+"&langGb=ENG";
				
			// 탭에서 조회시
			} else {
				var formObj = objTab.find("form[name=statsEasy-mst-form]");
				var objParam = formObj.serializeObject();
				var statblId = param.obj.find("input[name=statblId]").val();
				objParam.chkItms = getCheckedTreeDatano(param.itmTreeNm+statblId);
				if ( getCheckedTreeDatano(param.clsTreeNm+statblId).length > 0 ) {
					// 분류가 없는경우 null값이 아닌 아에 파라미터가 안넘어가야 하네요.
					objParam.chkClss = getCheckedTreeDatano(param.clsTreeNm+statblId);	
				}
				objParam.dtadvsVal = getCheckedTreeDatano(param.dvsTreeNm+statblId);
				
				// Object를 queryString으로 변환한다.
				params = objParam2Serialize(objParam);
			}	
			
			$("#dataDown-box").show();
		    $.fileDownload(com.wise.help.url("/portal/stat/downloadStatSheetData.do"), {
		        httpMethod: "POST",
		        data: params,
		        successCallback: function(url){
		        	$("#dataDown-box").hide();
		        },
		        failCallback: function(responseHtml,url){
		        	$("#dataDown-box").hide();
		        }
		    });
		});
		
		return false;
	} else {
		return true;
	}

}

////////////////////////////////////////////////////////////////////////////////
//숫자만 입력 함수 > jAlert적용을 위해 별도로 추가
////////////////////////////////////////////////////////////////////////////////
function statComInputNumObj(obj) {
	strb = obj.val().toString();
	if(strb == "0"){
		jAlert(alertMsg08);
		obj.val("5"); //검색기간 Default 5
	}
	strb = strb.replace(/[^0-9]/g, 'ㄱ');
	if(/ㄱ/i.test(strb)){
		jAlert(alertMsg09); 
		strb = strb.replace(/[^0-9]/g, ''); 
		obj.val(strb);  
	} 
}

////////////////////////////////////////////////////////////////////////////////
//Get파라메터 변수값 확인 searchVal
////////////////////////////////////////////////////////////////////////////////
function searchGetVal(){ 
	var name = "searchVal";

	var search = decodeURIComponent($(location).attr('search'));
	var results = new RegExp('[\?&amp;]' + name + '=([^&amp;#]*)').exec(com.wise.help.XSSfilter(search));
	
	if(results != null){
		$("#statSearchVal").val(results[1]);
		loadMainPage(true);
	}	
}
