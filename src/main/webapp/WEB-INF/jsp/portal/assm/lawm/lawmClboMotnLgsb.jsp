<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%-- 메인 - 의정활동 - 공동발의 법률안 화면		                   
<%-- 
<%-- @author JHKIM
<%-- @version 1.0 2019/10/16
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<div style="display: none;" id="div-clbo-sect">	
	<h4 class="hide">공동발의법률안</h4>
	<form id="clboForm" method="post">
		<input type="hidden" name="page" value="${param.page}" title="페이지번호">
		<input type="hidden" name="rows" value="10" title="행번호">
		<input type="hidden" name="gubunId" value="AC" title="구분코드">
		<input type="hidden" name="excelNm" value="" title="엑셀다운로드 명">
		<div class="theme_select_box">
			<table>
	            <caption>공동발의법률안 : 대수, 본회의 처리결과, 의안명 등 정보제공</caption>
	            <tbody>
	            <tr>
	            	<th scope="row">
	                   <label for="selUnitCd">대수</label>
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
				<li><a href="javascript:;" class="btn_checkchart" id="btnChartsch">차트조회</a></li>
			</ul>
		</div>
		<div id="chartClboArea" style="overflow:hidden;display:none;">
			<div id="chartClboTreeMapContainer" style="float:left;width:50%;"></div>
			<div id="chartClboColumnContainer" style="float:left;width:50%;"></div>
		</div>
		<div class="themeB mt10 layoutFx">
			<table>
			<caption>공동발의법률안 : 번호, 대수, 의안명, 제안자, 소관위원회, 작성일, 처리상태 등 정보제공</caption>
			<colgroup>
			<col style="width:70px;">
			<col style="width:90px;">
			<col style="width:;">
			<col style="width:150px;">
			<col style="width:150px;">
			<col style="width:120px;">
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
			<div id="clbo-pager-sect"></div>
		</div>
	</form>
</div>
<script type="text/javascript" src="<c:url value="/js/portal/assm/lawm/lawmClboMotnLgsb.js" />"></script>