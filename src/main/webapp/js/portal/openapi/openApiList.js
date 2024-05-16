/*
 * @(#)openApiList.js
 * 
 */

/**
 * Open API 목록을 검색하는 스크립트이다.
 *
 * @author 
 * @version 
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
    
    //checkForHash();
    
});

////////////////////////////////////////////////////////////////////////////////
// 글로벌 변수
////////////////////////////////////////////////////////////////////////////////

/**
 * 템플릿
 */
var templates = {
    data:
        "<tr>"                                                                                                      +
            "<td class=\"number rowNum\"></td>"                                                                     +
            "<td class=\"name left\">"                                                                              +
                "<a href=\"#\" class=\"dataset-select-link\"><strong class=\"point-color01 infNm\"></strong></a>"   +
                "<ul class=\"mobile-info\">"                                                                        +
	                "<li class=\"regDttm\" ></li>"                                                                  +
	                "<li class=\"none viewCnt\"></li>"                                                              +
                "</ul>"                                                                                             + 
            "</td>"                                                                                                 +
            "<td class=\"summary left infExp\"></td>"                                                               +
            "<td class=\"date regDttm\"></td>"                                                                      +
            "<td class=\"hit viewCnt\"></td>"                                                                       +
        "</tr>",
    none:
        "<tr>"                                                                                                      +
            "<td colspan=\"5\">해당 자료가 없습니다.</td>"                                                          +
        "</tr>"
};

////////////////////////////////////////////////////////////////////////////////
// 초기화 함수
////////////////////////////////////////////////////////////////////////////////
/**
 * 컴포넌트를 초기화한다.
 */
function initComp() {
	// 공공데이터 데이터셋 검색어 필드를 초기화한다.
	$("#dataset-searchword-field").val($("#dataset-search-form :hidden[name=searchWord]:last").val());
    
}

/**
 * 마스크를 바인딩한다.
 */
function bindMask() {
    
}

/**
 * 이벤트를 바인딩한다.
 */
function bindEvent() {
    
    
    // 공공데이터 데이터셋 검색어 필드에 키다운 이벤트를 바인딩한다.
    $("#dataset-searchword-field").bind("keydown", function(event) {
        if (event.which == 13) {
            // 공공데이터 데이터셋 검색어를 변경한다.
            changeDatasetSearchWord();
            return false;
        }
    });
    
    // 공공데이터 데이터셋 검색 버튼에 클릭 이벤트를 바인딩한다.
    $("#dataset-search-button").bind("click", function(event) {
        // 공공데이터 데이터셋 검색어를 변경한다.
        changeDatasetSearchWord();
        return false;
    });
    
    // 공공데이터 데이터셋 검색 버튼에 키다운 이벤트를 바인딩한다.
    $("#dataset-search-button").bind("keydown", function(event) {
        if (event.which == 13) {
            // 공공데이터 데이터셋 검색어를 변경한다.
            changeDatasetSearchWord();
            return false;
        }
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
    // 공공데이터 데이터셋 전체목록을 검색한다.
    searchDataset($("#dataset-search-form [name=page]").val());
}

////////////////////////////////////////////////////////////////////////////////
// 서비스 함수
////////////////////////////////////////////////////////////////////////////////
/**
 * 공공데이터 데이터셋 전체목록을 검색한다.
 * 
 * @param page {String} 페이지 번호
 */
function searchDataset(page) {
    // 데이터를 검색한다.
    doSearch({
        url:"/portal/openapi/searchOpenApiList.do",
        page:page ? page : "1",
        before:beforeSearchDataset,
        after:afterSearchDataset,
        pager:"dataset-pager-sect",
        counter:{
            count:"dataset-count-sect",
            pages:"dataset-pages-sect"
        }
    });
}

/**
 * 공공데이터 서비스를 조회한다.
 * 
 * @param data {Object} 데이터
 */
function selectService(data) {
    // 데이터를 조회하는 화면으로 이동한다.
    goSelect({
        url:"/portal/openapi/selectServicePage.do",
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
 * 공공데이터 데이터셋 검색어를 변경한다.
 */
function changeDatasetSearchWord() {
    var value = $("#dataset-searchword-field").val();
    
    value = htmlTagFilter(value);
    if(value == false) {
    	value = "";
    	$("#dataset-searchword-field").val(""); 
    }
    
    if (!com.wise.util.isBlank(value)) {
        var form = $("#dataset-search-form");
        
        if (form.find("[name=searchWord]").length == 0) {
            var hidden = $("<input type=\"hidden\" name=\"searchWord\" />");
            hidden.attr("value", value);
            
            form.append(hidden);
        }else{
        	form.find("[name=searchWord]").val(value);
        }
    }
    else {
        // if ($("#dataset-data-table .noData").length > 0) {
            var form = $("#dataset-search-form");
            
            form.find("[name=searchWord]").each(function(index, element) {
                $(this).remove();
            });
        // }
    }
    
    // 공공데이터 데이터셋 전체목록을 검색한다.
    searchDataset();
}

////////////////////////////////////////////////////////////////////////////////
// 전처리 함수
////////////////////////////////////////////////////////////////////////////////
/**
 * 공공데이터 데이터셋 전체목록 검색 전처리를 실행한다.
 * 
 * @param options {Object} 옵션
 * @returns {Object} 데이터
 */
function beforeSearchDataset(options) {
    var data = {
        // Nothing do do.
    };
    
    var form = $("#dataset-search-form");
    
    if (com.wise.util.isBlank(options.page)) {
        form.find("[name=page]").val("1");
    }
    else {
        form.find("[name=page]").val(options.page);
    }
    
    $.each(form.serializeArray(), function(index, element) {
        switch (element.name) {
            case "orgCd":
            case "cateId":
            case "srvCd":
            case "schwTagCont":
            case "searchWord":
                if (data[element.name] == null) {
                    data[element.name] = [];
                }
                
                data[element.name][data[element.name].length] = element.value;
                break;
            default:
                data[element.name] = element.value;
                break;
        }
    });
    
    return data;
}

////////////////////////////////////////////////////////////////////////////////
// 후처리 함수
////////////////////////////////////////////////////////////////////////////////
/**
 * 공공데이터 데이터셋 전체목록 검색 후처리를 실행한다.
 * 
 * @param data {Array} 데이터
 */
function afterSearchDataset(data) {
    var table = $("#dataset-data-table");
    
    table.find("tr").each(function(index, element) {
        if (index > 0) {
            $(this).remove();
        }
    });
    
    for (var i = 0; i < data.length; i++) {
        var row = $(templates.data);
        
        row.find(".infNm").text(data[i].infNm);
        row.find(".infExp").text(data[i].infExp ? com.wise.util.ellipsis(data[i].infExp, 56) : "");
       // row.find(".rowNum").text(getRowNumber($("#dataset-count-sect").text(), "" + data[i].rowNum));
        row.find(".rowNum").text(i + 1);
        
        row.find(".viewCnt").text(com.wise.util.toCurrency(data[i].viewCnt.toString()));
        row.find(".regDttm").text(data[i].regDttm);
        
        
        row.find(".dataset-select-link").each(function(index, element) {
            // 서비스 링크에 클릭 이벤트를 바인딩한다.
            $(this).bind("click", {
                infId:data[i].infId,
                infSeq:data[i].infSeq,
                infNm:data[i].infNm
                //currentPage : $(this).val()
               
            }, function(event) {
                // 공공데이터 서비스를 조회한다.
                selectService(event.data);
                return false;
            });
            
            // 서비스 링크에 키다운 이벤트를 바인딩한다.
            $(this).bind("keydown", {
                infId:data[i].infId,
                infSeq:data[i].infSeq,
                infNm:data[i].infNm
            }, function(event) {
                if (event.which == 13) {
                    // 공공데이터 서비스를 조회한다.
                    selectService(event.data);
                    return false;
                }
            });
        });
        
        table.append(row);
    }
    
    if (data.length == 0) {
        var row = $(templates.none);
        
        table.append(row);
    }
}

////////////////////////////////////////////////////////////////////////////////
// 이벤트 함수
////////////////////////////////////////////////////////////////////////////////