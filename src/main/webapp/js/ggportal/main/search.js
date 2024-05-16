/*
 * @(#)search.js 1.0 2015/06/15
 * 
 * COPYRIGHT (C) 2013 WISEITECH CO., LTD. ALL RIGHTS RESERVED.
 */

/**
 * 통합 검색 스크립트이다.
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
    dataset:{
        data:
            "<tr>"                                                                                                             +
                "<td class=\"area_summary\">"                                                                                  +
                    "<a href=\"#\" class=\"link dataset-select-link\">"                                                        +
                        "<figure class=\"thumbnail\">"                                                                         +
                            "<figcaption>해당 서비스에 대한 thumbnail</figcaption>"                                            +
                            "<img src=\"\" alt=\"\" class=\"thumbnail_dataSet metaImagFileNm\" />"                             +
                        "</figure>"                                                                                            +
                        "<span class=\"summary\">"                                                                             +
                            "<strong class=\"tit ellipsis W300 infNm\"></strong>"                                              +
                            "<span class=\"cont infExp\"></span>"                                                              +
                        "</span>"                                                                                              +
                    "</a>"                                                                                                     +
                    "<strong class=\"btn_detail mq_mobile\"><a href=\"#\" class=\"dataset-select-link\">상세보기</a></strong>" +
                "</td>"                                                                                                        +
                "<td>"                                                                                                         +
                    "<span class=\"area_txt_A\">"                                                                              +
                    "</span>"                                                                                                  +
                "</td>"                                                                                                        +
                "<td><strong class=\"mq_tablet viewCnt\"></strong></td>"                                                       +
                "<td><span class=\"date regDttm\"></span><br><span class=\"date updDttm\"></span></td>"                                                                +
                "<td><span class=\"sort dataset-category-sect\"><strong class=\"topCateNm\"></strong></span></td>"             +
            "</tr>",
        none:
            "<tr>"                                                              +
                "<td colspan=\"5\" class=\"noData\">해당 자료가 없습니다.</td>" +
            "</tr>"
    },
    stat : {
    	data:
            "<tr>"                                                                                                             +
	            "<td class=\"area_tit\">"                                                        +
		            "<a href=\"#\" class=\"link tit ellipsis w_400 statblNm\"></a>"                +
		            "<strong class=\"btn_detail mq_mobile\"><a href=\"#\">상세보기</a></strong>" +
		        "</td>"                                                                          +
		        "<td><span class=\"date openDttm\"></span></td>"  +
		        "<td><span class=\"writer orgNm\"></span></td>"                                 +
            "</tr>",
        none:
            "<tr>"                                                              +
                "<td colspan=\"5\" class=\"noData\">해당 자료가 없습니다.</td>" +
            "</tr>"
    },
    village:{
        data:
            "<tr>"                                                                                                             +
                "<td class=\"area_summary\">"                                                                                  +
                    "<a href=\"#\" class=\"link village-select-link\">"                                                        +
                        "<figure class=\"thumbnail\">"                                                                         +
                            "<figcaption>해당 서비스에 대한 thumbnail</figcaption>"                                            +
                            "<img src=\"\" alt=\"\" class=\"thumbnail_dataSet metaImagFileNm\" />"                             +
                        "</figure>"                                                                                            +
                        "<span class=\"summary\">"                                                                             +
                            "<strong class=\"tit ellipsis W300 infNm\"></strong>"                                              +
                            "<span class=\"cont infExp\"></span>"                                                              +
                        "</span>"                                                                                              +
                    "</a>"                                                                                                     +
                    "<strong class=\"btn_detail mq_mobile\"><a href=\"#\" class=\"village-select-link\">상세보기</a></strong>" +
                "</td>"                                                                                                        +
                "<td>"                                                                                                         +
                    "<span class=\"area_txt_A\">"                                                                              +
                    "</span>"                                                                                                  +
                "</td>"                                                                                                        +
                "<td><strong class=\"mq_tablet viewCnt\"></strong></td>"                                                       +
                "<td><span class=\"date regDttm\"></span></td>"                                                                +
                "<td><span class=\"sort village-category-sect\"><strong class=\"topCateNm\"></strong></span></td>"             +
            "</tr>",
        none:
            "<tr>"                                                              +
                "<td colspan=\"5\" class=\"noData\">해당 자료가 없습니다.</td>" +
            "</tr>"
    },
    catalog:{
        data:
            "<tr>"                                                                                                             +
                "<td class=\"area_summary w_2\">"                                                                              +
                    "<a href=\"#\" class=\"link catalog-select-link\">"                                                        +
                        "<span class=\"summary\">"                                                                             +
                            "<strong class=\"tit ellipsis W300 ctlgNm\"></strong>"                                             +
                            "<span class=\"cont ctlgDesc\"></span>"                                                            +
                        "</span>"                                                                                              +
                    "</a>"                                                                                                     +
                    "<strong class=\"btn_detail mq_mobile\"><a href=\"#\" class=\"catalog-select-link\">상세보기</a></strong>" +
                "</td>"                                                                                                        +
                "<td><span class=\"supply orgNm\"></span></td>"                                                                +
                "<td>"                                                                                                         +
                    "<span class=\"area_txt_A\">"                                                                              +
                    "</span>"                                                                                                  +
                "</td>"                                                                                                        +
                "<td><strong class=\"mq_tablet viewCnt\"></strong></td>"                                                       +
                "<td><span class=\"date regDttm\"></span></td>"                                                                +
                "<td><span class=\"txt_sort cateNm\"></span></td>"                                                             +
            "</tr>",
        none:
            "<tr>"                                                              +
                "<td colspan=\"6\" class=\"noData\">해당 자료가 없습니다.</td>" +
            "</tr>"
    },
    multimedia:{
        data:
            "<tr>"                                                                                                                                                +
                "<td class=\"area_summary w_1\">"                                                                                                                 +
                    "<a href=\"#\" class=\"link\">"                                                                                                               +
                        "<figure class=\"thumbnail\">"                                                                                                            +
                            "<figcaption>해당 서비스에 대한 thumbnail</figcaption>"                                                                               +
                            "<img src=\"" + com.wise.help.url("/img/ggportal/desktop/thumbnail/@thumbnail_180_100.jpg") + "\"  alt=\"\" class=\"tmnlImgFile\" />" +
                            "<span class=\"time hide\">00:00</span>"                                                                                              +
                        "</figure>"                                                                                                                               +
                    "</a>"                                                                                                                                        +
                    "<span class=\"summary\">"                                                                                                                    +
                        "<a href=\"#\" class=\"link\">"                                                                                                           +
                            "<strong class=\"tit ellipsis infNm\"></strong>"                                                                                      +
                            "<span class=\"cont infExp\"></span>"                                                                                                 +
                        "</a>"                                                                                                                                    +
                        "<span class=\"date regDttm\"></span>"                                                                                                    +
                        "<span class=\"clickNum viewCnt\"></span>"                                                                                                +
                    "</span>"                                                                                                                                     +
                    "<strong class=\"btn_detail mq_mobile\"><a href=\"#\">상세보기</a></strong>"                                                                  +
                "</td>"                                                                                                                                           +
            "</tr>",
        none:
            "<tr>"                                                +
                "<td class=\"noData\">해당 자료가 없습니다.</td>" +
            "</tr>"
    },
    gallery:{
        data:
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
            "</li>",
        none:
            "<li class=\"noData\">해당 자료가 없습니다.</li>"
    },
    develop:{
        data:
            // "<tr>"                                                                                                                                                           +
            //     "<td><span class=\"mq_tablet rowNum\"></span></td>"                                                                                                          +
            //     "<td class=\"area_tit\">"                                                                                                                                    +
            //         "<a href=\"#\" class=\"link tit ellipsis w_400 bbsTit\"></a>"                                                                                            +
            //         "<strong class=\"btn_detail mq_mobile\"><a href=\"#\">상세보기</a></strong>"                                                                             +
            //     "</td>"                                                                                                                                                      +
            //     "<td><span class=\"writer userNm\"></span></td>"                                                                                                             +
            //     "<td><span class=\"date userDttm\"></span></td>"                                                                                                             +
            //     "<td><span class=\"mq_tablet viewCnt\"></span></td>"                                                                                                         +
            //     "<td><span class=\"reply ansCnt\"><img src=\"" + com.wise.help.url("/img/ggportal/desktop/common/icon_reply.png") + "\" alt=\"\" /></span></td>"             +
            //     "<td><span class=\"recommendation\"><img src=\"" + com.wise.help.url("/img/ggportal/desktop/common/icon_recommendation.png") + "\" alt=\"\" />0</span></td>" +
            // "</tr>",
            "<tr>"                                                                                                                                               +
                "<td><span class=\"mq_tablet rowNum\"></span></td>"                                                                                              +
                "<td class=\"area_tit\">"                                                                                                                        +
                    "<a href=\"#\" class=\"link tit ellipsis w_400 bbsTit\"></a>"                                                                                +
                    "<strong class=\"btn_detail mq_mobile\"><a href=\"#\">상세보기</a></strong>"                                                                 +
                "</td>"                                                                                                                                          +
                "<td><span class=\"writer userNm\"></span></td>"                                                                                                 +
                "<td><span class=\"date userDttm\"></span></td>"                                                                                                 +
                "<td><span class=\"mq_tablet viewCnt\"></span></td>"                                                                                             +
                "<td><span class=\"reply ansCnt\"><img src=\"" + com.wise.help.url("/img/ggportal/desktop/common/icon_reply.png") + "\" alt=\"\" /></span></td>" +
            "</tr>",
        none:
            // "<tr>"                                                              +
            //     "<td colspan=\"7\" class=\"noData\">해당 자료가 없습니다.</td>" +
            // "</tr>"
            "<tr>"                                                              +
                "<td colspan=\"6\" class=\"noData\">해당 자료가 없습니다.</td>" +
            "</tr>"
    },
    data:{
        data:
            "<tr>"                                                                               +
                "<td><span class=\"mq_tablet rowNum\"></span></td>"                              +
                "<td class=\"area_tit\">"                                                        +
                    "<a href=\"#\" class=\"link tit ellipsis w_400 bbsTit\"></a>"                +
                    "<strong class=\"btn_detail mq_mobile\"><a href=\"#\">상세보기</a></strong>" +
                "</td>"                                                                          +
                "<td><span class=\"writer userNm\"></span></td>"                                 +
                "<td><span class=\"date userDttm\"></span></td>"                                 +
                "<td><span class=\"mq_tablet viewCnt\"></span></td>"                             +
                "<td class=\"btn addFile\"><span class=\"fileCnt\"></span></td>"                 +
            "</tr>",
        none:
            "<tr>"                                                              +
                "<td colspan=\"6\" class=\"noData\">해당 자료가 없습니다.</td>" +
            "</tr>"
    },
    qna:{
        data:
            "<tr>"                                                                               +
                "<td><span class=\"mq_tablet rowNum\"></span></td>"                              +
                "<td class=\"area_tit\">"                                                        +
                    "<a href=\"#\" class=\"link tit ellipsis w_400 bbsTit\"></a>"                +
                    "<strong class=\"btn_detail mq_mobile\"><a href=\"#\">상세보기</a></strong>" +
                "</td>"                                                                          +
                "<td><span class=\"writer userNm\"></span></td>"                                 +
                "<td><span class=\"date userDttm\"></span></td>"                                 +
                "<td><span class=\"mq_tablet viewCnt\"></span></td>"                             +
                "<td class=\"txt\"><span class=\"txt_D ansStateNm\"></span></td>"                +
            "</tr>",
        none:
            "<tr>"                                                              +
                "<td colspan=\"6\" class=\"noData\">해당 자료가 없습니다.</td>" +
            "</tr>"
    }
};

/**
 * 완료
 */
var completes = {
    dataset:false,
    stat: false,
    // village:false,
    //catalog:false,
    //multimedia:false,
    gallery:true,
    //develop:false,
    //data:false,
    qna:false
};
////////////////////////////////////////////////////////////////////////////////
// 초기화 함수
////////////////////////////////////////////////////////////////////////////////
/**
 * 컴포넌트를 초기화한다.
 */
function initComp() {
    $("#search").val($("#unified-search-form [name=searchWord]").val());
    // 더보기 버튼이 검색값이 있을 때만 보이게 하기 위해 전체 투명화 처리 (hide 하면 위치 깨짐)
    // 값이 없을 때만 투명처리하면 화면 로드시 처음에 나타났다가 사라지는게 눈에 보이므로 첨부터 숨겨놓고 시작
    $('.btn_D_more').css({opacity : 0, cursor : 'default'});
    $('.btn_D_more').removeAttr("href");
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
    // 공공데이터 데이터셋 더보기 버튼에 클릭 이벤트를 바인딩한다.
    $("#dataset-search-button").bind("click", function(event) {
        // 공공데이터 데이터셋 전체목록을 검색한다.
        searchDataset(true);
        return false;
    });
    
    // 공공데이터 데이터셋 더보기 버튼에 키다운 이벤트를 바인딩한다.
    $("#dataset-search-button").bind("keydown", function(event) {
        if (event.which == 13) {
            // 공공데이터 데이터셋 전체목록을 검색한다.
            searchDataset(true);
            return false;
        }
    });
    
    // 통계데이터 더보기 버튼에 클릭 이벤트를 바인딩한다.
    $("#stat-search-button").bind("click", function(event) {
        // 공공데이터 데이터셋 전체목록을 검색한다.
        searchStat(true);
        return false;
    });
    
    // 통계데이터 더보기 버튼에 키다운 이벤트를 바인딩한다.
    $("#stat-search-button").bind("keydown", function(event) {
        if (event.which == 13) {
            // 공공데이터 데이터셋 전체목록을 검색한다.
        	searchStat(true);
            return false;
        }
    });
    
    // 우리지역 데이터 찾기 더보기 버튼에 클릭 이벤트를 바인딩한다.
    $("#village-search-button").bind("click", function(event) {
        // 우리지역 데이터 찾기 전체목록을 검색한다.
        searchVillage(true);
        return false;
    });
    
    // 우리지역 데이터 찾기 더보기 버튼에 키다운 이벤트를 바인딩한다.
    $("#village-search-button").bind("keydown", function(event) {
        if (event.which == 13) {
            // 우리지역 데이터 찾기 전체목록을 검색한다.
            searchVillage(true);
            return false;
        }
    });
    
    /* 171221-KIMJH 사용안함
    // 공공데이터 멀티미디어 서비스 더보기 버튼에 클릭 이벤트를 바인딩한다.
    $("#multimedia-search-button").bind("click", function(event) {
        // 공공데이터 멀티미디어 서비스 전체목록을 검색한다.
        searchMultimedia(true);
        return false;
    });
    
    // 공공데이터 멀티미디어 서비스 더보기 버튼에 키다운 이벤트를 바인딩한다.
    $("#multimedia-search-button").bind("keydown", function(event) {
        if (event.which == 13) {
            // 공공데이터 멀티미디어 서비스 전체목록을 검색한다.
            searchMultimedia(true);
            return false;
        }
    });
    */
    // 갤러리 게시판 더보기 버튼에 클릭 이벤트를 바인딩한다.
    $("#gallery-search-button").bind("click", function(event) {
        // 갤러리 게시판 내용을 검색한다.
        searchGallery(true);
        return false;
    });
    
    // 갤러리 게시판 더보기 버튼에 키다운 이벤트를 바인딩한다.
    $("#gallery-search-button").bind("keydown", function(event) {
        if (event.which == 13) {
            // 갤러리 게시판 내용을 검색한다.
            searchGallery(true);
            return false;
        }
    });
    /* 171221-KIMJH 사용안함
    // 개발자공간 게시판 더보기 버튼에 클릭 이벤트를 바인딩한다.
    $("#develop-search-button").bind("click", function(event) {
        // 개발자공간 게시판 내용을 검색한다.
        searchDevelop(true);
        return false;
    });
    
    // 개발자공간 게시판 더보기 버튼에 키다운 이벤트를 바인딩한다.
    $("#develop-search-button").bind("keydown", function(event) {
        if (event.which == 13) {
            // 개발자공간 게시판 내용을 검색한다.
            searchDevelop(true);
            return false;
        }
    });
    */
    // 자료실 게시판 더보기 버튼에 클릭 이벤트를 바인딩한다.
    $("#data-search-button").bind("click", function(event) {
        // 자료실 게시판 내용을 검색한다.
        searchData(true);
        return false;
    });
    
    // 자료실 게시판 더보기 버튼에 키다운 이벤트를 바인딩한다.
    $("#data-search-button").bind("keydown", function(event) {
        if (event.which == 13) {
            // 자료실 게시판 내용을 검색한다.
            searchData(true);
            return false;
        }
    });
    
    // Q&A 게시판 더보기 버튼에 클릭 이벤트를 바인딩한다.
    $("#qna-search-button").bind("click", function(event) {
        // Q&A 게시판 내용을 검색한다.
        searchQna(true);
        return false;
    });
    
    // Q&A 게시판 더보기 버튼에 키다운 이벤트를 바인딩한다.
    $("#qna-search-button").bind("keydown", function(event) {
        if (event.which == 13) {
            // Q&A 게시판 내용을 검색한다.
            searchQna(true);
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
    // 공공데이터 데이터셋 전체목록을 검색한다.
    searchDataset(false);
    
    // 통계데이터 전체목록을 검색한다.
    searchStat(false);

    // 갤러리 게시판 내용을 검색한다.
    searchGallery(false);
    
    // 개발자공간 게시판 내용을 검색한다.
    //171221-KIMJH 사용안함
    //searchDevelop(false);
    
    // 자료실 게시판 내용을 검색한다.
    //171221-KIMJH 사용안함
    //searchData(false);
    
    // Q&A 게시판 내용을 검색한다.
    searchQna(false);
    
    // 통합 검색 카운트를 설정한다.
    setUnifiedCount();
}

////////////////////////////////////////////////////////////////////////////////
// 서비스 함수
////////////////////////////////////////////////////////////////////////////////
/**
 * 공공데이터 데이터셋 전체목록을 검색한다.
 * 
 * @param more {Boolean} 더보기
 */
function searchDataset(more) {
    if (more) {
        $("#dataset-search-form [name=rows]").attr("disabled", "disabled");
        
        // 데이터를 검색하는 화면으로 이동한다.
        goSearch({
            url:"/portal/data/dataset/searchDatasetPage.do",
            form:"dataset-search-form",
            data:[
                // Nothing to do.
            ]
        });
    }
    else {
        // 데이터를 검색한다.
        doSearch({
            url:"/portal/data/dataset/searchDataset.do",
            before:beforeSearchDataset,
            after:afterSearchDataset,
            counter:{
                count:"dataset-count-sect"
            }
        });
    }
}

/**
 * 공공데이터 서비스를 조회한다.
 * 
 * @param data {Object} 데이터
 */
function selectService(data) {
    $("#dataset-search-form [name=rows]").attr("disabled", "disabled");
    
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
 * 통계데이터 전체목록을 검색한다.
 * 
 * @param more {Boolean} 더보기
 */
function searchStat(more) {
    if (more) {
        $("#stat-search-form [name=rows]").attr("disabled", "disabled");
        
        // 데이터를 검색하는 화면으로 이동한다.
        goSearch({
            url:"/portal/stat/easyStatSch.do",
            form:"stat-search-form",
            data:[
                // Nothing to do.
            ]
        });
    }
    else {
        // 데이터를 검색한다.
        doSearch({
            url:"/portal/stat/easyStatMobileList.do",
            before:beforeSearchStat,
            after:afterSearchStat,
            counter:{
                count:"stat-count-sect"
            }
        });
    }
}

/**
 * 통계데이터 서비스를 조회한다.
 * 
 * @param data {Object} 데이터
 */
function selectStat(data) {
    // 데이터를 조회하는 화면으로 이동한다.
    goSelect({
        url:"/portal/stat/easyStatSch.do/" + data.statblId,
        form:"stat-search-form",
        data:[{}]
    });
}

/**
 * 갤러리 게시판 내용을 검색한다.
 * 
 * @param more {Boolean} 더보기
 */
function searchGallery(more) {
    if (more) {
        $("#gallery-search-form [name=rows]").attr("disabled", "disabled");
        
        // 데이터를 검색하는 화면으로 이동한다.
        goSearch({
            url:"/portal/bbs/gallery/searchBulletinPage.do",
            form:"gallery-search-form",
            data:[
                // Nothing to do.
            ]
        });
    }
    else {
        // 데이터를 검색한다.
        doSearch({
            url:"/portal/bbs/gallery/searchBulletin.do",
            before:beforeSearchGallery,
            after:afterSearchGallery,
            counter:{
                count:"gallery-count-sect"
            }
        });
    }
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
    
    $("#gallery-search-form [name=rows]").attr("disabled", "disabled");
    
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
 * 개발자공간 게시판 내용을 검색한다.
 * 
 * @param more {Boolean} 더보기
 */
function searchDevelop(more) {
    if (more) {
        $("#develop-search-form [name=rows]").attr("disabled", "disabled");
        
        // 데이터를 검색하는 화면으로 이동한다.
        goSearch({
            url:"/portal/bbs/develop/searchBulletinPage.do",
            form:"develop-search-form",
            data:[
                // Nothing to do.
            ]
        });
    }
    else {
        // 데이터를 검색한다.
        doSearch({
            url:"/portal/bbs/develop/searchBulletin.do",
            before:beforeSearchDevelop,
            after:afterSearchDevelop,
            counter:{
                count:"develop-count-sect"
            }
        });
    }
}

/**
 * 개발자공간 게시판 내용을 조회한다.
 * 
 * @param data {Object} 데이터
 */
function selectDevelop(data) {
    // if (!verifyWriter(data.lockTag, "develop-search-form", selectDevelop, data)) {
    //     return;
    // }
    
    $("#develop-search-form [name=rows]").attr("disabled", "disabled");
    
    // 데이터를 조회하는 화면으로 이동한다.
    goSelect({
        url:"/portal/bbs/develop/selectBulletinPage.do",
        form:"develop-search-form",
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
 * 자료실 게시판 내용을 검색한다.
 * 
 * @param more {Boolean} 더보기
 */
function searchData(more) {
    if (more) {
        $("#data-search-form [name=rows]").attr("disabled", "disabled");
        
        // 데이터를 검색하는 화면으로 이동한다.
        goSearch({
            url:"/portal/bbs/data/searchBulletinPage.do",
            form:"data-search-form",
            data:[
                // Nothing to do.
            ]
        });
    }
    else {
        // 데이터를 검색한다.
        doSearch({
            url:"/portal/bbs/data/searchBulletin.do",
            before:beforeSearchData,
            after:afterSearchData,
            counter:{
                count:"data-count-sect"
            }
        });
    }
}

/**
 * 자료실 게시판 내용을 조회한다.
 * 
 * @param data {Object} 데이터
 */
function selectData(data) {
    // if (!verifyWriter(data.lockTag, "data-search-form", selectData, data)) {
    //     return;
    // }
    
    $("#data-search-form [name=rows]").attr("disabled", "disabled");
    
    // 데이터를 조회하는 화면으로 이동한다.
    goSelect({
        url:"/portal/bbs/data/selectBulletinPage.do",
        form:"data-search-form",
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
 * Q&A 게시판 내용을 검색한다.
 * 
 * @param more {Boolean} 더보기
 */
function searchQna(more) {
    if (more) {
        $("#qna-search-form [name=rows]").attr("disabled", "disabled");
        
        // 데이터를 검색하는 화면으로 이동한다.
        goSearch({
            url:"/portal/bbs/qna01/searchBulletinPage.do",
            form:"qna-search-form",
            data:[
                // Nothing to do.
            ]
        });
    }
    else {
        // 데이터를 검색한다.
        doSearch({
            url:"/portal/bbs/qna01/searchBulletin.do",
            before:beforeSearchQna,
            after:afterSearchQna,
            counter:{
                count:"qna-count-sect"
            }
        });
    }
}

/**
 * Q&A 게시판 내용을 조회한다.
 * 
 * @param data {Object} 데이터
 */
function selectQna(data) {
    if (!verifyWriter(data.lockTag, "qna-search-form", selectQna, data)) {
        return;
    }
    
    $("#qna-search-form [name=rows]").attr("disabled", "disabled");
    
    // 데이터를 조회하는 화면으로 이동한다.
    goSelect({
        url:"/portal/bbs/qna01/selectBulletinPage.do",
        form:"qna-search-form",
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
 * 공공데이터 데이터셋 카테고리 클래스를 반환한다.
 * 
 * @param code {String} 코드
 * @returns {String} 경로
 */
function getCategoryClass(code) {
    var clazz = "";
    
    switch (code) {
        case "GG01":
            clazz = "sort_1";
            break;
        case "GG05":
            clazz = "sort_2";
            break;
        case "GG09":
            clazz = "sort_3";
            break;
        case "GG13":
            clazz = "sort_4";
            break;
        case "GG16":
            clazz = "sort_5";
            break;
        case "GG20":
            clazz = "sort_6";
            break;
        case "GG23":
            clazz = "sort_7";
            break;
        case "GG26":
            clazz = "sort_8";
            break;
        case "GG29":
            clazz = "sort_9";
            break;
    }
    
    return clazz;
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
 * 통합 검색 카운트를 설정한다.
 */
function setUnifiedCount() {
    var completed = true;
    for (var key in completes) {
        completed = completed && completes[key];
    }
    if (completed) {
        var count = 0;
        
        $(".single-count-sect").each(function(index, element) {
            var text = $(this).text();
            
            if (text) {
                count += parseInt(text);
            }
        });
        
        $(".unified-count-sect").each(function(index, element) {
            $(this).text(count);
        });
    }
    else {
        setTimeout(function() {
            // 통합 검색 카운트를 설정한다.
            setUnifiedCount();
        }, 400);
    }
}

////////////////////////////////////////////////////////////////////////////////
// 전처리 함수
////////////////////////////////////////////////////////////////////////////////
/**
 * 공공데이터 데이터셋 전체목록 검색 전처리를 실행한다.
 * 
 * @param options {Object} 옵션
 * @returns {Object} 데이터
 */
function beforeSearchDataset(options) {
    var data = {
        // Nothing do do.
    };
    
    var form = $("#dataset-search-form");
    
    $.each(form.serializeArray(), function(index, element) {
        switch (element.name) {
            case "orgCd":
            case "cateId":
            case "srvCd":
            case "infTag":
            case "searchWord":
                if (data[element.name] == null) {
                    data[element.name] = [];
                }
                
                data[element.name][data[element.name].length] = element.value;
                break;
            default:
                data[element.name] = element.value;
                break;
        }
    });
    
    if (com.wise.util.isBlank(data.searchWord[0])) {
        return null;
    }
    
    return data;
}

/**
 * 통계데이터 전체목록 검색 전처리를 실행한다.
 * 
 * @param options {Object} 옵션
 * @returns {Object} 데이터
 */
function beforeSearchStat(options) {
	var form = $("#stat-search-form");
    var data = {
        // Nothing do do.
   		page: 1,
    	rows: 5,
    	searchGubun: "STATBL_NM",
    	searchVal: form.find("[name=searchVal]").val()
    };
    
    if (com.wise.util.isBlank(data.searchVal)) {
        return null;
    }
    
    return data;
}

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
    
    if (com.wise.util.isBlank(data.searchWord)) {
        return null;
    }
    
    return data;
}

/**
 *  개발자공간 게시판 내용 검색 전처리를 실행한다.
 * 
 * @param options {Object} 옵션
 * @returns {Object} 데이터
 */
function beforeSearchDevelop(options) {
    var data = {
        // Nothing do do.
    };
    
    var form = $("#develop-search-form");
    
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
    
    if (com.wise.util.isBlank(data.searchWord)) {
        return null;
    }
    
    return data;
}

/**
 *  자료실 게시판 내용 검색 전처리를 실행한다.
 * 
 * @param options {Object} 옵션
 * @returns {Object} 데이터
 */
function beforeSearchData(options) {
    var data = {
        // Nothing do do.
    };
    
    var form = $("#data-search-form");
    
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
    
    if (com.wise.util.isBlank(data.searchWord)) {
        return null;
    }
    
    return data;
}

/**
 *  Q&A 게시판 내용 검색 전처리를 실행한다.
 * 
 * @param options {Object} 옵션
 * @returns {Object} 데이터
 */
function beforeSearchQna(options) {
    var data = {
        // Nothing do do.
    };
    
    var form = $("#qna-search-form");
    
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
    
    if (com.wise.util.isBlank(data.searchWord)) {
        return null;
    }
    
    return data;
}

////////////////////////////////////////////////////////////////////////////////
// 후처리 함수
////////////////////////////////////////////////////////////////////////////////
/**
 * 공공데이터 데이터셋 전체목록 검색 후처리를 실행한다.
 * 
 * @param data {Array} 데이터
 */
function afterSearchDataset(data) {
    var table = $("#dataset-data-table");
    
    table.find("tr").each(function(index, element) {
        if (index > 0) {
            $(this).remove();
        }
    });
    
    for (var i = 0; i < data.length; i++) {
        var row = $(templates.dataset.data);
        
        if (data[i].metaImagFileNm || data[i].cateSaveFileNm) {
            var url = com.wise.help.url("/portal/data/dataset/selectThumbnail.do");
            
            // url += "?infId=" + data[i].infId;
            url += "?seq="            + data[i].seq;
            url += "&metaImagFileNm=" + (data[i].metaImagFileNm ? data[i].metaImagFileNm : "");
            url += "&cateSaveFileNm=" + (data[i].cateSaveFileNm ? data[i].cateSaveFileNm : "");
            
            row.find(".metaImagFileNm").attr("src", url);
        }
        
        row.find(".infNm").text(data[i].infNm);
        row.find(".infExp").text(data[i].infExp ? com.wise.util.ellipsis(data[i].infExp, 56) : "");
        
        if (data[i].scolInfSeq) {
            if (row.find(".txt_A").length > 0) {
                row.find(".area_txt_A").append(" ");
            }
            row.find(".area_txt_A").append("<a href=\"#\" class=\"dataset-sheet-button\"><span class=\"txt_A txt_A_1\">SHEET</span></a>");
        }
        if (data[i].ccolInfSeq) {
            if (row.find(".txt_A").length > 0) {
                row.find(".area_txt_A").append(" ");
            }
            row.find(".area_txt_A").append("<a href=\"#\" class=\"dataset-chart-button\"><span class=\"txt_A txt_A_2\">CHART</span></a>");
        }
        if (data[i].mcolInfSeq) {
            if (row.find(".txt_A").length > 0) {
                row.find(".area_txt_A").append(" ");
            }
            row.find(".area_txt_A").append("<a href=\"#\" class=\"dataset-map-button\"><span class=\"txt_A txt_A_3\">MAP</span></a>");
        }
        if (data[i].fileInfSeq) {
            if (row.find(".txt_A").length > 0) {
                row.find(".area_txt_A").append(" ");
            }
            row.find(".area_txt_A").append("<a href=\"#\" class=\"dataset-file-button\"><span class=\"txt_A txt_A_4\">FILE</span></a>");
        }
        if (data[i].acolInfSeq) {
            if (row.find(".txt_A").length > 0) {
                row.find(".area_txt_A").append(" ");
            }
            row.find(".area_txt_A").append("<a href=\"#\" class=\"dataset-openapi-button\"><span class=\"txt_A txt_A_5\">API</span></a>");
        }
        if (data[i].linkInfSeq) {
            if (row.find(".txt_A").length > 0) {
                row.find(".area_txt_A").append(" ");
            }
            row.find(".area_txt_A").append("<a href=\"#\" class=\"dataset-link-button\"><span class=\"txt_A txt_A_6\">LINK</span></a>");
        }
        
        row.find(".regDttm").text(data[i].regDttm);
      //추가
        row.find(".updDttm").text(data[i].updDttm);
        //추가끝
        row.find(".viewCnt").text(com.wise.util.toCurrency(data[i].viewCnt.toString()));
        row.find(".topCateNm").text(data[i].topCateNm);
        row.find(".dataset-category-sect").eq(0).addClass(getCategoryClass(data[i].topCateId));
        
        if (data[i].topCateId2) {
        	row.find("td").eq(4).append("<span class=\"sort dataset-category-sect\"><strong class=\"topCateNm2\"></strong></span>")
        	row.find(".topCateNm2").text(data[i].topCateNm2);
            row.find(".dataset-category-sect").eq(1).addClass(getCategoryClass(data[i].topCateId2));
        }
        
        row.find(".dataset-select-link").each(function(index, element) {
            // 서비스 링크에 클릭 이벤트를 바인딩한다.
            $(this).bind("click", {
                infId:data[i].infId,
                infSeq:data[i].infSeq
            }, function(event) {
                // 공공데이터 서비스를 조회한다.
                selectService(event.data);
                return false;
            });
            
            // 서비스 링크에 키다운 이벤트를 바인딩한다.
            $(this).bind("keydown", {
                infId:data[i].infId,
                infSeq:data[i].infSeq
            }, function(event) {
                if (event.which == 13) {
                    // 공공데이터 서비스를 조회한다.
                    selectService(event.data);
                    return false;
                }
            });
        });
        
        row.find(".dataset-sheet-button").each(function(index, element) {
            // 시트 버튼에 클릭 이벤트를 바인딩한다.
            $(this).bind("click", {
                infId:data[i].infId,
                infSeq:data[i].scolInfSeq
            }, function(event) {
                // 공공데이터 서비스를 조회한다.
                selectService(event.data);
                return false;
            });
            
            // 시트 버튼에 키다운 이벤트를 바인딩한다.
            $(this).bind("keydown", {
                infId:data[i].infId,
                infSeq:data[i].scolInfSeq
            }, function(event) {
                if (event.which == 13) {
                    // 공공데이터 서비스를 조회한다.
                    selectService(event.data);
                    return false;
                }
            });
        });
        
        row.find(".dataset-chart-button").each(function(index, element) {
            // 차트 버튼에 클릭 이벤트를 바인딩한다.
            $(this).bind("click", {
                infId:data[i].infId,
                infSeq:data[i].ccolInfSeq
            }, function(event) {
                // 공공데이터 서비스를 조회한다.
                selectService(event.data);
                return false;
            });
            
            // 차트 버튼에 키다운 이벤트를 바인딩한다.
            $(this).bind("keydown", {
                infId:data[i].infId,
                infSeq:data[i].ccolInfSeq
            }, function(event) {
                if (event.which == 13) {
                    // 공공데이터 서비스를 조회한다.
                    selectService(event.data);
                    return false;
                }
            });
        });
        
        row.find(".dataset-map-button").each(function(index, element) {
            // 맵 버튼에 클릭 이벤트를 바인딩한다.
            $(this).bind("click", {
                infId:data[i].infId,
                infSeq:data[i].mcolInfSeq
            }, function(event) {
                // 공공데이터 서비스를 조회한다.
                selectService(event.data);
                return false;
            });
            
            // 맵 버튼에 키다운 이벤트를 바인딩한다.
            $(this).bind("keydown", {
                infId:data[i].infId,
                infSeq:data[i].mcolInfSeq
            }, function(event) {
                if (event.which == 13) {
                    // 공공데이터 서비스를 조회한다.
                    selectService(event.data);
                    return false;
                }
            });
        });
        
        row.find(".dataset-file-button").each(function(index, element) {
            // 파일 버튼에 클릭 이벤트를 바인딩한다.
            $(this).bind("click", {
                infId:data[i].infId,
                infSeq:data[i].fileInfSeq
            }, function(event) {
                // 공공데이터 서비스를 조회한다.
                selectService(event.data);
                return false;
            });
            
            // 파일 버튼에 키다운 이벤트를 바인딩한다.
            $(this).bind("keydown", {
                infId:data[i].infId,
                infSeq:data[i].fileInfSeq
            }, function(event) {
                if (event.which == 13) {
                    // 공공데이터 서비스를 조회한다.
                    selectService(event.data);
                    return false;
                }
            });
        });
        
        row.find(".dataset-openapi-button").each(function(index, element) {
            // 오픈API 버튼에 클릭 이벤트를 바인딩한다.
            $(this).bind("click", {
                infId:data[i].infId,
                infSeq:data[i].acolInfSeq
            }, function(event) {
                // 공공데이터 서비스를 조회한다.
                selectService(event.data);
                return false;
            });
            
            // 오픈API 버튼에 키다운 이벤트를 바인딩한다.
            $(this).bind("keydown", {
                infId:data[i].infId,
                infSeq:data[i].acolInfSeq
            }, function(event) {
                if (event.which == 13) {
                    // 공공데이터 서비스를 조회한다.
                    selectService(event.data);
                    return false;
                }
            });
        });
        
        row.find(".dataset-link-button").each(function(index, element) {
            // 링크 버튼에 클릭 이벤트를 바인딩한다.
            $(this).bind("click", {
                infId:data[i].infId,
                infSeq:data[i].linkInfSeq
            }, function(event) {
                // 공공데이터 서비스를 조회한다.
                selectService(event.data);
                return false;
            });
            
            // 링크 버튼에 키다운 이벤트를 바인딩한다.
            $(this).bind("keydown", {
                infId:data[i].infId,
                infSeq:data[i].linkInfSeq
            }, function(event) {
                if (event.which == 13) {
                    // 공공데이터 서비스를 조회한다.
                    selectService(event.data);
                    return false;
                }
            });
        });
        
        table.append(row);
    }
    
    if (data.length == 0) {
        var row = $(templates.dataset.none);
        
        table.append(row);
        unbindPlusViewBtn('dataset-search-button');
    } else {
    	showPlusViewBtn('dataset-search-button');
    }
    
    completes.dataset = true;
}

/**
 * 통계데이터 전체목록 검색 후처리를 실행한다.
 * 
 * @param data {Array} 데이터
 */
function afterSearchStat(data) {
    var table = $("#stat-data-table");
    
    table.find("tr").each(function(index, element) {
        if (index > 0) {
            $(this).remove();
        }
    });
    
    for (var i = 0; i < data.length; i++) {
        var row = $(templates.stat.data);
        row.find(".statblNm").text(data[i].statblNm ? com.wise.util.ellipsis(data[i].statblNm, 40) : "");
        row.find(".orgNm").text(data[i].orgNm);
        row.find(".openDttm").text(data[i].openDttmYmd);
        
        row.find(".statblNm").each(function(index, element) {
            // 통계표명에 클릭 이벤트를 바인딩한다.
            $(this).bind("click", {
                statblId:data[i].statblId
            }, function(event) {
                // 공공데이터 서비스를 조회한다.
            	selectStat(event.data);
                return false;
            });
        });
        
        table.append(row);
    }
    
    if (data.length == 0) {
        var row = $(templates.stat.none);
        table.append(row);
        unbindPlusViewBtn('stat-search-button');
    } else {
    	showPlusViewBtn('stat-search-button');
    }
    
    completes.stat = true;
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
    
    for (var i = 0; i < data.length; i++) {
        var item = $(templates.gallery.data);
        
        if (data[i].fileSeq) {
            var url = com.wise.help.url("/portal/bbs/gallery/selectAttachFile.do") + "?fileSeq=" + data[i].fileSeq;
            
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
        var item = $(templates.gallery.none);
        
        list.append(item);
        unbindPlusViewBtn('gallery-search-button');
    } else {
    	showPlusViewBtn('gallery-search-button');
    }
    
    completes.gallery = true;
}

/**
 * 개발자공간 게시판 내용 검색 후처리를 실행한다.
 * 
 * @param data {Array} 데이터
 */
function afterSearchDevelop(data) {
    var table = $("#develop-data-table");
    
    table.find("tr").each(function(index, element) {
        if (index > 0) {
            $(this).remove();
        }
    });
    
    for (var i = 0; i < data.length; i++) {
        var row = $(templates.develop.data);
        
        if (data[i].noticeYn == "Y") {
            // row.addClass("notice");
            // 
            // row.find(".rowNum").parent("td").html("<span class=\"txt_C\">공지</span>");
            continue;
        }
        else {
            row.find(".rowNum").text(data[i].rowNum);
        }
        
        row.find(".bbsTit").text(data[i].bbsTit);
        
        // if (data[i].secretYn == "Y") {
        //     row.find(".bbsTit").prepend("<img src=\"" + com.wise.help.url("/img/ggportal/desktop/common/icon_lock.png") + "\" alt=\"\" title=\"비밀글 아이콘\" /> ");
        // }
        
        if (data[i].newYn == "Y") {
            row.find(".bbsTit").prepend("<span class=\"txt_new\"></span> ");
        }
        
        // if (data[i].viewCnt >= data[i].hlCnt) {
        //     row.find(".bbsTit").addClass("best");
        // }
        
        row.find(".userNm").text(data[i].userNm);
        row.find(".userDttm").text(data[i].userDttm);
        
        // if (data[i].fileCnt) {
        //     row.find(".fileCnt").append("<img src=\"" + com.wise.help.url("/img/ggportal/desktop/common/icon_addFile.png") + "\" alt=\"\" />");
        // }
        
        row.find(".viewCnt").text(com.wise.util.toCurrency(data[i].viewCnt.toString()));
        row.find(".ansCnt").append(com.wise.util.toCurrency(data[i].ansCnt.toString()));
        
        row.find("a").each(function(index, element) {
            // 개발자공간 게시판 내용 제목 링크에 클릭 이벤트를 바인딩한다.
            $(this).bind("click", {
                bbsCd:data[i].bbsCd,
                seq:data[i].seq,
                noticeYn:data[i].noticeYn,
                lockTag:data[i].lockTag
            }, function(event) {
                // 개발자공간 게시판 내용을 조회한다.
                selectDevelop(event.data);
                return false;
            });
            
            // 개발자공간 게시판 내용 제목 링크에 키다운 이벤트를 바인딩한다.
            $(this).bind("keydown", {
                bbsCd:data[i].bbsCd,
                seq:data[i].seq,
                noticeYn:data[i].noticeYn,
                lockTag:data[i].lockTag
            }, function(event) {
                if (event.which == 13) {
                    // 개발자공간 게시판 내용을 조회한다.
                    selectDevelop(event.data);
                    return false;
                }
            });
        });
        
        table.append(row);
    }
    
    if (data.length == 0) {
        var row = $(templates.develop.none);
        
        table.append(row);
        unbindPlusViewBtn('develop-search-button');
    } else {
    	showPlusViewBtn('develop-search-button');
    }
    
    completes.develop = true;
}

/**
 * 자료실 게시판 내용 검색 후처리를 실행한다.
 * 
 * @param data {Array} 데이터
 */
function afterSearchData(data) {
    var table = $("#data-data-table");
    
    table.find("tr").each(function(index, element) {
        if (index > 0) {
            $(this).remove();
        }
    });
    
    for (var i = 0; i < data.length; i++) {
        var row = $(templates.data.data);
        
        if (data[i].noticeYn == "Y") {
            // row.addClass("notice");
            // 
            // row.find(".rowNum").parent("td").html("<span class=\"txt_C\">공지</span>");
            continue;
        }
        else {
            row.find(".rowNum").text(data[i].rowNum);
        }
        
        row.find(".bbsTit").text(data[i].bbsTit);
        
        // if (data[i].secretYn == "Y") {
        //     row.find(".bbsTit").prepend("<img src=\"" + com.wise.help.url("/img/ggportal/desktop/common/icon_lock.png") + "\" alt=\"\" title=\"비밀글 아이콘\" /> ");
        // }
        
        if (data[i].newYn == "Y") {
            row.find(".bbsTit").prepend("<span class=\"txt_new\"></span> ");
        }
        
        // if (data[i].viewCnt >= data[i].hlCnt) {
        //     row.find(".bbsTit").addClass("best");
        // }
        
        row.find(".userNm").text(data[i].userNm);
        row.find(".userDttm").text(data[i].userDttm);
        row.find(".viewCnt").text(com.wise.util.toCurrency(data[i].viewCnt.toString()));
        
        if (data[i].fileCnt) {
            row.find(".fileCnt").append("<img src=\"" + com.wise.help.url("/images/icon_addfile.png") + "\" alt=\"첨부파일\" />");
        }
        
        // row.find(".ansCnt").append(com.wise.util.toCurrency(data[i].ansCnt.toString()));
        
        row.find("a").each(function(index, element) {
            // 자료실 게시판 내용 제목 링크에 클릭 이벤트를 바인딩한다.
            $(this).bind("click", {
                bbsCd:data[i].bbsCd,
                seq:data[i].seq,
                noticeYn:data[i].noticeYn,
                lockTag:data[i].lockTag
            }, function(event) {
                // 자료실 게시판 내용을 조회한다.
                selectData(event.data);
                return false;
            });
            
            // 자료실 게시판 내용 제목 링크에 키다운 이벤트를 바인딩한다.
            $(this).bind("keydown", {
                bbsCd:data[i].bbsCd,
                seq:data[i].seq,
                noticeYn:data[i].noticeYn,
                lockTag:data[i].lockTag
            }, function(event) {
                if (event.which == 13) {
                    // 자료실 게시판 내용을 조회한다.
                    selectData(event.data);
                    return false;
                }
            });
        });
        
        table.append(row);
    }
    
    if (data.length == 0) {
        var row = $(templates.data.none);
        
        table.append(row);
        unbindPlusViewBtn('data-search-button');
    } else {
    	showPlusViewBtn('data-search-button');
    }
    
    completes.data = true;
}

/**
 * Q&A 게시판 내용 검색 후처리를 실행한다.
 * 
 * @param data {Array} 데이터
 */
function afterSearchQna(data) {
    var table = $("#qna-data-table");
    
    table.find("tr").each(function(index, element) {
        if (index > 0) {
            $(this).remove();
        }
    });
    
    for (var i = 0; i < data.length; i++) {
        var row = $(templates.qna.data);
        
        if (data[i].noticeYn == "Y") {
            // row.addClass("notice");
            // 
            // row.find(".rowNum").parent("td").html("<span class=\"txt_C\">공지</span>");
            continue;
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
        
        row.find(".userNm").text(data[i].userNm);
        row.find(".userDttm").text(data[i].userDttm);
        row.find(".viewCnt").text(com.wise.util.toCurrency(data[i].viewCnt.toString()));
        
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
        var row = $(templates.qna.none);
        
        table.append(row);
        unbindPlusViewBtn('qna-search-button');
    } else {
    	showPlusViewBtn('qna-search-button');
    }
    
    completes.qna = true;
}

////////////////////////////////////////////////////////////////////////////////
// 이벤트 함수
////////////////////////////////////////////////////////////////////////////////
function showPlusViewBtn(id) {
	$('#'+id).css({opacity : 1, cursor : 'pointer'});
	$('#'+id).attr("href", "#");
}

function unbindPlusViewBtn(id) {
	$('#'+id).unbind('click');
}
