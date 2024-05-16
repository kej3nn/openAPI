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
<script type="text/javascript">
var tabIdx = ${tabIdx};
</script>
<script type="text/javascript" src="<c:url value="/js/portal/openapi/openApiActKey.js" />"></script>
<style type="text/css">
a { cursor:pointer;}
</style>

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
	            <h3>인증키 발급내역<span class="arrow"></span></h3>
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
				<!-- 
				<div id="tab_layout" class="tabmenu-type01 type02 mt0">
					<ul><li id="tab_0"><a href="#">인증키<span>발급 내역 </span></a></li>
						<li id="tab_3"><a href="#">인증키<span>이용 내역</span></a></li>
						<li id="tab_1"><a href="#">인증키<span>발급</span></a></li>
						<li id="tab_2"><a href="#">Open API<span>테스트</span></a></li>
					</ul>
				</div> -->
				
				<div id="content_0" class="board-area children_content">
					<div class="board-top-information clear pt15">
						<p class="total fl" id="actKey">전체 <strong class="totalNum">0</strong> 건</p>
						<a href="javascript:;" class="fr btn-m btns-color06 btn_AC" id="discardActKey-btn" style="display:none;">인증키폐기</a>
						<a href="/portal/openapi/openApiActKeyIssPage.do" class="fr btn-m btns-color07 btn_AC">인증키발급</a>
					</div>
					<form id="actkey-discard-form" name="actkey-discard-form" method="post">
					<div class="board-list01 mt05">
						<table style="width: 100%">
							<caption>
								인증키발급 정보 목록표 : 인증키, 활용용도, 발급일, 호출건수, 사용여부 정보 제공
							</caption>
							<thead>
								<tr>
									<th class="title" scope="col">인증키</th>
									<th class="division" scope="col">활용용도</th>
									<th class="date" scope="col">발급일</th>
									<th class="counter" scope="col">호출건수</th>
									<th class="counter" scope="col">사용여부</th>
								</tr>
							</thead>
							<tbody id="actkey-list">
							</tbody>
						</table>
					</div>
					<div class="gray-box01 mt70">
						<h4 class="title0403">
							※ Open API 이용 제한에 대하여
						</h4>

						<p class="word-type03 mb30">
							발급 받은 인증키로 악의적으로 데이터를 호출하는 경우  이용제한이 있을 수 있습니다. 
							<br>정상 상태의 인증키는 최대 10개까지 발급받을 수 있습니다.
						</p>

						<ul class="ul-list04">
							<li>신청하신 인증키는 타인에게 양도할 수 없습니다.</li>
							<li>발급받은 인증키는 활용사례 별로 구분한 것으로 모든 Open API 에 활용 가능합니다.</li>
							<li>발급받은 인증키는 관리목적상 활용용도 별로 구분한 것으로 모든 Open API 에 활용 가능합니다.</li>
							<li>자세한 것은 Open API 사용방법을 참조하시기 바랍니다.</li>
						</ul>
					</div>
					</form>
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
<!-- // wrapper -->
</body>
</html>