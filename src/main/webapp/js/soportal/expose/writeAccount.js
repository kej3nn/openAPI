/*
 * @(#)writeAccount.js 1.0 2019/07/22
 */

/**
 * 정보공개 > 청구서 작성 스크립트이다.
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
var userCd = $("#portalUserCd").val();
////////////////////////////////////////////////////////////////////////////////
// 초기화 함수
////////////////////////////////////////////////////////////////////////////////
/**
 * 컴포넌트를 초기화한다.
 */
function initComp() {
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
	
	//파일첨부 관련
	$("input[type=file]").change(function(){
		if($(this).val() != ""){
			//확장자 체크
			var ext = $(this).val().split(".").pop().toLowerCase();
			if($.inArray(ext, ["txt", "hwp", "doc", "docx", "xls", "xlsx", "ppt", "pptx", "pdf", "zip", "rar"]) == -1){
				alert("등록이 불가능한 파일입니다.\n\n파일을 다시 선택하시기 바랍니다.");
				$(this).val("");
				return;
			}
			//용량체크
			var fileSize = this.files[0].size;
			var maxSize = 30*1024*1000;
			if(fileSize > maxSize){
				alert("등록이 불가능한 파일입니다.\n\n파일을 다시 선택하시기 바랍니다.");
				$(this).val("");
				return;
			}
		}
	});
	
	$("input[name=aplSaveYn]").change(function(){
		if($(this).is(":checked")) {
			  if ( !confirm("청구인 기본정보를 저장하시겠습니까? ") ){
				  $(this).attr('checked', false);
				  return;
			  }else{
				  updateUserInfo();
			  }
		}
	});
	$("a[name=aplSave]").bind("click", function(e) {
		if ( com.wise.util.isBlank(userCd) ) { 
			alert("로그인 후 이용할 수 있습니다.");
			return false;
		}
		if (!confirm("청구인 기본정보를 저장하시겠습니까? "))return false;
		updateUserInfo();
	});
	
	//if($("input:checkbox[id='dcs_ntc_rcvmth_sms']").is(":checked") || $("input:checkbox[id='dcs_ntc_rcvmth_talk']").is(":checked")){
	
	$("#dcs_ntc_rcvmth_sms, #dcs_ntc_rcvmth_talk").bind("click", function(e) {
		if( $("input:checkbox[id='dcs_ntc_rcvmth_sms']").is(":checked") && $("input:checkbox[id='dcs_ntc_rcvmth_talk']").is(":checked") ) {
			alert("SMS와 카카오알림톡은 동시에 선택할 수 없습니다.");
			return false;
		}
	});
	
	$('.instInfo-open').click(function () {
	    var $layer = $('.instInfo-layer');
	    if($layer.hasClass("hidden")){
	    	 $layer.removeClass('hidden');
			 $layer.find("a").focus();	// 2022.12.20 - 웹접근성 처리
	    	 //$layer.find("div").focus();	// 2021.11.10 - 웹접근성 처리
	    }else{
	    	 $layer.addClass('hidden');
	    }
	});
	
	$("a[name=instInfoClose").bind("click", function(e) {
		var $layer = $('.instInfo-layer');
		$layer.addClass('hidden');
		$('.instInfo-open').focus();
	});
}

/**
 * 옵션을 로드한다.
 */
function loadOptions() {
	fn_pageLoad();
	
	fn_DefaultSelected('apl_mbl_pno1', 'p_apl_mbl_pno1');
	fn_DefaultSelected('apl_pno1', 'p_apl_pno1');
	fn_DefaultSelected('apl_fax_no1', 'p_apl_fax_no1');
	fn_DefaultSelected('email', 'p_email');
	//fn_DefaultSelected('dcs_ntc_rcvmth', 'p_dcs_ntc_rcvmth');
	
	fn_DefaultChecked('apl_instcd', 'p_instCd');
	fn_DefaultChecked2('opb_fom', 'p_opb_fom' , 3);
	fn_DefaultChecked2('apl_tak_mth', 'p_apl_tak_mth', 4);
	
	fn_feeRdtnChecked();
}

/**
 * 데이터를 로드한다.
 */
function loadData() {
	var apl_no = $("input[name=apl_no]").val();
	if(com.wise.util.isBlank(apl_no)) {
		if($("#portalUserCd").val() != "") selectUserInfo();
	}
}

/**
 * 유저정보 조회
 */
function selectUserInfo() {
    doSelect({
        url:"/portal/myPage/exposeDefaultUpdInfo.do",
        before:function(){return{};},
        after:afterSelectUserInfo
    });
}
/**
 * 후처리 함수
 * @param data
 */
function afterSelectUserInfo(data) {
	if(data != null){
		
		var userNm = data.userNm;
		var userHp = data.userHp;
		var userFaxTel = data.userFaxTel;
		var userTel = data.userTel;
		var userEmail = data.userEmail;
		var emailYn = data.emailYn;
		var hpYn = data.hpYn;
		var kakaoYn = data.kakaoYn;
		var userZip = data.userZip;
		var user1Addr = data.user1Addr;
		var user2Saddr = data.user2Saddr;
	
	
		//$("[name=userNm]").val(userNm);
		$("input[name=apl_zpno]").val(userZip);
		$("input[name=apl_addr1]").val(user1Addr);
		$("input[name=apl_addr2]").val(user2Saddr);
		
		if(!com.wise.util.isBlank(userHp)) {
			var telObj = ["apl_mbl_pno1","apl_mbl_pno2","apl_mbl_pno3"];
			var telArr = userHp.split('-');
			$.each(telArr, function(i, d) {
				$('#'+telObj[i]).val(d);
			});
		}
		
		if(!com.wise.util.isBlank(userTel)) {
			var telObj = ["apl_pno1","apl_pno2","apl_pno3"];
			var telArr = userTel.split('-');
			$.each(telArr, function(i, d) {
				$('#'+telObj[i]).val(d);
			});
		}
		
		if(!com.wise.util.isBlank(userFaxTel)) {
			var telObj = ["apl_fax_no1","apl_fax_no2","apl_fax_no3"];
			var telArr = userFaxTel.split('-');
			$.each(telArr, function(i, d) {
				$('#'+telObj[i]).val(d);
			});
		}
		
		if(!com.wise.util.isBlank(userEmail)) {
			var emailObj = ["apl_email1", "apl_email2", "email"];
			var emailArr = userEmail.split('@');
			$.each(emailArr, function(i, d) {
				$('#'+emailObj[i]).val(d);
			});
		}

		if(emailYn == 'Y') {
			$('#dcs_ntc_rcvmth_mail').attr('checked', true);
		}
		if(hpYn == 'Y') {
			$('#dcs_ntc_rcvmth_sms').attr('checked', true);
		}
		if(kakaoYn == 'Y') {
			$('#dcs_ntc_rcvmth_talk').attr('checked', true);
		}
	}
}

function updateUserInfo() {
	doUpdate({
		form:"form",
        url:"/portal/expose/updateExposeDefaultInfo.do",
        before:function(){return{};},
        after:afterUpdateUserInfo
	});
}

function afterUpdateUserInfo() {
	
}


////////////////////////////////////////////////////////////////////////////////
// 기존 JS 함수
////////////////////////////////////////////////////////////////////////////////

//공개형태, 수령방법 기타 선택시 텍스트입력
function fn_opbFomDiv(){
	var frm = document.form;
	if(frm.opb_fom[4].checked == true){
		opbFomDiv.style.display='block';
	}else{
		opbFomDiv.style.display='none';
	}
}
function fn_aplTakDiv(){
	var frm = document.form;
	if(frm.apl_tak_mth[4].checked == true){
		aplTakDiv.style.display='block';
	}else{
		aplTakDiv.style.display='none';
	}
}
//우편번호 팝업
function fn_zipcode(){
	var wname = "우편번호검색";

	var url = com.wise.help.url("/portal/expose/roadSearchAddrPage.do");
	var w = 500;
	var h = 720;
	var LP = (screen.width) ? (screen.width - w) / 2 : 100;
	var TP = (screen.height) ? (screen.height - h) / 3 : 100;
	var setting = "height=" + h + ", width=" + w + ", top=" + TP + ", left=" + LP;
 	window.open(url, wname, setting);
}

//등록, 수정
function fn_infoInsert(gb){
	var frm = document.form;
	if(!fn_valitionChk()) return;
	if(!fn_checkRadio('apl_instcd', '1')) return;
	if(fn_checkRadio('opb_fom', '2')){
		if(frm.opb_fom[4].checked == true && frm.opb_fom_etc.value.trim() == ''){
			alert('공개형태를 입력해주세요.');
			frm.opb_fom_etc.focus();
			return;
		}
	}else{
		return;
	}
	if(fn_checkRadio('apl_tak_mth', '3')){
		if(frm.apl_tak_mth[4].checked == true && frm.apl_takmth_etc.value.trim() == ''){
			alert('수령방법을 입력해주세요.');
			frm.apl_takmth_etc.focus();
			return;
		}
	}else{
		return;
	}
	if(fn_checkRadio('fee_rdtn_yn', '4')){
		if(frm.fee_rdtn_yn[0].checked == true && frm.fee_rdtn_rson.value.trim() == ''){
			alert('감면사유를 입력해주세요.');
			frm.fee_rdtn_rson.focus();
			return;
		}
	}else{
		return;
	}
	if(!fn_checkSelect()) return;
	var val = "";
	if(gb == 'I') val = '등록';
	else val = '수정';
	if(!confirm(val + ' 하시겠습니까?')){
		return;
	}
	if(frm.file.value.length > 0){
		frm.aplLength.value='1';
	}
	if(frm.file1.value.length > 0){
		frm.feeLength.value='2';
	}
	saveData();
}

/**
 * 데이터 등록/수정(파일처리)
 */
function saveData() {
	var formObj = $("form[name=form]");
	formObj.ajaxSubmit({
		url : com.wise.help.url("/portal/expose/insertAccount.do")
		, async : false
		, type : 'post'
		, dataType: 'json' 
		, contentType : 'application/x-www-form-urlencoded;charset=UTF-8'
		, beforeSubmit : function() {
			$("#loading").show();
		}	
		, success : function(res, status) {
			$("#loading").hide();
			if(res.data == "처리가 불가능한 청구서입니다."){
				alert("처리가 불가능한 청구서입니다.");
			}
			doAjaxMsg(res, "");
			location.href = com.wise.help.url("/portal/expose/searchAccountPage.do");
		}
		, error: function(jqXHR, textStatus, errorThrown) {
			alert("처리 도중 에러가 발생하였습니다.");
			$("#loading").hide();
		}
	});
}

//청구취하
function fn_infoCancle(val){
	var frm = document.uForm;
	if(!(confirm('청구취하를 하시겠습니까?'))){
		return;
	}
	frm.apl_cancle.value = val;
	cancelData();
}

/**
 * 데이터 청구취하
 */
function cancelData() {
	var formObj = $("form[name=uForm]");
	formObj.ajaxSubmit({
		url : com.wise.help.url("/portal/expose/withdrawAccount.do")
		, async : false
		, type : 'post'
		, dataType: 'json' 
		, contentType : 'application/x-www-form-urlencoded;charset=UTF-8'
		, beforeSubmit : function() {
		}	
		, success : function(res, status) {
			if(res.data == "처리가 불가능한 청구서입니다."){
				alert("처리가 불가능한 청구서입니다.");
			}
			doAjaxMsg(res, "");
			location.href = com.wise.help.url("/portal/expose/searchAccountPage.do");
		}
		, error: function(jqXHR, textStatus, errorThrown) {
			alert("처리 도중 에러가 발생하였습니다.");
		}
	});
}

function fn_checkRadio(name, rdoGb){
	var radioId = eval('document.form.'+name);
	var val = "";
	var cnt = 0;
	if(rdoGb == '1') val = "청구대상기관";
	else if(rdoGb == '2') val = "공개형태";
	else if(rdoGb == '3') val = "수령방법"; 
	else if(rdoGb == '4') val = "수수료 해당여부"; 
	for(var i=0;i<radioId.length;i++){
		if(radioId[i].checked == true) cnt++;
	}
	if(cnt <= 0){
		alert(val+'을(를) 선택 하세요.');
		return false;
	}else{
		if(rdoGb == '3'){
			var frm = document.form;
			if(radioId[3].checked == true){//이메일
				if(frm.apl_email1.value=='' || frm.apl_email2.value==''){
					alert('정보통신망주소를 입력해주세요.');
					return false;
				}else{
					return true;
				}
			}else if(radioId[2].checked == true){//팩스
				if(frm.apl_fax_no1.value=='000' || frm.apl_fax_no2.value=='' || frm.apl_fax_no3.value==''){
					alert('모사전송번호를 입력해주세요.');
					return false;
				}else{
					return true;
				}
			}else if(radioId[1].checked == true){//우편
				if(frm.apl_addr1.value=='' || frm.apl_addr2.value==''){
					alert('주소를 입력해주세요.');
					return false;
				}else{
					return true;
				}
			}else{
				return true;
			}
		}else{
			return true;
		}
	}
}
function fn_checkSelect(){
	var frm = document.form;
	if($("input:checkbox[id='dcs_ntc_rcvmth_sms']").is(":checked") || $("input:checkbox[id='dcs_ntc_rcvmth_talk']").is(":checked")){
		if(frm.apl_mbl_pno1.value=='000' || frm.apl_mbl_pno2.value=='' || frm.apl_mbl_pno3.value==''){
			alert('[결정통지 안내수신]에 필요합니다.\n\n휴대전화번호를 입력해주세요.');
			return false;
		}else{
			return true;
		}
	}
	
	if($("input:checkbox[id='dcs_ntc_rcvmth_mail']").is(":checked")){
		if(frm.apl_email1.value=='' || frm.apl_email2.value==''){
			alert('[결정통지 안내수신]에 필요합니다.\n\n정보통신망주소를 입력해주세요.');
			return false;
		}else{
			return true;
		}
	}
	
	return true;
}
//수수료 해당여부에 따른 디스플레이
function fn_feeRdtnDisplay(){
	var frm = document.form;
	if(frm.fee_rdtn_yn[0].checked == true){
		feeRdtnTr1.style.display = 'block';
	}else{
		feeRdtnTr1.style.display = 'none';
	}
}

function fn_feeRdtnChecked(){
	var frm = document.form;
	for(var i=0;i<frm.fee_rdtn_yn.length;i++){
		if(frm.fee_rdtn_yn[i].value == frm.p_fee_rdtn_yn.value){
			frm.fee_rdtn_yn[i].checked = true;
		}else{
			frm.fee_rdtn_yn[i].checked = false;
		}
	}
	if(frm.p_fee_rdtn_yn.value==''){
		frm.fee_rdtn_yn[1].checked = true;
	}
	fn_feeRdtnDisplay();
}
//page onload
function fn_pageLoad(){
	fn_opbFomDiv();
	fn_aplTakDiv();
	fn_feeRdtnDisplay();
	var obj1 = document.form.apl_dtscn_bfmod;
	var obj2 = document.form.fee_rdtn_rson;
	fn_textareaLengthChk(obj1, 'len1', 2000);
	fn_textareaLengthChk(obj2, 'len2', 100);
}
function fn_valitionChk(){
	var frm = document.form;

	if(frm.apl_pno1.value == '000' && frm.apl_mbl_pno1.value == '000'){
		alert('휴대전화번호, 전화번호중 하나는 필수 입력입니다.');
		return false;
	}
	if(frm.apl_mbl_pno1.value != '000' && frm.apl_mbl_pno2.value == ''){
		alert('휴대전화 앞자리를 입력하세요.');
		frm.apl_mbl_pno2.focus();
		return false;
	}
	if(frm.apl_mbl_pno1.value != '000' && frm.apl_mbl_pno3.value == ''){
		alert('휴대전화 뒷자리를 입력하세요.');
		frm.apl_mbl_pno3.focus();
		return false;
	}
	if((frm.apl_mbl_pno2.value.length > 0 && frm.apl_mbl_pno2.value.length < 3) || (frm.apl_mbl_pno3.value.length > 0 && frm.apl_mbl_pno3.value.length < 4)){
		alert('입력하신 휴대전화번호를 확인하세요.');
		return false;
	}
	if(frm.apl_pno1.value != '000' && (frm.apl_pno2.value == '' || frm.apl_pno3.value == '')){
		alert('전화번호를 입력하시거나 \n없음으로 선택하세요.');
		return false;
	}
	if((frm.apl_pno2.value.length > 0 && frm.apl_pno2.value.length < 3) || (frm.apl_pno3.value.length > 0 && frm.apl_pno3.value.length < 4)){
		alert('입력하신 전화번호를 확인하세요.');
		return false;
	}
	if(fn_getId('apl_zpno').value == '' && fn_getId('apl_addr1').value == ''){
		alert('우편번호찾기를 통해 주소를 입력하세요.');
		return false;
	}
	if(frm.apl_addr2.value == ''){
		alert('상세주소를 입력하세요.');
		frm.apl_addr2.focus();
		return false;
	}
	if(frm.apl_sj_bfmod.value == ''){
		alert('청구제목을 입력하세요.');
		frm.apl_sj_bfmod.focus();
		return false;
	}
	if(frm.apl_dtscn_bfmod.value == ''){
		alert('청구내용을 입력하세요.');
		frm.apl_dtscn_bfmod.focus();
		return false;
	}
	return true;
}

function fn_numReset(obj, num){
	var frm = document.form;
	if(num =='1'){
		if(obj.value=='000'){
			frm.apl_mbl_pno2.value="";
			frm.apl_mbl_pno3.value="";
			$("input[name=apl_mbl_pno2]").attr("readonly", true);
			$("input[name=apl_mbl_pno3]").attr("readonly", true);
		}else{
			$("input[name=apl_mbl_pno2]").attr("readonly", false);
			$("input[name=apl_mbl_pno3]").attr("readonly", false);
		}
	}else if(num =='2'){
		if(obj.value=='000'){
			frm.apl_pno2.value="";
			frm.apl_pno3.value="";
			$("input[name=apl_pno2]").attr("readonly", true);
			$("input[name=apl_pno3]").attr("readonly", true);
		}else{
			$("input[name=apl_pno2]").attr("readonly", false);
			$("input[name=apl_pno3]").attr("readonly", false);
		}
	}else if(num =='3'){
		if(obj.value=='000'){
			frm.apl_fax_no2.value="";
			frm.apl_fax_no3.value="";
			$("input[name=apl_fax_no2]").attr("readonly", true);
			$("input[name=apl_fax_no3]").attr("readonly", true);
		}else{
			$("input[name=apl_fax_no2]").attr("readonly", false);
			$("input[name=apl_fax_no3]").attr("readonly", false);
		}
	}
}

function fn_noSChar(id){
	if($("#"+id).val() != ""){
		var reStr = removeSpecialChar($("#"+id).val());
		$("#"+id).val(reStr);
	}
}
