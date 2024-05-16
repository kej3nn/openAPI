<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>

<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%-- @(#)searchDataset.jsp 1.0 2015/06/15                                   --%>
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

<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%-- 공공데이터 데이터셋 전체목록을 검색하는 화면이다.                      --%>
<%--                                                                        --%>
<%-- @author 김은삼                                                         --%>
<%-- @version 1.0 2015/06/15                                                --%>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<!DOCTYPE html>
<html lang="ko">
<head>
<%@ include file="/WEB-INF/jsp/ggportal/sect/head.jsp" %>
<script type="text/javascript" src="<c:url value="/js/ggportal/data/dataset/searchDataset.js" />"></script>
</head>
<body>
<!-- layout_A -->
<div class="layout_A">
<%@ include file="/WEB-INF/jsp/ggportal/sect/header.jsp" %>
<!-- wrap_layout_flex -->
<div class="wrap_layout_flex fix_page"><div class="layout_flex_100">
<%@ include file="/WEB-INF/jsp/ggportal/sect/gnb.jsp" %>
<!-- menu_sort -->
<div class="area_menu_sort"><div class="menu_sort">
    <div class="sort mq_tablet">
        <c:forEach items="${data}" var="item" varStatus="status">
        <span><a href="#<c:out value="${item.cateId}" />" class="sort_<c:out value="${status.count}" /> dataset-category-button"><strong><c:out value="${item.cateNm}" /></strong></a></span>
        </c:forEach>
    </div>
</div></div>
<!-- // menu_sort -->
<!-- layout_flex -->
<div class="layout_flex">
    <%@ include file="/WEB-INF/jsp/ggportal/data/dataset/sect/lnb.jsp" %>
    <!-- content -->
    <div class="content">
		<a href="#none" id="content" class="hide">본문시작</a>
        <%@ include file="/WEB-INF/jsp/ggportal/sect/navigation.jsp" %>
        <h2 class="hide"><c:out value="${requestScope.menu.lvl1MenuPath}" /></h2>
        <div class="area_h3 deco_h3_1">
            <h3 class="ty_A"><span>공공데이터 개방포털</span><strong>데이터셋</strong></h3>
            <span id="dataset-keyword-sect" class="sort"></span>
            <p>데이터의 특성을 고려하여 Sheet, Chart, Map, File, Link 서비스와 개발자를 위한 Open API 서비스 등<br /> 
            편리하게 데이터를 활용할 수 있도록 다양한 방식으로 서비스를 제공합니다.</p>
        </div>
        <div class="area_menu_sort_mobile"> 
            <select id="dataset-category-combo" title="데이터셋 분류 선택">
                <option value="">전체</option>
                <c:forEach items="${data}" var="item" varStatus="status">
                <option value="<c:out value="${item.cateId}" />"><c:out value="${item.cateNm}" /></option>
                </c:forEach>
            </select>
        </div>
        <ul class="search">
        <li>
            <dl class="flL">
            <dt>유형선택</dt>
            <dd>
                <a href="#S" class="dataset-service-button btn_B">SHEET</a>
                <a href="#C" class="dataset-service-button btn_B">CHART</a>
                <a href="#M" class="dataset-service-button btn_B">MAP</a>
                <a href="#F" class="dataset-service-button btn_B">FILE</a>
                <a href="#A" class="dataset-service-button btn_B">API</a>
                <a href="#L" class="dataset-service-button btn_B">LINK</a>
            </dd>
            </dl>
            <span class="desc">복수 선택 가능</span>
        </li>
        <li id="dataset-keyword-list" class="area_sort_bestTag hide">
        </li>
        <li>
            <ul class="ty_A flL mq_tablet">
                <li>전체 <strong id="dataset-count-sect" class="totalNum"></strong>건, <span id="dataset-pages-sect" class="pageNum"></span></li>
            </ul>
       <div class="flR">
<!--             <select id="dataset-rows-combo" class="flR mq_PC" title="목록갯수 선택"> -->
			 <select id="dataset-rows-combo"  title="목록갯수 선택">
                <option value="10">10개씩보기</option>
                <option value="30">30개씩보기</option>
                <option value="50">50개씩보기</option>
            </select>
            <!-- <a href="#none" class="selcBtn">확인</a> -->
         </div>
        </li>
        </ul>
        <table id="dataset-data-table" class="table_boardList_A">
        <caption>데이터셋 목록</caption>
        <colgroup>
            <col style="width:56%;" /> 
            <col style="width:16%;" />
            <col style="width:8%;" />
            <col style="width:11%;" />
            <col style="width:9%;" />
        </colgroup>
        <thead>
        <tr>
            <th scope="col">서비스</th>
            <th scope="col">서비스 유형</th>
            <th scope="col">조회수</th>
            <th scope="col">등록일자<br>최종수정일자</th>
            <th scope="col">분류</th>
        </tr>
        </thead>
        <tbody>
        <tr>
            <td colspan="5" class="noData">해당 자료가 없습니다. </td>
        </tr>
        </tbody>
        </table>
        <div class="search_B">
            <span class="search">
                <input type="search" id="dataset-searchword-field" autocomplete="on" placeholder="결과내 재검색" title="결과내 재검색" style="ime-mode:active;" /><a id="dataset-search-button" href="#" class="btn_search"><span>검색</span></a>
            </span>     
        </div>
        <!-- page -->
        <div id="dataset-pager-sect" class="page"></div>
        <!-- // page -->
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
    </div>
    <!-- // content -->
</div>
<!-- // layout_flex -->
</div></div>        
<!-- // wrap_layout_flex -->
<%@ include file="/WEB-INF/jsp/ggportal/sect/footer.jsp" %>
</div>
<!-- // layout_A -->
</body>
</html>