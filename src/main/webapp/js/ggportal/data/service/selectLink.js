/*
 * @(#)selectLink.js 1.0 2015/06/15
 * 
 * COPYRIGHT (C) 2013 WISEITECH CO., LTD. ALL RIGHTS RESERVED.
 */

/**
 * 공공데이터 링크 서비스를 조회하는 스크립트이다.
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
        "<li class=\"w_2\">"                                                                            +
        	"<a class=\"link linkExp linkUrl\" title=\"새창으로 이동\"></a>"                                        +
            " "                                                                                         +
            "<span class=\"btn\">"                                                                      +
                "<a href=\"#\" class=\"btn_D link-select-button\" title=\"새창으로 이동\">바로가기</a>" +
            "</span>"                                                                                   +
        "</li>",
    none:
        "<li class=\"noData\">검색된 데이터가 없습니다.</li>"
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
    // 공공데이터 링크 서비스 메타정보를 조회한다.
    selectLinkMeta();
}

////////////////////////////////////////////////////////////////////////////////
// 서비스 함수
////////////////////////////////////////////////////////////////////////////////
/**
 * 공공데이터 링크 서비스 메타정보를 조회한다.
 */
function selectLinkMeta() {
    // 데이터를 조회한다.
    doSelect({
        url:"/portal/data/link/selectLinkMeta.do",
        before:beforeSelectLinkMeta,
        after:afterSelectLinkMeta
    });
}

/**
 * 공공데이터 링크 서비스 데이터를 검색한다.
 */
function searchLinkData() {
    // 데이터를 검색한다.
    doSearch({
        url:"/portal/data/link/searchLinkData.do",
        before:beforeSearchLinkData,
        after:afterSearchLinkData
    });
}

/**
 * 공공데이터 링크 서비스 데이터를 조회한다.
 * 
 * @param data {Object} 데이터
 */
function selectLinkData(data) {
    // 공공데이터 링크 서비스 썸네일을 조회한다.
    selectLinkTmnl(data);
    
    // // 윈도우를 띄운다.
    // openWindow("/portal/data/link/selectLinkData.do", "selectLinkData", {
    //     width:"600px",
    //     height:"400px"
    // }, {
    //     type:"object",
    //     data:data
    // });
    if (data.linkUrl) {
        var url = com.wise.help.url("/portal/data/link/selectLinkData.do");
        
        url += "?infId="   + data.infId;
        url += "&infSeq="  + data.infSeq;
        url += "&linkSeq=" + data.linkSeq;
        
        window.open(url, "_blank").focus();
    }
}

/**
 * 공공데이터 링크 서비스 썸네일을 조회한다.
 * 
 * @param data {Object} 데이터
 */
function selectLinkTmnl(data) {
    $("#link-data-list li.on").each(function(index, element) {
        $(this).removeClass("on");
    });

    $("#link-data-list .linkExp.linkUrl[href='#" + data.linkSeq + "']").parent("li").addClass("on");

    if (data.tmnlImgFile) {
        var url = com.wise.help.url("/portal/data/link/selectLinkTmnl.do");
        
        // url += "?infId="   + data.infId;
        // url += "&infSeq="  + data.infSeq;
        // url += "&linkSeq=" + data.linkSeq;
        url += "?seq="         + data.seq;
        url += "&tmnlImgFile=" + data.tmnlImgFile;

        $("#link-thumbnail-sect").html("<img src=\"" + com.wise.help.url(url) + "\" alt=\""+ data.linkExp + "\" />");
    }
    else {
        $("#link-thumbnail-sect").empty();
    }
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
 * 공공데이터 링크 서비스 메타정보 조회 전처리를 실행한다.
 * 
 * @param options {Object} 옵션
 * @returns {Object} 데이터
 */
function beforeSelectLinkMeta(options) {
    var data = {
        // Nothing do do.
    };
    
    var form = $("#link-search-form");
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
 * 공공데이터 링크 서비스 데이터 검색 전처리를 실행한다.
 * 
 * @param options {Object} 옵션
 * @returns {Object} 데이터
 */
function beforeSearchLinkData(options) {
    var data = {
        // Nothing do do.
    };
    
    var form = $("#link-search-form");
    
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

////////////////////////////////////////////////////////////////////////////////
// 후처리 함수
////////////////////////////////////////////////////////////////////////////////
/**
 * 공공데이터 링크 서비스 메타정보 조회 후처리를 실행한다.
 * 
 * @param data {Object} 데이터
 */
function afterSelectLinkMeta(data) {
    // 공공데이터 링크 서비스 데이터를 검색한다.
    searchLinkData();
}

/**
 * 공공데이터 링크 서비스 데이터 검색 후처리를 실행한다.
 * 
 * @param data {Array} 데이터
 */
function afterSearchLinkData(data) {
    var list = $("#link-data-list");
    
    list.find("li").each(function(index, element) {
        $(this).remove();
    });
    
    for (var i = 0; i < data.length; i++) {
        var item = $(templates.data);
        
        item.find(".linkExp.linkUrl").attr("href", "#" + data[i].linkSeq).text(data[i].linkExp + " - " + data[i].linkUrl);
        //item.find(".linkExp.linkUrl").text(data[i].linkExp + " - " + data[i].linkUrl);
        // 공공데이터 링크 서비스 설명 링크에 클릭 이벤트를 바인딩한다.
        item.find(".linkExp.linkUrl").bind("click", {
            seq:data[i].seq,
            infId:data[i].infId,
            infSeq:data[i].infSeq,
            linkSeq:data[i].linkSeq,
            linkUrl:data[i].linkUrl,
            tmnlImgFile:data[i].tmnlImgFile,
            linkExp:data[i].linkExp
        }, function(event) {
            // // 공공데이터 링크 서비스 썸네일을 조회한다.
            //selectLinkTmnl(event.data);
            // 공공데이터 링크 서비스 데이터를 조회한다.
            selectLinkData(event.data);
            return false;
        });
        
        // 공공데이터 링크 서비스 설명 링크에 키다운 이벤트를 바인딩한다.
        item.find(".linkExp.linkUrl").bind("keydown", {
            seq:data[i].seq,
            infId:data[i].infId,
            infSeq:data[i].infSeq,
            linkSeq:data[i].linkSeq,
            linkUrl:data[i].linkUrl,
            tmnlImgFile:data[i].tmnlImgFile,
            linkExp:data[i].linkExp
        }, function(event) {
            if (event.which == 13) {
                // // 공공데이터 링크 서비스 썸네일을 조회한다.
                //selectLinkTmnl(event.data);
                // 공공데이터 링크 서비스 데이터를 조회한다.
                selectLinkData(event.data);
                return false;
            }
        });
        
        // 공공데이터 링크 서비스 바로가기 버튼에 클릭 이벤트를 바인딩한다.
        item.find(".link-select-button").bind("click", {
            seq:data[i].seq,
            infId:data[i].infId,
            infSeq:data[i].infSeq,
            linkSeq:data[i].linkSeq,
            linkUrl:data[i].linkUrl,
            tmnlImgFile:data[i].tmnlImgFile,
            linkExp:data[i].linkExp
        }, function(event) {
            // 공공데이터 링크 서비스 데이터를 조회한다.
            selectLinkData(event.data);
            return false;
        });
        
        // 공공데이터 링크 서비스 바로가기 버튼에 키다운 이벤트를 바인딩한다.
        item.find(".link-select-button").bind("keydown", {
            seq:data[i].seq,
            infId:data[i].infId,
            infSeq:data[i].infSeq,
            linkSeq:data[i].linkSeq,
            linkUrl:data[i].linkUrl,
            tmnlImgFile:data[i].tmnlImgFile,
            linkExp:data[i].linkExp
        }, function(event) {
            if (event.which == 13) {
                // 공공데이터 링크 서비스 데이터를 조회한다.
                selectLinkData(event.data);
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
        // $(".linkExp.linkUrl:first").click();
        // 공공데이터 링크 서비스 썸네일을 조회한다.
        selectLinkTmnl({
            seq:data[0].seq,
            infId:data[0].infId,
            infSeq:data[0].infSeq,
            linkSeq:data[0].linkSeq,
            tmnlImgFile:data[0].tmnlImgFile,
            linkExp:data[0].linkExp
        });
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
        form:"link-search-form",
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
// 이벤트 함수
////////////////////////////////////////////////////////////////////////////////