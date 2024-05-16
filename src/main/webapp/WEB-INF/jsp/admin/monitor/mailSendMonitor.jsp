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
<script type="text/javascript" src="<c:url value="/js/admin/monitor/mailSendMonitor.js" />"></script>

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
				<form name="mail-monitor-form"  method="post" action="#">
				<table class="list01">
					<caption>리스트</caption>
					<colgroup>
						<col width="20%"/>
						<col width="80%"/>
					</colgroup>
					<tr>
						<th>검색어</th>
						<td colspan="3">
							<select name="searchGubun" value="">
								<option value="SUBJECT">제목</option>
								<option value="MAILTO">수신자</option>
							</select>
							<input type="text" name="searchVal" value="" placeholder="검색어 입력" size="40" />
							${sessionScope.button.btn_inquiry}  
							${sessionScope.button.btn_xlsDown}  
							
						</td>
					</tr>
					<tr>
						<th><label class="">전송요청일자</label></th>
						<td>
							<input type="text" name="regStartDtts" value="" readonly="readonly"/>
							~ 
							<input type="text" name="regEndDtts" value="" readonly="readonly"/>
						</td>
					</tr>
					<tr>
						<th>상태</th>
						<td>
							<input type="radio" name="errCode" id="errCode" value="" checked="checked">
								<label for="jobTagCdT">전체</label>
							</input> 
							<input type="radio" name="errCode" id="errCodeSUCC" value="100">
								<label for="errCodeSUCC">성공</label>
							</input>
							<input type="radio" name="errCode" id="errCodeFAIL" value="-1">
								<label for="errCodeFAIL">실패</label>
							</input>
							<input type="radio" name="errCode" id="errCodeBEFORE" value="0">
								<label for="errCodeBEFORE">전송 전</label>
							</input>
						</td>
					</tr>
				</table>		
				<div style="clear: both;"></div>
				<div class="ibsheet_area_both">
					<div id="sheet" class="sheet"></div> 
				</div>
			</div>
			</form>               	
		</div>
		
		<div id="loadingCircle" name="loadingCircle" style="position:fixed; top:0px; left:0px; width:100%; height: 100%; z-index:9999999999; display:none;">
			<div style="position:relative; top:50%; left:50%; margin: -37.5px 0 0 -37.5px;"><img src="<c:url value="/images/hfportal/desktop/ajax-loader.gif"/>" alt="loading"></div>
		</div>
	</div>
	<iframe id="hidden-iframe" name="hidden-iframe" width="100%" height="0" frameborder="0" scrolling="0" style="display:none;"></iframe>
	<c:import  url="/WEB-INF/jsp/inc/iframepopup.jsp"/>
	<!--##  푸터  ##-->
	<c:import url="/WEB-INF/jsp/admin/adminfooter.jsp" />
	<!--##  /푸터  ##-->
</body>

</html>