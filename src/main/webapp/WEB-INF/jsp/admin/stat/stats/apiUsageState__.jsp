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
<script type="text/javascript" src="<c:url value="/js/admin/stats/apiUsageState.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/common/highcharts/highstock.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/common/highcharts/highcharts-more.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/common/highcharts/highcharts-3d.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/common/highcharts/modules/exporting.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/common/highcharts/modules/data.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/common/highcharts/modules/drilldown.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/common/highcharts/modules/treemap.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/common/highcharts/modules/sunburst.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/common/highcharts/modules/map.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/common/highcharts/modules/data.js" />"></script>

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
					<th><label class="">기준월</label></th>
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
				<div class="ibsheet_area" style="">
					<div id="mainChart" class="chart"></div>  
					<div id="sheet" class="sheet"></div>					  
				</div>
			</div>
			
		</div>
</div>
</body>
</html>