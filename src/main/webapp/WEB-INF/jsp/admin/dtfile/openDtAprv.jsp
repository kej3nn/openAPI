<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title><spring:message code="wiseopen.title" /></title>
<c:import  url="/WEB-INF/jsp/inc/headinclude.jsp" />
<script type="text/javascript" src="<c:url value="/js/common/base/commonness.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/common/base/delegation.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/admin/dtfile/openDtAprv.js" />"></script>
<style type="text/css">
a {cursor:pointer;}
</style>
</head>
<body>
<div class="wrap">

<c:import  url="/admin/admintop.do" />

<div class="container">
    <div class="title">
        <h2><c:out value="${MENU_NM}" /></h2>
        <p><c:out value="${MENU_URL}" /></p>
    </div>
    
	<!-- 탭 -->
	<ul class="tab">
		<li class="all_list" id="tab_list"><a>전체목록</a></li>                       
	</ul>
			
    <div class="content">
        <form id="search-form" name="search-form" method="post">
            <table class="list01">
                <caption>데이터 파일 업로드 검색</caption>
                <colgroup>
                    <col width="10%" />
                    <col width="40%" />
                    <col width="10%" />
                    <col width="40%" />
                </colgroup>
                <tr>
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
                    <th><spring:message code='labal.infNm'/></th>
                    <td colspan="5">
                        <input type="text" id="infNm" name="infNm" style="width:200px; ime-mode:active;" />
                        <button id="search-button" name="search-button" class="btn01"><spring:message code='btn.inquiry'/></button>
                    </td>
                </tr>
            </table>
        </form>
        <div id="dtfile-sheet-section" class="ibsheet_area"></div>
        <form id="select-form" name="select-form" method="post">
        	<input type="hidden" name="dsId" value=""/>
        	<input type="hidden" name="indvdlYn" value="N"/>
        </form>
    </div>
</div>
<c:import  url="/WEB-INF/jsp/inc/iframepopup.jsp" />
<c:import  url="/WEB-INF/jsp/admin/adminfooter.jsp" />
</div>
</body>
</html>