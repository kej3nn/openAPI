/*
 * @(#)infSetMgmtEvent.js 1.0 2019/07/29
 */

/**
 * 관리자에서 정보셋의 이벤트를 관리하는 스크립트
 *
 * @author JHKIM
 * @version 1.0 2019/07/29
 */
/**
 * 이벤트를 바인딩한다.
 */
function bindEvent() {
	// 메인화면 이벤트 처리
	bindEventMain();
}

/**
 * 옵션을 로드한다.
 */
function loadOptions() {
	// 메인 폼 공개일 from ~ to
	$("form[name=mainForm]").find("input[name=beginOpenDttm], input[name=endOpenDttm]").datepicker(setDatePickerCalendar());
	$("form[name=mainForm]").find('input[name=beginOpenDttm]').datepicker('option', 'onClose',  function( selectedDate ) {$("input[name=endOpenDttm]").datepicker( "option", "minDate", selectedDate );});
	$("form[name=mainForm]").find('input[name=endOpenDttm]').datepicker('option', 'onClose',  function( selectedDate ) {	$("input[name=beginOpenDttm]").datepicker( "option", "maxDate", selectedDate );});
	
	// 추천순위
	loadComboOptions("fvtDataOrder", "/admin/stat/ajaxOption.do", {grpCd:"C1018"}, "");
}

/**
 * 메인화면 이벤트 처리
 */
function bindEventMain() {
	// 신규등록 폼 탭을 추가한다.
	$("button[name=btn_reg]").bind("click", function(event) {
		doActionMain("regForm");
    });
	// 조회
	$("button[name=btn_inquiry]").bind("click", function(event) {
		doActionMain("search");
    });
	$("input[name=searchVal]").bind("keydown", function(event) {
        // 엔터키인 경우
        if (event.which == 13) {
        	doActionMain("search");
            return false;
        }
    });
	// 입력기간 초기화
	$("button[name=openDttm_reset]").bind("click", function(e) {
		$("input[name=beginOpenDttm], input[name=endOpenDttm]").val("");
	});
	
	//분류체계 팝업
	$("button[name=cate_pop]").bind("click", function(e) {
		doActionMain("catePop");
	});
	//분류체계 초기화
	$("button[name=cate_reset]").bind("click", function(e) {
		$("input[name=cateId], input[name=cateIds], input[name=cateNm]").val("");
	});
	
	//담당부서 팝업
	$("button[name=org_pop]").bind("click", function(e) {
		doActionMain("orgPop");
	});
	
	//담당부서 초기화
	$("button[name=org_reset]").bind("click", function(e) {
		$("input[name=orgId], input[name=orgNm]").val("");
	});
	//분류체계 팝업
	$("button[name=cate_pop]").bind("click", function(e) {
		doActionMain("catePop");
	});
	// 엑셀 다운
	$("button[name=btn_xlsDown]").bind("click", function(event){
		doActionMain("excel");
	});
	
}

// 탭 버튼 이벤트 추가
function setTabButtonEvent() {
	var formObj = getTabFormObj("mst-form");
	
	// 캘린더 초기화 및 이벤트생성
	datePickerInit();
	
	//상세 탭 관련 이벤트
	formObj.find(".tab-inner li").on('click', function(e){
		var infsId = formObj.find("input[name=infsId]").val();
		if ( com.wise.util.isBlank(infsId) ) {
			alert("정보셋 기본정보 먼저 등록하세요.");
		} else {
			e.preventDefault();
			var i = $(this).index();
			formObj.find('.tab-inner-sect').hide();
			formObj.find('.tab-inner-sect').eq(i).show()
			formObj.find('.tab-inner-li a').removeClass('on');
			$(this).children().addClass('on');

			// 설명탭 스마트에디터 로드
			if ( formObj.find("div[name=tab-inner-exp-sect] iframe").length == 0 ) {
				nhn.husky.EZCreator.createInIFrame({ 
					oAppRef: oEditors, 
					elPlaceHolder: "infsDtlCont",
					sSkinURI: "/SmartEditor2/SmartEditor2Skin.html",
					fCreator: "createSEditor2" ,
					htParams : { 
						fOnBeforeUnload : function(){}
					},
					formObj: "mst-form"	
				});
			}
		}
	});
	
	// 데이터를 등록한다.
	formObj.find("a[name=a_reg]").bind("click", function(event) {
		doActionMst("insert");
    });
	// 데이터를 수정한다.
	formObj.find("a[name=a_modify]:eq(0)").bind("click", function(event) {
		doActionMst("update");
    });
	// 데이터를 삭제한다.
	formObj.find("a[name=a_del]:eq(0)").bind("click", function(event) {
		doActionMst("delete");
    });
	// 공개처리 버튼
	formObj.find("a[name=a_openState]").bind("click", function() {
		doActionMst("open");
	});
	// 공개취소 버튼
	formObj.find("a[name=a_openStateCancel]").bind("click", function() {
		doActionMst("openCancel");
	});
	// 분류추가
	formObj.find("button[name=cateAdd]").bind("click", function(e) {
		doActionCateSheet("catePop");
	});
	// 인원추가
	formObj.find("button[name=usrAdd]").bind("click", function(e) {
		doActionUsrSheet("addRow");
	});
	// 추천 체크박스 이벤트
	formObj.find("input[name=fvtDataYn]").bind("click", function(event) {
		if ( !$(this).is(":checked") ) {
			formObj.find("select[name=fvtDataOrder]").val("0").hide();	//체크 해제시 추천안함으로
		} else {
			formObj.find("select[name=fvtDataOrder]").show();
		}
	});
	// 추천 순위 selectbox 이벤트
	formObj.find("select[name=fvtDataOrder]").bind("change", function(event) {
		if ( $(this).val() == "0" ) {	//추천 안할경우
			$(this).hide();	//selectbox 숨김
			formObj.find("input[name=fvtDataYn]").prop("checked", false);	//추천 체크박스 언체크
		}
	});
	// 설명 시트 위로이동
	formObj.find("a[name=a_exp_up]").bind("click", function() {
		doActionExpSheet("rowUp");
	});
	// 설명 시트 아래로이동
	formObj.find("a[name=a_exp_down]").bind("click", function() {
		doActionExpSheet("rowDown");
	});
	// 설명 시트 초기화
	formObj.find("button[name=expInit]").bind("click", function() {
		doActionExpSheet("init");
	});
	// 설명시트 데이터 저장
	formObj.find("[name=tab-inner-exp-sect] [name=a_save]").bind("click", function() {
		doActionExpSheet("save");
	});
	// 설명시트 데이터 삭제
	formObj.find("[name=tab-inner-exp-sect] [name=a_del]").bind("click", function() {
		doActionExpSheet("delete");
	});
	// 설명시트 순서저장
	formObj.find("[name=tab-inner-exp-sect] [name=a_exp_order]").bind("click", function() {
		doActionExpSheet("saveOrder");
	});
	// 문서데이터 탭 통계표 추가
	formObj.find("button[name=docAdd]").bind("click", function() {
		doActionDocSheet("addPop");
	});
	// 공공데이터 탭 통계표 추가
	formObj.find("button[name=openAdd]").bind("click", function() {
		doActionOpenSheet("addPop");
	});
	// 통계표 탭 통계표 추가
	formObj.find("button[name=statAdd]").bind("click", function() {
		doActionStatSheet("addPop")
	});
	// 문서데이터 탭 저장버튼
	formObj.find("[name=tab-inner-doc-sect] [name=a_save]").bind("click", function() {
		doActionDocSheet("save");
	});
	// 공공데이터 탭 저장버튼
	formObj.find("[name=tab-inner-open-sect] [name=a_save]").bind("click", function() {
		doActionOpenSheet("save");
	});
	// 통계데이터 탭 저장버튼
	formObj.find("[name=tab-inner-stat-sect] [name=a_save]").bind("click", function() {
		doActionStatSheet("save");
	});
	// 문서데이터 시트 위로이동
	formObj.find("a[name=a_doc_up]").bind("click", function() {
		doActionDocSheet("rowUp");
	});
	// 문서데이터 시트 아래로이동
	formObj.find("a[name=a_doc_down]").bind("click", function() {
		doActionDocSheet("rowDown");
	});
	// 공공데이터 시트 위로이동
	formObj.find("a[name=a_open_up]").bind("click", function() {
		doActionOpenSheet("rowUp");
	});
	// 공공데이터 시트 아래로이동
	formObj.find("a[name=a_open_down]").bind("click", function() {
		doActionOpenSheet("rowDown");
	});
	// 통계데이터 시트 위로이동
	formObj.find("a[name=a_stat_up]").bind("click", function() {
		doActionStatSheet("rowUp");
	});
	// 통계데이터 시트 아래로이동
	formObj.find("a[name=a_stat_down]").bind("click", function() {
		doActionStatSheet("rowDown");
	});
}

/**
 * 캘린더 초기화 및 이벤트생성
 */
function datePickerInit() {
	var formObj = getTabFormObj("mst-form");
	
	/* 탭 이동마다 호출 */
	formObj.find(".ui-datepicker-trigger").remove();	//달력 이미지 제거
	
	//공개일
	formObj.find("input[name=openDttm]").removeClass('hasDatepicker').datepicker(setDatePickerCalendar());
	
	//공개일 초기화
	formObj.find("button[id=openDttmInit]").bind("click", function() {
		formObj.find("input[name=openDttm]").val("");		
	});
}

function setDatePickerCalendar() {
	var calendar = {
		monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
		dayNamesMin: ['일','월','화','수','목','금','토'],
		weekHeader: 'Wk',
		dateFormat: 'yy-mm-dd', //형식(20120303)
		autoSize: false, //오토리사이즈(body등 상위태그의 설정에 따른다)
		changeMonth: true, //월변경가능
		changeYear: true, //년변경가능
		showMonthAfterYear: true, //년 뒤에 월 표시
		buttonImageOnly: true, //이미지표시
		buttonText: '달력선택', //버튼 텍스트 표시
		buttonImage: "../../../../images/admin/icon_calendar.png", //이미지주소                                              
		showOn: "both", //엘리먼트와 이미지 동시 사용(both,button)                 
		yearRange: '1900:2100', //1990년부터 2020년까지
		showButtonPanel: true, 
		closeText: 'close'
	};
	return calendar;
}

