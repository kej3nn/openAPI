/**
 * 의정활동별 공개 - 날짜별 스크립트 파일이다.
 * 
 * @author JHKIM
 * @version 1.0 2019/11/05
 */
////////////////////////////////////////////////////////////////////////////////
// GLOBAL VARIABLE
////////////////////////////////////////////////////////////////////////////////
/* 현재날짜 */
//var CONST_TODAY = new Date();
////////////////////////////////////////////////////////////////////////////////
// SCRIPT INIT
////////////////////////////////////////////////////////////////////////////////
$(function() {
	//initEventCalendar();
	
	bindEvent();
	
	loadOptions();
	
	searchDate(1);
	var form = $("#dateForm")
	$(window).width() <= 980 ? form.find("#btnDownload").remove() : false; 
});

function loadOptions() {
	// 일자 캘린더
	gfn_portalCalendar($("input[name=frDt]"));
	gfn_portalCalendar($("input[name=toDt]"));
	
	$('input[name=frDt]').datepicker('option', 'onClose',  function( selectedDate ) {$("input[name=toDt]").datepicker( "option", "minDate", selectedDate );});
	$('input[name=toDt]').datepicker('option', 'onClose',  function( selectedDate ) {	$("input[name=frDt]").datepicker( "option", "maxDate", selectedDate );});	
	
	setDate();
}

function setDate(){
	var formObj = $("#dateForm")
	var now = new Date(Date.parse(new Date)-1*1000*60*60*24);
	var before = new Date(Date.parse(new Date)-1*1000*60*60*24);
	before.setMonth(before.getMonth()-1);
	var monTo = (now.getMonth()+1)>9?now.getMonth()+1:'0'+(now.getMonth()+1);
	var monFrom = (before.getMonth()+1)>9?before.getMonth()+1:'0'+(before.getMonth()+1);
	var day = (now.getDate())>9?(now.getDate()):'0'+(now.getDate());
	var dayFrom = (before.getDate())>9?(before.getDate()):'0'+(before.getDate());
	var dateTo=now.getFullYear()+'-'+monTo+'-'+day;
	var dateFrom=before.getFullYear()+'-'+monFrom+'-'+dayFrom;
	
	formObj.find("input[name=frDt]").val(dateFrom);
	formObj.find("input[name=toDt]").val(dateTo);

}

function bindEvent() {
	var formObj = $("#dateForm")
	
	// 조회
	$("#btnSch").bind("click", function() {
		searchDate(1);
		return false;
	}).bind("keydown", function(event) {
		if ( event.which == 13 ) {
			$(this).click();
			return false;
		}
	});
	
	// 조회 엔터이벤트
	$("input[name=billNm], input[name=stage], input[name=actStatus], input[name=committee]").bind("keydown", function(event) {
		if ( event.which == 13 ) {
			event.preventDefault();
			searchDate(1);
			return false;
		}
	});

		
	
	// 엑셀 다운로드
	formObj.find("#btnDownload").bind("click", function() {
		var data = formObj.serializeObject();
		var searchParamCnt = 0;
		if ( com.wise.util.isBlank(data.stage) )		searchParamCnt++;
		if ( com.wise.util.isBlank(data.actStatus) )	searchParamCnt++;
		if ( com.wise.util.isBlank(data.committee) )	searchParamCnt++;
		if ( com.wise.util.isBlank(data.frDt) )			searchParamCnt++;
		if ( com.wise.util.isBlank(data.toDt) )			searchParamCnt++;
		if ( com.wise.util.isBlank(data.billNm) )		searchParamCnt++;
		
		if ( searchParamCnt > 4 ) {
			alert("2가지 이상 조회조건을 입력하세요.");
			return false;
		}
		    gfn_fileDownload({
	    	url: "/portal/bpm/downExcel.do",
	    	params: formObj.serialize()
	    });
	});	
	
	
	// 캘린더 이전월
	/*
	$("#btnCalendarPrev").bind("click", function() {
		CONST_TODAY = new Date(CONST_TODAY.getFullYear(), CONST_TODAY.getMonth() - 1, CONST_TODAY.getDate());
		initEventCalendar();
		return false;
	}).bind("keydown", function(event) {
		if ( event.which == 13 ) {
			CONST_TODAY = new Date(CONST_TODAY.getFullYear(), CONST_TODAY.getMonth() - 1, CONST_TODAY.getDate());
			initEventCalendar();
			return false;
		}
	});
	
	// 캘린더 다음월
	$("#btnCalendarNext").bind("click", function() {
		CONST_TODAY = new Date(CONST_TODAY.getFullYear(), CONST_TODAY.getMonth() + 1, CONST_TODAY.getDate());
		initEventCalendar();
		return false;
	}).bind("keydown", function(event) {
		if ( event.which == 13 ) {
			CONST_TODAY = new Date(CONST_TODAY.getFullYear(), CONST_TODAY.getMonth() + 1, CONST_TODAY.getDate());
			initEventCalendar();
			return false;
		}
	});
	*/
}

/**
 * 목록 리스트 조회
 * @param page	페이지번호
 */
function searchDate(page) {
	
	if($('input[name=frDt]').val() == null || $('input[name=frDt]').val() == ""){
		alert("날짜별 의정활동 공개는 일자를 선택하시기 바랍니다.");
		return false;
	}
	
	if($('input[name=toDt]').val() == null || $('input[name=toDt]').val() == ""){
		alert("날짜별 의정활동 공개는 일자를 선택하시기 바랍니다.");
		return false;
	}
	
	var sDate = $('input[name=frDt]').val().split("-");
	var eDate = $('input[name=toDt]').val().split("-");
	
	if(sDate.length != 3 || eDate.length != 3){
		alert("일자가 잘못 입력되었습니다. 일자를 다시 선택하시기 바랍니다.");
		return false;
	}

	if(dateDiff() > 92){
		alert("날짜별 의정활동 공개는 일자를 3개월 이내로 선택하시기 바랍니다.");
		return false;
	}
	
	page = page || 1;
	doSearch({
		url : "/portal/bpm/date/searchDate.do",
		page : page,
		before : beforeSearchDate,
		after : afterSearchDate,
		pager : "date-pager-sect"
	});
}

/**
 * 날짜 차이 계산
 * @date	조회하려는 날짜
 */
function dateDiff() {
    var diffDate_1 = $('input[name=frDt]').val() instanceof Date ? $('input[name=frDt]').val() :new Date($('input[name=frDt]').val());
    var diffDate_2 = $('input[name=toDt]').val() instanceof Date ? $('input[name=toDt]').val() :new Date($('input[name=toDt]').val());
 
    diffDate_1 =new Date(diffDate_1.getFullYear(), diffDate_1.getMonth()+1, diffDate_1.getDate());
    diffDate_2 =new Date(diffDate_2.getFullYear(), diffDate_2.getMonth()+1, diffDate_2.getDate());
 
    var diff = Math.abs(diffDate_2.getTime() - diffDate_1.getTime());
    diff = Math.ceil(diff / (1000 * 3600 * 24));
 
    return diff;
}

//개월수 계산 함수
function timeSt(dt) {
	var d = new Date(dt);
	var yyyy = d.getFullYear();
	var MM = d.getMonth()+1;
	var dd = d.getDate()-1;
	return (yyyy + '년 ' + MM + '월 ' + dd + '일');
}

/**
 * 국회일정 리스트 조회
 * @date	조회하려는 날짜
 */
function selectDate(options) {
	/*
	// date 인자 없을경우 현재일자 세팅
	options.date = options.date || (function() {
		var date = new Date();
		return date.getFullYear() + "-" + (date.getMonth()+1) + "-" + (date.getDate() < 10 ? com.wise.util.lpad("0", 1)+date.getDate() : date.getDate());
	})();
	
	$("#dateForm input[name=meettingYmd]").val(options.date);
	
	doSearch({
        url:"/portal/bpm/date/searchDate.do",
        before: function() {
        	var form = $("#dateForm");
        	
        	if (com.wise.util.isEmpty(options.page)) {
        		form.find("[name=page]").val("1");
        	} 
        	else {
        		form.find("[name=page]").val(options.page);
        	}
        	return form.serializeObject();
        },
        after: afterSearchDate
    });*/
}

/**
 * 목록 리스트 페이징 조회 전처리
 */
function beforeSearchDate(options) {
	var form = $("#dateForm");
	
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
function afterSearchDate(datas) {
	var row = null,
		data = null,
		list = $("#date-result-sect"),
		item = 
			"<tr>" +
			"	<td class=\"ROW_NUM\"></td>" +
			"	<td class=\"dt\"></td>" +
			"	<td class=\"billKind\"></td>" +
			"	<td class=\"stage\"></td>" +
			"	<td class=\"dtlStage\"></td>" +
			"	<td class=\"billNm left\"></td>" +
			"	<td class=\"committee\"></td>" +
			"	<td class=\"actStatus\"></td>" +
			"</tr>";
	
	list.empty();
	
	if ( datas.length > 0 ) {
		
		_.forEach(datas, function(data, i) {
			row = $(item);
			
			Object.keys(data).map(function(key, idx) {
				if ( key == "billNm" ) {
					var linkA = $("<a title=\"새창열림_의안정보시스템\" href=\"javascript:;\">"+data[key]+"</a>");
					linkA.bind("click", {param: data}, function(event) {
						if ( !com.wise.util.isEmpty(event.data.param.linkUrl) ) {
							gfn_openPopup({url: event.data.param.linkUrl});
						}
					});
					
					row.find("." + key).append(linkA);
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
 *  캘린더를 초기화한다.
 */
function initEventCalendar() {
}

function selectCalendarDate() {
	/*
	// 캘린더 조회로직 필요(GROUP BY 날짜)
	var data = [
		{ meettingDate: "2019-11-02" },
		{ meettingDate: "2019-11-04" },
		{ meettingDate: "2019-11-05" },
		{ meettingDate: "2019-11-09" },
		{ meettingDate: "2019-11-12" },
		{ meettingDate: "2019-11-17" },
		{ meettingDate: "2019-11-20" },
		{ meettingDate: "2019-11-30" },
	];
	
	doSearch({
        url: "/portal/bpm/date/searchDateCalendar.do",
        before: function() {
        	return $("#dateForm").serializeObject();
        },
        after: function(data) {
        	if ( data.length > 0 )renderCalendarIcon(data);
        }
    });*/
}

/**
 * 캘린더 아이콘을 표시한다
 * @param data	조회된 데이터
 * @returns
 */
function renderCalendarIcon(data) {
	/*
	var calb = $("#calendar tbody");
	var day = null;
	
	_.each(data, function(value, idx) {

		day = calb.find("#cal_" + value.meettingDate);
	
		day.find("i").addClass("on");
	});
	
	bindCalendarEvent();*/
}

/**
 * 캘린터 일정 목록 조회 이벤트 바인딩
 */
function bindCalendarEvent() {
	/*
	$(".assembly_open_calendar td").each(function(idx) {
		
		if ( !com.wise.util.isEmpty($(this).attr("id")) ) {
			// 고유ID
			var id = $(this).attr("id").replace("cal_", "");

			// 행사가 있는경우
			if ( $(this).find("i").hasClass("on") ) {
				$(this).bind("click", {id: id}, function(event) {
					selectDate({date: event.data.id});
				}).bind("keydown", {id: id}, function(event) {
					if ( event.which == 13 ) {
						selectDate({date: event.data.id});
					}
				});
			}
			else {
				$(this).find("a").removeAttr("href");
			}
		}
	});*/
}