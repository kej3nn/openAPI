/*
 * COPYRIGHT (C) 2013 WISEITECH CO., LTD. ALL RIGHTS RESERVED.
 */

/**
	장홍식
 */
$(function() {
	
	bindMask();
	
	bindEvent();

    // 옵션을 로드한다.
    loadOptions();
    
    // 데이터를 로드한다.
    loadData();
});


/**
 * 마스크를 바인딩한다.
 */
function bindMask() {
	$("[name=userTel1]").setMask({ mask:"999" });
    $("[name=userTel2]").setMask({ mask:"9999" });
    $("[name=userTel3]").setMask({ mask:"9999" });
}

function bindEvent() {
	
	$('#emailAgree').change(function() {
		if($(this).is(':checked')) {
    		$('[name=emailYn]').val('Y');
    	} else {
    		$('[name=emailYn]').val('N');
    	}
	});

    $("[name=userEmail3]").bind("change", function(event) {
        changeUserEmail($(this).val());
        return false;
    });
    
	$('#userinfo-update-btn').bind("click", function() {
		updateUserInfo();
		return false;
	});
	
	$('#userinfo-delete-btn').bind("click", function() {
		deleteUserInfo();
		return false;
	});
	
}

/**
 * 옵션을 로드한다.
 */
function loadOptions() {
    
    loadComboOptions("eMail_3", "/portal/common/code/searchCommCode.do", {
        grpCd:"C1009"
    }, "na");
}


function loadData() {
	
	selectUserInfo();
	
}

function selectUserInfo() {
    doSelect({
        url:"/portal/myPage/selectUserInfo.do",
        before:function(){return{};},
        after:afterSelectUserInfo
    });
}

function updateUserInfo() {
	doUpdate({
		form:"update-userinfo-form",
        url:"/portal/myPage/updateUserInfo.do",
        before:beforeUpdateUserInfo,
        after:afterUpdateUserInfo
	});
}

function deleteUserInfo() {
	if(confirm("정말로 탈퇴하시겠습니까?")) {
	    doDelete({
	        url:"/portal/myPage/deleteUserInfo.do",
	        before:function() {return {};},
	        after:afterDeleteUserInfo
	    });
	}
}

function changeUserEmail(value) {
   if (value == "na") {
       $("[name=userEmail2]").prop("readonly", false);
   }
   else {
       $("[name=userEmail2]").prop("readonly", true).val(value);
   }
}

/////////////////////////////////////////////////////////////////////////////////
/////////////////////////// 전처리 함수 //////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
function beforeUpdateUserInfo() {
    var form = $("#update-userinfo-form");
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


/////////////////////////////////////////////////////////////////////////////////
/////////////////////////// 후처리 함수 //////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////


function afterSelectUserInfo(data) {
	var userNm = data.userNm;
	var userTel = data.userTel;
	var userEmail = data.userEmail;
	var emailYn = data.emailYn;

	$('[name=userNm]').val(userNm);
	var tel010 = "";
	if(!com.wise.util.isBlank(userTel)) {
		var telObj = ["telephone","telephone_2","telephone_3"];
		var telArr = userTel.split('-');
		$.each(telArr, function(i, d) {
			// if(i == 0) {
			// 	tel010 = d;
			// } else {
			// 	$('#'+telObj[i]).val(d);
			// }
			$('#'+telObj[i]).val(d);
		});
	}
    // loadComboOptions("telephone", "/portal/common/code/searchCommCode.do", {
    //     grpCd:"C1015",
    //     defaultCode:"",
    //     defaultName:"선택"
    // }, tel010);
	
	if(!com.wise.util.isBlank(userEmail)) {
		var emailObj = ["eMail", "eMail_2", "eMail_3"];
		var emailArr = userEmail.split('@');
		$.each(emailArr, function(i, d) {
			$('#'+emailObj[i]).val(d);
		});
	}
	
	if(emailYn == 'Y') {
		$('#emailAgree').attr('checked', true);
		$('[name=emailYn]').val(emailYn);
	}
}

function afterUpdateUserInfo(data) {
	
}

function afterDeleteUserInfo() {
	location.href = "/portal/mainPage.do";
}