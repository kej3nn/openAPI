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
<script language="javascript"> 
$(document).ready(function()    {         
	reSizeIframePop();
	inputSet();
	
	$("a[name=a_close]").click(function(e) { 
		window.close();
		return false;                             
	 });
	$("button[name=a_copy]").click(function(e){
		
		var IE=(document.all)?true:false;
		
		var srcUrl = document.getElementById("srcUrl").firstChild.nodeValue;
		
		if(IE){
			window.clipboardData.setData("text",srcUrl);
			return false;
		}else{

			prompt("Ctrl+C를 눌러 클립보드로 복사하세요",srcUrl);
			return false;
		}
		return false;
	});

/*	
	<c:forEach var="result" items="${result}" varStatus="status">
		if("${result.infState}" == "Y"){
			$(".icon-open1").attr("style", "");
			$(".icon-open2").attr("style", "display:none;");
			$(".icon-open3").attr("style", "display:none;");
			$(".icon-open4").attr("style", "display:none;");
		}else if("${result.infState}" == "N"){
			$(".icon-open1").attr("style", "display:none;");
			$(".icon-open2").attr("style", "");
			$(".icon-open3").attr("style", "display:none;");
			$(".icon-open4").attr("style", "display:none;");
		}else if("${result.infState}" == "X"){
			$(".icon-open1").attr("style", "display:none;");
			$(".icon-open2").attr("style", "display:none;");
			$(".icon-open3").attr("style", "");
			$(".icon-open4").attr("style", "display:none;");
		}else if("${result.infState}" == "C"){
			$(".icon-open1").attr("style", "display:none;");
			$(".icon-open2").attr("style", "display:none;");
			$(".icon-open3").attr("style", "display:none;");
			$(".icon-open4").attr("style", "");
		}
	</c:forEach>
*/	
});    

function doAction(sAction) {
	var formObj = $("form[name=openInfViewPopUp]");
	switch( sAction ) {
		case "lang":
			formObj.attr("action","<c:url value='/admin/openinf/popup/openInfViewPopUp.do'/>").submit();
			break;
	}
}
function inputSet() {
	var formObj = $("form[name=openInfViewPopUp]");
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

</script>
</head>                                          
<body>
	<div class="wrap-popup">
		<!-- 내용 -->
		<div class="container">
			<!-- 상단 타이틀 -->
			<div class="title">
				<h2>미리보기 - 메타정보</h2>
			</div>
			<!-- 탭 -->
			<ul class="tab-popup">
 				<%-- <c:choose>
					<c:when test="${viewLang eq 'E'}">
						<li class="first"><a href="#" id="a_kr">KOR VIEW</a></li>
						<li class="on"><a href="#" id="a_en">ENG VIEW</a></li>
						<!-- <li class="on"><a href="#" id="a_mb">MOBILE VIEW</a></li> -->
					</c:when>
					<c:otherwise>         
						<li class="first on"><a href="#" id="a_kr">한글보기</a></li>
						<li><a href="#" id="a_en">영문보기</a></li>
						<!-- <li><a href="#" id="a_mb">모바일보기</a></li> -->
					</c:otherwise>
				</c:choose> --%>
			</ul>

<!-- 			<ul class="tab-popup"> -->
<!-- 				<li class="first on"><a href="#">한글보기</a></li> -->
<!-- 				<li><a href="#">영문보기</a></li> -->
<!-- 				<li><a href="#">모바일보기</a></li> -->
<!-- 			</ul> -->
			<!-- 탭 내용 -->

			<c:forEach var="result" items="${result}" varStatus="status">
			<form name="openInfViewPopUp" method="post" action="#">

			<div class="content-popup">
			
			<input type="hidden" name="viewLang" value=""/>
			<input type="hidden" name="infId" value="${result.infId}"/>
			
				<div class="header-popup">
					<!-- <h3 class="text-title2">${result.infNm }</h3>
					<p>${result.infExp }</p> -->
				</div>
				

				
				<table class="list01" style="position:relative;">
					<caption>메타정보</caption>
					<colgroup>
						<col width="150"/>
						<col width=""/>
						<col width="150"/>
						<col width=""/>
						<col width="150"/>
						<col width=""/>
					</colgroup>
					
					
					<c:choose>
					<c:when test="${viewLang eq 'E'}">
						<tr>
						<th>Public Data Name</th>
						<td colspan="5">${result.infNm }</td>
					<!--<td colspan="5">
							대분류 &gt; 분류정보
							<span class="icon-open1" style="display:none;">개방</span>
							<span class="icon-open2" style="display:none;">미개방</span>
							<span class="icon-open3" style="display:none;">개방불가</span>
							<span class="icon-open4" style="display:none;">개방취소</span>
						</td> -->
						</tr>
						<tr>
							<th>Origin System</th>
							<td colspan="2">${result.srcExp } (<a href="${result.srcUrl }">${result.srcUrl }</a>)</td>
							<th>Retention Data</th>
							<td colspan="2">${result.dtNm }</td>
						</tr>
						<tr>
							<th>Load Cycle</th>
							<td colspan="2">${result.loadNm }</td>
							<th>Load Day</th>
							<td colspan="2">${result.loadDttm }</td>
						<tr>
						<tr>
							<th>Classification System</th>
							<td colspan="2">${result.cateNm }
							<th>Open Data</th>
							<td colspan="2">${result.openDttm }
						</tr>
						<tr>
							<th>Organization</th>
							<td colspan="2">${result.topOrgNm }
							<th>Condition of Utilization</th>
							<td colspan="2">${result.cclNm }
						</tr>
						<tr>
							<th>Explanation</th>
							<td colspan="5">${result.infExp }</td>
						</tr>
						<tr>
							<th>URL</th>
							<td colspan="5" class="a_url">
								<a id="srcUrl" value="${result.srcUrl }">${result.srcUrl }</a>
<!-- 								<a href="#" class="btn02" name="a_copy">Copy</a> -->
								<button type="button" class="btn01" name="a_copy">Copy</button>
							</td>
							
						</tr>
					</c:when>
					<c:otherwise>
						<tr>
							<th>공공데이터명</th>
							<td colspan="5">${result.infNm }</td>
						</tr>
						<tr>
							<th>원본시스템</th>
							<td colspan="2"><a href="${result.srcUrl }">${result.srcExp }</a></td>
							<th>기관</th>
							<td colspan="2">${result.topOrgNm }
						</tr>
							<tr>
							<th>분류체계</th>
							<td colspan="5">${result.cateFullNm }
							</td>
						</tr>
						<tr>
							<th>적재주기</th>
							<td colspan="2">${result.loadNm }</td>
							<th>최초공개일자</th>
							<td colspan="2">${result.openDttm }</td>
						</tr>
						<tr>
							<th>설명</th>
							<td colspan="5">${result.infExp }</td>
						</tr>
						<th>URL</th>
							<td colspan="5" class="a_url">
								<a id="srcUrl" value="${result.infUrl }">${result.infUrl }</a>
<%-- 								<a id="srcUrl" value="${result.srcUrl }">${result.srcUrl }</a> --%>
<!-- 								<a href="#" class="btn01" name="a_copy">복사</a> -->
								<button type="button" class="btn01" name="a_copy">복사</button>
							</td>
						</tr>
						<tr>
							<th>기관</th>
							<td colspan="5">${result.topOrgNm }</td>
						</tr>
						<tr>
							<th>이용허락조건</th>
							<td colspan="5">${result.cclNm }</td>   
<!-- 							<td colspan="5"> -->
<!-- 								<div class="by"> -->
<!-- 								<img src="/img/icon_by01.gif" /> <strong>출처표시</strong><br/>출처표시, 상업적, 비상업적 이용가능, 변형 등 2차적 저작물 작성 가능</div> -->
<!-- 							</td> -->

						</tr>
													
						
							
				
					</c:otherwise>
					</c:choose>	
				</table>
								
			</div>
			</form>	
			</c:forEach>			
			<c:choose>
				<c:when test="${viewLang eq 'E' }">
					<div class="buttons">
						<a href="#" class="btn02" name="a_close">Close</a>
					</div>					
				</c:when>
				<c:otherwise>
					<div class="buttons">
						<a href="#" class="btn02" name="a_close">닫기</a>
					</div>					
				</c:otherwise>
			</c:choose>
			
			
		</div>		
	
	</div>
	
</body>
</html>

