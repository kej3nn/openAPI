<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%-- 국회의원 메인 화면				                    	
<%-- 
<%-- @author JHKIM
<%-- @version 1.0 2019/10/16
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<!DOCTYPE html>
<html lang="ko">
<head>
<%@ include file="/WEB-INF/jsp/portal/sect/head.jsp" %>
<c:set var="leftMember" value="Y"></c:set>
</head>
<body>

<c:if test="${empty meta }">
<script>
alert("국회의원 정보가 없습니다.\n메인페이지로 이동합니다.");
location.href = com.wise.help.url("/portal/mainPage.do");
</script>
</c:if>

<!-- wrapper -->
<div class="wrapper" id="wrapper">

<!-- container -->
<section>
	<div class="container hide-pc-lnb" id="container">
	
    <!-- content -->
    <article>
		<div class="contents" id="contents">
			<div class="layout_flex_100">
				
				<!-- 국회의원 LEFT -->
				<%@ include file="/WEB-INF/jsp/portal/assm/sect/lnb.jsp" %>
				<!-- //국회의원 LEFT -->
				
				<!-- 국회의원 RIGHT -->
				<div class="assemblyman_content">
					<!-- 개인신상정보 -->
					<%@ include file="/WEB-INF/jsp/portal/assm/sect/meta.jsp" %>
					<!-- //개인신상정보 -->
				
					<!-- 탭 -->
					<%@ include file="/WEB-INF/jsp/portal/assm/sect/tab.jsp" %>
					<!-- //탭 -->
					
					<!-- 내용 -->
					<div id="tab-cont">
						<iframe id="ifm_tabLawm" name="ifm_tabLawm" title="입법활동,국회발언,정책자료&보고서,의원일정,의원실알림에 대한 콘텐츠" src="/portal/assm/lawm/assmLawmPage.do" frameborder="0" scrolling="no" marginwidth="0" marginheight="0" width="100%" height="500px;" onload="iframeResize('ifm_tabLawm')"></iframe>
					</div>
					<!-- //내용 -->
					
				</div>
				<!-- //국회의원 RIGHT (content) -->
			</div>
		
		</div>
	</article>
	<!-- //contents  -->
	
	</div>
</section>
<!-- //container -->
</div>
<script type="text/javascript" src="<c:url value="/js/portal/assm/member.js" />"></script>
</body>
</html>