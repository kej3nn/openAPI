<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%-- @(#)lnb.jsp 1.0 2018/02/01                                             --%>
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
<%-- 좌측 메뉴 섹션 화면이다.                                               		--%>
<%--                                                                        --%>
<%-- @author SoftOn                                                  		--%>
<%-- @version 1.0 2018/02/01                                                --%>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
    <!-- lnb -->
	<nav>
		<div class="lnb">
				
		<c:choose>
			<c:when test="${empty requestScope.menu.lvl1MenuPath && not empty directType }"> 
				<h2>재정·경제통계</h2>
				<ul>
		            <li><a href="<c:url value="/portal/stat/directStatPage.do" />" class="menu_1">간략조회</a></li>
		            <li><a href="<c:url value="/portal/stat/easyStatPage.do" />" class="menu_2">상세분석</a></li>
		            <li><a href="<c:url value="/portal/stat/multiStatPage.do" />" class="menu_3">복수통계분석</a></li>
				</ul>
			</c:when>
			<c:otherwise>
				<h2>
					<c:out value="${requestScope.menu.lvl1MenuPath}" />
				</h2>
				<ul>
					<c:forEach items="${requestScope.menus}" var="menu" varStatus="status">
		            <c:choose>
		            <c:when test="${pageScope.menu.menuNm == requestScope.menu.lvl2MenuPath}">
		            <c:choose>
		            <c:when test="${pageScope.menu.menuUrl != '#'}">
		            <li><a href="<c:url value="${pageScope.menu.menuUrl}" />" class="menu_${status.count} selected"><c:out value="${pageScope.menu.menuNm}" /></a></li>
		            </c:when>
		            <c:otherwise>
		            <li><a href="javascript:alert('서비스 준비중 입니다.');" class="menu_${status.count} selected"><c:out value="${pageScope.menu.menuNm}" /></a></li>
		            </c:otherwise>
		            </c:choose>
		            </c:when>
		            <c:otherwise>
		            <c:choose>
		            <c:when test="${pageScope.menu.menuUrl != '#'}">
		            <li><a href="<c:url value="${pageScope.menu.menuUrl}" />" class="menu_${status.count}"><c:out value="${pageScope.menu.menuNm}" /></a></li>
		            </c:when>
		            <c:otherwise>
		            <li><a href="javascript:alert('서비스 준비중 입니다.');" class="menu_${status.count}"><c:out value="${pageScope.menu.menuNm}" /></a></li>
		            </c:otherwise>
		            </c:choose>
		            </c:otherwise>
		            </c:choose>
		            </c:forEach>
					
				</ul>
			</c:otherwise>
		</c:choose>
		</div>

	</nav>
	<!-- //lnb -->