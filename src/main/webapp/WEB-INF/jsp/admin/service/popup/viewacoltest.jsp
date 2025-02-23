<%@page import="java.net.URL"%>
<%@page import="java.net.HttpURLConnection"%>
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
<script type="text/javascript" src="<c:url value='/js/json2xml.js'/>"></script>
<style type="text/css">
body{background:none;} /* 임시로 해놓은 것임 */
.apiPre {
   margin: 10px 15px; border: 1px solid #e9e9e9; padding: 10px; height: 180px; background: #fcfcfc; text-align: left; word-spacing: 5px; overflow: auto;
}

</style>
</head>    
<script language="javascript">
var reqAddr;
//<![CDATA[                   
$(document).ready(function()    {
	inputSet();
});                                      
//]]>
var cnt=0;
function inputSet() {
	var formObj = $("form[name=OpenInfAColView]");              
	var apiRes = "${openInfSrv.apiRes}";
	$("#reqAddr").text($("#apiEp", opener.document).val() + "/" + apiRes);
	
	//한글보기
	$("#a_kr").click(function(e) { 
		formObj.find("input[name=viewLang]").val("");
		doAction("lang");
		return false;                             
	}); 
	//영어보기
	$("#a_en").click(function(e) { 
		formObj.find("input[name=viewLang]").val("E");
		formObj.find("input[name=popupUse]").val("Y");
		doAction("lang");
		return false;                             
	 }); 
	//탭클릭
	formObj.find("li[name=li01]").click(function() { cickTab(1, formObj);	});
	formObj.find("li[name=li02]").click(function() { cickTab(2, formObj);	});
	formObj.find("li[name=li03]").click(function() { cickTab(3, formObj);	});
	formObj.find("li[name=li04]").click(function() { cickTab(4, formObj);	});
	
	this.reqAddr = $("#reqAddr").text() + "?";
	formObj.find("td[name=reqAddrApiTest]").text(this.reqAddr);
	
	formObj.find("a[name=btn_apiTest]").click(function() {
		fncApiTest();
	});
	
	//xml 파싱 뷰어
    jQuery.parseXmlPreview = function(a,b,c) {
    		$.ajax(
    			{ url:a,type:"POST",dataType:b,success:function(res){var serializer=new XMLSerializer();var xmlText=serializer.serializeToString(res);xmlText=entityChange(xmlText);if(typeof c==="function"){return c(xmlText)}else{return window[c](xmlText)}}})
    }
	
}

function doAction(sAction) {
	var formObj = $("form[name=OpenInfAColView]");
	switch( sAction ) {
		case "lang":
			formObj.attr("action","<c:url value='/admin/service/openInfColViewPopUp.do'/>").submit();
			break;
	}
}

function cickTab(num, formObj) {
	for(var idx = 1; idx  < 5; idx++) {
		if(idx == num) {
			formObj.find("div[id=api0"+idx+"]").css("display", "block");
			formObj.find("a[name=li0"+idx+"a]").addClass("on");
		} else {
			formObj.find("div[id=api0"+idx+"]").css("display", "none");
			formObj.find("a[name=li0"+idx+"a]").removeClass("on");
		}
	}
}

function goUrl(url) {
	var wName = "url";
	var wWidth = "1024";
	var wHeight = "560";
	var wScroll ="no";
	OpenWindow(url, wName, wWidth, wHeight, wScroll);
}

/* jsonp방식에서 iframe 방식으로 변경
function fncUrlTest(url, gubun) {
	jQuery.support.cors = true;
	$.ajax({
		crossDomain : true ,
		type:'get',
		url : url,
		dataType : 'jsonp',
	    jsonpCallback : 'jsonpCallback',
		error : function(xhr, status, error) {
	     	alert("code : " + status + "\n" + error);
	    }
	}); 
}

function jsonpCallback(data) {
	//alert(JSON.stringify(data));
	//var jsonStr = JSON.stringify(data);
	var transJsonStr = json2xml(data);
	alert(transJsonStr);
	
}
 */

function getXmlContents(id) {
	var iframeDocument = document.getElementById(id).contentDocument;
	if ( iframeDocument == null )
		return undefined;
	var xmlContainer = iframeDocument.getElementById
} 
 
function fncSampleTest(url) {
	//$("#sampleUrlIfrm").attr("src", url);
	$("#apiSample").html("");
	$.parseXmlPreview(url, "xml", function(res){
		$("#apiSample").html(res);
	});
}

function fncApiTest() {
	var formObj = $("form[name=OpenInfAColView]");
	var apiListCnt = formObj.find("input[name=apiListCnt]").val();
	var apiTestUrl = "";
	var apiTestParam = "";
	if ( apiListCnt > 0 ) {
		apiTestUrl = reqAddr.replace("opentest.assembly.go.kr/portal/openapi/", "192.168.0.66:8080/portal/openapi/") + "type=xml&";
		for (var i=0; i<apiListCnt; i++  ) {
			if ( $("#apiListReqNeed_"+i).val() == "Y" ) {		//필수값 여부 체크
				if ( $("#apiVal_"+i).val() == "" & $("#apiVal option:selected").val() == undefined ) {		//필수 값 일경우 유효성 체크
					alert("<spring:message code='msg.searchReqIniput'/>"); return false;
				}
				apiTestParam += $("#reqCol_"+i).text() + "=" + encodeURIComponent($("#apiVal_"+i).val()) + "&";
			} else {
				if ( $("#apiVal_"+i).val() == "" & $("#apiVal option:selected").val() == undefined ) {		//필수는 아니지만 value값이 없는 경우는
					//not work						
				} else {
					apiTestParam += $("#reqCol_"+i).text() + "=" + encodeURIComponent($("#apiVal_"+i).val()) + "&";
				}
			}
		}
		apiTestParam = apiTestParam.substring(0, apiTestParam.length-1);	//끝에 '&' 빼려고..
	} else {
		apiTestUrl = reqAddr;
	}
	apiTestUrl = apiTestUrl + apiTestParam;
	formObj.find("td[name=reqAddrApiTest]").text(apiTestUrl);	//호출URL 표시
	//fncUrlTest(apiTestUrl, "TEST");
	//$("#apiTestIfrm").attr("src", apiTestUrl);	//iFrame 호출
	
	$("#apiTest").html("");
	$.parseXmlPreview(apiTestUrl, "xml", function(res){
		$("#apiTest").html(res);
	});
	
} 

function getIframeContent(id) {
	var ifrm = document.getElementById(id);
	return ifrm.contentWindow || ifrm.contentDocument;
}

function  fncGetDataCode(selectId, filtCd)
{	//open api테스트시 필터 조건이 기준정보에 있을 경우 selectBox 생성한다.
	var formObj = $("form[name=OpenInfAColView]");
	formObj.find("input[name=ditcCd]").val(filtCd);
	formObj.find("input[name=filtSelectId]").val(selectId);
	var url ="<c:url value='/admin/service/openInfAcolApiFiltVal.do'/>";
	var param = formObj.serialize();
	ajaxCallAdmin(url, param, dataCodeCallBack);
}

function dataCodeCallBack(data)
{	//fncGetDataCode 콜백함수
	var formObj = $("form[name=OpenInfAColView]");
	var selectId = formObj.find("input[name=filtSelectId]").val();
	var appendSelectFilt = "";
	for ( var i=0; i<data.filtCd.length; i++ ) {	
		appendSelectFilt += "<option value='"+data.filtCd[i].ditcCd+"'>["+data.filtCd[i].ditcCd+"]"+data.filtCd[i].ditcNm+"</option>";
	}
	$("#"+selectId).append(appendSelectFilt);
}

</script>              
</head>
<body onload="">
<div class="wrap-popup">
		<!-- 내용 -->
		<div class="container">
			<!-- 상단 타이틀 -->
			<div class="title">
				<!--
				<c:choose>
					<c:when test="${viewLang eq 'E'}">
						<h2>Preview - Link</h2>
					</c:when>
					<c:otherwise>         
						<h2>미리보기 - Link</h2>
					</c:otherwise>
				</c:choose>
				-->
				<h2>테스트 - Open API</h2>
			</div><div><label id="reqAddr" style="display:none;"></label></div>
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
			<form name="OpenInfAColView"  method="post" action="#">             
			<div class="content-popup">
				<input type="hidden" name="fileDownType" value=""/> 
				<input type="hidden" name="popupUse" value=""/> 
				<input type="hidden" name="infId" value="${openInfSrv.infId}"/>
				<input type="hidden" name="srvCd" value="${openInfSrv.srvCd}"/>
				<input type="hidden" name="viewLang" value=""/>
				<input type="hidden" name="ditcCd" value=""/>
				<input type="hidden" name="filtSelectId" value=""/>
				<input type="hidden" name="apiRes" value="${openInfSrv.apiRes}"/>                                  
				
				<table class="list01" style="display:none;">
					<caption>공공데이터목록리스트</caption>
					<colgroup>
						<col width="150"/>
						<col width=""/>
					</colgroup>
					<tr>
						<c:choose>
							<c:when test="${viewLang eq 'E'}">
								<th>Request Address</th>
							</c:when>
							<c:otherwise>         
								<th>요청 주소</th>
							</c:otherwise>
						</c:choose>
						<td><label id="reqAddr"></label></td>
					</tr>
					<tr>
						<c:choose>
							<c:when test="${viewLang eq 'E'}">
								<th>Default Parameter</th>
							</c:when>
							<c:otherwise>         
								<th>기본 인자</th>
							</c:otherwise>
						</c:choose>
						<td>
							<table class="list02">
								<colgroup>
									<col width="150"/>
									<col width="180"/>
									<col width="300"/>
									<col width="400"/>
								</colgroup>
								<c:choose>
									<c:when test="${viewLang eq 'E'}">
										<tr>
											<th>Variable Name</th>
											<th>Request Type</th>
											<th>Explanation</th>
											<th>Description</th>
										</tr>
										<tr>
											<td>Key</td>
											<td>STRING(Requied)</td>
											<td>API KEY</td>
											<td>Default Value : sample key</td>
										</tr>
										<tr>
											<td>Type</td>
											<td>STRING(Requied)</td>
											<td>Request document(xml, json)</td>
											<td>Default Value : XML</td>
										</tr>
										<tr>
											<td>pIndex</td>
											<td>INTEGER(Requied)</td>
											<td>Page place</td>
											<td>Default Value : 1(sample key = 1 Fix)</td>
										</tr>
										<tr>
											<td>pSize</td>
											<td>INTEGER(Requied)</td>
											<td>Page per Request count</td>
											<td>Default Value : 100(sample key = 5 Fix)</td>
										</tr>
									</c:when>
									<c:otherwise>         
										<tr>
											<th>변수명</th>
											<th>요청타입</th>
											<th>설명</th>
											<th>비고</th>
										</tr>
										<tr>
											<td>Key</td>
											<td>STRING(필수)</td>
											<td>인증키</td>
											<td>기본값 : sample key</td>
										</tr>
										<tr>
											<td>Type</td>
											<td>STRING(필수)</td>
											<td>호출 문서(xml, json)</td>
											<td>기본값 : XML</td>
										</tr>
										<tr>
											<td>pIndex</td>
											<td>INTEGER(필수)</td>
											<td>페이지 위치</td>
											<td>기본값 : 1(sample key는 1 고정)</td>
										</tr>
										<tr>
											<td>pSize</td>
											<td>INTEGER(필수)</td>
											<td>페이지 당 요청 숫자</td>
											<td>기본값 : 100(sample key는 5 고정)</td>
										</tr>
									</c:otherwise>
								</c:choose>
								
							</table>
						</td>
					</tr>
					<tr>
						<c:choose>
							<c:when test="${viewLang eq 'E'}">
								<th>Search Request Parameter</th>
							</c:when>
							<c:otherwise>         
								<th>검색 요청인자</th>
							</c:otherwise>
						</c:choose>
						
						<td>
							<table class="list02">
								<colgroup>
									<col width="200"/>
									<col width="200"/>
									<col width="200"/>
									<col width="500"/>
								</colgroup>
								<c:if test="${!empty reqVar}">
									<c:choose>
										<c:when test="${viewLang eq 'E'}">
											<tr>
												<th>Variable Name</th>
												<th>Request Type</th>
												<th colspan="2">Explanation</th>
												<!-- <th>Description</th> -->
											</tr>
										</c:when>
										<c:otherwise>
											<tr>
												<th>변수명</th>
												<th>요청타입</th>
												<th colspan="1">설명</th>
												<th colspan="1">예시</th>
											</tr>
										</c:otherwise>
									</c:choose>
									
									<c:forEach var="reqVar" items="${reqVar}" varStatus="status">
									<c:choose>
										<c:when test="${viewLang eq 'E'}">
											<tr>
												<td id="reqCol_${status.index }">${reqVar.colId }</td>
												<td>${reqVar.reqTypeEng }</td>
												<td colspan="1">${reqVar.colExpEng }</td>
												<td colspan="1">${reqVar.smpColExp }</td>
												<%-- <td>${reqVar.colExpEng }</td> --%>
											</tr>
										</c:when>
										<c:otherwise>         
											<tr>
												<td id="reqCol_${status.index }">${reqVar.colId }</td>
												<td>${reqVar.reqType }</td>
												<td colspan="1">${reqVar.colExp }</td>
												<td colspan="1">${reqVar.smpColExp }</td>
												<%-- <td>${reqVar.colExp }</td> --%>
											</tr>
										</c:otherwise>
									</c:choose>
									</c:forEach>
								</c:if>
								<c:if test="${empty reqVar}">
									<c:choose>
										<c:when test="${viewLang eq 'E'}">
											<tr><td colspan="5" style="border-color: #fff; ">Search request parameter Not found.</td></tr>
										</c:when>
										<c:otherwise>
											<tr><td colspan="5" style="border-color: #fff; ">검색 요청인자가 없습니다.</td></tr>
										</c:otherwise>
									</c:choose>
								</c:if>
							</table>
						</td>
					</tr>
				</table>
				
				
				<ul id="apiTab" class="tab-3rd" style="margin-bottom:20px;">
					<c:choose>
						<c:when test="${viewLang eq 'E'}">
							<li name="li01"><a name="li01a" href="#" class="on">Column Value</a></li>
							<li name="li02"><a name="li02a" href="#">Sample URL</a>	</li>
							<li name="li03"><a name="li03a" href="#">OpenAPI Test</a></li>
							<li name="li04"><a name="li04a" href="#">Result Message</a></li>
						</c:when>
						<c:otherwise>
							<li name="li01"><a name="li01a" href="#" class="on">출력값</a></li>
							<li name="li02"><a name="li02a" href="#">샘플URL</a>	</li>
							<li name="li03"><a name="li03a" href="#">Open API 테스트</a></li>
							<li name="li04"><a name="li04a" href="#">처리메세지</a></li>
						</c:otherwise>
					</c:choose>
					
				</ul>
				
				<div id="api01">
					<table class="list01 hor">
						<colgroup>
							<col width="40"/>
							<col width="200"/>
							<col width="200"/>
							<col width=""/>
						</colgroup>
						<tr>
							<th class="none">No</th>
							<c:choose>
								<c:when test="${viewLang eq 'E'}">
									<th>Column ID</th>
									<th>Column Name</th>
									<th>Column Description</th>
								</c:when>
								<c:otherwise>
									<th>항목ID</th>
									<th>항목명</th>
									<th>설명</th>
								</c:otherwise>
							</c:choose>
						</tr>
						<c:forEach var="printVal" items="${printVal}" varStatus="status">
						<tr>
							<td>${status.index+1 }</td>
							<td>${printVal.colId }</td>
							<c:choose>
								<c:when test="${viewLang eq 'E'}">
									<td>${printVal.colNmEng }</td>
									<td>${printVal.colExpEng }</td>
								</c:when>
								<c:otherwise>
									<td>${printVal.colNm }</td>
									<td>${printVal.colExp }</td>
								</c:otherwise>
							</c:choose>
						</tr>
						</c:forEach>
					</table>
				</div>
				
				<div id="api02" style="display:none; ">
					<table class="list01 hor">
						<colgroup>
							<col width="40"/>
							<col width=""/>
							<col width=""/>
							<col width=""/>
						</colgroup>
						<tr>
							<th class="none">No</th>
							<c:choose>
								<c:when test="${viewLang eq 'E'}">
									<th>URI Name</th>
									<th colspan="2">URI</th>
								</c:when>
								<c:otherwise>
									<th>URI명</th>
									<th colspan="2">주소</th>
								</c:otherwise>
							</c:choose>
						</tr>
						<c:forEach var="sampleUri" items="${sampleUri}" varStatus="status">
						<tr>
							<td>${status.index+1 }</td>
							<c:choose>
								<c:when test="${viewLang eq 'E'}">
									<td>${sampleUri.uriNmEng }</td>
								</c:when>
								<c:otherwise>
									<td>${sampleUri.uriNm }</td>
								</c:otherwise>
							</c:choose>
							<td colspan="2"><a href="#" onclick="fncSampleTest('${sampleUri.uriFull }')">${sampleUri.uriFull }</a></td>
							<%-- <td colspan="2"><a href="${sampleUri.uriFull }" target="sampleUrlIfr">${sampleUri.uriFull }</a></td> --%>
						</tr>
						</c:forEach>
						<tr><td>결과</td><td>※ URL을 클릭하면 결과를 확인할 수 있습니다.</td><td style="height: 200px;" colspan="2"><pre class="apiPre" id="apiSample"></pre></td></tr>
					</table>
					<!-- 
					<div style="min-height:400px;overflow:hidden;word-break:break-all;" id="sampleTest">
						<iframe id="sampleUrlIfrm" name="sampleUrlIfrm" width="98%" height="350px" frameborder="0" scrolling="auto"  style="margin:0;padding:5px;" title="출력결과"></iframe>
					</div> -->
				</div>                       
				
				<div id="api03" style="display:none; ">
					<div style="float: right"><a href='#' class='btn02' name='btn_apiTest'>조회</a></div>
					<table class="list01 hor">
						<colgroup>
							<col width=""/>
							<col width=""/>
							<col width=""/>
							<col width=""/>
						</colgroup>
						<tr>
							<c:choose>
								<c:when test="${viewLang eq 'E'}">
									<th class="none" colspan="5">Open API Test</th>
								</c:when>
								<c:otherwise>
									<th class="none" colspan="5">Open API 테스트</th>
								</c:otherwise>
							</c:choose>
						</tr>
						
						
						<c:forEach var="apiList" items="${apiList}" varStatus="status">
						<tr>
							<c:if test="${!empty apiList }">
									<input type="hidden" id="apiListReqNeed_${status.index }" value="${apiList.reqNeedYn }"/>
									<c:choose>
										<c:when test="${viewLang eq 'E'}">
											<td>＊ ${apiList.colId }${apiList.reqNeedEng }</td>
										</c:when>
										<c:otherwise>
											<td>＊ ${apiList.colId }${apiList.reqNeed }</td>
										</c:otherwise>
									</c:choose>
									<td colspan="4">
									<c:choose>
										<c:when test="${viewLang eq 'E'}">
											<c:choose>
												<c:when test="${apiList.useFiltCode eq 'Y'}">
													<select id="apiVal_${status.index }">
														<option value="">select</option>
														<c:if test="${apiList.filtCode eq 'D1008' }">
															<c:forEach var="code" items="${codeMap.useAgreeCd}" varStatus="status">
																	<option value="${code.ditcCd}">${code.ditcNmEng}</option>
															</c:forEach>
														</c:if>
														<c:if test="${apiList.filtCode eq 'D1009' }">
															<c:forEach var="code" items="${codeMap.carryPeriodCd}" varStatus="status">
																	<option value="${code.ditcCd}">${code.ditcNmEng}</option>
															</c:forEach>
														</c:if>
													</select>
												</c:when>  
												<c:otherwise>
													<input type="text" id="apiVal_${status.index }" style="width:300px;"/>
												</c:otherwise>
											</c:choose>
										</c:when>
										<c:otherwise>
											<c:choose>
												<c:when test="${apiList.useFiltCode eq 'Y'}">
													<select id="apiVal_${status.index }">
														<option value="">선택</option>
														<script>
															fncGetDataCode("apiVal_${status.index }", "${apiList.filtCode }");
														</script>
														<%-- 
														<c:if test="${apiList.filtCode eq 'D1008' }">
															<c:forEach var="code" items="${codeMap.useAgreeCd}" varStatus="status">
																	<option value="${code.ditcCd}">${code.ditcNm}</option>
															</c:forEach>
														</c:if>
														<c:if test="${apiList.filtCode eq 'D1009' }">
															<c:forEach var="code" items="${codeMap.carryPeriodCd}" varStatus="status">
																	<option value="${code.ditcCd}">${code.ditcNm}</option>
															</c:forEach>
														</c:if>
														 --%>
													</select>
												</c:when>
												<c:otherwise>
													<input type="text" id="apiVal_${status.index }" style="width:300px;"/>
												</c:otherwise>
											</c:choose>
										</c:otherwise>
									</c:choose>
									</td>
							</c:if>
						</tr>
						</c:forEach>
						<input type="hidden" name="apiListCnt" value="${apiListCnt }" />
						
						<tr>
							<c:choose>
								<c:when test="${viewLang eq 'E'}">
									<td>▷ Request Address</td>
								</c:when>
								<c:otherwise>
									<td>▷ 요청주소</td>
								</c:otherwise>
							</c:choose>
							<td colspan="4" name="reqAddrApiTest"></td>
						</tr>	
						<tr><td>API 결과</td><td style="height: 200px;" colspan="4"><pre class="apiPre" id="apiTest"></pre></td></tr>					
					</table>
					<!-- 
					<div style="min-height:400px;overflow:hidden;word-break:break-all;" id="apiTest">
						<iframe id="apiTestIfrm" name="apiTestIfrm" width="98%" height="350px" frameborder="0" scrolling="auto"  style="margin:0;padding:5px;" title="출력결과"></iframe>
					</div> -->	
				</div>
				
				<div id="api04" style="display:none; ">
					<table class="list01 hor">
						<colgroup>
							<col width="40"/>
							<col width="150"/>
							<col width="150"/>
							<col width=""/>
						</colgroup>
						<tr>
							<th class="none">No</th>
							<c:choose>
								<c:when test="${viewLang eq 'E'}">
									<th>Message Type</th>
									<th>Message Code</th>
									<th>Message Description</th>
								</c:when>
								<c:otherwise>
									<th>메세지 구분</th>
									<th>메세지 코드</th>
									<th>메시지 설명</th>
								</c:otherwise>
							</c:choose>
							
						</tr>
						<c:forEach var="resultMsg" items="${resultMsg}" varStatus="status">
						<tr>
							<td>${status.index+1 }</td>
							<td>${resultMsg.msgTag }</td>
							<td>${resultMsg.msgCd }</td>
							<c:choose>
								<c:when test="${viewLang eq 'E'}">
									<td>${resultMsg.msgExpEng }</td>
								</c:when>
								<c:otherwise>
									<td>${resultMsg.msgExp }</td>
								</c:otherwise>
							</c:choose>
							
						</tr>
						</c:forEach>
					</table>
				</div>
			</div>
			</form>
			
			<div class="buttons">  
				<!--
				<c:choose>
					<c:when test="${viewLang eq 'E'}">
						<a href='#' class='btn02' name='a_close' onclick="javascript: window.close();">Close</a>       
					</c:when>
					<c:otherwise>         
						<a href='#' class='btn02' name='a_close' onclick="javascript: window.close();">닫기</a>       
					</c:otherwise>        
				</c:choose>
				-->
				<a href='#' class='btn02' name='a_close' onclick="javascript: window.close();">닫기</a>
			</div>	
		</div>		
	</div>
</html>