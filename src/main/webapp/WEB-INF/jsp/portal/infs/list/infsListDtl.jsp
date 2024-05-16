<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>

<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%-- @(#)infsListDtl.jsp 1.0 2019/08/19 	                                  --%>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>

<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%-- 정보공개 목록 상세화면이다.			 				                --%>
<%--                                                                        --%>
<%-- @author JHKIM                                                         --%>
<%-- @version 1.0 2019/08/19                                                --%>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<!DOCTYPE html>
<html lang="ko">
<head>
<!-- head include -->
<%@ include file="/WEB-INF/jsp/portal/sect/head.jsp" %>
</head>
<body>

<!-- header html -->
<%@ include file="/WEB-INF/jsp/portal/sect/header.jsp" %>

<!-- gnb -->
<%@ include file="/WEB-INF/jsp/portal/sect/gnb.jsp" %>

<div>
	<form id="searchForm">
		<div id="schParams">
		<c:forEach var="entry" items="${schParams}">
			<c:forEach var="value" items="${entry.value}">
				<input type="hidden" name="${entry.key }" value="${value }">
			</c:forEach>
		</c:forEach>
		<c:forEach var="entry" items="${schHdnParams}">
			<c:forEach var="value" items="${entry.value}">
				<input type="hidden" name="${entry.key }" value="${value }">
			</c:forEach>
		</c:forEach>
		<br><br>
		
		<span>서비스 구분 : ${param.opentyTag}</span>
		<span>오브젝트 ID : ${param.objId}</span>
		
		<div>
			<button id="btnList">목록으로</button>
		</div>
	</form>
</div>
<script>
$("#btnList").click(function() {
	var data = {};
	goSelect({
        url:"/portal/infs/list/infsListPage.do",
        form:"searchForm",
        method: "post",
        data:[{
            name:"infaId",
            value:data.infaId
        }
        , {
            name:"opentyTag",
            value:data.opentyTag
        }
        ]
    });
});
</script>

<!-- footer -->
<%@ include file="/WEB-INF/jsp/portal/sect/footer.jsp" %>
<!-- jquery tree plugin [Dynatree] -->
<link rel="stylesheet" href="<c:url value="/js/soportal/tree/skin/ui.dynatree.css" />" type="text/css">
<script type="text/javascript" src="<c:url value="/js/soportal/tree/jquery.dynatree.js" />"></script> 
</body>
</html>