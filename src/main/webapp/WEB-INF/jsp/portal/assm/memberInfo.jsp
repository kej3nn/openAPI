<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%-- 국회의원 인적정보 화면		                    	
<%-- 
<%-- @author JHKIM
<%-- @version 1.0 2019/10/16
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<!DOCTYPE html>
<html lang="ko">
<head>
<%@ include file="/WEB-INF/jsp/portal/sect/head.jsp" %>
<c:set var="leftMemberInfo" value="Y"></c:set>
</head>
<body>
<!-- wrapper -->
<div class="wrapper" id="wrapper">
<c:set var="isExistYAK" value="N"/>
<c:set var="isExistWI" value="N"/>
<c:set var="isExistASM" value="N"/>
<c:set var="isExistHAK" value="N"/>
<c:forEach var="data" items="${info }" varStatus="status">
<c:if test="${data.profileCd eq 'P01' }"><c:set var="isExistYAK" value="Y"/></c:if>	<!-- 약력 -->
<c:if test="${data.profileCd eq 'P13' }"><c:set var="isExistWI" value="Y"/></c:if>	<!-- 위원회 경력 -->
<c:if test="${data.profileCd eq 'P10' }"><c:set var="isExistASM" value="Y"/></c:if>	<!-- 국회의원경력 -->
<c:if test="${data.profileCd eq 'P04' }"><c:set var="isExistHAK" value="Y"/></c:if>	<!-- 학력 -->
</c:forEach>

<!-- container -->
<section>
	<div class="container hide-pc-lnb" id="container">
	
    <!-- content -->
    <article>
		<div class="contents" id="contents">
			<div class="layout_flex_100">
			
				<div class="assemblyman_memberinfo_mobile">
					<div class="assemblyman_header">국회의원현황</div>
					<a class="close" onclick="javascript: parent.close();">
						<img src="/images/btn_close_layerPopup_A.png" alt="닫기">
					</a>
					<div class="mca_header assemblyman_mca_header">
						<div>
							<span class="mcah01"><strong>의원명</strong></span>
							<span class="mcah02"><input type="text" id="" title="검색어 입력"></span>
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
					
					<form id="form" method="post" class="assemblyman_info_four">
						<input type="hidden" name="excelNm" value="" title="엑셀다운로드 파일명">
						<input type="hidden" name="profileCd" value="인적사항 구분코드">
					
					
						<!-- 탭 -->
						<div class="tab_B mt70 m_none w130x" id="tab-btn-sect">
							<c:if test="${isExistYAK eq 'Y' }"><a href="javascript:;" class="on" data-gubun="P01">약력</a></c:if>
							<c:if test="${isExistHAK eq 'Y' }"><a href="javascript:;" class="" data-gubun="P04">학력사항</a></c:if>
							<c:if test="${isExistASM eq 'Y' }"><a href="javascript:;" class="" data-gubun="P10">국회의원 이력</a></c:if>
							<!-- <c:if test="${fn:length(electedInfo) > 0 }"><a href="javascript:;" class="" data-gubun="P98">선거이력</a></c:if> -->
							<c:if test="${isExistWI eq 'Y' }"><a href="javascript:;" class="" data-gubun="P13">위원회 경력</a></c:if>
							<%-- 현역 국회의원 조회일경우 표시 --%>
							<c:if test="${isHistMemberSch != null && isHistMemberSch eq 'N' }">
								<c:if test="${ !empty meta.tUrl or !empty meta.fUrl or !empty meta.iUrl or !empty meta.bUrl or !empty meta.yUrl }">
									<a href="javascript:;" class="" data-gubun="P99">SNS</a>
								</c:if>
							</c:if>
							
							<div class="tab_downbtn">
								<button class="btn_filedown" id="btnMembDown">다운로드</button>
							</div>
				
						</div>
						<!-- //탭 -->
						
						<!-- 내용 -->
						<div id="tab-cont-sect" class="assembly_human_info" style="height:36px;">
							<!-- 약력 -->
							<c:if test="${isExistYAK eq 'Y' }">
								<div class="assem_profile" style="display: none;">
									<h5>약력</h5>
									<c:forEach var="data" items="${info }" varStatus="status">
									<c:if test="${data.profileCd eq 'P01' }">
										<div id="result-profile-sect">
											<pre id="P01"><c:out value="${data.profileSj }" escapeXml="false"></c:out></pre>
										</div>
									</c:if>
									</c:forEach>
								</div>
							</c:if>
							<!-- //약력 -->
							
							<!-- 학력 -->
							<c:if test="${isExistHAK eq 'Y' }">
								<div class="assem_profile" style="display: none;">
									<h5>학력</h5>
									<ul class="info_line" style="display: none;">
										<c:forEach var="data" items="${info }" varStatus="status">
										<c:if test="${data.profileCd eq 'P04' }">
											<li>
												<strong class="mw148x">${data.frtoDate }</strong>
												<span id="P04">${data.profileSj }</span>
											</li>
										</c:if>
										</c:forEach>
									</ul>
									<ul></ul>
								</div>
							</c:if>
							<!-- //학력 -->
							
							<!-- 국회의원 경력 -->
							<c:if test="${isExistASM eq 'Y' }">
								<div class="assem_profile" style="display: none;">
									<h5>국회의원 이력</h5>
									<ul class="info_line" style="display: none;">
										<c:forEach var="data" items="${info }" varStatus="status">
										<c:if test="${data.profileCd eq 'P10' }">
											<li>
												<strong>${data.frtoDate }</strong>
												<span id="P10">${data.profileSj }</span>
											</li>
										</c:if>
										</c:forEach>
									</ul>
									<ul></ul>
								</div>
							</c:if>
							<!-- //국회의원 경력 -->
							
							<!-- 선거이력 -->
							<!-- <c:if test="${fn:length(electedInfo) > 0 }">
								<div class="assem_profile" style="display: none;">
									<h5>선거 이력</h5>
									<div class="themeBscrollx assemblyOnly">
										<table>
											<caption>선거명, 선거구, 정당명, 득표율</caption>
											<colgroup class="m_none">
											<col style="width:35%;">
											<col style="width:26%;">
											<col style="width:23%;">
											<col style="width:28%;">
											</colgroup>
											<thead>
												<tr>
													<th scope="row">선거명</th>
													<th scope="row">선거구</th>
													<th scope="row">정당명</th>
													<th scope="row">득표율</th>
												</tr>
											</thead>
											<tbody>
											<c:forEach var="data" items="${electedInfo }">
												<tr>
													<td>${data.sgtypename }</td>
													<td>${data.sggname }</td>
													<td>${data.jdname }</td>
													<td>${data.dugyul }%</td>
												</tr>
											</c:forEach>
											</tbody>
										</table>
									</div>
								</div>
							</c:if> -->
							<!-- //선거이력 -->
							
							<!-- 위원회 경력 -->
							<c:if test="${isExistWI eq 'Y' }">
								<div class="assem_profile" style="display: none;">
									<h5>위원회 경력</h5>
									<ul class="info_line"  style="display: none;">
										<c:forEach var="data" items="${info }" varStatus="status">
										<c:if test="${data.profileCd eq 'P13' }">
											<li>
												<strong>${data.frtoDate }</strong>
												<span id="P13">${data.profileSj }</span>
											</li>
										</c:if>
										</c:forEach>
									</ul>
									<ul></ul>
								</div>
							</c:if>
							<!-- //위원회 경력 -->
							
							<!-- SNS -->
							<%-- 현역 국회의원 조회일경우 표시 --%>
							<c:if test="${isHistMemberSch != null && isHistMemberSch eq 'N' }">
								<c:if test="${ !empty meta.tUrl or !empty meta.fUrl or !empty meta.iUrl or !empty meta.bUrl or !empty meta.yUrl }">
									<div class="assem_profile" style="display: none;">
										<h5>SNS</h5>
										<div class="themeBscrollx assemblyOnly">
											<table>
												<caption>선거명, 선거구, 정당명, 득표율</caption>
												<colgroup class="m_none">
												<col style="width:15%;">
												<col style="width:;">
												</colgroup>
												<thead>
													<tr>
														<th scope="row">구분</th>
														<th scope="row">URL</th>
													</tr>
												</thead>
												<tbody>
													<c:if test="${!empty meta.fUrl }">
														<tr><td>페이스북</td><td><a title="새창열림_페이스북" href="${meta.fUrl }" target="_blank">${meta.fUrl }</a></td></tr>
													</c:if>
													<c:if test="${!empty meta.tUrl }">
														<tr><td>트위터</td><td><a title="새창열림_트위터" href="${meta.tUrl }" target="_blank">${meta.tUrl }</a></td></tr>
													</c:if>
													<c:if test="${!empty meta.bUrl }">
														<tr><td>블로그</td><td><a title="새창열림_블로그" href="${meta.bUrl }" target="_blank">${meta.bUrl }</a></td></tr>
													</c:if>
													<c:if test="${!empty meta.iUrl }">
														<tr><td>인스타그램</td><td><a title="새창열림_인스타그램" href="${meta.iUrl }" target="_blank">${meta.iUrl }</a></td></tr>
													</c:if>
													<c:if test="${!empty meta.yUrl }">
														<tr><td>유튜브</td><td><a title="새창열림_유튜브" href="${meta.yUrl }" target="_blank">${meta.yUrl }</a></td></tr>
													</c:if>
												</tbody>
											</table>
										</div>
									</div>
								</c:if>
							</c:if>
							<!-- //SNS -->
							
						</div>
						<!-- //내용 -->
					</form>
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
<script type="text/javascript" src="<c:url value="/js/portal/assm/memberInfo.js" />"></script>
<script type="text/javascript">
$(function() {
	/* if($("#P13").text() == ""){
		$("#tab-btn-sect > a").eq(1).hide();
		
	}
	else if($("#P04").text() == ""){
		$("#tab-btn-sect > a").eq(2).hide();
	}
	else if($("#P10").text() == ""){
		$("#tab-btn-sect > a").eq(3).hide();
	}
	 */
	
});
</script>
</body>
</html>