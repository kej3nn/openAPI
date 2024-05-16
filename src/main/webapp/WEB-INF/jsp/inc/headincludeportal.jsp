<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>                                         
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<meta http-equiv="X-UA-Compatible" content="IE=9" />
<link href="${pageContext.request.contextPath}/css/portal/style.css" rel="stylesheet" type="text/css"/>              
<link rel="stylesheet" type="text/css" media="screen" href="/css/jquery-ui-1.9.2.custom.css"/>
<!--                           
<link href="<c:url value='/css/jquery-ui-1.10.4.custom.css'/>" rel="stylesheet" type="text/css"/>
 -->
<link href="${pageContext.request.contextPath}/js/jquery/skin/ui.dynatree.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/common.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/commonValidation.js"></script>                
<script type="text/javascript" src="${pageContext.request.contextPath}/js/commonCalendar.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/commonViewFun.js"></script>                  
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery/jquery-2.2.4.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery/json.min.js"></script>         
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery/jquery-ui.min.js"></script>            
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery/jquery.money.js"></script> 
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery/jquery.form.js"></script> 
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery/jquery.cookie.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery/jquery.dynatree.js"></script>                                             
<script type="text/javascript" src="${pageContext.request.contextPath}/js/sheet/ibsheetinfo.js"></script>                                      
<script type="text/javascript" src="${pageContext.request.contextPath}/js/sheet/ibsheet.js"></script>                            
<script type="text/javascript" src="${pageContext.request.contextPath}/js/chart/ibchart.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/chart/ibchartinfo.js"></script>             
<script type="text/javascript" src="${pageContext.request.contextPath}/validator.do"></script>                                                        
<script type="text/javascript" src="${pageContext.request.contextPath}/js/tabs.js"></script>                                  
<script type="text/javascript" src="${pageContext.request.contextPath}/js/map.js"></script>                         
<script type="text/javascript" src="${pageContext.request.contextPath}/js/commonchart.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/SmartEditor2/js/HuskyEZCreator.js"></script>  
<%-- <script type="text/javascript" src="<c:url value='/js/placeholders.min.js "></script>   --%>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.placeholder.js"></script>
<script type="text/javascript">
var getContextPath = "${pageContext.request.contextPath}";
var serverName ="${pageContext.request.serverName}";
var serverPort ="${pageContext.request.serverPort}";
if(serverPort != "80" ){                                               
	var serverAddr = "http://"+serverName+":"+serverPort+getContextPath;
}else{
	var serverAddr = "http://"+serverName+getContextPath;
}                       
var tabContentClass= "content";               
var tabId = "tab";                          
var tabBody="container .wrap";                  
</script>                