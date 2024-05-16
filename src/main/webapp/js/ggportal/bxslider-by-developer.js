////////////////////////////////////////////////////////////////////////////////
//슬라이더 관련(메인) [시작]
////////////////////////////////////////////////////////////////////////////////
/**
 * bxslider를 적용한다.
 */
function setBxsliders() {
	//메인 배너 슬라이더
	sliders.banner = $("#banner-list").bxSlider({
		mode : 'fade',
		auto : true, 
		pause : 3000, 
		autoStart: true,
		autoControls : false,
		speed : 500,
		pager : false,

		moveSlider : 1,
		autoHover : true,
		controls : false,
		slideMargin : 0,
		startSlide : 0
    });
	
	//메인 차트 배너(인구수)
	sliders.population = $("#populationChart").bxSlider({
	 	mode : 'vertical',
		auto : true, 
		pause : 3000, 
		autoStart: true,
		autoControls : false,
		speed : 500,
		pager : false,

		moveSlider : 1,
		autoHover : true,
		controls : false,
		slideMargin : 0,
		startSlide : 0
    });
}

/**
 * 슬라이더를 리로드한다.
 */
function reloadSliders() {
    for (var key in sliders) {
        var slider = sliders[key];
        
        if (slider) {
            slider.reloadSlider();
        }
    }
}

/**
 * 메인배너 slider control
 * @param direction
 */
function moveBanner(direction) {
    if (sliders.banner) {
        switch (direction) {
            case "previous":
                sliders.banner.goToPrevSlide();
                break;
            case "next":
                sliders.banner.goToNextSlide();
                break;
            case "play":
            	sliders.banner.startAuto();
            	break;
            case "stop":
            	sliders.banner.stopAuto();
            	break;
        }
    }
}

/**
 * 활용갤러리 slider control
 * 
 * @param direction {String} 방향
 */
function moveGallery(direction) {
    if (sliders.gallery) {
        switch (direction) {
            case "previous":
                sliders.gallery.goToPrevSlide();
                break;
            case "next":
                sliders.gallery.goToNextSlide();
                break;
            case "play":
            	sliders.gallery.startAuto();
            	break;
            case "stop":
            	sliders.gallery.stopAuto();
            	break;
        }
    }
}

/**
 * 추천데이터셋 slider control
 * @param direction
 */
function moveRecommend(direction) {
    if (sliders.recommend) {
        switch (direction) {
            case "previous":
                sliders.recommend.goToPrevSlide();
                break;
            case "next":
                sliders.recommend.goToNextSlide();
                break;
            case "play":
            	sliders.recommend.startAuto();
            	break;
            case "stop":
            	sliders.recommend.stopAuto();
            	break;
        }
    }
}

/**
 * 인구차트 slider control
 * @param direction
 */
function movePopulation(direction) {
    if (sliders.population) {
        switch (direction) {
            case "previous":
                sliders.population.goToPrevSlide();
                break;
            case "next":
                sliders.population.goToNextSlide();
                break;
            case "play":
            	sliders.population.startAuto();
            	break;
            case "stop":
            	sliders.population.stopAuto();
            	break;
        }
    }
}

$(document).ready(function(){
	// 메인배너 이전 버튼에 클릭 이벤트를 바인딩한다.
    $("#banner-previous-button").bind("click", function(event) {
        // 활용갤러리 게시판을 이동한다.
    	moveBanner("previous");
        return false;
    });
    
    // 메인배너 게시판 다음 버튼에 클릭 이벤트를 바인딩한다.
    $("#banner-next-button").bind("click", function(event) {
        // 활용갤러리 게시판을 이동한다.
    	moveBanner("next");
        return false;
    });
   
    // 메인배너 게시판 플레이 버튼에 클릭 이벤트를 바인딩
    $('#banner-play-button').bind("click", function(event) {
    	moveBanner("play");
    	return false;
    });

    // 메인배너 게시판 플레이 버튼에 클릭 이벤트를 바인딩
    $('#banner-stop-button').bind("click", function(event) {
    	moveBanner("stop");
    	return false;
    });
    
    // 활용갤러리 게시판 이전 버튼에 클릭 이벤트를 바인딩한다.
    $("#gallery-previous-button").bind("click", function(event) {
        // 활용갤러리 게시판을 이동한다.
        moveGallery("previous");
        return false;
    });
    
    // 활용갤러리 게시판 다음 버튼에 클릭 이벤트를 바인딩한다.
    $("#gallery-next-button").bind("click", function(event) {
        // 활용갤러리 게시판을 이동한다.
        moveGallery("next");
        return false;
    });
   
    // 활용갤러리 게시판 플레이 버튼에 클릭 이벤트를 바인딩
    $('#gallery-play-button').bind("click", function(event) {
        moveGallery("play");
    	return false;
    });

    // 활용갤러리 게시판 플레이 버튼에 클릭 이벤트를 바인딩
    $('#gallery-stop-button').bind("click", function(event) {
        moveGallery("stop");
    	return false;
    });
    
    // 추천데이터셋 게시판 이전 버튼에 클릭 이벤트를 바인딩한다.
    $( '#dataset-previous-button' ).on( 'click', function () {
    	moveRecommend("previous");
 	   	return false;              //<a>에 링크 차단
    });

    $( '#dataset-next-button' ).on( 'click', function () {
    	moveRecommend("next");
    	return false;
    } );

 	$( '#dataset-play-button' ).on( 'click', function () {
 		moveRecommend("play");
 		return false;
 	} );

 	$( '#dataset-stop-button' ).on( 'click', function () {
 		moveRecommend("stop");
 		return false;
 	} );
 	
 	// 인구차트 이전 버튼에 클릭 이벤트를 바인딩한다.
    $("#population-previous-button").bind("click", function(event) {
        // 활용갤러리 게시판을 이동한다.
    	movePopulation("previous");
        return false;
    });
    
    // 인구차트 게시판 다음 버튼에 클릭 이벤트를 바인딩한다.
    $("#population-next-button").bind("click", function(event) {
        // 활용갤러리 게시판을 이동한다.
    	movePopulation("next");
        return false;
    });
   
    // 인구차트 게시판 플레이 버튼에 클릭 이벤트를 바인딩
    $('#population-play-button').bind("click", function(event) {
    	movePopulation("play");
    	return false;
    });

    // 인구차트 게시판 플레이 버튼에 클릭 이벤트를 바인딩
    $('#population-stop-button').bind("click", function(event) {
    	movePopulation("stop");
    	return false;
    });
////////////////////////////////////////////////////////////////////////////////
//슬라이더 관련(메인) [종료]
////////////////////////////////////////////////////////////////////////////////	
	
	
	
	
	
	// 메인 top 
	/*autoPlay = $('.autoplay').bxSlider({
		mode : 'fade',
		auto : true, 
		pause : 3000, 
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
		onSliderLoad: function(){visualMenuPos();},
		onSlideBefore: function(){},
		onSlideAfter: function() {
			var h = $('.deco_main .bx-viewport li:not(:hidden)').height();
			$('.deco_main .bx-viewport').height(h);
		},
		onSlideNext: function(){},
		onSlidePrev: function(){},
		onSliderResize: function(){visualMenuPos();}		
	});*/

	 // topBanner slide  
	 topBanner = $('.topBanner ul').bxSlider({
		mode : 'fade',
	 	speed : 500,
		auto : false, 
	 	pager : false,
	 	moveSlider : 1,
	 	autoHover : true,
	 	controls : false,
	 	slideMargin : 0,
	 	startSlide : 0
	 });

	  $( '.topBanner-direction .bx-prev' ).on( 'click', function () {
	   topBanner.goToPrevSlide();  //이전 슬라이드 배너로 이동
	   clearTimeout(autoPopClose);
	   return false;              //<a>에 링크 차단
	  } );

	  $( '.topBanner-direction .bx-next' ).on( 'click', function () {
	   topBanner.goToNextSlide();  //다음 슬라이드 배너로 이동
	   clearTimeout(autoPopClose);
	   return false;
	  });

	  var autoPopClose = setTimeout(function(){
		$('#topBannerBtn' ).click();
	  }, 5000);

	  $('#topBannerBtn' ).on( 'click', function () {
		  clearTimeout(autoPopClose);
		  if( $('.topBanner').hasClass('on')){
			  $('.topBanner').removeClass('on');
			  $('.topBannerBtn button').text('팝업열기');
		  }else{
			 $('.topBanner').addClass('on');
			  $('.topBannerBtn button').text('팝업닫기');
		  }
	  });
/*
	$(window).resize(function(){
		setTimeout(visualMenuPos, 100)
	});
*/
	/*function visualMenuPos(){
		console.log("visualMenuPos");
		if(!$('.deco_main ').size()>0) return;
		
		var t = $('.deco_main .autoplay > li:not(:hidden) > a > img').offset().top;
		var h = $('.deco_main .autoplay > li:not(:hidden) > a > img').height();
		//console.log(t)
		$('.deco_main .bx-controls-direction').css({top:(t+h)/3});
		$('.deco_main .bx-wrapper .bx-pager').css({top:t+h -20});
	}


  //추천데이터셋	
	if($('#dataset-recommend-list').size()>0){
		var ww = ($('#dataset-recommend-list').width()-40) / 4;
		dataset(ww);
	};


	function dataset(ww){
		dataSet = $('.dataSetSlider').bxSlider({
			mode : 'horizontal',
			speed : 500,
			moveSlider : 1,
			autoHover : true,
			controls : false,
			slideMargin : 0,
			startSlide : 0,
			slideWidth: ww,
			minSlides: 1,
			maxSlides: 4,
			moveSlides: 1
		});

	  $( '#dataset_prev' ).on( 'click', function () {
	   dataSet.goToPrevSlide();  //이전 슬라이드 배너로 이동
	   return false;              //<a>에 링크 차단
	  } );

	  $( '#dataset_next' ).on( 'click', function () {
	   dataSet.goToNextSlide();  //다음 슬라이드 배너로 이동
	   return false;
	  } );
	}
*/
});

