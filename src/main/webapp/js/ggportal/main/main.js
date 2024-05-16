/*
 * @(#)main.js 1.0 2018/01/15
 * 
 * COPYRIGHT (C) 2013 WISEITECH CO., LTD. ALL RIGHTS RESERVED.
 */

/**
 * 메인 화면 스크립트이다.
 *
 * @author 김정호
 * @version 1.0 2018/01/08
 */
$(function() {
    // 컴포넌트를 초기화한다.
    initComp();
    
    // 마스크를 바인딩한다.
    bindMask();
    
    // 이벤트를 바인딩한다.
    bindEvent();
    
    // 옵션을 로드한다.
    loadOptions();
    
    // 데이터를 로드한다.
    //loadData();
    
});

////////////////////////////////////////////////////////////////////////////////
// 글로벌 변수
////////////////////////////////////////////////////////////////////////////////
/*
 * 오늘
 */
var today = new Date();

/**
 * 템플릿
 */
var templates = {
    dataset:{
        data:
        	"<li><img src=\"\" alt=\"\" /><a href=\"#\" class=\"infNm\"></a></li>",
        none:
            "<li class=\"noData\">해당 자료가 없습니다.</li>"
    },
    notice:{	
        data:
            "<li>" 															+
	            "<a href=\"#\" class=\"bbsTit\"></a> "				 +
	            "<span class=\"date\"></span> " 					+
            "</li>",
        none:
            "<li class=\"noData\">해당 자료가 없습니다.</li>"
    },
    recommend:{
    	data:
    		"<li><i></i><a href=\"#\" class=\"recomm_txt\"></a></li>",
    	none:
    		"<ul class=\"recomm_list\"><li><a href=\"#\" class=\"recomm_txt\">해당 자료가 없습니다.</a></li></ul>"
    },
    gallery: {
    	data:
    		"<li>"
    		+"<div class=\"area_thumbnail_gallery\">"                           
			+"	<a href=\"javascript:;\" class=\"thumbnail_gallery\">"                            
			//+"	<img src=''  class='gallery-others-image' alt='' />
			+"	</a>"                                                       
			+"</div>"
			+"</li>",
		none:
			"<li class=\"noData\">해당 자료가 없습니다.</li>"
    }
};

/**
 * 슬라이더
 */
var sliders = {
	banner: null,
	population: null,
    gallery:null,
    recommend:null
};

////////////////////////////////////////////////////////////////////////////////
// 초기화 함수
////////////////////////////////////////////////////////////////////////////////
/**
 * 컴포넌트를 초기화한다.
 */
function initComp() {
	//메인 팝업(임시)
	mainPop();
	
	//bxslider를 적용한다.
	//setBxsliders();
}

/**
 * 마스크를 바인딩한다.
 */
function bindMask() {
    // Nothing to do.
}

/**
 * 이벤트를 바인딩한다.
 */
function bindEvent() {
    $(window).bind("resize", function(event) {
        // 슬라이더를 리로드한다.
        //reloadSliders();
    });
    
    //데이터셋 분류 버튼 이벤트
    $(".dataset-category-button").each(function(index, element) {
        // 공공데이터 데이터셋 카테고리 버튼에 클릭 이벤트를 바인딩한다.
        $(this).bind("click", function(event) {
            // 공공데이터 데이터셋 카테고리를 변경한다.
        	searchDataset($(this).attr("href").substring(1));
            return false;
        });
        
        // 공공데이터 데이터셋 카테고리 버튼에 키다운 이벤트를 바인딩한다.
        $(this).bind("keydown", function(event) {
            if (event.which == 13) {
                // 공공데이터 데이터셋 카테고리를 변경한다.
            	searchDataset($(this).attr("href").substring(1));
                return false;
            }
            
        });
    });

    //간편통계
    $(".flex_menu_main section:eq(2)").find(".deco a, .btn_more").bind("click", function(event) { locationMove("/portal/stat/easyStatSch.do"); });
    //지도 검색
    $(".flex_menu_main section:eq(3)").find(".deco a, .btn_more").bind("click", function(event) { locationMove("/portal/adjust/map/mapSearchPage.do"); });
    //활용갤러리
    $(".flex_menu_main section:eq(4)").find(".btn_more"			).bind("click", function(event) { locationMove("/portal/bbs/gallery/searchBulletinPage.do"); });
    //아이디어 제안
    $(".flex_menu_main section:eq(5)").find(".deco a, .btn_more").bind("click", function(event) { locationMove("/portal/bbs/idea/searchBulletinPage.do"); });
    //공지사항 더보기
    $("#noticeBtnMore").bind("click", function(event) { locationMove("/portal/bbs/notice/searchBulletinPage.do"); });
    
}

/**
 * 옵션을 로드한다.
 */
function loadOptions() {
    // Nothing do do.
}

/**
 * 데이터를 로드한다.
 */
function loadData() {
	searchGallery();
	//주간 인기순위를 조회한다.
	selectDataset("weekly");
	//월간 인기순위를 조회한다.
	selectDataset("monthly");
	//공지사항을 조회한다.
	searchNotice("current");
	//데이터셋 추천순위를 조회한다.
	selectDataset("recommend");
}

////////////////////////////////////////////////////////////////////////////////
// 서비스 함수
////////////////////////////////////////////////////////////////////////////////
/**
 * 공공데이터 데이터셋으로 리스트로 이동한다.
 * @param 	value	분류ID
 */
function searchDataset(value) {
	$('#datasts-search-form').empty();
	$('#datasts-search-form').html('<input type="hidden" name="cateId" value=""/>');
	// 데이터를 검색하는 화면으로 이동한다.
	goSearch({
	    url:"/portal/data/dataset/searchDatasetPage.do",
	    form:"dataset-search-form",
	    data:[{
	        name:"cateId",
	        value:value
	    }]
	});
}

/*
 * 활용갤러리를 조회한다.
 */
function searchGallery() {
    // 데이터를 검색한다.
    doSearch({
        url: "/portal/bbs/gallery/searchBulletin.do",
        page: "1",
        before:beforeSearchGallery,
        after:afterSearchGallery
    });
}

/**
 * 공공데이터 데이터셋 상세로 이동한다.
 * @param mode
 */
function selectDataset(mode) {
    switch (mode) {
        case "weekly":
            // 주간 인기 데이터를 검색한다.
            doSearch({
                url:"/portal/data/dataset/searchWeekly.do",
                before:beforeSearchWeekly,
                after:afterSearchWeekly
            });
            break;
        case "monthly":
            // 월간 인기 데이터를 검색한다.
            doSearch({
                url:"/portal/data/dataset/searchMonthly.do",
                before:beforeSearchMonthly,
                after:afterSearchMonthly
            });
            break;
        case "recommend":
            // 데이터를 검색한다.
            doSearch({
                url:"/portal/data/dataset/searchRecommend.do",
                before: beforeSearchWeekly,
                after:afterSearchRecommend
            });
            break;
    }
}

/**
 * 공지 게시판 내용을 검색한다.
 * 
 * @param mode {String} 모드
 */
function searchNotice(mode) {
    switch (mode) {
        case "current":
            // 데이터를 검색한다.
            doSearch({
                url:"/portal/bbs/notice/searchBulletin.do",
                before:beforeSearchCurrent,
                after:afterSearchCurrent
            });
            break;
    }
}

/**
 * 공공데이터 서비스를 조회한다.
 * 
 * @param data {Object} 데이터
 */
function selectService(data) {
    $("#dataset-search-form [name=cateId]").attr("disabled", "disabled");
    
    // 데이터를 조회하는 화면으로 이동한다.
    goSelect({
        url:"/portal/data/service/selectServicePage.do",
        form:"dataset-search-form",
        data:[{
            name:"infId",
            value:data.infId
        }, {
            name:"infSeq",
            value:data.infSeq
        }]
    });
}

/**
 * 갤러리 게시판 내용을 조회한다.
 * 
 * @param data {Object} 데이터
 */
function selectGallery(data) {
    // 데이터를 조회하는 화면으로 이동한다.
    goSelect({
        url: "/portal/bbs/gallery/selectBulletinPage.do",
        form:"bbs-search-form",
        data:[{
            name:"bbsCd",
            value:data.bbsCd
        }, {
            name:"seq",
            value:data.seq
        }, {
            name:"noticeYn",
            value:data.noticeYn
        }]
    });
}

/**
 * 공지 게시판 내용을 조회한다.
 * 
 * @param data {Object} 데이터
 */
function selectNotice(data) {
    // 데이터를 조회하는 화면으로 이동한다.
    goSelect({
        url:"/portal/bbs/notice/selectBulletinPage.do",
        form:"bbs-search-form",
        data:[{
            name:"bbsCd",
            value:data.bbsCd
        }, {
            name:"seq",
            value:data.seq
        }, {
            name:"noticeYn",
            value:data.noticeYn
        }]
    });
}



/**
 * 페이지를 이동한다.
 * @param url
 */
function locationMove(url) {
	location.href = com.wise.help.url(url);
}

/**
 * 메인 팝업(임시)
 */
function mainPop() {
	/*
	$("#mainPopDiv").show();
	$("#mainPopDiv").bind("click", function(e) {
		$("#mainPopDiv").hide();
	});
	*/
	
	// 메인 window 팝업 오픈
	doSearch({
        url: "/portal/settings.do",
        before: function() {
        	return { homeTagCd : "BANER" }
        },
        after:function(res) {
        	//데이터가 있으면
        	if ( res.length > 0 ) {
        		// 쿠키정보 가져오는 function
        		function getCookie(name){
	                var nameOfCookie = name + "=";
	                var x = 0;
	                while (x <= document.cookie.length){
	                    var y = (x + nameOfCookie.length);
	                    if (document.cookie.substring(x, y) == nameOfCookie){
		                    if ((endOfCookie = document.cookie.indexOf(";", y)) == -1){
		                    	endOfCookie = document.cookie.length;
		                    }
		                    return unescape (document.cookie.substring(y, endOfCookie));
	                    }
	                    x = document.cookie.indexOf (" ", x) + 1;
	                    if (x == 0) break;
	                }
	                return "";
	            }
        		
        		// 설정 갯수에 따라 팝업 여러개 오픈
        		for ( var i=0; i < res.length; i++ ) {
        			var data = res[i];
        			if ( getCookie("mainPop" + data.seqceNo) != "done"){
    	            	var popParam = "?saveFileNm=" + data.saveFileNm
    	            		+ "&seqceNo=" + data.seqceNo
    	            		+ "&linkUrl=" + data.linkUrl 
    	            		+ "&srvTit=" + data.srvTit;
    	                var popUrl = "/portal/popupPage.do" + popParam;
    	                var popOption = "width=800, height=600, resizable=no, scrollbars=no, status=no;";
    	                window.open(popUrl,"",popOption);
    	            }
        		}
        	}

        }
    });
}
////////////////////////////////////////////////////////////////////////////////
// 전처리 함수
////////////////////////////////////////////////////////////////////////////////
/**
 * 공공데이터 데이터셋 주간순위 검색 전처리를 실행한다.
 * 
 * @param options {Object} 옵션
 * @returns {Object} 데이터
 */
function beforeSearchWeekly(options) {
    var data = {
        term:"W"
    };
    
    return data;
}

function beforeSearchGallery(options) {
    var data = {
    	bbsCd: "GALLERY",
    	page: 1,
    	rows: 5
    };
    return data;
}

/**
 * 공공데이터 데이터셋 월간순위 검색 전처리를 실행한다.
 * 
 * @param options {Object} 옵션
 * @returns {Object} 데이터
 */
function beforeSearchMonthly(options) {
    var data = {
        term:"M"
    };
    
    return data;
}

/**
 *  최근 공지 게시판 내용 검색 전처리를 실행한다.
 * 
 * @param options {Object} 옵션
 * @returns {Object} 데이터
 */
function beforeSearchCurrent(options) {
    var data = {
        page:"1",
        rows:"8"
    };
    
    return data;
}
////////////////////////////////////////////////////////////////////////////////
// 후처리 함수
////////////////////////////////////////////////////////////////////////////////
function afterSearchWeekly(data) {
    var list = $(".dataset-weekly-list");
    
    list.find("li").each(function(index, element) {
        $(this).remove();
    });
    for (var i = 0, n = 1; i < data.length; i++, n++) {
        var item = $(templates.dataset.data);
        item.find("img").attr("src", com.wise.help.url("/img/ggportal/desktop/main/num_rank_"+ (n<=9 ? "0":"") + String(n) + ".png")).attr("alt", n);
        item.find(".infNm").text(data[i].infNm);
        
        // 공공데이터 데이터셋 제목 링크에 클릭 이벤트를 바인딩한다.
        item.find("a").bind("click", {
            infId:data[i].infId,
            infSeq:data[i].infSeq
        }, function(event) {
            // 공공데이터 서비스를 조회한다.
            selectService(event.data);
            return false;
        });
        
        list.append(item);
    }
    
    if (data.length == 0) {
        var item = $(templates.dataset.none);
        
        list.append(item);
    }
    //windowResize();
}

/**
 * 활용갤러리 조회 후처리
 * @param data
 */
function afterSearchGallery(data) {
	var list = $("#gallery-data-list");
	list.find("li").each(function(index, element) {
        $(this).remove();
    });
	
	for (var i = 0, n = 1; i < data.length; i++, n++) {
        var item = $(templates.gallery.data);
        
        if ( data[i].fileSeq ) {
        	var url = com.wise.help.url("/portal/bbs/gallery/selectAttachFile.do") + "?fileSeq=" + data[i].fileSeq;
        	item.find(".thumbnail_gallery").append("<img src=\"" + url + "\" class=\"gallery-others-image\" alt=\"" + data[i].bbsTit + "\" />")
        }
        
     // 갤러리 게시판 내용 제목 링크에 클릭 이벤트를 바인딩한다.
        item.find("a").bind("click", {
            bbsCd:data[i].bbsCd,
            seq:data[i].seq,
            noticeYn:data[i].noticeYn,
            lockTag:data[i].lockTag
        }, function(event) {
            // 갤러리 게시판 내용을 조회한다.
            selectGallery(event.data);
            return false;
        });
        
        list.append(item);
	}
	
	if (data.length == 0) {
        var item = $(templates.gallery.none);
        
        list.append(item);
    } else {
    	sliders.gallery = $("#gallery-data-list").bxSlider({
    		mode : 'horizontal',
    	 	speed : 500,
    	 	pager : false,
    	 	moveSlider : 1,
    	 	autoHover : true,
    	 	controls : false,
    	 	slideMargin : 0,
    	 	startSlide : 0
        });
    }
}

/**
 * 공공데이터 데이터셋 월간순위 검색 후처리를 실행한다.
 * 
 * @param data {Array} 데이터
 */
function afterSearchMonthly(data) {
    var list = $(".dataset-monthly-list");
    
    list.find("li").each(function(index, element) {
        $(this).remove();
    });
    
    for (var i = 0, n = 1; i < data.length; i++, n++) {
        var item = $(templates.dataset.data);
        
        item.find("img").attr("src", com.wise.help.url("/img/ggportal/desktop/main/num_rank_"+ (n<=9 ? "0":"") + String(n) + ".png")).attr("alt", n);
        item.find(".infNm").text(data[i].infNm);
        
        // 공공데이터 데이터셋 제목 링크에 클릭 이벤트를 바인딩한다.
        item.find("a").bind("click", {
            infId:data[i].infId,
            infSeq:data[i].infSeq
        }, function(event) {
            // 공공데이터 서비스를 조회한다.
            selectService(event.data);
            return false;
        });
        
        list.append(item);
    }
    
    if (data.length == 0) {
        var item = $(templates.dataset.none);
        
        list.append(item);
    }
    //windowResize();
}

/**
 * 공지사항 검색 후처리를 실행한다.
 * 
 * @param data {Array} 데이터
 */
function afterSearchCurrent(data) {
	var list = $(".notice-current-list");
    
    list.find("li").each(function(index, element) {
        $(this).remove();
    });
    
    for (var i = 0, n = 1; i < data.length; i++, n++) {
    	var item = $(templates.notice.data);
        
        item.find(".bbsTit").text(data[i].bbsTit);
        // 공지 게시판 내용 제목 링크에 클릭 이벤트를 바인딩한다.
        item.find("a").bind("click", {
            bbsCd:data[i].bbsCd,
            seq:data[i].seq,
            noticeYn:data[i].noticeYn,
            lockTag:data[i].lockTag
        }, function(event) {
            // 공지 게시판 내용을 조회한다.
            selectNotice(event.data);
            return false;
        });
        
        list.append(item);
    }
    
    if (data.length == 0) {
        var item = $(templates.notice.none);
        
        list.append(item);
    } 
	
}

/**
 * 공공데이터 데이터셋 추천서비스  검색 후처리를 실행한다.
 * 
 * @param data {Array} 데이터
 */

function afterSearchRecommend(data) {
	var list = $("#dataset-recommend-list");
    var $ul = $("<ul class='recomm_list'></ul>");
    
    for (var i = 0; i < data.length; i++) {
    	var row = $(templates.recommend.data);
    	var no = data[i].no;
       
    	row.find("i").text(data[i].no);
    	row.find(".recomm_txt").text(data[i].infNm);
       
        // 공공데이터 데이터셋 링크에 클릭 이벤트를 바인딩한다.
    	row.find("a").bind("click", {
            infId:data[i].infId,
            infSeq:data[i].infSeq
        }, function(event) {
            // 공공데이터 서비스를 조회한다.
            selectService(event.data);
            return false;
        });
       
        $ul.append(row);
        
        if ( no % 5 == 0) {
        	//한개페이지에 5개씩 보여준다.
        	list.append($ul);
        	$ul = $("<ul class='recomm_list'></ul>");
        }
    }
    
    if (data.length == 0) {
        var item = $(templates.recommend.none);
        list.append(item);
    } else {
    	sliders.recommend = $("#dataset-recommend-list").bxSlider({
    		mode : 'horizontal',
    	 	speed : 500,
    	 	pager : false,
    	 	moveSlider : 1,
    	 	autoHover : true,
    	 	controls : false,
    	 	slideMargin : 0,
    	 	startSlide : 0
        });
    }

}
////////////////////////////////////////////////////////////////////////////////
// 이벤트 함수
////////////////////////////////////////////////////////////////////////////////

$(document).ready(function() {
	// ie8에서 창 슬라이더 문제
	//setTimeout(reloadSliders, 1500);
	
	// 인기데이터 모바일 화면 높이 설정
	$(window).resize(function() {
		//windowResize();
	});
});

