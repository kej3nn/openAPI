<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title></title>


<script type="text/javascript" src="<c:url value="/js/jquery/jquery-2.2.4.min.js" />"></script>
<script language="javascript">
//<![CDATA[                   
$(document).ready(function()    {
    var xx=700;
	var yy=300;                                             
	var rr=300;                                               
	var a1=0;
	var a2=0;
	for(var i=0; i < 3.14*2; i+=0.05){
		a1 = xx+(Math.round((Math.cos(i))*rr));               
		a2 = yy-(Math.round((Math.sin(i))*rr));
		$("#test").animate({'top':a2},5).animate({'left':a1},5);
	}     
	for(var i=0; i < 3.14*2; i+=0.05){                
		a1 = xx-(Math.round((Math.cos(i))*rr));               
		a2 = yy+(Math.round((Math.sin(i))*rr));
		$("#test2").animate({'top':a2},5).animate({'left':a1},5);
	} 
	var width= 100;
	var falg = true;                            
	while(falg){
		if(width > screen.width){
			falg =false;                          
		}
		width+=5;                                       
		$("#abc").animate({'width':width},20);                                      
	}
    //위아래도 돌리고싶다..        	    
});                     
//]]>  
</script> 
</head>
<body>     
	<div id="abc" style="background-color:red;width: 100px;height: 80px;position: absolute;left:0px; top: 0px;">              
		나중에 심심하면 태극기나 만들어야겠다.                              
	</div>                                          
	<div id="test" style="background-color:red;width: 200px;height: 80px;position: absolute;left:1000px; top: 300px;">              
		500 error.... 
	</div>
	<div id="test2" style="background-color:red;width: 200px;height: 80px;position: absolute;left:1000px; top: 300px;">              
		- Tomcat 컴파일은 열라 안됨...
		<br/>        
		- 할짓 겁나 없네...                                                   
	</div>
</body>
</html>

