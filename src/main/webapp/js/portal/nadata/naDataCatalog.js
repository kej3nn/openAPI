/**
 * @(#)naDataCatalog.js 1.0 2019/08/12
 * 
 * 정보서비스 카탈로그 스크립트 파일이다.
 * 
 * @author CSB
 * @version 1.0 2019/08/12
 */

////////////////////////////////////////////////////////////////////////////////
// SCRIPT INIT
////////////////////////////////////////////////////////////////////////////////
$(function() {
	// 컴포넌트 초기화
	initComp();
	
	bindEvent();
	
});

////////////////////////////////////////////////////////////////////////////////
// 초기화 함수
////////////////////////////////////////////////////////////////////////////////
function initComp() {
	// 트리 초기화
	initTree();
	
	// 초기 트리 사이즈 조절
	changeTreeAreaHeight();
	
	// 디렉토리 모바일 목록(페이징)
	searchMobileNaSetDir();
	
	// 목록 리스트 조회(페이징)
	selectNaSetListPaging();
}

function bindEvent() {
	// 주제선택 이벤트
	$("#naDataTopCate li a").bind("click", function(event) {
		$("#parCateId").val($(this).attr('id'));
		$("#naDataTopCate li").removeClass("on");
		$(this).closest("li").addClass("on");
		initTree();
		return false;
	}).bind("keydown", function(event) {
		if (event.which == 13) {
			$("#parCateId").val($(this).attr('id'));
			$("#naDataTopCate li").removeClass("on");
			$(this).closest("li").addClass("on");
			initTree();
			return false;
		}
	});
	
	// 모바일 콤보박스 변경 이벤트
	$("#catePosMobile").bind("change", function(event) {
		var idx = $("#catePosMobile option:selected").index();
		$("#naDataTopCate li").eq(idx).find("a").click();
//		$("#catePosMobile").val($(this).val());
		searchMobileNaSetDir(1);
		return false;
	});
	
	// 디렉토리/목록 탭 변경 이벤트
	$("#tab-sect .tab_J a").each(function(idx) {
		$(this).bind("click", function(event) {
			$("#tab-sect .tab_J a").removeClass("on");
			$(this).addClass("on");
			$(".content_all").hide();
			$(".content_all").eq(idx).show();
			changeTreeAreaHeight();
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
	
	// 검색 엔터이벤트
	$("#txtSearchVal").bind("keydown", function(event) {
		if (event.which == 13) {
			if ( com.wise.util.isBlank($("#txtSearchVal").val()) ) {
				alert("검색어를 입력하세요.");
				return false;
			}
			
			searchNaSetDir();
			return false;
		}
	});
	
	// 검색 버튼
	$("#btnSearch").bind("click", function(event) {
		if ( com.wise.util.isBlank($("#txtSearchVal").val()) ) {
			alert("검색어를 입력하세요.");
			return false;
		}
		searchNaSetDir();
		return false;
	}).bind("keydown", function(event) {
		if (event.which == 13) {
			if ( com.wise.util.isBlank($("#txtSearchVal").val()) ) {
				alert("검색어를 입력하세요.");
				return false;
			}
			searchNaSetDir();
			return false;
		}
	});
	
	// 검색 결과 닫기
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
	// 검색 결과 오름차순 정렬
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
	// 검색 결과 내림차순 정렬
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
	// 트리 목록 다운로드
	$(".content_tree_down").find("a").bind("click", function(event) {
		var f = $("#global-request-form");
		f.attr("target","iframePopUp");
		f.attr("method","post");
		f.attr("action",com.wise.help.url("/portal/nadata/catalog/selectNaDataCateTreeExcel.do"));
		f.submit();
	}).bind("keydown", function(event) {
		if (event.which == 13) {
			var f = $("#global-request-form");
			f.attr("target","iframePopUp");
			f.attr("method","post");
			f.attr("action",com.wise.help.url("/portal/nadata/catalog/selectNaDataCateTreeExcel.do"));
			f.submit();
		}
	});
	
	// 정보셋 목록 조회
	$("#btnListSch").bind("click", function() {
		selectNaSetListPaging(1);
	}).bind("keydown", function(event) {
		if (event.which == 13) {
			selectNaSetListPaging(1);
			return false;
		}
	});
	// 정보셋 목록조회 정보명 엔터
	$("#listForm input[name=infoNm]").bind("keydown", function(event) {
		if (event.which == 13) {
			selectNaSetListPaging(1);
			return false;
		}
	});
	// 정보셋 목록 다운로드(검색된 결과)
	$("#btnListDown").bind("click", function(event) {
		var f = $("#listForm");
		f.attr("target","iframePopUp");
		f.attr("method","post");
		f.attr("action",com.wise.help.url("/portal/nadata/catalog/selectNaDataListExcel.do"));
		f.submit();
	}).bind("keydown", function(event) {
		if (event.which == 13) {
			var f = $("#listForm");
			f.attr("target","iframePopUp");
			f.attr("method","post");
			f.attr("action",com.wise.help.url("/portal/nadata/catalog/selectNaDataListExcel.do"));
			f.submit();
		}
	});
	
	// 모바일 목록
	$("#btnMobileList").bind("click", function(event) {
		$(".content_text").hide();
		$(".mobile_content_all").show();
		$("#catePosMobile-sect").show();
		return false;
	}).bind("keydown", function(event) {
		if (event.which == 13) {
			$(".content_text").hide();
			$(".mobile_content_all").show();
			$("#catePosMobile-sect").show();
			return false;
		}
	});
}

/**
 * 트리를 초기화 한다.
 */
function initTree() {
	var initTreeSuccess = function() {
		var deferred = $.Deferred();
		try {
			loadTree();	// 트리 로드
			deferred.resolve(true);
		} catch (err) {
			deferred.reject(false);
		}
		return deferred.promise();
	}
	
	initTreeSuccess().done(function(message) {
	}).always(function() {
		setTimeout(function() {
			activeInfsTreeNode();
		}, 100);
	});
}

/**
 * 키값(정보서비스 카탈로그ID, 분류ID)에 따라 트리 노드 바로가기
 */
function activeInfsTreeNode() {
	var infoId = $("#paramInfoId").val();
	var cateId = $("#paramCateId").val();
	
	// 정보서비스 카탈로그, 분류ID가 모두 넘어온경우
	if ( !com.wise.util.isBlank(infoId)) {
		$("#treeObj").dynatree("getRoot").visit(function(node){
            if (node.data.key == infoId ) {
            	loadInfo({ id: infoId });
            	node.focus();
            }
        });
	}
	// 정보서비스 카탈로그 ID만 넘어온경우
	/*else if ( !com.wise.util.isBlank(infoId) ) {
		$("#treeObj").dynatree("getTree").getNodeByKey(infoId).focus();
	}*/
	// 분류ID만 넘어온 경우
	else if ( !com.wise.util.isBlank(cateId) ) {
		var nodeKey = $("#treeObj").dynatree("getTree").getNodeByKey(cateId);
		if ( nodeKey != null ) {
			var childrens = nodeKey.data.children;
			
			if ( childrens.length > 0 ) {
				for ( var i in childrens ) {
					if ( childrens[i].gubunTag == 'T' ) {
						var key = childrens[i].key;	// 문서 ID
						
						// 해당 ID 포커스 처리(문서ID가 여러 분류체계로 들어갈 수 있음)
						$("#treeObj").dynatree("getRoot").visit(function(node){
							if (node.data.key == key ) {
								// 데이터 로드
								loadInfo({
									id: key
								});

								// focus 처리
								node.activate();
								setTimeout(function() {
									node.focus();
								}, 100);
							}
						});
						
						break;
					}
				}
			}
			else {
				$("#treeObj").dynatree("getTree").getNodeByKey(cateId).focus();
			}
		}
	}
}

/**
 * 트리 로드
 */
function loadTree() {
	var parCateId = $("#parCateId").val() || "NA10000";
	doAjax({
		url: "/portal/nadata/catalog/selectNaDataCateTree.do",
		params: "parCateId="+parCateId ,
		callback: function(res) {
			var data = res.data;
			//$("#paramInfoId").val(data[0].children[0].infoId);
			$("#treeObj").dynatree({
		        selectMode: 3,
		        children: data,
		        onClick: function (node, event) {
		        	if(!node.data.isFolder)  {
		           		setTimeout(function() {
		           			treeInfoClick(node.data.key, node.data.parInfoId);
		           		}, 0);
		        	}
		        }
		    });
			
			$("#treeObj").dynatree("getTree").reload();
			
			$("#naDataTopCate li").removeClass("on");
			$("#naDataTopCate > li > a[id="+parCateId+"]").parent().addClass("on");
			$("#parCateId").val(parCateId);
		}
	});
	
	function treeInfoClick(id, parCateId) {
		// 로딩중...
		gfn_showLoading();
		
		setTimeout(function() {
			// id 선택시 처리 정보서비스 카탈로그 상세조회
			loadInfo({
				id: id
			});
		}, 10);
	}
}



/**
 * 정보셋 모바일 검색(디렉토리)
 */
function searchMobileNaSetDir(page) {
	page = page || 1;
	doSearch({
		url : "/portal/nadata/catalog/searchNaSetDirPaging.do",
		page : page,
		before : beforeSearchMobileNaSetDir,
		after : afterSearchMobileNaSetDir,
		pager : "mobile-list-pager-sect"
	});
}

// 정보셋 모바일 검색(디렉토리) - 전처리
function beforeSearchMobileNaSetDir(options) {
	var form = $("#form");
	
	if (com.wise.util.isEmpty(options.page)) {
		form.find("[name=page]").val(1);
	} else {
		form.find("[name=page]").val(options.page);
	}
	//$("input[name=rows]").val(10);		// 조회행 수
	
	var data = form.serializeObject();
	
	data["topCateId"] = $("#catePosMobile").val();
	return data;
}

// 정보셋 모바일 검색(디렉토리) - 후처리
function afterSearchMobileNaSetDir(datas) {
	var item = "";
	
	mobileSect = $("#mobile-list-sect"),
	
	mobileSect.empty();
	
	if ( datas.length > 0 ) {
		for ( var i in datas ) {
			data = datas[i];
			item = $("<a href=\"javascript:;\"><strong></strong></a>");
			item.find("strong").text(data.infoNm)
				.bind("click", { 
					id: data.infoId,
					mobile: true
				},  function(event) {
					// 로딩중...
					gfn_showLoading();
					
					loadInfo(event.data);
					return false;
				}).bind("keydown", { 
						id: data.infoId,
						mobile: true
					}, function(event) {
						if (event.which == 13) {
							// 로딩중...
							gfn_showLoading();
							
							loadInfo(event.data);
							return false;
						}
				});
			mobileSect.append(item);
		}
		
	}
	else {
		item = $("<a href=\"javascript:;\"><strong>조회된 데이터가 없습니다.</strong></a>");
		mobileSect.append(item);
	}
}

/**
 * 정보셋 검색(디렉토리)
 */
function searchNaSetDir() {
	doSearch({
		url : "/portal/nadata/catalog/searchNaSetDirPaging.do",
		before : beforeSearcNaSetDir,
		after : afterSearchNaSetDir,
	});
}

// 정보셋 검색(디렉토리) - 전처리
function beforeSearcNaSetDir(options) {
	var data = {};
	
	data["searchVal"] = htmlTagFilter($("#txtSearchVal").val());
	data["orderBy"] = htmlTagFilter($("#paramOrderBy").val());
	data["topCateId"] = $("#naDataTopCate > li.on > a").attr("id") || $("#naDataTopCate > li:eq(0) a").attr("id");
	
	return data;
}

// 정보셋 검색(디렉토리) - 후처리
function afterSearchNaSetDir(datas) {
	var item = "", highlight = "", infsNm = "", data = null, regex = null,
	searchSect = $("#result-search-sect"),
	searchVal = htmlTagFilter($("#txtSearchVal").val()),
	searchValSplit = searchVal.split(" ");
	
	$("#paramOrderBy").val("");
	$(".searchResult").show();
	searchSect.empty();
	
	if ( datas.length > 0 ) {
		for ( var i in datas ) {
			data = datas[i];
			item = $("<li><a href=\"javascript:;\" name=\"\"><strong class=\"tit\"></strong></a></li>");
			item.find(".tit").text(data.infoNm)
				.bind("click", { 
					id: data.infoId
				},  function(event) {
					// 로딩중...
					gfn_showLoading();
					
					loadInfo(event.data);
					return false;
				}).bind("keydown", { 
						id: data.infoId
					}, function(event) {
						if (event.which == 13) {
							// 로딩중...
							gfn_showLoading();
							
							loadInfo(event.data);
							return false;
						}
				});
			searchSect.append(item);
		}
		
		// 검색어 강조 처리
		$("#result-search-sect li a strong").each(function () {
	    	for( var i in searchValSplit ) {
	    		if ( !com.wise.util.isBlank(searchValSplit[i]) ) {
		    		regex = new RegExp(searchValSplit[i],'gi');
		    		infsNm = $(this).text();
		    		infsNm = (infsNm.toUpperCase()).match(searchValSplit[i].toUpperCase());
		    		$(this).html( $(this).html().replace(regex, "<span class='text-red'>"+infsNm+"</span>") );
	    		}
	    	}
	    });
	}
	else {
		item = $("<li><a href=\"javascript:;\" name=\"\"><strong class=\"tit\"></strong></a></li>");
		item.find(".tit").text("조회된 데이터가 없습니다.");
		searchSect.append(item);
	}
}


/**
 * 정보셋 카탈로그 목록 검색
 * @param page	페이지
 * @returns
 */
function selectNaSetListPaging(page) {
	page = page || 1;
	doSearch({
		url : "/portal/nadata/catalog/selectNaSetListPaging.do",
		page : page,
		before : beforeSelectNaSetListPaging,
		after : afterSelectNaSetListPaging,
		pager : "list-pager-sect",
		counter: {
			count:"list-count-sect",
            pages:"list-pages-sect"
		}
	});
}
// 정보셋 카탈로그 목록검색 - 전처리
function beforeSelectNaSetListPaging(options) {
	var form = $("#listForm");
	
	if (com.wise.util.isEmpty(options.page)) {
		form.find("[name=page]").val(1);
	} else {
		form.find("[name=page]").val(options.page);
	}
	$("input[name=rows]").val(10);		// 조회행 수
	
	var data = form.serializeObject();
	
	return data;
}
// 정보셋 카탈로그 목록검색 - 후처리
function afterSelectNaSetListPaging(datas) {
	var row = "",
		data = null,
		list = $("#list-sect"),
		item = "<tr>" +
				"	<td class=\"ROW_NUM\"></td>" +
				"	<td class=\"infoNm\"><a href=\"\" target=\"_blank\"  title=\"URL바로가기\"></a></td>" +
				"	<td class=\"cateFullnm\"></td>" +
				"	<td class=\"orgNm\"></td>" +
				"	<td class=\"srvInfoNm\"></td>" +
				"	<td class=\"srcSysNm\"></td>" +
				"	<td class=\"srcUrl\"><a href=\"\" class=\"assm_view\" title=\"URL복사하기\">복사하기</a></td>" +
				"	<td class=\"infoSmryExp left\"></td>" +
				"</tr>";
	
	list.empty();
	
	if ( datas.length > 0 ) {
		
		for ( var i in datas ) {
			row = $(item);
			
			data = datas[i];
			
			Object.keys(data).map(function(key, idx) {
				if ( key == "srcUrl" ) {
					row.find("." + key).find('a').attr("href", "javascript:copyUrlToClipboard('"+data[key]+"');");
				} else if( key == "infoNm" ){
					row.find("." + key).find('a').attr("href", data["srcUrl"]);
					row.find("." + key).find('a').text(data[key]);
				} else {
					row.find("." + key).text(data[key]);
				}
			});

			
			list.append(row);
		}
		
		//tr전체에 링크 처리
		/*
		list.find("tr").click(function() {
			window.open($(this).find("a").attr("href"), '_blank');
		});*/
	}
	else {
		row = $(item);
		list.append("<td colspan='"+ String(row.find("td").length)+"'>조회된 데이터가 없습니다.</td>");
	}
}

/**
 * 컨텐츠 높이가 글 내용에 따라 달라졌을경우 트리영역의 높이도 동일하게 맞춰 준다
 */
function changeTreeAreaHeight() {
	$(".content_tree").height($(".content_text").height());
	$("#treeObj").height($(".content_text").height()-120);
}

/**
 * 정보서비스 카탈로그 조회
 * @param data.id			정보서비스 카탈로그 ID
 * @param data.parCateId	상위 카테고리 ID
 * @param mobile			모바일 여부
 * @returns
 */
function loadInfo(data) {
	data.id 		= data.id || "";
	data.parCateId 	= data.parCateId || "";
	data.mobile 		= data.mobile || false;
	
	// 초기 기본이미지 화면 숨김
	if ( $(".first_main").css("display") == 'block' ) {
		$(".first_main").hide();
	}
	$("#shareinfoId").val(data.id);
	$("#shareCateId").val(data.parCateId);
	var loadSuccess = function() {
		var deferred = $.Deferred();
		try {
			selectInfoDtl(data.id, data.parCateId);	// 정보서비스 카탈로그 상세조회
			deferred.resolve(true);
		} catch (err) {
			deferred.reject(false);
		}
		return deferred.promise();
	};
	
	loadSuccess().done(function(message) {
	}).always(function() {
		setTimeout(function() {
			// 트리 높이 컨텐츠 사이즈와 동일하도록 변경
			changeTreeAreaHeight();
			
			if ( data.mobile ) {
				$(".content_text").show();
				$(".mobile_content_all").hide();
				$("#catePosMobile-sect").hide();
			}
			
			gfn_hideLoading();
		}, 100);
	});
}


/**
 * 정보서비스 카탈로그서비스 상세조회
 * @param id	정보서비스 카탈로그 ID
 * @returns
 */
function selectInfoDtl(id, parCateId) {
	doAjax({
		url: "/portal/nadata/catalog/selectInfoDtl.do",
		params: "infoId="+id,
		callback: function(res) {
			var data = res.data;
			Object.keys(data).map(function(key, idx) {
				if ( key == "cateFullnm" ) {	// 메뉴 LOCATION
					var sp = data[key].split('>');
					$(".content_location").empty();
					for ( var i in sp ) {
						$(".content_location").append("<span>"+ sp[i] +"</span>");
					}
					$("#dtlVal_" + key).text(sp[0]);
					
				}else if (key == "srcUrl"){
					$("#dtlVal_srcUrl").empty();
					$("#dtlVal_srcUrl").append("<a href=\""+data[key]+"\" target=\"_blank\" title=\"새창열림\">"+data[key]+"</a>" )
				}else if ( $("#dtlTxt_" + key).length > 0 ) {
					$("#dtlTxt_" + key).text(data[key]);
					$("#dtlVal_" + key).text(data[key]);
				}else if ( $("#dtlVal_" + key).length > 0 ) {
					$("#dtlVal_" + key).text(data[key]);
				}else if (key =="tmnlImgFile"){
					$("#tmnlImgFile").empty();
					if(data[key]!=null){
						var cateId = data[key].split('.');
						var url = com.wise.help.url("/portal/nadata/catalog/selectThumbnail.do?gb=site&cateId="+cateId[0] );  
						$("#tmnlImgFile").append("<img alt=\"\" src=\""+url+"\">" )
					}
				}
			});
		}
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
 * 바로가기 URL 정보 클립보드 복사
 * @param event
 * @returns
 */
function copyUrlToClipboard(urlValue) {
	$("#clip_tmp").val(urlValue);
	$("#clip_tmp").select();
	
	var successful = document.execCommand('copy');

     if (successful) {
        alert('URL이 클립보드에 복사되었습니다.');
     } else {
        alert('URL이 클립보드에 복사되지 않았습니다.');

     }
}