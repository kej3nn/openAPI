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
	<nav>
		<div class="lnb">
			<h2>참여형 플랫폼</h2>
			<ul>
				<li><span><a href="/portal/bbs/guide/searchBulletinPage.do" class="">활용가이드</a></span></li>
				<li><span><a href="/portal/bbs/develop/searchBulletinPage.do" class="">개발자 공간</a></span>
					<ul>
						<li><span><a href="/portal/bbs/develop/searchBulletinPage.do" class="">개발자커뮤니티</a></span></li>
						<li><span><a href="/portal/bbs/qnaapi/searchBulletinPage.do" class="">관리자문의</a></span></li>
						<li><span><a href="/portal/bbs/faqapi/searchBulletinPage.do" class="">FAQ</a></span></li>
						<!-- <li><span><a href="/portal/bbs/gallery/searchBulletinPage.do" class="">활용 사례</a></span></li> -->
					</ul>
				</li>
			</ul>
		</div>
	</nav>
	<!-- //leftmenu -->
	
    <!-- content -->
    <article>
		<div class="contents" id="contents">   
	        <div class="layout_flex_100">
	        	
	        	<!-- SUB header -->
	        	<div class="platform_header">
	        		<h2>참여형 플랫폼</h2>
	        		<div>
		        		<span>
		        			국회정보를 다양한 분야에 활용할 수 있습니다.<br>
		        			데이터 활용에 도움을 드리기 위한 커뮤니티 공간입니다. 
		        		</span>
	        		</div>
	        	</div>
	        	<!-- //SUB header -->
	        	
	        	<!-- 활용가이드 리스트 -->
	        	<div class="platform_guide">
		        	<div id="guideImg">
						<c:forEach var="guide" items="${guideList}" varStatus="status">
		        		<li class="pg_img pg01">
			        		<em>활용가이드</em>
			        		<strong>${guide.BBS_TIT}</strong>
			        		<span>${guide.ANS_CONT }</span>
			        		<div>
			        			<a href="/portal/bbs/guide/selectBulletinPage.do?page=1&rows=10&bbsCd=GUIDE&listSubCd=&searchType=&searchWord=&seq=${guide.SEQ}&noticeYn=N" class="btn_guide_detail">자세히보기</a>
			        		</div>
		        		</li>
						</c:forEach>
	        		</div>
	        		<ul class="platform_btn">
	        			<li><a href="javascript:;" class="pb_prev">이전</a></li>
	        			<li><a href="javascript:;" class="pb_next">다음</a></li>
	        		</ul>
	        	</div>
	        	<!-- //활용가이드 리스트 -->
	        	
	        	<!-- 인증키 발급 절차안내 -->
	        	<div class="platform_info">
	        		<div class="platform_info_header">
		        		<div class="platform_info_txt">
		        			<strong>인증키 발급</strong>
		        			<span>신청절차</span>
		        		</div>
		        		<div class="platform_info_desc">
		        			열린국회정보 Open API에서 제공되는 데이터를 활용하기 위해서는 마이페이지 <em>[인증키발급]</em> 메뉴에서 인증키를 발급 받으셔야 합니다.
		        		</div>
	        		</div>
	        		<div class="platform_keylist">
	        			<ul>
	        				<li><span class="pk01">로그인</span></li>
	        				<li><span class="pk02">인증키 발급 요청</span></li>
	        				<li><span class="pk03">인증키 발급내역 확인</span></li>
	        			</ul>
	        			<div>
	        				<span>
	        					인증키는 최대 10개까지 발급받을 수 있으며, 발급 받은 인증키로 악의적으로 데이터를 <br>
	        					호출하는 경우 이용제한을 할 수 있습니다.
	        				</span>
	        			</div>
	        		</div>
	        	</div>
	        	<!-- //인증키 발급 절차안내 -->
	        	
			 </div> 
		</div>
	</article>
	<!-- //contents  -->

	</div>
</section>       
		        
</script>		
<%@ include file="/WEB-INF/jsp/portal/sect/footer.jsp" %>
</div>
<script type="text/javascript" src="<c:url value="/js/portal/openapi/galleryMain.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/portal/openapi/openApiSns.js" />"></script>
</body>
</html>