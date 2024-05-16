/*
 * COPYRIGHT (C) 2013 WISEITECH CO., LTD. ALL RIGHTS RESERVED.
 */
/**
 * 마이페이지에서 통계스크랩 목록을 보는 페이지이다.
 *
 * @author 김정호
 * @version 1.0 2017/12/12
 */


$(function() {
    // 컴포넌트를 초기화한다.
    initComp();
    
    // 마스크를 바인딩한다.
    bindMask();
    
    // 이벤트를 바인딩한다.
    bindEvent();
    
    // 옵션을 로드한다.
    loadOptions();
    
    // 데이터를 로드한다.
    loadData();
});

/**
 * 템플릿
 */
var templates = {
    data:
        "<tr>"                                                                               +        	
            "<td><span class=\"mq_tablet simmixTag\"></span></td>"                           +
            "<td class=\"area_tit\">"                                                        +
                "<a href=\"#\" class=\"link tit ellipsis w_400 statblNm\"></a>"              +
                "<strong class=\"btn_detail mq_mobile\"><a href=\"#\">상세보기</a></strong>" +
            "</td>"                                                                          +
            "<td><span class=\"date searchTag\"></span></td>"                                +
            "<td class=\"txt\"><span class=\"txt_D regDttm fcgray\"></span></td>"            +
            "<td><a href='javascript:;'><span class=\"mq_tablet searchPop\"></span></a></td>"+
            "<td><a class=\"btn_scrap\">삭제</a></td>"                           +
        "</tr>",
    none:
        "<tr>"                                                              +
            "<td colspan=\"6\" class=\"noData\">해당 자료가 없습니다.</td>" +
        "</tr>"
};

////////////////////////////////////////////////////////////////////////////////
// 초기화 함수
////////////////////////////////////////////////////////////////////////////////
/**
 * 컴포넌트를 초기화한다.
 */
function initComp() {
    //var code = $("#qna-search-form [name=listSubCd]").val();
    
    //$(".qna-section-tab[href='#" + code + "']").addClass("on");
    
   // $("#qna-searchtype-combo").val($("#qna-search-form [name=searchType]").val());
    //$("#qna-searchword-field").val($("#qna-search-form [name=searchWord]").val());
}

/**
 * 마스크를 바인딩한다.
 */
function bindMask() {
    // Nothing to do.
}

/**
 * 이벤트를 바인딩한다.
 */
function bindEvent() {
    
}

/**
 * 옵션을 로드한다.
 */
function loadOptions() {
    // Nothing do do.
}

/**
 * 데이터를 로드한다.
 */
function loadData() {
    // Q&A 게시판 내용을 검색한다.
	searchScrap($("#scrap-search-form [name=page]").val());
}

////////////////////////////////////////////////////////////////////////////////
// 서비스 함수
////////////////////////////////////////////////////////////////////////////////
/**
 * 통계스크랩 목록 검색한다.
 * 
 * @param page {String} 페이지 번호
 */
function searchScrap(page) {
    // 데이터를 검색한다.
    doSearch({
        url:"/portal/myPage/statUserScrapList.do",
        page:page ? page : "1",
        before:beforeSearchScrap,
        after:afterSearchScrap,
        pager:"scrap-pager-sect",
        counter:{
            count:"scrap-count-sect",
            pages:"scrap-pages-sect"
        }
    });
}

////////////////////////////////////////////////////////////////////////////////
// 전처리 함수
////////////////////////////////////////////////////////////////////////////////
/**
 *  통계스크랩 내용 검색 전처리를 실행한다.
 * 
 * @param options {Object} 옵션
 * @returns {Object} 데이터
 */
function beforeSearchScrap(options) {
    var data = {
        // Nothing do do.
    };
    
    var form = $("#scrap-search-form");
    
    if (com.wise.util.isBlank(options.page)) {
        form.find("[name=page]").val("1");
    }
    else {
        form.find("[name=page]").val(options.page);
    }
    
    return data;
}

////////////////////////////////////////////////////////////////////////////////
// 후처리 함수
////////////////////////////////////////////////////////////////////////////////
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
        var row = $(templates.data);
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
        
        // 통계스크랩 삭제 기능 구현
        row.find(".btn_scrap").off("click");	// 기 바인드 되어 있는 클릭 이벤트 제거
        row.find(".btn_scrap").bind("click", {
        	seqceNo : data[i].seqceNo
        }, function(event) {
        	if ( !confirm("삭제 하시겠습니까?") )	return false;
        	doAjax({
				url : "/portal/myPage/delStatUserScrap.do",
				params : {seqceNo : event.data.seqceNo},
				succUrl : "/portal/myPage/statUserScrapPage.do",
			});
        	
        });
        
        table.append(row);
    }
    
    if (data.length == 0) {
        var row = $(templates.none);
        
        table.append(row);
    }
}

