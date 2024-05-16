/*
 * @(#)searchDataset.js 1.0 2015/06/15
 * 
 * COPYRIGHT (C) 2013 WISEITECH CO., LTD. ALL RIGHTS RESERVED.
 */

/**
 * 공공데이터 데이터셋 전체목록을 검색하는 스크립트이다.
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
        "<tr>"                                                                                                             +
            "<td class=\"area_summary\">"                                                                                  +
                "<a href=\"#\" class=\"link dataset-select-link\">"                                                        +
                    "<span class=\"thumbnail\">"                                                                         +
                        "<img src=\"\" alt=\"\" class=\"thumbnail_dataSet metaImagFileNm\" />"                             +
                    "</span>"                                                                                            +
                    "<span class=\"summary\">"                                                                             +
                        "<strong class=\"tit ellipsis W300 infNm\"></strong>"                                              +
                        "<span class=\"cont infExp\"></span>"                                                              +
                    "</span>"                                                                                              +
                "</a>"                                                                                                     +
                "<strong class=\"btn_detail mq_mobile\"><a href=\"#\" class=\"dataset-select-link\">상세보기</a></strong>" +
            "</td>"                                                                                                        +
            "<td>"                                                                                                         +
                "<span class=\"area_txt_A\">"                                                                              +
                "</span>"                                                                                                  +
            "</td>"                                                                                                        +
            "<td><strong class=\"mq_tablet viewCnt\"></strong></td>"                                                       +
            "<td><span class=\"date regDttm\"></span><br><span class=\"date updDttm\"></span></td>"                                                                +
            "<td><span class=\"sort dataset-category-sect\"><strong class=\"topCateNm\"></strong></span></td>"             +
        "</tr>",
    none:
        "<tr>"                                                              +
            "<td colspan=\"5\" class=\"noData\">해당 자료가 없습니다.</td>" +
        "</tr>"
};

////////////////////////////////////////////////////////////////////////////////
// 초기화 함수
////////////////////////////////////////////////////////////////////////////////
/**
 * 컴포넌트를 초기화한다.
 */
function initComp() {
    // 공공데이터 데이터셋 카테고리 버튼을 초기화한다.
    $("#dataset-search-form :hidden[name=cateId]").each(function(index, element) {
        $(".dataset-category-button[href='#" + $(this).val() + "']").each(function(index, element) {
            $(this).addClass("on");
            
            if (index == 0) {
                // 공공데이터 데이터셋 키워드를 추가한다.
                addDatasetKeyword("cateId", $(this).attr("href").substring(1), $(this).text());
            }
        });
    });
    
    // 공공데이터 데이터셋 카테고리 콤보박스를 초기화한다.
    $("#dataset-search-form :hidden[name=cateId]").each(function(index, element) {
        $("#dataset-category-combo").val($(this).val());
    });
    
    // 공공데이터 데이터셋 서비스 버튼을 초기화한다.
    $("#dataset-search-form :hidden[name=srvCd]").each(function(index, element) {
        $(".dataset-service-button[href='#" + $(this).val() + "']").addClass("on");
    });
    
    // 공공데이터 데이터셋 페이지 크기 콤보박스를 초기화한다.
    $("#dataset-rows-combo").val($("#dataset-search-form :hidden[name=rows]").val());
    
    // 공공데이터 데이터셋 검색어 필드를 초기화한다.
    $("#dataset-searchword-field").val($("#dataset-search-form :hidden[name=searchWord]:last").val());
    
    if( $("#dataset-search-form").find("input[name=order]").val() == 1){$(".mq_tablet").find("li").eq(1).addClass("on");}
    if( $("#dataset-search-form").find("input[name=order]").val() == 2){$(".mq_tablet").find("li").eq(2).addClass("on");}
    if( $("#dataset-search-form").find("input[name=order]").val() == 3){$(".mq_tablet").find("li").eq(3).addClass("on");}
}

/**
 * 마스크를 바인딩한다.
 */
function bindMask() {
	//var value = $("#dataset-searchword-field").val();
	//value = decodeURIComponent(encodeURIComponent(value));
	//alert(value);
	//$("#dataset-searchword-field").val("공연");
    
}

/**
 * 이벤트를 바인딩한다.
 */
function bindEvent() {
    $(".dataset-category-button").each(function(index, element) {
        // 공공데이터 데이터셋 카테고리 버튼에 클릭 이벤트를 바인딩한다.
        $(this).bind("click", function(event) {
            // 공공데이터 데이터셋 카테고리를 변경한다.
            changeDatasetCategory($(this).attr("href").substring(1));
            return false;
        });
        
        // 공공데이터 데이터셋 카테고리 버튼에 키다운 이벤트를 바인딩한다.
        $(this).bind("keydown", function(event) {
            if (event.which == 13) {
                // 공공데이터 데이터셋 카테고리를 변경한다.
                changeDatasetCategory($(this).attr("href").substring(1));
                return false;
            }
            
        });
    });
    
    
    
    // 공공데이터 데이터셋 카테고리 콤보박스에 변경 이벤트를 바인딩한다.
    $("#dataset-category-combo").bind("change", function(event) {
        // 공공데이터 데이터셋 카테고리를 변경한다.
        changeDatasetCategory($(this).val());
    });
    
    $(".dataset-service-button").each(function(index, element) {
        // 공공데이터 데이터셋 서비스 버튼에 클릭 이벤트를 바인딩한다.
        $(this).bind("click", function(event) {
            // 공공데이터 데이터셋 서비스를 변경한다.
            changeDatasetService($(this).attr("href").substring(1));
            return false;
        });
        
        // 공공데이터 데이터셋 서비스 버튼에 키다운 이벤트를 바인딩한다.
        $(this).bind("keydown", function(event) {
            if (event.which == 13) {
                // 공공데이터 데이터셋 서비스를 변경한다.
                changeDatasetService($(this).attr("href").substring(1));
                return false;
            }
        });
    });
        
    // 공공데이터 데이터셋 페이지 크기 콤보박스에 변경 이벤트를 바인딩한다.
    $("#dataset-rows-combo").bind("change", function(event) {
        // 공공데이터 데이터셋 페이지 크기를 변경한다.
        changeDatasetRows();
    });
    
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
        url:"/portal/data/dataset/searchDataset.do",
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
 * 공공데이터 데이터셋 카테고리 클래스를 반환한다.
 * 
 * @param code {String} 코드
 * @returns {String} 경로
 */
function getCategoryClass(code) {
    var clazz = "";
    
    switch (code) {
        case "GG01":
            clazz = "sort_1";
            break;
        case "GG05":
            clazz = "sort_2";
            break;
        case "GG09":
            clazz = "sort_3";
            break;
        case "GG13":
            clazz = "sort_4";
            break;
        case "GG16":
            clazz = "sort_5";
            break;
        case "GG20":
            clazz = "sort_6";
            break;
        case "GG23":
            clazz = "sort_7";
            break;
        case "GG26":
            clazz = "sort_8";
            break;
        case "GG29":
            clazz = "sort_9";
            break;
    }
    
    return clazz;
}

/**
 * 공공데이터 데이터셋 카테고리를 변경한다.
 * 
 * @param code {String} 코드
 */
function changeDatasetCategory(code) {
    var button = $(".dataset-category-button[href='#" + code + "']");
    var combo  = $("#dataset-category-combo");
    
    if (code) {
        if (button.hasClass("on")) {
            button.removeClass("on");
            
            if (combo.val()) {
                combo.val("");
            }
            
            $("#dataset-keyword-sect").empty();
        }
        else {
            $(".dataset-category-button.on, .dataset-hashtag-link.on, .dataset-organization-link.on, .dataset-service-button.on").each(function(index, element) {
                $(this).removeClass("on");
            });
            
            button.addClass("on");
            
            if (combo.val() != code) {
                combo.val(code);
            }
        }
    }
    else {
        $(".dataset-category-button.on, .dataset-hashtag-link.on, .dataset-organization-link.on, .dataset-service-button.on").each(function(index, element) {
            $(this).removeClass("on");
        });
        
        if (combo.val()) {
            combo.val("");
        }
        
        $("#dataset-keyword-sect").empty();
    }
     
    var form = $("#dataset-search-form");
    
    form.find("[name=cateId], [name=infTag], [name=orgCd], [name=srvCd], [name=searchWord]").each(function(index, element) {
        $(this).remove();
    });
    
    var list = $("#dataset-keyword-list");
    
    list.find(".cateId").each(function(index, element) {
        $(this).remove();
    });
    
    $(".dataset-category-button.on").each(function(index, element) {
        var hidden = $("<input type=\"hidden\" name=\"cateId\" />");
        
        hidden.val($(this).attr("href").substring(1));
        
        form.append(hidden);
        
        // 공공데이터 데이터셋 키워드를 추가한다.
        addDatasetKeyword("cateId", $(this).attr("href").substring(1), $(this).text());
    });
    
    $("#dataset-searchword-field").val("");
    
    // 공공데이터 데이터셋 전체목록을 검색한다.
    searchDataset();
}

/**
 * 공공데이터 데이터셋 서비스를 변경한다.
 * 
 * @param code {String} 코드
 */
function changeDatasetService(code) {
    var button = $(".dataset-service-button[href='#" + code + "']");
    
    if (button.hasClass("on")) {
        button.removeClass("on");
    }
    else {
        button.addClass("on");
    }
    
    var form = $("#dataset-search-form");
    
    form.find("[name=srvCd], [name=searchWord]").each(function(index, element) {
        $(this).remove();
    });
    
    $(".dataset-service-button.on").each(function(index, element) {
        var hidden = $("<input type=\"hidden\" name=\"srvCd\" />");
        
        hidden.val($(this).attr("href").substring(1));
        
        form.append(hidden);
    });
    
    $("#dataset-searchword-field").val("");
    
    // 공공데이터 데이터셋 전체목록을 검색한다.
    searchDataset();
}

/**
 * 공공데이터 데이터셋 페이지 크기를 변경한다.
 */
function changeDatasetRows() {
    var form = $("#dataset-search-form");
    
    form.find("[name=rows]").val($("#dataset-rows-combo").val());
    
    // 공공데이터 데이터셋 전체목록을 검색한다.
    searchDataset();
}

/**
 * 공공데이터 데이터셋 검색어를 변경한다.
 */
function changeDatasetSearchWord() {
    var value = $("#dataset-searchword-field").val();
    
    
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
        return false;
     }
     
     //연속해서 검색시 오류발생에따른 수정...
     if(value != $("input[name=searchWord]").val()){
    	 var form = $("#dataset-search-form");
    	 form.find("[name=searchWord]").each(function(index, element) {
 			$(this).remove();
 		});
     }
     
    if (!com.wise.util.isBlank(value)) {
        var form = $("#dataset-search-form");
        
        if (form.find("[name=searchWord][value='" + value.replace(/\'/g, "\\'") + "']").length == 0) {
            var hidden = $("<input type=\"hidden\" name=\"searchWord\" />");
            
            hidden.attr("value", value);
            
            form.append(hidden);
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
            case "infTag":
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
        if (data[i].metaImagFileNm || data[i].cateSaveFileNm) {
            var url = com.wise.help.url("/portal/data/dataset/selectThumbnail.do");
            
            // url += "?infId=" + data[i].infId;
            url += "?seq="            + data[i].seq;
            url += "&metaImagFileNm=" + (data[i].metaImagFileNm ? data[i].metaImagFileNm : "");
            url += "&cateSaveFileNm=" + (data[i].cateSaveFileNm ? data[i].cateSaveFileNm : "");

            row.find(".metaImagFileNm").attr("src", url);
           // row.find(".metaImagFileNm").attr("alt", data[i].infNm);
        }
        
        row.find(".infNm").text(data[i].infNm);
        row.find(".infExp").text(data[i].infExp ? com.wise.util.ellipsis(data[i].infExp, 56) : "");
        
        if (data[i].scolInfSeq) {
            if (row.find(".txt_A").length > 0) {
                row.find(".area_txt_A").append(" ");
            }
            row.find(".area_txt_A").append("<a href=\"#\" class=\"dataset-sheet-button\"><span class=\"txt_A txt_A_1\">SHEET</span></a>");
        }
        if (data[i].ccolInfSeq) {
            if (row.find(".txt_A").length > 0) {
                row.find(".area_txt_A").append(" ");
            }
            row.find(".area_txt_A").append("<a href=\"#\" class=\"dataset-chart-button\"><span class=\"txt_A txt_A_2\">CHART</span></a>");
        }
        if (data[i].mcolInfSeq) {
            if (row.find(".txt_A").length > 0) {
                row.find(".area_txt_A").append(" ");
            }
            row.find(".area_txt_A").append("<a href=\"#\" class=\"dataset-map-button\"><span class=\"txt_A txt_A_3\">MAP</span></a>");
        }
        if (data[i].fileInfSeq) {
            if (row.find(".txt_A").length > 0) {
                row.find(".area_txt_A").append(" ");
            }
            row.find(".area_txt_A").append("<a href=\"#\" class=\"dataset-file-button\"><span class=\"txt_A txt_A_4\">FILE</span></a>");
        }
        if (data[i].acolInfSeq) {
            if (row.find(".txt_A").length > 0) {
                row.find(".area_txt_A").append(" ");
            }
            row.find(".area_txt_A").append("<a href=\"#\" class=\"dataset-openapi-button\"><span class=\"txt_A txt_A_5\">API</span></a>");
        }
        if (data[i].linkInfSeq) {
            if (row.find(".txt_A").length > 0) {
                row.find(".area_txt_A").append(" ");
            }
            row.find(".area_txt_A").append("<a href=\"#\" class=\"dataset-link-button\"><span class=\"txt_A txt_A_6\">LINK</span></a>");
        }
        
        row.find(".viewCnt").text(com.wise.util.toCurrency(data[i].viewCnt.toString()));
        row.find(".regDttm").text(data[i].regDttm);
        //추가
        row.find(".updDttm").text(data[i].updDttm);
        //추가끝
        row.find(".topCateNm").text(data[i].topCateNm);
        //row.find(".dataset-category-sect").eq(0).addClass(getCategoryClass(data[i].topCateId));
        
        if (data[i].topCateId2) {
        	row.find("td").eq(4).append("<span class=\"sort dataset-category-sect\"><strong class=\"topCateNm2\"></strong></span>")
        	row.find(".topCateNm2").text(data[i].topCateNm2);
            //row.find(".dataset-category-sect").eq(1).addClass(getCategoryClass(data[i].topCateId2));
        }
        
        
        
        
        row.find(".dataset-select-link").each(function(index, element) {
            // 서비스 링크에 클릭 이벤트를 바인딩한다.
            $(this).bind("click", {
                infId:data[i].infId,
                infSeq:data[i].infSeq
                //currentPage : $(this).val()
               
            }, function(event) {
                // 공공데이터 서비스를 조회한다.
            	//currentPage = $(this).val();
            	//document.location.hash = "#" + currentPage;
                selectService(event.data);
                return false;
            });
            
            // 서비스 링크에 키다운 이벤트를 바인딩한다.
            $(this).bind("keydown", {
                infId:data[i].infId,
                infSeq:data[i].infSeq
            }, function(event) {
                if (event.which == 13) {
                    // 공공데이터 서비스를 조회한다.
                	//currentPage = $(this).val();
                	//document.location.hash = "#" + currentPage;
                    selectService(event.data);
                    return false;
                }
            });
        });
        
        
        
        
        
//        row.find(".dataset-select-link").bind("click", function(e) {
//            document.location.hash = '#' + currentPage;
//        });
        
        row.find(".dataset-sheet-button").each(function(index, element) {
            // 시트 버튼에 클릭 이벤트를 바인딩한다.
            $(this).bind("click", {
                infId:data[i].infId,
                infSeq:data[i].scolInfSeq
            }, function(event) {
                // 공공데이터 서비스를 조회한다.
                selectService(event.data);
                return false;
            });
            
            // 시트 버튼에 키다운 이벤트를 바인딩한다.
            $(this).bind("keydown", {
                infId:data[i].infId,
                infSeq:data[i].scolInfSeq
            }, function(event) {
                if (event.which == 13) {
                    // 공공데이터 서비스를 조회한다.
                    selectService(event.data);
                    return false;
                }
            });
        });
        
        row.find(".dataset-chart-button").each(function(index, element) {
            // 차트 버튼에 클릭 이벤트를 바인딩한다.
            $(this).bind("click", {
                infId:data[i].infId,
                infSeq:data[i].ccolInfSeq
            }, function(event) {
                // 공공데이터 서비스를 조회한다.
                selectService(event.data);
                return false;
            });
            
            // 차트 버튼에 키다운 이벤트를 바인딩한다.
            $(this).bind("keydown", {
                infId:data[i].infId,
                infSeq:data[i].ccolInfSeq
            }, function(event) {
                if (event.which == 13) {
                    // 공공데이터 서비스를 조회한다.
                    selectService(event.data);
                    return false;
                }
            });
        });
        
        row.find(".dataset-map-button").each(function(index, element) {
            // 맵 버튼에 클릭 이벤트를 바인딩한다.
            $(this).bind("click", {
                infId:data[i].infId,
                infSeq:data[i].mcolInfSeq
            }, function(event) {
                // 공공데이터 서비스를 조회한다.
                selectService(event.data);
                return false;
            });
            
            // 맵 버튼에 키다운 이벤트를 바인딩한다.
            $(this).bind("keydown", {
                infId:data[i].infId,
                infSeq:data[i].mcolInfSeq
            }, function(event) {
                if (event.which == 13) {
                    // 공공데이터 서비스를 조회한다.
                    selectService(event.data);
                    return false;
                }
            });
        });
        
        row.find(".dataset-file-button").each(function(index, element) {
            // 파일 버튼에 클릭 이벤트를 바인딩한다.
            $(this).bind("click", {
                infId:data[i].infId,
                infSeq:data[i].fileInfSeq
            }, function(event) {
                // 공공데이터 서비스를 조회한다.
                selectService(event.data);
                return false;
            });
            
            // 파일 버튼에 키다운 이벤트를 바인딩한다.
            $(this).bind("keydown", {
                infId:data[i].infId,
                infSeq:data[i].fileInfSeq
            }, function(event) {
                if (event.which == 13) {
                    // 공공데이터 서비스를 조회한다.
                    selectService(event.data);
                    return false;
                }
            });
        });
        
        row.find(".dataset-openapi-button").each(function(index, element) {
            // 오픈API 버튼에 클릭 이벤트를 바인딩한다.
            $(this).bind("click", {
                infId:data[i].infId,
                infSeq:data[i].acolInfSeq
            }, function(event) {
                // 공공데이터 서비스를 조회한다.
                selectService(event.data);
                return false;
            });
            
            // 오픈API 버튼에 키다운 이벤트를 바인딩한다.
            $(this).bind("keydown", {
                infId:data[i].infId,
                infSeq:data[i].acolInfSeq
            }, function(event) {
                if (event.which == 13) {
                    // 공공데이터 서비스를 조회한다.
                    selectService(event.data);
                    return false;
                }
            });
        });
        
        row.find(".dataset-link-button").each(function(index, element) {
            // 링크 버튼에 클릭 이벤트를 바인딩한다.
            $(this).bind("click", {
                infId:data[i].infId,
                infSeq:data[i].linkInfSeq
            }, function(event) {
                // 공공데이터 서비스를 조회한다.
                selectService(event.data);
                return false;
            });
            
            // 링크 버튼에 키다운 이벤트를 바인딩한다.
            $(this).bind("keydown", {
                infId:data[i].infId,
                infSeq:data[i].linkInfSeq
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