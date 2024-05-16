<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>

<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%-- 국회의원 메인 탭
<%--              
<%-- @author JHKIM
<%-- @version 1.0 2019/10/21
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<div class="assemblyman_play">
	<ul id="tabBtnList">
		<li class="assplay01"><a href="javascript:;" class="on" id="tabLawm"><span><em>입법활동</em></span></a></li>
		<li class="assplay02"><a href="javascript:;" id="tabRemk"><span><em>국회발언</em></span></a></li>
		<li class="assplay03"><a href="javascript:;" id="tabPdta"><span><em>정책자료<br>&amp; 보고서</em></span></a></li>
		<li class="assplay04"><a href="javascript:;" id="tabSchd"><span><em>회의 일정</em></span></a></li>
		<li class="assplay05"><a href="javascript:;" id="tabNoti"><span><em>의원실 알림</em></span></a></li>
	</ul>
</div>
