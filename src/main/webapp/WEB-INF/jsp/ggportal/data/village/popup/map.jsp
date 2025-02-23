<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%--                                                                        --%>
<%-- COPYRIGHT (C) 2013 WISEITECH CO., LTD. ALL RIGHTS RESERVED.            --%>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>

<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%--                                                                        --%>
<%-- @author 장홍식                                                         --%>
<%-- @version 1.0 2015/08/06                                              --%>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<script type="text/javascript">

$(function() {

	// 시 목록 데이터 조회
	selectListCityData();
	
	// 지도 클릭 이벤트
	mapClickEvent();

	// 지역 해제 버튼 클릭 이벤트
	offAreaClickEvent();
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
	var city_list_mob = $('#city_list_mob');
	$.each(data, function(i, d) {
		// 2016.07.29 type_cd 로 수정
		//city_list_mob.append('<option value='+d.OrgCd+'>'+d.orgNm+'</option>');
		//$('#city_map area[orgNm='+d.orgNm+']').attr('orgCd', d.OrgCd);

		city_list_mob.append('<option value='+d.typeOrgCd+'>'+d.orgNm+'</option>');
		$('#city_map area[orgNm='+d.orgNm+']').attr('orgCd', d.typeOrgCd);
	});
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
	var thisUrl = "${requestScope.uri}";
	var form = $('#dataset-search-form');
	form.find("input[name=sigunFlag]").remove();
	if(orgCd) {
		form.append('<input type="hidden" name="sigunFlag" value="'+orgCd+'"/>');
	}
    goSelect({
        url:thisUrl,
        form:"dataset-search-form"
    });
}

/**
 * 지역해제 버튼
 */
function offAreaClickEvent() {
	$('#offAreaBtn').click(function() {
		moveToListByCity(null);
	});
}

</script>

<!-- layerPopup 지역 선택 -->
<div class="layout_layerPopup_A layout_layerPopup_A_map">
	<div class="transparent"></div>
	<div id="layerPopup_map" class="layerPopup_A">
		<h4 class="pop h4_pop_map">지역 선택</h4>
		<!-- 내용 -->
		<div class="cont">
			<!-- 지도 (tablet/pc) -->
			<div class="map_pop">
				<p class="map_pop_blank"><img src="<c:url value="/img/ggportal/desktop/data/map_blank.png"/>" usemap="#Map"  alt="" /></p>
				<p class="map_pop_origin"><img src="<c:url value="/img/ggportal/desktop/data/map.png"/>" alt="가평,고양,과천,광명,광주,구리,군포,김포,남양주,동두천,부천,성남,수원,시흥,안산,안성,안양,양주,양평,여주,연천,오산,용인,의왕,의정부,이천,파주,평택,포천,하남,화성" /></p>
				<map name="Map" id="city_map">
					<area orgNm="연천군" shape="poly" coords="152,3,152,3,70,47,74,96,80,109,84,109,94,95,105,92,108,101,117,101,130,93,143,89,148,95,148,117,142,131,156,128,162,112,177,100,196,105,202,118,211,112,215,105,207,87,208,69" href="#none" onMouseOver="ovr_select_map('select_map_21');" onmouseout="out_select_map('select_map_21');" alt="연천" />
					<area orgNm="파주시" shape="poly" coords="73,98,45,123,42,141,54,153,59,167,57,187,49,199,47,210,56,210,63,215,71,214,74,208,83,205,96,207,107,215,123,172,137,153,139,133,145,118,147,96,144,91,130,95,120,102,108,103,104,96,95,97,86,111,79,111,72,99" href="#none" onMouseOver="ovr_select_map('select_map_27');" onmouseout="out_select_map('select_map_27');" alt="파주" />
					<area orgNm="김포시" shape="poly" coords="41,144,38,165,12,178,17,209,3,233,17,258,53,256,82,262,76,250,55,231,39,222,44,211,47,198,56,187,58,170,54,154,41,144" href="#none" onMouseOver="ovr_select_map('select_map_8');" onmouseout="out_select_map('select_map_8');" alt="김포"/>
					<area orgNm="동두천시" shape="poly" coords="178,103,164,113,157,128,168,140,177,141,187,149,199,149,203,139,200,129,201,119,196,106,179,102" href="#none" onMouseOver="ovr_select_map('select_map_10');" onmouseout="out_select_map('select_map_10');" alt="동두천"/>
					<area orgNm="양주시" shape="poly" coords="156,130,141,133,138,153,124,171,107,217,112,222,127,214,139,213,148,205,157,204,170,195,179,179,176,166,185,150,176,142,168,140,157,130" href="#none" onMouseOver="ovr_select_map('select_map_18');" onmouseout="out_select_map('select_map_18');" alt="양주"/>
					<area orgNm="고양시" shape="poly" coords="45,211,40,220,57,231,73,244,83,262,100,267,111,234,141,233,138,215,129,215,112,224,105,217,93,209,83,207,75,209,71,215,62,217,53,212,46,210" href="#none" onMouseOver="ovr_select_map('select_map_2');" onmouseout="out_select_map('select_map_2');" alt="고양"/>
					<area orgNm="의정부시" shape="poly" coords="170,197,159,205,149,206,140,214,143,233,175,233,193,216,186,202,171,197" href="#none" onMouseOver="ovr_select_map('select_map_25');" onmouseout="out_select_map('select_map_25');" alt="의정부"/>
					<area orgNm="포천시" shape="poly" coords="210,70,208,86,216,106,210,114,202,120,202,131,205,138,200,150,187,151,178,166,180,177,172,195,187,200,193,216,212,216,224,208,233,196,237,176,244,161,262,156,269,144,274,111,249,65,210,69" href="#none" onMouseOver="ovr_select_map('select_map_29');" onmouseout="out_select_map('select_map_29');" alt="포천"/>
					<area orgNm="구리시" shape="poly" coords="213,245,198,246,184,249,201,282,220,280,216,268,218,256,212,244" href="#none" onMouseOver="ovr_select_map('select_map_6');" onmouseout="out_select_map('select_map_6');" alt="구리"/>
					<area orgNm="남양주시" shape="poly" coords="234,197,226,208,214,217,193,218,176,234,184,247,199,245,214,243,220,254,219,267,222,280,233,290,245,295,262,270,267,239,250,211,234,197" href="#none" onMouseOver="ovr_select_map('select_map_9');" onmouseout="out_select_map('select_map_9');" alt="남양주"/>
					<area orgNm="가평군" shape="poly" coords="275,113,270,145,264,156,246,162,237,178,234,196,252,213,268,238,266,259,264,270,281,275,292,287,308,284,316,268,282,192,297,157,274,113" href="#none" onMouseOver="ovr_select_map('select_map_1');" onmouseout="out_select_map('select_map_1');" alt="가평"/>
					<area orgNm="하남시" shape="poly" coords="221,283,203,285,210,298,202,316,218,321,230,335,233,330,252,321,244,314,245,296,233,293,221,283" href="#none" onMouseOver="ovr_select_map('select_map_30');" onmouseout="out_select_map('select_map_30');" alt="하남"/>
					<area orgNm="양평군" shape="poly" coords="263,273,246,297,246,311,254,320,270,317,279,325,275,338,287,342,311,334,332,336,347,336,369,304,354,272,318,270,310,285,291,289,281,277,263,272" href="#none" onMouseOver="ovr_select_map('select_map_19');" onmouseout="out_select_map('select_map_19');" alt="양평"/>
					<area orgNm="성남시" shape="poly" coords="201,318,192,337,180,341,180,353,176,365,187,367,194,383,207,377,212,362,228,337,217,323,201,318" href="#none" onMouseOver="ovr_select_map('select_map_12');" onmouseout="out_select_map('select_map_12');" alt="성남"/>
					<area orgNm="광주시" shape="poly" coords="269,319,253,324,235,331,214,363,209,378,195,385,213,396,227,391,237,398,258,381,272,364,268,354,276,326,269,319" href="#none" onMouseOver="ovr_select_map('select_map_5');" onmouseout="out_select_map('select_map_5');" alt="광주"/>
					<area orgNm="여주시" shape="poly" coords="287,344,274,340,271,354,274,363,295,363,317,389,318,421,332,441,330,465,357,437,347,338,311,336,289,344" href="#none" onMouseOver="ovr_select_map('select_map_20');" onmouseout="out_select_map('select_map_20');" alt="여주"/>
					<area orgNm="이천시" shape="poly" coords="273,366,256,387,246,394,254,415,295,447,304,473,328,468,330,443,316,423,315,389,295,366,272,365" href="#none" onMouseOver="ovr_select_map('select_map_26');" onmouseout="out_select_map('select_map_26');" alt="이천"/>
					<area orgNm="부천시" shape="poly" coords="84,323,58,348,76,353,96,347,106,336,85,323" href="#none" onMouseOver="ovr_select_map('select_map_11');" onmouseout="out_select_map('select_map_11');" alt="부천"/>
					<area orgNm="시흥시" shape="poly" coords="97,350,78,355,55,350,41,363,36,372,70,380,103,382,109,370,104,359,96,349" href="#none" onMouseOver="ovr_select_map('select_map_14');" onmouseout="out_select_map('select_map_14');" alt="시흥"/>
					<area orgNm="광명시" shape="poly" coords="108,338,100,349,111,370,134,345,108,338" href="#none" onMouseOver="ovr_select_map('select_map_4');" onmouseout="out_select_map('select_map_4');" alt="광명"/>
					<area orgNm="안양시" shape="poly" coords="137,345,112,371,105,382,117,388,132,380,144,384,151,388,159,386,160,368,151,348,137,345" href="#none" onMouseOver="ovr_select_map('select_map_17');" onmouseout="out_select_map('select_map_17');" alt="안양"/>
					<area orgNm="과천시" shape="poly" coords="178,341,154,348,161,367,173,366,178,355,178,340" href="#none" onMouseOver="ovr_select_map('select_map_3');" onmouseout="out_select_map('select_map_3');" alt="과천"/>
					<area orgNm="의왕시" shape="poly" coords="174,367,162,369,161,387,196,412,206,408,211,398,193,386,186,368,174,366" href="#none" onMouseOver="ovr_select_map('select_map_24');" onmouseout="out_select_map('select_map_24');" alt="의왕"/>
					<area orgNm="안산시" shape="poly" coords="116,390,104,384,72,383,35,374,11,420,41,420,63,413,92,412,112,407,116,390" href="#none" onMouseOver="ovr_select_map('select_map_15');" onmouseout="out_select_map('select_map_15');" alt="안산"/>
					<area orgNm="군포시" shape="poly" coords="133,383,119,390,114,407,130,419,144,411,151,403,151,390,143,385,133,383" href="#none" onMouseOver="ovr_select_map('select_map_7');" onmouseout="out_select_map('select_map_7');" alt="군포"/>
					<area orgNm="수원시" shape="poly" coords="195,414,160,389,153,390,153,402,147,412,131,422,135,436,170,446,193,442,196,426,195,414" href="#none" onMouseOver="ovr_select_map('select_map_13');" onmouseout="out_select_map('select_map_13');" alt="수원"/>
					<area orgNm="용인시" shape="poly" coords="244,395,237,400,227,393,213,398,209,408,197,414,199,424,196,441,210,443,218,451,213,470,207,482,225,485,235,478,244,462,261,459,268,448,260,435,269,429,253,416,244,394" href="#none" onMouseOver="ovr_select_map('select_map_23');" onmouseout="out_select_map('select_map_23');" alt="용인"/>
					<area orgNm="화성시" shape="poly" coords="128,421,113,409,95,414,65,414,42,423,11,423,25,440,3,486,35,513,77,512,113,488,139,462,170,460,187,467,212,468,216,452,209,445,195,444,171,449,134,438,128,421" href="#none" onMouseOver="ovr_select_map('select_map_31');" onmouseout="out_select_map('select_map_31');" alt="하성"/>
					<area orgNm="오산시" shape="poly" coords="184,469,170,462,143,464,154,485,188,486,203,482,211,470,184,468" href="#none" onMouseOver="ovr_select_map('select_map_22');" onmouseout="out_select_map('select_map_22');" alt="오산"/>
					<area orgNm="평택시" shape="poly" coords="153,486,140,464,119,485,79,514,97,540,190,534,193,511,185,497,187,487,152,485" href="#none" onMouseOver="ovr_select_map('select_map_28');" onmouseout="out_select_map('select_map_28');" alt="평택"/>
					<area orgNm="안성시" shape="poly" coords="271,431,263,435,269,447,263,460,246,464,237,477,226,488,204,484,189,488,187,495,195,511,192,534,223,532,282,479,302,474,293,448,271,430" href="#none" onMouseOver="ovr_select_map('select_map_16');" onmouseout="out_select_map('select_map_16');" alt="안성"/>
				</map>
				<div id="select_map_1" class="select_map_1" style="display:none;" onMouseOver="ovr_select_map('select_map_1');" onMouseOut="out_select_map('select_map_1');"></div>
				<div id="select_map_2" class="select_map_2" style="display:none;" onMouseOver="ovr_select_map('select_map_2');" onMouseOut="out_select_map('select_map_2');"></div>
				<div id="select_map_3" class="select_map_3" style="display:none;" onMouseOver="ovr_select_map('select_map_3');" onMouseOut="out_select_map('select_map_3');"></div>
				<div id="select_map_4" class="select_map_4" style="display:none;" onMouseOver="ovr_select_map('select_map_4');" onMouseOut="out_select_map('select_map_4');"></div>
				<div id="select_map_5" class="select_map_5" style="display:none;" onMouseOver="ovr_select_map('select_map_5');" onMouseOut="out_select_map('select_map_5');"></div>
				<div id="select_map_6" class="select_map_6" style="display:none;" onMouseOver="ovr_select_map('select_map_6');" onMouseOut="out_select_map('select_map_6');"></div>
				<div id="select_map_7" class="select_map_7" style="display:none;" onMouseOver="ovr_select_map('select_map_7');" onMouseOut="out_select_map('select_map_7');"></div>
				<div id="select_map_8" class="select_map_8" style="display:none;" onMouseOver="ovr_select_map('select_map_8');" onMouseOut="out_select_map('select_map_8');"></div>
				<div id="select_map_9" class="select_map_9" style="display:none;" onMouseOver="ovr_select_map('select_map_9');" onMouseOut="out_select_map('select_map_9');"></div>
				<div id="select_map_10" class="select_map_10" style="display:none;" onMouseOver="ovr_select_map('select_map_10');" onMouseOut="out_select_map('select_map_10');"></div>
				<div id="select_map_11" class="select_map_11" style="display:none;" onMouseOver="ovr_select_map('select_map_11');" onMouseOut="out_select_map('select_map_11');"></div>
				<div id="select_map_12" class="select_map_12" style="display:none;" onMouseOver="ovr_select_map('select_map_12');" onMouseOut="out_select_map('select_map_12');"></div>
				<div id="select_map_13" class="select_map_13" style="display:none;" onMouseOver="ovr_select_map('select_map_13');" onMouseOut="out_select_map('select_map_13');"></div>
				<div id="select_map_14" class="select_map_14" style="display:none;" onMouseOver="ovr_select_map('select_map_14');" onMouseOut="out_select_map('select_map_14');"></div>
				<div id="select_map_15" class="select_map_15" style="display:none;" onMouseOver="ovr_select_map('select_map_15');" onMouseOut="out_select_map('select_map_15');"></div>
				<div id="select_map_16" class="select_map_16" style="display:none;" onMouseOver="ovr_select_map('select_map_16');" onMouseOut="out_select_map('select_map_16');"></div>
				<div id="select_map_17" class="select_map_17" style="display:none;" onMouseOver="ovr_select_map('select_map_17');" onMouseOut="out_select_map('select_map_17');"></div>
				<div id="select_map_18" class="select_map_18" style="display:none;" onMouseOver="ovr_select_map('select_map_18');" onMouseOut="out_select_map('select_map_18');"></div>
				<div id="select_map_19" class="select_map_19" style="display:none;" onMouseOver="ovr_select_map('select_map_19');" onMouseOut="out_select_map('select_map_19');"></div>
				<div id="select_map_20" class="select_map_20" style="display:none;" onMouseOver="ovr_select_map('select_map_20');" onMouseOut="out_select_map('select_map_20');"></div>
				<div id="select_map_21" class="select_map_21" style="display:none;" onMouseOver="ovr_select_map('select_map_21');" onMouseOut="out_select_map('select_map_21');"></div>
				<div id="select_map_22" class="select_map_22" style="display:none;" onMouseOver="ovr_select_map('select_map_22');" onMouseOut="out_select_map('select_map_22');"></div>
				<div id="select_map_23" class="select_map_23" style="display:none;" onMouseOver="ovr_select_map('select_map_23');" onMouseOut="out_select_map('select_map_23');"></div>
				<div id="select_map_24" class="select_map_24" style="display:none;" onMouseOver="ovr_select_map('select_map_24');" onMouseOut="out_select_map('select_map_24');"></div>
				<div id="select_map_25" class="select_map_25" style="display:none;" onMouseOver="ovr_select_map('select_map_25');" onMouseOut="out_select_map('select_map_25');"></div>
				<div id="select_map_26" class="select_map_26" style="display:none;" onMouseOver="ovr_select_map('select_map_26');" onMouseOut="out_select_map('select_map_26');"></div>
				<div id="select_map_27" class="select_map_27" style="display:none;" onMouseOver="ovr_select_map('select_map_27');" onMouseOut="out_select_map('select_map_27');"></div>
				<div id="select_map_28" class="select_map_28" style="display:none;" onMouseOver="ovr_select_map('select_map_28');" onMouseOut="out_select_map('select_map_28');"></div>
				<div id="select_map_29" class="select_map_29" style="display:none;" onMouseOver="ovr_select_map('select_map_29');" onMouseOut="out_select_map('select_map_29');"></div>
				<div id="select_map_30" class="select_map_30" style="display:none;" onMouseOver="ovr_select_map('select_map_30');" onMouseOut="out_select_map('select_map_30');"></div>
				<div id="select_map_31" class="select_map_31" style="display:none;" onMouseOver="ovr_select_map('select_map_31');" onMouseOut="out_select_map('select_map_31');"></div>
			</div>
			<!-- // 지도 (tablet/pc) -->

			<!-- 지역 찾기 (mobile) -->
			<div class="region_search_pop mq_mobile">
            <select id="city_list_mob" title="시군 선택">
                <option value="">선택</option>
            </select>
			</div>
			<!-- // 지역 찾기 (mobile) -->
		</div>
		<!-- //내용 -->
		<a href="#btn_E_map" class="btn_close"><span>레이어 팝업 닫기</span></a>
	</div>
</div>
<!-- layerPopup 지역 선택 -->