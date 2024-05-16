<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="egovframework.common.WiseOpenConfig"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
	
	//부존재 등 통지서 출력
	$("a[name=printNonBtnA]").bind("click", function(event) {
		infoPrint("non");
	});
	
	//결정통지서출력
	$("a[name=printDcsBtnA]").bind("click", function(event) {
		infoPrint("dcs");
	});
	
	//팝업창 닫기
	$("a[name=a_close]").bind("click", function(event) {
		window.close();
	});
	
	//청구서 상세
	$("a[name=aplBtnA]").bind("click", function(event) {
		goOpnAplPopup();
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
	
	if(div == "dcs"){		
		formPrint.find("input[name=width]").val("680");
		formPrint.find("input[name=height]").val("700");
		formPrint.find("input[name=title]").val("정보공개 결정통지서 출력");		
		window.open("","popup","width=680, height=700, resizable=yes, location=no;");
		
	<c:choose>
        <c:when test="${opnDcsDo.callVersion eq 'V1'}">
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

	}else if(div == "non"){		
		formPrint.find("input[name=mrdParam]").val( "/rp ["+aplNo+"] [1]") ;
		formPrint.find("input[name=width]").val("680");
		formPrint.find("input[name=height]").val("700");
		formPrint.find("input[name=title]").val("정보공개 결정통지서 출력");		
		window.open("","popup","width=680, height=700, resizable=yes, location=no;");
		
	<c:choose>
        <c:when test="${opnDcsDo.callVersion eq 'V1'}">
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
	}
	formPrint.attr("target", "popup");
	formPrint.submit();
}

//첨부파일 다운로드
function fileDownLoad(fileNm, filePath) {
	
	var params = "?fileNm="+ fileNm + "&filePath="+filePath;
	$("iframe[id=download-frame]").attr("src", com.wise.help.url("/admin/expose/downloadOpnAplFile.do") + params);
}

//청구서 조회 이동
function goOpnAplPopup() {
	
	var form = $("form[name=opnDcsForm]");
	
	form.attr("action", com.wise.help.url("/admin/expose/popup/viewOpnAplPopup.do"));
	form.attr("target", "_self");
	form.submit();
}

//이의신청내역 이동
function goOpnObjtnPopup () {
	var form = $("form[name=opnDcsForm]");
	
	form.attr("action", com.wise.help.url("/admin/expose/popup/viewOpnObjtnPopup.do"));
	form.attr("target", "_self");
	form.submit();
}

//신청서목록 이동
function goOpnAplListPopup () {
var form = $("form[name=opnDcsForm]");
	
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
	<h3>결정통보내역</h3>
	<div id="div-sect" style="padding:15px;">
	<form name="opnDcsForm" method="post" action="#">
	 	<input type="hidden" name="aplNo" value="${opnDcsDo.aplNo}" />
	 	<input type="hidden" name="aplDealInstCd" value="${opnDcsDo.aplDealInstCd }" />
	 	<input type="hidden" name="objtnSno" value="${opnDcsDo.objtnSno }" />
		<div class="buttons">
			<a href="javascript:;" class="btn02" title="청구서바로가기" name="aplBtnA">청구서바로가기</a>
			<c:if test="${!empty opnDcsDo.objtnDt }">
			<a href="javascript:;" class="btn02" title="이의신청바로가기" name="objTnBtnA">이의신청바로가기</a>	
			</c:if>
			<a href="javascript:;" class="btn02" title="목록" name="aplListBtnA">목록</a>
		</div><br>
		<div>
			<table class="list01">
			    <caption>공개결정 내용등록</caption>
			    <colgroup>
			        <col style="width:100px;">
			        <col style="width:100px;">
			        <col>
			        <col style="width:120px;">
			        <col style="width:200px;">
			    </colgroup>
			    <tbody>
			        <tr>
			            <th colspan="2">정보공개 결정</th>
			            <td colspan="3">
			                <c:choose>
			                    <c:when test="${opnDcsDo.opbYn eq '0'}">공개</c:when>
			                    <c:when test="${opnDcsDo.opbYn eq '1'}">부분공개</c:when>
			                    <c:when test="${opnDcsDo.opbYn eq '2'}">비공개</c:when>
			                    <c:otherwise>부존재 등</c:otherwise>
			                </c:choose>
			            </td>
			        </tr>
			        <tr>
			            <th colspan="2">청구내용</th>
			            <td colspan="3">
			                <pre>${opnDcsDo.aplModDtsCn}</pre>
			            </td>
			        </tr>
			        <tr>
			            <th colspan="2">공개내용</th>
			            <td colspan="3">
			                <c:choose>
			                    <c:when test="${opnDcsDo.opbYn eq '0'}">
			                        <pre>${opnDcsDo.opbCn}</pre>
			                    </c:when>
			                    <c:when test="${opnDcsDo.opbYn eq '1'}">
			                        <pre>${opnDcsDo.opbCn}</pre>
			                    </c:when>
			                    <c:when test="${opnDcsDo.opbYn eq '2'}">해당없음</c:when>
			                    <c:when test="${opnDcsDo.opbYn eq '3'}">해당없음</c:when>
			                </c:choose>
			            </td>
			        </tr>
			        <tr>
			            <th colspan="2">비공개<br>(전부 또는 일부 내용 및 사유)</th>
			            <td colspan="3">
			            	<c:choose>
			                    <c:when test="${opnDcsDo.opbYn eq '0'}">해당없음</c:when>
			                    <c:when test="${opnDcsDo.opbYn eq '1'}">
			                    
					            	<c:choose>
					                    <c:when test="${opnDcsDo.callVersion eq 'V1'}">
					                    	${opnDcsDo.clsdRsonNm}<br>
					                    	${fn:replace(opnDcsDo.clsdRmk, CR, "<br>")}
					                    </c:when>
					                    <c:otherwise>
					                    	${fn:replace(opnDcsDo.newClsdRmk, CR, "<br>")}
					                    </c:otherwise>
					                </c:choose>
			                         
			                    </c:when>
			                    <c:when test="${opnDcsDo.opbYn eq '2'}">
			                    
					            	<c:choose>
					                    <c:when test="${opnDcsDo.callVersion eq 'V1'}">
					                    	${opnDcsDo.clsdRsonNm}<br>
					                    	${fn:replace(opnDcsDo.clsdRmk, CR, "<br>")}
					                    </c:when>
					                    <c:otherwise>
					                    	${fn:replace(opnDcsDo.newClsdRmk, CR, "<br>")}
					                    </c:otherwise>
					                </c:choose>

			                    </c:when>
			                    <c:when test="${opnDcsDo.opbYn eq '3'}">해당없음</c:when>
			                </c:choose>
			            </td>
			        </tr>
			        <tr>
			            <th colspan="2">정보 부존재 등<br> 정보공개청구에<br>따를수 없는 사유 </th>
			            <td colspan="3">
			                <c:if test="${opnDcsDo.opbYn eq '3'}">
			                    ${opnDcsDo.non_ext}<br>
			                </c:if>
			                <c:if test="${opnDcsDo.opbYn ne '3'}">해당없음</c:if>
			            </td>
			        </tr>
			        <tr>
			            <th rowspan="2" class="line">공개방법</th>
			            <th>공개형태</th>
			            <td colspan="3">
						<c:choose>
							<c:when test="${opnDcsDo.callVersion eq 'V1' }">
								${opnDcsDo.opbFomNm }
							</c:when>
							<c:otherwise>
								<c:set var="opbFomNm" value="${opnDcsDo.opbFomNm1}"/>
								<c:if test="${!empty opnDcsDo.opbFomNm2 and !empty opbFomNm}"><c:set var="opbFomNm" value="${opbFomNm}, ${opnDcsDo.opbFomNm2}"/></c:if>
								<c:if test="${!empty opnDcsDo.opbFomNm2 and empty opbFomNm}"><c:set var="opbFomNm" value="${opnDcsDo.opbFomNm2}"/></c:if>
								<c:if test="${!empty opnDcsDo.opbFomNm3 and !empty opbFomNm}"><c:set var="opbFomNm" value="${opbFomNm}, ${opnDcsDo.opbFomNm3}"/></c:if>
								<c:if test="${!empty opnDcsDo.opbFomNm3 and empty opbFomNm}"><c:set var="opbFomNm" value="${opnDcsDo.opbFomNm3}"/></c:if>
								<c:if test="${!empty opnDcsDo.opbFomNm4 and !empty opbFomNm}"><c:set var="opbFomNm" value="${opbFomNm}, ${opnDcsDo.opbFomNm4}"/></c:if>
								<c:if test="${!empty opnDcsDo.opbFomNm4 and empty opbFomNm}"><c:set var="opbFomNm" value="${opnDcsDo.opbFomNm4}"/></c:if>
								<c:if test="${!empty opnDcsDo.opbFomNm5 and !empty opbFomNm}"><c:set var="opbFomNm" value="${opbFomNm}, ${opnDcsDo.opbFomNm5}"/></c:if>
								<c:if test="${!empty opnDcsDo.opbFomNm5 and empty opbFomNm}"><c:set var="opbFomNm" value="${opnDcsDo.opbFomNm5}"/></c:if>
								${opbFomNm}
							</c:otherwise>
						</c:choose>
	                        <c:if test="${!empty opnDcsDo.opbFomNm5 and !empty opnDcsDo.opbFomEtc}">
	                           (${opnDcsDo.opbFomEtc})
	                        </c:if>
			            </td>
			        </tr>
			        <tr>
			            <th>교부방법</th>
			            <td colspan="3">
						<c:choose>
							<c:when test="${opnDcsDo.callVersion eq 'V1' }">
								<input type="hidden" name="givie_mth" id="giveMth" value="${opnDcsDo.giveMth}" />
								${opnDcsDo.giveMthNm }
							</c:when>
							<c:otherwise>
								<c:set var="giveMthNm" value="${opnDcsDo.giveMthNm1}"/>
								<c:if test="${!empty opnDcsDo.giveMthNm2 and !empty giveMthNm}"><c:set var="giveMthNm" value="${giveMthNm}, ${opnDcsDo.giveMthNm2}"/></c:if>
								<c:if test="${!empty opnDcsDo.giveMthNm2 and empty giveMthNm}"><c:set var="giveMthNm" value="${opnDcsDo.giveMthNm2}"/></c:if>
								<c:if test="${!empty opnDcsDo.giveMthNm3 and !empty giveMthNm}"><c:set var="giveMthNm" value="${giveMthNm}, ${opnDcsDo.giveMthNm3}"/></c:if>
								<c:if test="${!empty opnDcsDo.giveMthNm3 and empty giveMthNm}"><c:set var="giveMthNm" value="${opnDcsDo.giveMthNm3}"/></c:if>
								<c:if test="${!empty opnDcsDo.giveMthNm4 and !empty giveMthNm}"><c:set var="giveMthNm" value="${giveMthNm}, ${opnDcsDo.giveMthNm4}"/></c:if>
								<c:if test="${!empty opnDcsDo.giveMthNm4 and empty giveMthNm}"><c:set var="giveMthNm" value="${opnDcsDo.giveMthNm4}"/></c:if>
								<c:if test="${!empty opnDcsDo.giveMthNm5 and !empty giveMthNm}"><c:set var="giveMthNm" value="${giveMthNm}, ${opnDcsDo.giveMthNm5}"/></c:if>
								<c:if test="${!empty opnDcsDo.giveMthNm5 and empty giveMthNm}"><c:set var="giveMthNm" value="${opnDcsDo.giveMthNm5}"/></c:if>
								${giveMthNm}
							</c:otherwise>
						</c:choose>
	                        <c:if test="${!empty opnDcsDo.giveMthNm5 and !empty opnDcsDo.giveMthEtc}">
	                           (${opnDcsDo.giveMthEtc})
	                        </c:if>
			            </td>
			        </tr>
			        <tr>
			            <th colspan="2">공개일자</th>
			            <td>
			                ${opnDcsDo.opbDtm} 까지
			            </td>
			            <th>공개장소</th>
			            <td>
			                ${opnDcsDo.opbPlcNm}
			            </td>
			        </tr>
			        <tr>
			            <th colspan="2">수수료(A)</th>
			            <td>
			                ${opnDcsDo.fee}
			            </td>
			            <th>우송료(B)</th>
			            <td>
			                ${opnDcsDo.zipFar}
			            </td>
			        </tr>
			        <tr>
			            <th colspan="2">수수료 감면액(C)</th>
			            <td>
			                ${opnDcsDo.feeRdtnAmt}
			            </td>
			            <th>계(A+B+C)</th>
			            <td>
			                <input type="text" name="feeSum" size="10" style="border:none;" value="${opnDcsDo.feeSum}" readonly />
			            </td>
			        </tr>
			        <tr>
			            <th colspan="2">수수료 산정 내역</th>
			            <td>
			                ${opnDcsDo.feeEstCn}
			            </td>
			            <th>수수료납입계좌</th>
			            <td>
			                ${opnDcsDo.feePaidAccNo}
			            </td>
			        </tr>
			    </tbody>
			</table>
			<br>
			</div>
			<div>
			    <table class="list01">
			        <caption>공개결정 내용등록</caption>
			        <colgroup>
			            <col style="width:200px;">
			            <col>
			        </colgroup>
			        <tbody>
			            <tr>
			                <th>제3자의견등록 첨부파일</th>
			                <td>
			                    <input type="hidden" name="trdOpnFlNm" id="trdOpnFlNm" value="${opnDcsDo.trdOpnFlNm}" />
			                    <input type="hidden" name="trdOpnFlPh" id="trdOpnFlPh" value="${opnDcsDo.trdOpnFlPh}" />
			                    <a href="#" style="text-decoration:none;" onclick="javascript:fileDownLoad('${opnDcsDo.trdOpnFlNm}','${opnDcsDo.trdOpnFlPh}')">
			                        <c:if test="${!empty opnDcsDo.trdOpnFlNm}">
			                            <img src="/images/admin/icon_file.png" style="padding-right:4px;" alt="첨부파일">
			                        </c:if>
			                        <span style="color:#666;">${opnDcsDo.trdOpnFlNm}</span>
			                    </a>
			                    <c:if test="${empty opnDcsDo.trdOpnFlNm}">
			                    		   해당없음
			                    </c:if>
			                </td>
			            </tr>
			            <tr>
			                <th>심의회 관리 첨부파일</th>
			                <td>
			                    <input type="hidden" name="dbrtInstFlNm" id="dbrtInstFlNm" value="${opnDcsDo.dbrtInstFlNm}" />
			                    <input type="hidden" name="dbrtInstFlPh" id="dbrtInstFlPh" value="${opnDcsDo.dbrtInstFlPh}" />
			                    <a href="#" style="text-decoration:none;" onclick="javascript:fileDownLoad('${opnDcsDo.dbrtInstFlNm}', '${opnDcsDo.dbrtInstFlPh}')">
			                        <c:if test="${!empty opnDcsDo.dbrtInstFlNm}">
			                            <img src="/images/admin/icon_file.png" style="padding-right:4px;" alt="첨부파일">
			                        </c:if>
			                        <span style="color:#666;">${opnDcsDo.dbrtInstFlNm}</span>
			                    </a>
			                    <c:if test="${empty opnDcsDo.dbrtInstFlNm}">
			                     		해당없음
			                    </c:if>
			                </td>
			            </tr>
			
			            <c:if test="${opnDcsDo.prgStatCd eq '08'}">
			                <tr>
			                    <th>결정통지 첨부파일</th>
			                    <td>
			                    	<c:if test="${!empty opnDcsDo.opbFlNm}">
									<a href="#none" style="text-decoration:none;" onclick="fileDownLoad('${opnDcsDo.opbFlNm}','${opnDcsDo.opbFlPh}');">
										<img src="/images/admin/icon_file.png" style="padding-right:4px;" alt="첨부파일">
										<span style="color:#666;">${opnDcsDo.opbFlNm}</span>
									</a><br>
									</c:if>
									<c:if test="${!empty opnDcsDo.opbFlNm2}">
									<a href="#none" style="text-decoration:none;" onclick="fileDownLoad('${opnDcsDo.opbFlNm2}','${opnDcsDo.opbFlPh2}');">
										<img src="/images/admin/icon_file.png" style="padding-right:4px;" alt="첨부파일">
										<span style="color:#666;">${opnDcsDo.opbFlNm2}</span>
									</a><br>
									</c:if>
									<c:if test="${!empty opnDcsDo.opbFlNm3}">
									<a href="#none" style="text-decoration:none;" onclick="fileDownLoad('${opnDcsDo.opbFlNm3}','${opnDcsDo.opbFlPh3}');">
										<img src="/images/admin/icon_file.png" style="padding-right:4px;" alt="첨부파일">
										<span style="color:#666;">${opnDcsDo.opbFlNm3}</span>
									</a><br>
									</c:if>
									<c:if test="${!empty opnDcsDo.opbFlNm or !empty opnDcsDo.opbFlNm2 or !empty opnDcsDo.opbFlNm3}">
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
			        </tbody>
			    </table>
			</div>
			
		<div class="buttons">
		<c:if test="${opnDcsDo.opbYn eq '3'}">
			<a href="javascript:;" class="btn02" title="부존재 등 통지서 출력" name="printNonBtnA">부존재 등 통지서 출력</a>
		</c:if>
		<c:if test="${opnDcsDo.opbYn ne '3'}">
			<a href="javascript:;" class="btn02" title="결정통지서" name="printDcsBtnA">결정통지서출력</a>
		</c:if>	
			${sessionScope.button.a_close}
		</div>
		<textarea name="printAplModDtsCn" title="청구내용(출력용)" style="display:none;">${opnDcsDo.aplModDtsCn}</textarea>
		<textarea name="printClsdRmk" title="비공개사유(출력용)"  style="display:none;">${opnDcsDo.newClsdRmk}</textarea>
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