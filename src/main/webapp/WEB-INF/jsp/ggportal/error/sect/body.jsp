<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%-- @(#)body.jsp 1.0 2015/06/15                                            --%>
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
<%-- 오류 바디 섹션 화면이다.                                               --%>
<%--                                                                        --%>
<%-- @author 김은삼                                                         --%>
<%-- @version 1.0 2015/06/15                                                --%>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<!-- layout_A -->
<div class="layout_error">
    <div class="area_error">
        <h1><a href="<c:url value='/'/>"><img src="<c:url value="/img/ggportal/desktop/common/h1.png" />"  alt="열린국회정보 정보공개포털" /></a></h1>
        <div class="error">
            <strong class="tit_error"><img src="<c:url value="/img/ggportal/desktop/remainder/txt_error.png" />"  alt="죄송합니다. 요청하신 페이지를 찾을 수 없습니다." /></strong>
            <p class="txt_error mq_tablet">잘못된 페이지를 호출하셨거나 일시적인 시스템 오작동으로<br />
            요청하신 페이지를 찾을 수 없습니다. 이용에 불편을 드려 죄송합니다.<br />
            <p class="txt_error mq_mobile">잘못된 페이지를 호출하셨거나 일시적인 시스템 오작동으로
            요청하신 페이지를 찾을 수 없습니다. 이용에 불편을 드려 죄송합니다.<br />
            <strong class="tit_error_english">Error-Page Not Found</strong><br/>
            <p class="txt_error_english">The page you were looking for has been moved or no longer existes.<br />
            Your browser will automatically take you to the main page after several seconds.</p>            
        </div>
    </div>
</div>
<!-- // layout_A -->