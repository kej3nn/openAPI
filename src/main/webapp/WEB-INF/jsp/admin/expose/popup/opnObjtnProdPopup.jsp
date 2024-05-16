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
	$("textarea[name=dcsprodEtRson]").bind("keyup", function(event) {
		var obj = $("textarea[name=dcsprodEtRson]");
		textAreaLenChk(obj, 'len1', 500);
	});
	
	//텍스트박스 글자수 체크
	$("textarea[name=dcsprodEtEtc]").bind("keyup", function(event) {
		var obj = $("textarea[name=dcsprodEtEtc]");
		textAreaLenChk(obj, 'len2', 500);
	});
	//결정기한 연장 등록
	$("a[name=a_opnDcs]").bind("click", function(event) {
		saveData();
	});
	
	//팝업창 닫기
	$("a[name=a_close]").bind("click", function(event) {
		window.close();
	});
	
	
	
}

/**
 * 옵션을 로드한다.
 */
function loadOptions() {
	//캘린더 초기화
	datePickerInit()
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
	 
	 var formObj = $("form[name=opnObjtnProdForm]");
	 
	formObj.ajaxSubmit({
		url : com.wise.help.url("/admin/expose/insertOpnObjtnProd.do")
		, async : false
		, type : 'post'
		, dataType: 'json' 
		, contentType : 'application/x-www-form-urlencoded;charset=UTF-8'
		, beforeSubmit : function() {
			//submit 전 validation 체크
			
			if ( saveValidation() ) {
				if ( !confirm("기간연장 하시겠습니까?") )	return false;
			} else {
				return false;
			}
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
//Validation 함수
////////////////////////////////////////////////////////////////////////////////
/**
* 등록 validation 
*/
function saveValidation() {
	if ( com.wise.util.isNull($("input[name=dcs_ntcs_doc_no]").val()) ) {
		alert("결정기간연장 문서번호를 입력해 주세요.");
		$("input[name=dcs_ntcs_doc_no]").focus();
		return false;
	}
	
	if ( com.wise.util.isNull($("textarea[name=dcsprodEtRson]").val()) ) {
		alert("연장사유를 입력해주세요.");
		$("textarea[name=dcsprodEtRson]").focus();
		return false;
	}
	
	var first_dcs_dt = $("input[name=first_dcs_dt]").val();
	var dcsprodEtDt = $("input[name=dcsprodEtDt]").val();
	
	if(first_dcs_dt >= dcsprodEtDt){
		alert("당초연장기간보다 이후 날짜를 선택해주세요.");
		return false;
	}
	
	return true;
	
}
////////////////////////////////////////////////////////////////////////////////
//기타 함수
////////////////////////////////////////////////////////////////////////////////

//바이트 체크
function byteCheck(val, name){
	var objTab = getTabShowObj();//탭이 oepn된 객체가져옴
	var formObj = $("form[name=opnObjtnProdForm]");
	
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
	formObj.find("input[name="+name+"]").val( ((cnt *2) + temp_str.length));
	return ((cnt *2) + temp_str.length);
}

//텍스트박스 글자수 체크
function textAreaLenChk(obj, name, len){
	rtn = byteCheck(obj.val(), name);
	if(rtn > len){
	  alert(len+'byte 이상 초과 할 수 없습니다.');
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
	var formObj = $("form[name=opnObjtnProdForm]");
	
	formObj.find("input[name=first_dcs_dt], input[name=dcsprodEtDt]").datepicker(setCalendarFormat('yymmdd'));
	formObj.find("input[name=first_dcs_dt], input[name=dcsprodEtDt]").attr("readonly", true);
	datepickerTrigger(); 
	// 시작-종료 일자보다 이전으로 못가게 세팅
	var startDcsDt = formObj.find("input[name=first_dcs_dt]").val();
	if(startDcsDt != null) formObj.find("input[name=dcsprodEtDt]").datepicker( "option", "minDate", startDcsDt );
	
	formObj.find('input[name=first_dcs_dt]').datepicker('option', 'onClose',  function( selectedDate ) {formObj.find("input[name=dcsprodEtDt]").datepicker( "option", "minDate", selectedDate );});
	formObj.find('input[name=dcsprodEtDt]').datepicker('option', 'onClose',  function( selectedDate ) {	formObj.find("input[name=first_dcs_dt]").datepicker( "option", "maxDate", selectedDate );});
}
</script>                
<body>
	<form name="opnObjtnProdForm" method="post" action="#">
		<input type="hidden" name ="aplNo" id="aplNo" value="${objtnDo.aplNo}" />
		<input type="hidden" name="rcpNo" id="rcpNo" value="${objtnDo.rcpNo }"/>
		<input type="hidden" name ="objtnSno" id="objtnSno" value="${objtnDo.objtnSno}" />
		<input type="hidden" name="usrId" id="usrId" value="${sessionScope.loginVO.usrId}">
		<input type="hidden" name="dcsProdEtYn" id="dcsProdEtYn" value="0"/>
		<input type="hidden" name="objtnStatCd" id="objtnStatCd" value="04"/>
		<input type="hidden" name="objtnAplRslt" id="objtnAplRslt" value="${requestScope.objtnAplRslt }"/>
		<input type="hidden" name="objtnDeal_Rslt" id="objtnDeal_Rslt" value="01"/>
		<input type="hidden" name="objtnNtcDt" id="objtnNtcDt"/>
		<input type="hidden" name="dcsNtcRcvmth" id="dcsNtcRcvmth" value="${opnObjtnDo.dcsNtcRcvMthCd }"/>
		<input type="hidden" name="dcsNtcRcvmthSms" id="dcsNtcRcvmthSms" value="${opnObjtnDo.dcsNtcRcvmthSms }"/>
		<input type="hidden" name="dcsNtcRcvmthMail" id="dcsNtcRcvmthMail" value="${opnObjtnDo.dcsNtcRcvmthMail }"/>
		<input type="hidden" name="dcsNtcRcvmthTalk" id="dcsNtcRcvmthTalk" value="${opnObjtnDo.dcsNtcRcvmthTalk }"/>
		<input type="hidden" name="aplEmail" id="aplEmail" value="<c:out value='${opnObjtnDo.aplEmailAddr }' escapeXml='true'/> "/>
		<input type="hidden" name="aplMblPno" id="aplMblPno" value="${opnObjtnDo.aplMblPno }"/>
		<input type="hidden" name="aplPn" id="aplPn" value="${opnObjtnDo.aplPn }"/>
		<input type="hidden" name="aplDealInstCd" id="aplDealInstCd" value="${objtnDo.aplDealInstCd }"/>
		<input type="hidden" name="instChrgDeptNm" id="instChrgDeptNm" value="${objtnDo.instChrgDeptNm }"/>
		<input type="hidden" name="instChrgCentCgp1Nm" id="instChrgCentCgp1Nm" value="${objtnDo.instChrgCentCgp1Nm }"/>
		<input type="hidden" name="instChrgCentCgp2Nm" id="instChrgCentCgp2Nm" value="${objtnDo.instChrgCentCgp2Nm }"/>
		<input type="hidden" name="instChrgCentCgp3Nm" id="instChrgCentCgp3Nm" value="${objtnDo.instChrgCentCgp3Nm }"/>
		<input type="hidden" name="instPno" id="instPno" value="${objtnDo.instPno }"/>
		<input type="hidden" name="instFaxNo" id="instFaxNo" value="${objtnDo.instFaxNo }"/>
		<div class="popup">
			<h3>이의신청 연장등록 </h3>
			<div id="div-sect" style="padding:15px;">
				<span>결정기간연장 문서번호  </span><input type="text" name="dcs_ntcs_doc_no" value="국회민원지원-"/><br><br>
				<table class="list01">
					<caption>이의신청 연장등록</caption>
					<colgroup>
						<col style="width:80">
						<col style="width:80">
						<col style="width:">

					</colgroup>
					<tbody>

						<tr>
							<th>이의신청내용</th>
							<td colspan="4">
								<textarea rows="5" cols="80" readonly="readonly">${objtnDo.newObjtnRson}</textarea>
							</td>
						</tr>
						<tr>
							<th rowspan="2">접수일자 및<br>접수번호${objtnDo.rcpDt }</th>
							<th>접수일자</th>
							<td colspan="3">
								${objtnDo.rcpDt }
								<input type="hidden" name="rcpDt" value="${objtnDo.rcpDt }" />
							</td>
						</tr>
						<tr>
							<th>접수번호</th>
							<td colspan="3">
								${objtnDo.rcpDtsNo }
								<input type="hidden" name="rcpNo" value="${objtnDo.rcpDtsNo }" />
							</td>
						</tr>
						<tr>
							<th>당초연장기간</th>
							<td colspan="4">
								<input type="text" name="first_dcs_dt" size="13" />
							</td>
						</tr>

						<tr>
							<th>연장사유</th>
							<td colspan="4">
								<textarea name="dcsprodEtRson" rows="5"cols="80"></textarea><br>
								<span class="byte_r">
									<input type="text" name="len1" id="len1"style="width:20px; text-align:right;border: none;" value="0" readonly="">/500Byte
								</span>
							</td>
						</tr>
						<tr>
							<th>연장결정기한</th>
							<td colspan="4">
								<input type="text" name="dcsprodEtDt" size="13" />
							</td>
						</tr>
						<tr>
							<th>기타안내사항</th>
							<td colspan="4">
								<textarea name="dcsProdEtEtc" rows="5"cols="80"></textarea><br>
								<span class="byte_r">
									<input type="text" name="len2" id="len2"style="width:20px; text-align:right;border: none;" value="0" readonly="">/500Byte
								</span>
							</td>
						</tr>
						<tr>
							<td colspan="5" align="center">
							</td>
						</tr>
					</tbody>
				</table>
				<div class="buttons">
					<a href="javascript:;" class="btn02" title="연장" name="a_opnDcs">연장</a>
					${sessionScope.button.a_close}
				</div> 
			</div>
		</div>
	</form>
</body>

</html>                          