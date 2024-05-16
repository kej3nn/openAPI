<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="egovframework.common.WiseOpenConfig"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
</style>                  
<script language="javascript">         

var popObj = "form[name=statInputDif]";

/* 등록 가능한 입력 상태들(대기, 저장, 반려, 취소승인) */
var BATCH_PP_STATE = ["WW", "PG", "RC", "RA"]; 

$(document).ready(function()    {
	/* 이벤트를 바인딩 한다 */
	bindEvent();
	
	// 필요 없을시 주석처리
	var wrtstateCd = $("#wrtStateCd").val();
	if ( !gfn_isNull(wrtstateCd) && BATCH_PP_STATE.includes(wrtstateCd) ) {	
		// 작업상태가 대기, 저장, 반려, 취소승인만 저장할 수 있음.
		$(popObj).find("a[name=a_save]").show();
	} else {
		$(popObj).find("a[name=a_save]").hide();
	}
	
	doAction("search");
	
});
 
function bindEvent() {
	$(popObj).find("a[name=a_close]").click(function(e) {
		//창닫기
		parent.closeIframePop("iframePopUp");
		return false;                
	});
	
	$(popObj).find(".popup_close").click(function(e) {
		//닫기
		$(popObj).find("a[name=a_close]").click();
		return false;                
	}); 
	
	$(popObj).find("select[name=wrttimeIdtfrId]").bind("change", function(e) {
		doAction("search");
		return false;
	});
	
	$(popObj).find("button[name=btnDifInit]").bind("click", function(e) {
		$("#cmmtIdtfr, #cmmtCont, #engCmmtCont").val("");
		return false;
	});
	
	
	$(popObj).find("a[name=a_save]").click(function(e) { 
		//데이터 저장
		doAction("save");
		return false;  
	});
	
}


// action 함수
function doAction(sAction) {
	
	var formObj = $("form[name=statInputDif]");  
	
	switch(sAction) {
		case "search" :
			
			doAjax({
				url : "/admin/stat/selectSttsTblDif.do",
				params : formObj.serialize(),
				callback : function(res) {
					if ( res != null ) {
						var data = res.data;
						$("#cmmtIdtfr").val(data.cmmtIdtfr);
						$("#cmmtCont").val(data.cmmtCont);
						$("#engCmmtCont").val(data.engCmmtCont);
					}
				}
			});
			
			break;	
			
		case "save" :
			var cmmtIdtfr = formObj.find("#cmmtIdtfr").val();
			if ( !com.wise.util.isBlank(cmmtIdtfr) && !com.wise.util.isNumeric(cmmtIdtfr) ) {
				alert("식별자는 숫자만 입력하세요.");
				return false;
			} 
			
			if ( !confirm("저장 하시겠습니까?") ) {
				return false;
			}
			
			doAjax({
				url : "/admin/stat/saveStatInputDifData.do",
				params : formObj.serialize()
			});
			break;
	}
}

</script>                
<body>
<form name="statInputDif"  id="statInputDif" method="post" action="#">
	<input type="hidden" id="parentFormNm" value="${param.parentFormNm}"/>
	<input type="hidden" id="statblId" name="statblId" value="${param.statblId}"/>
	<input type="hidden" id="dtacycleCd" name="dtacycleCd" value="${param.dtacycleCd}"/>
	<%-- <input type="hidden" id="wrttimeIdtfrId" name="wrttimeIdtfrId" value="${param.wrttimeIdtfrId}"/> --%>
	<input type="hidden" id="wrttimeDesc" name="wrttimeDesc" value="${param.wrttimeDesc}"/>
	<c:choose>
    <c:when test="${fn:length(data.batchWrttimeIdtfrId) > 0 }">
        <input type="hidden" id="batchYn" name="batchYn" value="Y"/>
    </c:when>
    <c:otherwise>
        <input type="hidden" id="batchYn" name="batchYn" value="N"/>
    </c:otherwise>
	</c:choose>
	<input type="hidden" id="wrtStateCd" value="${param.wrtStateCd}"/>
	<%-- 
	<c:forEach var="wrttimdIdtfrId" items="${data.batchWrttimeIdtfrId}">
		<input type="hidden" id="batchWrttimeIdtfrId" name="batchWrttimeIdtfrId" value="${wrttimdIdtfrId }"/>
	</c:forEach>
	<c:forEach var="wrttimeDesc" items="${data.batchWrttimeDesc}">
		<input type="hidden" id="batchWrttimeDesc" name="batchWrttimeDesc" value="${wrttimeDesc }"/>
	</c:forEach>
	 --%>
	<div class="popup">
		<h3>자료시점 주석</h3>
		<a href="#" class="popup_close">x</a>
		<div style="padding:15px;">
			<!-- <p class="text-title">조회조건</p> -->
			<table class="list01">              
			<colgroup>
				<col width="200"/>
				<col width=""/>
			</colgroup>
				<tr>
					<th>자료시점</th>
					<td>
						<select id="wrttimeIdtfrId" name="wrttimeIdtfrId">
						<c:choose>
						    <c:when test="${fn:length(data.batchWrttimeIdtfrId) > 0 }">
						        <c:forEach var="wrttimeDesc" varStatus="status" items="${data.batchWrttimeDesc}">
									<option value="${data.batchWrttimeIdtfrId[status.index] }">${wrttimeDesc}</option>
								</c:forEach>
						    </c:when>
						    <c:otherwise>
						        <option value="${param.wrttimeIdtfrId}">${param.wrttimeDesc}</option>
						    </c:otherwise>
						</c:choose>
						</select>
					</td>
				</tr>
			</table>
			<p>
			
			<table class="list01">              
			<colgroup>
				<col width="200"/>
				<col width=""/>
			</colgroup>
				<tr>
					<th>식별자</th>
					<td>
						<input type="text" id="cmmtIdtfr" name="cmmtIdtfr" size="20" value="" maxlength="9"/>
					</td> 
				</tr>
				<tr>
					<th>한글 주석</th>
					<td style="padding: 5px">
						<textarea id="cmmtCont" name="cmmtCont" style="width: 75%;" rows="4" placeholder="(한글)주석을 입력하세요"></textarea>
					</td> 
				</tr>
				<tr>
					<th>영문 주석</th>
					<td style="padding: 5px">
						<textarea id="engCmmtCont" name="engCmmtCont"  style="width: 75%;" rows="4" placeholder="(영문)주석을 입력하세요"></textarea>
					</td> 
				</tr>
			</table>
			
			<div class="buttons">
				<button type="button" class="btn01L" id="btnDifInit" name="btnDifInit" style="margin-top: -5px">초기화</button>
				${sessionScope.button.a_save}
				${sessionScope.button.a_close}
			</div>         
		</div>
	</div>
</form>
</body>
</html>                             