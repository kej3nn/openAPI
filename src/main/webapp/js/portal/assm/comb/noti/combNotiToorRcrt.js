/**
 * 통합 - 의원실 알림 - 의원실채용 스크립트 파일
 * 
 * @author JHKIM
 * @version 1.0 2019/10/23
 */
////////////////////////////////////////////////////////////////////////////////
// GLOBAL VARIABLE
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// SCRIPT INIT
////////////////////////////////////////////////////////////////////////////////
$(function() {
	
	// 이벤트를 바인딩한다.
	bindRcrtEvent();
	
	// 데이터를 조회한다.
	searchAssmNotiRcrtList(1);
	
	var form = $("#rcrtForm");
	$(window).width() <= 980 ? form.find("#btnDownload").hide() : false
});

/**
 * 데이터를 조회한다.
 * @param page	페이지번호
 * @returns
 */
function searchAssmNotiRcrtList(page) {
	page = page || 1;
	doSearch({
		url : "/portal/assm/noti/searchAssmNotiRcrt.do",
		page : page,
		before : beforeSearchAssmNotiRcrtList,
		after : afterSearchAssmNotiRcrtList,
		pager : "rcrt-pager-sect"
	});
}

/**
 * 목록 리스트 페이징 조회 전처리
 */
function beforeSearchAssmNotiRcrtList(options) {
	var form = $("#rcrtForm");
	
	if (com.wise.util.isEmpty(options.page)) {
		form.find("[name=page]").val("1");
	} 
	else {
		form.find("[name=page]").val(options.page);
	}
	
	var data = form.serializeObject();
	
	data["empNo"] = $("input[name=empNo]").val();		// 부모 iframe 값

	return data;
}

/**
 * 목록 리스트 페이징 조회 후처리
 */
function afterSearchAssmNotiRcrtList(datas) {
	var row = null,
		data = null,
		list = $("#rcrt-result-sect"),
		item = 
			"<tr>" +
			"	<td class=\"rownum\"></td>" +
			"	<td class=\"unitNm\"></td>" +
			"	<td class=\"titleV left\"><a href=\"javascript:;\" title=\"새창열림_의원실 채용\"></a></td>" +
			"	<td class=\"regDtD\"></td>" +
			"	<td class=\"useYn\"></td>" +
			"</tr>",
		newImg = "<img src=\"/images/icon_new.png\" alt=\"new\" class=\"icon_new\">";

	list.empty();
	
	if ( datas.length > 0 ) {
		for ( var i in datas ) {
			data = datas[i];
			
			row = $(item);
			
			row.find(".rownum").text(data.ROW_NUM);
			
			Object.keys(data).map(function(key, idx) {
				if ( key == "noticeYnC" ) {
					if ( data[key] == "Y" ) {
						row.addClass("header_notice");	// 공지인경우 줄 강조표시
					}
				}
				else if ( key == "titleV" ) {
					row.find("." + key).find("a").text(data[key])
						.bind("click", {param: data}, function(event) {
							if ( !com.wise.util.isEmpty(event.data.param.linkUrl) ) {
								gfn_openPopup({url: event.data.param.linkUrl});
							}
						})
				}
				else if ( row.find("." + key).length > 0 ) {
					row.find("." + key).text(data[key]);
				}
			});
			
			list.append(row);
		}
	}
	else {
		row = $(item);
		list.append("<tr><td colspan=\""+ (row.find("td").length) +"\">조회된 데이터가 없습니다.</td></tr>");
	}
}

/**
 * 이벤트를 바인딩한다.
 */
function bindRcrtEvent() {
	var formObj = $("#rcrtForm");
	
	// 조회
	formObj.find("#btnSch").bind("click", function() {
		searchAssmNotiRcrtList(1);
		return false;
	}).bind("keydown", function(event) {
		if ( event.which == 13 ) {
			searchAssmNotiRcrtList(1);
			return false;
		}
	});
	
	// 조회 엔터이벤트
	formObj.find("input[name=titleV]").bind("keydown", function(event) {
		if ( event.which == 13 ) {
			searchAssmNotiRcrtList(1);
			return false;
		}
	});
	
	// 엑셀 다운로드
	formObj.find("#btnDownload").bind("click", function() {

		formObj.find("input[name=excelNm]").val(parent.$(".assemblyman_name strong").text());
		
		if ( formObj.find("input[name=empNo]").length == 0 ) {
			formObj.append("<input type='hidden' name='empNo' value='"+$("input[name=empNo]").val()+"'>");
		}
		
	    gfn_fileDownload({
	    	url: "/portal/assm/downExcel.do",
	    	params: formObj.serialize()
	    });
	});
}