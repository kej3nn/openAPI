/**
 * 통합 - 정책자료&보고서 - 연구용역 연구보고서 스크립트 파일이다.
 * 
 * @author JHKIM
 * @version 1.0 2019/11/09
 */
////////////////////////////////////////////////////////////////////////////////
// GLOBAL VARIABLE
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// SCRIPT INIT
////////////////////////////////////////////////////////////////////////////////
$(function() {
		
	// 이벤트를 로드한다.
	bindSrvReportEvent();
	
	// 데이터를 조회한다.
	searchSrvReportList(1);
	
	var form = $("#srvForm");
	$(window).width() <= 980 ? form.find("#btnDownload").hide() : false
});

/**
 * 옵션정보를 로드한다.
 */
function loadSrvReportOptions() {
	
}

/**
 * 데이터를 조회한다.
 * @param page	페이지번호
 * @returns
 */
function searchSrvReportList(page) {
	page = page || 1;
	doSearch({
		url : "/portal/assm/pdta/searchPdtaRschSrvReport.do",
		page : page,
		before : beforeSearchSrvReportList,
		after : afterSearchSrvReportList,
		pager : "srv-pager-sect"
	});
}

/**
 * 목록 리스트 페이징 조회 전처리
 */
function beforeSearchSrvReportList(options) {
	var form = $("#srvForm");
	
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
function afterSearchSrvReportList(datas) {
	var row = null,
		data = null,
		list = $("#srv-result-sect"),
		item = 
			"<tr>" +
			"	<td class=\"rownum\"></td>" +
			"	<td class=\"unitNm\"></td>" +
			"	<td class=\"rptTit left\"></td>" +
			"	<td class=\"rptAutNm\"></td>" +
			"	<td class=\"rptDt\"></td>" +
			"	<td class=\"fileUrl\"><a href=\"javascript:;\" target=\"_blank\"><img src=\"/images/icon_addfile.png\" alt=\"첨부파일\"></a></td>" +
			"</tr>";
	
	list.empty();
	
	if ( datas.length > 0 ) {
		for ( var i in datas ) {
			data = datas[i];
			
			row = $(item);
			
			row.find(".rownum").text(data.ROW_NUM);
			
			Object.keys(data).map(function(key, idx) {
				if ( key == "rptTit" ) {
					if ( !com.wise.util.isEmpty(data.linkUrl) ) {
						var linkA = $("<a href=\"javascript:;\">"+data[key]+"</a>");
						linkA.bind("click", {param: data}, function(event) {
							if ( !com.wise.util.isEmpty(event.data.param.linkUrl) ) {
								gfn_openPopup({url: event.data.param.linkUrl});
							}
						});
						
						row.find("." + key).append(linkA);
					}
					
					row.find("." + key).text(data[key]);
				}
				else if ( key == "fileUrl" ) {
					row.find("." + key).find("a").attr("href", data[key]);
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
function bindSrvReportEvent() {
	var formObj = $("#srvForm");
	
	// 조회
	formObj.find("#btnSch").bind("click", function() {
		searchSrvReportList(1);
		return false;
	}).bind("keydown", function(event) {
		if ( event.which == 13 ) {
			$(this).click();
			return false;
		}
	});
	
	// 조회 엔터이벤트
	formObj.find("input[name=rptTit]").bind("keydown", function(event) {
		if ( event.which == 13 ) {
			searchSrvReportList(1);
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