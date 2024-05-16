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
<c:set var="downGubun" value="${downGubun}" />
<c:choose>
<c:when test="${downGubun == 'DIC'}">
<c:set var="downFilename" value="용어사전.xls" />
</c:when>
<c:when test="${downGubun == 'khaiNA'}">
<c:set var="downFilename" value="주택금융지수_주택구입부담지수(전체평균).xls" />
</c:when>
<c:when test="${downGubun == 'khaiLC'}">
<c:set var="downFilename" value="주택금융지수_주택구입부담지수(지역별).xls" />
</c:when>
<c:when test="${downGubun == 'khaiHS'}">
<c:set var="downFilename" value="주택금융지수_주택구입부담지수(주택규모별).xls" />
</c:when>
<c:when test="${downGubun == 'khoiNA'}">
<c:set var="downFilename" value="주택금융지수_주택구입물량지수(전체평균).xls" />
</c:when>
<c:when test="${downGubun == 'khoiLC'}">
<c:set var="downFilename" value="주택금융지수_주택구입물량지수(주택규모별).xls" />
</c:when>
<c:when test="${downGubun == 'API'}">
<c:set var="downFilename" value="OpenAPI_통계코드.xls" />
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
response.setHeader("Content-Disposition", Encodehelper.getDisposition(name, Encodehelper.getBrowser(request)));
response.setHeader("Content-Description","JSP Generated Data");
// 열기/저장 선택창이 뜨지않고 바로 저장되도록 함
response.setContentType("application/vnd.ms-excel;charset=UTF-8");
%>
</head>
<body>
<c:choose>
<c:when test="${downGubun == 'DIC'}">
	<!-- 용어사전 -->
	<table style="width: 1100px;border:1px solid #000000;">
	<colgroup>
			<col style="width:100px;">
			<col style="width:200px;">
			<col style="width:800px;">
	</colgroup>
	<thead>
		<tr>
			<th align="center" bgcolor='#CEFBC9' style='border:1px solid #d3d3d3;'>순번</th>
			<th align="center" bgcolor='#CEFBC9' style='border:1px solid #d3d3d3;'>용어</th>
			<th align="center" bgcolor='#CEFBC9' style='border:1px solid #d3d3d3;'>설명</th>
		</tr>
	</thead>
	<tfoot></tfoot>
	<tbody>
	<c:set var="num" value="1" />
	<c:forEach var="result" items="${result}" varStatus="status">
	<tr>
		<td style='text-align:center;border:1px solid #d3d3d3;'>${num}</td>
		<td style='text-align:left;border:1px solid #d3d3d3;''>${result.bbsTit}</td>
		<td style='text-align:left;border:1px solid #d3d3d3;''>${result.bbsCont}</td>
	</tr>
	<c:set var="num" value="${num+1}" />
	</c:forEach>
	</tbody>
	</table>
</c:when>
<c:when test="${downGubun == 'khaiNA'}">
	<!-- 주택금융지수_주택구입부담지수(전체평균) -->
	<table style="width: 1100px;border:1px solid #000000;">
	<colgroup>
			<col style="width:150px;">
			<col style="width:150px;">
			<col style="width:150px;">
	</colgroup>
	<thead>
		<tr>
			<th align="center" bgcolor='#CEFBC9' style='border:1px solid #d3d3d3;' rowspan='2'>시점</th>
			<th align="center" bgcolor='#CEFBC9' style='border:1px solid #d3d3d3;' colspan='2'>주택구입부담지수</th>
		</tr>
		<tr>
			<th align="center" bgcolor='#CEFBC9' style='border:1px solid #d3d3d3;'>지수</th>
			<th align="center" bgcolor='#CEFBC9' style='border:1px solid #d3d3d3;'>전기대비증감</th>
		</tr>
	</thead>
	<tfoot></tfoot>
	<tbody>
	<c:forEach var="result" items="${result}" varStatus="status">
		<c:if test="${result.ITM_ITM_NM eq '전국'}">
		<c:choose>
			<c:when test="${result.DTADVS_CD eq 'OD'}">
			<c:set var="xxValue" value='${result.XX}'/>			
			<tr>
			<td style='text-align:center;border:1px solid #d3d3d3;'>${result.YYYY} ${fn:substring(xxValue,1,2)}분기</td>
			<td style='text-align:right;border:1px solid #d3d3d3;'>${result.DTA_VAL}</td>
			</c:when>
			<c:when test="${result.DTADVS_CD eq 'PR'}">
			<td style='text-align:right;border:1px solid #d3d3d3;'>${result.DTA_VAL}</td>
			</tr>
			</c:when>
			<c:otherwise></c:otherwise>
		</c:choose>
		</c:if>
	</c:forEach>	
	</tbody>
	</table>
</c:when>
<c:when test="${downGubun == 'khaiLC'}">
	<!-- 주택금융지수_주택구입부담지수(지역별) -->
	<table style="width: 1100px;border:1px solid #000000;">
	<colgroup>
			<col style="width:150px;">
			<col style="width:150px;">
			<col style="width:150px;">
			<col style="width:150px;">
	</colgroup>
	<thead>
		<tr>
			<th align="center" bgcolor='#CEFBC9' style='border:1px solid #d3d3d3;'>시점</th>
			<th align="center" bgcolor='#CEFBC9' style='border:1px solid #d3d3d3;'>지역</th>
			<th align="center" bgcolor='#CEFBC9' style='border:1px solid #d3d3d3;'>지수</th>
			<th align="center" bgcolor='#CEFBC9' style='border:1px solid #d3d3d3;'>전기대비증감</th>
		</tr>
	</thead>
	<tfoot></tfoot>
	<tbody>
	<c:forEach var="result" items="${result}" varStatus="status">
		<c:choose>
			<c:when test="${result.DTADVS_CD eq 'OD'}">
			<c:set var="xxValue" value='${result.XX}'/>			
			<tr>
			<td style='text-align:center;border:1px solid #d3d3d3;'>${result.YYYY} ${fn:substring(xxValue,1,2)}분기</td>
			<td style='text-align:center;border:1px solid #d3d3d3;'>${result.ITM_ITM_NM}</td>
			<td style='text-align:right;border:1px solid #d3d3d3;'>${result.DTA_VAL}</td>
			</c:when>
			<c:when test="${result.DTADVS_CD eq 'PR'}">
			<td style='text-align:right;border:1px solid #d3d3d3;'>${result.DTA_VAL}</td>
			</tr>
			</c:when>
			<c:otherwise></c:otherwise>
		</c:choose>
	</c:forEach>	
	</tbody>
	</table>
</c:when>
<c:when test="${downGubun == 'khaiHS'}">
	<!-- 주택금융지수_주택구입부담지수(주택규모별) -->
	<table style="width: 1100px;border:1px solid #000000;">
	<colgroup>
			<col style="width:150px;">
			<col style="width:150px;">
			<col style="width:150px;">
			<col style="width:150px;">
			<col style="width:150px;">
	</colgroup>
	<thead>
		<tr>
			<th align="center" bgcolor='#CEFBC9' style='border:1px solid #d3d3d3;'>시점</th>
			<th align="center" bgcolor='#CEFBC9' style='border:1px solid #d3d3d3;'>60㎡ 이하</th>
			<th align="center" bgcolor='#CEFBC9' style='border:1px solid #d3d3d3;'>60 ~ 85㎡ 이하</th>
			<th align="center" bgcolor='#CEFBC9' style='border:1px solid #d3d3d3;'>85 ~ 135㎡ 이하</th>
			<th align="center" bgcolor='#CEFBC9' style='border:1px solid #d3d3d3;'>135㎡ 초과</th>
		</tr>
	</thead>
	<tfoot></tfoot>
	<tbody>
	<c:forEach var="result" items="${result}" varStatus="status">
		<c:if test="${result.ITM_ITM_NM eq '전국' && result.DTADVS_CD eq 'OD'}">
		<c:choose>
			<c:when test="${result.CLS_DATANO eq '50001'}">
			<c:set var="xxValue" value='${result.XX}'/>			
			<tr>
			<td style='text-align:center;border:1px solid #d3d3d3;'>${result.YYYY} ${fn:substring(xxValue,1,2)}분기</td>
			<td style='text-align:right;border:1px solid #d3d3d3;'>${result.DTA_VAL}</td>
			</c:when>
			<c:when test="${result.CLS_DATANO eq '50004'}">
			<td style='text-align:right;border:1px solid #d3d3d3;'>${result.DTA_VAL}</td>
			</tr>
			</c:when>
			<c:otherwise>
			<td style='text-align:right;border:1px solid #d3d3d3;'>${result.DTA_VAL}</td>
			</c:otherwise>
		</c:choose>
		</c:if>
	</c:forEach>	
	</tbody>
	</table>
</c:when>
<c:when test="${downGubun == 'khoiNA' || downGubun == 'khoiLC'}">
	<!-- 주택금융지수_주택구입물량지수(전체평균) || 주택금융지수_주택구입물량지수(주택규모별) -->
	<table style="width: 1100px;border:1px solid #000000;">
	<colgroup>
			<col style="width:100px;">
			<col style="width:60px;">
			<col style="width:60px;">
			<col style="width:60px;">
			<col style="width:60px;">
			<col style="width:60px;">
			<col style="width:60px;">
			<col style="width:60px;">
			<col style="width:60px;">
			<col style="width:60px;">
			<col style="width:60px;">
			<col style="width:60px;">
			<col style="width:60px;">
			<col style="width:60px;">
			<col style="width:60px;">
			<col style="width:60px;">
			<col style="width:60px;">
			<col style="width:60px;">
	</colgroup>
	<thead>
		<tr>
			<th align="center" bgcolor='#CEFBC9' style='border:1px solid #d3d3d3;'>연도말</th>
			<th align="center" bgcolor='#CEFBC9' style='border:1px solid #d3d3d3;'>전국</th>
			<th align="center" bgcolor='#CEFBC9' style='border:1px solid #d3d3d3;'>서울</th>
			<th align="center" bgcolor='#CEFBC9' style='border:1px solid #d3d3d3;'>부산</th>
			<th align="center" bgcolor='#CEFBC9' style='border:1px solid #d3d3d3;'>대구</th>
			<th align="center" bgcolor='#CEFBC9' style='border:1px solid #d3d3d3;'>인천</th>
			<th align="center" bgcolor='#CEFBC9' style='border:1px solid #d3d3d3;'>광주</th>
			<th align="center" bgcolor='#CEFBC9' style='border:1px solid #d3d3d3;'>대전</th>
			<th align="center" bgcolor='#CEFBC9' style='border:1px solid #d3d3d3;'>울산</th>
			<th align="center" bgcolor='#CEFBC9' style='border:1px solid #d3d3d3;'>경기</th>
			<th align="center" bgcolor='#CEFBC9' style='border:1px solid #d3d3d3;'>강원</th>
			<th align="center" bgcolor='#CEFBC9' style='border:1px solid #d3d3d3;'>충북</th>
			<th align="center" bgcolor='#CEFBC9' style='border:1px solid #d3d3d3;'>충남</th>
			<th align="center" bgcolor='#CEFBC9' style='border:1px solid #d3d3d3;'>전북</th>
			<th align="center" bgcolor='#CEFBC9' style='border:1px solid #d3d3d3;'>전남</th>
			<th align="center" bgcolor='#CEFBC9' style='border:1px solid #d3d3d3;'>경북</th>
			<th align="center" bgcolor='#CEFBC9' style='border:1px solid #d3d3d3;'>경남</th>
			<th align="center" bgcolor='#CEFBC9' style='border:1px solid #d3d3d3;'>제주</th>
		</tr>
	</thead>
	<tfoot></tfoot>
	<tbody>
	<c:forEach var="result" items="${result}" varStatus="status">
		<c:if test="${result.DTADVS_CD eq 'OD'}">
		<c:choose>
			<c:when test="${result.ITM_DATANO eq '10001'}">
			<c:set var="xxValue" value='${result.XX}'/>			
			<tr>
			<td style='text-align:center;border:1px solid #d3d3d3;'>${result.YYYY}년</td>
			<td style='text-align:right;border:1px solid #d3d3d3;'>${result.DTA_VAL}</td>
			</c:when>
			<c:when test="${result.CLS_DATANO eq '10017'}">
			<td style='text-align:right;border:1px solid #d3d3d3;'>${result.DTA_VAL}</td>
			</tr>
			</c:when>
			<c:otherwise>
			<td style='text-align:right;border:1px solid #d3d3d3;'>${result.DTA_VAL}</td>
			</c:otherwise>
		</c:choose>
		</c:if>
	</c:forEach>	
	</tbody>
	</table>
</c:when>
<c:when test="${downGubun == 'API'}">
	<!-- OpenAPI_통계코드 -->
	<table style="width: 1100px;border:1px solid #000000;">
	<colgroup>
			<col style="width:100px;">
			<col style="width:300px;">
			<col style="width:200px;">
	</colgroup>
	<thead>
		<tr>
			<th align="center" bgcolor='#CEFBC9' style='border:1px solid #d3d3d3;'>번호</th>
			<th align="center" bgcolor='#CEFBC9' style='border:1px solid #d3d3d3;'>통계표명</th>
			<th align="center" bgcolor='#CEFBC9' style='border:1px solid #d3d3d3;'>통계표코드</th>
		</tr>
	</thead>
	<tfoot></tfoot>
	<tbody>
	<c:set var="num" value="1" />
	<c:forEach var="result" items="${result}" varStatus="status">
	<c:if test="${result.statblTag eq 'T'}">
	<tr>
		<td style='text-align:center;border:1px solid #d3d3d3;'>${num}</td>
		<td style='text-align:left;border:1px solid #d3d3d3;''>${result.statblNm}</td>
		<td style='text-align:left;border:1px solid #d3d3d3;''>${result.statblId}</td>
	</tr>
	<c:set var="num" value="${num+1}" />
	</c:if>
	</c:forEach>
	</tbody>
	</table>
</c:when>
<c:otherwise>
	<table style="width: 1100px;border:1px solid #000000;">
	<colgroup>
			<col style="width:180px;">
			<col style="width:920px;">
	</colgroup>
	<thead>
		<tr>
			<th align="center" bgcolor='#CEFBC9' style='border:1px solid #d3d3d3;'>엑셀</th>
			<th align="center" bgcolor='#CEFBC9' style='border:1px solid #d3d3d3;'>다운로드</th>
		</tr>
	</thead>
	<tfoot></tfoot>
	<tbody>
	</tbody>
	</table>
</c:otherwise>
</c:choose>
</body>
</html>