/*
 * JavaScript 국회사무처 정보공개포털(공통)
 */

//document.getElementById(elementId)
function fn_getId(elementId){
	var obj = document.getElementById(elementId);
	return obj;
}

// document.getElementByName(elementName);
function fn_getName(elementName){
	var obj = document.getElementByName(elementName);
	return obj;
}

function fn_onlyNumberChk(obj){	
	if(fn_trim(obj.value).length != 0 && !fn_onlyNumeric(obj.value)){
		alert("숫자만 입력하세요.");
		obj.value = "";
		return;
	}
}

//trim() 공백제거
function fn_trim(str){
   str = str.replace(/(^\s*)|(\s*$)/g, "");
   return str;
}

function fn_onlyNumeric(str){
 var findStr = str.match(/[0-9]+/);
 if ( str == findStr ) return true;
 else return false;
}

function fn_DefaultSelected(id, value){
	var obj = fn_getId(id);
	var val = fn_getId(value);
	var len = obj.length;
	for(var i=0;i<len;i++){
		if(obj[i].value == val.value){
			obj[i].selected = true;
		}else{
			obj[i].selected = false;
		}
	}
}

function fn_DefaultChecked(name, value){
	var obj = eval('document.form.'+name);
	var val = fn_getId(value);
	var len = obj.length;
	for(var i=0;i<len;i++){
		if(obj[i].value == val.value){
			obj[i].checked = true;
		}else{
			obj[i].checked = false; 
		}
	}
	if(val.value==''){
		obj[0].checked = true;
	}
}

//20170427 고은정
//name   = form name
//value1 = 저장된값
//value2 = 디폴트로 설정할 값

function fn_DefaultChecked2(name, value1, value2){ 
	var obj  = eval('document.form.'+name);
	var val1 = fn_getId(value1);
	var val2 = value2;
	var len  = obj.length;

	if(val1.value==''){
		for(var i=0;i<len;i++){
			if(obj[i].value == val2){
				obj[i].checked = true;
			}else{
				obj[i].checked = false; 
			}
		}
	}else{
		for(var i=0;i<len;i++){
			if(obj[i].value == val1.value){
				obj[i].checked = true;
			}else{
				obj[i].checked = false; 
			}
		}
	}
	if(name == "opb_fom") fn_opbFomDiv();
	else if(name == "apl_tak_mth") fn_aplTakDiv();
}

//이메일 선택
function fn_selectEmail(obj){
	if(obj.value == '1'){
		document.form.apl_email2.readOnly = false;
	}else{
		document.form.apl_email2.value = obj.value;
		document.form.apl_email2.readOnly = true;
	}
}

//파일 다운로드
function fn_fileDown(fileGb){
	
	
	
	var frm = document.form;
	var dfrm = document.dForm;
	if(fileGb == '1'){
		dfrm.fileName.value = frm.apl_attch_flnm.value;
		dfrm.filePath.value = frm.apl_attch_flph.value;
	}else if(fileGb == '2'){
		dfrm.fileName.value = frm.fee_rdtn_attch_flnm.value;
		dfrm.filePath.value = frm.fee_rdtn_attch_flph.value;
	}else if(fileGb == '3'){
		dfrm.fileName.value = frm.objtn_apl_flnm.value;
		dfrm.filePath.value = frm.objtn_apl_flph.value;
	}
	dfrm.action = "/portal/expose/downloadOpnAplFile.do";
	dfrm.submit();
}

//국회사무처 정보공개청구 양식파일 다운로드
function fn_fileDownload(fileGb){
	var dfrm = document.dForm;
	if(fileGb == '1'){
		dfrm.fileName.value = "정보공개청구서(양식).hwp";
		dfrm.filePath.value = "open_apply.hwp";
	}else if(fileGb == '2'){
		dfrm.fileName.value = "이의신청서(양식).hwp";
		dfrm.filePath.value = "open_objtn.hwp";
	}else if(fileGb == '3'){
		dfrm.fileName.value = "수수료안내(양식).hwp";
		dfrm.filePath.value = "open_fee.hwp";
	}
	dfrm.action = "/portal/exposeInfo/downloadBasicFile.do";
	dfrm.submit();
}

//국회사무처 정보공개청구 유틸리티파일 다운로드
function fn_utilFileDownload(fileGb){
	var dfrm = document.dForm;
	if(fileGb == '1'){
		dfrm.fileName.value = "AdbeRdr1010_mui_Std.zip";
		dfrm.filePath.value = "AdbeRdr1010_mui_Std.zip";
	}else if(fileGb == '2'){
		dfrm.fileName.value = "e-timing for AdobeReader 9.exe";
		dfrm.filePath.value = "Adobe_Reader.exe";
	}else if(fileGb == '3'){
		dfrm.fileName.value = "vcredist_x86.exe";
		dfrm.filePath.value = "vcredist_x86.exe";
	}else if(fileGb == '4'){
		dfrm.fileName.value = "manual.pdf";
		dfrm.filePath.value = "Nasna.pdf";
	}
	dfrm.action = "/portal/exposeInfo/downloadBasicFile.do";
	dfrm.submit();
}

function fn_pathDelete1(id){
	var a = fn_getId(id);
	a.outerHTML = a.outerHTML
}

//Byte 체크
function fn_byteCheck(val, id){
	var frm = document.form;
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
	fn_getId(id).value = numberWithCommas(((cnt *2) + temp_str.length));
	return ((cnt *2) + temp_str.length);
}

function fn_textareaLengthChk(obj, id, len){
	rtn = fn_byteCheck(obj.value, id);
	if(rtn > len){
	  alert(numberWithCommas(len)+'byte 이상 초과 할 수 없습니다.');
	  for(var i=rtn; i > len; i--){
		  obj.value = fn_trim(obj.value).substring(0, obj.value.length-1);
		  if(fn_byteCheck(obj.value, id) <= len){
		  	break;
		  }
	  }
		rtn = fn_byteCheck(obj.value, id);
	  return;
	}
}

/**
 * 특수문자 제거
 * @param str
 * @returns
 */
function removeSpecialChar(str) { 
    var regExp = /[\{\}\[\]\/?,;:|\)*~`!^\-_+<>@\#$%&\\\=\(\'\"]/gi
     
    if(regExp.test(str)){
         
        //특수문자 제거
        str = str.replace(regExp, '');
    }
     
    return str;
}

/**
 * 숫자 천단위 콤마
 * @param str
 * @retruns
 */
function numberWithCommas(str) {
    return str.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}

