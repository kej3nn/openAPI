/*
 * COPYRIGHT (C) 2013 WISEITECH CO., LTD. ALL RIGHTS RESERVED.
 */

/**
	장홍식
 */
$(function() {
	
    bindEvent();

    loadData();
    
});

//////////////////////////////////////////////////////////
//////////////// global /////////////////////////////
/////////////////////////////////////////////////////////

var templates = [
                 	"<a></a> "
                 	, "<td><div><strong></strong></div></td>"
                 	, "<th scope=\"col\"></th>"
                 ];

function bindEvent() {
	
}

function loadData() {
	
	selectChatData();
	
}

//////////////////////////////////////////////////////////
/////////////////// 조회 서비스 //////////////////////
/////////////////////////////////////////////////////////
// 데이터 조회
function selectChatData() {
    // 데이터를 조회한다.
    doSelect({
        url:"/portal/intro/stats/selectStatsData.do",
        before:function () {return {};},
        after:afterSelectChart
    });
}

/////////////////////////////////////////////////
///////////////// 후처리 함수 ////////////////
////////////////////////////////////////////////

function afterSelectChart(data) {
	var result_stats = data.stats;
//	$('#result-stats-0').text(result_stats.infCnt);		// 개방 시스템 수
	$('#result-stats-1').text(result_stats.dsCnt);		// 데이터셋 수
	$('#result-stats-2').text(result_stats.srvCnt);		// 서비스 수
	$('#result-stats-3').text(result_stats.orgCnt);		// 제공 기관 수
	$('#result-stats-4').text(result_stats.statTblCnt);		// 통계표 수
	
	var cateMaxValue = 0;					// 분류별 최대값
	var srvMaxValue = 0;					// 서비스별 최대값
	$.each(data.listBycate, function(i, d) {
		if(d.cnt > cateMaxValue) {
			cateMaxValue = d.cnt;
		}
	});
	$.each(data.listBySrv, function(i, d) {
		if(d.cnt > srvMaxValue) {
			srvMaxValue = d.cnt;
		}
	});
	
	// 분류별 통계
	$.each(data.listBycate, function(i, d) {
		var tmpl0 = $(templates[0]);
		//tmpl0.addClass(getCategoryClass(d.cateId)).html(d.cateNm+"<strong>("+d.cnt+")</strong>");
		tmpl0.addClass("sort_" + String(i+1))
			.css("background-image", "url(/portal/data/dataset/selectThumbnail.do?cateSaveFileNm="+ d.cateSaveFileNm +")")
			.html(d.cateNm+"<strong>("+d.cnt+")</strong>");
		
		tmpl0.css("cursor", "pointer");
		tmpl0.css("text-align", "center");
		
		tmpl0.attr({
			href:"#"
		});
		
		tmpl0.bind("click", function() {
			searchDataset("cateId", d.cateId);
		});
		$('#sort-stats-0').append(tmpl0);
		
		var tmpl1 = $(templates[1]);
		tmpl1.find('div').css('height', ((d.cnt*100)/cateMaxValue)+'%').find('strong').text("("+d.cnt+")");
		$('#sort-stats-1').append(tmpl1);

		var tmpl2 = $(templates[2]);
		tmpl2.text(d.cateNm);
		$('#sort-stats-2').append(tmpl2);
	});
	
	// 서비스 유형별 통계
	var cateNmList = {
						"S":"SHEET"
						, "C":"CHART"
						, "M":"MAP"
						, "F":"FILE"
						, "A":"API"
						, "L":"LINK"
						, "T":"통계표"
					};
	$.each(data.listBySrv, function(i, d) {
		var tmpl0 = $(templates[0]);
		tmpl0.addClass("type_"+(i+1));
		//tmpl0.addClass(getServiceClass(d.cateId)).html(cateNmList[d.srvCd]+"<strong>("+d.cnt+")</strong>");
		tmpl0.addClass(getServiceClass(d.cateId)).html(cateNmList[d.srvCd]+"<strong>("+d.cnt+")</strong>");
		tmpl0.css("cursor", "pointer");
		tmpl0.css("text-align", "center");
		tmpl0.attr({
			href:"#"
		});
		tmpl0.bind("click", function() {
			if(i < data.listBySrv.length -1) {
				searchDataset("srvCd", d.srvCd);
			} else {
				//location.href = com.wise.help.url("/portal/data/multimedia/searchMultimediaPage.do");
				location.href = com.wise.help.url("/portal/stat/easyStatSch.do");
			}
		});
		$('#type-stats-0').append(tmpl0);

		var tmpl1 = $(templates[1]);
		tmpl1.find('div').css('height', ((d.cnt*100)/srvMaxValue)+'%').find('strong').text("("+d.cnt+")");
		$('#type-stats-1').append(tmpl1);

		var tmpl2 = $(templates[2]);
		tmpl2.text(cateNmList[d.srvCd]);
		$('#type-stats-2').append(tmpl2);
	});
}


//////////////////////////////////////////////////////////



/**
 * 공공데이터 데이터셋 카테고리 클래스를 반환한다.
 * 
 * @param code {String} 코드
 * @returns {String} 경로
 */
function getCategoryClass(code) {
    var clazz = "";
    
    switch (code) {
        case "GG01":
            clazz = "sort_1";
            break;
        case "GG05":
            clazz = "sort_2";
            break;
        case "GG09":
            clazz = "sort_3";
            break;
        case "GG13":
            clazz = "sort_4";
            break;
        case "GG16":
            clazz = "sort_5";
            break;
        case "GG20":
            clazz = "sort_6";
            break;
        case "GG23":
            clazz = "sort_7";
            break;
        case "GG26":
            clazz = "sort_8";
            break;
        case "GG29":
            clazz = "sort_9";
            break;
    }
    
    return clazz;
}

function getServiceClass(srvCd) {
	var clazz = "";

    switch (srvCd) {
	    case "S":
	    	clazz = "type_1";
	    	break;
	    case "C":
	    	clazz = "type_2";
	    	break;
	    case "M":
	    	clazz = "type_3";
	    	break;
	    case "F":
	    	clazz = "type_4";
	    	break;
	    case "A":
	    	clazz = "type_5";
	    	break;
	    case "L":
	    	clazz = "type_6";
	    	break;
    }
    return clazz;
}

function searchDataset(name, value) {
	$('#datasts-search-form').empty();
	if("cateId" == name) {
		$('#datasts-search-form').html('<input type="hidden" name="cateId" value=""/>');
	} else {
		$('#datasts-search-form').html('<input type="hidden" name="srvCd" value=""/>');
	}
	// 데이터를 검색하는 화면으로 이동한다.
	goSearch({
	    url:"/portal/data/dataset/searchDatasetPage.do",
	    form:"datasts-search-form",
	    data:[{
	        name:name,
	        value:value
	    }]
	});
}