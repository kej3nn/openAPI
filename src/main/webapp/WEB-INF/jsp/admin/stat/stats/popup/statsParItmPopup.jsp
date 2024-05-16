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
</head>                                                
<style type="text/css">
body{background:none;}                                     
</style>                  
<script language="javascript">                
var popObj = "form[name=form]";
var selectGubun = "I";

$(document).ready(function()    {
	bindEvent();
	loadPage();
	$("input[name=searchVal]").focus();
});
 
function bindEvent() {
	$(popObj).find("a[name=a_close]").click(function(e) { 
		parent.closeIframePop("iframePopUp");
		return false;                
	});
	
	$(popObj).find(".popup_close").click(function(e) {             
		$(popObj).find("a[name=a_close]").click();
		return false;                
	}); 
	
	$(popObj).find("button[name=btn_topLevel]").click(function(e) { 
		setTopLevel();              
		return false;                
	});
	
	$(popObj).find("button[name=treeOpen]").click(function(e) { 
		doAction("treeOpen");              
		return false;                
	});
	
	$(popObj).find("button[name=treeClose]").click(function(e) { 
		doAction("treeClose");              
		return false;                
	});
	
	
 }

//시트초기화
function loadPage() {
	
	createIBSheet2(document.getElementById("sheet"),"sheet", "100%", "400px");
	
	var gridTitle ="NO";
		gridTitle +="|자료\n번호";
		gridTitle +="|시트항목명";
		gridTitle +="|영문출력항목명";
		
    with(sheet){
    	                     
    	var cfg = {SearchMode:2,Page:50,VScrollMode:1,ChildPage: 20};
        SetConfig(cfg);
        var headers = [
                    {Text:gridTitle, Align:"Center"}
                ];
        var headerInfo = {Sort:0, ColMove:0, ColResize:1};
        
        InitHeaders(headers, headerInfo);
       var cols = [          
					  {Type:"Seq",		SaveName:"seq",				Width:0,	Align:"Center",		Edit:false}
					 ,{Type:"Int",		SaveName:"datano",			Width:60,	Align:"Center",		Edit:false,	Format:"#####"}
					 ,{Type:"Text",		SaveName:"viewItmNm",		Width:230,	Align:"Left",		Edit:false,	TreeCol:1}
					 ,{Type:"Text",		SaveName:"engViewItmNm",	Width:60,	Align:"Left",		Edit:false,	Hidden:true}
               ];  
        InitColumns(cols);
        FitColWidth();
        SetExtendLastCol(1);
    }               
    default_sheet(sheet);   
    
    doAction("search");
} 

//action 함수
function doAction(sAction) {
	
	var formObj = $("form[name=form]");  
	
	switch(sAction) {
		case "search":      //조회   
			ajaxBeforeSendAdmin(com.wise.help.url("/admin/ajaxBeforeSendAdmin.do")); //IbSheet 조회전 세션 체크
			var param = {PageParam: "ibpage", Param: "onepagerow=50&" + formObj.serialize()};
			sheet.DoSearchPaging(com.wise.help.url("/admin/stat/selectStatsTblItmList.do"), param);
			break;
		case "treeOpen" :	//트리 전체 펼치기
			sheet.ShowTreeLevel(-1);
			break;	
		case "treeClose" :	//트리 전체 접기
			sheet.ShowTreeLevel(0);
	}
}
     
//시트 더블클릭 선택시
function sheet_OnDblClick(row, col, value, cellx, celly) {
    if(row == 0) return;
    
    if ( gfn_isNull($("#datano").val()) ) return;
    
    var selectGubun = "itm";

    var parentRow = sheet.FindText("datano", $("#datano").val());		// 부모 행 위치 찾기
    
    var parentChildRows = sheet.GetChildRows(parentRow).split('|');		// 부모의 하위자식행들 조회
    
    if ( parentRow == row ) {
    	
    	alert("자기 자신은 선택할 수 없습니다.");
    }
    else if ( $.inArray(String(row), parentChildRows) != -1 ) {
    	
    	alert("부모행이 자식행으로 변경될 수 없습니다.");
    }
    else {
		var arrayValue;
    	
    	if ( "${param.gb}" === "I" ) {
    		selectGubun = "itm";
        	arrayValue = {
       			itmParDatano : sheet.GetCellValue(row, "datano")
        	}
        } else if ( "${param.gb}" === "C" ) {
        	selectGubun = "cate";
        	arrayValue = {
       			cateParDatano : sheet.GetCellValue(row, "datano")
        	}
        } else if ( "${param.gb}" === "G" ) {
        	selectGubun = "group";
        	arrayValue = {
       			groupParDatano : sheet.GetCellValue(row, "datano")
        	}
        } else {
        	arrayValue = {
       			parDatano : sheet.GetCellValue(row, "datano")
        	}
        }
    	
    	// 부모 폼으로 arrayValue에 있는 값을 넘겨준다.
    	var parentFormNm = $("#parentFormNm").val();
    	var parentObj = window.parent.$("form[name="+ parentFormNm +"]");
    		           
    	$.each(arrayValue,function(key,state){
    		parentObj.find("[name="+key+"]").val(state);
    	}); 
    	
    	parent.doActionItmSheet("confirm", selectGubun);	// 부모 시트에 반영
    	
    	parent.closeIframePop("iframePopUp");
    }
       
} 

function setTopLevel() {
	
	if ( !confirm("최상위 항목으로 설정하시겠습니까?") ) {
		return false;	
	}
	var selectGubun = "itm";
	
	if ( "${param.gb}" === "I" ) {
		selectGubun = "itm";
    	arrayValue = {
   			itmParDatano : 0
    	}
    } else if ( "${param.gb}" === "C" ) {
    	selectGubun = "cate";
    	arrayValue = {
   			cateParDatano : 0
    	}
    } else if ( "${param.gb}" === "G" ) {
    	selectGubun = "group";
    	arrayValue = {
    		groupParDatano : 0
    	}
    } else {
    	arrayValue = {
   			parDatano : 0
    	}
    }
	
	// 부모 폼으로 arrayValue에 있는 값을 넘겨준다.
	var parentFormNm = $("#parentFormNm").val();
	var parentObj = window.parent.$("form[name="+ parentFormNm +"]");
		           
	$.each(arrayValue,function(key,state){
		parentObj.find("[name="+key+"]").val(state);
	}); 
	
	parent.doActionItmSheet("confirm", selectGubun);	// 부모 시트에 반영
	
	parent.closeIframePop("iframePopUp");
}

function sheet_OnSearchEnd(code, msg)
{
   if(msg != "")
	{                
	    alert(msg);
    }
}
</script>                
<body>
<form name="form"  method="post" action="#">
	<input type="hidden" id="parentFormNm" value="${param.parentFormNm}"/>
	<input type="hidden" name="statblId" id="statblId" value="${param.statblId}">
	<input type="hidden" name="gb" id="gb" value="${param.gb}">
	<input type="hidden" name="datano" id="datano" value="${param.datano}">
	<div class="popup">
		<h3>통계표 항목/분류 팝업</h3>
		<a href="#" class="popup_close">x</a>
		<div style="padding:15px;">
			<%-- <table class="list01">              
			<colgroup>
				<col width="150"/>
				<col width=""/>
			</colgroup>
				<tr>
					<th>검색어</th>
					<td>
						<select id="searchGubun" name="searchGubun">
							<option value="VIEW_ITM_NM">한글 항목명</option>
							<option value="ENG_VIEW_ITM_NM">영문 항목명</option>
						</select>
						<input type="text" id="searchVal" name="searchVal" value="" width="70%"/>
					</td>
				</tr>
			</table> --%>
			<div align="right">
				<button type="button" class="btn01" name="treeOpen">펼치기</button>
				<button type="button" class="btn01" name="treeClose">접기</button>
			</div>
			
			<div class="ibsheet_area" id="sheet">
			</div>
			
			<div class="buttons">
			<button type="button" class="btn01" title="검색" name="btn_topLevel" style="margin-bottom: 3px;">최상위 레벨설정</button>
				${sessionScope.button.a_close}
			</div>         
		</div>
	</div>
</form>
</body>
</html>                             