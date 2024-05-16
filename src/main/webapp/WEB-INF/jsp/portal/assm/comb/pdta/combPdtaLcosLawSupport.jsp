<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%-- 통합 - 정책자료&보고서 - 지역현안 입법지원 토론회 개최내역             
<%-- 
<%-- @author JHKIM
<%-- @version 1.0 2019/10/22
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
	
<h5>지역현안 입법지원 토론회 개최내역</h5>
<form id="lawSprtForm" method="post">
	<input type="hidden" name="page" value="${param.page}"  title="페이지번호">
	<input type="hidden" name="rows" value="10" title="행번호">
	<input type="hidden" name="gubunId" value="PL" title="구분코드">
	<input type="hidden" name="excelNm" value="" title="엑셀다운로드 명">
	<div class="theme_select_box layout_autoMt20 active_top">
		<table>
            <caption>지역현안 입법지원 토론회 개최내역 : 대수, 제목 등 정보제공</caption>
            <tbody>
            <tr>
            	<th scope="row">
                   <label for="lawSprtBillName">대수</label>
                </th>
                <td>
                  <%@ include file="/WEB-INF/jsp/portal/assm/sect/assmUnitCombobox.jsp" %>
                </td>
                <th scope="row">
                   <label for="lawSprtRptTit">제목</label>
                </th>
                <td>
                  <input type="text" name="rptTit" id="lawSprtRptTit">
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
		<caption>지역현안 입법지원 토론회 개최내역 : 번호, 대수, 제목, 주최자, 개최일 등 정보제공</caption>
		<colgroup class="m_none">
		<col style="width:10%;">
		<col style="width:15%;">
		<col style="width:;">
		<col style="width:20%;">
		<col style="width:15%;">
		</colgroup>
		<thead>
			<tr>
				<th scope="row">번호</th>
				<th scope="row">대수</th>
				<th scope="row">제목</th>
				<th scope="row">주최자</th>
				<th scope="row">개최일</th>
			</tr>
		</thead>
		<tbody id="lawSprt-result-sect">
		</tbody>
		</table>
	</div>
	<div id="lawSprt-pager-sect"></div>
</form>
<script type="text/javascript" src="<c:url value="/js/portal/assm/comb/pdta/combPdtaLcosLawSupport.js" />"></script>