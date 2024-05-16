/**
 * @(#)infsContEvent.js 1.0 2019/08/12
 * 
 * 사전정보공개 이벤트 관련 스크립트 파일이다.
 * 
 * @author JHKIM
 * @version 1.0 2019/08/12
 */
////////////////////////////////////////////////////////////////////////////////
// GLOBAL VARIABLE
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// SCRIPT INIT
////////////////////////////////////////////////////////////////////////////////
$(function() {
	bindEvent();
});

function bindEvent() {
	//페이스북 공유
	$("#shareFB").bind("click", function(event) {
		shareFace(location.href, $(".contents-title-wrapper h3").text());
	});

	//트위터 공유
	$("#shareTW").bind("click", function(event) {
		shareTwitter(location.href, $(".contents-title-wrapper h3").text());
	});

	//네이버 블로그 공유
	$("#shareBG").bind("click", function(event) {
		shareNaver(location.href, $(".contents-title-wrapper h3").text());
	});
	//카카오 스토리 공유
	$("#shareKS").bind("click", function(event) {
		shareStory(location.href, $(".contents-title-wrapper h3").text());
	});
	//카카오톡공유
	$("#shareKT").bind("click", function(event) {
		shareKT(location.href, $(".contents-title-wrapper h3").text());
	});
}

//특수기호 replace 함수
function entityChange(value){
	if(value.indexOf("?>")>-1){
		value = value.replace(/\?>/gi, '?>\r\n');
	}
	return value.replace(/&/gi, '&amp;').replace(/</gi, '&lt;').replace(/>/gi, '&gt;').replace(/ /gi, '&nbsp;').replace(/"/gi, '&quot;');
}