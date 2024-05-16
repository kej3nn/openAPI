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
<%-- 오류 헤드 섹션 화면이다.                                               --%>
<%--                                                                        --%>
<%-- @author 김은삼                                                         --%>
<%-- @version 1.0 2015/06/15                                                --%>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%--
--%>
<title>오류 메세지 | 열린국회정보</title>

<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no, target-densitydpi=medium-dpi" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="format-detection" content="telephone=no" />
<meta name="copyright" content="대한민국국회. All Rights Reserved." />
<meta name="description" content="국회데이터 에서 필요한 자료를 손쉽게 찾아보세요. PC웹, 태블릿 PC, 모바일에서 편리하게 사용하실 수 있습니다." />
<meta name="keywords" content="대한민국, 국회, 정보공개, 데이터, data, 데이터셋, 활용갤러리, 개방데이터 요청, 개발자 공간" />

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

<link rel="stylesheet" type="text/css" href="<c:url value="/css/ggportal/base.css" />" />
<link rel="stylesheet" type="text/css" href="<c:url value="/css/ggportal/layout.css" />" />
<link rel="stylesheet" type="text/css" href="<c:url value="/css/ggportal/remainder.css" />" />
<link rel="stylesheet" type="text/css" href="<c:url value="/css/ggportal/style.css" />" />
<!--[if lt IE 9]>
<link rel="stylesheet" type="text/css" href="<c:url value="/incl/css/ie.css" />" />
<![endif]-->

<%-- <script type="text/javascript" src="<c:url value="/js/ggportal/jquery-1.10.2.min.js" />"></script> --%>
<script type="text/javascript" src="<c:url value="/js/jquery/jquery-2.2.4.min.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/ggportal/jquery.bx.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/ggportal/base-by-developer.js" />"></script>
<!--[if lt IE 9]>
<script type="text/javascript" src="<c:url value="/js/ggportal/html5.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/ggportal/respond.min.js" />"></script>
<![endif]-->

<%-- 2015.08.26 김은삼 [1] 김석균 수석님 추가요청 스크립트 BEGIN --%>
<script>
  (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
  (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
  m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
  })(window,document,'script','//www.google-analytics.com/analytics.js','ga');
  ga('create', 'UA-66786815-1', 'auto');
  ga('send', 'pageview');
</script>
<%-- 2015.08.26 김은삼 [1] 김석균 수석님 추가요청 스크립트 END --%>