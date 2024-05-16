/**
 * 의정활동 - 영상회의록 스크립트 파일이다.
 * 
 * @author JHKIM
 * @version 1.0 2019/11/16
 */
////////////////////////////////////////////////////////////////////////////////
// GLOBAL VARIABLE
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// SCRIPT INIT
////////////////////////////////////////////////////////////////////////////////
$(function() {
	
	// 이벤트를 로드한다.
	bindVideoEvent();
	
	// 데이터 조회
	searchCombLawmVideoMnts(1)
	
	var form = $("#videoForm");
	$(window).width() <= 980 ? form.find("#btnDownload").hide() : false
});

/**
 * 데이터 조회
 */
function searchCombLawmVideoMnts(page) {
	page = page || 1;
	doSearch({
		url : "/portal/assm/lawm/searchCombLawmVideoMnts.do",
		page : page,
		before : beforeVideoMnts,
		after : afterVideoMnts,
		pager : "video-pager-sect"
	});
}

/**
 * 목록 리스트 페이징 조회 전처리
 */
function beforeVideoMnts(options) {
	var form = $("#videoForm");
	
	if (com.wise.util.isEmpty(options.page)) {
		form.find("[name=page]").val("1");
	} 
	else {
		form.find("[name=page]").val(options.page);
	}
	
	var data = form.serializeObject();
	
	data["empNo"] = $("input[name=empNo]").val();	// 부모 iframe 값
	data["empNm"] = $("input[name=empNm]").val();	// 부모 iframe 값
	
	return data;
}

/**
 * 목록 리스트 페이징 조회 후처리
 */
function afterVideoMnts(datas) {
	var cntObj = {},
		row = null,
		data = null,
		list = $("#video-result-sect"),
		item = 
			"<tr>" +
			"	<td class=\"rownum\"></td>" +
			"	<td class=\"unitNm\"></td>" +
			"	<td class=\"takingDate\"></td>" +
			"	<td class=\"title left\"></td>" +
			"	<td class=\"recTime\"></td>" +
			"	<td class=\"linkUrl\"></td>" +
			"</tr>";
	
	list.empty();
	
	if ( datas.length > 0 ) {
		
		for ( var i in datas ) {
			data = datas[i];
			
			row = $(item);
			
			row.find(".rownum").text(data.ROW_NUM);
			
			Object.keys(data).map(function(key, idx) {
				if ( key == "linkUrl" ) {
					if ( !com.wise.util.isEmpty(data[key]) ) {
						var linkA = $("<a href=\"javascript:;\"><img src=\"/images/btn_movie.png\" title=\"새창열림_영상회의록시스템\" alt=\"영상보기\"></a>");
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
		}
	}
	else {
		row = $(item);
		list.append("<tr><td colspan=\""+ (row.find("td").length) +"\">조회된 데이터가 없습니다.</td></tr>");
	}
}

function bindVideoEvent() {
	var formObj = $("#videoForm");
	
	// 조회
	formObj.find("#btnSch").bind("click", function() {
		searchCombLawmVideoMnts(1);
		return false;
	}).bind("keydown", function(event) {
		if ( event.which == 13 ) {
			$(this).click();
			return false;
		}
	});
	
	// 조회 엔터이벤트
	formObj.find("input[name=title]").bind("keydown", function(event) {
		if ( event.which == 13 ) {
			event.preventDefault();
			formObj.find("#btnSch").click();
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