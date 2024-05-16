/*
 * @(#)easyStatSchPop.js 1.0 2019/07/25
 */
/**
 * 간편통계 팝업 관련 메인 스크립트 파일이다.
 * 
 * @author JHKIM
 * @version 1.0 2019/07/25
 */
// //////////////////////////////////////////////////////////////////////////////
// 글로벌 변수
// //////////////////////////////////////////////////////////////////////////////
var isMobile = $(window).width() <= 980 ? true : false; // 모바일 접근 여부
var isFirst = true; 		// 최초 조회 여부
var dtadvsLoc = null; 		// 단위 위치
var MOBILE_CD = "M";		// 모바일 코드
var PC_CD = "P";				// PC 코드

var selectNode = "";
var GC_SHEET_NM 	= "statSheet";
var GC_CHART_NM 	= "statChart";
var GC_SLIDER_NM 	= "statSlider";
var GC_MAP_NM 		= "statMap";

var TREE_CHK_LIMIT_CNT = 500;	// 트리 체크 제한 갯수
var SEARCH_LIMIT_CNT = 20000;	// 셀 검색 제한 갯수
var DOWN_LIMIT_CNT = 200000;	// 셀 다운로드 제한 갯수
var confirmAction = "";

/**
 * 연관데이터셋 템플릿
 */
var templates2 = {
	    data:
	        "<li><a href=\"#none\">"                                                       +
	            "<span class=\"img\"><img src=\"\" alt=\"\" class=\"thumbnail_dataSet metaImagFileNm\"></span>" +
	            "<div class=\"dataset_boxlist\">"                                               				+
	            "<div class=\"dataset_box_text\">"                                               					+
	            "<em class=\"m_cate\">의정활동</em>"                                               										+
	            "<i class=\"ot01 infsTag\">데이터</i>"                                               										+
	            "</div>"                                               											+
	            "<span class=\"txt\"></span>"                                               					+
	            "</div>"                                               											+
	        "</a></li>",  
	       none:
	           "<li><a href=\"#none\">"                                                       +
	           "<img src=\"\" alt=\"\">"                                                  +
	           "<span class=\"txt\">데이터가 없습니다.</span>" +
	       "</a></li>"  
	};
// //////////////////////////////////////////////////////////////////////////////
// Script Init Loading...
// //////////////////////////////////////////////////////////////////////////////
$(function() {
	$("input[name=deviceType]").val(isMobile ? MOBILE_CD : PC_CD);
	
	// 이벤트를 정의한다.
	initEvent();
	
	if (!com.wise.util.isBlank($("#firParam").val())) {
		loadStats($("input[name=deviceType]").val());
	}
	else {
		alert("잘못된 접근입니다.");
		return false;
	}
	
});

////////////////////////////////////////////////////////////////////////////////
// 초기화 함수
////////////////////////////////////////////////////////////////////////////////
/**
 * 통계표 상세조회한다.
 * @param deviceType	디바이스 타입(P, M)
 * @returns
 */
function loadStats(deviceType) {
	if ( gfn_isNull($("#statblId").val()) ) {
		jAlert(alertMsg10);
		return false;
	}
	try {
		doAjax({
			url: "/portal/stat/selectEasyStatDtl.do",
			async: true,
			before: function() {
				showLoading();	// 조회중
			},
			params: $("#commonForm").serialize() + "&statblId=" + $("#statblId").val(),
			callback: afterLoadStats
		});
	} catch(e) {
		hideLoading();
	}
}

/**
 * 통계표 상세조회 후처리
 * @param res	조회결과
 * @returns
 */
function afterLoadStats(res) {
	var data = res.data;
	// PC는 좌측헤더고정 기본 체크
	isMobile ? $("#chkFrozenCol").prop("checked", false) : $("#chkFrozenCol").prop("checked", true);
	
	$(".sheetTitle").text(data.DATA.statblNm);	//타이틀
	
	// 시트 생성
	statSheetCreate();
	
}

/**
 * 시트 재생성
 */
function reCreateSheet() {
	statSheet.Reset(); 			// 윈도우 객체에 담은 해당 DIV객체를 초기화한다.
	statSheetCreate();		// 통계 시트 새로조회
}

/**
 * 시트를 생성한다.
 * @returns
 */
function statSheetCreate() {
	// 통계 시트 컬럼 세팅(헤더설정)
	loadEasySheet();

	if (isFirst) {
		params = $("#firParam").val();
	}
	else {
		params = $("form[name=statsEasy-mst-form]").serialize();
	}
	
	statSheet.SetWaitImageVisible(0);	//조회중 이미지 보이지 않게 설정
}

/**
 * 통계 시트 컬럼정보를 로드한다
 * @returns
 */
function loadEasySheet() {
	var gridArr = [];
	var iArr = null;
	var sheetCols = [];
	
	if (isFirst) {
		params = $("#firParam").val() + "&searchType=" + $("#searchType").val();
	}
	else {
		params = $("form[name=statsEasy-mst-form]").serializeObject();
	}

	$.ajax({
			url : com.wise.help.url("/portal/stat/statTblItm.do"),
			async : true,
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
					var cfg = { SearchMode : 0, Page : 10, MouseHoverMode : 1, VScrollMode:0, SelectionRowsMode : 0, MergeSheet : 7, DataRowMerge: 1, ColPage: 20, FrozenCol: frozenCol , SizeMode: 0, TouchScrolling: 1};

					SetConfig(cfg);

					InitHeaders(gridArr, {Sort : 0, ColMove : 0, ColResize : 1, HeaderCheck : 0});

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

				// //////////////////////////////////////////////////////////////////////////
				// 최초 접근시 통계표 정보 표시해준다.(항목, 분류 단위, 시계열 등등)
				if ( isFirst) {
					statDisplay(data.data.statCond);
				}
				////////////////////////////////////////////////////////////////////////////
				
				//statSheet.SetExtendLastCol(1);	// 마지막 컬럼 끝까지 늘린다.		
				
				// 데이터 로드 후 포커스를 설정하지 않도록 설정
				statSheet.SetFocusAfterProcess(0);
				statSheet.SetCountPosition(0);		// 카운트 정보 표시안함
			},
			error : function(request, status, error) {
				handleError(status, error);
			},
			complete : function(jqXHR) {
				// 데이터 조회
				statSheet.DoSearch(com.wise.help.url("/portal/stat/ststPreviewList.do"), params);
			}
		});
}

/**
 * 시트 조회 후처리
 * @returns
 */
function statSheet_OnSearchEnd(code, message, statusCode, statusMessage) {
	$("#firParam").val("");
	$("#searchType").val("");

	// 통계자료 hidden 처리(원자료만 존재할 경우)
	if (dtadvsLoc.LOC != "") {
		if (dtadvsLoc.LOC == "HEAD") {
			statSheet.SetRowHidden(dtadvsLoc.CNT, 1);
		} else if (dtadvsLoc.LOC == "LEFT") {
			statSheet.SetColHidden(dtadvsLoc.CNT, 1);
		}
	}
	
	// 통계표 주석 세팅(주기에 따라 통계값 주석 내용이 달라서)
	setStatCmmtList($("select[name=dtacycleCd]").val());
	
	// 연관 데이터셋 검색
//	selectRecommandDataSet();
	   
	$("input[name=deviceType]").val("");

	//통계표 이력 조회 CycleNo(키값) => 값이 있으면 통계표 이력에서 조회한다.(조회 할때마다 초기화 해준다.)
	$("input[name=hisCycleNo]").val("");	

	//sheet 상단에 피봇 값에 따라 설정한 값 이미지 표시 
	showSheetPivotImg();

	// 20180508/김정호 - 조회 완료후 무조건 최상단으로 focus
	$(".gnb-area .left li:eq(0) a").attr("tabindex", -1).focus();

	//  좌측헤더고정 설정값 처리
	var chkFrozenCol = $("#chkFrozenCol");
	if ( chkFrozenCol.is(":checked") ) {
		for ( var i=0; i < statSheet.LastCol(); i++ ) {
			if ( statSheet.ColSaveName(i).indexOf("COL_") > -1 ) {
				statSheet.SetFrozenCol(i);
				break;
			}
		}
	}
	else {
		statSheet.SetFrozenCol(0);
	}
	statSheet.SetHeaderRowHeight(23);			// 헤더 높이
	
	isFirst = false;
	
	//시트&차트 구분값을 전달받아 해당 화면을 바로 호출할수 있도록 처리
	var callStatType = $("#callStatType").val();
	if(callStatType == "C"){
		$("#callStatType").val(""); //호출 구분값 초기화
		var formObj = $("form[name=statsEasy-mst-form]");
		formObj.find($('.tabSt li')).removeClass('on');
		formObj.find("a[title=Chart]").parents("li").addClass('on');
		formObj.find($(".tabCont.sheetTab")).hide();
		formObj.find($(".tabCont.chartTab")).show();
		formObj.find($(".tabCont.mapTab")).hide();
		formObj.find($(".remarkDv")).hide();
		
		formObj.find("div[class=dropdown-content]").hide();
		doLoadChart();
	}
	
	hideLoading();
}

/**
 * 통계표 정보 표시해준다.(항목, 분류 단위, 시계열 등등)
 *   => 통계표를 바꿔서 조회할 수 없기 때문에 최초 한번반 조회해준다.
 * @param datas
 * @returns
 */
function statDisplay(datas) {
	var id = $("#statblId").val(); // 통계표 ID
	
	/* 검색주기 및 검색기간 세팅 */
	setDtaWrttimeVal(datas);
	
	/* 증감분석 설정 */
	getStatTblOption();
	
	/* 피봇 설정 */
	viewOptionStatDivSet();
	
	/* 통계스크랩 파라미터로 접근한 경우 */
	if ($("#searchType").val() == "U") {
		$("input[name=usrTblSeq]").val(getParam("usrTblSeq"));	//히든 파라미터에 값 세팅
		$("input[name=usrTblStatblNm]").val(getStringParam("statblNm"));
		//doUsrTblAction(id);
		$("a[name=usrTblUpd]").show();	//통계스크랩 수정버튼 보이도록
	}
	/* 모바일 및 최초 파라미터를 받아서 접근한 경우 */
	else {
		/* 항목, 분류 트리 로드 + 그룹 */
		statsTreeLoad("I");
		statsTreeLoad("C");
		statsTreeLoad("G");
		
		/* 소수점 값 세팅 */
		loadComboOptionsDef("dmPointVal", "/portal/stat/statOption.do", {grpCd : "S1109"}, (datas != null ? datas.dmPointVal : ""), jsMsg02);
		/* 단위 값 세팅 */
		loadComboOptionsDef("uiChgVal", "/portal/stat/statTblUi.do", {statblId : id}, (datas != null ? datas.uiChgVal : ""), jsMsg03);
	}
}

/**
 * 차트를 로드한다.
 */
function doLoadChart() {
	showLoading();
	
	setTimeout(function() {
		var funcLoadChart = function() {
			var deferred = $.Deferred();
			try {
				directStatChart($("#statblId").val(), "statChart");
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
	}, 10);
	
}

////////////////////////////////////////////////////////////////////////////////
//사용자 정의 공통 함수
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
	$.post(com.wise.help.url(url), data, function(data, status, request) {
		if (data.data) {
			// 콤보 옵션을 초기화한다.
			initComboOptions(id, [ {
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

/**
 * 포털에서 시트 데이터 엑셀 다운로드
 */
function PortalDownFile(type, fileNm) {
	var formObj = $("form[name=statsEasy-mst-form]");

	var params = {
		URL : com.wise.help.url("/portal/stat/down2Excel.do"),
		ExtendParam : formObj.serialize() + "&fileNm=" + fileNm + "&sysTag=K",
		ExtendParamMethod : "POST",
		SheetDesign : 1,
		Merge : 1,
		Mode : -1,
		NumberFormatMode : 1,
		FileName : (formObj.find("[name=statTitle]").val() || "excel") + ".xlsx",
		SheetName : "excelsheet",
		Multipart : 0
	};
	statSheet.Down2Excel(params);
	statSheet.HideProcessDlg();
}

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
 * 숫자만 입력 함수 > jAlert적용을 위해 별도로 추가 
 * @param obj 	객체
 * @returns
 */
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
//Validation 함수
////////////////////////////////////////////////////////////////////////////////
function searchValidation() {
	var formObj = $("form[name=statsEasy-mst-form]");
	
	//트리 체크관련 validation
	var statblId = $("#statblId").val();
	if ( !isTreeChk("itm" + statblId) ) {
		jAlert(alertMsg03);
		return false;
	}
	if ( !isTreeAllChk("itm" + statblId) ) {
		jAlert( "항목은 " + String(TREE_CHK_LIMIT_CNT) + "개 이상 선택 할 수 없습니다.");
		return false;
	}
	
	var clsDataLen = $("#treeClsData").find("li").length;
	if(clsDataLen > 1){
		if ( !isTreeChk("cls" + statblId) ) {	
			jAlert(alertMsg04);
			return false;
		}
		if ( !isTreeAllChk("cls" + statblId) ) {
			jAlert( "분류는 " + String(TREE_CHK_LIMIT_CNT) + "개 이상 선택 할 수 없습니다.");
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
	param.grpTreeNm = param.grpDataNm 	|| "grp";
	param.itmTreeNm = param.itmDataNm 	|| "itm";
	param.clsTreeNm = param.clsDataNm 	|| "cls";
	param.dvsTreeNm = param.dvsDataNm 	|| "dvs";
	
	var grpDataLen, itmDataLen, clsDataLen, dvsDataLen = 1;
	if ( param.type > 0 ) {
		grpDataLen = getCheckedTreeLen(param.grpTreeNm) > 0 ? getCheckedTreeLen(param.grpTreeNm) : 1;
		itmDataLen = getCheckedTreeLen(param.itmTreeNm) > 0 ? getCheckedTreeLen(param.itmTreeNm) : 1;
		clsDataLen = getCheckedTreeLen(param.clsTreeNm) > 0 ? getCheckedTreeLen(param.clsTreeNm) : 1;
		dvsDataLen = getCheckedTreeLen(param.dvsTreeNm) > 0 ? getCheckedTreeLen(param.dvsTreeNm) : 1;
	} else {
		var statblId = $("#statblId").val();
		grpDataLen = getCheckedTreeLen(param.grpTreeNm+statblId) > 0 ? getCheckedTreeLen(param.grpTreeNm+statblId) : 1;
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
	
	// 검색주기 * 검색기간 * 항목 * 분류 * 증감분석 트리 체크 갯수
	var cellCnt = wrttimeCnt()  
	   * grpDataLen * itmDataLen * clsDataLen * dvsDataLen;
	
	// 다운로드 건수 제한
	if ( cellCnt > DOWN_LIMIT_CNT ) {
		if ( param.type> 0 ) {
		}else{
			var formObj = $("form[name=statsEasy-mst-form]");
			// 레이어 숨김
			formObj.find($(".layerPopup.grpPop")).hide();
			formObj.find($(".layerPopup.itmPop")).hide();
			formObj.find($(".layerPopup.clsPop")).hide();
			formObj.find($(".layerPopup.dvsPop")).hide();
		}
		
		jAlert("조회 건수가 " +commaWon(String(DOWN_LIMIT_CNT))+ "건 이상은 조회 속도 지연 및 서버 부하로 인해 다운로드가 되지 않습니다. 항목을 재설정하여 조회하시기 바랍니다.");
		return false;
		
	// 조회 건수 제한
	} else if ( cellCnt > SEARCH_LIMIT_CNT ) {	

		if ( param.type> 0 ) {
		}else{
			var formObj = $("form[name=statsEasy-mst-form]");
			// 레이어 숨김
			formObj.find($(".layerPopup.grpPop")).hide();
			formObj.find($(".layerPopup.itmPop")).hide();
			formObj.find($(".layerPopup.clsPop")).hide();
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
			
			var formObj = $("form[name=statsEasy-mst-form]");
			var objParam = formObj.serializeObject();
			var statblId = param.obj.find("input[name=statblId]").val();
			objParam.chkItms = getCheckedTreeDatano(param.itmTreeNm+statblId);
			
			if ( getCheckedTreeDatano(param.grpTreeNm+statblId).length > 0 ) {
				// 그룹이 없는경우 null값이 아닌 아에 파라미터가 안넘어가야 하네요.
				objParam.chkGrps = getCheckedTreeDatano(param.grpTreeNm+statblId);
			}
			if ( getCheckedTreeDatano(param.clsTreeNm+statblId).length > 0 ) {
				// 분류가 없는경우 null값이 아닌 아에 파라미터가 안넘어가야 하네요.
				objParam.chkClss = getCheckedTreeDatano(param.clsTreeNm+statblId);	
			}
			objParam.dtadvsVal = getCheckedTreeDatano(param.dvsTreeNm+statblId);
			
			// Object를 queryString으로 변환한다.
			params = objParam2Serialize(objParam);
			
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

/**
 * 목록으로 이동(파라미터 유지)
 */
function moveInfsList() {
	goSearch({
		url:"/portal/infs/list/infsListPage.do",
		form:"searchForm",
		method: "post"
	});
}

/**
 * 연관 데이터셋 검색
 */
function selectRecommandDataSet() {
	doSelect({
        url:"/portal/data/sheet/selectRecommandDataSet.do",
        before:beforeSelectRecommandDataSet,
        after:afterSelectRecommandDataSet
    });
}

/**
 * 연관 데이터셋 검색 전처리
 */
function beforeSelectRecommandDataSet(options) {
    var data = {
        // Nothing do do.
    };
    
    var form = $("#commonForm");
    
    data["objId"] =$("input[name=statblId]").val() || $("#searchForm [name=statblId]").val();
   
    if (com.wise.util.isBlank(data.objId)) {
        return null;
    }
    
    return data;
}

/**
 * 연관 데이터셋 검색 후처리를 실행한다.
 * 
 * @param data {Object} 데이터
 */
function afterSelectRecommandDataSet(data) {
	  var table = $(".bxslider");
	//  var infsq = 1;
	  
	//데이터가 없다면
	  if (data.length == 0) {
		 $(".recommendDataset").remove();
	  }
	  for (var i = 0; i < data.length; i++) {
	      var row = $(templates2.data);
	     
	      table.append(row);
  
	     
	      if (data[i].metaImagFileNm || data[i].saveFileNm) {
	            var url = com.wise.help.url("/portal/data/dataset/selectThumbnail.do");
	            url += "?infId=" + data[i].objId;
	            url += "&cateSaveFileNm=" + (data[i].saveFileNm ? data[i].saveFileNm : "");

	            row.find(".metaImagFileNm").attr("src", url);
				//row.find(".metaImagFileNm").attr("alt", data[i].objNm);
	      }
	      
	      row.find("span").eq(1).text(data[i].objNm);
	      row.find(".m_cate").text(data[i].topCateNm);
	      row.find(".infsTag").text(data[i].opentyTagNm);
	      
	      row.each(function(index, element) {
	            // 서비스 링크에 클릭 이벤트를 바인딩한다.   	  
	            $(this).bind("click", {
	                objId:data[i].objId,
	                opentyTag:data[i].opentyTag
	            }, function(event) {
	            	moveToRecommendDataset(event.data);
	                return false;
	            });
	            
	            // 서비스 링크에 키다운 이벤트를 바인딩한다.
	            $(this).bind("keydown", {
	                objId:data[i].objId,
	                opentyTag:data[i].opentyTag
	            }, function(event) {
	                if (event.which == 13) {
	                	moveToRecommendDataset(event.data);
	                    return false;
	                }
	            });
	        });
	  	      
	  }
	  
	  var ww = ($('.recommendDataset').width()-75) / 4;
	  setTimeout(dataset, 700, ww);
	
	  function dataset(ww) {
		  dataSet = $('.dataSetSlider').bxSlider({
				mode : 'horizontal',
				speed : 500,
				moveSlider : 1,
				autoHover : true,
				controls : false,
				slideMargin : 0,
				startSlide : 0,
				slideWidth: ww,
				minSlides: 1,
				maxSlides: 4,
				moveSlides: 1
			});

			$( '#dataset_prev' ).on( 'click', function () {
				dataSet.goToPrevSlide();  //이전 슬라이드 배너로 이동
				return false;              //<a>에 링크 차단
			} );
			
			$( '#dataset_next' ).on( 'click', function () {
				dataSet.goToNextSlide();  //다음 슬라이드 배너로 이동
				return false;
			} );
			
			
			$('.dataSet ul.dataSetSlider li a').on('focus', function(){
				$('.dataSet').addClass('focus');
			});
			
			$('.dataSet ul.dataSetSlider li a').on('focusout', function(){
				$('.dataSet').removeClass('focus');
			});
	  }
}

/**
 * 연관(추천) 데이터셋으로 이동한다.
 * @param data
 * @returns
 */
function moveToRecommendDataset(data) {
	var obj = getOpentyTagData(data);
	
	$("#searchForm").append("<input type=\"hidden\" id=\""+obj.id+"\" name=\""+obj.id+"\" value=\""+data.objId+"\" />");
	
	goSelect({
		url: obj.url,
        form:"searchForm",
        method: "post"
    });
	
	function getOpentyTagData(data) {
		var obj = {};
		
		switch ( data.opentyTag ) {
		case "D":
			obj.url = "/portal/doc/docInfPage.do/" + data.objId;
			obj.id = "docId";
			obj.gubun = "seq";
			break;
		case "O":
			obj.url = "/portal/data/service/selectServicePage.do/" + data.objId;
			obj.id = "infId";
			obj.gubun = "infSeq";
			break;
		case "S":
			obj.url = "/portal/stat/selectServicePage.do/" + data.objId;
			obj.id = "statblId";
			obj.gubun = "";
			break;
		}
		return obj
	}
}