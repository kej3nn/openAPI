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
	$("textarea[name=aplDtsCn]").bind("keyup", function(event) {
		var obj = $("textarea[name=aplDtsCn]");
		textAreaLenChk(obj, 'len1', 500);
	});
	
	//텍스트박스 글자수 체크
	$("textarea[name=trsfCn]").bind("keyup", function(event) {
		var obj = $("textarea[name=trsfCn]");
		textAreaLenChk(obj, 'len2', 500);
	});
	
	//텍스트박스 글자수 체크
	$("textarea[name=trsfEtcCn]").bind("keyup", function(event) {
		var obj = $("textarea[name=trsfEtcCn]");
		textAreaLenChk(obj, 'len3', 500);
	});
	
	//이송통지 등록
	$("a[name=a_reg]").bind("click", function(event) {
		saveData();
	});
	
	//팝업창 닫기
	$("a[name=a_close]").bind("click", function(event) {
		window.close();
	});
	
	$("button[name=pathDelete]").bind("click", function(event) {
		$("input[name=file]").val(""); 
	});
	
}

/**
 * 옵션을 로드한다.
 */
function loadOptions() {
	//캘린더 초기화
	datePickerInit();
	
	textAreaLenChk($("textarea[name=aplDtsCn]"), 'len1', 500);
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
	 
	 var formObj = $("form[name=opnTrnForm]");
	 
	formObj.ajaxSubmit({
		url : com.wise.help.url("/admin/expose/infoOpenTrnWrite.do")
		, async : false
		, type : 'post'
		, dataType: 'json' 
		, contentType : 'application/x-www-form-urlencoded;charset=UTF-8'
		, beforeSubmit : function() {
			//submit 전 validation 체크
			
			if ( saveValidation() ) {
				if ( !confirm("저장 하시겠습니까?") )	return false;
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
	if ( com.wise.util.isNull($("input[name=trsfDocNo]").val()) ) {
		alert("문서번호를 입력해 주세요.");
		$("input[name=trsfDocNo]").focus();
		return false;
	}
	
	if ( com.wise.util.isNull($("input[name=trsfInstNm]").val()) ) {
		alert("이송기관을 입력해주세요.");
		$("input[name=trsfInstNm]").focus();
		return false;
	}
	
	if ( com.wise.util.isNull($("input[name=trsfDt]").val()) ) {
		alert("이송일시를 입력해주세요.");
		$("input[name=trsfDt]").focus();
		return false;
	}
	
	
	if ( com.wise.util.isNull($("textarea[name=trsfCn]").val()) ) {
		alert("이송사유를 입력해주세요.");
		$("textarea[name=trsfCn]").focus();
		return false;
	}
	
	if(!com.wise.util.isNull($("input[name=file]").val())){
		var chk = checkFile();
		if(chk){
			alert("해당 파일은 등록할 수 없습니다.");
			$("input[name=file]").val("");
			return false;
		}
		$("input[name=trsfFlLength]").val("1");
	}

	
	return true;
	
}
////////////////////////////////////////////////////////////////////////////////
//기타 함수
////////////////////////////////////////////////////////////////////////////////

//바이트 체크
function byteCheck(val, name){
	var objTab = getTabShowObj();//탭이 oepn된 객체가져옴
	var formObj = $("form[name=opnTrnForm]");
	
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
	$("input[name=trsfDt]").datepicker(setCalendarFormat('yymmdd'));
	$("input[name=trsfDt]").attr("readonly", true);
	datepickerTrigger(); 
}

function checkFile() {
	
	var ext = $("input[name=file]").val();
	var chk = true;
	
	if( ext.substr(ext.length-3).toLowerCase() == 'txt')  {chk = false; return chk;} 
    if( ext.substr(ext.length-3).toLowerCase() == 'hwp')  {chk = false; return chk;}
    if( ext.substr(ext.length-3).toLowerCase() == 'doc')  {chk = false; return chk;}
    if( ext.substr(ext.length-4).toLowerCase() == 'docx') {chk = false; return chk;}
    if( ext.substr(ext.length-3).toLowerCase() == 'xls')  {chk = false; return chk;}
    if( ext.substr(ext.length-4).toLowerCase() == 'xlsx') {chk = false; return chk;}
    if( ext.substr(ext.length-3).toLowerCase() == 'ppt')  {chk = false; return chk;}
    if( ext.substr(ext.length-4).toLowerCase() == 'pptx') {chk = false; return chk;}
    if( ext.substr(ext.length-3).toLowerCase() == 'pdf')  {chk = false; return chk;}
    if( ext.substr(ext.length-3).toLowerCase() == 'zip')  {chk = false; return chk;}
    if( ext.substr(ext.length-3).toLowerCase() == 'rar')  {chk = false; return chk;}
	
	return chk;
}


</script>                
<body>
	<form name="opnTrnForm" method="post" action="#">
		<input type="hidden" name="aplNo" id="aplNo" value="${opnRcpDo.aplNo }"/>
		<input type="hidden" name="rcpDt" id="rcpDt" value="${opnRcpDo.rcpDt }"/>
		<input type="hidden" name="rcpNo" id="rcpNo" value="${opnRcpDo.rcpNo }"/>
		<input type="hidden" name="aplDealInstCd" id="aplDealInstCd" value="${opnRcpDo.aplDealInstCd }"/>
		<div class="popup">
			<h3>이송통지</h3>
			<div id="div-sect" style="padding:15px;">
				<span>문서번호  </span><input type="text" name="trsfDocNo" value="국회민원지원-"/><br><br>
				<table class="list01">
				    <caption>공개결정 내용등록</caption>
				    <colgroup>
				        <col style="width:10%;">
				        <col style="width:15%;">
				        <col style="width:30%;">
				        <col style="width:15%;">
				        <col>
				    </colgroup>
				    <tbody>
				        <tr>
				            <th colspan="2">정보공개 결정</th>
				            <td colspan="3">
				                <input type="radio" name="opbYn" id="opbYn" value="0" checked="checked" />타기관이송
				            </td>
				        </tr>
				        <tr>
				            <th colspan="2">청구내용</th>
				            <td colspan="3">
				                <textarea name="aplDtsCn" id="aplDtsCn" rows="10" cols="70">${opnRcpDo.aplModDtsCn}</textarea><br>
				                <span class="byte_r"><input type="text" name="len1" id="len1" style="width:40px; text-align:right;border:none;" value="0" readonly>/500 Byte</span>
				
				            </td>
				        </tr>
				        <tr>
				            <th colspan="2"><span>*</span>이송기관</th>
				            <td>
				                <input type="text" name="trsfInstNm" size="20" value="${opnRcpDo.trsfInstNm }" />
				            </td>
				            <th><span>*</span>이송일시</th>
				            <td>
				                <input name="trsfDt" type="text" id="trsfDt" style="width:90px" value="${opnRcpDo.trsfDt}" />
				            </td>
				        </tr>
				        <tr>
				            <th colspan="2"><span>*</span>이송사유</th>
				            <td colspan="3">
				                <textarea name="trsfCn" id="trsfCn" rows="10" cols="70"></textarea><br>
				                <span class="byte_r"><input type="text" name="len2" id="len2" style="width:40px; text-align:right;border: none;" value="0" readonly>/500 Byte</span>
				            </td>
				        </tr>
				        <tr>
				            <th colspan="2">그 밖의 안내사항</th>
				            <td colspan="3">
				                <textarea name="trsfEtcCn" id="trsfEtcCn" rows="10" cols="70"></textarea><br>
				                <span class="byte_r"><input type="text" name="len3" id="len3" style="width:40px; text-align:right;border: none;" value="0" readonly>/500 Byte</span>
				            </td>
				        </tr>
				    </tbody>
				</table><br>
				<table class="list01">
					<caption>공개결정 내용등록</caption>
					<colgroup>
						<col style="width:25%;">
					</colgroup>
					<tbody>
					<tr>
						<th>파일 첨부</th>
						<td>
							<span>*</span>40mb이하의 파일만 등록이 가능합니다.<br/>
							<span>*</span>2개 이상의 파일을 등록하실경우 zip 또는 rar파일로 압축해서 등록하시기 바랍니다.<br/>
							<span>*</span>등록가능 파일(txt, hwp, doc, docx, xls, xlsx, ppt, pptx, pdf, zip, rar)<br />
							<input type="file" id="file" name="file" size="50" onkeypress="return false;" />
							<button type="button" class="btn01" id="pathDelete" name="pathDelete">지우기</button>
							<input type="hidden" name="trsfFlLength"/>
						</td>
					</tr>
					</tbody>
				</table>
				<div class="buttons">
					${sessionScope.button.a_reg}
					${sessionScope.button.a_close}
				</div> 
			</div>
		</div>
	</form>
</body>

</html>                          