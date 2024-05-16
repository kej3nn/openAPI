/*
 * @(#)fCalcStatSch.js 1.0 2019/05/15
 * 
 * COPYRIGHT (C) 2013 WISEITECH CO., LTD. ALL RIGHTS RESERVED.
 */

/**
 * 사칙연산 관련 스크립트 파일이다.
 * 
 * @author 김정호
 * @version 1.0 2019/05/15
 */
// //////////////////////////////////////////////////////////////////////////////
// 사칙연산 용 글로벌 변수
// //////////////////////////////////////////////////////////////////////////////
MULTI_STAT_TYPE = "FC";

// //////////////////////////////////////////////////////////////////////////////
// Script Init Loading...
// //////////////////////////////////////////////////////////////////////////////
$(function() {

	loadEvent();
	
	// GNB메뉴 바인딩한다.
	menuOn(1, 4);
	
	
	
});

function loadEvent() {
	var objTab = getTabShowObj();
	var formSch = $("form[name=searchForm]");
	var formObj = objTab.find("form[name=statsEasy-mst-form]");
	
	// 증감분석 버튼 숨김
	$("button[name=callPopDvs]").hide();
	
	// 메인탭 계산식 초기화
	formSch.find("#calcAqnReset").click(function() {
		formSch.find("#calcAqn").val("");
	});
	
	// 메인탭 계산식 입력제한(소문자와 특정 기호만 입력), 탭 계산식 이벤트는 multiStatSch.js 파일에 있음
	setCalcAqnAlphaNumeric(formSch.find("#calcAqn"));
}

function setCalcAqnAlphaNumeric(element) {
	element.bind("keydown", function() {
		$(this).val( $(this).val().replace( /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/g, '' ) );
	}).alphanum({
			allowSpace: false,
			allowNewline: false,
			maxLength: 80,
			allow: "+-*/()",
//			forceUpper: true
	//		allowLower: false,
	//		allowUpper: true
		});
}

/**
 * 계산식 VALIDATION
 * @returns		{boolean} 정상/비정상
 */
function validCalcOperator() {
	var WORD_STATUS = {
		NUM: 		1,	// 숫자
		ALPHA: 		2,	// 알파벳
		OPRT: 		3,	// 연산자(+, -, *, /)
		OPRT_MLDV: 	4,	// 연산자(*, /)
		FB: 		5,	// 여는괄호
		TB: 		6	// 닫는괄호
	};
		
	var CHAR_CODE = {
		fb:		40,	// (
		tb:		41,	// )
		mlpy: 	42,	// *
		plus: 	43,	// +
		minus: 	45,	// -
		dvd: 	47,	// /
		0: 		48,
		9: 		57,
		A: 		65,
		Z: 		90,
	};
	
	var iFirst = true;		// 최초 접근
	var status = 0;			// 문자의 상태
	var prevStatus	= 0;	// 이전 문자의 상태
	var msg = "계산식 오류입니다.<br>";
	var objTab = getTabShowObj();
	objTab.find("#calcAqn").val();
	var calc = objTab.find("#calcAqn").val();
	calc = calc.replace( /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/g, '').toUpperCase().trim();

	if ( gfn_isNull(calc) ) {
		jAlert("계산식을 입력하세요.");
		return false;
	}
	objTab.find("#calcAqn").val(calc);	// 대문자로 변경하여 다시 입력해준다.
	
	var arrCalc = calc.split('');
	var rowCnt = mixContainer.RowCount();	// 선택항목 행 갯수
	var alphaObj = {};	// alphabet 체크
	var brktObj = {};	// braket[(, )] 개수 체크
	
	for ( var i in arrCalc ) {
		var char = arrCalc[i];
		var charCode = char.charCodeAt();
		
		if ( charCode >= CHAR_CODE.A && charCode <= CHAR_CODE.Z ) {	// A ~ Z
			alphaObj[char] = (alphaObj[char] || 0) + 1;
		}
		else if ( charCode == 40 ) {	// '('
			brktObj[char] = (brktObj[char] || 0) + 1;
		}
		else if ( charCode == 41 ) {	// ')'
			brktObj[char] = (brktObj[char] || 0) + 1;
		}
	}
	
	// 추가한 행갯수(기호)만큼 계산식 기호가 입력하였는지 체크
	/*
	if ( rowCnt != Object.keys(alphaObj).length ) {
		jAlert(msg + "선택항목으로 추가한 기호만큼 계산식 기호를 입력해야 합니다.");
		return false;
	}
	*/
	
	// 동일한 기호는 입력불가
	var checkMaxAlphaCd = CHAR_CODE.A + rowCnt;
	for ( var key in alphaObj ) {
		/*
		if ( alphaObj[key] > 1 ) {
			jAlert(msg + "기호 ["+ key +"]가 1개 이상 입력되었습니다.");
			return false;
		}*/
		
		if ( key.charCodeAt() < CHAR_CODE.A || key.charCodeAt() >= checkMaxAlphaCd ) {
			jAlert(msg + "계산식에 선택항목 기호에 없는 기호가 입력되었습니다. [기호 : "+key+"]");
			return false;
		}
	}
	
	if ( brktObj["("] != brktObj[")"] ) {
		jAlert(msg + "여는괄호와 닫는괄호의 갯수가 다릅니다.");
		return false;
	}
	
	for ( var i=0; i < arrCalc.length; i++ ) {
		var char = arrCalc[i];
		var charCode = char.charCodeAt();
		
		if ( charCode >= CHAR_CODE.A && charCode <= CHAR_CODE.Z ) { 	// A ~ Z
			status = WORD_STATUS.ALPHA;
		}
		else if ( charCode >= 48 && charCode <= 57 ) {	// 0 ~ 9
			status = WORD_STATUS.NUM;
		}
		else if ( charCode == CHAR_CODE.plus || charCode == CHAR_CODE.minus || charCode == CHAR_CODE.mlpy || charCode == CHAR_CODE.dvd  ) {	// [+, -, *, /]
			status = WORD_STATUS.OPRT;
		}
		else if ( charCode == CHAR_CODE.mlpy || charCode == CHAR_CODE.dvd  ) {	// [*, /]
			status = WORD_STATUS.OPRT_MLDV;
		}
		else if ( charCode == CHAR_CODE.fb ) {	// [(]
			status = WORD_STATUS.FB;
		}
		else if ( charCode == CHAR_CODE.tb ) {	// [)]
			status = WORD_STATUS.TB;
		}
		
		if ( i == 0 && (charCode == CHAR_CODE.mlpy || charCode == CHAR_CODE.dvd) )  {
			jAlert(msg + "계산식 처음에는 연산자가 올 수 없습니다.");
			return false;
		}
		
		if ( iFirst && (status == WORD_STATUS.NUM || status == WORD_STATUS.FB) ) {	
			// 문자와 여는괄호는 pass
		}
		else if ( iFirst && i == 0 && status == WORD_STATUS.OPRT_MLDV ) {
			// 맨처음입력자에 [+, -]는 pass
		}
		else if ( iFirst && prevStatus == WORD_STATUS.NUM ) {	
			// 이전문자가 숫자이면 pass
		}
		else {
			iFirst = false;
			
			if ( status == prevStatus && status != WORD_STATUS.NUM ) {
				if ( prevStatus == WORD_STATUS.FB && status == WORD_STATUS.FB ) {
					// [(] 연속 입력은 pass
				}
				else if ( prevStatus == WORD_STATUS.TB && status == WORD_STATUS.TB ) {
					// [)] 연속 입력은 pass
				}
				else {
					jAlertCalc(msg + "기호나 연산자를 연속으로 입력 할 수 없습니다.", calc, i);
					return false;
				}
			}
			else if ( status == WORD_STATUS.FB ) {
				if ( prevStatus != WORD_STATUS.OPRT ) {
					jAlertCalc(msg + "여는 괄호 앞에는 연산자만 올 수 있습니다.", calc, i);
				}
			}
			else if ( status == WORD_STATUS.TB ) {
				if ( prevStatus == WORD_STATUS.OPRT ) {
					jAlertCalc(msg + "닫는 괄호 앞에는 연산자가 올 수 없습니다.", calc, i);
					return false;
				}
			}
			else if ( status == WORD_STATUS.NUM ) {
				if ( prevStatus == WORD_STATUS.TB ) {
					jAlertCalc(msg + "닫는 괄호 뒤에는 숫자가 올 수 없습니다.", calc, i);
					return false;
				}
			}
			else if ( status == WORD_STATUS.OPRT_MLDV ) {
				if ( prevStatus == WORD_STATUS.FB || prevStatus == WORD_STATUS.TB ) {
					jAlertCalc(msg + "괄호 앞/뒤에는 연산자(*, /)가 올 수 없습니다.", calc, i);
					return false;
				}
			}
		}
		prevStatus = status;
	}
	return true;
}

/**
 * 사칙연산 alert 메시지 생성
 * @Param msg	메시지 text
 * @Param calc	사용자가 입력한 계산식 text 
 * @Param idx	계산식 오류 index  
 */
function jAlertCalc(msg, calc, idx) {
	var calc = calc || "";
	var idx = idx || 0;
	var calcErrTxt = "<font color='red'>" + calc.substr(idx-1, 2) + "</font>";
	var calcTxt = calc.substr(0, idx-1) + calcErrTxt + calc.substring(idx+1, calc.length);
	msg += "<br>" + calcTxt;
	$("#alertMsg").empty().append(msg);
	$(".layerpopup-stat-wrapper").hide();
	$("#alert-box").show();
	$("#alert-box-focus").val(document.activeElement.name);	// 창 닫기 후 이동할 focus 위치 지정
	$("#alert-box .type02").focus();						// 확인 버튼으로 focus
}


/**
 * 사칙연산 시트 조회후 선택한 기준시점 표시처리
 * @returns
 */
function sheetOnSearchEndBPoint() {
	var objTab = getTabShowObj();
	var sheetObj = window[getTabSheetName()];
	var viewLocOpt = objTab.find("input[name=viewLocOpt]:checked").val();
	var startRow = sheetObj.GetDataFirstRow();
	
	if ( viewLocOpt == "H" || viewLocOpt == "T" ) {	// 기본(가로) 보기, 년월보기
		sheetObj.SetRowBackColor(startRow, IB_COLOR_DTA);	// 컬럼 배경색
		sheetObj.RangeFontBold(startRow, 0, startRow, sheetObj.LastCol(), true);
	}
	else if ( viewLocOpt == "V" ) {	// 세로보기
		sheetObj.SetColBackColor("calcVal", IB_COLOR_DTA);
		sheetObj.SetColFontBold("calcVal", true);
	}
}