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
<title><spring:message code="labal.usrManagement"/>ㅣ<spring:message code="wiseopen.title"/></title>                    
<c:import  url="/WEB-INF/jsp/inc/headinclude.jsp"/>
<style type="text/css">
body{background:none;}
</style>
<%
	// 조직정보에서 팝업 띄웠을 경우 name 바꿔서 부모창에 입력하기 위한 변수
	String usrGb = request.getParameter("usrGb") == null ? "" : EgovWebUtil.clearXSSMinimum(request.getParameter("usrGb"));
	String orgCd = request.getParameter("orgCd") == null ? "" : EgovWebUtil.clearXSSMinimum((String)request.getParameter("orgCd"));
	String sheetNm = request.getParameter("sheetNm") == null ? "" : EgovWebUtil.clearXSSMinimum(request.getParameter("sheetNm"));
	
	//검색어를 입력후 검색시 usrnNm에 출력되도록.
	String linkSearch = request.getParameter("linkSearch");
	if(linkSearch != null){
		linkSearch = EgovWebUtil.clearXSSMinimum(new String(linkSearch.getBytes("8859_1"),"UTF-8")); //인코딩 변환
	}else{
		linkSearch = "";
	}
%>
<script language="javascript">           
var tabContentClass= "content";
$(document).ready(function()    { 
	
	//get으로 넘어온 담당자명 검색어 팝업에 저장후 검색
	var linkSearch = $("input[id=linkSearch]").val();
	if(linkSearch != null){
		$("input[name=usrNm]").val(linkSearch);
	}
	
	LoadPage();                                                               
	doAction('search');                                                         
	$("input[name=usrNm]").focus();
	$("a[name=closePop]").click(function(){	window.close();	});		// 팝업창 닫기
	$("button[name=btn_usrSearch]").click(function(e) {	doAction("search");	return false;	});
	inputEnterKey();      
});                                                       
            
function LoadPage()                
{         
    with(mySheet1){
        
    	var cfg = {SearchMode:2,Page:50,VScrollMode:1};                       
        SetConfig(cfg);          
        var headers = [                                   
                    {Text:"NO|부서코드|부서|직원코드|직원명|직책|영문직원명", Align:"Center"}
                ];
        var headerInfo = {Sort:0, ColMove:0, ColResize:1, HeaderCheck:1};
        
        InitHeaders(headers, headerInfo);                           
            
        var cols = [          
					 {Type:"Seq",		SaveName:"seq",				Width:20,	Align:"Center",		Edit:false}
					,{Type:"Text",		SaveName:"orgCd",			Width:0,	Align:"Center",		Edit:false, Hidden:true}
					,{Type:"Text",		SaveName:"orgNm",			Width:100,	Align:"Center",		Edit:false, Hidden:false}
					,{Type:"Text",		SaveName:"usrCd",			Width:0,	Align:"Center",		Edit:false, Hidden:true}
					,{Type:"Text",		SaveName:"usrNm",			Width:60,	Align:"Center",		Edit:false}
					,{Type:"Combo",		SaveName:"jobCd",			Width:60,	Align:"Center",		Edit:false}
					,{Type:"Text",		SaveName:"usrNmEng",		Width:0,	Align:"Center",		Edit:false, Hidden:true}
                                                     
                ];                                                                    
                                      
        InitColumns(cols);                                                                                               
        FitColWidth();                                                                       
        SetExtendLastCol(1);   
        SetColProperty("jobCd",${codeMap.jobCdIbs});
    }
    
    default_sheet(mySheet1);                      
}      
    
/*Sheet 각종 처리*/   

function doAction(sAction)                                  
{
	var usrNm = $("#usrNm").val();
	switch(sAction)
	{          
	                   
		case "search":      //조회   
		                 
			var formParam = $("form[name=adminCommUsrPop]").serialize();   
			ajaxBeforeSendAdmin("<c:url value='/admin/ajaxBeforeSendAdmin.do'/>"); //IbSheet 조회전 세션 체크
			var param = {PageParam: "ibpage", Param: "onepagerow=<%=WiseOpenConfig.IBSHEETPAGENOW%>"}; 
			//mySheet1.DoSearchPaging("<c:url value='/admin/basicinf/popup/commUsrAdminPopList.do'/>", "usrGb=");
			mySheet1.DoSearch("<c:url value='/admin/basicinf/popup/commUsrAdminPosPopList.do'/>" , "usrGb="+$("#usrGb").val()
					+"&usrNm="+usrNm+"&orgCd="+$("#orgCd").val()); 
			
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
    return_pop_adminCommOpenInf();
	
}

function return_pop_adminCommOpenInf(){
	
	var sheetNm = "<%=sheetNm.replaceAll("<", "&lt;").replaceAll(">", "&gt;")%>";
	
	
	var toSheet = opener.window[sheetNm];
	//var toRow = $("input[name=toRow]").val();
	var rowCnt = mySheet1.GetSelectionRows();
	var usrCd = "";
	var usrNm = "";
	var jobCd = "";
	//var cnt = 0;
	
	
	usrCd = mySheet1.GetCellValue(rowCnt, "usrCd");
	usrNm = mySheet1.GetCellValue(rowCnt, "usrNm");
	jobCd = mySheet1.GetCellValue(rowCnt, "jobCd");
	//cnt ++;
	//alert(orgCd);
	//alert(orgNm);
	var row = toSheet.GetSelectionRows();
	toSheet.SetCellValue(row, "usrCd", usrCd);
	toSheet.SetCellValue(row, "usrNm", usrNm); 
	toSheet.SetCellValue(row, "jobCd", jobCd);
	
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


//]]> 
</script>              
</head>
<body onload="">
<div class="wrap-popup">
	<!-- 내용 -->
	<div class="container">
		<!-- 상단 타이틀 -->
		<div class="title">
			<h2>직원 선택</h2>
		</div>
		<!-- 팝업 내용 -->
		<div class="popup" style="padding: 20px;">
			<form name="adminCommUsrPop"  method="post" action="#">
				<input type="hidden" id="usrGb" name="usrGb" value="<%=usrGb.replaceAll("<", "&lt;").replaceAll(">", "&gt;") %>"/>
				<input type="hidden" id="orgCd" name="orgCd" value="<%=orgCd.replaceAll("<", "&lt;").replaceAll(">", "&gt;") %>"/>
				<input type="hidden" id="linkSearch" name="linkSearch" value="<%=linkSearch.replaceAll("<", "&lt;").replaceAll(">", "&gt;")%>"/>
				<div>	
					<table class="list01">
						<colgroup>
							<col width="100"/>
							<col width=""/>
						</colgroup>
						<tr>
							<th>직원명</th>
							<td>
								<input type="text" name="usrNm" id="usrNm" value=""/>
								<button type="button" class="btn01" name="btn_usrSearch">
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