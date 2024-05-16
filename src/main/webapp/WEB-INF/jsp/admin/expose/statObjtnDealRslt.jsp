<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="egovframework.common.WiseOpenConfig"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><spring:message code='wiseopen.title'/></title>                    
<c:import  url="/WEB-INF/jsp/inc/headinclude.jsp"/>
<script type="text/javascript" src="<c:url value="/js/admin/expose/statObjtnDealRslt.js" />"></script>
</head>     
<body onload="">
<div class="wrap">
	<c:import  url="/admin/admintop.do"/>
	<!--##  메인  ##-->
	<div class="container">
		<!-- 상단 타이틀 -->   
		<div class="title">
			<h2>${MENU_NM}</h2>                                      
			<p>${MENU_URL}</p>             
		</div>
			<!-- 탭 -->
			
		<!-- 목록내용 -->
		<div class="content">
			<form name="objtnDealRslForm"  method="post" action="#">
				<input type="hidden" name="aplDealInstCd" value="" />
				
				<table class="list01">              
					<caption>회원목록</caption>
					<colgroup>
						<col width="150"/>
						<col width=""/>
						<col width="150"/>
						<col width=""/>
					</colgroup>
					<tr>
						<th>처리기관</th>
						<td colspan="3">
							<select name="instCd">
								<option value="">전체</option>
								<c:forEach var="instCd" items="${instCodeList }" varStatus="status">
									<option value="${instCd.orgCd}">${instCd.orgNm}</option>
								</c:forEach>
							</select>
							
						</td>
					</tr>	
					<tr>	
						<th>이의신청일자</th>
						<td colspan="3">
							<input type="text" name="aplDtFrom" value="" placeholder="시작일자" size="15" />
							~
							<input type="text" name="aplDtTo" value="" placeholder="종료일자" size="15" />
							<button type="button" class="btn01" id="aplDt_reset" name="aplDt_reset">초기화</button>      
						</td>
					</tr>
					
				</table>
				<div class="buttons">
					${sessionScope.button.btn_inquiry}
					${sessionScope.button.btn_printSave}
					${sessionScope.button.btn_xlsDown} 
				</div>	
			</form>
			<!-- ibsheet 영역 -->
			<div style="clear: both;"></div>
			<div class="ibsheet_area" style="height:600px;">
				<div id="sheet" class="sheet"></div>    
			</div>
		</div>
		<form name="printForm" method="post">
			<input type="hidden" name="mrdParam" value=""/>
			<input type="hidden" name="width" value=""/>
			<input type="hidden" name="height" value=""/>
			<input type="hidden" name="title" value=""/>
		</form>	
	</div>
</div>
</body>
</html>