<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>

<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%-- @(#)searchWorkPay.jsp 1.0 2019/08/12                                   --%>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>

<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ 	--%>
<%-- 정보공개 > 업무추진비                 																												   	--%>
<%--                                                                        																						--%>
<%-- @author SoftOn                                                         								 												--%>
<%-- @version 1.0 2019/07/22                                                																			--%>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ 	--%>
<!DOCTYPE html>
<html lang="ko">
<head>
<!-- head include -->
<%@ include file="/WEB-INF/jsp/portal/sect/head.jsp" %>
</head>
<body>

<!-- header html -->
<%@ include file="/WEB-INF/jsp/portal/sect/header.jsp" %>
<div class="container" id="container">
<!-- leftmenu -->
<%@ include file="/WEB-INF/jsp/portal/sect/lnb.jsp" %>
<!-- //leftmenu -->

<!-- contents -->
	<div class="contents" id="contents">
		<div class="contents-title-wrapper">
			<h3>업무추진비<span class="arrow"></span></h3>
        </div>

	
<div class="layout_flex">
    <!-- content -->
    <div class="layout_flex_100">
		<h2 class="hide">업무추진비</h2>
		<div class="area_h3 area_h3_AB deco_h3_3 mb30">
			<h3 class="ty_A"><strong>업무추진비</strong></h3>
			<p><strong class="point-color02" style="vertical-align: top;">조회목록의 파일</strong>을 클릭하시면 해당파일이 다운로드됩니다.</p>
		</div>

		<form name="objtnForm" id="objtnForm" method="post">
		<input type="hidden" name="apl_no" id="apl_no">
		<input type="hidden" name="objtnSno" id="objtnSno">
		<input type="hidden" name="page" value="<c:out value="${param.page}" default="1" />" />
        <input type="hidden" name="rows" value="<c:out value="${param.rows}" default="10" />" />
        <fieldset>
        <legend>업무추진비</legend>
        <section>
            <table class="table_datail_CC width_A bt1x">
            <caption>검색</caption>
            <tbody>
            <tr>
                <th scope="row"><label for="aplInst">대상기관</label></th>
                <td>
		            <span class="select">
		                <select name="aplInst" id="aplInst" title="대상기관">
		                    <option value="">전체</option>
								<c:set var="instCodeList" value="${requestScope.instCodeList}"/>
								<c:forEach var="instCodeDo" items="${instCodeList}">
								<option value="${instCodeDo.instCd }">${instCodeDo.instNm }</option>
								</c:forEach>
		                </select>
		            </span>
                </td>
            </tr>
            </tbody>
            </table>
        </section>
        </fieldset>
        <div class="area_btn_A">
        	<a id="insert-button" href="#none" onclick="fn_goSearch();" class="btn_A">조회</a>
        </div>

        <!-- 목록 -->
        <section id="tab_B_cont_1" class="tab_AB_cont">
            <h4 class="hide"><c:out value="${requestScope.menu.lvl3MenuPath}" /></h4>
            <ul class="search search_AB">
            <li class="ty_BB">
                <ul class="ty_A mq_tablet">
                    <li>전체 <strong id="count-sect" class="totalNum"></strong>건, <span id="pages-sect" class="pageNum"></span></li>
                </ul>
            </li>
            </ul>

            <table id="data-table" class="table_boardList_A table_boardList_AB  mgTm10_mq_mobile mtable_layout">
            <caption><c:out value="${requestScope.menu.lvl3MenuPath}" /></caption>
            <colgroup>
                <col style="width:8%;" />
                <col style="width:15%;" />
                <col style="width:17%;" />
                <col style="width:50%;" /> 
                <col style="width:10%;" />
            </colgroup>
            <thead>
            <tr>
                <th scope="col">번호</th>
                <th scope="col">생산년월</th>
                <th scope="col">기관명</th>
                <th scope="col">파일명</th>
                <th scope="col">다운로드</th>
            </tr>
            </thead>
            <tbody>
            <tr>
                <td colspan="5" class="noData">조회 된 자료가 없습니다.</td>
            </tr>
            </tbody>
            </table>

            <!-- page -->
            <div id="pager-sect" class="page"></div>
            <!-- // page -->
        </section>
        <!-- // 목록 -->
        
        </form>
    </div>
	<!-- // content -->
</div>
<!-- // layout_flex #################### -->
</div></div>

<!-- footer -->
<%@ include file="/WEB-INF/jsp/portal/sect/footer.jsp" %>
<script type="text/javascript" src="<c:url value="/js/soportal/expose/nasCommon.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/soportal/expose/searchWorkPay.js" />"></script>
<!-- jquery tree plugin [Dynatree] -->
<link rel="stylesheet" href="<c:url value="/js/soportal/tree/skin/ui.dynatree.css" />" type="text/css">
<script type="text/javascript" src="<c:url value="/js/soportal/tree/jquery.dynatree.js" />"></script> 
</body>
</html>