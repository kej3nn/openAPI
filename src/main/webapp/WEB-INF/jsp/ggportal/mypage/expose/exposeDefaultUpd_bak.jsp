<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>

<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ 	--%>
<%-- 마이페이지 > 청구기본정보수정 
<%-- 
<%-- @author jhkim
<%-- @version 1.0 2019/11/26
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

	<div class="contents" id="contents">
		<div class="contents-title-wrapper">
			<h3>청구기본정보수정<span class="arrow"></span></h3>
		</div>
		<form id="form" name="form" method="post">
			<input type="hidden" name="inst_cd" value="10B1000001"/>
			<input type="hidden" name="cert_cd" value="9700000003"/>
			<input type="hidden" id="RSAModulus" value="${requestScope.RSAModulus }"/>
			<input type="hidden" id="RSAExponent" value="${requestScope.RSAExponent }"/>
			<input type="hidden" id="login_rno2_RSA" name="login_rno2_RSA"/>
			<input type="hidden" name="login_name" value="<c:out value="${sessionScope.portalUserNm}" />"/>
			<div class="layout_flex">
				<div class="layout_flex_100">
					<fieldset>
						<section>
							<table class="table_datail_CC w_1 bt2x width_A">
								<caption>
									<c:out value="${requestScope.menu.lvl2MenuPath}" /> 청구인정보 :
									이름,주민등록번호(외국인번호),휴대전화번호,전화번호,모사전송번호,전자우편,주소</caption>
								<tbody>
									<tr>
										<th scope="row"><span class="text_require">* </span>이름</th>
										<td class="mh42x">
											<em><c:out value="${sessionScope.portalUserNm}" /></em>
										</td>
										<th scope="row"><span class="text_require">*</span>주민등록번호(외국인번호)</th>
										<td>
											<c:choose>
											<c:when test="${isReal != null and isReal eq 'Y' }">
												<div id="isReal-sect">
													<div>
														<input type="text" name="user1Ssn" title="주민등록번호 앞6자리" readonly="readonly" style="width:35%;" value="${sessionScope.loginRno1 }"> -
														<input type="password" name="user2Ssn" title="주민등록번호 뒤7자리" readonly="readonly" style="width:35%;" value="*******">
													</div>
												</div>
											</c:when>
											<c:otherwise>
												<div id="isReal-sect">
													<div>
														<input type="text" class="ip01" name="login_rno1" id="login_rno1" title="주민등록번호 앞6자리" maxlength="6"  value=""/> -
														<!-- <input type="password" class="ip02" name="login_rno2" id="login_rno2" title="주민등록번호 뒤7자리" maxlength="7" value=""/> -->
														<input type="password" class="ip02" name="login_rno2" id="login_rno2" title="주민등록번호 뒤7자리" maxlength="7"  npkencrypt="on" data-keypad-type="num" data-keypad-theme="default" data-keypad-useyn-type="checkbox" data-keypad-useyn-input="idKeyPad" value=""/>
														<div class="btn_keypad"><input type="checkbox" id="idKeyPad" name="idKeyPad" onclick="fn_useKeyPad();" checked="checked"><label for="idKeyPad">키패드 사용</label></div>
														<button type="button" class="btn01" name="isRealBtn">실명인증</button>
													</div>
												</div>
											</c:otherwise>
											</c:choose>
										</td>
									</tr>
									<tr>
										<th scope="row"><span class="text_require">*</span>휴대전화번호</th>
										<td>
											<select name="userHp" id="userHp" title="휴대폰 서비스 번호 선택" class="w60x">
												<option value="010">010</option>
												<option value="011">011</option>
												<option value="016">016</option>
												<option value="017">017</option>
												<option value="018">018</option>
												<option value="019">019</option>
												<option value="000">없음</option>
											</select>
											<input type="text" id="userHp2" name=userHp2 value="" title="휴대폰 가운데 자리" maxlength="4" class="w60x" pattern="[0-9]{4}" autocomplete="on" ime-mode:disabled;"> -
											<input type="text" id="userHp3" name="userHp3" value="" title="휴대폰 마지막 자리" maxlength="4" class="w60x" pattern="[0-9]{4}" autocomplete="on" ime-mode:disabled;">
										</td>
										<th scope="row"><span class="text_require">* </span>전화번호</th>
										<td>
											<select name="userTel" id="userTel" title="전화번호 지역번호 선택" class="w60x">
												<option value="02">02</option>
												<option value="031">031</option>
												<option value="032">032</option>
												<option value="033">033</option>
												<option value="041">041</option>
												<option value="042">042</option>
												<option value="043">043</option>
												<option value="051">051</option>
												<option value="052">052</option>
												<option value="053">053</option>
												<option value="054">054</option>
												<option value="055">055</option>
												<option value="061">061</option>
												<option value="062">062</option>
												<option value="063">063</option>
												<option value="064">064</option>
												<option value="070">070</option>
												<option value="000">없음</option>
											</select>
											<input type="text" id="userTel2" name="userTel2" value="" title="전화번호 가운데 자리" class="w60x" maxlength="4" pattern="[0-9]{4}" autocomplete="on" ime-mode:disabled;"> -
											<input type="text" id="userTel3" name="userTel3" value="" title="전화번호 마지막 자리" class="w60x" maxlength="4" autocomplete="on" ime-mode:disabled;">
										</td>
									</tr>
									<tr>
										<th scope="row">모사전송번호</th>
										<td colspan="3">
											<select name="userFaxTel" id="userFaxTel" title="모사전송번호 지역번호 선택" class="w60x">
												<option value="02">02</option>
												<option value="031">031</option>
												<option value="032">032</option>
												<option value="033">033</option>
												<option value="041">041</option>
												<option value="042">042</option>
												<option value="043">043</option>
												<option value="051">051</option>
												<option value="052">052</option>
												<option value="053">053</option>
												<option value="054">054</option>
												<option value="055">055</option>
												<option value="061">061</option>
												<option value="062">062</option>
												<option value="063">063</option>
												<option value="064">064</option>
												<option value="070">070</option>
												<option value="000">없음</option>
											</select>
											<input type="text" id="userFaxTel2" name="userFaxTel2" title="모사전송번호 가운데 자리" maxlength="4" class="w60x" autocomplete="on" ime-mode:disabled;"> -
											<input type="text" id="userFaxTel3" name="userFaxTel3" title="모사전송번호 마지막 자리" maxlength="4" class="w60x" autocomplete="on" ime-mode:disabled;">
										</td>
									</tr>
									<tr>
										<th scope="row">전자우편</th>
										<td colspan="3">
											<input type="text" class="mw40p" id="eMail" name="userEmail1" title="전자우편 아이디 입력" style="ime-mode:inactive;" maxlength="15">@
											<input type="text" class="mw40p" id="eMail_2" name="userEmail2" title="전자우편 도메인 입력" style="ime-mode:inactive;" maxlength="15" readonly="readonly">
											<select id="eMail_3" name="userEmail3" title="전자우편 선택">
												<option value="" selected>선택하세요</option>
												<option value="naver.com">naver.com</option>
												<option value="daum.net">daum.net</option>
												<option value="gmail.com">gmail.com</option>
												<option value="nate.com">nate.com</option>
												<option value="korea.com">korea.com</option>
												<option value="hotmail.com">hotmail.com</option>
												<option value="chol.com">chol.com</option>
												<option value="yahoo.co.kr">yahoo.co.kr</option>
												<option value="assembly.go.kr">assembly.go.kr</option>
												<option value="na">직접입력</option>
											</select>
										</td>
									</tr>
									<tr>
										<th scope="row"><span class="text_require">* </span>주소</th>
										<td colspan="3">
											<input type="text" class="mw70x" name="userZip" id="apl_zpno" title="우편번호" class="input_readonly" readonly="readonly">
											<a title="새창열림_우편번호찾기" href="javascript:;" class="btn_C" id="findAddrBtn">우편번호찾기</a><br>
											<input type="text" name="user1Addr" id="apl_addr1" class="input_readonly input_zip w100p" title="동까지 주소" readonly="readonly"><br>
											<input type="text" name="user2Saddr" id="apl_addr2" title="나머지 주소" class="w100p" style="ime-mode:active;" maxlength="30" />
										</td>
									</tr>
									<tr>
										<th scope="row">청구처리통지</th>
										<td colspan="3">
											<input type="checkbox" title="이메일" class="ml10" id="emailYn" name="emailYn" value="Y">
											<label>이메일</label>
											<input type="checkbox" title="SMS" id="hpYn" name="hpYn" value="Y">
											<label>SMS</label>
											<input type="checkbox" title="카카오알림톡" class="ml10" id="kakaoYn" name="kakaoYn" value="Y">
											<label>카카오알림톡</label>
										</td>
									</tr>
								</tbody>
							</table>
							<div class="area_btn_A">
								<a href="javascript:;" class="btn_inquiries" id="updateBtn">저장</a></li>
							</div>
						</section>
					</fieldset>
					<div class="nppfs-elements" style="display:none"></div>
					<div class="nppfs-keypad-div" style="display:none"></div>
				</div>
			</div>
		</form>
		<div id="nppfs-loading-modal" style="display:none;"></div>
	</div>
</div>
<!-- footer -->
<%@ include file="/WEB-INF/jsp/portal/sect/footer.jsp" %>
<script type="text/javascript" src="<c:url value="/js/ggportal/myPage/expose/exposeDefaultUpd.js" />"></script>
</body>
</html>