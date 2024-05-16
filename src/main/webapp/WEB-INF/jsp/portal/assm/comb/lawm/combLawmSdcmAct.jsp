<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%-- 통합 - 의정활동 - 상임위 활동	                   
<%-- 
<%-- @author JHKIM
<%-- @version 1.0 2019/10/22
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
	
<form id="sdcmForm" method="post">
	<input type="hidden" name="page" value="${param.page}" title="페이지번호">
	<input type="hidden" name="rows" value="10" title="행번호">
	<input type="hidden" name="gubunId" value="AS" title="구분코드">
	<input type="hidden" name="excelNm" value="" title="엑셀다운로드 명">
	<div class="theme_select_box layout_autoMt20 active_top">
		<table>
			<caption>회기, 차수, 위원회</caption>
			<tbody>
			<tr>
				<th scope="row">
                   <label for="sdcmBillName">대수</label>
                </th>
                <td>
                  <%@ include file="/WEB-INF/jsp/portal/assm/sect/assmUnitCombobox.jsp" %>
                </td>
			    <th scope="row">
			    	<label for="sdcmSesNum">회기</label>
			    </th>
			    <td>
			  		<input type="text" id="sdcmSesNum" name="sesNum">
			    </td>
			</tr>
			<tr>
				<th scope="row">
			    	<label for="sdcmDegreeNum">차수</label>
			    </th>
			    <td>
			    	<input type="text" id="sdcmDegreeNum" name="degreeNum">
			    </td>
			    <th scope="row">
			    	<label for="sdcmCommName">위원회</label>
			    </th>
			    <td colspan="3">
					<input type="text" id="sdcmCommName" name="commName">
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
		<caption>번호, 대수, 회기, 차수, 위원회, 안건보기, 회의일, 작성일</caption>
		<colgroup class="m_none">
		<col style="width:60px;">
		<col style="width:110px;">
		<col style="width:100px;">
		<col style="width:90px;">
		<col style="width:;">
		<col style="width:100px;">
		<col style="width:120px;">
		<col style="width:120px;">
		</colgroup>
		<thead>
			<tr>
				<th scope="row">번호</th>
				<th scope="row">대수</th>
				<th scope="row">회기</th>
				<th scope="row">차수</th>
				<th scope="row">위원회</th>
				<th scope="row">안건보기</th>
				<th scope="row">회의일</th>
				<th scope="row">작성일</th>
			</tr>
		</thead>
		<tbody id="sdcm-result-sect">
		</tbody>
		</table>
	</div>
	<div id="sdcm-pager-sect"></div>
</form>
<script type="text/javascript" src="<c:url value="/js/portal/assm/comb/lawm/combLawmSdcmAct.js" />"></script>