<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>

<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%-- 국회의원 LEFT 메뉴
<%--              
<%-- @author JHKIM
<%-- @version 1.0 2019/10/21
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%-- <script type="text/javascript" src="<c:url value="/js/portal/assm/common.js" />"></script> --%>
<iframe id="global-process-iframe" name="global-process-iframe"  title="프로그램 처리 영역" height="0" style="width:100%; display:none;"></iframe>
<form id="lnbForm">
<input type="hidden" name="empNo" value="<c:out value="${empNo }"/>" title="국회의원 코드">
<input type="hidden" name="unitCd" value="<c:out value="${unitCd }"/>" title="대수 코드">
<input type="hidden" name="empNm" value="<c:out value="${meta.hgNm }"/>" title="국회의원명">
<input type="hidden" name="monaCd" value="<c:out value="${monaCd }"/>" title="국회의원도메인">
</form>
<div class="assemblyman_menu">
	<div class="assemblyman_menu_head">
		<h2>국회의원 소개</h2>
	</div>
	<div class="assemblyman_menu_body">
		<c:choose>
		<%-- 역대국회의원 조회인경우 --%>
		<c:when test="${isHistMemberSch != null && isHistMemberSch eq 'Y' }">
		<ul>
			<li class="${leftMember     eq 'Y' ? 'on' : '' }"><a href="/portal/assm/memberPage.do?monaCd=${monaCd }&unitCd=${unitCd}"><span>요약정보</span></a></li>
			<li class="${leftMemberInfo eq 'Y' ? 'on' : '' }"><a href="/portal/assm/memberInfoPage.do?monaCd=${monaCd }&unitCd=${unitCd}"><span>인적사항</span></a></li>
			<li class="${leftCombLawm   eq 'Y' ? 'on' : '' }"><a href="/portal/assm/comb/combLawmPage.do?monaCd=${monaCd }&unitCd=${unitCd}"><span>의정활동</span></a></li>
			<li class="${leftCombPdta   eq 'Y' ? 'on' : '' }"><a href="/portal/assm/comb/combPdtaPage.do?monaCd=${monaCd }&unitCd=${unitCd}"><span>정책자료&보고서</span></a></li>
			<li class="${leftCombSchd   eq 'Y' ? 'on' : '' }"><a href="/portal/assm/comb/combSchdPage.do?monaCd=${monaCd }&unitCd=${unitCd}"><span>회의 일정</span></a></li>
			<li class="${leftCombNoti   eq 'Y' ? 'on' : '' }"><a href="/portal/assm/comb/combNotiPage.do?monaCd=${monaCd }&unitCd=${unitCd}"><span>의원실 알림</span></a></li>
		</ul>
		</c:when>
		<c:otherwise>
		<ul>
			<li class="${leftMember     eq 'Y' ? 'on' : '' }"><a href="/portal/assm/memberPage.do?monaCd=${monaCd }"><span>요약정보</span></a></li>
			<li class="${leftMemberInfo eq 'Y' ? 'on' : '' }"><a href="/portal/assm/memberInfoPage.do?monaCd=${monaCd }"><span>인적사항</span></a></li>
			<li class="${leftCombLawm   eq 'Y' ? 'on' : '' }"><a href="/portal/assm/comb/combLawmPage.do?monaCd=${monaCd }"><span>의정활동</span></a></li>
			<li class="${leftCombPdta   eq 'Y' ? 'on' : '' }"><a href="/portal/assm/comb/combPdtaPage.do?monaCd=${monaCd }"><span>정책자료&보고서</span></a></li>
			<li class="${leftCombSchd   eq 'Y' ? 'on' : '' }"><a href="/portal/assm/comb/combSchdPage.do?monaCd=${monaCd }"><span>회의 일정</span></a></li>
			<li class="${leftCombNoti   eq 'Y' ? 'on' : '' }"><a href="/portal/assm/comb/combNotiPage.do?monaCd=${monaCd }"><span>의원실 알림</span></a></li>
		</ul>
		</c:otherwise>
		</c:choose>
	</div>
</div>

<!-- 조회중 -->
<div id="loadingCircle" style="position:fixed; top:0px; left:0px; width:100%; height: 100%; z-index:9999999999; display:none;">
	<div style="position:relative; top:50%; left:50%; margin: -77px 0 0 -77px;z-index:10;"><img src="<c:url value="/images/soportal/desktop/ajax-loader.gif"/>" alt="loading"></div>
	<div class="bgshadow"></div>
</div>