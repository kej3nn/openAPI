<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>

<!DOCTYPE html>
<html lang="ko">
<head>
<%@ include file="/WEB-INF/jsp/portal/sect/head.jsp" %>
</head>
<body>
<div class="wrapper" id="wrapper">
<%@ include file="/WEB-INF/jsp/portal/sect/header.jsp" %>
<section>
	<div class="container hide-pc-lnb" id="container">

    <!-- content -->
    <article>
		<div class="contents" id="contents">
       	<div class="contents-title-wrapper">
            <h3>사용자 확인<span class="arrow"></span></h3>
       	</div>
        
        <form action="/portal/user/checkUserProc.do" method="post">
        <div class="contents-area">
		<!-- CMS 시작 -->

			<table class="table_datail_CC w_1 bt2x width_A">
	        	<tbody>
	        		<tr>
	        			<th scope="row">ID</th>
	        			<td><input type="text" name="userId" title="ID"></td>
	        		</tr>
	        		<tr>
	        			<th scope="row">비밀번호</th>
	        			<td><input type="password" name="userPw" class="mw40p" title="비밀번호"></td>
	        		</tr>
	        	</tbody>
	        </table>
	        
	        <div class="area_btn_A">
	        	<input type="submit" id="insert-button" href="javascript:;" class="btn_A" value="확인">
	        </div>
		<!-- //CMS 끝 -->
						
		</div>
	</form>
	</div>
	</article>
	<!-- //contents  -->

</div>
</section>



<%-- 
<div class="container" id="container">
	
	<div class="contents" id="contents">
		<div class="contents-title-wrapper">
			<h3>사용자 확인<span class="arrow"></span></h3>
		</div>
		
<div class="wrap_layout_flex">
<div class="layout_flex_100">
<div class="layout_flex">
    <div id="content" class="container hide-pc-lnb">
        
        <form action="/portal/user/checkUserProc.do" method="post">
        <table class="table_datail_CC w_1 bt2x width_A">
        	<tbody>
        		<tr>
        			<th scope="row">ID</th>
        			<td><input type="text" name="userId"></td>
        		</tr>
        		<tr>
        			<th scope="row">비밀번호</th>
        			<td><input type="password" name="userPw" class="mw40p"></td>
        		</tr>
        	</tbody>
        </table>
        
        <div class="area_btn_A">
        	<input type="submit" id="insert-button" href="javascript:;" class="btn_A" value="확인">
        </div>
        </form>
    </div>
</div>
</div></div>        
</div></div>     --%>   
<%@ include file="/WEB-INF/jsp/portal/sect/footer.jsp" %>
</div>
<!-- // layout_A -->
</body>

</html>