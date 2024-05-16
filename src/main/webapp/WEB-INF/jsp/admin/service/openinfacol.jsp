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
<validator:javascript formName="adminOpenInfAcol" staticJavascript="false" xhtml="true" cdata="false"/>       
<script language="javascript">                
//<![CDATA[                              
function setAcol(SSheet){   
	var srvYn = false;
	var objTab = getTabShowObj();//탭이 oepn된 객체가져옴
	var formObj = objTab.find("form[name=adminOpenInfAcol]");
	formObj.find("a[name=a_reg]").click(function(e) { //등록
		doActionAcol('reg');                 
		return false;                 
	});                 
	formObj.find("a[name=a_save]").click(function(e) {
		doActionAcol('save');                 
		return false;                 
	});      
	formObj.find("a[name=a_up]").click(function(e) { //위로
		doActionAcol('moveUp');                 
		return false;                 
	}); 
	formObj.find("a[name=a_down]").click(function(e) { //아래로
		doActionAcol('moveDown');                 
		return false;                 
	}); 
	formObj.find("a[name=a_view]").click(function(e) { //미리보기
		doActionAcol('view');                 
		return false;                            
	})
	formObj.find("button[name=btn_dup]").click(function(e) { //미리보기
		doActionAcol('dup');                 
		return false;                            
	})                 
	
	formObj.find("a[name=a_view]").click(function(e) { //미리보기
		doActionAcol('view');                 
		return false;                            
	})
	formObj.find("a[name=a_tview]").click(function(e) { //미리보기
		doActionAcol('tview');                 
		return false;                            
	})
	
// 	formObj.find("input[name=apiRes]").keyup(function(e) {			//리소스명 영문만     
// 		ComInputEngObj(formObj.find("input[name=apiRes]"));   
 		
//  		return false;                                                                          
//  	});
	formObj.find("input[name=apiRes]").keyup(function(e) { 			// 리소스명 영문, 숫자만                    
		ComInputEngNumObj(formObj.find("input[name=apiRes]"));    
		formObj.find("input[name=apiResDup]").val("N");
 		return false;                                                                          
 	});
	formObj.find("input[name=apiTrf]").keyup(function(e) { 			// 건수 숫자만                    
		ComInputNumObj(formObj.find("input[name=apiTrf]"));    
 		return false;                                                                          
 	});
	formObj.find("input[name=apiExp2]").keyup(function(e) { 			// API 한글, 숫자만 입력                    
		ComInputKorNumObj(formObj.find("input[name=apiExp2]"));    
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
		formObj.find("a[name=a_tview]").hide(); 
	}     
	
	if(formObj.find("input[name=SSheetNm]").val() ==""){
		formObj.find("input[name=SSheetNm]").val(SSheet);    
	}              
	formObj.find("input[name=srvCd]").val("A");        
	setLabal(formObj,"A"); //라벨 이름 중복됨(id 변경))
	
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
			window[sheet].FitColWidth("5|7|13|13|13|13|7|7|7|7|7");    
		}else if(sheetSrvCd == "A"){  
			window[sheet].FitColWidth("6|5|20|25|8|8|8|8|8");    
		}else if(sheetSrvCd == "V"){  
			window[sheet].FitColWidth("7|7|12|15|25|13|13|8");
		}		                                                 
		return false;                                                                                               
	}); 
	
	
	return srvYn;
} 

function setAcolTwo(SSheet){   
	var srvYn = false;
	var objTab = getTabShowObj();//탭이 oepn된 객체가져옴
	var formObj = objTab.find("form[name=adminOpenInfAcolTwo]");
	
	formObj.find("a[name=a_add]").click(function(e) { //등록
		doActionAcolTwo('reg');                 
		return false;                 
	});                 
	formObj.find("a[name=a_save]").click(function(e) {
		doActionAcolTwo('save');                 
		return false;                 
	});      
	formObj.find("a[name=a_up]").click(function(e) { //위로
		doActionAcolTwo('moveUp');                 
		return false;                 
	}); 
	formObj.find("a[name=a_down]").click(function(e) { //아래로
		doActionAcolTwo('moveDown');                 
		return false;                 
	});
	
	if(formObj.find("input[name=SSheetNmTwo]").val() ==""){
		formObj.find("input[name=SSheetNmTwo]").val(SSheet);    
	}
	
	return true;
} 

function setAcolTwoObjSet() {
	var srvYn = false;
	var objTab = getTabShowObj();//탭이 oepn된 객체가져옴
	var formObj = objTab.find("form[name=adminOpenInfAcolTwo]");
	formObj.find("a[name=a_up]").hide();          
	formObj.find("a[name=a_down]").hide();       
	formObj.find("a[name=a_add]").hide();
	formObj.find("a[name=a_save]").hide(); 
}

function setAcolTwoObjShow() {
	//var srvYn = false;
	var objTab = getTabShowObj();//탭이 oepn된 객체가져옴
	var formObj = objTab.find("form[name=adminOpenInfAcolTwo]");
	formObj.find("a[name=a_up]").show();          
	formObj.find("a[name=a_down]").show();       
	formObj.find("a[name=a_add]").show();
	formObj.find("a[name=a_save]").show(); 
}

function initAcol(sheetName,Acol){
	 var srvYn  = setAcol(Acol);   
	 if(srvYn){
		 LoadPageAcol(sheetName);
	 }         
}
	 
function initAcolTwo(sheetName,Acol){
	 var srvYn = setAcolTwo(Acol);
	 if(srvYn){
		 LoadPageAcolTwo(sheetName);
	 }         
}

function LoadPageAcol(sheetName)                
{                               
	var gridTitle = "<spring:message code='labal.status'/>";  
	    gridTitle += "|NO|vOrder"       
		gridTitle +="|"+"<spring:message code='labal.infId'/>";           
		gridTitle +="|"+"<spring:message code='labal.infSeq'/>";   
		gridTitle +="|"+"<spring:message code='labal.colSeq'/>";   
		gridTitle +="|"+"<spring:message code='labal.colId'/>";        
		gridTitle +="|"+"<spring:message code='labal.colNm'/>";    
		gridTitle +="|"+"<spring:message code='labal.viewCd'/>";    
		gridTitle +="|"+"<spring:message code='labal.sortTag'/>";      
		gridTitle +="|"+"<spring:message code='labal.filtCode'/>";      
		gridTitle +="|"+"<spring:message code='labal.viewYn'/>";   
		gridTitle +="|"+"<spring:message code='labal.optSet'/>";    
		gridTitle +="|"+"<spring:message code='labal.useYn'/>";  		
	
    with(sheetName){
    	                     
    	var cfg = {SearchMode:2,Page:50,VScrollMode:1};                                        
        SetConfig(cfg);  
        var headers = [                                                                   
                    {Text:gridTitle, Align:"Center"}                          
                ];
        var headerInfo = {Sort:0,ColMove:1,ColResize:1,HeaderCheck:1};         
                        
        InitHeaders(headers, headerInfo); 
                 
        var cols = [          
					 {Type:"Status",		SaveName:"status",		Width:30,	Align:"Center",		Edit:false}               
					,{Type:"Seq",			SaveName:"seq",			Width:30,	Align:"Center",		Edit:false}               
					,{Type:"Text",			SaveName:"vOrder",		Width:50,	Align:"Right",		Edit:false, Hidden:true}                   
					,{Type:"Text",			SaveName:"infId",		Width:10,	Align:"Right",		Edit:false, Hidden:true}
					,{Type:"Int",			SaveName:"infSeq",		Width:10,	Align:"Right",		Edit:false, Hidden:true}
					,{Type:"Text",			SaveName:"colSeq",		Width:10,	Align:"Right",		Edit:false, Hidden:true}
					,{Type:"Text",			SaveName:"colId",		Width:350,	Align:"Left",		Edit:true}
					,{Type:"Text",			SaveName:"colNm",		Width:350,	Align:"Left",		Edit:true}
					,{Type:"Combo",			SaveName:"viewCd",		Width:50,	Align:"Center",		Edit:true}
					,{Type:"Combo",			SaveName:"sortTag",		Width:50,	Align:"Center",		Edit:true}
					,{Type:"Text",			SaveName:"filtCd",		Width:50,	Align:"Center",		Edit:true, Hidden:true}
					,{Type:"CheckBox",		SaveName:"viewYn",		Width:50,	Align:"Center",		Edit:true, TrueValue:"Y", FalseValue:"N"}
					,{Type:"Popup",			SaveName:"aoptSet",		Width:50,	Align:"Center",		Edit:true}
					,{Type:"CheckBox",		SaveName:"useYn",		Width:50,	Align:"Center",		Edit:true, TrueValue:"Y", FalseValue:"N"}
                ];                                                      
               
        InitColumns(cols);     
        SetExtendLastCol(1);   
        FitColWidth();
        SetColProperty("viewCd", 	${codeMap.viewCdApiIbs});    //InitColumns 이후에 셋팅 
        SetColProperty("sortTag", 	{ComboCode:"|A|D", 	ComboText:"|Asc|Desc"});    //InitColumns 이후에 셋팅 
    }                   
    default_sheet(sheetName);              
    doActionAcol("search");
}

function LoadPageAcolTwo(sheetName)                
{    
	//var gridTitle = "상태|No|infId|infSeq|uriSeq|샘플명(한글)|샘플명 URL|URI 파라미터|순서|사용여부";
	var gridTitle = "<spring:message code='labal.status'/>";  
	    gridTitle += "|NO";       
		gridTitle +="|"+"<spring:message code='labal.infId'/>";           
		gridTitle +="|"+"<spring:message code='labal.infSeq'/>";   
		gridTitle +="|"+"<spring:message code='labal.uriSeq'/>";   
		gridTitle +="|"+"<spring:message code='labal.uriNm'/>";    
		gridTitle +="|"+"<spring:message code='labal.uri'/>";    
		gridTitle +="|"+"<spring:message code='labal.uriParam'/>";    
		gridTitle +="|"+"<spring:message code='labal.vOrder'/>";    
		gridTitle +="|"+"<spring:message code='labal.useYn'/>";    
		
    with(sheetName){
    	                     
    	var cfg = {SearchMode:2,Page:50,VScrollMode:1};                                        
        SetConfig(cfg);  
        var headers = [                                                                   
                    {Text:gridTitle, Align:"Center"}                          
                ];
        var headerInfo = {Sort:0,ColMove:1,ColResize:1,HeaderCheck:1};         
                        
        InitHeaders(headers, headerInfo); 
                 
        var cols = [          
					 {Type:"Status",		SaveName:"status",		Width:50,	Align:"Center",		Edit:false}               
					,{Type:"Seq",			SaveName:"seq",			Width:50,	Align:"Right",		Edit:false}                   
					,{Type:"Text",			SaveName:"infId",		Width:30,	Align:"Left",		Edit:false,		Hidden:true}
					,{Type:"Int",			SaveName:"infSeq",		Width:30,	Align:"Left",		Edit:false,		Hidden:true}
					,{Type:"Text",			SaveName:"uriSeq",		Width:30,	Align:"Left",		Edit:false,		Hidden:true}
					,{Type:"Text",			SaveName:"uriNm",		Width:350,	Align:"Left",		Edit:true}
					,{Type:"Text",			SaveName:"uri",			Width:450,	Align:"Left",		Edit:true}
					,{Type:"Text",			SaveName:"uriParam",	Width:450,	Align:"Left",		Edit:true}
					,{Type:"Text",			SaveName:"uriVOrder",	Width:50,	Align:"Right",		Edit:false,		Hidden:true}
					,{Type:"CheckBox",		SaveName:"uriUseYn",	Width:50,	Align:"Center",		Edit:true, TrueValue:"Y", FalseValue:"N"}
                ];                                                      
               
        InitColumns(cols);     
        SetExtendLastCol(1);   
        FitColWidth();
        SetColProperty("viewCd", 	${codeMap.viewCdIbs});    //InitColumns 이후에 셋팅 
        SetColProperty("sortTag", 	{ComboCode:"A|D", 	ComboText:"Asc|Desc"});    //InitColumns 이후에 셋팅 
    }                   
    default_sheet(sheetName);              
    doActionAcolTwo("searchUri");
} 

// Open API Sheet action
function doActionAcol(sAction)                                  
{
 	var classObj = $("."+tabContentClass); //tab으로 인하여 form이 다건임
 	var actObj = setTabForm2(classObj,"adminOpenInfAcol"); // 0: form data, 1: form 객체
 	var sheetObj; //IbSheet 객체         
 	var param = actObj[0]  ;  
 	var objTab = getTabShowObj();//탭이 oepn된 객체가져옴
 	
 	var formObj = objTab.find("form[name=adminOpenInfAcol]");
 	sheetObj =formObj.find("input[name=SSheetNm]").val();    
 	ajaxBeforeSendAdmin("<c:url value='/admin/ajaxBeforeSendAdmin.do'/>"); //IbSheet 조회전 세션 체크
 	var gridObj = window[sheetObj];
 	switch(sAction)                    
 	{          
 		case "search":      //조회    
 			gridObj.DoSearch("<c:url value='/admin/service/openInfAcolList.do'/>", param); 
 			break;
 		case "reg":      //등록
 			if( !colCheck(formObj, true) ) {                            
 				return;
 			}
 			if(formObj.find("input[name=ownerCd]").val() == ""){
				alert("데이터셋이 등록되지 않았습니다.");           
				return;    
			}
 			var url ="<c:url value='/admin/service/openInfColReg.do'/>";
 			param += "&apiExp="+escape(encodeURIComponent(formObj.find("input[name=apiExp2]").val())); 		//한글깨짐..
 			
 			ajaxCallAdmin(url, param,colcallback);
 			LoadPageAcol(gridObj);                    
 			formObj.find("a[name=a_reg]").hide();
 			formObj.find("a[name=a_up]").show();        
			formObj.find("a[name=a_down]").show();
 			formObj.find("a[name=a_save]").show();
 			formObj.find("a[name=a_view]").show();
 			formObj.find("a[name=a_tview]").show();
 			SheetCreate("AcolTwo", getTabShowObjNum(), "150");//API2
 			setAcolTwoObjShow();
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
 			if( !colCheck(formObj, false) ){                            
 				return;
 			}
 			ibsSaveJson = gridObj.GetSaveJson(1);                                          
 			if(ibsSaveJson.data.length == 0) return;
 			var url = "<c:url value='/admin/service/openInfAcolSave.do'/>";
 			param += "&apiExp="+escape(encodeURIComponent(formObj.find("input[name=apiExp2]").val())); 		//한글깨짐..
 			IBSpostJson(url, param, colcallback);      
 			doActionAcol("search");           
 			break;                  			
 		case "dup" :		//리소스 중복체크
			if(nullCheckValdation(formObj.find('input[name=apiRes]'),"리소스","")){
				return true;
			}	
			var url = "<c:url value='/admin/basicinf/openInfAcolApiDup.do'/>"; 
			ajaxCallAdmin(url,actObj[0],dupCallBack);
			break;	
 		case "view":   
 			var infId = formObj.find("input[name=infId]").val();                  
 			var srvCd = formObj.find("input[name=srvCd]").val();
 			var apiRes = formObj.find("input[name=apiRes]").val();
 			var target = "<c:url value='/admin/service/openInfColViewPopUp.do?infId="+infId+"&srvCd="+srvCd+"&apiRes="+apiRes+"&popupUse=Y'/>";
 			var wName = "Acolview";        
 			var wWidth = "1100";                             
 			var wHeight = "760";                                       
 			var wScroll ="yes";    
 			OpenWindow(target, wName, wWidth, wHeight, wScroll);
 			break; 	
 		case "tview":   
 			var infId = formObj.find("input[name=infId]").val();                  
 			var srvCd = formObj.find("input[name=srvCd]").val();
 			var apiRes = formObj.find("input[name=apiRes]").val();
 			var target = "<c:url value='/admin/service/openInfColTestViewPopUp.do?infId="+infId+"&srvCd="+srvCd+"&apiRes="+apiRes+"&popupUse=Y'/>";
 			var wName = "Acolview";        
 			var wWidth = "1100";                             
 			var wHeight = "760";                                       
 			var wScroll ="yes";    
 			OpenWindow(target, wName, wWidth, wHeight, wScroll);
 			break; 	
 	}                           
}

// 입력/수정 validation
function colCheck(obj, regYn) {
	var rtnVal = false;
	if(nullCheckValdation(obj.find('input[name=apiRes]'),"리소스명","")){
		rtnVal = false;		return;
	}
	if(nullCheckValdation(obj.find('input[name=apiTrf]'),"제한 건수","")){
		rtnVal = false;		return;
	}
	if(nullCheckValdation(obj.find('input[name=apiExp2]'),"API명","")){
		rtnVal = false;		return;
	}
	if(obj.find(':radio[name="srvYn"]:checked').val() ==undefined){
		alert("서비스 여부를 선택해 주세요");
		rtnVal = false;		return;
	}
	if ( regYn ) {
		if(obj.find('input[name=apiResDup]').val() == "N"){
			alert("중복확인 버튼을 클릭해주세요.");
			rtnVal = false;		return;
		}
	}
	
	return true;
 }
 
 //URI Sheet Action
 function doActionAcolTwo(sAction)                                  
 {
 	var classObj = $("."+tabContentClass); //tab으로 인하여 form이 다건임
 	var actObj = setTabForm2(classObj,"adminOpenInfAcol"); // 0: form data, 1: form 객체
 	//var actObj2 = setTabForm2(classObj,"adminOpenInfAcol"); // 0: form data, 1: form 객체
 	var sheetObj; //IbSheet 객체         
 	var sheetObj2; //IbSheet2 객체         
 	//var param = actObj[0]  ;  
 	var objTab = getTabShowObj();//탭이 oepn된 객체가져옴
 	
 	var formObj = objTab.find("form[name=adminOpenInfAcol]");
 	var formObj2 = objTab.find("form[name=adminOpenInfAcolTwo]");
 	sheetObj =formObj.find("input[name=SSheetNm]").val();     
 	sheetObj2 =formObj2.find("input[name=SSheetNmTwo]").val();     
 	ajaxBeforeSendAdmin("<c:url value='/admin/ajaxBeforeSendAdmin.do'/>"); //IbSheet 조회전 세션 체크
 	var gridObj = window[sheetObj];
 	var gridObj2 = window[sheetObj2];
 	switch(sAction)                    
 	{          
 		case "searchUri":      //조회    
 			formObj.find("input[name=popupUse]").val("");
 			gridObj2.DoSearch("<c:url value='/admin/service/openInfAcolUriList.do'/>", actObj[0]); 
 			break;                    
 		case "reg":      //등록
 			var newRow = gridObj2.DataInsert(-1);
 			gridObj2.SetCellValue(newRow, "uri", objTab.find("input[name=apiEp]").val()+"/"+objTab.find("input[name=apiRes]").val());	//IBS uri값에 도메인 입력
 			gridObj2.SetCellValue(newRow, "infId", gridObj.GetCellValue(1, "infId"));	//순서 현재seq 카운팅
 			gridObj2.SetCellValue(newRow, "infSeq", gridObj.GetCellValue(1, "infSeq"));	//순서 현재seq 카운팅
 			gridObj2.SetCellValue(newRow, "uriSeq", gridObj2.RowCount());				//URI_SEQ 카운팅
 			gridObj2.SetCellValue(newRow, "uriVorder", gridObj2.RowCount());			//순서 현재seq 카운팅
 			gridObj2.SetCellValue(newRow, "uriUseYn", true);			//순서 현재seq 카운팅
 			break;          
 		case "moveUp":
			var row = gridObj2.GetSelectRow();
			gridMove(gridObj2,row-1,"uriVOrder","Y"); //그리드객체, 이동번호, 정렬컬럼, 정렬여부
			break;                 
		case "moveDown":                         
			var row = gridObj2.GetSelectRow();               
			gridMove(gridObj2,row+2,"uriVOrder","Y");                                  
			break;       
 		case "save":      //저장                                 
 			ibsSaveJson = gridObj2.GetSaveJson(1);                                          
 			if(ibsSaveJson.data.length == 0) return;
 			var url = "<c:url value='/admin/service/openInfAcolApiUriSave.do'/>";
 			IBSpostJson(url, actObj[0], colcallback);      
 			doActionAcolTwo("searchUri");          
 			break;                     
 	}                           
 }  
 
 
function dupCallBack(res){
	var objTab = getTabShowObj();//탭이 oepn된 객체가져옴
	var formObj = objTab.find("form[name=adminOpenInfAcol]");
	if(res.RESULT.CODE == -1){
		alert("중복된 리소스가 존재합니다.");
		formObj.find("input[name=apiResDup]").val("N");
		formObj.find("input[name=apiRes]").val("");
	}else{                           
		alert("등록 가능합니다.");
		formObj.find("input[name=apiResDup]").val("Y");
	}
} 

function aColValidation(gridObj, Row, Col, Value) {
	if (Col == 5) { //5번째 컬럼만 체크하여 값이 없을경우에만 실행한다. url명 체크
		if ( gridObj.GetCellValue(Row, Col) == "" ) {
			alert("값을 입력해 주세요.");
			gridObj.validateFail(1);
			gridObj.SetSelectCell(Row, Col);
			return false;
		}
	}
}
 
//]]>            
</script> 
<div name="srvColDiv" style="display:none">
<form name="adminOpenInfAcol"  method="post" action="#">
				<input type="hidden" name="infId">                          
				<input type="hidden" name="infSeq" value=0>                          
				<input type="hidden" name="SSheetNm">
				<input type="hidden" name="srvCd" value="">                   
				<input type="hidden" name="apiType" value="rest">                   
				<input type="hidden" name="apiResDup" value="N">                   
				<input type="hidden" name="popupUse" value="Y">     
				<input type="hidden" name="prssAccCd">              
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
						<td id="sinfo">
							<input type="text" name="ownerCd"  style="width:150px" value="" placeholder="OWNER" ReadOnly/> 
							<input type="text" name="dsId" style="width:200px" value="" placeholder="DS_ID" ReadOnly/>
							<input type="text" name="dsNm"  style="width:250px"value="" placeholder="DS_NM" ReadOnly/>
						</td>
					</tr>
					<tr>   
						<!-- 요청주소 -->
						<th><spring:message code='labal.reqUri'/> <span> *</span></th>                             
						<td> 
							<input type="text" name="apiEp" id="apiEp" value="<spring:message code='Globals.ApiEp'/>" style="width:200px" placeholder="(한)"  ReadOnly/>
							<input type="text" name="apiRes" id="apiRes" value="" style="width:250px" maxlength="30"/>
							<button type="button" class="btn01" name="btn_dup"><spring:message code='btn.dup'/></button>
							<input type="text" name="apiTrf" value=0 style="width:100px"/><spring:message code='labal.apiTrfDesc'/> <!-- 건 제한/일(0건 제한없음) -->
						</td>
					</tr>
					<tr>   
						<!-- API명 -->
						<th><spring:message code='labal.apiNm'/></th>                             
						<td> 
							<input type="text" name="apiExp2" value="" style="width:300px" maxlength="160"/>
						</td>
					</tr>
					<tr>
						<!-- 서비스사용여부 -->
						<th><spring:message code='labal.srvYn'/></th>                 
						<td>
							<input type="radio" value="Y" id="Ause" name="srvYn"/>
							<label for="Ause"><spring:message code='labal.yes'/></label>  
							<input type="radio" value="N" id="Aunuse" name="srvYn"/>
							<label for="Aunuse"><spring:message code='labal.no'/></label>
						</td>
					</tr>        
				</table>	
				
				
				<!-- ibsheet 영역 -->
				<div class="ibsheet_area" name="Acol">               
				</div>
				
				<div class="buttons">
					${sessionScope.button.a_reg}       
					<%-- ${sessionScope.button.a_save}     --%>
					<a href="javascript:;" class="btn03" title="저장" name="a_save">저장</a>   
					<a href="javascript:;" class="btn03" title="테스트" name="a_tview">테스트</a>  
					<a href="javascript:;" class="btn03" title="정보조회" name="a_view">정보조회</a>  
					<%-- ${sessionScope.button.a_view}  --%>      
				</div>	
				
</form> 
<div>
<br/>
</div>

<form name="adminOpenInfAcolTwo" method="post" action="#">
				<input type="hidden" name="SSheetNmTwo"> 
				<div class="ibsheet_area2" name="AcolTwo">
				</div>
				
				<div class="buttons">
					${sessionScope.button.a_add}       
					${sessionScope.button.a_up}       
					${sessionScope.button.a_down}           
					<%-- ${sessionScope.button.a_save}    --%>
					<a href="javascript:;" class="btn03" title="저장" name="a_save">저장</a>    
				</div>	
</form>
</div>  