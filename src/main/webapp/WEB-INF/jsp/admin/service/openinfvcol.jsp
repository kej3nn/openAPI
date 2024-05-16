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
//<![CDATA[ 
           
function isValidURL(url) {
	var RegExp = /(ftp|http|https):\/\/(\w+:{0,1}\w*@)?(\S+)(:[0-9]+)?(\/\/([\w#!:.?+=%@!\-\/]))?/;
	return RegExp.test(url);
}
           
function setVcol(SSheet){   
	
	var srvYn = false;
	var objTab = getTabShowObj();//탭이 oepn된 객체가져옴
	var formObj = objTab.find("form[name=adminOpenInfVcol]");
	
	formObj.find("a[name=a_init]").click(function(e) { //초기화버튼
		doActionVcol('init');                 
		return false;                 
	});                 
	formObj.find("a[name=a_add]").click(function(e) { //추가
		doActionVcol('add');                 
		return false;                 
	});                 
	formObj.find("a[name=a_modify]").click(function(e) { //수정
		doActionVcol('add');                 
		return false;                 
	});                 
	formObj.find("a[name=a_reg]").click(function(e) { //등록
		doActionVcol('reg');                 
		return false;                 
	});                 
	formObj.find("a[name=a_save]").click(function(e) {
		doActionVcol('save');                 
		return false;                 
	});      
	formObj.find("a[name=a_up]").click(function(e) { //위로
		doActionVcol('moveUp');                 
		return false;                 
	}); 
	formObj.find("a[name=a_down]").click(function(e) { //아래로
		doActionVcol('moveDown');                 
		return false;                 
	}); 
	formObj.find("a[name=a_view]").click(function(e) { //미리보기
		doActionVcol('view');                 
		return false;                            
	})
	formObj.find("button[name=btn_dup]").click(function(e) { //미리보기
		doActionVcol('dup');                 
		return false;                            
	});
	
	formObj.find(':radio[name="srvYn"]').click(function(e) {    	//서비스여부 변경시 이전value와 비교 
		if ( $(this).val() != formObj.find("input[name=beforeSrvYn]").val() ) {
			formObj.find("input[name=dataModified]").val("Y");
		} else {
			formObj.find("input[name=dataModified]").val("");
		}
 	})
	
	formObj.find("input[name=vistnExp]").keyup(function(e) {			//URL명 한글만     
		ComInputKorObj(formObj.find("input[name=vistnExp]"));   
 		return false;                                                                          
 	});
	 
	if(formObj.find(':radio[name="srvYn"]:checked').val() !=undefined){
		formObj.find("a[name=a_reg]").hide();
		formObj.find("a[name='a_init']").hide();
		formObj.find("a[name='a_modify']").hide();
		srvYn = true;                 
	}else{              
		formObj.find("a[name=a_add]").hide();          
		formObj.find("a[name=a_up]").hide();          
		formObj.find("a[name=a_down]").hide();       
		formObj.find("a[name=a_save]").hide();
		formObj.find("a[name=a_view]").hide();
		formObj.find("a[name='a_init']").hide();
		formObj.find("a[name='a_modify']").hide();
		formObj.find("div[name=imgDiv]").hide();
	}
	
	if(formObj.find("input[name=SSheetNm]").val() ==""){
		formObj.find("input[name=SSheetNm]").val(SSheet);    
	}              
	formObj.find("input[name=srvCd]").val("V");        
	setLabal(formObj,"V"); //라벨 이름 중복됨(id 변경))
	
	formObj.find("input[name=beforeSrvYn]").val(formObj.find(':radio[name="srvYn"]:checked').val());	//저장한내역 확인하기위해
	
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
			window[sheet].FitColWidth("7|7|12|15|25|13");
		}		                                                 
		return false;                                                                                               
	}); 
	if(formObj.find(':radio[name="srvYn"]:checked').val() !=undefined){
		doActionVcol("init");
	}
	return srvYn;
} 

function initVcol(sheetName,Vcol){
	 var srvYn  = setVcol(Vcol);   
	 if(srvYn){
		 LoadPageVcol(sheetName);
		 setTabButton_Vcol();
	 }         
}

function LoadPageVcol(sheetName)                
{                               
	var gridTitle = "<spring:message code='labal.status'/>";  
		gridTitle += "|NO"       
		gridTitle +="|"+"<spring:message code='labal.infId'/>";           
		gridTitle +="|"+"<spring:message code='labal.infSeq'/>";   
		gridTitle +="|"+"시각화URL";   
		gridTitle +="|"+"시각화URL명";   
		gridTitle +="|"+"제작자명";   
		gridTitle +="|"+"시각화유형명";   
		gridTitle +="|"+"<spring:message code='labal.useYn'/>";  		
		gridTitle +="|"+"순서";  		
		gridTitle +="|"+"링크seq";  		
		gridTitle +="|"+"썸네일이미지파일";;
	
    with(sheetName){
    	                     
    	var cfg = {SearchMode:2,Page:50};                                        
        SetConfig(cfg);  
        var headers = [                                                                   
                    {Text:gridTitle, Align:"Center"}                          
                ];
        var headerInfo = {Sort:0,ColMove:1,ColResize:1,HeaderCheck:1};         
                        
        InitHeaders(headers, headerInfo); 
                 
        var cols = [          
				 {Type:"Status",		SaveName:"status",		Width:30,	Align:"Center",		Edit:false}               
				,{Type:"Seq",			SaveName:"seq",			Width:10,	Align:"Right",		Edit:false, Hidden:true}
				,{Type:"Text",			SaveName:"infId",		Width:30,	Align:"Right",		Edit:false, Hidden:true}
				,{Type:"Int",			SaveName:"infSeq",		Width:30,	Align:"Right",		Edit:false,	Hidden:true}
				,{Type:"Text",			SaveName:"vistnUrl",		Width:100,	Align:"Left",		Edit:false}
				,{Type:"Text",			SaveName:"vistnExp",		Width:50,	Align:"Left",		Edit:false}
				,{Type:"Text",			SaveName:"prdNm",		Width:50,	Align:"Left",		Edit:false}
				,{Type:"Text",			SaveName:"vistnTyNm",		Width:50,	Align:"Left",		Edit:false}
				,{Type:"CheckBox",		SaveName:"useYn",		Width:50,	Align:"Center",		Edit:false, TrueValue:"Y", FalseValue:"N"}
				,{Type:"Text",			SaveName:"vOrder",		Width:30,	Align:"Right",		Edit:false,	Hidden:true}
				,{Type:"Text",			SaveName:"vistnSeq",		Width:30,	Align:"Right",		Edit:false, Hidden:true}
				,{Type:"Text",			SaveName:"tmnlImgFile",	Width:30,	Align:"Right",		Edit:false, Hidden:true}
               ];                                                      
               
        InitColumns(cols);     
        SetExtendLastCol(1);  
        sheetName.FitColWidth("10|50|30|10");
    }                   
    default_sheet(sheetName);              
    doActionVcol("search");
}


function doActionVcol(sAction)                                  
{
 	var classObj = $("."+tabContentClass); //tab으로 인하여 form이 다건임
 	var actObj = setTabForm2(classObj,"adminOpenInfVcol"); // 0: form data, 1: form 객체
 	var sheetObj; //IbSheet 객체         
 	var param = actObj[0]  ;  
 	var objTab = getTabShowObj();//탭이 oepn된 객체가져옴
 	
 	var formObj = objTab.find("form[name=adminOpenInfVcol]");
 	sheetObj =formObj.find("input[name=SSheetNm]").val();    
 	//ajaxBeforeSendAdmin("<c:url value='/admin/ajaxBeforeSendAdmin.do'/>"); //IbSheet 조회전 세션 체크
 	var gridObj = window[sheetObj];
 	switch(sAction)                    
 	{          
 		case "init":			//초기화 
	 		fncInit2_Vcol(formObj);
 			break;
 		case "search":      //조회    
 			gridObj.DoSearch("<c:url value='/admin/service/openInfVcolList.do'/>", param); 
 			break;
 		case "add" :
 			if ( !vColCheck(formObj) ) {
 				return;
 			}
 			if ( !isValidURL(formObj.find("input[name=vistnUrl]").val()) ) {
 				alert("URL 형식이 아닙니다.");
 				return;
 			}
 			
 			if(formObj.find("input[name=vistnSeq]").val() == 0 ){
 				formObj.find("input[name=vistnSeq]").val(gridObj.RowCount()+1);	
 				formObj.find("input[name=vOrder]").val(gridObj.RowCount()+1);
 			}
 			
 			if ( formObj.find("input[name=initFlag]").val() == "" ) { 
				alert("초기화 버튼을 눌러주세요.");		return;
			}
 			
 			formObj.find("input[name=useYn]").val("Y");
 			
 			var seq = gridObj.RowCount();
 			var seq2 = gridObj.GetSelectRow();
			var imgLen = formObj.find(".img-box").length;
 						
			
			if(imgLen > 1){
				alert("썸네일 이미지는 1개만 등록 가능합니다."); 
				return false
			}
			if (formObj.find("input[id=file]").val() == "" ) {
				formObj.find("input[id=saveFileNm]").val("");
			} else {
				var srcFileNm = formObj.find("input[id=saveFileNm]").val();
				var fileExt = getFileExt(formObj.find("input[id=saveFileNm]").val());
				
				if(fileExt.toLowerCase() != "jpg" && fileExt.toLowerCase() != "jpeg" && fileExt.toLowerCase() != "gif" && fileExt.toLowerCase() != "png"){
					alert("이미지 파일[jpg/jpeg, gif, png]만 첨부가능 합니다.");
			        return false;
				}
			}
			

 			ibsSaveJson = formObj.serialize(); 
 			ibsSaveJson += "&srcFileNm="+srcFileNm+"&fileExt="+fileExt+"&status=I";
			var url = "<c:url value='/admin/service/openInfVcolImgSave.do'/>";                
			IBSpostJsonFile(formObj,url, fileSaveCallBack2_Vcol);
			
 			break;
 		case "reg":      //등록
 			if(formObj.find(':radio[name="srvYn"]:checked').val() ==undefined){
 				alert("서비스 여부를 선택해 주세요");
 				return;
 			}
 			var url ="<c:url value='/admin/service/openInfColReg.do'/>";
 			ajaxCallAdmin(url, param,colVcallback);
 			LoadPageVcol(gridObj);
 			setTabButton_Vcol();
 			formObj.find("a[name=a_reg]").hide();
 			formObj.find("a[name=a_add]").show();        
 			formObj.find("a[name=a_up]").show();        
			formObj.find("a[name=a_down]").show();
 			formObj.find("a[name=a_save]").show();
 			formObj.find("a[name=a_view]").show();
 			formObj.find("div[name=imgDiv]").show();
 			fncInit2_Vcol(formObj);
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
 			if(ibsSaveJson. data.length == 0) {
 				var url = "<c:url value='/admin/service/openInfColReg.do'/>";
 				ajaxCallAdmin(url, actObj[0],colcallback);
 				doActionVcol("search");	
 				return;
 			} else {
 				var url = "<c:url value='/admin/service/openInfVcolSave.do'/>";
 	 			IBSpostJson(url, actObj[0], colcallback);      
 	 			doActionVcol("search");	
 			} 
 			break;                    
 		case "view":   
 			var infId = formObj.find("input[name=infId]").val();                  
 			var srvCd = formObj.find("input[name=srvCd]").val();
 			var target = "<c:url value='/admin/service/openInfColViewPopUp.do?infId="+infId+"&srvCd="+srvCd+"'/>";
 			var wName = "Vcolview";        
 			var wWidth = "1100";
 			var wHeight = "560";                                       
 			var wScroll ="no";    
 			OpenWindow(target, wName, wWidth, wHeight, wScroll);
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

// 입력/수정 validation
function vColCheck(obj) {
	var rtnVal = false;
	
	if(nullCheckValdation(obj.find('input[name=vistnUrl]'),"URL","")){
		rtnVal = false;		return;
	}
	if(nullCheckValdation(obj.find('input[name=vistnExp]'),"URL명","")){
		rtnVal = false;		return;
	}
	
	return true;
 }



// 클릭시
function vColClick(gridObj, Row, Col) {
	var objTab = getTabShowObj();//탭이 oepn된 객체가져옴
	var formObj = objTab.find("form[name=adminOpenInfVcol]");
	formObj.find("input[name=vistnUrl]").val(gridObj.GetCellValue(Row, "vistnUrl"));
	formObj.find("input[name=vistnExp]").val(gridObj.GetCellValue(Row, "vistnExp"));
	formObj.find("input[name=prdNm]").val(gridObj.GetCellValue(Row, "prdNm"));
	formObj.find("input[name=vistnTyNm]").val(gridObj.GetCellValue(Row, "vistnTyNm"));
	
	
	initImg_Vcol();
}

function vColValidation(gridObj, Row, Col, Value) {
	if ( Col == 4 | Col == 5 | Col == 6 ) {
		if ( gridObj.GetCellValue(Row, Col) == "" ) {
			alert("값을 입력해 주세요.");
			gridObj.validateFail(1);
			gridObj.SetSelectCell(Row, Col);
			return;
		}
		if ( !isValidURL(gridObj.GetCellValue(Row, 4)) ) {
			alert("URL 형식이 아닙니다.");
			gridObj.validateFail(1);
			gridObj.SetSelectCell(Row, Col);
			return;
		}
		
	}
}

function colVcallback(res){ 
    var result = res.RESULT.CODE;
    if(result == 0) {
    	alert(res.RESULT.MESSAGE);                  
    } else {         
    	alert(res.RESULT.MESSAGE);
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


//--------------------------------------------------- 이미지 관련 javascript Start ---------------------------------------------------------
function bbsDtlCallBack_Vcol(tab, json, res){
	var objTab = getTabShowObj();		//탭이 oepn된 객체가져옴
	var formImgObj = objTab.find("form[name=adminOpenInfVcol]");
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
			var param = "downCd=V&fileSeq="+tab.resultImg[i].vistnSeq+"&seq="+tab.resultImg[i].mstSeq+"&etc="+tab.resultImg[i].infId;
			append += "<div class='img-box'>";
			append += "<p><input type='hidden' name='delUse' value='"+delUse+"' /></p>";
			append += "<p><img src=\"<c:url value='/admin/service/fileDownload.do?"+param+"'/>\" alt='"+tab.resultImg[i].tmnlImgFile+"' width='120' height='120'/></p>";
			append += "<p><input type='checkbox' name='del_yn' id='del"+i+"' value='"+tab.resultImg[i].vistnSeq+"' onclick=\"javascript:checkDel_Vcol('"+delUse+"', '"+tab.resultImg[i].vistnSeq+"', '"+tab.resultImg[i].mstSeq+"');\" /> <label for='del"+i+"'>삭제</label></p>";
			append += "</div> ";
			
			//formImgObj.find("span[id=fileImgDiv]").append(tab.resultImg[i].tmnlImgFile);
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
	var formImgObj = objTab.find("form[name=adminOpenInfVcol]");
	
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
	// 추가버튼 생성
	formObj.find("a[name='a_add']").show();
	
	// 수정,초기화버튼 감춤
	formObj.find("a[name='a_modify']").hide();
	formObj.find("a[name='a_init']").hide();
	
	//값 초기화
	formObj.find("input[name=initFlag]").val("Y");		//초기화하였음.
	formObj.find("input[name=vistnSeq]").val(0);
	formObj.find("input[name=vistnUrl]").val("http://");
	formObj.find("input[name=vistnExp]").val("");
	formObj.find("input[name=prdNm]").val("");
	formObj.find("input[name=vistnTyNm]").val("");
	formObj.find(".appendImg div").remove();						//이미지미리보기 제거
	//현재파일객체 숨김
	formObj.find("input[id=saveFileNm]").remove();
	formObj.find("input[id=file]").remove();
	//빈 파일객체 현재 순서ID로 추가..
	appendFile += "<input type='text' name='fileStatus' id='fileStatus' value='C' style='display:none;' readonly/>";
			appendFile += "<input type='text' name='saveFileNm' id='saveFileNm' width:200px;' value='' style=\"display: none;\" readonly>";
			appendFile += "<input type='file' name='file' id='file' onchange='fncFileChange2_Vcol();' width:80px; color:#fff'/>";
	formObj.find("span[id=fileImgDiv]").find("span[id=fileImgInfo]").remove();	// 문구 삭제
	formObj.find("span[id=fileImgDiv]").append(appendFile);
}

//파일선택시
function fncFileChange2_Vcol() {
	var objTab = getTabShowObj();
	var formObj = objTab.find("form[name=adminOpenInfVcol]");
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
 	
 	/* formImgObj.find("button[name=btn_add]").click(function(){		//이미지 추가
		doActionImg_Vcol("add");  
		return false;		
	}); */
 	
}


// 시트 더블클릭시
function initImg_Vcol() {
	var objTab = getTabShowObj();//탭이 oepn된 객체가져옴
	var formObj = objTab.find("form[name=adminOpenInfVcol]");
	var sheetObj =formObj.find("input[name=SSheetNm]").val();
 	var gridObj = window[sheetObj];
 	var objTabDiv = getTabShowObjForm("srvColDiv");//탭이 oepn된 div객체가져옴
 	
 	formObj.find("a[name='a_init']").show();
 	formObj.find("a[name='a_modify']").show();
 	formObj.find("a[name='a_add']").hide();
 	
 	
	
 	
	
	var Row = gridObj.GetSelectRow();
	if(Row < 0) return;					//선택한 행이 없을 경우
	if(gridObj.GetCellValue(Row, "status")!="R") return;		//시트 데이터가 조회 데이터 가아닌경우
	
 	//썸네일 등록 DIV SHOW
 	objTab.find("div[name='imgDiv']").show();
 	
 	
	formObj.find("input[name='tmnlImgFile']").val(gridObj.GetCellValue(Row, "tmnlImgFile"));				//이미지파일명
	formObj.find("input[name='vistnSeq']").val(gridObj.GetCellValue(Row, "vistnSeq"));					//링크SEQ
	formObj.find("input[name='vOrder']").val(gridObj.GetCellValue(Row, "vOrder"));						//순서
	formObj.find("input[name='infId']").val(formObj.find("input[name='infId']").val());					//INF_ID
	formObj.find("input[name='infSeq']").val(formObj.find("input[name='infSeq']").val());				//INF_SEQ
	formObj.find("input[name='mstSeq']").val(formObj.find("input[name='mstSeq']").val());				//MST_SEQ
	formObj.find("input[name='srvCd']").val(formObj.find("input[name='srvCd']").val());	
	
	if(formObj.find("input[name='tmnlImgFile']").val() == "") {
		formObj.find(".appendImg div").remove();
	} else {	 	
		var url = "<c:url value='/admin/service/openInfVcolImgDetailView.do'/>";
		param = formObj.serialize();
		ajaxCall(url, param, bbsDtlCallBack_Vcol);
	 } 
}

//--------------------------------------------------- 이미지 관련 javascript End ---------------------------------------------------------

</script> 
<div name="srvColDiv" style="display:none">  
<form name="adminOpenInfVcol"  method="post" action="#" enctype="multipart/form-data">
			<input type="hidden" name="infId">                          
			<input type="hidden" name="infSeq" value=0>                          
			<input type="hidden" name="mstSeq" value=0>                          
			<input type="hidden" name="SSheetNm">
			<input type="hidden" name="srvCd" value="">                   
			<input type="hidden" name="beforeSrvYn" value="">                   
			<input type="hidden" name="dataModified">
			<input type="hidden" name="vistnSeq" value=0 />
			<input type="hidden" name="tmnlImgFile" />
			<input type="hidden" name="initFlag" value=""/>
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
			<input type="hidden" name="prssAccCd">     
			<input type="hidden" name="vOrder" value=0 />     
			<input type="hidden" name="useYn"  />     
			          
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
						${sessionScope.button.btn_metaDtl}
					</td>         
				</tr>
				<tr>
					<th><spring:message code='labal.srvYn'/></th>                 
					<td>
						<input type="radio" value="Y" id="Ause" name="srvYn"/>
						<label for="Ause"><spring:message code='labal.yes'/></label>  
						<input type="radio" value="N" id="Aunuse" name="srvYn"/>
						<label for="Aunuse"><spring:message code='labal.no'/></label>
					</td>
				</tr>
			</table>
			
			<div name="imgDiv">  
			<h3 class="text-title2">시각화</h3>
			<table class="list01">
				<caption>공공데이터링크</caption>
				<colgroup>
					<col width="150"/>
					<col width=""/>
				</colgroup>			    
				<tr>   
					<th>시각화URL</th>                             
					<td> 
						<input type="text" name="vistnUrl" style="width:500px" value="http://" maxlength="160"/>
					</td>
				</tr>
				<tr>   
					<th>
						시각화URL명<br/>(300자 이내)
					</th>                             
					<td> 
						<input type="text" name="vistnExp" value="" style="width:600px"  maxlength="330"/>
					</td>
				</tr>
				 <tr>   
					<th>제작자명</th>                             
					<td> 
						<input type="text" name="prdNm" value="" style="width:600px"  maxlength="330"/>
					</td>
				</tr>
				<tr>   
					<th>시각화유형명</th>                             
					<td> 
						<input type="text" name="vistnTyNm" value="" style="width:600px"  maxlength="330"/>
					</td>
				</tr>
			</table>
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
			</div>
			<div class="buttons">
				${sessionScope.button.a_modify}
				${sessionScope.button.a_init}  
				${sessionScope.button.a_add}    
			</div>	
			
			<!-- ibsheet 영역 -->
			<div class="ibsheet_area" name="Vcol">               
			</div>
			
			<div class="buttons">
				${sessionScope.button.a_up}       
				${sessionScope.button.a_down}           
				${sessionScope.button.a_reg}       
				<%-- ${sessionScope.button.a_save}       --%>
				<a href="javascript:;" class="btn03" title="저장" name="a_save">저장</a> 
				${sessionScope.button.a_view}       
			</div>	
				
</form> 
<div>
<br/>
</div>

</div>  