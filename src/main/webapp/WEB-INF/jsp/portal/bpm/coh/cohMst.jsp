<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%-- 의정활동별 공개 - 인사청문회
<%-- 
<%-- @author JHKIM
<%-- @version 1.0 2019/11/05
<%--
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<!DOCTYPE html>
<html lang="ko">
<head>
<%@ include file="/WEB-INF/jsp/portal/sect/head.jsp" %>
<c:set var="leftBpmCoh" value="Y"></c:set>
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
				<div class="assemblyman_content pr0 active_top">
				
					<div class="assemblyman_active">
						
						<div id="tab-cont-sect">
							<form id="cohForm" method="post">
								<input type="hidden" name="page" value="${param.page}" title="페이지번호">
								<input type="hidden" name="rows" value="10" title="행번호">
								<input type="hidden" name="currentDate" value="10">
								<input type="hidden" name="gubunId" value="HA" title="구분코드">
								<input type="hidden" name="excelNm" value="" title="엑셀다운로드 명">
	
								<div class="theme_select_box layout_auto">
									<table>
							            <caption>인사청문회 : 후보자명, 직위, 소관위원회</caption>
							            <colgroup>
							            <col style="">
							            </colgroup>
							            <tbody>
							            <tr>
							                <th scope="row">후보자명</th>
							                <td colspan="3"><input type="text" title="후보자명" name="schAppointName"></td>
							            </tr>
							            <tr>
							                <th scope="row">직위</th>
							                <td><input type="text" title="직위" name="schAppointGrade"></td>
							                <th scope="row">소관위원회</th>
							                <td><input type="text" title="소관위원회" name="schCurrCommiittee"></td>
							            </tr>
							            </tbody>
							        </table>		
									
									<ul>
										<li><a href="javascript:;" class="btn_inquiries" id="btnSch">조회</a></li>
										<li><a href="javascript:;" class="btn_filedown" id="btnDownload">다운로드</a></li>
									</ul>
								</div>
	
								<div class="themeBscrollx hline">
									<table>
									<caption>인사청문회 : 직위정보, 후보자명, 소관위원회, 인사청문실시 계획서, 제안일자, 의안원문 정보, 소관위 회부일, 소관위 상정일, 소관위 처리일, 처리결과, 소관위 심사보고서</caption>
									<colgroup>
									<col style="">
									</colgroup> 
									<thead>
										<tr>
											<th scope="row">직위정보</th>
											<th scope="row">후보자명</th>
											<th scope="row">소관위원회</th>
											<th scope="row">인사청문실시<br>계획서</th>
											<th scope="row">제안일자</th>
											<th scope="row">의안원문 정보</th>
											<th scope="row">소관위 회부일</th>
											<th scope="row">소관위 상정일</th>
											<th scope="row">소관위 처리일</th>
											<th scope="row">처리결과</th>
											<th scope="row">소관위<br>심사보고서</th>
										</tr>
									</thead>
									<tbody id="coh-result-sect"></tbody>
									</table>
								</div>
								<div id="coh-pager-sect"></div>
							</form>
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
	
<script type="text/javascript" src="<c:url value="/js/portal/bpm/coh/cohMst.js" />"></script>
</body>
</html>