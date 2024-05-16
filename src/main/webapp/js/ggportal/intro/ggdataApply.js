/*
 * COPYRIGHT (C) 2013 WISEITECH CO., LTD. ALL RIGHTS RESERVED.
 */

/**
	장홍식
 */
$(function() {
	

    bindEvent();
	
});

function bindEvent() {

	$("#apply-insert-form").bind("submit", function(event) {
        return false;
    });
    
    $("#apply-insert-form [name=userEmail3]").bind("change", function(event) {
        changeUserEmail($(this).val());
    });

    $("#apply-insert-btn").bind("click", function(event) {
        insertApply();
        return false;
    });
    
    $("#apply-insert-btn").bind("keydown", function(event) {
        if (event.which == 13) {
        	insertApply();
            return false;
        }
    });
    
    $('#emailAgree').change(function() {
    	if($(this).is(':checked')) {
    		$('[name=emailYn]').val('Y');
    	} else {
    		$('[name=emailYn]').val('N');
    	}
    });
}

/**
 * 사용자 이메일을 변경한다.
 * 
 * @param value {String} 값
 */
function changeUserEmail(value) {
    if (value == "na") {
        $("#apply-insert-form [name=userEmail2]").prop("readonly", false);
    }
    else {
        $("#apply-insert-form [name=userEmail2]").prop("readonly", true).val(value);
    }
}

/**
 * 등록
 */
function insertApply() {
    // 데이터를 등록한다.
    doInsert({
        url:"/portal/intro/apply/insertApplyData.do",
        form:"apply-insert-form",
        before:beforeInsertApply,
        after:afterInsertApply
    });
}

function beforeInsertApply() {
    var form = $("#apply-insert-form");

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

    if (com.wise.util.isBlank(form.find("[name=userNm]").val())) {
        alert("이름을 입력하여 주십시오.");
        form.find("[name=userNm]").focus();
        return false;
    }
    // if (!com.wise.util.isBytes(form.find("[name=userNm]").val(), 1, 100)) {
    //     alert("이름을 100바이트 이내로 입력하여 주십시오.");
    //     form.find("[name=userNm]").focus();
    //     return false;
    // }
    if (!com.wise.util.isLength(form.find("[name=userNm]").val(), 1, 20)) {
        alert("이름을 20자 이내로 입력하여 주십시오.");
        form.find("[name=userNm]").focus();
        return false;
    }

    if (form.find("[name=userEmail1]").length > 0) {
        if (com.wise.util.isBlank(form.find("[name=userEmail1]").val())) {
            alert("이메일을 입력하여 주십시오.");
            form.find("[name=userEmail1]").focus();
            return false;
        }
    }
    if (form.find("[name=userEmail2]").length > 0) {
        if (com.wise.util.isBlank(form.find("[name=userEmail2]").val())) {
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
    return true;
}

function afterInsertApply() {
	location.href="/portal/intro/apply/selectApplyPage.do";
}
