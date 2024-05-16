/*
 * @(#)delegation.js 1.0 2015/06/01
 * 
 * COPYRIGHT (C) 2013 WISEITECH CO., LTD. ALL RIGHTS RESERVED.
 */

/**
 * 업무 처리를 위임하는 스크립트이다.
 * 
 * 프록시
 * 
 * =============================================================================
 * Name                Description
 * -----------------------------------------------------------------------------
 * goSubmit            데이터를 처리하는 화면으로 이동한다.
 * goSearch            데이터를 검색하는 화면으로 이동한다.
 * goInsert            데이터를 등록하는 화면으로 이동한다.
 * goSelect            데이터를 조회하는 화면으로 이동한다.
 * goUpdate            데이터를 수정하는 화면으로 이동한다.
 * goDownload          데이터를 다운로드하는 화면으로 이동한다.
 * goLogin             로그인을 처리하는 화면으로 이동한다.
 * doSubmit            데이터를 처리한다.
 * doInsert            데이터를 등록한다.
 * doUpdate            데이터를 수정한다.
 * doPost              데이터를 처리한다.
 * doSearch            데이터를 검색한다.
 * doSelect            데이터를 조회한다.
 * doDelete            데이터를 삭제한다.
 * doLogin             로그인을 처리한다.
 * doAjaxMsg		   ajax 호출 메시지를 표시한다.
 * =============================================================================
 * 
 * 컴포넌트
 * 
 * =============================================================================
 * Name                Description
 * -----------------------------------------------------------------------------
 * handleFiles         파일을 처리한다.
 * createFile          파일을 생성한다.
 * downloadFile        파일을 다운로드한다.
 * loadCheckOptions    체크 옵션을 로드한다.
 * initCheckOptions    체크 옵션을 초기화한다.
 * loadRadioOptions    라디오 옵션을 로드한다.
 * initRadioOptions    라디오 옵션을 초기화한다.
 * loadComboOptions    콤보 옵션을 로드한다.
 * initComboOptions    콤보 옵션을 초기화한다.
 * loadTreeData        트리 데이터를 로드한다.
 * initTreeData        트리 데이터를 초기화한다.
 * initSheetGrid       시트 그리드를 생성한다.
 * loadSheetData       시트 데이터를 로드한다.
 * saveSheetData       시트 데이터를 저장한다.
 * addSheetData        시트 데이터를 추가한다.
 * loadSheetOptions    시트 옵션을 로드한다.
 * initSheetOptions    시트 옵션을 초기화한다.
 * handleSheetError    시트 오류를 처리한다.
 * addSearchFilters    검색 필터를 추가한다.
 * checkSearchFilters  검색 필터를 검증한다.
 * sheetDataMove	   시트 데이터 위/아래 이동
 * sheetDataMoveOrder  시트 데이터 위/아래이동 후 순서 재조정(전체행에 대해서)
 * saveTabSheetData	   탭 내의 시트데이터를 저장한다.
 * =============================================================================
 * 
 * 통계관련
 * 
 * =============================================================================
 * Name                Description
 * -----------------------------------------------------------------------------
 * initStatInputSheet	   통계표 입력 시트 헤더 값과 컬럼값을 로드한다.
 * =============================================================================
 * 
 * 기타
 * 
 * =============================================================================
 * Name                Description
 * -----------------------------------------------------------------------------
 * openWindow          윈도우를 띄운다.
 * closeWindow         윈도우를 닫는다.
 * setValue            값을 설정한다.
 * copyValue           값을 복사한다.
 * toggleCheckbox      체크박스를 토글한다.
 * getRowNumber        행번호를 반환한다.
 * =============================================================================
 * 
 * @author 김은삼
 * @version 1.0 2015/06/01
 */


////////////////////////////////////////////////////////////////////////////////
// 프록시
////////////////////////////////////////////////////////////////////////////////
/**
 * 데이터를 처리하는 화면으로 이동한다.
 * 
 * @param options {Object} 옵션
 */
function goSubmit(options) {
    options.form   = options.form   || "";
    options.url    = options.url    || "";
    options.method = options.method || "get";
    options.target = options.target || "_self";
    
    if (com.wise.util.isBlank(options.form)) {
        return;
    }
    if (com.wise.util.isBlank(options.url)) {
        return;
    }
    
    var form = $("#" + options.form);
    
    if (options.data) {
        for (var i = 0; i < options.data.length; i++) {
            form.find("[name=" + options.data[i].name + "]").val(options.data[i].value);
        }
    }
    
    form.attr("action", com.wise.help.url(options.url));
    form.attr("method", options.method);
    form.attr("target", options.target);
    
    form.submit();
}

/**
 * 데이터를 검색하는 화면으로 이동한다.
 * 
 * @param options {Object} 옵션
 */
function goSearch(options) {
    options.form = options.form || "search-form";
    
    goSubmit(options);
}

/**
 * 데이터를 등록하는 화면으로 이동한다.
 * 
 * @param options {Object} 옵션
 */
function goInsert(options) {
    options.form = options.form || "search-form";
    
    goSubmit(options);
}

/**
 * 데이터를 조회하는 화면으로 이동한다.
 * 
 * @param options {Object} 옵션
 */
function goSelect(options) {
    options.form = options.form || "search-form";
    
    goSubmit(options);
}

/**
 * 데이터를 수정하는 화면으로 이동한다.
 * 
 * @param options {Object} 옵션
 */
function goUpdate(options) {
    options.form = options.form || "search-form";
    
    goSubmit(options);
}

/**
 * 데이터를 다운로드하는 화면으로 이동한다.
 * 
 * @param options {Object} 옵션
 */
function goDownload(options) {
    options.form   = options.form   || "download-form";
    options.target = options.target || "download-iframe";
    
    goSubmit(options);
}

/**
 * 로그인을 처리하는 화면으로 이동한다.
 * 
 * @param options {Object} 옵션
 */
function goLogin(options) {
    options = options || {};
    
    options.form   = options.form   || "global-request-form";
    options.url    = options.url    || "/portal/user/oauth/authorizePage.do";
    
    goSubmit(options);
}

/**
 * 데이터를 처리한다.
 *  
 * @param options {Object} 옵션
 */
function doSubmit(options) {
    options.form = options.form || "";
    options.url  = options.url  || "";
    
    if (com.wise.util.isBlank(options.form)) {
        return;
    }
    if (com.wise.util.isBlank(options.url)) {
        return;
    }
    
    options.before = options.before || function(options) {
        return true;
    };
    options.after  = options.after  || function(data) {
        // Nothing to do.
    };
    
    var success = options.before(options);
    
    if (success) {
        showLoadingMask();
        
        $("#" + options.form).ajaxSubmit({
            beforeSubmit:function(data, form, options) {
                return true;
            },
            url:com.wise.help.url(options.url),
            dataType:"json",
            success:function(data, status, request, form) {
                handleResponse(data, status, options);
                
                hideLoadingMask();
            },
            error:function(request, status, error) {
                handleError(status, error);
                
                hideLoadingMask();
            }
        });
    }
}

/**
 * 데이터를 등록한다.
 * 
 * @param options {Object} 옵션
 */
function doInsert(options) {
    options.form   = options.form   || "insert-form";
    options.before = options.before || beforeInsert;
    options.after  = options.after  || afterInsert;
    
    doSubmit(options);
}

/**
 * 데이터를 수정한다.
 * 
 * @param options {Object} 옵션
 */
function doUpdate(options) {
    options.form   = options.form   || "update-form";
    options.before = options.before || beforeUpdate;
    options.after  = options.after  || afterUpdate;
    
    doSubmit(options);
}

/**
 * 데이터를 처리한다.
 * 
 * @param options {Object} 옵션
 */
function doPost(options) {
    options.url = options.url || "";
    
    if (com.wise.util.isBlank(options.url)) {
        return;
    }
    
    options.before = options.before || function(options) {
        return {
            // Nothing to do.
        };
    };
    options.after  = options.after  || function(data) {
        // Nothing to do.
    };
    
    var data = options.before(options);
    
    if (data) {
        showLoadingMask();
        
        $.post(
            com.wise.help.url(options.url),
            data,
            function(data, status, request) {
                handleResponse(data, status, options);
                
                hideLoadingMask();
            },
            "json"
        ).fail(function(request, status, error) {
            handleError(status, error);
            
            hideLoadingMask();
        });
    }
}

/**
 * 데이터를 검색한다.
 * 
 * @param options {Object} 옵션
 */
function doSearch(options) {
    options.before = options.before || beforeSearch;
    options.after  = options.after  || afterSearch;
    
    doPost(options);
}

/**
 * 데이터를 조회한다.
 * 
 * @param options {Object} 옵션
 */
function doSelect(options) {
    options.before = options.before || beforeSelect;
    options.after  = options.after  || afterSelect;
    
    doPost(options);
}

/**
 * 데이터를 삭제한다.
 * 
 * @param options {Object} 옵션
 */
function doDelete(options) {
    options.before = options.before || beforeDelete;
    options.after  = options.after  || afterDelete;
    
    doPost(options);
}

/**
 * 로그인을 처리한다.
 * 
 * @param options {Object} 옵션
 */
function doLogin(options) {
    if (com.wise.util.isBlank(options.provider)) {
        return;
    }
    
    var url = com.wise.help.url("/portal/user/oauth/" + options.provider + "/authorize.do");
    
    window.open(url, "_blank").focus();
}

/**
 * ajax 호출 메시지를 표시한다.
 * @param data 		ajax 처리 상태
 * @param succUrl	성공시 이동할 url
 */
function doAjaxMsg(data, succUrl) {
	if (data.success) {
        if (data.success.message) {
            alert(data.success.message);
            if ( succUrl != "")	location.href = com.wise.help.url(succUrl);
        }
    } else if (data.error) {
    	if (data.error.message) {
    		alert(data.error.message);
    	}
    }
}

/**
 * ajax 호출한다.
 * @param options
 */
function doAjax(options) {
	options.url 		= options.url		|| "";
	options.succUrl 	= options.succUrl 	|| "";
	options.type 		= options.type 		|| "POST";
	options.dataType	= options.dataType 	|| "json";
	options.callback 	= options.callback	|| {};
	options.async		= options.async		|| false;
	options.before 		= options.before	|| {};
	options.complete 	= options.complete	|| {};

	if (com.wise.util.isBlank(options.url)) {
        return;
    }
	
	$.ajax({
	    url: com.wise.help.url(options.url),
	    async: options.async, 
	    type: 'POST', 
	    data: options.params,
	    dataType: options.dataType,
	    beforeSend: function(obj) {
	    	if (typeof options.before === 'function') {
	    		options.before(obj);
	    	}
	    }, // 서버 요청 전 호출 되는 함수 return false; 일 경우 요청 중단
	    success: function(data) {
	    	if (typeof options.callback === 'function') {
	    		options.callback(data);
	    	}
	    	doAjaxMsg(data, options.succUrl);
	    }, // 요청 완료 시
	    error: function(request, status, error) {
	    	handleError(status, error);
	    }, // 요청 실패.
	    complete: function(jqXHR) {
	    	if (typeof options.complete === 'function') {
	    		options.complete(jqXHR);
	    	}
	    } // 요청의 실패, 성공과 상관 없이 완료 될 경우 호출
	});
}

/**
 * 로딩 마스크를 보인다.
 */
function showLoadingMask() {
    $("#loading-mask").css({
        width:$("body").width() + "px",
        height:$(document).height() + "px"
    });
    
    $("#loading-mask").show();
    
    $("#loading-mask").focus();
}

/**
 * 로딩 마스크를 숨긴다.
 */
function hideLoadingMask() {
    $("#loading-mask").fadeOut("slow");
}

/**
 * 응답을 처리한다.
 * 
 * @param data {Object} 데이터
 * @param status {String} 상태
 * @param options {Object} 옵션
 */
function handleResponse(data, status, options) {
    // 페이지가 있는 경우
    if (data.page) {
        // 카운트를 처리한다.
        handleCount(data.total, data.count, data.pages, data.page, options);
        
        // 페이지를 처리한다.
        handlePage(data.pages, data.page, options);
        
        // 데이터를 처리한다.
        handleData(data.data, options);
        
        return;
    }
    
    // 데이터가 있는 경우
    if (data.data) {
        // 데이터를 처리한다.
        handleData(data.data, options);
        
        return;
    }
    
    // 처리가 완료된 경우
    if (data.success) {
        // 메시지를 처리한다.
        handleMessage(data.success, options);
        
        return;
    }
    
    // 오류가 발생한 경우
    if (data.error) {
        // 오류를 처리한다.
        handleError(status, data.error);
        
        return;
    }
}

/**
 * 페이지를 처리한다.
 * 
 * @param pages {Number} 전체 페이지
 * @param page {Number} 페이지 번호
 * @param options {Object} 옵션
 */
function handlePage(pages, page, options) {
    options.pager = options.pager || "search-pager";
    
    var isMobile = $(window).width() <= 980 ? true : false; // 모바일 접근 여부
    
    var pagerSize = 10;	// 페이져 사이즈 기본 10(5에서 10으로 변경)
    if(isMobile) pagerSize = 5;
    
    var pager = $("#" + options.pager);
    
    pager.empty();
    
    if(page==1){
    	pager.append(
    	        "<div class=\"paging-navigation\">"                                                       +
    	         //   "<a href=\"#\" class=\"btn btn_page_first\" title=\"처음페이지 이동\"><strong>처음페이지 이동</strong></a>"   +
    	            " "                                                                           +
    	         //   "<a href=\"#\" class=\"btn btn_page_pre\" title=\"이전 10페이지 이동\"><strong>이전 10페이지 이동</strong></a>"  +
    	            " "                                                                           +
    	            "<a href=\"#\" class=\"btn-next btn_page_next\" title=\"다음 "+ pagerSize +"페이지 이동\"><strong>다음 "+ pagerSize +"페이지 이동</strong></a>" +
    	            " "                                                                           +
    	            "<a href=\"#\" class=\"btn-last btn_page_last\" title=\"마지막페이지 이동\"><strong>마지막페이지 이동</strong></a>"  +
    	        "</div>"                                                                          
    	    );
    }
    else{
    	pager.append(
    	        "<div class=\"paging-navigation\">"                                                       +
    	            "<a href=\"#\" class=\"btn-first btn_page_first\" title=\"처음페이지 이동\"><strong>처음페이지 이동</strong></a>"   +
    	            " "                                                                           +
    	            "<a href=\"#\" class=\"btn-pre btn_page_pre\" title=\"이전 "+ pagerSize +"페이지 이동\"><strong>이전 "+ pagerSize +"페이지 이동</strong></a>"  +
    	            " "                                                                           +
    	            "<a href=\"#\" class=\"btn-next btn_page_next\" title=\"다음 "+ pagerSize +"페이지 이동\"><strong>다음 "+ pagerSize +"페이지 이동</strong></a>" +
    	            " "                                                                           +
    	            "<a href=\"#\" class=\"btn-last btn_page_last\" title=\"마지막페이지 이동\"><strong>마지막페이지 이동</strong></a>"  +
    	        "</div>"                                                                          
    	      
    	    );
    }
    
    
    if (pages > 0 && page > 1) {
        pager.find(".btn_page_first").addClass("first");
    }
    else {
        pager.find(".btn_page_first").css("cursor", "default");
    }
    
    if (pages > 0 && page > pagerSize) {
        pager.find(".btn_page_pre").addClass("previous");
    }
    else {
        pager.find(".btn_page_pre").css("cursor", "default");
    }
    
    var first = Math.floor((page - 1) / pagerSize) * pagerSize + 1;
    var last  = first;
    
    for (var i = 0, n = first; i < pagerSize; i++, n++) {
        if (n == page) {
            pager.find(".btn_page_next").before("<strong class=\"page-number\" style=\"cursor:default;\">" + n + "</strong>");
        }
        else {
            pager.find(".btn_page_next").before("<a href=\"#\" class=\"number page-number\">" + n + "</a>");
        }
        
        pager.find(".btn_page_next").before(" ");
        
        if (n >= pages) {
            last = n;
            break;
        }
    }
    
    if (pages > 0 && last < pages) {
        pager.find(".btn_page_next").addClass("next");
    }
    else {
        pager.find(".btn_page_next").css("cursor", "default");
    }
    
    if (pages > 0 && page < pages) {
        pager.find(".btn_page_last").addClass("last");
    }
    else {
        pager.find(".btn_page_last").css("cursor", "default");
    }
    
    pager.find(".presentPage strong").text(page);
    pager.find(".presentPage span").text(pages ? pages : 1);
    
    if (pages > 0 && page > 1) {
        pager.find(".btn_page_preStep").addClass("previousStep");
    }
    else {
        pager.find(".btn_page_preStep").css("cursor", "default");
    }
    
    if (pages > 0 && page < pages) {
        pager.find(".btn_page_nextStep").addClass("nextStep");
    }
    else {
        pager.find(".btn_page_nextStep").css("cursor", "default");
    }
    
    // 맨앞 버튼에 클릭 이벤트를 바인딩한다.
    pager.find(".btn_page_first").bind("click", {
        url:options.url,
        page:"1",
        before:options.before,
        after:options.after,
        pager:options.pager,
        counter:options.counter
    }, function(event) {
        if ($(this).hasClass("first")) {
            doSearch(event.data);
        }
        return false;
    });
    
    // 맨앞 버튼에 키다운 이벤트를 바인딩한다.
    pager.find(".btn_page_first").bind("keydown", {
        url:options.url,
        page:"1",
        before:options.before,
        after:options.after,
        pager:options.pager,
        counter:options.counter
    }, function(event) {
        if ($(this).hasClass("first") && event.which == 13) {
            doSearch(event.data);
            return false;
        }
    });
    
    // 이전 버튼에 클릭 이벤트를 바인딩한다.
    pager.find(".btn_page_pre").bind("click", {
        url:options.url,
        page:(parseInt(pager.find(".page-number:first").text(), 10) - 1).toString(),
        before:options.before,
        after:options.after,
        pager:options.pager,
        counter:options.counter
    }, function(event) {
        if ($(this).hasClass("previous")) {
            doSearch(event.data);
        }
        return false;
    });
    
    // 이전 버튼에 키다운 이벤트를 바인딩한다.
    pager.find(".btn_page_pre").bind("keydown", {
        url:options.url,
        page:(parseInt(pager.find(".page-number:first").text(), 10) - 1).toString(),
        before:options.before,
        after:options.after,
        pager:options.pager,
        counter:options.counter
    }, function(event) {
        if ($(this).hasClass("previous") && event.which == 13) {
            doSearch(event.data);
            return false;
        }
    });
    
    pager.find(".number").each(function(index, element) {
        // 번호 링크에 클릭 이벤트를 바인딩한다.
        $(this).bind("click", {
            url:options.url,
            page:$(this).text(),
            before:options.before,
            after:options.after,
            pager:options.pager,
            counter:options.counter
        }, function(event) {
            doSearch(event.data);
            return false;
        });
        
        // 번호 링크에 키다운 이벤트를 바인딩한다.
        $(this).bind("keydown", {
            url:options.url,
            page:$(this).text(),
            before:options.before,
            after:options.after,
            pager:options.pager,
            counter:options.counter
        }, function(event) {
            if (event.which == 13) {
                doSearch(event.data);
                return false;
            }
        });
    });
    
    // 다음 버튼에 클릭 이벤트를 바인딩한다.
    pager.find(".btn_page_next").bind("click", {
        url:options.url,
        page:(parseInt(pager.find(".page-number:last").text(), 10) + 1).toString(),
        before:options.before,
        after:options.after,
        pager:options.pager,
        counter:options.counter
    }, function(event) {
        if ($(this).hasClass("next")) {
            doSearch(event.data);
        }
        return false;
    });
    
    // 다음 버튼에 키다운 이벤트를 바인딩한다.
    pager.find(".btn_page_next").bind("keydown", {
        url:options.url,
        page:(parseInt(pager.find(".page-number:last").text(), 10) + 1).toString(),
        before:options.before,
        after:options.after,
        pager:options.pager,
        counter:options.counter
    }, function(event) {
        if ($(this).hasClass("next") && event.which == 13) {
            doSearch(event.data);
            return false;
        }
    });
    
    // 맨뒤 버튼에 클릭 이벤트를 바인딩한다.
    pager.find(".btn_page_last").bind("click", {
        url:options.url,
        page:pages.toString(),
        before:options.before,
        after:options.after,
        pager:options.pager,
        counter:options.counter
    }, function(event) {
        if ($(this).hasClass("last")) {
            doSearch(event.data);
        }
        return false;
    });
    
    // 맨뒤 버튼에 키다운 이벤트를 바인딩한다.
    pager.find(".btn_page_last").bind("keydown", {
        url:options.url,
        page:pages.toString(),
        before:options.before,
        after:options.after,
        pager:options.pager,
        counter:options.counter
    }, function(event) {
        if ($(this).hasClass("last") && event.which == 13) {
            doSearch(event.data);
            return false;
        }
    });
    
    // 이전 버튼에 클릭 이벤트를 바인딩한다.
    pager.find(".btn_page_preStep").bind("click", {
        url:options.url,
        page:(parseInt(pager.find(".presentPage strong").text(), 10) - 1).toString(),
        before:options.before,
        after:options.after,
        pager:options.pager,
        counter:options.counter
    }, function(event) {
        if ($(this).hasClass("previousStep")) {
            doSearch(event.data);
        }
        return false;
    });
    
    // 이전 버튼에 키다운 이벤트를 바인딩한다.
    pager.find(".btn_page_preStep").bind("keydown", {
        url:options.url,
        page:(parseInt(pager.find(".presentPage strong").text(), 10) - 1).toString(),
        before:options.before,
        after:options.after,
        pager:options.pager,
        counter:options.counter
    }, function(event) {
        if ($(this).hasClass("previousStep") && event.which == 13) {
            doSearch(event.data);
            return false;
        }
    });
    
    // 다음 버튼에 클릭 이벤트를 바인딩한다.
    pager.find(".btn_page_nextStep").bind("click", {
        url:options.url,
        page:(parseInt(pager.find(".presentPage strong").text(), 10) + 1).toString(),
        before:options.before,
        after:options.after,
        pager:options.pager,
        counter:options.counter
    }, function(event) {
        if ($(this).hasClass("nextStep")) {
            doSearch(event.data);
        }
        return false;
    });
    
    // 다음 버튼에 키다운 이벤트를 바인딩한다.
    pager.find(".btn_page_nextStep").bind("keydown", {
        url:options.url,
        page:(parseInt(pager.find(".presentPage strong").text(), 10) + 1).toString(),
        before:options.before,
        after:options.after,
        pager:options.pager,
        counter:options.counter
    }, function(event) {
        if ($(this).hasClass("nextStep") && event.which == 13) {
            doSearch(event.data);
            return false;
        }
    });
}

/**
 * 데이터를 처리한다.
 * 
 * @param data {Object} 데이터
 * @param options {Object} 옵션
 */
function handleData(data, options) {
    options.after(data);
}

/**
 * 카운트를 처리한다.
 * 
 * @param total {Number} 전체 카운트
 * @param count {Number} 검색 카운트
 * @param pages {Number} 전체 페이지
 * @param page {Number} 페이지 번호
 * @param options {Object} 옵션
 */
function handleCount(total, count, pages, page, options) {
    var counter = options.counter || {};
    
    counter.total = counter.total || "search-total";
    counter.count = counter.count || "search-count";
    counter.pages = counter.pages || "search-pages";
    
    $("#" + counter.total).text(total);
    $("#" + counter.count).text(count);
    $("#" + counter.pages).html("&#40;" + page + "&#47;" + (pages ? pages : 1) + " page&#41;");
}

/**
 * 메시지를 처리한다.
 * 
 * @param messages {Object} 메시지
 * @param options {Object} 옵션
 */
function handleMessage(messages, options) {
    if (messages.message) {
        alert(messages.message);
    }
    
    options.after(messages);
}

/**
 * 오류를 처리한다.
 * 
 * @param status {String} 상태
 * @param error {Object} 오류
 */
function handleError(status, error) {
    // 서비스 오류인 경우
    if (status == "success") {
        alert(error.message);
    }
    // 시스템 오류인 경우
    else {
//        alert("시스템 오류가 발생하였습니다.");
    }
}

////////////////////////////////////////////////////////////////////////////////
// 컴포넌트
////////////////////////////////////////////////////////////////////////////////
// 파일
/**
 * 파일을 처리한다.
 * 
 * @param files {Array} 파일
 * @param options {Object} 옵션
 */
function handleFiles(files, options) {
    options.attacher = options.attacher || "attach-files";
    options.mode     = options.mode     || "select";
    
    var list = $("#" + options.attacher);
    
    if (options.mode == "select") {
        list.empty();
    }
    
    for (var i = 0; i < files.length; i++) {
        // 파일을 첨부한다.
        attachFile({
            fileSeq:files[i].fileSeq,
            fileNm:files[i].viewFileNm,
            fileExt:files[i].fileExt,
            fileSize:getFileSize(files[i].fileSize)
        }, options);
    }
    
    if (options.mode == "select") {
        if (files.length == 0) {
            list.text("첨부 파일이 없습니다.");
        }
    }
}

/**
 * 파일을 생성한다.
 * 
 * @param options {Object} 옵션
 */
function createFile(options) {
    options.uploader = options.uploader || "upload-files";
    options.attach   = options.attach   || "attach";
    
    var template = "";
    
    template += "<li>";
    template += "    <input type=\"file\" class=\"atchFile\" title=\"첨부파일\" />";
    template += "    <a href=\"#\" class=\"btn_C file-attach-button\">추가</a>";
    template += "</li>";
    
    var list = $("#" + options.uploader);
    
    var item = $(template);
    
    item.find(":file").attr("id",   "fileAdd");
    item.find(":file").attr("name", options.attach);
    
    // if ($(".secretYn").length > 0) {
    //     item.find(":file").addClass("f_90per");
    //     item.find(":file").addClass("f_80per");
    // }
    item.find(":file").addClass("f_90per");
    item.find(":file").addClass("f_80per");
    
    // 첨부파일 추가 버튼에 클릭 이벤트를 바인딩한다.
    item.find(".file-attach-button").bind("click", {
        options:options
    }, function(event) {
        // 파일을 첨부한다.
        attachFile({
            fileSeq:"",
            fileNm:"",
            fileExt:"",
            fileSize:""
        }, event.data.options);
        return false;
    });
    
    // 첨부파일 추가 버튼에 키다운 이벤트를 바인딩한다.
    item.find(".file-attach-button").bind("keydown", {
        options:options
    }, function(event) {
        if (event.which == 13) {
            // 파일을 첨부한다.
            attachFile({
                fileSeq:"",
                fileNm:"",
                fileExt:"",
                fileSize:""
            }, event.data.options);
            return false;
        }
    });
    
    list.append(item);
}

/**
 * 파일 이름을 반환한다.
 * 
 * @param path {String} 파일 경로
 * @returns {String} 파일 이름
 */
function getFileName(path) {
    return path.substring(path.replace(new RegExp("\\\\", "g"), "/").lastIndexOf("/") + 1);
}

/**
 * 파일 크기를 반환한다.
 * 
 * @param size {Number} 파일 크기
 * @returns {String} 파일 크기
 */
function getFileSize(size) {
    return com.wise.util.toCurrency(Math.ceil(size / 1024).toString()) + "KB";
}

/**
 * 파일 유형을 반환한다.
 * 
 * @param extension {String} 파일 확장자
 * @returns {String} 파일 유형
 */
function getFileType(extension) {
    switch (extension.toLowerCase()) {
        case "ppt":
        case "pptx":
            return "ty_A_1";
        case "doc":
        case "docx":
            return "ty_A_2";
        case "xls":
        case "xlsx":
            return "ty_A_3";
        case "hwp":
            return "ty_A_4";
        case "pdf":
            return "ty_A_5";
        case "bmp":
        case "gif":
        case "ief":
        case "jpe":
        case "jpeg":
        case "jpg":
        case "png":
        case "tif":
        case "tiff":
            return "ty_A_6";
        default:
            return "ty_A_7";
    }
}

/**
 * 파일을 첨부한다.
 * 
 * @param file {Object} 파일
 * @param options {Object} 옵션
 */
function attachFile(file, options) {
    options.attacher = options.attacher || "attach-files";
    options.mode     = options.mode     || "select";
    
    var list = $("#" + options.attacher);
    
    switch (options.mode) {
        case "insert":
            var template = "";
            
            template += "<li>";
            template += "    <input type=\"file\" class=\"atchFile\" title=\"첨부파일\" />";
            template += "    <a href=\"#\" title=\"첨부파일 행 삭제\" class=\"file-detach-button\"><img src=\"" + com.wise.help.url("/img/ggportal/desktop/common/btn_delete.png") + "\" alt=\"\" /></a>";
            template += "</li>";
            
            var item = $(template);
            
            item.find(":file").attr("id",   "fileAdd_" + list.find(":file").length + 1);
            item.find(":file").attr("name", options.attach);
            
            // if ($(".secretYn").length > 0) {
            //     item.find(":file").addClass("f_90per");
            //     item.find(":file").addClass("f_80per");
            // }
            item.find(":file").addClass("f_90per");
            item.find(":file").addClass("f_80per");
            
            // 첨부파일 삭제 버튼에 클릭 이벤트를 바인딩한다.
            item.find(".file-detach-button").bind("click", {
                key:file.fileSeq,
                options:options
            }, function(event) {
                // 파일을 제거한다.
                detachFile(this, event.data.key, event.data.options);
                return false;
            });
            
            // 첨부파일 삭제 버튼에 키다운 이벤트를 바인딩한다.
            item.find(".file-detach-button").bind("keydown", {
                key:file.fileSeq,
                options:options
            }, function(event) {
                if (event.which == 13) {
                    // 파일을 제거한다.
                    detachFile(this, event.data.key, event.data.options);
                    return false;
                }
            });
            
            list.find(":file:last").parent("li").after(item);
            
            break;
        case "update":
            var template = "";
            
            template += "<li>";
            template += "    <a href=\"#\" class=\"file atchFile\"></a>";
            template += "    <a href=\"#\" title=\"첨부파일 삭제\" class=\"btn_delete_B\"><img src=\"" + com.wise.help.url("/img/ggportal/desktop/common/btn_delete_B.png") + "\" alt=\"\" /></a>";
            template += "</li>";
            
            var item = $(template);
            
            item.find(".atchFile").addClass(getFileType(file.fileExt)).text(file.fileNm + "." + file.fileExt + " (" + file.fileSize + ")");
            
            item.find("a").each(function(index, element) {
                // 첨부파일 파일명 링크 및 삭제 버튼에 클릭 이벤트를 바인딩한다.
                $(this).bind("click", {
                    key:file.fileSeq,
                    options:options
                }, function(event) {
                    // 파일을 제거한다.
                    detachFile(this, event.data.key, event.data.options);
                    return false;
                });
                
                // 첨부파일 파일명 링크 및 삭제 버튼에 키다운 이벤트를 바인딩한다.
                $(this).bind("keydown", {
                    key:file.fileSeq,
                    options:options
                }, function(event) {
                    if (event.which == 13) {
                        // 파일을 제거한다.
                        detachFile(this, event.data.key, event.data.options);
                        return false;
                    }
                });
            });
            
            list.append(item);
            
            break;
        default:
            var item = $("<p class=\"add-file\"><a href=\"#\" class=\"file atchFile\"></a></p>");
            
        	item.find(".atchFile").addClass(getFileType(file.fileExt)).text(file.fileNm + "." + file.fileExt + " (" + file.fileSize + ")");
            
            // 파일이름 링크에 클릭 이벤트를 바인딩한다.
            item.bind("click", {
                data:{
                    fileSeq:file.fileSeq
                },
                options:options
            }, function(event) {
                // 파일을 다운로드한다.
                downloadFile(event.data.data, event.data.options);
                return false;
            });
            
            // 파일이름 링크에 키다운 이벤트를 바인딩한다.
            item.bind("keydown", {
                data:{
                    fileSeq:file.fileSeq
                },
                options:options
            }, function(event) {
                if (event.which == 13) {
                    // 파일을 다운로드한다.
                    downloadFile(event.data.data, event.data.options);
                    return false;
                }
            });
            
            list.append(item);
            
            break;
    }
}

/**
 * 파일을 제거한다.
 * 
 * @param button {Element} 버튼
 * @param key {String} 키
 * @param options {Object} 옵션
 */
function detachFile(button, key, options) {
    options.attacher = options.attacher || "attach-files";
    options.mode     = options.mode     || "update";
    options.form     = options.form     || "update-form";
    options.detach   = options.detach   || "detach";
    
    switch (options.mode) {
        case "insert":
            $(button).parent("li").remove();
            
            break;
        default:
            var form = $("#" + options.form);
            
            var hidden = $("<input type=\"hidden\" />");
            
            hidden.attr("name", options.detach);
            
            hidden.val(key);
            
            form.append(hidden);
            
            $(button).parent("li").remove();
            
            break;
    }
}

/**
 * 파일을 다운로드한다.
 * 
 * @param data {Object} 데이터
 * @param options {Object} 옵션
 */
function downloadFile(data, options) {
    options.target = options.target || "download-iframe";
    
    if (com.wise.util.isBlank(options.url)) {
        return;
    }
    
    var params = "";
    
    for (var key in data) {
        if (com.wise.util.isBlank(params)) {
            params += "?";
        }
        else {
            params += "&";
        }
        
        params += key + "=" + data[key];
    }
    
    $("#" + options.target).attr("src", com.wise.help.url(options.url) + params);
}

// 체크
/**
 * 체크 옵션을 로드한다.
 * 
 * @param id {String} 아이디
 * @param name {String} 이름
 * @param url {String} URL
 * @param data {Object} 데이터
 * @param value {String} 값
 * @param options {array} 체크박스 옵션
 *           - isIdDiff : 체크박스별로 ID를 다르게 설정
 *           - isDisEle : value값으로 들어온 값은 비활성화 처리
 */    
function loadCheckOptions(id, name, url, data, value, options) {
    // 옵션을 검색한다.
    $.post(
        com.wise.help.url(url),
        data,
        function(data, status, request) {
            if (data.data) {
                // 체크 옵션을 초기화한다.
           		initCheckOptions(id, name, data.data, value, options);
            }
        },
        "json"
    );
}

/**
 * 체크 옵션을 초기화한다.
 * 
 * @param id {String} 아이디
 * @param name {String} 이름
 * @param data {Array} 데이터
 * @param value {String} 값
 */
function initCheckOptions(id, name, data, value, options) {
	var isIdDiff = options.isIdDiff || false;
	var isDisEle = options.isDisEle || false;
	var isAllChk = options.isAllChk || false;
	
	var eleId  = ""
    var section = $("#" + id);
    
    section.empty();
    
    for (var i = 0; i < data.length; i++) {
        var checkbox = $("<span class=\"chk\"><input type=\"checkbox\" autocomplete=\"on\" /> <label></label></span>");
        if (isIdDiff) {
        	eleId = id + "-" + data[i].code;
        } else {
        	eleId = id + "-" + i;
        }
        
        var chkYn = function() {
        	if ( isAllChk ) {
        		return true;
        	} else {
        		return data[i].code == value;
        	}
        }
        
        if ( isDisEle ) {
        	checkbox.find("input").attr("id",  eleId).attr("name", name).val(data[i].code).prop("checked", chkYn).prop("disabled", data[i].code == value);
        } else {
        	checkbox.find("input").attr("id",  eleId).attr("name", name).val(data[i].code).prop("checked", chkYn);
        }
        checkbox.find("label").attr("for", eleId).text(data[i].name);
        
        if ( i < data.length-1 ) {
        	checkbox.append("&nbsp;&nbsp;");
        }
        section.append(checkbox);
    }
}

/**
 * 체크 옵션을 초기화한다.(ID값을 코드값에 따라 다르게 설정)
 * 
 * @param id {String} 아이디
 * @param name {String} 이름
 * @param data {Array} 데이터
 * @param value {String} 값
 */
/*
function initCheckOptionsDiffId(id, name, data, value) {
    var section = $("#" + id);
    
    section.empty();
    
    for (var i = 0; i < data.length; i++) {
        var checkbox = $("<span class=\"chk\"><input type=\"checkbox\" autocomplete=\"on\" /> <label></label></span> ");
        
        checkbox.find("input").attr("id",  id + "-" + data[i].code).attr("name", name).val(data[i].code).prop("checked", data[i].code == value);
        
        checkbox.find("label").attr("for", id + "-" + data[i].code).text(data[i].name);
        if ( i < data.length-1 ) {
        	checkbox.append("&nbsp;&nbsp;");
        }
        section.append(checkbox);
    }
}
*/
// 라디오
/**
 * 라디오 옵션을 로드한다.
 * 
 * @param id {String} 아이디
 * @param name {String} 이름
 * @param url {String} URL
 * @param data {Object} 데이터
 * @param value {String} 값
 */    
function loadRadioOptions(id, name, url, data, value, options) {
	var isAll = options.isAll || false;
	
    // 옵션을 검색한다.
    $.post(
        com.wise.help.url(url),
        data,
        function(data, status, request) {
            if (data.data) {
            	if ( isAll ) {
            		data.data = [{
            			code:"",
                        name:"전체"
            		}].concat(data.data)
            	}
                // 라디오 옵션을 초기화한다.
                initRadioOptions(id, name, data.data, value, options);
            }
        },
        "json"
    );
}

/**
 * 라디오 옵션을 초기화한다.
 * 
 * @param id {String} 아이디
 * @param name {String} 이름
 * @param data {Array} 데이터
 * @param value {String} 값
 */
function initRadioOptions(id, name, data, value, options) {
	var isIdDiff = options.isIdDiff || false;
	var eleId = "";
    var section = $("#" + id);
    
    section.empty();
    
    for (var i = 0; i < data.length; i++) {
        var radio = $("<span class=\"radio\"><input type=\"radio\" autocomplete=\"on\" /> <label></label></span>");
        if (isIdDiff) {
        	eleId = id + "-" + data[i].code;
        } else {
        	eleId = id + "-" + i;
        }
        
        radio.find("input").attr("id",  eleId).attr("name", name).val(data[i].code).prop("checked", data[i].code == value);
        radio.find("label").attr("for", eleId).text(data[i].name);
        if ( i < data.length-1 ) {
        	radio.append("&nbsp;&nbsp;");
        }
       
        section.append(radio);
    }
}

// 콤보
/**
 * 콤보 옵션을 로드한다.
 * 
 * @param id {String} 아이디
 * @param url {String} URL
 * @param data {Object} 데이터
 * @param value {String} 값
 */    
function loadComboOptions(id, url, data, value) {
    // 옵션을 검색한다.
    $.post(
        com.wise.help.url(url),
        data,
        function(data, status, request) {
            if (data.data) {
                // 콤보 옵션을 초기화한다.
                initComboOptions(id, data.data, value);
            }
        },
        "json"
    );
}

/**
 * 콤보 옵션을 로드한다. (선택 추가)
 * 
 * @param id {String} 아이디
 * @param url {String} URL
 * @param data {Object} 데이터
 * @param value {String} 값
 */    
function loadComboOptions2(id, url, data, value) {
    // 옵션을 검색한다.
    $.post(
        com.wise.help.url(url),
        data,
        function(data, status, request) {
            if (data.data) {
                // 콤보 옵션을 초기화한다.
                initComboOptions(id, [{
                    code:"",
                    name:"전체"
                }].concat(data.data), value);
            }
        },
        "json"
    );
}
function loadComboOptions3(id, url, data, value) {
    // 옵션을 검색한다.
    $.post(
        com.wise.help.url(url),
        data,
        function(data, status, request) {
            if (data.data) {
                // 콤보 옵션을 초기화한다.
                initComboOptions(id, [{
                    code:"",
                    name:"선택"
                }].concat(data.data), value);
            }
        },
        "json"
    );
}


function loadTabComboOptions(formObj, name, url, data, value, isEmpty) {
	isEmpty = isEmpty || false;
	
    // 옵션을 검색한다.
    $.post(
        com.wise.help.url(url),
        data,
        function(data, status, request) {
            if (data.data) {
            	// 콤보 옵션을 초기화한다.
            	
            	if ( isEmpty ) {
            		initTabComboOptions(formObj, name, [{
                        code:"",
                        name:"전체"
                    }].concat(data.data), value);
            	}
            	else {
            		initTabComboOptions(formObj, name, data.data, value);
            	}
            }
        },
        "json"
    );
}

/**
 * 콤보 옵션을 초기화한다.
 * 
 * @param id {String} 아이디
 * @param data {Array} 데이터
 * @param value {String} 값
 */
function initComboOptions(id, data, value) {
    var combobox = $("#" + id);
    
    combobox.find("option").each(function(index, element) {
        $(this).remove();
    });
    
    for (var i = 0; i < data.length; i++) {
        var option = $("<option></option>");
        
        option.val(data[i].code);
        
        option.text(data[i].name);
        
        combobox.append(option);
    }
    
    if (value) {
        combobox.val(value);
    }
}

function initTabComboOptions(formObj, name, data, value) {
	var combobox = formObj.find("select[name="+name+"]");
    
    combobox.find("option").each(function(index, element) {
        $(this).remove();
    });
    
    for (var i = 0; i < data.length; i++) {
        var option = $("<option></option>");
        
        option.val(data[i].code);
        
        option.text(data[i].name);
        
        combobox.append(option);
    }
    
    if (value) {
        combobox.val(value);
    }
}
// 트리
/**
 * 트리 데이터를 로드한다.
 * 
 * @param id {String} 아이디
 * @param url {String} URL
 * @param data {Object} 데이터
 * @param options {Object} 옵션
 */
function loadTreeData(id, url, data, options) {
    options.id        = options.id        || "id";
    options.pid       = options.pid       || "pId";
    options.name      = options.name      || "name";
    options.check     = options.check     || false;
    options.checkType = options.checkType || { Y:"ps", N:"ps" };
    options.simple    = options.simple    || false;
    options.callback  = options.callback  || {};
    
    options.callback.onAsyncError = function(event, id, node, request, status, error) {
        handleError(status, error);
    };
    
    // 트리를 초기화한다.
    $.fn.zTree.init($("#" + id), {
        async:{
            enable:true,
            url:com.wise.help.url(url),
            autoParam:[
                options.id
            ],
            otherParam:data,
            dataFilter:function(id, node, data) {
                return data.data;
            }
        },
        data:{
            key:{
                name:options.name
            },
            simpleData:{
                enable:options.simple,
                idKey:options.id,
                pIdKey:options.pid
            }
        },
        check:{
            enable:options.check,
            chkboxType:options.checkType
        },
        callback:options.callback
    });
}

/**
 * 트리 데이터를 초기화한다.
 * 
 * @param id {String} 아이디
 * @param data {Array} 데이터
 * @param options {Object} 옵션
 */
function initTreeData(id, data, options) {
    options.id        = options.id        || "id";
    options.pid       = options.pid       || "pId";
    options.name      = options.name      || "name";
    options.check     = options.check     || false;
    options.checkType = options.checkType || { Y:"ps", N:"ps" };
    options.simple    = options.simple    || false;
    options.callback  = options.callback  || {};
    
    // 트리를 초기화한다.
    $.fn.zTree.init($("#" + id), {
        data:{
            key:{
                name:options.name
            },
            simpleData:{
                enable:options.simple,
                idKey:options.id,
                pIdKey:options.pid
            }
        },
        check:{
            enable:options.check,
            chkboxType:options.checkType
        },
        callback:options.callback
    }, data);
}

// 시트
/**
 * 시트 그리드를 생성한다.
 * 
 * @param createOptions {Object} 생성 옵션
 * @param configOptions {Object} 시트 옵션
 * @param headerOptions {Object} 헤더 옵션
 * @param columnOptions {Array} 컬럼 옵션
 * @param othersOptions {Object} 기타 옵션
 */
function initSheetGrid(createOptions, configOptions, headerOptions, columnOptions, othersOptions) {
    createOptions = createOptions || {};
    configOptions = configOptions || {};
    headerOptions = headerOptions || {};
    columnOptions = columnOptions || [];
    othersOptions = othersOptions || {};
    
    createOptions.ElementId  = createOptions.ElementId  != null ? createOptions.ElementId  : "sheet-section";
    createOptions.SheetId    = createOptions.SheetId    != null ? createOptions.SheetId    : "sheet";
    createOptions.Width      = createOptions.Width      != null ? createOptions.Width      : "100%";
    createOptions.Height     = createOptions.Height     != null ? createOptions.Height     : "270px";
    createOptions.Locale     = createOptions.Locale     != null ? createOptions.Locale     : "";
    createOptions.CreateMode = createOptions.CreateMode != null ? createOptions.CreateMode : "Create";
    //아이비시트 추가
    createOptions.MinWidth      = createOptions.MinWidth      != null ? createOptions.MinWidth      : "50";
    
    var element = document.getElementById(createOptions.ElementId);
    
    if (element) {
        configOptions.MaxSort     = configOptions.MaxSort     != null ? configOptions.MaxSort     : 3;
        configOptions.MergeSheet  = configOptions.MergeSheet  != null ? configOptions.MergeSheet  : msHeaderOnly;
        configOptions.Page        = configOptions.Page        != null ? configOptions.Page        : 10;
        configOptions.SearchMode  = configOptions.SearchMode  != null ? configOptions.SearchMode  : smServerPaging;
        configOptions.SumPosition = configOptions.SumPosition != null ? configOptions.SumPosition : posBottom;
        configOptions.VScrollMode = configOptions.VScrollMode != null ? configOptions.VScrollMode : 1;
        //아이비시트 추가
        configOptions.AutoFitColWidth = configOptions.AutoFitColWidth != null ? configOptions.AutoFitColWidth : "init|search|resize";
        configOptions.TouchScrolling  = configOptions.TouchScrolling  != null ? configOptions.TouchScrolling : 1;	// 터치스크롤 방법
		configOptions.MouseHoverMode  = configOptions.MouseHoverMode  != null ? configOptions.MouseHoverMode : 1;	// Mouse Hover 모드(0:미사용, 1:셀단위, 2:행단위)
        
        headerOptions.Sort        = headerOptions.Sort        != null ? headerOptions.Sort        : 1;
        headerOptions.ColMove     = headerOptions.ColMove     != null ? headerOptions.ColMove     : 1;
        headerOptions.ColResize   = headerOptions.ColResize   != null ? headerOptions.ColResize   : 1;
        headerOptions.HeaderCheck = headerOptions.HeaderCheck != null ? headerOptions.HeaderCheck : 1;
        
        var sheet = null;
        
        if (createOptions.CreateMode == "Reset") {
            sheet = window[createOptions.SheetId];
            
            sheet.Reset();
        }
        else {
            createIBSheet2(element, createOptions.SheetId, createOptions.Width, createOptions.Height, createOptions.Locale);
        }
        
        sheet = window[createOptions.SheetId];
        
        var options = {};
        
        options.Cfg        = configOptions;
        options.HeaderMode = headerOptions;
        options.Cols       = columnOptions;
        IBS_InitSheet(sheet, options);
        
        othersOptions.AllowEvent4CheckAll  = othersOptions.AllowEvent4CheckAll  != null ? othersOptions.AllowEvent4CheckAll  : 0;
        othersOptions.AutoRowHeight        = othersOptions.AutoRowHeight        != null ? othersOptions.AutoRowHeight        : 0;
        othersOptions.ComboOpenMode        = othersOptions.ComboOpenMode        != null ? othersOptions.ComboOpenMode        : 1;
        othersOptions.CountFormat          = othersOptions.CountFormat          != null ? othersOptions.CountFormat          : "BOTTOMDATA / TOTALROWS";
        othersOptions.CountPosition        = othersOptions.CountPosition        != null ? othersOptions.CountPosition        : 4;
        othersOptions.Ellipsis             = othersOptions.Ellipsis             != null ? othersOptions.Ellipsis             : 1;
        othersOptions.FocusAfterProcess    = othersOptions.FocusAfterProcess    != null ? othersOptions.FocusAfterProcess    : 0;
        othersOptions.FocusEditMode        = othersOptions.FocusEditMode        != null ? othersOptions.FocusEditMode        : 1;
        othersOptions.InitComboNoMatchText = othersOptions.InitComboNoMatchText != null ? othersOptions.InitComboNoMatchText : 1;
        othersOptions.ThemePrefix          = othersOptions.ThemePrefix          != null ? othersOptions.ThemePrefix          : "GM";
        othersOptions.ThemeFolder          = othersOptions.ThemeFolder          != null ? othersOptions.ThemeFolder          : "Main";
        othersOptions.UserAgent            = othersOptions.UserAgent            != null ? othersOptions.UserAgent            : "IBSheet/7.0.0.0";
        //아이비시트추가
        othersOptions.SetExtendLastCol     = othersOptions.SetExtendLastCol     != null ? othersOptions.SetExtendLastCol     : 1;
        
        for (var key in othersOptions) {
            if (key.indexOf("Theme") < 0) {
                var setter = sheet["Set" + key] || sheet[key];
                
                if (setter) {
                    setter.call(sheet, othersOptions[key]);
                }
                else {
                    alert("[" + key + "] 설정을 지원하지 않습니다.");
                }
            }
        }
        
        if (!com.wise.util.isBlank(othersOptions.ThemePrefix) && !com.wise.util.isBlank(othersOptions.ThemeFolder)) {
            sheet.SetTheme(othersOptions.ThemePrefix, othersOptions.ThemeFolder);
        }
    }
    else {
        alert("[" + createOptions.ElementId + "] 요소를 찾을 수 없습니다.");
    }
}

/**
 * 시트 데이터를 로드한다.
 * 
 * @param searchOptions {Object} 검색 옵션
 * @param paramsOptions {Object} 파라메터 옵션
 * @param othersOptions {Object} 기타 옵션
 */
function loadSheetData(searchOptions, paramsOptions, othersOptions) {
    searchOptions = searchOptions || {};
    paramsOptions = paramsOptions || {};
    othersOptions = othersOptions || {};
    
    searchOptions.SheetId    = searchOptions.SheetId    != null ? searchOptions.SheetId    : "sheet";
    searchOptions.SearchMode = searchOptions.SearchMode != null ? searchOptions.SearchMode : smServerPaging;
    
    var sheet = window[searchOptions.SheetId];
    
    if (sheet) {
        var url = searchOptions.PageUrl;
        
        if (com.wise.util.isBlank(url)) {
            alert("[PageUrl] 속성을 찾을 수 없습니다.");
            
            return;
        }
        
        var params = paramsOptions.QueryParam != null ? paramsOptions.QueryParam : "";
        
        if (paramsOptions.FormParam) {
            if (params.length > 0) {
                params += "&";
            }
            
            params += FormQueryStringEnc(document.getElementById(paramsOptions.FormParam));
        }
        if (paramsOptions.ArrayParam) {
            for (var i = 0; i < paramsOptions.ArrayParam.length; i++) {
                if (params.length > 0) {
                    params += "&";
                }
                
                params += paramsOptions.ArrayParam[i].name + "=" + paramsOptions.ArrayParam[i].value;
            }
        }
        if (paramsOptions.ObjectParam) {
            for (var key in paramsOptions.ObjectParam) {
                if (params.length > 0) {
                    params += "&";
                }
                
                params += key + "=" + paramsOptions.ObjectParam[key];
            }
        }
        
        params = params.replace(/(page=([\d])*&|page=([\d])*$)/, "");
        
        var options = {};
        
        if (searchOptions.SearchMode == smServerPaging) {
            othersOptions.Param        = othersOptions.Param        != null ? othersOptions.Param        : params;
            othersOptions.PageParam    = othersOptions.PageParam    != null ? othersOptions.PageParam    : "page";
            othersOptions.OrderbyParam = othersOptions.OrderbyParam != null ? othersOptions.OrderbyParam : "orderby";
            
            for (var key in othersOptions) {
                if (key == "Param" || key == "PageParam" || key == "OrderbyParam" || key == "UseWaitImage" || key == "Sync") {
                    options[key] = othersOptions[key];
                }
            }
            
            sheet.DoSearchPaging(com.wise.help.url(url), options);
        }
        else {
            for (var key in othersOptions) {
                if (key == "Sync" || key == "Append") {
                    options[key] = othersOptions[key];
                }
            }
            
            sheet.DoSearch(com.wise.help.url(url), params, options);
        }
    }
    else {
        alert("[" + searchOptions.SheetId + "] 시트를 찾을 수 없습니다.");
    }
}

/**
 * 시트 데이터를 저장한다.
 * 
 * @param saveOptions {Object} 저장 옵션
 * @param paramsOptions {Object} 파라메터 옵션
 * @param othersOptions {Object} 기타옵션
 */
function saveSheetData(saveOptions, paramsOptions, othersOptions) {

	
    saveOptions   = saveOptions   || {};
    paramsOptions = paramsOptions || {};
    othersOptions = othersOptions || {};
    
    saveOptions.SheetId  = saveOptions.SheetId  != null ? saveOptions.SheetId  : "sheet";
    saveOptions.SaveMode = saveOptions.SaveMode != null ? saveOptions.SaveMode : "GetSaveJson";
    
    var sheet = window[saveOptions.SheetId];
    
    if (sheet) {
        var url = saveOptions.PageUrl;
        
        if (com.wise.util.isBlank(url)) {
            alert("[PageUrl] 속성을 찾을 수 없습니다.");
            
            return;
        }
        
        var params = paramsOptions.QueryParam != null ? paramsOptions.QueryParam : "";
        
        if (paramsOptions.FormParam) {
            if (params.length > 0) {
                params += "&";
            }
            
            params += FormQueryStringEnc(document.getElementById(paramsOptions.FormParam));
        }
        if (paramsOptions.ArrayParam) {
            for (var i = 0; i < paramsOptions.ArrayParam.length; i++) {
                if (params.length > 0) {
                    params += "&";
                }
                
                params += paramsOptions.ArrayParam[i].name + "=" + paramsOptions.ArrayParam[i].value;
            }
        }
        if (paramsOptions.ObjectParam) {
            for (var key in paramsOptions.ObjectParam) {
                if (params.length > 0) {
                    params += "&";
                }
                
                params += key + "=" + paramsOptions.ObjectParam[key];
            }
        }
        
        var options = {};
        
        if (saveOptions.SaveMode == "DoSave") {
            othersOptions.Param     = othersOptions.Param     != null ? othersOptions.Param     : params;
            othersOptions.Col       = othersOptions.Col       != null ? othersOptions.Col       : -1;
            othersOptions.Quest     = othersOptions.Quest     != null ? othersOptions.Quest     : 1;
            othersOptions.UrlEncode = othersOptions.UrlEncode != null ? othersOptions.UrlEncode : 1;
            othersOptions.Mode      = othersOptions.Mode      != null ? othersOptions.Mode      : 1;
            othersOptions.Delim     = othersOptions.Delim     != null ? othersOptions.Delim     : "|";
            
            for (var key in othersOptions) {
                if (key == "Param" || key == "Col" || key == "Quest" || key == "UrlEncode" || key == "Mode" || key == "Delim") {
                    options[key] = othersOptions[key];
                }
            }
            
            sheet.DoSave(com.wise.help.url(url), options);
        }
        else if (saveOptions.SaveMode == "DoAllSave") {
            othersOptions.Param     = othersOptions.Param     != null ? othersOptions.Param     : params;
            othersOptions.UrlEncode = othersOptions.UrlEncode != null ? othersOptions.UrlEncode : 1;
            othersOptions.Mode      = othersOptions.Mode      != null ? othersOptions.Mode      : 1;
            othersOptions.Delim     = othersOptions.Delim     != null ? othersOptions.Delim     : "|";
            
            for (var key in othersOptions) {
                if (key == "Param" || key == "UrlEncode" || key == "Mode" || key == "Delim") {
                    options[key] = othersOptions[key];
                }
            }
            
            sheet.DoAllSave(com.wise.help.url(url), options);
        }
        else {
            othersOptions.ParamName = othersOptions.ParamName != null ? othersOptions.ParamName : "sheetData";
            othersOptions.AllSave   = othersOptions.AllSave   != null ? othersOptions.AllSave   : 0;
            othersOptions.StdCol    = othersOptions.StdCol    != null ? othersOptions.StdCol    : -1;
            
            for (var key in othersOptions) {
                if (key == "AllSave" || key == "StdCol") {
                    options[key] = othersOptions[key];
                }
            }
            
            sheet.ExtendValidFail = 0;
            
            var json = sheet.GetSaveJson(options);
            if (sheet.ExtendValidFail) {
                return;
            }
            
            if (json.Code) {
            	
                switch (json.Code) {
                    case "IBS000":
                        alert("저장할 내역이 없습니다.");
                        break;
                    case "IBS010":
                    case "IBS020":
                        // Nothing to do.
                        break;
                }
            }
            else {
                var string = encodeURIComponent(othersOptions.ParamName) + "=" + encodeURIComponent(JSON.stringify(json.data));
                
                var result = sheet.GetSaveData(com.wise.help.url(url), string, params);
                sheet.LoadSaveData(result, {CallBack:sheetSaveCallBack});
            }
        }
    }
    else {
        alert("[" + saveOptions.SheetId + "] 시트를 찾을 수 없습니다.");
    }
}

function sheetSaveCallBack(sheet, code) {
}

/**
 * 시트 데이터를 추가한다.
 * 
 * @param id {String} 아이디
 * @param row {Number} 위치
 * @param level {Number} 레벨
 * @param data {Object} 데이터
 */
function addSheetData(id, row, level, data) {
    var sheet = window[id];
    
    var index = sheet.DataInsert(row, level);
    
    if (data) {
        for (var key in data) {
            sheet.SetCellValue(index, key, data[key]);
        }
    }
}

/**
 * 시트 옵션을 로드한다.
 * 
 * @param id {String} 아이디
 * @param row {Number} 행
 * @param column {Number} 열
 * @param url {String} URL
 * @param data {Object} 데이터
 */    
function loadSheetOptions(id, row, column, url, data) {
    // 옵션을 검색한다.
    $.post(
        com.wise.help.url(url),
        data,
        function(data, status, request) {
            if (data.data) {
                // 시트 옵션을 초기화한다.
                initSheetOptions(id, row, column, data.data);
            }
        },
        "json"
    );
}

/**
 * 시트 옵션을 초기화한다.
 * 
 * @param id {String} 아이디
 * @param row {Number} 행
 * @param column {Number} 열
 * @param data {Array} 데이터
 */
function initSheetOptions(id, row, column, data) {
    var options = {};
    
    options.ComboCode = "";
    options.ComboText = "";
    
    for (var i = 0; i < data.length; i++) {
        if (i > 0) {
            options.ComboCode += "|";
            options.ComboText += "|";
        }
        
        options.ComboCode += data[i].code;
        options.ComboText += data[i].name;
    }
    
    var sheet = window[id];
    
    sheet.SetColProperty(row, column, options);
}

/**
 * 시트 오류를 처리한다.
 * 
 * @param statusCode {Number} 상태 코드
 * @param statusMessage {String} 상태 메시지
 */
function handleSheetError(statusCode, statusMessage) {
    var status = statusCode != null ? statusCode : 0;
    
    switch (status) {
        case 0:
        case 200:
            break;
        default:
            alert("시스템 오류가 발생하였습니다.");
            break;
    }
}

////////////////////////////////////////////////////////////////////////////////
// 필터
////////////////////////////////////////////////////////////////////////////////
/**
 * 검색 필터를 추가한다.
 * 
 * @param id      {String} 아이디
 * @param filters {Array} 필터
 * @param options {Object} 옵션
 */
function addSearchFilters(id, filters, options, sigunFlag) {
    options = options || {};
    
    options.idPrefix   = options.idPrefix   ? options.idPrefix   : "";
    options.idKey      = options.idKey      ? options.idKey      : "colId";
    options.nameKey    = options.nameKey    ? options.nameKey    : "colNm";
    options.typeKey    = options.typeKey    ? options.typeKey    : "filtCd";
    options.needKey    = options.needKey    ? options.needKey    : "filtNeed";
    options.codeKey    = options.codeKey    ? options.codeKey    : "filtCode";
    options.optCodeKey = options.optCodeKey ? options.optCodeKey : "options";
    options.defCodeKey = options.defCodeKey ? options.defCodeKey : "filtDefault";
    options.defTextKey = options.defTextKey ? options.defTextKey : "filtDefaultNm";
    options.maxDaysKey = options.maxDaysKey ? options.maxDaysKey : "filtMaxDay";
    options.tabCodeKey = options.tabCodeKey ? options.tabCodeKey : "filtTblCd";
    options.onKeyDown  = options.onKeyDown  ? options.onKeyDown  : null;
    
    // options.showPopupCode = options.showPopupCode || function(code) {
    //     // Nothing do do.
    // };
    var required = false;
    
    for (var i = 0; i < filters.length; i++) {
        filters[i][options.defCodeKey] = filters[i][options.defCodeKey] ? filters[i][options.defCodeKey] : "";
        filters[i][options.defTextKey] = filters[i][options.defTextKey] ? filters[i][options.defTextKey] : "";

        // 2016.07.28
        // codeKey 가 SIGUN_CD, typeKey = COMBO 고 sigunFlag의 값이 있으면 디폴트를 sigunFlag로 바꿔줘야 한다.
        // 문제는 sigunFlag값이 내부용 ORG_CD 이고 5자리 공식 코드가 아니라는 점. (그래서 맵의 org_cd를 type_cd로 교체 
        if (filters[i][options.codeKey] == "SIGUN_CD" ) {
        	if (typeof sigunFlag == 'string' && sigunFlag != null && sigunFlag != "") {
		            filters[i][options.defCodeKey] = sigunFlag;
        	}        
        }
        
        
        switch (filters[i][options.typeKey]) {
            case "CHECK":
            case "RADIO":
            case "COMBO":
                if (filters[i][options.codeKey]) {
                    // 검색 필터를 추가한다.
                    addSearchFilter(id, filters[i], options);
                }
                break;
            case "WORDS":
            case "FDATE":
            case "LDATE":
            case "PDATE":
            case "SDATE":
            case "CDATE":
            // case "POPUP":
                // 검색 필터를 추가한다.
                addSearchFilter(id, filters[i], options);
                break;
            // case "PLINK":
            //     if (filters[i][options.defCodeKey]) {
            //         // 검색 필터를 추가한다.
            //         addSearchFilter(id, filters[i], options);
            //     }
            //     break;
        }
        
        if (filters[i][options.needKey] == "Y") {
            required = true;
        }
    }
    
    $(".ui-datepicker-trigger").css({
        // "vertical-align":"middle",
        // "margin":"0 3px",
        "cursor":"pointer"
    });
    
    if (required) {
        $(".toggle_search_C").click();
    }
}

/**
 * 검색 필터를 추가한다.
 * 
 * @param id {String} 아이디
 * @param filter {Object} 필터
 * @param options {Object} 옵션
 */
function addSearchFilter(id, filter, options) {
    // 검색 필터 템플을 가져온다.
    var row = $(getSearchFilterTemplate(filter, options));
    
    if (filter[options.needKey] == "Y") {
        row.find(".header").html("<strong>" + filter[options.nameKey] + " <span>필수입력</span></strong>");
    }
    else {
        row.find(".header").text(filter[options.nameKey]);
    }
    
    row.find(".filter").addClass(filter[options.typeKey].toLowerCase());
    
    if (filter[options.needKey] == "Y") {
        row.find(".filter").addClass("required");
    }
    
    var uid  = options.idPrefix + filter[options.idKey];
    var name = filter[options.idKey];
    var code = filter[options.defCodeKey];
    var text = filter[options.defTextKey];
    var days = filter[options.maxDaysKey];
    
    switch (filter[options.typeKey]) {
        case "CHECK":
        case "RADIO":
            row.find(".filter").attr("id", uid);
            break;
        case "COMBO":
            row.find(".header").attr("for", uid);
            row.find("select").attr("id", uid).attr("name", name).attr("title", filter[options.nameKey] + " 선택");
            break;
        case "WORDS":
            row.find(".header").attr("for", uid);
            row.find(":text").attr("id", uid).attr("name", name).val(code);
            break;
        case "FDATE":
        case "LDATE":
        case "PDATE":
        case "SDATE":
        case "CDATE":
            row.find(".header").attr("for", uid + "_FROM");
            row.find(":text").each(function(index, element) {
                if (index == 0) {
                    $(this).attr("id", uid + "_FROM").attr("name", name).val(code);
                }
                else {
                    $(this).attr("id", uid + "_TO").attr("name", name).val(code);
                }
            });
            row.find(".hidden").attr("id", uid + "_DAYS").attr("name", name + "_DAYS").val(days); 
            break;
        // case "POPUP":
        //     row.find(".header").attr("for", uid + "_NM");
        //     row.find(".hidden").attr("id", uid).attr("name", name).val(code);
        //     row.find(":text").attr("id", uid + "_NM").attr("name", name + "_NM").val(text);
        //     break;
        // case "PLINK":
        //     row.find(".header").attr("for", uid);
        //     row.find("a").attr("id", uid).attr("href", code).text(code);
        //     break;
    }
    
    $("#" + id).append(row);
    
    // 검색 필터 컴포넌트를 설정한다.
    setSearchFilterComponent(filter, options);
}

/**
 * 검색 필터 템플릿을 반환한다.
 * 
 * @param filter {Object} 필터
 * @param options {Object} 옵션
 * @returns {String} 템플릿
 */
function getSearchFilterTemplate(filter, options) {
    var template = "";
    
    template += "<tr>";
    template += "<th scope=\"row\">";
    template += "<label class=\"header\"></label>";
    template += "</th>";
    template += "<td>";
    template += "<span class=\"field filter\">";
    
    switch (filter[options.typeKey]) {
        case "CHECK":
        case "RADIO":
            break;
        case "COMBO":
            template += "<select></select>";
            break;
        case "WORDS":
            template += "<input type=\"text\" autocomplete=\"on\" style=\"width:100%;\" />";
            break;
        case "FDATE":
        case "LDATE":
        case "PDATE":
        case "SDATE":
        case "CDATE":
            template += "<input type=\"text\" autocomplete=\"on\" style=\"width:100px;\" title=\"시작일자(입력예:YYYY-MM-DD)\"  />";
            template += " ";
            template += "~";
            template += " ";
            template += "<input type=\"text\" autocomplete=\"on\" style=\"width:100px;\" title=\"종료일자(입력예:YYYY-MM-DD)\"  />";
            template += "<input type=\"hidden\" class=\"hidden\" disabled=\"disabled\" />";
            template += " ";
            template += "<a href=\"#\" title=\"초기화\" class=\"reset\"><img src=\"" + com.wise.help.url("/img/ggportal/desktop/common/btn_reset.png") + "\" alt=\"\" /></a>";
            break;
        // case "POPUP":
        //     template += "<input type=\"hidden\" class=\"hidden\" />";
        //     template += "<input type=\"text\" readonly=\"readonly\" />";
        //     template += " ";
        //     template += "<button type=\"button\" class=\"search\">조회</button>";
        //     template += " ";
        //     template += "<button type=\"button\" class=\"reset\">초기화</button>";
        //     break;
        // case "PLINK":
        //     template += "<a href=\"#\" target=\"_blank\"></a>";
        //     break;
    }
    
    template += "</span>";
    template += "</td>";
    template += "</tr>";
    
    return template;
}

/**
 * 검색 필터 컴포넌트를 설정한다.
 * 
 * @param filter {Object} 필터
 * @param options {Object} 옵션
 */
function setSearchFilterComponent(filter, options) {
    var component = $(".filter:last");
    
    var uid  = options.idPrefix + filter[options.idKey];
    var name = filter[options.idKey];
    var data = filter[options.optCodeKey];
    var code = filter[options.defCodeKey];
    
    switch (filter[options.typeKey]) {
        case "CHECK":
            // 체크 옵션을 초기화한다.
            initCheckOptions(uid, name, data, code);
            break;
        case "RADIO":
            // 라디오 옵션을 초기화한다.
            initRadioOptions(uid, name, data, code);
            break;
        case "COMBO":
            // 콤보 옵션을 초기화한다.
            initComboOptions(uid, [{
                code:"",
                name:"선택"
            }].concat(data), code);
            break;
        case "WORDS":
            component.find(":text").bind("keydown", function(event) {
                if (event.which == 13) {
                    if (options.onKeyDown) {
                        options.onKeyDown();
                    }
                    return false;
                }
            });
            break;
        case "FDATE":
        case "LDATE":
        case "PDATE":
        case "SDATE":
        case "CDATE":
            component.find(":text").each(function(index, element) {
                // 날짜 선택기를 바인딩한다.
                $(this).datepicker(com.wise.help.datepicker({
                    buttonImage:com.wise.help.url("/images/admin/icon_calendar.png"),
                    dateFormat:getSearchFilterPatterns(filter, options)
                }));
            });
            component.find(".reset").bind("click", function(event) {
                $(this).parent("span").find(":text").each(function(index, element) {
                    $(this).val("");
                });
                return false;
            });
            component.find(".reset").bind("keydown", function(event) {
                if (event.which == 13) {
                    $(this).parent("span").find(":text").each(function(index, element) {
                        $(this).val("");
                    });
                    return false;
                }
            });
            break;
        // case "POPUP":
        //     component.find(".search").bind("click", {
        //        title:filter[options.nameKey],
        //        table:filter[options.tabCodeKey]
        //     }, function(event) {
        //         // 팝업 코드 검색 화면을 보인다.
        //         options.showPopupCode(event.data.title, event.data.table);
        //         return false;
        //     });
        //     component.find(".search").bind("keydown", {
        //        title:filter[options.nameKey],
        //        table:filter[options.tabCodeKey]
        //     }, function(event) {
        //         if (event.which == 13) {
        //             // 팝업 코드 검색 화면을 보인다.
        //             options.showPopupCode(event.data.title, event.data.table);
        //             return false;
        //         }
        //     });
        //     component.find(".reset").bind("click", function(event) {
        //         $(this).parent("span").find(".hidden").val("");
        //         $(this).parent("span").find(":text"  ).val("");
        //         return false;
        //     });
        //     component.find(".reset").bind("keydown", function(event) {
        //         if (event.which == 13) {
        //             $(this).parent("span").find(".hidden").val("");
        //             $(this).parent("span").find(":text"  ).val("");
        //             return false;
        //         }
        //     });
        // case "PLINK":
        //     // Nothing to do.
        //     break;
    }
}

/**
 * 검색 필터 패턴을 반환한다.
 * 
 * @param filter {Object} 필터
 * @param options {Object} 옵션
 * @returns {String} 패턴
 */
function getSearchFilterPatterns(filter, options) {
    var pattern = "";
    
    switch (filter[options.typeKey]) {
        case "CHECK":
        case "RADIO":
        case "COMBO":
        case "WORDS":
            break;
        case "FDATE":
            pattern = "yy-mm-dd";
            break;
        case "LDATE":
            pattern = "yy/mm/dd";
            break;
        case "PDATE":
            pattern = "yy.mm.dd";
            break;
        case "SDATE":
        case "CDATE":
            pattern = "yymmdd";
            break;
        // case "POPUP":
        // case "PLINK":
        //     break;
    }
    
    return pattern;
}

/**
 * 검색 필터를 검증한다.
 * 
 * @param id {String} 아이디
 */
function checkSearchFilters(id) {
    var check = true;
    
    $("#" + id).find(".filter").each(function(index, element) {
        var title = $(this).parent("td").parent("tr").find(".header").text();
        
        if ($(this).hasClass("check")) {
            if ($(this).hasClass("required")) {
                if ($(this).find(":checkbox:checked").size() == 0) {
                    alert(title + " 항목을 선택하여 주십시오.");
                    check = false;
                    return false;
                }
            }
        }
        else if ($(this).hasClass("radio")) {
            if ($(this).hasClass("required")) {
                if ($(this).find(":radio:checked").size() == 0) {
                    alert(title + " 항목을 선택하여 주십시오.");
                    check = false;
                    return false;
                }
            }
        }
        else if ($(this).hasClass("combo")) {
            if ($(this).hasClass("required")) {
                if (com.wise.util.isBlank($(this).find("select").val())) {
                    alert(title + " 항목을 선택하여 주십시오.");
                    $(this).find("select").focus();
                    check = false;
                    return false;
                }
            }
        }
        else if ($(this).hasClass("words")) {
            if ($(this).hasClass("required")) {
                if (com.wise.util.isBlank($(this).find(":text").val())) {
                    alert(title + " 항목을 입력하여 주십시오.");
                    $(this).find(":text").focus();
                    check = false;
                    return false;
                }
            }
        }
        // else if ($(this).hasClass("popup")) {
        //     if ($(this).hasClass("required")) {
        //         if (com.wise.util.isBlank($(this).find(".hidden").val())) {
        //             alert(title + " 항목을 선택하여 주십시오.");
        //             check = false;
        //             return false;
        //         }
        //         if (com.wise.util.isBlank($(this).find(":text").val())) {
        //             alert(title + " 항목을 선택하여 주십시오.");
        //             check = false;
        //             return false;
        //         }
        //     }
        // }
        // else if ($(this).hasClass("plink")) {
        //     // Nothing to do.
        // }
        else {
            var from = com.wise.util.toNumeric($(this).find(":text:eq(0)").val());
            var to   = com.wise.util.toNumeric($(this).find(":text:eq(1)").val());
            var days = com.wise.util.toNumeric($(this).find(".hidden").val());
            
            if ($(this).hasClass("required")) {
                if (com.wise.util.isBlank(from)) {
                    alert(title + " 시작일자를 입력하여 주십시오.");
                    $(this).find(":text:eq(0)").focus();
                    check = false;
                    return false;
                }
                if (com.wise.util.isBlank(to)) {
                    alert(title + " 종료일자를 입력하여 주십시오.");
                    $(this).find(":text:eq(1)").focus();
                    check = false;
                    return false;
                }
            }
            
            if (!com.wise.util.isBlank(from) && !com.wise.util.isBlank(to)) {
                from = com.wise.util.parseDate(from, "yyyyMMdd").getTime();
                to   = com.wise.util.parseDate(to,   "yyyyMMdd").getTime();
                days = com.wise.util.toInteger(days) * 24 * 60 * 60 * 1000;
                
                if (from > to) {
                    alert(title + " 시작일자가 종료일자보다 큽니다.");
                    $(this).find(":text:eq(1)").focus();
                    check = false;
                    return false;
                }/*
                if (to - from > days) {
                    alert(title + " 조회기간이 최대기간보다 큽니다.");
                    $(this).find(":text:eq(1)").focus();
                    check = false;
                    return false;
                }*/
            }
        }
    });
    
    return check;
}

/**
 * 시트 데이터 위/아래 이동
 * @param sheetObj	시트객체
 * @param action	액션명
 * @returns
 */
function sheetDataMove(sheetObj, action) {
	if (sheetObj == null)	return;
	
	var selectRow = sheetObj.GetSelectRow();
	if ( selectRow > 0 ) {
		switch (action) {
		case "up":
			sheetObj.DataMove(selectRow-1, selectRow);
			break;
		case "down":
			sheetObj.DataMove(selectRow+2, selectRow);
			break;	
		}
		
		sheetDataMoveOrder(sheetObj);
	}
}

/**
 * 시트 데이터 위/아래이동 후 순서 재조정(전체행에 대해서)
 * @returns
 */
function sheetDataMoveOrder(sheetObj) {
	var headerRows = sheetObj.HeaderRows();
	for ( var i=0; i < sheetObj.RowCount(); i++ ) {
		sheetObj.SetCellValue(headerRows+i, "vOrder", headerRows+i);
	}
}

/**
 * 탭 내의 시트 데이터를 저장한다.
 * @param sheet
 * @param url
 * @param params
 * @param callback
 * @returns
 */
function saveTabSheetData(sheet, url, params, callback) {
	callback = callback || {};
	
	if (sheet) {
		
		var json = sheet.GetSaveJson({AllSave:false});
		if (json.Code) {
	    	
	        switch (json.Code) {
	            case "IBS000":
	                alert("저장할 내역이 없습니다.");
	                break;
	            case "IBS010":
	            case "IBS020":
	                // Nothing to do.
	                break;
	        }
	    }
	    else {
	        var string = encodeURIComponent("sheetData") + "=" + encodeURIComponent(JSON.stringify(json.data));
	        
	        var result = sheet.GetSaveData(com.wise.help.url(url), string, params);
	        doAjaxMsg(JSON.parse(result), "");
	        if (typeof callback === 'function') {
	    		callback();
	    	}
//	        sheet.LoadSaveData(result, {CallBack:callback});
	    }
	}
	else {
		alert("시트를 찾을 수 없습니다.")
		return false;
	}
}

////////////////////////////////////////////////////////////////////////////////
//통계관련
////////////////////////////////////////////////////////////////////////////////
/**
 * 통계표 입력 시트를 초기화한다
 * 
 * @param data {Object} 항목/분류 데이터
 */
function initStatInputSheet(data) {
	//리턴될 데이터
	var rtnData = new Object();
	//단위 행
	var uiRowCnt = 1;
	//헤더 Text 관련 변수
	var gridArr = [];
	var iArr = null;
	//항목 관련데이터
	var iData = data.data.I_DATA;			//항목 데이터
	var iMaxLevel = data.data.I_MAX_LEVEL;	//항목 최대 레벨
	var iColCnt = data.data.I_COL_CNT;		//항목 갯수(1레벨 갯수)
	//분류 관련데이터
	var cData = data.data.C_DATA;
	var cMaxLevel = data.data.C_MAX_LEVEL;
	var cColCnt = data.data.C_COL_CNT;
	//그룹 관련데이터
	var gData = data.data.G_DATA;
	var gMaxLevel = data.data.G_MAX_LEVEL;
	var gColCnt = data.data.G_COL_CNT;
	
	var markYn = data.data.MARK_YN || "N";
	
	var cmmtYn = data.data.CMMT_YN || "N";

	//컬럼
	var cols = [
	            {Type:"Seq",		SaveName:"seq",				Width:30,	Align:"Center",		Edit:false}
	            ,{Type:"Status",	SaveName:"status",			Width:40,	Align:"Center",		Edit:false,	Hidden:true}
	            ,{Type:"Text",		SaveName:"wrttimeIdtfrId",	Width:80,	Align:"Center",		Edit:false,	Hidden:true}
	            ,{Type:"Text",		SaveName:"dYear",			Width:60,	Align:"Center",		Edit:false}
	    ];
	
	//필수입력
	var inputKeys = [];
	
	// 그룹(message.properties 사용)
	var isInIframe = (window.location != window.parent.location);	// 호출되는 함수가 iframe에서 호출되는지 체크
	var statGroupTxt = $("#statGroupTxt").val() || (isInIframe ? parent.statMainForm.statGroupTxt.value : "그룹" );
	
	//헤더 Text Setting
	var iArrTmp = new Array();	//validation 처리를 위해 array 하나 추가로 생성
	var forCnt = iMaxLevel + uiRowCnt;
	for ( var i=0; i < forCnt; i++ ) {
		iArr = new Array();
		iArr.push("No");
		iArr.push("상태");
		iArr.push("자료시점코드");
		iArr.push("자료시점");
		for ( var j=0; j < gMaxLevel; j++ ) {
			iArr.push(statGroupTxt);
		}
		for ( var j=0; j < cMaxLevel; j++ ) {
			iArr.push("분류");
		}
		iArr.push("그룹데이터번호");
		iArr.push("분류데이터번호");
		iArr.push("통계자료");
		iArr.push("통계자료코드");
		for ( var r in iData) {
			//if ( iData[r].leaf == 1 ) {	//자식노드가 없는경우
			if ( iData[r].dummyYn == "N" ) {	
				if ( i == forCnt-1 ) {
					iArr.push(iData[r].uiNm);
				} else { 
					var itmNmArr = iData[r].itmFullNm.split('>');
					var itmStr = "";
					if ( itmNmArr.length > 1 ) {	//레벨단위로 항목명 length보다 큰 경우(레벨로 된 항목인경우)
						if ( (i+1) > itmNmArr.length ) {	//항목레벨보다 max level이 항상 크지 않으므로 마지막 항목레벨 값 넣는다.
							itmStr = itmNmArr[itmNmArr.length-1];
						} else {
							itmStr = itmNmArr[i];
						}
					} else {
						itmStr = iData[r].itmNm;
					}
					
					//forCnt(헤더 전체 row 수)
					//  => 데이터의 마지막 2row위(항목 값 마지막 레벨 text값)에 필수 입력 여부 표시해주기 위함(forCnt-1은 항목단위임)
					if ( i == forCnt-2 && iData[r].inputNeedYn == "Y" ) {
						itmStr = itmStr + " (*)";
					}
					iArr.push(itmStr);
				}
			}
			
		}
		//validation 처리를 위해 숨김 행 넣기
		if ( i == forCnt-2 ) {
			iArrTmp = iArr;
		}
		gridArr.push({Text:iArr.join("|"), Align:"Center"} );
	}
	//iArrTmp 값 마지막에 입력함(실제 데이터 표시는 하지 않음 => 숨김처리)
	gridArr.push({Text:iArrTmp.join("|"), Align:"Center"} );
	
	//컬럼정보 Setting
	for ( var i=1; i <= gMaxLevel; i++ ) {	//그룹 값 cols
		cols.push({
			Type 		: "Text",
			SaveName 	: "gCol" + String(i),
			Width 		: 70,
			Align 		: "Center",
			Edit 		: false
		})
	}
	
	for ( var i=1; i <= cMaxLevel; i++ ) {	//분류 값 cols
		cols.push({
			Type 		: "Text",
			SaveName 	: "cCol" + String(i),
			Width 		: 70,
			Align 		: "Center",
			Edit 		: false
		})
	}
	
	cols.push({		//그룹 코드값
		Type 		: "Text",
		SaveName 	: "gColDatano",
		Width 		: 70,
		Align 		: "Center",
		Edit 		: false,
		Hidden 		: true
	});
	
	cols.push({		//분류 코드값
		Type 		: "Text",
		SaveName 	: "cColDatano",
		Width 		: 70,
		Align 		: "Center",
		Edit 		: false,
		Hidden 		: true
	});
	
	cols.push({		//통계자료 명
		Type 		: "Text",
		SaveName 	: "dtadvsNm",
		Width 		: 70,
		Align 		: "Center",
		Edit 		: false,
		Hidden		: true
	});
	cols.push({		//통계자료 코드(통계데이터 좌측에 있어야함..)
		Type 		: "Text",
		SaveName 	: "dtadvsCd",
		Width 		: 70,
		Align 		: "Center",
		Edit 		: false,
		Hidden 		: true
	});
	
	for ( var r in iData ) {
		//if ( iData[r].leaf == 1 ) {	//자식노드가 없는경우
		if ( iData[r].dummyYn == "N" ) {	//입출력여부
			cols.push({
				//통계기호 입력여부와 주석 입력이 Y인경우 Text형식으로 설정한다
				Type 		: ( markYn == "Y" || cmmtYn == "Y" ) ? "Text" : "Float",
				SaveName 	: "iCol_" + String(iData[r].datano),
				Width 		: 70,
				Align 		: "Right",
				ColMerge	: false,
				//필수입력 여부가 Y인경우 && 통계기호 입력여부가 N인경우만 KeyField설정
				KeyField	: (iData[r].inputNeedYn == "Y" ? (markYn == "Y" ? 0 : 1) : 0),	
				Edit 		: true
			});
		}
	}
	
	
	
	rtnData.headTxt = gridArr;
	rtnData.cols = cols;
	rtnData.gridRowLen = gridArr.length

	return rtnData;
	
}


////////////////////////////////////////////////////////////////////////////////
// 기타
////////////////////////////////////////////////////////////////////////////////
/**
 * 윈도우를 띄운다.
 * 
 * @param url {String} URL
 * @param target {String} 대상
 * @param options {Object} 옵션
 * @param params {Object} 파라메터
 * @returns {Object} 윈도우
 */
function openWindow(url, target, options, params) {
    var feature = "";
    
    if (options) {
        feature += "channelmode=" + (options.channelmode || "no"   ) + ",";
        feature += "fullscreen="  + (options.fullscreen  || "no"   ) + ",";
        feature += "titlebar="    + (options.titlebar    || "no"   ) + ",";
        feature += "menubar="     + (options.menubar     || "no"   ) + ",";
        feature += "toolbar="     + (options.toolbar     || "no"   ) + ",";
        feature += "location="    + (options.location    || "no"   ) + ",";
        feature += "directories=" + (options.directories || "no"   ) + ",";
        feature += "status="      + (options.status      || "no"   ) + ",";
        feature += "top="         + (options.top         || "10px" ) + ",";
        feature += "left="        + (options.left        || "10px" ) + ",";
        feature += "width="       + (options.width       || "400px") + ",";
        feature += "height="      + (options.height      || "300px") + ",";
        feature += "resizable="   + (options.resizable   || "yes"  ) + ",";
        feature += "scrollbars="  + (options.scrollbars  || "yes"  );
    }
    
    var query = "";
    
    if (params) {
        switch (params.type) {
            case "object":
                for (var key in params.data) {
                    if (query.length == 0) {
                        query += "?";
                    }
                    else {
                        query += "&";
                    }
                    
                    query += key + "=" + params.data[key];
                }
                break;
            case "array":
                for (var i = 0; i < params.data.length; i++) {
                    if (query.length == 0) {
                        query += "?";
                    }
                    else {
                        query += "&";
                    }
                    
                    query += params.data[i].name + "=" + params.data[i].value;
                }
                break;
        }
    }
    
    return window.open(com.wise.help.url(url) + query, target || "", feature);
}

/**
 * 윈도우를 닫는다.
 * 
 * @param window {Object} 윈도우
 */
function closeWindow(window) {
    (window || self).close();
}

/**
 * 값을 설정한다.
 * 
 * @param element {Element} 요소
 * @param value {String} 값
 */
function setValue(element, value) {
    switch (element.type) {
        case "file":
        case "image":
        case "reset":
        case "submit":
        case "button":
            break;
        case "radio":
        case "checkbox":
            if (element.value == value) {
                element.checked = true;
            }
            else {
                element.checked = false;
            }
            
            break;
        default:
            element.value = value;
            
            break;
    }
}

/**
 * 값을 복사한다.
 * 
 * @param source {Element} 원본 요소
 * @param destination {Element} 대상 요소
 */
function copyValue(source, destination) {
    switch (source.type) {
        case "file":
        case "image":
        case "reset":
        case "submit":
        case "button":
            break;
        case "radio":
            if (source.checked) {
                destination.value = source.value;
            }
            break;
        case "checkbox":
            if (source.checked) {
                destination.value = com.wise.util.isEmpty(destination.value) ? source.value : destination.value + "," + source.value;
            }
            
            break;
        default:
            destination.value = source.value;
            
            break;
    }
};

/**
 * 체크박스를 토글한다.
 * 
 * @param checkbox {Object} 체크박스
 * @param selector {String} 셀렉터
 */
function toggleCheckbox(checkbox, selector) {
    $(selector).each(function(index, element) {
        this.checked = checkbox.checked;
    });
};

/**
 * 행번호를 반환한다.
 * 
 * @param count {String} 건수
 * @param number {String} 번호
 */
function getRowNumber(count, number) {
    if (count) {
        return parseInt(count) - (parseInt(number) - 1)
    }
    
    return parseInt(number);
}
/**
 * 검색어 반환
 * 
 * @param searchWord 
 * @returns
 */
function htmlTagFilter(searchWord){
	 var filtArr = ["~","!","@","#","$",
	                   "%","^","&","*","(",
	                   ")","-","+","{","}",
	                   "?","[","]","<",">","/",
	                   "\\","\"",".","'"];
	 var isCheck = false;
	 
     for(var i=0; i<filtArr.length; i++){
   	 if(searchWord.indexOf(filtArr[i])> -1){
   		 isCheck = true;
   		 }
   	 }   
	  if(isCheck){
		  alert("특수문자는 사용하실 수 없습니다.");
		  return false;  
	  }
	  searchWord = searchWord.replace(/&/gi,"&amp;").replace(/\\/gi,"&quot;").replace(/</gi,"&lt;").replace(/>/gi,"&gt;");
	  return searchWord;	
		
}

/**
* 시트 데이터를 확인하여 Row반환
 * @param searchWord 
 * @returns row
*/
function findSheetRow(sheetNm, searchWord, tField){
	var returnVal = null;
	
	var searchWord = searchWord;
	if(searchWord != "" && searchWord != null){
		var headRow = window[sheetNm].HeaderRows(); //시트의 헤더 row를 확인한다.
		var rowCnt = window[sheetNm].RowCount() + headRow - 1;
		
		if ( rowCnt > 0 ) {
			for ( var i=headRow; i <= rowCnt; i++ ) {
				var jRow = window[sheetNm].GetRowData(i);
				if( eval("jRow."+tField) == searchWord){
					returnVal = i;
					break;
				}
			}
		}
	}
	
	return returnVal;
}

/**
 * 로딩중 표시
 */
function gfn_showLoading() {
	$("#loadingCircle").show();
}

/**
 * 로딩중 숨김
 */
function gfn_hideLoading() {
	$("#loadingCircle").hide();
}

/**
 * 카카오스토리 공유
 */
function shareStory(url, text) {
    var origin = window.location.origin;
    if (origin === "http://localhost:8080") {
        url = url.replace(origin, "https://open.assembly.go.kr");
    }
    // console.log(origin);
    // console.log(url.replace(origin, "https://open.assembly.go.kr"));

	Kakao.Story.share({
		url : url,
		text: text
	});
}

/**
 * NAVER 공유
 */
function shareNaver(url, text) {
    if (!text) {
        text = "열린국회정보";
    }
	window.open("https://share.naver.com/web/shareView.nhn?url="
            +encodeURIComponent(url)
            +"&title="+encodeURIComponent(text)
    		, "_blank"
    		, 'width=600,height=400,resizable=yes,scrollbars=yes'
    		);
}
/**
 * 트위터 공유
 */
function shareTwitter(url, text) {
	window.open("https://twitter.com/share"
    		+"?text="+encodeURIComponent(text)
    		+"&url="+encodeURIComponent(url)
    		, "_blank"
    		, 'width=600,height=400,resizable=yes,scrollbars=yes'
    		);
}
/**
 * 페이스북 공유
 */
function shareFace(url) {
	window.open("https://www.facebook.com/sharer/sharer.php"
			+"?u="+encodeURIComponent(url)
    		, "_blank"
    		, 'width=600,height=400,resizable=yes,scrollbars=yes'
    		);
}

/*카카오톡 공유*/
function shareKT(url, text) {
    /*카카오톡 공유*/
    Kakao.Link.sendDefault({
        objectType: "feed",
        content: {
            title: text,
            description: "#열린국회정보",
            imageUrl: "https://open.assembly.go.kr/kakao.png",
            imageWidth: 800,
            imageHeight: 400,
            link: {
                mobileWebUrl: url,
                webUrl: url
            }
        }
    });
 }


