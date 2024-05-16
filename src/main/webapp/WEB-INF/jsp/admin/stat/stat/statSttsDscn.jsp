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
<script type="text/javascript" src="<c:url value="/js/admin/stat/statSttsDscn.js" />"></script>

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
			
			<!-- 리스트 -->
			<div class="content">
				<form name="statMainForm" id="statMainForm" method="post" action="#">
				<table class="list01">
					<caption>통계표 분류 리스트</caption>
					<colgroup>
						<col width="20%"/>
						<col width="80%"/>
					</colgroup>
					<tr>
						<th>검색어</th>
						<td colspan="3">
							<select id="searchGubun" name="searchGubun">
								<option value="DSCN_NM">데이터셋 연계명</option>
							</select>
							<input type="text" name="searchVal" value="" placeholder="검색어 입력" size="40" />
							${sessionScope.button.btn_inquiry}  
						</td>
					</tr>
					<tr>
						<th>사용여부</th>
						<td>
							<input type="radio" value="" name="useYn" id="useYnAll" checked="checked"></input><label for="useYnAll">전체</label>&nbsp;&nbsp;
							<input type="radio" value="Y" name="useYn" id="useYnY"></input><label for="useYnY">사용</label>&nbsp;&nbsp;
							<input type="radio" value="N" name="useYn" id="useYnN"></input><label for="useYnN">미사용</label>
						</td>
					</tr>
				</table>
						
				<div style="width: 100%; float: left;">
					<div class="ibsheet-header">
						<button type="button" class="btn01" name="rowAdd" style="float: right">추가</button>
					</div>
					<div style="clear: both;"></div>
					<div class="ibsheet_area_both">
						<div id="sheet-sect" class="sheet"></div>
					</div>
				</div>		 
			
				<div class="buttons">
					${sessionScope.button.a_save}
				</div>
			</div>
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