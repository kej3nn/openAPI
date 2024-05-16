/**
 * 의정활동별 공개 - 위원회 구성/계류법안 - 위원회 명단 스크립트 파일이다.
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
	//옵션정보를 로드한다.
	loadCmpListOptions()
	
	// 이벤트를 바인딩한다.
	bindCmpListEvent();
	
	// 목록 리스트를 조회한다.
	searchCmpList(1);
	
	var form = $("#listForm");
	 $(window).width() <= 980 ? form.find("#btnDownload").remove() : false; 
	
});


/**
 * 옵션정보를 로드한다.
 */
function loadCmpListOptions() {
	var formObj = $("#listForm");
	
	// 위원회
	loadTabComboOptions(formObj, "deptCd", "/portal/assm/search/searchAssmMembCommCd.do", {listNo: 206}, "", true);
	// 정당코드
	loadTabComboOptions(formObj, "polyCd", "/portal/assm/search/searchAssmMembCommCd.do", {listNo: 101}, "", true);
	// 구성코드
	loadTabComboOptions(formObj, "jobResCd", "/portal/assm/search/searchAssmMembCommCd.do", {listNo: 208}, "", true);
}

/**
 * 데이터를 조회한다.
 * @param page	페이지번호
 * @returns
 */
function searchCmpList(page) {
	page = page || 1;
	doSearch({
		url : "/portal/bpm/cmp/searchCmpList.do",
		page : page,
		before : beforeSearchCmpList,
		after : afterSearchCmpList,
		pager : "list-pager-sect"
	});
}

/**
 * 목록 리스트 페이징 조회 전처리
 */
function beforeSearchCmpList(options) {
	var form = $("#listForm");
	
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
function afterSearchCmpList(datas) {
	var row = null,
		data = null,
		list = $("#list-result-sect"),
		item = 
			"<tr>" +
			"	<td><span class=\"deptNm\"></span></td>" +
			"	<td><span class=\"jobResNm\"></span></td>" +
			"	<td class=\"\">" +
			"		<a href=\"javascript:;\" class=\"nassem_reslut_pic\" title=\"새창열림_국회의원소개\">" +
			"			<div><img class=\"deptImgUrl\" alt=\"\"></div>" +
			"		</a>" +
			"	</td>" +
			"	<td><span class=\"hgNm\"></span></td>" +
			"	<td class=\"polyNm\"></td>" +
			"	<td><span class=\"telNo\"></span></td>" +
			"	<td class=\"left aide\">" +
			"       <dl><dd class=\"staff\"></dd></dl>" +
			"	    <dl><dd class=\"secretary\"></dd></dl>" +
			"	    <dl><dd class=\"secretary2\"></dd></dl>" +
			"   </td>" +
			"</tr>";

	list.empty();
	
	if ( datas.length > 0 ) {
		
		_.forEach(datas, function(data, i) {
			row = $(item);
			
			Object.keys(data).map(function(key, idx) {
				if ( key == "deptImgUrl" ) {
					row.find("." + key)
						.attr("src", data[key])
						.attr("alt", data["hgNm"] + " 국회의원 사진")
						.bind("click", {param: data}, function(event) {
							//gfn_openMembPopup(event.data.param.monaCd);

							gfn_newNowMembPopup(event.data.param.linkUrl);
							return false;
						});
					
					// 2021.11.10 - 웹접근성 처리, 이미지 클릭이벤트
					// 2021.11.16 - 웹접근성 재처리
					//row.find(".nassem_reslut_pic").attr("href", "javascript: gfn_openMembPopup('"+data.monaCd+"')");
					row.find(".nassem_reslut_pic").attr("href", "javascript: gfn_newNowMembPopup('"+data.linkUrl+"')");
				}
				else if ( key == "staff" ) {
					row.find("." + key).text("보좌관 :" + data[key]);
				}
				else if ( key == "secretary" ) {
					row.find("." + key).text("선임비서관 :" + data[key]);
				}
				else if ( key == "secretary2" ) {
					row.find("." + key).text("비서관 :" +data[key]);
				}
				else if ( key == "polyNm" ) {
					row.find("." + key).text(data[key] + "(" + data["origNm"] + ")"  );
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
function bindCmpListEvent() {
	var formObj = $("#listForm");
	
	// 조회
	formObj.find("#btnSch").bind("click", function() {
		searchCmpList(1);
		return false;
	}).bind("keydown", function(event) {
		if ( event.which == 13 ) {
			searchCmpList(1);
			return false;
		}
	});
	
	// 조회 엔터이벤트
	formObj.find("input[name=hgNm]").bind("keydown", function(event) {
		if ( event.which == 13 ) {
			searchCmpList(1);
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