<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>

<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%-- 의정활동별 공개 LEFT MENU
<%--              
<%-- @author JHKIM
<%-- @version 1.0 2019/11/05
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<form id="lnbForm">
</form>
<div class="assemblyman_openmenu">
	<div class="assemblyman_openmenu_head">
		<h2>의정활동 통합현황</h2>
		<a href="javascript:;" class="leftmenu_close">닫기</a>
	</div>
	<div class="assemblyman_openmenu_body">
		<ul>
			<li class="${leftBpmPrc eq 'Y' ? 'on' : '' }"><a href="/portal/bpm/prc/prcMstPage.do"><span>본회의 정보</span></a></li>
			<li class="${leftBpmCmp eq 'Y' ? 'on' : '' } ls1x"><a href="/portal/bpm/cmp/cmpMstPage.do"><span>위원회 정보</span></a></li>
			<li class="${leftBpmDate eq 'Y' ? 'on' : '' }"><a href="/portal/bpm/date/dateMstPage.do"><span>날짜별 의정활동</span></a></li>
			<li class="${leftBpmCoh eq 'Y' ? 'on' : '' }"><a href="/portal/bpm/coh/cohMstPage.do"><span>인사청문회</span></a></li>
			<li class="${leftBpmPet eq 'Y' ? 'on' : '' }"><a href="/portal/bpm/pet/petMstPage.do"><span>청원</span></a></li>
		</ul>
	</div>
</div>