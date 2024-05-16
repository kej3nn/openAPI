/*
 * @(#)writeObjection.js 1.0 2019/07/22
 */

/**
 * 정보공개 > 이의신청서 작성 스크립트이다.
 *
 * @author SoftOn
 * @version 1.0 2018/04/19
 */
$(function() {
	
    // 컴포넌트를 초기화한다.
    initComp();
    
    // 이벤트를 바인딩한다.
    bindEvent();

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
	fn_pageLoad();
}

/**
 * 이벤트를 바인딩한다.
 */
function bindEvent() {
	$("input[name=dcsNtcDt], input[name=firstDcsDt]").datepicker(com.wise.help.datepicker({
        buttonImage:com.wise.help.url("/images/admin/icon_calendar.png")
    }));
	$("input[name=dcsNtcDt], input[name=firstDcsDt]").attr("readonly", true);
	
	$("input:checkbox[name=clsdChk]").on("click", function() {
		var objtnHtml = "";
		var clickVal = $(this).val();
		if($(this).is(":checked")){
			$("label[for=selInfo]").hide();
			$("div[name=clsd"+clickVal+"]").show();
			
			$("div[name=clsd"+clickVal+"]").find("textarea[name=objtn_rson]").bind("keyup", function(event) {
				var obj = $("div[name=clsd"+clickVal+"]").find("textarea[name=objtn_rson]");
				textAreaLabelLenChk(obj, 'clsd'+clickVal, 'len2', 500);
			});
			
		}else{
			$("div[name=clsd"+clickVal+"]").hide();
			$("div[name=clsd"+clickVal+"]").find("textarea[name=objtn_rson]").val("");
			if($("input:checkbox[name=clsdChk]:checked").length == 0) $("label[for=selInfo]").show();
			$("div[name=clsd"+clickVal+"]").find("input[name=len2]").val("0");
		}
	 });
}

/**
 * 옵션을 로드한다.
 */
function loadOptions() {

}

////////////////////////////////////////////////////////////////////////////////
// 기존 JS 함수
////////////////////////////////////////////////////////////////////////////////
//page onload
function fn_pageLoad(){
	var obj1 = document.form.objtn_rson;
	var obj2 = document.form.opb_clsd_cn;
	
	$("input:checkbox[name=clsdChk]:checked").each(function() {
		var clickVal = $(this).val();
		var obj = $("div[name=clsd"+clickVal+"]").find("textarea[name=objtn_rson]");
		textAreaLabelLenChk(obj, 'clsd'+clickVal, 'len2', 500);
	});
	
	//fn_textareaLengthChk(obj1, 'len1', 500);
	//fn_textareaLengthChk(obj2, 'len2', 500);
}

function fn_submitForm(gb) {
	var frm = fn_getId("form");
	var key;
	var msglen = 0;
	
	if($("input:checkbox[name=clsdChk]:checked").length == 0){
		alert("이의신청 대상이 없습니다.");
		return false;
	}
		
	/* 이의신청의 취지 및 이유 확인 시작 (START) */
	var isDataChk = false;
	var eqIdx = "";
	$("input:checkbox[name=clsdChk]:checked").each(function() {
		
		if(com.wise.util.isNull($("div[name=clsd"+$(this).val()+"]").find("textarea[name=objtn_rson]").val())){
			isDataChk = true;
			eqIdx = $(this).val();
		}
	});
	if(isDataChk){ //이의신청의 취지 및 이유 내용이 없는게 있을 경우
		alert("이의신청의 취지 및 이유를 입력해주세요.");
		$("div[name=clsd"+eqIdx+"]").find("textarea[name=objtn_rson]").focus();
		return false;
	}
	/* 이의신청의 취지 및 이유 확인 종료 (END) */		
		
		
/*	var i = fn_getId("objtn_rson").value.length;
	for(k = 0; k < i; k++) {
		key = fn_getId("objtn_rson").value.charAt(k);
		if(escape(key).length > 4) {
			msglen +=2;
		} else {
			msglen++;
		}
	}*/

	var radioObj = frm.ntcs_yn;
	var isCheck;
	if(radioObj.length == null){
		isCheck = radioObj.checked;
	} else {
		for(var i=0; i < radioObj.length; i++) {
			if(radioObj[i].checked) {
				isCheck = true;
				break;
			}
		}
		
	}

	if(!isCheck) {
		alert("통지서 수령유무를 선택해 주세요");
		return false;
	}

	/*if(frm.objtn_rson.value == '') {
		alert("이의신청의 취지 및 이유를 입력해 주세요");
		frm.objtn_rson.focus();
		return false;
	} else if(msglen > 500) {
		alert("이의신청의 취지및 사유는 500Byte 이내로 작성해 주십시오.");
		frm.objtn_rson.focus();
		return false;
	}*/
	
	var val = "";
	if(gb == 'I') val = '등록';
	else val = '수정';
	if(!confirm(val + ' 하시겠습니까?')){
		return;
	}
	if(frm.file.value.length > 0){
		frm.objtnLength.value='1';
	}
	
	saveData(gb);
}

/**
 * 데이터 등록/수정(파일처리)
 */
function saveData(gb) {
	var formObj = $("form[name=form]");
	var action = "";
	if(gb == 'I') action = "/portal/expose/insertObjection.do";
	else action = "/portal/expose/updateObjection.do";

	formObj.ajaxSubmit({
		url : com.wise.help.url(action)
		, async : false
		, type : 'post'
		, dataType: 'json' 
		, contentType : 'application/x-www-form-urlencoded;charset=UTF-8'
		, beforeSubmit : function() {
		}	
		, success : function(res, status) {
			doAjaxMsg(res, "");
			location.href = com.wise.help.url("/portal/expose/searchObjectionPage.do");
		}
		, error: function(jqXHR, textStatus, errorThrown) {
			alert("처리 도중 에러가 발생하였습니다.");
		}
	});
}

function fn_textareaLengthChk(obj, id, len){
	rtn = fn_byteCheck(obj.value, id);
	if(rtn > len){
	  alert(len+'byte 이상 초과 할 수 없습니다.');
	  for(var i=rtn; i > len; i--){
		  obj.value = fn_trim(obj.value).substring(0, obj.value.length-1);
		  if(fn_byteCheck(obj.value, id) <= len){
		  	break;
		  }
	  }
		rtn = fn_byteCheck(obj.value, id);
	  return;
	}
}

//레이블 텍스트박스 글자수 체크
function textAreaLabelLenChk(obj, label, name, len){
	rtn = byteLabelCheck(obj.val(), label, name);
	if(rtn > len){
	  alert(numberWithCommas(len)+'byte 이상 초과 할 수 없습니다.');
	  for(var i=rtn; i > len; i--){
		  obj.val(fn_trim(obj.val()).substring(0, obj.val().length-1));
		  if(byteLabelCheck(obj.val(), label, name) <= len){
		  	break;
		  }
	  }
		rtn = byteLabelCheck(obj.val(), label, name);
	  return;
	}
}

//trim() 공백제거
function fn_trim(str){
   str = str.replace(/(^\s*)|(\s*$)/g, "");
   return str;
}

//레이블 바이트 체크
function byteLabelCheck(val, label, name){
	var formObj = $("form[name=form]");
	
	var temp_estr = escape(val);
	var s_index = 0;
	var e_index = 0;
	var temp_str = "";
	var cnt = 0;
	while((e_index = temp_estr.indexOf("%u", s_index)) >=0){
		temp_str += temp_estr.substring(s_index, e_index);
		s_index = e_index + 6;
		cnt ++;;
	}
	temp_str += temp_estr.substring(s_index);
	temp_str = unescape(temp_str);
	formObj.find("div[name="+label+"]").find("input[name="+name+"]").val( numberWithCommas(((cnt *2) + temp_str.length)));
	return ((cnt *2) + temp_str.length);
}

function fn_dateSet() {

	var radio =  document.getElementsByName("ntcs_yn");

	for(var i = 0; i < radio.length; i++) {
		if(radio[i].checked == true) {
			if(radio[i].value == '0') {
				document.getElementById("firstDcsDt").value = '';
				document.getElementById("dcsNtcDt").value = document.getElementById("dcs_ntc_dt").value;
			} else {
				document.getElementById("dcsNtcDt").value = '';
				document.getElementById("firstDcsDt").value = document.getElementById("first_dcs_dt").value;
			}
		}
	}
}

