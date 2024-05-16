<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%-- <%@ page import="egovframework.common.util"%> --%>
<%@ page import="egovframework.common.WiseOpenConfig"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><spring:message code='wiseopen.title'/></title>                    
<c:import  url="/WEB-INF/jsp/inc/headinclude.jsp"/>
<script type="text/javascript" src="<c:url value="/js/admin/stats/statOpenState.js" />"></script>
</head>     
<body >
<div class="wrap">
		<c:import  url="/admin/admintop.do"/>
		<!--##  메인  ##-->
		<div class="container">
			<!-- 상단 타이틀 -->   
			<div class="title">
				<h2>${MENU_NM}</h2>                                      
				<p>${MENU_URL}</p>             
			</div>
			
			<!-- 탭 내용 -->
			
			<div class="more_list" style="display:none">
				<a href="#" class="more">0</a>                
				<ul class="other_list" style="display:none;">
					<li><a href="#">보유데이터목록</a><a href="#" class="line_close">x</a></li>
					<li><a href="#">공공데이터목록</a><a href="#" class="line_close">x</a></li>
				</ul>
			</div>
			
			<div class="content-default">
				
				<div class="statistics">
					<div class="statistics-list" title="실시간">
						<h4>통계메타</h4>
						<p id="statCnt"></p>
					</div>
					<div class="statistics-list" title="실시간">
						<h4>통계표</h4>
						<p id="statblCnt"></p>
					</div>
					<div class="statistics-list p2" title="통계">
						<h4>통계표 활용(전일)</h4>
						<p id="useCnt"></p>
					</div>
				</div>
 
				<div class="ibsheet-header">				
					<h3 class="text-title2">통계표 공개 현황</h3>
					<p class="title-txt">
<!-- 						(평균개방율 : 98%)					 -->
					</p>
					<p>
<!-- 						<span>Excel Download :</span> -->
						${sessionScope.button.btn_xlsDown}
					</p>
				</div>
				<div class="ibsheet_area" style="height:400px;">
 					<div id="sheet" class="sheet"></div>               
 				</div>
				
			</div>
			
		</div>
		
		<!--##  푸터  ##-->
 			 <c:import  url="/WEB-INF/jsp/admin/adminfooter.jsp"/>
		<!--##  /푸터  ##-->
</div>
</body>
</html>