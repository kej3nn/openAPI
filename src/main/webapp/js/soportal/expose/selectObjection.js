/*
 * @(#)selectObjection.js 1.0 2019/07/22
 */

/**
 * 정보공개 > 이의신청처리현황 상세 작성 스크립트이다.
 *
 * @author SoftOn
 * @version 1.0 2018/04/19
 */
$(function() {
	
    // 컴포넌트를 초기화한다.
    initComp();
    
    // 마스크를 바인딩한다.
    bindMask();
    
    // 이벤트를 바인딩한다.
    bindEvent();
    
    // 옵션을 로드한다.
    loadOptions();
    
    // 데이터를 로드한다.
    loadData();
});

////////////////////////////////////////////////////////////////////////////////
// 글로벌 변수
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// 초기화 함수
////////////////////////////////////////////////////////////////////////////////
/**
 * 컴포넌트를 초기화한다.
 */
function initComp() {
	//fn_feeRdtnDisplay();
}

/**
 * 마스크를 바인딩한다.
 */
function bindMask() {
    
}

/**
 * 이벤트를 바인딩한다.
 */
function bindEvent() {

}

/**
 * 옵션을 로드한다.
 */
function loadOptions() {

}

/**
 * 데이터를 로드한다.
 */
function loadData() {
    // Nothing to do.
}

////////////////////////////////////////////////////////////////////////////////
// 서비스 함수
////////////////////////////////////////////////////////////////////////////////
/**
 * 사용자를 등록한다.
 */
function insertUser() {
    doInsert({
        url:"/portal/user/insertUser.do",   
        form:"frm",
        before:beforeInsertUser,
        after:afterInsertUser
    });
}

////////////////////////////////////////////////////////////////////////////////
// 전처리 함수
////////////////////////////////////////////////////////////////////////////////
/**
 * 사용자 등록 전처리를 실행한다.
 * 
 * @param options {Object} 옵션
 * @returns {Object} 데이터
 */
function beforeInsertUser(options) {
    var form = $("#frm");
    
    if (com.wise.util.isBlank(form.find("[name=userId]").val())) {
        alert("사용자 아이디가 없습니다.");
        return false;
    }
    
    if ( form.find("#dupYn").val() == "N" ) {
    	alert("ID 중복체크를 하십시오.");
    	return false;
    }
    
    if ( com.wise.util.isBlank(form.find("[name=userPw]").val()) ) {
    	alert("비밀번호를 입력하여 주십시오.");
    	return false;
    }
    
    //if ( !chkUserPw(form.find("[name=userPw]").val()) ) return false;
    
    if ( com.wise.util.isBlank(form.find("[name=userPw2]").val()) ) {
    	alert("비밀번호 재확인을 입력하여 주십시오.");
    	return false;
    }
    
    if ( form.find("[name=userPw]").val() != form.find("[name=userPw2]").val() ) {
    	alert("비밀번호와 재확인 비밀번호가 서로 다릅니다.");
    	return false;
    }
    
    if (com.wise.util.isBlank(form.find("[name=userNm]").val())) {
        alert("닉네임을 입력하여 주십시오.");
        form.find("[name=userNm]").focus();
        return false;
    }

    if (!com.wise.util.isLength(form.find("[name=userNm]").val(), 1, 20)) {
        alert("닉네임을 20자 이내로 입력하여 주십시오.");
        form.find("[name=userNm]").focus();
        return false;
    }
    
    if (com.wise.util.isBlank(form.find("[name=memberCd]").val())) {
    	alert("질문을 선택하여 주십시오.");
		form.find("[name=memberCd]").focus();
		return false;
	}
    
    if (com.wise.util.isBlank(form.find("[name=memberVal]").val())) {
    	alert("질문 답변을 입력하여 주십시오.");
		form.find("[name=memberVal]").focus();
		return false;
	}
    
    var agree = form.find("input:radio[name=agree]:checked").val();
    if ( agree == undefined || agree == "N" ) {
        alert("이용약관에 동의하여 주십시오.");
        form.find("[id=agree]").focus();
        return false;
    }

    if ( !confirm("회원가입 하시겠습니까?") )	return false;
    
    return true;
}

////////////////////////////////////////////////////////////////////////////////
// 후처리 함수
////////////////////////////////////////////////////////////////////////////////
/**
 * 사용자 등록 후처리를 실행한다.
 * 
 * @param messages {Object} 메시지
 */
function afterInsertUser(messages) {
	var form = $("#global-request-form");
    var actionUrl = form.attr("action");
        
    if(actionUrl == "/") form.attr("action", "/data/");
    else  form.attr("action", "/data/"+actionUrl);
    
    $("#global-request-form").submit();
}

////////////////////////////////////////////////////////////////////////////////
// 기존 JS 함수
////////////////////////////////////////////////////////////////////////////////
function fn_DocStat() {
	var docStat = document.objtnForm.objtn_stat_cd.value;
	if(docStat == '99') {
		alert("취하된 이의신청건 입니다.");
	}
}

function fn_goAction(jobs, apl_no, sno, print) {
	var frm = document.objtnForm;
	var target;
	var action;

	if(jobs == 'M') {				// 이의 신청 수정
		if(frm.objtn_stat_cd.value == '01'){
			if(!confirm("이의신청서를 수정하시겠습니까?")) {return;}
			action = "/portal/expose/updateObjectionPage.do";
			target = "_self";
		} else {
			alert("이의신청서 수정은 접수중 일때만 가능합니다.");
			return;
		}
	} else if(jobs == 'C') {		// 이의 취하
		if(frm.objtn_stat_cd.value == '99') {
			alert("이미 취하된 청구건 입니다.");
			return;
		} else if(frm.objtn_stat_cd.value == '03' || frm.objtn_stat_cd.value == '') {
			alert("처리가 완료된 신청건 입니다.");
			return;
		} else {
			if(!confirm("이의취하를 하면 해당 이의신청 대상의 이의신청이 불가합니다.\n\n이의신청을 취하 하시겠습니까?")) {return;}
			cancelData();
		}
	} else {						// 목록으로 이동
		action = "/portal/expose/searchObjectionPage.do";
		target = "_self";
	}
	if(jobs != 'C'){
		frm.target = target;
		frm.action = action;
		frm.submit();
	}
}

/**
 * 이의신청 취소
 */
function cancelData() {
	var formObj = $("form[name=objtnForm]");
	formObj.ajaxSubmit({
		url : com.wise.help.url("/portal/expose/withdrawObjection.do")
		, async : false
		, type : 'post'
		, dataType: 'json' 
		, contentType : 'application/x-www-form-urlencoded;charset=UTF-8'
		, beforeSubmit : function() {
		}	
		, success : function(res, status) {
			doAjaxMsg(res, "/portal/expose/searchObjectionPage.do");
		}
		, error: function(jqXHR, textStatus, errorThrown) {
			alert("처리 도중 에러가 발생하였습니다.");
		}
	});
}

// 파일 다운로드
function fn_objFileDownload(str){
	
	var f=document.downloadForm;

	if(str == 'objtn_apl_flnm'){
		f.fileName.value = document.objtnForm.objtn_apl_flnm.value;
		f.filePath.value = document.objtnForm.objtn_apl_flph.value;
	}else if(str == 'attch_fl_nm'){
		f.fileName.value = document.objtnForm.attch_fl_nm.value;
		f.filePath.value = document.objtnForm.attch_fl_ph_nm.value;		
		
	}else if(str == 'fee_attch_fl_nm'){
			f.fileName.value = document.objtnForm.fee_attch_fl_nm.value;
			f.filePath.value = document.objtnForm.fee_attch_fl_ph.value;		
	}else if(str == 'opb_fl_nm1'){
		f.fileName.value = document.objtnForm.opb_fl_nm1.value;
		f.filePath.value = document.objtnForm.opb_fl_ph1.value;			
	}else if(str == 'opb_fl_nm2'){
		f.fileName.value = document.objtnForm.opb_fl_nm2.value;
		f.filePath.value = document.objtnForm.opb_fl_ph2.value;			
	}else if(str == 'opb_fl_nm3'){
		f.fileName.value = document.objtnForm.opb_fl_nm3.value;
		f.filePath.value = document.objtnForm.opb_fl_ph3.value;			
	}	
	
	f.action = "/portal/expose/downloadOpnAplFile.do";
	f.submit();
}

function fn_print(target, cVersion) {
	
	var frm = document.objtnForm;
	var form = document.printForm;
	var objtnSno = frm.objtnSno.value;
	
	form.mrdParam.value = "/rp [" + frm.apl_no.value + "] [" + frm.objtnSno.value + "]";
	
	form.width.value = "680";
	form.height.value = "700";
	
	if(target == 'objtn') {
		window.open('', 'popup', 'width=680, height=700, resizable=yes, location=no;');
		form.title.value = "정보공개 이의신청서 출력";
		
		if(cVersion == 'V1'){	//2단계 개선사업 이전일 경우 이전 통지서를 호출한다.
			form.action = "/portal/expose/reportingPage/printObjtn.do";
		}else{	//2단계 개선사업 이후일 경우 신규 통지서를 호출한다.
			/* 이의신청의 취지 및 이유 확인 로직 추가 > 이의신청서의 이의신청의 취지 및 이유에 맞지 않을 경우(초과) 별지참조 처리*/
			var tArea = frm.printObjtnRson.value; //이의신청의 취지 및 이유 - 출력용
			var totLine = chkTotLine(tArea);
			if(totLine > 10){ //이의신청서의 이의신청의 취지 및 이유 최대 10줄
				form.action = "/portal/expose/reportingPage/printNewObjtnPtsRefer.do"; 	// 이의신청서 출력(별지 참조)
			}else{
				form.action = "/portal/expose/reportingPage/printNewObjtnPts.do"; 	// 이의신청서 출력
			}
		}
	} else if(target == 'objtnExt') {
		window.open('', 'popup', 'width=680, height=700, resizable=yes, location=no;');
		form.title.value ="정보공개 이의신청 연장통지서 출력";
		if(cVersion == 'V1'){	//2단계 개선사업 이전일 경우 이전 통지서를 호출한다.
			form.action = "/portal/expose/reportingPage/printObjtnExt.do";
		}else{	//2단계 개선사업 이후일 경우 신규 통지서를 호출한다.
			form.action = "/portal/expose/reportingPage/printNewObjtnExt.do"; 	// 이의신청 연장통지서 출력
		}
	}else if(target == 'objtnDcs') {
		window.open('', 'popup', 'width=680, height=700, resizable=yes, location=no;');
		form.title.value ="정보공개 이의신청 결정통지서 출력";
		if(cVersion == 'V1'){	//2단계 개선사업 이전일 경우 이전 통지서를 호출한다.
			form.action = "/portal/expose/reportingPage/printObjtnDcs.do";
		}else{	//2단계 개선사업 이후일 경우 신규 통지서를 호출한다.
			form.action = "/portal/expose/reportingPage/printNewObjtnDcs.do"; 	// 이의신청 결정통지서 출력
		}
	}
	
	form.target = "popup";
	form.submit();		
}

function fn_go_opnApl() {
	var frm = document.objtnForm;
	frm.apl_no.value = frm.aplNo.value;
	
	frm.action = "/portal/expose/selectAccountPage.do";
	frm.target = "_self";
	frm.submit();
} 

/**
 * 내용의 줄수 확인(RD 출력 확인)
 * @param str
 * @retruns
 */
function chkTotLine(tArea){
	var tAreaLine = tArea.split("\n");
	var totLine = 0;
	for(var li=0; li<tAreaLine.length; li++){
		var liData = tAreaLine[li];
		var dataLength = liData.length;
		if(liData.length> 50){
			var arrChkData = tAreaLine[li].match(new RegExp('.{1,50}', 'g'));
			totLine += arrChkData.length;
		}else{
			totLine++;
		}
	}
	return totLine;
}
