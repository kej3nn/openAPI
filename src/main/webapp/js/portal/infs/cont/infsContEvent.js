/**
 * @(#)infsContEvent.js 1.0 2019/08/12
 * 
 * 사전정보공개 컨텐츠 이벤트 관련 스크립트 파일이다.
 * 
 * @author JHKIM
 * @version 1.0 2019/08/12
 */
////////////////////////////////////////////////////////////////////////////////
// GLOBAL VARIABLE
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// SCRIPT INIT
////////////////////////////////////////////////////////////////////////////////
$(function() {
	bindEvent();
	
	bindMobileEvent();
});

function bindEvent() {
	//기본정보 토글
	$(".toggle_metaInfo").bind("click", function() {
		var open = $(".toggle_metaInfo strong").text() == "콘텐츠 열기" ? true : false;
		$(this).find("strong").text(open ? "콘텐츠 닫기" : "콘텐츠 열기");
		$(this).find("img").attr("src", ( open ? com.wise.help.url("/img/ggportal/desktop/common/toggle_open_metaInfo.png") : com.wise.help.url("/img/ggportal/desktop/common/toggle_colse_metaInfo.png") ));
		$("#exp-cont-sect, #exp-tab-sect").slideToggle();
	});
	
	// 트리 주제별/조직별 선택처리 - 2020.01.09
	$(".content_menu li").each(function() {
		$(this).bind("click", function(event) {
			$(".content_menu li a").removeClass("on");
			$(".content_menu li a").attr("aria-selected", "false");
			$(".content_menu li a").attr("title", "");	//2022.12.21 접근성 조치
			var elem = $(this).find("a");
			elem.addClass("on");
			elem.attr("aria-selected", "true");
			elem.attr("title","선택됨");	//2022.12.21 접근성 조치
			var dataGubun = elem.attr("data-gubun");
			$("input[name=cateDataGubun]").val(dataGubun);
			setTreeTabCateId(dataGubun);	// 주제별/지원조직별 탭 선택시 먼저 표시되는 정보셋 입력
			
			// 트리 초기화
			initTree();
		}).bind("keydown" , function(event) {	//2022.12.21 접근성 조치
			if(event.which == 13) {

				$(".content_menu li a").removeClass("on");
				$(".content_menu li a").attr("aria-selected", "false");
				$(".content_menu li a").attr("title", "");	//2022.12.21 접근성 조치
				var elem = $(this).find("a");
				elem.addClass("on");
				elem.attr("aria-selected", "true");
				elem.attr("title","선택됨");	//2022.12.21 접근성 조치
				var dataGubun = elem.attr("data-gubun");
				$("input[name=cateDataGubun]").val(dataGubun);
				setTreeTabCateId(dataGubun);	// 주제별/지원조직별 탭 선택시 먼저 표시되는 정보셋 입력

				// 트리 초기화
				var promis = new Promise(function(resolve, reject){
					initTree();
					resolve();
				});

				promis.then(function(value) {
					setTimeout(function(){
						//2022.12.21 접근성 조치
						elem.focus();
					},300)
				});

				return false;
			}
		});


	});
	
	// 트리 전체열기
	$(".btn_open").bind("click", function(event) {
		treeObjEvent("EXP");
		return false;
	}).bind("keydown", function(event) {
		if (event.which == 13) {
			treeObjEvent("EXP");
			return false;
		}
	});
	// 트리 전체닫기
	$(".btn_close").bind("click", function(event) {
		treeObjEvent("UN_EXP");
		return false;
	}).bind("keydown", function(event) {
		if (event.which == 13) {
			treeObjEvent("UN_EXP");
			return false;
		}
	});
	// 정보셋 검색 입력창 엔터 - PC
	$("#txtSearchVal").bind("keydown", function(event) {
		if (event.which == 13) {
			searchInfs();
			return false;
		}
	});
	// 정보셋 검색 입력창 엔터 - 모바일
	$("#txtMbSearchVal").bind("keydown", function(event) {
		if (event.which == 13) {
			selectInfsCont(1);
			return false;
		}
	});
	
	// 정보셋 검색 버튼
	$("#btnSearch").bind("click", function(event) {
		searchInfs();
		return false;
	}).bind("keydown", function(event) {
		if (event.which == 13) {
			searchInfs();
			return false;
		}
	});
	// 정보셋 검색 결과 닫기
	$("#btnSearchResultClose").bind("click", function(event) {
		$(".searchResult").hide();
		$("#txtSearchVal").val("");
		return false;
	}).bind("keydown", function(event) {
		if (event.which == 13) {
			$(".searchResult").hide();
			$("#txtSearchVal").val("");
			return false;
		}
	});
	// 정보셋 검색 결과 오름차순 정렬
	$("#btnSortAsc").bind("click", function(event) {
		$("#paramOrderBy").val("A");
		$("#btnSearch").click();
		return false;
	}).bind("keydown", function(event) {
		if (event.which == 13) {
			$("#paramOrderBy").val("A");
			$("#btnSearch").click();
			return false;
		}
	});
	// 정보셋 검색 결과 내림차순 정렬
	$("#btnSortDesc").bind("click", function(event) {
		$("#paramOrderBy").val("D");
		$("#btnSearch").click();
		return false;
	}).bind("keydown", function(event) {
		if (event.which == 13) {
			$("#paramOrderBy").val("D");
			$("#btnSearch").click();
			return false;
		}
	});
	// 정보셋 목록 다운로드
	$(".content_tree_down").find("a").bind("click", function(event) {
		var f = $("#form");
		f.attr("target","iframePopUp");
		f.attr("method","post");
		f.attr("action",com.wise.help.url("/portal/infs/cont/infsListExcel.do"));
		f.submit();
	}).bind("keydown", function(event) {
		if (event.which == 13) {
			var f = $("#form");
			f.attr("target","iframePopUp");
			f.attr("method","post");
			f.attr("action",com.wise.help.url("/portal/infs/cont/infsListExcel.do"));
			f.submit();
		}
	});
	
	//페이스북 공유
    $("#shareFB").bind("click", function(event) {
    	var fullUrl = location.href;
		var url = fullUrl;
		if($("#shareCateId").val() != '' && $("#shareInfsId").val() != ''){
			url = fullUrl.slice(0,fullUrl.indexOf("?"))+"?"+"cateId="+$("#shareCateId").val()+"&infsId="+$("#shareInfsId").val();
		}
		
		shareFace(url);
    });
    
    //트위터 공유
	$("#shareTW").bind("click", function(event) {
		
		var fullUrl = location.href;
		var url = fullUrl;
		if($("#shareCateId").val() != '' && $("#shareInfsId").val() != ''){
			url = fullUrl.slice(0,fullUrl.indexOf("?"))+"?"+"cateId="+$("#shareCateId").val()+"&infsId="+$("#shareInfsId").val();
		}
		shareTwitter(url, $(".text_header").text());
    });
	
	 //네이버 블로그 공유
	$("#shareBG").bind("click", function(event) {
		var fullUrl = location.href;
		var url = fullUrl;
		if($("#shareCateId").val() != '' && $("#shareInfsId").val() != ''){
			url = fullUrl.slice(0,fullUrl.indexOf("?"))+"?"+"cateId="+$("#shareCateId").val()+"&infsId="+$("#shareInfsId").val();
		}
		
		shareNaver(url, $(".text_header").text());
    });
	//카카오 스토리 고유
	$("#shareKS").bind("click", function(event) {
		var fullUrl = location.href;
		var url = fullUrl;
		if($("#shareCateId").val() != '' && $("#shareInfsId").val() != ''){
			url = fullUrl.slice(0,fullUrl.indexOf("?"))+"?"+"cateId="+$("#shareCateId").val()+"&infsId="+$("#shareInfsId").val();
		}
		
		// shareStory(url, $(".text_header").text());
		shareStory(location.href, $(".text_header").text());
	});
	//카카오 톡고유
	$("#shareKT").bind("click", function(event) {
		var key = $("#kakaoKey").val();
		var fullUrl = location.href;
		var url = fullUrl;
		if($("#shareCateId").val() != '' && $("#shareInfsId").val() != ''){
			url = fullUrl.slice(0,fullUrl.indexOf("?"))+"?"+"cateId="+$("#shareCateId").val()+"&infsId="+$("#shareInfsId").val();
		}
		
		shareKT(url, $(".text_header").text(), key);
	});
	
}

function bindMobileEvent() {
	// 목록
	$("#btnMobileList").bind("click", function(event) {
		$(".content_text").hide();
		$(".mobile_content_all").show();
		return false;
	}).bind("keydown", function(event) {
		if (event.which == 13) {
			$(".content_text").hide();
			$(".mobile_content_all").show();
			return false;
		}
	});
	// 조회
	$("#btnMbSearch, #btnMbCateSearch").bind("click", function(event) {
		event.stopPropagation();
		selectInfsCont(1);
		return false;
	}).bind("keydown", function(event) {
		if (event.which == 13) {
			selectInfsCont(1);
			return false;
		}
	});
	// 분류 모달창 열기
	$("#txtMbCate, #btnMbCate").bind("click", function(event) {
		$("#modelMbCate").show();
		return false;
	}).bind("keydown", function(event) {
		if (event.which == 13) {
			$("#modelMbCate").show();
			return false;
		}
	});
	// 분류 모달창 닫기
	$("#btnMbCateClose").bind("click", function(event) {
		$("#modelMbCate").hide();
		return false;
	}).bind("keydown", function(event) {
		if (event.which == 13) {
			$("#modelMbCate").hide();
			return false;
		}
	});
	// 분류 모달창 콤보박스 변경이벤트
	$("select[id^=selMbCate]").bind("change", function(event) {
		selectInfoCateChild($(this).val(), $(this).attr("id"));
	});
	
	// 설명탭 SELECTBOX 변경 이벤트 - 모바일
	$("#exp-mbTab-sect").bind("change", function(a, b) {
		var idx = $("#exp-mbTab-sect option:selected").index()
		var expMbTabSect = $("#exp-mbTab-sect");
		var expContSect = $("#exp-cont-sect");
		expContSect.find(".expCont").hide();
		expContSect.find(".expCont").eq(idx).show();
		
	});
}

/**
 * 분류 트리 열기/닫기 이벤트 처리
 * @param event
 * @returns
 */
function treeObjEvent(event) {
	switch (event) {
	case "EXP":
		$("#treeObj").dynatree("getRoot").visit(function(dtnode){
			dtnode.expand(true);
	    });
	    return false;
		break;
	case "UN_EXP":
		$("#treeObj").dynatree("getRoot").visit(function(dtnode){
			dtnode.expand(false);
		});
		break;
	
	}
}

/**
 * 설명탭 버튼 이벤트
 * 
 * @param idx	탭 위치
 */
function bindExpTabSelect(idx) {
	var expTabSect = $("#exp-tab-sect");
	var expContSect = $("#exp-cont-sect");
	var expContHeaderSect = $("#exp-cont-sect-header");
	expContHeaderSect.empty().show();
	expTabSect.find("a").removeClass("on");
	expTabSect.find("a").attr("aria-selected", "false");
	//웹접근성 조치 23.11.06
	for(var i = 0 ; i < expTabSect.find("a").length; i ++){
		expTabSect.find("a").eq(i).attr("title",expTabSect.find("a").eq(i).text());
	}

	expTabSect.find("a").eq(idx).addClass("on").attr("title",expTabSect.find("a").eq(idx).text() + " 선택됨");
	expTabSect.find("a").eq(idx).attr("aria-selected", "true");
	expContHeaderSect.html(expTabSect.find("a").eq(idx).html()).show();
	expContSect.find(".expCont").hide();
	expContSect.find(".expCont").eq(idx).show();
	
	// 트리 높이 컨텐츠 사이즈와 동일하도록 변경
	changeTreeAreaHeight();
}

/**
 * 컨텐츠 높이가 글 내용에 따라 달라졌을경우 트리영역의 높이도 동일하게 맞춰 준다
 */
function changeTreeAreaHeight() {
	$(".content_tree").height($(".content_text").height());
	//$(".content_tree_area").height($(".content_text").height());  -하단 라인이 없어지는 이슈로 삭제
	$("#treeObj").height($(".content_text").height() - 162);
}

/**
 * 주제별/지원조직별 탭 선택시 먼저 표시되는 정보셋 입력
 * @param gubun	탭 구분
 * @returns
 */
function setTreeTabCateId(gubun) {
	if ( gubun == "subj" ) {
		$("#paramInfsId").val("");
		$("#paramCateId").val("NA10000");
	}
	else if ( gubun == "sorg" ) {
		$("#paramInfsId").val("IQ60021753Q12716");
		$("#paramCateId").val("NA30000");
	}
	else {
		$("#paramInfsId").val("");
		$("#paramCateId").val("");
	}
}

