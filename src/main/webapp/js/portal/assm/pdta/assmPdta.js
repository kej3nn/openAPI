/**
 * 국회의원 메인 - 정책자료&보고서 스크립트 파일
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
	loadPdtaOptions();
	
	// 이벤트를 바인딩한다.
	bindPdtaEvent();
	
	// 데이터를 조회한다.
	searchAssmPdtaList(1);
});

/**
 * 검색옵션을 조회한다.
 */
function loadPdtaOptions() {
	
	var formObj = $("#pdtaForm");
	
	// 일자 캘린더
	gfn_portalCalendar(formObj.find("input[name=rptDt]"));
	
	// 구분
	loadTabComboOptions(formObj, "rptDivCd", "/portal/assm/searchAssmCommCd.do", {gCmCd: "REPORT"}, "", true);
}

/**
 * 데이터를 조회한다.
 * @param page	페이지번호
 * @returns
 */
function searchAssmPdtaList(page) {
	page = page || 1;
	doSearch({
		url : "/portal/assm/noti/searchAssmPdta.do",
		page : page,
		before : beforeSearchAssmPdtaList,
		after : afterSearchAssmPdtaList,
		pager : "pdta-pager-sect"
	});
}

/**
 * 목록 리스트 페이징 조회 전처리
 */
function beforeSearchAssmPdtaList(options) {
	
	parent.gfn_showLoading();
	
	var form = $("#pdtaForm");
	
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
function afterSearchAssmPdtaList(datas) {
	var row = null,
		data = null,
		list = $("#pdta-result-sect"),
		item = 
			"<tr>" +
			"	<td class=\"rownum\"></td>" +
			"	<td class=\"rptDivNm\"></td>" +
			"	<td class=\"rptTit left\"><a href=\"javascript:;\"></a></td>" +
			"	<td class=\"rptDt\"></td>" +
			"</tr>";
		downImg = "<img src=\"/images/icon_addfile.png\" alt=\"첨부파일\" style=\"margin-left: 5px;\">",
		newImg = "<img src=\"/images/icon_new.png\" alt=\"new\" class=\"icon_new\">";

	list.empty();
	
	if ( datas.length > 0 ) {
		for ( var i in datas ) {
			data = datas[i];
			
			row = $(item);
			
			row.find(".rownum").text(data.ROW_NUM);
			
			Object.keys(data).map(function(key, idx) {
				if ( key == "rptTit" ) {
					row.find("." + key).find("a").text(data[key]);
					
					if ( data.rptDivCd === "OREPORT" || data.rptDivCd === "RESHR" ) {
						if ( !com.wise.util.isEmpty(data.fileUrl) ) {
							row.find("." + key).find("a").append($(downImg)).attr("href", data.fileUrl);
						}
					}
					else {
						row.find("." + key).find("a").bind("click", {param: data}, function(event) {
							if ( !com.wise.util.isEmpty(event.data.param.linkUrl) ) {
								gfn_openPopup({url: event.data.param.linkUrl});
							}
						});
					}
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
function bindPdtaEvent() {
	var formObj = $("#pdtaForm");
	
	// 조회
	formObj.find("#btnSch").bind("click", function() {
		searchAssmPdtaList(1);
		return false;
	}).bind("keydown", function(event) {
		if ( event.which == 13 ) {
			searchAssmPdtaList(1);
			return false;
		}
	});
	
	// 조회 엔터이벤트
	formObj.find("input[name=rptTit]").bind("keydown", function(event) {
		if ( event.which == 13 ) {
			searchAssmPdtaList(1);
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