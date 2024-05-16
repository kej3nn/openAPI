<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%-- @(#)head.jsp 1.0 2019/08/12                                            --%>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>

<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%-- 헤드 섹션 화면이다.                                                    --%>
<%--                                                                        --%>
<%-- @author JHKIM                                                         --%>
<%-- @version 1.0 2019/08/12                                                --%>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>

<c:choose>
<c:when test="${fn:indexOf(requestScope.uri, '/portal/mainPage.do') >= 0}">
<title>열린국회정보</title>
</c:when>
<c:when test="${empty requestScope.menu.lvl2MenuPath}">
<title><c:out value="${fn:replace(requestScope.menu.lvl1MenuPath, '&amp;', '&')}"/> | 열린국회정보</title>
</c:when>
<c:when test="${empty requestScope.menu.lvl3MenuPath}">
<title><c:out value="${requestScope.menu.lvl2MenuPath}" /> | <c:out value="${fn:replace(requestScope.menu.lvl1MenuPath, '&amp;', '&')}"/> | 열린국회정보</title>
</c:when>
<c:otherwise>
<title><c:out value="${requestScope.menu.lvl2MenuPath}" /> <c:out value="${requestScope.menu.lvl3MenuPath}" /> <c:out value="${pageScope.lvl3MenuSuffix}" /> | 열린국회정보</title>
</c:otherwise>
</c:choose>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no, target-densitydpi=medium-dpi" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="format-detection" content="telephone=no" />
<meta name="copyright" content="대한민국국회. ALL RIGHTS RESERVED." />
<%-- <meta name="description" content="<c:out value="${pageScope.description}" />" /> --%>
<meta name="description" content="국회 및 지원기관이 보유한 정보를 체계화하고 통합·공개하여 국민과 공유하고 민간의 활용 촉진과 다양한 맞춤형 서비스를 제공하기 위해 구축된 정보공개 포털 서비스 입니다." />
<meta name="keywords" content="국회사무처,대한민국국회,정보공개,포털" />

<!-- For old IEs -->
<link rel="shortcut icon" href="<c:url value="/favicon.ico" />" />
<!-- For new browsers - multisize ico  -->
<link rel="icon" href="<c:url value="/favicon.ico" />">
<!-- For iPad with high-resolution Retina display running iOS ≥ 7: -->
<link rel="apple-touch-icon" sizes="152x152" href="<c:url value="/favicon-152.png" />">
<!-- For iPad with high-resolution Retina display running iOS ≤ 6: -->
<link rel="apple-touch-icon" sizes="144x144" href="<c:url value="/favicon-144.png" />">
<!-- For iPhone with high-resolution Retina display running iOS ≥ 7: -->
<link rel="apple-touch-icon" sizes="120x120" href="<c:url value="/favicon-120.png" />">
<!-- For iPhone with high-resolution Retina display running iOS ≤ 6: -->
<link rel="apple-touch-icon" sizes="114x114" href="<c:url value="/favicon-114.png" />">
<!-- For iPhone 6+ -->
<link rel="apple-touch-icon" sizes="180x180" href="<c:url value="/favicon-180.png" />">
<!-- For first- and second-generation iPad: -->
<link rel="apple-touch-icon" sizes="72x72" href="<c:url value="/favicon-72.png" />">
<!-- For non-Retina iPhone, iPod Touch, and Android 2.1+ devices: -->
<link rel="apple-touch-icon" href="<c:url value="/favicon-57.png" />">
<!-- For Old Chrome -->
<link rel="icon" href="<c:url value="/favicon-32.png" />" sizes="32x32">
<!-- For IE10 Metro -->
<meta name="msapplication-TileColor" content="#FFFFFF">
<meta name="msapplication-TileImage" content="<c:url value="/favicon-144.png" />">
<!-- kakao talk -->
<meta property="og:title" content="열린국회정보">
<meta property="og:image" content="/kakao.png"> 
<meta property="og:image:width" content="800">
<meta property="og:image:height" content="400"> 
<meta property="og:url" content="https://open.assembly.go.kr"> 
<meta property="og:site_name" content="열린국회정보 정보공개포털"> 
<meta property="og:type" content="website">
<meta property="og:description" content="국회를 열다, 정보를 나누다.">

<!-- Chrome for Android -->
<link rel="icon" sizes="192x192" href="<c:url value="/favicon-192.png" />">

<link rel="stylesheet" type="text/css" href="<c:url value="/css/jquery-ui-1.9.2.custom.css" />" media="screen" />
<link rel="stylesheet" type="text/css" href="<c:url value="/css/portal/default.css" />" />
<link rel="stylesheet" type="text/css" href="<c:url value="/css/portal/notokr.css" />" />
<link rel="stylesheet" type="text/css" href="<c:url value="/css/portal/layout.css" />" />
<link rel="stylesheet" type="text/css" href="<c:url value="/css/portal/layout_mobile.css" />" />
<link rel="stylesheet" type="text/css" href="<c:url value="/css/portal/search.css" />" />
<link rel="stylesheet" type="text/css" href="<c:url value="/css/portal/search_mobile.css" />" />

<script type="text/javascript" src="<c:url value="/js/jquery/jquery-2.2.4.min.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/jquery/jquery-ui.min.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/jquery/json.min.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/jquery/jquery.form.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/ggportal/data/service/jquery.fileDownload.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/jquery/jquery.cookie.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/jquery/jquery.meio.mask.js" />" charset="utf-8"></script>
<%-- 메인에서는 IBSHEET 제외 --%>
<c:choose>
<c:when test="${fn:indexOf(requestScope.uri, '/portal/mainPage') >= 0}"></c:when>
<c:otherwise>
	<script type="text/javascript" src="<c:url value="/js/sheet/ibsheet.js" />"></script>
	<script type="text/javascript" src="<c:url value="/js/sheet/ibsheetinfo.js" />"></script>
</c:otherwise>
</c:choose>

<script type="text/javascript" src="<c:url value="/js/common/base/commonness.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/common/base/delegation.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/common.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/lodash.min.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/ggportal/jquery.bx.js" />"></script>
<%-- 구글 애널리틱스 스크립트 BEGIN 내부망은 제외함 --%>
<c:choose>
<c:when test="${fn:indexOf(requestScope.userIp, '10.') >= 0}">
</c:when>
<c:when test="${fn:indexOf(requestScope.userIp, '192.168') >= 0}">
</c:when>
<c:otherwise>
<!-- Global site tag (gtag.js) - Google Analytics -->
<script async src="https://www.googletagmanager.com/gtag/js?id=UA-158610642-1"></script>
<script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());

  gtag('config', 'UA-158610642-1');
</script>
</c:otherwise>
</c:choose>
<%-- 구글 애널리틱스 스크립트 END --%>

<%-- 카카오톡 공유를 위한 스크립트 BEGIN --%>
<%-- 2020-02-16 added by giinie --%>
<c:choose>
<c:when test="${fn:indexOf(requestScope.userIp, '10.') >= 0}">
</c:when>
<c:when test="${fn:indexOf(requestScope.userIp, '192.168') >= 0}">
</c:when>
<c:otherwise>
<script src="https://developers.kakao.com/sdk/js/kakao.min.js"></script>
<script type="text/javascript">
    Kakao.init("6d0de373ee382b138fbfe6f47726a4b6");
</script>
</c:otherwise>
</c:choose>
<%-- 카카오톡 공유를 위한 스크립트 END --%>

<c:choose>
<c:when test="${fn:indexOf(requestScope.uri, '/portal/stat/') >= 0}">
<script type="text/javascript">
    var getContextPath = "<c:out value="${pageContext.request.contextPath}" />";
    var serverName ="${pageContext.request.serverName}";
    var serverPort ="${pageContext.request.serverPort}";
    if ( serverPort != "80" ){                                               
    	var serverAddr = "http://"+serverName+":"+serverPort+getContextPath;
    }
    else{
    	var serverAddr = "http://"+serverName+getContextPath;
    }
    var tabContentClass= "tabArea";               
    var tabId = "tabTitle";             
    var tabBody="easySearchArea";
    var tabSeq = 1;
</script>
</c:when>
<c:when test="${fn:indexOf(requestScope.uri, '/portal/bbs/') >= 0}">
<script type="text/javascript">
	var getContextPath = "<c:out value="${pageContext.request.contextPath}" />";
</script>
<script type="text/javascript" src="<c:url value="/js/cipher/tripledes.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/cipher/mode-ecb.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/cipher/encrypt.js" />"></script>
</c:when>
<c:otherwise>
<script type="text/javascript">
    var getContextPath = "<c:out value="${pageContext.request.contextPath}" />";
</script>
</c:otherwise>
</c:choose>

<script type="text/javascript" src="<c:url value="/js/portal/menu.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/portal/common.js" />"></script>
<!--  Mind Map -->
<link rel="stylesheet" type="text/css" href="<c:url value="/css/component/Jit/Spacetree.css" />" />
<link rel="stylesheet" type="text/css" href="<c:url value="/css/component/Jit/style.css" />" />
<script type="text/javascript" src="<c:url value="/js/common/component/jquery.fittext.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/common/Jit/jit.custom.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/common/Jit/mindMap_data.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/common/Jit/script.js" />"></script>

<c:if test="${fn:indexOf(requestScope.uri, '/portal/data/service/') >= 0}">
<script type="text/javascript" src="<c:url value="/js/ggportal/base-by-developer.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/ggportal/bxslider-by-developer.js" />"></script>
</c:if>
<c:if test="${fn:indexOf(requestScope.uri, '/portal/stat/') >= 0}">
<script type="text/javascript" src="<c:url value="/js/commonValidation.js" />"></script>                
<script type="text/javascript" src="<c:url value="/js/commonCalendar.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/commonViewFun.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/tabsStatSch.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/map.js" />"></script>                
<script type="text/javascript" src="<c:url value="/SmartEditor2/js/HuskyEZCreator.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/soportal/common/common.js" />"></script>
</c:if>