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
	            <h3>인증키 이용내역<span class="arrow"></span></h3>
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
				
				<!-- 인증키 이용 내역 -->
				<div id="content_3" class="board-area children_content">
					<div class="contents-box mt10 mb10">
						<div class="gray-box01 mb0">
							<p class="word-type02">
								※ 1개월 이내에 인증키 호출 내역을 보실 수 있습니다.
							</p>

							<div class="statement-download-wrapper type02">
								<label class="blind" for="actKeySelect">인증키 선택</label>
								<select id="actKeySelect" title="인증키 선택">
									<option value="">인증키를 선택하세요.</option>
								</select>
								<button type="button" id="act-key-select-btn" class="btn-search" title="검색">
									검색
								</button>
							</div>
						</div>
					</div>
					<div class="board-list01 mt05">
						<table style="width: 100%">
							<caption>인증키 이용 내역 정보 목록표 : 이용일자, 호출(회), 데이터(건), 평균 응답속도(초), 데이터량(KB) 정보 제공</caption>
							<colgroup>
								<col style="width: 20%" />
								<col style="width: 20%" />
								<col style="width: 20%" />
								<col style="width: 20%" />
								<col style="width: 20%" />
							</colgroup>
							<thead class="mobile-show">
								<tr>
									<th scope="col">이용일자</th>
									<th scope="col">호출(회)</th>
									<th scope="col">데이터(건)</th>
									<th scope="col">평균 응답속도(초)</th>
									<th scope="col">데이터량(Kb)</th>
								</tr>
							</thead>
							<tbody  id="actkey-use-list">
								<tr><td colspan="5">해당 자료가 없습니다.</td></tr>
							</tbody>
						</table>
					</div>	
				</div>
				<!-- // 인증키 이용 내역 -->
				
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