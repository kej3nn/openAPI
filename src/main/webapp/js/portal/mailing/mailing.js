/**
 * 메일링 화면 스크립트이다.
 *
 * @author SBCHOI
 * @version 1.0 2019/11/25
 */
////////////////////////////////////////////////////////////////////////////////
// 글로벌 변수
////////////////////////////////////////////////////////////////////////////////


////////////////////////////////////////////////////////////////////////////////
// 초기화 함수
////////////////////////////////////////////////////////////////////////////////
$(function() {
	
	// 이벤트 바인딩
	bindEvent();
	
	// 화면 초기화
	initComp();
	
	// 데이터 조회
	loadData();
	
});

function initComp() {
}

function loadData() {
	
	// 인기공개정보 조회
	selectPplrInfoRank();
	
	//initPplrWord();
	
	//국회 주간일정을 조회
	selectNaScheduleList();
}

/********************************************************************************
 * 인기공개정보 [BEGIN]
 ********************************************************************************/
 // 데이터 조회
function selectPplrInfoRank() {
	doSearch({
        url:"/portal/mailing/selectPplrInfoRank.do",
        before: function() {
        	return {};
        },
        after: afterselectPplrInfoRank
    });	
}
function afterselectPplrInfoRank(datas) {
	var sect = $("#ymail_info_list");
	var sect1 = $("#ymail_info_list1");
	
	var innerHtml = "";
	var innerHtml2 = "";
	var i = 1;
	_.each(datas, function(data, idx) {
		linkUrl = getLinkUrl(data) ;
		if(i < 6){
			innerHtml += "<li>";
			innerHtml += "<a href=\""+com.wise.help.url(linkUrl)+"\" target=\"_blank\">";
			innerHtml += "<span>"+Number(idx+1) +"위</span>";
			innerHtml += data.infaNm;
			innerHtml += "</a>";
			innerHtml += "</li>";
		}else{
			innerHtml2 += "<li>";
			innerHtml2 += "<a href=\""+com.wise.help.url(linkUrl)+"\" target=\"_blank\">";
			innerHtml2 += "<span>"+Number(idx+1) +"위</span>";
			innerHtml2 += data.infaNm;
			innerHtml2 += "</a>";
			innerHtml2 += "</li>";
		}
		i++;
	});
	sect.append(innerHtml);
	sect1.append(innerHtml2);
	
	sect.find("a:first").addClass("one");
	sect.find("a:eq(1)").addClass("two");
	sect.find("a:eq(2)").addClass("three");
}

//인기검색어 조회한다.
function initPplrWord() {
	var datas = null;
	
	// 통합검색 인기검색어 결과값
	doAjax({
		url: "/portal/search/getPopword.do",
		params: {
			range: "D",
			collection: "iopenpop",
			target: "popword"
		},
		callback: function(res) {
			if ( !com.wise.util.isEmpty(res) && !com.wise.util.isBlank(res) ) {
				var dataJson = JSON.parse(res);
				datas = dataJson.Data.Query;
			}
		}
	});
}

//국회 주간일정을 조회
function selectNaScheduleList() {

	doAjax({
		url: "/portal/mailing/selectNaScheduleList.do",
		params: {
			strDt: $("#strDt").val(),
			endDt: $("#endDt").val()
			
		},
		callback: function(res) {
			var data = res.data;
			afterSelectNaScheduleList(data);
		}
	});
}

function afterSelectNaScheduleList(data) {
	_.each(data, function(data, idx) {
		if(data.gubun == "ASSEM") $("#assem").text(data.cnt);
		if(data.gubun == "CMMTT") $("#cmmtt").text(data.cnt);
		if(data.gubun == "SEMNA") $("#semna").text(data.cnt);
	});
}

/* 인기공개정보 [END] *************************************************************/



////////////////////////////////////////////////////////////////////////////////
// 이벤트 함수
////////////////////////////////////////////////////////////////////////////////
function bindEvent() {
	
}



////////////////////////////////////////////////////////////////////////////////
//서비스 함수
////////////////////////////////////////////////////////////////////////////////
/**
 * 정보셋 구분 데이터 정보를 조회한다.
 */
function getLinkUrl(data) {
	var url = ""
	
	switch ( data.opentyTag ) {
	case "D":
		url = "/portal/doc/docInfPage.do/" + data.infaId;
		break;
	case "O":
		url = "/portal/data/service/selectServicePage.do?infId=" + data.infaId + "&infSeq=1";
		break;
	case "S":
		url = "/portal/stat/selectServicePage.do/" + data.infaId;
		break;
	}
	return url;
}
