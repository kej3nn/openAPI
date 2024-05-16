/**
 * 지도화면 호출 적용
 * 
 * @param map			//지도서비스 기본변수
 * @param tooltip		//지도서비스 환경변수용
 * 
 * 글로벌 변수에 적용하여 데이터를 전달한다.
 * @param regionData	//지도서비스 행정구역 명칭
 * @param regionValue	//지도서비스 행정구역 VALUE
 * @param mapCenterX	//지도서비스 지도 중앙 위도
 * @param mapCenterY	//지도서비스 지도 중앙 경도
 * @param valColor1		//지도서비스 행정구역 색상1
 * @param valColor2		//지도서비스 행정구역 색상2
 * @param valColor3		//지도서비스 행정구역 색상3
 * @param boxDataType	//지도서비스 행정구역선택 데이터 타입
 * 
 */
////////////////////////////////////////////////////////////////////////////////
//맵노출 이벤트 호출
////////////////////////////////////////////////////////////////////////////////
function eventThemeMapCall(){
	//네이버 지도 행정구역 경계 좌표값이 들어 있는 json파일 호출
    urlPrefix = '/js/soportal/regiondata/region',
    urlSuffix = '.json',
    regionGeoJson = [],
    loadCount = 0;

	for (var i = 1; i < 18; i++) {
	    var keyword = i +'';
	
	    if (keyword.length === 1) {
	        keyword = '0'+ keyword;
	    }
	
	    $.ajax({
	        url: urlPrefix + keyword + urlSuffix,
	        success: function(idx) {
	            return function(geojson) {
	                regionGeoJson[idx] = geojson;
	
	                loadCount++;
	
	                if (loadCount === 17) {
	                    startDataLayer();
	                }
	            }
	        }(i - 1)
	    });
	}
	
	//지도가 그려지는 DIV ID는 map
	//map의 크기에 따라서 중심좌표를 변경한다.
	map = new naver.maps.Map(document.getElementById('map'), {
	    zoom: 2,
	    mapTypeId: 'normal',
	    center: new naver.maps.LatLng(mapCenterX, mapCenterY)
	});
	
	tooltip = $('<div style="position:absolute;z-index:1000;padding:5px 10px;background-color:#fff;border:solid 2px #000;font-size:14px;pointer-events:none;display:none;"></div>');
	
	tooltip.appendTo(map.getPanes().floatPane);
	
	//지도 하단 naver링크 및 copyright 제거
	$("#map").find('a').css("display", "none");
	$("#map").find('div[class=map_copyright]').css("display", "none");
}
////////////////////////////////////////////////////////////////////////////////
//맵노출 Data별 화면 처리
////////////////////////////////////////////////////////////////////////////////
function startDataLayer() {

	//글로벌 변수 regionData와 regionValue의 값으로
	//지도의 행정구역 내 색상 및 값을 세팅
	
	var fillOy = 0;
    map.data.setStyle(function(feature) {
    	var baseData = 0;
    	for(var i=0; i<regionData.length; i++){
    		if(feature.property_area3 == regionData[i]){
    			baseData = regionValue[i];
    			fillOy = baseData * 0.015;
    		}
    	}
    	
    	var styleOptions = null;
    	if(baseData < 100){
	    	styleOptions = {
	    		fillColor: valColor1,
	            fillOpacity: fillOy,
    			strokeColor: valColor1,
	            strokeWeight: 2,
	            strokeOpacity: 0.4
	        };
    	}else{
	    	styleOptions = {
		    	fillColor: valColor2,
		        fillOpacity: fillOy,
		    	strokeColor: valColor2,
		        strokeWeight: 2,
		        strokeOpacity: 0.4
		    };
    	}
    	
        if (feature.getProperty('focus')) {
            styleOptions.fillOpacity = 0.6;
            styleOptions.fillColor = valColor3;
            styleOptions.strokeColor = valColor3;
            styleOptions.strokeWeight = 4;
            styleOptions.strokeOpacity = 1;
        }

        return styleOptions;
    });

    regionGeoJson.forEach(function(geojson) {
        map.data.addGeoJson(geojson);
    });
    
    map.data.addListener('click', function(e) {
        var feature = e.feature;

        if (feature.getProperty('focus') !== true) {
            feature.setProperty('focus', true);
        } else {
            feature.setProperty('focus', false);
        }
    });

    map.data.addListener('mouseover', function(e) {
        var feature = e.feature,
        //지도내 행정구역 명칭은 json파일 내의 area3으로 노출 
        regionName = feature.getProperty('area3');

	    for(var i=0; i<regionData.length; i++){
	    	if(regionName == regionData[i]){
	    		if(boxDataType == "JISU"){
	    			regionName = regionName + " [지수 : " + regionValue[i] + "%]";
	    		}
	    	}
	    }
    	
        tooltip.css({
            display: '',
            left: e.offset.x,
            top: e.offset.y,
            fontWeight : 5
        }).text(regionName);

        map.data.overrideStyle(feature, {
            fillOpacity: 0.6,
            strokeWeight: 3,
            strokeOpacity: 1
        });
    });

    map.data.addListener('mouseout', function(e) {
        tooltip.hide().empty();
        map.data.revertStyle();
    });
}