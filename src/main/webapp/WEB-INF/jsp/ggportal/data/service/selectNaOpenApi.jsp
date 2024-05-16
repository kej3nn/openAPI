<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%-- @(#)selectNaOpenApi.jsp 1.0 2019/10/11                                 --%>
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
<%-- 공공데이터 오픈API 서비스(국회사무처 OPEN API 별도페이지)     			--%>
<%--                                                                        --%>
<%-- @author JHKIM                                                         --%>
<%-- @version 1.0 2019/10/11                                                --%>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<!DOCTYPE html>
<html lang="ko">
<head>
<c:set var="title" value="${data.infNm}" />
<c:set var="description" value="${fn:replace(data.infExp, constants.LINE_FEED, '')}" />
<c:set var="lvl3MenuSuffix" value= "API" />
<%@ include file="/WEB-INF/jsp/portal/sect/head.jsp" %>
<script type="text/javascript" src="<c:url value="/js/ggportal/data/service/selectNaOpenApi.js" />"></script>

<script type="text/javascript">
// 	history.pushState(null, null, location.href); 
// 	window.onpopstate = function(event) { 
// 		//history.go(1); 
// 		searchDataset();
// 	}
</script>
</head>
<body>
<!-- layout_A -->
<div class="layout_A">
<%@ include file="/WEB-INF/jsp/portal/sect/headerOpen.jsp" %>
<div class="container hide-pc-lnb" id="container">
<!-- contents -->
	<div class="contents" id="contents">
		<div class="contents-title-wrapper">
			<h3>Open API 상세<span class="arrow"></span></h3>
			<h3 style="padding-left:40px;">
				<c:set var="oInfIds" value="${fn:split(data.openInfIds,'|')}" />
				<c:set var="oOpenDttms" value="${fn:split(data.openDttms,'|')}" />
				<c:set var="apiMenu" value="openAPIDetail"/>
				
			</h3>
		</div>
		
<!-- wrap_layout_flex -->
<div class="wrap_layout_flex"><div class="layout_flex_100">

<!-- layout_flex -->
<div class="layout_flex">
    <!-- content -->
    <div id="content" class="content_B">
        <%@ include file="/WEB-INF/jsp/ggportal/data/service/sect/meta.jsp" %>
        <!-- tab_A -->
        <div class="tab_A">
            <a href="#<c:out value="${data.acolInfSeq}" />" class="service-select-tab on">API</a>
        </div>
        <form id="openapi-search-form" name="openapi-search-form" method="post">
            <input type="hidden" name="infId" value="<c:out value="${data.infId}" default="" />" />
            <input type="hidden" name="infSeq" value="<c:out value="${data.infSeq}" default="" />" />
        </form>
        <!-- Open API -->
        <section class="section_OpenAPI">
            <h4 class="hide">Open API</h4>
            <!-- area_btn_D -->
            <div class="area_btn_D">
                <a href="<c:url value="/portal/openapi/openApiIntroPage.do" />" class="btn_D" target="_blank">Open API란</a>
                <a href="<c:url value="/portal/openapi/openApiActKeyPage.do?tabIdx=1" />" class="btn_D" target="_blank">인증키 신청</a>
                <a id="openapi-download-button" href="#" class="btn_D">명세서 다운로드</a>
            </div>
            <!-- // area_btn_D -->
            <div class="box_A OpenAPI_address">
                <ul class="list_B">
                <li>요청주소 : <span class="apiEp apiRes"></span></li>
                <li>요청제한횟수 : <span class="apiTrf"></span></li>
                </ul>
            </div>
            <h5 class="ty_A">기본인자</h5>
            <table class="table_boardList_B">
            <caption>기본인자 목록</caption>
            <colgroup>
                <col style="width:18%;" />
                <col style="width:18%;" />
                <%--
                <col style="width:18%;" />
                <col style="width:46%;" />
                --%>
                <col style="width:32%;" />
                <col style="width:32%;" />
            </colgroup>
            <thead>
            <tr>
                <th scope="col">변수명</th>
                <th scope="col">타입</th>
                <th scope="col">변수 설명</th>
                <th scope="col" class="mq_tablet">설명</th>
            </tr>
            </thead>
            <tbody>
            <tr>
                <td>KEY</td>
                <td>STRING(필수)</td>
                <td>인증키</td>
                <td class="talL mq_tablet">기본값 : sample key</td>
            </tr>
            <tr>
                <td>Type</td>
                <td>STRING(필수)</td>
                <td>호출 문서(xml, json)</td>
                <td class="talL mq_tablet">기본값 : xml</td>
            </tr>
            <tr>
                <td>pIndex</td>
                <td>INTEGER(필수)</td>
                <td>페이지 위치</td>
                <td class="talL mq_tablet">기본값 : 1(sample key는 1 고정)</td>
            </tr>
            <tr>
                <td>pSize</td>
                <td>INTEGER(필수)</td>
                <td>페이지 당 요청 숫자</td>
                <td class="talL mq_tablet">기본값 : 100(sample key는 5 고정)</td>
            </tr>
            </tbody>
            </table>
            <h5 class="ty_A">요청인자</h5>
            <table id="openapi-variables-table" class="table_boardList_B">
            <caption>요청인자 목록</caption>
            <colgroup>
                <col style="width:18%;" />
                <col style="width:18%;" />
                <%--
                <col style="width:18%;" />
                <col style="width:46%;" />
                --%>
                <col style="width:32%;" />
                <col style="width:32%;" />
            </colgroup>
            <thead>
            <tr>
                <th scope="col">변수명</th>
                <th scope="col">타입</th>
                <th scope="col">변수 설명</th>
                <th scope="col">변수 예시</th>
                <%--
                <th scope="col" class="mq_tablet">설명</th>
                --%>
            </tr>
            </thead>
            <tbody>
            <tr>
                <%--
                <td colspan="4" class="noData">해당 자료가 없습니다.</td>
                --%>
                <td colspan="4" class="noData">해당 자료가 없습니다.</td>
            </tr>
            </tbody>
            </table>
            <!-- tab -->
            <div id="tab_B" class="tab_B">
                <a href="#none" id="tab_B_1"  class="on"><strong>출력값</strong></a>
                <a href="#none" id="tab_B_2"><strong>샘플 URL</strong></a>
                <a href="#none" id="tab_B_3"><strong>샘플 test</strong></a>
                <a href="#none" id="tab_B_4"><strong>메시지 설명</strong></a>
            </div>
            <!-- // tab -->
            <!-- 출력값 -->
            <section id="tab_B_cont_1" class="tab_B_cont">
                <h5 class="hide">출력값</h5>
                <table id="openapi-columns-table" class="table_boardList_B">
                <caption>출력값</caption>
                <colgroup>
                    <col style="width:8%;" class="mq_tablet" />
                    <col style="width:28%;" />
                    <%--
                    <col style="width:32%;" />
                    <col style="width:32%;" />
                    --%>
                    <col style="width:64%;" />
                </colgroup>
                <thead>
                <tr>
                    <th scope="col" class="mq_tablet">No</th>
                    <th scope="col">출력명</th>
                    <th scope="col">출력 설명</th>
                    <%--
                    <th scope="col">설명</th>
                    --%>
                </tr>
                </thead>
                <tbody>
                <tr>
                    <%--
                    <td colspan="4" class="noData">해당 자료가 없습니다.</td>
                    --%>
                    <td colspan="3" class="noData">해당 자료가 없습니다.</td>
                </tr>
                </tbody>
                </table>
            </section>
            <!-- // 출력값 -->
            <!-- 샘플 URL -->
            <section id="tab_B_cont_2" class="tab_B_cont" style="display:none">
                <h5 class="hide">샘플 URL</h5>
                <table id="openapi-urls-table" class="table_boardList_B">
                <caption>샘플 URL</caption>
                <colgroup>
                    <col style="width:8%;" />
                    <col style="width:28%;" />
                    <col style="width:64%;" />
                </colgroup>
                <thead>
                <tr>
                    <th scope="col">No</th>
                    <th scope="col">출력명</th>
                    <th scope="col">URL</th>
                </tr>
                </thead>
                <tbody>
                <tr>
                    <td colspan="3" class="noData">해당 자료가 없습니다.</td>
                </tr>
                </tbody>
                </table>
                <!-- <iframe id="openapi-response-iframe-0" name="openapi-response-iframe-0" class="iframe_sampleurl openapi-response-iframe" title="샘플 url" style="width:100%; marginwidth:0px; marginheight:0px; frameborder:0; scrolling:no;"></iframe> -->
            </section>
            <!-- // 샘플 URL -->
            <!-- 샘플 test -->
            <section id="tab_B_cont_3" class="tab_B_cont" style="display:none">
                <h5 class="hide">샘플 test</h5>
                <!-- search -->
                <form id="openapi-request-form" name="openapi-request-form" action="#" method="post">
                <fieldset>
                <legend>샘플 test 검색</legend>
                <div id="search_C" class="view_search_C">
                    <table id="openapi-filters-table" class="table_search_C width_D">
                    <caption>검색</caption>
                    </table>
                    <span class="area_btn_search_C"><a id="openapi-request-button" href="#" class="btn_A">검색</a></span>
                </div>
                </fieldset>
                </form>
                <!-- // search -->
                <!-- <div class="box_A OpenAPI_address">
                    <ul class="list_B">
                    <li>요청주소 : <span class="apiEp apiRes apiFilt"></span></li>
                    </ul>
                </div> -->
                <!-- <iframe id="openapi-response-iframe-1" name="openapi-response-iframe-1" class="iframe_sampleTest openapi-response-iframe" title="샘플 테스트" style="width:100%; marginwidth:0px; marginheight:0px; frameborder:0; scrolling:no;"></iframe> -->
                <div>
					<table class="table_boardList_B" style="margin-top: 10px;">
                        <caption>OpenAPI 샘플 테스트</caption>
						<colgroup>
		                    <col style="width:30%;"><col style="width:70%;">
		                </colgroup>
						<thead>
							<tr><th scope="col">구분</th><th scope="col">Open API 샘플 테스트</th></tr>
						</thead>
						<tbody>
							<tr>
								<td>요청주소</td><td><span class="apiEp apiRes apiFilt" id="sampleTestUrl"></span></td>
							</tr>					
							<tr>
								<td>API 결과</td>
								<td class="talL">
									<pre class="pre-box" id="apiSampleTest">									
									</pre>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
            </section>
            <!-- // 샘플 test -->
            <!-- 메시지 설명 -->
            <section id="tab_B_cont_4" class="tab_B_cont" style="display:none">
                <h5 class="hide">메시지 설명</h5>
                <table id="openapi-messages-table" class="table_boardList_B">
                <caption>메시지 설명</caption>
                <colgroup>
                    <col style="width:18%;" />
                    <col style="width:18%;" />
                    <col style="width:64%;" />
                </colgroup>
                <thead>
                <tr>
                    <th scope="col">구분</th>
                    <th scope="col">코드</th>
                    <th scope="col">설명</th>
                </tr>
                </thead>
                <tbody>
                <tr>
                    <td colspan="3" class="noData">해당 자료가 없습니다.</td>
                </tr>
                </tbody>
                </table>
            </section>
            <!-- // 메시지 설명 -->
        </section>
        <!-- // Open API -->

        <!-- btn_A -->
        <div class="area_btn_A">
            <a id="dataset-search-button" href="#" class="btn_A">목록</a>
        </div>
        
 					<!-- 추천 데이터 셋 -->
					<!-- <div class="recommendDataset">
						<dl>
							<dt>연관 데이터셋</dt>
							<dd>
								<div class="dataSet">
									<div class="btn_slide">
										<a href="#none" class="prev" id="dataset_prev" title="이전 갤러리 이동">이전</a>
										<a href="#none" class="next" id="dataset_next" title="다음 갤러리 이동">다음</a>
									</div>

									<ul class="dataSetSlider bxslider">

									</ul>
									
								</div>
							</dd>
						</dl>
					</div> -->
					<!-- // 추천 데이터 셋 -->
        
        <!-- // btn_A -->
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
        
        <form id="searchForm">
        	<c:if test="${empty param.infId}">
        		<input type="hidden" name="infId" value="${infId}">
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
    </div>
    <!-- // content -->
</div>
<!-- // layout_flex -->
</div></div>        
<!-- // wrap_layout_flex -->

</div>
</div>        

<%@ include file="/WEB-INF/jsp/portal/sect/footer.jsp" %>
</div>
<!-- // layout_A -->
</body>
</html>