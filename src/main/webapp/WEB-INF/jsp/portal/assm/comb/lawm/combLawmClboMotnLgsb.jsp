<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%-- 통합 - 의정활동 - 공동발의 법률안 화면		                   
<%-- 
<%-- @author JHKIM
<%-- @version 1.0 2019/10/22
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
	
<form id="clboForm" method="post">
	<input type="hidden" name="page" value="${param.page}" title="페이지번호" >
	<input type="hidden" name="rows" value="10" title="행번호">
	<input type="hidden" name="gubunId" value="AC_2" title="구분코드">
	<input type="hidden" name="excelNm" value="" title="엑셀다운로드 명">
	<div class="theme_select_box layout_autoMt20 active_top">
		<table>
            <caption>의안명,본회의 처리결과</caption>
            <tbody>
            <tr>
            	<th scope="row">
                   <label for="clboBillName">대수</label>
                </th>
                <td>
					<%@ include file="/WEB-INF/jsp/portal/assm/sect/assmUnitCombobox.jsp" %>
                </td>
                <th scope="row">
                   <label for="clboProcResult">본회의 처리결과</label>
                </th>
                <td>
                   <select name="procResult" id="clboProcResult"></select>
                </td>
            </tr>
            <tr>
                <th scope="row">
                   <label for="clboBillName">의안명</label>
                </th>
                <td colspan="3">
                  <input type="text" name="billName" id="clboBillName">
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
		<caption>번호, 대수, 의안명, 제안자, 소관위원회, 작성일, 처리상태</caption>
		<colgroup class="m_none">
		<col style="width:60px;">
		<col style="width:80px;">
		<col style="width:;">
		<col style="width:140px;">
		<col style="width:220px;">
		<col style="width:100px;">
		<col style="width:100px;">
		</colgroup>
		<thead>
			<tr>
				<th scope="row">번호</th>
				<th scope="row">대수</th>
				<th scope="row">의안명</th>
				<th scope="row">제안자</th>
				<th scope="row">소관위원회</th>
				<th scope="row">작성일</th>
				<th scope="row">처리상태</th>
			</tr>
		</thead>
		<tbody id="clbo-result-sect">
		</tbody>
		</table>
	</div>
	<div id="clbo-pager-sect"></div>
</form>
<script type="text/javascript" src="<c:url value="/js/portal/assm/comb/lawm/combLawmClboMotnLgsb.js" />"></script>