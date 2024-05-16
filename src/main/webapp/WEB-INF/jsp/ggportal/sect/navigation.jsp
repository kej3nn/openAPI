<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%-- @(#)navigation.jsp 1.0 2015/06/15                                      --%>
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
<%-- 네비게이션 섹션 화면이다.                                              --%>
<%--                                                                        --%>
<%-- @author 김은삼                                                         --%>
<%-- @version 1.0 2015/06/15                                                --%>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
        <!-- location -->
        <div id="global-navigation-sect" class="location">
            <a href="<c:url value="/" />" title="메인으로 이동"><img src="<c:url value="/img/ggportal/desktop/common/btn_home.png" />" alt="메인페이지 이동" /></a>
            <c:choose>
            <c:when test="${empty requestScope.menu.lvl2MenuPath}">
            &gt;
            <strong><c:out value="${requestScope.menu.lvl1MenuPath}" /></strong>
            </c:when>
            <c:otherwise>
            &gt;
            <a href="#"><c:out value="${requestScope.menu.lvl1MenuPath}" /></a>
            &gt;
            <strong><c:out value="${requestScope.menu.lvl2MenuPath}" /></strong>
            </c:otherwise>
            </c:choose>
        </div>
        <script type="text/javascript">
            $(function() {
                if ($("#global-navigation-sect a").length > 1) {
                    $(".global-navigation-list").find("a").each(function(index, element) {
                        if ($(this).text() == "<c:out value="${requestScope.menu.lvl2MenuPath}" />") {
                            $("#global-navigation-sect a:eq(1)").attr("href",  $(this).parent("li").parent("ul").prev("a").attr("href"));
                            return false;
                        }
                    });
                }
            });
        </script>
        <!-- // location -->