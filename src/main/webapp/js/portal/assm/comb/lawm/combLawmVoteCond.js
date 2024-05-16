/**
 * 통합 - 의정활동 - 표결정보 스크립트 파일이다.
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
	
	// 옵션정보를 로드한다.
	loadVoteOptions();
	
	// 이벤트를 로드한다.
	bindVoteEvent();
	
	// 데이터 조회
	searchAssmLawmVoteCondList(1)
	var form = $("#voteForm");
	$(window).width() <= 980 ? form.find("#btnDownload").hide() : false
});

/**
 * 옵션정보를 로드한다.
 */
function loadVoteOptions() {
	var formObj = $("#voteForm");
	
	// 처리결과
	loadTabComboOptions(formObj, "procResult", "/portal/assm/lawm/searchAssmLawmCommCd.do", {gCmCd: "RESULT"}, "", true);
	
	// 표결정보
	loadTabComboOptions(formObj, "resultVoteCd", "/portal/assm/lawm/searchAssmLawmCommCd.do", {gCmCd: "VOTE"}, "", true);
	
	// 일자 캘린더
	gfn_portalCalendar(formObj.find("input[name=voteendDt]"));
}

/**
 * 데이터 조회
 */
function searchAssmLawmVoteCondList(page) {
	page = page || 1;
	doSearch({
		url : "/portal/assm/lawm/searchLawmVoteCond.do",
		page : page,
		before : beforeVoteCondList,
		after : afterVoteCondList,
		pager : "vote-pager-sect"
	});
}

/**
 * 목록 리스트 페이징 조회 전처리
 */
function beforeVoteCondList(options) {
	var form = $("#voteForm");
	
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
function afterVoteCondList(datas) {
	var cntObj = {},
		row = null,
		data = null,
		list = $("#vote-list-sect"),
		item = 
			"<tr>" +
			"	<td class=\"rownum\"></td>" +
			"	<td class=\"unitNm\"></td>" +
			"	<td class=\"voteendDt\"></td>" +
			"	<td class=\"billName left\"></td>" +
			"	<td class=\"currCommittee\"></td>" +
			"	<td><span class=\"resultVote\"></span></td>" +
			"	<td class=\"result\"></td>" +
			"</tr>";
	
	list.empty();
	
	if ( datas.length > 0 ) {
		
		// 탭 버튼 국회의원 대수 출력
		$("#tab-btn-vote").text(String(datas[0].age) + "대 표결현황");
		
		for ( var i in datas ) {
			data = datas[i];
			
			row = $(item);
			
			row.find(".rownum").text(data.ROW_NUM);
			
			Object.keys(data).map(function(key, idx) {
				if ( key == "resultVoteCd" ) {
					var classNm = "";
					if ( data[key] == "AG" ) {
						classNm = "stat_agree";			// 찬성
					}
					else if ( data[key] == "DA" ) {
						classNm = "stat_oppose";		// 반대
					}
					else if ( data[key] == "DR" ) {
						classNm = "stat_abstained";		// 기권
					}
					else if ( data[key] == "XX" ) {
						classNm = "stat_absence";		// 불참
					}
					
					row.find(".resultVote").addClass(classNm);
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
}

function bindVoteEvent() {
	var formObj = $("#voteForm");
	
	// 조회
	formObj.find("#btnSch").bind("click", function() {
		searchAssmLawmVoteCondList(1);
		return false;
	}).bind("keydown", function(event) {
		if ( event.which == 13 ) {
			searchAssmLawmVoteCondList(1);
			return false;
		}
	});
	
	// 조회 엔터이벤트
	formObj.find("input[name=billName]").bind("keydown", function(event) {
		if ( event.which == 13 ) {
			searchAssmLawmVoteCondList(1);
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