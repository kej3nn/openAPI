/**
 * 국회의원 입법활동 메인탭 표결현황 스크립트 파일이다.
 * 
 * @author JHKIM
 * @version 1.0 2019/10/21
 */
////////////////////////////////////////////////////////////////////////////////
// GLOBAL VARIABLE
////////////////////////////////////////////////////////////////////////////////
var chartVoteData = "";
////////////////////////////////////////////////////////////////////////////////
// SCRIPT INIT
////////////////////////////////////////////////////////////////////////////////
$(function() {
	
	// 옵션정보를 로드한다.
	loadVoteOptions();
	
	// 이벤트를 로드한다.
	bindVoteEvent();
	
	// 표결정보 카운트를 조회
	selectLawmVoteCondResultCnt();
	
	// 데이터 조회
	searchAssmLawmVoteCondList(1);
});

/**
 * 옵션정보를 로드한다.
 */
function loadVoteOptions() {
	var formObj = $("#voteForm");
	
	// 소관위원회
	loadTabComboOptions(formObj, "committeeId", "/portal/assm/lawm/searchAssmLawmCommCd.do", {gCmCd: "COMMITTEE"}, "", true);
	
	// 의안종류
	loadTabComboOptions(formObj, "billKindCd", "/portal/assm/lawm/searchAssmLawmCommCd.do", {gCmCd: "BILL"}, "", true);
	
	// 처리결과
	loadTabComboOptions(formObj, "procResult", "/portal/assm/lawm/searchAssmLawmCommCd.do", {gCmCd: "RESULT"}, "", true);
	
	// 표결정보
	loadTabComboOptions(formObj, "resultVoteCd", "/portal/assm/lawm/searchAssmLawmCommCd.do", {gCmCd: "VOTE"}, "", true);
	
	// 일자 캘린더
	gfn_portalCalendar(formObj.find("input[name=voteendDt]"));
}

/**
 * 표결정보 카운트를 조회
 */
function selectLawmVoteCondResultCnt() {
	var params = $("#voteForm").serializeObject();
	params["empNo"] = $("input[name=empNo]", parent.document).val();
//	params["unitCd"] = $("input[name=unitCd]", parent.document).val();
	
	doAjax({
		url: "/portal/assm/lawm/selectLawmVoteCondResultCnt.do",
		params: params,
		callback: afterLawmVoteCondResultCnt
	});
}

/**
 * 표결정보 카운트 조회 후처리
 */
function afterLawmVoteCondResultCnt(res) {
	$("#voteTotalCnt").text(res.data.totalCnt + "건");
	$("#voteAgrCnt").text(res.data.agreeCnt || "0");
	$("#voteDisCnt").text(res.data.disCnt || "0");
	$("#voteAbsCnt").text(res.data.absCnt || "0");
	//$("#voteNonAtanCnt").text(res.data.nonAtanCnt || "0");
	loadPieChart(res);
//	chartVoteData = res;
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
			"	<td class=\"billName left\"><a title=\"새창열림_의안정보시스템\" href=\"javascript:;\"></a></td>" +
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
				/*	else if ( data[key] == "XX" ) {
						classNm = "stat_absence";		// 불참
					}
					*/
					row.find(".resultVote").addClass(classNm);
				}
				else if ( key == "billName" ) {
					row.find("." + key).find("a").text(data[key])
						.bind("click", {param: data}, function(event) {
							if ( !com.wise.util.isEmpty(event.data.param.linkUrl) ) {
								gfn_openPopup({url: event.data.param.linkUrl});
							}
						})
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
	
	GCP_ONLOAD.vote = true;
	lawmHideLoading();
}
/**
 * 파이 차트 로드
 * @param data	
 * @returns
 */
function loadPieChart(res) {
	var data = res.data;
//	var data = chartVoteData.data;
	
	if ( data.totalCnt > 0 ) {
		var chart = Highcharts.chart('chartPieContainer', {
			chart: {
		        plotBackgroundColor: null,
		        plotBorderWidth: null,
		        plotShadow: false,
		        type: 'pie'
		    },
		    colors: ["#04a021", "#ff1a1a", "#efa900"],
		    title: {
		        text: ''
		    },
		    tooltip: {
		        pointFormat: '{series.name}: <b>{point.y}({point.percentage:.1f}%)</b>'
		    },
		    plotOptions: {
		        pie: {
		            allowPointSelect: true,
		            cursor: 'pointer',
		            dataLabels: {
		                enabled: true,
		                format: '<span style="color:{point.color}">● </span><span>{point.name}</span>: <b>{point.y}({point.percentage:.1f}%)</b><br>'
		            },
		            showInLegend: true
		        }
		    },
		    series: [{
		        name: '인원',
		        colorByPoint: true,
		        data: [{name:'찬성', y:data.agreeCnt || "0"},{name:'반대', y:data.disCnt || "0"},{name:'기권', y:data.absCnt || "0"}]
		    }],
		    credits: {enabled: false},
		    exporting: {enabled: false}
		});
	}
	else {
		var chart = $("#chartPieContainer").highcharts();
		
		if ( chart != null ) {
			while( chart.series.length > 0 ) {
				chart.series[0].remove(false);
			}
			
			chart.redraw();
		}
	}
}

// chart show hide toggle
function toggleShowHideChart(isShow) {
	var ifmHeight = $("#ifm_tabLawm", window.parent.document).height();
	if( isShow ){
		$("#chartPieArea").css("display", "block");
		//차트 높이 만큼 아이프레임 높이 조정
		$("#ifm_tabLawm", window.parent.document).height(ifmHeight + 400);
		$("#voteForm").find("#btnChartsch").text("차트닫기");
	}else{
		$("#chartPieArea").css("display", "none");
		$("#ifm_tabLawm", window.parent.document).height(ifmHeight - 400);
		$("#voteForm").find("#btnChartsch").text("차트조회");
	}
}

function bindVoteEvent() {
	var formObj = $("#voteForm");
	
	// 조회
	formObj.find("#btnSch").bind("click", function() {
		searchAssmLawmVoteCondList(1);
		selectLawmVoteCondResultCnt();
		return false;
	}).bind("keydown", function(event) {
		if ( event.which == 13 ) {
			searchAssmLawmVoteCondList(1);
			selectLawmVoteCondResultCnt();
			return false;
		}
	});
	
	// 조회 엔터이벤트
	formObj.find("input[name=billName]").bind("keydown", function(event) {
		if ( event.which == 13 ) {
			searchAssmLawmVoteCondList(1);
			selectLawmVoteCondResultCnt();
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
	
	formObj.find("#btnChartsch").bind("click", function() {
//		var open = $(this).text() == "차트조회" ? true : false;
//		$(this).text(open ? "차트닫기" : "차트조회");
//		var ifmHeight = $("#ifm_tabLawm", window.parent.document).height();
//		if(open){
//			loadPieChart();
//			$("#chartPieArea").css("display", "block");
//			//차트 높이 만큼 아이프레임 높이 조정
//			$("#ifm_tabLawm", window.parent.document).height(ifmHeight + 400)
//		}else{
//			$("#chartPieArea").css("display", "none");
//			$("#ifm_tabLawm", window.parent.document).height(ifmHeight - 400);
//		}
		toggleShowHideChart($("#chartPieArea").is(":hidden"));
	});
	
}