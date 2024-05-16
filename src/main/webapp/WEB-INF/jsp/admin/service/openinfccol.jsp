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
<%-- <validator:javascript formName="adminOpenInfCcol" staticJavascript="false" xhtml="true" cdata="false"/>        --%>
<script language="javascript">                
//<![CDATA[                              
function setCcol(SSheet){   
	var srvYn = false;
	var objTab = getTabShowObj();//탭이 oepn된 객체가져옴
	var formObj = objTab.find("form[name=adminOpenInfCcol]");
 	var gridObj = window[SSheet];
	
	formObj.find("a[name=a_reg]").click(function(e) { //등록
		doActionCcol('reg');                 
		return false;                 
	});                 
	formObj.find("a[name=a_save]").click(function(e) {	//저장
		doActionCcol('save');                 
		return false;                 
	});     
	formObj.find("a[name=a_up]").click(function(e) { //위로
		doActionCcol('moveUp');                 
		return false;                 
	}); 
	formObj.find("a[name=a_down]").click(function(e) { //아래로
		doActionCcol('moveDown');                 
		return false;                 
	}); 
	formObj.find("a[name=a_view]").click(function(e) { //미리보기
		doActionCcol('view');                 
		return false;                 
	}); 
	if(formObj.find(':radio[name="srvYn"]:checked').val() !=undefined){
		formObj.find("a[name=a_reg]").hide();
		srvYn = true;                 
	}else{              
		formObj.find("a[name=a_save]").hide();
		formObj.find("a[name=a_view]").hide();                  
	}     
	
	if(formObj.find("input[name=SSheetNm]").val() ==""){
		formObj.find("input[name=SSheetNm]").val(SSheet);    
	}              
	
// 	formObj.find("input[name=lytitNmEng]").keyup(function(e) {                     
// 		ComInputEngBlankNumObj(formObj.find("input[name=lytitNmEng]"));    
// 		return false;                                                                          
// 	 });  
// 	formObj.find("input[name=rytitNmEng]").keyup(function(e) {                     
// 		ComInputEngBlankNumObj(formObj.find("input[name=rytitNmEng]"));    
// 		return false;                                                                          
// 	 });  
	
	formObj.find("select[name=sgrpCd]").change(function(){		// 시리즈그룹 변경할 때
		var sgrpCd = formObj.find("select[name=sgrpCd]").val();
		if(sgrpCd == "BAR"){
			gridObj.SetColProperty("seriesCd", 	${codeMap.barCdIbs});           
		}else{
			gridObj.SetColProperty("seriesCd", 	${codeMap.pieIbs});   
		}
		
	});
	
	formObj.find("input[name=srvCd]").val("C");        
	setLabal(formObj,"C"); //라벨 이름 중복됨(id 변경))
	return srvYn;
} 
           
function initCcol(sheetName,Ccol){
	 var srvYn  = setCcol(Ccol);                      
	 if(srvYn){
		 LoadPageCcol(sheetName);
	 }         
 }
 function LoadPageCcol(sheetName)                
{                               
	var gridTitle = "<spring:message code='labal.status'/>";  
	    gridTitle += "|NO"       
		gridTitle +="|"+"<spring:message code='labal.infId'/>";           
		gridTitle +="|"+"<spring:message code='labal.infSeq'/>";   
		gridTitle +="|"+"<spring:message code='labal.colSeq'/>";   
		gridTitle +="|"+"<spring:message code='labal.colId'/>";        
		gridTitle +="|"+"<spring:message code='labal.colNm'/>";    
		gridTitle +="|"+"<spring:message code='labal.seriesCd'/>";
		gridTitle +="|단위";
		gridTitle +="|"+"<spring:message code='labal.yaxisPos'/>";    
		gridTitle +="|"+"<spring:message code='labal.xaxisYn'/>";    
		gridTitle +="|"+"<spring:message code='labal.sortTag'/>";    
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
            
        
                 
        var cols = [          
					{Type:"Status",	SaveName:"status",				Width:15,	Align:"Center",		Edit:false}               
					,{Type:"Seq",		SaveName:"seq",				Width:10,	Align:"Center",		Edit:false}
					,{Type:"Text",		SaveName:"infId",			Width:70,	Align:"Center",		Edit:false, Hidden:true}
					,{Type:"Text",		SaveName:"infSeq",			Width:70,	Align:"Center",		Edit:false, Hidden:true}
					,{Type:"Text",		SaveName:"colSeq",			Width:70,	Align:"Center",		Edit:false, Hidden:true}
					,{Type:"Text",		SaveName:"colId",			Width:150,	Align:"Left",		Edit:false}
					,{Type:"Text",		SaveName:"colNm",		Width:200,	Align:"Left",		Edit:false}
					,{Type:"Combo",		SaveName:"seriesCd",		Width:70,	Align:"Center",		Edit:true}
					,{Type:"Combo",		SaveName:"unitCd",			Width:70,	Align:"Center",		Edit: false}
					,{Type:"Combo",		SaveName:"yaxisPos",		Width:70,	Align:"Center",		Edit:true}
					,{Type:"Radio",		SaveName:"xaxisYn",		Width:70,	Align:"Center",		Edit:true, TrueValue:"Y", FalseValue:"N"}
					,{Type:"Combo",		SaveName:"sortTag",		Width:70,	Align:"Center",		Edit:true}
					,{Type:"CheckBox",		SaveName:"viewYn",		Width:70,	Align:"Center",		Edit:true, TrueValue:"Y", FalseValue:"N"}
					,{Type:"Popup",		SaveName:"coptSet",		Width:70,	Align:"Center",		Edit:true}
					,{Type:"CheckBox",		SaveName:"useYn",		Width:70,	Align:"Center",		Edit:true, TrueValue:"Y", FalseValue:"N"}
                                        
                ];                                                      
                                                            
               
        InitColumns(cols);                                                                           
        FitColWidth();                                                               
        SetExtendLastCol(1);   
        SetColProperty("seriesCd", 	${codeMap.seriesCdIbs});    //InitColumns 이후에 셋팅
        SetColProperty("unitCd", 	${codeMap.unitCdIbs});		// 단위
        SetColProperty("sortTag", 	{ComboCode:"|A|D", 	ComboText:"|Asc|Desc"});    //InitColumns 이후에 셋팅 
        SetColProperty("yaxisPos", 	{ComboCode:"|L|R", 	ComboText:"|왼쪽|오른쪽"});    //InitColumns 이후에 셋팅         
        SetColProperty("xaxisYn", 	{ComboCode:"|Y|N", 	ComboText:"|Y|N"});    //InitColumns 이후에 셋팅         
    }                   
    default_sheet(sheetName);              
    doActionCcol("search")
    doActionCcol("initCombo");
}   


 function doActionCcol(sAction)                                  
 {
 	var classObj = $("."+tabContentClass); //tab으로 인하여 form이 다건임
 	var actObj = setTabForm2(classObj,"adminOpenInfCcol"); // 0: form data, 1: form 객체
 	var sheetObj; //IbSheet 객체         
 	var param = actObj[0]  ;  
 	var objTab = getTabShowObj();//탭이 oepn된 객체가져옴
 	
 	var formObj = objTab.find("form[name=adminOpenInfCcol]");
 	sheetObj =formObj.find("input[name=SSheetNm]").val();     
 	ajaxBeforeSendAdmin("<c:url value='/admin/ajaxBeforeSendAdmin.do'/>"); //IbSheet 조회전 세션 체크
 	var gridObj = window[sheetObj];
 	switch(sAction)                    
 	{          
 		case "search":      //조회    
 			gridObj.DoSearch("<c:url value='/admin/service/openInfColList.do'/>", param); 
 			break;                    
 		case "reg":      //등록
 			if(formObj.find(':radio[name="srvYn"]:checked').val() ==undefined){
 				alert("필수 입력값...");   
 				return;	
 			}
 			
 			if(formObj.find("input[name=ownerCd]").val() == ""){
				alert("데이터셋이 등록되지 않았습니다.");           
				return;    
			}
 			
 			var url ="<c:url value='/admin/service/openInfColReg.do'/>";
 			ajaxCallAdmin(url, param,colcallback);
 			LoadPageCcol(gridObj);                    
 			formObj.find("a[name=a_reg]").hide();
 			formObj.find("a[name=a_save]").show();
 			formObj.find("a[name=a_view]").show();                   
 			break;          
 		case "save":      //저장           
 			if(!saveCheck(gridObj)){                            
 				return;
 			}
 			param += "&rytitNm="+escape(encodeURIComponent(formObj.find("input[name=rytitNm2]").val())); 		//한글깨짐..
 			param += "&lytitNm="+escape(encodeURIComponent(formObj.find("input[name=lytitNm2]").val())); 		//한글깨짐.. 
 			ibsSaveJson = gridObj.GetSaveJson(1);                                          
 			if(ibsSaveJson.data.length == 0) return;
 			var url = "<c:url value='/admin/service/openInfCcolSave.do'/>";
 			IBSpostJson(url, param, colcallback);      
 			doActionCcol("search");           
 			break;                    
 		case "view":                         
 			var infId = formObj.find("input[name=infId]").val();                  
 			var srvCd = formObj.find("input[name=srvCd]").val();
 			var sgrpCd = formObj.find("select[name=sgrpCd]").val();
 			var target = "<c:url value='/admin/service/openInfColViewPopUp.do?sgrpCd="+sgrpCd+"&infId="+infId+"&srvCd="+srvCd+"'/>";
 			var wName = "ccolview"        
 			var wWidth = "1100";            
 			var wHeight = "768"                            
 			var wScroll ="yes"
 			OpenWindow(target, wName, wWidth, wHeight, wScroll);
 		break; 
 		case "initCombo":
 			if(formObj.find("select[name=sgrpCd]").val() == "BAR") {
 				gridObj.SetColProperty("seriesCd", 	${codeMap.barCdIbs});      
 			} else if(formObj.find("select[name=sgrpCd]").val() == "PIE") {
 				gridObj.SetColProperty("seriesCd", 	${codeMap.pieIbs});   
 			}
 		break;      
		case "moveUp":
			var row = gridObj.GetSelectRow();
			gridMove(gridObj,row-1,"vOrder","Y"); //그리드객체, 이동번호, 정렬컬럼, 정렬여부
		break;                 
		case "moveDown":                         
			var row = gridObj.GetSelectRow();               
			gridMove(gridObj,row+2,"vOrder","Y");                                  
		break;       
 	}                           
 }     
 
function saveCheck(gridObj){ 
	var objTab = getTabShowObj();//탭이 oepn된 객체가져옴
 	var formObj = objTab.find("form[name=adminOpenInfCcol]");
 	var yaxisCnt = 0;
	var xaxisCnt = 0;
	
	for(i=1; i<=gridObj.RowCount() ; i++ ){
		var yaxisPos = gridObj.GetCellValue(i, "yaxisPos");
		var rytitNm = formObj.find("input[name=rytitNm2]").val();
		var lytitNm = formObj.find("input[name=lytitNm2]").val();
		var viewYn = gridObj.GetCellValue(i, "viewYn");
		var useYn = gridObj.GetCellValue(i, "useYn");
		var xaxisYn = gridObj.GetCellValue(i, "xaxisYn");
		var sgrpCd = formObj.find("select[name=sgrpCd]").val();
		// 시리즈타입이 파이일 경우 Y축명 필요음슴 그러니 수정하셈
		
		if(nullCheckValdation(formObj.find("select[name=sgrpCd]"),"시리즈그룹","")){ 
			return false; 
		}
		if(sgrpCd == "BAR"){
			if(yaxisPos == "L" && viewYn == "Y" && useYn == "Y"){			// 왼쪽Y축명이 없을 경우
				if(lytitNm == ""){
					alert("왼쪽 Y축명을 입력해주세요.");
					formObj.find("input[name=lytitNm2]").focus();
					return false;
				}
			}
			if(yaxisPos == "R" && viewYn == "Y" && useYn == "Y"){			// Y축위치를 오른쪽으로 지정했을 때 오른쪽Y축명이 없을 경우
				if(rytitNm == ""){
					alert("오른쪽 Y축명을 입력해주세요.");
					formObj.find("input[name=rytitNm2]").focus();
					return false;
				}
			}
		}
		if(xaxisYn == "Y"){	//x축기준인 컬럼은 출력여부와 사용여부 모두 체크되어야 한다
			if(viewYn == "N" || useYn == "N"){
				alert("X축기준인 컬럼의 출력여부와 사용여부를 체크해주세요");
				return false;
			}
			xaxisCnt++;
		}else{
			if(viewYn == "Y" && useYn == "Y"){
				yaxisCnt++;
			}
		}
	}
	if(yaxisCnt == 0){
		alert("Y축이 될 하나 이상의 컬럼의 출력여부와 사용여부를 체크해주세요.");
		return false;
	}
	if(xaxisCnt == 0){
		alert("X축기준이 될 컬럼을 선택해주세요.");
		return false;
	}
	return true;
 }
//]]>            
</script> 
<div name="srvColDiv" style="display:none">  
<form name="adminOpenInfCcol"  method="post" action="#">
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
						<th>공<spring:message code='labal.infNm'/></th>            
						<td>
							<input type="text" name="infNm" value="" style="width:500px" placeholder="(한)" ReadOnly/>
							${sessionScope.button.btn_dataSetDtl}         
							${sessionScope.button.btn_metaDtl}            
						</td>         
					</tr>        
					<tr>   
						<th><spring:message code='labal.dataSet'/></th>
						<td>
							<input type="text" name="ownerCd"  style="width:150px" value="" placeholder="OWNER" ReadOnly/> 
							<input type="text" name="dsId" style="width:200px" value="" placeholder="DS_ID" ReadOnly/>
							<input type="text" name="dsNm"  style="width:250px"value="" placeholder="DS_NM" ReadOnly/>
						</td>
					</tr>
					<tr>
						<th><label class=""><spring:message code="labal.sgrpCd"/></label> <span>*</span></th>
						<td>
							<select name="sgrpCd">
								<option value="">선택</option>
								<c:forEach var="code" items="${codeMap.sgrpCd}" varStatus="status">
									<option value="${code.ditcCd}">${code.ditcNm}</option>
								</c:forEach>
							</select>
						</td>
					</tr>
					<tr>
						<th><label class=""><spring:message code="labal.series"/></label></th>
						<td>
							<label class=""><spring:message code="labal.seriesPosx"/></label>
							<select name="seriesPosx">
								<option value="">선택</option>
								<option value="R">오른쪽</option>
								<option value="C">가운데</option>
								<option value="L">왼쪽</option>
							</select>
							<label class=""><spring:message code="labal.seriesPosy"/></label>
							<select name="seriesPosy">
								<option value="">선택</option>
								<option value="T">상</option>
								<option value="M">중</option>
								<option value="B">하</option>
							</select>
							<label class=""><spring:message code="labal.seriesOrd"/></label>
							<select name="seriesOrd">
								<option value="">선택</option>
								<option value="W">가로</option>
								<option value="H">세로</option>
							</select>
							<input type="checkbox" name="seriesFyn" value="Y"/>
							<label class=""><spring:message code="labal.seriesFyn"/></label>
						</td>
					</tr>
					<tr>
						<th rowspan="2"><label class=""><spring:message code="labal.xaxisYInfo"/></label></th>
						<td>
							왼쪽 <input type="text" name="lytitNm2" />
							오른쪽 <input type="text" name="rytitNm2" />
						</td>
					</tr>
					<tr>
						<td>
						<label class=""><spring:message code="labal.ylnCd"/></label>
						<select name="ylnCd">
							<option value="">선택</option>
							<c:forEach var="code" items="${codeMap.ylnCd}" varStatus="status">
							  <option style="background-color:${code.valueCd}" value="${code.ditcCd}">${code.ditcNm}</option>
							</c:forEach>
						</select>
						<label class=""><spring:message code="labal.xlnCd"/></label>
						<select name="xlnCd">
							<option value="">선택</option>
							<c:forEach var="code" items="${codeMap.xlnCd}" varStatus="status">
							  <option style="background-color:${code.valueCd}" value="${code.ditcCd}">${code.ditcNm}</option>
							</c:forEach>
						</select>
						</td>
					</tr>
					<tr>
						<th><spring:message code='labal.srvYn'/></th>                 
						<td>
							<input type="radio" value="Y" id="Muse" name="srvYn"/>
							<label for="Muse"><spring:message code='labal.yes'/></label>  
							<input type="radio" value="N" id="Munuse" name="srvYn"/>
							<label for="Munuse"><spring:message code='labal.no'/></label>
						</td>
					</tr>        
				</table>	
				
				
				<!-- ibsheet 영역 -->
				<div class="ibsheet_area" name="Ccol">               
				</div>
				
				<div class="buttons">
					${sessionScope.button.a_reg}       
					<%-- ${sessionScope.button.a_save} --%>
					<a href="javascript:;" class="btn03" title="저장" name="a_save">저장</a>       
					${sessionScope.button.a_view}       
				</div>		
</form> 
</div>  