<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="egovframework.common.WiseOpenConfig"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
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
	buttonEvent();                                         
	setInput();
	setTree();                               
	doAction("search");   
	
});                                                                          

function setInput(){
	var formObj = $("form[name=OpenInfTColView]");    
	              
	if("${openInfSrv.dataOrder}" != ""){       
		if("${openInfSrv.ymqTag}" == "M"){
			formObj.find("select[name=ymqTag]").val("M").change();
		}else if("${openInfSrv.ymqTag}" == "Q"){
			formObj.find("select[name=ymqTag]").val("Q").change();
		}else if("${openInfSrv.ymqTag}" == "Y"){
			formObj.find("select[name=ymqTag]").val("Y").change();    
		}                               
		//년
		formObj.find("select[name=yyStYy]").val("${openInfSrv.yyStYy}");
		formObj.find("select[name=yyEnYy]").val("${openInfSrv.yyEnYy}");
		//월            
		formObj.find("select[name=mmStYy]").val("${openInfSrv.mmStYy}");
		formObj.find("select[name=mmEnYy]").val("${openInfSrv.mmEnYy}");
		formObj.find("select[name=mmStMq]").val("${openInfSrv.mmStMq}");             
		formObj.find("select[name=mmEnMq]").val("${openInfSrv.mmEnMq}");
		//분기
		formObj.find("select[name=qqStYy]").val("${openInfSrv.qqStYy}");
		formObj.find("select[name=qqEnYy]").val("${openInfSrv.qqEnYy}");                                                  
		formObj.find("select[name=qqStMq]").val("${openInfSrv.qqStMq}");
		formObj.find("select[name=qqEnMq]").val("${openInfSrv.qqEnMq}");
		formObj.find("select[name=dataOrder]").val("${openInfSrv.dataOrder}");
	}else{
		if("${search.ymqTagM}" == "1"){
			formObj.find("select[name=ymqTag]").val("M").change();
		}else if("${search.ymqTagQ}" == "1"){
			formObj.find("select[name=ymqTag]").val("Q").change();
		}else if("${search.ymqTagY}" == "1"){
			formObj.find("select[name=ymqTag]").val("Y").change();    
		}
		//년
		formObj.find("select[name=yyStYy]").val("${info.yyStYy}");
		formObj.find("select[name=yyEnYy]").val("${yyDate.yyEnYy}");
		//월            
		formObj.find("select[name=mmStYy]").val("${info.mmStYy}");
		formObj.find("select[name=mmEnYy]").val("${mmDate.mmEnYy}");
		formObj.find("select[name=mmStMq]").val("${info.mmStMq}");             
		formObj.find("select[name=mmEnMq]").val("${mmDate.mmEnMq}");
		//분기
		formObj.find("select[name=qqStYy]").val("${info.qqStYy}");
		formObj.find("select[name=qqEnYy]").val("${qqDate.qqEnYy}");                                                  
		formObj.find("select[name=qqStMq]").val("${info.qqStMq}");
		formObj.find("select[name=qqEnMq]").val("${qqDate.qqEnMq}");
	}
}                 

function buttonEvent(){
	$("select[name=ymqTag]").change(function(e) {
		var value = $(this).val();
		$("#mmDiv").hide();                
		$("#qqDiv").hide();                            
		$("#yyDiv").hide();                                
		if(value =="M"){       
			$("#mmDiv").show();                
		}else if(value =="Q"){
			$("#qqDiv").show();
		}else{
			$("#yyDiv").show();
		}
		 return false;                
	 }); 
	
	$("button[name=btn_inquiry]").click(function(e) { //미리보기
		$("input[name=firstYn]").val("N");       
		doAction("search");                                               
		return false;      
	});
	
	
	var formObj = $("form[name=OpenInfTColView]");    
	$("button[name=btn_chart]").click(function(e) { //미리보기
		doAction("chart");                                               
		return false;      
	});
	
	$("a[name=a_close]").click(function(e) { 
		window.close();                      
		 return false;                             
	 }); 
	
	$("#a_kr").click(function(e) { 
		if(formObj.find("input[name=viewLang]").val() ==""){
			return false;
		}
		formObj.find("input[name=viewLang]").val("");
		doAction("lang");
		 return false;                             
	 }); 
	$("#a_en").click(function(e) { 
		if(formObj.find("input[name=viewLang]").val() =="E"){
			return false;
		}                    
		formObj.find("input[name=viewLang]").val("E");
		doAction("lang");
		 return false;                             
	 });         
	
	$("select[name=viewTag]").change(function(e) { 
		$("button[name=btn_inquiry]").click();                   
		 return false;                                                                      
	 });
	
	$("select[name=numCd]").change(function(e) { 
		 setUnit();         
		 $("button[name=btn_inquiry]").click();       
		 return false;                                                                      
	 });
	                             
	$('#article').click(function(){
		if($('#popup2').css("display") != "none"){       
			$('#popup2').toggle('slow');
		}
		$('#popup').toggle('slow');
	});                          
	
	$('#article2').click(function(){
		if($('#popup').css("display") != "none"){       
			$('#popup').toggle('slow');                         
		}
		$('#popup2').toggle('slow');
	});       
	
	$('#btnConvCd').click(function(){
		$("#popup3").css("left", $("#btnConvCd").position().left+50);                                       
		$('#popup3').toggle('slow');
	}); 
	
	$("#close").click(function(){
		$('#article').click();                                               
	});   
	
	$("#close2").click(function(){
		$('#article2').click();                                            
	}); 
	
	$("#close3").click(function(){
		$('#btnConvCd').click();                                            
	});
	
	//항목,원자료 전체 열기
	 var allOpenObj = $("a[name=itemOpen]"); 
		allOpenObj.each(function(index,item){  
			$(item).click(function(e) {          
				var flag =true;
				$(".check-list").eq(index).dynatree("getRoot").visit(function(node){
					node.expand(flag);                                                                  
				}); 
			});                                                                              
		});
		//항목,원자료 전체 닫기
		 var allCloseObj = $("a[name=itemClose]"); 
		allCloseObj.each(function(index,item){  
				 $(item).click(function(e) {          
						var flag =false;
						$(".check-list").eq(index).dynatree("getRoot").visit(function(node){
							node.expand(flag);                                                                  
						}); 
					});                                                     
				});
		
		
		//전체체크
		var itemCheck = $("a[name=itemCheck]");     
		itemCheck.each(function(index,item){               
			$(item).click(function(e){                  
				var flag =true;
				if(index == 2){
					$("input[name=convCdCheck]:checkbox").each(function(index2,item2){  
						if($(item2).val() !="RAW"){                   
							$(item2).prop("checked",flag);                                                      
						}                                                                                                   
					});  
				}else{
					$(".check-list").eq(index).dynatree("getRoot").visit(function(node){
						node.select(flag);                                                       
					}); 
				}
				return false;              
			});             
		}); 
		
		
		//전체체크해제
		var itemUnCheck = $("a[name=itemUnCheck]");                    
		itemUnCheck.each(function(index,item){               
			$(item).click(function(e){                  
				var flag =false;
				if(index == 2){
					$("input[name=convCdCheck]:checkbox").each(function(index2,item2){  
						if($(item2).val() !="RAW"){                   
							$(item2).prop("checked",flag);                                                      
						}                                                                                                   
					});  
				}else{
					$(".check-list").eq(index).dynatree("getRoot").visit(function(node){
						node.select(flag);                                                       
					}); 
				}
				return false;
			});             
		}); 
	
	$("#select2").click(function(e) {  
		var formData = $("#treeForm2").serializeArray();
	    var tree = $("#treeData2").dynatree("getTree");
	    formData = formData.concat(tree.serializeArray());
	    if(jQuery.param(formData) == ""){
	 	    $("input[name=treeData2]").val("");                                                               
	    }else{
	    	 var data = jQuery.param(formData).replace(/&treeData2=/gi,"','").replace(/treeData2=/gi,"'");                                                                 
	 	    $("input[name=treeData2]").val(data+"'");                                                               
	    }
	    $("#close2").click();         
	    $("button[name=btn_inquiry]").click();                                              
	 });
	
	$("#select").click(function(e) {  
		var formData = $("#treeForm").serializeArray();
	    var tree = $("#treeData").dynatree("getTree");
	    formData = formData.concat(tree.serializeArray());
	    if(jQuery.param(formData) == ""){                     
	 	    $("input[name=treeData]").val("");                                                             
	    }else{
	    	 var data = jQuery.param(formData).replace(/&treeData=/gi,"','").replace(/treeData=/gi,"'");                   
	 	    $("input[name=treeData]").val(data+"'");       
	    }                                                              
	    $("#close").click();
	    $("button[name=btn_inquiry]").click();                           
	 });
	                           
	$("#select3").click(function(e) {  
		var formData = $("#convCdForm").serializeArray();
	    if(jQuery.param(formData) == ""){                     
	 	    alert("선택...");                                                                                  
	    }else{
	    	 var data = jQuery.param(formData).replace(/&convCdCheck=/gi,"','").replace(/convCdCheck=/gi,"'");                   
	 	    $("input[name=convCd]").val(data+"'");       
	    }                                                              
	    $("#close3").click();
	    $("button[name=btn_inquiry]").click();                                       
	 });
	
}
function LoadPage(data)                                
{            
	
	if($("input[name=numWgCd]").val() ==""){  
		$("select[name=numCd]").empty();              
		 if(data.unitCd != "" && data.unitCd != "null" && data.unitCd !=null ){            
			 for(var i= 0; i < data.unitCd.length; i++){                    
				 var ditcNm ="";
				 if( "<%=response.getLocale().getLanguage()%>"== 'ko'){       
					 ditcNm =  data.unitCd[i].ditcNm;
				 }else{
					 ditcNm =  data.unitCd[i].ditcNmEng;
				 }
				 if(data.unitCd[i].ditcCd == data.unitCdVal){                  
					 $("input[name=defaultVal]").val(data.unitCd[i].valueCd);
					 $("select[name=numCd]").append("<option value='"+ data.unitCd[i].valueCd+"' selected='selected'>"+ditcNm+"</option>");
				 }else{
					 $("select[name=numCd]").append("<option value='"+ data.unitCd[i].valueCd+"'>"+ditcNm+"</option>");
				 }                                                    
			 }                      
			 $("select[name=numCd]").removeAttr("disabled");                                              
		 }else{       
			 $("select[name=numCd]").attr("disabled","disabled").val("");                
		 }
	}
	                                                               
	mySheet1.Reset();                                            
    with(mySheet1){                                 
    	                                  
    	var cfg = {SearchMode:3,Page:50,ColPage:50};                                                                              
        SetConfig(cfg);                        
        var headerInfo = {Sort:0,ColMove:0,ColResize:1,HeaderCheck:0};
        InitHeaders(data.info.gridColHead, headerInfo); 
                                                         
        InitColumns(data.col);                                                                                                            
        //FitColWidth();                                                                 
        SetExtendLastCol(1);       
        SetDataAutoTrim(0);
        
        if($("select[name=viewTag]").val() =="C"){
        	SetMergeSheet(2);
        	SetColBackColor(0, "#eee");
        	 if($("input[name=itemCnt]").val() == "2"){                             
        		 SetColBackColor(1, "#eee");
        	 }
        }else{                
        	SetMergeSheet(5);   
        }
    }                               
    //default_sheet(mySheet1);                       
    var formObj = $("form[name=OpenInfTColView]");                          
    ajaxBeforeSendAdmin("<c:url value='/admin/ajaxBeforeSendAdmin.do'/>"); //IbSheet 조회전 세션 체크
	var param = {PageParam: "ibpage", Param: "onepagerow=50&"+formObj.serialize()};         
	mySheet1.DoSearchPaging("<c:url value='/admin/service/openInfColViewListAll.do'/>", param);         
}                 


             

function doAction(sAction)                                  
{
	var formObj = $("form[name=OpenInfTColView]");       
	switch(sAction)                                              
	{                            
		case "search":      //조회                                                           
			var url ="";        
			ajaxCallAdmin("<c:url value='/admin/service/openInfColViewPopUpHead.do'/>",formObj.serialize(),LoadPage);
			break;   
		case "lang":            
			formObj.attr("action","<c:url value='/admin/service/openInfColViewPopUp.do'/>").submit();
			break;
		case "chart":      //조회                                                           
			var url ="";        
			formObj.attr("action","<c:url value='/admin/service/openInfColTsChartViewPopUp.do'/>").submit();
			break; 
				
	}                                                                                                                 
}                         


function setUnit(){
	var val= $("select[name=numCd]").val();                         
	var unit = $("select[name=numCd] option:selected").text();                                                                  
	var weight = Number($("input[name=defaultVal]").val())/ Number(val);
	$("input[name=numWgCd]").val(weight);
	$("input[name=numNm]").val(unit);
} 
              

function setTree(){
	 $("#treeData").dynatree({                               
	      persist: false,                                                                                                                 
	      checkbox: true,        
	      clickFolderMode: 3,                                          
	      selectMode: 3,       
	      onPostInit: function(isReloading, isError) {
	         logMsg("onPostInit(%o, %o)", isReloading, isError);
	         // Re-fire onActiva e, so the text is update
	         this.reactivate();                 
	      },                        
	      onDblClick: function(node, event) {
	        logMsg("onDblClick(%o, %o)", node, event);
	        node.toggleExpand();
	      }
	    });
	                        
	 if($(".check-list").eq(1).length > 0){
		 $("#treeData2").dynatree({                               
		      persist: false,                                                                                                                                            
		      checkbox: true,       
		      clickFolderMode: 3,          
		      selectMode: 3,     
		      onPostInit: function(isReloading, isError) {
		         logMsg("onPostInit(%o, %o)", isReloading, isError);
		         // Re-fire onActiva e, so the text is update
		         this.reactivate();                 
		      },        
		      onDblClick: function(node, event) {
		        logMsg("onDblClick(%o, %o)", node, event);
		        node.toggleExpand();
		      }
		    });
	 }
	 
	 var treeData1 ="${openInfSrv.treeData}"; //오작동시 배열로 쪼개야함
	 if(treeData1 == ""){
		 var formData = $("#treeForm").serializeArray();
		    var tree = $("#treeData").dynatree("getTree");
		    formData = formData.concat(tree.serializeArray());
		    if(jQuery.param(formData) == ""){                     
		 	    $("input[name=treeData]").val("");                                                             
		    }else{
		    	 var data = jQuery.param(formData).replace(/&treeData=/gi,"','").replace(/treeData=/gi,"'");                   
		 	    $("input[name=treeData]").val(data+"'");       
		    }           
	 }
		$(".check-list").eq(0).dynatree("getRoot").visit(function(node){
			if(treeData1.indexOf(node.data.key) > -1){
				node.select(true);                  
			}else if(treeData1 ==""){
				//node.select(true);    
			}                     
		}); 
		$(".check-list").eq(0).dynatree("getRoot").visit(function(node){
			node.expand(true);   
		});
		
		if($(".check-list").eq(1).length > 0){
			var treeData2 ="${openInfSrv.treeData2}"; 
			if(treeData2 ==""){          
				var formData = $("#treeForm2").serializeArray();
			    var tree = $("#treeData2").dynatree("getTree");
			    formData = formData.concat(tree.serializeArray());
			    if(jQuery.param(formData) == ""){
			 	    $("input[name=treeData2]").val("");                                                               
			    }else{
			    	 var data = jQuery.param(formData).replace(/&treeData2=/gi,"','").replace(/treeData2=/gi,"'");                                                                 
			 	    $("input[name=treeData2]").val(data+"'");                                                               
			    }
			}
			$(".check-list").eq(1).dynatree("getRoot").visit(function(node){                                   
				if(treeData2.indexOf(node.data.key) > -1){
					node.select(true);                                                    
				}else if(treeData2 ==""){
					//node.select(true);    
				}                                                    
			});    
			$(".check-list").eq(1).dynatree("getRoot").visit(function(node){
				node.expand(true);   
			});
		}          
		
}                  
//]]> 
</script>              
</head>
<body onload="">
<div class="wrap-popup">
		<div  id="popup"  class="popup" style="width:300px;height:320px;position:absolute;top:207px;left:62px;z-index:20;display:none;">
			<h3>항목 선택</h3>
			<a href="#" class="popup_close" id="close">X</a>
			<div style="padding:0 15px;min-width:270px;">
				<div class="item-select">
					<p>
						<a href="#" class="itembtn01" title="<spring:message code='labal.allOpen'/>" name="itemOpen"><spring:message code='labal.allOpen'/></a>
						<a href="#" class="itembtn02" title="<spring:message code='labal.allClose'/>" name="itemClose"><spring:message code='labal.allClose'/></a>
						<span class="item-txt"><spring:message code='labal.allOpenClose'/></span>
						<a href="#" class="itembtn03" title="<spring:message code='labal.allSelect'/>" name="itemCheck"><spring:message code='labal.allSelect'/></a>
						<a href="#" class="itembtn04" title="<spring:message code='labal.allUnSelect'/>" name="itemUnCheck"><spring:message code='labal.allUnSelect'/></a>
						<span class="item-txt"><spring:message code='labal.allSelectUnSelect'/></span> 
					</p>
				</div>
				<form id="treeForm">                    
					<div class="check-list" style="height:165px;" id="treeData">
						<c:url value="${treeDate.data0}"/>                                  
					</div>
				</form>
			</div>
			<div class="buttons" style="margin:10;text-align:center;">
				<a href="#" class="btn02" id="select">적용</a>
			</div>                          
		</div>                       
			<div id="popup2" class="popup" style="width:300px;height:320px;position:absolute;top:207px;left:168px;z-index:20;display:none;">
				<h3>항목 선택</h3>     
				<a href="#" class="popup_close" id="close2">X</a>
				<div style="padding:0 15px;min-width:270px;">
					<div class="item-select">
						<p>
							<a href="#" class="itembtn01" title="<spring:message code='labal.allOpen'/>" name="itemOpen"><spring:message code='labal.allOpen'/></a>
							<a href="#" class="itembtn02" title="<spring:message code='labal.allClose'/>" name="itemClose"><spring:message code='labal.allClose'/></a>
							<span class="item-txt"><spring:message code='labal.allOpenClose'/></span>
							<a href="#" class="itembtn03" title="<spring:message code='labal.allSelect'/>" name="itemCheck"><spring:message code='labal.allSelect'/></a>
							<a href="#" class="itembtn04" title="<spring:message code='labal.allUnSelect'/>" name="itemUnCheck"><spring:message code='labal.allUnSelect'/></a>
							<span class="item-txt"><spring:message code='labal.allSelectUnSelect'/></span> 
						</p>
					</div>
					<form id="treeForm2">
						<div class="check-list" style="height:165px;" id="treeData2">
							<c:url value="${treeDate.data1}"/>                                  
						</div>
					</form>
				</div>
				<div class="buttons" style="margin:10;text-align:center;">
					<a href="#" class="btn02" id="select2">적용</a>
				</div>
			</div>
		
		
		<div id="popup3" class="popup" style="width:300px;height:320px;position:absolute;top:207px;left:500px;z-index:20;display:none;">
				<h3>항목 선택</h3>
				<a href="#" class="popup_close" id="close3">X</a>
				<div style="padding:0 15px;min-width:270px;">
					<div class="item-select">
						<p>
							<a href="#" class="itembtn03" title="<spring:message code='labal.allSelect'/>" name="itemCheck"><spring:message code='labal.allSelect'/></a>
							<a href="#" class="itembtn04" title="<spring:message code='labal.allUnSelect'/>" name="itemUnCheck"><spring:message code='labal.allUnSelect'/></a>
							<span class="item-txt"><spring:message code='labal.allSelectUnSelect'/></span> 
						</p>
					</div>
					<form id="convCdForm">
						<div class="check-list" style="height:165px;">
							<c:forEach var="code" items="${codeMap.convCd}" varStatus="status">
								<c:choose>            
									<c:when test="${code.ditcCd eq 'RAW'}">                                       
										<input type="checkbox" id="${code.ditcCd}" name="convCdCheck" value="${code.ditcCd}" checked="checked"/> 
									</c:when>
									<c:otherwise>                     
										<input type="checkbox" id="${code.ditcCd}" name="convCdCheck" value="${code.ditcCd}"/> 
									</c:otherwise>
								</c:choose>                    
								 <c:choose>
									<c:when test="${viewLang eq 'E'}">
										<label for="${code.ditcCd}">${code.ditcNmEng}</label> <br/>       
									</c:when>
									<c:otherwise>         
										<label for="${code.ditcCd}">${code.ditcNm}</label> <br/>       
									</c:otherwise>            
								</c:choose>           
							</c:forEach> 
						</div>
					</form>         
				</div>
				<div class="buttons" style="margin:10;text-align:center;">
					<a href="#" class="btn02" id="select3">적용</a>
				</div>
			</div>
			
		 
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
				<form name="OpenInfTColView"  method="post" action="#">             
						<input type="hidden" name="infId" value="${openInfSrv.infId}"/>
						<input type="hidden" name="srvCd" value="${openInfSrv.srvCd}"/>
						<input type="hidden" name="viewLang" value="${viewLang}"/>                    
						<input type="hidden" name="firstYn" value="Y"/>             
						<input type="hidden" name="treeData" value="${openInfSrv.treeData}"/>                                                                       
						<input type="hidden" name="treeData2" value="${openInfSrv.treeData2}"/>     
						<input type="hidden" name="convCd"/>  
						<input type="hidden" name="numWgCd"/>              
						<input type="hidden" name="numNm"/>  
						<input type="hidden" name="defaultVal"/>            
					<table class="list01" style="position:relative;">
					<caption>공공데이터목록리스트</caption>  
					<colgroup>
						<col width=""/>
						<col width=""/>
					</colgroup>
					<tr>
						<td colspan="2">
							<span style="float:left;">
								<div style="float: left; margin: 0 10px 0 0;">
									<select name="ymqTag">          
										<c:choose>
											<c:when test="${viewLang eq 'E'}">
												<c:if test="${search.ymqTagM eq '1'}">     
													<option value="M">Month</option>         
												</c:if>
												<c:if test="${search.ymqTagQ eq '1'}">     
													<option value="Q">quarter</option>         
												</c:if>
												<c:if test="${search.ymqTagY eq '1'}">     
													<option value="Y">Year</option>         
												</c:if>
											</c:when>
											<c:otherwise>         
												<c:if test="${search.ymqTagM eq '1'}">     
													<option value="M">월</option>         
												</c:if>
												<c:if test="${search.ymqTagQ eq '1'}">     
													<option value="Q">분기</option>         
												</c:if>
												<c:if test="${search.ymqTagY eq '1'}">     
													<option value="Y">년</option>         
												</c:if>
											</c:otherwise>
										</c:choose>         
									</select>    
								</div>
								<div id="yyDiv" style="display: none; float: left;">           
								<c:if test="${!empty yyDate.yyStYy}">                 
									<select name="yyStYy">
										<c:forEach begin="${yyDate.yyStYy}" end="${yyDate.yyEnYy}" step="1" varStatus="status">
											<option value="${status.index }">${status.index }<spring:message code='labal.yy'/></option>
										</c:forEach> 
									</select> ~
									<select name="yyEnYy">
										<c:forEach begin="${yyDate.yyStYy}" end="${yyDate.yyEnYy}" step="1" varStatus="status">
											<option value="${status.index }">${status.index }<spring:message code='labal.yy'/></option>
										</c:forEach> 
									</select>               
								</c:if>
									
								</div>
								<div id="mmDiv" style="display: none;float: left;">
									<c:if test="${!empty mmDate.mmStYy}">      
										<select name="mmStYy">
											<c:forEach begin="${mmDate.mmStYy }" end="${mmDate.mmEnYy }" step="1" varStatus="status">
												<option value="${status.index }">${status.index }<spring:message code='labal.yy'/></option>
											</c:forEach> 
										</select>
										<select name="mmStMq">
											<c:forEach begin="1" end="12" step="1" varStatus="status">
												<c:if test="${status.index > 9}">     
													<option value="${status.index }">${status.index }<spring:message code='labal.mm'/></option>
												</c:if>
												<c:if test="${status.index < 10}">     
													<option value="0${status.index }">0${status.index }<spring:message code='labal.mm'/></option>
												</c:if>
											</c:forEach> 
										</select>                         
										~
										<select name="mmEnYy">
											<c:forEach begin="${mmDate.mmStYy }" end="${mmDate.mmEnYy }" step="1" varStatus="status">
												<option value="${status.index }">${status.index }<spring:message code='labal.yy'/></option>
											</c:forEach> 
										</select>
										<select name="mmEnMq">
											<c:forEach begin="1" end="12" step="1" varStatus="status">
												<c:if test="${status.index > 9}">     
													<option value="${status.index }">${status.index }<spring:message code='labal.mm'/></option>
												</c:if>
												<c:if test="${status.index < 10}">     
													<option value="0${status.index }">0${status.index }<spring:message code='labal.mm'/></option>
												</c:if> 
											</c:forEach>
										</select>
									</c:if>
								</div>            
								<div id="qqDiv" style="display: none;float: left;">
									<c:if test="${!empty qqDate.qqStYy}">              
										<select name="qqStYy">
										<c:forEach begin="${qqDate.qqStYy }" end="${qqDate.qqEnYy }" step="1" varStatus="status">
											<option value="${status.index }">${status.index }<spring:message code='labal.yy'/></option>
										</c:forEach> 
										</select>
										<select name="qqStMq">
											<c:forEach begin="1" end="4" step="1" varStatus="status">
												<option value="0${status.index }">0${status.index }<spring:message code='labal.qq'/></option>
											</c:forEach>              
										</select>
										~
										<select name="qqEnYy">                 
											<c:forEach begin="${qqDate.qqStYy }" end="${qqDate.qqEnYy }"  step="1" varStatus="status">
												<option value="${status.index }">${status.index }<spring:message code='labal.yy'/></option>
											</c:forEach>            
										</select>
										<select name="qqEnMq">
											<c:forEach begin="1" end="4" step="1" varStatus="status">
												<option value="0${status.index }">0${status.index }<spring:message code='labal.qq'/></option>
											</c:forEach> 
										</select>   
									</c:if>                 
								</div>
								&nbsp;&nbsp;<label for="txt_align" class="text-blue"><strong>정렬</strong></label>
								<select id="txt_align" name="dataOrder">
									<option value="ASC" selected="selected">오름차순</option>
									<option value="DESC">내림차순</option>
								</select>
								&nbsp;${sessionScope.button.btn_inquiry}  
							</span>                 
							<span style="float:right;">               
								<button type="button" class="btn01" name="btn_chart">CHART</button>
							</span>
						</td>             
					</tr>
					<tr>
						<td>
							<button type="button" class="btn01L" title="항목선택" id="article">
								<c:choose>            
									<c:when test="${viewLang eq 'E'}">
										ITEM SELECT▼
									</c:when>
									<c:otherwise>         
										항목선택▼
									</c:otherwise>        
								</c:choose>        
							</button>
							<c:if test="${search.itemCnt eq '2'}">     
								<button type="button" class="btn01L" title="항목선택" id="article2">
									<c:choose>            
										<c:when test="${viewLang eq 'E'}">
											ITEM SELECT▼
										</c:when>
										<c:otherwise>         
											항목선택▼
										</c:otherwise>        
									</c:choose>       
								</button>
							</c:if>
						</td>
						<td align="right">                  
							<button type="button" class="btn01L" title="원자료" id="btnConvCd">
							<c:choose>            
								<c:when test="${viewLang eq 'E'}">
									원자료 영문▼
								</c:when>
								<c:otherwise>         
									원자료▼
								</c:otherwise>        
							</c:choose>       
							</button>				
							<select name="viewTag">
								<option value="C">가로보기</option>         
								<option value="S">세로보기</option>                          
								<c:if test="${search.ymqTagM eq '1' or search.ymqTagQ eq '1'}">     
										<option value="P">표로보기</option>         
								</c:if>                                                                        
							</select>				
							
							<c:choose>
								<c:when test="${unitCd ne ''}">
									<select name="numCd">
										<c:forEach var="code" items="${unitCd}" varStatus="status">
											<c:choose>                 
												<c:when test="${code.ditcCd eq unitCdVal}">                              
													<option value="${code.valueCd}" selected="selected">${code.ditcNm}</option>         
												</c:when>                
												<c:otherwise>                   
													<option value="${code.valueCd}">${code.ditcNm}</option>         
												</c:otherwise>
											</c:choose>
										</c:forEach> 
									</select>
								</c:when>
								<c:otherwise>     
									<select name="numCd" disabled="disabled">
										<option value=""></option>              
									</select>    
								</c:otherwise>
							</c:choose>                
							<select name="pointCd">
								<option value="" >소수점</option>  
								<option value="9">첫번째 자리</option>
								<option value="99">두번째 자리</option>
								<option value="999">세번째 자리</option>
								<option value="9999">네번째 자리</option>
								<option value="99999">다섯번째 자리</option>
							</select>					
						</td>
					</tr>
				</table>			          
				</form>
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