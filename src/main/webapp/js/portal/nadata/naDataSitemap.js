/**
 * @(#)naDataSitemap.js 1.0 2019/08/12
 * 
 * 정보 사이트맵 스크립트 파일이다.
 * 
 * @author CSB
 * @version 1.0 2019/08/12
 */
////////////////////////////////////////////////////////////////////////////////
// GLOBAL VARIABLE
////////////////////////////////////////////////////////////////////////////////

// 템플릿 객체
var template = {
	item: 
		"<div class=\"sitemap_box\">" +
		"	<a href=\"javascript:;\" class=\"srvmNmBox\">" +
		"	</a>" +
		"</div>"
	
};
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
	loadSiteMapList();
	
	$("#result_srvm_list").show();
	$("#result_srvm_sitemap").show();	
	$("#result_search_sitemap").hide();
}

function loadSiteMapList() {
	
	gfn_showLoading();
	
	var loadSuccess = function() {
		var deferred = $.Deferred();
		try {
			selectSiteMapList();
			deferred.resolve(true);
		} catch (err) {
			deferred.reject(false);
		}
		return deferred.promise();
	};
	
	loadSuccess().done(function(message) {
	}).always(function() {
		setTimeout(function() {
			gfn_hideLoading();
		}, 100);
	});
}

function bindEvent() {
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
	
	// 검색
	$("button[id=btnSearch]").bind("click", function() {
		
		var searchKeyword = $("#schInputVal").val();
		// 선택시 바로 조회
		if(searchKeyword != ""){
			searchSiteMapList();
			
			$("#result_srvm_list").hide();
			$("#result_srvm_sitemap").hide();		
			$("#result_search_sitemap").show();
		}else{
			selectSiteMapList();
			
			$("#result_srvm_list").show();
			$("#result_srvm_sitemap").show();		
			$("#result_search_sitemap").hide();
		}
		return false;
	});
	
	$("input[name=schInputVal]").bind("keydown", function(event) {
		if (event.which == 13) {
			//selectSiteMapList();
			if($(this).val() != ""){
				searchSiteMapList();
				
				$("#result_srvm_list").hide();
				$("#result_srvm_sitemap").hide();		
				$("#result_search_sitemap").show();
			}else{
				selectSiteMapList();
				
				$("#result_srvm_list").show();
				$("#result_srvm_sitemap").show();		
				$("#result_search_sitemap").hide();
			}			
			return false;
		}
	});
	
	// 초기화
	$("button[id=btnReset]").bind("click", function() {
		selectSiteMapList();
		
		$("#schInputVal").val("");
		
		$("#result_srvm_list").show();
		$("#result_srvm_sitemap").show();		
		$("#result_search_sitemap").hide();
		
		return false;
	});

	//탭버튼 > 사이트맵
	/*$("#tab_siteMap").on("click", function(e){
		$(this).addClass("on");
		$("#tab_menuList").removeClass("on");
		$(".sc_menulist").hide();
		$(".sc_sitemap").show();
	});*/
	
	//탭버튼 > 메뉴목록
	/*$("#tab_menuList").on("click", function(e){
		$(this).addClass("on");
		$("#tab_siteMap").removeClass("on");
		$(".sc_menulist").show();
		$(".sc_sitemap").hide();
	});*/
	
}

/**
 * 사이트맵 목록을 조회한다.
 * @param page	페이지
 * @returns
 */
function selectSiteMapList() {
	
	doSearch({
		url : "/portal/nadata/sitemap/selectSiteMapList.do",
		before : beforeSelectSiteMapList,
		after : afterSelectSiteMapList
	});
}

/**
 * 사이트맵 목록 조회 전처리
 */
function beforeSelectSiteMapList(options) {
	var form = $("#searchForm");
	
	var data = form.serializeObject();
	
	return data;
}

/**
 * 사이트맵 목록 조회 후처리
 * @param datas
 * @returns
 */
function afterSelectSiteMapList(datas) {
	var item = "",
		data = null,
		list = $("#result_srvm_list");
	
	$(".sitemap_content").hide();
	list.empty();
	$("#result_srvm_list_mobile").empty();
	
	if ( datas.length > 0 ) {
		for ( var i in datas ) {
			data = datas[i];
			item = $(template.item);
			
			item.find(".srvmNmBox").text(data.srvmNm)
				.bind("click", {
					srvmId: data.srvmId,
					orgCd: data.orgCd,
					orgNm: data.orgNm,
					srcUrl: data.srcUrl,
					infoSmryExp: data.infoSmryExp,
					srvmNm: data.srvmNm,
					tmnlImgFile: data.tmnlImgFile,
					tmnl2ImgFile: data.tmnl2ImgFile,
					cateId: data.cateId
				}, function(event) {
					
					$("#result_srvm_list div a").removeClass("on");
					$(this).addClass("on");
					
					makeSiteMapDtl(event.data);
				});
			
			list.append(item);
			
			// 모바일 리스트 콤보박스 추가
			afterSelectSiteMapMobileList(data, i);
		}
		$("#result_srvm_list div a:first" ).addClass("on");
		$("#result_srvm_list div a:first" ).trigger("click");
		
		// 모바일 콤보박스 변경 이벤트
		$("#result_srvm_list_mobile").bind("change", function(event) {
			var idx = $("#result_srvm_list_mobile option:selected").index();
			$("#result_srvm_list .srvmNmBox").eq(idx).click();
			return false;
		});
		
		$(".sitemap_content").show();
	}
	else {
		list.append("조회된 데이터가 없습니다.");
	}
}

function afterSelectSiteMapMobileList(data, idx) {
	var combo = $("#result_srvm_list_mobile");
	combo.append("<option value=\""+ data.srvmId +"\">"+ data.srvmNm +"</option>");
}

function makeSiteMapDtl(data) {
	
	$("#srcUrl").empty();
	//이미지 경로
	var imgUrl = com.wise.help.url("/portal/nadata/sitemap/selectThumbnail.do?gb=preView&srvmId="+data.srvmId );
	var img2Url = com.wise.help.url("/portal/nadata/sitemap/selectThumbnail.do?gb=siteMap&srvmId="+data.srvmId );
	$("#tmnlImgFileNm").attr("src", imgUrl);
	$("#tmnl2ImgFileNm").attr("src",img2Url); 
	
	$("#hSrvmNm").text(data.srvmNm);
	$("#srcUrl").append("<a href=\""+data.srcUrl+"\" target=\"_blank\" title=\"새창열림\">"+data.srcUrl+"</a>");
	$("#infoSmryExp").text(data.infoSmryExp);
	$("#orgNm").text(data.orgNm);
	$("#srvmNmMenu").text(data.srvmNm + " 전체메뉴");
	$("#srcUrlGo").attr("href", data.srcUrl);
	
	//메뉴목록
	/*
	$.ajax({
		type : 'POST',
		dataType : 'json',
		async : false,
		url : com.wise.help.url("/portal/nadata/sitemap/selectMenuList.do"),
		data : "cateId="+data.cateId,
		success : function(menu) {
			$("#sitemapMenu>tbody").empty();
			var menuData = menu.data;
			if ( menuData.length > 0 ) {
				var rowspanCnt = 0;
				var mergeCnt = 0;
				for ( var i in menuData ) {
					data = menuData[i];
					if(data.HaveChild == 0){
						var inHtml = "<tr>";
						var cateNm = data.cateFullNm.split(">");
						var srcUrl = data.srcUrl == null ? "" : data.srcUrl;
						
						if(cateNm.length > 1){
							if(rowspanCnt < cateNm.length) rowspanCnt = cateNm.length;
							if(cateNm.length == 2){
								inHtml += "<td>"+cateNm[1]+"</td><td></td><td></td><td></td><td class='left'><a href='"+srcUrl+"' target=_blank>"+srcUrl+"</a></td>";
								if(mergeCnt < 2) mergeCnt = 2;
							}
							if(cateNm.length == 3){
								inHtml += "<td>"+cateNm[1]+"</td><td>"+cateNm[2]+"</td><td></td><td></td><td class='left'><a href='"+srcUrl+"' target=_blank>"+srcUrl+"</a></td>";
								if(mergeCnt < 3) mergeCnt = 3;
							}
							if(cateNm.length == 4){
								inHtml += "<td>"+cateNm[1]+"</td><td>"+cateNm[2]+"</td><td>"+cateNm[3]+"</td><td></td><td class='left'><a href='"+srcUrl+"' target=_blank>"+srcUrl+"</a></td>";
								if(mergeCnt < 4) mergeCnt = 4;
							}
							if(cateNm.length == 5){
								inHtml += "<td>"+cateNm[1]+"</td><td>"+cateNm[2]+"</td><td>"+cateNm[3]+"</td><td>"+cateNm[4]+"</td><td class='left'><a href='"+srcUrl+"' target=_blank>"+srcUrl+"</a></td>";
								if(mergeCnt < 5) mergeCnt = 5;
							}
							if(cateNm.length == 6){
								inHtml += "<td>"+cateNm[1]+"</td><td>"+cateNm[2]+"</td><td>"+cateNm[3]+"</td><td>"+cateNm[4]+">"+cateNm[5]+"</td><td class='left'><a href='"+srcUrl+"' target=_blank>"+srcUrl+"</a></td>";
							}
						}
						inHtml += "</tr>";
						$("#sitemapMenu>tbody").append(inHtml);
					}
				}
				// 테이블 그린 뒤 rowMerge 한다.
				for (var z=1; z < mergeCnt; z++){
					rowSpan("sitemapMenu", z);
				}
				// 검색 문자열 찾아서 표시한다.
				var searchKey = $("#schInputVal").val();
				if(searchKey != ""){
					$("#sitemapMenu tbody td").each(function() {
						var titTxt = $(this).text();
						var dataReplace = "";
						if(titTxt.indexOf("http") != -1){
							dataReplace = "<a href='"+titTxt+"' target=_blank>";
							dataReplace += $(this).text().replaceAll(searchKey,"<font style='color:#f90444;font-size:medium;'>"+searchKey+"</font>");
							dataReplace += "</a>";
						}else{
							dataReplace = $(this).text().replaceAll(searchKey,"<font style='color:#f90444;font-size:medium;'>"+searchKey+"</font>");
						}
						$(this).html(dataReplace);					
					});
				}
			}
		}
	});
	*/
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
			obj.attr("aria-selected", true).attr("title", "선택됨");	// 2021.11.10 - 웹접근성 처리;
		}
		else {
			$("#btnOrgAll").removeClass("on");
			$("#btnOrgAll").attr("aria-selected", false).attr("title", "");	// 2021.11.10 - 웹접근성 처리;
			obj.toggleClass("on");
			
			if ( obj.hasClass("on") ) {
				obj.attr("aria-selected", true).attr("title", "선택됨");	// 2021.11.10 - 웹접근성 처리;	
				addInputHidden({
					formId: "searchForm",
					objId: "schHdnOrgCd",
					val: gubun
				});
			}
			else {
				$("input[name=schHdnOrgCd][value="+gubun+"]").remove();
				obj.attr("aria-selected", false).attr("title", "");	// 2021.11.10 - 웹접근성 처리;
			}
			
			// 분류가 전체선택될경우, 전부 선택풀었을경우 전체버튼 선택해준다.
			if ( $("button[id^=btnOrgCd]").length == $("button[id^=btnOrgCd][class=on]").length
					|| $("button[id^=btnOrgCd][class=on]").length == 0 ) {
				$("button[id^=btnOrgCd]").attr("aria-selected", false).attr("title", "");	// 2021.11.10 - 웹접근성 처리;
				$("#btnOrgAll").click();
			}
		}
		
		var searchKeyword = $("#schInputVal").val();
		// 선택시 바로 조회
		if(searchKeyword == ""){
			loadSiteMapList();
		}else{
			searchSiteMapList();
		}
		
	}
}

/**
 * 폼에 히든파라미터 등록
 */
function addInputHidden(options) {
	options.formId = options.formId || "";	// 폼 ID
	options.objId = options.objId || "";	// 오브젝트 ID
	
	if ( com.wise.util.isBlank(options.formId) || com.wise.util.isBlank(options.objId) )	return;
	
	var input = $("<input type=\"hidden\">");
	input.attr("id", options.objId).attr("name", options.objId).val(options.val);
	
	$("#" + options.formId).append(input);
}

////////////////////////////////////////////////////////////////////////////////
//열을 병합
////////////////////////////////////////////////////////////////////////////////
function rowSpan(tableId, colIdx){
	
	$('#'+tableId).each(function() {
		var table = this;

		var chk1Tds = $('>tbody>tr>td:nth-child(1)', table).toArray();
		var chk2Tds = $('>tbody>tr>td:nth-child(2)', table).toArray();

		if(colIdx == 1){ //첫번째 row는 그냥 데이터값에 따라 합쳐준다.
			$.each([colIdx] /* 합칠 칸 번호 */, function(c, v) {
				var tds = $('>tbody>tr>td:nth-child(' + v + ')', table).toArray(), i = 0, j = 0;
				for(j = 1; j < tds.length; j ++) {
					if(tds[i].innerHTML != tds[j].innerHTML) {
						$(tds[i]).attr('rowspan', j - i);
						i = j;
						continue;
					}
					$(tds[j]).hide();
				}
				j --;
				if(tds[i].innerHTML == tds[j].innerHTML) {
					$(tds[i]).attr('rowspan', j - i + 1);
				}
			});
		}
		
		if(colIdx == 2){ //두번째, 세번째 row는 데이터값을 확인한다.
			var tdsHtmlArray = new Array();
			
			$.each([colIdx] /* 합칠 칸 번호 */, function(c, v) {
				var tdf = $('>tbody>tr>td:nth-child(1)', table).toArray(), i = 0, j = 0;
				var tds = $('>tbody>tr>td:nth-child(' + v + ')', table).toArray(), i = 0, j = 0;
				
				for(x = 1; x < tds.length; x ++) {
					tdsHtmlArray.push(tds[x].innerHTML);
				}
				var uniqHtmlArray = tdsHtmlArray.reduce(function(a, b){ if(a.indexOf(b) < 0) a.push(b); return a;},[]);

				if(uniqHtmlArray.length == 1){
					copySpan(tableId, colIdx, "1");
				}else{
					for(j = 1; j < tds.length; j ++) {

						if(tdf[i].innerHTML != tdf[j].innerHTML || tds[i].innerHTML != tds[j].innerHTML) {
							$(tds[i]).attr('rowspan', j - i);
							i = j;
							continue;
						}
						$(tds[j]).hide();
					}
					j --;
					if(tdf[i].innerHTML == tdf[j].innerHTML) {
						if(tds[i].innerHTML == tds[j].innerHTML) {
							$(tds[i]).attr('rowspan', j - i + 1);
						}
					}
				}
			});
		}

	});
	
	function copySpan(tableId, colIdx, cpIdx){
		$('#'+tableId).each(function() {
			var table = this;

				$.each([colIdx] /* 합칠 칸 번호 */, function(c, v) {
					var tgTds = $('>tbody>tr>td:nth-child('+ cpIdx +')', table).toArray();
					var tds = $('>tbody>tr>td:nth-child(' + v + ')', table).toArray();
					for(var i=0; i<tgTds.length; i ++) {
						if($(tgTds[i]).attr('rowspan') != undefined){
							$(tds[i]).attr('rowspan', $(tgTds[i]).attr('rowspan'));
						}else{
							$(tds[i]).hide();
						}
					}
				});

		});
	}
}


/**
 * 검색 목록을 조회한다.
 * @param page	페이지
 * @returns
 */
function searchSiteMapList() {
	
	doSearch({
		url : "/portal/nadata/sitemap/searchSiteMapList.do",
		before : beforeSearchSiteMapList,
		after : afterSearchSiteMapList
	});
}

/**
 * 검색 목록 조회 전처리
 */
function beforeSearchSiteMapList(options) {
	var form = $("#searchForm");
	
	var data = form.serializeObject();
	
	return data;
}

/**
 * 검색 목록 조회 후처리
 * @param datas
 * @returns
 */
function afterSearchSiteMapList(datas) {
	var searchKeyword = $("#schInputVal").val();
	$("#result_search_sitemap").empty();
	$("#result_search_sitemap").append("<p class='word-search-result'></p>");
	
	$(".word-search-result").html("‘"+searchKeyword+"’(으)로 검색한 결과가 <span>총 "+datas.length+"건</span>이 존재합니다.");
	
	if ( datas.length > 0 ) {
		var topCateId = "";
		var homeCnt = 0;
		var homeHtml = "";
		var menuHtml = "";
		$.each(datas, function(key, value){
			
			
			if(topCateId != value.topCateId){
				if(topCateId != ""){
					$("#cnt_"+topCateId).text(homeCnt);
				}
				homeCnt = 1;
				
				topCateId = value.topCateId;
				
				homeHtml  = "<div class='board-area'>";
				homeHtml += "		<div class='contents-box'>";
				homeHtml += "			<div class='board-top-information totalsearch clear'>";
				homeHtml += "				<p class='total type02'>";
				homeHtml += "					"+value.topCateNm+" (<strong class='point-color09 single-count-sect' style='vertical-align: top;' id='cnt_"+value.topCateId+"'></strong>건)";
				homeHtml += "				</p>";
				homeHtml += "				<div class='btns-wrapper'><a href='"+value.topSrcUrl+"' class='btn-s03 btns-color08' target=_blank>사이트 바로가기</a></div>";
				homeHtml += "			</div>";
				homeHtml += "			<div class='board-list01' id='menu_"+value.topCateId+"'>";
				homeHtml += "				<table style='width: 100%'>";
				homeHtml += "					<tbody>";
				homeHtml += "						<tr>";
				homeHtml += "							<th style='width: 10%'>관리기관</th><td style='width: 15%'>"+value.orgNm+"</td>";
				homeHtml += "							<th style='width: 15%'>주요 제공 서비스</th><td style='width: 60%'>"+value.topInfoSmryExp+"</td>";
				homeHtml += "						</tr>";
				homeHtml += "					</tbody>";
				homeHtml += "				</table>";
				homeHtml += "			</div>";
				homeHtml += "		</div>";
				homeHtml += "	</div>";
				homeHtml += "<div class='result_more_btn'>";
				homeHtml += "	<a href='javascript:;' class='btn_more' id='btn_more_"+topCateId+"' style='display:none;'>더보기</a>";
				homeHtml += "</div>";
				
				$("#result_search_sitemap").append(homeHtml);
				
				if(homeCnt > 10) {
					menuHtml  = "				<article name='tg_view' style='display:none;'>";
				} else {
					menuHtml  = "				<article>";
				}
				
				menuHtml += "					<div class='ysearch_result_01'>"+value.cateFullnm+"</div>";
				menuHtml += "					<div class='ysearch_result_02'>";
				menuHtml += "						<a href='"+value.srcUrl+"' target='_blank'>"+value.srvmNm+"</a>";
				menuHtml += "					</div>";
				if(value.infoSmryExp != null){
				menuHtml += "					"+value.infoSmryExp+"";
				}
				menuHtml += "					<a href='"+value.srcUrl+"' target='_blank' class='ysearch_result_03'>";
				menuHtml += "					<p>URL : "+value.srcUrl+"</p>";
				menuHtml += "				</a>";
				menuHtml += "				</article>";
				
				$("#menu_"+topCateId).append(menuHtml);
            
			} else {
				homeCnt++;
				
				if(homeCnt > 10) {
					menuHtml  = "				<article name='tg_view' style='display:none;'>";
					$("#btn_more_"+topCateId).css("display","block");
				} else {
					menuHtml  = "				<article>";
				}
				
				menuHtml += "					<div class='ysearch_result_01'>"+value.cateFullnm+"</div>";
				menuHtml += "					<div class='ysearch_result_02'>";
				menuHtml += "						<a href='"+value.srcUrl+"' target='_blank'>"+value.srvmNm+"</a>";
				menuHtml += "					</div>";
				if(value.infoSmryExp != null){
				menuHtml += "					"+value.infoSmryExp+"";
				}
				menuHtml += "					<a href='"+value.srcUrl+"' target='_blank' class='ysearch_result_03'>";
				menuHtml += "					<p>URL : "+value.srcUrl+"</p>";
				menuHtml += "				</a>";
				menuHtml += "				</article>";
				
				$("#menu_"+topCateId).append(menuHtml);
				
			}

		});
		
		$("#cnt_"+topCateId).text(homeCnt);
		
		// 검색 문자열 찾아서 표시한다.
		if(searchKeyword != ""){
			$(".ysearch_result_01").each(function() {
				var titTxt = $(this).text();
				var dataReplace = $(this).text().replace(new RegExp(searchKeyword,'gi'),"<span>"+searchKeyword+"</span>");
				$(this).html(dataReplace);					
			});
			
			$(".ysearch_result_02 a").each(function() {
				var titTxt = $(this).text();
				var dataReplace = $(this).text().replace(new RegExp(searchKeyword,'gi'),"<span>"+searchKeyword+"</span>");
				$(this).html(dataReplace);					
			});
			
			$(".ysearch_result_03").each(function() {
				var titTxt = $(this).text();
				var dataReplace = $(this).text().replace(new RegExp(searchKeyword,'gi'),"<span>"+searchKeyword+"</span>");
				$(this).html(dataReplace);					
			});
		}
		
	}
	
	//더보기 버튼
	$("a[id^=btn_more]").each(function() {
		$(this).bind("click", function(event) {
			var btnId = this.id;
			var topCateId = btnId.replace("btn_more_","");
			if($(this).text() == "더보기") {
				$("#menu_"+topCateId).find("article[name=tg_view]").css("display","block");
				$(this).text("닫기");
			} else {
				$("#menu_"+topCateId).find("article[name=tg_view]").css("display","none");
				$(this).text("더보기");
			}
			return false;
		});
	});
	
}