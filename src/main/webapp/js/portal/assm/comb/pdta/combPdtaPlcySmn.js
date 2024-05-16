/**
 * 통합 - 정책자료&보고서 - 정책세미나 스크립트 파일이다.
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
	bindPlcySmnEvent();
	
	// 데이터를 조회한다.
	searchPlcySmnList(1);
	
	var form = $("#smnForm");
	$(window).width() <= 980 ? form.find("#btnDownload").hide() : false
});

/**
 * 옵션정보를 로드한다.
 */
function loadPlcySmnOptions() {
	
}

/**
 * 데이터를 조회한다.
 * @param page	페이지번호
 * @returns
 */
function searchPlcySmnList(page) {
	page = page || 1;
	doSearch({
		url : "/portal/assm/pdta/searchPdtaPlcySmn.do",
		page : page,
		before : beforeSearchPlcySmnList,
		after : afterSearchPlcySmnList,
		pager : "smn-pager-sect"
	});
}

/**
 * 목록 리스트 페이징 조회 전처리
 */
function beforeSearchPlcySmnList(options) {
	var form = $("#smnForm");
	
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
function afterSearchPlcySmnList(datas) {
	var row = null,
		data = null,
		list = $("#smn-result-sect"),
		item = 
			"<div class=\"press_interview_box\">"+
			"	<a href=\"#\" class=\"report_title linkUrl\">"+
			" 	</a>"+
			"	<ul class=\"report_list\">"+
			"		<li class=\"rptAutNm\"></li>"+
			"		<li class=\"srcRptDt\"></li>"+
//			"		<li class=\"rptPlace\"></li>"+
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
						
					}
				}
				else if ( key == "rptAutNm" ) {
					row.find("." + key).text("주최 : " + data[key]);
				}
				else if ( key == "srcRptDt" ) {
					row.find("." + key).text("일시 : " + data[key]);
				}
//				else if ( key == "rptPlace" ) {
//					row.find("." + key).text("장소 : " + data[key]);
//				}
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
function bindPlcySmnEvent() {
	var formObj = $("#smnForm");
	
	// 조회
	formObj.find("#btnSch").bind("click", function() {
		searchPlcySmnList(1);
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
			searchPlcySmnList(1);
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