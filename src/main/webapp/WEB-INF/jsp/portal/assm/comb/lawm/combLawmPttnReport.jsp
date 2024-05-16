<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%-- 통합 - 의정활동 - 청원현황             
<%-- 
<%-- @author JHKIM
<%-- @version 1.0 2019/10/22
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
	
<form id="reportForm" method="post">
	<input type="hidden" name="page" value="${param.page}" title="페이지번호">
	<input type="hidden" name="rows" value="10" title="행번호">
	<input type="hidden" name="gubunId" value="AP" title="구분코드">
	<input type="hidden" name="excelNm" value="" title="엑셀다운로드 명">
	<input type="hidden" name="approver" value="${meta.hgNm }" title="제안자 이름">
	<div class="theme_select_box layout_autoMt20 active_top">
		<table>
			<caption>청원명, 의결결과</caption>
			<tbody>
			<tr>
				<th scope="row">
                   <label for="procBillName">대수</label>
                </th>
                <td>
                  <%@ include file="/WEB-INF/jsp/portal/assm/sect/assmUnitCombobox.jsp" %>
                </td>
                <th scope="row">
			    	<label for="procResultCd">의결결과</label>
			    </th>
			    <td>
			    	<input type="text" id="procResultCd" name="procResultCd">
			    </td>
			</tr>
			<tr>
			    <th scope="row">
			    	<label for="procBillName">청원명</label>
			    </th>
			    <td colspan="3">
			  		<input type="text" id="procBillName" name="billName" >
			    </td>
			</tr>
			</tbody>
		</table>
		<ul>
			<li><a href="javascript:;" class="btn_inquiries" id="btnSch">조회</a></li>
			<li><a href="javascript:;" class="btn_filedown" id="btnDownload">다운로드</a></li>
		</ul>
	</div>
	<div class="themeBscrollx mt30">
		<table>
		<caption>구분, 대수, 청원번호, 청원명, 청원인, 소개의원, 접수일, 회부일, 소관위원회, 의결일자, 의결결과</caption>
		<colgroup>
		<col style="">
		</colgroup>
		<thead>
			<tr>
				<th scope="row">구분</th>
				<th scope="row">대수</th> 
				<th scope="row">청원번호</th>
				<th scope="row">청원명</th>
				<th scope="row">청원인</th>
				<th scope="row">소개의원</th>
				<th scope="row">접수일</th>
				<th scope="row">회부일</th>
				<th scope="row">소관위원회</th>
				<th scope="row">의결일자</th>
				<th scope="row">의결결과</th>
			</tr>
		</thead>
		<tbody id="report-list-sect">
		</tbody>
		</table>
	</div>
	<div id="report-pager-sect"></div>
</form>
<script type="text/javascript" src="<c:url value="/js/portal/assm/comb/lawm/combLawmPttnReport.js" />"></script>