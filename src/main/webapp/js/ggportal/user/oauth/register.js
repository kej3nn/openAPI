/*
 * @(#)register.js 1.0 2015/06/15
 * 
 * COPYRIGHT (C) 2013 WISEITECH CO., LTD. ALL RIGHTS RESERVED.
 */

/**
 * 사용자를 등록하는 스크립트이다.
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
    // // 사용자 이메일을 설정한다.
    // setUserEmail();
    
    // // 사용자 연락처를 설정한다.
    // setUserPhone();
}

/**
 * 마스크를 바인딩한다.
 */
function bindMask() {
    // // 사용자 등록 연락처 필드에 숫자 마스크를 바인딩한다.
    // $("#oauth-insert-form [name=userTel1]").setMask({ mask:"999" });
    
    // // 사용자 등록 연락처 필드에 숫자 마스크를 바인딩한다.
    // $("#oauth-insert-form [name=userTel2]").setMask({ mask:"9999" });
    
    // // 사용자 등록 연락처 필드에 숫자 마스크를 바인딩한다.
    // $("#oauth-insert-form [name=userTel3]").setMask({ mask:"9999" });
}

/**
 * 이벤트를 바인딩한다.
 */
function bindEvent() {
    // 사용자 등록 폼에 제출 이벤트를 바인딩한다.
    $("#oauth-insert-form").bind("submit", function(event) {
        return false;
    });
    
    // // 사용자 등록 이메일 콤보박스에 변경 이벤트를 바인딩한다.
    // $("#oauth-insert-form [name=userEmail3]").bind("change", function(event) {
    //     // 사용자 이메일을 변경한다.
    //     changeUserEmail($(this).val());
    // });
    
    // 사용자 등록 저장하기 버튼에 클릭 이벤트를 바인딩한다.
    $("#oauth-insert-button").bind("click", function(event) {
        // 사용자를 등록한다.
        insertUser();
        return false;
    });
    
    // 사용자 등록 저장하기 버튼에 키다운 이벤트를 바인딩한다.
    $("#oauth-insert-button").bind("keydown", function(event) {
        if (event.which == 13) {
            // 사용자를 등록한다.
            insertUser();
            return false;
        }
    });
    
    // 사용자 등록 취소하기 버튼에 클릭 이벤트를 바인딩한다.
    $("#oauth-cancel-button").bind("click", function(event) {
        // 사용자를 취소한다.
        cancelUser();
        return false;
    });
    
    // 사용자 등록 취소하기 버튼에 키다운 이벤트를 바인딩한다.
    $("#oauth-cancel-button").bind("keydown", function(event) {
        if (event.which) {
            // 사용자를 취소한다.
            cancelUser();
            return false;
        }
    });
}

/**
 * 옵션을 로드한다.
 */
function loadOptions() {
    // // 사용자 등록 연락처 콤보 옵션을 로드한다.
    // loadComboOptions("telephone", "/portal/common/code/searchCommCode.do", {
    //     grpCd:"C1015",
    //     defaultCode:"",
    //     defaultName:"선택"
    // }, "");
    
    // // 사용자 등록 이메일 콤보 옵션을 로드한다.
    // loadComboOptions("eMail_3", "/portal/common/code/searchCommCode.do", {
    //     grpCd:"C1009"
    // }, "na");
}

/**
 * 데이터를 로드한다.
 */
function loadData() {
    // Nothing to do.
}

////////////////////////////////////////////////////////////////////////////////
// 서비스 함수
////////////////////////////////////////////////////////////////////////////////
/**
 * 사용자를 등록한다.
 */
function insertUser() {
    // 데이터를 등록한다.
    doInsert({
        url:"/portal/user/oauth/register.do",
        form:"oauth-insert-form",
        before:beforeInsertUser,
        after:afterInsertUser
    });
}

/**
 * 사용자를 취소한다.
 */
function cancelUser() {
    $("#global-request-form").submit();
}

// /**
//  * 사용자 이메일을 설정한다.
//  */
// function setUserEmail() {
//     var form = $("#oauth-insert-form");
//     
//     var email = form.find("[name=userEmail]").val();
//     
//     if (!com.wise.util.isBlank(email)) {
//         var tokens = email.split("@");
//         
//         form.find("[name=userEmail1]").prop("readonly", true).val(tokens[0]);
//         form.find("[name=userEmail2]").prop("readonly", true).val(tokens[1]);
//         form.find("[name=userEmail3]").prop("disabled", true);
//     }
// }

// /**
//  * 사용자 이메일을 변경한다.
//  * 
//  * @param value {String} 값
//  */
// function changeUserEmail(value) {
//     if (value == "na") {
//         $("#oauth-insert-form [name=userEmail2]").prop("readonly", false);
//     }
//     else {
//         $("#oauth-insert-form [name=userEmail2]").prop("readonly", true).val(value);
//     }
// }

// /**
//  * 사용자 연락처를 설정한다.
//  */
// function setUserPhone() {
//     var form = $("#oauth-insert-form");
//     
//     var phone = form.find("[name=userTel]").val();
//     
//     if (!com.wise.util.isBlank(phone)) {
//         var tokens = phone.split("-");
//         
//         form.find("[name=userTel1]").val(tokens[0]);
//         form.find("[name=userTel2]").val(tokens[1]);
//         form.find("[name=userTel3]").val(tokens[2]);
//     }
// }

////////////////////////////////////////////////////////////////////////////////
// 전처리 함수
////////////////////////////////////////////////////////////////////////////////
/**
 * 사용자 등록 전처리를 실행한다.
 * 
 * @param options {Object} 옵션
 * @returns {Object} 데이터
 */
function beforeInsertUser(options) {
    var form = $("#oauth-insert-form");
    
    if (com.wise.util.isBlank(form.find("[name=providerName]").val())) {
        alert("인증 제공자가 없습니다.");
        return false;
    }
    
    if (com.wise.util.isBlank(form.find("[name=contSiteCd]").val())) {
        alert("인증 제공자가 없습니다.");
        return false;
    }
    
    if (com.wise.util.isBlank(form.find("[name=userId]").val())) {
        alert("사용자 아이디가 없습니다.");
        return false;
    }
    
    if (com.wise.util.isBlank(form.find("[name=userNm]").val())) {
        alert("닉네임을 입력하여 주십시오.");
        form.find("[name=userNm]").focus();
        return false;
    }
    // if (!com.wise.util.isBytes(form.find("[name=userNm]").val(), 1, 100)) {
    //     alert("닉네임을 100바이트 이내로 입력하여 주십시오.");
    //     form.find("[name=userNm]").focus();
    //     return false;
    // }
    if (!com.wise.util.isLength(form.find("[name=userNm]").val(), 1, 20)) {
        alert("닉네임을 20자 이내로 입력하여 주십시오.");
        form.find("[name=userNm]").focus();
        return false;
    }
    
    // if (com.wise.util.isBlank(form.find("[name=userEmail1]").val())) {
    //     alert("이메일을 입력하여 주십시오.");
    //     form.find("[name=userEmail1]").focus();
    //     return false;
    // }
    // if (com.wise.util.isBlank(form.find("[name=userEmail2]").val())) {
    //     alert("이메일을 입력하여 주십시오.");
    //     form.find("[name=userEmail2]").focus();
    //     return false;
    // }
    
    // var email = form.find("[name=userEmail1]").val() + "@" + form.find("[name=userEmail2]").val();
    
    // if (!com.wise.util.isEmail(email)) {
    //     alert("이메일 헝식이 아닙니다.");
    //     form.find("[name=userEmail1]").focus();
    //     return false;
    // }
    
    if (!form.find("[name=agree1Yn]").is(":checked")) {
        alert("개인정보 이용약관에 동의하여 주십시오.");
        form.find("[name=agree1Yn]").focus();
        return false;
    }
    
    if (!form.find("[name=agree2Yn]").is(":checked")) {
        alert("서비스 이용약관에 동의하여 주십시오.");
        form.find("[name=agree2Yn]").focus();
        return false;
    }
    
    return true;
}

////////////////////////////////////////////////////////////////////////////////
// 후처리 함수
////////////////////////////////////////////////////////////////////////////////
/**
 * 사용자 등록 후처리를 실행한다.
 * 
 * @param messages {Object} 메시지
 */
function afterInsertUser(messages) {
    $("#global-request-form").submit();
}

////////////////////////////////////////////////////////////////////////////////
// 이벤트 함수
////////////////////////////////////////////////////////////////////////////////