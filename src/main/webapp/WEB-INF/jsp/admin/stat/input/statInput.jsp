<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="egovframework.common.WiseOpenConfig"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><spring:message code='wiseopen.title' /></title>
<c:import url="/WEB-INF/jsp/inc/headinclude.jsp" />
<script type="text/javascript" src="<c:url value="/js/admin/stat/statInput.js" />"></script>
<%-- <script type="text/javascript" src="<c:url value="/js/admin/stat/statInputRandom.js" />"></script> --%>

</head>
<script language="javascript">   
</script>
</head>
<body onload="">
	<div class="wrap">
		<c:import url="/admin/admintop.do" />
		<!--##  메인  ##-->
		<div class="container">
		
			<!-- 상단 타이틀 -->
			<div class="title">
				<h2>${MENU_NM}</h2>
				<p>${MENU_URL}</p>
			</div>
			</ul>
			
			<!-- 탭 -->
			<ul class="tab">
				<li class="all_list"><a href="#">전체목록</a></li>
			</ul>
			
			<c:import  url="statInputDtl.jsp"/>
			
			<!-- 리스트 -->
			<div class="content">
				<form name="statMainForm"  method="post" action="#">
				<input type="hidden" name="valueCd" value="${param.valueCd}">
				<c:set var="statGroupTxt"><spring:message code="stat.ko.group"/></c:set>
				<input id="statGroupTxt" type="hidden" value="${statGroupTxt}">
				<table class="list01">
					<caption>통계표 데이터입력 리스트</caption>
					<colgroup>
						<col width="15%"/>
						<col width="35%"/>
						<col width="15%"/>
						<col width="35%"/>
					</colgroup>
					<tr>
						<th>분류</th>
						<td colspan="3">
							<input type="text" id="cateIds" name="cateIds" size="8" value="" readonly="readonly" />
							<input type="text" id="cateId" name="cateId" size="8" value="" readonly="readonly" style="display: none;"/>
							<input type="text" id="cateNm" name="cateNm" size="25" value=""  placeholder="선택하세요.." readonly="readonly" />
							<button type="button" class="btn01" id="cate_pop" name="cate_pop">검색</button>
							<button type="button" class="btn01" id="cate_reset" name="cate_reset">초기화</button>
						</td>
					</tr>
					<c:if test="${accCd eq 'SYS' }">
					<!-- 시스템유저만 부서선택 -->
					<tr>
						<th>담당부서</th>
						<td colspan="3">
							<input type="text" id="orgCd" name="orgCd" size="8" value="" readonly="readonly" />
							<input type="text" id="orgNm" name="orgNm" size="25" value="" placeholder="선택하세요.." readonly="readonly" />
							<button type="button" class="btn01" id="org_pop" name="org_pop">검색</button>
							<button type="button" class="btn01" id="org_reset" name="org_reset">초기화</button>
						</td>
					</tr>
					</c:if>
					<tr>
						<th>자료시점기준</th>
						<td>
							<select id="wrttime" name="wrttime" style="width: 180px;">
							</select>
						</td>
						<th>입력기간</th>
						<td>
							<input type="text" name="wrtStartYmd" value="" placeholder="입력기간 시작" size="13" />
							~
							<input type="text" name="wrtEndYmd" value="" placeholder="입력기간 종료" size="13" />
							&nbsp;&nbsp;
							<button type="button" class="btn01" id="wrtYmd_reset" name="wrtYmd_reset">초기화</button>
						</td>
					</tr>
					<tr>
						<th>입력상태</th>
						<td colspan="3">
							<!-- <div id="inputStatus-sect"></div> -->
							<input type="checkbox" name="inputStatusAll" id="inputStatusAll" value="" checked="checked"><label for="inputStatusAll"> 전체</label></input>&nbsp;&nbsp;
							<c:forEach var="code" items="${inputStatusList}" varStatus="status">
								<input type="checkbox" name="inputStatus" id="inputStatus${code.code }" value="${code.code }" checked="checked"><label for="inputStatus${code.code }"> ${code.name}</label></input>&nbsp;&nbsp;
							</c:forEach>
						</td>
					</tr>
					<tr>
						<th>검색어</th>
						<td colspan="3">
							<select name="searchGubun" value="">
								<option value="STATBL_NM">통계표명</option>
								<option value="STATBL_ID">통계표ID</option>
							</select>
							<input type="text" name="searchVal" value="" placeholder="검색어 입력" size="40" />
							${sessionScope.button.btn_inquiry}  
						</td>
					</tr>
				</table>		
				<!-- 
				<div style="width:100%;float:left;">
					<div style="border:1px solid #c0cbd4;padding:10px;margin:0 15px 0 0;">
						<div style="clear: both;"></div>
						<div class="ibsheet_area_both">
							<div id="statSheet" class="sheet"></div> 
						</div>         
					</div>
				</div>
				 -->
				<div style="clear: both;"></div>
				<div class="ibsheet_area_both">
					<div id="statSheet" class="sheet"></div> 
				</div>  
				
				<div class="buttons" id="batchBtnDiv">
				<!-- 
					입력(W) 	= 입력, 승인요청, 제한
					승인(Q) 	= 승인, 반려
					취소요청(R) = 취소요청
					취소승인(A) = 취소승인, 취소반려
					입력이력(C) = 입력대기
				 -->
				<c:if test="${accCd eq 'SYS'}">
				<c:choose>
					<c:when test="${param.valueCd eq 'W'}">
						<a href='javascript:;' class='btn02' title="일괄 입력" name="batchInput">일괄 입력</a>
						<a href='javascript:;' class='btn02' title="일괄 승인요청" 	name="batchAprvReq" 	data-wrtstate="AW">일괄 승인요청</a>
						<a href='javascript:;' class='btn02' title="일괄 입력제한" 	name="batchLimitInput"	data-wrtstate="WL">일괄 입력제한</a>
					</c:when>
					<c:when test="${param.valueCd eq 'Q'}">
						<a href='javascript:;' class='btn02' title="일괄 승인" 		name="batchAprv"		data-wrtstate="AC">일괄 승인</a>
						<a href='javascript:;' class='btn02' title="일괄 반려" 		name="batchReturn"		data-wrtstate="RC">일괄 반려</a>
					</c:when>
					<c:when test="${param.valueCd eq 'R'}">
						<a href='javascript:;' class='btn02' title="일괄 취소요청" 	name="batchCancelReq"	data-wrtstate="RQ">일괄 취소요청</a>
					</c:when>
					<c:when test="${param.valueCd eq 'A'}">
						<a href='javascript:;' class='btn02' title="일괄 취소승인" 	name="batchCancel"		data-wrtstate="RA">일괄 취소승인</a>
						<a href='javascript:;' class='btn02' title="일괄 취소반려" 	name="batchCancelReturn"data-wrtstate="QR">일괄 취소반려</a>
					</c:when>
					<c:when test="${param.valueCd eq 'C'}">
						<a href='javascript:;' class='btn02' title="일괄 입력대기" 	name="batchWait"		data-wrtstate="WW">일괄 입력대기</a>
					</c:when>
					<c:otherwise>
						<a href='javascript:;' class='btn02' title="일괄 입력" name="batchInput">일괄 입력</a>
						<a href='javascript:;' class='btn02' title="일괄 승인요청" 	name="batchAprvReq" 	data-wrtstate="AW">일괄 승인요청</a>
						<a href='javascript:;' class='btn02' title="일괄 승인" 		name="batchAprv"		data-wrtstate="AC">일괄 승인</a>
						<a href='javascript:;' class='btn02' title="일괄 반려" 		name="batchReturn"		data-wrtstate="RC">일괄 반려</a>
						<a href='javascript:;' class='btn02' title="일괄 취소요청" 	name="batchCancelReq"	data-wrtstate="RQ">일괄 취소요청</a>
						<a href='javascript:;' class='btn02' title="일괄 취소승인" 	name="batchCancel"		data-wrtstate="RA">일괄 취소승인</a>
						<a href='javascript:;' class='btn02' title="일괄 취소반려" 	name="batchCancelReturn"data-wrtstate="QR">일괄 취소반려</a>
						<a href='javascript:;' class='btn02' title="일괄 입력제한" 	name="batchLimitInput"	data-wrtstate="WL">일괄 입력제한</a>
						<a href='javascript:;' class='btn02' title="일괄 입력대기" 	name="batchWait"		data-wrtstate="WW">일괄 입력대기</a>
					</c:otherwise>
				</c:choose>
				</c:if>
				</div>
				</form>               	
			</div>
		</div>
		
		<div id="loadingCircle" name="loadingCircle" style="position:fixed; top:0px; left:0px; width:100%; height: 100%; z-index:9999999999; display:none;">
			<div style="position:relative; top:50%; left:50%; margin: -37.5px 0 0 -37.5px;"><img src="<c:url value="/images/soportal/desktop/ajax-loader.gif"/>" alt="loading"></div>
		</div>
	</div>
	<iframe id="hidden-iframe" name="hidden-iframe" width="100%" height="0" frameborder="0" scrolling="0" style="display:none;"></iframe>
	<c:import url="/WEB-INF/jsp/inc/iframepopup.jsp"/>
	<!--##  푸터  ##-->
	<c:import url="/WEB-INF/jsp/admin/adminfooter.jsp" />
	<!--##  /푸터  ##-->
</body>

</html>