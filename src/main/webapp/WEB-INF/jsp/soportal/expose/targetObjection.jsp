<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>

<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%-- @(#)targetObjection.jsp 1.0 2019/08/12                                   --%>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>

<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ 	--%>
<%-- 정보공개 > 이의신청서 대상                  																												   	--%>
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
			<h3>이의신청서 작성<span class="arrow"></span></h3>
        </div>



<div class="layout_flex">
    <!-- content -->
    <div class="layout_flex_100">
		<h2 class="hide">이의신청서 작성</h2>
		<div class="area_h3 area_h3_AB deco_h3_3 mb20">
			<h3 class="ty_A"><strong>이의신청서 작성</strong></h3>
			<p>각 항목중 선택, 입력 후 <strong class="point-color02" style="vertical-align: top;">조회목록의 제목</strong>을 클릭하시면 해당페이지로 이동합니다.</p>
		</div>

		<form name="form" id="form" method="post">
		<input type="hidden" name="apl_no" id="apl_no">
        <fieldset>
        <legend>이의신청서 작성</legend>
        <section>
            <table class="table_datail_CC width_A bt1x">
            <caption>이의신청서 작성 : 청구기관,청구일자</caption>
            <tbody>
            <tr>
                <th scope="row"><label for="s_aplInst">청구기관</label></th>
                <td>
		            <span class="select">
		                <select name="s_aplInst" id="s_aplInst" title="청구기관">
		                    <option value="">전체</option>
								<c:set var="instCodeList" value="${requestScope.instCodeList}"/>
								<c:forEach var="instCodeDo" items="${instCodeList}">
								<option value="${instCodeDo.instCd }">${instCodeDo.instNm }</option>
								</c:forEach>
		                </select>
		            </span>
                </td>
                <th scope="row"><label for="s_aplDtFrom">청구일자</label></th>
                <td>
					<input type="text" name="s_aplDtFrom" id="s_aplDtFrom"  value="${requestScope.aplDtFrom }" title="시작일자(입력예:YYYY-MM-DD)" maxlength="10" style="width:100px;" /> ~
					<input type="text" name="s_aplDtTo" id="s_aplDtTo" value="${requestScope.aplDtTo }" title="종료일자(입력예:YYYY-MM-DD)" maxlength="10" style="width:100px;" />
                </td>
            </tr>
            </tbody>
            </table>
        </section>
        </fieldset>
        <div class="area_btn_A">
        	<a id="insert-button" href="#" onclick="fn_goSearch();" class="btn_A">조회</a>
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
            <caption><c:out value="${requestScope.menu.lvl3MenuPath}" />이의신청서 작성 : 번호,청구일자,제목,청구기관명,처리기관명,결정통지일자</caption>
            <colgroup>
                <col style="width:8%;">
                <col style="width:12%;">
                <col style="width:28%;"> 
                <col style="width:15%;">
                <col style="width:15%;">
                <col style="width:12%;" class="td_width">
            </colgroup>
            <thead>
            <tr>
                <th scope="col">번호</th>
                <th scope="col">청구일자</th>
                <th scope="col">제목</th>
                <th scope="col">청구기관명</th>
                <th scope="col">처리기관명</th>
                <th scope="col">결정통지일자</th>
            </tr>
            </thead>
            <tbody>
            <tr>
                <td colspan="6" class="noData">청구서 자료가 없습니다.</td>
            </tr>
            </tbody>
            </table>

            <!-- page -->
            <div id="pager-sect" class="page"></div>
            <!-- // page -->
        </section>
        <!-- // 목록 -->
        
        </form>
		<form name="pForm" id="pForm" method="post">
			<input type="hidden" name="aplInst" value="<c:out value="${requestScope.aplInst }"/>">
			<input type="hidden" name="aplDtFrom" value="<c:out value="${requestScope.aplDtFrom }"/>">
			<input type="hidden" name="aplDtTo" value="<c:out value="${requestScope.aplDtTo }"/>">
			<input type="hidden" name="page" value="<c:out value="${param.page}" default="1" />" />
        	<input type="hidden" name="rows" value="<c:out value="${param.rows}" default="10" />" />
			<input type="hidden" name="imd_deal_div" value="<c:out value="${requestScope.imdDealDiv }"/>">
			<input type="hidden" name="listPerPage" >
		</form>
		<form name="printForm" method="post">
			<input type="hidden" name="mrdParam" id="mrdParam" />
			<input type="hidden" name="width"/>
			<input type="hidden" name="height"/>
			<input type="hidden" name="title"/>
		</form>
    </div>
	<!-- // content -->
</div>
<!-- // layout_flex #################### -->
</div></div>

<!-- footer -->
<%@ include file="/WEB-INF/jsp/portal/sect/footer.jsp" %>
<script type="text/javascript" src="<c:url value="/js/soportal/expose/nasCommon.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/soportal/expose/targetObjection.js" />"></script>
<!-- jquery tree plugin [Dynatree] -->
<link rel="stylesheet" href="<c:url value="/js/soportal/tree/skin/ui.dynatree.css" />" type="text/css">
<script type="text/javascript" src="<c:url value="/js/soportal/tree/jquery.dynatree.js" />"></script> 
</body>
</html>