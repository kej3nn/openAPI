/*
 * @(#)selectMap.js 1.0 2015/06/15
 * 
 * COPYRIGHT (C) 2013 WISEITECH CO., LTD. ALL RIGHTS RESERVED.
 */

/**
 * 공공데이터 맵 서비스를 조회하는 스크립트이다.
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
// /**
//  * 설정
//  */
// var confing;

// /**
//  * 항목
//  */
 var items;

/**
 * 맵
 */
var map;

/**
 * 이미지
 */
var image;

/**
 * 툴팁
 */
var infoWindow;

/**
 * 마커
 */
var markers;
var polys = new Array();

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
//    // // 맵 컴포넌트를 생성한다.
//    // initMapComp();
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
    
    // 공공데이터 지도 서비스 필터검색 버튼에 클릭 이벤트를 바이딩한다.
    $("#map-search-button").bind("click", function(event) {
    	$("input[id=searchCd]").val("F");
        // 공공데이터 지도 서비스 데이터를 검색한다.
        searchMapData();
        return false;
    });
    
    // 공공데이터 지도 서비스 필터검색 버튼에 키다운 이벤트를 바이딩한다.
    $("#map-search-button").bind("keydown", function(event) {
        if (event.which == 13) {
        	$("input[id=searchCd]").val("F");
            // 공공데이터 지도 서비스 데이터를 검색한다.
            searchMapData();
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
    // 공공데이터 맵 서비스 메타정보를 조회한다.
    selectMapMeta();
}

////////////////////////////////////////////////////////////////////////////////
// 서비스 함수
////////////////////////////////////////////////////////////////////////////////
/**
 * 공공데이터 맵 서비스 메타정보를 조회한다.
 */
function selectMapMeta() {
    // 데이터를 조회한다.

    doSelect({
        url:"/portal/data/map/selectMapMeta.do",
        before:beforeSelectMapMeta,
        after: afterSelectMapMeta
    });
}

/**
 * 공공데이터 맵 서비스 데이터를 검색한다.
 */
function searchMapData() {
    // 데이터를 검색한다.
	$("#map-object-sect").find("div[style='font: 11px tahoma, sans-serif; float: right; margin: 3px 2px 0px;']").css("display", "none");
	$("#map-object-sect").find("a[href='http://map.daum.net/']").css("display", "none");
	
    // 데이터를 검색한다.
    doSearch({
        url:"/portal/data/map/searchMapData.do",
        before:beforeSearchMapData,
        after:afterSearchMapData
    });
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

// /**
//  * 맵 설정을 저장한다.
//  * 
 function initMapItems(data) {
     items = {
         // Nothing to do.
     };
     
     for (var i = 0; i < data.length; i++) {
         items[data[i].colCd] = data[i].colNm;
     }
 }

/**
 * 맵 컴포넌트를 생성한다.
 * `
 * @param data {Object} 데이터
 */

function initMapComp(data) {
    data.yPos     = data.yPos     > 0 && data.xPos     > 0  ? data.yPos     : 37.522681949477025;
    data.xPos     = data.yPos     > 0 && data.xPos     > 0  ? data.xPos     : 126.92185405195066;
    data.mapLevel = data.mapLevel > 0 && data.mapLevel < 15 ? data.mapLevel : 9;
    
/*    if (data.first.length > 0) {
        if (data.first[0].Y_WGS84 > 0 && data.first[0].X_WGS84 > 0) {
            data.yPos = data.first[0].Y_WGS84;
            data.xPos = data.first[0].X_WGS84;
        }
    }*/
    
    map = new daum.maps.Map(document.getElementById("map-object-sect"), {
        center:new daum.maps.LatLng(data.yPos, data.xPos),
        level:data.mapLevel
    });
    
    map.addControl(new daum.maps.MapTypeControl(), daum.maps.ControlPosition.TOPRIGHT);
    map.addControl(new daum.maps.ZoomControl(), daum.maps.ControlPosition.BOTTOMRIGHT);
    
    map.setCopyrightPosition(daum.maps.CopyrightPosition.BOTTOMRIGHT, true);
    
    if (data.markerCd) {
        image = new daum.maps.MarkerImage(data.markerCd, new daum.maps.Size(35, 35), {
            offset:new daum.maps.Point(16, 32)
        });
    }
    
    tooltip = new daum.maps.InfoWindow({
        content:""
    });
    
    markers = [
        // Nothing to do.
    ];
}

/**
 * 맵 이벤트를 바인딩한다.
 */
function bindMapEvent() {
    daum.maps.event.addListener(map, "idle", function() {
        // 공공데이터 맵 서비스 데이터를 검색한다.
        searchMapData();
    });
}
/**
 * 맵 마커를 초기화한다.
 */
function initMapMarkers() {
    if (markers) {
        for (var i = 0; i < markers.length; i++) {
            markers[i].setMap(null);
        }
    }
    
    if (polys) {
        for (var i = 0; i < polys.length; i++) {
        	polys[i].setMap(null);
        }
    }
    
    markers = [];
    polys = [];
}

/**
 * 맵 데이터를 로드한다.
 * 
 * @param data {Array} 데이터
 */
function loadMapData(data) {
	
    for (var i = 0; i < data.length; i++) {
        if (data[i].Y_WGS84 > 0 && data[i].X_WGS84 > 0) {

        	// 마커가 표시될 위치입니다 
        	var markerPosition  = new daum.maps.LatLng(data[i].Y_WGS84, data[i].X_WGS84); 

        	// 마커를 생성합니다
        	var marker = new daum.maps.Marker({
        	    position: markerPosition,
        	    image : image
        	});

            marker.setMap(map);
            
            var content = "";
            
            for (var key in data[i]) {
                if (key != "Y_WGS84" && key != "X_WGS84") {
                    if (data[i][key] != null) {
                        if (content) {
                            content += "<br />";
                        }
                        
                        if (items[key]) {
                             content += "<strong style=\"color:#ffffff;font-size:13px;\">" + items[key] + " : </strong>";
                        }
                        
                        content += data[i][key];
                    }
                }
            }

            daum.maps.event.addListener(marker, "mouseover", (function(marker, content) {
                return function() {
                    if (content) {
                        tooltip.setContent("<div style=\"font-size:13px;padding:8px 10px;background-color: rgb( 95, 157, 224);color:#ffffff;border:3px solid #ffffff;border-radius:5px;-webkit-border-radius:5px;-moz-border-radius:5px;-o-border-radius:5px;\">" + content + "</div>");
                        tooltip.open(map, marker);
                    }
                    else {
                        tooltip.close();
                    }
                };
            })(marker, content));
            
            daum.maps.event.addListener(marker, "mouseout", (function() {
                return function() {
                    tooltip.close();
                };
            })());
            
            markers[markers.length] = marker;
            
            // count++;
        }
    }

}


////////////////////////////////////////////////////////////////////////////////
// 전처리 함수
////////////////////////////////////////////////////////////////////////////////
/**
 * 공공데이터 맵 서비스 메타정보 조회 전처리를 실행한다.
 * 
 * @param options {Object} 옵션
 * @returns {Object} 데이터
 */
function beforeSelectMapMeta(options) {
	
	var data = {
        // Nothing do do.
    };
    
    var form = $("#map-search-form");
    var form2 = $("#dataset-search-form");
	
   	if ( typeof(form2) == "object" ) {
   	    var id = form2.find("input[name=infId]").val() || form.find("input[name=infId]").val();
	    var seq = form2.find("input[name=infSeq]").val() || form.find("input[name=infSeq]").val();
   	    
   	    form.find("input[name=infId]").val(id);
   	    form.find("input[name=infSeq]").val(seq);
    }
    
	
    $.each(form.serializeArray(), function(index, element) {
        switch (element.name) {
            case "loc":
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
 * 공공데이터 맵 서비스 데이터 검색 전처리를 실행한다.
 * 
 * @param options {Object} 옵션
 * @returns {Object} 데이터
 */
function beforeSearchMapData(options) {
    var data = {
        // Nothing do do.
    };
    
    var form = $("#map-search-form");
    
    $.each(form.serializeArray(), function(index, element) {
        switch (element.name) {
            case "version":
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
    
    var bounds = map.getBounds();
    
    var sw = bounds.getSouthWest();
    
    var ne = bounds.getNorthEast();
    
    data.Y_WGS84_FROM = sw.getLat();
    data.Y_WGS84_TO   = ne.getLat();
    data.X_WGS84_FROM = sw.getLng();
    data.X_WGS84_TO   = ne.getLng();
    
    return data;
}
////////////////////////////////////////////////////////////////////////////////
// 후처리 함수
////////////////////////////////////////////////////////////////////////////////
/**
 * 공공데이터 맵 서비스 메타정보 조회 후처리를 실행한다.
 * 
 * @param data {Object} 데이터
 */
function afterSelectMapMeta(data) {

	//추천 데이터셋을 검색한다.
//    selectRecommandDataSet();
    
    // // 맵 설정을 저장한다.
    // initMapConf(data);
    
    // // 맵 항목을 설정한다.
     initMapItems(data.items);
    
    // // 맵 컴포넌트를 설정한다.
    // editMapComp(data);
    // 맵 컴포넌트를 생성한다.
     
     
    initMapComp(data);
    
    //맵서비스를 shape파일로 오픈할지 확인
    doAjax({
		url : "/portal/data/map/selectOpenInfIsShape.do",
		params : {infId : $("#map-search-form").find("input[name=infId]").val()},
		callback : function(res) {
			if ( res.data != null ) {
				// shape 파일이 있으면
				openShapefile(res.data);
				
			} else {
				// 맵 이벤트를 바인딩한다.
			    bindMapEvent();
			    
			    addMapSearchFilters(data.filters);
			    
			    // 공공데이터 맵 서비스 데이터를 검색한다.
			    searchMapData();
				
			    //마커 순서 세팅
			    markerOrderSet(data.marker);
			    
			}
		}
	});
    
}

function openShapefile(data) {
	// 지도 툴팁
    //var tooltip = $('<div style="position:absolute;z-index:1000;padding:5px 10px;background-color:#fff;border:solid 2px #000;font-size:14px;pointer-events:none;display:none;"></div>');
    //tooltip.appendTo(map.getPanes().floatPane);
    
    // shape 파일다운로드 인자
    var param = "?infId=" + data.infId;
    param += "&infSeq="  + data.infSeq;
    param += "&fileSeq=" + data.fileSeq;
    
    // Shapefile 을 lod 하여 geojson 으로 반환해줌
    loadshp({
    	url: '/portal/data/file/downloadFileData.do' + param,
        encoding: 'utf-8',
        EPSG: 4326
    }, function(geojson) {  // geojson 을 받을 수 있음 - loadshp 를 사용해서 Shapefile 을 geojson 으로 변환해주는 것까지가 Shapefile 관련 라이브러리의 역할이고 이후의 다른 기능들은 네이버 지도 라이브러리의 기능입니다.
        
        // 아래의 소스코드는 네이버 지도 예제
        // https://kakaomaps.github.io/maps.js/docs/tutorial-2-datalayer-region.example.html
        // 를 보고 만든 것입니다.

        // 스타일 설정
        map.data.setStyle(function(feature) {
            // 기본 스타일
            var styleOptions = {
                fillColor: '#ff0000',
                fillOpacity: 0.0001,
                strokeColor: '#ff0000',
                strokeWeight: 2,
                strokeOpacity: 0.4
            };

            // polygon 위에 마우스를 올렸을 때의 스타일
            if (feature.getProperty('focus')) {
                styleOptions.fillOpacity = 0.6;
                styleOptions.fillColor = '#0f0';
                styleOptions.strokeColor = '#0f0';
                styleOptions.strokeWeight = 4;
                styleOptions.strokeOpacity = 1;
            }

            return styleOptions;
        });
        
        // 지도에 geojson 추가
        map.data.addGeoJson(geojson);

        // 클릭 이벤트
        map.data.addListener('click', function(e) {
            var feature = e.feature;

            if (feature.getProperty('focus') !== true) {
                feature.setProperty('focus', true);
            } else {
                feature.setProperty('focus', false);
            }
        });

        // 마우스오버 이벤트
        map.data.addListener('mouseover', function(e) {
            var feature = e.feature,
                regionName = feature['property_BJD_NAM'];
            /*	
            tooltip.css({
                display: '',
                left: e.offset.x,
                top: e.offset.y
            }).text(regionName);
			*/
            map.data.overrideStyle(feature, {
                fillOpacity: 0.6,
                strokeWeight: 4,
                strokeOpacity: 1
            });
        });

        // 마우스아웃 이벤트
        map.data.addListener('mouseout', function(e) {
            //tooltip.hide().empty();
            map.data.revertStyle();
        });

    });
}

var markerCd = new Array();
 
//마커 순서 세팅
function markerOrderSet(data){
	if(data != null){

		var legendAppend = "";
		
		for(var i=0; i<data.length; i++){
			legendAppend += "<span><img src='/img/map/marker_0"+(i+1)+".png' /> "+data[i].MARKER+"</span><br>";
			markerCd.push(data[i].MARKER);
		}
		var legendH = 20*data.length + "px";
		$(".markerLegend").css("height", legendH);

    	$("#legendArea").show();
    	$("#legendArea").empty().append(legendAppend);
	}
}

function addMapSearchFilters(filters) {
    if (filters.length > 0) {
        $("#map-search-sect").removeClass("hide");
    }
    
    var form = $('#map-search-form');
    var sigunFlag = form.find("[name=sigunFlag]").val();
    
    // 검색 필터를 추가한다.
    addSearchFilters("map-search-table", filters, {
        idPrefix:"sheet-filter-",
        idKey:"srcColId",
        onKeyDown: searchMapData
    }, sigunFlag);
}

/**
 * 공공데이터 맵 서비스 데이터 검색 후처리를 실행한다.
 * 
 * @param data {Object} 데이터
 */
function afterSearchMapData(data) {

    // 맵 마커를 초기화한다.
    initMapMarkers();
    
    // 맵 데이터를 로드한다.
    loadMapData(data.result);

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
        form:"map-search-form",
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
////////////////////////////////////////////////////////////////////////////////
// 이벤트 함수
////////////////////////////////////////////////////////////////////////////////