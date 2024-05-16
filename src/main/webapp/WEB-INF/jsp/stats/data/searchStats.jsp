<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%--                                                                        --%>
<%-- COPYRIGHT (C) 2013 WISEITECH CO., LTD. ALL RIGHTS RESERVED.            --%>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%-- 공공데이터소개 > 사이트소개                      --%>
<%--                                                                        --%>
<%-- @author 장홍식                                                         --%>
<%-- @version 1.0 2015/08/24                                                --%>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<!DOCTYPE html>
<html lang="ko">
<head>
<%@ include file="/WEB-INF/jsp/ggportal/sect/head.jsp" %>

<link rel="stylesheet" href="<c:url value="/css/ggportal/ztree/demo.css" />" type="text/css">
<link rel="stylesheet" href="<c:url value="/css/ggportal/ztree/metroStyle.css" />" type="text/css">
<script type="text/javascript" src="<c:url value="/js/stats/data/searchStats.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/ggportal/jquery.ztree.core.js" />"></script>  
</head>
<body>
<!-- layout_A -->
<div class="layout_A">
<%@ include file="/WEB-INF/jsp/ggportal/sect/header.jsp" %>
<!-- wrap_layout_flex -->
<div class="wrap_layout_flex">
<div class="layout_flex_100">
<%@ include file="/WEB-INF/jsp/ggportal/sect/gnb.jsp" %>
<!-- layout_flex #################### -->
<div class="layout_flex">
    <%@ include file="/WEB-INF/jsp/ggportal/bbs/board/sect/lnb.jsp" %>
   <!-- content -->
    <div id="content" class="content">
        
        <!-- location -->
        <div id="global-navigation-sect" class="location">
            <a href="/" title="메인으로 이동"><img src="../../../img/ggportal/desktop/common/btn_home.png" alt="메인페이지 이동"></a>
            <a href="#">소개</a>
            <strong>관련사이트</strong>
            
            
        </div>
       
        <!-- // location -->

        <h2 class="hide">관련 사이트</h2>
        <div class="area_h3 area_h3_AB deco_h3_2">
			<h3 class="ty_A">관련 사이트</h3> 
            <p>바로 알아두면 유용한 공공기관 사이트입니다. <br />다방면의 정보들이 담겨 있으니 자주 이용하시면 좋을 것 같습니다.</p>
        </div>
        <form id="sheet-search-form" name="sheet-search-form" method="post">
        	<input type="hidden" name="rows" value="<c:out value="${constants.SHEET_ROWS}" default="100" />" />
            <input type="hidden" name="infId" value="<c:out value="${param.infId}" default="" />" />
            <input type="hidden" name="infSeq" value="<c:out value="${param.infSeq}" default="" />" />
            <input type="hidden" name="downloadType" value="<c:out value="${param.downloadType}" default="" />" />
		</form>

		<script type="text/javascript">
			// 관련사이트 탭
			$(function(){
				
			
			});
		</script>
		
		<div>
			<ul id="treeDemo" class="ztree"></ul>
		</div>

        <!-- 목록 -->
        <div class="tab_C">
            <a href="#area-sheet-sect-1" class="gallery-section-tab on">sheet-1</a>
        </div>
        
        <section class="tab_C_cont">
			<div class="area_sheet" id="area-sheet-sect-1">
            	<div id="sheet-object-sect-1" class="sheet"></div>
         	</div>
        </section>
       
        <!-- // 목록 -->
        
        
        <!-- // Sheet -->
        <form id="dataset-search-form" name="dataset-search-form" method="post">
            <input type="hidden" name="page" value="<c:out value="${param.page}" default="1" />" />
            <input type="hidden" name="rows" value="<c:out value="${param.rows}" default="10" />" />
            <input type="hidden" name="infId" value="<c:out value="${param.infId}" default="" />" />
            <input type="hidden" name="infSeq" value="<c:out value="${param.infSeq}" default="" />" />
            <input type="hidden" name="order" value="<c:out value="${param.order}" default="" />" />
            <c:forEach items="${paramValues}" var="parameter">
            <c:set var="key" value="${parameter.key}" />
            <c:if test="${key == 'orgCd' || key == 'cateId' || key == 'srvCd' || key == 'infTag' || key == 'searchWord'}">
            <c:forEach items="${parameter.value}" var="value">
            <input type="hidden" name="${key}" value="${value}" />
            </c:forEach>
            </c:if>
            </c:forEach>
        </form>

    </div>
    <!-- // content -->
   
	<!-- // content -->
</div>
<!-- // layout_flex #################### -->
</div></div>		
<!-- // wrap_layout_flex ############################## -->
<%@ include file="/WEB-INF/jsp/ggportal/sect/footer.jsp" %>
</div>
<!-- // layout_A -->
</body>
</html>