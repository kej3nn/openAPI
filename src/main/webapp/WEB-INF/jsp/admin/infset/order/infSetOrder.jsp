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
						<th>공개상태</th>
						<td colspan="3">
							<input type="radio" id="openStateAll" name="openState" value=""  checked="checked"><label for="openStateAll">전체</label></input>&nbsp;&nbsp;
							<c:forEach var="openState" items="${openStateList }" varStatus="status">
								<input type="radio" id="openState_${openState.code }" name="openState" value="${openState.code }" ><label for="openState_${openState.code }">${openState.name }</label></input>&nbsp;&nbsp;
							</c:forEach>
							&nbsp;&nbsp;&nbsp;
							<button type="button" class="btn01" title="열기" id="btn_treeOpen">열기</button>
							<button type="button" class="btn01" title="닫기" id="btn_treeClose">닫기</button>
							<button type="button" class="btn01B" title="조회" name="btn_inquiry" style="float: right;">조회</button>
						</td>
					</tr>
				</table>		
				<div style="clear: both;"></div>
				<div class="ibsheet_area_both">
					<div id="mainSheet" class="sheet"></div> 
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
<script type="text/javascript" src="<c:url value="/js/admin/infset/order/infSetOrder.js" />"></script>
</html>