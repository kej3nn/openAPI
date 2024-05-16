// 전체메뉴 보기 
function btn_view_allMenu(obj_id)
{
    document.getElementById(obj_id).style.display = "";
}
function btn_close_allMenu(obj_id)
{
    document.getElementById(obj_id).style.display = "none";
}


$(document).ready(function(){
    var selectOpenClose = false; // 별점 셀렉트 열기닫기버튼의 활성화 지표
    var familySiteOpenClose = false; //페밀리 사이트 셀렉트 활성화 지표

    //인기데이터
    $('.btn_bestData_L').on('click', function(){
        $('#bestData').css('top',0);
    });
    $('.btn_bestData_R').on('click', function(){
        $('#bestData').css('top',-116);
    });
    
    //sortMenu reset
    var w = $(window).width();
    var h = $(window).height();
    if(w >= 980){
        sortMenu();
    }
    else {
        var sortSpan = $('.area_menu_sort .sort span').width();
        sortMenuT(sortSpan);
    }
    
    // 별점 셀렉트 기능
    $('.toggle_grade').click(function(){
        $('#view_grade').slideToggle(function(){
            if(selectOpenClose == false){
                $('#toggle_grade').attr('src',com.wise.help.url('/img/ggportal/desktop/common/toggle_open_grade.png'));
                selectOpenClose = true;
            }
            else {
                $('#toggle_grade').attr('src',com.wise.help.url('/img/ggportal/desktop/common/toggle_open_grade.png'));   
                selectOpenClose = false;
            }
        });
    });

    //페밀리 사이트 셀렉트 토글
    $('.toggle_familySite').unbind("click");
    $('.toggle_familySite').click(function(){
        $('#view_familySite').slideToggle(function(){
            if(familySiteOpenClose == false){
                familySiteOpenClose = true;
            }
            else {
                familySiteOpenClose = false;
            }
        });
    });

	// GNB focus control 
	$('h1 a, #view_totalSearch input').on('focus', function(){
		$('#subNavi_1, #subNavi_2, #subNavi_3').css('visibility','hidden');
	});
	$('.navi_1 > a').on('focus', function(){
		$('#subNavi_2').css('visibility','hidden');
	});
	$('.navi_2 > a').on('focus', function(){
		$('#subNavi_1, #subNavi_3').css('visibility','hidden');
	});
	$('.navi_3 > a').on('focus', function(){
		$('#subNavi_2').css('visibility','hidden');
	});

});

// new gnb
$(function(){

	$('.gnbArea .gnbMenu a').on('focusin', function(){
		$('.autoComplete .layer').hide();
	});
	$('#content').on('focusin', function(){
		$('.gnbSub').stop().slideUp("fast");
	});

	$('.gnbArea').on('mouseleave', function(){
		$('.gnbSub').stop().slideUp("fast");
	});
	$('.gnbSub .sub').on('focusin', function(){
		$('.gnbSub').slideDown("fast");
		$('.gnbSub .sub').removeClass('on');
		$(this).addClass('on');
	});
	/* 180108/KIMJH - gnb 변경
	$('.navMenu > ul > li > a').unbind('click');
	$('.navMenu > ul > li > a').on('click', function(){
		if($('.gnbSub').is(':hidden')) {
			$('.gnbSub').stop().slideDown(function(){
				$('.gnbSub').animate({height:155});
			});
		}else{ 
			$('.gnbSub').stop().slideUp();
		}
		return false;
	});
	*/
	//1레벨 메뉴 over했을 경우
	$('.gnbMenu, .gnbNew').on('mouseover', function(){
		if($('.gnbSub').is(':hidden')) {
			$('.gnbSub').stop().slideDown("fast", function(){
				$('.gnbSub').animate({height:197});
			});
		}
		$(this).find("li").on('mouseover', function(){
			if($('.gnbSub').is(':hidden')) {
				$('.gnbSub').stop().slideDown("fast", function(){
					$('.gnbSub').animate({height:197});
				});
			}
			var i = $(this).index();
			$(".gnbSubNew").prop("class", "gnbSubNew gnbBg0" + String(i+1));	//이미지 변경
			setGnbSubText(i);	//메뉴에 맞는 text변경
			return false;
		});
		return false;
	});
	
	//sub메뉴 over 했을경우
	$(".gnbSub .sub").on("mouseover", function() {
		var i = $(this).index();
		$(".gnbSubNew").prop("class", "gnbSubNew gnbBg0" + String(i+1));	//이미지 변경
		setGnbSubText(i);	//메뉴에 맞는 text변경
	});
	
	$('.navMenu > ul > li > a').on('mouseover', function(){
		var i = $(this).parent().index();

		$('.gnbSub .sub').removeClass('on');
		$('.gnbSub .sub').eq(i).addClass('on');
	});
	$('.navMenu > ul > li > a').on('mouseout', function(){
		$('.gnbSub .sub').removeClass('on');
	});


});

// sortMenu 
$(window).resize(function(){
    var w = $(window).width();
    var h = $(window).height();
    if(w >= 980){
        sortMenu();
    }
    else {
        var sortSpan = $('.area_menu_sort .sort span').width();
        sortMenuT(sortSpan);
    }
});

function sortMenu(s){
    $('.btn_slide_sortMenu_L').on('click', function(){
        $('.area_menu_sort .sort').stop().animate({left : 0},500);
    });
    $('.btn_slide_sortMenu_R').on('click', function(){
        $('.area_menu_sort .sort').stop().animate({left : -490},500);
    });
}

function sortMenuT(s){
    $('.btn_slide_sortMenu_L').on('click', function(){
        $('.area_menu_sort .sort').stop().animate({left : 0},500);
    });
    $('.btn_slide_sortMenu_R').on('click', function(){
        $('.area_menu_sort .sort').stop().animate({left : (s*7)*-1},500);
    });
}

// 통합검색 열기 
$(function(){
    var totalSearch = false;
    $('.toggle_totalSearch').click(function(){
        $('#view_totalSearch').slideToggle(function(){
            if(totalSearch == false){
                $('#toggle_totalSearch').attr('src',com.wise.help.url('../img/ggportal/mobile/common/btn_close_allMenu.png'));
                totalSearch = true;
            }
            else {
                $('#toggle_totalSearch').attr('src',com.wise.help.url('../img/ggportal/mobile/common/btn_close_allMenu.png'));  
                totalSearch = false;
            }
        });
    });
});

// 메타정보열기 
$(function(){
    var metaInfoOpenClose = false;
    $('.toggle_metaInfo').click(function(){
        $('#metaInfo').toggle(function(){
            if(metaInfoOpenClose == false){
            $('#metaInfo').removeClass('metaInfo').addClass('view_metaInfo');
            $('.toggle_metaInfo').html('<strong>메타 정보 닫기</strong><img src="' + com.wise.help.url("/img/ggportal/desktop/common/toggle_colse_metaInfo.png") + '" alt="" />');
            metaInfoOpenClose = true;
        }
        else {
            $('#metaInfo').removeClass('view_metaInfo').addClass('metaInfo');
            $('.toggle_metaInfo').html('<strong>메타 정보 열기</strong><img src="' + com.wise.help.url("/img/ggportal/desktop/common/toggle_open_metaInfo.png") + '" alt="" />');
            metaInfoOpenClose = false;
        }
        });
    });
});

/* 메타정보열기 
var metaInfoOpenClose = false;
function toggleMetaInfo(){
    $('#metaInfo').slideToggle(function(){
        if(metaInfoOpenClose == false){
                $('#metaInfo').removeClass('view_metaInfo').addClass('metaInfo');
                $('.toggle_metaInfo').html('<strong>메타 정보 닫기</strong><img src="' + com.wise.help.url("/img/ggportal/desktop/common/toggle_colse_metaInfo.png") + '" alt="" />');
                metaInfoOpenClose = true;
            }
        else {
            $('#metaInfo').removeClass('metaInfo').addClass('view_metaInfo');
            $('.toggle_metaInfo').html('<strong>메타 정보 열기</strong><img src="' + com.wise.help.url("/img/ggportal/desktop/common/toggle_open_metaInfo.png") + '" alt="" />');
            metaInfoOpenClose = false;
        }
    });
}
/* 메타정보열기 E */

// 검색 열기 
$(function(){
    var searchOpenClose = false;
    $('.toggle_search_C').unbind('click')
    $('.toggle_search_C').click(function(){
        $('#search_C').toggle(function(){
            if(searchOpenClose == false){
            $('#search_C').removeClass('view_search_C').addClass('.close_search_C');
            $('.toggle_search_C').html('검색 닫기 <img src="' + com.wise.help.url("/img/ggportal/desktop/common/toggle_colse_search_C.png") + '" alt="" />');
            searchOpenClose = true;
        }
        else {
            $('#search_C').removeClass('.close_search_C').addClass('view_search_C');
            $('.toggle_search_C').html('검색 <img src="' + com.wise.help.url("/img/ggportal/desktop/common/toggle_open_search_C.png") + '" alt="" />');
            searchOpenClose = false;
        }
        });
    });
});

// 지도 
function ovr_select_map(obj_id)
{
    $('#'+obj_id+'').fadeIn('fast');
}
function out_select_map(obj_id)
{
    $('#'+obj_id+'').fadeOut('fast');
}

// 지역 선택 레이어 팝업 
jQuery(function($){
    var loginWindow = $('.layout_layerPopup_A_map');
    var login = $('#layerPopup_map');
    
    // Show Hide
    $('.btn_view_layerPopup_map').click(function(){
        loginWindow.addClass('view');
    });
    $('#layerPopup_map .btn_close').click(function(){
        loginWindow.removeClass('view');
    });
    $('#layerPopup_map2 .btn_close').click(function(){
        loginWindow.removeClass('view');
        return false;
    });
    
    // ESC Event
    $(document).keydown(function(event){
        if(event.keyCode != 27) return true;
        if (loginWindow.hasClass('view')) {
            loginWindow.removeClass('view');
        }
        return false;
    });
    
    // Hide Window
    loginWindow.find('>.transparent').mousedown(function(event){
        loginWindow.removeClass('view');
        return false;
    });
});

// 메타보기 레이어 팝업 
jQuery(function($){
    var loginWindow = $('.layout_layerPopup_A_meta');
    var login = $('#layerPopup_meta');
    
    // Show Hide
    $('.btn_view_layerPopup_meta').click(function(){
        loginWindow.addClass('view');
    });
    $('#layerPopup_meta .btn_close').click(function(){
        loginWindow.removeClass('view');
        return false;
    });
    
    // ESC Event
    $(document).keydown(function(event){
        if(event.keyCode != 27) return true;
        if (loginWindow.hasClass('view')) {
            loginWindow.removeClass('view');
        }
        return false;
    });
    
    // Hide Window
    loginWindow.find('>.transparent').mousedown(function(event){
        loginWindow.removeClass('view');
        return false;
    });
});


// 인기태그 레이어 팝업 
jQuery(function($){
    var loginWindow = $('.layout_layerPopup_A_bestTag');
    var login = $('#layerPopup_bestTag');
    
    // Show Hide
    $('.btn_view_layerPopup_bestTag').click(function(){
        loginWindow.addClass('view');
    });
    $('#layerPopup_bestTag .btn_close').click(function(){
        loginWindow.removeClass('view');
    });
    
    // ESC Event
    $(document).keydown(function(event){
        if(event.keyCode != 27) return true;
        if (loginWindow.hasClass('view')) {
            loginWindow.removeClass('view');
        }
        return false;
    });
    
    // Hide Window
    loginWindow.find('>.transparent').mousedown(function(event){
        loginWindow.removeClass('view');
        return false;
    });
});

// 제공기관 레이어 팝업 
jQuery(function($){
    var loginWindow = $('.layout_layerPopup_A_providingOrganization');
    var login = $('#layerPopup_providingOrganization');
    
    // Show Hide
    $('.btn_view_layerPopup_providingOrganization').click(function(){
        loginWindow.addClass('view');
    });
    $('#layerPopup_providingOrganization .btn_close').click(function(){
        loginWindow.removeClass('view');
    });
    
    // ESC Event
    $(document).keydown(function(event){
        if(event.keyCode != 27) return true;
        if (loginWindow.hasClass('view')) {
            loginWindow.removeClass('view');
        }
        return false;
    });
    
    // Hide Window
    loginWindow.find('>.transparent').mousedown(function(event){
        loginWindow.removeClass('view');
        return false;
    });
});

// 비밀번호 레이어 팝업 
jQuery(function($){
    var loginWindow = $('.layout_layerPopup_A_password');
    var login = $('#layerPopup_password');
    
    // Show Hide
    $('.btn_view_layerPopup_password').click(function(){
        loginWindow.addClass('view');
    });
    $('#layerPopup_password .btn_close').click(function(){
        loginWindow.removeClass('view');
    });
    
    // ESC Event
    $(document).keydown(function(event){
        if(event.keyCode != 27) return true;
        if (loginWindow.hasClass('view')) {
            loginWindow.removeClass('view');
        }
        return false;
    });
    
    // Hide Window
    loginWindow.find('>.transparent').mousedown(function(event){
        loginWindow.removeClass('view');
        return false;
    });
});

// 관련서비스 레이어 팝업 
jQuery(function($){
    var loginWindow = $('.layout_layerPopup_A_dataSet_service');
    var login = $('#layerPopup_dataSet_service');
    
    // Show Hide
    $('.btn_view_layerPopup_dataSet_service').click(function(){
        loginWindow.addClass('view');
    });
    $('#layerPopup_dataSet_service .btn_close').click(function(){
        loginWindow.removeClass('view');
    });
    
    // ESC Event
    $(document).keydown(function(event){
        if(event.keyCode != 27) return true;
        if (loginWindow.hasClass('view')) {
            loginWindow.removeClass('view');
        }
        return false;
    });
    
    // Hide Window
    loginWindow.find('>.transparent').mousedown(function(event){
        loginWindow.removeClass('view');
        return false;
    });
});

// // FAQ 
// $(function() {
//     $('dd.answer').hide();
//     $('a.question').click(function() {
//             $('dd.answer').slideUp('fast'); 
//             $('a.question').removeClass('on');
//             var slidedownelement = $(this).closest('dl.dl_FAQ').find('dd.answer').eq(0);
//             if(!slidedownelement.is(':visible')) {
//             slidedownelement.slideDown('fast'); 
//             $(this).addClass('on');
//         }
//         return false;
//     });
// });

// view_subNavi
function view_subNavi(id) {
    for(num=1; num<=3; num++) document.getElementById('subNavi_'+num).style.visibility ='hidden'; //
    document.getElementById(id).style.visibility ='visible'; //
}
$(function(){
    $('.area_navi').bind('mouseleave', function(){
//        console.log('leaver');
        $('.subNavi:visible').css("visibility", "hidden");
    });
});

// 메인 갤러리
function ovr_gallery_summary(obj_id)
{
    document.getElementById(obj_id).style.display = "";
}
function out_gallery_summary(obj_id)
{
    document.getElementById(obj_id).style.display = "none";
}

// tab_B_1 
$(function(){
    $("#tab_B > a").click(function(e){
        switch(this.id){
            case "tab_B_1":
                $("#tab_B_1").addClass("on");
                $("#tab_B_2").removeClass("on");
                $("#tab_B_3").removeClass("on");
                $("#tab_B_4").removeClass("on");

                $("#tab_B_cont_1").fadeIn();
                $("#tab_B_cont_2").css("display", "none");
                $("#tab_B_cont_3").css("display", "none");
                $("#tab_B_cont_4").css("display", "none");
            break;
            case "tab_B_2":
                $("#tab_B_1").removeClass("on");
                $("#tab_B_2").addClass("on");
                $("#tab_B_3").removeClass("on");
                $("#tab_B_4").removeClass("on");

                $("#tab_B_cont_2").fadeIn();
                $("#tab_B_cont_1").css("display", "none");
                $("#tab_B_cont_3").css("display", "none");
                $("#tab_B_cont_4").css("display", "none");
            break;
            case "tab_B_3":
                $("#tab_B_1").removeClass("on");
                $("#tab_B_2").removeClass("on");
                $("#tab_B_3").addClass("on");
                $("#tab_B_4").removeClass("on");

                $("#tab_B_cont_3").fadeIn();
                $("#tab_B_cont_1").css("display", "none");
                $("#tab_B_cont_2").css("display", "none");
                $("#tab_B_cont_4").css("display", "none");
            break;
            case "tab_B_4":
                $("#tab_B_1").removeClass("on");
                $("#tab_B_2").removeClass("on");
                $("#tab_B_3").removeClass("on");
                $("#tab_B_4").addClass("on");

                $("#tab_B_cont_4").fadeIn();
                $("#tab_B_cont_1").css("display", "none");
                $("#tab_B_cont_2").css("display", "none");
                $("#tab_B_cont_3").css("display", "none");
            break;
        }
        return false;
    });
});

// 멀티미디어 상세
$(function(){
    $("#tab_mediaDetail  > span").click(function(e){
        switch(this.id){
            case "tab_mediaDetail_1":
                $("#tab_mediaDetail_1").addClass("on");
                $("#tab_mediaDetail_2").removeClass("on");
                $("#tab_mediaDetail_3").removeClass("on");
                $("#tab_mediaDetail_4").removeClass("on");
                $("#tab_mediaDetail_5").removeClass("on");
                $("#tab_mediaDetail_6").removeClass("on");
                $("#tab_mediaDetail_7").removeClass("on");
                $("#tab_mediaDetail_8").removeClass("on");
                $("#tab_mediaDetail_cont_1").fadeIn();
                $("#tab_mediaDetail_cont_2").css("display", "none");
                $("#tab_mediaDetail_cont_3").css("display", "none");
                $("#tab_mediaDetail_cont_4").css("display", "none");
                $("#tab_mediaDetail_cont_5").css("display", "none");
                $("#tab_mediaDetail_cont_6").css("display", "none");
                $("#tab_mediaDetail_cont_7").css("display", "none");
                $("#tab_mediaDetail_cont_8").css("display", "none");
            break;
            case "tab_mediaDetail_2":
                $("#tab_mediaDetail_1").removeClass("on");
                $("#tab_mediaDetail_2").addClass("on");
                $("#tab_mediaDetail_3").removeClass("on");
                $("#tab_mediaDetail_4").removeClass("on");
                $("#tab_mediaDetail_5").removeClass("on");
                $("#tab_mediaDetail_6").removeClass("on");
                $("#tab_mediaDetail_7").removeClass("on");
                $("#tab_mediaDetail_8").removeClass("on");
                $("#tab_mediaDetail_cont_2").fadeIn();
                $("#tab_mediaDetail_cont_1").css("display", "none");
                $("#tab_mediaDetail_cont_3").css("display", "none");
                $("#tab_mediaDetail_cont_4").css("display", "none");
                $("#tab_mediaDetail_cont_5").css("display", "none");
                $("#tab_mediaDetail_cont_6").css("display", "none");
                $("#tab_mediaDetail_cont_7").css("display", "none");
                $("#tab_mediaDetail_cont_8").css("display", "none");
            break;
            case "tab_mediaDetail_3":
                $("#tab_mediaDetail_1").removeClass("on");
                $("#tab_mediaDetail_2").removeClass("on");
                $("#tab_mediaDetail_3").addClass("on");
                $("#tab_mediaDetail_4").removeClass("on");
                $("#tab_mediaDetail_5").removeClass("on");
                $("#tab_mediaDetail_6").removeClass("on");
                $("#tab_mediaDetail_7").removeClass("on");
                $("#tab_mediaDetail_8").removeClass("on");
                $("#tab_mediaDetail_cont_3").fadeIn();
                $("#tab_mediaDetail_cont_1").css("display", "none");
                $("#tab_mediaDetail_cont_2").css("display", "none");
                $("#tab_mediaDetail_cont_4").css("display", "none");
                $("#tab_mediaDetail_cont_5").css("display", "none");
                $("#tab_mediaDetail_cont_6").css("display", "none");
                $("#tab_mediaDetail_cont_7").css("display", "none");
                $("#tab_mediaDetail_cont_8").css("display", "none");
            break;
            case "tab_mediaDetail_4":
                $("#tab_mediaDetail_1").removeClass("on");
                $("#tab_mediaDetail_2").removeClass("on");
                $("#tab_mediaDetail_3").removeClass("on");
                $("#tab_mediaDetail_4").addClass("on");
                $("#tab_mediaDetail_5").removeClass("on");
                $("#tab_mediaDetail_6").removeClass("on");
                $("#tab_mediaDetail_7").removeClass("on");
                $("#tab_mediaDetail_8").removeClass("on");
                $("#tab_mediaDetail_cont_4").fadeIn();
                $("#tab_mediaDetail_cont_1").css("display", "none");
                $("#tab_mediaDetail_cont_2").css("display", "none");
                $("#tab_mediaDetail_cont_3").css("display", "none");
                $("#tab_mediaDetail_cont_5").css("display", "none");
                $("#tab_mediaDetail_cont_6").css("display", "none");
                $("#tab_mediaDetail_cont_7").css("display", "none");
                $("#tab_mediaDetail_cont_8").css("display", "none");
            break;
            case "tab_mediaDetail_5":
                $("#tab_mediaDetail_1").removeClass("on");
                $("#tab_mediaDetail_2").removeClass("on");
                $("#tab_mediaDetail_3").removeClass("on");
                $("#tab_mediaDetail_4").removeClass("on");
                $("#tab_mediaDetail_5").addClass("on");
                $("#tab_mediaDetail_6").removeClass("on");
                $("#tab_mediaDetail_7").removeClass("on");
                $("#tab_mediaDetail_8").removeClass("on");
                $("#tab_mediaDetail_cont_5").fadeIn();
                $("#tab_mediaDetail_cont_1").css("display", "none");
                $("#tab_mediaDetail_cont_2").css("display", "none");
                $("#tab_mediaDetail_cont_3").css("display", "none");
                $("#tab_mediaDetail_cont_4").css("display", "none");
                $("#tab_mediaDetail_cont_6").css("display", "none");
                $("#tab_mediaDetail_cont_7").css("display", "none");
                $("#tab_mediaDetail_cont_8").css("display", "none");
            break;
            case "tab_mediaDetail_6":
                $("#tab_mediaDetail_1").removeClass("on");
                $("#tab_mediaDetail_2").removeClass("on");
                $("#tab_mediaDetail_3").removeClass("on");
                $("#tab_mediaDetail_4").removeClass("on");
                $("#tab_mediaDetail_5").removeClass("on");
                $("#tab_mediaDetail_6").addClass("on");
                $("#tab_mediaDetail_7").removeClass("on");
                $("#tab_mediaDetail_8").removeClass("on");
                $("#tab_mediaDetail_cont_6").fadeIn();
                $("#tab_mediaDetail_cont_1").css("display", "none");
                $("#tab_mediaDetail_cont_2").css("display", "none");
                $("#tab_mediaDetail_cont_3").css("display", "none");
                $("#tab_mediaDetail_cont_4").css("display", "none");
                $("#tab_mediaDetail_cont_5").css("display", "none");
                $("#tab_mediaDetail_cont_7").css("display", "none");
                $("#tab_mediaDetail_cont_8").css("display", "none");
            break;
            case "tab_mediaDetail_7":
                $("#tab_mediaDetail_1").removeClass("on");
                $("#tab_mediaDetail_2").removeClass("on");
                $("#tab_mediaDetail_3").removeClass("on");
                $("#tab_mediaDetail_4").removeClass("on");
                $("#tab_mediaDetail_5").removeClass("on");
                $("#tab_mediaDetail_6").removeClass("on");
                $("#tab_mediaDetail_7").addClass("on");
                $("#tab_mediaDetail_8").removeClass("on");
                $("#tab_mediaDetail_cont_7").fadeIn();
                $("#tab_mediaDetail_cont_1").css("display", "none");
                $("#tab_mediaDetail_cont_2").css("display", "none");
                $("#tab_mediaDetail_cont_3").css("display", "none");
                $("#tab_mediaDetail_cont_4").css("display", "none");
                $("#tab_mediaDetail_cont_5").css("display", "none");
                $("#tab_mediaDetail_cont_6").css("display", "none");
                $("#tab_mediaDetail_cont_8").css("display", "none");
            break;
            case "tab_mediaDetail_8":
                $("#tab_mediaDetail_1").removeClass("on");
                $("#tab_mediaDetail_2").removeClass("on");
                $("#tab_mediaDetail_3").removeClass("on");
                $("#tab_mediaDetail_4").removeClass("on");
                $("#tab_mediaDetail_5").removeClass("on");
                $("#tab_mediaDetail_6").removeClass("on");
                $("#tab_mediaDetail_7").removeClass("on");
                $("#tab_mediaDetail_8").addClass("on");
                $("#tab_mediaDetail_cont_8").fadeIn();
                $("#tab_mediaDetail_cont_1").css("display", "none");
                $("#tab_mediaDetail_cont_2").css("display", "none");
                $("#tab_mediaDetail_cont_3").css("display", "none");
                $("#tab_mediaDetail_cont_4").css("display", "none");
                $("#tab_mediaDetail_cont_5").css("display", "none");
                $("#tab_mediaDetail_cont_6").css("display", "none");
                $("#tab_mediaDetail_cont_7").css("display", "none");
            break;
        }
        return false;
    });
});

//공지사항 레이어 팝업 
jQuery(function($){
    var loginWindow = $('.layout_layerPopup_A_notice');
    var login = $('#layerPopup_notice');
    
   loginWindow.addClass('view');
   //loginWindow.draggable();

    $('#layerPopup_notice .btn_close').click(function(){
        loginWindow.removeClass('view');
    });

});

//이벤트 레이어 팝업 
jQuery(function($){
	
	//$('.eventPop').draggable();

	$('.eventPop .btn_close').click(function(){
		 $('.eventPop').hide();
	});
	
	   // ESC Event
    $(document).keydown(function(event){
        if(event.keyCode != 27) return true;
        else $('.eventPop').hide();
        return false;
    });

	
});



$(function(){
	$('#link1').on('change', function(){
		
		$('#link1').hide();
	})
	
})


//ㅍㅏ라미터 분리해주는 함수 - 2017.08.21
function separateParams(params){
	var params = (params.replace("?", "")).split("&");
	var paramArr = {};
	$.each(params, function(idx, value){
		value = value.split("=");
		paramArr[value[0]] = value[1];
	});
	$.each(paramArr, function(key, value){
		$("input[name="+key+"]").val(value);
	});
}


