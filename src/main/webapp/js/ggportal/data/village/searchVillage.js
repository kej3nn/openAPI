/*
 * COPYRIGHT (C) 2013 WISEITECH CO., LTD. ALL RIGHTS RESERVED.
 */

/**
 * 우리지역 데이터 찾기
 *
 * @author 장홍식
 * @version 1.0 2015/08/05
 */
$(function() {
	
	// 시 목록 데이터 조회
	selectListCityData();
	
	// 지도 클릭 이벤트
	mapClickEvent();
	
});

/**
	시 목록 데이터 조회
*/	
function selectListCityData() {
	doSelect({
        url:"/portal/data/village/selectListCity.do"
        , before:function() {return {};}
		, after:drawCityList
    });
}

function drawCityList(data) {
	var city_list_ul = $('#city_list');
	var city_list_mob = $('#city_list_mob');
	$.each(data, function(i, d) {
		// 2016.07.29 type_cd 로 수정
		//city_list_ul.append('<li id="'+d.orgCd+'"><a style="cursor:pointer;">'+d.orgNm+'</a></li>');
		//city_list_mob.append('<option value='+d.orgCd+'>'+d.orgNm+'</option>');
		//$('#city_map area[orgNm='+d.orgNm+']').attr('orgCd', d.orgCd);
		
		city_list_ul.append('<li id="'+d.typeOrgCd+'"><a style="cursor:pointer;">'+d.orgNm+'</a></li>');
		city_list_mob.append('<option value='+d.typeOrgCd+'>'+d.orgNm+'</option>');
		$('#city_map area[orgNm='+d.orgNm+']').attr('orgCd', d.typeOrgCd);
	});
	// 클릭 시 화면 이동
	/*
	$('#city_list li').click(function() {
		moveToListByCity($(this).attr('id'));
	});*/
	// 셀렉트박스 선택 시 화면 이동(mobile)
	city_list_mob.change(function() {
		moveToListByCity($(this).val());
	});
	
}

/**
	지도 클릭 이벤트
*/
function mapClickEvent() {
	var area_list = $('#city_map area');
	area_list.click(function() {
		moveToListByCity($(this).attr('orgCd'));
	});
}

/**
 * 지역 별 목록 화면으로 이동
*/
function moveToListByCity(orgCd) {
	var form = $('#villageForm');
	form.attr("action", "/portal/data/village/selectListDataByCityPage.do");
	form.append('<input type="hidden" name="sigunFlag" value="'+orgCd+'"/>');
	form.submit();
}