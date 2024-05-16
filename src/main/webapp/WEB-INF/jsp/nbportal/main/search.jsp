<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%-- @(#)search.jsp 1.0 2015/06/15                                          --%>
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
<%-- 통합 검색 화면이다.                                                    --%>
<%--                                                                        --%>
<%-- @author Soft-on                                                        --%>
<%-- @version 1.0 2018/02/11                                                --%>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<!DOCTYPE html>
<html lang="ko">
<head>
<%@ include file="/WEB-INF/jsp/nbportal/include/head.jsp" %>
<script type="text/javascript" src="<c:url value="/js/nabo/main/search.js" />"></script>
</head>
<body>
<!-- wrapper -->
<div class="wrapper" id="wrapper">
<%@ include file="/WEB-INF/jsp/nbportal/include/header.jsp" %>
<%@ include file="/WEB-INF/jsp/nbportal/include/navigation.jsp" %>

	<!-- container -->
	<section>
		<div class="container hide-pc-lnb" id="container">
		
	    <!-- content -->
	    <article>
		<div class="contents" id="contents">
        	<div class="contents-title-wrapper">
	            <h3> <c:out value="${requestScope.menu.lvl1MenuPath}" /><span class="arrow"></span></h3>
        	</div>
        
	        <div class="contents-area">
			<!-- CMS 시작 -->
				<p class="word-search-result">
					<img src="<c:url value='/images/soportal/icon/icon_search04@2x.png' />" alt="검색버튼" />
						검색어 <strong style="vertical-align: top;">&quot;<c:out value="${param.searchWord}" />&quot;</strong>
						(으)로 총 <strong class="unified-count-sect" style="vertical-align: top;">0</strong>건이 검색되었습니다.
				</p>
	
		        <div class="board-area">
					<!-- 통계데이터-->  
					<div class="contents-box">
						<div class="board-top-information totalsearch clear">
							<p class="total type02">통계조회 (<strong id="stat-count-sect" class="point-color09 single-count-sect" style="vertical-align: top;">0</strong>건)</p>
		
							<div class="btns-wrapper"><a href="#" id="stat-search-button" class="btn-s03 btns-color08">더보기</a></div>
						</div>

				        <div class="board-list01">
							<table id="stat-data-table">
								<caption>통합검색 간편통계 조회에 관한 정보 제공</caption>
								<thead>
									<tr>
										<th scope="col" class="number">번호</th>
										<th scope="col" class="division">구분</th>
										<th scope="col" class="title">통계명</th>						
										<th scope="col" class="stats-type">분류</th>
									</tr>
								</thead>
								<tbody>
							        <tr>
							            <td colspan="5" >해당 자료가 없습니다.</td>
							        </tr>
						        </tbody>
			        		</table>
		        		</div>
					</div>			
					<form id="stat-link-form" name="stat-link-form" method="post"></form>	        
			        <form id="stat-search-form" name="stat-search-form" method="post">
			            <input type="hidden" name="searchVal" value="<c:out value="${param.searchWord}" default="" />" />
			        </form>
			        <!-- // 통계데이터 -->

			        <!-- 통계간행물 -->
			        <div class="contents-box">
						<div class="board-top-information totalsearch clear">
							<p class="total type02">
								통계간행물 (<strong id="compose-count-sect" class="point-color09 single-count-sect" style="vertical-align: top;">0</strong>건)
							</p>
							<div class="btns-wrapper"><a href="#" id="compose-search-button" class="btn-s03 btns-color08">더보기</a></div>
						</div>
						<div class="board-list01">
							<table id="compose-data-table" style="width: 100%">
								<caption>통계간행물 조회 정보 제공</caption>
								<thead>
									<tr>
										<th class="number" scope="col">
											번호
										</th>
										<th class="division01" scope="col">
											구분
										</th>
										<th class="title" scope="col">
											제목
										</th>
										<th class="file02" scope="col">
											다운로드
										</th>
									</tr>
								</thead>
								<tbody>
		       						<tr>
									<td colspan="4">
										해당 자료가 없습니다.
									</td>
									</tr>
								</tbody>
							</table>
						</div>
					</div>
			        <form id="compose-search-form" name="compose-search-form" method="post">
			            <input type="hidden" name="page" value="<c:out value="${param.page}" default="1" />" />
			            <input type="hidden" name="rows" value="<c:out value="${param.rows}" default="5" />" />
			            <input type="hidden" name="bbsCd" value="<c:out value="${param.bbsCd}" default="dic" />" />
			            <input type="hidden" name="listSubCd" value="<c:out value="${param.listSubCd}" default="" />" />
			            <input type="hidden" name="searchType" value="<c:out value="${param.searchType}" default="" />" />
			            <input type="hidden" name="searchWord" value="<c:out value="${param.searchWord}" default="" />" />
			            <input type="hidden" name="seq" value="<c:out value="${param.seq}" default="" />" />
			            <input type="hidden" name="noticeYn" value="<c:out value="${param.noticeYn}" default="" />" />
			        </form>			
					<!-- // 통계간행물 -->
					
			        <!-- 용어사전 -->
			        <div class="contents-box">
						<div class="board-top-information totalsearch clear">
							<p class="total type02">
								용어사전 (<strong id="dic-count-sect" class="point-color09 single-count-sect" style="vertical-align: top;">0</strong>건)
							</p>
							<div class="btns-wrapper"><a href="#" id="dic-search-button" class="btn-s03 btns-color08">더보기</a></div>
						</div>
						<div class="board-list01">
							<table id="dic-data-table" style="width: 100%">
								<caption>용어사전 조회 정보 제공</caption>
								<thead>
									<tr>
										<th class="number" scope="col">
											번호
										</th>
										<th class="title" scope="col">
											통계용어
										</th>
									</tr>
								</thead>
								<tbody>
		       						<tr>
									<td colspan="2">
										해당 자료가 없습니다.
									</td>
									</tr>
								</tbody>
							</table>
						</div>
					</div>
			        <form id="dic-search-form" name="dic-search-form" method="post">
			            <input type="hidden" name="page" value="<c:out value="${param.page}" default="1" />" />
			            <input type="hidden" name="rows" value="<c:out value="${param.rows}" default="5" />" />
			            <input type="hidden" name="bbsCd" value="<c:out value="${param.bbsCd}" default="dic" />" />
			            <input type="hidden" name="listSubCd" value="<c:out value="${param.listSubCd}" default="" />" />
			            <input type="hidden" name="searchType" value="<c:out value="${param.searchType}" default="" />" />
			            <input type="hidden" name="searchWord" value="<c:out value="${param.searchWord}" default="" />" />
			            <input type="hidden" name="seq" value="<c:out value="${param.seq}" default="" />" />
			            <input type="hidden" name="noticeYn" value="<c:out value="${param.noticeYn}" default="" />" />
			        </form>			
					<!-- // 용어사전 -->
					
					<!-- 경제재정교실 -->
			        <div class="contents-box">
						<div class="board-top-information totalsearch clear">
							<p class="total type02">
								경제/재정교실 (<strong id="school-count-sect" class="point-color09 single-count-sect" style="vertical-align: top;">0</strong>건)
							</p>
							<div class="btns-wrapper"><a href="#" id="school-search-button" class="btn-s03 btns-color08">더보기</a></div>
						</div>
						<div class="board-list01">
							<table id="school-data-table" style="width: 100%">
								<caption>용어사전 조회 정보 제공</caption>
								<thead>
									<tr>
										<th class="number" scope="col">
											번호
										</th>
										<th class="title" scope="col">
											항목
										</th>
									</tr>
								</thead>
								<tbody>
		       						<tr>
									<td colspan="2">
										해당 자료가 없습니다.
									</td>
									</tr>
								</tbody>
							</table>
						</div>
					</div>
			        <form id="school-search-form" name="school-search-form" method="post">
			            <input type="hidden" name="page" value="<c:out value="${param.page}" default="1" />" />
			            <input type="hidden" name="rows" value="<c:out value="${param.rows}" default="5" />" />
			            <input type="hidden" name="bbsCd" value="<c:out value="${param.bbsCd}" default="SCHOOL" />" />
			            <input type="hidden" name="searchType" value="<c:out value="${param.searchType}" default="" />" />
			            <input type="hidden" name="searchWord" value="<c:out value="${param.searchWord}" default="" />" />
			            <input type="hidden" name="listCd" value="<c:out value="${param.listCd}" default="" />" />
			            <input type="hidden" name="topListCd" value="<c:out value="${param.topListCd}" default="" />" />
			            <input type="hidden" name="parListCd" value="<c:out value="${param.parListCd}" default="" />" />
			            <input type="hidden" name="cnt" value="<c:out value="${param.cnt}" default="" />" />
			        </form>			
					<!-- // 경제재정교실 -->
					
					<!-- NABO분석 -->
			        <div class="contents-box">
						<div class="board-top-information totalsearch clear">
							<p class="total type02">
								국회심사연혁 (<strong id="nabo-count-sect" class="point-color09 single-count-sect" style="vertical-align: top;">0</strong>건)
							</p>
							<div class="btns-wrapper"><a href="#" id="nabo-search-button" class="btn-s03 btns-color08">더보기</a></div>
						</div>
						<div class="board-list01" id="nabo-table-sect">
							<table id="nabo-data-table" style="width: 100%">
							</table>
						</div>
					</div>
			        <form id="nabo-search-form" name="nabo-search-form" method="post">
			            <input type="hidden" name="page" value="<c:out value="${param.page}" default="1" />" />
			            <input type="hidden" name="rows" value="<c:out value="${param.rows}" default="5" />" />
			            <input type="hidden" name="seq" value="<c:out value="${param.seq}" default="" />" />
			            <input type="hidden" name="searchBbsCd" value="<c:out value="${param.searchBbsCd}" default="" />" />
			            <input type="hidden" name="searchType" value="<c:out value="${param.searchType}" default="" />" />
			            <input type="hidden" name="opiSearchWord" value="<c:out value="${param.searchWord}" default="" />" />
			        </form>			
					<!-- // NABO분석 -->

				</div>	
			</div>
			<!-- //CMS 끝 -->
		</div>
	</article>
	<!-- //contents  -->
	</div>
</section>
<!-- //container -->
<%@ include file="/WEB-INF/jsp/nbportal/include/footer.jsp" %>
</div>
<!-- //wrapper -->
</body>
</html>