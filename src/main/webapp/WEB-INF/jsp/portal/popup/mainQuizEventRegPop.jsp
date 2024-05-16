<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%-- @(#)mainQuizEventRegPop.jsp 1.0 2021/01/05								--%>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%-- 퀴즈 이벤트 등록 팝업화면	  											   		--%>
<%--																		--%>
<%-- @author Softon															--%>
<%-- @version 1.0 2021/01/05												--%>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<!DOCTYPE html>
<html lang="ko">
<head>
<title>열린국회정보 사이트 개편 이벤트 - 국회와 함께하는 "퀴즈 이벤트"</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no, target-densitydpi=medium-dpi">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="format-detection" content="telephone=no">
<meta name="copyright" content="대한민국국회. ALL RIGHTS RESERVED.">
<link rel="stylesheet" type="text/css" href="/css/portal/default.css">
<link rel="stylesheet" type="text/css" href="/css/portal/notokr.css">
<link rel="stylesheet" type="text/css" href="/css/portal/layout.css">
<link rel="stylesheet" type="text/css" href="/css/portal/layout_mobile.css">
<script type="text/javascript" src="<c:url value="/js/jquery/jquery-2.2.4.min.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/jquery/jquery.form.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/common/base/commonness.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/common/base/delegation.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/portal/common.js" />"></script>

<style type="text/css">
*{margin:0;padding:0;font-size:14px;color:#444444;vertical-align:middle;}
input{padding:0 5px;box-sizing:border-box;} 
/* .event_sub{width:898px;} */
.layout_event {width: 898px;margin: 0 auto;padding: 0 20px 100px 20px;background: #ffffff;}
.layout_event .area_logo {height:50px;background: #ffffff;text-align:center; margin-top:30px;}
h1{color:#ffffff;background:#4b4b5b;padding:10px 0;text-align:center;font-size:22px;letter-spacing:-0.5px;}
.event_content{background:#e6eaf0;padding:20px;}
dl{background:#ffffff;padding:20px 15px;margin:10px 0 0 0;}
dl:first-child{margin:0;}
dt{font-weight:bold;padding-left:20px;text-indent:-20px;margin:0 0 10px 0;font-size:17px;}
dd{padding:3px 0 3px 20px;}
dt em{font-size:17px;color:#444444;vertical-align:top;font-style:normal;text-decoration:underline;}
span{color:#ff4900;}
.event_reg{background:#fff4da;padding:20px 15px;margin:10px 0 0 0;}
.event_reg h2{font-size:17px;padding:0 0 10px 0;border-bottom:1px solid #000000;}
.event_reg > div{padding:15px 20px;}
.event_int{overflow:hidden;}
.event_int > div{float:left;margin-left:100px;}
.event_int > div strong{margin-right:10px;}
.event_int > div input{width:100px;height:30px;}
.event_btn{text-align:center;padding:20px 0 0 0;}
.event_btn a{background:#ff781d;text-align:center;color:#ffffff;font-weight:bold;display:inline-block;padding:15px 35px;font-size:16px;}
.event_int div.form_ipt select{width:60px;height:30px;}
.event_int div.form_ipt input{width:60px;}

@media all and (max-width: 1023px) {
	.layout_event{width:auto;}
	.event_int > div{margin:5px 0;float:none;}
	.event_int > div strong{display:block;}
}

</style>
</head>   
<body>
<!-- layout_event -->
<div class="layout_event">
	<form id="event-insert-form" name="event-insert-form" method="post"> 
	<div class="area_logo">
        <a href="<c:url value="/portal/mainPage.do" />" title="국회 홈페이지 이동" class="logo" style="margin-top:36px;"><img src="<c:url value="/images/logo.png" />" alt="국회 홈페이지 이동" /></a>
    </div>
	<div class="event_sub">
		<h1>열린국회정보포털 퀴즈 이벤트</h1>
	    <div class="event_content">
	        <dl>
	            <dt>1. 국회가 보유&middot;관리하는 각종 정보를 인터넷을 통해 알기 쉽게 제공하는 국회 정보공개포털의 명칭은 무엇일까요?</dt>
	            <dd><label><input type="radio" name="q1MemberVal" value="1"> ①열린국회정보</label></dd>
	            <dd><label><input type="radio" name="q1MemberVal" value="2"> ②대한민국국회</label></dd>
	            <dd><label><input type="radio" name="q1MemberVal" value="3"> ③국회의원정보</label></dd>
	            <dd><span>※힌트 : OOOOOO포털</span></dd>
	        </dl>
	        <dl>
	            <dt>2. 제21대 국회의원 중 초선 국회의원은 몇 명일까요?</dt>
	            <dd><label><input type="radio" name="q2MemberVal" value="1"> ①300명</label></dd>
	            <dd><label><input type="radio" name="q2MemberVal" value="2"> ②151명</label></dd>
	            <dd><label><input type="radio" name="q2MemberVal" value="3"> ③74명</label></dd>
	            <dd><span>※힌트 : 국회의원 > 제21대 국회의원 검색 > 당선횟수</span></dd>
	        </dl>
	        <div class="event_reg">
	        	<h2>경품 응모를 위한 정보 등록</h2>
	            <div class="event_int">
	            	<div>
	                    <strong>성명</strong>
	                    <input type="text" name="userNm" title="성명" maxlength="20" autocomplete="on">
	                </div>
	                <div class="form_ipt">
	                	<strong>휴대폰번호</strong>
	                	<select name="userTel1" title="휴대폰번호기지국번호">
	                		<option value="010" selected="selected">010</option>
	                		<option value="011">011</option>
	                		<option value="016">016</option>
	                		<option value="017">017</option>
	                		<option value="018">018</option>
	                		<option value="019">019</option>
	                	</select> -
	                    <input type="text" name="userTel2" maxlength="4" numberOnly> -
	                    <input type="text" name="userTel3" maxlength="4" numberOnly>
	                </div>
	            </div>
	            <div>            	
	            	<span>※본 이벤트에 제공된 개인정보는 「개인정보 보호법」 제21조에 의거하여 경품제공 목적 사용 후 파기되며, 또한 동법 제59조에 따라 개인정보의 누설 또는 타인의 이용에 제공하는 등 부당한 목적으로 사용하지 않을 것을 약속드립니다.</span>
	            </div>
	            <div style="text-align:center;">            	
	            	<input type="checkbox" value="Y" id="agree" title="동의"> <label for="agree">개인정보 수집 및 이용에 동의합니다.</label>
	            </div>
	        </div>
	        <div class="event_btn">
	            <a href="javascript:insertEvent();">이벤트 참여완료</a>
	        </div>
	    </div>
	</div>
	</form>
</div>
<script type="text/javascript">
var getContextPath = "${pageContext.request.contextPath}";

/**
 * 퀴즈이벤트 내용을 등록하는 스크립트이다.
 *
 */
$(function() {
    // 이벤트를 바인딩한다.
    bindEvent();

});
/**
 * 이벤트를 바인딩한다.
 */
function bindEvent() {
	
	$("input:text[numberOnly]").on("keyup", function() {
	    $(this).val($(this).val().replace(/[^0-9]/g,""));
	});

}

/**
 * 이벤트 내용을 등록한다.
 * 
 * @param button {Element} 버튼
 */
function insertEvent() {

    // 데이터를 등록한다.
    doInsert({
        url:"/portal/main/mainQuizEventInsert.do",
        form:"event-insert-form",
        before:beforeInsertEvent,
        after:afterInsertEvent
    });

}

////////////////////////////////////////////////////////////////////////////////
// 전처리 함수
////////////////////////////////////////////////////////////////////////////////
/**
 * 이벤트 내용 등록 전처리를 실행한다.
 * 
 * @param options {Object} 옵션
 * @returns {Object} 데이터
 */
function beforeInsertEvent(options) {
    var form = $("#event-insert-form");

    var isChk1 = form.find(':input[name=q1MemberVal]:radio:checked').val();
    if( !isChk1 ){
    	alert("[1번문항]의 답을 선택하여 주십시오."); 
        return false;
    }

    var isChk2 = form.find(':input[name=q2MemberVal]:radio:checked').val();
    if( !isChk2 ){
    	alert("[2번문항]의 답을 선택하여 주십시오."); 
        return false;
    }
    
    if (com.wise.util.isBlank(form.find("[name=userNm]").val())) {
        alert("성명을 입력하여 주십시오.");
        form.find("[name=userNm]").focus();
        return false;
    }

    if (!com.wise.util.isLength(form.find("[name=userNm]").val(), 1, 20)) {
        alert("성명을 20자 이내로 입력하여 주십시오.");
        form.find("[name=userNm]").focus();
        return false;
    }

    if (com.wise.util.isBlank(form.find("[name=userTel2]").val())) {
        alert("휴대폰 번호를 입력하여 주십시오.");
        form.find("[name=userTel2]").focus();
        return false;
    }
    if (com.wise.util.isBlank(form.find("[name=userTel3]").val())) {
        alert("휴대폰 번호를 입력하여 주십시오.");
        form.find("[name=userTel3]").focus();
        return false;
    }

    if (!form.find("[id=agree]").is(":checked")) {
        alert("개인정보 수집 및 이용에 동의하여 주십시오.");
        form.find("[id=agree]").focus();
        return false;
    }
    
    if ( confirm("작성하신 정보로 퀴즈이벤트에 참여 하시겠습니까?\n\n중복 참여하셔도 한 번 참여하신 것으로 등록됩니다.") ){
    	return true;
    } else {
    	return false;
    }
}

////////////////////////////////////////////////////////////////////////////////
// 후처리 함수
////////////////////////////////////////////////////////////////////////////////
/**
 * 이벤트 내용 등록 후처리를 실행한다.
 * 
 * @param messages {Object} 메시지
 */
function afterInsertEvent(messages) {
	window.close();
}

function fn_onlyNumberChk(obj){	
	if(fn_trim(obj.value).length != 0 && !fn_onlyNumeric(obj.value)){
		alert("휴대폰번호는 숫자만 입력가능합니다.");
		obj.value = "";
		return;
	}
}

function fn_trim(str){
	   str = str.replace(/(^\s*)|(\s*$)/g, "");
	   return str;
}

function fn_onlyNumeric(str){
	 var findStr = str.match(/[0-9]+/);
	 if ( str == findStr ) return true;
	 else return false;
}

</script>

</body>
</html>