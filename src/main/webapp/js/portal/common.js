/**
 * 포털 공통 스크립트
 *
 * @author JHKIM
 * @version 1.0 2019/10/31
 */

/* 이벤트 //////////////////////////////////////////////////////////////////////*/

// 퀵메뉴 스크롤
$( window ).scroll( function() {
	$(".quick_menu").stop().animate({
		"top" : ($(this).scrollTop() > 210 ? "20px" : "210px")
	}, 500);
});

$(function() {
	// 공통 통합검색 SUBMIT
	$("#global-totalsch-btn").bind("click", function(event) {
		event.preventDefault();
		if ( com.wise.util.isBlank($("#global-sf1Form input[name=query]").val()) ) {
			alert("검색어를 입력하세요.");
			return false;
		}
		$("#global-sf1Form").submit();
	});
	$("#global-sf1Form input[name=query]").bind("keydown", function(event) {
		if ( event.which == 13 ) {
			event.preventDefault();
			$("#global-totalsch-btn").click();
		}
	});
	
	// 모바일 TOP BUTTON
	$('.btn-top-go').click( function() {
		$( 'html, body' ).animate( { scrollTop : 0 }, 400 );
		return false;
	});

});
/////////////////////////////////////////////////////////////////////////////////

/**
 * 통합검색 레이어 열기
 */
function gfn_showTotalsch(value) {
	$(".menu_more_btn").removeClass("on");
	$("#global-totalsch-sect").show();
	$("#global-totalsch-val").val("");
	$("input[name=showTotalSch]").val(value);
	setTimeout(function() {
		$("#global-totalsch-val").focus();
	}, 100);
	// 통합검색 인기검색어 표시
//	var datas = gfn_getPropWord({range: "M"});
//	var globalSect = $("#global-totalSch-recent-list");
//	if ( globalSect.find("li").length == 0 ) {
//		 for ( var i=0; i < datas.length; i++ ) {
//			 if ( i == 5 )	break;
//			 globalSect.append("<li><a href=\"javascript:;\">"+datas[i].name+"</a></li>");
//		 }
//		 
//		 // 검색어 이벤트 바인딩
//		 $("#global-totalSch-recent ul li a").bind("click", function(e) {
//			 $("#global-sf1Form input[name=query]").val($(this).text());
//			 $("#global-sf1Form").submit();
//		 });
//	 }
}

/**
 * 통합검색 레이어 닫기
 * @returns
 */
function gfn_hideTotalsch() {
	$("#global-totalsch-sect").hide();
	//웹접근성 조치
	var schId = $("input[name=showTotalSch]").val();
	
	if( schId == "trdTotalSch" ) {
		$(".menu_more_btn").removeClass("off").addClass("on");
		$(".menulayer01").removeClass("on").addClass("off");
		$(".menulayer02").removeClass("off").addClass("on");
		$(".moremenu").show();
		$(".allmenu").hide();
		$("#trdTotalSch").focus();
	}else{
		$("#"+schId).focus();
	}
}	

/**
 * 마인드맵 레이어 열기
 */
function gfn_showMindmap(value) {
	$("#global-mindmap-sect").show();
	startMindMap();
	loadMindMap();
	//웹접근성 조치 
	$("#global-mindmap-obj").focus();
	$("input[name=mindmapCloseLoc]").val(value);
}

/**
 * 마인드맵 레이어 닫기
 */
function gfn_hideMindmap() {
	$("#global-mindmap-sect").hide();
	$("#global-mindmap-obj").empty();
	//웹접근성 조치
	var focusId = $("input[name=mindmapCloseLoc]").val();
	if( focusId == "fstEleMindmap" ) {
		$(".menu_more_btn").removeClass("on").addClass("off");
		$(".menulayer01").removeClass("off").addClass("on");
		$(".menulayer02").removeClass("on").addClass("off");
		$(".moremenu").hide();
		$(".allmenu").show();
		$(".menulayer01 li > div").show();
		$(".menulayer02 li > div").hide();
		$("#"+focusId).focus();
	} else if ( focusId == "secEleMindmap" ) {
		$(".menu_more_btn").removeClass("off").addClass("on");
		$(".menulayer01").removeClass("on").addClass("off");
		$(".menulayer02").removeClass("off").addClass("on");
		$(".moremenu").show();
		$(".allmenu").hide();
		$(".menulayer01 li > div").hide();
		$(".menulayer02 li > div").show();
		$("#"+focusId).focus();
	}
	else {
		$("#"+focusId).focus();
	}
	
}

/**
* 포털에 날짜 캘린더를 추가한다.
*/
function gfn_portalCalendar(obj) {
	if ( obj.length > 0 ) {
		obj.datepicker({
			monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
			dayNamesMin: ['일','월','화','수','목','금','토'],
			weekHeader: 'Wk',
			dateFormat: 'yy-mm-dd', //형식(20120303)
			autoSize: false, //오토리사이즈(body등 상위태그의 설정에 따른다)
			changeMonth: true, //월변경가능
			changeYear: true, //년변경가능
			showMonthAfterYear: true, //년 뒤에 월 표시
			buttonImageOnly: true, //이미지표시
			buttonText: '달력선택', //버튼 텍스트 표시
			buttonImage: "../../../../images/icon_calendar.png", //이미지주소                                              
			showOn: "both", //엘리먼트와 이미지 동시 사용(both,button)                 
			yearRange: '1900:2100', //1990년부터 2020년까지
			showButtonPanel: true, 
			closeText: 'close'	
		});
	}
}

/**
 * 국회의원 상세 팝업을 연다
 * @param empNo	국회의원 번호
 * @param empNo	국회의원 대수
 * @returns
 */
function gfn_openMembPopup(monaCd, unitCd) {
	unitCd = unitCd || "";
	if ( com.wise.util.isEmpty(monaCd) )	return false;
	
	var w =  1217, h = 900, leftPos=(screen.width-w)/2, topPos=(screen.height-h)/2;
	var url = com.wise.help.url("/portal/assm/memberPage.do"),
		params = "?monaCd=" + monaCd;
	
	if ( !com.wise.util.isNull(unitCd) ) {
		params += "&unitCd=" + unitCd;
	}
	
	var win = window.open(url + params, "assmMemPop", "width="+w+",height="+h+",top="+topPos+",left="+leftPos+",location=no,status=no,menubar=no,toolbar=no,scrollbars=1");
    win.focus();
}


/**
 * 팝업을 오픈한다.
 * @param options
 * @returns
 */
function gfn_openPopup(options) {
	if ( com.wise.util.isEmpty(options.url) )	return false;
	
	options.name = options.name 	|| "";
	options.width = options.width 	|| 1024;
	options.height = options.height || 768;
	
	var win = window.open(com.wise.help.url(options.url), options.name, "width="+String(options.width)+",height="+String(options.height)+",location=no,status=no,menubar=no,toolbar=no,scrollbars=1");
    win.focus();
}

/**
 * 파일 다운로드
 */
function gfn_fileDownload(options) {
	options.url = options.url || "";
	if ( options.url == "" ) return;
	
	$.fileDownload(com.wise.help.url(options.url), {
	    httpMethod: "POST",
	    data: options.params,
	    successCallback: function(s) {},
	    failCallback: function() {
	    	alert("다운로드중 오류가 발생하였습니다.");
	    }
	});
}

/**
 * 관리자 페이지 이동
 */
function gfn_moveAdmin() {
	var form = document.getElementById('adminLoginForm');
	form.target = "_blank";
	form.submit();
}

/**
 * 통합검색 인기검색어 조회
 * @returns	인기검색어 조회한 뒤 가중치별로 파싱한 배열값
 */
function gfn_getPropWord(param) {
	param.range = param.range || "W";		// D:일간 , W: 주간, M:월간
	
	var datas = null;
	
	//통합검색 인기검색어 결과값
	doAjax({
		url: "/portal/search/getPopword.do",
		params: {
			range: param.range, 
			collection: "iopenpop",
			target: "popword"
		},
		callback: function(res) {
			if ( !com.wise.util.isEmpty(res) && !com.wise.util.isBlank(res) ) {
				var dataJson = JSON.parse(res);
				datas = gfn_totalSch_parseWordData(dataJson.Data.Query);
			}
		}
	});
	 
	/*
	datas = datas || [{"content":"정보공개포털","id":1,"count":-1,"updown":"N"}, {"content":"국회","id":2,"count":2,"updown":"U"}, {"content":"국회의원","id":3,"count":1,"updown":"D"}, {"content":"의안정보","id":4,"count":-1,"updown":"N"}, {"content":"회의록","id":5,"count":3,"updown":"D"}, {"content":"국회생중계","id":6,"count":0,"updown":"C"}, {"content":"역대국회의원","id":7,"count":-1,"updown":"N"}, {"content":"입법예고","id":8,"count":23,"updown":"U"}, {"content":"의정활동","id":9,"count":0,"updown":"C"}, {"content":"보고서","id":10,"count":0,"updown":"C"},
		{"content":"발간물","id":11,"count":0,"updown":"C"}, {"content":"정보공개청구","id":12,"count":0,"updown":"C"}, {"content":"의안처리현황","id":13,"count":0,"updown":"C"}, {"content":"국회사무처","id":14,"count":0,"updown":"C"}, {"content":"국회도서관","id":15,"count":0,"updown":"C"}, {"content":"국회예산정책처","id":16,"count":0,"updown":"C"}, {"content":"재정","id":17,"count":0,"updown":"C"}, {"content":"행정","id":18,"count":0,"updown":"C"}, {"content":"법률","id":19,"count":0,"updown":"C"}, {"content":"발의","id":20,"count":0,"updown":"C"},
		{"content":"입법조사","id":21,"count":0,"updown":"C"}, {"content":"마인드맵","id":22,"count":0,"updown":"C"}, {"content":"테마","id":23,"count":0,"updown":"C"}	, {"content":"세비정보","id":24,"count":0,"updown":"C"}, {"content":"FAQ","id":25,"count":0,"updown":"C"}	, {"content":"표결현황","id":26,"count":0,"updown":"C"}, {"content":"인기공개","id":27,"count":0,"updown":"C"}, {"content":"지금","id":28,"count":0,"updown":"C"}	, {"content":"공지사항","id":29,"count":0,"updown":"C"}, {"content":"발간물","id":30,"count":0,"updown":"C"},
		{"content":"용역","id":31,"count":0,"updown":"C"}, {"content":"정보공개","id":32,"count":0,"updown":"C"}, {"content":"데이터","id":33,"count":0,"updown":"C"}, {"content":"공지사항","id":34,"count":0,"updown":"C"}, {"content":"국회의장","id":35,"count":0,"updown":"C"}, {"content":"예결위","id":36,"count":0,"updown":"C"}, {"content":"법사위","id":37,"count":0,"updown":"C"}, {"content":"환노위","id":38,"count":0,"updown":"C"}, {"content":"최고","id":39,"count":0,"updown":"C"}, {"content":"정보","id":40,"count":0,"updown":"C"}];
	datas = gfn_totalSch_parseWordData(datas);
	 */
	
	return datas;
}

/**
 * 통합검색 데이터 가중치 적용하여 파싱한다.
 * @param datas	통합검색 결과 데이터
 * @returns
 */
function gfn_totalSch_parseWordData(datas) {
	
	if ( datas != null && datas.length > 0 ) {
		
		var parseData = _.map(datas, function(data, idx) {
		var weight  = function() {
			var cnt = 0;
			if (data.id <= 5) {
				cnt = 400;
			}
			else if (data.id <= 5) {
				cnt = 300;
			}
			else if (data.id <= 15)	{
				cnt = 250;
			}
			else {
				cnt = 200;
			}
			return cnt - (Number(data.id) * 3);
		}();
		return {'name': data.content, 'weight': weight};
		});
		return parseData;
	}
	else {
		return null;
	}
}

/**
 * 테이블 행을 머지한다.
 * @param className	클래스명
 * @returns
 */
function gfn_tableRowMerge(className) {
	$("." + className).each(function() {
        var rows = $("." + className + ":contains('" + $(this).text() + "')");
        if (rows.length > 1) {
            rows.eq(0).attr("rowspan", rows.length);
            rows.not(":eq(0)").remove();
        }
    });
}

/**
 * 쿠키를 정보를 가져온다.
 * @param name	쿠키명
 * @returns
 */
function gfn_getCookie(name) {
	var obj = name + "="; 
    var x = 0; 
    while ( x <= document.cookie.length ) { 
        var y = (x+obj.length); 
        if ( document.cookie.substring( x, y ) == obj ) { 
            if ((endOfCookie=document.cookie.indexOf( ";", y )) == -1 ) {
            	endOfCookie = document.cookie.length;
            } 
            return unescape( document.cookie.substring( y, endOfCookie ) ); 
        } 
        x = document.cookie.indexOf( " ", x ) + 1; 
        if ( x == 0 ) 
            break; 
    } 
    return ""; 
}

/**
 * 쿠키를 설정한다.
 * @param name	쿠키명
 * @param value	값
 * @param expiredays 쿠키 유지일자
 * @returns
 */
function gfn_setCookie(name, value, expiredays) {
	var todayDate = new Date();
	todayDate.setDate( todayDate.getDate() + expiredays );
	document.cookie = name + '=' + escape( value ) + '; path=/; expires=' + todayDate.toGMTString() + ';'
}

/**
 * 현역 국회의원 상세 팝업을 연다 > 도메인 처리
 * @param openNaId	도메인 키값
 * @returns
 */
function gfn_openNowMembPopup(openNaId) {
	openNaId = openNaId || "";
	if ( com.wise.util.isEmpty(openNaId) )	return false;
	
	var w =  1217, h = 900, leftPos=(screen.width-w)/2, topPos=(screen.height-h)/2;
	var url = com.wise.help.url("/21stMembers/"+openNaId);
	var win = window.open(url, "assmNowMemPop", "width="+w+",height="+h+",top="+topPos+",left="+leftPos+",location=no,status=no,menubar=no,toolbar=no,scrollbars=1");
    win.focus();
}

/**
 * 현역 국회의원 상세 팝업을 연다 > 도메인 처리
 * @param openNaId	도메인 키값
 * @returns
 */
function gfn_newNowMembPopup(linkUrl) {
	linkUrl = linkUrl || "";
	if ( com.wise.util.isEmpty(linkUrl) )	return false;

	var w =  1300, h = 900, leftPos=(screen.width-w)/2, topPos=(screen.height-h)/2;
	var url = com.wise.help.url(linkUrl);
	var win = window.open(url, "assmNowMemPop", "width="+w+",height="+h+",top="+topPos+",left="+leftPos+",location=no,status=no,menubar=no,toolbar=no,scrollbars=1");
	win.focus();
}

/**
 * 역대 국회의원 상세 팝업을 연다 > 도메인 처리
 * @param openNaId	도메인 키값
 * @returns
 */
function gfn_openHisMembPopup(openNaId, unitCd) {
	openNaId = openNaId || "";
	unitCd = unitCd || "";
	if ( com.wise.util.isEmpty(openNaId) )	return false;
	if ( com.wise.util.isEmpty(unitCd) ) {
		return false;
	} else {
		unit = unitCd.slice(-2);
	}
	
	var w =  1217, h = 900, leftPos=(screen.width-w)/2, topPos=(screen.height-h)/2;
	var url = com.wise.help.url("/"+unit+"stMembers/"+openNaId);
	var win = window.open(url, "assmHisMemPop", "width="+w+",height="+h+",top="+topPos+",left="+leftPos+",location=no,status=no,menubar=no,toolbar=no,scrollbars=1");
    win.focus();
}
