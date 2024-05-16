<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%-- 국회의원 국회발언 화면 - 탭 				                    	
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
<form id="assmRemkForm" method="post">
	<input type="hidden" name="page" value="${param.page}"  title="페이지번호">
	<input type="hidden" name="rows" value="10" title="행번호">
 	<input type="hidden" name="gubunId" value="AV" title="구분코드"> 
 	<input type="hidden" name="excelNm" value="" title="엑셀다운로드 명">
	<div class="theme_select_box">
		<table>
			<caption>국회발언 : 대수, 회의명</caption>
			<tbody>
			<tr>
				<th scope="row">
                   <label for="cmteBillName">대수</label>
                </th>
                <td>
					<%@ include file="/WEB-INF/jsp/portal/assm/sect/assmUnitCombobox.jsp" %>
                </td>
			    <th scope="row">
			    	<label for="title">회의명</label>
			    </th>
			    <td>
			  		<input type="text" name="title" id="title" title="회의명 입력">
			    </td>
			</tr>
			</tbody>
		</table>
		<ul>
			<li><a href="javascript:;" class="btn_inquiries" id="btnSch">조회</a></li>
			<li><a href="javascript:;" class="btn_filedown" id="btnDownload">영상목록 다운로드</a></li>
		</ul>
	</div>
	<div class="themeB mt10">
		<table>
		<caption>국회발언 : 번호, 날짜, 회의명/내용, 시:분:초, 영상보기</caption>
		<colgroup>
		<col style="width:60px;">
		<col style="width:120px;">
		<col>
		<col style="width:100px;">
		<col style="width:100px;">
		</colgroup>
		<thead>
			<tr>
				<th scope="row">번호</th>
				<th scope="row">날짜</th>
				<th scope="row">회의명/내용</th>
				<th scope="row">시:분:초</th>
				<th scope="row">영상보기</th>
			</tr>
		</thead>
		<tbody id="video-result-sect">
			<!-- 
			<tr>
				<td>2019-09-04</td>
				<td>제371회 국회(정기회) 제01차 국방위원회 | 홍영표 위원(더불어민주당) 발언</td>
				<td>01:58</td>
				<td><a href="#"><img src="/images/btn_movie.png" alt="영상보기"></a></td>
				<td><a href="#"><img src="/images/btn_smi.png" alt="자막보기"></a></td>
			</tr> -->
		</tbody>
		</table>
		<div id="video-pager-sect"></div>
	</div>
</form>
<script type="text/javascript" src="<c:url value="/js/portal/assm/remk/assmRemk.js" />"></script>
</body>
</html>