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
			
			
			<!-- 리스트 -->
			<div class="content">
				<form name="mainForm"  method="post" action="#">
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
						<td>
							<select id="searchGubun" name="searchGubun">
								<option value="JOB_NM">JOB 명</option>
								<option value="SRC_OBJ_NM">원천객체 명</option>
								<option value="TARGET_OBJ_NM">대상객체 명</option>
							</select>
							<input type="text" name="searchVal" value="" placeholder="검색어 입력" size="40" />
						</td>
						<th>처리일</th>
						<td>
							<input type="text" name="beginOpenDttm" value="" placeholder="처리일 시작" size="13" />
							~
							<input type="text" name="endOpenDttm" value="" placeholder="처리일 종료" size="13" />
							&nbsp;&nbsp;
							<button type="button" class="btn01" id="openDttm_reset" name="openDttm_reset">초기화</button>
						</td>
					</tr>
					<tr>
						<th>처리구분</th>
						<td colspan="3">
							<select id="jobTagCd" name="jobTagCd">
								<option value="">선택</option>
								<c:forEach var="list" items="${jobTagCd}">
									<option value="${list.code }">${list.name }</option>
								</c:forEach>
							</select>
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							${sessionScope.button.btn_inquiry}  
							${sessionScope.button.btn_xlsDown}
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
			<div style="position:relative; top:50%; left:50%; margin: -37.5px 0 0 -37.5px;"><img src="<c:url value="/images/soportal/desktop/ajax-loader.gif"/>" alt="loading"></div>
		</div>
	</div>
	<iframe id="hidden-iframe" name="hidden-iframe" width="100%" height="0" frameborder="0" scrolling="0" style="display:none;"></iframe>
	<c:import  url="/WEB-INF/jsp/inc/iframepopup.jsp"/>
	<!--##  푸터  ##-->
	<c:import url="/WEB-INF/jsp/admin/adminfooter.jsp" />
	<!--##  /푸터  ##-->
</body>
<script type="text/javascript" src="<c:url value="/js/admin/monitor/jobMonitor.js" />"></script>
</html>