<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%-- 의정활동별 공개 - 위원회 구성/계류법안등 - 위원회 명단
<%-- 
<%-- @author JHKIM
<%-- @version 1.0 2019/11/05
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<form id="listForm" method="post">
<h4 class="hide">위원 명단</h4>
	<input type="hidden" name="page" value="${ param.page }"  title="페이지번호">
	<input type="hidden" name="rows" value="10" title="행번호">
	<input type="hidden" name="gubunId" value="CB" title="구분코드">
	<input type="hidden" name="excelNm" value="" title="엑셀다운로드 명">
	<div class="theme_select_box layout_auto active_top">
		<table>
            <caption>위원 명단 : 위원회명, 위원명, 구성, 소속정당</caption>
            <tbody>
            <tr>
                <th scope="row">위원회명</th>
                <td>
                	<select name="deptCd" id="deptCd" title="위원회명">
                		
                	</select>
                </td>
                <th scope="row">위원명</th>
                <td><input name="hgNm" type="text" title="위원명"></td>
            </tr>
            <tr>
                <th scope="row">구성</th>
                <td>
                	<select name="jobResCd" id="jobResCd" title="구성">
	                </select>
				</td>
                <th scope="row">소속정당</th>
                <td>
	                <select name="polyCd" id="polyCd" title="소속정당">
	                </select>
                </td>
            </tr>
            </tbody>
        </table>		
		<ul>
			<li><a href="javascript:;" class="btn_inquiries" id="btnSch">조회</a></li>
			<li><a href="javascript:;" class="btn_filedown" id="btnDownload">다운로드</a></li>
		</ul>
	</div>
	<div class="themeBscrollx hline">
		<table>
		<caption>위원 명단 : 위원회 명, 구성, 사진, 위원명, 소속정당(선거구), 전화번호, 보좌진</caption>
		<colgroup>
		<col style="">
		</colgroup>
		<thead>
			<tr>
				<th scope="row">위원회 명</th>
				<th scope="row">구성</th>
				<th scope="row">사진</th>
				<th scope="row">위원명</th>
				<th scope="row">소속정당(선거구)</th>
				<th scope="row">전화번호</th>
				<th scope="row">보좌진</th>
			</tr>
		</thead>
		<tbody id="list-result-sect">
		</tbody>
		</table>
	</div>
	<div id="list-pager-sect"></div>
</form>
<script type="text/javascript" src="<c:url value="/js/portal/bpm/cmp/cmpList.js" />"></script>