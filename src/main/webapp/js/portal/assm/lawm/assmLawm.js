/**
 * 국회의원 입법활동 화면(탭) 스크립트 파일이다.
 * 
 * @author JHKIM
 * @version 1.0 2019/10/16
 */
////////////////////////////////////////////////////////////////////////////////
// GLOBAL VARIABLE
////////////////////////////////////////////////////////////////////////////////
// 로딩 완료 상태 변수
var GCP_ONLOAD = {
	degt: false,
	clbo: false,
	vote: false
};

////////////////////////////////////////////////////////////////////////////////
// SCRIPT INIT
////////////////////////////////////////////////////////////////////////////////
$(function() {
	bindEvent();
});


function bindEvent() {
	// 탭 선택 이벤트
	$("#lawm-tab-btn a").each(function() {
		$(this).bind("click", function() {
			$("#lawm-tab-btn a").removeClass("on");
			$(this).addClass("on");
			$("#lawm-tab-btn").nextAll("div");

			var bindForm = $(this).attr("data-bindForm").replace("Form", "");
			$("div[id^=div-]").hide();
			$("#div-" + bindForm + "-sect").show();
			
			// 리사이징(탭 이동시)
			parent.iframeResize("ifm_tabLawm", $("#div-" + bindForm + "-sect").height());
		});
	});
}

function lawmHideLoading() {
	if ( GCP_ONLOAD.degt && GCP_ONLOAD.clbo && GCP_ONLOAD.vote ) {
		parent.gfn_hideLoading();
	}
}