/**
 * 통합 - 의원일정 - 위원회 의사일정 스크립트 파일
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
	bindCmteEvent();
	
	// 데이터를 조회한다.
	searchAssmSchdCmteList(1);
	
	var form = $("#cmteForm");
	$(window).width() <= 980 ? form.find("#btnDownload").hide() : false
});

/**
 * 데이터를 조회한다.
 * @param page	페이지번호
 * @returns
 */
function searchAssmSchdCmteList(page) {
	page = page || 1;
	doSearch({
		url : "/portal/assm/schd/searchAssmSchdCmte.do",
		page : page,
		before : beforeSearchAssmSchdCmteList,
		after : afterSearchAssmSchdCmteList,
		pager : "cmte-pager-sect"
	});
}

/**
 * 목록 리스트 페이징 조회 전처리
 */
function beforeSearchAssmSchdCmteList(options) {
	var form = $("#cmteForm");
	
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
function afterSearchAssmSchdCmteList(datas) {
	var row = null,
		data = null,
		list = $("#cmte-result-sect"),
		item = 
			"<tr>" +
			"	<td class=\"rownum\"></td>" +
			"	<td class=\"unitNm\"></td>" +
			"	<td class=\"committeeName\"></td>" +
			"	<td class=\"meetingsession\"></td>" +
			"	<td class=\"cha\"></td>" +
			"	<td class=\"title left\"></td>" +
			"	<td class=\"meetingDateTime\"></td>" +
			"	<td class=\"fileUrl\"><a href=\"javascript:;\"></a></td>" +
			"	<td class=\"resultDownUrl\"><a href=\"javascript:;\"></a></td>" +
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
				if ( key == "title" ) {
					if ( !com.wise.util.isEmpty(data.linkUrl) ) {
						var linkA = $("<a title=\"새창열림_위원회 의사일정\" href=\"javascript:;\">"+data[key]+"</a>");
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
				else if ( key == "fileUrl" && !com.wise.util.isEmpty(data[key]) ) {
					row.find("." + key).find("a")
						.attr("href", data[key] || "javascript:;")
						.append(downImg);
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
function bindCmteEvent() {
	var formObj = $("#cmteForm");
	
	// 조회
	formObj.find("#btnSch").bind("click", function() {
		searchAssmSchdCmteList(1);
		return false;
	}).bind("keydown", function(event) {
		if ( event.which == 13 ) {
			searchAssmSchdCmteList(1);
			return false;
		}
	});
	
	// 조회 엔터이벤트
	formObj.find("input[name=title]").bind("keydown", function(event) {
		if ( event.which == 13 ) {
			searchAssmSchdCmteList(1);
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