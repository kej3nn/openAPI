/***
 * 마이페이지 > 청구기본정보수정 
 * @author 	SBCHOI
 * @since	2019/12/01
 */
var success = "";
$(function() {
	initComp();
	
    // 데이터를 로드한다.
    loadData();
    
    fn_useKeyPad();
    
    bindEvent();
    
    // 옵션을 로드한다.
    //loadOptions();
});

/**
 * 마스크를 바인딩한다.
 */
function initComp() {
	// nProtect 마우스입력
    nProtectMouse();
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
    
	$("#updateBtn").bind("click", function() {
		updateUserInfo();
		return false;
	});
	
	$("#findAddrBtn").bind("click", function() {
		fn_zipcode();
		return false;
	});
	
	
	$("#userTel").bind("change", function() {
		var val = $(this).val();
		if(val == '000'){
			$("#userTel2").val("");
			$("#userTel3").val("");
		}
		return false;
	});
	
	$("#userFaxTel").bind("change", function() {
		var val = $(this).val();
		if(val == '000'){
			$("#userFaxTel2").val("");
			$("#userFaxTel3").val("");
		}
		return false;
	});
	
	$("#userHp").bind("change", function() {
		var val = $(this).val();
		if(val == '000'){
			$("#userHp2").val("");
			$("#userHp3").val("");
		}
		return false;
	});
	
	$("button[name=isRealBtn]").bind("click", function() {
		if(com.wise.util.trim($("input[name=login_rno1]").val()).length < 6){
			alert('주민등록번호 13자리를 입력해주세요. ');
			$("input[name=login_rno1]").focus();
			return false;
		}
		if(com.wise.util.trim($("input[name=login_rno2]").val()).length < 7){
			alert('주민등록번호 13자리를 입력해주세요. ');
			$("input[name=login_rno2]").focus();
			return false;
		}
		// 실명인증
		isReal();
		return false;
    });
	
	$("#hpYn, #kakaoYn").bind("click", function(e) {
		if( $("input:checkbox[id='hpYn']").is(":checked") && $("input:checkbox[id='kakaoYn']").is(":checked") ) {
			alert("SMS와 카카오알림톡은 동시에 선택할 수 없습니다.");
			return false;
		}
	});
	
}
function nProtectMouse(){
	npPfsStartup(document.form,	false, false, false, true, "npkencrypt", "on");
}

function fn_useKeyPad() {
	
 	if($("#idKeyPad").is(":checked") == true) {
		// 미보호 상태 종료		
		$("#idKeyPad").attr("value","Y");
		
		npVCtrl.isAbsoluteUse = function() { return true; }; // 체크박스 true 시 키패드 사용

  		jQuery(document).on("nppfs-npv-enabled", function(event){ 
 			npVCtrl.closeAll();
		});  

	} else {
		//npPfsCtrl.doFocusOut();
		npVCtrl.isAbsoluteUse = function() { return false; }; // 체크박스 false 시 키패드 미사용
		// 미보호 상태 실행
	} 
	
}

/**
 * 옵션을 로드한다.
 */
function loadOptions() {
    
    loadComboOptions("eMail_3", "/portal/common/code/searchCommCode.do", {grpCd:"C1009"}, "na");
}


function loadData() {
	
	selectUserInfo();
	
}

function selectUserInfo() {
    doSelect({
        url:"/portal/myPage/exposeDefaultUpdInfo.do",
        before:function(){return{};},
        after:afterSelectUserInfo
    });
}

function updateUserInfo() {
	/*if ( !com.wise.util.isNull($("input[name=login_rno1]").val()) || !com.wise.util.isNull($("input[name=login_rno2]").val())) {
		if(success != 1){
			alert("실명인증을 하지 않았습니다.");
			$("button[name=isRealBtn]").focus();
			return false;
		}else{
			if(!confirm("저장 하시겠습니까?")) return false;
			
			doUpdate({
				form:"form",
		        url:"/portal/myPage/updateExposeDefaultUpd.do",
		        before:beforeUpdateUserInfo,
		        after:afterUpdateUserInfo
			});
		}*/
	if ( $("button[name=isRealBtn]").length == 1 ) {
		alert("실명인증을 하지 않았습니다.");
		$("button[name=isRealBtn]").focus();
	}
	else{
		if(!confirm("저장 하시겠습니까?")) return false;
		
		doUpdate({
			form:"form",
	        url:"/portal/myPage/updateExposeDefaultUpd.do",
	        before:beforeUpdateUserInfo,
	        after:afterUpdateUserInfo
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
    var form = $("#form");
    
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
    
    if (form.find("[name=userZip]").length > 0) {
        
    	if (com.wise.util.isBlank(form.find("[name=user2Saddr]").val())) {
            alert("상세주소를 입력하여 주십시오.");
            form.find("[name=user2Saddr]").focus();
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
	var userHp = data.userHp;
	var userFaxTel = data.userFaxTel;
	var userTel = data.userTel;
	var userEmail = data.userEmail;
	var emailYn = data.emailYn;
	var hpYn = data.hpYn;
	var kakaoYn = data.kakaoYn;
	var userZip = data.userZip;
	var user1Addr = data.user1Addr;
	var user2Saddr = data.user2Saddr;
	
//	var user1Ssn = data.user1Ssn;
//	var user2Ssn = data.user2Ssn;


	$("[name=userNm]").val(userNm);
	$("[name=userZip]").val(userZip);
	$("[name=user1Addr]").val(user1Addr);
	$("[name=user2Saddr]").val(user2Saddr);
	/*
	if(!com.wise.util.isBlank(user1Ssn) || !com.wise.util.isBlank(user2Ssn)) {
		$("#isRealAreaF").hide();
		$("#isRealAreaS").show();
		$("input[name=user1Ssn]").val(user1Ssn);
		$("input[name=user2Ssn]").val(user2Ssn);
	}else{
		$("#isRealAreaF").show();
		$("#isRealAreaS").hide();
	}*/
	if(!com.wise.util.isBlank(userHp)) {
		var telObj = ["userHp","userHp2","userHp3"];
		var telArr = userHp.split('-');
		$.each(telArr, function(i, d) {
			$('#'+telObj[i]).val(d);
		});
	}
	
	if(!com.wise.util.isBlank(userTel)) {
		var telObj = ["userTel","userTel2","userTel3"];
		var telArr = userTel.split('-');
		$.each(telArr, function(i, d) {
			$('#'+telObj[i]).val(d);
		});
	}
	
	if(!com.wise.util.isBlank(userFaxTel)) {
		var telObj = ["userFaxTel","userFaxTel2","userFaxTel3"];
		var telArr = userFaxTel.split('-');
		$.each(telArr, function(i, d) {
			$('#'+telObj[i]).val(d);
		});
	}
	
	if(!com.wise.util.isBlank(userEmail)) {
		var emailObj = ["eMail", "eMail_2", "eMail_3"];
		var emailArr = userEmail.split('@');
		$.each(emailArr, function(i, d) {
			$('#'+emailObj[i]).val(d);
		});
	}
	
	if(emailYn == 'Y') {
		$('#emailYn').attr('checked', true);
	}
	if(hpYn == 'Y') {
		$('#hpYn').attr('checked', true);
	}
	if(kakaoYn == 'Y') {
		$('#kakaoYn').attr('checked', true);
	}
}

function afterUpdateUserInfo(data) {
	selectUserInfo();
}
/////////////////////////////////////////////////////////////////////////////////
/////////////////////////// 후처리 함수 //////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

//우편번호 팝업
function fn_zipcode(){
	var wname = "우편번호검색";

	var url = com.wise.help.url("/portal/expose/roadSearchAddrPage.do");
	var w = 500;
	var h = 720;
	var LP = (screen.width) ? (screen.width - w) / 2 : 100;
	var TP = (screen.height) ? (screen.height - h) / 3 : 100;
	var setting = "height=" + h + ", width=" + w + ", top=" + TP + ", left=" + LP;
 	window.open(url, wname, setting);
}

function isReal() {
	var formObj = $("form[name=form]");
	
	var login_rno1 = formObj.find("input[name=login_rno1]").val();
	
	//키보드보안 체크를 안했으면 RSA암호화로 값을 변환한다.
	if($("input:checkbox[name=idKeyPad]").is(":checked") == false) {
		
		 // rsa 암호화
		var rsa = new RSAKey();
		rsa.setPublic($('#RSAModulus').val(),$('#RSAExponent').val());
    
		$("#login_rno2_RSA").val(rsa.encrypt($("#login_rno2").val()));
		$("#login_rno2").val("");
	}
	
	formObj.ajaxSubmit({
		url : com.wise.help.url("/portal/expose/openLogin.do")
		, async : false
		, type : 'post'
		, dataType: 'json' 
		, contentType : 'application/x-www-form-urlencoded;charset=UTF-8'
		, success : function(res, status) {
			var result = res.data;
			
			alert(result.msg);
			
			if ( result.result == 1 ) {
				var element = 
					"<div>" +
					"	<input type=\"text\" name=\"user1Ssn\" title=\"주민등록번호 앞6자리\" readonly=\"readonly\" style=\"width:35%;\" value=\""+ login_rno1 +"\"> -" +
					"	<input type=\"password\" name=\"user2Ssn\" title=\"주민등록번호 뒤7자리\" readonly=\"readonly\" style=\"width:35%;\" value=\"*******\">" + 
					"</div>";
				$("#isReal-sect").empty().append(element);
			}
		}
		, error: function(jqXHR, textStatus, errorThrown) {
			alert("처리 도중 에러가 발생하였습니다.");
		}
	});
}

