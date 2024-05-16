/**
 * 의정활동별 공개 - 본회의 안건처리 - 본회의 회의록 스크립트 파일이다.
 * 
 * @author JHKIM
 * @version 1.0 2019/11/05
 */
////////////////////////////////////////////////////////////////////////////////
// GLOBAL VARIABLE
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// SCRIPT INIT
////////////////////////////////////////////////////////////////////////////////
$(function() {
	var form = $("#prcdForm");

	//옵션정보를 로드한다.
	loadPrcPrcdOptions();
	// 이벤트를 바인딩한다.
	bindPrcPrcdEvent();
	
	// 목록 리스트를 조회한다.
	searchPrcPrcd(1);
	// 일자 캘린더
	// 일자 캘린더
	gfn_portalCalendar(form.find("#frConfDate"));
	gfn_portalCalendar(form.find("#toConfDate"));
	
	form.find("#frConfDate").datepicker('option', 'onClose',  function( selectedDate ) {form.find("#toConfDate").datepicker( "option", "minDate", selectedDate );});
	form.find("#toConfDate").datepicker('option', 'onClose',  function( selectedDate ) {	form.find("#frConfDate").datepicker( "option", "maxDate", selectedDate );});
	
	$(window).width() <= 980 ? form.find("a[name=btnDownload]").remove() : false; // 
});


/**
 * 옵션정보를 로드한다.
 */
function loadPrcPrcdOptions() {
	var formObj = $("#prcdForm");
	
	// 대수
	loadTabComboOptions(formObj, "unitCd", "/portal/assm/search/searchAssmMembCommCd.do", {listNo: 100}, "", true);
	// 위원회
	loadTabComboOptions(formObj, "cmitCd", "/portal/assm/search/searchAssmMembCommCd.do", {listNo: 206}, "", true);
	
}

/**
 * 데이터를 조회한다.
 * @param page	페이지번호
 * @returns
 */
function searchPrcPrcd(page) {
	page = page || 1;
	doSearch({
		url : "/portal/bpm/prc/searchPrcPrcd.do",
		page : page,
		before : beforeSearchPrcPrcd,
		after : afterSearchPrcPrcd,
		pager : "prcd-pager-sect"
	});
}

/**
 * 목록 리스트 페이징 조회 전처리
 */
function beforeSearchPrcPrcd(options) {
	var form = $("#prcdForm");
	
	if (com.wise.util.isEmpty(options.page)) {
		form.find("[name=page]").val("1");
	} 
	else {
		form.find("[name=page]").val(options.page);
	}
	
	var data = form.serializeObject();
	
	return data;
}

/**
 * 목록 리스트 페이징 조회 후처리
 */
function afterSearchPrcPrcd(datas) {
	var row = null,
		data = null,
		list = $("#prcd-result-sect"),
		item = 
			"<tr>" +
			"	<td class=\"rownum\"></td>" +
			"	<td class=\"daeNum\"></td>" +
			"	<td class=\"confDate\"></td>" +
			"	<td class=\"title left\"></td>" +
			"	<td class=\"left\"><span class=\"subName\"></span></td>" +
			"	<td class=\"vodLinkUrl\"></td>" +
			"	<td class=\"confLinkUrl\"></td>" +
			"</tr>";
	
	list.empty();
	
	if ( datas.length > 0 ) {
		
		_.forEach(datas, function(data, i) {
			row = $(item);
			row.find(".rownum").text(data.ROW_NUM);
			
			Object.keys(data).map(function(key, idx) {
				if ( key == "vodLinkUrl" ) {
					if ( !com.wise.util.isEmpty(data[key]) ) {
						var linkA = $("<a title=\"새창열림_영상회의록시스템\" href=\"javascript:;\"><img src=\"/images/btn_movie.png\" alt=\"영상보기\"></a>");
						linkA.bind("click", {param: data}, function(event) {
							if ( !com.wise.util.isEmpty(event.data.param.vodLinkUrl) ) {
								gfn_openPopup({url: event.data.param.vodLinkUrl});
							}
						});
						
						row.find("." + key).append(linkA);
					}
					else {
						row.find("." + key).text(data[key]);
					}
				}
				else if ( key == "confLinkUrl" ) {
					if ( !com.wise.util.isEmpty(data[key]) ) {
						var linkA = $("<a href=\"javascript:;\" class=\"assm_view\" title=\"새창열림_요약정보\">요약정보</a>");
						linkA.bind("click", {param: data}, function(event) {
							if ( !com.wise.util.isEmpty(event.data.param.confLinkUrl) ) {
								gfn_openPopup({url: event.data.param.confLinkUrl});
							}
						});
						
						row.find("." + key).append(linkA);
					}
					else {
						row.find("." + key).text(data[key]);
					}
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
function bindPrcPrcdEvent() {
	var formObj = $("#prcdForm");
	
	// 조회
	formObj.find("a[name=btnSch]").bind("click", function() {
		searchPrcPrcd(1);
		return false;
	}).bind("keydown", function(event) {
		if ( event.which == 13 ) {
			searchPrcPrcd(1);
			return false;
		}
	});
	
	// 조회 엔터이벤트
	formObj.find("input[name=title], input[name=subName], input[name=unitCd]").bind("keydown", function(event) {
		if ( event.which == 13 ) {
			searchPrcPrcd(1);
			return false;
		}
	});

		
	// 엑셀 다운로드
	formObj.find("a[name=btnDownload]").bind("click", function() {
		var data = formObj.serializeObject();
		var searchParamCnt = 0;
		if ( com.wise.util.isBlank(data.unitCd) )		searchParamCnt++;
		if ( com.wise.util.isBlank(data.frConfDate) )	searchParamCnt++;
		if ( com.wise.util.isBlank(data.ConfDate) )	searchParamCnt++;
		if ( com.wise.util.isBlank(data.subName) )	searchParamCnt++;
		if ( com.wise.util.isBlank(data.title) )	searchParamCnt++;

		
		if ( searchParamCnt > 3 ) {
			alert("2가지 이상 조회조건을 입력하세요.");
			return false;
		}
		
	    gfn_fileDownload({
	    	url: "/portal/bpm/downExcel.do",
	    	params: formObj.serialize()
	    });
	});	
	
}