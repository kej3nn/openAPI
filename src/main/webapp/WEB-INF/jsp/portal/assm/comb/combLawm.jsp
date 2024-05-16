<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%-- 국회의원 의정활동 화면 - 통합조회			                    	
<%-- 
<%-- @author JHKIM
<%-- @version 1.0 2019/10/16
<%--
<%-- combLawmDegtMotnLgsb	대표발의 법률안
<%-- combLawmClboMotnLgsb	공동발의 법률안
<%-- combLawmRglsVoteInfo 	본회의 표결정보
<%-- combLawmSdcmAct		상임위 활동
<%-- combLawmVideoMnts		영상회의록
<%-- combLawmPttnReport		청원현황
<%-- combLawmRschOrg		연구단체 
<%--
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<!DOCTYPE html>
<html lang="ko">
<head>
<%@ include file="/WEB-INF/jsp/portal/sect/head.jsp" %>
<c:set var="leftCombLawm" value="Y"></c:set>
</head>
<body>

<!-- wrapper -->
<div class="wrapper" id="wrapper">

<!-- container -->
<section>
	<div class="container hide-pc-lnb" id="container">
	
    <!-- content -->
    <article>
		<div class="contents" id="contents">
			<div class="layout_flex_100">
				<div class="assemblyman_memberinfo_mobile">
					<div class="assemblyman_header">국회의원현황</div>
					<a class="close" onclick="javascript: window.close();">
						<img src="/images/btn_close_layerPopup_A.png" alt="닫기">
					</a>
					<div class="mca_header assemblyman_mca_header">
						<div>
							<span class="mcah01"><strong>의원명</strong></span>
							<span class="mcah02"><input type="text" id="" title="검색어  입력" ></span>
							<span class="mcah03"><button type="button" id="">조회</button></span>
							<span class="mcah04"><button type="button" id="">상세조회</button></span>
						</div>
					</div>
				</div>
				
				<!-- 국회의원 LEFT -->
				<%@ include file="/WEB-INF/jsp/portal/assm/sect/lnb.jsp" %>
				<!-- //국회의원 LEFT -->
				
				<!-- 국회의원 RIGHT -->
				<div class="assemblyman_content">
					<!-- 개인신상정보 -->
					<%@ include file="/WEB-INF/jsp/portal/assm/sect/meta.jsp" %>
					<!-- //개인신상정보 -->
					
					<div class="assemblyman_desc">
						${meta.hgNm } 국회의원의 입법 발의 및 활동 정보를 조회하실 수 있습니다.
					</div>
					
					<div>
						<div class="tab_G mt30 m_none" id="tab-btn-sect">
							<a href="javascript:;" class="on">대표발의 법률안</a>
							<a href="javascript:;">공동발의 법률안</a>
							<a href="javascript:;">본회의 표결정보</a>
							<a href="javascript:;">상임위 활동</a>
							<a href="javascript:;">영상 회의록</a>
							<a href="javascript:;">청원현황</a>
							<a href="javascript:;">연구단체</a>
						</div>
						
						<div id="tab-cont-sect" class="assembly_human_info">
							<div class="assembly_hi01">
								<h5>대표발의 법률안</h5>
								<%@ include file="/WEB-INF/jsp/portal/assm/comb/lawm/combLawmDegtMotnLgsb.jsp" %>
							</div>
							<div class="assembly_hi02">
								<h5>공동발의 법률안</h5>
								<%@ include file="/WEB-INF/jsp/portal/assm/comb/lawm/combLawmClboMotnLgsb.jsp" %>
							</div>
							<div class="assembly_hi03">
								<h5>본회의 표결정보</h5>
								<%@ include file="/WEB-INF/jsp/portal/assm/comb/lawm/combLawmRglsVoteInfo.jsp" %>
							</div>
							<div class="assembly_hi04">
								<h5>상임위 활동</h5>
								<%@ include file="/WEB-INF/jsp/portal/assm/comb/lawm/combLawmSdcmAct.jsp" %>
							</div>
							<div class="assembly_hi05">
								<h5>영상 회의록</h5>
								<%@ include file="/WEB-INF/jsp/portal/assm/comb/lawm/combLawmVideoMnts.jsp" %>
							</div>
							<div class="assembly_hi06">
								<h5>청원현황</h5>
								<%@ include file="/WEB-INF/jsp/portal/assm/comb/lawm/combLawmPttnReport.jsp" %>
							</div>
							<div class="assembly_hi07">
								<h5>연구단체</h5>
								<%@ include file="/WEB-INF/jsp/portal/assm/comb/lawm/combLawmRschOrg.jsp" %>
							</div>
						</div>
					</div>	
					
				</div>
				<!-- //국회의원 RIGHT (content) -->
			</div>
		</div>
	</article>
	<!-- //contents  -->
	
	</div>
</section>
<!-- //container -->
</div>
	
<script type="text/javascript" src="<c:url value="/js/portal/assm/comb/combLawm.js" />"></script>
</body>
</html>