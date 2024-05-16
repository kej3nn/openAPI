/*
 * @(#)selectMapV2.js 1.0 2015/06/15
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
// var items;

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
var tooltip;

/**
 * 마커
 */
var markers;

////////////////////////////////////////////////////////////////////////////////
// 초기화 함수
////////////////////////////////////////////////////////////////////////////////
/**
 * 컴포넌트를 초기화한다.
 */
function initComp() {
    // // 맵 컴포넌트를 생성한다.
    // initMapComp();
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
        after:afterSelectMapMeta
    });
}

/**
 * 공공데이터 맵 서비스 데이터를 검색한다.
 */
function searchMapData() {
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
    // 데이터를 검색하는 화면으로 이동한다.
    goSearch({
        url:"/portal/data/dataset/searchDatasetPage.do",
        form:"dataset-search-form"
    });
}

// /**
//  * 맵 설정을 저장한다.
//  * 
//  * @param data {Object} 데이터
//  */
// function initMapConf(data) {
//     config = {
//         yPos:data.yPos,
//         xPos:data.xPos,
//         mapLevel:data.mapLevel,
//         markerCd:data.markerCd
//     };
// }

// /**
//  * 맵 항목을 설정한다.
//  * 
//  * @param data {Array} 데이터
//  */
// function initMapItems(data) {
//     items = {
//         // Nothing to do.
//     };
//     
//     for (var i = 0; i < data.length; i++) {
//         items[data[i].colCd] = data[i].colNm;
//     }
// }

// /**
//  * 맵 컴포넌트를 생성한다.
//  */
// function initMapComp() {
//     map = new daum.maps.Map(document.getElementById("map-object-sect"), {
//         center:new daum.maps.LatLng(37.27466697525489, 127.00961997318083),
//         level:9
//     });
//     
//     map.addControl(new daum.maps.MapTypeControl(), daum.maps.ControlPosition.TOPRIGHT);
//     map.addControl(new daum.maps.ZoomControl(), daum.maps.ControlPosition.BOTTOMRIGHT);
//     
//     map.setCopyrightPosition(daum.maps.CopyrightPosition.BOTTOMRIGHT, true);
//     
//     tooltip = new daum.maps.InfoWindow({
//         content:""
//     });
// }
/**
 * 맵 컴포넌트를 생성한다.
 * 
 * @param data {Object} 데이터
 */
function initMapComp(data) {
    data.yPos     = data.yPos     > 0 && data.xPos     > 0  ? data.yPos     : 37.27466697525489;
    data.xPos     = data.yPos     > 0 && data.xPos     > 0  ? data.xPos     : 127.00961997318083;
    data.mapLevel = data.mapLevel > 0 && data.mapLevel < 15 ? data.mapLevel : 9;
    
    if (data.first.length > 0) {
        if (data.first[0].Y_WGS84 > 0 && data.first[0].X_WGS84 > 0) {
            data.yPos = data.first[0].Y_WGS84;
            data.xPos = data.first[0].X_WGS84;
        }
    }
    
    map = new daum.maps.Map(document.getElementById("map-object-sect"), {
        center:new daum.maps.LatLng(data.yPos, data.xPos),
        level:data.mapLevel
    });
    
    map.addControl(new daum.maps.MapTypeControl(), daum.maps.ControlPosition.TOPRIGHT);
    map.addControl(new daum.maps.ZoomControl(), daum.maps.ControlPosition.BOTTOMRIGHT);
    
    map.setCopyrightPosition(daum.maps.CopyrightPosition.BOTTOMRIGHT, true);
    
    if (data.markerCd) {
        image = new daum.maps.MarkerImage(data.markerCd, new daum.maps.Size(32, 32), {
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

// /**
//  * 맵 컴포넌트를 설정한다.
//  * 
//  * @param data {Object} 데이터
//  */
// function editMapComp(data) {
//     if (data.yPos > 0 && data.xPos > 0) {
//         map.setCenter(new daum.maps.LatLng(data.yPos, data.xPos));
//     }
//     
//     if (0 < data.mapLevel && data.mapLevel < 15) {
//         map.setLevel(data.mapLevel);
//     }
//     
//     if (data.markerCd) {
//         image = new daum.maps.MarkerImage(data.markerCd, new daum.maps.Size(32, 32), {
//             offset:new daum.maps.Point(16, 32)
//         });
//     }
// }

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
    
    markers = [];
}

/**
 * 맵 데이터를 로드한다.
 * 
 * @param data {Array} 데이터
 */
function loadMapData(data) {
    // var count = 0;
    
    for (var i = 0; i < data.length; i++) {
        if (data[i].Y_WGS84 > 0 && data[i].X_WGS84 > 0) {
            // if (map == null) {
            //     config.yPos = data[i].Y_WGS84;
            //     config.xPos = data[i].X_WGS84;
            //     
            //     // 맵 컴포넌트를 생성한다.
            //     initMapComp(config);
            // }
            
            var options = {
                position:new daum.maps.LatLng(data[i].Y_WGS84, data[i].X_WGS84)
            };
            
            if (image) {
                options.image = image;
            }
            
            var marker = new daum.maps.Marker(options);
            
            marker.setMap(map);
            
            var content = "";
            
            for (var key in data[i]) {
                if (key != "Y_WGS84" && key != "X_WGS84") {
                    if (data[i][key] != null) {
                        if (content) {
                            content += "<br />";
                        }
                        
                        // if (items[key]) {
                        //     content += "<strong>" + items[key] + " : </strong>";
                        // }
                        
                        content += data[i][key];
                    }
                }
            }
            
            // if (content) {
            //     var tooltip = new daum.maps.InfoWindow({
            //         content:"<div style=\"padding:8px 8px 24px 8px;\">" + content + "</div>"
            //     });
            //     
            //     daum.maps.event.addListener(marker, "mouseover", (function(marker, tooltip) {
            //         return function() {
            //             tooltip.open(map, marker);
            //         };
            //     })(marker, tooltip));
            //     
            //     daum.maps.event.addListener(marker, "mouseout", (function(marker, tooltip) {
            //         return function() {
            //             tooltip.close();
            //         };
            //     })(marker, tooltip));
            // }
            daum.maps.event.addListener(marker, "mouseover", (function(marker, content) {
                return function() {
                    if (content) {
                        tooltip.setContent("<div style=\"padding:8px 8px 24px 8px;\">" + content + "</div>");
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
    
    // if (data.length > 0) {
    //     if (count > 0) {
    //         map.setCenter(new daum.maps.LatLng(data[0].Y_WGS84, data[0].X_WGS84));
    //     }
    // }
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
    // // 맵 설정을 저장한다.
    // initMapConf(data);
    
    // // 맵 항목을 설정한다.
    // initMapItems(data.items);
    
    // // 맵 컴포넌트를 설정한다.
    // editMapComp(data);
    // 맵 컴포넌트를 생성한다.
    initMapComp(data);
    
    // 맵 이벤트를 바인딩한다.
    bindMapEvent();
    
    // 공공데이터 맵 서비스 데이터를 검색한다.
    searchMapData();
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
    loadMapData(data);
}

////////////////////////////////////////////////////////////////////////////////
// 이벤트 함수
////////////////////////////////////////////////////////////////////////////////