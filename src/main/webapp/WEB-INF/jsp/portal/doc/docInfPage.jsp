<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>

<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%-- @(#)docInfPage.jsp 1.0 2019/08/19 	                                  --%>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>

<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%-- 문서 서비스 조회 화면이다.			 				                    --%>
<%--                                                                        --%>
<%-- @author JHKIM                                                         --%>
<%-- @version 1.0 2019/08/19                                                --%>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<!DOCTYPE html>
<html lang="ko">
<head>
<!-- head include -->
<%@ include file="/WEB-INF/jsp/portal/sect/head.jsp" %>
</head>
<body>

<!-- header -->
<%@ include file="/WEB-INF/jsp/portal/sect/header.jsp" %>
<!-- //header -->

<!-- content -->
<div>
	<form id="form">
		<!-- container -->
		<section>
			<div class="container hide-pc-lnb" id="container">
				<!-- contents  -->
				<article>
					<div class="contents" id="contents">
						<div class="contents-title-wrapper">
							<h3>정보공개<span class="arrow"></span></h3>
						</div>
						<div class="contents-area">
							<div class="wrap_layout_flex fix_page">
								<div class="layout_easySearch layout_flex_100">
									<!-- top level TAB -->
									<!-- <div class="toplevel_tab">
										<ul>
											<li><a href="/portal/infs/cont/infsContPage.do">정보공개 콘텐츠</a></li>
											<li><a href="javascript:;" class="on">정보공개 목록</a></li>
										</ul>
									</div> -->
									<!-- //top level TAB -->
									
									<!-- 목록 헤더 -->
									<div class="detail_summary buya01">
							            <div class="summary">
							                <strong class="tit">국회의원 표결 현황</strong>
							                <div class="area_grade clfix">
							                    <div class="flL">   
							                        <strong class="tit_totalGrade">총평점</strong>
							                        <img src="/images/grade_0.png" class="icon_grade service-grade-image" alt="총점 5점 중 평점 0점 아주 나쁨">
							                        <div class="make_grade">
							                            <a href="#none" class="toggle_grade service-grade-combo">
							                                <img src="/images/grade_s_1.png" alt="총점 5점 중 평점 1점 아주 나쁨">
							                                <img src="/images/toggle_open_grade.png" id="toggle_grade" alt="">
							                            </a>
							                            <ul id="view_grade" class="view_grade" style="display:none;">
							                            <li><a href="#" class="service-grade-option"><img src="/images/grade_s_1.png" alt="총점 5점 중 평점 1점 아주 나쁨"></a></li>
							                            <li><a href="#" class="service-grade-option"><img src="/images/grade_s_2.png" alt="총점 5점 중 평점 2점 나쁨"></a></li>
							                            <li><a href="#" class="service-grade-option"><img src="/images/grade_s_3.png" alt="총점 5점 중 평점 3점 보통"></a></li>
							                            <li><a href="#" class="service-grade-option"><img src="/images/grade_s_4.png" alt="총점 5점 중 평점 4점 좋음"></a></li>
							                            <li><a href="#" class="service-grade-option"><img src="/images/grade_s_5.png" alt="총점 5점 중 평점 5점 아주 좋음"></a></li>
							                            </ul>
							                        </div>
							                        <a href="#" class="btn_make_grade service-grade-button">OK</a>
												</div>
							                    <a href="#none" class="toggle_metaInfo"><strong>메타 정보 닫기</strong>
							                    <img src="/images/toggle_colse_metaInfo.png" alt=""></a>
							                    <div class="btn_sns">
								                    <a href="#" id="shareFB" title="새창열림_페이스북" class="sns_facebook">페이스북</a>
													<a href="#" id="shareTW" title="새창열림_트위터" class="sns_twitter">트위터</a>
													<a href="#" id="shareBG" title="새창열림_네이버블로그" class="sns_blog">네이버블로그</a>
													<a id="shareKS" href="#" title="새창열림_카카오스토리" class="sns_kakaostory">카카오스토리</a>
													<a id="shareKT" href="#" title="새창열림_카카오톡" class="sns_kakaotalk">카카오톡</a>
							                    </div>
											</div>
							            </div>
							        </div>
							        <!-- //목록 헤더 -->
							        
							        <!-- meta -->
							        <section id="metaInfo" class="view_metaInfo">
							      	  <h4 class="hide">메타 정보</h4>
										<table class="table_datail_A width_A">
										<caption>메타 정보 상세</caption>
										<colgroup>
											<col style="">
										</colgroup>
										<tbody>
										<tr>
										    <th scope="row">분류 체계</th>
										    <td>국회활동 &gt; 본회의</td>
										    <th scope="row">정보 개방일</th>
										    <td>2019-07-24</td>
										</tr>
										<tr>
										    <th scope="row">태그</th>
										    <td>국회활동, 본회의, 의안, 출석, 결석, 출석률, 정당별</td>
										    <th scope="row">최종 수정일자</th>
										    <td>2019-12-12</td>
										</tr>
										<tr>
										    <th scope="row">제공기관</th>
										    <td>국회 사무처</td> 
										    <th scope="row">데이터 기준일자</th>
										    <td>2019-12-12</td> 
										</tr>
										<tr>
										    <th scope="row">제공부서</th>
										    <td>의사국</td>
										    <th scope="row">갱신주기</th>
										    <td>수시</td>
										</tr>
										<tr>
											<th scope="row">원본 시스템</th>
											<td>국회 출결 시스템</td>
											<th scope="row">이용 허락 조건</th>
											<td class="img70p">
												<img src="/images/copyright01.gif" alt="공공누리-공공저작물 자유 이용허락 : 출처표시">
												<!-- 
												<img src="/images/copyright02.gif" alt="공공누리-공공저작물 자유 이용허락 : 출처표시, 상업용금지">
												<img src="/images/copyright03.gif" alt="공공누리-공공저작물 자유 이용허락 : 출처표시, 변경금지">
												<img src="/images/copyright04.gif" alt="공공누리-공공저작물 자유 이용허락 : 출처표시, 상업용금지, 변경금지">
												 -->
											</td>
										</tr>
										<tr>
										    <th scope="row">설명</th>
										    <td colspan="3">본회의 출결 현황에 대해 정보를 제공합니다.</td>
										</tr>
										</tbody>
										</table>
							        </section>
							        <!-- //meta -->
							        
							        <!-- tab -->
							        <div class="tab_A">
							            <a href="#" class="service-select-tab on">시각화</a>
							            <a href="#" class="service-select-tab">표</a>
							            <a href="#" class="service-select-tab">차트</a>
							            <a href="#" class="service-select-tab">지도</a>
							            <a href="#" class="service-select-tab">개방형데이터(API)</a>
							            <a href="#" class="service-select-tab">파일</a>
							            <a href="#" class="service-select-tab">링크</a>
							        </div>
							        <!-- //tab -->
							        
							        <!-- tab content -->
									<section class="tab_section">
										<h4 class="hide">시각화</h4>
										<div class="tab_content">
											<div class="themeD">
												<strong class="themeHeader">첨부 문서</strong>
												<table>
												<caption>첨부파일 목록</caption>
												<colgroup>
													<col style="">
													<col style="width:100px;">
												</colgroup>
												<tbody>
													<tr>
														<td>2019년 본회의 표결정보 표결정보 표결정보 표결정보 표결정보 표결정보 표결정보 표결정보</td>
														<td class="right"><a href="#" class="btn_download">다운로드</a></td>
													</tr>
													<tr>
														<td>2019년 본회의 표결정보</td>
														<td class="right"><a href="#" class="btn_download">다운로드</a></td>
													</tr>
													<tr>
														<td>2019년 본회의 표결정보</td>
														<td class="right"><a href="#" class="btn_download">다운로드</a></td>
													</tr>
												</tbody>
												</table>
											</div>
											<div class="btnArea right">
												<a href="#" class="btn_list">목록</a>
											</div>
										</div>
									</section>
							        <!-- //tab content -->
									
								</div>		
							</div>
						</div>
					</div>
				</article>
				<!-- //contents  -->
			
			</div>
		</section>
		<!-- //container -->		
	</form>
</div>
<!-- //content -->

<!-- footer -->
<%@ include file="/WEB-INF/jsp/portal/sect/footer.jsp" %>
<!-- //footer -->

<script type="text/javascript" src="<c:url value="/js/portal/infs/cont/infsCont.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/portal/infs/cont/infsContEvent.js" />"></script>
<!-- jquery tree plugin [Dynatree] -->
<link rel="stylesheet" href="<c:url value="/js/soportal/tree/skin/ui.dynatree.css" />" type="text/css">
<script type="text/javascript" src="<c:url value="/js/soportal/tree/jquery.dynatree.js" />"></script> 
</body>
</html>