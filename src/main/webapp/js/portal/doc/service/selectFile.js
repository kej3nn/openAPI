/**
 * @(#)selectFile.js 1.0 2019/08/20
 * 
 * 문서관리 파일 서비스 스크립트 파일이다.
 * 
 * @author JHKIM
 * @version 1.0 2019/08/20
 */
////////////////////////////////////////////////////////////////////////////////
// GLOBAL VARIABLE
////////////////////////////////////////////////////////////////////////////////
var template = {
	list: {
		none: "<tr><td colspan=\"2\">조회된 데이터가 없습니다.</td></tr>",
		
		item:  "<li class=\"w_1\">"                                                                              +
			    	"<span class=\"no center\">1</span>" +
			    	"<span class=\"viewFileNm left\" style='cursor:pointer' tabindex='0'></span>" +
			    	"<span class=\"ftCrDttm center\"></span>" +
			    	"<span class=\"linkA center\" style=\"width:auto;\"><a href=\"javascript:;\"><img class=\"icon_file_A\" src=\"/images/icon_file.png\" /></a></span>"           +
			    	"<span class=\"linkB\" style=\"width:auto;\"><a href=\"javascript:;\"><img class=\"icon_file_A\" src=\"/images/icon_fileView.jpg\" height='32' width=29'/></a></span>"           +
			    "</li>",
		none: 
			"<li class=\"noData\">해당 자료가 없습니다.</li>"
	}	
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
// SCRIPT INIT
////////////////////////////////////////////////////////////////////////////////
$(function() {
	// 파일서비스 목록 조회
	searchFiles();
	
	// 연관 데이터셋을 검색한다.
//	selectRecommandDataSet();
});

/**
 * 파일서비스 다운로드 목록 조회
 */
function searchFiles() {
	doSelect({
		url: "/portal/doc/file/searchFileData.do",
		before: beforeSearchFiles,
		after: afterSearchFiles
	});
}

/**
 * 파일서비스 다운로드 목록 조회 전처리
 */
function beforeSearchFiles(options) {
	var form = $("#form");
	var data = {
		docId: form.find("input[name=docId]").val()
	}
	
	if ( com.wise.util.isBlank(data.docId) ) {
		return null;
	}
	
	return data;
}

/**
 * 파일서비스 다운로드 목록 조회 후처리
 */
function afterSearchFiles(datas) {
	var list = $("#file-data-list");
	list.empty();

	if ( datas.length > 0 ) {
		for ( var i in datas ) {
			var data = datas[i];
			var item = $(template.list.item);
			item.find(".no").text(Number(i)+1);
			item.find(".viewFileNm").text(data.viewFileNm).bind("click", data, function(event) {
				downloadFileData(event.data);
				return false;
			}).bind("keydown", data, function(event) {
				if (event.which == 13) {
					downloadFileData(event.data);
	                return false;
	            }
			});
			
			viewFileExtImage(item.find(".linkA img"), data.fileExt);
			item.find(".ftCrDttm").text(data.cvtFileSize);
			item.find(".linkB a").attr("href", "javascript:previewFile('https://open.assembly.go.kr/portal/doc/file/downloadFileData.do?docId="+data.docId+"&fileSeq="+data.fileSeq+"', 'nm', '"+data.viewFileNm+"')");			
			// 파일 다운로드
			item.find(".linkA a").bind("click", data, function(event) {
				downloadFileData(event.data);
				return false;
			}).bind("keydown", data, function(event) {
				if (event.which == 13) {
					downloadFileData(event.data);
	                return false;
	            }
			});
			list.append(item);
		}
	}
	else {
		list.append($(template.list.none));
	}
}

/**
 * 파일 다운로드
 */
function downloadFileData(data) {
	downloadFile(data, {
		url: "/portal/doc/file/downloadFileData.do",
		target:"global-process-iframe"
	});
} 

/**
 * 첨부파일 이미지 아이콘 조회
 */
function viewFileExtImage(item, fileExt) {
	switch (fileExt.toLowerCase()) {
		case "ppt":
	    case "pptx":
	        item.attr("src", com.wise.help.url("/images/icon_ppt.png")).attr("alt", "PowerPoint file 아이콘");
	        break;
	    case "doc":
	    case "docx":
	        item.attr("src", com.wise.help.url("/images/icon_word.png")).attr("alt", "word file 아이콘");
	        break;
	    case "xls":
	    case "xlsx":
	        item.attr("src", com.wise.help.url("/images/icon_excel.png")).attr("alt", "excel file 아이콘");
	        break;
	    case "hwp":
	        item.attr("src", com.wise.help.url("/images/icon_hwp.png")).attr("alt", "한글 file 아이콘");
	        break;
	    case "pdf":
	        item.attr("src", com.wise.help.url("/images/icon_pdf.png")).attr("alt", "PDF file 아이콘");
	        break;
	    case "jpg":
	    case "jpeg":
	    case "gif":
	    case "png":
	    case "bmp":
	        item.attr("src", com.wise.help.url("/img/ggportal/desktop/common/icon_file_A_6.png")).attr("alt", "이미지 file 아이콘");
	        break;
	    case "txt":
	        item.attr("src", com.wise.help.url("/images/icon_file.png")).attr("alt", "text file 아이콘");
	        break;
	    case "zip":
        case "rar":
        case "7z":	
            item.find(".linkA img").attr("src", com.wise.help.url("/images/icon_zip.png")).attr("alt", "zip file 아이콘");
            break;       
	}
	
}

/**
 * 연관 데이터셋 검색
 */
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
    
    var form = $("#form");
    
    data["objId"] = form.find("input[name=docId]").val() || $("#searchForm [name=docId]").val();
   
    if (com.wise.util.isBlank(data.objId)) {
        return null;
    }
    
    return data;
}

/**
 * 공공데이터 시트 서비스 메타정보 조회 후처리를 실행한다.
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
	            	moveToRecommendDataset(event.data);
	                return false;
	            });
	            
	            // 서비스 링크에 키다운 이벤트를 바인딩한다.
	            $(this).bind("keydown", {
	                objId:data[i].objId,
	                opentyTag:data[i].opentyTag
	            }, function(event) {
	                if (event.which == 13) {
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