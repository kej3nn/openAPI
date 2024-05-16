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
	/* location 정보 제거 */
	.contents-navigation-area{display:none;}
</style>
</head>
<body>
<!-- layout_A -->
<div class="layout_A layout_main">

<%@ include file="/WEB-INF/jsp/portal/sect/header.jsp" %>

	<!-- wrap_layout_flex -->
	<div class="wrap_layout_flex" id="contents">
		<div class="layout_flex_100 flex_main">
			
			<%@ include file="/WEB-INF/jsp/portal/mainPop.jsp" %>
			<c:if test="${not empty textAPopup }">
				<c:forEach var="popup" items="${textAPopup }">
					<script type="text/javascript">
						window.open("/portal/main/mainTextPopup.do?homeTagCd=${popup.homeTagCd}&homeSeq=${popup.homeSeq}", "_blank", 'width=400, height=500, location=no, directories=no, resizable=no, status=no, toolbar=no, menubar=no, scrollbars=no')
					</script>
				</c:forEach>
			</c:if>
			
			<c:if test="${not empty textBPopup }">
				<c:forEach var="popup" items="${textBPopup }">
					<script type="text/javascript">
					window.open("/portal/main/mainTextPopup.do?homeTagCd=${popup.homeTagCd}&homeSeq=${popup.homeSeq}", "_blank", 'width=400, height=500, location=no, directories=no, resizable=no, status=no, toolbar=no, menubar=no, scrollbars=no')
					</script>
				</c:forEach>
			</c:if>

			<!-- visual & search -->
			<div class="visual_search">
				<div>
					<div class="visual_slogan">
						<strong>국회를 열다, <br>정보를 나누다.</strong>
						<p>
							"열린국회정보"는 굳게 닫혀있던 문을 활짝 열어,<br>
							국회의 모든 정보를 국민 여러분과 나누겠습니다.
						</p>
						<!-- 통합검색 -->
						<form id="sf1Form" method="post" action="/portal/search/searchPage.do">
							<input type="hidden" name="collection" value="ALL" title="collection">
							<div class="main_search">
								<input type="text" name="query" title="검색어 입력">
								<button type="button" id="btnSf1Search">검색</button>
							</div>
						</form>
						<!-- // 통합검색 -->
						<!--<div class="main_search_recent">
							<strong>인기</strong>
							<ul id="main_search_recent_list"></ul>
						</div>-->
					</div>
					<a href="javascript: gfn_showMindmap('trdMindmap');" class="btn_mindmap" id="trdMindmap">정보공개 마인드맵 바로가기</a>
				</div>
			</div>
			<!-- //visual & search -->
			
			
			<!-- main content -->
			<div class="main_content">
			
				<!-- main circle menu -->
				<div class="main_circle_menu">
					<ul>
						<li class="mcm01"><a href="<c:url value="/portal/assm/search/memberSchPage.do"/>">국회의원</a></li>
						<li class="mcm04"><a href="<c:url value="/portal/bpm/prc/prcMstPage.do"/>">의정활동별<em>공개</em></a></li>
						<li class="mcm02"><a href="<c:url value="/portal/infs/cont/infsContPage.do?cateId=NA20000"/>">주제별 공개</a></li>
						<li class="mcm05"><a href="<c:url value="/portal/nadata/catalog/naDataCommPage.do"/>">보고서·발간물</a></li>
						<li class="mcm03"><a href="<c:url value="/portal/infs/cont/infsContPage.do?cateId=NA30000&infsId=IQ60021753Q12716"/>">지원조직별<em>공개</em></a></li>
					</ul>
				</div>
				<!-- //main circle menu -->
				
				<div class="main_common">
				
					<!-- 국회일정 -->
					<div class="mcom01">
						<h4 class="on">
							<a href="javascript:;">국회일정</a>
						</h4>
						<div>
						<form id="schdForm" method="post">
						<input type="hidden" name="meettingYM" value="" title="년월">
						<input type="hidden" name="meettingYmd" value="" title="년월일">
							<div class="mcom_calendar">
								<div class="assembly_calendar_year">
									<strong id="calendarYM"></strong>
									<ul>
										<li><a href="javascript:;" id="btnCalendarPrev">이전</a></li>
										<li><a href="javascript:;" id="btnCalendarNext">다음</a></li>
									</ul>
								</div>
								<div class="assembly_calendar">
									<table id="calendar">
									<caption>국회일정 달력 : 일, 월, 화, 수, 목, 금, 토 제공</caption>
									<thead>
										<tr>
											<th class="sunday">일</th>
											<th>월</th>
											<th>화</th>
											<th>수</th>
											<th>목</th>
											<th>금</th>
											<th class="saturday">토</th>
										</tr>
									</thead>
									<tbody></tbody>
									</table>
								</div>
								<div class="assembly_calendar_icon">
									<ul>
										<li>
											<em class="icon_assembly_cal01">본</em>
											<span>본회의</span>
										</li>
										<li>
											<em class="icon_assembly_cal02">위</em>
											<span>위원회</span>
										</li>
										<li>
											<em class="icon_assembly_cal03">의</em>
											<span>의장단</span>
										</li>
										<li>
											<em class="icon_assembly_cal04">세</em>
											<span>세미나</span>
										</li>
										<li>
											<em class="icon_assembly_cal05">행</em>
											<span>국회행사</span>
										</li>
									</ul>
								</div>
							</div> 
							
							<div class="m_inner">
								<div class="tab_B m_none mt0 w109x" id="schd-tab-btn">
									<a href="javascript:;" class="on" title="선택됨">전체</a>
									<a href="javascript:;">본회의</a>
									<a href="javascript:;">위원회</a>
									<a href="javascript:;">의장단</a>
									<a href="javascript:;">세미나</a>
									<a href="javascript:;">국회행사</a>
								</div>
								
								<!-- 모바일 셀렉트박스 처리  11.11 추가됨 -->
								<select id="mb-schd-select" class="yselect pc_none" title="국회일정 선택">
					                <option value="">전체</option>
					                <option value="">본회의</option>
					                <option value="">위원회</option>
					                <option value="">의장단</option>
						            <option value="">세미나</option>
						            <option value="">국회행사</option>
						        </select>
								
								
								<!-- 국회일정 - 전체 -->
								<div>
									<h5 class="blind">전체</h5>
									<div class="main_themeA assemblyOnly h318">
										<table>
										<caption>국회일정 전체 : 구분, 제목, 일시, 생중계 제공</caption>
										<colgroup class="m_none">
										<col style="width:160px;">
										<col style="">
										<col style="width:140px;">
										<col style="width:70px;">
										</colgroup>
										<thead>
											<tr>
												<th scope="col">구분</th>
												<th scope="col">제목</th>
												<th scope="col">일시</th>
												<th scope="col">생중계</th>
											</tr>
										</thead>
										<tbody id="assm-all-sect">
										</tbody>
										</table>	
									</div>
								</div>
								<!-- //국회일정 - 전체 -->
								
								<!-- 국회일정 - 본회의 -->
								<div>
									<div class="main_themeA assemblyOnly h318" style="display: none;">
										<table>
										<caption>국회일정 본회의 : 회기, 차수, 제목, 일시, 생중계 제공</caption>
										<colgroup class="m_none">
										<col style="width:160px;">
										<col style="width:70px;">
										<col style="">
										<col style="width:160px;">
										<col style="width:60px;">
										</colgroup>
										<thead>
											<tr>
												<th scope="col">회기</th>
												<th scope="col">차수</th>
												<th scope="col">제목</th>
												<th scope="col">일시</th>
												<th scope="col">생중계</th>
											</tr>
										</thead>
										<tbody id="assm-bon-sect"></tbody>
										</table>
									</div>
								</div>
								<!-- //국회일정 - 본회의 -->
								
								<!-- 국회일정 - 위원회 -->
								<div>
									<div class="main_themeA assemblyOnly h318" style="display: none;">
										<table>
										<caption>국회일정 위원회 : 위원회, 차수, 제목, 일시, 생중계 제공</caption>
										<colgroup class="m_none">
										<col style="width:160px;">
										<col style="width:70px;">
										<col style="">
										<col style="width:160px;">
										<col style="width:60px;">
										</colgroup>
										<thead>
											<tr>
												<th scope="col">위원회</th>
												<th scope="col">차수</th>
												<th scope="col">제목</th>
												<th scope="col">일시</th>
												<th scope="col">생중계</th>
											</tr>
										</thead>
										<tbody id="assm-wi-sect"></tbody>
										</table>
									</div>
								</div>
								<!-- //국회일정 - 위원회 -->
								
								<!-- 국회일정 - 의장단 -->
								<div>
									<div class="main_themeA assemblyOnly h318" style="display: none;">
										<table>
										<caption>국회일정 의장단 : 구분, 일시, 제목 제공</caption>
										<colgroup class="m_none">
										<col style="width:120px;">
										<col style="">
										<col style="width:160px;">
										</colgroup>
										<thead>
											<tr>
												<th scope="col">구분</th>
												<th scope="col">제목</th>
												<th scope="col">일시</th>
											</tr>
										</thead>
										<tbody id="assm-ui-sect"></tbody>
										</table>
									</div>
								</div>
								<!-- //국회일정 - 의장단 -->
								
								<!-- 국회일정 - 세미나 -->
								<div>
									<div class="main_themeA assemblyOnly h318" style="display: none;">
										<table>
										<caption>국회일정 세미나 : 제목, 일시 제공</caption>
										<colgroup class="m_none">
										<col style="">
										<col style="width:160px;">
										</colgroup>
										<thead>
											<tr>
												<th scope="col">제목</th>
												<th scope="col">일시</th>
											</tr>
										</thead>
										<tbody id="assm-semina-sect"></tbody>
										</table>
									</div>
								</div>
								<!-- //국회일정 - 세미나 -->
								
								<!-- 국회일정 - 국회행사 -->
								<div>
									<div class="main_themeA h318" style="display: none;">
										<table>
										<caption>국회일정 국회행사 : 제목, 일시 제공</caption>
										<colgroup class="m_none">
										<col style="">
										<col style="width:160px;">
										</colgroup>
										<thead>
											<tr>
												<th scope="col">제목</th>
												<th scope="col">일시</th>
											</tr>
										</thead>
										<tbody id="assm-hangsa-sect"></tbody>
										</table>
									</div>
								</div>
								<!-- //국회일정 - 국회행사 -->
							
							</div>

							<!-- <a href="#" class="btn_main_more">더보기</a> -->
						</form>
						</div>
					</div>
					<!-- //국회일정 -->
				
					<!-- 국회생중계 -->
					<div class="mcom07">
						<h4><a href="javascript:;">국회생중계</a></h4>
						<div>
							<!-- <h5>국회생중계</h5> -->
							<div class="m_inner">
								<div class="assembly_live">
									<div class="assembly_live_txt">
										<div class="assembly_live_speak">
											<span id="live_speak_desc"></span>
											<!-- 
											<a href="http://assembly.webcast.go.kr" target="_blank">더보기</a>
											-->
										</div>
										<div class="assembly_live_tv">
											<div class="assembly_live_date">
												<span>오늘의 생중계</span>
												<strong></strong>
											</div>
											<div class="assembly_live_confer">
												<strong id="live_confer_no"></strong>
												<div>
													<span id="live_confer_subj"></span>
													<em id="live_confer_time"></em>
												</div>
												<div class="assembly_live_box">
													<ul class="assembly_live_box_ul">
													<c:forEach var="data" items="${liveList }" varStatus="status">
														<c:if test="${status.index == 0 }"><li class="on" id="live_li_${data.xBill }"></c:if>
														<c:if test="${status.index != 0 }"><li id="live_li_${data.xBill }"></c:if>
															<input type="hidden" id="live_subj_${data.xBill }" value="${data.xSubj }" title="라이브" >
															<a href="javascript:;" onclick="fnLiveSubjChange('${data.xBill }')">${data.xName }</a>
															<c:if test="${data.xStat eq '1' }">
																<span class="icon_live"><a href="${data.linkUrl }" target="_blank" title="새창열림_국회인터넷의사중계시스템">LIVE</a></span>
															</c:if>
														</li>
													</c:forEach>
													</ul>
													<ol class="assembly_live_arrow">
														<li><a href="javascript:;" id="btnLivePrev">이전</a></li>
														<li><a href="javascript:;" id="btnLiveNext">다음</a></li>
													</ol>
												</div>
											</div>
										</div>
									</div>
									<div class="assembly_live_img">
										<a href="http://assembly.webcast.go.kr" target="_blank" title="새창열림_국회인터넷의사중계시스템"><img src="/images/img_live_bg.png" alt="LIVE 인터넷의사중계"></a>
									</div>
								</div>
							</div>							
							<a href="http://assembly.webcast.go.kr" class="btn_main_more" target="_blank">더보기</a>
						</div>
					</div>
					<!-- //국회생중계 -->
				
					<!-- 국회TV -->
					<div class="mcom08">
						<h4><a href="javascript:;">국회방송(NATV)</a></h4>
						<div>
							<h5>국회방송(NATV)</h5>
							<div class="m_inner">
								<div class="assembly_television">
									<a href="http://assembly.webcast.go.kr/natv/natv_live.asp" class="assembly_tv_img" onclick="window.open(this.href, 'popupOrAir', 'width=466,height=402').focus(); return false;" title="새창열림_NATV 생방송 서비스">
										<img src="/images/assembly_tv.png" alt="ON AIR 생방송 바로가기">
									</a>
									<div class="assembly_tv_list">
										<div class="assembly_tv_list_head">
											<span class="atv01">시간</span>
											<span class="atv02">방송프로그램</span>
											<span class="atv03">날짜</span>
										</div>
										<div class="assembly_tv_list_body">
										
											<c:forEach var="data" items="${brdPrmList }" varStatus="status">
												<a href="${data.linkUrl}" target="_blank" title="새창열림_국회방송">
													<span class="atv01">${data.formationTime}</span>
													<span class="atv02">${data.proTitle}</span>
													<span class="atv03">${data.formationDate}</span>
												</a>
											</c:forEach>
										</div>
									</div>
								</div>
							</div>							
							<a href="https://www.natv.go.kr/renew09/brd/formation/formation_lst.jsp" title="새창열림_국회방송" target="_blank" class="btn_main_more">더보기</a>
						</div>
					</div>
					<!-- //국회TV -->
					
					<!-- 국회는 지금 -->
					<div class="mcom02">
						<h4><a href="javascript:;">국회는 지금</a></h4>
						<div>
							<h5>국회는 지금</h5>
							<div class="m_inner" id="assmNow-div-sect">
							<c:forEach var="data" items="${nowList }" varStatus="status">
								<div class="assembly_now">
									<a href="${data.urlLink }" target="_blank" title="새창열림_국회뉴스ON">
										<div>
											<strong>국회소식</strong>
											<img src="${data.titleImageUrl }" alt="">
										</div>
										<dl>
											<dt>${data.vTitle }</dt>
											<dd class="assembly_now_date">${data.dataReleased }</dd>
											<dd><c:out value='${fn:substring(data.vBody.replaceAll("\\\<.*?\\\>",""),0, 200)}' escapeXml="false" />...</dd>
										</dl>
									</a>
								</div>
							</c:forEach>
							</div>
							<ul class="assemnow_arrow">
								<li class="btn_now_left"><a href="javascript:;">이전</a></li>
								<li class="btn_now_right"><a href="javascript:;">다음</a></li>
							</ul>
							<a href="https://www.naon.go.kr/assemblyNews/naon_now/list.do" target="_blank" class="btn_main_more" title="새창열림_국회뉴스ON">더보기</a>
						</div>
					</div>
					<!-- //국회는 지금 -->
					
					<!-- 국민 동의 청원 -->
					<div class="mcom03">
						<h4><a href="javascript:;">국민 동의 청원</a></h4>
						<div>
							<h5>국민 동의 청원</h5>
							<div class="m_inner">
								<div class="main_themeB">
									<table>
									<caption>국민 동의 청원 : 청원명, 청원인, 등록일, 진행상황 제공</caption>
									<colgroup>
									<col style="">
									<col style="width:70px;">
									<col style="width:120px;">
									<col style="width:110px;">
									</colgroup>
									<thead>
										<tr>
											<th scope="col">청원명</th>
											<th scope="col">청원인</th>
											<th scope="col">등록일</th>
											<th scope="col">진행상황</th>
										</tr>
									</thead>
									<tbody>
										<tr>
											<td class="left"><a href="#">교장자격증제 폐지와 교장선출보직제 도입을 위한 교육</a></td>
											<td>홍길동</td>
											<td>2019-08-07</td>
											<td><span class="icon_ongoing">진행중</span></td>
										</tr>
										<tr>
											<td class="left"><a href="#">교장자격증제 폐지와 교장선출보직제 도입을 위한 교육</a></td>
											<td>홍길동</td>
											<td>2019-08-07</td>
											<td><span class="icon_sending">위원회 회부</span></td>
										</tr>
										<tr>
											<td class="left"><a href="#">교장자격증제 폐지와 교장선출보직제 도입을 위한 교육</a></td>
											<td>홍길동</td>
											<td>2019-08-07</td>
											<td><span class="icon_sending">위원회 회부</span></td>
										</tr>
										<tr>
											<td class="left"><a href="#">교장자격증제 폐지와 교장선출보직제 도입을 위한 교육</a></td>
											<td>홍길동</td>
											<td>2019-08-07</td>
											<td><span class="icon_sending">위원회 회부</span></td>
										</tr>
									</tbody>
									</table>
								</div>
							</div>
							<a href="#" class="btn_main_more">더보기</a>
						</div>
					</div>
					<!-- //국민 동의 청원 -->
					
					<!-- 표결현황 -->
					<div class="mcom04">
						<h4><a href="javascript:;">표결현황</a></h4>
						<div>
							<h5>표결현황</h5>
							<div class="m_inner">
								<div class="main_status">
									<div>
										<ul>
										<c:forEach var="data" items="${billList }" varStatus="status">
											<li id="voteItem_${data.billId }">
												<strong>${data.procResult }</strong>
												<a href="javascript:;" onclick="javascript: selectVoteResult('${data.billId}');"><em>${data.proposeDt }</em> <span>${data.billName }</span></a>
												<input type="hidden"  class="linkurl" value="${data.linkUrl }" title="표결현황 링크">
											</li>
										</c:forEach>									
										</ul>
									</div>
									<div class="main_status_chart" id="chartVoteResult">차트</div>
								</div>
								<div class="main_status_agree" id="voteAssmMemberList">
									<strong id="voteBillName"></strong>
									<div class="main_status_agree_list">
										<div class="loading" style="display: none;">
											<div class="loading_img">
												<span>
													<img src="/images/ajax_loader.gif" alt="loading...">
												</span>
											</div>
											<div class="bg_trans"></div>
										</div>
										<div class="msal01_wrap on">
											<h5 class="msal01"><a href="javascript:;">찬성</a></h5>
											<div class="msal01_box">
												<span>찬성에 투표한 국회의원이 없습니다.</span>
												<ul id="voteAgreeList">
												</ul>
											</div>
										</div>
										<div class="msal02_wrap">
											<h5 class="msal02"><a href="javascript:;">반대</a></h5>
											<div class="msal02_box" style="display:none;">
												<span>반대에 투표한 국회의원이 없습니다.</span>
												<ul id="voteDisAgreeList">
												</ul>
											</div>
										</div>
										<div class="msal03_wrap">
											<h5 class="msal03"><a href="javascript:;">기권</a></h5>
											<div class="msal03_box" style="display:none;">
												<span>기권한 국회의원이 없습니다.</span>
												<ul id="voteAbsList">
												</ul>
											</div>
										</div>
										<a href="https://likms.assembly.go.kr/bill/FinishBill.do" class="msal_more" target="_blank" title="새창열림_의안정보시스템">더보기</a>
									</div>
									<div class="btn_msal_more">
										<a href="javascript:;">펼치기</a>
									</div>
								</div>
							</div>
							<a title="새창열림_의안정보시스템" href="https://likms.assembly.go.kr/bill/FinishBill.do"  target="_blank" class="btn_main_more">더보기</a>
						</div>
					</div>
					<!-- //표결현황 -->
					
					<!-- 입법예고 -->
					<div class="mcom05">
						<h4><a href="javascript:;">입법예고</a></h4>
						<div>
							<h5>입법예고</h5>
							<div class="m_inner">
								<div class="trailer">
									<ul>
									<!-- 
										<li>
											<a href="#">
												<div class="trailer_dday">
													<img src="/images/sample5.png" alt="샘플이미지">
												</div>
												<div class="trailer_txt">
													<strong>공공자원의 개방 및 국민 이용 활성화에 관한 법률안</strong>
													<span>행정안전위원회</span>
													<em>2019-12-12</em>
												</div>
											</a>
										</li>
										<li>
											<a href="#">
												<div class="trailer_dday">
													<img src="/images/sample5.png" alt="샘플이미지">
												</div>
												<div class="trailer_txt">
													<strong>공공자원의 개방 및 국민 이용 활성화에 관한 법률안</strong>
													<span>행정안전위원회</span>
													<em>2019-12-12</em>
												</div>
											</a>
										</li>
										<li>
											<a href="#">
												<div class="trailer_dday">
													<img src="/images/sample5.png" alt="샘플이미지">
												</div>
												<div class="trailer_txt">
													<strong>공공자원의 개방 및 국민 이용 활성화에 관한 법률안</strong>
													<span>행정안전위원회</span>
													<em>2019-12-12</em>
												</div>
											</a>
										</li>
										<li>
											<a href="#">
												<div class="trailer_dday">
													<img src="/images/sample5.png" alt="샘플이미지">
												</div>
												<div class="trailer_txt">
													<strong>공공자원의 개방 및 국민 이용 활성화에 관한 법률안</strong>
													<span>행정안전위원회</span>
													<em>2019-12-12</em>
												</div>
											</a>
										</li> -->
									
									<c:forEach var="data" items="${ibbubList }" varStatus="status">
										<li>
											<a href="${data.linkUrl }" onclick="window.open(this.href, 'ibbubpop', 'width=1024,height=768,scrollbars=1').focus(); return false;" title="새창열림">
												<div class="trailer_dday">
												<c:choose>
													<c:when test="${data.cmtId eq '9700005' }"><img src="/images/committee/${data.cmtId }.png" alt="국회운영위원회"></c:when>
													<c:when test="${data.cmtId eq '9700006' }"><img src="/images/committee/${data.cmtId }.png" alt="법제사법위원회"></c:when>
													<c:when test="${data.cmtId eq '9700008' }"><img src="/images/committee/${data.cmtId }.png" alt="정무위원회"></c:when>
													<c:when test="${data.cmtId eq '9700019' }"><img src="/images/committee/${data.cmtId }.png" alt="국방위원회"></c:when>
													<c:when test="${data.cmtId eq '9700038' }"><img src="/images/committee/${data.cmtId }.png" alt="환경노동위원회"></c:when>
													<c:when test="${data.cmtId eq '9700047' }"><img src="/images/committee/${data.cmtId }.png" alt="정보위원회"></c:when>
													<c:when test="${data.cmtId eq '9700049' }"><img src="/images/committee/${data.cmtId }.png" alt="예산결산특별위원회"></c:when>
													<c:when test="${data.cmtId eq '9700300' }"><img src="/images/committee/${data.cmtId }.png" alt="기획재정위원회"></c:when>
													<c:when test="${data.cmtId eq '9700341' }"><img src="/images/committee/${data.cmtId }.png" alt="보건복지위원회"></c:when>
													<c:when test="${data.cmtId eq '9700342' }"><img src="/images/committee/${data.cmtId }.png" alt="여성가족위원회"></c:when>
													<c:when test="${data.cmtId eq '9700407' }"><img src="/images/committee/${data.cmtId }.png" alt="국토교통위원회"></c:when>
													<c:when test="${data.cmtId eq '9700408' }"><img src="/images/committee/${data.cmtId }.png" alt="농림축산식품해양수산위원회"></c:when>
													<c:when test="${data.cmtId eq '9700409' }"><img src="/images/committee/${data.cmtId }.png" alt="외교통일위원회"></c:when>
													<c:when test="${data.cmtId eq '9700410' }"><img src="/images/committee/${data.cmtId }.png" alt="산업통상자원중소벤처기업위원회"></c:when>
													<c:when test="${data.cmtId eq '9700480' }"><img src="/images/committee/${data.cmtId }.png" alt="행정안전위원회"></c:when>
													<c:when test="${data.cmtId eq '9700512' }"><img src="/images/committee/${data.cmtId }.png" alt="교육위원회"></c:when>
													<c:when test="${data.cmtId eq '9700513' }"><img src="/images/committee/${data.cmtId }.png" alt="문화체육관광위원회"></c:when>
													<c:otherwise><img src="/images/committee/9999999.png" alt="특별위원회"></c:otherwise>
												</c:choose>	
												</div>
												<div class="trailer_txt">
													<c:choose>
													<c:when test="${fn:length(data.sj) gt 35 }">
														<strong><c:out value="${fn:substring(data.sj, 0, 32) }"></c:out> ...</strong>
													</c:when>
													<c:otherwise>
														<strong><c:out value="${data.sj }"></c:out></strong>
													</c:otherwise>
													</c:choose>
													<span>${data.cmtNm }</span>
													<em>${data.notiBgDt } ~ ${data.notiEdDt }</em>
												</div>
											</a>
										</li>
									</c:forEach>	
									</ul>
								</div>
							</div>
							<a title="새창열림_국회입법예고" href="https://pal.assembly.go.kr/main/mainView.do" target="_blank" class="btn_main_more">더보기</a>
						</div>
					</div>
					<!-- //입법예고 -->
					
					<!-- 인기 공개 정보 -->
					<div class="mcom06">
						<h4><a href="javascript:;">인기 공개 정보</a></h4>
						<div>
							<div class="popular_btn">
								<ul>
									<li class="on"><a href="javascript:;">주간</a></li>
									<li><a href="javascript:;">월간</a></li>
								</ul>
							</div>
							<h5>인기 공개 정보</h5>
							<div class="m_inner">
								<div class="popular_info">
									<!-- 
									<div class="word_cloud">
										<h6><span>인기검색어</span></h6>
										<div>
											<div id="chartWordcloud"></div>
										</div>
									</div>
									-->
									<div class="popular_info_ranking">
										<h6><span>인기공개정보</span></h6>
										<ul id="pplr-result-sect"></ul>
									</div>
									<div class="popular_info_ranking">
										<h6><span>인기공개정보</span></h6>
										<ul id="pplr-result-sect1"></ul>
									</div>
								</div>
							</div>
						</div>
					</div>				
					<!-- //인기 공개 정보 -->
					<!-- 
					<div class="main_controller">
						<ul>
							<li><a href="#" class="mcb01">이전</a></li>
							<li><a href="#" class="mcb02">다음</a></li>
							<li><a href="#" class="mcb03">시작</a></li>
							<li><a href="#" class="mcb04">정지</a></li>
						</ul>
					</div> -->
					
				</div>
				
				<div class="main_process">
				
					<!-- 의안처리현황 -->
					<div class="main_process_list">
						<div class="main_process_head">
							<h4>법률안 처리현황</h4>
							<em></em>
							<a href="https://likms.assembly.go.kr/bill/stat/statFinishBillSearch.do" target="_blank" title="새창열림_의안정보시스템" class="mph_more">더보기</a>
						</div>
						<div class="main_process_box">
							<ul>
								<li>
									<div>
										<strong>제21대 국회 발의건수</strong>
										<p>
											<span id="totReceiptCnt"></span>
										</p>
									</div>
								</li>								
								<li>
									<div>
										<strong>의원발의 건수</strong>
										<p>
											<span id="hgReceiptCnt"></span>
										</p>
									</div>
								</li>								
								<li>
									<div>
										<strong>위원장 제안 건수</strong>
										<p>
											<span id="cogReceiptCnt"></span>
										</p>
									</div>
								</li>								
								<li>
									<div>
										<strong>정부제출 건수</strong>
										<p>
											<span id="govReceiptCnt"></span>
										</p>
									</div>
								</li>								
								<li>
									<div>
										<strong>제21대 국회 처리건수</strong>
										<p>
											<span id="totFinishCnt"></span>
										</p>
									</div>
								</li>								
								<li>
									<div>
										<strong>의원발의 처리건수</strong>
										<p>
											<span id="hgFinishCnt"></span>
										</p>
									</div>
								</li>								
								<li>
									<div>
										<strong>위원장 제안 처리건수</strong>
										<p>
											<span id="cogFinishCnt"></span>
										</p>
									</div>
								</li>								
								<li>
									<div>
										<strong>정부제출 처리건수</strong>
										<p>
											<span id="govFinishCnt"></span>
										</p>
									</div>
								</li>								
							</ul>
						</div>
					</div>
					<!-- //의안처리현황 -->
					
					<!-- 정보공개청구 -->
					<div class="main_process_call">
						<strong>정보공개청구</strong>
						<span>원하시는 정보를 요청하세요</span>
						<a href="<c:url value="/portal/exposeInfo/guideOpnInfoPage.do"/>">청구하기</a>
					</div>
					<!-- //정보공개청구 -->
					
				</div>
				
				<!-- 공지사항 -->
				<div class="main_notice">
					<strong>공지사항</strong>
					<div id="notice-div-sect">
					<c:forEach var="data" items="${noticeList }">
						<div class="main_notice_link">
							<a href="/portal/bbs/notice/selectBulletinPage.do?seq=${data.seq }">${data.bbsTit }</a>
							<!-- <img src="/images/icon_new.png" alt="NEW"> -->
							<span>${data.userDttm }</span>
						</div>	
					</c:forEach>
					</div>
					<ul>
						<li class="notice_prev"><a href="javascript:;">이전</a></li>
						<li class="notice_next"><a href="javascript:;">다음</a></li>
					</ul>
				</div>
				<!-- //공지사항 -->
				<!--<div id='calendar'></div>-->
			</div>
			<!-- //main content -->
		
		</div>
	</div>
	<!-- // layout_flex -->
	
		<div id="mainPopDiv" name="mainPopDiv" style="position:fixed; top:0px; left:0px; width:100%; height: 100%; z-index:9999999999; display:none;text-align:center;">
			<%-- <div style="position:relative;top:100px;z-index:10;display:inline-block;"><img src="<c:url value="/img/ggportal/desktop/common/opentest.png"/>" alt="loading" onclick=""></div> --%>
			<div class="bgshadow"></div>
		</div>
		
	
<!-- // wrap_layout_flex -->

<%@ include file="/WEB-INF/jsp/portal/sect/footer.jsp" %>

</div>
<!-- // layout_A -->
<script type="text/javascript" src="<c:url value="/js/portal/main.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/common/highcharts/highcharts.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/common/highcharts/modules/wordcloud.js" />"></script>
</body>
</html>