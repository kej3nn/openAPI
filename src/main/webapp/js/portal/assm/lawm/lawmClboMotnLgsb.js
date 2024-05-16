/**
 * 국회의원 입법활동 메인탭 공동발의 스크립트 파일이다.
 * 
 * @author JHKIM
 * @version 1.0 2019/10/21
 */
////////////////////////////////////////////////////////////////////////////////
// GLOBAL VARIABLE
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// SCRIPT INIT
////////////////////////////////////////////////////////////////////////////////
$(function() {
	
	// 옵션정보를 로드한다.
	loadClboOptions();
	
	// 이벤트를 로드한다.
	bindClboEvent();
	
	// 데이터를 조회한다.
	searchAssmLawmClboMotnLgsbList(1);
});

/**
 * 옵션정보를 로드한다.
 */
function loadClboOptions() {
	var formObj = $("#clboForm");
	
	// 처리결과
	loadTabComboOptions(formObj, "procResult", "/portal/assm/lawm/searchAssmLawmCommCd.do", {gCmCd: "RESULT"}, "", true);
}

/**
 * 데이터를 조회한다.
 * @param page	페이지번호
 * @returns
 */
function searchAssmLawmClboMotnLgsbList(page) {
	page = page || 1;
	doSearch({
		url : "/portal/assm/lawm/searchLawmClboMotnLgsb.do",
		page : page,
		before : beforeClboMotnLgsbList,
		after : afterClboMotnLgsbList,
		pager : "clbo-pager-sect"
	});
}

/**
 * 목록 리스트 페이징 조회 전처리
 */
function beforeClboMotnLgsbList(options) {
	var form = $("#clboForm");
	
	parent.gfn_showLoading();
	GCP_ONLOAD.vote = true;
	
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
function afterClboMotnLgsbList(datas) {
	var row = null,
		data = null,
		list = $("#clbo-result-sect"),
		item = 
			"<tr>" +
			"	<td class=\"rownum\"></td>" +
			"	<td class=\"unitNm\"></td>" +
			"	<td class=\"billName left\"></td>" +
			"	<td class=\"proposer\"></td>" +
			"	<td class=\"committee\"></td>" +
			"	<td class=\"proposeDt\"></td>" +
			"	<td><span class=\"procResult\"></span></td>" +
			"</tr>";
	
	list.empty();
	
	if ( datas.length > 0 ) {
		for ( var i in datas ) {
			data = datas[i];
			
			row = $(item);
			
			row.find(".rownum").text(data.ROW_NUM);
			
			Object.keys(data).map(function(key, idx) {
				if ( key == "procResult" && !com.wise.util.isEmpty(data[key]) ) {
					if(data[key] == '수정가결' || data[key] == '원안가결'){
						row.find("." + key).text(data[key]).addClass("stat_pass");
					} else if(data[key] == '철회' || data[key] == '부결'){
						row.find("." + key).text(data[key]).addClass("stat_moor");
					} else if(data[key] == '폐기' || data[key] == '수정안반영폐기' || data[key] == '대안반영폐기' || data[key] == '임기만료폐기' ){
						row.find("." + key).text(data[key]).addClass("stat_disuse");
					}
				}
				else if ( key == "billName" ) {
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
		}
	}
	else {
		row = $(item);
		list.append("<tr><td colspan=\""+ (row.find("td").length) +"\">조회된 데이터가 없습니다.</td></tr>");
	}
	
	GCP_ONLOAD.clbo = true;
	lawmHideLoading();
}

/**
* TreeMap 데이터 조회
**/
function searchLawmClboMotnLgsbTreeMap(empNo) {
	doAjax({
		url: "/portal/assm/lawm/searchLawmClboMotnLgsbTreeMap.do",
		params: "empNo="+empNo,
		callback: function(res) {
			var data = res.data;
			var chartId = "chartClboTreeMapContainer";
			loadTreeMapChart(data, chartId);
		}
	});
}

/**
* Column 데이터 조회
**/
function searchLawmClboMotnLgsbColumn(empNo) {
	doAjax({
		url: "/portal/assm/lawm/searchLawmClboMotnLgsbColumn.do",
		params: "empNo="+empNo,
		callback: function(res) {
			var data = res.data;
			var chartId = "chartClboColumnContainer";
			loadColumnChart(data, chartId);
		}
	});
}


function bindClboEvent() {
	var formObj = $("#clboForm");
	
	// 조회
	formObj.find("#btnSch").bind("click", function() {
		searchAssmLawmClboMotnLgsbList(1);
		return false;
	}).bind("keydown", function(event) {
		if ( event.which == 13 ) {
			searchAssmLawmClboMotnLgsbList(1);
			return false;
		}
	});
	
	// 조회 엔터이벤트
	formObj.find("input[name=billName]").bind("keydown", function(event) {
		if ( event.which == 13 ) {
			searchAssmLawmClboMotnLgsbList(1);
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
	
	// 차트조회
	formObj.find("#btnChartsch").bind("click", function() {
		
		var empNo = $("input[name=empNo]", parent.document).val();
		
		var open = $(this).text() == "차트조회" ? true : false;
		$(this).text(open ? "차트닫기" : "차트조회");
		
		var ifmHeight = $("#ifm_tabLawm", window.parent.document).height();
		
		if(open){
			$("#chartClboArea").css("display", "block");
			//트리맵 차트 조회
			searchLawmClboMotnLgsbTreeMap(empNo);
			//컬럼차트 조회
			searchLawmClboMotnLgsbColumn(empNo);
			
			//차트 높이 만큼 아이프레임 높이 조정
			$("#ifm_tabLawm", window.parent.document).height(ifmHeight + 400);
		}else{
			$("#chartClboArea").css("display", "none");
			$("#ifm_tabLawm", window.parent.document).height(ifmHeight - 400);
		}
	});
}