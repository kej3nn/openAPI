<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="egovframework.common.WiseOpenConfig"%>
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
<validator:javascript formName="adminOpenDs" staticJavascript="false" xhtml="true" cdata="false"/> 
<script language="javascript">
function tabSet(){ //탭 객체 생성  
	openTab = new OpenTab(tabId,tabContentClass,tabBody); //headinclude.jsp 변수 있음
	openTab.TabObj = openTab;  
	openTab.addTabClickEvent();            
}	  

$(document).ready(function(){                         
	
	LoadPage();    
	LoadDetail(sheetName);
	//LoadDQ(sheetDQ);
	//LoadIDE(sheetIDE);
	doAction('search');   
	btnSet();
	inputEnterKey();       
	//tabSet();// tab 셋팅
	setTabButton();
	$("button[name=btn_reg]").click(function(e) {	doAction("reg");	return false;	}); 
	$("button[name=btn_inquiry]").click(function(){	doAction("search");	return false;	});
	
	setDs();
	//setDq();
	//setIde();
	
});  

function saveCallBackDs(res){      
    alert(res.RESULT.MESSAGE);
    location.reload();
 
}

function btnSet() { //버튼 초기화 함수
		
		$("a[name=a_init]").show();
	    $("a[name=a_reg]").show();
	    $("a[name=a_modify]").hide();
	    $("a[name=a_del]").hide();
	    $("a[name=a_dataSample]").hide();
		
		$("a[name=a_import]").hide();
		$("a[name=a_up]").hide();
		$("a[name=a_down]").hide();
		$("a[name=a_modify]").hide();
	   
}

function LoadPage(){      
	
	//message-common_ko_KR.properties 선언 후 사용 or message-common_en_US.properties 선언 후 사용
	var gridTitle1 = "NO";
		gridTitle1 +="|"+"<spring:message code='labal.ownerCd'/>";
		gridTitle1 +="|"+"<spring:message code='labal.dsId'/>";
		gridTitle1 +="|"+"<spring:message code='labal.dsNm'/>";
		gridTitle1 +="|"+"<spring:message code='labal.dtId'/>";
		gridTitle1 +="|"+"<spring:message code='labal.dtNm'/>";
		gridTitle1 +="|"+"<spring:message code='labal.keyDbYn'/>";
		gridTitle1 +="|"+"<spring:message code='labal.stddDsYn'/>";
		gridTitle1 +="|"+"<spring:message code='labal.useYn'/>";
	
	with(mySheet){
           
    	var cfg = {SearchMode:3,Page:50,VScrollMode:1};                                
        SetConfig(cfg);  
        var headers = [                               
                    {Text:gridTitle1, Align:"Center"}                 
                ];
        var headerInfo = {Sort:0,ColMove:1,ColResize:1,HeaderCheck:0};
        
        InitHeaders(headers, headerInfo); 
         
        var cols = [          
					 {Type:"Seq",			SaveName:"seq",				Width:50,	Align:"Center",		Edit:false,  Sort:false}
					,{Type:"Text",		SaveName:"ownerCd",		Width:200,	Align:"Left",			Edit:false}
					,{Type:"Text",			SaveName:"dsId",				Width:250,	Align:"Left",			Edit:false}
					,{Type:"Text",			SaveName:"dsNm",			Width:350,	Align:"Left",			Edit:false}
					,{Type:"Text",			SaveName:"dtId",				Width:0,		Align:"Left",			Edit:false, Hidden:true}
					,{Type:"Text",			SaveName:"dtNm",			Width:350,	Align:"Left",			Edit:false}
					,{Type:"Text",			SaveName:"keyDbYn",			Width:100,	Align:"Left",			Edit:false}
					,{Type:"Text",			SaveName:"stddDsYn",			Width:100,	Align:"Left",			Edit:false}
					,{Type:"CheckBox",	SaveName:"useYn",			Width:20,	Align:"Center",		TrueValue:"Y", FalseValue:"N", Edit:false}
                                        
                ];       
                                      
        InitColumns(cols);                                                                           
        SetExtendLastCol(1);   
        SetColProperty("ownerCd", ${codeMap.ownerCdIbs});    //InitColumns 이후에 셋팅       
        SetColProperty("dsCd", 			${codeMap.dsCdIbs});    //InitColumns 이후에 셋팅       
    }
        default_sheet(mySheet);    	
	
}




// 기본 action      
function doAction(sAction)                                  
{
	var classObj = $("."+"content").eq(0); //tab으로 인하여 form이 다건임
	var actObj = setTabForm(classObj); // 0: form data, 1: form 객체
		switch(sAction) {          
				case "search":      //조회   
					
					ajaxBeforeSendAdmin("<c:url value='/admin/ajaxBeforeSendAdmin.do'/>"); //IbSheet 조회전 세션 체크
					var param = {PageParam: "ibpage", Param: "onepagerow=50&"+actObj[0]};    
					mySheet.DoSearchPaging("<c:url value='/admin/openinf/opends/openDsList.do'/>", param);
					break;
						
				case "reg":	//등록
					tabNewEvent();
					break;
			}
}

// detail sheet action

//순서 재설정
function setOrder(objId){
	var order = 1;
	var tmpOrder = "";
	for(var i=1; i<=objId.LastRow(); i++){
		tmpOrder= "vOrder";
		objId.SetCellValue(i,tmpOrder, order);
		order++;
	};
}


function dupCallBack(tab, json, res){
	var objTab = getTabShowObj();//탭이 oepn된 객체가져옴
	var formObj = objTab.find("form[name=adminOpenDs]");
	if(tab.resultCnt > 0){
		alert("중복된 데이터셋이 존재합니다.");
		return;
	}
	var url = "<c:url value='/admin/openinf/opends/saveOpenDs.do'/>"; 
	var param = formObj.serialize();
	ajaxCallAdmin(url,param,savecallbackprev);
}

function setDsId(){
	var classObj = $("."+"content").eq(1); //tab으로 인하여 form이 다건임
	//var objTab = getTabShowObj(); //탭이 oepn된 객체가져옴
	var formObj = classObj.find("form[name=adminOpenDs]");    
	var sheetObj =formObj.find("input[name=sheetNm]").val();  
	//var sheetObj2=sheetObj+"table";
	var sheetObj2 = "sheetName";
	var gridObj2 = window[sheetObj2];
	var dsId=formObj.find("[name=dsId]").val();
	var status;
	for(var i=1; i<=gridObj2.LastRow(); i++){
		tmpOrder= "dsId";
		gridObj2.SetCellValue(i,tmpOrder, dsId);
		status=gridObj2.GetCellValue(i,"status");
		if(status == "U") gridObj2.SetCellValue(i,"status", "R");		
	};	
}

function saveCallBack2(res){
	var dsId = res.RESULT.GUBUN;
	var sheetObj; //IbSheet 객체         
	var objTab = getTabShowObj();//탭이 oepn된 객체가져옴
	var formObj = objTab.find("form[name=adminOpenDs]");
	sheetObj =formObj.find("input[name=sheetNm]").val();   
	var gridObj = window[sheetObj];
	for(var i=1; i<=gridObj.LastRow(); i++){
		tmpOrder= "dsId";
		gridObj.SetCellValue(i,tmpOrder, dsId);
	}
 	ibsSaveJson = gridObj.GetSaveJson(1);	//모든 행의 데이터를 객체로 받기
	if(ibsSaveJson.data.length < 0) return;
	var url =  "<c:url value='/admin/openinf/opends/saveOpenDscol.do'/>";
	var param = "";
	IBSpostJson(url, param, savecallback);	 
}
var sheetTabCnt = 0;
function tabNewEvent(){
	var title = "등록하기";
	var id ="bbsListReg";
	openTab.addRegTab(id,title,tabCallRegBack2); // 탭 추가 시작함
   	var cnt = sheetTabCnt++;
   	SheetCreate(cnt);
   	buttonEventAdd();
}

function tabCallRegBack2(tab){ 
	tab.ContentObj.find("a[name=a_modify]").hide();  
 	tab.ContentObj.find("a[name=a_del]").hide();  
	tab.ContentObj.find("a[name=a_import]").hide();
	tab.ContentObj.find("a[name=a_up]").hide();       
	tab.ContentObj.find("a[name=a_down]").hide();
}

// 상세정보 보기
function mySheet_OnDblClick(row, col, value, cellx, celly) {
    
	if(row == 0) return;    
    
    $("a[name=a_init]").show();
    $("a[name=a_reg]").hide();
    $("a[name=a_modify]").show();
    $("a[name=a_del]").show();
    $("a[name=a_dataSample]").show();
	
	$("a[name=a_import]").show();
	$("a[name=a_up]").show();
	$("a[name=a_down]").show();
	$("a[name=a_modify]").show(); 
 
 	var url = "<c:url value='/admin/openinf/opends/openDsDetail.do'/>";
 	var param = "dsId= " + mySheet.GetCellValue(row,"dsId");
 
 	ajaxBeforeSendAdmin("<c:url value='/admin/ajaxBeforeSendAdmin.do'/>"); //IbSheet 조회전 세션 체크
 	ajaxCallAdmin(url, param, tabCallBack2);
 	doSheetAction('searchDtl');
 	//doDqAction('searchDQ');
 	//dosheetIdeAction('searchIDE');
    
    
    //tabEvent(row);                      
}

function tabEvent(row){//탭 이벤트 실행     
	var title = mySheet.GetCellValue(row,"dsNm");//탭 제목                                           
	var id = mySheet.GetCellValue(row,"dsId");//탭 id(유일한key))
    openTab.SetTabData(mySheet.GetRowJson(row));//db data 조회시 조건 data
    var url = "<c:url value='/admin/openinf/opends/openDsDetail.do'/>"; // Controller 호출 url  
    
    var sheetYn = openTab.tabExits(id); //탭존재 여부      
    openTab.addTab(id,title,url,tabCallBack2); // 탭 추가 시작함(callback함수 overring)
	
    if(!sheetYn){	//탭이 있을 경우 IBSheet 로드 방지                                  
    	var cnt = sheetTabCnt++;
    	SheetCreate(cnt); //시트
    	doSheetAction('searchDtl');
    	doSheetAction('searchDstbl');
     	buttonEventAdd();
    }else{
    	buttonEventAdd();
    }
}

function tabCallBack2(json){
//	tab.ContentObj.find("a[name=a_reg]").hide();
//	tab.ContentObj.find("button[name=dsSearch]").hide();
//	tab.ContentObj.find("button[name=dtSearch]").hide();
// 	readonly class="readonly"
// 	.attr("readonly class","readonly");
	if(json.DATA != null){
		var classObj = $("."+"content").eq(1); //tab으로 인하여 form이 다건임
		var formObj = classObj.find("form[name=adminOpenDs]");
		  
		$.each(json.DATA[0],function(key,state){
			if(key == "useYn"){
				formObj.find("input:radio[name=useYn][value="+state+"]").prop("checked","checked");
			}else if(key == "ownerCd"){
				formObj.find("[name=ownerCd]").val(state);
				formObj.find("[name=ownerCode]").val(state);
				formObj.find("[name=ownerCode]").attr("class","readonly");
				if(state=="OPENDBRAIN"){
					formObj.find("[name=ownerCode]").attr("style","width:85px");
				}else{
					formObj.find("[name=ownerCode]").attr("style","width:70px");
				}
			}else if(key == "dsCd"){
				formObj.find("input:radio[name=dsCd][value="+state+"]").prop("checked","checked");
			}else if(key == "dtNm"){
				formObj.find("[name=dtNm]").attr("class","readonly");
				formObj.find("[name="+key+"]").val(state);
			}else if(key == "dsId"){
				formObj.find("[name=dsId]").attr("class","readonly");
				formObj.find("[name="+key+"]").val(state);
			}else if(key == "bcpDsId"){
				formObj.find("[name=bcpDsId]").attr("class","readonly");
				formObj.find("[name="+key+"]").val(state);
			}else if(key == "keyDbYn"){
				formObj.find("input:radio[name=keyDbYn][value="+state+"]").prop("checked","checked");
			}else if(key == "stddDsYn"){
				formObj.find("input:radio[name=stddDsYn][value="+state+"]").prop("checked","checked");
			}
			else{		
				formObj.find("[name="+key+"]").val(state);
			}
		});  
	}
}

function SheetCreate(SheetCnt){       
	var SheetNm = "sheet"+SheetCnt;
	var SheetTable=SheetNm+"table";
	$("div[name=mainSheet]").eq(1).attr("id","DIV_"+SheetNm);                                          
	createIBSheet2(document.getElementById("DIV_"+SheetNm),SheetNm, "100%", "300px");
	$("div[name=subSheet]").eq(1).attr("id","DIV_sub_"+SheetNm);                                          
	createIBSheet2(document.getElementById("DIV_sub_"+SheetNm),SheetTable, "100%", "150px");
	var sheetobj = window[SheetNm];
	window[SheetTable + "_OnSearchEnd"] =  OnSearchEnd;
	window[SheetNm + "_OnClick"] =  onClick;
	var sheetobj2 = window[SheetTable]; 
	var objTab = getTabShowObj();//탭이 oepn된 객체가져옴
	var formObj = objTab.find("form[name=adminOpenDs]");
	formObj.find("input[name=sheetNm]").val(SheetNm);
	//buttonEventAdd();
	LoadDetail(sheetobj);	
	LoadTable(sheetobj2);
	dsCdCheck(); //sheet가 생성된 후 실행해야 한다.
}

function buttonEventAdd(){ 
	setTabButton();
	
}

function onClick(Row, Col, Value, CellX, CellY, CellW, CellH) {
	if(Row == 0) return;
	var objTab = getTabShowObj(); //탭이 oepn된 객체가져옴
	var formObj = objTab.find("form[name=adminOpenDs]");    
	var sheetObj =formObj.find("input[name=sheetNm]").val();  
	var gridObj = window[sheetObj];
	var param = "?sheetNm="+sheetObj;
		param += "&toSeq="+Row;
// 	var data = "?dsId="+gridObj.GetCellValue(Row,"dsId");       
// 		data += "&colSeq="+gridObj.GetCellValue(Row,"colSeq");                
	
	if(gridObj.ColSaveName(Col) == "bbsTit"){
		var target = "<c:url value='/admin/openinf/opends/openDsTermPop.do"+param+"'/>";
		var wName = "ccolview";        
		var wWidth = "900";            
		var wHeight = "600" ;                           
		var wScroll ="yes";
		OpenWindow(target, wName, wWidth, wHeight, wScroll);
		
	}
}

function OnSearchEnd(){                  
	
}
function sheetcallback(res){
    var result = res.RESULT.CODE;
    if(result == 0) {
    	alert(res.RESULT.MESSAGE);
    	doSheetAction('searchDtl');
    } else {                               
    	alert(res.RESULT.MESSAGE);
    }
}   
function sheetDsbtlcallback(res){
	var result = res.RESULT.CODE;
    if(result == 0) {
    	alert(res.RESULT.MESSAGE);
    	doSheetAction('searchDstbl');
    } else {                               
    	alert(res.RESULT.MESSAGE);
    }
}
function savecallbackprev(res){   //등록하기를 통해 저장을 했을경우..   
	alert(res.RESULT.MESSAGE);
	
	var objTab = getTabShowObj();
	objTab.find("a[name=a_modify]").show();
	objTab.find("a[name=a_del]").show();  
	objTab.find("a[name=a_import]").show();
	objTab.find("a[name=a_up]").show();       
	objTab.find("a[name=a_down]").show();
	objTab.find("a[name=a_reg]").hide();
	objTab.find("button[name=dsSearch]").hide();
	objTab.find("button[name=dtSearch]").hide();
	
	var formObj = objTab.find("form[name=adminOpenDs]");
	state =formObj.find("input[name=ownerCode]").val();
	if(state=="OPENDBRAIN"){
		objTab.find("input[name=ownerCode]").attr("style","width:85px");
	}else{
		objTab.find("input[name=ownerCode]").attr("style","width:70px");
	}
	objTab.find("[name=ownerCode]").attr("class","readonly");
	objTab.find("input[name=dtNm]").attr("class","readonly");
	objTab.find("input[name=dsId]").attr("class","readonly");
    
}

function mySheet_OnSearchEnd(Code,Msg,StCode,StMsg){
	
	if( $("input[name=tempRegValue]").val() == "1" ){
		$("input[name=tempRegValue]").val("0"); //값을 0로 하여 조회시 페이지 자동 click하지 못하도록 한다.
		tabEvent(1);
	}
	
}

function savecallback(res){      
    alert(res.RESULT.MESSAGE);
   location.reload();
}


function setTabButton(){ 
	
	var classObj = $("."+"content").eq(1); //tab으로 인하여 form이 다건임
	var formObj = classObj.find("form[name=adminOpenDs]");
	
	formObj.find("a[name=a_import]").click(function(e) { //불러오기
		doSheetAction("bring");
		
		return false;                 
	});   
	formObj.find("a[name=a_reg]").click(function(e) { //저장
		doSheetAction("save");	     
		return false;                 
	});          
	formObj.find("a[name=a_modify]").eq(0).click(function() { // 상세정보 수정
		doSheetAction("update");          
		return false;                 
	});          
	/* formObj.find("a[name=a_modify]").eq(1).click(function() { // 테이블 목록 수정
		doSheetAction("updateDstbl");               
		return false;                 
	}); */
	formObj.find("a[name=a_modify]").eq(1).click(function() { // 컬럼 목록 수정
		doSheetAction("updateCol");               
		return false;                 
	});          
	formObj.find("a[name=a_del]").eq(0).click(function() { // 데이터셋 삭제
		doSheetAction('delete');                     
		return false;                 
	});
// 	formObj.find("a[name=a_del]").eq(1).click(function() { // 테이블 목록 삭제
// 		doSheetAction('deleteDstbl');                     
// 		return false;                 
// 	});
// 	formObj.find("a[name=a_del]").eq(2).click(function() { // 컬럼 목록 삭제
// 		doSheetAction('deleteCol');                     
// 		return false;                 
// 	});   
	formObj.find("a[name=a_up]").click(function() { // 위로이동
		doSheetAction("up");               
		return false;                 
	});     
	formObj.find("a[name=a_down ]").click(function() { // 아래로이동
		doSheetAction("down");               
		return false;                 
	});  
	formObj.find("button[name=dsSearch ]").click(function() { 
		doSheetAction("openDsPop");               
		return false;                 
	}); 
	formObj.find("button[name=btSearch ]").click(function() { 
		doSheetAction("backDsPop");               
		return false;                 
	});
	formObj.find("button[name=dtSearch ]").click(function() { 
		doSheetAction("openDtPop");               
		return false;                 
	});  
	formObj.find("a[name=a_dataSample ]").click(function() { 
		doSheetAction("dataSamplePop");               
		return false;                 
	});  
	formObj.find("input[name=fsYn]" ).change(function(e) { //재정 전용 검색 사용여부
		if(inputCheckYn("fsYn") =="Y"){
			formObj.find("input[name=fsYn]").val("Y");
		}else{
			formObj.find("input[name=fsYn]").val("N");
		}
	 });
	
	if( formObj.find("input[name=fsYn]").val() == 'Y' ){  //사용 
		formObj.find("input[name=fsYn]").prop("checked",true);
	}
	
	formObj.find("input[name=dsNm]").keyup(function(e) {
		ComInputKorObj(formObj.find("input[name=dsNm]"));
		 return false;
	 });
	
	formObj.find("input[name=dsNmEng]").keyup(function(e) {
		ComInputEngEtcObj2(formObj.find("input[name=dsNmEng]"));
		 return false;
	 });
	
// 	formObj.find("textarea[name=dsExp]").keyup(function(e) {
// 		ComInputKorObj(formObj.find("textarea[name=dsExp]"));
// 		 return false;
// 	 });
	
	formObj.find("textarea[name=dsExpEng]").keyup(function(e) {
		ComInputEngEtcObj2(formObj.find("textarea[name=dsExpEng]"));
		 return false;
	 });
	
	formObj.find("a[name=a_init]").click(function() {
 		doSheetAction("init");          
 		return false;                 
 	});
	
	

	formObj.find("input[name=dsCd]").click(function(e) { //데이터셋 구분 클릭시 sheet 숨기거나 보이도록.
		var checkId = $(this).attr("id");
		var sheetObj =formObj.find("input[name=sheetNm]").val();   //IbSheet 객체
		var gridObj = window[sheetObj];
			/* 
	 		if( "dsCdCheck2" == checkId ){ //통계 데이터 선택시 
	 			gridObj.SetColHidden("statYn",0); //컬럼 보이도록
	 			formObj.find("tr[name=trHidden]").css("display","none"); //숨김
	 		}else if( "dsCdCheck1" == checkId   ){  //원시 데이터 선택시
	 			gridObj.SetColHidden("statYn",1); //컬럼숨김
	 			formObj.find("tr[name=trHidden]").css("display",""); //보임
	 		} */
  	});
	
	if(formObj.find("input[name=isLock]").val() >= "1"){
		formObj.find("input:radio[name=dsCd]").attr("disabled","true");
		formObj.find("td[name=tdHidden]").append("(등록된 공공데이터가 있어 수정 불가)");
	}
	
	
} 

function dsCdCheck(){ //데이터셋 구분탭이 열리면서 체크
	
	var objTab = getTabShowObj();//탭이 oepn된 객체가져옴
	var formObj = objTab.find("form[name=adminOpenDs]");   
	var sheetObj; //IbSheet 객체   
	var checkId1 = formObj.find("input[name=dsCd]").eq(0).is(":checked");
	var checkId2 = formObj.find("input[name=dsCd]").eq(1).is(":checked");
	var checkId = "";
	if(checkId1){  //참일경우의 값을 넣어 준다..체크 
		checkId = "dsCdCheck1";
	}else if(checkId2){
		checkId = "dsCdCheck2";
	}
	sheetObj =formObj.find("input[name=sheetNm]").val();   //IbSheet 객체
	var gridObj = window[sheetObj];
	/* 
 		if( "dsCdCheck2" == checkId ){ //통계 데이터 선택시 
 			gridObj.SetColHidden("statYn",0); //컬럼 보이도록
 			formObj.find("tr[name=trHidden]").css("display","none"); //숨김
 		}else if( "dsCdCheck1" == checkId  ){  //원시 데이터 선택시
 			gridObj.SetColHidden("statYn",1); //컬럼숨김
 			formObj.find("tr[name=trHidden]").css("display",""); //보임
 		} */
}

function inputEnterKey(){
	$("input").keypress(function(e) {
		  if(e.which == 13) {
			  doAction('search');   
			  return false;
		  }
	});
}   

</script>
</head>
<body onload="">
<div class="wrap">
	<c:import  url="/admin/admintop.do"/>
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
			<div class="more_list">
				<a href="#" class="more">0</a>                
				<ul class="other_list" style="display:none;">
					<li><a href="#">보유데이터목록</a><a href="#" class="line_close">x</a></li>
					<li><a href="#">공공데이터목록asdfsdfsfsdfsdfsdf</a><a href="#" class="line_close">x</a></li>
				</ul>
			</div>
			
			<!-- 목록내용 -->
		<div class="content"  >
		<form name="adminOpenDs"  method="post" action="#">
		<table class="list01">              
			<caption>데이터셋 관리</caption>
			<colgroup>
							<col width="10%"/>
							<col width="30%"/>
							<col width="10%"/>
<%-- 							<col width="30%"/> --%>
<%-- 							<col width="10%"/> --%>
<%-- 							<col width="10%"/> --%>
						</colgroup>     
				<tr>                
							 
						<th>국가중점DB여부</th>
						<td>
							<input type="checkbox" name="keyDbYn" value="Y" class="input"/>
							<label for="use"></label>
						</td>         
						<th>행자부표준여부</th>
						<td colspan="3">
							<input type="checkbox" name="stddDsYn" value="Y" class="input"/>
							<label for="use"></label>
						</td>
				</tr> 
				<tr>
					<th>검색어</th>
					<td colspan="5">
					<select name="searchWd">
						<option value="">선택</option>
						<option value="0" selected="selected">데이터셋명</option>
	                 	<option value="1">데이터셋ID</option>
	                 	<option value="2">보유데이터명</option>
					</select>

					<select name="searchWd2">
						<option value="" selected="selected">전체</option>
						<!-- <option value="">선택</option>
						<option value="3" selected="selected">전체</option> -->
	                 	<option value="4">사용</option>
	                 	<option value="5">미사용</option>
					</select> 
					<input name="searchWord" type="text" value="" style="width:200px" maxlength="160"/>
					<!-- <button type="button" class="btn01" name="btn_search">조회</button> --> 
					 ${sessionScope.button.btn_inquiry}
					<%-- ${sessionScope.button.btn_reg}    --%>                  
				</td>
			</tr>
			
			<!-- <tr>
				<th>사용여부</th>
				<td>
					<input type="radio" name="useYn" />
					<label for="useAll">전체</label>
					<input type="radio" name="useYn"  value="Y" checked="checked"/>
					<label for="use">사용</label>
					<input type="radio" name="useYn" value="N"/>
					<label for="unuse">미사용</label>
				</td>
			</tr> -->
		</table>	
		</form>		
			<!-- ibsheet 영역 -->
			<div style="clear: both;"></div>
			<div class="ibsheet_area_both">
				<script type="text/javascript">createIBSheet("mySheet", "100%", "300px");</script>             
			</div>
		</div>
			
			<!-- 탭 -->
			<!-- <ul class="tab">
				<li class="all_list"><a href="#">데이터셋</a></li>                       
			</ul> -->
			<!-- <div class="more_list" style="display:none">
				<a href="#" class="more">0</a>                
				<ul class="other_list" style="display:none;">
					<li><a href="#">보유데이터목록</a><a href="#" class="line_close">x</a></li>
					<li><a href="#">공공데이터목록asdfsdfsfsdfsdfsdf</a><a href="#" class="line_close">x</a></li>
				</ul>
			</div> -->
		
			
			<!-- 탭 내용 --> 
			
				<ul class="tab-inner" >   
					<li><a href="#" class="service">데이터셋 상세정보</a></li>
					<!-- 사용안함
					<li><a href="#" class="no-service" >데이터 품질진단</a></li>              
				    <li><a href="#" class="no-service" >개인정보 모니터링</a></li> --> 
				</ul>             
				<c:import  url="opendsdetailtab.jsp"/> 
				<%-- 사용안함
				<c:import  url="opendqtab.jsp"/>    
 				<c:import  url="openidinftab.jsp"/> --%>                
				<%-- <c:import  url=""/>    --%>
		
		
		
	</div> 
</div>

	<!--##  푸터  ##-->
  <c:import  url="/WEB-INF/jsp/admin/adminfooter.jsp"/>
	<!--##  /푸터  ##-->
</div>
</body>
</html>