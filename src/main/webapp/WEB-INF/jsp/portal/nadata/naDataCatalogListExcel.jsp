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
String name = "정보카탈로그-검색리스트-목록.xls";
response.reset();
response.setHeader("Content-Disposition", Encodehelper.getDisposition(name, Encodehelper.getBrowser(request)));
response.setHeader("Content-Description","JSP Generated Data");
// 열기/저장 선택창이 뜨지않고 바로 저장되도록 함
response.setContentType("application/vnd.ms-excel;charset=UTF-8");
%>
</head>
<body>
<table style="width: 1560px;border:1px solid #000000;">
<colgroup>
		<col style="width:100px;">
		<col style="width:350px;">
		<col style="width:350px;">
		<col style="width:180px;">
		<col style="width:180px;">
		<col style="width:250px;">
		<col style="width:150px;">
</colgroup>
<thead>
	<tr>
		<th align="center" bgcolor='#CEFBC9' style='border:1px solid #d3d3d3;10%'>번호</th>
		<th align="center" bgcolor='#CEFBC9' style='border:1px solid #d3d3d3;'>정보명</th>
		<th align="center" bgcolor='#CEFBC9' style='border:1px solid #d3d3d3;'>분류</th>
		<th align="center" bgcolor='#CEFBC9' style='border:1px solid #d3d3d3;'>관리기관</th>
		<th align="center" bgcolor='#CEFBC9' style='border:1px solid #d3d3d3;'>서비스유형</th>
		<th align="center" bgcolor='#CEFBC9' style='border:1px solid #d3d3d3;'>출처시스템</th>
		<th align="center" bgcolor='#CEFBC9' style='border:1px solid #d3d3d3;'>바로가기 URL</th>
	</tr>
</thead>
<tfoot></tfoot>
<tbody>
<c:forEach var="result" items="${result}" varStatus="status">
<tr>
	<td style='text-align:center;border:1px solid #d3d3d3;width:100px;'>${status.index+1}</td>
	<td style='text-align:left;border:1px solid #d3d3d3;width:100px;'>${result.infoNm}</td>
	<td style='text-align:left;border:1px solid #d3d3d3;width:100px;'>${result.cateFullnm}</td>
	<td style='text-align:center;border:1px solid #d3d3d3;width:100px;'>${result.orgNm}</td>
	<td style='text-align:center;border:1px solid #d3d3d3;width:100px;'>${result.srvInfoNm}</td>
	<td style='text-align:center;border:1px solid #d3d3d3;width:100px;'>${result.srcSysNm}</td>
	<td style='text-align:center;border:1px solid #d3d3d3;'>
		<a href='${result.srcUrl}'>바로가기</a>
	</td>
</tr>
</c:forEach>
</tbody>
</table>
</body>
</html>