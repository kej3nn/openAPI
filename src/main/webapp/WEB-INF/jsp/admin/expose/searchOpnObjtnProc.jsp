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
<script type="text/javascript" src="<c:url value="/js/admin/expose/searchOpnObjtnProc.js" />"></script>

</head>
<script language="javascript">   
</script>
</head>
<body onload="">
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
			
			<c:import  url="detailOpnObjtnProc.jsp"/>
			
			<!-- 리스트 -->
			<div class="content">
				<form name="statMainForm"  method="post" action="#">
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
							<select name="aplInst">
								<option value="">전체</option>
								<c:forEach var="instCd" items="${instCodeList }" varStatus="status">
									<option value="${instCd.orgCd}">${instCd.orgNm}</option>
								</c:forEach>
							</select>
							</c:when>
							<c:otherwise>
							${sessionScope.portalOrgName}
							<input type="hidden" name="aplInst" value="${sessionScope.portalOrgCode}"/>
							</c:otherwise>
							</c:choose>
						</td>
						<th>처리상태</th>
						<td>
							<select name="objtnStatCd">
								<option value="">전체</option>
								<option value="01">신청</option>
								<option value="02">처리중</option>
								<option value="05">결정통지</option>
								<option value="03">통지완료</option>
								<option value="04">기간연장</option>
								<option value="99">취하</option>
							</select>
						</td>	
					</tr>
					<tr>
						<th>청구제목</th>
						<td>
							<input type="text" name="aplSj" value="" placeholder="검색어 입력" size="40" />
						</td>
						<th>신청내용</th>
						<td>
							<input type="text" name="objtnRson" value="" placeholder="검색어 입력" size="40" />
						</td>
					</tr>
					<tr>
						<th>신청인</th>
						<td>
							<input type="text" name="aplPn" value="" placeholder="검색어 입력" size="40" />
						</td>
						<th>신청일자</th>
						<td>
							<input type="text" name="aplDtFrom" value="" placeholder="시작일자" size="13" />
							~
							<input type="text" name="aplDtTo" value="" placeholder="종료일자" size="13" />
							&nbsp;&nbsp;
							<button type="button" class="btn01" id="aplDt_reset" name="aplDt_reset">초기화</button>
						</td>
					</tr>
					<tr>
						<th>처리결과</th>
						<td>
							<select name="objtnDealRsltCd">
								<option value="">전체</option>
								<option value="01">기간연장</option>
								<option value="02">각하</option>
								<option value="03">기각</option>
								<option value="04">인용</option>
								<option value="05">결부분인용정통지</option>
								<option value="99">취하</option>
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
					${sessionScope.button.btn_printSave}
					${sessionScope.button.btn_xlsDown}
				</div>
				<div style="clear: both;"></div>
				<div class="ibsheet_area_both">
					<div id="sheet" class="sheet"></div> 
				</div>
				
			</div>
			</form>
			<form name="printForm" method="post">
				<input type="hidden" name="mrdParam" value=""/>
				<input type="hidden" name="width" value=''/>
				<input type="hidden" name="height" value=''/>
				<input type="hidden" name="title" value=""/>
			</form>		
			<form name="file-download-form" method="post">
				<input type="hidden" name="fileNm" title="파일명">
				<input type="hidden" name="filePath" title="파일경로">
			</form>	
		</div>

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