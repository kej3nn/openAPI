/*
 * @(#)easyStatSchSearch.js 1.0 2017/12/14
 * 
 * COPYRIGHT (C) 2013 WISEITECH CO., LTD. ALL RIGHTS RESERVED.
 */
/**
 * 간편통계 조회 및 조회 전/후처리 스크립트 파일이다.
 * 
 * @author 최성빈
 * @version 1.0 2018/06/20
 */
////////////////////////////////////////////////////////////////////////////////
// 통계 컨텐츠 처리
////////////////////////////////////////////////////////////////////////////////
/**
 * 통계 컨텐츠 탭 설정
 */
function setContentData(data){
	
	var sttsctSeq = data.STTSCT_SEQ; // NABO 통계표 컨텐츠
	var naboeSeq  = data.NABOE_SEQ;  // NABO 통계해설
	var naborSeq  = data.NABOR_SEQ;  // NABO 분석
   	var nabooSeq  = data.NABOO_SEQ;  // NABO 국회부대의견
   	var nabocSeq  = data.NABOC_SEQ;  // NABO 시정조치
   	var dicSeq    = data.DIC_SEQ;	 // NABO 용어설명
   	var sttsqaSeq = data.STTSQA_SEQ; // NABO 통계표 질의 답변
    
   	var statblNm = data.statblNm; 
   	
   	var ctsSrvCd = data.CTS_SRV_CD; // Contents 코드  A: 전체(설명+파일) F : 첨부파일  S : 통계설명  N : 사용안함
   	
   	var body = $("#content_button");
	body.empty();
	
	$("#contTitle").empty();
	$("#content_detail").empty();
	$("#file_detail").empty();
	$("#fileSelect").hide();
	$("#fileDownload").hide();
	
	var innerHtml = "";
    
   	if(naboeSeq != 0)  innerHtml += "<li><button class='btnSt1 btnX' type='button' name='statNaboe' title='통계해설'>통계해설</button></li>";
   	if(naborSeq != 0)  innerHtml += "<li><button class='btnSt1 btnX' type='button' name='statNabor' title='통계설명'>통계설명</button></li>";
   	if(nabooSeq != 0)  innerHtml += "<li><button class='btnSt1 btnX' type='button' name='statNaboo' title='국회부대의견'>국회부대의견</button></li>";
   	if(nabocSeq !=0)  innerHtml += "<li><button class='btnSt1 btnX' type='button' name='statNaboc' title='시정조치'>시정조치</button></li>";
   	/*if(sttsqaSeq !=0)  innerHtml += "<li><button class='btnSt1 btnX' type='button' name='statSttsqa' title='질의/답변'>질의/답변</button></li>";*/
   	
   	if(dicSeq ==0) $("a[name=statDic]").hide();
   	else $("a[name=statDic]").show();

   	$("#contTitle").text(statblNm); 
   	body.append(innerHtml);
   	
   	if($("#content_button > li").size() == 0) body.hide();
   	else body.show();
   	
   	$("#seq").val(sttsctSeq);
   	
   	switch (ctsSrvCd) {
   	case "A" :
   		getContentsData();
   		getContentsFile();
   		break;
   	case "F" :
   		getContentsFile();
   	    break;
   	case "S" :
   		getContentsData();
	    break;    
   	}
   	
   	//div 팝업 버튼 액션
   	divPopupEventControl();
   	
   	//상세조회
   	detailAnalysis();
   	
   	// 컨텐츠 버튼이 없을 시 컨텐츠영역 리사이즈
   	var treeboxSize = $('.easySearch .treeBox.size2');
   	var height ="";
   	if($("#content_button").is(":visible")){
   		height = treeboxSize.height();
		$('#content_txt').css("height",height-13);
	}else{
		height = treeboxSize.height();
		$('#content_txt').css("height",height+33);
	}
}

/**
 * 통계 설명 조회
 * @param sttsctSeq
 * @returns {Boolean}
 */
function getContentsData(){
	var sttsctSeq = $("#seq").val();
	$("#content_detail").empty();
	doAjax({
		url : "/portal/stat/selectContentsList.do",
		params : {seq : sttsctSeq, bbsCd : "STTSCT"},
		callback : function(res) {
			var data = res.data;
			if (data.length > 0) {
				for ( var i=0; i < data.length; i++ ) {
					
					$("#content_detail").html(data[i].BBS_CONT);
				}
			} else {
				return false;
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
 * 첨부파일 목록 생성
 * @param data
 */
/**
 * 첨부파일 목록 생성
 * @param data
 */
function afterFileSearchList(data){
	
	
	$("#fileSelect").empty();
	$("#file_detail").empty();
	$("#fileSelect").empty();
	
	
	if(data.length > 0){
		$("#fileDownload").show();
		$("#fileSelect").show();
		$("#file_detail").html(data[0].FILE_CONT);
		$.each(data, function(key, value){
			$("#fileSelect").append("<option value=\""+value.FILE_SEQ+"\">"+value.VIEW_FILE_NM+"</option>");

		});
	}else{
		$("#fileDownload").hide();
		$("#fileSelect").hide();
		return false;
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
	$("#fileSelect").show();
	$("#fileDownload").show();
	
	doAjax({
		url : "/portal/stat/selectContentsFileList.do",
		params : {seq : seq, bbsCd : "STTSCT", fileSeq: fileSeq},
		callback : function(res) {
			var data = res.data;
			if (data.length > 0) {
				$("#file_detail").show();
				for ( var i=0; i < data.length; i++ ) {
					
					$("#file_detail").html(data[i].FILE_CONT);
				}
			} else {
			    //파일 데이터 없을시 버튼 삭제
				$("#file_detail").hide();
				return false;
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

/**
 * div 팝업 버튼 액션 정의
 */
function divPopupEventControl(){
	
	var statblId = $("#sId").val();
	$("button[name=statNaboe]").bind("click", function(event) { //통계해설
		conDataCall(statblId, "NABOE", "TOP");
	});
	
	$("button[name=statNabor]").bind("click", function(event) { //통계설명
		conDataCall(statblId, "NABOR", "TOP");
	});
	
	$("button[name=statNaboo]").bind("click", function(event) { //국회부대의견
		conDataCall(statblId, "NABOO", "TOP");
	});
	
	$("button[name=statNaboc]").bind("click", function(event) { //시정조치
		conDataCall(statblId, "NABOC", "TOP");
	});
	
	$("button[name=statSttsqa]").bind("click", function(event) { //질의/답변
		conDataCall(statblId, "STTSQA", "TOP");
	});

	
	$("a[name=statContentClose], a[name=statContentTblClose]").bind("click", function(event) {
		$("#statContent-box").hide();
		return false;
	});
	
	$("a[name=statDic]").unbind("click").bind("click",function(){
		conDataCall(statblId, "DIC", "TOP");
	});
	
	//목록버튼 클릭이벤트
	$("a[name=statContentTblList]").bind("click", function(event) {
		$("#bbsDetailDiv").hide();
		$("#bbsBtnDiv").hide();
		//$("#bbsListDiv").show('1000');
		$("#bbsListDiv").show();
		return false;
	});

	$("button[name=list]").bind("click", function(event) {
		$(".rightCont").hide();
		$(".leftArea").show();
	});
		
    // 컨텐츠 게시판 검색어 필드에 키다운 이벤트를 바인딩한다.
    $("#bbs-searchword-field").bind("keydown", function(event) {
        if (event.which == 13) {
        	conDataSearch();
            return false;
        }
    });
    
    // 컨텐츠 게시판 검색 버튼에 클릭 이벤트를 바인딩한다.
    $("#bbs-search-button").bind("click", function(event) {
    	conDataSearch();
        return false;
    });
    
    // 컨텐츠 게시판 검색 버튼에 키다운 이벤트를 바인딩한다.
    $("#bbs-search-button").bind("keydown", function(event) {
        if (event.which == 13) {
        	conDataSearch();
            return false;
        }
    });
}

/**
 * div 팝업 버튼 액션 정의
 */
function conDataCall(statblId, bbsCd, seqNo){
	//검색을 위한 변수값 Setting
	$("#contents-search-form [name=statblId]").val(statblId);
	$("#contents-search-form [name=bbsCd]").val(bbsCd);
	$("#contents-search-form [name=seq]").val(seqNo);
	
	//NABO 컨텐츠 팝업창 활성화
	$("#statContent-box").show();
	//$("#bbsDetailDiv").show('1000');
	//$("#bbsBtnDiv").show('1000');
	$("#bbsDetailDiv").show();
	$("#bbsBtnDiv").show();
	$("#bbsListDiv").hide();
	$("#contentsOrgNm").hide();
	$("#orgNm").hide();
	$("#tdContDetail").attr("colspan", "4");
	$("#bottomLinkTd").attr("colspan", "4");
   	
	var titNm = "";
	var orgNm ="";
	if(bbsCd == "NABOE") 	titNm = "통계해설";
	if(bbsCd == "NABOR"){
		titNm = "통계설명";
		orgNm = "분석년도";
		$("#contentsOrgNm").text(orgNm);
		$("#contentsOrgNm").show();
		$("#orgNm").show();
	}
	if(bbsCd == "NABOO") {
		titNm = "국회부대의견";
		orgNm = "유형";
		$("#contentsOrgNm").text(orgNm);
		$("#contentsOrgNm").show();
		$("#orgNm").show();
	}
	if(bbsCd == "NABOC") 	{
		titNm = "시정조치";
		orgNm = "대상기관";
		$("#contentsOrgNm").text(orgNm);
		$("#contentsOrgNm").show();
		$("#orgNm").show();
	}
	if(bbsCd == "STTSQA") 	titNm = "질의/답변";
	if(bbsCd == "DIC") 	titNm = "용어설명";

	$("#statContent-box").find($(".tit")).text(titNm);
	$("#contentsTitle").text(titNm);
	$("#contentsListTitle").text(titNm);
	$("#bbs-searchtype-combo option:eq(1)").text(titNm);

	//$("#content_detail").empty();
	doAjax({
		url : "/portal/stat/selectContentsNabo.do",
		params : {statblId : statblId, bbsCd : bbsCd, seq : seqNo },
		callback : function(res) {
			var data = res.data;

			//통계명 Display
			$("#conStatNm").text(data.statblNm);
			
			
			if(bbsCd != "DIC"){
				var bbsData = data.BBS_DATA;
				$(".termList").hide();
				$(".board-list09").show();
				$(".ncontent_next").show();
				$("#bbsBtnDiv").find("[name=statContentTblList]").show();
				$("#npop").css("width", "800px");
				//선택 게시물 Display
				if (bbsData.length > 0) {
					for ( var i=0; i < bbsData.length; i++ ) {
						$("#bbsTit").text(bbsData[i].BBS_TIT);
						$("#userNm").text(bbsData[i].USER_NM); 
						$("#userNmM").text(bbsData[i].USER_NM);     
						if(bbsCd == "NABOR" || bbsCd == "NABOO" || bbsCd == "NABOC"){
							var listSubCd = gfn_isNull(bbsData[i].LIST_SUB_CD) ? "" : bbsData[i].LIST_SUB_CD;
							var grpListCdNm = gfn_isNull(bbsData[i].GRP_LIST_CD_NM) ? "" : bbsData[i].GRP_LIST_CD_NM;
							
							$("#contentsOrgNm").text(grpListCdNm);
							$("#orgNm").text(listSubCd);
							$("#orgNmM").text(listSubCd);
							$("#tdContDetail").attr("colspan", "5");
							$("#bottomLinkTd").attr("colspan", "5");
						}
						var inDate = bbsData[i].USER_DTTM;
						$("#userDttmM").text(inDate.substr(0,4)+"-"+inDate.substr(4,2)+"-"+inDate.substr(6,2));
						$("#userDttm").text(inDate.substr(0,4)+"-"+inDate.substr(4,2)+"-"+inDate.substr(6,2));
						$("#viewCntM").text(bbsData[i].VIEW_CNT);
						$("#viewCnt").text(bbsData[i].VIEW_CNT);
						
						var bbsCont = "";
						//국회시정 요구사항
						if(bbsCd == "NABOC") bbsCont += "<div style='width:125px;' class='good_title'>"+bbsData[i].PROC_START_NM+"</div>";
						bbsCont += bbsData[i].BBS_CONT;
						//조치결과
						if(bbsCd == "NABOC" && bbsData[i].ANS_STATE == "조치결과") {
							bbsCont += "<div class='good_title'>"+bbsData[i].PROC_END_NM+"</div>";
							bbsCont += bbsData[i].ANS_CONT;
						}
						
						$("#bbsContM").html(bbsCont);
						$("#bbsCont").html(bbsCont);
					}
				} else {
					return false;
				}
				
				//다음 게시물 Display
				var nextData = data.NEXT_DATA;
				$("#bbsNext").empty();
				var nextHtml = "";
				if (nextData.length > 0) {
					for ( var i=0; i < nextData.length; i++ ) {
						nextHtml = "<a href='#' onclick=\"javascript:conDataCall('"+nextData[i].STATBL_ID+"', '"+nextData[i].BBS_CD+"', '"+nextData[i].SEQ+"');\">"+nextData[i].BBS_TIT+"</a>";
					}
				}else{
					nextHtml="<a href='#'>다음글이 없습니다.</a>";
				}
				$("#bbsNext").append(nextHtml);
				
				//이전 게시물 Display
				var prevData = data.PREV_DATA;
				$("#bbsPrev").empty();
				var prevHtml = "";
				if (prevData.length > 0) {
					for ( var i=0; i < prevData.length; i++ ) {
						prevHtml = "<a href='#' onclick=\"javascript:conDataCall('"+prevData[i].STATBL_ID+"', '"+prevData[i].BBS_CD+"', '"+prevData[i].SEQ+"');\">"+prevData[i].BBS_TIT+"</a>";
					}
				}else{
					prevHtml = "<a href='#'>이전글이 없습니다.</a>";
				}
				$("#bbsPrev").append(prevHtml);
				
				$(".content_free").empty();
				
				//링크 데이터
				var linkData = data.LINK_DATA;
				var linkHtml = "";
				$("#linkList").empty();
				if(linkData.length > 0){
					for ( var i=0; i < linkData.length; i++ ) {
						linkHtml += "<div class=\"conLink\">";
						linkHtml += "<a href=\"#\">"+linkData[i].LINK_NM+"</a>";
						linkHtml +=  "<a href=\""+linkData[i].URL+"\" class='con_btn'>바로가기</a>";
						linkHtml += "</div>";
					}
					$(".content_free").append(linkHtml);
					$(".con_btn").attr({"target" : "_blank"});
				}
				
				//파일 데이터
				var fileData = data.FILE_DATA;
				var fileHtml = "";
				if(fileData.length > 0){
					for ( var i=0; i < fileData.length; i++ ) {
						fileHtml += "<div class=\"conDown\"><a href=\"#\">"+fileData[i].VIEW_FILE_NM+"</a>";
						fileHtml += "<a href=\"#\" onclick=\"javascript:fileDownload('"+fileData[i].FILE_SEQ+"');\" class=\"con_btn\">파일다운로드</a></div>"
					}
					$(".content_free").append(fileHtml);
				}
				
				//레이어 팝업창 파일/링크 갯수의 상관없이 고정
				var fileCnt =  $("#contentFree").find("div.conDown, div.conLink").length;
				$("#tdContDetail").css("height", "285px");
				if(fileCnt != 0){
					var reSizeHeight = 285 - (fileCnt * 31 );
					$("#tdContDetail").css("height", reSizeHeight);
				}
				
				//목록 Display
				conDataSearch();
			}else{
				$(".termList").show();
				$(".board-list09").hide();
				$(".ncontent_next").hide();
				$("#bbsBtnDiv").find("[name=statContentTblList]").hide();
				$("#npop").css("width", "500px");
				
				$(".listFolder").empty();
				var dicHtml ="";
				var dicData = data.DIC_DATA;
				if (dicData.length > 0) {
					for ( var i=0; i < dicData.length; i++ ) {
						dicHtml +="<dt>";
						dicHtml +="<span><a href=\"javascript:void(0);\">"+dicData[i].BBS_TIT+"</a></span>";
						dicHtml +="</dt>";
						dicHtml +="<dd style=\"display:none;\">";
						dicHtml +="<p class=\"txtSt2\">";
						dicHtml += dicData[i].BBS_CONT;
						dicHtml +="</p>";
						dicHtml +="</dd>";
					}
					
					$(".listFolder").append(dicHtml);
				}
				
			}
		}
	});
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
	     "<td class=\"orgNm \" ></span></td>"                +
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
 * div 팝업 목록 검색
 */
function conDataSearch(){
	
	$("#contents-search-form [name=searchType]").val($("#bbs-searchtype-combo").val())
	$("#contents-search-form [name=searchWord]").val($("#bbs-searchword-field").val())
	var page = $("#contents-search-form [name=page]").val();
	var bbsCd = $("#contents-search-form [name=bbsCd]").val();
	//NABO 컨텐츠 팝업창 활성화
	//$("#bbsDetailDiv").hide('1000');
	//$("#bbsBtnDiv").hide('1000');
	//$("#bbsListDiv").show('1000');
	$("#contentsListOrgNm").hide();
	
	if(bbsCd == "NABOE") $("#statContent-box").find($(".tit")).text("통계해설");
	if(bbsCd == "NABOR") {
		$("#statContent-box").find($(".tit")).text("통계설명");
		$("#contentsListOrgNm").show();
		$("#contentsListOrgNm").text("분석년도");
	}
	if(bbsCd == "NABOO") {
		$("#statContent-box").find($(".tit")).text("국회부대의견");
		$("#contentsListOrgNm").show();
		$("#contentsListOrgNm").text("유형");
	}
	if(bbsCd == "NABOC") {
		$("#statContent-box").find($(".tit")).text("국회시정조치");
		$("#contentsListOrgNm").show();
		$("#contentsListOrgNm").text("대상기관");
	}
	if(bbsCd == "STTSQA") $("#statContent-box").find($(".tit")).text("질의/답변");

    // 데이터를 검색한다.
    doSearch({
        url:"/portal/stat/selectContentsNaboList.do",
        page:page ? page : "1",
        before:beforeSearchContents,
        after:afterSearchContents,
        pager:"contents-pager-sect",
        counter:{
            count:"contents-count-sect",
            pages:"contents-pages-sect"
        }
    });
    
}

////////////////////////////////////////////////////////////////////////////////
//전처리 함수
////////////////////////////////////////////////////////////////////////////////
/**
*  통계컨텐츠 목록 검색 전처리를 실행한다.
* 
* @param options {Object} 옵션
* @returns {Object} 데이터
*/
function beforeSearchContents(options) {
	var data = {
     // Nothing do do.
	};
	var form = $("#contents-search-form");
	if (com.wise.util.isBlank(options.page)) {
		form.find("[name=page]").val("1");
	}else{
		form.find("[name=page]").val(options.page);
	}

	$.each(form.serializeArray(), function(index, element) {
		switch (element.name) {
			case "seq":
			default:
				data[element.name] = element.value;
			break;
		}
	});

	if (com.wise.util.isBlank(data.bbsCd)) {
		return null;
	}
	return data;
}
////////////////////////////////////////////////////////////////////////////////
//후처리 함수
////////////////////////////////////////////////////////////////////////////////
/**
* 통계컨텐츠 목록 검색 후처리를 실행한다.
* 
* @param data {Array} 데이터
*/
function afterSearchContents(data) {
	var table = $("#contents-data-table");
	table.find("tr").each(function(index, element) {
		if (index > 0) {
			$(this).remove();
		}
	});
	var bbsCd = data[0].bbsCd; 
	if(bbsCd !="DIC"){
		for (var i = 0; i < data.length; i++) {
			if(data[i].rowCnt != null && data[i].rowCnt > 0){
			
				var row = $(templates.data);
				row.find(".rowNum").text(getRowNumber($("#contents-count-sect").text(), "" + data[i].rowCnt));
				row.find(".bbsTit").text(data[i].bbsTit);
				if(data[i].bbsCd == "NABOR" ||data[i].bbsCd == "NABOO" ||data[i].bbsCd == "NABOC"){
					var listSubCd = gfn_isNull(data[i].listSubCd) ? "" : data[i].listSubCd;
					var grpListCdNm = $("#contentsOrgNm").text();
					
					$("#contentsListOrgNm").text(grpListCdNm); //분류명
					row.find(".orgNm").text(listSubCd); // 코드명
				}
		
				if (data[i].newYn == "Y") {
					row.find(".bbsTit").prepend("<img src=\"" + com.wise.help.url("/images/hfportal/board/icon_new@2x.png") + "\" alt=\"새글\" class=\"board-icon mobile\"/> ");
				}
				if (data[i].viewCnt >= data[i].hlCnt) {
					row.find(".bbsTit").addClass("best");
				}
				row.find(".userNm").text(data[i].userNm);
				var listDate = data[i].userDttm;
				if(listDate != undefined) listDate = listDate.substr(0,4)+"-"+listDate.substr(4,2)+"-"+listDate.substr(6,2);
				row.find(".userDttm").text(listDate);
				row.find(".viewCnt").text(data[i].viewCnt);
		
				row.find("a").each(function(index, element) {
					// 제목 링크에 클릭 이벤트를 바인딩한다.
					$(this).bind("click", {
						statblId:data[i].statblId,
						bbsCd:data[i].bbsCd,
			            seq:data[i].seq
			         }, function(event) {
			            //내용을 조회한다.
			        	conDataCall(event.data.statblId, event.data.bbsCd, event.data.seq);
			            return false;
			         });
		         
					// 제목 링크에 키다운 이벤트를 바인딩한다.
					$(this).bind("keydown", {
						statblId:data[i].statblId,
						bbsCd:data[i].bbsCd,
			            seq:data[i].seq
					}, function(event) {
						if (event.which == 13) {
							// 내용을 조회한다.
							conDataCall(event.data.statblId, event.data.bbsCd, event.data.seq);
							return false;
						}
					});
				});
				table.append(row);
		
			}
		}
	
	}
	if (data.length == 0) {
		var row = $(templates.none);
		table.append(row);
	}
	if(bbsCd == "NABOE"){ 
		$(".orgNm").hide();
		$("#orgNmM").hide();
	}else{
		$("#contentsOrgNm").css("display", "");
		$("#orgNmM").css("display", "");
		$("#orgNm").css("display", "");
		$(".orgNm").css("display", "");
	}
}

/**
 * 상세분석 정의
 * @returns
 */
function detailAnalysis(){
	var sttsctSeq = $("#seq").val();
	doAjax({
		url : "/portal/stat/selectDtlAnalysisList.do",
		params : {seq : sttsctSeq},
		callback : function(res) {
			var data = res.data;
			if (data.length > 0) {
				$("#detailAnalysis").show();
				for ( var i=0; i < data.length; i++ ) {
					var statblId = data[0].STATBL_ID;
					$("#detailAnalysis").attr("href", "javascript:goStatsUrl('"+statblId+"');");
				}
			} else {
			    //상세조회 없을시 버튼 삭제
				$("#detailAnalysis").hide();
				return false;
			}
		}
	});
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
