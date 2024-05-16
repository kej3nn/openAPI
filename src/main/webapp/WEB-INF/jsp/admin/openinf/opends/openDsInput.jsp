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
<script type="text/javascript" src="<c:url value="/js/admin/openinf/openDsInput.js" />"></script>

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
			
			<c:import  url="openDsInputDtl.jsp"/>
			
			<!-- 리스트 -->
			<div class="content">
				<form name="openMainForm"  method="post" action="#">
				<table class="list01">
					<caption>공공데이터 데이터입력 리스트</caption>
					<colgroup>
						<col width="15%"/>
						<col width="35%"/>
						<col width="15%"/>
						<col width="35%"/>
					</colgroup>
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
						<th>입력마감일</th>
						<td>
							<input type="text" name="startLoadDttm" value="" placeholder="입력마감일 시작" size="13" />
							~
							<input type="text" name="endLoadDttm" value="" placeholder="입력마감일 종료" size="13" />
							&nbsp;&nbsp;
							<button type="button" class="btn01" id="loadDttm_reset" name="loadDttm_reset">초기화</button>
						</td>
						<th>승인일</th>
						<td>
							<input type="text" name="startAccDttm" value="" placeholder="승인일 시작" size="13" />
							~
							<input type="text" name="endAccDttm" value="" placeholder="승인일 종료" size="13" />
							&nbsp;&nbsp;
							<button type="button" class="btn01" id="accDttm_reset" name="accDttm_reset">초기화</button>
						</td>
					</tr>
					<tr>
						<th>입력주기</th>
						<td colspan="3">
							<input type="checkbox" name="loadCdAll" id="loadCdAll" value=""><label for="loadCdAll"> 전체</label></input>&nbsp;&nbsp;
							<c:forEach var="code" items="${loadCdList}" varStatus="status">
								<input type="checkbox" name="loadCd" id="loadCd${code.code }" value="${code.code }"><label for="loadCd${code.code }"> ${code.name}</label></input>&nbsp;&nbsp;
							</c:forEach>  
						</td>
					</tr>
					<tr>
						<th>입력상태</th>
						<td colspan="3">
							<input type="checkbox" name="ldstateCdAll" id="ldstateCdAll" value=""><label for="ldstateCdAll"> 전체</label></input>&nbsp;&nbsp;
							<c:forEach var="code" items="${ldstateCdList}" varStatus="status">
								<input type="checkbox" name="ldstateCd" id="ldstateCd${code.code }" value="${code.code }"><label for="ldstateCd${code.code }"> ${code.name}</label></input>&nbsp;&nbsp;
							</c:forEach>
						</td>
					</tr>
					<tr>
						<th>검색어</th>
						<td colspan="3">
							<select name="searchGubun" value="">
								<option value="DS_NM">데이터셋명</option>
								<option value="DS_ID">데이터셋ID</option>
							</select>
							<input type="text" name="searchVal" value="" placeholder="검색어 입력" size="40" />
							${sessionScope.button.btn_inquiry}  
						</td>
					</tr>
				</table>		
				
				<div style="width:100%;float:left;">
					<div style="border:1px solid #c0cbd4;padding:10px;margin:0 15px 0 0;">
						<div style="clear: both;"></div>
						<div class="ibsheet_area_both">
							<div id="mainSheet" class="sheet"></div> 
						</div>         
					</div>
				</div>
				</form>               	
			</div>
		</div>
		
		<div id="loadingCircle" name="loadingCircle" style="position:fixed; top:0px; left:0px; width:100%; height: 100%; z-index:9999999999; display:none;">
			<div style="position:relative; top:50%; left:50%; margin: -37.5px 0 0 -37.5px;"><img src="<c:url value="/img/ajax-loader.gif"/>" alt="loading"></div>
		</div>
	</div>
	<iframe id="hidden-iframe" name="hidden-iframe" width="100%" height="0" frameborder="0" scrolling="0" style="display:none;"></iframe>
	<c:import  url="/WEB-INF/jsp/inc/iframepopup.jsp"/>
	<!--##  푸터  ##-->
	<c:import url="/WEB-INF/jsp/admin/adminfooter.jsp" />
	<!--##  /푸터  ##-->
</body>

</html>