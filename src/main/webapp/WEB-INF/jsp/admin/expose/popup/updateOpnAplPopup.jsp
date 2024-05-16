<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="egovframework.common.WiseOpenConfig"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>  
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>       
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><spring:message code='wiseopen.title'/></title>                  
<c:import  url="/WEB-INF/jsp/inc/headinclude.jsp"/>
</head>                                                
<style type="text/css">
body{background:none;}
a{text-decoration:none; color:#000000;}         
a:hover{color:#ff0000;}        

ul {
    list-style:square inside;
    margin:2px;
    padding:0;
}

li {
    margin: 0 20px 2px 0;
    padding: 7px 7px 0 0;
    border : 0;
    float: left;
}
</style>                  
<script language="javascript">       

$(function() {
	// 컴포넌트를 초기화한다.
    initComp();
 	
	// 이벤트를 바인딩한다.
    bindEvent();
	
 	// 옵션을 로드한다.
    loadOptions();
 	
    // 데이터를 로드한다.
    loadData();
});

////////////////////////////////////////////////////////////////////////////////
//글로벌 변수
////////////////////////////////////////////////////////////////////////////////
var ctxPath = '<c:out value="${pageContext.request.contextPath}" />';

////////////////////////////////////////////////////////////////////////////////
//초기화 함수
////////////////////////////////////////////////////////////////////////////////

/**
 * 컴포넌트를 초기화한다.
 */
function initComp() {
	
}


/**
 * 이벤트를 바인딩한다.
 */
function bindEvent() {
	
	//텍스트박스 글자수 체크
	$("textarea[name=aplModDtsCn]").bind("keyup", function(event) {
		var obj = $("textarea[name=aplModDtsCn]");
		textAreaLenChk(obj, 'len1', 2000);
	});
	
	//텍스트박스 글자수 체크
	$("textarea[name=dcsprodEtEtc]").bind("keyup", function(event) {
		var obj = $("textarea[name=dcsprodEtEtc]");
		textAreaLenChk(obj, 'len2', 2000);
	});
	//결정기한 연장 등록
	$("a[name=a_modify]").bind("click", function(event) {
		saveData();
	});
	
	//팝업창 닫기
	$("a[name=a_close]").bind("click", function(event) {
		window.close();
	});
	
	//공개형태 체인지 이벤트
	$("input[name=opbFomVal]").bind("change", function(event) {
		var val = $(this).val();
		if(val == "05"){ //기타일때 input 활성화
			$("input[name=opbFomEtc]").attr("disabled", false );
		}else{
			$("input[name=opbFomEtc]").val(""); // 초기화
			$("input[name=opbFomEtc]").attr("disabled", true); //비활성화
		}
	});
	
	//수령방법 체인지 이벤트
	$("input[name=aplTakMth]").bind("change", function(event) {
		var val = $(this).val();
		if(val == "05"){ //기타일때 input 활성화
			$("input[name=aplTakMthEtc]").attr("disabled", false );
		}else{
			$("input[name=aplTakMthEtc]").val(""); // 초기화
			$("input[name=aplTakMthEtc]").attr("disabled", true); //비활성화
		}
	});
	
	
}

/**
 * 옵션을 로드한다.
 */
function loadOptions() {
	
	//텍스트박스 글자수
	var obj = $("textarea[name=aplModDtsCn]");
	textAreaLenChk(obj, 'len1', 2000);
	
	
	var opbFomValChk = $("input[name=pOpbFomVal]").val();
	var aplTakMthChk = $("input[name=pAplTakMth]").val();
	
	//라디오 버튼 체크
	$("input:radio[name=opbFomVal][value="+opbFomValChk+"]").prop("checked", true);
	$("input:radio[name=aplTakMth][value="+aplTakMthChk+"]").prop("checked", true);
	
	if(opbFomValChk == "05") $("input[name=opbFomEtc]").attr("disabled", false );
	if(aplTakMthChk == "05") $("input[name=aplTakMthEtc]").attr("disabled", false );
}

/**
 * 데이터를 로드한다.
 */
function loadData() {
	
}

/**
 * 데이터 저장
 */
function saveData() {
	 
	 var formObj = $("form[name=opnDcsProdForm]");
	 
	formObj.ajaxSubmit({
		url : com.wise.help.url("/admin/expose/updateOpnApl.do")
		, async : false
		, type : 'post'
		, dataType: 'json' 
		, contentType : 'application/x-www-form-urlencoded;charset=UTF-8'
		, beforeSubmit : function() {
			//submit 전 validation 체크
			if ( !confirm("수정 하시겠습니까?") )	return false;
			
		}	
		, success : function(res, status) {
			afterSaveEnd(res);
		}
		, error: function(jqXHR, textStatus, errorThrown) {
			alert("처리 도중 에러가 발생하였습니다.");
		}
	});
}

function afterSaveEnd(res) {
	doAjaxMsg(res, ""); //메세지 출력
	var aplNo = $("input[name=aplNo]").val();  
	$(opener.location).attr("href", "javascript:popUpCloseEvent('"+aplNo+"');");

	window.self.close(); // 팝업창 닫기
}
////////////////////////////////////////////////////////////////////////////////
//기타 함수
////////////////////////////////////////////////////////////////////////////////

//바이트 체크
function byteCheck(val, name){
	var objTab = getTabShowObj();//탭이 oepn된 객체가져옴
	var formObj = $("form[name=opnDcsProdForm]");
	
	var temp_estr = escape(val);
	var s_index = 0;
	var e_index = 0;
	var temp_str = "";
	var cnt = 0;
	while((e_index = temp_estr.indexOf("%u", s_index)) >=0){
		temp_str += temp_estr.substring(s_index, e_index);
		s_index = e_index + 6;
		cnt ++;;
	}
	temp_str += temp_estr.substring(s_index);
	temp_str = unescape(temp_str);
	formObj.find("input[name="+name+"]").val( numberWithCommas(((cnt *2) + temp_str.length)));
	return ((cnt *2) + temp_str.length);
}

//텍스트박스 글자수 체크
function textAreaLenChk(obj, name, len){
	rtn = byteCheck(obj.val(), name);
	if(rtn > len){
	  alert(numberWithCommas(len)+'byte 이상 초과 할 수 없습니다.');
	  for(var i=rtn; i > len; i--){
		  obj.val(trim(obj.val()).substring(0, obj.val().length-1));
		  if(byteCheck(obj.val(), name) <= len){
		  	break;
		  }
	  }
		rtn = byteCheck(obj.val(), name);
	  return;
	}
}


function trim(str){
   str = str.replace(/(^\s*)|(\s*$)/g, "");
   return str;
}

//달력관련 함수
function datePickerInit() {
	$("input[name=startDcsDt], input[name=dcsprodEtProd]").datepicker(setCalendarFormat('yymmdd'));
	$("input[name=startDcsDt], input[name=dcsprodEtProd]").attr("readonly", true);
	datepickerTrigger(); 
	
	$("input[name=startDcsDt]").datepicker("option", "onClose",  function( selectedDate ) {$("input[name=dcsprodEtProd]").datepicker( "option", "minDate", selectedDate );});
	$("input[name=dcsprodEtProd]").datepicker("option", "onClose",  function( selectedDate ) {	$("input[name=startDcsDt]").datepicker( "option", "maxDate", selectedDate );});
}

/**
 * 숫자 천단위 콤마
 * @param str
 * @retruns
 */
function numberWithCommas(str) {
    return str.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}

</script>                
<body>
	<form name="opnDcsProdForm" method="post" action="#">
		<input type="hidden" name ="aplNo" id="aplNo" value="${opnRcpDo.aplNo}" />
		<input type="hidden" name="usrId" id="usrId" value="${sessionScope.loginVO.usrId}">
		<input type="hidden" name="pOpbFomVal" value="${opnRcpDo.opbFomVal}" />
		<input type="hidden" name="pAplTakMth" value="${opnRcpDo.aplTakMth}" />
		
		<div class="popup">
			<h3>청구내역 수정</h3>
			<div id="div-sect" style="padding:15px;">
				<table class="list01">   
				    <caption>청구내역 수정</caption>
				    <colgroup>
				        <col style="width:120px;">   
				        <col style="width:90px;">
				        <col style="width:">
				        <col style="width:70px;">
				        <col>
				    </colgroup>
				    <tbody>
				        <tr>
				            <th>청구제목</th>
				            <td colspan="4">
				            	${opnRcpDo.aplSj}
				            </td>
				        </tr>
				        <tr>
				            <th>접수번호</th>
				            <td colspan="4">
				                <input type="text" name="rcpDtsNo" value="${opnRcpDo.rcpDtsNo}" maxlength="10" />
				            </td>
				        </tr>
				        <tr>
				            <th>수정청구제목</th>
				            <td colspan="4">
				                <input type="text" name="aplModSj" value="${opnRcpDo.aplModSj}" maxlength="50" size="54" />
				            </td>
				        </tr>
				        <tr>
				            <th>수정청구내용</th>
				            <td colspan="4">
				                <textarea name="aplModDtsCn" cols="55" rows="10" style="ime-mode:active">${opnRcpDo.aplModDtsCn}</textarea><br>
				                <span><input type="text" name="len1" style="width:40px; text-align:right;border: none;margin-bottom:3px;" value="0" readonly="readonly">/ 2,000Byte(한글1,000자)</span>
				            </td>
				        </tr>
				        <tr>
				            <th>공개형태</th>
				            <td colspan="4">
				                <c:forEach var="opbFomValCd" items="${lclsCodeList }" varStatus="status">
									<input type="radio" name="opbFomVal" id="opbFomVal${opbFomValCd.baseCd }" value="${opbFomValCd.baseCd }" />
										<label for="opbFomValCd${opbFomValCd.baseCd }">${opbFomValCd.baseNm }</label>&nbsp;&nbsp;
								</c:forEach>
								<br />
				                <input type="text" name="opbFomEtc" value="${opnRcpDo.opbFomEtc}" style="width:300px;" maxlength="30" disabled />
				            </td>
				        </tr>
				        <tr>
				            <th>수령방법</th>
				            <td colspan="4">
				                <c:forEach var="aplTakMthCd" items="${apitCodeList }" varStatus="status">
									<input type="radio" name="aplTakMth" id="aplTakMth${aplTakMthCd.baseCd }" value="${aplTakMthCd.baseCd }">
										<label for="aplTakMthCd${aplTakMthCd.baseCd }">${aplTakMthCd.baseNm }</label>&nbsp;&nbsp;
									</input>									
								</c:forEach>
								<br />
				                <input type="text" name="aplTakMthEtc" value="${opnRcpDo.aplTakMthEtc}" style="width:300px;" maxlength="30" disabled />
				
				            </td>
				        </tr>
				    </tbody>
				</table>
				<div class="buttons">
					${sessionScope.button.a_modify}
					${sessionScope.button.a_close}
				</div> 
			</div>
		</div>
	</form>
</body>

</html>                          