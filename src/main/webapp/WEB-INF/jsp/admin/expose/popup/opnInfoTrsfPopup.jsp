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

	// 이벤트를 바인딩한다.
    bindEvent();

});

/**
 * 이벤트를 바인딩한다.
 */
function bindEvent() {
	
	//이송처리
	$("a[name=infoTrsfBtnA]").bind("click", function(event) {
		saveData();
	});
	
	//팝업창 닫기
	$("a[name=a_close]").bind("click", function(event) {
		window.self.close(); // 팝업창 닫기
	});
	
	$("input:checkbox[name='aplDealInstCd']").change(function(){

		var relAplInstCd =  $("input[name='relAplInstCd']").val();
			
		if(relAplInstCd != this.value){
	        if($(this).is(":checked")){
	        	$("#table"+this.value).show();
	        }else{
	        	$("#table"+this.value).hide();
	        }
		}
    });
	
}

/**
 * 데이터 저장
 */
function saveData() {
	var formObj = $("form[name=opnInfoTrst]");

	//submit 전 validation 체크
	if ( infoTrsValidation() ) {
		if ( !confirm("이송하시겠습니까?") ) {
			return false;
		} else {
			formObj.ajaxSubmit({
				url : com.wise.help.url("/admin/expose/insertTrsfOpnApl.do")
				, async : false
				, type : 'post'
				, dataType: 'json' 
				, contentType : 'application/x-www-form-urlencoded;charset=UTF-8'
				, beforeSubmit : function() {
				}	
				, success : function(res, status) {
					afterSaveEnd(res);
				}
				, error: function(jqXHR, textStatus, errorThrown) {
					alert("처리 도중 에러가 발생하였습니다.");
				}
			});
		}
	} else {
		return false;
	}
	

}

function afterSaveEnd(res) {
	doAjaxMsg(res, ""); //메세지 출력
	var aplNo = $("input[name=aplNo]").val();  
	$(opener.location).attr("href", "javascript:popUpCloseEvent('"+aplNo+"');");

	window.self.close(); // 팝업창 닫기
}

////////////////////////////////////////////////////////////////////////////////
//Validation 함수
////////////////////////////////////////////////////////////////////////////////
/**
* validation 
*/
function infoTrsValidation(){
	var formObj = $("form[name=opnInfoTrst]");
	
	var relAplInstCd = formObj.find("input[name=relAplInstCd]").val();
	
	var value = "";
	
	formObj.find("input[name=aplDealInstCd]:checked").each(function() {
		value += $(this).val() + ",";
	});
	
	value = value.substr(0, value.length-1);
	
	//이송기관을 선택 안했을때 
	if(value.length == 0){
		alert("최소 한개의 기관을 선택하세요.");
		return;
	}
	
	//접수기관이 이송기관이랑 같을때
	if(value == relAplInstCd){
		alert("이송 할 대상이 없습니다.");
		return;
	}
	
	var isReq = true;
	//이송사유 내용 입력 확인
	formObj.find("input[name=aplDealInstCd]:checked").each(function() {
		if($(this).val() != formObj.find("input[name=relAplInstCd]").val()){
			if(formObj.find("textarea[name=trsfCn"+$(this).val()+"]").val() == "" || formObj.find("textarea[name=trsfCn"+$(this).val()+"]").val()  == undefined){
				isReq = false;
			}		
		}
	});
	if(!isReq){
		alert("이송사유를 입력하세요.");
		return;
	}
		
	formObj.find("input[name=aplDealInstCdArr]").val(value);
	
	return true;
	
}

</script>                
<body>
	<form name="opnInfoTrst" method="post" action="#">
		<input type="hidden" name ="aplNo" id="aplNo" value="${opnRcpDo.aplNo}" />
		<input type="hidden" name="usrId" id="usrId" value="${sessionScope.loginVO.usrId}">
		<div class="popup">
			<h3>청구서 이송</h3>
			<div id="div-sect" style="padding:15px;">
				<table class="list01">
					<caption>청구서 이송</caption>
					<colgroup>
						<col style="width:120px">
						<col style="width:580px">
					</colgroup>
					<tbody>
						<tr>
							<th>청구제목</th>
							<td>
								${opnRcpDo.aplSj}
							</td>
						</tr>
						<tr>
							<th>이송대상기관</th>
							<td>
								<c:set var="num" value="0" />
								<c:choose>
									<c:when test="${sessionScope.loginVO.accCd eq 'DM'}">
										<span id="accDM_aplDeptNm"></span>
									</c:when>
									<c:otherwise>
										<c:forEach var="instCd" items="${instCodeList}" varStatus="status">
												<input type="checkbox" name="aplDealInstCd" id="aplDealInstCd${instCd.orgCd }" value="${instCd.orgCd }"
												<c:choose>
													<c:when test="${opnRcpDo.prgStatCd eq '01'}">
													<c:if test="${opnRcpDo.aplDealInstCd eq instCd.orgCd}">
															checked
													</c:if>
													>
													</c:when>
													<c:otherwise>
													<c:if test="${opnRcpDo.aplDealInstCd eq instCd.orgCd}">
															disabled="disabled" checked
													</c:if>
													>
													</c:otherwise>
												</c:choose>
											<label for="aplDealInstCd${instCd.orgCd }"> ${instCd.orgNm}</label></input>&nbsp;&nbsp;
											<c:set var="num" value="${num+1}" />
										</c:forEach>
									</c:otherwise>
								</c:choose>
								<input type="hidden" name="relAplInstCd" value="${opnRcpDo.aplDealInstCd}">
								<input type="hidden" name="aplDealInstCdArr">
							</td>
						</tr>
						<tr>
							<th>이송사유</th>
							<td>
								<c:if test="${num eq 1}">
										이송 할 대상 기관이 없습니다.
								</c:if>
								<table class="list02" id="table9710000" style="display:none;">
									<tr>
										<th style="width:150px">국회사무처</th>
										<td style="width:430px">
											<textarea name="trsfCn9710000" rows="4" cols="63"></textarea>
										</td>
									</tr>
								</table>
								<table class="list02" id="table9720000" style="display:none;">
									<tr>
										<th style="width:150px">국회도서관</th>
										<td style="width:430px">
											<textarea name="trsfCn9720000" rows="4" cols="63"></textarea>
										</td>
									</tr>
								</table>
								<table class="list02" id="table9700209" style="display:none;">
									<tr>
										<th style="width:150px">국회예산정책처</th>
										<td style="width:430px">
											<textarea name="trsfCn9700209" rows="4" cols="63"></textarea>
										</td>
									</tr>
								</table>
								<table class="list02" id="table9735000" style="display:none;">
									<tr>
										<th style="width:150px">국회입법조사처</th>
										<td style="width:430px">
											<textarea name="trsfCn9735000" rows="4" cols="63"></textarea>
										</td>
									</tr>
								</table>
							</td>
						</tr>
					</tbody>
				</table>
				<div class="buttons">
					<c:if test="${num ne 1}">
					<a href="javascript:;" class="btn02" title="이송" name="infoTrsfBtnA">이송</a>
					</c:if>
					${sessionScope.button.a_close}
				</div> 
			</div>
		</div>
	</form>
</body>

</html>                          