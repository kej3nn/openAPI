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
<%-- 데이터 파일을 업로드하는 화면이다.                                     --%>
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
<script type="text/javascript" src="<c:url value="/js/admin/dtfile/uploadOpenDtfile.js" />"></script>
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
        <li style="padding-right:10px;"><a href="/admin/dtfile/acceptOpenDtfilePage.do">데이터파일승인</a></li>
        <li style="padding-right:10px;" class="on"><a href="#">데이터파일업로드</a></li>
        <li style="padding-right:10px;"><a href="/admin/dtfile/manageOpenDttranPage.do">데이터검증결과</a></li>
    </ul> -->
    <div class="content"  >
        <form id="search-form" name="search-form" method="post">
            <table class="list01">
                <caption>데이터 파일 업로드 검색</caption>
                <colgroup>
                    <col width="150" />
                    <col width="" />
                    <col width="150" />
                    <col width="" />
                    <col width="150" />
                    <col width="" />
                </colgroup>
                <tr>
                    <th><spring:message code='labal.loadCd'/></th>
                    <td>
                        <select id="loadCd" name="loadCd"></select>
                    </td>
                    <th><spring:message code='labal.fileNm'/></th>
                    <td>
                        <input type="text" id="fileNm" name="fileNm" style="width:200px; ime-mode:active;" />
                    </td>
                    <th><spring:message code='labal.status'/></th>
                    <td>
                        <select id="loadStatus" name="loadStatus"></select>
                    </td>
                </tr>
                <tr> 
                    <th><spring:message code='labal.infNm'/></th>
                    <td colspan="5">
                        <input type="text" id="infNm" name="infNm" style="width:200px; ime-mode:active;" />
                        <button id="search-button" name="search-button" class="btn01"><spring:message code='btn.inquiry'/></button>
                    </td>
                </tr>
            </table>
        </form>
        <div id="dtfile-sheet-section" class="ibsheet_area"></div>
<!--         <div id="dtcols-sheet-section" class="ibsheet_area"></div> -->
        <div style="text-align:left;">
        	<form id="upload-form" name="upload-form" method="post" enctype="multipart/form-data">
                <input type="hidden" id="dttranId" name="dttranId" />
                <input type="hidden" id="dtfileId" name="dtfileId" />
                <input type="hidden" id="uploadTy" name="uploadTy" />
                <input type="hidden" id="uplSchNo" name="uplSchNo" />
                <input type="hidden" id="dttmCheck" name="dttmCheck"  value="0"/>
                
<!--                 <button id="predefined-upload-button" name="predefined-upload-button" class="btn01LD">서버양식 엑셀업로드</button> -->
<!--                 <button id="template-upload-button" name="template-upload-button" class="btn01LD">기본양식 엑셀업로드</button> -->
	        	<table class="list01">
	                <caption>데이터 파일 업로드</caption>
	                <colgroup>
	                    <col width="150" />
	                    <col width="" />
	                </colgroup>
	                <tr id="checkDttm">
	                    <th><spring:message code='label.upload'/></th>
	                    <td>
	                        <input type="file" id="dtfile" name="dtfile" style="width:973px;" />
	                    </td>
	                </tr>         
	                <tr> 
	                    <th><spring:message code='label.delayMsg'/></th>
	                    <td>
	                        <textarea name="delayMsg" id="delayMsg" style="width:98%;" rows="5"></textarea>
	                    </td>
	                </tr>
	            </table>
	            <button id="template-upload-button" name="template-upload-button" class="btn01LD" style="float:right"><spring:message code='label.upload'/></button>
            </form>
        </div>
    </div>
</div>
<iframe id="hidden-iframe" name="hidden-iframe" width="100%" height="0" frameborder="0" scrolling="0" style="display:none;"></iframe>
<c:import  url="/WEB-INF/jsp/inc/iframepopup.jsp" />
<c:import  url="/WEB-INF/jsp/admin/adminfooter.jsp" />
</div>
<div id="loadingCircle" style="position:fixed; top:0px; left:0px; width:100%; height: 100%; z-index:9999999999; display:none;">
	<div style="position:relative; top:50%; left:50%; margin: -37.5px 0 0 -37.5px;"><img src="<c:url value="/img/ajax-loader.gif"/>" alt="loading"></div>
</div>
</body>
</html>