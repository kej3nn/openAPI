/*
 * @(#)lifeData.js 1.0 2015/06/15
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
});

////////////////////////////////////////////////////////////////////////////////
// 글로벌 변수
////////////////////////////////////////////////////////////////////////////////
/**
 * 템플릿
 */
var templates = {
    data:
        "<li id=\"lifeData1\">                                                     "+ //lifeData1,lifeData2,lifeData3......
		"<div class=\"dataList\">                                              "+
			"<p class=\"tit\">                                                       "+
				"<span>                                                               " +
					"<img   src=\"\" />" + //lifeData_ico_1_off,lifeData_ico_2_off.....   
				"</span>							                                     "+
				"<strong></strong>	                  		"+      //디비
			"</p>						                                                  "+
			"<ol>						                                                 "+
				"<li><a href=\"#\">					                  	        " +
						"<em>1</em>				                  		    " +    //디비
						"<span class=\"infNm\">상세내역</span>	                        " +    //디비
						"</a>						                                     " +
				"</li>						                                             "+
			"</ol>						                                                 "+
		"</div>						                                                     "+
	"</li>						                                                         ",
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
        before:beforeSearchDataset,
        after:afterSearchDataset
    });
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
    var table = $("#lifeDataList");
    
    
    for (var i = 1; i <=7; i++) {
        var row = $(templates.data);
        switch(i){
        case 1:
            row.find("strong").text("임신 · 출산");
            $("li").attr("id", "lifeData1");
            row.find("img").attr("src", com.wise.help.url("/img/ggportal/desktop/lifedata/lifeData_ico_1_off.png")).attr("alt", "임신 · 출산 아이콘");
        	break;
        case 2:
        	row.find("strong").text("영유아");
        	row.find("li").attr("id", "lifeData2");
        	row.find("img").attr("src", com.wise.help.url("/img/ggportal/desktop/lifedata/lifeData_ico_2_off.png")).attr("alt", "영유아 아이콘");
        	break;
        case 3:
        	row.find("strong").text("아동");
        	row.find("li").attr("id", "lifeData3");
        	row.find("img").attr("src", com.wise.help.url("/img/ggportal/desktop/lifedata/lifeData_ico_3_off.png")).attr("alt", "아동 아이콘");
        	break;
        case 4:
        	row.find("strong").text("청소년");
        	row.find("li").attr("id", "lifeData4");
        	row.find("img").attr("src", com.wise.help.url("/img/ggportal/desktop/lifedata/lifeData_ico_4_off.png")).attr("alt", "청소년 아이콘");
        	break;
        case 5:
        	row.find("strong").text("청년");
        	row.find("li").attr("id", "lifeData5");
        	row.find("img").attr("src", com.wise.help.url("/img/ggportal/desktop/lifedata/lifeData_ico_5_off.png")).attr("alt", "청년 아이콘");
        	break;
        case 6:
        	row.find("strong").text("중장년");
        	row.find("li").attr("id", "lifeData6");
        	row.find("img").attr("src", com.wise.help.url("/img/ggportal/desktop/lifedata/lifeData_ico_6_off.png")).attr("alt", "중장년 아이콘");
        	break;
        case 7:
        	row.find("strong").text("노년 · 사망");
        	row.find("li").attr("id", "lifeData7");
        	row.find("img").attr("src", com.wise.help.url("/img/ggportal/desktop/lifedata/lifeData_ico_7_off.png")).attr("alt", "노년 · 사망 아이콘");
        	break;
        }
        row.find(".infNm").text(data[i].infNm);
        table.append(row);
    }
    
    if (data.length == 0) {
        var row = $(templates.none);
        
        table.append(row);
    }
}