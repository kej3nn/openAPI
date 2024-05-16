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
<script type="text/javascript" src="<c:url value="/js/common/component/jquery.validate.min.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/admin/stat/statSttsStat.js" />"></script>
<script language="javascript">   
var ctxPath = '<c:out value="${pageContext.request.contextPath}" />';
</script>
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
			
			<c:import  url="statSttsStatDtl.jsp"/>
			
			<!-- 리스트 -->
			<div class="content">
				<form name="statSttsForm"  method="post" action="#"> 
				<table class="list01">
					<caption>리스트</caption>
					<colgroup>
						<col width="20%"/>
						<col width="80%"/>
					</colgroup>
					<tr>
						<th>통계구분</th>
						<td colspan="3">
							<c:forEach var="sttsCd" items="${searchSttsCdList }" varStatus="status">
								<c:choose>
									<c:when test="${status.first }">
										<input type="radio" id="searchSttsCd_${status.count }" name="sttsCd" value="${sttsCd.code }"  checked="checked">
									</c:when>
									<c:otherwise>
										<input type="radio" id="searchSttsCd_${status.count }" name="sttsCd" value="${sttsCd.code }" >									
									</c:otherwise>
								</c:choose>
									<label for="searchSttsCd_${status.count }">${sttsCd.name }</label>
								</input>&nbsp;&nbsp;
							</c:forEach>
						</td>
					</tr>
					<tr>
						<th>담당부서</th>
						<td>
							<input type="text" id="orgCd" name="orgCd" size="8" value="" readonly="readonly" />
							<input type="text" id="orgNm" name="orgNm" size="25" value="" placeholder="선택하세요.." readonly="readonly" />
							<button type="button" class="btn01" id="org_pop" name="org_pop">검색</button>
							<button type="button" class="btn01" id="org_reset" name="org_reset">초기화</button>
						</td>
					</tr>	
					<tr>
						<th>검색어</th>
						<td colspan="3">
							<select name="searchGubun" value="">
								<option value="STAT_NM">한글메타명</option>
								<option value="ENG_STAT_NM">영문메타명</option>
								<option value="STAT_ID">메타ID</option>
							</select>
							<input type="text" name="searchVal" value="" placeholder="검색어 입력" size="40" />
							${sessionScope.button.btn_inquiry}  
							${sessionScope.button.btn_reg}
						</td>
					</tr>
					<tr>
						<th>사용여부</th>
						<td>
							<input type="radio" value="" name="useYn" id="useYnAll" checked="checked"><label for="useYnAll">전체</label></input>&nbsp;&nbsp;
							<input type="radio" value="Y" name="useYn" id="useYnY"><label for="useYnY">사용</label></input>&nbsp;&nbsp;
							<input type="radio" value="N" name="useYn" id="useYnN"><label for="useYnN">미사용</label></input>&nbsp;&nbsp;
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
			</div>
			</form>               	
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

</html>