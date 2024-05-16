/*
 * 
 * COPYRIGHT (C) 2013 WISEITECH CO., LTD. ALL RIGHTS RESERVED.
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
			+"			<a title=\"연결 행 삭제\" style=\"cursor:pointer;\"><img src=\"" + com.wise.help.url("/img/ggportal/desktop/common/btn_delete.png") + "\" alt=\"\" /></a>	"
			+"		</div>	"
			+"	</div>	"
			+"</li>"
		, openInf :
			"<li>  "
			+ "<span class=\"openInf\"></span>" 
			+ "<a href=\"javascript:;\" onclick=\"goDel(this);\" title=\"활용데이터 행 삭제\" style=\"cursor:pointer;\"><img src=\"" + com.wise.help.url("/img/ggportal/desktop/common/btn_delete.png") + "\"  alt=\"\" /></a>"
			+ "<input type=\"hidden\" name=\"infId\">"
			+ " </li>"
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
	    	, {Type:"CheckBox",	SaveName:"check",			Width:50,	Align:"Center",		Edit:true}
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
    // Nothing to do.
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
	
    //  내용 등록 폼에 제출 이벤트를 바인딩한다.
    $("#gallery-update-form").bind("submit", function(event) {
        return false;
    });
    
    //  내용 목록 버튼에 클릭 이벤트를 바인딩한다.
    $("#gallery-search-button").bind("click", function(event) {
        //  내용을 검색한다.
        searchBoard($("#gallery-search-form [name=page]").val());
        return false;
    });
    
    //  내용 목록 버튼에 키다운 이벤트를 바인딩한다.
    $("#gallery-search-button").bind("keydown", function(event) {
        if (event.which == 13) {
            //  내용을 검색한다.
            searchBoard($("#gallery-search-form [name=page]").val());
            return false;
        }
    });
    
    // 수정 버튼에 클릭 이벤트를 바인딩한다.
    $("#gallery-update-button").bind("click", function(event) {
        //  내용을 수정한다.
        updateGallery();
        return false;
    });
    
    //  수정 버튼에 키다운 이벤트를 바인딩한다.
    $("#gallery-update-button").bind("keydown", function(event) {
        if (event.which == 13) {
            //  내용을 수정한다.
        	updateGallery();
            return false;
        }
    });
    
    //  내용 취소 버튼에 클릭 이벤트를 바인딩한다.
    $("#gallery-cancel-button").bind("click", function(event) {
        //  내용을 취소한다.
        cancelBoard();
        return false;
    });
    
    //  내용 취소 버튼에 키다운 이벤트를 바인딩한다.
    $("#gallery-cancel-button").bind("keydown", function(event) {
        if (event.which) {
            //  내용을 취소한다.
            cancelBoard();
            return false;
        }
    });
    
    // 대표이미지 추가시 기존 이미지 삭제
    $("[name=mainImg]").change(function() {
    	
    	$("#gallery-mainattach-list li a").click();
    	
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
    
    // 결정통지 체크
    $("#dvpHpYn, #dvpKakaoYn").bind("click", function(e) {
    	if ($("#gallery-update-form").find("input:checkbox[id='dvpHpYn']").is(":checked") && $("#gallery-update-form").find("input:checkbox[id='dvpKakaoYn']").is(":checked")) {
    		alert("SMS와 카카오알림톡은 동시에 선택할 수 없습니다.");
    		return false;
    	}
    });
}

/**
 * 옵션을 로드한다.
 */
function loadOptions() {
    // Nothing do do.
}

/**
 * 데이터를 로드한다.
 */
function loadData() {
    // 갤러리 게시판 내용을 조회한다.
    selectGallery();
}

////////////////////////////////////////////////////////////////////////////////
//서비스 함수
////////////////////////////////////////////////////////////////////////////////
/**
 * 갤러리 게시판 내용을 조회한다.
 */
function selectGallery() {
    // 데이터를 조회한다.
    doSelect({
        url:resolveUrl("/selectBulletin.do"),
        before:beforeSelectGallery,
        after:afterSelectGallery
    });
}

/**
 * 갤러리 내용 수정
 */
function updateGallery() {
    // 데이터를 수정한다.
    doUpdate({
        url:"/portal/myPage/updateUtilGallery.do",
        form:"gallery-update-form",
        before:beforeUpdateBoard,
        after:afterUpdateBoard
    });
}


/**
 *  내용을 검색한다.
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
 *  내용을 취소한다.
 */
function cancelBoard() {
    // 데이터를 조회하는 화면으로 이동한다.
    goSelect({
        url:"/portal/myPage/selectUtilGalleryPage.do",
        form:"gallery-search-form"
    });
}

/**
 * URL을 반환한다.
 * 
 * @param url {String} URL
 */
function resolveUrl(url) {
    var matches = window.location.href.match(/\/portal\/[^\/]+\//);
    
    return matches[0] + $("#gallery-search-form [name=bbsCd]").val().toLowerCase() + url;
}

////////////////////////////////////////////////////////////////////////////////
//전처리 함수
////////////////////////////////////////////////////////////////////////////////
/**
*  갤러리 게시판 내용 조회 전처리를 실행한다.
* 
* @param options {Object} 옵션
* @returns {Object} 데이터
*/
function beforeSelectGallery(options) {
	var data = {
	// Nothing do do.
	};

	var form = $("#gallery-search-form");

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

	if (com.wise.util.isBlank(data.bbsCd)) {
		return null;
	}
	if (com.wise.util.isBlank(data.seq)) {
		return null;
	}

	return data;
}

// 수정 시 전처리 함수
function beforeUpdateBoard() {
	
    var form = $("#gallery-update-form");

    if (com.wise.util.isBlank(form.find("[name=bbsCd]").val())) {
        alert("수정할 데이터가 없습니다.");
        return false;
    }
    if (com.wise.util.isBlank(form.find("[name=seq]").val())) {
        alert("수정할 데이터가 없습니다.");
        return false;
    }
    
    if (com.wise.util.isBlank(form.find("[name=userNm]").val())) {
        alert("제작자명을 입력하여 주십시오.");
        form.find("[name=userNm]").focus();
        return false;
    }
    // if (!com.wise.util.isBytes(form.find("[name=userNm]").val(), 1, 100)) {
    //     alert("작성자를 100바이트 이내로 입력하여 주십시오.");
    //     form.find("[name=userNm]").focus();
    //     return false;
    // }
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

    /*if (com.wise.util.isBlank(form.find("[name=mainImg]").val()) && $("#gallery-mainattach-list").html() == "") {
    	alert("대표 이미지를 첨부해 주세요.");
    	form.find("[name=mainImg]").focus();
    	return false;
    }*/
    
    var pattern = /(.)+\.(bmp|gif|ief|jpe|jpeg|jpg|png|tif|tiff)$/;
	var message = "BMP, GIF, IEF, JPG, PNG, TIF 그림 파일만 첨부할 수 있습니다.";
   /* if (!com.wise.util.isBlank(form.find("[name=mainImg]").val() && !pattern.test(form.find("[name=mainImg]").val()))) {
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
    addedExamImgCnt = addedExamImgCnt + $('#gallery-attach-list li').length;
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
 * 갤러리 게시판 내용 조회 후처리를 실행한다.
 * 
 * @param data
 *            {Object} 데이터
 */
function afterSelectGallery(data) {
    for (var key in data) {
    	var value = data[key] ? data[key]:"";
        $("#gallery-update-form").find("[name=" + key + "]").each(function(index, element) {
            switch ($(this).prop("tagName").toLowerCase()) {
                case "input":
                    switch ($(this).attr("type")) {
                        case "hidden":
                        case "text":
                        case "tel":
                        case "email":
                            $(this).val(value);
                            break;
                        case "checkbox":
                        case "radio":
                            if ($(this).val() == value) {
                                $(this).prop("checked", true);
                            }
                            break;
                    }
                    break;
                case "textarea":
                    $(this).val(value);
                    break;
            }
        });
    }
    
    if (data.fileCnt) {
        if (data.files) {
        	var mainFiles = new Array();
        	var exFiles = new Array();
        	$.each(data.files, function(i, d) {
        		if(d.topYn == 'Y') {
        			mainFiles.push(d);
        		} else {
        			exFiles.push(d);
        		}
        	});
        	
            // 메인 파일을 처리한다.
            handleFiles(mainFiles, {
                mode:"update",
                attacher:"gallery-mainattach-list",
                form:"gallery-update-form",
                detach:"dtchMainFile"
            });
            
            // 예시 파일을 처리한다.
            handleFiles(exFiles, {
                mode:"update",
                attacher:"gallery-attach-list",
                form:"gallery-update-form",
                detach:"dtchFile"
            });
        }
    }
    
    // 링크 정보 처리
    if (data.linkCnt) {
    	if (data.link) {
    		$.each(data.link, function(i, d) {
    			if(i == 0) {
    				$("[name=linkNm]").val(d["linkNm"]);
    				$("[name=url]").val(d["url"]);
    			} else {
    		    	var row = $(templates.linkUrl);
    		    	row.find("a").bind("click", function() {
    		    		$(this).parent().parent().parent().remove();
    		    	});
    		    	row.find("[name=linkNm]").val(d["linkNm"]);
    		    	row.find("[name=url]").val(d["url"]);
    		    	$("#linkUrlList").append(row);
    			}
    		});
    	}
    }
    // 활용데이터
    if (data.infCnt) {
    	if (data.data) {
    		$.each(data.data, function(i, d) {
				var row = $(templates.openInf);
				row.find(".openInf").text(d["infNm"]);
				row.find("[name=infId]").val(d["infId"]);
				$("#openInfList").append(row);
    		});
    	}
    }
    if (data.dvp) {
    	var dt = data.dvp;
    	for (var key in dt[0]) {
        	var value = dt[0][key] ? dt[0][key]:"";
            $("#gallery-update-form").find("[name=" + key + "]").each(function(index, element) {
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

// 수정 후처리 이벤트
function afterUpdateBoard() {
	searchBoard();
}


function doAction(sAction) {
	var formObj = $("#gallery-update-form");
	var openInfFormObj = $("#openInf-search-form");
	
	switch(sAction) {
	case "catePop" :	// 분류정보 추가 팝업(선택 시 부모 시트로 데이터 이동)
		var url = com.wise.help.url("/portal/myPage/popup/openInfSearchPop.do");
		var data = "?parentFormNm=mainForm";
		$("#openInfList").find("input[name=infId]").each(function(i, v) {
			data += "&infId=" + v.value;
		});
		
		openIframeStatPop("iframePopUp", url+data, 660, 530);
		break;
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
