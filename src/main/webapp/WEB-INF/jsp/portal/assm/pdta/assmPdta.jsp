<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%-- 국회의원 정책자료/보고서 화면 - 탭 				                    	
<%-- 
<%-- @author JHKIM
<%-- @version 1.0 2019/10/16
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<!DOCTYPE html>
<html lang="ko">
<head>
<%@ include file="/WEB-INF/jsp/portal/sect/head.jsp" %>
<style type="text/css">
/* 페이징 네비게이션 */
.paging-navigation {
	clear: both; 
	text-align: center; 
	padding-bottom: 0;
	margin-top: 35px;
}

.paging-navigation a {
	display: inline-block; 
	line-height: 35px; 
	min-width: 29px; 
	height: 35px; 
	padding: 0 3px;
	color: #4c4c50;
	border: 1px solid #c5c7cc; 
	vertical-align: middle; 
	background: #fff;
}
.paging-navigation a:hover {
	border: 1px solid #636363; 
	color: #fff;
	background: #636363;
	text-decoration: none;
}
.paging-navigation strong {
	display: inline-block; 
	line-height: 35px; 
	min-width: 29px; 
	height: 35px; 
	padding: 0 3px; 
	border: 1px solid #636363; 
	color: #fff; 
	vertical-align: middle;
	background: #636363;
}
.paging-navigation a.btn-first {
	width: 35px;
	padding: 0;
	text-indent: -5000em;
	background: transparent url(/images/btn_first.gif) no-repeat center center;
	background: -webkit-linear-gradient(transparent, transparent), url(/images/btn_first@2x.gif) no-repeat center center;
	background: linear-gradient(transparent, transparent), url(/images/btn_first@2x.gif) no-repeat center center;
	background-size: 12px 10px;
}
.paging-navigation a.btn-pre {
	width: 35px;
	padding: 0;
	text-indent: -5000em; 
	background: transparent url(/images/btn_previous.gif) no-repeat center center;
	background: -webkit-linear-gradient(transparent, transparent), url(/images/btn_previous@2x.gif) no-repeat center center;
	background: linear-gradient(transparent, transparent), url(/images/btn_previous@2x.gif) no-repeat center center;
	background-size: 6px 10px;
}
.paging-navigation a.btn-next {
	width: 35px;
	padding: 0;
	text-indent: -5000em; 
	background: transparent url(/images/btn_next.gif) no-repeat center center;
	background: -webkit-linear-gradient(transparent, transparent), url(/images/btn_next@2x.gif) no-repeat center center;
	background: linear-gradient(transparent, transparent), url(/images/btn_next@2x.gif) no-repeat center center;
	background-size: 6px 10px;
}
.paging-navigation a.btn-last {
	width: 35px;
	padding: 0;
	text-indent: -5000em; 
	background: transparent url(/images/btn_last.gif) no-repeat center center;
	background: -webkit-linear-gradient(transparent, transparent), url(/images/btn_last@2x.gif) no-repeat center center;
	background: linear-gradient(transparent, transparent), url(/images/btn_last@2x.gif) no-repeat center center;
	background-size: 12px 10px;
}
</style>
</head>
<body>
<!-- wrapper -->
<div>
	<form id="pdtaForm" method="post">
		<input type="hidden" name="page" value="${param.page}"  title="페이지번호">
		<input type="hidden" name="rows" value="10" title="행번호">
		<input type="hidden" name="gubunId" value="PA" title="구분코드">
		<input type="hidden" name="excelNm" value="" title="엑셀다운로드 명">
		<div class="theme_select_box">
			<table>
	            <caption>정책자료&보고서 : 대수, 구분, 제목</caption>
	            <colgroup>
	            <col style="width:20%;">
	            <col style="width:30%;">
	            <col style="width:20%;">
	            <col style="width:30%;">
	            </colgroup>
	            <tbody>
	            <tr>
	            	<th scope="row">
	                   <label for="cmteBillName">대수</label>
	                </th>
	                <td>
						<%@ include file="/WEB-INF/jsp/portal/assm/sect/assmUnitCombobox.jsp" %>
	                </td>
	            	<th scope="row">
	                   <label for="rptDivCd">구분</label>
	                </th>
	                <td>
	                	<select id="rptDivCd" name="rptDivCd"></select>
	                </td>
	            </tr>
	            <tr>
	                <th scope="row">
	                   <label for="rptTit">제목</label>
	                </th>
	                <td colspan="3">
	                  <input type="text" name="rptTit" id="rptTit" title="제목 입력">
	                </td>
	            </tr>
	           
	            </tbody>
	        </table>			
			
			<ul>
				<li><a href="javascript:;" class="btn_inquiries" id="btnSch">조회</a></li>
				<li><a href="javascript:;" class="btn_filedown" id="btnDownload">다운로드</a></li>
			</ul>
		</div>
		<div class="themeB mt10 layoutFx">
			<table>
			<caption>정책자료&보고서 : 번호, 구분, 제목, 등록일자</caption>
			<colgroup>
			<col style="width:60px;">
			<col style="width:240px;">
			<col>
			<col style="width:120px;">
			</colgroup>
			<thead>
				<tr>
					<th scope="row">번호</th>
					<th scope="row">구분</th>
					<th scope="row">제목</th>
					<th scope="row">등록일자</th>
				</tr>
			</thead>
			<tbody id="pdta-result-sect">
			</tbody>
			</table>
			<div id="pdta-pager-sect"></div>
		</div>
	</form>
</div>

<script type="text/javascript" src="<c:url value="/js/portal/assm/pdta/assmPdta.js" />"></script>
<iframe name="download-iframe" title="다운로드 처리 영역" height="0" style="width:100%; display:none;"></iframe>
</body>
</html>