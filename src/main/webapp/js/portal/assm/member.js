/**
 * 국회의원 메인 관련 스크립트 파일이다.
 * 
 * @author JHKIM
 * @version 1.0 2019/10/16
 */
////////////////////////////////////////////////////////////////////////////////
// GLOBAL VARIABLE
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// SCRIPT INIT
////////////////////////////////////////////////////////////////////////////////
$(function() {
	// 모바일일경우 요약정보 페이지 보여주지 않는다.
	if ( GC_ISMOBILE ) {
		location.href = "/portal/assm/memberInfoPage.do?monaCd=" + $("form[id=lnbForm] input[name=monaCd]").val() + "&unitCd=" + $("form[id=lnbForm] input[name=unitCd]").val();
	}
	bindEvent();
	//웹접근성 조치 20.11.09
	$(top.document).find("title").text($(".assemblyman_content_head > h3").text() + " | " + $("title").text());
	//$("title").text($(".assemblyman_content_head > h3").text() + " | " + $("title").text());
	
});

/**
 * IFRAME의 높이를 조절한다.
 * @param ifmId		IFRAME ID
 * @param height	높이
 * @returns
 */
function iframeResize(ifmId, height ) {
	height = height || document.getElementById(ifmId).contentWindow.document.body.scrollHeight;
	document.getElementById(ifmId).height = height + 150;	// body안에 있는 DIV의 마진은 계산못해서 추가로 더해준다.
	document.getElementById(ifmId).style.overflow = "hidden";
}

/**
 * 메인 탭 이벤트를 바인딩한다.
 */
function bindEvent() {
	// IFRAME TAB 버튼 이벤트
	$("#tabBtnList li").each(function() {
		$(this).bind("click", function() {
			// 로딩중...
			gfn_showLoading();
			
			// 탭 선택자 표시
			$("#tabBtnList li a").removeClass("on");
			$(this).find("a").addClass("on");
			
			// IFRAME 이벤트 처리
			var tabBtn = $(this).find("a");
			var tabId = tabBtn.attr("id");
			var tabText = tabBtn.text();
			
			// 기존 IFRAME이 있을경우 보여주고 없을경우 신규로 생성
			$("#tab-cont iframe").hide();	// IFRAME 숨김
			var iframeId = "ifm_" + tabId;
			if ( $("#"+ iframeId).length > 0 ) {	// 있을경우
				$("#"+ iframeId).show();
				gfn_hideLoading();
			}
			else {
				var gubunId = tabId.replace("tab", "");
				var newIframe = $("<iframe height=\"700px\" frameborder=\"0\" scrolling=\"no\" marginwidth=\"0\" marginheight=\"0\" width=\"100%\" onload=\"iframeResize('"+ iframeId +"')\"></iframe>");
				newIframe.attr("title", tabText)
					.attr("id", iframeId)
					.attr("name", iframeId)
					.attr("src", "/portal/assm/" + gubunId.toLowerCase() + "/assm" + gubunId + "Page.do");
				$("#tab-cont").append(newIframe);
			}
		});
	});
}