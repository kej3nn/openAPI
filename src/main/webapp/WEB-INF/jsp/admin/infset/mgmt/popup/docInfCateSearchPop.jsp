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
var popObj = "form[name=statsCatePopup]";
 
$(document).ready(function()    {
	bindEvent();
	LoadStatMetaSheet();
});
 
function bindEvent() {
	$(popObj).find("a[name=a_close]").click(function(e) { 
		//parent.doActionMst("popClose");
		parent.closeIframePop("iframePopUp");
		return false;                
	});
	
	$(popObj).find(".popup_close").click(function(e) {             
		$(popObj).find("a[name=a_close]").click();
		return false;                
	}); 
	
	$(popObj).find("button[name=btn_search]").click(function(e) { 
		doAction("search");                
		return false;                
	});
	
	$(popObj).find("input").keypress(function(e) {                   
		  if(e.which == 13) {
			  doAction('search');   
			  return false; 
		  }
	});
	
	// 추가
	$(popObj).find("a[name=a_add]").bind("click", function(e) {
		addCate();
		return false;
	})
 }

//시트초기화
function LoadStatMetaSheet() {
	
	createIBSheet2(document.getElementById("statsCatePopSheet"),"catePopSheet", "100%", "300px");
	
	var gridTitle ="NO";
		/* gridTitle +="|선택"; */
		gridTitle +="|항목분류ID";
		gridTitle +="|분류명";
		gridTitle +="|분류레벨";
		gridTitle +="|전체분류명";
		
    with(catePopSheet){
    	                     
    	var cfg = {SearchMode:2, Page:50, VScrollMode:1, TreeNodeIcon:2};
        SetConfig(cfg);
        var headers = [
                    {Text:gridTitle, Align:"Center"}
                ];
        var headerInfo = {Sort:0,ColMove:1,ColResize:1,HeaderCheck:1};
        
        InitHeaders(headers, headerInfo);
       
        var cols = [
                     {Type:"Seq",		SaveName:"seq",				Width:30,	Align:"Center",		Edit:false}
					,{Type:"Text",		SaveName:"cateId",			Width:80,	Align:"Center",		Edit:false}
					,{Type:"Text",		SaveName:"cateNm",			Width:300,	Align:"Left",		Edit:false,	TreeCol:1, TreeCheck:1, CheckSaveName: "chk"}
					,{Type:"Int",		SaveName:"Level",			Width:50,	Align:"Center",		Edit:false}
					,{Type:"Text",		SaveName:"cateFullnm",		Width:150,	Align:"Left",		Edit:false,	Hidden:true}
                ];                                          
        InitColumns(cols);
        FitColWidth();
        SetTreeCheckActionMode(0);
        SetExtendLastCol(1);
    }               
    default_sheet(catePopSheet);   
    
    doAction("search");
} 

// 시트 더블클릭시
/* 
function catePopSheet_OnDblClick(row, col, value, cellx, celly) {
	if(row == 0) return;  
	var arrayValue;
	
	arrayValue = {
			cateId : catePopSheet.GetCellValue(row, "cateId"),
			cateNm : catePopSheet.GetCellValue(row, "cateNm")
	}
	
	// 부모 폼으로 arrayValue에 있는 값을 넘겨준다.
	var parentFormNm = $("#parentFormNm").val();
	var parentObj = window.parent.$("form[name="+ parentFormNm +"]");
		           
	$.each(arrayValue,function(key,state){
		parentObj.find("[name="+key+"]").val(state);
	}); 
	
	//parent.doActionMst("popClose");	//창닫기
	parent.closeIframePop("iframePopUp");
}
 */
function addCate() {

	var parentFormNm = $("#parentFormNm").val();
	var parentObj = window.parent.$("form[name="+ parentFormNm +"]");
	
 	var strChkRows = catePopSheet.FindCheckedRow("cateNm");
 	if ( gfn_isNull(strChkRows) ) {
 		alert("추가하려는 분류체계를 선택하세요.");
 		return false;
 	}
 	
	var chkRows = strChkRows.split('|');
	var arrCateId = [];
	var arrCateNm = [];
	
	for ( var i=0; i < chkRows.length; i++ ) {
		arrCateId.push(catePopSheet.GetCellValue(chkRows[i], "cateId"));
		arrCateNm.push(catePopSheet.GetCellValue(chkRows[i], "cateNm"));
	}

	if ( arrCateId.length > 0 ) {
		parentObj.find("[name=cateId]").val(arrCateId[0]);
		parentObj.find("[name=cateIds]").val(arrCateId.join(","));
		parentObj.find("[name=cateNm]").val(arrCateNm.join(","));
	} 
	else {
		parentObj.find("[name=cateId]").val("");
		parentObj.find("[name=cateIds]").val("");
		parentObj.find("[name=cateNm]").val("");
	}
	
	parent.closeIframePop("iframePopUp");
}

//각족 action 함수
function doAction(sAction) {
	
	var formObj = $("form[name=statsCatePopup]");  
	
	switch(sAction) {
		case "search" :
			ajaxBeforeSendAdmin("<c:url value='/admin/ajaxBeforeSendAdmin.do'/>"); //IbSheet 조회전 세션 체크
			var param = {PageParam: "ibpage", Param: "onepagerow=50"+"&"+formObj.serialize()};
			catePopSheet.DoSearchPaging("<c:url value='/admin/infs/doc/popup/selectDocInfCatePop.do'/>", param);
			break;
	}
}

function catePopSheet_OnSearchEnd(code, message, statusCode, statusMessage) {
	doAjax({
		url : "/admin/stat/statSttsTblCateList.do",
		params : "statblId=" + $("#statblId").val(),
		callback : function(res) {
			var cateId = "";
			var data = res.data;
			
			var parentChkcked = $("#cateId").val().split(",");
			if ( !gfn_isNull($("#cateId").val())  ) {
				for ( var r in parentChkcked ) {
					data.push({ statblId: $("#statblId").val(), cateId: parentChkcked[r] });
				}
			}
			
			for ( var r in data ) {
				cateId = data[r].cateId;
				for ( var i=0; i < catePopSheet.RowCount(); i++ ) {
					if ( cateId == catePopSheet.GetCellValue(i, "cateId") ) {
						catePopSheet.SetTreeCheckValue(i, 1);
					}
				}
			}
		}
	});
}


</script>                
<body>
<form name="statsCatePopup"  method="post" action="#">
	<input type="hidden" id="parentFormNm" value="${param.parentFormNm}"/>
	<input type="hidden" id="statblId" value="${param.statblId}"/>
	<input type="hidden" id="cateId" value="${param.cateId}"/>
	<div class="popup">
		<h3>분류선택 팝업</h3>
		<a href="#" class="popup_close">x</a>
		<div style="padding:15px;">
			<!-- <p class="text-title">조회조건</p> -->
			<table class="list01">              
			<colgroup>
				<col width="150"/>
				<col width=""/>
			</colgroup>
				<tr>
					<th>검색어</th>
					<td>
						<select id="searchGubun" name="searchGubun">
							<option value="CATE_NM">한글분류명</option>
							<option value="ENG_CATE_NM">영문분류명</option>
						</select>
						<input type="text" id="searchVal" name="searchVal" value="" width="70%"/>
					</td>
				</tr>
			</table>
			<div align="right">
				<button type="button" class="btn01" title="검색" name="btn_search">검색</button>
			</div>
			
			<div class="ibsheet_area" id="statsCatePopSheet">
			</div>
			
			<div class="buttons">
				${sessionScope.button.a_add}
				${sessionScope.button.a_close}
			</div>         
		</div>
	</div>
</form>
</body>
</html>                             