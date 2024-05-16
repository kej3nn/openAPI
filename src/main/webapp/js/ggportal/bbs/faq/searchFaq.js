/*
 * @(#)searchFaq.js 1.0 2015/06/15
 * 
 * COPYRIGHT (C) 2013 WISEITECH CO., LTD. ALL RIGHTS RESERVED.
 */

/**
 * FAQ 게시판 내용을 검색하는 스크립트이다.
 *
 * @author 김은삼
 * @version 1.0 2015/06/15
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
    loadData();
});

////////////////////////////////////////////////////////////////////////////////
// 글로벌 변수
////////////////////////////////////////////////////////////////////////////////
/**
 * 템플릿
 */
var templates = {
    data:
        "<dl class=\"dl_FAQ\">"                                                               +
            "<dt>"                                                                            +
                "<a href=\"#\" class=\"question bbsTit\"><span class=\"tit\">질문</span></a>" +
            "</dt>"                                                                           +
            "<dd class=\"answer bbsCont\">"                                                   +
                "<span class=\"tit\">답변</span>"                                             +
            "</dd>"                                                                           +
        "</dl>",
    none:
        "<dl class=\"dl_FAQ\">"                               +
            "<dt class=\"noData\">해당 자료가 없습니다.</dt>" +
        "</dl>"
};

////////////////////////////////////////////////////////////////////////////////
// 초기화 함수
////////////////////////////////////////////////////////////////////////////////
/**
 * 컴포넌트를 초기화한다.
 */
function initComp() {
    var code = $("#faq-search-form [name=listSubCd]").val();
    
    $(".faq-section-tab[href='#" + code + "']").addClass("on");
    
    $("#faq-searchtype-combo").val($("#faq-search-form [name=searchType]").val());
    $("#faq-searchword-field").val($("#faq-search-form [name=searchWord]").val());
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
    $(".faq-section-tab").each(function(index, element) {
        // FAQ 게시판 내용 섹션 탭에 클릭 이벤트를 바인딩한다.
        $(this).bind("click", function(event) {
            // FAQ 게시판 내용 섹션을 변경한다.
            changeFaqSection(this);
            return false;
        });
        
        // FAQ 게시판 내용 섹션 탭에 키다운 이벤트를 바인딩한다.
        $(this).bind("keydown", function(event) {
            if (event.which == 13) {
                // FAQ 게시판 내용 섹션을 변경한다.
                changeFaqSection(this);
                return false;
            }
        });
    });
    
    // FAQ 게시판 검색어 필드에 키다운 이벤트를 바인딩한다.
    $("#faq-searchword-field").bind("keydown", function(event) {
        if (event.which == 13) {
            // FAQ 게시판 검색어를 변경한다.
            changeFaqSearchWord();
            return false;
        }
    });
    
    // FAQ 게시판 검색 버튼에 클릭 이벤트를 바인딩한다.
    $("#faq-search-button").bind("click", function(event) {
        // FAQ 게시판 검색어를 변경한다.
        changeFaqSearchWord();
        return false;
    });
    
    // FAQ 게시판 검색 버튼에 키다운 이벤트를 바인딩한다.
    $("#faq-search-button").bind("keydown", function(event) {
        if (event.which == 13) {
            // FAQ 게시판 검색어를 변경한다.
            changeFaqSearchWord();
            return false;
        }
    });
    
 // 탭에 클릭 이벤트 바인딩
	$('#tab_layout > ul > li').each(function(i, d) {
		$(this).bind('click', function() {
			$("#tab_layout > ul > li > a").removeAttr("title")
			var id = $(this).attr("id");
			var idx = id.replace("tab_", "");
			var value = $(this).attr("value");
			$(this).find("a").attr("title", "확장됨");
			selectTab(idx);
			$('#faq-search-form [name=listSubCd]').val(value);
			searchFaq();
		});
	});
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
    // FAQ 게시판 내용을 검색한다.
    searchFaq($("#faq-search-form [name=page]").val());
}

////////////////////////////////////////////////////////////////////////////////
// 서비스 함수
////////////////////////////////////////////////////////////////////////////////
/**
 * FAQ 게시판 내용을 검색한다.
 * 
 * @param page {String} 페이지 번호
 */
function searchFaq(page) {
    // 데이터를 검색한다.
    doSearch({
        url:resolveUrl("/searchBulletin.do"),
        page:page ? page : "1",
        before:beforeSearchFaq,
        after:afterSearchFaq,
        pager:"faq-pager-sect",
        counter:{
            count:"faq-count-sect",
            pages:"faq-pages-sect"
        }
    });
}

/**
 * FAQ 게시판 내용을 조회한다.
 * 
 * @param link {Element} 링크
 */
function selectFaq(link) {
    // base.js FAQ 스크립트 참조
    $("dd.answer").slideUp("fast");
    
    $("a.question").removeClass("on");
    $("a.question").removeAttr("title");
    
    var element = $(link).closest("dl.dl_FAQ").find("dd.answer").eq(0);
    
    if (!element.is(":visible")) {
        element.slideDown("fast");
        
        $(link).addClass('on');
        $(link).attr('title', '선택됨');
    }
}

/**
 * FAQ 게시판 내용 섹션을 변경한다.
 * 
 * @param tab {Element} 탭
 */
function changeFaqSection(tab) {
    if (!$(tab).hasClass("on")) {
        $(".faq-section-tab.on").removeClass("on");
        
        $(tab).addClass("on");
    }
    
    var code = $(tab).attr("href").substring(1);
    
    $("#faq-search-form [name=listSubCd]").val(code);
    
    // FAQ 게시판 내용을 검색한다.
    searchFaq();
}

/**
 * FAQ 게시판 검색어를 변경한다.
 */
function changeFaqSearchWord() {
    $("#faq-search-form [name=searchType]").val($("#faq-searchtype-combo").val());
    $("#faq-search-form [name=searchWord]").val($("#faq-searchword-field").val());
    
    var value = $("#faq-searchword-field").val();
    var filtArr = ["~","!","@","#","$",
                   "%","^","&","*","(",
                   ")","-","+","{","}",
                   "?","[","]","<",">","/",
                   "\\","\"",".","'"];
    var isCheck = false;
     for(var i=0; i<filtArr.length; i++){
        if(value.indexOf(filtArr[i])> -1){
           isCheck = true;
        }
     }   
     if(isCheck){
    	 alert("특수문자는 사용하실 수 없습니다.");
    	 $("#faq-searchword-field").val("");
         return false;
     }
    
    // FAQ 게시판 내용을 검색한다.
    searchFaq();
}

/**
 * URL을 반환한다.
 * 
 * @param url {String} URL
 */
function resolveUrl(url) {
    var matches = window.location.href.match(/\/portal\/[^\/]+\//);
    
    return matches[0] + $("#faq-search-form [name=bbsCd]").val().toLowerCase() + url;
}

////////////////////////////////////////////////////////////////////////////////
// 전처리 함수
////////////////////////////////////////////////////////////////////////////////
/**
 *  FAQ 게시판 내용 검색 전처리를 실행한다.
 * 
 * @param options {Object} 옵션
 * @returns {Object} 데이터
 */
function beforeSearchFaq(options) {
    var data = {
        // Nothing do do.
    };
    
    var form = $("#faq-search-form");
    
    if (com.wise.util.isBlank(options.page)) {
        form.find("[name=page]").val("1");
    }
    else {
        form.find("[name=page]").val(options.page);
    }
    
    $.each(form.serializeArray(), function(index, element) {
        switch (element.name) {
            case "seq":
            case "noticeYn":
                break;
            default:
                data[element.name] = element.value;
                break;
        }
    });
    
    if (com.wise.util.isBlank(data.bbsCd)) {
        return null;
    }
    
    return data;
}

////////////////////////////////////////////////////////////////////////////////
// 후처리 함수
////////////////////////////////////////////////////////////////////////////////
/**
 * FAQ 게시판 내용 검색 후처리를 실행한다.
 * 
 * @param data {Array} 데이터
 */
function afterSearchFaq(data) {
    var sect = $("#faq-data-sect");
    
    sect.find("dl").each(function(index, element) {
        $(this).remove();
    });
    
    for (var i = 0; i < data.length; i++) {
        var list = $(templates.data);
        
        list.find(".bbsTit").append(data[i].bbsTit);
        list.find(".bbsCont").append(data[i].bbsCont);
        
        // FAQ 게시판 내용 제목 링크에 클릭 이벤트를 바인딩한다.
        list.find("a:first").bind("click", function(event) {
            // FAQ 게시판 내용을 조회한다.
            selectFaq(this);
            return false;
        });
        
        // FAQ 게시판 내용 제목 링크에 키다운 이벤트를 바인딩한다.
        list.find("a:first").bind("keydown", function(event) {
            if (event.which == 13) {
                // FAQ 게시판 내용을 조회한다.
                selectFaq(this);
                return false;
            }
        });
        
        sect.append(list);
    }
    
    if (data.length == 0) {
        var list = $(templates.none);
        
        sect.append(list);
    }
}

/**
 * 탭 선택 이벤트
 * @param tabIndex
 */
function selectTab(tabIndex) {

	//if(!$('#tab_layout a:eq('+tabIndex+')').hasClass('on')) {
	if(!$('#tab_layout ul li#tab_'+tabIndex).hasClass('on')) {
		// 레이아웃 내용을 비운다.
		//$('#content_'+tabIndex).empty();
		
		$('#tab_layout ul li').removeClass('on');
		//$('div[id^=content_]').css('display', 'none');
		
		$('#tab_layout ul li#tab_'+tabIndex).addClass('on');
		
		// 레이아웃을 초기화된 내용으로 다시 채운다.
		//$('#content_'+tabIndex).html(pageTemplates["content_"+tabIndex]);
		//$('#content_'+tabIndex).css('display', 'block');
		
		// 각 레이아웃 별 이벤트 바인딩
		//eval("bindContent_"+tabIndex +"()");
		selectFaq(1);
	}
}
////////////////////////////////////////////////////////////////////////////////
// 이벤트 함수
////////////////////////////////////////////////////////////////////////////////