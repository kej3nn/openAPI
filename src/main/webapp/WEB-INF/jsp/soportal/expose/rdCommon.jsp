<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="egovframework.common.WiseOpenConfig"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>  
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>  
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=Edge,chrome=1">
<title><spring:message code='wiseopen.title'/></title>   
<script src="https://open.assembly.go.kr/ReportingServer/html5/js/jquery-1.11.0.min.js"></script>
<script src="https://open.assembly.go.kr/ReportingServer/html5/js/crownix-viewer.min.js"></script>
<link rel="stylesheet" type="text/css" href="https://open.assembly.go.kr/ReportingServer/html5/css/crownix-viewer.min.css">
</head>
<body>
<div id="crownix-viewer" style="position:absolute;width:100%;height:100%;"></div>
<script type="text/javascript">

////////////////////////////////////////////////////////////////////////////////
// RD파일 오픈
////////////////////////////////////////////////////////////////////////////////

$(document).ready(function() { 

	var width    = $("#width").val();
	var height   = $("#height").val();
	var mrdParam = $("#mrdParam").val();
	var mrdPath  = $("#mrdPath").val();
	
	//var mrdParam2 = mrdParam + " /rf [http://10.201.180.231:8128/DataServer/rdagent.jsp] /rsn [opn_admin]"
    var mrdParam2 = mrdParam + " /rf [https://open.assembly.go.kr/DataServer/rdagent.jsp] /rsn [iopn]";

	var viewer = new m2soft.crownix.Viewer('https://open.assembly.go.kr/ReportingServer/service', 'crownix-viewer');
	
	viewer.openFile(mrdPath, mrdParam2);
		
});

</script>

<input type="hidden" id="height" value="<c:out value="${requestScope.height}" />">
<input type="hidden" id="width" value="<c:out value="${requestScope.width}" />">
<input type="hidden" id="mrdParam" value="<c:out value="${requestScope.mrdParam}" />">
<input type="hidden" id="mrdPath" value="<c:out value="${requestScope.mrdPath}" />">
</body>
</html> 
