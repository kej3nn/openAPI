<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%-- @(#)footer.jsp 1.0 2015/06/15                                          --%>
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
<%-- 하단 섹션 화면이다.                                                    --%>
<%--                                                                        --%>
<%-- @author 김은삼                                                         --%>
<%-- @version 1.0 2015/06/15                                                --%>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<!-- footer -->
<footer>
<div class="area_menu_footer">
    <div class="menu_footer">
        <a href="<c:url value="http://www.gm.go.kr/pt/guide/pinfopolicy/PTMN910.jsp" />" target="_blank">개인정보처리방침</a>
        <a href="<c:url value="http://www.gm.go.kr/pt/guide/PTMN929.jsp" />" target="_blank">저작권 정책</a>
        <a href="<c:url value="/portal/userAgreementPage.do" />">서비스이용약관</a>
        <a href="<c:url value="/portal/sitemapPage.do" />" class="mq_tablet">사이트맵</a>
	    <ul class="menu_footer_link">
        <c:choose>
        <c:when test="${requestScope.systemAppType eq 'clb'}">
	    	<li><a id="goAdmLink">포털 관리자</a></li>
	    	<li><a id="goClbLink">내부협업 관리자</a></li>
        </c:when>
        <c:otherwise>
        </c:otherwise>
    	</c:choose>
    	</ul>
    </div>
    <div class="menu_footer mq_mobile">
        <c:choose>
        <c:when test="${!empty sessionScope.portalUserCd}">
        <a href="<c:url value="/portal/user/oauth/logout.do" />">로그아웃</a>
        </c:when>
        <c:otherwise>
        <a href="<c:url value="/portal/user/oauth/authorizePage.do" />">로그인</a>
        </c:otherwise>
        </c:choose>
        <a href="/portal/myPage/myPage.do">마이페이지</a>
        <a href="<c:url value="/portal/bbs/faq01/searchBulletinPage.do"/>">FAQ</a>
    </div>
</div>
<div class="area_address">
    <span class="flogo"><img src="<c:url value="/img/ggportal/desktop/common/foot_logo.gif" />" alt="사람중심 행복도시 국회" /></span>
	<address><strong>우)07233 | 서울특별시 영등포구 의사당대로 1(여의도동)| 문의전화 : <span class="tel"> 문의전화 : 02-6788-2357  </span></strong> &copy; Copyright© National Assembly. All rights reserved. 대한민국국회 홈페이지의 모든 정보에 대한 권한은 국회에 있습니다.</address>
    <div id="family-site-sect" class="familySite">
        <a id="global-family-link" href="#none" class="toggle_familySite">관련사이트</a>
        <div id="view_familySite" class="view_familySite" style="display:none;">
        <ul id="global-family-list"></ul>
        </div>
        <a id="global-family-button" href="#none" class="btn_go_familySite">이동</a>
    </div>
    <script type="text/javascript">
        $(function() {
            // 관련사이트를 검색한다.
            searchFamilySite();
            
            $("#family-site-sect").bind("mouseleave", function(event) {
                $("#view_familySite").hide("slide", {
                    direction:"down"
                }, "slow");
            });
            
            $("#goAdmLink").bind("click", function(event) {
            	window.open(com.wise.help.url("/portal/user/sso/sendAdmAcc.do"), "", "status=no,resizable=yes,location=no,scrollbars=yes");
            });
            
            $("#goClbLink").bind("click", function(event) {
            	window.open(com.wise.help.url("/admin/adminMain.do"), "", "status=no,resizable=yes,location=no,scrollbars=yes");
            });
            
        });
        
        /**
         * 관련사이트를 검색한다.
         */
        function searchFamilySite() {
            // 데이터를 검색한다.
            doSearch({
                url:"/portal/settings.do",
                before:beforeSearchFamilySite,
                after:afterSearchFamilySite
            });
        }
        
        /**
         * 관련사이트를 검색 전처리를 실행한다.
         * 
         * @param options {Object} 옵션
         * @returns {Object} 데이터
         */
        function beforeSearchFamilySite(options) {
            var data = {
                homeTagCd:"FLINK"
            };
            
            return data;
        }
        
        /**
         * 관련사이트를 검색 후처리를 실행한다.
         * 
         * @param data {Array} 데이터
         */
        function afterSearchFamilySite(data) {
            var list = $("#global-family-list");
            
            list.find("li").each(function(index, element) {
                $(this).remove();
            });
            
            for (var i = 0; i < data.length; i++) {
                var item = $("<li><a href=\"#\"></a></li>");
                
                item.find("a").text(data[i].srvTit);
                
                // 관련사이트 링크에 클릭 이벤트를 바인딩한다.
                item.find("a").bind("click", {
                    srvTit:data[i].srvTit,
                    linkUrl:data[i].linkUrl
                }, function(event) {
                    // 관련사이트를 설정한다.
                    setFamilySite(event.data);
                    $('#global-family-button').focus();
                    return false;
                });
                
                // 관련사이트 링크에 키다운 이벤트를 바인딩한다.
                item.find("a").bind("keydown", {
                    srvTit:data[i].srvTit,
                    linkUrl:data[i].linkUrl
                }, function(event) {
                    if (event.which == 13) {
                        // 관련사이트를 설정한다.
                        setFamilySite(event.data);
                        $('#global-family-button').focus();
                        return false;
                    }
                });
                
                list.append(item);
            }
        }
        
        /**
         * 관련사이트를 설정한다.
         * 
         * @param data {Object} 데이터
         */
        function setFamilySite(data) {
            $("#global-family-link").text(data.srvTit).click();

            var button = $("#global-family-button");

            button.attr("href", data.linkUrl);
            button.attr("target", "_blank");
            button.attr("title", "새창으로 이동");
        }
    </script>
</div>
</footer>
<!-- // footer -->
<form id="global-request-form" name="global-request-form" method="post" action="<c:out value="${requestScope.action}" /><c:if test="${!empty requestScope.queryString}">?<c:out value="${requestScope.queryString}" escapeXml="false" /></c:if>">
    <c:forEach items="${paramValues}" var="parameter">
    <c:set var="key" value="${parameter.key}" />
    <c:set var="add" value="true" />
    <c:forEach items="${requestScope.queryNames}" var="name">
    <c:if test="${key == name}">
    <c:set var="add" value="false" />
    </c:if>
    </c:forEach>
    <c:if test="${key == 'ACTION' || key == 'userPw'}">
    <c:set var="add" value="false" />
    </c:if>
    <c:if test="${add}">
    <c:forEach items="${parameter.value}" var="value">
    <input type="hidden" name="${key}" value="${fn:escapeXml(value)}" />
    </c:forEach>
    </c:if>
    </c:forEach>
</form>
<iframe id="global-process-iframe" name="global-process-iframe"  title="프로그램 처리 영역" height="0" style="width:100%; display:none;"></iframe>

<%-- Naver Analytics 스크립트 BEGIN --%>
<%-- STEP 1. NA 스크립트인 wcslog.js 호출 --%>
<script type="text/javascript" src="//wcs.naver.net/wcslog.js"></script>
<script type="text/javascript">
    // STEP 2. na_account_id(네이버공통키) 세팅
    if(!wcs_add) var wcs_add = {};
    wcs_add["wa"] = "724dd300f4ac8";
    // STEP 3. 로그 서버로 전송
    wcs_do();
</script>
<%-- Naver Analytics 스크립트 END --%>
