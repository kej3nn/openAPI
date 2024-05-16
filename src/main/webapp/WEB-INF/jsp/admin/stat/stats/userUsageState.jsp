<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%-- <%@ page import="egovframework.common.util"%> --%>
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
<script type="text/javascript" src="<c:url value="/js/admin/stats/userUsageState.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/common/highcharts_2/highcharts.js" />"></script>
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
			<form name="statOpen"  method="post" action="#">
			<table class="list01">              
				<caption>회원목록</caption>
				<colgroup>
					<col width="150"/>
					<col width=""/>
				</colgroup>
				<tr>
					<th>메뉴</th>
					<td colspan="3">
						<input type="radio" name="searchWd" id="A" value="" checked="checked"/>
						<label for="A">전체</label>
						<input type="radio" name="searchWd" id="M" value="/21stMembers"/>
						<label for="M">국회의원</label>
						<input type="radio" name="searchWd" id="K" value="/infonavi"/>
						<label for="K">국회 정보나침반</label>
					</td>
				</tr>
				<tr>
					<th>국회의원</th>
					<td colspan="3">
						<input name="searchWord" type="text" value=""/>
					</td>
				</tr>
				
				<tr>
					<th><label class="">접속일자</label></th>
					<td colspan="3">
						<input type="text" name="startYmd" value="" placeholder="시작일자" size="15" />
						~
						<input type="text" name="endYmd" value="" placeholder="종료일자" size="15" />
						${sessionScope.button.btn_inquiry}
						${sessionScope.button.btn_xlsDown}       
					</td>
				</tr>
			</table>	
			</form>
					
				<!-- ibsheet 영역 -->
				<div id="mainChart1" class="chart" style="width:100%; height:400px;"></div>   
				<div class="ibsheet_area" style="height:600px;">
					<div id="sheet" class="sheet"></div>    
				</div>
			</div>
			
		</div>
</div>
</body>
</html>