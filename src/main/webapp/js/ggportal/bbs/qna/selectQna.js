/*
 * @(#)selectQna.js 1.0 2015/06/15
 * 
 * COPYRIGHT (C) 2013 WISEITECH CO., LTD. ALL RIGHTS RESERVED.
 */

/**
 * Q&A 게시판 내용을 조회하는 스크립트이다.
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
    // Q&A 게시판 내용 조회 폼에 제출 이벤트를 바인딩한다.
    $("#qna-select-form").bind("submit", function(event) {
        return false;
    });
    
    // Q&A 게시판 내용 목록 버튼에 클릭 이벤트를 바인딩한다.
    $("#qna-search-button").bind("click", function(event) {
        // Q&A 게시판 내용을 검색한다.
        searchQna($("#qna-search-form [name=page]").val());
        return false;
    });
    
    // Q&A 게시판 내용 목록 버튼에 키다운 이벤트를 바인딩한다.
    $("#qna-search-button").bind("keydown", function(event) {
        if (event.which == 13) {
            // Q&A 게시판 내용을 검색한다.
            searchQna($("#qna-search-form [name=page]").val());
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
    // Q&A 게시판 내용을 조회한다.
    selectQna();
}

////////////////////////////////////////////////////////////////////////////////
// 서비스 함수
////////////////////////////////////////////////////////////////////////////////
/**
 * Q&A 게시판 내용을 조회한다.
 */
function selectQna() {
    // 데이터를 조회한다.
    doSelect({
        url:resolveUrl("/selectBulletin.do"),
        before:beforeSelectQna,
        after:afterSelectQna
    });
}

/**
 * Q&A 게시판 내용을 수정한다.
 * 
 * @param data {Object} 데이터
 */
function updateQna(data) {
    if (!verifyWriter(data.lockTag, "qna-search-form", updateQna, data)) {
        return;
    }
    
    // 데이터를 수정하는 화면으로 이동한다.
    goUpdate({
        url:resolveUrl("/updateBulletinPage.do"),
        form:"qna-search-form"
    });
}

/**
 * Q&A 게시판 내용을 삭제한다.
 * 
 * @param data {Object} 데이터
 */
function deleteQna(data) {
    if (!verifyWriter(data.lockTag, "qna-select-form", deleteQna, data)) {
        return;
    }
    
    // 데이터를 삭제한다.
    doDelete({
        url:resolveUrl("/deleteBulletin.do"),
        before:beforeDeleteQna,
        after:afterDeleteQna
    });
}

/**
 * Q&A 게시판 내용을 검색한다.
 *
 * @param page {String} 페이지 번호
 */
function searchQna(page) {
    // 데이터를 검색하는 화면으로 이동한다.
    goSearch({
        url:resolveUrl("/searchBulletinPage.do"),
        form:"qna-search-form",
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
    
    return matches[0] + $("#qna-search-form [name=bbsCd]").val().toLowerCase() + url;
}

////////////////////////////////////////////////////////////////////////////////
// 전처리 함수
////////////////////////////////////////////////////////////////////////////////
/**
 *  Q&A 게시판 내용 조회 전처리를 실행한다.
 * 
 * @param options {Object} 옵션
 * @returns {Object} 데이터
 */
function beforeSelectQna(options) {
    var data = {
        // Nothing do do.
    };
    
    var form = $("#qna-search-form");
    
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

/**
 * Q&A 게시판 내용 삭제 전처리를 실행한다.
 * 
 * @param options {Object} 옵션
 * @returns {Object} 데이터
 */
function beforeDeleteQna(options) {
    var data = {
        // Nothing do do.
    };
    
    var form = $("#qna-select-form");
    
    $.each(form.serializeArray(), function(index, element) {
        switch (element.name) {
            case "bbsCd":
            case "seq":
            case "userPw":
                data[element.name] = element.value;
                break;
        }
    });
    
    if (com.wise.util.isBlank(data.bbsCd)) {
        alert("삭제할 데이터가 없습니다.");
        return null;
    }
    if (com.wise.util.isBlank(data.seq)) {
        alert("삭제할 데이터가 없습니다.");
        return null;
    }
    
    if (!confirm("게시물을 삭제하시겠습니까?")) {
        return null;
    }
    
    return data;
}

////////////////////////////////////////////////////////////////////////////////
// 후처리 함수
////////////////////////////////////////////////////////////////////////////////
/**
 * Q&A 게시판 내용 조회 후처리를 실행한다.
 * 
 * @param data {Object} 데이터
 */
function afterSelectQna(data) {
    var form = $("#qna-select-form");
    
    form.find("[name=bbsCd]").val(data.bbsCd);
    form.find("[name=seq]").val(data.seq);
    
    form.find(".bbsTit").prepend(com.wise.help.XSSfilter(data.bbsTit));
        
    if (data.listSubNm) {
        form.find(".listSubNm").prepend("[" + data.listSubNm + "] ");
    }
    
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
            $("#qna-attach-sect").parent("dl").removeClass("hide");
            
            // 파일을 처리한다.
            handleFiles(data.files, {
                mode:"select",
                attacher:"qna-attach-sect",
                url:resolveUrl("/downloadAttachFile.do"),
                target:"global-process-iframe"
            });
        }
    }
    
    if (data.ansState == "AK" || data.ansState == "AC") {	//답변대기, 답변불가시 답변내용 보여준다.
        form.find(".ansCont").parent("td").parent("tr").removeClass("hide");
        
        if (data.htmlYn == "Y") {
            form.find(".ansCont").html(data.ansCont);
        }
        else {
            form.find(".ansCont").text(data.ansCont ? data.ansCont.replace(/\r/g, "") : "");
        }
    }
    
    if (data.lockTag != "Y" && data.ansState == "RW") {
        $("#qna-update-button").removeClass("hide");
        $("#qna-delete-button").removeClass("hide");
        
        // Q&A 게시판 내용 수정 버튼에 클릭 이벤트를 바인딩한다.
        $("#qna-update-button").bind("click", {
            lockTag:data.lockTag
        }, function(event) {
            // Q&A 게시판 내용을 수정한다.
            updateQna(event.data);
            return false;
        });
        
        // Q&A 게시판 내용 수정 버튼에 키다운 이벤트를 바인딩한다.
        $("#qna-update-button").bind("keydown", {
            lockTag:data.lockTag
        }, function(event) {
            if (event.which == 13) {
                // Q&A 게시판 내용을 수정한다.
                updateQna(event.data);
                return false;
            }
        });
        
        // Q&A 게시판 내용 삭제 버튼에 클릭 이벤트를 바인딩한다.
        $("#qna-delete-button").bind("click", {
            lockTag:data.lockTag
        }, function(event) {
            // Q&A 게시판 내용을 삭제한다.
            deleteQna(event.data);
            return false;
        });
        
        // Q&A 게시판 내용 삭제 버튼에 키다운 이벤트를 바인딩한다.
        $("#qna-delete-button").bind("keydown", {
            lockTag:data.lockTag
        }, function(event) {
            if (event.which == 13) {
                // Q&A 게시판 내용을 삭제한다.
                deleteQna(event.data);
                return false;
            }
        });
    }
}

/**
 * Q&A 게시판 내용 삭제 후처리를 실행한다.
 * 
 * @param qnas {Object} Q&A
 */
function afterDeleteQna(qnas) {
    // Q&A 게시판 내용을 검색한다.
    searchQna();
}

////////////////////////////////////////////////////////////////////////////////
// 이벤트 함수
////////////////////////////////////////////////////////////////////////////////