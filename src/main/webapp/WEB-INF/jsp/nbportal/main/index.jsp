<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>

<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%-- @(#)main.jsp 1.0 2018/07/06                                     --%>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>

<c:forEach var="sCate" items="${scateList }" varStatus="status"> 
	<c:if test="${sCate.ditcCd eq 'SCATE.200000' }"><c:set var="sCateT200000" value = "${sCate.valueCd}"/><c:set var="sCateC200000" value = "${sCate.value2Cd}"/></c:if>
	<c:if test="${sCate.ditcCd eq 'SCATE.210000' }"><c:set var="sCateT210000" value = "${sCate.valueCd}"/><c:set var="sCateC210000" value = "${sCate.value2Cd}"/></c:if>
	<c:if test="${sCate.ditcCd eq 'SCATE.220000' }"><c:set var="sCateT220000" value = "${sCate.valueCd}"/><c:set var="sCateC220000" value = "${sCate.value2Cd}"/></c:if>
	<c:if test="${sCate.ditcCd eq 'SCATE.230000' }"><c:set var="sCateT230000" value = "${sCate.valueCd}"/><c:set var="sCateC230000" value = "${sCate.value2Cd}"/></c:if>
	<c:if test="${sCate.ditcCd eq 'SCATE.240000' }"><c:set var="sCateT240000" value = "${sCate.valueCd}"/><c:set var="sCateC240000" value = "${sCate.value2Cd}"/></c:if>
	<c:if test="${sCate.ditcCd eq 'SCATE.250000' }"><c:set var="sCateT250000" value = "${sCate.valueCd}"/><c:set var="sCateC250000" value = "${sCate.value2Cd}"/></c:if>
	<c:if test="${sCate.ditcCd eq 'SCATE.260000' }"><c:set var="sCateT260000" value = "${sCate.valueCd}"/><c:set var="sCateC260000" value = "${sCate.value2Cd}"/></c:if>
	<c:if test="${sCate.ditcCd eq 'SCATE.270000' }"><c:set var="sCateT270000" value = "${sCate.valueCd}"/><c:set var="sCateC270000" value = "${sCate.value2Cd}"/></c:if>
	<c:if test="${sCate.ditcCd eq 'SCATE.280000' }"><c:set var="sCateT280000" value = "${sCate.valueCd}"/><c:set var="sCateC280000" value = "${sCate.value2Cd}"/></c:if>
	<c:if test="${sCate.ditcCd eq 'SCATE.290000' }"><c:set var="sCateT290000" value = "${sCate.valueCd}"/><c:set var="sCateC290000" value = "${sCate.value2Cd}"/></c:if>
	<c:if test="${sCate.ditcCd eq 'SCATE.300000' }"><c:set var="sCateT300000" value = "${sCate.valueCd}"/><c:set var="sCateC300000" value = "${sCate.value2Cd}"/></c:if>
</c:forEach>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%-- 국가예산정책처 메인페이지             									--%>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>

<!DOCTYPE html>
<html lang="ko">
<head>
<%@ include file="/WEB-INF/jsp/nbportal/include/head.jsp" %>
<script type="text/javascript" src="<c:url value="/js/common/component/jquery.bxslider.min.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/common/component/jquery.bxslider-rahisified.min.js" />"></script>
</head>
<body>
<!-- wrapper -->
<div class="wrapper" id="wrapper">
<%@ include file="/WEB-INF/jsp/nbportal/include/toppopup.jsp" %>
<%@ include file="/WEB-INF/jsp/nbportal/include/header.jsp" %>
<script type="text/javascript" src="<c:url value="/js/nabo/cont/loadNationDebtClock.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/nabo/main/index.js" />"></script>
<!-- container -->
	<section >
		<div class="main-container" id="contents" tabindex="0">
		
			<!-- visual  -->
			<div class="main_visual">
				
				<!-- visual title -->
				<div class="main_slogan">
					<a href="http://www.nabo.go.kr" target="_blank" id="mainImgNabo" onkeydown="nextTab();"><img src="/images/soportal/common/logo_main.png" alt="국회예산정책처-건전한 재정,희망찬 미래"></a>
					<h3>국회예산정책처</h3>
					<span>건전한 재정, 희망찬 미래</span>
				</div>
				<!-- //visual title -->
				
				<!-- 통계정보 -->
				<div class="main_static">
					<ul class="static_list"></ul>
					
					<!-- 이전&다음&중지&실행 -->
					<div class="static_control">
						<ul>
							<li class="sc01"><a href="javascript:;">이전</a></li>
							<li class="sc02"><a href="javascript:;">다음</a></li> 
							<li class="sc03"><a href="javascript:;">중지</a></li>
							<li class="sc04" style="display: none;"><a href="javascript:;">실행</a></li> 
						</ul>
					</div>
					<!-- //이전&다음&중지&실행 -->
					
					<!-- 이전&다음 -->
					<ul class="static_list_arrow">
						<li class="list_arrow_prev"><a href="javascript:;" title="이전">이전</a>
						<li class="list_arrow_next"><a href="javascript:;" title="이후">이후</a>
					</ul>
					<!-- //이전&다음 -->
					
					<!-- 슬라이더 페이져 
					<div class="static_list_page" id="statlc_list_page">
						<ul></ul>
					</div>
					-->
					<div id="statlc_list_page" class="static_list_page2">
						<ul>
							<li><a href="javascript:;" class="icon_circle01"></a></li>
							<li><a href="javascript:;" class="icon_circle02"></a></li>
						</ul>
					</div>
					
				</div>
				<!-- //통계정보 -->
			</div>
			<!-- //visual  -->
			
			
			<!-- 통계 링크 -->
			<div class="static_link">
				<ul>
					<li class="sl01" id="sl01"><a href="${serverAddr }/portal/stat/directStatPage/${sCateT200000 }.do?sCate=${sCateC20000}">재정통계</a></li>
					<li class="sl03"><a href="${serverAddr }/portal/stat/directStatPage/${sCateT210000 }.do?sCate=${sCateC210000 }">조세통계</a></li>
					<li class="sl04"><a href="${serverAddr }/portal/stat/directStatPage/${sCateT220000 }.do?sCate=${sCateC220000 }">지방재정</a></li>
					<li class="sl05"><a href="${serverAddr }/portal/stat/directStatPage/${sCateT230000 }.do?sCate=${sCateC230000 }">공공기관<br>통계</a></li>
					<li class="sl06"><a href="${serverAddr }/portal/stat/directStatPage/${sCateT240000 }.do?sCate=${sCateC240000 }">경제통계</a></li>
					<li class="sl07"><a href="${serverAddr }/portal/stat/directStatPage/${sCateT250000 }.do?sCate=${sCateC250000 }">인구ㆍ사회통계</a></li>
					<li class="sl02"><a href="${serverAddr }/portal/stat/directStatPage/${sCateT300000 }.do?sCate=${sCateC300000 }">위원회별<br>통계</a></li>
					<li class="sl08"><a href="${serverAddr }/portal/stat/directStatPage/${sCateT260000 }.do?sCate=${sCateC260000 }">북한통계</a></li>
					<li class="sl09"><a href="${serverAddr }/portal/stat/directStatPage/${sCateT270000 }.do?sCate=${sCateC270000 }">국제통계</a></li>
				</ul>
			</div>
			<!-- //통계 링크 -->
			
			
			<div class="static_event">
			
				<!-- 국가채무시계 -->
				<div class="debt_clock">
					<div class="debt_title">
						<h4>국가 채무시계</h4>
					</div>
					<div class="debt_country">
						<h5>국가채무</h5>
						<span id="nowtime"></span>
						<div class="debt_number">
							<div>
								<div>
									<span id="d1"></span>
									<span id="d2"></span>
									<span id="d3"></span>
									<span id="d4"></span>
									<span class="unit">조</span>
								</div>
								<div>
									<span id="d5"></span>
									<span id="d6"></span>
									<span id="d7"></span>
									<span id="d8"></span>
									<span class="unit">억</span>
								</div>
							</div>
							<div class="debt_fcy">
								<div>
									<span id="d9"></span>
									<span id="d10"></span>
									<span id="d11"></span>
									<span id="d12"></span>
									<span class="unit">만</span>
								</div>
								<div>
									<span id="d13"></span>
									<span id="d14"></span>
									<span id="d15"></span>
									<span id="d16"></span>
									<span class="unit">원</span>
								</div>
							</div>
						</div>
					</div>
					<div class="debt_nation">
						<h5>국민 1인당 국가채무</h5>
						<div class="debt_number2">
							<div>
								<span id="p1" class="num"></span>
								<span id="p2" class="num"></span>
								<span id="p3" class="num"></span>
								<span id="p4" class="num"></span>
								<span class="unit">만</span>
							</div>
							<div>
								<span id="p5" class="num"></span>
								<span id="p6" class="num"></span>
								<span id="p7" class="num"></span>
								<span id="p8" class="num"></span>
								<span class="unit">원</span>
							</div>
						</div>
					</div>
					<a href="javascript:;" class="debt_more" title="국가채무시계 더보기">더보기</a>
				</div>
				<!-- //국가채무시계 -->
				
				<!-- 데이터로 보는 재정이슈 -->
				<div class="data_issue">
					<div>
						<h4>데이터로 보는 재정이슈</h4>
						<ul class="di_list" id="dataIssueList">
						<c:forEach var="issue" items="${issueList }">
							<li><a href="${serverAddr }${issue.linkUrl }"><img src="/portal/main/selectAttachIssueFile.do?seqceNo=${issue.seqceNo }" alt="${issue.srvTit }"></a></li>
						</c:forEach>
						</ul>
						<ul class="data_issue_control">
							<li><a href="javascript:;" class="dic01">이전</a></li>
							<li><a href="javascript:;" class="dic02">정지</a></li>
							<li style="display: none;"><a href="javascript:;" class="dic03">재생</a></li>
							<li><a href="javascript:;" class="dic04">다음</a></li>
						</ul>
						<a href="/portal/nabo/financeIssuePage.do" class="btn_more4">더보기</a>
					</div>
				</div>
				<!-- //데이터로 보는 재정이슈 -->
				
				<!-- 금주의 통계 -->
				<div class="today_static">
					<c:if test="${not empty thisWeek }">
						<img src="/portal/main/selectAttachThisWeekFile.do?seqceNo=${thisWeek.seqceNo }" alt="${thisWeek.srvTit }" onerror="setDefaultThisWeekImage(this)">
						<a href="${serverAddr }${thisWeek.linkUrl }" title="금주의 통계 더보기" class="today_more">더보기</a>
					</c:if>
				</div>
				<!-- //금주의 통계 -->
			</div>
			
			<div class="main_board">
			
				<div class="board_inner">
					<!-- 간략조회, 상세분석, 복수통계분석 배너 -->
					<div class="static_banner">
						<ul>
							<li class="sb01">
								<a href="${serverAddr }/portal/stat/directStatPage.do">
									<strong>간략조회</strong>
									<span>간단하게 통계지표를 조회할 수 있습니다.</span>
								</a>
							</li>
							<li class="sb02">
								<a href="${serverAddr }/portal/stat/easyStatPage.do">
									<strong>상세분석</strong>
									<span>증감분석 등 심도있는 분석기능을 제공합니다.</span>
								</a>
							</li>
							<li class="sb03">
								<a href="${serverAddr }/portal/stat/multiStatPage.do">
									<strong>복수통계분석</strong>
									<span>다양한 통계지표를 교차분석 할 수 있습니다.</span>
								</a>
							</li>
						</ul>
					</div>
					<!-- //통계조회, 통계분석, 복수통계분석 배너 -->
					
					<!-- 인기통계&최근통계 -->
					<div class="static_board">
						<h5 class="on"><a href="javascript:;">인기통계</a></h5>
						<div id="hitStat-sect">
							<ul id="hitStatList">
							<c:forEach var="hit" items="${hitList }" varStatus="status">
								<c:if test="${status.index lt 5 }">
									<li>
									<c:choose>
										<c:when test="${hit.ctsSrvCd eq 'N' }">
											<a href="${serverAddr }/portal/stat/easyStatPage/${hit.statblId }.do">
										</c:when>
										<c:otherwise>
											<a href="${serverAddr }/portal/stat/directStatPage/${hit.statblId }.do">
										</c:otherwise>
									</c:choose>
											<em>${status.index + 1 }</em>
											<span>${hit.statblNm }</span>
										</a>
									</li>
								</c:if>
							</c:forEach>
							</ul>
							<a href="${serverAddr }/portal/theme/hitStatPage.do" class="board_more" title="인기통계 더보기">더보기</a>
						</div>
						
						<h5 class="static_new"><a href="javascript:;">최신통계</a></h5>
						<div id="newStat-sect" style="display:none;">
							<ul id="newStatList">
							<c:forEach var="newest" items="${newList }" varStatus="status">
								<c:if test="${status.index lt 5 }">
									<li>
									<c:choose>
										<c:when test="${newest.ctsSrvCd eq 'N' }">
											<a href="${serverAddr }/portal/stat/easyStatPage/${newest.statblId }.do">
										</c:when>
										<c:otherwise>
											<a href="${serverAddr }/portal/stat/directStatPage/${newest.statblId }.do">
										</c:otherwise>
									</c:choose>
											<em>${status.index + 1 }</em>
											<span>${newest.statblNm }</span>
										</a>
									</li>
								</c:if>
							</c:forEach>
							</ul>
							<a href="${serverAddr }/portal/theme/newStatPage.do" class="board_more" title="최신통계 더보기">더보기</a>
						</div>
					</div>
					<!-- //인기통계&최근통계 -->
					
					<!-- Open API -->
					<div class="main_openapi" title="Open API - 재정경제통계를 Open API로 공유할 수 있습니다.">
						<a href="${serverAddr }/portal/openapi/openApiIntroPage.do">
							<strong>Open API</strong>
							<span>재정경제통계를 Open API로<br>공유할 수 있습니다.</span>
						</a>
					</div>
					<!-- //Open API -->
				</div>
				
				<!-- 공지사항 -->
				<div class="main_notice">
					<ul id="noticeList">
					<c:forEach var="notice" items="${noticeList }">
						<li>
							<a href="${serverAddr }/portal/bbs/notice/selectBulletinPage.do?seq=${notice.seq}">
								<em>공지</em>
								<strong>${notice.userDttm }</strong>
								<span>${notice.bbsTit }</span>
							</a>
						</li>
					</c:forEach>
					</ul>
					<ul class="notice_arrow">
						<li class="notice_prev"><a href="javascript:;">이전</a>
						<li class="notice_next"><a href="javascript:;">다음</a>
						<li class="notice_pause"><a href="javascript:;">중지</a>
						<li class="notice_play"><a href="javascript:;">재생</a>
					</ul>
				</div>
				<!-- //공지사항 -->
				
				<!-- <a href="<c:url value="/portal/openapi/openApiIntroPage.do" />"><div style="height:1389px;background:url(/images/common/bg_new_main.png) no-repeat center 0;"></div></a> -->
			</div>	
			
			<!-- banner -->
			<div class="main_banner">
				<ul class="mb_list">
				<c:forEach var="banner" items="${bannerList }">
					<li><a href="${banner.linkUrl }"><img src="/portal/main/selectAttachBannerFile.do?seqceNo=${banner.seqceNo }" alt="${banner.srvTit }"></a></li>
				</c:forEach>
				</ul>
				<ul class="mb_btn">
					<li class="mb_prev"><a href="javascript:;">이전</a></li>
					<li class="mb_next"><a href="javascript:;">다음</a></li>
				</ul>
				<div class="mb_control">
					<ul>
						<li class="mb01"><a href="javascript:;">이전</a></li>
						<li class="mb02"><a href="javascript:;">다음</a></li> 
						<li class="mb03"><a href="javascript:;">중지</a></li>
						<li class="mb04"><a href="javascript:;">실행</a></li>
					</ul>
				</div>
			</div>
			<!-- //banner -->
			
		</div>
	</section>
	<!-- //container -->
<!-- //container -->

<!-- 국가채무시계 hidden value -->
<input name="debtValue" type="hidden" id="debtValue" value="${map.debtValue}" />
<input name="debtIncrement" type="hidden" id="debtIncrement" value="${map.debtIncrement}" />
<input name="debtDate" type="hidden" id="debtDate" value="${map.debtDate}" />
<input name="population" type="hidden" id="population" value="${map.population}" />
	
<form name="excelDownload" method="post"><input type="hidden" name="selCetNum" id="selCetNum" value="1"/></form>
<iframe width=0 height=0 name="hide_frame" style="margin-top:0;border:0;display:none;" title="엑셀다운로드"></iframe>
<%@ include file="/WEB-INF/jsp/nbportal/include/footer.jsp" %>
</div>
</body>
</html>
