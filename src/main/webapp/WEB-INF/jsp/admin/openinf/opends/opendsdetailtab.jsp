<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="egovframework.common.WiseOpenConfig"%>
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
<validator:javascript formName="adminOpenDs" staticJavascript="false" xhtml="true" cdata="false"/>       
<script language="javascript">                
//<![CDATA[                              


           
function LoadDetail(sheetName){
   var gridTitle2 = "상태|삭제|NO";
       gridTitle2 +="|"+"<spring:message code='labal.srcColId'/>"; 
       /* gridTitle2 +="|"+"<spring:message code='labal.srcColNm'/>"; */
       gridTitle2 +="|"+"<spring:message code='labal.srcColSize'/>";
       gridTitle2 +="|"+"<spring:message code='labal.srcColScale'/>";
       gridTitle2 +="|"+"<spring:message code='labal.srcColType'/>";
       gridTitle2 +="|"+"<spring:message code='labal.colSeq'/>";
       gridTitle2 +="|"+"<spring:message code='labal.dsId'/>";
       gridTitle2 +="|"+"<spring:message code='labal.dataTypeLeng'/>";
       gridTitle2 +="|"+"<spring:message code='labal.colId'/>"; 
       /* gridTitle2 +="|"+"<spring:message code='labal.colNm'/>"; */
       gridTitle2 +="|"+"<spring:message code='labal.colAttNm'/>";
       /* gridTitle2 +="|"+"<spring:message code='labal.colNmEng'/>"; */
       gridTitle2 +="|"+"<spring:message code='labal.unitCd'/>";
       gridTitle2 +="|"+"주소컬럼";
       /* gridTitle2 +="|"+"<spring:message code='labal.statYn'/>"; */
       gridTitle2 +="|"+"Open API 주석";
        gridTitle2 +="|"+"재정용어";
       gridTitle2 +="|"+"<spring:message code='labal.useYn'/>";
   
   with(sheetName){
      
     var cfg = {SearchMode:2,Page:50,VScrollMode:1};                                
      SetConfig(cfg);  
      var headers = [                               
                  {Text:gridTitle2, Align:"Center"}                 
              ];
      var headerInfo = {Sort:0,ColMove:1,ColResize:1,HeaderCheck:1};
      
      InitHeaders(headers, headerInfo); 
      SetEditable(1);
       
      var cols = [          
                {Type:"Status",   SaveName:"status",            Width:30,   Align:"Center",      Edit:false}
               ,{Type:"DelCheck",      SaveName:"delChk",         Width:40,   Align:"Center",      Edit:true}
               ,{Type:"Int",      SaveName:"vOrder",            Width:30,   Align:"Center",      Edit:false}
               ,{Type:"Text",      SaveName:"srcColId",         Width:100,   Align:"Left",      Edit:false , KeyField:1}
               ,{Type:"Text",      SaveName:"srcColSize",         Width:80,   Align:"Center",      Edit:false,      Hidden:true}
               ,{Type:"Text",      SaveName:"srcColScale",         Width:80,   Align:"Center",      Edit:false,      Hidden:true}
               ,{Type:"Text",      SaveName:"srcColType",         Width:100,   Align:"Center",      Edit:false,    Hidden:true}
               ,{Type:"Text",      SaveName:"colSeq",            Width:100,   Align:"Center",      Edit:false,      Hidden:true}
               ,{Type:"Text",      SaveName:"dsId",            Width:100,   Align:"Center",      Edit:false, Hidden:true}
               ,{Type:"Text",      SaveName:"dataTypeLeng",      Width:100,   Align:"Center",      Edit:false}
                ,{Type:"Text",      SaveName:"colId",            Width:100,   Align:"Left",      Edit:true , KeyField:1} 
               ,{Type:"Text",      SaveName:"colNm",            Width:100,   Align:"Left",      Edit:true , }
               ,{Type:"Combo",      SaveName:"unitCd",            Width:50,   Align:"Center",      Edit:true , Hidden:false}
               ,{Type:"Combo",      SaveName:"jsCd",            Width:50,   Align:"Center",      Edit:true , Hidden:false}
               ,{Type:"Text",         SaveName:"colExp",            Width:100,   Align:"Left",      Edit:true} 
                ,{Type:"Text",            SaveName:"termSeq",         Width:100,   Align:"Left",      Edit:true, Hidden:true} 
               ,{Type:"CheckBox",      SaveName:"useYn",         Width:40,   Align:"Center",      TrueValue:"Y", FalseValue:"N", Edit:true}
              ];         
                                    
      InitColumns(cols);                                                                           
      FitColWidth();                                                         
      SetExtendLastCol(1);   
      SetColProperty("unitCd",    ${codeMap.unitCdIbs});
      SetColProperty("jsCd",    ${codeMap.jsCdIbs});
  }
      default_sheet(sheetName);
   
}
	 
function doSheetAction(sAction){

var classObj = $("."+"content").eq(1); //tab으로 인하여 form이 다건임
var actObj = setTabForm(classObj); // 0: form data, 1: form 객체
var sheetObj; //IbSheet 객체         
var objTab = getTabShowObj();//탭이 oepn된 객체가져옴
var formObj = classObj.find("form[name=adminOpenDs]");

sheetObj ="sheetName"; 

//var sheetObj2=sheetObj+"table";
var sheetObj2 = "sheetName";

ajaxBeforeSendAdmin("<c:url value='/admin/ajaxBeforeSendAdmin.do'/>"); //IbSheet 조회전 세션 체크

var gridObj = window[sheetObj];
var gridObj2 = window[sheetObj2];
switch(sAction)                    
{          
	case "searchDtl":		//컬럼 목록 조회
		var dsIdVal = formObj.find("[name=dsId]").val();
		var param = {PageParam: "ibpage", Param: "onepagerow=50&"+"dsId="+dsIdVal};
		gridObj.DoSearchPaging("<c:url value='/admin/openinf/opends/openDsColList.do'/>", param);
		break;
		
	case "searchDstbl":    //항목정보 조회
		var dtIdVal = formObj.find("[name=dtId]").val();
		var dsIdVal = formObj.find("[name=dsId]").val();
		var param = {PageParam: "ibpage", Param: "onepagerow=50&"+"dtId="+dtIdVal+"&dsId="+dsIdVal};
		gridObj2.DoSearchPaging("<c:url value='/admin/openinf/opends/openDstblList.do'/>", param);
		//$("html,body").animate({scrollTop:0},'fast',function(){ }); //데이터셋 스크롤 최상위로 이동하도록함..
		break;
	case "bring":		//불러오기
		LoadDetail(gridObj);   
		var owner = formObj.find("[name=ownerCd]").val();
		
		var tableName = formObj.find("[name=dsId]").val();
		
		if(owner == "" || tableName == ""){
			alert("데이터셋ID를 입력해주세요.");
			return false;
		}
		var param = {PageParam: "ibpage", Param: "onepagerow=50&owner="+owner+"&tableName="+tableName};         
		gridObj.DoSearchPaging("<c:url value='/admin/openinf/opends/openDsSrcColList.do'/>", param);	
		break;     
				
	case "save":		//신규 저장
		if (!validateAdminOpenDs(actObj[1])){  //validation 체크         
			return;   
		}
		
		
	
		/* var sheetCnt = gridObj.RowCount();
		if(sheetCnt == 0){
			alert("테이블 항목정보를 입력해주세요.");
			return false;
		} */
		//dsId 중복 확인 후 저장
		var url ="<c:url value='/admin/openinf/opends/dupDsId.do'/>";	
		var param = formObj.serialize();
		ajaxCall(url, param, dupCallBack);       
		location.reload();
		break;
			
	case "update":		//수정
		if ( !confirm("수정 하시겠습니까? ") ) {
			return;
			}
		if (!validateAdminOpenDs(actObj[1])){  //validation 체크         
			return;   
		} 
		
		
		
		var sheetCnt = gridObj.RowCount();
		if(sheetCnt == 0){
			alert("테이블 항목정보를 입력해주세요.");
			return false;
		}
		var url = "<c:url value='/admin/openinf/opends/updateOpenDs.do'/>"; 
		//var param = openTab.ContentObj.find("[name=adminOpenDs]").serialize();
		var param = formObj.serialize();
		ajaxCallAdmin(url,param,saveCallBackDs);
		
		break;
			
	case "updateCol":		// 컬럼 저장(수정)
	
		if ( !confirm("수정 하시겠습니까? ") ) {
			return;
			}
		/* 
		if(gridObj.GetColHidden("statYn") == "0"){ //컬럼 보이도록){
			if( !(gridObj.CheckedRows("statYn") > 0) ){ //체크는 꼭 하나라도 해야한다.
				alert("통계항목 1개이상 체크해야 합니다.");					
				return;				
			}
		} */
		 //var chk = sheetName.GetCellValue(i,"jsCd");
		 var LOTN = 0;
		 var ADDR = 0;
		 var ROAD = 0;
		 var ZIP5 = 0;
		 var WGSO = 0;
		 var WGSA = 0;
		 
		 var chkNo = 0;
		 
		 var sheetObj2 = "sheetName";
		 var gridObj2 = window[sheetObj2];
		 //alert(gridObj2.LastRow());
		 for(var i=1; i<=gridObj2.LastRow(); i++){
			 var chk = gridObj2.GetCellValue(i,"jsCd");
			 
			 if(chk == "LOTN"){
				 LOTN++;
				if(LOTN == 2){
					alert("지번주소코드를 중복으로 넣을 수 없습니다.")
					return false;
				}
			 }
			 if(chk == "ADDR"){
				 ADDR++;
				if(ADDR == 2){
					alert("기본주소코드를 중복으로 넣을 수 없습니다.")
					return false;
				}
			 }
			 if(chk == "ROAD"){
				 ROAD++;
				if(ROAD == 2){
					alert("도로명주소코드를 중복으로 넣을 수 없습니다.")
					return false;
				}
			 }
			 if(chk == "ZIP5"){
				 ZIP5++;
				if(ZIP5 == 2){
					alert("우편번호코드를 중복으로 넣을 수 없습니다.")
					return false;
				}
			 }
			 if(chk == "WGSO"){
				 WGSO++;
				if(WGSO == 2){
					alert("경도코드를 중복으로 넣을 수 없습니다.")
					return false;
				}
			 }
			 if(chk == "WGSA"){
				 WGSA++;
				if(WGSA == 2){
					alert("위도코드를 중복으로 넣을 수 없습니다.")
					return false;
				}
			 }
		 }
		 
		if(LOTN == 1 || ADDR == 1 || ROAD == 1 || ZIP5 ==1 || WGSO == 1 || WGSA == 1 ){
		//alert("1");
			for(var i=1; i<=gridObj2.LastRow(); i++){
				 
				 var chk = gridObj2.GetCellValue(i,"srcColId");
				 //alert("2");
				 if(chk != null){
					 chkNo++;
				 }
			 }
		 }
		
// 		if(chkNo == 0){
// 			alert("주소컬럼이 들어가는 데이터셋은 'NO' 컬럼이 필수로 있어야합니다.")
// 			return false;
// 	    }
		
		ibsSaveJson = gridObj.GetSaveJson(0);	//트랜잭션 발생한 행의 데이터를 객체로 받기
		if(ibsSaveJson.data.length == 0) return;
		var url = "<c:url value='/admin/openinf/opends/updateOpenDscol.do'/>";
		var param = ""; 
		IBSpostJson(url, param, sheetcallback);		
		break;
	case "updateDstbl":		// 테이블 저장(수정)
		if ( !confirm("수정 하시겠습니까? ") ) {
			return;
			}
	
		setDsId();
		ibsSaveJson = gridObj2.GetSaveJson(0);	//트랜잭션 발생한 행의 데이터를 객체로 받기
		if(ibsSaveJson.data.length == 0) return;
		var url = "<c:url value='/admin/openinf/opends/updateOpenDstbl.do'/>";
		var param = ""; 
		IBSpostJson(url, param, sheetDsbtlcallback);		
		break;
		
	case "delete":		// 데이터셋 삭제
		if ( !confirm("삭제 하시겠습니까? ") ) {
			return;
			}
		var sheetCnt = gridObj.RowCount();
		if(sheetCnt > 0){
			alert("관련 테이블이 존재해서 삭제할 수 없습니다");
			return false;
		}else{
 			var url = "<c:url value='/admin/openinf/opends/deleteOpenDs.do'/>"; 
 			var param = formObj.serialize();
 			ajaxCallAdmin(url,param,savecallback);
		}
		break;
		
	case "deleteCol":		// 컬럼 저장(삭제)
		if ( !confirm("삭제 하시겠습니까? ") ) {
			return;
			}
		ibsSaveJson = gridObj.GetSaveJson(0, "delChk");	//선택한 행의 데이터를 객체로 받기
		if(ibsSaveJson.data.length == 0) return;
		var url = "<c:url value='/admin/openinf/opends/deleteOpenDscol.do'/>";
		var param = ""; 
		IBSpostJson(url, param, sheetcallback);		
		break;
		
	case "deleteDstbl":		// 테이블 저장(삭제)
		if ( !confirm("삭제 하시겠습니까? ") ) {
			return;
			}
		setDsId();
		ibsSaveJson = gridObj2.GetSaveJson(0, "delChk");	//선택한 행의 데이터를 객체로 받기
		if(ibsSaveJson.data.length == 0) return;
		var url = "<c:url value='/admin/openinf/opends/deleteOpenDstbl.do'/>";
		var param = "";
		IBSpostJson(url, param, sheetDsbtlcallback);
		break;
		
	case "up":
		if(gridObj.GetSelectRow() < 2){
			alert("이동할 행을 선택하세요.");
		}else{
			var selRow = gridObj.GetSelectRow();	//선택된 Row 구하기
			gridObj.DataMove(selRow-1, selRow);		//행 이동
			setOrder(gridObj);	//순서 재설정
		}
		break;
		
	case "down":
		if(gridObj.GetSelectRow() < 1){
			alert("이동할 행을 선택하세요.");
		}else{
			var selRow = gridObj.GetSelectRow();	//선택된 Row 구하기
			gridObj.DataMove(selRow+2, selRow);		//행 이동
			setOrder(gridObj);	//순서 재설정
		}
		break;
		
	case "openDsPop":
 		OpenWindow("<c:url value="/admin/openinf/opends/popup/openDs_pop.do"/>","openDsPop","700","550","yes");
		break;
	case "backDsPop":
 		OpenWindow("<c:url value="/admin/openinf/opends/popup/backDs_pop.do"/>","backDsPop","700","550","yes");
		break;
		
	case "openDtPop":
		OpenWindow("<c:url value="/admin/openinf/opends/popup/openDt_pop.do"/>","openDtPop","700","550","yes");
		break;
		
	case "dataSamplePop":
		var dsId = formObj.find("input[name=dsId]").val();                  
		var target = "<c:url value="/admin/openinf/opends/popup/opends_samplePop.do"/>";
		var wName = "samplePop";        
		var wWidth = "1024";
		var wHeight = "580"   ;                         
		var wScroll ="no";
		OpenWindow(target+"?dsId="+dsId, wName, wWidth, wHeight, wScroll);      
//			OpenWindow("<c:url value="/admin/openinf/opends/popup/opends_samplePop.do"/>","samplePop","700","550","yes");
		break;
	case "init":
		
		formObj.find("input[name=dtId]").val("");
		formObj.find("input[name=dtNm]").val("");
		formObj.find("input[name=ownerCd]").val("");
		formObj.find("input[name=ownerCode]").val("");
		formObj.find("input[name=dsId]").val("");
		formObj.find("input[name=dsNm]").val("");
		formObj.find("input[name=useYn]").val("Y");
		
		sheetName.RemoveAll();
		
		btnSet();
		break;

}
}

function setDs(){   
	
	var classObj = $("."+"container"); //tab으로 인하여 form이 다건임
	
	classObj.find(".tab-inner a").click(function(e) {            
		if($(this).hasClass("on")){
			return;              
		}
		classObj.find(".tab-inner a").removeClass("service").addClass("no-service");
		//classObj.find(".tab-inner a").addClass("no-service");
		//classObj.find(".tab-inner a").removeClass("on");                                                                  
		//$(this).addClass("on");                                    
		$(this).removeClass("no-service").addClass("service");                                
		var talIndex = ($(this).index(".tab-inner a")+1);
		
		classObj.find("div.content").hide();  
		classObj.find("div.content").eq(0).show();
		classObj.find("div.content").eq(talIndex).show();   
		//var sheet = formObj.find("div[name=srvColDiv]").eq(talIndex).find("input[name=SSheetNm]").val();
		//var sheetSrvCd = formObj.find("div[name=srvColDiv]").eq(talIndex).find("input[name=srvCd]").val();	
		//7개 헤더 설정       
		/* if(sheetSrvCd == "T"){
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
			window[sheet].FitColWidth("5|3|12|12|12|12|10|7|7|7|7|3");  
		}else if(sheetSrvCd == "A"){  
			window[sheet].FitColWidth("6|5|20|25|8|8|8|8|8");    
		}else if(sheetSrvCd == "V"){  
			window[sheet].FitColWidth("7|7|12|15|25|13|13|8");
		}		      */                                            
		return false;                                                                                               
	});  
	//return srvYn;
} 
 
 
//]]>            
</script> 
		<!-- 탭 내용 --> 
			<div class="content">                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   
		        <h3 class="text-title2">메타 상세정보</h3>
				
			
				<form name="adminOpenDs"  method="post" action="#">
				<input type="hidden" name="sheetNm"/>
				<input type="hidden" name="tempRegValue" value="0"/>
				<table class="list01">
					<caption>데이터셋관리</caption>
					<colgroup>
						<col width="150"/>
						<col width=""/>
						<col width="100"/>
						<col width=""/>
					</colgroup>
					
					<tr>
						<th><label class=""><spring:message code="labal.dtNm"/></label> <span>*</span></th>
						<td colspan="3">
							<input type="hidden" name="dtId" />
							<input type="text" name="dtNm"  value="" style="width:373px" readonly class="readonly"/>
							<button type="button" class="btn01" name="dtSearch">검색</button>
						</td>
						
					</tr>
					<tr>
						<th><label class=""><spring:message code="labal.dsId"/></label><span>*</span></th>
						<td colspan="3">
							<input type="hidden" name="ownerCd" />
							<input type="text" name="ownerCode" class="input" readonly  />
							<strong style="font-size:16pt;vertical-align:middle;">.</strong>
							<input type="text" name="dsId" class="input" readonly class="readonly" style="width:220px"/>
							<button type="button" class="btn01" name="dsSearch">검색</button><br/>
						</td>
					</tr>
					<tr>
						
					</tr>
					<tr>
						<th><label class=""><spring:message code="labal.dsNm"/></label> <span>*</span></th>
						<td colspan="3">
							<input type="text" name="dsNm"  style="width:345px" maxlength="160"/>
						</td>
					</tr>
					
					<tr>
						<th>사용여부</th>
						<td colspan="3">
							<input type="radio" name="useYn" value="Y" class="input" checked/>
							<label for="use">사용</label>
							<input type="radio" name="useYn" value="N" class="input"/>
							<label for="unuse">미사용</label>
						</td>
					</tr>
					<tr>
						<th><label class="">백업테이블</th>
						<td colspan="3">
							<input type="hidden" name="backOwnerCd" />
							<input type="text" name="backOwnerCode" class="input" readonly  />
							<strong style="font-size:16pt;vertical-align:middle;">.</strong>
							<input type="text" name="bcpDsId" class="input" readonly class="readonly" style="width:220px"/>
							<button type="button" class="btn01" name="btSearch">검색</button>
						</td>
					</tr>
					<tr>
						<th>국가중점DB여부</th>
						<td colspan="3">
							<input type="radio" name="keyDbYn" value="Y" class="input" />
							<label for="use">예</label>
							<input type="radio" name="keyDbYn" value="N" class="input" checked/>
							<label for="unuse">아니요</label>
						</td>
					</tr>
					<tr>
						<th>행자부표준여부</th>
							<td colspan="3">
							<input type="radio" name="stddDsYn" value="Y" class="input"/>
							<label for="use">예</label>
							<input type="radio" name="stddDsYn" value="N" class="input" checked/>
							<label for="unuse">아니요</label>
						</td>
					</tr>
				</table>
				<div class="buttons">
					${sessionScope.button.a_init}
					${sessionScope.button.a_reg}
					${sessionScope.button.a_modify}
					${sessionScope.button.a_del}
					${sessionScope.button.a_dataSample}
					
				</div>
				<!-- ibsheet 영역 -->
				<%-- <div class="ibsheet-header">				
					<h3 class="text-title2">관련 테이블 정보</h3>
				</div>
				<div class="ibsheet_area" name="subSheet"></div>
				<div class="buttons">
					${sessionScope.button.a_modify}
					${sessionScope.button.a_del}
				</div> --%>
				
				
				<!-- ibsheet 영역 -->
				<div class="ibsheet-header">				
					<h3 class="text-title2">항목정보</h3>
<!-- 					<p> -->
<!-- 						<input type="radio" name="infoCheck" id="ko" checked/> -->
<!-- 						<label for="ko">한글</label> -->
<!-- 						<input type="radio" name="infoCheck" id="en"/> -->
<!-- 						<label for="en">영문</label> -->
<!-- 					</p> -->

					</div>
					
				<div style="clear: both;"></div>
				<div class="ibsheet_area_both">
					<script type="text/javascript">createIBSheet("sheetName", "100%", "300px");</script> 
			
				</div>
			<div class="buttons">
					${sessionScope.button.a_import}
					${sessionScope.button.a_up}
					${sessionScope.button.a_down}
					${sessionScope.button.a_modify}
<%-- 					${sessionScope.button.a_del} --%>
			</div>
			</form>	
		</div>