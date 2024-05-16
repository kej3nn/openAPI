<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%-- @(#)mainTextPop.jsp 1.0 2020/11/12										--%>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%-- 메인 2021년 국회의장 신년사 팝업 화면이다.												--%>
<%--																		--%>
<%-- @author Softon															--%>
<%-- @version 1.0 2020/12/31												--%>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<!DOCTYPE html>
<html lang="ko">
<head>
<title>2021년 국회의장 신년사 : 열린국회정보</title>
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
<style type="text/css">
html{overflow:hidden;overflow-y:auto;}
.pop_newyear{height:800px;width:900px;}
.pop_under_close{position:fixed;bottom:0;width:100%;}
@media only all and (max-width: 900px){
   .pop_newyear{height:800px;width:auto;}
   .pop_newyear img{max-width:100%;}
}
</style>
</head>   
<body>
<div>
   <div class="pop_newyear">
      <img src="<c:url value="/images/popup/newYearsMessage.jpg"/>" alt="박병석 국회의장 2022년 신년사
- 여야 모두 선국후당(先國後黨) 자세로 가다듬어야 -

존경하는 국민 여러분. 2022년 임인년(壬寅年) 새해입니다.
대한민국 국민들의 삶에 행복과 행운이 가득하길 기원합니다.

지난해 우리는 단계적 일상회복을 중지하고, 다시 어렵고 힘든 터널안으로
들어섰습니다. 사회적 거리두기 강화로 고통의 시기를 감내하고 계신 국민
한 분 한 분께 깊은 위로의 마음을 전합니다. 평범하다고만 여겼던 일들이 사실은
축복이였고, 때로는 무료하다고 느꼇던 날들이 실은 행복이였음을 새삼 느낍니다.

국민 여러분께서 하루빨리 고통의 터널을 지나 소중한 일상을 회복할 수 있도록,
올해 국회는 코로나 극복을 위한 민생입법을 신속히 뒷받침하겠습니다.
국민께 희망의 사다히흫 만들어드리기 위해 마부작침(磨斧作針)의 각오로
혼신의 힘을 다하겠습니다.

올해는 대선의 해입니다. 대한민국은 지금 '성장사회'에서 '성숙사회'로,
호랑이처럼 역동적으로 한 걸음 더 나아갈 것이냐,
아니면 후퇴할 것이냐의 분수령에 서 있습니다.

국민이 건강하고 안전한 나라, 격차와 차별이 완화된 더불어 사는 공동체, 핵무기와
전쟁이 없는 평화의 한반도. 그 안에서 정치는 서로 협력하여 국내외의 도전과 갈등을
극복해내어야 합니다. 경제는 디지털혁명과 4차산업혁명 시대에 맞는 질적 성장의
토대를 구축한 나라가 되어야 합니다.
우리가 꿈꾸는 성숙사회의 모습입니다.

이번 대선은 바로 이런 성숙사회를 향해 나아가는 여정이어야 합니다.
대선이 갈등과 분열을 심화시키는 과정이 아니라, 미래비전을 도출하고 국민을
통합해 내는 과정이어야만 합니다. 국민통합을 위해선 서로 다른 점은 인정하면서
공동의 이익을 추구하는 구동존이(求同存異), 경쟁하되 나라의 이익을 먼저 생각하는
선국후당(先國後黨)의 자세가 절실합니다. 그것이 코로나 팬데믹에 맞서 2년째
희생하고 계신 국민께 보답하는 길일 것입니다.

임인년에는 위대한 우리 국민의 마음을 하나로 모은 통합의 에너지를 발판으로
코로나 국난을 극복합시다. 새로운 희망을 만들어낼 수 있게 되기를 소망합니다.
국회가 먼저 통합의 큰 걸음을 시작하겠습니다.
국민 여러분께서도 힘과 지혜를 모아 합께 해 주실 것이라 믿습니다.

올 한해 우리 모두의 가정엣 웃음꽃이 피어나고, 마스크를 벗고 일상을 회복하기를
기원합니다.
국민 여러분, 새해 복 많이 받으십시오.


임인년 새해   
대한민국 국회의장  박병석">
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
    	var cookieNm = "mainNewYearMessagePopup";
    		gfn_setCookie(cookieNm, 'Y' , 1);
    }
    window.close();
}
/********************************************************************************
 * 팝업 관련 [END]
 ********************************************************************************/
</script>	
</html>