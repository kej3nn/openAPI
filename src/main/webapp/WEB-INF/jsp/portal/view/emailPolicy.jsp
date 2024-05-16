<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%-- @(#)emailPolicy.jsp 1.0 2015/06/15                                     --%>
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
<%-- 이메일무단수집거부를 조회하는 화면이다.                                --%>
<%--                                                                        --%>
<%-- @author 김은삼                                                         --%>
<%-- @version 1.0 2015/06/15                                                --%>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<!DOCTYPE html>
<html lang="ko">
<head>
<%@ include file="/WEB-INF/jsp/ggportal/sect/head.jsp" %>
</head>
<body>
<!-- layout_A -->
<div class="layout_A">
<%@ include file="/WEB-INF/jsp/ggportal/sect/header.jsp" %>
<!-- wrap_layout_flex -->
<div class="wrap_layout_flex"><div class="layout_flex_100">
<%@ include file="/WEB-INF/jsp/ggportal/sect/gnb.jsp" %>
<!-- layout_flex -->
<div class="layout_flex">
    <!-- content -->
    <div id="content" class="content_B">
        <%@ include file="/WEB-INF/jsp/ggportal/sect/navigation.jsp" %>
        <h2 class="hide"><c:out value="${requestScope.menu.lvl1MenuPath}" /></h2>
        <div class="area_h3 area_h3_AB deco_h3_4">
            <h3 class="ty_A"><img src="<c:url value="/img/ggportal/desktop/remainder/h3_5_3.png" />" alt="<c:out value="${requestScope.menu.lvl1MenuPath}" />" /><strong><c:out value="${requestScope.menu.lvl1MenuPath}" /></strong></h3>
            <p></p>
        </div>
        <h4 class="ty_A mq_tablet">이메일무단수집거부</h4>
        <div class="area_email_agreement box_C"><div class="email_agreement">
            <span class="icon_email_agreement mq_tablet"><img src="<c:url value="/img/ggportal/desktop/remainder/icon_email_agreement.png" />"  alt="SPAM" /></span>
            <span class="icon_email_agreement mq_mobile"><img src="<c:url value="/img/ggportal/mobile/remainder/icon_email_agreement.png" />"  alt="SPAM" /></span>
            <div>
            <strong class="tit_email_agreement mq_tablet"><img src="<c:url value="/img/ggportal/desktop/remainder/tit_email_agreement.png" />" alt="이메일무단수집거부" /></strong>
            <p class="txt_email_agreement mq_tablet">사이트 회원에게 무차별적으로 보내지는 메일을<br />
            차단하기 위해 본 웹사이트는 게시된 이메일 주소가 전자우편 수집 프로그램이나<br />
            그 밖에 기술적 장치를 이용하여 무단으로 수집되는 것을 거부하며,<br />
            이를 위반시 <strong class="point_B">정보통신망법에 의해 형사처벌됨</strong>을 유념하시기 바랍니다.</p>
            <p class="txt_email_agreement mq_mobile">사이트 회원에게 무차별적으로 보내지는 메일을
            차단하기 위해 본 웹사이트는 게시된 이메일 주소가 전자우편 수집 프로그램이나
            그 밖에 기술적 장치를 이용하여 무단으로 수집되는 것을 거부하며
            이를 위반시 <strong class="point_B">정보통신망법에 의해 형사처벌됨</strong>을 유념하시기 바랍니다.</p>
            </div>
        </div></div>
    </div>
    <!-- // content -->
</div>
<!-- // layout_flex -->
</div></div>        
<!-- // wrap_layout_flex -->
<%@ include file="/WEB-INF/jsp/ggportal/sect/footer.jsp" %>
</div>
<!-- // layout_A -->
</body>
</html>