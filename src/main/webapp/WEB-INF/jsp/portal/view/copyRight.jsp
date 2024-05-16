<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%-- @(#)privatePolicy.jsp 1.0 2015/06/15                                   --%>
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
<%-- 개인정보처리방침을 조회하는 화면이다.                                  --%>
<%--                                                                        --%>
<%-- @author 김춘삼                                                         --%>
<%-- @version 1.0 2015/06/15                                                --%>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<!DOCTYPE html>
<html lang="ko">
<head>
<%@ include file="/WEB-INF/jsp/portal/sect/head.jsp" %>
</head>
<body>
<!-- layout_A -->
<div class="layout_A">
<%@ include file="/WEB-INF/jsp/portal/sect/header.jsp" %>


<section>
	<div class="container hide-pc-lnb" id="container">
	<article>
		<div class="contents" id="contents">
			<div class="contents-title-wrapper">
				<h3>열린국회정보포털 저작권 보호 정책<span class="arrow"></span></h3>
       		</div>
			<div class="layout_flex_100">
				<div class="terms_txt">
				
					<div class="copyright_txt">
						<strong>
							<em>「저작권법」 제24조의2(공공저작물의 자유이용)</em>에 따라 열린국회정보포털에서 제공하는 자료 중  <em>국회가 업무상 작성하여 공표한 저작물이나 계약에 따라 저작재산권의 전부를 보유한 저작물</em>은 별도의 허락 없이 자유이용이 가능합니다.
						</strong>
						<strong>
							자유이용이 가능한 자료는 <em>공공저작물 자유이용허락 표시 기준(공공누리,KOGL)의  제1유형을 부착하여 개방하고 있습니다.</em>
						</strong>
						<span>
							* 공공누리의 제1유형 : 출처표시(공공저작물의 자유이용)
						</span>
						<span class="copyright_copyimg">
							<img src="/images/copyright01.gif" alt="공공누리-공공저작물 자유 이용허락 : 출처표시">
						</span>
						<strong>
							<em>따라서, 해당 정보공개항목의 메타정보 내 이용허락조건에 공공누리 제1유형 표시가 되어있는지 확인한 이후에 자유롭게 이용</em>하시기 바랍니다.
								<br>이러한 자유이용의 경우에도 반드시 <em>저작물의 출처를 구체적으로 표시</em>하여야 합니다.
						</strong>
						<span class="copyright_copyimg">
							<img src="/images/copyright_img.png" alt="공공데이터 내의 공공누리 유형 표시 예시">
						</span>
						<strong>
							<em>공공누리 제1유형 외에 2·3·4 유형(상업적 이용 금지, 변경금지 등)의 표시</em>가 부착된 자료, 또는 <em>공공누리가 부착되지 않은 자료</em>를 사용하고자 할 경우 반드시 <em>사전에 협의</em>하신 후 사용하여 주시기 바랍니다. 
						</strong>
						<div>
							<ul>
								<li>
									<div><img src="/images/copyright02.gif" alt="공공누리-공공저작물 자유 이용허락 : 출처표시,상업용금지"></div>
									<span>제2유형</span>
								</li>
								<li>
									<div><img src="/images/copyright03.gif" alt="공공누리-공공저작물 자유 이용허락 : 출처표시,변경금지"></div>
									<span>제3유형</span>
								</li>
								<li>
									<div><img src="/images/copyright04.gif" alt="공공누리-공공저작물 자유 이용허락 : 출처표시,상업용금지,변경금지"></div>
									<span>제4유형</span>
								</li>
							</ul>
						</div>
						<span>
							* 관련 정보 보기(공공누리 소개)(<a href="http://www.kogl.or.kr/info/introduce.do" target="_blank" title="공공누리 소개 URL">http://www.kogl.or.kr/info/introduce.do)</a>
						</span>
					</div>
					
				</div>
			</div>
       	</div>	
	</article>
</section>
      
<!-- // wrap_layout_flex -->
<%@ include file="/WEB-INF/jsp/portal/sect/footer.jsp" %>
</div>
<!-- // layout_A -->
</body>
</html>