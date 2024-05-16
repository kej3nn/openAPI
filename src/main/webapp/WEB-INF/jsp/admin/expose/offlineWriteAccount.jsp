<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="egovframework.common.WiseOpenConfig"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><spring:message code='wiseopen.title' /></title>
<c:import url="/WEB-INF/jsp/inc/headinclude.jsp" />
<script type="text/javascript" src="<c:url value="/js/admin/expose/offlineWriteAccount.js" />"></script>
</head>
<body>
	<div class="wrap">
		<c:import url="/admin/admintop.do" />
		<!--##  메인  ##-->
		<div class="container">
		
			<!-- 상단 타이틀 -->
			<div class="title">
				<h2>${MENU_NM}</h2>
				<p>${MENU_URL}</p>
			</div>
			</ul>
			
			<!-- 탭 -->
			<ul class="tab">
				<li class="all_list"><a href="#">전체목록</a></li>
			</ul>
			
			<c:import  url="offlineWriteAccountDtl.jsp"/>
			
			<!-- 리스트 -->
			<div class="content">
				<form name="statMainForm"  method="post" action="#">
				<input type="hidden" id="loginAccCd" name="loginAccCd" value="${sessionScope.loginVO.accCd}"/>
				<input type="hidden" id="loginOrgCd" name="loginOrgCd" value="${sessionScope.loginVO.orgCd}"/>
				<table class="list01">
					<caption>리스트</caption>
					<colgroup>
						<col width="150" />
						<col width="" />
						<col width="150" />
						<col width="" />
					</colgroup>
					<tr>
						<th>처리기관</th>
						<td>
							<c:choose>
							<c:when test="${sessionScope.loginVO.accCd eq 'SYS' or sessionScope.loginVO.accCd eq 'OPA'}">
							<select name="aplDealInstCd">
								<option value="">전체</option>
								<c:forEach var="instCd" items="${instCodeList }" varStatus="status">
								<option value="${instCd.orgCd}">${instCd.orgNm}</option>
								</c:forEach>
							</select>
							</c:when>
							<c:otherwise>
							${sessionScope.portalOrgName}
							<input type="hidden" name="aplDealInstCd" value="${sessionScope.portalOrgCode}"/>
								<c:choose>
								<c:when test="${sessionScope.loginVO.accCd eq 'DM'}">
									<input type="hidden" name="aplDeptCd" value="${sessionScope.portalDeptCode}"/>
								</c:when>
								<c:otherwise>
									<input type="hidden" name="aplDeptCd" value=""/>
								</c:otherwise>
								</c:choose>
							</c:otherwise>
							</c:choose>
						</td>
						<th>처리상태</th>
						<td>
							<select name="prgStatCd">
								<option value="">전체</option> 
								<c:forEach var="prgStatCd" items="${prgStatCodeList }" varStatus="status">
								<c:if test="${prgStatCd.baseCd eq '01' or prgStatCd.baseCd eq '03' or prgStatCd.baseCd eq '04' or prgStatCd.baseCd eq '05' or prgStatCd.baseCd eq '08' or prgStatCd.baseCd eq '99' or prgStatCd.baseCd eq '11' }">
									<option value="${prgStatCd.baseCd}">${prgStatCd.baseNm}</option>
								</c:if>	
								</c:forEach>
							</select>
							<span id="imdDealDivArea" style="display:none;">
								<input type="checkbox" name="imdDealDiv" value="1"/> 즉시처리건 조회
							</span>
						</td>	
					</tr>
					<tr>
						<th>청구제목</th>
						<td>
							<input type="text" name="aplSj" value="" placeholder="검색어 입력" size="40" />
						</td>
						<th>청구내용</th>
						<td>
							<input type="text" name="aplDtsCn" value="" placeholder="검색어 입력" size="40" />
						</td>
					</tr>
					<tr>
						<th>청구인</th>
						<td>
							<input type="text" name="aplPn" value="" placeholder="검색어 입력" size="40" />
						</td>
						<th>청구일자</th>
						<td>
							<input type="text" name="startAplDt" value="" placeholder="시작일자" size="13" />
							~
							<input type="text" name="endAplDt" value="" placeholder="종료일자" size="13" />
							&nbsp;&nbsp;
							<button type="button" class="btn01" id="aplDt_reset" name="aplDt_reset">초기화</button>
						</td>
					</tr>
					<tr>
						<th>공개여부</th>
						<td>
							<select name="opbYn">
								<option value="">전체</option>
								<option value="0">공개</option>
								<option value="1">부분공개</option>
								<option value="2">비공개</option>
								<option value="3">부존재 등</option>
							</select>
						</td>
						<th>통지일자</th>
						<td>
							<input type="text" name="startDcsNtcDt" value="" placeholder="시작일자" size="13" />
							~
							<input type="text" name="endDcsNtcDt" value="" placeholder="종료일자" size="13" />
							&nbsp;&nbsp;
							<button type="button" class="btn01" id="dcsNtcDt_reset" name="dcsNtcDt_reset">초기화</button>
						</td>
					</tr>
					<tr>
						<th>접수번호</th>
						<td colspan="3">
							<input type="text" name="rcpDtsNo" value="" placeholder="검색어 입력" size="40" />
						</td>
					</tr>
					
				</table>

				<div class="buttons">
					${sessionScope.button.btn_inquiry}
					<c:if test="${sessionScope.loginVO.accCd ne 'DM'}">
						<button type="button" class="btn01" title="청구서작성" name="btn_reg">청구서 작성</button>
					</c:if>
					${sessionScope.button.btn_printSave}
					${sessionScope.button.btn_xlsDown}
				</div>
				
				<div style="clear: both;"></div>
				<div class="ibsheet_area_both">
					<div id="sheet" class="sheet"></div> 
				</div> 
			</form>       
			</div>
			<form name="printForm" method="post">
				<input type="hidden" name="mrdParam" value=""/>
				<input type="hidden" name="width" value=""/>
				<input type="hidden" name="height" value=""/>
				<input type="hidden" name="title" value=""/>
			</form>	
			<form name="opnzDcsForm" method="post">
				<input type="hidden" name="aplNo" value=""/>
			</form>	
			<form name="isRealform" method="post">
				<input type="hidden" name="inst_cd" value="10B1000001"/>
				<input type="hidden" name="cert_cd" value="9700000003"/>
				<input type="hidden" name="login_rno1" value=""/>
				<input type="hidden" name="login_rno2" value=""/>
				<input type="hidden" name="login_name" value=""/>
			</form>	
			<form name="file-download-form" method="post">
				<input type="hidden" name="fileNm" title="파일명">
				<input type="hidden" name="filePath" title="파일경로">
			</form>
		<form name="dForm" method="post">
			<input type="hidden" name="fileName" />
			<input type="hidden" name="filePath" />
		</form>
			
		</div>
		<input type="hidden" name="openAplNo" id="openAplNo" value="${openAplNo}"/>
		<div id="loadingCircle" name="loadingCircle" style="position:fixed; top:0px; left:0px; width:100%; height: 100%; z-index:9999999999; display:none;">
			<div style="position:relative; top:50%; left:50%; margin: -37.5px 0 0 -37.5px;"><img src="<c:url value="/images/soportal/desktop/ajax-loader.gif"/>" alt="loading"></div>
		</div>
	</div>
	<iframe id="hidden-iframe" name="hidden-iframe" width="100%" height="0" frameborder="0" scrolling="0" style="display:none;"></iframe>
	<c:import  url="/WEB-INF/jsp/inc/iframepopup.jsp"/>
	<!--##  푸터  ##-->
	<c:import url="/WEB-INF/jsp/admin/adminfooter.jsp" />
	<!--##  /푸터  ##-->
</body>
</html>