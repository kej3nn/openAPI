<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%-- 의정활동별 공개 - 본회의 안건처리 - 본회의 일정
<%-- 
<%-- @author JHKIM
<%-- @version 1.0 2019/11/05
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<form id="dateForm" method="post">
<h4 class="hide">본회의 일정</h4>
	<input type="hidden" name="page" value="${param.page}" title="페이지번호">
	<input type="hidden" name="rows" value="10" title="행번호">
	<input type="hidden" name="currentDate" value="10">
	<input type="hidden" name="gubunId" value="PA" title="구분코드">
	<input type="hidden" name="excelNm" value="" title="엑셀다운로드 명">
	
	<div class="theme_select_box layout_auto active_top">
		<h4 class="blind">본회의 일정</h4>
		<table>
            <caption>본회의 일정 : 제목, 회기, 일자</caption>
            <tbody>
            <tr>
                <th scope="row">제목</th>
                <td><input type="text" name="title" title="제목"></td>
                <th scope="row">회기</th>
                <td><input type="text" name="meetingsession" title="회기"></td>
            </tr>
            <tr>
                <th scope="row">일자</th>
                <td colspan="3" class="col3">
	                <ul>
	                	<li>
			                <span class="ipt_calendar">
					  			<input type="text" id="frMeetingDate" name="frMeetingDate" title="시작일자(입력예:YYYY-MM-DD)" placeholder="시작일자입력 예시 : 2019-12-25">
					  			<i>날짜입력 형식 : 2019-12-25</i>
					  		</span>
				  		</li>
				  		<li>
					  		<span class="ipt_calendar">
					  			<input type="text" id="toMeetingDate" name="toMeetingDate" title="종료일자(입력예:YYYY-MM-DD)" placeholder="종료일자입력 예시 : 2019-12-25">
					  			<i>날짜입력 형식 : 2019-12-25</i>
					  		</span>
				  		</li>
				  	</ul>	
                </td>
            </tr>
            </tbody>
        </table>			
		<ul>
			<li><a href="javascript:;" class="btn_inquiries" name="btnSch">조회</a></li>
			<li><a href="javascript:;" class="btn_filedown" name="btnDownload">다운로드</a></li>
		</ul>
	</div>
	<div class="themeBscrollx assemblyOnly">
		<h4 class="blind">본회의 일정</h4>
		<table>
		<caption>본회의 일정 : 번호, 일시, 회기, 차수, 제목</caption>
		<colgroup class="m_none">
		<col style="width:60px;">
		<col style="width:140px;">
		<col style="width:160px;">
		<col style="width:80px;">
		<col style="">
		</colgroup>
		<thead>
			<tr>
				<th scope="row">번호</th>
				<th scope="row">일시</th>
				<th scope="row">회기</th>
				<th scope="row">차수</th>
				<th scope="row">제목</th>
			</tr>
		</thead>
		<tbody id="date-result-sect">
		</tbody>
		</table>
	</div>
	<div id="date-pager-sect"></div>
</form>
<script type="text/javascript" src="<c:url value="/js/portal/bpm/prc/prcDate.js" />"></script>