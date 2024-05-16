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
				<h3>Open API 소개<span class="arrow"></span></h3>
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
	        
	        	<div class="openapi-information-wrapper">
					<p class="bg">
						<img src="<c:url value="/images/img0101.png" />" alt="" />
					</p>
					<div class="openapi-information-slogan">
						<h4>
							열린국회정보 
							<span>
								Open API 
							</span>
						</h4>
						<p>
							열린국회정보 포털 정보에 대한 Open API 서비스를 제공합니다. 
						</p>
						<p>
							열린국회정보 Open API는 열린국회정보 정보를 보다 편리하게 활용할 수 있도록 외부에 공개하는 인터페이스 입니다.										
						</p>
						<p>
							Open API를 실시간 연계하여 웹 또는 모바일 앱 등으로 다양하게 활용하실 수 있습니다. 
						</p>
					</div>
				</div>
			
				<h4 class="title0401">
					사용방법
				</h4>
			
				<div class="images-box">
					<img src="<c:url value="/images/img0102@2x_pc.png" />" alt="사이트접속, Open API 인증키 신청, Open API검색 및 이용방법 확인, OPEN API를 이용 어플리케이션 제작" class="pc" />
			
					<img src="<c:url value="/images/img0102@2x_mobile.png" />" alt="사이트접속, Open API 인증키 신청, Open API검색 및 이용방법 확인, OPEN API를 이용 어플리케이션 제작" class="mobile image-openapi-process-mobile" />
				</div>
			
			
				<div class="openapi-information">
					<div class="openapi-information-area">
						<img src="<c:url value="/images/icon_simbol0101@2x.png" />" alt="" class="simbol" />
						<dl>
							<dt>
								Open API 제공 목록
							</dt>
							<dd>
								<p>
									열린국회정보 포털에서 제공하는 Open API 목록을 확인하실 수 있습니다.
								</p>
								<a href="<c:url value="/portal/openapi/openApiNaListPage.do" />">
									<span>
										자세히보기
									</span>
									<img src="<c:url value="/images/icon_arrow_right02@2x.png" />" alt="" />
								</a>
							</dd>
						</dl>
					</div>
			
					<div class="openapi-information-area">
						<img src="<c:url value="/images/icon_simbol0102@2x.png" />" alt="" class="simbol" />
						<dl>
							<dt>
								인증키 발급
							</dt>
							<dd>
								<p>
									인증키를 발급받아 Open API 서비스를 이용하실 수 있습니다.
								</p>
								<a href="<c:url value="/portal/openapi/openApiActKeyPage.do" />">
									<span>
										자세히보기
									</span>
									<img src="<c:url value="/images/icon_arrow_right02@2x.png" />" alt="" />
								</a>
							</dd>
						</dl>
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