$(function() {

	init();
	
    // 이벤트를 바인딩한다.
    bindEvent();
    
    // 데이터를 로드한다.
    loadData();
});

////////////////////////////////////////////////////////////////////////////////
//글로벌 변수
////////////////////////////////////////////////////////////////////////////////
/**
* 템플릿
*/
var templates = {
	data:
		" <li>"
		+" 	<a href=\"#\" class=\"link\">"
		+" 		<span class=\"thumbnail\"><img src=\"\" alt=\"\"/></span>"
		+" 		<span class=\"summary\">"
		+" 			<strong class=\"tit\"></strong>"
		+" 			<span class=\"name\"></span>"
		+" 			<span class=\"type\"></span>"
		+" 		</span>"
		+" 	</a>" 
		+" </li>",
	none:
		"<li class=\"noData\">해당 자료가 없습니다.</li>"
};

function init() {
	
	var form = $('#visual-search-form');
	var tabIdx = form.find('[name=tabIdx]').val();
	if(!tabIdx || tabIdx == null || tabIdx == "") {
		tabIdx = 0;
	}
	$('.gallery-section-tab:eq('+tabIdx+')').addClass("on");
}

/**
 * 이벤트를 바인딩한다.
 */
function bindEvent() {
	$('.gallery-section-tab').bind('click', function() {
		if(!$(this).hasClass("on")) {
			
			$('.gallery-section-tab').removeClass("on");
			$(this).addClass("on");
			var index = $(this).index();
			if(index == 1) {
				$('#visual-search-form [name=vistnCd]').val("I");
				$('#visual-search-form [name=tabIdx]').val(index);
			} else if(index == 2) {
				$('#visual-search-form [name=vistnCd]').val("C");
				$('#visual-search-form [name=tabIdx]').val(index);
			} else {
				$('#visual-search-form [name=vistnCd]').val("");
				$('#visual-search-form [name=tabIdx]').val(0);
			}
			$('#nowStatusNm').text($(this).text());
			searchVisual("1");
		}
	});
}


/**
 * 데이터를 로드한다.
 */
function loadData() {
    // 게시판 내용을 검색한다.
    searchVisual($("#visual-search-form [name=page]").val());
}

////////////////////////////////////////////////////////////////////////////////
//서비스 함수
////////////////////////////////////////////////////////////////////////////////
/**
* 게시판 내용을 검색한다.
* 
* @param page {String} 페이지 번호
*/
function searchVisual(page) {
	// 데이터를 검색한다.
	doSearch({
		url:"/portal/data/visual/searchVisualData.do",
		page:page ? page : "1",
		before:beforeSearchVisual,
		after:afterSearchVisual,
		pager:"visual-pager-sect"
	});
}

/**
 * 게시판 내용을 조회한다.
 * 
 * @param data {Object} 데이터
 */
function selectVisual(data) {
    // 데이터를 조회하는 화면으로 이동한다.
    goSelect({
        url:"/portal/data/visual/selectVisualPage.do",
        form:"visual-search-form",
        data:[{
	            name:"vistnSrvSeq",
	            value:data.vistnSrvSeq
        	}
        	, {
        		name:"vistnCd",
        		value:data.vistnCd
        	}
        
        ]
    });
}


////////////////////////////////////////////////////////////////////////////////
//전처리 함수
////////////////////////////////////////////////////////////////////////////////

/**
 *  게시판 내용 검색 전처리를 실행한다.
 * 
 * @param options {Object} 옵션
 * @returns {Object} 데이터
 */
function beforeSearchVisual(options) {
    var data = {
        // Nothing do do.
    };
    
    var form = $("#visual-search-form");
    
    if (com.wise.util.isBlank(options.page)) {
        form.find("[name=page]").val("1");
    }
    else {
        form.find("[name=page]").val(options.page);
    }
    
    $.each(form.serializeArray(), function(index, element) {
        switch (element.name) {
            case "vistnSrvSeq":
            default:
                data[element.name] = element.value;
                break;
        }
    });
    
    return data;
}


////////////////////////////////////////////////////////////////////////////////
//후처리 함수
////////////////////////////////////////////////////////////////////////////////
/**
 * 게시판 내용 검색 후처리를 실행한다.
 * 
 * @param data {Array} 데이터
 */
function afterSearchVisual(data) {
    var list = $("#visual-data-list");
    
    list.find("li").each(function(index, element) {
        $(this).remove();
    });
    
    for (var i = 0; i < data.length; i++) {
        var item = $(templates.data);
        
        if (data[i].tmnlImgFile) {
        	var url = com.wise.help.url(data[i].tmnlImgFile);
        	item.find(".thumbnail img").attr({
        		src : url
        		, alt : data[i].vistnNm + " thumbnail"
        	});
		}
		else {
			item.find(".thumbnail img").attr("alt", data[i].vistnNm + " thumbnail");
		}
        item.find(".tit").text(data[i].vistnNm);
        item.find(".name").text(data[i].prdNm);
        item.find(".type").text(data[i].vistnTyNm);
        
        // 게시판 내용 제목 링크에 클릭 이벤트를 바인딩한다.
        item.find("a").bind("click", {
            vistnSrvSeq:data[i].vistnSrvSeq
            , vistnCd:data[i].vistnCd
        }, function(event) {
            // 게시판 내용을 조회한다.
            selectVisual(event.data);
            return false;
        });
        
        // 게시판 내용 제목 링크에 키다운 이벤트를 바인딩한다.
        item.find("a").bind("keydown", {
            vistnSrvSeq:data[i].vistnSrvSeq
            , vistnCd:data[i].vistnCd
        }, function(event) {
            if (event.which == 13) {
                // 게시판 내용을 조회한다.
                selectVisual(event.data);
                return false;
            }
        });
        
        list.append(item);
    }
    
    if (data.length == 0) {
        var item = $(templates.none);
        
        list.append(item);
    }
}
