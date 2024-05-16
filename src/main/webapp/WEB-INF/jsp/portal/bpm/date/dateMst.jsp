<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%-- 의정활동별 공개 - 날짜별 의정활동 공개
<%-- 
<%-- @author JHKIM
<%-- @version 1.0 2019/11/05
<%--
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<!DOCTYPE html>
<html lang="ko">
<head>
<%@ include file="/WEB-INF/jsp/portal/sect/head.jsp" %>
<c:set var="leftBpmDate" value="Y"></c:set>
</head>
<body>

<!-- header -->
<%@ include file="/WEB-INF/jsp/portal/sect/header.jsp" %>
<!-- //header -->

<!-- wrapper -->
<div class="wrapper" id="wrapper">

<!-- container -->
<section>
	<div class="container active_left" id="container">
				
	<!-- LEFT -->
	<%@ include file="/WEB-INF/jsp/portal/bpm/lnb.jsp" %>
	<!-- //LEFT -->
	
    <!-- content -->
    <article>
		<div class="contents" id="contents">
			<div class="contents-title-wrapper">
				<h3 class=""><c:out value="${requestScope.menu.lvl2MenuPath}" /><span class="arrow"></span></h3>
	        </div>
			<div class="layout_flex_100">
				
				<!-- RIGHT -->
				<div class="assemblyman_content pr0">
				
					<div class="assemblyman_active">
						<!-- 
						<div class="tab_B mt30" id="tab-btn-sect">
							<a href="javascript:;" class="on">본회의 일정</a>
							<a href="javascript:;">본회의 안건처리</a>
							<a href="javascript:;">본회의 회의록</a>
						</div> -->
						
						<div id="tab-cont-sect">
							<form id="dateForm" method="post">
								<input type="hidden" name="page" value="${param.page}" title="페이지번호">
								<input type="hidden" name="rows" value="10" title="행번호">
								<input type="hidden" name="meettingYM" value="" title="일정년월">
								<input type="hidden" name="meettingYmd" value="" title="일정년월일">
								<input type="hidden" name="gubunId" value="DA" title="구분코드">
								<input type="hidden" name="excelNm" value="" title="엑셀다운로드 명">
								
								<div class="date_play_open">
										<div class="theme_select_box layout_auto active_top">
											<table>
									            <caption>날짜별 의정활동공개 : 의안명(국정감사명), 일자, 소관위원회, 단계, 처리상태</caption>
									            <tbody>
									            <tr>
									                <th scope="row">단계</th>
									                <td><input type="text" title="단계" name="stage"></td>
									                <th scope="row">처리상태</th>
									                <td><input type="text" title="처리상태" name="actStatus"></td>
									            </tr>
									            <tr>
									                <th scope="row">일자</th>
									                <td>
									                	<ul>
									                		<li>
											                	<span class="ipt_calendar">
															    	<input type="text" name="frDt" title="시작일자(입력예:YYYY-MM-DD)">
															    	<i>날짜입력 형식 : 2019-12-25</i>
															    </span>
													    	</li>
													    	<li>
															    <span class="ipt_calendar">
															    	<input type="text" name="toDt" title="종료일자(입력예:YYYY-MM-DD)">
															    	<i>날짜입력 형식 : 2019-12-25</i>
															    </span>
															</li>
													    </ul>
									                </td>
									                <th scope="row">소관위원회</th>
									                <td><input type="text" title="소관위원회" name="committee"></td>
									            </tr>
									            <tr>
									                <th scope="row">의안명(국정감사명)</th>
									                <td colspan="3" class="col3"><input type="text" title="의안명(국정감사명)" name="billNm"></td>
									            </tr>
									            </tbody>
									        </table>		
											
											<ul>
												<li><a href="javascript:;" class="btn_inquiries" id="btnSch">조회</a></li>
												<li><a href="javascript:;" class="btn_filedown" id="btnDownload">다운로드</a></li>
											</ul>
										</div>		

										<!-- <div class="themeCscrollx hline"> -->
										<div class="themeBscrollx assemblyOnly">
											<table>
											<caption>날짜별 의정활동공개 : 번호, 일자, 의안구분, 단계, 세부단계, 의안명(국정감사명), 소관위원회명, 처리상태</caption>
											<colgroup>
											<col style="width:8%;">
											<col style="width:12%;">
											<col style="width:14%;">
											<col style="width:10%">
											<col style="width:10%;">
											<col style="width:;">
											<col style="width:10%;">
											<col style="width:10%;">
											</colgroup>
											<thead>
												<tr>
													<th scope="row">번호</th>
													<th scope="row">일자</th>
													<th scope="row">의안구분</th>
													<th scope="row">단계</th>
													<th scope="row">세부단계</th>
													<th scope="row">의안명(국정감사명)</th>
													<th scope="row">소관위원회명</th>
													<th scope="row">처리상태</th>
												</tr>
											</thead>
											<tbody id="date-result-sect">
												<!-- <tr>
													<td>2019-09-30</td>
													<td>법률안심사</td>
													<td>법사위 체계자구심사</td>
													<td class="left">국민체육진흥법 일부개정법률안(김영주의원 등 10인)</td>
													<td>전체회의</td>
													<td>문화체육관광위원회</td>
													<td>정부이송</td>
												</tr> -->
											</tbody>
											</table>
										</div>																	
										<div id="date-pager-sect"></div>
									<!-- </div> -->						
								</div>								
							</form>
						</div>
					</div>	
					
				</div>
				<!-- //RIGHT (content) -->
			</div>
		</div>
	</article>
	<!-- //contents  -->
	
	</div>
</section>
<!-- //container -->
</div>
	
<!-- footer -->
<%@ include file="/WEB-INF/jsp/portal/sect/footer.jsp" %>
<!-- //footer -->	
	
<script type="text/javascript" src="<c:url value="/js/portal/bpm/date/dateMst.js" />"></script>
</body>
</html>