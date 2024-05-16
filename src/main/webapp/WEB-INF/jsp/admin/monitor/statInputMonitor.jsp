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
<!-- jquery chart plugin [high charts] -->
<script type="text/javascript" src="<c:url value="/js/common/highcharts_2/highcharts.js" />"></script>
 
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
						<th>담당부서</th>
						<td>
							<input type="text" id="orgCd" name="orgCd" size="8" value="" readonly="readonly" />
							<input type="text" id="orgNm" name="orgNm" size="25" value="" placeholder="선택하세요.." readonly="readonly" />
							<button type="button" class="btn01" id="org_pop" name="org_pop">검색</button>
							<button type="button" class="btn01" id="org_reset" name="org_reset">초기화</button>
						</td>
						<th>입력예정일</th>
						<td>
							<input type="text" name="beginOpenDttm" value="" placeholder="예정일 시작" size="13" />
							~
							<input type="text" name="endOpenDttm" value="" placeholder="예정일 시작" size="13" />
							&nbsp;&nbsp;
							<button type="button" class="btn01" id="openDttm_reset" name="openDttm_reset">초기화</button>
						</td>
					</tr>
					<tr>
						<th><spring:message code='labal.search'/></th>             
						<td>
							<select id="searchGubun" name="searchGubun">
								<option value=STATBL_NM>통계표 명</option>
								<option value="STATBL_ID">통계표 ID</option>
							</select>
							<input type="text" name="searchVal" value="" placeholder="검색어 입력" size="40" />
							
						</td>
						<td>
							<input type="checkbox" name="nawYn" value="Y"/>
							<span>미제출만 조회</span>
						</td>
						<td>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							${sessionScope.button.btn_inquiry}  
							${sessionScope.button.btn_xlsDown}
						</td>
					</tr>
				</table>		
				<div style="clear: both;"></div>
				<div class="ibsheet_area_both">
				<div style="display:flex;  gap:100px;">
					<div style="display:flex; flex-direction:column; width:100%;">
						<div id="barChart1" class="chart" style="height:400px;"></div>
						<div id="barChart2" class="chart" style="height:400px;"></div>
					</div>
				</div>
				<div style="display:flex;  gap:100px;">
					<div id="pieChart" class="chart" style="width:30%; height:400px;"></div>
					<div style="width:70%;" >
					<div id="mainSheet" class="sheet" style="height:400px;"></div>
					<div style="text-align: left";>
					<span>주 ) 입력률 = (승인 + 제출) / 합계 </span><br>
				    &nbsp;&nbsp;&nbsp;&nbsp;<span>	단, 입력대기(제출 예전일 전) 는 제외</span>
				    </div>
				</div> 
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
<script type="text/javascript" src="<c:url value="/js/admin/monitor/statInputMonitor.js" />"></script>
</html>