<%@ page language="java" contentType="application/vnd.ms-excel; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="egovframework.common.WiseOpenConfig"%>
<%@ page import="egovframework.common.helper.Encodehelper"%>
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
<c:set var="contextPath" 	value="${pageContext.request.contextPath }"></c:set>  
<c:set var="serverNm" 		value="${pageContext.request.serverName }"></c:set>
<c:set var="serverPort" 	value="${pageContext.request.serverPort }"></c:set>
<c:set var="levelBlank" 	value="&nbsp;&nbsp;&nbsp;&nbsp;"></c:set>  
<%
String name = "정보카탈로그-전체목록.xls";
response.reset();
response.setHeader("Content-Disposition", Encodehelper.getDisposition(name, Encodehelper.getBrowser(request)));
response.setHeader("Content-Description","JSP Generated Data");
// 열기/저장 선택창이 뜨지않고 바로 저장되도록 함
response.setContentType("application/vnd.ms-excel;charset=UTF-8");
%>
</head>
<body>
<table style="width: 1300px;border:1px solid #000000;">
<colgroup>
		<col style="width:180px;">
		<col style="width:920px;">
</colgroup>
<thead>
	<tr>
		<th align="center" bgcolor='#CEFBC9' style='border:1px solid #d3d3d3;10%'>레벨</th>
		<th align="center" bgcolor='#CEFBC9' style='border:1px solid #d3d3d3;'>정보명</th>
		<th align="center" bgcolor='#CEFBC9' style='border:1px solid #d3d3d3;'>정보셋조회</th>
		<th align="center" bgcolor='#CEFBC9' style='border:1px solid #d3d3d3;'>경로</th>
	</tr>
</thead>
<tfoot></tfoot>
<tbody>
<c:forEach var="result" items="${result}" varStatus="status">
<tr>
	<td style='text-align:right;border:1px solid #d3d3d3;width:100px;'>${result.Level}</td>
	<td style='text-align:left;border:1px solid #d3d3d3;width:600px;'>
		<c:if test="${result.Level > 1 }">
			<c:forEach begin="1" end="${result.Level -1 }">
				${levelBlank}
			</c:forEach>
			└
		</c:if>
		<c:choose>
			<c:when test="${result.gubunTag eq 'C'}">
				<b>[ ${result.infoNm} ]</b>
			</c:when>
			<c:otherwise>
				${result.infoNm}
			</c:otherwise>
		</c:choose>
	</td>
	<td style='text-align:center;border:1px solid #d3d3d3;'>
		<c:if test="${result.gubunTag eq 'T' }">
			<a href='http://${serverNm}<c:if test="${serverPort ne '' }">:${serverPort }</c:if>/portal/nadata/catalog/naDataCatalogPage.do?infoId=${result.infoId}'>바로가기</a>
		</c:if>
	</td>
	<td style='text-align:left;border:1px solid #d3d3d3;width:700px;'>${result.fullPath }</td>
</tr>
</c:forEach>
</tbody>
</table>
</body>
</html>