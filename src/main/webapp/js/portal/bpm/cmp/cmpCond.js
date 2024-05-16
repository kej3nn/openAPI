/**
 * 의정활동별 공개 - 위원회 구성/계류법안 - 위원회 현황 스크립트 파일이다.
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
	loadCmpCondOptions();
	// 이벤트를 바인딩한다.
	bindCmpCondEvent();
	
	// 목록 리스트를 조회한다.
	searchCmpCond(1);
	
	var form = $("#condForm");
	
	$(window).width() <= 980 ? form.find("#btnDownload").remove() : false; 
});

function loadCmpCondOptions() {
	var formObj = $("#condForm");

	// 위원회 구분
	loadTabComboOptions(formObj, "cmtDivCd", "/portal/assm/lawm/searchAssmLawmCommCd.do", {gCmCd: "CMTDIV"}, "", true);

	// 위원회(수정필요)
	loadTabComboOptions(formObj, "committeeId", "/portal/assm/search/searchAssmMembCommCd.do", {listNo: 206}, "", true);
}

/**
 * 데이터를 조회한다.
 * @param page	페이지번호
 * @returns
 */
function searchCmpCond(page) {
	page = page || 1;
	doSearch({
		url : "/portal/bpm/cmp/searchCmpCond.do",
		page : page,
		before : beforeSearchCmpCond,
		after : afterSearchCmpCond,
		pager : "cond-pager-sect"
	});
}

/**
 * 목록 리스트 페이징 조회 전처리
 */
function beforeSearchCmpCond(options) {
	var form = $("#condForm");
	
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
function afterSearchCmpCond(datas) {
	var row = null,
		data = null,
		list = $("#cond-result-sect"),
		polyGroupCnt = $(".polyGroupNm").length || 0,		// 정당 갯수(교섭, 비교섭)
		polyGroupElement = function() {
			// 정당갯수만큼 컬럼 생성
			var str = "";
			for ( var i=1; i <= polyGroupCnt; i++ ) {
				if ( i != polyGroupCnt ) {
					str += "<td class=\"poly"+String(i)+"Cnt\"></td>";
				}
				else {
					str += "<td class=\"poly99Cnt\"></td>";
				}
			}
			return str;
		}();
	
	var	item = 
			"<tr>" +
			"	<td><span class=\"cmtDivNm\"></span></td>" +
			"	<td class=\"left\"><span class=\"committeeName\"></span></td>" +
			"	<td class=\"limitCnt\"></td>" +
			"	<td class=\"currCnt\"></td>" +
			polyGroupElement +
			"	<td class=\"hgNm\"></td>" +
			"	<td class=\"left hgNmList\"></td>" +
			"	<td class=\"assemList\"><a href=\"javascript:;\" class=\"assm_view\">조회</a></td>" +
			"	<td class=\"linkUrl\"></td>" +
			"</tr>";
	
	list.empty();
	
	if ( datas.length > 0 ) {
		
		_.forEach(datas, function(data, i) {
			row = $(item);
			
			Object.keys(data).map(function(key, idx) {
				if ( key == "linkUrl" ) {
					if ( !com.wise.util.isEmpty(data[key]) ) {
						row.find("." + key).append("<a href=\""+data[key]+"\" class=\"assm_view\" title=\""+data["committeeName"]+"_새창열림"+"\" target=\"_blank\">바로가기</a>");
//						row.find("." + key).find("a").attr("href", data[key]);
//						row.find("." + key).find("a").text("바로가기");
//						row.find("." + key).find("a").attr("title", data["committeeName"]+"_새창열림" );
					}
				}
				else if ( key == "committeeId" ) {
					row.find(".assemList").find("a").bind("click", function(event) {
						$("#tab-btn-sect a:eq(1)").click();
						$("#listForm select[name=deptCd]").val(data[key]);
						searchCmpList(1);
					});
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
function bindCmpCondEvent() {
	var formObj = $("#condForm");
	
	// 조회
	formObj.find("#btnSch").bind("click", function() {
		searchCmpCond(1);
		return false;
	}).bind("keydown", function(event) {
		if ( event.which == 13 ) {
			searchCmpCond(1);
			return false;
		}
	});
	
	// 조회 엔터이벤트
	formObj.find("input[name=title]").bind("keydown", function(event) {
		if ( event.which == 13 ) {
			searchCmpCond(1);
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