<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="egovframework.common.WiseOpenConfig"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><spring:message code='wiseopen.title' /></title>
<c:import url="/WEB-INF/jsp/inc/headinclude.jsp" />
<script type="text/javascript" src="<c:url value="/js/admin/openinf/openDsUsrDefInput.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/admin/openinf/openDsUsrDefInputEvent.js" />"></script>
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
			<c:import url="openDsUsrDefInputDtl.jsp"/>
			
			<!-- 리스트 -->
			<div class="content">
				<form id="mstForm" name="mstForm" method="post" action="#">
				<input type="hidden" id="dsId" name="dsId" value="${dsId}">
				<input type="hidden" id="isUTF8" value="${isUTF8}">
				<table class="list01">
					<caption>공공데이터 데이터입력 리스트</caption>
					<colgroup>
						<col width="15%"/>
						<col width="35%"/>
						<col width="15%"/>
						<col width="35%"/>
					</colgroup>
					<tr>
						<th>검색어</th>
						<td colspan="3">
							<select name="searchGubun" value="">
							<c:forEach items="${colList }" var="list">
								<c:if test="${list.srcColType eq 'VARCHAR' && list.srcColSize >= 100 }">
									<option value="${list.colSeq }">${list.colNm }</option>	
								</c:if>
							</c:forEach>
							</select>
							<input type="text" name="searchVal" value="" placeholder="검색어 입력" size="40" />
							${sessionScope.button.btn_inquiry}
							${sessionScope.button.btn_reg}  
						</td>
					</tr>
				</table>		
				
				<div style="clear: both;"></div>
				<div class="ibsheet_area_both">
					<div id="mainSheet" class="sheet"></div> 
				</div>         
				</form>               	
			</div>
		
		</div>
		
		<div id="loadingCircle" name="loadingCircle" style="position:fixed; top:0px; left:0px; width:100%; height: 100%; z-index:9999999999; display:none;">
			<div style="position:relative; top:50%; left:50%; margin: -37.5px 0 0 -37.5px;"><img src="<c:url value="/img/ajax-loader.gif"/>" alt="loading"></div>
		</div>
		<form id="downloadForm" action="/admin/openinf/opends/downloadOpenUsrDefFile.do" target="hidden-iframe">
			<input type="hidden" name="dataSeqceNo">
			<input type="hidden" name="fileSeq">
			<input type="hidden" name="dsId">
			<input type="hidden" name="saveFileNm">
			<input type="hidden" name="srcFileNm">
		</form>
	</div>
	<iframe id="hidden-iframe" name="hidden-iframe" width="100%" height="0" frameborder="0" scrolling="0" style="display:none;"></iframe>
	<c:import  url="/WEB-INF/jsp/inc/iframepopup.jsp"/>
	<!--##  푸터  ##-->
	<c:import url="/WEB-INF/jsp/admin/adminfooter.jsp" />
	<!--##  /푸터  ##-->
</body>

</html>