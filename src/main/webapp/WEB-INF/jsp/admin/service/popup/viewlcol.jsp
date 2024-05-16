<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="egovframework.common.WiseOpenConfig"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><spring:message code='wiseopen.title'/></title>                    
<c:import  url="/WEB-INF/jsp/inc/headinclude.jsp"/>
<style type="text/css">
body{background:none;} /* 임시로 해놓은 것임 */
</style>
</head>                                                 
<script language="javascript">              
//<![CDATA[                   
$(document).ready(function()    {
	inputSet();
});                                      
//]]>

function inputSet() {
	var formObj = $("form[name=OpenInfLColView]");
	$("#a_kr").click(function(e) { 
		formObj.find("input[name=viewLang]").val("");
		doAction("lang");
		return false;                             
	 }); 
	$("#a_en").click(function(e) { 
		formObj.find("input[name=viewLang]").val("E");
		doAction("lang");
		return false;                             
	 }); 
}

function doAction(sAction) {
	var formObj = $("form[name=OpenInfLColView]");
	
	switch( sAction ) {
		case "lang":
			formObj.attr("action","<c:url value='/admin/service/openInfColViewPopUp.do'/>").submit();
			break;
	}
}

function goUrl(url) {
	var wName = "url";
	var wWidth = "1024";
	var wHeight = "560";
	var wScroll ="no";
	OpenWindow(url, wName, wWidth, wHeight, wScroll);
}
</script>              
</head>
<body onload="">
<div class="wrap-popup">
		<!-- 내용 -->
		<div class="container">
			<!-- 상단 타이틀 -->
			<div class="title">
				<c:choose>
					<c:when test="${viewLang eq 'E'}">
						<h2>Preview - Link</h2>
					</c:when>
					<c:otherwise>         
						<h2>미리보기 - Link</h2>
					</c:otherwise>
				</c:choose>
			</div>
			<!-- 탭 -->
			<ul class="tab-popup">
 				<%-- <c:choose>
					<c:when test="${viewLang eq 'E'}">
						<li class="first"><a href="#" id="a_kr">KOR VIEW</a></li>
						<li class="on"><a href="#" id="a_en">ENG VIEW</a></li>
					</c:when>
					<c:otherwise>         
						<li class="first on"><a href="#" id="a_kr">한글보기</a></li>
						<li><a href="#" id="a_en">영문보기</a></li>
					</c:otherwise>
				</c:choose> --%>
			</ul>
			
			<!-- 탭 내용 -->                 
			<form name="OpenInfLColView"  method="post" action="#">             
			<div class="content-popup">
				<input type="hidden" name="fileDownType" value=""/> 
				<input type="hidden" name="infId" value="${openInfSrv.infId}"/>
				<input type="hidden" name="srvCd" value="${openInfSrv.srvCd}"/>
				<input type="hidden" name="viewLang" value=""/>                                  
				
				<table class="list01 hor">
				<caption>공공데이터목록리스트</caption>
				<colgroup>
					<col width="40"/>
					<col width="330"/>
					<col width="230"/>
					<col width="100"/>
					<col width="110"/>
					<col width=""/>
				</colgroup>
				<tr>
					<c:choose>
						<c:when test="${viewLang eq 'E'}">
							<th class="none">No</th>
							<th>URL</th>
							<th>URL Name</th>
							<th>View Count</th>
							<th>Regist Day</th>
							<th>Shot cut</th>
						</c:when>
						<c:otherwise>
							<th class="none">No</th>
							<th>URL</th>
							<th>URL명</th>
							<th>조회수</th>
							<th>등록일자</th>
							<th>바로가기</th>
						</c:otherwise>
					</c:choose>  
					
				</tr>
				<c:forEach var="resultList" items="${resultList}" varStatus="status">
				<tr>
					<td class="none text-center">${status.index +1 }</td>
					<td>${resultList.linkUrl }</td>
					<c:choose>
					<c:when test="${viewLang eq 'E'}">
						<td>${resultList.linkExpEng }</td>
					</c:when>
					<c:otherwise>
						<td>${resultList.linkExp }</td>
					</c:otherwise>
					</c:choose>
					<td class="text-center">${resultList.viewCnt }</td>
					<td class="text-center">${resultList.regDttm }</td>
					<td class="text-center">
						<c:choose>
							<c:when test="${viewLang eq 'E'}">
								<button type="button" class="btn01L" id="btn_link" onclick="javascript: goUrl('${resultList.linkUrl}');">Shot cut▶</button>
							</c:when>
							<c:otherwise>         
								<button type="button" class="btn01L" id="btn_link" onclick="javascript: goUrl('${resultList.linkUrl}');">바로가기▶</button>
							</c:otherwise>        
						</c:choose>
					</td>
				</tr>
				</c:forEach>
			</table>
			</div>
			</form>
			
			<div class="buttons">  
				<c:choose>
					<c:when test="${viewLang eq 'E'}">
						<a href='#' class='btn02' name='a_close' onclick="javascript: window.close();">Close</a>       
					</c:when>
					<c:otherwise>         
						<a href='#' class='btn02' name='a_close' onclick="javascript: window.close();">닫기</a>       
					</c:otherwise>        
				</c:choose>
			</div>	
		</div>		
	</div>
</html>