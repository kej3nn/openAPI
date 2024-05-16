/*
 * @(#)openApiDetail.js
 * 
 * COPYRIGHT (C) 2013 WISEITECH CO., LTD. ALL RIGHTS RESERVED.
 */

/**
 * 공공데이터 오픈API 서비스를 조회하는 스크립트이다.
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
    variables:{
        data:
            "<tr>"                                                                 +
                "<td class=\"colId\"></td>"                                        +
                "<td class=\"reqType reqNeed\"></td>"                              +
                "<td class=\"line-none colNm\"></td>"                              +
            "</tr>",
        none:
            "<tr>"                                                                 +
                "<td colspan=\"3\" class=\"line-none\">해당 자료가 없습니다.</td>" +
            "</tr>"
    },
    columns:{
        data:
            "<tr>"                                                                 +
                "<td class=\"rowNum\"></td>"                                       +
                "<td class=\"colId\"></td>"                                        +
                "<td class=\"line-none colNm unitNm\"></td>"                       +
            "</tr>",
        none:
            "<tr>"                                                                 +
                "<td colspan=\"3\" class=\"line-none\">해당 자료가 없습니다.</td>" +
            "</tr>"
    },
    urls:{
        data:
            "<tr>"                                                                                +
                "<td class=\"rowNum\"></td>"                                                      +
                "<td class=\"uriNm\"></td>"                                                       +
                "<td class=\"line-none left\"><a href=\"#\" class=\"apiEp apiRes uri\"></a></td>" +
            "</tr>",
        none:
            "<tr>"                                                                                +
                "<td colspan=\"3\" >해당 자료가 없습니다.</td>"                                   +
            "</tr>"
    },
    /*filters:{
        text:
            "<tr>"                                                                                             +
                "<th scope=\"row\">"                                                                           +
                    "<label class=\"colId reqNeed\"></label>"                                                  +
                "</th>"                                                                                        +
                "<td>"                                                                                         +
                    "<span class=\"field\">"                                                                   +
                        "<input type=\"text\" autocomplate=\"on\" style=\"width:100%;\" class=\"filtCode\" />" +
                    "</span>"                                                                                  +
                "</td>"                                                                                        +
            "</tr>",
        select:
            "<tr>"                                             +
                "<th scope=\"row\">"                           +
                    "<label class=\"colId reqNeed\"></label>"  +
                "</th>"                                        +
                "<td>"                                         +
                    "<span class=\"field\">"                   +
                        "<select class=\"filtCode\"></select>" +
                    "</span>"                                  +
                "</td>"                                        +
            "</tr>"
    },*/
    filters:{
        text:
            "<dl>"                                                                                             +
                "<dt>"                                                                                         +
                    "<label class=\"colId reqNeed\"></label>"                                                  +
                "</dt>"                                                                                        +
                "<dd>"                                                                                         +
                    "<input type=\"text\" autocomplate=\"on\" class=\"filtCode\" />"                           +
                "</dd>"                                                                                        +
            "</dl>",
        select:
            "<tr>"                                             +
                "<th scope=\"row\">"                           +
                    "<label class=\"colId reqNeed\"></label>"  +
                "</th>"                                        +
                "<td>"                                         +
                    "<span class=\"field\">"                   +
                        "<select class=\"filtCode\"></select>" +
                    "</span>"                                  +
                "</td>"                                        +
            "</tr>"
    },
    messages:{
        data:
            "<tr>"                                                                        +
                "<td class=\"msgTag\"></td>"                                              +
                "<td class=\"msgCd\"></td>"                                               +
                "<td class=\"msgExp left msgExp\" ></td>" +
            "</tr>",
        none:
            "<tr>"                                                              +
                "<td colspan=\"3\" class=\"line-none\">해당 자료가 없습니다.</td>" +
            "</tr>"
    }
};

var openAPIListData = {};
////////////////////////////////////////////////////////////////////////////////
// 초기화 함수
////////////////////////////////////////////////////////////////////////////////
/**
 * 컴포넌트를 초기화한다.
 */
//function initComp() {
//    // Nothing to do.
//}

function initComp() {
	// 윈도우 단위에서 키가 눌리면
    $(window).keyup(function (e) {
        // 발생한 이벤트에서 키 코드 추출, BackSpace 키의 코드는 8
    	if(e.target.nodeName != "INPUT" && e.target.nodeName != "TEXTAREA"){
	        if (e.keyCode == 8) {
	        	 searchDataset();
	        }
    	}
    });
    
    //xml 파싱 뷰어
    jQuery.parseXmlPreview = function(a,b,c) {
    		$.ajax(
    			{ url:a,type:"POST",dataType:b,success:function(res){var serializer=new XMLSerializer();var xmlText=serializer.serializeToString(res);xmlText=entityChange(xmlText);if(typeof c==="function"){return c(xmlText)}else{return window[c](xmlText)}}})
    }
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
    // 공공데이터 오픈API 서비스 명세서 다운로드 버튼에 클릭 이벤트를 바인딩한다.
    $("#openapi-download-button").bind("click", function(event) {
        // 공공데이터 오픈API 서비스 명세서를 조회한다.
        selectOpenApiSpec();
        return false;
    });
    
    // 공공데이터 오픈API 서비스 명세서 다운로드 버튼에 키다운 이벤트를 바인딩한다.
    $("#openapi-download-button").bind("keydown", function(event) {
        if (event.which == 13) {
            // 공공데이터 오픈API 서비스 명세서를 조회한다.
            selectOpenApiSpec();
            return false;
        }
    });
    
    // 공공데이터 오픈API 서비스 샘플 테스트 폼에 제출 이벤트를 바인딩한다.
    $("#openapi-request-form").bind("submit", function(event) {
        return false;
    });
    
    // 공공데이터 오픈API 서비스 샘플 테스트 조회 버튼에 클릭 이벤트를 바인딩한다.
    $("#openapi-request-button").bind("click", function(event) {
        // 공공데이터 오픈API 서비스 데이터를 검색한다.
        searchOpenApiData(addOpenApiFilt(), 1);
    	$("#apiSampleTest").html("");
    	var sampleUrl = $("#sampleTestUrl").text();
    	$.parseXmlPreview(sampleUrl, "xml", function(res){
    		$("#apiSampleTest").html(res);
    	});
        return false;
    });
    
    // 공공데이터 오픈API 서비스 샘플 테스트 키다운 버튼에 클릭 이벤트를 바인딩한다.
    $("#openapi-request-button").bind("keydown", function(event) {
        if (event.which == 13) {
            // 공공데이터 오픈API 서비스 데이터를 검색한다.
            searchOpenApiData(addOpenApiFilt(), 1);
        	$("#apiSampleTest").html("");
        	var sampleUrl = $("#sampleTestUrl").text();
        	$.parseXmlPreview(sampleUrl, "xml", function(res){
        		$("#apiSampleTest").html(res);
        	});
            return false;
        }
    });
    
    // 공공데이터 데이터셋 목록 버튼에 클릭 이벤트를 바인딩한다.
    $("#dataset-search-button").bind("click", function(event) {
        // 공공데이터 데이터셋 전체목록을 검색한다.
        searchDataset();
        return false;
    });
    
    // 공공데이터 데이터셋 목록 버튼에 키다운 이벤트를 바인딩한다.
    $("#dataset-search-button").bind("keydown", function(event) {
        if (event.which == 13) {
            // 공공데이터 데이터셋 전체목록을 검색한다.
            searchDataset();
            return false;
        }
    });
    
    $('#apiSrv').bind("change", function() {
    	selectService($('#apiSrv').val());
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
    // 공공데이터 오픈API 서비스 메타정보를 조회한다.
    selectOpenApiMeta();
    searchApiList("1");
}

////////////////////////////////////////////////////////////////////////////////
// 서비스 함수
////////////////////////////////////////////////////////////////////////////////
/**
 * 공공데이터 오픈API 서비스 메타정보를 조회한다.
 */
function selectOpenApiMeta() {
    // 데이터를 조회한다.
    doSelect({
        url:"/portal/data/openapi/selectOpenApiMeta.do",
        before:beforeSelectOpenApiMeta,
        after:afterSelectOpenApiMeta
    });
}

/**
 * 공공데이터 오픈API 서비스 데이터를 검색한다.
 * 
 * @param url {String} URL
 * @param index {Number} 인덱스
 */
function searchOpenApiData(url, index) {
    $(".openapi-response-iframe:eq(" + index + ")").attr("src", url);
}

/**
 * 공공데이터 오픈API 서비스 명세서를 조회한다.
 */
function selectOpenApiSpec() {
    // 데이터를 다운로드하는 화면으로 이동한다.
    goDownload({
        url:"/portal/data/openapi/downloadOpenApiSpec.do",
        form:"openapi-search-form",
        target:"global-process-iframe"
    });
}

/**
 * 공공데이터 데이터셋 전체목록을 검색한다.
 */
function searchDataset() {
    // 데이터를 검색하는 화면으로 이동한다.
    goSearch({
        url:"/portal/openapi/openApiListPage.do",
        form:"dataset-search-form"
    });
}

/**
 * 인증키 목록 조회
 */
function searchApiList(page) {
	doSearch({
		url:"/portal/openapi/searchOpenApiList.do",
		page:page ? page : "1",
        before:function(){return {};},
        after:afterSearchApiList
	});
}

/**
 * 공공데이터 오픈API 서비스 메타정보를 설정한다.
 * 
 * @param data {Object} 데이터
 */
function setOpenApiMeta(data) {
	$("#openapi-sampleTest-infNm").text(data.infNm);
    if (data.apiEp) {
        var url = data.apiEp;
        
        if (data.apiRes) {
            url += "/" + data.apiRes + ".do";
        }
        
        $(".apiEp.apiRes").each(function(index, element) {
            $(this).text(url);
        });
    }
    
    if (data.apiTrf) {
        $(".apiTrf").each(function(index, element) {
            $(this).text(data.apiTrf);
        });
    }
    else {
        $(".apiTrf").each(function(index, element) {
            $(this).text("제한없음");
        });
    }
}

/**
 * 공공데이터 오픈API 서비스 요청변수를 설정한다.
 * 
 * @param data {Array} 데이터
 */
function setOpenApiVars(data) {
    var table = $("#openapi-variables-table");
    
    table.find("tr").each(function(index, element) {
        if (index > 0) {
            $(this).remove();
        }
    });
    
    for (var i = 0; i < data.length; i++) {
        var row = $(templates.variables.data);
        
        if (data[i].colId) {
            row.find(".colId").text(data[i].colId);
        }
        if (data[i].reqType) {
            var type = data[i].reqType;
            
            if (data[i].reqNeed == "Y") {
                type += "(필수)";
            }
            else {
                type += "(선택)";
            }
            
            row.find(".reqType.reqNeed").text(type);
        }
        if (data[i].colNm) {
            row.find(".colNm").text(data[i].colNm);
        }
        if (data[i].colExp) {
            row.find(".colExp").text(data[i].colExp);
        }
        
        table.append(row);
    }
    
    if (data.length == 0) {
        var row = $(templates.variables.none);
        
        table.append(row);
    }
}

/**
 * 공공데이터 오픈API 서비스 응답컬럼을 설정한다.
 * 
 * @param data {Array} 데이터
 */
function setOpenApiCols(data) {
    var table = $("#openapi-columns-table");
    
    table.find("tr").each(function(index, element) {
        if (index > 0) {
            $(this).remove();
        }
    });
    
    for (var i = 0; i < data.length; i++) {
        var row = $(templates.columns.data);
        
        row.find(".rowNum").text(i + 1);
        
        if (data[i].colId) {
            row.find(".colId").text(data[i].colId);
        }
        if (data[i].colNm) {
            var name = data[i].colNm;
            
            if (data[i].unitNm) {
                name += data[i].unitNm;
            }
            
            row.find(".colNm.unitNm").text(name);
        }
        if (data[i].colExp) {
            row.find(".colExp").text(data[i].colExp);
        }
        
        table.append(row);
    }
    
    if (data.length == 0) {
        var row = $(templates.columns.none);
        
        table.append(row);
    }
}

/**
 * 공공데이터 오픈API 서비스 예제주소를 설정한다.
 * 
 * @param data {Array} 데이터
 */
function setOpenApiUrls(data) {
    var table = $("#openapi-urls-table");
    var table2 = $("#openapi-urls-table2");
    
    table.find("tbody tr").each(function(index, element) {
        if (index > 0) {
            $(this).remove();
        }
    });
    
    for (var i = 0; i < data.length; i++) {
        var row = $(templates.urls.data);
        
        row.find(".rowNum").text(i + 1);
        
        if (data[i].uriNm) {
            row.find(".uriNm").text(data[i].uriNm);
        }
        if (data[i].apiEp) {
            var url = data[i].apiEp;
            
            if (data[i].apiRes) {
                url += "/" + data[i].apiRes + ".do";
            }
            
            if (data[i].uri) {
                // if (data[i].uri.indexOf("?") < 0) {
                //     url += "?" + encodeURIComponent(data[i].uri);
                // }
                // else {
                //     url += data[i].uri.substring(data[i].uri.indexOf("?"));
                // }
                var query = "";
                
                if (data[i].uri.indexOf("?") < 0) {
                    query = data[i].uri;
                }
                else {
                    query = data[i].uri.substring(data[i].uri.indexOf("?") + 1);
                }
                
                var buffer = "";
                
                if (query) {
                    var pairs = query.split("&");
                    
                    for (var i = 0; i < pairs.length; i++) {
                        var tokens = pairs[i].split("=");
                        
                        if (buffer) {
                            buffer += "&";
                        }
                        
                        buffer += tokens[0] + "=" + encodeURIComponent(tokens[1]);
                    }
                }
                
                if (buffer) {
                    url += "?" + buffer;
                }
            }
            
            row.find(".apiEp.apiRes.uri").text(url);
        }
        
        row.find("a").each(function(index, element) {
            // 공공데이터 오픈API 서비스 샘플 URL 링크에 클릭 이벤트를 바인딩한다.
            $(this).bind("click", {
                url:$(this).text()
            }, function(event) {
                // 공공데이터 오픈API 서비스 데이터를 검색한다.
                //searchOpenApiData(event.data.url, 0);
            	$("#apiSample").html("");
            	$.parseXmlPreview(event.data.url, "xml", function(res){
            		$("#apiSample").html(res);
            	});
            	
                return false;
            });
            
            // 공공데이터 오픈API 서비스 샘플 URL 링크에 키다운 이벤트를 바인딩한다.
            $(this).bind("keydown", {
                url:$(this).text()
            }, function(event) {
                if (event.which == 13) {
                    // 공공데이터 오픈API 서비스 데이터를 검색한다.
                    //searchOpenApiData(event.data.url, 0);
                	$("#apiSample").html("");
                	$.parseXmlPreview(event.data.url, "xml", function(res){
                		$("#apiSample").html(res);
                	});
                    return false;
                }  
            });
        });
        
        table.append(row);
    }
    
    if (data.length == 0) {
        var row = $(templates.urls.none);
        
        table.append(row);
    } else {
    	table2.append("<pre class=\"pre-box\" id=\"apiSample\"></pre>");
    }
}

/**
 * 공공데이터 오픈API 서비스 조회필터를 설정한다.
 * 
 * @param data {Array} 데이터
 */
function setOpenApiFilt(data) {
    var table = $("#openapi-filters-table");
    
    table.find("tr").each(function(index, element) {
        $(this).remove();
    });
    
    for (var i = 0; i < data.length; i++) {
        var row = data[i].filtCode ? $(templates.filters.select) : $(templates.filters.text);
        
        if (data[i].colId) {
            var name = "ㆍ"+ data[i].colId;
            
            if (data[i].reqNeed == "Y") {
                name += "(필수)";
            }
            else {
                name += "(선택)";
            }
            
            var id = "openapi-filter-" + data[i].colId;
            
            row.find(".colId.reqNeed").attr("for", id).text(name);
            
            row.find(".filtCode").attr("id", id).attr("name", data[i].colId);
            
            if (data[i].filtCode) {
                row.find(".filtCode").attr("title", data[i].colId + " 선택");
                
                // 콤보 옵션을 로드한다.
                loadComboOptions(id, "/portal/common/code/searchDataCode.do", {
                    grpCd:data[i].filtCode,
                    apiYn:"Y",
                    defCd:"",
                    defNm:"선택"
                }, "");
            }
        }
        table.append(row);
    }
}

/**
 * 공공데이터 오픈API 서비스 조회필터를 추가한다.
 */
function addOpenApiFilt() {
    var table = $("#openapi-filters-table");
    
    var query = "";
    
    table.find("input, select").each(function(index, element) {
        var value = $(this).val();
        
        if (!com.wise.util.isBlank(value)) {
            if (com.wise.util.isBlank(query)) {
                query += "?";
            }
            else {
                query += "&";
            }
            
            query += $(this).attr("name") + "=" + encodeURIComponent(value);
        }
    });
    
    $(".apiEp.apiRes.apiFilt").text($(".apiEp.apiRes:eq(0)").text() + query);
    
    return $(".apiEp.apiRes.apiFilt").text();
}

/**
 * 공공데이터 오픈API 서비스 응답문자를 설정한다.
 * 
 * @param data {Array} 데이터
 */
function setOpenApiMsgs(data) {
    var table = $("#openapi-messages-table");
    
    table.find("tr").each(function(index, element) {
        if (index > 0) {
            $(this).remove();
        }
    });
    
    for (var i = 0; i < data.length; i++) {
        var row = $(templates.messages.data);
        
        if (data[i].msgTag) {
            row.find(".msgTag").text(data[i].msgTag);
        }
        if (data[i].msgCd) {
            row.find(".msgCd").text(data[i].msgCd);
        }
        if (data[i].msgExp) {
            row.find(".msgExp").text(data[i].msgExp);
        }
        
        table.append(row);
    }
    
    if (data.length == 0) {
        var row = $(templates.messages.none);
        
        table.append(row);
    }
}

////////////////////////////////////////////////////////////////////////////////
// 전처리 함수
////////////////////////////////////////////////////////////////////////////////
/**
 * 공공데이터 오픈API 서비스 메타정보 조회 전처리를 실행한다.
 * 
 * @param options {Object} 옵션
 * @returns {Object} 데이터
 */
function beforeSelectOpenApiMeta(options) {
    var data = {
        // Nothing do do.
    };
    
    var form = $("#openapi-search-form");
    var form2 = $("#dataset-search-form");
    var id = form2.find("input[name=infId]").val();
    var seq = form2.find("input[name=infSeq]").val();
    
    form.find("input[name=infId]").val(id);
    form.find("input[name=infSeq]").val(seq);
    
    $.each(form.serializeArray(), function(index, element) {
        switch (element.name) {
            case "infId":
            case "infSeq":
                data[element.name] = element.value;
                break;
        }
    });
    
    if (com.wise.util.isBlank(data.infId)) {
        return null;
    }
    if (com.wise.util.isBlank(data.infSeq)) {
        return null;
    }
    
    return data;
}

////////////////////////////////////////////////////////////////////////////////
// 후처리 함수
////////////////////////////////////////////////////////////////////////////////
/**
 * 공공데이터 오픈API 서비스 메타정보 조회 후처리를 실행한다.
 * 
 * @param data {Object} 데이터
 */
function afterSelectOpenApiMeta(data) {
    // 공공데이터 오픈API 서비스 메타정보를 설정한다.
    setOpenApiMeta(data);
    
    // 공공데이터 오픈API 서비스 요청변수를 설정한다.
    setOpenApiVars(data.variables);
    
    // 공공데이터 오픈API 서비스 응답컬럼을 설정한다.
    setOpenApiCols(data.columns);
    
    // 공공데이터 오픈API 서비스 예제주소를 설정한다.
    setOpenApiUrls(data.urls);
    
    // 공공데이터 오픈API 서비스 조회필터를 설정한다.
    setOpenApiFilt(data.filters);
    
    // 공공데이터 오픈API 서비스 응답문자를 설정한다.
    setOpenApiMsgs(data.messages);
}

function afterSearchApiList(data) {
	$.each($('#apiSrv option'), function(i, d) {
		if(i > 0) {
			$(this).remove();
		}
	});
	$.each(data, function(i, d) {
		openAPIListData[d.infId] = d;
		$('#apiSrv').append("<option value=\""+d.infId+"\">"+d.infNm+"</option>");
	});
	var form = $("#openapi-search-form");
    var id = form.find("input[name=infId]").val();
    $('#apiSrv').val(id);
}

function selectService(infId) {
    // 데이터를 조회하는 화면으로 이동한다.
    goSelect({
        url:"/portal/openapi/selectServicePage.do",
        form:"openapi-search-form",
        data:[{
            name:"infId",
            value:infId
        }, {
            name:"infSeq",
            value:"1"
        }]
    });
}

////////////////////////////////////////////////////////////////////////////////
// 이벤트 함수
////////////////////////////////////////////////////////////////////////////////