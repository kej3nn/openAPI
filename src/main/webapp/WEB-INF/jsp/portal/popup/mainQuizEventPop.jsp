<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%-- @(#)mainQuizEventPop.jsp 1.0 2021/01/05								--%>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%-- 퀴즈 이벤트 팝업화면	  											   			--%>
<%--																		--%>
<%-- @author Softon															--%>
<%-- @version 1.0 2021/01/05												--%>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<!DOCTYPE html>
<html lang="ko">
<head>
<title>열린국회정보 사이트 개편 이벤트 - 국회와 함께하는 "퀴즈 이벤트"</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no, target-densitydpi=medium-dpi">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="format-detection" content="telephone=no">
<meta name="copyright" content="대한민국국회. ALL RIGHTS RESERVED.">
<link rel="stylesheet" type="text/css" href="/css/portal/default.css">
<link rel="stylesheet" type="text/css" href="/css/portal/notokr.css">
<link rel="stylesheet" type="text/css" href="/css/portal/layout.css">
<link rel="stylesheet" type="text/css" href="/css/portal/layout_mobile.css">
<script type="text/javascript" src="<c:url value="/js/jquery/jquery-2.2.4.min.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/common/base/commonness.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/portal/common.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/jquery.rwdImageMaps.min.js" />"></script>
<style type="text/css">
body{overflow:hidden;}
*{margin:0;padding:0;list-style:none;box-sizing:border-box;}
div{height:627px;}
ul{overflow:hidden;padding:5px 10px;background:#647183;width:488px;}
ul li{float:left;}
ul li.popup_win_close{float:right;}
label,a{color:#ffffff;font-size:14px;text-decoration:none;letter-spacing:-0.5px;}

@media all and (max-width: 1023px) {
	div{height:auto;}
	img{max-width:100%;}
	ul{width:auto;}
}
</style>
</head>   
<body>
   <div class="pop_newyear">
      <img src="<c:url value="/images/popup/pop_quizevent.png"/>" usemap="#quizevent" alt="
열린국회정보 사이트 개편 이벤트
국회와 함께하는 퀴즈 이벤트
퀴즈풀고, 문화상품권 받고 유익한 국회 정보는 덤!
참여기간 2021.01.08(금)~2021.01.31(일)
당첨자발표 2021.02.05(금) 열린국회정보 공지사항에 게시
경품내역 문화상품권 5,000원권(200명)
참여방법 하단의 이벤트 참여하기를 클릭하여 퀴즈에 참여하세요.
※이벤트에 참여해주신 분께는 추첨을 통해 소정의 상품을 드립니다."></div>
	<ul>
	  <li><input type="checkbox" id="chkNotTodayOpen"> <label for="chkNotTodayOpen">오늘 하루 이창을 열지 않음</label></li>
	  <li class="popup_win_close"><a href="javascript: closeWin();">[닫기]</a></li>
	</ul>
	<map name="quizevent">
	  <area shape="rect" coords="48,526,276,571" href="<c:url value="/portal/main/mainQuizEventRegPage.do"/>" target="_blank"  alt="이벤트 참여하기">
	</map>
<script type="text/javascript">
/********************************************************************************
 * 팝업 관련 [BEGIN]
 ********************************************************************************/
 $(document).ready(function(e) {
	$('img[usemap]').rwdImageMaps();
 });
//닫기 버튼 클릭시
function closeWin() {
	// 오늘 하루 이창 열지않음 체크되있을경우
    if( $("#chkNotTodayOpen").is(":checked") ) {
    	var cookieNm = "mainQuizEventPop";
    		gfn_setCookie(cookieNm, 'Y' , 1);
    }
    window.close();
}
/********************************************************************************
 * 팝업 관련 [END]
 ********************************************************************************/
</script>	
</body>
</html>