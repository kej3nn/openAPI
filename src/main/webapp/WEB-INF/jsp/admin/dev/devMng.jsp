<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="egovframework.common.WiseOpenConfig"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><spring:message code='wiseopen.title' /></title>
<c:import url="/WEB-INF/jsp/inc/headinclude.jsp" />
</head>
<script language="javascript">   
</script>
<body onload="">
	<div class="wrap">
		<c:import url="/admin/admintop.do"/>
		<!-- ## 메인 ## --> 
		<div class="container">
			<!-- 상단 타이틀 -->
			<div class="title">
				<h2>${MENU_NM}</h2>
				<p>${MENU_URL}</>
			</div>
			<!-- 탭 -->
			<!-- 탭 -->
			<!--리스트 -->
			<div class="content">
				<form name="devMngForm" method="post" action="#">
				<table class="list01">
					<caption>리스트</caption>
					<colgroup>
						<col width="150"/>
						<col width=""/>
						<col width="150"/>
						<col width="" />
					</colgroup>
					<tr>
						<th>안내수신</th>
						<td><input type="checkbox" id="dvpEmailYn" name="dvpEmailYn"><label for="dvpEmailYn">이메일</label>
							<input type="checkbox" id="dvpHpYn" name="dvpHpYn"><label for="dvpHpYn">SMS</label>
							<input type="checkbox" id="dvpKakaoYn" name="dvpKakaoYn"><label for="dvpKakaoYn">카카오알림톡</label></td>
						<th>개발자명</th>
						<td><input type="text" name="searchVal" value="" placeholder="검색어 입력" size="40" />
						${sessionScope.button.btn_inquiry}</td>
					</tr>
					
				</table>
				<div style="clear: both;"></div>
				<div class="ibsheet_area_both">
					<div id="sheet" class="sheet"></div>
				</div>
				<div class="buttons">
				※선택된 개발자에게  수신 허용 여부에 따라 전송됩니다.
					<a href='javascript:;' class='btn02' title="이메일" name="btnEmail" id="btnEmail">이메일</a>
					<a href='javascript:;' class='btn02' title="SMS" name="btnHp" id="btnHp">SMS</a>
					<a href='javascript:;' class='btn02' title="알림톡" name="btnKakao" id= "btnKakao">알림톡</a>
				</div>
				</form>
			</div>
		</div>
	</div>
	
	<!-- 팝업 -->
	<form id="emailForm" name="emailForm" method="post" class="admin_popup">
		<div id="email-sect" class="email-sect"  style="display: none">
			<div class="sheet-detail" id="email-sect-pop">
				<a href="#" id="btnEmailPopX" class="btn_pop_x">X</a>	
				<div class="popup_title">이메일 전송</div>
				<div class="popup_cont"><textarea id="emailContent" cols="5" style="height:200px; width:100%" onkeyup="fn_textareaLengthChk(this, 'len1', 500)"></textarea>
					<span class="byte_r">
					<input type="text" name="len1" id="len1" style="text-align:right;" value="0" readonly="readonly" title="글자수">
				<em>/500 Byte</em>
			</span>
				</div>
				<div class="buttons"><a href='#' class='btn02' title="전송" name="sendEmail" id= "sendEmail">전송</a></div>
			</div>
			<div class="bgshadow">&nbsp;</div>
		</div>
	</form>
	<form id="hpForm" name="hpForm" method="post" class="admin_popup">
		<div id="hp-sect" class="hp-sect"  style="display: none">
			<div class="sheet-detail" id="hp-sect-pop">
				<a href="#" id="btnHpPopX" class="btn_pop_x">X</a>	
				<div class="popup_title">메시지 전송</div>
				<div class="popup_cont"><textarea id="hpContent" cols="5" style="height:200px; width:100%" onkeyup="fn_textareaLengthChk(this, 'len2', 500)"></textarea>
					<span class="byte_r">
					<input type="text" name="len2" id="len2" style="text-align:right;" value="0" readonly="readonly" title="글자수">
					<em>/500 Byte</em>
			</span>
				</div>
				<div class="buttons"><a href='#' class='btn02' title="전송" name="sendHp" id= "sendHp">전송</a></div>
			</div>
			<div class="bgshadow">&nbsp;</div>
		</div>
	</form>
	<form id="kakaoForm" name="kakaoForm" method="post" class="admin_popup">
		<div id="kakao-sect" class="kakao-sect"  style="display: none">
			<div class="sheet-detail" id="kakao-sect-pop">
				<a href="#" id="btnKakaoPopX" class="btn_pop_x">X</a>	
				<div class="popup_title">알림톡 전송</div>
				<div class="popup_cont"><textarea id="kakaoContent" cols="5" style="height:200px; width:100%" onkeyup="fn_textareaLengthChk(this, 'len3', 500)"></textarea>
					<span class="byte_r">
					<input type="text" name="len3" id="len3" style="text-align:right;" value="0" readonly="readonly" title="글자수">
					<em>/500 Byte</em>
			</span>
				</div>
				<div class="buttons"><a href='#' class='btn02' title="전송" name="sendKakao" id= "sendKakao">전송</a></div>
			</div>
			<div class="bgshadow">&nbsp;</div>
		</div>
	</form>
	<!-- //팝업 -->
	
<script type="text/javascript" src="<c:url value="/js/soportal/expose/nasCommon.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/admin/dev/devMng.js" />"></script>
</body>
</html>