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
	$("textarea[name=endCn]").bind("keyup", function(event) {
		var obj = $("textarea[name=endCn]");
		textAreaLenChk(obj, 'len1', 500);
	});
	
	//종결 등록
	$("a[name=a_reg]").bind("click", function(event) {
		saveData();
	});
	
	//팝업창 닫기
	$("a[name=a_close]").bind("click", function(event) {
		window.close();
	});
	
}



/**
 * 데이터 저장
 */
function saveData() {
	 
	 var formObj = $("form[name=opnEndCnForm]");
	 
	formObj.ajaxSubmit({
		url : com.wise.help.url("/admin/expose/infoOpenUpdateEndCn.do")
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
	
	if ( com.wise.util.isNull($("textarea[name=endCn]").val()) ) {
		alert("종결사유를 입력해주세요.");
		$("textarea[name=endCn]").focus();
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
	var formObj = $("form[name=opnEndCnForm]");
	
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

</script>                
<body>
	<form name="opnEndCnForm" method="post" action="#">
		<input type="hidden" name ="aplNo" id="aplNo" value="${param.aplNo}" />
		<input type="hidden" name="usrId" id="usrId" value="${sessionScope.loginVO.usrId}">
		<input type="hidden" name="aplDealInstCd" id="aplDealInstCd" value="${param.aplDealInstCd}"/>
	
		<div class="popup">
			<h3>신고서 종결처리</h3>
			<div id="div-sect" style="padding:15px;">
				<table class="list01">
					<caption>신고서 종결처리</caption>
					<colgroup>
						<col style="width:80">
						<col style="width:">
					</colgroup>
					<tbody>
						<tr>
							<th>종결사유</th>
							<td colspan="4">
								<textarea name="endCn" rows="5"cols="80"></textarea><br>
								<span class="byte_r">
									<input type="text" name="len1" id="len1"style="width:20px; text-align:right;border: none;" value="0" readonly="">/500Byte
								</span>
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