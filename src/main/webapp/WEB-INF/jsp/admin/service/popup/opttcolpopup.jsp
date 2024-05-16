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
	//로직처리
	$(popUpOptObj).find("[name=condYn]:radio[value='${resultList.condYn}']").prop("checked",true);	
	$(popUpOptObj).find("select[name=condOp]").val("${resultList.condOp}");	
	var param = $(popUpOptObj).serialize();
	var url ="<c:url value='/admin/service/selectItemCd.do'/>";
	ajaxCallAdmin(url, param,setItemCd);                
	ajaxCallAdmin(url, param,setItemCd); 
	reSizeIframePop();//페이지 size계산                                                                   
}); 
 
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
 }
 
 function setItemCd(data){
	 $(popUpOptObj).find("select[name=itemCd]").empty();         
	 if(data.itmeCd != null){             
		 obj = "<option value=''>기본값</option>";                  
		 for(var i = 0 ; i <data.itmeCd.length; i++){
			 if("${resultList.itemCd}" == data.itmeCd[i].ditcCd){
				 obj+="<option value='"+data.itmeCd[i].ditcCd+"' selected='selected'>"+data.itmeCd[i].ditcNm+"</option>";
			 }else{
				 obj+="<option value='"+data.itmeCd[i].ditcCd+"'>"+data.itmeCd[i].ditcNm+"</option>";
			 }      
		 }
		 $(popUpOptObj).find("select[name=itemCd]").append(obj);      
	 }         
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
                                       
 function validation(){
	 var flag = false;
	 var radio = inputRadioVal("condYn");
	 if(radio == "Y"){
		if(nullCheckValdation($(popUpOptObj).find("select[name=condOp]"),"<spring:message code='labal.condOp'/>","")){
			return true;
		}
		if(nullCheckValdation($(popUpOptObj).find("input[name=condVar]"),"<spring:message code='labal.condVar'/>","")){
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
			<input type="hidden" name="dtId" value="${resultList.dtId}">
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
									<select name="condOp">
										<option value=""><spring:message code='labal.condOp'/></option>
										<c:forEach var="code" items="${codeMap.condOp}" varStatus="status">
												<option value="${code.ditcCd}">${code.ditcNm}</option>
										</c:forEach>        
									</select>
									<input type="text" name="condVar" value="${resultList.condVar}" maxlength="250"/>
									(<spring:message code='labal.valNotUse'/>)
								</td>
							</tr> 
							<c:if test="${resultList.statYn eq 'Y'}">              
							<tr>
								<th><spring:message code='labal.colAttr'/></th>    
								<td>
									<select name="itemCd">
										<option value=''>기본값</option>             
									</select>
								</td>
							</tr>
							</c:if>      
						</table>                   
						
						<div class="buttons">
							${sessionScope.button.a_save}
							${sessionScope.button.a_close}        
						</div>         
					</div>
				</div>
</form>
</body>
</html>                             