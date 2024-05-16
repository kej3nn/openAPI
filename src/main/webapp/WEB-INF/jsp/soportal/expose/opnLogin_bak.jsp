<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@page import="com.nprotect.pluginfree.PluginFree"%>
<%@page import="com.nprotect.pluginfree.PluginFreeException"%>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%-- @(#)opnLogin.jsp 1.0 2019/08/12                                   --%>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>

<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ 	--%>
<%-- 정보공개 > 본인확인                      																												   		--%>
<%--                                                                        																						--%>
<%-- @author SoftOn                                                         								 												--%>
<%-- @version 1.0 2019/07/22                                                																			--%>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ 	--%>
<!DOCTYPE html>
<html lang="ko">
<head>
<!-- head include -->
<%@ include file="/WEB-INF/jsp/portal/sect/head.jsp" %>
<script type ="text/javascript" src="<c:url value="/js/common/nProtect/nppfs-1.13.0.js" />" charset="utf-8"></script>
<!--  RSA 암호화 -->
<script type="text/javascript" src="<c:url value="/js/common/rsa/rsa.js" />" charset="utf-8"></script>
<script type="text/javascript" src="<c:url value="/js/common/rsa/jsbn.js" />" charset="utf-8"></script>
<script type="text/javascript" src="<c:url value="/js/common/rsa/prng4.js" />" charset="utf-8"></script>
<script type="text/javascript" src="<c:url value="/js/common/rsa/rng.js" />" charset="utf-8"></script>
</head>
<body>

<!-- header html -->
<%@ include file="/WEB-INF/jsp/portal/sect/header.jsp" %>
<div class="container" id="container">
<!-- leftmenu -->
<%@ include file="/WEB-INF/jsp/portal/sect/lnb.jsp" %>
<!-- //leftmenu -->

<!-- contents -->
	<div class="contents" id="contents">
		<div class="contents-title-wrapper">
			<h3>사용자인증<span class="arrow"></span></h3>
        </div>

<div class="layout_flex">

    <!-- content -->
    <div class="layout_flex_100">
		<h2 class="hide">본인확인</h2>
		<div class="area_h3 area_h3_AB deco_h3_3">
			<h3 class="ty_A"><strong>본인확인</strong></h3>
			<p>본인확인을 위해 <strong class="point-color02" style="vertical-align: top;">실명인증</strong>을 해 주시기 바랍니다.</p>
		</div>

		<form name="form" method="post" class="form-horizontal" action="/portal/expose/openLogin.do">
		<input type="hidden" name="inst_cd" value="10B1000001">
		<input type="hidden" name="cert_cd" value="9700000003">
		<input type="hidden" name="url" value="${requestScope.URL }"/>
		<input type="hidden" name="success" value="${requestScope.success }"/>
		<input type="hidden" name="msg" value="${requestScope.msg }"/>
		<input type="hidden" id="RSAModulus" value="${requestScope.RSAModulus }"/>
		<input type="hidden" id="RSAExponent" value="${requestScope.RSAExponent }"/>
		<input type="hidden" id="login_rno2_RSA" name="login_rno2_RSA"/>
		
        <fieldset>
        <legend>실명인증</legend>
        <section>
            <h4 class="ty_A">실명인증</h4>
            <table class="table_datail_AB w_1 bt2x">
            <caption>실명인증 : 구분, 이름, 주민등록번호</caption>
            <tbody>
            <tr>
                <th scope="row"><label for="Type">구분</label></th>
                <td class="ty_AB ty_B">
						<ul class="for_choose">
							<li><input type="radio" name="login_div" value="1" title="내국인" class="border_none" onclick="fn_ntfrDiv('1')" checked /> 내국인</li>
							<li><input type="radio" name="login_div" value="2" title="외국인" class="border_none" onclick="fn_ntfrDiv('2')" /> 외국인</li>
						</ul>
                </td>
            </tr>
            <tr>
                <th scope="row">
                	<label for="login_name">이름</label>
                </th>
                <td class="ty_AB ty_B">
                	<input type="text" name="login_name" id="login_name" title="이름" value="" autocomplete="on"  class="f_110px userNm" style="ime-mode:active;"/>
                </td>
            </tr>
            <tr>
                <th scope="row">
                	<label for="login_rno"><span id="juminDiv">주민등록번호</span><span id="forDiv" style="display: none;">외국인번호</span></label>
                </th>
                <td class="ty_AB ty_B">
               		<input type="text" class="f_110px" name="login_rno1" id="login_rno1" title="주민등록번호 앞6자리" maxlength="6" onkeyup="fn_rnoFocus();" onkeydown="fn_onlyNumberChk(this)" value=""/> -
					<!-- <input type="password" class="f_110px" name="login_rno2" id="login_rno2" title="주민등록번호 뒤7자리" maxlength="7"  value=""/> -->
					<input type="password" class="f_110px" name="login_rno2" id="login_rno2" title="주민등록번호 뒤7자리" maxlength="7"  npkencrypt="on" data-keypad-type="num" data-keypad-theme="default" data-keypad-useyn-type="checkbox" data-keypad-useyn-input="idKeyPad" value=""/>
					<div class="btn_keypad"><input type="checkbox" id="idKeyPad" name="idKeyPad" onclick="fn_useKeyPad();" checked="checked"><label for="idKeyPad">키패드 사용</label></div>
                </td>
            </tr>
            </tbody>
            </table>
            <div class="area_btn_A">
                <a href="#none" class="btn_A" onclick="fn_certLogin();">확인</a>
            </div>
            
            <div>
            	※ 공공기관의 정보공개에 관한 법률 제10조에 의거 주민등록번호를 처리하고 있습니다<br>
				※ 로그인하시면, 청구인 정보를 마이페이지에 저장하실 수 있습니다. 
            </div>
        </section>
        </fieldset>
		<div class="nppfs-elements" style="display:none"></div>
		<div class="nppfs-keypad-div" style="display:none"></div>
        </form>
     	<div id="nppfs-loading-modal" style="display:none;"></div>   
	</div>
	<!-- // content -->
</div>
<!-- // layout_flex #################### -->
</div></div>

<!-- footer -->
<%@ include file="/WEB-INF/jsp/portal/sect/footer.jsp" %>
<script type="text/javascript" src="<c:url value="/js/soportal/expose/nasCommon.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/soportal/expose/opnLogin.js" />"></script>
</body>
</html>