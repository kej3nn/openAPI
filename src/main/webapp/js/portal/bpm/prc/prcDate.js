/**
 * 의정활동별 공개 - 본회의 안건처리 - 본회의 일정 스크립트 파일이다.
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
	// 이벤트를 바인딩한다.
	bindPrcDateEvent();
	
	// 목록 리스트를 조회한다.
	searchPrcDate(1);
	
	// 일자 캘린더
	var form = $("#dateForm");
	
	gfn_portalCalendar(form.find("#frMeetingDate"));
	gfn_portalCalendar(form.find("#toMeetingDate"));
	
	form.find("#frMeetingDate").datepicker('option', 'onClose',  function( selectedDate ) {form.find("#toMeetingDate").datepicker( "option", "minDate", selectedDate );});
	form.find("#toMeetingDate").datepicker('option', 'onClose',  function( selectedDate ) {	form.find("#frMeetingDate").datepicker( "option", "maxDate", selectedDate );});
	
	$(window).width() <= 980 ? form.find("a[name=btnDownload]").remove() : false; // 모바일 접근 여부
		
	
});

/**
 * 데이터를 조회한다.
 * @param page	페이지번호
 * @returns
 */
function searchPrcDate(page) {
	page = page || 1;
	doSearch({
		url : "/portal/bpm/prc/searchPrcDate.do",
		page : page,
		before : beforeSearchPrcDate,
		after : afterSearchPrcDate,
		pager : "date-pager-sect"
	});
}

/**
 * 목록 리스트 페이징 조회 전처리
 */
function beforeSearchPrcDate(options) {
	var form = $("#dateForm");
	
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
function afterSearchPrcDate(datas) {
	var row = null,
		data = null,
		list = $("#date-result-sect"),
		item = 
			"<tr>" +
			"	<td class=\"ROW_NUM\"></td>" +
			"	<td class=\"meettingDateTime\"></td>" +
			"	<td class=\"meetingsession\"></td>" +
			"	<td class=\"cha\"></td>" +
			"	<td class=\"title\"></td>" +
			"</tr>";

	list.empty();
	
	if ( datas.length > 0 ) {
		
		_.forEach(datas, function(data, i) {
			row = $(item);
			
			row.find(".rownum").text(Number(i)+1);

			Object.keys(data).map(function(key, idx) {
				
				if ( key == "title" ) {
					if ( !com.wise.util.isEmpty(data.linkUrl) ) {
						var linkA = $("<a title=\"새창열림_대한민국 국회\" href=\"javascript:;\">"+data[key]+"</a>");
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
function bindPrcDateEvent() {
	var formObj = $("#dateForm");
	
	// 조회
	formObj.find("a[name=btnSch]").bind("click", function() {
		searchPrcDate(1);
		return false;
	}).bind("keydown", function(event) {
		if ( event.which == 13 ) {
			searchPrcDate(1);
			return false;
		}
	});
	
	// 조회 엔터이벤트
	formObj.find("input[name=title], input[name=meetingsession]").bind("keydown", function(event) {
		if ( event.which == 13 ) {
			searchPrcDate(1);
			return false;
		}
	});

	// 엑셀 다운로드
	formObj.find("a[name=btnDownload]").bind("click", function() {
	    gfn_fileDownload({
	    	url: "/portal/bpm/downExcel.do",
	    	params: formObj.serialize()
	    });
	});	
	
}