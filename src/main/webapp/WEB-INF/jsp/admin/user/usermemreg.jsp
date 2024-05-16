<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="egovframework.common.WiseOpenConfig"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page import="egovframework.common.util.PagingView"%>
<%@ page import="egovframework.com.cmm.EgovWebUtil"%>
<%
// 캐쉬 사용안함.
response.setDateHeader("Expires", 0L);
response.setHeader("Prama", "no-cache");
if(request.getProtocol().equals("HTTP/1.1"))
	response.setHeader("Cache-Control", "no-cache");

String dupInfo = session.getAttribute("dupInfo") == null ? "" : (String)session.getAttribute("dupInfo");		//중복가입정보
String virtualNo = session.getAttribute("virtualNo") == null ? "" : (String)session.getAttribute("virtualNo");	//가상식별번호
//인증 안하고 주소로 입력하고 접속 시 메인으로 이동
if ( dupInfo.equals("") && virtualNo.equals("") ) {
	response.sendRedirect("/");
} else {
	session.setAttribute("rauthYn", "Y");		//실명인증 여부 set
	String usrNm = EgovWebUtil.clearXSSMinimum(session.getAttribute("realName") == null ? "" : (String)session.getAttribute("realName"));
	
%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><spring:message code='wiseopen.portalTitle'/></title>                    
<c:import  url="/WEB-INF/jsp/inc/headincludeportal.jsp"/>

<script language="javascript">               
//<![CDATA[
  
  $(document).ready(function(){
	  /****** GPIN 유저 중복체크 ******/
	  gpinAdminDupCheck();
	  /*********************************/
	  /****** 키보드 보안 설치 체크 ******/
	  keyScriptCheck();
	  /*********************************/
	  setTabButton();
	  inputEnterKey();
	  usrIdCheck();
	  passCheck();
	  emailCheck();
	  emailYnCheck();
	  hpYnCheck();
	  hpYnNullCheck();
	  emailYnNullCheck();
	  
  });
  
  
  /* 엔터 중복확인 조회*/
  function inputEnterKey(){
  	$("input[name=usrId]").keypress(function(e) {
  		  if(e.which == 13) {
  			  doAction('dup');
  			  return false;
  		  }
  	});
  }
  
  
  function doAction(sAction)                                  
  {
	 // ajaxBeforeSendAdmin("<c:url value='/admin/ajaxBeforeSendAdmin.do'/>"); //IbSheet 조회전 세션 체크
	  switch(sAction)
		{ 
			case "dup": // id중복체크 
				if(nullCheckValdation($('input[name=usrId]'),"아이디","")){
					return false;
				}
			
				//var check = /^(?=.*[a-zA-Z])(?=.*[0-9]).{5,20}$/; //영문,숫자 5자이상~ 20자이내만 허용
				var check = /^[a-zA-Z0-9+].{4,19}$/; //영문,숫자중 5자이상~ 20자이내만 허용
				
				//아이디 조합 체크 
				if ( !check.test($("input[name=usrId]").val()) ) {
						alert("영문,숫자 5자 이상 ~ 20자 이내로 입력해 주세요.");
						$('input[name=usrId]').val("");
						return true;
				}
				
				var url = "<c:url value='/admin/user/memRegUsrIdDup.do'/>"; 
				var param = $("[name=usrId]").serialize(); //폼정보 serialize
 				ajaxCall(url,param,idDupCallBack);
			break;
			
			case "save" : //회원가입
				var naidCd = $("input[name=linkSysIdCheck]").val();
				if(naidCd == "N"){
					alert("업무 선택을 확인해 주세요.");
					//alert("국고보조금 연계 ID를 확인해 주세요.");
					return false;
				}
				var formObj = $("form[name=usrMemReg]");
				if (validateUserReg(formObj)) {	return false;	}	//validation 체크
					
				if ( confirm("관리자 회원가입 하시겠습니까?") ) {
					var url =  "<c:url value='/admin/user/memRegInsert.do'/>";
		 			var param = formObj.serialize(); //폼정보 serialize
		 			ajaxCall(url, param, saveCallMemReg); //saveCallBackCheckbox 체크박스제거 및 자동조회가능.
					//$("form[name=usrMemReg]").attr("action","<c:url value='/admin/user/memRegInsert.do'/>").submit();
				}
				break;
		}
  }
  
  function usrIdCheck(){ //회원아이디 입력을 지웠다 썼다 할시 중복체크를 다시 해야한다.
	  $("input[name=userId]").keypress(function(e) {
  		  if(e.which != 13) { //엔터키는 제외하고 .
  			 $("input[name=userIdDupCheck]").val("N");  
  		  }
  	  });
	  
	  /* $("input[name=usrId]").keyup(function(){
		  $("input[name=usrIdDupCheck]").val("N");  
	  }); */
  }
  
  
  function saveCallMemReg(res){
	  var usrId = $("input[name=usrId]").val();// 가입한 id값도 보낸다.
	  location.href = "<c:url value='/admin/user/memResult.do'/>"+"?usrId="+usrId+"&code=adminLogin&leftCd=25&subCd="; //회원가입 완료 후 결과페이지로 이동
  } 
  
  
/*   //ID 중복체크 콜백	
  function idDupCallBack(res){
  	var formObj = $("form[name=usrMemReg]");
  	if(res.RESULT.CODE == -1){
  		alert("중복된 ID가 존재합니다.");
  		formObj.find("input[name=usrId]").val("");
  		$("input[name=usrIdDupCheck]").val("N"); 
  	}else{                           
  		alert("등록 가능합니다.");
  		$("input[name=usrIdDupCheck]").val("Y"); //중복이 아니라면 Y로 변경해준다.
  	}
  } */
  
//ID 중복체크 콜백	 
  function idDupCallBack(res){ 
  	var formObj = $("form[name=usrMemReg]"); 
  	if(res.RESULT.CODE == -1){ 
  		alert("중복된 ID가 존재합니다."); 
  		formObj.find("input[name=usrId]").val(""); 
  		$("input[name=usrIdDupCheck]").val("N");  
  	}else{                            
  		alert("등록 가능합니다."); 
  		$("#usrMemRegId").attr("readonly", true).addClass("readonly", true);	//중복체크 후 아이디 변경 불가 
  		$("input[name=usrIdDupCheck]").val("Y"); //중복이 아니라면 Y로 변경해준다. 
  	} 
  } 
  
  
  
  function passCheck(){ //비밀번호 일치여부 확인 
	  $("input[name=usrPwCheck1]").keyup(function(){ //첫번째 비밀번호 입력란.
		 $("input[name=usrPw]").val("");  //암호 저장값 초기화
	  });
	  
	  $("input[name=usrPwCheck2]").keyup(function(){ //두번째 비밀번호 입력란.
		  	 if( $("input[name=usrPwCheck1]").val() != $("input[name=usrPwCheck2]").val() ){//불일치 하면..
				 $("input[name=usrPw]").val("");  //암호 저장값 초기화
		  	 }else{
				 var pass = $("input[name=usrPwCheck2]").val(); //비밀번호가 일치하면..
				 $("input[name=usrPw]").val(pass);  //암호 저장.
		  	 }
		  });
  }
  
  function emailCheck(){ //이메일 직접입력 체크
	  $("select[name=usrEmailSelect]").change(function(){ //이메일 직접입력이 아니라면 @이후 입력불가
			if($("select[name=usrEmailSelect]").val() == 'na' ){
				$("#usrEmailLast").val(""); //초기화
				$("#usrEmailLast").attr("readonly",false);
			}else{
				var usrEmailSelect = $("select[name=usrEmailSelect]").val();
				$("#usrEmailLast").val(usrEmailSelect); // select 선택된 이메일을 입력한다.
				$("#usrEmailLast").attr("readonly",true);
			}
		});
  }
  
  function emailYnCheck(){ //이메일 수신동의 체크 Y/N
	  $("input:checkbox[name=emailYn]").change(function(){ 
		if( $('input[name=usrEmail]').eq(0).val().length > 0 && $('input[name=usrEmailLast]').eq().val().length  > 0 ){ //수신동의 하기위해선 이메일을 입력을 해야한다.  
		  if( $("input:checkbox[name=emailYn]").is(":checked") ){ //수신동의 했을때 Y
			  $("input:checkbox[name=emailYn]").prop("checked",true);
			  $("input:checkbox[name=emailYn]").val("Y");
		  }else{
			  $("input:checkbox[name=emailYn]").prop("checked",false); 
			  $("input:checkbox[name=emailYn]").val("N");
		  }
		}else{
			$("input:checkbox[name=emailYn]").prop("checked",false); 
			 $("input:checkbox[name=emailYn]").val("N");
			alert("이메일 입력 후 이메일 수신동의 하실 수 있습니다.");
		}
	  });
  }
  
  function emailYnNullCheck(){ //이메일 입력이 안되있다면 이메일 수신동의를 풀어버리는 이벤트.
		$('input[name=usrEmail]').keyup(function(){
			//이메일 입력중 하나라도 취소하면 수신동의 해제한다. 
			if( !( $('input[name=usrEmail]').eq(0).val().length > 0 )  ){
				$("input:checkbox[name=emailYn]").prop("checked",false); 
				$("input:checkbox[name=emailYn]").val("N");
			}
			
			if( !( $('input[name=usrEmailLast]').eq(0).val().length > 0 )  ){
				$("input:checkbox[name=emailYn]").prop("checked",false); 
				$("input:checkbox[name=emailYn]").val("N");
			}
			
		});
	  }
  
  
  function hpYnCheck(){ //문자메세지 수신동의 체크 Y/N
	  $("input:checkbox[name=hpYn]").change(function(){ 
		if( $('input[name=usrHp]').eq(0).val().length > 0 && $('input[name=usrHp]').eq(1).val().length  > 0 && $('select[name=usrHp]').val()  != '1'){ //수신동의 하기위해선 휴대전화번호 입력을 해야한다. 
		  if( $("input:checkbox[name=hpYn]").is(":checked") ){ //수신동의 했을때 Y
			  $("input:checkbox[name=hpYn]").prop("checked",true);
			  $("input:checkbox[name=hpYn]").val("Y");
		  }else{
			  $("input:checkbox[name=hpYn]").prop("checked",false);
			  $("input:checkbox[name=hpYn]").val("N");
		  }
		}else{
			$("input:checkbox[name=hpYn]").prop("checked",false);
			$("input:checkbox[name=hpYn]").val("N");
			alert("휴대전화번호 입력 후 문자메세지 수신동의 하실 수 있습니다.");
		}
	  });
  }
  
  function hpYnNullCheck(){ //휴대전화번호가 입력이 안되있다면 문자메세지 수신동의를 풀어버리는 이벤트.
		$('input[name=usrHp]').keyup(function(){
			//휴대전화번호 입력중 하나라도 취소하면 수신동의 해제한다. 
			if( !( $('input[name=usrHp]').eq(0).val().length > 0 )  ){
				$("input:checkbox[name=hpYn]").prop("checked",false);
				$("input:checkbox[name=hpYn]").val("N");
			}
			
			if( !( $('input[name=usrHp]').eq(1).val().length > 0 )  ){
				$("input:checkbox[name=hpYn]").prop("checked",false);
				$("input:checkbox[name=hpYn]").val("N");
			}
			
		});
	  }
  
  
  
  
  function setTabButton(){ //버튼 클릭시 
	  $("button[name=btn_dup]").click(function(e) {
		  	doAction("dup");                                               
			return false;                  
	  });
  
	  $("a[name=a_memReg]").click(function(e) {
		  	doAction("save");                                               
			return false;                  
	  });
	  
	//이메일 영문, 숫자만 입력
	  $("#usrEmailFirst").keyup(function(e) {                     
		  ComInputEngNumObj($("#usrEmailFirst"));    
	 	  return false;                                                                          
	  });
	  
	  //이메일 영문, 숫자, 점(dot)만 입력
	  $("#usrEmailLast").keyup(function(e) {                     
		  ComInputEngDcmObj($("#usrEmailLast"));    
	 	  return false;                                                                          
	  });
	  
	  
	  $("input[name=accCd]").click(function(e) { //업무 라디오박스중 국고보조금 클릭시 보인다.
			var checkId = $(this).attr("id"); 
		 		if( "accCdCheck2" == checkId ){
		 		 	$("tr[name=trHidden]").css("display",""); //보임  
		 		 	$("tr[name=trHidden2]").css("display",""); //보임  
		 		 	$("td[name=tdDut]").css("border-bottom-color","white"); //선 숨김 
		 		}else{
		 			$("tr[name=trHidden]").css("display","none"); //숨김
		 			$("tr[name=trHidden2]").css("display","none"); //숨김
		 			$("td[name=tdDut]").css("border-bottom-color","#c0cbd4"); //선 숨김 
		 			$("input[name=linkSysIdCheck]").val("Y");
		 		}
	  });
	  
	  //////숫자만 입력하도록 체크.
	  $("input[name=usrTel]").eq(0).keyup(function(e) {                       
		 ComInputNumObj($("input[name=usrTel]").eq(0));    
	 	 return false;                                                                          
	  });
	  
	  $("input[name=usrTel]").eq(1).keyup(function(e) {                     
			 ComInputNumObj($("input[name=usrTel]").eq(1));    
		 	 return false;                                                                          
	  });
	  
	  $("input[name=usrHp]").eq(0).keyup(function(e) {                     
			 ComInputNumObj($("input[name=usrHp]").eq(0));    
		 	 return false;                                                                          
	  });
		  
	  $("input[name=usrHp]").eq(1).keyup(function(e) {                     
			 ComInputNumObj($("input[name=usrHp]").eq(1));    
		 	 return false;                                                                          
	  });
	  
	  $("button[name=keyCryptInstallSet]").click(function(e) {
		    keyCryptInstall();                                               
			return false;                  
	  });
	    
	  $("select[name=naidCd]").change(function(){
		  if($("select[name=naidCd]").val()=='ehojo'){
			  $("input[name=linkSysIdCheck]").val("Y");
			  $("input[name=naidId]").val(null);
			  $("span[name=sysNoehojoSpan]").css("display","none");
			  $("span[name=sysYesehojoSpan]").css("display","block");
			  $("button[name=naidIdCheck]").empty().append("보조사업설정");
			  $("span[name=naidSpan]").empty().append("<span>e호조 사용자는 ID를 입력하지 않으셔도됩니다.</span>");
		  }else{
			  $("span[name=sysNoehojoSpan]").css("display","block");
			  $("input[name=linkSysIdCheck]").val("N");
			  $("span[name=sysYesehojoSpan]").css("display","none");  
			  $("button[name=naidIdCheck]").empty().append("ID 확인");  
			  $("span[name=naidSpan]").empty().append("<span>ID는 대소문자를 구분합니다.</span>");
		  }
	  });  
	  
	  $("button[name=naidIdCheck]").click(function(){		// ID확인 or 보조사업설정 버튼 클릭시
		  //if (validateUserReg($("form[name=usrMemReg]"))) {	return false;	}	//validation 체크
		  var usrNm = $("input[name=usrNm]").val();
		  var param = "?rppsNm="+$("input[name=usrNm]").val();
			param += "&rppsPno="+$("select[name=usrTel]").eq(0).val()+"-"+$("input[name=usrTel]").eq(0).val()+"-"+$("input[name=usrTel]").eq(1).val();
			//param += "&rppsPno=02-1111-2222";	// 임시로 해놓았음
		  
			if($("select[name=naidCd]").val()=='ehojo'){	// 원천 시스템이 e호조일 경우
			  // e호조는 ID를 받아오지 않기 때문에 새로운 팝업창에서 담당자명과 소속기관을 조건으로 보조사업리스트를 조회하게 함
			  $("input[name=linkSysCd]").val(2);  	// e호조는 value = 2
			param += "&linkSysCd="+$("input[name=linkSysCd]").val();
			param += "&rppsId="+$("input[name=usrId]").val();
			param += "&naidGb=1";
			alert("국고보조금 보조사업 정보공개담당자로 등록하시려면 반드시 자료원천 시스템의 사업정보에 담당자로 등록되어 있으셔야 합니다.");
			var url = "<c:url value="/portal/foss/popup/naidIdCheckPopup.do"/>"+param;
			//var url = "<c:url value="/admin/foss/popup/naidIdCheckPopup.do"/>";   
			var popup = OpenWindow(url,"naidIdCheckPopUp","800","575","yes");	
			popup.focus();
		  }else{											// 원천 시스템이 e호조가 아닐경우
			// e호조가 아니면 ID를 연계해서 받아오기 때문에 ID가 실제하는지 확인만해주면 됨
			  alert("국고보조금 보조사업 정보공개담당자로 등록하시려면 반드시 자료원천 시스템의 사업정보에 담당자로 등록되어 있으셔야 합니다.");
			  if($("select[name=naidCd]").val()=='dbrain'){	// 디브렌인은 value = 1
				  $("input[name=linkSysCd]").val("1");  
				  param += "&linkSysCd="+$("input[name=linkSysCd]").val();
			  }else if($("select[name=naidCd]").val()=='edufine'){	// 에듀파인은 value = 3
				  $("input[name=linkSysCd]").val("3");  
				  param += "&linkSysCd="+$("input[name=linkSysCd]").val();
			  }else if($("select[name=naidCd]").val()=='cleani'){	// 클린은 value = 4
				  $("input[name=linkSysCd]").val("4");  
				  param += "&linkSysCd="+$("input[name=linkSysCd]").val();
			  }
			  param += "&rppsId="+$("input[name=naidId]").val();  
			  var url = "<c:url value='/admin/foss/popup/naidIdCheckDup.do'/>"; 
			  ajaxCallAdmin(url,param,dupCallBack);
		  }
	  });
	  
	  
	  
	  
	  $("button[name=MyNaidList]").click(function(){		// My 보조사업리스트 버튼 클릭시 ==> 원래는 회원수정페이지에 있어야 하는데 임시로 이곳에 만듬
		  	var param = "?rppsId="+$("input[name=usrId]").val();
			param += "&linkSysCd="+$("input[name=linkSysCd]").val();
			param += "&rppsNm="+$("input[name=usrNm]").val();
			param += "&rppsPno=02-1111-2222";	// 임시로 해놓았음
			param += "&naidGb=2";   
		  	var url = "<c:url value="/admin/foss/popup/myNaidListPopup.do"/>"+param;
			var popup = OpenWindow(url,"myNaidListPopup","1300","1300","yes");	
			popup.focus();
	  });
	  
	  
	  
	  
	  
  }
  function dupCallBack(res){
		/* var objTab = getTabShowObj();//탭이 oepn된 객체가져옴
		var formObj = objTab.find("form[name=adminOpenCateOne]"); */   
		if(res > 0){
			$("input[name=linkSysIdCheck]").val("Y"); 
			alert("아이디가 확인되었습니다.");
		}else{                           
			alert("회원가입이 불가합니다. 원천 시스템 아이디를 다시한번 확인해주십시오");
			return false;
		}
	}  
  
 
  
  
  function validateUserReg(formObj){ 
	  var check = /^(?=.*[a-z])(?=.*[A-Z])(?=.*[!@#$%^&*()-])(?=.*[0-9]).{8,20}$/; //비밀번호 체크
	  
		// 회원아이디  null체크 영문 숫자포함 5자이상~ 20자 이내 
		if( !( (formObj.find('input[name=usrId]').val().length > 4) && (formObj.find('input[name=usrId]').val().length < 21 )  )){
			if ( nullCheckValdation( formObj.find('input[name=usrId]'), "회원아이디", "" ) ) {
				return true;
			}
		}
		
		// 회원아이디 중복체크 확인 유무
		if( (formObj.find('input[name=usrIdDupCheck]').val() == 'N' ) ){
			alert("중복확인 체크 해주세요.");
			return true;
		}

		
		//비밀번호 일치 유무 체크
		if( $("input[name=usrPw]").val() == "" ){
			alert("비밀번호가 일치하지 않습니다.");
			formObj.find("input[name=usrPwCheck1]").val(""); //암호 틀릴시 초기화
			formObj.find("input[name=usrPwCheck2]").val(""); //암호 틀릴시 초기화
			formObj.find('input[name=usrPwCheck1]').focus();
			return true;
		}
		
		//비밀번호 조합 체크 (단, 비밀번호 수정안할경우 체크하지 않는다.)
	 	if(!( formObj.find("input[name=usrPwCheck1]").val().length == 0 && formObj.find("input[name=usrPwCheck2]").val().length == 0 )  ){
			if ( !check.test($("input[name=usrPw]").val()) ) {
				alert("비밀번호는 8~20자리 영, 숫자, 특수문자 조합으로 입력해 주세요");
				formObj.find("input[name=usrPwCheck1]").val(""); //암호 틀릴시 초기화
	 			formObj.find("input[name=usrPwCheck2]").val(""); //암호 틀릴시 초기화
	 			formObj.find('input[name=usrPwCheck1]').focus();
				return true;
			}
	 	}
		
		
	 	// 이메일 입력을 했을 때 null체크 
		if( formObj.find('input[name=usrEmail]').eq(0).val().length + formObj.find('input[name=usrEmailLast]').eq(0).val().length > 0 ){
			if ( nullCheckValdation( formObj.find('input[name=usrEmail]').eq(0), "이메일", "" ) ) {
				return true;
			}
			
			//if( formObj.find('input[name=userEmail]').eq(1).val().length > 0 ){
				if ( nullCheckValdation( formObj.find('input[name=usrEmailLast]').eq(0), "이메일", "" ) ) {
					return true;
				}
			//}
		}

		//전화번호 입력을 했다면 체크한다. 
		if( ( (formObj.find('input[name=usrTel]').eq(0).val().length + formObj.find('input[name=usrTel]').eq(1).val().length ) > 0 || formObj.find('select[name=usrTel]').val()  != '1' ) ){ 
			
			if( $("select[name=usrTel]").val() == '1' ){ //번호 선택 유무 체크
				alert("전화번호(을)를 선택해주세요.");
				$("select[name=usrTel]>option[value=1]").attr("selected","true"); //콤보박스를 '선택'으로 초기화시킨다.
				return true;
			}
			
			// 전화번호 null체크 1
			if ( nullCheckValdation( formObj.find('input[name=usrTel]').eq(0), "전화번호", "" ) ) {
				return true;
			}
			
			// 전화번호 null체크 2
			if ( nullCheckValdation( formObj.find('input[name=usrTel]').eq(1), "전화번호", "" ) ) {
				return true;
			}
		}
		
		//휴대전화번호 입력을 했다면 체크한다.
		if( (formObj.find('input[name=usrHp]').eq(0).val().length + formObj.find('input[name=usrHp]').eq(1).val().length ) > 0 || formObj.find('select[name=usrHp]').val()  != '1' ){
			
			if( $("select[name=usrHp]").val() == '1' ){ //번호 선택 유무 체크
				alert("휴대전화번호(을)를 선택해주세요.");
				$("select[name=usrHp]>option[value=1]").attr("selected","true"); //콤보박스를 '선택'으로 초기화시킨다.
				return true;
			}
			
			// 휴대전화번호 null체크 1
			if ( nullCheckValdation( formObj.find('input[name=usrHp]').eq(0), "휴대전화번호", "" ) ) {
				return true;
			}
			
			// 휴대전화번호 null체크 2
			if ( nullCheckValdation( formObj.find('input[name=usrHp]').eq(1), "휴대전화번호", "" ) ) {
				return true;
			}
		}
		
		//전화번호, 휴대전화번호 중 하나는 필수 입력이다.
		var cnt = formObj.find('input[name=usrHp]').eq(0).val().length + formObj.find('input[name=usrHp]').eq(1).val().length + formObj.find('input[name=usrTel]').eq(0).val().length + formObj.find('input[name=usrTel]').eq(1).val().length;
		if(  cnt == 0  ){
			alert("전화번호, 휴대전화번호 중 하나는 필수 입력입니다.");
			return true;
		}
		
		// 소속기관 NULL체크
		if ( nullCheckValdation( formObj.find('input[name=orgNm]').eq(0), "소속기관", "" ) ) {
			return true;
		}
		
		// 소속부서 NULL체크
		if ( nullCheckValdation( formObj.find('input[name=deptNm]').eq(0), "소속부서", "" ) ) {
			return true;
		}
		
		//업무 NULL체크
		if ( nullCheckValdation( formObj.find('input[name=accCd]').eq(0), "업무", "" ) ) {
			return true;
		}
		
		//업무- 국고보조금 선택시 입력해야한다.
		if( formObj.find("input:radio[name=accCd]:checked").val() == 'NAID' ){ //국고보조금 선택시.
			var naidCd = $("select[name=naidCd]").val();
			if( !($('input[name=naidId]').val().length > 0) && naidCd != "ehojo" ){ //입력을 안했다면
				if ( nullCheckValdation( $('input[name=naidId]'), "업무 ID", "" ) ) { //입력하라고한다.
					return true;
				}
			}
		}
		 
		return false;
	}

//국고보조금 연계시스템ID가 가입전 변경될경우 다시한번 ID확인
function naidIdOkd(){
	var naidCd = $("input[name=linkSysIdCheck]").val();
	if(naidCd == "Y"){
		$("input[name=linkSysIdCheck]").val("N");
	}
}
//]]> 
</script>              
</head>
<body>

		
		<!-- 상단 -->
		<c:import  url="/WEB-INF/jsp/portal/portaltop.jsp"/>  
		
		
		<!-- CONTAINER -->
		<div class="container" id="container">
		<div class="wrap">
			<div class="location">
				<h2 title="회원가입"><spring:message code='top.menu6_1'/></h2>
				<span><spring:message code='top.MenuHome'/> &gt;<spring:message code='top.menu9'/>&gt; <strong><spring:message code='top.menu6_1'/></strong></span>
			</div>
			<hr/>
			
			<!-- LEFT 탭 -->
			<c:import  url="/WEB-INF/jsp/portal/portalleft.jsp"/>
			<!-- END  -->
			
			<!-- 탭 내용 -->
			<div class="left-content">
				<form name="usrMemReg"  method="post" action="#">
				<input type="hidden" name="agreeYn" value="${usrAgreeYn}" /> <!-- 이용약관 동의여부 -->
				
				<div class="left-content-header">
					<p class="img6">회원으로 가입하시면 My Page 및 Open API 서비스 등을 이용하실 수 있습니다.</p>
				</div>
				
				<dl class="header-desc"> 
					<dd name="keyCryptInstallArea" style="display:none;"><b>키보드 보안 프로그램을 설치해 주세요. <button type="button" class="btn10" name="keyCryptInstallSet" >설치하기</button></b></dd> 
					<dd>(<span style="color:#ff0000;">*</span>)항목은 필수 입력입니다.</dd> 
					<dd>문자메세지 수신동의를 하지 않으시면 안내메시지를 받으실 수 없습니다.</dd> 
				</dl> 
				
				<div class="list-box" style="padding:0;">
					
					<table class="list05 view">
						<caption>회원가입</caption>
						<colgroup>
							<col width="110"/>
							<col width=""/>
							<col width="110"/>
							<col width=""/>
						</colgroup>
						<tr>
						<th>회원아이디 <span>*</span></th>
						<td colspan="3">
							<input type="text" name="usrId" id="usrMemRegId" value="" onkeydown="ComInputEngNum(this.id)" maxlength="20"/>
							<input type="hidden" name="usrIdDupCheck" value="N"/>
							<button type="button" class="btn01" name="btn_dup"><spring:message code="btn.dup"/></button>
							<span>영문, 숫자 5자 이상 ~ 20자 이내</span>
						</td>
						</tr>
						<tr>
							<th>이름 <span>*</span></th>
							<td colspan="3"><%=usrNm %></td>
							<input type="hidden" name="usrNm" value="<%=usrNm %>" maxlength="30"/>
							<input type="hidden" name="usrNmEng" value="abcd"/>
						</tr>
						<tr>
							<th>비밀번호 <span>*</span></th>
							<td colspan="3">
								<input type="password" size="15" name="usrPwCheck1" maxlength="20" autocomplete="off"/> &nbsp;&nbsp;
								<span style="font-weight:bold;">확인</span> <input type="password" name="usrPwCheck2" size="15" maxlength="20" autocomplete="off"/> <span>대문자, 소문자, 숫자, 특수문자 조합 8자 이상~20자 이내</span>
								<input type="hidden" name="usrPw" value="" maxlength="20"/>
							</td>
						</tr>
						<tr>
							<th>이메일</th>
							<td colspan="3">
								<input type="text" name="usrEmail" id="usrEmailFirst" maxlength="20"/> @
								<input type="text" name="usrEmailLast" id="usrEmailLast"  maxlength="30"/>
								<select name="usrEmailSelect" >
										<c:forEach var="code" items="${codeMap.usrEmail}" varStatus="status">
											<option value="${code.ditcCd}">${code.ditcNm}</option>
										</c:forEach>
								</select>
								<label for="email"><input type="checkbox" name="emailYn" value="N"/> 이메일 수신동의</label>
							</td>
						</tr>
						<tr>
							<th>업무전화번호</th>
							<td colspan="3">
								<select name="usrTel" >
									<option value="1">선택</option>
									<c:forEach var="code" items="${codeMap.usrTel}" varStatus="status">
										<option value="${code.ditcCd}">${code.ditcNm}</option>
									</c:forEach>  
								</select>
								<input type="text" size="10" name="usrTel"  maxlength="4" />
								<input type="text" size="10" name="usrTel"  maxlength="4"/>
							</td>
						</tr>
						<tr>
							<th>휴대전화번호</th>
							<td colspan="3">
								<select name="usrHp" >
									<option value="1">선택</option>
									<c:forEach var="code" items="${codeMap.usrHp}" varStatus="status">
										<option value="${code.ditcCd}">${code.ditcNm}</option>
									</c:forEach>
								</select>
								<input type="text" size="10" name="usrHp"  maxlength="4"/>
								<input type="text" size="10" name="usrHp"  maxlength="4"/>
								<label for="sms"><input type="checkbox" name="hpYn" value="N" /> 문자메세지 수신동의</label>
							</td>
						</tr>
						<tr>
							<th>소속기관 <span>*</span></th>
							<td>
								<input type="text" name="orgNm" maxlength="160"/>
							</td>
							<th>소속부서 <span>*</span></th>
							<td>
								<input type="text" name="deptNm" maxlength="160"/>
							</td>
						</tr>
						<tr>
							<th rowspan="2">업무</th>
							<td colspan="3" name="tdDut">
								<!-- <input type="radio" name="accCd" id="accCdCheck1" value="DATA"/><label for="accCd1">자료취합</label> -->
								<input type="radio" name="accCd" id="accCdCheck1" value="NONE"/><label for="accCd1">일반</label>
								<input type="radio" name="accCd" id="accCdCheck2" value="NAID"/><label for="accCd2">국고보조금</label>
								<span style="margin-left:20px;">※기타 업무에 대한 문의는 사용자지원실로 문의하시기 바랍니다.</span>
							</td>
						</tr>
						
						<tr name="trHidden"  style="display: none;"><!-- 국고보조금 라디오버튼 선택시 나타난다.  -->
							<td colspan="3" style="border-top-color: white;">    
								<select name="naidCd" style="float:left;margin:0 5px 0 0;">
										<c:forEach var="code" items="${codeMap.naidCd}" varStatus="status">
											<option value="${code.ditcCd}">${code.ditcNm}</option>
										</c:forEach>  
								</select>
								<span name="sysNoehojoSpan" style="float:left;">
								<input type="hidden" name="linkSysCd" value=""/>
								<input type="hidden" name="linkSysIdCheck" value="N"/>
								<input type="text" name="naidId" maxlength="20" onkeydown="naidIdOkd()"/>&nbsp;     
								</span>
								<span name="sysYesehojoSpan" style="float:left;display:none;">
								</span>
								<button type="button" class="btn01W" name="naidIdCheck">ID 확인</button>
								 <span name="naidSpan">ID는 대소문자를 구분합니다.</span>
							</td>  
							<!-- <td>
							<button type="button" class="btn01W" name="MyNaidList">My보조사업리스트</button>
							</td> -->
						</tr>
					</table>
					
					<div class="buttons" style="text-align:right;">
						<a href="#" class="btn02" name="a_memReg">회원가입</a>
					</div>
					
					<div class="btn-txt">
						재정정보 공개시스템의 회원정보는 <strong>개인정보처리방침</strong>에 의해 보호받고 있습니다.<br/>
						자세한 문의는 사용자지원실로 문의하시기 바랍니다.
					</div>
					
				</div>
				</form>
			</div>
			<!-- END -->
			
		</div>		
	
	</div>
	
	
	<!--##  푸터  ##-->                                       
	<c:import  url="/WEB-INF/jsp/portal/portalfooter.jsp"/>                                   
	<!--##  /푸터  ##-->
	
	
	<!--nProtect KeyCrypt 적용 시작-->  
		<script type="text/javascript" src="../../../js/nprotect/npkfx.js"></script>
	<!--nProtect KeyCrypt 적용 끝-->
	


</body>
<%
}
%>
</html>