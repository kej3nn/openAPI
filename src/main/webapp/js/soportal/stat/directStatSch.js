/*
 * @(#)directStatSch.js 1.0 2018/06/25
 */

/**
 * 통계조회 관련 스크립트 파일이다.
 * 
 * @author 김정호
 * @version 1.0 2018/06/25
 */
// //////////////////////////////////////////////////////////////////////////////
// 글로벌 변수
// //////////////////////////////////////////////////////////////////////////////
var isMobile = $(window).width() <= 980 ? true : false; // 모바일 접근 여부
var isFirst = false; 		// 최초 조회 여부(파라미터로 통계표 ID 넘어와서 조회한 경우)
var dtadvsLoc = null; 		// 단위 위치
var MOBILE_CD = "M";		// 모바일 코드
var PC_CD = "P";			// PC 코드

var gridH;
var nodeList = [];
var selectNode = "";
var chartId = "statChart";

var confirmAction = "";
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

	$(window).resize(function() {
		remarkInit();
		contReSize();	// 통계 컨턴츠 창사이즈의 따른 액션
	});
	// GNB메뉴 바인딩한다.
	if(window.location.href.indexOf("nabocit")> -1) menuOn(3, 1);
	else menuOn(1, 1);
	
});

////////////////////////////////////////////////////////////////////////////////
// 초기화 함수
////////////////////////////////////////////////////////////////////////////////
/**
 * 컴포넌트를 초기화한다.
 */
function initComp() {
	
	if ( gfn_isNull($("#statSearchVal").val()) ) {
		loadMainPage();
	} else {
		//통합검색에서 검색어가 넘어온 경우 검색된 항목을 표시한다.
		loadMainPage(true);
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
	
	// 통계표 바로접근시 사용하는 변수
	var cnt = 0;
	var sCate = getParam("sCate") || "";
	var node = null;
	
	var statblId = $("#sId").val();
	var searchWord = $("#statSearchVal").val();
    
	searchWord = htmlTagFilter(searchWord);
	if(searchWord == false){
		$("#statSearchVal").val("");
		searchWord = "";
	}
	
	$("#searchVal").val(searchWord);
	
	/* 검색하였거나, PC이거나, 검색어가 있는경우 */
	if (searchFlag && !isMobile && ( !gfn_isNull($("#searchVal").val()) || !gfn_isNull($("#hdnKeywordVal").val()) ) ) {
		// PC에서 조회한 경우
		loadMainMobileList($("#commonForm [name=page]").val());
		loadMainSearchList();

		// 검색어가 있을경우 메인 트리는 추가로 보여준다.
		if ( searchWord ) {
			$("#searchVal").val("");	// 전체 조회되도록 값 초기화 후
			
			$.when(loadMainTreeList("SUBJ")).done(
				function(r1) {
					$("#searchVal").val(searchWord);	// 완료 후 다시 값 넣어준다.
				});
		}
		
	} else {
		loadMainMobileList($("#commonForm [name=page]").val());
		//2018.07.04 모바일 통계주제별 통계표 조회 추가
		var gubun = $("#statGb").val() == "" ? "SUBJ" : $("#statGb").val();
		loadMainTreeList(gubun);
	}
	
	// url로 통계표 입력후 접근하였을경우 해당 통계표를 바로 보여준다.
	if (!com.wise.util.isBlank(statblId)) {
		setTimeout(function() {
			// 통계표로 바로 왔을경우 동일한 KEY값이 있는지 체크한다.(다중분류일경우 동일 KEY값 존재함)
			$("#treeStatData").dynatree("getRoot").visit(function(dtnode){
	            if ( dtnode.data.key == statblId && !com.wise.util.isNull(sCate) ) cnt++;
	        });
			
			if ( cnt > 1 ) {
            	$("#treeStatData").dynatree("getRoot").visit(function(dtnode){
    	            if ( dtnode.data.key == statblId && dtnode.data.parStatblId == sCate ) {
    	            	node = dtnode;
    	            }
    	        });
            	
            	if ( node == null ) {
            		node = $("#treeStatData").dynatree("getTree").getNodeByKey(statblId);
            	}
            }
            else {
            	node = $("#treeStatData").dynatree("getTree").getNodeByKey(statblId);
            }

			node.activate();	// 선택처리 제거(바로 조회하지 않도록)	
			
			setTimeout(function() {	
				node.focus();
				if ( node.data.parStatblId == "T" ) {
					// 1레벨 분류만 스크롤 위치 이동(선택한 노드가 맨 스크롤 맨 위로 가도록)
					$("#treeStatData").scrollTop(node.li.offsetTop-56);
				}
			}, 100);	// 해당 포커스로 이동
			if ( isMobile ) {
				$(".leftArea").hide();
				$(".rightCont").show();
			}
		}, 1500);
	}
}
/**
 * PC 메인 통계표 목록 트리 리스트
 */
function loadMainTreeList(gubun) {
	/**
	 * gubun == "SUBJ" 	//주제별 
	 * gubun == "NAME" 	//통계명(명칭별)
	 * gubun == "NABOCIT" //국회위원회별
	 * gubun == "ORIGIN" //출처별
	 */
	$("#statGb").val(gubun);
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
			return {statblId : $("#sId").val(),langGb : $("#langGb").val(), statGb:$("#statGb").val() } 
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
		statGb : $("#statGb").val(), //2018.07.04 모바일 통계주제별 통계표 조회 추가
		treeCateId : $("#treeCateId").val()		// 분류ID
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
				
				selStat($(this).find("a").attr('name'));
				
				if ( isMobile ) {
					$('.leftArea').hide();
				}
				else {
					$('.leftArea').show();
				}
			});
		});
	} else {
		$("#" + id + " ul").empty().append($(mbListTemplate.none));
	}
	
	// left bar 숨김/표시 이벤트
	$(".left_bar").bind("click", function(e) {
		if ( $(".rightCont").css("display") != "none" ) {	// 컨텐츠 내용이 있는 상태에서
			$("#schTitTxt").toggle();
			$(".leftArea").toggleClass("leftnone");
			$(this).find("a").toggleClass("on");
			$("#leftTreeBox").css("height", $(".rightCont .content_body").height());
			
			// 차트 resize
			if($('#statChart').highcharts() != undefined) chartResize("statChart");
			// 지도 resize
			if ($('#statMap').highcharts() != undefined)  chartResize("statMap");
		}
	});
}
////////////////////////////////////////////////////////////////////////////////
// 액션 처리 함수들
////////////////////////////////////////////////////////////////////////////////
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
 * 통계 조회 탭 Sheet 생성
 * @Param sheetNm	통계표 시트명
 */
function statSheetCreate() {
	
	var formObj = $("form[name=statsEasy-mst-form]");
	
	statSheet.Reset();
	
	/* 통계 시트 컬럼 세팅(헤더설정) */
	loadEasySheet();

	var param = formObj.serialize();

	var params = {
		PageParam : "ibpage",
		Param : "onepagerow=50&statblId=" + $("#sId").val()
	};
	statSheet.SetWaitImageVisible(0);	//조회중 이미지 보이지 않게 설정
	
	statSheet.DoSearchPaging(com.wise.help.url("/portal/stat/directStstPreviewList.do"), params);

	// 조회 완료 후 시트 및 차트의 사이즈 조절
	remarkInit();
}


/**
 * 통계 시트 컬럼 세팅(헤더설정)
 * @param sheetNm	통계표 시트명
 * @param sheetobj	시트객체
 */
function loadEasySheet() {
	var formObj = $("form[name=statsEasy-mst-form]");

	var gridArr = [];
	var iArr = null;
	var sheetCols = [];

	// 파라미터로 접근 한 경우 java에서 넘어온 파라미터값으로 param 값 넘겨준다.
	var params = "statblId=" + $("#sId").val();

	$.ajax({
			url : com.wise.help.url("/portal/stat/directStatTblItm.do"),
			async : false,
			type : 'POST',
			data : params,
			dataType : 'json',
			beforeSend : function(obj) {
				//showLoading();	//조회중 표시
			}, // 서버 요청 전 호출 되는 함수 return false; 일 경우 요청 중단
			success : function(data) {
				var text = data.data.Text; // 헤더 컬럼 text 정보
				var cols = data.data.Cols; // 헤더 컬럼 속성정보
				var cmmtRowCol = data.data.cmmtRowCol;
				var loadDtadvsLoc = data.data.dtadvsLoc;
				var frozenCol = 0;		// 열고정 할 컬럼위치
				var saveName = "";
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
					
					// 컬렴 열고정 할 컬럼 갯수 확인
					saveName = cols[c].SaveName;
					if ( saveName.indexOf("COL_") < 0 ) {
						frozenCol++;
					}
				}

				with (statSheet) {
					var cfg = { SearchMode : 0, Page : 10, MouseHoverMode : 1, VScrollMode:0, SelectionRowsMode : 0, MergeSheet : 7, DataRowMerge: 1, ColPage: 20, FrozenCol: frozenCol, TouchScrolling: 1 };

					SetConfig(cfg);
					
					InitHeaders(gridArr, {Sort : 0, ColMove : 0, ColResize : 0, HeaderCheck : 0});
					InitColumns(sheetCols);
				}

				default_sheet(statSheet);
				portal_sheet(statSheet);	//포털화면 시트 별도 로딩바 생성 안되도록 처리

				// 헤더에 주석식별자 입력
				for ( var cmmt in cmmtRowCol) {
					statSheet.SetHtmlHeaderValue(cmmtRowCol[cmmt].row, cmmtRowCol[cmmt].col, cmmtRowCol[cmmt].cmmt);
				}

				// 통계자료 행or열 숨김 처리(원자료만 있는 경우)
				if ( loadDtadvsLoc.LOC != "" ) {
					dtadvsLoc = loadDtadvsLoc
				}
				
				statSheet.SetExtendLastCol(1);		// 마지막 컬럼 끝까지 늘린다.
				statSheet.SetFocusAfterProcess(0);	// 데이터 로드 후 포커스를 설정하지 않도록 설정
				statSheet.SetCountPosition(0);		// 카운트 정보 표시안함
				
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
function statSheet_OnSearchEnd(code, message, statusCode, statusMessage) {
	var formObj = $("form[name=statsEasy-mst-form]");
	var sheetObj = window["statSheet"];

	// 통계자료 hidden 처리(원자료만 존재할 경우)
	if (dtadvsLoc.LOC != "") {
		if (dtadvsLoc.LOC == "HEAD") {
			sheetObj.SetRowHidden(dtadvsLoc.CNT, 1);
		} else if (dtadvsLoc.LOC == "LEFT") {
			sheetObj.SetColHidden(dtadvsLoc.CNT, 1);
		}
	}
	
	//  좌측헤더고정 설정값 처리
	var chkFrozenCol = formObj.find("#chkFrozenCol");
	if ( chkFrozenCol.is(":checked") ) {
		for ( var i=0; i < sheetObj.LastCol(); i++ ) {
			if ( sheetObj.ColSaveName(i).indexOf("COL_") > -1 ) {
				sheetObj.SetFrozenCol(i);
				break;
			}
		}
	}
	else {
		sheetObj.SetFrozenCol(0);
	}
	
	sheetObj.SetHeaderRowHeight(23);			// 헤더 높이

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
		//messageDivCloseFocus(alertboxFocus)
		$("#alert-box-focus").val("");
	}
	
	// 20180508/김정호 - confirm 메시지 박스 포커스
	var confirmboxFocus = $("#confirm-box-focus").val();
	if ( !gfn_isNull(confirmboxFocus) ) {
		//messageDivCloseFocus(confirmboxFocus)
		$("#confirm-box-focus").val("");
	}
}

/**
 * 포털 액션시 로그를 남김
 * @Param	type 액션타입 
 */
function insertStatLogs(param) {
	var url = "/portal/stat/insertLogSttsTbl.do";
	
	param["simmixTag"] = "B";
	param["sysTag"] = "K";
	
	if ( !gfn_isNull(url) ) {
		doAjax({url: url, params: param});
	}
}

/**
 * 한글다운로드 로그를 남김
 * @Param	type 액션타입 
 */
function insertStatHwpDownLogs(param) {
	var url = "/portal/stat/insertLogSttsHwp.do";
	
	param["simmixTag"] = "B";
	param["sysTag"] = "K";
	
	if ( !gfn_isNull(url) ) {
		doAjax({url: url, params: param});
	}
}

/**
 * 포털에서 시트 데이터 다운로드 하는 서비스 => 5가지 파일형식 모두 Down2Excel 공통으로 사용(sheet의 데이터구조 그대로
 * 활용하기 위해)
 */
function PortalDownFile(type, fileNm) {
	var formObj = $("form[name=statsEasy-mst-form]");

	var url = "";
	switch (type) {
	case "EXCEL":
		url = com.wise.help.url("/portal/stat/directDown2Excel.do");
		break;
	case "CSV":
		url = com.wise.help.url("/portal/stat/directDown2Csv.do");
		break;
	case "JSON":
		url = com.wise.help.url("/portal/stat/directDown2Json.do");
		break;
	case "XML":
		url = com.wise.help.url("/portal/stat/directDown2Xml.do");
		break;
	case "TXT":
		url = com.wise.help.url("/portal/stat/directDown2Text.do");
		break;
	default:
		jAlert(alertMsg13);
		return;
		break;
	}
	var params = {
		URL : url,
		ExtendParam : "statblId=" + $("#sId").val() + "&statTitle=" + encodeURIComponent($("#contTitle").text()) + "&fileNm=" + fileNm + "&sysTag=K",
		ExtendParamMethod : "POST",
		SheetDesign : 1,
		Merge : 1,
		Mode : -1,
		NumberFormatMode : 1,
		FileName : fileNm + ".xls",
		SheetName : "excelsheet",
		Multipart : 0
	};
	
	statSheet.Down2Excel(params);
	statSheet.HideProcessDlg();
}

/**
 * 시트 및 차트화면의 사이즈 조절 
 */
function remarkInit() {

	var ww = $(window).width();
	var hh = $(window).height();
	var isWidePC = $('body').hasClass('wide');	// PC에서 전체화면 여부(true면 전체화면)
	var isWideMobile = $("body").hasClass("wideMobile");	// 모바일에서 전체화면여부(true면 전체화면)
	
	var sheetPcHeight = 416;
	
	if ( isWideMobile ) {
		$("#statTbl-sect").css("height", hh-52);
		statSheet.SetSheetHeight(hh-140);
	}
	else {
		$("#statTbl-sect").css("height", sheetPcHeight);
		statSheet.SetSheetHeight(288);
	}
	
	var statChart = $("#statChart");
	var chartObj = statChart.highcharts();
	if ( !gfn_isNull(chartObj) ) {
		chartObj.setSize(statChart.width(), null, false);
	}
	
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
		statSheet.FitSizeCol(0); //모바일화면에서 가로/세로보기에 따라 사이즈 재조정
		$("#stat-pager-sect").show();
		statSheet.SetHeaderRowHeight(23);	// 사이즈 조절시 시트 헤더 높이가 자기 맘대로 조절됨.ㅠㅠ 강제로 설정..
	}
}

////////////////////////////////////////////////////////////////////////////////
//이벤트 관련 함수들
////////////////////////////////////////////////////////////////////////////////
/**
* 통계화면 컨트롤 정의
*/
function eventControl() {
	
	var formObj = $("form[name=statsEasy-mst-form]");
	
	// 통계표 조회
	$("button[name=btn_statInquiry]").bind("click", function(event) {
		$("#sId").val("");
		loadMainPage(true);
		return false;
	});
	// 통계표 조회 enter
	$("input[name=statSearchVal]").bind("keydown", function(event) {
		// 엔터키인 경우
		if (event.which == 13) {
			$("#sId").val("");
			loadMainPage(true);
			return false;
		}
	});
	// 전체목록받기
	$("button[name=btn_statExcelDwon]").bind("click", function(event) {
		doStatExcelDown();
	});
	
	// 모바일 통계주제 선택
	$("#mbSubject").change(function() {
		$("#commonForm").find("[name=page]").val("1");
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
		
		// 닫기 버튼 눌렀을때 모바일 리스트 재 검색(반응형 때문에.....)
		loadMainMobileList($("#commonForm [name=page]").val());
		
		return false;
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
		
		// 닫기 버튼 눌렀을때 모바일 리스트 재 검색(반응형 때문에.....)
		loadMainMobileList($("#commonForm [name=page]").val());
		
		return false;
	});
	// 메인 검색결과 팝업 닫기
	$("#searchResultClose").bind("click", function(event) {
		$("#sId").val(""); // 통계표 ID
		$("#stat_title").text(""); // title 초기화
		$("#searchVal, #statSearchVal").val(""); // 검색값 초기화
		$("#searchResult li").remove(); // 검색한 항목 삭제
		$("#searchResult").hide();

		// 닫기 버튼 눌렀을때 모바일 리스트 재 검색(반응형 때문에.....)
		loadMainMobileList($("#commonForm [name=page]").val());
		
		return false;
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
			
		} else {
			$('body').addClass('wide');
			$('.container.hide-pc-lnb').css("max-width", "100%");
			
			$(this).text(jsMsg10);
			header.hide();
			loc.hide();
			tit.hide();
			footer.hide();
		}
		
		// 통계명 탭 선택시 사이즈 조절
		if ( $(".rightCont .content_body").height() > 0 ) {	// 최초화면(트리에 선택된 값이 없을경우)
			if ( $("#tabNm").hasClass("on") ) {		// 통계명 선택시
				$("#leftTreeBox").css("height", $(".rightCont .content_body").height() -25);
			}
			else {
				$("#leftTreeBox").css("height", $(".rightCont .content_body").height());
			}
		}
		else {
			if ( $("#tabNm").hasClass("on") ) {
				$("#leftTreeBox").css("height", wHeight - 212);
			}
			else {
				$("#leftTreeBox").css("height", wHeight - 184);
			}
		}
		
		remarkInit();
	});
	
	$(".btn-layerpopup-close02").on("click", function() {
		$("body").addClass("remove-body");
		$(".layerpopup-stat-wrapper").hide();
	});
	
	// 통계컨텐츠 탭 눌렀을경우 해당 focus로 이동
	$(".content_tab ul li").each(function(index, element) {
		$(this).bind("click", function(event) {
			$(".content_tab ul li").removeClass("on");
			$(this).addClass("on");
			$('html, body').animate({scrollTop : $("#"+ $(this).attr("data-link")).offset().top + -70}, 100);	// 스크롤 이동
		});
	});
	
	// 다운로드[XLS] 버튼
	formObj.find("button[name=downXLS]").bind("click", function(event) {
		PortalDownFile("EXCEL", "excel");
		return false;
	});
	/* 숨김처리
	// 다운로드[CSV] 버튼
	formObj.find("button[name=downCSV]").bind("click", function(event) {
		PortalDownFile("CSV", "csv");
		return false;
	});
	// 다운로드[JSON] 버튼
	formObj.find("button[name=downJSON]").bind("click", function(event) {
		PortalDownFile("JSON", "json");
		return false;
	});
	// 다운로드[XML] 버튼
	formObj.find("button[name=downXML]").bind("click", function(event) {
		PortalDownFile("XML", "xml");
		return false;
	});
	// 다운로드[TXT] 버튼
	formObj.find("button[name=downTXT]").bind("click", function(event) {
		PortalDownFile("TXT", "txt");
		return false;
	});*/
	// 다운로드[HWP] 버튼
	formObj.find("button[name=downHWP]").bind("click", function(event) {		 
		
		var statblId = $("#sId").val();
		
		var hwpColArray = new Array();
		
		for(var idx = 0; idx < statSheet.LastCol() + 1; idx++){
			if(!statSheet.GetColHidden(idx)){
				hwpColArray.push(idx);
			}
		}
		
		var docTitle = $("#contTitle").text();
		
		var params = {
   	           Title:{ Text:docTitle, Align:"Center"},
   	           DocOrientation:"Landscape",
   	           DownCols: hwpColArray.join("|"),
					FileName: docTitle
    	} ;
		
		//통계표 다운로드(HWP) 로그 남김
		insertStatHwpDownLogs({statMulti: "N", statblId: statblId});
		
		statSheet.Down2Hml(params);
		return false;
	});
	
	// 모바일 목록버튼
	$("#btnMobileList").bind("click", function(event) {
		$(".leftArea").show();
		$(".rightCont").hide();
		$("#sId").val("");
		return false;
	})
	
	// 시트 컬럼 열 고정/해제
	formObj.find("#chkFrozenCol").bind("change", function(event) {
		var statblId = formObj.find($("input[name=statblId]")).val();
		var sheetObj = window["statSheet"];

		if ( sheetObj.GetFrozenCol() > 0 ) {
			sheetObj.SetFrozenCol(0);
		}
		else {
			for ( var i=0; i < sheetObj.LastCol(); i++ ) {
				if ( sheetObj.ColSaveName(i).indexOf("COL_") > -1 ) {
					sheetObj.SetFrozenCol(i);
					break;
				}
			}
		}
		sheetObj.SetHeaderRowHeight(23);	// 열고정시 시트 헤더 높이가 자기 맘대로 조절됨.ㅠㅠ 강제로 설정..
		return false;
	});
	
	// 상세페이지 모바일에서 fullsize
	formObj.find(".mobile_wide_btn a").on("click", function() {
		var body = $("body").hasClass("wideMobile");
		if(body) {
			$(this).text("전체화면");
			$(".mobile_wide_btn").removeClass("scroll");
			$(".mobile_wide_btn").css("top", "6px");
		}else {
			$(this).text("기본화면");
			$(".mobile_wide_btn").addClass("scroll");
			var currentPosition = parseInt($(".mobile_wide_btn").css("top")); 
			$(window).scroll(function() { 
				var position = $(window).scrollTop(); 
				$(".scroll").stop().animate({"top":position+currentPosition+"px"},1000); 
			});
		}
		$("body").toggleClass("wideMobile");
		remarkInit();
	});
	
	/*************************************************************************************/
	/* 차트 버튼 이벤트 처리 START */
	
	// 차트 다운로드 버튼
	formObj.find("button[name=chartDownload]").bind("click", function(event) {
		
		if (!formObj.find($('.dropdown-content')).hasClass('down')) {
			formObj.find($('.dropdown-content')).addClass('down');
			formObj.find($('.dropdown-content')).show();
		} else {
			formObj.find($('.dropdown-content')).removeClass('down');
			formObj.find($('.dropdown-content')).hide();
		}
		return false;
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

	// 차트 범례 버튼 
	formObj.find("button[name=remarkControl]").bind("click", function(event) {
		
		if (!formObj.find($('.content_graph')).hasClass('remark')) {
			formObj.find($('.content_graph')).addClass('remark');
			formObj.find($('.remark-content')).show();
		} else {
			formObj.find($('.content_graph')).removeClass('remark');
			formObj.find($('.remark-content')).hide();
		}
	});
	// 차트 범례 버튼 -> 범례보이기
	formObj.find("a[name=remarkShow]").bind("click", function(event) {
		for (var i = 0; i < hightChart.series.length-1; i++) {
			hightChart.series[i].update({
				showInLegend : true
			});
		}
		$(this).parents('li').hide();
		formObj.find("a[name=remarkHide]").parents('li').show();
	});
	// 차트 범례 버튼 -> 범례숨기기
	formObj.find("a[name=remarkHide]").bind("click", function(event) {
		for (var i = 0; i < hightChart.series.length-1; i++) {
			hightChart.series[i].update({
				showInLegend : false
			});
		}
		$(this).parents('li').hide();
		formObj.find("a[name=remarkShow]").parents('li').show();
	});
	// 차트 범례 버튼 -> 범례 전체선택
	formObj.find("a[name=legAllChk]").bind("click", function(event) {
        var series =  hightChart.series;
        for(i=0;i<series.length;i++) {
            series[i].show();
        }
	});
	// 차트 범례 버튼 -> 범례 전체선택해제
	formObj.find("a[name=legAllNon]").bind("click", function(event) {
        var series =  hightChart.series;
        for(i=0;i<series.length;i++) {
            series[i].hide();
        }
	});
	
/*	// 차트 범례 버튼
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
	});*/

	/*	// HISTROY || SCROLL 버튼
	formObj.find("button[name=chartStockType]").bind("click", function(event) {
		//기본 차트정보 호출
		var imgSrc = $(this).children("img").attr("src");
		if (imgSrc.indexOf("charbtn02_on.png") != -1) {
			$(this).children("img").attr("src", "/images/soportal/chart/charbtn02on.png");
			formObj.find("input[name=chartStockType]").val("SCROLL");
			hightChart.options.xAxis[0].min = 0;
			var maxCateCnt = hightChart.options.xAxis[0].max < 5 ? hightChart.options.xAxis[0].max : 4;
			hightChart.options.xAxis[0].max = maxCateCnt;
			hightChart.options.navigator.enabled = false;
			hightChart.options.scrollbar.enabled = true;
			hightChart = Highcharts.chart(chartId, hightChart.options);
		}else{
			$(this).children("img").attr("src", "/images/soportal/chart/charbtn02_on.png");
			formObj.find("input[name=chartStockType]").val("HISTORY");
			delete(hightChart.options.xAxis[0].min);
			delete(hightChart.options.xAxis[0].max);
			hightChart.options.navigator.enabled = true;
			hightChart.options.scrollbar.enabled = false;
			hightChart = Highcharts.chart(chartId, hightChart.options);
		}
	}); 히스토리 & 스크롤 동시 노출로 변경 */

	// 2D || 3D 버튼
	formObj.find("button[name=chartViewType]").bind("click", function(event) {
		//기본 차트정보 호출
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
		statChartCreate("", chartId);
		$("[name=chartType], [name=chartStockType]").val("");	// 차트 변수 초기화1
		$("[name=chart23Type]").val("2D");	// 차트 변수 초기화2
		chartButtonReset("charbtn19");
	});
	
	//버튼선택에 따른 초기화
	function chartButtonReset(selNum){
		$(".chartMenu").find("button").each(function(event){
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
		statChartCreate("spline", chartId);
		formObj.find("input[name=chartType]").val("spline");
		chartButtonReset("charbtn04");
	});
	// 꺽은선
	formObj.find("button[name=chartLine]").bind("click", function(event) {
		statChartCreate("line", chartId);
		formObj.find("input[name=chartType]").val("line");
		chartButtonReset("charbtn05");
	});
	// 누적영역
	formObj.find("button[name=chartArea]").bind("click",	function(event) {
		statChartCreate("area", chartId);
		formObj.find("input[name=chartType]").val("area");
		chartButtonReset("charbtn06");
	});
	// 막대
	formObj.find("button[name=chartHbar]").bind("click", function(event) {
		statChartCreate("column", chartId);
		formObj.find("input[name=chartType]").val("column");
		chartButtonReset("charbtn07");
	});
	// 누적막대
	formObj.find("button[name=chartAccHbar]").bind("click", function(event) {
		statChartCreate("accolumn", chartId);
		formObj.find("input[name=chartType]").val("accolumn");
		chartButtonReset("charbtn08");
	});
	// 퍼센트누적막대
	formObj.find("button[name=chartPAccHbar]").bind("click", function(event) {
		statChartCreate("pccolumn", chartId);
		formObj.find("input[name=chartType]").val("pccolumn");
		chartButtonReset("charbtn09");
	});
	// 가로막대
	formObj.find("button[name=chartWbar]").bind("click", function(event) {
		statChartCreate("bar", chartId);
		formObj.find("input[name=chartType]").val("bar");
		chartButtonReset("charbtn10");
	});
	// 가로누적막대
	formObj.find("button[name=chartAccWbar]").bind("click",	function(event) {
		statChartCreate("acbar", chartId);
		formObj.find("input[name=chartType]").val("acbar");
		chartButtonReset("charbtn11");
	});
	// 퍼센트가로누적막대
	formObj.find("button[name=chartPAccWbar]").bind("click", function(event) {
		statChartCreate("pcbar", chartId);
		formObj.find("input[name=chartType]").val("pcbar");
		chartButtonReset("charbtn12");
	});
/*	// 차트 듀얼
	formObj.find("button[name=chartDual]").bind("click", function(event) {
		var chartId = formObj.find($(".chart.statEasyChart")).attr('id');
		statChartCreate("dual", chartId);
		formObj.find("input[name=chartType]").val("dual");
		chartButtonReset("charbtn13");
	});
*/	// 차트 파이
	formObj.find("button[name=chartPie]").bind("click", function(event) {
		statChartCreate("pie", chartId);
		formObj.find("input[name=chartType]").val("pie");
		chartButtonReset("charbtn13");
	});
	// 차트 도넛
	formObj.find("button[name=chartDonut]").bind("click",function(event) {
		statChartCreate("donut", chartId);
		formObj.find("input[name=chartType]").val("donut");
		chartButtonReset("charbtn14");
	});
	// 차트 TreeMap
	formObj.find("button[name=chartTreeMap]").bind("click",function(event) {
		statChartCreate("treemap", chartId);
		formObj.find("input[name=chartType]").val("treemap");
		chartButtonReset("charbtn15");
	});
	// 차트 SpiderWeb
	formObj.find("button[name=chartSpiderWeb]").bind("click",function(event) {
		statChartCreate("spiderweb", chartId);
		formObj.find("input[name=chartType]").val("spiderweb");
		chartButtonReset("charbtn16");
	});
	// 차트 Sunburst
	formObj.find("button[name=chartSunburst]").bind("click",function(event) {
		statChartCreate("sunburst", chartId);
		formObj.find("input[name=chartType]").val("sunburst");
		chartButtonReset("charbtn17");
	});
/*	// 차트 다운로드 버튼
	formObj.find("button[name=chartDownload]").bind("click", function(event) {
		if (!formObj.find($('.chart')).hasClass('down')) {
			formObj.find($('.chart')).addClass('down');
			formObj.find($('.dropdown-content')).show();
		} else {
			formObj.find($('.chart')).removeClass('down');
			formObj.find($('.dropdown-content')).hide();
		}
	});*/
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
	
	// Chart & Map tab 이벤트 
	$('.tabSt li').on('click', function() {
		var id = $(this).find('a').attr('href');
		$('.tabSt li').removeClass('on');
		$(this).addClass('on');
		if(id == "#chartTab") {
			$(".chartMenu").show();
			$("#statChart").show();
			$(".maparea").hide();
		} else { //mapTab
			$(".chartMenu").hide();
			$("#statChart").hide();
			$(".maparea").show();
			
			//맵 로드
			loadMap("statMap", $(".areaDv").find("input[name=tabMapVal]").val(), "S");
		}
		return false;
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

//통계 컨턴츠 창사이즈의 따른 액션
function contReSize(){
	var sId = $("#sId").val();

	if (!isMobile) {
		$(".leftArea").show();
		if (sId) {
			$(".rightCont").show();
		} else {
			$(".rightCont").hide();
		}
	} else {
		if (sId != "") {
			$(".leftArea").hide();
			$(".rightCont").show();

			if ($("#detailAnalysis").is(":visible"))
				$("#detailAnalysis").css("display", "");
			else
				$("#detailAnalysis").css("display", "none");

			if ($("#statDic").is(":visible"))
				$("#statDic").css("display", "");
			else
				$("#statDic").css("display", "none");

			// 모바일일경우 버튼 틀어져서 조절
			if ($("#fileDownload").is(":visible"))
				$("#fileDownload").css("display", "");
			else
				$("#fileDownload").css("display", "none");
			if ($("#fileSelect").is(":visible"))
				$("#fileSelect").css("display", "");
			else
				$("#fileSelect").css("display", "none");

		} else {
			$(".leftArea").show();
			$(".rightCont").hide();
		}
	}
	
	// 글로벌 변수 수정(모바일 여부)
	isMobile = $(window).width() <= 980 ? true : false;
}
