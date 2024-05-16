/**
 * 의정활동별 공개 - 청원 - 국민동의청원 스크립트 파일이다.
 * 
 * @author JHKIM
 * @version 1.0 2020/02/21
 */
////////////////////////////////////////////////////////////////////////////////
// GLOBAL VARIABLE
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// SCRIPT INIT
////////////////////////////////////////////////////////////////////////////////
$(function() {
	//옵션정보를 로드한다.
	loadPetAssmAprvOptions();
	
	// 이벤트를 바인딩한다.
	bindPetAssmAprvEvent();
	
	// 목록 리스트를 조회한다.
	searchPetAprvNa(1);
	
	// 일자 캘린더
//	gfn_portalCalendar($("#dateForm #meetingDate"));
	var form = $("#petAssmAprvForm");
	$(window).width() <= 980 ? form.find("#btnDownload").hide() : false; 
});

/**
 * 옵션정보를 로드한다.
 */
function loadPetAssmAprvOptions() {
	var formObj = $("#petAssmAprvForm");
	
	// 대수
	//loadTabComboOptions(formObj, "unitCd", "/portal/assm/search/searchAssmMembCommCd.do", {listNo: 100}, "", true);
	// 위원회
	loadTabComboOptions(formObj, "cmitCd", "/portal/assm/search/searchAssmMembCommCd.do", {listNo: 206}, "", true);
}

/**
 * 데이터를 조회한다.
 * @param page	페이지번호
 * @returns
 */
function searchPetAprvNa(page) {
	page = page || 1;
	doSearch({
		url : "/portal/bpm/pet/searchPetAprvNa.do",
		page : page,
		before : beforesearchPetAprvNa,
		after : aftersearchPetAprvNa,
		pager : "aprv-pager-sect"
	});
}

/**
 * 목록 리스트 페이징 조회 전처리
 */
function beforesearchPetAprvNa(options) {
	var form = $("#petAssmAprvForm");
	
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
function aftersearchPetAprvNa(datas) {
	var row = null,
		data = null,
		list = $("#aprv-result-sect"),
		item = 
			"<tr>" +
			"	<td><span class=\"passGubun\"></span></td>" +
			"	<td><span class=\"billNo\"></span></td>" +
			"	<td class=\"left\"><span class=\"billName\"></span></td>" +
			"	<td><span class=\"proposer\"></span></td>" +
			"	<td class=\"proposeDt\"></td>" +
			"	<td class=\"committeeDt\"></td>" +
			"	<td class=\"cmitNm\"></td>" +
			"	<td class=\"procDt\"></td>" +
			"	<td class=\"procResultCd\"></td>" +
			"</tr>";

	list.empty();
	
	if ( datas.length > 0 ) {
		
		_.forEach(datas, function(data, i) {
			row = $(item);
			
			Object.keys(data).map(function(key, idx) {
				
				if ( key == "billName" ) {
					if ( !com.wise.util.isEmpty(data.linkUrl) ) {
						var linkA = $("<a title=\"새창열림_의안정보시스템\" href=\"javascript:;\">"+data[key]+"</a>");
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
function bindPetAssmAprvEvent() {
	var formObj = $("#petAssmAprvForm");
	
	// 조회
	formObj.find("#btnSch").bind("click", function() {
		searchPetAprvNa(1);
		return false;
	}).bind("keydown", function(event) {
		if ( event.which == 13 ) {
			searchPetAprvNa(1);
			return false;
		}
	});
	
	// 조회 엔터이벤트
	formObj.find("input[name=procResultCd], input[name=billName], input[name=approver], input[name=procResultCd]").bind("keydown", function(event) {
		if ( event.which == 13 ) {
			searchPetAprvNa(1);
			return false;
		}
	});

		
	// 엑셀 다운로드
	formObj.find("#btnDownload").bind("click", function() {
		var data = formObj.serializeObject();
		var searchParamCnt = 0;
		if ( com.wise.util.isBlank(data.unitCd) )		searchParamCnt++;
		if ( com.wise.util.isBlank(data.approver) )	searchParamCnt++;
		if ( com.wise.util.isBlank(data.cmitCd) )	searchParamCnt++;
		if ( com.wise.util.isBlank(data.procResultCd) )	searchParamCnt++;
		if ( com.wise.util.isBlank(data.billName) )	searchParamCnt++;
		
		if ( searchParamCnt > 3) {
			alert("2가지 이상 조회조건을 입력하세요.");
			return false;
		}
		    gfn_fileDownload({
	    	url: "/portal/bpm/downExcel.do",
	    	params: formObj.serialize()
	    });
	});	
}