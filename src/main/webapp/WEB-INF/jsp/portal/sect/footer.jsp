<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%-- @(#)footer.jsp 1.0 2019/08/12                                          --%>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>

<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%-- 하단 섹션 화면이다.                                                    --%>
<%--                                                                        --%>
<%-- @author JHKIM                                                         --%>
<%-- @version 1.0 2019/08/12                                                --%>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
	<!-- footer -->
	<footer>
		<div class="footer">
			<div class="footer-menulist">
				<div>
					<ul class="clear">
						<li><a href="/portal/policy/privatePolicyPage.do" class="point-privacy" title="개인정보처리방침 바로가기">개인정보처리방침</a></li>
						<li><a href="/portal/policy/userAgreementPage.do" title="열린국회정보 이용약관 바로가기">열린국회정보 이용약관</a></li>
						<li><a href="/portal/policy/openUserAgreementPage.do" title="Open API 이용약관 바로가기">Open API 이용약관</a></li>
						<li class="line-none"><a href="/portal/policy/copyRightPage.do" title="저작권 정책 바로가기">저작권 정책</a></li>
						<!-- 2023-12. 테스트 위해 임시 설정 ::start  -->
						<li class="line-none"><a href="javascript::" onclick="javascript: gfn_moveAdmin();">관리자_dev</a></li>
						<!--	 2023-12. 테스트 위해 임시 설정 ::end -->
							
						<c:if test="${!empty sessionScope.portalUserCd && !empty sessionScope.portalDeptCode }">
							<c:if test="${sessionScope.PortalIsAdmin eq 'Y' }">
							<li class="line-none"><a href="javascript::" onclick="javascript: gfn_moveAdmin();">관리자</a></li>
							</c:if>
						</c:if>
						
					</ul>
					<ol>
						<li><a href="https://www.facebook.com/NationalAssemblyROK" target="new" title="새창열림 국회 facebook"><img src="/images/btn_footer_facebook.gif" alt="국회 facebook"></a></li>
						<li><a href="https://www.youtube.com/channel/UCsWa6xl7KxOolVhROUJ4Ghw" title="새창열림 국회 youtube" target="new"><img src="/images/btn_footer_youtube.gif" alt="국회 youtube"></a></li>
						<li><a href="https://www.instagram.com/theassembly_kr/" title="새창열림 국회 인스타그램" target="new"><img src="/images/btn_footer_instagram.gif" alt="국회 인스타그램"></a></li>
						<li><a href="https://twitter.com/news_NA" title="새창열림 국회 twitter" target="new"><img src="/images/btn_footer_twitter.gif" alt="국회 twitter"></a></li>
					</ol>	
				</div>			
			</div>
	
			<div class="footer-information">
				<address>서울특별시 영등포구 의사당대로 1 (여의도동) 07233</address>
				<p class="callcenter-information"> 문의전화 : 02-6788-3853  홈페이지 문의 : webmaster@assembly.go.kr</p>
				<p class="copyrigyht">
					<span>COPYRIGHT</span>©National Assembly. All Rights Reserved.
				</p>
				<%--<a href="/images/wa.pdf" class="wa" target="_blank" title="새창열림 웹접근성 품질인증서 확인"><img src="/images/logo_wa.png" alt="WEB ACCESSIBILITY"></a>--%>
				<a href="http://www.wa.or.kr/board/list.asp?search=total&SearchString=%BF%AD%B8%B0%B1%B9%C8%B8&BoardID=0006" class="wa" target="_blank" title="새창열림 웹접근성 확인"><img src="/images/logo_wa.png" alt="WEB ACCESSIBILITY"></a>
			</div>
			<a href="javascript:;" class="btn-top-go">TOP</a>
		</div>
	</footer>
	<!-- //footer -->
	<form id="global-request-form" name="global-request-form" method="post" action="<c:out value="${requestScope.action}" /><c:if test="${!empty requestScope.queryString}">?<c:out value="${requestScope.queryString}" /></c:if>">
	    <c:forEach items="${paramValues}" var="parameter">
	    <c:set var="key" value="${parameter.key}" />
	    <c:set var="add" value="true" />
		    <c:forEach items="${requestScope.queryNames}" var="name">
		    <c:if test="${key == name}">
		    <c:set var="add" value="false" />
		    </c:if>
		    </c:forEach>
		    
		    <c:if test="${key == 'ACTION' || key == 'userPw' || key == 'memberPw'}">
		    <c:set var="add" value="false" />
		    </c:if>
		    <c:if test="${add}">
			    <c:forEach items="${parameter.value}" var="value">
			    <input type="hidden" name="<c:out value="${key}"/>" value="<c:out value="${fn:escapeXml(value)}"/>" />
			    </c:forEach>
		    </c:if>
	    </c:forEach>
	</form>
	<iframe id="global-process-iframe" name="global-process-iframe"  title="프로그램 처리 영역" height="0" style="width:100%; display:none;"></iframe>
	<div id="loadingCircle" style="position:fixed; top:0px; left:0px; width:100%; height: 100%; z-index:9999999999; display:none;">
		<div style="position:relative; top:50%; left:50%; margin: -77px 0 0 -77px;z-index:10;"><img src="<c:url value="/images/soportal/desktop/ajax-loader.gif"/>" alt="loading"></div>
		<div class="bgshadow"></div>
	</div>
	<form id="adminLoginForm" method="post" action="/admin/user/loginProc.do" target="global-process-iframe"></form>
	
	<c:if test="${fn:indexOf(requestScope.uri, '/portal/bbs/qna01/insertBulletinPage.do') >= 0}">
		<%-- <%@ include file="/webfilter/inc/initCheckWebfilter.jsp"%> --%>
	</c:if>
	<c:if test="${fn:indexOf(requestScope.uri, '/portal/bbs/qna01/updateBulletinPage.do') >= 0}">
		<%-- <%@ include file="/webfilter/inc/initCheckWebfilter.jsp"%> --%>
	</c:if>
	<c:if test="${fn:indexOf(requestScope.uri, '/portal/myPage/') >= 0}">
		<%-- <%@ include file="/webfilter/inc/initCheckWebfilter.jsp"%> --%>
	</c:if>

<%-- Naver Analytics 스크립트 BEGIN 내부망은 제외시킴--%>
<c:choose>
<c:when test="${fn:indexOf(requestScope.userIp, '10.') >= 0}">
</c:when>
<c:when test="${fn:indexOf(requestScope.userIp, '192.168') >= 0}">
</c:when>
<c:otherwise>
<%-- STEP 1. NA 스크립트인 wcslog.js 호출 --%>
<script type="text/javascript" src="//wcs.naver.net/wcslog.js"></script>
<script type="text/javascript">
	// STEP 2. na_account_id(네이버공통키) 세팅
	if(!wcs_add) var wcs_add = {};
	wcs_add["wa"] = "724dd300f4ac8";
	// STEP 3. 로그 서버로 전송
	wcs_do();
</script>
</c:otherwise>
</c:choose>
<%-- Naver Analytics 스크립트 END --%>