<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ page import="egovframework.common.WiseOpenConfig"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="validator"
	uri="http://www.springmodules.org/tags/commons-validator"%>
<%
String ansCd = request.getParameter("ansCd"); //get방식으로 ansCd받아서 활용.
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><spring:message code="labal.surveyManagement"/>ㅣ<spring:message code='wiseopen.title'/></title>
<c:import url="/WEB-INF/jsp/inc/headinclude.jsp" />
<style type="text/css">
body {
	background: none;
}
</style>
<script language="javascript">
	$(document).ready(function() {

		setButton();
		dupCheck();
		initCheck();
		emailCheck();
		regCheck();
		//ip 중복시 버튼 숨김처리
		if ($("input[name=ipDup]").val() == '1') {
			$(".btn02").css("display", "none");
		}

	});
	
	function emailCheck(){ //이메일 직접입력 체크
		  $("select[name=ansEmailSelect]").change(function(){ //이메일 직접입력이 아니라면 @이후 입력불가
				if($("select[name=ansEmailSelect]").val() == 'na' ){
					$("#ansEmailLast").val(""); //초기화
					$("#ansEmailLast").attr("readonly",false);
				}else{
					var ansEmailSelect = $("select[name=ansEmailSelect]").val();
					$("#ansEmailLast").val(ansEmailSelect); // select 선택된 이메일을 입력한다.
					$("#ansEmailLast").attr("readonly",true);
				}
			});
	 }
	
	/* 설문팝업창에서 버튼들은 모두 필수체크이기에 첫번째 라디오버튼 체크한다.  */
	function initCheck(){ 
		
		$("input[name=ansAgeCd]").eq(0).attr("checked", true); //연령 첫번째 체크
		$("input[name=ansJobCd]").eq(0).attr("checked", true); //직업 첫번째 체크

		var questLength = 1 * $("input[name=questLength]").val(); //총 문항 개수 ,  문자열 -> 숫자 형변환
		for (var i = 1; i < questLength + 1; i++) {
	
			if ($("input[name=questExamCd" + i + "]").val() == 'RADIO') { // radio 버튼일경우.
				$("input[name=examSeq" + i + "]").eq(0).attr("checked", true); //설문조사 라디오 첫번째 체크
			}
			
			if ( $("input[name=questExamCd" + i + "]").val() == 'RADIOmanual' ){  // radiomanual 버튼일경우. 수동으로 직접 지문작성하는 radio..
				var radioCnt = $("input[name=radioCnt"+i+"]").val(); //라디오버튼내에 지문그룹이 2개이상인 경우가 대다수라 for 문으로 횟수만큼 집어넣겠다.
				for(var k=1; k <= radioCnt; k++){
					var radioName = $("input[name = examSeq" + i +"_"+k+" ]").eq(0).attr("checked", true); //설문조사 라디오 첫번째 체크
				}
			}
			
		}
	}

	/*Sheet 각종 처리*/
	function doAction(sAction) {
		ajaxBeforeSendAdmin("<c:url value='/admin/ajaxBeforeSendAdmin.do'/>"); //IbSheet 조회전 세션 체크
		switch (sAction) {

		case "save": //설문등록
			if (!confirm("설문완료 하시겠습니까? ")) {
				return;
			}

			var param = $("#frmAnsInfo").serializeObject(); //폼정보 serialize
			var questLength = 1 * $("input[name=questLength]").val(); //문자를 숫자로 형변환
			if( $("input[name=user2Yn]").val() == "Y" ){ //사용자 상세정보를 입력을 했다면 
				param.ansTel ="";
				param.ansEmail ="";
				param.ansTel = $("[name=ansTel]").eq(0).val() + "," +$("[name=ansTel]").eq(1).val() + "," +$("[name=ansTel]").eq(2).val();
				param.ansEmail = $("[name=ansEmail]").eq(0).val() + "," +$("[name=ansEmail]").eq(1).val();
			}
			//초기화
			param.examSeq = "";
			param.questSeq = "";
			param.examVal = "";
			param.examAns = "";
			param.questExamCd = "";
			for (var i = 1; i < questLength + 1; i++) { //체크된 값들 배열에 담는다. split사용할것이다.
				var gradeCnt = $(":radio[name=examSeq" + i + "]").index($(":radio[name=examSeq" + i + "]:checked")); //1~10개중 선택된 지문의 index구한다.
				if ($("input[name=questExamCd" + i + "]").val() == 'RADIO') { // radio 버튼일경우.
					var tmp = $(":radio[name=examSeq" + i + "]:checked").val(); //split하기위해 공백으로 구분을 둔다.
					param.examSeq += tmp;
					param.examSeq += " "; //split하기 위한 구분으로 공백사용

					var tmp2 = $("input[name=questSeq" + i + "]").val();
					param.questSeq += tmp2;
					param.questSeq += " ";

					var tmp3 = $("input[name=examVal" + i + "_" + gradeCnt + "]").val(); //선택되는 지문값..척도5..등등저장용
					param.examVal += tmp3;
					param.examVal += " ";

					var tmpCd = $("input[name=questExamCd" + i + "]").val(); //분기문사용하기위한 타입저장
					param.questExamCd += tmpCd;
					param.questExamCd += " ";

					var tmpFake = null; //배열로 저장되기에  null을 넣어 인덱스에 채워준다. 
					param.examAns += tmpFake;
					param.examAns += "12.34,56";

				} else if ($("input[name=questExamCd" + i + "]").val() == 'TEXT'
						|| $("input[name=questExamCd" + i + "]").val() == 'CLOB') { //text200,4000자 일때.
					var tmp4 = $("input[name=examSeq" + i + "]").val(); //text 200자 일때.
					param.examSeq += tmp4;
					param.examSeq += " ";

					if ($("input[name=questExamCd" + i + "]").val() == 'TEXT') { //200자 일때.
						var tmp5 = $("input[name=examAns" + i + "]").val(); //exam_ans컬럼 저장
						param.examAns += tmp5;
						param.examAns += "12.34,56";
					} else if ($("input[name=questExamCd" + i + "]").val() == 'CLOB') { //4000자 일때.
						var tmp5 = $("textarea[name=examAns" + i + "]").val(); //exam_ans컬럼 저장
						param.examAns += tmp5;
						param.examAns += "12.34,56";
					}

					var tmp6 = $("input[name=questSeq" + i + "]").val();
					param.questSeq += tmp6;
					param.questSeq += " ";

					var tmpCd = $("input[name=questExamCd" + i + "]").val(); //분기문사용하기위한 타입저장
					param.questExamCd += tmpCd;
					param.questExamCd += " ";

					var tmpFake = null; //배열로 저장되기에 text라도 null을 넣어 인덱스에 채워준다. 
					param.examVal += tmpFake;
					param.examVal += " ";
				} else if ( $("input[name=questExamCd" + i + "]").val() == 'RADIOmanual' ){  // radiomanual 버튼일경우. 수동으로 직접 지문작성하는 radio..
					var radioCnt = $("input[name=radioCnt"+i+"]").val(); //라디오버튼내에 지문그룹이 2개이상인 경우가 대다수라 for 문으로 횟수만큼 집어넣겠다.
					for(var k=1; k <= radioCnt; k++){
						var radioName = $("input[name = examSeq" + i +"_"+k+" ]").attr("name");
						var tmp = $("input[name="+ radioName +" ]:checked").val(); //지문그룹중 지문 몇번을 선택했는지 찾는다.
						
						param.examSeq += tmp;
						param.examSeq += " "; //split하기 위한 구분으로 공백사용
					
						var tmp2 = $("input[name=questSeq" + i + "]").val();
						param.questSeq += tmp2;
						param.questSeq += " ";
	
						var tmp3 = 0; // RADIOmanual의 경우 examVal의 값이 전부 0이다. 
						param.examVal += tmp3;
						param.examVal += " ";
	
						var tmpCd = $("input[name=questExamCd" + i + "]").val(); //분기문사용하기위한 타입저장
						param.questExamCd += tmpCd;
						param.questExamCd += " ";
	
						
						//체크한 값의 기타답변내용만 저장할 것이기에 체크한 부분의 index를 가지고 eq에서 사용하여 텍스트를 가져올 것 이다. index는 0부터 시작
						var checkIndex = $(":radio[name=examSeq" + i +"_"+k+"]").index($(":radio[name=examSeq" + i +"_"+k+ "]:checked"));
						
						//if문을 통해 type이 text일때 가져오고 hidden일때 null값을 보내면 기타답변이 Y인지 N인지 구분가능할듯.
  						if( $("input[name=examAns" + i + "_"+k+"]").eq(checkIndex).attr("type") == "text" ){
  							var tmp4 = $("input[name=examAns" + i + "_"+k+"]").eq(checkIndex).val();
 							param.examAns += tmp4;
 							param.examAns += "12.34,56";
  						}else{
 							var tmp4 = null; //배열로 저장되기에  null을 넣어 인덱스에 채워준다. 
 							param.examAns += tmp4;
 							param.examAns += "12.34,56";
 						}
					}
				} else if ( $("input[name=questExamCd" + i + "]").val() == 'CHECK' ){  // check 버튼일경우. 수동으로 직접 지문만드는 check..
				 	var checkCnt = $("input[name=checkCnt"+i+"]").val(); //체크버튼내에 지문그룹이 2개이상인 경우가 대다수라 for 문으로 횟수만큼 집어넣겠다. 지문그룹 개수
					
				 	for(var k=1; k <= checkCnt; k++){
						var checkGroupCnt = $("input[name = examSeq" + i +"_"+k+" ]:checked").length; //하나의 지문 그룹내에서 check한 총 개수 
// 						if(checkGroupCnt == 0){ // 체크를 필수로 해야한다. 최소 한개이상해야한다.
// 							alert("");
// 							return false;
// 						}
						 for(var G=0; G < checkGroupCnt; G++){
							var checkName = $("input[name = examSeq" + i +"_"+k+" ]").attr("name"); //check의 name을 찾는다.
							var tmp = $("input[name="+ checkName +" ]:checked").eq(G).val(); //지문그룹중 지문 몇번을 선택했는지 찾는다.
							
							
							param.examSeq += tmp;
							param.examSeq += " "; //split하기 위한 구분으로 공백사용
						
							var tmp2 = $("input[name=questSeq" + i + "]").val();
							param.questSeq += tmp2;
							param.questSeq += " ";
		
							var tmp3 = 0; // check 의 경우 examVal의 값이 전부 0이다. 
							param.examVal += tmp3;
							param.examVal += " ";
		
							var tmpCd = $("input[name=questExamCd" + i + "]").val(); //분기문사용하기위한 타입저장
							param.questExamCd += tmpCd;
							param.questExamCd += " ";
		
							var checkIndex = $("input[name="+ checkName +" ]").index( $("input[name="+ checkName +" ]:checked").eq(G) ); //examAns의 체크  index구한다.
							
							//if문을 통해 type이 text일때 가져오고 hidden일때 null값을 보내면 기타답변이 Y인지 N인지 구분가능할듯.
							//힌트 여기서 텍스트의 eq값만 알아내면 끝날거같다.
							if( $("input[name=examAns" + i + "_"+k+"]").eq(checkIndex).attr("type") == "text" ){
	  							var tmp4 = $("input[name=examAns" + i + "_"+k+"]").eq(checkIndex).val();
	 							param.examAns += tmp4;
	 							param.examAns += "12.34,56"; //split 기준인데.. 음..
	 							
	  						}else{
	 							var tmp4 = null; //배열로 저장되기에  null을 넣어 인덱스에 채워준다. 
	 							param.examAns += tmp4;
	 							param.examAns += "12.34,56";
	 						}
						} 
					} 
				}
			}
			var url = "<c:url value='/admin/bbs/surveyAnsExamPopReg.do'/>";
			ajaxCallAdmin(url, param, OnSaveEnd); //   콜백을  OnSaveEnd로 설정.
			break;

		}
	}

	function OnSaveEnd() {
		window.close(); //팝업창 닫는다.
	}

	//체크박스 중복개수 처리
	function dupCheck() {
		$("#surveyInfoQuest li[name=checkLi] :checkbox").click(function() { //체크박스 개수 제한
					var checkNm = $(this).attr("name");
					var checkTot = $("input:checkbox[name=" + checkNm+ ']').length; //해당 문항의 체크박스 전체개수
					var checkCnt = $("input:checkbox[name=" + checkNm+ ']:checked').length; //해당 문항의 체크박스 선택된 개수
					var maxDupCnt = $("input:checkbox[name=" + checkNm + ']').attr("maxlength"); //해당 문항의 체크박스 중복선택가능 개수
					if ( (checkCnt == maxDupCnt) && (checkTot != 1) ) { //단 체크박스개수가 총1개라면 적용안한다.
						for (var i = 0; i < checkTot; i++) {
							if (!$("input:checkbox[name=" + checkNm+ ']').eq(i).is(":checked")) { //체크들을 검사하여 true가 아닌것은 disabled한다.
									$("input:checkbox[name="+ checkNm + ']').eq(i).attr('disabled', true);
								}
							}
					} else if (checkCnt < maxDupCnt) {
						$("input:checkbox[name=" + checkNm + ']').attr('disabled', false);
					}
				});
	}

	function setButton() {
		$(" div[name=surveyInfo] a[name=surveyInfoButton]").click(function(e) { //설명 다음버튼
			if ($("input[name=loginYn]").val() == 'Y' && $("input[name=user2Yn]").val() == 'N' && $("input[name=user2Yn]").val() == 'N') { //로그인후 응답버튼만 체크했다면 응답자 정보는 점프. 
				$(" div[name=surveyInfo]").css("display", "none");
				$(" div[name=surveyInfoQuest] ").css("display", "block");
			} else {
				$(" div[name=surveyInfo]").css("display", "none");
				$(" div[name=surveyInfoDtl] ").css("display", "block");
			}
			return false;
		});

		$(" div[name=surveyInfoDtl] a[name=surveyInfoDtlButtonAfter]").click(
				function(e) { //응답자 정보 다음버튼
					//상세정보도 입력해야 한다면 필수로 입력해야 한다.
					if( $("input[name=user2Yn]").val() == "Y" ){ 
						if(validateAnsReg() ){
							return false; 
						}
					}else if( $("input[name=user1Yn]").val() == "Y"){ //기본수집만 한다면..
						//개인정보수집 이용동의 체크 필수
						if (nullCheckValdation($('input[name=agreeYn]'), "개인정보수집 이용 동의", "")) {
							return true;
						}
					}
				
					$(" div[name=surveyInfo]").css("display", "none");
					$(" div[name=surveyInfoDtl] ").css("display", "none");
					$(" div[name=surveyInfoQuest] ").css("display", "block");
					
					return false;
		});

		$(" div[name=surveyInfoDtl] a[name=surveyInfoDtlButtonBefore]").click(
				function(e) { //응답자 정보 이전버튼
					$(" div[name=surveyInfo]").css("display", "block");
					$(" div[name=surveyInfoDtl] ").css("display", "none");
					$(" div[name=surveyInfoQuest] ").css("display", "none");
					return false;
		});

		$(" div[name=surveyInfoQuest] a[name=surveyInfoButtonBefore]").click(
				function(e) { //설문 정보 이전버튼
				if ($("input[name=loginYn]").val() == 'Y' && $("input[name=user2Yn]").val() == 'N' && $("input[name=user2Yn]").val() == 'N') { //로그인후 응답버튼만 체크했다면 응답자 정보는 점프. 
					$(" div[name=surveyInfo]").css("display", "block");
					$(" div[name=surveyInfoDtl] ").css("display", "none");
					$(" div[name=surveyInfoQuest] ").css("display", "none");
				} else {
					$(" div[name=surveyInfo]").css("display", "none");
					$(" div[name=surveyInfoDtl] ").css("display", "block");
					$(" div[name=surveyInfoQuest] ").css("display", "none");
				}	
				return false;
		});

		$(" div[name=surveyInfoQuest] a[name=a_close]").click(function(e) { // 팝업창 닫기
			window.close();
			return false;
		});
		

		//설문관리자 페이지에서는 설문등록하기 없다. 풀면 사용가능
		$(" div[name=surveyInfoQuest] a[name=a_reg]").click(function(e) { // 사용자 설문조사 등록
			doAction("save");
			return false;                 
		});
		
		if($("input[name=SurveyQuestCnt]").val() == "0"){
			$("a[name=a_reg]").css("display", "none"); //설문 문항이 없다면 등록 막아버린다.
		}
		
		 
	//////숫자만 입력하도록 체크.
		$("input[name=ansTel]").eq(0).keyup(function(e) {
			ComInputNumObj($("input[name=ansTel]").eq(0));
			return false;
		});

		$("input[name=ansTel]").eq(1).keyup(function(e) {
			ComInputNumObj($("input[name=ansTel]").eq(1));
			return false;
		});

		//이메일 영문, 숫자만 입력
		$("#ansEmailFirst").keyup(function(e) {
			ComInputEngNumObj($("#ansEmailFirst"));
			return false;
		});

		//이메일 영문, 숫자, 점(dot)만 입력
		$("#ansEmailLast").keyup(function(e) {
			engNumDotCheck($("#ansEmailLast"));
			return false;
		});
		
		//개인정보 수집 동의
	  	$("input:checkbox[name=agreeYn]").click(function(){ 
	 		var chk = $("input:checkbox[name=agreeYn]").is(":checked");
	 		if(chk){
	 			$("input:checkbox[name=agreeYn]").attr("checked",true);
	 		}else{
	 			$("input:checkbox[name=agreeYn]").attr("checked",false);
	 		}
	  	});

	}
	
	function regCheck(){
		 var now = new Date;
		 var year = now.getFullYear();  //년도
		 var month =now.getMonth()+1;	//월
		 if((month + "").length < 2){   // 월의 자리수가 1인경우 앞에 0붙임.ex) 01,02,03..10,11,12
			 month = "0" + month;
		 }
		 var date = now.getDate();		//날
		 if((date + "").length < 2){
			 date = "0" + date;
		 }
		 var today = year + "-" + month + "-" + date; 
		 var startDttm = $("input[name=startDttm]").val();
		 var endDttm = $("input[name=endDttm]").val();
		 
		 if( !((today >= startDttm) && (today <= endDttm)) ){ //등록하기 설문기간에만 보임
			 $("a[name=a_reg]").css("display", "none");
		 }
	}
	
	
	//영문, 숫자, dot 체크
	function engNumDotCheck(obj) {
		obj.css("ime-mode", "disabled");
		strb = obj.val().toString();
		strb = strb.replace(/[^0-9a-zA-Z.]/g, '');
		obj.val(strb);
	}

	function validateAnsReg() {
		
		//개인정보수집 이용동의 체크 필수
		if (nullCheckValdation($('input[name=agreeYn]'), "개인정보수집 이용 동의", "")) {
			return true;
		}
		
		// 전화번호 null체크 1
		if (nullCheckValdation($('input[name=ansTel]').eq(0), "연락처", "")) {
			return true;
		}

		// 전화번호 null체크 2
		if (nullCheckValdation($('input[name=ansTel]').eq(1), "연락처", "")) {
			return true;
		}

		// 이메일 입력을 했을 때 null체크 
		if (nullCheckValdation($('input[name=ansEmail]').eq(0), "이메일", "")) {
			return true;
		}

		if (nullCheckValdation($('input[name=ansEmail]').eq(1), "이메일", "")) {
			return true;
		}

	}
</script>
</head>
<body onload="">
	<div class="wrap-popup">

		<!-- 내용 -->
		<div class="container">

			<!-- 상단 타이틀 -->
			<div class="title">
				<h2>설문조사</h2>
			</div>

			<!-- 탭 내용 -->
			<form name="frmAnsInfo" id="frmAnsInfo" method="post" action="#">
				<input type="hidden" name="surveyId" value="${Survey.surveyId}">
				<input type="hidden" name="ansIp" value="${ClientIp}">
				<input type="hidden" name="loginYn" value="${Survey.loginYn}"> 
				<input type="hidden" name="questLength" value="${fn:length(SurveyQuest)}" />
				<input type="hidden" name="user1Yn" value="${Survey.user1Yn}" />
				<input type="hidden" name="user2Yn" value="${Survey.user2Yn}" />
				<input type="hidden" name="SurveyQuestCnt" value="${SurveyQuestCnt}" />
				<input type="hidden" name="startDttm" value="${Survey.startDttm}" />
				<input type="hidden" name="endDttm" value="${Survey.endDttm}" />
				<!-- 문항전체 개수 -->
				<div class="popup" style="padding: 20px;">
 					<c:if test="${(Survey.ipDupYn == 'N') && (ClientIpDup > 0)}">
						<p class="text-red">이미 설문에 답변해주신 분은 응답하실 수 없습니다.</p>
						<input type="hidden" value="1" name="ipDup" /> 
						<!-- ip중복시 제어 -->
 					</c:if>
					<h2 class="survey-title">${Survey.surveyNm}</h2>
					<p class="survey-day">설문기간 : ${Survey.startDttm} ~
						${Survey.endDttm}</p>

					<div class="survey-obj" name="surveyInfo">
						<h3 class="text-title3">설명</h3>
						<p class="desc-bx">${Survey.surveyExp}</p>
						<p>
							<%-- ${Survey.surveyDesc} --%>
						</p>
						<!-- 설문 요지/요약  -->

						<div class="buttons">
							<a href="#" class="btn02" name="surveyInfoButton" title="다음">다음 <img
								src="../../../img/icon_arrow2.gif" border="0" /></a>
						</div>
					</div>


					<div class="survey-obj" name="surveyInfoDtl" style="display: none;">
						<input type="hidden" name="ansCd" value="" />
						<p class="text-title3">응답자 정보</p>
						<p> 
							설문에 앞서 응답자의 기본 정보를 수집합니다. 조사 분석 외의 목적으로는 사용되지 않습니다.<br /> <label
								for="agreeYn"><strong>개인정보수집 및 이용에 동의합니다 </strong><input
								type="checkbox" name="agreeYn" id="agreeYn" value="Y" /></label>
						</p>
						<table class="list03">
							<caption>설문미리보기</caption>
							<colgroup>
								<col width="150" />
								<col width="" />
								<col width="150" />
								<col width="" />
								<col width="150" />
								<col width="" />
							</colgroup>
							<tr>
								<th>귀하의 성별은?</th>
								<td colspan="3"><input type="radio" id="male" name="ansSex"
									checked="checked" value="M" /> <label for="male">남</label> <input
									type="radio" id="female" name="ansSex" value="F" /> <label
									for="female">여</label></td>
							</tr>


							<tr>
								<th>귀하의 연령은?</th>
								<td colspan="3"><c:forEach var="code" items="${codeMap.ansAge}" varStatus="status">
										<%-- <option value="${code.ditcCd}">${code.ditcNm}</option> --%>
										<input type="radio" name="ansAgeCd" id="ansAgeCd" value="${code.ditcCd}" />
										<label for="ansAgeCd">${code.ditcNm}</label>
									</c:forEach></td>
							</tr>
							<tr>
								<th>귀하의 직업은?</th>
								<td colspan="3"><c:forEach var="code" items="${codeMap.ansJob}" varStatus="status">
										<%-- <option value="${code.ditcCd}">${code.ditcNm}</option> --%>
										<input type="radio" name="ansJobCd" id="ansJobCd" value="${code.ditcCd}" />
										<label for="ansJobCd">${code.ditcNm}</label>
										<br />
									</c:forEach></td>
							</tr>

							<c:if test="${Survey.user2Yn == 'Y'}">
								<tr>
									<th>연락처</th>
									<td colspan="3"><select name="ansTel">
											<c:forEach var="code" items="${codeMap.ansTel}" varStatus="status">
												<option value="${code.ditcCd}">${code.ditcNm}</option>
											</c:forEach>
										</select> 
									<input type="text" size="6" name="ansTel" maxlength="4" /> 
									<input type="text" size="6" name="ansTel" maxlength="4" /></td>
								</tr>
								<tr>	
									<th>이메일</th>
									<td colspan="3"><input type="text" name="ansEmail" id="ansEmailFirst" maxlength="20" /> @ 
										<input type="text" name="ansEmail" id="ansEmailLast"  maxlength="30"/> 
										<select name="ansEmailSelect">
											<c:forEach var="code" items="${codeMap.ansEmail}" varStatus="status">
												<option value="${code.ditcCd}">${code.ditcNm}</option>
											</c:forEach>
										</select></td>
								</tr>
							</c:if>

						</table>

						<div class="buttons">
							<a href="#" class="btn02" style="float: left;"
								name="surveyInfoDtlButtonBefore" title="이전"><img
								src="../../../img/icon_arrow3.gif" border="0" /> 이전</a> <a href="#"
								class="btn02" name="surveyInfoDtlButtonAfter" title="다음">다음 <img
								src="../../../img/icon_arrow2.gif" border="0" /></a>
						</div>
					</div>

					<div class="survey-obj" name="surveyInfoQuest" id="surveyInfoQuest"
						style="display: none;">
						<p class="text-title3">설문</p>
						<c:forEach var="surveyQuest" items="${SurveyQuest}" varStatus="status">
							<c:if test="${not empty surveyQuest.grpExp}">
								<br />
								<p>[${surveyQuest.grpExp}]</p>
								<!--[문항그룹] -->
							</c:if>


							<c:set var="examCnt" value="${status.count}" />
							<!--각 지문의 이름을 다르게 주기위해사용 -->

							<table class="list04">
								<caption>문항그룹</caption>
								<colgroup>
									<col width="" />
									<col width="" />
								</colgroup>
								<tr>
									<th>${surveyQuest.questNo}.${surveyQuest.questNm}</th>
									<!-- 1. 항목 -->
								</tr>
								<tr>
									<td><c:choose>
											<c:when test="${surveyQuest.examCd == 'RADIO'}">
												<!-- radio 문항유형  -->
												<ul>
													<c:set var="gradeCnt" value="0" />
													<!-- 2개 이상의 지문에서 몇번째 지문인지 구별  -->
													<c:set var="cnt" value="1" />
													<!-- 지문그룹이 있기에 ex)만족도..와 달리 한단계 더 구조가 깊어진다.  -->
													<c:forEach var="surveyExam" items="${SurveyExam}" varStatus="status">
														<c:if test="${(surveyExam.questNo == surveyQuest.questNo ) && (surveyExam.questSeq == surveyQuest.questSeq)}">
															<c:if test="${ not empty surveyExam.grpExp }">  
																<li><strong>[${surveyExam.grpExp}]</strong></li>
																<c:if test="${ (gradeCnt) != 0}">   <!-- 첫번째 지문이 지문그룹인경우 제외하고 ++ 한다.  -->
																	<c:set var="cnt" value="${cnt+1}" />
																</c:if>
															</c:if>
															<!-- 이부분 구조가 깊어진다. 지문그룹이 많을수록..  -->
															<li><input type="radio" name="examSeq${examCnt}_${cnt}" id="examSeq${examCnt}_${cnt}" value="${surveyExam.examSeq}" /><label for="examSeq${examCnt}_${cnt}">${surveyExam.examNm}</label>
																<input type="hidden" name="questSeq${examCnt}" value="${surveyQuest.questSeq}"> 
<%-- 																<input type="hidden" name="examVal${examCnt}_${gradeCnt}" value="${surveyExam.examVal}">  --%>
																<input type="hidden" name="questExamCd${examCnt}" value="RADIOmanual" />
																<c:if test="${not empty surveyExam.examExp}">
																	<br /><span>${surveyExam.examExp}</span>
																</c:if> 
																
																<!-- 기타답변 선택시  -->
																<!-- 기타답변 미선택시.. name을 eq로 선택하기위해 hidden 만듬.. -->
																<c:choose>
																	<c:when test="${surveyExam.etcYn == 'Y'}"> 
																		<br />
																		<span><input type="text" maxlength="200" style="width: 97%;" name="examAns${examCnt}_${cnt}" /></span>
																	</c:when>
																	<c:otherwise>
																		<span><input type="hidden" maxlength="200" style="width: 97%;" name="examAns${examCnt}_${cnt}" /></span>
																	</c:otherwise>
																</c:choose>
															<c:set var="gradeCnt" value="${gradeCnt+1}" />
															</li>
														</c:if>
													</c:forEach>
													<input type="hidden" name="radioCnt${examCnt}" value="${cnt}" /> <!-- 총 지문그룹의 개수  -->
												</ul>
											</c:when>

											<c:when test="${surveyQuest.examCd == 'CHECK'}">
												<!-- CHECK 문항유형  -->
												<ul>
													<c:set var="gradeCnt" value="0" />
													<!-- 2개 이상의 지문에서 몇번째 지문인지 구별  -->
													<c:set var="cnt" value="1" />
													<!-- 지문그룹이 있기에 ex)만족도..와 달리 한단계 더 구조가 깊어진다.  -->
													<c:forEach var="surveyExam" items="${SurveyExam}" varStatus="status">
														<c:if test="${(surveyExam.questNo == surveyQuest.questNo ) && (surveyExam.questSeq == surveyQuest.questSeq)}">
															<c:if test="${not empty surveyExam.grpExp}">
																<li><strong>[${surveyExam.grpExp}]</strong></li>
																<c:if test="${ (gradeCnt) != 0}">   <!-- 첫번째 지문이 지문그룹인경우 제외하고 ++ 한다.  -->
																	<c:set var="cnt" value="${cnt+1}" />
																</c:if>
															</c:if>
															<li name="checkLi"><input type="checkbox" name="examSeq${examCnt}_${cnt}" id="examSeq${examCnt}_${cnt}" value="${surveyExam.examSeq}" maxlength="${surveyQuest.maxDupCnt}" />
															<label for="examSeq${examCnt}_${cnt}">${surveyExam.examNm} </label>
															<input type="hidden" name="questSeq${examCnt}" value="${surveyQuest.questSeq}"> 
<%-- 															<input type="hidden" name="examVal${examCnt}_${gradeCnt}" value="${surveyExam.examVal}">  --%>
															<input type="hidden" name="questExamCd${examCnt}" value="CHECK" /> 
															<c:if test="${not empty surveyExam.examExp}">
																<br /><span>${surveyExam.examExp}</span>
															</c:if>
															<!-- 기타답변 선택시  -->
															<!-- 기타답변 미선택시.. name을 eq로 선택하기위해 hidden 만듬.. -->
															<c:choose>
																<c:when test="${surveyExam.etcYn == 'Y'}"> 
																	<br />
																	<span><input type="text" maxlength="200" style="width: 97%;" name="examAns${examCnt}_${cnt}" /></span>
																</c:when>
																<c:otherwise>
																	<span><input type="hidden" maxlength="200" style="width: 97%;" name="examAns${examCnt}_${cnt}" /></span>
																</c:otherwise>
															</c:choose>
															<c:set var="gradeCnt" value="${gradeCnt+1}" />
															</li>
														</c:if>
													</c:forEach>
													<input type="hidden" name="checkCnt${examCnt}" value="${cnt}" /> <!-- 총 지문그룹의 개수  -->
												</ul>
											</c:when>

											<c:when test="${surveyQuest.examCd == 'SASF5'}">
												<!-- 만족도5 -->
												<ul>
													<c:set var="gradeCnt" value="0" />
													<c:forEach var="surveyExamCd" items="${SurveyExamCd}" varStatus="status">
														<c:if test="${surveyExamCd.ditcCd == 'SASF5'}">
															<li><input type="radio" name="examSeq${examCnt}" id="examSeq${examCnt}" value="${surveyExamCd.examSeq}" class="examSeq" />
															<label for="examSeq${examCnt}">${surveyExamCd.examNm}</label>
															<input type="hidden" name="questSeq${examCnt}" value="${surveyQuest.questSeq}"> 
															<input type="hidden" name="examVal${examCnt}_${gradeCnt}" value="${surveyExamCd.examVal}"> 
															<input type="hidden" name="questExamCd${examCnt}" value="RADIO" />
															</li>
															<c:set var="gradeCnt" value="${gradeCnt+1}" />
														</c:if>
													</c:forEach>
												</ul>
											</c:when>

											<c:when test="${surveyQuest.examCd == 'APPR5'}">
												<!-- 평가도5 -->
												<ul>
													<c:set var="gradeCnt" value="0" />
													<c:forEach var="surveyExamCd" items="${SurveyExamCd}" varStatus="status">
														<c:if test="${surveyExamCd.ditcCd == 'APPR5'}">
															<li><input type="radio" name="examSeq${examCnt}" id="examSeq${examCnt}"
																value="${surveyExamCd.examSeq}" /><label for="examSeq${examCnt}">${surveyExamCd.examNm}</label>
																<input type="hidden" name="questSeq${examCnt}"
																value="${surveyQuest.questSeq}"> <input
																type="hidden" name="examVal${examCnt}_${gradeCnt}"
																value="${surveyExamCd.examVal}"> <input
																type="hidden" name="questExamCd${examCnt}" value="RADIO" />
															</li>
															<c:set var="gradeCnt" value="${gradeCnt+1}" />
														</c:if>
													</c:forEach>
												</ul>
											</c:when>
											<c:when test="${surveyQuest.examCd == 'IRST5'}">
												<!-- 관심도5 -->
												<ul>
													<c:set var="gradeCnt" value="0" />
													<c:forEach var="surveyExamCd" items="${SurveyExamCd}" varStatus="status">
														<c:if test="${surveyExamCd.ditcCd == 'IRST5'}">
															<li><input type="radio" name="examSeq${examCnt}" id="examSeq${examCnt}"
																value="${surveyExamCd.examSeq}" /><label for="examSeq${examCnt}">${surveyExamCd.examNm}</label>
																<input type="hidden" name="questSeq${examCnt}"
																value="${surveyQuest.questSeq}"> <input
																type="hidden" name="examVal${examCnt}_${gradeCnt}"
																value="${surveyExamCd.examVal}"> <input
																type="hidden" name="questExamCd${examCnt}" value="RADIO" />
															</li>
															<c:set var="gradeCnt" value="${gradeCnt+1}" />
														</c:if>
													</c:forEach>
												</ul>
											</c:when>
											<c:when test="${surveyQuest.examCd == 'NEED5'}">
												<!-- 필요성5 -->
												<ul>
													<c:set var="gradeCnt" value="0" />
													<c:forEach var="surveyExamCd" items="${SurveyExamCd}" varStatus="status">
														<c:if test="${surveyExamCd.ditcCd == 'NEED5'}">
															<li><input type="radio" name="examSeq${examCnt}" id="examSeq${examCnt}"
																value="${surveyExamCd.examSeq}" /><label for="examSeq${examCnt}">${surveyExamCd.examNm}</label>
																<input type="hidden" name="questSeq${examCnt}"
																value="${surveyQuest.questSeq}"> <input
																type="hidden" name="examVal${examCnt}_${gradeCnt}"
																value="${surveyExamCd.examVal}"> <input
																type="hidden" name="questExamCd${examCnt}" value="RADIO" />
															</li>
															<c:set var="gradeCnt" value="${gradeCnt+1}" />
														</c:if>
													</c:forEach>
												</ul>
											</c:when>
											<c:when test="${surveyQuest.examCd == 'MEAS10'}">
												<!-- 척도10 -->
												<ul>
													<c:set var="gradeCnt" value="0" />
													<c:forEach var="surveyExamCd" items="${SurveyExamCd}" varStatus="status">
														<c:if test="${surveyExamCd.ditcCd == 'MEAS10'}">
															<li><input type="radio" name="examSeq${examCnt}" id="examSeq${examCnt}"
																value="${surveyExamCd.examSeq}" maxlength="" /><label
																for="examSeq${examCnt}">${surveyExamCd.examNm}</label> <input
																type="hidden" name="questSeq${examCnt}"
																value="${surveyQuest.questSeq}"> <input
																type="hidden" name="examVal${examCnt}_${gradeCnt}"
																value="${surveyExamCd.examVal}"> <input
																type="hidden" name="questExamCd${examCnt}" value="RADIO" />
															</li>
															<c:set var="gradeCnt" value="${gradeCnt+1}" />
														</c:if>
													</c:forEach>
												</ul>
											</c:when>
											<c:when test="${surveyQuest.examCd == 'MEAS5'}">
												<!-- 척도5 -->
												<ul>
													<c:set var="gradeCnt" value="0" />
													<c:forEach var="surveyExamCd" items="${SurveyExamCd}" varStatus="status">
														<c:if test="${surveyExamCd.ditcCd == 'MEAS5'}">
															<li><input type="radio" name="examSeq${examCnt}" id="examSeq${examCnt}" value="${surveyExamCd.examSeq}" />
																<label for="examSeq${examCnt}">${surveyExamCd.examNm}</label>
																<input type="hidden" name="questSeq${examCnt}" value="${surveyQuest.questSeq}"> 
																<input type="hidden" name="examVal${examCnt}_${gradeCnt}" value="${surveyExamCd.examVal}"> 
																<input type="hidden" name="questExamCd${examCnt}" value="RADIO" />
															</li>
															<c:set var="gradeCnt" value="${gradeCnt+1}" />
														</c:if>
													</c:forEach>
												</ul>
											</c:when>
											<c:when test="${surveyQuest.examCd == 'TEXT'}">
												<!-- 200자 텍스트 -->
												<ul>
													<li><input type="text" name="examAns${examCnt}" maxlength="200" style="width: 100%;" /> 
													<input type="hidden" name="questSeq${examCnt}" value="${surveyQuest.questSeq}"> 
													<input type="hidden" name="examSeq${examCnt}" value="1" /> 
													<input type="hidden" name="questExamCd${examCnt}" value="TEXT" />
													<!-- 해당 타입으로 분기주기위해사용  --></li>
												</ul>
											</c:when>
											<c:when test="${surveyQuest.examCd == 'CLOB'}">
												<!-- 4000자 텍스트 -->
												<ul>
													<li><textarea name="examAns${examCnt}" maxlength="4000" style="width: 100%; height: 250px;" rows="15"></textarea> 
													<input type="hidden" name="questSeq${examCnt}" value="${surveyQuest.questSeq}">
													<input type="hidden" name="examSeq${examCnt}" value="1" />
													<input type="hidden" name="questExamCd${examCnt}" value="CLOB" /> <!-- 해당 타입으로 분기주기위해사용  --></li>
												</ul>
											</c:when>

										</c:choose></td>
								</tr>
							</table>

						</c:forEach>
						<div style="text-align: center; padding: 15px 0 0 0;">
							<!-- 						설문에 응해 주셔서 감사합니다. -->
							<!--  설문등록시 사용한다. -->
						</div>
						<div class="buttons" style="text-align: center;">
							<a href="#" class="btn02" style="float: left;" name="surveyInfoButtonBefore" title="이전">
							<img src="../../../img/icon_arrow3.gif" border="0"  /> 이전</a>
							${sessionScope.button.a_reg}<!--  관리자 설문미리보기에서는 등록버튼이 없다. 풀면사용가능 -->
							${sessionScope.button.a_close}
						</div>
					</div>
				</div>
			</form>
		</div>
	</div>



</body>
</html>