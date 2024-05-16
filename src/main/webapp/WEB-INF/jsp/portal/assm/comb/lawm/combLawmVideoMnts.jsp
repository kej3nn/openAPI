<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%-- 통합 - 의정활동 - 영상회의록             
<%-- 
<%-- @author JHKIM
<%-- @version 1.0 2019/10/22
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
	
<form id="videoForm" method="post">
	<input type="hidden" name="page" value="${param.page}" title="페이지번호">
	<input type="hidden" name="rows" value="10" title="행번호">
	<input type="hidden" name="gubunId" value="AV" title="구분코드">
	<input type="hidden" name="excelNm" value="" title="엑셀다운로드 명">
	<div class="theme_select_box layout_autoMt20 active_top">
		<table>
			<caption>회의명</caption>
			<tbody>
			<tr>
				<th scope="row">
                   <label for="videoBillName">대수</label>
                </th>
                <td>
                  <%@ include file="/WEB-INF/jsp/portal/assm/sect/assmUnitCombobox.jsp" %>
                </td>
			    <th scope="row">
			    	<label for="videoTitle">회의명</label>
			    </th>
			    <td>
			  		<input type="text" id="videoTitle" name="title" title="회의명 입력" >
			    </td>
			</tr>
			</tbody>
		</table>
		<ul>
			<li><a href="javascript:;" class="btn_inquiries" id="btnSch">조회</a></li>
			<li><a href="javascript:;" class="btn_filedown" id="btnDownload">영상목록 다운로드</a></li>
		</ul>
	</div>
	<div class="themeBscrollx assemblyOnly">
		<table>
		<caption>번호, 대수, 날짜, 회의명/내용, 분:초, 영상보기</caption>
		<colgroup>
		<col style="width:60px;">
		<col style="width:70px;">
		<col style="width:100px;">
		<col style="width:;">
		<col style="width:100px;">
		<col style="width:110px;">
		</colgroup>
		<thead>
			<tr>
				<th scope="row">번호</th>
				<th scope="row">대수</th>
				<th scope="row">날짜</th>
				<th scope="row">회의명/내용</th>
				<th scope="row">분:초</th>
				<th scope="row">영상보기</th>
			</tr>
		</thead>
		<tbody id="video-result-sect">
		</tbody>
		</table>
	</div>
	<div id="video-pager-sect"></div>
</form>
<script type="text/javascript" src="<c:url value="/js/portal/assm/comb/lawm/combLawmVideoMnts.js" />"></script>