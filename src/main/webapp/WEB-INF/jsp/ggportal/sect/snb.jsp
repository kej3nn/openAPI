<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%-- @(#)snb.jsp 1.0 2015/06/15                                             --%>
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
<%-- 서브 메뉴 섹션 화면이다.                                               --%>
<%--                                                                        --%>
<%-- @author 김은삼                                                         --%>
<%-- @version 1.0 2015/06/15                                                --%>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
        <div id="global-lnb-sect" class="LNB">
            <c:choose>
            <c:when test="${fn:indexOf(requestScope.uri, '/portal/data/') >= 0}">
            <span class="tit tit_1"><strong><c:out value="${requestScope.menu.lvl1MenuPath}" /></strong></span>
            </c:when>
            <c:when test="${fn:indexOf(requestScope.uri, '/portal/bbs/') >= 0}">
            <span class="tit tit_2"><strong><c:out value="${requestScope.menu.lvl1MenuPath}" /></strong></span>
            </c:when>
            <c:when test="${fn:indexOf(requestScope.uri, '/portal/intro/') >= 0}">
            <span class="tit tit_3"><strong><c:out value="${requestScope.menu.lvl1MenuPath}" /></strong></span>
            </c:when>
            <c:when test="${fn:indexOf(requestScope.uri, '/portal/myPage/') >= 0}">
            <span class="tit tit_4"><strong><c:out value="${requestScope.menu.lvl1MenuPath}" /></strong></span>
            </c:when>
            </c:choose>
            <ul>
            <c:forEach items="${requestScope.menus}" var="menu" varStatus="status">
            <c:choose>
            <c:when test="${pageScope.menu.menuNm == requestScope.menu.lvl2MenuPath}">
            <c:choose>
            <c:when test="${pageScope.menu.menuUrl != '#'}">
            <li><a href="<c:url value="${pageScope.menu.menuUrl}" />" class="on"><c:out value="${pageScope.menu.menuNm}" /></a></li>
            </c:when>
            <c:otherwise>
            <li><a href="javascript:alert('서비스 준비중 입니다.');" class="on"><c:out value="${pageScope.menu.menuNm}" /></a></li>
            </c:otherwise>
            </c:choose>
            </c:when>
            <c:otherwise>
            <c:choose>
            <c:when test="${pageScope.menu.menuUrl != '#'}">
            <li><a href="<c:url value="${pageScope.menu.menuUrl}" />"><c:out value="${pageScope.menu.menuNm}" /></a></li>
            </c:when>
            <c:otherwise>
            <li><a href="javascript:alert('서비스 준비중 입니다.');"><c:out value="${pageScope.menu.menuNm}" /></a></li>
            </c:otherwise>
            </c:choose>
            </c:otherwise>
            </c:choose>
            </c:forEach>
            </ul>
        </div>
        <script type="text/javascript">
            $(function() {
                $(".LNB").find("a").each(function(index, element) {
                    // 좌측 메뉴에 클릭 이벤트를 바인딩한다.
                    $(this).bind("click", function(event) {
                        window.location.href = $(this).attr("href");
                        return false;
                    });
                    
                    // 좌측 메뉴에 키다운 이벤트를 바인딩한다.
                    $(this).bind("keydown", function(event) {
                        if (event.which == 13) {
                            window.location.href = $(this).attr("href");
                            return false;
                        }
                    });
                });
            });
        </script>