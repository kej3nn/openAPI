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
	$(popUpOptObj).find("[name=filtYn]:radio[value='${resultList.filtYn}']").prop("checked",true);	
	$(popUpOptObj).find("select[name=filtCd]").val("${resultList.filtCd}").change();
	$(popUpOptObj).find("select[name=filtCode]").val("${resultList.filtCode}").change();
	$(popUpOptObj).find("#filtDefault1").val("${resultList.filtDefault1}");     
	$(popUpOptObj).find("select[name=filtTblCd]").val("${resultList.filtTblCd}");
	
	if("${resultList.filtNeed1}" == "Y"){
		$(popUpOptObj).find("#filtNeed1").prop("checked",true);        
	}else{
		$(popUpOptObj).find("#filtNeed1").prop("checked",false);
	}
	
	if("${resultList.filtNeed2}" == "Y"){
		$(popUpOptObj).find("#filtNeed2").prop("checked",true);
	}else{
		$(popUpOptObj).find("#filtNeed2").prop("checked",false);
	}                                    
	$(popUpOptObj).find("input[name=filtMaxDay]").val("${resultList.filtMaxDay}");
	
	//공공데이터 메타 권한에 따른 저장 버튼 처리
	var prssAccCd = Number(getParam("prssAccCd")) || 0;
	if( prssAccCd > 20 ){
		$(popUpOptObj).find("a[name=a_save]").show();
	}else{
		$(popUpOptObj).find("a[name=a_save]").hide();
	}  
	
	reSizeIframePop();                  
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
	 
	 $(popUpOptObj).find("input[name=filtMaxDay]").keyup(function(e) {                           
		 ComInputNumObj($(popUpOptObj).find("input[name=filtMaxDay]"));
		 return false;                           
	 }); 
	 
	 
	 
	 $(popUpOptObj).find("select[name=filtCode]").change(function(e) { 
		 var param = $(popUpOptObj).serialize();
		 var url ="<c:url value='/admin/service/selectFiltDefault.do'/>";
		 ajaxCallAdmin(url, param,setfiltDefault);
	 });
	 $(popUpOptObj).find("select[name=filtCd]").change(function(e) {                 
		 	var filtCd = $(this).val();             
		 	 $(popUpOptObj).find("#codeTr").hide();
		 	 $(popUpOptObj).find("#dateTr").hide();                  
		 	 $(popUpOptObj).find("#popupTr").hide();
		 	
		 	switch(filtCd)                    
			{          
				case "CHECK":                
				case "COMBO":      
				case "RADIO":      
					 $(popUpOptObj).find("#codeTr").show();
					 objInValNull($(popUpOptObj).find("#dateTr"));
					 objInValNull($(popUpOptObj).find("#popupTr"));
					break;
				case "CDATE":      
				case "FDATE":      
				case "LDATE":              
				case "PDATE":    
				case "SDATE":   
					 $(popUpOptObj).find("#dateTr").show();                    
					 objInValNull($(popUpOptObj).find("#codeTr"));
					 objInValNull($(popUpOptObj).find("#popupTr"));
					break;          
				case "POPUP":   
					 $(popUpOptObj).find("#popupTr").show();
					 objInValNull($(popUpOptObj).find("#codeTr"));
					 objInValNull($(popUpOptObj).find("#dateTr"));
					break;
				default :
				 objInValNull($(popUpOptObj).find("#codeTr"));
				 objInValNull($(popUpOptObj).find("#dateTr"));
				 objInValNull($(popUpOptObj).find("#popupTr"));
			}                 
		 	$(popUpOptObj).find("input[name=filtMaxDay]").val("1");
		 	reSizeIframePop();                        
			return false;                                   
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
	 if(radio == "Y"){
		 if(nullCheckValdation($(popUpOptObj).find("select[name=condOp]"),"<spring:message code='labal.condOp'/>","")){
			 return true;
		 }
		 if(nullCheckValdation($(popUpOptObj).find("input[name=condVar]"),"<spring:message code='labal.condVar'/>","")){
			 return true;
		 }
	 }
	 radio = inputRadioVal("filtYn");
	 if(radio == "Y"){
		 if(nullCheckValdation($(popUpOptObj).find("select[name=filtCd]"),"<spring:message code='labal.filtCd'/>","")){
			 return true;
		 }
		switch($(popUpOptObj).find("select[name=filtCd]").val())                    
		{          
				case "CHECK":                
				case "COMBO":      
				case "RADIO":      
					 if(nullCheckValdation($(popUpOptObj).find("select[name=filtCode]"),"<spring:message code='labal.filtCode'/>","")){
						 return true;
					 }
					if(inputCheckYn("filtNeed1") =="Y"){
						if(nullCheckValdation($(popUpOptObj).find("select[name=filtDefault1]"),"<spring:message code='labal.filtDefault'/>","")){
							 return true;
						 }
					}
					break;           
				case "FDATE":      
				case "LDATE":              
				case "PDATE":    
				case "SDATE":                                              
					if($(popUpOptObj).find("input[name=filtMaxDay]").val() == "" || $(popUpOptObj).find("input[name=filtMaxDay]").val() == "0"){
						$(popUpOptObj).find("input[name=filtMaxDay]").val("1");                         
					}                                      
					break;          
				case "POPUP":   
					if(nullCheckValdation($(popUpOptObj).find("select[name=filtTblCd]"),"<spring:message code='labal.tblCd'/>","")){
						 return true;
					 }
					if(inputCheckYn("filtNeed2") =="Y"){
						if(nullCheckValdation($(popUpOptObj).find("input[name=filtDefault2]"),"<spring:message code='labal.filtDefault'/>","")){
							 return true;
						 }
					}            
					break;
				default :
					break;
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
			<input type="hidden" name="srcColId" value="${resultList.srcColId}">                          
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
							<tr>                            
								<th><spring:message code='labal.filtCond'/></th>
								<td>
									<input type="radio" name="filtYn" id="filtY" value="Y" />
									<label for="filtY"><spring:message code='labal.yes'/></label>
									<input type="radio" name="filtYn" id="filtN" value="N"/>
									<label for="filtN"><spring:message code='labal.no'/></label>
									 
								</td>         
							</tr>
							<tr>
								<th>&nbsp;&nbsp;ㄴ <spring:message code='labal.filtCd'/></th>
								<td>
									<select name="filtCd">
										<option value=""><spring:message code='labal.filtCd'/></option>
										<c:forEach var="code" items="${codeMap.filtCd}" varStatus="status">
												<option value="${code.ditcCd}">${code.ditcNm}</option>
										</c:forEach> 
									</select>
								</td>
							</tr>            
							<tr id="dateTr" style="display:none">
								<th>&nbsp;&nbsp;ㄴ <spring:message code='labal.filtMaxDay'/></th>
								<td><spring:message code='labal.condY'/> <input type="text" size="4" name="filtMaxDay" maxlength="4" value="${resultList.filtMaxDay}"/> 일</td>
							</tr>
							<tr id="codeTr" style="display:none">
								<th>&nbsp;&nbsp;ㄴ <spring:message code='labal.codeSel'/></th>
								<td>
									<c:out value="${resultList.colId}"/> =       
									<select name="filtCode">
										<option value=""><spring:message code='labal.filtCode'/></option>
										<c:forEach var="code" items="${codeMap.filtCode}" varStatus="status">
												<option value="${code.ditcCd}">${code.ditcNm}</option>
										</c:forEach>
									</select>
									<select id="filtDefault1" name="filtDefault1">
										<option value=""><spring:message code='labal.filtDefault'/></option>
									</select>
									<input type="checkbox"  name="filtNeed1" id="filtNeed1" value="Y"/>              
									<label for="filtNeed1"><spring:message code='labal.need'/></label>
								</td>
							</tr>                  
							<tr id="popupTr" style="display:none">
								<th>&nbsp;&nbsp;ㄴ <spring:message code='labal.popOpt'/></th>
								<td>
									<c:out value="${resultList.colId}"/> =                  
									<select name="filtTblCd">
										<option value=""><spring:message code='labal.tblCd'/></option>
										<c:forEach var="code" items="${codeMap.tblCd}" varStatus="status">
												<option value="${code.ditcCd}">${code.ditcNm}</option>
										</c:forEach>
									</select>
									<input type="text" size="30" id="filtDefault2" name="filtDefault2" value="${resultList.filtDefault2}" maxlength="100"/>
									<input type="checkbox" name="filtNeed2" id="filtNeed2" value="Y"/>                  
									<label for="filtNeed2"><spring:message code='labal.need'/></label>
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