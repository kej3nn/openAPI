<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>

<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%-- @(#)useServiceIntro.jsp 1.0 2019/09/03                                    --%>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>

<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%-- 서비스 이용안내                    									--%>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>

<!DOCTYPE html>
<html lang="ko">
<head>
<%@ include file="/WEB-INF/jsp/portal/sect/head.jsp" %>
<script type="text/javascript" src="<c:url value="/js/portal/view/useServiceIntro.js" />"></script>
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
				<h3>서비스 이용안내<span class="arrow"></span></h3>
        	</div>

			<!-- CMS 시작 -->
			<div class="layout_flex_100">
				<div class="intro_txt">
					<strong>주요 서비스 이용안내</strong>
					<div>
						<p>
						국회 및 지원기관이 보유한 정보를 체계화하고 통합ㆍ공개하여 국민과 공유하고 <br>
						민간의 활용 촉진과 다양한  맞춤형 서비스를 제공하기 위해 구축된 정보공개 포털 서비스 입니다.
						</p> 
						<p>
						열린국회정보 서비스는 반응형 마인드맵 서비스, 다양한 활용체계 서비스, 통계 분석 및 Open API 서비스 등 차별화된 서비스를 제공합니다.
						</p> 
					</div>				
				</div>
				<div class="intro_service_list">
					<ul>
						<li class="isl01 on"><a href="javascript:;"><i></i><span>콘텐츠 서비스 제공</span></a></li>
						<li class="isl05"><a href="javascript:;"><i></i><span>목록 서비스 제공</span></a></li>
						<li class="isl06"><a href="javascript:;"><i></i><span>반응형 마인드맵 서비스</span></a></li>
						<li class="isl07"><a href="javascript:;"><i></i><span>다양한 서비스 유형 제공</span></a></li>
						<li class="isl08"><a href="javascript:;"><i></i><span>통계 분석 서비스</span></a></li>
						<li class="isl04"><a href="javascript:;"><i></i><span>국회 정보나침반 서비스</span></a></li>
						<li class="isl09"><a href="javascript:;"><i></i><span>Open API 서비스</span></a></li>
						<li class="isl10"><a href="javascript:;"><i></i><span>반응형 웹 서비스</span></a></li>
						<!--
						<li class="isl02"><a href="#"><i></i><span>분야별 공개 정보</span></a></li>
						<li class="isl03"><a href="#"><i></i><span>지원조직별 공개 정보</span></a></li>
						-->
					</ul>
				</div>
				
				<div class="intro_service_txt">
					<h4>콘텐츠 서비스 제공</h4>
					<div class="intro_service_img">
						<img src="/images/useservice_img01.png" alt="">
						<div>국회정보공개의 특성은 공개 정보에 대한 이해를 돕기 위한 콘텐츠, 해당 공개 정보에 대한 법률/규정/지침, 관련 데이터 목록을 확인하실 수 있습니다.<br><br>콘텐츠, 관련규정, 관련 데이터 서비스를 통합 제공하여 국민, NGO, 학계 관계자 모든 분이 관련 정보를 손쉽게 이해하실 수 있습니다. </div>
					</div>
				</div>
				
				<div class="intro_service_txt" style="display: none;">
					<h4>목록 서비스 제공</h4>
					<div class="intro_service_img">
						<img src="/images/useservice_img03.png" alt="">
						<div>
							국회정보공개 데이터를 손쉽게 탐색할 수 있는 정보목록 서비스를 제공합니다. 
							<dl>
								<dt>분류체계 : 열린국회정보 분류체계별로 정보 공개 조회</dt>
								<dt>공개 유형</dt>
								<dd>규정(지침) : 국회 공개 정보별 관련 규정 조회 서비스</dd>
								<dd>데이터 : 국회 공개 정보 중 원시성(Raw) 데이터 서비스</dd>
								<dd>통계 서비스 : 국회 공개 정보 중 수치화된 통계성 데이터 서비스 </dd>
								<dt>공개 유형 : 표, 차트, 지도, 파일, 링크, API 별로 정보 공개 조회</dt>
							</dl>
 						 </div>
					</div>
				</div>
				
				<div class="intro_service_txt" style="display: none;">
					<h4>반응형 마인드맵 서비스</h4>
					<div class="intro_service_img">
						<img src="/images/useservice_img04.png" alt="">
						<div>국회정보공개 분류체계에 대해서 직관적으로 인지할 수 있도록 마인드맵 서비스를 제공합니다.<br> 
조회하고자 하는 분류체계를 클릭하시면, 하위 분류체계와 관련된 공개정보 목록을 확인하실 수 있습니다. </div>
					</div>
				</div>
				
				<div class="intro_service_txt" style="display: none;">
					<h4>다양한 서비스 유형제공</h4>
					<div class="intro_service_img">
						<img src="/images/useservice_img05.png" alt="">
						<div>
							국회정보공개는 공개정보 특성을 고려하여 표, 차트, 지도, 파일, 링크 등 다양한 서비스 유형을 제공합니다. 
							또한, 개발자를 위한 Open API 서비스를 제공하여 데이터의 활용을 용이하도록 합니다.
							<dl>
								<dt>표 서비스 : 조건검색, 정렬, 다양한 포맷 다운로드 기능 제공</dt>
								<dt>차트 서비스 : 다양한 차트 유형 및 차트 이미지 다운로드 기능 제공</dt>
								<dt>지도 서비스 : 지리정보를 가진 데이터에 대해 지도 위치 확인 서비스 기능 제공</dt>
								<dt>파일 서비스 : 보고서/발간물 같은 한글, PDF 포맷의 자료에 대한 다운로드 기능 제공</dt>
								<dt>링크 서비스 : 국회 타 정보 서비스 및 타 기관에서 제공 중인 데이터에 대한 연결 기능 제공</dt>
							</dl>
						</div>
					</div>
				</div>
				
				<div class="intro_service_txt" style="display: none;">
					<h4>통계분석서비스</h4>
					<div class="intro_service_img">
						<img src="/images/useservice_img06.png" alt="">
						<div>국회정보공개 목록 중 시계열 특성을 가진 통계데이터에 대한 다양한 분석 기능을 제공합니다. <br><br>증감 분석, 피봇, 단위 및 소수점 변경, 통계분류/항목 설정, 다운로드 등 다양한 부가기능을 통해 통계 분석의 효율성을 향상시킬 수 있습니다. 또한, 국내 최고 수준의 차트 서비스를 통해 통계 통찰력(Insight)를 강화할 수 있습니다.</div>
					</div>
				</div>
				
				<div class="intro_service_txt" style="display: none;">
					<h4>국회 정보나침반 서비스</h4>
					<div class="intro_service_img">
						<img src="/images/useservice_img02.png" alt="">
						<div>국회 정보나침반 서비스는 국회정보서비스 사이트맵과 국회정보 카탈로그 정보를 제공합니다. <br>
							<dl>
								<dt>정보서비스 사이트맵 : 국회사무처, 국회도서관, 국회예산정책처, 국회입법조사처 등 국회 지원기관에서 제공 중인 대국민 정보 서비스 목록과 정보 서비스별 서비스 구성을 조회할 수 있습니다.</dt>
								<dt>정보 카탈로그 : 국회 지원기관 정보서비스에서 제공 중인 정보 목록, 제공 정보목록 등을 제공합니다. </dt>
							</dl>
						</div>
					</div>
				</div>
				
				<div class="intro_service_txt" style="display: none;">
					<h4>Open API 서비스</h4>
					<div class="intro_service_img">
						<img src="/images/useservice_img07.png" alt="">
						<div>국회정보공개 정보중 DB화된 정보에 대해 Open API 서비스를 제공합니다. <br><br>
열린국회정보포털 Open API는 열린국회정보를 보다 편리하게 활용할 수 있도록 외부에 공개하는 인터페이스 입니다. <br><br>
Open API를 실시간 연계하여 웹 또는 모바일 앱 등으로 다양하게 활용하실 수 있습니다. <br><br>
열린국회정보 Open API는 인증키 다중발급, 인증키 이용내역 확인, Open API 테스트 등 부가 기능을 제공하여, API 개발 효율성을 향상시킬 수 있습니다.</div>
					</div>
				</div> 
				
				<div class="intro_service_txt" style="display: none;">
					<h4>반응형 웹 서비스</h4>
					<div class="intro_service_img">
						<img src="/images/useservice_img08.png" alt="">
						<div>열린국회정보 포털 서비스는 반응형 웹 서비스로 제공되어, PC 환경에서 제공하는 모든  서비스를 다양한 스마트 디바이스에서도 언제 어디서나 활용하실 수 있습니다.</div>
					</div>
				</div>
				
			</div>
		
			<!-- //CMS 끝 -->
						
		</div>
	</article>
	<!-- //contents  -->

</div>
</section>
<!-- //container -->
<script type="text/javascript">
$(".intro_service_list li").each(function(idx) {
	$(this).bind("click", function(event) {
		$(".intro_service_list li").removeClass("on");
		$(this).addClass("on");
		$(".intro_service_txt").hide();
		$(".intro_service_txt").eq(idx).show();
	});
});

</script>
<%@ include file="/WEB-INF/jsp/portal/sect/footer.jsp" %>
</div>
</body>
</html>
