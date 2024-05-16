<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%-- 의정활동별 공개 - 위원회 구성/계류법안등 - 계류법안
<%-- 
<%-- @author JHKIM
<%-- @version 1.0 2019/11/06
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<form id="moobForm" method="post">
<h4 class="hide">계류의안</h4>
	<input type="hidden" name="page" value="${ param.page }" title="페이지번호">
	<input type="hidden" name="rows" value="10" title="행번호">
	<input type="hidden" name="unitCd" value="100020" title="대수"> <!-- 조건확인 필요 -->
	<input type="hidden" name="gubunId" value="CD" title="구분코드"> 
	<input type="hidden" name="excelNm" value="" title="엑셀다운로드 명">
	
	<div class="theme_select_box layout_auto active_top">
		<table>
            <caption>계류의안 : 위원회, 의안명</caption>
            <tbody>
            <tr>
                <th scope="row">위원회</th>
                <td>
                	<select title="위원회명" id="cmitCd" name="cmitCd">
                		<option value="">전체</option>
                	</select>
                </td>
                <th scope="row">의안명</th>
                <td><input type="text" title="의안명" id="billName" name="billName"></td>
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
		<caption>계류의안 : 의안번호, 위원회, 의안명, 제안자구분, 제안자, 제안일자</caption>
		<colgroup>
		<col style="width:100px;">
		<col style="width:130px;">
		<col style="">
		<col style="width:100px;">
		<col style="width:140px;">
		<col style="width:100px;">
		</colgroup>
		<thead>
			<tr>
				<th scope="row">의안번호</th>
				<th scope="row">위원회</th>
				<th scope="row">의안명</th>
				<th scope="row">제안자구분</th>
				<th scope="row">제안자</th>
				<th scope="row">제안일자</th>
			</tr>
		</thead>
		<tbody id="moob-result-sect">
		</tbody>
		</table>
	</div>
	<div id="moob-pager-sect"></div>
</form>
<script type="text/javascript" src="<c:url value="/js/portal/bpm/cmp/cmpMoob.js" />"></script>