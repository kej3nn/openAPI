/*
 * @(#)useServiceIntro.js 1.0 2019/09/03
 * 
 * 서비스 이용안내 스크립트
 */
$(function() {
	
	/* pc 서비스 메뉴 선택 */
	$(".service-menu-wrapper.pc li a").on("click", function() {
		var choiseBox = $(this).attr('class');

		$("." + choiseBox).prop("selected", true);

		$(".service-menu-wrapper > li > a").removeClass('on');
		$(this).addClass('on');

		choiseBox = choiseBox.replace(/[^0-9]/g,"");
		$(".service-information-wrapper").removeClass('on');
		$(".service-information-box" + choiseBox).addClass('on');
	});

	/* 모바일 셀렉트박스 선택 */
	$("#service-menu-select").on("change", function() {
		var choiseOption = $(this).children("option:selected").attr('class');
		$(".service-menu-wrapper > li > a").removeClass('on');
		$(".service-menu-wrapper > li > a." + choiseOption).addClass('on');

		choiseOption = choiseOption.replace(/[^0-9]/g,"");
		$(".service-information-wrapper").removeClass('on');
		$(".service-information-box" + choiseOption).addClass('on');
	});
	
	// GNB메뉴 바인딩한다.
	menuOn(5, 2);
    
});

