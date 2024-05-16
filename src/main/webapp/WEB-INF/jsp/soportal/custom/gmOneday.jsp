<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="egovframework.common.WiseOpenConfig"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><spring:message code='wiseopen.title' /></title>
<c:import url="/WEB-INF/jsp/inc/headincludesoportal.jsp" />
<%@ include file="/WEB-INF/jsp/ggportal/sect/head.jsp" %>
	
<script type="text/javascript" src="<c:url value="/js/soportal/custom/gmOneday.js" />"></script>
</head>
<style type="text/css">
</style>
</head>
<body>
<!-- layout_A -->
<div class="layout_A">

<%@ include file="/WEB-INF/jsp/ggportal/sect/header.jsp" %>
<!-- wrap_layout_flex -->
<div class="wrap_layout_flex fix_page">
<div class="layout_easySearch layout_flex_100">
<%@ include file="/WEB-INF/jsp/ggportal/sect/gnb.jsp" %>

	<!-- layout_flex -->
	<div class="layout_flex">
		<!-- content -->
		<div class="content_B">
			<a href="#none" id="content" class="hide">본문시작</a>
			

			<!-- location -->
			<div id="global-navigation-sect" class="location pt12x">
				<a href="/portal/mainPage.do" title="메인으로 이동"><img src="/img/ggportal/desktop/common/btn_home.png" alt="국회 메인페이지 이동" /></a>
				<a href="#">통계데이터</a>
				<strong>국회의 하루</strong>
				
			</div>
			<script type="text/javascript">
				$(function() {
					if ($("#global-navigation-sect a").length > 1) {
						$(".global-navigation-list").find("a").each(function(index, element) {
							if ($(this).text() == "") {
								$("#global-navigation-sect a:eq(1)").attr("href",  $(this).parent("li").parent("ul").prev("a").attr("href"));
								return false;
							}
						});
					}
				});
			</script>
			<!-- // location -->
			<h2 class="hide">국회의 하루</h2>
			<div class="area_h4 mq_tablet">
				<p>국회의 하루</p>
			</div>
			
			<div class="line selRL">
				<select name="wrttimeStartYear" id="wrttimeStartYear" title="시작년">
					<c:forEach items="${wrttime}" var="wrttime" varStatus="status">
						<option value="${wrttime.code }">${wrttime.name } 년</option>
					</c:forEach>
				</select>
			</div>

			<div class="oneDayList">
				<ul>
					<li>
						<div class="bx">
							<i><img src="/img/ggportal/desktop/content/ico_oneDayList_1.png" alt="" /></i>
							<strong class="tit">인구</strong>
							<ul>
								<li>
									<strong>총인구</strong>
									<span class="dot">:</span>
									<span class="txt" id="itm10002"></span>
								</li>
								<li>
									<strong>총밀도</strong>
									<span class="dot">:</span>
									<span class="txt" id="itm10003"></span>
								</li>
							</ul>
						</div>
					</li>
					<li>
						<div class="bx">
							<i><img src="/img/ggportal/desktop/content/ico_oneDayList_2.png" alt="" /></i>
							<strong class="tit">세대수</strong>
							<ul>
								<li>
									<strong>총세대</strong>
									<span class="dot">:</span>
									<span class="txt" id="itm10005"></span>
								</li>
								<li>
									<strong>세대당</strong>
									<span class="dot">:</span>
									<span class="txt" id="itm10006"></span>
								</li>
							</ul>
						</div>
					</li>
					<li>
						<div class="bx">
							<i><img src="/img/ggportal/desktop/content/ico_oneDayList_3.png" alt="" /></i>
							<strong class="tit">출생</strong>
							<ul>
								<li>
									<strong>출생</strong>
									<span class="dot">:</span>
									<span class="txt" id="itm10008"></span>
								</li>
								<li>
									<strong>1일</strong>
									<span class="dot">:</span>
									<span class="txt" id="itm10009"></span>
								</li>
							</ul>
						</div>
					</li>
					<li>
						<div class="bx">
							<i><img src="/img/ggportal/desktop/content/ico_oneDayList_4.png" alt="" /></i>
							<strong class="tit">사망</strong>
							<ul>
								<li id="10011">
									<strong>사망</strong>
									<span class="dot">:</span>
									<span class="txt" id="itm10011"></span>
								</li>
								<li id="10012">
									<strong>1일</strong>
									<span class="dot">:</span>
									<span class="txt" id="itm10012"></span>
								</li>
							</ul>
						</div>
					</li>
					<li>
						<div class="bx">
							<i><img src="/img/ggportal/desktop/content/ico_oneDayList_5.png" alt="" /></i>
							<strong class="tit">혼인</strong>
							<ul>
								<li>
									<strong>혼인</strong>
									<span class="dot">:</span>
									<span class="txt" id="itm10014"></span>
								</li>
								<li>
									<strong>1일</strong>
									<span class="dot">:</span>
									<span class="txt" id="itm10015"></span>
								</li>
							</ul>
						</div>
					</li>
					<li>
						<div class="bx">
							<i><img src="/img/ggportal/desktop/content/ico_oneDayList_6.png" alt="" /></i>
							<strong class="tit">이혼</strong>
							<ul>
								<li>
									<strong>이혼</strong>
									<span class="dot">:</span>
									<span class="txt" id="itm10017"></span>
								</li>
								<li>
									<strong>1일</strong>
									<span class="dot">:</span>
									<span class="txt" id="itm10018"></span>
								</li>
							</ul>
						</div>
					</li>
					<li>
						<div class="bx">
							<i><img src="/img/ggportal/desktop/content/ico_oneDayList_7.png" alt="" /></i>
							<strong class="tit">전입</strong>
							<ul>
								<li>
									<strong>전입</strong>
									<span class="dot">:</span>
									<span class="txt" id="itm10020"></span>
								</li>
								<li>
									<strong>1일</strong>
									<span class="dot">:</span>
									<span class="txt" id="itm10021"></span>
								</li>
							</ul>
						</div>
					</li>
					<li>
						<div class="bx">
							<i><img src="/img/ggportal/desktop/content/ico_oneDayList_8.png" alt="" /></i>
							<strong class="tit">전출</strong>
							<ul>
								<li>
									<strong>전출</strong>
									<span class="dot">:</span>
									<span class="txt" id="itm10023"></span>
								</li>
								<li>
									<strong>1일</strong>
									<span class="dot">:</span>
									<span class="txt" id="itm10024"></span>
								</li>
							</ul>
						</div>
					</li>
					<li>
						<div class="bx">
							<i><img src="/img/ggportal/desktop/content/ico_oneDayList_9.png" alt="" /></i>
							<strong class="tit">토지거래</strong>
							<ul>
								<li>
									<strong>필지수</strong>
									<span class="dot">:</span>
									<span class="txt" id="itm10026"></span>
								</li>
								<li>
									<strong>1일</strong>
									<span class="dot">:</span>
									<span class="txt" id="itm10027"></span>
								</li>
							</ul>
						</div>
					</li>
					<li>
						<div class="bx">
							<i><img src="/img/ggportal/desktop/content/ico_oneDayList_10.png" alt="" /></i>
							<strong class="tit">강수량</strong>
							<ul>
								<li>
									<strong>강수량</strong>
									<span class="dot">:</span>
									<span class="txt" id="itm10029"></span>
								</li>
								<li>
									<strong>1일</strong>
									<span class="dot">:</span>
									<span class="txt" id="itm10030"></span>
								</li>
							</ul>
						</div>
					</li>
					<li>
						<div class="bx">
							<i><img src="/img/ggportal/desktop/content/ico_oneDayList_11.png" alt="" /></i>
							<strong class="tit">석유류소비</strong>
							<ul>
								<li>
									<strong>사용량</strong>
									<span class="dot">:</span>
									<span class="txt" id="itm10032"></span>
								</li>
								<li>
									<strong>1일</strong>
									<span class="dot">:</span>
									<span class="txt" id="itm10033"></span>
								</li>
							</ul>
						</div>
					</li>
					<li>
						<div class="bx">
							<i><img src="/img/ggportal/desktop/content/ico_oneDayList_12.png" alt="" /></i>
							<strong class="tit">사업체수</strong>
							<ul>
								<li>
									<strong>사업체수</strong>
									<span class="dot">:</span>
									<span class="txt" id="itm10035"></span>
								</li>
								<li>
									<strong>종사자수</strong>
									<span class="dot">:</span>
									<span class="txt" id="itm10036"></span>
								</li>
							</ul>
						</div>
					</li>
					<li>
						<div class="bx">
							<i><img src="/img/ggportal/desktop/content/ico_oneDayList_13.png" alt="" /></i>
							<strong class="tit">민원처리</strong>
							<ul>
								<li>
									<strong>민원처리</strong>
									<span class="dot">:</span>
									<span class="txt" id="itm10038"></span>
								</li>
								<li>
									<strong>1일처리</strong>
									<span class="dot">:</span>
									<span class="txt" id="itm10039"></span>
								</li>
							</ul>
						</div>
					</li>
					<li>
						<div class="bx">
							<i><img src="/img/ggportal/desktop/content/ico_oneDayList_14.png" alt="" /></i>
							<strong class="tit">학교수(유치원포함)</strong>
							<ul class="line3">
								<li>
									<strong>학교수</strong>
									<span class="dot">:</span>
									<span class="txt" id="itm10041"></span>
								</li>
								<li>
									<strong>교원수</strong>
									<span class="dot">:</span>
									<span class="txt" id="itm10042"></span>
								</li>
								<li>
									<strong>학생수</strong>
									<span class="dot">:</span>
									<span class="txt" id="itm10043"></span>
								</li>
							</ul>
						</div>
					</li>
					<li>
						<div class="bx">
							<i><img src="/img/ggportal/desktop/content/ico_oneDayList_15.png" alt="" /></i>
							<strong class="tit">의료인</strong>
							<ul>
								<li>
									<strong>의료인</strong>
									<span class="dot">:</span>
									<span class="txt" id="itm10045"></span>
								</li>
								<li>
									<strong>1인당시민수</strong>
									<span class="dot">:</span>
									<span class="txt" id="itm10046"></span>
								</li>
							</ul>
						</div>
					</li>
					<li>
						<div class="bx">
							<i><img src="/img/ggportal/desktop/content/ico_oneDayList_16.png" alt="" /></i>
							<strong class="tit">119구급활동</strong>
							<ul>
								<li>
									<strong>신고건수</strong>
									<span class="dot">:</span>
									<span class="txt" id="itm10048"></span>
								</li>
								<li>
									<strong>이송건수</strong>
									<span class="dot">:</span>
									<span class="txt" id="itm10049"></span>
								</li>
							</ul>
						</div>
					</li>
					<li>
						<div class="bx">
							<i><img src="/img/ggportal/desktop/content/ico_oneDayList_17.png" alt="" /></i>
							<strong class="tit">공무원</strong>
							<ul>
								<li>
									<strong>공무원</strong>
									<span class="dot">:</span>
									<span class="txt" id="itm10051"></span>
								</li>
								<li>
									<strong>1인당시민수</strong>
									<span class="dot">:</span>
									<span class="txt" id="itm10052"></span>
								</li>
							</ul>
						</div>
					</li>
					<li>
						<div class="bx">
							<i><img src="/img/ggportal/desktop/content/ico_oneDayList_18.png" alt="" /></i>
							<strong class="tit">자원봉사</strong>
							<ul>
								<li>
									<strong>자원봉사자</strong>
									<span class="dot">:</span>
									<span class="txt" id="itm10054"></span>
								</li>
								<li>
									<strong>1일봉사자</strong>
									<span class="dot">:</span>
									<span class="txt" id="itm10055"></span>
								</li>
							</ul>
						</div>
					</li>
					<li>
						<div class="bx">
							<i><img src="/img/ggportal/desktop/content/ico_oneDayList_19.png" alt="" /></i>
							<strong class="tit">지방세부담</strong>
							<ul>
								<li>
									<strong>부담액</strong>
									<span class="dot">:</span>
									<span class="txt" id="itm10057"></span>
								</li>
								<li>
									<strong>세대당</strong>
									<span class="dot">:</span>
									<span class="txt" id="itm10058"></span>
								</li>
							</ul>
						</div>
					</li>
					<li>
						<div class="bx">
							<i><img src="/img/ggportal/desktop/content/ico_oneDayList_20.png" alt="" /></i>
							<strong class="tit">자동차</strong>
							<ul>
								<li>
									<strong>자동차</strong>
									<span class="dot">:</span>
									<span class="txt" id="itm10060"></span>
								</li>
								<li>
									<strong>세대당</strong>
									<span class="dot">:</span>
									<span class="txt" id="itm10061"></span>
								</li>
							</ul>
						</div>
					</li>
				</ul>
			</div>

		</div>
		<!-- // content -->
	</div>
	<!-- // layout_flex -->
</div>
<!-- // layout_flex_100 -->
</div>        
<!-- // wrap_layout_flex -->

<%@ include file="/WEB-INF/jsp/ggportal/sect/footer.jsp" %>

</div>
<!-- // layout_A -->
</body>
</html>