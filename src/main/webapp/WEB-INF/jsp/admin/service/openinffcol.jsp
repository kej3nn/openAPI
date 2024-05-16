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
<validator:javascript formName="adminOpenInfFcol" staticJavascript="false" xhtml="true" cdata="false"/>  
    
<script language="javascript">                
//<![CDATA[ 
$(document).ready(function()    { 
});

/* 
 * ProgressBar.js - Progress bar에 대한 정의
 * 호환성 : IE7, IE8, 파이어폭스3.0.4, 크롬 에서 정상동작
 *          Opera 브라우저에서는 onbeforeunload 이벤트 미지원으로 동작하지 않음(오류 발생은 없음)
 */

// var progressbar = new Object();
// progressbar.enable = true; // 사용여부
// progressbar.image = "../../img/ggportal/desktop/common/progress.png"; // 사용할 이미지 파일

// /* Progress Bar 함수 */
// function Progressbar() {
//     if (progressbar.enable) {
//         $("#imgProgressbar").modal({
//             overlayCss: { "background-color": "#000", "cursor": "wait" },
//             containerCss: { "background-color": "#fff", "border": "0px solid #ccc" },
//             close: false,
//             closeHTML: ''
//         });
//     } else {
//     	$("#imgProgressbar").hide();
//         $.modal.close();
//     }
// }

// $(function(){
//     // 크롬과 사파리에서 beforeunload 이벤트가 실행되는 동안
//     // 동적으로 생성된 img 엘리먼트가가 정상적으로 로딩되지 않아 미리 img 엘리먼트를 생성한다. 
//     $("body").append('<img id ="imgProgressbar" src="' + progressbar.image + '" alt="progressbar" />');

//      $("#imgProgressbar").hide();
//      $.modal.close();
    
//     // IE에서 애니메이션 gif가 멈춰있는 현상으로 인하여 setTimeout을 이용하여 Progressbar function 실행
//     $(window).bind("beforeunload", function(){  setTimeout("Progressbar()", 0);});
// });
           
function setFcol(SSheet){   
	var srvYn = false;
	var objTab = getTabShowObj();//탭이 oepn된 객체가져옴
	var formObj = objTab.find("form[name=adminOpenInfFcol]");
	var downFileFormObj = objTab.find("form[name=adminOpenInfFcolDownFileForm]");
	
	datepickerInitTab(formObj.find("input[name=ftCrDttm]"));
	datepickerInitTab(formObj.find("input[name=ltCrDttm]"));
	formObj.find("input[name=ftCrDttm]").datepicker(setCalendarView('yy-mm-dd'));           
	formObj.find("input[name=ltCrDttm]").datepicker(setCalendarView('yy-mm-dd'));      
	datepickerTrigger();  
	var append = "";
	append += "<div>";  
	if (formObj.find("input[name=tmnlImgFile]").val() != "") {
		formObj.find("input[name=uploadTmnlfile]").hide();
		var tmnlImgFile = formObj.find("input[name=tmnlImgFile]").val();
		var infId = formObj.find("input[name=infId]").val();
		var param = "downCd=F&fileSeq=1&seq=1&etc="+infId;
		append += "<div class='img-box'>";
		append += "<p><img src=\"<c:url value='/admin/service/fileDownload.do?"+param+"'/>\" alt='"+tmnlImgFile+"' width='120' height='120'/></p>";
		append += "</div> ";
	} else{
		formObj.find("button[name=btn_init]").eq(0).hide();
		formObj.find(".appendImg div").remove();
	}
	append += "</div>";
	formObj.find(".appendImg").append(append);
	
	formObj.find("button[name=btn_add]").click(function(e) { //추가
		doActionFcol('add');                 
		return false;                 
	});                 
	formObj.find("a[name=a_reg]").click(function(e) { //등록
		doActionFcol('reg');                 
		return false;                 
	});                 
	formObj.find("a[name=a_save]").click(function(e) {	//저장
		doActionFcol('save');                 
		return false;                 
	}); 
	formObj.find("a[name=a_del]").click(function(e) {	//저장
		doActionFcol('del');                 
		return false;                 
	});
	formObj.find("a[name=a_view]").click(function(e) { //미리보기
		doActionFcol('view');                 
		return false;                            
	});
	formObj.find("button[name=btn_init]").eq(0).click(function(e) {				//썸네일초기화
		doActionFcol('tmnlInit');
		return false; 
	});
	formObj.find("button[name=btn_init]").eq(1).click(function(e) {				//초기화
		doActionFcol('init');                 
		return false;                            
	});
	//데이터 수정시 해당 IBSheet 행에 입력
	formObj.find("input[name=viewFileNm]").change(function(e) {
		fnChangeVal("viewFileNm", formObj.find("input[name=viewFileNm]").val());	//element name, value
		return false;                            
	});
	formObj.find("input[name=wrtNm]").change(function(e) {
		fnChangeVal("wrtNm", formObj.find("input[name=wrtNm]").val());	//element name, value
		return false;                            
	});
	
	formObj.find("input[name=ftCrDttm]").change(function(e) {
		dateValCheck(formObj.find('input[name=ftCrDttm]'), formObj.find('input[name=ltCrDttm]'));// from , to 날짜 안맞을 경우 자동셋팅   
		fnChangeVal("ftCrDttm", formObj.find("input[name=ftCrDttm]").val());	//element name, value  
		return false;                            
	});
	formObj.find("input[name=ltCrDttm]").change(function(e) {
		dateValCheck(formObj.find('input[name=ftCrDttm]'), formObj.find('input[name=ltCrDttm]'));// from , to 날짜 안맞을 경우 자동셋팅   
		fnChangeVal("ltCrDttm", formObj.find("input[name=ltCrDttm]").val());	//element name, value 
		return false;                            
	});
	
	// 서비스구분 변경시
	formObj.find("select[name=sgrpCd]").bind("change", function(event) {
		formObj.find("input[name=dataModified]").val("Y");	
	});
	/* 150111 - 회계연도 추가하면서 사용안함
	formObj.find("select[name=fileCd]").change(function(e) {
		if ( formObj.find("input[name=initFlag]").val() == "N" & $(this).val() == "" ) {
			alert("항목을 선택해 주십시오.");
			return false;
		}
		fnChangeVal("fileCd", formObj.find("select[name=fileCd]").val());	//element name, value 
		fnChangeVal("fileCdNm", formObj.find("select[name=fileCd] option:selected").text());	//element name, value 
		return false;                            
	}); */
	
	
	//////////////////////////////////////////////////////////////////////////////////////////////////////
	
	formObj.find(':radio[name="srvYn"]').click(function(e) {    	//서비스여부 변경시 이전value와 비교 
		if ( $(this).val() != formObj.find("input[name=beforeSrvYn]").val()) {
			formObj.find("input[name=dataModified]").val("Y");
		} else {
			formObj.find("input[name=dataModified]").val("");
		}
 	});
	if(formObj.find(':radio[name="srvYn"]:checked').val() !=undefined){
		formObj.find("a[name=a_reg]").hide();
		srvYn = true;                 
	}else{              
		formObj.find("button[name=btn_init]").hide();          
		formObj.find("button[name=btn_add]").hide();          
		formObj.find("a[name=a_del]").hide();
		formObj.find("a[name=a_save]").hide();
		formObj.find("a[name=a_view]").hide();                  
	}
	formObj.find("input[name=linkExp]").keyup(function(e) {			//URL명 한글만     
		ComInputKorObj(formObj.find("input[name=linkExp]"));   
 		return false;                                                                          
 	});
	formObj.find("input[name=linkExpEng]").keyup(function(e) {		//URL명(영문) 영문만     
		ComInputEngObj(formObj.find("input[name=linkExpEng]"));   
 		return false;                                                                          
 	});
	// 순서위로
	formObj.find("a[name=a_file_up]").bind("click", function(event) {
		doActionFcol("moveUp");
	});
	// 순서 아래로
	formObj.find("a[name=a_file_down]").bind("click", function(event) {
		doActionFcol("moveDown");
	});
	// 다운로드
	formObj.find("#fileDownDiv a").bind("click", function(event) {
		if ( com.wise.util.isNull(downFileFormObj.find("input[name=seq]").val())
			|| com.wise.util.isNull(downFileFormObj.find("input[name=seq]").val())	) {
			console.error("다운로드 파라미터 필수값 확인!");
			return;
		}
		downFileFormObj.submit();
	});
	
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
	formObj.find("input[name=srvCd]").val("F");        
	setLabal(formObj,"F"); //라벨 이름 중복됨(id 변경))
	formObj.find("input[name=initFlag]").val("N");    
	
	formObj.find("input[name=beforeSrvYn]").val(formObj.find(':radio[name="srvYn"]:checked').val());	//저장한내역 확인하기위해
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
		}else if(sheetSrvCd == "V"){  
			window[sheet].FitColWidth("7|7|12|15|25|13|13|8");
		}		                                                 
		return false;                                                                                               
	});
	 */
	return srvYn;
} 

function initFcol(sheetName,Fcol){
	 var srvYn  = setFcol(Fcol);   
	 if(srvYn){
		 LoadPageFcol(sheetName);
	 }         
}

function LoadPageFcol(sheetName)                
{                               
	var gridTitle = "<spring:message code='labal.status'/>";  
	    //gridTitle += "|NO"
	    gridTitle +="|"+"삭제";
		gridTitle +="|"+"<spring:message code='labal.infId'/>";           
		gridTitle +="|"+"<spring:message code='labal.infSeq'/>";   
		gridTitle +="|"+"파일고유번호";   
		//gridTitle +="|"+"파일종류코드";   
		//gridTitle +="|"+"파일종류";   
		gridTitle +="|"+"원본파일명";   
		gridTitle +="|"+"원본파일명(X)";  
		gridTitle +="|"+"저장파일명";   
		gridTitle +="|"+"출력파일명";  
		gridTitle +="|"+"출력파일명(X)";  
		gridTitle +="|"+"파일크기";   
		gridTitle +="|"+"파일확장자";   
		gridTitle +="|"+"작성자";   
		gridTitle +="|"+"최초생성일";   
		gridTitle +="|"+"최종수정일";   
		gridTitle +="|"+"<spring:message code='labal.useYn'/>";
		gridTitle +="|"+"순서";   
	
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
					//,{Type:"Seq",			SaveName:"seq",				Width:10,	Align:"Right",		Edit:false, Hidden:true} 
					,{Type:"Text",			SaveName:"infId",			Width:30,	Align:"Right",		Edit:false, Hidden:true}
					,{Type:"Text",			SaveName:"infSeq",			Width:30,	Align:"Right",		Edit:false,	Hidden:true}
					,{Type:"Text",			SaveName:"fileSeq",			Width:30,	Align:"Right",		Edit:false,	Hidden:true}
					/*
					,{Type:"Text",			SaveName:"fileCd",			Width:50,	Align:"Center",		Edit:false, Hidden:true}
					,{Type:"Text",			SaveName:"fileCdNm",		Width:50,	Align:"Center",		Edit:false, Hidden:true}*/
					,{Type:"Text",			SaveName:"srcFileNm",		Width:100,	Align:"Left",		Edit:false, Hidden:true}
					,{Type:"Text",			SaveName:"dpSrcFileNm",		Width:100,	Align:"Left",		Edit:false, Hidden:true}
					,{Type:"Text",			SaveName:"saveFileNm",		Width:100,	Align:"Left",		Edit:false}
					,{Type:"Text",			SaveName:"viewFileNm",		Width:100,	Align:"Left",		Edit:false}
					,{Type:"Text",			SaveName:"dpViewFileNm",		Width:100,	Align:"Left",		Edit:false, Hidden:true}
					,{Type:"Int",			SaveName:"fileSize",		Width:70,	Align:"Right",		Edit:false}
					,{Type:"Text",			SaveName:"fileExt",			Width:70,	Align:"Center",		Edit:false}
					,{Type:"Text",			SaveName:"wrtNm",			Width:70,	Align:"Center",		Edit:false}
					,{Type:"Text",			SaveName:"ftCrDttm",		Width:70,	Align:"Center",		Edit:false}
					,{Type:"Text",			SaveName:"ltCrDttm",		Width:70,	Align:"Center",		Edit:false} 
					,{Type:"CheckBox",		SaveName:"useYn",			Width:30,	Align:"Center",		Edit:true, TrueValue:"Y", FalseValue:"N"}
					,{Type:"Text",			SaveName:"vOrder",			Width:70,	Align:"Center",		Edit:false}
                ];                                                      
               
        InitColumns(cols);     
        SetExtendLastCol(1); 
        sheetName.FitColWidth("5|3|12|12|12|12|10|7|7|7|7|3");
        
         
    }                   
    default_sheet(sheetName);              
    doActionFcol("search");
    doActionFcol("search2");
    //doActionFcol("click");
}


function doActionFcol(sAction)                                  
{
 	var classObj = $("."+tabContentClass); //tab으로 인하여 form이 다건임
 	var actObj = setTabForm2(classObj,"adminOpenInfFcol"); // 0: form data, 1: form 객체
 	var sheetObj; //IbSheet 객체         
 	var param = actObj[0]  ;  
 	var objTab = getTabShowObj();//탭이 oepn된 객체가져옴
 	
 	var formObj = objTab.find("form[name=adminOpenInfFcol]");
 	sheetObj =formObj.find("input[name=SSheetNm]").val();    
 	//ajaxBeforeSendAdmin("<c:url value='/admin/ajaxBeforeSendAdmin.do'/>"); //IbSheet 조회전 세션 체크
 	var gridObj = window[sheetObj];
 	switch(sAction)                    
 	{          
	 	case "tmnlInit": 	// 썸네일 초기화
	 		formObj.find("input[name=uploadTmnlfile]").show();
	 		formObj.find("input[name=tmnlImgFile]").val("");
	 		formObj.find(".appendImg div").remove();
	 		formObj.find("button[name=btn_init]").eq(0).hide();
	 		break;
 		case "search":      //조회    
 			gridObj.DoSearch("<c:url value='/admin/service/openInfFcolList.do'/>", param); 
 			break;
 		case "search2":      //파일객체 생성하기 위한 조회   
 			ajaxCallAdmin("<c:url value='/admin/service/openInfFcolList2.do'/>", param, fileListCallBack);
 			break;
 		case "click":
 			fColClick(gridObj, 1, 3);
 			break;
 		case "init" : //초기화
 			fncInit(formObj, gridObj);
 			break;
 		case "add" :	//파일추가(grid에 입력)
 			if ( !fColCheck(formObj, gridObj) ) {
 				return;
 			}
 			fncFileAdd(formObj, gridObj);
 			break;
 		case "del" : 	//삭제
 			var cRow = gridObj.CheckedRows("delChk");
			if(cRow < 1){
				alert("삭제할 대상을 선택해주세요");
				return false;
			} else {
				if ( confirm("삭제 하시겠습니까?") ) {
					ibsSaveJson = gridObj.GetSaveJson({StdCol:1});    //선택된 행 삭제
		 			if(ibsSaveJson. data.length == 0) return;
		 			var url = "<c:url value='/admin/service/openInfFcolDel.do'/>";
		 			IBSpostJson(url, actObj[0], fileSaveCallBack);
				}
			}			
 			break;
 		case "reg":      //등록
 			if(formObj.find(':radio[name="srvYn"]:checked').val() ==undefined){
 				alert("서비스 여부를 선택해 주세요.");
 				return;
 			}
 			var url ="<c:url value='/admin/service/openInfColReg.do'/>";
 			
 			$(formObj).ajaxSubmit({
 		        beforeSubmit:function(data, form, options) {
 		            return true;
 		        },
 		        url:url,
 		        dataType:"json",
 		        success:colFcallback,
 		        error:function(request, status, error) {
 		        }
 		    });
 			
 			
// 			ajaxCallAdmin(url, param, colFcallback);
 			LoadPageFcol(gridObj);
 			formObj.find("a[name=a_reg]").hide();
 			formObj.find("button[name=btn_init]").show();
 			formObj.find("button[name=btn_add]").show();
 			formObj.find("a[name=a_save]").show();
 			formObj.find("a[name=a_view]").show();
 			break;
 		case "save":      //저장
 			var cRow = gridObj.CheckedRows("delChk");
			if(cRow >= 1){
				alert("삭제 체크를 해제 후 저장하시기 바랍니다.");
				return false;
			}
 			var dataModified = false;
 			if ( formObj.find("input[name=dataModified]").val() == "Y" ) {		//서비스여부 변경하였는지 체크
 				dataModified = true;
 			}
 			 if ( formObj.find("input[name=tmnlImgFile]").val() == "") {		//서비스여부 변경하였는지 체크
 				formObj.find("input[name=dataModified]").val("Y"); 
 				 dataModified = true;
 			}
 			
 			if ( !gridObj.IsDataModified() ) {
 				if ( !dataModified ) {
 					alert("저장할 내역이 없습니다.");
 					return;
 				}
 			}
 		
 			ibsSaveJson = gridObj.GetSaveString();
 			var url = "<c:url value='/admin/service/openInfFcolFileSave.do'/>";
 			//progressbar.enable = true; // 사용여부
 			//Progressbar();
			IBSpostJsonFile(formObj,url, fileSaveCallBack);
 			break;                    
 		case "view":   
 			var infId = formObj.find("input[name=infId]").val();                  
 			var srvCd = formObj.find("input[name=srvCd]").val();
 			//var seq = formObj.find("input[name=mstSeq]").val();
 			var target = "<c:url value='/admin/service/openInfColViewPopUp.do?infId="+infId+"&srvCd="+srvCd+"&popupUse=Y'/>";
 			var wName = "Fcolview";        
 			var wWidth = "1100";                       
 			var wHeight = "560";                                       
 			var wScroll ="no";    
 			OpenWindow(target, wName, wWidth, wHeight, wScroll);
 		case "reset" :
 			formObj.find("span[id=fileDiv]").html("");		//파일객체 초기화
 			formObj.find("input[name=initFlag]").val("N");	//초기화여부 플래그 변경
 			break;
 		case "getMstSeq" :	//신규 등록시 INF테이블의 SEQ 가져온다.
 			var url ="<c:url value='/admin/service/getMstSeq.do'/>";
 			ajaxCallAdmin(url, param, getMstSeqCallBack_F);
 			break;
 		case "getInfSeq" :	//신규 등록시 INF테이블의 SEQ 가져온다.
 	 		var url ="<c:url value='/admin/service/getInfSeq.do'/>";
 	 		ajaxCallAdmin(url, param, getInfSeqCallBack_F);
 	 		break;
 		case "moveUp":	//  순서 위로
			sheetDataMove(gridObj, "up");
			break;	
		case "moveDown":	// 순서 아래로
			sheetDataMove(gridObj, "down");
			break;
		case "saveOrder" :	// 순서 저장
			var params = "sheetData=" + encodeURIComponent(JSON.stringify(sheetObj.GetSaveJson().data));
			doAjax({
				url: "/admin/service/saveOpenInfFcolOrder.do",
				params: params,
				callback : function() {
					doActionFcol("search");
				}
			});
			break;	
 	}                           
}

//신규 등록시 INF의 SEQ를 가져온다(파일 업로드 위해)
function getMstSeqCallBack_F(res) {
	
	var objTab = getTabShowObj();//탭이 oepn된 객체가져옴
	var formObj = objTab.find("form[name=adminOpenInfFcol]");
	formObj.find("input[name=mstSeq]").val(res);
}

//신규 등록시 SERVICE의 SEQ를 가져온다(파일 업로드 위해)
function getInfSeqCallBack_F(res) {
	var objTab = getTabShowObj();//탭이 oepn된 객체가져옴
	var formObj = objTab.find("form[name=adminOpenInfFcol]");
	formObj.find("input[name=infSeq]").val(res);
}

//파일수정 콜백함수
function fileSaveCallBack(res) {
	//progressbar.enable = false; // 사용여부
	//Progressbar();
	var result = res.RESULT.CODE;
    if(result == 0) {
    	alert(res.RESULT.MESSAGE);
    } else {
    	alert(res.RESULT.MESSAGE);
    }   
    doActionFcol("search");		//조회
    doActionFcol("search2");	//파일타입 넣기위해 조회.
    doActionFcol("reset");		//초기화
}

// 입력/수정 validation
function fColCheck(obj, gridObj) {
	var rowCnt = gridObj.RowCount() + 1;
	var rtnVal = false;
	
	if ( obj.find("input[name=initFlag]").val() == "N" ) {
		alert("입력 초기화 후 추가해 주세요.");
		rtnVal = false;		return;
	}
	/* 150111 - 회계연도 사용하면서 사용 안함처리
	if(obj.find('select[name=fileCd]').val() == ""){
		alert("파일종류를 선택해 주세요.");
		rtnVal = false;		return;
	} */
	/* 필수값 아님
	if(obj.find('select[name=fsclYy]').val() == ""){
		alert("회계연도를 선택해 주세요.");
		rtnVal = false;		return;
	}
	*/
	if ( obj.find('input[id=file_'+rowCnt+']').val() == "" ) {
		alert("파일을 선택해 주세요.");
		rtnVal = false;		return;
	}
	if(nullCheckValdation(obj.find('input[name=viewFileEng]'),"출력파일명(영문)","")){
		rtnVal = false;		return;
	}
	if(nullCheckValdation(obj.find('input[name=ftCrDttm]'),"최초생성일","")){
		rtnVal = false;		return;
	}
	if(nullCheckValdation(obj.find('input[name=ltCrDttm]'),"최종수정일","")){
		rtnVal = false;		return;
	}
	if(nullCheckValdation(obj.find('input[name=viewFileNm]'),"출력파일명","")){
		rtnVal = false;		return;
	}
	if(nullCheckValdation(obj.find('input[name=viewFileEng]'),"출력파일명(영문)","")){
		rtnVal = false;		return;
	}
	
	return true;
 }


// 클릭시
var currRow = -1;
function fColClick(gridObj, Row, Col) {
	var objTab = getTabShowObj();//탭이 oepn된 객체가져옴
	var formObj = objTab.find("form[name=adminOpenInfFcol]");
	var downFileFormObj = objTab.find("form[name=adminOpenInfFcolDownFileForm]");
	var rowCnt = gridObj.RowCount();
	var addrowCnt = gridObj.RowCount() + 1;
	
	formObj.find("#fileStatus_"+addrowCnt).remove();
	formObj.find("#saveFileNm_"+addrowCnt).remove();
	formObj.find("#fileExt_"+addrowCnt).remove();
	formObj.find("#file_"+addrowCnt).remove();
	
	formObj.find("input[id=saveFileNm_"+Row+"]").val(gridObj.GetCellValue(Row, "saveFileNm"));
	formObj.find("input[name=viewFileNm]").val(gridObj.GetCellValue(Row, "viewFileNm"));
	formObj.find("input[name=ftCrDttm]").val(gridObj.GetCellValue(Row, "ftCrDttm"));
	formObj.find("input[name=ltCrDttm]").val(gridObj.GetCellValue(Row, "ltCrDttm"));
	formObj.find("input[name=wrtNm]").val(gridObj.GetCellValue(Row, "wrtNm"));

	// 파일 다운로드값 세팅
	formObj.find("#fileDownDiv a").text(gridObj.GetCellValue(Row, "viewFileNm"));
	downFileFormObj.find("input[name=seq]").val(formObj.find("input[name=mstSeq]").val());
	downFileFormObj.find("input[name=fileSeq]").val(gridObj.GetCellValue(Row, "fileSeq"));
	
	currRow = Row;
}

//ibSheet row 선택시 연결된 파일객체 보여줌  
function fileObjShowHide(formObj, Row, rowCnt){
	if ( rowCnt == 1 ) {
		formObj.find("input[id=saveFileNm_"+rowCnt+"]").show();	
		formObj.find("input[id=fileStatus_"+rowCnt+"]").show();	
		formObj.find("input[id=file_"+rowCnt+"]").show();
		return;
	}
	for ( var i=1; i <= rowCnt; i++ ) {
		if ( i == Row ) {
			formObj.find("input[id=saveFileNm_"+i+"]").show();		
			formObj.find("input[id=file_"+i+"]").show();
		} else {
			formObj.find("input[id=saveFileNm_"+i+"]").hide();	
			formObj.find("input[id=file_"+i+"]").hide();
		}
	}
}


//파일객체 동적 생성(미사용)
function fileListCallBack(tab, json, res) {
}

//파일선택시
function fncFileChange(fileId) {
	var objTab = getTabShowObj();
	var formObj = objTab.find("form[name=adminOpenInfFcol]");
	sheetObj =formObj.find("input[name=SSheetNm]").val();    
 	var gridObj = window[sheetObj];
 	
	val = formObj.find("input[id=file_"+fileId+"]").val().split("\\");
	fileName = val[val.length-1];
	f_name = fileName.substring(0, fileName.lastIndexOf("."));
	s_name = fileName.substring(fileName.lastIndexOf(".")+1, fileName.length);
	formObj.find("input[id=saveFileNm_"+fileId+"]").val(f_name);
	formObj.find("input[id=fileExt_"+fileId+"]").val(s_name);
	formObj.find("input[name=viewFileNm]").val(f_name);
	gridObj.SetCellValue(fileId, "srcFileNm", fileName);
	gridObj.SetCellValue(fileId, "viewFileNm", f_name);
	gridObj.SetCellValue(fileId, "fileExt", s_name);
}


//초기화 버튼 클릭시
function fncInit(formObj, gridObj) {
	var objTab = getTabShowObj();
	var downFileFormObj = objTab.find("form[name=adminOpenInfFcolDownFileForm]");
	var currRow = gridObj.GetSelectRow();
	this.currRow = -1;
	var rowCnt = gridObj.RowCount() + 1;
	var appendFile = "";
	if ( formObj.find("input[name=initFlag]").val() == "Y" ) {
		alert("이미 초기화 하였습니다.");		return;
	}
	//값 초기화
	formObj.find("input[name=viewFileNm]").val("");
	formObj.find("input[name=ftCrDttm]").val("");
	formObj.find("input[name=ltCrDttm]").val("");
	formObj.find("input[name=ltCrDttm]").val("");
	formObj.find("input[name=wrtNm]").val("");
	formObj.find("input[name=initFlag]").val("Y");		//초기화하였음.
	//빈 파일객체 현재 순서ID로 추가..
	appendFile += "<input type='hidden' name='fileStatus' id='fileStatus_" + rowCnt + "' value='C' style='display:none;' readonly/>";
	appendFile += "<input type='hidden' name='saveFileNm' id='saveFileNm_"+rowCnt+"' style='display:none; width:200px;' value='' readonly>";
	appendFile += "<input type='hidden' name='fileExt_' id='fileExt_"+rowCnt+"' style='display:none;' value='' readonly>";
	appendFile += "<input type='file' name='file' id='file_"+rowCnt+"' onchange='fncFileChange("+rowCnt+");' />";
	formObj.find("span[id=fileDiv]").append(appendFile);
	//파일객체 추가하고 보여준다
	formObj.find("input[id=saveFileNm_"+rowCnt+"]").show();
	formObj.find("input[id=file_"+rowCnt+"]").show(); 
	
	// 파일다운로드 영역 초기화
	formObj.find("#fileDownDiv a").text("").attr("href", "");
	downFileFormObj.find("input[name=seq], input[name=fileSeq]").val("");
}

//파일 추가시 grid에 입력 
function fncFileAdd(formObj, gridObj) {
	var newRow = gridObj.DataInsert(-1);
	gridObj.SetCellValue(newRow, "infId", formObj.find("input[name=infId]").val());	//순서 현재seq 카운팅
	gridObj.SetCellValue(newRow, "infSeq", formObj.find("input[name=infSeq]").val());	//순서 현재seq 카운팅
	//gridObj.SetCellValue(newRow, "fileCd", formObj.find("select[name=fileCd]").val());
	//gridObj.SetCellValue(newRow, "fileCdNm", formObj.find("select[name=fileCd] option:selected").text());
	gridObj.SetCellValue(newRow, "srcFileNm", formObj.find("input[id=saveFileNm_"+newRow+"]").val());
	gridObj.SetCellValue(newRow, "viewFileNm", formObj.find("input[name=viewFileNm]").val());
	gridObj.SetCellValue(newRow, "fileExt", formObj.find("input[id=fileExt_"+newRow+"]").val());
	gridObj.SetCellValue(newRow, "ftCrDttm", formObj.find("input[name=ftCrDttm]").val());
	gridObj.SetCellValue(newRow, "ltCrDttm", formObj.find("input[name=ltCrDttm]").val());
	gridObj.SetCellValue(newRow, "wrtNm", formObj.find("input[name=wrtNm]").val());
	gridObj.SetCellValue(newRow, "useYn", "Y");
	formObj.find("input[id=file_"+newRow+"]").hide();			//현재 파일숨김 
	formObj.find("input[id=saveFileNm_"+newRow+"]").hide();		//현재 파일숨김
	formObj.find("input[name=initFlag]").val("N");
	formObj.find("input[name=ftCrDttm]").val("");
	formObj.find("input[name=ltCrDttm]").val("");
	formObj.find("input[name=viewFileNm]").val("");
	formObj.find("input[name=wrtNm]").val("");
	//formObj.find("select[name=fileCd]").val("");
	//formObj.find("select[name=accYearCd]").val("");
}


function fColValidation(gridObj, Row, Col, Value) {
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
function fnChangeVal(name, val) {
	var objTab = getTabShowObj();
	var formObj = objTab.find("form[name=adminOpenInfFcol]");
	sheetObj =formObj.find("input[name=SSheetNm]").val();    
	var gridObj = window[sheetObj];
	if( currRow > -1 ) {	//currRow 최초 -1, Ibsheet 클릭시 Row위치 획득이므로 -1보다 클 경우만 셀 값 변경 
		gridObj.SetCellValue(currRow, name, val);
	}
	
}

function colFcallback(res){
    var result = res.RESULT.CODE;
    if(result > 0) {
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
    	doActionFcol("getMstSeq");
    	doActionFcol("getInfSeq");
    } else {                               
    	alert(res.RESULT.MESSAGE);                  
    }
}  




//]]>            
</script> 
<div name="srvColDiv" style="display:none">  
<form name="adminOpenInfFcol" method="post" action="#" enctype="multipart/form-data">
				<input type="hidden" name="infId">                          
				<input type="hidden" name="infSeq" value=0>                          
				<input type="hidden" name="mstSeq" value=0>                          
				<input type="hidden" name="SSheetNm">
				<input type="hidden" name="srvCd" value="">                   
				<input type="hidden" name="beforeSrvYn" value="">                   
				<input type="hidden" name="initFlag">                   
				<input type="hidden" name="dataModified">       
				<input type="hidden" name="prssAccCd">  
				<input type="hidden" name="initWrtNm" value="${sessionScope.loginVO.usrNm}">  
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
						<th>서비스 구분</th>                 
						<td colspan="7">
							<select name="sgrpCd">
								<option value="">선택</option>
								<c:forEach var="code" items="${codeMap.fileCd}" varStatus="status">
									<option value="${code.ditcCd}">${code.ditcNm}</option>
								</c:forEach>
							</select>
						</td>
					</tr>      
					<tr>
						<th rowspan="2">이미지</th>                 
						<td colspan="7">
							<div class="appendImg">
							</div>
							<input type="hidden" id="tmnlImgFile" name="tmnlImgFile"/> 
							<input type="file" id="uploadTmnlfile" name="uploadTmnlfile" accept="image/*" />
							${sessionScope.button.btn_init}
						</td>
					</tr>
					<tr>
						<td>
							size : 96*136px
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
				</table>
				<h3 class="text-title2">File</h3>
				
				<table class="list01">
					<caption>공공데이터파일</caption>
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
					<%-- 
					<tr>
						<th>File <span>*</span></th>                             
						<td colspan="7"> 
							<select class="" name="fileCd" style="width: 100px;"> 
								<option value="">선택</option>
								<c:forEach var="code" items="${codeMap.fileCd}" varStatus="status">
									<option value="${code.ditcCd}">${code.ditcNm}</option>
								</c:forEach>
							</select>
							<!-- <span id="fileDiv" style="display:inline-block;"></span> -->
						</td>
					</tr> --%>
					
					<tr>
						<th>첨부파일</th>                             
						<td colspan="7">
							<span id="fileDiv" style="display:inline-block;"></span>
							<span id="fileDownDiv"><a href="javascript:;" id="btnFileDown"></a></span>
						</td>
					</tr>
					
					<tr>   
						<th>출력파일명 <span>*</span></th>                             
						<td colspan="4"> 
							<input type="text" name="viewFileNm" value="" style="width:250px" maxlength="160"/>&nbsp;(확장자제외)
						</td>
						<th>작성자</th>                             
						<td colspan="2">
							<input type="text" name="wrtNm"  style="width:250px" maxlength="160"/>
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
					${sessionScope.button.btn_init}
					<button type="button"  class="btn01" title="추가" name="btn_add">추가</a>     
				</div>	
				
				<!-- ibsheet 영역 -->
				<div class="ibsheet_area" name="Fcol">               
				</div>
				
				<div class="buttons">
					<a href='javascript:;' class='btn02'  title="위로이동" name="a_file_up">위로이동</a>
					<a href='javascript:;' class='btn02'  title="아래로이동" name="a_file_down">아래로이동</a>
					${sessionScope.button.a_reg}
					${sessionScope.button.a_del}       
					<%-- ${sessionScope.button.a_save} --%>
					<a href="javascript:;" class="btn03" title="저장" name="a_save">저장</a>       
					${sessionScope.button.a_view}       
				</div>	
				
</form> 
<form name="adminOpenInfFcolDownFileForm" method="post" action="/admin/service/fileDownload.do" target="iframePopUp">
	<input type="hidden" name="downCd" value="S">
	<input type="hidden" name="etc" value="">
	<input type="hidden" name="seq">
	<input type="hidden" name="fileSeq">
</form>
<div>
<br/>
</div>

</div>  