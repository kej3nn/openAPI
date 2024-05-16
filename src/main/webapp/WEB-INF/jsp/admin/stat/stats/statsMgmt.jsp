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
<script type="text/javascript" src="<c:url value="/js/admin/stat/statsMgmt.js" />"></script>
<!--  
	validate 사용시 반드시 선언
	formName명과 validate 함수명이 연결되어있음
	adminOpenInf -> validateadminOpenInf 체크함
	resources/validator/*.* xml을 만들어서 사용
  -->
  <%-- 
<validator:javascript formName="adminOpenInf" staticJavascript="false"
	xhtml="true" cdata="false" /> --%>
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
			
			<c:import  url="statsMgmtMst.jsp"/>
			
			<!-- 리스트 -->
			<div class="content">
				<form name="statMainForm"  method="post" action="#">
				<table class="list01">
					<caption>통계표리스트</caption>
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
						<th>시스템</th>
						<td>
							<input type="checkbox" id="allSystem" name="allSystem" value="" checked="checked"><label for="allSystem">전체</label></input>&nbsp;&nbsp;
							<c:forEach var="system" items="${systemList }" varStatus="status">
									<c:if test="${system.code eq 'K'}">
										<input type="checkbox" value="${system.code }" id="korYn" name="korYn"><label for="korYn">${system.name }</label></input>&nbsp;&nbsp;
									</c:if>
									<c:if test="${system.code eq 'E'}">
										<input type="checkbox" value="${system.code }" id="engYn" name="engYn"><label for="engYn">${system.name }</label></input>&nbsp;&nbsp;
									</c:if>
									<c:if test="${system.code eq 'M'}">
										<input type="checkbox" value="${system.code }" id="korMobileYn" name="korMobileYn"><label for="korMobileYn">${system.name }</label></input>&nbsp;&nbsp;								
									</c:if>	
									<c:if test="${system.code eq 'B'}">
										<input type="checkbox" value="${system.code }" id="engMobileYn" name="engMobileYn"><label for="engMobileYn">${system.name }</label></input>&nbsp;&nbsp;								
									</c:if>	
							</c:forEach>
						</td> 
						<th>연계정보</th>
						<td>
							<select name="dscnId" id="dscnId">
								<option value="">전체</option>
							<c:forEach var="dscn" items="${dscnList }" varStatus="status">
								<option value="${dscn.code }">${dscn.name }</option>
							</c:forEach>
							</select>
						</td>
					</tr>
					<tr>
						<th>작성주기</th>
						<td>
							<input type="checkbox" id="allDtacycle" name="allDtacycle" value="" checked="checked"><label for="allDtacycle">전체</label></input>&nbsp;&nbsp;
							<c:forEach var="dtacycle" items="${dtacycleList }" varStatus="status">
								<input type="checkbox" id="${dtacycle.code }dtacycleYn" name="${dtacycle.code }dtacycleYn" value="${dtacycle.code }" >
								<label for="${dtacycle.code }dtacycleYn">${dtacycle.name }</label></input>&nbsp;&nbsp;
							</c:forEach>
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
								<option value="STATBL_NM">한글 통계표명</option>
								<option value="ENG_STATBL_NM">영문 통계표명</option>
								<option value="STATBL_ID">통계표 ID</option>
							</select>
							<input type="text" name="searchVal" value="" placeholder="검색어 입력" size="40" />
							${sessionScope.button.btn_inquiry}  
							${sessionScope.button.btn_reg}
							<button type="button" class="btn01B" title="통계분석자료 일괄생성" name="btn_sttsAnalsAll" style="float: right;">통계분석자료 일괄생성</button>
						</td>
					</tr>
					<tr>
						<th>공개상태</th>
						<td colspan="3">
							<input type="radio" id="openStateAll" name="openState" value=""  checked="checked"><label for="openStateAll">전체</label></input>&nbsp;&nbsp;
							<c:forEach var="openState" items="${openStateList }" varStatus="status">
								<input type="radio" id="openState_${openState.code }" name="openState" value="${openState.code }" ><label for="openState_${openState.code }">${openState.name }</label></input>&nbsp;&nbsp;
							</c:forEach>
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							<input type="checkbox" name="fvtDataOrder" id="fvtDataOrder" value="Y"><label for="fvtDataOrder">추천 (홈페이지 노출)</label></input>
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

</html>