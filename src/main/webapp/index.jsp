<%--
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<html lang="ko">             
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=8" />
<%

	String serverDomain = request.getServerName();
		if(serverDomain.equals("eng.openfiscaldata.go.kr")){
		//if(serverDomain.equals("eng.fios.go.kr")){
%>
	<title>Open Fiscal Data</title>                      
<%		                
	}else{
%>
	<title><spring:message code='wiseopen.portalTitle'/></title>   
<% 
	}
%>                       
</head>                        
<frameset rows="0,*" frameborder="0" >       
		<frame src="" title="top" name="top" marginwidth="0" marginheight="0" />   
		<frame title="main" src="/admin/admLog.do" name="main" marginwidth="0" marginheight="0" />
</frameset>
</html>                     
--%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>

<c:redirect url="/portal/mainPage.do" />