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
	var formObj = $("form[name=OpenInfFColView]"); 
}

function doAction(sAction) {
	var formObj = $("form[name=OpenInfFColView]");
	
	switch( sAction ) {
		case "lang":
			formObj.attr("action","<c:url value='/admin/service/openInfColViewPopUp.do'/>").submit();
			break;
	}
}

//function goDownload(mstSeq, saveFileNm) {
function goDownload(mstSeq, fileSeq) {
	var wName = "url";
	var wWidth = "300";
	var wHeight = "200";
	var wScroll ="no";
	var url = "/admin/service/fileDownload.do?downCd=S&seq="+mstSeq+"&fileSeq="+fileSeq+"&etc=";
	OpenWindow(url, wName, wWidth, wHeight, wScroll);
	
}

//function goPreview(mstSeq, fileSeq, fileExt) {
function goPreview(mstSeq, fileSeq, fileExt) {
	var fn = fileSeq + "." + fileExt;
	var rs = getFolderPath(mstSeq,"${convertFilePath}");
	
	var url = "<c:url value='/synap/skin/doc.html' />" +"?fn="+fn+"&rs="+rs;
  	$("#fileVIew").prop("src",url);
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
						<h2>Preview - File</h2>
					</c:when>
					<c:otherwise>         
						<h2>미리보기 - File</h2>
					</c:otherwise>
				</c:choose>
			</div>
			<!-- 탭 -->
			<ul class="tab-popup">
			</ul>
			
			<!-- 탭 내용 -->                 
			<form name="OpenInfFColView"  method="post" action="#">             
			<div class="content-popup">
				<input type="hidden" name="fileDownType" value=""/> 
				<input type="hidden" name="infId" value="${openInfSrv.infId}"/>
				<input type="hidden" name="srvCd" value="${openInfSrv.srvCd}"/>
				<input type="hidden" name="viewLang" value=""/>  
				<input type="hidden" name="popupUse" value=""/>                                 
		
				<!-- <iframe id="fileVIew" width="100%" height="500" scrolling="yes"></iframe> -->
				
				<table class="list01 hor">
					<caption>파일 미리보기</caption>
					<colgroup>
						<col width="40"/>
						<col width="200"/>
						<col width="90"/>
						<col width="80"/>
						<col width="80"/>
						<col width="80"/>
						<col width="100"/>
						<col width="100"/>
					</colgroup>
					<tr>
						<c:choose>
							<c:when test="${viewLang eq 'E'}">
								<th class="none">No</th>
								<th>File Name</th>
								<th>File Ext</th>
								<th>Size(KB)</th>
								<th>Writer</th>
								<th>Create Date</th>
								<th>Last Update Datet</th>
								<th>preview</th>
								<th>Download</th>
							</c:when>
							<c:otherwise>
								<th class="none">No</th>
								<th>파일명</th>
								<th>확장자</th>
								<th>사이즈(KB)</th>
								<th>작성자</th>
								<th>최초생성일</th>
								<th>최종수정일</th>
								<!-- <th>미리보기</th> -->
								<th>다운로드</th>
							</c:otherwise>
						</c:choose>  
						
					</tr>
					<c:forEach var="resultList" items="${resultList}" varStatus="status">
						<tr>
							<td class="none text-center">${status.index +1 }</td>
							<c:choose>
								<c:when test="${viewLang eq 'E'}">
									<td>${resultList.viewFileNmEng }.${resultList.fileExt }</td>
								</c:when>
								<c:otherwise>         
									<td>${resultList.viewFileNm }.${resultList.fileExt }</td>
								</c:otherwise>        
							</c:choose>
							<td class="text-center">${resultList.fileExt }</td>
							<td class="text-center">${resultList.fileSizeKb } KB</td>
							<td class="text-center">${resultList.wrtNm }</td>
							<td class="text-center">${resultList.ftCrDttm }</td>
							<td class="text-center">${resultList.ltCrDttm }</td>
							<td class="text-center">
								<c:choose>
									<c:when test="${viewLang eq 'E'}">
										<button type="button" class="btn01L" id="btn_link" onclick="javascript: goDownload('${resultList.mstSeq }', '${resultList.fileSeq }')">Download▶</button>
									</c:when>
									<c:otherwise>         
										<button type="button" class="btn01L" id="btn_link" onclick="javascript: goDownload('${resultList.mstSeq }', '${resultList.fileSeq }')">다운로드▶</button>
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