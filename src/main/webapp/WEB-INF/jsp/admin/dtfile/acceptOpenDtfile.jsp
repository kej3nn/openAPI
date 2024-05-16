<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%-- @(#)acceptOpenDtfile.jsp 1.0 2015/06/01                                --%>
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
<%-- 데이터 파일을 승인하는 화면이다.                                       --%>
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
<script type="text/javascript" src="<c:url value="/js/admin/dtfile/acceptOpenDtfile.js" />"></script>
</head>
<body>
<div class="wrap">

<c:import  url="/admin/admintop.do" />

<div class="container">
    <div class="title">
        <h2><c:out value="${MENU_NM}" /></h2>
        <p><c:out value="${MENU_URL}" /></p>
    </div>
   <!--  <ul class="tab">
        <li style="padding-right:10px;"><a href="/admin/dtfile/manageOpenDttypePage.do">데이터타입관리</a></li>
        <li style="padding-right:10px;"><a href="/admin/dtfile/manageOpenDtfilePage.do">데이터파일관리</a></li>
        <li style="padding-right:10px;" class="on"><a href="#">데이터파일승인</a></li>
        <li style="padding-right:10px;"><a href="/admin/dtfile/uploadOpenDtfilePage.do">데이터파일업로드</a></li>
        <li style="padding-right:10px;"><a href="/admin/dtfile/manageOpenDttranPage.do">데이터검증결과</a></li>
    </ul> -->
    <div class="content"  >
        <form id="search-form" name="search-form" method="post">
            <table class="list01">
                <caption>데이터 파일 승인</caption>
                <colgroup>
                    <col width="150" />
                    <col width="" />
                </colgroup>
                <tr>
                    <th>승인여부</th>
                    <td>
                        <select id="accYn" name="accYn"></select>
                    </td>
                </tr>
                <tr>
                    <th>검색어</th>
                    <td>
                        <select id="searchName" name="searchName"></select>
                        <input type="text" id="searchWord" name="searchWord" style="width:200px; ime-mode:active;" />
                        <button id="search-button" name="search-button" class="btn01">조회</button>
                    </td>
                </tr>
            </table>
        </form>
        <div id="dtfile-sheet-section" class="ibsheet_area"></div>
        <div id="dtcols-sheet-section" class="ibsheet_area"></div>
        <div style="text-align:right;">
            <button id="accept-button" name="dtcols-add-button" class="btn01">승인</button>
        </div>
    </div>
</div>
<iframe id="hidden-iframe" name="hidden-iframe" width="100%" height="0" frameborder="0" scrolling="0" style="display:none;"></iframe>
<c:import  url="/WEB-INF/jsp/inc/iframepopup.jsp" />
<c:import  url="/WEB-INF/jsp/admin/adminfooter.jsp" />
</div>
</body>
</html>