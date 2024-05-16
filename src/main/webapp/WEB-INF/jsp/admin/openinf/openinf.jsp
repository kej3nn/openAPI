<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ page import="egovframework.common.WiseOpenConfig"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="validator"
	uri="http://www.springmodules.org/tags/commons-validator"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><spring:message code='wiseopen.title' /></title>
<c:import url="/WEB-INF/jsp/inc/headinclude.jsp" />
<!--  
	validate 사용시 반드시 선언
	formName명과 validate 함수명이 연결되어있음
	adminOpenInf -> validateadminOpenInf 체크함
	resources/validator/*.* xml을 만들어서 사용
  -->
<validator:javascript formName="adminOpenInf" staticJavascript="false"
	xhtml="true" cdata="false" />
</head>
<script language="javascript">              
//<![CDATA[                              
function tabSet(){ //탭 객체 생성  
	openTab = new OpenTab(tabId,tabContentClass,tabBody); //headinclude.jsp 변수 있음
	openTab.TabObj = openTab;  
	openTab.addTabClickEvent();    
}	   
        
$(document).ready(function()    {    
	
	Btn_Set();
	LoadPage(); 
	LoadOrg();
	
	//LoadEmp();
	doAction('search');                                              
	inputEnterKey();       
	//tabSet();// tab 셋팅
	init();
	setTabButton();		//탭 버튼
	
	
	
});    

function Btn_Set() { //버튼 초기화 함수
	   
	   $("a[name=a_reg]").show();
	   $("a[name=a_reset]").show();
	   
	   $("a[name=a_modify]").hide();
	   $("a[name=a_del]").hide();
	   
}

var dtId = "";
function init(){
	var formObj = $("form[name=adminOpenInf]");
	var formSearchObj = $("form[name=adminOpenInfSearch]");
	formObj.find("input[name=openDttm]").datepicker(setCalendar());  
	//formObj.find("input[name=dataCondDttm]").datepicker(setCalendar());
// 	formObj.find("input[name=openDttmFrom]").datepicker(setCalendar());      
	datepickerTrigger();     
	formSearchObj.find("button[name=btn_search]").eq(2).click(function(e) { 
		doAction("search");
		 return false;        
	 }); 
	formSearchObj.find("button[name=btn_search]").eq(1).click(function(e) { 
		doAction("poporgnm");
		return false;               
	 }); 
	formSearchObj.find("button[name=btn_search]").eq(0).click(function(e) { 
		doAction("popcatenm");
		return false;                  
	 }); 
	
	formSearchObj.find("button[name=btn_regInit]").click(function(e) {
		doTabAction("init");
		return false;                  
	 }); 
	
	formSearchObj.find("button[name=btn_init]").eq(0).click(function(e) { 
		/* formObj.find("input[name=orgNm]").val("");
		formObj.find("input[name=orgCd]").val("");
		return false;  */    
		//$("a[name=cateNm]").();
		$("input[name=cateNm]").val(null);
	}); 
	formSearchObj.find("button[name=btn_init2]").eq(0).click(function(e) { 
		/* formObj.find("input[name=orgNm]").val("");
		formObj.find("input[name=orgCd]").val("");
		return false;  */    
		//$("a[name=cateNm]").();
		$("input[name=orgNm]").val(null);
	}); 
	formObj.find("button[name=btn_init]").eq(1).click(function(e) { 
		/* formObj.find("input[name=cateNm]").val("");
		formObj.find("input[name=cateId]").val("");
		return false;    */ 
		//$("a[name=orgNm]").blank();
		$("input[name=orgNm]").val(null);
		
	}); 
	formSearchObj.find("button[name=btn_reg]").click(function(e) { 
		doAction("reg");
		return false;                  
	 }); 
	formObj.find("button[name=btn_metadownload]").click(function(e) { 
		doAction("metadown");
		 return false;        
	 }); 
	formObj.find("button[name=btn_dttm]").click(function(e) { 
		formObj.find("input[name=openDttmFrom]").val("");
		formObj.find("input[name=openDttmTo]").val("");
	 }); 
	//추천 체크박스 이벤트
	formObj.find("input[name=fvtDataYn]").bind("click", function(event) {
		if ( !$(this).is(":checked") ) {
			formObj.find("select[name=fvtDataOrder]").val("0").hide();	//체크 해제시 추천안함으로
		} else {
			formObj.find("select[name=fvtDataOrder]").show();
		}
	});
	//추천 순위 selectbox 이벤트
	formObj.find("select[name=fvtDataOrder]").bind("change", function(event) {
		if ( $(this).val() == "0" ) {	//추천 안할경우
			$(this).hide();	//selectbox 숨김
			formObj.find("input[name=fvtDataYn]").prop("checked", false);	//추천 체크박스 언체크
		}else{
			$(this).show();	//selectbox 숨김
			formObj.find("input[name=fvtDataYn]").prop("checked", true);	//추천 체크박스 언체크
		}
	});
	
	//개방버튼
	formObj.find("a[name=a_infState]").bind("click", function(e) {
		doTabAction("infStateY");
	});
	//개방취소 버튼
	formObj.find("a[name=a_infStateCancel]").bind("click", function(e) {
		doTabAction("infStateC");
	});
	
	formObj.find("h3[name=tblOpenH3]").hide();			//개방 공개 숨김
	formObj.find("table[name=tblOpenTable]").hide();	//개방 공개 숨김
	
	
	
}

function buttonEventAdd(){
	setTabButton();
}
                                
function LoadPage()                
{      
	//message-common_ko_KR.properties 선언 후 사용 or message-common_en_US.properties 선언 후 사용
	var gridTitle = "NO"
		gridTitle +="|"+"<spring:message code='labal.infId'/>";  
		//gridTitle +="|"+"<spring:message code='labal.dtNm'/>";  
		gridTitle +="|"+"<spring:message code='labal.infNm'/>"; 
		//gridTitle +="|"+"<spring:message code='labal.infNm'/>";        
		gridTitle +="|"+"<spring:message code='labal.ditcEngCd'/>";       
		gridTitle +="|"+"<spring:message code='labal.bbsOrgCd'/>";     
		gridTitle +="|"+"<spring:message code='labal.cclCd'/>";        
		gridTitle +="|"+"서비스";   
		gridTitle +="|"+"개방일";    
		gridTitle +="|"+"<spring:message code='labal.infState'/>";   
	//	gridTitle +="|"+"데이터셋 구분";        
		//gridTitle +="|"+"<spring:message code='labal.cateNm'/>";        
		//gridTitle +="|"+"<spring:message code='labal.orgNm'/>";        
// 		gridTitle +="|"+"<spring:message code='labal.usrNm'/>"; 
		/* gridTitle +="|"+"<spring:message code='labal.useOrgCnt'/>";
		gridTitle +="|"+"<spring:message code='labal.openDttm'/>";    
		gridTitle +="|"+"<spring:message code='labal.dataCondDttm'/>";
		gridTitle +="|"+"<spring:message code='labal.useDeptNm'/>";
		gridTitle +="|"+"<spring:message code='labal.infState'/>";        
		gridTitle +="|"+"개방서비스";   
		gridTitle +="|"+"<spring:message code='labal.aprvProcYn'/>"; */
//		gridTitle +="|"+"dsId";
//		gridTitle +="|"+"emdYn";
	
    with(mySheet){
    	                      
    	var cfg = {SearchMode:3,Page:50};                                 
        SetConfig(cfg);   
        var headers = [                                             
                    {Text:gridTitle, Align:"Center"}                 
                ];
        var headerInfo = {Sort:0,ColMove:1,ColResize:1,HeaderCheck:0};
        
        InitHeaders(headers, headerInfo); 
         
        var cols = [          
					 {Type:"Seq",		SaveName:"seq",				Width:50,	Align:"Center",		Edit:false,  Sort:false}
					,{Type:"Text",		SaveName:"infId",			Width:250,	Align:"Left",		Edit:false}
					,{Type:"Text",		SaveName:"infNm",			Width:240,	Align:"Left",		Edit:false}
					,{Type:"Text",		SaveName:"cateFullnm",		Width:250,	Align:"Left",		Edit:false}
					,{Type:"Text",		SaveName:"orgNm",			Width:180,	Align:"Center",		Edit:false}
					,{Type:"Text",		SaveName:"cclNm",			Width:250,	Align:"Left",		Edit:false}
					,{Type:"Html",		SaveName:"openSrv",			Width:210,	Align:"Left",		Edit:false}
					,{Type:"Text",		SaveName:"openDttm",		Width:180,	Align:"Center",		Edit:false}
					,{Type:"Combo",		SaveName:"infState",		Width:80,	Align:"Left",		Edit:false}
                ];       
                                      
        InitColumns(cols);                                                                           
        SetExtendLastCol(1);   
        SetColProperty("infState", ${codeMap.infStatsIbs} );  
        SetColProperty("dsCd", {ComboCode:"RAW|TS", ComboText:"원시|통계"}	);    //InitColumns 이후에 셋팅
        
    }               
    default_sheet(mySheet);                      
}      


function LoadOrg()                
{      
	//message-common_ko_KR.properties 선언 후 사용 or message-common_en_US.properties 선언 후 사용
	var gridTitle = "NO";
		gridTitle +="|"+"<spring:message code='labal.status'/>";
		gridTitle +="|"+"<spring:message code='btn.del'/>"; 
		gridTitle +="|"+"NO";
		gridTitle +="|"+"<spring:message code='labal.bbsOrgCd'/>"; 
		gridTitle +="|"+"<spring:message code='labal.orgCd'/>";
		gridTitle +="|"+"<spring:message code='labal.usrCd'/>";
		gridTitle +="|"+"<spring:message code='labal.usrCd'/>";
		gridTitle +="|"+"<spring:message code='labal.job'/>";
		gridTitle +="|대표여부";
		gridTitle +="|업무권한";
		gridTitle +="|출처표시";
		gridTitle +="|"+"<spring:message code='labal.useYn'/>";
		//gridTitle +="|"+"<spring:message code='labal.status'/>";
	
    with(mySheet2){
    	                      
    	var cfg = {SearchMode:3,Page:50};                                 
        SetConfig(cfg);   
        var headers = [                                             
                    {Text:gridTitle, Align:"Center"}                 
                ];
        var headerInfo = {Sort:0,ColMove:1,ColResize:1,HeaderCheck:0};
        
        InitHeaders(headers, headerInfo); 
         
        var cols = [          
					{Type:"Seq",		SaveName:"seq",				Width:40,	Align:"Center",		Edit:false,  Sort:false}
					,{Type:"Status",	SaveName:"status",			Width:40,	Align:"Center",		Edit:false}
					,{Type:"DelCheck",	SaveName:"del",				Width:40,	Align:"Center",		Edit:true}
					,{Type:"Text",		SaveName:"seqceNo",			Width:0,	Align:"Center",		Edit:false, Hidden:true}
					,{Type:"Popup",		SaveName:"orgNm",			Width:120,	Align:"Center",		Edit:true, KeyField:true}
					,{Type:"Text",		SaveName:"orgCd",			Width:0,	Align:"Center",		Edit:false, Hidden:true, KeyField:true}
					,{Type:"Popup",		SaveName:"usrNm",			Width:120,	Align:"Center",		Edit:true}
					,{Type:"Text",		SaveName:"usrCd",			Width:0,	Align:"Center",		Edit:false, Hidden:true}
					,{Type:"Combo",		SaveName:"jobCd",			Width:120,	Align:"Center",		Edit:false, Hidden:true}
					,{Type:"Radio",		SaveName:"rpstYn",			Width:80,	Align:"Center",		Edit:true, TrueValue:"Y", FalseValue:"N",  Sort:false}
					,{Type:"Combo",		SaveName:"prssAccCd",		Width:80,	Align:"Center",		Edit:true}
					,{Type:"CheckBox",	SaveName:"srcViewYn",		Width:80,	Align:"Center",		Edit:true, TrueValue:"Y", FalseValue:"N"}
					,{Type:"CheckBox",	SaveName:"useYn",			Width:80,	Align:"Center",		Edit:true, TrueValue:"Y", FalseValue:"N"}
                ];       
                                      
        InitColumns(cols);                                                                           
        FitColWidth();                                                         
        SetExtendLastCol(1);   
        SetColProperty("jobCd", ${codeMap.jobCdIbs});
        SetColProperty("prssAccCd", ${codeMap.prssAccCdIbs});	//권한
    }               
    default_sheet(mySheet2);                      
}      
/* img 처리 */
function doActionImg(sAction){
	
	var classObj = $("."+'content').eq(1); //tab으로 인하여 form이 다건임
	var actObj = setTabForm2(classObj,"adminOpenInf"); // 0: form data, 1: form 객체
	var sheetObj; //IbSheet 객체         
	var param = actObj[0]  ;  
	var objTab = getTabShowObj();//탭이 oepn된 객체가져옴
	var formObj = classObj.find("form[name=adminOpenInf]");
	var formImgObj = classObj.find("form[name=adminImgForm]");
	ajaxBeforeSendAdmin("<c:url value='/admin/ajaxBeforeSendAdmin.do'/>"); //IbSheet 조회전 세션 체크
	
	switch(sAction){
		case "init":
			fncInit2(formImgObj);
			break;
		
		case "add":
			
			var cateId = formObj.find("input[name=cateId]").val();
			if ( formImgObj.find("input[name=initFlag]").val() == "" ) { 
				alert("초기화 버튼을 눌러주세요.");		return;
			}
			if(cateId == ""){
				alert("상세정보를 먼저 등록해주세요");	return false; 
			}
			if ( formObj.find('input[id=file]').val() == "" ) {
				alert("파일을 선택해 주세요."); 	return false;
			}
			
			
			var imgLen = formImgObj.find(".img-box").length;
			
		    if(imgLen > 1){
					alert("대표이미지 1개만 등록가능합니다."); 
					return false;
				}
		   
			
			var srcFileNm = formImgObj.find("input[id=saveFileNm]").val();
			alert(srcFileNm);
			var fileExt = getFileExt(formImgObj.find("input[id=saveFileNm]").val());
			
			if(fileExt.toLowerCase() != "jpg" && fileExt.toLowerCase() != "jpeg" && fileExt.toLowerCase() != "gif" && fileExt.toLowerCase() != "png"){
				alert("이미지 파일[jpg/jpeg, gif, png]만 첨부가능 합니다.");
		        return false;
			}
			
 			ibsSaveJson = formImgObj.serialize(); 
 			//ibsSaveJson += "&srcFileNm="+srcFileNm+"&fileExt="+fileExt+"&bbsCd="+bbsCd+"&delYn=N&status=I&fileSize=";
 			ibsSaveJson += "&srcFileNm="+srcFileNm+"&fileExt="+fileExt+"&delYn=N&status=I&fileSize="+"&cateId="+cateId;
//  			alert(ibsSaveJson);    
			var url = "<c:url value='/admin/openinf/saveBbsFile.do'/>";                
			IBSpostJsonFile(formImgObj, url, fileSaveCallBack2);
			
			break;
			
		case "save":
			if(formImgObj.find("input[name=top_yn]").is(":checked") == false){
				alert("대표이미지를 지정해주세요.");
				return false;
			}
			var url = "<c:url value='/admin/bbs/updateTopYn.do'/>"; 
			var param = formObj.serialize();
				param += formImgObj.serialize();
			ajaxCallAdmin(url, param, ibsLinkcallback);
			break;
		
		case "modify":
		 	if ( !confirm("수정 하시겠습니까? ") ) {
				return;
  			}
			if(formImgObj.find("input[name=top_yn]").is(":checked") == false){
				alert("대표이미지를 지정해주세요.");
				return false;
			}
			var url = "<c:url value='/admin/bbs/updateDeleteImg.do'/>"; 
			var param = formObj.serialize();
				param += formImgObj.serialize();
 			//alert(param);
			ajaxCallAdmin(url, param, imgDeleteCallBack);
			break;
		
		case "delete":
 			if ( !confirm("삭제 하시겠습니까? ") ) {
				return;
  			}
 			if(formImgObj.find("input:checkbox[name=del_yn]").is(":checked") == false){
 				alert("삭제할 이미지를 선택해주세요."); 
 				return false;
 			}
			var url = "<c:url value='/admin/openinf/deleteImgDtl.do'/>"; 
			var param = formObj.serialize();
				param += formImgObj.serialize();
// 				alert(param);
			ajaxCallAdmin(url, param, imgDeleteCallBack);
			break;
	}
}

//초기화 버튼 클릭시
function fncInit2(formObj) {
// 	alert(typeof(gridObj));

	var appendFile = "";
/* 	if ( formObj.find("input[name=initFlag]").val() == "Y" ) {
		alert("이미 초기화 하였습니다.");		return;
	} */
	//값 초기화
	formObj.find("input[name=viewFileNm]").val("");
	formObj.find("input[name=initFlag]").val("Y");		//초기화하였음.
	//현재파일객체 숨김
	formObj.find("input[id=saveFileNm]").hide();
	formObj.find("input[id=file]").hide();
	//빈 파일객체 현재 순서ID로 추가..
	appendFile += "<input type='text' name='fileStatus' id='fileStatus' value='C' style='display:none;' readonly/>";
			appendFile += "<input type='text' name='saveFileNm' id='saveFileNm' style='display:none; width:200px;' value='' readonly>";
			appendFile += "<input type='file' name='file' id='file' onchange='fncFileChange2();' style='display:none; width:80px; color:#fff'/>";
	formObj.find("span[id=fileImgDiv]").find("span[id=fileImgInfo]").remove();	// 문구 삭제
	formObj.find("button[name=btn_init]").remove();	// 초기화 버튼 삭제
	formObj.find("span[id=fileImgDiv]").append(appendFile);
	//파일객체 추가하고 보여준다
	formObj.find("input[id=saveFileNm]").show();
	formObj.find("input[id=file]").show();
}

function fncFileChange2() {
	var classObj = $('.'+'content').eq(1);
	var formObj = classObj.find("form[name=adminImgForm]");
	val = formObj.find("input[id=file]").val().split("\\");
	fileName = val[val.length-1];
	f_name = fileName.substring(0, fileName.indexOf("."));
	s_name = fileName.substring(fileName.length-3, fileName.length);
	formObj.find("input[id=saveFileNm]").val(fileName);
// 	alert("fileName==>"+fileName+" , f_name==>"+f_name+" , s_name==>"+s_name);
}

function fileSaveCallBack2(res) {		// 이미지 미리보기 추가 콜백
	
	var classObj = $("."+'content').eq(1); //tab으로 인하여 form이 다건임
	
	var formObj = classObj.find("form[name=adminOpenInf]");
	
	
	var url = "<c:url value='/admin/openinf/bbsImgDetailView.do'/>";
	param = formObj.serialize();
	ajaxCall(url, param, bbsDtlCallBack);       
	
}

function bbsDtlCallBack(tab, json, res){
	
	var classObj = $("."+'content').eq(1); //tab으로 인하여 form이 다건임
	var formObj = classObj.find("form[name=adminOpenInf]");
	var formImgObj = classObj.find("form[name=adminImgForm]");
	var delUse = "N";
	var cateId = formObj.find("input[name=cateId]").val();
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
			
			var param = "downCd=C&fileSeq=0&seq="+cateId;
			append += "<div class='img-box'>";
			append += "<p><input type='hidden' name='delUse' value='"+delUse+"' /> <label for='ceoImg"+i+"'>대표이미지</label></p>";
			append += "<p><img src=\"<c:url value='/admin/openinf/fileDownload.do?"+param+"'/>\" alt='"+tab.resultImg[i].viewFileNm+"' width='120' height='120'/></p>";
			append += "<p><input type='checkbox' name='del_yn' id='del"+i+"' value='"+cateId+"' onclick=\"javascript:checkDel('"+delUse+"', '"+cateId+"', '"+i+"');\" /> <label for='del"+i+"'>삭제</label></p>";
			append += "</div> ";
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
	
}

function checkDel(delUse, cateId, seq){
	var classObj = $("."+'content').eq(1); //tab으로 인하여 form이 다건임
	var formObj = classObj.find("form[name=adminOpenInf]");

	var formImgObj = classObj.find("form[name=adminImgForm]");
	
	if(delUse == "Y"){
 		formImgObj.find("input[name=delYnVal]").val(cateId);
 		var url = "<c:url value='/admin/opendt/deleteImg.do'/>"; 
		var param = formObj.serialize();
			param += formImgObj.serialize();
		ajaxCallAdmin(url, param, imgDeleteCallBack2);
	}else{
		if(formImgObj.find("input:checkbox[id=del"+seq+"]").is(":checked") == true){
			formImgObj.find("input[name=delYn"+seq+"]").val(cateId);
		}else{
			formImgObj.find("input[name=delYn"+seq+"]").val('0');
		}
	}
	
	
}

function imgDeleteCallBack(res){
//	 var result = res.RESULT.CODE;
//	alert(res.RESULT.CODE);
	if(res.RESULT.CODE == 0){
		alert("<spring:message code='MSG.SAVE'/>");
	}else{
		alert("<spring:message code='ERR.SAVE'/>");
	}
	
	var classObj = $("."+'content').eq(1); //tab으로 인하여 form이 다건임
	var formObj = classObj.find("form[name=adminOpenInf]");
	var url = "<c:url value='/admin/opendt/bbsImgDetailView.do'/>";
	param = formObj.serialize();
	ajaxCall(url, param, bbsDtlCallBack);  
}

function imgDeleteCallBack2(res){
	var classObj = $("."+'content').eq(1); //tab으로 인하여 form이 다건임
	var formObj = classObj.find("form[name=adminOpenInf]");
	var url = "<c:url value='/admin/opendt/bbsImgDetailView.do'/>";
	param = formObj.serialize();
	ajaxCall(url, param, bbsDtlCallBack);  
}

/*Sheet 각종 처리*/                  
function doAction(sAction)                                  
{
	var classObj = $("."+"content").eq(0); //tab으로 인하여 form이 다건임
	var actObj = setTabForm(classObj); // 0: form data, 1: form 객체
	var formObj = $("form[name=adminOpenInfSearch]");        
	switch(sAction)
	{          
		case "search":      //조회   
			
			/* fromObj = formObj.find("input[name=openDttmFrom]");                          
			toObj = formObj.find("input[name=openDttmTo]");
			dateValCheck(fromObj,toObj)// from , to 날짜 안맞을 경우 자동셋팅    */
			ajaxBeforeSendAdmin("<c:url value='/admin/ajaxBeforeSendAdmin.do'/>"); //IbSheet 조회전 세션 체크
			var param = {PageParam: "ibpage", Param: "onepagerow=50&"+formObj.serialize()};   
			mySheet.DoSearchPaging("<c:url value='/admin/openinf/openInfListAll.do'/>", param);   
			$('html, body').animate({scrollTop : 0}, 100);	//최상위로
			break;
		case "reg":      //등록화면                 
			var title = "등록하기"
			var id ="openInfReg";
			openTab.addRegTab(id,title,tabCallRegBack); // 탭 추가 시작함
			break;
		case "popclose":              
			closeIframePop("iframePopUp");
			break;
		case "poporgnm":
			var url="<c:url value="/admin/basicinf/popup/commOrg_pop.do"/>" +  "?index=0";
			var popup = OpenWindow(url,"orgPop","500","550","yes");	    
			break;
		case "popcatenm":
			var url = "<c:url value="/admin/opendt/openCateParListPopUp.do"/>" + "?cateGb=2&index=0";
			var popup = OpenWindow(url,"openCateParListPopUp","750","550","yes");	
			popup.focus();
			break;
		/* case "metadown":			//공공데이터포털용 엑셀 다운로드
			formObj.attr("action","<c:url value='/admin/openinf/metaDownload.do'/>").submit();   
			break; */
	}           
}   

function doTabAction(sAction){
	var classObj = $("."+"content").eq(1); //tab으로 인하여 form이 다건임
	var actObj = setTabForm(classObj); // 0: form data, 1: form 객체
	var formObj = classObj.find("form[name=adminOpenInf]");
	ajaxBeforeSendAdmin("<c:url value='/admin/ajaxBeforeSendAdmin.do'/>"); //IbSheet 조회전 세션 체크
	switch(sAction){
		
		case "save":      //등록 
			
			if (!validateAdminOpenInf(actObj[1])){	return;			}	//xml Validation체크
			if(!saveCheck(formObj)){	return;			}	//validation 체크
			
			var sheetCnt = mySheet2.RowCount();
			if(sheetCnt == 0) {
				alert("조직정보를 등록하셔야 합니다.");
				return false;
			} 
			
			var cateId = formObj.find("input[name=cateId]").val();

			var cateId2 = formObj.find("input[name=cateId2]").val();
					
			if( cateId != "" && cateId == cateId2){
				alert("분류1의 값과 분류2의 값이 같으면 안됩니다.");
				formObj.find("input[name=cateId2]").val("");
				formObj.find("input[name=cateNm2]").val("");
				return false;
			}
			
			var rpstYns = "";
			for ( var i=1; i <= mySheet2.RowCount(); i++ ) {
				rpstYns = rpstYns + mySheet2.GetCellValue(i, "rpstYn");
			}
			if ( rpstYns.indexOf('Y') == -1 ) {
				alert("인원정보의 대표자(대표여부)를 선택해 주세요.");
				return false;
			}
			
			ibsSaveJson = mySheet2.GetSaveJson();
			
			var url = "<c:url value='/admin/openinf/openInfReg.do'/>"; 
			var param = formObj.serialize();
			param = param.replace(/%/g,'%25');					// parameter Encoding
			
// 			ajaxCallAdmin(url, param, saveCallBack);
			IBSpostJson(url, param, sheetCallBack);
			location.reload(); 
			break;
				
		case "update":      //수정 
			if ( !confirm("수정 하시겠습니까? ") ) {
				return;
  			}
			
		
			if (!validateAdminOpenInf(actObj[1])){	return;			}	//xml Validation체크
			if(!saveCheck(formObj)){	return;			}	//validation 체크
			
			var sheetCnt = mySheet2.RowCount();
			if(sheetCnt == 0) {
				alert("조직정보를 등록하셔야 합니다.");
				return false;
			}
			
			if(mySheet2.RowCount("D") == mySheet2.RowCount()){
				alert("조직정보는 최소 1개이상 존재하여야 합니다.");
				return false;
			}
			
			var rpstYns = "";
			for ( var i=1; i <= mySheet2.RowCount(); i++ ) {
				rpstYns = rpstYns + mySheet2.GetCellValue(i, "rpstYn");
			}
			if ( rpstYns.indexOf('Y') == -1 ) {
				alert("인원정보의 대표자(대표여부)를 선택해 주세요.");
				return false;
			}
			
			ibsSaveJson = mySheet2.GetSaveJson({AllSave:true});

			var url = "<c:url value='/admin/openinf/openInfUpd.do'/>";
			var param = formObj.serialize();
			param = param.replace(/%/g,'%25');
			
 			//param = encodeURIComponent(param);					// parameter Encoding
 			param = param + "&ibsSaveJson=" + JSON.stringify(ibsSaveJson);
			ajaxCallAdmin(url, param, sheetCallBack);
			
			//IBSpostJson(url, param, sheetCallBack);
			//formSubmit(url, param, sheetCallBack);
			location.reload(); 
			break;
			
			
		case "delete":      //삭제
			if ( !confirm("삭제 하시겠습니까? ") ) {
				return;
  			}
			
			ibsSaveJson = mySheet2.GetSaveJson({AllSave:true});
		
			 var url = "<c:url value='/admin/openinf/openInfDel.do'/>"; 
			 var param = formObj.serialize();
			 param = param.replace(/%/g,'%25');
			 
			 //ajaxCallAdmin(url, param, saveCallBack);
			 IBSpostJson(url, param, sheetCallBack);
			 location.reload(); 
			 break;
			 
		case "view":                         
			var infId = formObj.find("input[name=infId]").val();                  
			var target = "<c:url value='/admin/openinf/popup/openInfViewPopUp.do'/>"+"?infId="+infId;
			var wName = "metaview"        
			var wWidth = "1024"
			var wHeight = "580"                            
			var wScroll ="no"
			OpenWindow(target, wName, wWidth, wHeight, wScroll);                     
			break;
		
		case "import":
			var param = "infId="+formObj.find("input[name=existinfId]").val();
			var url =  "<c:url value='/admin/openinf/existOpenInfList.do'/>";
			ajaxCallAdmin(url, param, importCallBack);
			break;
			
		case "search":      //조회   
			var row = mySheet.GetSelectionRows();
			var infId = mySheet.GetCellValue(row,"infId");
			ajaxBeforeSendAdmin("<c:url value='/admin/ajaxBeforeSendAdmin.do'/>"); //IbSheet 조회전 세션 체크
			var param = {PageParam: "ibpage", Param: "onepagerow=50&infId="+infId};   
			
			
			mySheet2.DoSearchPaging("<c:url value='/admin/openinf/openInfOrgUsrList.do'/>", param);
			break;
		
		case "init":
			
			formObj.find("input[name=infId]").val("");
			formObj.find("input[name=infNm]").val("");
			
			formObj.find("input[name=cateId]").val("");
			formObj.find("input[name=cateIdTop]").val("");
			formObj.find("input[name=cateNm]").val("");
			formObj.find("input[name=cateId2]").val("");
			formObj.find("input[name=cateNm2]").val("");
			
			formObj.find("select[name=cclCd]").val("");
			
			formObj.find("input[name=dtId]").val("");
			formObj.find("input[name=dtNm]").val("");
			
			formObj.find("input[name=dsId]").val("");
			formObj.find("button[name=dsSearch]").show();
					
			
			formObj.find("select[name=openCd]").val("");
			
			formObj.find("select[name=causeCd]").val("");
			formObj.find("input[name=causeInfo]").val("");
			
			formObj.find("select[name=loadCd]").val("");
			
			formObj.find("input[name=infTag]").val("");
			formObj.find("input[name=openDttm]").val("");
			formObj.find("input[name=dataCondDttm]").val("");
			formObj.find("input[name=useDeptNm]").val("");
			formObj.find("textarea[name=infExp]").val("");
			formObj.find("div[name=infExp]").val("");
			formObj.find("input[name=infState]").val("");
			
			formObj.find(".icon-open1").attr("style", "display:none;");
			formObj.find(".icon-open2").attr("style", "display:none;");
			formObj.find(".icon-open3").attr("style", "display:none;");
			formObj.find(".icon-open4").attr("style", "display:none;");
			
			formObj.find(".serviceYn").find("span").removeClass("icon-no-service").addClass("icon-no-service");
			formObj.find("select[name=cclCd]").val("");
			formObj.find("select[name=fvtDataOrder]").val("0").hide();
			formObj.find("input[name=fvtDataYn]").prop("checked", false);
			
			formObj.find("h3[name=tblOpenH3]").hide();			//개방 공개 숨김
			formObj.find("table[name=tblOpenTable]").hide();	//개방 공개 숨김
			
			mySheet2.RemoveAll();
			
			Btn_Set();
			$('html, body').animate({scrollTop : $("#dtl-area").offset().top}, 100);	//상세정보로 스크롤 이동
			break;
		case "infStateY" :		//공개버튼
			doPost({
		        url:"/admin/openinf/updateInfState.do",
		        before : beforeUpdateInfStateY,
		        after : function() {
		        	location.href = com.wise.help.url("/admin/openinf/openInfPage.do");
		        }
		    });
			break;
		case "infStateC" :		//공개취소 버튼
			doPost({
		        url:"/admin/openinf/updateInfState.do",
		        before : beforeUpdateInfStateN,
		        after : function() {
		        	location.href = com.wise.help.url("/admin/openinf/openInfPage.do");
		        }
		    });
			break;		
	}
}

//공개처리
function beforeUpdateInfStateY() {
	var data = {};
	var classObj = $("."+"content").eq(1); //tab으로 인하여 form이 다건임
	var formObj = classObj.find("form[name=adminOpenInf]");
    $.each(formObj.serializeArray(), function(index, element) {
        switch (element.name) {
        	case "infId":
        	case "infState":	
            case "openDttm":
            	data[element.name] = element.value;
            	break;
        }
    });
    
    if ( data.infState == "Y" ) {
        alert("이미 공개 된 상태 입니다.");
        return null;
    }
    if (com.wise.util.isBlank(data.openDttm)) {
        alert("공개일을 선택하세요");
        return null;
    }
    
    if ( !confirm("공개처리 하시겠습니까?") )	return null;
    
    data["infState"] = "Y";
    return data;
}
//공개취소 처리
function beforeUpdateInfStateN() {
	var data = {};
	var classObj = $("."+"content").eq(1); //tab으로 인하여 form이 다건임
	var formObj = classObj.find("form[name=adminOpenInf]");
	
    $.each(formObj.serializeArray(), function(index, element) {
        switch (element.name) {
        	case "infId":
            case "infState":
            	data[element.name] = element.value;
            	break;
        }
    });
    
    if ( data.infState == "N" ) {
        alert("이미 공개취소 된 상태 입니다.");
        return null;
    }
    
    data["infState"] = "N";
    if ( !confirm("공개취소 처리 하시겠습니까?") )	return null;
    return data;
}

function sheetCallBack(res) {
	var result = res.RESULT.CODE;
	if(result == 0) {
		alert(res.RESULT.MESSAGE);		
	} else {
		alert(res.RESULT.MESSAGE);
	}
}

function mySheet_OnDblClick(row, col, value, cellx, celly) {
    if(row == 0) return;   
	    var formObj = $("form[name=adminOpenInf]");
    	
       $("a[name=a_modify]").show();
	   $("a[name=a_del]").show();
	   
	   $("a[name=a_reg]").hide();
	   $("a[name=a_reset]").show();
	   
	   formObj.find("h3[name=tblOpenH3]").show();			//개방 공개 보임
	   formObj.find("table[name=tblOpenTable]").show();	//개방 공개 보임
	   
	 
    //tabEvent(row);   
    
    var url = "<c:url value='/admin/openinf/openInfList.do'/>";
    var param = "infId= " + mySheet.GetCellValue(row,"infId");
    
    ajaxBeforeSendAdmin("<c:url value='/admin/ajaxBeforeSendAdmin.do'/>"); //IbSheet 조회전 세션 체크
    ajaxCallAdmin(url, param, tabInfCallBack);
    doTabAction("search");
    
    if(formObj.find("input[name=infState]").val() == "N" || formObj.find("input[name=infState]").val() == "C"){
		   formObj.find("a[name=a_infStateCancel]").hide();
		   formObj.find("a[name=a_infState]").show();
	   } else{
		   formObj.find("a[name=a_infStateCancel]").show();
		   formObj.find("a[name=a_infState]").hide();
	   }
    $('html, body').animate({scrollTop : $("#dtl-area").offset().top}, 100);	//상세정보로 스크롤 이동
    //////////////////////////////////
    /* 
     $(function(){
    	 $('input[name=themeCd]').attr("disabled", false);
			$('input[name=saCd]').attr("disabled", false);
    	 var row = mySheet.GetSelectionRows();
    	 var dsId = mySheet.GetCellValue(row, "dsId");
    	 var emdYn = mySheet.GetCellValue(row, "emdYn");
		if(dsId==null || dsId==""){
			// 테마 / 생애주기 설정 불가
			$('input[name=themeCd]').attr("disabled", true);
			$('input[name=saCd]').attr("disabled", true);
		}
		if(emdYn=="N"){
			// 테마 설정 불가능
			$('input[name=themeCd]').attr("disabled", true);
			return false;
		}
	}); */
    //////////////////////////////////
    
    
}


function mySheet2_OnPopupClick(Row, Col){
	
	
			if(mySheet2.ColSaveName(Col) == "orgNm"){
					window.open("<c:url value="/admin/basicinf/popup/commOrg_pop.do"/>" + "?orgNmGb=7&sheetNm=mySheet2","list"
				, "fullscreen=no, width=500, height=550"); 
			}
			
			else if(mySheet2.GetCellValue(Row, "orgNm") != "" && mySheet2.ColSaveName(Col) == "usrNm"){
				window.open("<c:url value="/admin/basicinf/popup/commUsrPos_pop.do"/>" + "?usrGb=4&sheetNm=mySheet2&orgCd="+mySheet2.GetCellValue(Row, "orgCd") ,"list"
						, "fullscreen=no, width=600, height=550");
			}
			else{
				alert("조직명을 넣어주세요");
			}
			
			/* formObj.find("button[name=usrSearch]").click(function() {		// 직원명 팝업
		 		var orgCd = formObj.find("[name=orgCd]").val();   
		 		if(orgCd == ""){
		 			alert("담당조직을 먼저 선택해주세요.");
		 			return false;
		 		}
				var url = "<c:url value="/admin/basicinf/popup/commUsr_pop.do"/>" + "?usrGb=3&orgCd="+orgCd; 
				var popup = OpenWindow(url,"usrPop","500","550","yes");	        
		 		return false;    
		 	}); */
}

  /* function mySheet2_OnPopupClick(Row, Col) {
	//if(Row == 0) return;
	//var objTab = getTabShowObj(); //탭이 oepn된 객체가져옴
	var classObj = $("."+"content_dt");
	var formObj = classObj.find("form[name=adminOpenInf]");    
	//var sheetObj =formObj.find("input[name=sheetNm]").val();  
	var mySheet2 = formObj.find("[name=mySheet2]").val();
	var gridObj = window[mySheet2];
	var param = "?sheetNm="+sheetObj;
		param += "&toSeq="+Row;
	//mySheet2.DataInsert(0);
// 	var data = "?dsId="+gridObj.GetCellValue(Row,"dsId");       
// 		data += "&colSeq="+gridObj.GetCellValue(Row,"colSeq");                
	
	formObj.find("button[name=orgNm]").click(function(){		// 조직 추가 팝업
 		var mySheet2 = formObj.find("[name=mySheet2]").val();
 		var url="<c:url value="/admin/basicinf/popup/commOrg_pop.do"/>" + "?orgNmGb=7&sheetNm=mySheet2"; 
		var popup = OpenWindow(url,"orgPop","500","550","yes");	            
 	});  
	alert("1");
	if(gridObj.ColSaveName(Col) == "orgNm"){
		
		var target = "<c:url value="/admin/basicinf/popup/commOrg_pop.do"/>" + "?orgNmGb=7&sheetNm=mySheet2"; 
		//var wName = "ccolview";        
		//var wWidth = "900";            
		//var wHeight = "600" ;                           
		//var wScroll ="yes";
		OpenWindow(target, "orgPop","500","550","yes");
		
		
		
	}
	
	if(gridObj.ColSaveName(Col) == "empNm"){
		var target = "<c:url value='/admin/openinf/opends/openDsTermPop.do"+param+"'/>";
		var wName = "ccolview";        
		var wWidth = "900";            
		var wHeight = "600" ;                           
		var wScroll ="yes";
		OpenWindow(target, wName, wWidth, wHeight, wScroll);
		
	}
}   */


function tabInfCallBack(json){
	var classObj = $("."+"content").eq(1); //tab으로 인하여 form이 다건임
	var formObj = classObj.find("form[name=adminOpenInf]");
	//formObj.find("input[name=themeCd]").removeAttr("checked",true);
	//formObj.find("input[name=saCd]").removeAttr("checked",true);
	
	formObj.find(".serviceYn").find("span").removeClass("icon-no-service").addClass("icon-no-service");
	if(json.DATA != null){
		$.each(json.DATA,function(key,state){
			
			var srvCd = state.srvCd;
			var srvIndex = typeIndex(srvCd);
			var metaCate = state.metaCate;
			
			
			$.each(state,function(key2,state2){
// 				formObj.find("a[name=a_reg]").remove();
				
				if(key2 == "infState"){
					if(state2 == "Y"){
						formObj.find(".icon-open1").attr("style", "");
						formObj.find(".icon-open2").attr("style", "display:none;");
						formObj.find(".icon-open3").attr("style", "display:none;");
						formObj.find(".icon-open4").attr("style", "display:none;");
					}else if(state2 == "N"){
						formObj.find(".icon-open1").attr("style", "display:none;");
						formObj.find(".icon-open2").attr("style", "");
						formObj.find(".icon-open3").attr("style", "display:none;");
						formObj.find(".icon-open4").attr("style", "display:none;");
					}else if(state2 == "X"){
						formObj.find(".icon-open1").attr("style", "display:none;");
						formObj.find(".icon-open2").attr("style", "display:none;");
						formObj.find(".icon-open3").attr("style", "");
						formObj.find(".icon-open4").attr("style", "display:none;");
					}else if(state2 == "C"){
						formObj.find(".icon-open1").attr("style", "display:none;");
						formObj.find(".icon-open2").attr("style", "display:none;");
						formObj.find(".icon-open3").attr("style", "display:none;");
						formObj.find(".icon-open4").attr("style", "");
					}
				}
				if(key2 =="srvYn" && srvIndex > -1){ //사용여부 판단    
					
					if(state2 =="Y"){                                                 
						formObj.find(".serviceYn").find("span").eq(srvIndex).removeClass("icon-no-service").addClass("icon-on");
					}else{
						formObj.find(".serviceYn").find("span").eq(srvIndex).removeClass("icon-no-service").addClass("icon-service");            
					} 
				}
				
				if(key2 == "openCd"){
					if(state2 == "DT002"){
						formObj.find("select[name=causeCd]").attr("disabled", "disabled");
						formObj.find("input[name=causeInfo]").attr("readonly", "readonly");	
					}
				}
				if(key2 == "dsId"){
						formObj.find("[name=dsId]").val(state2);
						formObj.find("button[name=dsSearch]").hide();
					
				}else if(key2 == "srvCd"){
					if(state2 == null){
						formObj.find("button[name=dsSearch]").show();
					}
				}else if(key2 == "apiRes"){
					if(state2 != null){
						formObj.find("[name=apiRes]").val(state2);
					}
				}else if(key2 == "sgrpCd"){
					if(state2 != null){
						formObj.find("[name=sgrpCd]").val(state2);
					}
				}else if(key2 == "metaCate"){
					formObj.find("[id="+state2+"]"+":checkbox[value='"+state2+"']").prop("checked",true);
				}
				else{
					if(formObj.find("[name="+key2+"]").attr("type") == 'radio'){          
						formObj.find("[name="+key2+"]"+":radio[value='"+state2+"']").prop("checked",true);                                                                          
					}else if(formObj.find("[name="+key2+"]").attr("type") == 'checkbox'){          
						formObj.find("[name="+key2+"]"+":checkbox[value='"+state2+"']").prop("checked",true); 
					}else{  
						formObj.find("[name="+key2+"]").val(state2).change();
					}
				}
			});
		});    
	}
	//var objTab = getTabShowObj();//탭이 oepn된 객체가져옴
 	//var formObj = objTab.find("form[name=adminOpenInf]");    
	//formObj.find("a[name=a_import]").remove();
	//setTabButton();
}


function importCallBack(tab, json){
	var objTab = getTabShowObj();
	var formObj = objTab.find("form[name=adminOpenInf]");
	$.each(tab.DATA,function(key,state){
		if (formObj.find("input:checkbox[name="+key+"]").attr("type") == 'checkbox') {
			if ( state == "Y" ) {
				formObj.find("input:checkbox[name="+key+"]").prop("checked",true);
			} else {
				formObj.find("input:checkbox[name="+key+"]").prop("checked",false);
			}
		} 
		if( key == "infId"){
			formObj.find("input[name=infId]").val("");
		} else {
			formObj.find("[name="+key+"]").val(state);
		}
		
	});
}

function saveCheck(formObj){
	if( formObj.find('select[name=openCd]').val() == "DT003" || formObj.find('select[name=openCd]').val() == "DT004"){
 		if( formObj.find('select[name=causeCd]').val() == "" ){
 			alert("개방여부가 개방이 아닐 경우 미(부분)개방사유 선택은 필수입니다. ");
 			return false;
 		}	
	}
	var cateIdTop = formObj.find("input[name=cateIdTop]").val();
	if(cateIdTop == "KOR"){
		formObj.find("input[name=korYn]").val("Y");
		formObj.find("input[name=engYn]").val("N");
		formObj.find("input[name=korMobileYn]").val("N");
	}else if(cateIdTop == "ENG"){
		formObj.find("input[name=engYn]").val("Y");
		formObj.find("input[name=korYn]").val("N");
		formObj.find("input[name=korMobileYn]").val("N");
	}else if(cateIdTop == "MOB"){
		formObj.find("input[name=korMobileYn]").val("Y");
		formObj.find("input[name=engYn]").val("N");
		formObj.find("input[name=korYn]").val("N");
	}
	
	return true;
}






function tabEvent(row){	//탭 이벤트 실행                
	var title = mySheet.GetCellValue(row,"infNm");//탭 제목      
	var id = mySheet.GetCellValue(row,"infId");//탭 id(유일해야함))     
    openTab.SetTabData(mySheet.GetRowJson(row));//db data 조회시 조건 data
    var url = "<c:url value='/admin/openinf/openInfList.do'/>"; // Controller 호출 url
    openTab.addTab(id,title,url,tabInfCallBack); // 탭 추가 시작함
}



function typeIndex(srvCd){          
	var srvIndex = -1
	switch(srvCd)                    
	{          
		    
		case "S":      
			srvIndex = 0;
			break;
		case "C":      
			srvIndex = 1;
			break; 
		case "M":      
			srvIndex = 2;
			break; 
		case "L":      
			srvIndex = 3;
			break; 
		case "F":      
			srvIndex = 4;
			break; 
		case "A":      
			srvIndex = 5;
			break;    
		case "V":      
			srvIndex = 6;
			break;  
	}
	return srvIndex;
}

function regUserFunction(){		// 등록callback
	var objTab = getTabShowObj();//탭이 oepn된 객체가져옴
 	var formObj = objTab.find("form[name=adminOpenInf]");    
 	formObj.find("a[name=a_view]").remove();
 	formObj.find("button[name=dsInfo]").remove();  
// 	formObj.find("input:checkbox[name=korYn]").prop("checked",true);		// 디폴트 게시위치 한글
	formObj.find("select[name=openCd]").val("DT002");		// 디폴트 적재주기 개방
	formObj.find("select[name=causeCd]").val("DS000");
	formObj.find("select[name=causeCd]").attr("disabled", "disabled");
	formObj.find("input[name=causeInfo]").attr("readonly", "readonly");	
	
	formObj.find("h3[name=tblOpenH3]").hide();			//공공데이터 개방숨김
	formObj.find("table[name=tblOpenTable]").hide();	//공공데이터 개방숨김
//  	formObj.find("input[name=usrNm]").val('솔직원1(나중에 수정..)');
}

function viewPop(srvCd){
	var classObj = $("."+"content").eq(1); 
	//var objTab = getTabShowObj();//탭이 oepn된 객체가져옴
 	var formObj = classObj.find("form[name=adminOpenInf]");     
	var infId = formObj.find("input[name=infId]").val();       
	var apiRes = formObj.find("input[name=apiRes]").val();       
	var sgrpCd = formObj.find("input[name=sgrpCd]").val();       
	var data = "";
	if(srvCd == "F"){
		data = "&popupUse=Y";
	}else if(srvCd == "A"){
		data = "&popupUse=Y&apiRes="+apiRes;
	}else if(srvCd == "C"){
		data = "&sgrpCd="+sgrpCd
	}
	var target = "<c:url value='/admin/service/openInfColViewPopUp.do?infId="+infId+"&srvCd="+srvCd+""+data+" '/>";
	var wName = "colview"        
	var wWidth = "1024"
	var wHeight = "768"                            
	var wScroll ="no"
	OpenWindow(target, wName, wWidth, wHeight, wScroll);       
}

function setTabButton(){		//버튼event
/* 	var objTab = getTabShowObj();//탭이 oepn된 객체가져옴
 	var formObj = objTab.find("form[name=adminOpenInf]"); */     
 	
 	//var classObj = $("."+"content_dt"); //tab으로 인하여 form이 다건임
 	var classObj = $("."+"content").eq(1); //tab으로 인하여 form이 다건임
	var formObj = classObj.find("form[name=adminOpenInf]");
	var formObjImg = classObj.find("form[name=adminImgForm]");
 	
 	formObj.find("input, textarea").placeholder();
 	/* datepickerInitTab(formObj.find("input[name=openDttm]")); //초기화
	formObj.find("input[name=openDttm]").datepicker(setCalendar());    
	datepickerTrigger();  */    
	
 	/* formObj.find("[name=T]").click(function() {		// TsSheet미리보기
 		if(!formObj.find("[name=T]").hasClass("icon-no-service")){
 			viewPop('T');
 		}
 		return false;                 
 	}); */
 	formObj.find("[name=S]").click(function() {		//rawSheet미리보기
 		if(!formObj.find("[name=S]").hasClass("icon-no-service")){
 			viewPop('S');
 		}
 		return false;                 
 	});
 	formObj.find("[name=M]").click(function() {		//map미리보기
 		if(!formObj.find("[name=M]").hasClass("icon-no-service")){
 			viewPop('M');
 		}
 		return false;                 
 	});
 	formObj.find("[name=L]").click(function() {		//link미리보기
 		if(!formObj.find("[name=L]").hasClass("icon-no-service")){
 			viewPop('L');
 		}  
 		return false;                 
 	});
 	formObj.find("[name=F]").click(function() {		//file미리보기
 		if(!formObj.find("[name=F]").hasClass("icon-no-service")){
 			viewPop('F');
 		}  
 		return false;                 
 	});
 	formObj.find("[name=C]").click(function() {		//chart미리보기
 		if(!formObj.find("[name=C]").hasClass("icon-no-service")){
 			viewPop('C');
 		}     
 		return false;                 
 	});
 	formObj.find("[name=A]").click(function() {		//openAPI미리보기
 		if(!formObj.find("[name=A]").hasClass("icon-no-service")){
 			viewPop('A');
 		}     
 		return false;                 
 	});
 	formObj.find("[name=V]").click(function() {		//MultiMedia 미리보기
 		if(!formObj.find("[name=A]").hasClass("icon-no-service")){
 			viewPop('V');
 		}     
 		return false;                 
 	});

	
 	formObj.find("a[name=a_reg]").click(function() {		// 신규등록
 		doTabAction("save");          
 		return false;                 
 	});
 	
 	formObj.find("a[name=a_modify]").click(function() {		// 수정
 		doTabAction("update");          
 		return false;                 
 	});
 	
 	formObj.find("a[name=a_del]").click(function() {		// 삭제
 		doTabAction("delete");          
 		return false;                 
 	});
 	
 	
 	
 	formObj.find("button[name=dtSearch]").click(function() {		// 보유데이터 팝업
 		var url="<c:url value="/admin/openinf/opends/popup/openDt_pop.do"/>" + "?index=1";
		var popup = OpenWindow(url,"OpenInfdtPop","700","550","yes");	       
 		return false;    
 	});
 	
 	formObj.find("button[name=cateSearch]").click(function() {		// 분류명 팝업
 		var url = "<c:url value="/admin/opendt/openCateParListPopUp.do"/>" + "?cateGb=3&index=1";
		var popup = OpenWindow(url,"openCateParListPopUp","750","550","yes");	
		popup.focus();
 		return false;    
 	});
 	
 	formObj.find("button[name=cateReset]").click(function() { // 2차 분류명 리셋
 		formObj.find("input[name=cateNm2]").val("");
 		formObj.find("input[name=cateId2]").val("");
 		
 	});
 	
 	formObj.find("button[name=cateReset2]").click(function() { // 데이터셋 리셋
 		formObj.find("input[name=dsId]").val("");
 		
 	});
 	
 	formObj.find("button[name=cateSearch2]").click(function() {		// 분류명 팝업
 		
 		var cateId = formObj.find("input[name=cateId]").val();
 		
 		if(cateId == ""){
 			alert("먼저 분류1의 값을 넣어주세요");
 			return false;
 		}
 		
 		var url = "<c:url value="/admin/opendt/openCateParListPopUp.do"/>" + "?cateGb=4&index=1";
		var popup = OpenWindow(url,"openCateParListPopUp","750","550","yes");	
		popup.focus();
		
		var cateId2 = formObj.find("input[name=cateId2]").val();
		
		if(cateId == cateId2){
			alert("분류1의 값과 분류2의 값이 같으면 안됩니다.");
			formObj.find("input[name=cateId2]").val("");
			formObj.find("input[name=cateNm2]").val("");
			return false;
		}
		
 		return false;    
 	});
 	
 	formObj.find("button[name=dsSearch]").click(function() {		// 데이터셋 팝업
 		getDtId();
 		if(dtId == ""){
 			alert("보유데이터를 먼저 선택해주세요.");
 		}else{
	 		var url="<c:url value="/admin/openinf/popup/openInfDs_pop.do"/>" + "?dtId="+dtId + "&index=1";
			var popup = OpenWindow(url,"OpenInfdsPop","700","550","yes");	       
 		}
 		return false;    
 	});
 	
 	formObj.find("button[name=dsInfo]").click(function() {		// 데이터셋정보팝업
		var dsId = formObj.find("input[name=dsId]").val();                  
 		if(dsId == ""){
 			alert("데이터셋을 먼저 선택해주세요.");
 		}else{
 			var target = "<c:url value="/admin/openinf/opends/popup/opends_samplePop.do"/>";
 			var wName = "samplePop"        
 			var wWidth = "1024"
 			var wHeight = "580"                            
 			var wScroll ="no"
 			OpenWindow(target+"?dsId="+dsId, wName, wWidth, wHeight, wScroll);      
 		}
 		return false;    
 	});
 	formObj.find("button[name=usrSearch]").click(function() {		// 직원명 팝업
 		var orgCd = formObj.find("[name=orgCd]").val();   
 		if(orgCd == ""){
 			alert("담당조직을 먼저 선택해주세요.");
 			return false;
 		}
		var url = "<c:url value="/admin/basicinf/popup/commUsr_pop.do"/>" + "?usrGb=3&orgCd="+orgCd; 
		var popup = OpenWindow(url,"usrPop","500","550","yes");	        
 		return false;    
 	});
 	
 	formObj.find("select[name=openCd]").change(function(){
 		var openCdVal = formObj.find("select[name=openCd]").val();
 		if(openCdVal == "DT002"){
 			formObj.find("select[name=causeCd]").val("DS000");	
 			formObj.find("select[name=causeCd]").attr("disabled", "disabled");
 			formObj.find("input[name=causeInfo]").attr("readonly", "readonly");
 		}else{
 			formObj.find("select[name=causeCd]").removeAttr("disabled");
 			formObj.find("input[name=causeInfo]").removeAttr("readonly", "readonly");
 		}
 		return false;
 	});
 	
 	/* formObj.find("button[name=orgNm]").click(function(){		// 조직 추가 팝업
 		var mySheet2 = formObj.find("[name=mySheet2]").val();
 		var url="<c:url value="/admin/basicinf/popup/commOrg_pop.do"/>" + "?orgNmGb=7&sheetNm=mySheet2"; 
		var popup = OpenWindow(url,"orgPop","500","550","yes");	            
 	}); 
 	 */
 	formObj.find("a[name=a_import]").click(function(){		//불러오기
 		var url="<c:url value="/admin/openinf/popup/existOpenInfPop.do"/>";
		var popup = OpenWindow(url,"existOpenInfPop","900","550","yes");	 
 		return false;
 	});
 	
 	formObj.find("a[name=a_view]").click(function() {		// 미리보기
 		doTabAction("view");          
 		return false;                 
 	});
 	
 	formObj.find("textarea[name=infExp]").keyup(function(e) {         	//한글설명 글자수제한          
 		CheckMaxString(formObj.find("textarea[name=infExp]"), 4000, "kor");
 		return false;                                                                          
 	});
 	
 	formObj.find("textarea[name=infExpEng]").keyup(function(e) {         	//영문설명 글자수제한          
 		CheckMaxString(formObj.find("textarea[name=infExpEng]"), 4000, "eng");
 		return false;                                                                          
 	});
 	
 	formObj.find("textarea[name=loadDesc]").keyup(function(e) {         	//공표설명 글자수제한          
 		CheckMaxString(formObj.find("textarea[name=loadDesc]"), 1000, "kor");
 		return false;                                                                          
 	});
 	
	formObj.find("input[name=infNmEng]").keyup(function(e) {        
		ComInputEngEtcObj2(formObj.find("input[name=infNmEng]"));    
		 return false;                                                                          
	 });  
	
	formObj.find("input[name=infTagEng]").keyup(function(e) {
		ComInputEngBlankComObj(formObj.find("input[name=infTagEng]"));    
		return false;                                                                          
	 }); 
	
	
	formObj.find("button[name=orgAdd]").click(function() {
		mySheet2.DataInsert(0);
	});
	
	formObj.find("a[name=a_init]").click(function() {
 		doTabAction("init");          
 		return false;                 
 	});
	
	//img 관련 기능 구현
	formObjImg.find("button[name=btn_init]").click(function(e){		
		
		doActionImg("init");
		
		return false;		
	});
	
	formObjImg.find("button[name=btn_add]").click(function(){		//이미지 추가
		
		doActionImg("add");  
		return false;		
	});
	
	formObjImg.find("a[name=a_del]").click(function(){		//이미지 추가
		
		doActionImg("delete");  
		return false;		
	});
	
}





function CheckMaxString(obj, maxNum, ver){
	var ls_str = obj.val();
	var li_str_len = ls_str.length;
	var li_max = maxNum;
	var i =0;
	var li_byte = 0;
	var li_len = 0;
	var ls_one_char = "";
	var ls_str2 = "";
	for(i=0; i<li_str_len; i++){
		ls_one_char = ls_str.charAt(i);
		if(escape(ls_one_char).length > 4 ) {
			li_byte += 2;
		}else{
			li_byte++;
		}
		if(li_byte <= li_max){
			li_len = i+1;
		}
	}
	if(ver == "eng"){
		obj.css("ime-mode","disabled");
		strb = obj.val().toString();   
		strb = strb.replace(/[ㄱ-ㅎ가-힣]/g, '');
		obj.val(strb);
	}
	
	if(li_byte > li_max){
		alert(maxNum+"Byte를 초과할 수 없습니다.");
		ls_str2 = ls_str.substr(0, li_len);
		obj.val(ls_str2);
	}
	obj.focus();
}

function getDtId(){
	var objTab = getTabShowObj();//탭이 oepn된 객체가져옴
 	var formObj = objTab.find("form[name=adminOpenInf]");    
	dtId = formObj.find("input[name=dtId]").val();
}


// 마우스 이벤트
function mySheet_OnSearchEnd(code, msg)
{
   if(msg != "")
	{
	    alert(msg);
    }
}

//마우스 이벤트
function OnSaveEnd()
{
	doAction("search");     
}           

function inputEnterKey(){
	$("input").keypress(function(e) {
		  if(e.which == 13) {
			  doAction('search');   
			  return false;
		  }
	});
}           




/* function formSubmit(urls, param, CallBack) {
    var params = jQuery("#adminOpenInf").serialize(); // serialize() : 입력된 모든Element(을)를 문자열의 데이터에 serialize 한다.
    jQuery.ajax({
        url: '/admin/openinf/openInfReg.do',
        type: 'POST',
        data:params,
        contentType: 'application/x-www-form-urlencoded; charset=UTF-8', 
        dataType: 'html',
        success: CallBack,
        error:function(request,textStatus){
        	 if(request.status == 9999){                
        		 $("form").eq(0).attr("action",getContextPath+"/admin/admin.do").submit();
        	 }else{
        		 alert('에러발생...' + textStatus);
        	 }
         }
    });
} */
                   
          
//]]> 
</script>
</head>
<body onload="">
	<div class="wrap">
		<c:import url="/admin/admintop.do" />
		<!--##  메인  ##-->
		<div class="container">
			<!-- 상단 타이틀 -->
			<div class="title">
				<h2>${MENU_NM}</h2>
				<p>${MENU_URL}</p>
			</div>
			<!-- 탭 -->
			<!-- <ul class="tab">
				<li class="all_list"><a href="#">전체목록</a></li>
			</ul> -->
			<div class="more_list" style="display: none">
				<a href="#" class="more">0</a>
				<ul class="other_list" style="display: none;">
					<li><a href="#">보유데이터목록</a><a href="#" class="line_close">x</a></li>
					<li><a href="#">공공데이터목록asdfsdfsfsdfsdfsdf</a><a href="#"
						class="line_close">x</a></li>
				</ul>
			</div>

			<!-- 목록내용 -->
			<div class="content">
				<form name="adminOpenInfSearch" method="post" action="#">
					<table class="list01">
						<caption>데이터셋 관리</caption>
						<colgroup>
							<col width="150" />
							<col width="" />
							<col width="150" />
							<col width="" />
						</colgroup>
						<tr>
							<th><label class="">분류</label></th>
							<td><input type="hidden" name="cateId" value="" /> 
								<input type="text" name="cateNm" readonly="readonly" />
								<button type="button" class="btn01" name="btn_search">
									<spring:message code="btn.search" />
								</button>
								<button type="button" class="btn01" name="btn_init">초기화</button>
							</td>
							<th><label class=""><spring:message
										code="labal.bbsOrgCd" /></label></th>
							<td><input type="hidden" name="orgCd" /> <input type="text"
								name="orgNm" readonly="readonly" />
								<button type="button" class="btn01" name="btn_search">
									<spring:message code="btn.search" />
								</button>
								<button type="button" class="btn01" name="btn_init2">초기화</button>
							</td>
							


						</tr>
						<tr>
							<th><label class=""><spring:message
										code="labal.cclCd" /></label></th>
							<td><select name="cclCd">
									<option value=""><spring:message code="labal.whole" /></option>
									<c:forEach var="code" items="${codeMap.cclCd}" varStatus="status">
										<option value="${code.ditcCd}">${code.ditcNm}</option>
									</c:forEach>
							</select></td>
							
							<th>서비스</th>
							<td>
							<%-- <select name="infSrv">
									<option value="" selected="selected"><spring:message
											code="labal.whole" /></option>
									<option value="S">SHEET</option>
									<option value="C">CHART</option>
									<option value="M">MAP</option>
									<option value="L">LINK</option>
									<option value="F">FILE</option>
									<option value="O">OPEN API</option>
									<option value="V">MUITIMEDIA</option>
							</select> --%>
							<select id="infSrv" name="infSrv">
									<option value="">전체</option>
									<c:forEach var="code" items="${codeMap.infSrv}" varStatus="status">
										<option value="${code.ditcCd}">${code.ditcNm}</option>
									</c:forEach>
							</select>
							</td>
							
						</tr>

						<tr>
							<th><spring:message code="labal.search" /></th>
							<td colspan="3"><select name="searchWd">
									<option value=""><spring:message code="labal.whole" /></option>
									<option value="0">공공데이터명</option>
									<option value="1">보유데이터명</option>
							</select> <input name="searchWord" type="text" value="" style="width: 240px" />
							<input type="checkbox" name="fvtDataYn" id="fvtDataYn" value="Y">
							<label for="fvtDataYn">추천(홈페이지 노출)</label></input> 
							
								<button type="button" class="btn01B" name="btn_search">
									<spring:message code="btn.inquiry" />
								</button>
								<button type="button" class="btn01" name="btn_regInit">등록</button>
							</td>
						</tr>
						
						<tr>
							<th><label class=""><spring:message code="labal.infState" /></label></th>
							<td colspan="3">
							<%-- <select name="infState">
									<option value="" selected="selected"><spring:message code="labal.infStateA" /></option>
									<option value="N"><spring:message
											code="labal.infStateN" /></option>
									<option value="Y"><spring:message
											code="labal.infStateY" /></option>
									<option value="C"><spring:message
											code="labal.infStateC" /></option>
									<option value="X"><spring:message code="labal.infStateX" /></option>
							</select> --%>
							<input type="radio" id="infStateAll" name="infState" value=""  checked="checked"><label for="infStateAll"><spring:message code="labal.infStateA" /></label></input>&nbsp;&nbsp;
							<input type="radio" id="infStateN" name="infState" value="N" ><label for="infStateN"><spring:message code="labal.infStateN" /></label></input>&nbsp;&nbsp;
							<input type="radio" id="infStateY" name="infState" value="Y" ><label for="infStateY"><spring:message code="labal.infStateY" /></label></input>&nbsp;&nbsp;
							<input type="radio" id="infStateX" name="infState" value="X" ><label for="infStateX"><spring:message code="labal.infStateX" /></label></input>&nbsp;&nbsp;
							<input type="radio" id="infStateC" name="infState" value="C" ><label for="infStateC"><spring:message code="labal.infStateC" /></label></input>&nbsp;&nbsp;
							
							<%-- <input type="radio" id="infStateAll" name="infState" value=""  checked="checked"><label for="infStateAll">전체</label></input>&nbsp;&nbsp;
							<c:forEach var="code" items="${codeMap.infState }" varStatus="status">
								<input type="radio" id="infState_${code.ditcCd }" name="infState" value="${code.ditcCd }" ><label for="infState_${code.ditcCd }">${code.ditcNm }</label></input>&nbsp;&nbsp;
							</c:forEach> --%>
							
							</td>
						</tr>
					</table>


					<!-- ibsheet 영역 -->
					<div style="clear: both;"></div>
					<div class="ibsheet_area_both">
						<script type="text/javascript">createIBSheet("mySheet", "100%", "300px"); </script>
					</div>
				</form>

			</div>

			<!----------------------------------------------- 탭 내용 -------------------------------------------------------------->

			<div class="content" style="clear: both;" id="dtl-area">
				<h3 class="text-title2">공공데이터메타 상세정보</h3>
				<form name="adminOpenInf" method="post" action="#">
					<input type="hidden" name="apiRes" /> <input type="hidden"
						name="sgrpCd" /> <input type="hidden" name="korYn" value="N" />
					<input type="hidden" name="engYn" value="N" /> <input
						type="hidden" name="korMobileYn" value="N" />
					<table class="list01" style="position: relative;">
						<caption>공공데이터목록리스트</caption>
						<colgroup>
							<col width="150" />
							<col width="" />
							<col width="150" />
							<col width="" />


						</colgroup>
						<tr>
							<th><label class=""><spring:message
										code="labal.infNm" /></label><span>*</span></th>
							<input type="hidden" name="seq" />
							<input type="hidden" name="existinfId" />
							<td colspan="2"><input type="text" name="infId" value=""
								placeholder="ID 자동생성" readonly size="50" /> <input type="text"
								name="infNm" style="width: 30%" placeholder="입력하세요."
								maxlength="160" /></td>


							<%-- <th><label class=""><spring:message
										code="labal.infNm" /></label> <span>*</span></th> --%>
							<td><input type="checkbox" name="fvtDataYn" id="fvtDataYn">
							<label for="fvtDataYn">추천(홈페이지 노출)</label></input> 
							<select id="fvtDataOrder" name="fvtDataOrder" style="width: 180px; display: none;">
									<!-- <option value="">추천안함</option> -->
									<c:forEach var="code" items="${codeMap.fvtDataOrder}"
										varStatus="status">
										<option value="${code.ditcCd}">${code.ditcNm}</option>
									</c:forEach>
							</select> <!-- <select id="fvtDataOrder" name="fvtDataOrder" style="width : 180px; display: none;">
							</select> --> <span class="icon-open1" style="display: none;"><label
									class=""> <spring:message code="labal.infStateY" /></span> <!-- 개방 -->
								<span class="icon-open2" style="display: none;"><label
									class=""><spring:message code="labal.infStateN" /></label></span> <!-- 미개방 -->
								<span class="icon-open3" style="display: none;"><label
									class=""><spring:message code="labal.infStateX" /></label></span> <!-- 개방불가 -->
								<span class="icon-open4" style="display: none;"><label
									class=""><spring:message code="labal.infStateC" /></label></span> <!-- 개방취소 -->
								<!-- (영) <input type="text" name="infNmEng"  style="width:30%;"   maxlength="160"/> -->
							</td>


						</tr>

						<tr>

							<th ><label class="">분류</label> <span>*</span></th>
							<td colspan="3"><input type="hidden" name="cateId" /> <input
								type="hidden" name="cateIdTop" /> <input type="text"
								name="cateNm" size="35" value="" readonly="readonly" />
								<button type="button" class="btn01" name="cateSearch">
									<spring:message code="btn.search" />
								</button></td>
							<%-- <th><label class="">분류(옵션)</th>
							<td><input type="hidden" name="cateId2" /> 
							<input	type="text" name="cateNm2" size="35" value=""
								readonly="readonly" />
								<button type="button" class="btn01" name="cateSearch2">
									<spring:message code="btn.search" />
								</button>
								<button type="button" class="btn01" name="cateReset">
									<spring:message code="btn.init" />
								</button></td>
							</td> --%>
						</tr>
						<tr>
							<th><label class=""><spring:message code="labal.dt" /></label>
								<span>*</span></th>
							<td><input type="hidden" name="dtId" /> <input type="text"
								name="dtNm" size="35" value="" readonly="readonly" />
								<button type="button" class="btn01" name="dtSearch">
									<spring:message code="btn.search" />
								</button></td>
							<th><label class=""><spring:message
										code="labal.dataSet" /></label></th>
							<td><input type="text" name="dsId" size="35"
								readonly="readonly" />
								<button type="button" class="btn01" name="dsSearch">
									<spring:message code="btn.search" />
								</button>
								<button type="button" class="btn01" name="cateReset2">
									<spring:message code="btn.init" />
								</button>
								<button type="button" class="btn01L" name="dsInfo">
									<label class=""><spring:message
											code="labal.dataSetInfo" /></label>
								</button></td>
						</tr>
						<tr>
							<th><label class=""><spring:message
										code="labal.openCd" /></label> <span>*</span></th>
							<td><select name="openCd">
									<option value=""><spring:message
											code="labal.allSelect" /></option>
									<c:forEach var="code" items="${codeMap.openCd}"
										varStatus="status">
										<option value="${code.ditcCd}">${code.ditcNm}</option>
									</c:forEach>
							</select></td>

							<th><label class="">미(부분)개방사유</label></th>
							<td><select name="causeCd">
									<option value=""><spring:message
											code="labal.allSelect" /></option>
									<c:forEach var="code" items="${codeMap.causeCd}"
										varStatus="status">
										<option value="${code.ditcCd}">${code.ditcNm}</option>
									</c:forEach>
							</select><input type="text" name="causeInfo" size="50"
								placeholder="부분개방 및 개방불가 시 사유를 작성하세요." maxlength="660" /></td>

						</tr>
						<tr>
							<th><label class=""><spring:message
										code="labal.loadCd" /></label> <span>*</span></th>
							<td><select name="loadCd">
									<option value=""><spring:message
											code="labal.allSelect" /></option>
									<c:forEach var="code" items="${codeMap.loadCd}"
										varStatus="status">
										<option value="${code.ditcCd}">${code.ditcNm}</option>
									</c:forEach>
							</select></td>

							<th><label class=""><spring:message
										code="labal.cclCd" /></label> <span>*</span></th>
							<td><select name="cclCd">
									<option value=""><spring:message code="labal.whole" /></option>
									<c:forEach var="code" items="${codeMap.cclCd}"
										varStatus="status">
										<option value="${code.ditcCd}">${code.ditcNm}</option>
									</c:forEach>
							</select>
							<!-- <input type="hidden" name="useDeptNm"
								style="width: 30%" maxlength="160" /> <select name="aprvProcYn"
								style="width: 180px; display: none;">
									<option value="">선택</option>
									<option value="Y">승인이 필요한 자료</option>
									<option value="N">승인이 필요없는 자료</option>
							</select> -->
							</td>

						</tr>
						<tr>

						</tr>
						<tr>

						</tr>
						<%-- <tr>
							<th><label class=""><spring:message
										code="labal.infTag" /></label></th>
							<td> <!-- (영) <input type="text" name="infTagEng" style="width:35%;" maxlength="160"/> -->
								<span>(각 태그명은 콤마로 태그를 구분합니다.)</span></td>

							<th><label class=""><spring:message
										code="labal.openDttm" /></label> <input type="hidden" name="dataCondDttm" size="50"  /><span>*</span></th>
							<td></td>
							
							

						</tr> --%>


						<!-- 데이터 기준일자, 제공 부서명 -->

						<%-- <tr>
						
							<th><label class=""><spring:message
										code="labal.dataCondDttm" /></label> </th>
							<td></td>
								
								<th><label class=""><spring:message
										code="labal.useDeptNm" /></label> </th>
							<td>
							</td>
							
						</tr> --%>

						<!-- 데이터 기준일자, 제공 부서명 끝 -->

						<%-- <tr>
							<th><label class=""><spring:message
											code="labal.aprvProcYn"/>
							<td></td>
    						
    				    </tr> --%>
						<tr>
							<th><label class=""><spring:message
										code="labal.infExp" /></label></th>
							<td colspan="3" class="pd"><textarea name="infExp"
									placeholder="1000자 이내로 입력하세요." style="width: 45%;" rows="5"></textarea>
								<!-- (영) <textarea name="infExpEng"   style="width:45%;" rows="5"></textarea> -->
							</td>
						</tr>
						<tr>
							<th><label class=""><spring:message
										code="labal.infTag" /></label></th>
							<td colspan="3" class="pd"><input type="text" name="infTag"
								style="width: 60%;" placeholder="검색태그는 콤마(,)로 구분합니다."
								maxlength="160" /> <!-- (영) <input type="text" name="infTagEng" style="width:35%;" maxlength="160"/> -->
							</td>
						</tr>
						<tr>
							<th><label class=""><spring:message
										code="labal.dataCondDttm" /></label></th>
							<td><input type="text"
								name="dataCondDttm" placeholder="최종 데이터의 기준정보를 표시할 경우 입력하세요."
								size="50" /></td>
							
							<th><spring:message code="labal.useYn"/></th>
							<td>
								<input type="radio" name="useYn"  value="Y" checked="checked"/>
								<label for="use"><spring:message code="labal.yes"/></label>
								<input type="radio" name="useYn" value="N"/>
								<label for="unuse"><spring:message code="labal.no"/></label>
							</td>
						</tr>

					</table>

					<h3 class="text-title2" name="tblOpenH3">공공데이터 개방</h3>
					<table class="list01" name="tblOpenTable" style="position: relative;">
						<colgroup>
							<col width="150" />
							<col width="" />
							<col width="150" />
							<col width="" />
						</colgroup>

						<tr>
							<th>서비스정보</th>
							<td colspan="3" class="serviceYn">
								<!-- <span class="icon-no-service" name="T"><a href="#" >tsSheet</a></span>  -->
								<span class="icon-no-service" name="S"><a href="#">Sheet</a></span>
								<span class="icon-no-service" name="C"><a href="#">Chart</a></span>
								<span class="icon-no-service" name="M"><a href="#">Map</a></span>
								<span class="icon-no-service" name="L"><a href="#">Link</a></span>
								<span class="icon-no-service" name="F"><a href="#">File</a></span>
								<span class="icon-no-service" name="A"><a href="#">Open API</a></span>
								<span class="icon-no-service" name="V"><a href="#">Visual</a></span>
							</td>
						</tr>
						<tr>
							<th><input type="hidden" name="infState" value="" />
							<label class=""><spring:message code="labal.openDttm" /></label><span>*</span></th>
							<td  colspan="3"><input type="text" name="openDttm" size="35" value="" readonly="readonly" />
							<%-- <select name="infState">
									<option value="" selected="selected"><spring:message code="labal.infStateA" /></option>
									<option value="N"><spring:message
											code="labal.infStateN" /></option>
									<option value="Y"><spring:message
											code="labal.infStateY" /></option>
									<option value="C"><spring:message
											code="labal.infStateC" /></option>
									<option value="X"><spring:message code="labal.infStateX" /></option>
							</select> --%>
							<span style="float: right">
								${sessionScope.button.a_infState}
								${sessionScope.button.a_infStateCancel}
								</span>
							</td>
						</tr>
					</table>

					<!-- ibsheet 영역 -->
					<div style="width: 100%; float: left;">
						<div class="ibsheet-header">
							<h3 class="text-title2">담당자 정보</h3>
							<div class = "header-right-btn">
								<button type="button" class="btn01" name="orgAdd" style="float: right">
									<spring:message code="btn.add" />
								</button>
							</div>
						</div>
						<div style="clear: both;"></div>
						<div class="ibsheet_area_both">
							<script type="text/javascript">createIBSheet("mySheet2", "100%", "200px"); </script>
						</div>
					</div>
					<%-- <!-- ibsheet 영역 -->
				<div  style="width: 40%; float: right;">
					<div class="ibsheet-header">            
		          		<h3 class="text-title2">직원정보</h3>
		          		<button type="button" class="btn01" name="empAdd" style="float:right"><spring:message code="btn.add"/></button>
		          	</div>
					<div class="ibsheet_area" style="clear: both;">
						<script type="text/javascript">createIBSheet("mySheet3", "100%", "200px"); </script>             
					</div> 
				</div> --%>
					<div class="buttons">
						<%-- ${sessionScope.button.a_import} --%>
						${sessionScope.button.a_init} ${sessionScope.button.a_reg}
						${sessionScope.button.a_modify}
					    ${sessionScope.button.a_del}

						<%-- ${sessionScope.button.a_view} --%>
					</div>

					<!----------------------------------- IMG 처리 태그는 나중에........ 해제하면 이용 가능..... ------------------------------------>
					<%-- <form name="adminImgForm" method="post" action="#" enctype="multipart/form-data">
						<input type="hidden" name="initFlag"/>
						<input type="hidden" name="mstSeq" value=0 />    
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
									<span id="fileImgDiv" style="display:inline-block;">
									<span id="fileImgInfo">신규등록할 경우 초기화 버튼을 눌러서 등록해주세요</span>
									${sessionScope.button.btn_init}
									</span>
									<button type="button" class="btn01" title="초기화" name="btn_init">초기화</button>
								<!-- <input type="text" name="viewFileNm" size="80" value="" /> (확장자제외) -->
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
						<div class="buttons">
							${sessionScope.button.a_reg} 
							${sessionScope.button.a_modify}     
							${sessionScope.button.a_del}  
						</div>
						</form> --%>

				</form>






			</div>






		</div>
	</div>
</body>
<!--##  푸터  ##-->
<c:import url="/WEB-INF/jsp/admin/adminfooter.jsp" />
<!--##  /푸터  ##-->
</html>