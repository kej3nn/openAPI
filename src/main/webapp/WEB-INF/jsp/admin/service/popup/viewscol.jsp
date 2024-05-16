<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="egovframework.common.WiseOpenConfig"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>   

<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt" %>   

<%pageContext.setAttribute("crlf", "\r\n"); %>                        
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><spring:message code='wiseopen.title'/></title>                    
<c:import  url="/WEB-INF/jsp/inc/headinclude.jsp"/>
<style type="text/css">
body{background:none;} /* 임시로 해놓은 것임 */
</style>
</head>                                                 
<script language="javascript">              
//<![CDATA[                   
$(document).ready(function()    {           
	LoadPage();
	inputSet();
});                                      

var widhtArr = new Array();

function LoadPage()                
{      
	
	var gridTitle ="NO";
	var gridEngTitle="NO"
	<c:forEach var="head" items="${head}" varStatus="status">
		gridTitle +="|"+'${head.colNm}';  
	</c:forEach>
                                       
    with(mySheet1){
    	                     
    	var cfg = {SearchMode:3,Page:50};                                
        SetConfig(cfg);  
        var headers = [                               
                    {Text:gridTitle, Align:"Center"}                 
                ];
        var headerInfo = {Sort:0,ColMove:1,ColResize:1,HeaderCheck:0};
        
        InitHeaders(headers, headerInfo); 
        var cols = [          
					 {Type:"Seq",		SaveName:"seq",				Width:50,	Align:"Center",		Edit:false,Hidden:false,Sort:0}
					 <c:forEach var="head" items="${head}" varStatus="status">
					 ,{Type:"${head.viewCd}",		SaveName:"${head.srcColId}",			Width:${head.viewSize},	Align:"${head.alignTag}",		Edit:false,	Format:"${head.formatText}",	Ellipsis:"${head.ellipsisText}",AllowNull:1}
					</c:forEach>
                ];                          
                                      
        InitColumns(cols);                                                                                         
        //FitColWidth();                                                         
        SetExtendLastCol(1);                              
        SetColProperty("infState", 	${codeMap.infStateIbs});    //InitColumns 이후에 셋팅   
        SetDataAutoTrim(0);
        ShowToolTip(1)
    }               
    gridSet(mySheet1);       
    
	doAction("search");       
    
    var i = 1;
    <c:forEach var="head" items="${head}" varStatus="status">
    widhtArr[i++] = ${head.viewSize}
	</c:forEach>
}      


function gridSet(sheet_obj)                
{
	with (sheet_obj)  
	{
		//헤더설정
		SetHeaderFontBold(true);					//해더행 볼드
		SetHeaderRowHeight(31); //해더 행 높이         
		                         
		SetDataRowHeight(22);//데이터행 높이                
		//기타설정
		SetSheetFontName("Malgun Gothic");		//글자체 설정
		SetSheetFontSize(12);		//글자크기 설정
		SetSelectionMode(1);		//셀 선택 모드(0:셀단위, 1:행단위)
		SetCountPosition(4);		//건수위치,0:없음,1:좌상,2:우상,3:좌하,4:우하
		SetWaitImageVisible(1);	//대기이미지표시 여부               
	}                              
} 

function doAction(sAction)                                  
{
	var formObj = $("form[name=OpenInfSColView]");       
	var flag = false;  
	
	var pattern =/[&]/gi;             
	var pattern2 =/[=]/gi;             
	var formData = formObj.serialize().replace(pattern,"~!@");     
	formData = formData.replace(pattern2,"@!~");   
	switch(sAction)                                              
	{          
		case "search":      //조회   
			//날짜 체크(max)
			//from to 체크       
			formObj.find("input[name=filtMaxDay]").each(function(index,item){              
				var fromObj = $(this).parent().find("input").eq(0);
				var toObj = $(this).parent().find("input").eq(1);
				var fromDt = fromObj.val(); //from
				var toDt =  toObj.val(); //to
				var pattern =/[^(0-9)]/gi;
				var fromReplace = fromDt.replace(pattern,"");                 
				var toReplace=toDt.replace(pattern,"");
				
				if(!(fromDt =="" && toDt == "")){//값이 있으면
					if(fromDt != "" && toDt == ""){
					 alert($(this).parent().prev().html().replace(" <SPAN>*</SPAN>","").replace(" <span>*</span>","")+" <spring:message code='msg.view1'/>");    
						toObj.val(fromDt); //to 값 넣음
						toReplace = fromReplace;
					}
					if(toDt != "" && fromDt == ""){
						alert($(this).parent().prev().html().replace(" <SPAN>*</SPAN>","").replace(" <span>*</span>","")+" <spring:message code='msg.view2'/>");    
						fromObj.val(toDt); //from 값 넣음
						fromReplace = toReplace;
					}
					if(toReplace < fromReplace ){              
						alert($(this).parent().prev().html().replace(" <SPAN>*</SPAN>","").replace(" <span>*</span>","")+" <spring:message code='msg.view3'/>");    
						toObj.val(fromDt); //from 값 넣음    
						toReplace = fromReplace;                                         
					}                                            
					var day =  getDateDiffVal(fromReplace,toReplace);    
					if(day >= $(this).val()){                    
						alert($(this).parent().prev().html().replace(" <SPAN>*</SPAN>","").replace(" <span>*</span>","")+" <spring:message code='msg.view4'/>");    
						fromObj.focus();       
						flag =true;
						return;     
					}
				}else if((fromDt =="" && toDt == "") && ($(this).parent().prev().html().indexOf(">*<") > -1)) {
					alert($(this).parent().prev().html().replace(" <SPAN>*</SPAN>","").replace(" <span>*</span>","")+"(을)를 입력해주세요.");   
					flag =true;
					return;                    
				}               
			});   
			if(flag){
				return;
			}
			//check박스 필수 체크
			formObj.find("input[name=checkFiltNeed]").each(function(index,item){              
				if($(this).val() == "Y"){
					var checkObj = $(this).parent().find("input").eq(0);                 
					if(nullCheckValdation(checkObj,$(this).parent().prev().html().replace(" <span>*</span>",""),"")){
						flag =true;
						return;
					}
				}
			});
			if(flag){
				return;
			}
			//radio박스 필수 체크
			formObj.find("input[name=radioFiltNeed]").each(function(index,item){              
				if($(this).val() == "Y"){
					var checkObj = $(this).parent().find("input").eq(0);
					if(nullCheckValdation(checkObj,$(this).parent().prev().html().replace(" <span>*</span>",""),"")){
						flag =true;
						return;
					}
				}
			})
			if(flag){
				return;
			}
			formObj.find("input[name=comboFiltNeed]").each(function(index,item){              
				if($(this).val() == "Y"){
					var checkObj = $(this).parent().find("select").eq(0);
					if(nullCheckValdation(checkObj,$(this).parent().prev().html().replace(" <span>*</span>",""),"")){
						flag =true;
						return;
					}
				}
			})
			
			//팝업 
			if(flag){
				return;
			}
			formObj.find("input[name=popFiltNeed]").each(function(index,item){    
				if($(this).val() == "Y"){
					var checkObj = $(this).parent().find("input").eq(0);
					if(nullCheckValdation(checkObj,$(this).parent().prev().html().replace(" <span>*</span>",""),"")){
						flag =true;
						return;
					}
				}
			})
			//워드
			if(flag){
				return;
			}
			formObj.find("input[name=wordsFiltNeed]").each(function(index,item){              
				if($(this).val() == "Y"){
					var checkObj = $(this).parent().find("input").eq(0);
					if(nullCheckValdation(checkObj,$(this).parent().prev().html().replace(" <span>*</span>",""),"")){
						flag =true;
						return;
					}
				}
			});
			
			if(flag){         
				return;                 
			}               
			ajaxBeforeSendAdmin("<c:url value='/admin/ajaxBeforeSendAdmin.do'/>"); //IbSheet 조회전 세션 체크
			var param = {PageParam: "ibpage", Param: "onepagerow=50&"+formObj.serialize()+"&queryString="+formData};         
			mySheet1.DoSearchPaging("<c:url value='/admin/service/openInfColViewListAll.do'/>", param);
			break;   
		case "lang":            
			formObj.attr("action","<c:url value='/admin/service/openInfColViewPopUp.do'/>").submit();
			break;
		case "down":                       
				formObj.attr("action","<c:url value='/admin/service/download.do?"+"&queryString="+formData+"'/>").submit();        
			break;                           
	}                                                                                                                 
}                         

function colcallback(){
	                                                                    
}

function inputSet(){
	<c:forEach var="cond" items="${cond}" varStatus="status">
	switch("${cond.filtCd}")                                 
	{                                                
		case "FDATE":                          
			$("input[name=${cond.srcColId}]").datepicker(setCalendarView('yy-mm-dd'));                                                           
			break;
		case "LDATE":   
			$("input[name=${cond.srcColId}]").datepicker(setCalendarView('yy/mm/dd'));            
			break;
		case "PDATE": 
			$("input[name=${cond.srcColId}]").datepicker(setCalendarView('yy.mm.dd'));            
			break;          
		case "SDATE":   
			$("input[name=${cond.srcColId}]").datepicker(setCalendarView('yymmdd'));                            
			break;          
		case "CDATE":   
			$("input[name=${cond.srcColId}]").datepicker(setCalendarView('yymmdd'));                            
			break;  
	}
	</c:forEach>
	
	var formObj = $("form[name=OpenInfSColView]");                  
	$("button[name=btn_reSearch]").click(function(e) {      
		doAction('search');                 
		return false;                                                     
	});
	
	$("a[name=a_close]").click(function(e) { 
		window.close();
		 return false;                             
	 }); 
	
	$("#a_kr").click(function(e) { 
		formObj.find("input[name=viewLang]").val("");
		doAction("lang");
		 return false;                             
	 }); 
	$("#a_en").click(function(e) { 
		formObj.find("input[name=viewLang]").val("E");
		doAction("lang");
		 return false;                             
	 });             
	$("#xlsDown").click(function(e) {
		formObj.find("input[name=fileDownType]").val("E");
		doAction("down");                    
		 return false;                             
	 }); 
	$("#csvDown").click(function(e) { 
		formObj.find("input[name=fileDownType]").val("C");
		doAction("down");
		 return false;                             
	 });
	$("#jsonDown").click(function(e) { 
		formObj.find("input[name=fileDownType]").val("J");           
		doAction("down");
		 return false;                             
	 });   
	
	 var btn09 =  formObj.find(".btn09");
	 btn09.each(function(index,item){  
			$(item).click(function(e) {    
				popupObj =$(item).prev().prev();             
				// 하드코딩(연결검색)
				var srcCol = popupObj.attr("name");
				var fsclYy = formObj.find("select[name=FSCL_YY]").val();
				if(formObj.find("input[name=fsYn]").val() =="Y"){
					switch(srcCol)                  
					{                                           
						case "OFFC_CD":      //중앙관서코드 
							if(fsclYy == "undefined" || fsclYy == undefined || fsclYy == ""){//회계년도 필수
								alert(fsclNm+"<spring:message code='msg.connSelect'/>");    
								return;
							}
							break;   
						case "FSCL_CD":      //회계코드
							if(fsclYy == "undefined" || fsclYy == undefined || fsclYy == ""){//회계년도 필수
								alert(fsclNm+"<spring:message code='msg.connSelect'/>");      
								return;
							}
							var offcCd = formObj.find("[name=OFFC_CD]").val();
							var offcNm =  formObj.find("[name=OFFC_CD]").parent().parent().find("th").text(); 
							if(offcCd == "undefined" || offcCd == undefined || offcCd == ""){//중앙관서코드 필수
								alert(offcNm+"<spring:message code='msg.connSelect'/>");           
								return;
							}
							break; 
						case "FSCL2_CD":      //회계코드
							if(fsclYy == "undefined" || fsclYy == undefined || fsclYy == ""){//회계년도 필수
								alert(fsclNm+"<spring:message code='msg.connSelect'/>");      
								return;
							}
							break; 
						case "ACCT_CD":      //계정코드
							if(fsclYy == "undefined" || fsclYy == undefined || fsclYy == ""){//회계년도 필수
								alert(fsclNm+"<spring:message code='msg.connSelect'/>");       
								return;
							}
							var fsclCd = formObj.find("[name=FSCL_CD]").val()
							var fsclCdNm =  formObj.find("[name=FSCL_CD]").parent().parent().find("th").text(); 
							if(fsclCd == "undefined" || fsclCd == undefined || fsclCd == ""){//회계코드 필수
								alert(fsclCdNm+"<spring:message code='msg.connSelect'/>");           
								return;
							}
							break; 
						case "FGO_CD":      //관서구분코드
							if(fsclYy == "undefined" || fsclYy == undefined || fsclYy == ""){//회계년도필수(데이터셋에 일선관서코드참조)
								alert(fsclNm+"<spring:message code='msg.connSelect'/>");  
								return;
							}
							var offcCd = formObj.find("[name=OFFC_CD]").val();
							var offcNm =  formObj.find("[name=OFFC_CD]").parent().parent().find("th").text(); 
							if(offcCd == "undefined" || offcCd == undefined || offcCd == ""){//중앙관서코드 필수
								alert(offcNm+"<spring:message code='msg.connSelect'/>");             
								return;
							}
							var fsclCd = formObj.find("[name=FSCL_CD]").val();
							var fsclCdNm =  formObj.find("[name=FSCL_CD]").parent().parent().find("th").text(); 
							if(fsclCd == "undefined" || fsclCd == undefined || fsclCd == ""){//회계코드 필수
								alert(fsclCdNm+"<spring:message code='msg.connSelect'/>");    
								return;
							}
							
							var acctCd = formObj.find("[name=ACCT_CD]").val();
							var acctNm =  formObj.find("[name=ACCT_CD]").parent().parent().find("th").text(); 
							if(acctCd == "undefined" || acctCd == undefined || acctCd == ""){//계정코드 필수
								alert(acctNm+"<spring:message code='msg.connSelect'/>");              
								return;           
							}
							break; 
							
						case "FLD_CD":      //분야코드
							if(fsclYy == "undefined" || fsclYy == undefined || fsclYy == ""){//회계년도 필수
								alert(fsclNm+"<spring:message code='msg.connSelect'/>");  
								return;
							}
							break; 
						case "SECT_CD":      //부문코드
							if(fsclYy == "undefined" || fsclYy == undefined || fsclYy == ""){//회계년도 필수
								alert(fsclNm+"<spring:message code='msg.connSelect'/>");  
								return;
							}
							var fldCd = formObj.find("[name=FLD_CD]").val();
							var fldNm =  formObj.find("[name=FLD_CD]").parent().parent().find("th").text(); 
							if(fldCd == "undefined" || fldCd == undefined || fldCd == ""){//분야코드 필수
								alert(fldNm+"<spring:message code='msg.connSelect'/>");         
								return;
							}
							break; 
						case "PGM_CD":      //프로그램코드
							if(fsclYy == "undefined" || fsclYy == undefined || fsclYy == ""){//회계년도 필수
								alert(fsclNm+"<spring:message code='msg.connSelect'/>");     
								return;
							}
							var fldCd = formObj.find("[name=FLD_CD]").val()
							var fldNm =  formObj.find("[name=FLD_CD]").parent().parent().find("th").text(); 
							if(fldCd == "undefined" || fldCd == undefined || fldCd == ""){//분야코드 필수
								alert(fldNm+"<spring:message code='msg.connSelect'/>");              
								return;
							}
							var sectCd = formObj.find("[name=SECT_CD]").val();
							var sectNm =  formObj.find("[name=SECT_CD]").parent().parent().find("th").text(); 
							if(sectCd == "undefined" || sectCd == undefined || sectCd == ""){//부문코드필수
								alert(sectNm+"<spring:message code='msg.connSelect'/>");              
								return;
							}
							break; 
						case "ACTV_CD":      //단위사업코드 
							if(fsclYy == "undefined" || fsclYy == undefined || fsclYy == ""){//회계년도 필수
								alert(fsclNm+"<spring:message code='msg.connSelect'/>");    
								return;
							}
							var fldCd = formObj.find("[name=FLD_CD]").val();
							var fldNm =  formObj.find("[name=FLD_CD]").parent().parent().find("th").text(); 
							if(fldCd == "undefined" || fldCd == undefined || fldCd == ""){//분야코드 필수
								alert(fldNm+"<spring:message code='msg.connSelect'/>");           
								return;
							}
							var sectCd = formObj.find("[name=SECT_CD]").val();
							var sectNm =  formObj.find("[name=SECT_CD]").parent().parent().find("th").text(); 
							if(sectCd == "undefined" || sectCd == undefined || sectCd == ""){//부문코드필수
								alert(sectNm+"<spring:message code='msg.connSelect'/>");              
								return;
							}
							var pgmCd = formObj.find("[name=PGM_CD]").val();
							var pgmNm =  formObj.find("[name=PGM_CD]").parent().parent().find("th").text(); 
							if(pgmCd == "undefined" || pgmCd == undefined || pgmCd == ""){//프로그램코드필수
								alert(pgmNm+"<spring:message code='msg.connSelect'/>");              
								return;
							}
							break; 
						case "IKWAN_CD":      //수입관 
							if(fsclYy == "undefined" || fsclYy == undefined || fsclYy == ""){//회계년도 필수
								alert(fsclNm+"<spring:message code='msg.connSelect'/>");      
								return;
							}
							break; 
						case "IHANG_CD":      //수입항
							if(fsclYy == "undefined" || fsclYy == undefined || fsclYy == ""){//회계년도 필수
								alert(fsclNm+"<spring:message code='msg.connSelect'/>");    
								return;
							}
						
							var ikwanCd = formObj.find("[name=IKWAN_CD]").val();
							var ikwanNm =  formObj.find("[name=IKWAN_CD]").parent().parent().find("th").text(); 
							if(ikwanCd == "undefined" || ikwanCd == undefined || ikwanCd == ""){//수입관 
								alert(ikwanNm+"<spring:message code='msg.connSelect'/>");       
								return;
							}
							break;
						case "IMOK_CD":      //수입목
							if(fsclYy == "undefined" || fsclYy == undefined || fsclYy == ""){//회계년도 필수
								alert(fsclNm+"<spring:message code='msg.connSelect'/>");    
								return;
							}
						
							var ikwanCd = formObj.find("[name=IKWAN_CD]").val();
							var ikwanNm =  formObj.find("[name=IKWAN_CD]").parent().parent().find("th").text(); 
							if(ikwanCd == "undefined" || ikwanCd == undefined || ikwanCd == ""){//수입관 
								alert(ikwanNm+"<spring:message code='msg.connSelect'/>");          
								return;
							}
							var ihangCd = formObj.find("[name=IHANG_CD]").val();
							var ihangNm =  formObj.find("[name=IHANG_CD]").parent().parent().find("th").text(); 
							if(ihangCd == "undefined" || ihangCd == undefined || ihangCd == ""){//수입항
								alert(ihangNm+"<spring:message code='msg.connSelect'/>");             
								return;
							}
							break;
						case "CITM_CD":      //지출목
							if(fsclYy == "undefined" || fsclYy == undefined || fsclYy == ""){//회계년도 필수
								alert(fsclNm+"<spring:message code='msg.connSelect'/>");        
								return;
							}
							break; 
						case "EITM_CD":      //지출세목
							if(fsclYy == "undefined" || fsclYy == undefined || fsclYy == ""){//회계년도 필수
								alert(fsclNm+"<spring:message code='msg.connSelect'/>");    
								return;
							}
							var citmCd = formObj.find("[name=CITM_CD]").val();
							var citmNm =  formObj.find("[name=CITM_CD]").parent().parent().find("th").text(); 
							if(citmCd == "undefined" || citmCd == undefined || citmCd == ""){//지출목
								alert(citmNm+"<spring:message code='msg.connSelect'/>");           
								return;
							}
							break;
						case "FSCL_YM":      //회계년월
							if(fsclYy == "undefined" || fsclYy == undefined || fsclYy == ""){//회계년도 필수
								alert(fsclNm+"<spring:message code='msg.connSelect'/>");    
								return;
							}
							break;
						case "ORG_CD":      //직제코드
							if(fsclYy == "undefined" || fsclYy == undefined || fsclYy == ""){//회계년도 필수
								alert(fsclNm+"<spring:message code='msg.connSelect'/>");         
								return;
							}
							break;
						case "MPB_FSCL_CD":      //예산편성회계코드
							if(fsclYy == "undefined" || fsclYy == undefined || fsclYy == ""){//회계년도 필수
								alert(fsclNm+"<spring:message code='msg.connSelect'/>");    
								return;
							}
							var orgCd = formObj.find("[name=ORG_CD]").val();
							var orgNm =  formObj.find("[name=ORG_CD]").parent().parent().find("th").text(); 
							if(orgCd == "undefined" || orgCd == undefined || orgCd == ""){//직제코드 필수
								alert(orgNm+"<spring:message code='msg.connSelect'/>");           
								return;
							}
							break;
						case "MPB_ACCT_CD":      //예산편성계정코드
							if(fsclYy == "undefined" || fsclYy == undefined || fsclYy == ""){//회계년도 필수
								alert(fsclNm+"<spring:message code='msg.connSelect'/>");    
								return;
							}
							var orgCd = formObj.find("[name=ORG_CD]").val();
							var orgNm =  formObj.find("[name=ORG_CD]").parent().parent().find("th").text(); 
							if(orgCd == "undefined" || orgCd == undefined || orgCd == ""){//직제코드 필수
								alert(orgNm+"<spring:message code='msg.connSelect'/>");    
								return;
							}
							var mpbFsclCd = formObj.find("[name=MPB_FSCL_CD]").val();
							var mpbFsclNm =  formObj.find("[name=MPB_FSCL_CD]").parent().parent().find("th").text(); 
							if(mpbFsclCd == "undefined" || mpbFsclCd == undefined || mpbFsclCd == ""){//예산편성회계코드 필수
								alert(mpbFsclNm+"<spring:message code='msg.connSelect'/>");             
								return;
							}
							break;
					}
				}
				
				               
				formObj.find("input[name=tblId]").val($(item).prev().val());
				formObj.find("input[name=popColId]").val(srcCol);
				
				var sb="";
				sb +="<colgroup>";                      
				sb +="<col width='50'/>";                   
				sb +="<col width='220'/>";      
				sb +="<col width='220'/>";                         
				sb +="</colgroup>";                
				sb +="<tr>";
				sb+="<th class='ac'>선택</th>";
				sb+="<th>CODE</th>";      
				sb+="<th>CODE VAL</th>";      
				sb+="</tr>";              
				formObj.find(".popup table").empty().append(sb);  
				
				var position = $(item).position();    
					formObj                             
						.find(".popup")
						.css("top",position.top)                       
						.css("left",position.left)
						.hide()
						.show();      
					 formObj.find("input[name=popupSerarch]").focus().val("");  
					 formObj.find(".btn01").click();            
					return false;                 
				});                                                          
		}); 
	 
	 
	 formObj.find("[name=popBtn10]").each(function(index,item){  
			$(item).click(function(e) {    
				$(item).prev().prev().prev().val("");              
				$(item).prev().prev().prev().prev().val("");       
				initInputPopup($(item).prev().prev().prev().attr("name"));
			});                                                          
		})
		
		
	formObj.find("[name=dateBtn10]").each(function(index,item){  
		$(item).click(function(e) {    
			$(item).parent().find("input").eq(0).val("");              
			$(item).parent().find("input").eq(1).val("");              
		});                                                                         
	})
	
	 formObj.find(".popup_close").click(function(e) {    
			formObj.find(".popup").hide();           
			return false;                 
		});
	 
	 formObj.find(".btn01").click(function(e) {    
		/*  if(formObj.find("input[name=popupSerarch]").val() ==""){
			 alert("<spring:message code='labal.searchKeyWord'/>");            
			 return false;
		 }    */                                 
		 goPagePop("1");               
			return false;                      
		}); 
	 
	 formObj.find("input[name=popupSerarch]").keypress(function(e) {     
		  if(e.which == 13) {
			  formObj.find(".btn01").click();              
			  return false;    
		  }
	});
	                 
	 $("#article").click(function(e) { 
			var position = $(this).position();
			$(".sheet-header .popup")                           
				.css("top",position.top)                                      
				.css("left",position.left)
				.hide()                            
				.show();              
		});
	 
	 
	 $(".sheet-header .popup_close").click(function(e) {    
			$(".sheet-header .popup").hide();           
			return false;                             
		});
	               
	//항목적용
		$("#btn02").click(function(e) { 
			var tree = $("input[name=itemCheck]");         
			var formData = tree.serializeArray();
			if(jQuery.param(formData) == ""){                     
		    	alert("<spring:message code='msg.selectItem'/>");              
		    	return false;          
		    }
			var data = jQuery.param(formData).replace(/&itemCheck=/gi,"','").replace(/itemCheck=/gi,"'");                    
			formObj.find("input[name=gridItem]").val(data+"'");       
			$(".sheet-header .popup").hide();
			formObj.find("input[name=applyYn]").val("Y");
			setIbSheetCol();          
			//doAction('search');               
		});                 
		                    
		//항목 선택
		$("a[name=itemChecks]").click(function(e) { 
			$(".check-list input").prop("checked",true);      
			return false;             
		}); 
		//항목 해제
		$("a[name=itemUnCheck]").click(function(e) { 
			$(".check-list input").prop("checked",false);   
			return false;           
		}); 
	
		
		formObj.find(".btn_openclose").click(function(e) { 
            
			if(formObj.find(".btn_openclose").attr("title") == "<spring:message code='btn.close'/>"){
				formObj.find(".btn_openclose").html("<spring:message code='btn.open'/>");
				formObj.find(".btn_openclose").attr("title","<spring:message code='btn.open'/>");
				formObj.find(".btn_openclose").css("top","-20px");     
				formObj.find(".list01").hide();                                                               
			}else{                                      
				formObj.find(".btn_openclose").html("<spring:message code='btn.close'/>");                 
				formObj.find(".btn_openclose").attr("title","<spring:message code='btn.close'/>");
				formObj.find(".btn_openclose").css("top","-15px");     
				formObj.find(".list01").show();             
			}
			 return false;                                                                               
		 });                  
}

function goPagePop(page) {
	var formObj = $("form[name=OpenInfSColView]");       
	var url ="<c:url value='/portal/service/selectTvPopupCode.do'/>";                    
	var param= "tblId="+formObj.find("input[name=tblId]").val();
	param+= "&popColId="+ formObj.find("input[name=popColId]").val();       
	param+= "&popupSerach="+ formObj.find("input[name=popupSerarch]").val();       
	param+= "&pageSize="+ "<%=WiseOpenConfig.PAGE_SIZE %>" 
	param+= "&currPage="+page;
	
	//조회조건
	param+= "&fsclYy="+ formObj.find("[name=FSCL_YY]").val();       
	param+= "&fsclCd="+ formObj.find("[name=FSCL_CD]").val();       
	param+= "&fscl2Cd="+ formObj.find("[name=FSCL2_CD]").val(); 
	param+= "&fldCd="+ formObj.find("[name=FLD_CD]").val();       
	param+= "&sectCd="+ formObj.find("[name=SECT_CD]").val();       
	param+= "&pgmCd="+ formObj.find("[name=PGM_CD]").val();       
	param+= "&gofDivCd="+ formObj.find("[name=gofDivCd]").val();     
	param+= "&offcCd="+ formObj.find("[name=OFFC_CD]").val();      
	param+= "&acctCd="+ formObj.find("[name=ACCT_CD]").val(); 
	param+= "&fsYn="+ formObj.find("input[name=fsYn]").val();
	
	param+= "&ikwanCd="+ formObj.find("[name=IKWAN_CD]").val();       
	param+= "&ihangCd="+ formObj.find("[name=IHANG_CD]").val();       
	param+= "&citmCd="+ formObj.find("[name=CITM_CD]").val();      
	
	param+= "&orgCd="+ formObj.find("[name=ORG_CD]").val(); 
	param+= "&mpbFsclCd="+ formObj.find("[name=MPB_FSCL_CD]").val(); 
	ajaxCall(url,param,tbPopupCodeCallBack);                    
}

function tbPopupCodeCallBack(json){
	var formObj = $("form[name=OpenInfSColView]");    
	var sb="";
	sb +="<colgroup>";                      
	sb +="<col width='50'/>";
	sb +="<col width='120'/>";      
	sb +="<col width='320'/>";                         
	sb +="</colgroup>";                
	sb +="<tr>";
	sb +="<th class='ac'><spring:message code='etc.select'/></th>";                 
	sb +="<th><spring:message code='labal.code'/></th>";
	sb +="<th><spring:message code='labal.codeNm'/></th>";                
	sb+="</tr>";                             
	if(json.list.length> 0){
		for(var i =0; i <json.list.length; i++){         
			sb+="<tr class='tr-bg' onclick=\"javascript:setPopupData('"+json.list[i].COL_ID+"','"+json.list[i].COL_NM+"')\">";     
			sb+="<td class='ac'><input type='radio' onclick=\"javascript:setPopupData('"+json.list[i].COL_ID+"','"+json.list[i].COL_NM+"')\"/></td>";     
			sb+="<td>"+json.list[i].COL_ID+"</td>";
			sb+="<td>"+json.list[i].COL_NM+"</td>";                           
			sb+="</tr>";                  
		}
		formObj.find(".paging").empty().append(json.paging);	
	}else{                       
		sb+="<tr><td colspan='3'><spring:message code='msg.notExitsData'/></td></tr>";
	}
	                
	formObj.find(".popup table").empty().append(sb);     
	formObj.find(".list-search p strong").html(json.totCnt);	
	      
}
var popupObj;
function setPopupData(value,valueNm){
	popupObj.val(value);
	popupObj.prev().val(valueNm);           
	var formObj = $("form[name=OpenInfSColView]");               
	formObj.find(".popup").hide();              
	if(formObj.find("input[name=fsYn]").val() =="Y"){
		initInputPopup(popupObj.attr("name"))
	}   
}

function initFsclYy(){
	var formObj = $("form[name=OpenInfSColView]");               
	if(formObj.find("input[name=fsYn]").val() =="Y"){
		formObj.find("[name=OFFC_CD]").val("");       
		formObj.find("[name=FSCL_CD]").val("");       
		formObj.find("[name=ACCT_CD]").val("");       
		formObj.find("[name=FGO_CD]").val("");       
		formObj.find("[name=FLD_CD]").val("");       
		formObj.find("[name=SECT_CD]").val("");       
		formObj.find("[name=PGM_CD]").val("");       
		formObj.find("[name=ACTV_CD]").val("");       
		formObj.find("[name=IKWAN_CD]").val("");       
		formObj.find("[name=IHANG_CD]").val("");       
		formObj.find("[name=IMOK_CD]").val("");       
		formObj.find("[name=CITM_CD]").val("");  
		formObj.find("[name=EITM_CD]").val(""); 
		formObj.find("[name=FSCL_YM]").val(""); 
		formObj.find("[name=ORG_CD]").val(""); 
		formObj.find("[name=MPB_FSCL_CD]").val(""); 
		formObj.find("[name=MPB_ACCT_CD]").val(""); 
		formObj.find("[name=OFFC_CDNm]").val("");       
		formObj.find("[name=FSCL_CDNm]").val("");       
		formObj.find("[name=ACCT_CDNm]").val("");       
		formObj.find("[name=FGO_CDNm]").val("");       
		formObj.find("[name=FLD_CDNm]").val("");       
		formObj.find("[name=SECT_CDNm]").val("");       
		formObj.find("[name=PGM_CDNm]").val("");       
		formObj.find("[name=ACTV_CDNm]").val("");       
		formObj.find("[name=IKWAN_CDNm]").val("");       
		formObj.find("[name=IHANG_CDNm]").val("");       
		formObj.find("[name=IMOK_CDNm]").val("");       
		formObj.find("[name=CITM_CDNm]").val("");  
		formObj.find("[name=EITM_CDNm]").val(""); 
		formObj.find("[name=FSCL_YMNm]").val(""); 
		formObj.find("[name=ORG_CDNm]").val(""); 
		formObj.find("[name=MPB_FSCL_CDNm]").val(""); 
		formObj.find("[name=MPB_ACCT_CDNm]").val(""); 
		
	}
}

function initInputPopup(colNm){
	var formObj = $("form[name=OpenInfSColView]");         
	switch(colNm)                    
	{                        
		case "OFFC_CD":      //중앙관서코드 
			formObj.find("[name=FSCL_CD]").val(""); 
			formObj.find("[name=FSCL_CDNm]").val(""); 
			formObj.find("[name=ACCT_CD]").val(""); 
			formObj.find("[name=ACCT_CDNm]").val(""); 
			formObj.find("[name=FGO_CD]").val(""); 
			formObj.find("[name=FGO_CDNm]").val(""); 
			break; 
		case "FSCL_CD":      //회계코드
			formObj.find("[name=ACCT_CD]").val(""); 
			formObj.find("[name=ACCT_CDNm]").val(""); 
			formObj.find("[name=FGO_CD]").val(""); 
			formObj.find("[name=FGO_CDNm]").val(""); 
			break; 
		case "ACCT_CD":      //계정코드
			formObj.find("[name=FGO_CD]").val(""); 
			formObj.find("[name=FGO_CDNm]").val(""); 
			break; 
		case "FLD_CD":      //분야코드
			formObj.find("[name=SECT_CD]").val(""); 
			formObj.find("[name=SECT_CDNm]").val(""); 
			formObj.find("[name=PGM_CD]").val(""); 
			formObj.find("[name=PGM_CDNm]").val(""); 
			formObj.find("[name=ACTV_CD]").val(""); 
			formObj.find("[name=ACTV_CDNm]").val(""); 
			break; 
		case "SECT_CD":      //부문코드
			formObj.find("[name=PGM_CD]").val(""); 
			formObj.find("[name=PGM_CDNm]").val(""); 
			formObj.find("[name=ACTV_CD]").val(""); 
			formObj.find("[name=ACTV_CDNm]").val(""); 
			break; 
		case "PGM_CD":      //프로그램코드
			formObj.find("[name=ACTV_CD]").val(""); 
			formObj.find("[name=ACTV_CDNm]").val(""); 
			break; 
		case "IKWAN_CD":      //수입관 
			formObj.find("[name=IHANG_CD]").val(""); 
			formObj.find("[name=IHANG_CDNm]").val(""); 
			formObj.find("[name=IMOK_CD]").val(""); 
			formObj.find("[name=IMOK_CDNm]").val(""); 
			break; 
		case "IHANG_CD":      //수입항
			formObj.find("[name=IMOK_CD]").val(""); 
			formObj.find("[name=IMOK_CDNm]").val(""); 
			break;
		case "CITM_CD":      //지출목
			formObj.find("[name=EITM_CD]").val(""); 
			formObj.find("[name=EITM_CDNm]").val(""); 
			break; 
		case "ORG_CD":      //직제코드
			formObj.find("[name=MPB_FSCL_CD]").val(""); 
			formObj.find("[name=MPB_FSCL_CDNm]").val("");                    
			formObj.find("[name=MPB_ACCT_CD]").val(""); 
			formObj.find("[name=MPB_ACCT_CDNm]").val(""); 
			break;
		case "MPB_FSCL_CD":      //예산편성회계코드
			formObj.find("[name=MPB_ACCT_CD]").val(""); 
			formObj.find("[name=MPB_ACCT_CDNm]").val(""); 
			break;
	}
}


function setIbSheetCol(){
	var checkList =  $(".check-list input");            
	for(var i = 0; i < 2 ;i++){
		checkList.each(function(index,item){                                  
			if($(item).is(":checked") == true){       
				mySheet1.SetColHidden(index+1,false);   
				mySheet1.SetColWidth(index+1, Number(widhtArr[index+1]));      
			}else{                                           
				mySheet1.SetColHidden(index+1,true);            
			}
		});  
	}                                             
	
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
				<c:choose>
					<c:when test="${viewLang eq 'E'}">
						<h2>VIEW - Sheet</h2>
					</c:when>
					<c:otherwise>         
						<h2>미리보기 - Sheet</h2>
					</c:otherwise>
				</c:choose>
			</div>
			<!-- 탭 -->
			<ul class="tab-popup">
 				<%-- <c:choose>
					<c:when test="${viewLang eq 'E'}">
						<li class="first"><a href="#" id="a_kr">KOR VIEW</a></li>
						<li class="on"><a href="#" id="a_en">ENG VIEW</a></li>
					</c:when>
					<c:otherwise>         
						<li class="first on"><a href="#" id="a_kr">한글보기</a></li>
						<li><a href="#" id="a_en">영문보기</a></li>
					</c:otherwise>
				</c:choose> --%>
			</ul>
			
			<!-- 탭 내용 -->                 
			<div class="content-popup">
				<form name="OpenInfSColView"  method="post" action="#">             
						<input type="hidden" name="fileDownType" value=""/> 
						<input type="hidden" name="infId" value="${openInfSrv.infId}"/>
						<input type="hidden" name="srvCd" value="${openInfSrv.srvCd}"/>
						<input type="hidden" name="viewLang" value=""/>        
						<input type="hidden" name="tblId">          
						<input type="hidden" name="popColId">                   
						<input type="hidden" name="applyYn" value="N"/>                         
						<input type="hidden" name="gridItem" value=""/>    
						<%--      
						<input type="hidden" name="fsYn" value="${fsObj.fsYn}"/>                  
						<input type="hidden" name="gofDivCd" value="${fsObj.fsCd}"/> --%>       
					<div class="popup"style="display:none;width:500px;position:absolute;z-index:20;padding-bottom:20px;">        
					<h3 class="infNm">검색</h3>               
					<a href="#" class="popup_close">X</a>                                   
					<div style="padding:25px 15px 10px 15px;">
						<div class="list-search" style="margin-bottom:3px;">
							<p><strong>Total: 0</strong></p>             
							<div>
								<input type="text" name="popupSerarch"/>
								<button type="button" class="btn01"><spring:message code='btn.inquiry'/></button>
							</div>
						</div>         
						<table class="list02 op">
							<colgroup>
								<col width="50"/>
								<col width="220"/>
								<col width="220"/>
							</colgroup>                
							<tr>
								<th class="ac"><spring:message code='etc.select'/></th>                 
								<th><spring:message code='labal.code'/></th>
								<th><spring:message code='labal.codeNm'/></th>
							</tr>       
						</table>
						
					</div>
					
					<ul class="paging">
					</ul>
				</div>                                           
						<table class="list01" style="position:relative;">
						<caption>공공데이터목록리스트</caption>
						<colgroup>
							<col width="250"/>
							<col width=""/>             
						</colgroup>
						<c:forEach var="cond" items="${cond}" varStatus="status">
						<tr>
							<th><c:out value="${cond.colNm}"/><c:if test="${cond.filtNeed eq 'Y'}"> <span>*</span></c:if></th>                 
							<c:choose>
							
								<c:when test="${cond.filtCd eq 'CHECK'}">
								<td style='padding-top:5px;padding-bottom:5px;'>        
									<c:forEach var="condDtl" items="${condDtl}" varStatus="status1">                
										<c:if test="${cond.srcColId eq condDtl.srcColId}">        
											<c:choose>
												<c:when test="${cond.filtDefault eq condDtl.ditcCd}">
													<input type="checkbox" id="${condDtl.ditcCd}" name="${condDtl.srcColId}" checked="checked" value="${condDtl.ditcCd}"/>                   
												</c:when>
												<c:otherwise>             
													<input type="checkbox" id="${condDtl.ditcCd}" name="${condDtl.srcColId}" value="${condDtl.ditcCd}"/>                   
												</c:otherwise>
											</c:choose>
											<label for="${condDtl.ditcCd}"/><c:out value="${condDtl.ditcNm}"/></label>      
										</c:if>                    
									</c:forEach>
									<input type="hidden" name="checkFiltNeed" value="${cond.filtNeed}"/>                          
								</c:when>
								
								<c:when test="${cond.filtCd eq 'COMBO'}">
								<td>   
									<select name="${cond.srcColId}"><option value=''></option>
									<c:forEach var="condDtl" items="${condDtl}" varStatus="status1">            
										<c:if test="${cond.srcColId eq condDtl.srcColId}">    
											<c:set var="dataD"/>
											<fmt:formatDate value="<%=new java.util.Date()%>" pattern="yyyy" var="dateD"/>              
											<c:choose>               
												<c:when test="${cond.srcColId eq 'FSCL_YY' && cond.filtDefault eq ''}">
													<c:choose>                     
														<c:when test="${condDtl.ditcCd eq dateD}">
															<option value="<c:out value="${condDtl.ditcCd}"/>" selected="selected"><c:out value="${condDtl.ditcNm}"/></option>
														</c:when>
														<c:otherwise>
															<option value="<c:out value="${condDtl.ditcCd}"/>"><c:out value="${condDtl.ditcNm}"/></option>    
														</c:otherwise>
													</c:choose>
												</c:when>
												<c:otherwise>
													<c:choose>
														<c:when test="${cond.filtDefault eq condDtl.ditcCd}">
															<option value="<c:out value="${condDtl.ditcCd}"/>" selected="selected"><c:out value="${condDtl.ditcNm}"/></option>
														</c:when>
														<c:otherwise>
															<option value="<c:out value="${condDtl.ditcCd}"/>"><c:out value="${condDtl.ditcNm}"/></option>    
														</c:otherwise>
													</c:choose>
												</c:otherwise>
											</c:choose>
										</c:if>                                          
									</c:forEach> 
									</select>    
									<input type="hidden" name="comboFiltNeed" value="${cond.filtNeed}"/>      
								</c:when>
								
								<c:when test="${cond.filtCd eq 'RADIO'}">
								<td style='padding-top:5px;padding-bottom:5px;'>        
									<c:forEach var="condDtl" items="${condDtl}" varStatus="status1">    
									<c:if test="${cond.srcColId eq condDtl.srcColId}">  
										<c:choose>
											<c:when test="${cond.filtDefault eq condDtl.ditcCd}">
												<input type="radio" name="${condDtl.srcColId}" id="${condDtl.ditcCd}" checked="checked" value="${condDtl.ditcCd}">
											</c:when>
											<c:otherwise>
												<input type="radio" name="${condDtl.srcColId}" id="${condDtl.ditcCd}" value="${condDtl.ditcCd}">              
											</c:otherwise>
										</c:choose>
										<label for="${condDtl.ditcCd}"><c:out value="${condDtl.ditcNm}"/></label>          		
									</c:if>                                 
								</c:forEach> 
								<input type="hidden" name="radioFiltNeed" value="${cond.filtNeed}"/>      
								</c:when>
								
								<c:when test="${cond.filtCd eq 'FDATE' || cond.filtCd eq'LDATE' || cond.filtCd eq 'PDATE' || cond.filtCd eq 'SDATE' || cond.filtCd eq 'CDATE'}">
								<td>      
									<input type="text" name="${cond.srcColId}" readonly="readonly"/> ~ <input type="text" name="${cond.srcColId}" readonly="readonly"/>
									<input type="hidden" name="filtMaxDay" value="${cond.filtMaxDay }"/>
									<button type='button' class='btn10' name="dateBtn10" title="<spring:message code='btn.init'/>"><spring:message code='btn.init'/></button>
								</c:when>
								
								<c:when test="${cond.filtCd eq 'WORDS'}">
								<td>      
									<input type="text" name="${cond.srcColId}"/> 
								</c:when>
								
								<c:when test="${cond.filtCd eq 'POPUP'}">         
								<td>                                                
									<input type='text' name="${cond.srcColId}Nm"  readonly='readonly' value="${cond.filtDefault}"/>                                
									<input type='hidden' name="${cond.srcColId}" value="${cond.filtDefault}"  readonly='readonly'/>                 
									<input type='hidden' name='realTblId' value="${cond.filtTblCd}" readonly='readonly'/>                   
									<button type='button' class='btn09' title="<spring:message code='btn.inquiry'/>"><spring:message code='btn.inquiry'/></button>
									<button type='button' class='btn10' name="popBtn10" title="<spring:message code='btn.init'/>"><spring:message code='btn.init'/></button>
									<input type='hidden' name='popFiltNeed' value="${cond.filtNeed}" />                     
								</c:when>
								              
								<c:when test="${cond.filtCd eq 'PLINK'}">
								<td>              
									<a target='_blank' href=''${cond.filtDefault}' class='on' title=''${cond.filtDefault}'>${cond.filtDefault}</a>                        
								</c:when>
							</c:choose>                        
							</td>                   
							</tr>
						</c:forEach>   
						<tr style="display:none">     
							<th ><spring:message code='labal.itemSelect'/></th>
							<td style="padding-top:5px;padding-bottom:5px;">
								<button type="button" class="btn01L" title="항목선택" id="article">항목선택▼</button>
							</td>
						</tr>                                                                  
					</table>	
					<a href="#" title="<spring:message code='btn.close'/>" class="btn_openclose"><spring:message code='btn.close'/></a>        
				</form>
				<div class="ibsheet-header">		
					<p>
						${sessionScope.button.btn_reSearch}
					</p>  
				</div>
				
				<div class="sheet-header">
					<!-- 항목선택1 -->
					<div class="popup" style="width:300px;height:340px;position:absolute;top:504px;left:182px;z-index:20;display:none;">
						<h3><spring:message code='labal.itemSelect'/></h3>
						<a href="#" class="popup_close">X</a>
						<div style="padding:15px;min-width:270px;">
							<div class="item-select">
								<p>
									<a href="#" class="itembtn03" title="<spring:message code='labal.allSelect'/>" name="itemChecks"><spring:message code='labal.allSelect'/></a>
									<a href="#" class="itembtn04" title="<spring:message code='labal.allUnSelect'/>" name="itemUnCheck"><spring:message code='labal.allUnSelect'/></a>
									<span class="item-txt"><spring:message code='labal.allSelectUnSelect'/></span> 
								</p>
							</div>       
							<div class="check-list" style="height:165px;">
							<c:forEach var="head" items="${head}"  varStatus="status">
								<input type="checkbox" name="itemCheck" checked="checked" value="${head.srcColId}">${head.colNm}<br/>
							</c:forEach>
							</div>            
						</div>           
						<div class="buttons" style="margin:0;text-align:center;">
							<a href="#" id="btn02" class="btn02" title="<spring:message code='btn.apply'/>"><spring:message code='btn.apply'/></a>
						</div>
					</div>						
					</div>      
				
				<div style="clear: both;"></div>
				<div class="ibsheet_area_both">
					<script type="text/javascript">createIBSheet("mySheet1", "100%", "300px"); </script>             
				</div>
				 <c:if test="${!empty ds_exp && ds_exp ne ''}">                     
				 	<div class="comment">                                
				 		${fn:replace(ds_exp,crlf,'<br/>')}                                                         
					</div>                                       
				 </c:if>
						            
			</div>
			<div class="buttons">            
				<c:choose>
					<c:when test="${viewLang eq 'E'}">
						<a href='#' class='btn02' name='a_close'>close</a>       
					</c:when>
					<c:otherwise>         
						<a href='#' class='btn02' name='a_close'>닫기</a>       
					</c:otherwise>        
				</c:choose>         
			</div>	
		</div>		
	</div>
</html>