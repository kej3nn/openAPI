/**
 * 국회의원 메인 - 의원일정 스크립트 파일
 * 
 * @author JHKIM
 * @version 1.0 2019/10/22
 */
////////////////////////////////////////////////////////////////////////////////
// GLOBAL VARIABLE
////////////////////////////////////////////////////////////////////////////////
/* 현재날짜 */
var CONST_TODAY = new Date();

////////////////////////////////////////////////////////////////////////////////
// SCRIPT INIT
////////////////////////////////////////////////////////////////////////////////
$(function() {
	
	// 일정을 초기화한다.
//	initSchedule();			// 200915-역대국회의원 조회 기능 추가로 인한 기능제거
	
	// 검색옵션을 조회한다.
	loadSchdOptions();
	
	// 이벤트를 바인딩한다.
	bindSchdEvent();
	
	// 데이터를 조회한다.
	searchAssmSchdList(1);
});
/*
function initSchedule() {
	var formObj = $("#schdForm");
	var year = CONST_TODAY.getFullYear();		// 현재년
	var month = CONST_TODAY.getMonth() + 1;		// 현재월
	
	formObj.find("input[name=meetingYM]").val(year + "-" + (month < 10 ? com.wise.util.lpad("0", 1)+ month : month));
	formObj.find(".year_choose strong").text(year + "년 " + month + "월");
	
	searchAssmSchdList(1);
	
}*/
/**
 * 검색옵션을 조회한다.
 */
function loadSchdOptions() {
	var formObj = $("#schdForm");
	
	// 일자 캘린더
	gfn_portalCalendar(formObj.find("#meetingDate"));
	
	// 구분
	loadTabComboOptions(formObj, "radioGubun", "/portal/assm/searchAssmCommCd.do", {gCmCd: "SCHEDULE"}, "", true);
}

/**
 * 데이터를 조회한다.
 * @param page	페이지번호
 * @returns
 */
function searchAssmSchdList(page) {
	page = page || 1;
	doSearch({
		url : "/portal/assm/schd/searchAssmSchd.do",
		page : page,
		before : beforeSearchAssmSchdList,
		after : afterSearchAssmSchdList,
		pager : "schd-pager-sect"
	});
}

/**
 * 목록 리스트 페이징 조회 전처리
 */
function beforeSearchAssmSchdList(options) {
	
	parent.gfn_showLoading();
	
	var form = $("#schdForm");
	
	if (com.wise.util.isEmpty(options.page)) {
		form.find("[name=page]").val("1");
	} 
	else {
		form.find("[name=page]").val(options.page);
	}
	
	var data = form.serializeObject();
	
	data["empNo"] = $("input[name=empNo]", parent.document).val();		// 부모 iframe 값
//	data["unitCd"] = $("input[name=unitCd]", parent.document).val();	// 부모 iframe 값

	return data;
}

/**
 * 목록 리스트 페이징 조회 후처리
 */
function afterSearchAssmSchdList(datas) {
	var row = null,
		data = null,
		list = $("#schd-result-sect"),
		item = 
			"<tr>" +
			"	<td class=\"rownum\"></td>" +
			"	<td class=\"gubunNm\"></td>" +
			"	<td class=\"title left\"><a href=\"javascript:;\"></a></td>" +
			"	<td class=\"meetingDate\"></td>" +
			"	<td class=\"meetingTime\"></td>" +
			"</tr>",
		newImg = "<img src=\"/images/icon_new.png\" alt=\"new\" class=\"icon_new\">";

	list.empty();
	
	if ( datas.length > 0 ) {
		for ( var i in datas ) {
			data = datas[i];
			
			row = $(item);
			
			row.find(".rownum").text(data.ROW_NUM);

			Object.keys(data).map(function(key, idx) {
				if ( key == "title" ) {
					row.find("." + key).find("a").text(data["meetingsession"] + " " + data[key])
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
	
	parent.gfn_hideLoading();
}

/**
 * 이벤트를 바인딩한다.
 */
function bindSchdEvent() {
	var formObj = $("#schdForm");
	
	// 조회
	formObj.find("#btnSch").bind("click", function() {
		searchAssmSchdList(1);
		return false;
	}).bind("keydown", function(event) {
		if ( event.which == 13 ) {
			searchAssmSchdList(1);
			return false;
		}
	});
	
	// 조회 엔터이벤트
	formObj.find("input[name=title]").bind("keydown", function(event) {
		if ( event.which == 13 ) {
			searchAssmSchdList(1);
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
	
	/*
	// 일정 이전월
	formObj.find(".btn_calendar_prev").bind("click", function() {
		CONST_TODAY = new Date(CONST_TODAY.getFullYear(), CONST_TODAY.getMonth() - 1, CONST_TODAY.getDate());
		initSchedule();
	});
	
	// 일정 다음월
	formObj.find(".btn_calendar_next").bind("click", function() {
		CONST_TODAY = new Date(CONST_TODAY.getFullYear(), CONST_TODAY.getMonth() +1, CONST_TODAY.getDate());
		initSchedule();
	});*/
}