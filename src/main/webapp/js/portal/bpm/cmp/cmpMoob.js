/**
 * 의정활동별 공개 - 위원회 구성/계류법안 - 계류법안 스크립트 파일이다.
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
	var form = $("#moobForm");
	//옵션정보를 로드한다.
	loadCmpMoobOptions();
	// 이벤트를 바인딩한다.
	bindCmpMoobEvent();
	
	// 목록 리스트를 조회한다.
	searchCmpMoob(1);
	
	$(window).width() <= 980 ? form.find("#btnDownload").remove() : false; 
});

/**
 * 옵션정보를 로드한다.
 */
function loadCmpMoobOptions() {
	var formObj = $("#moobForm");
	
	// 위원회
	loadTabComboOptions(formObj, "cmitCd", "/portal/assm/search/searchAssmMembCommCd.do", {listNo: 206}, "", true);
}

/**
 * 데이터를 조회한다.
 * @param page	페이지번호
 * @returns
 */
function searchCmpMoob(page) {
	page = page || 1;
	doSearch({
		url : "/portal/bpm/cmp/searchCmpMoob.do",
		page : page,
		before : beforeSearchCmpMoob,
		after : afterSearchCmpMoob,
		pager : "moob-pager-sect"
	});
}

/**
 * 목록 리스트 페이징 조회 전처리
 */
function beforeSearchCmpMoob(options) {
	var form = $("#moobForm");
	
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
function afterSearchCmpMoob(datas) {
	var row = null,
		data = null,
		list = $("#moob-result-sect"),
		item = 
			"<tr>" +
			"	<td class=\"billNo\"></td>" +
			"	<td class=\"cmitNm \"></td>" +
			"	<td class=\"billName left\"></td>" +
			"	<td class=\"proposerKind\"></td>" +
			"	<td class=\"proposer\"></td>" +
			"	<td class=\"proposeDt\"></td>" +
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
function bindCmpMoobEvent() {
	var formObj = $("#moobForm");
	
	// 조회
	formObj.find("#btnSch").bind("click", function() {
		searchCmpMoob(1);
		return false;
	}).bind("keydown", function(event) {
		if ( event.which == 13 ) {
			searchCmpMoob(1);
			return false;
		}
	});
	
	// 조회 엔터이벤트
	formObj.find("input[name=billName]").bind("keydown", function(event) {
		if ( event.which == 13 ) {
			searchCmpMoob(1);
			return false;
		}
	});

	
	
	// 엑셀 다운로드
	formObj.find("#btnDownload").bind("click", function() {
		var data = formObj.serializeObject();
		var searchParamCnt = 0;
		if ( com.wise.util.isBlank(data.cmitCd) )		searchParamCnt++;
		if ( com.wise.util.isBlank(data.billName) )	searchParamCnt++;
		
		
		if ( searchParamCnt > 1) {
			alert("1가지 이상 조회조건을 입력하세요.");
			return false;
		}
	    gfn_fileDownload({
	    	url: "/portal/bpm/downExcel.do",
	    	params: formObj.serialize()
	    });
	});	
}