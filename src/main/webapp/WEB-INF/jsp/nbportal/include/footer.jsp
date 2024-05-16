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
<%-- 하단 섹션 화면이다.                                                    		--%>
<%--                                                                        --%>
<%-- @author SoftOn                                                         --%>
<%-- @version 1.0 2018/02/01                                                --%>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>

<!-- footer -->
<footer>
	<div class="footer">
		<div class="footer-menulist">
			<ul class="clear">
				<li>
					<%-- <a href="<c:url value="/portal/intro/privatePolicyPage.do" />" class="point-privacy"></a> --%>
					<a href="<c:url value="http://www.nabo.go.kr/Sub/03Information/09_Contents.jsp" />" target="_blank" class="point-privacy" title="새창열림_개인정보처리방침">
						개인정보처리방침
					</a>
				</li>
				
				<li>
					<a href="<c:url value="/portal/intro/userAgreementPage.do" />">
						서비스이용약관
					</a>
				</li>
				<li>
					<a href="<c:url value="http://www.nabo.go.kr/Sub/03Information/10_Contents.jsp" />" target="_blank" title="새창열림_저작권정책">
						저작권정책
					</a>
				</li>
				<li class="line-none">
					<a href="<c:url value="http://www.nabo.go.kr/Sub/03Information/08_01_Contents.jsp" />" target="_blank" title="새창열림_오시는길">
						오시는길
					</a>
				</li>
			</ul>
			
		</div>

		<div class="footer-information">
			<address>
				©국회예산정책처, (07233)서울시 영등포구 의사당대로 1 | 대표전화 02-2070-3114 | 문의메일 w3@nabo.go.kr
			</address>
			<p class="copyrigyht">
				<span>COPYRIGHT</span>&copy; National Assembly Budget Office All Rights Reserved
			</p>
			<%--<a href="/images/soportal/common/wa.pdf" class="wa" target="_blank" title="새창열림_PDF 파일보기">
				<img src="/images/soportal/common/logo_wa.png" alt="(사)한국장애인단체총연합회 한국웹접근성인증평가원 웹 접근성 우수사이트 인증마크(WA인증마크)">
			</a>--%>
			<a href="http://www.wa.or.kr/board/list.asp?search=total&SearchString=%BF%AD%B8%B0%B1%B9%C8%B8&BoardID=0006" class="wa" target="_blank" title="새창열림_웹접근성 인증 확인화면">
				<img src="/images/soportal/common/logo_wa.png" alt="(사)한국장애인단체총연합회 한국웹접근성인증평가원 웹 접근성 우수사이트 인증마크(WA인증마크)">
			</a>
		</div>

		<!-- 상단으로 이동 
		<a href="#btn-top-go" class="btn-top-go">TOP</a>
		<a href="javascript:history.back()" class="btn-mobile-back">BACK</a>
		<!-- //이전페이지로 이동 -->

	</div>
</footer>
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