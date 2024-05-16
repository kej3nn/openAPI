/**
 * 통합 - 정책자료&보고서 - 의정보고서 스크립트 파일이다.
 * 
 * @author SBCHOI
 * @version 1.0 2019/11/27
 */
////////////////////////////////////////////////////////////////////////////////
// GLOBAL VARIABLE
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// SCRIPT INIT
////////////////////////////////////////////////////////////////////////////////
$(function() {
		
	// 이벤트를 로드한다.
	bindPltcReportEvent();
	
	// 데이터를 조회한다.
	searchPltcReportList(1);
	
	var form = $("#pltcForm");
	$(window).width() <= 980 ? form.find("#btnDownload").hide() : false
});

/**
 * 옵션정보를 로드한다.
 */
function loadPltcReportOptions() {
	
}

/**
 * 데이터를 조회한다.
 * @param page	페이지번호
 * @returns
 */
function searchPltcReportList(page) {
	page = page || 1;
	doSearch({
		url : "/portal/assm/pdta/searchPdtaPltcReport.do",
		page : page,
		before : beforeSearchPltcReportList,
		after : afterSearchPltcReportList,
		pager : "pltc-pager-sect"
	});
}

/**
 * 목록 리스트 페이징 조회 전처리
 */
function beforeSearchPltcReportList(options) {
	var form = $("#pltcForm");
	
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
function afterSearchPltcReportList(datas) {
	var row = null,
		data = null,
		list = $("#pltc-result-sect"),
		item = 
			"<div class=\"press_interview_box\">"+
			"	<a href=\"#\" class=\"report_title linkUrl\">"+
			" 	</a>"+
			"	<ul class=\"report_list\">"+
			"		<li class=\"rptAutNm\"></li>"+
			"		<li class=\"srcRptDt\"></li>"+
			"	</ul>"+
			"</div>";
	
	list.empty();
	
	if ( datas.length > 0 ) {
		for ( var i in datas ) {
			data = datas[i];
			
			row = $(item);
			
			row.find(".rownum").text(data.ROW_NUM);
			
			Object.keys(data).map(function(key, idx) {
				if ( key == "linkUrl" ) {
					if ( !com.wise.util.isEmpty(data[key]) ) {
						row.find("." + key).bind("click", {param: data}, function(event) {
							gfn_openPopup({url: event.data.param.linkUrl});
						});
						row.find("."+ key).text(data["rptTit"]);
						
						// 원문보기
						row.find(".dtlView").attr("href",  data["linkUrl"]);
					}
				}
				else if ( key == "rptAutNm" ) {
					row.find("." + key).text("발행처 : " + data[key]);
				}
				else if ( key == "srcRptDt" ) {
					row.find("." + key).text("발행년 : " + data[key] + "년");
				}
				else if ( key == "fileUrl" ) {
					if ( !com.wise.util.isEmpty(data[key]) ) {
						row.find("." + key).attr("href",  data[key]);
					}
					else {
						row.find("." + key).remove();
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
		list.append("<div>조회된 데이터가 없습니다.</div>");
	}
	
	gfn_hideLoading();
	
}

/**
 * 이벤트를 바인딩한다.
 */
function bindPltcReportEvent() {
	var formObj = $("#pltcForm");
	
	// 조회
	formObj.find("#btnSch").bind("click", function() {
		searchPltcReportList(1);
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
			searchPltcReportList(1);
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