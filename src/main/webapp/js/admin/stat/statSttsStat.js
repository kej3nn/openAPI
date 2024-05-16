/*
 * @(#)statStddMeta.js 1.0 2017/07/03
 * 
 * COPYRIGHT (C) 2013 WISEITECH CO., LTD. ALL RIGHTS RESERVED.
 */

/**
 * 관리자 통계메타관리 스크립트 파일이다
 *
 * @author 김정호
 * @version 1.0 2017/08/07
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
var sheetUsrTabCnt = 0;		//유저시트 갯수

/**
 * 메타입력유형 템플릿
 * 	str 	: 문자열
 * 	date 	: 날짜
 * 	number 	: 숫자
 * 	combo 	: 공통코드 선택
 * 	file 	: 파일
 */
var metatyTemplate = {
	    str:
	        "<tr>"                                                       +
	            "<th></th>"  +
	            "<td colspan=\"2\">"+
	            	"<input type='text' id='strKor' name='' size='40' placeholder='(한글)입력하세요.' />&nbsp;&nbsp;" +
	            	"<input type='text' id='strEng' name='' size='40' placeholder='(영문)입력하세요.' />&nbsp;&nbsp;"+
	            "</td>" +
	            "<td><b><label id=\"metaExp\"></label></b></td>"+
	        "</tr>",
        str500:
	        "<tr>"                                                       +
	            "<th></th>"  +
	            "<td colspan=\"2\">"+
	            	"<textarea id='strKor' name='' rows='3' style='width: 45%' placeholder='(한글)입력하세요.' />&nbsp;&nbsp;" +
	            	"<textarea id='strEng' name='' rows='3' style='width: 45%' placeholder='(영문)입력하세요.' />&nbsp;&nbsp;"+
	            "</td>" +
	            "<td><b><label id=\"metaExp\"></label></b></td>"+
	        "</tr>",    
	    date:
	        "<tr>"  +
	            "<th></th>"  +
	            "<td colspan=\"2\">"+
	            	"<input type='text' id='date' name='' value='2' size='30' placeholder='날짜를 선택하세요.' />&nbsp;&nbsp;" +
	            "</td>" +
	            "<td><b><label id=\"metaExp\"></label></b></td>"+
	        "</tr>",
	    number:
	        "<tr>" +
	            "<th></th>"  +
	            "<td colspan=\"2\">"+
	            	"<input type='text' id='number' name='' size='43' placeholder='숫자를 입력하세요.' />&nbsp;&nbsp;" +
	            "</td>" +
	            "<td><b><label id=\"metaExp\"></label></b></td>"+
	        "</tr>",	
	    combo:
	        "<tr>" +
	            "<th></th>"  +
	            "<td colspan=\"2\">"+
	            	"<select id='combo' name='' style='width: 180px'></select>&nbsp;&nbsp;" +
	            "</td>" +
	            "<td><b><label id=\"metaExp\"></label></b></td>"+
	        "</tr>",
	    file:
	        "<tr>" +
	            "<th rowspan='2'></th>" +
	            "<td colspan=\"3\">"+
	            	"<input type='file' id='file' name=''/>&nbsp;&nbsp;" +
	            "</td>" +
	            
	        "</tr>" + 
	        "<tr>" +
	        	"<td colspan=\"2\">"+
		        	"<input type='text' id='fileSaveNm' name='' size='30' placeholder='(저장 파일명)입력하세요.' />&nbsp;&nbsp;"+
		        	"<input type='text' id='fileViewKorNm' name='' size='30' placeholder='(출력 한글 파일명)입력하세요.' />&nbsp;"+
		        	"<input type='text' id='fileViewEngNm' name='' size='30' placeholder='(출력 영문 파일명)입력하세요.' />"+
		        "</td>" +
		        "<td><b><label id=\"metaExp\"></label></b></td>"+
	        "</tr>"
	};

////////////////////////////////////////////////////////////////////////////////
// 초기화 함수
////////////////////////////////////////////////////////////////////////////////
/**
 * 컴포넌트를 초기화한다.
 */
function initComp() {
	tabSet();
	
	loadSheet();	//시트로드
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

	$("button[name=btn_inquiry]").bind("click", function(event) {
		//조회
		doActionMain("search");
    });
	$("button[name=btn_reg]").bind("click", function(event) {
		// 신규등록 폼 탭을 추가한다.
		doAction("regForm");
    });
	//조회 enter
	$("input[name=searchVal]").bind("keydown", function(event) {
        // 엔터키인 경우
        if (event.which == 13) {
        	doActionMain("search");
            return false;
        }
    });
	//담당부서 팝업
	$("button[name=org_pop]").bind("click", function(e) {
		doActionMain("orgPop");
	});
	//담당부서 초기화
	$("button[name=org_reset]").bind("click", function(e) {
		$("input[name=orgCd], input[name=orgNm]").val("");
	});
	//시트 row 위로 이동
	$("a[name=a_treeUp]").bind("click", function(event) {
		doAction("gridUp");
    });
	//시트 row 아래로 이동
	$("a[name=a_treeDown]").bind("click", function(event) {
		doAction("gridDown");
    });
	//시트 순서 저장
	$("a[name=a_vOrderSave]").bind("click", function(event) {
		doAction("orderSave");
    });
}


/**
 * 옵션을 로드한다.
 */
function loadOptions() {
	//메인페이지 단위유형코드
	loadComboOptions("sttsCd", "/admin/stat/ajaxOption.do", {grpCd:"S1008"}, "");			//통계구분코드(탭)
}

/**
 * 데이터를 로드한다.
 */
function loadData() {
	doActionMain("search");
}

////////////////////////////////////////////////////////////////////////////////
// 서비스 함수
////////////////////////////////////////////////////////////////////////////////
function doActionMain(sAction) {
	var formObj = getTabFormObj("statSttsForm"); 
	var sheet = window["sheet"];

	switch(sAction) {                       
		case "search" :
			ajaxBeforeSendAdmin(com.wise.help.url("/admin/ajaxBeforeSendAdmin.do")); //IbSheet 조회전 세션 체크
			var param = {PageParam: "ibpage", Param: "onepagerow=50"+"&"+formObj.serialize()};
			sheet.DoSearchPaging(com.wise.help.url("/admin/stat/statSttsStatList.do"), param);
			break;
		case "orgPop" :
			window.open(com.wise.help.url("/admin/basicinf/popup/commOrg_pop.do") + "?orgNmGb=2&sheetNm=statMainForm", "list" ,"fullscreen=no, width=500, height=550");
			break;
	}
}

/**
 * 화면 액션
 */
function doAction(sAction) {
	var formObj = getTabFormObj("sttsStat-dtl-form");
	var classObj = $("."+tabContentClass);
	var actObj = setTabForm(classObj); // 0: form data, 1: form 객체
	var sheet = window["sheet"];
	var usrSheetNm = formObj.find("input[name=usrSheetNm]").val();
	var usrSheetObj = window[usrSheetNm];
	
	switch(sAction) {   
		case "regForm" :
			var title = "신규등록"
			var id ="statReg";
			openTab.addRegTab(id, title, tabCallRegBack);
			break;
		case "insert" :
			if ( saveValidation() ) {
				if ( !confirm("등록 하시겠습니까?") )	return false;
				doAjax({
					url : "/admin/stat/insertStatSttsStat.do",
					params : formObj.serialize(),
					callback : afterTabRemove
				});
			} 
			break;
		case "update" :
			if ( !usrSheetValidation(usrSheetObj) ) {
				return false;
			}
			
			formObj.ajaxSubmit({
				url : com.wise.help.url("/admin/stat/saveStatSttsStatMeta.do") + "?ibsSaveJson=" + encodeURIComponent(JSON.stringify(usrSheetObj.GetSaveJson({AllSave:true})))
				, async : false
				, type : 'post'
				, dataType: 'json' 
				, contentType : 'application/x-www-form-urlencoded;charset=UTF-8'
				, beforeSubmit : function() {
					//submit 전 validation 체크
					if ( formObj.valid() ) {
						if ( usrSheetObj.RowCount() == 0 ) {
							alert("인원정보를 입력하세요.");
							return false; 
						}
						if ( !confirm("저장 하시겠습니까?") )	return false;
					} else {
						return false;
					}
				}	
				, success : function(res, status) {
					doAjaxMsg(res, "");
					afterTabRemove(res);
				}
				, error: function(jqXHR, textStatus, errorThrown) {
					alert("처리 도중 에러가 발생하였습니다.");
				}
			});
			break;
		case "delete" :
			if ( !confirm("삭제 하시겠습니까?") )	return false;
			doAjax({
				url : "/admin/stat/deleteStatSttsStat.do",
				params : formObj.serialize(),
				callback : afterTabRemove
			});
			break;	
		case "statMetaExpPop" :	//통계 설명 팝업
			window.open(com.wise.help.url("/admin/stat/popup/statMetaExpPopup.do") + "?statId=" + formObj.find("input[name=statId]").val() , "list", "fullscreen=no, width=800, height=700");	
		case "gridUp" :		//위로이동
			gridMoveUpChgVal(sheet, "vOrder");
			break;
		case "gridDown" :	//아래로이동
			gridMoveDownChgVal(sheet, "vOrder");
			break;	
		case "orderSave" :	//순서저장
			if(sheet.GetSaveJson(0).data.length == 0) {
				alert("저장할 데이터가 없습니다.");  
				return;
			}
			doAjax({
				url : "/admin/stat/saveSttsStatOrder.do",
				params : formObj.serialize() + "&ibsSaveJson=" + JSON.stringify(sheet.GetSaveJson(0)),
				succUrl : "/admin/stat/statSttsStatPage.do",
			});
			break;	
	}
}

//인원정보 관련 서비스액션
function doActionUsrSheet(sAction) {
	var formObj = getTabFormObj("sttsStat-dtl-form");
	var classObj = $("."+tabContentClass);
	var actObj = setTabForm(classObj); // 0: form data, 1: form 객체
	var usrSheetNm = formObj.find("input[name=usrSheetNm]").val();
	var usrSheetObj = window[usrSheetNm];
	
	switch(sAction) {
		case "search" :	//조회
			ajaxBeforeSendAdmin(com.wise.help.url("/admin/ajaxBeforeSendAdmin.do")); //IbSheet 조회전 세션 체크
			var param = {PageParam: "ibpage", Param: "onepagerow=50"+"&"+actObj[0]};
			usrSheetObj.DoSearchPaging(com.wise.help.url("/admin/stat/statSttsStatUsrList.do"), param);
			break;
		case "addRow" :	//행 추가
			var newRow = usrSheetObj.DataInsert(-1);			//제일 마지막 행에 추가
			usrSheetObj.SetCellValue(newRow, "useYn", true);	//사용여부 기본값 체크
			break;
	}
}
////////////////////////////////////////////////////////////////////////////////
// 전처리 함수
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// 후처리 함수
////////////////////////////////////////////////////////////////////////////////
//상세 탭 이벤트 후처리
function tabFunction(tab, data) {
	var formObj = getTabFormObj("sttsStat-dtl-form");
	
	formObj.find("select[name=sttsCd] option").not(":selected").attr("disabled", "disabled"); 	//수정시 통계구분은 변경 불가
	formObj.find("button[name=statMeta_pop]").show();					//수정시 통계설명 버튼 보임
	
	/* 메타 구분별 테이블 세팅 */
	setTableTemplate();
	
	/* tab form 동적 validation 추가 */
	formValidation();
	
	/* 메타 입력유형 정보 세팅 */
	setStddMetaInfo();		
	
	formObj.find("div[name=usrSheet-sect]").show();		//인원정보 sheet 표시
}

//메타 구분별 테이블 세팅
function setTableTemplate() {
	var formObj = getTabFormObj("sttsStat-dtl-form");
	$.ajax({
	    url: com.wise.help.url("/admin/stat/statSttsStatExistMetaCd.do"),
	    async: false, 
	    type: 'POST', 
	    data: formObj.serialize(),
	    dataType: 'json',
	    beforeSend: function(obj) {
	    }, 
	    success: function(data) {
	    	var tableDiv = formObj.find("div[name=metatyTb-sect]");
	    	var table = "";
	    	var list = data.data;
	    	for ( var i in list ) {
	    		var metaCd = list[i].metaCd;
	    		table = 
	    			"<table id=\"metaTb"+metaCd+"\" name=\"metaTb"+metaCd+"\" class=\"list01\" style=\"position: relative;\">" +
	    				"<h3 class=\"text-title2\">"+ list[i].metaNm +"</h3>" +
	    				"<colgroup>" +
							"<col width=\"150\" />" +
							"<col width=\"\" />" +
							"<col width=\"\" />" +
							"<col width=\"500\" />" +
						"</colgroup>" +
	    			"</table>";
	    		tableDiv.append(table);
	    	}
	    },
	    error: function(request, status, error) {
	    	handleError(status, error);
	    },
	    complete: function(jqXHR) {} 
	});	
}

//메타 입력유형 정보 세팅
function setStddMetaInfo() {
	var formObj = getTabFormObj("sttsStat-dtl-form");
	$.ajax({
	    url: com.wise.help.url("/admin/stat/statSttsStddMeta.do"),
	    async: false, 
	    type: 'POST', 
	    data: formObj.serialize(),
	    dataType: 'json',
	    beforeSend: function(obj) {
	    }, 
	    success: function(data) {
	    	setStddMetaTemplate(data);
	    },
	    error: function(request, status, error) {
	    	handleError(status, error);
	    },
	    complete: function(jqXHR) {} 
	});	
}

/**
 * 메타 입력유형 별 템플릿 element 추가
 * @param data	메타 입력유형 정보 list
 */
function setStddMetaTemplate(data) {
	var list = data.data;	//메타 입력유형 리스트 데이터
	var formObj = getTabFormObj("sttsStat-dtl-form");
	
	var validOptions = [];	//validation 옵션
	
	for (var i = 0; i < list.length; i++) {
		table = formObj.find("table[name=metaTb"+ list[i].metaCd +"]");		//메타 구분 테이블
		row = getMetatyTemplate(list[i]);		//메타 입력 유형별 템플릿 로드
		table.append(row.template);				//메타 구분 테이블에 append
		validOptions.push(row.validOptions);	
	}
	//메타 유형별 동적 validation 추가
	for ( var arrValid in validOptions ) {
		var arrDatas = validOptions[arrValid];
		for ( var valid in arrDatas ) {
			addValidRule(formObj, arrDatas[valid]);		//validation 룰 추가
		}
	}
}

/**
 * 메타 입력 유형별 element 정보를 가져온다.
 * @param data	메타 입력유형 리스트 데이터
 */
function getMetatyTemplate(data) {
	var template = "";
	var obj = {};
	var validOptions = [];
//console.log(data);	
	var metaId = data.metaId;
	var metatyCd = data.metatyCd;
	
	switch(metatyCd) {                       
	case "ST":	//문자열
		//템플릿 가져와서 id와 name 변경
		if ( data.inputMaxCdVal > 100 ) {	
			// 입력유형이 문자열 100자 이상일때 템플릿 textarea로 변경
			template = $(metatyTemplate.str500); 
		}
		else {
			template = $(metatyTemplate.str);
		}
		template.find("#strKor").attr("id", "MTCD_" + metaId + "_ST_kor").attr("name", "MTCD_" + metaId + "_ST_kor").val(data.metaCont);	//문자열 한글
		template.find("#strEng").attr("id", "MTCD_" + metaId + "_ST_eng").attr("name", "MTCD_" + metaId + "_ST_eng").val(data.engMetaCont);	//문자열 영문
		//validation 룰 동적 추가
		validOptions.push(addValidOptionRow("MTCD_" + metaId + "_ST_kor", data));
		validOptions.push(addValidOptionRow("MTCD_" + metaId + "_ST_kor", data));
		break;
	case "DD":	//날짜
		template = $(metatyTemplate.date);
		template.find("#date").attr("id", "MTCD_" + metaId + "_DD").attr("name", "MTCD_" + metaId + "_DD");
		template.find("input[name=MTCD_" + metaId + "_DD]").datepicker(setCalendar()).val(data.metaCont);	//캘린더 추가
		validOptions.push(addValidOptionRow("MTCD_" + metaId + "_DD", data));
		break;
	case "NB":	//숫자
		template = $(metatyTemplate.number);
		template.find("#number").attr("id", "MTCD_" + metaId + "_NB").attr("name", "MTCD_" + metaId + "_NB").val(data.metaCont);
		validOptions.push(addValidOptionRow("MTCD_" + metaId + "_NB", data));
		break;
	case "SB":	//콤보
		template = $(metatyTemplate.combo);
		//콤보인 경우 공통코드 리스트 가져와서 추가한다.
		$.ajax({
			type: 'POST',
			url: com.wise.help.url("/admin/stat/ajaxOption.do"),
			data: {grpCd:data.grpCd},
			success: function(res) {
				if (res.data) {
					var combobox = template.find("#combo");
					combobox.find("option").each(function(index, element) {
					    $(this).remove();
					});
					for (var i = 0; i < res.data.length; i++) {
					    var option = $("<option></option>");
					    option.val(res.data[i].code);
					    option.text(res.data[i].name);
					    combobox.append(option);
					}
				}
			},
			dataType: 'json',
			async:false
		});
		template.find("#combo").attr("id", "MTCD_" + metaId + "_SB").attr("name", "MTCD_" + metaId + "_SB").val(data.ditcCd);
		validOptions.push(addValidOptionRow("MTCD_" + metaId + "_SB", data));
		break;
	case "FL":	//파일
		template = $(metatyTemplate.file);
		template.find("#file").attr("id", "MTCD_" + metaId + "_FL_file").attr("name", "MTCD_" + metaId + "_FL_file");	//파일
		template.find("#fileSaveNm").attr("id", "MTCD_" + metaId + "_FL_saveNm").attr("name", "MTCD_" + metaId + "_FL_saveNm").val(data.saveFileNm);				//저장 파일명
		template.find("#fileViewKorNm").attr("id", "MTCD_" + metaId + "_FL_viewKorNm").attr("name", "MTCD_" + metaId + "_FL_viewKorNm").val(data.viewFileNm);		//출력파일명(한글)
		template.find("#fileViewEngNm").attr("id", "MTCD_" + metaId + "_FL_viewEngNm").attr("name", "MTCD_" + metaId + "_FL_viewEngNm").val(data.engViewFileNm);	//출력파일명(영문)
		validOptions.push(addValidOptionRow("MTCD_" + metaId + "_FL_file", data));
		validOptions.push(addValidOptionRow("MTCD_" + metaId + "_FL_saveNm", data));
		validOptions.push(addValidOptionRow("MTCD_" + metaId + "_FL_viewKorNm", data));
		validOptions.push(addValidOptionRow("MTCD_" + metaId + "_FL_viewEngNm", data));
		break;	
	}
	
	//필수 입력 '*' 표시
	if ( data.inputNeedYn == "Y" ) {
		template.find("th").text(data.metaNm).append("<span> *</span>");
	} else {
		template.find("th").text(data.metaNm);
	}
	
	//메타 설명
	template.find("#metaExp").text( com.wise.util.isNull(data.metaExp) ? "" : "※ " + data.metaExp );
	
	obj.template 		= template; 
	obj.validOptions 	= validOptions;
	
	return obj;
}

/**
 * validation 룰 추가
 * @param formObj	탭 폼 object
 * @param options	validation 옵션
 */
function addValidRule(formObj, options) {
	var ruleParams = {};
	var metatyCd = options.data.metatyCd;			//메타 입력유형
	var inputNeedYn = options.data.inputNeedYn;		//필수 입력여부
	var isNumber 	= options.data.metatyCd 	== "NB" ? true : false;		//메타 입력유형이 숫자 인경우
	var isRequired	= options.data.inputNeedYn	== "Y" 	? true : false;	
	var requiredMsg = "값을 입력하세요.";		//필수 값 체크 메세지
	var numberMsg = "숫자를 입력하세요.";		//숫자 체크 메세지
	
	ruleParams.required = isRequired;
	ruleParams.number = isNumber;
	ruleParams.messages = {
		required : "값을 입력하세요.",
		number: "숫자를 입력하세요."
	}
	
	//메타 입력유형이
	if ( metatyCd == "SB" ) {
		//콤보박스 인 경우
		ruleParams.messages.required = "값을 선택하세요.";
	} else if ( metatyCd == "FL" && options.name.indexOf('_file') > 0 ) {
		//파일, input type='file' 인 경우 
		if ( !com.wise.util.isNull(options.data.srcFileNm) ) {	//첨부파일이 있는 경우
			ruleParams.required = false;
		}
		ruleParams.messages.required = "파일을 선택하세요.";
	} else if ( metatyCd == "ST" ) {
		//숫자 인경우
		if ( options.data.inputMaxCdVal ) {
			//최대 허용 글자수 값이 있는 경우
			ruleParams.maxlength = Number(options.data.inputMaxCdVal); 
			ruleParams.messages.maxlength = "최대 {0} 글자 이하만 입력하세요.";
		}
	}
	
	//룰 적용
	formObj.find("#" + options.name).rules('add', ruleParams);
}

/**
 * validation option row 추가
 */
function addValidOptionRow(name, data) {
	var vo = new Object();
	vo.name = name;
	vo.data = data;
	return vo;
}


/**
 * 데이터 저장 완료 후
 */
function sheet_OnLoadData(data) {
	var data = JSON.parse(data);
	if ( data.success != null) {
		//시트 분류명 저장이 성공적으로 완료된 경우
		alert(data.success.message);
		doActionMain("search");
	}
}

////////////////////////////////////////////////////////////////////////////////
//탭 관련 함수
////////////////////////////////////////////////////////////////////////////////
function tabSet(){ //탭 객체 생성  
	openTab = new OpenTab(tabId,tabContentClass,tabBody); //headinclude.jsp 변수 있음
	openTab.TabObj = openTab;  
	openTab.addTabClickEvent();            
}
//탭 버튼 이벤트
function buttonEventAdd() {
	setTabButton();     
}
//등록 탭 이벤트
function regUserFunction(tab) {
	usrSheetCreate(999);	//유저정보 시트생성
	
	var formObj = getTabFormObj("sttsStat-dtl-form");
	//dynamicTabButton(tab);		//탭 이벤트를 바인딩한다(동적생성 element들)
}

//상세 탭 이벤트
function tabEvent(row){//탭 이벤트 실행  
	var title = sheet.GetCellValue(row, "statNm");	//탭 제목
	title = title.substring(0, title.indexOf("<a"));	//아이콘 없앰
	var id = sheet.GetCellValue(row, "statId");			//탭 id(유일한key))
	openTab.SetTabData(sheet.GetRowJson(row));		//db data 조회시 조건 data
	var url =  com.wise.help.url('/admin/stat/statSttsStatDtl.do'); // Controller 호출 url 
	openTab.addTab(id, title, url, tabCallBack); 	// 탭 추가 시작함
	usrSheetCreate(sheetUsrTabCnt++);			//유저정보 시트생성
} 

////////////////////////////////////////////////////////////////////////////////
//시트 로드
////////////////////////////////////////////////////////////////////////////////
function loadSheet() {
	
	createIBSheet2(document.getElementById("sheet"),"sheet", "100%", "300px");
	
	var gridTitle ="NO";
	gridTitle +="|상태";
	gridTitle +="|통계구분";
	gridTitle +="|통계메타 ID";
	gridTitle +="|한글통계메타명";
	gridTitle +="|영문통계메타명";
	gridTitle +="|담당부서";
	gridTitle +="|출력순서";
	gridTitle +="|사용여부";
	
	with(sheet){
		                     
		var cfg = {SearchMode:2,Page:50,VScrollMode:1};
	    SetConfig(cfg);
	    var headers = [
	                {Text:gridTitle, Align:"Center"}
	            ];
	    var headerInfo = {Sort:0,ColMove:1,ColResize:1,HeaderCheck:0};
	    
	    InitHeaders(headers, headerInfo);
	   
	    var cols = [
	                 {Type:"Seq",		SaveName:"seq",			Width:30,	Align:"Center",		Edit:false}
	                ,{Type:"Status",	SaveName:"status",		Width:30,	Align:"Center",		Edit:false} 
					,{Type:"Text",		SaveName:"sttsNm",		Width:100,	Align:"Center",		Edit:false}
					,{Type:"Text",		SaveName:"statId",		Width:110,	Align:"Center",		Edit:false}
					,{Type:"Html",		SaveName:"statNm",		Width:250,	Align:"Left",		Edit:false}
					,{Type:"Text",		SaveName:"engStatNm",	Width:200,	Align:"Left",		Edit:false}
					,{Type:"Text",		SaveName:"orgNm",		Width:100,	Align:"Center",		Edit:false}
					,{Type:"Number",	SaveName:"vOrder",		Width:80,	Align:"Center",		Edit:false,	Hidden:true}
					,{Type:"Combo",		SaveName:"useYn",		Width:80,	Align:"Center",		Edit:false, TrueValue:"N", FalseValue:"Y"}
	            ];                                          
	    InitColumns(cols);
	    FitColWidth();
	    SetExtendLastCol(1);
	    
	    initSheetOptions("sheet", 0, "useYn", 		[{code:"Y", name:"사용"}, {code:"N", name:"미사용"}]);
	}               
	default_sheet(sheet);   
	
}

//유저 시트 생성
function loadUsrSheet(sheetNm, sheetObj) {
	
	var gridTitle ="NO";
	gridTitle +="|상태";
	gridTitle +="|삭제";
	gridTitle +="|통계표ID";
	gridTitle +="|조직코드";
	gridTitle +="|조직명";
	gridTitle +="|직원코드";
	gridTitle +="|직원명";
	gridTitle +="|대표여부";
	gridTitle +="|업무권한";
	gridTitle +="|출처표시";
	gridTitle +="|사용여부";
	
	with(sheetObj){
		                     
		var cfg = {SearchMode:2,Page:50,VScrollMode:1};
	    SetConfig(cfg);
	    var headers = [
	                {Text:gridTitle, Align:"Center"}
	            ];
	    var headerInfo = {Sort:0,ColMove:1,ColResize:1,HeaderCheck:0};
	    
	    InitHeaders(headers, headerInfo);
	   
	    var cols = [
	                 {Type:"Seq",		SaveName:"seq",				Width:30,	Align:"Center",		Edit:false}
	                ,{Type:"Status",	SaveName:"status",			Width:40,	Align:"Center",		Edit:false} 
	                ,{Type:"DelCheck",	SaveName:"del",				Width:30,	Align:"Center",		Edit:true}
					,{Type:"Text",		SaveName:"statblId",		Width:30,	Align:"Center",		Edit:true,	Hidden:true}
					,{Type:"Text",		SaveName:"orgCd",			Width:30,	Align:"Left",		Edit:true,	Hidden:true}
					,{Type:"Popup",		SaveName:"orgNm",			Width:100,	Align:"Left",		Edit:true,	KeyField: 1}
					,{Type:"Text",		SaveName:"usrCd",			Width:50,	Align:"Left",		Edit:true,	Hidden:true}
					,{Type:"Popup",		SaveName:"usrNm",			Width:100,	Align:"Left",		Edit:true}
					,{Type:"Radio",		SaveName:"rpstYn",			Width:30,	Align:"Center",		Edit:true, TrueValue:"Y", FalseValue:"N",  Sort:false}
					,{Type:"Combo",		SaveName:"prssAccCd",		Width:80,	Align:"Center",		Edit:true,	KeyField: 1}
					,{Type:"CheckBox",	SaveName:"srcViewYn",		Width:30,   Align:"Center",		TrueValue:"Y", FalseValue:"N",Edit:true}
					,{Type:"CheckBox",	SaveName:"useYn",			Width:30,   Align:"Center",		TrueValue:"Y", FalseValue:"N",Edit:true}
	            ];
	    
	    
	    InitColumns(cols);
	    FitColWidth();
	    SetExtendLastCol(1);
	    loadSheetOptions(sheetNm, 0, "prssAccCd", "/admin/stat/ajaxOption.do", {grpCd:"S2001"});
	    
	}               
	default_sheet(sheetObj);   
	
	doActionUsrSheet("search");		//조회
}
////////////////////////////////////////////////////////////////////////////////
//시트 서비스 함수
////////////////////////////////////////////////////////////////////////////////
function sheet_OnDblClick(row, col, value, cellx, celly) {
	if(row < 1) return;                                         
	    tabEvent(row);
}

function sheet_OnSearchEnd(code, message, statusCode, statusMessage) {
	//조회 후 순서관련 버튼 숨김
	var formObj = $("form[name=statSttsForm]");
	if ( com.wise.util.isBlank(formObj.find("input[name=searchVal]").val()) 
			&& com.wise.util.isBlank(formObj.find("select[name=searchUityCd]").val()) 
			&& com.wise.util.isBlank(formObj.find("input[name=orgCd]").val())  ) {
		formObj.find("a[name=a_treeUp], a[name=a_treeDown], a[name=a_vOrderSave]").show();
	} else {
		formObj.find("a[name=a_treeUp], a[name=a_treeDown], a[name=a_vOrderSave]").hide();
	}
}

//유저 탭 Sheet 생성
function usrSheetCreate(SheetCnt){       
 	var sheetNm = "usrSheet"+SheetCnt;  
 	$("div[name=statUsrSheet]").eq(1).attr("id","DIV_"+sheetNm);                                          
 	createIBSheet2(document.getElementById("DIV_"+sheetNm),sheetNm, "100%", "200px");               
 	var sheetobj = window[sheetNm]; 
 	var objTab = getTabShowObj();//탭이 oepn된 객체가져옴
 	var formObj = objTab.find("form[name=sttsStat-dtl-form]");
 	formObj.find("input[name=usrSheetNm]").val(sheetNm);
 	loadUsrSheet(sheetNm, sheetobj);
 	window[sheetNm+ "_OnPopupClick"] = usrSheetOnPopupClick		//시트 팝업클릭
 	//window[sheetNm + "_OnValidation"] = usrSheetOnValidation;	//시트 Validation(시트 기능으로 대체)
}

//시트 팝업클릭 이벤트
function usrSheetOnPopupClick(Row, Col){
	var objTab = getTabShowObj();//탭이 oepn된 객체가져옴
	var formObj = objTab.find("form[name=sttsStat-dtl-form]");
	var usrSheetNm = formObj.find("input[name=usrSheetNm]").val();
	var usrSheetObj = window[usrSheetNm];
	
	if ( usrSheetObj.ColSaveName(Col) == "orgNm" ) {	//조직명 클릭
		window.open(com.wise.help.url("/admin/basicinf/popup/commOrg_pop.do") + "?orgNmGb=7&sheetNm="+usrSheetNm+"", "list" ,"fullscreen=no, width=500, height=550"); 
	} else if ( usrSheetObj.GetCellValue(Row, "orgNm") != "" && usrSheetObj.ColSaveName(Col) == "usrNm" ) {
		window.open(com.wise.help.url("/admin/basicinf/popup/commUsrPos_pop.do") + "?usrGb=4&sheetNm="+usrSheetNm+"&orgCd="+usrSheetObj.GetCellValue(Row, "orgCd") ,"list", "fullscreen=no, width=600, height=550");
	} else {
		alert("먼저 조직명을 선택하세요.");
	}
}
////////////////////////////////////////////////////////////////////////////////
//이벤트 함수
////////////////////////////////////////////////////////////////////////////////
/**
 * 탭 이벤트를 바인딩한다.
 */
function setTabButton() {
	var formObj = getTabFormObj("sttsStat-dtl-form");
	formObj.find("a[name=a_reg]").bind("click", function(event) {
		// 등록
		doAction("insert");
    });
	formObj.find("a[name=a_modify]").bind("click", function(event) {
		// 수정
		doAction("update");
    });
	formObj.find("a[name=a_del]").bind("click", function(event) {
		// 삭제
		doAction("delete");
    });
	formObj.find("button[name=usrAdd]").bind("click", function(e) {
		//인원추가
		doActionUsrSheet("addRow");
	});
	formObj.find("button[name=statMeta_pop]").bind("click", function(e) {
		//통계설명 팝업
		doAction("statMetaExpPop");
	});
	//사용여부 클릭시
	formObj.find("input[name=useYn]").bind("click", function(e) {
		//공개된 통계표 수 공백일경우 데이터 가져온다
		if ( com.wise.util.isNull( formObj.find("input[name=openStateCnt]").val()) ) {
			doAjax({
				url : "/admin/stat/statSttsOpenStateTblCnt.do",
				params : "statId=" + formObj.find("input[name=statId]").val(),
				callback : function(res) {
					formObj.find("input[name=openStateCnt]").val(res.data.cnt);
				}
			});
		} 
		
		//사용여부 아니오 클릭했을때 공개중인 통계표 있을경우 변경 불가
		if ( $(this).val() == "N" ) {
			if ( Number(formObj.find("input[name=openStateCnt]").val()) > 0 ) {
				alert("공개중인 통계표가 있어 변경 할 수 없습니다");
				formObj.find("input[name=useYn][value=Y]").prop("checked", true);
			}
		}
	});
}

/**
 * 탭 이벤트를 바인딩한다.(동적으로 생성된 selectBox등)
 */
function dynamicTabButton(tab) {
	tab.ContentObj.on("change", "select[name=metatyCd]", function() {
		if ( $(this).val() == "SB" ) {	//메타입력유형코드가 공통코드선택(SB)인 경우
			tab.ContentObj.find("select[name=grpCd] option").attr("disabled", false);	//option 값 활성화
		} else {
			tab.ContentObj.find("select[name=grpCd] option").attr("disabled", true);	//option 값 비활성
			tab.ContentObj.find("select[name=grpCd]").val(tab.ContentObj.find("input[name=preGrpCd]").val());	//이전 option 값(db값) 으로 value 지정
			
		}
	});
}
////////////////////////////////////////////////////////////////////////////////
//Validation 함수
////////////////////////////////////////////////////////////////////////////////
/**
 * 등록/수정 validation 
 */
function saveValidation() {
	var objTab = getTabShowObj();//탭이 oepn된 객체가져옴
	var formObj = objTab.find("form[name=sttsStat-dtl-form]");
	
	if ( com.wise.util.isNull(formObj.find("input[name=statNm]").val()) ) {
		alert("통계 메타명을 입력하세요.");
		formObj.find("input[name=statNm]").focus();
		return false;
	}
	if ( com.wise.util.isNull(formObj.find("input[name=engStatNm]").val()) ) {
		alert("통계 메타명(영문)을 입력하세요.");
		formObj.find("input[name=engStatNm]").focus();
		return false;
	}
	if ( com.wise.util.isNull(formObj.find("select[name=sttsCd]").val()) ) {
		alert("통계구분을 선택하세요.");
		formObj.find("select[name=sttsCd]").focus();
		return false;
	}
	if ( com.wise.util.isNull(formObj.find("input[name=useYn]:checked").val()) ) {
		alert("사용여부를 선택하세요.");
		formObj.find("input[name=useYn]").eq(0).focus();
		return false;
	}
	
	return true;
}


//인원정보 등록 전 validation
function usrSheetValidation(sheetObj) {
	// 인원정보 입력확인
	if ( sheetObj.RowCount() == 0 ) {
		alert("인원정보를 입력하세요.");
		return false;
	}
	
	sheetObj.ExtendValidFail = 0;
	var sheetJson = sheetObj.GetSaveJson({AllSave:true, ValidKeyField: 1});
	var rpstYns = "";	// 분류정보 대표여부 체크
	
	if (sheetJson.Code) {
        switch (sheetJson.Code) {
            case "IBS000":
                alert("저장할 내역이 없습니다.");
                break;
            case "IBS010":
            case "IBS020":
                // Nothing to do.
                break;
        }
        return false;
    }
	
	// 대표여부 체크여부
	for ( var i=1; i <= sheetObj.RowCount(); i++ ) {
		if ( sheetObj.GetCellValue(i, "status") !== "D" ) {	// 삭제하는 행은 제외
			rpstYns = rpstYns + sheetObj.GetCellValue(i, "rpstYn");
		}
	}
	if ( rpstYns.indexOf('Y') == -1 ) {
		alert("대표자(대표여부)를 선택하세요.");
		return false;
	}
	
	return true;
}

//인원정보 등록 전 validation
function usrSheetOnValidation(Row, Col, Value) {
	var objTab = getTabShowObj();//탭이 oepn된 객체가져옴
	var formObj = objTab.find("form[name=sttsStat-dtl-form]");
	var usrSheetNm = formObj.find("input[name=usrSheetNm]").val();
	var usrSheetObj = window[usrSheetNm];
	
	switch(Col) {
		case usrSheetObj.SaveNameCol("orgCd") : 
			if ( usrSheetObj.GetCellValue(Row, Col) == "" ) {
				alert("조직을 선택하세요.");
				usrSheetObj.ValidateFail(1);
				usrSheetObj.SelectCell(Row, usrSheetObj.SaveNameCol("orgNm"));
			}
			break;
		case usrSheetObj.SaveNameCol("usrCd") :
			if ( usrSheetObj.GetCellValue(Row, Col) == "" ) {
				alert("직원을 선택하세요.");
				usrSheetObj.ValidateFail(1);
				usrSheetObj.SelectCell(Row, usrSheetObj.SaveNameCol("usrNm"));
			}
			break;
	}
}

/**
 * tab form 동적 validation 추가
 */
function formValidation() {
	var formObj = getTabFormObj("sttsStat-dtl-form");
	formObj.validate({
        onfocusout: false,
        errorPlacement: function (error, element) {
            // $(element).removeClass('error');
            // do nothing;
        }, invalidHandler: function (form, validator) {
            var errors = validator.numberOfInvalids();
            if (errors) {
                alert(validator.errorList[0].message);
                validator.errorList[0].element.focus();
            }
        }, submitHandler: function (form) {
        	//doAction("update");
        	return false;
        }
    });	
	
}
