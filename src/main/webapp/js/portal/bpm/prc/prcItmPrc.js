/**
 * 의정활동별 공개 - 본회의 안건처리 - 본회의 안건처리 스크립트 파일이다.
 * 
 * @author JHKIM
 * @version 1.0 2019/11/06
 */
////////////////////////////////////////////////////////////////////////////////
// GLOBAL VARIABLE
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// SCRIPT INIT
////////////////////////////////////////////////////////////////////////////////
$(function() {
	// 이벤트를 바인딩한다.
	bindPrcItmPrcEvent();
	
	// 법률안 목록 리스트를 조회한다.
	searchPrcItmPrcLaw(1);
	
	var form = $("#itmPrcForm");
	// 일자 캘린더
	gfn_portalCalendar(form.find("#frRgsProcDt"));
	gfn_portalCalendar(form.find("#toRgsProcDt"));
	
	form.find("#frRgsProcDt").datepicker('option', 'onClose',  function( selectedDate ) {form.find("#toRgsProcDt").datepicker( "option", "minDate", selectedDate );});
	form.find("#toRgsProcDt").datepicker('option', 'onClose',  function( selectedDate ) {	form.find("#frRgsProcDt").datepicker( "option", "maxDate", selectedDate );});
	
	$(window).width() <= 980 ? form.find("a[name=btnDownload]").remove() : false; // 
});

/**
 * 법률안, 기타 데이터를 조회한다.
 * @param page	페이지번호
 * @returns
 */
function searchPrcItmPrcLaw(page) {
	page = page || 1;
	doSearch({
		url : "/portal/bpm/prc/searchPrcItmPrcLaw.do",
		page : page,
		before : beforeSearchPrcItmPrc,
		after : afterSearchPrcItmPrcLaw,
		pager : "itmPrc-law-pager-sect"
	});
}

/**
 * 예산안, 결산 데이터를 조회한다.
 * @param page	페이지번호
 * @returns
 */
function searchPrcItmPrcBdg(page) {
	page = page || 1;
	doSearch({
		url : "/portal/bpm/prc/searchPrcItmPrcBdg.do",
		page : page,
		before : beforeSearchPrcItmPrc,
		after : afterSearchPrcItmPrcBdg,
		pager : "itmPrc-bdg-pager-sect"
	});
}

/**
 * 목록 리스트 페이징 조회 전처리
 */
function beforeSearchPrcItmPrc(options) {
	var form = $("#itmPrcForm");
	
	if (com.wise.util.isEmpty(options.page)) {
		form.find("[name=page]").val("1");
	} 
	else {
		form.find("[name=page]").val(options.page);
	}
	
	var data = form.serializeObject();
	
	var gubun = selectGubun();
	if ( gubun == "LAW" ) {
		form.find("[name=gubun]").val("LAW");
		form.find("#div-gubun-law").show();
		form.find("#div-gubun-bdg").hide()
		form.find("#itmPrc-law-pager-sect").show();
		form.find("#itmPrc-bdg-pager-sect").hide()
	}
	else if ( gubun == "BDG" ) { 
		form.find("[name=gubun]").val("BDG");
		form.find("#div-gubun-law").hide();
		form.find("#div-gubun-bdg").show()
		form.find("#itmPrc-law-pager-sect").hide();
		form.find("#itmPrc-bdg-pager-sect").show()
	}
	
	return data;
}

/**
 * 법률안, 기타 목록 리스트 페이징 조회 후처리
 */
function afterSearchPrcItmPrcLaw(datas) {
	var row = null,
		data = null,
		list = $("#itmPrc-law-result-sect"),
		item = 
			"<tr>" +
			"	<td class=\"ROW_NUM\"></td>" +
			"	<td class=\"billKind\"></td>" +
			"	<td class=\"billNo\"></td>" +
			"	<td class=\"left\"><span class=\"billName\"></span></td>" +
			"	<td class=\"proposerKindCd\"></td>" +
			"	<td class=\"proposer\"></td>" +
			"	<td class=\"committeeName\"></td>" +
			"	<td class=\"procResultCd\"></td>" +
			"	<td class=\"yesTcnt\"></td>" +
			"	<td class=\"noTcnt\"></td>" +
			"	<td class=\"blankTcnt\"></td>" +
			"	<td class=\"proposeDt\"></td>" +
			"	<td class=\"committeeSubmitDt\"></td>" +
			"	<td class=\"committeePresentDt\"></td>" +
			"	<td class=\"committeeProcDt\"></td>" +
			"	<td class=\"lawSubmitDt\"></td>" +
			"	<td class=\"lawPresentDt\"></td>" +
			"	<td class=\"lawProcDt\"></td>" +
			"	<td class=\"rgsPresentDt\"></td>" +
			"	<td class=\"rgsProcDt\"></td>" +
			"	<td class=\"currTransDt\"></td>" +
			"	<td class=\"announceDt\"></td>" +
			"</tr>"
	
	list.empty();
	
	if ( datas.length > 0 ) {
		
		_.forEach(datas, function(data, i) {
			row = $(item);
			
			Object.keys(data).map(function(key, idx) {
				if ( key == "billName" ) {
					var linkA = $("<a title=\"새창열림_의안정보시스템\" href=\"javascript:;\">"+data[key]+"</a>");
					linkA.bind("click", {param: data}, function(event) {
						if ( !com.wise.util.isEmpty(event.data.param.linkUrl) ) {
							gfn_openPopup({url: event.data.param.linkUrl});
						}
					});
					
					row.find("." + key).append(linkA);
				}
				else if ( row.find("." + key).length > 0 ) {
					row.find("." + key).text(data[key]);
				}
			});
			
			list.append(row);
		});
	}
	else {
		row = $(item);
		list.append("<tr><td colspan=\""+ (row.find("td").length) +"\">조회된 데이터가 없습니다.</td></tr>");
	}
}

/**
 * 예산안, 결산안 목록 리스트 페이징 조회 후처리
 */
function afterSearchPrcItmPrcBdg(datas) {
	var row = null,
		data = null,
		list = $("#itmPrc-bdg-result-sect"),
		item = 
			"<tr>" +
			"	<td class=\"ROW_NUM\"></td>" +
			"	<td class=\"billKind\"></td>" +			// 구분
			"	<td class=\"billNo\"></td>" +
			"	<td class=\"left\"><span class=\"billName\"></span></td>" +	// 의안명
			"	<td class=\"procResultCd\"></td>" +	// 의결결과
			"	<td class=\"yesTcnt\"></td>" +		// 표결현황-찬성
			"	<td class=\"noTcnt\"></td>" +		// 반대
			"	<td class=\"blankTcnt\"></td>" +	// 기권
			"	<td class=\"proposeDt\"></td>" +
			"	<td class=\"bdgSubmitDt\"></td>" +	// 예결위 -회부일
			"	<td class=\"bdgPresentDt\"></td>" +	// 예결위-상정일
			"	<td class=\"bdgProcDt\"></td>" +	// 예결위-처리일
			"	<td class=\"rgsPresentDt\"></td>" +	// 본회의심의-상정일
			"	<td class=\"rgsProcDt\"></td>" +	// 본회의심의-의결일
			"	<td class=\"announceDt\"></td>" +	// 정부이송일
			"</tr>"
	
	list.empty();
	
	if ( datas.length > 0 ) {
		
		_.forEach(datas, function(data, i) {
			row = $(item);
			
			Object.keys(data).map(function(key, idx) {
				if ( key == "billName" ) {
					var linkA = $("<a href=\"javascript:;\">"+data[key]+"</a>");
					linkA.bind("click", {param: data}, function(event) {
						if ( !com.wise.util.isEmpty(event.data.param.linkUrl) ) {
							gfn_openPopup({url: event.data.param.linkUrl});
						}
					});
					
					row.find("." + key).append(linkA);
				}
				else if ( row.find("." + key).length > 0 ) {
					row.find("." + key).text(data[key]);
				}
			});
			
			list.append(row);
		});
	}
	else {
		row = $(item);
		list.append("<tr><td colspan=\""+ (row.find("td").length) +"\">조회된 데이터가 없습니다.</td></tr>");
	}
}

/**
 * 이벤트를 바인딩한다.
 */
function bindPrcItmPrcEvent() {
	var formObj = $("#itmPrcForm");
	
	// 의안구분 라디오버튼 선택시
	formObj.find("#td-gubun-sect input[name=billKind]").each(function() {
		$(this).bind("click", function() {
			var gubun = selectGubun();
			if ( gubun == "LAW" ) {
				formObj.find("#div-gubun-law").show();
				formObj.find("#div-gubun-bdg").hide()
				formObj.find("#itmPrc-law-pager-sect").show();
				formObj.find("#itmPrc-bdg-pager-sect").hide()
			}
			else if ( gubun == "BDG" ) { 
				formObj.find("#div-gubun-law").hide();
				formObj.find("#div-gubun-bdg").show()
				formObj.find("#itmPrc-law-pager-sect").hide();
				formObj.find("#itmPrc-bdg-pager-sect").show()
			}
			// 검색조건 초기화
			formObj.find(".theme_select_box input:text, select").val("");
			
			// 검색
			formObj.find("a[name=btnSch]").click();
		});
	});
	
	// 조회
	formObj.find("a[name=btnSch]").bind("click", function() {
		var gubun = selectGubun();
		if ( gubun == "LAW" ) {
			searchPrcItmPrcLaw(1);
		}
		else if ( gubun == "BDG" ) { 
			searchPrcItmPrcBdg(1);
		}
		return false;
	}).bind("keydown", function(event) {
		if ( event.which == 13 ) {
			$(this).click();
			return false;
		}
	});
	
	// 조회 엔터이벤트
	formObj.find("input[name=billName]").bind("keydown", function(event) {
		if ( event.which == 13 ) {
			event.preventDefault();
			formObj.find("a[name=btnSch]").click();
			return false;
		}
	});

	
	
	// 엑셀 다운로드
	formObj.find("a[name=btnDownload]").bind("click", function() {
		var data = formObj.serializeObject();
		var searchParamCnt = 0;
		if ( com.wise.util.isBlank(data.procResultCd) )		searchParamCnt++;
		if ( com.wise.util.isBlank(data.frRgsProcDt) )	searchParamCnt++;
		if ( com.wise.util.isBlank(data.toRgsProcDt) )	searchParamCnt++;
		if ( com.wise.util.isBlank(data.billName) )	searchParamCnt++;

		
		if ( searchParamCnt > 2 ) {
			alert("2가지 이상 조회조건을 입력하세요.");
			return false;
		}
		
	    gfn_fileDownload({
	    	url: "/portal/bpm/downExcel.do",
	    	params: formObj.serialize()
	    });
	});	
}

/**
 * 의안구분에 따른 선택처리
 */
function selectGubun() {
	var rtnGubun = "";
	var gubun = $("#itmPrcForm #td-gubun-sect input[name=billKind]:checked").attr("id") || "";
	
	if ( gubun == "billKindLaw" ) {
		rtnGubun = "LAW";
	}
	else if ( gubun == "billKindBudget" ) {
		rtnGubun = "BDG";
	}
	else if ( gubun == "billKindCls" ) {
		rtnGubun = "BDG";
	}
	else if ( gubun == "billKindEtc" ) {
		rtnGubun = "LAW";
	}
	
	return rtnGubun;
}
