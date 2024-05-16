<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%-- @(#)openApiDetail.jsp 1.0 2019/08/27                                   --%>
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
<%-- 오픈API 서비스를 조회하는 화면이다.                                    --%>
<%--                                                                        --%>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<!DOCTYPE html>
<html lang="ko">
<head>
<c:set var="title" value="${data.infNm}" />
<c:set var="description" value="${fn:replace(data.infExp, constants.LINE_FEED, '')}" />
<c:set var="lvl3MenuSuffix" value= "Open API" />
<%@ include file="/WEB-INF/jsp/portal/sect/head.jsp" %>
<script type="text/javascript" src="<c:url value="/js/portal/openapi/openApiDetail.js" />"></script>
</head>
<body>
<!-- wrapper -->
<div class="wrapper" id="wrapper">
<%@ include file="/WEB-INF/jsp/portal/sect/headerOpen.jsp" %>

<!-- container -->
<section>
	<div class="container" id="container">
	<!-- leftmenu -->
	<nav>
		<div class="lnb">
			<h2>Open API</h2>
			<ul>
	            <li><a href="/portal/openapi/openApiIntroPage.do" class="menu_1">Open API 소개</a></li>
	            <li><a href="/portal/openapi/openApiListPage.do" class="menu_3 selected">Open API 목록</a></li>
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
				<h3>Open API 목록<span class="arrow"></span></h3>
        	</div>
        	
        	<form id="openapi-search-form" name="openapi-search-form" method="post">
	            <input type="hidden" name="infId" value="<c:out value="${param.infId}" default="" />" />
	            <input type="hidden" name="infSeq" value="<c:out value="${param.infSeq}" default="" />" />
        	</form>	
        	
	        <div class="contents-area">
	        
			<!-- CMS 시작 -->
			    <div class="contents-box">        
					<div class="gray-box01">
						<div class="word-type02">
							서비스명을 선택하세요. 상세주소, 요청인자, 샘플url, 예제 등을 확인 하실 수 있습니다.
						</div>

						<div class="statement-download-wrapper">
							<label for="apiSrv" class="hide">서비스명 선택</label>
							<select name="apiSrv" id="apiSrv" title="서비스명 선택">
								
							</select>
							<a id="openapi-download-button" href="#" class="btnType01">
								<span>
									개발명세서 다운로드
								</span>
								<img src="<c:url value="/images/icon_download@2x.png" />" alt="다운화살표" />
							</a>
						</div>
					</div>
				</div>	
				
				<div class="contents-box">
					<h4 class="title0401">
						상세주소
					</h4>
					<p class="detail-address-information apiEp apiRes"></p>
				</div>
        		
        		<div class="contents-box">
					<h4 class="title0401">기본인자</h4>
	            	<div class="table-type01">
						<table>
						<caption>
							기본인자 정보표 : 변수명, 타입, 필수여부, 값설명 정보 제공
						</caption>
						<colgroup>
							<col style="width: 20%" />
							<col style="width: 23%" />
							<col style="width: 23%" />
							<col style="width: 34%" />
						</colgroup>
						<thead>
							<tr>
							<th scope="col">변수명</th>
							<th scope="col">타입</th>
							<th scope="col">필수여부</th>
							<th scope="col" class="line-none">값설명</th>
						</tr>
						</thead>
						<tbody>
						<tr>
							<td>KEY</td>
							<td>STRING <span class="span-br-mobile01">(필수)</span></td>
							<td>인증키</td>
							<td class="line-none">기본값 : <span class="span-br-mobile01">sample key</span></td>
						</tr>
						<tr>
							<td>Type</td>
							<td>STRING <span class="span-br-mobile01">(필수)</span></td>
							<td>호출 문서 <span class="span-br-mobile01">(xml, json)</span></td>
							<td class="line-none">기본값 : xml</td>
						</tr>
						<tr>
							<td>pIndex</td>
							<td>INTEGER <span class="span-br-mobile01">(필수)</span></td>
							<td>페이지 <span class="span-br-mobile01">위치</span></td>
							<td class="line-none">기본값 : <span class="span-br-mobile01">1(sample key는 1 고정)</span></td>
						</tr>
						<tr>
							<td>pSize</td>
							<td>INTEGER <span class="span-br-mobile01">(필수)</span></td>
							<td>페이지 당 <span class="span-br-mobile01">요청 숫자</span></td>
							<td class="line-none">기본값 : <span class="span-br-mobile01">100(sample key는 5 고정)</span></td>
						</tr>
						</tbody>
					</table>
            		</div>
            	</div>	
            	
            	<div class="contents-box">	
           			<h4 class="title0401">요청인자</h4>
            		<div class="table-type01">
			            <table id="openapi-variables-table">
				            <caption>요청인자 목록</caption>
				            <colgroup>
				                <col style="width:20%" />
				                <col style="width:23%" />
				                <col style="width:57%" />
				            </colgroup>
				            <thead>
				            <tr>
				                <th scope="col">변수명</th>
				                <th scope="col">타입</th>
				                <th scope="col" class="line-none">변수 설명</th>
				            </tr>
				            </thead>
				            <tbody>
				            <tr>
				                <td colspan="3" class="line-none">해당 자료가 없습니다.</td>
				            </tr>
				            </tbody>
			            </table>
		            </div>
            	</div>
		           	 		            
		            <div class="contents-box mb10">
		            	<!-- tab -->
						<div id="tab_B" class="tabmenu-type01">
							<ul>
								<li id="tab_B_1" class="on"><a href="#">출력값</a></li>
								<li id="tab_B_2"><a href="#">샘플URL</a></li>
								<li id="tab_B_3"><a href="#">샘플 테스트</a></li>
								<li id="tab_B_4"><a href="#">메시지 설명</a></li>
							</ul>					
					    </div>
		           		<!-- // tab -->
		            
			            <!-- 출력값 -->
			            <div id="tab_B_cont_1" class="tab-contents-wrapper">
							<h4 class="title0401">
								출력값(Out Result)
							</h4>
		           			<div class="table-type01">
								<table id="openapi-columns-table">
									<caption>
										출력값 (Out Result) 목록 : 순번, 출력명, 출력설명 정보제공
									</caption>
									<colgroup>
										<col style="width: 12%" />
										<col style="width: 45%" />
										<col style="width: 42%" />
									</colgroup>
									<thead>
										<tr>
											<th scope="col">순번</th>
											<th scope="col">출력명</th>
											<th scope="col" class="line-none">출력설명</th>
										</tr>
									</thead>
									<tbody>
						                <tr>
						                    <td colspan="3" class="line-none">해당 자료가 없습니다.</td>
						                </tr>
					                </tbody>
				                </table>
			                </div>
		                </div>
			            <!-- // 출력값 -->
			            
			            <!-- 샘플 URL -->
			            <div id="tab_B_cont_2" class="tab-contents-wrapper" style="display:none">
							<h4 class="title0401">
								샘플URL
							</h4>
							<div class="table-type01">
								<table id="openapi-urls-table" style="border-collapse: separate">
									<caption>
										Open API 샘플 URL 정보표 : No, 출력명, URL 정보제공
									</caption>
									<colgroup>
										<col style="width: 15%" />
										<col style="width: 25%" />
										<col style="width: 50%" />
									</colgroup>
									<thead>
										<tr>
											<th scope="col">No</th>
											<th scope="col">출력명</th>
											<th scope="col">URL</th>
										</tr>
									</thead>
									<tfoot>
										<!-- 공간 만들기 위해 추가 기능적인 면은 없음 -->
										<tr>
											<td colspan="3" class="line-none"></td>
										</tr>
										<!-- //공간 만들기 위해 추가 기능적인 면은 없음 -->
										<tr>
											<td>
												결과
											</td>
											<td class="left">  
												※ URL을 클릭하면 결과를 확인할 수 있습니다.
											</td>
											<td id="openapi-urls-table2" class="line-none left" style="padding: 10px">
											</td>
										</tr>
									</tfoot>
									<tbody>
									</tbody>
								</table>
							</div>
						</div>	
		          
		          			<!-- // 샘플 URL -->
			            
			            <!-- 샘플 test -->
			            <div id="tab_B_cont_3" class="tab-contents-wrapper" style="display:none">
							<h4 class="title0401">
								Open API 테스트
							</h4>
		
							<p class="word-type03 pl15 mb10">
								OpenAPI 서비스의 요청인자에 값을 입력하고 검색버튼을 클릭하여 해당 서비스의 xml 형태의 응답을 확인해 볼 수 있습니다.
							</p>
							
							<div class="table-type02">
								<form id="openapi-request-form" name="openapi-request-form" action="#" method="post">	
								<table>
								<caption>OpenAPI 테스트</caption>
								<colgroup>
									<col style="width: 25%" />
									<col style="width: 75%" />
								</colgroup>
								<tbody>
									<tr>
										<th scope="row">서비스</th>
										<td class="left line-none">
											<strong id="openapi-sampleTest-infNm"></strong>
											<a id="openapi-request-button" href="#" class="btn-s btns-color06 btn-db-search">검색</a>
										</td>
									</tr>
									<tr>
										<th scope="row">통계코드</th>
										<td class="left line-none">
											<div id="openapi-filters-table" class="input-code-wrapper">
												
											</div>
										</td>
									</tr>
									<tr>
										<th scope="row">API 결과</th>
										<td class="left line-none">
											<p id="sampleTestUrl" class="word-type03 mb10 apiEp apiRes apiFilt">
											</p>

											<div class="smaple-ex-wrapper">
												<pre id="apiSampleTest" class="pre-box"></pre>
											</div>
										</td>
									</tr>
								</tbody>
							</table>
							</form>
							</div>
		               	</div>
		          		 <!-- // 샘플 test -->
	            
			            <!-- 메시지 설명 -->
			            <div id="tab_B_cont_4" class="tab-contents-wrapper" style="display:none">
			                <h4 class="title0401 mb0">
								에러 및 정보배치
							</h4>
							<div class="table-type01">
				                <table id="openapi-messages-table" >
					                <caption>메시지 설명</caption>
					                <colgroup>
					                    <col style="width: 20%" />
										<col style="width: 15%" />
										<col style="width: 65%" />
					                </colgroup>
					                <thead>
					                <tr>
					                    <th scope="col">구분</th>
					                    <th scope="col">코드</th>
					                    <th scope="col" class="line-none">설명</th>
					                </tr>
					                </thead>
					                <tbody>
					                <tr>
					                    <td colspan="3" class="line-none">해당 자료가 없습니다.</td>
					                </tr>
					                </tbody>
			                </table>			
				            </div>
			            </div> 
		            	<!-- // 메시지 설명 -->
  					</div>
  			
	  				<div class="btn-right pt0">
						<a id="dataset-search-button" href="#" class="btn_A">목록</a>
					</div>
					
	  			<!-- //CMS 끝 -->
				</div>
			</div>
		</article>
		<!-- //contents  -->
	</div>
</section>
<form id="dataset-search-form" name="dataset-search-form" method="post">
      <input type="hidden" name="page" value="<c:out value="${param.page}" default="1" />" />
      <input type="hidden" name="rows" value="<c:out value="${param.rows}" default="10" />" />
      <input type="hidden" name="infId" value="<c:out value="${param.infId}" default="" />" />
      <input type="hidden" name="infSeq" value="<c:out value="${param.infSeq}" default="" />" />
      <input type="hidden" name="order" value="<c:out value="${param.order}" default="" />" />
      <c:forEach items="${paramValues}" var="parameter">
      <c:set var="key" value="${parameter.key}" />
      <c:if test="${key == 'orgCd' || key == 'cateId' || key == 'srvCd' || key == 'infTag' || key == 'searchWord'}">
      <c:forEach items="${parameter.value}" var="value">
      <input type="hidden" name="${key}" value="${value}" />
      </c:forEach>
      </c:if>
      </c:forEach>
  </form>
<!-- //container -->
<%@ include file="/WEB-INF/jsp/portal/sect/footer.jsp" %>
</div>
<!-- //wrapper -->
</body>
</html>