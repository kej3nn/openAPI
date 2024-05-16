<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
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
//<![CDATA[                                         
 var popUpOptObj = "form[name=adminOpenInfOptPop]";                 
 $(document).ready(function()    {      
	popUpEvent();

	//라디오버튼 선택
	$(popUpOptObj).find("[name=condYn]:radio[value='${resultList.condYn}']").prop("checked",true);	
	$(popUpOptObj).find("[name=reqYn]:radio[value='${resultList.reqYn}']").prop("checked",true);	
	$(popUpOptObj).find("[name=reqType]:radio[value='${resultList.reqType}']").prop("checked",true);	
	//셀렉트박스 선택	
	$(popUpOptObj).find("select[name=condOp]").val("${resultList.condOp}");
	$(popUpOptObj).find("select[name=reqOp]").val("${resultList.reqOp}");
// 	$(popUpOptObj).find("select[name=filtCode]").val("${resultList.filtCode}");
	//체크박스 선택
	if ( $(popUpOptObj).find("input:checkbox[name=reqNeed]").val() == "Y" ) {
		$(popUpOptObj).find("input:checkbox[name=reqNeed]").prop("checked", true);
		$(popUpOptObj).find("input[name=reqNeed]").attr("disabled", false);
	} else {
		$(popUpOptObj).find("input:checkbox[name=reqNeed]").prop("checked", false);
		$(popUpOptObj).find("input[name=reqNeed]").attr("disabled", true);
	}
	
	//필수여부 선택시 값 세팅
	$(popUpOptObj).find("input:checkbox[name=reqNeed]").click(function() {
		var isChecked = $(this).prop("checked");
		if ( isChecked ) {
			$(this).val("Y");
		} else {
			$(this).val("N");
		}
	});
	
	//공공데이터 메타 권한에 따른 저장 버튼 처리
	var prssAccCd = Number(getParam("prssAccCd")) || 0;
	if( prssAccCd > 20 ){
		$(popUpOptObj).find("a[name=a_save]").show();
	}else{
		$(popUpOptObj).find("a[name=a_save]").hide();
	}  
	
	//선택여부 클릭시
	//$(popUpOptObj).find("input:radio[name=condYn]:checked").click();
	//$(popUpOptObj).find("input:radio[name=reqYn]:checked").click();
	initialButtonSet();
	reSizeIframePop();                  
}); 
 
 
function initialButtonSet() { 
	if ( $(popUpOptObj).find("input:radio[name=condYn]:checked").val() == "Y" ) {
		$(popUpOptObj).find("select[name=condOp]").attr("disabled", false);
		$(popUpOptObj).find("input[name=condVar]").attr("readonly", false);
	} else {
		$(popUpOptObj).find("select[name=condOp]").attr("readonly", true);
		$(popUpOptObj).find("select[name=condOp] option:eq(0)").attr("selected", "selected");
		$(popUpOptObj).find("input[name=condVar]").attr("readonly", true);
	}
	
	if ( $(popUpOptObj).find("input:radio[name=reqYn]:checked").val() == "Y" ) {
		$(popUpOptObj).find("select[name=reqOp]").attr("disabled", false);
// 		$(popUpOptObj).find("select[name=filtCode]").attr("disabled", false);
		$(popUpOptObj).find("input[name=reqNeed]").attr("disabled", false);
		$(popUpOptObj).find("input[name=reqType]").attr("disabled", false);
		//$(popUpOptObj).find("input[name=reqType] option:eq(0)").prop("checked", true);
		//$(popUpOptObj).find("input:radio[name=reqType]").removeAttr("checked");	//체크되어있는 것 초기화
	} else {
		$(popUpOptObj).find("select[name=reqOp]").attr("disabled", true);
		$(popUpOptObj).find("select[name=reqOp] option:eq(0)").attr("selected", "selected");
// 		$(popUpOptObj).find("select[name=filtCode]").attr("disabled", true);
// 		$(popUpOptObj).find("select[name=filtCode] option:eq(0)").attr("selected", "selected");
		$(popUpOptObj).find("input[name=reqNeed]").attr("disabled", true);
		$(popUpOptObj).find("input[name=reqNeed]").prop("checked", false);
		$(popUpOptObj).find("input[name=reqNeed]").val("N");
		$(popUpOptObj).find("input[name=reqType]").attr("disabled", true);
		//$(popUpOptObj).find("input[name=reqType]").val("");
	}
} 
 
function popUpEvent(){  
	$(popUpOptObj).find("a[name=a_save]").click(function(e) { 
		doActionOpt("save");
		return false;
	}); 
	$(popUpOptObj).find("a[name=a_close]").click(function(e) { 
		parent.doAction("popclose");                
		return false;                
	}); 
	
	$(popUpOptObj).find(".popup_close").click(function(e) {             
		$(popUpOptObj).find("a[name=a_close]").click();    
		return false;                
	}); 
	 
	//조건 클릭시 조건항목 disabled 및 readonly
	$(popUpOptObj).find("input[name=condYn]").change(function(e) {
		if ( $(popUpOptObj).find("input:radio[name=condYn]:checked").val() == "Y" ) {
			$(popUpOptObj).find("select[name=condOp]").attr("disabled", false);
			$(popUpOptObj).find("input[name=condVar]").attr("readonly", false);
			//$(popUpOptObj).find("input:radio[name=reqType]").removeAttr("checked");	//체크되어있는 것 초기화
		} else {
			$(popUpOptObj).find("select[name=condOp]").attr("readonly", true);
			$(popUpOptObj).find("select[name=condOp] option:eq(0)").attr("selected", "selected");
			$(popUpOptObj).find("input[name=condVar]").attr("readonly", true);
			//$(popUpOptObj).find("input[name=condVar]").val("");
		} 
	});  
	 
	$(popUpOptObj).find("input[name=reqYn]").change(function(e) {
		if ( $(popUpOptObj).find("input:radio[name=reqYn]:checked").val() == "Y" ) {
			$(popUpOptObj).find("select[name=reqOp]").attr("disabled", false); 
// 			$(popUpOptObj).find("select[name=filtCode]").attr("disabled", false);
			$(popUpOptObj).find("input[name=reqNeed]").attr("disabled", false);
			$(popUpOptObj).find("input[name=reqType]").attr("disabled", false);
			$(popUpOptObj).find("input:radio[name=reqType]").removeAttr("checked");	//체크되어있는 것 초기화
		} else {
			$(popUpOptObj).find("select[name=reqOp]").attr("disabled", true);
			$(popUpOptObj).find("select[name=reqOp] option:eq(0)").attr("selected", "selected");
// 			$(popUpOptObj).find("select[name=filtCode]").attr("disabled", true);
// 			$(popUpOptObj).find("select[name=filtCode] option:eq(0)").attr("selected", "selected");
			$(popUpOptObj).find("input[name=reqNeed]").attr("disabled", true);
			$(popUpOptObj).find("input[name=reqNeed]").prop("checked", false);
			$(popUpOptObj).find("input[name=reqNeed]").val("N");
			$(popUpOptObj).find("input[name=reqType]").attr("disabled", true);
			//$(popUpOptObj).find("input[name=reqType]").val("");
		} 
	});  
	
}
 
 function doActionOpt(sAction)                                  
 {                    
	 switch(sAction)                    
		{          
			case "save":      //저장
				if(validation()){
					return;           
				}
				var param = $(popUpOptObj).serialize();
				var url ="<c:url value='/admin/service/openInfColOptPopUpSave.do'/>";
				ajaxCallAdmin(url, param,ibscallback);
				$(popUpOptObj).find("a[name=a_close]").click();    
				break;                                 
		}        
 } 
 
 function radioClick(item) {}
 
 function setfiltDefault(data){
	 $(popUpOptObj).find("#filtDefault1").empty();         
	 if(data.filtDefault != null){
		 obj = "<option value=''>기본값</option>";                  
		 for(var i = 0 ; i <data.filtDefault.length; i++){
			 obj+="<option value='"+data.filtDefault[i].ditcCd+"'>"+data.filtDefault[i].ditcNm+"</option>"
		 }
		 $(popUpOptObj).find("#filtDefault1").append(obj);              
	 } 
 }
 
 function validation(){
	 var flag = false;
	 var radio = inputRadioVal("condYn");
	 var radioReq = inputRadioVal("reqYn");
	 if(radio == "Y"){
		 if(nullCheckValdation($(popUpOptObj).find("select[name=condOp]"),"<spring:message code='labal.condOp'/>","")){
			 return true;
		 }
		 if(nullCheckValdation($(popUpOptObj).find("input[name=condVar]"),"<spring:message code='labal.condVar'/>","")){
			 return true;
		 }
	 }
	 if(radioReq == "Y"){
		 if(nullCheckValdation($(popUpOptObj).find("select[name=reqOp]"),"검색요청 연산자","")){
			 return true;
		 }
		 if(nullCheckValdation($(popUpOptObj).find("input:radio[name=reqType]"),"요청인자타입","")){
			 return true;
		 }
	 }
	
	 return flag;
 }
//]]>                                                                    
</script>                
<body>
<form name="adminOpenInfOptPop"  method="post" action="#">
			<input type="hidden" name="infId" value="${resultList.infId}">
			<input type="hidden" name="infSeq" value="${resultList.infSeq}">              
			<input type="hidden" name="colSeq" value="${resultList.colSeq}">
			<input type="hidden" name="srvCd" value="${resultList.srvCd}">
			<div class="popup">
					<h3><spring:message code='labal.optSet'/></h3>
					<a href="#" class="popup_close">x</a>
					<div style="padding:15px;">
						<p class="text-title"><spring:message code='labal.defaultInfo'/></p>
						<table class="list01">              
						<colgroup>
							<col width="150"/>
							<col width=""/>
						</colgroup>
							<tr>
								<th><spring:message code='labal.infNm'/></th>
								<td><c:out value="${resultList.infNm}"/></td>
							</tr>
							<tr>      
								<th><spring:message code='labal.dataSet'/></th>
								<td><c:out value="${resultList.ownerCd}"/>.<c:out value="${resultList.dsId}"/>(<c:out value="${resultList.dsNm}"/>)</td>
							</tr>
						</table>
						
						<p class="text-title"><spring:message code='labal.colOpt'/></p>
						<table class="list01">
						<colgroup>
							<col width="150"/>
							<col width=""/>
						</colgroup>
							<tr>
								<th><spring:message code='labal.tgtCol'/></th>
								<td><c:out value="${resultList.colId}"/>(<c:out value="${resultList.colNm}"/>)</td>
							</tr>
							<tr>
								<th rowspan="2"><spring:message code='labal.condYn'/></th>
								<td>
									<input type="radio" name="condYn" id="condY" value="Y" />
									<label for="condY"><spring:message code='labal.condY'/></label>
									<input type="radio" name="condYn" id="condn" value="N" />
									<label for="condn"><spring:message code='labal.condN'/></label>
								</td>
							</tr>                         
							<tr>
								<td>
									<c:out value="${resultList.colId}"/>
									<select name="condOp" disabled="disabled">
										<option value=""><spring:message code='labal.condOp'/></option>
										<c:forEach var="code" items="${codeMap.condOp}" varStatus="status">
												<option value="${code.ditcCd}">${code.ditcNm}</option>
										</c:forEach>        
									</select>
									<input type="text" name="condVar" value="${resultList.condVar}" maxlength="250" readonly/>
									(<spring:message code='labal.valNotUse'/>)
								</td>
							</tr> 
							<tr>
								<th>검색요청조건</th>
								<td>
									<input type="radio" name="reqYn" value="Y" />
									<label for="reqY"><spring:message code='labal.yes'/></label>
									<input type="radio" name="reqYn" value="N" />
									<label for="reqN"><spring:message code='labal.no'/></label>
								</td>
							</tr>
							<tr>
								<th>요청정보</th>
								<td>
									<c:out value="${resultList.colId}"/>
									<select name="reqOp" disabled="disabled">
										<option value=""><spring:message code='labal.condOp'/></option>
										<c:forEach var="code" items="${codeMap.condOp}" varStatus="status">
												<option value="${code.ditcCd}">${code.ditcNm}</option>
										</c:forEach>        
									</select>
									<input type="checkbox" name="reqNeed" id="reqNeed" value="${resultList.reqNeed}" disabled="true">필수요청</input>
								</td>
							</tr>
							<tr>
								<th>요청인자타입</th>
								<td>
									
									<input type="radio" name="reqType" id="reqType" value="STRING" />
									<label for="reqTypeY">String</label>&nbsp;
									<input type="radio" name="reqType" id="reqType" value="INTEGER" />
									<label for="reqTypen">Integer</label>
								</td>
							</tr>
						</table>                   
						
						<div class="buttons">
							<%-- ${sessionScope.button.a_save} --%>
							<a href="javascript:;" class="btn03" title="저장" name="a_save">저장</a>
							${sessionScope.button.a_close}
						</div>         
					</div>
				</div>
</form>
</body>
</html>                             