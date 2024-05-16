/*
 * @(#)opnLogin.js 1.0 2019/07/22
 */

/**
 * 정보공개 > 실명인증 스크립트이다.
 *
 * @author SoftOn
 * @version 1.0 2018/04/19
 */
$(function() {
	// 컴포넌트를 초기화한다.
	initComp();
	
	// 이벤트를 바인딩한다.
	//bindEvent();
	
	fn_useKeyPad();
	
	//웹접근성 조치 20.11.09
	$("title").text($(".contents-title-wrapper > h3").text() + " | " + $("title").text());
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
	// nProtect 마우스입력
    nProtectMouse();
}

/**
 * 이벤트를 바인딩한다.
 */
function bindEvent() {
	// 키패드 사용/미사용 체크
	/*$("#idKeyPad").bind("click", function() {
		if ( $(this).is(":checked") ) {
			// 미보호 상태 종료		
			$("#idKeyPad").attr("value","Y");
			
			npVCtrl.isAbsoluteUse = function() { return true; }
			
			jQuery(document).on("nppfs-npv-enabled", function(event){
                npVCtrl.closeAll();
			}); 
		}
		else {
			npVCtrl.isAbsoluteUse = function() { return false; }
		}
	});*/
}

////////////////////////////////////////////////////////////////////////////////
// 서비스 함수
////////////////////////////////////////////////////////////////////////////////
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
////////////////////////////////////////////////////////////////////////////////
// 전처리 함수
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// 후처리 함수
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// 기존 JS 함수
////////////////////////////////////////////////////////////////////////////////

function fn_certLogin(){

	var frm = document.form;
	if(fn_trim(frm.login_name.value) == ''){
		alert('이름을 입력해주세요');
		frm.login_name.focus(); 
		return false;
	}
	
	// 이름에 공백제거
	frm.login_name.value = fn_trim(frm.login_name.value);
	
	var i = 0;
	var special=new Array("~","!","@","#","$","%","^","&","*","=","+","_","`","<",">","{","}","[","]","|","\\","/"); // 특수문자 배열
	for(i=0; i< special.length;i++) {
	  var output = frm.login_name.value.indexOf(special[i],0)  //해당문자열에 특수문자열이 있는지 확인
	  if (output != -1) { //특수문자가 없다면 -1을 반환 -1이외의값에 alert 수행후 함수 종료")) {
	    alert('이름에 특수문자를 입력할수 없습니다.');
	    return false;
	  }
	}
  		
	if(fn_trim(frm.login_rno1.value).length < 6){
		alert('주민등록번호 13자리를 입력해주세요. ');
		frm.login_rno1.focus();
		return false;
	}
	if(fn_trim(frm.login_rno2.value).length < 7){
		alert('주민등록번호 13자리를 입력해주세요. ');
		frm.login_rno2.focus();
		return false;
	}
	loginData();
}

function loginData() {
	/*npPfsCtrl.waitSubmit(function(){
		document.form.submit();
	});
	*/
	
	//키보드보안 체크를 안했으면 RSA암호화로 값을 변환한다.
	if($("input:checkbox[name=idKeyPad]").is(":checked") == false) {
		
		 // rsa 암호화
		var rsa = new RSAKey();
		rsa.setPublic($('#RSAModulus').val(),$('#RSAExponent').val());
    
		$("#login_rno2_RSA").val(rsa.encrypt($("#login_rno2").val()));
		$("#login_rno2").val("");
	}
	
	var formObj = $("form[name=form]");
	formObj.ajaxSubmit({
		url : com.wise.help.url("/portal/expose/openLogin.do")
		, async : false
		, type : 'post'
		, dataType: 'json' 
		, contentType : 'application/x-www-form-urlencoded;charset=UTF-8'
		, success : function(res, status) {
			var result = res.data;	
			alert(result.msg);
			location.href = com.wise.help.url(result.url);
		}
		, error: function(jqXHR, textStatus, errorThrown) {
			alert("처리 도중 에러가 발생하였습니다.");
		}
	});
}

function fn_rnoFocus(){
	var frm = document.form;
	//alert("[키값은] "+event.keyCode);
	if(frm.login_rno1.value.length == 6) {
		if(event.keyCode == 16 || event.keyCode == 9) {
			return;
		} else {
			frm.login_rno2.focus();
		}
	}
	
}

function fn_ntfrDiv(num){
	if(num == '1'){
		fn_getId('juminDiv').style.display = '';
		fn_getId('forDiv').style.display = 'none';
	}else{
		fn_getId('juminDiv').style.display = 'none';
		fn_getId('forDiv').style.display = '';
	}
}

function nProtectMouse(){
	npPfsStartup(document.form,	false, false, false, true, "npkencrypt", "on");
}
