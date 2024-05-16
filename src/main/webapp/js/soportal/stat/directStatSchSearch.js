/*
 * @(#)directStatSchSearch.js 1.0 2018/06/25
 * 
 */
/**
 * 통계조회 및 조회 전/후처리 스크립트 파일이다.
 * 
 * @author 김정호
 * @version 1.0 2018/06/25
 */

////////////////////////////////////////////////////////////////////////////////
// 통계 조회 전/후 처리
////////////////////////////////////////////////////////////////////////////////
/**
 * 메인리스트에서 통계표 선택시 항목, 분류 및 검색주기, 검색기간 세팅 
 */
function selStat(sId) {
	
	$("#sId").val(sId);
	
	selectCycle();
	
	return true;
}

/**
 * 통계표 선택시 통계정보 호출(메인화면에서 통계표 선택시 호출됨)
 */

function selectCycle() {
	var params = {statblId : $("#sId").val(), metaCallYn : "Y", langGb : $("#langGb").val()};
	doAjax({
		url : "/portal/stat/selectEasyStatDtl.do",
		params : params,
		callback : afterStatsCycle
	});

	//return true;
}
/**
 * 선택 통계정보 확인 후 처리함수
 */

function afterStatsCycle(res) {
	var data = res.data;
	
	$('#contTitle').text(data.DATA.statblNm);
	$(".txt.cmmtIdtfr").text(gfn_isNull(data.DATA.cmmtIdtfr) ? "" : data.DATA.cmmtIdtfr);
	$('#stat_make').text("자료  : " + data.DATA.orgNm);
	
	$(".rightCont").show();
	$("#contTab li").hide().removeClass("on");	// right영역 탭 전체 숨김
	$(".content_inner div[id$=-sect]").hide();
	
	$("[name=chartType], [name=chartStockType]").val("");	// 차트 변수 초기화1
	$("[name=chart23Type]").val("2D");	// 차트 변수 초기화2
	
	// 분류체계 전체경로
	var cateFullNm = data.DATA.cateFullnm.split(">");
	$(".tab_location ul").empty();
	for ( var i=0; i < cateFullNm.length; i++ ) {
		$(".tab_location ul").append("<li><span>"+ cateFullNm[i] +"</span></li>");
	}
    
	if(data.DATA.CTS_SRV_CD == 'N'){ 
		
		// 통계표, 그래프 탭 보여준다.
		$("#tab_A_G").show().addClass("on");	
		$("#tab_A_S").show();
		
		$("#graph-sect, #statTbl-sect").show();
		
		$("#fileSelect, #fileDownload").hide();	// 컨텐츠 파일 숨김
		
		// 주석 로드
		setCmmtData(data.DATA2.CMMT_DATA, data.META_DATA);
		
		// 상세분석
		$("#detailAnalysis").attr("href", "javascript:goStatsUrl('"+ $("#sId").val() +"');");
		
		// 시트 및 차트 로드
		$.when(statSheetCreate(),
				directStatChart($("#sId").val(), "statChart")).done(
				function(r1, r2) {
					hideLoading();
				});
		
		// 지도 탭 버튼을 노출한다.
		if(data.DATA.MAP_SRV_CD == "KOREA" || data.DATA.MAP_SRV_CD == "WORLD") {
			$(".tabSt").find("a[title=Map]").parents("li").show();
		} 
		else {
			$(".tabSt").find("a[title=Map]").parents("li").hide();
		}	
		$(".areaDv").find("input[name=tabMapVal]").val(data.DATA.MAP_SRV_CD);
		
		$('.tabSt li').eq(0).click();	// 그래프 탭 보여준다.(맵화면 보고있는 상태에서 다른 통계표 선택시)
				
		// 통계게시판 데이터로드
		setContBbsTbl(data.DATA);
		
	}else{
		
		// 통계 컨텐츠 + 통계게시판 데이터로드
		var funcContents = function() {
			var deferred = $.Deferred();
			try {
				setContents(data.DATA)
				deferred.resolve(true);
			} catch (err) {
				deferred.reject(false);
			}
			return deferred.promise();
		};
		
		funcContents().done(function(message) {
			hideLoading();
		}).always(function() {
			hideLoading();
		});
	}
	
	// left 트리와 right 컨텐츠 박스와 동일하게 height 세팅
	setTimeout(function() {
		$("#leftTreeBox").css("height", $(".rightCont .content_body").height());
	}, 500);
	
	// 통계표 열람 확인 로그 남김
	insertStatLogs({statblId: $("#sId").val()});
	
}

// 주석 로드
function setCmmtData(cmmtData, metaData) {
	var source = "";
	var cmmtEle = "";
	
	if ( cmmtData.length > 0 ) {
		var cmmtSect = $(".conComment");
		
		cmmtSect.find(".source, .cmmt").empty();
		
		$.each(cmmtData, function(key, value) {
			if (value.cmmtGubun == "TBL") {
				cmmtEle += "<br><span style='color: blue; font-weight:bold;'>" + (gfn_isNull(value.cmmtIdtfr) ? "" : value.cmmtIdtfr) + "</span>" + openRealceAll(value.cmmtCont, "\n","<br/>");
			} 
			else {
				cmmtEle += "<br><span style='color: blue; font-weight:bold;'>"+ (gfn_isNull(value.cmmtIdtfr) ? "" : value.cmmtIdtfr) + "</span> "+ openRealceAll(value.cmmtCont, "\n","<br/>") ;
			}
		});
		cmmtSect.show().find(".cmmt").append(cmmtEle);
		cmmtSect.find(".cmmt > br").first().remove();
		/* 자료출처 요청에 의해 제거(통계표주석으로 표시함)
		// 주석 자료출처
		$.each(metaData, function(key, value) {
			
			if ( value.metaId == 81000106 || value.metaId == 81000100 ) {
				// 제공기관, 자료출처
				source += gfn_isNull(value.metaCont) ? "" : value.metaCont + " ";
			}
		});
		cmmtSect.find(".source").text(source);*/
	}
	else {
		$(".conComment").hide();	// 주석 숨김
	}
}



