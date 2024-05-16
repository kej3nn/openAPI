/***
 * 마이페이지 - 검색연혁 및 추천정보
 * @author 	jhkim
 * @since	2019/11/28
 */

$(function() {
	
	// 검색로그 조회
	searchSearchHisData(1);
	
});

/**
 * 유저별 검색로그 조회
 * @param page	페이지번호
 * @returns
 */
function searchSearchHisData(page) {
	page = page || 1;
	doSearch({
		url : "/portal/myPage/searchSearchHisData.do",
		page : page,
		before : beforeSearchSearchHisData,
		after : afterSearchSearchHisData,
		pager : "search-pager-sect"
	});
}
function beforeSearchSearchHisData(options) {
	var form = $("#searchForm");
	
	if (com.wise.util.isEmpty(options.page)) {
		form.find("[name=page]").val("1");
	} 
	else {
		form.find("[name=page]").val(options.page);
	}
	
	return form.serializeObject();
}
function afterSearchSearchHisData(datas) {
	var row = null,
		data = null,
		list = $("#search-list-sect"),
		item = 
			"<tr>" +
			"	<td class=\"center\"><a href=\"javascript:;\" class=\"searchStr\"></a></td>" +
			"	<td class=\"regDttm center\"></td>" +
			"</tr>";
	
	list.empty();
	
	if ( datas.length > 0 ) {
		
		for ( var i in datas ) {
			data = datas[i];
			
			row = $(item);
			
			row.find(".searchStr").text(data.searchStr)
				.bind("click", {query: data.searchStr }, function(e) {
					searchTotalSearchCloud(e.data.query);
					return false;
				});
			
			row.find(".regDttm").text(data.regDttm);
			
			list.append(row);
		}
	}
	else {
		row = $(item);
		list.append("<tr><td colspan=\""+ (row.find("td").length) +"\">조회된 데이터가 없습니다.</td></tr>");
	}
}

/**
 * 연관검색어 조회
 * @param query	검색어
 * @returns
 */
function searchTotalSearchCloud(query) {
	
	var sect = $("#rel-list-sect");
	
	sect.empty();
	
	doAjax({
		url: "/portal/search/getGroup.do",
		params: "query=" + query,
		callback: function(res) { 
			
			if ( res != null && res.terms && res.terms.length > 0 ) {
				
				var datas = res.terms;
				
				_.forEach(datas, function(data, i) {
					var row = $("<li><a href=\"javascript:;\">"+ data.key +"</a></li>");
					row.find("a").bind("click", {query: data.key}, function(e) {
						var hdnSchForm = $("#hidden-search-form");
						var popTitle = "searchPopOpener";
						// 선택시 통합검색 팝업창 로드
						window.open("", popTitle);
						
						hdnSchForm.find("input[name=query]").val(e.data.query);
						hdnSchForm.attr("target", popTitle);
						hdnSchForm.submit();
					});
					
					sect.append(row);
				});
			}
			else {
				var row = $("<li class=\"center\">조회된 데이터가 없습니다.</li>");
				sect.append(row);
			}
		}
	});
}
