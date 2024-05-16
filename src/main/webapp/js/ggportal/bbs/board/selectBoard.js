/*
 * @(#)selectBoard.js 1.0 2015/06/15
 * 
 * COPYRIGHT (C) 2013 WISEITECH CO., LTD. ALL RIGHTS RESERVED.
 */

/**
 * 일반 게시판 내용을 조회하는 스크립트이다.
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
        "<li>"                                                                       +
        	"<div class=\"password hide comment-password-sect\">"                    +
		        "<label>비밀번호</label>"                                            +
		        " "                                                                  +
		        "<input type=\"password\" name=\"updUserPw\" autocomplete=\"on\" />" +
		    "</div>"                                                                 +
            "<strong class=\"writer userNm\"></strong>"                              +
            "<span class=\"date userDttm\"></span>"                                  +
            "<span class=\"btn hide comment-button-sect\">"                          +
                "<a href=\"#\" class=\"comment-update-button\">수정</a>"             +
                " "                                                                  +
                "<a href=\"#\" class=\"comment-delete-button\">삭제</a>"             +
            "</span>"                                                                +
            "<p><pre class=\"bbsCont\"></pre></p>"                                   +
        "</li>",
    none:
        "<li class=\"noData\">댓글이 없습니다. 댓글을 남겨주세요.</li>"
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
    // 일반 게시판 내용 조회 폼에 제출 이벤트를 바인딩한다.
    $("#board-select-form").bind("submit", function(event) {
        return false;
    });
    
    // 일반 게시판 댓글 등록 폼에 제출 이벤트를 바인딩한다.
    $("#comment-insert-form").bind("submit", function(event) {
        return false;
    });
    
    // $(".oauth-login-button").each(function(index, element) {
    //     // 로그인 버튼에 클릭 이벤트를 바인딩한다.
    //     $(this).bind("click", function(event) {
    //         // 로그인을 처리한다.
    //         doLogin({
    //             provider:$(this).attr("href").substring(1)
    //         });
    //         return false;
    //     });
    //     
    //     // 로그인 버튼에 키다운 이벤트를 바인딩한다.
    //     $(this).bind("keydown", function(event) {
    //         if (event.which == 13) {
    //             // 로그인을 처리한다.
    //             doLogin({
    //                 provider:$(this).attr("href").substring(1)
    //             });
    //             return false;
    //         }
    //     });
    // });
    
    // 일반 게시판 댓글 내용 필드에 키업 이벤트를 바인딩한다.
    $("#comment-insert-form [name=bbsCont]").bind("keyup", function(event) {
        // 일반 게시판 댓글 내용을 변경한다.
        changeComment();
    });
    
    // 일반 게시판 댓글 쓰기 버튼에 클릭 이벤트를 바인딩한다.
    $("#comment-insert-button").bind("click", function(event) {
        if (com.wise.util.isBlank($("#comment-insert-form [name=seq]").val())) {
            // 일반 게시판 댓글을 등록한다.
            insertComment();
        }
        else {
            // 일반 게시판 댓글을 수정한다.
            updateComment();
        }
        return false;
    });
    
    // 일반 게시판 댓글 쓰기 버튼에 키다운 이벤트를 바인딩한다.
    $("#comment-insert-button").bind("keydown", function(event) {
        if (event.which == 13) {
            if (com.wise.util.isBlank($("#comment-insert-form [name=seq]").val())) {
                // 일반 게시판 댓글을 등록한다.
                insertComment();
            }
            else {
                // 일반 게시판 댓글을 등록한다.
                updateComment();
            }
            return false;
        }
    });
    
    // 일반 게시판 내용 목록 버튼에 클릭 이벤트를 바인딩한다.
    $("#board-search-button").bind("click", function(event) {
        // 일반 게시판 내용을 검색한다.
        searchBoard($("#board-search-form [name=page]").val());
        return false;
    });
    
    // 일반 게시판 내용 목록 버튼에 키다운 이벤트를 바인딩한다.
    $("#board-search-button").bind("keydown", function(event) {
        if (event.which == 13) {
            // 일반 게시판 내용을 검색한다.
            searchBoard($("#board-search-form [name=page]").val());
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
    // 일반 게시판 내용을 조회한다.
    selectBoard();
    
    // 일반 게시판 댓글을 검색한다.
    searchComment();
}

////////////////////////////////////////////////////////////////////////////////
// 서비스 함수
////////////////////////////////////////////////////////////////////////////////
/**
 * 일반 게시판 내용을 조회한다.
 */
function selectBoard() {
    // 데이터를 조회한다.
    doSelect({
        url:resolveUrl("/selectBulletin.do"),
        before:beforeSelectBoard,
        after:afterSelectBoard
    });
}

/**
 * 일반 게시판 내용을 수정한다.
 * 
 * @param data {Object} 데이터
 */
function updateBoard(data) {
    if (!verifyWriter(data.lockTag, "board-search-form", updateBoard, data)) {
        return;
    }
    
    // 데이터를 수정하는 화면으로 이동한다.
    goUpdate({
        url:resolveUrl("/updateBulletinPage.do"),
        form:"board-search-form"
    });
}

/**
 * 일반 게시판 내용을 삭제한다.
 * 
 * @param data {Object} 데이터
 */
function deleteBoard(data) {
    if (!verifyWriter(data.lockTag, "board-select-form", deleteBoard, data)) {
        return;
    }
    
    // 데이터를 삭제한다.
    doDelete({
        url:resolveUrl("/deleteBulletin.do"),
        before:beforeDeleteBoard,
        after:afterDeleteBoard
    });
}

/**
 * 일반 게시판 내용을 검색한다.
 *
 * @param page {String} 페이지 번호
 */
function searchBoard(page) {
    // 데이터를 검색하는 화면으로 이동한다.
    goSearch({
        url:resolveUrl("/searchBulletinPage.do"),
        form:"board-search-form",
        data:[{
            name:"page",
            value:page ? page : "1"
        }]
    });
}

/**
 * 일반 게시판 댓글을 검색한다.
 */
function searchComment() {
    // 데이터를 검색한다.
    doSearch({
        url:resolveUrl("/searchComment.do"),
        before:beforeSearchComment,
        after:afterSearchComment
    });
}

/**
 * 일반 게시판 댓글을 조회한다.
 * 
 * @param data {Object} 데이터
 */
function selectComment(data) {
    data.bbsCd     = data.bbsCd     ? data.bbsCd     : "";
    data.seq       = data.seq       ? data.seq       : "";
    data.pSeq      = data.pSeq      ? data.pSeq      : "";
    data.listSubCd = data.listSubCd ? data.listSubCd : "";
    data.bbsTit    = data.bbsTit    ? data.bbsTit    : "";
    data.bbsCont   = data.bbsCont   ? data.bbsCont   : "";
    data.lockTag   = data.lockTag   ? data.lockTag   : "";
    
    var form = $("#comment-insert-form");
    
    form.find("[name=bbsCd]").val(data.bbsCd);
    form.find("[name=seq]").val(data.seq);
    form.find("[name=pSeq]").val(data.pSeq);
    form.find("[name=listSubCd]").val(data.listSubCd);
    form.find("[name=bbsTit]").val(data.bbsTit);
    form.find("[name=bbsCont]").val(data.bbsCont).focus();
    form.find("[name=bulletIdInfo]").val("");
    form.find("[name=regUserPw]").val("");
  
    if (data.seq) {
        $("#comment-insert-button strong").text("댓글수정");
    }
    else {
        $("#comment-insert-button strong").text("댓글쓰기");
    }
    
    // 일반 게시판 댓글 내용을 변경한다.
    changeComment();
}

/**
 * 일반 게시판 댓글을 등록한다.
 */
function insertComment() {
    // if ($(".oauth-login-button img.on").length == 0) {
    //     alert("로그인 후 이용할 수 있습니다.");
    //     return;
    // }
    
    var from = $("#board-select-form");
    var to   = $("#comment-insert-form");
    
    to.find("[name=bbsCd]").val(from.find("[name=bbsCd]").val());
    to.find("[name=pSeq]").val(from.find("[name=seq]").val());
    to.find("[name=listSubCd]").val(from.find("[name=listSubCd]").val());
    to.find("[name=bbsTit]").val("[RE] " + from.find("[name=bbsTit]").val());
    
    // 데이터를 등록한다.
    doInsert({
        form:"comment-insert-form",
        url:resolveUrl("/insertBulletin.do"),
        before:beforeInsertComment,
        after:afterInsertComment
    });
}

/**
 * 일반 게시판 댓글을 수정한다.
 */
function updateComment() {
    // if ($(".oauth-login-button img.on").length == 0) {
    //     alert("로그인 후 이용할 수 있습니다.");
    //     return;
    // }
    
    // 데이터를 수정한다.
    doUpdate({
        form:"comment-insert-form",
        url:resolveUrl("/updateBulletin.do"),
        before:beforeUpdateComment,
        after:afterUpdateComment
    });
}

/**
 * 일반 게시판 댓글을 삭제한다.
 * 
 * @param data {Object} 데이터
 */
function deleteComment(data) {
    // if ($(".oauth-login-button img.on").length == 0) {
    //     alert("로그인 후 이용할 수 있습니다.");
    //     return;
    // }
    
    // 데이터를 삭제한다.
    doDelete({
        url:resolveUrl("/deleteBulletin.do"),
        data:data,
        before:beforeDeleteComment,
        after:afterDeleteComment
    });
}

/**
 * 일반 게시판 댓글 내용을 변경한다.
 */
function changeComment() {
    $("#comment-bytes-sect").text($("#comment-insert-form [name=bbsCont]").val().length);
}

/**
 * 일반 게시판 댓글 비밀번호를 확인한다.
 * 
 * @param button {Element} 버튼
 * @param data {Object} 데이터
 */
function verifyCommentPassword(button, data) {
    var password = $("#pass"+"word-" + data.seq);
    
    if (password.hasClass("locked")) {
        if ($(button).hasClass("comment-update-button")) {
            alert("댓글 작성자만 수정할 수 있습니다.");
            return;
        }
        else {
            alert("댓글 작성자만 삭제할 수 있습니다.");
            return;
        }
    }
    if (password.hasClass("required")) {
        if (com.wise.util.isBlank(password.val())) {
            alert("비밀번호를 입력하여 주십시오.");
            password.focus();
            return;
        }
        
        // 데이터를 조회한다.
        doSelect({
            url:"/portal/bbs/" + data.bbsCd.toLowerCase() + "/verifyPassword.do",
            before:beforeVerifyCommentPassword(data),
            after:afterVerifyCommentPassword(button, data)
        });
    }
    else {
        if ($(button).hasClass("comment-update-button")) {
            // 일반 게시판 댓글을 조회한다.
            selectComment(data);
        }
        else {
            // 일반 게시판 댓글을 삭제한다.
            deleteComment(data);
        }
    }
}

/**
 * URL을 반환한다.
 * 
 * @param url {String} URL
 */
function resolveUrl(url) {
    var matches = window.location.href.match(/\/portal\/[^\/]+\//);
    
    return matches[0] + $("#board-search-form [name=bbsCd]").val().toLowerCase() + url;
}

////////////////////////////////////////////////////////////////////////////////
// 전처리 함수
////////////////////////////////////////////////////////////////////////////////
/**
 *  일반 게시판 내용 조회 전처리를 실행한다.
 * 
 * @param options {Object} 옵션
 * @returns {Object} 데이터
 */
function beforeSelectBoard(options) {
    var data = {
        // Nothing do do.
    };
    
    var form = $("#board-search-form");
    
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
 * 일반 게시판 내용 삭제 전처리를 실행한다.
 * 
 * @param options {Object} 옵션
 * @returns {Object} 데이터
 */
function beforeDeleteBoard(options) {
    var data = {
        // Nothing do do.
    };
    
    var form = $("#board-select-form");
    
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

/**
 * 일반 게시판 댓글 검색 전처리를 실행한다.
 * 
 * @param options {Object} 옵션
 * @returns {Object} 데이터
 */
function beforeSearchComment(options) {
    var data = {
        // Nothing do do.
    };
    
    var form = $("#board-search-form");
    
    data.bbsCd = form.find("[name=bbsCd]").val();
    data.pSeq  = form.find("[name=seq]").val();
    
    if (com.wise.util.isBlank(data.bbsCd)) {
        return null;
    }
    if (com.wise.util.isBlank(data.pSeq)) {
        return null;
    }
    
    return data;
}

/**
 * 일반 게시판 댓글 등록 전처리를 실행한다.
 * 
 * @param options {Object} 옵션
 * @returns {Boolean} 검증결과
 */
function beforeInsertComment(options) {
    var form = $("#comment-insert-form");
    
    if (com.wise.util.isBlank(form.find("[name=bbsCont]").val())) {
        alert("댓글 내용을 입력하여 주십시오.");
        form.find("[name=bbsCont]").focus();
        return false;
    }
    if (!com.wise.util.isLength(form.find("[name=bbsCont]").val(), 1, 200)) {
        alert("댓글 내용을 200자 이내로 입력하여 주십시오.");
        form.find("[name=bbsCont]").focus();
        return false;
    }
    
    // if (form.find("[name=userPw]").hasClass("required")) {
    //     if (com.wise.util.isBlank(form.find("[name=userPw]").val())) {
    //         alert("비밀번호를 입력하여 주십시오.");
    //         form.find("[name=userPw]").focus();
    //         return false;
    //     }
    // }
    if (form.find("[name=regUserPw]").hasClass("required")) {
        if (com.wise.util.isBlank(form.find("[name=regUserPw]").val())) {
            alert("비밀번호를 입력하여 주십시오.");
            form.find("[name=regUserPw]").focus();
            return false;
        }
    }
    
    form.find("[name=bulletIdInfo]").val(encryptByDES(form.find("[name=regUserPw]").val(), bulletIdInfoKey));
    
    return true;
}

/**
 * 일반 게시판 댓글 수정 전처리를 실행한다.
 * 
 * @param options {Object} 옵션
 * @returns {Boolean} 검증결과
 */
function beforeUpdateComment(options) {
    var form = $("#comment-insert-form");
    
    if (com.wise.util.isBlank(form.find("[name=bbsCont]").val())) {
        alert("댓글 내용을 입력하여 주십시오.");
        form.find("[name=bbsCont]").focus();
        return false;
    }
    if (!com.wise.util.isLength(form.find("[name=bbsCont]").val(), 1, 200)) {
        alert("댓글 내용을 200자 이내로 입력하여 주십시오.");
        form.find("[name=bbsCont]").focus();
        return false;
    }
    
    // if (form.find("[name=userPw]").hasClass("locked")) {
    //     alert("댓글 작성자만 수정할 수 있습니다.");
    //     return false;
    // }
    // if (form.find("[name=userPw]").hasClass("required")) {
    //     if (com.wise.util.isBlank(form.find("[name=userPw]").val() + "]").val())) {
    //         alert("비밀번호를 입력하여 주십시오.");
    //         form.find("[name=userPw]").val() + "]").focus();
    //         return false;
    //     }
    // }
    var id = "password-" + form.find("[name=seq]").val();
    
    if ($("#" + id).hasClass("locked")) {
        alert("댓글 작성자만 수정할 수 있습니다.");
        return false;
    }
    if ($("#" + id).hasClass("required")) {
        if (com.wise.util.isBlank($("#" + id).val())) {
            alert("비밀번호를 입력하여 주십시오.");
            $("#" + id).focus();
            return false;
        }
    }
    
    form.find("[name=bulletIdInfo]").val(encryptByDES($("#" + id).val(), bulletIdInfoKey));
    
    return true;
}

/**
 * 일반 게시판 댓글 삭제 전처리를 실행한다.
 * 
 * @param options {Object} 옵션
 * @returns {Object} 데이터
 */
function beforeDeleteComment(options) {
    var data = {
        // Nothing do do.
    };
    
    if (options.data) {
        data.bbsCd   = options.data.bbsCd   ? options.data.bbsCd          : "";
        data.seq     = options.data.seq     ? options.data.seq.toString() : "";
        data.pSeq    = options.data.pSeq    ? options.data.pSeq           : "";
        data.lockTag = options.data.lockTag ? options.data.lockTag        : "";
    }
    
    if (com.wise.util.isBlank(data.bbsCd)) {
        return null;
    }
    if (com.wise.util.isBlank(data.seq)) {
        return null;
    }
    
    var id = "password-" + data.seq;
    
    if ($("#" + id).hasClass("locked")) {
        alert("댓글 작성자만 삭제할 수 있습니다.");
        return null;
    }
    if ($("#" + id).hasClass("required")) {
        if (com.wise.util.isBlank($("#" + id).val())) {
            alert("비밀번호를 입력하여 주십시오.");
            $("#" + id).focus();
            return null;
        }
        
        data.bulletIdInfo = encryptByDES($("#" + id).val(), bulletIdInfoKey);
    }
    
    if (!confirm("댓글을 삭제하시겠습니까?")) {
        return null;
    }
    
    return data;
}

/**
 * 일반 게시판 댓글 비밀번호 확인 전처리를 실행한다.
 * 
 * @param data {Object} 데이터
 */
function beforeVerifyCommentPassword(data) {
    return function(options) {
        return {
            bbsCd:data.bbsCd,
            seq:data.seq,
            bulletIdInfo:encryptByDES($("#password-" + data.seq).val(), bulletIdInfoKey)
        };
    };
}

////////////////////////////////////////////////////////////////////////////////
// 후처리 함수
////////////////////////////////////////////////////////////////////////////////
/**
 * 일반 게시판 내용 조회 후처리를 실행한다.
 * 
 * @param data {Object} 데이터
 */
function afterSelectBoard(data) {
    var form = $("#board-select-form");

    form.find("[name=bbsCd]").val(data.bbsCd);
    form.find("[name=seq]").val(data.seq);
    form.find("[name=listSubCd]").val(data.listSubCd ? data.listSubCd : "");
    form.find("[name=bbsTit]").val(data.bbsTit);
    
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
                attacher:"board-attach-sect",
                url:resolveUrl("/downloadAttachFile.do"),
                target:"global-process-iframe"
            });
        }
    }
    
    if (data.lockTag != "Y" && data.ansState == "RW") {
        $("#board-update-button").removeClass("hide");
        $("#board-delete-button").removeClass("hide");
        
        // 일반 게시판 내용 수정 버튼에 클릭 이벤트를 바인딩한다.
        $("#board-update-button").bind("click", {
            lockTag:data.lockTag
        }, function(event) {
            // 일반 게시판 내용을 수정한다.
            updateBoard(event.data);
            return false;
        });
        
        // 일반 게시판 내용 수정 버튼에 키다운 이벤트를 바인딩한다.
        $("#board-update-button").bind("keydown", {
            lockTag:data.lockTag
        }, function(event) {
            if (event.which == 13) {
                // 일반 게시판 내용을 수정한다.
                updateBoard(event.data);
                return false;
            }
        });
        
        // 일반 게시판 내용 삭제 버튼에 클릭 이벤트를 바인딩한다.
        $("#board-delete-button").bind("click", {
            lockTag:data.lockTag
        }, function(event) {
            // 일반 게시판 내용을 삭제한다.
            deleteBoard(event.data);
            return false;
        });
        
        // 일반 게시판 내용 삭제 버튼에 키다운 이벤트를 바인딩한다.
        $("#board-delete-button").bind("keydown", {
            lockTag:data.lockTag
        }, function(event) {
            if (event.which == 13) { 
                // 일반 게시판 내용을 삭제한다.
                deleteBoard(event.data);
                return false;
            }
        });
    }
    
    /*setTimeout(function() {$(".trc_rbox_container").remove();}, 2000);*/
}

/**
 * 일반 게시판 내용 삭제 후처리를 실행한다.
 * 
 * @param messages {Object} 메시지
 */
function afterDeleteBoard(messages) {
    // 일반 게시판 내용을 검색한다.
    searchBoard();
}

/**
 * 일반 게시판 댓글 검색 후처리를 실행한다.
 * 
 * @param data {Array} 데이터
 */
function afterSearchComment(data) {
    $("#board-select-form .ansCnt").text(data.length);
    $("#comment-insert-form .ansCnt").text(data.length);
    
    var list = $("#comment-data-list");
    
    list.find("li").each(function(index, element) {
        $(this).remove();
    });
    
    for (var i = 0; i < data.length; i++) {
        var item = $(templates.data);
        
        item.find(".userNm").text(data[i].userNm ? data[i].userNm : "손님");
        item.find(".userDttm").text(data[i].userDttm);
        item.find(".bbsCont").text(data[i].bbsCont ? data[i].bbsCont.replace(/\r/g, "") : "");
        
        item.find(".comment-password-sect label").attr("for", "password-" + data[i].seq);
        item.find(".comment-password-sect input").attr("id",  "password-" + data[i].seq);
        
        switch (data[i].lockTag) {
            case "Y":
                item.find(".comment-password-sect input").addClass("locked");
                break;
            case "N":
                item.find(".comment-password-sect input").addClass("disabled");
                break;
            case "P":
                item.find(".comment-password-sect input").addClass("required");
                break;
        }
        
        if (data[i].lockTag != "Y" && data[i].ansState == "RW") {
            // item.find(".comment-button-sect").removeClass("hide");
            switch (data[i].lockTag) {
                case "N":
                    item.find(".comment-button-sect").removeClass("hide");
                    break;
                case "P":
                    item.find(".comment-button-sect").removeClass("hide");
                    item.find(".comment-password-sect").removeClass("hide");
                    break;
            }
            
            // 일반 게시판 댓글 수정 버튼에 클릭 이벤트를 바인딩한다.
            item.find(".comment-update-button").bind("click", {
                bbsCd:data[i].bbsCd,
                seq:data[i].seq,
                pSeq:data[i].pSeq,
                listSubCd:data[i].listSubCd,
                bbsTit:data[i].bbsTit,
                bbsCont:data[i].bbsCont,
                lockTag:data[i].lockTag
            }, function(event) {
                // // 일반 게시판 댓글을 조회한다.
                // selectComment(event.data);
                // 일반 게시판 댓글 비밀번호를 확인한다.
                verifyCommentPassword(this, event.data);
                return false;
            });
            
            // 일반 게시판 댓글 수정 버튼에 키다운 이벤트를 바인딩한다.
            item.find(".comment-update-button").bind("keydown", {
                bbsCd:data[i].bbsCd,
                seq:data[i].seq,
                pSeq:data[i].pSeq,
                listSubCd:data[i].listSubCd,
                bbsTit:data[i].bbsTit,
                bbsCont:data[i].bbsCont,
                lockTag:data[i].lockTag
            }, function(event) {
                if (event.which == 13) {
                    // // 일반 게시판 댓글을 조회한다.
                    // selectComment(event.data);
                    // 일반 게시판 댓글 비밀번호를 확인한다.
                    verifyCommentPassword(this, event.data);
                    return false;
                }
            });
            
            // 일반 게시판 댓글 삭제 버튼에 클릭 이벤트를 바인딩한다.
            item.find(".comment-delete-button").bind("click", {
                bbsCd:data[i].bbsCd,
                seq:data[i].seq,
                pSeq:data[i].pSeq,
                lockTag:data[i].lockTag
            }, function(event) {
                // // 일반 게시판 댓글을 삭제한다.
                // deleteComment(event.data);
                // 일반 게시판 댓글 비밀번호를 확인한다.
                verifyCommentPassword(this, event.data);
                return false;
            });
            
            // 일반 게시판 댓글 삭제 버튼에 키다운 이벤트를 바인딩한다.
            item.find(".comment-delete-button").bind("keydown", {
                bbsCd:data[i].bbsCd,
                seq:data[i].seq,
                pSeq:data[i].pSeq,
                lockTag:data[i].lockTag
            }, function(event) {
                if (event.which == 13) {
                    // // 일반 게시판 댓글을 삭제한다.
                    // deleteComment(event.data);
                    // 일반 게시판 댓글 비밀번호를 확인한다.
                    verifyCommentPassword(this, event.data);
                    return false;
                }
            });
        }
        
        list.append(item);
    }
    
    if (data.length == 0) {
        var item = $(templates.none);
        
        list.append(item);
    }
}

/**
 * 일반 게시판 댓글 등록 후처리를 실행한다.
 * 
 * @param messages {Object} 메시지
 */
function afterInsertComment(messages) {
    // 일반 게시판 댓글을 조회한다.
    selectComment({
        // Nothing to do.
    });
    
    // 일반 게시판 댓글을 검색한다.
    searchComment();
}

/**
 * 일반 게시판 댓글 수정 후처리를 실행한다.
 * 
 * @param messages {Object} 메시지
 */
function afterUpdateComment(messages) {
    // 일반 게시판 댓글을 조회한다.
    selectComment({
        // Nothing to do.
    });
    
    // 일반 게시판 댓글을 검색한다.
    searchComment();
}

/**
 * 일반 게시판 댓글 삭제 후처리를 실행한다.
 * 
 * @param messages {Object} 메시지
 */
function afterDeleteComment(messages) {
    // 일반 게시판 댓글을 조회한다.
    selectComment({
        // Nothing to do.
    });
    
    // 일반 게시판 댓글을 검색한다.
    searchComment();
}

/**
 * 일반 게시판 댓글 비밀번호를 확인 후처리를 실행한다.
 * 
 * @param button {Element} 버튼
 * @param data {Object} 데이터
 */
function afterVerifyCommentPassword(button, data) {
    return function(message) {
        if (message.matched == "true") {
            if ($(button).hasClass("comment-update-button")) {
                // 일반 게시판 댓글을 조회한다.
                selectComment(data);
            }
            else {
                // 일반 게시판 댓글을 삭제한다.
                deleteComment(data);
            }
        }
        else {
            alert("비밀번호가 일치하지 않습니다.");
            $("#password-" + data.seq).focus();
        }
    };
}

/**
 * 라이브리 댓글 추가 실행한다.
 * 
 * @param button {Element} 버튼
 * @param data {Object} 데이터
 */
//(function(d, s) {
//    var j, e = d.getElementsByTagName(s)[0];
//
//    if (typeof LivereTower === 'function') { return; }
//
//    j = d.createElement(s);
//    j.src = 'https://cdn-city.livere.com/js/embed.dist.js';
//    j.async = true;
//
//    e.parentNode.insertBefore(j, e);
//})(document, 'script');

////////////////////////////////////////////////////////////////////////////////
// 이벤트 함수
////////////////////////////////////////////////////////////////////////////////