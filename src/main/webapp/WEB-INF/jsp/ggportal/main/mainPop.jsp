<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery/jquery-2.2.4.min.js"></script>
<title>Popup</title>
</head>
<body>
<table width="" border="0" cellpadding="0" cellspacing="0">
  <tbody><tr>
    <td>
    	<img src="<c:url value="/portal/banner.do?saveFileNm=${param.saveFileNm}" />" alt="${param.srvTit}" width="100%" height="100%" border="0"/>
    </td>
  </tr>
  <tr>
    <td height="30" align="right" bgcolor="#000000">
    <table border="0" cellpadding="0" cellspacing="2">
      <form name="frm" method="post" action=""></form>
        <tbody><tr>
         <td><input class="PopupCheck" type="checkbox" name="pop" onclick="closePop()"></td>
         <td style="font-size:11px;color:#FFFFFF;">1일동안 이 창을 열지 않음</td>
            <td style="font-size:11px;"><a href="javascript:self.close();" onfocus="this.blur()">[닫기]</a></td>
        </tr>
    </tbody></table>
    </td>
  </tr>
</tbody></table>
<script type="text/javascript">
	setTimeout(function() {
		window.resizeTo($("img").eq(0).width(), $("img").eq(0).height() + 120);
	}, 1000);
	
	$("img").eq(0).bind("click", function(event) {
		window.opener.location.href = "${param.linkUrl}";
		window.close();
	});

	function setCookie(name, value, expiredays){
	    var todayDate = new Date();
	        todayDate.setDate (todayDate.getDate() + expiredays);
	        document.cookie = name + "=" + escape(value) + "; path=/; expires=" + todayDate.toGMTString() + ";";
	    }

    function closePop(){
        if ( $("[name=pop]").is(":checked") ) {
        	setCookie("mainPop${param.seqceNo}", "done", 1);
    	}
    	self.close();
	}
</script>
</body>
</html>