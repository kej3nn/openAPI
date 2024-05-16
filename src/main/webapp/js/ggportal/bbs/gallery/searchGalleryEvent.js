/**
 * @(#)infsListEvent.js 1.0 2019/08/13
 * 
 * 활용갤러리 목록 이벤트 관련 스크립트 파일이다.
 * 
 * @author JSSON
 * @version 1.0 2019/08/13
 */
////////////////////////////////////////////////////////////////////////////////
// GLOBAL VARIABLE
////////////////////////////////////////////////////////////////////////////////


////////////////////////////////////////////////////////////////////////////////
// SCRIPT INIT
////////////////////////////////////////////////////////////////////////////////
$(function() {
});

function bindEvent() {
	$(".gallery-insert-button").each(function(index, element){
		// 갤러리 게시판 내용 활용 갤러리 등록 버튼에 클릭 이벤트를 바인딩한다.
		$(this).bind("click", function(event){
			// 갤러리 게시판 내용을 등록한다.
			insertGallery();
			return false;
		});
	
		// 갤러리 게시판 내용 활용갤러리 등록 버튼에 키다운 이벤트를 바인딩한다.
		$(this).bind("click", function(event){
			if (event.which == 13) {
				insertGallery();
				return false;
			}
		});
		
	});	
	
	// 조회 - PC
	$("#btnSearch").bind("click", function(event) {
		event.stopPropagation();
		loadGalleryList(1);
		return false;
	}).bind("keydown", function(event) {
		if (event.which == 13) {
			loadGalleryList(1);
			return false;
		}
	});
	// 조회 - 모바일
	$("#btnMbSearch").bind("click", function(event) {
		event.stopPropagation();
		$("#schInputVal").val($("#schMbInputVal").val());
		loadGalleryList(1);
		return false;
	}).bind("keydown", function(event) {
		if (event.which == 13) {
			$("#schInputVal").val($("#schInputVal").val());
			loadGalleryList(1);
			return false;
		}
	});
		
	// 검색 폼 분류체계 변경이벤트 - PC
	$("button[id^=btnCate]").each(function() {
		$(this).bind("click", function(event) {
			event.stopPropagation();
			eventSchFormAsCate($(this));
			return false;
		}).bind("keydown", function(event) {
			if (event.which == 13) {
				eventSchFormAsCate($(this));
				return false;
			}
		});
	});
	// 검색 폼 분류체계 변경이벤트 - 모바일
	$("#selMbCateId").bind("change", function() {
		$("#gallery-search-form [name=schHdnCateId]").remove();
		$("button[id^=btnCate]").removeClass("on");
		$("button[id^=btnCate][data-gubun="+$(this).val()+"]").click();
	})
	
	// 검색 폼 활용구분 변경이벤트 - PC
	$("button[id^=btnUsed]").each(function() {
		$(this).bind("click", function(event) {
			event.stopPropagation();
			eventSchFormAsUsed($(this));
			return false;
		}).bind("keydown", function(event) {
			if (event.which == 13) {
				eventSchFormAsUsed($(this));
				return false;
			}
		});
	});
	// 검색 폼 활용구분 변경이벤트 - 모바일
	$("a[id^=btnMbUsed]").each(function() {
		$(this).bind("click", function(event) {
			event.stopPropagation();
			var id = $(this).attr("id");
			id = id.replace("Mb", "");
			$("#" + id).click();
			return false;
		}).bind("keydown", function(event) {
			if (event.which == 13) {
				var id = $(this).attr("id");
				id = id.replace("Mb", "");
				$("#" + id).click();
				return false;
			}
		});
	});
	
	
	
	// 검색 폼 조회 변경 이벤트
	$("button[id^=btnVOrder]").each(function() {
		$(this).bind("click", function(event) {
			event.stopPropagation();
			eventSchFormAsVOrder($(this));
			return false;
		}).bind("keydown", function(event) {
			if (event.which == 13) {
				eventSchFormAsVOrder($(this));
				return false;
			}
		});
	});
	
	// 조회되는 행 갯수 변경 이벤트
	$("#selRows").bind("change", function(event) {
		loadGalleryList(1);
	}).bind("keydown", function(event) {
		if (event.which == 13) {
			loadGalleryList(1);
			return false;
		}
	});
	
	// 검색어 입력창 엔터 이벤트 - PC
	$("#schInputVal").bind("keydown", function(event) {
		if (event.which == 13) {
			loadGalleryList(1);
			return false;
		}
	});
	// 검색어 입력창 엔터 이벤트 - 모바일
	$("#schMbInputVal").bind("keydown", function(event) {
		if (event.which == 13) {
			$("#schInputVal").val($("#schMbInputVal").val());
			loadGalleryList(1);
			return false;
		}
	});
	
	//페이스북 공유
    $("#shareFB").bind("click", function(event) {
    	window.open("https://www.facebook.com/sharer/sharer.php"
        		+"?u="+encodeURIComponent(window.location.href)
        		, "_blank"
        		, 'width=600,height=400,resizable=yes,scrollbars=yes'
        		);


    });
	
	//트위터 공유
	$("#shareTW").bind("click", function(event) {
		window.open("https://twitter.com/share"
        		+"?text="+encodeURIComponent( $(".detail_summary .tit").text() )
        		+"&url="+encodeURIComponent(window.location.href)
        		, "_blank"
        		, 'width=600,height=400,resizable=yes,scrollbars=yes'
        		);
    });
    
    //네이버 블로그 공유
	$("#shareBG").bind("click", function(event) {
		window.open("http://blog.naver.com/openapi/share"
        		+"?url="+encodeURIComponent(window.location.href)
        		+"&title="+encodeURIComponent( $(".detail_summary .tit").text() )
        		, "_blank"
        		, 'width=600,height=400,resizable=yes,scrollbars=yes'
        		);
    });
}

/**
 * 검색 폼 - 분류체계 선택시 버튼 액션 및 처리
 */
function eventSchFormAsCate(obj) {
	obj = obj || null;
	
	if ( obj != null ) {
		var gubun = obj.attr("data-gubun");
		
		if ( gubun === "A" ) {
			if ( obj.hasClass("on") )	return false;
			$("input[name=schHdnCateId]").remove();
			$("button[id^=btnCateId]").removeClass("on");
			obj.addClass("on");
			obj.attr("aria-selected", true);
		}
		else {
			$("#btnCateAll").removeClass("on");
			$("#btnCateAll").attr("aria-selected", false);
			obj.toggleClass("on");
			
			if ( obj.hasClass("on") ) {
				obj.attr("aria-selected", true);
				addInputHidden({
					formId: "gallery-search-form",
					objId: "schHdnCateId",
					val: gubun
				});
			}
			else {
				$("input[name=schHdnCateId][value="+gubun+"]").remove();
				obj.attr("aria-selected", false);
			}
			
			// 분류가 전체선택될경우, 전부 선택풀었을경우 전체버튼 선택해준다.
			if ( $("button[id^=btnCateId]").length == $("button[id^=btnCateId][class=on]").length
					|| $("button[id^=btnCateId][class=on]").length == 0 ) {
				$("button[id^=btnCateId]").attr("aria-selected", false);
				$("#btnCateAll").click();
			}
		}
		// 선택시 바로 조회
		loadGalleryList(1);
	}
}

/**
 * 검색 폼 - 활용구분 선택시 버튼 액션 및 처리
 */
function eventSchFormAsUsed(obj) {
	obj = obj || null;
	
	if ( obj != null ) {
		var gubun = obj.attr("data-gubun");
		
		if ( gubun === "A" ) {
			if ( obj.hasClass("on") )	return false;
			$("input[name=schHdnUsedId]").remove();
			$("button[id^=btnUsedId]").removeClass("on");
			obj.addClass("on");
			obj.attr("aria-selected", true);
		}
		else {
			$("#btnUsedAll").removeClass("on");
			$("#btnUsedAll").attr("aria-selected", false);
			obj.toggleClass("on");
			
			if ( obj.hasClass("on") ) {
				obj.attr("aria-selected", true);
				addInputHidden({
					formId: "gallery-search-form",
					objId: "schHdnUsedId",
					val: gubun
				});
			}
			else {
				$("input[name=schHdnUsedId][value="+gubun+"]").remove();
				obj.attr("aria-selected", false);
			}
			
			// 분류가 전체선택될경우, 전부 선택풀었을경우 전체버튼 선택해준다.
			if ( $("button[id^=btnUsedId]").length == $("button[id^=btnUsedId][class=on]").length
					|| $("button[id^=btnUsedId][class=on]").length == 0 ) {
				$("button[id^=btnUsedId]").attr("aria-selected", false);
				$("#btnUsedAll").click();
			}
		}
		// 선택시 바로 조회
		loadGalleryList(1);
		
		// 모바일 선택처리
		$("a[id^=btnMbUsed]").removeClass("on");
		$("button[id^=btnUsed]").each(function() {
			if ( $(this).hasClass("on") ) {
				$("a[id^=btnMbUsed][data-gubun="+$(this).attr("data-gubun")+"]").addClass("on");
			}
		});
	}
}



/**
 * 검색 폼 - 정렬기준 선택시 버튼 액션 및 처리
 */
function eventSchFormAsVOrder(obj) {
	var gubun = obj.attr("data-gubun");
	
	// 선택되었으면 새로 조회하지 않음
	if ( obj.hasClass("on") ) {
		return false;
	}
	else {
		//웹접근성 조치 23.11.06
		$("button[id^=btnVOrder]").removeClass("on").removeAttr("title");
		obj.addClass("on").attr("title","선택됨");
		
		// 기존 히든값 지우고 다시만듬
		$("input[name=schVOrder]").remove();
		addInputHidden({
			formId: "gallery-search-form",
			objId: "schVOrder",
			val: gubun
		});
		
		// 조회
		loadGalleryList(1);
	}
	
}
/*카카오 스토리 공유*/
function shareStory() {
	var origin = window.location.origin;
	var url = location.href;
	if (origin === "http://localhost:8080") {
		url = url.replace(origin, "https://open.assembly.go.kr");
	}

	Kakao.Story.share({
    	url : url,
        text: $(".detail_summary .tit").text()
      });
}
/*카카오톡 공유*/
function sendLink() {
	Kakao.Link.sendDefault({
		objectType: "feed",
		content: {
			title: $(".detail_summary .tit").text(),
			description: "#열린국회정보",
			imageUrl: "https://open.assembly.go.kr/kakao.png",
			imageWidth: 800,
			imageHeight: 400,
			link: {
				mobileWebUrl: location.href,
				webUrl: location.href
			}
		}
	});
 }

/**
 * 갤러리 게시판 내용을 등록한다.
 */
function insertGallery() {
	window.location.href = com.wise.help.url("/portal/myPage/insertUtilGalleryPage.do");
}

