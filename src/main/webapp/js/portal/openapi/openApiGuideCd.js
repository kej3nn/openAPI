/*
 * @(#)openApiGuideCd.js 1.0 2018/02/09
 * 
 */

/**
 * 통계코드를 검색하는 스크립트이다.
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
    
    menuOn(4, 5);
    
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
            "<td class=\"number-block rowNum\"></td>"                                                               +
            "<td class=\"title\"><span class=\"statblNm\"></span>"                                                                         +
            	"<ul class=\"mobile-info\">"                                                                        +
            		"<li class=\"statblId\" ></li>"                                 								+
                "</ul>"                                                                                             + 
            "</td>"                                                                                                 +
            "<td class=\"summary statblId\"></td>"                                                                  +
            "<td class=\"code-search btn\">"                                             							+
            	"<a href=\"#\" class=\"btn-s02 btns-color08 btn-open-popup\">"										+
            	"<img src=\"" + com.wise.help.url("/images/hfportal/icon/icon_search03@2x.png") + "\" alt=\"조회버튼\" style=\"height: 9px\" />" +
            		"조회" 																							+
            	"</a>"                         																		+
            "</td>"                                                                      							+
        "</tr>",
    none:
        "<tr>"                                                                                                      +
            "<td colspan=\"5\">해당 자료가 없습니다.</td>"                                                          +
        "</tr>",
    data02:
        "<tr>"                                                                                                      +
            "<td class=\"itmNm\"></td>"                                                          					+
            "<td class=\"itmId\"></td>"                                                                             +
        "</tr>",     
	none02:
	    "<tr>"                                                                                                      +
	        "<td colspan=\"2\">해당 자료가 없습니다.</td>"                                                          +
	    "</tr>"     
};

////////////////////////////////////////////////////////////////////////////////
// 초기화 함수
////////////////////////////////////////////////////////////////////////////////
/**
 * 컴포넌트를 초기화한다.
 */
function initComp() {
	      
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
    $("#openapi-searchword-field").bind("keydown", function(event) {
        if (event.which == 13) {
            // 공공데이터 데이터셋 검색어를 변경한다.
        	searchCd($("#openapi-search-form [name=page]").val());
            return false;
        }
    });
    
    // 공공데이터 데이터셋 검색 버튼에 클릭 이벤트를 바인딩한다.
    $("#openapi-search-button").bind("click", function(event) {
        // 공공데이터 데이터셋 검색어를 변경한다.
    	searchCd($("#openapi-search-form [name=page]").val());
        return false;
    });
    
    // 공공데이터 데이터셋 검색 버튼에 키다운 이벤트를 바인딩한다.
    $("#openapi-search-button").bind("keydown", function(event) {
        if (event.which == 13) {
            // 공공데이터 데이터셋 검색어를 변경한다.
        	searchCd($("#openapi-search-form [name=page]").val());
            return false;
        }
    });
    
    // 레이어 닫기 버튼 이벤트를 바인딩한다.
    $(".mask, .btn-layerpopup-close").click(function() {
		$(".layerpopup-wrapper").hide();
		
		$(".mask").fadeOut(300, function() {
			$("body").removeClass('fixed-body');
		});
		$("#tab_B_1").addClass("on");
		$("#tab_B_2").removeClass("on");
		$("#tab_B_cont_1").fadeIn();
        $("#tab_B_cont_2").css("display", "none");

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
	//통계표 코드 검색 로드
	searchCd($("#openapi-search-form [name=page]").val());
}

////////////////////////////////////////////////////////////////////////////////
// 서비스 함수
////////////////////////////////////////////////////////////////////////////////
/**
 * 통계표 코드 검색
 * 
 */
function searchCd(page) {
    // 데이터를 검색한다.
	doSearch({
		url : "/portal/stat/easyStatMobileList.do",
		page : page ? page : "1",
		before : beforeSearchList,
		after : afterSearchList,
		pager : "stat-pager-sect",
		counter:{
            count:"stat-count-sect",
            pages:"stat-pages-sect"
        }
	});
}



/**
 * 통계코드 항목/분류 조회
 */
function loadCdSearchList(data) {
	$("#sId").val(data.statblId);
	doSearch({
		url : "/portal/openapi/selectOpenApiItmCd.do",
		before : beforeLoadCdSearchList,
		after : afterLoadCdSearchList
	});
}

////////////////////////////////////////////////////////////////////////////////
//전처리 함수
////////////////////////////////////////////////////////////////////////////////

/**
 * 통계표 코드 검색 전처리를 실행한다.
 */
function beforeSearchList(options) {
	var form = $("#openapi-search-form");
	if (com.wise.util.isBlank(options.page)) {
		form.find("[name=page]").val("1");
	} else {
		form.find("[name=page]").val(options.page);
	}
	
	var data = {
		searchVal : $("#openapi-searchword-field").val(),
		searchGubun : $("#searchGubun").val(),
		page : form.find("[name=page]").val(),
		multiGb : "MULTI"
	};
	return data;
}
/**
 * 통계코드 항목/분류 검색 전처리를 실행한다.
 */
function beforeLoadCdSearchList(option){
	var data = {
			statblId : $("#sId").val() //통계표 아이디 
		};
		return data;
		
}


////////////////////////////////////////////////////////////////////////////////
//후처리 함수
////////////////////////////////////////////////////////////////////////////////
/**
 * 통계코드 조회후 후처리를 실행한다.
 * 
 */
function afterLoadCdSearchList(data){
	$("body").addClass('fixed-body');
	
	$(".mask").fadeIn(300, function() {
		$(".layerpopup-wrapper").show();
    	$('#tab_B_1 > a').focus(); // 2018.04.05. 포커스 이동떄문에 넣어 둠.
	});
	
	$(".statblCd .statblNm").text("통계표명 : "+data[0].statblNm);
	$(".statblCd .statblId").text("통계표코드 : "+data[0].statblId);
	
	var table = $("#openapi_itm_cd_tb");
	var table02 = $("#openapi_itm_cls_tb");
	
    table.find("tr").each(function(index, element) {
        if (index > 0) {
            $(this).remove();
        }
    });
    
    table02.find("tr").each(function(index, element) {
        if (index > 0) {
            $(this).remove();
        }
    });
    
    for (var i = 0; i < data.length; i++) {
    	
        var row = $(templates.data02);
        
        switch (data[i].itmTag) { //분류코드
        case "항목":
        	 row.find(".itmNm").text(data[i].itmNm);
             row.find(".itmId").text(data[i].itmId); 
             table.append(row);
            break;
        case "분류":
        	row.find(".itmNm").text(data[i].itmNm);
            row.find(".itmId").text(data[i].itmId); 
            table02.append(row);
            $("#tab_B_2").css("display", "");
            break;
       
        }
    }
    
    if (data.length == 0) {
        var row = $(templates.none02);
        
        table.append(row);
        table02.append(row);
    }
    
    var rowsCount = $("#openapi_itm_cls_tb tbody tr").length;
    if(rowsCount == 0){
    	var row = $(templates.none02);
    	table02.append(row);
    	$("#tab_B_2").css("display", "none");
    	
    }
    
}

/**
 * 통계표 코드 조회후 후처리를 실행한다.
 * 
 */
function afterSearchList(data) {
var table = $("#openapi-data-table");

    table.find("tr").each(function(index, element) {
        if (index > 0) {
            $(this).remove();
        }
    });
    
    for (var i = 0; i < data.length; i++) {
        var row = $(templates.data);
        
        row.find(".statblNm").text(data[i].statblNm);
        row.find(".statblId").text(data[i].statblId); 
        row.find(".rowNum").text(getRowNumber($("#stat-count-sect").text(), "" + data[i].ROW_NUM));
        
        row.find("a").each(function(index, element) {
            // Q&A 게시판 내용 제목 링크에 클릭 이벤트를 바인딩한다.
            $(this).bind("click", {
            	statblId:data[i].statblId
            }, function(event) {
                // Q&A 게시판 내용을 조회한다.
            	loadCdSearchList(event.data);
                return false;
            });
            
            // Q&A 게시판 내용 제목 링크에 키다운 이벤트를 바인딩한다.
            $(this).bind("keydown", {
            	statblId:data[i].statblId
            }, function(event) {
                if (event.which == 13) {
                    // Q&A 게시판 내용을 조회한다.
                	loadCdSearchList(event.data);
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
//엑셀 다운
////////////////////////////////////////////////////////////////////////////////
function doExcelDown() {
	var firParam = "";
	
	var f = document.excelDownload;
	var action = com.wise.help.url("/portal/stat/easyStatApiExcel.do");
	f.target = "hide_frame";
	f.action = action;
	f.submit();
}