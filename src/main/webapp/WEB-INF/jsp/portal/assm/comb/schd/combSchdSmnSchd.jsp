<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%-- 통합 - 의원일정 - 세미나일정             
<%-- 
<%-- @author JHKIM
<%-- @version 1.0 2019/10/22
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
	
<form method="post">
	<input type="hidden" name="page" value="${param.page}" title="페이지번호">
	<input type="hidden" name="rows" value="10" title="행번호">
	
	<div class="themeB mt30">
		<table>
		<caption>번호, 대수, 제목, 주최, 일시, 장소, 첨부파일</caption>
		<colgroup>
		<col style="width:10%;">
		<col style="width:10%;">
		<col style="width:;">
		<col style="width:20%;">
		<col style="width:15%;">
		<col style="width:15%;">
		<col style="width:10%;">
		</colgroup>
		<thead>
			<tr>
				<th scope="row">번호</th>
				<th scope="row">대수</th>
				<th scope="row">제목</th>
				<th scope="row">주최</th>
				<th scope="row">일시</th>
				<th scope="row">장소</th>
				<th scope="row">첨부파일</th>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td>53</td>
				<td>판문점 회동 이후 남북관계 전망</td>
				<td>박병석 의원실, 통일연구원</td>
				<td>09-26 (08:00~10:00)</td>
				<td>의원회관 제9간담회의실</td>
				<td>&nbsp;</td>
			</tr>
		</tbody>
		</table>
		<div id="pager-sect"></div>
	</div>
</form>