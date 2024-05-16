<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%-- @(#)selectEvent.jsp 1.0 2015/06/15                                     --%>
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
<%-- 이벤트 게시판 내용을 조회하는 화면이다.                                --%>
<%--                                                                        --%>
<%-- @author 김은삼                                                         --%>
<%-- @version 1.0 2015/06/15                                                --%>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<!DOCTYPE html>
<html lang="ko">
<head>
<%@ include file="/WEB-INF/jsp/ggportal/sect/head.jsp" %>
<script type="text/javascript" src="<c:url value="/js/ggportal/bbs/event/selectEvent.js" />"></script>
</head>
<body>
<!-- layout_event -->
<div class="layout_event">
    <div class="area_logo">
        <a href="http://www.gm.go.kr" title="국회 홈페이지 이동" class="logo" style="margin-top:36px;"><img src="<c:url value="/img/ggportal/desktop/event/logo.png" />" alt="빛을 품은 광명시" /></a>
        <h1 style="margin-top:41px;"><a href="<c:url value="/" />" title="국회나눔데이터 메인페이지 이동"><img src="<c:url value="/img/ggportal/desktop/event/h1.png" />" alt="광명나눔데이터" /></a></h1>
    </div>
    <h2 class="hide">이벤트</h2>
    <h3 class="hide">국회 나눔데이터 오픈 이벤트</h3>
    <div><img src="<c:url value="/img/ggportal/desktop/event/deco_event.png" />" alt="국회 나눔데이터 오픈 이벤트 옥의 티를 찾아라 국회 공공데이터 개방포털이 새롭게 개편되어 국회나눔데이터라는 이름으로 오픈하였습니다 국회는 시민의 삶에 유용한 공공데이터를 지속적으로 발굴하여 제공해 드릴 수 있도록 노력하겠습니다" /></div>
    <p class="txt_event mq_tablet"><img src="<c:url value="/img/ggportal/desktop/event/txt_event.png" />" alt="국회나눔데이터를 둘러보시고 발견한 버그나 개선의견을 보내주세요 여러분의 의견을 모아 개선을 위한 소중한 자료로 활용하겠습니다" /></p>
    <div class="area_event">
        <div class="info">  
            <table>
            <caption>이벤트 응모 정보</caption>
            <tbody>
            <tr>    
                <th scope="row">참여 기간</th>      
                <td>2018. 3. 19(월) ~ 2018. 3. 30(금)</td>
            </tr>
            <tr>
                <th scope="row">참여 대상</th>      
                <td>누구나</td>
            </tr>
            <tr>
                <th scope="row">당첨자 발표</th>  
                <td>2018. 4. 3(화) 국회나눔데이터 공지사항에 게시</td>
            </tr>
            <tr>
                <th scope="row">경품 내역</th>      
                <td>스타벅스 기프티콘(추첨)</td>
            </tr>
            <tr>
           	<th scope="row">참여 방법</th>      
            <td>하단의  <strong class="point_A">이벤트 응모하기</strong> 버튼을 클릭하여 개선의견을 남겨주세요.</td>
            </tbody>
            </table>
            <p>이벤트에 참여하신 분들께는 추첨을 통해 소정의 상품을 드립니다.<br />
            더 나은 공공데이터 개방 서비스가 제공될 수 있도록 여러분들의 많은 참여를 바랍니다.</p>
            <div class="area_btn_E">
                <c:choose>
                <c:when test="${data.bbsOpenYn == 'Y'}">
                <a href="#" class="btn_EB event-insert-button opened">이벤트 응모하기</a>
                </c:when>
                <c:otherwise>
                <a href="#" class="btn_EB event-insert-button closed">이벤트 응모하기</a>
                </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
</div>
<!-- // layout_event -->
</body>
</html>