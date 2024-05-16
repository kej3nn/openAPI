<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>

<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%-- @(#)meta.jsp 1.0 2019/08/20 	                                  		--%>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>

<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%-- 문서관리 서비스 메타 조회 화면이다. 				                    --%>
<%--                                                                        --%>
<%-- @author JHKIM                                                         --%>
<%-- @version 1.0 2019/08/20                                                --%>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>

<section id="metaInfo" class="view_metaInfo">
<h4 class="hide">메타 정보</h4>
	<table class="table_datail_A width_A">
		<caption>메타 정보 상세</caption>
		<colgroup>
		<col style="">
		</colgroup>
		<tbody>
		<tr>
		    <th scope="row">분류 체계</th>
		    <td>${meta.cateFullnm }</td>
			<th scope="row">공개일자</th>
			<td>${meta.openDttm }</td>
		</tr>
		<tr>
		    <th scope="row">제공기관</th>
		    <td>${meta.orgNm }</td>
			<th scope="row">최종 수정일자</th>
			<td>${meta.loadDttm }</td>
		</tr>
		<tr>
		    <th scope="row">원본시스템</th>
		    <td>
			    <c:if test="${meta.srcYn eq 'Y' and meta.srcUrl ne null}">
			        <a href="${meta.srcUrl}" target="_blank">${meta.srcExp }</a>
			    </c:if>
			    <c:if test="${meta.srcYn eq 'Y' and meta.srcUrl eq null}">
			        ${meta.srcExp }
			    </c:if>
		    </td>
			<th scope="row" rowspan="2">이용허락조건</th>
			<td rowspan="2"><img src="/images/${meta.cclFileNm }" alt="${meta.cclNm }"></td>
		</tr>
		<tr>
			<th scope="row">공개주기</th>
			<td>${meta.loadNm }</td>			
		</tr>
		<tr>
			<th scope="row">공개시기</th>
			<td colspan="3">${meta.dataDttmCont }</td>			
		</tr>
		<tr>
		    <th scope="row">검색태그</th>
		    <td colspan="3">${meta.schwTagCont }</td>
		</tr>
		<tr>
		    <th scope="row">설명</th>
		    <td colspan="3">${meta.docExp }</td>
		</tr>
		</tbody>
	</table>
</section>