<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%-- @(#)uploadOpenDtfile.jsp 1.0 2015/06/01                                --%>
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
<%-- 독촉 스크립트를 관리하는 화면이다.				                                    --%>
<%--                                                                        --%>
<%-- @author 신익진	                                                        --%>
<%-- @version 1.0 2015/09/22                                                --%>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title><spring:message code="wiseopen.title" /></title>
<c:import  url="/WEB-INF/jsp/inc/headinclude.jsp" />
<script type="text/javascript" src="<c:url value="/js/common/base/commonness.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/common/base/delegation.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/admin/dtfile/managePresMng.js" />"></script>
</head>
<body>
<div class="wrap">

<c:import  url="/admin/admintop.do" />

<div class="container">
    <div class="title">
        <h2><c:out value="${MENU_NM}" /></h2>
        <p><c:out value="${MENU_URL}" /></p>
    </div>
    <div class="content"  >
        <form id="search-form" name="search-form" method="post">
            <table class="list01">
                <caption>독촉관리 검색</caption>
                <colgroup>
                    <col width="10%" />
                    <col width="15%" />
                    <col width="10%" />
                    <col width="15%" />
                    <col width="10%" />
                    <col width="15%" />
                    <col width="10%" />
                    <col width="15%" />
                </colgroup>
                <tr>
                    <th>실행일</th>
                    <td>
                        <select id="useDtCd" name="useDtCd"></select>
                    </td>
                    <th>담당수신자</th>
                    <td>
                        <select id="callerCd" name="callerCd"></select>
                    </td>
                    <th>배경HTML</th>
                    <td>
                    	<select id="htmlCont" name="htmlCont"></select>
                    </td>
                    <th>사용여부</th>
                    <td>
                        <select id="useYn" name="useYn"></select>
                    </td>
                </tr>
                <tr> 
                    <th>독촉스크립트명</th>
                    <td colspan="7">
                        <input type="text" id="scrtNm" name="scrtNm" style="width:200px; ime-mode:active;" />
                        <button id="search-button" name="search-button" class="btn01"><spring:message code='btn.inquiry'/></button>
                    </td>
                </tr>
            </table>
        </form>
        <button id="template-init-button" name="template-init-button" class="btn01" title="btn.init" style="float:right"><spring:message code='btn.init'/></button>
        <br>
        <div id="dtfile-sheet-section" class="ibsheet_area"></div>
<!--         <div id="dtcols-sheet-section" class="ibsheet_area"></div> -->
        <div style="text-align:left;">
        	<form id="upload-form" name="upload-form" method="post" enctype="multipart/form-data">
                <input type="hidden" id="presMngNo" name="presMngNo" />
                
	        	<table class="list01">
	                <caption>데이터 파일 업로드</caption>
	                <colgroup>
	                    <col width="150" />
	                    <col width="" />
	                    <col width="150" />
	                    <col width="" />
	                </colgroup>
	                <tr>
	                    <th>독촉스크립트명</th>
	                    <td colspan="3">
	                    	<input type="text" id="formScrtNm" name="scrtNm" style="width:973px;" />
	                    </td>
	                </tr>
	                <tr> 
	                    <th>독촉스크립트</th>
	                    <td colspan="3">
	                        <textarea id="formScrtCont" name="scrtCont" style="width:98%;" rows="5"></textarea>
	                    </td>
	                </tr>
	                <tr>
	                    <th>사용여부</th>
	                    <td>
	                    	<input type="radio" value="Y" id="useY" name="useYn"/>
							<label for="useY"><spring:message code='labal.yes'/></label>  
							<input type="radio" value="N" id="useN" name="useYn"/>
							<label for="useN"><spring:message code='labal.no'/></label>
	                    </td>
	                    <th>담당수신자</th>
	                    <td>
	                    	<select id="formCallerCd" name="callerCd"></select>
	                    </td>
	                </tr>
	                <tr>
	                    <th>실행일</th>
	                    <td colspan="3">
	                    	<select id="formUseDtCd" name="useDtCd"></select>
	                    </td>
	                </tr>
	                <tr>
	                    <th>배경HTML</th>
	                    <td colspan="3">
	                    	<select id="formHtmlCont" name="htmlCont"></select>
	                    </td>
	                </tr>
	            </table>
				<button id="template-save-button" name="template-save-button" class="btn01" title="btn.save" style="display:none;float:right"><spring:message code='btn.save'/></button>
				<span id="blankBetButton" name="blankBetButton" style="float:right">&nbsp;&nbsp;</span>
				<button id="template-modify-button" name="template-modify-button" class="btn01" title="btn.modify" style="display:none;float:right"><spring:message code='btn.modify'/></button>
	            <span id="blankBetButton" name="blankBetButton" style="float:right">&nbsp;&nbsp;</span>
	            <button id="template-del-button" name="template-del-button" class="btn01" title="btn.del" style="display:none;float:right"><spring:message code='btn.del'/></button>
            </form>
        </div>
    </div>
</div>
<iframe id="hidden-iframe" name="hidden-iframe" width="100%" height="0" frameborder="0" scrolling="0" style="display:none;"></iframe>
<c:import  url="/WEB-INF/jsp/inc/iframepopup.jsp" />
<c:import  url="/WEB-INF/jsp/admin/adminfooter.jsp" />
</div>
</body>
</html>