<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="egovframework.common.WiseOpenConfig"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><spring:message code='wiseopen.title'/></title>
<c:import  url="/WEB-INF/jsp/inc/headinclude.jsp"/>
</head>
<script language="javascript"> 
//<![CDATA[      
$(document).ready(function() {  
	setTabButton();
	//passCheck();
	//emailYnCheck();
	//emailYnNullCheck();
	//hpYnCheck();
	//hpYnNullCheck();
	
	 //사용자 기본 정보 수신동의 체크 
	 /* if( $("input[name=emailCheck]").val() == 'Y' ){  //이메일 수신동의 
	 	$("input[name=emailYn]").prop("checked",true);
	 }
	 if( $("input[name=hpCheck]").val() == 'Y' ){  //문자메시지 수신동의 
	 	$("input[name=hpYn]").prop("checked",true);
	 } */
}); 

function doAction(sAction)                                  
{
	  	switch(sAction)
		{ 
	  		case "update": //비밀번호 요청
	  			var formObj = $("form[name=MemUpdInfo]");
	  			if (validateUserUpd(formObj)) {	
	  				return false;	
	  			}	//validation 체크
	  			
	  				  			
	  			if ( confirm("수정 하시겠습니까? ") ) {
					$("form[name=MemUpdInfo]").attr("action","<c:url value='/admin/user/memInfoUpd.do'/>").submit();
	  			}
				break;

	  		break;
		}
}
function passCheck(){ //비밀번호 일치여부 확인 
	  $("input[name=usrPwCheck1]").keyup(function(){ //첫번째 비밀번호 입력란.
		 $("input[name=usrPw]").val("");  //암호 저장값 초기화
	  });
	  
	  $("input[name=usrPwCheck2]").keyup(function(){ //두번째 비밀번호 입력란.
		  	 if( $("input[name=usrPwCheck1]").val() != $("input[name=usrPwCheck2]").val() ){
				 $("input[name=usrPw]").val("");  //암호 저장값 초기화
		  	 }else{
				 var pass = $("input[name=usrPwCheck2]").val();
				 $("input[name=usrPw]").val(pass);  //암호 저장.
		  	 }
		  });
}

function emailYnCheck(){ //이메일 수신동의 체크 Y/N
	  $("input:checkbox[name=emailYn]").change(function(){ 
		if( $('input[name=usrEmail]').eq(0).val().length > 0 && $('input[name=usrEmailLast]').eq(0).val().length  > 0 ){ //수신동의 하기위해선 이메일을 입력을 해야한다.  
		  if( $("input:checkbox[name=emailYn]").is(":checked") ){ //수신동의 했을때 Y
			  $("input:checkbox[name=emailYn]").prop("checked",true);
			  $("input:checkbox[name=emailYn]").val("Y");
		  }else{
			  $("input:checkbox[name=emailYn]").prop("checked",false); 
			  $("input:checkbox[name=emailYn]").val("N");
		  }
		}else{
			alert("이메일 입력 후 이메일 수신동의 하실 수 있습니다.");
			$("input:checkbox[name=emailYn]").prop("checked",false); 
			$("input:checkbox[name=emailYn]").val("N");
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
			alert("휴대전화번호 입력 후 문자메세지 수신동의 하실 수 있습니다.");
			$("input:checkbox[name=hpYn]").prop("checked",false);
			$("input:checkbox[name=hpYn]").val("N");
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
	 
	  $("a[name=a_memUpd]").click(function(e) { //수정버튼 요청 클릭시
		  	doAction("update");                                               
			return false;                  
	  });
	  
	  ////// 숫자만 입력하도록 체크.
	  $("input[name=usrTelSplit2]").keyup(function(e) {                     
		 ComInputNumObj($("input[name=usrTelSplit2]"));    
	 	 return false;                                                                          
	  });
	  
	  $("input[name=usrTelSplit3]").keyup(function(e) {                     
			 ComInputNumObj($("input[name=usrTelSplit3]"));    
		 	 return false;                                                                          
	  });
	  
	  $("input[name=usrHpSplit2]").keyup(function(e) {                     
			 ComInputNumObj($("input[name=usrHpSplit2]"));    
		 	 return false;                                                                          
	  });
		  
	  $("input[name=usrHpSplit3]").eq(1).keyup(function(e) {                     
			 ComInputNumObj($("input[name=usrHpSplit3]"));    
		 	 return false;                                                                          
	  });
	  
	  //이메일 체크
	  $("input[name=usrEmail]").eq(0).keyup(function(e) {                     
//		  	 ComInputEngNumObj($("input[name=usrEmail]").eq(0));
			 ComInputEngEtcObj($("input[name=usrEmail]").eq(0));
		 	 return false;                                                                          
	  });
	  $("input[name=usrEmailLast]").eq(0).keyup(function(e) {                     
		  	 ComInputEngDcmObj($("input[name=usrEmailLast]").eq(0));    
		 	 return false;                                                                          
	  });
	
	  
}


function validateUserUpd(formObj){ 

	//var check = /^(?=.*[a-z])(?=.*[A-Z])(?=.*[!@#$%^&*()-])(?=.*[0-9]).{8,20}$/; //비밀번호 체크
	/* 
	var check = /^[A-Za-z0-9]{8,20}$/;
	 //비밀번호 일치 유무 체크 (단, 비밀번호 수정안할경우 체크하지 않는다.)
	if(!( formObj.find("input[name=usrPwCheck1]").val().length == 0 && formObj.find("input[name=usrPwCheck2]").val().length == 0 )  ){
		if( $("input[name=usrPw]").val() == "" ){
			alert("비밀번호가 일치하지 않습니다.");
			formObj.find("input[name=usrPwCheck1]").val(""); //암호 틀릴시 초기화
			formObj.find("input[name=usrPwCheck2]").val(""); //암호 틀릴시 초기화
			formObj.find('input[name=usrPwCheck1]').focus();
			return true;
		}
	}

 	//비밀번호 조합 체크 (단, 비밀번호 수정안할경우 체크하지 않는다.)
 	if(!( formObj.find("input[name=usrPwCheck1]").val().length == 0 && formObj.find("input[name=usrPwCheck2]").val().length == 0 )  ){
		if ( !check.test($("input[name=usrPw]").val()) ) {
			alert("비밀번호는 영어와 숫자 조합 8자 이상~20자 조합으로 입력해 주세요");
			formObj.find("input[name=usrPwCheck1]").val(""); //암호 틀릴시 초기화
 			formObj.find("input[name=usrPwCheck2]").val(""); //암호 틀릴시 초기화
 			formObj.find('input[name=usrPwCheck1]').focus();
			return true;
		}
 	} */
	
 	
 	// 이메일 입력을 했을 때 null체크 
//	if( formObj.find('input[name=usrEmail]').eq(0).val().length + formObj.find('input[name=usrEmailLast]').eq(0).val().length > 0 ){
		/* 
		if ( nullCheckValdation( formObj.find('input[name=usrEmail]').eq(0), "이메일", "" ) ) {
			return true;
		}
		
		if ( nullCheckValdation( formObj.find('input[name=usrEmailLast]').eq(0), "이메일", "" ) ) {
			return true;
		} */
//	}
 	
	
	//전화번호 입력을 했다면 체크한다.  
	/* 
	if( (formObj.find('input[name=usrTelSplit2]').val().length + formObj.find('input[name=usrTelSplit3]').val().length )  > 0 || formObj.find('select[name=usrTelSplit1]').val()  != '1'){ 
		
		if( $("select[name=usrTelSplit1]").val() == '1' ){ //번호 선택 유무 체크
			alert("전화번호를 선택해주세요.");
			$("select[name=usrTelSplit1]>option[value=1]").attr("selected","true"); //콤보박스를 '선택'으로 초기화시킨다.
			return true;
		}
		
		// 전화번호 null체크 1
		if ( nullCheckValdation( formObj.find('input[name=usrTelSplit2]'), "전화번호", "" ) ) {
			return true;
		}
		
		// 전화번호 null체크 2
		if ( nullCheckValdation( formObj.find('input[name=usrTelSplit3]'), "전화번호", "" ) ) {
			return true;
		}
	}
	 */
	//휴대전화번호 입력을 했다면 체크한다.
	/* 
	if( (formObj.find('input[name=usrHpSplit2]').val().length + formObj.find('input[name=usrHpSplit2]').val().length ) > 0 || formObj.find('select[name=usrHpSplit1]').val()  != '1' ){
		
		if( $("select[name=usrHpSplit1]").val() == '1' ){ //번호 선택 유무 체크
			alert("휴대전화를 선택해주세요.");
			$("select[name=usrHpSplit1]>option[value=1]").attr("selected","true"); //콤보박스를 '선택'으로 초기화시킨다.
			return true;
		}
		
		// 휴대전화번호 null체크 1
		if ( nullCheckValdation( formObj.find('input[name=usrHpSplit2]'), "휴대전화", "" ) ) {
			return true;
		}
		
		// 휴대전화번호 null체크 2
		if ( nullCheckValdation( formObj.find('input[name=usrHpSplit3]'), "휴대전화", "" ) ) {
			return true;
		}
	}
	 */
	
	//전화번호, 휴대전화번호 중 하나는 필수 입력이다.
	/* 
	var cnt = formObj.find('input[name=usrHpSplit2]').val().length + formObj.find('input[name=usrHpSplit3]').val().length + formObj.find('input[name=usrTelSplit2]').val().length + formObj.find('input[name=usrTelSplit3]').val().length;
	if(  cnt == 0  ){
		alert("전화번호, 휴대전화번호 중 하나는 필수 입력입니다.");
		return true;
	} */ 
	
	// 소속기관 NULL체크
	if ( nullCheckValdation( formObj.find('input[name=orgNm]').eq(0), "소속기관", "" ) ) {
		return true;
	}
	
	// 소속부서 NULL체크
	if ( nullCheckValdation( formObj.find('input[name=deptNm]').eq(0), "부서", "" ) ) {
		return true;
	}
	
	if(formObj.find("select[name=notiStartHh]").val() > formObj.find("select[name=notiEndHh]").val()) {
		alert("알림시간이 잘못되었습니다.");
		return true;
	}
	
	return false;                               
}
	

           
//]]> 
</script> 
<body>
	
	<div class="wrap">
		
		<!-- 상단 -->
		<c:import  url="/admin/admintop.do"/>
		<!--  -->
					
		<!-- 내용 -->
		<div class="container">
			<!-- 상단 타이틀 -->   
			<div class="title">
				<h2>개인정보수정</h2>                                  
				<p>홈 &gt; 개인정보수정</p>         
			</div>
		
			
			<!-- 탭 내용 -->
			<div class="content-default" style="min-height:350px;">
				<form name="MemUpdInfo" action=""# method="post">
				<input type="hidden" name="emailCheck" value="${Usr.emailYn}"/> 
				<input type="hidden" name="hpCheck" value="${Usr.hpYn}"/>
				<input type="hidden" name="accCd" value="${Usr.accCd}" />
				<div style="margin-bottom:10px;">
					<span class="text-red">주의사항</span>
					<ul class="text">
						<!-- <li>소속 부서, 직책, 연락처 정보가 변경되면 반드시 수정하시기 바랍니다.</li> -->
						<li>담당자 변경 시에는 관리자에게 통보해주시기 바랍니다.</li>
					</ul>
				</div>
				
				<table class="list01">
					<caption>보유데이터목록리스트</caption>
					<colgroup>
						<col width="150"/>
						<col width=""/>
						<col width="150"/>
						<col width=""/>
					</colgroup>
					<tr>
						<th>회원아이디</th>
						<td colspan="3">
							<input type="text" name="usrId" value="${Usr.usrId}" class="readonly" readonly />
						</td>
					</tr>
					<tr>
						<th>이름</th>
						<td>
							<input type="text" value="${Usr.usrNm}" name="usrNm" class="readonly" readonly/>
							<%-- (영)<input type="text" value="${Usr.usrNmEng}" name="usrNmEng" /> --%>
						</td>
						<th>직책</th>
						<td>
							<input type="text" name="jobNm" maxlength="10" value="${Usr.jobNm }"/ class="readonly" readonly="readonly">
							<input type="text" name="jobCd" maxlength="10" value="${Usr.jobCd }"/ style="display: none;">
						</td>
					</tr>
					<tr>
						<th>소속기관</th>
						<td>
							<input type="text" value="${Usr.orgNm}" class="readonly" readonly />
						</td>
						<th>부서 <span>*</span></th>
						<td>
							<input type="text" name="deptNm" maxlength="30" value="${Usr.deptNm}" class="readonly" readonly/>
						</td>
					</tr>
					<%-- 
					<tr>
						<th>비밀번호</th>
						<td>
							<input type="password"  name="usrPwCheck1" maxlength="20" autocomplete="off"/>
						</td>
						<th>비밀번호확인</th>
						<td>
							<input type="password" size="15"  name="usrPwCheck2" maxlength="20" autocomplete="off"/>&nbsp<span>영어와 숫자 조합 8자 이상~20자 이내</span>
							<input type="hidden" name="usrPw" value=""/>
						</td>
					</tr>
					<tr>
						<th>이메일 <span>*</span></th>
						<td colspan="3">
							<input type="text" value="${Usr.usrEmailSplit1}" name="usrEmail"/>
							@
							<input type="text" value="${Usr.usrEmailSplit2}" name="usrEmailLast" id="usrEmailLast"/>
							<input type="checkbox" name="emailYn" value="N"/>
							<label for="agree">이메일 수신동의</label>
						</td>
					</tr>
					<tr>
						<th>연락처 <span>*</span>
						</th>
						<td>
							<select name="usrTelSplit1" >
									<option value="1">선택</option>
									<c:forEach var="code" items="${codeMap.usrTel}" varStatus="status">
										<c:choose> 
											<c:when test="${code.ditcCd == Usr.usrTelSplit1 }">
												<option value="${code.ditcCd}" selected="selected">${code.ditcNm}</option>
											</c:when>
											<c:otherwise>
												<option value="${code.ditcCd}">${code.ditcNm}</option>
											</c:otherwise>
										</c:choose>
									</c:forEach>
							</select>
							<input type="text" size="6" name="usrTelSplit2" value="${Usr.usrTelSplit2}"  maxlength="4"/>
							<input type="text" size="6" name="usrTelSplit3" value="${Usr.usrTelSplit3}"  maxlength="4"/>
						</td>
						<th>휴대전화</th>
						<td>
							<select name="usrHpSplit1" >
									<option value="1">선택</option>
									<c:forEach var="code" items="${codeMap.usrHp}" varStatus="status">
										<c:choose> 
											<c:when test="${code.ditcCd == Usr.usrHpSplit1 }">
												<option value="${code.ditcCd}" selected="selected">${code.ditcNm}</option>
											</c:when>
											<c:otherwise>
												<option value="${code.ditcCd}">${code.ditcNm}</option>
											</c:otherwise>
										</c:choose>
									</c:forEach>
								</select>
							<input type="text" size="6" name="usrHpSplit2" value="${Usr.usrHpSplit2}"  maxlength="4"/>
							<input type="text" size="6" name="usrHpSplit3" value="${Usr.usrHpSplit3}"   maxlength="4"/>
							<input type="checkbox" name="hpYn" value="N"  />
							<label for="agree2">문자메세지 수신동의</label>
						</td>
					</tr> --%>
					<tr>
						<th>알림시간</th>
						<td colspan="3">
							<select name="notiHhCd">
								<c:forEach var="code" items="${codeMap.notiHhCd}" varStatus="status">
									<c:choose> 
										<c:when test="${code.ditcCd == Usr.notiHhCd}">
											<option value="${code.ditcCd}" selected="selected">${code.ditcNm}</option>
										</c:when>
										<c:otherwise>
												<option value="${code.ditcCd}">${code.ditcNm}</option>
										</c:otherwise>
									</c:choose>
								</c:forEach>
							</select>
							<select name="notiStartHh">
								<c:forEach var="hh" begin="0" end="23" varStatus="status">
									<fmt:formatNumber var="no" value="${hh}" pattern="00"/>
									<c:choose> 
										<c:when test="${no == Usr.notiStartHh }">
											<option value="${no}" selected="selected">${no}시</option>
										</c:when>
										<c:otherwise>
											<option value="${no}">${no}시</option>
										</c:otherwise>
									</c:choose>
								</c:forEach>
							</select>
							부터
							<select name="notiEndHh">
								<c:forEach var="hh" begin="0" end="23" varStatus="status">
									<fmt:formatNumber var="no" value="${hh}" pattern="00"/>
									<c:choose> 
										<c:when test="${no == Usr.notiEndHh }">
											<option value="${no}" selected="selected">${no}시</option>
										</c:when>
										<c:otherwise>
											<option value="${no}">${no}시</option>
										</c:otherwise>
									</c:choose>
								</c:forEach>
							</select>
							까지 알림받음
						</td>
					</tr>
					<tr>
						<th>담당업무</th>
						<td colspan="3">
							<input type="text" name="usrWork" value="${Usr.usrWork}"  maxlength="100"/>
						</td>
					</tr>
				</table>	
				
				<div class="buttons">
					<a href="#" class="btn03" name="a_memUpd">수정</a>
				</div>
				</form>
			</div>
			
			<!-- END  -->
			
		</div>		
	
	</div>
	
	<!--##  푸터  ##-->                
	<c:import  url="/WEB-INF/jsp/admin/adminfooter.jsp"/>
	<!--##  /푸터  ##-->
	
</body>
</html>