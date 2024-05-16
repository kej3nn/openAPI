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
var popObj = "form[name=statsStddItmPopup]";
 
$(document).ready(function()    {
	bindEvent();
	LoadStatStddItmSheet();
	bindParam();
	if ( !'${param.gb}' ) {
		alert("잘못된 접근입니다.");	
	}
});
 
function bindEvent() {
	$(popObj).find("a[name=a_close]").click(function(e) { 
		parent.doActionMst("popClose");
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
	
	$(popObj).find("a[name=a_apply]").click(function(e) {             
		doAction("apply");  
		return false;                
	}); 
	
	$(popObj).find("select[name=allLevel]").click(function(e) {
		$("#applyCd02").prop("checked", true);    
	}); 
	
	// 트리 관계모드 사용자 선택처리
	$(popObj).find("#treeActionMode").click(function(e) {
		if ( $(this).is(":checked") ) {
			stddItmPopSheet.SetTreeCheckActionMode(1);
		}
		else {
			stddItmPopSheet.SetTreeCheckActionMode(0);
		}
	});
	
}

function bindParam() {
	var pLevel = Number($("#level").val());
	var maxLevel = Number($("#maxLevel").val());
	var checkedRowVal = $("#checkedRows").val();	//항목 추가할 부모 row 행(체크된 행 파라미터로 전달 받음)
	var checkedRows = checkedRowVal.split("|");
	if ( pLevel == 0 ) {
		$("#fixParItmNm").text("없음");
		$("#fixLevel").val("1");
		$("select[name=allLevel]").append("<option value='1'>1레벨</option>");
	} else {
		if ( checkedRowVal.indexOf("|") > -1 ) {	//항목 선택하여 팝업창 들어오는 경우
			$("#fixParItmNm").text($("#viewItmNm").val() + " 외 " + checkedRows.length + "개");
		} else {
			$("#fixParItmNm").text($("#viewItmNm").val());
		}

		$("#fixLevel").val(pLevel);
		$("select[name=allLevel]").append("<option value='0'>최상위</option>");
		for (var i=0; i < maxLevel; i++) {
			$("select[name=allLevel]").append("<option value='"+Number(i+1)+"'>"+Number(i+1)+"레벨</option>"); 
		}
		
	}
}

//시트초기화
function LoadStatStddItmSheet() {
	
	createIBSheet2(document.getElementById("statsStddItmPopSheet"), "stddItmPopSheet", "100%", "300px");
	
	var gridTitle ="NO";
		gridTitle +="|항목분류ID";
		gridTitle +="|한글표준항목명";
		gridTitle +="|영문표준항목명";
		gridTitle +="|분류레벨";
		gridTitle +="|전체분류명";
		
    with(stddItmPopSheet){
    	                     
    	var cfg = {SearchMode:smLazyLoad, MergeSheet:msHeaderOnly, VScrollMode:1, TreeNodeIcon:2, ChildPage:5};
        SetConfig(cfg);
        var headers = [
                    {Text:gridTitle, Align:"Center"}
                ];
        var headerInfo = {Sort:0,ColMove:1,ColResize:1,HeaderCheck:0};
        
        InitHeaders(headers, headerInfo);
       
        var cols = [
                     {Type:"Seq",		SaveName:"seq",				Width:30,	Align:"Center",		Edit:false}
					,{Type:"Int",		SaveName:"itmId",			Width:70,	Align:"Center",		Edit:false,	Hidden:true}
					,{Type:"Text",		SaveName:"itmNm",			Width:200,	Align:"Left",		Edit:false, TreeCol:1,	TreeCheck:1, LevelSaveName:"TREELEVEL"}
					,{Type:"Text",		SaveName:"engItmNm",		Width:150,	Align:"Left",		Edit:false}
					,{Type:"Int",		SaveName:"Level",			Width:50,	Align:"Center",		Edit:false}
					,{Type:"Text",		SaveName:"itmFullnm",		Width:160,	Align:"Left",		Edit:false, Hidden:true}
                ];                                          
        InitColumns(cols);
        FitColWidth();
        SetTreeCheckActionMode(1);
        SetExtendLastCol(1);
        
        SetCountPosition(0);
    }               
    default_sheet(stddItmPopSheet);   
    
    doAction("search");
} 

//각족 action 함수
function doAction(sAction) {
	
	var formObj = $("form[name=statsStddItmPopup]");  
	switch(sAction) {
		case "search" :
			ajaxBeforeSendAdmin("<c:url value='/admin/ajaxBeforeSendAdmin.do'/>"); //IbSheet 조회전 세션 체크
			var param = {PageParam: "ibpage", Param: "onepagerow=50"+"&"+formObj.serialize()};
			stddItmPopSheet.DoSearchPaging("<c:url value='/admin/stat/popup/selectStatStddItmPopup.do'/>", param);
			break;
		case "apply" :
			var checkedRowVal = $("#checkedRows").val();			//항목 추가할 부모 row 행(체크된 행 파라미터로 전달 받음)
			var chkRows = stddItmPopSheet.FindCheckedRow("itmNm");	//체크한 rows
			var chkArr = chkRows.split('|');
			if ( chkRows == "" ) {
				alert("추가할 행을 선택해 주세요.")
				return false;
			}
			
			var cnt = 0;
			var pLevel = Number($("#level").val());			//레벨(파라미터 값)
			var maxDatano = Number($("#maxDatano").val());	//마지막 데이터번호
			var selDatano = Number($("#selDatano").val());	//선택한 데이터번호
			
			var jData = new Object();	//부모창에 넘겨줄 Obj
			var jList = new Array();	//트리 목록 obj
			var jRow = null;
			
			//특정항목인지 동일레벨인지 화면에서 선택한 코드
			var applyCd = $("input[name=applyCd]:checked").val();	
			if ( checkedRowVal.indexOf("|") > -1 ) {	//항목 선택하여 팝업창 들어오는 경우
				applyCd = "FIX_CHK";
			}
			var applyLvl = 0;
			if ( applyCd == "FIX" ) {
				applyLvl = $("#fixLevel").val();
			} else if ( applyCd == "ALL" ) {
				applyLvl = $("select[name=allLevel]").val();	
			}
			jData.gb = applyCd;				//특정항목인지 동일항목적용인지..(FIX/FIX_CHK/ALL) 선택항목 하위, 선택항목들(여러개) 하위, 동일 레벨 일괄 적용
			jData.gbLvl = Number(applyLvl);	//적용하는 레벨이 뭔지
			jData.selDatano = selDatano;		//항목구성 시트에서 선택한 자료번호
			
			for ( var c in chkArr ) {
				//선택한 레벨
				var _level = Number(stddItmPopSheet.GetCellValue(chkArr[c], stddItmPopSheet.SaveNameCol("Level")));
				if ( _level > 1 ) {
					jRow = stddItmPopSheet.GetRowData(chkArr[c]);
					jRow.datano = Number(++cnt + maxDatano);	//데이터번호 순차적 증가
					jRow.Level = Number((pLevel == 0 ? 0 : applyLvl)) + (_level - 1);
					jList.push(jRow);
				}
			}
			
			jData.data = jList;	//실 data
			
			var parentFormNm = $("#parentFormNm").val();
			var parentObj = window.parent.$("form[name="+ parentFormNm +"]");
			
			parentObj.find("input[name=${param.gb}Json]").val(JSON.stringify(jData));
			parent.doActionItmSheet("put", '${param.gb}');	//창닫고 항목 sheet에 넣기
			break;
	}
}

/**
 * 부모 노드에서 트리 확장기능을 선택했을 때 이벤트가 발생(선택한 하위 노드 조회한다.)
 */
function stddItmPopSheet_OnTreeChild(row) {
	var itmId = stddItmPopSheet.GetCellValue(row, "itmId");
	//하위 노드 조회(동기 방식으로 -> 선택한 노드 하위 체크하기 위해서)
	stddItmPopSheet.DoSearchChild(row, com.wise.help.url("/admin/stat/popup/selectStatStddItmPopup.do"), "parItmId="+itmId, {wait: 1, Sync: 2});	
	
	//stddItmPopSheet.SetTreeCheckValue(row, 1);	//하위 항목 체크상태로 변경
	stddItmPopSheet.SetRowExpanded(row, 1);		//하위 항목 전체 펼침
	
}

</script>                
<body>
<form name="statsStddItmPopup" method="post" action="#">
	<input type="hidden" id="gb" value="${param.gb}"/>
	<input type="hidden" id="parentFormNm" value="${param.parentFormNm}"/>
	<input type="hidden" id="maxDatano" value=${param.maxDatano}>
	<input type="hidden" id="selDatano" value=${param.selDatano}>
	<input type="hidden" id="viewItmNm" value="${param.viewItmNm}"/>
	<input type="hidden" id="level" value=${param.level}>
	<input type="hidden" id="maxLevel" value=${param.maxLevel}>
	<input type="hidden" id="checkedRows" value=${param.checkedRows}>
	<div class="popup">
		<h3>표준항목 선택</h3>
		<a href="#" class="popup_close" onclick="parent.doActionMst('popClose')">x</a>
		<div style="overflow-y:auto;height:645px;padding:0 15px;margin:15px 0;">
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
							<option value="ITM_NM">한글표준항목명</option>
							<option value="ENG_ITM_NM">영문표준항목명</option>
						</select>
						<input type="text" id="searchVal" name="searchVal" value="" width="70%"/>
					</td>
				</tr>
			</table>
			<div align="right">
				<input type="checkbox" id="treeActionMode" checked="checked"/><label for="treeActionMode">관계모드(트리)</label>&nbsp;&nbsp;&nbsp;
				<button type="button" class="btn01" title="검색" name="btn_search">검색</button>
			</div>
			
			<div class="ibsheet_area" id="statsStddItmPopSheet">
			</div>
			
			<table class="list01">              
			<colgroup>
				<col width="28%"/>
				<col width="18%"/>
				<col width="18%"/>
				<col width="18%"/>
				<col width="18%"/>
			</colgroup>
				<tr>
					<th rowspan="2">선택 항목 하위 적용</th>
					<td colspan="4">
						<input type="radio" id="applyCd01" name="applyCd" value="FIX" checked="checked">적용</input>
					</td>
				</tr>
				<tr>
					<th>선택 항목</th>
					<td colspan="4">
						<span id="fixParItmNm"></span>
						<input type="hidden" id="fixLevel" />
					</td>
				</tr>
				<tr>
					<th rowspan="2">동일 레벨 일괄 적용</th>
					<td colspan="4">
						<input type="radio" id="applyCd02" name="applyCd" value="ALL">적용</input>
					</td>
				</tr>
				<tr>
					<th>하위 레벨</th>
					<td colspan="3">
						<select name="allLevel" style="width: 70%">
						</select>
					</td>
				</tr>
			</table>
			
			<div class="buttons" style="padding-bottom:15px;">
				<a href="#" class="btn03" title="적용" name="a_apply">적용</a>
				${sessionScope.button.a_close}
			</div>         
		</div>
	</div>
</form>
</body>
</html>                             