<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="egovframework.common.WiseOpenConfig"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><spring:message code='wiseopen.title' /></title>
<c:import url="/WEB-INF/jsp/inc/headinclude.jsp" />
<link rel="stylesheet" type="text/css" media="screen" href='<c:url value="/css/component/multiple-select.css"/>' />
<script type="text/javascript" src="<c:url value="/js/common/component/multiple-select.js" />"></script>
<link rel="stylesheet" href="<c:url value="/css/component/ztree/demo.css" />" type="text/css">
<link rel="stylesheet" href="<c:url value="/css/component/ztree/metroStyle.css" />" type="text/css">
<script type="text/javascript" src="<c:url value="/js/common/component/jquery.ztree.all.min.js" />"></script>  
<script type="text/javascript" src="<c:url value="/js/admin/stat/statPreview.js" />"></script>

</head>
<script language="javascript">   
</script>
</head>
<body onload="">
		
		<div class="container" style="padding: 20px; background: #fff;">
			
			<!-- 리스트 -->
			<div class="content">
				<form name="statMainForm"  method="post" action="#">
				<!-- <input type="hidden" id="statblId" name="statblId" value="TGM179443126539577" /> -->
				<input type="hidden" id="firParam" name="firParam" value="${firParam }" />
				<input type="hidden" id="statblId" name="statblId" value="${statblId }" />
				<input type="hidden" id="wrttimeMinYear" name="wrttimeMinYear" value="" />
				<input type="hidden" id="wrttimeMaxYear" name="wrttimeMaxYear" value="" />
				<input type="hidden" id="wrttimeMinQt" name="wrttimeMinQt" value="" />
				<input type="hidden" id="wrttimeMaxQt" name="wrttimeMaxQt" value="" />
				
				<div class="title">
					<h2>${statblNm }</h2>
				</div>
				<table class="list01">
					<caption>통계표 데이터입력 리스트</caption>
					<colgroup>
						<col width="20%"/>
						<col width="15%"/>
						<col width="60%"/>
					</colgroup>
					<tr>
						<th rowspan="3">주기/기간</th>
						<td rowspan="2">
							<select id="dtacycleCd" name="dtacycleCd" style="width: 100px;">
							</select>
						</td>
						<td>
							<input type="radio" id="wrttimeTypeBetween" name="wrttimeType" value="B"><label for="wrttimeTypeBetween">기간검색</label></input>
							&nbsp;&nbsp;
							<select id="wrttimeStartYear" name="wrttimeStartYear" style="width: 100px;">
							</select>
							<select id="wrttimeStartQt" name="wrttimeStartQt" style="width: 100px;">
							</select>
							~
							<select id="wrttimeEndYear" name="wrttimeEndYear" style="width: 100px;">
							</select>
							<select id="wrttimeEndQt" name="wrttimeEndQt" style="width: 100px;">
							</select>
							
							<button type="button" class="btn01L" title="통계설명" name="statMetaExp" id="statMetaExp" style="float: right; margin-bottom: 3px;">통계설명</button>
						</td>
					</tr>
					<tr>
						<td>
							<input type="radio" id="wrttimeTypeLatest" name="wrttimeType" value="L" checked="checked"><label for="wrttimeTypeLatest">최근시점</label></input>
							&nbsp;&nbsp;	
							<input type="text" name="wrttimeLastestVal" maxlength="3" placeholder="숫자 입력"> 개 검색			
						</td>
					</tr>
					<tr>
						<td colspan="2">
						<input type="radio" id="wrttimeOrderAsc" name="wrttimeOrder" value="A" checked="checked"><label for="wrttimeOrderAsc">오름차순</label></input>&nbsp;
						<input type="radio" id="wrttimeOrderDesc" name="wrttimeOrder" value="D"><label for="wrttimeOrderDesc">내림차순</label></input>
						</td>
					</tr>
					<tr>
						<th id="viewLocOpt-sect-th">보기 옵션</th>
						<td colspan="2">
							<div id="viewLocOpt-sect"></div>
						</td>
					</tr>
					<tr id="viewLocOptUsr-sect" style="display: none;">
						<td colspan="2">
							<label id="optST-label-fr">* 시계열 [&nbsp;</label><span id="optST-sect" style="vertical-align:baseline; color:#515151;"></span><label id="optST-label-to">&nbsp;]&nbsp;&nbsp;</label>
							<label id="optSG-label-fr" style="display: none;">* 그룹 [&nbsp;</label><span id="optSG-sect" style="vertical-align:baseline; color:#515151; display: none;"></span><label id="optSG-label-to" style="display: none;">&nbsp;]&nbsp;&nbsp;</label>
							<label id="optSC-label-fr" style="display: none;">* 분류 [&nbsp;</label><span id="optSC-sect" style="vertical-align:baseline; color:#515151; display: none;"></span><label id="optSC-label-to" style="display: none;">&nbsp;]&nbsp;&nbsp;</label>
							<label id="optSI-label-fr">* 항목 [&nbsp;</label><span id="optSI-sect" style="vertical-align:baseline; color:#515151;"></span><label id="optSI-label-to">&nbsp;]&nbsp;&nbsp;</label>
						</td>
					</tr>
					<tr>
						<td colspan="2">
							<button type="button" class="btn01L" title="그룹선택" id="grpArticle" style="display: none;">
								<c:choose>            
									<c:when test="${viewLang eq 'E'}">
										ITEM SELECT▼
									</c:when>
									<c:otherwise>         
										그룹선택▼
									</c:otherwise>        
								</c:choose>      
							</button>
							<button type="button" class="btn01L" title="항목선택" id="itmArticle" style="display: none;">
								<c:choose>            
									<c:when test="${viewLang eq 'E'}">
										ITEM SELECT▼
									</c:when>
									<c:otherwise>         
										항목선택▼
									</c:otherwise>        
								</c:choose>      
							</button>
							<button type="button" class="btn01L" title="분류선택" id="clsArticle" style="display: none;">
								<c:choose>            
									<c:when test="${viewLang eq 'E'}">
										CATEGORY SELECT▼
									</c:when>
									<c:otherwise>         
										분류선택▼
									</c:otherwise>        
								</c:choose>      
							</button>
						</td>
						<td>
					        <select id="dtadvsVal" name="dtadvsVal" multiple="multiple">
					        </select>
							<select id="uiChgVal" name="uiChgVal" style="width: 100px;">
							</select>
							<select id="dmPointVal" name="dmPointVal" style="width: 100px;">
							</select>
							
							${sessionScope.button.btn_inquiry}
						</td>
					</tr>
				</table>		
				<div style="clear: both;"></div>
				<div class="ibsheet_area_both">
					<script type="text/javascript">createIBSheet("sheet", "100%", "400px"); </script>
					<!-- <div id="sheet" class="sheet"></div>  -->
				</div>
				
				<div id="cmmt-sect" style="border :1px solid; padding: 10px; background-color:rgba(235, 238, 241, 0.35); display: none;">
					<c:if test="${fn:length(cmmtList) gt 0 }">
					<h4>【주】</h4>
					</c:if>
					<c:forEach var="cmmt" items="${cmmtList}" varStatus="status">
						<c:if test="${cmmt.cmmtGubun eq 'TBL' }">
							<h5>${cmmt.cmmtCont }</h5>	
						</c:if>
					</c:forEach>
					<p>
					<table>
					<c:forEach var="cmmt" items="${cmmtList}" varStatus="status">
						<c:if test="${cmmt.cmmtGubun ne 'TBL' }">
							<tr>
								<td style="width:20%"><h6>${cmmt.cmmtIdtfr}</h6></td>
								<td style="width:80%"><h6>${cmmt.cmmtCont }</h6></td>
							<tr>
						</tr>
						</c:if>
					</c:forEach>
					</table>
				</div>
				<button type="button" class="btn01L" title="주석닫기" id="cmmtArticle" style="float:right;">주석열기</button>
			</div>
			</form>               	
		</div>
		
		<div id="loadingCircle" name="loadingCircle" style="position:fixed; top:0px; left:0px; width:100%; height: 100%; z-index:9999999999; display:none;">
			<div style="position:relative; top:50%; left:50%; margin: -37.5px 0 0 -37.5px;"><img src="<c:url value="/images/soportal/desktop/ajax-loader.gif"/>" alt="loading"></div>
		</div>
	
	<div class="wrap-popup">
		<div id="itmTreePop"  class="popup" style="width:300px;height:320px;position:absolute;top:263px;left:30px;z-index:20;display:none;">
			<h3>항목 선택</h3>
			<a href="javascript:;" class="popup_close" id="close">X</a>
			<div style="padding:0 15px;min-width:270px;">
				<div class="item-select">
					<p>
						<a href="#" class="itembtn01" title="<spring:message code='labal.allOpen'/>" name="itmAllExpand"><spring:message code='labal.allOpen'/></a>
						<a href="#" class="itembtn02" title="<spring:message code='labal.allClose'/>" name="itmAllUnExpand"><spring:message code='labal.allClose'/></a>
						<span class="item-txt"><spring:message code='labal.allOpenClose'/></span>
						<a href="#" class="itembtn03" title="<spring:message code='labal.allSelect'/>" name="itmAllChk"><spring:message code='labal.allSelect'/></a>
						<a href="#" class="itembtn04" title="<spring:message code='labal.allUnSelect'/>" name="itmAllUnChk"><spring:message code='labal.allUnSelect'/></a>
						<span class="item-txt"><spring:message code='labal.allSelectUnSelect'/></span> 
					</p>
				</div>
				<form id="treeForm">                    
					<div class="check-list" style="height:165px;">
						<ul id="treeItmData" class="ztree"></ul>
					</div>
				</form>
			</div>
			<div class="buttons" style="margin:10;text-align:center;">
				<a href="javascript:;" class="btn02" id="itmApply">적용</a>
			</div>                          
		</div>  
		<div id="clsTreePop"  class="popup" style="width:300px;height:320px;position:absolute;top:263px;left:134px;z-index:20;display:none;">
			<h3>분류 선택</h3>
			<a href="javascript:;" class="popup_close" id="close">X</a>
			<div style="padding:0 15px;min-width:270px;">
				<div class="item-select">
					<p>
						<a href="#" class="itembtn01" title="<spring:message code='labal.allOpen'/>" name="clsAllExpand"><spring:message code='labal.allOpen'/></a>
						<a href="#" class="itembtn02" title="<spring:message code='labal.allClose'/>" name="clsAllUnExpand"><spring:message code='labal.allClose'/></a>
						<span class="item-txt"><spring:message code='labal.allOpenClose'/></span>
						<a href="#" class="itembtn03" title="<spring:message code='labal.allSelect'/>" name="clsAllChk"><spring:message code='labal.allSelect'/></a>
						<a href="#" class="itembtn04" title="<spring:message code='labal.allUnSelect'/>" name="clsAllUnChk"><spring:message code='labal.allUnSelect'/></a>
						<span class="item-txt"><spring:message code='labal.allSelectUnSelect'/></span> 
					</p>
				</div>
				<form id="treeForm">                    
					<div class="check-list" style="height:165px;">
						<ul id="treeClsData" class="ztree"></ul>
					</div>
				</form>
			</div>
			<div class="buttons" style="margin:10;text-align:center;">
				<a href="javascript:;" class="btn02" id="clsApply">적용</a>
			</div>                          
		</div>  
		<div id="grpTreePop"  class="popup" style="width:300px;height:320px;position:absolute;top:263px;left:134px;z-index:20;display:none;">
			<h3>그룹 선택</h3>
			<a href="javascript:;" class="popup_close" id="close">X</a>
			<div style="padding:0 15px;min-width:270px;">
				<div class="item-select">
					<p>
						<a href="#" class="itembtn01" title="<spring:message code='labal.allOpen'/>" name="grpAllExpand"><spring:message code='labal.allOpen'/></a>
						<a href="#" class="itembtn02" title="<spring:message code='labal.allClose'/>" name="grpAllUnExpand"><spring:message code='labal.allClose'/></a>
						<span class="item-txt"><spring:message code='labal.allOpenClose'/></span>
						<a href="#" class="itembtn03" title="<spring:message code='labal.allSelect'/>" name="grpAllChk"><spring:message code='labal.allSelect'/></a>
						<a href="#" class="itembtn04" title="<spring:message code='labal.allUnSelect'/>" name="grpAllUnChk"><spring:message code='labal.allUnSelect'/></a>
						<span class="item-txt"><spring:message code='labal.allSelectUnSelect'/></span> 
					</p>
				</div>
				<form id="treeForm">                    
					<div class="check-list" style="height:165px;">
						<ul id="treeGrpData" class="ztree"></ul>
					</div>
				</form>
			</div>
			<div class="buttons" style="margin:10;text-align:center;">
				<a href="javascript:;" class="btn02" id="grpApply">적용</a>
			</div>                          
		</div>  
	<iframe id="hidden-iframe" name="hidden-iframe" width="100%" height="0" frameborder="0" scrolling="0" style="display:none;"></iframe>
	<c:import  url="/WEB-INF/jsp/inc/iframepopup.jsp"/> 
</body>

</html>