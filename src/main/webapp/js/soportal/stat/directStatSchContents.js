/*
 * @(#)directStatSchSearch.js 1.0 2017/12/14
 */
/**
 * 통계조회 및 조회 전/후처리 스크립트 파일이다.
 * 
 * @author 김정호
 * @version 1.0 2018/06/26
 */
////////////////////////////////////////////////////////////////////////////////
// 통계 컨텐츠 처리
////////////////////////////////////////////////////////////////////////////////

function setContents(data) {
	setContData(data);
	setContBbsTbl(data);
}

/**
 * 통계컨텐츠 데이터 조회
 * @param data
 */
function setContData(data) {

	$("#tab_A_G, #tab_A_S").hide();			// 통계표, 그래프 탭 숨김
	$("#fileSelect, #fileDownload").hide();	// 통계컨텐츠 파일 숨김
	
	$("#tab_A_T").show().addClass("on");	// 통계컨텐츠 탭 보여준다
	
	$("#contTitle").empty().text(data.statblNm);
	
	var sttsctSeq = data.STTSCT_SEQ; // NABO 통계표 컨텐츠
	
	// 탭에 선택클래스를 준다.
   	//$("#contTab li:first").attr("class", "on");
    
   	$("#seq").val(sttsctSeq);
   	
   	// 컨텐츠 서비스 CD case(Contents 코드  A: 전체(설명+파일) F : 첨부파일  S : 통계설명  N : 사용안함)
   	switch (data.CTS_SRV_CD) {
   	case "A" :
   		if ( sttsctSeq != 0 ) {
   	   		getContBbsTbl(sttsctSeq, "STTSCT");
   	   	}
   		getContentsFile();
   		
		$("#statCont-sect .free_cont").eq(0).show();	// 통계 메인컨텐츠는 보여준다.
		$("#statCont-sect .free_cont").eq(1).show();	// 통계 파일컨텐츠는 보여준다.
   		break;
   	case "F" :
   		getContentsFile();
   		
   		$("#statCont-sect").show();
   		$("#statCont-sect .free_cont").eq(0).hide();	// 통계 메인컨텐츠는 보여주지 않음.
		$("#statCont-sect .free_cont").eq(1).show();
   	    break;
   	case "S" :
   		if ( sttsctSeq != 0 ) {
   	   		getContBbsTbl(sttsctSeq, "STTSCT");
   	   	}
   		$("#statCont-sect").show();
   		$("#statCont-sect .free_cont").eq(0).show();	
		$("#statCont-sect .free_cont").eq(1).hide();	// 통계 파일컨텐츠는 보여주지 않음.
	    break;    
   	}
	
   	//상세조회
   	detailAnalysis(data.CTS_SRV_CD);
	
}

/**
 * 통계연결 컨텐츠 데이터 조회
 */
function setContBbsTbl(data){
	
	var sttsctSeq = data.STTSCT_SEQ; // NABO 통계표 컨텐츠
	var naboeSeq  = data.NABOE_SEQ;  // NABO 통계해설
	var naborSeq  = data.NABOR_SEQ;  // NABO 분석
   	var nabooSeq  = data.NABOO_SEQ;  // NABO 국회부대의견
   	var nabocSeq  = data.NABOC_SEQ;  // NABO 시정조치
   	var dicSeq    = data.DIC_SEQ;	 // NABO 용어설명
 
   	if(dicSeq !=0) {
   		getContBbsTblList("DIC");
   	}
   	if(naboeSeq != 0) {
   		getContBbsTbl(naboeSeq, "NABOE");
   	}
   	if(naborSeq != 0) {
   		getContBbsTbl(naborSeq, "NABOR");
   	}
   	if(nabooSeq != 0) {
   		getContBbsTbl(nabooSeq, "NABOO");
   	}
   	if(nabocSeq !=0) {
   		getContBbsTbl(nabocSeq, "NABOC");
   	}
   	
}

/**
 * 게시판 통계표 컨텐츠를 가져온다.
 * @param seq		게시글 보유번호
 * @param bbsCd		게시판 코드
 */
function getContBbsTbl(seq, bbsCd) {
	doAjax({
		url : "/portal/stat/selectContBbsTbl.do",
		params : {seq : seq, bbsCd : bbsCd},
		callback : function(res) {
			var data = res.data;
			
			if (data != null) {
			
				// 게시판 통계표 컨텐츠를 화면에 보여준다
				viewContBbsTbl(data, bbsCd);
				
				// 통계해설, NABO분석, 국회부대의견, 시정조치 일경우 파일 및 링크목록 표시
				if ( bbsCd == "NABOE" || bbsCd == "NABOR" || bbsCd == "NABOO" || bbsCd == "NABOC" ) {

					if ( data.fileCnt > 0 ) {
						// 파일 다운로드 연결
						getContBbsFile(bbsCd);
					}
					if ( data.linkCnt > 0 ) {
						// 링크 연결
						getContBbsLink(bbsCd);
					}
				}
			} else {
				
			}
		}
	});
}

/**
 * 게시판 통계표 컨텐츠를 화면에 보여준다
 * @param data
 * @param bbsCd
 * @returns {Boolean}
 */
function viewContBbsTbl(data, bbsCd) {
	
	if ( gfn_isNull(bbsCd) )	return false;
	
	if ( bbsCd == "STTSCT" ) {			// 통계표 컨텐츠
		$("#statCont-sect").show();
		var statContSect = $("#statCont-sect"); 
		statContSect.show();
		statContSect.find(".free_cont").eq(0).html(data.bbsCont);
	}
	else if ( bbsCd == "NABOE" ) {		// 통계해설
		$("#tab_A_E").show();
		var statHaesulSect = $("#statHaesul-sect").show();
		statHaesulSect.show();
		statHaesulSect.find(".free_title").text(data.bbsTit + (gfn_isNull(data.listCdNm) ? "" : " (" + data.listCdNm + " : " + data.listSubCdNm + ")"));
		statHaesulSect.find(".free_cont").html(data.bbsCont);
	}
	else if ( bbsCd == "DIC" ) {		// 용어설명
		$("#tab_A_D").show();
		$("#wordExplantion-sect").show();
	}
	else if ( bbsCd == "NABOR" ) {		// NABO분석(통계설명)
		$("#tab_A_R").show();
		var naboAnalsSect = $("#naboAnals-sect");
		naboAnalsSect.show();
		naboAnalsSect.find(".free_title").text(data.bbsTit + (gfn_isNull(data.listCdNm) ? "" : " (" + data.listCdNm + " : " + data.listSubCdNm + ")"));
		naboAnalsSect.find(".free_cont").html(data.bbsCont);
	}
	else if ( bbsCd == "NABOO" ) {		// 국회부대의견
		$("#tab_A_O").show();
		var assemblyIdeaSect = $("#assemblyIdea-sect");
		assemblyIdeaSect.show();
		assemblyIdeaSect.find(".free_title").text(data.bbsTit + (gfn_isNull(data.listCdNm) ? "" : " (" + data.listCdNm + " : " + data.listSubCdNm + ")"));
		assemblyIdeaSect.find(".free_cont").html(data.bbsCont);
	}
	else if ( bbsCd == "NABOC" ) {		// 시정조치
		$("#tab_A_C").show();
		var correctSect = $("#correct-sect"); 
		correctSect.show();
		correctSect.find(".free_title").text(data.bbsTit + (gfn_isNull(data.listCdNm) ? "" : " (" + data.listCdNm + " : " + data.listSubCdNm + ")"));
		correctSect.find(".good_title").eq(0).text(data.procStartNm);	// 처리상태 시작명
		correctSect.find(".good_title_cont").html(data.bbsCont);			// 글내용
		correctSect.find(".good_title").eq(1).text(data.procEndNm);		// 처리상태 종료명
		correctSect.find(".good_title_ans").html(data.ansCont);			// 처리내용
		
	}
}

/**
 * 게시판 컨텐츠 파일 목록을 가져온다.
 * @param bbsCd		게시판 코드
 */
function getContBbsFile(bbsCd) {
	doAjax({
		url : "/portal/stat/selectContBbsFileList.do",
		params : {statblId : $("#sId").val(), bbsCd : bbsCd},
		callback : function(res) {
			
			var data = res.data;
			
			if (data.length > 0) {
				viewContBbsFile(data, bbsCd);
			}
		}
	});
}

/**
 * 게시판 컨텐츠 파일 목록을 표시한다.
 * @param data		게시판 컨텐츠 파일 목록 데이터
 * @param bbsCd		게시판 코드
 */
function viewContBbsFile(data, bbsCd) {

	// 파일 목록 템플릿
	var template = 
			"<div class=\"conDown\">" +
			"	<a href=\"javascript:;\"></a>" +
			"	<a href=\"javascript:;\" class=\"con_btn\">파일다운로드</a>" +
			"</div>";

	var divSectId = getDivSectId(bbsCd);	// jsp의 bbs별 div 영역 ID
	
	$("#" + divSectId + " .content_down").empty();
	
	for ( var d in data ) {
		var tmp = $(template);
		
		tmp.find("a").eq(0).text(data[d].viewFileNm);
		
		tmp.find("a").eq(1).bind("click", {
			fileSeq : data[d].fileSeq
		}, function(event) {
			fileDownload(event.data.fileSeq);	// 다운로드 이벤트
		});
		
		$("#" + divSectId + " .content_down").append(tmp);
	}
}

/**
 * 게시판 컨텐츠 링크 목록을 가져온다.
 * @param bbsCd		게시판 코드
 */
function getContBbsLink(bbsCd) {
	doAjax({
		url : "/portal/stat/selectContBbsLinkList.do",
		params : {statblId : $("#sId").val(), bbsCd : bbsCd},
		callback : function(res) {
			var data = res.data;

			if (data.length > 0) {
				viewContBbsLink(data, bbsCd);
			}
		}
	});
}

/**
 * 게시판 컨텐츠 링크 목록을 표시한다.
 * @param data		게시판 컨텐츠 링크 목록 데이터
 * @param bbsCd		게시판 코드
 */
function viewContBbsLink(data, bbsCd) {

	var template = 
			"<div class=\"conLink\">" +
			"	<a href=\"javascript:;\"></a>" +
			"	<a href=\"javascript:;\" class=\"con_btn\">바로가기</a>" +
			"</div>";

	var divSectId = getDivSectId(bbsCd);		// jsp의 bbs별 div 영역 ID
	
	$("#" + divSectId + " .content_link").empty();
	
	for ( var d in data ) {
		var tmp = $(template);
		
		tmp.find("a").eq(0).text(data[d].linkNm);
		
		tmp.find("a").eq(1).bind("click", {
			linkUrl : data[d].linkUrl
		}, function(event) {
			window.open(event.data.linkUrl, 'pop','height=' + $(window).height() + ',width=' + $(window).width() + 'fullscreen=yes');
		});
		
		$("#" + divSectId + " .content_link").append(tmp);
	}
}

/**
 * jsp 파일의 BBS별 DIV영역 ID를 가져온다.
 * @param bbsCd	게시판 코드
 * @returns
 */
function getDivSectId(bbsCd) {
	
	if ( gfn_isNull(bbsCd) )	return null;
	
	var divSectId = "";
		
	if ( bbsCd == "STTSCT" ) {			// 통계표 컨텐츠
		divSectId = "statCont";
	}
	else if ( bbsCd == "NABOE" ) {		// 통계해설
		divSectId = "statHaesul";
	}
	else if ( bbsCd == "DIC" ) {		// 용어설명
		divSectId = "wordExplantion";
	}
	else if ( bbsCd == "NABOR" ) {		// NABO분석(통계설명)
		divSectId = "naboAnals";
	}
	else if ( bbsCd == "NABOO" ) {		// 국회부대의견
		divSectId = "assemblyIdea";
	}
	else if ( bbsCd == "NABOC" ) {		// 시정조치
		$("#correct-sect .content_down").empty().append(tmp);
		divSectId = "correct";
	}
	
	return divSectId + "-sect"
}

/**
 * 용어설명 리스트 조회
 * @param bbsCd
 * @returns {Boolean}
 */
function getContBbsTblList(bbsCd) {

	if ( gfn_isNull(bbsCd) )	return false;
	
	var template =
		"<div class=\"desc_text\">" +
		"	<div class=\"desc01 vamle\"></div>" +
		"	<div class=\"desc03\"></div>" +
		"</div>";
	
	doAjax({
		url : "/portal/stat/selectContBbsTblList.do",
		params : {statblId : $("#sId").val(), bbsCd : bbsCd},
		callback : function(res) {
			var data = res.data;
			
			if (data.length > 0) {
				
				$("#tab_A_D").show();
				$("#wordExplantion-sect").show();
				$("#content_desc_text").empty();
				
				for ( var i=0; i < data.length; i++ ) {
					temp = $(template);
					temp.find(".desc01").html(data[i].bbsTit);
					temp.find(".desc03").html(data[i].bbsCont);
					$("#content_desc_text").append(temp);
				}
			}
		}
	});
	
	
}

/**
 * 첨부파일 조회
 * @param sttsctSeq
 * @returns {Boolean}
 */ 
function getContentsFile(){
	var page = "";
	doSearch({
		url : "/portal/stat/selectContentsFileList.do",
		page : page ? page : "1",
		before : beforeFileSearchList,
		after :  afterFileSearchList,
		pager : "file-pager-sect",
		counter:{
            count:"file-count-sect"
        }
	});
	
	
}

/**
 * 첨부파일 조회 전처리
 * @param option
 */
function beforeFileSearchList(option) {
	var data = {
			seq : $("#seq").val(),
			bbsCd : "STTSCT",
			searchType : $("#file-searchtype-combo").val(),
			searchWord : $("#file-searchword-field").val()
				
		};
		return data;
}

/**
 * 첨부파일 조회 후처리(목록 생성)
 * @param data
 */
function afterFileSearchList(data){
	
	$("#fileSelect").empty();
	
	if(data.length > 0){
		$("#fileSelect, #fileDownload").show();
		
		$("#statCont-sect .free_cont").eq(1).html(data[0].FILE_CONT);	// 파일 내용
		
		$.each(data, function(key, value){
			$("#fileSelect").append("<option value=\""+value.FILE_SEQ+"\">"+value.VIEW_FILE_NM+"</option>");
		});
	}
	
	// 파일 셀렉트 처리 
	$("#fileSelect").bind("change", function() {
		var seq = $("#seq").val();
		var fileSeq = $("#fileSelect").val();
		
		fileDetailView(seq, fileSeq);
	});
	
	//파일 다운로드
	$("#fileDownload").bind("click", function(event) {
		fileDownload($("#fileSelect").val());
	});
}

/**
 * 첨부파일 내용 조회
 * @param seq
 * @param fileSeq
 * @returns {Boolean}
 */
function fileDetailView(seq, fileSeq){
	if ( gfn_isNull(seq) || gfn_isNull(fileSeq) ) {
		return false;
	}
	$("#file_detail").empty();
	doAjax({
		url : "/portal/stat/selectContentsFileList.do",
		params : {seq : seq, bbsCd : "STTSCT", fileSeq: fileSeq},
		callback : function(res) {
			var data = res.data;
			if (data.length > 0) {
				$("#statCont-sect .free_cont").eq(1).html(data[0].FILE_CONT);
				
				// left 트리와 right 컨텐츠 박스와 동일하게 height 세팅
				setTimeout(function() {
					$("#leftTreeBox").css("height", $(".rightCont .content_body").height());
				}, 500);
			} 
		}
	});
}

/**
 * 첨부파일 다운로드
 * @param fileSeq
 */
function fileDownload(fileSeq){
	
	var data = {fileSeq:fileSeq};
	var options = {
			mode : "select",
			url : "/portal/bbs/STTSCT/downloadAttachFile.do",
			target : "global-process-iframe"
	};
	downloadFile(data,options);
}

////////////////////////////////////////////////////////////////////////////////
//글로벌 변수
////////////////////////////////////////////////////////////////////////////////
/**
* 템플릿
*/
var templates = {
 data:
     "<tr>"                                                        +
         "<td class=\"number rowNum\"></td>"                       +
         "<td class=\"title left\">"                               +
	            "<a href=\"#\" class=\"bbsTit\"></a>"              +
	            "<ul class=\"mobile-info\">"                       +
	            "<li class=\"userDttm\"></li>"                     +
	            "<li class=\"none viewCnt\"></li>"                 +
	            "</ul>"                                            +
	     "</td>"                                                   +
	     "<td class=\"writer userNm\"></span></td>"                +
         "<td class=\"date userDttm\"></td>"                       +
         "<td class=\"hit viewCnt\"></td>"                         +
     "</tr>",
 none:
     "<tr>"                                                        +
         "<td colspan=\"5\" class=\"noData\">해당 자료가 없습니다.</td>" +
     "</tr>"
};

/**
 * 상세분석 정의
 * @returns
 */
function detailAnalysis(ctsSrvCd){
	if ( ctsSrvCd == "N" ) {
		// 통계표는 상세분석 무조건 표시(선택한 자기자신의 통계표로 이동)
		$("#detailAnalysis").attr("href", "javascript:goStatsUrl('"+ $("#sId").val() +"');").show();
	}
	else {
		var sttsctSeq = $("#seq").val();
		doAjax({
			url : "/portal/stat/selectDtlAnalysisList.do",
			params : {seq : sttsctSeq},
			callback : function(res) {
				var data = res.data;
				if (data.length > 0) {
					/*
				for ( var i=0; i < data.length; i++ ) {
					var statblId = data[0].STATBL_ID;
					$("#detailAnalysis").attr("href", "javascript:goStatsUrl('"+data[0].STATBL_ID+"');");
				}*/
					$("#detailAnalysis").attr("href", "javascript:goStatsUrl('"+data[0].STATBL_ID+"');").show();
				} else {
					$("#detailAnalysis").hide();
				}
			}
		});
	}
}

/**
 * 상세페이지 이동
 * @param sttsctSeq
 * @returns
 */
function goStatsUrl(statblId){
	var windowWidth = $(window).width();
    var windowHeight = $(window).height();
    
    urlPage = "/portal/stat/easyStatPage/";
    
    var url = com.wise.help.url(urlPage)+statblId+".do";
	window.open(url,'pop','height=' + windowHeight + ',width=' + windowWidth + 'fullscreen=yes');
    
}

//----------------------- 통계 컨텐츠 처리[종료] ---------------------------
