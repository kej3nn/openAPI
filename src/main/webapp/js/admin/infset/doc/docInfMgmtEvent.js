/*
 * @(#)docInfMgmtEvent.js 1.0 2019/08/05
 */

/**
 * 관리자에서 정보공개 문서관리 이벤트를 관리하는 스크립트
 *
 * @author JHKIM
 * @version 1.0 2019/08/05
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
	// 공개구분
	loadComboOptions("openCd", "/admin/stat/ajaxOption.do", {grpCd:"I1001"}, "");
	// 미공개사유
	loadComboOptions("causeCd", "/admin/stat/ajaxOption.do", {grpCd:"I1002"}, "");
	// 이용허락조건(콤보)
	loadComboOptions("cclCd", "/admin/stat/ajaxOption.do", {grpCd:"D1008"}, "");
	// 문서보존기한코드
	loadComboOptions("docKpDdayCd", "/admin/stat/ajaxOption.do", {grpCd:"I1010"}, "");
	
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
		var docId = formObj.find("input[name=docId]").val();
		if ( com.wise.util.isBlank(docId) ) {
			alert("문서 기본정보 먼저 등록하세요.");
		} else {
			e.preventDefault();
			var i = $(this).index();
			formObj.find('.tab-inner-sect').hide();
			formObj.find('.tab-inner-sect').eq(i).show()
			formObj.find('.tab-inner-li a').removeClass('on');
			$(this).children().addClass('on');

			// 첨부파일탭 스마트에디터 로드
			if ( formObj.find("div[name=tab-inner-file-sect] iframe").length == 0 ) {
				nhn.husky.EZCreator.createInIFrame({ 
					oAppRef: oEditors, 
					elPlaceHolder: "fileDtlCont",
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
	
	// 보유데이터 팝업
	formObj.find("button[name=dtSearch]").click(function() {		// 보유데이터 팝업
 		var url = com.wise.help.url("/admin/openinf/opends/popup/openDt_pop.do");// + "?index=1";
		var popup = OpenWindow(url,"OpenInfdtPop","700","550","yes");	       
 		return false;    
 	});
	
	// 마스터 데이터를 등록한다.
	formObj.find("a[name=a_reg]:eq(0)").bind("click", function(event) {
		doActionMst("insert");
    });
	// 마스터 데이터를 수정한다.
	formObj.find("a[name=a_save]:eq(0)").bind("click", function(event) {
		doActionMst("update");
    });
	// 마스터 데이터를 삭제한다.
	formObj.find("a[name=a_del]:eq(0)").bind("click", function(event) {
		doActionMst("delete");
    });
	
	// 파일 초기화
	formObj.find("button[name=fileInit]").bind("click", function(event) {
		doActionFileSheet("init");
	});
	// 파일 등록
	formObj.find("a[name=a_file_reg]").bind("click", function(event) {
		doActionFileSheet("reg");
    });
	// 파일 저장
	formObj.find("a[name=a_save]:eq(1)").bind("click", function(event) {
		doActionFileSheet("save");
    });
	// 파일 삭제
	formObj.find("a[name=a_del]:eq(1)").bind("click", function(event) {
		doActionFileSheet("del");
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
	
	// 공개구분 변경이벤트
	formObj.find("#openCd").bind("change", function(event) {
		formObj.find("#causeCd option").removeAttr("disabled");
		// 전체공개일경우 미공개사유는 공개만 선택가능
		if ( $(this).val() == "DT002" ) {
			formObj.find("#causeCd").val("99");
			formObj.find("#causeCd option").not(":selected").attr("disabled", "disabled");
		}
		else {
			formObj.find("#causeCd option:not([value=99]):eq(0)").attr("selected", "selected");
			formObj.find("#causeCd option[value=99]").attr("disabled", "disabled");
		}
	});
	// 첨부파일시트 순서저장
	formObj.find("a[name=a_file_order]").bind("click", function(event) {
		doActionFileSheet("saveOrder");
	});
	// 첨부파일시트 위로이동
	formObj.find("a[name=a_file_up]").bind("click", function(event) {
		doActionFileSheet("rowUp");
	});
	// 첨부파일시트 아래로이동
	formObj.find("a[name=a_file_down]").bind("click", function(event) {
		doActionFileSheet("rowDown");
	});
	// 첨부파일시트 이미지 미리보기
	formObj.find("button[name=btnImgThumbnail]").bind("click", function(event) {
		doActionFileSheet("thumbnail");
	});
	
}

/**
 * 캘린더 초기화 및 이벤트생성
 */
function datePickerInit() {
	var formObj = getTabFormObj("mst-form");
	
	/* 탭 이동마다 호출 */
	formObj.find(".ui-datepicker-trigger").remove();	//달력 이미지 제거
	
	// 공개일
	formObj.find("input[name=openDttm]").removeClass('hasDatepicker').datepicker(setDatePickerCalendar());
	
	// 생산일(파일)
	formObj.find("input[name=prdcYmd]").removeClass('hasDatepicker').datepicker(setDatePickerCalendar());
	
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