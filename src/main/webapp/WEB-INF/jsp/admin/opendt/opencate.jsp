<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="egovframework.common.WiseOpenConfig"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><spring:message code='wiseopen.title'/></title>
<c:import  url="/WEB-INF/jsp/inc/headinclude.jsp"/>
</head>    
<script language="javascript">              
$(document).ready(function()    {     
	$("input[name=sysLang]").val("KOR");
	$("input:radio[name=sysLangRadio]").eq(0).prop("checked",true);
	setMainButton(); //메인 버튼
	LoadPage();//메인 sheet
	doAction('search');//메인 바로조회
	buttonEventAdd();
	Btn_Set();
	
	inputEnterKey();//엔터키 적용
	//tabSet();// tab 셋팅
});

function Btn_Set() { //버튼 초기화 함수
	   
	
	   $("a[name=a_reg]").show();
	   $("a[name=a_reset]").show();
	   
	   $("a[name=a_modify]").eq(1).hide();
	   $("a[name=a_del]").hide();
	   
}

function setMainButton(){
	var formObj = $("form[name=adminOpenCateMain]");
	formObj.find("button[name=btn_inquiry]").click(function(e) { //조회
		doAction("search");
		 return false;
	 });
	formObj.find("button[name=btn_reg]").click(function(e) { //등록
		doAction("reg");
		 return false;
	 });
	formObj.find("a[name=a_modify]").click(function(e) { //수정 : 순서변경저장
		doAction("modify");
		 return false;
	 });
	formObj.find("a[name=a_up]").click(function(e) { //위로이동
		doAction("moveUp");
		 return false;
	 });
	formObj.find("a[name=a_down]").click(function(e) { //아래로이동
		doAction("moveDown");
		 return false;
	 });
	
	$("input:checkbox[id=obj_open]").prop("checked", true);
	
	$("#obj_open").change(function(e) { // 항목 펼치기
		if(inputCheckYn("obj_open") =="Y"){
			mySheet.ShowTreeLevel(-1);
		}else{
			mySheet.ShowTreeLevel(0, 1);
		}
	 });
	
	var sysLang = formObj.find("input:radio[name=sysLangRadio]"); 
	sysLang.each(function(index,item){			// sysLang라디오버튼의 길이만큼 each를 실행
		sysLang.eq(index).click(function(){		// sysLang라디오버튼중에서 선택한것만
			sysLang.each(function(index2,item){	// 다시sysLang라디오버튼의 길이만큼 each를 실행
					sysLang.eq(index2).prop("checked",false);	// 일단 sysLang라디오버튼의 checked를 모두 false시킴
 			});
		sysLang.eq(index).prop("checked",true);	// 선택된 sysLang라디오버튼만 다시 checked를 true시킴
		formObj.find("input[name=sysLang]").val(sysLang.eq(index).val());
		// 선택된 sysLang라디오버튼의 value값을 sysLang inputBox에다가 넣어줌
		});
	});
	
	
}

function LoadPage()                
{
	//message-common_ko_KR.properties 선언 후 사용 or message-common_en_US.properties 선언 후 사용
	var gridTitle ="NO";
		gridTitle +="|"+"<spring:message code='labal.status'/>";
		gridTitle +="|"+"<spring:message code='labal.cateId'/>";
		gridTitle +="|"+"<spring:message code='labal.cateNm'/>";
		gridTitle +="|"+"<spring:message code='labal.cateNm'/>";
		gridTitle +="|"+"<spring:message code='labal.cateNmEng'/>";
		gridTitle +="|"+"<spring:message code='labal.vOrder'/>";
		gridTitle +="|"+"<spring:message code='labal.cateNm'/>";
		gridTitle +="|"+"<spring:message code='labal.cateNm'/>";
		gridTitle +="|"+"<spring:message code='labal.cateNm'/>";
/* 		gridTitle +="|"+"<spring:message code='labal.ditcNm'/>"; */
		gridTitle +="|"+"<spring:message code='labal.useYn'/>";
		gridTitle +="|"+"<spring:message code='labal.cateId'/>";
    with(mySheet){
    	                     
    	var cfg = {SearchMode:2,Page:50,VScrollMode:1,ChildPage:10};
        SetConfig(cfg);
        var headers = [
                    {Text:gridTitle, Align:"Center"}
                ];
        var headerInfo = {Sort:0,ColMove:1,ColResize:1,HeaderCheck:0};
        
        InitHeaders(headers, headerInfo);
       
        //문자는 왼쪽정렬
        //숫자는 오른쪽정렬
        //코드값은 가운데정렬
        var cols = [
                     {Type:"Seq",		SaveName:"seq",				Width:30,	Align:"Center",		Edit:false}
                    ,{Type:"Status",	SaveName:"status",			Width:50,	Align:"Center",		Hidden:false, Hidden:true	}
					,{Type:"Text",		SaveName:"cateId",			Width:60,	Align:"Center",		Edit:false}
					,{Type:"Text",		SaveName:"cateNm",			Width:300,	Align:"Left",		Edit:false, TreeCol:1}
					,{Type:"Text",		SaveName:"cateCib",			Width:50,	Align:"Left",		Edit:false, Hidden:true	}
					,{Type:"Text",		SaveName:"cateNmEng",		Width:300,	Align:"Left",		Edit:false, Hidden:true	}
					,{Type:"Text",		SaveName:"vOrder",			Width:50,	Align:"Left",		Edit:false, Hidden:true	}
					,{Type:"Text",		SaveName:"cateLvl",			Width:50,	Align:"Left",		Edit:false, Hidden:true	}
					,{Type:"Text",		SaveName:"cateIdPar",		Width:50,	Align:"Left",		Edit:false, Hidden:true	}
					,{Type:"Text",		SaveName:"cateIdTop",		Width:50,	Align:"Left",		Edit:false, Hidden:true	}
					,{Type:"CheckBox",	SaveName:"useYn",			Width:50,	Align:"Center",		Edit:false, TrueValue:"Y", FalseValue:"N", KeyField:false}
					,{Type:"Text",		SaveName:"cateIdCheck",		Width:50,	Align:"Center",		Edit:true, Hidden:true	}
                ];                                          
        InitColumns(cols);
        FitColWidth();
        SetExtendLastCol(0);
        SetColProperty("niaId", ${codeMap.niaId} );    //InitColumns 이후에 셋팅
    }               
    default_sheet(mySheet);                                         
    mySheet.SetCountPosition(0);          	
}         
/*Sheet 각종 처리*/
function doAction(sAction)                                  
{
	var classObj = $("."+"content").eq(0); //tab으로 인하여 form이 다건임
	var actObj = setTabForm(classObj); // 0: form data, 1: form 객체
	switch(sAction)                  
	{                       
		case "search":      //조회   
			var formObj = $("form[name=adminOpenCateMain]");
			ajaxBeforeSendAdmin("<c:url value='/admin/ajaxBeforeSendAdmin.do'/>"); //IbSheet 조회전 세션 체크
			var param = {PageParam: "ibpage", Param: "onepagerow=50&"+actObj[0]};
			mySheet.DoSearchPaging("<c:url value='/admin/opendt/openCateListAllMainTree.do'/>", param);
			break;          
		case "reg":      //등록화면        
			var title = "분류항목 등록"
			var id ="cateRegTab";
		    openTab.addRegTab(id,title,tabCallRegBack); // 탭 추가 시작함
		    break;     
		case "modify":      // 수정 : 순서변경저장
			if ( !confirm("수정 하시겠습니까? ") ) {
				return;
  			}
			ibsSaveJson = mySheet.GetSaveJson(0);                                          
			if(ibsSaveJson.data.length == 0) {
				alert("저장할 데이터가 없습니다.");  
				return;
			}
			var url = "<c:url value='/admin/opendt/openCateOrderBySave.do'/>";
			IBSpostJson(url, param, ibscallback);
			break;
		case "moveUp":  
			gridTreeMoveUp(mySheet,"cateLvl","vOrder","Y");
			break;                 
		case "moveDown":              
			gridTreeMoveDown(mySheet,"cateLvl","vOrder","Y");
			break;
	}           
}       

function doActionTab(sAction)                                  
{
	var classObj = $("."+"content").eq(1); //tab으로 인하여 form이 다건임
	var actObj = setTabForm(classObj); // 0: form data, 1: form 객체
	//var objTab = getTabShowObj();//탭이 oepn된 객체가져옴
	var formObj = classObj.find("form[name=adminOpenCateOne]");
	switch(sAction)                                           
	{                        
		case "reg":      //등록
			if(validateOne(formObj)){
				return;
			}
			var url = "<c:url value='/admin/opendt/openCateReg.do'/>"; 
			ajaxCallAdmin(url,actObj[0],saveCallBack);
			location.reload();
		    break;       
		case "modify":      //수정
			if ( !confirm("수정 하시겠습니까? ") ) {
				return;
  			}
			if(validateOne(formObj)){            
				return;
			}
			var url = "<c:url value='/admin/opendt/openCateUpd.do'/>"; 
			ajaxCallAdmin(url,actObj[0],saveCallBack);
			location.reload();
			break;
		case "delete":      //삭제
			if ( !confirm("삭제 하시겠습니까? ") ) {
				return;
  			}
			if(validateOneDel(formObj)){
				return;
			}
// 			alert(formObj.find('input[name=cateCib]').val());
			var url = "<c:url value='/admin/opendt/openCateDel.do'/>"; 
			ajaxCallAdmin(url,actObj[0],deleteCallBack);
			location.reload();
			break;       
		case "dup":   		// 중복 
			
			if(nullCheckValdation(formObj.find('input[name=cateId]'),"<spring:message code='labal.cateId'/>","")){
				return true;
			}
			var url = "<c:url value='/admin/opendt/openCateCheckDup.do'/>"; 
			ajaxCallAdmin(url,actObj[0],dupCallBack);
			break;
		case "par_del":   		// 상위분류 초기화 
			formObj.find('input[name=cateIdPar]').val(null);
			formObj.find('input[name=cateNmPar]').val(null);
			break;
		case "popclose":                      
			closeIframePop("iframePopUp");
			break;
		case "popdt1":			// 상위분류 선택 팝업     
			/* var iframeNm ="iframePopUp";
			var wWidth ="660";                                                    
			var wHeight ="530"                         
			var url = "<c:url value='/admin/opendt/openCateParListPopUp.do'/>";
			openIframePop(iframeNm,url,wWidth,wHeight);//ifrmNm, url,width,height
			break; */   	//iframe 팝업 사용시                  
			var cataTopId = inputRadioVal("sysLangRadio");                    
			var url = "<c:url value="/admin/opendt/openCateParListPopUp.do"/>" + "?cateGb=1&cateIdTop="+cataTopId;
			var popup = OpenWindow(url,"openCateParListPopUp","700","550","yes");	
			popup.focus();
			break;
		case "popdt2":       	// 표준맵핑 선택 팝업
			/* var iframeNm ="iframePopUp";
			var wWidth ="660";                                                                              
			var wHeight ="530"                         
			var url = "<c:url value='/admin/opendt/commCodeListPopUp.do'/>";
			openIframePop(iframeNm,url,wWidth,wHeight);//ifrmNm, url,width,height
			break; */	//iframe 팝업 사용시
			var url = "<c:url value="/admin/opendt/commCodeListPopUp.do"/>" + "?ditcGb=1";
			var popup = OpenWindow(url,"commCodeListPopUp","600","550","yes");
			popup.focus();
			break;
		case "init":
			
			formObj.find("input[name=cateId]").val("");
			formObj.find("input[name=cateId]").removeAttr("readonly","readonly"); 
			formObj.find("input[name=cateNm]").val("");
	/* 		formObj.find("input[name=ditcNm]").val(""); */
			formObj.find("input[name=cateNmPar]").val("");
			formObj.find("input[name=useYn]").val("");
			formObj.find("button[name=btn_dup]").show();
			formObj.find("span[name=dup]").show();
			
			Btn_Set();
			
			break;
	}
}

function doActionImg(sAction){
	
	var classObj = $("."+'content').eq(1); //tab으로 인하여 form이 다건임
	var actObj = setTabForm2(classObj,"adminOpenCateOne"); // 0: form data, 1: form 객체
	var sheetObj; //IbSheet 객체         
	var param = actObj[0]  ;  
	var objTab = getTabShowObj();//탭이 oepn된 객체가져옴
	var formObj = classObj.find("form[name=adminOpenCateOne]");
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
			var url = "<c:url value='/admin/opendt/saveBbsFile.do'/>";                
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
// 				alert(param);
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
			var url = "<c:url value='/admin/opendt/deleteImgDtl.do'/>"; 
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
	
	var formObj = classObj.find("form[name=adminOpenCateOne]");
	
	
	var url = "<c:url value='/admin/opendt/bbsImgDetailView.do'/>";
	param = formObj.serialize();
	ajaxCall(url, param, bbsDtlCallBack);       
	
}

function bbsDtlCallBack(tab, json, res){
	
	var classObj = $("."+'content').eq(1); //tab으로 인하여 form이 다건임
	var formObj = classObj.find("form[name=adminOpenCateOne]");
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
			append += "<p><img src=\"<c:url value='/admin/opendt/fileDownload.do?"+param+"'/>\" alt='"+tab.resultImg[i].viewFileNm+"' width='120' height='120'/></p>";
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
	var formObj = classObj.find("form[name=adminOpenCateOne]");

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
	var formObj = classObj.find("form[name=adminOpenCateOne]");
	var url = "<c:url value='/admin/opendt/bbsImgDetailView.do'/>";
	param = formObj.serialize();
	ajaxCall(url, param, bbsDtlCallBack);  
}

function imgDeleteCallBack2(res){
	var classObj = $("."+'content').eq(1); //tab으로 인하여 form이 다건임
	var formObj = classObj.find("form[name=adminOpenCateOne]");
	var url = "<c:url value='/admin/opendt/bbsImgDetailView.do'/>";
	param = formObj.serialize();
	ajaxCall(url, param, bbsDtlCallBack);  
}

function inputEnterKey(){
	var formObj = $("form[name=adminOpenCateMain]");
	formObj.find("input[name=serVal]").keypress(function(e) {                   
		  if(e.which == 13) {
			  doAction('search');   
			  return false; 
		  }
	});
}

function tabSet(){ //탭 객체 생성  
	openTab = new OpenTab(tabId,tabContentClass,tabBody); //headinclude.jsp 변수 있음
	openTab.TabObj = openTab;  
	openTab.addTabClickEvent();            
}

function setCateId(row){
	mySheet.SetCellValue(row,"cateId",mySheet.GetCellValue(row,"cateIdCheck"));//키값
}

function OnSaveEnd(){
	doAction("search");                 
}

function tabFunction(){//tab callback에서 사용함
	var row = $("input[name=ibSheetRow]").val();
	var cateId = mySheet.GetCellValue(row,"cateId");
	var cateNm = mySheet.GetCellValue(row,"cateNm");
	//var ditcNm = mySheet.GetCellValue(row,"ditcNm");
	/* var ditcNm = mySheet.GetCellValue(row,"niaId"); */
	var cateIdPar = mySheet.GetCellValue(row,"cateIdPar");
	
	var classObj = $('.'+'content').eq(1);
	//var objTab = getTabShowObj();//탭이 oepn된 객체가져옴
	var formObj = classObj.find("form[name=adminOpenCateOne]");
	formObj.find("button[name=btn_dup]").hide();    
	
	formObj.find("input[name=cateId]").val(cateId);                                         
	formObj.find("input[name=cateId]").attr("readonly","readonly"); 
	
	formObj.find("input[name=cateNm]").val(cateNm);
	
	
/* 	formObj.find("input[name=ditcNm]").val(ditcNm); */
	
	
	formObj.find("input[name=cateNmPar]").val(cateIdPar);
	formObj.find("input[name=cateNmPar]").attr("readonly","readonly");
	
// 	buttonEventAdd();
	//formObj.find("input[name=useYn]").attr("disabled","disabled");       // 사용여부는 수정할 수 없음                 
}                      

function mySheet_OnSearchEnd(code, msg)
{
    if(msg != "")
	{
	    alert(msg);
    }else{
    	if(inputCheckYn("obj_open") =="Y"){
			mySheet.ShowTreeLevel(-1);
		}else{
			mySheet.ShowTreeLevel(0, 1);
		}
    }
}

function mySheet_OnDblClick(row, col, value, cellx, celly) {
	
	$("a[name=a_reg]").hide();
	$("a[name=a_reset]").show();
	   
	$("a[name=a_modify]").eq(1).show();
	$("a[name=a_del]").show();
	$("span[name=dup]").hide();
	
	
	var seq = mySheet.GetCellValue(mySheet.GetSelectRow(),"seq");
	$("input[name=ibSheetRow]").val(seq);        
	 //   tabEvent(seq);
	 
	var url = "<c:url value='/admin/opendt/OpenCateOne.do'/>";

 	var param = "seq= " + mySheet.GetCellValue(seq,"seq");
 	
 	
 	ajaxBeforeSendAdmin("<c:url value='/admin/ajaxBeforeSendAdmin.do'/>"); //IbSheet 조회전 세션 체크
 	ajaxCallAdmin(url, param, tabFunction);
	 
	var classObj = $("."+'content').eq(1); //tab으로 인하여 form이 다건임
	
	var formObj = classObj.find("form[name=adminOpenCateOne]");
	
	
	var url = "<c:url value='/admin/opendt/bbsImgDetailView.do'/>";
	param = formObj.serialize();
	ajaxCall(url, param, bbsDtlCallBack);
} 
	
function tabEvent(row){//탭 이벤트 실행  
	var seq = mySheet.GetCellValue(mySheet.GetSelectRow(),"seq");                    
	var title = mySheet.GetCellValue(seq,"cateNm");//탭 제목
	var id = mySheet.GetCellValue(seq,"seq");//탭 id(유일한key))
    openTab.SetTabData(mySheet.GetRowJson(seq));//db data 조회시 조건 data
    var url = "<c:url value='/admin/opendt/OpenCateOne.do'/>"; // Controller 호출 url 
    openTab.addTab(id,title,url,tabCallBack); // 탭 추가 시작함
	var objTab = getTabShowObj();//탭이 oepn된 객체가져옴
	/* var cib = mySheet.GetCellValue(seq,"cateCib"); // 하위분류 존재여부
	if(cib == "Y"){	//하위분류가 존재하면 subTreeList 실행
		var cateid = mySheet.GetCellValue(seq,"cateId");
		LoadPage2();
		getSubTree(cateid);
	} */
}                   

function buttonEventAdd(){ //버튼 이벤트 사라짐 overring하여 버튼 이벤트 추가사용
	setTabButton();                                  
}                
//* 반드시 setTabButton() 메소드 사용해야함*//
// 탭 callback에서 사용하고 있음//
function setTabButton(){ 
	var classObj = $("."+"content").eq(1); //tab으로 인하여 form이 다건임 
	//var objTab = getTabShowObj();//탭이 oepn된 객체가져옴
	var formObj = classObj.find("form[name=adminOpenCateOne]");
	var formObjImg = classObj.find("form[name=adminImgForm]");
	
	
	formObj.find("a[name=a_reg]").click(function(e) { //등록
		doActionTab("reg");
		return false;
	 });
	formObj.find("a[name=a_modify]").click(function(e) { //수정
		doActionTab("modify");
		 return false;
	 });
	formObj.find("a[name=a_del]").click(function(e) { //삭제
		doActionTab("delete");
		 return false;
	 });
	formObj.find("button[name=btn_dup]").click(function(e) { //중복
		doActionTab("dup");        
		 return false;
	 });
	formObj.find("button[name=par_del]").click(function(e) { //상위분류삭제
		doActionTab("par_del");
		 return false;
	 });
	formObj.find("button[name=btn_search]").eq(0).click(function(e) { // 상위분류 검색
		doActionTab("popdt1");
		 return false;
	 });
	formObj.find("button[name=btn_search]").eq(1).click(function(e) { // 표준맵핑 검색
		doActionTab("popdt2");
		 return false;
	 });
	
	formObj.find("a[name=a_init]").click(function() {
		doActionTab("init"); 
 		return false;                 
 	});
	
	formObj.find("input[name=cateId]").keyup(function(e) {
		ComInputEngNumObj(formObj.find("input[name=cateId]"));
		formObj.find("input[name=cateIdDup]").val("N");   
		 return false;
	 });      
	formObj.find("input[name=cateNm]").keyup(function(e) {
		ComInputKorObj(formObj.find("input[name=cateNm]"));
		 return false;
	 });
	
	formObj.find("input[name=cateNmEng]").keyup(function(e) {
		ComInputEngBlankObj(formObj.find("input[name=cateNmEng]"));
		 return false;
	 });
	
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

function dupCallBack(res){
	var objTab = getTabShowObj();//탭이 oepn된 객체가져옴
	var formObj = objTab.find("form[name=adminOpenCateOne]");
	if(res.RESULT.CODE == -1){
		alert("중복된 분류항목이 존재합니다.");
		formObj.find("input[name=cateIdDup]").val("N");
	}else{                           
		alert("등록 가능합니다.");
		formObj.find("input[name=cateIdDup]").val("Y");
	}
}  

function validateOne(formObj){
	if(nullCheckValdation(formObj.find('input[name=cateId]'),"<spring:message code='labal.cateId'/>","")){
		return true;
	}
	if(nullCheckValdation(formObj.find('input[name=cateNm]'),"<spring:message code='labal.cateNm'/>","")){
		return true;
	}
	if(nullCheckValdation(formObj.find('input[name=cateNmEng]'),"<spring:message code='labal.cateNmEng'/>","")){
		return true;
	}
/* 	if(nullCheckValdation(formObj.find('input[name=ditcNm]'),"<spring:message code='labal.ditcNm'/>","")){
		return true;
	} */
	if(formObj.find('input[name=cateId]').attr("readonly") != "readonly"){
		if(formObj.find('input[name=cateIdDup]').val() == "N"){
			alert("중복체크 버튼을 클릭해주세요.")
			return true;
		}
	}
	
		if(formObj.find('input[name=cateId]').val() == formObj.find('input[name=cateIdPar]').val()){
			alert("분류ID와 상위분류가 동일합니다");
			return true;
		}
	
		if(formObj.find('input[name=cateCib]').val() == "Y"){
			var msg = "하위분류가 존재합니다. 변경하시겠습니까?";
			if(!confirm(msg)){
				return true;
		}
			if($("radio[id=unuse]:checked").val() == "N"){
				var msg = "미사용 처리시 하위 분류도 동시에 미사용 처리 됩니다. 저장하시겠습니까?";
				if(!confirm(msg)){
					return true;
				}
			}
	}
	return false;                               
}

function validateOneDel(formObj){
		if(formObj.find('input[name=cateCib]').val() == "Y"){
			alert("하위 항목이 존재합니다. 삭제할 수 없습니다.")
			return true;
	}
	return false;                               
}
</script>              
</head>
<body onload="">
<div class="wrap">            
		<c:import  url="/admin/admintop.do"/>   
		<!-- 내용 -->
		<div class="container">
			<!-- 상단 타이틀 -->   
			<div class="title">             
				<h2>${MENU_NM}</h2>                                      
				<p>${MENU_URL}</p>             
			</div>
			
			<!-- 탭 -->
			
			<div class="more_list" style="display:none">
				<a href="#" class="more">0</a>                                        
				<ul class="other_list" style="display:none;">
					<li><a href="#">보유데이터목록</a><a href="#" class="line_close">x</a></li>
					<li><a href="#">공공데이터목록</a><a href="#" class="line_close">x</a></li>
				</ul>
			</div>
			
	

						
			<!-- 리스트(트리) -->   
			<div class="content">
				<form name="adminOpenCateMain"  method="post" action="#">
				<input type="hidden" name="ibSheetRow" value=""/>     
				<input type="hidden" name="sysLang" value=""/>        
				<table class="list01">
					<caption>보유데이터목록리스트</caption>
					<colgroup>
						<col width="150"/>
						<col width=""/>
					</colgroup>
					
					<tr>
						<th><spring:message code='labal.search'/></th>             
							<td>
								<select name="serSel">	
									<option value="ALL"><spring:message code='etc.select'/></option>
									<option value="ID"><spring:message code='labal.cateId'/></option>
									<option value="NM" selected="selected"><spring:message code='labal.cateNm'/></option>
									
									<input type="text" name="serVal" value="" maxlength="50" style="width: 300px"/>
								</select> 
								${sessionScope.button.btn_inquiry}
								
							</td>
					</tr>
					<tr>
						<th><spring:message code='labal.useYn'/></th>
						<td>
							<input type="radio" name="useYn" id="useall"  value=""/>
							<label for="useall"><spring:message code="labal.whole"/></label>
							<input type="radio" name="useYn" id="use" value="Y" checked="checked"/>
							<label for="use"><spring:message code='labal.yes'/></label>
							<input type="radio" name="useYn" id="unuse" value="N"/>
							<label for="unuse"><spring:message code='labal.no'/></label>
							&nbsp;&nbsp;&nbsp;
						<input type="checkbox" id="obj_open"  name="obj_open"/>
						<label for="obj_open">항목 펼치기</label>
						</td>
					</tr>
				</table>		
				
				
						<script type="text/javascript">createIBSheet("mySheet", "100%", "300px"); </script>             
					<div class="buttons" style="margin-right:15px;">
						${sessionScope.button.a_up}
						${sessionScope.button.a_down}
						${sessionScope.button.a_modify}
					</div>
				</form>               	
			</div>
			
					<!-- 분류관리 상세 내용 전체 DIV-->
			<div class="content">
				<form name="adminOpenCateOne"  method="post" action="#" enctype="multipart/form-data">
				<input type="hidden" name="cateIdPar" value=""/>
				<input type="hidden" name="niaId" value=""/>
				<input type="hidden" name="cateLvl" value=""/>
				<input type="hidden" name="cateCib" value=""/>
				<input type="hidden" name="cateIdTop" value=""/>
				<input type="hidden" name="cateIdDup" value="N"/>
				<input type="hidden" name="vOrder" value=""/>
				
				<table class="list01">
					<caption>보유데이터목록리스트</caption>
					<colgroup>
						<col width="150"/>
						<col width=""/>
					</colgroup>
					<tr>
						<th><spring:message code='labal.cateId'/><span>*</span></th>
						<td>
							<input type="text" value="" name="cateId" maxlength="8" style="width: 150px;"/>
							${sessionScope.button.btn_dup}
							<span name="dup">공백없이 영문자와 숫자로만 입력하세요. (10자이내)</span>
						</td>
					</tr>         
					<tr>
						<th><spring:message code='labal.cateNm'/> <span>*</span></th>
						<td>
							<input type="text" value=""  name="cateNm" maxlength="250"  style="width: 344px;"/>
							
						</td>
					</tr>        
					<tr>
						<th><spring:message code='labal.cateIdPar'/></th>
						<td>
							<input type="text" name="cateNmPar" value="" class="readonly" readonly sizemaxlength="6" style="width: 200px;"/>
							${sessionScope.button.btn_search}
							<span>선택하지 않으면 최상위 분류로 등록됩니다.</span>
							${sessionScope.button.par_del}
							<!-- <span>상위초기화는 선택된 상위분류를 초기화합니다.</span> -->
						</td>
					</tr>
					<%-- <tr>                 
						<th><spring:message code='labal.ditcNm'/> <span>*</span></th>
						<td>
							<input type="text" name="ditcNm" value="" class="readonly" readonly maxlength="6"  style="width: 200px;"/>  
							${sessionScope.button.btn_search}
							<span>안전행정부 표준 분류코드를 선택하세요.</span>
							
						</td>
					</tr> --%>
					<tr>         
						<th><spring:message code='labal.useYn'/> </th>
						<td>
							<input type="radio" name="useYn" id="use" checked="checked" value="Y"/>
							<label for="use"><spring:message code='labal.yes'/></label>
							<input type="radio" name="useYn" id="unuse" value="N"/>
							<label for="unuse"><spring:message code='labal.no'/></label>                                  
						</td>                             
					</tr>
				</table>	
				<div class="buttons">
					     ${sessionScope.button.a_init}
						${sessionScope.button.a_reg}     
						${sessionScope.button.a_modify}     
						${sessionScope.button.a_del}                       
				</div>
				</form>  
				
				<form name="adminImgForm" method="post" action="#" enctype="multipart/form-data">
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
<%-- 									${sessionScope.button.btn_init} --%>
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
						</form>
				
				
						
						
						<%-- <div class="buttons">
							${sessionScope.button.a_reg} 
							${sessionScope.button.a_modify}     
							${sessionScope.button.a_del}  
						</div> --%>
							
						
		<%-- 				</c:when>
					</c:choose>	
			</c:if>             --%>  
				 
				      <!-- 상세 페이지 우측 트리 구조 -->       
	             <!-- <div style="width:35%;float:right;">
					<div style="border:1px solid #c0cbd4;padding:10px;">
							<script type="text/javascript">createIBSheet("mySheet2", "100%", "300px"); </script>
						</div>        
				</div> -->	
			
			
			
			</div>
		</div>		
	<c:import  url="/WEB-INF/jsp/inc/iframepopup.jsp"/>
	<!--##  푸터  ##-->                                       
	<c:import  url="/WEB-INF/jsp/admin/adminfooter.jsp"/>                                   
	<!--##  /푸터  ##-->            
</body>
</html>