<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="egovframework.common.WiseOpenConfig"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>  
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>       
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><spring:message code='wiseopen.title'/></title>                  
<c:import  url="/WEB-INF/jsp/inc/headinclude.jsp"/>
</head>                                                
<style type="text/css">
body{background:none;}
a{text-decoration:none; color:#000000;}         
a:hover{color:#ff0000;}        

ul {
    list-style:square inside;
    margin:2px;
    padding:0;
}

li {
    margin: 0 20px 2px 0;
    padding: 7px 7px 0 0;
    border : 0;
    float: left;
}
</style>                  
<script language="javascript">       

$(function() {
	// 컴포넌트를 초기화한다.
    initComp();
 	
	// 이벤트를 바인딩한다.
    bindEvent();
	
 	// 옵션을 로드한다.
    loadOptions();
 	
    // 데이터를 로드한다.
    loadData();
});

////////////////////////////////////////////////////////////////////////////////
//글로벌 변수
////////////////////////////////////////////////////////////////////////////////
var ctxPath = '<c:out value="${pageContext.request.contextPath}" />';

////////////////////////////////////////////////////////////////////////////////
//초기화 함수
////////////////////////////////////////////////////////////////////////////////

/**
 * 컴포넌트를 초기화한다.
 */
function initComp() {
	
}


/**
 * 이벤트를 바인딩한다.
 */
function bindEvent() {
	
	//이의신청서 출력
	$("a[name=printObjtnBtnA]").bind("click", function(event) {
		infoPrint("objtn");
	});
	
	//이의신청 결정기간 연장통지서 출력
	$("a[name=printObjtnExtBtnA]").bind("click", function(event) {
		infoPrint("objtnExt");
	});
	
	//팝업창 닫기
	$("a[name=a_close]").bind("click", function(event) {
		window.close();
	});
	
	//청구서 상세
	$("a[name=aplBtnA]").bind("click", function(event) {
		goOpnAplPopup();
	});
	
	//결정내역 이동
	$("a[name=dcsBtnA]").bind("click", function(event) {
		goOpnDcsPopup();
	});
	

	//신청서 목록이동
	$("a[name=aplListBtnA]").bind("click", function(event) {
		goOpnAplListPopup();
	});
	
}

/**
 * 옵션을 로드한다.
 */
function loadOptions() {
}

/**
 * 데이터를 로드한다.
 */
function loadData() {
	
}



////////////////////////////////////////////////////////////////////////////////
//Validation 함수
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
//기타 함수
////////////////////////////////////////////////////////////////////////////////

//출력 및 저장
function infoPrint(div){
	var formPrint = $("form[name=printForm]");
	
	var aplNo = $("input[name=aplNo]").val();
	var objtnSno = $("input[name=objtnSno]").val();
	
	//formPrint.find("input[name=mrdParam]").val("/rp ["+aplNo+"] [" + objtnSno + "]" ;
	//통합테스트용
	formPrint.find("input[name=mrdParam]").val("/rp [19010092] [87]" ;
	
	if(div == "objtn"){
		
		formPrint.find("input[name=width]").val("680");
		formPrint.find("input[name=height]").val("700");
		formPrint.find("input[name=title]").val("정보공개 이의신청서 출력");
		
		window.open("","popup","width=680, height=700, resizable=yes, location=no;");
		
		/* 이의신청의 취지 및 이유 확인 로직 추가 > 이의신청서의 이의신청의 취지 및 이유에 맞지 않을 경우(초과) 별지참조 처리*/
		var tArea = $("textarea[name=printObjtnRson]").val(); //이의신청의 취지 및 이유 - 출력용
		var totLine = chkTotLine(tArea);
		if(totLine > 10){ //이의신청서의 이의신청의 취지 및 이유 최대 10줄
			formPrint.attr("action", com.wise.help.url("/admin/expose/infoPrintPage/printNewObjtnRefer.do"));
		}else{
			formPrint.attr("action", com.wise.help.url("/admin/expose/infoPrintPage/printNewObjtn.do"));
		}
	}else if(div == "objtnExt"){
		
		formPrint.find("input[name=width]").val("680");
		formPrint.find("input[name=height]").val("700");
		formPrint.find("input[name=title]").val("정보공개 이의신청 결정기간 연장 통지서 출력");
		
		window.open("","popup","width=680, height=700, resizable=yes, location=no;");
		
		formPrint.attr("action", com.wise.help.url("/admin/expose/infoPrintPage/printNewObjtnExt.do"));
	}
	formPrint.attr("target", "popup");
	formPrint.submit();
}

function fileDownLoad(fileNm, filePath) {
	
	var params = "?fileNm="+ fileNm + "&filePath="+filePath;
	$("iframe[id=download-frame]").attr("src", com.wise.help.url("/admin/expose/downloadOpnAplFile.do") + params);
}
//청구서 조회 이동
function goOpnAplPopup() {
	
	var form = $("form[name=objtnForm]");
	
	form.attr("action", com.wise.help.url("/admin/expose/popup/viewOpnAplPopup.do"));
	form.attr("target", "_self");
	form.submit();
}

//결정통지서
function goOpnDcsPopup () {
	var form = $("form[name=objtnForm]");
	
	form.attr("action", com.wise.help.url("/admin/expose/popup/viewOpnDcsPopup.do"));
	form.attr("target", "_self");
	form.submit();
}
//신청서목록 이동
function goOpnAplListPopup () {
	var form = $("form[name=objtnForm]");
	
	form.attr("action", com.wise.help.url("/admin/expose/popup/searchOpnAplPopup.do"));
	form.attr("target", "_self");
	form.submit();
}

</script>                
<body>
<div class="popup">
	<h3>이의신청 접수</h3>
	<div id="div-sect" style="padding:15px;">
		<form name="objtnForm" method="post" action="">
			<input type="hidden" name="aplNo" id="aplNo" value="${opnObjtnDo.aplNo }" />
			<input type="hidden" name="objtnSno" id="objtnSno" value="${opnObjtnDo.objtnSno }" />
			<input type="hidden" name="aplDealInstCd" id="aplDealInstCd" value="${opnObjtnDo.aplDealInstCd }" />
	
			<div class="buttons">
				<a href="javascript:;" class="btn02" title="청구서바로가기" name="aplBtnA">청구서바로가기</a>
				<a href="javascript:;" class="btn02" title="결정내역" name="dcsBtnA">결정내역</a>
				<a href="javascript:;" class="btn02" title="목록" name="aplListBtnA">목록</a> 
			</div>
	
			<h2 class="text-title2">신청인 정보</h2>
			<div>
				<table class="list01">
					<caption>이의신청 접수</caption>
					<colgroup>
						<col style="width:150px;">
						<col>
						<col style="width:120px;">
						<col style="width:240px;">
					</colgroup>
					<tbody>
						<tr>
							<th>접수번호</th>
							<td>
								<input maxlength="8" type="hidden" name="rcpNo" id="rcpNo" value="${opnObjtnDo.rcpNo }" />
								<input maxlength="8" type="text" name="rcpDtsNo" id="rcpDtsNo" value="${opnObjtnDo.rcpDtsNo }" />
							</td>
							<th>접수일자</th>
							<td>
								<c:choose>
									<c:when test="${opnObjtnDo.objtnStatCd eq '01' }">
										<input readonly="readonly" type="text" name="objtnDt" id="objtnDt" value="${opnObjtnDo.objDt }" />
									</c:when>
									<c:otherwise>
										<input readonly="readonly" type="text" name="objtnDt" id="objtnDt" value="${opnObjtnDo.rcpDt }" />
									</c:otherwise>
								</c:choose>
							</td>
						</tr>
						<tr>
							<th>이름</th>
							<td>
								<c:out value="${opnObjtnDo.aplPn }" escapeXml="true"></c:out>
							</td>
							<!-- <th>주민등록번호<br>(외국인번호)</th> -->
							<th>생년월일</th>
							<td>
								<c:out value="${opnObjtnDo.aplRno1 }" escapeXml="true"></c:out>
							</td>
						</tr>
						<tr>
							<th>법인명 등 대표자</th>
							<td>
								<c:out value="${opnObjtnDo.aplCorpNm }" escapeXml="true"></c:out>
							</td>
							<th>사업자등록번호</th>
							<td>${opnObjtnDo.aplBno }</td>
						</tr>
						<tr>
							<th rowspan="2">주소</th>
							<td rowspan="2">
								(<c:out value="${opnObjtnDo.aplZpno }" />)&nbsp;
								<c:out value="${opnObjtnDo.apl1Addr }" />&nbsp;
								<c:out value="${opnObjtnDo.apl2Addr }" escapeXml="true" />
							</td>
							<th>전화번호</th>
							<td>${opnObjtnDo.aplPno }</td>
						</tr>
						<tr>
							<th>모사전송번호</th>
							<td>${opnObjtnDo.aplFaxNo }</td>
						</tr>
						<tr>
							<th>전자우편</th>
							<td>
								<c:out value="${opnObjtnDo.aplEmail }" escapeXml="true"></c:out>
							</td>
							<th>휴대전화번호</th>
							<td>${opnObjtnDo.aplMblPno }</td>
						</tr>
					</tbody>
				</table>
			</div>
			<h2 class="text-title2">신청내역</h2>
			<div>
				<table class="list01">
					<caption>이의신청 접수내역</caption>
					<colgroup>
						<col style="width:150px;">
					</colgroup>
					<tbody>
						<tr>
							<th>비공개 사유</th>
							<td>
								<c:out value="${opnObjtnDo.clsdRmk }" escapeXml="true"></c:out>
							</td>
						</tr>
						<tr>
							<th>공개 또는<br>비공개 내용</th>
							<td>
								<c:choose>
									<c:when test="${empty opnObjtnDo.opbYn }">
										해당 없음
									</c:when>
									<c:otherwise>
										<c:out value="${opnObjtnDo.opbCn }" escapeXml="true"></c:out>
									</c:otherwise>
								</c:choose>
							</td>
						</tr>
						<tr>
							<th>통지서 수령유무</th>
							<td>
								<c:choose>
									<c:when test="${opnObjtnDo.objtnNtcsYn eq '0' }">
										정보(공개,부분공개,비공개)결정통지서를 ${opnObjtnDo.dcsNtcDt } 에 받았음.
									</c:when>
									<c:otherwise>
										정보(공개,부분공개,비공개)결정통지서를 받지 못했음<br>
										(법 제11조제5항의 규정에 의하여 비공개 결정이 있는것으로 보는날은 ${opnObjtnDo.dcsNtcDt } 임.
									</c:otherwise>
								</c:choose>
							</td>
						</tr>
						<tr>
							<th>이의신청의 <br>취지 및 이유</th>
							<td>
								<c:out value="${opnObjtnDo.objtnRson }" escapeXml="true"></c:out>
							</td>
						</tr>
						<tr>
							<th>첨부문서</th>
							<td>
								<c:if test="${!empty opnObjtnDo.objtnAplFlNm }">
									<a href="#" style="text-decoration:none;" onclick="fileDownLoad('${opnObjtnDo.objtnAplFlNm}','${opnObjtnDo.objtnAplFlPh}');">
										<img src="/images/admin/icon_file.png" style="padding-right:4px;" alt="첨부파일">
										<span style="color:#666;">${opnObjtnDo.objtnAplFlNm}</span>
									</a>	
								</c:if>
							</td>
						</tr>
						<tr>
							<th>처리기관</th>
							<td>${opnObjtnDo.aplDealInstNm }</td>
						</tr>
					</tbody>
				</table>
			</div>
	
		</form>
		<div class="buttons">
			<a href="javascript:;" class="btn02" title="신청서출력" name="printObjtnBtnA">신청서출력</a>
			<c:if test="${opnObjtnDo.objtnStatCd eq '04' }">	
			<a href="javascript:;" class="btn02" title="연장통지서출력" name="printObjtnExtBtnA">연장통지서출력</a>
			</c:if>
		</div>
	
	</div>
	<form name="printForm" method="post">
	    <input type="hidden" name="mrdParam" value=""/>
		<input type="hidden" name="width" value=""/>
		<input type="hidden" name="height" value=""/>
		<input type="hidden" name="title" value=""/>
	</form>
	
</div>
<iframe id="download-frame" name="download-frame"  title="다운로드 처리" height="0" style="width:100%; display:none;"></iframe>
</body>

</html>                          