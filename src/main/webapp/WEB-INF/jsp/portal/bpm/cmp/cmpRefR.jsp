<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%-- 의정활동별 공개 - 위원회 구성/계류법안등 - 위원회 자료실
<%-- 
<%-- @author JHKIM
<%-- @version 1.0 2019/11/05
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<form id="refRForm" method="post">
<h4 class="hide">위원회 자료실</h4>
	<input type="hidden" name="page" value="${ param.page }"  title="페이지번호">
	<input type="hidden" name="rows" value="10" title="행번호">
	<input type="hidden" name="gubunId" value="CE" title="구분코드">
	<input type="hidden" name="excelNm" value="" title="엑셀다운로드 명">
	
	<div class="theme_select_box layout_auto active_top">
		<table>
            <caption>위원회 자료실 : 위원회, 일자, 제목</caption>
            <tbody>
            <tr>
                <th scope="row">위원회</th>
                <td>
                	<select name="siteId" id="siteId" title="위원회">
                	</select>
                </td>
                <th scope="row">일자</th>
                <td>
			  		 <ul>
	                	<li>
			                <span class="ipt_calendar">
					  			<input type="text" id="frCreateDt" name="frCreateDt" title="시작일자(입력예:YYYY-MM-DD)">
					  			<i>날짜입력 형식 : 2019-12-25</i>
					  		</span>
				  		</li>
				  		<li>
					  		<span class="ipt_calendar">
					  			<input type="text" id="toCreateDt" name="toCreateDt" title="종료일자(입력예:YYYY-MM-DD)">
					  			<i>날짜입력 형식 : 2019-12-25</i>
					  		</span>
				  		</li>
				  	</ul>
                </td>
            </tr>
            <tr>
                <th scope="row">제목</th>
                <td colspan="3" class="col3"><input name="articleTitle" id="articleTitle" type="text" title="제목"></td>
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
		<caption>위원회 자료실 : 번호, 위원회명, 제목, 작성일</caption>
		<colgroup>
		<col style="width:60px;">
		<col style="width:150px;">
		<col style="">
		<col style="width:100px;">
		</colgroup>
		<thead>
			<tr>
				<th scope="row">번호</th>
				<th scope="row">위원회명</th>
				<th scope="row">제목</th>
				<th scope="row">작성일</th>
			</tr>
		</thead>
		<tbody id="refr-result-sect">
		</tbody>
		</table>
	</div>
	<div id="refr-pager-sect"></div>
</form>
<script type="text/javascript" src="<c:url value="/js/portal/bpm/cmp/cmpRefR.js" />"></script>