/**
 * @(#)menu.js 1.0 2019/08/26
 * 
 * 포털 메뉴 핸들링 스크립트 파일
 * 
 * @author JHKIM
 * @version 1.0 2019/08/26
 */

var GC_ISMOBILE =  $(window).width() < 1200 ? true : false

/* menu on */
function menuOn(depth1, depth2, depth3) {
	var menuDepth1 = $(".menu" + depth1)
	menuDepth1.addClass("selected");

	var menuDepth2 = $(".menu" + depth1 + "-" + depth2)
	menuDepth2.addClass("selected");
}

$(function() {
	$(".menulayer01").hover(function() {
		$(".allmenu").show();
		$(".menulayer01 li > div").show();
		$(".moremenu").hide();
		$(".menu_more_btn").removeClass("on");
		$("#moreFirst").show();
	}, function() {
		if($(".allmenu").is(":hover") && $("#moreFirst").is(":hover")){
		} else {
			$(".allmenu").hide();
			$(".moremenu").hide();
			$(".menulayer01 li > div").hide();
			$(".menulayer02 li > div").hide();
			$(".menu_more_btn").removeClass("on");
			$("#moreFirst").hide();
			
		}
	});
	$(".menulayer02").hover(function() {
		$(".allmenu").hide();
		$(".menulayer01 li > div").hide();
		$(".menulayer02 li > div").show();
		$(".moremenu").show();
		$(".menu_more_btn").addClass("on");
	}, function() {
		if($(".moremenu").is(":hover")){
			
		} else {
			$(".menu_more_btn").removeClass("on");
			$(".menulayer02").removeClass("on");
			$(".moremenu").hide();
			$(".menulayer01").removeClass("off");
		}
	});
	// 첫번째 메뉴 상세 오버시
	$(".allmenu").hover(function() {
		$(".allmenu").show();
		$(".menulayer01 li > div").show();
	}, function() {
		$(".allmenu").hide();
		$(".menulayer01 li > div").hide();
	});
	
	// 두번째 메뉴 상세 오버시
	$(".moremenu").hover(function() {
		$(".menulayer01").removeClass("on").addClass("off");
		$(".menulayer02").removeClass("off").addClass("on");
		$(".menu_more_btn").addClass("on");
		$(".moremenu").show();
		$(".allmenu").hide();
		$(".menulayer01 li > div").hide();
		$(".menulayer02 li > div").show();
	});
	
	// 메뉴 숨김
	$(".gnb-area").hover(function() {
		$(".allmenu").hide();
		$(".moremenu").hide();
		$(".menulayer01 li > div").hide();
		$(".menulayer02 li > div").hide();
		$(".menu_more_btn").removeClass("on");
		$(".menulayer01").removeClass("off").addClass("on");
		$(".menulayer02").removeClass("on").addClass("off");
	
	});
	
	/* 메뉴 더보기 */
	$(".menu_more_btn a").hover(function() {
		$(".menulayer01").removeClass("on").addClass("off");
		$(".menulayer02").removeClass("off").addClass("on");
		$(".menu_more_btn").addClass("on");
		$(".moremenu").show();
		$(".allmenu").hide();
		$(".menulayer01 li > div").hide();
		$(".menulayer02 li > div").show();
	});

	$(".menu_more_btn a").focusin(function() {
		$(".menu_more_btn").removeClass("off").addClass("on");
		$(".menulayer01").removeClass("on").addClass("off");
		$(".menulayer02").removeClass("off").addClass("on");
		$(".moremenu").show();
		$(".allmenu").hide();
		$(".menulayer02.on li > a.top-menu-depth1.menu1").focus();
		//$(".allmenu_box.more > div.menu1 > a:first").focus();
		
	})
	//첫번째 메뉴 키보드 포커스
	$(".menulayer01").keyup(function() {
		$("#moreFirst").show(); 
		$(".menulayer01").addClass('on');
		 $(".moremenu").hide();
		 $(".menulayer02 li > div").hide();
		 $(".allmenu").show();
		 $(".menulayer01 li > div").show();
		 
	});
	
	//두번째 메뉴 키보드 포커스
	$(".menulayer02").keyup(function(event) {
		 $(".menulayer02").addClass('on');
		 $(".allmenu").hide();
		 $(".menulayer01 li > div").hide();
		 $(".moremenu").show();
		 $(".menulayer02 li > div").show();
			 
	});
	// shift+tab시 통합검색에서 menulayer01에 마지막 메뉴로 이동
	$("#fstTotalSch").bind('keydown', function(event) {
		if( event.which === 9 && event.shiftKey ) {
			$(".menulayer01").removeClass("off").addClass("on");
			$(".menulayer02").removeClass("on").addClass("off");
			$(".moremenu").hide();
			$(".menulayer02 li > div").hide();
			$(".menu_more_btn").removeClass("on");
			$(".allmenu").show();
			$(".menulayer01 li > div").show();
			setTimeout(function() {
				$("#lastMenu01").focus();
			}, 10);
		}else if (event.which === 9) {
		}
	});
	
	//두번째 더보기 포커스 아웃시 
	$("#moreSecond").bind('keydown', function(event) {
		if( event.which === 9 && event.shiftKey ) {
		}else if (event.which === 9) {
			setTimeout(function() {
				$(".moremenu").hide();
				$(".menu_more_btn").removeClass("on");
				$(".menulayer01").removeClass("off").addClass("on");
				$(".menulayer02").removeClass("on").addClass("off");
				$("#moreFirst").hide();
				$("#quickTotalSch").focus(); // 2022.12.20 - 메인화면 웹접근성 처리
				$(".btn-font-bigger").focus();	// 2021.11.10 - 웹접근성 처리
			}, 10);
		}
	});
	
	// 메뉴 세부 더보기
	$(".menu_new_more a").bind("click", function(e) {
		if ( $(".moremenu").css("display") == "block" ) {
			$(".menulayer01").removeClass("off").addClass("on");
			$(".menulayer02").removeClass("on").addClass("off");
			$(".moremenu").hide();
			$(".allmenu").show(); 
			$(".menulayer01 li > div").show();
			$(".menulayer02 li > div").hide();
			$(".menu_more_btn").removeClass("on").addClass("off");
			setTimeout(function() {
				$(".menulayer01.on li > a.top-menu-depth1.menu1").focus();
			}, 10);
		}
		else {	
			$(".menu_more_btn").removeClass("off").addClass("on");
			$(".menulayer01").removeClass("on").addClass("off");
			$(".menulayer02").removeClass("off").addClass("on");
			$(".moremenu").show();
			$(".allmenu").hide();
			$(".menulayer01 li > div").hide();
			$(".menulayer02 li > div").show();
			setTimeout(function() {
				$(".menulayer02.on li > a.top-menu-depth1.menu1").focus();
			}, 10);
		}
	});
	
	$("#quickTotalSch").bind('keydown', function(event) {
		if( event.which === 9 && event.shiftKey ) {
			$(".menulayer01").removeClass("on").addClass("off");
			$(".menulayer02").removeClass("off").addClass("on");
			$(".moremenu").show();
			$(".menulayer02 li > div").show();
			$(".menu_more_btn").addClass("on");
			$(".allmenu").hide();
			$(".menulayer01 li > div").hide();
			setTimeout(function() {
				$("#moreSecond > a").focus();
			}, 10);
		}else if (event.which === 9) {
		}
	});
	
	$("#firstMenu").bind('keydown', function(event) {
		if( event.which === 9 && event.shiftKey ) {
			$(".allmenu").hide();
			$(".menulayer01 li > div").hide();
		}else if (event.which === 9) {
		}
	});
	/* 모바일 lnb */
	var wrapperWidth = $(window).width();	
	if(wrapperWidth < 1200) {		
		$(".contents-title-wrapper h3").removeClass('on');
		$(".lnb").hide();
		$(".assemblyman_openmenu").hide();
	} else {
		$(".contents-title-wrapper h3").removeClass('on');
		$(".lnb").show();
		$(".assemblyman_openmenu").show();
		$(".hide-pc-lnb .lnb").hide();
	}
	
	
	$( window ).resize(function() {
		var wrapperWidth = $(window).width();	
		if(wrapperWidth < 1200) {		
			$(".contents-title-wrapper h3").removeClass('on');
			$(".lnb").hide();
			$(".assemblyman_openmenu").hide();
			GC_ISMOBILE = true;
		} else {
			$(".contents-title-wrapper h3").removeClass('on');
			$(".lnb").show();
			$(".assemblyman_openmenu").show();
			$(".hide-pc-lnb .lnb").hide();
			GC_ISMOBILE = false;
		}
	});
	
	
	$(".contents-title-wrapper h3").click(function() {
		var leftMenuClassNm = "";
		
		if ( $(".lnb").length > 0 ) {
			leftMenuClassNm = ".lnb";	// 일반 lnb
		}
		else if ( $(".assemblyman_openmenu").length > 0 ) {
			leftMenuClassNm = ".assemblyman_openmenu";	// 의정활동메뉴 lnb
		}
		
		if ( GC_ISMOBILE ) {
			if( $(leftMenuClassNm).css("display") != "none" ) {
				$("body").removeClass("fixed-body");
				$(this).removeClass('fixed on');
				$(leftMenuClassNm).removeClass("fixed");
				$(leftMenuClassNm).hide();
				$(leftMenuClassNm).css('height', 'auto');
			} else {
				var mobileLnbHeight = $(window).height() - 95;
				$("body").addClass("fixed-body");
				$(this).addClass('fixed on');
				$(leftMenuClassNm).addClass("fixed");
				$(leftMenuClassNm).show();
				$(leftMenuClassNm).css('height', mobileLnbHeight + 'px');
			}
		}
	});	
	
	//국회의원현황 h4 메뉴
	$(".assemblyman_menu_mobile h4").click(function() {
		
		var leftMenuClassNm = "";
		
		if ( $(".lnbs").length > 0 ) {
			leftMenuClassNm = ".lnbs";
		}
		else if ( $(".assemblyman_openmenu").length > 0 ) {
			leftMenuClassNm = ".assemblyman_openmenu";	// 의정활동메뉴 lnb
		}
		
		var wrapperWidth02 = $(window).width();	
		if(wrapperWidth02 < 1200) { 
			if( $(leftMenuClassNm).css("display") != "none" ) {
				$("body").removeClass("fixed-body");
				$(this).removeClass('fixed on');
				$(leftMenuClassNm).removeClass("fixed");
				$(leftMenuClassNm).hide();
				$(leftMenuClassNm).css('height', 'auto');
			} else {
				var mobileLnbHeight = $(window).height() - 95;
				$("body").addClass("fixed-body");
				$(this).addClass('fixed on');
				$(leftMenuClassNm).addClass("fixed");
				$(leftMenuClassNm).show();
				$(leftMenuClassNm).css('height', mobileLnbHeight + 'px');
			}
		} else {
			$(this).removeClass('on');
			$(leftMenuClassNm).show();
			$(".hide-pc-lnb " + leftMenuClassNm).hide();
		}
		
	});	
	
	/* 국회의원 모바일 */
	if ( GC_ISMOBILE ) {
		$(".assembly_human_info > div > div").hide();
		$(".assembly_human_info > div > form").hide();
	}
	
	$(".assembly_human_info h5").click(function(){
		$(this).next().slideToggle(300);
		$(".assembly_human_info h5").not(this).next().slideUp(300);
		return false;
	});
	
	/* 의정활동별공개 열기/닫기 버튼 */
	$(".leftmenu_close").click(function() {
		$(".container").toggleClass("active_parliamentary");
		
		//웹접근성 조치 20.11.09
		if($(".container").hasClass("active_parliamentary")){
			$(".leftmenu_close").text("열기");
		}else{
			$(".leftmenu_close").text("닫기");
		}
	});	
	
	/* 전체 메뉴 모바일 */
	$(".mh_allmenu").click(function() {
		$(this).toggleClass('on');
		$("body").toggleClass('fixed-body');
		$(".totalmenu-mobile").slideToggle(150);

		if($(".totalmenu-mobile").css("display") != "none") {
			$(".totalmenu-area-mobile h2 a").removeClass('on');
			$(".totalmenu-area-mobile ul").hide();
			$(".totalmenu-area-mobile ul.selected").show();
		}
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