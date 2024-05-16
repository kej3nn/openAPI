<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%-- @(#)mainPop.jsp 1.0 2020/03/03											--%>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%-- 메인 팝업 화면이다.													--%>
<%--																		--%>
<%-- @author Softon															--%>
<%-- @version 1.0 2020/03/03												--%>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<!DOCTYPE html>
<html lang="ko">
	<!-- 팝업 500 x 520 -->
	<!-- 팝업 461 x 571 -->
	<c:if test="${not empty homePopup }">
		<div class="oktee" style="display:none;">
			<div>
				<a href="<c:url value="${homePopup.linkUrl }"/>" target="_blank"><img src="<c:url value="/portal/main/commHomeImg.do?seqceNo=${homePopup.homeSeq }"/>" alt="${homePopup.srvNm }"></a>			
			</div>
			<div class="oktee_close">
			    <p>
			        <input type="checkbox" id="close">
			        <label for="close">오늘 하루 창열지 않기</label>
			    </p>
			    <a href="#" onclick="javascript:closeWin();" >닫기</a>
			</div>
		</div>
	</c:if>
	<!-- //팝업 500 x 520 -->
<script type="text/javascript">
/********************************************************************************
 * 팝업 관련 [BEGIN]
 ********************************************************************************/
 var isMobile = $(window).width() <= 980 ? true : false; // 모바일 접근 여부
 
 $(window).load(function() {
	if ( $(".oktee").length > 0 ) {
		eventPopup(); 
	}
 });
function eventPopup() {
	
    if(gfn_getCookie("event") != "Y"){
    	$(".oktee").show();
    }
}
//닫기 버튼 클릭시
function closeWin() {
    if( $("#close").prop("checked") ) {
    	gfn_setCookie('event', 'Y' , 1 );
    }
    $(".oktee").hide();
}
/********************************************************************************
 * 팝업 관련 [END]
 ********************************************************************************/
</script>

<!-- 2021년 국회의장 신년사 -->
<script type="text/javascript">

if (new Date() >= new Date('01/01/2022 00:00:00')           // 언제부터		
	&& new Date() < new Date('02/08/2022 23:59:59')) {        // 언제까지 실행하기
	
	var mainNewYearMessageCookieNm = "mainNewYearMessagePopup";
	if( gfn_getCookie(mainNewYearMessageCookieNm) !== "Y" ) {
		var popupWidth = 500;
		var popupHeight = 771;
		var popupX = (window.screen.width / 2) - (popupWidth) - 20;
		var popupY= (window.screen.height / 2) - (popupHeight / 2);
		
		if(!isMobile) window.open("/portal/main/mainNewYearsMessage.do", "_blank", "top="+popupY+", left="+popupX+", width="+popupWidth+", height="+popupHeight+", location=no, directories=no, resizable=no, status=no, toolbar=no, menubar=no, scrollbars=no");
	}
	
	var mainOkteeCookieNm = "mainOkteePop";
	if( gfn_getCookie(mainOkteeCookieNm) !== "Y" ) {
		
		if(navigator.userAgent.indexOf("Trident") != -1){
			var popupWidth = 542;
			var popupHeight = 767;
			var popupX = (window.screen.width / 2) - (popupWidth / 2) + (popupWidth / 2);
			var popupY= (window.screen.height / 2) - (popupHeight / 2);
			var option = "top="+popupY+", left="+popupX+", width="+popupWidth+", height="+popupHeight+", location=no, directories=no, resizable=no, status=no, toolbar=no, menubar=no, scrollbars=no";
		}else{
			var popupWidth = 546;
			var popupHeight = 771;
			var popupX = (window.screen.width / 2) - (popupWidth / 2) + (popupWidth / 2);
			var popupY= (window.screen.height / 2) - (popupHeight / 2);
			var option = "top="+popupY+", left="+popupX+", width="+popupWidth+", height="+popupHeight+", location=no, directories=no, resizable=no, status=no, toolbar=no, menubar=no, scrollbars=no";
		}
		//window.open("/portal/main/mainOkteePop.do", "_blank", option);
	}
}
</script>
						
</html>