/*
 * @(#)searchQna.js 1.0 2015/06/15
 * 
 * COPYRIGHT (C) 2013 WISEITECH CO., LTD. ALL RIGHTS RESERVED.
 */

/**
 * Q&A 게시판 내용을 검색하는 스크립트이다.
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
        "<tr>"                                                                               +
            "<td><span class=\"mq_tablet rowNum\"></span></td>"                              +
            "<td class=\"area_tit\">"                                                        +
                "<a href=\"#\" class=\"link tit ellipsis w_400 bbsTit\"></a>"                +
                "<strong class=\"btn_detail mq_mobile\"><a href=\"#\">상세보기</a></strong>" +
            "</td>"                                                                          +
            "<td><span class=\"writer userNm\"></span></td>"                                 +
            "<td><span class=\"date userDttm\"></span></td>"                                 +
            "<td class=\"txt\"><span class=\"txt_D ansStateNm\"></span></td>"                +
            "<td><span class=\"mq_tablet viewCnt\"></span></td>"                             +
        "</tr>",
    none:
        "<tr>"                                                              +
            "<td colspan=\"6\" class=\"noData\">해당 자료가 없습니다.</td>" +
        "</tr>"
};

////////////////////////////////////////////////////////////////////////////////
// 초기화 함수
////////////////////////////////////////////////////////////////////////////////
/**
 * 컴포넌트를 초기화한다.
 */
function initComp() {
    var code = $("#qna-search-form [name=listSubCd]").val();
    
    $(".qna-section-tab[href='#" + code + "']").addClass("on");
    
    $("#qna-searchtype-combo").val($("#qna-search-form [name=searchType]").val());
    $("#qna-searchword-field").val($("#qna-search-form [name=searchWord]").val());
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
    $(".qna-insert-button").each(function(index, element) {
        // Q&A 게시판 내용 작성 버튼에 클릭 이벤트를 바인딩한다.
        $(this).bind("click", function(event) {
            // Q&A 게시판 내용을 등록한다.
            insertQna();
            return false;
        });
        
        // Q&A 게시판 내용 작성 버튼에 키다운 이벤트를 바인딩한다.
        $(this).bind("keydown", function(event) {
            if (event.which == 13) {
                // Q&A 게시판 내용을 등록한다.
                insertQna();
                return false;
            }
        });
    });
    
    // $(".qna-section-tab").each(function(index, element) {
    //     // Q&A 게시판 내용 섹션 탭에 클릭 이벤트를 바인딩한다.
    //     $(this).bind("click", function(event) {
    //         // Q&A 게시판 내용 섹션을 변경한다.
    //         changeQnaSection(this);
    //         return false;
    //     });
    //     
    //     // Q&A 게시판 내용 섹션 탭에 키다운 이벤트를 바인딩한다.
    //     $(this).bind("keydown", function(event) {
    //         if (event.which == 13) {
    //             // Q&A 게시판 내용 섹션을 변경한다.
    //             changeQnaSection(this);
    //             return false;
    //         }
    //     });
    // });
    
    // Q&A 게시판 검색어 필드에 키다운 이벤트를 바인딩한다.
    $("#qna-searchword-field").bind("keydown", function(event) {
        if (event.which == 13) {
            // Q&A 게시판 검색어를 변경한다.
            changeQnaSearchWord();
            return false;
        }
    });
    
    // Q&A 게시판 검색 버튼에 클릭 이벤트를 바인딩한다.
    $("#qna-search-button").bind("click", function(event) {
        // Q&A 게시판 검색어를 변경한다.
        changeQnaSearchWord();
        return false;
    });
    
    // Q&A 게시판 검색 버튼에 키다운 이벤트를 바인딩한다.
    $("#qna-search-button").bind("keydown", function(event) {
        if (event.which == 13) {
            // Q&A 게시판 검색어를 변경한다.
            changeQnaSearchWord();
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
    // Q&A 게시판 내용을 검색한다.
    searchQna($("#qna-search-form [name=page]").val());
}

////////////////////////////////////////////////////////////////////////////////
// 서비스 함수
////////////////////////////////////////////////////////////////////////////////
/**
 * Q&A 게시판 내용을 검색한다.
 * 
 * @param page {String} 페이지 번호
 */
function searchQna(page) {
    // 데이터를 검색한다.
    doSearch({
        url:resolveUrl("/searchBulletin.do"),
        page:page ? page : "1",
        before:beforeSearchQna,
        after:afterSearchQna,
        pager:"qna-pager-sect",
        counter:{
            count:"qna-count-sect",
            pages:"qna-pages-sect"
        }
    });
}

/**
 * Q&A 게시판 내용을 조회한다.
 * 
 * @param data {Object} 데이터
 */
function selectQna(data) {
    if (!verifyWriter(data.lockTag, "qna-search-form", selectQna, data)) {
        return;
    }
    
    // 데이터를 조회하는 화면으로 이동한다.
    goSelect({
        url:resolveUrl("/selectBulletinPage.do"),
        form:"qna-search-form",
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
 * Q&A 게시판 내용을 등록한다.
 */
function insertQna() {
    // 데이터를 등록하는 화면으로 이동한다.
    goInsert({
        url:resolveUrl("/insertBulletinPage.do"),
        form:"qna-search-form",
        data:[{
            name:"seq",
            value:""
        }]
    });
}

/**
 * Q&A 게시판 내용 섹션을 변경한다.
 * 
 * @param tab {Element} 탭
 */
function changeQnaSection(tab) {
    if (!$(tab).hasClass("on")) {
        $(".qna-section-tab.on").removeClass("on");
        
        $(tab).addClass("on");
    }
    
    var code = $(tab).attr("href").substring(1);
    
    $("#qna-search-form [name=listSubCd]").val(code);
    
    // Q&A 게시판 내용을 검색한다.
    searchQna();
}

/**
 * Q&A 게시판 검색어를 변경한다.
 */
function changeQnaSearchWord() {
    $("#qna-search-form [name=searchType]").val($("#qna-searchtype-combo").val());
    $("#qna-search-form [name=searchWord]").val($("#qna-searchword-field").val());
    var value = $("#qna-searchword-field").val();
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
    	 $("#qna-searchword-field").val("");
         return false;
     }
    
    // Q&A 게시판 내용을 검색한다.
    searchQna();
}

/**
 * URL을 반환한다.
 * 
 * @param url {String} URL
 */
function resolveUrl(url) {
    var matches = window.location.href.match(/\/portal\/[^\/]+\//);
    
    return matches[0] + $("#qna-search-form [name=bbsCd]").val().toLowerCase() + url;
}

////////////////////////////////////////////////////////////////////////////////
// 전처리 함수
////////////////////////////////////////////////////////////////////////////////
/**
 *  Q&A 게시판 내용 검색 전처리를 실행한다.
 * 
 * @param options {Object} 옵션
 * @returns {Object} 데이터
 */
function beforeSearchQna(options) {
    var data = {
        // Nothing do do.
    };
    
    var form = $("#qna-search-form");
    
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
 * Q&A 게시판 내용 검색 후처리를 실행한다.
 * 
 * @param data {Array} 데이터
 */
function afterSearchQna(data) {
    var table = $("#qna-data-table");
    
    table.find("tr").each(function(index, element) {
        if (index > 0) {
            $(this).remove();
        }
    });
    
    for (var i = 0; i < data.length; i++) {
        var row = $(templates.data);
        
        if (data[i].noticeYn == "Y") {
            row.addClass("notice");
            
            row.find(".rowNum").parent("td").html("<span class=\"txt_C\">공지</span>");
        }
        else {
            row.find(".rowNum").text(getRowNumber($("#qna-count-sect").text(), "" + data[i].rowNum));
        }
        
        row.find(".bbsTit").text(data[i].bbsTit);
        
        if (data[i].secretYn == "Y") {
            row.find(".bbsTit").prepend("<img src=\"" + com.wise.help.url("/img/ggportal/desktop/common/icon_lock.png") + "\" alt=\"\" title=\"비밀글 아이콘\" /> ");
        }
        
        // if (data[i].newYn == "Y") {
        //     row.find(".bbsTit").prepend("<span class=\"txt_new\"></span> ");
        // }
        
        // if (data[i].viewCnt >= data[i].hlCnt) {
        //     row.find(".bbsTit").addClass("best");
        // }
        
        row.find(".userNm").text(maskingNm(data[i].userNm));
        row.find(".userDttm").text(data[i].userDttm);
        
        switch (data[i].ansState) {
            case "RW":
                row.find(".ansStateNm").addClass("txt_D_inquiry");
                break;
            case "AW":
                row.find(".ansStateNm").addClass("txt_D_standby");
                break;
            case "AK":
                row.find(".ansStateNm").addClass("txt_D_answer");
                break;
            case "AC":
                row.find(".ansStateNm").addClass("txt_D_impossibility");
                break;
        }
        
        row.find(".ansStateNm").text(data[i].ansStateNm);
        row.find(".viewCnt").text(com.wise.util.toCurrency(data[i].viewCnt.toString()));
        
        row.find("a").each(function(index, element) {
            // Q&A 게시판 내용 제목 링크에 클릭 이벤트를 바인딩한다.
            $(this).bind("click", {
                bbsCd:data[i].bbsCd,
                seq:data[i].seq,
                noticeYn:data[i].noticeYn,
                lockTag:data[i].lockTag
            }, function(event) {
                // Q&A 게시판 내용을 조회한다.
                selectQna(event.data);
                return false;
            });
            
            // Q&A 게시판 내용 제목 링크에 키다운 이벤트를 바인딩한다.
            $(this).bind("keydown", {
                bbsCd:data[i].bbsCd,
                seq:data[i].seq,
                noticeYn:data[i].noticeYn,
                lockTag:data[i].lockTag
            }, function(event) {
                if (event.which == 13) {
                    // Q&A 게시판 내용을 조회한다.
                    selectQna(event.data);
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

function maskingNm(strName){
	if (strName.length > 2) {
	    var originName = strName.split('');
	    originName.forEach(function(name, i) {
	      if (i === 0) return;
	      originName[i] = '*';
	    });
	    var joinName = originName.join();
	    return joinName.replace(/,/g, '');
	  } else {
	    var pattern = /.$/; // 정규식
	    return strName.replace(pattern, '*');
	  }
}

////////////////////////////////////////////////////////////////////////////////
// 이벤트 함수
////////////////////////////////////////////////////////////////////////////////