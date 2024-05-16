/* ================================================================== 
 * @FileName  : adminBodMng.js
 * @FileTitle : Jquery Validate 공통
 * @ModifyDate  2020.11.20
 * @Version     1.0
 * @Modifier    jhKim
 * @ChangeNote  최초작성
 * =================================================================*/
function commonValidator(targetForm, ignore, rules, messages, submitFunction, groups) {
    targetForm.validate({
        debug: false,   						// debug가 true인 경우 validation 후 submit을 수행하지 않음
        onfocusout: false,  					// onblur 시 해당항목을 validation 할 것인지 여부 (default: true)
        ignore: ignore || "*:not([name])",    	// name을 부여하지 않은 tag ignore Ex) '*:not([name])'
        ignoreTitle: true,						// element에 title 속성으로 메세지가 표시를 막는다.
        rules: rules,
        messages: messages,
        groups: groups,
        errorPlacement: function (error, element) {
            /* validator는 기본적으로 validation 실패 시 실패한 노드 우측에 실패 메시지를 표시하게 되어있다.
             	작동을 원하지 않으면 내용이 없는 errorPlacement를 선언한다. */
        	element.parent().children().last().after(error);
        },
        invalidHandler: function (form, validator) {
            /*  validation 실패 시의 핸들러를 정의한다.실패 시 메시지를 alert으로 표시하도록 되어 있다. */
            var errors = validator.numberOfInvalids();
            if (errors) {
//                alert(validator.errorList[0].message);
                validator.errorList[0].element.focus();
            }
        },
        submitHandler: submitFunction
        /*
         유효성 검사가 완료된 뒤 수행할 핸들러를 정의한다.
         주의 할 점은 이 옵션을 명시할 경우 'submit' 이벤트만 발생하며 실제 FORM 전송은 일어나지 않는다는 것이다.
         만약 submitHandler를 명시하지 않으면 유효성 검사 후 온전한 submit을 수행한다.
         */
    });
 
	//**********************************************************************************
	//Jquery Validate Custom Method Define - Common start
	//**********************************************************************************
	 
	//number 여부 체크값 return
	function isNumber(str) {
	    var n = Math.floor(Number(str));
	    return String(n) == str && n >= 0;
	}
	 
	//number 제외하고 입력 못함
	function InpuOnlyNumber(obj) {
	    if (event.keyCode >= 48 && event.keyCode <= 57) { //숫자키만 입력
	        return true;
	    } else {
	        event.returnValue = false;
	    }
	}
	 
	/*바이트 체크 함수*/
	function getByteB(str) {
	    var byte = 0;
	    for (var i = 0; i < str.length; ++i) {
	        // 기본 한글 3바이트 처리 ( UTF-8 )
	        (str.charCodeAt(i) > 127) ? byte += 3 : byte++;
	    }
	    return byte;
	}
	 
	/*input 바이트 길이 체크 (type=file) 가능 */
	$.validator.addMethod("maxLengthByte", function (str, element, param) {
	    var byte = 0, result = true;
	    if (str) {
	        byte +=  getByteB(str);
	        if (byte > param) {
	            result = false;
	        }
	    }
	    return this.optional(element) || result;
	});
	 
	/*input 파일사이즈 체크*/
	$.validator.addMethod('fileSize', function (value, element, param) {
	    return this.optional(element) || (element.files[0].size <= ( param * 1000000 ) )
	});
	 
	// 날짜 비교
	$.validator.addMethod("dateChk", function (value, element, param) {
		var result = new Date(value) > new Date($(param).val()) ? false : true;
	    return result;
	 
	});
	
	// 영어와 숫자인지 확인
	$.validator.addMethod("allowAlphaNum", function (str, element, param) {
		return new RegExp("^[0-9a-zA-Z]+$", "").test(str);
	});
	
	// 소문자 영어와 숫자인지 확인
	$.validator.addMethod("allowLowerAlphaNum", function (str, element, param) {
		return new RegExp("^[0-9a-z]+$", "").test(str);
	});
	
	// 대문자 영어와 숫자인지 확인
	$.validator.addMethod("allowUpperAlphaNum", function (str, element, param) {
		return new RegExp("^[0-9A-Z]+$", "").test(str);
	});
	
	// 패스워드 규칙 확인
	$.validator.addMethod("pwdChck", function (str, element, param) {
		var c1 = /^(?=.*[a-zA-Z])(?=.*[0-9])/.test(str);   			// 영문,숫자
		var c2 = /^(?=.*[a-zA-Z])(?=.*[^a-zA-Z0-9])/.test(str);  	// 영문,특수문자
		var c3 = /^(?=.*[^a-zA-Z0-9])(?=.*[0-9])/.test(str);  		// 특수문자, 숫자
		return (c1 || c2 || c3);
	});
	
	// 체크박스 다른 이름 무조건 하나
	$.validator.addMethod("leastOneChck", function (value, element, param) {
		return $('input[type=checkbox]:checked').length > 0;
	}, "응답자 정보(을)를 최소 1개이상 선택해 주십시오.");
	
	// 다른값인지 체크
	$.validator.addMethod("notEqualsTo", function(value, element, param){
	    return this.optional(element) || value != param;
	}, "다른값으로 입력 및 선택해 주십시오.");
 
    //**********************************************************************************
    //Jquery Validate Custom Method Define - Common end
    //**********************************************************************************
}