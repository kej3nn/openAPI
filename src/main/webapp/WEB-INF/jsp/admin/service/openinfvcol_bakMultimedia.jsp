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
<validator:javascript formName="adminOpenInfVcol" staticJavascript="false" xhtml="true" cdata="false"/>       
<script language="javascript">                
$(document).ready(function()    { 
});
           
function setVcol(SSheet){   
	var srvYn = false;
	var objTab = getTabShowObj();//탭이 oepn된 객체가져옴
	var formObj = objTab.find("form[name=adminOpenInfVcol]");
	
	datepickerInitTab(formObj.find("input[name=ftCrDttm]"));
	datepickerInitTab(formObj.find("input[name=ltCrDttm]"));
	formObj.find("input[name=ftCrDttm]").datepicker(setCalendarView('yy-mm-dd'));           
	formObj.find("input[name=ltCrDttm]").datepicker(setCalendarView('yy-mm-dd'));      
	datepickerTrigger();  
	
	formObj.find("a[name=a_add]").click(function(e) { //추가
		doActionVcol('add');                 
		return false;                 
	});                 
	formObj.find("a[name=a_reg]").click(function(e) { //등록
		doActionVcol('reg');                 
		return false;                 
	});                 
	formObj.find("a[name=a_save]").click(function(e) {	//저장
		doActionVcol('save');                 
		return false;                 
	}); 
	
	formObj.find("a[name=a_init]").click(function(e) {	//초기화
		doActionVcol('init');                 
		return false;                            
	});
	
	//데이터 수정시 해당 IBSheet 행에 입력
	//스트림타입
	formObj.find("select[name=mediaMtdCd]").change(function(e) {
		fnChangeVal_V("mediaMtdCd", formObj.find("select[name=mediaMtdCd]").val());	//element name, value
		return false;                            
	});
	//직접다운로드
	formObj.find(":radio[name=downYn]").change(function(e) {
		fnChangeVal_V("downYn", formObj.find("radio[name=downYn]").val());	//element name, value
		return false;                            
	});
	//직접다운로드
	formObj.find("select[name=cclCd]").change(function(e) {
		fnChangeVal_V("cclCd", formObj.find("select[name=cclCd]").val());	//element name, value
		return false;                            
	});
	//담당자
	formObj.find("input[name=prodNm]").change(function(e) {
		fnChangeVal_V("prodNm", formObj.find("input[name=prodNm]").val());	//element name, value
		return false;                            
	});
	//연락처
	formObj.find("input[name=telNo]").change(function(e) {
		fnChangeVal_V("telNo", formObj.find("input[name=telNo]").val());	//element name, value
		return false;                            
	});
	//미디어타입
	formObj.find("select[name=mediaTypeCd]").change(function(e) {
		fnChangeVal_V("mediaTypeCd", formObj.find("select[name=mediaTypeCd]").val());	//element name, value
		fnChangeType(formObj.find("select[name=mediaTypeCd]").val());					//미디어 타입 변경시 이벤트
		return false;                            
	});
	//원본신청링크
	formObj.find("input[name=siteNm]").change(function(e) {
		fnChangeVal_V("siteNm", formObj.find("input[name=siteNm]").val());	//element name, value
		return false;                            
	});
	//설명
	formObj.find("textarea[name=tranDesc]").change(function(e) {
		fnChangeVal_V("tranDesc", formObj.find("textarea[name=tranDesc]").val());	//element name, value
		return false;                            
	});
	//소제목
	formObj.find("input[name=detlSubject]").change(function(e) {
		fnChangeVal_V("detlSubject", formObj.find("input[name=detlSubject]").val());	//element name, value
		return false;                            
	});
	
	
	//파일 폼 처리
	formObj.find("input[name=ftCrDttm]").change(function(e) {
		dateValCheck(formObj.find('input[name=ftCrDttm]'), formObj.find('input[name=ltCrDttm]'));// from , to 날짜 안맞을 경우 자동셋팅  
		return false;                            
	});
	formObj.find("input[name=ltCrDttm]").change(function(e) {
		dateValCheck(formObj.find('input[name=ftCrDttm]'), formObj.find('input[name=ltCrDttm]'));// from , to 날짜 안맞을 경우 자동셋팅   
		return false;                            
	});
	
	//////////////////////////////////////////////////////////////////////////////////////////////////////
	
	formObj.find(':radio[name="srvYn"]').click(function(e) {    	//서비스여부 변경시 이전value와 비교 
		if ( $(this).val() != formObj.find("input[name=beforeSrvYn]").val() ) {
			formObj.find("input[name=dataModified]").val("Y");
		} else {
			formObj.find("input[name=dataModified]").val("");
		}
 	});
	
	if(formObj.find(':radio[name="srvYn"]:checked').val() !=undefined){
		formObj.find("a[name=a_reg]").hide();
		srvYn = true;                 
	}else{              
		formObj.find("a[name=a_init]").hide();
		formObj.find("a[name=a_add]").hide();
		formObj.find("a[name=a_del]").hide();
		formObj.find("a[name=a_save]").hide();
	}
	/////////////////////////////////
	/*
	formObj.find("input[id=file_1]").live('change', function(e) {
		val = $(this).val().split("\\");
		f_name = val[val.length-1];
		s_name = f_name.substring(f_name.length-4, f_name.length);
	});
	*/
	////////////////////
	
	if(formObj.find("input[name=SSheetNm]").val() ==""){
		formObj.find("input[name=SSheetNm]").val(SSheet);    
	}              
	formObj.find("input[name=srvCd]").val("V");        
	setLabal(formObj,"V"); //라벨 이름 중복됨(id 변경))
	formObj.find("input[name=initFlag]").val("N");
	
	formObj.find("input[name=beforeSrvYn]").val(formObj.find(':radio[name="srvYn"]:checked').val());	//저장한내역 확인하기위해
	
	//직접다운로드 초기값 미사용
	formObj.find(":radio[name='downYn'][value='N']").prop("checked",true);
	/* 
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
			window[sheet].FitColWidth("8|35|23|22|10");    
		}else if(sheetSrvCd == "F"){
			window[sheet].FitColWidth("5|7|13|13|13|13|7|7|7|7|7");    
		}else if(sheetSrvCd == "A"){  
			window[sheet].FitColWidth("6|5|20|25|8|8|8|8|8");    
		}else if(sheetSrvCd == "v"){  
			window[sheet].FitColWidth("7|7|12|15|25|13|13|8");
		}		                                                 
		return false;                                                                                               
	});
	 */
	return srvYn;
}

//두번째 Sheet
function setVcolTwo(SSheet){   
	var srvYn = false;
	var objTab = getTabShowObj();//탭이 oepn된 객체가져옴
	var formObj = objTab.find("form[name=adminOpenInfVcolFile]");
		

	formObj.find("a[name=a_save]").click(function(e) {				//세부서비스 저장
		doActionVcolTwo('save');                 
		return false;                 
	});
	formObj.find("a[name=a_del]").click(function(e) {				//세부서비스 삭제
		doActionVcolTwo('del');                 
		return false;                 
	});
	formObj.find("a[name=a_init]").click(function(e) {				//세부서비스 초기화
		doActionVcolTwo('init');                 
		return false;                 
	});
	
	if(formObj.find("input[name=SSheetNmTwo]").val() ==""){
		formObj.find("input[name=SSheetNmTwo]").val(SSheet);    
	}
	
	return true;
} 

function setVcolTwoObjShow() {
	//var srvYn = false;
	var objTab = getTabShowObj();//탭이 oepn된 객체가져옴
	var formObj = objTab.find("form[name=adminOpenInfVcolFile]");
	formObj.find("a[name=a_save]").show(); 
}

	 
function initVcol(sheetName,Vcol){
	 var srvYn  = setVcol(Vcol);   
	 if(srvYn){
		 LoadPageVcol(sheetName);
		 setTabButton_Vcol();
	 }         
}

function initVcolTwo(sheetName,Acol){
	 var srvYn = setVcolTwo(Acol);
	 if(srvYn){
		 LoadPageVcolTwo(sheetName);
	 }
}

function LoadPageVcol(sheetName)                
{                               
	var gridTitle = "<spring:message code='labal.status'/>";
	    gridTitle +="|"+"삭제";
		gridTitle +="|"+"<spring:message code='labal.infId'/>";           
		gridTitle +="|"+"<spring:message code='labal.infSeq'/>";   
		gridTitle +="|"+"멀티미디어고유번호";
		gridTitle +="|"+"미디어형태코드";
		gridTitle +="|"+"미디어방식코드";
		gridTitle +="|"+"다운로드여부";
		gridTitle +="|"+"원본파일명";   
		gridTitle +="|"+"저장파일명";   
		gridTitle +="|"+"출력파일명";  
		gridTitle +="|"+"스트리밍경로";   
		gridTitle +="|"+"소제목";
		gridTitle +="|"+"내용설명";
		gridTitle +="|"+"담당자";
		gridTitle +="|"+"연락처";
		gridTitle +="|"+"썸네일이미지파일";
		gridTitle +="|"+"원본신청링크";
		gridTitle +="|"+"이용허락범위코드";
		gridTitle +="|"+"최초생성일";   
		gridTitle +="|"+"최종수정일";
		gridTitle +="|"+"<spring:message code='labal.useYn'/>";  		
	
    with(sheetName){
    	                      
    	var cfg = {SearchMode:2,Page:50};                                        
        SetConfig(cfg);  
        var headers = [                                                                   
                    {Text:gridTitle, Align:"Center"}                          
                ];
        var headerInfo = {Sort:0,ColMove:1,ColResize:1,HeaderCheck:1};         
                        
        InitHeaders(headers, headerInfo); 
                 
        var cols = [          
					 {Type:"Status",		SaveName:"status",			Width:30,	Align:"Center",		Edit:false}               
					,{Type:"DelCheck",		SaveName:"delChk",			Width:10,	Align:"Center",		Edit:true} 
					,{Type:"Text",			SaveName:"infId",			Width:30,	Align:"Right",		Edit:false, Hidden:true}
					,{Type:"Text",			SaveName:"infSeq",			Width:30,	Align:"Right",		Edit:false,	Hidden:true}
					,{Type:"Text",			SaveName:"mediaNo",			Width:30,	Align:"Right",		Edit:false,	Hidden:true}
					,{Type:"Combo",			SaveName:"mediaTypeCd", 	Width:100,	Align:"Center",		Edit:false}	//Combo D1101
					,{Type:"Combo",			SaveName:"mediaMtdCd", 		Width:100,	Align:"Left",		Edit:false, Hidden:true}	//Combo D1102
					,{Type:"Text",			SaveName:"downYn", 			Width:100,	Align:"Left",		Edit:false,	Hidden:true}
					,{Type:"Text",			SaveName:"srcFileNm", 		Width:100,	Align:"Left",		Edit:false,	Hidden:true}
					,{Type:"Text",			SaveName:"saveFileNm",  	Width:100,	Align:"Left",		Edit:false,	Hidden:true}
					,{Type:"Text",			SaveName:"viewFileNm", 		Width:100,	Align:"Left",		Edit:false,	Hidden:true}
					,{Type:"Text",			SaveName:"streamUrl",  		Width:70,	Align:"Center",		Edit:false, Hidden:true}
					,{Type:"Text",			SaveName:"detlSubject",   	Width:70,	Align:"Left",		Edit:false}
					,{Type:"Text",			SaveName:"tranDesc",   		Width:70,	Align:"Left",		Edit:false}
					,{Type:"Text",			SaveName:"prodNm",     		Width:70,	Align:"Center",		Edit:false}
					,{Type:"Text",			SaveName:"telNo",      		Width:70,	Align:"Center",		Edit:false}
					,{Type:"Text",			SaveName:"tmnlImgFile",		Width:70,	Align:"Center",		Edit:false,	Hidden:true}
					,{Type:"Text",			SaveName:"siteNm",     		Width:70,	Align:"Center",		Edit:false,	Hidden:true}
					,{Type:"Text",			SaveName:"cclCd",      		Width:70,	Align:"Center",		Edit:false,	Hidden:true}
					,{Type:"Text",			SaveName:"ftCrDttm",   		Width:70,	Align:"Center",		Edit:false,	Hidden:true}
					,{Type:"Text",			SaveName:"ltCrDttm",   		Width:70,	Align:"Center",		Edit:false,	Hidden:true}
					,{Type:"CheckBox",		SaveName:"useYn",			Width:30,	Align:"Center",		Edit:true, TrueValue:"Y", FalseValue:"N"}
                ];

        InitColumns(cols);
        SetExtendLastCol(1);
        sheetName.FitColWidth("7|7|8|22|28|10|10|8");

        SetColProperty("mediaTypeCd", ${codeMap.mediaTypeCdIbs} );
        SetColProperty("mediaMtdCd", ${codeMap.mediaMtdCdIbs} );

    }
    default_sheet(sheetName);
    doActionVcol("search");
    //doActionVcol("click");
    initVFile();
}

function LoadPageVcolTwo(sheetName)                
{                               
	var gridTitle = "<spring:message code='labal.status'/>";
	    gridTitle +="|"+"삭제";
		gridTitle +="|"+"<spring:message code='labal.infId'/>";           
		gridTitle +="|"+"<spring:message code='labal.infSeq'/>";   
		gridTitle +="|"+"멀티미디어고유번호";
		gridTitle +="|"+"세부정보고유번호";
		gridTitle +="|"+"원본파일명";   
		gridTitle +="|"+"저장파일명";   
		gridTitle +="|"+"출력파일명";  
		gridTitle +="|"+"스트리밍경로";
		gridTitle +="|"+"썸네일파일명";
		gridTitle +="|"+"<spring:message code='labal.useYn'/>";
	
    with(sheetName){
    	                      
    	var cfg = {SearchMode:2,Page:50};                                        
        SetConfig(cfg);  
        var headers = [                                                                   
                    {Text:gridTitle, Align:"Center"}                          
                ];
        var headerInfo = {Sort:0,ColMove:1,ColResize:1,HeaderCheck:1};         
                        
        InitHeaders(headers, headerInfo); 
                 
        var cols = [          
					 {Type:"Status",		SaveName:"status",			Width:100,	Align:"Center",		Edit:false}               
					,{Type:"DelCheck",		SaveName:"delChk",			Width:100,	Align:"Center",		Edit:true} 
					,{Type:"Text",			SaveName:"infId",			Width:30,	Align:"Right",		Edit:false, Hidden:true}
					,{Type:"Text",			SaveName:"infSeq",			Width:30,	Align:"Right",		Edit:false,	Hidden:true}
					,{Type:"Text",			SaveName:"mediaNo",			Width:30,	Align:"Right",		Edit:false,	Hidden:true}
					,{Type:"Text",			SaveName:"mediaDetailNo", 	Width:100,	Align:"Left",		Edit:false,	Hidden:true}
					,{Type:"Text",			SaveName:"srcFileNm", 		Width:350,	Align:"Left",		Edit:false}
					,{Type:"Text",			SaveName:"saveFileNm",  	Width:100,	Align:"Left",		Edit:false,	Hidden:true}
					,{Type:"Text",			SaveName:"viewFileNm", 		Width:350,	Align:"Left",		Edit:false}
					,{Type:"Text",			SaveName:"streamUrl",  		Width:350,	Align:"Left",		Edit:false}
					,{Type:"Text",			SaveName:"tmnlImgFile",  	Width:100,	Align:"Center",		Edit:false, Hidden:true}
					,{Type:"CheckBox",		SaveName:"useYn",			Width:100,	Align:"Center",		Edit:true, TrueValue:"Y", FalseValue:"N"}
                ];

        InitColumns(cols);
        SetExtendLastCol(1);
        FitColWidth();
    }
    default_sheet(sheetName);
}


function doActionVcol(sAction)                                  
{
 	var classObj = $("."+tabContentClass); //tab으로 인하여 form이 다건임
 	var actObj = setTabForm2(classObj,"adminOpenInfVcol"); // 0: form data, 1: form 객체
 	var actObjFile = setTabForm2(classObj,"adminOpenInfVcolFile"); // 0: form data, 1: form 객체
 	var sheetObj; //IbSheet 객체         
 	var param = actObj[0];
 	var paramFile = actObjFile[0];
 	var objTab = getTabShowObj();		//탭이 oepn된 객체가져옴
 	
 	var formObj = objTab.find("form[name=adminOpenInfVcol]");
 	sheetObj =formObj.find("input[name=SSheetNm]").val();
 	//ajaxBeforeSendAdmin("<c:url value='/admin/ajaxBeforeSendAdmin.do'/>"); //IbSheet 조회전 세션 체크
 	var gridObj = window[sheetObj];
 	switch(sAction)                    
 	{          
 		case "search":      //조회    
 			gridObj.DoSearch("<c:url value='/admin/service/openInfVcolList.do'/>", param); 
 			break;
 		case "click":
 			vColClick(gridObj, 1, 3);
 			break;
 		case "init" : //초기화
 			fncInit_V(formObj, gridObj);
 			break;
 		case "add" :	//파일추가(grid에 입력)
 			if ( !vColCheck(formObj, gridObj) ) {
 				return;
 			}
 			fncFileAdd_V(formObj, gridObj);
 			break;
 		case "reg":      //등록
 			if(formObj.find(':radio[name="srvYn"]:checked').val() ==undefined){
 				alert("서비스 여부를 선택해 주세요.");
 				return;
 			}
 			var url ="<c:url value='/admin/service/openInfColReg.do'/>";
 			ajaxCallAdmin(url, param, colVcallback);
 			LoadPageVcol(gridObj);
 			setTabButton_Vcol();
 			formObj.find("a[name=a_reg]").hide();
 			formObj.find("a[name=a_init]").show();
 			formObj.find("a[name=a_add]").show();
 			formObj.find("a[name=a_save]").show();
 			break;
 		case "save":      //저장
//  			var cRow = gridObj.CheckedRows("delChk");
// 			if(cRow >= 1){
// 				alert("삭제 체크를 해제 후 저장하시기 바랍니다.");
// 				return false;
// 			}
 			var dataModified = false;
 			if ( formObj.find("input[name=dataModified]").val() == "Y" ) {		//서비스여부 변경하였는지 체크
 				dataModified = true;
 			}
 			
 			if ( !gridObj.IsDataModified() ) {
 				if ( !dataModified ) {
 					alert("저장할 내역이 없습니다.");
 					return;
 				}
 			}
 			
 			ibsSaveJson = gridObj.GetSaveJson(1);    
 			if(ibsSaveJson. data.length == 0) return;
 			var url = "<c:url value='/admin/service/openInfVcolSave.do'/>";
 			IBSpostJson(url, actObj[0], saveCallBack_V);
 			
//  			ibsSaveJson = gridObj.GetSaveString(); 			
 			
// 			IBSpostJsonFile(formObj,url, saveCallBack_V);
 			break;
 		case "getMstSeq" :	//신규 등록시 INF테이블의 SEQ 가져온다.
 			var url ="<c:url value='/admin/service/getMstSeq.do'/>";
 			ajaxCallAdmin(url, param, getMstSeqCallBack_V);
 			break;
 		case "getInfSeq" :	//신규 등록시 INF테이블의 SEQ 가져온다.
 	 		var url ="<c:url value='/admin/service/getInfSeq.do'/>";
 	 		ajaxCallAdmin(url, param, getInfSeqCallBack_V);
 	 		break;
 	}                
 	initCaptionForm();           
}

function doActionVcolTwo(sAction)                                  
{
 	var classObj = $("."+tabContentClass); //tab으로 인하여 form이 다건임
 	var actObj = setTabForm2(classObj,"adminOpenInfVcol"); // 0: form data, 1: form 객체
 	var actObjFile = setTabForm2(classObj,"adminOpenInfVcolFile"); // 0: form data, 1: form 객체
 	var sheetObj; //IbSheet 객체
 	var sheetObjFile; //IbSheet 객체         
 	var param = actObj[0]  ;
 	var paramFile = actObjFile[0];
 	var objTab = getTabShowObj();//탭이 oepn된 객체가져옴
 	
 	var formObj = objTab.find("form[name=adminOpenInfVcol]");
 	var formObjFile = objTab.find("form[name=adminOpenInfVcolFile]");
 	sheetObj =formObj.find("input[name=SSheetNm]").val();
 	sheetObjFile =formObjFile.find("input[name=SSheetNmTwo]").val();    
 	//ajaxBeforeSendAdmin("<c:url value='/admin/ajaxBeforeSendAdmin.do'/>"); //IbSheet 조회전 세션 체크
 	
 	var gridObj = window[sheetObj];
 	var gridObjFile = window[sheetObjFile];
 	switch(sAction)                    
 	{          
 		case "search":      //조회    
 			gridObjFile.DoSearch("<c:url value='/admin/service/openInfVcolDtlList.do'/>", paramFile); 
 			break;
 		case "init" : //초기화
 			fncFormSet_VFile(formObjFile);
 			break;
 		case "initDiv" : //초기화
 			fncInit_VFile(formObjFile, gridObj, -1);
 			break;
 		case "del":      //저장
 			var cRow = gridObjFile.CheckedRows("delChk");
			if(cRow < 0){
				alert("삭제할 행을 선택하세요.");
				return false;
			}
 			
 			ibsSaveJson = gridObjFile.GetSaveJson(1);    
 			if(ibsSaveJson.data.length == 0) return;
 			var url = "<c:url value='/admin/service/openInfVcolDetailDel.do'/>";
 			IBSpostJson(url, paramFile, fileSaveCallBack_VFile);
 			break;
 		case "save":      //저장
 			if ( !vColCheckFile(formObjFile, gridObjFile) ) {
 				return;
 			}
 			var status = "";
 			if(formObjFile.find("input[name=mediaTypeCd]").val() == "MTN") {
 				status = "M";
 			} else {
 				status = "I";
 			}
 			ibsSaveJson = formObjFile.serialize();
 			if(ibsSaveJson.length == 0) return;
 			ibsSaveJson = ibsSaveJson + "&status="+status;
 			var url = "<c:url value='/admin/service/openInfVcolFileSave.do'/>";
			IBSpostJsonFile(formObjFile,url, fileSaveCallBack_VFile);
 			break;
 	}
 	initCaptionForm();
}

//신규 등록시 INF의 SEQ를 가져온다(파일 업로드 위해)
function getMstSeqCallBack_V(res) {
	var objTab = getTabShowObj();//탭이 oepn된 객체가져옴
	var formObj = objTab.find("form[name=adminOpenInfVcol]");
	formObj.find("input[name=mstSeq]").val(res);
}

//신규 등록시 SERVICE의 SEQ를 가져온다(파일 업로드 위해)
function getInfSeqCallBack_V(res) {
	var objTab = getTabShowObj();//탭이 oepn된 객체가져옴
	var formObj = objTab.find("form[name=adminOpenInfVcol]");
	formObj.find("input[name=infSeq]").val(res);
}

//파일수정 콜백함수
function saveCallBack_V(res) {
	var result = res.RESULT.CODE;
    if(result == 0) {
    	alert(res.RESULT.MESSAGE);
    } else {
    	alert(res.RESULT.MESSAGE);
    }   
    doActionVcol("search");		//조회
}

//파일수정 콜백함수
function fileSaveCallBack_VFile(res) {
	var result = res.RESULT.CODE;
    if(result == 0) {
    	alert(res.RESULT.MESSAGE);
    } else {
    	alert(res.RESULT.MESSAGE);
    }   
    doActionVcolTwo("search");		//조회
}

// 입력/수정 validation
function vColCheck(obj, gridObj) {
	var rowCnt = gridObj.RowCount() + 1;
	var rtnVal = false;
	
// 	if ( obj.find("input[name=initFlag]").val() == "N" ) {
// 		alert("입력 초기화 후 추가해 주세요.");
// 		rtnVal = false;		return;
// 	}
	if(nullCheckValdation(obj.find('select[name=mediaTypeCd]'),"미디어타입","")){
		rtnVal = false;		return;
	}
	if(nullCheckValdation(obj.find(':radio[name=downYn]'),"직접다운로드","")){
		rtnVal = false;		return;
	}
	
	//다운로드 여부에 따른 Validation 변경
	if(obj.find('select[name="mediaTypeCd"]').val() != "IMG") {
		if(nullCheckValdation(obj.find('select[name=mediaMtdCd]'),"스트림타입","")){
			rtnVal = false;		return;
		}
	}
	
// 	if(nullCheckValdation(obj.find('input[name=streamUrl]'),"스트리밍경로","")){
// 		rtnVal = false;		return;
// 	}
	
	if(nullCheckValdation(obj.find('input[name=ftCrDttm]'),"최초생성일","")){
		rtnVal = false;		return;
	}
	if(nullCheckValdation(obj.find('input[name=ltCrDttm]'),"최종수정일","")){
		rtnVal = false;		return;
	}
	
	return true;
 }
 
//입력/수정 validation
function vColCheckFile(obj, gridObj) {
	var rowCnt = gridObj.RowCount() + 1;
	var rtnVal = false;
	var row = gridObj.SelectRow;
	
	if(row < 0) {
		alert("시트에서 데이터를 선택하세요.");
		return;
	}
	if(obj.find("input[name=mediaTypeCd]").val() == "MTD") {
		if(nullCheckValdation(obj.find('input[name=streamUrl]'),"스트리밍경로","")){
			rtnVal = false;		return;
		}
	}
	if(obj.find("input[name=downYn]").val() == "Y") {
		if(gridObj.GetCellValue(row,"saveFileNm") == "") {						//파일 업로드 시에만
			if ( obj.find('input[id=file_'+rowCnt+']').val() == "" ) {
				alert("파일을 선택해 주세요.");
				rtnVal = false;		return;
			}	
		}
		
		if(nullCheckValdation(obj.find('input[name=viewFileNm]'),"출력파일명","")){
			rtnVal = false;		return;
		}
	}
	
	return true;
}


// 클릭시
var currRow = -1;
function vColClick(gridObj, Row, Col) {
	var objTab = getTabShowObj();//탭이 oepn된 객체가져옴
	var formObj = objTab.find("form[name=adminOpenInfVcol]");
	var formObjFile = objTab.find("form[name=adminOpenInfVcolFile]");
	var rowCnt = gridObj.RowCount();
	
	if(gridObj.ColSaveName(Col) == "delChk") {					//삭제
		return;
	}
	
// 	if ( formObj.find("input[name=initFlag]").val() == "Y" ) {
// 		alert("초기화 된 상태 입니다\n신규 입력 부터 하시기 바랍니다.");
// 		gridObj.SetCellValue(Row, "delChk", "0");	//체크된 항목 초기화
// 		currRow = -1;
// 		return;
// 	}
	fncInit_V(formObj, gridObj);							//초기화처리
	formObj.find("input[name=initFlag]").val("N");
	if(gridObj.GetCellValue(Row, "mediaNo") == "") {			//저장하지 않은 행 클릭
		fncInit_VFile(formObjFile, gridObj, -1);							//세부서비스 초기화처리
	} else {
		fncInit_VFile(formObjFile, gridObj, Row);							//세부서비스 초기화처리
		
		// 세부서비스
		formObjFile.find("input[name=mediaNo]").val(gridObj.GetCellValue(Row, "mediaNo"));
		formObjFile.find("input[name=mediaTypeCd]").val(gridObj.GetCellValue(Row, "mediaTypeCd"));
		formObjFile.find("input[name=downYn]").val(gridObj.GetCellValue(Row, "downYn"));
		
		fncFormSet_VFile(formObjFile);
		doActionVcolTwo("search");	
	}
	
	// 멀티미디어 정보
	formObj.find("input[name=ftCrDttm]").val(gridObj.GetCellValue(Row, "ftCrDttm"));
	formObj.find("input[name=ltCrDttm]").val(gridObj.GetCellValue(Row, "ltCrDttm"));
	formObj.find("select[name=mediaMtdCd]").val(gridObj.GetCellValue(Row, "mediaMtdCd"));				//미디어타입
	
	if(gridObj.GetCellValue(Row, "downYn") == "Y") {										//라디오 버튼
		formObj.find(":radio[name=downYn][value=Y]").prop("checked",true);					//직접다운로드	
	} else if(gridObj.GetCellValue(Row, "downYn") == "N"){
		formObj.find(":radio[name=downYn][value=N]").prop("checked",true);					//직접다운로드
	} 
	fnChangeType(gridObj.GetCellValue(Row, "mediaTypeCd"));
	
	formObj.find("select[name=cclCd]").val(gridObj.GetCellValue(Row, "cclCd"));					//이용허락조건
	formObj.find("input[name=prodNm]").val(gridObj.GetCellValue(Row, "prodNm"));					//담당자
	formObj.find("input[name=telNo]").val(gridObj.GetCellValue(Row, "telNo"));					//연락처
	formObj.find("input[name=siteNm]").val(gridObj.GetCellValue(Row, "siteNm"));					//원본신청링크
// 	formObj.find("input[name=streamUrl]").val(gridObj.GetCellValue(Row, "streamUrl"));				//스트림경로
	formObj.find("textarea[name=tranDesc]").val(gridObj.GetCellValue(Row, "tranDesc"));				//설명
	formObj.find("input[name=detlSubject]").val(gridObj.GetCellValue(Row, "detlSubject"));			//소제목
	formObj.find("input[name=viewFileNm]").val(gridObj.GetCellValue(Row, "viewFileNm"));	
	
	//formObj.find("select[name=fileCd]").val(gridObj.GetCellValue(Row, "fileCd"));
	currRow = Row;
	//gridObj.SetSelectRow(1);
	initImg_Vcol();
}

function vColClickTwo(Row, Col, Value) {
	var objTab = getTabShowObj();//탭이 oepn된 객체가져옴
	var formObjFile = objTab.find("form[name=adminOpenInfVcolFile]");
	var sheetNm = formObjFile.find("input[name=SSheetNmTwo]").val();
	var gridObj = window[sheetNm];
	var rowCnt = gridObj.RowCount();
	
	fncFormSet_VFile(formObjFile);
	
	formObjFile.find("input[name=mediaDetailNo]").val(gridObj.GetCellValue(Row, "mediaDetailNo"));		//멀티미디어세부고유번호
	formObjFile.find("input[name=viewFileNm]").val(gridObj.GetCellValue(Row, "viewFileNm"));		//멀티미디어세부고유번호
	formObjFile.find("input[name=streamUrl]").val(gridObj.GetCellValue(Row, "streamUrl"));		//멀티미디어세부고유번호
	
	if(formObjFile.find("input[name=downYn]").val() == "Y") {				//파일 사용시
		var appendFile = "";
		//빈 파일객체 현재 순서ID로 추가..
		appendFile += "<input type='hidden' name='saveFileNm' id='saveFileNm_0' style='display:none; width:200px;' value='' readonly>";
		appendFile += "<input type='hidden' name='srcFileNm' id='srcFileNm_0' style='display:none; width:200px;' value='' readonly>";
		formObjFile.find("span[id=fileDiv]").html(gridObj.GetCellValue(Row, "srcFileNm"));		//멀티미디어세부고유번호
		formObjFile.find("span[id=fileDiv]").append(appendFile);
		
		formObjFile.find("input[name=saveFileNm]").val(gridObj.GetCellValue(Row, "saveFileNm"));	//저장파일명
		formObjFile.find("input[name=srcFileNm]").val(gridObj.GetCellValue(Row, "srcFileNm"));		//원본파일명
	}

	var jsonData = gridObj.GetRowJson(Row);
	var params = {
			infId : jsonData.infId
			, infSeq : jsonData.infSeq
			, mediaNo : jsonData.mediaNo
			, mediaDetailNo : jsonData.mediaDetailNo
	};
	$.ajax({
		type : "POST"
		, url : "<c:url value='/admin/service/openInfVcolCaptionDesc.do'/>"
		, data : params
		, dataType : "json"
		, success : function(data) {
			var captionForm = openTab.ContentObj.find('form[name=captionForm]');
			captionForm.find('input[name=infId]').val(params.infId);
			captionForm.find('input[name=infSeq]').val(params.infSeq);
			captionForm.find('input[name=mediaNo]').val(params.mediaNo);
			captionForm.find('input[name=mediaDetailNo]').val(params.mediaDetailNo);
			captionForm.find('textarea[name=captionDesc]').val(data.data);
			captionForm.find('textarea[name=captionDesc]').scrollTop(0);
			
			captionForm.find('#subtitle_save').unbind("click");
			captionForm.find('#subtitle_save').bind("click", function() {
				captionForm.ajaxSubmit({
		            url:"<c:url value='/admin/service/updateCaptionDesc.do'/>",
		            dataType:"json",
		            success:function(data, status, request, form) {
		            	alert('저장되었습니다.');
		            	initCaptionForm();
		            },
		            error:function(request, status, error) {
		            }
		        });
			});
			
			$('div[id=captionDiv]').show();
		}
	});
}

// 자막 등록창 초기화
function initCaptionForm() {
	var captionForm = $('form[name=captionForm]');
	captionForm.find('input[name=infId]').val("");
	captionForm.find('input[name=infSeq]').val("");
	captionForm.find('input[name=mediaNo]').val("");
	captionForm.find('input[name=mediaDetailNo]').val("");
	captionForm.find('textarea[name=captionDesc]').val("");
	$('div[id=captionDiv]').hide();
}

//파일선택시
function fncFileChange_V(fileId) {
	var objTab = getTabShowObj();
	var formObjFile = objTab.find("form[name=adminOpenInfVcolFile]");
 	
	val = formObjFile.find("input[id=file_"+fileId+"]").val().split("\\");
	fileName = val[val.length-1];
	f_name = fileName.substring(0, fileName.lastIndexOf("."));
	s_name = fileName.substring(fileName.lastIndexOf(".")+1, fileName.length);
	formObjFile.find("input[id=saveFileNm_"+fileId+"]").val(f_name);
	formObjFile.find("input[name=viewFileNm]").val(f_name);
	formObjFile.find("input[name=srcFileNm]").val(f_name);
}


//초기화 버튼 클릭시
function fncInit_V(formObj, gridObj) {
	var currRow = gridObj.GetSelectRow();
	this.currRow = -1;
	var rowCnt = gridObj.RowCount() + 1;
	var totalRow = gridObj.RowCount();
	
// 	if ( formObj.find("input[name=initFlag]").val() == "Y" ) {
// 		alert("이미 초기화 하였습니다.");		return;
// 	}
	formObj.find("select[name=mediaTypeCd] option").not(":selected").removeAttr("disabled");			//selectbox 고정 해제
	
	//Disabled 해제 및 Label 수정
	formObj.find("span[id=tranDescLabel]").empty().html("설명");
 	formObj.find(":radio[name=downYn][value=N]").prop("disabled",false);
 	formObj.find("select[name=mediaTypeCd]").prop("readonly",false);
 	
 	
	//값 초기화
	formObj.find("select[name=mediaMtdCd]").val("");					//미디어타입
	formObj.find(":radio[name=downYn][value=N]").prop("checked",true);	//직접다운로드
	formObj.find("select[name=cclCd]").val("");							//이용허락조건
	formObj.find("input[name=prodNm]").val("");							//담당자
	formObj.find("input[name=telNo]").val("");							//연락처
	formObj.find("select[name=mediaTypeCd]").val("");					//스트림타입
	formObj.find("input[name=siteNm]").val("");							//원본신청링크
// 	formObj.find("input[name=streamUrl]").val("");						//스트림경로
	formObj.find("textarea[name=tranDesc]").val("");					//설명
	formObj.find("input[name=detlSubject]").val("");					//소제목
	formObj.find("input[name=ftCrDttm]").val("");
	formObj.find("input[name=ltCrDttm]").val("");
	formObj.find("input[name=initFlag]").val("Y");		//초기화하였음.
	
	if(totalRow > 0) {					//입력건수 존재시
		var mediaTypeCd = gridObj.GetCellValue(totalRow,"mediaTypeCd");
		formObj.find("select[name=mediaTypeCd]").val(mediaTypeCd);
		formObj.find("select[name=mediaTypeCd]").prop("readonly",true);
		
		formObj.find("select[name=mediaTypeCd] option").not(":selected").attr("disabled", "disabled");		//selectbox 고정
		fnChangeType(formObj.find("select[name=mediaTypeCd]").val());
	}
}

//미디어 세부 서비스 초기화
function fncInit_VFile(formObj, gridObj, Row) {
	var objTab = getTabShowObj();
	var currRow = gridObj.GetSelectRow();
	var rowCnt = gridObj.RowCount() + 1;
	var appendFile = "";
	
	if(Row < 0) {
		objTab.find("div[id=mediaFile]").hide();
		return;
	}
	
	formObj.find("input[name=downYn]").val("");
	formObj.find("input[name=mediaNo]").val("");
	formObj.find("input[name=mediaTypeCd]").val("");
	
	objTab.find("div[id=mediaFile]").show();
}

//미디어 세부 서비스 폼 초기화
function fncFormSet_VFile(formObj) {
	var sheetNm = formObj.find("input[name=SSheetNmTwo]").val();
	var gridObj = window[sheetNm];
	var mediaTypeCd = formObj.find("input[name=mediaTypeCd]").val();
	var downYn = formObj.find("input[name=downYn]").val();
	
	formObj.find("input[name=mediaDetailNo]").val("0");
	formObj.find("input[name=viewFileNm]").val("");
	formObj.find("input[name=streamUrl]").val("");
	
	if(mediaTypeCd == "MTN") {
		if(downYn == "Y") {
			formObj.find("tr[id=fileForm1]").show();
			formObj.find("tr[id=fileForm2]").show();
			formObj.find("tr[id=streamForm1]").show();
			
// 			gridObj.SetColHidden("srcFileNm",1);
// 			gridObj.SetColHidden("viewFileNm",1);
// 			gridObj.SetColHidden("streamUrl",1);
		} else {
			formObj.find("tr[id=fileForm1]").hide();
			formObj.find("tr[id=fileForm2]").hide();
			formObj.find("tr[id=streamForm1]").show();
			
// 			gridObj.SetColHidden("srcFileNm",0);
// 			gridObj.SetColHidden("viewFileNm",0);
// 			gridObj.SetColHidden("streamUrl",1);
		}
	} else if(mediaTypeCd == "IMG") {
		formObj.find("tr[id=fileForm1]").show();
		formObj.find("tr[id=fileForm2]").show();
		formObj.find("tr[id=streamForm1]").hide();
		
// 		gridObj.SetColHidden("srcFileNm",1);
// 		gridObj.SetColHidden("viewFileNm",1);
// 		gridObj.SetColHidden("streamUrl",0);
	}
	
	if(downYn == "Y") {
		var appendFile = "";
		//빈 파일객체 현재 순서ID로 추가..
		appendFile += "<input type='hidden' name='fileStatus' id='fileStatus_0' value='C' style='display:none;' readonly/>";
		appendFile += "<input type='hidden' name='saveFileNm' id='saveFileNm_0' style='display:none; width:200px;' value='' readonly>";
		appendFile += "<input type='hidden' name='srcFileNm' id='srcFileNm_0' style='display:none; width:200px;' value='' readonly>";
		appendFile += "<input type='file' name='file' id='file_0' onchange='fncFileChange_V(0);' />";
		formObj.find("span[id=fileDiv]").empty();
		formObj.find("span[id=fileDiv]").html(appendFile);
		//파일객체 추가하고 보여준다
		formObj.find("input[id=saveFileNm_0]").show();
		formObj.find("input[id=file_0]").show(); 
	} else {
		formObj.find("span[id=fileDiv]").empty();
	}
}


//파일 추가시 grid에 입력 
function fncFileAdd_V(formObj, gridObj) {
	var newRow = gridObj.DataInsert(-1);
	gridObj.SetCellValue(newRow, "infId", formObj.find("input[name=infId]").val());	//순서 현재seq 카운팅
	gridObj.SetCellValue(newRow, "infSeq", formObj.find("input[name=infSeq]").val());	//순서 현재seq 카운팅
// 	gridObj.SetCellValue(newRow, "mediaNo", gridObj.RowCount());
	gridObj.SetCellValue(newRow, "mediaMtdCd", formObj.find("select[name=mediaMtdCd]").val());			//스트림타입
	gridObj.SetCellValue(newRow, "downYn", formObj.find(":radio[name=downYn]:checked").val());			//직접다운로드
	gridObj.SetCellValue(newRow, "cclCd", formObj.find("select[name=cclCd]").val());					//이용허락조건
	gridObj.SetCellValue(newRow, "prodNm", formObj.find("input[name=prodNm]").val());					//담당자
	gridObj.SetCellValue(newRow, "telNo", formObj.find("input[name=telNo]").val());						//연락처
	gridObj.SetCellValue(newRow, "mediaTypeCd", formObj.find("select[name=mediaTypeCd]").val());		//미디어타입
	gridObj.SetCellValue(newRow, "siteNm", formObj.find("input[name=siteNm]").val());					//원본신청링크
	gridObj.SetCellValue(newRow, "tranDesc", formObj.find("textarea[name=tranDesc]").val());				//설명
	gridObj.SetCellValue(newRow, "detlSubject", formObj.find("input[name=detlSubject]").val());				//소제목
	gridObj.SetCellValue(newRow, "ftCrDttm", formObj.find("input[name=ftCrDttm]").val());
	gridObj.SetCellValue(newRow, "ltCrDttm", formObj.find("input[name=ltCrDttm]").val());
	gridObj.SetCellValue(newRow, "useYn", "Y");
	formObj.find("input[name=initFlag]").val("N");
	fncInit_V(formObj, gridObj);								//초기화
	formObj.find("input[name=initFlag]").val("N");
}


function vColValidation(gridObj, Row, Col, Value) {
	/* Sheet에서 수정금지(주석처리)
	if ( Col == 7 | Col == 8  ) {
		if ( gridObj.GetCellValue(Row, Col) == "" ) {
			alert("값을 입력해 주세요.");
			gridObj.validateFail(1);
			gridObj.SetSelectCell(Row, Col);
			return false;
		}
	}
	 */
}

//file 데이터 변경시 IBsheet에 해당 Row에 값 넣기
function fnChangeVal_V(name, val) {
	var objTab = getTabShowObj();
	var formObj = objTab.find("form[name=adminOpenInfVcol]");
	sheetObj =formObj.find("input[name=SSheetNm]").val();    
	var gridObj = window[sheetObj];
	if( currRow > -1 ) {	//currRow 최초 -1, Ibsheet 클릭시 Row위치 획득이므로 -1보다 클 경우만 셀 값 변경 
		gridObj.SetCellValue(currRow, name, val);
	}
	
}

function colVcallback(res){ 
    var result = res.RESULT.CODE;
    if(result == 0) {
    	alert(res.RESULT.MESSAGE);                  
    } else {                               
    	var objTab = getTabShowObj();//탭이 oepn된 객체가져옴
    	var objTabDiv = getTabShowObjForm("srvColDiv");//탭이 oepn된 div객체가져옴
    	var val =objTabDiv.find(':radio[name="srvYn"]:checked').val();
    	var srvCd = objTabDiv.find("input[name=srvCd]").val();
    	var index = typeIndex(srvCd);
    	if(val =="Y"){                                 	                    
    		objTab.find(".tab-inner").find("a").eq(index).removeClass("no-service").addClass("service");
		}else{                 
			objTab.find(".tab-inner").find("a").eq(index).removeClass("no-service").removeClass("service");                       
		}                                  
    	doActionVcol("getMstSeq");
    	doActionVcol("getInfSeq");
    }
}  

function fnChangeType(mediaTypeCd) {					//미디어 타입 선택에 따른 활성화 변경
	if("MTN" == mediaTypeCd) {			//음원, 동영상의 경우 스트림타입, 스트림 경로 필수
		selectMTN();
	} else if("IMG" == mediaTypeCd) {							//이미지의 경우 스트림타입, 스트림 경로 X , 직접다운로드 사용만
		selectIMG();
	} else {
		
	}
}

function selectMTN() {
 	var objTab = getTabShowObj();//탭이 oepn된 객체가져옴
 	var formObj = objTab.find("form[name=adminOpenInfVcol]");
 	formObj.find("span[id=tranDescLabel]").empty().html("설명");
 	formObj.find(":radio[name=downYn][value=N]").prop("disabled",false);
 	
	formObj.find("span[id=mediaMtdCdLabel]").empty().html("*");
}

function selectIMG() {
	var objTab = getTabShowObj();//탭이 oepn된 객체가져옴
 	var formObj = objTab.find("form[name=adminOpenInfVcol]");
 	formObj.find("span[id=tranDescLabel]").empty().html("설명");
 	
	// 직접다운로드 사용 고정
	formObj.find(":radio[name=downYn][value=Y]").prop("checked",true);
	formObj.find(":radio[name=downYn][value=N]").prop("disabled",true);
	
	formObj.find("span[id=mediaMtdCdLabel]").empty();
}

//초기값 셋팅
function initVFile() {
	var objTab = getTabShowObj();//탭이 oepn된 객체가져옴
 	var formObj = objTab.find("form[name=adminOpenInfVcol]");
	var formObjFile = objTab.find("form[name=adminOpenInfVcolFile]");
	
	formObjFile.find("input[name='infId']").val(formObj.find("input[name='infId']").val());
	formObjFile.find("input[name='infSeq']").val(formObj.find("input[name='infSeq']").val());
	formObjFile.find("input[name='mstSeq']").val(formObj.find("input[name='mstSeq']").val());
	formObjFile.find("input[name='srvCd']").val(formObj.find("input[name='srvCd']").val());
}

//조회 완료 이벤트
function onSearchEnd_V(code, msg) {
	doActionVcol("init");
	doActionVcolTwo("initDiv");
	initImg_Vcol();
}

//조회 완료 이벤트
function onSearchEnd_VcolTwo(code, msg) {
	doActionVcolTwo("init");
}

//--------------------------------------------------- 이미지 관련 javascript Start ---------------------------------------------------------
function bbsDtlCallBack_Vcol(tab, json, res){
	var objTab = getTabShowObj();		//탭이 oepn된 객체가져옴
	var formImgObj = objTab.find("form[name=adminImgForm_Vcol]");
	var delUse = "Y";
	if(formImgObj.find("a[name=a_reg]").length > 0){		// 신규등록일 경우..
		delUse = "Y";
	}
// 	var newYn = formImgObj.find("a[name=a_reg]").length;
//  var oldYn = formImgObj.find("a[name=a_modify]").length;   

	var append = "";
	formImgObj.find(".appendImg div").remove();
	
	append += "<div>";                 
	if ( tab.resultImg != null ) {
		for( var i =0; i<tab.resultImg.length ; i++){
			var param = "downCd=MT&fileSeq="+tab.resultImg[i].mediaNo+"&seq="+tab.resultImg[i].mstSeq+"&etc="+tab.resultImg[i].infId;
			append += "<div class='img-box'>";
			append += "<p><input type='hidden' name='delUse' value='"+delUse+"' /></p>";
			append += "<p><img src=\"<c:url value='/admin/service/fileDownload.do?"+param+"'/>\" alt='"+tab.resultImg[i].tmnlImgFile+"' width='120' height='120'/></p>";
			append += "<p><input type='checkbox' name='del_yn' id='del"+i+"' value='"+tab.resultImg[i].mediaNo+"' onclick=\"javascript:checkDel_Vcol('"+delUse+"', '"+tab.resultImg[i].mediaNo+"', '"+tab.resultImg[i].mstSeq+"');\" /> <label for='del"+i+"'>삭제</label></p>";
			append += "</div> ";
			
			formImgObj.find("span[id=fileImgDiv]").append(tab.resultImg[i].tmnlImgFile);
		}
	}
	append += "</div>"; 
	formImgObj.find(".appendImg").append(append);
	formImgObj.find("input[name=delYn0]").val('0');
	formImgObj.find("input[name=delYn1]").val('0');
	formImgObj.find("input[name=delYn2]").val('0');
	formImgObj.find("input[name=delYn3]").val('0');
	formImgObj.find("input[name=delYn4]").val('0');
	formImgObj.find("input[name=delYn5]").val('0');
	formImgObj.find("input[name=delYn6]").val('0');
	formImgObj.find("input[name=delYn7]").val('0');
	formImgObj.find("input[name=delYnVal]").val('0');
	
	if(false){	//대표이미지 표시
		formImgObj.find("[name=top_yn]:radio[value='"+tab.resultTopYn[0].fileSeq+"']").prop("checked",true);   
		formImgObj.find("input[name=topYnSeq]").val(tab.resultTopYn[0].fileSeq);
	}else{
		formImgObj.find("input[name=topYnSeq]").val('0');
	}
	
 	formImgObj.find("input[name=top_yn]").click(function(){		// 대표이미지 선택
 		var topYnVal = formImgObj.find("input:radio[name=top_yn]:checked").val();
 		formImgObj.find("input[name=topYnSeq]").val(topYnVal);
	});
 	
 	
 	formImgObj.find("button[name=btn_add]").hide();
}

function checkDel_Vcol(delUse, fileSeq, seq){
	var objTab = getTabShowObj();		//탭이 oepn된 객체가져옴
	var formObj = objTab.find("form[name=adminOpenInfVcol]");
	var formImgObj = objTab.find("form[name=adminImgForm_Vcol]");
	
	if(delUse == "Y"){
 		formImgObj.find("input[name=delYnVal]").val(fileSeq);
 		var url = "<c:url value='/admin/service/openInfVcolDeleteImg.do'/>"; 
		var param = formImgObj.serialize();
		ajaxCallAdmin(url, param, imgDeleteCallBack2_Vcol);
	}else{
		if(formImgObj.find("input:checkbox[id=del"+seq+"]").is(":checked") == true){
			formImgObj.find("input[name=delYn"+seq+"]").val(fileSeq);
		}else{
			formImgObj.find("input[name=delYn"+seq+"]").val('0');
		}
	}
}

function imgDeleteCallBack2_Vcol(res){
	alert(res.msg);
	var objTab = getTabShowObj();//탭이 oepn된 객체가져옴
	var formObj = objTab.find("form[name=adminOpenInfVcol]");
// 	var url = "<c:url value='/admin/service/openInfVcolImgDetailView.do'/>";
// 	param = formObj.serialize();
// 	ajaxCall(url, param, bbsDtlCallBack_Vcol); 
	doActionVcol("search");
	initImg_Vcol();
}

function imgDeleteCallBack_Vcol(res){
// 	 var result = res.RESULT.CODE;
// 	alert(res.RESULT.CODE);
	if(res.RESULT.CODE == 0){
		alert("<spring:message code='MSG.SAVE'/>");
	}else{
		alert("<spring:message code='ERR.SAVE'/>");
	}
	
	var objTab = getTabShowObj();//탭이 oepn된 객체가져옴
	var formObj = objTab.find("form[name=adminOpenInfVcol]");
	var url = "<c:url value='/admin/service/openInfVcolImgDetailView.do'/>";
	param = formObj.serialize();
	ajaxCall(url, param, bbsDtlCallBack_Vcol);  
}

function doActionImg_Vcol(sAction){
	var classObj = $("."+tabContentClass); //tab으로 인하여 form이 다건임
	var actObj = setTabForm2(classObj,"adminOpenInfVcol"); // 0: form data, 1: form 객체
	var sheetObj; //IbSheet 객체
	var param = actObj[0]  ;  
	var objTab = getTabShowObj();//탭이 oepn된 객체가져옴
	var formObj = objTab.find("form[name=adminOpenInfVcol]");
	var formImgObj = objTab.find("form[name=adminImgForm_Vcol]");
	ajaxBeforeSendAdmin("<c:url value='/admin/ajaxBeforeSendAdmin.do'/>"); //IbSheet 조회전 세션 체크
	sheetObj =formObj.find("input[name=SSheetNm]").val();    
 	var gridObj = window[sheetObj];
	
	switch(sAction){
		case "init":
			fncInit2_Vcol(formImgObj);
			break;
		
		case "add":
			var seq = formImgObj.find("input[name=mediaNo]").val();
			if ( formImgObj.find("input[name=initFlag]").val() == "" ) { 
				alert("초기화 버튼을 눌러주세요.");		return;
			}
			if(seq == ""){
				alert("링크를 먼저 선택해주세요");	return false; 
			}
			if ( formImgObj.find('input[id=file]').val() == "" ) {
				alert("파일을 선택해 주세요."); 	return false;
			}
			
			var imgLen = formImgObj.find(".img-box").length;
			if(imgLen > 1){
				alert("썸네일 이미지는 1개만 등록 가능합니다."); 
				return false
			}
			var srcFileNm = formImgObj.find("input[id=saveFileNm]").val();
			var fileExt = getFileExt(formImgObj.find("input[id=saveFileNm]").val());
			
			if(fileExt.toLowerCase() != "jpg" && fileExt.toLowerCase() != "jpeg" && fileExt.toLowerCase() != "gif" && fileExt.toLowerCase() != "png"){
				alert("이미지 파일[jpg/jpeg, gif, png]만 첨부가능 합니다.");
		        return false;
			}

 			ibsSaveJson = formImgObj.serialize(); 
 			ibsSaveJson += "&srcFileNm="+srcFileNm+"&fileExt="+fileExt+"&status=I";
			var url = "<c:url value='/admin/service/openInfVcolImgSave.do'/>";                
			IBSpostJsonFile(formImgObj,url, fileSaveCallBack2_Vcol);
			break;
	}
}

function fileSaveCallBack2_Vcol(res) {		// 이미지 미리보기 추가 콜백
	alert("저장되었습니다.");
	var objTab = getTabShowObj();//탭이 oepn된 객체가져옴
	var formObj = objTab.find("form[name=adminOpenInfVcol]");
// 	var url = "<c:url value='/admin/service/openInfVcolImgDetailView.do'/>";
// 	param = formObj.serialize();
// 	ajaxCall(url, param, bbsDtlCallBack_Vcol);
	doActionVcol("search");
	initImg_Vcol();
	
}

//초기화 버튼 클릭시
function fncInit2_Vcol(formObj) {
// 	alert(typeof(gridObj));
	var appendFile = "";
/* 	if ( formObj.find("input[name=initFlag]").val() == "Y" ) {
		alert("이미 초기화 하였습니다.");		return;
	} */
	//값 초기화
	formObj.find("input[name=initFlag]").val("Y");		//초기화하였음.
	//현재파일객체 숨김
	formObj.find("input[id=saveFileNm]").hide();
	formObj.find("input[id=file]").hide();
	//빈 파일객체 현재 순서ID로 추가..
	appendFile += "<input type='text' name='fileStatus' id='fileStatus' value='C' style='display:none;' readonly/>";
			appendFile += "<input type='text' name='saveFileNm' id='saveFileNm' style='display:none; width:200px;' value='' readonly>";
			appendFile += "<input type='file' name='file' id='file' onchange='fncFileChange2_Vcol();' style='display:none; width:80px; color:#fff'/>";
	formObj.find("span[id=fileImgDiv]").find("span[id=fileImgInfo]").remove();	// 문구 삭제
	formObj.find("span[id=fileImgDiv]").append(appendFile);
	//파일객체 추가하고 보여준다
	formObj.find("input[id=saveFileNm]").show();
	formObj.find("input[id=file]").show();
}

//파일선택시
function fncFileChange2_Vcol() {
	var objTab = getTabShowObj();
	var formObj = objTab.find("form[name=adminImgForm_Vcol]");
	val = formObj.find("input[id=file]").val().split("\\");
	fileName = val[val.length-1];
	f_name = fileName.substring(0, fileName.indexOf("."));
	s_name = fileName.substring(fileName.length-3, fileName.length);
	formObj.find("input[id=saveFileNm]").val(fileName);
// 	alert("fileName==>"+fileName+" , f_name==>"+f_name+" , s_name==>"+s_name);
}


function setTabButton_Vcol(){		//버튼event
	var objTab = getTabShowObj();//탭이 oepn된 객체가져옴
	var formImgObj = objTab.find("form[name=adminImgForm_Vcol]");
 	
 	formImgObj.find("button[name=btn_add]").click(function(){		//이미지 추가
		doActionImg_Vcol("add");
		return false;		
	});
 	
}


// 썸네일 업로드 초기화 - 시트 더블클릭시
function initImg_Vcol() {
	var objTab = getTabShowObj();//탭이 oepn된 객체가져옴
	var formObj = objTab.find("form[name=adminOpenInfVcol]");
	var formImgObj = objTab.find("form[name=adminImgForm_Vcol]");
	var sheetObj =formObj.find("input[name=SSheetNm]").val();
 	var gridObj = window[sheetObj];
 	var objTabDiv = getTabShowObjForm("srvColDiv");//탭이 oepn된 div객체가져옴
 	
 	//썸네일 등록 DIV SHOW
 	objTab.find("div[name='imgDiv']").hide();
 	formImgObj.find("input[name='tmnImgFile']").val("");			//이미지파일명
	formImgObj.find("input[name='mediaNo']").val("");				//링크SEQ
	formImgObj.find("input[name='infId']").val("");					//INF_ID
	formImgObj.find("input[name='infSeq']").val("");				//INF_SEQ
	formImgObj.find("input[name='mstSeq']").val("");				//MST_SEQ
	formImgObj.find("input[name='initFlag']").val("");				//initFlag
	formImgObj.find("span[id=fileImgDiv]").empty();					//파일 제거
	formImgObj.find(".appendImg div").remove();						//이미지미리보기 제거
	
	var Row = gridObj.GetSelectRow();
	if(Row < 0) return;					//선택한 행이 없을 경우
	if(gridObj.GetCellValue(Row, "status")!="R") return;					//시트 데이터가 조회 데이터가 아닌 경우
	
 	//썸네일 등록 DIV SHOW
 	objTab.find("div[name='imgDiv']").show();
 	
	// ImgForm 에 데이터 셋팅
 	
	formImgObj.find("input[name='tmnlImgFile']").val(gridObj.GetCellValue(Row, "tmnlImgFile"));				//이미지파일명
	formImgObj.find("input[name='mediaNo']").val(gridObj.GetCellValue(Row, "mediaNo"));					//링크SEQ
	formImgObj.find("input[name='infId']").val(formObj.find("input[name='infId']").val());					//INF_ID
	formImgObj.find("input[name='infSeq']").val(formObj.find("input[name='infSeq']").val());				//INF_SEQ
	formImgObj.find("input[name='mstSeq']").val(formObj.find("input[name='mstSeq']").val());				//MST_SEQ
	formImgObj.find("input[name='srvCd']").val(formObj.find("input[name='srvCd']").val());					//MST_SEQ
	
	if(formImgObj.find("input[name='tmnlImgFile']").val() == "") {				//썸네일 이미지 업로드 안한상태
		doActionImg_Vcol("init");
		formImgObj.find("button[name=btn_add]").show();
	} else {																	//썸네일 이미지 업로드 한 상태
		var url = "<c:url value='/admin/service/openInfVcolImgDetailView.do'/>";
		param = formImgObj.serialize();
		ajaxCall(url, param, bbsDtlCallBack_Vcol);
	}
}

//--------------------------------------------------- 이미지 관련 javascript End ---------------------------------------------------------

</script> 
<div name="srvColDiv" style="display:none">  
<form name="adminOpenInfVcol" method="post" action="#">
				<input type="hidden" name="infId">
				<input type="hidden" name="infSeq" value=0>
				<input type="hidden" name="mstSeq" value=0>
				<input type="hidden" name="SSheetNm">
				<input type="hidden" name="srvCd" value="">
				<input type="hidden" name="beforeSrvYn" value="">
				<input type="hidden" name="initFlag">
				<input type="hidden" name="dataModified">
				<table class="list01">
					<caption>공공데이터목록리스트</caption>
					<colgroup>
						<col width="150"/>
						<col width=""/>
						<col width="150"/>
						<col width=""/>
						<col width="150"/>
						<col width=""/>
						<col width="150"/>
						<col width=""/>
					</colgroup>
					<tr>
						<th><spring:message code='labal.infNm'/></th>            
						<td colspan="7">
							<input type="text" name="infNm" value="" style="width:500px" placeholder="(한)" ReadOnly/>
							${sessionScope.button.btn_metaDtl}
						</td>         
					</tr>
					<tr>
						<th><spring:message code='labal.srvYn'/></th>                 
						<td colspan="7">
							<input type="radio" value="Y" id="Ause" name="srvYn"/>
							<label for="Ause"><spring:message code='labal.yes'/></label>  
							<input type="radio" value="N" id="Aunuse" name="srvYn"/>
							<label for="Aunuse"><spring:message code='labal.no'/></label>
						</td>
					</tr>      
					<tr>
				</table>
				<h3 class="text-title2">멀티 미디어 서비스</h3>
				
				<table class="list01">
					<caption>공공데이터 멀티미디어</caption>
					<colgroup>
						<col width="150"/>
						<col width=""/>
						<col width="150"/>
						<col width=""/>
						<col width="150"/>
						<col width=""/>
						<col width="150"/>
						<col width=""/>
					</colgroup>
					<tr>
						<th>미디어 타입 <span>*</span></th>                             
						<td colspan="7">
							<select id="mediaTypeCd" name="mediaTypeCd">
								<option value=""><spring:message code='etc.select'/></option>
								<c:forEach var="code" items="${codeMap.mediaTypeCd}" varStatus="status">
										<option value="${code.ditcCd}">${code.ditcNm}</option>
								</c:forEach>
							</select>
						</td>
					</tr>
					<tr>
						<th>직접다운로드 <span>*</span></th>                             
						<td colspan="2">
							<input type="radio" name="downYn" id="downY" value="Y">
							<label for="downY"><spring:message code='labal.yes'/></label>  
							<input type="radio" name="downYn" id="downN" value="N">
							<label for="downN"><spring:message code='labal.no'/></label>
						</td>
						<th>이용허락조건</th>                             
						<td colspan="4">
							<select id="cclCd" name="cclCd">
								<option value=""><spring:message code='etc.select'/></option>
								<c:forEach var="code" items="${codeMap.cclCd}" varStatus="status">
										<option value="${code.ditcCd}">${code.ditcNm}</option>
								</c:forEach>
							</select>
						</td>
					</tr>
					<tr>
						<th><span id="detlSubjectLabel" style="color:#6b8194">소제목</span></th>
						<td colspan="7">
							<input type="text" name="detlSubject" value="" style="width:800px" maxlength="300"/>
						</td>
					</tr>
					<tr>
						<th><span id="tranDescLabel" style="color:#6b8194">설명</span></th>
						<td colspan="7">
<!-- 							<input type="text" name="tranDesc" value="" style="width:800px" maxlength="300"/> -->
							<textarea name="tranDesc" style="width:1000px" rows="5"></textarea>
						</td>
					</tr>
					<tr>
						<th>담당자</th>                             
						<td colspan="2">
							<input type="text" name="prodNm" value="" style="width:250px" maxlength="30"/>
						</td>
						<th>연락처</th>                             
						<td colspan="4">
							<input type="text" name="telNo" value="" style="width:250px" maxlength="20"/>
						</td>
					</tr>
					<tr>
						<th>스트림타입 <span id="mediaMtdCdLabel">*</span></th>                             
						<td colspan="2">
							<select id="mediaMtdCd" name="mediaMtdCd">
								<option value=""><spring:message code='etc.select'/></option>
								<c:forEach var="code" items="${codeMap.mediaMtdCd}" varStatus="status">
										<option value="${code.ditcCd}">${code.ditcNm}</option>
								</c:forEach>
							</select>
						</td>
						<th>원본신청링크</th>                             
						<td colspan="4">
							<input type="text" name="siteNm" value="" style="width:250px" maxlength="300"/>
						</td>
					</tr>
					<tr>   
						<th>최초 생성일 <span>*</span></th>                             
						<td colspan="2">                                                  
							<input type="text" name="ftCrDttm" value="" readonly="readonly" style="width:120px"/>
						</td>
						<th>최종 수정일 <span>*</span></th>                                               
						<td colspan="4">                      
							<input type="text" name="ltCrDttm" value="" readonly="readonly" style="width:120px"/>                 
						</td>
					</tr>
				</table>	
				<div class="buttons">
					${sessionScope.button.a_init}
					${sessionScope.button.a_add}
				</div>	
				
				<!-- ibsheet 영역 -->
				<div class="ibsheet_area" name="Vcol">               
				</div>
				
				<div class="buttons">
					${sessionScope.button.a_reg}     
					${sessionScope.button.a_save}      
				</div>	
				
</form> 
	<div id="mediaFile" style="display:none">
		<form name="adminOpenInfVcolFile" method="post" action="#" enctype="multipart/form-data">
			<input type="hidden" name="infId">
			<input type="hidden" name="infSeq" value=0>
			<input type="hidden" name="mstSeq" value=0>
			<input type="hidden" name="srvCd" value="">
			<input type="hidden" name="mediaNo">
			<input type="hidden" name="mediaTypeCd">
			<input type="hidden" name="downYn">
			<input type="hidden" name="mediaDetailNo">
			<input type="hidden" name="SSheetNmTwo">
			
			<h3 class="text-title2">멀티 미디어 세부 서비스</h3>
			<table class="list01">
				<caption>공공데이터 멀티미디어</caption>
				<colgroup>
					<col width="150"/>
					<col width=""/>
					<col width="150"/>
					<col width=""/>
					<col width="150"/>
					<col width=""/>
					<col width="150"/>
					<col width=""/>
				</colgroup>
				<tr id="fileForm1">
					<th>첨부파일</th>                             
					<td colspan="7">
						<span id="fileDiv" style="display:inline-block;"></span>
					</td>
				</tr>
				
				<tr id="fileForm2">   
					<th>출력파일명 <span>*</span></th>                             
					<td colspan="7"> 
						<input type="text" name="viewFileNm" value="" style="width:250px" maxlength="160"/>&nbsp;(확장자제외)
					</td>
				</tr>
				<tr id="streamForm1">   
					<th>스트림경로 <span id="streamUrlLabel">*</span></th>                             
					<td colspan="7"> 
						<input type="text" name="streamUrl" value="" style="width:350px" maxlength="300"/>
					</td>
				</tr>
			</table>
			<div class="buttons">
				${sessionScope.button.a_init}
				${sessionScope.button.a_save}
			</div>
			<!-- ibsheet 영역 -->
			<div class="ibsheet_area2" name="VcolTwo">               
			</div>
			<div class="buttons">
				${sessionScope.button.a_del}
			</div>
		</form>
	</div>
	<div id="captionDiv" style="display:none;">
	<form id="captionForm" name="captionForm" method="post" onsubmit="return false;">
		<input type="hidden" name="infId" value=""/>
		<input type="hidden" name="infSeq" value=""/>
		<input type="hidden" name="mediaNo" value=""/>
		<input type="hidden" name="mediaDetailNo" value=""/>
		<h3 class="text-title2">자막</h3>
		<table class="list01" style="margin-top:15px;">
			<caption>자막</caption>
			<colgroup>
				<col width="150"/>
				<col width=""/>
			</colgroup>
			<tr>
				<th>자막</th>
				<td style="text-align:left;">
					<textarea name="captionDesc" style="width:1000px" rows="8"></textarea>
					<a class="btn03" title="저장" id="subtitle_save" style="cursor:pointer; margin:5px; vertical-align:bottom;">저장</a>
				</td>
			</tr>
		</table>
	</form>
	</div>
	
	<div name="imgDiv" style="display:none">  
	<form name="adminImgForm_Vcol" method="post" action="#" enctype="multipart/form-data">
		<input type="hidden" name="infId"/>
		<input type="hidden" name="infSeq" value=0/>
		<input type="hidden" name="mstSeq" value=0 />
		<input type="hidden" name="mediaNo" value=0 />
		<input type="hidden" name="tmnlImgFile" />
		<input type="hidden" name="srvCd" value="">
		<input type="hidden" name="initFlag"/>
		<input type="hidden" name="topYnSeq" value=0 />
		<input type="hidden" name="delYnVal"  value = 0 />
		<input type="hidden" name="delYn0"  value=0 />
		<input type="hidden" name="delYn1"  value=0 />
		<input type="hidden" name="delYn2"  value=0 />
		<input type="hidden" name="delYn3"  value=0 />
		<input type="hidden" name="delYn4"  value=0 />
		<input type="hidden" name="delYn5"  value=0 />
		<input type="hidden" name="delYn6"  value=0 />
		<input type="hidden" name="delYn7"  value=0 />
		<h3 class="text-title2">첨부이미지</h3>
		<table class="list01">
			<caption>첨부파일리스트</caption>
			<colgroup>
				<col width="150"/>
				<col width=""/>
			</colgroup>
			<tr>
				<th>파일</th>
				<td>
					<span id="fileImgDiv" style="display:inline-block;"></span>
					${sessionScope.button.btn_add}
				</td>
			</tr>
		</table>
		<table class="list05">
			<caption>첨부이미지</caption>
			<colgroup>
				<col width="150"/>
				<col width=""/>
			</colgroup>
			<tr>
				<th>이미지</th>
				<td style="text-align:left;">
					<div class="appendImg"></div>
	<!-- 									<div class="img-box"> -->
						<!-- <p><input type="radio" id="ceoImg0"/> <label for="ceoImg0">대표이미지</label></p>
						<p><img src = "" /></p>
						<p><input type="checkbox" id="del0"/> <label for="del0">삭제</label></p> -->
	<!-- 									</div> -->
				</td>
			</tr>	
		</table>
	</form>
	</div>
</div>  