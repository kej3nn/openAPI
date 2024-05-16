<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="egovframework.common.WiseOpenConfig"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>  
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>   
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">   
<!--
	validate 사용시 반드시 선언
	formName명과 validate 함수명이 연결되어있음
	adminCommUsr -> validateAdminCommUsr 체크함
	resources/validator/*.* xml을 만들어서 사용
  -->    
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
 <title><spring:message code='wiseopen.title'/></title>                
<c:import  url="/WEB-INF/jsp/inc/headinclude.jsp"/>
<validator:javascript formName="adminOpenDs" staticJavascript="false" xhtml="true" cdata="false"/>     
<script language="javascript">                

$(document).ready(function(){                         
	
	LoadPage();    
	//LoadDetail(sheetName);
	//LoadDQ(sheetDQ);
	LoadIDE(sheetIDE);
	doAction('search');   
	//btnSet();
	inputEnterKey();       
	//tabSet();// tab 셋팅
	//setTabButton();
	$("button[name=btn_reg]").click(function(e) {	doAction("reg");	return false;	}); 
	$("button[name=btn_inquiry]").click(function(){	doAction("search");	return false;	});
	
	//setDs();
	//setDq();
	//setIde();
	
});     

function inputEnterKey(){
	$("input").keypress(function(e) {
		  if(e.which == 13) {
			  doAction('search');   
			  return false;
		  }
	});
}   

function LoadPage(){      
	
	//message-common_ko_KR.properties 선언 후 사용 or message-common_en_US.properties 선언 후 사용
	var gridTitle1 = "NO";
		gridTitle1 +="|"+"<spring:message code='labal.ownerCd'/>";
		gridTitle1 +="|"+"<spring:message code='labal.dsId'/>";
		gridTitle1 +="|"+"<spring:message code='labal.dsNm'/>";
		gridTitle1 +="|"+"<spring:message code='labal.dtId'/>";
		gridTitle1 +="|"+"<spring:message code='labal.dtNm'/>";
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
					,{Type:"CheckBox",	SaveName:"useYn",			Width:20,	Align:"Center",		TrueValue:"Y", FalseValue:"N", Edit:false}
                                        
                ];       
                                      
        InitColumns(cols);                                                                           
        SetExtendLastCol(1);   
        SetColProperty("ownerCd", ${codeMap.ownerCdIbs});    //InitColumns 이후에 셋팅       
        SetColProperty("dsCd", 			${codeMap.dsCdIbs});    //InitColumns 이후에 셋팅       
    }
        default_sheet(mySheet);    	
	
}

//기본 action      
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
						
			}
}


           
function LoadIDE(sheetIDE){
   var gridTitle3 = "NO"
	   gridTitle3 +="|"+"<spring:message code='labal.resdntergNoCnt'/>";
	   gridTitle3 +="|"+"<spring:message code='labal.frgnrNoCn'/>";
	   gridTitle3 +="|"+"<spring:message code='labal.driveLicenceNoCnt'/>";
	   gridTitle3 +="|"+"<spring:message code='labal.passportNoCnt'/>";
	   gridTitle3 +="|"+"<spring:message code='labal.emailNoCnt'/>";
	   gridTitle3 +="|"+"<spring:message code='labal.telNoCnt'/>";
	   gridTitle3 +="|"+"<spring:message code='labal.mphonNoCnt'/>";
       gridTitle3 +="|"+"<spring:message code='labal.accntNoCnt'/>";
       gridTitle3 +="|"+"<spring:message code='labal.cardNoCnt'/>";
       gridTitle3 +="|"+"<spring:message code='labal.coprtnNoCnt'/>";
       gridTitle3 +="|"+"<spring:message code='labal.bizmanNoCnt'/>";
       gridTitle3 +="|"+"<spring:message code='labal.healthInsrncNoCnt'/>";
       gridTitle3 +="|"+"<spring:message code='labal.beginDtm'/>";
       gridTitle3 +="|"+"<spring:message code='labal.endDtm'/>";
       
      
   
   with(sheetIDE){
      
     var cfg = {SearchMode:2,Page:50,VScrollMode:1,MergeSheet:2};                                
      SetConfig(cfg);  
      var headers = [                               
                  {Text:gridTitle3, Align:"Center"}                 
              ];
      var headerInfo = {Sort:0,ColMove:1,ColResize:1,HeaderCheck:1};
      
      InitHeaders(headers, headerInfo); 
      SetEditable(1);
       
      var cols = [          
                 {Type:"Seq",		SaveName:"seq",				Width:60,	Align:"Center",		Edit:false,  Sort:false}  
                ,{Type:"Text",      SaveName:"resdntergNoCnt",         Width:150,   Align:"Left",      Edit:false}
                ,{Type:"Text",      SaveName:"frgnrNoCnt",      Width:150,   Align:"Center",      Edit:false}
                ,{Type:"Text",      SaveName:"driveLicenceNoCnt",            Width:150,   Align:"Left",      Edit:false}
                ,{Type:"Text",      SaveName:"passportNoCnt",            Width:150,   Align:"Left",      Edit:false  }
                ,{Type:"Text",      SaveName:"emailNoCnt",            Width:150,   Align:"Left",      Edit:false  }
                ,{Type:"Text",      SaveName:"telNoCnt",            Width:150,   Align:"Left",      Edit:false  }
                ,{Type:"Text",      SaveName:"mphonNoCnt",            Width:150,   Align:"Left",      Edit:false  }
                ,{Type:"Text",      SaveName:"accntNoCnt",            Width:150,   Align:"Left",      Edit:false  }
                ,{Type:"Text",      SaveName:"cardNoCnt",            Width:150,   Align:"Left",      Edit:false  }
                ,{Type:"Text",      SaveName:"coprtnNoCnt",            Width:150,   Align:"Left",      Edit:false  }
                ,{Type:"Text",      SaveName:"bizmanNoCnt",            Width:150,   Align:"Left",      Edit:false  }
                ,{Type:"Text",      SaveName:"healthInsrncNoCnt",            Width:150,   Align:"Left",      Edit:false  }
                ,{Type:"Text",      SaveName:"beginDtm",            Width:150,   Align:"Left",      Edit:false  }
                ,{Type:"Text",      SaveName:"endDtm",            Width:150,   Align:"Left",      Edit:false  }
               ];         
                                    
      InitColumns(cols);                                                                           
      FitColWidth();                                                         
      SetExtendLastCol(1);   
      
  }
      default_sheet(sheetIDE);
   
}

//상세정보 보기
function mySheet_OnDblClick(row, col, value, cellx, celly) {
    
	
 
 	var url = "<c:url value='/admin/openinf/opends/openDsDetail.do'/>";
 	var param = "dsId= " + mySheet.GetCellValue(row,"dsId");
 
 	ajaxBeforeSendAdmin("<c:url value='/admin/ajaxBeforeSendAdmin.do'/>"); //IbSheet 조회전 세션 체크
 	//ajaxCallAdmin(url, param, tabCallBack2);
 	//doSheetAction('searchDtl');
 	//doDqAction('searchDQ');
 	dosheetIdeAction('searchIDE');
    
    
    //tabEvent(row);                      
}
           
          
function dosheetIdeAction(sAction){

    var classObj = $("."+"container"); //tab으로 인하여 form이 다건임
	var formObj = classObj.find("div.content").eq(1).find("form[name=adminOpenDs]");
	
	var sheetObj; //IbSheet 객체         
	sheetObj ="sheetIDE"; 
	var gridObj = window[sheetObj];
	
    ajaxBeforeSendAdmin("<c:url value='/admin/ajaxBeforeSendAdmin.do'/>"); //IbSheet 조회전 세션 체크

	switch(sAction)                    
	{          
		case "searchIDE":		//컬럼 목록 조회
			var tot = mySheet.GetSelectRow();
		    //var dsIdVal = formObj.find("[name=dsId]").val();
			var dsIdVal = mySheet.GetCellValue(tot, "dsId");
			var param = {PageParam: "ibpage", Param: "onepagerow=50&"+"dsId="+dsIdVal};
			gridObj.DoSearchPaging("<c:url value='/admin/openinf/opends/openDsIdeInf.do'/>", param);
	
			break;
	}
}
	 
/* function setIde(){   
	
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
		}		                                                
		return false;                                                                                               
	});  
	//return srvYn;
}  */


                 
function sheetIDE_OnSearchEnd(Code,Msg,StCode,StMsg){
	 
	var tot = sheetIDE.RowCount();
	
	for(var i=1; i<= tot; i++ ) {
		if((sheetIDE.GetCellValue(i, "resdntergNoCnt") != "" && sheetIDE.GetCellValue(i, "resdntergNoCnt") != "0")   
				||(sheetIDE.GetCellValue(i, "frgnrNoCnt") != "" && sheetIDE.GetCellValue(i, "frgnrNoCnt") != "0")	
				||(sheetIDE.GetCellValue(i, "driveLicenceNoCnt") != "" && sheetIDE.GetCellValue(i, "driveLicenceNoCnt") != "0")	
				||(sheetIDE.GetCellValue(i, "passportNoCnt") != "" && sheetIDE.GetCellValue(i, "passportNoCnt") != "0")	
				||(sheetIDE.GetCellValue(i, "emailNoCnt") != "" && sheetIDE.GetCellValue(i, "emailNoCnt") != "0")	
				||(sheetIDE.GetCellValue(i, "telNoCnt") != "" && sheetIDE.GetCellValue(i, "telNoCnt") != "0")	
				||(sheetIDE.GetCellValue(i, "mphonNoCnt") != "" && sheetIDE.GetCellValue(i, "mphonNoCnt") != "0")	
				||(sheetIDE.GetCellValue(i, "accntNoCnt") != "" && sheetIDE.GetCellValue(i, "accntNoCnt") != "0")	
				||(sheetIDE.GetCellValue(i, "cardNoCnt") != "" && sheetIDE.GetCellValue(i, "cardNoCnt") != "0")	
				||(sheetIDE.GetCellValue(i, "coprtnNoCnt") != "" && sheetIDE.GetCellValue(i, "coprtnNoCnt") != "0")	
				||(sheetIDE.GetCellValue(i, "bizmanNoCnt") != "" && sheetIDE.GetCellValue(i, "bizmanNoCnt") != "0")	
				||(sheetIDE.GetCellValue(i, "healthInsrncNoCnt") != "" && sheetIDE.GetCellValue(i, "healthInsrncNoCnt") != "0")	
	      ){
			
			sheetIDE.SetRowBackColor(i, "#FFFF00");
			//sheetIDE.SetCellBackColor(i,"seq", "#FFFFFF");
			
			 
		}
	}
	
}  
 
//]]>            
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
				<col width="150"/>
				<col width=""/>
			</colgroup>
			<tr>
				<th>검색어</th>
				<td>
					<select name="searchWd">
						<option value="">선택</option>
						<option value="0" selected="selected">데이터셋명</option>
	                 	<option value="1">데이터셋ID</option>
	                 	<option value="2">보유데이터명</option>
					</select>

					<select name="searchWd2">
						<option value="">선택</option>
						<option value="3" selected="selected">전체</option>
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
		<!-- 탭 내용 --> 
			<div class="content">                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   
		
				
			
				<form name="adminOpenDs"  method="post" action="#">
				<input type="hidden" name="sheetNm"/>
				<input type="hidden" name="tempRegValue" value="0"/>
					<h3 class="text-title2">개인정보 모니터링</h3>
       
					
				<div style="clear: both;"></div>
				<div class="ibsheet_area_both">
					<script type="text/javascript">createIBSheet("sheetIDE", "100%", "300px");</script> 
			
				</div>
			
			</form>	
		</div>
		</div>
		</div>
		<!--##  푸터  ##-->
  <c:import  url="/WEB-INF/jsp/admin/adminfooter.jsp"/>
	<!--##  /푸터  ##-->
</body>
</html>