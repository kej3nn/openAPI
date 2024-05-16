<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>

<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%-- @(#)docInfPage.jsp 1.0 2019/08/19 	                                  --%>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>

<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%-- 문서관리 파일 서비스 조회 화면이다.					                    --%>
<%--                                                                        --%>
<%-- @author JHKIM                                                         --%>
<%-- @version 1.0 2019/08/20                                                --%>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<!DOCTYPE html>
<html lang="ko">
<head>
<!-- head include -->
<%@ include file="/WEB-INF/jsp/portal/sect/head.jsp" %>
<script type="text/javascript" src="<c:url value="/js/portal/doc/service/selectFile.js" />"></script>
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
									<!--<div class="toplevel_tab">
										<ul>
											<li><a href="/portal/infs/cont/infsContPage.do">정보공개 콘텐츠</a></li>
											<li><a href="javascript:;" class="on">정보공개 목록</a></li>
										</ul>
									</div> -->
									<!-- //top level TAB -->
									
									<!-- 목록 헤더 -->
									<%@ include file="/WEB-INF/jsp/portal/doc/sect/header.jsp" %>
							        <!-- //목록 헤더 -->
							        
							        <!-- meta -->
							        <%@ include file="/WEB-INF/jsp/portal/doc/sect/meta.jsp" %>
							        <!-- //meta -->
							        
							        <!-- tab -->
							        <div class="tab_A">
							        	<a href="javascript:;" class="service-select-tab on">파일</a>
							        </div>
							        <!-- //tab -->
							        
							        <!-- tab content -->
									<section class="tab_section">
										<h4 class="hide">파일</h4>
										<div class="tab_content">
											<div class="themeD">
												<strong class="themeHeader">첨부 문서</strong>
												<ul class="select_board">
									            	<li>
									            		<span class="hd_no">No</span>         	
										            	<span class="hd_viewFileNm">제목</span>           	
										            	<span class="hd_ftCrDttm">파일사이즈</span>            	
										            	<span class="hd_fileSize">다운로드</span>
										            	<span class="hd_dowload">미리보기</span>
										            </li>            	
									            </ul>
									            <ul id="file-data-list" class="list_A">
									            </ul>
											</div>
											<div class="btnArea right">
												<c:choose>
										        <c:when test="${isInfsPop eq 'Y' }">
										        	<a href="#" class="btn_A" onclick="javascript: window.close();">목록</a>
										        </c:when>
										        <c:otherwise>
										        	<a href="javascript:;" class="btn_list">목록</a>
										        </c:otherwise>
										        </c:choose>
											</div>
										</div>
										<!-- 
										<ul class="select_board">
							            	<li>
							            		<span class="hd_no">No</span>         	
								            	<span class="hd_viewFileNm">제목</span>           	
								            	<span class="hd_fileSize">사이즈</span>            	
								            	<span class="hd_download">다운로드</span>
								            </li>            	
							            </ul>
							            <ul id="file-data-list" class="list_A">
							            <li class="noData">해당 자료가 없습니다.</li>
							            </ul>
										 -->
										
										<!-- 추천 데이터 셋 -->
										<!-- 숨김처리
										<div class="recommendDataset">
											<dl>
												<dt>연관 데이터셋</dt>
												<dd>
													<div class="dataSet">
														<ul class="dataSetSlider bxslider">
					
														</ul>
														<div class="btn_slide">
															<a href="#none" class="prev" id="dataset_prev" title="이전 갤러리 이동">이전</a>
															<a href="#none" class="next" id="dataset_next" title="다음 갤러리 이동">다음</a>
														</div>
													</div>
												</dd>
											</dl>
										</div> -->
										<!-- // 추천 데이터 셋 -->
										
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


 <!-- searchForm -->
<%@ include file="/WEB-INF/jsp/portal/doc/sect/searchForm.jsp" %>
<!-- //searchForm -->

<!-- footer -->
<%@ include file="/WEB-INF/jsp/portal/sect/footer.jsp" %>
<!-- //footer -->
 
</body>
</html>