<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%-- 의원실 알림 - 전체조회 화면		                   
<%-- 
<%-- @author JHKIM
<%-- @version 1.0 2019/10/22
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<div>
	<form id="notiForm" method="post">
		<input type="hidden" name="page" value="${param.page}" title="페이지번호">
		<input type="hidden" name="rows" value="10" title="행번호">
		<div class="theme_select_box">
			<div>
				<!-- 구분 -->
				<span id="radioBbsCdN"></span>
				<input type="text" name="titleV">
				<div>
					<input type="text">
					<img src="/images/icon_calendar.png" alt="날짜선택">
				</div>
			</div>
			<ul>
				<li><a href="javascript:;" class="btn_inquiries" id="btnSch">조회</a></li>
				<li><a href="javascript:;" class="btn_filedown" id="btnDownload">다운로드</a></li>
			</ul>
		</div>
		<div class="themeB mt10">
			<table>
			<caption>번호, 구분, 제목, 작성일, 첨부파일</caption>
			<colgroup>
			<col style="">
			</colgroup>
			<thead>
				<tr>
					<th scope="row" class="tm_number">번호</th>
					<th scope="row" class="tm_gubun">구분</th>
					<th scope="row" class="tm_title">제목</th>
					<th scope="row" class="tm_date">작성일</th>
					<th scope="row" class="tm_file">첨부파일</th>
				</tr>
			</thead>
			<tbody id="noti-result-sect">
			</tbody>
			</table>
			<div id="noti-pager-sect"></div>
		</div>
	</form>
</div>