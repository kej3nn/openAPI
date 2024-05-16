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
<style type="text/css">
body{background:none;} /* 임시로 해놓은 것임 */
</style>                                               
<script type="text/javascript">
var tabContentClass= "content";

function setButton(){
	$("button[name=infSearch]").click(function(){
		doAction("search");	return false;	
	});
	
	$("a[name=closePop]").click(function(){	window.close();	});
	
	$("a[name=apply]").bind("click", function(event) {
		doAction("add")	;
	});
	
	$("a[name=applyStts]").bind("click", function(event) {
		doAction("addStts")	;
	});
}

$(document).ready(function()    {          
	LoadPage();                                                               
	doAction('search');    
	setButton();
	inputEnterKey();
	
});   


function inputEnterKey(){
	$("input").keypress(function(e) {
		  if(e.which == 13) {
			  doAction('search');   
			  return false;
		  }
	});
	
}  

function LoadPage()                
{
	var gridTitle = "NO";
		 gridTitle +="|선택";
		 gridTitle +="|통계표 ID";
		 gridTitle +="|통계표명(숨김)";
		 gridTitle +="|통계표 한글명";
                    
    with(popSheet){
    	                     
    	var cfg = {SearchMode:2,Page:50};                       
        SetConfig(cfg);          
        var headers = [                                   
                    {Text:gridTitle, Align:"Center"}
                ];
        var headerInfo = {Sort:0, ColMove:0, ColResize:1, HeaderCheck:0};
        
        InitHeaders(headers, headerInfo);                           
            
        var cols = [          
					{Type:"Seq",				SaveName:"no",				Width:20,	Align:"Center",		Edit:false					}
					,{Type:"CheckBox",			SaveName:"chkbox",			Width:30,	Align:"Center",		Edit:true					}
					,{Type:"Text",				SaveName:"statblId",		Width:70,	Align:"Center",		Edit:false,	Hidden:false	}
					,{Type:"Text",				SaveName:"statblNm",		Width:70,	Align:"Center",		Edit:false,	Hidden:true		}
					,{Type:"Html",				SaveName:"statblNmExp",		Width:120,	Align:"Left",		Edit:false					}
                ];                                                                    
                                      
        InitColumns(cols);                                                                                               
        FitColWidth();                                                                       
        SetExtendLastCol(1);   
    }                   
    default_sheet(popSheet);                      
}

/*Sheet 각종 처리*/                  
function doAction(sAction)                                  
{
	var classObj = $("."+tabContentClass); //tab으로 인하여 form이 다건임
	var actObj = setTabForm(classObj); // 0: form data, 1: form 객체
	switch(sAction)
	{          
		case "search":      //조회   
			var infNm = $("input[name=infNm]").val();
			ajaxBeforeSendAdmin("<c:url value='/admin/ajaxBeforeSendAdmin.do'/>"); //IbSheet 조회전 세션 체크
			var param = {PageParam: "ibpage", Param: "onepagerow=50"+ "&" + $("form[name=popOpenDs]").serialize() };
			popSheet.DoSearchPaging("<c:url value='/admin/stat/selectSttsTblPopList.do'/>", param);
			break;
		case "add" :
			addTbl();
			break;
	}
}

function addTbl() {
	var parSheet = opener.parent.doActionTblSheet('getSheet');		// 부모창 시트
	
	var strChkRows = popSheet.FindCheckedRow("chkbox");
	var chkRows = strChkRows.split('|');
	
	if ( gfn_isNull(strChkRows) ) {
		alert("추가할 통계표를 선택하세요.");
		return false;
	}
	
	if ( !confirm("통계표를 추가 하시겠습니까?\n중복되는 통계표는 추가되지 않습니다.") ) {
		return;
		}

	for ( var i=0; i < chkRows.length; i++ ) {
		//제일 마지막 행에 추가
		var newRow = parSheet.DataInsert(-1);	
		parSheet.SetCellValue(newRow, "relStatblId", popSheet.GetCellValue(chkRows[i], "statblId"));
		parSheet.SetCellValue(newRow, "relStatblNm", popSheet.GetCellValue(chkRows[i], "statblNm"));
		parSheet.SetCellValue(newRow, "useYn", 'Y');
	}
	
	// 중복된 통계표 ID 확인하여 제거함
	while ( parSheet.ColValueDup("relStatblId") > -1 ) {
		parSheet.RowDelete(parSheet.ColValueDup("relStatblId"));
	}
	
	parSheet.ReNumberSeq();			// 시트 seq 초기화
	
	window.close();
}

</script>
</head>  
<body onload="">
<div class="wrap-popup">
	<!-- 내용 -->
	<div class="container">
		<!-- 상단 타이틀 -->
		<div class="title">
			<h2>대상 통계표 선택</h2>
		</div>
		<!-- 팝업 내용 -->
		<div class="popup">
		<form name="popOpenDs"  method="post" action="#">
			<input type="hidden" id="statblId" name="statblId" value="${param.statblId}" />
			<table class="list01" style="position:relative;">
					<caption>통계표 선택</caption>
					<colgroup>
						<col width="150"/>
						<col width=""/>
						<col width="150"/>
						<col width=""/>	
						<col width="150"/>
						<col width=""/>
					</colgroup>
					<tr>
						<th><label class="">통계표 명</label></th>
						<td colspan="5">
							<select name="searchGubun">
								<option value="STATBL_NM">통계표 한글명</option>
							</select>
		                 	<input type="text" name="searchVal" class="input" />
							<button type="button" class="btn01" name="tblSearch">검색</button>
						</td>
					</tr>
				</table>
			</form>	
			<div style="clear: both;"></div>
			<div class="ibsheet_area_both">
				<script type="text/javascript">createIBSheet("popSheet", "100%", "300px"); </script>
			</div>
		</div>
		<div class="buttons">
		<c:choose>
			<c:when test="${ param.bbsCd eq 'STTSCT' }">
				<a href="#" class="btn03" name="applyStts">상세분석 통계표추가</a>
				<a href="#" class="btn03" name="apply">관련 통계표추가</a>
			</c:when>
			<c:otherwise>
				<a href="#" class="btn03" name="apply">추가</a>
			</c:otherwise>
		</c:choose>
			<a href="#" class="btn02" name="closePop">닫기</a>
		</div>	
	</div>

</div>

</body>
</html>