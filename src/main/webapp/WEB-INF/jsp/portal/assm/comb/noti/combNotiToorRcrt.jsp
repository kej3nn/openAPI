<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%-- 통합 - 의원실 알림 - 의원실 채용             
<%-- 
<%-- @author JHKIM
<%-- @version 1.0 2019/10/23
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<h5>의원실 채용</h5>
<form id="rcrtForm" method="post">
	<input type="hidden" name="page" value="${param.page}"  title="페이지번호">
	<input type="hidden" name="rows" value="10" title="행번호">
	<input type="hidden" name="gubunId" value="NR" title="구분코드">
	<input type="hidden" name="excelNm" value="" title="엑셀다운로드 명">
	<div class="theme_select_box layout_autoMt20 active_top">
		<table>
            <caption>제목</caption>
            <tbody>
            <tr>
            	<th scope="row">
                   <label for="rcrtBillName">대수</label>
                </th>
                <td>
                  <%@ include file="/WEB-INF/jsp/portal/assm/sect/assmUnitCombobox.jsp" %>
                </td>
                <th scope="row">
                   <label for="rcrtTitleV">제목</label>
                </th>
                <td>
                  <input type="text" name="titleV" id="rcrtTitleV">
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
		<caption>번호, 대수, 구분, 제목, 작성일, 첨부파일</caption>
		<colgroup class="m_none">
		<col style="width:15%;">
		<col style="width:15%;">
		<col style="width:;">
		<col style="width:15%;">
		<col style="width:15%;">
		</colgroup>
		<thead>
			<tr>
				<th scope="row" class="tm_number">번호</th>
				<th scope="row" class="tm_number">대수</th>
				<th scope="row" class="tm_title">제목</th>
				<th scope="row" class="tm_date">작성일</th>
				<th scope="row" class="tm_useyn">상태</th>
			</tr>
		</thead>
		<tbody id="rcrt-result-sect">
		</tbody>
		</table>
	</div>
	<div id="rcrt-pager-sect"></div>
</form>
<script type="text/javascript" src="<c:url value="/js/portal/assm/comb/noti/combNotiToorRcrt.js" />"></script>