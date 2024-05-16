<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>

<!DOCTYPE html>
<html lang="ko">
<head>
<%@ include file="/WEB-INF/jsp/portal/sect/head.jsp" %>
<script type="text/javascript" src="<c:url value="/js/soportal/openapi/openApiGuideCd.js" />"></script>
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
	<nav>
		<div class="lnb">
			<h2>Open API</h2>
			<ul>
	            <li><a href="/portal/openapi/openApiIntroPage.do" class="menu_1">Open API 소개</a></li>
	            <li><a href="/portal/openapi/openApiListPage.do" class="menu_3">Open API 목록</a></li>
	            <li><a href="/portal/openapi/openApiDevPage.do" class="menu_4">개발가이드</a></li>
	            <li><a href="/portal/openapi/openApiActKeyPage.do" class="menu_4">인증키 발급내역</a></li>
			</ul>
		</div>
	</nav>
	<!-- //leftmenu -->
    <!-- content -->
    <article>
		<div class="contents" id="contents">
			<div class="contents-title-wrapper">
				<h3>통계코드 검색<span class="arrow"></span></h3>
        	</div>
        
        <div class="contents-area">
		<!-- CMS 시작 -->
		
	       	<div class="board-area">
				<!-- board search -->
				<fieldset>
					<legend class="blind">검색</legend>
					<p class="total">
						총 <strong id="stat-count-sect" ></strong> 건
					</p>
					<div class="search-wrapper02">
						<div class="search-area02">
							<label for="searchGubun" class="hide">검색구분선택</label>
							<select id="searchGubun" name="searchGubun" title="검색 선택창">
								<option value="STATBL_NM">통계표</option>
								<option value="ITM_NM">항목</option>
							</select>
							<div class="search-box02">
								<label for="openapi-searchword-field" class="blind">통계코드 검색</label>
								<input type="search" id="openapi-searchword-field"  title="검색어 입력" placeholder="검색어를 입력하세요" />
								<input type="submit" class="btn-search" id="openapi-search-button" value="검색" />
							</div>
						</div>
						<a href="javascript:doExcelDown();" class="btn-s04 btns-color08" id="openapi-excel-button" >
							<img src="<c:url value="/images/icon_excel@2x.gif" />" alt="엑셀 다운로드" style="height: 14px;"/>
							<span>엑셀 다운로드</span>
						</a>
					</div>
				</fieldset>
				<!-- //board search -->
				
	        		<div class="board-list01 line01">
						<table id="openapi-data-table" style="width: 100%">
							<caption>
								OPENAPI 통계코드 검색 목록표 : 번호, 통계명, 통계표코드, 통계항목 및 분류코드 조회
							</caption>
							<thead>
								<tr>
									<th class="number" scope="col">번호</th>
									<th class="title" scope="col">통계표명</th>
									<th class="title" scope="col">통계표코드</th>
									<th class="code-search" scope="col">통계항목 및<br />분류 코드조회</th>
								</tr>
							</thead>
							<tbody>
						        <tr>
						            <td colspan="4" >해당 자료가 없습니다.</td>
						        </tr>
					        </tbody>
				        </table>
				        <!-- page -->
				        <div id="stat-pager-sect" class="page"></div>
				        <!-- // page -->
			        </div>
	        	</div>
	        	
	        	<!-- 통계항목 및 분류코드 조회 팝업 레이어 팝업 -->
				<div class="mask"></div>
				<div class="layerpopup-wrapper">
					<div class="layerpopup-area">
						<h2>
							통계항목 및 분류코드 조회 팝업
						</h2>

						<div class="layerpopup-box">
							<ul class="ul-list05 statblCd">
								<li class="statblNm"></li>
								<li class="statblId"></li>
							</ul>

							<div id="tab_B" class="tabmenu-type01">
								<ul class="depth2">
									<li id="tab_B_1" class="on"><a href="#">항목코드</a></li>
									<li id="tab_B_2" style="display:none;"><a href="#">분류코드</a></li>
								</ul>
							</div>
							<div class="table-scroll-area">
								<div id="tab_B_cont_1" class="table-type03 line01">
									<table id="openapi_itm_cd_tb">
										<caption>
											통계항목 및 분류코드 조회 정보표 : 통계항목명, 통계항목코드 정보 제공
										</caption>
										<colgroup>
											<col style="width: 50%" />
											<col style="width: 50%" />
										</colgroup>
										<thead>
											<tr>
												<th scope="col">항목명</th>
												<th scope="col">항목코드</th>
											</tr>
										</thead>
										<tbody>
											<tr>
												<td colspan="2">해당 자료가 없습니다.</td>
											</tr>
										</tbody>
									</table>
								</div>
							</div>
							
							<div class="table-scroll-area">
								<div id="tab_B_cont_2" class="table-type03 line01" style="display:none">
									<table id="openapi_itm_cls_tb">
										<caption>
											통계항목 및 분류코드 조회 정보표 : 통계항목명, 통계항목코드 정보 제공
										</caption>
										<colgroup>
											<col style="width: 50%" />
											<col style="width: 50%" />
										</colgroup>
										<thead>
											<tr>
												<th scope="col">분류명</th>
												<th scope="col">분류코드</th>
											</tr>
										</thead>
										<tbody>
											<tr>
												<td colspan="2">해당 자료가 없습니다.</td>
											</tr>
										</tbody>  
									</table>
								</div>
							</div>
							

						</div>
						<button type="button" class="btn-layerpopup-close">
							<img src="<c:url value="/images/hfportal/btn/btn_close02@2x.gif" />" alt="닫기버튼" />
						</button>
					</div>
				</div>
				<!-- //통계항목 및 분류코드 조회 팝업 레이어 팝업 -->
							
				<form name="excelDownload" method="post"></form>
				<iframe width=0 height=0 name="hide_frame" style="margin-top:0;border:0;" title="엑셀다운로드"></iframe>
							
			<!-- //CMS 끝 -->
			</div>
		</div>
	</article>
	<!-- //contents  -->

	</div>
</section>
<c:import  url="/WEB-INF/jsp/inc/iframepopup.jsp"/>
<!-- //container -->
 <form id="openapi-search-form" name="openapi-search-form" method="post">
 	<input type="hidden" name="page" title="page" value="<c:out value="${param.page}" default="1" />" />
	<input type="hidden" name="rows" title="rows" value="<c:out value="${param.rows}" default="10" />" />
 	<input type="hidden" name="statblId" id="sId" title="statblId" value="" />
</form> 
<%@ include file="/WEB-INF/jsp/portal/sect/footer.jsp" %>
</div>
</body>
</html>