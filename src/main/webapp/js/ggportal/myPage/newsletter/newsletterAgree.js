/***
 * 뉴스레터 수신동의
 * @author 	jhkim
 * @since	2019/11/28
 */

$(function() {
	bindEvent();
	
});

function bindEvent() {
	
	// SUBMIT
	$("#formObj").submit(function() {
		var userEmail = $("input[name=userEmail]");
		
		if ( com.wise.util.isEmpty(userEmail.val()) ) {
			alert("이메일주소를 입력하세요.");
			userEmail.focus();
			return false;
		}
		
		if ( !com.wise.util.isEmail(userEmail.val()) && $("input[name=emailYn]").val() == "Y" ) {
			alert("올바르지 않은 이메일주소 입니다.");
			userEmail.focus();
			return false;
		}
		
		doAjax({
			url: $(this).attr("action"),
			params: $(this).serialize(),
			succUrl: "/portal/myPage/newsletterAgreePage.do"
		})
		
		return false;
	});
	
	// 엔터 submit 이벤트 제거 
	$("input[name=userEmail]").bind("keydown", function(e) {
		if ( e.which == 13 ) {
			e.preventDefault();
		}
	});
	
	// 수신동의
	$("button[id=btnAgree]").bind("click", function(e) {
		$("input[name=emailYn]").val("Y");
		$("#formObj").submit();
		return false;
	});
	
	// 수신동의 취소
	$("button[id=btnCancel]").bind("click", function(e) {
		$("input[name=emailYn]").val("N");
		$("#formObj").submit();
		return false;
	});
	
	// 이메일 주소 변경
	$("button[id=btnUpdate]").bind("click", function(e) {
		$("input[name=emailYn]").val("Y");
		$("#formObj").submit();
		return false;
	});
}