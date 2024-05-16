<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%-- @(#)navigation.jsp 1.0 2018/02/01                                      --%>
<%--                                                                        --%>
<%-- COPYRIGHT (C) 2013 WISEITECH CO., LTD. ALL RIGHTS RESERVED.            --%>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>

<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%-- 네비게이션 섹션 화면이다.                                              		--%>
<%--                                                                        --%>
<%-- @author SoftOn                                                         --%>
<%-- @version 1.0 2018/02/01                                                --%>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<!-- location -->
<div class="contents-navigation-area">
	<div class="contents-navigation-box">
		<p class="contents-navigation">
			<span class="icon-home">
				Home
			</span>
			<span class="icon-gt">
				&gt;
			</span>

			<c:choose>
	            <c:when test="${empty requestScope.menu.lvl1MenuPath}">
				<span class="location">재정·경제통계</span>
				<span class="icon-gt">&gt;</span>
				<c:choose>
					<c:when test="${directType == 'directType'}">
					<strong>간략조회</strong>
					</c:when>
					<c:otherwise>
					<strong>상세분석</strong>	
					</c:otherwise>
				</c:choose>
				</c:when>
				
	            <c:when test="${empty requestScope.menu.lvl2MenuPath}">
				<strong>
					<c:out value="${requestScope.menu.lvl1MenuPath}" />
				</strong>
				</c:when>

				<c:otherwise>
				<span class="location">
					<c:out value="${requestScope.menu.lvl1MenuPath}" />
				</span>
				<span class="icon-gt">
					&gt;
				</span>
				<strong>
					<c:out value="${requestScope.menu.lvl2MenuPath}" />
				</strong>
				
				</c:otherwise>
			</c:choose>


		</p>
		<!-- sub function list -->
		<div class="sub-function-list">
			<!-- button type="button" class="btn-print" title="프린트" onclick="printWin(this.href)">
				프린트
			</button-->
			<button type="button" class="btn-font-viewer" aria-label="폰트 선명하게">
			</button>
			<button type="button" class="btn-font-bigger" aria-label="폰트 크기 증가" onclick='zoomOut(); return false;'>
			</button>
			<button type="button" class="btn-font-reset" aria-label="폰트 크기 리셋" onclick='zoomReset(); return false;'>
			</button>
			<button type="button" class="btn-font-small" aria-label="폰트 크기 감소" onclick='zoomIn(); return false;'>
			</button>
		</div>


		<!-- //sub function list -->
	</div>
</div>
