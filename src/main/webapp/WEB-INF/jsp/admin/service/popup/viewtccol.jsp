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
	doAction("search");   
	setTree();                     
});                                                                          

function setInput(){                
	var formObj = $("form[name=OpenInfTColView]");    
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
	})
	
	var formObj = $("form[name=OpenInfTColView]");                  
	$("a[name=a_close]").click(function(e) { 
		window.close();                      
		 return false;                             
	 }); 
	
	$("button[name=btn_sheet]").click(function(e) { //미리보기
		doAction("sheet");                                                                     
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
	                        
	$("select[name=seriesCd]").change(function(){
		changeSelect();
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
	
	$("#close").click(function(){
		$('#article').click();                                               
	});   
	
	$("#close2").click(function(){
		$('#article2').click();                                            
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
				$(".check-list").eq(index).dynatree("getRoot").visit(function(node){
					node.select(flag);                                                       
				}); 
				return false;              
			});             
		}); 
		
		
		//전체체크해제
		var itemUnCheck = $("a[name=itemUnCheck]");                    
		itemUnCheck.each(function(index,item){               
			$(item).click(function(e){                  
				var flag =false;
				$(".check-list").eq(index).dynatree("getRoot").visit(function(node){
						node.select(flag);                                                       
				}); 
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
}
function initializeChart(data)                                
{             
	myChart.RemoveAll();                                              
	var obj = myChart;
	initChart(obj);//차트 기본색상 셋팅
	//X축 스타일                   
	initXStyleChart(obj,'Purple', 'Purple', "")//chartObj, x색, y색, 이름
	// 왼쪽 Y축 스타일
	initYStyleChart(obj,'Purple', 'Purple', "금액");//chartObj, x색, y색, 이름
	// 왼쪽 Y축 스타일2                              
	initYStylechart2(obj,'Purple', 'Purple', "");//chartObj, x색, y색, 이름
	//툴팁 스타일
	initToolTipSet(obj);//chartObj               
	//범례 스타일                               
	//initLegend(obj,"center","top","horizontal","N");//chartObj, 가로, 세로, 정렬, 플로팅
	//Label 스타일
	initLable(obj);//chartObj                          
	//chart 데이터 추가         
	var val = $("select[name=seriesCd]").val();                                                              
	var type = fnChartType(obj,val);
	fnChartDraw(obj, data,type); //chart명, pointer, pointer이름, 시리즈유형, 시리즈이름 ????????
	fnChartDraw(obj, data); //chart명, pointer, pointer이름, 시리즈유형, 시리즈이름 ????????
	var formObj = $("form[name=OpenInfTColView]");
	formObj.find("input[name=chartCnt]").val(data.DATA.length);
}                 

function changeSelect(){
	var val = $("select[name=seriesCd]").val();                                             
	var obj = myChart;
	var type = fnChartType(obj,val);
	var formObj = $("form[name=OpenInfTColView]");
	var chartCnt = formObj.find("input[name=chartCnt]").val();
	for(var i =0; i < Number(chartCnt); i++){
		 var list = obj.GetSeries(i);                                 
		 list.SetProperty({                                          
			 Type:type                      
		 })                                                            
		 obj.UpdateSeries(list,i);                          
	}                                                     
	 obj.Draw();
}

function doAction(sAction)                                  
{
	var formObj = $("form[name=OpenInfTColView]");       
	switch(sAction)                                              
	{                            
		case "search":      //조회                                                           
			var url ="";        
			ajaxCallAdmin("<c:url value='/admin/service/openInfColViewListAll.do'/>",formObj.serialize(),initializeChart);
			break;   
		case "lang":            
			formObj.attr("action","<c:url value='/admin/service/openInfColTsChartViewPopUp.do'/>").submit();
			break;
		case "sheet":      //조회                                                           
			var url ="";        
			formObj.attr("action","<c:url value='/admin/service/openInfColViewPopUp.do'/>").submit();
			break; 
	}                                                                                                                 
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
		$(".check-list").eq(0).dynatree("getRoot").visit(function(node){
			if(treeData1.indexOf(node.data.key) > -1){
				node.select(true);                  
			}
		}); 
	 	
		$(".check-list").eq(0).dynatree("getRoot").visit(function(node){
			node.expand(true);   
		});
		
		if($(".check-list").eq(1).length > 0){
			var treeData2 ="${openInfSrv.treeData2}"; 
			$(".check-list").eq(1).dynatree("getRoot").visit(function(node){                                   
				if(treeData2.indexOf(node.data.key) > -1){
					node.select(true);                                          
				}                                                    
			});                  B  
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
						<input type="hidden" name="viewTag" value="CC">                 
						<input type="hidden" name="chartCnt" value=""/>                 
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
										<select name="qqStYy">
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
								&nbsp;&nbsp;<label for="txt_align" class="text-blue"><strong>차트유형</strong></label>
								<select class="" name="seriesCd">                   
				                 	<option value="">선택</option>
									<c:forEach var="code" items="${codeMap.seriesCd}" varStatus="status">
									 <c:if test="${code.valueCd2 eq 'BAR'}">                       
											<option value="${code.valueCd}">${code.ditcNm}</option>
									 </c:if>
									  
									</c:forEach>                  
								</select>      
								&nbsp;${sessionScope.button.btn_inquiry}  
							</span>
							<span style="float:right;">
								<button type="button" class="btn01" name="btn_sheet">SHEET</button>
							</span>
						</td>
					</tr>
					<tr>
						<td colspan="2">
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
					</tr>
				</table>			          
				</form>
				<div style="clear: both;"></div>
				<div class="ibsheet_area_both">
					<script type="text/javascript">createIBChart("myChart", "100%", "300px");</script> 
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