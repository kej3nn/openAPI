/**
 * 포털 OPEN API 메인화면이다.
 *
 * @author jhkim
 * @version 1.0 2020/11/13
 */

// 공지사항 슬라이더
var SLIDER_NOTICE = null;

$(function() {
    // 컴포넌트를 초기화한다.
    initComp();
    
    // 이벤트를 바인딩한다.
    bindEvent();
});

/**
 * 컴포넌트 초기화한다.
 */
function initComp() {
	// 슬라이더 로드(공지사항)
	loadSlider();
}

/**
 * 이벤트를 바인딩한다.
 */
function bindEvent() {
	// 공지사항 슬라이더 이전
	$(".openapi_prev").bind("click", function() {
		SLIDER_NOTICE.goToPrevSlide();
		return false;
	}).bind("keydown", function(event) {
		if ( event.which == 13 ) {
			SLIDER_NOTICE.goToPrevSlide();
			return false;
		}
	});
	// 공지사항 슬라이더 다음
	$(".openapi_next").bind("click", function() {
		SLIDER_NOTICE.goToNextSlide();
		return false;
	}).bind("keydown", function(event) {
		if ( event.which == 13 ) {
			SLIDER_NOTICE.goToNextSlide();
			return false;
		}
	});
	
	// FAQ, Q&A 탭 토글
	$("#bbs-sect > div").bind("click", function(e) {
		$("#bbs-sect > div").removeClass("on");
		$(this).addClass("on");
	});
}

/**
 * 슬라이더를 로드한다.
 */
function loadSlider() {
	// 공지사항 슬라이더
	SLIDER_NOTICE = $("#notice-div-sect").bxSlider({
		mode : 'vertical',
	 	speed : 500,
	 	pager : false,
	 	moveSlider : 1,
	 	autoHover : true,
	 	controls : false,
	 	slideMargin : 0,
	 	startSlide : 0,
		// 웹 접근성 관련 수정
		onSliderLoad: function(currentIndex){
			$("#notice-div-sect").find('a').attr('tabindex', -1);
			$("#notice-div-sect").find('a').not('.bx-clone').eq( currentIndex ).attr('tabindex', 0); 
		},
		onSlideBefore: function($slideElement, oldIndex, newIndex){
			$("#notice-div-sect").find('a').attr('tabindex', -1);
			$("#notice-div-sect").find('a').not('.bx-clone').eq( newIndex ).attr('tabindex', 0);
		}
    });
}