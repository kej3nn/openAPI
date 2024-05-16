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
<%@ include file="/WEB-INF/jsp/portal/sect/header.jsp" %>
<%-- <%@ include file="/WEB-INF/jsp/nbportal/include/navigation.jsp" %> --%>

<!-- container -->
<section>
	<div class="container hide-pc-lnb" id="container">

    <!-- content -->
    <article>
		<div class="contents" id="contents">
        	<div class="contents-title-wrapper">
	            <h3>사이트맵<span class="arrow"></span></h3>
        	</div>
        
        <div class="contents-area">
		<!-- CMS 시작 -->

			<div class="sitemap-wrapper">
				<!-- 1 row -->
				<div class="sitemap-area">
					<div class="sitemap-box">
						<!-- 국회의원 -->
						<dl>
							<c:forEach var="menu" items="${requestScope.menuLst }">
								<c:if test="${menu.id eq 'NA10000' }">
									<dt><a href="${getContextPath }${menu.url }">${menu.title }</a></dt>
								</c:if>
							</c:forEach>
							<c:forEach var="menu" items="${requestScope.menuLst }">
								<c:if test="${menu.parId eq 'NA10000' }">
									<dd><a href="${getContextPath }${menu.url }">${menu.title }</a></dd>
								</c:if>
							</c:forEach>
						</dl>
						<!-- 의정활동별 -->
						<dl>
							<c:forEach var="menu" items="${requestScope.menuLst }">
								<c:if test="${menu.id eq 'NA40000' }">
									<dt><a href="${getContextPath }${menu.url }">${menu.title }</a></dt>
								</c:if>
							</c:forEach>
							<c:forEach var="menu" items="${requestScope.menuLst }">
								<c:if test="${menu.parId eq 'NA40000' }">
									<dd><a href="${getContextPath }${menu.url }">${menu.title }</a></dd>
								</c:if>
							</c:forEach>
						</dl>
					</div>
					
					<div class="sitemap-box">
						<!-- 분야별 -->
						<dl>
							<c:forEach var="menu" items="${requestScope.menuLst }">
								<c:if test="${menu.id eq 'NA20000' }">
									<dt><a href="${getContextPath }${menu.url }">${menu.title }</a></dt>
								</c:if>
							</c:forEach>
							<c:forEach var="menu" items="${requestScope.menuLst }">
								<c:if test="${menu.parId eq 'NA20000' }">
									<dd><a href="${getContextPath }${menu.url }">${menu.title }</a></dd>
								</c:if>
							</c:forEach>
						</dl>
						<!-- 보고서 -->
						<dl>
							<c:forEach var="menu" items="${requestScope.menuLst }">
								<c:if test="${menu.id eq 'NA50000' }">
									<dt><a href="${getContextPath }${menu.url }">${menu.title }</a></dt>
								</c:if>
							</c:forEach>
							<c:forEach var="menu" items="${requestScope.menuLst }">
								<c:if test="${menu.parId eq 'NA50000' }">
									<dd><a href="${getContextPath }${menu.url }">${menu.title }</a></dd>
								</c:if>
							</c:forEach>
						</dl>
						<!-- 지원조직 -->
						<%-- 사용안함 2019.01.08
						<dl>
							<c:forEach var="menu" items="${requestScope.menuLst }">
								<c:if test="${menu.id eq 'NA30000' }">
									<dt><a href="${getContextPath }${menu.url }">${menu.title }</a></dt>
								</c:if>
							</c:forEach>
							<c:forEach var="menu" items="${requestScope.menuLst }">
								<c:if test="${menu.parId eq 'NA30000' }">
									<dd><a href="${getContextPath }${menu.url }">${menu.title }</a></dd>
								</c:if>
							</c:forEach>
						</dl> --%>
					</div>
				</div>
				
				<!-- 2row -->
				<div class="sitemap-area">
					<div class="sitemap-box">
						<!-- 정보공개청구 -->
						<dl>
							<c:forEach var="menu" items="${requestScope.menuLst }">
								<c:if test="${menu.id eq 'EX10000' }">
									<dt><a href="${getContextPath }${menu.url }">${menu.title }</a></dt>
								</c:if>
							</c:forEach>
							<c:forEach var="menu" items="${requestScope.menuLst }">
								<c:if test="${menu.parId eq 'EX10000' }">
									<dd><a href="${getContextPath }${menu.url }">${menu.title }</a></dd>
								</c:if>
							</c:forEach>
						</dl>
						<!-- 정보나침반 -->
						<dl>
							<c:forEach var="menu" items="${requestScope.menuLst }">
								<c:if test="${menu.id eq 'NO20000' }">
									<dt><a href="${getContextPath }${menu.url }">${menu.title }</a></dt>
								</c:if>
							</c:forEach>
							<c:forEach var="menu" items="${requestScope.menuLst }">
								<c:if test="${menu.parId eq 'NO20000' }">
									<dd><a href="${getContextPath }${menu.url }">${menu.title }</a></dd>
								</c:if>
							</c:forEach>
						</dl>
					</div>
					<div class="sitemap-box">
						<!-- 테마정보공개 -->
						<dl>
							<c:forEach var="menu" items="${requestScope.menuLst }">
								<c:if test="${menu.id eq 'NO30000' }">
									<dt><a href="${getContextPath }${menu.url }">${menu.title }</a></dt>
								</c:if>
							</c:forEach>
							<c:forEach var="menu" items="${requestScope.menuLst }">
								<c:if test="${menu.parId eq 'NO30000' }">
									<dd><a href="${getContextPath }${menu.url }">${menu.title }</a></dd>
								</c:if>
							</c:forEach>
						</dl>
						<!-- 알림마당 -->
						<dl>
							<c:forEach var="menu" items="${requestScope.menuLst }">
								<c:if test="${menu.id eq 'NO40000' }">
									<dt><a href="${getContextPath }${menu.url }">${menu.title }</a></dt>
								</c:if>
							</c:forEach>
							<c:forEach var="menu" items="${requestScope.menuLst }">
								<c:if test="${menu.parId eq 'NO40000' }">
									<dd><a href="${getContextPath }${menu.url }">${menu.title }</a></dd>
								</c:if>
							</c:forEach>
						</dl>
					</div>
				</div>
				
				<!-- 3row -->
				<div class="sitemap-area">
					<div class="sitemap-box">
						<!-- 서비스소개 -->
						<dl>
							<c:forEach var="menu" items="${requestScope.menuLst }">
								<c:if test="${menu.id eq 'NO50000' }">
									<dt><a href="${getContextPath }${menu.url }">${menu.title }</a></dt>
								</c:if>
							</c:forEach>
							<c:forEach var="menu" items="${requestScope.menuLst }">
								<c:if test="${menu.parId eq 'NO50000' }">
									<dd><a href="${getContextPath }${menu.url }">${menu.title }</a></dd>
								</c:if>
							</c:forEach>
						</dl>
						<!-- 마이페이지 -->
						<dl>
							<c:forEach var="menu" items="${requestScope.menuLst }">
								<c:if test="${menu.id eq 'NO60000' }">
									<dt><a href="${getContextPath }${menu.url }">${menu.title }</a></dt>
								</c:if>
							</c:forEach>
							<c:forEach var="menu" items="${requestScope.menuLst }">
								<c:if test="${menu.parId eq 'NO60000' }">
									<dd><a href="${getContextPath }${menu.url }">${menu.title }</a></dd>
								</c:if>
							</c:forEach>
						</dl>
					</div>
					<div class="sitemap-box">
						<!-- 통합검색 -->
						<dl>
							<dt><a href="javascript: gfn_showTotalsch();">통합검색</a></dt>
						</dl>
					</div>
				</div>
				
				<p class="image">
					<img src="<c:url value="/images/bg_sitemap.jpg" />" alt="">
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
