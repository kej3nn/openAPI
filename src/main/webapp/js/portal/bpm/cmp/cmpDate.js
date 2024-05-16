/**
 * 의정활동별 공개 - 위원회 구성/계류법안 - 위원회 일정 스크립트 파일이다.
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
	//옵션정보를 로드한다.
	loadCmpDateOptions()
	// 이벤트를 바인딩한다.
	bindCmpDateEvent();
	
	// 목록 리스트를 조회한다.
	searchCmpDate(1);
	
	var form = $("#dateForm");
	// 일자 캘린더
	gfn_portalCalendar(form.find("#frMeetingDate"));
	gfn_portalCalendar(form.find("#toMeetingDate"));
	
	form.find("#frMeetingDate").datepicker('option', 'onClose',  function( selectedDate ) {form.find("#toMeetingDate").datepicker( "option", "minDate", selectedDate );});
	form.find("#toMeetingDate").datepicker('option', 'onClose',  function( selectedDate ) {	form.find("#frMeetingDate").datepicker( "option", "maxDate", selectedDate );});	
	
	$(window).width() <= 980 ? form.find("#btnDownload").remove() : false; 
});

/**
 * 옵션정보를 로드한다.
 */
function loadCmpDateOptions() {
	var formObj = $("#dateForm");

	// 위원회(수정필요)
	loadTabComboOptions(formObj, "cmitCd", "/portal/assm/search/searchAssmMembCommCd.do", {listNo: 206}, "", true);
}
/**
 * 데이터를 조회한다.
 * @param page	페이지번호
 * @returns
 */
function searchCmpDate(page) {
	page = page || 1;
	doSearch({
		url : "/portal/bpm/cmp/searchCmpDate.do",
		page : page,
		before : beforeSearchCmpDate,
		after : afterSearchCmpDate,
		pager : "date-pager-sect"
	});
}

/**
 * 목록 리스트 페이징 조회 전처리
 */
function beforeSearchCmpDate(options) {
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
function afterSearchCmpDate(datas) {
	var row = null,
		data = null,
		list = $("#date-result-sect"),
		item = 
			"<tr>" +
			"	<td class=\"ROW_NUM\"></td>" +
			"	<td class=\"committeeName\"></td>" +
			"	<td class=\"meettingDateTime\"></td>" +
			"	<td class=\"title\"></td>" +
			"	<td class=\"meetingsession\"></td>" +
			"	<td class=\"cha\"></td>" +
			"	<td class=\"resultDownUrl\"><a href=\"javascript:;\"></a></td>" +
			"</tr>";
	downImg = "<img src=\"/images/icon_addfile.png\" alt=\"첨부파일\">",
	newImg = "<img src=\"/images/icon_new.png\" alt=\"new\" class=\"icon_new\">";

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
				else if ( key == "resultDownUrl" && !com.wise.util.isEmpty(data[key]) ) {
					row.find("." + key).find("a")
						.attr("href", data[key] || "javascript:;")
						.append(downImg);
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
function bindCmpDateEvent() {
	var formObj = $("#dateForm");
	
	// 조회
	formObj.find("#btnSch").bind("click", function() {
		searchCmpDate(1);
		return false;
	}).bind("keydown", function(event) {
		if ( event.which == 13 ) {
			searchCmpDate(1);
			return false;
		}
	});
	
	// 조회 엔터이벤트
	formObj.find("input[name=title]").bind("keydown", function(event) {
		if ( event.which == 13 ) {
			searchCmpDate(1);
			return false;
		}
	});

	// 다운로드
	formObj.find("#btnDownload").bind("click", function() {
		return false;
	}).bind("keydown", function(event) {
		if ( event.which == 13 ) {
			return false;
		}
	});
	
	
	// 엑셀 다운로드
	formObj.find("#btnDownload").bind("click", function() {
		var data = formObj.serializeObject();
		var searchParamCnt = 0;
		if ( com.wise.util.isBlank(data.cmitCd) )		searchParamCnt++;
		if ( com.wise.util.isBlank(data.title) )	searchParamCnt++;
		if ( com.wise.util.isBlank(data.frMeetingDate) )	searchParamCnt++;
		if ( com.wise.util.isBlank(data.toMeetingDate) )	searchParamCnt++;
		
		
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