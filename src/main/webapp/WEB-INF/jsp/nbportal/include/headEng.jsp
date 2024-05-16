<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%-- @(#)head.jsp 1.0 2018/02/01                                            --%>
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
<%-- 헤드 섹션 화면이다.                                                    		--%>
<%--                                                                        --%>
<%-- @author SoftOn                                                        	--%>
<%-- @version 1.0 2018/02/01                                                --%>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<c:choose>
<c:when test="${!empty pageScope.title}">
<c:choose>
<c:when test="${fn:indexOf(requestScope.uri, '/portal/main/indexEngPage.do') >= 0}">
<title><c:out value="${pageScope.title}" /> | HOUSTAT (HOUSING FINANCE STATISTICS)</title>
</c:when>
<c:when test="${empty requestScope.menu.lvl2MenuPath}">
<title><c:out value="${pageScope.title}" /> | <c:out value="${requestScope.menu.lvl1MenuPath}" /> | HOUSTAT (HOUSING FINANCE STATISTICS)</title>
</c:when>
<c:when test="${empty requestScope.menu.lvl3MenuPath}">
<title><c:out value="${pageScope.title}" /> | <c:out value="${requestScope.menu.lvl2MenuPath}" /> | HOUSTAT (HOUSING FINANCE STATISTICS)</title>
</c:when>
<c:otherwise>
<title><c:out value="${pageScope.title}" /> | <c:out value="${requestScope.menu.lvl3MenuPath}" /> <c:out value="${pageScope.lvl3MenuSuffix}" /> | HOUSTAT (HOUSING FINANCE STATISTICS)</title>
</c:otherwise>
</c:choose>
</c:when>
<c:otherwise>
<c:choose>
<c:when test="${fn:indexOf(requestScope.uri, '/portal/main/indexEngPage.do') >= 0}">
<title>HOUSTAT (HOUSING FINANCE STATISTICS)</title>
</c:when>
<c:when test="${empty requestScope.menu.lvl2MenuPath}">
<title><c:out value="${requestScope.menu.lvl1MenuPath}" /> | HOUSTAT (HOUSING FINANCE STATISTICS)</title>
</c:when>
<c:when test="${empty requestScope.menu.lvl3MenuPath}">
<title><c:out value="${requestScope.menu.lvl2MenuPath}" /> | HOUSTAT (HOUSING FINANCE STATISTICS)</title>
</c:when>
<c:otherwise>
<title><c:out value="${requestScope.menu.lvl3MenuPath}" /> <c:out value="${pageScope.lvl3MenuSuffix}" /> | HOUSTAT (HOUSING FINANCE STATISTICS)</title>
</c:otherwise>
</c:choose>
</c:otherwise>
</c:choose>

<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no, target-densitydpi=medium-dpi" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="format-detection" content="telephone=no" />
<meta name="copyright" content="KOREA HOUSING FINANCE CORPORATION. ALL RIGHTS RESERVED." />
<c:choose>
<c:when test="${!empty pageScope.description}">
<meta name="description" content="<c:out value="${pageScope.description}" />" />
</c:when>
<c:otherwise>
<meta name="description" content="주택금융통계시스템 에서 필요한 자료를 손쉽게 찾아보세요. PC웹, 태블릿 PC, 모바일에서 편리하게 사용하실 수 있습니다." />
</c:otherwise>
</c:choose>
<c:choose>
<c:when test="${!empty pageScope.title}">
<meta name="keywords" content="<c:out value="${pageScope.title}" />, 주택금융공사, 주택금융통계, 금융통계, 간편통계, 복수통계, 주택금융지수" />
</c:when>
<c:otherwise>
<meta name="keywords" content="주택금융공사, 주택금융통계, 금융통계, 간편통계, 복수통계, 주택금융지수" />
</c:otherwise>
</c:choose>

<!-- For old IEs -->
<link rel="shortcut icon" href="<c:url value="/images/soportal/icon/favicon.ico" />" />
<!-- For new browsers - multisize ico  -->
<link rel="icon" href="<c:url value="/images/soportal/icon/favicon.ico" />">

<link rel="stylesheet" type="text/css" href="<c:url value="/css/soportal/jquery-ui-1.9.2.custom.css" />" media="screen" />

<c:choose>
<c:when test="${fn:indexOf(requestScope.uri, '/portal/stat/') >= 0}">
<link rel="stylesheet" href="<c:url value="/css/soportal/style.css" />" type="text/css"> 
<script type="text/javascript" src="<c:url value="/js/common.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/commonValidation.js" />"></script>                
<script type="text/javascript" src="<c:url value="/js/commonCalendar.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/commonViewFun.js" />"></script>                  
<script type="text/javascript" src="<c:url value="/js/jquery/jquery-2.2.4.min.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/jquery/jquery.money.js" />"></script> 
<script type="text/javascript" src="<c:url value="/js/chart/ibchart.js" />"></script>
<script type="text/javascript" src="<c:url value="/validator.do" />"></script>                                                        
<script type="text/javascript" src="<c:url value="/js/tabsStatSch.js" />"></script>                                  
<script type="text/javascript" src="<c:url value="/js/map.js" />"></script>                         
<script type="text/javascript" src="<c:url value="/SmartEditor2/js/HuskyEZCreator.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/jquery.placeholder.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/jquery.simplemodal-1.4.4.js" />"></script> 
<script type="text/javascript">
var getContextPath = "${pageContext.request.contextPath}";
var serverName ="${pageContext.request.serverName}";
var serverPort ="${pageContext.request.serverPort}";
if(serverPort != "80" ){                                               
	var serverAddr = "http://"+serverName+":"+serverPort+getContextPath;
}else{
	var serverAddr = "http://"+serverName+getContextPath;
}
var tabContentClass= "tabArea";               
var tabId = "tabTitle";             
var tabBody="easySearchArea";
var tabSeq = 1;
</script>
</c:when>
<c:otherwise>
<link rel="stylesheet" type="text/css" href="<c:url value="/css/soportal/remainder.css" />" />
</c:otherwise>
</c:choose>
<link rel="stylesheet" type="text/css" href="<c:url value="/css/soportal/popup.css" />" />
<link rel="stylesheet" type="text/css" href="<c:url value="/css/soportal/data.css" />" /> 

<!-- 주택금융공사   -->
<link rel="stylesheet" href="<c:url value="/css/soportal/eng.css" />" type="text/css"> 
<link rel="stylesheet" type="text/css" href="<c:url value="/css/soportalEng/poppins.css" />" />
<link rel="stylesheet" type="text/css" href="<c:url value="/css/soportalEng/roboto.css" />" />
<link rel="stylesheet" type="text/css" href="<c:url value="/css/soportalEng/reset.css" />" />
<link rel="stylesheet" type="text/css" href="<c:url value="/css/soportalEng/layout.css" />" />
<link rel="stylesheet" type="text/css" href="<c:url value="/css/soportalEng/layout_mobile.css" />" />
<link rel="stylesheet" type="text/css" href="<c:url value="/css/soportalEng/contents.css" />" />
<link rel="stylesheet" type="text/css" href="<c:url value="/css/soportalEng/contents_mobile.css" />" />
<link rel="stylesheet" type="text/css" href="<c:url value="/css/soportalEng/board.css" />" />
<link rel="stylesheet" type="text/css" href="<c:url value="/css/soportalEng/board_mobile.css" />" />
<link rel="stylesheet" type="text/css" href="<c:url value="/css/soportal/responsiveslides.css" />" />
<!-- //주택금융공사 -->

<%-- <script type="text/javascript" src="<c:url value="/js/soportal/jquery-1.10.2.min.js" />"></script> --%>
<script type="text/javascript" src="<c:url value="/js/jquery/jquery-2.2.4.min.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/soportal/base-by-developer.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/soportal/jquery.bx.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/soportal/bxslider-by-developer.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/soportal/html5.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/jquery/jquery-ui.min.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/jquery/json.min.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/jquery/jquery.form.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/jquery/jquery.cookie.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/jquery/jquery.meio.mask.js" />" charset="utf-8"></script>
<script type="text/javascript" src="<c:url value="/js/sheet/ibsheet.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/sheet/ibsheetinfo.js" />"></script>

<script type="text/javascript" src="<c:url value="/js/chart/ibchartinfo.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/commonchart.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/common/base/commonness.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/common/base/delegation.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/soportal/data/service/jquery.fileDownload.js" />"></script>
<!-- 테마,생애주기 js -->

<%--2016.02.17 게시판 등록 시 패스워드 암호화 BEGIN --%>
<script type="text/javascript" src="<c:url value="/js/cipher/tripledes.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/cipher/mode-ecb.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/cipher/encrypt.js" />"></script>
<%--2016.02.17 게시판 등록 시 패스워드 암호화 END --%>

<!-- bg 슬라이드를 위해 js 추가 -->
<script src="<c:url value="/js/soportal/responsiveslides.min.js" />"></script>
<!-- //bg 슬라이드를 위해 js 추가 -->

<script type="text/javascript" src="<c:url value="/js/soportal/common/commonEng.js" />"></script>
<script type="text/javascript">
    var getContextPath = "<c:out value="${pageContext.request.contextPath}" />";
</script>

