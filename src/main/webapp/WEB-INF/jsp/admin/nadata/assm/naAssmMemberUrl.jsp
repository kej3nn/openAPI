<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="egovframework.common.WiseOpenConfig"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%> 
<%-- 
 * 관리자 - 국회의원 URL 관리 스크립트 파일이다
 *
 * @author JHKIM
 * @version 1.0 2019/11/12
--%>
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
				<form name="form"  method="post" action="#">
				<table class="list01">
					<caption>리스트</caption>
					<colgroup>
						<col width="150"/>
						<col width=""/>
						<col width="150"/>
						<col width=""/>
					</colgroup>
					<tr>
						<th>검색어</th>
						<td colspan="3">
							<select name="searchGubun">
								<option value="A">의원명</option>
							</select>
							<input type="text" name="searchVal" style="width: 300px;">
							&nbsp;&nbsp;&nbsp;
							<button type="button" class="btn01B" title="조회" id="btn_inquery">조회</button>
							<button type="button" class="btn01B" title="조회" id="btn_save">저장</button>
						</td>
					</tr>
				</table><!-- 
				<div class="buttons">
					<a href="javascript:;" class="btn02" title="추가" id="a_add">추가</a>
					<a href="javascript:;" class="btn03" title="저장" id="a_save">저장</a>
				</div> -->
				
				<div style="clear: both;"></div>
				<div class="ibsheet_area_both">
					<div id="sheet" class="sheet"></div> 
				</div>   
			</div>
			   	
			</form>
		</div>
		
	</div>
	<iframe id="hidden-iframe" name="hidden-iframe" width="100%" height="0" frameborder="0" scrolling="0" style="display:none;"></iframe>
	<c:import  url="/WEB-INF/jsp/inc/iframepopup.jsp"/>
	<!--##  푸터  ##-->
	<c:import url="/WEB-INF/jsp/admin/adminfooter.jsp" />
	<!--##  /푸터  ##-->
</body>
<script type="text/javascript" src="<c:url value="/js/admin/nadata/assm/naAssmMemberUrl.js" />"></script>
</html>