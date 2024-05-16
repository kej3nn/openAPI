<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%-- @(#)head.jsp 1.0 2015/06/15                                            --%>
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
<%-- 헤드 섹션 화면이다.                                                    --%>
<%--                                                                        --%>
<%-- @author 김은삼                                                         --%>
<%-- @version 1.0 2015/06/15                                                --%>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<c:choose>
<c:when test="${!empty pageScope.title}">
<c:choose>
<c:when test="${fn:indexOf(requestScope.uri, '/portal/mainPage.do') >= 0}">
<title><c:out value="${pageScope.title}" /> | 열린국회정보</title>
</c:when>
<c:when test="${empty requestScope.menu.lvl2MenuPath}">
<title><c:out value="${pageScope.title}" /> | <c:out value="${requestScope.menu.lvl1MenuPath}" /> | 열린국회정보</title>
</c:when>
<c:when test="${empty requestScope.menu.lvl3MenuPath}">
<title><c:out value="${pageScope.title}" /> | <c:out value="${requestScope.menu.lvl2MenuPath}" /> | 열린국회정보</title>
</c:when>
<c:otherwise>
<title><c:out value="${pageScope.title}" /> | <c:out value="${requestScope.menu.lvl3MenuPath}" /> <c:out value="${pageScope.lvl3MenuSuffix}" /> | 열린국회정보</title>
</c:otherwise>
</c:choose>
</c:when>
<c:otherwise>
<c:choose>
<c:when test="${fn:indexOf(requestScope.uri, '/portal/mainPage.do') >= 0}">
<title>열린국회정보</title>
</c:when>
<c:when test="${empty requestScope.menu.lvl2MenuPath}">
<title><c:out value="${requestScope.menu.lvl1MenuPath}" /> | 열린국회정보</title>
</c:when>
<c:when test="${empty requestScope.menu.lvl3MenuPath}">
<title><c:out value="${requestScope.menu.lvl2MenuPath}" /> | 열린국회정보</title>
</c:when>
<c:otherwise>
<title><c:out value="${requestScope.menu.lvl3MenuPath}" /> <c:out value="${pageScope.lvl3MenuSuffix}" /> | 열린국회정보</title>
</c:otherwise>
</c:choose>
</c:otherwise>
</c:choose>

<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no, target-densitydpi=medium-dpi" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="format-detection" content="telephone=no" />
<meta name="copyright" content="대한민국국회. ALL RIGHTS RESERVED." />
<!-- kakao talk -->
<meta property="og:title" content="열린국회정보">
<meta property="og:image" content="/kakao.png">
<meta property="og:image:width" content="800">
<meta property="og:image:height" content="400">
<meta property="og:url" content="https://open.assembly.go.kr">
<meta property="og:site_name" content="열린국회정보 정보공개포털">
<meta property="og:type" content="website">
<meta property="og:description" content="국회를 열다, 정보를 나누다.">

<c:choose>
<c:when test="${!empty pageScope.description}">
<meta name="description" content="<c:out value="${pageScope.description}" />" />
</c:when>
<c:otherwise>
<meta name="description" content="열린국회정보에서 필요한 자료를 손쉽게 찾아보세요. PC웹, 태블릿 PC, 모바일에서 편리하게 사용하실 수 있습니다." />
</c:otherwise>
</c:choose>
<c:choose>
<c:when test="${!empty pageScope.title}">
<meta name="keywords" content="<c:out value="${pageScope.title}" />, 데이터, data, 데이터셋, 멀티미디어, 데이터 시각화, 활용갤러리, 개방데이터 요청, 개발자 공간, 공공데이터 개방, 공공테이터 통계" />
</c:when>
<c:otherwise>
<meta name="keywords" content="대한민국국회, 데이터, data, 데이터셋, 멀티미디어, 데이터 시각화, 활용갤러리, 개방데이터 요청, 개발자 공간, 공공데이터 개방, 공공테이터 통계" />
</c:otherwise>
</c:choose>

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
<!-- Chrome for Android -->
<link rel="icon" sizes="192x192" href="<c:url value="/favicon-192.png" />">

<link rel="stylesheet" type="text/css" href="<c:url value="/css/jquery-ui-1.9.2.custom.css" />" media="screen" />

<link rel="stylesheet" type="text/css" href="<c:url value="/css/notokr.css" />" />
<link rel="stylesheet" type="text/css" href="<c:url value="/css/ggportal/base.css" />" />
<script type="text/javascript" src="<c:url value="/js/sheet/ibsheet.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/sheet/ibsheetinfo.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/chart/ibchartinfo.js" />"></script>
<c:choose>
	<c:when test="${requestScope.systemAppType eq 'clb'}">
	<link rel="stylesheet" type="text/css" href="<c:url value="/css/ggportal/layout_clb.css" />" />
	</c:when>
	<c:otherwise>
	<link rel="stylesheet" type="text/css" href="<c:url value="/css/ggportal/layout.css" />" />
	</c:otherwise>
</c:choose>
<link rel="stylesheet" type="text/css" href="<c:url value="/css/ggportal/event.css" />" />
<c:choose>
<c:when test="${fn:indexOf(requestScope.uri, '/portal/mainPage.do') >= 0}">
	<c:choose>
		<c:when test="${requestScope.systemAppType eq 'clb'}">
		<link rel="stylesheet" type="text/css" href="<c:url value="/css/ggportal/main_clb.css" />" />
		</c:when>
		<c:otherwise>
		<link rel="stylesheet" type="text/css" href="<c:url value="/css/ggportal/main.css" />" />
		</c:otherwise>
	</c:choose>
</c:when>
<c:when test="${fn:indexOf(requestScope.uri, '/portal/data/') >= 0}">
<link rel="stylesheet" type="text/css" href="<c:url value="/css/ggportal/data.css" />" />
<script type="text/javascript" src="<c:url value="/js/chart/ibchart.js" />"></script>
</c:when>
<c:when test="${fn:indexOf(requestScope.uri, '/portal/adjust/') >= 0}">
<link rel="stylesheet" type="text/css" href="<c:url value="/css/ggportal/data.css" />" />
</c:when>
<c:when test="${fn:indexOf(requestScope.uri, '/portal/bbs/') >= 0}">
<link rel="stylesheet" type="text/css" href="<c:url value="/css/ggportal/communication.css" />" />
</c:when>
<c:when test="${fn:indexOf(requestScope.uri, '/portal/myPage/actKeyPage.do') >= 0}">
<link rel="stylesheet" type="text/css" href="<c:url value="/css/ggportal/member.css" />" />
</c:when>
<c:when test="${fn:indexOf(requestScope.uri, '/portal/user/') >= 0}">
<link rel="stylesheet" type="text/css" href="<c:url value="/css/ggportal/member.css" />" />
</c:when>
<c:when test="${fn:indexOf(requestScope.uri, '/portal/intro/') >= 0}">
<link rel="stylesheet" type="text/css" href="<c:url value="/css/ggportal/intro.css" />" />
<script type="text/javascript" src="<c:url value="/js/chart/ibchart.js" />"></script>
</c:when>
<c:when test="${fn:indexOf(requestScope.uri, '/portal/stat/') >= 0}">
<link rel="stylesheet" href="<c:url value="/css/soportal/style.css" />" type="text/css">
</c:when>
<c:otherwise>
<link rel="stylesheet" type="text/css" href="<c:url value="/css/ggportal/remainder.css" />" />
</c:otherwise>
</c:choose>
<link rel="stylesheet" type="text/css" href="<c:url value="/css/ggportal/style.css" />" />
<link rel="stylesheet" type="text/css" href="<c:url value="/css/ggportal/popup.css" />" />
<link rel="stylesheet" type="text/css" href="<c:url value="/css/ggportal/data.css" />" />
<%--
<!--[if lt IE 9]>
<link rel="stylesheet" type="text/css" href="<c:url value="/incl/css/ie.css" />" />
<![endif]-->
--%>

<%-- <script type="text/javascript" src="<c:url value="/js/ggportal/jquery-1.10.2.min.js" />"></script> --%>
<script type="text/javascript" src="<c:url value="/js/jquery/jquery-2.2.4.min.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/ggportal/base-by-developer.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/ggportal/jquery.bx.js" />"></script>
<c:choose>
	<c:when test="${requestScope.systemAppType eq 'clb'}">
	</c:when>
	<c:otherwise>
	<script type="text/javascript" src="<c:url value="/js/ggportal/bxslider-by-developer.js" />"></script>
	</c:otherwise>
</c:choose>
<script type="text/javascript" src="<c:url value="/js/jquery/jquery-ui.min.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/jquery/json.min.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/jquery/jquery.form.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/jquery/jquery.cookie.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/jquery/jquery.meio.mask.js" />" charset="utf-8"></script>
<script type="text/javascript" src="<c:url value="/js/commonchart.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/common/base/commonness.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/common/base/delegation.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/ggportal/data/service/jquery.fileDownload.js" />"></script>
<%--2016.02.17 게시판 등록 시 패스워드 암호화 BEGIN --%>
<script type="text/javascript" src="<c:url value="/js/cipher/tripledes.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/cipher/mode-ecb.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/cipher/encrypt.js" />"></script>
<%--2016.02.17 게시판 등록 시 패스워드 암호화 END --%>
<script src="https://developers.kakao.com/sdk/js/kakao.min.js"></script>

<script type="text/javascript">
    var getContextPath = "<c:out value="${pageContext.request.contextPath}" />";
</script>
<%-- 구글 애널리틱스 스크립트 BEGIN --%>
<!-- Global site tag (gtag.js) - Google Analytics -->
<script async src="https://www.googletagmanager.com/gtag/js?id=UA-158610642-1"></script>
<script>
	window.dataLayer = window.dataLayer || [];
	function gtag(){dataLayer.push(arguments);}
	gtag('js', new Date());

	gtag('config', 'UA-158610642-1');
</script>
<%-- 구글 애널리틱스 스크립트 END --%>

<%-- 카카오톡 공유를 위한 스크립트 BEGIN --%>
<%-- 2020-02-16 added by giinie --%>
<%-- globals.properties::Oauth2.Provider.Kakao.ClientId는 openAPI 용도로 파악됨 --%>
<script type="text/javascript">
	Kakao.init("6d0de373ee382b138fbfe6f47726a4b6");
</script>
<%-- 카카오톡 공유를 위한 스크립트 END --%>
