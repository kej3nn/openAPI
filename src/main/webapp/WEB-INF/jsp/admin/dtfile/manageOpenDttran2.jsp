<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%-- @(#)manageOpenDttran.jsp 1.0 2015/06/01                                --%>
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
<%-- 데이터 처리를 관리하는 화면이다.                                       --%>
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
<script type="text/javascript" src="<c:url value="/js/admin/dtfile/manageOpenDttran2.js" />"></script>
</head>
<body>
<div class="wrap">

<c:import  url="/admin/admintop.do" />

<div class="container">
    <div class="title">
    	<c:if test="${empty param.dttranId}">
        <h2><c:out value="${MENU_NM}" /></h2>
        <p><c:out value="${MENU_URL}" /></p>
        </c:if>
        <c:if test="${not empty param.dttranId}">
        	<c:if test="${data.accCd eq 'SYS' }">
		        <h2>데이터 등록 결과</h2>
		        <p>자료입력 &gt; 데이터 등록</p>
        	</c:if>
        	<c:if test="${data.accCd eq 'DM' }">
		        <h2>데이터 등록 결과</h2>
		        <p>데이터 등록</p>
        	</c:if>
        </c:if>
    </div>
   <!--  <ul class="tab">
        <li style="padding-right:10px;"><a href="/admin/dtfile/manageOpenDttypePage.do">데이터타입관리</a></li>
        <li style="padding-right:10px;"><a href="/admin/dtfile/manageOpenDtfilePage.do">데이터파일관리</a></li>
        <li style="padding-right:10px;"><a href="/admin/dtfile/acceptOpenDtfilePage.do">데이터파일승인</a></li>
        <li style="padding-right:10px;"><a href="/admin/dtfile/uploadOpenDtfilePage.do">데이터파일업로드</a></li>
        <li style="padding-right:10px;" class="on"><a href="#">데이터검증결과</a></li>
    </ul> -->
    <div class="content"  >
        <form id="search-form" name="search-form" method="post">
            <input type="hidden" id="dttranId" name="dttranId" value="<c:out value="${param.dttranId}" />" />
        <c:if test="${empty param.dttranId}">
            <table class="list01">
                <caption>데이터 처리 관리</caption>
                <colgroup>
                    <col width="150" />
                    <col width="" />
                    <col width="150" />
                    <col width="" />
                    <col width="150" />
                    <col width="" />
                </colgroup>
<!--                 <tr> -->
<!--                     <th>처리상태</th> -->
<!--                     <td> -->
<!--                         <select id="procStat" name="procStat"></select> -->
<!--                     </td> -->
<!--                 </tr> -->
<!--                 <tr> -->
<!--                     <th>검색어</th> -->
<!--                     <td> -->
<!--                         <select id="searchName" name="searchName"></select> -->
<!--                         <input type="text" id="searchWord" name="searchWord" style="width:200px; ime-mode:active;" /> -->
<!--                         <button id="search-button" name="search-button" class="btn01">조회</button> -->
<!--                         <span id="countdown"></span> -->
<!--                     </td> -->
<!--                 </tr> -->
				<tr>
					<th>저장여부</th>
					<td>
						<select id="saveYn" name="saveYn">
							<option value="">전체</option>
							<option value="Y">예</option>
							<option value="N">아니오</option>
						</select>
					</td>
                    <th><spring:message code='labal.loadCd'/></th>
                    <td>
                        <select id="loadCd" name="loadCd"></select>
                    </td>
                    <th><spring:message code='labal.orgNm'/></th>
                    <td>
                        <input type="hidden" name="orgCd" value=""/>
						<input type="text" name="orgNm" value="" readonly="readonly"/>
						${sessionScope.button.btn_search}
						<button type="button" class="btn01" title="<spring:message code='btn.init'/>" name="btn_init"><spring:message code='btn.init'/></button>
                    </td>
				</tr>
				<tr>
                    <th>검증일자</th>
                    <td>
						<input type="text" name="startDttm" value="" readonly="readonly" style="width:90px;"/>
						<input type="text" name="endDttm" value="" readonly="readonly" style="width:90px;"/>
					</td>
                    <th>검증결과</th>
                    <td>
						<select id="chckYn" name="chckYn">
							<option value="">전체</option>
							<option value="Y">정상</option>
							<option value="N">오류</option>
						</select>
                    </td>
                    <th><spring:message code='labal.infNm'/></th>
                    <td>
                        <input type="text" id="infNm" name="infNm" style="width:200px; ime-mode:active;" />
                        <button id="search-button" name="search-button" class="btn01"><spring:message code='btn.inquiry'/></button>
                    </td>
				</tr>
            </table>
        </c:if>
        	<input type="hidden" name="downLoadFileNm" value="검증 이력"/>
        </form>
        <div id="dttran-sheet-section" class="ibsheet_area"></div>
        <div style="text-align:right;">
        	<input type="hidden" name="dtfileId" value=""/>
        	<input type="hidden" name="uplSchNo" value=""/>
	    	<c:if test="${empty param.dttranId}">
	        	<button id="download-excel-button" name="download-excel-button" class="btn01LD">이력 다운로드</button>
	        </c:if>
        	<c:if test="${not empty param.dttranId}">
	            <button id="create-save-button" name="create-save-button" class="btn01LD">지우고 저장하기</button>
	            <button id="append-save-button" name="append-save-button" class="btn01LD">이어서 저장하기</button>
            </c:if>
        </div>
        <div id="dtchck-sheet-section" class="ibsheet_area"></div>
        <div style="text-align:right;">
            <button id="excel1997-download-button" name="excel1997-download-button" class="btn01LD">엑셀2003 다운로드</button>
            <button id="excel2007-download-button" name="excel2007-download-button" class="btn01LD">엑셀2007 다운로드</button>
        	<button id="upload-preview-button" name="upload-preview-button" class="btn01LD">서비스 미리보기</button>
        </div>
    </div>
</div>
<iframe id="hidden-iframe" name="hidden-iframe" width="100%" height="0" frameborder="0" scrolling="0" style="display:none;"></iframe>
<c:import url="/WEB-INF/jsp/inc/iframepopup.jsp" />
<c:import url="/WEB-INF/jsp/admin/adminfooter.jsp" />
</div>
<div id="loadingCircle" style="position:fixed; top:0px; left:0px; width:100%; height: 100%; z-index:9999999999; display:none;">
	<div style="position:relative; top:50%; left:50%; margin: -37.5px 0 0 -37.5px;"><img src="<c:url value="/img/ajax-loader.gif"/>" alt="loading"></div>
</div>
</body>
</html>