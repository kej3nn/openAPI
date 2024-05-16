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

           
function LoadDQ(sheetDQ){
   var gridTitle3 = "NO"
	  
	   gridTitle3 +="|"+"<spring:message code='labal.dbcColNm'/>";
	   gridTitle3 +="|"+"<spring:message code='labal.dataTypeLeng'/>";
	   gridTitle3 +="|"+"<spring:message code='labal.dbcColKorNm'/>";
	   gridTitle3 +="|"+"<spring:message code='labal.commDtlCdNm'/>";
	   gridTitle3 +="|"+"<spring:message code='labal.anaCnt'/>";
	   gridTitle3 +="|"+"<spring:message code='labal.esnErCnt'/>";
       gridTitle3 +="|"+"<spring:message code='labal.colErrRate'/>";
       
      
   
   with(sheetDQ){
      
     var cfg = {SearchMode:2,Page:50,VScrollMode:1,MergeSheet:2};                                
      SetConfig(cfg);  
      var headers = [                               
                  {Text:gridTitle3, Align:"Center"}                 
              ];
      var headerInfo = {Sort:0,ColMove:1,ColResize:1,HeaderCheck:1};
      
      InitHeaders(headers, headerInfo); 
      SetEditable(1);
       
      var cols = [          
                 {Type:"Seq",		SaveName:"seq",				Width:40,	Align:"Center",		Edit:false,  Sort:false, ColMerge:false}
                ,{Type:"Text",      SaveName:"dbcColNm",         Width:200,   Align:"Left",      Edit:false, ColMerge:true}
                ,{Type:"Text",      SaveName:"dataTypeLeng",      Width:200,   Align:"Center",      Edit:false, ColMerge:true}
                ,{Type:"Text",      SaveName:"dbcColKorNm",            Width:300,   Align:"Left",      Edit:false, ColMerge:true  }
                ,{Type:"Text",      SaveName:"commDtlCdNm",            Width:300,   Align:"Left",      Edit:false  }
                ,{Type:"Text",      SaveName:"anaCnt",            Width:200,   Align:"Left",      Edit:false  }
                ,{Type:"Text",      SaveName:"esnErCnt",            Width:200,   Align:"Left",      Edit:false  }
                ,{Type:"Text",      SaveName:"colErrRate",            Width:40,   Align:"Left",      Edit:false  }
               ];         
                                    
      InitColumns(cols);                                                                           
      FitColWidth();                                                         
      SetExtendLastCol(1);   
      
  }
      default_sheet(sheetDQ);
   
}
           
          
function doDqAction(sAction){

    var classObj = $("."+"container"); //tab으로 인하여 form이 다건임
	var formObj = classObj.find("div.content").eq(1).find("form[name=adminOpenDs]");
	
	var sheetObj; //IbSheet 객체         
	sheetObj ="sheetDQ"; 
	var gridObj = window[sheetObj];
	
    ajaxBeforeSendAdmin("<c:url value='/admin/ajaxBeforeSendAdmin.do'/>"); //IbSheet 조회전 세션 체크

	switch(sAction)                    
	{          
		case "searchDQ":		//컬럼 목록 조회
			
		    var dsIdVal = formObj.find("[name=dsId]").val();
		    //alert(dsIdVal);
			var param = {PageParam: "ibpage", Param: "onepagerow=50&"+"dsId="+dsIdVal};
			gridObj.DoSearchPaging("<c:url value='/admin/openinf/opends/openDsDQ.do'/>", param);
			
			
						
			
			
			break;
	}
}
	 
function setDq(){   
	
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


 function sheetDQ_OnSearchEnd(Code,Msg,StCode,StMsg){
	 
	var tot = sheetDQ.RowCount();
	
	for(var i=1; i< tot; i++ ) {
		if(sheetDQ.GetCellValue(i, "esnErCnt") != "" && sheetDQ.GetCellValue(i, "esnErCnt") != "0"  ){
			
			sheetDQ.SetRowBackColor(i, "#FFFF00");
			sheetDQ.SetCellBackColor(i,"seq", "#FFFFFF");
			
			 //이제 머지된 부분에 대한 색상 반영 (1,2,3 열만 머지된다고 가정)
            for(var c=1;c<4;c++){
                      var startMergeRow = ((sheetDQ.GetMergedStartCell(i,c)).split(","))[0]; //머지 시작행
                      if(startMergeRow != i){//현재 행이 머지 시작 지점이 아닌 경우, 시작지점 셀에 배경색을 넣어주자.
                                 if(    sheetDQ.GetCellBackColor(startMergeRow,c) != "#FFFF00"){
                                	 sheetDQ.SetCellBackColor(startMergeRow, c, "#FFFF00") ;
                                 }
                      }
            }
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
					<h3 class="text-title2">데이터 품질진단</h3>
       
					
				<div style="clear: both;"></div>
				<div class="ibsheet_area_both">
					<script type="text/javascript">createIBSheet("sheetDQ", "100%", "300px");</script> 
			
				</div>
			
			</form>	
		</div>