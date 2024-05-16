<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%-- @(#)header.jsp 1.0 2018/02/01                                          --%>
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
<%-- 상단 팝업 화면이다.                                                    		--%>
<%--                                                                        --%>
<%-- @author SoftOn                                                         --%>
<%-- @version 1.0 2018/02/01                                                --%>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>

<script type="text/javascript">
$(document).ready(function(){  

    if($.cookie('mainTopBanner') == 'hidden'){
    	$("#mainTopBanner").hide();
    }else{
    	//메인 상단 배너데이터를 호출한다.
    	mainBannerDataCall();
    }

});
////////////////////////////////////////////////////////////////////////////////
//맵 데이터 호출
////////////////////////////////////////////////////////////////////////////////
function mainBannerDataCall(){
	var params = "homeTagCd=BANER";

	$.ajax({
		url : com.wise.help.url("/portal/main/mainBannerList.do"),
		async : false,
		type : 'POST',
		data : params,
		dataType : 'json',
		beforeSend : function(obj) {
		}, // 서버 요청 전 호출 되는 함수 return false; 일 경우 요청 중단
		success : function(res) {
			//var data = res.data.BANNERLIST;
			var data = res.data;
			if(data.length > 0){
				
				
				var bannerDiv = $("#responsive-popup");
				bannerDiv.empty();
				
				var innerHtml = "";
				var dataBannerCnt = 0;
				$.each(data, function(key, value){					
					var toDay = chkToday();
					var startDay = 0;
					var endDay = 0;
					if(value.strtDttm != null) startDay = value.strtDttm.replace(/-/gi, ""); 
					if(value.endDttm != null) endDay = value.endDttm.replace(/-/gi, ""); 
					
					if(toDay >= startDay && toDay <= endDay){
						innerHtml += '<li>';
						var urlChk = value.linkUrl;
						var linkUrl = value.linkUrl;
						if(urlChk.substring(0,1) == "/") linkUrl = "https://www.nabostats.go.kr" + urlChk;
						if(value.popupYn == "Y"){
						innerHtml += '<a href="'+linkUrl+'" target="_blank">';
						}else{
						innerHtml += '<a href="'+linkUrl+'">';
						}
						innerHtml += '	<span class="title">'+value.srvTit+'</span>';
						//innerHtml += '	<span class="submit">'+value.srvContent+'</span>';
						innerHtml += '<span class="word-detail-view">자세히보기</span>';
						innerHtml += '</a>';
						innerHtml += '</li>';
						
						dataBannerCnt++;
					}
				});				
				bannerDiv.append(innerHtml);
				
				if(dataBannerCnt > 0){
					$("#mainTopBanner").show();
				}else{
					$("#mainTopBanner").hide();
				}
				
			}else{
				$("#mainTopBanner").hide();
			}

			/* top popup slider*/
			$('#responsive-popup').bxSlider({
			     pager: false,
			     infiniteLoop: false,
			     slideMargin: 25,
			     autoReload: true,
			     breaks: [
			      {screen:0, slides:1, pager:false},
			      {screen: 474, slides:2}
			     ]
			});

			/* top popup close*/
			$(".btn-top-popup-close").click(function(e) {
				e.preventDefault();
	            var chkd = $("#top-popup-checkbox").is(":checked");
	            if(chkd){
	                $.cookie('mainTopBanner', 'hidden', {expires : 1});
	            }
	            $(".header-popup-area").slideUp(500);
			});
			
		}, // 요청 완료 시
		error : function(request, status, error) {
			handleError(status, error);
		}, // 요청 실패.
		complete : function(jqXHR) {
		} // 요청의 실패, 성공과 상관 없이 완료 될 경우 호출
	});
	
	
}

function chkToday(){ //YYYYMMDD 형태
	var today = new Date();
	var dd = today.getDate();
	var mm = today.getMonth()+1;
	var yyyy = today.getFullYear();

	if(dd<10) dd='0'+dd;
	if(mm<10) mm='0'+mm;

	return yyyy+''+mm+''+dd;
}

</script>	
<!-- top popup -->
<div class="header-popup-area" id="mainTopBanner" style="display: none;">
	<div class="header-popup-box">
		<ul id="responsive-popup">
		</ul>
	</div>

	<div class="btns-area">
		<div class="btns-box">
			<p class="today-close">
				<input type="checkbox" id="top-popup-checkbox" name="top-popup-checkbox" />
				<label for="top-popup-checkbox">
					오늘은 다시 보지 않음
				</label>
			</p>

			<a href="javascript:;" class="btn-top-popup-close">
				닫기
			</a>
		</div>
	</div>
</div>
<!-- //top popup -->
			
	    