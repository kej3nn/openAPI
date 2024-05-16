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
<c:when test="${fn:indexOf(requestScope.uri, '/portal/main/indexPage.do') >= 0}">
<title><c:out value="${pageScope.title}" /> | NABOSTATS 재정경제통계시스템</title>
</c:when>
<c:when test="${empty requestScope.menu.lvl2MenuPath}">
<title><c:out value="${pageScope.title}" /> | <c:out value="${requestScope.menu.lvl1MenuPath}" /> | NABOSTATS 재정경제통계시스템</title>
</c:when>
<c:when test="${empty requestScope.menu.lvl3MenuPath}">
<title><c:out value="${pageScope.title}" /> | <c:out value="${requestScope.menu.lvl2MenuPath}" /> | NABOSTATS 재정경제통계시스템</title>
</c:when>
<c:otherwise>
<title><c:out value="${pageScope.title}" /> | <c:out value="${requestScope.menu.lvl3MenuPath}" /> <c:out value="${pageScope.lvl3MenuSuffix}" /> | NABOSTATS 재정경제통계시스템</title>
</c:otherwise>
</c:choose>
</c:when>
<c:otherwise>
<c:choose>
<c:when test="${fn:indexOf(requestScope.uri, '/portal/main/indexPage.do') >= 0}">
<title>NABOSTATS 국회예산정책처 재정경제통계시스템</title>
</c:when>
<c:when test="${empty requestScope.menu.lvl2MenuPath}">
	<c:choose>
	<c:when test="${fn:indexOf(requestScope.uri, '/portal/compose/metainfoDetail/') >= 0}">
	<title>통계메타정보 | NABOSTATS 국회예산정책처 재정경제통계시스템</title>
	</c:when>
	<c:otherwise>
	<title><c:out value="${requestScope.menu.lvl1MenuPath}" /> | NABOSTATS 국회예산정책처 재정경제통계시스템</title>
	</c:otherwise>
	</c:choose>
</c:when>
<c:when test="${empty requestScope.menu.lvl3MenuPath}">
<title><c:out value="${requestScope.menu.lvl2MenuPath}" /> | NABOSTATS 국회예산정책처 재정경제통계시스템</title>
</c:when>
<c:otherwise>
<title><c:out value="${requestScope.menu.lvl3MenuPath}" /> <c:out value="${pageScope.lvl3MenuSuffix}" /> | NABOSTATS 국회예산정책처 재정경제통계시스템</title>
</c:otherwise>
</c:choose>
</c:otherwise>
</c:choose>

<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=Edge" /> 
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no, target-densitydpi=medium-dpi" />
<meta name="format-detection" content="telephone=no" />
<meta name="copyright" content="National Assembly Budget Office All Rights Reserved." />
<c:choose>
<c:when test="${!empty pageScope.description}">
<meta name="description" content="<c:out value="${pageScope.description}" />" />
</c:when>
<c:otherwise>
<meta name="description" content="재정총량·조세, 지방·공공기관, 경제, 인구·사회, 북한·국제 통계, 국회 예·결산 정보" />
</c:otherwise>
</c:choose>
<c:choose>
<c:when test="${!empty pageScope.title}">
<meta name="keywords" content="<c:out value="${pageScope.title}" />, 통계, 간편통계조회, 상세통계분석, 복수통계분석 국회심사연혁" />
</c:when>
<c:otherwise>
<meta name="keywords" content="통계, 간편통계조회, 상세통계분석, 복수통계분석, 국회심사연혁, 재정총량, 조세 북한통계, 국제통계, 인구, 사회" />
</c:otherwise>
</c:choose>
<meta property="og:type" content="website">
<meta property="og:title" content="NABOSTATS 국회예산정책처 재정경제통계시스템">
<meta property="og:description" content="재정총량·조세, 지방·공공기관, 경제, 인구·사회, 북한·국제 통계, 국회 예·결산 정보">
<meta property="og:image" content="http://www.nabostats.go.kr/images/soportal/common/logo@2x.png">
<meta property="og:url" content="http://www.nabostats.go.kr">

<!-- For old IEs -->
<link rel="shortcut icon" href="<c:url value="/images/soportal/icon/favicon.ico" />" />
<!-- For new browsers - multisize ico  -->
<link rel="icon" href="<c:url value="/images/soportal/icon/favicon.ico" />">

<link rel="stylesheet" type="text/css" href="<c:url value="/css/soportal/jquery-ui-1.9.2.custom.css" />" media="screen" />

<c:choose>
<c:when test="${fn:indexOf(requestScope.uri, '/portal/main/indexPage.do') >= 0}">
<link rel="stylesheet" type="text/css" href="<c:url value="/css/soportal/main.css" />" />
</c:when>
<c:when test="${fn:indexOf(requestScope.uri, '/portal/data/') >= 0}">
<link rel="stylesheet" type="text/css" href="<c:url value="/css/soportal/data.css" />" />
<script type="text/javascript" src="<c:url value="/js/chart/ibchart.js" />"></script>
</c:when>
<c:when test="${fn:indexOf(requestScope.uri, '/portal/adjust/') >= 0}">
<link rel="stylesheet" type="text/css" href="<c:url value="/css/soportal/data.css" />" />
</c:when>
<c:when test="${fn:indexOf(requestScope.uri, '/portal/bbs/') >= 0}">
<link rel="stylesheet" type="text/css" href="<c:url value="/css/soportal/communication.css" />" />
</c:when>
<c:when test="${fn:indexOf(requestScope.uri, '/portal/myPage/actKeyPage.do') >= 0}">
<link rel="stylesheet" type="text/css" href="<c:url value="/css/soportal/member.css" />" />
</c:when>
<c:when test="${fn:indexOf(requestScope.uri, '/portal/user/') >= 0}">
<link rel="stylesheet" type="text/css" href="<c:url value="/css/soportal/member.css" />" />
</c:when>
<c:when test="${fn:indexOf(requestScope.uri, '/portal/intro/') >= 0}">
<link rel="stylesheet" type="text/css" href="<c:url value="/css/soportal/intro.css" />" />
<script type="text/javascript" src="<c:url value="/js/chart/ibchart.js" />"></script>
</c:when>
<c:when test="${fn:indexOf(requestScope.uri, '/portal/stat/') >= 0}">
<link rel="stylesheet" type="text/css" href="<c:url value="/css/notokr.css" />" />
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
<%-- <link rel="stylesheet" type="text/css" href="<c:url value="/css/soportal/style.css" />" /> --%>
<link rel="stylesheet" type="text/css" href="<c:url value="/css/soportal/popup.css" />" />
<link rel="stylesheet" type="text/css" href="<c:url value="/css/soportal/data.css" />" />

<!-- 국가예산정책처  -->
<link rel="stylesheet" type="text/css" href="<c:url value="/css/soportal/board.css" />" />
<link rel="stylesheet" type="text/css" href="<c:url value="/css/soportal/contents.css" />" />
<link rel="stylesheet" type="text/css" href="<c:url value="/css/soportal/layout.css" />" />
<link rel="stylesheet" type="text/css" href="<c:url value="/css/soportal/reset.css" />" />
<link rel="stylesheet" type="text/css" href="<c:url value="/css/soportal/board_mobile.css" />" />
<link rel="stylesheet" type="text/css" href="<c:url value="/css/soportal/contents_mobile.css" />" />
<link rel="stylesheet" type="text/css" href="<c:url value="/css/soportal/layout_mobile.css" />" />
<link rel="stylesheet" type="text/css" href="<c:url value="/css/soportal/top_popup.css" />" />
<!-- //국가예산정책처 -->

<%-- <script type="text/javascript" src="<c:url value="/js/ggportal/jquery-1.10.2.min.js" />"></script> --%>
<script type="text/javascript" src="<c:url value="/js/jquery/jquery-2.2.4.min.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/ggportal/base-by-developer.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/ggportal/jquery.bx.js" />"></script>
<%-- <script type="text/javascript" src="<c:url value="/js/soportal/bxslider-by-developer.js" />"></script> --%>
<script type="text/javascript" src="<c:url value="/js/ggportal/html5.js" />"></script>
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
<script type="text/javascript" src="<c:url value="/js/ggportal/data/service/jquery.fileDownload.js" />"></script>
<!-- 테마,생애주기 js -->

<%--2016.02.17 게시판 등록 시 패스워드 암호화 BEGIN --%>
<script type="text/javascript" src="<c:url value="/js/cipher/tripledes.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/cipher/mode-ecb.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/cipher/encrypt.js" />"></script>
<%--2016.02.17 게시판 등록 시 패스워드 암호화 END --%>

<!-- bg 슬라이드를 위해 js 추가 -->
<%-- <script src="<c:url value="/js/soportal/responsiveslides.min.js" />"></script> --%>
<!-- //bg 슬라이드를 위해 js 추가 -->

<script type="text/javascript" src="<c:url value="/js/soportal/common/common.js" />"></script>
<script type="text/javascript">
    var getContextPath = "<c:out value="${pageContext.request.contextPath}" />";
</script>

