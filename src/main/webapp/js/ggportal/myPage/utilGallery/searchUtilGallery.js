/*
 * COPYRIGHT (C) 2013 WISEITECH CO., LTD. ALL RIGHTS RESERVED.
 */

/**
	장홍식
*/
$(function() {
    // 컴포넌트를 초기화한다.
    initComp();
    
    // 마스크를 바인딩한다.
    bindMask();
    
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
		/*data:
			'<li>'
			+'<a href="" class="list_Dlink">'
			+'	<span class="icon"><img src="" alt="" /></span>'
			+'	<span class="summary">'
			+'		<strong class="tit w_2 bbsTit"></strong>'
			+'		<span class="date userDttm"></span>'
			+'	</span>'
			+'	<span>ccc'
			+'	</span>'
			+'</a>'
			+'</li>'*/
		data:
			'<tr style="text-align:center">'
				+'<td>'
				+'	<span class="listSubNm mq_tablet">'
				+'	</span>'
				+'</td>'
				+'<td class="area_tit">'
			//	+'	<span class="icon mq_tablet"><img src="" alt="" /></span>'
			//	+'	<span class="summary">'
			//	+'	</span>'
				+'<a href="" class="link tit ellipsis w_400 my_platform">'
				+'	<span class="icon">'
				+		'<img class="mq_tablet thumnail"  src="" alt="" />'
				+'  </span>'
				+'	<span class="bbsTit"></span>'
				+'	<strong class="btn_detail mq_mobile"></strong>'
				+'</a>'
				+'</td>'
				+'<td class="txt"><span class="txt_D ansStateNm"></span>'
				+'</td>'
				+'<td>'
				+'	<span class="date userDttm">'
				+'	</span>'
				+'</td>'
			+'</tr>'
		, none:
			"<tr>"                                                              +
            	"<td colspan=\"4\" class=\"noData\">해당 자료가 없습니다.</td>" +
            "</tr>"
};

////////////////////////////////////////////////////////////////////////////////
//초기화 함수
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
    // Nothing do do.
}

/**
 * 이벤트를 바인딩한다.
 */
function bindEvent() {
    $(".gallery-insert-button").each(function(index, element) {
        // 갤러리 게시판 내용 활용갤러리 등록 버튼에 클릭 이벤트를 바인딩한다.
        $(this).bind("click", function(event) {
            // 갤러리 게시판 내용을 등록한다.
            insertGallery();
            return false;
        });
        
        // 갤러리 게시판 내용 활용갤러리 등록 버튼에 키다운 이벤트를 바인딩한다.
        $(this).bind("keydown", function(event) {
            if (event.which == 13) {
                // 갤러리 게시판 내용을 등록한다.
                insertGallery();
                return false;
            }
        });
    });
    
    $(".blog-insert-button").each(function(index, element) {
        // 갤러리 게시판 내용 활용갤러리 등록 버튼에 클릭 이벤트를 바인딩한다.
        $(this).bind("click", function(event) {
            // 갤러리 게시판 내용을 등록한다.
            insertBlog();
            return false;
        });
        
        // 갤러리 게시판 내용 활용갤러리 등록 버튼에 키다운 이벤트를 바인딩한다.
        $(this).bind("keydown", function(event) {
            if (event.which == 13) {
                // 갤러리 게시판 내용을 등록한다.
            	insertBlog();
                return false;
            }
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
    // 갤러리 게시판 내용을 검색한다.
    searchGallery($("#gallery-search-form [name=page]").val());
}

////////////////////////////////////////////////////////////////////////////////
//서비스 함수
////////////////////////////////////////////////////////////////////////////////
/**
* 갤러리 게시판 내용을 검색한다.
* 
* @param page {String} 페이지 번호
*/
function searchGallery(page) {
	// 데이터를 검색한다.
	doSearch({
		url:"/portal/myPage/myBBSList.do",
		before:beforeSearchGallery,
		after:afterSearchGallery,
		pager:"gallery-pager-sect",
        counter:{
            count:"gallery-count-sect",
            pages:"gallery-pages-sect"
        }
	});
}

/**
 * 갤러리 게시판 내용을 조회한다.
 * 
 * @param data {Object} 데이터
 */
function selectGallery(data) {
	
    // if (!verifyWriter(data.lockTag, "gallery-search-form", selectGallery, data)) {
    //     return;
    // }
    
    // 데이터를 조회하는 화면으로 이동한다.
	if(data.bbsCd == 'GALLERY'){
	    goSelect({
	        url:"/portal/myPage/selectUtilGalleryPage.do",
	        form:"gallery-search-form",
	        data:[{
	            name:"bbsCd",
	            value:data.bbsCd
	        }, {
	            name:"seq",
	            value:data.seq
	        }, {
	            name:"noticeYn",
	            value:data.noticeYn
	        }, {
	            name:"cateId",
	            value:data.cateId
	        }, {
	            name:"cateNm",
	            value:data.cateNm
	        }]
	    });
	}
	else{
		 goSelect({
		        url:"/portal/myPage/selectUtilBlogPage.do",
		        form:"gallery-search-form",
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
	
}

/**
 * 갤러리 게시판 내용을 조회한다.
 * 
 * @param data {Object} 데이터
 */
function selectBlog(data) {
	
    // if (!verifyWriter(data.lockTag, "gallery-search-form", selectGallery, data)) {
    //     return;
    // }
    
    // 데이터를 조회하는 화면으로 이동한다.
    goSelect({
        url:"/portal/myPage/selectUtilBlogPage.do",
        form:"gallery-search-form",
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
 * 갤러리 게시판 내용을 등록한다.
 */
function insertGallery() {
    // // 데이터를 등록하는 화면으로 이동한다.
     goInsert({
         url:"/portal/myPage/insertUtilGalleryPage.do",
         form:"gallery-search-form",
         data:[{
             name:"seq",
             value:""
         }]
     });
}

/**
 * 블로그 내용을 등록한다.
 */
function insertBlog() {
    // // 데이터를 등록하는 화면으로 이동한다.
     goInsert({
         url:"/portal/myPage/insertUtilBlogPage.do",
         form:"gallery-search-form",
         data:[{
             name:"seq",
             value:""
         }]
     });
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
//전처리 함수
////////////////////////////////////////////////////////////////////////////////
/**
*  갤러리 게시판 내용 검색 전처리를 실행한다.
* 
* @param options {Object} 옵션
* @returns {Object} 데이터
*/
function beforeSearchGallery(options) {
	var data = {
			// Nothing do do.
	};
	
	var form = $("#gallery-search-form");
	
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
//후처리 함수
////////////////////////////////////////////////////////////////////////////////
/**
* 갤러리 게시판 내용 검색 후처리를 실행한다.
* 
* @param data {Array} 데이터
*/
function afterSearchGallery(data) {
	var list = $("#gallery-data-list");
	
	list.find("tr").each(function(index, element) {
		$(this).remove();
	});
	
	for (var i = 0; i < data.length; i++) {
		
		var item = $(templates.data);
		item.find(".bbsTit").text(data[i].bbsTit);
//		if (data[i].fileSeq) {
//			var url = com.wise.help.url(resolveUrl("/selectAttachFile.do")) + "?fileSeq=" + data[i].fileSeq;
//			item.find(".icon img").attr({src : url, alt : data[i].bbsTit});
//		}
//		else {
//			item.find(".icon img").attr("alt", data[i].bbsTit);
//		}
		
		var cateIdIdx = "";
		if(data[i].cateId != null){
			cateIdIdx = data[i].cateId.substr(2, 1) || "1";
			if ( Number(cateIdIdx) > 5 ) {
				cateIdIdx = "99";
			}
		}else{
			cateIdIdx = "99"
		}
		var src = "/images/icon_bunya0"+cateIdIdx+".png" 
		var cateNm = !com.wise.util.isEmpty(data[i].cateNm) ? data[i].cateNm : "기타";
		item.find(".icon img").attr({src : src, alt : cateNm});
		
		
		item.find(".listSubNm").text(data[i].listSubNm);
		item.find(".list1SubNm").text(data[i].list1SubNm);
		item.find(".userDttm").text(data[i].userDttm);
		switch (data[i].ansState) {
        case "RW":
        	item.find(".ansStateNm").addClass("txt_D_inquiry");
            break;
        case "AW":
        	item.find(".ansStateNm").addClass("txt_D_standby");
        	break;
        case "AK":
        	item.find(".ansStateNm").addClass("txt_D_answer");
            break;
        case "AC":
        	item.find(".ansStateNm").addClass("txt_D_impossibility");
            break;
		}
		item.find(".ansStateNm").text(data[i].ansStateNm);
		
		// 갤러리 게시판 내용 제목 링크에 클릭 이벤트를 바인딩한다.
		item.find("a").bind("click", {
			bbsCd:data[i].bbsCd,
			seq:data[i].seq,
			noticeYn:data[i].noticeYn,
			cateId:data[i].cateId,
			cateNm:data[i].cateNm
		}, function(event) {
			selectGallery(event.data);
			return false;
		});
	
		// 갤러리 게시판 내용 제목 링크에 키다운 이벤트를 바인딩한다.
		item.find("a").bind("keydown", {
			bbsCd:data[i].bbsCd,
			seq:data[i].seq,
			noticeYn:data[i].noticeYn,
			cateId:data[i].cateId,
			cateNm:data[i].cateNm
		}, function(event) {
			if (event.which == 13) {
				// 갤러리 게시판 내용을 조회한다.
				//if(bbsCd = "GALLERY"){
					selectGallery(event.data);
				//}else{
				//	selectBlog(event.data);
				//}
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



////////////////////////////////////////////////////////////////////////////////
//이벤트 함수
////////////////////////////////////////////////////////////////////////////////
