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
	            <h3>Open API 테스트<span class="arrow"></span></h3>
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
				
				<!-- Open API 검색 레이아웃 -->
        		<div id="content_2" class="board-area children_content">
        			<div class="contents-box mt10 mb10">
						<div class="gray-box01 type02 mb0">
							<!-- <div class="statement-download-wrapper type02 title mt0">
								<label for="API_search">API 검색</label>
								<input type="search" id="API_search" name="infNm" value="" placeholder="검색어를 입력하세요.">
								<button type="button" id="api-search-btn" class="btn-search">검색</button>
							</div> -->

							<div class="statement-download-wrapper type02 title">
								<label for="APIname">API 명</label>
								<select id="APIname" title="openAPI 선택">
									<option value="">API를 선택하세요.</option>
								</select>
								<button type="button" id="api-test-btn" class="btn-search" title="출력">출력</button>
							</div>

							<!-- <p class="word-statement-download">
								※ 자체 제공하는 API 만 출력이 가능합니다.
							</p> -->
						</div>
					</div>

					<h4 class="title0403">
						Open API 결과	
					</h4>
					<div class="table-type02">
						<table>
							<caption>Open API 결과 정보 표: 요청주소, 내용정보 제공</caption>
							<colgroup>
								<col width="30%">
								<col width="">
							</colgroup>
								<tbody>
									<tr>
										<th scope="row">요청주소</th>
										<td class="left line-none">
											<strong id="api-ep-url" class="point-color03"></strong>
										</td>
									</tr>

									<tr>
										<th scope="row">
											내용
										</th>
										<td class="left line-none">
											<pre class="pre-box" id="apiSampleTest"></pre>
										</td>
									</tr>
								</tbody>
							</table>
						</div>
											
				</div>
				<!-- //Open API 검색 레이아웃 -->
				
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