<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%-- @(#)footer.jsp 1.0 2018/02/01                                          --%>
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
<%-- 하단 섹션 화면이다(영문).                                                    		--%>
<%--                                                                        --%>
<%-- @author SoftOn                                                         --%>
<%-- @version 1.0 2018/02/01                                                --%>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>

<!-- footer -->
<footer>
	<div class="footer">
		

		<div class="footer-information">
			<address>
				BIFC 40, Munhyeongeumyung-ro, Nam-gu, Busan, Korea.
			</address>


			<p class="copyrigyht">
				<span>COPYRIGHT</span>&copy;KOREA HOUSING FINANCE CORPORATION All Rights Reserved
			</p>
		</div>

		<!-- 상단으로 이동 -->
		<a href="#btn-top-go" class="btn-top-go">
			TOP
		</a>
		<!-- //상단으로 이동 -->

		<!-- 이전페이지로 이동 -->
		<a href="javascript:history.back()" class="btn-mobile-back">
			BACK
		</a>
		<!-- //이전페이지로 이동 -->
	</div>
</footer>
<!-- //footer -->
<form id="global-request-form" name="global-request-form" method="post" action="<c:out value="${requestScope.action}" /><c:if test="${!empty requestScope.queryString}">?<c:out value="${requestScope.queryString}" escapeXml="false" /></c:if>">
    <c:forEach items="${paramValues}" var="parameter">
    <c:set var="key" value="${parameter.key}" />
    <c:set var="add" value="true" />
    <c:forEach items="${requestScope.queryNames}" var="name">
    <c:if test="${key == name}">
    <c:set var="add" value="false" />
    </c:if>
    </c:forEach>
    <c:if test="${key == 'ACTION' || key == 'userPw'}">
    <c:set var="add" value="false" />
    </c:if>
    <c:if test="${add}">
    <c:forEach items="${parameter.value}" var="value">
    <input type="hidden" name="${key}" value="${fn:escapeXml(value)}" />
    </c:forEach>
    </c:if>
    </c:forEach>
</form>
<iframe id="global-process-iframe" name="global-process-iframe"  title="프로그램 처리 영역" height="0" style="width:100%; display:none;"></iframe>
<!-- //footer -->