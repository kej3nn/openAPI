/*
 * @(#)main.js 1.0 2015/06/15
 * 
 * COPYRIGHT (C) 2013 WISEITECH CO., LTD. ALL RIGHTS RESERVED.
 */

/**
 * 메인 화면 스크립트이다.
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
/*
 * 오늘
 */
var today = new Date();

/**
 * 템플릿
 */
var templates = {
    gallery:{
        data:
            "<li>"                                                                 +
                "<div class=\"area_thumbnail_gallery\">"                           +
                    "<a href=\"#none\" class=\"thumbnail_gallery\">"                            +
                        "<img src=\"\" alt=\"\" class=\"gallery-others-image\" />" +
                    "</a>"                                                       +
                "</div>"                                                           +
                "<div class=\"area_thumbnail_gallery_safari\">"                    +
                    "<a href=\"#none\"  class=\"safari\"></a>"                                 +
                    "<img src=\"\" alt=\"\" class=\"gallery-safari-image\" />"     +
                "</div>"                                                           +
                "<span class=\"area_link\" style=\"display:none;\">"               +
                    "<a href=\"#\" class=\"link\">"                                +
                        "<strong class=\"tit bbsTit\"></strong>"                   +
                        "<span class=\"summary bbsCont\"></span>"                  +
                    "</a>"                                                         +
                "</span>"                                                          +
            "</li>",
        none:
            "<li class=\"noData\">해당 자료가 없습니다.</li>"
    },
    notice:{
        data:
            "<li><a href=\"#\" class=\"bbsTit\"></a></li>",
        none:
            "<li class=\"noData\">해당 자료가 없습니다.</li>"
    },
    dataset:{
        data:
            "<li><img src=\"\" alt=\"\" /><a href=\"#\" class=\"infNm\"></a></li>",
        none:
            "<li class=\"noData\">해당 자료가 없습니다.</li>"
    },
    recommend:{
        data:
            "<span class=\"area_link\">"                                 +
                "<a href=\"#\" class=\"link\">"                          +
                    "<span class=\"sort_B cateId\"><span></span></span>" +
                    "<span class=\"area_summary\">"                      +
                        "<strong class=\"tit infNm\"></strong>"          +
                        "<span class=\"summary infExp\"></span>"         +
                    "</span>"                                            +
                "</a>"                                                   +
            "</span>",
        none:
            "<li class=\"noData\">해당 자료가 없습니다.</li>"
    }
};

/**
 * 슬라이더
 */
var sliders = {
    gallery:null,
    notice:null,
    dataset:null
};

////////////////////////////////////////////////////////////////////////////////
// 초기화 함수
////////////////////////////////////////////////////////////////////////////////
/**
 * 컴포넌트를 초기화한다.
 */
function initComp() {
    // Nothing to do.
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
    $(window).bind("resize", function(event) {
        // 슬라이더를 리로드한다.
        reloadSliders();
    });
    
    $(".dataset-category-button").each(function(index, element) {
        // 공공데이터 데이터셋 카테고리 버튼에 클릭 이벤트를 바인딩한다.
        $(this).bind("click", function(event) {
            // 공공데이터 데이터셋 카테고리를 변경한다.
            changeDatasetCategory($(this).attr("href").substring(1));
            return false;
        });
        
        // 공공데이터 데이터셋 카테고리 버튼에 키다운 이벤트를 바인딩한다.
        $(this).bind("keydown", function(event) {
            if (event.which == 13) {
                // 공공데이터 데이터셋 카테고리를 변경한다.
                changeDatasetCategory($(this).attr("href").substring(1));
                return false;
            }
            
        });
    });
    
    // 갤러리 게시판 이전 버튼에 클릭 이벤트를 바인딩한다.
    $("#gallery-previous-button").bind("click", function(event) {
        // 갤러리 게시판을 이동한다.
        moveGallery("previous");
        return false;
    });
    
    // 갤러리 게시판 이전 버튼에 키다운 이벤트를 바인딩한다.
    $("#gallery-previous-button").bind("keydown", function(event) {
        if (event.which == 13) {
            // 갤러리 게시판을 이동한다.
            moveGallery("previous");
            return false;
        }
    });
    
    // 갤러리 게시판 다음 버튼에 클릭 이벤트를 바인딩한다.
    $("#gallery-next-button").bind("click", function(event) {
        // 갤러리 게시판을 이동한다.
        moveGallery("next");
        return false;
    });
    
    // 갤러리 게시판 다음 버튼에 키다운 이벤트를 바인딩한다.
    $("#gallery-next-button").bind("keydown", function(event) {
        if (event.which == 13) {
            // 갤러리 게시판을 이동한다.
            moveGallery("next");
            return false;
        }
    });
    
    // 갤러리 게시판 플레이 버튼에 클릭 이벤트를 바인딩
    $('#gallery-play-button').bind("click", function(event) {
        moveGallery("play");
    	return false;
    });
    
    // 겔러리 게시판 플레이 버튼에 키다운 이벤트를 바인딩
    $('#gallery-play-button').bind("keydown", function(event) {
        if (event.which == 13) {
            moveGallery("play");
            return false;
        }
    });

    // 갤러리 게시판 플레이 버튼에 클릭 이벤트를 바인딩
    $('#gallery-stop-button').bind("click", function(event) {
        moveGallery("stop");
    	return false;
    });
    
    // 겔러리 게시판 플레이 버튼에 키다운 이벤트를 바인딩
    $('#gallery-stop-button').bind("keydown", function(event) {
        if (event.which == 13) {
            moveGallery("stop");
            return false;
        }
    });
    
    // 공지사항 게시판 이전 버튼에 클릭 이벤트를 바인딩한다.
    $("#notice-previous-button").bind("click", function(event) {
        // 공지사항 게시판을 이동한다.
        moveNotice("previous");
        return false;
    });
    
    // 공지사항 게시판 이전 버튼에 키다운 이벤트를 바인딩한다.
    $("#notice-previous-button").bind("keydown", function(event) {
        if (event.which == 13) {
            // 공지사항 게시판을 이동한다.
            moveNotice("previous");
            return false;
        }
    });
    
    // 공지사항 게시판 다음 버튼에 클릭 이벤트를 바인딩한다.
    $("#notice-next-button").bind("click", function(event) {
        // 공지사항 게시판을 이동한다.
        moveNotice("next");
        return false;
    });
    
    // 공지사항 게시판 다음 버튼에 키다운 이벤트를 바인딩한다.
    $("#notice-next-button").bind("keydown", function(event) {
        if (event.which == 13) {
            // 공지사항 게시판을 이동한다.
            moveNotice("next");
            return false;
        }
    });
    
    // 공공데이터 데이터셋 이전 버튼에 클릭 이벤트를 바인딩한다.
    $("#dataset-previous-button").bind("click", function(event) {
        // 공공데이터 데이터셋을 이동한다.
        moveDataset("previous");
        return false;
    });
    
    // 공공데이터 데이터셋 이전 버튼에 키다운 이벤트를 바인딩한다.
    $("#dataset-previous-button").bind("keydown", function(event) {
        if (event.which == 13) {
            // 공공데이터 데이터셋을 이동한다.
            moveDataset("previous");
            return false;
        }
    });
    
    // 공공데이터 데이터셋 다음 버튼에 클릭 이벤트를 바인딩한다.
    $("#dataset-next-button").bind("click", function(event) {
        // 공공데이터 데이터셋을 이동한다.
        moveDataset("next");
        return false;
    });
    
    // 공공데이터 데이터셋 다음 버튼에 키다운 이벤트를 바인딩한다.
    $("#dataset-next-button").bind("keydown", function(event) {
        if (event.which == 13) {
            // 공공데이터 데이터셋을 이동한다.
            moveDataset("next");
            return false;
        }
    });
    //  공공데이터 데이터셋  플레이 버튼에 클릭 이벤트를 바인딩
    $('#dataset-play-button').bind("click", function(event) {
    	moveDataset("play");
    	return false;
    });
    
    //  공공데이터 데이터셋 플레이 버튼에 키다운 이벤트를 바인딩
    $('#dataset-play-button').bind("keydown", function(event) {
        if (event.which == 13) {
        	moveDataset("play");
            return false;
        }
    });

    //  공공데이터 데이터셋 플레이 버튼에 클릭 이벤트를 바인딩
    $('#dataset-stop-button').bind("click", function(event) {
    	moveDataset("stop");
    	return false;
    });
    
    //  공공데이터 데이터셋 플레이 버튼에 키다운 이벤트를 바인딩
    $('#dataset-stop-button').bind("keydown", function(event) {
        if (event.which == 13) {
        	moveDataset("stop");
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
    searchGallery();
    
    // // 공지 게시판 내용을 검색한다.
    // searchNotice("popular");
    
    // 공지 게시판 내용을 검색한다.
    searchNotice("current");
    
    // 공공데이터 데이터셋을 검색한다.
    searchDataset("weekly");

    // 공공데이터 데이터셋을 검색한다.
    searchDataset("monthly");
    
    // 공공데이터 데이터셋을 검색한다.
    //searchDataset("recommend");
}

////////////////////////////////////////////////////////////////////////////////
// 서비스 함수
////////////////////////////////////////////////////////////////////////////////
/**
 * 갤러리 게시판 내용을 검색한다.
 */
function searchGallery() {
    // 데이터를 검색한다.
    doSearch({
        url:"/portal/bbs/gallery/searchBulletin.do",
        before:beforeSearchGallery,
        after:afterSearchGallery
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
        url:"/portal/bbs/gallery/selectBulletinPage.do",
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
 * 갤러리 게시판을 이동한다.
 * 
 * @param direction {String} 방향
 */
function moveGallery(direction) {
    if (sliders.gallery) {
        switch (direction) {
            case "previous":
                sliders.gallery.goToPrevSlide();
                break;
            case "next":
                sliders.gallery.goToNextSlide();
                break;
            case "play":
            	sliders.gallery.startAuto();
            	break;
            case "stop":
            	sliders.gallery.stopAuto();
            	break;
        }
    }
}

/**
 * 갤러리 게시판 내용을 보인다.
 *
 * @param element {Element} 엘레멘트
 */
function showGallery(element) {
    if ($(element).hasClass("gallery-others-image")) {
        $(element).parent("div").parent("div").parent("li").find("span.area_link").show();
    }
    else if ($(element).hasClass("gallery-safari-image")) {
        $(element).parent("div").parent("li").find("span.area_link").show();
    }
    else if ($(element).hasClass("area_link")) {
        $(element).show();
    }
}

/**
 * 갤러리 게시판 내용을 숨긴다.
 *
 * @param element {Element} 엘레멘트
 */
function hideGallery(element) {
    if ($(element).hasClass("gallery-others-image")) {
        $(element).parent("div").parent("div").parent("li").find("span.area_link").hide();
    }
    else if ($(element).hasClass("gallery-safari-image")) {
        $(element).parent("div").parent("li").find("span.area_link").hide();
    }
    else if ($(element).hasClass("area_link")) {
        $(element).hide();
    }
}

/**
 * 공지 게시판 내용을 검색한다.
 * 
 * @param mode {String} 모드
 */
function searchNotice(mode) {
    switch (mode) {
        // case "popular":
        //     // 데이터를 검색한다.
        //     doSearch({
        //         url:"/portal/bbs/notice/searchBulletin.do",
        //         before:beforeSearchPopular,
        //         after:afterSearchPopular
        //     });
        //     break;
        case "current":
            // 데이터를 검색한다.
            doSearch({
                url:"/portal/bbs/notice/searchBulletin.do",
                before:beforeSearchCurrent,
                after:afterSearchCurrent
            });
            break;
    }
}

/**
 * 공지 게시판 내용을 조회한다.
 * 
 * @param data {Object} 데이터
 */
function selectNotice(data) {
    // if (!verifyWriter(data.lockTag, "notice-search-form", selectNotice, data)) {
    //     return;
    // }
    
    // 데이터를 조회하는 화면으로 이동한다.
    goSelect({
        url:"/portal/bbs/notice/selectBulletinPage.do",
        form:"notice-search-form",
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
 * 공지사항 게시판을 이동한다.
 * 
 * @param direction {String} 방향
 */
function moveNotice(direction) {
    if (sliders.notice) {
        switch (direction) {
            case "previous":
                sliders.notice.goToPrevSlide();
                break;
            case "next":
                sliders.notice.goToNextSlide();
                break;
        }
    }
}

/**
 * 공공데이터 데이터셋을 검색한다.
 * 
 * @param mode {String} 모드
 */
function searchDataset(mode) {
    switch (mode) {
        case "category":
            // 데이터를 검색하는 화면으로 이동한다.
            goSearch({
                url:"/portal/data/dataset/searchDatasetPage.do",
                form:"dataset-search-form",
                data:[{
                    name:"cateId",
                    value:$(".dataset-category-button.on").attr("href").substring(1)
                }]
            });
            break;
        case "weekly":
            // 데이터를 검색한다.
            doSearch({
                url:"/portal/data/dataset/searchWeekly.do",
                before:beforeSearchWeekly,
                after:afterSearchWeekly
            });
            break;
        case "monthly":
            // 데이터를 검색한다.
            doSearch({
                url:"/portal/data/dataset/searchMonthly.do",
                before:beforeSearchMonthly,
                after:afterSearchMonthly
            });
            break;
        case "recommend":
            // 데이터를 검색한다.
            doSearch({
                url:"/portal/data/dataset/searchRecommend.do",
                before:beforeSearchRecommend,
                after:afterSearchRecommend
            });
            break;
    }
}

/**
 * 공공데이터 서비스를 조회한다.
 * 
 * @param data {Object} 데이터
 */
function selectService(data) {
    $("#dataset-search-form [name=cateId]").attr("disabled", "disabled");
    
    // 데이터를 조회하는 화면으로 이동한다.
    goSelect({
        url:"/portal/data/service/selectServicePage.do",
        form:"dataset-search-form",
        data:[{
            name:"infId",
            value:data.infId
        }, {
            name:"infSeq",
            value:data.infSeq
        }]
    });
}

/**
 * 공공데이터 데이터셋을 이동한다.
 * 
 * @param direction {String} 방향
 */
function moveDataset(direction) {
    if (sliders.dataset) {
        switch (direction) {
            case "previous":
                sliders.dataset.goToPrevSlide();
                break;
            case "next":
                sliders.dataset.goToNextSlide();
                break;
            case "play":
                sliders.dataset.startAuto();
            	break;
            case "stop":
                sliders.dataset.stopAuto();
            	break;
        }
    }
}

/**
 * 공공데이터 데이터셋 카테고리를 변경한다.
 * 
 * @param code {String} 코드
 */
function changeDatasetCategory(code) {
    $(".dataset-category-button.on").each(function(index, element) {
        $(this).removeClass("on");
    });
    
    $(".dataset-category-button[href='#" + code + "']").addClass("on");
    
    // 공공데이터 데이터셋을 검색한다.
    searchDataset("category");
}

/**
 * 공공데이터 데이터셋 카테고리 클래스를 반환한다.
 * 
 * @param code {String} 코드
 * @returns {String} 경로
 */
function getCategoryClass(code) {
    var clazz = "";
    
    switch (code) {
        case "GG02":
            clazz = "sort_B_1_1";
            break;
        case "GG03":
            clazz = "sort_B_1_2";
            break;
        case "GG04":
            clazz = "sort_B_1_3";
            break;
        case "GG06":
            clazz = "sort_B_2_1";
            break;
        case "GG07":
            clazz = "sort_B_2_2";
            break;
        case "GG08":
            clazz = "sort_B_2_3";
            break;
        case "GG10":
            clazz = "sort_B_3_1";
            break;
        case "GG11":
            clazz = "sort_B_3_2";
            break;
        case "GG12":
            clazz = "sort_B_3_3";
            break;
        case "GG14":
            clazz = "sort_B_4_1";
            break;
        case "GG15":
            clazz = "sort_B_4_2";
            break;
        case "GG17":
            clazz = "sort_B_5_1";
            break;
        case "GG18":
            clazz = "sort_B_5_2";
            break;
        case "GG19":
            clazz = "sort_B_5_3";
            break;
        case "GG21":
            clazz = "sort_B_6_1";
            break;
        case "GG22":
            clazz = "sort_B_6_2";
            break;
        case "GG24":
            clazz = "sort_B_7_1";
            break;
        case "GG25":
            clazz = "sort_B_7_2";
            break;
        case "GG27":
            clazz = "sort_B_8_1";
            break;
        case "GG28":
            clazz = "sort_B_8_2";
            break;
        case "GG30":
            clazz = "sort_B_9_1";
            break;
        case "GG31":
            clazz = "sort_B_9_2";
            break;
        case "GG32":
            clazz = "sort_B_9_3";
            break;
    }
    
    return clazz;
}

/**
 * 슬라이더를 리로드한다.
 */
function reloadSliders() {
    for (var key in sliders) {
        var slider = sliders[key];
        
        if (slider) {
            slider.reloadSlider();
        }
    }
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
        page:"1",
        rows:"10"
    };
    
    return data;
}

/**
 *  최근 공지 게시판 내용 검색 전처리를 실행한다.
 * 
 * @param options {Object} 옵션
 * @returns {Object} 데이터
 */
function beforeSearchCurrent(options) {
    var data = {
        page:"1",
        rows:"10"
    };
    
    return data;
}

/**
 * 공공데이터 데이터셋 주간순위 검색 전처리를 실행한다.
 * 
 * @param options {Object} 옵션
 * @returns {Object} 데이터
 */
function beforeSearchWeekly(options) {
    var data = {
        term:"W"
    };
    
    return data;
}

/**
 * 공공데이터 데이터셋 월간순위 검색 전처리를 실행한다.
 * 
 * @param options {Object} 옵션
 * @returns {Object} 데이터
 */
function beforeSearchMonthly(options) {
    var data = {
        term:"M"
    };
    
    return data;
}

/**
 * 공공데이터 데이터셋 추천순위 검색 전처리를 실행한다.
 * 
 * @param options {Object} 옵션
 * @returns {Object} 데이터
 */
function beforeSearchRecommend(options) {
    var data = {
        // Nothing to do.
    };
    
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
        var item = $(templates.gallery.data);
        
        var url = com.wise.help.url("bbs/gallery/selectAttachFile.html") + "?fileSeq=" + data[i].fileSeq;
        
        item.find("img").each(function(index, element) {
            $(this).attr("src", url).attr("alt", data[i].bbsTit);
        });
        
        item.find(".bbsTit").text(data[i].bbsTit);
        item.find(".bbsCont").html(data[i].bbsCont);
        
        // 갤러리 게시판 내용 썸네일 링크에 클릭 이벤트를 바인딩한다.
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
        
        // 갤러리 게시판 내용 썸네일 링크에 키다운 이벤트를 바인딩한다.
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
        var item = $(templates.gallery.none);
        
        list.append(item);
    }
    else {
        sliders.gallery = $("#gallery-data-list").bxSlider({
            pager:false,
            controls:false,
            auto:true,
            autoHover:true
        });
        
        list.find("li").each(function(index, element) {
            var item = $(this);
            
            var id = "gallery_summary_" + (index + 1);
            
            item.find("span.area_link").attr("id", id);
            
            item.find("img").each(function(index, element) {
                $(this).bind("mouseover", {
                    id:id
                }, function(event) {
                    // ovr_gallery_summary(event.data.id);
                    showGallery(this);
                });
            });
            
            item.find("img").each(function(index, element) {
                $(this).bind("mouseout", {
                    id:id
                }, function(event) {
                    // out_gallery_summary(event.data.id);
                    hideGallery(this);
                });
            });
            
            item.find("span.area_link").bind("mouseover", {
                id:id
            }, function(event) {
                // ovr_gallery_summary(event.data.id);
                showGallery(this);
            });
            
            item.find("span.area_link").bind("mouseout", {
                id:id
            }, function(event) {
                // out_gallery_summary(event.data.id);
                hideGallery(this);
            });
        });
    }
}

// /**
//  * 인기 공지 게시판 내용 검색 후처리를 실행한다.
//  * 
//  * @param data {Array} 데이터
//  */
// function afterSearchPopular(data) {
//     var list = $(".notice-popular-list");
//     
//     list.find("li").each(function(index, element) {
//         $(this).remove();
//     });
//     
//     for (var i = 0; i < data.length; i++) {
//         var item = $(templates.notice.data);
//         
//         if (data[i].noticeYn == "Y") {
//             continue;
//         }
//         
//         item.find(".bbsTit").text(data[i].bbsTit);
//         
//         // 공지 게시판 내용 제목 링크에 클릭 이벤트를 바인딩한다.
//         item.find("a").bind("click", {
//             bbsCd:data[i].bbsCd,
//             seq:data[i].seq,
//             noticeYn:data[i].noticeYn,
//             lockTag:data[i].lockTag
//         }, function(event) {
//             // 공지 게시판 내용을 조회한다.
//             selectNotice(event.data);
//             return false;
//         });
//         
//         // 공지 게시판 내용 제목 링크에 키다운 이벤트를 바인딩한다.
//         item.find("a").bind("keydown", {
//             bbsCd:data[i].bbsCd,
//             seq:data[i].seq,
//             noticeYn:data[i].noticeYn,
//             lockTag:data[i].lockTag
//         }, function(event) {
//             if (event.which == 13) {
//                 // 공지 게시판 내용을 조회한다.
//                 selectNotice(event.data);
//                 return false;
//             }
//         });
//         
//         list.append(item);
//     }
//     
//     if (data.length == 0) {
//         var item = $(templates.notice.none);
//         
//         list.append(item);
//     }
// }

/**
 * 최근 공지 게시판 내용 검색 후처리를 실행한다.
 * 
 * @param data {Array} 데이터
 */
function afterSearchCurrent(data) {
    var noticeCount = 0;
    
    $(".notice-current-list").each(function(index, element) {
        var list = $(this);
        
        list.find("li").each(function(index, element) {
            $(this).remove();
        });
        
        var count = 0;
        
        for (var i = 0; i < data.length; i++) {
            if (index == 0 && count >= 3) {
                continue;
            }
            if (index == 1 && count >= 8 - noticeCount) {
                continue;
            }
            
            if (index == 0 && data[i].noticeYn != "Y") {
                continue;
            }
            if (index == 1 && data[i].noticeYn == "Y") {
                continue;
            }
            
            var item = $(templates.notice.data);
            
            item.find(".bbsTit").text(data[i].bbsTit);
            
            // 공지 게시판 내용 제목 링크에 클릭 이벤트를 바인딩한다.
            item.find("a").bind("click", {
                bbsCd:data[i].bbsCd,
                seq:data[i].seq,
                noticeYn:data[i].noticeYn,
                lockTag:data[i].lockTag
            }, function(event) {
                // 공지 게시판 내용을 조회한다.
                selectNotice(event.data);
                return false;
            });
            
            // 공지 게시판 내용 제목 링크에 키다운 이벤트를 바인딩한다.
            item.find("a").bind("keydown", {
                bbsCd:data[i].bbsCd,
                seq:data[i].seq,
                noticeYn:data[i].noticeYn,
                lockTag:data[i].lockTag
            }, function(event) {
                if (event.which == 13) {
                    // 공지 게시판 내용을 조회한다.
                    selectNotice(event.data);
                    return false;
                }
            });
            
            list.append(item);
            
            count++;
        }
        
        if (data.length == 0) {
            var item = $(templates.notice.none);
            
            list.append(item);
        }
        else {
            if (index == 2) {
                sliders.notice = $(this).bxSlider({
                    mode:"vertical",
                    pager:false,
                    controls:false,
                    auto:true,
                    autoHover:true
                });
            }
        }
        
        if (i == 0) {
            noticeCount = count;
        }
    });
}

/**
 * 공공데이터 데이터셋 주간순위 검색 후처리를 실행한다.
 * 
 * @param data {Array} 데이터
 */
function afterSearchWeekly(data) {
    var list = $(".dataset-weekly-list");
    
    list.find("li").each(function(index, element) {
        $(this).remove();
    });
    
    for (var i = 0, n = 1; i < data.length; i++, n++) {
        var item = $(templates.dataset.data);
        
        item.find("img").attr("src", com.wise.help.url("/img/ggportal/desktop/common/txt_num_" + n + ".png")).attr("alt", n);
        
        if (i < 3) {
            item.find(".infNm").html("<strong>" + data[i].infNm + "</strong>");
        }
        else {
            item.find(".infNm").text(data[i].infNm);
        }
        
        // 공공데이터 데이터셋 제목 링크에 클릭 이벤트를 바인딩한다.
        item.find("a").bind("click", {
            infId:data[i].infId,
            infSeq:data[i].infSeq
        }, function(event) {
            // 공공데이터 서비스를 조회한다.
            selectService(event.data);
            return false;
        });
        
        // 공공데이터 데이터셋 제목 링크에 키다운 이벤트를 바인딩한다.
        item.find("a").bind("keydown", {
            infId:data[i].infId,
            infSeq:data[i].infSeq
        }, function(event) {
            if (event.which == 13) {
                // 공공데이터 서비스를 조회한다.
                selectService(event.data);
                return false;
            }
        });
        
        list.append(item);
    }
    
    if (data.length == 0) {
        var item = $(templates.dataset.none);
        
        list.append(item);
    }
    windowResize();
}

/**
 * 공공데이터 데이터셋 월간순위 검색 후처리를 실행한다.
 * 
 * @param data {Array} 데이터
 */
function afterSearchMonthly(data) {
    var list = $(".dataset-monthly-list");
    
    list.find("li").each(function(index, element) {
        $(this).remove();
    });
    
    for (var i = 0, n = 1; i < data.length; i++, n++) {
        var item = $(templates.dataset.data);
        
        item.find("img").attr("src", com.wise.help.url("/img/ggportal/desktop/common/txt_num_" + n + ".png")).attr("alt", n);
        
        if (i < 3) {
            item.find(".infNm").html("<strong>" + data[i].infNm + "</strong>");
        }
        else {
            item.find(".infNm").text(data[i].infNm);
        }
        
        // 공공데이터 데이터셋 제목 링크에 클릭 이벤트를 바인딩한다.
        item.find("a").bind("click", {
            infId:data[i].infId,
            infSeq:data[i].infSeq
        }, function(event) {
            // 공공데이터 서비스를 조회한다.
            selectService(event.data);
            return false;
        });
        
        // 공공데이터 데이터셋 제목 링크에 키다운 이벤트를 바인딩한다.
        item.find("a").bind("keydown", {
            infId:data[i].infId,
            infSeq:data[i].infSeq
        }, function(event) {
            if (event.which == 13) {
                // 공공데이터 서비스를 조회한다.
                selectService(event.data);
                return false;
            }
        });
        
        list.append(item);
    }
    
    if (data.length == 0) {
        var item = $(templates.dataset.none);
        
        list.append(item);
    }
	windowResize();
}

/**
 * 공공데이터 데이터셋 추천순위 검색 후처리를 실행한다.
 * 
 * @param data {Array} 데이터
 */
function afterSearchRecommend(data) {
    var list = $("#dataset-recommend-list");
    
    list.find("li").each(function(index, element) {
        $(this).remove();
    });
    
    var item = null;
    
    for (var i = 0; i < data.length; i++) {
        if (item == null || item.find("span.area_link").length == 2) {
            item = $("<li></li>");
        }
        
        var sect = $(templates.recommend.data);
        
        sect.find(".cateId").addClass(getCategoryClass(data[i].cateId));
        sect.find(".infNm").text(data[i].infNm);
        sect.find(".infExp").text(data[i].infExp ? data[i].infExp : "");
        
        // 공공데이터 데이터셋 링크에 클릭 이벤트를 바인딩한다.
        sect.find("a").bind("click", {
            infId:data[i].infId,
            infSeq:data[i].infSeq
        }, function(event) {
            // 공공데이터 서비스를 조회한다.
            selectService(event.data);
            return false;
        });
        
        // 공공데이터 데이터셋 링크에 키다운 이벤트를 바인딩한다.
        sect.find("a").bind("keydown", {
            infId:data[i].infId,
            infSeq:data[i].infSeq
        }, function(event) {
            if (event.which == 13) {
                // 공공데이터 서비스를 조회한다.
                selectService(event.data);
                return false;
            }
        });
        
        item.append(sect);
        
        if (item.find("span.area_link").length == 2 || i == data.length - 1) {
            list.append(item);
        }
    }
    
    if (data.length == 0) {
        var item = $("<li></li>");
        
        var sect = $(templates.recommend.none);
        
        item.append(sect);
        
        list.append(item);
    }
    else {
        sliders.dataset = $("#dataset-recommend-list").bxSlider({
            pager:false,
            controls:false,
            auto:true,
            autoHover:true
        });
    }
}

////////////////////////////////////////////////////////////////////////////////
// 이벤트 함수
////////////////////////////////////////////////////////////////////////////////

function windowResize() {
	var width = $(window).width();
	var bestData_main = $('.bestData_main');
	if(width <= 767) {
		$.each(bestData_main, function() {
			var li = $(this).find("li");
			$.each(li, function(i, d) {
				if(i >= 5) {
					$(this).hide();
				}
			});
		});
	} else {
		$.each(bestData_main, function() {
			$(this).find("li").show();
		});
	}
}

$(document).ready(function() {
	// ie8에서 창 슬라이더 문제
	setTimeout(reloadSliders, 1500);
	
	// 인기데이터 모바일 화면 높이 설정
	$(window).resize(function() {
		windowResize();
	});
});