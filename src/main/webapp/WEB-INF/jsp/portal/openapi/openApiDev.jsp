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
				<h3>Open API 사용방법<span class="arrow"></span></h3>
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
			    
		        <!-- Open API 사용방법 --> 
		        <div id="tab_B_cont_1">
			        <!-- <h4 class="title0402">Open API 사용방법</h4> -->
		
					<div class="contents-box">
						<h5 class="title0401 mb0">
							1. 사용할 Open API 정하기
						</h5>
						<p class="word-type02">
							Open API 목록 메뉴의 서비스 항목을 확인합니다.
						</p>
					</div>
		
					<div class="contents-box">
						<h5 class="title0401 mb0">
							2. 명세서를 다운로드 받습니다.
						</h5>
						<p class="word-type02 mb15">
							명세서에는 Open API를 사용하기 위한 설명이 포함되어 있습니다.
						</p>
		
						<div class="images-box line">
							<img src="<c:url value="/images/img030101.png" />" alt="open API 명세서" />
						</div>
					</div>
		
					<div class="contents-box">
						<h5 class="title0401 mb0">
							3. 인증키 발급 
						</h5>
						<p class="word-type02 mb15">
							열린국회정보에서 제공하는 Open API는 RESTful 방식의 웹서비스 입니다. RESTful 웹서비스는 HTTP를 사용하는 웹기반 인터페이스로 GET 또는 POST 방식의 URI를 통해 서비스 되기에 파라미터의 값을 URL에 표기하여 페이지를 로딩합니다.<br />
							인증키를 발급 받기 위해서는 로그인을 하셔야 합니다.
						</p>
		
						<div class="images-box line">
							<img src="<c:url value="/images/img030102.png" />" alt="open API 인증키 발급" />
						</div>
					</div>
		
					<div class="contents-box">
						<h5 class="title0401 mb0">
							4. URL 등록
						</h5>
						<p class="word-type02 mb15">
							열린국회정보에서 제공하는 Open API는 RESTful 방식의 웹서비스 입니다. RESTful 웹서비스는 HTTP를 사용하는 웹기반 인터페이스로 GET 또는 POST 방식의 URI를 통해 서비스 되기에 파라미터의 값을 URL에 표기하여 페이지를 로딩합니다.<br />
							인증키를 발급 받기 위해서는 로그인을 하셔야 합니다.
						</p>
		
						<div class="images-box line">
							<img src="<c:url value="/images/img030103.png" />" alt="URL 등록" />
						</div>
		
						<div class="url-reg-information">
							<ol>
								<li>
									<strong>
										① Open API URL
									</strong>
									열린국회정보의 Open API 주소는 <span class="break-all">https://www.열린국회정보s.go.kr/openapi/</span> 입니다.
								</li>
								<li>
									<strong>
										② Open API 명
									</strong>
									열린국회정보의 Open API 서비스는 고유명을 가지고 있습니다. 다운로드 받으신 명세표에 요청 주소가 표기되어 있습니다.
								</li>
								<li>
									<strong>
										③ 기본인자
									</strong>
									기본인자를 생략하면 명세표의 기본값으로 결과를 표기합니다. 인증키(KEY)는 발급을 받으신 후 발급 받은 인증키를 추가하여야 합니다. 만약 인증키가 없다면 기본값은 sample로 처리되어 10건 만 출력되므로 반드시 인증키를 입력하셔야 합니다. 호출문서(Type)은 xml 이나 json 등 출력하고자 하는 타입의 형태를 지정합니다. 기본값은 xml입니다. 페이지 위치(pIndex)는 출력하고자 하는 페이지 입니다. 데이터 수가 많은 경우에는 페이지 위치를 증가시키면서 여러 번에 나누어 호출하셔야 합니다. 페이지당 요청숫자(pSize)는 한 페이지에 출력될 건수입니다.
								</li>
								<li>
									<strong>
										④ 요청인자
									</strong>
									열린국회정보의 각 서비스 별로 별도로 지정한 인자 값입니다. 이 요청인자는 요청인자가 제공되는 서비스만 가능합니다.
								</li>
							</ol>
						</div>
					</div>
					<div class="contents-box">
						<h5 class="title0401 mb0">
							5. APP에서 Open API 요청
						</h5>
		
						<p class="word-type02 mb15">
							이제 Open API를 활용하여 새로운 App을 개발하였습니다. 개발 된 App에서 요청한 데이터가 여러분께서 만든 앱의 내용에 표시됩니다.
						</p>
		
						<div class="images-box line">
							<img src="<c:url value="/images/img030104.png" />" alt="Open API 요청" />
						</div>
					</div>
				</div>
				<!-- //Open API 사용방법 --> 
			  <!-- //CMS 끝 -->
			 </div>
		</div>
	</article>
	<!-- //contents  -->

	</div>
</section>       
		        
</script>		
<%@ include file="/WEB-INF/jsp/portal/sect/footer.jsp" %>
</div>
<script type="text/javascript" src="<c:url value="/js/portal/openapi/openApiSns.js" />"></script>
</body>
</html>