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
<validator:javascript formName="adminOpenInfTcol" staticJavascript="false" xhtml="true" cdata="false"/>       
<script language="javascript">                
//<![CDATA[                              

function setTcol(SSheet){   
	var srvYn = false;
	var objTab = getTabShowObj();//탭이 oepn된 객체가져옴
	var formObj = objTab.find("form[name=adminOpenInfTcol]");
	formObj.find("a[name=a_reg]").click(function(e) { //등록
		doActionTcol('reg');                 
		return false;                 
	});                 
	formObj.find("a[name=a_save]").click(function(e) { //저장
		doActionTcol('save');                 
		return false;                 
	});                   
	formObj.find("a[name=a_up]").click(function(e) { //위로
		doActionTcol('moveUp');                 
		return false;                 
	}); 
	formObj.find("a[name=a_down]").click(function(e) { //아래로
		doActionTcol('moveDown');                 
		return false;                 
	}); 
	formObj.find("a[name=a_view]").click(function(e) { //미리보기
		doActionTcol('view');                 
		return false;                 
	}); 
	
	formObj.find("input[name=maxCnt]").keyup(function(e) {                     
		 ComInputNumObj(formObj.find("input[name=maxCnt]"));                
		 return false;                                                                 
	 }); 
	
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
	
	objTab.find("button[name=btn_dataSetDtl]").click(function(e) {
		doAction('dataSetDtl');                 
		return false;                            
	});
	objTab.find("button[name=btn_metaDtl]").click(function(e) { 
		doAction('metaDtl');                 
		return false;                            
	});
			
	formObj.find("input[name=srvCd]").val("T"); 
	setLabal(formObj,"T");       
	setLabal2(formObj);
	objTab.find(".tab-inner a").click(function(e) {            
		if($(this).hasClass("on")){
			return;              
		}
		objTab.find(".tab-inner a").removeClass("on");                                                                  
		$(this).addClass("on");                                    
		var talIndex = ($(this).index(".tab-inner a")-8);
		objTab.find("div[name=srvColDiv]").hide();             
		objTab.find("div[name=srvColDiv]").eq(talIndex).show();   
		var sheet = objTab.find("div[name=srvColDiv]").eq(talIndex).find("input[name=SSheetNm]").val();
		var sheetSrvCd = objTab.find("div[name=srvColDiv]").eq(talIndex).find("input[name=srvCd]").val();	
		//7개 헤더 설정       
		if(sheetSrvCd == "T"){
			window[sheet].FitColWidth("6|6|25|25|11|11|11");             
		}else if(sheetSrvCd == "S"){
			window[sheet].FitColWidth("6|6|17|22|6|6|6|6|6|6|6|6");                                                                                 
		}else if(sheetSrvCd == "C"){    
			window[sheet].FitColWidth("4|5|11|20|10|8|8|8|9|9|9");    
		}else if(sheetSrvCd == "M"){
			window[sheet].FitColWidth("6|6|20|25|15|6|6|6");   
		}else if(sheetSrvCd == "L"){                         
			window[sheet].FitColWidth("10|50|30|10");    
		}else if(sheetSrvCd == "F"){
			window[sheet].FitColWidth("5|3|12|12|12|12|10|7|7|7|7|3");  
		}else if(sheetSrvCd == "A"){  
			window[sheet].FitColWidth("6|5|20|25|8|8|8|8|8");    
		}else if(sheetSrvCd == "V"){  
			window[sheet].FitColWidth("7|7|12|15|25|13|13|8");
		}		                                                 
		return false;                                                                                               
	});  
	return srvYn;
} 

function setLabal2(formObj){// labal 동작하기 위해서 id변경(id는 반드시 한개여야함)                  
	formObj.find("#ymqTagY0").attr("id","ymqTagY");   
	formObj.find("#ymqTagM0").attr("id","ymqTagM");                        
	formObj.find("#ymqTagQ0").attr("id","ymqTagQ");   
}
           
function initTcol(sheetName,Tcol){
	 var srvYn  = setTcol(Tcol);                                    
	 if(srvYn){
		 LoadPageTcol(sheetName)
	 }         
 }
 function LoadPageTcol(sheetName)                
{                               
	var gridTitle = "<spring:message code='labal.status'/>";  
	    gridTitle += "|NO"       
		gridTitle +="|"+"<spring:message code='labal.infId'/>";           
		gridTitle +="|"+"<spring:message code='labal.infSeq'/>";   
		gridTitle +="|"+"<spring:message code='labal.colSeq'/>";   
		gridTitle +="|"+"<spring:message code='labal.colId'/>";        
		gridTitle +="|"+"<spring:message code='labal.colNm'/>";    
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
					{Type:"Status",	SaveName:"status",				Width:100,	Align:"Center",		Edit:false}               
					,{Type:"Text",		SaveName:"vOrder",				Width:100,	Align:"Right",		Edit:false}                   
					,{Type:"Text",		SaveName:"infId",			Width:0,	Align:"Right",		Edit:false, Hidden:true}
					,{Type:"Text",		SaveName:"infSeq",			Width:0,	Align:"Right",		Edit:false, Hidden:true}
					,{Type:"Text",		SaveName:"colSeq",			Width:0,	Align:"Right",		Edit:false, Hidden:true}
					,{Type:"Text",		SaveName:"colId",			Width:400,	Align:"Left",		Edit:false}
					,{Type:"Text",		SaveName:"colNm",		Width:400,	Align:"Left",		Edit:false}
					,{Type:"CheckBox",		SaveName:"viewYn",		Width:150,	Align:"Center",		Edit:true, TrueValue:"Y", FalseValue:"N"}
					,{Type:"Popup",		SaveName:"toptSet",		Width:150,	Align:"Center",		Edit:true}
					,{Type:"CheckBox",		SaveName:"useYn",		Width:150,	Align:"Center",		Edit:true, TrueValue:"Y", FalseValue:"N"}
                ];                                                                                                  
                                                            
                              
        InitColumns(cols);                              
        SetExtendLastCol(1);   
        FitColWidth("6|6|25|25|11|11|11");                     
    }                   
    default_sheet(sheetName);              
    doActionTcol("search")
}   


function doActionTcol(sAction)                                  
{
	var classObj = $("."+tabContentClass); //tab으로 인하여 form이 다건임
	var sheetObj; //IbSheet 객체         
	var objTab = getTabShowObj();//탭이 oepn된 객체가져옴
	
	var formObj = objTab.find("form[name=adminOpenInfTcol]");
	sheetObj =formObj.find("input[name=SSheetNm]").val();     
	ajaxBeforeSendAdmin("<c:url value='/admin/ajaxBeforeSendAdmin.do'/>"); //IbSheet 조회전 세션 체크
	var gridObj = window[sheetObj];
	switch(sAction)                    
	{          
		case "search":      //조회    
			var actObj = setTabForm2(classObj,"adminOpenInfTcol"); // 0: form data, 1: form 객체
			var param = actObj[0];
			gridObj.DoSearch("<c:url value='/admin/service/openInfColList.do'/>", param); 
			break;                    
		case "reg":      //등록
			if(setTval(formObj)){                                      
				return;
			}
			if(formObj.find("input[name=ownerCd]").val() == ""){
				alert("데이터셋이 등록되지 않았습니다.");           
				return;    
			}
			var actObj = setTabForm2(classObj,"adminOpenInfTcol"); // 0: form data, 1: form 객체
			var param = actObj[0];
			var url ="<c:url value='/admin/service/openInfColReg.do'/>";
			ajaxCallAdmin(url, param,colcallback);
			LoadPageTcol(gridObj)                    
			formObj.find("a[name=a_reg]").hide();
			formObj.find("a[name=a_up]").show();        
			formObj.find("a[name=a_down]").show();
			formObj.find("a[name=a_save]").show();           
			formObj.find("a[name=a_view]").show();                   
			break;                                        
		case "save":      //저장            
			if(setTval(formObj)){
				return;
			}         
			
			var colCnt = 0;
			//YMQ, ITEM_CD1, CONV_CD, AMT 출력 Y, 사용여부 Y 없어도 안됨
			for ( var i=1; i <= gridObj.RowCount(); i++ ) {
				var colid = gridObj.GetCellValue(i,"colId");
				if(colid == "YMQ" || colid == "ITEM_CD1"  || colid == "CONV_CD" || colid == "AMT"){
					if(gridObj.GetCellValue(i,"viewYn") =="Y" && gridObj.GetCellValue(i,"useYn") == "Y"){
					}else{
						alert(colid+"은(는) 출력여부와 사용여부를 체크해주세요.");
						return;
					}
					colCnt++;
				}
			}
			if(colCnt != 4){             
				alert("YMQ, ITEM_CD1, CONV_CD, AMT 표준컬럼ID가 없습니다.");              
				return;
			}
			
			var actObj = setTabForm2(classObj,"adminOpenInfTcol"); // 0: form data, 1: form 객체
			var param = actObj[0];                   
			ibsSaveJson = gridObj.GetSaveJson(1);                                          
			if(ibsSaveJson.data.length == 0) return;
			var url = "<c:url value='/admin/service/openInfTcolSave.do'/>";
			IBSpostJson(url, param, colcallback);      
			doActionTcol("search");           
			break;         
		case "moveUp":
				var row = gridObj.GetSelectRow();
				gridMove(gridObj,row-1,"vOrder","Y"); //그리드객체, 이동번호, 정렬컬럼, 정렬여부
			break;                 
		case "moveDown":                         
				var row = gridObj.GetSelectRow();               
				gridMove(gridObj,row+2,"vOrder","Y");                                  
			break;       
		case "view":                         
			var infId = formObj.find("input[name=infId]").val();                  
			var srvCd = formObj.find("input[name=srvCd]").val();
			var target = "<c:url value='/admin/service/openInfColViewPopUp.do?infId="+infId+"&srvCd="+srvCd+"'/>";
			var wName = "Tcolview"        
				var wWidth = "1100";
			var wHeight = "768" ;                        
			var wScroll ="no"
			OpenWindow(target, wName, wWidth, wHeight, wScroll)                     
		break; 
	}                           
}      

function setTag(name){
	if(inputCheckYn(name) =="Y"){
		return "1"
	}else{
		return "0"
	}
}

function setTval(formObj){
	var ymqTag ="";
	var viewTag="";
	ymqTag +=setTag("ymqTagY");			
	ymqTag +=setTag("ymqTagM");			
	ymqTag +=setTag("ymqTagQ");//값넣기			
	formObj.find('input[name=ymqTag]').val(ymqTag);
	if(nullCheckValdation(formObj.find('input[name=ymqTag]'),"<spring:message code='labal.searchOpt'/>","000")){
		return true;
	}                      
	if(nullCheckValdation(formObj.find('input[name=maxCnt]'),"<spring:message code='labal.maxCnt'/>","")){
		return true;        
	}   
	if(nullCheckValdation(formObj.find('input:radio[name="srvYn"]'),"<spring:message code='labal.srvYn'/>","")){
		return true;                
	}                                    
	return false;
}
//]]>                                               
</script>             
<div name="srvColDiv" style="display:none">                                                  
	<form name="adminOpenInfTcol"  method="post" action="#">
				<input type="hidden" name="infId">                          
				<input type="hidden" name="SSheetNm"> 
				<input type="hidden" name="srvCd" value="">    
				<input type="hidden" name="ymqTag">                                      
				<input type="hidden" name="viewTag">                                 
				<table class="list01">          
					<caption>공공데이터목록리스트</caption>
					<colgroup>                                 
						<col width="150"/>
						<col width=""/>
					</colgroup>
					<tr>
						<th><spring:message code='labal.infNm'/></th>            
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
						<th><spring:message code='labal.searchOpt'/> <span>*</span></th>
						<td>
							<input type="checkbox"  name="ymqTagY" id="ymqTagY0" value="1"/>
							<label for="ymqTagY"><spring:message code='labal.yy'/> </label>
							<input type="checkbox"name="ymqTagM" id="ymqTagM0" value="1"/>
							<label for="ymqTagM"><spring:message code='labal.mm'/></label>
							<input type="checkbox" name="ymqTagQ" id="ymqTagQ0" value="1"/>
							<label for="ymqTagQ"><spring:message code='labal.qq'/></label>
							&nbsp;&nbsp;&nbsp;&nbsp;
							<spring:message code='labal.maxCnt'/> <input type="text" value="" size="4" name=maxCnt maxlength="4"> 
						</td>
					</tr>
					<tr>
						<th><spring:message code='labal.srvYn'/><span>*</span></th>
						<td>                          
							<input type="radio" value="Y" id="Tuse" name="srvYn"/>
							<label for="Tuse"><spring:message code='labal.yes'/></label>  
							<input type="radio" value="N" id="Tunuse" name="srvYn"/>
							<label for="Tunuse"><spring:message code='labal.no'/></label>
						</td>
					</tr>        
				</table>	
				
				
				<!-- ibsheet 영역 -->
				<div class="ibsheet_area" name="Tcol">               
				</div>                       
				
				<div class="buttons">
					${sessionScope.button.a_up}       
					${sessionScope.button.a_down}           
					${sessionScope.button.a_reg}       
					${sessionScope.button.a_save}       
					${sessionScope.button.a_view}       
				</div>		
	</form> 
</div>