<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%-- 의정활동별 공개 - 청원 - 의원소개청원(국회의원 청원)
<%-- 
<%-- @author JHKIM
<%-- @version 1.0 2019/11/05
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<form id="petAssmMembForm" method="post">
<h4 class="hide">의원소개청원</h4>
	<input type="hidden" name="page" value="${ param.page }"  title="페이지번호">
	<input type="hidden" name="rows" value="10" title="행번호">
	<input type="hidden" name="currentDate" value="10">
	<input type="hidden" name="gubunId" value="EA" title="구분코드">
	<input type="hidden" name="excelNm" value="" title="엑셀다운로드 명">
	
	<div class="theme_select_box layout_auto active_top">
		<table>
            <caption>의원소개청원 : 대수, 청원명, 소개의원, 소관위원회, 의결결과, 청원명</caption>
            <tbody>
            <tr>
                <th scope="row">대수</th>
                <td>	
					<input type="text" title="대수" name="unitCd" value="">
                	<%-- <input type="hidden" name="unitCd" value="${unitCd }" title="대수"> --%>
                </td>
                 <th scope="row">소개의원</th>
                <td><input name="approver" type="text" title="소개의원"></td>
            </tr>
            <tr>
                <th scope="row">소관위원회</th>
                <td>
					<select id="cmitCd" name="cmitCd" title="소관위원회">
					<option value="">선택</option>
				</select>               
                </td>
                <th scope="row">의결결과</th>
                <td><input name="procResultCd" type="text" title="의결결과"></td>
            </tr>
            <tr>
                <th scope="row">청원명</th>
                <td  colspan="3"><input name="billName" type="text" title="청원명"></td>
            </tr>
            </tbody>
        </table>		
		
		<ul>
			<li><a href="javascript:;" class="btn_inquiries" id="btnSch">조회</a></li>
			<li><a href="javascript:;" class="btn_filedown" id="btnDownload">다운로드</a></li>
		</ul>
	</div>
	
	<div class="themeBscrollx">
		<table>
		<caption>의원소개청원 : 구분, 청원번호, 청원명, 청원인, 소개의원, 접수일, 회부일, 소관위원회, 의결일자, 의결결과</caption>
		<colgroup>
		<col style="">
		</colgroup>
		<thead>
			<tr>
				<th scope="row">구분</th>
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
		<tbody id="memb-result-sect">
		</tbody>
		</table>
	</div>
	<div id="memb-pager-sect"></div>
</form>
<script type="text/javascript" src="<c:url value="/js/portal/bpm/pet/petAssmMemb.js" />"></script>