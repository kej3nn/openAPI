<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
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
<%-- @Modifiers 장홍식                                                         --%>
<%-- @version 1.0 2015/08/06                                              --%>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<!DOCTYPE html>
<html lang="ko">
<head>
<c:set var="title" value="${data.infNm}" />
<c:set var="description" value="${fn:replace(data.infExp, constants.LINE_FEED, '')}" />
<c:set var="lvl3MenuSuffix" value= "Sheet" />
<%@ include file="/WEB-INF/jsp/ggportal/sect/head.jsp" %>
<script type="text/javascript" src="<c:url value="/js/ggportal/data/service/selectOpenApi.js" />"></script>
<script type="text/javascript">

// history.pushState(null, null, location.href); 
// window.onpopstate = function(event) { 
// 	//history.go(1); 
// 	searchDataset();
// }

/**
 * 우리 지역 찾기 목록 화면으로 이동
 */
function searchDataset() {
    goSearch({
        url:"/portal/data/village/selectListDataByCityPage.do",
        form:"dataset-search-form"
    });
}

</script>
</head>
<body>
<!-- layout_A -->
<div class="layout_A">
<%@ include file="/WEB-INF/jsp/ggportal/sect/header.jsp" %>
<!-- wrap_layout_flex -->
<div class="wrap_layout_flex"><div class="layout_flex_100">
<%@ include file="/WEB-INF/jsp/ggportal/sect/gnb.jsp" %>

<!-- layout_flex #################### -->
<div class="layout_flex">
	<div id="content" class="content_B">
		<!-- location -->
        <%@ include file="/WEB-INF/jsp/ggportal/sect/navigation.jsp" %>
        <h2 class="hide"><c:out value="${requestScope.menu.lvl1MenuPath}" /></h2>
		<div class="area_h3 area_h3_AB area_h3_AC deco_h3_1">
			<h3 class="ty_A"><img src="<c:url value="/img/ggportal/desktop/data/h3_1_3.png"/>" alt="우리 지역 데이터 찾기" /><strong>우리 지역 데이터 찾기</strong></h3>
			<p>지도 기반으로 우리 지역 관련 공공데이터를 손쉽게 찾으실 수 있습니다.</p>
		</div>
        <%@ include file="/WEB-INF/jsp/ggportal/data/village/service/sect/meta.jsp" %>
        <%@ include file="/WEB-INF/jsp/ggportal/data/village/service/sect/tabs.jsp" %>
        <form id="openapi-search-form" name="openapi-search-form" method="post">
            <input type="hidden" name="infId" value="<c:out value="${param.infId}" default="" />" />
            <input type="hidden" name="infSeq" value="<c:out value="${param.infSeq}" default="" />" />
        </form>
        <!-- Open API -->
        <section class="section_OpenAPI">
            <h4 class="hide">Open API</h4>
            <!-- area_btn_D -->
            <div class="area_btn_D">
                <a href="<c:url value="/portal/bbs/develop/searchBulletinPage.do?tab=2" />" class="btn_D" target="_blank">Open API란</a>
                <a href="<c:url value="/portal/myPage/actKeyPage.do?tabIdx=1" />" class="btn_D" target="_blank">인증키 신청</a>
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
                <iframe id="openapi-response-iframe-0" name="openapi-response-iframe-0" class="iframe_sampleURL openapi-response-iframe" title="샘플 URL" style="width:100%; marginwidth:0px; marginheight:0px; frameborder:0; scrolling:no;"></iframe>
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
                <div class="box_A OpenAPI_address">
                    <ul class="list_B">
                    <li>요청주소 : <span class="apiEp apiRes apiFilt"></span></li>
                    </ul>
                </div>
                <iframe id="openapi-response-iframe-1" name="openapi-response-iframe-1" class="iframe_sampleTest openapi-response-iframe" title="샘플 테스트" style="width:100%; marginwidth:0px; marginheight:0px; frameborder:0; scrolling:no;"></iframe>
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
        <!-- // btn_A -->
        <form id="dataset-search-form" name="dataset-search-form" method="post">
            <input type="hidden" name="page" value="<c:out value="${param.page}" default="1" />" />
            <input type="hidden" name="rows" value="<c:out value="${param.rows}" default="10" />" />
            <input type="hidden" name="infId" value="<c:out value="${param.infId}" default="" />" />
            <input type="hidden" name="infSeq" value="<c:out value="${param.infSeq}" default="" />" />
            <c:forEach items="${paramValues}" var="parameter">
            <c:set var="key" value="${parameter.key}" />
            <c:if test="${key == 'orgCd' || key == 'cateId' || key == 'srvCd' || key == 'infTag' || key == 'searchWord' || key == 'sigunFlag'}">
            <c:forEach items="${parameter.value}" var="value">
            <input type="hidden" name="${key}" value="${value}" />
            </c:forEach>
            </c:if>
            </c:forEach>
        </form>
    </div>
    <!-- // content -->
</div>
<!-- // layout_flex -->
</div></div>        
<!-- // wrap_layout_flex -->
<%@ include file="/WEB-INF/jsp/ggportal/sect/footer.jsp" %>

<%@ include file="/WEB-INF/jsp/ggportal/data/village/popup/map.jsp" %>
</div>
<!-- // layout_A -->
</body>
</html>




