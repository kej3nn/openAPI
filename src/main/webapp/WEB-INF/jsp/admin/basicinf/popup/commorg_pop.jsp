<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="egovframework.common.WiseOpenConfig"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ page import="egovframework.com.cmm.EgovWebUtil"%>
<%
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><spring:message code="labal.orgManagement"/>ㅣ<spring:message code="wiseopen.title"/></title>                    
<c:import  url="/WEB-INF/jsp/inc/headinclude.jsp"/>
<style type="text/css">
body{background:none;}
</style>  
<%
	// 조직정보에서 팝업 띄웠을 경우 name 바꿔서 부모창에 입력하기 위한 변수
	String orgNmGb = request.getParameter("orgNmGb") == null ? "" : EgovWebUtil.clearXSSMinimum(request.getParameter("orgNmGb"));
	String sheetNm = request.getParameter("sheetNm") == null ? "" : EgovWebUtil.clearXSSMinimum(request.getParameter("sheetNm")); 
	String index = request.getParameter("index") == null ? "" : EgovWebUtil.clearXSSMinimum(request.getParameter("index")); 
	//검색어를 입력후 검색시 usrnNm에 출력되도록.
	String linkSearch = request.getParameter("linkSearch") ;          
	if(linkSearch != null){
		linkSearch = EgovWebUtil.clearXSSMinimum(new String(linkSearch.getBytes("8859_1"),"UTF-8")); //인코딩 변환
	}else{
		linkSearch = "";
	}
%>
<script language="javascript">              
//<![CDATA[          
var tabContentClass= "content";
$(document).ready(function()    {
	
	//get으로 넘어온 담당부서명 검색어 팝업에 저장후 검색
	var linkSearch = $("input[id=linkSearch]").val();
	if(linkSearch != null){
		$("input[name=orgNm]").val(linkSearch);
	}
	
	LoadPage();                                                               
	doAction('search');                                                         
	$("input[name=usrId]").focus();
	$("a[name=closePop]").click(function(){	window.close();	});		// 팝업창 닫기
	$("button[name=btn_orgSearch]").click(function(e) {	doAction("search");	return false;	});
	inputEnterKey();      
	document.getElementById("orgNmGb");
});                                                       
            
function LoadPage()                
{         
                    
    with(mySheet1){
    	                     
    	var cfg = {SearchMode:2,Page:50,VScrollMode:1};                       
        SetConfig(cfg);          
        var headers = [                                   
                    {Text:"조직코드|조직명|조직영문명|전체조직명|최상위조직코드|상위조직코드|레벨", Align:"Center"}
                ];
        var headerInfo = {Sort:0, ColMove:0, ColResize:1, HeaderCheck:1};
        
        InitHeaders(headers, headerInfo);                           
            
        var cols = [          
					 {Type:"Text",		SaveName:"orgCd",			Width:0,	Align:"Center",		Edit:false, Hidden:true}
					,{Type:"Text",		SaveName:"orgNm",			Width:100,	Align:"Left",		Edit:false, TreeCol:1}
					,{Type:"Text",		SaveName:"orgNmEng",		Width:0,	Align:"Center",		Edit:false, Hidden:true}
					,{Type:"Text",		SaveName:"orgFullNm",		Width:0,	Align:"Center",		Edit:false, Hidden:true}
					,{Type:"Text",		SaveName:"orgCdTop",		Width:0,	Align:"Center",		Edit:false, Hidden:true}
					,{Type:"Text",		SaveName:"orgCdPar",		Width:0,	Align:"Center",		Edit:false, Hidden:true}
					,{Type:"Text",		SaveName:"orgLvl",			Width:0,	Align:"Center",		Edit:false,Hidden:true}
                                                     
                ];                                                                    
                                      
        InitColumns(cols);                                                                                               
        FitColWidth();                                                                       
        SetExtendLastCol(1);   
    }                   
    default_sheet(mySheet1);                      
}      
    
/*Sheet 각종 처리*/                  
function doAction(sAction)                                  
{
	switch(sAction)
	{          
	                   
		case "search":      //조회   
		                 
			var formParam = $("form[name=adminCommOrgPop]").serialize();     
			ajaxBeforeSendAdmin("<c:url value='/admin/ajaxBeforeSendAdmin.do'/>"); //IbSheet 조회전 세션 체크
			var param = {PageParam: "ibpage", Param: "onepagerow=50&"+formParam};
			mySheet1.DoSearchPaging("<c:url value='/admin/basicinf/popup/commOrgListAll.do'/>", param);
			break;
	}           
}         



// 마우스 이벤트
function mySheet1_OnSearchEnd(code, msg)
{
   if(msg != "")
	{                
	    alert(msg);
    }
}

function inputEnterKey(){
	$("input").keypress(function(e) {
		  if(e.which == 13) {
			  doAction('search');   
			  return false;        
		  }
	});
}           
                   
function mySheet1_OnDblClick(row, col, value, cellx, celly) {
    if(row == 0) return;  
    var arrayValue, orgTopCd, orgTopNm;
    var classObj = opener.$("."+tabContentClass); //부모 form class 확인
    
    // 조직정보에서 팝업 띄웠을 경우 name 바꿔서 부모창에 입력
    if ($("#orgNmGb").val() == "1") {
    	/* 
    	if ( mySheet1.GetCellValue(row, "orgLvl") == "1" ) {
	    	alert("최상위 조직은 선택 할 수 없습니다.");
	    	return;
	    } */
    	// 최상위 조직 찾기
    	for ( var i=row; i>0; i-- ) {
    		if ( mySheet1.GetParentRow(i) == -1 ) {
    			orgTopCd = mySheet1.GetCellValue(i, "orgCd");
    			orgTopNm = mySheet1.GetCellValue(i, "orgNm");
    			break;
    		}
    	}
    	arrayValue = {orgCdParCd:mySheet1.GetCellValue(row, "orgCd")
    			, orgLvl:Number(mySheet1.GetCellValue(row, "orgLvl"))+1
    			, orgCdTopCd:orgTopCd
    			, orgCdTopNm:orgTopNm
    			}// json으로 부모창 input 이름, data
    } else if($("#orgNmGb").val() == "2"){ 
    	arrayValue = {orgCd:mySheet1.GetCellValue(row, "orgCd"), orgNm:mySheet1.GetCellValue(row, "orgNm"), orgFullNm:mySheet1.GetCellValue(row, "orgFullNm")}// json으로 부모창 input 이름, data
    } else if($("#orgNmGb").val() == "3"){	//메타데이터 담당조직 일괄변경에서 사용함
    	arrayValue = {orgCdMod:mySheet1.GetCellValue(row, "orgCd"), orgNmMod:mySheet1.GetCellValue(row, "orgNm"), orgFullNm:mySheet1.GetCellValue(row, "orgFullNm")}// json으로 부모창 input 이름, data
    	return_popMod(classObj,arrayValue);
    } else if($("#orgNmGb").val() == "4"){ 
    	arrayValue = {orgCd:mySheet1.GetCellValue(row, "orgCd"), orgNm:mySheet1.GetCellValue(row, "orgNm"), orgFullnm:mySheet1.GetCellValue(row, "orgFullNm")}// json으로 부모창 input 이름, data
    } else if($("#orgNmGb").val() == "5"){ 
    	arrayValue = {orgCd:mySheet1.GetCellValue(row, "orgCd"), orgNm:mySheet1.GetCellValue(row, "orgNm"), orgFullNm:mySheet1.GetCellValue(row, "orgFullNm"),usrCd:null,usrNm:null}// json으로 부모창 input 이름, data
    } else if($("#orgNmGb").val() == "6"){ 
    	arrayValue = {orgCd:mySheet1.GetCellValue(row, "orgCd"), orgNm:mySheet1.GetCellValue(row, "orgNm")}// json으로 부모창 input 이름, data
    	return_pop_adminCommOrg(arrayValue); //탭이 아닌경우 사용하도록 만듬.
    	return true;
    } else if($("#orgNmGb").val() == "7"){ 
    	/* arrayValue = {orgCd:mySheet1.GetCellValue(row, "orgCd"), orgNm:mySheet1.GetCellValue(row, "orgNm"), orgFullNm:mySheet1.GetCellValue(row, "orgFullNm"),usrCd:null,usrNm:null}// json으로 부모창 input 이름, data */
    	//arrayValue = {orgCd:mySheet1.GetCellValue(row, "orgCd"), orgNm:mySheet1.GetCellValue(row, "orgNm")}// json으로 부모창 input 이름, data
    	//alert(orgNm);
    	return_pop_adminCommOpenInf(); //탭이 아닌경우 사용하도록 만듬.
    	return true;
    } else if($("#orgNmGb").val() == "8"){ 
    	arrayValue = {orgCd:mySheet1.GetCellValue(row, "orgCd")
    			, orgNm:mySheet1.GetCellValue(row, "orgNm")
    			, orgLvl:Number(mySheet1.GetCellValue(row, "orgLvl"))+1
    			, orgCdTopCd:orgTopCd
    			, orgCdTopNm:orgTopNm
    			}// json으로 부모창 input 이름, data 직원정보관리 소속기관 검색에서 씀(부서도 넘어가서 등록)
    }
    	else {
    	
	    arrayValue = {orgCd:mySheet1.GetCellValue(row, "orgCd"), orgNm:mySheet1.GetCellValue(row, "orgNm")}// json으로 부모창 input 이름, data
    }
    var index = "<%=index.replaceAll("<", "&lt;").replaceAll(">", "&gt;")%>";
    if(index =="") {
    	
    	return_pop(classObj,arrayValue); // 공통 javascirpt 호출(common.js)	
    } else {
    	
    	return_popIndex(classObj,index,arrayValue); // 공통 javascirpt 호출(common.js)
    }

    //return_pop(classObj,arrayValue); // 공통 javascirpt 호출(common.js)
}   

function return_pop_adminCommOpenInf(){
	
	//var rowCnt = mySheet1.RowCount();
	//var sheetNm = $("input[name=sheetNm]").val();
	//var toSheet = opener.window("<c:url value='/admin/openinf/openInfPage.do'/>");
	var sheetNm = "<%=sheetNm.replaceAll("<", "&lt;").replaceAll(">", "&gt;")%>";
	
	
	var toSheet = opener.window[sheetNm];
	//var toRow = $("input[name=toRow]").val();
	var rowCnt = mySheet1.GetSelectionRows();
	var orgCd = "";
	var orgNm = "";
	//var cnt = 0;
	
	
	orgCd = mySheet1.GetCellValue(rowCnt, "orgCd");
	orgNm = mySheet1.GetCellValue(rowCnt, "orgNm");
	//cnt ++;
	//alert(orgCd);
	//alert(orgNm);
	var row = toSheet.GetSelectionRows();
	toSheet.SetCellValue(row, "orgCd", orgCd);
	toSheet.SetCellValue(row, "orgNm", orgNm); 
	
	/* alert("test");
	$.each(arrayValue,function(key,state){         
	//opener.$("form[name=MemUpdInfo]").find("input[name="+key+"]").val(state);
		if(key=="orgNm"){ //개인정보수정에서 orgNm컬럼자체가 사용되고있는데 이 함수에서는 nm은 저장되면 안되기에 orgNm2를 만듬.
			opener.$("form[name=adminOpenInf]").find("input[name=orgNm]").val(state);
		}else{
			opener.$("form[name=adminOpenInf]").find("input[name="+key+"]").val(state);
		}
	}); */ 
	
	window.close();
}

function return_pop_adminCommOrg(arrayValue){ //탭이 아닌경우 사용하도록 만듬 ..관리자 개인정보수정에서만 사용.. 필요하면 수정
	$.each(arrayValue,function(key,state){         
//		opener.$("form[name=MemUpdInfo]").find("input[name="+key+"]").val(state);
		if(key=="orgNm"){ //개인정보수정에서 orgNm컬럼자체가 사용되고있는데 이 함수에서는 nm은 저장되면 안되기에 orgNm2를 만듬.
			opener.$("form[name=MemUpdInfo]").find("input[name=orgNm2]").val(state);
		}else{
			opener.$("form[name=MemUpdInfo]").find("input[name="+key+"]").val(state);
		}
	}); 
	
	window.close();
}

//담당자일괄변경용 함수
function return_popMod(obj,arrayValue){
	
	var formObj;   
	for(var i = 0; i < obj.length; i++){         
		if(obj.eq(i).css("display") != "none"){
			formObj = obj.eq(i).find("form"); 
		}
	}                
	           
	$.each(arrayValue,function(key,state){
		formObj.find("[name="+key+"]").val(state);
		
		formObj.find("input[name=usrCdMod]").val("");
		formObj.find("input[name=usrNmMod]").val("");
		
	}); 
	
	window.close();
	
	 
}


//]]> 
</script>              
</head>
<body onload="">
<div class="wrap-popup">
	<!-- 내용 -->
	<div class="container">
		<!-- 상단 타이틀 -->
		<div class="title">
			<h2>조직 선택</h2>
		</div>
		<!-- 팝업 내용 -->
		<div class="popup" style="padding: 20px;"> 
			<form name="adminCommOrgPop"  method="post" action="#">
				<input type="hidden" id="orgNmGb" value="<%=orgNmGb.replaceAll("<", "&lt;").replaceAll(">", "&gt;") %>"/>
				<input type="hidden" id="linkSearch" name="linkSearch" value="<%=linkSearch.replaceAll("<", "&lt;").replaceAll(">", "&gt;")%>"/>
				<div>	
					<table class="list01">
						<colgroup>
							<col width="100"/>
							<col width=""/>
						</colgroup>
						<tr>
							<th>조직명</th>
							<td>
								<input type="text" name="orgNm" value="" maxlength="160"/>
								<button type="button" class="btn01" name="btn_orgSearch">
									<spring:message code="btn.search"/>
								</button>
							</td>
							
						</tr>
					</table>	
				</div>
				<div style="clear: both;"></div>
				<div class="ibsheet_area_both">
					<script type="text/javascript">createIBSheet("mySheet1", "100%", "300px"); </script>
				</div>
			</form>
		</div>
		<div class="buttons">
			<a href="#" class="btn02" name="closePop">닫기</a>
		</div>	
	</div>

</div>

</body>
</html>