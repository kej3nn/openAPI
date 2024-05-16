<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%-- @(#)main.jsp 1.0 2019/10/10											--%>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>

<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%-- OPEN API 메인 화면이다.												--%>
<%--																		--%>
<%-- @author JHKIM														--%>
<%-- @version 1.0 2019/10/08												--%>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<!DOCTYPE html>
<html lang="ko">
<head>
<%@ include file="/WEB-INF/jsp/portal/sect/head.jsp" %>
<style type="text/css">
	.contents-navigation-area{display:none;}
</style>
</head>
<body>
<!-- layout_A -->
<div class="layout_A layout_main">

<%@ include file="/WEB-INF/jsp/portal/sect/headerOpen.jsp" %>

	<!-- wrap_layout_flex -->
	<div class="wrap_layout_flex openapi_newmain" id="contents">
		<div class="layout_flex_100">
			<div class="openapi_main_visual">
				<div>
					<img src="/images/txt_openapi.png" alt="열린국회정보 Open API 서비스를 제공합니다. - 국회 정보공개 Open API는 국회가 보유한 다양한 정보를 보다 편리하게 활용할 수 있도록 외부에 공개한 인터페이스입니다. 열린국회정보 Open API를 이용할 경우 열린국회정보 포털 서비스의 다양한 정보를 실시간 다운로드하여 스마트폰 애플리케이션 등으로 다양하게 개발 활용할 수 있습니다.">
				</div>
			</div>
			<div class="openapi_flow">
				<ul>
					<li class="of01">
						<span>열린국회정보 <br>Open API <br>서비스 접속</span>
					</li>
					<li class="of02">
						<span>로그인</span>
					</li>
					<li class="of03">
						<span>인증키 신청</span>
					</li>
					<li class="of04">
						<span>Open API 검색 <br>및 이용방법 확인</span>
					</li>
					<li class="of05">
						<span>Open API를 이용한 <br>어플리케이션 제작</span>
					</li>
				</ul>
			</div>
			<div class="openapi_more">
				<div>
					<ul>
						<li>
							<div>
								<strong>Open API 기능 소개</strong>
								<span>열린국회정보만의 특화된<br>Open API 기능을 소개합니다.</span>
								<a href="${getContextPath }/portal/openapi/openApiIntroPage.do" class="btn_openapi_more">MORE</a>
							</div>
						</li>
						<li>
							<div>
								<strong>Open API 제공 목록</strong>
								<span>열린국회정보 서비스에서 제공하는<br>Open API 목록을 확인하실 수 있습니다.</span>
								<a href="${getContextPath }/portal/openapi/openApiNaListPage.do" class="btn_openapi_more">MORE</a>
							</div>
						</li>
					</ul>
				</div>
			</div>
			<div class="openapi_board">
				<div>
					<div class="openapi_notice">
						<h3>공지사항</h3>
						<ul>
						<c:forEach items="${noticeList }" var="item">
							<li>
								<a href="${getContextPath }/portal/bbs/noticeapi/selectBulletinPage.do?seq=${item.seq }">${item.bbsTit }</a>
								<span>${item.userDttm }</span>
							</li>
						</c:forEach>
						</ul>
						<a href="${getContextPath }/portal/bbs/noticeapi/searchBulletinPage.do" class="btn_board_more" title="공지사항 더보기">MORE</a>
					</div>
					<div class="openapi_qna">
						<h3>Q&amp;A</h3>
						<ul>
						<c:forEach items="${qnaList }" var="item">
							<li><a href="${getContextPath }/portal/bbs/qnaapi/selectBulletinPage.do?seq=${item.seq }">${item.bbsTit }</a></li>
						</c:forEach>
					</ul>
						</ul>
						<a href="${getContextPath }/portal/bbs/qnaapi/searchBulletinPage.do" class="btn_board_more" title="Q&A 더보기">MORE</a>
					</div>
				</div>
			</div>
		</div>
	</div>
    <!-- // content -->
</div>
<!-- // layout_flex -->

</div></div>        
<!-- // wrap_layout_flex -->

<%@ include file="/WEB-INF/jsp/portal/sect/footer.jsp" %>

</div>
<!-- // layout_A -->
</body>
</html>