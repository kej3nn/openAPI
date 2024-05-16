/* menu on */
function menuOn(depth1, depth2, depth3) {
	var menuDepth1 = $(".menu" + depth1)
	menuDepth1.addClass("selected");

	var menuDepth2 = $(".menu" + depth1 + "-" + depth2)
	menuDepth2.addClass("selected");
}

/* 상단 메뉴 고정  : 접근성 이슈로 주석 처리(2018-12-13)
$(window).scroll(function(e){
	if ($(this).scrollTop() > 30) {
		$(".header-area").addClass("fixed");
		$(".header-area").animate({
			marginTop:'0'
		}, 150);
		$(".header-box h1 a img").attr("src", com.wise.help.url("/images/hfportal/common/logo_white@2x.png"));
	} else {
		$(".header-area").stop().animate({
			marginTop:'0'
		}, 150);
		$(".header-area").removeClass('fixed');
		$(".header-box h1 a img").attr("src", com.wise.help.url("/images/hfportal/common/logo@2x.png"));
	}

	var currentHeight = $(document).scrollTop();
	if(currentHeight < 30) {
		$(".contents-title-wrapper h3").removeClass('fixed fixed-on');
		$(".lnb").removeClass('fixed');
	} else {
		$(".contents-title-wrapper h3").addClass('fixed fixed-on');
	}
});
*/


$(function() {

	/* 통합검색 */
	$(".header-area .btn-search").click(function() {
		$("body").removeClass('fixed-body');
		$(".mask").fadeIn(150, function() {
			$(".layerpopup-totalsearch-wrapper").show();
			$("#search").focus();
		});
		
	});

	$(".btn-totalsearch-close").click(function() {
		$(".layerpopup-totalsearch-wrapper").hide();
		$(".mask").fadeOut(150);
	});

	/* 전체 메뉴 모바일 */
	$(".btn-totalmenu-mobile").click(function() {
		$(this).toggleClass('on');
		$("body").toggleClass('fixed-body');
		$(this).next('.totalmenu-mobile').slideToggle(150);

		if($(".totalmenu-mobile").css("display") != "none") {
			$(".totalmenu-area-mobile h2 a").removeClass('on');
			$(".totalmenu-area-mobile ul").hide();
			$(".totalmenu-area-mobile ul.selected").show();
		}
	});

	/* 최대화 최소화 */
	window.onresize = function() {
		if (window.innerHeight <= 1024) {
			$('body').removeClass('fixed-body');
			$('.totalmenu').hide();
			$('.totalmenu-mobile').hide();
			$(".btn-totalmenu").removeClass('on');
			$(".btn-totalmenu-mobile").removeClass('on');

			$(".totalmenu-area-mobile h2 a").removeClass('on');
			$(".totalmenu-area-mobile ul").slideUp();

			$('.contents-title-wrapper h3').removeClass('fixed on');
			$('.lnb').removeClass('fixed on');
		}
	}


	/* 부드럽게 상단으로 이동 */
	$( window ).scroll( function() {
		if ( $( this ).scrollTop() > 200 ) {
			$( '.btn-top-go, .btn-mobile-back' ).fadeIn();
		} else {
			$( '.btn-top-go, .btn-mobile-back' ).fadeOut();
		}
	});

	$( '.btn-top-go' ).click( function() {
		$( 'html, body' ).animate( { scrollTop : 0 }, 400 );
		return false;
	});



  
	/* 모바일 lnb */
	var wrapperWidth = $(window).width();	
	if(wrapperWidth < 1024) {		
		$(".contents-title-wrapper h3").removeClass('on');
		$(".lnb").hide();
	} else {
		$(".contents-title-wrapper h3").removeClass('on');
		$(".lnb").show();
		$(".hide-pc-lnb .lnb").hide();
	}

	
	$( window ).resize(function() {
		var wrapperWidth = $(window).width();	
		if(wrapperWidth < 1024) {		
			$(".contents-title-wrapper h3").removeClass('on');
			$(".lnb").hide();
		} else {
			$(".contents-title-wrapper h3").removeClass('on');
			$(".lnb").show();
			$(".hide-pc-lnb .lnb").hide();
		}
	});

	
	$(".contents-title-wrapper h3").click(function() {

		var wrapperWidth02 = $(window).width();	
		if(wrapperWidth02 < 1024) {
			if($(".lnb").css("display") != "none") {
				$("body").removeClass("fixed-body");
				$(this).removeClass('fixed on');
				$(".lnb").removeClass("fixed");
				$(".lnb").hide();
				$(".lnb").css('height', 'auto');
			} else {
				var mobileLnbHeight = $(window).height() - 95;
				$("body").addClass("fixed-body");
				$(this).addClass('fixed on');
				$(".lnb").addClass("fixed");
				$(".lnb").show();
				$(".lnb").css('height', mobileLnbHeight + 'px');
			}
		} else {
			$(this).removeClass('on');
			$(".lnb").show();
			$(".hide-pc-lnb .lnb").hide();
		}

	});

	$(".btn-totalsearch-close").blur(function() {
		$(".layerpopup-totalsearch-wrapper").hide();
		$(".mask").fadeOut(150);
	});
	
	$(".btn-print").focus(function() {
		$(".btn-totalmenu").removeClass('on');
		$(".totalmenu").hide();
	});


	$(".btn-font-viewer").click(function() {
		$(".contents").toggleClass('on');
		$(this).toggleClass('on');
	});
	
	
	
	//////////////////////////////// 메인 MENU EVENT [start] ////////////////////////////////////////////
	$(".btn-totalmenu").bind("click", function() {
		$(this).toggleClass('on');
		if ( $('.totalmenu').css("display") === "block" ) {
			$('.totalmenu').slideUp(150);
		}
		else {
			$('.totalmenu').slideDown(150);
		}
	});
	
	// 메뉴항목 밖에 마우스가 있는경우 메뉴 숨김
	$(".totalmenu").mouseout(function() {
		if ( $("#contents:hover").length == 1 ) {
			$(".btn-totalmenu").removeClass('on');
			$('.totalmenu').slideUp(150);
		}
	});
	
	// 키보드 focus 갔을경우 하위 영역 표시
	$(".top-menu > li > a").keyup(function() {
		$(".top-menu > li > ol").css("display", "none");
		$(this).next().css("display", "block");
	});
	
	// 검색 버튼에 포커스 있을경우 열려있는 메뉴 닫기
	$(".btn-search").focus(function() {
		$(".top-menu .line-none ol").hide();
	});
	
	// 메뉴 한개씩 열렸을때 마지막 메뉴항목으로 갔을때 포커스 아웃이면 메뉴 숨김
	$(".totalmenu-area:last-child").find("ul > li:last-child > a").focusout(function() {
		$(".btn-totalmenu").removeClass('on');
		$('.totalmenu').slideUp(150);
	});
	
	
	// 모바일 링크문제로 추가 반영 2018-11-09
	$(".totalmenu-area-mobile h2 a").click(function() {
		if($(this).parent().next(".totalmenu-area-mobile ul").css("display") == "none") {
			$(".totalmenu-area-mobile h2 a").removeClass('on point');
			$(".totalmenu-area-mobile ul").slideUp();
			$(this).addClass('on');
			$(this).parent().next(".totalmenu-area-mobile ul").slideDown();
		} else {
			$(".totalmenu-area-mobile h2 a").removeClass('on point');
			$(".totalmenu-area-mobile ul").slideUp();
		}
	});
	//////////////////////////////// 메인 MENU EVENT [end] ////////////////////////////////////////////
});





// -----------------------------------------------------------
// 화면 가운데에 새창 열기
// -----------------------------------------------------------
function windowOpen(page,w,h,s,r) 
{
    var win="_blank";
	var l = (screen.width) ? (screen.width-w)/2 : 0; 
	var t = (screen.height) ? (screen.height-h)/2 : 0; 
    var settings='';
    
    settings ='width='+w+','; 
    settings +='height='+h+',';
    settings +='top='+t+','; 
    settings +='left='+l+','; 
    settings +='scrollbars='+s+','; 
    settings +='resizable='+r+','; 
    settings +='status=0';

	var windows=window.open(page,win,settings);
    windows.focus();
}

/* 화면 확대/축소 */
var nowZoom = 100;

function zoomIn() {
	nowZoom = nowZoom - 5;
	if(nowZoom <= 80) nowZoom = 80;
	zooms();
}

function zoomOut() {
	nowZoom = nowZoom + 5;
	if(nowZoom >= 1200) nowZoom = 120;
	zooms();
}

function zoomReset(){
	nowZoom = 100; 
	zooms();
}

function zooms(){
	document.body.style.zoom = nowZoom + '%';
	if(nowZoom==80){
		//alert ("20%축소 되었습니다. 더 이상 축소할 수 없습니다.");
		return false;
	}

	if(nowZoom==120){
		//alert ("20%확대 되었습니다. 더 이상 확대할 수 없습니다.");
		return false;
	}
}

/* 프린트 */
function printWin() {
	window.open(com.wise.help.url("/js/hfportal/html/include/print.html"),'','width=810,height=768,scrollbars=yes');
}

//특수기호 replace 함수
function entityChange(value){
	if(value.indexOf("?>")>-1){
		value = value.replace(/\?>/gi, '?>\r\n');
	}
	return value.replace(/&/gi, '&amp;').replace(/</gi, '&lt;').replace(/>/gi, '&gt;').replace(/ /gi, '&nbsp;').replace(/"/gi, '&quot;');
}