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
<script language="javascript">                
//<![CDATA[                              

           
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
			
		  	var dsIdVal = formObj.find("[name=dsId]").val();
		   // alert(dsIdVal);
			var param = {PageParam: "ibpage", Param: "onepagerow=50&"+"dsId="+dsIdVal};
			gridObj.DoSearchPaging("<c:url value='/admin/openinf/opends/openDsIdeInf.do'/>", param);
	
			break;
	}
}
	 
function setIde(){   
	
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
		<!-- 탭 내용 --> 
			<div class="content" style="display:none">                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   
		
				
			
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