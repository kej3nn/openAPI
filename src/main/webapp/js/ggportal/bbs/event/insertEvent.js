/*
 * @(#)insertEvent.js 1.0 2015/06/15
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
    document.title = "국회홈페이지 옥에 티 이벤트";
    // 파일을 생성한다.
    createFile({
        mode:"insert",
        attach:"atchFile",
        uploader:"event-upload-list",
        attacher:"event-upload-list"
    });
}

/**
 * 마스크를 바인딩한다.
 */
function bindMask() {
    // 이벤트 게시판 내용 연락처 필드에 숫자 마스크를 바인딩한다.
    $("#event-insert-form [name=userTel1]").setMask({ mask:"999" });

    // 이벤트 게시판 내용 연락처 필드에 숫자 마스크를 바인딩한다.
    $("#event-insert-form [name=userTel2]").setMask({ mask:"9999" });

    // 이벤트 게시판 내용 연락처 필드에 숫자 마스크를 바인딩한다.
    $("#event-insert-form [name=userTel3]").setMask({ mask:"9999" });
}

/**
 * 이벤트를 바인딩한다.
 */
function bindEvent() {
    // 이벤트 게시판 내용 등록 폼에 제출 이벤트를 바인딩한다.
    $("#event-insert-form").bind("submit", function(event) {
        return false;
    });

    // 일반 게시판 내용 이메일 콤보박스에 변경 이벤트를 바인딩한다.
    $("#event-insert-form [name=userEmail3]").bind("change", function(event) {
        // 사용자 이메일을 변경한다.
        changeUserEmail($(this).val());
    });

    $(".event-insert-button").each(function(index, element) {
        // 이벤트 응모하기 및 이벤트 참여 완료 버튼에 클릭 이벤트를 바인딩한다.
        $(this).bind("click", function(event) {
            // 이벤트 게시판 내용을 등록한다.
            insertEvent(this);
            return false;
        });

        // 이벤트 응모하기 및 이벤트 참여 완료 버튼에 키다운 이벤트를 바인딩한다.
        $(this).bind("keydown", function(event) {
            if (event.which == 13) {
                // 이벤트 게시판 내용을 등록한다.
                insertEvent(this);
                return false;
            }
        });
    });

    $(".event-confirm-button, .event-close-button").each(function(index, element) {
        // 확인 및 닫기 버튼에 클릭 이벤트를 바인딩한다.
        $(this).bind("click", function(event) {
            // 윈도우를 닫는다.
            location.href = com.wise.help.url("https://www.assembly.go.kr/portal/main/main.do");
            return false;
        });

        // 확인 및 닫기 버튼에 키다운 이벤트를 바인딩한다.
        $(this).bind("keydown", function(event) {
            if (event.which == 13) {
                // 윈도우를 닫는다.
                location.href = com.wise.help.url("https://www.assembly.go.kr/portal/main/main.do");
                return false;
            }
        });
    });
}

/**
 * 옵션을 로드한다.
 */
function loadOptions() {
    // 일반 게시판 내용 이메일 콤보 옵션을 로드한다.
    loadComboOptions("eMail_3", "/portal/common/code/searchCommCode.do", {
        grpCd:"C1009"
    }, "na");
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
function insertEvent(button) {
    if ($(button).hasClass("opened")) {
        // 데이터를 등록한다.
        doInsert({
            url:"/portal/etc/event/insertBulletin.do",
            form:"event-insert-form",
            before:beforeInsertEvent,
            after:afterInsertEvent
        });
    }
    else {
        alert("이벤트 기간이 아닙니다.");
    }
}

/**
 * 사용자 이메일을 변경한다.
 *
 * @param value {String} 값
 */
function changeUserEmail(value) {
    if (value == "na") {
        $("#event-insert-form [name=userEmail2]").prop("readonly", false);
    }
    else {
        $("#event-insert-form [name=userEmail2]").prop("readonly", true).val(value);
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
function beforeInsertEvent(options) {
    var form = $("#event-insert-form");

    if (form.find("[name=listSubCd]").length > 0) {
        if (com.wise.util.isBlank(form.find("[name=listSubCd]").val())) {
            alert("분류를 선택하여 주십시오.");
            form.find("[name=listSubCd]").focus();
            return false;
        }
    }

    if (com.wise.util.isBlank(form.find("[name=bbsTit]").val())) {
        alert("제목을 입력하여 주십시오.");
        form.find("[name=bbsTit]").focus();
        return false;
    }
    // if (!com.wise.util.isBytes(form.find("[name=bbsTit]").val(), 1, 500)) {
    //     alert("제목을 500바이트 이내로 입력하여 주십시오.");
    //     form.find("[name=bbsTit]").focus();
    //     return false;
    // }
    if (!com.wise.util.isLength(form.find("[name=bbsTit]").val(), 1, 100)) {
        alert("제목을 100자 이내로 입력하여 주십시오.");
        form.find("[name=bbsTit]").focus();
        return false;
    }

    if (com.wise.util.isBlank(form.find("[name=bbsCont]").val())) {
        alert("제보 내용을 입력하여 주십시오.");
        form.find("[name=bbsCont]").focus();
        return false;
    }

    if (form.find("[name=atchFile]").length > 0) {
        var pattern = null;
        var message = null;

        if ($("#event-upload-list").hasClass("IMG")) {
            pattern = /(.)+\.(bmp|gif|ief|jpe|jpeg|jpg|png|tif|tiff)$/gi;
            message = "BMP, GIF, IEF, JPG, PNG, TIF 그림 파일만 첨부할 수 있습니다.";
        }
        else if ($("#event-upload-list").hasClass("DOC")) {
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

    if (com.wise.util.isBlank(form.find("[name=userNm]").val())) {
        alert("성명을 입력하여 주십시오.");
        form.find("[name=userNm]").focus();
        return false;
    }
    // if (!com.wise.util.isBytes(form.find("[name=userNm]").val(), 1, 100)) {
    //     alert("성명을 100바이트 이내로 입력하여 주십시오.");
    //     form.find("[name=userNm]").focus();
    //     return false;
    // }
    if (!com.wise.util.isLength(form.find("[name=userNm]").val(), 1, 20)) {
        alert("성명을 20자 이내로 입력하여 주십시오.");
        form.find("[name=userNm]").focus();
        return false;
    }

    if (form.find("[name=userTel1]").length > 0) {
        if (form.find("[name=userTel1]").hasClass("required") && com.wise.util.isBlank(form.find("[name=userTel1]").val())) {
            alert("휴대폰 번호를 입력하여 주십시오.");
            form.find("[name=userTel1]").focus();
            return false;
        }
    }
    if (form.find("[name=userTel2]").length > 0) {
        if (form.find("[name=userTel2]").hasClass("required") && com.wise.util.isBlank(form.find("[name=userTel2]").val())) {
            alert("휴대폰 번호를 입력하여 주십시오.");
            form.find("[name=userTel2]").focus();
            return false;
        }
    }
    if (form.find("[name=userTel3]").length > 0) {
        if (form.find("[name=userTel3]").hasClass("required") && com.wise.util.isBlank(form.find("[name=userTel3]").val())) {
            alert("휴대폰 번호를 입력하여 주십시오.");
            form.find("[name=userTel3]").focus();
            return false;
        }
    }

    if (form.find("[name=userEmail1]").length > 0) {
        if (form.find("[name=userEmail1]").hasClass("required") && com.wise.util.isBlank(form.find("[name=userEmail1]").val())) {
            alert("이메일을 입력하여 주십시오.");
            form.find("[name=userEmail1]").focus();
            return false;
        }
    }
    if (form.find("[name=userEmail2]").length > 0) {
        if (form.find("[name=userEmail2]").hasClass("required") && com.wise.util.isBlank(form.find("[name=userEmail2]").val())) {
            alert("이메일을 입력하여 주십시오.");
            form.find("[name=userEmail2]").focus();
            return false;
        }
    }
    if (form.find("[name=userEmail3]").length > 0) {
        var email = form.find("[name=userEmail1]").val() + "@" + form.find("[name=userEmail2]").val();

        if (email.length > 1 && !com.wise.util.isEmail(email)) {
            alert("이메일 헝식이 아닙니다.");
            form.find("[name=userEmail1]").focus();
            return false;
        }
    }

    if (!form.find("[id=agree]").is(":checked")) {
        alert("개인정보 수집 및 이용에 동의하여 주십시오.");
        form.find("[id=agree]").focus();
        return false;
    }

    if($("input[name=list1SubCd]:checked").length < 1) {
        $("#inworkYn_Y").attr("disabled",true);
    } else {
        $("#inworkYn_N").attr("disabled",true);
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
function afterInsertEvent(messages) {
    $("#event-confirm-sect").addClass("view");
}

////////////////////////////////////////////////////////////////////////////////
// 이벤트 함수
////////////////////////////////////////////////////////////////////////////////