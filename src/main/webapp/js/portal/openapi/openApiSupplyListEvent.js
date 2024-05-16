/**
 * @(#)openApiNaListEvent 1.0 2019/10/11
 * 
 * Open API 목록 리스트 화면 이벤트 스크립트(국회사무처)
 * 
 * @author JHKIM
 * @version 1.0 2019/10/11
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
	$("button[id^=btnOrg]").each(function() {
		$(this).bind("click", function(event) {
			event.stopPropagation();
			eventSchFormAsOrg($(this));
			return false;
		}).bind("keydown", function(event) {
			if (event.which == 13) {
				eventSchFormAsOrg($(this));
				return false;
			}
		});
	});
	// 검색 폼 분류체계 변경이벤트 - 모바일
	$("#selMbOrgCd").bind("change", function() {
		$("#searchForm [name=schHdnOrgCd]").remove();
		$("button[id^=btnOrg]").removeClass("on");
		$("button[id^=btnOrg][data-gubun="+$(this).val()+"]").click();
	})
	
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
	$("#schApiTagCd").bind("change", function(event) {
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
	
	$("#excelDown").bind("click", function(event) {
		excelDownload();
	});
	
}

/**
 * 검색 폼 - 분류체계 선택시 버튼 액션 및 처리
 */
function eventSchFormAsOrg(obj) {
	obj = obj || null;
	
	if ( obj != null ) {
		var gubun = obj.attr("data-gubun");
		
		if ( gubun === "A" ) {
			if ( obj.hasClass("on") )	return false;
			$("input[name=schHdnOrgCd]").remove();
			$("button[id^=btnOrgCd]").removeClass("on");
			obj.addClass("on");
		}
		else {
			$("#btnOrgAll").removeClass("on");
			obj.toggleClass("on");
			
			if ( obj.hasClass("on") ) {
				addInputHidden({
					formId: "searchForm",
					objId: "schHdnOrgCd",
					val: gubun
				});
			}
			else {
				$("input[name=schHdnOrgCd][value="+gubun+"]").remove();
			}
			
			// 분류가 전체선택될경우, 전부 선택풀었을경우 전체버튼 선택해준다.
			if ( $("button[id^=btnOrgCd]").length == $("button[id^=btnOrgCd][class=on]").length
					|| $("button[id^=btnOrgCd][class=on]").length == 0 ) {
				$("#btnOrgAll").click();
			}
		}
		// 선택시 바로 조회
		loadInfsList(1);
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
      Kakao.Story.share({
    	url : location.href,
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
 * 엑셀 다운로드 
 */
function excelDownload(){
	var form = $("form[name=searchForm]");
	
	form.attr("action", com.wise.help.url("/portal/openapi/excelOpenApiSupplyList.do"));
	form.attr("target", "global-process-iframe");
	form.submit();
}