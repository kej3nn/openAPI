<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>

<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%-- @(#)serviceIntro.jsp 1.0 2019/09/03                                    --%>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>

<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%-- 서비스 소개		                    									--%>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>

<!DOCTYPE html>
<html lang="ko">
<head>
<%@ include file="/WEB-INF/jsp/portal/sect/head.jsp" %>

</head>
<body>
<!-- wrapper -->
<div class="wrapper" id="wrapper">
<%@ include file="/WEB-INF/jsp/portal/sect/header.jsp" %>

<!-- container -->
<section>
	<div class="container" id="container">
	<!-- leftmenu -->
	<%@ include file="/WEB-INF/jsp/portal/sect/lnb.jsp" %>
	<!-- //leftmenu -->
    <!-- content -->
    <article>
		<div class="contents" id="contents">
			<div class="contents-title-wrapper">
				<h3>서비스 소개<span class="arrow"></span></h3>
        	</div>

			<!-- CMS 시작 -->
			<div class="layout_flex_100">
				<div class="intro_txt">
					<h4>열린국회정보 소개</h4>
					<strong>국회를 열다, 정보를 나누다.</strong>
					<div>
						<p>
						국회 및 지원기관이 보유한 정보를 체계화하고 통합·공개하여 국민과 공유하고 <br>
						민간의 활용 촉진과 다양한  맞춤형 서비스를 제공하기 위해 구축된 정보공개 포털 서비스입니다.
						</p> 
						<p>
						열린국회정보는 정보공개를 통해 적극적으로 국민에 공개하고 국민과의 공유를 통해 공개 정보에 대한 <br>  
						민간 활용을 촉진하고 새로운 서비스와 공공의 가치를 창출하기 위한 서비스입니다. <br>
						국회는 사회적 활용 가치가 높은 정보를 공개하여 국회의 투명성을 제고하도록 하겠습니다.
						</p> 
					</div>				
				</div>
				<div class="intro_img">
					<img src="/images/intro_img01.png" alt="">
				</div>
				<div class="intro_img">
					<img src="/images/intro_img02.png" alt="예상되는 기대효과 - 1. 국민, 민간 : 편익증대 -> 국민참여 2. 국회 : 투명성 제고 -> 활용가치 높은 정보 공개 3. 시민단체, 기자, 전문가 : 가치부여 -> 국민 중심의 새로운 서비스, 콘텐츠 [결론] 수요자 중심의 정보 공개를 통한 사회적 가치 창출">
				</div>
				<div class="intro_txt" style="display:none;">
					<h4>열린국회정보는 <em>국내 NO.1 정보 공개 서비스</em>입니다.</h4>
					<div>
						<p>
						국회 및 지원기관(국회사무처, 국회예산정책처, 국회도서관, 국회입법조사처) 이 보유한 정보를  발굴하여 <br> 
						통합된 포털을 통해 공개함으로써 국민의 국회의 정보 활용을 향상시키고자 합니다. <br> 
						공개 정보는 데이터의 특성을 고려하여 Sheet, Chart, Map, File, Link, 시각화 서비스로 제공되며 개발자를 위한 <br>  
						Open API 서비스를 제공하여 데이터의 활용을 용이하도록 합니다.  
						</p>
						<p>
						또한, 통계데이터의 경우 통계분석 전용 서비스를 통해 증감 분석, 피봇, 단위 및 소수점 변경, 통계항목 설정, 다운로드 등  <br>  
						다양한 부가기능을 통해 통계 분석의 효율성을 향상시킬 수 있습니다. <br> 
						또한, 국내 최고 수준의 차트 및 Map 시각화 서비스를 통해 통계 통찰력(Insight)를 강화할 수 있습니다.
						</p>
					</div>
				</div>
				<div class="intro_img">
					<img src="/images/intro_img03.png" alt="국회는 보유한 정보를 공개하여 누구든지 편리하게 이용할 수 있도록 노력하고 공개 대상 정보를 점차 확대해 나아가겠습니다.">
				</div>
			</div>
		
			<!-- //CMS 끝 -->
			
		</div>
	</article>
	<!-- //contents  -->

</div>
</section>
<!-- //container -->

<%@ include file="/WEB-INF/jsp/portal/sect/footer.jsp" %>
</div>
</body>
</html>
