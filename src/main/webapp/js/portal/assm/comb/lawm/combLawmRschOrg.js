/**
 * 통합 - 의정활동 - 연구단체  스크립트 파일이다.
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
		
	// 이벤트를 로드한다.
	bindRschOrgEvent();
	
	// 데이터를 조회한다.
	searchRschOrgList(1);
	
	var form = $("#orgForm");
	$(window).width() <= 980 ? form.find("#btnDownload").hide() : false
});

/**
 * 옵션정보를 로드한다.
 */
function loadRschOrgOptions() {
	
}

/**
 * 데이터를 조회한다.
 * @param page	페이지번호
 * @returns
 */
function searchRschOrgList(page) {
	page = page || 1;
	doSearch({
		url : "/portal/assm/lawm/searchLawmRschOrg.do",
		page : page,
		before : beforeSearchRschOrgList,
		after : afterSearchRschOrgList,
		pager : "org-pager-sect"
	});
}

/**
 * 목록 리스트 페이징 조회 전처리
 */
function beforeSearchRschOrgList(options) {
	var form = $("#orgForm");
	
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
function afterSearchRschOrgList(datas) {
	var row = null,
		data = null,
		list = $("#org-result-sect"),
		item = 
			"<tr>" +
			"	<td class=\"rownum\"></td>" +
			"	<td class=\"regdaesu\"></td>" +
			"	<td class=\"reTopicName\"></td>" +
			"	<td class=\"reName left\"></td>" +
			"</tr>";
	
	list.empty();
	
	if ( datas.length > 0 ) {
		for ( var i in datas ) {
			data = datas[i];
			
			row = $(item);
			
			row.find(".rownum").text(data.ROW_NUM);
			
			Object.keys(data).map(function(key, idx) {
				if ( key == "reName" ) {
					if ( !com.wise.util.isEmpty(data.linkUrl) ) {
						var linkA = $("<a title=\"새창열림_대한민국 국회\" href=\"javascript:;\">"+data[key]+"</a>");
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

/**
 * 이벤트를 바인딩한다.
 */
function bindRschOrgEvent() {
	var formObj = $("#orgForm");
	
	// 조회
	formObj.find("#btnSch").bind("click", function() {
		searchRschOrgList(1);
		return false;
	}).bind("keydown", function(event) {
		if ( event.which == 13 ) {
			$(this).click();
			return false;
		}
	});
	
	// 조회 엔터이벤트
	formObj.find("input[name=reTopicName], input[name=reName]").bind("keydown", function(event) {
		if ( event.which == 13 ) {
			searchRschOrgList(1);
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