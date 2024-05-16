/**
 * @(#)infsListEvent.js 1.0 2019/08/13
 * 
 * 사전정보공개 목록 이벤트 관련 스크립트 파일이다.
 * 
 * @author JHKIM
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
	
	// 조회 - PC
	$("#btnSearch").bind("click", function(event) {
		event.stopPropagation();
		loadInfsList(1);
		return false;
	}).bind("keydown", function(event) {
		if (event.which == 13) {
			loadInfsList(1);
			return false;
		}
	});
	// 조회 - 모바일
	$("#btnMbSearch").bind("click", function(event) {
		event.stopPropagation();
		$("#schInputVal").val($("#schMbInputVal").val());
		loadInfsList(1);
		return false;
	}).bind("keydown", function(event) {
		if (event.which == 13) {
			$("#schInputVal").val($("#schMbInputVal").val());
			loadInfsList(1);
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
		$("#searchForm [name=schHdnCateId]").remove();
		$("button[id^=btnCate]").removeClass("on");
		$("button[id^=btnCate][data-gubun="+$(this).val()+"]").click();
	})
	
	
	// 검색 폼 서비스유형 변경이벤트 - PC
	$("button[id^=btnSrv]").each(function() {
		$(this).bind("click", function(event) {
			event.stopPropagation();
			eventSchFormAsSrv($(this));
			return false;
		}).bind("keydown", function(event) {
			if (event.which == 13) {
				eventSchFormAsSrv($(this));
				return false;
			}
		});
	});
	// 검색 폼 서비스유형 변경이벤트 - 모바일
	$("a[id^=btnMbSrv]").each(function() {
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
	
	// 검색 폼 공개유형 변경이벤트 - PC
	$("button[id^=btnTag]").each(function() {
		$(this).bind("click", function(event) {
			event.stopPropagation();
			eventSchFormAsTag($(this));
			return false;
		}).bind("keydown", function(event) {
			if (event.which == 13) {
				eventSchFormAsTag($(this));
				return false;
			}
		});
	});
	// 검색 폼 서비스유형 변경이벤트 - 모바일
	$("a[id^=btnMbTag]").each(function() {
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
			//웹접근성 조치 20.11.09
			$(".hide").text($(this).text());
			
			eventSchFormAsVOrder($(this));
			return false;
		}).bind("keydown", function(event) {
			if (event.which == 13) {
				//웹접근성 조치 20.11.09
				$(".hide").text($(this).text());
				
				eventSchFormAsVOrder($(this));
				return false;
			}
		});
	});
	
	// 조회되는 행 갯수 변경 이벤트
	$("#selRows").bind("change", function(event) {
		loadInfsList(1);
	}).bind("keydown", function(event) {
		if (event.which == 13) {
			loadInfsList(1);
			return false;
		}
	});
	
	// 검색어 입력창 엔터 이벤트 - PC
	$("#schInputVal").bind("keydown", function(event) {
		if (event.which == 13) {
			loadInfsList(1);
			return false;
		}
	});
	// 검색어 입력창 엔터 이벤트 - 모바일
	$("#schMbInputVal").bind("keydown", function(event) {
		if (event.which == 13) {
			$("#schInputVal").val($("#schMbInputVal").val());
			loadInfsList(1);
			return false;
		}
	});
	
	// 기관 변경 이벤트
	$("#schOrgCd").bind("change", function(event) {
		loadInfsList(1);
	}).bind("keydown", function(event) {
		if (event.which == 13) {
			loadInfsList(1);
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
			obj.attr("aria-selected", true).attr("title", "선택됨");	// 2021.11.10 - 웹접근성 처리
		}
		else {
			$("#btnCateAll").removeClass("on");
			$("#btnCateAll").attr("aria-selected", false).attr("title", "");
			obj.toggleClass("on");
			
			if ( obj.hasClass("on") ) {
				obj.attr("aria-selected", true).attr("title", "선택됨");
				addInputHidden({
					formId: "searchForm",
					objId: "schHdnCateId",
					val: gubun
				});
			}
			else {
				$("input[name=schHdnCateId][value="+gubun+"]").remove();
				obj.attr("aria-selected", false).attr("title", "");
			}
			
			// 분류가 전체선택될경우, 전부 선택풀었을경우 전체버튼 선택해준다.
			if ( $("button[id^=btnCateId]").length == $("button[id^=btnCateId][class=on]").length
					|| $("button[id^=btnCateId][class=on]").length == 0 ) {
				$("button[id^=btnCateId]").attr("aria-selected", false).attr("title", "");
				$("#btnCateAll").click();
			}
		}
		// 선택시 바로 조회
		loadInfsList(1);
	}
}

/**
 * 검색 폼 - 서비스유형 선택시 버튼 액션 및 처리
 */
function eventSchFormAsSrv(obj) {
	obj = obj || null;
	
	if ( obj != null ) {
		var gubun = obj.attr("data-gubun");
		
		if ( gubun === "ALL" ) {
			
			if ( obj.hasClass("on") ) return false;
			$("input[name=schHdnSrvCd]").remove();
			$("button[id^=btnSrvId]").removeClass("on");
			obj.addClass("on");
			obj.attr("aria-selected", true).attr("title", "선택됨");	// 2021.11.10 - 웹접근성 처리
			
		}
		else {
			$("#btnSrvAll").removeClass("on");
			$("#btnSrvAll").attr("aria-selected", false).attr("title", "");
			obj.toggleClass("on");
			if ( obj.hasClass("on") ) {
				obj.attr("aria-selected", true).attr("title", "선택됨");
				addInputHidden({
					formId: "searchForm",
					objId: "schHdnSrvCd",
					val: gubun
				});
			}
			else {
				$("input[name=schHdnSrvCd][value="+gubun+"]").remove();
				obj.attr("aria-selected", false).attr("title", "");
			}
			
			// 서비스유형이 전체선택될경우, 전부 선택풀었을경우 전체버튼 선택해준다.
			if ( $("button[id^=btnSrvId]").length == $("button[id^=btnSrvId][class=on]").length 
					|| $("button[id^=btnSrvId][class=on]").length == 0 ) {
				$("button[id^=btnSrvId]").attr("aria-selected", false).attr("title", "");
				$("#btnSrvAll").click();
			}
		}
		// 선택시 바로 조회
		loadInfsList(1);
		
		// 모바일 선택처리
		$("a[id^=btnMbSrv]").removeClass("on");
		$("button[id^=btnSrv]").each(function() {
			if ( $(this).hasClass("on") ) {
				$("a[id^=btnMbSrv][data-gubun="+$(this).attr("data-gubun")+"]").addClass("on");
			}
		});
	}
}

/**
 * 검색 폼 - 공개유형 선택시 버튼 액션 및 처리
 */
function eventSchFormAsTag(obj) {
	obj = obj || null;
	
	if ( obj != null ) {
		var gubun = obj.attr("data-gubun");
		
		if ( gubun === "A" ) {
			if ( obj.hasClass("on") )	return false;
			$("input[name=schHdnTag]").remove();
			$("button[id^=btnTagId]").removeClass("on");
			obj.addClass("on");
			obj.attr("aria-selected", true).attr("title", "선택됨");	// 2021.11.10 - 웹접근성 처리
		}
		else {
			$("#btnTagAll").removeClass("on");
			$("#btnTagAll").attr("aria-selected", false).attr("title", "");;
			obj.toggleClass("on");
			
			if ( obj.hasClass("on") ) {
				obj.attr("aria-selected", true).attr("title", "선택됨");
				addInputHidden({
					formId: "searchForm",
					objId: "schHdnTag",
					val: gubun
				});
			}
			else {
				$("input[name=schHdnTag][value="+gubun+"]").remove();
				obj.attr("aria-selected", false).attr("title", "");
			}
			
			// 공개유형이 전체선택될경우, 전부 선택풀었을경우 전체버튼 선택해준다.
			if ( $("button[id^=btnTagId]").length == $("button[id^=btnTagId][class=on]").length 
					|| $("button[id^=btnTagId][class=on]").length == 0 ) {
				 $("button[id^=btnTagId]").attr("aria-selected", false).attr("title", "");
				$("#btnTagAll").click();
			}
			
		}
		// 선택시 바로 조회
		loadInfsList(1);
		
		// 모바일 선택처리
		$("a[id^=btnMbTag]").removeClass("on");
		$("button[id^=btnTag]").each(function() {
			if ( $(this).hasClass("on") ) {
				$("a[id^=btnMbTag][data-gubun="+$(this).attr("data-gubun")+"]").addClass("on");
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
			formId: "searchForm",
			objId: "schVOrder",
			val: gubun
		});
		
		// 조회
		loadInfsList(1);
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
