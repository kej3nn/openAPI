/*
 * COPYRIGHT (C) 2013 WISEITECH CO., LTD. ALL RIGHTS RESERVED.
 */

/**
	장홍식
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
        uploader:"qna-upload-list",
        attacher:"qna-upload-list"
    });
}

/**
 * 마스크를 바인딩한다.
 */
function bindMask() {
    // Q&A 게시판 내용 연락처 필드에 숫자 마스크를 바인딩한다.
    $("#qna-update-form [name=userTel1]").setMask({ mask:"999" });
    
    // Q&A 게시판 내용 연락처 필드에 숫자 마스크를 바인딩한다.
    $("#qna-update-form [name=userTel2]").setMask({ mask:"9999" });
    
    // Q&A 게시판 내용 연락처 필드에 숫자 마스크를 바인딩한다.
    $("#qna-update-form [name=userTel3]").setMask({ mask:"9999" });
}

/**
 * 이벤트를 바인딩한다.
 */
function bindEvent() {
    // Q&A 게시판 내용 수정 폼에 제출 이벤트를 바인딩한다.
    $("#qna-update-form").bind("submit", function(event) {
        return false;
    });
    
    // Q&A 게시판 내용 이메일 콤보박스에 변경 이벤트를 바인딩한다.
    $("#qna-update-form [name=userEmail3]").bind("change", function(event) {
        // 사용자 이메일을 변경한다.
        changeUserEmail($(this).val());
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
    
    // Q&A 게시판 내용 확인 버튼에 클릭 이벤트를 바인딩한다.
    $("#qna-update-button").bind("click", function(event) {
        // Q&A 게시판 내용을 수정한다.
        updateQna();
        return false;
    });
    
    // Q&A 게시판 내용 확인 버튼에 키다운 이벤트를 바인딩한다.
    $("#qna-update-button").bind("keydown", function(event) {
        if (event.which == 13) {
            // Q&A 게시판 내용을 수정한다.
            updateQna();
            return false;
        }
    });
    
    // Q&A 게시판 내용 취소 버튼에 클릭 이벤트를 바인딩한다.
    $("#qna-cancel-button").bind("click", function(event) {
        // Q&A 게시판 내용을 취소한다.
        cancelQna();
        return false;
    });
    
    // Q&A 게시판 내용 취소 버튼에 키다운 이벤트를 바인딩한다.
    $("#qna-cancel-button").bind("keydown", function(event) {
        if (event.which == 13) {
            // Q&A 게시판 내용을 취소한다.
            cancelQna();
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
 * Q&A 게시판 내용을 검색한다.
 *
 * @param page {String} 페이지 번호
 */
function searchQna(page) {
    // 데이터를 검색하는 화면으로 이동한다.
    goSearch({
        url:"/portal/myPage/myQnaPage.do",
        form:"qna-search-form",
        data:[{
            name:"page",
            value:page ? page : "1"
        }]
    });
}

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
 */
function updateQna() {
    // 데이터를 수정한다.
    doUpdate({
        url:resolveUrl("/updateBulletin.do"),
        form:"qna-update-form",
        before:beforeUpdateQna,
        after:afterUpdateQna
    });
}

/**
 * Q&A 게시판 내용을 취소한다.
 */
function cancelQna() {
    // 데이터를 조회하는 화면으로 이동한다.
    goSelect({
        url:"/portal/myPage/selectMyQnaPage.do",
        form:"qna-search-form"
    });
}

/**
 * 사용자 이메일을 변경한다.
 * 
 * @param value {String} 값
 */
function changeUserEmail(value) {
    if (value == "na") {
        $("#qna-update-form [name=userEmail2]").prop("readonly", false);
    }
    else {
        $("#qna-update-form [name=userEmail2]").prop("readonly", true).val(value);
    }
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
        alert("수정할 데이터가 없습니다.");
        return null;
    }
    if (com.wise.util.isBlank(data.seq)) {
        alert("수정할 데이터가 없습니다.");
        return null;
    }
    
    return data;
}

/**
 * Q&A 게시판 내용 수정 전처리를 실행한다.
 * 
 * @param options {Object} 옵션
 * @returns {Object} 데이터
 */
function beforeUpdateQna(options) {
    var form = $("#qna-update-form");
    
    if (com.wise.util.isBlank(form.find("[name=bbsCd]").val())) {
        alert("수정할 데이터가 없습니다.");
        return false;
    }
    if (com.wise.util.isBlank(form.find("[name=seq]").val())) {
        alert("수정할 데이터가 없습니다.");
        return false;
    }
    
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
        alert("내용을 입력하여 주십시오.");
        form.find("[name=bbsCont]").focus();
        return false;
    }
    
    if (com.wise.util.isBlank(form.find("[name=userNm]").val())) {
        alert("작성자를 입력하여 주십시오.");
        form.find("[name=userNm]").focus();
        return false;
    }
    // if (!com.wise.util.isBytes(form.find("[name=userNm]").val(), 1, 100)) {
    //     alert("작성자를 100바이트 이내로 입력하여 주십시오.");
    //     form.find("[name=userNm]").focus();
    //     return false;
    // }
    if (!com.wise.util.isLength(form.find("[name=userNm]").val(), 1, 20)) {
        alert("작성자를 20자 이내로 입력하여 주십시오.");
        form.find("[name=userNm]").focus();
        return false;
    }
    
    // if (!form.find("[name=newUserPw]").parent("td").parent("tr").hasClass("hide")) {
    //    if (com.wise.util.isBlank(form.find("[name=newUserPw]").val())) {
    //        alert("비밀번호를 입력하여 주십시오.");
    //        form.find("[name=newUserPw]").focus();
    //        return false;
    //    }
    // }
    
    if (form.find("[name=userTel1]").length > 0) {
        if (form.find("[name=userTel1]").hasClass("required") && com.wise.util.isBlank(form.find("[name=userTel1]").val())) {
            alert("전화번호를 입력하여 주십시오.");
            form.find("[name=userTel1]").focus();
            return false;
        }
    }
    if (form.find("[name=userTel2]").length > 0) {
        if (form.find("[name=userTel2]").hasClass("required") && com.wise.util.isBlank(form.find("[name=userTel2]").val())) {
            alert("전화번호를 입력하여 주십시오.");
            form.find("[name=userTel2]").focus();
            return false;
        }
    }
    if (form.find("[name=userTel3]").length > 0) {
        if (form.find("[name=userTel3]").hasClass("required") && com.wise.util.isBlank(form.find("[name=userTel3]").val())) {
            alert("전화번호를 입력하여 주십시오.");
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
    
    if (form.find("[name=atchFile]").length > 0) {
        var pattern = null;
        var message = null;
        
        if ($("#board-upload-list").hasClass("IMG")) {
            pattern = /(.)+\.(bmp|gif|ief|jpe|jpeg|jpg|png|tif|tiff)$/;
            message = "BMP, GIF, IEF, JPG, PNG, TIF 그림 파일만 첨부할 수 있습니다.";
        }
        else if ($("#board-upload-list").hasClass("DOC")) {
            pattern = /(.)+\.(doc|docx|hwp|pdf|ppt|pptx|txt|xls|xlsx)$/;
            message = "PPT, DOC, XLS, HWP, PDF, TXT 문서 파일만 첨부할 수 있습니다.";
        }
        else {
            pattern = /(.)+\.(bmp|gif|ief|jpe|jpeg|jpg|png|tif|tiff|doc|docx|hwp|pdf|ppt|pptx|txt|xls|xlsx)$/;
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
    
    // if (com.wise.util.isBlank(form.find("[name=secuCd]").val())) {
    //     alert("보안코드를 입력하여 주십시오.");
    //     form.find("[name=secuCd]").focus();
    //     return false;
    // }
    
    // if (!form.find("[name=agreeYn]").is(":checked")) {
    //     alert("개인정보 수집 및 이용에 동의하여 주십시오.");
    //     form.find("[name=agreeYn]").focus();
    //     return false;
    // }
    
    return true;
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
    for (var key in data) {
        var value = data[key] ? data[key] : "";
        
        $("#qna-update-form").find("." + key).each(function(index, element) {
            switch ($(this).prop("tagName").toLowerCase()) {
                case "input":
                    switch ($(this).attr("type")) {
                        case "hidden":
                        case "text":
                        case "tel":
                        case "email":
                            $(this).val(value);
                            break;
                        case "checkbox":
                        case "radio":
                            if ($(this).val() == value) {
                                $(this).prop("checked", true);
                            }
                            break;
                    }
                    break;
                case "select":
                    switch (key) {
                        // case "userTel1":
                        //     // 일반 게시판 내용 연락처 콤보 옵션을 로드한다.
                        //     loadComboOptions("telephone", "/portal/common/code/searchCommCode.do", {
                        //         grpCd:"C1015",
                        //         defaultCode:"",
                        //         defaultName:"선택"
                        //     }, value);
                        //     break;
                        case "userEmail3":
                            // 일반 게시판 내용 이메일 콤보 옵션을 로드한다.
                            loadComboOptions("eMail_3", "/portal/common/code/searchCommCode.do", {
                                grpCd:"C1009"
                            }, value);
                            
                            // 사용자 이메일을 변경한다.
                            changeUserEmail(value);
                            break;
                        default:
                            $(this).val(value);
                            break;
                    }
                    break;
                case "textarea":
                    $(this).val(value);
                    break;
            }
        });
    }
    
    if (data.fileCnt) {
        if (data.files) {
            // 파일을 처리한다.
            handleFiles(data.files, {
                mode:"update",
                attacher:"qna-attach-list",
                form:"qna-update-form",
                detach:"dtchFile"
            });
        }
    }
    
    if (data.lockTag == 'P') {
        $("#qna-update-form [name=newUserPw]").parent("td").parent("tr").removeClass("hide");
    }
}

/**
 * Q&A 게시판 내용 수정 후처리를 실행한다.
 * 
 * @param qnas {Object} Q&A
 */
function afterUpdateQna(qnas) {
    // Q&A 게시판 내용을 취소한다.
    cancelQna();
}

////////////////////////////////////////////////////////////////////////////////
// 이벤트 함수
////////////////////////////////////////////////////////////////////////////////