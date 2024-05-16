<%@ page language="java" contentType="text/html; charset=utf-8"	pageEncoding="utf-8"%>
<%@ page import="egovframework.common.WiseOpenConfig"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><spring:message code='wiseopen.title' /></title>
<c:import url="/WEB-INF/jsp/inc/headinclude.jsp" />
<script type="text/javascript" src="<c:url value="/js/admin/expose/instMgmt.js" />"></script>
</head>
<body onload="">
	<div class="wrap">
		<c:import url="/admin/admintop.do" />
		<!-- 내용 -->
		<div class="container">
			<!-- 상단 타이틀 -->
			<div class="title">
				<h2>${MENU_NM}</h2>
				<p>${MENU_URL}</p>
			</div>

			<!-- 목록내용 -->
			<div class="content">
				<form name="adminInstMgmtList" method="post" action="#">
				<input type="hidden" name="instCd" value=""/>
				<input type="hidden" name="instNm" value=""/>
				<input type="hidden" name="instOrd" value=""/>
					<!-- ibsheet 영역 -->
					<div style="clear: both;"></div>
					<div class="ibsheet_area" style="height:200px;">
						<div id="sheet" class="sheet"></div>
					</div>
				</form>

			<!-- 탭 내용 -->
				<form name="adminInstMgmtInfo" method="post" action="#">
				<h3 class="text-title2">기관내용</h3>
					<input type="hidden" name="initFlag"/>
					<table class="list01">
						<caption>기관관리</caption>
						<colgroup>
							<col width="100" />
							<col width="150" />
							<col width="300" />
							<col width="150" />
							<col width="400" />
						</colgroup>
						
						<tr>
							<!-- 기관명 -->
							<th colspan="2">기관명 <span>*</span></th>
							<td><input type="text" name="instNm" value="" maxlength="160" style="width: 200px;;display:none;" />
								<span name="instText">위 기관을 더블클릭 하세요.</span>
							</td>
							<!-- 기관코드 -->
							<th>기관코드 <span>*</span></th>
							<td>
							 <input type="text" name="instCd" id="instCd" value="" maxlength="20" style="width: 200px;display:none;" />
								<span name="instText">위 기관을 더블클릭 하세요.</span>
							</td>
						</tr>
						<tr>
							<!-- 기관장명 -->
							<th colspan="2">기관장명 <span>*</span></th>
							<td colspan="3"><input type="text" name="inscfNm" id="inscfNm" value=""
								style="width: 330px;" maxlength="660" />&nbsp;</td>
						</tr>
						<tr>
							<!-- 전화번호, FAX번호 -->
							<th colspan="2">전화번호 <span>*</span></th>
							<td><input type="text" name="instPno" id="instPno" style="width: 300px;" maxlength="160" /></td>
							<th>FAX 번호 <span>*</span></th>
							<td><input type="text" name="instFaxNo" id="instFaxNo" style="width: 300px;" maxlength="160" /></td>
						</tr>
						<tr>
							<!-- 부가정보, 담당부서, 결재권자1 -->
							<th rowspan="6">부가정보</th>
							<th>담당부서 <span>*</span></th>
							<td><input type="text" name="instChrgDeptNm" id="instChrgDeptNm" style="width: 300px;" maxlength="160" /></td>
							<th>결재권자1 <span>*</span></th> 
							<td><input type="text" name="instChrgCentCgp1Nm" id="instChrgCentCgp1Nm" style="width: 300px;" maxlength="160" /></td>
						</tr>
						<tr>
							<!-- 결재권자2, 결재권자3 -->
							<th>결재권자2</th>
							<td><input type="text" name="instChrgCentCgp2Nm" style="width: 300px;" maxlength="160" /></td>
							<th>결재권자3</th> 
							<td><input type="text" name="instChrgCentCgp3Nm" style="width: 300px;" maxlength="160" /></td>
						</tr>
						<tr>
							<!-- 은행명, 예금주 -->
							<th>은행명</th>
							<td><input type="text" name="instBankNm" style="width: 300px;" maxlength="160" /></td>
							<th>예금주</th> 
							<td><input type="text" name="instAccNm" style="width: 300px;" maxlength="160" /></td>
						</tr>
						<tr>
							<!-- 계좌번호 -->
							<th>계좌번호</th>
							<td colspan="3"><input type="text" name="instAccNo" style="width: 300px;" maxlength="160" /></td>
						</tr>
						<tr>
							<th>직인파일</th>
							<td>
								<span id="fileImgDiv" style="display:inline-block;">
									<input type='file' name='instOfslFlPhNm' id='instOfslFlPhNm' accept="image/*"/>
								</span>
							</td>
							<th>직인이미지</th>
							<td style="text-align:left;">
								<div class="appendImg">
									<img id="instImg" alt="" src="" width="100" height="100"  />
								</div>
							</td>
						</tr> 
						
					</table>
				</form>
				<div class="buttons">${sessionScope.button.a_init} 
				${sessionScope.button.a_reg}
				</div>
				
			</div>
		</div>
	</div>
	<iframe id="hidden-iframe" name="hidden-iframe" width="100%" height="0" frameborder="0" scrolling="0" style="display:none;"></iframe>
	<c:import  url="/WEB-INF/jsp/inc/iframepopup.jsp"/> 
	<!--##  푸터  ##-->
	<c:import url="/WEB-INF/jsp/admin/adminfooter.jsp" />
	<!--##  /푸터  ##-->
</body>
</html>