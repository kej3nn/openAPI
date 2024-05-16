<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%-- @(#)main.jsp 1.0 2019/10/14											--%>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>

<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%-- 메인 화면이다.														--%>
<%--																		--%>
<%-- @author Softon														--%>
<%-- @version 1.0 2019/10/14												--%>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<!DOCTYPE html>
<html lang="ko">
<head>
<%@ include file="/WEB-INF/jsp/portal/sect/head.jsp" %>
<style type="text/css">

/* 링크스타일 */
a {text-decoration:none; cursor:pointer;}
a:link {color:#666; cursor:pointer;}
a:visited{color:#666; cursor:pointer;}
a:hover, a:focus, a:active {text-decoration:underline; cursor:pointer; color:#666;}

.ellipsis{overflow:hidden; white-space:nowrap; text-overflow:ellipsis; display:block;}

/* 메일링 코딩 */
.ymail_container{width:800px; margin:0 auto;}
.ymail_top{position:relative; height:61px;}
.ymail_top .logo{display:block; margin-top:20px;}
.ymail_num{position:absolute; top:0px; left:190px; font-size:20px; display:block; font-size:24px; font-family:"notoKrM"; background:url(../../images/mailing/bar.png) no-repeat 0px 20px; padding:10px 0 0 18px; color:#1e345b;}
.ymail_top .logo_assembly{ position:absolute; top:8px; right:5px;}
.ymail_cont{padding:40px; overflow:hidden;}
.ymail_cont{padding:40px;}
.ymail_odd{background:#f7f8fa;}

.ymail_tit_cont{position:relative; margin-bottom:15px;}
.ymail_tit{font-size:20px; font-family:"notoKrB"; color:#000000;}
.ymail_tit span{font-size:20px; font-family:"notoKrR"; color:#999999;}
.ymail_tit_more{font-size:18px; display:block; position:absolute; top:7px; right:10px;}
.ymail_tit_more span{color:#37cedb;}

.ymail_info_list{width:48%; margin-right:2%; float:left;}
.ymail_info_list li{margin:5px 0;}
.ymail_info_list a{display:block; background-color:#eff2f5; padding:8px 36px 8px 10px; border-radius:20px; font-size:16px; overflow:hidden; white-space:nowrap; text-overflow:ellipsis;}
.ymail_info_list a span{font-family:"notoKrB"; background:url(../../images/mailing/bar_b.png) no-repeat 50px 7px; padding-right:20px; text-align:right; display:inline-block; width:40px;}

.ymail_info_list a.one{background:url(../../images/mailing/medal1.png) no-repeat 97% 0; background-color:#37cedb; color:#fff;}
.ymail_info_list a.one span, .ymail_info_list a.two span, .ymail_info_list a.three span{background:url(../../images/mailing/bar_w.png) no-repeat 50px 7px;}
.ymail_info_list a.two{background:url(../../images/mailing/medal2.png) no-repeat 97% 0; background-color:#37cedb; color:#fff;}
.ymail_info_list a.three{background:url(../../images/mailing/medal3.png) no-repeat 97% 0; background-color:#37cedb; color:#fff;}


.ymail_schedule{}
.ymail_schedule li{float:left; width:226px; margin-left:21px;}
.ymail_schedule li:first-child{margin-left:0px;}
.ymail_schedule li a{display:block; text-align:center; padding:120px 0 0 0; font-size:18px; color:#000; font-family:"notoKrM";}
.ymail_schedule li a:hover, .ymail_schedule li a:focus, .ymail_schedule li a:active{text-decoration:none;}
.ymail_schedule li a span{ font-family:"notoKrB"; color:#22bdb6; font-size:36px; font-weight:bold;}
.ymail_schedule li a.schedule1{background:url(../../images/mailing/schedule1.png) no-repeat 0 0;}
.ymail_schedule li a.schedule2{background:url(../../images/mailing/schedule2.png) no-repeat 0 0;}
.ymail_schedule li a.schedule3{background:url(../../images/mailing/schedule3.png) no-repeat 0 0;}


.ymail_word_cont{background:url(../../images/mailing/word_img.png) no-repeat 60px 40px;overflow:hidden; padding:10px 0; }
.ymail_word{float:left; margin-left:40px; width:215px;}
.ymail_word_cont .left{margin-left:246px;}
.ymail_word li{position:relative;}
.ymail_word li a{display:block; font-size:16px; color:#666; width:80%; padding:3px 0; line-height:22px; overflow:hidden; white-space:nowrap; text-overflow:ellipsis;}
.ymail_word li a:hover, .ymail_word li a:focus, .ymail_word li a:active{text-decoration:none; color:#000;}
.ymail_word li a span.circle{display:inline-block; width:22px; height:22px; border-radius:100px; background:#0c2c60; color:#fff; font-family:"notoKrM"; text-align:center; font-size:12px; margin-right:5px;}

.ymail_word li span.plus, .ymail_word li span.minus, .ymail_word li span.draw{ position:absolute; top:6px; right:0; font-size:12px; color:#999; padding-left:10px; width:30px; text-align:center;}
.ymail_word li span.plus{background:url(../../images/mailing/ic_plus.png) no-repeat 0 5px;}
.ymail_word li span.minus{background:url(../../images/mailing/ic_minus.png) no-repeat 0 5px;}
.ymail_word li span.draw{background:url(../../images/mailing/ic_draw.png) no-repeat 0 5px;}


.ymail_bbs{}
.ymail_bbs li{position:relative;}
.ymail_bbs li a{padding:5px 0; display:block;overflow:hidden; white-space:nowrap; text-overflow:ellipsis; width:83%;}
.ymail_bbs li span{position:absolute; top:7px; right:10px; font-size:12px; color:#999;}


.ymail_event{}
.ymail_event li{float:left; width:226px; margin-left:21px;}
.ymail_event li:first-child{margin-left:0px;}
.ymail_event li a{display:block; padding:0 0 0 0;}
.ymail_event li a img{margin-bottom:5px;width:226px;}
.ymail_event li a:hover, .ymail_event li a:focus, .ymail_event li a:active{}
.ymail_event li span{color:#999; font-size:12px;}


.ymail_quick{}
.ymail_quick li{float:left; width:226px; margin-left:21px;}
.ymail_quick li:first-child{margin-left:0px;}


.ymail_open{padding:3px 0 0 160px; position:relative;}
.ymail_open a{position:absolute; top:0; left:0;}
.ymail_open span{font-family:"notoKrM"; color:#000;}


.footer_container{border-top:1px solid #e2e7ed;}
.footer_cont{width:800px; margin:0 auto; text-align:center; padding:20px 0 40px 0;}
.footer_cont img{margin-bottom:10px}
</style>
</head>
<body>

<div class="ymail_container">
	<div class="ymail_top">
		<a href="#none" class="logo" target="_blank"><img src="<c:url value="/images/mailing/logo.png"/>" alt="열린국회정보 정보공개포털"></a>
        <span class="ymail_num">제10호</span>
        <a href="#none" class="logo_assembly" target="_blank"><img src="<c:url value="/images/mailing/logo_assembly.png"/>" alt="대한민국국회"></a>
    </div>
	<div class="ymail_visual"><img src="<c:url value="/images/mailing/visual.png"/>" alt="Newsletter"></div>
    
    
    <div class="ymail_cont">
    	<div class="ymail_tit_cont">
        	<div class="ymail_tit">국회 공개 정보 Top 10</div>
            <a href="<c:url value="/portal/infs/list/infsListPage.do"/>" target="_blank" class="ymail_tit_more">더보기 <span>+</span></a>
        </div>
        <ol class="ymail_info_list" id="ymail_info_list">
        </ol>
        
        <ol class="ymail_info_list" id="ymail_info_list1">
        </ol>
    </div>
    
    
    
    
    <div class="ymail_cont ymail_odd">
    	<div class="ymail_tit_cont">
        	<div class="ymail_tit">금주의 국회 일정 
        	<c:forEach var="data" items="${weekList }" varStatus="status">
        		<span>(${data.strDt }~${data.endDt })</span>
        		<input type="hidden" value="${data.strDt }" name="strDt" id="strDt" title="시작날짜">
    			<input type="hidden" value="${data.endDt }" name="endDt" id="endDt" title="종료날짜">
        	</c:forEach>
        	</div>
        </div>
        <ul class="ymail_schedule">
        	<li>
            	<a href="http://www.assembly.go.kr/assm/assemact/council/council0101/assmSchCal/assemSchCal.do" target="_blank" class="schedule1">본회의<br><span id="assem">0</span></a>
            </li>
            <li>
            	<a href="http://www.assembly.go.kr/assm/assemact/council/council0101/assmSchCal/assemSchCal.do" target="_blank" class="schedule2">위원회<br><span id="cmmtt">0</span></a>
            </li>
            <li>
            	<a href="http://ampos.nanet.go.kr:7000/diaryList.do" target="_blank" class="schedule3">세미나/간담회<br><span id="semna">0</span></a>
            </li>
        </ul>
    </div>
    
    
    
<!--     
    <div class="ymail_cont">
    	<div class="ymail_tit_cont">
        	<div class="ymail_tit">국회 공개 정보 인기 검색어</div>
        </div>
        <div class="ymail_word_cont">
        	<ol class="ymail_word left">
            	<li><a href="#none"><span class="circle">1</span> 검색어검색어검색어검색어검색어검색어검색어검색어</a> <span class="plus">2</span></li>
                <li><a href="#none"><span class="circle">2</span> 검색어</a> <span class="plus">21</span></li>
                <li><a href="#none"><span class="circle">3</span> 검색어</a> <span class="draw">0</span></li>
                <li><a href="#none"><span class="circle">4</span> 검색어</a> <span class="minus">1</span></li>
                <li><a href="#none"><span class="circle">5</span> 검색어</a> <span class="minus">1</span></li>
            </ol>
            <ol class="ymail_word">
            	<li><a href="#none"><span class="circle">6</span> 검색어</a> <span class="plus">1</span></li>
                <li><a href="#none"><span class="circle">7</span> 검색어</a> <span class="plus">211</span></li>
                <li><a href="#none"><span class="circle">8</span> 검색어</a> <span class="draw">0</span></li>
                <li><a href="#none"><span class="circle">9</span> 검색어</a> <span class="minus">3</span></li>
                <li><a href="#none"><span class="circle">10</span> 검색어</a> <span class="minus">3</span></li>
            </ol>
        </div>
    </div>
 -->    
    
    
    <div class="ymail_cont ymail_odd">
    	<div class="ymail_tit_cont">
        	<div class="ymail_tit">국회는 지금</div>
            <a href="https://www.naon.go.kr/assemblyNews/naon_now/list.do" target="_blank" class="ymail_tit_more">더보기 <span>+</span></a>
        </div>
        <ul class="ymail_bbs">
        	<c:forEach var="data" items="${nowList }" varStatus="status">
	        	<li>
		        	<a href="${data.urlLink }" target="_blank">${data.vTitle }</a>
		        	<span>${data.dataReleased }</span>
		        </li>	
        	</c:forEach>
        </ul>
    </div>
    
    
    
    
    <div class="ymail_cont">
    	<div class="ymail_tit_cont">
        	<div class="ymail_tit">국회 행사</div>
        </div>
        <ul class="ymail_event">
        	<c:forEach var="data" items="${cultureList }" varStatus="status">
	        	<li>
	        		<a href="${data.linkUrl }" target="_blank">
		        	<img src="${data.imageUrl }" alt=""><br>
		        	${data.articleTitle }
		        	</a>
		        	<span>${data.dt }</span>
		        </li>	
        	</c:forEach>
        </ul>
    </div>
    
    
    <div class="ymail_cont ymail_odd">
    	<div class="ymail_tit_cont">
        	<div class="ymail_tit">바로가기</div>
        </div>
        <ul class="ymail_quick">
            <li>
                <a href="<c:url value="/portal/exposeInfo/guideOpnInfoPage.do"/>" target="_blank"><img src="<c:url value="/images/mailing/quick_info.png"/>" alt="정보공개청구"></a>
            </li>
            <li>
                <a href="<c:url value="/portal/theme/visual/searchVisualPage.do"/>" target="_blank"><img src="<c:url value="/images/mailing/quick_theme.png"/>" alt="테마정보"></a>
            </li>
            <li>
                <a href="<c:url value="/portal/openapi/main.do"/>" target="_blank"><img src="<c:url value="/images/mailing/quick_api.png"/>" alt="Open API"></a>
            </li>
        </ul>
    </div>
    
    
    
    <div class="ymail_cont">
        <div class="ymail_open">
        	<a href="http://www.kogl.or.kr" target="_blank"><img src="<c:url value="/images/mailing/open_nuri.png"/>" alt="공공누리"></a>
        	<span>출처표시 - 변경금지 : </span><br>
			출처표시 / 상업적, 비상업적 이용 가능 / 변형 등 2차적 저작물 작성금지
        </div>
    </div>
    
    
</div>



<div class="footer_container">
	<div class="footer_cont">
    	<a href="#none"><img src="/images/mailing/footer_logo.png" alt="국회"></a>
        <br>
        Copyright© National Assembly. All rights reserved. 
    </div>
</div>
<script type="text/javascript" src="<c:url value="/js/portal/mailing/mailing.js" />"></script>
</body>
</html>