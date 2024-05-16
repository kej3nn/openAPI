<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%-- 역대 국회의원 검색 화면 				                    	
<%-- 
<%-- @author JHKIM
<%-- @version 1.0 2020/09/10
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<!DOCTYPE html>
<html lang="ko">
<head>
<%@ include file="/WEB-INF/jsp/portal/sect/head.jsp" %>
<script type="text/javascript" src="<c:url value="/js/common/highcharts/highcharts.js" />"></script>
</head>
<body>
<!-- wrapper -->
<div class="wrapper" id="wrapper">
<%@ include file="/WEB-INF/jsp/portal/sect/header.jsp" %>

<!-- container -->
<section>
	<div class="container hide-pc-lnb" id="container">	
    <!-- content -->
    <article>
		<div class="contents" id="contents">
			<div class="contents-title-wrapper">
				<h3><c:out value="${requestScope.menu.lvl2MenuPath}" /><span class="arrow"></span></h3>
       		</div>
       		<div class="layout_flex_100">
	       		<div class="national_assemblyman_mobile"> 
	       			<div class="mca_header">
						<div>
							<span class="mcah01"><strong>의원명</strong></span>
							<span class="mcah02"><input type="text" title="검색어 입력" id="schMbHgNm"></span>
							<span class="mcah03"><button type="button" id="btnMbSearch">조회</button></span>
							<span class="mcah04"><button type="button" id="btnMbDtlSearch">상세조회</button></span>
						</div>
					</div>
				</div>    		
       			
       			<div class="national_assemblyman_search">
	       			<!-- left 검색 -->
	       			<div class="theme_select_box response_theme_box response_theme_layout">
	       			<form id="schform" method="post">
	       			<input type="hidden" name="statusCd" value="060001"> 
		       			<div class="response_theme_header">
			       			<h4>역대 국회의원 통합현황</h4>
			       			<a href="javascript:;" class="sheet-close" id="btnMbCateClose">닫기</a>
		       			</div>
	       				<table>
	       				<caption>대수, 이름, 정당, 지역, 성별, 연령, 당선횟수, 당선방법</caption>
	       				<colgroup>
	       				<col style="width:15%;">
	       				<col style="">
	       				<col style="width:15%;">
	       				<col style="">
	       				<col style="width:15%;">
	       				<col style="">
	       				</colgroup>
	       				<tbody>
	       					<tr>
	       						<input type="hidden" id="hdnAllCnt" value="" title="총건수">
	       						<input type="hidden" name="gubunId" value="MA" title="구분코드">
	       						<input type="hidden" name="excelNm" value="" title="엑셀 다운로드명">
	       						<th scope="row">대수</th>
	       						<td>
	       							<select id="schUnitCd" name="schUnitCd" title="대수">
	       							<option value="">전체</option>
	       							<c:forEach var="code" items="${assmHistUnitCodeList }" varStatus="status">
	       							<c:choose>
	       								<c:when test="${status.index eq 1 }">
	       									<option value="${code.unitCd }" selected="selected">${code.unitNm }</option>
	       								</c:when>
	       								<c:otherwise>
	       									<option value="${code.unitCd }">${code.unitNm }</option>
	       								</c:otherwise>
									</c:choose>
	       							</c:forEach>
	       							</select>
	       						</td>
	       						<th scope="row">이름</th>
	       						<td><input type="text" title="이름" id="schHgNm" name="schHgNm"></td>
	       						<th scope="row">성별</th>
	       						<td>
	       							<select id="schSexGbn" name="schSexGbn" title="성별">
										<option value="">전체</option>
										<c:forEach items="${sexGbnList }" var="code">
										<c:if test="${code.name eq param.name }">
											<option value="${code.code }" selected="selected">${code.name }</option>
										</c:if>
										<c:if test="${code.name ne param.name }">
											<option value="${code.code }">${code.name }</option>
										</c:if>
										</c:forEach>
									</select>
	       						</td>
	       					</tr>
	       					<tr>
	       						<th scope="row">당선횟수</th>
	       						<td>
		       						<select id="schReeleGbn" name="schReeleGbn" title="당선횟수">
										<option value="">전체</option>
										<c:forEach items="${reeleGbnList }" var="code">
										<c:if test="${code.name eq param.name }">
											<option value="${code.code }" selected="selected">${code.name }</option>
										</c:if>
										<c:if test="${code.name ne param.name }">
											<option value="${code.code }">${code.name }</option>
										</c:if>	
										</c:forEach>
									</select>
	       						</td>
	       						<th scope="row">당선방법</th>
	       						<td colspan="3" class="td_mobile_wid">
		       						<select id="schElectGbn" name="schElectGbn" title="당선방법">
										<option value="">전체</option>
										<c:forEach items="${electGbnList }" var="code">
											<option value="${code.code }">${code.name }</option>
										</c:forEach>
									</select>
	       						</td>
	       					</tr>
	       				</tbody>
	       				</table>
	       				<div class="btn_group">
		       				<ul>
		       					<li><a href="javascript:;" class="btn_inquiries" id="btnSearch">검색</a></li>
		       					<li><a href="javascript:;" class="btn_checkchart" id="btnInit">초기화</a></li>
		       					<!-- <li><a href="javascript:;" class="btn_filedown" id="btnDownload">다운로드</a></li> -->
		       				</ul>
	       				</div>
	       			</form>
	       			<div class="bgshadow_modal">&nbsp;</div>
	       			</div>
	       			<!-- //left 검색 -->
	       			
	       			<!-- right 결과 -->
	       				
	       			
	       			<div class="nassem_bottom">
	       					
	       					<!-- 
	       					<div class="area_h3 area_h3_AB deco_h3_3">
								<p>역대 국회의원 통합현황은 <span style="color:#d10000;">18대</span> 부터 정보를 제공합니다.</p>
							</div>
							<li class="ty_BB">
					         	<ul class="ty_A mq_tablet">
					          		<li>검색결과 <strong id="searchResultCnt"></strong>명</li>
								</ul>
					        </li>
		         			
		        
		       				<div class="nassem_reslut_header">
		       					<div id="result-cnt-sect">
			       					<strong id="searchResultCntText">검색결과 <em id="searchResultCnt">0</em>명</strong>
			       					<span>역대 국회의원 통합현황은 18대 부터 정보를 제공합니다.</span>
		       					</div>
		       					<div class="assem_chart" id="chartSearchResult">
		       					</div>
		       				</div>
		       				-->
	       				<!-- <div class="nassem_reslut_header">
	       					<div id="result-cnt-sect">
		       					<strong id="searchResultCntText">총 명의 의원 중 / 검색결과 <em id="searchResultCnt">0</em>명</strong>
		       					<span>조회하신 국회의원의 전체 국회의원 비중은 0% 입니다.</span>
	       					</div>
	       					<div class="assem_chart" id="chartSearchResult">
	       					</div>
	       				</div> -->
	       				
	       				<div class="nassem_reslut_view">
	       					<div>
	       						<div class="tab_B" id="tab-btn-sect">
	       							<a href="javascript:;" class="on">목록보기</a>
	       							<a href="javascript:;">사진보기</a>
	       						</div>
	       					</div>
	       				
		       				<div class="assemblyman_search_result">
		       					<strong id="searchResultCntText">검색결과 <em id="searchResultCnt">0</em>명</strong>
		       				</div>
	       					
	       					<!-- 목록보기 -->
	       					<div class="nassem_result_list">
	       					<h4 class="hide">목록보기</h4>
	       					<form id="listform" method="post">
	       						<input type="hidden" name="page" title="page" value="<c:out value="${params.page}"/>" />
								<input type="hidden" name="rows" title="rows" value="10" />
	       						<div class="nassem_top_btn">
	       							<a href="javascript:;" class="btn_filedown" id="btnDownload">다운로드</a>
	       						</div>
	       						<div class="themeB response_theme">
	       						<table>
	       						<caption>국회의원검색 목록보기 : 번호, 대수, 의원명, 정당, 소속위원회, 지역, 성별, 당선횟수, 당선방법</caption>
	       						<colgroup>
	       						<col style="width:80px;" class="m_none">
	       						<col style="width:80px;" class="m_none">
	       						<col class="p110_m70">
	       						<col class="p150_m30">
	       						<col style="width:180px;" class="m_none">
	       						<col style="width:100px;" class="m_none">
	       						<col style="width:110px;" class="m_none">
	       						<col style="width:150px;" class="m_none">
	       						</colgroup>
	       						<thead>
	       							<tr>
	       								<th scope="col">번호</th>
	       								<th scope="col">대수</th>
	       								<th scope="col">의원명</th>
	       								<th scope="col">정당</th>
	       								<th scope="col">지역</th>
	       								<th scope="col">성별</th>
	       								<th scope="col" class="m_none">당선횟수</th>
	       								<th scope="col">당선방법</th>
	       							</tr>
	       						</thead>
	       						<tbody id="list-result-sect">
	       						</tbody>
	       						</table>
	       						</div>
	       						
	       						<div id="list-sect-pager"></div>
	       					</form>
	       					</div>
	       					<!-- //목록보기 -->
	       					
	       					<!-- 사진보기 -->
	       					<div class="nassem_result_picture" style="display: none;">
	       					<h4 class="hide">사진보기</h4>
	       					<form id="picform" method="post">
	       						<input type="hidden" name="page" title="page" value="<c:out value="${params.page}"/>" />
								<input type="hidden" name="rows" title="rows" value="30" />
		       					<ul class="political_organization">
		       						<li><span class="politics101182">더불어민주당</span></li>
		       						<li><span class="politics101186">자유한국당</span></li>
		       						<li><span class="politics101192">바른미래당</span></li>
		       						<li><span class="politics101180">정의당</span></li>
		       						<li><span class="politics101191">민주평화당</span></li>
		       						<li><span class="politics101193">우리공화당</span></li>
		       						<li><span class="politics101190">민중당</span></li>
		       						<li><span class="politics101030">무소속</span></li>
		       					</ul>
		       					<div id="pic-result-sect">
	       						<ul class="nassem_result_ul"></ul>
	       						
	       						<div id="pic-sect-pager"></div>
	       						</div>
	       					</form>
	       					</div>
	       					<!-- //사진보기 -->
	       				</div>
	       			</div>
	       			<!-- //right 결과 -->
       			</div>
       		</div>
		</div>
	</article>
	<!-- //contents  -->
	
	</div>
</section>
<!-- //container -->
<%@ include file="/WEB-INF/jsp/portal/sect/footer.jsp" %>
</div>
<script type="text/javascript" src="<c:url value="/js/portal/assm/search/memberHistSch.js" />"></script>
</body>
</html>