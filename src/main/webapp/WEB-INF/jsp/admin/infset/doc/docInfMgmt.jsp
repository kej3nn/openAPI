<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="egovframework.common.WiseOpenConfig"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><spring:message code='wiseopen.title' /></title>
<c:import url="/WEB-INF/jsp/inc/headinclude.jsp" />
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
			
			<c:import  url="docInfMgmtMst.jsp"/>
			
			<!-- 리스트 -->
			<div class="content">
				<form name="mainForm"  method="post" action="#">
				<table class="list01">
					<caption>리스트</caption>
					<colgroup>
						<col width="150"/>
						<col width=""/>
						<col width="150"/>
						<col width=""/>
					</colgroup>
					<tr>
						<th>분류</th>
						<td>
							<input type="text" id="cateIds" name="cateIds" size="8" value="" readonly="readonly" />
							<input type="text" id="cateId" name="cateId" size="8" value="" readonly="readonly" style="display: none;"/>
							<input type="text" id="cateNm" name="cateNm" size="25" value=""  placeholder="선택하세요.." readonly="readonly" />
							<button type="button" class="btn01" id="cate_pop" name="cate_pop">검색</button>
							<button type="button" class="btn01" id="cate_reset" name="cate_reset">초기화</button>
						</td>
						<th>담당부서</th>
						<td>
							<input type="text" id="orgCd" name="orgCd" size="8" value="" readonly="readonly" />
							<input type="text" id="orgNm" name="orgNm" size="25" value="" placeholder="선택하세요.." readonly="readonly" />
							<button type="button" class="btn01" id="org_pop" name="org_pop">검색</button>
							<button type="button" class="btn01" id="org_reset" name="org_reset">초기화</button>
						</td>
					</tr>
					
					<tr>
						<th>이용허락조건</th>
						<td>
							<select id="schCclCd" name="schCclCd">
								<option value="">선택</option>
								<c:forEach var="list" items="${cclCdList }">
									<option value="${list.code }">${list.name }</option>
								</c:forEach>
							</select>
						</td>
						<th>공개일</th>
						<td>
							<input type="text" name="beginOpenDttm" value="" placeholder="공개일 시작" size="13" />
							~
							<input type="text" name="endOpenDttm" value="" placeholder="공개일 종료" size="13" />
							&nbsp;&nbsp;
							<button type="button" class="btn01" id="openDttm_reset" name="openDttm_reset">초기화</button>
						</td>
					</tr>
					<tr>
						<th><spring:message code='labal.search'/></th>             
						<td colspan="3">
							<select id="searchGubun" name="searchGubun">
								<option value="DOC_NM">문서 명</option>
								<option value="DOC_ID">문서 ID</option>
							</select>
							<input type="text" name="searchVal" value="" placeholder="검색어 입력" size="40" />
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							<input type="checkbox" name="fvtDataOrder" id="fvtDataOrder" value="Y"><label for="fvtDataOrder">추천 (홈페이지 노출)</label></input>
						</td>
					</tr>
					<tr>
						<th>공개상태</th>
						<td colspan="3">
							<input type="radio" id="openStateAll" name="openState" value=""  checked="checked"><label for="openStateAll">전체</label></input>&nbsp;&nbsp;
							<c:forEach var="openState" items="${openStateList }" varStatus="status">
								<input type="radio" id="openState_${openState.code }" name="openState" value="${openState.code }" ><label for="openState_${openState.code }">${openState.name }</label></input>&nbsp;&nbsp;
							</c:forEach>
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							${sessionScope.button.btn_inquiry}  
							${sessionScope.button.btn_reg}
							${sessionScope.button.btn_xlsDown}
						</td>
					</tr>
				</table>		
				<div style="clear: both;"></div>
				<div class="ibsheet_area_both">
					<div id="mainSheet" class="sheet"></div> 
				</div>   
				
				</form>               	
			</div>
		</div>
		<div id="loadingCircle" name="loadingCircle" style="position:fixed; top:0px; left:0px; width:100%; height: 100%; z-index:9999999999; display:none;">
			<div style="position:relative; top:50%; left:50%; margin: -37.5px 0 0 -37.5px;"><img src="<c:url value="/images/soportal/desktop/ajax-loader.gif"/>" alt="loading"></div>
		</div>
	</div>
	<iframe id="hidden-iframe" name="hidden-iframe" width="100%" height="0" frameborder="0" scrolling="0" style="display:none;"></iframe>
	<c:import  url="/WEB-INF/jsp/inc/iframepopup.jsp"/>
	<!--##  푸터  ##-->
	<c:import url="/WEB-INF/jsp/admin/adminfooter.jsp" />
	<!--##  /푸터  ##-->
</body>
<script type="text/javascript" src="<c:url value="/js/admin/infset/doc/docInfMgmt.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/admin/infset/doc/docInfMgmtSheet.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/admin/infset/doc/docInfMgmtEvent.js" />"></script>
</html>