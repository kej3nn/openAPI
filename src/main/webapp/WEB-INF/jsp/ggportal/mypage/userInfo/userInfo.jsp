<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%--                                                                        --%>
<%-- COPYRIGHT (C) 2013 WISEITECH CO., LTD. ALL RIGHTS RESERVED.            --%>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>

<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%-- 마이페이지 > Qna                      --%>
<%--                                                                        --%>
<%-- @author 장홍식                                                         --%>
<%-- @version 1.0 2015/08/11                                                --%>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<!DOCTYPE html>
<html lang="ko">
<head>
<%@ include file="/WEB-INF/jsp/ggportal/sect/head.jsp" %>
<script type="text/javascript" src="<c:url value="/js/ggportal/myPage/userInfo/userInfo.js" />"></script>
<style type="text/css">
a {cursor:pointer;}
</style>
</head>
<body>
<!-- layout_A -->
<div class="layout_A">
<%@ include file="/WEB-INF/jsp/ggportal/sect/header.jsp" %>
<!-- wrap_layout_flex -->
<div class="wrap_layout_flex fix_page"><div class="layout_flex_100">
<%@ include file="/WEB-INF/jsp/ggportal/sect/gnb.jsp" %>
<!-- layout_flex #################### -->
<div class="layout_flex">
	<%@ include file="/WEB-INF/jsp/ggportal/mypage/sect/left.jsp" %>
    <!-- content -->
    <div id="content" class="content">
        <%@ include file="/WEB-INF/jsp/ggportal/sect/navigation.jsp" %>
        <h2 class="hide"><c:out value="${requestScope.menu.lvl1MenuPath}" /></h2>
		<div class="area_h3 area_h3_AB area_h3_AC deco_h3_4">
			<h3 class="ty_A"><span>공공데이터 개방포털</span><img src="<c:url value="/img/ggportal/desktop/member/h3_4_4.png"/>" alt="회원정보 수정"" /><strong>회원정보 수정</strong></h3>
			<p> <strong>${sessionScope.portalUserNm}</strong>님 환영합니다.</p>
		</div>
        <form id="update-userinfo-form" method="post">
		<fieldset>
		<legend>회원정보 수정</legend>
		<section>
			<h4 class="ty_A mgTm10_mq_mobile">회원정보 수정</h4>
			<div class="area_desc_AB">
				<p class="p_tyC"><img src="<c:url value="/img/ggportal/desktop/common/bul_requisite.png"/>" class="valM" alt="" title="필수입력 항목 아이콘" /> 필수입력 항목입니다.</p>
			</div>
			<table class="table_datail_AB w_1">
			<caption>회원정보 수정</caption>
			<tbody>
			<tr>
				<th scope="row"><label for="name"><strong>이름<span>필수입력</span></strong></label></th>
				<td class="ty_AB ty_B"><input type="text" id="name" name="userNm" autocomplete="on"  class="f_110px" /></td>
			</tr>
			<tr>
				<th scope="row"><label for="telephone">연락처</label></th>
				<td class="ty_AB ty_B">
				    <%--
					<select id="telephone" name="userTel1" style="width:50px;" title="전화번호 앞번호 선택">
					</select> -
					--%>
					<input type="tel" id="telephone"   name="userTel1" pattern="[0-9]{3}" autocomplete="on" style="width:50px; ime-mode:disabled;" /> -
					<input type="tel" id="telephone_2" name="userTel2" pattern="[0-9]{4}" autocomplete="on" style="width:49px; ime-mode:disabled;" /> -
					<input type="tel" id="telephone_3" name="userTel3" pattern="[0-9]{4}" autocomplete="on" style="width:49px; ime-mode:disabled;" />
				</td>
			</tr>
			<tr>
				<th scope="row"><label for="eMail"><strong><abbr title="electronic mail">E-mail</abbr><span>필수입력</span></strong></label></th>
				<td class="ty_AB ty_B">
					<div class="area_form">
						<input type="email" id="eMail" name="userEmail1" class="flL f_170px f_46per" title="E-mail ID" placeholder="E-mail ID" autocomplete="on" />
						<span class="txt talC f_8per_mq_mobile">@</span>
						<input type="email" id="eMail_2" name="userEmail2" class="flL f_110px f_46per" title="E-mail 주소" placeholder="E-mail address" autocomplete="on" />
						<span class="f_mgT3_mq_mobile f_100per_mq_mobile">
							<span class="divi_select paL0_mq_mobile f_46per_mq_mobile">
								<select id="eMail_3" name="userEmail3" class="f_100per_mq_mobile" title="이메일 주소 번지 선택">
								</select>
							</span>
							<span class="chk divi_form divi_form_AC f_46per_mq_mobile"><input type="checkbox" id="emailAgree"/><label for="emailAgree">수신동의</label></span>
							<input type="hidden" name="emailYn" value="N"/>
						</span>
					</div>
				</td>
			</tr>
			</tbody>
			</table>
		</section>
		<div class="area_btn_A">
			<a class="btn_A" id="userinfo-delete-btn">탈퇴</a>
			<a class="btn_A" id="userinfo-update-btn">수정</a>
			<a class="btn_AB" href="javascript:history.back();">취소</a>
		</div>
		</fieldset>
		</form>
	</div>
	<!-- // content -->
</div>
<!-- // layout_flex -->
</div></div>		
<!-- // wrap_layout_flex ############################## -->
<%@ include file="/WEB-INF/jsp/ggportal/sect/footer.jsp" %>
</div>
<!-- // layout_A -->
</body>
</html>