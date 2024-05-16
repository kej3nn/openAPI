/*
 * @(#)selectFile.js 1.0 2015/06/15
 * 
 * COPYRIGHT (C) 2013 WISEITECH CO., LTD. ALL RIGHTS RESERVED.
 */

/**
 * 공공데이터 파일 서비스를 조회하는 스크립트이다.
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
        "<li class=\"w_1\">"                                                                              +
        	"<span class=\"hdNew_no\">1</span>" +
        	"<span class=\"hdNew_viewFileNm left\" style='cursor:pointer' tabindex='0'></span>" +
        	"<span class=\"hdNew_wrtNm\">테스터</span>" +
        	"<span class=\"hdNew_ftCrDttm\"></span>" +
        	"<span class=\"hdNew_fileDown\"><a href=\"#\" class='linkA'><img class=\"icon_file_A\" src=\"/images/icon_file.png\" /></a></span>"           +
        	"<span class=\"hdNew_fileView\" style=\"\"><a href=\"#\" class='linkB'><img alt=\"미리보기 아이콘\" src=\"/images/icon_fileView.jpg\" height='32' width=29'/></a></span>"           +
        "</li>",
    none:
        "<li class=\"noData\">해당 자료가 없습니다.</li>"
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
	            "<em class=\"m_cate\">의정활동</em>"                                               										+
	            "<i class=\"ot01 infsTag\">데이터</i>"                                               										+
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
/**
 * 컴포넌트를 초기화한다.
 */
//function initComp() {
//    // Nothing to do.
//}

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
 * 마스크를 바인딩한다.
 */
function bindMask() {
    // Nothing to do.
}

/**
 * 이벤트를 바인딩한다.
 */
function bindEvent() {
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
    
    $("#btnSearch").bind("click", function(event) {
    	searchFileData();
        return false;
    });
    $("#searchVal").bind("keydown", function(event) {
        if (event.which == 13) {
        	searchFileData();
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
    // 공공데이터 파일 서비스 메타정보를 조회한다.
    selectFileMeta();
}

////////////////////////////////////////////////////////////////////////////////
// 서비스 함수
////////////////////////////////////////////////////////////////////////////////
/**
 * 공공데이터 파일 서비스 메타정보를 조회한다.
 */
function selectFileMeta() {
    // 데이터를 조회한다.
    doSelect({
        url:"/portal/data/file/selectFileMeta.do",
        before:beforeSelectFileMeta,
        after:afterSelectFileMeta
    });
}

/**
 * 공공데이터 파일 서비스 데이터를 검색한다.
 */
function searchFileData() {
    // // 데이터를 검색한다.
    // doSearch({
    //     url:"/portal/data/file/searchFileData.do",
    //     before:beforeSearchFileData,
    //     after:afterSearchFileData,
    //     pager:"file-pager-sect",
    //     counter:{
    //         count:"file-count-sect"
    //     }
    // });
    // 데이터를 검색한다.
	
	// 파일 검색 파라미터 설정
	if ( com.wise.util.isEmpty($("#searchGubun").val()) ) {
		$("#file-search-form [name=searchGubun]").remove();
	}
	else if ( !com.wise.util.isEmpty($("#searchGubun").val()) ) {
		$("#file-search-form").append("<input type=\"hidden\" name=\"searchGubun\" value=\""+ $("#searchGubun").val() +"\">");
	}
	
	if ( com.wise.util.isEmpty($("#searchVal").val()) ) {
		$("#file-search-form [name=searchVal]").remove();
	}
	else {
		$("#file-search-form").append("<input type=\"hidden\" name=\"searchVal\" value=\""+ $("#searchVal").val() +"\">");
	}
	
    doSearch({
        url:"/portal/data/file/searchFileData.do",
        before:beforeSearchFileData,
        after:afterSearchFileData
    });
}

/**
 * 공공데이터 파일 서비스 데이터를 조회한다.
 * 
 * @param data {Object} 데이터
 */
function selectFileData(data) {
    $("#file-data-list li.on").each(function(index, element) {
        $(this).removeClass("on");
    });
    
    $("#file-data-list .viewFileNm[href='#" + data.fileSeq + "']").parent("li").addClass("on");
    
    var url = com.wise.help.url("/portal/data/file/selectFileData.do");
    
    url += "?infId="   + data.infId;
    url += "&infSeq="  + data.infSeq;
    url += "&fileSeq=" + data.fileSeq;
    
    //$("#file-preview-iframe").attr("src", url);
}

/**
 * 공공데이터 파일 서비스 데이터를 다운로드한다.
 * 
 * @param data {Object} 데이터
 */
function downloadFileData(data) {
    // $("#file-data-list li.on").each(function(index, element) {
    //     $(this).removeClass("on");
    // });
    // 
    // $("#file-data-list .viewFileNm[href='#" + data.fileSeq + "']").parent("li").addClass("on");
    
    // 파일을 다운로드한다.
    downloadFile(data, {
        url:"/portal/data/file/downloadFileData.do",
        target:"global-process-iframe"
    });
}

/**
 * 공공데이터 데이터셋 전체목록을 검색한다.
 */
function searchDataset() {
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

////////////////////////////////////////////////////////////////////////////////
// 전처리 함수
////////////////////////////////////////////////////////////////////////////////
/**
 * 공공데이터 파일 서비스 메타정보 조회 전처리를 실행한다.
 * 
 * @param options {Object} 옵션
 * @returns {Object} 데이터
 */
function beforeSelectFileMeta(options) {
    var data = {
        // Nothing do do.
    };
    
    var form = $("#file-search-form");
    var form2 = $("#dataset-search-form");
    var id = form2.find("input[name=infId]").val() || form.find("input[name=infId]").val();
    var seq = form2.find("input[name=infSeq]").val() || form.find("input[name=infSeq]").val();
    
    form.find("input[name=infId]").val(id);
    form.find("input[name=infSeq]").val(seq);
    
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

/**
 * 공공데이터 파일 서비스 데이터 검색 전처리를 실행한다.
 * 
 * @param options {Object} 옵션
 * @returns {Object} 데이터
 */
function beforeSearchFileData(options) {
    var data = {
        // Nothing do do.
    };
    
    var form = $("#file-search-form");
    
    // if (com.wise.util.isBlank(options.page)) {
    //     form.find("[name=page]").val("1");
    // }
    // else {
    //     form.find("[name=page]").val(options.page);
    // }
    
    // $.each(form.serializeArray(), function(index, element) {
    //     data[element.name] = element.value;
    // });
    $.each(form.serializeArray(), function(index, element) {
        switch (element.name) {
            case "infId":
            case "infSeq":
            case "searchGubun":
            case "searchVal":
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

////////////////////////////////////////////////////////////////////////////////
// 후처리 함수
////////////////////////////////////////////////////////////////////////////////
/**
 * 공공데이터 파일 서비스 메타정보 조회 후처리를 실행한다.
 * 
 * @param data {Object} 데이터
 */
function afterSelectFileMeta(data) {
    // 공공데이터 파일 서비스 데이터를 검색한다.
    searchFileData();
}

/**
 * 공공데이터 파일 서비스 데이터 검색 후처리를 실행한다.
 * 
 * @param data {Array} 데이터
 */
function afterSearchFileData(data) {
    var list = $("#file-data-list");
    
    list.find("li").each(function(index, element) {
        $(this).remove();
    });
  
    for (var i = 0; i < data.length; i++) {
        var item = $(templates.data);
       
        item.find(".hdNew_no").text(i+1);
        //item.find(".fileSize").text(data[i].cvtFileSize);
        item.find(".hdNew_viewFileNm").text(data[i].viewFileNm + (data[i].fileExt ? "." + data[i].fileExt : "") + " (" + data[i].cvtFileSize + ")");
        //item.find(".viewCnt").append(" (다운로드수 : " + (data[i].viewCnt ? data[i].viewCnt : "0") + ")");
        
        item.find(".hdNew_wrtNm").text(data[i].wrtNm);
        item.find(".hdNew_ftCrDttm").text(data[i].ftCrDttm);
                
        switch (data[i].fileExt.toLowerCase()) {
            case "ppt":
            case "pptx":
                item.find(".linkA img").attr("src", com.wise.help.url("/images/icon_ppt.png")).attr("alt", "PowerPoint file 아이콘");
                break;
            case "doc":
            case "docx":
                item.find(".linkA img").attr("src", com.wise.help.url("/images/icon_word.png")).attr("alt", "word file 아이콘");
                break;
            case "xls":
            case "xlsx":
                item.find(".linkA img").attr("src", com.wise.help.url("/images/icon_excel.png")).attr("alt", "excel file 아이콘");
                break;
            case "hwp":
                item.find(".linkA img").attr("src", com.wise.help.url("/images/icon_hwp.png")).attr("alt", "한글 file 아이콘");
                break;
            case "pdf":
                item.find(".linkA img").attr("src", com.wise.help.url("/images/icon_pdf.png")).attr("alt", "PDF file 아이콘");
                break;
            case "jpg":
            case "jpeg":
            case "gif":
            case "png":
            case "bmp":
                item.find(".linkA img").attr("src", com.wise.help.url("/img/ggportal/desktop/common/icon_file_A_6.png")).attr("alt", "이미지 file 아이콘");
                break;
            case "txt":
                item.find(".linkA img").attr("src", com.wise.help.url("/images/icon_file.png")).attr("alt", "text file 아이콘");
                break;
            case "zip":
            case "rar":
            case "7z":	
                item.find(".linkA img").attr("src", com.wise.help.url("/images/icon_zip.png")).attr("alt", "zip file 아이콘");
                break;    
        }
        item.find(".linkB").attr("href", "javascript:previewFile('https://open.assembly.go.kr/portal/data/file/downloadFileData.do?infId="+data[i].infId+"&infSeq="+data[i].infSeq+"&fileSeq="+data[i].fileSeq+"', 'nm', '"+data[i].viewFileNm+"."+data[i].fileExt+"')");
        
        // 공공데이터 파일 서비스 다운로드 버튼에 클릭 이벤트를 바인딩한다.
        item.find(".linkA, .hdNew_viewFileNm").bind("click", {
            infId:data[i].infId,
            infSeq:data[i].infSeq,
            fileSeq:data[i].fileSeq
        }, function(event) {
            // 공공데이터 파일 서비스 데이터를 다운로드한다.
            downloadFileData(event.data);
            return false;
        });
        
        // 공공데이터 파일 서비스 다운로드 버튼에 키다운 이벤트를 바인딩한다.
        item.find(".linkA, .hdNew_viewFileNm").bind("keydown", {
            infId:data[i].infId,
            infSeq:data[i].infSeq,
            fileSeq:data[i].fileSeq
        }, function(event) {
            if (event.which == 13) {
                // 공공데이터 파일 서비스 데이터를 다운로드한다.
                downloadFileData(event.data);
                return false;
            }
        });
        
        list.append(item);
    }
    
    if (data.length == 0) {
        var item = $(templates.none);
        
        list.append(item);
    }
    else {
        //$(".file-select-button:first").click();	//문서보기 사용안함
    }
    
  //추천 데이터셋을 검색한다.
//    selectRecommandDataSet();
}

/////////////// 추천
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
        form:"file-search-form",
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

//////////////////////

////////////////////////////////////////////////////////////////////////////////
// 웹뷰어 함수
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