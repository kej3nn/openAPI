<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%-- 국회의원 의원실 알림 화면 - 통합조회			                    	
<%-- 
<%-- @author JHKIM
<%-- @version 1.0 2019/10/22
<%--
<%-- combNotiToorRcrt	의원실 채용
<%-- combNotiPressIntv	기자회견
<%-- combNotiTwitter 	트위터
<%--
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<!DOCTYPE html>
<html lang="ko">
<head>
<%@ include file="/WEB-INF/jsp/portal/sect/head.jsp" %>
<script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script> 
<c:set var="leftCombNoti" value="Y"></c:set>
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
						${meta.hgNm } 국회의원의 의원실 채용 및 기자회견 정보를 조회하실 수 있습니다.
					</div>
					
					<div>
						<div class="tab_B mt30 m_none" id="tab-btn-sect">
							<a href="javascript:;" class="on">의원실 채용</a>
							<a href="javascript:;">기자회견</a>
							<!-- <a href="javascript:;">트위터</a> -->
						</div>
						
						<div id="tab-cont-sect" class="assembly_human_info">
							<div><%@ include file="/WEB-INF/jsp/portal/assm/comb/noti/combNotiToorRcrt.jsp" %></div>
							<div style="display: none;"><%@ include file="/WEB-INF/jsp/portal/assm/comb/noti/combNotiPressIntv.jsp" %></div>
							<%-- <div style="display: none;"><%@ include file="/WEB-INF/jsp/portal/assm/comb/noti/combNotiTwitter.jsp" %></div> --%>
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
	
<script type="text/javascript" src="<c:url value="/js/portal/assm/comb/combNoti.js" />"></script>
</body>
</html>