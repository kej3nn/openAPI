/**
 * 금액일 경우 자동으로 콤마 표시
 * 예)onkeydown="ComInputMoney(this.id)"
 * @param objNm
 */
function ComInputMoney(objNm) {
	$("#" + objNm).attr('style', 'ime-mode:disabled');
	$("#" + objNm).keyup(function() {
		$(this).toPrice();
		var strText = $(this).getOnlyNumeric();
		$(this).val(strText);
	});
}

/**
 * 숫자만 입력(id)
 * 예)onkeydown="ComInputNum(this.id)"
 * @param objNm
 */
function ComInputNum(objNm) {
	$("#" + objNm).attr('style', 'ime-mode:disabled');
	$("#" + objNm).keyup(function() {
		$(this).toNum();
		var strText = $(this).getOnlyNumeric();
		$(this).val(strText);
	});
}

/**
 * 숫자만 입력(name)
 * 예)onkeydown="ComNmInputNum(this.name)"
 * @param objNm
 */
function ComNmInputNum(objNm) {
	$('input[name="'+objNm+'"]').attr('style', 'ime-mode:disabled; text-align:right;');
	$('input[name="'+objNm+'"]').keyup(function() {
		$(this).toNum();
		var strText = $(this).getOnlyNumeric();
		$(this).val(strText);
	});
}

/**
 * 숫자만 입력(obj)+max값 설정
 * 예)onkeydown="ComNmInputMaxNum(this, 100)"
 * @param obj, maxNum
 */
var before;
function ComNmInputMaxNum(obj, maxNum) {
	$(obj).attr('style', 'ime-mode:disabled; text-align:right;');
	before = $(obj).val();
	
	$(obj).keyup(function() {
		var strb, minus;
		minus = '';
		strb = $(this).val().toString();
		if (strb.charAt(0) == '-')
			minus = strb.charAt(0);
		strb = strb.replace(/-,/g, '');
		strb = parseInt(strb, 10);
		
		if(strb > maxNum){
			alert(maxNum + '보다 작은수를 입력하세요.');
			return $(this).val(minus + before);
		}
		if (isNaN(strb)) {
			return $(this).val(minus + '');
		}else{
			return $(this).val(minus + strb);
		}
	});
		
}

/**
 * 영어만 입력
 * 예)onkeydown="ComInputEng(this.id)"
 * @param objNm
 */
function ComInputEng(objNm) {
	$("#" + objNm).attr('style', 'ime-mode:disabled');
	$("#" + objNm).keyup(function() {
		$(this).toEng();
	});
}

/**
 * 영어,숫자만 입력
 * 예)onkeydown="ComInputMoney(this.id)"
 * @param objNm
 */
function ComInputEngNum(objNm) {
	$("#" + objNm).attr('style', 'ime-mode:disabled');
	$("#" + objNm).keyup(function() {
		$(this).toEngNum();
	});
}

/**
 * string에 콤마 넘음
 * 
 * @param expression
 */
function InsertComma(n) {
	if(n == 0) return n;
	if (null == n || "" == n) return;

	var reg = /(^[+-]?\d+)(\d{3})/; // 정규식
	n += ''; // 숫자를 문자열로 변환
	while (reg.test(n))
		n = n.replace(reg, '$1' + ',' + '$2');
	return n;
}

/**
 * string에 콤마 삭제
 * 
 * @param expression
 */
function DeleteComma(str) {

	if (null == str || "" == str)
		return;

	var comm_str = str;
	var uncomm_str = "";
	if (str == null || str == "") {
		return 0;
	}
	for ( var j = 0; j < comm_str.length; j++) {
		var substr = comm_str.substring(j, j + 1);
		if (substr != ",")
			uncomm_str += substr;
	}

	return uncomm_str;
}


/**
 * 시작일이 종료일보다 더 느린지 검사
 * @param fromDt
 * @param toDt
 * @returns {String}
 */
function validateDate(fromDt, toDt){
	var label = $("label");
	var day = getDateDiff(fromDt, toDt);
	var fromNm = '';
	var toNm = '';
	label.each(function() { 
		
    	if($('#'+fromDt).attr("id") == $(this).attr("for")){
    		fromNm = $(this).html();
    	}else if($('#'+toDt).attr("id") == $(this).attr("for")){
    		toNm = $(this).html();
    	}
	});
	var str = '';
	if(day < 0){
		str = fromNm+'은(는) '+toNm+'과 같거나 이후로 지정하셔야 합니다.';
	}
	return str;
}

function checkIEVersion()
{
   var msg = "You're not using Windows Internet Explorer.";
   var ver = getInternetExplorerVersion();
   var m_ver="";
   if ( ver> -1 )
   {
	 if ( ver> 9.0 ){
	      msg = "You're using Windows Internet Explorer 10.";
	      m_ver="10"; 
	 }
	 else if ( ver== 9.0 ){
          msg = "You're using Windows Internet Explorer 9.";
          m_ver="9";
     }else if ( ver== 8.0 ){
         msg = "You're using Windows Internet Explorer 8.";
         m_ver="8";
     }else if ( ver == 7.0 ){
    	 m_ver="7";
    	  msg = "You're using Windows Internet Explorer 7.";
     }else if ( ver == 6.0 ){
    	  msg = "You're using Windows Internet Explorer 6.";
	 }else{
    	  msg = "You should upgrade your copy of Windows Internet Explorer";
	 }
    }   
   //alert(ver+"||"+ msg+"||"+m_ver );
   return  m_ver; 
}


/**
 * 영어 숫자 입력
 * 예)onkeydown="ComInputEng(this)"
 * @param objNm
 */
function ComInputEngNumObj(obj) {
	obj.css("ime-mode","disabled");
	strb = obj.val().toString(); 
	strb = strb.replace(/[^a-zA-Z0-9]/g, 'ㄱ');
	if(/ㄱ/i.test(strb)){
		alert("영어와 숫자만 입력가능합니다."); 
		strb = strb.replace(/[^a-zA-Z0-9]/g, ''); 
		obj.val(strb);  
	}
//	obj.toEngNum();
}                
                                
/**
 * 영어만 입력
 * 예)onkeydown="ComInputEng(this)"
 * @param objNm
 */
function ComInputEngObj(obj) {
	obj.css("ime-mode","disabled");
	strb = obj.val().toString(); 
	strb = strb.replace(/[^a-zA-Z]/g, 'ㄱ');
	if(/ㄱ/i.test(strb)){
		alert("영어만 입력가능합니다."); 
		strb = strb.replace(/[^a-zA-Z]/g, ''); 
		obj.val(strb);  
	}
//	obj.toEng();
}

/**
 * 숫자만 입력   
 * 예)onkeydown="ComInputNum(this)"
 * @param objNm
 */
function ComInputNumObj(obj) {
	obj.css("ime-mode","disabled");
	strb = obj.val().toString();
	strb = strb.replace(/[^0-9]/g, 'ㄱ');
	if(/ㄱ/i.test(strb)){
		alert("숫자만 입력가능합니다."); 
		strb = strb.replace(/[^0-9]/g, ''); 
		obj.val(strb);  
	} 
}

/**
 * 숫자와 소수점 입력
 * 예)onkeydown="ComInputNum(this)"
 * @param objNm
 */
function ComInputNumDcmObj(obj) {
	obj.css("ime-mode","disabled");
	strb = obj.val().toString();
	strb = strb.replace(/[^0-9.]/g, 'ㄱ');
	if(/ㄱ/i.test(strb)){
		alert("숫자와 소수점만 입력가능합니다."); 
		strb = strb.replace(/[^0-9.]/g, ''); 
		obj.val(strb);  
	} 
//	ob.jval(strb);
}

/**
 * 숫자와 - 입력
 * 예)onkeydown="ComInputNum(this)"
 * @param objNm
 */
function ComInputNumDecObj(obj) {
	obj.css("ime-mode","disabled");
	strb = obj.val().toString();
	strb = strb.replace(/[^0-9-]/g, 'ㄱ');   
	if(/ㄱ/i.test(strb)){
		alert("숫자와 -만 입력가능합니다."); 
		strb = strb.replace(/[^0-9-]/g, ''); 
		obj.val(strb);  
	} 
//	obj.val(strb);                
} 

/**
 * 영문와 소수점 입력
 * 예)onkeydown="ComInputNum(this)"
 * @param objNm
 */
function ComInputEngDcmObj(obj) {
	obj.css("ime-mode","disabled");
	strb = obj.val().toString();
	strb = strb.replace(/[^a-zA-Z.]/g, 'ㄱ');
	if(/ㄱ/i.test(strb)){
		alert("영문과 소수점만 입력가능합니다."); 
		strb = strb.replace(/[^a-zA-Z.]/g, ''); 
		obj.val(strb);  
	} 
//	obj.val(strb);
}


/**
 * 영문와 소수점 '/',':'  입력
 * 예)onkeydown="ComInputNum(this)"
 * @param objNm
 */
function ComInputEngUrlObj(obj) {
	obj.css("ime-mode","disabled");
	strb = obj.val().toString();
	strb = strb.replace(/[^a-zA-Z/.:]/g, 'ㄱ');
	if(/ㄱ/i.test(strb)){
		alert("영문과 소수점 / : 만 입력가능합니다."); 
		strb = strb.replace(/[^a-zA-Z/.:]/g, ''); 
		obj.val(strb);  
	} 
//	obj.val(strb);
}

/**
 * 영문와 공백 입력
 * 예)onkeydown="ComInputNum(this)"
 * @param objNm
 */
function ComInputEngBlankObj(obj) {
	obj.css("ime-mode","disabled");
	strb = obj.val().toString();
	strb = strb.replace(/[^a-zA-Z ]/g, 'ㄱ');
	if(/ㄱ/i.test(strb)){
		alert("영어만 입력가능합니다."); 
		strb = strb.replace(/[^a-zA-Z ]/g, '');
		obj.val(strb);
	}
}

/**
 * 영문과 공백과 comma(,) 입력
 * 예)onkeydown="ComInputNum(this)"
 * @param obj
 */
function ComInputEngBlankComObj(obj) {
	obj.css("ime-mode","disabled");
	strb = obj.val().toString();
	strb = strb.replace(/[^a-zA-Z ,]/g, 'ㄱ');
	if(/ㄱ/i.test(strb)){
		alert("영어와 , 만 입력가능합니다."); 
		strb = strb.replace(/[^a-zA-Z ,]/g, ''); 
		obj.val(strb);  
	}
}

/**
 * 영문과 공백과 숫자 입력
 * 예)onkeydown="ComInputNum(this)"
 * @param obj
 */
function ComInputEngBlankNumObj(obj) {
	obj.css("ime-mode","disabled");
	strb = obj.val().toString();
	strb = strb.replace(/[^a-zA-Z 0-9]/g, 'ㄱ');
	if(/ㄱ/i.test(strb)){
		alert("영어와 공백과 숫자만 입력가능합니다."); 
		strb = strb.replace(/[^a-zA-Z 0-9]/g, ''); 
		obj.val(strb);  
	}
}

/**
 * 영문과 공백과 숫자 - _ 입력
 * @param obj
 */
function ComInputEngBlankNumBarObj(obj) {
	obj.css("ime-mode","disabled");
	strb = obj.val().toString();
	strb = strb.replace(/[^a-zA-Z 0-9_-]/g, 'ㄱ');
	if(/ㄱ/i.test(strb)){
		alert("영어와 공백과 숫자 _ - 만 입력가능합니다."); 
		strb = strb.replace(/[^a-zA-Z 0-9_-]/g, ''); 
		obj.val(strb);  
	}
}

/**
 * 한글 입력 (한)사용 한글,영어,숫자, 컴마, 점,(),/ , - , _ 사용가능
 * 예)onkeydown="ComInputKorObj(this)" 
 */
function ComInputKorObj(obj) { 
	obj.css("ime-mode","active");
	strb = obj.val().toString();
	strb = strb.replace(/[^ㄱ-ㅎ가-힣a-zA-Z 0-9,.()/_-]/g, '@');
	if(/@/i.test(strb)){
		alert("한글, 영어, 숫자, 컴마, 점,(), /, _ , - 만 입력가능합니다."); 
		strb = strb.replace(/[^ㄱ-ㅎ가-힣a-zA-Z 0-9,.()/_-]/g, '');  
		obj.val(strb);
	}
}

/**
 * 한글 입력 (한)사용 한글,영어,숫자 사용가능
 * 예)onkeydown="ComInputKorObj(this)" 
 */
function ComInputKorNumObj(obj) { 
	obj.css("ime-mode","active");
	strb = obj.val().toString();
	strb = strb.replace(/[^ㄱ-ㅎ가-힣a-zA-Z0-9]/g, '@');
	if(/@/i.test(strb)){
		alert("한글, 영어, 숫자만 입력가능합니다."); 
		strb = strb.replace(/[^ㄱ-ㅎ가-힣a-zA-Z0-9]/g, '');  
		obj.val(strb);
	}
}

function ComInputEngEtcObj(obj) { 
	obj.css("ime-mode","active");
	strb = obj.val().toString();
	strb = strb.replace(/[^a-zA-Z 0-9,.()/_-]/g, '@');
	if(/@/i.test(strb)){
		alert("영어, 숫자, 컴마, 점,(), /, _ , - 만 입력가능합니다."); 
		strb = strb.replace(/[^a-zA-Z 0-9,.()/_-]/g, '');  
		obj.val(strb);
	}
}

function ComInputEngEtcObj2(obj) { 
	obj.css("ime-mode","active");
	strb = obj.val().toString();
	strb = strb.replace(/[ㄱ-ㅎ가-힣]/g, '¿'); 
	if(/¿/i.test(strb)){
		alert("한글은 입력할 수 없습니다."); 
		strb = strb.replace(/[¿]/g, '');  
		obj.val(strb);
	}
}



/**
 * 한글, 영문만 입력
 * 예)onkeydown="ComInputKorEngObj(this)" 
 */
function ComInputKorEngObj(obj) { 
	obj.css("ime-mode","active");     
	strb = obj.val().toString();
	strb = strb.replace(/[^ㄱ-ㅎ가-힣a-zA-Z]/g, '@');
	if(/@/i.test(strb)){  
		alert("한글과 영문만 입력가능합니다."); 
		strb = strb.replace(/[^ㄱ-ㅎ가-힣a-zA-Z]/g, '');  
		obj.val(strb);
	}
	
//	if(jQuery.browser.msie){
//		obj.keypress(function() {                  
//			strb = obj.val().toString();
//			strb = strb.replace(/[^ㄱ-ㅎ가-힣a-zA-Z]/g, '');  
//			$(this).val(strb);
//		});
//	}else{
//		obj.keyup(function() {                  
//			strb = obj.val().toString();
//			strb = strb.replace(/[^ㄱ-ㅎ가-힣a-zA-Z]/g, '');  
//			$(this).val(strb);
//	});
//	}
}
   
/**
 * 공통으로 적용되는 함수 - 필수부분   
 * document object 에서 enter 시 id 의 클릭이 실행됨
 * 주로 조회시 검색어 입력 후 엔터치면 자동조회가 되는 데 사용됨
 * document_enter(search);
 */
function document_enter(eventid) {
	$(':input').keypress(function(e){
		if (e.which == 13) {
			$('#'+eventid).click();
		};
	});   
};

/**
 * 숫자와 소수점 입력
 * 예)onkeydown="ComInputNum(this)"
 * @param objNm
 */
function ComInputEmailObj(obj) {
	obj.css("ime-mode","disabled");
	strb = obj.val().toString();  
	strb = strb.replace(/[^a-zA-Z0-9.\-_]/g, 'ㄱ');
	if(/ㄱ/i.test(strb)){  
		alert("숫자와 소수점과 -, _만 입력가능합니다."); 
		strb = strb.replace(/[^a-zA-Z0-9.\-_]/g, '');  
		obj.val(strb);
	}
//	obj.val(strb);
}


function addCommas(num){
	return num.toString().replace(/\B(?=(\d{3})+(?!\d))/g,',');
}


function addMul(val,returnVal){
	if(returnVal =="" || returnVal =="0" || returnVal ==0){
		return returnVal;
	}
	var patNum = val.indexOf(".") ;
	var valNum = returnVal.indexOf(".") ;
	var patLength = val.length -patNum-1;   
	var length = returnVal.length;
	if(patNum >0){//소수점있음
		if(valNum > 0){ //값에 소수점 있음
			alert(patLength+valNum);
			var firstVal ="0.";                                                                 
			var lastVal= returnVal.substring(2,length); 
			for(var i=0; i < patLength ; i++){
				firstVal=firstVal+"0";                                                             
			}                   
			return firstVal+lastVal; 
		}else{
			var firstVal =returnVal.substring(0,length - patLength);                                                                 
			var lastVal= returnVal.substring(length - patLength,length);     
			alert(patLength);                                                             
			var temp="";
			if(lastVal !="0"){
				for(var i=lastVal.length ; i > 0 ; i--){
					if(lastVal.charAt(i) =="0"){
						temp = lastVal.substring(0,i);                       
					}
				}
			}                          
			if(temp !=""){
				temp="."+temp;             	
			}
			return firstVal+temp; 
		}
	}
	
}