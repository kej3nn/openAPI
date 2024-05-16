/*
 * COPYRIGHT (C) 2013 WISEITECH CO., LTD. ALL RIGHTS RESERVED.
 */

/**
	장홍식
 */
$(function() {
    // 컴포넌트를 초기화한다.
    initComp();
    
    // 이벤트를 바인딩한다.
    bindEvent();
    
    // 옵션을 로드한다.
    loadOptions();
    
    // 데이터를 로드한다.
    loadData();
    
    // 시트데이터를 로드한다.
    loadSheet();
});

////////////////////////////////////////////////////////////////////////////////
//글로벌 변수
////////////////////////////////////////////////////////////////////////////////
var templates = {
	attachFile : 
		"<li>	"
		+ " 	<input type=\"file\" name=\"examImg\" class=\"f_65per f_80per\" title=\"화면 예시 첨부파일\" />"
		+ " 	<a title=\"첨부파일 행 삭제\" style=\"cursor:pointer;\"><img src=\"" + com.wise.help.url("/img/ggportal/desktop/common/btn_delete.png") + "\"  alt=\"\" /></a>"
		+ " </li>"
	, linkUrl :
		"<li>	"
		+"	<div class=\"area_form area_connect\">	"
		+"		<div>	"
		+"			<span>연결명</span>	"
		+"			<input type=\"text\" title=\"연결명 입력\" name=\"linkNm\" />	"
		+"		</div>	"
		+"		<div>	"
		+"			<span>URL</span>	"
		+"			<input type=\"text\" title=\"URL 입력\" name=\"url\"/>	"
		+"			<a title=\"연결 행 삭제\" style=\"cursor:pointer;\"><img src=\"" + com.wise.help.url("/img/ggportal/desktop/common/btn_delete.png") + "\" alt=\"\" /></a>"
		+"		</div>	"
		+"	</div>	"
		+"</li>"
	, openInf :
		"<li>"
		+ "<a href=\"javascript:;\" onclick=\"goDel(this);\" title=\"활용데이터 행 삭제\" style=\"cursor:pointer;\"><img src=\"" + com.wise.help.url("/img/ggportal/desktop/common/btn_delete.png") + "\"  alt=\"\" /></a>"
		+ "<input type=\"hidden\" name=\"infId\">"
		+ " </li>",
};

////////////////////////////////////////////////////////////////////////////////
//초기화 함수
////////////////////////////////////////////////////////////////////////////////
//시트초기화
function loadSheet() {
	
	createIBSheet2(document.getElementById("sheet"), "sheet", "100%", "300px");
	
	var gridTitle ="NO|선택|활용데이터ID|활용데이터명|분류|부서|이용\n허락조건|개방일|상태";
		
		
    with(sheet){
    	                     
    	var cfg = {SearchMode:2, Page:50, VScrollMode:1};
        SetConfig(cfg);
        var headers = [
                    {Text:gridTitle, Align:"Center"}
                ];
        var headerInfo = {Sort:0,ColMove:1,ColResize:1,HeaderCheck:1};
        
        InitHeaders(headers, headerInfo);
        
	    var cols = [
	    	{Type:"Seq",		SaveName:"seq",				Width:30,	Align:"Center",		Edit:false}
	    	, {Type:"CheckBox",	SaveName:"check",			Width:60,	Align:"Center",		Edit:true}
            , {Type:"Text",		SaveName:"infId",			Width:100,	Align:"Center",		Edit:false,	Hidden:true}
			, {Type:"Text",		SaveName:"infNm",			Width:500,	Align:"Left",		Edit:false,	Hidden:false}
			, {Type:"Text",		SaveName:"cateNm",			Width:100,	Align:"Left",		Edit:false,	Hidden:false}
			, {Type:"Text",		SaveName:"orgNm",			Width:190,	Align:"Left",		Edit:false,	Hidden:true}
			, {Type:"Text",		SaveName:"cclNm",			Width:100,	Align:"Left",		Edit:false,	Hidden:true}
			, {Type:"Text",		SaveName:"openDttm",		Width:90,	Align:"Center",		Edit:false,	Hidden:true, Format:"Ymd"}
			, {Type:"Combo",	SaveName:"infState",		Width:80,	Align:"Center",		Edit:false,	Hidden:true}
        ];
	    
        InitColumns(cols);
        //FitColWidth();
        SetExtendLastCol(1);
        
        setSheetOptions();	// 상태 옵션처리
    }               
    default_sheet(sheet);
    
    doAction("search");
} 
/**
 * 시트 컬럼옵션을 설정한다.
 */
function setSheetOptions() {
	loadSheetOptions("sheet", 0, "infState", "/portal/common/code/searchCommCode.do", 	{grpCd:"D1007"});	//공개상태 구분코드
}

/**
 * 컴포넌트를 초기화한다.
 */
function initComp() {

}

/**
 * 이벤트를 바인딩한다.
 */
function bindEvent() {
	$("button[name=btn_search]").click(function(e) { 
		doAction("search");                
		return false;                
	});
    
    // 추가
	$("a[name=a_add]").bind("click", function(e) {
		add();
		return false;
	})
    
    //활용데이터 팝업
    $("#openInfBtn").bind("click", function() {
    	var $infId = $("input[id=infId]");
    	if ( $infId.length > 0 ) {
    		$infId.each(function(i, v) {
    			var findRow = sheet.FindText("infId", v.value, 0);
    			sheet.SetCellValue(findRow, "check", 1);
    		});
    	}
    	var sect = $("div[id=openInf-sect]");
    	sheet.SetBlur();
    	sect.show().focus();
    	$("#openInf-search-pop").css("top",  (($(window).height() - $("#openInf-search-pop").height()) / 2) + "px");    	
    });
    
    // 시트 사용자 정의 컬럼유형기능 레이어 팝업 닫기 이벤트 추가
    bindSheetUsrDef();
        
    // 일반 게시판 내용 등록 폼에 제출 이벤트를 바인딩한다.
    $("#gallery-insert-form").bind("submit", function(event) {
        return false;
    });
    
    // 일반 게시판 내용 목록 버튼에 클릭 이벤트를 바인딩한다.
    $("#gallery-search-button").bind("click", function(event) {
        // 일반 게시판 내용을 검색한다.
        searchBoard($("#gallery-search-form [name=page]").val());
        return false;
    });
    
    // 일반 게시판 내용 목록 버튼에 키다운 이벤트를 바인딩한다.
    $("#gallery-search-button").bind("keydown", function(event) {
        if (event.which == 13) {
            // 일반 게시판 내용을 검색한다.
            searchBoard($("#gallery-search-form [name=page]").val());
            return false;
        }
    });
    
    // 일반 게시판 내용 확인 버튼에 클릭 이벤트를 바인딩한다.
    $("#gallery-insert-button").bind("click", function(event) {
        // 일반 게시판 내용을 등록한다.
        insertBoard();
        return false;
    });
    
    // 일반 게시판 내용 확인 버튼에 키다운 이벤트를 바인딩한다.
    $("#gallery-insert-button").bind("keydown", function(event) {
        if (event.which == 13) {
            // 일반 게시판 내용을 등록한다.
            insertBoard();
            return false;
        }
    });
    
  
    
    // 일반 게시판 내용 취소 버튼에 클릭 이벤트를 바인딩한다.
    $("#gallery-cancel-button").bind("click", function(event) {
        // 일반 게시판 내용을 취소한다.
        cancelBoard();
        return false;
    });
    
    // 일반 게시판 내용 취소 버튼에 키다운 이벤트를 바인딩한다.
    $("#gallery-cancel-button").bind("keydown", function(event) {
        if (event.which) {
            // 일반 게시판 내용을 취소한다.
            cancelBoard();
            return false;
        }
    });
    
   
    // 화면 예시 첨부파일 추가 버튼
    $("#examImgAddBtn").bind("click", function() {
    	var row = $(templates.attachFile);
    	row.find("a").bind("click", function() {
    		$(this).parent().remove();
    	});
    	$("#examImgList").append(row);
    });
    
    // 링크 URL 추가 버튼
    $("#linkUrlAddBtn").bind("click", function() {
    	var row = $(templates.linkUrl);
    	row.find("a").bind("click", function() {
    		$(this).parent().parent().parent().remove();
    	});
    	$("#linkUrlList").append(row);
    });

    // 안내수신 문자 체크
	$("#dvpHpYn, #dvpKakaoYn").bind("click", function(e) {
		if( $("#gallery-insert-form").find("input:checkbox[id='dvpHpYn']").is(":checked") && $("#gallery-insert-form").find("input:checkbox[id='dvpKakaoYn']").is(":checked") ) {
			alert("SMS와 카카오알림톡은 동시에 선택할 수 없습니다.");
			return false;
		}
	});
}

/**
 * 옵션을 로드한다.
 */
function loadOptions() {

}

/**
 * 데이터를 로드한다.
 */
function loadData() {
	
	// 활용 인증키 목록 조회
	doSelect({
        url:"/portal/myPage/searchBbsDvp.do",
        before:function(){return {};},
        after:afterSearchBbsDvp
	});
}
function afterSearchBbsDvp(data) {
	if (data[0]) {
    	for (var key in data[0]) {
        	var value = data[0][key] ? data[0][key]:"";
            $("#gallery-insert-form").find("[name=" + key + "]").each(function(index, element) {
                switch ($(this).prop("tagName").toLowerCase()) {
                    case "input":
                        switch ($(this).attr("type")) {
                            case "checkbox":
                            case "radio":
                                if ($(this).val() == value) {
                                    $(this).prop("checked", true);
                                }
                                break;
                        }
                        break;
                }
            });
        }
    }
}

////////////////////////////////////////////////////////////////////////////////
// 서비스 함수
////////////////////////////////////////////////////////////////////////////////
/**
 * 일반 게시판 내용을 검색한다.
 *
 * @param page {String} 페이지 번호
 */
function searchBoard(page) {
    // 데이터를 검색하는 화면으로 이동한다.
    goSearch({
        url:"/portal/myPage/utilGalleryPage.do",
        form:"gallery-search-form",
        data:[{
            name:"page",
            value:page ? page : "1"
        }]
    });
}


/**
 * 일반 게시판 내용을 등록한다.
 */
function insertBoard() {
    // 데이터를 등록한다.
    doInsert({
        url:("/portal/myPage/insertUtilGallery.do"),
        form:"gallery-insert-form",
        before:beforeInsertBoard,
        after:afterInsertBoard
    });
}


/**
 * 일반 게시판 내용을 취소한다.
 */
function cancelBoard() {
    // 일반 게시판 내용을 검색한다.
    searchBoard($("#gallery-search-form [name=page]").val());
}


////////////////////////////////////////////////////////////////////////////////
//전처리 함수
////////////////////////////////////////////////////////////////////////////////
/**
* 일반 게시판 내용 등록 전처리를 실행한다.
* 
* @param options {Object} 옵션
* @returns {Object} 데이터
*/
function beforeInsertBoard(options) {
    var form = $("#gallery-insert-form");

    if (com.wise.util.isBlank(form.find("[name=userNm]").val())) {
        alert("제작자명을 입력하여 주십시오.");
        form.find("[name=userNm]").focus();
        return false;
    }
    
    if (!com.wise.util.isLength(form.find("[name=userNm]").val(), 1, 20)) {
        alert("제작자명을 20자 이내로 입력하여 주십시오.");
        form.find("[name=userNm]").focus();
        return false;
    }
    
    if (com.wise.util.isBlank(form.find("[name=bbsTit]").val())) {
        alert("제목을 입력하여 주십시오.");
        form.find("[name=bbsTit]").focus();
        return false;
    }
   
    if (!com.wise.util.isLength(form.find("[name=bbsTit]").val(), 1, 100)) {
        alert("제목을 100자 이내로 입력하여 주십시오.");
        form.find("[name=bbsTit]").focus();
        return false;
    }
    
    if (com.wise.util.isBlank(form.find("[name=bbsCont]").val())) {
        alert("주요기능을 입력하여 주십시오.");
        form.find("[name=bbsCont]").focus();
        return false;
    }

    /*if (com.wise.util.isBlank(form.find("[name=mainImg]").val())) {
    	alert("대표 이미지를 첨부해 주세요.");
    	form.find("[name=mainImg]").focus();
    	return false;
    }*/
    
    var pattern = /(.)+\.(bmp|gif|ief|jpe|jpeg|jpg|png|tif|tiff)$/;
	var message = "BMP, GIF, IEF, JPG, PNG, TIF 그림 파일만 첨부할 수 있습니다.";
    /*if (!pattern.test(form.find("[name=mainImg]").val())) {
    	alert(message);
    	form.find("[name=mainImg]").focus();
    	return false;
    }*/
    
    var addedExamImgCnt = 0;
    var invalid = -1;
    form.find("[name=examImg]").each(function(i, d) {
    	var thisVal = $(this).val().toLowerCase();
    	if(!com.wise.util.isBlank(thisVal)) {
    		if(!pattern.test(thisVal)) {
    			invalid = i;
    			return false;
    		} else {
    			addedExamImgCnt++;
    		}
    	}
    });
    if (invalid >= 0) {
        alert(message);
        form.find("[name=examImg]:eq(" + invalid + ")").focus();
        return false;
    }
    
    if(addedExamImgCnt == 0) {
    	alert("화면 예시 이미지를 1개 이상 첨부해 주세요.");
    	form.find("[name=examImg]").focus();
    	return false;
    }
    
    var elNm = "";
    $('#linkUrlList div div').each(function(i, d) {
    	if (i % 2 == 1) {
    		var linkUrl = $(this).find("[name=url]").val();
    		if(com.wise.util.isBlank(linkUrl)) {
        		invalid = i;
    			elNm = "url";
        		return false;
        	}
		} else {
			var linkNm = $(this).find("[name=linkNm]").val();
			if(com.wise.util.isBlank(linkNm)) {
				invalid = i;
				elNm = "linkNm";
				return false;
	    	}
		}
    });
    if(invalid >= 0) {
    	alert("연결 정보를 입력해 주세요.");
    	form.find("[name="+elNm+"]:eq(" + invalid + ")").focus();
    	return false;
    }
    
    linkInvalid = -1;
    $('#linkUrlList div div').each(function(i, d) {
    	if (i % 2 == 1) {
    		var linkUrl = $(this).find("[name=url]").val();
    		if (!checkUrl(linkUrl)) {
    			linkInvalid = i;
				elNm = "url";
				return false;
    		}
    	}
    });
    
    if(linkInvalid >= 0) {
    	alert("URL 형식이 맞지 않습니다.");
    	form.find("[name="+elNm+"]:eq(" + linkInvalid + ")").focus();
    	return false;
    }
    
	return true;
}

function checkUrl(url){
    return url.match(/(http|ftp|https):\/\/[\w\-_]+(\.[\w\-_]+)+([\w\-\.,@?^=%&amp;:/~\+#]*[\w\-\@?^=%&amp;/~\+#])?/);
}
////////////////////////////////////////////////////////////////////////////////
//후처리 함수
////////////////////////////////////////////////////////////////////////////////
/**
* 일반 게시판 내용 등록 후처리를 실행한다.
* 
* @param messages {Object} 메시지
*/
function afterInsertBoard(messages) {
	// 일반 게시판 내용을 검색한다.
	searchBoard();
}


function doAction(sAction) {
	var formObj = $("#gallery-insert-form");
	var openInfFormObj = $("#openInf-search-form");
	
	switch(sAction) {
		case "search" :
			sheet.DoSearch("/portal/myPage/popup/selectOpenInfSearchPop.do", openInfFormObj.serialize());
			break;
	}
}
function goDel(id){
	$(id).parent().remove()
}

//시트레이어 팝업 닫기 이벤트 추가
function bindSheetUsrDef() {
	// 레이어 팝업 닫기
	$("div[id=openInf-sect]").find(".pop-close").unbind("click").bind("click", function(e) {
		sheet.SetFocus();
		$("div[id=openInf-sect]").hide();
		return false;
	}).unbind("keydown").bind("keydown", function(e){
		if (e.which == 13) {
			sheet.SetFocus();
			$("div[id=openInf-sect]").hide();
			return false;
		}
	});
	$("div[id=openInf-sect]").find("a[name=a_close]").unbind("click").bind("click", function(e) {
		sheet.SetFocus();
		$("div[id=openInf-sect]").hide();
		return false;
	}).unbind("keydown").bind("keydown", function(e){
		if (e.which == 13) {
			sheet.SetFocus();
			$("div[id=openInf-sect]").hide();
			return false;
		}
	});
}

/**
 * 부모 시트에 선택한 데이터를 추가한다.
 */
function add() {
	var	html = "",
	strChkRows = sheet.FindCheckedRow("check"),
	chkRows = strChkRows.split('|');
	
	
	if ( gfn_isNull(strChkRows) ) {
 		alert("추가하려는 활용데이터를 선택하세요.");
 		return false;
 	}
	$("ul[name=openInfList]").empty();
	
	for ( var i=0; i < chkRows.length; i++ ) {
		html += "<li>" +sheet.GetCellValue(chkRows[i], "infNm")
		html += "<a href=\"javascript:;\" onclick=\"goDel(this);\" title=\"활용데이터 행 삭제\" style=\"cursor:pointer;\"><img src=\"" + com.wise.help.url("/img/ggportal/desktop/common/btn_delete.png") + "\"  alt=\"\" /></a>"
		html += "<input type=\"hidden\" name=\"infId\" value=\""+sheet.GetCellValue(chkRows[i], "infId") +"\">";
		html += "</li>"
	}
	$("ul[name=openInfList]").append(html);
	$("#openInf-sect").hide();
}