<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<jsp:useBean id="constants" class="egovframework.common.base.constants.GlobalConstants" />

<!DOCTYPE html>
<html lang="ko">
<head>
<c:set var="title" value="${data.infNm}" />
<c:set var="description" value="${fn:replace(data.infExp, constants.LINE_FEED, '')}" />
<c:set var="lvl3MenuSuffix" value= "표" />
<%@ include file="/WEB-INF/jsp/portal/sect/head.jsp" %>
<script type="text/javascript" src="<c:url value="/js/ggportal/data/service/selectSheet.js" />"></script>
</head>
<body>
<!-- 내용보기 설정시 레이어 팝업 -->
<c:if test="${dataColType eq 'contPop' }">
<div id="sheet-cont-sect" style="display: none;">
<div class="sheet-detail" id="sheet-cont-sect-detail">
	<h5 class="sheet-header">내용</h5>
	<a href="javascript:;" class="sheet-close" onclick="document.getElementById('sheet-cont-sect').style.display='none'">닫기</a>
<div>
	<div id="sheet-cont-sect-cont"></div>
	<div class="sheet-detail-btn">
		<a href="javascript:;" class="btn_A" onclick="document.getElementById('sheet-cont-sect').style.display='none'">닫기</a>
  	</div>
 	</div>
	</div>            	
	<div class="bgshadow">&nbsp;</div>
</div>
</c:if>
<!-- //내용보기 설정시 레이어 팝업 -->

<!-- 상세보기 설정시 레이어 팝업 -->
<c:if test="${dataColType eq 'dtlPop' }">
<div id="sheet-dtl-sect" style="display: none;">
<div class="sheet-detail" id="sheet-dtl-sect-detail">
	<h5 class="sheet-header">상세내용</h5>
	<a href="javascript:;" class="sheet-close" onclick="document.getElementById('sheet-dtl-sect').style.display='none'">닫기</a>
<div>
	<table id="sheet-dtl-sect-cont" class="table_datail_A width_A">
	</table>
	<div class="sheet-detail-btn">
		<a href="javascript:;" class="btn_A" onclick="document.getElementById('sheet-dtl-sect').style.display='none'">닫기</a>
  	</div>
 	</div>
	</div>            	
	<div class="bgshadow">&nbsp;</div>
</div>
</c:if>
<!-- //상세보기 설정시 레이어 팝업 -->

<!-- 유저 멀티 다운로드 데이터 셋 -->
<c:if test="${dataColType eq 'downPop' }">
<div id="userDown-dtl-sect" style="display: none;">
<div class="sheet-detail" id="userDown-dtl-sect-detail">
	<h5 class="sheet-header">다운로드</h5>
	<a href="javascript:;" class="sheet-close" onclick="document.getElementById('userDown-dtl-sect').style.display='none'">닫기</a>
<div>
	<div class="board-list01">
	<table>
	<caption>No, 제목, 작성자, 등록일자, 다운로드</caption>
<colgroup>
<col style="">
</colgroup>
<thead>
	<tr>
		<th scope="row" class="n_number">No</th>
		<th scope="row" class="n_subject">제목</th>
		<th scope="row" class="n_writer">작성자</th>
		<th scope="row" class="n_date">등록일자</th>
		<th scope="row" class="n_download">다운로드</th>
	</tr>
</thead>
<tbody id="userDown-dtl-sect-cont">
</tbody>
</table>
</div>
<div class="sheet-detail-btn">
	<a href="javascript:;" class="btn_A" onclick="document.getElementById('userDown-dtl-sect').style.display='none'">닫기</a>
  	</div>
 	</div>
	</div>  
	<div class="bgshadow">&nbsp;</div>	
</div>
</c:if>
<!-- //유저 멀티 다운로드 데이터 셋 -->
</body>
</html>