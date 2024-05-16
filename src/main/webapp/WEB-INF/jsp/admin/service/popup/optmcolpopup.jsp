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
	 
	//값 세팅
	regFiltSet();
	 
	popUpEvent();                                     
	//로직처리
	$(popUpOptObj).find("select[name=filtCd]").val("${resultList.filtCd}").change();
	$(popUpOptObj).find("[name=condYn]:radio[value='${resultList.condYn}']").prop("checked",true);	
	$(popUpOptObj).find("select[name=condOp]").val("${resultList.condOp}");	
	reSizeIframePop();//페이지 size계산      

	if("${resultList.filtCd}" == "WORDS"){
		$(popUpOptObj).find("#filtDefault3").val("${resultList.filtDefault}");
		if("${resultList.filtNeed}" == "Y"){
			$(popUpOptObj).find("#filtNeed3").prop("checked",true);
		}
	}
	
	$(popUpOptObj).find("select[name=filtCode]").change(function(e) { 
		var param = $(popUpOptObj).serialize();
		var url ="<c:url value='/admin/service/selectFiltDefault.do'/>";
		ajaxCallAdmin(url, param,setfiltDefault);
	});
	
	//공공데이터 메타 권한에 따른 저장 버튼 처리
	var prssAccCd = Number(getParam("prssAccCd")) || 0;
	if( prssAccCd > 20 ){
		$(popUpOptObj).find("a[name=a_save]").show();
	}else{
		$(popUpOptObj).find("a[name=a_save]").hide();
	}  
	
}); 

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
 
function regFiltSet(){
	$(popUpOptObj).find("select[name=filtCd]").change(function(){

		$(popUpOptObj).find("#wordTr").hide();
		
		var value = $(popUpOptObj).find("select[name=filtCd]").val();
		if(value == ""){
			$(popUpOptObj).find("tr[id=codeTr]").hide();
			$(popUpOptObj).find("select[name=filtCode]").val("");
			$(popUpOptObj).find("select[name=filtDefault1]").empty().append("<option value=''>기본값</option>");
		}else if(value == "WORDS"){
			$(popUpOptObj).find("#wordTr").show();
			objInValNull($(popUpOptObj).find("#wordTr"));
			$(popUpOptObj).find("tr[id=codeTr]").hide();
			$(popUpOptObj).find("select[name=filtCode]").val("");
			$(popUpOptObj).find("select[name=filtDefault1]").empty().append("<option value=''>기본값</option>");
		}else{
			$(popUpOptObj).find("tr[id=codeTr]").show();
		}
		reSizeIframePop();
	});

	$(popUpOptObj).find("input[name=filtYn]:radio[value='${resultList.filtYn}']").prop("checked",true);	
	$(popUpOptObj).find("select[name=filtCd]").val("${resultList.filtCd}");
	$(popUpOptObj).find("select[name=filtCode]").val("${resultList.filtCode}");
	if("${resultList.filtCode}" != null){
		var param = $(popUpOptObj).serialize();
		var url ="<c:url value='/admin/service/selectFiltDefault.do'/>";
		ajaxCallAdmin(url, param,setfiltDefault);
	}
	$(popUpOptObj).find("select[name=filtDefault1]").val("${resultList.filtDefault1}");
	if("${resultList.filtNeed1}" == "Y"){
		$(popUpOptObj).find("input[name=filtNeed1]").prop("checked", true);
	}
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
							
							


							<!----------------------- 필터조건 ------------------------------>
							<tr>                            
								<th>필터조건</th>
								<td>
									<input type="radio" name="filtYn" id="filtY" value="Y" />
									<label for="filtY"><spring:message code='labal.yes'/></label>
									<input type="radio" name="filtYn" id="filtN" value="N"/>
									<label for="filtN"><spring:message code='labal.no'/></label>
								</td>         
							</tr>
							<tr>
								<th>&nbsp;&nbsp;ㄴ 필터유형</th>
								<td>
									<select name="filtCd">
										<option value=""><spring:message code='labal.filtCd'/></option>
										<c:forEach var="code" items="${codeMap.filtCd}" varStatus="status">
												<option value="${code.ditcCd}">${code.ditcNm}</option>
										</c:forEach> 
									</select>
								</td>
							</tr>
							<tr id="codeTr" style="display: none;">
								<th>&nbsp;&nbsp;ㄴ 코드선택</th>
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
							<tr id="wordTr" style="display:none">
								<th>&nbsp;&nbsp;ㄴ 초기값</th>
								<td>
									<input type="text" name="filtDefault3" id= "filtDefault3" value=""/>
									<input type="checkbox"  name="filtNeed3" id="filtNeed3" value="Y"/>              
									<label for="filtNeed1"><spring:message code='labal.need'/></label>
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