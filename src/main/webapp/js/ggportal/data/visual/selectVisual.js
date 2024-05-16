$(function() {
    // 이벤트를 바인딩한다.
    bindEvent();
    
    // 데이터를 로드한다.
    loadData();
});

////////////////////////////////////////
//////// global ///////////
/////////////////////////////////
// 조건 필터
var filter;

/**
 * 이벤트를 바인딩한다.
 */
function bindEvent() {
	
	// 목록 버튼에 키다운 이벤트를 바인딩한다.
    $("#visual-search-btn").bind("keydown", function(event) {
        if (event.which == 13) {
            // 게시판 내용을 검색한다.
            searchVisual($("#visual-search-form [name=page]").val());
            return false;
        }
    });
    
    // 목록 버튼에 클릭 이벤트를 바인딩한다.
    $("#visual-search-btn").bind("click", function(event) {
        // 갤러리 게시판 내용을 검색한다.
    	searchVisual($("#visual-search-form [name=page]").val());
        return false;
    });

}

/**
 * 데이터를 로드한다.
 */
function loadData() {
    // 게시판 내용을 조회한다.
    selectVisual();
}

////////////////////////////////////////////////////////////////////////////////
//서비스 함수
////////////////////////////////////////////////////////////////////////////////
/**
* 게시판 내용을 조회한다.
*/
function selectVisual() {
	// 데이터를 조회한다.
	doSelect({
		url:"/portal/data/visual/selectVisualData.do",
		before:beforeSelectVisual,
		after:afterSelectVisual
	});
}

/**
 * 목록으로 이동한다.
 */
function searchVisual(page) {
    // 데이터를 검색하는 화면으로 이동한다.
    goSearch({
        url:"/portal/data/visual/searchVisualMainPage.do",
        form:"visual-search-form",
        data:[{
            name:"page",
            value:page ? page : "1"
        }]
    });
}

/**
 * 데이터셋 화면으로 이동한다.
 * 
 * @param data {Object} 데이터
 */
function selectDataset() {
    // 데이터를 조회하는 화면으로 이동한다.
    goSelect({
        url:"/portal/data/service/selectServicePage.do",
        form:"dataset-select-form"/*,
        data:[{
            name:"infId",
            value:data.infId
        }, {
            name:"infSeq",
            value:data.infSeq
        }]*/
    });
}

////////////////////////////////////////////////////////////////////////////////
//전처리 함수
////////////////////////////////////////////////////////////////////////////////

/**
 *  게시판 내용 조회 전처리를 실행한다.
 * 
 * @param options {Object} 옵션
 * @returns {Object} 데이터
 */
function beforeSelectVisual(options) {
    var data = {
        // Nothing do do.
    };
    
    var form = $("#visual-search-form");
    
    $.each(form.serializeArray(), function(index, element) {
        switch (element.name) {
            case "page":
            case "rows":
                break;
            default:
                data[element.name] = element.value;
                break;
        }
    });
    
    if (com.wise.util.isBlank(data.vistnSrvSeq)) {
        return null;
    }
    
    return data;
}

////////////////////////////////////////////////////////////////////////////////
//후처리 함수
////////////////////////////////////////////////////////////////////////////////
/**
 * 게시판 내용 조회 후처리를 실행한다.
 * 
 * @param data {Object} 데이터
 */
function afterSelectVisual(data) {
    var form = $("#visual-select-form");

    form.find("[name=vistnSrvSeq]").val(data.vistnSrvSeq);
    
    form.find(".visualNm").append(data.vistnNm);
        
    form.find(".visualCont").text(data.vistnSrvDesc);
    
    form.find(".userNm").text(data.prdNm);
    form.find(".userDttm").text(data.regDttm);
    form.find(".visualType").text(data.vistnTyNm);
    
    // 인포그래픽인 경우 구조를 갈아엎는다.
    if($('#visual-search-form [name=vistnCd]').val() == 'I') {
    	form.empty();
    	form.html("<div id=\"chart_dataVisualization\"></div>");
    }
    
    // 조건 필터
    filter = [
              {name : data.filt1Nm, value : data.filt1Val}
              , {name : data.filt2Nm, value : data.filt2Val}
              , {name : data.filt3Nm, value : data.filt3Val}
              ];

    // html 5 미지원 차트 url 목록
    var noHtml5Arr = [
                      	// ---- 차트 ----
                      	"/portal/data/visual/selectListPublsvntHBChart.do"		// 공무원 현황 Hierarical Bar Chart
                      	, "/portal/data/visual/selectListPublsvntCPChart.do"		// 공무원 현황 Circle packing
                      	, "/portal/data/visual/selectListBudgetTreemap.do"		// 예산 현황 Tree map
                      	, "/portal/data/visual/selectListHedofcLocalMeta.do"		// 경기도 부분 예산 메타Tree map
                      	, "/portal/data/visual/selectDeathCause.do"					// 사망 원인별 사망 Heat map
                      	, "/portal/data/visual/selectHouseForm.do"					// 주택점유형태별 가구 heat map
                      	, "/portal/data/visual/selectListLocalTax.do"					// 지방세 징수 현황 Zoomable Sunburst
                      	, "/portal/data/visual/selectListPopltnTreeMap.do"		// 시군별 인구현황 추이 내/외국인 남녀 Tree map
                      	// ---- 인포그래픽 ----
                      	, "/portal/data/visual/selectInfographicTapwaterPrice2.do"		// 상수도 통계
                      	, "/portal/data/visual/selectInfographicFinance.do"				// 재정 자립도
                      	, "/portal/data/visual/selectInfographicSocialWelfareBudget.do"	// 예산 대비 사회복지비중 경기도 인포그래픽
                      ];
    
    var ieVerText = "IE 9.0 이상";
    var noHtml5Flag = false;
    $.each(noHtml5Arr, function(i, d) {
    	if(d == data.vistnUrl) {
    		noHtml5Flag = true;
    		return;
    	}
    });
    
    // ie 10 부터 지원
    var ie10UpArr = [
//                     "/portal/data/visual/selectDeathCause.do" // 사망원인별 사망
//                     , "/portal/data/visual/selectHouseForm.do" // 주택점유형태별 일반가구
                     ];
    var ie10UpFlag = false;
    $.each(ie10UpArr, function(i, d) {
    	if(d == data.vistnUrl) {
    		ie10UpFlag = true;
    		ieVerText = "IE 10.0 이상";
    		return;
    	}
    });
    
    
	// html5를 지원하지 않는 URL 이고 IE 브라우저 이며 9버전 미만인 경우
    if((noHtml5Flag && getBrowserType() == "IEold") || (ie10UpFlag && getBrowserType() == "IE9")) {
       	var template = 
   				'<div id="noHtml5">'                 
   				+'	<div class="back2"></div>'                 
   				+'	<div class="backBox2">'
   				+'		<img src="'+ com.wise.help.url("/img/ggportal/desktop/data/no_html5.jpg")+'" alt="HTML5 지원 안함" /><br/>'
   				+'		본 데이터 시각화 차트는 최신 기술인 HTML5로 제작되어<br/>'
   				+'		<a href="http://windows.microsoft.com/ko-kr/internet-explorer/download-ie" target="_new">'+ieVerText+'</a>,'
   				+'		<a href="http://www.google.com/chrome" target="_new">Chrome</a>,'
   				+'		<a href="http://www.mozilla.org/ko/firefox/" target="_new">Firefox</a>,'
   				+'		<a href="http://www.apple.com/kr/safari/" target="_new">Safari</a> 등의 브라우저에서만 조회됩니다.<br/><br/>'
   				+'	</div>'
   				+'</div>';
       	$("#chart_dataVisualization").html(template);
    } else {
	    // iframe 으로 열어야되는 차트 url 목록
	    var iframeUrlArr = [
	                        {path:"/portal/data/visual/selectBudgetMotionChart.do", style : "min-height:530px;"}		// 예산 현황 Motion Chart
	                        , {path:"/portal/data/visual/selectListPopltnMotionChart.do", style : "min-height:530px;"}		// 인구 현황 Motion Chart
	                      ];
	    
	    var iframeFlag = false;
	    var style = "";
	    $.each(iframeUrlArr, function(i, d) {
	    	if(d.path == data.vistnUrl) {
	    		style = d.style;
	    		iframeFlag = true;
	    		return;
	    	}
	    });
	    var url = com.wise.help.url(data.vistnUrl+"?"+filter[0].name+"="+filter[0].value+"&"+filter[1].name+"="+filter[1].value+"&"+filter[2].name+"="+filter[2].value);
	    // iframe 으로 열어야되는 경우
	    if(iframeFlag) {
	    	// 사파리는 플래시 미지원
//	    	if(getBrowserType() == "Safari") {
//	    		var template = 
//	   				'<div id="noHtml5">'                 
//	   				+'	<div class="back2"></div>'                 
//	   				+'	<div class="backBox2">'
//	   				+'		사파리에서는 Flash 를 조회 할수 없습니다.<br/>'
//	   				+'		<a href="http://windows.microsoft.com/ko-kr/internet-explorer/download-ie" target="_new">IE 9.0 이상</a>,'
//	   				+'		<a href="http://www.google.com/chrome" target="_new">Chrome</a>,'
//	   				+'		<a href="http://www.mozilla.org/ko/firefox/" target="_new">Firefox</a>등의 브라우저에서만 조회됩니다.<br/><br/>'
//	   				+'	</div>'
//	   				+'</div>';
//	           	$("#chart_dataVisualization").html(template);
//	    	} else {
		    	var temp = "<iframe src=\""+url+"\" scrolling=\"no\" frameborder=0 style=\"width:980px; "+style +"\"></iframe>";
		    	$("#chart_dataVisualization").html(temp);
//	    	}
	    } else {
		    $("#chart_dataVisualization").load(url);
	    }
	    
	    if(data.infId) {
	    	var dataSetForm = $('#dataset-select-form');
	    	dataSetForm.find("[name=infId]").val(data.infId);
	    	dataSetForm.find("[name=infSeq]").val(data.trnSrvCd);
	    	
	    	var btn = $('#visual-dataset-btn');
	    	btn.show();
	        // 상세데이터보기 버튼에 클릭 이벤트
	    	btn.bind("click", function(event) {
	    		selectDataset();
	            return false;
	        });
	    }
    }
}

function getBrowserType(){
    
    var _ua = navigator.userAgent;
    var rv = -1;
     
    //IE 11,10,9,8
    var trident = _ua.match(/Trident\/(\d.\d)/i);
    if( trident != null )
    {
        if( trident[1] == "7.0" ) return rv = "IE";
        if( trident[1] == "6.0" ) return rv = "IE";
        if( trident[1] == "5.0" ) return rv = "IE9";
        if( trident[1] == "4.0" ) return rv = "IEold";
    }
     
    //IE 7...
    if( navigator.appName == 'Microsoft Internet Explorer' ) return rv = "IEold";
     
    //other
    var agt = _ua.toLowerCase();
    if (agt.indexOf("chrome") != -1) return 'Chrome';
    if (agt.indexOf("opera") != -1) return 'Opera'; 
    if (agt.indexOf("staroffice") != -1) return 'Star Office'; 
    if (agt.indexOf("webtv") != -1) return 'WebTV'; 
    if (agt.indexOf("beonex") != -1) return 'Beonex'; 
    if (agt.indexOf("chimera") != -1) return 'Chimera'; 
    if (agt.indexOf("netpositive") != -1) return 'NetPositive'; 
    if (agt.indexOf("phoenix") != -1) return 'Phoenix'; 
    if (agt.indexOf("firefox") != -1) return 'Firefox'; 
    if (agt.indexOf("safari") != -1) return 'Safari'; 
    if (agt.indexOf("skipstone") != -1) return 'SkipStone'; 
    if (agt.indexOf("netscape") != -1) return 'Netscape'; 
    if (agt.indexOf("mozilla/5.0") != -1) return 'Mozilla';
}