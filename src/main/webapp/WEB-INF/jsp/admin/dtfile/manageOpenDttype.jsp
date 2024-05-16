<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%-- @(#)manageOpenDttype.jsp 1.0 2015/06/01                                --%>
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
<%-- 데이터 유형을 관리하는 화면이다.                                       --%>
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
<script type="text/javascript" src="<c:url value="/js/admin/dtfile/manageOpenDttype.js" />"></script>
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
        <li style="padding-right:10px;" class="on"><a href="#">데이터타입관리</a></li>
        <li style="padding-right:10px;"><a href="/admin/dtfile/manageOpenDtfilePage.do">데이터파일관리</a></li>
        <li style="padding-right:10px;"><a href="/admin/dtfile/acceptOpenDtfilePage.do">데이터파일승인</a></li>
        <li style="padding-right:10px;"><a href="/admin/dtfile/uploadOpenDtfilePage.do">데이터파일업로드</a></li>
        <li style="padding-right:10px;"><a href="/admin/dtfile/manageOpenDttranPage.do">데이터검증결과</a></li>
    </ul> -->
    <div class="content"  >
    	<form id="search-form"  method="post" action="#">
    	<table class="list01">
			<caption>데이터 유형정의</caption>
			<colgroup>
				<col width="20%"/>
				<col width="80%"/>
			</colgroup>
			<tr>
				<th>검색어</th>
				<td colspan="3">
					<select id="searchGubun" name="searchGubun">
						<option value="VERIFY_NM">검증유형명</option>
					</select>
					<input type="text" name="searchVal" value="" placeholder="검색어 입력" size="40" />
					&nbsp;
					${sessionScope.button.btn_inquiry}
				</td>
			</tr>
			<tr>
				<th>사용여부</th>
				<td>
					<input type="radio" value="" name="useYn" id="useYnAll" checked="checked"></input><label for="useYnAll">전체</label>&nbsp;&nbsp;
					<input type="radio" value="Y" name="useYn" id="useYnY"></input><label for="useYnY">사용</label>&nbsp;&nbsp;
					<input type="radio" value="N" name="useYn" id="useYnN"></input><label for="useYnN">미사용</label>
				</td>
			</tr>
		</table>
		</form>
        <div style="text-align:right;">
            <button id="dttype-add-button" name="dttype-add-button" class="btn01">추가</button>
        </div>
        <div id="dttype-sheet-section" class="ibsheet_area"></div>
        
        <div class="buttons">
        	<button id="dttype-save-button" name="dttype-save-button" class="btn01B">저장</button>
        </div>
    </div>
</div>
<iframe id="hidden-iframe" name="hidden-iframe" width="100%" height="0" frameborder="0" scrolling="0" style="display:none;"></iframe>
<c:import  url="/WEB-INF/jsp/inc/iframepopup.jsp" />
<c:import  url="/WEB-INF/jsp/admin/adminfooter.jsp" />
</div>
</body>
</html>