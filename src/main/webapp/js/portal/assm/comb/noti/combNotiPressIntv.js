/**
 * 통합 - 의원실 알림 - 기자회견 스크립트 파일
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
	bindIntvEvent();
	
	// 데이터를 조회한다.
	searchAssmNotiIntvList(1);
	
	var form = $("#intvForm");
	$(window).width() <= 980 ? form.find("#btnDownload").hide() : false
});

/**
 * 데이터를 조회한다.
 * @param page	페이지번호
 * @returns
 */
function searchAssmNotiIntvList(page) {
	page = page || 1;
	doSearch({
		url : "/portal/assm/noti/searchAssmNotiIntv.do",
		page : page,
		before : beforeSearchAssmNotiIntvList,
		after : afterSearchAssmNotiIntvList,
		pager : "intv-pager-sect"
	});
}

/**
 * 목록 리스트 페이징 조회 전처리
 */
function beforeSearchAssmNotiIntvList(options) {
	var form = $("#intvForm");
	
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
function afterSearchAssmNotiIntvList(datas) {
	var row = null,
		data = null,
		list = $("#press-result-sect"),
		item = 
			"<div class=\"press_interview_box\">" +
			"	<div class=\"press_interview_time\"><span></span><em></em></div>" +
			"	<div class=\"press_interview_subject\"></div>" +
			"	<div class=\"press_interview_name\"></div>" +
			"</div>",
		newImg = "<img src=\"/images/icon_new.png\" alt=\"new\" class=\"icon_new\">";

	list.empty();
	
	if ( datas.length > 0 ) {
		for ( var i in datas ) {
			data = datas[i];
			
			row = $(item);
			
			//row.find(".rownum").text(data.ROW_NUM);
			
			if ( !com.wise.util.isEmpty(data.linkUrl) ) {
				
				var linkA = $("<a href=\"javascript:;\" class=\"press_interview_btn\" title=\"새창열림_국회기자회견\">view</a>");
				linkA.bind("click", {param: data}, function(event) {
					if ( !com.wise.util.isEmpty(event.data.param.linkUrl) ) {
						gfn_openPopup({url: event.data.param.linkUrl});
					}
				});
				row.find(".press_interview_name").after(linkA);
			}
			
			row.find(".press_interview_subject").text(data.titleV);
			row.find(".press_interview_time span").text(data.startDtV);
			row.find(".press_interview_time").find("em").text(" " + data.endDtV);
			row.find(".press_interview_name").text(data.person);
			
			list.append(row);
		}
	}
	else {
		row = $(item);
		list.append("<div>조회된 데이터가 없습니다.</div>");
	}
}

/**
 * 이벤트를 바인딩한다.
 */
function bindIntvEvent() {
	var formObj = $("#intvForm");
	
	// 조회
	formObj.find("#btnSch").bind("click", function() {
		searchAssmNotiIntvList(1);
		return false;
	}).bind("keydown", function(event) {
		if ( event.which == 13 ) {
			searchAssmNotiIntvList(1);
			return false;
		}
	});
	
	// 조회 엔터이벤트
	formObj.find("input[name=titleV]").bind("keydown", function(event) {
		if ( event.which == 13 ) {
			searchAssmNotiIntvList(1);
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