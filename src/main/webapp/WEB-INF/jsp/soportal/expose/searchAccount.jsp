<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>

<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%-- @(#)searchAccount.jsp 1.0 2019/08/12                                   --%>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>

<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ 	--%>
<%-- 정보공개 > 청구서처리현황                      																												--%>
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
			<h3>청구서 처리현황<span class="arrow"></span></h3>
        </div>

<div class="layout_flex">
    <!-- content -->
    <div class="layout_flex_100">
		<h2 class="hide">청구서 처리현황</h2>
		<div class="area_h3 area_h3_AB deco_h3_3 mb20">
			<h3 class="ty_A"><strong>청구서 처리현황</strong></h3>
			<p>각 항목중 선택, 입력 후 <strong class="point-color02" style="vertical-align: top;">조회목록의 제목</strong>을 클릭하시면 해당페이지로 이동합니다.</p>
		</div>

		<form name="form" id="form" method="post">
		<input type="hidden" name="h_aplInst" id="h_aplInst" value="<c:out value="${requestScope.aplInst }"/>" title="처리기관">
		<input type="hidden" name="h_prgState" id="h_prgState" value="<c:out value="${requestScope.prgState }"/>" title="처리상태">
		<input type="hidden" name="apl_no" id="apl_no" title="청구번호">
        <fieldset>
        <legend>청구서 처리현황</legend>
        <section>
            <table class="table_datail_CC width_A bt1x">
            <caption>청구서 처리현황 : 청구기관,처리상태,청구일자</caption>
            <tbody>
            <tr>
                <th scope="row"><label for="s_aplInst">청구기관</label></th>
                <td>
		            <span class="select">
		                <select name="s_aplInst" id="s_aplInst" title="청구기관">
		                    <option value="">전체</option>
								<c:set var="instCodeList" value="${requestScope.instCodeList}"/>
								<c:forEach var="commonCodeDo" items="${instCodeList}">
								<option value="${commonCodeDo.instCd }">${commonCodeDo.instNm }</option>
								</c:forEach>
		                </select>
		            </span>
                </td>
                <th scope="row"><label for="s_prgState">처리상태</label></th>
                <td>
		            <span class="select">
		                <select name="s_prgState" id="s_prgState" title="처리상태" onchange="fn_subElement();">
		                    <option value="">전체</option>
								<c:set var="commonCdList" value="${requestScope.pStateCodeList}"/>
								<c:forEach var="commonCodeDo" items="${commonCdList}">
								<c:if test="${commonCodeDo.baseCd eq '01' or commonCodeDo.baseCd eq '03' or commonCodeDo.baseCd eq '04' or commonCodeDo.baseCd eq '08' or commonCodeDo.baseCd eq '99' or commonCodeDo.baseCd eq '11' }">
								<option value="${commonCodeDo.baseCd }">${commonCodeDo.baseNm }</option>
								</c:if>
								</c:forEach>
		                </select>
		            </span>
					<span id="subElement" style="display: none;">
						<input type="checkbox" id="imd_deal_div" name="imd_deal_div" title="즉시처리여부"> 즉시처리건 조회
					</span>
                </td>
            </tr>
            <tr>
                <th scope="row"><label for="s_aplInst">청구일자</label></th>
                <td>
					<input type="text" name="s_aplDtFrom" id="s_aplDtFrom"  value="${requestScope.aplDtFrom }" title="시작일자(입력예:YYYY-MM-DD)" maxlength="10" style="width:100px;" /> ~
					<input type="text" name="s_aplDtTo" id="s_aplDtTo" value="${requestScope.aplDtTo }" title="종료일자(입력예:YYYY-MM-DD)" maxlength="10" style="width:100px;" />
                </td>
                <th scope="row"><label for="s_opbYn">공개여부</label></th>
                <td>
		            <span class="select">
		                <select name="s_opbYn" id="s_opbYn" title="공개여부">
		                    <option value="">전체</option>
							<option value="0">공개</option>
							<option value="1">부분공개</option>
							<option value="2">비공개</option>
							<option value="3">부존재 등</option>
		                </select>
		            </span>
                </td>
            </tr>

            <tr>
                <th scope="row"><label for="s_aplSj">제목</label></th>
                <td colspan="3" class="ty_AB">
					<input type="text" name="s_aplSj" id="s_aplSj" title="제목" maxlength="100" style="width:100%;" />
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
            <caption><c:out value="${requestScope.menu.lvl3MenuPath}" />청구서 처리현황 : 번호,청구일자,제목,청구기관명,처리기관명,처리상태,통지서</caption>
            <colgroup class="m_none">
                <col style="width:8%;" />
                <col style="width:10%;" />
                <col style="width:30%;" /> 
                <col style="width:13%;" />
                <col style="width:13%;" />
                <col style="width:10%;" />
                <col style="width:10%;" />
                <col style="width:6%;" />
            </colgroup>
            <thead>
            <tr>
                <th scope="col">번호</th>
                <th scope="col">청구일자</th>
                <th scope="col">제목</th>
                <th scope="col">청구기관명</th>
                <th scope="col">처리기관명</th>
                <th scope="col">처리상태</th>
                <th scope="col">공개여부</th>
                <th scope="col">통지서</th>
            </tr>
            </thead>
            <tbody>
            <tr>
                <td colspan="8" class="noData">청구서 자료가 없습니다.</td>
            </tr>
            </tbody>
            </table>

            <!-- page -->
            <div id="pager-sect" class="page"></div>
            <!-- // page -->
        </section>
        <!-- // 목록 -->
		<textarea name="printAplDtsCn" title="청구내용(출력용)" style="display:none;"></textarea>
		<textarea name="printClsdRmk" title="비공개사유(출력용)"  style="display:none;"></textarea>
        </form>
		<form name="pForm" id="pForm" method="post">
			<input type="hidden" name="aplInst" value="<c:out value="${requestScope.aplInst}"/>" title="aplInst">
			<input type="hidden" name="prgState" value="<c:out value="${requestScope.prgState}"/>" title="prgState">
			<input type="hidden" name="aplDtFrom" value="<c:out value="${requestScope.aplDtFrom}"/>" title="aplDtFrom">
			<input type="hidden" name="aplDtTo" value="<c:out value="${requestScope.aplDtTo}"/>" title="aplDtTo">
			<input type="hidden" name="opbYn" value="<c:out value="${requestScope.opbYn}"/>" title="opbYn">
			<input type="hidden" name="aplSj" value="<c:out value="${requestScope.aplSj}"/>" title="aplSj">
			<input type="hidden" name="page" value="<c:out value="${param.page}" default="1" />" title="page">
        	<input type="hidden" name="rows" value="<c:out value="${param.rows}" default="10" />" title="rows">
			<input type="hidden" name="imd_deal_div" value="<c:out value="${requestScope.imdDealDiv}"/>" title="imd_deal_div">
			
		</form>
		<form name="printForm" method="post">
			<input type="hidden" name="mrdParam" id="mrdParam" title="mrdParam">
			<input type="hidden" name="width" title="width">
			<input type="hidden" name="height" title="height">
			<input type="hidden" name="title" title="title">
		</form>
	</div>
	<!-- // content -->
</div>
<!-- // layout_flex #################### -->

</div></div>
<!-- footer -->
<%@ include file="/WEB-INF/jsp/portal/sect/footer.jsp" %>
<script type="text/javascript" src="/js/soportal/expose/nasCommon.js"></script>
<script type="text/javascript" src="/js/soportal/expose/searchAccount.js"></script>
<!-- jquery tree plugin [Dynatree] -->
<link rel="stylesheet" href="<c:url value="/js/soportal/tree/skin/ui.dynatree.css" />" type="text/css">
<script type="text/javascript" src="<c:url value="/js/soportal/tree/jquery.dynatree.js" />"></script> 
</body>
</html>