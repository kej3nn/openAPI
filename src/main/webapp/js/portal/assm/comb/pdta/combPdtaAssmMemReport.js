/**
 * 통합 - 정책자료&보고서 - 의원저서 스크립트 파일
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
	bindAmrEvent();
	
	// 데이터를 조회한다.
	searchAssmPdtaAmrList(1);
});

/**
 * 데이터를 조회한다.
 * @param page	페이지번호
 * @returns
 */
function searchAssmPdtaAmrList(page) {
	page = page || 1;
	doSearch({
		url : "/portal/assm/pdta/searchAssmPdtaAmr.do",
		page : page,
		before : beforeSearchAssmPdtaAmrList,
		after : afterSearchAssmPdtaAmrList,
		pager : "amr-pager-sect"
	});
}

/**
 * 목록 리스트 페이징 조회 전처리
 */
function beforeSearchAssmPdtaAmrList(options) {
	var form = $("#amrForm");
	
	if (com.wise.util.isEmpty(options.page)) {
		form.find("[name=page]").val("1");
	} 
	else {
		form.find("[name=page]").val(options.page);
	}
	
	var data = form.serializeObject();
	
	data["empNo"] = $("input[name=empNo]").val();		// 부모 iframe 값
	data["unitCd"] = $("input[name=unitCd]").val();	// 부모 iframe 값

	return data;
}

/**
 * 목록 리스트 페이징 조회 후처리
 */
function afterSearchAssmPdtaAmrList(datas) {
	var row = null,
		data = null,
		list = $("#amr-result-sect"),
		item = 
			"<div class=\"assemblyman_book_box\">" +
			"	<div class=\"assemblyman_book_img\">" +
			"		<img src=\"\" alt=\"이미지\">" +
			"	</div>" +
			"	<div class=\"assemblyman_book_content\">" +
			"		<dl>" +
			"			<dt class=\"rptTit\"></dt>" +
			"			<dd class=\"rptAutNm\">저자</dd>" +
//			"			<dd class=\"\">출판사</dd>" +
			"			<dd class=\"rptDt\">출판일</dd>" +
			"		</dl>"
			"		<span class=\"rptCn\"></span>"			
			"	</div>" +
			"</div>";
	
	list.empty();
	
	if ( datas.length > 0 ) {
		for ( var i in datas ) {
			data = datas[i];
			
			row = $(item);
			
			row.find("img").attr("src", com.wise.help.url(data.imgUrl)).attr("alt", data.rptTit);
			row.find(".rptTit").text(data.rptTit);
			row.find(".rptCn").text(data.rptCn);
			row.find(".rptAutNm").text("저자 : " + data.rptAutNm);
//			row.find(".publishName").text("출판사 : " + data.publishName);
			row.find(".rptDt").text("출판일 : " + data.rptDt);
			
			list.append(row);
		}
	}
	else {
		list.append("<div class=\"assemblyman_book_box\">조회된 데이터가 없습니다.</div>");
	}
}

/**
 * 이벤트를 바인딩한다.
 */
function bindAmrEvent() {
	var formObj = $("#amrForm");
	
	// 조회
	formObj.find("#btnSch").bind("click", function() {
		searchAssmPdtaAmrList(1);
		return false;
	}).bind("keydown", function(event) {
		if ( event.which == 13 ) {
			searchAssmPdtaAmrList(1);
			return false;
		}
	});
	
	// 조회 엔터이벤트
	formObj.find("input[name=rptTit]").bind("keydown", function(event) {
		if ( event.which == 13 ) {
			searchAssmPdtaAmrList(1);
			return false;
		}
	});
	
	// 엑셀 다운로드
	formObj.find("#btnDownload").bind("click", function() {

		formObj.find("input[name=excelNm]").val(parent.$(".assemblyman_name strong").text());
		
		if ( formObj.find("input[name=empNo]").length == 0 ) {
			formObj.append("<input type='hidden' name='empNo' value='"+$("input[name=empNo]").val()+"'>");
		}
		if ( formObj.find("input[name=unitCd]").length == 0 ) {
			formObj.append("<input type='hidden' name='unitCd' value='"+$("input[name=unitCd]").val()+"'>");
		}
		
	    gfn_fileDownload({
	    	url: "/portal/assm/downExcel.do",
	    	params: formObj.serialize()
	    });
	});
}