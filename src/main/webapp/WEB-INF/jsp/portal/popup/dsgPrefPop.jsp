<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%-- 메인 옥의 티를 찾아라 팝업화면	  											    --%>
<%--																		--%>
<%-- @author Softon															--%>
<%-- @version 1.0 2021/01/05												--%>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<!DOCTYPE html>
<html lang="ko">
<head>
<title>대한민국 국회 디자인 선호도 조사 참여</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no, target-densitydpi=medium-dpi">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="format-detection" content="telephone=no">
<meta name="copyright" content="대한민국국회. ALL RIGHTS RESERVED.">
<script type="text/javascript" src="<c:url value="/js/jquery/jquery-2.2.4.min.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/jquery/jquery-ui.min.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/jquery/json.min.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/jquery/jquery.form.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/jquery/jquery.cookie.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/jquery/jquery.meio.mask.js" />" charset="utf-8"></script>
<script type="text/javascript" src="<c:url value="/js/common/base/commonness.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/common/base/delegation.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/soportal/common/common.js" />"></script>
<link rel="stylesheet" type="text/css" href="/css/portal/assembly.css">
<script type="text/javascript">
    var getContextPath = "<c:out value="${pageContext.request.contextPath}" />";
    $(function() {
	    $("#goEvent").bind("click", function(event) {
	    	//windowOpen("/portal/etc/event/insertBulletinPage.do", "1200", "900","yes", "yes");
	    	alert("이벤트 기간이 아닙니다.");
	    });
    });
    
</script>

</head>   
<body>
    <section class="survey">
        <article style="line-height:0;">
            <img src="<c:url value="/images/assembly/section1.png"/>" alt="대한민국 국회 대표 홈페이지 디자인 선호도 조사.대한민국 국회 대표 홈페이지 개편을 준비 중에 있습니다. 
            메인화면 디자인을 여러분의 손으로 뽑아주세요.조사기간:2022년 2월 21일(월) ~ 2월 25일(금) 추첨발표:2022년 3월 4일(금) : 그룹웨어 공지">
        </article>
        <%-- <article>
            <ul>
                <li>
                    <img src="<c:url value="/images/assembly/design1.png"/>" alt="시안1">
                </li>
                <li>
                	<img src="<c:url value="/images/assembly/design2.png"/>" alt="시안2">
                </li>
                <li>
                	<img src="<c:url value="/images/assembly/design3.png"/>" alt="시안3">
                </li>
            </ul>
            <p>* 디자인 시안은 PC를 기준으로 제작되었습니다.  </p>
        </article> --%>
        <article>
            <img src="<c:url value="/images/assembly/section3.png"/>" alt="참여방법:첫번째 아래 디자인 시안 보기 버튼을
            클릭하여 디자인 시안을
            확인하세요 두번째 선호도 조사 참여하기 버튼을
            눌러 추첨을 위한 연락처를
            입력해 주세요 세번째 마음에 드는
            시안을 선택하고 의견을
            작성하여 신청해 주세요.
            선호도 조사에 참여해 주신 300명에게 추첨을 통해 스타벅스 아메리카노 기프티콘 1매를 드립니다.">

            <div class="btn-wrap" style="margin:30px 0 0 0;">
                <%-- <button>
                    <img src="<c:url value="/images/assembly/btn1.png"/>" alt="디자인 시안 보기">
                </button> --%>
                <button type="button" id="goEvent">
                    <img src="<c:url value="/images/assembly/btn2.png"/>" alt="선호도 조사 참여">
                </button>
            </div>
        </article>
    </section>
</body>
</html>