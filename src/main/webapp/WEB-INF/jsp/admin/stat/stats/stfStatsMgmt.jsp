<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="egovframework.common.WiseOpenConfig"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><spring:message code='wiseopen.title' /></title>
<c:import url="/WEB-INF/jsp/inc/headinclude.jsp" />
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
			
		<c:import  url="stfStatsMgmtDtl.jsp"/>
			
			<!-- 리스트 -->
			<div class="content">
				<form name="stfStatsMgmtMainForm"  method="post" action="#">
				<table class="list01">
					<caption>리스트</caption>
					<colgroup>
						<col width="150"/>
						<col width=""/>
						<col width="150"/>
						<col width=""/>
					</colgroup>
					<tr>
						<th><spring:message code='labal.search'/></th>             
						<td colspan="7">
							<select id="searchGubun" name="searchGubun">
								<option value=""><spring:message code="labal.whole" /></option>
								<option value="STATBL_NM">통계표명</option>
							</select>
							<input type="text" name="searchVal" value="" placeholder="검색어 입력" size="40" />
							${sessionScope.button.btn_inquiry} 
						</td>
					</tr>
				</table>		
				<div style="clear: both;"></div>
				<div class="ibsheet_area_both">
					<div id="sheet" class="sheet"></div> 
				</div>   
				</form>               	
			</div>
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
<script type="text/javascript" src="<c:url value="/js/admin/stat/stfStatsMgmt.js" />"></script>
</html>