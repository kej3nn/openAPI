<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="egovframework.common.WiseOpenConfig"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%
	String apikey = "3dac3b05c02ee38e6f02898c63bf6f43";	//openapi.wise.go.kr
   //치환 변수 선언
    pageContext.setAttribute("cr", "\r"); //Space
    pageContext.setAttribute("cn", "\n"); //Enter
    pageContext.setAttribute("crcn", "\r\n"); //Space, Enter
    pageContext.setAttribute("br", "<br/>"); //br 태그
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><spring:message code='wiseopen.title'/></title>                    
<c:import  url="/WEB-INF/jsp/inc/headinclude.jsp"/>
<style type="text/css">
body{background:none;} /* 임시로 해놓은 것임 */
.iwStyle { width:148px; min-height:23px; display:table-cell; vertical-align:middle; word-break:break-all; padding:3px; text-align:center; font-weight:bold; }
</style>
</head> 
<link rel="stylesheet" href="/css/map/theme/default/style.css" type="text/css"/>
<link rel="stylesheet" href="/css/map/style.css" type="text/css"/>
<link rel="stylesheet" type="text/css" href="http://serverapi.arcgisonline.com/jsapi/arcgis/3.1/js/dojo/dijit/themes/claro/claro.css"/>
<script type="text/javascript" src="http://serverapi.arcgisonline.com/jsapi/arcgis/?v=3.1"></script>
<script type="text/javascript" src="//apis.daum.net/maps/maps3.js?apikey=<%=apikey%>" charset="utf-8"></script>                                                
<script language="javascript">              
//<![CDATA[  
var map;           
$(document).ready(function()    {           
	inputSet();
	setMap();
});                                                     

function doAction(sAction)                                  
{
	var formObj = $("form[name=OpenInfMColView]");       
	switch(sAction)                                              
	{          
		case "lang":            
			formObj.attr("action","<c:url value='/admin/service/openInfColViewPopUp.do'/>").submit();
			break;
	}                                                                                                                 
}                         

function inputSet(){
	var formObj = $("form[name=OpenInfMColView]");                  
	$("a[name=a_close]").click(function(e) { 
		window.close();
		 return false;                             
	 });              
}

function setMap(){
	//중심좌표
	map =  new daum.maps.Map(document.getElementById('map'), {
		center: new daum.maps.LatLng(${latitude}, ${longitude}), 
		level: ${mapLevel}
	});
	
	var zoomControl = new daum.maps.ZoomControl();
	map.addControl(zoomControl, daum.maps.ControlPosition.RIGHT);
	var mapTypeControl = new daum.maps.MapTypeControl();
	map.addControl(mapTypeControl, daum.maps.ControlPosition.TOPRIGHT);

	// 컬럼명
	var colList = {
               <c:forEach var="colData" items="${colList}" varStatus="status">
   					<c:choose>
	               		<c:when test="${status.index eq 0}">
	               			${colData.colId} : "${colData.colNm}"
	               		</c:when>
	               		<c:otherwise>
	               			, ${colData.colId} : "${colData.colNm}"
	               		</c:otherwise>
	        		</c:choose>
               </c:forEach>
				};
	
	//위도: latitude
	//경도: longitude
	//col명: 
	var points = [
		//위도, 경도
		<c:forEach var="data" items="${mapData}" varStatus="status">
			<c:choose>
				<c:when test="${status.index eq 0}">
					<c:if test="${data.X_WGS84 != null}">
					new daum.maps.LatLng(${data.Y_WGS84}, ${data.X_WGS84})
					</c:if>
				</c:when>      
				<c:otherwise>
					<c:if test="${data.X_WGS84 != null}">
					,new daum.maps.LatLng(${data.Y_WGS84}, ${data.X_WGS84})
					</c:if>
				</c:otherwise>  
			</c:choose>
		</c:forEach>
		];      
	
	if("${infoWin}" == "Y"){
		//위치정보 컬럼
		var points_info =
			[
				//위도, 경도
				<c:forEach var="data" items="${mapData}" varStatus="status">
					<c:choose>
						<c:when test="${status.index eq 0}">
							<c:if test="${data.X_WGS84 != null}">
								<c:forEach var="col" items="${data}" varStatus="dataStatus">
									<c:set var="colValue" value="${fn:replace(col.value,crcn,'')}" />
									<c:set var="colValue" value="${fn:replace(col.value,cr,'')}" />
									<c:set var="colValue" value="${fn:replace(col.value,cn,'')}" />
									<c:if test="${col.key != 'X_WGS84' and col.key != 'Y_WGS84'}">
										<c:choose>
											<c:when test="${dataStatus.index eq 0}">
											"<strong>"+colList.${col.key}+" : </strong><c:out value='${colValue}' /><br>"
											</c:when>
											<c:otherwise>
											+"<strong>"+colList.${col.key}+" : </strong><c:out value='${colValue}' /><br>"
											</c:otherwise>
										</c:choose>
									</c:if>
								</c:forEach>
							</c:if>
						</c:when>      
						<c:otherwise>
							<c:if test="${data.X_WGS84 != null}">
								,
								<c:forEach var="col" items="${data}" varStatus="dataStatus">
									<c:set var="colValue" value="${fn:replace(col.value,crcn,'')}" />
									<c:set var="colValue" value="${fn:replace(col.value,cr,'')}" />
									<c:set var="colValue" value="${fn:replace(col.value,cn,'')}" />
									<c:if test="${col.key != 'X_WGS84' and col.key != 'Y_WGS84'}">
										<c:choose>
											<c:when test="${dataStatus.index eq 0}">
											"<strong>"+colList.${col.key}+" : </strong><c:out value='${colValue}' /><br>"
											</c:when>
											<c:otherwise>
											+ "<strong>"+colList.${col.key}+" : </strong><c:out value='${colValue}' /><br>"
											</c:otherwise>
										</c:choose>
									</c:if>
								</c:forEach>
							</c:if>
						</c:otherwise>
					</c:choose>
				</c:forEach>
				];    
	}
	
	var icon = new daum.maps.MarkerImage(
		"${markerVal}",
		new daum.maps.Size(31, 34),
		new daum.maps.Point(16,34),
		"poly",
		"1,20,1,9,5,2,10,0,21,0,27,3,30,9,30,20,17,33,14,33"
	);            
	
		for(var i = 0; i < points.length; i++) {
			// 다중 마커
	    var marker = new daum.maps.Marker({
	    position: points[i],
	    image: icon
		});
		marker.setMap(map);
         
	    //인포 윈도우
	   if("${infoWin}" == "Y"){
		    daum.maps.event.addListener(marker, 'mouseover', (function(marker, i) {
		    	return function() {
			    		var infowindow = new daum.maps.InfoWindow({
			    			content: "<div style='padding:8px 8px 24px 8px;white-space:nowrap;text-align:left;'>" + points_info[i] + "</div>",
			    		});    		
		    		infowindow.open(map, marker);
		    		
		    		daum.maps.event.addListener(marker, "mouseout", function() {
	      			infowindow.close(map, marker);
	      			});
		    	}
		    })(marker, i));
	    }
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
						<h2>VIEW - Map</h2>
					</c:when>
					<c:otherwise>         
						<h2>미리보기 - Map</h2>
					</c:otherwise>
				</c:choose>
			</div>
			<!-- 탭 -->
			<ul class="tab-popup">
			</ul>             
			
			<!-- 탭 내용 -->                 
			<div class="content-popup">
				<form name="OpenInfMColView"  method="post" action="#">             
						<input type="hidden" name="infId" value="${openInfSrv.infId}"/>
						<input type="hidden" name="srvCd" value="${openInfSrv.srvCd}"/>
						<input type="hidden" name="viewLang" value=""/>                                  
				</form>
				
				<div class="ibsheet_area" id="map" style="height:500px">
				</div>
			</div>
			<div class="buttons">            
				<c:choose>
					<c:when test="${viewLang eq 'E'}">
						<a href='#' class='btn02' title="close" name='a_close'>close</a>       
					</c:when>
					<c:otherwise>         
						<a href='#' class='btn02' title="닫기" name='a_close'>닫기</a>       
					</c:otherwise>        
				</c:choose>         
			</div>	
		</div>		
	</div>
</html>