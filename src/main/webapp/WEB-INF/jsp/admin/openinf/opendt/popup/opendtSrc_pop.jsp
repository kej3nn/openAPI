<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="egovframework.common.WiseOpenConfig"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><spring:message code="labal.dtManagement"/>ㅣ<spring:message code="wiseopen.title"/></title>                    
<c:import  url="/WEB-INF/jsp/inc/headinclude.jsp"/>
<style type="text/css">
body{background:none;} /* 임시로 해놓은 것임 */
</style>                                               
<script type="text/javascript">
var tabContentClass= "content";

function setButton(){
	$("button[name=dsSearch]").click(function(){	doAction("search");	return false;	});
	$("a[name=closePop]").click(function(){	window.close();	});
}

$(document).ready(function()    {          
	$("input[name=tableName]").focus();  
	LoadPage();                                                               
	//doAction('search');  처음부터 조회못하도록 막음.. 느림..
	setButton();
	inputEnterKey();

	$("a[name=apply]").click(function(){
		var cRow = popSheet.CheckedRows("delChk");
		if(cRow < 1){
			
			return false;
		}else{
			
			var sheetNm = $("input[name=sheetNm]").val();
			var dtId = $("input[name=dtId]").val();
			var sheetobj = opener.window[sheetNm];
			IBS_Sheet2SheetCheck(popSheet ,sheetobj, "delChk", dtId); 
			//window.close();
		}
	});
});   

// 2개 Sheet에서 데이터 이동하기 (체크 된 데이터만 이동)
function IBS_Sheet2SheetCheck(fromSheet, toSheet, chkCol, dtId)  {
	
	  var duplicateVal = sheet2SheetDupChk(fromSheet, toSheet, chkCol, dtId);	//중복체크 하기 위한 함수(한개만 체크.......)
	 
	  if ( duplicateVal == "" ) {
		//데이터 행의 개수 확인
		
		  var toRow = toSheet.RowCount();
		  fromSheet.Redraw = false;
		  toSheet.Redraw = false;
		  var fromRow = fromSheet.RowCount();
		  //원본에서 역순으로 Check 된 데이터를 확인하여 이동
		  for (var ir = 1; ir<=fromRow; ir++) {
		  //Check 되지 않은 경우 건너뜀
		  	  if (fromSheet.GetCellValue(ir, chkCol) == '0') continue;
			  toRow++;
			  //데이터 행 추가
			  toSheet.DataInsert(toRow);
			  
			  //데이터 옮기기
			  for (var ic = 0; ic<=fromSheet.LastCol(); ic++) {
				//체크 컬럼, 상태 컬럼은 빼고 옮김
				if(ic==0 || ic==1) continue;    
				//시퀀스 설정
				if(ic==2) toSheet.SetCellValue(toRow, 1, toRow);
				//dtId 세팅
				if ( ic == 3 ){
			    	  toSheet.SetCellValue(toRow, ic, dtId);
			      }else{
			    	  var fromSheetVal = fromSheet.GetCellValue(ir,ic);
			    	  toSheet.SetCellValue(toRow, ic, fromSheetVal);
			      }
				toSheet.CheckAll(ic, 0);  
			  }
		  }   
		
		  toSheet.Redraw = true;
		  fromSheet.Redraw = true;
		  
		  
	  } else {
		  alert("중복된 행이 있습니다(" +duplicateVal+ ")");
	  }
}
//IBS 행 중복체크(부모창과 자식창 비교)
function sheet2SheetDupChk(fromSheet, toSheet, chkCol, dtId)  {
	var toSheetVal, fromSheetVal = "";
	var rtnVal = "";
	for (var ir = 1; ir<=toSheet.RowCount(); ir++ ) {
		toSheetVal = toSheet.GetCellValue(ir, "ownTabId");
		for ( var jr = 1; jr<=fromSheet.RowCount(); jr++) {
			if (fromSheet.GetCellValue(jr, chkCol) == '0') continue;
			fromSheetVal = fromSheet.GetCellValue(jr, "ownTabId");
				if ( toSheetVal == fromSheetVal ) {
				rtnVal = toSheetVal;
			}
		}
	}
	
	return rtnVal;
	
}

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
	var gridTitle = "|상태|NO"    
		 gridTitle +="|"+"<spring:message code='labal.dtId'/>";
		 gridTitle +="|"+"<spring:message code='labal.ownTabId'/>";
		 gridTitle +="|"+"<spring:message code='labal.tbNm'/>";
		 gridTitle +="|"+"<spring:message code='labal.tbId'/>";
		 gridTitle +="|"+"<spring:message code='labal.ownerCd'/>";
		 gridTitle +="|"+"<spring:message code='labal.srcTblCd'/>";
		 gridTitle +="|"+"<spring:message code='labal.linkCd'/>";
		 gridTitle +="|"+"<spring:message code='labal.prssCd'/>";
		 gridTitle +="|"+"<spring:message code='labal.loadCd'/>";
		 gridTitle +="|"+"<spring:message code='labal.loadDttm'/>";
                    
    with(popSheet){
    	                     
    	var cfg = {SearchMode:3,Page:50,VScrollMode:1};                       
        SetConfig(cfg);          
        var headers = [                                   
                    {Text:gridTitle, Align:"Center"}
                ];
        var headerInfo = {Sort:0, ColMove:0, ColResize:1, HeaderCheck:1};
        
        InitHeaders(headers, headerInfo);                           
            
        var cols = [          
					{Type:"CheckBox",		SaveName:"delChk",				Width:10,	Align:"Center",		Edit:true						}
					,{Type:"Status",			SaveName:"status",				Width:20,	Align:"Center",		Edit:false, Hidden:true	}
					,{Type:"Seq",				SaveName:"seq",					Width:20,	Align:"Center",		Edit:false					}
					,{Type:"Text",				SaveName:"dtId",					Width:100,	Align:"Center",		Edit:false, Hidden:true	}
					,{Type:"Text",				SaveName:"ownTabId",			Width:80,	Align:"Left",			Edit:false					}
					,{Type:"Text",				SaveName:"tbNm",				Width:80,	Align:"Left",			Edit:false					}
					,{Type:"Text",				SaveName:"tbId",					Width:100,	Align:"Center",		Edit:false, Hidden:true	}
					,{Type:"Text",				SaveName:"ownerCd",			Width:100,	Align:"Center",		Edit:false, Hidden:true	}
					,{Type:"Combo",			SaveName:"srcTblCd",			Width:100,	Align:"Center",		Edit:false, Hidden:true	}
					,{Type:"Combo",			SaveName:"linkCd",				Width:100,	Align:"Center",		Edit:false, Hidden:true	}
					,{Type:"Combo",			SaveName:"prssCd",				Width:100,	Align:"Center",		Edit:false, Hidden:true	}
					,{Type:"Combo",			SaveName:"loadCd",				Width:100,	Align:"Center",		Edit:true, Hidden:true	}
					,{Type:"Date",				SaveName:"ltLoadDttm",		Width:100,	Align:"Center",		Edit:true, Hidden:true	}
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
			var tableName = $("input[name=tableName]").val();
			var owner = $("[name=owner]").val();
			ajaxBeforeSendAdmin("<c:url value='/admin/ajaxBeforeSendAdmin.do'/>"); //IbSheet 조회전 세션 체크
			var param = {PageParam: "ibpage", Param: "onepagerow=50&tableName="+tableName+"&owner="+owner};    
			popSheet.DoSearchPaging("<c:url value='/admin/openinf/opendt/popup/openDtSrcPopList.do'/>", param);
			break;
			
	}
}

</script>
</head>  
<body onload="">
<div class="wrap-popup">
	<!-- 내용 -->
	<div class="container">
		<!-- 상단 타이틀 -->
		<div class="title">
			<h2>테이블 선택</h2>
		</div>
		<!-- 팝업 내용 -->
		<div class="popup" style="padding: 20px;">
		<form name="popOpenDs"  method="post" action="#">
		<input type="hidden" name="sheetNm" value="${sheetNm }"/>
		<input type="hidden" name="dtId" value="${dtId }"/>
			<table class="list01" style="position:relative;">
					<caption>데이터셋 선택</caption>
					<colgroup>
						<col width="150"/>
						<col width=""/>
						<col width="150"/>
						<col width=""/>
						<col width="150"/>
						<col width=""/>
					</colgroup>
					<tr>
						<th>테이블ID</th>
						<td colspan="5">
							<select name="owner">
			                 	<option value="">선택</option>
								<c:forEach var="code" items="${codeMap.ownerCd}" varStatus="status">
								  <option value="${code.ditcCd}">${code.ditcNm}</option>
								</c:forEach>
							</select>
		                 	<input type="text" name="tableName" class="input" placeholder="테이블ID"/>
							<button type="button" class="btn01" name="dsSearch">검색</button>
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
			<a href="#" class="btn03" name="apply">적용</a>
			<a href="#" class="btn02" name="closePop">닫기</a>
		</div>	
	</div>

</div>

</body>
</html>