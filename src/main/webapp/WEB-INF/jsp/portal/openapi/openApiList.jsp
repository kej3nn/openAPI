<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>

<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%-- @(#)openApiList.jsp 1.0 2019/08/27                                     --%>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>

<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%-- Open API 목록을 검색하는 화면이다.                      						--%>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<!DOCTYPE html>
<html lang="ko">
<head>
<%@ include file="/WEB-INF/jsp/portal/sect/head.jsp" %>
<script type="text/javascript" src="<c:url value="/js/portal/openapi/openApiList.js" />"></script>
</head>
<body>
<!-- wrapper -->
<div class="wrapper" id="wrapper">
<%@ include file="/WEB-INF/jsp/portal/sect/headerOpen.jsp" %>
<%-- <%@ include file="/WEB-INF/jsp/nbportal/include/navigation.jsp" %> --%>

<!-- container -->
<section>
	<div class="container" id="container">
	<!-- leftmenu -->
	<%@ include file="/WEB-INF/jsp/portal/sect/lnb.jsp" %>
	<!-- //leftmenu -->
	
    <!-- content -->
    <article>
		<div class="contents" id="contents">
			<div class="contents-title-wrapper">
				<h3>Open API 목록<span class="arrow"></span></h3>
        	</div>
        
	        <div class="contents-area">
			<!-- CMS 시작 -->
			
		       	<div class="board-area">
					<!-- board search -->
					<fieldset>
						<legend class="blind">검색</legend>
						<p class="total">
							총 <strong id="dataset-count-sect" ></strong> 건
						</p>
						<div class="search-wrapper">
							<div class="search-area fl">
								<div class="search-box">
									<label class="blind" for="dataset-searchword-field">검색창</label>
									<input type="search" id="dataset-searchword-field"  title="검색어 입력" placeholder="검색어를 입력하세요" />
									<input type="submit" id="dataset-search-button" value="검색" title="검색"/>
								</div>
							</div>
							</div>
						</fieldset>
						<!-- //board search -->
					
		        		<div class="board-list01">
							<table id="dataset-data-table" style="width: 100%">
								<caption>
									Open API 목록 정보표 : 번호, 서비스명, 설명, 등록일, 조회 정보 제공
								</caption>
								<thead>
									<tr>
										<th class="number" scope="col">
											번호
										</th>
										<th class="name" scope="col">
											서비스명
										</th>
										<th class="title" scope="col">
											설명
										</th>
										<th class="date" scope="col">
											등록일
										</th>
										<th class="hit" scope="col">
											조회
										</th>
									</tr>
								</thead>
								<tbody>
							        <tr>
							            <td colspan="5" >해당 자료가 없습니다.</td>
							        </tr>
						        </tbody>
					        </table>
					        <!-- page -->
					        <div id="dataset-pager-sect"></div>
					        <!-- // page -->
		        
						<!-- //CMS 끝 -->
						</div>
					</div>
				</div>
			</div>
		</article>
		<!-- //contents  -->

	</div>
</section>
<!-- //container -->
 <form id="dataset-search-form" name="dataset-search-form" method="post">
    <input type="hidden" name="page" value="<c:out value="${param.page}" default="1" />" />
    <input type="hidden" name="rows" value="<c:out value="${param.rows}" default="10" />" />
    <input type="hidden" name="infId" value="<c:out value="${param.infId}" default="" />" />
    <input type="hidden" name="infSeq" value="<c:out value="${param.infSeq}" default="" />" />
    <input type="hidden" name="order" value="<c:out value="${param.order}" default="" />" />
    <input type="hidden" name="srvCd" value="A" />
    <c:forEach items="${paramValues}" var="parameter">
    <c:set var="key" value="${parameter.key}" />
    <c:if test="${key == 'orgCd' || key == 'cateId' || key == 'srvCd' || key == 'schwTagCont' || key == 'searchWord'}">
    <c:forEach items="${parameter.value}" var="value">
    <input type="hidden" name="${key}" value="${value}" />
    </c:forEach>
    </c:if>
    </c:forEach>
</form> 
<%@ include file="/WEB-INF/jsp/portal/sect/footer.jsp" %>
</div>
</body>
</html>