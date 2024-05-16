/**
 * 국회의원 정책자료&보고서 화면 - 통합조회 스크립트 파일이다.
 * 
 * @author JHKIM
 * @version 1.0 2019/10/22
 */
////////////////////////////////////////////////////////////////////////////////
// GLOBAL VARIABLE
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// SCRIPT INIT
////////////////////////////////////////////////////////////////////////////////
$(function() {
	bindEvent();
	
	//웹접근성 조치 20.11.09
	$(top.document).find("title").text($(".assemblyman_content_head > h3").text() + " | " + $("title").text());
	$("title").text($(".assemblyman_content_head > h3").text() + " | " + $("title").text());
});


function bindEvent() {
	// 탭 이벤트
	$("#tab-btn-sect a").each(function(idx, j) {

		$(this).bind("click", function() {
			//웹접근성 조치 23.11.06
			$("#tab-btn-sect a").removeClass("on").removeAttr("title");
			$(this).addClass("on").attr("title","선택됨");
			
			var tabBtn = $(this).find("a");
			var tabSect = $("#tab-cont-sect");
			
			tabSect.children("div").hide();
			tabSect.children("div:eq("+idx+")").show();
		});
	});
}