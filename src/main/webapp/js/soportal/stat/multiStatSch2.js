/*
 * @(#)multiStatSch.js 1.0 2017/11/30
 * 
 * COPYRIGHT (C) 2013 WISEITECH CO., LTD. ALL RIGHTS RESERVED.
 */

/**
 * 복수통계 관련 스크립트 파일이다.
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

var centerDivW = 0;
var centerDivH = 0;
var centerGrpH = 0;
var centerItmH = 0;
var centerClsH = 0;
var itmData = "";
var clsData = "";
var grpData = "";
var gridH;
var nodeList = [];
var nodesItm = null;
var nodesCls = null;
var nodesGrp = null;

var SEARCH_LIMIT_CNT = 20000;		// 셀 검색 제한 갯수
var DOWN_LIMIT_CNT = 200000;		// 셀 다운로드 제한 갯수

var SEL_DTACYCLE_CD = "";			// 복수통계 항목 추가시 처음 선택된 주기코드
var confirmAction = "";
////////////////////////////////////////////////////////////////////////////////
//복수통계용 글로벌 변수
////////////////////////////////////////////////////////////////////////////////
var itmCnt = 0;		//항목 선택 갯수
var clsCnt = 0;		//분류 선택 갯수
var grpCnt = 0;		//그룹 선택 갯수
var mixTitle = "";		//선택통계 명칭
var mixStatId = ""; 	//선택통계표 ID
var gridArr = [];
var sheetCols = [];
var inData = new Object();
var baseDatas = [];
////////////////////////////////////////////////////////////////////////////////

// 모바일 메인 리스트 템플릿(검색결과도 같이 사용)
var mbListTemplate = {
	row : "<li>"
			+ "<a href=\"javascript:;\" name=\"\"><strong class=\"tit\"></strong></a>"
			+ "</li>",
	none : "<li><strong class=\"tit\">"+jsMsg01+"</strong></li>"
}
// //////////////////////////////////////////////////////////////////////////////
// Script Init Loading...
// //////////////////////////////////////////////////////////////////////////////
$(function() {
	/* 컴포넌트를 초기화한다. */
	initComp();

	/* 통계화면 컨트롤 정의(이벤트) */
	eventControl();

	/* 복수통계 시계열선택을 위한 컨트롤 정의(이벤트) */
	mixControl();
	
	$(window).resize(function() {
		remarkInit();
		
		// 복수통계의 > 선택된 시계열 항목 영역
		multiSelDivInit();
	});
	
	multiSelDivInit();
	
	/* 시계열항목 테이블 헤더 고정 */
    $('#mixBody').scroll(function () {
        var xPoint = $('#mixBody').scrollLeft();
        $('#mixHeader').scrollLeft(xPoint);
    });

    $('#mixBodyM').scroll(function () {
        var xPoint = $('#mixBodyM').scrollLeft();
        $('#mixHeaderM').scrollLeft(xPoint);
    });
    
    mixIBSheet();
    
	// GNB메뉴 바인딩한다.
	menuOn(1, 3);
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
	
	/* 화면 로드시 파라미터 값으로 전달받은경우 바로 관련 탭 연다. */
	if (!com.wise.util.isBlank($("#firParam").val())) {

		//복수통계는 넘어온  firParam의 값에서 시계열 항목값을 우선 Setting한다.
		setDirectMulti();
		
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
	
	var searchWord = $("#statSearchVal").val();
    
	searchWord = htmlTagFilter(searchWord);
	if(searchWord == false){
		$("#statSearchVal").val("");
		searchWord = "";
	}
	
	$("#searchVal").val(searchWord);
	
	/* 그룹선택/항목선택/분류선택을 초기화한다. */
	$("#treeGrpData").empty();
	$("#treeItmData").empty();
	$("#treeClsData").empty();

	/* 검색하였거나, PC이거나, 검색어가 있는경우 */
	if (searchFlag && !isMobile && ( !gfn_isNull($("#searchVal").val()) || !gfn_isNull($("#hdnKeywordVal").val()) ) ) {
		// PC에서 조회한 경우
		loadMainMobileList($("#commonForm [name=page]").val());
		loadMainSearchList();
	} else {
		loadMainMobileList($("#commonForm [name=page]").val());
		//2018.07.04 모바일 통계주제별 통계표 조회 추가
		var gubun = $("#statGb").val() == "" ? "SUBJ" : $("#statGb").val();
		loadMainTreeList(gubun);
	}
}
/**
 * PC 메인 통계표 목록 트리 리스트
 */
function loadMainTreeList(gubun) {
	
	$("#statGb").val(gubun);
	$("#multiGb").val("MULTI");
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
	}
}
/**
 * 모바일 메인 통계표 목록 리스트 조회
 */
function loadMainMobileList(page) {
	$("#multiGb").val("MULTI");
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
function loadMainMobileTopCate(gubun) {
	$("#statGb").val(gubun); //2018.07.04 모바일 통계주제별 통계표 조회 추가
	doSearch({
		url : "/portal/stat/statCateTopList.do",
		before : function() {
			return {statblId : $("#sId").val(),langGb : $("#langGb").val(), statGb : $("#statGb").val()}
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
		langGb : $("#langGb").val(), 
		multiGb : $("#multiGb").val(),
		statGb : $("#statGb").val() //2018.07.04 모바일 통계주제별 통계표 조회 추가
	};
	return data;
}
/**
 * 메인 검색결과 전처리
 */
function beforeSearchList(options) {
	var searchVal = $("#searchVal").val();
	searchVal = searchVal.toUpperCase();
	var data = {
		statblId : $("#sId").val(),
		searchVal : searchVal,
		searchGubun : $("#searchGubun").val(),
		searchKeywordVal : $("#hdnKeywordVal").val(),
		langGb : $("#langGb").val(),
		sortGb : $("#sortGb").val(),
		multiGb : $("#multiGb").val(),
		statGb : $("#statGb").val() //2018.07.04 모바일 통계주제별 통계표 조회 추가
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
		
		// 2018.06.07 - 결과값에 검색어 CSS 적용
	    var statSearchVal = $('#statSearchVal').val();
		var statSearchVals = statSearchVal.split(" ");
		
	    $("#" + id + " ul li a strong").each(function () {
	    	for(var i in statSearchVals) {
	    		if (statSearchVals[i] !=""){
		    		var regex = new RegExp(statSearchVals[i],'gi');
		    		var statblNm = $(this).text();
		    		statblNm = (statblNm.toUpperCase()).match(statSearchVals[i].toUpperCase());
		    		$(this).html( $(this).html().replace(regex, "<span class='text-red'>"+statblNm+"</span>") );
	    		}
	    	}
	    });
	    
	    // 2018.04.24 김정호 - 검색창 팝업시 첫번째 검색결과에 focus를 준다.
		$("#" + id + " ul li:eq(0) a").focus();

		// 모바일 통계선택 이벤트(row단위로 이벤트 준다)
		$(".leftArea #" + id + " li").each(function(index, element) {
			$(this).bind("click", function(event) {
				// 2018.06.07 - 선택값에 선택 CSS 적용
				$(".leftArea #" + id + " li").each(function () {
					$(this).removeClass("stat-click");
				});
				$(this).addClass("stat-click");
				
				if (id.indexOf("search") > -1) {
					// 리스트 선택시 항목, 분류 보여준다.(PC에서)
					selStat($(this).find("a").attr('name'));
				} else {
					$("#sId").val($(this).find("a").attr('name'));
					$('#stat_title').text($(this).find("a strong").text());
					
					if ($("#statsGB").val() == "Mix") { // 모바일 화면 복수 통계 일 경우
						// 항목/분류 선택화면을 노출한다.
						$('.easySearch').addClass('complex2');
						$("#treeGrpData").empty();
						$("#treeItmData").empty();
						$("#treeClsData").empty();
						selStat($(this).find("a").attr('name'));
						
					} else {
						// 조회 검색 셀 갯수 제한 validation		
						var chkParam = {
							type : 1,
							obj : $("form[name=searchForm]"),
							grpDataNm : "treeGrpData",
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
 * 통계스크랩 신규저장
 */
function doUsrTblApply() {
	var objTab = getTabShowObj();// 탭이 open된 객체가져옴
	var formObj = objTab.find("form[name=statsEasy-mst-form]");

	doPost({
		url : "/portal/stat/insertStatMultiUserTbl.do",
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
		url : "/portal/stat/updateStatMultiUserTbl.do",
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
 * 그룹선택 조회 
 */
function doGrpSearch() {
	$("#searchGb").val("S");
	
	var searchWord = $("#grpSearchVal").val();
    
	searchWord = htmlTagFilter(searchWord);
	if(searchWord == false) {
		searchWord="";
		$("#grpSearchVal").val("");
	}
	
	searchNode("treeStatData", searchWord);
}
/**
 * 그룹선택 초기화
 */
function doGrpReset() {
	$("#searchGb").val("");
	$("#grpSearchVal").val("");
	var searchWord = $("#grpSearchVal").val();
    
	searchWord = htmlTagFilter(searchWord);
	if(searchWord == false) {
		searchWord="";
		$("#grpSearchVal").val("");
	}
	
    searchNode("treeGrpData", searchWord);
}
/**
 * 항목선택 조회 
 */
function doItmSearch() {
	$("#searchGb").val("S");
	
	var searchWord = $("#itmSearchVal").val();
    
	searchWord = htmlTagFilter(searchWord);
	if(searchWord == false) {
		searchWord="";
		$("#itmSearchVal").val("");
	}
	
    searchNode("treeItmData", searchWord);
}
/**
 * 항목선택 초기화
 */
function doItmReset() {
	$("#searchGb").val("");
	$("#itmSearchVal").val("");
	var searchWord = $("#itmSearchVal").val();
    
	searchWord = htmlTagFilter(searchWord);
	if(searchWord == false) {
		searchWord="";
		$("#itmSearchVal").val("");
	}
	
    searchNode("treeItmData", searchWord);
}
/**
 * 분류선택 조회
 */
function doClsSearch() {
	$("#searchGb").val("S");
	
	var searchWord = $("#clsSearchVal").val();
    
	searchWord = htmlTagFilter(searchWord);
	if(searchWord == false) {
		searchWord="";
		$("#clsSearchVal").val("");
	}
    
	searchNode("treeClsData", searchWord);
}
/**
 * 분류선택 초기화
 */
function doClsReset() {
	$("#searchGb").val("");
	$("#clsSearchVal").val("");
	var searchWord = $("#clsSearchVal").val();
    
	searchWord = htmlTagFilter(searchWord);
	if(searchWord == false) {
		searchWord="";
		$("#clsSearchVal").val("");
	}
	
    searchNode("treeClsData", searchWord);
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

/**
 * 차트를 로드한다.
 */
function doLoadChart() {
	var funcLoadChart = function() {
		var deferred = $.Deferred();
		try {
			loadChart();
			deferred.resolve(true);
		} catch (err) {
			deferred.reject(false);
		}
		return deferred.promise();
	};
	
	funcLoadChart().done(function(message) {
	}).always(function() {
		setTimeout(function() {
			hideLoading();
		}, 100);
	});
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

	formObj.find($(".grid")).empty(); // 화면에 Display하기전에 해당 위치의 내용을 초기화한다.

	var sheetobj = window[sheetNm];
	sheetobj.Reset(); 			// 윈도우 객체에 담은 해당 DIV객체를 초기화한다.
	setTimeout("mixSheetCreate(\""+sheetNm+"\")", 100); 	// 통계 시트 새로조회
}
/**
 * 통계 조회 탭 Sheet 생성
 * @Param sheetNm	통계표 시트명
 */
function mixSheetCreate(sheetNm) {

	var objTab = getTabShowObj();//탭이 open된 객체가져옴
	var formObj = objTab.find("form[name=statsEasy-mst-form]");
	
	createIBSheet2(document.getElementById("DIV_" + sheetNm), sheetNm, "100%", "500px");     
	
	var sheetobj = window[sheetNm];
	
	/* 통계 시트 컬럼 세팅(헤더설정) */
 	loadMixSheet(sheetNm, sheetobj);
 	
 	//시트 조회후 이벤트
 	window[sheetNm+ "_OnSearchEnd"] = sheetOnSearchEnd;		
 	
 	//파라미터로 접근 한 경우 java에서 넘어온 파라미터값으로 param 값 넘겨준다.
 	var param = formObj.serialize();
 	var params = {
 			PageParam : "ibpage",
 			Param : "onepagerow=50&" + param
 	};
 	sheetobj.SetWaitImageVisible(0);	//조회중 이미지 보이지 않게 설정
 	sheetobj.DoSearchPaging(com.wise.help.url("/portal/stat/statMultiPreviewList.do"), params);
	
 	//조회 완료 후 시트 및 차트의 사이즈 조절
 	remarkInit();
}
/**
 * 통계 시트 컬럼 세팅(헤더설정)
 * @param sheetNm	통계표 시트명
 * @param sheetobj	시트객체
 */
function loadMixSheet(sheetNm, sheetobj) {
	var objTab = getTabShowObj();//탭이 open된 객체가져옴
	var formObj = objTab.find("form[name=statsEasy-mst-form]");
	
	var gridArr = [];
	var iArr = null;
	var sheetCols = [];
	
	//파라미터로 접근 한 경우 java에서 넘어온 파라미터값으로 param 값 넘겨준다.
	var params = formObj.serializeObject();
	
  	$.ajax({
  		url: com.wise.help.url("/portal/stat/multiTblItm.do"),
	    async: false, 
	    type: 'POST', 
	    data: params,
	    dataType: 'json',
	    beforeSend: function(obj) {
	    	$("#loadingCircle").show();	//조회중 표시
	    }, // 서버 요청 전 호출 되는 함수 return false; 일 경우 요청 중단
	    success: function(data) {
	    	var text = data.data.Text;	//헤더 컬럼 text 정보
	    	var cols = data.data.Cols;	//헤더 컬럼 속성정보
	    	var cmmtRowCol = data.data.cmmtRowCol;
	    	var loadDtadvsLoc = data.data.dtadvsLoc; 
	    	for ( var i=0; i < text.length; i++) {
	    		var tdata = text[i];
	    		iArr = new Array();
	    		for ( var t in tdata ) {	
	    			iArr.push(tdata[t]);
	    		}
	    		gridArr.push({Text:iArr.join("|"), Align:"Center"} );
	    	}

	    	for ( var c in cols ) {
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
				var cfg = { SearchMode : 0, Page : 10, MouseHoverMode : 1, VScrollMode:0, SelectionRowsMode : 1, MergeSheet : 7, DataRowMerge: 1, ColPage: 20 };

				SetConfig(cfg);
				
				InitHeaders(gridArr, {Sort : 0, ColMove : 0, ColResize : 0, HeaderCheck : 0});
				InitColumns(sheetCols);
			}
				    	
	    	default_sheet(sheetobj);  
	    	portal_sheet(sheetobj);	//포털화면 시트 별도 로딩바 생성 안되도록 처리
	    	
	    	//헤더에 주석식별자 입력
	    	for ( var cmmt in cmmtRowCol ) {
	    		sheetobj.SetHtmlHeaderValue(cmmtRowCol[cmmt].row, cmmtRowCol[cmmt].col, cmmtRowCol[cmmt].cmmt);
	    	}
	    	
	    	//통계자료 행or열 숨김 처리(원자료만 있는 경우)
	    	if ( loadDtadvsLoc.LOC != "" ) {
	    		dtadvsLoc = loadDtadvsLoc
	    	}
	    	sheetobj.SetExtendLastCol(1);	// 마지막 컬럼 끝까지 늘린다.	
			// 바닥라인 삭제
			formObj.find($('.GMCountRowBottom')).closest('tr').remove();
	    	
	    }, // 요청 완료 시
	    error: function(request, status, error) {
	    	handleError(status, error);
	    }, // 요청 실패.
	    complete: function(jqXHR) {} // 요청의 실패, 성공과 상관 없이 완료 될 경우 호출
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
	
	//sheet 상단에 피봇 값에 따라 설정한 값 이미지 표시 
	showSheetPivotImg();

	// 20180508/김정호 - 조회 완료후 무조건 최상단으로 focus
	$(".gnb-area .left li:eq(0) a").attr("tabindex", -1).focus();

	hideLoading();
	
	if ( !isMobile ) {
		$("#stat-pager-sect").hide();	//PC일경우 페이져 숨김
	} else {
		$("#stat-pager-sect").show();
	}
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
		formObj.find("input[name=usrTblStatblNm]").focus();
		return null;
	}
	var params = jsonfy(formObj);
	
	params["statTitle"] = formObj.find("input[name=usrTblStatblNm]").val(); 	// 통계자료명
	params["statblExp"] = formObj.find("input[name=usrTblStatblExp]").val(); 	// 통계자료설명
	params["dtadvsVals"] = getChkedStatArrVal("dvs"); // 체크한 증감분석
	
	//복수통계는 시계열 항목을 가지고 데이터를 전달한다.
	var mixData = formObj.find($("input[name=TAB_MVAL]"));
	var mixDataValue = [];
	mixData.each(function(index, element) {
		mixDataValue.push($(this).attr('value'));
	});
	//복수통계는 별도로 묶는다.
	params["TAB_MVAL"] = mixDataValue;

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
		jAlert(alertMsg12);
		return null;
	}
	if ( gfn_isNull(formObj.find("input[name=usrTblStatblNm]").val()) ) {
		jAlert(alertMsg11);
		formObj.find("input[name=usrTblStatblNm]").focus();
		return null;
	}
	var params = jsonfy(formObj);
	params["statTitle"] = formObj.find("input[name=usrTblStatblNm]").val(); 	// 통계자료명
	params["statblExp"] = formObj.find("input[name=usrTblStatblExp]").val(); 	// 통계자료설명
	params["dtadvsVals"] = getChkedStatArrVal("dvs"); // 체크한 증감분석
	params["seqceNo"]  = usrTblSeq;

	//복수통계는 시계열 항목을 가지고 데이터를 전달한다.
	var mixData = formObj.find($("input[name=TAB_MVAL]"));
	var mixDataValue = [];
	mixData.each(function(index, element) {
		mixDataValue.push($(this).attr('value'));
	});
	//복수통계는 별도로 묶는다.
	params["TAB_MVAL"] = mixDataValue;
	
	return params;
}
/**
 * 통계스크랩 화면 접근시 통계스크랩된 항목/분류 데이터로 tree 체크
 * @param id :	통계표 ID
 * @param gubun	Itm : 항목, Cls : 분류, dvs : 증감분석, Grp : 그룹
 */
function setUsrTblChk(id, gubun) {
	var chkVals = null;
	if (gubun == "Itm" || gubun == "Cls" || gubun == "Grp") {
		chkVals = getStringParamArr("chk" + gubun + "s");
		treeObj = $("#"+id).dynatree("getTree");
	} else {
		chkVals = getStringParamArr(gubun);
		treeObj = $("#"+id).dynatree("getTree");
	}
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
	
	treeRefreshEvent("D");	//증감분석 트리

	mixStatTblEvent()
	viewOptionStatEvent();	//피봇설정 팝업 버튼이벤트 설정
	
	// 탭의 시트 및 차트의 크기만 조정한다.
	remarkInit();
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
	var objTab = getTabShowObj();//탭이 open된 객체가져옴
	var formObj = objTab.find("form[name=statsEasy-mst-form]");
	
	var mixListLen = formObj.find("input[name=TAB_MVAL]").length;
	if(mixListLen == 0) mixDataValSet(); //탭추가 완료후 복수통계 [선택된 시계열 정보 변수처리]
	
	//파라미터로 접근 한 경우 java에서 넘어온 파라미터값으로 param 값 넘겨준다.
	var params = formObj.serializeArray();
	params=changeSerialize(params,"dtacycleCd",$("#mixCycleVal").val());
	$.ajax({
		url : com.wise.help.url("/portal/stat/selectMultiStatDtl.do"),
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

			var chk = JSON.stringify(data.DATA2);
			var chkData = JSON.parse(chk);

			var optData = chkData.OPT_DATA; // 통계표 옵션 정보
			var optCdDc = ""; // 검색자료주기 선택값
			var wrttimeLastestVal = ""; // 검색 시계열 수

			if (optData.length > 0) {
				for (var i = 0; i < optData.length; i++) {
					if (optData[i].optCd == "DC")
						optCdDc = optData[i].optVal; // 검색자료주기 선택 확인
					if (optData[i].optCd == "TN")
						wrttimeLastestVal = optData[i].optVal; // 검색시계열 수 확인
				}
			}

			// 주석 Display
			var cmmtData = "";
			var cmmtStatblId = "";
			$.each(chkData.CMMT_DATA, function(key, value) {

				if(value.statblId != null){
					if(cmmtStatblId == ""){
						cmmtStatblId = value.statblId;
						cmmtData += "<br/><strong>"+value.statblNm+"</strong>";
					}else{
						if(cmmtStatblId != value.statblId){
							cmmtStatblId = value.statblId;
							cmmtData += "<br/><br/><strong>"+value.statblNm+"</strong>";
						}
					}
				}
				
				if (value.cmmtGubun == "TBL") {
					cmmtData += "<br><span style='color: blue; font-weight:bold;'>" + (gfn_isNull(value.cmmtIdtfr) ? "" : value.cmmtIdtfr) + "</span>" + openRealceAll(value.cmmtCont, "\n","<br/>");
				} else {
					cmmtData += "<br><span style='color: blue; font-weight:bold;'>"+ (gfn_isNull(value.cmmtIdtfr) ? "" : value.cmmtIdtfr) + "</span> "+ openRealceAll(value.cmmtCont, "\n","<br/>") ;
				}   
			});
			$('.remark').find($(".cmmt")).empty().append(cmmtData);
			tab.ContentObj.find(".remark > .cmmt > br").first().remove();		
			
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
// //////////////////////////////////////////////////////////////////////////////
// 포털 서비스 함수들
// //////////////////////////////////////////////////////////////////////////////
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
	$(".layerpopup-stat-wrapper").hide();
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
	$(".layerpopup-stat-wrapper").hide();
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
	case "HWP" :	//통계표 다운로드(HWP)시
		url = "/portal/stat/insertLogSttsHwp.do";
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
	var tabTitle = formObj.find("input[name=statTitle]").val();
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
	
	//복수통계의 경우 다운로드 로그 저장을 위해 통계표 ID를 확인하여 변수에 다시 담아서 넘긴다.
	var statblId = new Array();
	if ( formObj.find($("input[name=TAB_MVAL]")).length > 0 ) {
		for(var mIdx = 0; mIdx < formObj.find($("input[name=TAB_MVAL]")).length; mIdx++){
			var mixVal = formObj.find($("input[name=TAB_MVAL]:eq(" + mIdx + ")")).val();
			var splitStatblId = mixVal.split("-");
			statblId.push(splitStatblId[0]);
		}
	}
	var uniqStatblId = statblId.reduce(function(a, b){ if(a.indexOf(b) < 0) a.push(b); return a;},[]);
	formObj.find($("input[name=multiStatblId]")).remove();
	for(var z=0; z<uniqStatblId.length; z++){
		var sValue = uniqStatblId[z];		
		$('<input>').attr({
		    type: 'hidden',
		    name: 'multiStatblId',
		    value: sValue
		}).appendTo(formObj);
	}
	
	var params = {
		URL : url,
		ExtendParam : formObj.serialize() + "&fileNm=" + fileNm + "&sysTag=K&tabTitle="+tabTitle,
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
	var sheetId = formObj.find($(".grid.statEasySheet")).attr('id');
	var chartDivId = formObj.find($(".chart.statEasyChart")).attr('id');
	var mapDivId = formObj.find($(".map.statEasyMap")).attr('id');
	
	var ww = $(window).width();
	var hh = $(window).height();
	
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
	formObj.find($('.chartarea')).css({'padding-bottom' : 0});
	formObj.find($('.sheetarea')).css({'padding-bottom' : 0});
	obj.css({
		height : gridH
	});
	
	//전체화면시 시트/차트 높이 조정
	$("#"+sheetId).css("height", hh-285);
	$("#"+chartDivId).css("height", hh-285);

	//chart탭이 선택되어 있는 경우 사이즈 조절시 차트를 resize한다.
	if ($('#'+chartDivId).highcharts() != undefined)  chartResize(chartDivId);
	
	//map탭이 선택되어 있는 경우 사이즈 조절시 차트를 resize한다.
	if ($('#'+mapDivId).highcharts() != undefined)  chartResize(mapDivId);
	
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

/**
 * [복수통계]시계열 항목 DIV table 사이즈 조절 
 */
function multiSelDivInit() {
	var multiHeight = $(".searchCtrl").height();
	var multiWidth = $(".searchCtrl").width();
	
	if ($('body').hasClass('wide')) {
		
		//$('#mixInner').css("height", (multiHeight - 200) + "px").css("width", multiWidth + "px");
		$('#mixBody').css("height", (multiHeight - 228) + "px");
		
		if($('#mixListTable').find("tbody").height() > 560){
			var mixBodyWidth = $('#mixBody').width() - 17;
			$('#colwidth1').css("width", (mixBodyWidth/100*10) + "px");
			$('#colwidth2').css("width", (mixBodyWidth/100*30) + "px");
			$('#colwidth3').css("width", (mixBodyWidth/100*20) + "px");
			$('#colwidth4').css("width", (mixBodyWidth/100*20) + "px");
			$('#colwidth5').css("width", ((mixBodyWidth/100*20) + 17) + "px");
		}else{
			$('#colwidth1').css("width", "10%");
			$('#colwidth2').css("width", "30%");
			$('#colwidth3').css("width", "20%");
			$('#colwidth4').css("width", "20%");
			$('#colwidth5').css("width", "20%");
		}
	}else{
		// 복수통계의 > 선택된 시계열 항목 영역
		//$('#mixInner').css("height", "442px").css("width", "410.38px");
		$('#mixBody').css("height", "412px");
		
		if($('#mixListTable').find("tbody").height() > 415){
			$('#colwidth1').css("width", "30px");
			$('#colwidth2').css("width", "88px");
			$('#colwidth3').css("width", "59px");
			$('#colwidth4').css("width", "58px");
			$('#colwidth5').css("width", "75px");
		}else{
			$('#colwidth1').css("width", "10%");
			$('#colwidth2').css("width", "30%");
			$('#colwidth3').css("width", "20%");
			$('#colwidth4').css("width", "20%");
			$('#colwidth5').css("width", "20%");
		}
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
	//시트 조회
	$("a[id=addStatTab], a[id=addStatTab_pop]").bind("click", function(event) {
		
		centerDivCloseAction();
		
		var statblId = $("#sId").val();
		if ( gfn_isNull(statblId) ) {
			jAlert(alertMsg10);
			return false;
		}		
		
		// 조회 검색 셀 갯수 제한 validation
		if ( validSearchLimit({type : 1
			, obj : $("form[name=searchForm]")}) ) {
			tabStatEvent();
		}
			
	});
	//시트 조회 [모바일]
	$("a[id=addMultiStatTab]").bind("click", function(event) {
		var statblId = $("#sId").val();
		if ( gfn_isNull(statblId) ) {
			jAlert(alertMsg10);
			return false;
		}		
		tabStatEvent();
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
	// 선택영역 확장
	$("a[id=btn_centerExtend]").bind("click", function(event) {
		
		centerDivW = $(".box3s").width();
		centerDivH = $('.lSide .treeBox.size6').height();
		
		centerGrpH = $('#treeGrpData').height();
		centerItmH = $('#treeItmData').height();
		centerClsH = $('#treeClsData').height();

		$('.layout_A').addClass('box3line');
		$('.lSide .treeBox.size6').css("height", "530px");
		
		// 선택영역 확장시 영역 갯수에 따라 화면을 조절한다.
		var itemDispCnt = centerItmCnt();

		if(itemDispCnt == 3) {
			$(".box1s").css('width', '33.3%');
			$(".box2s").css('width', '33.3%');
			$(".box3s").css('width', '33.3%');
		}
		if(itemDispCnt == 2) {
			if($(".box1s").css("display") == "none") $(".box2s").css('width', '50%');
			if($(".box2s").css("display") == "none") $(".box1s").css('width', '50%');
			$(".box3s").css('width', '50%');
		}
		if(itemDispCnt == 1) {
			$(".box3s").css('width', '100%');
		}
		
		$("#treeGrpData").css('height', 530);
		$("#treeItmData").css('height', 530);
		$("#treeClsData").css('height', 530);
	});
	// 선택영역 축소
	$("#centerClose").bind("click", function(event) {
		centerDivCloseAction();
	});
	// 선택 Div영역 닫기
	$("#centerDivClose").bind("click", function(event) {
		centerDivCloseAction();
	});
	// 그룹선택 조회
	$("button[name=btn_grpInquiry]").bind("click", function(event) {
		doGrpSearch();
	});
	// 그룹선택 조회 enter
	$("input[name=grpSearchVal]").bind("keydown", function(event) {
		// 엔터키인 경우
		if (event.which == 13) {
			doGrpSearch();
			return false;
		}
	});
	// 그룹선택 초기화
	$("button[name=btn_grpReset]").bind("click", function(event) {
		doGrpReset();
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
	// 항목선택 초기화
	$("button[name=btn_itmReset]").bind("click", function(event) {
		doItmReset();
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
	// 분류선택 초기화
	$("button[name=btn_clsReset]").bind("click", function(event) {
		doClsReset();
	});
	//검색주기 변경 이벤트
	$("form[name=searchForm]").find("select[name=dtacycleCd]").bind("change", function(event) {
		selectWrttimeVal($("form[name=searchForm"), $(this).val());
	});

	// 모바일 통계주제 선택
	$("#mbSubject").change(function() {
		loadMainPage(true);
	});
	// 메인 검색결과 정렬버튼(오름차순) 클릭이벤트
	$("#sortAsc").bind("click", function(event) {
		$("#sId").val(""); // 통계표 ID
		$("#stat_title").text(""); // title 초기화
		//$("#searchVal, #statSearchVal").val(""); // 검색값 초기화
		$("#searchResult li").remove(); // 검색한 항목 삭제

		$(this).text("▼");
		$("#sortDesc").text("△");
		$("#sortGb").val("ASC");
		loadMainSearchList();
		
		// 항목선택/분류선택을 초기화한다. + 그룹
		$("#treeItmData").empty();
		$("#treeClsData").empty();
		$("#treeGrpData").empty();

		// 닫기 버튼 눌렀을때 모바일 리스트 재 검색(반응형 때문에.....)
		loadMainMobileList($("#commonForm [name=page]").val());
	});
	// 메인 검색결과 정렬버튼(내림차순) 클릭이벤트
	$("#sortDesc").bind("click", function(event) {
		$("#sId").val(""); // 통계표 ID
		$("#stat_title").text(""); // title 초기화
		//$("#searchVal, #statSearchVal").val(""); // 검색값 초기화
		$("#searchResult li").remove(); // 검색한 항목 삭제

		$(this).text("▲");
		$("#sortAsc").text("▽");
		$("#sortGb").val("DESC");
		loadMainSearchList();
		
		// 항목선택/분류선택을 초기화한다. + 그룹
		$("#treeItmData").empty();
		$("#treeClsData").empty();
		$("#treeGrpData").empty();
		
		// 닫기 버튼 눌렀을때 모바일 리스트 재 검색(반응형 때문에.....)
		loadMainMobileList($("#commonForm [name=page]").val());
	});
	// 메인 검색결과 팝업 닫기
	$("#searchResultClose").bind("click", function(event) {
		$("#sId").val(""); // 통계표 ID
		$("#stat_title").text(""); // title 초기화
		$("#searchVal, #statSearchVal").val(""); // 검색값 초기화
		$("#searchResult li").remove(); // 검색한 항목 삭제
		$("#searchResult").hide();

		// 항목선택/분류선택을 초기화한다. + 그룹
		$("#treeItmData").empty();
		$("#treeClsData").empty();
		$("#treeGrpData").empty();

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

			$('.easySearch .treeBox.size2').css("height", "621px");
			$('#treeStatData').css("height", "621px");
			$('.easySearch .rightArea .searchCtrl').css("height", "678px");
			
			// 선택영역 확장시 영역 갯수에 따라 화면을 조절한다.
			var itemDispCnt = centerItmCnt();
			
			centerDivH = 143;
			centerItmH = 143;
			centerClsH = 143;
			centerGrpH = 143;
			
			if(itemDispCnt == 3) {
				$('.lSide .treeBox.size6').css("height", 143);
				$('#treeGrpData').css("height", 143);
				$('#treeItmData').css("height", 143);
				$('#treeClsData').css("height", 143);
			}
			if(itemDispCnt == 2) {
				$('.lSide .treeBox.size6').css("height", 263);
				if($(".box1s").css("display") == "none") {
					$('#treeItmData').css("height", 263);
				}
				if($(".box2s").css("display") == "none") {
					$('#treeGrpData').css("height", 263);
				}
				$('#treeClsData').css("height", 263);
			}
			if(itemDispCnt == 1) {
				$('.lSide .treeBox.size6').css("height", 622);
				$('#treeItmData').css("height", 622);
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

			$('.easySearch .treeBox.size2').css("height", (wHeight - 177) + "px");
			$('#treeStatData').css("height", (wHeight - 177) + "px");
			$('.easySearch .rightArea .searchCtrl').css("height", (wHeight - 121) + "px");

			//기본화면 상태의 size를 등록해놓는다.
			centerDivH = $('.lSide .treeBox.size6').height();
			centerGrpH = $('#treeGrpData').height();
			centerItmH = $('#treeItmData').height();
			centerClsH = $('#treeClsData').height();
			
			// 선택영역 확장시 영역 갯수에 따라 화면을 조절한다.
			var itemDispCnt = centerItmCnt();
			
			if(itemDispCnt == 3) {
				$('.lSide .treeBox.size6').css("height", (wHeight / 3 - 123) + "px");
				$('#treeGrpData').css("height", (wHeight / 3 - 123) + "px");
				$('#treeItmData').css("height", (wHeight / 3 - 123) + "px");
				$('#treeClsData').css("height", (wHeight / 3 - 123) + "px");
			}
			if(itemDispCnt == 2) {
				$('.lSide .treeBox.size6').css("height", (wHeight / 2 - 137) + "px");
				if($(".box1s").css("display") == "none") {
					$('#treeItmData').css("height", (wHeight / 2 - 137) + "px");
				}
				if($(".box2s").css("display") == "none") {
					$('#treeGrpData').css("height", (wHeight / 2 - 137) + "px");
				}
				$('#treeClsData').css("height", (wHeight / 2 - 137) + "px");
			}
			if(itemDispCnt == 1) {
				$('.lSide .treeBox.size6').css("height", (wHeight - 177) + "px");
				$('#treeItmData').css("height", (wHeight - 177) + "px");
			}
			
			remarkInit();
		}
		// 복수통계의 > 선택된 시계열 항목 영역
		multiSelDivInit();
	});

}

/**
* 복수통계용 통계화면 컨트롤 정의
*/
function mixControl() {
	//복수통계 선택된 시계열 항목 초기화 이벤트
	$('#mixReset').bind("click", function(event){
		var body = $('#mixListTable tbody');
		body.empty();
		
		//모바일용 Div Table 세팅
		var bodyM = $('#mixListTableM tbody');
		bodyM.empty();
		
		SEL_DTACYCLE_CD = "";	// 복수통계 항목 추가시 처음 선택된 주기코드 초기화
		$("#mixCycleVal").val(""); //선택 주기값을 초기화
		$("#selcycleCd").val("").prop("selected", true);
	});

	//[모바일] 복수통계 선택된 시계열 항목 초기화 이벤트
	$('#mixResetM').bind("click", function(event){
		var body = $('#mixListTable tbody');
		body.empty();
		
		//모바일용 Div Table 세팅
		var bodyM = $('#mixListTableM tbody');
		bodyM.empty();
		
		SEL_DTACYCLE_CD = "";	// 복수통계 항목 추가시 처음 선택된 주기코드 초기화
		$("#mixCycleVal").val(""); //선택 주기값을 초기화
		$("#selcycleCd").val("").prop("selected", true);
	});
	
/*	//선택된 시계열 항목 선택 - 넣기
	$("#itmPlus").bind("click", function(event) {
		selectInMixData();
    });
	//선택된 시계열 항목 선택 - 빼기
	$("#itmMinus").bind("click", function(event) {
		var delChk = deleteInMixData('P');

		if(delChk){
			if($('#mixListTable').find("input").length > 0){
				rowSpan("mixListTable", 2);	//통계표 명칭 동일 병합(PC)
				rowSpan("mixListTableM", 2);//통계표 명칭 동일 병합(모바일)
			}else{
				$("#mixCycleVal").val(""); //선택 주기값을 초기화
			}
		}
		
		multiSelDivInit();
    });*/

	//[모바일]선택된 시계열 항목 선택 - 넣기
	$("#itmPlusM1").bind("click", function(event) {
		selectInMixData();
		
		//모바일에서 추가를 했다면 DIV팝업창을 닫고 [선택항목]을 노출한다.
		$('.easySearch').removeClass('complex2');
		$("#D").addClass('on');
		$("#L").removeClass('on');
		
		$(".searchResult2").css('display','');
		$(".searchResult").css('display','none');
		$("#stat-pager-sect").css('display','none');
    });
	$("#itmPlusM2").bind("click", function(event) {
		selectInMixData();
		
		//모바일에서 추가를 했다면 DIV팝업창을 닫고 [선택항목]을 노출한다.
		$('.easySearch').removeClass('complex2');
		$("#D").addClass('on');
		$("#L").removeClass('on');
		
		$(".searchResult2").css('display','');
		$(".searchResult").css('display','none');
		$("#stat-pager-sect").css('display','none');
    });

	//선택된 시계열 항목 선택 - 빼기
	$("#itmMinusM").bind("click", function(event) {
		var delChk = deleteInMixData('M');
		
		if(delChk){
			if($('#mixListTable').find("input").length > 0){
				rowSpan("mixListTable", 2);	//통계표 명칭 동일 병합(PC)
				rowSpan("mixListTableM", 2);//통계표 명칭 동일 병합(모바일)
			}else{
				$("#mixCycleVal").val(""); //선택 주기값을 초기화
				$("#selcycleCd").val("").prop("selected", true);
			}
		}
		
		multiSelDivInit();
    });

	//[모바일]항목/분류 DIV 닫기
	$("#itmCloseM1").bind("click", function(event) {
		$('.easySearch').removeClass('complex2');
    });
	$("#itmCloseM2").bind("click", function(event) {
		$('.easySearch').removeClass('complex2');
    });	
/*	
	//복수통계 선택된 시계열 항목 올리기 이벤트
	$('#mixUp').bind("click", function(event){
		var body = $('#mixListTable tbody');
		var len = body.find("input:checked").length;
		if(len > 0){
			var upChk = selectUpMixData("P");	
			
			if(upChk){
				rowSpan("mixListTable", 2);	//통계표 명칭 동일 병합(PC)
				rowSpan("mixListTableM", 2);//통계표 명칭 동일 병합(모바일)
			}
		}else{
			jAlert(alertMsg14);
			return;
		}
	});

	//[모바일] 복수통계 선택된 시계열 항목 올리기 이벤트
	$('#mixUpM').bind("click", function(event){
		var bodyM = $('#mixListTableM tbody');
		var len = bodyM.find("input:checked").length;
		if(len > 0){
			var upChk = selectUpMixData("M");		
			
			if(upChk){
				rowSpan("mixListTable", 2);	//통계표 명칭 동일 병합(PC)
				rowSpan("mixListTableM", 2);//통계표 명칭 동일 병합(모바일)
			}
		}else{
			jAlert(alertMsg14);
			return;
		}
	});
	
	//복수통계 선택된 시계열 항목 내리기 이벤트
	$('#mixDown').bind("click", function(event){
		var body = $('#mixListTable tbody');
		var len = body.find("input:checked").length;
		if(len > 0){
			var downChk = selectDownMixData("P");		

			if(downChk){
				rowSpan("mixListTable", 2);	//통계표 명칭 동일 병합(PC)
				rowSpan("mixListTableM", 2);//통계표 명칭 동일 병합(모바일)
			}
		}else{
			jAlert(alertMsg14);
			return;
		}
	});

	//[모바일] 복수통계 선택된 시계열 항목 내리기 이벤트
	$('#mixDownM').bind("click", function(event){
		var bodyM = $('#mixListTableM tbody');
		var len = bodyM.find("input:checked").length;
		if(len > 0){
			var downChk = selectDownMixData("M");	
			
			if(downChk){
				rowSpan("mixListTable", 2);	//통계표 명칭 동일 병합(PC)
				rowSpan("mixListTableM", 2);//통계표 명칭 동일 병합(모바일)
			}
		}else{
			jAlert(alertMsg14);
			return;
		}
	});
	*/
	//복수통계 선택된 시계열 항목 전체선택/해제 이벤트
	$('#allMixCheck').bind("click", function(event){
		selectCheckAll("P");
	});

	//[모바일] 복수통계 선택된 시계열 항목 전체선택/해제 이벤트
	$('#allMixCheckM').bind("click", function(event){
		selectCheckAll("M");
	});

	//[모바일] 통계목록 Tab선택
	$('#mixStatList').bind("click", function(event){
		$("#L").addClass('on');
		$("#D").removeClass('on');
		
		$("#mobileList").css('display','');
		$(".searchResult2").css('display','none');
		
		//하단 페이지 영역 노출
		$("#stat-pager-sect").css('display','');
	});
	//[모바일] 선택항목 Tab선택
	$('#mixStatSelData').bind("click", function(event){
		$("#D").addClass('on');
		$("#L").removeClass('on');
		
		$(".searchResult2").css('display','');
		$("#mobileList").css('display','none');
		
		//하단 페이지 영역 숨김
		$("#stat-pager-sect").css('display','none');
	});
    // 펼치기 토글 버튼 
    $("a[id=fullOpen]").bind("click", function(event) {
    	$(".areaDv").toggleClass("lefthalf");
    	$("#fullOpen").toggleClass("on");
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

			if(formObj.find("a[title=Sheet]").parents("li").hasClass("on")){
				reCreateSheet();	//통계 시트 새로조회
			}else if(formObj.find("a[title=Chart]").parents("li").hasClass("on")){
				formObj.find("input[name=chartType]").val(""); 		// 차트 : 선택타입 초기화
				formObj.find("input[name=chartStockType]").val("");	// 차트 : HISTORY/SCROLL 초기화
				formObj.find("input[name=chart23Type]").val("2D");	// 차트 : 2D/3D 초기화
				formObj.find("input[name=chartLegend]").val("");	// 차트 : 범례 초기화
				
				// 차트 버튼 이미지 초기화
				formObj.find(".chartMenu > button img").each(function(event) {
					var src = $(this).attr("src");
					$(this).attr("src", src.replace("on", ""));
				});
				
				doLoadChart();		//통계  차트 새로조회
			}
		}

	});
	// 모바일 목록 버튼
	formObj.find("button[name=easyClose]").bind("click", function(event) {
		location.href = com.wise.help.url("/portal/stat/multiStatPage.do")
	});
	// Shee & Chart tab
	formObj.find($('.tabSt li')).on('click', function() {
		var id = $(this).find('a').attr('href');

		formObj.find($('.tabSt li')).removeClass('on');
		$(this).addClass('on');

		if (id == "#sheetTab") {
			formObj.find($(".tabCont.sheetTab")).show();
			formObj.find($(".tabCont.chartTab")).hide();
			formObj.find($(".tabCont.mapTab")).hide();
			reCreateSheet();
		} else if(id == "#chartTab") {
			formObj.find($(".tabCont.sheetTab")).hide();
			formObj.find($(".tabCont.chartTab")).show();
			formObj.find($(".tabCont.mapTab")).hide();

			formObj.find("div[class=dropdown-content]").hide();
			doLoadChart();
		} else { //mapTab
			formObj.find($(".tabCont.sheetTab")).hide();
			formObj.find($(".tabCont.chartTab")).hide();
			formObj.find($(".tabCont.mapTab")).show();

			formObj.find("div[class=dropdown-content]").hide();
			loadMap(formObj.find($(".map.statEasyMap")).attr('id'), formObj.find("input[name=tabMapVal]").val(), "T");
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
	});
	// 검색주기 선택
	formObj.find($('.viewBx .searchBx .cellbox .cell')).find("select[name=dtacycleCd]").change(function() {
		selectWrttimeVal(formObj, $(this).val());
	});
	// 그룹선택 버튼
	formObj.find("button[name=callPopGrp]").bind("click", function(event) {
		formObj.find($(".layerPopup.grpPop")).show();
		formObj.find($(".layerPopup.grpPop .PschBar input")).focus();	// 2018.04.24 김정호 - 레이어 팝업 오픈시 검색창에 focus를 준다.
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
		formObj.find($(".layerPopup.grpPop")).hide();
		formObj.find($(".layerPopup.itmPop")).hide();
		formObj.find($(".layerPopup.clsPop")).hide();
		formObj.find($(".layerPopup.optPop")).hide();
		formObj.find($(".layerPopup.dvsPop")).hide();
		formObj.find("button[name=callPop"+closeNm+"]").focus();	// 2018.04.24 김정호 - 레이어 팝업 닫을경우 레이어 버튼에 포커스를 준다.
	});
	// 그룹설정 팝업 닫기버튼
	formObj.find("a[name=grpClose], a[name=grpPopClose]").bind("click", function(event) {
		formObj.find($(".layerPopup.grpPop")).hide();
		formObj.find("button[name=callPopGrp]").focus();	// 2018.04.24 김정호 - 레이어 팝업 닫을경우 레이어 버튼에 포커스를 준다.
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
		/*if ( formObj.find(".txtHistory").css("display") != "none" ) {
			jAlert(alertMsg01);
			return false;
		}*/
		formObj.find($(".layerPopup.usrTblPop")).show();
		formObj.find("input[name=usrTblStatblNm]").focus();
	});
	formObj.find("button[name=btnUsrTbl]").bind("keydown", function(event) {
		if (event.which == 13) {
			/*if ( formObj.find(".txtHistory").css("display") != "none" ) {
				jAlert(alertMsg01);
				return false;
			}*/
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
			location.href = com.wise.help.url("/portal/user/oauth/authorizePage.do");
		});
	});
	formObj.find("button[name=btnUsrTblLogin]").bind("keydown", function(event) {
        if (event.which == 13) {
        	jConfirm("로그인 후 이용 가능합니다.\n\n로그인 하시겠습니까?", function() {
    			location.href = com.wise.help.url("/portal/user/oauth/authorizePage.do");
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
	// 다운로드[HWP] 버튼
	formObj.find("button[name=downHWP]").bind("click", function(event) {
		/*
		 * Sheet HWP 파일 다운로드
		 */
		var sheetNm = formObj.find($(".grid.statEasySheet")).attr('id');
		
		//복수통계의 경우 다운로드 로그 저장을 위해 통계표 ID를 확인하여 변수에 다시 담아서 넘긴다.
		var statblId = new Array();
		if ( formObj.find($("input[name=TAB_MVAL]")).length > 0 ) {
			for(var mIdx = 0; mIdx < formObj.find($("input[name=TAB_MVAL]")).length; mIdx++){
				var mixVal = formObj.find($("input[name=TAB_MVAL]:eq(" + mIdx + ")")).val();
				var splitStatblId = mixVal.split("-");
				statblId.push(splitStatblId[0]);
			}
		}
		var uniqStatblId = statblId.reduce(function(a, b){ if(a.indexOf(b) < 0) a.push(b); return a;},[]);
		
		formObj.find($("input[name=TAB_MVAL]")).val();
		sheetNm = sheetNm.replace("DIV_", "");
		var sheetObj = window[sheetNm];
		var hwpColArray = new Array();
		
		for(var idx = 0; idx < sheetObj.LastCol() + 1; idx++){
			if(!sheetObj.GetColHidden(idx)){
				hwpColArray.push(idx);
			}
		}
		
		var docTitle = objTab.find(".sheetTitle").html();
		
		var params = {
   	           Title:{ Text:docTitle, Align:"Center"},
   	           DocOrientation:"Landscape",
   	           DownCols: hwpColArray.join("|"),
					FileName: docTitle
    	} ;

		//통계표 다운로드(HWP) 로그 남김
		insertStatLogs("HWP", {statMulti: "Y", multiStatblId: uniqStatblId});
		
		sheetObj.Down2Hml(params);
		return false;
	});
	
	/*************************************************************************************/
	/* 차트 버튼 이벤트 처리 START */
	
	// 차트 범례 버튼
	formObj.find("button[name=remarkShow]").bind("click", function(event) {
		//if (formObj.find($('.chart')).hasClass('wide')) {
		var cLegendVal = formObj.find("input[name=chartLegend]").val();
		
		if (cLegendVal == "" || cLegendVal == "Y") {
			formObj.find("input[name=chartLegend]").val("N");
			formObj.find("button[name=remarkShow]").children("img").attr("src", "/images/soportal/chart/charbtn01.png");
			$('.chart').addClass('wide');
			for (var i = 0; i < hightChart.series.length-1; i++) {
				hightChart.series[i].update({
					showInLegend : false
				});
			}
		} else {
			formObj.find("input[name=chartLegend]").val("Y");
			formObj.find("button[name=remarkShow]").children("img").attr("src", "/images/soportal/chart/charbtn01on.png");
			formObj.find($('.chart')).removeClass('wide');
			for (var i = 0; i < hightChart.series.length-1; i++) {
				hightChart.series[i].update({
					showInLegend : true
				});
			}

		}
	});

	// 2D || 3D 버튼
	formObj.find("button[name=chartViewType]").bind("click", function(event) {
		//기본 차트정보 호출
		var chartId = formObj.find($(".chart.statEasyChart")).attr('id');
		var imgSrc = $(this).children("img").attr("src");
		if (imgSrc.indexOf("charbtn03.png") != -1) {
			$(this).children("img").attr("src", "/images/soportal/chart/charbtn03_.png");

			//3D로 옵션변경
			formObj.find("input[name=chart23Type]").val("3D");
			var chartType = formObj.find("input[name=chartType]").val();
			statChartCreate(chartType, chartId);
		}else{
			$(this).children("img").attr("src", "/images/soportal/chart/charbtn03.png");
			
			//2D로 옵션변경
			formObj.find("input[name=chart23Type]").val("2D");
			var chartType = formObj.find("input[name=chartType]").val();
			statChartCreate(chartType, chartId);
		}
	});

	// 기본차트
	formObj.find("button[name=chartBasic]").bind("click", function(event) {
		var chartId = formObj.find($(".chart.statEasyChart")).attr('id');
		statChartCreate("", chartId);
		formObj.find("input[name=chartType]").val("");
		formObj.find("input[name=chartStockType]").val("");
		formObj.find("input[name=chart23Type]").val("2D");
		chartButtonReset("charbtn19");
	});
	
	//버튼선택에 따른 초기화
	function chartButtonReset(selNum){
		formObj.find($(".chartMenu")).find("button").each(function(event){
			var imgSrc = $(this).children("img").attr("src");
			if (imgSrc.indexOf("on.png") != -1 && imgSrc.indexOf("01") == -1) {
				$(this).children("img").attr("src", imgSrc.replace("on", ""));
			}
			
			if (imgSrc.indexOf(selNum) != -1){
				$(this).children("img").attr("src", "/images/soportal/chart/"+selNum+"on.png");
			}
		});
	}
	
	// 곡선
	formObj.find("button[name=chartSpline]").bind("click", function(event) {
		var chartId = formObj.find($(".chart.statEasyChart")).attr('id');
		statChartCreate("spline", chartId);
		formObj.find("input[name=chartType]").val("spline");
		chartButtonReset("charbtn04");
	});
	// 꺽은선
	formObj.find("button[name=chartLine]").bind("click", function(event) {
		var chartId = formObj.find($(".chart.statEasyChart")).attr('id');
		statChartCreate("line", chartId);
		formObj.find("input[name=chartType]").val("line");
		chartButtonReset("charbtn05");
	});
	// 누적영역
	formObj.find("button[name=chartArea]").bind("click",	function(event) {
		var chartId = formObj.find($(".chart.statEasyChart")).attr('id');
		statChartCreate("area", chartId);
		formObj.find("input[name=chartType]").val("area");
		chartButtonReset("charbtn06");
	});
	// 막대
	formObj.find("button[name=chartHbar]").bind("click", function(event) {
		var chartId = formObj.find($(".chart.statEasyChart")).attr('id');
		statChartCreate("column", chartId);
		formObj.find("input[name=chartType]").val("column");
		chartButtonReset("charbtn07");
	});
	// 누적막대
	formObj.find("button[name=chartAccHbar]").bind("click", function(event) {
		var chartId = formObj.find($(".chart.statEasyChart")).attr('id');
		statChartCreate("accolumn", chartId);
		formObj.find("input[name=chartType]").val("accolumn");
		chartButtonReset("charbtn08");
	});
	// 퍼센트누적막대
	formObj.find("button[name=chartPAccHbar]").bind("click", function(event) {
		var chartId = formObj.find($(".chart.statEasyChart")).attr('id');
		statChartCreate("pccolumn", chartId);
		formObj.find("input[name=chartType]").val("pccolumn");
		chartButtonReset("charbtn09");
	});
	// 가로막대
	formObj.find("button[name=chartWbar]").bind("click", function(event) {
		var chartId = formObj.find($(".chart.statEasyChart")).attr('id');
		statChartCreate("bar", chartId);
		formObj.find("input[name=chartType]").val("bar");
		chartButtonReset("charbtn10");
	});
	// 가로누적막대
	formObj.find("button[name=chartAccWbar]").bind("click",	function(event) {
		var chartId = formObj.find($(".chart.statEasyChart")).attr('id');
		statChartCreate("acbar", chartId);
		formObj.find("input[name=chartType]").val("acbar");
		chartButtonReset("charbtn11");
	});
	// 퍼센트가로누적막대
	formObj.find("button[name=chartPAccWbar]").bind("click", function(event) {
		var chartId = formObj.find($(".chart.statEasyChart")).attr('id');
		statChartCreate("pcbar", chartId);
		formObj.find("input[name=chartType]").val("pcbar");
		chartButtonReset("charbtn12");
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
			jAlert("파이형 차트는 다운로드 기능을 지원하지 않습니다.");
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
			jAlert("파이형 차트는 다운로드 기능을 지원하지 않습니다.");
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
			jAlert("파이형 차트는 다운로드 기능을 지원하지 않습니다.");
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
			jAlert("파이형 차트는 다운로드 기능을 지원하지 않습니다.");
			return false;
		}
		hightChart.exportChart({
			type : 'image/svg+xml',
			filename : 'nasna-svg'
		});
	});

	/* 차트 버튼 이벤트 처리 END */
	/*************************************************************************************/

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
		$("#mbSubject").append("<option value=\"\">전체</option>");
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

////////////////////////////////////////////////////////////////////////////////
//[복수통계 시계열 항목 처리] 체크사항을 Count한다.
////////////////////////////////////////////////////////////////////////////////
function dataCheckCount(checkDataCnt, nodesData){
	$.each(nodesData, function(key, value){
		if(value.children){
			checkDataCnt = dataCheckCount(checkDataCnt, value.children);
		}else{
			if(value.checked) checkDataCnt++; 
		}
	});
	return checkDataCnt;
}




////////////////////////////////////////////////////////////////////////////////
//[복수통계 시계열 항목 처리] 선택된 시계열 항목을 올린다.
////////////////////////////////////////////////////////////////////////////////
function selectUpMixData(deviceGb){
	var body = $('#mixListTable tbody');
	var bodyM = $('#mixListTableM tbody');
	var targetBody;
	if(deviceGb == "P") targetBody = body;
	else targetBody = bodyM;	
	
	var inHtml = "";
	var tr1Line = "";
	var tr2Line = "";
	var trChkLine = "";
	targetBody.find("tr").each(function(index, element) {
		var sName = $(this).find("input").attr('name');
		var sValue = $(this).find("input").attr('value');
		var tdText1 = $(this).find("td").eq(1).text();
		var tdText2 = $(this).find("td").eq(2).text();
		var tdText3 = $(this).find("td").eq(3).text();
		var tdText4 = $(this).find("td").eq(4).text();
		var chekedVal = "";
		if($(this).find("input").is(":checked")) chekedVal = "checked"; //체크상태 유지
		
		trChkLine = "<tr><td align='center'><input type='checkbox' name='MIXVAL' title='MIXVAL' value='"+sValue+"' "+chekedVal+"/></td>"
			+"<td>"+tdText1+"</td><td>"+tdText2+"</td><td>"+tdText3+"</td><td>"+tdText4+"</td></tr>";
		if(tr1Line == ""){
			tr1Line = trChkLine; //최초 TR 라인
		}else{
			if($(this).find("input").is(":checked")){
				tr2Line = trChkLine;
			}else{
				tr2Line = tr1Line;
				tr1Line = trChkLine;
			}
			inHtml += tr2Line;
		}
	});
	inHtml += tr1Line;
	
	body.empty().append(inHtml);
	
	//모바일용 Div Table 세팅
	bodyM.empty().append(inHtml);
	
	return true;
}

////////////////////////////////////////////////////////////////////////////////
//[복수통계 시계열 항목 처리] 선택된 시계열 항목을 내린다.
////////////////////////////////////////////////////////////////////////////////
function selectDownMixData(deviceGb){
	var body = $('#mixListTable tbody');
	var bodyM = $('#mixListTableM tbody');
	var targetBody;
	if(deviceGb == "P") targetBody = body;
	else targetBody = bodyM;	
		
	var inHtml = "";
	var trLine = "";
	var trKey = "";
	var trChkLine = "";
	targetBody.find("tr").each(function(index, element) {
		var sName = $(this).find("input").attr('name');
		var sValue = $(this).find("input").attr('value');
		var tdText1 = $(this).find("td").eq(1).text();
		var tdText2 = $(this).find("td").eq(2).text();
		var tdText3 = $(this).find("td").eq(3).text();
		var tdText4 = $(this).find("td").eq(4).text();
		var chekedVal = "";
		if($(this).find("input").is(":checked")) chekedVal = "checked"; //체크상태 유지
		
		trChkLine = "<tr><td align='center'><input type='checkbox' name='MIXVAL' title='MIXVAL' value='"+sValue+"' "+chekedVal+"/></td>"
			+"<td>"+tdText1+"</td><td>"+tdText2+"</td><td>"+tdText3+"</td><td>"+tdText4+"</td></tr>";
		
		if(trLine == ""){
			trLine = trChkLine;
			if($(this).find("input").is(":checked")) trKey = "Y";
			else trKey = "N";
		}else{
			if($(this).find("input").is(":checked")){
				if(trKey == "Y"){ trLine += trChkLine; }
				else{ inHtml += trLine; trLine = trChkLine; }
				trKey = "Y";
			}else{
				if(trKey == "N"){ trLine += trChkLine; }
				else{ inHtml += trChkLine;}
				trKey = "N";
			}
		}
	});
	inHtml += trLine;
	
	body.empty().append(inHtml);
	
	//모바일용 Div Table 세팅
	bodyM.empty().append(inHtml);
	
	return true;
}

////////////////////////////////////////////////////////////////////////////////
//[복수통계 시계열 항목 처리] 선택된 시계열 항목 전체선택/해제
////////////////////////////////////////////////////////////////////////////////
function selectCheckAll(diviceGb){
	var targetDiv = "";
	if(diviceGb == "P") targetDiv = $("#allMixCheck");
	else targetDiv = $("#allMixCheckM");
	
	if(targetDiv.is(":checked")){
		$("#mixListTable").find("input").each(function(index, element) {
			$(this).prop("checked", true);
		});
		$("#mixListTableM").find("input").each(function(index, element) {
			$(this).prop("checked", true);
		});
	}else{
		$("#mixListTable").find("input").each(function(index, element) {
			$(this).prop("checked", false);
		});
		$("#mixListTableM").find("input").each(function(index, element) {
			$(this).prop("checked", false);
		});
	}
}

////////////////////////////////////////////////////////////////////////////////
//[복수통계 시계열 항목 처리] 같은 값이 있는 열을 병합 >>> 속도개선
////////////////////////////////////////////////////////////////////////////////
function rowSpan(tableId, colIdx){
	
	$('#'+tableId).each(function() {
		var table = this;
		$.each([colIdx] /* 합칠 칸 번호 */, function(c, v) {
			var tds = $('>tbody>tr>td:nth-child(' + v + ')', table).toArray(), i = 0, j = 0;
			for(j = 1; j < tds.length; j ++) {
				if(tds[i].innerHTML != tds[j].innerHTML) {
					$(tds[i]).attr('rowspan', j - i);
					i = j;
					continue;
				}
				$(tds[j]).hide();
			}
			j --;
			if(tds[i].innerHTML == tds[j].innerHTML) {
				$(tds[i]).attr('rowspan', j - i + 1);
			}
		});
	});
}

////////////////////////////////////////////////////////////////////////////////
//[복수통계 시계열 항목 처리] 탭생성 후 검색기간 세팅
////////////////////////////////////////////////////////////////////////////////
function mixWrtDtaCycle() {
	var objTab = getTabShowObj();// 탭이 open된 객체가져옴
	var formObj = objTab.find("form[name=statsEasy-mst-form]");
	var statblId = formObj.find($("input[name=statblId]")).val();
	var dtacycleCd = formObj.find($("select[name=dtacycleCd]")).val();

	var searchObj = new Array();
	
	//복수통계는 시계열 항목을 가지고 탭구성을 진행한다.
	var mixData = formObj.find($("input[name=TAB_MVAL]"));
	searchObj.push(dtacycleCd);
	mixData.each(function(index, element) {
		searchObj.push($(this).attr('value'));
	});
	
	//통계자료 체크박스 로드
	$.ajax({
		  type: 'POST',
		  url: com.wise.help.url("/portal/stat/statMultiWrtTimeOption.do"),
		  data: "TAB_MVAL="+searchObj,
		  success: function(res1) {
			  
			  if (res1.data) {
					// 콤보 옵션을 초기화한다.
					initTabComboOptions(formObj, "wrtStartYmd", res1.data, ""); // 기간검색
																				// 시작
					initTabComboOptions(formObj, "wrtEndYmd", res1.data, ""); // 기간검색
																				// 종료
	            }
		  },
		  dataType: 'json',
		  async:false
	});
	
}

////////////////////////////////////////////////////////////////////////////////
//[복수통계 시계열 항목 처리] 탭생성 후 피봇설정 적용버튼
////////////////////////////////////////////////////////////////////////////////
function setPiEvent(){
	var objTab = getTabShowObj();// 탭이 open된 객체가져옴
	var formObj = objTab.find("form[name=statsEasy-mst-form]");
	
	if (  $("#searchType").val() == "U" ) {
		var viewLocOptVal = getStringParam("viewLocOpt");

		var $radios = formObj.find('input:radio[name=viewLocOpt]');
		$radios.filter('[value='+viewLocOptVal+']').prop('checked', true);
	}
	
	// 피봇설정 적용버튼
	formObj.find("a[name=optRefresh]").bind("click", function(event) {
		if (searchValidation(formObj)) {
			// 20180508/김정호 - validation 하고 팝업 닫도록 수정(년월 보기 focus 때문에)
			formObj.find($(".layerPopup.optPop")).hide();
			showLoading();
			
			if(formObj.find("a[title=Sheet]").parents("li").hasClass("on")){
				reCreateSheet();	//통계 시트 새로조회
			}else{
				alert("피봇설정은 Sheet를 재조회 합니다.")
				reCreateSheet();	//통계 시트 새로조회
			}
		}
	});

	formObj.find("a[name=optClose]").bind("click", function(event) {
		formObj.find($(".layerPopup.optPop")).hide();
	});
};

////////////////////////////////////////////////////////////////////////////////
//[복수통계 통계스크랩] 통계스크랩의 setting값을 시계열항목에 Display
////////////////////////////////////////////////////////////////////////////////
function setDirectMulti(){
	//PC용 Div Table 세팅
	var body = $('#mixListTable tbody');
	//모바일용 Div Table 세팅
	var bodyM = $('#mixListTableM tbody');
	
	var mixData = getStringParamArr("mixData");
	
	for(var i=0; i<mixData.length; i++){
	  	$.ajax({
	  		url: com.wise.help.url("/portal/stat/selectMultiName.do"),
		    async: false, 
		    type: 'POST', 
		    data: "mixDataVal=" + mixData[i],
		    dataType: 'json',
		    beforeSend: function(obj) {
		    }, // 서버 요청 전 호출 되는 함수 return false; 일 경우 요청 중단
		    success: function(res) {
				var data = res.data;
				var statData = data.DATA; // 통계표 기본 정보
				var inHtml = "<tr><td align='center'><input type='checkbox' name='MIXVAL' title='MIXVAL' value='"+mixData[i]+"'/></td>"
				+ "<td>"+statData[0].statblNm+"</td><td>"+statData[0].grpDataNm+"</td><td>"+statData[0].clsDataNm+"</td><td>"+statData[0].itmDataNm+"</td></tr>";
				
				body.append(inHtml);	//PC용 시계열 항목 테이블 추가
				bodyM.append(inHtml);	//모바일용 시계열 항목 테이블 추가
				
		    }, // 요청 완료 시
		    error: function(request, status, error) {
		    	handleError(status, error);
		    }, // 요청 실패.
		    complete: function(jqXHR) {} // 요청의 실패, 성공과 상관 없이 완료 될 경우 호출
		});
	}
	
	rowSpan("mixListTable", 2);	//통계표 명칭 동일 병합(PC)
	rowSpan("mixListTableM", 2);//통계표 명칭 동일 병합(모바일)
}



/**
 * 조회 검색 셀 갯수 제한 validation 하는 함수이다.
 * @param param
 * 		- type : 조회 타입, 0:탭 화면 조회, 1:시작화면 조회
 * 		- obj : form 오브젝트
 * @returns {Boolean}
 */
function validSearchLimit(param) {
	if (param.obj == null) return false;
	param.type 		= param.type 		|| 0;
	
	var mixListLen = 1;
	var objTab = getTabShowObj();// 탭이 open된 객체가져옴
	
	if ( param.type > 0 ) {
		mixListLen = $('#mixListTable').find("input").length;
	} else {
		var formObj = objTab.find("form[name=statsEasy-mst-form]");
		mixListLen = formObj.find("input[name=TAB_MVAL]").length;
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
			var chkNodes = $("#"+treeId).dynatree("getSelectedNodes");
			for ( d in chkNodes ) {
				data.push(String(chkNodes[d].data.key));
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
		var d, iYear, bCnt, lCnt = 0;
		var iQt = 1;
		
		// 기간 검색 갯수
		iYear = Number(param.obj.find("select[name=wrttimeEndYear]").val()) - Number(param.obj.find("select[name=wrttimeStartYear]").val()) + 1;	//종료년 - 시작년 + 1(자기자신은 +1)
		if ( dtacycleCnt() > 1 ) {
			// 검색주기가 년도 이상부터 쿼터 존재함.
			iQt = Number(param.obj.find("select[name=wrttimeEndQt]").val()) - Number(param.obj.find("select[name=wrttimeStartQt]").val()) + 1;
		}
		bCnt = iYear * iQt;
		
		// 최근시점인 경우
		lCnt = Number(param.obj.find("input[name=wrttimeLastestVal]").val());
		
		if ( lCnt <= bCnt ) {
			d = lCnt;
		}
		else if ( lCnt > bCnt ) {
			d = bCnt;
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
	
	// 검색주기 * 검색기간 선택항목/분류 갯수
	var cellCnt = dtacycleCnt() * wrttimeCnt() * mixListLen;
	
	// 다운로드 건수 제한
	if ( cellCnt > DOWN_LIMIT_CNT ) {
		if ( param.type> 0 ) {
		}else{
			var objTab = getTabShowObj();
			var formObj = objTab.find("form[name=statsEasy-mst-form]");
			// 레이어 숨김
			formObj.find($(".layerPopup.dvsPop")).hide();
		}
		
		jAlert("조회 건수가 " +commaWon(String(DOWN_LIMIT_CNT))+ "건 이상은 조회 속도 지연 및 서버 부하로 인해 다운로드가 되지 않습니다.  항목을 재설정하여 조회하시기 바랍니다.");
		return false;
		
	// 조회 건수 제한
	} else if ( cellCnt > SEARCH_LIMIT_CNT ) {	

		if ( param.type> 0 ) {
		}else{
			var objTab = getTabShowObj();
			var formObj = objTab.find("form[name=statsEasy-mst-form]");
			// 레이어 숨김
			formObj.find($(".layerPopup.dvsPop")).hide();
		}
		
		$("#confDown").show();
		$("#confAction").hide();
		$("#confirmMsg").text("조회 건수가 " +commaWon(String(SEARCH_LIMIT_CNT))+ "건 이상은 조회 속도 지연 및 서버 부하로 인해 \n다운로드하시기 바랍니다.");
		$(".layerpopup-stat-wrapper").hide();
		$("#confirm-box").show();
		
		$("#confDown").bind("click", function(event) {
			$("#confirm-box").hide();

    		var params = "";
    		var mixList = new Array();
    		
    		// 메인에서 조회시
    		if ( param.type> 0 ) {
    			var formObj = objTab.find("form[name=searchForm]");
    			var objParam = formObj.serializeObject();
    			objParam.statblId = $("#sId").val();
    			objParam.deviceType = "P";
    			objParam.firParam = "";
    			objParam.wrttimeOrder = objParam.searchSort;
    			objParam.dtadvsVal = "OD";
    			objParam.viewLocOpt = "H";
    					     
    			// 선택 항목 값 hidden 값 생성
    			$('#mixListTable').find("input").each(function(index, element) {
    				mixList.push($(this).attr('value'));
    			});
    			objParam.TAB_MVAL = mixList;

    			// Object를 queryString으로 변환한다.
    			params = objParam2Serialize(objParam);
    			
    		// 탭에서 조회시	
    		} else {
    			var formObj = objTab.find("form[name=statsEasy-mst-form]");
    			var objParam = formObj.serializeObject();
    			var statblId = param.obj.find("input[name=statblId]").val();
    					  
    			// 선택 항목 값 hidden 값 생성
    			formObj.find("input[name=TAB_MVAL]").each(function(index, element) {
    				mixList.push($(this).attr('value'));
    			});
    			objParam.TAB_MVAL = mixList;
    			
    			objParam.dtadvsVal = getCheckedTreeDatano("dvs"+param.obj.find("input[name=statblId]").val());
    			
    			// Object를 queryString으로 변환한다.
    			params = objParam2Serialize(objParam);
    		}	
    		
    		$("#dataDown-box").show();
    	    $.fileDownload(com.wise.help.url("/portal/stat/downloadMultiStatSheetData.do"), {
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

/**
 * Serialize 동적 변경
 */
function changeSerialize(values,k,v) {
	var found = false;
	for (i = 0; i < values.length && !found; i++) {
		if (values[i].name == k) { 
			values[i].value = v;
			found = true;
		}
	}
	if(!found) {
		values.push(
			{
				name: k,
				value: v
			}	
		);
	}
	return values;
}

/**
 * 센터 Div Itm 닫기
 */
function centerDivCloseAction(){
	
	if ($('.layout_A').hasClass('box3line')) { //센터 Div OPEN 여부 확인
		$('.layout_A').removeClass('box3line');
		
		$('.lSide .treeBox.size6').css("height", centerDivH);
		$('#treeGrpData').css("height", centerGrpH);
		$('#treeItmData').css("height", centerItmH);
		$('#treeClsData').css("height", centerClsH);
	}
	
	$(".box1s").css('width', '100%');
	$(".box2s").css('width', '100%');
	$(".box3s").css('width', '100%');
	
}

/**
 *  그룹/분류/항목 여부 갯수확인
 */
function centerItmCnt(){
	var itemDispCnt = 3;
	if($(".box1s").css("display") == "none") itemDispCnt--;
	if($(".box2s").css("display") == "none") itemDispCnt--;
	
	return itemDispCnt;
}

////////////////////////////////////////////////////////////////////////////////
//[복수통계 선택항목 Sheet 선언 처리] 복수통계 > 선택항목 AREA
////////////////////////////////////////////////////////////////////////////////
function mixIBSheet(){
	createIBSheet2("mixContainer", "mixContainer", "100%", "250px"); 
	
	gridArr.push({ Text : "구분ID|통계표|"+jsMsg00+"|분류|항목|단위|수록기간", Align : "Center" });
	sheetCols.push({ Type : "Text", SaveName : "sMixval", Width : 0, Align : "Center", Edit : false, Hidden : true, ColMerge : false, RowMerge : false });
	sheetCols.push({ Type : "Text", SaveName : "sStat", MinWidth : 100, Align : "Center", Edit : false, Hidden : false, ColMerge : true, RowMerge : true });
	sheetCols.push({ Type : "Text", SaveName : "sGrp", MinWidth : 60, Align : "Center", Edit : false, Hidden : false, ColMerge : false, RowMerge : false });
	sheetCols.push({ Type : "Text", SaveName : "sCls", MinWidth : 60, Align : "Center", Edit : false, Hidden : false, ColMerge : false, RowMerge : false });
	sheetCols.push({ Type : "Text", SaveName : "sItm", MinWidth : 60, Align : "Center", Edit : false, Hidden : false, ColMerge : false, RowMerge : false });
	sheetCols.push({ Type : "Text", SaveName : "sDanwi", MinWidth : 30, Align : "Center", Edit : false, Hidden : false, ColMerge : false, RowMerge : false });
	sheetCols.push({ Type : "Text", SaveName : "sPeriod", MinWidth : 100, Align : "Center", Edit : false, Hidden : false, ColMerge : false, RowMerge : false });
	
	inData.Data = baseDatas;
	
	with (mixContainer) {
		var cfg = { SearchMode : 0, Page : 10, MouseHoverMode : 1, VScrollMode:0, SelectionRowsMode : 0, MergeSheet : 7, DataRowMerge: 1, ColPage: 20};
		SetConfig(cfg);
		
		InitHeaders(gridArr, {Sort : 0, ColMove : 0, ColResize : 0, HeaderCheck : 1});
		InitColumns(sheetCols);
	}
	
	default_sheet(mixContainer); //디자인 적용
	portal_sheet(mixContainer);	//포털화면 시트 별도 로딩바 생성 안되도록 처리
	
	mixContainer.SetExtendLastCol(1);	// 마지막 컬럼 끝까지 늘린다.		
	mixContainer.FitColWidth();
	mixDataAction();
	
	mixBtnControl();
}

function mixDataAction() {
	if(inData.Data.length > 0)	mixContainer.LoadSearchData(inData, false);
	// 바닥라인 삭제
	$("#mixContainer").find($('.GridMain1 .GridMain2 .GMCountRowBottom')).hide();
	return false;
}

function mixBtnControl(){
	$("#mixUp").click(function(e) { 						//위로이동
		mixContainer.DataMove(mixContainer.GetSelectRow()-1, mixContainer.GetSelectRow());
		return false;                  
	});                                             
	$("#mixDown").click(function(e) {		 			//아래로이동
		mixContainer.DataMove(mixContainer.GetSelectRow()+1, mixContainer.GetSelectRow());
		return false;                              
	});  
	$("#mixReset").click(function(e) {		 			//초기화
		mixContainer.RemoveAll();
		baseDatas = [];
		// 바닥라인 삭제
		$("#mixContainer").find($('.GridMain1 .GridMain2 .GMCountRowBottom')).hide();
		$("#mixCycleVal").val("");
		$("#selcycleCd").val("").prop("selected", true);
		searchCycleNode("treeStatData", "");
		
		// 검색기간 초기화 > 복수통계는 선택항목에 따라 기간을 조절한다.
		settingWrttime();

		return false;                              
	});  
	
	//선택된 시계열 항목 선택 - 넣기
	$("#itmPlus").bind("click", function(event) {
		selectInMixData();
	});
	
	//선택된 시계열 항목 선택 - 빼기
	$("#itmMinus").bind("click", function(event) {
		var mixItm = deleteInMixData();
		
		if(baseDatas.length == 0){
			$("#mixCycleVal").val("");
			$("#selcycleCd").val("").prop("selected", true);
			searchCycleNode("treeStatData", "");
		}
		
		// 검색기간 초기화 > 복수통계는 선택항목에 따라 기간을 조절한다.
		if(mixItm) settingWrttime();
	});
}
////////////////////////////////////////////////////////////////////////////////
//[복수통계 시계열 항목 처리] 시계열 항목을 추가한다.
////////////////////////////////////////////////////////////////////////////////
function selectInMixData(){

	//통계를 선택하지 않으면 안내를 한다.
	var itmLiCnt = $("#treeItmData").find("li").length;
	if(itmLiCnt == 0){
		jAlert(alertMsg10);
		return;
	}
	nodesItm = null;
	nodesCls = null;
	nodesGrp = null;
	itmCnt = 0;
	clsCnt = 0;
	grpCnt = 0;
	mixTitle = "";
	mixStatId = "";
	
	//그룹이 활성화 되어 있을 경우만 해당 트리정보를 가져온다.
	if($(".box1s").css("display") != "none"){
		nodesGrp = $("#treeGrpData").dynatree("getSelectedNodes");
		grpCnt = nodesGrp.length;
		
		if(grpCnt == 0){
			jAlert(alertMsg15);
			return;
		}		
	}
	
	//분류가 활성화 되어 있을 경우만 해당 트리정보를 가져온다.
	if($(".box2s").css("display") != "none"){
		nodesCls = $("#treeClsData").dynatree("getSelectedNodes");
		clsCnt = nodesCls.length;
		
		if(clsCnt == 0){
			jAlert(alertMsg16);
			return;
		}	
	}
	
	//항목은 체크여부만 확인한다.
	nodesItm = $("#treeItmData").dynatree("getSelectedNodes");
	
	itmCnt = nodesItm.length;
	if(itmCnt == 0){
		jAlert(alertMsg17);
		return;
	}
	mixTitle = $("#stat_title").text();
	mixStatId = $("#sId").val();
	
	var mixCycleVal = $("#mixCycleVal").val(); //이미 들어있는 항목 선택 주기값을 가져온다.
	var selCycleVal = $("#dtacycleCd").val(); //선택 검색주기값을 가져온다.
	
	if(mixCycleVal == ""){
		$("#mixCycleVal").val(selCycleVal);
		$("#selcycleCd").val(selCycleVal).prop("selected", true);
		searchCycleNode("treeStatData", selCycleVal);
	}else{
		if(mixCycleVal != selCycleVal){
			jAlert(alertMsg18);
			return;
		}
	}
	
	//$("#itmMix-box").show();
	setTimeout("callMakeMix()", 100);
}

////////////////////////////////////////////////////////////////////////////////
//[복수통계 시계열 항목 처리] 호출함수
////////////////////////////////////////////////////////////////////////////////
function callMakeMix(){
	var makeMixFunction = function() {
		var deferred = $.Deferred();
		
		try {
			var mixItm = makeMixHtml(nodesItm, nodesCls);
			if(mixItm) settingWrttime();
			deferred.resolve('등록완료');
		} catch (err) {
			deferred.reject(err);
		}
		return deferred.promise();
	};
	
	makeMixFunction().done(function(message) {
		mixContainer.RemoveAll();
		inData.Data = baseDatas;
		mixDataAction();
	}).fail(function(error) {
		multiSelDivInit();
		//$("#itmMix-box").hide();
	}).always(function() {
		multiSelDivInit();
		//$("#itmMix-box").hide();
	});

}
////////////////////////////////////////////////////////////////////////////////
//[복수통계 시계열 항목 처리] 시계열 항목을 추가 분류 여부에 따른 항목처리
////////////////////////////////////////////////////////////////////////////////
function makeMixHtml(nodesItm, nodesCls){
	//PC용 Div Table 세팅
	var body = $('#mixListTable tbody');
	//모바일용 Div Table 세팅
	var bodyM = $('#mixListTableM tbody');
	
	var wrttimeDisplay = $("#wrttimeMinYear").val() + " ~ " + $("#wrttimeMaxYear").val();

	//그룹 추가로 인해 로직 변경 2019-04-11
	if(grpCnt > 0){
		//넘어온 그룹선택 트리의  Level를 확인한다.
		for (var g=0; g<nodesGrp.length; g++) {
			if(clsCnt > 0){
				//넘어온 분류선택 트리의  Level를 확인한다.
				for (var i=0; i<nodesCls.length; i++) {
					makeItmData(nodesGrp[g].data.title, nodesGrp[g].data.key, nodesCls[i].data.title, nodesCls[i].data.key, nodesItm, wrttimeDisplay);
				}
			}else{
				//넘어온 항목선택 트리의  Level를 확인한다.
				for (var i=0; i<nodesItm.length; i++) {
					if(checkItmData(mixStatId+"-"+nodesGrp[g].data.key+"--"+nodesItm[i].data.key)){
						baseDatas.push({sMixval: mixStatId+"-"+nodesGrp[g].data.key+"--"+nodesItm[i].data.key, sStat: mixTitle, sGrp: nodesGrp[g].data.title, sCls: "", sItm: nodesItm[i].data.title, sDanwi: nodesItm[i].data.uiNm, sPeriod: wrttimeDisplay});
					}//checkItmData
				}
			}
		}
	}else{
		if(clsCnt > 0){
			//넘어온 분류선택 트리의  Level를 확인한다.
			for (var i=0; i<nodesCls.length; i++) {
				makeItmData('', '', nodesCls[i].data.title, nodesCls[i].data.key, nodesItm, wrttimeDisplay);
			}
		}else{
			//넘어온 항목선택 트리의  Level를 확인한다.
			for (var i=0; i<nodesItm.length; i++) {
				if(checkItmData(mixStatId+"---"+nodesItm[i].data.key)){
					baseDatas.push({sMixval: mixStatId+"---"+nodesItm[i].data.key, sStat: mixTitle, sGrp: "", sCls: "", sItm: nodesItm[i].data.title, sDanwi: nodesItm[i].data.uiNm, sPeriod: wrttimeDisplay});
				}//checkItmData
			}
		}
	}
	
	return true;
}
////////////////////////////////////////////////////////////////////////////////
//[복수통계 시계열 항목 처리] 시계열 항목을 추가  > 분류선택가 있을 경우 항목과 MIX
////////////////////////////////////////////////////////////////////////////////
function makeItmData(viewGrpNm, grpDatano, viewClsNm, clsDatano, nodesItm, wrttimeDisplay){

	//항목선택 트리의 1번째 Level을 확인한다.
	for (var i=0; i<nodesItm.length; i++) {
		if(checkItmData(mixStatId+"-"+grpDatano+"-"+clsDatano+"-"+nodesItm[i].data.key)){
			baseDatas.push({sMixval: mixStatId+"-"+grpDatano+"-"+clsDatano+"-"+nodesItm[i].data.key, sStat: mixTitle, sGrp: viewGrpNm, sCls: viewClsNm, sItm: nodesItm[i].data.title, sDanwi: nodesItm[i].data.uiNm, sPeriod: wrttimeDisplay});
		}//checkItmData
	}
}

////////////////////////////////////////////////////////////////////////////////
//[복수통계 시계열 항목 처리] 시계열 항목을 추가 > 추가시 기존 정보에 해당 항목이 있는지 확인한다. 없으면 true / 있으면 false
////////////////////////////////////////////////////////////////////////////////
function checkItmData(chkData){
	var returnVal = true;
	if(baseDatas.length > 0){
		$.each(baseDatas, function(key, value){
			if(value.sMixval == chkData) returnVal = false;
		});
	}
	return returnVal;
}

////////////////////////////////////////////////////////////////////////////////
//[복수통계 시계열 항목 처리] 선택된 시계열 항목을 제거한다.
////////////////////////////////////////////////////////////////////////////////
function deleteInMixData(){

	if(mixContainer.GetSelectCol() > 1){
		mixContainer.RowDelete(mixContainer.GetSelectRow());
		baseDatas.splice(mixContainer.GetSelectRow()-1, 1);
	}else{
		var chkCnt = 1;
		var delCnt = 0;
		var chkSid = "";
		var isStop = false;
		var delIndex, delIndexCnt;
		$.each(baseDatas, function(key, value){
			if(!isStop){
				var sMixval = value.sMixval.split("-");
				if(chkCnt == mixContainer.GetSelectRow()){
					delCnt = chkCnt;
					chkSid = sMixval[0];		
					mixContainer.RowDelete(delCnt);
					delIndex = chkCnt - 1;
					delIndexCnt = 1;
				}else{
					if(chkSid != ""){
						if(chkSid == sMixval[0]){
							mixContainer.RowDelete(delCnt);
							delIndexCnt++;
						}else{
							isStop = true;
						}
					}
				}
				chkCnt++;
			}
		});
		baseDatas.splice(delIndex, delIndexCnt);
	}

	return true;
}

////////////////////////////////////////////////////////////////////////////////
//[복수통계 시계열 항목 처리] 검색기간 Setting
////////////////////////////////////////////////////////////////////////////////
function settingWrttime(){
	var wrtData = new Array();
	var valWrtArray = new Array();
	
	if(baseDatas.length > 0){
		$.each(baseDatas, function(key, value){
			valWrtArray.push(value.sPeriod);
		});
		wrtData =valWrtArray.reduce(function(a, b){ if(a.indexOf(b) < 0) a.push(b); return a; },[]);
		
		var minWrtYear = new Date().getFullYear();
		var maxWrtYear = new Date().getFullYear();
		//먼저 년도 최소값과 최대값을 뽑아낸다.
		for(var i=0; i<wrtData.length; i++){
			var wrtDataVals = wrtData[i].split(" ~ ");
			if(wrtDataVals[0] < minWrtYear) minWrtYear = wrtDataVals[0];
			if(wrtDataVals[1] > maxWrtYear) maxWrtYear = wrtDataVals[1];
		}
		
		//복수통계 선택항목에 따라 기간 년도를 설정한다.
		$("select#wrttimeStartYear option").remove();
		$("select#wrttimeEndYear option").remove();
		for(var y=minWrtYear; y<=maxWrtYear; y++){
			$("select#wrttimeStartYear").append("<option value='"+y+"'>"+y+"년</option>");
			$("select#wrttimeEndYear").append("<option value='"+y+"'>"+y+"년</option>");
		}
		$("#wrttimeStartYear").val(minWrtYear);
		$("#wrttimeEndYear").val(maxWrtYear);
	}else{
		// 검색기간 초기화 > 복수통계는 선택항목에 따라 기간을 조절한다.
		$("select#wrttimeStartYear option").remove();
		$("select#wrttimeEndYear option").remove();
		$("select#wrttimeStartYear").append("<option value=''>-</option>");
		$("select#wrttimeEndYear").append("<option value=''>-</option>");
	}
	
} 
