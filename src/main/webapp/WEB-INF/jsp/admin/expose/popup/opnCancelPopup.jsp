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
<c:set var="cType" value="${cType}" />
<c:choose>
<c:when test="${cType eq 'DCS'}">
<c:set var="popupTitle" value="결정통지취소" />
</c:when>
<c:when test="${cType eq 'END'}">
<c:set var="popupTitle" value="통지완료취소" />
</c:when>
<c:otherwise>
<c:set var="popupTitle" value="잘못된 접근 입니다." />
</c:otherwise>
</c:choose>
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
	//취소처리
	$("a[name=btnCancel]").bind("click", function(event) {
		saveData();
	});
	
	//팝업창 닫기
	$("a[name=a_close]").bind("click", function(event) {
		window.close();
	});
}

/**
 * 옵션을 로드한다.
 */
function loadOptions() {
	//캘린더 초기화
	datePickerInit()
}

/**
 * 데이터를 로드한다.
 */
function loadData() {
	
}

/**
 * 데이터 저장
 */
function saveData() {
	 
	var formObj = $("form[name=opnCancelForm]");
	var cType = formObj.find("input[name=cType]").val();
	var cTypeNm = cType == "DCS" ? "결정통지취소" : "통지완료취소";
	formObj.ajaxSubmit({
		url : com.wise.help.url("/admin/expose/cancelOpnProd.do")
		, async : false
		, type : 'post'
		, dataType: 'json' 
		, contentType : 'application/x-www-form-urlencoded;charset=UTF-8'
		, beforeSubmit : function() {
			if ( !confirm(cTypeNm+" 하시겠습니까?") )	return false;
		}	
		, success : function(res, status) {
			afterSaveEnd(res);
		}
		, error: function(jqXHR, textStatus, errorThrown) {
			alert("처리 도중 에러가 발생하였습니다.");
		}
	});
}

function afterSaveEnd(res) {
	doAjaxMsg(res, ""); //메세지 출력
	var aplNo = $("input[name=aplNo]").val();  
	$(opener.location).attr("href", "javascript:popUpCloseEvent('"+aplNo+"');");

	window.self.close(); // 팝업창 닫기
}

</script>                
<body>
	<form name="opnCancelForm" method="post" action="#">
		<input type="hidden" name ="cType" id="cType" value="${cType}" />
		<input type="hidden" name ="aplNo" id="aplNo" value="${opnAplDo.aplNo}" />
		<input type="hidden" name="aplPrgStatCd" id="aplPrgStatCd" value="${opnAplDo.aplPrgStatCd }"/>
		<input type="hidden" name ="imdDealDiv" id="imdDealDiv" value="${opnAplDo.imdDealDiv}" />
		<div class="popup">
			<h3>${popupTitle}</h3>
			<div id="div-sect" style="padding:15px;">
				<table class="list01">
					<caption>취소 알림등록</caption>
					<colgroup>
						<col style="width:80">
						<col style="width:80">
						<col style="width:">
					</colgroup>
					<tbody>

						<tr>
							<th>청구제목</th>
							<td colspan="4">${opnAplDo.aplSj}</td>
						</tr>
						<tr>
							<th>정보공개결정</th>
							<td colspan="4">${opnAplDo.opbYn}</td>
						</tr>
						<tr>
							<th rowspan="2">취소 알림</th>
							<th>청구인</th>
							<td colspan="3">
								<input type="checkbox" name="A1" value="Y">문자(SMS)&nbsp;&nbsp;
								<input type="checkbox" name="A2" value="Y">메일
							</td>
						</tr>
						<tr>
							<th>담당자</th>
							<td colspan="3">
								<input type="checkbox" name="B1" value="Y">문자(SMS)&nbsp;&nbsp;
							</td>
						</tr>
						<tr>
							<td colspan="5" align="center">
							</td>
						</tr>
					</tbody>
				</table>
				<div class="buttons">
					<a href="javascript:;" class="btn02" title="등록" name="btnCancel">${popupTitle}</a>
					${sessionScope.button.a_close}
				</div> 
			</div>
		</div>
	</form>
</body>

</html>                          