<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>

<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%-- @(#)siteMap.jsp 1.0 2019/08/28
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>

<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%-- 사이트맵	                    											--%>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>

<!DOCTYPE html>
<html lang="ko">
<head>
<%@ include file="/WEB-INF/jsp/portal/sect/head.jsp" %>
</head>
<body>
<!-- wrapper -->
<div class="wrapper" id="wrapper">
<%@ include file="/WEB-INF/jsp/portal/sect/headerOpen.jsp" %>
<%-- <%@ include file="/WEB-INF/jsp/nbportal/include/navigation.jsp" %> --%>

<!-- container -->
<section>
	<div class="container hide-pc-lnb" id="container">

    <!-- content -->
    <article>
		<div class="contents" id="contents">
        	<div class="contents-title-wrapper">
	            <h3>Open API 사이트맵<span class="arrow"></span></h3>
        	</div>
        
        <div class="contents-area">
		<!-- CMS 시작 -->

			<div class="sitemap-wrapper">
				<!-- 1 row -->
				<div class="sitemap-area">
					<div class="sitemap-box">
						<!-- Open API 소개 -->
						<dl>
							<c:forEach var="menu" items="${requestScope.menuLst }">
								<c:if test="${menu.id eq 'OP10000' }">
									<dt><a href="${getContextPath }${menu.url }">${menu.title }</a></dt>
								</c:if>
							</c:forEach>
							<c:forEach var="menu" items="${requestScope.menuLst }">
								<c:if test="${menu.parId eq 'OP10000' }">
									<dd><a href="${getContextPath }${menu.url }">${menu.title }</a></dd>
								</c:if>
							</c:forEach>
						</dl>
						<!-- Open API 목록 -->
						<dl>
							<c:forEach var="menu" items="${requestScope.menuLst }">
								<c:if test="${menu.id eq 'OP20000' }">
									<dt><a href="${getContextPath }${menu.url }">${menu.title }</a></dt>
								</c:if>
							</c:forEach>
							<c:forEach var="menu" items="${requestScope.menuLst }">
								<c:if test="${menu.parId eq 'OP20000' }">
									<dd><a href="${getContextPath }${menu.url }">${menu.title }</a></dd>
								</c:if>
							</c:forEach>
						</dl>
					</div>
					
					<div class="sitemap-box">
						<!-- 개발가이드 -->
						<dl>
							<c:forEach var="menu" items="${requestScope.menuLst }">
								<c:if test="${menu.id eq 'OP30000' }">
									<dt><a href="${getContextPath }${menu.url }">${menu.title }</a></dt>
								</c:if>
							</c:forEach>
							<c:forEach var="menu" items="${requestScope.menuLst }">
								<c:if test="${menu.parId eq 'OP30000' }">
									<dd><a href="${getContextPath }${menu.url }">${menu.title }</a></dd>
								</c:if>
							</c:forEach>
						</dl>
						<!-- 참여형 플랫폼 -->
						<dl>
							<c:forEach var="menu" items="${requestScope.menuLst }">
								<c:if test="${menu.id eq 'OP60000' }">
									<dt><a href="${getContextPath }${menu.url }">${menu.title }</a></dt>
								</c:if>
							</c:forEach>
							<c:forEach var="menu" items="${requestScope.menuLst }">
								<c:if test="${menu.parId eq 'OP60000'}">
									<dd><a href="${getContextPath }${menu.url }">${menu.title }</a></dd>
								</c:if>
								<c:if test="${(menu.parId ne menu.topId) and (menu.topId eq 'OP60000' and menu.viewYn ne 'N')}">
									<dd> - <a href="${getContextPath }${menu.url }">${menu.title }</a></dd>
								</c:if>
							</c:forEach>
						</dl>
						
					</div>
				</div>
				
				<!-- 2row -->
				<div class="sitemap-area">
					<div class="sitemap-box">
						<!-- 알림마당 -->
						<dl>
							<c:forEach var="menu" items="${requestScope.menuLst }">
								<c:if test="${menu.id eq 'OP50000' }">
									<dt><a href="${getContextPath }${menu.url }">${menu.title }</a></dt>
								</c:if>
							</c:forEach>
							<c:forEach var="menu" items="${requestScope.menuLst }">
								<c:if test="${menu.parId eq 'OP50000' }">
									<dd><a href="${getContextPath }${menu.url }">${menu.title }</a></dd>
								</c:if>
							</c:forEach>
						</dl>
						<!-- 인증키 발급내역 -->
						<dl>
							<c:forEach var="menu" items="${requestScope.menuLst }">
								<c:if test="${menu.id eq 'OP40000' }">
									<dt><a href="${getContextPath }${menu.url }">${menu.title }</a></dt>
								</c:if>
							</c:forEach>
							<c:forEach var="menu" items="${requestScope.menuLst }">
								<c:if test="${menu.parId eq 'OP40000' }">
									<dd><a href="${getContextPath }${menu.url }">${menu.title }</a></dd>
								</c:if>
							</c:forEach>
						</dl>
					</div>
				</div>
				
				<p class="image">
					<img src="<c:url value="/images/bg_sitemap.jpg" />" alt="Statistics">
				</p>

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
</body>
</html>
