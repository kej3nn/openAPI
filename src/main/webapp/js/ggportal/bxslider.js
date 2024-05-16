$(document).ready(function(){
	// 메인 top 
	autoPlay = $('.autoplay').bxSlider({
		mode : 'fade',
		auto : true, 
		pause : 2000, 
		autoStart: true,
		autoControls : true,
		speed : 500,
		pager : true,

		moveSlider : 1,
		autoHover : true,
		controls : true,
		slideMargin : 0,
		startSlide : 0,
		nextText: '',
		prevText: '',
		startText: '',
		stopText: '',

		autoControlsCombine: false,
		autoControlsSelector: null,		
		easing: null,
		slideMargin: 0,
		startSlide: 0,
		randomStart: false,
		captions: false,

		ticker: false,
		tickerHover: false,
		adaptiveHeight: false,		
		//callbacks
		onSliderLoad: function(){},
		onSlideBefore: function(){},
		onSlideAfter: function(){},
		onSlideNext: function(){},
		onSlidePrev: function(){},
		onSliderResize: function(){}		
	});

	// 활용갤러리 이미지 slide  
	mb = $('.imgGalleryDetail').bxSlider({
		mode : 'horizontal',
		speed : 500,
		pager : false,
		moveSlider : 1,
		autoHover : true,
		controls : true,
		slideMargin : 0,
		startSlide : 0
	});
	
	// 관련사이트 slide 
	mbo = $('.list_dataSet_service').bxSlider({
		auto : false, 
		pause : 2000, 
		speed : 500,
		pager : true,
		pagerType : 'short',
		controls : true
	});

	// 멀티미디어 데이터 slide 
	mbr = $('.list_media_image').bxSlider({
		auto : false, 
		pause : 2000, 
		speed : 500,
		pager : true,
		pagerType : 'short',
		controls : true
	});
});

