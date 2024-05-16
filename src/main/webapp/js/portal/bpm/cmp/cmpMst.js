/**
 * 의정활동별 공개 - 위원회 구성/계류법안 스크립트 파일이다.
 * 
 * @author JHKIM
 * @version 1.0 2019/11/05
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
	
	// 모바일 탭 변경이벤트
	$("#tab-select-sect").bind("change", function() {
		var tabSect = $("#tab-cont-sect");
		tabSect.children("div").hide();
		tabSect.children("div:eq("+ $("#tab-select-sect :selected").index() +")").show();
	});
}