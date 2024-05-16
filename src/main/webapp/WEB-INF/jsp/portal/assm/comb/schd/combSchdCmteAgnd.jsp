<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%-- 통합 - 의원일정 -  위원회 의사일정           
<%-- 
<%-- @author JHKIM
<%-- @version 1.0 2019/10/23
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<h5>위원회 의사일정</h5>
<form id="cmteForm" method="post">
	<input type="hidden" name="page" value="${param.page}" title="페이지번호">
	<input type="hidden" name="rows" value="10" title="행번호">
	<input type="hidden" name="gubunId" value="SC" title="구분코드">
	<input type="hidden" name="excelNm" value="" title="엑셀다운로드 명">
	<div class="theme_select_box layout_autoMt20 active_top">
		<table>
            <caption>제목</caption>
            <tbody>
            <tr>
            	<th scope="row">
                   <label for="cmteBillName">대수</label>
                </th>
                <td>
                  <%@ include file="/WEB-INF/jsp/portal/assm/sect/assmUnitCombobox.jsp" %>
                </td>
                <th scope="row">
                   <label for="cmteTitle2">제목</label>
                </th>
                <td>
                	<input type="text" name="title" id="cmteTitle2">
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
		<caption>번호, 대수, 위원회, 회기, 차수, 제목, 일시, 결과서</caption>
		<colgroup class="m_none">
		<col style="width:60px;">
		<col style="width:60px;">
		<col style="width:160px;">
		<col style="width:160px;">
		<col style="width:90px;">
		<col style="width:;">
		<col style="width:180px;">
		<col style="width:60px;">
		<col style="width:60px;">
		</colgroup>
		<thead>
			<tr>
				<th scope="row" class="tm_number">번호</th>
				<th scope="row" class="tm_number">대수</th>
				<th scope="row" class="tm_number">위원회</th>
				<th scope="row" class="tm_session">회기</th>
				<th scope="row" class="tm_cha">차수</th>
				<th scope="row" class="tm_title">제목</th>
				<th scope="row" class="tm_datetime">일시</th>
				<th scope="row" class="tm_report">예정</th>
				<th scope="row" class="tm_report">결과</th>
			</tr>
		</thead>
		<tbody id="cmte-result-sect">
		</tbody>
		</table>
	</div>
	<div id="cmte-pager-sect"></div>
</form>
<script type="text/javascript" src="<c:url value="/js/portal/assm/comb/schd/combSchdCmteAgnd.js" />"></script>