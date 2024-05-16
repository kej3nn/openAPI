<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>  
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>       
<!--
	validate 사용시 반드시 선언
	formName명과 validate 함수명이 연결되어있음
	adminCommUsr -> validateAdminCommUsr 체크함
	resources/validator/*.* xml을 만들어서 사용
  -->
<validator:javascript formName="adminOpenInfMcol" staticJavascript="false" xhtml="true" cdata="false"/>       
<script language="javascript">                
//<![CDATA[                              
function setMcol(SSheet){   
	var srvYn = false;
	var objTab = getTabShowObj();//탭이 oepn된 객체가져옴
	var formObj = objTab.find("form[name=adminOpenInfMcol]");
	formObj.find("a[name=a_reg]").click(function(e) { //등록
		doActionMcol('reg');                 
		return false;                 
	});                 
	formObj.find("a[name=a_save]").click(function(e) {
		doActionMcol('save');                 
		return false;                 
	});      
	formObj.find("a[name=a_up]").click(function(e) { //위로
		doActionMcol('moveUp');                 
		return false;                 
	}); 
	formObj.find("a[name=a_down]").click(function(e) { //아래로
		doActionMcol('moveDown');                 
		return false;                 
	}); 
	formObj.find("a[name=a_view]").click(function(e) { //미리보기
		doActionMcol('view');                 
		return false;                            
	})
	
	if(formObj.find(':radio[name="srvYn"]:checked').val() !=undefined){
		formObj.find("a[name=a_reg]").hide();
		srvYn = true;                 
	}else{              
		formObj.find("a[name=a_up]").hide();          
		formObj.find("a[name=a_down]").hide();               
		formObj.find("a[name=a_save]").hide();
		formObj.find("a[name=a_view]").hide();                  
	}     
	
	if(formObj.find("input[name=SSheetNm]").val() ==""){
		formObj.find("input[name=SSheetNm]").val(SSheet);    
	}              
	
	formObj.find("input[name=srvCd]").val("M");        
	setLabal(formObj,"M"); //라벨 이름 중복됨(id 변경))
	return srvYn;
} 
           
function initMcol(sheetName,Mcol){
	 var srvYn  = setMcol(Mcol);                      
	 if(srvYn){
		 LoadPageMcol(sheetName)
	 }         
 }
 function LoadPageMcol(sheetName)                
{                               
	var gridTitle = "<spring:message code='labal.status'/>";  
	    gridTitle += "|NO"       
		gridTitle +="|"+"<spring:message code='labal.infId'/>";           
		gridTitle +="|"+"<spring:message code='labal.infSeq'/>";   
		gridTitle +="|"+"<spring:message code='labal.colSeq'/>";   
		gridTitle +="|"+"<spring:message code='labal.colId'/>";        
		gridTitle +="|"+"<spring:message code='labal.colNm'/>";    
		gridTitle +="|"+"<spring:message code='labal.colCd'/>";    
		gridTitle +="|"+"<spring:message code='labal.viewYn'/>";    
		gridTitle +="|"+"<spring:message code='labal.optSet'/>";    
		gridTitle +="|"+"<spring:message code='labal.useYn'/>";    
	
    with(sheetName){
    	                     
    	var cfg = {SearchMode:3,Page:50};                                        
        SetConfig(cfg);  
        var headers = [                                                                   
                    {Text:gridTitle, Align:"Center"}                          
                ];
        var headerInfo = {Sort:0,ColMove:1,ColResize:1,HeaderCheck:1};         
                        
        InitHeaders(headers, headerInfo); 
            
        
        //문자는 왼쪽정렬
        //숫자는 오른쪽정렬
        //코드값은 가운데정렬                  
        var cols = [          
					{Type:"Status",	SaveName:"status",				Width:50,	Align:"Center",		Edit:false}               
					,{Type:"Seq",		SaveName:"seq",				Width:30,	Align:"Right",		Edit:false}            
					,{Type:"Text",		SaveName:"infId",			Width:100,	Align:"Right",		Edit:false, Hidden:true}
					,{Type:"Text",		SaveName:"infSeq",			Width:100,	Align:"Right",		Edit:false, Hidden:true}
					,{Type:"Text",		SaveName:"colSeq",			Width:100,	Align:"Right",		Edit:false, Hidden:true}
					,{Type:"Text",		SaveName:"colId",			Width:150,	Align:"Left",		Edit:false}
					,{Type:"Text",		SaveName:"colNm",		Width:200,	Align:"Left",		Edit:false}
					,{Type:"Combo",		SaveName:"colCd",		Width:70,	Align:"Center",		Edit:true}
					,{Type:"CheckBox",		SaveName:"viewYn",		Width:70,	Align:"Center",		Edit:true, TrueValue:"Y", FalseValue:"N"}
					,{Type:"Popup",		SaveName:"moptSet",		Width:70,	Align:"Center",		Edit:true}
					,{Type:"CheckBox",		SaveName:"useYn",		Width:70,	Align:"Center",		Edit:true, TrueValue:"Y", FalseValue:"N"}
                                        
                ];                                                      
                                                            
               
        InitColumns(cols);                                                                           
        FitColWidth();                                                               
              
        SetExtendLastCol(1);   
        SetColProperty("colCd", 	${codeMap.colCdIbs});    //InitColumns 이후에 셋팅 
    }                   
    default_sheet(sheetName);              
    doActionMcol("search")
}   


 function doActionMcol(sAction)                                  
 {
 	var classObj = $("."+tabContentClass); //tab으로 인하여 form이 다건임
 	var actObj = setTabForm2(classObj,"adminOpenInfMcol"); // 0: form data, 1: form 객체
 	var sheetObj; //IbSheet 객체         
 	var param = actObj[0]  ;  
 	var objTab = getTabShowObj();//탭이 oepn된 객체가져옴
 	
 	var formObj = objTab.find("form[name=adminOpenInfMcol]");
 	sheetObj =formObj.find("input[name=SSheetNm]").val();     
 	ajaxBeforeSendAdmin("<c:url value='/admin/ajaxBeforeSendAdmin.do'/>"); //IbSheet 조회전 세션 체크
 	var gridObj = window[sheetObj];
 	switch(sAction)                    
 	{          
 		case "search":      //조회    
 			gridObj.DoSearch("<c:url value='/admin/service/openInfColList.do'/>", param); 
 			break;                    
 		case "reg":      //등록
 			if (!validateAdminOpenInfMcol(document.adminOpenInfMcol[1])){
				return;                               
			}
 			
 			if(formObj.find("input[name=ownerCd]").val() == ""){
				alert("데이터셋이 등록되지 않았습니다.");           
				return;    
			}
 			
 			var url ="<c:url value='/admin/service/openInfColReg.do'/>";
 			ajaxCallAdmin(url, param,colcallback);
 			LoadPageMcol(gridObj)                    
 			formObj.find("a[name=a_reg]").hide();
 			formObj.find("a[name=a_up]").show();        
			formObj.find("a[name=a_down]").show();
 			formObj.find("a[name=a_save]").show();
 			formObj.find("a[name=a_view]").show();                   
 			break;          
 		case "moveUp":
			var row = gridObj.GetSelectRow();
			gridMove(gridObj,row-1,"vOrder","Y"); //그리드객체, 이동번호, 정렬컬럼, 정렬여부
			break;                 
		case "moveDown":                         
			var row = gridObj.GetSelectRow();               
			gridMove(gridObj,row+2,"vOrder","Y");                                  
			break;       
 		case "save":      //저장       
 			if(colCheckM(gridObj)){                                           
 				return;
 			}
 			ibsSaveJson = gridObj.GetSaveJson(1);                                          
 			if(ibsSaveJson.data.length == 0) return;
 			var url = "<c:url value='/admin/service/openInfMcolSave.do'/>";
 			IBSpostJson(url, param, colcallback);      
 			doActionMcol("search");           
 			break;                    
 		case "view":                         
 			var infId = formObj.find("input[name=infId]").val();                  
 			var srvCd = formObj.find("input[name=srvCd]").val();
 			var target = "<c:url value='/admin/service/openInfColViewPopUp.do?infId="+infId+"&srvCd="+srvCd+"'/>";
 			var wName = "mcolview"        
 			var wWidth = "1100";
			var wHeight = "768" ;                                   
 			var wScroll ="no"    
 			OpenWindow(target, wName, wWidth, wHeight, wScroll)                     
 		break; 
 	}                           
 }     
 
 function colCheckM(gridObj){ // X, Y는 반드시 하나만 존재해야한다.
	 var X_Cnt = 0;
	 var Y_Cnt = 0;
	 var M_Cnt = 0;
	 var P_Cnt = 0;
	 for(var i = 1 ; i < gridObj.RowCount()+1; i++){     
		var colCd = gridObj.GetCellValue(i,"colCd");       
		if(colCd == "X_WGS84"){
			X_Cnt++;
		}else if(colCd == "Y_WGS84"){
			Y_Cnt++;
		}else if(colCd == "MARKER"){
			M_Cnt++;
		}else if(colCd == "POLYGON" || colCd == "POLYLINE"){
			P_Cnt++;
		}

	}
	if(X_Cnt == 0){
		alert("X 좌표는 반드시 하나가 존재해야합니다.");
		return true;
	}
	if(X_Cnt  > 1){
		alert("X 좌표는 하나만 존재해야합니다.");
		return true;
	}
	if(Y_Cnt == 0){
		alert("Y 좌표는 반드시 하나가 존재해야합니다.");
		return true;
	}
	if(Y_Cnt  > 1){
		alert("Y 좌표는 하나만 존재해야합니다.");
		return true;         
	}
	
	if(M_Cnt > 1){
		alert("마커구분은 하나만 존재해야합니다.");
		return true;
	}
	if(P_Cnt > 1){
		alert("폴리곤, 폴리라인은 하나만 존재해야합니다.");
		return true;         
	}
	return false;
 }
//]]>            
</script> 
<div name="srvColDiv" style="display:none">  
<form name="adminOpenInfMcol"  method="post" action="#">
				<input type="hidden" name="infId">                          
				<input type="hidden" name="SSheetNm"> 
				<input type="hidden" name="srvCd" value="">           
				<input type="hidden" name="prssAccCd">        
				<table class="list01">
					<caption>공공데이터목록리스트</caption>
					<colgroup>
						<col width="150"/>
						<col width=""/>
					</colgroup>
					<tr>
						<th><spring:message code='labal.infNm'/></th>            
						<td colspan="7">
							<input type="text" name="infNm" value="" style="width:500px" placeholder="(한)" ReadOnly/>
							${sessionScope.button.btn_dataSetDtl}         
							${sessionScope.button.btn_metaDtl}
						</td>         
					</tr>        
					<tr>   
						<th><spring:message code='labal.dataSet'/></th>
						<td colspan="7">
							<input type="text" name="ownerCd"  style="width:150px" value="" placeholder="OWNER" ReadOnly/> 
							<input type="text" name="dsId" style="width:200px" value="" placeholder="DS_ID" ReadOnly/>
							<input type="text" name="dsNm"  style="width:250px"value="" placeholder="DS_NM" ReadOnly/>
						</td>
					</tr>
					<tr>      
						<th><spring:message code='labal.markerCd'/> <span>*</span></th>                             
						<td> 
							<select name="markerCd">                  
									<option value=""><spring:message code='etc.select'/></option>
									<c:forEach var="code" items="${codeMap.markerCd}" varStatus="status">
											<option value="${code.ditcCd}">${code.ditcNm}</option>
									</c:forEach>
							</select>
						</td>
						<th>X 기준</th>                             
						<td> 
							<input type="text" name="xPos" value="">
						</td>
						<th>Y 기준</th>                             
						<td> 
							<input type="text" name="yPos" value="">
						</td>
						<th>기준 레벨</th>                             
						<td> 
							<select name="mapLevel">                  
									<option value="1">1</option>
									<option value="2">2</option>
									<option value="3">3</option>
									<option value="4">4</option>
									<option value="5">5</option>
									<option value="6">6</option>
									<option value="7">7</option>
									<option value="8">8</option>
									<option value="9">9</option>
									<option value="10">10</option>
							</select>
						</td>
					</tr>
					<tr>
						<th><spring:message code='labal.srvYn'/> <span>*</span></th>                 
						<td colspan="7">   
							<input type="radio" value="Y" id="Muse" name="srvYn"/>
							<label for="Muse"><spring:message code='labal.yes'/></label>  
							<input type="radio" value="N" id="Munuse" name="srvYn"/>
							<label for="Munuse"><spring:message code='labal.no'/></label>
						</td>
						
					</tr>   
										   
				</table>	
				
				
				<!-- ibsheet 영역 -->
				<div class="ibsheet_area" name="Mcol">               
				</div>
				
				<div class="buttons">
					${sessionScope.button.a_reg}       
					<%-- ${sessionScope.button.a_save}      --%>
					<a href="javascript:;" class="btn03" title="저장" name="a_save">저장</a>  
					${sessionScope.button.a_view}       
				</div>		
</form> 
</div>  