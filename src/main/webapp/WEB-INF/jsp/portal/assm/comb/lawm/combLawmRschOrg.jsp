<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%-- 통합 - 의정활동 - 연구단체             
<%-- 
<%-- @author JHKIM
<%-- @version 1.0 2019/10/22
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
	
<form id="orgForm" method="post">
	<input type="hidden" name="page" value="${param.page}" title="페이지번호">
	<input type="hidden" name="rows" value="10" title="행번호">
	<input type="hidden" name="gubunId" value="AO" title="구분코드">
	<input type="hidden" name="excelNm" value="" title="엑셀다운로드 명">
	<div class="theme_select_box layout_autoMt20 active_top">
		<table>
			<caption>분야, 연구단체</caption>
			<tbody>
			<tr>
				<th scope="row">
                   <label for="orgBillName">대수</label>
                </th>
                <td>
                  <%@ include file="/WEB-INF/jsp/portal/assm/sect/assmUnitCombobox.jsp" %>
                </td>
                <th scope="row">
			    	<label for="orgReName">연구단체</label>
			    </th>
			    <td>
			    	<input type="text" id="orgReName" name="reName">
			    </td>
			</tr>
			<tr>
			    <th scope="row">
			    	<label for="orgReTopicName">분야</label>
			    </th>
			    <td colspan="3">
			  		<input type="text" id="orgReTopicName" name="reTopicName">
			    </td>
			</tr>
			</tbody>
		</table>
		<ul>
			<li><a href="javascript:;" class="btn_inquiries" id="btnSch">조회</a></li>
			<li><a href="javascript:;" class="btn_filedown" id="btnDownload">다운로드</a></li>
		</ul>
	</div>
	<div class="themeBscrollx mt30 assemblyOnly">
		<table>
		<caption>번호, 대수, 분야별, 연구단체</caption>
		<colgroup class="m_none">
		<col style="width:60px;">
		<col style="width:70px;">
		<col style="width:150px;">
		<col style="width:;">
		</colgroup>
		<thead>
			<tr>
				<th scope="row">번호</th>
				<th scope="row">대수</th>
				<th scope="row">분야별</th>
				<th scope="row">연구단체</th>
			</tr>
		</thead>
		<tbody id="org-result-sect">
		</tbody>
		</table>
	</div>
	<div id="org-pager-sect"></div>
</form>
<script type="text/javascript" src="<c:url value="/js/portal/assm/comb/lawm/combLawmRschOrg.js" />"></script>