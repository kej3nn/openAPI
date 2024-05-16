/**
 * 의정활동별 공개 - 위원회 구성/계류법안 - 위원회 자료실 스크립트 파일이다.
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
	//옵션정보를 로드한다.
	loadCmpRefROptions();
	
	// 이벤트를 바인딩한다.
	bindCmpRefREvent();
	
	// 목록 리스트를 조회한다.
	searchCmpRefR(1);
	
	var form = $("#refRForm");
	// 일자 캘린더
	gfn_portalCalendar(form.find("#frCreateDt"));
	gfn_portalCalendar(form.find("#toCreateDt"));
	
	form.find("#frCreateDt").datepicker('option', 'onClose',  function( selectedDate ) {form.find("#toCreateDt").datepicker( "option", "minDate", selectedDate );});
	form.find("#toCreateDt").datepicker('option', 'onClose',  function( selectedDate ) {	form.find("#frCreateDt").datepicker( "option", "maxDate", selectedDate );});
	$(window).width() <= 980 ? form.find("#btnDownload").remove() : false; 
});

/**
 * 옵션정보를 로드한다.
 */
function loadCmpRefROptions() {
	var formObj = $("#refRForm");
	
	// 위원회코드
	loadTabComboOptions(formObj, "siteId", "/portal/assm/search/searchAssmMembCommCd.do", {listNo: 206}, "", true);
	
}

/**
 * 데이터를 조회한다.
 * @param page	페이지번호
 * @returns
 */
function searchCmpRefR(page) {
	page = page || 1;
	doSearch({
		url : "/portal/bpm/cmp/searchCmpRefR.do",
		page : page,
		before : beforeSearchCmpRefR,
		after : afterSearchCmpRefR,
		pager : "refr-pager-sect"
	});
}

/**
 * 목록 리스트 페이징 조회 전처리
 */
function beforeSearchCmpRefR(options) {
	var form = $("#refRForm");
	
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
function afterSearchCmpRefR(datas) {
	var row = null,
		data = null,
		list = $("#refr-result-sect"),
		item = 
			"<tr>" +
			"	<td class=\"rownum\"></td>" +
			"	<td class=\"\writerNm\"></td>" +
			"	<td class=\"articleTitle left\"></td>" +
			"	<td class=\"\createDt\"></td>" +
			"</tr>";

	list.empty();
	
	if ( datas.length > 0 ) {
		
		_.forEach(datas, function(data, i) {
			row = $(item);
			
			row.find(".rownum").text(data.ROW_NUM);
			
			Object.keys(data).map(function(key, idx) {
				if( key == "articleTitle" ) {
					if ( !com.wise.util.isEmpty(data.linkUrl) ) {
						var linkA = $("<a title=\"새창열림_국회상임위원회 및 특별위원회\" href=\"javascript:;\">"+data[key]+"</a>");
						linkA.bind("click", {param: data}, function(event) {
							if ( !com.wise.util.isEmpty(event.data.param.linkUrl) ) {
								gfn_openPopup({url: event.data.param.linkUrl});
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
function bindCmpRefREvent() {
	var formObj = $("#refRForm");
	
	// 조회
	formObj.find("#btnSch").bind("click", function() {
		searchCmpRefR(1);
		return false;
	}).bind("keydown", function(event) {
		if ( event.which == 13 ) {
			searchCmpRefR(1);
			return false;
		}
	});
	
	// 조회 엔터이벤트
	formObj.find("input[name=articleTitle]").bind("keydown", function(event) {
		if ( event.which == 13 ) {
			searchCmpRefR(1);
			return false;
		}
	});

	
	// 엑셀 다운로드
	formObj.find("#btnDownload").bind("click", function() {
		var data = formObj.serializeObject();
		var searchParamCnt = 0;
		if ( com.wise.util.isBlank(data.siteId) )		searchParamCnt++;
		if ( com.wise.util.isBlank(data.frCreateDt) )	searchParamCnt++;
		if ( com.wise.util.isBlank(data.toCreateDt) )	searchParamCnt++;
		if ( com.wise.util.isBlank(data.articleTitle) )	searchParamCnt++;
		
		
		if ( searchParamCnt > 2) {
			alert("2가지 이상 조회조건을 입력하세요.");
			return false;
		}
	    gfn_fileDownload({
	    	url: "/portal/bpm/downExcel.do",
	    	params: formObj.serialize()
	    });
	});	
}