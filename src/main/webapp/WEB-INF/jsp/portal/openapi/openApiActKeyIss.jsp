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
	            <h3>인증키 발급<span class="arrow"></span></h3>
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
				
				<!-- 인증키 발급 요청 레이아웃 -->
				<div id="content_1" class="open-api-information-wrapper children_content">
					<h4 class="title0403">Open API 인증키 이용안내 </h4>
					<div class="open-api-information-area">
						<!-- 내용 자료 제공 시 추가 수정 작업 예정 -->
						[Open API 서비스의 제한]<br />
						① 국회사무처는 특정 Open API 서비스의 범위를 제한하거나 별도의 이용가능 시간 또는 이용가능 횟수를 지정할 수 있으며, 관련 법률 개정으로 인해 Open API 서비스 제공 대상이 변경되어 더 이상 활용을 할 수 없을 경우, 서비스 활용으로 인해 제공기관의 업무에 지장을 초래하거나 인프라 성능 등의 이유로 서비스 제공 상의 성능 문제가 발생한 경우 활용을 제한할 수 있습니다.<br/>
						② 국회사무처는 회원이 Open API 서비스를 이용함에 있어 법령을 위반하거나 약관 또는 서비스 이용기준 등을 위반한 경우, 제공된 정보를 임의로 위조·변조하여 저작권을 위반하는 경우에는 제 1항의 규정에도 불구하고 즉시 인증 Key의 이용을 정지하는 등의 조치를 취할 수 있습니다.<br/><br/>
						
						[인증 Key의 이용 및 관리]<br/>
						① 회원은 발급 받은 인증 Key를 타인에게 제공·공개하거나 공유할 수 없으며, 발급 받은 회원 본인에 한하여 이를 사용할 수 있습니다.<br/>
						② 국회사무처는 인증 Key를 발급함에 있어 이용기간을 지정할 수 있습니다. <br/>  
						
					</div>
					<!-- 인증키 발급 요청 레이아웃 -->
					<form id="actkey-insert-form" name="actkey-insert-form" method="post" enctype="multipart/form-data">
						<fieldset>
							<legend class="blind">
								인증키발급요청 양식
							</legend>
							<div class="table-type02">
								<table>
									<caption>Open API 인증키 발급요청 입력 양식 : 활용용도, 내용 입력 양식 제공</caption>
									<colgroup>
										<col width="30%">
										<col width="">
									</colgroup>
									<tbody>
										<tr>
											<th scope="row">
												<label for="use">활용용도</label>
											</th>
											<td class="left line-none">
												<!-- <select id="selected01">
													<option value="">
														선택하세요
													</option>
												</select> -->
												<input type="text" id="use" name="useNm" autocomplete="on"  style="width:100%" title="활용용도"/>
											</td>
										</tr>
	
										<tr>
											<th scope="row">
												<label for="contents">내용</label>
											</th>
											<td class="left line-none">
												<textarea id="contents" name="useCont" cols="50" rows="5" title="내용"></textarea>
											</td>
										</tr>
									</tbody>
								</table>
							</div>
							<div class="btn-center">
								<button type="submit" id="create-actKey-btn" class="btn-b btns-color06" title="인증키 발급요청">인증키 발급요청</button>
							</div>
						</fieldset>
					</form>
				</div>
				<!--// 인증키 발급 요청 레이아웃 -->
				
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
<!-- // wrapper -->
<script type="text/javascript" src="<c:url value="/js/portal/openapi/openApiSns.js" />"></script>
</body>
</html>