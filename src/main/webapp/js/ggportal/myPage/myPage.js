/*
 * COPYRIGHT (C) 2013 WISEITECH CO., LTD. ALL RIGHTS RESERVED.
 */

/**
	장홍식
 */

$(function() {
	// 이벤트 바인딩
	bindEvent();
	
	// 데이터 로드
	loadData();
	
});

////////////////////////////////////////////////////////////////////////////////
//글로벌 변수
////////////////////////////////////////////////////////////////////////////////
var templates = {
		data0 : "<tr>"
				+" 	<td class=\"talL\"></td>"
				+" 	<td class=\"talL\"></td>"
				+" 	<td></td>"
				+" 	<td></td>"
				+" 	<td></td>"
				+" </tr>"
		, data_m0 : "<li>"
				+"	<strong class=\"tit\"></strong>"
				+"	<p class=\"cont\"></p>"
				+"	<dl>"
				+"	<dt class=\"hide\">발급일</dt>"
				+"	<dd class=\"ty_B first\"></dd>"
				+"	<dt>호출</dt>"
				+"	<dd></dd>"
				+"	<dt class=\"hide\">사용여부</dt>"
				+"	<dd class=\"ty_B\"></dd>"
				+"	</dl>"
				+"</li>"
		, none0 : "<tr><td colspan=\"6\" class=\"noData\">해당 자료가 없습니다.</td></tr>"
		, none_m0 : "<li class=\"noData\">해당 자료가 없습니다.</li>"
	    , data1:
	        "<tr>"                                                                               +
	            "<td><span class=\"mq_tablet rowNum\"></span></td>"                              +
	            "<td class=\"area_tit\">"                                                        +
	                "<a href=\"#\" class=\"link tit ellipsis w_400 bbsTit\"></a>"                +
	                "<strong class=\"btn_detail mq_mobile\"><a href=\"#\">상세보기</a></strong>" +
	            "</td>"                                                                          +
	            "<td><span class=\"date userDttm\"></span></td>"                                 +
	            "<td class=\"txt\"><span class=\"txt_D ansStateNm\"></span></td>"                +
	            "<td><span class=\"mq_tablet viewCnt\"></span></td>"                             +
	        "</tr>"
	     , none1:
	        "<tr>"                                                              +
	            "<td colspan=\"6\" class=\"noData\">해당 자료가 없습니다.</td>" +
	        "</tr>"
        , data2:
            "<li>"                                               +
                "<a href=\"#\" class=\"link\">"                  +
                    "<span class=\"icon fileSeq\"></span>"       +
                    "<span class=\"summary\">"                   +
                        "<strong class=\"tit bbsTit\"></strong>" +
                        "<span class=\"name userNm\"></span>"    +
                        " "                                      +
                        "<span class=\"date userDttm\"></span>"  +
                        "<span class=\"grade apprVal\"></span>"  +
                    "</span>"                                    +
                "</a>"                                           +
            "</li>"
        , none2:
            "<li class=\"noData\">해당 자료가 없습니다.</li>"
        	
        	, data3:
                "<li>"                                               +
                    "<a href=\"#\" class=\"link\">"                  +
                        "<span class=\"icon fileSeq\"></span>"       +
                        "<span class=\"summary\">"                   +
                            "<strong class=\"tit bbsTit\"></strong>" +
                            "<span class=\"name userNm\"></span>"    +
                            " "                                      +
                            "<span class=\"date userDttm\"></span>"  +
                        "</span>"                                    +
                    "</a>"                                           +
                "</li>"
            , none3:
                "<li class=\"noData\">해당 자료가 없습니다.</li>"
            	
            , dataScrap:
                "<tr>"                                                                               +
	                "<td><span class=\"mq_tablet simmixTag\"></span></td>"                           +
	                "<td class=\"area_tit\">"                                                        +
	                    "<a href=\"#\" class=\"link tit ellipsis w_400 statblNm\"></a>"              +
	                    "<strong class=\"btn_detail mq_mobile\"><a href=\"#\">상세보기</a></strong>" +
	                "</td>"                                                                          +
	                "<td><span class=\"date searchTag\"></span></td>"                                +
	                "<td class=\"txt\"><span class=\"regDttm\"></span></td>"                   +
	                "<td><span class=\"mq_tablet searchPop\"></span></td>"                           +
                "</tr>"
            , noneScrap:
	            "<tr>"                                                              +
	                "<td colspan=\"6\" class=\"noData\">해당 자료가 없습니다.</td>" +
	            "</tr>"
};

/**
 * 바인딩 이벤트
 */
function bindEvent() {
	
	// 인증키발급 버튼
	$('#actKey-insertpage-btn').bind('click', function() {
		goSelect({
	        url:"/portal/myPage/actKeyPage.do",
	        form:"search-form",
	        data:[{
	            name:"tabIdx",
	            value:1
	        }]
	    });
	});
	// 인증키 더보기 버튼
	$('#actKey-page-btn').bind('click', function() {
		goSelect({
	        url:"/portal/myPage/actKeyPage.do",
	        form:"search-form",
	        data:[{
	            name:"tabIdx",
	            value:0
	        }]
	    });
	});
	
	// 질문 작성 버튼
	$('#qna-insertpage-btn').bind('click', function() {
	    goInsert({
	        url:"/portal/myPage/insertMyQnaPage.do",
	        form:"search-form",
	        data:[{
	            name:"bbsCd",
	            value:"QNA01"
	        	}
	        , {
	            name:"seq",
	            value:""
	        }]
	    });
	});
	// 질문 더보기 버튼
	$('#qna-page-btn').bind('click', function() {
	    goSearch({
	        url:"/portal/myPage/myQnaPage.do",
	        form:"search-form",
	        data:[{
	            name:"bbsCd",
	            value:"QNA01"
	        	}
	        , {
	            name:"page",
	            value:"1"
	        }]
	    });
	});
	
	// 활용 갤러리 등록 페이지 버튼
	$('#gallery-insertpage-btn').bind('click', function() {
	    goInsert({
	        url:"/portal/myPage/insertUtilGalleryPage.do",
	        form:"search-form",
	        data:[{
	            name:"bbsCd",
	            value:"GALLERY"
	        	}
	        , {
	            name:"seq",
	            value:""
	        }]
	    });
	});
	// 활용 갤러리 더보기 버튼
	$('#gallery-page-btn').bind('click', function() {
	    goSearch({
	        url:"/portal/myPage/utilGalleryPage.do",
	        form:"search-form",
	        data:[{
	            name:"bbsCd",
	            value:"GALLERY"
	        	}
	        , {
	            name:"page",
	            value:"1"
	        }]
	    });
	});
	
	// 블로그 등록 페이지 버튼
	$('#blog-insertpage-btn').bind('click', function() {
	    goInsert({
	        url:"/portal/myPage/insertUtilBlogPage.do",
	        form:"search-form",
	        data:[{
	            name:"bbsCd",
	            value:"BLOG"
	        	}
	        , {
	            name:"seq",
	            value:""
	        }]
	    });
	});
	// 활용 갤러리 더보기 버튼
	$('#blog-page-btn').bind('click', function() {
	    goSearch({
	        url:"/portal/myPage/utilBlogPage.do",
	        form:"search-form",
	        data:[{
	            name:"bbsCd",
	            value:"BLOG"
	        	}
	        , {
	            name:"page",
	            value:"1"
	        }]
	    });
	});
	
	$("#scrap-page-btn").bind('click', function() {
	    goSearch({
	        url:"/portal/myPage/statUserScrapPage.do",
	        form:"search-form",
	        data:[]
	    });
	});
}

/**
 * 데이터 로드
 */
function loadData() {
	// 인증키
	searchActKey();
	// QNA
	searchQna();
	// 활용갤러리
	searchGallery();
	// 블로그
	searchBlog();
	// 통계스크랩
	searchScrap();
}


////////////////////////////////////////////////////////////////////////////////
//서비스 함수
////////////////////////////////////////////////////////////////////////////////
/**
 * 인증키 목록 조회
 */
function searchActKey() {
	doSearch({
        url:"/portal/myPage/searchActKey.do",
        before:function(){return {viewCnt:5};},
        after:afterSearchActKey
	});
}

/**
 * Q&A 게시판 내용을 검색한다.
 */
function searchQna() {
    // 데이터를 검색한다.
    doSearch({
        url:"/portal/myPage/myBBSList.do",
        page:"1",
        before:function() {return {bbsCd:"QNA01"};},
        after:afterSearchQna,
        counter:{
            count:"totalCnt-1"
        }
    });
}

/**
 * 갤러리 게시판 내용을 검색한다.
 * 
 */
function searchGallery() {
    // 데이터를 검색한다.
    doSearch({
        url:"/portal/myPage/myBBSList.do",
        page:"1",
        before:function() {return {bbsCd:"GALLERY"};},
        after:afterSearchGallery,
        counter:{
            count:"totalCnt-2"
        }
    });
}

function searchBlog() {
    // 데이터를 검색한다.
    doSearch({
        url:"/portal/myPage/myBBSList.do",
        page:"1",
        before:function() {return {bbsCd:"BLOG"};},
        after:afterSearchBlog,
        counter:{
            count:"totalCnt-3"
        }
    });
}



/**
 * Q&A 게시판 내용을 조회한다.
 * 
 * @param data {Object} 데이터
 */
function selectQna(data) {
    // if (!verifyWriter(data.lockTag, "search-form", selectQna, data)) {
    //     return;
    // }
    
    // 데이터를 조회하는 화면으로 이동한다.
    goSelect({
        url:"/portal/myPage/selectMyQnaPage.do",
        form:"search-form",
        data:[{
            name:"bbsCd",
            value:data.bbsCd
        }, {
            name:"seq",
            value:data.seq
        }, {
            name:"noticeYn",
            value:data.noticeYn
        }]
    });
}

/**
 * 갤러리 게시판 내용을 조회한다.
 * 
 * @param data {Object} 데이터
 */
function selectGallery(data) {
    // if (!verifyWriter(data.lockTag, "search-form", selectGallery, data)) {
    //     return;
    // }
    
    // 데이터를 조회하는 화면으로 이동한다.
    goSelect({
        url:"/portal/myPage/selectUtilGalleryPage.do",
        form:"search-form",
        data:[{
            name:"bbsCd",
            value:data.bbsCd
        }, {
            name:"seq",
            value:data.seq
        }, {
            name:"noticeYn",
            value:data.noticeYn
        }]
    });
}

/**
 * 블로그 게시판 내용을 조회한다.
 * 
 * @param data {Object} 데이터
 */
function selectBlog(data) {
    // if (!verifyWriter(data.lockTag, "search-form", selectGallery, data)) {
    //     return;
    // }
    
    // 데이터를 조회하는 화면으로 이동한다.
    goSelect({
        url:"/portal/myPage/selectUtilBlogPage.do",
        form:"search-form",
        data:[{
            name:"bbsCd",
            value:data.bbsCd
        }, {
            name:"seq",
            value:data.seq
        }, {
            name:"noticeYn",
            value:data.noticeYn
        }]
    });
}



/**
 * 갤러리 활용사례 평가점수를 반환한다.
 * 
 * @param value {Object} 점수
 */
function getAppraisal(value) {
    if (value == 0.0) {
        return "<img src=\"" + com.wise.help.url("/img/ggportal/desktop/common/grade_0.png") + "\" class=\"icon_grade\" alt=\"총점 5점 중 평점 0점 아주 나쁨\" />";
    }
    else if (value > 0.0 && value <= 0.5) {
        return "<img src=\"" + com.wise.help.url("/img/ggportal/desktop/common/grade_1.png") + "\" class=\"icon_grade\" alt=\"총점 5점 중 평점 0.5점 아주 나쁨\" />";
    }
    else if (value > 0.5 && value <= 1.0) {
        return "<img src=\"" + com.wise.help.url("/img/ggportal/desktop/common/grade_2.png") + "\" class=\"icon_grade\" alt=\"총점 5점 중 평점 1점 아주 나쁨\" />";
    }
    else if (value > 1.0 && value <= 1.5) {
        return "<img src=\"" + com.wise.help.url("/img/ggportal/desktop/common/grade_3.png") + "\" class=\"icon_grade\" alt=\"총점 5점 중 평점 1.5점 아주 나쁨\" />";
    }
    else if (value > 1.5 && value <= 2.0) {
        return "<img src=\"" + com.wise.help.url("/img/ggportal/desktop/common/grade_4.png") + "\" class=\"icon_grade\" alt=\"총점 5점 중 평점 2점 나쁨\" />";
    }
    else if (value > 2.0 && value <= 2.5) {
        return "<img src=\"" + com.wise.help.url("/img/ggportal/desktop/common/grade_5.png") + "\" class=\"icon_grade\" alt=\"총점 5점 중 평점 2.5점 나쁨\" />";
    }
    else if (value > 2.5 && value <= 3.0) {
        return "<img src=\"" + com.wise.help.url("/img/ggportal/desktop/common/grade_6.png") + "\" class=\"icon_grade\" alt=\"총점 5점 중 평점 3점 보통\" />";
    }
    else if (value > 3.0 && value <= 3.5) {
        return "<img src=\"" + com.wise.help.url("/img/ggportal/desktop/common/grade_7.png") + "\" class=\"icon_grade\" alt=\"총점 5점 중 평점 3.5점 보통\" />";
    }
    else if (value > 3.5 && value <= 4.0) {
        return "<img src=\"" + com.wise.help.url("/img/ggportal/desktop/common/grade_8.png") + "\" class=\"icon_grade\" alt=\"총점 5점 중 평점 4점 좋음\" />";
    }
    else if (value > 4.0 && value <= 4.5) {
        return "<img src=\"" + com.wise.help.url("/img/ggportal/desktop/common/grade_9.png") + "\" class=\"icon_grade\" alt=\"총점 5점 중 평점 4.5점 좋음\" />";
    }
    else if (value > 4.5) {
        return "<img src=\"" + com.wise.help.url("/img/ggportal/desktop/common/grade_10.png") + "\" class=\"icon_grade\" alt=\"총점 5점 중 평점 5점 아주 좋음\" />";
    }
    else {
        return "<img src=\"" + com.wise.help.url("/img/ggportal/desktop/common/grade_0.png") + "\" class=\"icon_grade\" alt=\"총점 5점 중 평점 0점 아주 나쁨\" />";
    }
}

/**
 * 통계스크랩 목록을 조회한다.
 */
function searchScrap() {
    // 데이터를 검색한다.
    doSearch({
        url:"/portal/myPage/statUserScrapList.do",
        page:"1",
        before:function() {return {viewCnt:5};},
        after:afterSearchScrap,
        counter:{
            count:"totalCnt-scrap"
        }
    });
}

////////////////////////////////////////////////////////////////////////////////
//전처리 함수
////////////////////////////////////////////////////////////////////////////////


////////////////////////////////////////////////////////////////////////////////
//후처리 함수
////////////////////////////////////////////////////////////////////////////////

/**
 * 인증키 목록 조회 후 처리함수
 * 
 */
function afterSearchActKey(data) {
	if(data.length > 0) {
		$('#totalCnt-0').text(data[0].totalCnt);
		$.each(data, function(i, d) {
			var row = $(templates.data0);
			var row_m = $(templates.data_m0);
			
			row.find("td:eq(0)").text(d.actKey);
			row.find("td:eq(1)").text(d.useNm);
			row.find("td:eq(2)").text(d.regDttm);
			row.find("td:eq(3)").text(d.callCnt);
			row.find("td:eq(4)").text(d.keyState);
			
			row_m.find("strong").text(d.actKey);
			row_m.find("p").text(d.useNm);
			row_m.find("dd:eq(0)").text(d.regDttm);
			row_m.find("dd:eq(1)").text(d.callCnt);
			row_m.find("dd:eq(2)").text(d.keyState);

			$('#actkey-list').append(row);
			$('#actkey-list-mob').append(row_m);
		});
	} else {
		$('#actkey-list').append($(templates.none0));
		$('#actkey-list-mob').append($(templates.none_m0));
	}
}

/**
 * Q&A 게시판 내용 검색 후처리를 실행한다.
 * 
 */
function afterSearchQna(data) {
    var table = $("#qna-data-table");
    
    table.find("tr").each(function(index, element) {
        if (index > 0) {
            $(this).remove();
        }
    });
    var viewCnt = data.length > 5 ? 5 : data.length;
 
    for (var i = 0; i < viewCnt; i++) {
        var row = $(templates.data1);
        
        if (data[i].noticeYn == "Y") {
            row.addClass("notice");
            
            row.find(".rowNum").parent("td").html("<span class=\"txt_C\">공지</span>");
        }
        else {
            row.find(".rowNum").text(data[i].rowNum);
        }
        
        row.find(".bbsTit").text(data[i].bbsTit);
        
        if (data[i].secretYn == "Y") {
            row.find(".bbsTit").prepend("<img src=\"" + com.wise.help.url("/img/ggportal/desktop/common/icon_lock.png") + "\" alt=\"\" title=\"비밀글 아이콘\" /> ");
        }
        
        // if (data[i].newYn == "Y") {
        //     row.find(".bbsTit").prepend("<span class=\"txt_new\"></span> ");
        // }
        
        // if (data[i].viewCnt >= data[i].hlCnt) {
        //     row.find(".bbsTit").addClass("best");
        // }
        
        row.find(".userDttm").text(data[i].userDttm);
        
        switch (data[i].ansState) {
            case "RW":
                row.find(".ansStateNm").addClass("txt_D_inquiry");
                break;
            case "AW":
                row.find(".ansStateNm").addClass("txt_D_standby");
                break;
            case "AK":
                row.find(".ansStateNm").addClass("txt_D_answer");
                break;
            case "AC":
                row.find(".ansStateNm").addClass("txt_D_impossibility");
                break;
        }
        
        row.find(".ansStateNm").text(data[i].ansStateNm);
        row.find(".viewCnt").text(com.wise.util.toCurrency(data[i].viewCnt.toString()));
        
        row.find("a").each(function(index, element) {
            // Q&A 게시판 내용 제목 링크에 클릭 이벤트를 바인딩한다.
            $(this).bind("click", {
                bbsCd:data[i].bbsCd,
                seq:data[i].seq,
                noticeYn:data[i].noticeYn,
                lockTag:data[i].lockTag
            }, function(event) {
                // Q&A 게시판 내용을 조회한다.
                selectQna(event.data);
                return false;
            });
            
            // Q&A 게시판 내용 제목 링크에 키다운 이벤트를 바인딩한다.
            $(this).bind("keydown", {
                bbsCd:data[i].bbsCd,
                seq:data[i].seq,
                noticeYn:data[i].noticeYn,
                lockTag:data[i].lockTag
            }, function(event) {
                if (event.which == 13) {
                    // Q&A 게시판 내용을 조회한다.
                    selectQna(event.data);
                    return false;
                }
            });
        });
        
        table.append(row);
    }
    
    if (data.length == 0) {
        var row = $(templates.none1);
        
        table.append(row);
    }

}


/**
 * 갤러리 게시판 내용 검색 후처리를 실행한다.
 * 
 * @param data {Array} 데이터
 */
function afterSearchGallery(data) {
    var list = $("#gallery-data-list");
    
    list.find("li").each(function(index, element) {
        $(this).remove();
    });
    
    var viewCnt = data.length > 4 ? 4 : data.length;
    
    for (var i = 0; i < viewCnt; i++) {
        var item = $(templates.data2);
        
        if (data[i].fileSeq) {
            var url = com.wise.help.url("/portal/myPage/gallery/selectAttachFile.do") + "?fileSeq=" + data[i].fileSeq;
            
            item.find(".fileSeq").html("<img src=\"" + url + "\" alt=\"" + data[i].bbsTit + "\" />");
        }
        else {
            item.find(".fileSeq").html("<img alt=\"" + data[i].bbsTit + "\" />");
        }
        
        item.find(".bbsTit").text(data[i].bbsTit);
        item.find(".userNm").text(data[i].userNm);
        item.find(".userDttm").text(data[i].userDttm);
        item.find(".apprVal").html(getAppraisal(data[i].apprVal));
        
        // 갤러리 게시판 내용 제목 링크에 클릭 이벤트를 바인딩한다.
        item.find("a").bind("click", {
            bbsCd:data[i].bbsCd,
            seq:data[i].seq,
            noticeYn:data[i].noticeYn,
            lockTag:data[i].lockTag
        }, function(event) {
            // 갤러리 게시판 내용을 조회한다.
            selectGallery(event.data);
            return false;
        });
        
        // 갤러리 게시판 내용 제목 링크에 키다운 이벤트를 바인딩한다.
        item.find("a").bind("keydown", {
            bbsCd:data[i].bbsCd,
            seq:data[i].seq,
            noticeYn:data[i].noticeYn,
            lockTag:data[i].lockTag
        }, function(event) {
            if (event.which == 13) {
                // 갤러리 게시판 내용을 조회한다.
                selectGallery(event.data);
                return false;
            }
        });
        
        list.append(item);
    }
    
    if (data.length == 0) {
        var item = $(templates.none2);
        
        list.append(item);
    }
}

function afterSearchBlog(data) {
    var list = $("#blog-data-list");
  
    list.find("li").each(function(index, element) {
        $(this).remove();
    });
    
    var viewCnt = data.length > 4 ? 4 : data.length;
    
    for (var i = 0; i < viewCnt; i++) {
        var item = $(templates.data2);
        
        if (data[i].fileSeq) {
            var url = com.wise.help.url("/portal/myPage/gallery/selectAttachFile.do") + "?fileSeq=" + data[i].fileSeq;
            
            item.find(".fileSeq").html("<img src=\"" + url + "\" alt=\"" + data[i].bbsTit + "\" />");
        }
        else {
            item.find(".fileSeq").html("<img alt=\"" + data[i].bbsTit + "\" />");
        }
        
        item.find(".bbsTit").text(data[i].bbsTit);
        item.find(".userNm").text(data[i].userNm);
        item.find(".userDttm").text(data[i].userDttm);
        //item.find(".apprVal").html(getAppraisal(data[i].apprVal));
        
        // 갤러리 게시판 내용 제목 링크에 클릭 이벤트를 바인딩한다.
        item.find("a").bind("click", {
            bbsCd:data[i].bbsCd,
            seq:data[i].seq,
            noticeYn:data[i].noticeYn,
            lockTag:data[i].lockTag
        }, function(event) {
            // 갤러리 게시판 내용을 조회한다.
            selectBlog(event.data);
            return false;
        });
        
        // 갤러리 게시판 내용 제목 링크에 키다운 이벤트를 바인딩한다.
        item.find("a").bind("keydown", {
            bbsCd:data[i].bbsCd,
            seq:data[i].seq,
            noticeYn:data[i].noticeYn,
            lockTag:data[i].lockTag
        }, function(event) {
            if (event.which == 13) {
                // 갤러리 게시판 내용을 조회한다.
                selectBlog(event.data);
                return false;
            }
        });
        
        list.append(item);
    }
    
    if (data.length == 0) {
        var item = $(templates.none2);
        
        list.append(item);
    }
}

/**
 * 통계스크랩 내용 검색 후처리를 실행한다.
 * 
 * @param data {Array} 데이터
 */
function afterSearchScrap(data) {
    var table = $("#scrap-data-table");
    var windowWidth = $(window).width();
    var windowHeight = $(window).height();
    
    table.find("tr").each(function(index, element) {
        if (index > 0) {
            $(this).remove();
        }
    });
    for (var i = 0; i < data.length; i++) {
        var row = $(templates.dataScrap);
       
        row.find(".simmixTag").text(data[i].simmixTagNm);
        row.find(".statblNm").text(data[i].statblNm);
        
        row.find(".searchTag").text(data[i].searchTagNm);
        row.find(".regDttm").text(data[i].regDttm);
        row.find(".searchPop").text("조회(팝업)").addClass("txt_D_inquiry");
        
        row.find("a").each(function(index, element) {
            // 통계스크랩 내용 제목 링크에 클릭 이벤트를 바인딩한다.
            $(this).bind("click", {
            	seqceNo : data[i].seqceNo,
            	simmixTag : data[i].simmixTag
            }, function(event) {
            	var urlPage = ""; //간편통계(S), 복수통계(M)
            	if(event.data.simmixTag == "S") urlPage = "/portal/stat/easyStatSch.do";
            	else  urlPage = "/portal/stat/multiStatSch.do";
            	var url = com.wise.help.url(urlPage) + "?usrTblSeq=" + event.data.seqceNo;
            	window.open(url,'pop'+event.data.seqceNo,'height=' + windowHeight + ',width=' + windowWidth + 'fullscreen=yes');
            });
        });
        table.append(row);
    }
    
    if (data.length == 0) {
        var row = $(templates.noneScrap);
        table.append(row);
    }
}
