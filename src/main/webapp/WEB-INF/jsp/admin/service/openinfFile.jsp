<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="egovframework.common.WiseOpenConfig"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><spring:message code='wiseopen.title' /></title>
<c:import url="/WEB-INF/jsp/inc/headinclude.jsp" />
<script type="text/javascript" src="<c:url value="/js/admin/openinf/openinfFile.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/admin/openinf/openinfFileEvent.js" />"></script>
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
			
			<c:import url="openinfFileDtl.jsp"/>
			
			<!-- 리스트 -->
			<div class="content">
				<form id="mstForm" name="mstForm" method="post" action="#">
				<table class="list01">
					<caption>파일서비스 첨부등록 리스트</caption>
					<colgroup>
						<col width="15%"/>
						<col width="35%"/>
						<col width="15%"/>
						<col width="35%"/>
					</colgroup>
					<c:if test="${accCd eq 'SYS' }">
					<!-- 시스템유저만 부서선택 -->
					<!-- 
					<tr>
						<th>담당부서</th>
						<td colspan="3">
							<input type="text" id="orgCd" name="orgCd" size="8" value="" readonly="readonly" />
							<input type="text" id="orgNm" name="orgNm" size="25" value="" placeholder="선택하세요.." readonly="readonly" />
							<button type="button" class="btn01" id="org_pop" name="org_pop">검색</button>
							<button type="button" class="btn01" id="org_reset" name="org_reset">초기화</button>
						</td>
					</tr> -->
					</c:if>
					<tr>
						<th>검색어</th>
						<td colspan="3">
							<select name="searchGubun" value="">
								<option value="ALL">선택</option>
								<option value="DT">보유데이터명</option>
								<option value="INF" selected="selected">공공데이터명</option>
								<option value="TAG">태그명</option>
							</select>
							<input type="text" name="searchWord" value="" placeholder="검색어 입력" size="40" />
							${sessionScope.button.btn_inquiry}
						</td>
					</tr>
					<%-- <tr>
						<th>개방상태</th>
						<td colspan="3">
							<input type="radio" id="infStateAll" name="infState" value=""  checked="checked"><label for="infStateAll"><spring:message code="labal.infStateA" /></label></input>&nbsp;&nbsp;
							<input type="radio" id="infStateN" name="infState" value="N" ><label for="infStateN"><spring:message code="labal.infStateN" /></label></input>&nbsp;&nbsp;
							<input type="radio" id="infStateY" name="infState" value="Y" ><label for="infStateY"><spring:message code="labal.infStateY" /></label></input>&nbsp;&nbsp;
							<input type="radio" id="infStateX" name="infState" value="X" ><label for="infStateX"><spring:message code="labal.infStateX" /></label></input>&nbsp;&nbsp;
							<input type="radio" id="infStateC" name="infState" value="C" ><label for="infStateC"><spring:message code="labal.infStateC" /></label></input>&nbsp;&nbsp;
						</td>
					</tr> --%>
				</table>		
				
				<div style="clear: both;"></div>
				<div class="ibsheet_area_both">
					<div id="mainSheet" class="sheet"></div> 
				</div>         
				</form>               	
			</div>
		
		</div>
		
		<div id="loadingCircle" name="loadingCircle" style="position:fixed; top:0px; left:0px; width:100%; height: 100%; z-index:9999999999; display:none;">
			<div style="position:relative; top:50%; left:50%; margin: -37.5px 0 0 -37.5px;"><img src="<c:url value="/img/ajax-loader.gif"/>" alt="loading"></div>
		</div>
		<form id="downloadForm" action="/admin/openinf/downloadOpeninfFile.do" target="hidden-iframe">
			<input type="hidden" name="infId">
			<input type="hidden" name="fileSeq">
		</form>
	</div>
	<iframe id="hidden-iframe" name="hidden-iframe" width="100%" height="0" frameborder="0" scrolling="0" style="display:none;"></iframe>
	<c:import  url="/WEB-INF/jsp/inc/iframepopup.jsp"/>
	<!--##  푸터  ##-->
	<c:import url="/WEB-INF/jsp/admin/adminfooter.jsp" />
	<!--##  /푸터  ##-->
</body>

</html>