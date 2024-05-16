<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%-- 국회의원 정보 화면		                    	
<%-- 
<%-- @author JHKIM
<%-- @version 1.0 2019/10/16
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<!DOCTYPE html>
<html lang="ko">
<html>
<head>
<title>국회의원 정보 화면</title>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no, target-densitydpi=medium-dpi" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="format-detection" content="telephone=no" />
<meta name="copyright" content="대한민국국회. ALL RIGHTS RESERVED." />
<meta name="description" content="국회 및 지원기관이 보유한 정보를 체계화하고 통합·공개하여 국민과 공유하고 민간의 활용 촉진과 다양한 맞춤형 서비스를 제공하기 위해 구축된 정보공개 포털 서비스 입니다." />
<meta name="keywords" content="국회사무처,대한민국국회,정보공개,포털" />
<script type="text/javascript" src="<c:url value="/js/jquery/jquery-2.2.4.min.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/jquery/jquery-ui.min.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/jquery/json.min.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/jquery/jquery.form.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/ggportal/data/service/jquery.fileDownload.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/jquery/jquery.cookie.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/jquery/jquery.meio.mask.js" />" charset="utf-8"></script>
<script>
$(function() {
	// 모바일일경우 요약정보 페이지 보여주지 않는다.
	var GC_ISMOBILE =  $(window).width() < 1200 ? true : false
	if ( GC_ISMOBILE ) {
	 	$("#ifm").attr("src", "/portal/assm/memberInfoPage.do?monaCd=${monaCd}&unitCd=${unitCd}");
	}
});
</script>
</head>
<body style="margin:0px;padding:0px;overflow:hidden">
    <iframe src="/portal/assm/memberPage.do?monaCd=${monaCd}&unitCd=${unitCd}" id="ifm" frameborder="0" style="overflow:hidden;overflow-x:hidden;overflow-y:hidden;height:100%;width:100%;position:absolute;top:0px;left:0px;right:0px;bottom:0px"></iframe>
</body>
</body>
</html>