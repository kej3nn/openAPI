/*
 * @(#)insertIdea.js 1.0 2015/06/15
 * 
 * COPYRIGHT (C) 2013 WISEITECH CO., LTD. ALL RIGHTS RESERVED.
 */

/**
 * 이벤트 게시판 내용을 등록하는 스크립트이다.
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
    // 파일을 생성한다.
    createFile({
        mode:"insert",
        attach:"atchFile",
        uploader:"idea-upload-list",
        attacher:"idea-upload-list"
    });
}

/**
 * 마스크를 바인딩한다.
 */
function bindMask() {
    
}

/**
 * 이벤트를 바인딩한다.
 */
function bindEvent() {
    // 이벤트 게시판 내용 등록 폼에 제출 이벤트를 바인딩한다.
    $("#idea-insert-form").bind("submit", function(event) {
        return false;
    });
    
    $(".idea-insert-button").each(function(index, element) {
        // 이벤트 응모하기 및 이벤트 참여 완료 버튼에 클릭 이벤트를 바인딩한다.
        $(this).bind("click", function(event) {
            // 이벤트 게시판 내용을 등록한다.
            insertIdea(this);
            return false;
        });
        
        // 이벤트 응모하기 및 이벤트 참여 완료 버튼에 키다운 이벤트를 바인딩한다.
        $(this).bind("keydown", function(event) {
            if (event.which == 13) {
                // 이벤트 게시판 내용을 등록한다.
                insertIdea(this);
                return false;
            }
        });
    });
    
    $(".idea-confirm-button, .idea-close-button").each(function(index, element) {
        // 확인 및 닫기 버튼에 클릭 이벤트를 바인딩한다.
        $(this).bind("click", function(event) {
            // 윈도우를 닫는다.
            location.href = com.wise.help.url("/portal/mainPage.do");
            return false;
        });
        
        // 확인 및 닫기 버튼에 키다운 이벤트를 바인딩한다.
        $(this).bind("keydown", function(event) {
            if (event.which == 13) {
                // 윈도우를 닫는다.
            	location.href = com.wise.help.url("/portal/mainPage.do");
                return false;
            }
        });
    });
}

/**
 * 옵션을 로드한다.
 */
function loadOptions() {
    // Nothing to do.
}

/**
 * 데이터를 로드한다.
 */
function loadData() {
    // Nothing do do.
}

////////////////////////////////////////////////////////////////////////////////
// 서비스 함수
////////////////////////////////////////////////////////////////////////////////
/**
 * 이벤트 게시판 내용을 등록한다.
 * 
 * @param button {Element} 버튼
 */
function insertIdea(button) {
    if ($(button).hasClass("opened")) {
        // 데이터를 등록한다.
        doInsert({
            url:"/portal/bbs/idea/insertBulletin.do",
            form:"idea-insert-form",
            before:beforeInsertIdea,
            after:afterInsertIdea
        });
    }
    else {
        alert("이벤트 기간이 아닙니다.");
    }
}

////////////////////////////////////////////////////////////////////////////////
// 전처리 함수
////////////////////////////////////////////////////////////////////////////////
/**
 * 이벤트 게시판 내용 등록 전처리를 실행한다.
 * 
 * @param options {Object} 옵션
 * @returns {Object} 데이터
 */
function beforeInsertIdea(options) {
    var form = $("#idea-insert-form");
    
    if (com.wise.util.isBlank(form.find("[name=bbsTit]").val())) {
        alert("제목을 입력하여 주십시오.");
        form.find("[name=bbsTit]").focus();
        return false;
    }
    
    if (form.find("[name=atchFile]").length > 0) {
        var pattern = null;
        var message = null;
        
        if ($("#idea-upload-list").hasClass("IMG")) {
            pattern = /(.)+\.(bmp|gif|ief|jpe|jpeg|jpg|png|tif|tiff)$/gi;
            message = "BMP, GIF, IEF, JPG, PNG, TIF 그림 파일만 첨부할 수 있습니다.";
        }
        else if ($("#idea-upload-list").hasClass("DOC")) {
            pattern = /(.)+\.(doc|docx|hwp|pdf|ppt|pptx|txt|xls|xlsx)$/gi;
            message = "PPT, DOC, XLS, HWP, PDF, TXT 문서 파일만 첨부할 수 있습니다.";
        }
        else {
            pattern = /(.)+\.(bmp|gif|ief|jpe|jpeg|jpg|png|tif|tiff|doc|docx|hwp|pdf|ppt|pptx|txt|xls|xlsx)$/gi;
            message = "BMP, GIF, IEF, JPG, PNG, TIF 그림 파일 또는 PPT, DOC, XLS, HWP, PDF, TXT 문서 파일만 첨부할 수 있습니다.";
        }
        
        var invalid = -1;
        
        form.find("[name=atchFile]").each(function(index, element) {
            if ($(this).val()) {
                if (!pattern.test($(this).val())) {
                    invalid = index;
                    return false;
                }
            }
        });
        
        if (invalid >= 0) {
            alert(message);
            form.find("[name=atchFile]:eq(" + invalid + ")").focus();
            return false;
        }
    }
    
    return true;
}

////////////////////////////////////////////////////////////////////////////////
// 후처리 함수
////////////////////////////////////////////////////////////////////////////////
/**
 * 메시지를 처리한다.
 * 
 * @param messages {Object} 메시지
 * @param options {Object} 옵션
 */
function handleMessage(messages, options) {
    // if (messages.message) {
    //     alert(messages.message);
    // }
    
    options.after(messages);
}

/**
 * 이벤트 게시판 내용 등록 후처리를 실행한다.
 * 
 * @param messages {Object} 메시지
 */
function afterInsertIdea(messages) {
    $("#idea-confirm-sect").addClass("view");
}

////////////////////////////////////////////////////////////////////////////////
// 이벤트 함수
////////////////////////////////////////////////////////////////////////////////