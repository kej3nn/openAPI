/*
 * @(#)easyStatSchPopSearch.js 1.0 2019/07/25
 */

/**
 * 간편통계 팝업 조회관련 처리 스크립트 파일이다.
 * 
 * @author JHKIM
 * @version 1.0 2019/07/25
 */

// ------------------------------------------ [검색주기 시작] -----------------------------------------------------
/**
 * 검색주기를 조회한다.
 * @param dtacycleCd	검색주기 콤보에 선택될 값
 */
function selectDtacycleList(dtacycleCd) {
	var dtacycleCd = dtacycleCd || "";
	doAjax({
		url : "/portal/stat/statDtacycleList.do",
		params : {statblId : $("#statblId").val(), langGb : $("#langGb").val()},
		callback : function(data) {
			initComboOptions("dtacycleCd", data.data, dtacycleCd);
		}
	});
}

/**
 * 검색기간을 조회하고 콤보박스를 생성함
 * @param dtacycleCd	검색기간 콤보에 선택될 값
 */
function selectWrttimeVal(formObj, dtacycleCd) {
	var dtacycleCd = dtacycleCd || $('select[name=dtacycleCd]').val();
	
	// 기간
	$.ajax({
		type : 'POST',
		dataType : 'json',
		async : false,
		url : com.wise.help.url("/portal/stat/statWrtTimeOption.do"),
		data : {
			statblId : $("#statblId").val(),
			dtacycleCd : dtacycleCd,
			optCd : "DC"
		},
		success : function(res1) {
			if (res1.data) {
				
				var dataLen = res1.data.length;
				var endComboCd = dataLen > 1 ? res1.data[dataLen-1].code : "";
				// 콤보 옵션을 초기화한다.
				initComboOptions("wrttimeStartYear", res1.data, "");
				initComboOptions("wrttimeEndYear", res1.data, endComboCd);
				
				formObj.find("input[name=wrttimeMinYear]").val(formObj.find("select[name=wrttimeStartYear] option:first").val());	//년도 시점 최소값
				formObj.find("input[name=wrttimeMaxYear]").val(formObj.find("select[name=wrttimeStartYear] option:last").val());	//년도 시점 최대값
				
				//검색주기 쿼터 생성
				setWrttimeQuater(formObj, dtacycleCd);
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
 * 검색주기 및 검색기간 세팅
 * @Param datas	기본세팅 정보 값
 */
function setDtaWrttimeVal(datas) {
	var formObj = $("form[name=statsEasy-mst-form]");

	if (!gfn_isNull(datas)) {
		//검색주기 콤보박스 생성
		selectDtacycleList(formObj, datas.dtacycleCd);
		//검색기간 콤보박스 생성
		selectWrttimeVal(formObj, datas.dtacycleCd);
		formObj.find("select[name=dtacycleCd]").val(datas.dtacycleCd);	//검색주기
		formObj.find("select[name=wrttimeOrder]").val(datas.wrttimeOrder);	//정렬순서
		formObj.find("input[name=wrttimeLastestVal]").val(datas.wrttimeLastestVal);			//검색갯수
		formObj.find("input[name=wrttimeType][value="+datas.wrttimeType+"]").prop("checked", true);			//검색시점타입
		if(datas.wrttimeStartYear == null){
			datas.wrttimeStartYear = formObj.find("select[name=wrttimeStartYear] option:first").val();
			datas.wrttimeEndYear = formObj.find("select[name=wrttimeEndYear] option:last").val();
		}
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
		
	}
	return true;
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
	
	initComboOptions("wrttimeStartQt", options, "");
	initComboOptions("wrttimeEndQt", options, formObj.find("select[name=wrttimeStartQt] option:last").val());
	
	if ( dtacycleCd == "YY" ) {
		//년도일때는 쿼터정보 숨김
		formObj.find("select[name=wrttimeStartQt]").hide();
		formObj.find("select[name=wrttimeEndQt]").hide();
	} else {
		formObj.find("select[name=wrttimeStartQt]").show();
		formObj.find("select[name=wrttimeEndQt]").show();
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

//------------------------------------------ [검색주기(기간) 종료] -----------------------------------------------------








//------------------------------------------ [피봇설정 시작] -----------------------------------------------------
/**
 * 피봇설정 팝업DIV 세팅
 */
function viewOptionStatDivSet() {
	var formObj = $("form[name=statsEasy-mst-form]");
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
	var viewObj = loadPivotRadioOptions("viewLocOpt-sect", "viewLocOpt", "/portal/stat/statOption.do", {grpCd : "S1110", langGb : $("#langGb").val()}, viewLocOptVal, {});

	if (viewObj) {
		// 표두/표측(시계열)
		loadPivotRadioOptions("optST-sect", "optST", "/portal/stat/statOption.do", {grpCd : "S1106", langGb : $("#langGb").val()}, viewLotOptST, {});
		// 표두/표측(분류)
		loadPivotRadioOptions("optSC-sect", "optSC", "/portal/stat/statOption.do", {grpCd : "S1106", langGb : $("#langGb").val()}, viewLotOptSC, {});
		// 표두/표측(항목)
		loadPivotRadioOptions("optSI-sect", "optSI", "/portal/stat/statOption.do", {grpCd : "S1106", langGb : $("#langGb").val()}, viewLotOptSI, {});
		// 표두/표측(그룹)
		loadPivotRadioOptions("optSG-sect", "optSG", "/portal/stat/statOption.do", {grpCd : "S1106", langGb : $("#langGb").val()}, viewLotOptSG, {});		
	}

}

/**
 * 탭추가 완료후 해당 탭에 RadioOption처리
 */
function loadPivotRadioOptions(id, name, url, data, value, options) {

	var isIdDiff = options.isIdDiff || false;
	var isDisEle = options.isDisEle || false;

	var tgId = "";
	if (id == "viewLocOpt-sect") {
		tgId = $(".viewLocOpt-sect");
	} else {
		tgId = $("."+id);
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
										+ "		<div class=\"cell tit\">"+jsMsg08+"</div><div class=\"optSC-sect\"></div>"
										+ "</li>"
										+ "<li>"
										+ "		<div class=\"cell tit\">"+jsMsg07+"</div><div class=\"optSI-sect\"></div>"
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
//------------------------------------------ [피봇설정 종료] -----------------------------------------------------

/**
 * 통계표 주석 조회
 */
function setStatCmmtList(dtacycleCd) {
	var formObj = $("form[name=statsEasy-mst-form]");
	
	doAjax({
		url : "/portal/stat/selectStatCmmtList.do",
		params : {
			statblId : $("#statblId").val(),
			dtacycleCd : dtacycleCd
		},
		callback : function(res) {
			var data = res.data;
			if ( data.length > 0 ) {
				var cmmtData = "";
				$.each(data, function(key, value) {
					
					if (value.cmmtGubun == "TBL") {
						cmmtData += "<br><span style='color: blue; font-weight:bold;'>" + (gfn_isNull(value.cmmtIdtfr) ? "" : value.cmmtIdtfr) + "</span>" + openRealceAll(value.cmmtCont, "\n","<br/>");
					} else {
						cmmtData += "<br><span style='color: blue; font-weight:bold;'>"+ (gfn_isNull(value.cmmtIdtfr) ? "" : value.cmmtIdtfr) + "</span> "+ openRealceAll(value.cmmtCont, "\n","<br/>") ;
					}    
				});
				
				$('.remark').find($(".cmmt")).empty().append(cmmtData);
				formObj.find(".remark > .cmmt > br").first().remove();		
			}
		}
	});
}

/**
 * 탭추가 완료후 통계표 옵션 조회(단위변환, 소수점단위, 통계자료 형태)
 */
function getStatTblOption() {
	var formObj = $("form[name=statsEasy-mst-form]");
	var sId = $("#statblId").val();
	var langGb = $("input[name=langGb]").val();

	// 항목 정보를 [통계검색]화면의 DIV에서 받아서 세팅한다.
	var dvsIdNm = "dvs" + sId;

	// 생성된 탭의 증감분석DIV ID를 변경한다.
	formObj.find("ul[id^='treeDvsDataTab']").attr('id', dvsIdNm);

	// 통계자료 체크박스 로드
	$.ajax({
		type : 'POST',
		url : com.wise.help.url("/portal/stat/statTblDtadvs.do"),
		data : {
			statblId : sId,
			langGb : langGb
		},
		success : function(res1) {

			if (res1.data) {
				// 콤보 옵션을 초기화한다.
				var data = res1.data;
				var treeData = new Array();

				for (var i = 0; i < data.length; i++) {
					var valName = new Object();

					valName.title = data[i].optNm;
					valName.key = data[i].optVal;
					valName.isFolder = false;	
					valName.children = "";

					if($("#mainCall").val() == "Y"){
						if (data[i].optVal == "OD" || data[i].optVal == "PD" || data[i].optVal == "PR") {
							valName.select = true;
						}else{
							valName.select = false;
						}
					}else{
						if (data[i].optVal == "OD"){
							valName.select = true;
						}else{
							if(data[i].defaultCnt > 0){
								valName.select = true;
							}else{
								valName.select = false;
							}
						}
					}
					treeData.push(valName);
				}
				/* 탭이동시 증감선택정보 재설정*/
				treeData = treeSelectChkData(treeData);

				setMakeTabTree(dvsIdNm, treeData);

				if ($("#firParam").val() != "") {
					// 통계스크랩 조회시 스크랩한 통계자료코드를 체크
					//setUsrTblChk(dvsIdNm, "dtadvsVal");
				}
			}
		},
		dataType : 'json',
		async : false
	});
}