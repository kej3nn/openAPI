<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>

<!DOCTYPE html>
<html lang="ko">
<head>
<%@ include file="/WEB-INF/jsp/portal/sect/head.jsp" %>
</head>
<body>
<!-- wrapper -->
<div class="wrapper" id="wrapper">
<%@ include file="/WEB-INF/jsp/portal/sect/headerOpen.jsp" %>

<!-- container -->
<input type="hidden" id="kakaoKey" value="<spring:message code="Oauth2.Provider.Kakao.ClientId"/>">
<section>
	<div class="container" id="container">
	<!-- leftmenu -->
	<%@ include file="/WEB-INF/jsp/portal/sect/lnb.jsp" %>
	<!-- //leftmenu -->
	
    <!-- content -->
    <article>
		<div class="contents" id="contents">
			<div class="contents-title-wrapper">
				<h3>Open API 특징<span class="arrow"></span></h3>
				<ul class="sns_link">
					<li><a title="새창열림_페이스북" href="#" id="shareFB" class="sns_facebook">페이스북</a></li>
					<li><a title="새창열림_트위터" href="#" id="shareTW" class="sns_twitter">트위터</a></li>
					<li><a title="새창열림_네이버블로그" href="#" id="shareBG" class="sns_blog">네이버블로그</a></li>
					<li><a title="새창열림_카카오스토리" href="#" id="shareKS"  class="sns_kakaostory">카카오스토리</a></li>
					<li><a title="새창열림_카카오톡" href="#" id="shareKT" class="sns_kakaotalk">카카오톡</a></li>
				</ul>
        	</div>
        
	        <div class="layout_flex_100">
			<!-- CMS 시작 -->
	        
	        	<div class="content_txt">열린국회정보 포털에서 제공하는 Open API는 다음과 같은 특징을 가지고 있습니다.</div>
	        	<div class="openapi_list">
	        		<div class="ol01">
	        			<strong>1. 모든 데이터 유형의 Open API 제공</strong>
	        			<span>
	        				정보공개포털에서 제공하는 모든 데이터를 Open API로 제공합니다. <br> 개발자는 주기적으로 Open API를 호출하여 모든 데이터를 확보할 수 있습니다.
	        			</span>
	        		</div>
	        		<div class="ol02">
	        			<strong>2. 인증키 다중 발급 가능</strong>
	        			<span>
	        				정상 상태의 인증키를  최대 10개까지 발급받을 수 있습니다. <br>
							활용 용도나 서비스에 따라 고유한 인증키를 사용할 수 있으며, 발급한 인증키는 ‘인증키발급내역’ 메뉴에서 확인이 가능합니다.
						</span>
	        		</div>
	        		<div class="ol03">
	        			<strong>3. 인증키 이용내역 확인</strong>
	        			<span>
	        				정상 상태의 사용중인 인증키는 호출건수, 데이터건수, 초당 평균응답속도, 호출데이터량 등의 정보를 인증키별, 일자별로 확인이 가능합니다. 이를 통해 서비스 확장이나 문제점을 파악할 수 있을 것입니다. <br> 
							인증키별 이용 내역은 ‘인증키이용내역’ 메뉴를 통해 확인이 가능합니다.
						</span>
	        		</div>
	        		<div class="ol04">
	        			<strong>4. Open API 테스트</strong>
	        			<span>
	        				Open API를 사용하기 전에 미리 결과를 확인해 볼 수 있도록 테스트 기능을 제공합니다. <br> 
							요청 URL이나 호출 결과를 미리 검토할 수 있도록 하여 개발의 생산성을 높일 수 있을 것입니다.
						</span>
	        		</div>
	        		<div class="ol05">
	        			<strong>5. 다양한 요청인자 제공</strong>
	        			<span>
	        				각 Open API는 다양한 요청인자를 제공하여 모든 데이터를 한번에 받을 수도 있고, 특정 데이터만 선별하여 필요한 데이터만 받을 수 있습니다. 추가로 요청인자가 필요할 때에는 알림마당을 통해 신청하시면 즉시 처리해 드립니다.
	        			</span>
	        		</div>
	        	</div>
			
		<!-- //CMS 끝 -->
			</div>
		</div>
	</article>
	<!-- //contents  -->
	
		</div>
	</section>
	<!-- //container -->
<%@ include file="/WEB-INF/jsp/portal/sect/footer.jsp" %>
</div>
<script type="text/javascript" src="<c:url value="/js/portal/openapi/openApiSns.js" />"></script>
</body>
</html>