<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%-- 메인 옥의 티를 찾아라 팝업화면	  											    --%>
<%--																		--%>
<%-- @author Softon															--%>
<%-- @version 1.0 2021/01/05												--%>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<!DOCTYPE html>
<html lang="ko">
<head>
<title>대한민국 국회 디자인 선호도 조사 참여</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no, target-densitydpi=medium-dpi">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="format-detection" content="telephone=no">
<meta name="copyright" content="대한민국국회. ALL RIGHTS RESERVED.">
<script type="text/javascript" src="<c:url value="/js/jquery/jquery-2.2.4.min.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/jquery/jquery-ui.min.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/jquery/json.min.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/jquery/jquery.form.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/jquery/jquery.cookie.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/jquery/jquery.meio.mask.js" />" charset="utf-8"></script>
<script type="text/javascript" src="<c:url value="/js/common/base/commonness.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/common/base/delegation.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/soportal/common/common.js" />"></script>
<link rel="stylesheet" type="text/css" href="/css/portal/assembly.css">
<script type="text/javascript" src="/js/jquery/fullpage/jquery.fullpage.min.js"></script>
<link rel="stylesheet" type="text/css" href="/js/jquery/fullpage/jquery.fullpage.css">
<style type="text/css">
*{line-height:0;}
</style>

<script type="text/javascript">
$(document).ready(function() {
    $('#fullpage').fullpage({
        //options here
        autoScrolling:true,
        scrollHorizontally: true
    });
});
</script>
    
</script>

</head>   
<body>
    <div id="fullpage">
        <div class="section"><img src="<c:url value="/images/assembly/1sample-1.png"/>"></div>
        <div class="section"><img src="<c:url value="/images/assembly/1sample-2.png"/>"></div>
        <div class="section"><img src="<c:url value="/images/assembly/1sample-3.png"/>"></div>  
        <div class="section last_footer"><img src="<c:url value="/images/assembly/1sample-4.png"/>"></div>        
    </div>
</body>
</html>