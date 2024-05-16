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
<script type="text/javascript" src="<c:url value="/js/admin/openinf/opends.js" />"></script>
</head>
<script language="javascript">   
</script>
</head>
<body onload="">
	<div class="wrap" id="top-area">
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
			<!-- 탭 미사용
			<ul class="tab">
				<li class="all_list"><a href="#">전체목록</a></li>
			</ul>
 			-->			
			
			<!-- 리스트 -->
			<div class="content">
				<form name="adminOpenDs"  method="post" action="#">
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
								<option value="DS_NM">데이터셋명</option>
								<option value="ENG_DS_NM">영문데이터셋명</option>
								<option value="DS_ID">데이터셋ID</option>
							</select>
							<input type="text" name="searchVal" value="" placeholder="검색어 입력" size="40" />
							<input type="checkbox" name="keyDbYn" id="keyDbYnY" value="Y" class="input"><label for="keyDbYnY"> 국가중점DB</label></input>&nbsp;&nbsp;
							<input type="checkbox" name="stddDsYn" id="stddDsYnY" value="Y" class="input"><label for="stddDsYnY"> 행자부표준DB</label></input>
						</td>
					</tr>
					<tr>
						<th>사용여부</th>
						<td>
							<input type="radio" value="" name="useYn" id="useYnAll" checked="checked"></input><label for="useYnAll">전체</label>&nbsp;&nbsp;
							<input type="radio" value="Y" name="useYn" id="useYnY"></input><label for="useYnY">사용</label>&nbsp;&nbsp;
							<input type="radio" value="N" name="useYn" id="useYnN"></input><label for="useYnN">미사용</label>
							&nbsp;&nbsp;&nbsp;
							${sessionScope.button.btn_inquiry}
							${sessionScope.button.btn_reg}
						</td>
					</tr>
				</table>		
				<div style="clear: both;"></div>
				<div class="ibsheet_area_both">
					<!-- <div id="mySheet" class="sheet"></div>  -->
					<script type="text/javascript">createIBSheet("mySheet", "100%", "400px");</script>
				</div>
			</div>
			</form>               	
		</div>
		
		<c:import  url="newOpendsDtl.jsp"/>            
		
		
		<div id="loadingCircle" name="loadingCircle" style="position:fixed; top:0px; left:0px; width:100%; height: 100%; z-index:9999999999; display:none;">
			<div style="position:relative; top:50%; left:50%; margin: -37.5px 0 0 -37.5px;"><img src="<c:url value="/img/ajax-loader.gif"/>" alt="loading"></div>
		</div>
	</div>
	<iframe id="hidden-iframe" name="hidden-iframe" width="100%" height="0" frameborder="0" scrolling="0" style="display:none;"></iframe>
	<c:import  url="/WEB-INF/jsp/inc/iframepopup.jsp"/>
	<!--##  푸터  ##-->
	<c:import url="/WEB-INF/jsp/admin/adminfooter.jsp" />
	<!--##  /푸터  ##-->
</body>

</html>