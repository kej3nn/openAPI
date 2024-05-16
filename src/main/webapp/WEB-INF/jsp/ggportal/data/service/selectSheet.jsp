<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%-- @(#)selectSheet.jsp 1.0 2015/06/15                                     --%>
<%--                                                                        --%>
<%-- COPYRIGHT (C) 2013 WISEITECH CO., LTD. ALL RIGHTS RESERVED.            --%>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>

<jsp:useBean id="constants" class="egovframework.common.base.constants.GlobalConstants" />

<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%-- 공공데이터 시트 서비스를 조회하는 화면이다.                            --%>
<%--                                                                        --%>
<%-- @author 김은삼                                                         --%>
<%-- @version 1.0 2015/06/15                                                --%>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<!DOCTYPE html>
<html lang="ko">
<head>
<c:set var="title" value="${data.infNm}" />
<c:set var="description" value="${fn:replace(data.infExp, constants.LINE_FEED, '')}" />
<c:set var="lvl3MenuSuffix" value= "표" />
<%@ include file="/WEB-INF/jsp/portal/sect/head.jsp" %>
<%-- <script type="text/javascript" src="<c:url value="/js/ggportal/data/service/jquery.fileDownload.js" />"></script> --%>
<script type="text/javascript" src="<c:url value="/js/ggportal/data/service/selectSheet.js" />"></script>


</head>
<body>
<!-- layout_A -->
<div class="layout_A">
<%@ include file="/WEB-INF/jsp/portal/sect/header.jsp" %>

<div class="container hide-pc-lnb" id="container">
<!-- contents -->
	<div class="contents" id="contents">
		<div class="contents-title-wrapper">
			<h3>정보공개<span class="arrow"></span>
							<c:set var="oInfIds" value="${fn:split(data.openInfIds,'|')}" />
				<c:set var="oOpenDttms" value="${fn:split(data.openDttms,'|')}" />
				</h3>
		</div>


<!-- wrap_layout_flex -->
<div class="wrap_layout_flex">
<div class="layout_flex_100">
<!-- layout_flex -->
<div class="layout_flex">
    <!-- content -->
    <div class="content_B">
		<a href="#none" id="content" class="hide">본문시작</a>
        <h2 class="hide"><c:out value="${requestScope.menu.lvl1MenuPath}" /></h2>
        <c:if test="${empty param.loc}" >
        	<h3 class="ty_B"><strong><c:out value="${requestScope.menu.lvl2MenuPath}" /></strong></h3>
        </c:if>
		<c:if test="${not empty param.loc}" >
			<h3 class="ty_B">위치기반 데이터 찾기</h3>
		</c:if>
        <%@ include file="/WEB-INF/jsp/ggportal/data/service/sect/meta.jsp" %>
        <%@ include file="/WEB-INF/jsp/ggportal/data/service/sect/tabs.jsp" %>
        <!-- Sheet -->
        <section class="section_sheet">
            <h4 class="hide">Sheet</h4>
            <!-- search -->
            <div id="sheet-search-sect" class="hide">
            <form id="sheet-search-form" name="sheet-search-form" method="post">
            <input type="hidden" name="rows" value="<c:out value="${constants.SHEET_ROWS}" default="100" />" />
            <input type="hidden" name="infId" value="<c:out value="${data.infId}" default="" />" />
            <input type="hidden" name="infSeq" value="<c:out value="${data.infSeq}" default="" />" />
            <input type="hidden" name="downloadType" value="<c:out value="${param.downloadType}" default="" />" />
            <input type="hidden" name="loc" value="<c:out value="${param.loc}" default="" />" />
            <fieldset>
            <legend>검색</legend>
            <a href="#none" class="toggle_search_C">
                검색 <img src="<c:url value="/images/toggle_open_search_C.png" />" alt="" />
            </a>
            <div id="search_C" class="close_search_C">
                <table id="sheet-search-table" class="table_search_C width_A">
                <caption>검색</caption>
                </table>
                <span class="area_btn_search_C"><a id="sheet-search-button" href="#" class="btn_A">검색</a></span>
            </div>
            </fieldset>
            </form>
            </div>
            <!-- // search -->
            <ul class="search search_AB">
            <li class="ty_B">
                <p class="flL p_tyA">칼럼명을 클릭하면 데이터 정렬이 가능합니다.(<img src="<c:url value="/images/icon_align_high.png" />" alt="" />오름차순, <img src="<c:url value="/images/icon_align_low.png" />" alt="" />내림차순)</p>
                <dl class="flR mq_tablet">
                <dt><label>파일변환저장</label></dt>
                <dd>
                    <a id="sheet-excel-button" href="#" class="btn_D">XLS</a>
                    <a id="sheet-csv-button" href="#" class="btn_D">CSV</a>
                    <a id="sheet-json-button" href="#" class="btn_D">JSON</a>
                    <a id="sheet-xml-button" href="#" class="btn_D">XML</a>
                    <a id="sheet-txt-button" href="#" class="btn_D">TXT</a>
                    <a id="sheet-rdf-button" href="#" class="btn_D">RDF</a>
                </dd>
                </dl>
            </li>
            </ul>
            <!-- 테이블 건너뛰기 -->
            <div class="skip_table">
				<a href="javascript: $('#dataset-search-button').focus();" name="skip_table" tabindex="0">테이블 건너뛰기</a>
			</div>
			<!-- //테이블 건너뛰기 -->
            <div class="area_sheet">
                <div id="sheet-object-sect" class="sheet"></div>
            </div> 
            <!-- 테이블 이전으로 건너뛰기 -->
            <div class="skip_btn">
				<a href="javascript: $('#sheet-rdf-button').focus();" name="skip_btn" tabindex="0">테이블 이전으로 건너뛰기</a>
			</div>
            <!-- //테이블 이전으로 건너뛰기 -->

            <!-- btn_A -->
            <div class="area_btn_A">
            	<span class="flTxt">데이터 기준일자 : <c:out value="${data.dataCondDttm}" /></span>
                <c:choose>
                <c:when test="${isInfsPop eq 'Y' }">
                	<a href="#" class="btn_A" onclick="javascript: window.close();">목록</a>
                </c:when>
                <c:otherwise>
                	<a id="dataset-search-button" href="#" class="btn_A">목록</a>
                </c:otherwise>
                </c:choose>
            </div>
            <!-- // btn_A -->
            
			<!-- 추천 데이터 셋 -->
			<!-- 숨김처리
			<div class="recommendDataset">
				<dl>
					<dt>연관 데이터셋</dt>
					<dd>
						<div class="dataSet">
							<ul class="dataSetSlider bxslider">

							</ul>
							<div class="btn_slide">
								<a href="#none" class="prev" id="dataset_prev" title="이전 갤러리 이동">이전</a>
								<a href="#none" class="next" id="dataset_next" title="다음 갤러리 이동">다음</a>
							</div>
						</div>
					</dd>
				</dl>
			</div> -->
			<!-- // 추천 데이터 셋 -->
			
			<!-- 내용보기 설정시 레이어 팝업 -->
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
            <!-- //내용보기 설정시 레이어 팝업 -->
			
			<!-- 상세보기 설정시 레이어 팝업 -->
            <div id="sheet-dtl-sect" style="display: none;">
            	<div class="sheet-detail" id="sheet-dtl-sect-detail">
	           		<h5 class="sheet-header">상세내용</h5>
	           		<!-- <a href="javascript:;" class="sheet-close" onclick="document.getElementById('sheet-dtl-sect').style.display='none'">닫기</a> -->
	           		<a href="javascript:;" class="sheet-close">닫기</a>
	           		<div>
		            	<table id="sheet-dtl-sect-cont" class="table_datail_A width_A">
		            	</table>
		            	<div class="sheet-detail-btn">
		            		<!-- <a href="javascript:;" class="btn_A" onclick="document.getElementById('sheet-dtl-sect').style.display='none'">닫기</a> -->
		            		<a href="javascript:;" class="btn_A">닫기</a>
		            	</div>
	            	</div>
            	</div>
            	<div class="bgshadow">&nbsp;</div>
            </div>
            <!-- //상세보기 설정시 레이어 팝업 -->
            
            <!-- 유저 멀티 다운로드 데이터 셋 -->
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
	            				<!-- <th scope="row" class="n_writer">작성자</th> -->
	            				<th scope="row" class="n_date">등록일자</th>
	            				<th scope="row" class="n_download">다운로드</th>
	            				<th scope="row" class="n_preview">미리보기</th>
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
            <!-- //유저 멀티 다운로드 데이터 셋 -->
            
            
        </section>
        <!-- // Sheet -->
        <form id="dataset-search-form" name="dataset-search-form" method="post"> 
            <input type="hidden" name="page" value="<c:out value="${param.page}" default="1" />" />
            <input type="hidden" name="rows" value="<c:out value="${param.rows}" default="10" />" />
            <input type="hidden" name="infId" value="<c:out value="${param.infId}" default="" />" />
            <input type="hidden" name="infSeq" value="<c:out value="${param.infSeq}" default="" />" />
            <input type="hidden" name="order" value="<c:out value="${param.order}" default="" />" />
            <input type="hidden" name="loc" value="<c:out value="${param.loc}" default="" />" />
            <c:forEach items="${paramValues}" var="parameter">
            <c:set var="key" value="${parameter.key}" />
            <c:if test="${key == 'orgCd' || key == 'cateId' || key == 'srvCd' || key == 'infTag' || key == 'searchWord'}">
            <c:forEach items="${parameter.value}" var="value">
            <input type="hidden" name="${key}" value="${value}" />
            </c:forEach>
            </c:if>
            </c:forEach>
        </form>
        
        <form id="searchForm">
        	<c:if test="${empty param.infId}">
        		<input type="hidden" name="infId" value="${infId }">
        	</c:if>
        	<c:if test="${not empty param.infId}">
        		<input type="hidden" name="infId" value="${param.infId}">
        	</c:if>
        	<input type="hidden" name="infSeq" value="${param.infSeq}">
			<c:forEach var="entry" items="${schParams}">
				<c:forEach var="value" items="${entry.value}">
					<input type="hidden" name="${entry.key }" value="${value }">
				</c:forEach>
			</c:forEach>
			<c:forEach var="entry" items="${schHdnParams}">
				<c:forEach var="value" items="${entry.value}">
					<input type="hidden" name="${entry.key }" value="${value }">
				</c:forEach>
			</c:forEach>
		</form>
        
        <%-- <%@ include file="/WEB-INF/jsp/ggportal/data/service/sect/reply.jsp" %> --%>
    </div>
    <!-- // content -->
</div>
<!-- // layout_flex -->
</div>
</div>        
<!-- // wrap_layout_flex -->

</div>
</div>

<%@ include file="/WEB-INF/jsp/portal/sect/footer.jsp" %>

<!-- 데이터셋 활용 목적 팝업 -->
<%-- <%@ include file="/WEB-INF/jsp/ggportal/data/service/popup/dsUsePurp.jsp" %> --%>
</div>
<!-- // layout_A -->
</body>
</html>