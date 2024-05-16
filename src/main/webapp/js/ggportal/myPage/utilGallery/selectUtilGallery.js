/*
 * 
 * COPYRIGHT (C) 2013 WISEITECH CO., LTD. ALL RIGHTS RESERVED.
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
    link:
        "<dt class=\"ty_B\">URL</dt>"                                                          +
        "<dd><a href=\"#\" class=\"link\" target=\"_blank\" title=\"새창으로 이동\"></a></dd>",
    data:
    	"<li class=\"\"><a href=\"#\" class=\"link\" target=\"_blank\" title=\"새창으로 이동\"></a></li>",
    none:
    	"<li class=\"\">"	+
    	"해당 자료가 없습니다."   +
        "</li>"
};
////////////////////////////////////////////////////////////////////////////////
// 초기화 함수
////////////////////////////////////////////////////////////////////////////////
/**
 * 컴포넌트를 초기화한다.
 */
function initComp() {
    // Nothing to do.
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
    // 갤러리 게시판 내용 조회 폼에 제출 이벤트를 바인딩한다.
    $("#gallery-select-form").bind("submit", function(event) {
        return false;
    });
    
    $(".gallery-grade-option").each(function(index, element) {
        var image = $(this).find("img");
        
        // 갤러리 게시판 내용 평가점수 옵션에 클릭 이벤트를 바인딩한다.
        $(this).bind("click", {
            src:image.attr("src"),
            alt:image.attr("alt")
        }, function(event) {
            // 갤러리 게시판 내용 평가점수를 변경한다.
            changeAppraisal(event.data);
            return false;
        });
        
        // 갤러리 게시판 내용 평가점수 옵션에 키다운 이벤트를 바인딩한다.
        $(this).bind("keydown", {
            src:image.attr("src"),
            alt:image.attr("alt")
        }, function(event) {
            if (event.which == 13) {
                // 갤러리 게시판 내용 평가점수를 변경한다.
                changeAppraisal(event.data);
                return false;
            }
        });
    });
    
    // 갤러리 게시판 내용 평가점수 등록 버튼에 클릭 이벤트를 바인딩한다.
    $(".gallery-grade-button").bind("click", function(event) {
        // 갤러리 게시판 내용 평가점수를 등록한다.
        insertAppraisal();
        return false;
    });
    
    // 갤러리 게시판 내용 평가점수 등록 버튼에 키다운 이벤트를 바인딩한다.
    $(".gallery-grade-button").bind("keydown", function(event) {
        if (event.which == 13) {
            // 갤러리 게시판 내용 평가점수를 등록한다.
            insertAppraisal();
            return false;
        }
    });
    
    // 갤러리 게시판 내용 목록 버튼에 클릭 이벤트를 바인딩한다.
    $("#gallery-search-button").bind("click", function(event) {
        // 갤러리 게시판 내용을 검색한다.
        searchGallery($("#gallery-search-form [name=page]").val());
        return false;
    });
    
    // 갤러리 게시판 내용 목록 버튼에 키다운 이벤트를 바인딩한다.
    $("#gallery-search-button").bind("keydown", function(event) {
        if (event.which == 13) {
            // 갤러리 게시판 내용을 검색한다.
            searchGallery($("#gallery-search-form [name=page]").val());
            return false;
        }
    });
    

    // 갤러리 게시판 내용 수정 버튼에 클릭 이벤트를 바인딩한다.
    $("#gallery-update-button").bind("click", function(event) {
        // 갤러리 게시판 내용을 수정한다.
        updateGallery();
        return false;
    });
    
    // 갤러리 게시판 내용 수정 버튼에 키다운 이벤트를 바인딩한다.
    $("#gallery-update-button").bind("keydown", function(event) {
        if (event.which == 13) {
            // 갤러리 게시판 내용을 수정한다.
            updateGallery();
            return false;
        }
    });
    
    // 갤러리 게시판 내용 삭제 버튼에 클릭 이벤트를 바인딩한다.
    $("#gallery-delete-button").bind("click", function(event) {
        // 갤러리 게시판 내용을 삭제한다.
        deleteGallery();
        return false;
    });
    
    // 갤러리 게시판 내용 삭제 버튼에 키다운 이벤트를 바인딩한다.
    $("#gallery-delete-button").bind("keydown", function(event) {
        if (event.which == 13) {
            // 갤러리 게시판 내용을 삭제한다.
            deleteGallery();
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
    // 갤러리 게시판 내용을 조회한다.
    selectGallery();
}

////////////////////////////////////////////////////////////////////////////////
// 서비스 함수
////////////////////////////////////////////////////////////////////////////////
/**
 * 갤러리 게시판 내용을 조회한다.
 */
function selectGallery() {
    // 데이터를 조회한다.
    doSelect({
        url:resolveUrl("/selectBulletin.do"),
        before:beforeSelectGallery,
        after:afterSelectGallery
    });
}

/**
 * 갤러리 게시판 내용을 검색한다.
 *
 * @param page {String} 페이지 번호
 */
function searchGallery(page) {
    // 데이터를 검색하는 화면으로 이동한다.
    goSearch({
        url:"/portal/myPage/utilGalleryPage.do",
        form:"gallery-search-form",
        data:[{
            name:"page",
            value:page ? page : "1"
        }]
    });
}

/**
 * 갤러리 내용을 수정한다.
 */
function updateGallery() {
    // 데이터를 수정하는 화면으로 이동한다.
    goUpdate({
        url:"/portal/myPage/updateUtilGalleryPage.do",
        form:"gallery-search-form"
    });
}

/**
 * 갤러리 내용을 삭제한다.
 */
function deleteGallery() {
    // 데이터를 삭제한다.
    doDelete({
        url:resolveUrl("/deleteBulletin.do"),
        before:beforeDeleteGallery,
        after:afterDeleteGallery
    });
}


/**
 * 갤러리 게시판 내용 평가점수를 변경한다.
 * 
 * @param data {Object} 데이터
 */
function changeAppraisal(data) {
    var image = $(".gallery-grade-combo img:eq(0)");
    
    image.attr("src", data.src);
    image.attr("alt", data.alt);
    
    $(".gallery-grade-combo").click();
}

/**
 * 갤러리 게시판 내용 평가점수를 등록한다.
 */
function insertAppraisal() {
    // 데이터를 처리한다.
    doPost({
        url:resolveUrl("/insertAppraisal.do"),
        before:beforeInsertAppraisal,
        after:afterInsertAppraisal
    });
}

/**
 * 갤러리 게시판 내용 평가점수를 설정한다.
 * 
 * @param data {Object} 데이터
 */
function setAppraisal(data) {
    var image = $(".gallery-grade-image");
    
    if (data.apprVal == 0.0) {
        image.attr("src", com.wise.help.url("/img/ggportal/desktop/common/grade_0.png")).attr("alt", "총점 5점 중 평점 0점 아주 나쁨");
    }
    else if (data.apprVal > 0.0 && data.apprVal <= 0.5) {
        image.attr("src", com.wise.help.url("/img/ggportal/desktop/common/grade_1.png")).attr("alt", "총점 5점 중 평점 0.5점 아주 나쁨");
    }
    else if (data.apprVal > 0.5 && data.apprVal <= 1.0) {
        image.attr("src", com.wise.help.url("/img/ggportal/desktop/common/grade_2.png")).attr("alt", "총점 5점 중 평점 1점 아주 나쁨");
    }
    else if (data.apprVal > 1.0 && data.apprVal <= 1.5) {
        image.attr("src", com.wise.help.url("/img/ggportal/desktop/common/grade_3.png")).attr("alt", "총점 5점 중 평점 1.5점 아주 나쁨");
    }
    else if (data.apprVal > 1.5 && data.apprVal <= 2.0) {
        image.attr("src", com.wise.help.url("/img/ggportal/desktop/common/grade_4.png")).attr("alt", "총점 5점 중 평점 2점 나쁨");
    }
    else if (data.apprVal > 2.0 && data.apprVal <= 2.5) {
        image.attr("src", com.wise.help.url("/img/ggportal/desktop/common/grade_5.png")).attr("alt", "총점 5점 중 평점 2.5점 나쁨");
    }
    else if (data.apprVal > 2.5 && data.apprVal <= 3.0) {
        image.attr("src", com.wise.help.url("/img/ggportal/desktop/common/grade_6.png")).attr("alt", "총점 5점 중 평점 3점 보통");
    }
    else if (data.apprVal > 3.0 && data.apprVal <= 3.5) {
        image.attr("src", com.wise.help.url("/img/ggportal/desktop/common/grade_7.png")).attr("alt", "총점 5점 중 평점 3.5점 보통");
    }
    else if (data.apprVal > 3.5 && data.apprVal <= 4.0) {
        image.attr("src", com.wise.help.url("/img/ggportal/desktop/common/grade_8.png")).attr("alt", "총점 5점 중 평점 4점 좋음");
    }
    else if (data.apprVal > 4.0 && data.apprVal <= 4.5) {
        image.attr("src", com.wise.help.url("/img/ggportal/desktop/common/grade_9.png")).attr("alt", "총점 5점 중 평점 4.5점 좋음");
    }
    else if (data.apprVal > 4.5) {
        image.attr("src", com.wise.help.url("/img/ggportal/desktop/common/grade_10.png")).attr("alt", "총점 5점 중 평점 5점 아주 좋음");
    }
}

/**
 * URL을 반환한다.
 * 
 * @param url {String} URL
 */
function resolveUrl(url) {
    var matches = window.location.href.match(/\/portal\/[^\/]+\//);
    
    return matches[0] + $("#gallery-search-form [name=bbsCd]").val().toLowerCase() + url;
}

////////////////////////////////////////////////////////////////////////////////
// 전처리 함수
////////////////////////////////////////////////////////////////////////////////
/**
 *  갤러리 게시판 내용 조회 전처리를 실행한다.
 * 
 * @param options {Object} 옵션
 * @returns {Object} 데이터
 */
function beforeSelectGallery(options) {
    var data = {
        // Nothing do do.
    };
    
    var form = $("#gallery-search-form");
    
    $.each(form.serializeArray(), function(index, element) {
        switch (element.name) {
            case "page":
            case "rows":
                break;
            default:
                data[element.name] = element.value;
                break;
        }
    });
    
    if (com.wise.util.isBlank(data.bbsCd)) {
        return null;
    }
    if (com.wise.util.isBlank(data.seq)) {
        return null;
    }
    
    return data;
}

/**
 * 갤러리 게시판 내용 평가점수 등록 전처리를 실행한다.
 * 
 * @param options {Object} 옵션
 */
function beforeInsertAppraisal(options) {
    var data = {
        bbsCd:$("#gallery-search-form [name=bbsCd]").val(),
        seq:$("#gallery-search-form [name=seq]").val(),
        apprVal:$(".gallery-grade-combo img:eq(0)").attr("alt").match(/\d/)[0]
    };
    
    if (com.wise.util.isBlank(data.bbsCd)) {
        return null;
    }
    if (com.wise.util.isBlank(data.seq)) {
        return null;
    }
    
    return data;
}

/**
 * 갤러리 게시판 내용 삭제 전처리를 실행한다.
 * 
 * @param options {Object} 옵션
 * @returns {Object} 데이터
 */
function beforeDeleteGallery(options) {
    var data = {
        // Nothing do do.
    };
    
    var form = $("#gallery-select-form");
    
    $.each(form.serializeArray(), function(index, element) {
        switch (element.name) {
            case "bbsCd":
            case "seq":
                data[element.name] = element.value;
                break;
        }
    });
    
    if (com.wise.util.isBlank(data.bbsCd)) {
        alert("삭제할 데이터가 없습니다.");
        return null;
    }
    if (com.wise.util.isBlank(data.seq)) {
        alert("삭제할 데이터가 없습니다.");
        return null;
    }
    
    if (!confirm("게시물을 삭제하시겠습니까?")) {
        return null;
    }
    
    return data;
}

////////////////////////////////////////////////////////////////////////////////
// 후처리 함수
////////////////////////////////////////////////////////////////////////////////
/**
 * 갤러리 게시판 내용 조회 후처리를 실행한다.
 * 
 * @param data {Object} 데이터
 */
function afterSelectGallery(data) {
    var form = $("#gallery-select-form");

    var cateId = form.find("input[name=cateId]").val();  
	var cateNm = form.find("input[name=cateNm]").val();
    var image = $("#gallery-thumbnail-image") ;
    var cateIdIdx = "";
    
    if(cateId != null){
    	cateIdIdx = cateId.substr(2, 1) || "1";
    	if ( Number(cateIdIdx) > 5 ) {
			cateIdIdx = "99";
		}
    }
    
    cateNm = !com.wise.util.isEmpty(cateNm) ? cateNm : "기타";
    
    image.attr("src", com.wise.help.url("/images/icon_bunya0"+cateIdIdx+".png")).attr("alt", "");
    
    $("#bunyaNm").text(cateNm);
    
    form.find("[name=bbsCd]").val(data.bbsCd);
    form.find("[name=seq]").val(data.seq);
    
    form.find(".bbsTit").append(com.wise.help.XSSfilter(data.bbsTit));
    form.find(".list1SubNm").append(data.listSubNm);
    
    
    form.find(".userNm").text(data.userNm);
    form.find(".userDttm").text(data.userDttm);
    
    if (data.htmlYn == "Y") {
        form.find(".bbsCont").html(data.bbsCont);
    }
    else {
        form.find(".bbsCont").text(data.bbsCont ? data.bbsCont.replace(/\r/g, "") : "");
    }
    
    if (data.fileCnt) {
        if (data.files) {
            var list = $("#gallery-image-list");
            
            var item = null;
            
            for (var i = 0; i < data.files.length; i++) {
                var url = resolveUrl("/selectAttachFile.do?fileSeq=") + data.files[i].fileSeq;
                
                if (data.files[i].topYn == "Y") {
                   // $("#gallery-thumbnail-image").attr("src", url);
                }
                else {
                    if (item == null || item.find("span").length == 2) {
                        item = $("<li></li>");
                    }
                    
                    item.append("<span><img alt=\"\" /></span>");
                    
                    item.find("img:last").attr("src", url);
                    
                    if (item.find("span").length == 2 || i == data.files.length - 1) {
                        list.append(item);
                    }
                }
            }
        }
    }
    
    if (data.linkCnt) {
        var list = $("#gallery-data-list");
        
        for (var i = 0; i < data.link.length; i++) {
            var item = $(templates.link);
            
            /*item.find("a").attr("href", data.link[i].url).text(data.link[i].linkNm + " (" + data.link[i].url + ")");*/
            item.find("a").attr("href", data.link[i].url).text(data.link[i].url);
            
            list.append(item);
        }
    }
    if (data.infCnt) {
        if (data.data) {
            var list = $("#gallery-usedLink");
            
            for (var i = 0; i < data.data.length; i++) {
                var item = $(templates.data);
                item.find("a").attr("href", "/portal/data/service/selectServicePage.do/"+data.data[i].infId).text(data.data[i].infNm);
                list.append(item);
            }
        }
        
    } else {
    	$("#gallery-usedLink").append(templates.none);
    }
    
    // 갤러리 게시판 내용 평가점수를 설정한다.
    setAppraisal(data);
    
    if(data.ansState == 'AC') {	//승인불가
    	$('.table_datail_B tr').last().after("<tr><td><b>[승인불가 의견]</b><br><pre>"+data.ansCont+"</pre></td></tr>");
    } else if (data.ansState == "AK") {
    	//승인완료
    	$("#gallery-delete-button").hide();
    }
    
    // bxslider.js 활용갤러리 이미지 slide 스크립트 참조
    mb = $(".imgGalleryDetail").bxSlider({
        mode:"horizontal",
        speed:500,
        pager:false,
        moveSlider:1,
        autoHover:true,
        controls:true,
        slideMargin:0,
        startSlide:0
    });
}

/**
 * 갤러리 게시판 내용 평가점수 등록 후처리를 실행한다.
 * 
 * @param data {Object} 데이터
 */
function afterInsertAppraisal(data) {
    alert("평가해 주셔서 감사합니다.");
    
    // 갤러리 게시판 내용 평가점수를 설정한다.
    setAppraisal(data);
}

/**
 * 갤러리 게시판 내용 삭제 후처리를 실행한다.
 * 
 * @param qnas {Object} Q&A
 */
function afterDeleteGallery(qnas) {
    // Q&A 게시판 내용을 검색한다.
    searchGallery();
}


////////////////////////////////////////////////////////////////////////////////
// 이벤트 함수
////////////////////////////////////////////////////////////////////////////////