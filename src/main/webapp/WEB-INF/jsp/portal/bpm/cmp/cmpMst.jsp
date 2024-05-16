<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%-- 의정활동별 공개 - 위원회 구성/계류법안등
<%-- 
<%-- @author JHKIM
<%-- @version 1.0 2019/11/05
<%--
<%-- cmpCond	위원회 현황
<%-- cmpList	위원회 명단
<%-- cmpDate 	위원회 일정
<%-- cmpMoob 	계류의안
<%-- cmpReport	위원회 회의록
<%-- cmpRefR 	위원회 자료실

<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<!DOCTYPE html>
<html lang="ko">
<head>
<%@ include file="/WEB-INF/jsp/portal/sect/head.jsp" %>
<c:set var="leftBpmCmp" value="Y"></c:set>
</head>
<body>

<!-- header -->
<%@ include file="/WEB-INF/jsp/portal/sect/header.jsp" %>
<!-- //header -->

<!-- wrapper -->
<div class="wrapper" id="wrapper">

<!-- container -->
<section>
	<div class="container active_left" id="container">
				
	<!-- LEFT -->
	<%@ include file="/WEB-INF/jsp/portal/bpm/lnb.jsp" %>
	<!-- //LEFT -->
	
    <!-- content -->
    <article>
		<div class="contents" id="contents">
			<div class="contents-title-wrapper">
				<h3 class=""><c:out value="${requestScope.menu.lvl2MenuPath}" /><span class="arrow"></span></h3>
	        </div>
			<div class="layout_flex_100">
				
				<!-- RIGHT -->
				<div class="assemblyman_content pr0">
				
					<div>
						<div class="tab_B mt30 mnone" id="tab-btn-sect">
							<a href="javascript:;" class="on">위원회 현황</a>
							<a href="javascript:;">위원 명단</a>
							<a href="javascript:;">위원회 일정</a>
							<a href="javascript:;">계류의안</a>
							<a href="javascript:;">위원회 자료실</a>
							<a href="javascript:;">위원회 회의록</a>
						</div>
						
						<div class="tab_B_select">
							<select id="tab-select-sect" title="구분 선택">
								<option>위원회 현황</option>
								<option>위원 명단</option>
								<option>위원회 일정</option>
								<option>계류의안</option>
								<option>위원회 자료실</option>
								<option>위원회 회의록</option>
							</select>
						</div>
						
						<div id="tab-cont-sect">
							<div><%@ include file="/WEB-INF/jsp/portal/bpm/cmp/cmpCond.jsp" %></div>
							<div style="display: none;"><%@ include file="/WEB-INF/jsp/portal/bpm/cmp/cmpList.jsp" %></div>
							<div style="display: none;"><%@ include file="/WEB-INF/jsp/portal/bpm/cmp/cmpDate.jsp" %></div>
							<div style="display: none;"><%@ include file="/WEB-INF/jsp/portal/bpm/cmp/cmpMoob.jsp" %></div>
							<div style="display: none;"><%@ include file="/WEB-INF/jsp/portal/bpm/cmp/cmpRefR.jsp" %></div>
							<div style="display: none;"><%@ include file="/WEB-INF/jsp/portal/bpm/cmp/cmpReport.jsp" %></div>
						</div>
					</div>	
					
				</div>
				<!-- //RIGHT (content) -->
			</div>
		</div>
	</article>
	<!-- //contents  -->
	
	</div>
</section>
<!-- //container -->
</div>
	
<!-- footer -->
<%@ include file="/WEB-INF/jsp/portal/sect/footer.jsp" %>
<!-- //footer -->
	
<script type="text/javascript" src="<c:url value="/js/portal/bpm/cmp/cmpMst.js" />"></script>
</body>
</html>