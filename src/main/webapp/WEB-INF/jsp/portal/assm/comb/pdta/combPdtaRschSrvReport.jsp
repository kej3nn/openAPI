<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%-- 통합 - 정책자료&보고서 - 연구용역 결과보고서             
<%-- 
<%-- @author JHKIM
<%-- @version 1.0 2019/10/22
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
	
<h5>연구용역 연구보고서</h5>
<form id="srvForm" method="post">
	<input type="hidden" name="page" value="${param.page}"  title="페이지번호">
	<input type="hidden" name="rows" value="10" title="행번호">
	<input type="hidden" name="gubunId" value="PV" title="구분코드">
	<input type="hidden" name="excelNm" value="" title="엑셀다운로드 명">
	<div class="theme_select_box layout_autoMt20 active_top">
		<table>
            <caption>연구용역 연구보고서 : 대수, 보고서명 등 정보제공</caption>
            <tbody>
            <tr>
            	<th scope="row">
                   <label for="srvBillName">대수</label>
                </th>
                <td>
                  <%@ include file="/WEB-INF/jsp/portal/assm/sect/assmUnitCombobox.jsp" %>
                </td>
                <th scope="row">
                   <label for="srvRptTit">보고서명</label>
                </th>
                <td>
                  <input type="text" name="rptTit" id="srvRptTit">
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
		<caption>연구용역 결과보고서 : 번호, 대수, 보고서명, 작성자, 작성일, 첨부파일 등 정보제공</caption>
		<colgroup>
		<col style="width:;">
		</colgroup>
		<thead>
			<tr>
				<th scope="row">번호</th>
				<th scope="row">대수</th>
				<th scope="row">보고서명</th>
				<th scope="row">작성자</th>
				<th scope="row">작성일</th>
				<th scope="row">첨부파일</th>
			</tr>
		</thead>
		<tbody id="srv-result-sect">
		</tbody>
		</table>
	</div>
	<div id="srv-pager-sect"></div>
</form>
<script type="text/javascript" src="<c:url value="/js/portal/assm/comb/pdta/combPdtaRschSrvReport.js" />"></script>