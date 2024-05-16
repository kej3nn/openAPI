/*
 * @(#)selectNotice.js 1.0 2015/06/15
 * 
 * COPYRIGHT (C) 2013 WISEITECH CO., LTD. ALL RIGHTS RESERVED.
 */

/**
 * 공지 게시판 내용을 조회하는 스크립트이다.
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
    // 공지 게시판 내용 조회 폼에 제출 이벤트를 바인딩한다.
    $("#notice-select-form").bind("submit", function(event) {
        return false;
    });
    
    // 공지 게시판 내용 목록 버튼에 클릭 이벤트를 바인딩한다.
    $("#notice-search-button").bind("click", function(event) {
        // 공지 게시판 내용을 검색한다.
        searchNotice($("#notice-search-form [name=page]").val());
        return false;
    });
    
    // 공지 게시판 내용 목록 버튼에 키다운 이벤트를 바인딩한다.
    $("#notice-search-button").bind("keydown", function(event) {
        if (event.which == 13) {
            // 공지 게시판 내용을 검색한다.
            searchNotice($("#notice-search-form [name=page]").val());
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
    // 공지 게시판 내용을 조회한다.
    selectNotice();
}

////////////////////////////////////////////////////////////////////////////////
// 서비스 함수
////////////////////////////////////////////////////////////////////////////////
/**
 * 공지 게시판 내용을 조회한다.
 */
function selectNotice() {
    // 데이터를 조회한다.
    doSelect({
        url:resolveUrl("/selectBulletin.do"),
        before:beforeSelectNotice,
        after:afterSelectNotice
    });
}

/**
 * 공지 게시판 내용을 검색한다.
 *
 * @param page {String} 페이지 번호
 */
function searchNotice(page) {
    // 데이터를 검색하는 화면으로 이동한다.
    goSearch({
        url:resolveUrl("/searchBulletinPage.do"),
        form:"notice-search-form",
        data:[{
            name:"page",
            value:page ? page : "1"
        }]
    });
}

/**
 * URL을 반환한다.
 * 
 * @param url {String} URL
 */
function resolveUrl(url) {
    var matches = window.location.href.match(/\/portal\/[^\/]+\//);
    
    return matches[0] + $("#notice-search-form [name=bbsCd]").val().toLowerCase() + url;
}

////////////////////////////////////////////////////////////////////////////////
// 전처리 함수
////////////////////////////////////////////////////////////////////////////////
/**
 *  공지 게시판 내용 조회 전처리를 실행한다.
 * 
 * @param options {Object} 옵션
 * @returns {Object} 데이터
 */
function beforeSelectNotice(options) {
    var data = {
        // Nothing do do.
    };
    
    var form = $("#notice-search-form");
    
    $.each(form.serializeArray(), function(index, element) {
        switch (element.name) {
            case "page":
            case "rows":
                break;
            default:
                data[element.name] = element.value;
                break;
        }
    });
    
    if (com.wise.util.isBlank(data.bbsCd)) {
        return null;
    }
    if (com.wise.util.isBlank(data.seq)) {
        return null;
    }
    
    return data;
}

////////////////////////////////////////////////////////////////////////////////
// 후처리 함수
////////////////////////////////////////////////////////////////////////////////
/**
 * 공지 게시판 내용 조회 후처리를 실행한다.
 * 
 * @param data {Object} 데이터
 */
function afterSelectNotice(data) {
    var form = $("#notice-select-form");
    
    form.find(".bbsTit").prepend(com.wise.help.XSSfilter(data.bbsTit));
        
    if (data.listSubNm) {
        form.find(".listSubNm").prepend("[" + data.listSubNm + "] ");
    }
    
    form.find(".userNm").text(data.userNm);
    form.find(".userDttm").text(data.userDttm);
    form.find(".viewCnt").text(data.viewCnt);
    
    if (data.htmlYn == "Y") {
        form.find(".bbsCont").html(data.bbsCont);
    }
    else {
        form.find(".bbsCont").text(data.bbsCont ? data.bbsCont.replace(/\r/g, "") : "");
    }
    
    if (data.fileCnt) {
        if (data.files) {
            // 파일을 처리한다.
            handleFiles(data.files, {
                mode:"select",
                attacher:"notice-attach-sect",
                url:resolveUrl("/downloadAttachFile.do"),
                target:"global-process-iframe"
            });
        }
    }
}

////////////////////////////////////////////////////////////////////////////////
// 이벤트 함수
////////////////////////////////////////////////////////////////////////////////