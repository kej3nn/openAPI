<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%-- @(#)manageOpenDtfile.jsp 1.0 2015/06/01                                --%>
<%--                                                                        --%>
<%-- COPYRIGHT (C) 2013 WISEITECH CO., LTD. ALL RIGHTS RESERVED.            --%>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%-- 데이터 파일을 관리하는 화면이다.                                       --%>
<%--                                                                        --%>
<%-- @author 김은삼                                                         --%>
<%-- @version 1.0 2015/06/01                                                --%>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title><spring:message code="wiseopen.title" /></title>
<c:import  url="/WEB-INF/jsp/inc/headinclude.jsp" />
<script type="text/javascript" src="<c:url value="/js/common/base/commonness.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/common/base/delegation.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/admin/dtfile/manageOpenDtfile.js" />"></script>
</head>
<body>
<div class="wrap">

<c:import  url="/admin/admintop.do" />

<div class="container">
    <div class="title">
        <h2><c:out value="${MENU_NM}" /></h2>
        <p><c:out value="${MENU_URL}" /></p>
    </div>
    <!-- <ul class="tab">
        <li style="padding-right:10px;"><a href="/admin/dtfile/manageOpenDttypePage.do">데이터타입관리</a></li>
        <li style="padding-right:10px;" class="on"><a href="#">데이터파일관리</a></li>
        <li style="padding-right:10px;"><a href="/admin/dtfile/acceptOpenDtfilePage.do">데이터파일승인</a></li>
        <li style="padding-right:10px;"><a href="/admin/dtfile/uploadOpenDtfilePage.do">데이터파일업로드</a></li>
        <li style="padding-right:10px;"><a href="/admin/dtfile/manageOpenDttranPage.do">데이터검증결과</a></li>
    </ul> -->
    <div class="content"  >
        <form id="search-form" name="search-form" method="post">
            <table class="list01">
                <caption>데이터 파일 관리</caption>
                <colgroup>
                    <col width="150" />
                    <col width="" />
                    <col width="150" />
                    <col width="" />
                </colgroup>
                <tr>
                    <th><spring:message code='labal.cateNm'/></th>
                    <td>
                        <input type="hidden" name="cateId" value=""/>
						<input type="text" name="cateNm" value="" readonly="readonly"/>
						${sessionScope.button.btn_search}              
						<button type="button" class="btn01" title="초기화" name="btn_init">초기화</button>
                    </td>
                    <th><spring:message code='labal.orgNm'/></th>
                    <td>
                        <input type="hidden" name="orgCd" value=""/>
						<input type="text" name="orgNm" value="" readonly="readonly"/>
						${sessionScope.button.btn_search}      
						<button type="button" class="btn01" title="초기화" name="btn_init">초기화</button>
                    </td>
                </tr>
                <tr>
                    <th><spring:message code='labal.infNm'/></th>
                    <td colspan="3">
                        <input type="text" id="infNm" name="infNm" style="width:200px; ime-mode:active;" />
                        <button id="search-button" name="search-button" class="btn01">조회</button>
                    </td>
                </tr>
            </table>
        </form>
        <div style="text-align:right; height:23px;">
        <c:if test="${sessionScope.loginVO.accCd == 'SYS'}">
            <button id="dtfile-add-button" name="dtfile-add-button" class="btn01">추가</button>
            <button id="dtfile-save-button" name="dtfile-save-button" class="btn01">저장</button>
        </c:if>
        </div>
        <div id="dtfile-sheet-section" class="ibsheet_area"></div>
        <div style="text-align:right;  height:23px;">
<!--             <button id="dtcols-add-button" name="dtcols-add-button" class="btn01">추가</button> -->
		<c:if test="${sessionScope.loginVO.accCd == 'SYS'}">
            <button id="dtcols-moveup-button" name="dtcols-moveup-button" class="btn01">위로이동</button>
            <button id="dtcols-movedown-button" name="dtcols-movedown-button" class="btn01">아래로이동</button>
            <button id="dtcols-save-button" name="dtcols-save-button" class="btn01">저장</button>
        </c:if>
        </div>
        <div id="dtcols-sheet-section" class="ibsheet_area"></div>
    </div>
</div>
<iframe id="hidden-iframe" name="hidden-iframe" width="100%" height="0" frameborder="0" scrolling="0" style="display:none;"></iframe>
<c:import url="/WEB-INF/jsp/inc/iframepopup.jsp" />
<c:import url="/WEB-INF/jsp/admin/adminfooter.jsp" />
</div>
</body>
</html>