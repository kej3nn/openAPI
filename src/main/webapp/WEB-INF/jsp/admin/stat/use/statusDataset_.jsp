<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
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
<script type="text/javascript">
var IBSHEETPAGENOW = <%=WiseOpenConfig.IBSHEETPAGENOW%>;
</script>
<script type="text/javascript" src="<c:url value="/js/admin/stats/use/statusDataset.js"/>"></script>
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
				<form name="statUse"  method="post" action="#">
				<table class="list01">              
					<caption>회원목록</caption>
					<colgroup>
						<col width="150"/>
						<col width=""/>
					</colgroup>
					<tr>
						<th><label class=""><spring:message code="labal.stdDttm"/></label></th>
						<td colspan="3">
							<input type="text" name="pubDttmFrom" value="" readonly="readonly"/>
							<input type="text" name="pubDttmTo" value="" readonly="readonly"/>
						</td>
					</tr>
					<tr>
						<th>대분류</th>
						<td colspan="3">
							<select name="cateId">
								<option value="">전체</option>							
							</select>
						</td>
					</tr>
					<tr>
						<th>공공데이터명</th>
						<td colspan="3">
							<input type="text" name="infNm" style="width:200px; ime-mode:active;" value=""/>
							${sessionScope.button.btn_inquiry}
							${sessionScope.button.btn_xlsDown}       
						</td>
					</tr>
				</table>	
				</form>
					
				<!-- ibsheet 영역 -->
				<div class="ibsheet_area" style="height:600px;">
					<script type="text/javascript">createIBSheet("mySheet", "100%", "600px"); </script>             
				</div>
				
			</div>
		</div>
	</div>
</body>
</html>