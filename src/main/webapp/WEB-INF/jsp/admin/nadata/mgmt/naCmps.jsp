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
			
			<!-- 탭 -->
			<ul class="tab">
				<li class="all_list"><a href="#">전체목록</a></li>
			</ul>
			
			<c:import  url="naCmpsDtl.jsp"/>
			
			<!-- 리스트 -->
			<div class="content">
				<form name="naCmpsMainForm"  method="post" action="#">
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
						<td colspan="7">
							<input type="text" id="cateIds" name="cateIds" size="8" value="" readonly="readonly" />
							<input type="text" id="cateId" name="cateId" size="8" value="" readonly="readonly" style="display: none;"/>
							<input type="text" id="cateNm" name="cateNm" size="25" value=""  placeholder="선택하세요.." readonly="readonly" />
							<button type="button" class="btn01" id="cate_pop" name="cate_pop">검색</button>
							<button type="button" class="btn01" id="cate_reset" name="cate_reset">초기화</button>
						</td>
					</tr>
					<tr>
						<th>관련부서</th>             
						<td colspan="3">
							<select name="orgCd" id="orgCd">
								<option value="">전체</option>
								<c:forEach items="${orgList}" var="orgList">
									<option value="${orgList.orgCd}">${orgList.orgNm }</optin>
								</c:forEach>
							</select>
							
						</td>
						<th>서비스유형</th>
						<td colspan="3">
							<select name="srvInfoCd" id="srvInfoCd">
								<option value="">전체</option>
								<c:forEach items="${srvInfoList}" var="srvInfoList">
									<option value="${srvInfoList.code}">${srvInfoList.name }</optin>
								</c:forEach>
							</select>
						</td>
					</tr>
					<tr>
						<th><spring:message code='labal.search'/></th>             
						<td colspan="7">
							<select id="searchGubun" name="searchGubun">
								<option value="INFO_NM">정보명</option>
								<option value="INFO_ID">정보ID</option>
							</select>
							<input type="text" name="searchVal" value="" placeholder="검색어 입력" size="40" />
							
						</td>
					</tr>
					<tr>
						<th>정상서비스여부</th>
						<td colspan="3">
							<input type="radio" value="" name="viewYn" id="viewYnAll" checked="checked"></input><label for="viewYnAll">전체</label>&nbsp;&nbsp;
							<input type="radio" value="Y" name="viewYn" id="viewYnY"></input><label for="viewYnY">정상</label>&nbsp;&nbsp;
							<input type="radio" value="N" name="viewYn" id="viewYnN"></input><label for="viewYnN">비정상</label>
						</td>
						<th>사용여부</th>
						<td colspan="3">
							<input type="radio" value="" name="useYn" id="useYnAll" checked="checked"></input><label for="useYnAll">전체</label>&nbsp;&nbsp;
							<input type="radio" value="Y" name="useYn" id="useYnY"></input><label for="useYnY">사용</label>&nbsp;&nbsp;
							<input type="radio" value="N" name="useYn" id="useYnN"></input><label for="useYnN">미사용</label>
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							${sessionScope.button.btn_inquiry}  
							${sessionScope.button.btn_reg}
							<%-- ${sessionScope.button.btn_xlsDown} --%>
						</td>
					</tr>
				</table>		
				<div style="clear: both;"></div>
				<div class="ibsheet_area_both">
					<div id="sheet" class="sheet"></div> 
				</div>   
				<div class="buttons">
					<a href='javascript:;' class='btn02' title="위로이동" name="a_treeUp">위로이동</a>
					<a href='javascript:;' class='btn02' title="아래로이동" name="a_treeDown">아래로이동</a>
					${sessionScope.button.a_vOrderSave}
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
<script type="text/javascript" src="<c:url value="/js/admin/nadata/mgmt/naCmps.js" />"></script>
</html>