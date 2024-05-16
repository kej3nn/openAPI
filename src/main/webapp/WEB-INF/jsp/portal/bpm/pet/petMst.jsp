<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%-- 의정활동별 공개 - 청원
<%-- 
<%-- @author JHKIM
<%-- @version 1.0 2019/11/05
<%--
<%-- petAssmMemb	국회의원 청원
<%-- petAprvNa		국민동의 청원
<%--
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<!DOCTYPE html>
<html lang="ko">
<head>
<%@ include file="/WEB-INF/jsp/portal/sect/head.jsp" %>
<c:set var="leftBpmPet" value="Y"></c:set>
</head>
<body>

<!-- header -->
<%@ include file="/WEB-INF/jsp/portal/sect/header.jsp" %>
<!-- //header -->

<!-- wrapper -->
<div class="wrapper" id="wrapper">

<!-- container -->
<section>
	<div class="container active_left" id="container">
				
	<!-- LEFT -->
	<%@ include file="/WEB-INF/jsp/portal/bpm/lnb.jsp" %>
	<!-- //LEFT -->
	
    <!-- content -->
    <article>
		<div class="contents" id="contents">
			<div class="contents-title-wrapper">
				<h3 class=""><c:out value="${requestScope.menu.lvl2MenuPath}" /><span class="arrow"></span></h3>
	        </div>
			<div class="layout_flex_100">
				
				<!-- RIGHT -->
				<div class="assemblyman_content pr0">
				
					<div>
						<div class="tab_B mt30 mnone" id="tab-btn-sect">
							<a href="javascript:;" class="on">의원소개청원</a>
							<a href="javascript:;">국민동의청원</a>
						</div>
						
						<div class="tab_B_select">
							<select id="tab-select-sect" title="메뉴 선택">
								<option>국회의원청원</option>
								<option>국민동의청원</option>
							</select>
						</div>
						
						<div id="tab-cont-sect">
							<div><%@ include file="/WEB-INF/jsp/portal/bpm/pet/petAssmMemb.jsp" %></div>
							<div style="display: none;"><%@ include file="/WEB-INF/jsp/portal/bpm/pet/petAprvNa.jsp" %></div>
						</div>
					</div>	
					
				</div>
				<!-- //RIGHT (content) -->
			</div>
		</div>
	</article>
	<!-- //contents  -->
	
	</div>
</section>
<!-- //container -->
</div>
	
<!-- footer -->
<%@ include file="/WEB-INF/jsp/portal/sect/footer.jsp" %>
<!-- //footer -->	
	
<script type="text/javascript" src="<c:url value="/js/portal/bpm/pet/petMst.js" />"></script>
</body>
</html>