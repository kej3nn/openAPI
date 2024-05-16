/**
 * 국회의원 메인 - 의원실알림 스크립트 파일
 * 
 * @author JHKIM
 * @version 1.0 2019/10/22
 */
////////////////////////////////////////////////////////////////////////////////
// GLOBAL VARIABLE
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// SCRIPT INIT
////////////////////////////////////////////////////////////////////////////////
$(function() {
	// 검색옵션을 조회한다.
	loadNotiOptions();
	
	// 이벤트를 바인딩한다.
	bindNotiEvent();
	
	// 데이터를 조회한다.
	searchAssmNotiList(1);
});

function loadNotiOptions() {
	var formObj = $("#notiForm");
	
	// 일자 캘린더
	gfn_portalCalendar(formObj.find("input[name=regDtD]"));
	
	// 구분
	loadTabComboOptions(formObj, "bbsCdN", "/portal/assm/searchAssmCommCd.do", {gCmCd: "BBS"}, "", true);
}

/**
 * 데이터를 조회한다.
 * @param page	페이지번호
 * @returns
 */
function searchAssmNotiList(page) {
	page = page || 1;
	doSearch({
		url : "/portal/assm/noti/searchAssmNoti.do",
		page : page,
		before : beforeSearchAssmNotiList,
		after : afterSearchAssmNotiList,
		pager : "noti-pager-sect"
	});
}

/**
 * 목록 리스트 페이징 조회 전처리
 */
function beforeSearchAssmNotiList(options) {
	
	parent.gfn_showLoading();
	
	var form = $("#notiForm");
	
	if (com.wise.util.isEmpty(options.page)) {
		form.find("[name=page]").val("1");
	} 
	else {
		form.find("[name=page]").val(options.page);
	}
	
	var data = form.serializeObject();
	
	data["empNo"] = $("input[name=empNo]", parent.document).val();		// 부모 iframe 값

	return data;
}

/**
 * 목록 리스트 페이징 조회 후처리
 */
function afterSearchAssmNotiList(datas) {
	var row = null,
		data = null,
		list = $("#noti-result-sect"),
		item = 
			"<tr>" +
			"	<td class=\"rownum\"></td>" +
			"	<td class=\"bbsNm\"></td>" +
			"	<td class=\"titleV left\"><a href=\"javascript:;\"></a></td>" +
			"	<td class=\"regDtD\"></td>" +
			"</tr>",
		downImg = "<img src=\"/images/icon_addfile.png\" alt=\"첨부파일\">",
		newImg = "<img src=\"/images/icon_new.png\" alt=\"new\" class=\"icon_new\">";

	list.empty();
	
	if ( datas.length > 0 ) {
		for ( var i in datas ) {
			data = datas[i];
			
			row = $(item);
			
			row.find(".rownum").text(data.ROW_NUM);
			
			Object.keys(data).map(function(key, idx) {
				if ( key == "noticeYnC" && data[key] == "Y" ) {
					row.addClass("header_notice");	// 공지인경우 줄 강조표시
				}
				else if ( key == "fileUrl" && !com.wise.util.isEmpty(data[key]) ) {
					row.find("." + key).find("a")
						.attr("href", data[key] || "javascript:;")
						.append(downImg);
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
		list.append("<tr><td colspan=\""+ (row.find("td").length) +"\">조회된 일정이 없습니다.</td></tr>");
	}
	
	parent.gfn_hideLoading();
}

/**
 * 이벤트를 바인딩한다.
 */
function bindNotiEvent() {
	var formObj = $("#notiForm");
	
	// 조회
	formObj.find("#btnSch").bind("click", function() {
		searchAssmNotiList(1);
		return false;
	}).bind("keydown", function(event) {
		if ( event.which == 13 ) {
			searchAssmNotiList(1);
			return false;
		}
	});
	
	// 조회 엔터이벤트
	formObj.find("input[name=titleV]").bind("keydown", function(event) {
		if ( event.which == 13 ) {
			searchAssmNotiList(1);
			return false;
		}
	});
	
	// 엑셀 다운로드
	formObj.find("#btnDownload").bind("click", function() {

		formObj.find("input[name=excelNm]").val(parent.$(".assemblyman_name strong").text());
		
		if ( formObj.find("input[name=empNo]").length == 0 ) {
			formObj.append("<input type='hidden' name='empNo' value='"+$("input[name=empNo]", parent.document).val()+"'>");
		}
		
	    gfn_fileDownload({
	    	url: "/portal/assm/downExcel.do",
	    	params: formObj.serialize()
	    });
	});
}