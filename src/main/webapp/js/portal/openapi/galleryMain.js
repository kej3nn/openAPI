/*
 * @(#)galleryMain.js 1.0 2020/11/17
 * 
 */

/**
 * 활용사례 메인 페이지 스크립트이다.
 *
 * @author 
 * @version 
 */
////////////////////////////////////////////////////////////////////////////////
// 글로벌 변수
////////////////////////////////////////////////////////////////////////////////
/* 슬라이더 객체 */
var SLIDER = {
	guideList: null
};

$(function() {
    // 컴포넌트를 초기화한다.
    initComp();
    
    // 활용가이드 노출
    //openGuide();
});


////////////////////////////////////////////////////////////////////////////////
// 초기화 함수
////////////////////////////////////////////////////////////////////////////////
/**
 * 컴포넌트를 초기화한다.
 */
function initComp() {
	// 슬라이더 초기화
	initSlider();  
}

// 서비스 함수
////////////////////////////////////////////////////////////////////////////////

/**
 * 슬라이더를 초기화한다.
 */
function initSlider() {
	
	SLIDER.guideList = $("#guideImg").bxSlider({
		speed : 1000,
		/*pager : false,*/
		moveSlider : 1,
		autoHover : true,
		controls : false,
		slideMargin : 0,
		startSlide : 0,
		auto: false,
		pagerCustom: '#bx_pager',
		// 웹 접근성 관련 수정
		onSliderLoad: function(currentIndex){
			$("#guideImg").find('a').attr('tabindex', -1);
			$("#guideImg").find('li').not('.bx-clone').eq( currentIndex ).find('a').attr('tabindex', 0); 
		},
		onSlideBefore: function($slideElement, oldIndex, newIndex){
			$("#guideImg").find('a').attr('tabindex', -1);
			$("#guideImg").find('li').not('.bx-clone').eq( newIndex ).find('a').attr('tabindex', 0);
		}
	});
		
	
	// 슬라이더 이벤트 적용
	initSliderEvent();
}

/**
 * 슬라이더 이벤트를 적용한다.
 */
function initSliderEvent() {
	
	$(".pb_prev").bind("click", function() {
		SLIDER.guideList.goToPrevSlide();
		return false;
	}).bind("keydown", function(event) {
		if ( event.which == 13 ) {
			SLIDER.guideList.goToPrevSlide();
			return false;
		}
	});
	
	$(".pb_next").bind("click", function() {
		SLIDER.guideList.goToNextSlide();
		return false;
	}).bind("keydown", function(event) {
		if ( event.which == 13 ) {
			SLIDER.guideList.goToNextSlide();
			return false;
		}
	});
	
	$(".platform_all_btn ul li a").bind("click", function(event) {
		event.preventDefault();
		$(".platform_all_btn ul li a").removeClass("on");
		$(this).addClass("on");
		
	});
}

/**
 *  활용가이드 노출 
 */
function openGuide() {
	var ranNum = Math.random();
	var openKey = Math.floor(ranNum*5+1);
	
	$("#guide"+openKey).show();
}