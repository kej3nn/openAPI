/*
 * @(#)searchGallery.js 1.0 2015/06/15
 * 
 * COPYRIGHT (C) 2013 WISEITECH CO., LTD. ALL RIGHTS RESERVED.
 */

/**
 * 갤러리 게시판 내용을 검색하는 스크립트이다.
 *
 * @author 김은삼
 * @version 1.0 2015/06/15
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

////////////////////////////////////////////////////////////////////////////////
// 글로벌 변수
////////////////////////////////////////////////////////////////////////////////
/**
 * 템플릿
 */
var templates = {
    data:
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
        "</li>",
    none:
        "<li class=\"noData\">해당 자료가 없습니다.</li>"
};

////////////////////////////////////////////////////////////////////////////////
// 초기화 함수
////////////////////////////////////////////////////////////////////////////////
/**
 * 컴포넌트를 초기화한다.
 */
function initComp() {
    var code = $("#gallery-search-form [name=listSubCd]").val();
    
    $(".gallery-section-tab[href='#" + code + "']").addClass("on");
    
    $("#gallery-searchtype-combo").val($("#gallery-search-form [name=searchType]").val());
    $("#gallery-searchword-field").val($("#gallery-search-form [name=searchWord]").val());
}

/**
 * 마스크를 바인딩한다.
 */
function bindMask() {
    // Nothing do do.
}

/**
 * 이벤트를 바인딩한다.
 */
function bindEvent() {
    $(".gallery-insert-button").each(function(index, element) {
        // 갤러리 게시판 내용 활용갤러리 등록 버튼에 클릭 이벤트를 바인딩한다.
        $(this).bind("click", function(event) {
            // 갤러리 게시판 내용을 등록한다.
            insertGallery();
            return false;
        });
        
        // 갤러리 게시판 내용 활용갤러리 등록 버튼에 키다운 이벤트를 바인딩한다.
        $(this).bind("keydown", function(event) {
            if (event.which == 13) {
                // 갤러리 게시판 내용을 등록한다.
                insertGallery();
                return false;
            }
        });
    });
    
    $(".gallery-section-tab").each(function(index, element) {
        // 갤러리 게시판 내용 섹션 탭에 클릭 이벤트를 바인딩한다.
        $(this).bind("click", function(event) {
            // 갤러리 게시판 내용 섹션을 변경한다.
            changeGallerySection(this);
            return false;
        });
        
        // 갤러리 게시판 내용 섹션 탭에 키다운 이벤트를 바인딩한다.
        $(this).bind("keydown", function(event) {
            if (event.which == 13) {
                // 갤러리 게시판 내용 섹션을 변경한다.
                changeGallerySection(this);
                return false;
            }
        });
    });
    
    // 갤러리 게시판 검색어 필드에 키다운 이벤트를 바인딩한다.
    $("#gallery-searchword-field").bind("keydown", function(event) {
        if (event.which == 13) {
            // 갤러리 게시판 검색어를 변경한다.
            changeGallerySearchWord();
            return false;
        }
    });
    
    // 갤러리 게시판 검색 버튼에 클릭 이벤트를 바인딩한다.
    $("#gallery-search-button").bind("click", function(event) {
        // 갤러리 게시판 검색어를 변경한다.
        changeGallerySearchWord();
        return false;
    });
    
    // 갤러리 게시판 검색 버튼에 키다운 이벤트를 바인딩한다.
    $("#gallery-search-button").bind("keydown", function(event) {
        if (event.which == 13) {
            // 갤러리 게시판 검색어를 변경한다.
            changeGallerySearchWord();
            return false;
        }
    });
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
    // 갤러리 게시판 내용을 검색한다.
    searchGallery($("#gallery-search-form [name=page]").val());
}

////////////////////////////////////////////////////////////////////////////////
// 서비스 함수
////////////////////////////////////////////////////////////////////////////////
/**
 * 갤러리 게시판 내용을 검색한다.
 * 
 * @param page {String} 페이지 번호
 */
function searchGallery(page) {
    // 데이터를 검색한다.
    doSearch({
        url:resolveUrl("/searchBulletin.do"),
        page:page ? page : "1",
        before:beforeSearchGallery,
        after:afterSearchGallery,
        pager:"gallery-pager-sect"
    });
}

/**
 * 갤러리 게시판 내용을 조회한다.
 * 
 * @param data {Object} 데이터
 */
function selectGallery(data) {
    // if (!verifyWriter(data.lockTag, "gallery-search-form", selectGallery, data)) {
    //     return;
    // }
    
    // 데이터를 조회하는 화면으로 이동한다.
    goSelect({
        url:resolveUrl("/selectBulletinPage.do"),
        form:"gallery-search-form",
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
 * 갤러리 게시판 내용을 등록한다.
 */
function insertGallery() {
    window.location.href = com.wise.help.url("/portal/myPage/insertUtilGalleryPage.do");
}

/**
 * 갤러리 게시판 내용 섹션을 변경한다.
 * 
 * @param tab {Element} 탭
 */
function changeGallerySection(tab) {
	$('#nowStatusNm').text("활용갤러리 " + $(tab).text() + " 목록");
    if (!$(tab).hasClass("on")) {
        $(".gallery-section-tab.on").removeClass("on");
        
        $(tab).addClass("on");
    }
    
    var code = $(tab).attr("href").substring(1);
    
    $("#gallery-search-form [name=listSubCd]").val(code);
    
    // 갤러리 게시판 내용을 검색한다.
    searchGallery();
}

/**
 * 갤러리 게시판 검색어를 변경한다.
 */
function changeGallerySearchWord() {
    $("#gallery-search-form [name=searchType]").val($("#gallery-searchtype-combo").val());
    $("#gallery-search-form [name=searchWord]").val($("#gallery-searchword-field").val());
    
    // 갤러리 게시판 내용을 검색한다.
    searchGallery();
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
 * URL을 반환한다.
 * 
 * @param url {String} URL
 */
function resolveUrl(url) {
    var matches = window.location.href.match(/\/portal\/[^\/]+\//);
    
    return matches[0] + $("#gallery-search-form [name=bbsCd]").val().toLowerCase() + url;
}

////////////////////////////////////////////////////////////////////////////////
// 전처리 함수
////////////////////////////////////////////////////////////////////////////////
/**
 *  갤러리 게시판 내용 검색 전처리를 실행한다.
 * 
 * @param options {Object} 옵션
 * @returns {Object} 데이터
 */
function beforeSearchGallery(options) {
    var data = {
        // Nothing do do.
    };
    
    var form = $("#gallery-search-form");
    
    if (com.wise.util.isBlank(options.page)) {
        form.find("[name=page]").val("1");
    }
    else {
        form.find("[name=page]").val(options.page);
    }
    
    $.each(form.serializeArray(), function(index, element) {
        switch (element.name) {
            case "seq":
            case "noticeYn":
                break;
            default:
                data[element.name] = element.value;
                break;
        }
    });
    
    if (com.wise.util.isBlank(data.bbsCd)) {
        return null;
    }
    
    return data;
}

////////////////////////////////////////////////////////////////////////////////
// 후처리 함수
////////////////////////////////////////////////////////////////////////////////
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
    
    for (var i = 0; i < data.length; i++) {
        var item = $(templates.data);
        
        if (data[i].fileSeq) {
            var url = com.wise.help.url(resolveUrl("/selectAttachFile.do")) + "?fileSeq=" + data[i].fileSeq;
            
            item.find(".fileSeq").html("<div><img src=\"" + url + "\" alt=\"" + data[i].bbsTit + " thumbnail" + "\" /></div>");
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
        var item = $(templates.none);
        
        list.append(item);
    }
}

////////////////////////////////////////////////////////////////////////////////
// 이벤트 함수
////////////////////////////////////////////////////////////////////////////////