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
<c:when test="${pageType == 'TT'}">
<c:set var="downFilename" value="총수입·총지출 심사연혁.xls" />
</c:when>
<c:when test="${pageType == 'GS'}">
<c:set var="downFilename" value="세입·세출예산 심사연혁.xls" />
</c:when>
<c:when test="${pageType == 'GSDTL'}">
	<c:choose>
	<c:when test="${tgCd == 'IN'}">
	<c:set var="downFilename" value="세입·세출예산 심사연혁_세입조정내역.xls" />
	</c:when>
	<c:otherwise>
	<c:set var="downFilename" value="세입·세출예산 심사연혁_세출조정내역.xls" />
	</c:otherwise>
	</c:choose>
</c:when>
<c:when test="${pageType == 'FD'}">
<c:set var="downFilename" value="기금운용계획 심사연혁.xls" />
</c:when>
<c:when test="${pageType == 'FDDTL'}">
	<c:choose>
	<c:when test="${tgCd == 'IN'}">
	<c:set var="downFilename" value="기금운용계획 심사연혁_수입조정내역.xls" />
	</c:when>
	<c:otherwise>
	<c:set var="downFilename" value="기금운용계획 심사연혁_지출조정내역.xls" />
	</c:otherwise>
	</c:choose>
</c:when>
<c:when test="${pageType == 'SS'}">
<c:set var="downFilename" value="예산부대의견.xls" />
</c:when>
<c:when test="${pageType == 'LD'}">
<c:set var="downFilename" value="결산 시정요구.xls" />
</c:when>
<c:when test="${pageType == 'LD2'}">
<c:set var="downFilename" value="결산 조치결과.xls" />
</c:when>
<c:when test="${pageType == 'NABOC'}">
<c:set var="downFilename" value="결산시정요구.xls" />
</c:when>
<c:when test="${pageType == 'NABOI'}">
<c:set var="downFilename" value="부대의견.xls" />
</c:when>
<c:when test="${pageType == 'NABOQ'}">
<c:set var="downFilename" value="감사청구.xls" />
</c:when>
<c:otherwise>
<c:set var="downFilename" value="ExcelFile.xls" />
</c:otherwise>
</c:choose>
<%
String name = (String)pageContext.getAttribute("downFilename");
response.reset();
response.setHeader("Content-Disposition", Encodehelper.getDisposition(name, Encodehelper.getBrowser(request)));
response.setHeader("Content-Description","JSP Generated Data");
// 열기/저장 선택창이 뜨지않고 바로 저장되도록 함
response.setContentType("application/vnd.ms-excel;charset=UTF-8");
%>
</head>
<body>
<table style="width: 1000px;border:1px solid #000000;">
<c:choose>
<c:when test="${pageType == 'TT'}">
<colgroup>
		<col style="width:100px;">
		<col style="width:100px;">
		<col style="width:100px;">
		<col style="width:150px;">
		<col style="width:150px;">
		<col style="width:150px;">
		<col style="width:150px;">
		<col style="width:150px;">
		<col style="width:150px;">
		<col style="width:150px;">
		<col style="width:150px;">
		<col style="width:150px;">
</colgroup>
<thead>
	<tr>
		<th align="center" bgcolor='#CEFBC9' style='border:1px solid #d3d3d3;10%'>연도</th>
		<th align="center" bgcolor='#CEFBC9' style='border:1px solid #d3d3d3;'>구분1</th>
		<th align="center" bgcolor='#CEFBC9' style='border:1px solid #d3d3d3;'>구분2</th>
		<th align="center" bgcolor='#CEFBC9' style='border:1px solid #d3d3d3;'>정부안</th>
		<th align="center" bgcolor='#CEFBC9' style='border:1px solid #d3d3d3;'>증액</th>
		<th align="center" bgcolor='#CEFBC9' style='border:1px solid #d3d3d3;'>증액비율</th>
		<th align="center" bgcolor='#CEFBC9' style='border:1px solid #d3d3d3;'>감액</th>		
		<th align="center" bgcolor='#CEFBC9' style='border:1px solid #d3d3d3;'>감액비율</th>
		<th align="center" bgcolor='#CEFBC9' style='border:1px solid #d3d3d3;'>순수정액</th>		
		<th align="center" bgcolor='#CEFBC9' style='border:1px solid #d3d3d3;'>순수정비율</th>
		<th align="center" bgcolor='#CEFBC9' style='border:1px solid #d3d3d3;'>총수정비율</th>
		<th align="center" bgcolor='#CEFBC9' style='border:1px solid #d3d3d3;'>국회확정</th>
	</tr>
</thead>
<tfoot></tfoot>
<tbody>
<c:forEach var="result" items="${result}" varStatus="status">
<tr>
	<td style='text-align:center;border:1px solid #d3d3d3;width:100px;'>${result.dataYy}</td>
	<td style='text-align:center;border:1px solid #d3d3d3;width:100px;'>${result.budgetTagNm}</td>
	<td style='text-align:center;border:1px solid #d3d3d3;width:100px;'>${result.revspdTagNm}</td>
	<td style='text-align:right;border:1px solid #d3d3d3;width:100px;'>${result.govAmt}</td>
	<td style='text-align:right;border:1px solid #d3d3d3;width:100px;'>${result.incAmt}</td>
	<td style='text-align:right;border:1px solid #d3d3d3;width:100px;'>${result.incRate}</td>
	<td style='text-align:right;border:1px solid #d3d3d3;width:100px;'>${result.decAmt}</td>
	<td style='text-align:right;border:1px solid #d3d3d3;width:100px;'>${result.decRate}</td>
	<td style='text-align:right;border:1px solid #d3d3d3;width:100px;'>${result.pmodAmt}</td>
	<td style='text-align:right;border:1px solid #d3d3d3;width:100px;'>${result.pmodRate}</td>
	<td style='text-align:right;border:1px solid #d3d3d3;width:100px;'>${result.tmodRate}</td>
	<td style='text-align:right;border:1px solid #d3d3d3;width:100px;'>${result.nbAmt}</td>
</tr>
</c:forEach>
</c:when>
<c:when test="${pageType == 'GS' || pageType == 'FD'}">
<colgroup>
		<col style="width:100px;">
		<col style="width:100px;">
		<col style="width:100px;">
		<col style="width:150px;">
		<col style="width:150px;">
		<col style="width:150px;">
		<col style="width:150px;">
		<col style="width:150px;">
</colgroup>
<thead>
	<tr>
		<th align="center" bgcolor='#CEFBC9' style='border:1px solid #d3d3d3;10%'>연도</th>
		<th align="center" bgcolor='#CEFBC9' style='border:1px solid #d3d3d3;'>구분1</th>
		<th align="center" bgcolor='#CEFBC9' style='border:1px solid #d3d3d3;'>구분2</th>
		<th align="center" bgcolor='#CEFBC9' style='border:1px solid #d3d3d3;'>구분3</th>
		<th align="center" bgcolor='#CEFBC9' style='border:1px solid #d3d3d3;'>정부안</th>
		<th align="center" bgcolor='#CEFBC9' style='border:1px solid #d3d3d3;'>증액</th>
		<th align="center" bgcolor='#CEFBC9' style='border:1px solid #d3d3d3;'>감액</th>
		<th align="center" bgcolor='#CEFBC9' style='border:1px solid #d3d3d3;'>국회확정</th>
		<th align="center" bgcolor='#CEFBC9' style='border:1px solid #d3d3d3;'>관련정보</th>
	</tr>
</thead>
<tfoot></tfoot>
<tbody>
<c:forEach var="result" items="${result}" varStatus="status">
<tr>
	<td style='text-align:center;border:1px solid #d3d3d3;width:100px;'>${result.dataYy}</td>
	<td style='text-align:center;border:1px solid #d3d3d3;width:100px;'>${result.budgetTagNm}</td>
	<td style='text-align:center;border:1px solid #d3d3d3;width:100px;'>${result.fiscalTagNm}</td>
	<td style='text-align:center;border:1px solid #d3d3d3;width:100px;'>${result.revspdTagNm}</td>
	<td style='text-align:right;border:1px solid #d3d3d3;width:100px;'>${result.govAmt}</td>
	<td style='text-align:right;border:1px solid #d3d3d3;width:100px;'>${result.incAmt}</td>
	<td style='text-align:right;border:1px solid #d3d3d3;width:100px;'>${result.decAmt}</td>
	<td style='text-align:right;border:1px solid #d3d3d3;width:100px;'>${result.nbAmt}</td>
	<td style='text-align:center;border:1px solid #d3d3d3;width:100px;'>
		<c:if test="${result.plnyModUrl != null}"><a href='${result.plnyModUrl}' target=_blank>[심사보고서]</a><br /></c:if>
		<c:if test="${result.exmRptUrl != null}"><a href='${result.exmRptUrl}' target=_blank>[본회의수정안]</a><br /></c:if>
		<c:if test="${result.metRetUrl != null}"><a href='${result.metRetUrl}' target=_blank>[회의록]</a><br /></c:if>
	</td>
</tr>
</c:forEach>
</c:when>
<c:when test="${pageType == 'GSDTL' || pageType == 'FDDTL'}">
<c:choose>
<c:when test="${tgCd == 'IN'}">
<colgroup>
		<col style="width:100px;">
		<col style="width:100px;">
		<col style="width:100px;">
		<col style="width:150px;">
		<col style="width:150px;">
		<col style="width:150px;">
		<col style="width:150px;">
		<col style="width:150px;">
		<col style="width:150px;">
		<col style="width:150px;">
		<col style="width:150px;">
		<col style="width:150px;">
</colgroup>
<thead>
	<tr>
		<th align="center" bgcolor='#CEFBC9' style='border:1px solid #d3d3d3;'>연도</th>
		<th align="center" bgcolor='#CEFBC9' style='border:1px solid #d3d3d3;'>구분1</th>
		<th align="center" bgcolor='#CEFBC9' style='border:1px solid #d3d3d3;'>구분2</th>
		<th align="center" bgcolor='#CEFBC9' style='border:1px solid #d3d3d3;'>회계기금명</th>
		<th align="center" bgcolor='#CEFBC9' style='border:1px solid #d3d3d3;'>소관기관</th>
		<th align="center" bgcolor='#CEFBC9' style='border:1px solid #d3d3d3;'>관</th>
		<th align="center" bgcolor='#CEFBC9' style='border:1px solid #d3d3d3;'>항</th>
		<th align="center" bgcolor='#CEFBC9' style='border:1px solid #d3d3d3;'>목</th>
		<th align="center" bgcolor='#CEFBC9' style='border:1px solid #d3d3d3;'>본예산국회확정</th>
		<th align="center" bgcolor='#CEFBC9' style='border:1px solid #d3d3d3;'>정부안</th>
		<th align="center" bgcolor='#CEFBC9' style='border:1px solid #d3d3d3;'>국회확정</th>
		<th align="center" bgcolor='#CEFBC9' style='border:1px solid #d3d3d3;'>조정액(증감액)</th>
	</tr>
</thead>
<tfoot></tfoot>
<tbody>
<c:forEach var="result" items="${result}" varStatus="status">
<tr>
	<td style='text-align:center;border:1px solid #d3d3d3;'>${result.dataYy}</td>
	<td style='text-align:center;border:1px solid #d3d3d3;'>${result.budgetTagNm}</td>
	<td style='text-align:center;border:1px solid #d3d3d3;'>${result.fiscalTagNm}</td>
	<td style='text-align:center;border:1px solid #d3d3d3;'>${result.accNm}</td>
	<td style='text-align:center;border:1px solid #d3d3d3;'>${result.jurNm}</td>
	<td style='text-align:center;border:1px solid #d3d3d3;'>${result.catNm}</td>
	<td style='text-align:center;border:1px solid #d3d3d3;'>${result.secNm}</td>
	<td style='text-align:center;border:1px solid #d3d3d3;'>${result.pgmNm}</td>
	<td style='text-align:right;border:1px solid #d3d3d3;'>${result.mbgtNbAmt}</td>
	<td style='text-align:right;border:1px solid #d3d3d3;'>${result.govAmt}</td>
	<td style='text-align:right;border:1px solid #d3d3d3;'>${result.nbAmt}</td>
	<td style='text-align:right;border:1px solid #d3d3d3;'>${result.incdecAmt}</td>
</tr>
</c:forEach>	
</c:when>
<c:otherwise>
<colgroup>
		<col style="width:100px;">
		<col style="width:100px;">
		<col style="width:100px;">
		<col style="width:150px;">
		<col style="width:150px;">
		<col style="width:150px;">
		<col style="width:150px;">
		<col style="width:150px;">
		<col style="width:150px;">
		<col style="width:150px;">
		<col style="width:150px;">
		<col style="width:150px;">
		<col style="width:150px;">
		<col style="width:150px;">
</colgroup>
<thead>
	<tr>
		<th align="center" bgcolor='#CEFBC9' style='border:1px solid #d3d3d3;'>연도</th>
		<th align="center" bgcolor='#CEFBC9' style='border:1px solid #d3d3d3;'>구분1</th>
		<th align="center" bgcolor='#CEFBC9' style='border:1px solid #d3d3d3;'>구분2</th>
		<th align="center" bgcolor='#CEFBC9' style='border:1px solid #d3d3d3;'>회계기금명</th>
		<th align="center" bgcolor='#CEFBC9' style='border:1px solid #d3d3d3;'>소관기관</th>
		<th align="center" bgcolor='#CEFBC9' style='border:1px solid #d3d3d3;'>분야</th>
		<th align="center" bgcolor='#CEFBC9' style='border:1px solid #d3d3d3;'>부문</th>
		<th align="center" bgcolor='#CEFBC9' style='border:1px solid #d3d3d3;'>프로그램</th>
		<th align="center" bgcolor='#CEFBC9' style='border:1px solid #d3d3d3;'>단위사업</th>
		<th align="center" bgcolor='#CEFBC9' style='border:1px solid #d3d3d3;'>세부사업</th>
		<th align="center" bgcolor='#CEFBC9' style='border:1px solid #d3d3d3;'>본예산국회확정</th>
		<th align="center" bgcolor='#CEFBC9' style='border:1px solid #d3d3d3;'>정부안</th>
		<th align="center" bgcolor='#CEFBC9' style='border:1px solid #d3d3d3;'>국회확정</th>
		<th align="center" bgcolor='#CEFBC9' style='border:1px solid #d3d3d3;'>조정액(증감액)</th>
	</tr>
</thead>
<tfoot></tfoot>
<tbody>
<c:forEach var="result" items="${result}" varStatus="status">
<tr>
	<td style='text-align:center;border:1px solid #d3d3d3;'>${result.dataYy}</td>
	<td style='text-align:center;border:1px solid #d3d3d3;'>${result.budgetTagNm}</td>
	<td style='text-align:center;border:1px solid #d3d3d3;'>${result.fiscalTagNm}</td>
	<td style='text-align:center;border:1px solid #d3d3d3;'>${result.accNm}</td>
	<td style='text-align:center;border:1px solid #d3d3d3;'>${result.jurNm}</td>
	<td style='text-align:center;border:1px solid #d3d3d3;'>${result.catNm}</td>
	<td style='text-align:center;border:1px solid #d3d3d3;'>${result.secNm}</td>
	<td style='text-align:center;border:1px solid #d3d3d3;'>${result.pgmNm}</td>
	<td style='text-align:center;border:1px solid #d3d3d3;'>${result.bizNm}</td>
	<td style='text-align:center;border:1px solid #d3d3d3;'>${result.dbizNm}</td>
	<td style='text-align:right;border:1px solid #d3d3d3;'>${result.mbgtNbAmt}</td>
	<td style='text-align:right;border:1px solid #d3d3d3;'>${result.govAmt}</td>
	<td style='text-align:right;border:1px solid #d3d3d3;'>${result.nbAmt}</td>
	<td style='text-align:right;border:1px solid #d3d3d3;'>${result.incdecAmt}</td>
</tr>
</c:forEach>
</c:otherwise>
</c:choose>
</c:when>
<c:when test="${pageType == 'SS'}">
<colgroup>
		<col style="width:100px;">
		<col style="width:100px;">
		<col style="width:200px;">
		<col style="width:600px;">
</colgroup>
<thead>
	<tr>
		<th align="center" bgcolor='#CEFBC9' style='border:1px solid #d3d3d3;'>연도</th>
		<th align="center" bgcolor='#CEFBC9' style='border:1px solid #d3d3d3;'>구분</th>
		<th align="center" bgcolor='#CEFBC9' style='border:1px solid #d3d3d3;'>소관기관</th>
		<th align="center" bgcolor='#CEFBC9' style='border:1px solid #d3d3d3;'>예산부대의견</th>
	</tr>
</thead>
<tfoot></tfoot>
<tbody>
<c:forEach var="result" items="${result}" varStatus="status">
<tr>
	<td style='text-align:center;border:1px solid #d3d3d3;'>${result.listSubNm}</td>
	<td style='text-align:center;border:1px solid #d3d3d3;'>${result.list1SubNm}</td>
	<td style='text-align:center;border:1px solid #d3d3d3;'>${result.tgtOrgNm}</td>
	<td style='text-align:left;border:1px solid #d3d3d3;'>${result.bbsCont}</td>
</tr>
</c:forEach>
</c:when>

<c:when test="${pageType == 'LD'}">
<colgroup>
		<col style="width:100px;">
		<col style="width:200px;">
		<col style="width:100px;">
		<col style="width:100px;">
		<col style="width:100px;">
		<col style="width:100px;">
		<col style="width:100px;">
		<col style="width:100px;">
		<col style="width:100px;">
</colgroup>
<thead>
	<tr>
		<th align="center" bgcolor='#CEFBC9' style='border:1px solid #d3d3d3;10%'>회계연도</th>
		<th align="center" bgcolor='#CEFBC9' style='border:1px solid #d3d3d3;'>위원회</th>
		<th align="center" bgcolor='#CEFBC9' style='border:1px solid #d3d3d3;'>변상</th>
		<th align="center" bgcolor='#CEFBC9' style='border:1px solid #d3d3d3;'>징계</th>
		<th align="center" bgcolor='#CEFBC9' style='border:1px solid #d3d3d3;'>시정</th>
		<th align="center" bgcolor='#CEFBC9' style='border:1px solid #d3d3d3;'>주의</th>
		<th align="center" bgcolor='#CEFBC9' style='border:1px solid #d3d3d3;'>제도개선</th>
		<th align="center" bgcolor='#CEFBC9' style='border:1px solid #d3d3d3;'>중복</th>
		<th align="center" bgcolor='#CEFBC9' style='border:1px solid #d3d3d3;'>합계</th>
	</tr>
</thead>
<tfoot></tfoot>
<tbody>
<c:forEach var="result" items="${result}" varStatus="status">
<tr>
	<td style='text-align:center;border:1px solid #d3d3d3;width:100px;'>${result.dataYy}</td>
	<td style='text-align:left;border:1px solid #d3d3d3;width:200px;'>${result.cmteNm}</td>
	<td style='text-align:right;border:1px solid #d3d3d3;width:100px;'>${result.cpstCnt}</td>
	<td style='text-align:right;border:1px solid #d3d3d3;width:100px;'>${result.dcpnCnt}</td>
	<td style='text-align:right;border:1px solid #d3d3d3;width:100px;'>${result.cortCnt}</td>
	<td style='text-align:right;border:1px solid #d3d3d3;width:100px;'>${result.careCnt}</td>
	<td style='text-align:right;border:1px solid #d3d3d3;width:100px;'>${result.ipmtCnt}</td>
	<td style='text-align:right;border:1px solid #d3d3d3;width:100px;'>${result.dpctCnt}</td>
	<td style='text-align:right;border:1px solid #d3d3d3;width:100px;'>${result.sumCnt}</td>
</tr>
</c:forEach>
</c:when>

<c:when test="${pageType == 'LD2'}">
<colgroup>
		<col style="width:150px;">
		<col style="width:200px;">
		<col style="width:100px;">
		<col style="width:100px;">
		<col style="width:100px;">
		<col style="width:100px;">
</colgroup>
<thead>
	<tr>
		<th align="center" bgcolor='#CEFBC9' style='border:1px solid #d3d3d3;10%' rowspan='2'>회계년도</th>
		<th align="center" bgcolor='#CEFBC9' style='border:1px solid #d3d3d3;10%' rowspan='2'>위원회(부처)</th>
		<th align="center" bgcolor='#CEFBC9' style='border:1px solid #d3d3d3;' colspan='4'>합계</th>
	</tr>
	<tr>
		<th align="center" bgcolor='#CEFBC9' style='border:1px solid #d3d3d3;'>계</th>
		<th align="center" bgcolor='#CEFBC9' style='border:1px solid #d3d3d3;'>조치완료</th>
		<th align="center" bgcolor='#CEFBC9' style='border:1px solid #d3d3d3;'>조치중</th>
		<th align="center" bgcolor='#CEFBC9' style='border:1px solid #d3d3d3;'>조치율</th>
	</tr>
</thead>
<tfoot></tfoot>
<tbody>
<c:forEach var="result" items="${result}" varStatus="status">
<tr>
	<td style='text-align:center;border:1px solid #d3d3d3;width:150px;'>${result.dataYy}</td>
	<td style='text-align:left;border:1px solid #d3d3d3;width:200px;'>${result.cmteNm}</td>
	<td style='text-align:right;border:1px solid #d3d3d3;width:100px;'>${result.totCnt}</td>
	<td style='text-align:right;border:1px solid #d3d3d3;width:100px;'>${result.actnCmplCnt}</td>
	<td style='text-align:right;border:1px solid #d3d3d3;width:100px;'>${result.actnProcCnt}</td>
	<td style='text-align:right;border:1px solid #d3d3d3;width:100px;'>${result.actnRto}</td>
</tr>
</c:forEach>
</c:when>

<c:when test="${pageType == 'NABOC'}">
<colgroup>
		<col style="width:100px;">
		<col style="width:150px;">
		<col style="width:150px;">
		<col style="width:100px;">
		<col style="width:200px;">		
		<col style="width:200px;">
		<col style="width:100px;">		
		<col style="width:300px;">
		<col style="width:300px;">
		<col style="width:300px;">
		<col style="width:100px;">
		<col style="width:100px;">		
		<col style="width:300px;">
		<col style="width:100px;">
		<col style="width:100px;">
</colgroup>
<thead>
	<tr>
		<th align="center" bgcolor='#CEFBC9' style='border:1px solid #d3d3d3;10%'>연도</th>
		<th align="center" bgcolor='#CEFBC9' style='border:1px solid #d3d3d3;'>위원회</th>
		<th align="center" bgcolor='#CEFBC9' style='border:1px solid #d3d3d3;'>조사대상기관</th>
		<th align="center" bgcolor='#CEFBC9' style='border:1px solid #d3d3d3;'>유형</th>
		<th align="center" bgcolor='#CEFBC9' style='border:1px solid #d3d3d3;'>시정요구명</th>		
		<th align="center" bgcolor='#CEFBC9' style='border:1px solid #d3d3d3;'>관련사업명</th>
		<th align="center" bgcolor='#CEFBC9' style='border:1px solid #d3d3d3;'>등록일</th>		
		<th align="center" bgcolor='#CEFBC9' style='border:1px solid #d3d3d3;'>지적사항</th>
		<th align="center" bgcolor='#CEFBC9' style='border:1px solid #d3d3d3;'>시정요구사항</th>
		<th align="center" bgcolor='#CEFBC9' style='border:1px solid #d3d3d3;'>조치결과</th>
		<th align="center" bgcolor='#CEFBC9' style='border:1px solid #d3d3d3;'>조치상황</th>
		<th align="center" bgcolor='#CEFBC9' style='border:1px solid #d3d3d3;'>조치일자</th>
		<th align="center" bgcolor='#CEFBC9' style='border:1px solid #d3d3d3;'>후속조치결과</th>
		<th align="center" bgcolor='#CEFBC9' style='border:1px solid #d3d3d3;'>후속조치상황</th>
		<th align="center" bgcolor='#CEFBC9' style='border:1px solid #d3d3d3;'>후속조치일자</th>
	</tr>
</thead>
<tfoot></tfoot>
<tbody>
<c:forEach var="result" items="${result}" varStatus="status">
<tr>
	<td style='text-align:center;border:1px solid #d3d3d3;'>${result.listSubNm}</td>
	<td style='text-align:center;border:1px solid #d3d3d3;'>${result.cmteNm}</td>
	<td style='text-align:center;border:1px solid #d3d3d3;'>${result.tgtOrgNm}</td>
	<td style='text-align:center;border:1px solid #d3d3d3;'>${result.list1SubNm}</td>
	<td style='text-align:left;border:1px solid #d3d3d3;'>${result.bbsTit}</td>	
	<td style='text-align:left;border:1px solid #d3d3d3;'>${result.refTit}</td>
	<td style='text-align:left;border:1px solid #d3d3d3;'>${result.regDttm}</td>	
	<td style='text-align:left;border:1px solid #d3d3d3;'>${result.bbsCont}</td>
	<td style='text-align:left;border:1px solid #d3d3d3;'>${result.refCont}</td>
	<td style='text-align:left;border:1px solid #d3d3d3;'>${result.ansCont}</td>
	<td style='text-align:left;border:1px solid #d3d3d3;'>${result.ansStateNm}</td>
	<td style='text-align:left;border:1px solid #d3d3d3;'>${result.apprDttm}</td>	
	<td style='text-align:left;border:1px solid #d3d3d3;'>${result.ans2Cont}</td>
	<td style='text-align:left;border:1px solid #d3d3d3;'>${result.ans2StateNm}</td>
	<td style='text-align:left;border:1px solid #d3d3d3;'>${result.appr2Dttm}</td>	
</tr>
</c:forEach>
</c:when>
<c:when test="${pageType == 'NABOI'}">
<colgroup>
		<col style="width:100px;">
		<col style="width:200px;">
		<col style="width:700px;">
</colgroup>
<thead>
	<tr>
		<th align="center" bgcolor='#CEFBC9' style='border:1px solid #d3d3d3;10%'>연도</th>
		<th align="center" bgcolor='#CEFBC9' style='border:1px solid #d3d3d3;'>해당기관</th>
		<th align="center" bgcolor='#CEFBC9' style='border:1px solid #d3d3d3;'>부대의견</th>
	</tr>
</thead>
<tfoot></tfoot>
<tbody>
<c:forEach var="result" items="${result}" varStatus="status">
<tr>
	<td style='text-align:center;border:1px solid #d3d3d3;width:100px;'>${result.listSubCd}</td>
	<td style='text-align:center;border:1px solid #d3d3d3;width:100px;'>${result.tgtOrgNm}</td>
	<td style='text-align:left;border:1px solid #d3d3d3;width:100px;'>${result.bbsCont}</td>
</tr>
</c:forEach>
</c:when>
<c:when test="${pageType == 'NABOQ'}">
<colgroup>
		<col style="width:100px;">
		<col style="width:300px;">
		<col style="width:600px;">
</colgroup>
<thead>
	<tr>
		<th align="center" bgcolor='#CEFBC9' style='border:1px solid #d3d3d3;10%'>연도</th>
		<th align="center" bgcolor='#CEFBC9' style='border:1px solid #d3d3d3;'>감사요구</th>
		<th align="center" bgcolor='#CEFBC9' style='border:1px solid #d3d3d3;'>제안이유</th>
	</tr>
</thead>
<tfoot></tfoot>
<tbody>
<c:forEach var="result" items="${result}" varStatus="status">
<tr>
	<td style='text-align:center;border:1px solid #d3d3d3;width:100px;'>${result.listSubCd}</td>
	<td style='text-align:center;border:1px solid #d3d3d3;width:100px;'>${result.bbsTit}</td>
	<td style='text-align:left;border:1px solid #d3d3d3;width:100px;'>${result.bbsCont}</td>
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