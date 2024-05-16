/*
 * @(#)selectSheet.js 1.0 2015/06/15
 * 
 * COPYRIGHT (C) 2013 WISEITECH CO., LTD. ALL RIGHTS RESERVED.
 */

/**
 * 공공데이터 시트 서비스를 조회하는 스크립트이다.
 *
 * @author 김은삼
 * @version 1.0 2015/06/15
 */
$(function() {
	
    // 컴포넌트를 초기화한다.
    initComp();
    
    // 마스크를 바인딩한다.
    bindMask();
    
    // 이벤트를 바인딩한다.
    bindEvent();
    
    // 옵션을 로드한다.
    loadOptions();
    
    // 데이터를 로드한다.
    loadData();
    
});

////////////////////////////////////////////////////////////////////////////////
// 글로벌 변수
////////////////////////////////////////////////////////////////////////////////
/**
 * 템플릿
 */
var templates = {
    data:
        "<tr>"                                                       +
            "<td align=\"center\"><input type=\"checkbox\" /></td>"  +
            "<td align=\"center\"><span class=\"code\"></span></td>" +
            "<td align=\"left\"><span class=\"name\"></span></td>"   +
        "</tr>",
    none:
        "<tr>"                                                                               +
            "<td colspan=\"3\"><span class=\"noData\">검색된 데이터가 없습니다.</span></td>" +
        "</tr>"
};

/**
 * 추천 템플릿
 */
var templates2 = {
	    data:
	        "<li><a href=\"#none\">"                                                       +
	            "<span class=\"img\"><img src=\"\" alt=\"\" class=\"thumbnail_dataSet metaImagFileNm\"></span>" +
	            "<div class=\"dataset_boxlist\">"                                               				+
	            "<div class=\"dataset_box_text\">"                                               					+
	            "<em class=\"m_cate\"></em>"                                               										+
	            "<i class=\"ot01 infsTag\"></i>"                                               										+
	            "</div>"                                               											+
	            "<span class=\"txt\"></span>"                                               					+
	            "</div>"                                               											+
	        "</a></li>",  
	       none:
	           "<li><a href=\"#none\">"                                                       +
	           "<img src=\"\" alt=\"\">"                                                  +
	           "<span class=\"txt\">데이터가 없습니다.</span>" +
	       "</a></li>"  
	};


////////////////////////////////////////////////////////////////////////////////
// 초기화 함수
////////////////////////////////////////////////////////////////////////////////

function initComp() {
	
    // 윈도우 단위에서 키가 눌리면
    $(window).keyup(function (e) {
        // 발생한 이벤트에서 키 코드 추출, BackSpace 키의 코드는 8
    	if(e.target.nodeName != "INPUT" && e.target.nodeName != "TEXTAREA"){
        if (e.keyCode == 8) {        	
        	searchDataset();	       	
        }
    	}
    });
    
}






/**
 * 컴포넌트를 초기화한다.
 */
//function initComp() {
//    // Nothing to do.
//}

/**
 * 마스크를 바인딩한다.
 */
function bindMask() {
    // Nothing to do.
	
	if($("input[name=loc]").val() != ""){
		$(".recommendDataset").hide();
	}
}

/**
 * 이벤트를 바인딩한다.
 */
function bindEvent() {
	
    // 공공데이터 시트 서비스 필터검색 버튼에 클릭 이벤트를 바이딩한다.
    $("#sheet-search-button").bind("click", function(event) {
        // 공공데이터 시트 서비스 데이터를 검색한다.
        searchSheetData();
        return false;
    });
    
    // 공공데이터 시트 서비스 필터검색 버튼에 키다운 이벤트를 바이딩한다.
    $("#sheet-search-button").bind("keydown", function(event) {
        if (event.which == 13) {
            // 공공데이터 시트 서비스 데이터를 검색한다.
            searchSheetData();
            return false;
        }
    });
    
    // // 공공데이터 시트 서비스 팝업 코드 검색어 필드에 키다운 이벤트를 바이딩한다.
    // $("#sheet-popup-search-form").find("[name=searchWord]").bind("keydown", function(event) {
    //     if (event.which == 13) {
    //         // 공공데이터 시트 서비스 팝업 코드를 검색한다.
    //         searchSheetPopupCode();
    //         return false;
    //     }
    // });
    
    // // 공공데이터 시트 서비스 팝업 코드 조회 버튼에 클릭 이벤트를 바이딩한다.
    // $("#sheet-popup-search-button").bind("click", function(event) {
    //     // 공공데이터 시트 서비스 팝업 코드를 검색한다.
    //     searchSheetPopupCode();
    //     return false;
    // });
    
    // // 공공데이터 시트 서비스 팝업 코드 조회 버튼에 키다운 이벤트를 바이딩한다.
    // $("#sheet-popup-search-button").bind("keydown", function(event) {
    //     if (event.which == 13) {
    //         // 공공데이터 시트 서비스 팝업 코드를 검색한다.
    //         searchSheetPopupCode();
    //         return false;
    //     }
    // });
    
    // // 공공데이터 시트 서비스 팝업 코드 닫기 버튼에 클릭 이벤트를 바이딩한다.
    // $("#sheet-popup-close-button").bind("click", function(event) {
    //     // 공공데이터 시트 서비스 팝업 코드 검색 화면을 숨긴다.
    //     hideSheetPopupCode();
    //     return false;
    // });
    
    // // 공공데이터 시트 서비스 팝업 코드 닫기 버튼에 키다운 이벤트를 바이딩한다.
    // $("#sheet-popup-close-button").bind("keydown", function(event) {
    //     if (event.which == 13) {
    //         // 공공데이터 시트 서비스 팝업 코드 검색 화면을 숨긴다.
    //         hideSheetPopupCode();
    //         return false;
    //     }
    // });
    
    // 공공데이터 시트 서비스 XML 버튼에 클릭 이벤트를 바인딩한다.
    $("#sheet-xml-button").bind("click", function(event) {
        // 공공데이터 시트 서비스 데이터를 다운로드한다.
        downloadSheetData("X");
        return false;
    });
    
    // 공공데이터 시트 서비스 XML 버튼에 키다운 이벤트를 바인딩한다.
    $("#sheet-xml-button").bind("keydown", function(event) {
        if (event.which == 13) {
            // 공공데이터 시트 서비스 데이터를 다운로드한다.        	
            downloadSheetData("X");
            return false;
        }
    });
    
    // 공공데이터 시트 서비스 JSON 버튼에 클릭 이벤트를 바인딩한다.
    $("#sheet-json-button").bind("click", function(event) {
        // 공공데이터 시트 서비스 데이터를 다운로드한다.
        downloadSheetData("J");
        return false;
    });
    
    // 공공데이터 시트 서비스 JSON 버튼에 키다운 이벤트를 바인딩한다.
    $("#sheet-json-button").bind("keydown", function(event) {
        if (event.which == 13) {
            // 공공데이터 시트 서비스 데이터를 다운로드한다.
            downloadSheetData("J");
            return false;
        }
    });
    
    // 공공데이터 시트 서비스 EXCEL 버튼에 클릭 이벤트를 바인딩한다.
    $("#sheet-excel-button").bind("click", function(event) {
        // 공공데이터 시트 서비스 데이터를 다운로드한다.
        downloadSheetData("E");
        return false;
    });
    
    // 공공데이터 시트 서비스 EXCEL 버튼에 키다운 이벤트를 바인딩한다.
    $("#sheet-excel-button").bind("keydown", function(event) {
        if (event.which == 13) {
        	// 공공데이터 시트 서비스 데이터를 다운로드한다.
            downloadSheetData("E");
            return false;
        }
    });
    
    // 공공데이터 시트 서비스 CSV 버튼에 클릭 이벤트를 바인딩한다.
    $("#sheet-csv-button").bind("click", function(event) {
        // 공공데이터 시트 서비스 데이터를 다운로드한다.
        downloadSheetData("C");
        return false;
    });
    
    // 공공데이터 시트 서비스 CSV 버튼에 키다운 이벤트를 바인딩한다.
    $("#sheet-csv-button").bind("keydown", function(event) {
        if (event.which == 13) {
            // 공공데이터 시트 서비스 데이터를 다운로드한다.
            downloadSheetData("C"); 
            return false;
        }
    });
    
    // 공공데이터 시트 서비스 TXT 버튼에 클릭 이벤트를 바인딩한다.
    $("#sheet-txt-button").bind("click", function(event) {
        // 공공데이터 시트 서비스 데이터를 다운로드한다.
        downloadSheetData("T");
        return false;
    });
    
    // 공공데이터 시트 서비스 TXT 버튼에 키다운 이벤트를 바인딩한다.
    $("#sheet-txt-button").bind("keydown", function(event) {
        if (event.which == 13) {
            // 공공데이터 시트 서비스 데이터를 다운로드한다.
            downloadSheetData("T");
            return false;
        }
    });
    
    // 공공데이터 시트 서비스 RDF 버튼에 클릭 이벤트를 바인딩한다.
    $("#sheet-rdf-button").bind("click", function(event) {
        // 공공데이터 시트 서비스 데이터를 다운로드한다.
        downloadSheetData("R");
        return false;
    });
    
    // 공공데이터 시트 서비스 RDF 버튼에 키다운 이벤트를 바인딩한다.
    $("#sheet-rdf-button").bind("keydown", function(event) {
        if (event.which == 13) {
            // 공공데이터 시트 서비스 데이터를 다운로드한다.
            downloadSheetData("R");
            return false;
        }
    });
    
    // 공공데이터 시트 서비스 HWP 버튼에 클릭 이벤트를 바인딩한다.
    $("#sheet-hwp-button").bind("click", function(event) {
        // 공공데이터 시트 서비스 데이터를 다운로드한다.
        downloadSheetData("H");
        return false;
    });
    
    // 공공데이터 시트 서비스 HWP 버튼에 키다운 이벤트를 바인딩한다.
    $("#sheet-hwp-button").bind("keydown", function(event) {
        if (event.which == 13) {
            // 공공데이터 시트 서비스 데이터를 다운로드한다.
            downloadSheetData("H");
            return false;
        }
    });
    
    // 공공데이터 데이터셋 목록 버튼에 클릭 이벤트를 바인딩한다.
    $("#dataset-search-button").bind("click", function(event) {
        // 공공데이터 데이터셋 전체목록을 검색한다.
        searchDataset();
        return false;
    });
    
    // 공공데이터 데이터셋 목록 버튼에 키다운 이벤트를 바인딩한다.
    $("#dataset-search-button").bind("keydown", function(event) {
        if (event.which == 13) {
            // 공공데이터 데이터셋 전체목록을 검색한다.
            searchDataset();
            return false;
        }
    });
    
    // 시트 사용자 정의 컬럼유형기능 레이어 팝업 닫기 이벤트 추가
    bindSheetUsrDef();
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
    // 공공데이터 시트 서비스 메타정보를 조회한다.
    selectSheetMeta();
}

////////////////////////////////////////////////////////////////////////////////
// 서비스 함수
////////////////////////////////////////////////////////////////////////////////
/**
 * 공공데이터 시트 서비스 메타정보를 조회한다.
 */
function selectSheetMeta() {
    // 데이터를 조회한다.
    doSelect({
        url:"/portal/data/sheet/selectSheetMeta.do",
        before:beforeSelectSheetMeta,
        after:afterSelectSheetMeta
    });
}

/**
 * 공공데이터 시트 서비스 데이터를 검색한다.
 */
function searchSheetData() {
    // 공공데이터 시트 서비스 검색 필터를 검증한다.
    if (!checkSearchFilters("sheet-search-table")) {
        return;
    }
    
    // 시트 데이터를 로드한다.
    loadSheetData({
        SheetId:"SheetObject",
        PageUrl:"/portal/data/sheet/searchSheetData.do"
    }, {
        FormParam:"sheet-search-form"
    }, {
        // Nothing to do.
    });
}

/**
 * 공공데이터 시트 서비스 데이터를 다운로드한다.
 * 
 * @param type {String} 유형
 */
function downloadSheetData(type) {

    // 공공데이터 시트 서비스 검색 필터를 검증한다.
    if (!checkSearchFilters("sheet-search-table")) {
        return;
    }
    
/*
    if (window["SheetObject"].GetTotalRows() >= 50000) {
    	alert("시스템 성능으로 인해 "+downCnt+"건 이상 데이터는 다운로드되지 않습니다.\n조회조건을 변경하셔서 "+downCnt+"건 이하로 다운로드 하시기 바랍니다.");
    	return;
    }
*/

    var form = $('#sheet-search-form');
    if(type != "H"){
	    form.find("[name=downloadType]").val(type);
//	    var downloadUrl = "/portal/data/sheet/downloadSheetData.do?selCnt="+window["SheetObject"].GetTotalRows()+"&"+form.serialize();
	    //$.fileDownload(downloadUrl);
	    gfn_fileDownload({
	    	url: "/portal/data/sheet/downloadSheetData.do",
	    	params: "selCnt="+window["SheetObject"].GetTotalRows()+"&"+form.serialize()
	    });
	    
	   
	    return false;
    }else{
		/*
		 * Sheet HWP 파일 다운로드
		 */
		var infId = form.find($("input[name=infId]")).val();
		var sheetObj = window["SheetObject"];
		var hwpColArray = new Array();
		
		for(var idx = 0; idx < sheetObj.LastCol() + 1; idx++){
			if(!sheetObj.GetColHidden(idx)){
				hwpColArray.push(idx);
			}
		}
		
		var docTitle = $(".tit").html();
		
		var params = {
   	           Title:{ Text:docTitle, Align:"Center"},
   	           DocOrientation:"Landscape",
   	           DownCols: hwpColArray.join("|"),
					FileName: docTitle
    	} ;
		
		//통계표 다운로드(HWP) 로그 남김
		//insertStatLogs("HWP", {statMulti: "N", statblId: statblId});
		
		sheetObj.Down2Hml(params);
		return false;
    }
}

/**
 * 공공데이터 데이터셋 전체목록을 검색한다.
 */
function searchDataset() {
    
	if($("input[name=loc]").val() != ""){
		var form = $("#dataset-search-form");
		location.href = "/portal/adjust/map/mapSearchPage.do";
	}else{
		// 데이터를 검색하는 화면으로 이동한다.
	    /*
		goSearch({
	        url:"/portal/data/dataset/searchDatasetPage.do",
	        form:"dataset-search-form"
	    });*/
		goSearch({
			url:"/portal/infs/list/infsListPage.do",
			form:"searchForm",
			method: "post"
		});
	}
}

/**
 * 공공데이터 시트 서비스 검색 필터를 추가한다.
 * 
 * @param filters {Array} 필터
 */
function addSheetSearchFilters(filters) {
    if (filters.length > 0) {
        $("#sheet-search-sect").removeClass("hide");
    }
    
    var form = $('#sheet-search-form');
    var sigunFlag = form.find("[name=sigunFlag]").val();
    
    // // 검색 필터를 추가한다.
    // addSearchFilters("sheet-search-table", filters, {
    //     idPrefix:"sheet-filter-",
    //     idKey:"srcColId",
    //     showPopupCode:showSheetPopupCode
    // });
    // 검색 필터를 추가한다.
    addSearchFilters("sheet-search-table", filters, {
        idPrefix:"sheet-filter-",
        idKey:"srcColId",
        onKeyDown:searchSheetData
    }, sigunFlag);
}

// /**
//  * 공공데이터 시트 서비스 팝업 코드 검색 화면을 보인다.
//  * 
//  * @param title {String} 타이틀
//  * @param table {String} 테이블
//  */
// function showSheetPopupCode(title, table) {
//     var form = $("#sheet-popup-search-form");
//     
//     form.find("[name=page]").val("1");
//     form.find("[name=tblId]").val(table);
//     form.find("[name=searchWord]").val("");
//     
//     // 타이틀을 변경한다.
//     $("#sheet-popup-header-sect").text(title);
//     
//     // 데이터를 삭제한다.
//     afterSearchSheetPopupCode([
//         // Nothing to do.
//     ]);
//     
//     // 레이어를 보인다.
//     $("#sheet-popup-sect").show();
//     
//     // 공공데이터 시트 서비스 팝업 코드를 검색한다.
//     searchSheetPopupCode();
// }

// /**
//  * 공공데이터 시트 서비스 팝업 코드 검색 화면을 숨긴다.
//  */
// function hideSheetPopupCode() {
//     var form = $("#sheet-popup-search-form");
//     
//     form.find("[name=page]").val("1");
//     form.find("[name=tblId]").val("");
//     form.find("[name=searchWord]").val("");
//     
//     // 타이틀을 삭제한다.
//     $("#sheet-popup-header-sect").text("");
//     
//     // 데이터를 삭제한다.
//     afterSearchSheetPopupCode([
//         // Nothing to do.
//     ]);
//     
//     // 레이어를 숨긴다.
//     $("#sheet-popup-sect").hide();
// }

// /**
//  * 공공데이터 시트 서비스 팝업 코드를 검색한다.
//  */
// function searchSheetPopupCode() {
//     // 데이터를 검색한다.
//     doSearch({
//         url:"/portal/common/code/searchPopupCode.do",
//         before:beforeSearchSheetPopupCode,
//         after:afterSearchSheetPopupCode,
//         pager:"sheet-popup-pager-sect",
//         counter:{
//             count:"sheet-popup-count-sect"
//         }
//     });
// }

// /**
//  * 공공데이터 시트 서비스 팝업 코드를 설정한다.
//  * 
//  * @param code {String} 코드
//  * @param name {String} 코드
//  */
// function setSheetPopupCode(code, name) {
//     $("#sheet-search-table").find(".header").each(function(index, element) {
//         if ($(this).text() == $("#sheet-popup-header-sect").text()) {
//             var row = $(this).parent("th").parent("tr");
//             
//             row.find(".hidden").val(code);
//             row.find(":text").val(name);
//             
//             return false;
//         }
//     });
//     
//     // 공공데이터 시트 서비스 팝업 코드 검색 화면을 숨긴다.
//     hideSheetPopupCode();
// }

////////////////////////////////////////////////////////////////////////////////
// 전처리 함수
////////////////////////////////////////////////////////////////////////////////
/**
 * 공공데이터 시트 서비스 메타정보 조회 전처리를 실행한다.
 * 
 * @param options {Object} 옵션
 * @returns {Object} 데이터
 */
function beforeSelectSheetMeta(options) {
    var data = {
        // Nothing do do.
    };
    
    var form = $("#sheet-search-form");
    var form2 = $("#dataset-search-form");
    		
   	if ( typeof(form2) == "object" ) {
   	    var id = form2.find("input[name=infId]").val() || form.find("input[name=infId]").val();
	    var seq = form2.find("input[name=infSeq]").val() || form.find("input[name=infSeq]").val();
   	    
   	    form.find("input[name=infId]").val(id);
   	    form.find("input[name=infSeq]").val(seq);
    }
 		

    $.each(form.serializeArray(), function(index, element) {
        switch (element.name) {
            case "infId":
            case "infSeq":
                data[element.name] = element.value;
                break;
        }
    });
    
    if (com.wise.util.isBlank(data.infId)) {
        return null;
    }
    if (com.wise.util.isBlank(data.infSeq)) {
        return null;
    }
    
    return data;
}

// /**
//  * 공공데이터 시트 서비스 팝업 코드 검색 전처리를 실행한다.
//  * 
//  * @param options {Object} 옵션
//  * @returns {Object} 데이터
//  */
// function beforeSearchSheetPopupCode(options) {
//     var data = {
//         // Nothing do do.
//     };
//     
//     var form = $("#sheet-popup-search-form");
//     
//     if (com.wise.util.isBlank(options.page)) {
//         form.find("[name=page]").val("1");
//     }
//     else {
//         form.find("[name=page]").val(options.page);
//     }
//     
//     $.each(form.serializeArray(), function(index, element) {
//         data[element.name] = element.value;
//     });
//     
//     return data;
// }

////////////////////////////////////////////////////////////////////////////////
// 후처리 함수
////////////////////////////////////////////////////////////////////////////////
/**
 * 공공데이터 시트 서비스 메타정보 조회 후처리를 실행한다.
 * 
 * @param data {Object} 데이터
 */
function afterSelectSheetMeta(data) {
    // 시트 그리드를 생성한다.
    initSheetGrid({
        ElementId:"sheet-object-sect",
        SheetId:"SheetObject",
        Height:"100%"
    }, {
        Page:$("#sheet-search-form [name=rows]").val(),
        AutoFitColWidth : ""
    }, {
        HeaderCheck:0
    }, data.columns, {
        // Nothing do do.
    });
    
    var sheet = window["SheetObject"];
    
    var width = 0;
    
    //var max = data.columns.length;;
    
    for (var i = 0; i < data.columns.length; i++) {
        width += sheet.GetColWidth(i);
    }
    
    if (sheet.GetSheetWidth() > width) {
        //sheet.FitColWidth();
    }
    
    // 공공데이터 시트 서비스 검색 필터를 추가한다.
    addSheetSearchFilters(data.filters);    
    
    // 공공데이터 시트 서비스 데이터를 검색한다.
    searchSheetData();
    
    //추천 데이터셋을 검색한다.
    //selectRecommandDataSet();	  // 숨김처리
}


function selectRecommandDataSet() {
	doSelect({
        url:"/portal/data/sheet/selectRecommandDataSet.do",
        before:beforeSelectRecommandDataSet,
        after:afterSelectRecommandDataSet
    });
}

function beforeSelectRecommandDataSet(options) {
    var data = {
        // Nothing do do.
    };
    
    var form = $("#sheet-search-form");
    
    data["objId"] = form.find("#infId").val() || $("#searchForm [name=infId]").val();
   
    if (com.wise.util.isBlank(data.objId)) {
        return null;
    }
    
    return data;
}

/**
 * 연관 데이터셋 검색 후처리를 실행한다.
 * 
 * @param data {Object} 데이터
 */
function afterSelectRecommandDataSet(data) {
	  var table = $(".bxslider");
	//  var infsq = 1;
	  
	//데이터가 없다면
	  if (data.length == 0) {
		 $(".recommendDataset").remove();
	  }
	  for (var i = 0; i < data.length; i++) {
	      var row = $(templates2.data);
	     
	      table.append(row);
  
	     
	      if (data[i].metaImagFileNm || data[i].saveFileNm) {
	            var url = com.wise.help.url("/portal/data/dataset/selectThumbnail.do");
	            url += "?infId=" + data[i].objId;
//	            url += "?seq="            + data[i].seq;
//	            url += "&metaImagFileNm=" + (data[i].metaImagFileNm ? data[i].metaImagFileNm : "");
	            url += "&cateSaveFileNm=" + (data[i].saveFileNm ? data[i].saveFileNm : "");

	            row.find(".metaImagFileNm").attr("src", url);
				//row.find(".metaImagFileNm").attr("alt", data[i].objNm);
	      }
	      
	      row.find("span").eq(1).text(data[i].objNm);
	      row.find(".m_cate").text(data[i].topCateNm);
	      row.find(".infsTag").text(data[i].opentyTagNm);
	      
	      row.each(function(index, element) {
	            // 서비스 링크에 클릭 이벤트를 바인딩한다.   	  
	            $(this).bind("click", {
	                objId:data[i].objId,
	                opentyTag:data[i].opentyTag
	            }, function(event) {
	                // 공공데이터 서비스를 조회한다.
//	            	recoService(event.data);
	            	moveToRecommendDataset(event.data);
	                return false;
	            });
	            
	            // 서비스 링크에 키다운 이벤트를 바인딩한다.
	            $(this).bind("keydown", {
	                objId:data[i].objId,
	                opentyTag:data[i].opentyTag
	            }, function(event) {
	                if (event.which == 13) {
	                    // 공공데이터 서비스를 조회한다.
//	                	recoService(event.data);
	                	moveToRecommendDataset(event.data);
	                    return false;
	                }
	            });
	        });
	  	      
	  }
	  
	  var ww = ($('.recommendDataset').width()-75) / 4;
	  setTimeout(dataset, 700, ww);
	
	  function dataset(ww) {
		  dataSet = $('.dataSetSlider').bxSlider({
				mode : 'horizontal',
				speed : 500,
				moveSlider : 1,
				autoHover : true,
				controls : false,
				slideMargin : 0,
				startSlide : 0,
				slideWidth: ww,
				minSlides: 1,
				maxSlides: 4,
				moveSlides: 1
			});

			$( '#dataset_prev' ).on( 'click', function () {
				dataSet.goToPrevSlide();  //이전 슬라이드 배너로 이동
				return false;              //<a>에 링크 차단
			} );
			
			$( '#dataset_next' ).on( 'click', function () {
				dataSet.goToNextSlide();  //다음 슬라이드 배너로 이동
				return false;
			} );
			
			
			$('.dataSet ul.dataSetSlider li a').on('focus', function(){
				$('.dataSet').addClass('focus');
			});
			
			$('.dataSet ul.dataSetSlider li a').on('focusout', function(){
				$('.dataSet').removeClass('focus');
			});
	  }
}

/**
 * 연관(추천) 데이터셋으로 이동한다.
 * @param data
 * @returns
 */
function moveToRecommendDataset(data) {
	var obj = getOpentyTagData(data);
	
	$("#searchForm").append("<input type=\"hidden\" id=\""+obj.id+"\" name=\""+obj.id+"\" value=\""+data.objId+"\" />");
	
	goSelect({
		url: obj.url,
        form:"searchForm",
        method: "post"
    });
	
	function getOpentyTagData(data) {
		var obj = {};
		
		switch ( data.opentyTag ) {
		case "D":
			obj.url = "/portal/doc/docInfPage.do/" + data.objId;
			obj.id = "docId";
			obj.gubun = "seq";
			break;
		case "O":
			obj.url = "/portal/data/service/selectServicePage.do/" + data.objId;
			obj.id = "infId";
			obj.gubun = "infSeq";
			break;
		case "S":
			obj.url = "/portal/stat/selectServicePage.do/" + data.objId;
			obj.id = "statblId";
			obj.gubun = "";
			break;
		}
		return obj
	}
}

function recoService(data) {
    // 데이터를 조회하는 화면으로 이동한다.
    goSelect({
        url:"/portal/data/service/selectServicePage.do",
        form:"sheet-search-form",
        data:[{
            name:"infId",
            value:data.infId
        }
        , {
            name:"infSeq",
            value:data.infSeq
        }
        ]
    });
}

// /**
//  * 공공데이터 시트 서비스 팝업 코드 검색 후처리를 실행한다.
//  * 
//  * @param data {Array} 데이터
//  */
// function afterSearchSheetPopupCode(data) {
//     var table = $("#sheet-popup-data-table");
//     
//     table.find("tr").each(function(index, element) {
//         if (index > 0) {
//             $(this).remove();
//         }
//     });
//     
//     for (var i = 0; i < data.length; i++) {
//         var row = $(templates.data);
//         
//         row.find(".code").text(data[i].code);
//         row.find(".name").text(data[i].name);
//         
//         row.find(":checkbox").bind("click", {
//             code:data[i].code,
//             name:data[i].name
//         }, function(event) {
//             // 공공데이터 시트 서비스 팝업 코드를 설정한다.
//             setSheetPopupCode(event.data.code, event.data.name);
//         });
//         
//         table.append(row);
//     }
//     
//     if (data.length == 0) {
//         var row = $(templates.none);
//         
//         table.append(row);
//     }
// }

////////////////////////////////////////////////////////////////////////////////
// 이벤트 함수
////////////////////////////////////////////////////////////////////////////////
/**
 * 시트 조회 완료 이벤트를 처리한다.
 * 
 * @param code {Number} 코드
 * @param message {String} 메시지
 * @param statusCode {Number} 상태 코드
 * @param statusMessage {String} 상태 메시지
 */
function SheetObject_OnSearchEnd(code, message, statusCode, statusMessage) {
    if (code >= 0) {
        if (message) {
            alert(message);
        }
    }
    else {
        if (message) {
            alert(message);
        }
        else {
            handleSheetError(statusCode, statusMessage);
        }
    }
}

/////////////////아이비시트 추가

function SheetObject_OnTab(Row, Col, Orow, Ocol, isShift, isLast) {
    if(isLast){
    	SheetObject.SetBlur(); // focus를 이동시킬 준비를 합니다.
    	$("#dataset-search-button").focus(); //다른 객체에 focus를 이동합니다.
    }
}

/**
 * 컬럼유형을(팝업내용)으로 선택했을경우 선택한 행의 컬럼 내용보기
 * @param obj
 * @returns
 */
function openSheetClickCont(obj) {
	var textElement = $(obj).next(),
		sect = $("div[id=sheet-cont-sect]"),
		sectCont = $("#sheet-cont-sect-cont"),
		copyTextElement = null;
	
	sectCont.empty();
	
	if ( !com.wise.util.isBlank(textElement.text()||"") ) {
		copyTextElement = textElement.clone();
		sectCont.append(copyTextElement.show());
	}
	else {
		sectCont.append("<span>상세 내용이 없습니다.</span>");
	}

	SheetObject.SetBlur();
	
	sect.show().focus();
	$("#sheet-cont-sect-detail").css("top",  (($(window).height() - $("#sheet-cont-sect-detail").height()) / 2) + "px");
	
	//sect.find(".sheet-close").focus();
}

/**
 * 컬럼유형을 상세팝업으로 선택했을경우 아이콘 선택시 해당 행의 상세내용 레이어 팝업으로 보여준다.
 * @param obj
 * @param hdnCol
 * @returns
 */
function openSheetClickDetail(obj, hdnCol) {
	// 선택된 행 구함(시트에 클릭 Focus가 잡히지 않아 GetCurrentPage 사용불가함. tr 행에 필요정보가 있어서 사용함[Grids[0].ARow=Grids[0].Rows["130"];Grids[0].ASec=0;])
	var $selRow = $(obj).closest("tr");
	var selRow = $selRow.index();
	var selRowInfo = $selRow.attr("onmousemove");
	
	var splitRowsInfo = _.split(selRowInfo, "Rows[\"");
	if ( splitRowsInfo.length > 1 ) {
		selRow = Number(splitRowsInfo[1].substr(0, splitRowsInfo[1].indexOf("\"")));
	}
	
	var	sect = $("div[id=sheet-dtl-sect]"),
		sectCont = $("#sheet-dtl-sect-cont");

	// 시트정보
	var sCol = SheetObject.Cols,
		sColTxt = SheetObject.HeaderText,
		sColInfo = SheetObject.ColIndexInfo;
	
	if ( sColInfo.length > 0 ) {
		sectCont.empty();
		
		for ( var i=0; i < sColInfo.length; i++ ) {
			var col = sCol[sColInfo[i]];
			
			if ( col.SaveName == hdnCol )	continue;
			
			if ( col.Hidden == 0 ) {
				var row = $("<tr><th></th><td></td></tr>"); 
				row.find("th").text(sColTxt[i]);
				var value = SheetObject.GetCellValue(selRow, col.SaveName) || "";
				/*
				if ( sColTxt[i] == "첨부파일" ) {
					continue;
				}*/
				
				if ( col.Type == "Html" && value != null && value.indexOf("<") > -1 ) {
					row.find("td").html($(value));
				}
				else if ( typeof value == "string" && value.indexOf("http") > -1 ) {
					row.find("td").html($("<a href=\""+value+"\">"+value+"</a>"));
				}
                else if ( col.Type == "Text" && value != null && value.indexOf("&lt;") > -1 ) {
                    var escapeValue = value.replace(/&amp;/g, "&").replace(/&gt;/g, ">").replace(/&lt;/g, "<").replace(/&quot;/g, "\"").replace(/\？/g, '&nbsp;')
                    row.find("td").append("<div></div>").find("div").html(escapeValue);
                }
				else {
					row.find("td").append("<div>"+value+"</div>");
				}
				
				sectCont.append(row);
			}
		}
		
		SheetObject.SetBlur();
		
		sect.show().focus();
		$("#sheet-dtl-sect-detail").css("top",  (($(window).height() - $("#sheet-dtl-sect-detail").height()) / 2) + "px");
		
		//sect.find(".sheet-close").focus();
		
	}
}

function SheetObject_OnKeyDown(row, col, keyCode, shift) {
	if ( keyCode == 13 ) {

		var sCol = SheetObject.Cols,
		sColTxt = SheetObject.HeaderText,
		sColInfo = SheetObject.ColIndexInfo;
	
		var column = sCol[sColInfo[col]];

		if ( column.Type == "Html" && column.Hidden == 0 ) {
			var value = SheetObject.GetCellValue(row, col);
			var element = $(value);
			var dataColType = $(value).attr("data-col-type"); 
			
			if ( dataColType == "buttonSelfPop" || dataColType == "buttonNewPop" || dataColType == "link"
				|| dataColType == "contPop" || dataColType == "dtlPop" || dataColType == "downPop" ) {
				element.get(0).click();
			}
		}
		
		return false;
	}
}

/**
* 유저 파일다운로드 데이터 클릭이벤트
*/
function openSheetClickMultiDown(obj) {
	
	var page = $(obj).parents(".GMPage").index(),	// 선택한 페이지번호
		pageRow = $("#sheet-search-form").find("input[name=rows]").val() || 100;
		pageRowCalc = page > 0 ? page * pageRow : 0,
		selRow = pageRowCalc + $(obj).closest("tr")[0].rowIndex;		// 선택한 행번호(페이지를 더한다)
	
	var	dataSeqceNo = Number(SheetObject.GetCellValue(selRow, "DATA_SEQCE_NO")),
		sect = $("div[id=userDown-dtl-sect]"),
		sectCont = $("#userDown-dtl-sect-cont"),
		item = "<tr>" +
				"<td class=\"n_number\"></td>" +
				"<td class=\"n_subject left\"></td>" +
				//"<td class=\"n_writer\"></td>" +
				"<td class=\"n_date\"></td>" +
				"<td class=\"n_download\"><span class=\"linkA\"><a href=\"#\"><img class=\"icon_file_A\" src=\"/img/ggportal/desktop/common/icon_file_A_8.png\" /></a></span></td>" +
				"<td class=\"n_download\"><span><a class=\"linkB\" href=\"#\"><img class=\"\" src=\"/images/icon_fileView.jpg\" height=\"32\" width=\"29\" /></a></span></td>" +
				"</tr>"; 

	doAjax({
		url: "/portal/data/sheet/searchUsrDefFileData.do",
		params: {
			infId: $("input[name=infId]").val(),
			infSeq: Number($("input[name=infSeq]").val()),
			dataSeqceNo: dataSeqceNo
		},
		callback: function(res) {
			var datas = res.data;
			sectCont.empty();
			
			if ( datas.length > 0 ) {
				for ( var i in datas ) {
					var data = datas[i];
					var row = $(item); 
					var cnt = Number(i) + 1;
					
					row.find("td:eq(0)").text(cnt);
					row.find("td:eq(1)").text(data.viewFileNm + "(" + data.fileSize + ")");
					//row.find("td:eq(2)").text(data.usrNm);
					row.find("td:eq(2)").text(data.ftCrDttm);
					//row.find("td:eq(4)").text(data.fileSeq + "/" + data.dataSeqceNo);
					switch (data.fileExt.toLowerCase()) {
						case "ppt":
			            case "pptx":
			            	row.find("td:eq(3) img").attr("src", com.wise.help.url("/images/icon_ppt.png")).attr("alt", "PowerPoint file 아이콘");
			                break;
			            case "doc":
			            case "docx":
			            	row.find("td:eq(3) img").attr("src", com.wise.help.url("/images/icon_word.png")).attr("alt", "word file 아이콘");
			                break;
			            case "xls":
			            case "xlsx":
			            	row.find("td:eq(3) img").attr("src", com.wise.help.url("/images/icon_excel.png")).attr("alt", "excel file 아이콘");
			                break;
			            case "hwp":
			            	row.find("td:eq(3) img").attr("src", com.wise.help.url("/images/icon_hwp.png")).attr("alt", "한글 file 아이콘");
			                break;
			            case "pdf":
			            	row.find("td:eq(3) img").attr("src", com.wise.help.url("/images/icon_pdf.png")).attr("alt", "PDF file 아이콘");
			                break;
			            case "jpg":
			            case "jpeg":
			            case "gif":
			            case "png":
			            case "bmp":
			            	row.find("td:eq(3) img").attr("src", com.wise.help.url("/img/ggportal/desktop/common/icon_file_A_6.png")).attr("alt", "이미지 file 아이콘");
			                break;
			            case "txt":
			            	row.find("td:eq(3) img").attr("src", com.wise.help.url("/images/icon_file.png")).attr("alt", "text file 아이콘");
			                break;
					}
					row.find(".linkB").attr("href", "javascript:previewFile('https://open.assembly.go.kr/portal/data/sheet/downloadFileData.do?infId="+$("input[name=infId]").val()+"&infSeq="+Number($("input[name=infSeq]").val())+"&fileSeq="+data.fileSeq+"&dataSeqceNo="+data.dataSeqceNo+"', 'nm', '"+data.viewFileNm+"')");
					// 다운로드 버튼에 클릭 이벤트를 바인딩한다.
					row.find(".linkA").bind("click",{
						infId: $("input[name=infId]").val(),
						infSeq: Number($("input[name=infSeq]").val()),
						fileSeq:data.fileSeq,
						dataSeqceNo: data.dataSeqceNo
					}, function(event){
						downloadFileData(event.data);
						return false;
					});
					
					// 다운로드 버튼에 키다운 이벤트를 바인딩한다.
					row.find(".linkA").bind("keydown", {
						infId: $("input[name=infId]").val(),
						infSeq: Number($("input[name=infSeq]").val()),
						fileSeq:data.fileSeq,
						dataSeqceNo: data.dataSeqceNo
						//row.find("td:eq(4)").text(data.fileSeq + "/" + data.dataSeqceNo);
					}, function(event){
						if(event.which == 13){
							downloadFileData(event.data);
							return false;
						}
					});
					
					sectCont.append(row);
				}
			}
			else {
				var row = $("<tr><td colspan=\"4\">조회된 데이터가 없습니다.</td></tr>");
				sectCont.append(row);
			}
			
			SheetObject.SetBlur();
			
			sect.show();
			$("#userDown-dtl-sect-detail").css("top",  (($(window).height() - $("#userDown-dtl-sect-detail").height()) / 2) + "px");
			
			//sect.find(".sheet-close").focus();	// 닫기버튼으로 포커스
		}
	});
}

function downloadFileData(data) {
    // 파일을 다운로드한다.
    downloadFile(data, {
        url:"/portal/data/sheet/downloadFileData.do",
        target:"global-process-iframe"
    });
}

//파일 다운로드
function fn_exFileDown(fileName, filePath){
	var exfrm = document.exForm;
	exfrm.fileName.value = fileName;
	exfrm.filePath.value = filePath;

	exfrm.action = "/portal/expose/downloadOpnAplFile.do";
	exfrm.submit();
}

//시트 사용자 정의 컬럼유형기능 레이어 팝업 닫기 이벤트 추가
function bindSheetUsrDef() {
	// 시트 상세보기 닫기 이벤트
	$("div[id=sheet-dtl-sect]").find(".sheet-close").unbind("click").bind("click", function(e) {
		SheetObject.SetFocus();
		$("div[id=sheet-dtl-sect]").hide();
		return false;
	}).unbind("keydown").bind("keydown", function(e) {
		if ( e.which == 13 )  {
			SheetObject.SetFocus();
			$("div[id=sheet-dtl-sect]").hide();
			return false;
		}
	});
	$("div[id=sheet-dtl-sect]").find(".btn_A").unbind("click").bind("click", function(e) {
		SheetObject.SetFocus();
		$("div[id=sheet-dtl-sect]").hide();
		return false;
	}).unbind("keydown").bind("keydown", function(e) {
		if ( e.which == 13 )  {
			SheetObject.SetFocus();
			$("div[id=sheet-dtl-sect]").hide();
			return false;
		}
	});
	
	// 내용보기 닫기 이벤트
	$("div[id=sheet-cont-sect]").find(".sheet-close").unbind("click").bind("click", function(e) {
		SheetObject.SetFocus();
		$("div[id=sheet-cont-sect]").hide();
		return false;
	}).unbind("keydown").bind("keydown", function(e) {
		if ( e.which == 13 )  {
			SheetObject.SetFocus();
			$("div[id=sheet-cont-sect]").hide();
			return false;
		}
	});
	$("div[id=sheet-cont-sect]").find(".btn_A").unbind("click").bind("click", function(e) {
		SheetObject.SetFocus();
		$("div[id=sheet-cont-sect]").hide();
		return false;
	}).unbind("keydown").bind("keydown", function(e) {
		if ( e.which == 13 )  {
			SheetObject.SetFocus();
			$("div[id=sheet-cont-sect]").hide();
			return false;
		}
	});
}

////////////////////////////////////////////////////////////////////////////////
//웹뷰어 함수
////////////////////////////////////////////////////////////////////////////////
function previewFile(path, ext , fname ){
	  
	  //var preUrl = 'http://211.46.92.51:81/mview_scroll.php?FTYPE=jpeg&FLIVESERVER=http://211.46.92.51:47156';
	  var preUrl = 'http://media1.assembly.go.kr:81/mview_scroll.php?FTYPE=jpeg&FLIVESERVER=http://media1.assembly.go.kr:47158';
	  furl = 'http://media1.assembly.go.kr:47158?page=[PAGE]&size=12801024&type=jpg&webid=iopen&signcode=&LtpaToken=';
	  filepath = "&url=" + encodeURIComponent(path);
	  
	  furl = furl + filepath
	 
	  filename = "&FFILENAME=" + encodeURIComponent(fname);
	  
	  if(ext =='nm'){
		  flen = fname.length;
		  lastdot = fname.lastIndexOf('.') +1;
		  ext = fname.substring(lastdot, flen);
		  
		  fileext  = "&ext=" + encodeURIComponent(ext);
	  }else if(ext =='path'){
		  flen = path.length;
		  lastdot = path.lastIndexOf('.') +1;
		  ext = path.substring(lastdot, flen);
		  fileext  = "&ext=" + encodeURIComponent(ext);
	  }else{
		  
		  fileext  = "&ext=" + encodeURIComponent(ext);
	  }
		  
	  furl = furl + fileext
	  
	  furl = encodeURIComponent(furl)
	  preUrl = preUrl + "&FURL="+ furl + "&FEXT=" + ext + filename ;
	  window.open(preUrl);
	  
}