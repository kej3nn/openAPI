<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%-- 의정활동별 공개 - 위원회 구성/계류법안등 - 위원회 현황
<%-- 
<%-- @author JHKIM
<%-- @version 1.0 2019/11/05
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<form id="condForm" method="post">
<h4 class="hide">위원회 현황</h4>
	<input type="hidden" name="page" value="${ param.page }"  title="페이지번호">
	<input type="hidden" name="rows" value="10" title="행번호">
	<input type="hidden" name="gubunId" value="CA" title="구분코드">
	<input type="hidden" name="excelNm" value="" title="엑셀다운로드 명">
	
	<div class="theme_select_box layout_auto active_top">
		<table>
            <caption>위원회현황 : 위원회 종류, 위원회명 등 정보제공</caption>
            <tbody>
            <tr>
                <th scope="row">위원회 종류</th>
                <td>
                	<select name="cmtDivCd" id="cmtDivCd" title="위원회 종류">
                	</select>
                	 
                </td>
                <th scope="row">위원회명</th>
               	<td>
               		<select name="committeeId" id="committeeId" title="위원회명">
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
		<caption>위원회현황 : 위원회 종류, 위원회명, 위원정수, 현원, 더불어민주당, 국민의힘, 비교섭단체, 위원장, 간사, 홈페이지, 위원명단 및 연락처, 홈페이지 등 정보제공</caption>
		<colgroup>
		<col style="width:;">
		
		</colgroup>
		<thead>
			<tr>
				<th scope="row">위원회 종류</th>
				<th scope="row">위원회명</th>
				<th scope="row">위원정수</th>
				<th scope="row">현원</th>
				<c:forEach items="${polyGroupList }" var="polyGroup">
					<th scope="row" class="polyGroupNm">${polyGroup.polyGroupNm }</th>
				</c:forEach>
				<th scope="row">위원장</th>
				<th scope="row">간사</th>
				<th scope="row">위원명단 및 연락처</th>
				<th scope="row">홈페이지</th>
			</tr>
		</thead>
		<tbody id="cond-result-sect">
		</tbody>
		</table>
	</div>
	<div id="cond-pager-sect"></div>
</form>
<script type="text/javascript" src="<c:url value="/js/portal/bpm/cmp/cmpCond.js" />"></script>