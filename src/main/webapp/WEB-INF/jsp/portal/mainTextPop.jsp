<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%-- @(#)mainTextPop.jsp 1.0 2020/11/12										--%>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<% pageContext.setAttribute("replaceBR", "\n"); %>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%-- 메인 텍스트 팝업 화면이다.												--%>
<%--																		--%>
<%-- @author Softon															--%>
<%-- @version 1.0 2020/11/12												--%>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<!DOCTYPE html>
<html lang="ko">
<head>
<title><c:out value="${mainTextPopup.srvNm }"></c:out> : 열린국회정보</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no, target-densitydpi=medium-dpi">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="format-detection" content="telephone=no">
<meta name="copyright" content="대한민국국회. ALL RIGHTS RESERVED.">
<meta name="description" content="국회 및 지원기관이 보유한 정보를 체계화하고 통합·공개하여 국민과 공유하고 민간의 활용 촉진과 다양한 맞춤형 서비스를 제공하기 위해 구축된 정보공개 포털 서비스 입니다.">
<meta name="keywords" content="국회사무처,대한민국국회,정보공개,포털">
<link rel="stylesheet" type="text/css" href="/css/portal/default.css">
<link rel="stylesheet" type="text/css" href="/css/portal/notokr.css">
<link rel="stylesheet" type="text/css" href="/css/portal/layout.css">
<link rel="stylesheet" type="text/css" href="/css/portal/layout_mobile.css">
<script type="text/javascript" src="<c:url value="/js/jquery/jquery-2.2.4.min.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/common/base/commonness.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/portal/common.js" />"></script>
<style type="text/css">
	body{overflow:hidden;}
</style>
</head>	
	<div>
		<div class="pop_under_cont">
		<c:if test="${mainTextPopup != null }">
			<c:choose>
				<c:when test="${mainTextPopup.homeTagCd eq 'TEXTA' }">
					<div class="bg_under01">
						<input type="hidden" id="homeSeq" value="${mainTextPopup.homeSeq }">
						<strong><c:out value="${mainTextPopup.srvNm }"></c:out></strong>
						<div>
							<span><c:out value="${fn:replace(mainTextPopup.srvCont, replaceBR, '<br>') }" escapeXml="false"></c:out></span>
						</div>
					</div>
				</c:when>
				<c:when test="${mainTextPopup.homeTagCd eq 'TEXTB' }">
					<div class="bg_under02">
						<input type="hidden" id="homeSeq" value="${mainTextPopup.homeSeq }">
						<strong><c:out value="${mainTextPopup.srvNm }"></c:out></strong>
						<div>
							<span><c:out value="${fn:replace(mainTextPopup.srvCont, replaceBR, '<br>') }" escapeXml="false"></c:out></span>
						</div>
					</div>
				</c:when>
				<c:otherwise>
				</c:otherwise>
			</c:choose>
		</c:if>
		</div>
		<div class="pop_under_close">
			<div>
				<input type="checkbox" id="chkNotTodayOpen">
				<label for="chkNotTodayOpen">오늘 하루 이창을 열지 않음</label>
			</div>
			<a href="javascript: closeWin();">[닫기]</a>
		</div>
	</div>
	
<script type="text/javascript">
/********************************************************************************
 * 팝업 관련 [BEGIN]
 ********************************************************************************/
//닫기 버튼 클릭시
function closeWin() {
	// 오늘 하루 이창 열지않음 체크되있을경우
    if( $("#chkNotTodayOpen").is(":checked") ) {
    	var cookieNm = "";
    	if ( $(".pop_under_cont > div").hasClass("bg_under01") ) {
    		cookieNm = "mainTextAPopup_";
    	} 
    	else if ( $(".pop_under_cont > div").hasClass("bg_under02") ) {
    		cookieNm = "mainTextBPopup_";
    	}
    	
    	var homeSeq = $(".pop_under_cont").find("#homeSeq").val();
    	if ( cookieNm !== "" && !com.wise.util.isNull(homeSeq) ) {
    		cookieNm = cookieNm + homeSeq;
    		gfn_setCookie(cookieNm, 'Y' , 1);
    	}
    }
    
    window.close();
}
/********************************************************************************
 * 팝업 관련 [END]
 ********************************************************************************/
</script>	
</html>