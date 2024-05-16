<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%-- 통합 - 의정활동 - 본회의 표결정보		                   
<%-- 
<%-- @author JHKIM
<%-- @version 1.0 2019/10/22
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<form id="voteForm" method="post">
<input type="hidden" name="page" value="${param.page}" title="페이지번호">
<input type="hidden" name="rows" value="10" title="행번호">
<input type="hidden" name="gubunId" value="AR" title="구분코드">
<input type="hidden" name="excelNm" value="" title="엑셀다운로드 명">
	<div class="theme_select_box layout_autoMt20 active_top"> 
		<table>
			<caption>의안명,본회의 처리결과,의결일자,표결정보</caption>
			<tbody>
			<tr>
				<th scope="row">
                   <label for="procBillName">대수</label>
                </th>
                <td>
                  <%@ include file="/WEB-INF/jsp/portal/assm/sect/assmUnitCombobox.jsp" %>
                </td>
                <th scope="row">
			    	<label for="procResult">본회의 처리결과</label>
			    </th>
			    <td>
			    	<select name="procResult" id="procResult"></select>
			    </td>
			</tr>
			<tr>
			    <th scope="row">
			    	<label for="voteendDt">의결일자</label>
			    </th>
			    <td>
					<span class="ipt_calendar">
						<input type="text" name="voteendDt" id="voteendDt">
						<i>날짜입력 형식 : 2019-12-25</i>
					</span>
			    </td>
			    <th scope="row">
			    	<label for="resultVoteCd">표결정보</label>
			    </th>
			    <td>
			     <select name="resultVoteCd" id="resultVoteCd"></select>
			    </td>
			</tr>
			<tr>
			    <th scope="row">
			    	<label for="billName">의안명</label>
			    </th>
			    <td colspan="3">
			  		<input type="text" id="billName" name="billName">
			    </td>
			</tr>
			</tbody>
		</table>
		<ul>
			<li><a href="javascript:;" class="btn_inquiries" id="btnSch">조회</a></li>
			<li><a href="javascript:;" class="btn_filedown" id="btnDownload">다운로드</a></li>
		</ul>
	</div>
	<div class="themeBscrollx assemblyOnly">
		<table>
		<caption>연번, 대수, 의결일자, 의안명, 소관위원회, 표결정보, 표결결과</caption>
		<colgroup class="m_none">
		<col style="width:60px;">
		<col style="width:80px;">
		<col style="width:100px;">
		<col style="width:;">
		<col style="width:140px;">
		<col style="width:100px;">
		<col style="width:90px;">
		</colgroup>
		<thead>
			<tr>
				<th scope="row" class="tm_number">연번</th>
				<th scope="row" class="tm_number">대수</th>
				<th scope="row" class="tm_decide">의결일자</th>
				<th scope="row" class="tm_subject">의안명</th>
				<th scope="row" class="tm_sort3">소관위원회</th>
				<th scope="row" class="tm_vote">표결정보</th>
				<th scope="row" class="tm_result">표결결과</th>
			</tr>
		</thead>
		<tbody id="vote-list-sect">
		</tbody>
		</table>
	</div>
	<div id="vote-pager-sect"></div>
</form>
<script type="text/javascript" src="<c:url value="/js/portal/assm/comb/lawm/combLawmVoteCond.js" />"></script>