<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="egovframework.common.WiseOpenConfig"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>  
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>      
<%pageContext.setAttribute("CR", "\r");%> 
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
	
	//청구서 출력
	$("a[name=printAplBtnA]").bind("click", function(event) {
		infoPrint("apl");
	});
	
	//접수증 출력
	$("a[name=printRcpBtnA]").bind("click", function(event) {
		infoPrint("rcp");
	});
	
	//결정기한연장통지서
	$("a[name=printExtBtnA]").bind("click", function(event) {
		infoPrint("ext");
	});
	//부존재 등 통지서 출력
	$("a[name=printNonBtnA]").bind("click", function(event) {
		infoPrint("non");
	});
	
	//결정통지서
	$("a[name=printDcsBtnA]").bind("click", function(event) {
		infoPrint("dcs");
	});;
	
	//팝업창 닫기
	$("a[name=a_close]").bind("click", function(event) {
		window.close();
	});
	
	//결정내역 이동
	$("a[name=dcsBtnA]").bind("click", function(event) {
		goOpnDcsPopup();
	});
	
	//이의신청내역 이동
	$("a[name=objTnBtnA]").bind("click", function(event) {
		goOpnObjtnPopup();
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
	formPrint.find("input[name=mrdParam]").val("/rp ["+aplNo+"]") ;
	
	if(div == "apl"){
		formPrint.find("input[name=mrdParam]").val( "/rp ["+aplNo+"] [1]") ;
		formPrint.find("input[name=width]").val("680");
		formPrint.find("input[name=height]").val("700");
		formPrint.find("input[name=title]").val("정보공개 청구서 출력");		
		window.open("","popup","width=680, height=700, resizable=yes, location=no;");

	<c:choose>
        <c:when test="${opnAplDo.callVersion eq 'V1'}">
        	formPrint.attr("action", com.wise.help.url("/admin/expose/infoPrintPage/printOpnapl.do"));
        </c:when>
        <c:otherwise>
			/* 청구내용 확인 로직 추가 > 정보공개 청구서의 청구내용에 맞지 않을 경우(초과) 별지참조 처리*/
			var tArea = $("textarea[name=printAplModDtsCn]").val(); //청구내용 - 출력용
			var totLine = chkTotLine(tArea);
			if(totLine > 15){ //정보공개 청구서의 청구내용은 최대 15줄
				formPrint.attr("action", com.wise.help.url("/admin/expose/infoPrintPage/printNewOpnaplRefer.do"));
			}else{
				formPrint.attr("action", com.wise.help.url("/admin/expose/infoPrintPage/printNewOpnapl.do"));
			}
        </c:otherwise>
    </c:choose>    

	}else if(div == "rcp"){
		formPrint.find("input[name=width]").val("680");
		formPrint.find("input[name=height]").val("500");
		formPrint.find("input[name=title]").val("접수증 출력");		
		window.open("","popup","width=680, height=500");

	<c:choose>
        <c:when test="${opnAplDo.callVersion eq 'V1'}">
        	formPrint.attr("action", com.wise.help.url("/admin/expose/infoPrintPage/printOpnrcp.do"));
        </c:when>
        <c:otherwise>
        	formPrint.attr("action", com.wise.help.url("/admin/expose/infoPrintPage/printNewOpnrcp.do"));
        </c:otherwise>
    </c:choose>    
		
	}else if(div == "dcs"){		
		formPrint.find("input[name=width]").val("680");
		formPrint.find("input[name=height]").val("700");
		formPrint.find("input[name=title]").val("정보공개 결정통지서 출력");		
		window.open("","popup","width=680, height=700, resizable=yes, location=no;");

	<c:choose>
        <c:when test="${opnAplDo.callVersion eq 'V1'}">
        	formPrint.attr("action", com.wise.help.url("/admin/expose/infoPrintPage/printOpndcs.do"));
        </c:when>
        <c:otherwise>
			/* 청구내용 확인 로직 추가 > 결정통지서의 정보공개청구내용에 맞지 않을 경우(초과) 별지참조 처리*/
			var tArea = $("textarea[name=printAplModDtsCn]").val(); //청구내용 - 출력용
			var totLine = chkTotLine(tArea);
			/* 비공개 내용 및 사유 확인 로직 추가 > 결정통지서의 비공개 내용 및 사유에 맞지 않을 경우(초과) 별지참조 처리*/
			var tClsdArea = $("textarea[name=printClsdRmk]").val(); //비공개사유 - 출력용
			var totClsdLine = chkTotLine(tClsdArea);
			if(totLine > 8 && totClsdLine > 4){ //결정통지서의 정보공개청구내용은 최대 8줄, 비공개 내용 및 사유는 최대 4줄
				formPrint.attr("action", com.wise.help.url("/admin/expose/infoPrintPage/printNewOpndcsRefer3.do"));
			}else{
				if(totClsdLine > 4){
					formPrint.attr("action", com.wise.help.url("/admin/expose/infoPrintPage/printNewOpndcsRefer2.do"));
				}else if(totLine > 8){
					formPrint.attr("action", com.wise.help.url("/admin/expose/infoPrintPage/printNewOpndcsRefer1.do"));
				}else{			
					formPrint.attr("action", com.wise.help.url("/admin/expose/infoPrintPage/printNewOpndcs.do"));
				}
			}
        </c:otherwise>
    </c:choose>    
    
	}else if(div == "trsf"){
		formPrint.find("input[name=width]").val("680");
		formPrint.find("input[name=height]").val("700");
		formPrint.find("input[name=title]").val("이송통지서 출력");		
		window.open("","popup","width=680, height=700, resizable=yes, location=no;");

	<c:choose>
        <c:when test="${opnAplDo.callVersion eq 'V1'}">
        formPrint.attr("action", com.wise.help.url("/admin/expose/infoPrintPage/printOpntrn.do"));
        </c:when>
        <c:otherwise>
			/* 청구내용 확인 로직 추가 > 정보공개 청구서 기관이송 통지서의 청구정보내용에 맞지 않을 경우(초과) 별지참조 처리*/
			var tArea = $("textarea[name=printAplModDtsCn]").val(); //청구내용 - 출력용
			var totLine = chkTotLine(tArea);
			if(totLine > 9){ //정보공개 청구서 기관이송 통지서의 청구정보내용은 최대 9줄
				formPrint.attr("action", com.wise.help.url("/admin/expose/infoPrintPage/printNewOpntrnRefer.do"));
			}else{
				formPrint.attr("action", com.wise.help.url("/admin/expose/infoPrintPage/printNewOpntrn.do"));
			}
        </c:otherwise>
    </c:choose> 
    
	}else if(div == "non"){		
		formPrint.find("input[name=mrdParam]").val( "/rp ["+aplNo+"] [1]") ;
		formPrint.find("input[name=width]").val("680");
		formPrint.find("input[name=height]").val("700");
		formPrint.find("input[name=title]").val("정보공개 결정통지서 출력");		
		window.open("","popup","width=680, height=700, resizable=yes, location=no;");

	<c:choose>
        <c:when test="${opnAplDo.callVersion eq 'V1'}">
        	formPrint.attr("action", com.wise.help.url("/admin/expose/infoPrintPage/printNonext.do"));
        </c:when>
        <c:otherwise>
			/* 청구내용 확인 로직 추가 > 정보 부존재 등 통지서의 정보공개청구내용에 맞지 않을 경우(초과) 별지참조 처리*/
			var tArea = $("textarea[name=printAplModDtsCn]").val(); //청구내용 - 출력용
			var totLine = chkTotLine(tArea);
			if(totLine > 11){ //정보 부존재 등 통지서의 정보공개청구내용은 최대 11줄
				formPrint.attr("action", com.wise.help.url("/admin/expose/infoPrintPage/printNewNonextRefer.do"));
			}else{
				formPrint.attr("action", com.wise.help.url("/admin/expose/infoPrintPage/printNewNonext.do"));
			}
        </c:otherwise>
    </c:choose> 
    

	}else if(div == "ext"){
		formPrint.find("input[name=mrdParam]").val( "/rp ["+aplNo+"] [1]") ;
		formPrint.find("input[name=width]").val("680");
		formPrint.find("input[name=height]").val("700");
		formPrint.find("input[name=title]").val("정보공개 결정기간 연장통지서 출력");		
		window.open("","popup","width=680, height=700, resizable=yes, location=no;");

	<c:choose>
        <c:when test="${opnAplDo.callVersion eq 'V1'}">
        	formPrint.attr("action", com.wise.help.url("/admin/expose/infoPrintPage/printOpnext.do"));
        </c:when>
        <c:otherwise>
			/* 청구내용 확인 로직 추가 > 공개 여부 결정기간 연장 통지서의 정보공개청구내용에 맞지 않을 경우(초과) 별지참조 처리*/
			var tArea = $("textarea[name=printAplModDtsCn]").val(); //청구내용 - 출력용
			var totLine = chkTotLine(tArea);
			if(totLine > 8){ //공개 여부 결정기간 연장 통지서의 정보공개청구내용은 최대 8줄
				formPrint.attr("action", com.wise.help.url("/admin/expose/infoPrintPage/printNewOpnextRefer.do"));
			}else{
				formPrint.attr("action", com.wise.help.url("/admin/expose/infoPrintPage/printNewOpnext.do"));
			}
        </c:otherwise>
    </c:choose>

	}
	formPrint.attr("target", "popup");
	formPrint.submit();
}

//첨부파일 다운로드
function fileDownLoad(fileNm, filePath) {
	
	var params = "?fileNm="+ fileNm + "&filePath="+filePath;
	$("iframe[id=download-frame]").attr("src", com.wise.help.url("/admin/expose/downloadOpnAplFile.do") + params);
}

//결정내역 이동
function goOpnDcsPopup () {
	var form = $("form[name=opnAplForm]");
	
	form.attr("action", com.wise.help.url("/admin/expose/popup/viewOpnDcsPopup.do"));
	form.attr("target", "_self");
	form.submit();
}

//이의신청내역 이동
function goOpnObjtnPopup () {
	var form = $("form[name=opnAplForm]");
	
	form.attr("action", com.wise.help.url("/admin/expose/popup/viewOpnObjtnPopup.do"));
	form.attr("target", "_self");
	form.submit();
}

//신청서목록 이동
function goOpnAplListPopup () {
	var form = $("form[name=opnAplForm]");
	
	form.attr("action", com.wise.help.url("/admin/expose/popup/searchOpnAplPopup.do"));
	form.attr("target", "_self");
	form.submit();
}

//국회사무처 정보공개청구 양식파일 다운로드
function fn_utilFileDownload(fileGb){
	var dfrm = document.dForm;
	if(fileGb == '1'){
		dfrm.fileName.value = "AdbeRdr1010_mui_Std.zip";
		dfrm.filePath.value = "AdbeRdr1010_mui_Std.zip";
	}else if(fileGb == '2'){
		dfrm.fileName.value = "e-timing_VISUAL_TS_Verifier_for_Adobe_Reader_9,X,XI,DC(v4.6.8).exe";
		dfrm.filePath.value = "e-timing_VISUAL_TS_Verifier_for_Adobe_Reader_9,X,XI,DC(v4.6.8).exe";
	}else if(fileGb == '3'){
		dfrm.fileName.value = "vcredist_x86.exe";
		dfrm.filePath.value = "vcredist_x86.exe";
	}else if(fileGb == '4'){
		dfrm.fileName.value = "manual.pdf";
		dfrm.filePath.value = "manual.pdf";
	}
	dfrm.action = "/portal/exposeInfo/downloadBasicFile.do";
	dfrm.submit();
}

/**
 * 내용의 줄수 확인(RD 출력 확인)
 * @param str
 * @retruns
 */
function chkTotLine(tArea){
	var tAreaLine = tArea.split("\n");
	var totLine = 0;
	for(var li=0; li<tAreaLine.length; li++){
		var liData = tAreaLine[li];
		var dataLength = liData.length;
		if(liData.length> 50){
			var arrChkData = tAreaLine[li].match(new RegExp('.{1,50}', 'g'));
			totLine += arrChkData.length;
		}else{
			totLine++;
		}
	}
	return totLine;
}
</script>                
<body>
<div class="popup">
	<h3>청구서조회</h3>
	<div id="div-sect" style="padding:15px;">
	<form name="opnAplForm" method="post" action="#">
	 	<input type="hidden" name="aplNo" value="${opnAplDo.aplNo}" />
	 	<input type="hidden" name="aplDealInstCd" value="${opnAplDo.aplDealInstCd }" />
	 	<input type="hidden" name="objtnSno" value="${opnAplDo.objtnSno }" />
	 	
		<div class="buttons">
			<a href="javascript:;" class="btn02" title="결정내역" name="dcsBtnA">결정내역</a>
			<c:if test="${!empty opnAplDo.objtnDt }">
			<a href="javascript:;" class="btn02" title="이의신청바로가기" name="objTnBtnA">이의신청바로가기</a>	
			</c:if>
			<a href="javascript:;" class="btn02" title="목록" name="aplListBtnA">목록</a> 
		</div>
		<h2 class="text-title2">청구인 정보</h2>
		<div>
			<table class="list01">
				<caption>청구신청정보</caption>
				<colgroup>
					<col style="width:150px;">
					<col>
					<col style="width:120px;">
					<col style="width:240px">
				</colgroup>
				<tbody>
					<tr>
						<th>이름</th>
						<td>
							<c:out value="${opnAplDo.aplPn }" />
						</td>
						<!-- <th>주민등록번호<br />(외국인번호)</th> -->
						<th>생년월일</th>
						<td>
							<c:out value="${opnAplDo.aplRno1}" />
						</td>
					</tr>
					<tr>
						<th>휴대전화번호</th>
						<td>
							<c:out value="${opnAplDo.aplMblPno }" />
						</td>
						<th>전화번호</th>
						<td>
							<c:out value="${opnAplDo.aplPno }" />
						</td>
					</tr>
					<tr>
						<th>모사전송번호</th>
						<td>
							<c:out value="${opnAplDo.aplFaxNo }" />
						</td>
						<th>전자우편번호</th>
						<td>
							<c:out value="${opnAplDo.aplEmailAddr }" />
						</td>
					</tr>
					<tr>
						<th>주소(소재지)</th>
						<td colspan="3">
							(<c:out value="${opnAplDo.aplZpno }" />)&nbsp;
							<c:out value="${opnAplDo.apl1Addr }" />&nbsp;
							<c:out value="${opnAplDo.apl2Addr }" escapeXml="true" />
						</td>
					</tr>
				</tbody>
			</table>
		</div>
		<h2 class="text-title2">청구 내역</h2>
		<div>
			<table class="list01">
				<caption>청구신청정보</caption>
				<colgroup>
					<col style="width:70px;">
					<col style="width:80px;">
					<col style="width:247px">
					<col style="width:120px;">
					<col>
				</colgroup>
				<tbody>
					<tr>
						<c:if test="${opnAplDo.aplPrgStatCd eq '01'}">
					<tr>
						<th colspan="2">접수번호</th>
						<td>
							&nbsp;
						</td>
						</c:if>
						<c:if test="${opnAplDo.aplPrgStatCd eq '99'}">
							<th colspan="2">접수번호</th>
							<td>
								${opnAplDo.rcpDtsNo }
							</td>
						</c:if>
						<c:if test="${!empty opnAplDo.rcpPrgStatCd}">
					<tr>
						<th colspan="2">접수번호</th>
						<td>
							<c:out value="${opnAplDo.rcpDtsNo }" />
						</td>
						</c:if>
	
						<th>처리기한</th>
						<td colspan="2">
							<fmt:parseDate value="${opnAplDo.dealDlnDt }" var="dateFmt" pattern="yyyymmdd" />
							<fmt:formatDate value="${dateFmt}" pattern="yyyy-mm-dd" />
						</td>
					</tr>
					<tr>
						<th colspan="2">청구대상기관</th>
						<td colspan="4">
							<c:out value="${opnAplDo.aplInstNm }" />
						</td>
					</tr>
					<tr>
						<th colspan="2">청구제목</th>
						<td colspan="4">
							${opnAplDo.aplSj }
							<input type="hidden" name="aplSj" size="82" maxlength="50" value="<c:out value="
								${opnAplDo.aplSj }" />" />
						</td>
					</tr>
					<tr>
						<th colspan="2">수정청구제목</th>
						<td colspan="4">
							${opnAplDo.aplModSj }
						</td>
					</tr>
					<tr>
						<th colspan="2">청구내용</th>
						<td colspan="4">
							${fn:replace(opnAplDo.aplDtsCn, CR, "<br>")}
							<input type="hidden" name="aplDtsCn" size="82" maxlength="50" value="<c:out value="
								${opnAplDo.aplDtsCn }" />" />
						</td>
					</tr>
					<tr>
						<th colspan="2">수정청구내용</th>
						<td colspan="4">
							${fn:replace(opnAplDo.aplModDtsCn, CR, "<br>")}
						</td>
					</tr>
					<tr>
						<th colspan="2">첨부문서</th>
						<td colspan="4">
							<c:if test="${!empty opnAplDo.attchFlNm}">
							<a href="#none" style="text-decoration:none;" onclick="fileDownLoad('${opnAplDo.attchFlNm}','${opnAplDo.attchFlPhNm}');">
								<img src="/images/admin/icon_file.png" style="padding-right:4px;" alt="첨부파일">
								<span style="color:#666;">${opnAplDo.attchFlNm}</span>
							</a>
							</c:if>
							<c:if test="${opnAplDo.rcpPrgStatCd eq '08' and empty opnAplDo.attchFlNm}">
								해당없음
							</c:if>
						</td>
					</tr>
					<tr>
						<th colspan="2">공개형태</th>
						<td colspan="4">
							<c:out value="${opnAplDo.opbFomValNm }" />
							<c:if test="${!empty opnAplDo.opbFomValNm}">
								<c:out value="${opnAplDo.opbFomEtc}" escapeXml="true" />
							</c:if>
						</td>
					</tr>
					<tr>
						<th colspan="2">수령방법</th>
						<td colspan="4">
							<c:out value="${opnAplDo.aplTakMthNm }" />
							<c:if test="${!empty opnAplDo.aplTakMthEtc}">
								<c:out value="${opnAplDo.aplTakMthEtc}" escapeXml="true" />
							</c:if>
						</td>
					</tr>
				</tbody>
			</table>
			<br />
		</div>
	
		<div>
			<table class="list01">
				<caption>청구신청정보</caption>
				<colgroup>
					<col style="width:70px;">
					<col style="width:80px;">
					<col style="width:234px">
					<col style="width:120px;">
					<col>
				</colgroup>
				<tbody>
					<tr>
						<th rowspan="3">수수료</th>
						<th>감면여부</th>
						<td colspan="4">
							<c:out value="${opnAplDo.feeRdtnNm }" />
						</td>
					</tr>
					<tr>
						<th>감면사유</th>
						<td colspan="4">
							<c:out value="${opnAplDo.feeRdtnRson }" escapeXml="true" />
							<c:if test="${opnAplDo.rcpPrgStatCd eq '08' and empty opnAplDo.feeRdtnRson}">
								해당없음
							</c:if>
						</td>
					</tr>
					<tr>
						<th>첨부문서</th>
						<td colspan="4">
							<c:if test="${!empty opnAplDo.feeAttchFlNm}">
							<a href="#none" style="text-decoration:none;" onclick="fileDownLoad('${opnAplDo.feeAttchFlNm}','${opnAplDo.feeAttchFlPh}');">
								<img src="/images/admin/icon_file.png" style="padding-right:4px;" alt="첨부파일">
								<span style="color:#666;">${opnAplDo.feeAttchFlNm}</span>
							</a>
							</c:if>
							<c:if test="${opnAplDo.rcpPrgStatCd eq '08' and empty opnAplDo.feeAttchFlNm}">
								해당없음
							</c:if>
						</td>
					</tr>
					<c:if test="${!empty opnAplDo.opbYn }">
						<tr>
							<th colspan="2">공개여부</th>
							<td colspan="4">
								<c:out value="${opnAplDo.opbYn }" />
							</td>
						</tr>
						<tr>
							<th colspan="2">비공개사유</th>
							<td colspan="4">
							
				            	<c:choose>
				                    <c:when test="${opnAplDo.callVersion eq 'V1'}">
										 ${fn:replace(opnAplDo.clsdRmk, CR, "<br>")}
										<c:if test="${opnAplDo.rcpPrgStatCd eq '08' and empty opnAplDo.clsdRmk}">
											해당없음
										</c:if>
				                    </c:when>
				                    <c:otherwise>
										 ${fn:replace(opnAplDo.newClsdRmk, CR, "<br>")}
										<c:if test="${opnAplDo.rcpPrgStatCd eq '08' and empty opnAplDo.newClsdRmk}">
											해당없음
										</c:if>
				                    </c:otherwise>
				                </c:choose>							

							</td>
						</tr>
					</c:if>
					<tr>
						<th colspan="2">정보 부존재 등<br /> 정보공개청구에<br />따를수 없는 사유 </th>
						<td colspan="3">
							<c:if test="${opnAplDo.opbYn eq '부존재 등' }">
								${opnAplDo.nonExt }<br />
							</c:if>
							<c:if test="${opnAplDo.opbYn ne '부존재 등' }">해당없음</c:if>
						</td>
					</tr>
					<tr>
						<th colspan="2">결정통지안내수신</th>
						<td colspan="4">
							<c:out value="${opnAplDo.dcsNtcRcvMthNm }" />
						</td>
					</tr>
					<c:if test="${!empty opnAplDo.opbFlNm }">
						<tr>
							<th colspan="2">결정통지 첨부파일</th>
							<td colspan="4">
								<c:if test="${!empty opnAplDo.opbFlNm}">
								<a href="#none" style="text-decoration:none;" onclick="fileDownLoad('${opnAplDo.opbFlNm}','${opnAplDo.opbFlPh}');">
									<img src="/images/admin/icon_file.png" style="padding-right:4px;" alt="첨부파일">
									<span style="color:#666;">${opnAplDo.opbFlNm}</span>
								</a><br>
								</c:if>
								<c:if test="${!empty opnAplDo.opbFlNm2}">
								<a href="#none" style="text-decoration:none;" onclick="fileDownLoad('${opnAplDo.opbFlNm2}','${opnAplDo.opbFlPh2}');">
									<img src="/images/admin/icon_file.png" style="padding-right:4px;" alt="첨부파일">
									<span style="color:#666;">${opnAplDo.opbFlNm2}</span>
								</a><br>
								</c:if>
								<c:if test="${!empty opnAplDo.opbFlNm3}">
								<a href="#none" style="text-decoration:none;" onclick="fileDownLoad('${opnAplDo.opbFlNm3}','${opnAplDo.opbFlPh3}');">
									<img src="/images/admin/icon_file.png" style="padding-right:4px;" alt="첨부파일">
									<span style="color:#666;">${opnAplDo.opbFlNm3}</span>
								</a><br>
								</c:if>
								<c:if test="${opnAplDo.rcpPrgStatCd eq '08' and empty opnAplDo.opbFlNm}">
									해당없음
								</c:if>
								<c:if test="${!empty opnAplDo.opbFlNm or !empty opnAplDo.opbFlNm2 or !empty opnAplDo.opbFlNm3}">
										<br>
										<a href="#none" style="text-decoration:none;" onclick="javascript:fn_utilFileDownload('1');">
											<img src="/images/admin/icon_file.png" style="padding-right:4px;" alt="첨부파일"> 
											<span style="color:#666;">AdbeRdr1010_mui_Std.zip</span>
										</a>
										(PDF리더기)<br>
										<a href="#none" style="text-decoration:none;" onclick="javascript:fn_utilFileDownload('2');">
											<img src="/images/admin/icon_file.png" style="padding-right:4px;" alt="첨부파일">
											<span style="color:#666;">e-timing for AdobeReader 9,X,XI,DC(v4.6.6).exe<span style="color:#666;">
										</a>
										(진본확인 검증 프로그램1)<br>
										<a href="#none" style="text-decoration:none;" onclick="javascript:fn_utilFileDownload('3');">
											<img src="/images/admin/icon_file.png" style="padding-right:4px;" alt="첨부파일"> 
											<span style="color:#666;">vcredist_x86.exe</span>
										</a>
										(진본확인 검증 프로그램2)<br>
										<a href="#none" style="text-decoration:none;" onclick="javascript:fn_utilFileDownload('4');">
											<img src="/images/admin/icon_file.png" style="padding-right:4px;" alt="첨부파일"> 
											<span style="color:#666;">설치매뉴얼</span>
										</a><br>
								</c:if>
							</td>
						</tr>
					</c:if>
					<tr>
						<th colspan="2">타기관이송</th>
						<td colspan="4">
							<c:out value="${opnAplDo.trsfInstNm }" />
							<c:if test="${opnAplDo.rcpPrgStatCd eq '08' and empty opnAplDo.trsfInstNm}">
								해당없음
							</c:if>
						</td>
					</tr>
				</tbody>
			</table>
		</div>
			
		<c:if test="${!empty FROM_TRST }">
		<h2 class="text-title2">이송 받은 정보</h2>
		<div name="fromTrsfArea">
			<table class="list01" style="position: relative;border-color:#9C9C00;">
				<caption>이송 받은 정보</caption>
					 <colgroup>
						<col style="width:150px;">
						<col style="width:">
					</colgroup>
					<tbody>
						<c:set var="aplInstNm" value="" />
						<c:forEach var="fromData" items="${FROM_TRST}">
							<c:set var="aplInstNm" value="${fromData.aplInstNm}" />
						</c:forEach>
						<tr>
							<th>이송 기관</th>
							<td><span name="fromTrsfInstNm">${aplInstNm}</span></td>
						</tr>
						<tr>
							<th>이송 받은 기관<br />및 이송사유</th>
							<td>
								<table class="list02" style="width:100%;">
									<colgroup>
										<col style="width:150px;">
										<col>
									</colgroup>
									<tbody name="fromTrsfInfo">
										<c:forEach var="fromData" items="${FROM_TRST}">
											<fmt:parseDate value="${fromData.trsfDt}" var="trsfDt" pattern="yyyyMMdd"/>
											<tr>
											<c:choose>
												<c:when test="${opnAplDo.aplDealInstCd eq fromData.aplDealInstCd}">
													<th style="text-align:center;background:#FFFFCE;font-weight: bold;color: red;">
														${fromData.aplDealInstNm}<br />
														(<fmt:formatDate value="${trsfDt}" pattern="yyyy-MM-dd"/>)
													</th>
												</c:when>
												<c:otherwise>
													<th style="text-align:center;background:#FFFFCE;">${fromData.aplDealInstNm}<br />(${trsfDt})</th>
												</c:otherwise>
											</c:choose>
											<td>${fromData.trsfCn}</td>
											</tr>
										</c:forEach>
									</tbody>
								</table>
							</td>
						</tr>
					</tbody>
			</table>
		</div>
		</c:if>
		
		<c:if test="${!empty TO_TRST }">
		<h2 class="text-title2">이송 보낸 정보</h2>
		<div name="toTrsfArea">
			<table class="list01" style="position: relative;border-color:#FF639C;">
				<caption>이송 보낸 정보</caption>
					 <colgroup>
						<col style="width:150px;">
						<col style="width:">
					</colgroup>
				<tbody>
					<tr>
						<th>이송 보낸 기관<br />및 이송사유</th>
						<td>
							<table class="list02" style="width:100%;">
									<colgroup>
										<col style="width:150px;">
										<col>
									</colgroup>
									<tbody name="toTrsfInfo">
										<c:forEach var="toData" items="${TO_TRST}">
											<fmt:parseDate value="${toData.trsfDt}" var="trsfDt" pattern="yyyyMMdd"/>
											<tr>
												<th style="text-align:center;background:#FFE6FF;">
													${toData.aplDealInstNm}<br />
													(<fmt:formatDate value="${trsfDt}" pattern="yyyy-MM-dd"/>)
												</th>
												<td>${toData.trsfCn}</td>
											</tr>
										</c:forEach>
									</tbody>
							</table>
						</td>
					</tr>
				</tbody>
			</table>
		</div>
		</c:if>
			
		<div class="buttons">
		<c:choose>
				<c:when test="${opnAplDo.rcpPrgStatCd eq '03' }">
					<a href="javascript:;" class="btn02" title="청구서출력" name="printAplBtnA">청구서출력</a>
					<a href="javascript:;" class="btn02" title="접수증출력" name="printRcpBtnA">접수증출력</a>
				</c:when>
				<c:when test="${opnAplDo.rcpPrgStatCd eq '05' }">
					<a href="javascript:;" class="btn02" title="청구서출력" name="printAplBtnA">청구서출력</a>
					<a href="javascript:;" class="btn02" title="접수증출력" name="printRcpBtnA">접수증출력</a>
					<a href="javascript:;" class="btn02" title="결정기한연장통지서" name="printExtBtnA">결정기한연장통지서</a>
				</c:when>
				<c:otherwise>
					<a href="javascript:;" class="btn02" title="청구서출력" name="printAplBtnA">청구서출력</a>
					<a href="javascript:;" class="btn02" title="접수증출력" name="printRcpBtnA">접수증출력</a>
					<c:if test="${opnAplDo.dcsProdEtYn eq '0'}">
					<a href="javascript:;" class="btn02" title="결정기한연장통지서" name="printExtBtnA">결정기한연장통지서</a>
					</c:if>
				</c:otherwise>
			</c:choose>
			<c:if test="${opnAplDo.rcpPrgStatCd eq '08' or opnAplDo.rcpPrgStatCd eq '04'}">
				<c:if test="${opnAplDo.endCn eq NULL}"> <!-- 종결사유가 없을때, 즉. 강제종결이 아닐 때  -->		
					<c:if test="${empty opnAplDo.trsfInstNm }">
						<c:if test="${opnAplDo.opbYn eq '부존재 등'}">					
							<a href="javascript:;" class="btn02" title="부존재 등 통지서 출력" name="printNonBtnA">부존재 등 통지서 출력</a>	
						</c:if>
						<c:if test="${opnAplDo.opbYn ne '부존재 등'}">					
							<a href="javascript:;" class="btn02" title="결정통지서" name="printDcsBtnA">결정통지서출력</a>
						</c:if>
					</c:if>
				</c:if>
			</c:if>
			${sessionScope.button.a_close}
		</div> 
		<textarea name="printAplModDtsCn" title="청구내용(출력용)" style="display:none;">${opnAplDo.aplModDtsCn}</textarea>
		<textarea name="printClsdRmk" title="비공개사유(출력용)"  style="display:none;">${opnAplDo.newClsdRmk}</textarea>
	</form>	
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