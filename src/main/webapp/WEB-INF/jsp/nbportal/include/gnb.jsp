<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%-- @(#)gnb.jsp 1.0 2015/06/15                                             --%>
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
<%-- 상단 메뉴 섹션 화면이다.                                 --%>
<%--                                                                        --%>
<%-- @author 김정호                                                         --%>
<%-- @version 1.0 2018/01/15                                                --%>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<!-- 전체메뉴 -->

<div id="allMenu" class="area_allMenu" style="display:none">
<div class="allMenu_inner">
<div class="allMenu_title">전체메뉴</div>
<div class="allMenu">
<c:choose>
	<c:when test="${requestScope.systemAppType eq 'clb'}">
	<ul>
    <li class="allMenu_1">
        <a href="<c:url value="/portal/data/dataset/searchDatasetPage.do" />" class="tit">내부협업데이터</a>
        <ul class="global-navigation-list">
	        <li><a href="<c:url value="/portal/data/dataset/searchDatasetPage.do" />">데이터셋</a></li>
        </ul>
    </li>    
    <li class="allMenu_1">
        <a href="<c:url value="/portal/stat/easyStatPage.do"/>" class="tit" />통계데이터</a>
        <ul class="global-navigation-list">
			<li><a href="<c:url value="/portal/stat/easyStatPage.do" />">간편통계</a></li>
			<li><a href="<c:url value="/portal/stat/multiStatSch.do" />">복수통계</a></li>
        </ul>
    </li>
    <!-- 내부협업은 [활용] 메뉴 없음 -->
    <li class="allMenu_2">
        <a href="<c:url value="/portal/bbs/gallery/searchBulletinPage.do" />" class="tit">참여소통</a>
        <ul class="global-navigation-list">
	        <li><a href="<c:url value="/portal/bbs/notice/searchBulletinPage.do" />">공지사항</a></li>
			<li><a href="<c:url value="/portal/bbs/qna01/searchBulletinPage.do" />">Q&A</a></li>
			<li><a href="<c:url value="/portal/bbs/faq01/searchBulletinPage.do" />">FAQ</a></li>
        </ul>
    </li>
    <li class="allMenu_3">
        <a href="<c:url value="/portal/intro/intro/selectIntroPage.do" />" class="tit">소개</a>
        <ul class="global-navigation-list">
			<li><a href="<c:url value="/portal/intro/intro/selectIntroPage.do" />">사이트 소개</a></li>
		    <li><a href="<c:url value="/portal/intro/apply/selectApplyPage.do" />">내부협업데이터 제공신청</a></li>        
        </ul>
    </li>
    <li class="allMenu_1">
        <a href="<c:url value="/portal/myPage/myPage.do" />" class="tit">마이페이지</a>
        <ul class="global-navigation-list">
        	<li><a href="<c:url value="/portal/myPage/statUserScrapPage.do" />">통계스크랩</a></li>
	        <li><a href="<c:url value="/portal/myPage/myQnaPage.do" />">나의 질문 내역</a></li>
	        <li><a href="<c:url value="/portal/myPage/utilGalleryPage.do" />">활용갤러리</a></li>
	        <li><a href="<c:url value="/portal/myPage/deleteUserInfoPage.do" />">회원탈퇴</a></li>
        </ul>
    </li>
    </ul>
	</c:when>
	<c:otherwise>
    <ul>
    <li class="allMenu_1">
        <a href="<c:url value="/portal/data/dataset/searchDatasetPage.do" />" class="tit">공공데이터</a>
        <ul class="global-navigation-list">
	        <li><a href="<c:url value="/portal/data/dataset/searchDatasetPage.do" />">데이터셋</a></li>
			<li><a href="<c:url value="/portal/adjust/map/mapSearchPage.do" />">위치기반 데이터 찾기</a></li>
        </ul>
    </li>    
    <li class="allMenu_1">
        <a href="<c:url value="/portal/stat/easyStatPage.do"/>" class="tit">통계데이터</a>
        <ul class="global-navigation-list">
			<li><a href="<c:url value="/portal/stat/easyStatPage.do" />">간편통계</a></li>
			<li><a href="<c:url value="/portal/stat/multiStatSch.do" />">복수통계</a></li>
        </ul>
    </li>
    <li class="allMenu_2">
        <a href="<c:url value="/portal/bbs/gallery/searchBulletinPage.do" />" class="tit">활용</a>
        <ul class="global-navigation-list">
        	<li><a href="<c:url value="/portal/bbs/gallery/searchBulletinPage.do" />">활용갤러리</a></li>
			<li><a href="<c:url value="/portal/intro/intro/selectSitePage.do" />">관련사이트</a></li>
        </ul>
    </li>
    <li class="allMenu_2">
        <a href="<c:url value="/portal/bbs/gallery/searchBulletinPage.do" />" class="tit">참여소통</a>
        <ul class="global-navigation-list">
	        <li><a href="<c:url value="/portal/bbs/notice/searchBulletinPage.do" />">공지사항</a></li>
			<li><a href="<c:url value="/portal/bbs/qna01/searchBulletinPage.do" />">Q&A</a></li>
			<li><a href="<c:url value="/portal/bbs/faq01/searchBulletinPage.do" />">FAQ</a></li>
			<li><a href="<c:url value="/portal/bbs/idea/searchBulletinPage.do" />">아이디어 제안</a></li>
        </ul>
    </li>
    <li class="allMenu_3">
        <a href="<c:url value="/portal/intro/intro/selectIntroPage.do" />" class="tit">소개</a>
        <ul class="global-navigation-list">
			<li><a href="<c:url value="/portal/intro/intro/selectIntroPage.do" />">사이트 소개</a></li>
			<li><a href="<c:url value="/portal/bbs/develop/searchBulletinPage.do" />">Open API 소개</a></li>
		    <li><a href="<c:url value="/portal/bbs/stats/selectStatsPage.do" />">개방 통계</a></li>
		    <li><a href="<c:url value="/portal/intro/apply/selectApplyPage.do" />">공공데이터 제공신청</a></li>        
        </ul>
    </li>
    <li class="allMenu_1">
        <a href="<c:url value="/portal/myPage/myPage.do" />" class="tit">마이페이지</a>
        <ul class="global-navigation-list">
        	<li><a href="<c:url value="/portal/myPage/statUserScrapPage.do" />">통계스크랩</a></li>
	        <li><a href="<c:url value="/portal/myPage/actKeyPage.do" />">인증키 발급</a></li>
	        <li><a href="<c:url value="/portal/myPage/myQnaPage.do" />">나의 질문 내역</a></li>
	        <li><a href="<c:url value="/portal/myPage/utilGalleryPage.do" />">활용갤러리</a></li>
	        <li><a href="<c:url value="/portal/myPage/deleteUserInfoPage.do" />">회원탈퇴</a></li>
        </ul>
    </li>
    </ul>
	</c:otherwise>
</c:choose>
    
</div>  
<a href="javascript:btn_close_allMenu('allMenu');" onclick="javascript:btn_close_allMenu('allMenu');" onkeypress="javascript:btn_close_allMenu('allMenu');" class="btn_close_allMenu" title="전체메뉴 닫기"><span>전체메뉴 닫기</span></a>
</div>
<div class="bg_shadow">&nbsp;</div>
</div> 
<!-- // 전체메뉴 -->