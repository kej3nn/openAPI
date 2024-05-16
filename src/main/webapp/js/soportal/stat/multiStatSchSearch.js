/*
 * @(#)multiStatSchSearch.js 1.0 2017/12/14
 * 
 * COPYRIGHT (C) 2013 WISEITECH CO., LTD. ALL RIGHTS RESERVED.
 */
/**
 * 복수통계 조회 및 조회 전/후처리 스크립트 파일이다.
 * 
 * @author 김정호
 * @version 1.0 2017/12/14
 */
////////////////////////////////////////////////////////////////////////////////
// 통계 조회 관련 처리
////////////////////////////////////////////////////////////////////////////////
/**
 * [STEP-1] 통계 조회 탭 이벤트 실행 
 */
function tabStatEvent(deviceType) { 
	if(mixContainer.RowCount() == 0){
		jAlert("조회하실 데이터를 선택항목으로 추가해 주십시오");
		return false;
	}
	
	// 사칙연산 화면 계산식 VALIDATION
	if ( typeof validCalcOperator === "function" ) {
		if ( !validCalcOperator() )	return false; 
	}
	
	showLoading();	// 조회중
	
	var searchObj = $("form[name=searchForm]");
	var title = jsMsg11 + tabSeq;		//탭 제목
	var id = "MixStatId" + tabSeq;		//탭의 고유아이디로 통계 ID를 넣는다.
	
	tabSeq += 1; 						//탭 seq는 늘려준다.
	var param = jsonfy(searchObj);		//통계검색 조회폼의 값을 넣어주는데 사실 의미는 없슴
	openTab.SetTabData(param);//db data 조회시 조건 data
	var url =  com.wise.help.url('/portal/stat/selectMultiStatDtl.do'); // Controller 호출 url 
	
	openTab.addTab(id, title, url, tabCallBack); 	// 탭 추가 시작함

	/* 탭추가 완료 후 deviceType에 따라 화면세팅 및 데이터 호출 */
	mixStatTabDisplay(id, title, deviceType);
}

/**
* [STEP-2] 탭추가 완료 후 화면세팅 및 데이터 호출
* @Param id	통계표 ID
* @Param title	통계표 명
* @Param dType 기기 타입(PC or Mobile)
*/
function mixStatTabDisplay(id, title, dType) {
	var title = title || $("#stat_title").text(); // PC에서 항목 선택 안했을 경우(파라미터로 바로 접근했을 경우 tabSetDataFunc에서 입력한 값을 가지고 온다.)
	var deviceType = dType || PC_CD;
	var objTab = getTabShowObj();// 탭이 open된 객체가져옴
	var formObj = objTab.find("form[name=statsEasy-mst-form]");
	var sheetNm = formObj.find($(".grid.statEasySheet")).attr('id');
	var chartNm = formObj.find($(".chart.statEasyChart")).attr('id');
	var sliderNm = formObj.find($(".statSlider")).attr('id');
	var mapNm = formObj.find($(".map.statEasyMap")).attr('id');
	
	if (sheetNm == undefined && chartNm == undefined) {
		// 신규 탭화면
		statTabCnt++;
		sheetNm = "statEasySheet" + statTabCnt;
		chartNm = "statEasyChart" + statTabCnt;
		sliderNm = "statSlider" + statTabCnt;
		mapNm = "statEasyMap" + statTabCnt;
		
		formObj.find($(".chart.statEasyChart")).attr("id", chartNm);
		formObj.find($(".statSlider")).attr("id", sliderNm);
		formObj.find($(".map.statEasyMap")).attr("id", mapNm);
		
		// PC는 좌측헤더고정 기본 체크
		isMobile ? formObj.find("#chkFrozenCol").prop("checked", false) : formObj.find("#chkFrozenCol").prop("checked", true);
	} else {
		// 이미 호출된 탭화면
		sheetNm = sheetNm.replace("DIV_", "");

		formObj.find($(".grid.statEasySheet")).empty(); // 화면에 Display하기전에 해당 위치의 내용을 초기화한다.
		formObj.find($(".chart.statEasyChart")).empty(); // 챠트 내용도 초기화한다.

		var sheetobj = window[sheetNm];
		sheetobj.Reset(); // 윈도우 객체에 담은 해당 DIV객체를 초기화한다.
	}

	//선택된 시계열 항목중 첫번째 값의 통계ID 정보를 확인하여  statblId에 넣는다.
	var sMixval = mixContainer.GetCellValue(1, "sMixval").split("-");
	var sId = sMixval[0];

	// 0. 통계ID와 타이틀 넣기
	formObj.find("input[name=sheetNm]").val(sheetNm);
	formObj.find("input[name=statblId]").val(id);
	formObj.find("input[name=statTitle]").val(title);
	formObj.find($(".sheetTitle")).text(title); // 탭화면 타이틀 Display
	$("#tabs-" + id + " span").text(title); // 탭 버튼 타이틀(통계표 명 표시)

	// 기기 타입 탭 변수값에 세팅
	formObj.find("input[name=deviceType]").val(deviceType);

	MAP_SELECT_ITEM[sheetNm] = getMixContainerVals();
	
	mixTabDisplay(sId, sheetNm, null);	//if문 조건의 경우는 파라미터를 먼저 세팅한다.
}

/**
* [STEP-3] 탭 화면에 통계정보를 display 한다
* @param sheetNm	시트명
* @param datas		기본 세팅 데이터(탭 추가시 callback으로 넘어온다)
*/
function mixTabDisplay(id, sheetNm, datas) {
	
	var objTab = getTabShowObj();// 탭이 open된 객체가져옴
	var formObj = objTab.find("form[name=statsEasy-mst-form]");

	/* 검색주기 및 검색기간 세팅 > 간편통계 공통 호출 */
	setDtaWrttimeVal(datas);	// - 복수통계는 선택항목에 항목 추가한뒤 검색기간 세팅한다.
	
	/* 증감분석 설정 */
	getMixStatTblOption();

	/* 피봇설정 적용버튼 처리 */
	setPiEvent();
	
	/* 통계스크랩 파라미터로 접근한 경우 */
	if (  $("#searchType").val() == "U" ) {
		formObj.find("input[name=usrTblSeq]").val(getParam("usrTblSeq"));	//히든 파라미터에 값 세팅 usrTblSeq
		formObj.find("a[name=usrTblUpd]").show();	//통계스크랩 수정버튼 보이도록
	}
	var callUiChgVal = getStringParam("uiChgVal");
	var callDmPointVal = getStringParam("dmPointVal");

	/* 소수점 값 세팅 */
	loadComboOptionsDef("dmPointVal", "/portal/stat/statOption.do", {grpCd : "S1109", langGb : $("#langGb").val()}, "", jsMsg02);
	/* 단위 값 세팅 */
	var params = formObj.serialize() + "&" + MAP_SELECT_ITEM[sheetNm];
	//params.push("langGb",$("#langGb").val());
	loadComboOptionsDef("uiChgVal", "/portal/stat/statMultiTblUi.do", params, "", jsMsg03);
	/* 파라미터 값 세팅 완료 후 Sheet생성 */
	$(".grid.statEasySheet").eq(1).attr("id", "DIV_" + sheetNm);
	mixSheetCreate(sheetNm);
}
////////////////////////////////////////////////////////////////////////////////
// 통계 조회 전/후 처리
////////////////////////////////////////////////////////////////////////////////
/**
 * 메인리스트에서 통계표 선택시 항목, 분류 및 검색주기, 검색기간 세팅 
 */
function selStat(sId) {
	$.when(doSelStat(sId)).done(
		function(r1) {
			if ( !isMobile ) hideLoading();		// PC에서만 검색완료시 로딩바 숨긴다.
	});
}

function doSelStat(sId) {
	$("#sId").val(sId);

	// 통계표를 선택시 항목선택 및 분류선택의 검색란 내용을 지운다.
	$("#itmSearchVal").val("");
	$("#clsSearchVal").val("");
	$("#grpSearchVal").val("");

	var processChk1, processChk2;

	// 항목선택/분류선택/그룹선택 확인 Display
	processChk1 = selectStats();

	// 검색기준 확인 Display
	processChk2 = selectCycle();

	if (processChk1) {
		return true;
	} else {
		return false;
	}
}
/**
 * 통계표 선택시 항목, 분류, 그룹정보 세팅 및 이벤트 생성
 */
function selectStats() {

	$("#searchGb").val("M");

	statsMainTreeLoad("I");	//항목 선택 트리 로드
	statsMainTreeLoad("C");//분류 선택 트리 로드
	statsMainTreeLoad("G");//그룹 선택 트리 로드

	// 그룹
	$("button[name=grpAllChk]").bind("click", function() {
		treeNodeControl("treeGrpData", "CHK");
	}); // 전체선택
	$("button[name=grpAllUnChk]").bind("click", function() {
		treeNodeControl("treeGrpData", "UN_CHK");
	}); // 전체해제
	$("button[name=grpAllExpand]").bind("click", function() {
		treeNodeControl("treeGrpData", "EXP");
	}); // 펼침
	$("button[name=grpAllUnExpand]").bind("click", function() {
		treeNodeControl("treeGrpData", "UN_EXP");
	}); // 닫기
	// 항목
	$("button[name=itmAllChk]").bind("click", function() {
		treeNodeControl("treeItmData", "CHK");
	}); // 전체선택
	$("button[name=itmAllUnChk]").bind("click", function() {
		treeNodeControl("treeItmData", "UN_CHK");
	}); // 전체해제
	$("button[name=itmAllExpand]").bind("click", function() {
		treeNodeControl("treeItmData", "EXP");
	}); // 펼침
	$("button[name=itmAllUnExpand]").bind("click", function() {
		treeNodeControl("treeItmData", "UN_EXP");
	}); // 닫기
	// 분류
	$("button[name=clsAllChk]").bind("click", function() {
		treeNodeControl("treeClsData", "CHK");
	});
	$("button[name=clsAllUnChk]").bind("click", function() {
		treeNodeControl("treeClsData", "UN_CHK");
	});
	$("button[name=clsAllExpand]").bind("click", function() {
		treeNodeControl("treeClsData", "EXP");
	});
	$("button[name=clsAllUnExpand]").bind("click", function() {
		treeNodeControl("treeClsData", "UN_EXP");
	});

	return true;
}
/**
 * 통계표 선택시 통계정보 호출(메인화면에서 통계표 선택시 호출됨)
 */
function selectCycle() {
	var params = {statblId : $("#sId").val(), metaCallYn : "N", langGb : $("#langGb").val()};
	doAjax({
		url : "/portal/stat/selectMultiStatDtl.do",
		params : params,
		callback : afterStatsCycle
	});

	return true;
}
/**
 * 선택 통계정보 확인 후 처리함수
 */
function afterStatsCycle(res) {
	
	var data = res.data;

	$('#stat_title').text(data.DATA[0].statblNm);
	$('#stat_title_pop').text(data.DATA[0].statblNm);
	$('#stat_title_pop_m').text(data.DATA[0].statblNm);

	// 데이터 기준으로 검색주기 표시	
	var chk = JSON.stringify(data.DATA2);
	var chkData = JSON.parse(chk);
	
	var optData = chkData.OPT_DATA; // 통계표 옵션 정보
	var optCdDc = ""; // 검색자료주기 선택값
	var wrttimeLastestVal = ""; // 검색 시계열 수

	if (optData.length > 0) {
		for (var i = 0; i < optData.length; i++) {
			if (optData[i].optCd == "DC") {
				optCdDc = optData[i].optVal; 	// 검색자료주기 선택 확인
			} else if (optData[i].optCd == "TN") {
				wrttimeLastestVal = optData[i].optVal; 	// 검색시계열 수 확인
				$("form[name=searchForm]").find("[name=wrttimeLastestVal]").val(wrttimeLastestVal); 	// 검색시계열 수 반영
			}
		}
	}
	
	// 검색주기, 검색기간 조회
	if ( !IS_SELECT_ITEM ) {	// 선택항목에 데이터가 없는경우만 검색기간 조회한다
		selectDtacycleList($("form[name=searchForm]"), optCdDc);
		selectWrttimeVal($("form[name=searchForm]"), optCdDc);	// 복수통계는 검색기간 선택항목에 추가한뒤 생성해준다.
	}
	
	setDtacycleDisplay();	// 검색주기 DISPLAY
	setWrttimeDisplay();	// 검색기간(수록기간) DISPLAY
}

//----------------------- 검색주기 관련 함수[시작] ---------------------------
/**
 * 검색주기를 조회한다.
 * @param formObj		검색주기 콤보를 생성할 폼 객체
 * @param dtacycleCd	검색주기 콤보에 선택될 값
 */
function selectDtacycleList(formObj, dtacycleCd) {
	// 데이터 기준으로 검색기간 설정
	var dtacycleCd = dtacycleCd || "";
	doAjax({
		url : "/portal/stat/statDtacycleList.do",
		params : {statblId : $("#sId").val(), langGb : $("#langGb").val()},
		callback : function(data) {
			initTabComboOptions(formObj, "dtacycleCd", data.data, dtacycleCd);	// 기준주기 세팅
			
			if ( formObj.attr("name") == "searchForm" ) {	// 메인폼만 주기 변경해준다(탭안에서도 같이사용하는 함수라서)
				// 주기 display
				var dtacycleCdDisplay = [];
				for ( var d in data.data ) {
					dtacycleCdDisplay.push(data.data[d].name);
				}
				$("#dtacycleCdDisplay").text(dtacycleCdDisplay.join(", "));
			}
		}
	});
		
}
/**
 * 검색기간을 조회하고 콤보박스를 생성함
 * @param formObj		검색기간 콤보를 생성할 폼 객체
 * @param dtacycleCd	검색기간 콤보에 선택될 값
 */
function selectWrttimeVal(formObj, dtacycleCd) {
	// 데이터 기준으로 설정
	var pDtacycleCd = dtacycleCd || $("form[name=searchForm]").find('select[name=dtacycleCd] :selected').val();
	
	// 복수통계는 통계표가 여러개가 있으므로 통계표 ID 파라미터를 통계표 IN 절로 조회되도록 넘거야 함
	var paramMixVal = getMixContainerVals().replace("&sMixval=", "");
	var arrStatblId = [];
	if ( !gfn_isNull(paramMixVal) && paramMixVal.indexOf("|") > -1 ) {
		var arrMixval = paramMixVal.split("|");
		
		for ( var i in arrMixval ) {
			var sMixval = arrMixval[i];
			if ( !gfn_isNull(sMixval) ) {
				arrStatblId.push(sMixval.split("-")[0]);
			}
		}
	}
	
	var uniqArrStatblId = arrStatblId.reduce(function(a, b){		// 중복제거
		if (a.indexOf(b) < 0 ) a.push(b);
			return a;
	  	},[]);
	var statblIds = uniqArrStatblId.length > 1 ? uniqArrStatblId.join("|") : "";

	// 기간
	$.ajax({
		type : 'POST',
		dataType : 'json',
		async : false,
		url : com.wise.help.url("/portal/stat/statWrtTimeOption.do"),
		data : {
			statblId : $("#sId").val(),		// 복수통계 선택항목 추가시 마지막에 선택한 통계표 ID
			statblIds: statblIds,			// 복수통계 선택항목 추가한 전체 통계표 ID(ID|ID|ID)
			dtacycleCd : pDtacycleCd,
			langGb : $("#langGb").val()
		},
		success : function(res1) {
			if (res1.data) {
				var dataLen = res1.data.length;
				var endComboCd = dataLen > 1 ? res1.data[dataLen-1].code : "";
				// 콤보 옵션을 초기화한다.
				
				initTabComboOptions(formObj, "wrttimeStartYear", res1.data, "");
				initTabComboOptions(formObj, "wrttimeEndYear", res1.data, endComboCd);
				formObj.find("input[name=wrttimeMinYear]").val(formObj.find("select[name=wrttimeStartYear] option:first").val());		//년도 시점 최소값
				formObj.find("input[name=wrttimeMaxYear]").val(formObj.find("select[name=wrttimeStartYear] option:last").val());	//년도 시점 최대값
				
				$("#wrttimeDisplay").text(formObj.find("input[name=wrttimeMinYear]").val() + " ~ " + formObj.find("input[name=wrttimeMaxYear]").val());
				//검색주기 쿼터 생성
				setWrttimeQuater(formObj, pDtacycleCd);
				
				// 검색주기 선택시 라디오 버튼 선택 변경
				formObj.find("select[name=wrttimeStartYear], select[name=wrttimeEndYear], select[name=wrttimeStartQt], select[name=wrttimeEndQt]").bind("click", function(event) {
					formObj.find("input[name=wrttimeType][value=B]").prop("checked", true);
				});
				// 검색주기 - 최근시점 개의 입력박스 선택시 라디오 버튼 선택 변경
				formObj.find("input[name=wrttimeLastestVal]").bind("click", function(event) {
					formObj.find("input[name=wrttimeType][value=L]").prop("checked", true);
				});
				// 검색주기 - 최근시점은 숫자만 입력
				formObj.find("input[name=wrttimeLastestVal]").keyup(function(e) {
					statComInputNumObj(formObj.find("input[name=wrttimeLastestVal]"));
					return false;
				});
				
				// 탭 기준시점 생성
				var tabWrttimeStartYear = formObj.find("select#wrttimeStartYear").find("option").clone();
				formObj.find("select#dtaWrttimeYear").append(tabWrttimeStartYear);
				var tabWrttimeStartQt = formObj.find("select#wrttimeStartQt").find("option").clone();
				formObj.find("select#dtaWrttimeQt").append(tabWrttimeStartQt);
				
				if ( !gfn_isNull($("#firParam").val()) ) {
					// 통계스크랩으로 접근했을경우 기준시점 selectbox 표시
					var dtacycleCd = getStringParam("dtacycleCd");
					var dtaWrttime = getStringParam("dtaWrttime");
					var dtaCalcNullToZero = getStringParam("dtaCalcNullToZero");
					if ( dtacycleCd == "YY" ) {
						formObj.find("select#dtaWrttimeYear").val(dtaWrttime.substr(0, 4));
					}
					else {
						formObj.find("select#dtaWrttimeYear").val(dtaWrttime.substr(0, 4));
						formObj.find("select#dtaWrttimeQt").val(dtaWrttime.substr(4, 6));
					}
					
					formObj.find("#dtaCalcNullToZero[value="+dtaCalcNullToZero+"]").prop("checked", true);
					formObj.find("#calcAqn").val(getStringParam("calcAqn"));
					formObj.find("#calcAqnNm").val(getStringParam("calcAqnNm"));
					
				}
			}
		}
	});
	
	//맵 탭 오픈 여부를 처리한다.
	var statMapVal = $("#mapVal").val();
	if(statMapVal == "KOREA" || statMapVal == "WORLD") formObj.find("a[title=Map]").parents("li").show();
	else  formObj.find("a[title=Map]").parents("li").hide();
	formObj.find("input[name=tabMapVal]").val(statMapVal);
}
/**
 * 검색주기 쿼터 생성
 * @param formObj		검색기간 콤보를 생성할 폼 객체
 * @param dtacycleCd	검색기간 콤보에 선택될 값
 */
function setWrttimeQuater(formObj, dtacycleCd) {
	var options = new Array();
	
	if ( dtacycleCd == "YY" ) {
		options.push({code:"00", name:jsMsg12});
	} else if ( dtacycleCd== "HY" ) {
		options.push({code:"01", name:jsMsg16});
		options.push({code:"02", name:jsMsg17});
	} else if ( dtacycleCd == "QY" ) {
		options = wrttimeOption(4, jsMsg05);
	} else if ( dtacycleCd == "MM" ) {
		options = wrttimeOption(12, "");
	}
	
	initTabComboOptions(formObj, "wrttimeStartQt", options, "");
	initTabComboOptions(formObj, "wrttimeEndQt", options, formObj.find("select[name=wrttimeStartQt] option:last").val());
	
	if ( dtacycleCd == "YY" ) {
		//년도일때는 쿼터정보 숨김
		formObj.find("select[name=wrttimeStartQt]").hide();
		formObj.find("select[name=wrttimeEndQt]").hide();
		if ( formObj.find("#dtaWrttimeQt").length > 0 )		formObj.find("#dtaWrttimeQt").hide();	// 기준대비변경시점화면의 기준시점 쿼터(반기,분기,월)
	} else {
		formObj.find("select[name=wrttimeStartQt]").show();
		formObj.find("select[name=wrttimeEndQt]").show();
		if ( formObj.find("#dtaWrttimeQt").length > 0 )		formObj.find("#dtaWrttimeQt").show();
	}
	formObj.find("[name=wrttimeMinQt]").val(formObj.find("select[name=wrttimeStartQt] option:first").val());		//기간 시점 최소값(조회 파라미터로 사용됨)
	formObj.find("[name=wrttimeMaxQt]").val(formObj.find("select[name=wrttimeStartQt] option:last").val());			//기간 시점 최대값
}
/**
 * 주기에 따른 상세 시점 세팅(반기, 분기, 월)
 * @param end
 * @param wrtTxt
 * @returns {Array}
 */
function wrttimeOption(end, wrtTxt) {
	var options = new Array();
	var option = "";
	for ( var i=1; i <= end; i++ ) {
		if ( i < 10 ) {
			sCode = "0" + String(i);	//코드는 숫자 앞에 '0'이 필요
		} else {
			sCode = String(i);
			sName = String(i);
		}
		sName = String(i);
		options.push({code:sCode, name:sName + " " + wrtTxt});
	}
	return options;
}
/**
 * 검색주기 및 검색기간 세팅
 * @Param datas	기본세팅 정보 값
 */
function setDtaWrttimeVal(datas) {
	var objTab = getTabShowObj();// 탭이 open된 객체가져옴
	var formSch = $("form[name=searchForm]");
	var formObj = objTab.find("form[name=statsEasy-mst-form]");

	//모바일로 넘어온 경우 기본설정 데이터가 존재
	if (!gfn_isNull(datas)) {
		//검색주기 콤보박스 생성
		selectDtacycleList(formObj, datas.dtacycleCd);
		//검색기간 콤보박스 생성
		selectWrttimeVal(formObj, datas.dtacycleCd);
		formObj.find("select[name=dtacycleCd]").val(datas.dtacycleCd);	//검색주기
		formObj.find("select[name=wrttimeOrder]").val(datas.wrttimeOrder);	//정렬순서
		formObj.find("input[name=wrttimeLastestVal]").val(datas.wrttimeLastestVal);			//검색갯수
		formObj.find("input[name=wrttimeType][value="+datas.wrttimeType+"]").prop("checked", true);			//검색시점타입
		formObj.find("select[name=wrttimeStartYear]").val(datas.wrttimeStartYear|| datas.wrttimeMinYear);	//시작년
		formObj.find("select[name=wrttimeEndYear]").val(datas.wrttimeEndYear 	|| datas.wrttimeMaxYear);	//종료년
		formObj.find("input[name=wrttimeMinYear]").val(datas.wrttimeStartYear 	|| datas.wrttimeMinYear);	//시작년
		formObj.find("input[name=wrttimeMaxYear]").val(datas.wrttimeEndYear 	|| datas.wrttimeMaxYear);	//종료년
		formObj.find("select[name=wrttimeStartQt]").val(datas.wrttimeStartQt 	|| datas.wrttimeMinQt);		//시작쿼터
		formObj.find("select[name=wrttimeEndQt]").val(datas.wrttimeEndQt 		|| datas.wrttimeMaxQt);		//종료쿼터
		formObj.find("input[name=wrttimeMinQt]").val(datas.wrttimeStartQt 		|| datas.wrttimeMinQt);		//시작쿼터
		formObj.find("input[name=wrttimeMaxQt]").val(datas.wrttimeEndQt 		|| datas.wrttimeMaxQt);		//시작쿼터
	}
	else {
		//통계스크랩으로 넘어온 경우
		if ($("#searchType").val() == "U") {
			//검색주기 콤보박스 생성
			selectDtacycleList(formObj, getStringParam("dtacycleCd"));
			//검색기간 콤보박스 생성
			selectWrttimeVal(formObj, getStringParam("dtacycleCd"));
			formObj.find("select[name=dtacycleCd]").val(getStringParam("dtacycleCd"));		//검색주기
			formObj.find("select[name=wrttimeOrder]").val(getStringParam("wrttimeOrder"));	//정렬순서
			formObj.find("input[name=wrttimeLastestVal]").val(getStringParam("wrttimeLastestVal"));			//검색갯수
			formObj.find("input[name=wrttimeType][value="+getStringParam("wrttimeType")+"]").prop("checked", true);		//검색시점타입
			var wrttimeStartYear = getStringParam("wrttimeStartYear");
			var wrttimeEndYear = getStringParam("wrttimeEndYear");
			var wrttimeStartQt = getStringParam("wrttimeStartQt");
			var wrttimeEndQt = getStringParam("wrttimeEndQt");
			formObj.find("select[name=wrttimeStartYear]").val(wrttimeStartYear);	//시작년
			formObj.find("select[name=wrttimeEndYear]").val(wrttimeEndYear);		//종료년
			formObj.find("input[name=wrttimeMinYear]").val(wrttimeStartYear);		//시작년
			formObj.find("input[name=wrttimeMaxYear]").val(wrttimeEndYear);			//종료년
			formObj.find("select[name=wrttimeStartQt]").val(wrttimeStartQt);		//시작쿼터
			formObj.find("select[name=wrttimeEndQt]").val(wrttimeEndQt);			//종료쿼터
			formObj.find("input[name=wrttimeMinQt]").val(wrttimeStartQt);			//시작쿼터
			formObj.find("input[name=wrttimeMaxQt]").val(wrttimeEndQt);				//시작쿼터
		}
		else {
			setMainSearchParam();
		}
	}
	return true;
}
//----------------------- 검색주기 관련 함수[종료] ---------------------------
/**
 * 메인에서 검색 하는경우 메인화면에 선택한 파라미터 검색주기 및 검색기간 세팅
 */
function setMainSearchParam() {
	var objTab = getTabShowObj();// 탭이 open된 객체가져옴
	var formSch = $("form[name=searchForm]");
	var formObj = objTab.find("form[name=statsEasy-mst-form]");
	
	var schFormDtacycleCd = formSch.find("select[name=dtacycleCd] :selected").val();
	//검색주기 DB 조회 및 combobox 생성
	selectDtacycleList(formObj, schFormDtacycleCd);
	//검색기간 DB 조회 및 combobox 생성
	selectWrttimeVal(formObj, schFormDtacycleCd);
	formObj.find("select[name=dtacycleCd]").val(schFormDtacycleCd);												//검색주기
	formObj.find("select[name=wrttimeOrder]").val(formSch.find("select[name=searchSort]").val());				//정렬순서
	formObj.find("input[name=wrttimeLastestVal]").val(formSch.find("input[name=wrttimeLastestVal]").val());		//검색갯수
	formObj.find("select[name=wrttimeStartYear]").val(formSch.find("select[name=wrttimeStartYear]").val());		//시작년
	formObj.find("select[name=wrttimeEndYear]").val(formSch.find("select[name=wrttimeEndYear]").val());			//종료년
	formObj.find("input[name=wrttimeMinYear]").val(formSch.find("input[name=wrttimeMinYear]").val());			//시작년
	formObj.find("input[name=wrttimeMaxYear]").val(formSch.find("input[name=wrttimeMaxYear]").val());			//종료년
	formObj.find("select[name=wrttimeStartQt]").val(formSch.find("select[name=wrttimeStartQt]").val());			//시작쿼터
	formObj.find("select[name=wrttimeEndQt]").val(formSch.find("select[name=wrttimeEndQt]").val());				//종료쿼터
	formObj.find("input[name=wrttimeMinQt]").val(formSch.find("input[name=wrttimeMinQt]").val());				//시작쿼터
	formObj.find("input[name=wrttimeMaxQt]").val(formSch.find("input[name=wrttimeMaxQt]").val());				//시작쿼터
	formObj.find("input[name=wrttimeType][value="+formSch.find("input[name=wrttimeType]:checked").val()+"]").prop("checked", true);	//검색시점타입(기간인지 시점인지)

	// 기준시점대비화면의 기준시점콤보박스
	if ( formObj.find("#dtaWrttimeYear").length > 0 ) {	
		formObj.find("#dtaWrttimeYear").val(formSch.find("#dtaWrttimeYear").val());
	}
	if ( formObj.find("#dtaWrttimeQt").length > 0 ) {	
		formObj.find("#dtaWrttimeQt").val(formSch.find("#dtaWrttimeQt").val());
	}
	// 사칙연산, 기준시점대비화면의 NULL값 0으로 계산 체크박스
	if ( formObj.find("#dtaCalcNullToZero").length > 0 ) {	
		formObj.find("#dtaCalcNullToZero").prop("checked", formSch.find("#dtaCalcNullToZero").is(":checked") ? true : false);
	}
	// 사칙연산 계산식
	if ( formObj.find("#calcAqn").length > 0 ) {	
		formObj.find("#calcAqn").val(formSch.find("#calcAqn").val());
	}
	// 사칙연산 지표명
	if ( formObj.find("#calcAqnNm").length > 0 ) {	
		formObj.find("#calcAqnNm").val(formSch.find("#calcAqnNm").val());
	}
}

//----------------------- 피봇 관련 함수[시작] ---------------------------
/**
 * 탭추가 완료후 피봇설정 팝업DIV 세팅
 */
function viewOptionStatDivSet() {
	var objTab = getTabShowObj();// 탭이 open된 객체가져옴
	var formObj = objTab.find("form[name=statsEasy-mst-form]");
	var viewLocOptVal = "B";
	var viewLotOptST = "H";
	var viewLotOptSC = "L";
	var viewLotOptSI = "H";
	var viewLotOptSG = "H";

	if ($("#searchType").val() == "U") {
		// 통계스크랩으로 접근시
		viewLocOptVal = getStringParam("viewLocOpt");
		viewLotOptST = getStringParam("optST");
		viewLotOptSC = getStringParam("optSC");
		viewLotOptSI = getStringParam("optSI");
		viewLotOptSG = getStringParam("optSG");
	}

	// 보기옵션
	var viewObj = tabloadRadioOptions(formObj, "viewLocOpt-sect", "viewLocOpt", "/portal/stat/statOption.do", {grpCd : "S1110", langGb : $("#langGb").val()}, viewLocOptVal, {});

	if (viewObj) {
		// 표두/표측(시계열)
		tabloadRadioOptions(formObj, "optST-sect", "optST", "/portal/stat/statOption.do", {grpCd : "S1106", langGb : $("#langGb").val()}, viewLotOptST, {});
		// 표두/표측(분류)
		tabloadRadioOptions(formObj, "optSC-sect", "optSC", "/portal/stat/statOption.do", {grpCd : "S1106", langGb : $("#langGb").val()}, viewLotOptSC, {});
		// 표두/표측(항목)
		tabloadRadioOptions(formObj, "optSI-sect", "optSI", "/portal/stat/statOption.do", {grpCd : "S1106", langGb : $("#langGb").val()}, viewLotOptSI, {});
		// 표두/표측(그룹)
		tabloadRadioOptions(formObj, "optSG-sect", "optSG", "/portal/stat/statOption.do", {grpCd : "S1106", langGb : $("#langGb").val()}, viewLotOptSG, {});		

	}

	//피봇설정 팝업 버튼이벤트 설정
	viewOptionStatEvent();
}

/**
 * 피봇설정 팝업 버튼이벤트 설정
 */
function viewOptionStatEvent() {
	var objTab = getTabShowObj();// 탭이 open된 객체가져옴
	var formObj = objTab.find("form[name=statsEasy-mst-form]");
	
	// 사용자보기 자동선택
	formObj.find($("input[name=optST]")).click(function() { // 사용자보기 - 시계열
		var $radios = $('input:radio[name=viewLocOpt]');
		$radios.filter('[value=U]').prop('checked', true);
	});
	formObj.find($("input[name=optSI]")).click(function() { // 사용자보기 - 항목
		var $radios = $('input:radio[name=viewLocOpt]');
		$radios.filter('[value=U]').prop('checked', true);
	});
	formObj.find($("input[name=optSC]")).click(function() { // 사용자보기 - 분류
		var $radios = $('input:radio[name=viewLocOpt]');
		$radios.filter('[value=U]').prop('checked', true);
	});
	formObj.find($("input[name=optSG]")).click(function() { // 사용자보기 - 그룹
		var $radios = $('input:radio[name=viewLocOpt]');
		$radios.filter('[value=U]').prop('checked', true);
	});
	
	// 피봇설정 적용버튼
	formObj.find("a[name=optRefresh]").bind("click", function(event) {
		if (searchValidation(formObj)) {
			// 20180508/김정호 - validation 하고 팝업 닫도록 수정(년월 보기 focus 때문에)
			formObj.find($(".layerPopup.optPop")).hide();
			showLoading();

			if(formObj.find("a[title=Sheet]").parents("li").hasClass("on")){
				reCreateSheet();	//통계 시트 새로조회
			}else{
//				alert("피봇설정은 Sheet를 재조회 합니다.")
				reCreateSheet();	//통계 시트 새로조회
			}
		}
	});
}

/**
 * sheet 상단에 피봇 값에 따라 설정한 값 이미지 표시 
 */
function showSheetPivotImg() {
	var objTab = getTabShowObj();// 탭이 open된 객체가져옴
	var formObj = objTab.find("form[name=statsEasy-mst-form]");
	
	var viewLocOpt = formObj.find("input[name=viewLocOpt]:checked").val();
	var imgPos = 0;
	if 		( viewLocOpt == "H" ) {	imgPos = 0 }	// 기본보기(가로보기)
	else if ( viewLocOpt == "V" ) {	imgPos = 1 }	// 세로보기
	else if ( viewLocOpt == "T" ) {	imgPos = 2 }	// 년월보기
	formObj.find(".pivotLocImg").removeClass("on").eq(imgPos).addClass("on");
}
/**
 * 탭추가 완료후 해당 탭에 RadioOption처리
 */
function tabloadRadioOptions(obj, id, name, url, data, value, options) {

	var isIdDiff = options.isIdDiff || false;
	var isDisEle = options.isDisEle || false;

	var tgId = "";
	if (id == "viewLocOpt-sect") {
		tgId = obj.find($(".list1.viewLocOpt-sect"));
	} else {
		tgId = obj.find($("."+id));
	}
	tgId.empty();

	// 옵션을 검색한다.
	$.ajax({
			type : 'POST',
			url : com.wise.help.url(url),
			data : data,
			success : function(data) {
				var data_val = data.data;
				if (data_val) {

					for (var i = 0; i < data_val.length; i++) {
						var radio = $("<span class=\"radio\"><input type=\"radio\" /> <label></label></span>");
						if (id == "viewLocOpt-sect") {
							radio = $("<li class=\"half\"><div><label><input type=\"radio\" /><span></span></label>");

							switch (data_val[i].code) {
							case "B":
								radio = $("<li class=\"half\"><div><label><input type=\"radio\" /><span class=\"tag\"></span></label><i><img src=\"" + com.wise.help.url("/images/soportal/ico_pivot_1.png") + "\" alt=\"\" /></i></div></li>");
								break;
							case "H":
								radio = $("<li class=\"half\"><div><label><input type=\"radio\" /><span class=\"tag\"></span></label><i><img src=\"" + com.wise.help.url("/images/soportal/ico_pivot_2.png") + "\" alt=\"\" /></i></div></li>");
								break;
							case "V":
								radio = $("<li class=\"half\"><div><label><input type=\"radio\" /><span class=\"tag\"></span></label><i><img src=\"" + com.wise.help.url("/images/soportal/ico_pivot_4.png") + "\" alt=\"\" /></i></div></li>");
								break;
							case "T":
								radio = $("<li class=\"half\"><div><label><input type=\"radio\" /><span class=\"tag\"></span></label><i><img src=\"" + com.wise.help.url("/images/soportal/ico_pivot_3.png") + "\" alt=\"\" /></i></div></li>");
								break;
							case "U":
								radio = $("<li><div><label><input type=\"radio\" /><span class=\"tag\"></span></label><i><img src=\"" + com.wise.help.url("/images/soportal/ico_pivot_5.png") + "\" alt=\"ico_pivot_5\" /></i>"
										+ "<ul class=\"list2\" name=\"viewLocOptUsr-sect\" >"
										+ "<li>"
										+ "		<div class=\"cell tit\">"+jsMsg06+"</div><div class=\"optST-sect\"></div>"
										+ "</li>"
										+ "<li>"
										+ "		<div class=\"cell tit\">"+jsMsg00+"</div><div class=\"optSG-sect\"></div>"
										+ "</li>"
										+ "<li>"
										+ "		<div class=\"cell tit\">"+jsMsg07+"</div><div class=\"optSI-sect\"></div>"
										+ "</li>"
										+ "<li>"
										+ "		<div class=\"cell tit\">"+jsMsg08+"</div><div class=\"optSC-sect\"></div>"
										+ "</li>" + "</ul>" + "</div></li>");
								break;
							default:
								return;
								break;
							}
						} else {
							switch (data_val[i].code) {
							case "H":
								radio = $("<div class=\"cell\"><label><input type=\"radio\" /><span class=\"tag\"></span></label><i><img src=\"" + com.wise.help.url("/images/soportal/ico_pivot_5_1.png") + "\" alt=\"\" /></i></div>");
								break;
							case "L":
								radio = $("<div class=\"cell\"><label><input type=\"radio\" /><span class=\"tag\"></span></label><i><img src=\"" + com.wise.help.url("/images/soportal/ico_pivot_5_2.png") + "\" alt=\"\" /></i></div>");
								break;
							default:
								return;
								break;
							}
						}

						if (isIdDiff) {
							eleId = id + "-" + data_val[i].code;
						} else {
							eleId = id + "-" + i;
						}

						radio.find("input").attr("name", name).val(data_val[i].code).prop("checked", data_val[i].code == value);
						radio.find("span[class=tag]").attr("for", eleId).text(data_val[i].name);

						tgId.append(radio);
					}
				}
			},
			dataType : 'json',
			async : false
		});

	return true;
}
//----------------------- 피봇 관련 함수[종료] ---------------------------

//----------------------- 증감분석 관련 함수[시작] ---------------------------
/**
 * 탭추가 완료후 통계표 옵션 조회(단위변환, 소수점단위, 통계자료 형태)
 */
function getMixStatTblOption() {
	var objTab = getTabShowObj();//탭이 open된 객체가져옴
	var formObj = objTab.find("form[name=statsEasy-mst-form]");
	
	var sId = formObj.find("input[name=statblId]").val();
	
	if(sId != undefined){
		if(sId == "") sId = $("#sId").val();
	}
	
	// 항목 정보를 [통계검색]화면의 DIV에서 받아서 세팅한다.
	var dvsIdNm = "dvs"+sId;
	
	// 생성된 탭의 증감분석DIV ID를 변경한다.
	formObj.find("ul[id^='treeDvsDataTab']").attr('id', dvsIdNm);

	//파라미터로 접근 한 경우 java에서 넘어온 파라미터값으로 param 값 넘겨준다.
	var params = null;
	if ( isFirst ) {
 		params = $("#firParam").val() + "&searchType=" + $("#searchType").val();
 	} else {
 		params = getMixContainerVals() + "&" + formObj.serialize();	// 현재 열려있는탭 시의 선택항목을 변수로 사용
 	}
	
	// 복수통계 유형에 따른 증감분석 목록 조회 URL, 파라미터 설정
	var searchUrl = "/portal/stat/statMultiTblDtadvs.do"
 	if ( MULTI_STAT_TYPE == "BP" ) {	// 기준시점대비
 		searchUrl = "/portal/stat/statOption.do";
 		params = "grpCd=S1251"
 	}
		
	//통계자료 체크박스 로드
	$.ajax({
		  type: 'POST',
		  url: com.wise.help.url(searchUrl),
		  data: params,
		  dataType: 'json',
		  async:false,
		  success: function(res1) {
			  if (res1.data) {
				  var data = res1.data;
				  var treeData = new Array();
				  // 기준시점대비 변동분석 화면의 증감데이터는 기존과 다른 기준정보에서 가져온다
				  if ( MULTI_STAT_TYPE == "BP" ) {
					  for (var i = 0; i < data.length; i++) {
						  var valName = new Object();
						  valName.title = data[i].name;
						  valName.key = data[i].code;
						  valName.isFolder = false;	
						  valName.children = "";
						  valName.select = true;	// 전체 체크
						  treeData.push(valName);
					  }
				  }
				  else {
					  for (var i = 0; i < data.length; i++) {
						  var valName = new Object();

						  valName.title = data[i].optNm;
						  valName.key = data[i].optVal;
						  valName.isFolder = false;	
						  valName.children = "";

						  if (data[i].optVal == "OD") valName.select = true;
						  else valName.select = false;

						  treeData.push(valName);
					  }
				  }

				setMakeTabTree(dvsIdNm, treeData);

				  if ($("#firParam").val() != "") {
					  //통계스크랩 조회시 스크랩한 통계자료코드를 체크
					  setUsrTblChk(dvsIdNm, "dtadvsVal");
				  }
					
				  makeItmTreeChk(dvsIdNm, "dtadvsVal");
			  }
		  }
	});
	
	/* 증감분석 버튼 이벤트 추가 */
	mixStatTblEvent();
	
}

/**
 * 증감분석 버튼 이벤트 추가
 */
function mixStatTblEvent() {
	var objTab = getTabShowObj();// 탭이 open된 객체가져옴
	var formObj = objTab.find("form[name=statsEasy-mst-form]");
	var dvsTreeNm = formObj.find($(".layerPopup.dvsPop")).find("ul").attr('id');
	
	formObj.find("button[name=tabDvsAllChk]").bind("click", function(event) {
		treeNodeControl(dvsTreeNm, "CHK")});		//전체선택

	formObj.find("button[name=tabDvsAllUnChk]").bind("click", function(event) {
		treeNodeControl(dvsTreeNm, "UN_CHK")});	//전체해제

	// 증감분석 검색
	formObj.find("button[name=tabDvsSearch]").bind("click", function(event) {
		var dvsKeyword = formObj.find("input[name=tabDvsKeyword]").val();
		searchNode(dvsTreeNm, dvsKeyword);
	});
	// 증감분석검색창 enter
	formObj.find("input[name=tabDvsKeyword]").bind("keydown", function(event) {
		// 엔터키인 경우
		if (event.which == 13) {
			var dvsTreeId = formObj.find($(".layerPopup.dvsZtree")).find("ul").attr('id');
			var dvsKeyword = formObj.find("input[name=tabDvsKeyword]").val();
			searchNode(dvsTreeNm, dvsKeyword);
			return false;
		}
	});
	
	// 증감분석 적용버튼
	formObj.find("a[name=dvsApply]").bind("click", function(event) {
		if ( searchValidation(formObj) ) {
			treeChkApply(dvsTreeNm, "dtadvsVal");
			reCreateSheet();
		}
	});
	
}
//----------------------- 증감분석 관련 함수[종료] ---------------------------

//----------------------- 항복/분류 관련 함수[시작] ---------------------------
// 탭추가 완료후 항목DIV 및 분류DIV 복제 > 복제시 ID값을 변경한다.
function itmStatDivSet(statblId) {
	var objTab = getTabShowObj();// 탭이 open된 객체가져옴
	var formObj = objTab.find("form[name=statsEasy-mst-form]");

	// 그룹 정보를 [통계검색]화면의 DIV에서 받아서 세팅한다.
	var grpIdNm = "grp" + statblId;
	// 생성된 탭의 항목DIV ID를 변경한다. 
	formObj.find("ul[id^='treeGrpDataTab']").attr('id', grpIdNm);
	var treeGrpObj = $("#treeGrpData").dynatree("getTree");
	if ( gfn_isNull(treeGrpObj.tnRoot.childList) ) {	
		formObj.find("button[name=callPopGrp]").hide(); // 데이터가 없으면 버튼을 보이지 않게 한다.
	} else {
		var grpNodes = treeGrpObj.tnRoot.childList;
		var dynaData = new Array();
		
		$.each(grpNodes, function(key, value){
			var grpTreeData = new Object();
			grpTreeData.title = value.data.title;
			grpTreeData.key = value.data.key;
			grpTreeData.select = value.bSelected;
			grpTreeData.isFolder = value.data.isFolder;
			grpTreeData.expand = true;
			grpTreeData.children = childMake(value.childList);
			dynaData.push(grpTreeData);
		});
		setMakeTabTree(grpIdNm, dynaData);

		// 세팅된 트리에서 체크된 항목을 hidden으로 생성
		makeItmTreeChk(grpIdNm, "chkGrps");
	}
	
	// 항목 정보를 [통계검색]화면의 DIV에서 받아서 세팅한다.
	var itmIdNm = "itm" + statblId;
	// 생성된 탭의 항목DIV ID를 변경한다.
	formObj.find("ul[id^='treeItmDataTab']").attr('id', itmIdNm);
	var treeItmObj = $("#treeItmData").dynatree("getTree");
	if (treeItmObj.tnRoot.childList.length == 1) {
		formObj.find("button[name=callPopItm]").hide(); // 데이터가 없으면 버튼을 보이지 않게 한다.
	} else {
		var itmNodes = treeItmObj.tnRoot.childList;
		var dynaData = new Array();
		
		$.each(itmNodes, function(key, value){
			var itmTreeData = new Object();
			itmTreeData.title = value.data.title;
			itmTreeData.key = value.data.key;
			itmTreeData.select = value.bSelected;
			itmTreeData.isFolder = value.data.isFolder;
			itmTreeData.expand = true;
			itmTreeData.children = childMake(value.childList);
			dynaData.push(itmTreeData);
		});
		setMakeTabTree(itmIdNm, dynaData);

		// 세팅된 트리에서 체크된 항목을 hidden으로 생성
		makeItmTreeChk(itmIdNm, "chkItms");
	}

	// 분류 정보를 [통계검색]화면의 DIV에서 받아서 세팅한다.
	var clsIdNm = "cls" + statblId;
	// 생성된 탭의 분류DIV ID를 변경한다.
	formObj.find("ul[id^='treeClsDataTab']").attr('id', clsIdNm);
	var treeClsObj = $("#treeClsData").dynatree("getTree");
	if (treeClsObj.tnRoot.childList.length == 1) {
		formObj.find("span[class=spanCls]").hide(); // 데이터가 없으면 버튼을 보이지 않게 한다.
	} else {
		var clsNodes = treeClsObj.tnRoot.childList;
		var dynaData = new Array();
		
		$.each(clsNodes, function(key, value){
			var clsTreeData = new Object();
			clsTreeData.title = value.data.title;
			clsTreeData.key = value.data.key;
			clsTreeData.select = value.bSelected;
			clsTreeData.isFolder = value.data.isFolder;
			clsTreeData.expand = true;
			clsTreeData.children = childMake(value.childList);
			dynaData.push(clsTreeData);
		});
		setMakeTabTree(clsIdNm, dynaData);

		// 세팅된 트리에서 체크된 항목을 hidden으로 생성
		makeItmTreeChk(clsIdNm, "chkClss");
	}

	/* 항목 분류 이벤트 설정 */
	itmStatDivEvent();
	
	function childMake(data){
		var reData = new Array();
		if(data != undefined){
			$.each(data, function(key, value){
				var treeData = new Object();
				
				treeData.title = value.data.title;
				treeData.key = value.data.key;
				treeData.select = value.bSelected;
				treeData.isFolder = value.data.isFolder;
				treeData.expand = true;
				treeData.children = childMake(value.childList);
				
				reData.push(treeData);
			});
		}
		return reData;
	}
}
/**
 * 항목 분류 이벤트 설정
 */
function itmStatDivEvent() {
	
	var objTab = getTabShowObj();// 탭이 open된 객체가져옴
	var formObj = objTab.find("form[name=statsEasy-mst-form]");
	var statblId = formObj.find("input[name=statblId]").val();
	
	// 그룹 DIV팝업 버튼 세팅
	formObj.find("button[name=tabGrpAllExpand]").bind("click", function() 	{treeNodeControl("grp" + statblId, "EXP")}); 	// 펼침
	formObj.find("button[name=tabGrpAllUnExpand]").bind("click", function() {treeNodeControl("grp" + statblId, "UN_EXP")}); // 닫기
	formObj.find("button[name=tabGrpAllChk]").bind("click", function() 		{treeNodeControl("grp" + statblId, "CHK")}); 	// 전체선택
	formObj.find("button[name=tabGrpAllUnChk]").bind("click", function() 	{treeNodeControl("grp" + statblId, "UN_CHK")}); // 전체해제
	// 항목 검색
	formObj.find("button[name=tabGrpSearch]").bind("click", function(event) {
		var grpKeyword = formObj.find("input[name=tabGrpKeyword]").val();
		grpKeyword = htmlTagFilter(grpKeyword);
		if(grpKeyword == false) {
			grpKeyword="";
			formObj.find("input[name=tabGrpKeyword]").val("");
		}
		searchNode("grp" + statblId, grpKeyword);
	});
	// 그룹검색창 enter
	formObj.find("input[name=tabGrpKeyword]").bind("keydown", function(event) {
		// 엔터키인 경우
		if (event.which == 13) {
			var grpTreeId = formObj.find($(".layerPopup.grpZtree")).find("ul").attr('id');
			var grpKeyword = formObj.find("input[name=tabGrpKeyword]").val();
			grpKeyword = htmlTagFilter(grpKeyword);
			if(grpKeyword == false) {
				grpKeyword="";
				formObj.find("input[name=tabGrpKeyword]").val("");
			}
			searchNode("grp" + statblId, grpKeyword);
			return false;
		}
	});	
	// 항목 DIV팝업 버튼 세팅
	formObj.find("button[name=tabItmAllExpand]").bind("click", function() 	{treeNodeControl("itm" + statblId, "EXP")}); 	// 펼침
	formObj.find("button[name=tabItmAllUnExpand]").bind("click", function() {treeNodeControl("itm" + statblId, "UN_EXP")}); // 닫기
	formObj.find("button[name=tabItmAllChk]").bind("click", function() 		{treeNodeControl("itm" + statblId, "CHK")}); 	// 전체선택
	formObj.find("button[name=tabItmAllUnChk]").bind("click", function() 	{treeNodeControl("itm" + statblId, "UN_CHK")}); // 전체해제
	// 항목 검색
	formObj.find("button[name=tabItmSearch]").bind("click", function(event) {
		var itmKeyword = formObj.find("input[name=tabItmKeyword]").val();
		searchNode("itm" + statblId, itmKeyword);
	});
	// 항목검색창 enter
	formObj.find("input[name=tabItmKeyword]").bind(
			"keydown",
			function(event) {
				// 엔터키인 경우
				if (event.which == 13) {
					var itmTreeId = formObj.find($(".layerPopup.itmZtree")).find("ul").attr('id');
					var itmKeyword = formObj.find("input[name=tabItmKeyword]").val();
					searchNode("itm" + statblId, itmKeyword);
					return false;
				}
			});

	// 분류 DIV팝업 버튼 세팅
	formObj.find($("button[name=tabClsAllExpand]")).bind("click", function() 	{treeNodeControl("cls" + statblId, "EXP")}); 	// 펼침
	formObj.find($("button[name=tabClsAllUnExpand]")).bind("click", function() 	{treeNodeControl("cls" + statblId, "UN_EXP")}); // 닫기
	formObj.find($("button[name=tabClsAllChk]")).bind("click", function() 		{treeNodeControl("cls" + statblId, "CHK")}); 	// 전체선택
	formObj.find($("button[name=tabClsAllUnChk]")).bind("click", function() 	{treeNodeControl("cls" + statblId, "UN_CHK")}); // 전체해제
	// 분류 검색
	formObj.find("button[name=tabClsSearch]").bind("click", function(event) {
		var clsKeyword = formObj.find("input[name=tabClsKeyword]").val();
		searchNode("cls" + statblId, clsKeyword);
	});
	// 분류검색창 enter
	formObj.find("input[name=tabClsKeyword]").bind("keydown", function(event) {
		// 엔터키인 경우
		if (event.which == 13) {
			var clsTreeId = formObj.find($(".layerPopup.clsZtree")).find("ul").attr('id');
			var clsKeyword = formObj.find("input[name=tabClsKeyword]").val();
			searchNode("cls" + statblId, clsKeyword);
			return false;
		}
	});

	// 그룹 선택 적용
	formObj.find("a[name=grpApply]").bind("click", function(event) {
		if ( searchValidation(formObj) ) {
			treeChkApply("itm" + statblId, "chkItms");
			treeChkApply("cls" + statblId, "chkClss");
			treeChkApply("grp" + statblId, "chkGrps");
			treeChkApply(formObj.find($(".layerPopup.dvsPop")).find("ul").attr('id'), "dtadvsVal");
			
			if(formObj.find("a[title=Sheet]").parents("li").hasClass("on")){
				reCreateSheet();	//통계 시트 새로조회
			}else if(formObj.find("a[title=Chart]").parents("li").hasClass("on")){
				doLoadChart();		//통계  차트 새로조회
			}else{
				alert("Map 새로고침");
				return false;
			}
		}
	});
	
	// 항목 선택 적용
	formObj.find("a[name=itmApply]").bind("click", function(event) {
		if ( searchValidation(formObj) ) {
			treeChkApply("itm" + statblId, "chkItms");
			treeChkApply("cls" + statblId, "chkClss");
			treeChkApply("grp" + statblId, "chkGrps");
			treeChkApply(formObj.find($(".layerPopup.dvsPop")).find("ul").attr('id'), "dtadvsVal");
			
			if(formObj.find("a[title=Sheet]").parents("li").hasClass("on")){
				reCreateSheet();	//통계 시트 새로조회
			}else if(formObj.find("a[title=Chart]").parents("li").hasClass("on")){
				doLoadChart();		//통계  차트 새로조회
			}else{
				alert("Map 새로고침");
				return false;
			}
		}
	});
	
	// 분류 선택 적용
	formObj.find("a[name=clsApply]").bind("click", function(event) {
		if ( searchValidation(formObj) ) {
			treeChkApply("itm" + statblId, "chkItms");
			treeChkApply("cls" + statblId, "chkClss");
			treeChkApply("grp" + statblId, "chkGrps");
			treeChkApply(formObj.find($(".layerPopup.dvsPop")).find("ul").attr('id'), "dtadvsVal");
			
			if(formObj.find("a[title=Sheet]").parents("li").hasClass("on")){
				reCreateSheet();	//통계 시트 새로조회
			}else if(formObj.find("a[title=Chart]").parents("li").hasClass("on")){
				doLoadChart();		//통계  차트 새로조회
			}else{
				alert("Map 새로고침");
				return false;
			}
		}
	});
	
}

/**
 * 메인폼 검색주기 display
 */
function setDtacycleDisplay() {
	doAjax({
		url : "/portal/stat/statDtacycleList.do",
		params : {statblId : $("#sId").val(), langGb : $("#langGb").val()},
		callback : function(data) {
			// 주기 display
			var dtacycleCdDisplay = [];
			for ( var d in data.data ) {
				dtacycleCdDisplay.push(data.data[d].name);
			}
			$("#dtacycleCdDisplay").text(dtacycleCdDisplay.join(", "));
		}
	});
		
}

/**
 * 메인폼 검색기간(수록기간) display
 * @returns
 */
function setWrttimeDisplay() {
	// 데이터 기준으로 설정
	var dtacycleCd = dtacycleCd || $("form[name=searchForm]").find('select[name=dtacycleCd] :selected').val();
	
	// 기간
	$.ajax({
		type : 'POST',
		dataType : 'json',
		async : false,
		url : com.wise.help.url("/portal/stat/statWrtTimeOption.do"),
		data : {
			statblId : $("#sId").val(),
			langGb : $("#langGb").val()
		},
		success : function(res) {
			if (res.data) {
				var data = res.data;
				$("#wrttimeDisplay").text(data[0].code + "~" + data[data.length-1].code );
				$("#hdnWrttimeDisplayMin").val(data[0].code);	// 존재하는 데이터의 최소년도(히든값)
				$("#hdnWrttimeDisplayMax").val(data[data.length-1].code);	// 최대년도(히든값)
			}
		}
	});
}

