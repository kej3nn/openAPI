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
<c:set var="serverNm" 	value="${pageContext.request.serverName }"></c:set>
<c:set var="serverPort" 	value="${pageContext.request.serverPort }"></c:set>
<c:set var="levelBlank" 	value="&nbsp;&nbsp;&nbsp;&nbsp;"></c:set>  
<c:set var="pageType" 	value="${pageType}" />
<c:choose>
<c:when test="${pageType == 'SP'}">
<c:set var="downFilename" value="타사이트 제공 API 목록.xls" />
</c:when>
<c:when test="${pageType == 'GD'}">
<c:set var="downFilename" value="활용가이드.xls" />
</c:when>
<c:otherwise>
<c:set var="downFilename" value="ExcelFile.xls" />
</c:otherwise>
</c:choose>
<%
String name = (String)pageContext.getAttribute("downFilename");
//String downFileName = new String(name.getBytes("euc-kr"), "8859_1"); //서버반영시 한글문제발생으로 제외처리
response.reset();
//response.setHeader("Content-Disposition","attachment;filename="+downFileName);
//response.setHeader("Content-Disposition","attachment;filename="+name);
response.setHeader("Content-Disposition", Encodehelper.getDisposition(name, Encodehelper.getBrowser(request)));
response.setHeader("Content-Description","JSP Generated Data");
// 열기/저장 선택창이 뜨지않고 바로 저장되도록 함
response.setContentType("application/vnd.ms-excel;charset=UTF-8");
%>
</head>
<body>
<table style="width: 1000px;border:1px solid #000000;">
<c:choose>
<c:when test="${pageType == 'SP'}">
<colgroup>
		<col style="width:80px;">
		<col style="width:200px;">
		<col style="width:200px;">
		<col style="width:150px;">
		<col style="width:200px;">
</colgroup>
<thead>
	<tr>
		<th align="center" bgcolor='#CEFBC9' style='border:1px solid #d3d3d3;'>NO</th>
		<th align="center" bgcolor='#CEFBC9' style='border:1px solid #d3d3d3;'>기관</th>
		<th align="center" bgcolor='#CEFBC9' style='border:1px solid #d3d3d3;'>API명</th>
		<th align="center" bgcolor='#CEFBC9' style='border:1px solid #d3d3d3;'>구분</th>
		<th align="center" bgcolor='#CEFBC9' style='border:1px solid #d3d3d3;'>URL</th>
	</tr>
</thead>
<tfoot></tfoot>
<tbody>
<c:forEach var="result" items="${result}" varStatus="status">
<tr>
	<td style='text-align:center;border:1px solid #d3d3d3;width:100px;'>${status.count}</td>
	<td style='text-align:center;border:1px solid #d3d3d3;width:100px;'>${result.orgNm}</td>
	<td style='text-align:center;border:1px solid #d3d3d3;width:100px;'>${result.apiNm}</td>
	<td style='text-align:center;border:1px solid #d3d3d3;width:100px;'>${result.apiTagNm}</td>
	<td style='text-align:center;border:1px solid #d3d3d3;width:100px;'>
	<c:if test="${result.apiUrl != null}"><a href='${result.apiUrl}' target=_blank>[바로가기]</a><br /></c:if>
	</td>
	
</tr>
</c:forEach>
</c:when>
<c:when test="${pageType == 'GD'}">
<colgroup>
		<col style="width:80px;">
		<col style="width:200px;">
		<col style="width:80px;">
		<col style="width:90px;">
</colgroup>
<thead>
	<tr>
		<th align="center" bgcolor='#CEFBC9' style='border:1px solid #d3d3d3;'>NO</th>
		<th align="center" bgcolor='#CEFBC9' style='border:1px solid #d3d3d3;'>제목</th>
		<th align="center" bgcolor='#CEFBC9' style='border:1px solid #d3d3d3;'>작성자</th>
		<th align="center" bgcolor='#CEFBC9' style='border:1px solid #d3d3d3;'>작성일</th>
		<th align="center" bgcolor='#CEFBC9' style='border:1px solid #d3d3d3;'>조회수</th>
	</tr>
</thead>
<tfoot></tfoot>
<tbody>
<c:forEach var="result" items="${result}" varStatus="status">
<tr>
	<td style='text-align:center;border:1px solid #d3d3d3;width:100px;'>${status.count}</td>
	<td style='text-align:left;border:1px solid #d3d3d3;width:100px;'>${result.BBS_TIT}</td>
	<td style='text-align:center;border:1px solid #d3d3d3;width:100px;'>${result.USER_NM}</td>
	<td style='text-align:center;border:1px solid #d3d3d3;width:100px;mso-number-format:yyyy\\-mm\\-dd;'>${result.USER_DTTM}</td>
	<td style='text-align:center;border:1px solid #d3d3d3;width:100px;'>${result.VIEW_CNT}</td>
</tr>
</c:forEach>
</c:when>
<c:otherwise>
</c:otherwise>
</c:choose>
</tbody>
</table>
</body>
</html>