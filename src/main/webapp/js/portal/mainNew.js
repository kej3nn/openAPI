/**
 * 메인 화면 스크립트이다.(2차)
 *
 * @author 김정호
 * @version 1.0 2020/11/13
 */
////////////////////////////////////////////////////////////////////////////////
// 글로벌 변수
////////////////////////////////////////////////////////////////////////////////
/* 현재날짜 */
var CONST_TODAY = new Date();

/* 슬라이더 객체 */
var SLIDER = {
	assmNow: null,
	live: null,
	adzone: null
};

/* 국회일정 */
var SCHD_CONST = {
	bon: "ASSEM", wi: "CMMTT", ui: "SPEAK", se: "SEMNA", hang: "ARTCL"
};

/* 표결현황 */
var VOTE_RESULT_LIST = [];

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
	// 캘린더 초기화
	initEventCalendar();
	selectBultSchdCalendarList();
	
	// 슬라이더 초기화
	initSlider();
	
	// 국회TV 현재 시간 표시 및 FOCUS
	setFocusNATVProgram();
	
	// 상단 공지사항 여부에 따라 위치 조절
	topNoticeEvent();
}

function loadData() {
	// 의안처리현황 조회
	selectBillRecpFnshCnt();
	
	// 일정 조회
	selectBultSchdList();
	
	// 국회 생중계 조회
	selectAssmLiveStat();
	
	// 인기공개정보 조회
	selectPplrInfo("W");
	
	// 인기공개정보 wordcloud 조회
	//initPplrWordCloudChart("D");
	
	// 표결현황 첫번째 데이터 선택
	// 일시적으로숨김
	//selectVoteResult($(".main_status li:eq(0)").attr("id").replace("voteItem_", ""));
}

/********************************************************************************
 * 의안처리현황 조회 [BEGIN]
 ********************************************************************************/
function selectBillRecpFnshCnt() {
	doSearch({
        url:"/portal/main/selectBillRecpFnshCnt.do",
        before: function() {
        	return {};
        },
        after: afterSelectBillRecpFnshCnt
    });	
}
function afterSelectBillRecpFnshCnt(data) {
	var sect = $(".main_process_box");
	var strDate = (function() {
		var date = new Date();
		date.setDate(date.getDate()-1);		// 하루전
		var dt = date.getDate();
		var mt = date.getMonth() + 1;
		
		return date.getFullYear() + "." + (mt < 10 ? com.wise.util.lpad("0",1) + mt : mt) + "." + (dt < 10 ? com.wise.util.lpad("0", 1)+ dt : dt) + " 기준";
	})();
	$(".main_process_head em").text(strDate);
	
	sect.find("span").each(function(i, e) {
		var spanId = $(this).attr("id");
		if ( !gfn_isNull(data[spanId]) ) {
			$(e).text(com.wise.util.toCommaWon(data[spanId]) + "건");
		}
	});
}
/* 의안처리현황 [END] *************************************************************/

/********************************************************************************
 * 국회일정 [BEGIN]
 ********************************************************************************/
/**
 * 국회일정 리스트 조회
 * @date	조회하려는 날짜
 */
function selectBultSchdList(date) {
		
	// date 인자 없을경우 현재일자 세팅
	date = date || (function() {
		var date = new Date();
		var month = date.getMonth()+1;
		var dt =  date.getDate();
		return date.getFullYear() + "-" + (month < 10 ? com.wise.util.lpad("0", 1)+ month : month) + "-" + (dt < 10 ? com.wise.util.lpad("0", 1)+ dt : dt);
	})();
	
	$("#schdForm input[name=meettingYmd]").val(date);
	
	doSearch({
        url:"/portal/main/selectBultSchdList.do",
        before: function() {
        	return $("#schdForm").serializeObject() 
        },
        after: afterSelectBultSchdList
    });
}
function afterSelectBultSchdList(datas) {
	var meettingYmd = $("form[id=schdForm] input[name=meettingYmd]").val();
	var assmSect = {
		all: $("#assm-all-sect"),
		bon: $("#assm-bon-sect"),
		wi: $("#assm-wi-sect"),
		ui: $("#assm-ui-sect"),
		se: $("#assm-semina-sect"),
		hang: $("#assm-hangsa-sect"),
	}
	
	if ( datas.length > 0 ) {
		
		// 초기화
		_.mapKeys(assmSect, function(sect) {
			sect.empty();
		});
		
		_.forEach(datas, function(data, idx) {
			
			//if ( idx < 5 ) {
				assmSect.all.append(
					"<tr>" +
					"<td><span class='txt_overflow'>"+ data.gubunNm +"</span></td>" +
					"<td class='left'>"+(!com.wise.util.isEmpty(data.linkUrl) ?  "<a title=\"새창열림_대한민국 국회\" target=\"_blank\" href=\""+ data.linkUrl+"\" class='schedule_link' onclick=\"window.open(this.href, 'bultSchdPopup', 'width=1024,height=768, scrollbars=1').focus(); return false;\">"+ data.title +"</a>": data.title )+"</td>" +
					"<td>"+ (_.isEqual(SCHD_CONST.hang, data.gubun) ? (meettingYmd + " " + data.meettingTime) : data.meettingDateTime) +"</td>" +
					"<td>" + ( !com.wise.util.isEmpty(data.liveUrl) ? "<span class=\"icon_live\"><a href=\""+data.liveUrl+"\" target=\"_blank\">LIVE</a></span>" : "" ) + "</td>" +
					"</tr>"
				);
			//}
			
			if ( _.isEqual(SCHD_CONST.bon, data.gubun) ) {
				//if ( assmSect.bon.find("tr").length < 5 ) {
					assmSect.bon.append(
							"<tr>" +
							"<td><span class='txt_overflow'>"+ data.meetingsession +"</span></td>" +
							"<td><span class='txt_overflow'>"+ data.cha +"</span></td>" +
							"<td class='left'><a title=\"새창열림_대한민국 국회\" href=\""+ (!com.wise.util.isEmpty(data.linkUrl) ? data.linkUrl : "javascript:;") +"\" class='schedule_link' onclick=\"window.open(this.href, 'bultSchdPopup', 'width=1024,height=768, scrollbars=1').focus(); return false;\">"+ data.title +"</a></td>" +
							"<td>"+ data.meettingDateTime +"</td>" +
							"<td>" + ( !com.wise.util.isEmpty(data.liveUrl) ? "<span class=\"icon_live\"><a href=\""+data.liveUrl+"\" target=\"_blank\">LIVE</a></span>" : "" ) + "</td>" +
							"</tr>"
					);
				//}
			}
			else if ( _.isEqual(SCHD_CONST.wi, data.gubun) ) {
				//if ( assmSect.wi.find("tr").length < 5 ) {
					assmSect.wi.append(
							"<tr>" +
							"<td><span class='txt_overflow'>"+ data.committeeName +"</span></td>" +
							"<td><span class='txt_overflow'>"+ data.cha +"</span></td>" +
							"<td class='left'><a title=\"새창열림_대한민국 국회\" href=\""+ (!com.wise.util.isEmpty(data.linkUrl) ? data.linkUrl : "javascript:;") +"\" class='schedule_link' onclick=\"window.open(this.href, 'bultSchdPopup', 'width=1024,height=768, scrollbars=1').focus(); return false;\">"+ data.title +"</a></td>" +
							"<td>"+ data.meettingDateTime +"</td>" +
							"<td>" + ( !com.wise.util.isEmpty(data.liveUrl) ? "<span class=\"icon_live\"><a href=\""+data.liveUrl+"\" target=\"_blank\">LIVE</a></span>" : "" ) + "</td>" +
							"</tr>"
						);
				//}
			}
			else if ( _.isEqual(SCHD_CONST.ui, data.gubun) ) {
				//if ( assmSect.ui.find("tr").length < 5 ) {
					assmSect.ui.append(
							"<tr>" +
							"<td>"+ data.meetingsession +"</td>" +
							"<td class='left'><span class='txt_overflow'>"+ data.title +"</span></td>" +
							"<td>"+ data.meettingDateTime +"</td>" +
							"</tr>"
						);
				//}
			}
			else if ( _.isEqual(SCHD_CONST.se, data.gubun) ) {
				//if ( assmSect.se.find("tr").length < 5 ) {
					assmSect.se.append(
							"<tr>" +
							"<td class='left'><a title=\"새창열림_대한민국 국회\" href=\""+ (!com.wise.util.isEmpty(data.linkUrl) ? data.linkUrl : "javascript:;") +"\" class='schedule_link' onclick=\"window.open(this.href, 'bultSchdPopup', 'width=1024,height=768, scrollbars=1').focus(); return false;\">"+ data.title +"</a></td>" +
							"<td>"+ meettingYmd +"</td>" +
							"</tr>"
						);
				//}
			}
			else if ( _.isEqual(SCHD_CONST.hang, data.gubun) ) {
				//if ( assmSect.hang.find("tr").length < 5 ) {
					assmSect.hang.append(
							"<tr>" +
							"<td class='left'><a title=\"새창열림_대한민국 국회\" href=\""+ (!com.wise.util.isEmpty(data.linkUrl) ? data.linkUrl : "javascript:;") +"\" class='schedule_link' onclick=\"window.open(this.href, 'bultSchdPopup', 'width=1024,height=768, scrollbars=1').focus(); return false;\">"+ data.title +"</a></td>" +
							"<td>"+ (meettingYmd + " " + data.meettingTime) +"</td>" +
							"</tr>"
						);
				//}
			}
		});
		
		// 조회된 데이터 없는경우
		_.mapKeys(assmSect, function(sect) {
			if ( sect.find("tr").length == 0 ) {
				sect.append("<tr><td colspan=\""+ sect.prev().find("th").length +"\" class=\"no_schedule\"><span>금일 일정이 없습니다.</span></td></tr>");
			}
		});
	}
	else {
		// 조회된 데이터 없는경우
		_.mapKeys(assmSect, function(sect) {
			sect.empty();
			sect.append("<tr><td colspan=\""+ sect.prev().find("th").length +"\" class=\"no_schedule\"><span>금일 일정이 없습니다.</span></td></tr>");
		});
	}
}

// 국회일정 캘린더 조회
function selectBultSchdCalendarList() {
	doSearch({
        url:"/portal/main/selectBultSchdCalendarList.do",
        before: function() {
        	return $("#schdForm").serializeObject() 
        },
        after: function(data) {
        	if ( data.length > 0 )	renderCalendarIcon(data);
        }
    });
}

/**
 *  캘린더를 초기화한다.
 */
function initEventCalendar() {
	
	var template = {
		row: "<tr><td></td><td></td><td></td><td></td><td></td><td></td><td></td></tr>",
		day: "<a title='일정없음' role='cell' aria-selected='false'><em></em><ul></ul></a>"		// 2021.11.10 - 웹접근성 처리
	};
	
	var calYM = $("#calendarYM");				// 제목(년월)
	var cal = $("#calendar");
	var calb = cal.find("tbody");
	
	var year = CONST_TODAY.getFullYear();		// 현재년
	var month = CONST_TODAY.getMonth() + 1;		// 현재월
	var strMonth = month < 10 ? com.wise.util.lpad("0", 1)+month : month;
	
	var today = new Date();	// 현재 날짜(현재날짜 선택처리)
	
	// 현재 년월
	calYM.text(year + "년 " + month + "월");
	$("#schdForm input[name=meettingYM]").val(year + "-" + month);	// HIDDEN 값

	// 월
	var monthDate = new Date(year, CONST_TODAY.getMonth(), 1);
	
	// 마지막일자
	var lastDate = new Date(year, month, 0);
	
	calb.empty();
	
	var stDay = monthDate.getDay();		// 월 시작(일요일은 0)
	var lastDay = lastDate.getDate();	// 현재 년의 마지막일
	var weekCnt = Math.ceil((stDay + lastDay) / 7);	// 주 수
	
	var row = null, day = null, cnt = 0, id = "";
	var isDayStart = false;		// 1일로 시작할 위치 FLAG
	
	// Week Row FOR LOOP...
	_.each(_.range(0, weekCnt, 1), function(i) {
		
		row = $(template.row);
		
		// Day Col FOR LOOP...
		_.each(_.range(0, 7, 1), function(j) {
			
			if ( i == 0 && j == stDay ) {
				isDayStart = true;
			}
			
			day = $(template.day);
			
			// 토, 일요일 색상처리
			if ( j == 0 ) {
				day.find("em").css("color", "#c5280f");
			}
			else if ( j == 6) {
				day.find("em").css("color", "#3e79ae");
			}
			
			// 시작요일 확인하여 날짜 입력함.
			if ( isDayStart && cnt < lastDay ) {
				day.find("em").text(++cnt);
				id = "cal_" + year + "-" + strMonth + "-" + (cnt < 10 ? com.wise.util.lpad("0", 1)+cnt : cnt);
				row.find("td").eq(j).attr("id", id).append(day);

				// 현재날짜 선택처리
				if ( today.getFullYear() == year && (today.getMonth()+1) == month && today.getDate() == cnt ) {
					row.find("td").eq(j).addClass("today");
					row.find("td").eq(j).find("a").attr("title",row.find("td").eq(j).find("a").attr("title") + " 오늘");
					//2022.12.21 접근성 처리
				}
			}
			else {
				row.find("td").eq(j).append(day);
			}
		});
		
		calb.append(row);
	});
}

/**
 * 캘린더 아이콘을 표시한다
 * @param data	조회된 데이터
 * @returns
 */
function renderCalendarIcon(data) {
	var splitDate = null;

	_.each(data, function(value, idx) {
		// 데이터가 from-to로 들어있는경우 split으로 잘라서 처리
		if ( _.indexOf(value.meettingDate, ',') > -1 ) {
			splitDate = _.split(value.meettingDate, ',');

			_.each(splitDate, function(splitVal, idx) {
				renderAddIcon(value.gubun, splitVal);
			});
		}
		else {
			renderAddIcon(value.gubun, value.meettingDate);
		}
	});
	
	// 캘린더 선택 이벤트 바인딩
	bindCalendarEvent();
}
/**
 * 아이콘을 삽입한다.
 * @param gubun	구분
 * @param date	날짜
 * @returns
 */
function renderAddIcon(gubun, date) {
	var calb = $("#calendar tbody");
	var day = null, icon = null;
	var template = {
			bon: 	"<li><span class=\"icon_assembly_cal01\">본</span></li>",
			wi: 	"<li><span class=\"icon_assembly_cal02\">위</span></li>",
			ui: 	"<li><span class=\"icon_assembly_cal03\">의</span></li>",
			se: 	"<li><span class=\"icon_assembly_cal04\">세</span></li>",
			hang: 	"<li><span class=\"icon_assembly_cal05\">행</span></li>"
		}
	
	day = calb.find("#cal_" + date);

	if ( _.isEqual(SCHD_CONST.bon, gubun) ) {
		icon = template.bon;
	}
	else if ( _.isEqual(SCHD_CONST.wi, gubun) ) {
		icon = template.wi;
	}
	else if ( _.isEqual(SCHD_CONST.ui, gubun) ) {
		icon = template.ui;
	}
	else if ( _.isEqual(SCHD_CONST.se, gubun) ) {
		icon = template.se;
	}
	else if ( _.isEqual(SCHD_CONST.hang, gubun) ) {
		if ( day.find("ul .icon_assembly_cal05").length > 0 ) {
			icon = "";
		}
		else {
			icon = template.hang;
		}
	}
	else {
		icon = "";
	}

	if ( !com.wise.util.isBlank(icon) )	day.find("ul").append($(icon));
	if(!com.wise.util.isBlank(day.find("span").text())) {
		day.find("span")
			.closest("a")
			.attr({
				"href": "javascript:;",
				"title": day.find("span").closest("a").attr("title").replace("일정없음","")
			});
			// 2021.11.10 - 웹접근성 처리
	}
}

/**
 * 캘린터 일정 목록 조회 이벤트 바인딩
 * @returns
 */
function bindCalendarEvent() {
	$(".assembly_calendar td").each(function(idx) {
		
		if ( !com.wise.util.isEmpty($(this).attr("id")) ) {
			// 고유ID
			var id = $(this).attr("id").replace("cal_", "");
			$(this).find("a").attr("aria-label", id + " 일정");

			// 행사가 있는 경우
			if ( $(this).find("ul > li").length > 0 ) {
				$(this).bind("click", {id: id}, function(event) {
					$(".assembly_calendar td").removeClass("on");	// 선택일자 처리
					$(".assembly_calendar td").find("a").each(function(){
						$(this).attr("title",$(this).attr("title").replace(" 선택됨",""));
						//2022.12.21 접근성 처리
					});
					$(".assembly_calendar td a").attr("aria-selected", "false");
					$(this).addClass("on");
					$(this).find("a").attr("aria-selected", "true");
					$(this).find("a").attr("title",$(this).find("a").attr("title") + " 선택됨");
					//2022.12.21 접근성 처리
					selectBultSchdList(event.data.id);
					$("#schd-tab-btn a:eq(0)").click();		// 첫번째탭(전체)
				}).bind("keydown", {id: id}, function(event) {
					if ( event.which == 13 ) {
						$(this).click();
					}
				});
			}
			else {
				$(this).find("a").removeAttr("href");
			}
		}
	});
}
/* 국회일정 [END] *************************************************************/


/********************************************************************************
 * 국회생중계 [BEGIN]
 ********************************************************************************/
function selectAssmLiveStat() {
	doSearch({
        url:"/portal/main/selectAssmLiveStat.do",
        before: function() {
        	return {};
        },
        after: afterSelectAssmLiveStat
    });	
}
function afterSelectAssmLiveStat(datas) {
	
	var row = null,
		ul = $(".assembly_live_box_ul"),
		item = "<li><a href=\"http://assembly.webcast.go.kr/\"></a></li>",
		live = "<span class=\"icon_live\">LIVE</span>",
		today = new Date(),
		arrDayStr = ["일", "월", "화", "수", "목", "금", "토"];
	
	if ( datas.length > 0 ) {
		
		$(".assembly_live_date strong").text((today.getMonth()+1) + "월 " + (today.getDate()) + "일" + " (" + arrDayStr[today.getDay()] + ")");
		
		// 속개중인 데이터 하나 뽑음.
		var firData = _.filter(datas, { xStat : '1' })[0] || datas[0];
		// 제371회 국회(정기회) 제12차 예산결산특별위원회 (예산안) [10:00]
		
		var sptSubj = _.split(firData.xSubj, ') 제');
		var speakTime = sptSubj[1].substring(_.indexOf(sptSubj[1], '['), _.indexOf(sptSubj[1], ']')+1);
		var speakDesc = sptSubj[1].substr(0, _.lastIndexOf(sptSubj[1], '[')-1) + " " + firData.xDesc;
		
		$("#live_speak_desc").text(com.wise.util.ellipsis(speakTime + " " + speakDesc, 60));
		
		$("#live_confer_no").text(sptSubj[0]+")" || "");
		$("#live_confer_subj").text("제"+sptSubj[1]);
		$("#live_confer_time").text(_.replace(speakTime, /\[|\]/gi, ''));
	}
	else {
		// 숨기고 탭버튼위치 이동처리
		$(".mcom07").hide();
		setTimeout(function() {
			$(".main_common").children().each(function() {
				if ( $(this).attr("class") != "mcom01" && $(this).attr("class") != "mcom07" ) {
					if ( !com.wise.util.isNull($(this).find("h4 > a").css("left")) ) {
						$(this).find("h4 > a").css("left", (Number($(this).find("h4 > a").css("left").replace("px", "")) - 131) + "px");
					}
				}
			});
		}, 100);
	}
}

// 화면에서 위원회 클릭시 SUBJECT 데이터 파싱하여 화면에 표시
function fnLiveSubjChange(billId) {
	// 선택처리
	$(".assembly_live_box_ul li").removeClass("on");
	$(".assembly_live_box_ul #live_li_" + billId).addClass("on");
	
	var subjObj = $("#live_subj_" + billId);
	var sptSubj = _.split(subjObj.val() || "", ') 제');
	$("#live_confer_no").text(sptSubj[0]+")" || "");
	$("#live_confer_subj").text(com.wise.util.ellipsis("제"+(sptSubj[1]||"") || "", 23));
	
	var speakTime = sptSubj[1].substring(_.indexOf(sptSubj[1], '['), _.indexOf(sptSubj[1], ']')+1);
	$("#live_confer_time").text(_.replace(speakTime, /\[|\]/gi, ''));
}

/* 국회생중계 [END] *************************************************************/



/********************************************************************************
 * 표결현황 [BEGIN]
 ********************************************************************************/
// 의안결과에 따른 표결결과를 조회한다.
function selectVoteResult(billId) {
	
	var searchSuccess = function() {
		var deferred = $.Deferred();
		try {
			if ( com.wise.util.isEmpty(billId) ) {
				return false;
			}
			
			showVoteLoading();
			
			$("li[id^=voteItem_]").removeClass("on");
			var li = $("#voteItem_" + billId);
			li.addClass("on");
			$("#voteBillName").text(li.find("span").text());	// 의안제목
			var linkUrl = li.find("input").val(); //링크 URL
			$(".msal_more").attr("href", linkUrl);
			
			// 결과 수 조회(차트)
			doAjax({
				url: "/portal/main/selectBpmVoteResultCnt.do",
				params: "billId="+ billId,
				callback: function(data) {
					loadVoteResultChart(data.data)
				}
			});

			// 결과 목록 조회(찬성/반대 의원명단)
			doAjax({
				url: "/portal/main/selectBpmVoteResultList.do",
				params: "billId="+ billId,
				callback: afterVoteResultList
			});
			
			deferred.resolve(true);
		} catch (err) {
			console.error(err.message);
			hideVoteLoading();
			deferred.reject(false);
		}
		return deferred.promise();
	}
	
	searchSuccess().done(function(message) {
	}).always(function() {
		setTimeout(function() {
			hideVoteLoading();
		}, 100);
	});
	
}
/**
 * 의안결과 찬성/반대/기권 리스트 출력
 * @param datas
 * @returns
 */
function afterVoteResultList(datas) {
	$(".main_status_agree_list div[class*=_wrap] ul").removeClass("hmore");
	$(".msal01_box, .msal02_box, .msal03_box").removeClass("novote");
	$("#voteAssmMemberList ul").empty();
	
	VOTE_RESULT_LIST = datas.data;
	
	parseVoteResult(false);
	
	setTimeout(function() {
		$(".msal01").click();	// 찬성탭 default 선택
	}, 100);
}

/**
 * 표결현황 화면 렌더링
 * @param more	화면펼치기(더보기) 여부
 * @returns
 */
function parseVoteResult(more) {
	var showCnt = more ? 999 : 7,
		agreeSect = $("#voteAgreeList"),
		disSect = $("#voteDisAgreeList"),
		absSect = $("#voteAbsList");
		template = 
		"<li>" +
		"	<a href=\"javascript:;\" title=\"새창열림_국회의원 소개\">" +
		"		<div><img class=\"deptImgUrl\" src=\"\"></div>" +
		"		<p>" +
		"			<span class=\"polyNm\"></span>" +
		"			<strong class=\"reeleGbnNm\"></strong>" +
		"		</p>" +
		"	</a>" +
		"</li>";		
	
	if ( $(".main_status_agree_list div[class*=_wrap].on").find("ul").hasClass("hmore") ) {
		return false;
	}
	else {
		$("#voteAssmMemberList ul").empty();
	}
	
	for ( var i=0; i < VOTE_RESULT_LIST.length; i++ ) {
		var data = VOTE_RESULT_LIST[i];
		var item = $(template);
		
		// 펼치기 전에는 1줄만 표시
		if ( data.resultVoteCd === "AG" && agreeSect.find("li").length 	== showCnt ) {
			continue;
		}
		else if ( data.resultVoteCd === "DA" && disSect.find("li").length 	== showCnt ) {
			continue;
		}
		else if ( data.resultVoteCd === "DR" && absSect.find("li").length 	== showCnt ) {
			continue;
		}
		
		item.find("span").text(data.hgNm)
			.closest("a").bind("click", {monaCd: data.monaCd }, function(event) {
				gfn_openMembPopup(event.data.monaCd);
				return false;
			});

		item.find(".deptImgUrl").attr("src", data.deptImgUrl)
			.bind("click", {monaCd: data.monaCd }, function(event) {
					gfn_openMembPopup(event.data.monaCd);
					return false;
				});
		
		item.find(".deptImgUrl").closest("a").bind("keydown", {monaCd: data.monaCd}, function(event) {
			if (event.which == 13) {
				gfn_openMembPopup(event.data.monaCd);
				return false;
			}
		});
//		item.find(".polyNm").text(data.polyNm);
//		item.find("span").prepend("<i>"+data.polyNm+"</i>");
//		item.find(".reeleGbnNm").text(data.reeleGbnNm);
		item.find(".deptImgUrl").attr("alt", data.hgNm + " 국회의원 사진"); 
		
		switch ( data.resultVoteCd ) {
			case "AG":
				agreeSect.append(item);
				break;
			case "DA":
				disSect.append(item);
				break;
			case "DR":
				absSect.append(item);
				break;	
		}
	}
	
	if ( agreeSect.find("li").length == 0 ) $(".msal01_box").addClass("novote");
	if ( disSect.find("li").length == 0 ) 	$(".msal02_box").addClass("novote");
	if ( absSect.find("li").length == 0 ) 	$(".msal03_box").addClass("novote");	
}

/**
 * 표결현황 검색결과 차트
 * @param data	결과값(문자)
 * @returns
 */
function loadVoteResultChart(data) {
	
	var chart = Highcharts.chart('chartVoteResult', {
 		colors: ["#04B431", "#FF0000", "#FFFF00"],
 		credits: {
 			enabled: false
 		},
	    title: {
	    	text: '',
	    	style: {
		        fontSize: '30px',
		        fontWeight: 'bold',
		        fontColor: '#FFFFFF'
		    },
		    verticalAlign: 'middle'
	    },
	    subtitle: {
	    	align: 'left',
	    	text: '재석 : '+ (data.totalCnt || 0) +' <br>재적 : ' + (data.allCnt || 0),
	    	style: {
        		fontSize: '12px',
        		color: '#1C1C1C',
        		fontFamily: 'notoKrM',
        		textOutline: 0
        	}
	    },
	    chart: {
	        plotBackgroundColor: null,
	        plotBorderWidth: null,
	        plotShadow: false,
	        type: 'pie',
	        marginBottom: 100
	    },
	    legend: {
	    	enabled: true,
	    	labelFormatter: function() {
	    		return this.name + '(' + this.y + ')';
	    	}
	    },
	    plotOptions: {
	        pie: {
	        	showInLegend: true,
	        	allowPointSelect: true,
	        	size: 150,
	        	dataLabels: {
	            	enabled: true,
	            	distance: -30,
	            	formatter: function() {
	            		return this.y;
	            	},
	            	style: {
	            		fontSize: '12px',
	            		color: '#1C1C1C',
	            		fontFamily: 'notoKrM',
	            		textOutline: 0
	            	}
	            }
	        }
	    },
	    tooltip: {
	      enabled: true,
	      pointFormat: '<b>{point.y}</b>'
	    },
	    series: [{
	    	name: '표결현황',
		    data: [
	            { name: '찬성', y: data.agreeCnt || 0, },
	            { name: '반대', y: data.disCnt || 0, },
	            { name: '기권', y: data.absCnt|| 0 }
	        ]
	    }]
	    
	});
}
/* 표결현황 [END] *************************************************************/



/********************************************************************************
 * 인기공개정보 [BEGIN]
 ********************************************************************************/
 // 데이터 조회
function selectPplrInfo(range) {
	range = range || "W";
	
	doSearch({
        url:"/portal/main/selectPplrInfa.do",
        before: function() {
        	return {schRange : range};
        },
        after: afterSelectPplrInfo
    });	
}
function afterSelectPplrInfo(datas) {
	var sect = $("#pplr-result-sect"),
		sect1 = $("#pplr-result-sect1"),
		row = null,
		item = 
			"<li>" +
			"<div>" +
			"	<strong></strong>" +
			"	<a href=\"\" target=\"_blank\"><span></span></a>" +
			"</div>",
		star = "<img src=\"/images/icon_star.png\" alt=\"별점 1개\">",
		star2 = "<img src=\"/images/icon_star2.png\" alt=\"별점 2개(추천)\">",
		star3 = "<img src=\"/images/icon_star3.png\" alt=\"별점 3개(매우추천)\">",
		starTxt = "",
		linkUrl = null;
	
	sect.empty();
	
	_.each(datas, function(data, idx) {
		starTxt = "";
		row = $(item);
		row.find("strong").text(Number(idx+1) + "위");
		row.find("span").text(data.infaNm);
		
		if ( idx < 3 ) {
			row.addClass("ranking_number");
			/*for ( var i=3; i > idx; i-- ) {
				starTxt += star;
			}*/
			if(idx == 0){
				starTxt += star3;
			}else if(idx == 1){
				starTxt += star2;
			}else if(idx == 2){
				starTxt += star;
			}
		}
		row.find("div").append(starTxt);
		
		// 링크정보
		linkUrl = getLinkUrl(data) ;
		row.find("a").attr("href", com.wise.help.url(linkUrl));
		if(idx < 6 ) sect.append(row);
		else sect1.append(row);
	});
}

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

// 인기검색어 워드클라우드 차트를 초기화한다.
function initPplrWordCloudChart(range) {
	range = range || "W";
	var datas = gfn_getPropWord({range: range});	// 인기검색어 결과

	if ( !com.wise.util.isNull(datas) ) {
		// 검색어 결과에 따라 차트 표시
		Highcharts.chart('chartWordcloud', {
			credits: {
				enabled: false
			},
			series: [{
				type: 'wordcloud',
				data: datas,
				//spiral: 'archimedean',
				style: {"fontFamily": "notoKrM", "fontWeight": "500"},
				cursor: 'pointer',
				events: {
					click: function(event) {
						$("#sf1Form input[name=query]").val(event.point.name);
						$("#sf1Form").submit();
					}
				},
				//minFontSize: 30,
				//minFontSize: 10
				//name: 'Occurrences'
				colors: ['#F05C80', '#434348', '#8088E5', '#2F908F', '#7F9762', '#39A28B', '#C08221', '#E46D52', '#8B867E', '#298AD2']
			}],
			title: {
				text: ''
			},
			tooltip: {
				enabled: false
			}
		});
		
		// 검색어 상위 5개 보여준다.
		setPplrWordTop5(datas);
	}
}

// 인기검색어 5개 메인검색 TEXT 하위에 보여준다.
function setPplrWordTop5(datas) {
	if ( datas.length > 0 ) {
		
		var sect = $("#main_search_recent_list");
		var globalSect = $("#global-totalsch-recent-list");	// 레프트바 통합검색 인기검색어
		
		sect.empty();
		for ( var i=0; i < datas.length; i++ ) {
			if ( i == 5 )	break;
			sect.append("<li><a href=\"javascript:;\">"+datas[i].name+"</a></li>");
		}
		
		// 검색어 이벤트 바인딩
		$(".main_search_recent ul li a").bind("click", function(e) {
			$("#sf1Form input[name=query]").val($(this).text());
			$("#sf1Form").submit();
		});
	}
	else {
		$(".main_search_recent").hide();
	}
}
/* 인기공개정보 [END] *************************************************************/



////////////////////////////////////////////////////////////////////////////////
// 이벤트 함수
////////////////////////////////////////////////////////////////////////////////
function bindEvent() {
	
	// 통합검색 SUBMIT
	$("#btnSf1Search").bind("click", function(event) {
		event.preventDefault();
		if ( com.wise.util.isBlank($("#sf1Form input[name=query]").val()) ) {
			alert("검색어를 입력하세요.");
			return false;
		}
		$("#sf1Form").submit();
	});
	$("#sf1Form input[name=query]").bind("keydown", function(event) {
		if ( event.which == 13 ) {
			event.preventDefault();
			$("#btnSf1Search").click();
		}
	});
	
	// 메인 정보 탭
	$(".main_common  h4").each(function(idx) {
		$(this).bind("click", function() {
			$(".main_common h4").removeClass("on");
			$(".main_common h4 a").attr("aria-selected", "false");
			$(".main_common h4").next("div").hide();
			$(this).addClass("on");
			$(this).find("a").attr("aria-selected", "true");
			$(this).next("div").show();
		});
		
	});
	
	$(".mcom02 h4").bind("click", function() {
		reloadSlider();
	});
	// 캘린더 이전월
	$("#btnCalendarPrev").bind("click", function() {
		CONST_TODAY = new Date(CONST_TODAY.getFullYear(), CONST_TODAY.getMonth() - 1, CONST_TODAY.getDate());

		// 캘린더 초기화
		initEventCalendar();

		// 아이콘 렌더링
		setTimeout(function() {
			selectBultSchdCalendarList();
		}, 100);
		return false;
	}).bind("keydown", function(event) {
		if ( event.which == 13 ) {
			$(this).click();
			return false;
		}
	});
	
	// 캘린더 다음월
	$("#btnCalendarNext").bind("click", function() {
		CONST_TODAY = new Date(CONST_TODAY.getFullYear(), CONST_TODAY.getMonth() + 1, CONST_TODAY.getDate());
		
		// 캘린더 초기화
		initEventCalendar();

		// 아이콘 렌더링
		setTimeout(function() {
			selectBultSchdCalendarList();
		}, 100);
		return false;
	}).bind("keydown", function(event) {
		if ( event.which == 13 ) {
			$(this).click();
			return false;
		}
	});

	// 국회일정 상세 탭버튼
	$("#schd-tab-btn a").each(function(idx) {
		$(this).bind("click", function() {
			$(".mcom01 .m_inner .main_themeA").hide();
			$(".mcom01 .m_inner .main_themeA").eq(idx).show();
			$("#schd-tab-btn a").removeClass("on");
			$("#schd-tab-btn a").attr("aria-selected", "false" );
			$(this).addClass("on");
			
			//웹접근성 조치 20.11.09
			$(".mcom01 .m_inner .main_themeA").parent().find("h5").remove();
			$(".mcom01 .m_inner .main_themeA").eq(idx).parent().prepend("<h5 class=\"hide\">"+$(this).text()+"</h5>");
			$("#schd-tab-btn a").removeAttr("title");
			$(this).attr("title", "선택됨" );
			$(this).attr("aria-selected", "true" );
		});
	});
	// 국회일정 모바일 변경 이벤트
	$("#mb-schd-select").bind("change", function(event) {
		var idx = this.selectedIndex;  	// 선택한 콤보박스 순서
		$("#schd-tab-btn a").eq(idx).click();
	});
	
	// 표결현황 찬성/반대/기권 목록 탭
	$(".main_status_agree_list h5").each(function(idx) {
		$(this).bind("click", function() {
			var classNm = $(this).attr("class");
			$(".main_status_agree_list").find("div[class*=_wrap]").removeClass("on");
			$(".main_status_agree_list").find("div[class*=_box]").hide();
			$(this).parent().addClass("on").show();
			
			var divBox = $("." + classNm + "_box");
			divBox.show();
			divBox.find("li").length == 0 ? $(".btn_msal_more").hide() : $(".btn_msal_more").show();
			
			// 펼치기 버튼 원래대로 변경
			if ( divBox.find("ul").hasClass("hmore") ) {
				$(".btn_msal_more").addClass("on");
				$(".btn_msal_more a").text("접기");
			}
			else {
				$(".btn_msal_more").removeClass("on");
				$(".btn_msal_more a").text("펼치기");
			}
		});
	});
	// 표결현황 찬성/반대/기권 목록 더보기
	$(".btn_msal_more a").bind("click", function() {
		parseVoteResult(true);
		$(".btn_msal_more").toggleClass("on");
		$(this).text($(this).text() == "펼치기" ? "접기" : "펼치기");
		$(".main_status_agree_list div[class*=_wrap].on").find("ul").toggleClass("hmore");
		if ( !$(".main_status_agree_list div[class*=_wrap].on").find("ul").hasClass("hmore") ) {
			$("html").scrollTop(0);
		}
		return false;
	}).bind("keydown", function(event) {
		if ( event.which == 13 ) {
			parseVoteResult(true);
			$(".btn_msal_more").toggleClass("on");
			$(this).text($(this).text() == "펼치기" ? "접기" : "펼치기");
			$(".main_status_agree_list div[class*=_wrap].on").find("ul").toggleClass("hmore");
			if ( !$(".main_status_agree_list div[class*=_wrap].on").find("ul").hasClass("hmore") ) {
				$("html").scrollTop(0);
			}
			return false;
		}
	});

	// 인기공개정보 주간, 월간 선택
	$(".popular_btn ul li").each(function(i, j) {
		$(this).bind("click", function() {
			$(".popular_btn ul li").removeClass("on");
			$(this).addClass("on");
			
			// 인기공개정보 조회
			selectPplrInfo(i == 0 ? "W" : "M");
			
			// 인기공개정보 wordcloud 조회
			//initPplrWordCloudChart(i == 0 ? "W" : "M");
		});
	});
	
}



////////////////////////////////////////////////////////////////////////////////
//서비스 함수
////////////////////////////////////////////////////////////////////////////////
/**
 * 슬라이더를 초기화한다.
 */
function initSlider() {
	var retryNowCnt = 0, retryLiveCnt = 0;
	
	if($("#topinfo-sect").find("li").length > 1) {	 //상단 공지 한개일 경우 슬라이드 안함
		// 화면 상단 안내
		SLIDER.topinfo = $("#topinfo-sect").bxSlider({
			speed : 1000,
			pager : false,
			moveSlider : 0,
			autoHover : true,
			controls : false,
			slideMargin : 20,
			auto: true,
			mode : "vertical",
			// 웹 접근성 관련 수정
			onSliderLoad: function(currentIndex){
				$("#topinfo-sect").find('a').attr('tabindex', -1);
				$("#topinfo-sect").find('li').not('.bx-clone').eq( currentIndex ).find('a').attr('tabindex', 0); 
			},
			onSlideBefore: function($slideElement, oldIndex, newIndex){
				$("#topinfo-sect").find('a').attr('tabindex', -1);
				$("#topinfo-sect").find('li').not('.bx-clone').eq( newIndex ).find('a').attr('tabindex', 0);
			}
		});
	}
	
	//$(".bx-viewport").css("height", "59px");
	
	// 웹 접근성
	$('#topinfo-sect a').focusin(function () {
		//SLIDER.topinfo.stopAuto();
	});
	
	// 소식지
	SLIDER.adzone = $("#adzone-sect").bxSlider({
		speed : 500,
		pager : false,
		moveSlider : 1,
		autoHover : true,
		controls : false,
		slideMargin : 0,
		startSlide : 0,
		auto: true,
		//ariaHidden: true,
		// 웹 접근성 관련 수정
		onSliderLoad: function(currentIndex){
			$("#adzone-sect").find('a').attr('tabindex', -1);
			$("#adzone-sect").find('li').not('.bx-clone').eq( currentIndex ).find('a').attr('tabindex', 0); 
		},
		onSlideBefore: function($slideElement, oldIndex, newIndex){
			$("#adzone-sect").find('a').attr('tabindex', -1);
			$("#adzone-sect").find('li').not('.bx-clone').eq( newIndex ).find('a').attr('tabindex', 0);
		}
	});
	
	/*$('#adzone-sect a').focusin(function () {
		SLIDER.adzone.stopAuto();
	});*/
	// 국회는지금 슬라이더
	$(".mcom02 h4").next().show();	  
	SLIDER.assmNow = $("#assmNow-div-sect").bxSlider({
		speed : 500,
		pager : false,
		moveSlider : 1,
		autoHover : true,
		controls : false,
		slideMargin : 0,
		startSlide : 0,
		ariaHidden: false,
		onSliderLoad: function() {
			// 최초에 국회는지금 DIV가 숨겨있어서 slider가 height를 잡지 못함. DIV 먼저 보여주고 슬라이더 로드 후 숨김
			$(".mcom02 h4").next().hide();
			$(".mcom01 h4").click();
			$(".bx-clone").find("a").prop("tabIndex","-1");
		},
		onSlideAfter: function(){
			$("#assmNow-div-sect").children("li").each(function(){
				if($(this).attr("aria-hidden") == "false"){
					$(this).find("a").attr("tabIndex","0");
				}else{
					$(this).find("a").attr("tabIndex","-1");
				}
			});
		}
	});
		
	// 국회생중계 슬라이더
	$(".mcom07 h4").next().show();
	SLIDER.live = $(".assembly_live_box_ul").bxSlider({
		speed : 500,
		maxSlides: 3,
		infiniteLoop: false,
		moveSlider : 1,
		pager : false,
		autoHover : true,
		controls : false,
		slideWidth: 126,
		slideMargin : 0,
		startSlide : 0,
		onSliderLoad: function() {
			$(".mcom07 h4").next().hide();	 
			$(".mcom01 h4").click();
			$(".bx-clone").find("a").prop("tabIndex","-1");
		},
		onSlideAfter: function(){
			$(".assembly_live_box_ul").children("li").each(function(){
				if($(this).attr("aria-hidden") == "false"){
					$(this).find("a").attr("tabIndex","0");
				}else{
					$(this).find("a").attr("tabIndex","-1");
				}
			});
		}
	});
	
	// 슬라이더 이벤트 적용
	initSliderEvent();
}

/**
 * 슬라이더 이벤트를 적용한다.
 */
function initSliderEvent() {

	// 화면 상단 안내 이전
	$("#ti_prev").bind("click", function() {
		SLIDER.topinfo.goToPrevSlide();
		return false;
	}).bind("keydown", function(event) {
		if ( event.which == 13 ) {
			SLIDER.topinfo.goToPrevSlide();
			return false;
		}
	});
	// 화면 상단 안내 다음
	$("#ti_next").bind("click", function() {
		SLIDER.topinfo.goToNextSlide();
		return false;
	}).bind("keydown", function(event) {
		if ( event.which == 13 ) {
			SLIDER.topinfo.goToNextSlide();
			return false;
		}
	});
	
	// 소식지 이전
	$(".nn_prev").bind("click", function() {
		SLIDER.adzone.goToPrevSlide();
		return false;
	}).bind("keydown", function(event) {
		if ( event.which == 13 ) {
			SLIDER.adzone.goToPrevSlide();
			return false;
		}
	});
	// 소식지 다음
	$(".nn_next").bind("click", function() {
		SLIDER.adzone.goToNextSlide();
		return false;
	}).bind("keydown", function(event) {
		if ( event.which == 13 ) {
			SLIDER.adzone.goToNextSlide();
			return false;
		}
	});
	// 소식지 정지
	$(".nn_stop").bind("click", function() {
		SLIDER.adzone.stopAuto();
		return false;
	}).bind("keydown", function(event) {
		if ( event.which == 13 ) {
			SLIDER.adzone.stopAuto();
			return false;
		}
	});
	// 소식지 재생
	$(".nn_play").bind("click", function() {
		SLIDER.adzone.startAuto();
		return false;
	}).bind("keydown", function(event) {
		if ( event.which == 13 ) {
			SLIDER.adzone.startAuto();
			return false;
		}
	});
	
	// 국회는 지금 이전
	$(".btn_now_left").bind("click", function() {
		SLIDER.assmNow.goToPrevSlide();
		return false;
	}).bind("keydown", function(event) {
		if ( event.which == 13 ) {
			SLIDER.assmNow.goToPrevSlide();
			return false;
		}
	});
	// 국회는 지금 다음
	$(".btn_now_right").bind("click", function() {
		SLIDER.assmNow.goToNextSlide();
		return false;
	}).bind("keydown", function(event) {
		if ( event.which == 13 ) {
			SLIDER.assmNow.goToNextSlide();
			return false;
		}
	});
	
	// 국회생중계 이전
	$("#btnLivePrev").bind("click", function() {
		SLIDER.live.goToPrevSlide();
		return false;
	}).bind("keydown", function(event) {
		if ( event.which == 13 ) {
			$(this).click();
			return false;
		}
	});
	// 국회생중계 다음
	$("#btnLiveNext").bind("click", function() {
		SLIDER.live.goToNextSlide();
		return false;
	}).bind("keydown", function(event) {
		if ( event.which == 13 ) {
			$(this).click();
			return false;
		}
	});
}

//국회는 지금 슬라이더 height를 잡지 못함. 임시로.. 수정 필요 
function reloadSlider () {
	SLIDER.assmNow.reloadSlider();
	$(".mcom01 > div").hide();
	$(".mcom01 h4").removeClass("on");
	$(".mcom02 h4").addClass("on");
	$(".mcom02 > div").show();
}
/**
* 표결현황 목록(사진) 로딩중.. 화면 표시 및 닫기
*/
function showVoteLoading() {
	$("#voteAssmMemberList .loading").show();
}
function hideVoteLoading() {
	$("#voteAssmMemberList .loading").hide();
}

/**
 * 국회TV 현재 시간 표시 및 FOCUS
 */
function setFocusNATVProgram() {
	// PC일경우만 동작한다.
	if ( !GC_ISMOBILE ) {
		var today = new Date(),
		todayTime = today.getTime(),
		todayIdx = 0,
		arrTvTime = [];
		
		$(".assembly_tv_list_body .atv01").each(function(i, a) {
			arrTvTime.push($(a).text());
		});
		
		_.forEach(arrTvTime, function(time, idx) {
			var _time = new Date(today.getFullYear(), today.getMonth(), today.getDate(), Number(time.substr(0, 2)), Number(time.substr(3, 2))).getTime();
			
			if ( todayTime < _time ) {
				todayIdx = idx;
				return false;
			}
		});
		
		$(".assembly_tv_list_body a").eq(todayIdx-1).focus().addClass("on");

		//2022.12.21 접근성 처리
		$(".assembly_tv_list_body a").eq(todayIdx-1).attr("title",$(".assembly_tv_list_body a").eq(todayIdx-1).attr("title") + " 선택됨");
	}
}

/**
 *상단 공지사항 여부에 따라 위치 조절
 */
function topNoticeEvent(){
	if($(".top_notice").length > 0){
		$(".allmenu").css("top", "231px");
		$(".moremenu").css("top", "231px");
		$(".mobile-header-btn").css("top", "87px");
		
		// 상단 공지사항 쿠키확인
		getCookieTopNotice();
	}else{
		$(".allmenu").css("top", "153px");
		$(".moremenu").css("top", "153px");
		$(".mobile-header-btn").css("top", "0px");
	}
	
	$(".btn_top_x").click(function(){
		// 오늘은 다시 보지 않음 체크여부 확인
		if($("input:checkbox[name=topNotice]").is(":checked") == true) {
		    var todayDate = new Date();
		    todayDate.setDate( todayDate.getDate() + 1 );
		    document.cookie = "topNoticeCookie=" + escape( "done" ) + "; path=/; expires=" + todayDate.toGMTString() + ";"
	    }
		$(".top_notice").slideUp();
		$(".allmenu").css("top", "153px");
		$(".moremenu").css("top", "153px");
		$(".mobile-header-btn").css("top", "0px");
	});
}

/**
 *상단 공지사항 쿠키확인 열기
 */
function getCookieTopNotice(){
    var cookiedata = document.cookie;
    if ( cookiedata.indexOf("topNoticeCookie=done") < 0 ){
         $(".top_notice").show();
 		$(".allmenu").css("top", "231px");
		$(".moremenu").css("top", "231px");
		$(".mobile-header-btn").css("top", "87px");
    }
    else {
        $(".top_notice").hide();
		$(".allmenu").css("top", "153px");
		$(".moremenu").css("top", "153px");
		$(".mobile-header-btn").css("top", "0px");
    }
    $(".top_notice_text > ul").css("width", "750px");
}
