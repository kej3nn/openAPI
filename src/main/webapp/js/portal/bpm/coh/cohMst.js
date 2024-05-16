/**
 * 의정활동별 공개 - 인사청문회 스크립트 파일이다.
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
	bindCohEvent();
	
	// 목록 리스트를 조회한다.
	searchCoh(1);
	
});

/**
 * 데이터를 조회한다.
 * @param page	페이지번호
 * @returns
 */
function searchCoh(page) {
	page = page || 1;
	doSearch({
		url : "/portal/bpm/coh/searchCoh.do",
		page : page,
		before : beforeSearchCoh,
		after : afterSearchCoh,
		pager : "coh-pager-sect"
	});
}

/**
 * 목록 리스트 페이징 조회 전처리
 */
function beforeSearchCoh(options) {
	var form = $("#cohForm");
	
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
function afterSearchCoh(datas) {
	var row = null,
		data = null,
		list = $("#coh-result-sect"),
		item = 
			"<tr>" +
			"	<td class=\"appointGrade\"></td>" +	// 직위정보
			"	<td class=\"appointName\"></td>" +	// 후보자명
			"	<td class=\"currCommiittee\"></td>" +	// 소관위원회
			"	<td class=\"mpBookUrl\"><a href=\"javascript:;\"></a></td>" +	// 인사청문실시계획서
			"	<td class=\"proposeDt\"></td>" +	// 제안일자
			"	<td class=\"msBookUrl\"><a href=\"javascript:;\"></a></td>" +	// 의안접수 정보
			"	<td class=\"submitDt\"></td>" +		// 소관위 회부일
			"	<td class=\"presentDt\"></td>" +	// 소관위 상정일
			"	<td class=\"procDt\"></td>" +		// 소관위 처리일
			"	<td class=\"procResult\"></td>" +	// 처리결과
			"	<td class=\"mgBookUrl\"><a href=\"javascript:;\"></a></td>" +
			"</tr>",
		downImg = "<img src=\"/images/icon_addfile.png\" alt=\"첨부파일\">";

	list.empty();
	
	if ( datas.length > 0 ) {
		
		_.forEach(datas, function(data, i) {
			row = $(item);
			
			Object.keys(data).map(function(key, idx) {
				if ( !com.wise.util.isEmpty(data[key]) && (key == "mpBookUrl" || key == "msBookUrl" || key == "mgBookUrl") ) {
					row.find("." + key).find("a")
					.attr("href", data[key] || "javascript:;")
					.append(downImg);
				}
				else if ( key == "currCommiittee" ) {
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
function bindCohEvent() {
	var formObj = $("#cohForm");
	
	// 조회
	formObj.find("#btnSch").bind("click", function() {
		searchCoh(1);
		return false;
	}).bind("keydown", function(event) {
		if ( event.which == 13 ) {
			searchCoh(1);
			return false;
		}
	});
	
	// 조회 엔터이벤트
	formObj.find("input[name=schAppointName], input[name=schAppointGrade], input[name=schCurrCommiittee]").bind("keydown", function(event) {
		if ( event.which == 13 ) {
			searchCoh(1);
			return false;
		}
	});

	// 엑셀 다운로드
	formObj.find("#btnDownload").bind("click", function() {
		    gfn_fileDownload({
	    	url: "/portal/bpm/downExcel.do",
	    	params: formObj.serialize()
	    });
	});	
}