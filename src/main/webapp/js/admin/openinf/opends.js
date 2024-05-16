/*
 * @(#)opends.js 1.0 2017/10/11
 * 
 * COPYRIGHT (C) 2013 WISEITECH CO., LTD. ALL RIGHTS RESERVED.
 */

/**
 * 관리자 데이터셋 관리 신규 화면 파일이다
 *
 * @author 김정호
 * @version 1.0 2017/10/11
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
	/* 메인 시트 로드 */
	loadSheet();
	/* 항목정보 시트 로드 */
	loadDsColSheet();
	/* 담당자정보 시트 로드 */
	loadUsrSheet();
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
	var mainFormObj = $("form[name=adminOpenDs]");		//메인 폼
	var formObj = $("form[name=adminOpenDsDtl]");		//상세 폼
	//조회
	mainFormObj.find("button[name=btn_inquiry]").bind("click", function(event) {
		doAction("search");
    });
	//조회 enter
	mainFormObj.find("input[name=searchVal]").bind("keydown", function(event) {
        // 엔터키인 경우
        if (event.which == 13) {
        	doAction("search");
            return false;
        }
    });
	mainFormObj.find("button[name=btn_reg]").bind("click", function(e) {
		//등록 
		doDsColAction("reg");
	});
	
	formObj.find("button[name=btn_import]").bind("click", function(e) { 
		//불러오기
		doDsColAction("bring");
	});
	formObj.find("a[name=a_up]").bind("click", function(e) { 
		// 위로이동
		doDsColAction("treeUp");               
	});     
	formObj.find("a[name=a_down ]").bind("click", function(e) { 
		// 아래로이동
		doDsColAction("treeDown");               
	});
	formObj.find("button[name=dsSearch ]").bind("click", function(e) { 	
		//데이터셋 ID 팝업
		doDsColAction("openDsPop");               
	}); 
	formObj.find("button[name=dtSearch ]").bind("click", function(e) { 	
		//보유데이터 팝업
		doDsColAction("openDtPop");               
	});  
	formObj.find("button[name=btSearch ]").bind("click", function(e) { 	
		//백업테이블 팝업
		doDsColAction("backDsPop");               
	});
	formObj.find("a[name=a_init]").bind("click", function(e) {
		//초기화
 		doDsColAction("init");          
 	});
	formObj.find("button[name=dsColAdd]").bind("click", function(e) {
		//항목 행 신규추가
		doDsColAction("addDsRow");
	});
	formObj.find("button[name=usrAdd]").bind("click", function(e) {
		//인원추가 
		doDsColAction("addUsrRow");
	});
	formObj.find("a[name=a_reg]").bind("click", function(e) {
		//등록 
		doDsColAction("insert");
	});
	formObj.find("a[name=a_modify]").bind("click", function(e) {
		//수정 
		doDsColAction("update");
	});
	formObj.find("a[name=a_del]").bind("click", function(e) {
		//삭제
		doDsColAction("delete");
	});
	formObj.find("#initSetLoad").bind("click", function(e) {
		//초기설정방식 불러오기 선택했을 경우
		setInit("L");
	});
	formObj.find("#initSetNew").bind("click", function(e) {
		//초기설정방식 신규생성 선택했을 경우
		setInit("C");
	});
	formObj.find("button[name=btn_dsDup]").bind("click", function(e) {
		//초기설정방식 신규생성 선택했을 경우
		doDsColAction("dupDsId");
	});
	formObj.find("input[name=dsNm]").keyup(function(e) {
		//데이터셋명 영문 체크
		ComInputKorObj(formObj.find("input[name=dsNm]"));
		return false;
	});	
	formObj.find("select[name=conntyCd]").bind("change", function(e) {
		if ( $(this).val() == "UI" ) {
			formObj.find("select[name=lddataCd]").show();		//데이터 저장구분
			formObj.find("#autoAccYnSpan").show();	//데이터 자동저장
		} else {
			formObj.find("select[name=lddataCd]").hide().val("");
			formObj.find("#autoAccYnSpan").hide();
		}
	});
	
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
	doAction("search");
}

////////////////////////////////////////////////////////////////////////////////
// 서비스 함수
////////////////////////////////////////////////////////////////////////////////
function doAction(sAction) {
	var mainFormObj = $("form[name=adminOpenDs]");		//메인 폼
	switch(sAction) {  
		case "search":
			ajaxBeforeSendAdmin(com.wise.help.url("/admin/ajaxBeforeSendAdmin.do")); //IbSheet 조회전 세션 체크
			//var param = {PageParam: "ibpage", Param: "onepagerow=50&"+mainFormObj.serialize()};
			var param = {PageParam: "ibpage", Param: "onepagerow=50"+"&"+mainFormObj.serialize()};  
			mySheet.DoSearchPaging(com.wise.help.url("/admin/openinf/opends/openDsList.do"), param);
			$('html, body').animate({scrollTop : 0}, 100);	//최상위로
			break; 
	}
}

/**
 * 항목정보 액션
 */
function doDsColAction(sAction) {
	var formObj = $("form[name=adminOpenDsDtl]");
	var dsColSheet = window["dsColSheet"];
	var usrSheet = window["usrSheet"];

	switch(sAction) {                       
		case "searchDsCol":
			var dsIdVal = formObj.find("[name=dsId]").val();
			var param = {PageParam: "ibpage", Param: "onepagerow=50"+"&"+"dsId="+dsIdVal};
			dsColSheet.DoSearchPaging(com.wise.help.url("/admin/openinf/opends/openDsColList.do"), param);
			break;
		case "searchDsUsr" :
			var dsIdVal = formObj.find("[name=dsId]").val();
			var param = {PageParam: "ibpage", Param: "onepagerow=50"+"&"+"dsId="+dsIdVal};
			usrSheet.DoSearchPaging(com.wise.help.url("/admin/openinf/opends/openDsUsrList.do"), param);
			break;
		case "bring":			//불러오기
			//LoadDetail(gridObj);
			var owner = formObj.find("[name=ownerCd]").val();
			var tableName = formObj.find("[name=dsId]").val();
			
			if(owner == "" || tableName == ""){
				alert("데이터셋ID를 입력해주세요.");
				return false;
			}
			//데이터셋 테이블이 실제 존재하는지 체크
			var rtn = existSrcDsId(owner, tableName);
			if ( !rtn )	{
				return false;
			}
			
			var param = {PageParam: "ibpage", Param: "onepagerow=50"+"&owner="+owner+"&tableName="+tableName};         
			dsColSheet.DoSearchPaging(com.wise.help.url("/admin/openinf/opends/openDsSrcColList.do"), param);
			break; 
		case "reg" :
			setInit("C");
			break;
		case "insert" :
			if ( saveValidation("I") ) {
				if ( !confirm("등록 하시겠습니까? ") ) {
					return false;
	  			}
				transDataCUD("I");
			}
			break;
		case "update" :
			if ( saveValidation("U") ) {
				if ( !confirm("수정 하시겠습니까? ") ) {
					return false;
	  			}
				transDataCUD("U");
			}
			break;
		case "delete" :
			if ( !confirm("삭제 하시겠습니까? ") ) {
				return false;
  			}
			if ( com.wise.util.isBlank(formObj.find("input[name=dsId]").val()) ) {
				alert("데이터셋 ID가 없습니다.");
				return false;
			}
			transDataCUD("D");
			break;
		case "init" : 				//초기화
			setInit("L");
			break;
		case "dupDsId" :
			chkDupDsId();
			break;
		case "addDsRow" :
			var newRow = dsColSheet.DataInsert(-1);			//제일 마지막 행에 추가
			dsColSheet.SetCellValue(newRow, "useYn", true);	//사용여부 기본값 체크
			break;
		case "addUsrRow" :
			var newRow = usrSheet.DataInsert(-1);			//제일 마지막 행에 추가
			usrSheet.SetCellValue(newRow, "useYn", true);	//사용여부 기본값 체크
			break;	
		case "treeUp" :			//위로이동
			gridMoveUpChgVal(dsColSheet, "vOrder");
			break;
		case "treeDown" :		//아래로이동
			gridMoveDownChgVal(dsColSheet, "vOrder");
			break;
		case "openDsPop":		//데이터셋 검색 팝업
	 		OpenWindow(com.wise.help.url("/admin/openinf/opends/popup/openDs_pop.do"),"openDsPop","700","550","yes");
			break;
		case "openDtPop":		//보유데이터 검색 팝업
			OpenWindow(com.wise.help.url("/admin/openinf/opends/popup/openDt_pop.do"),"openDtPop","700","550","yes");
			break;	
		case "backDsPop":		//백업테이블 검색 팝업
	 		OpenWindow(com.wise.help.url("/admin/openinf/opends/popup/backDs_pop.do"),"backDsPop","700","550","yes");
			break;
		case "dataSamplePop":	//데이터셋 정보 팝업
			var dsId = formObj.find("input[name=dsId]").val();                  
			var target = com.wise.help.url("/admin/openinf/opends/popup/opends_samplePop.do");
			var wName = "samplePop";        
			var wWidth = "1024";
			var wHeight = "580"   ;                         
			var wScroll ="no";
			OpenWindow(target+"?dsId="+dsId, wName, wWidth, wHeight, wScroll);      	
			break;
	}
}

/**
 * 초기화
 * @param flag => C : 등록 / U : 수정
 */
function setInit(flag) {
	var formObj = $("form[name=adminOpenDsDtl]");
	
	$("#initTR").show();	//초기설정방식 TABLE <TR> 보기
	$("input[name=initSet][value="+flag+"]").prop("checked", true);
	
	formObj.find("input[name=dtId], input[name=dtNm], input[name=ownerCd], input[name=dsId], input[name=dsNm]").val("");
	formObj.find("input[name=useYn]").val("Y");
	formObj.find("select[name=conntyCd], select[name=loadCd]").val("");
	
	dsColSheet.RemoveAll();	//시트 초기화(컬럼정보)
	usrSheet.RemoveAll();	//시트 초기화(인원정보)
	
	setBtnInit(flag);		//버튼 초기화
	
	setSheetEditable(flag);	//시트 컬럼 수정여부 변경
	
	$('html, body').animate({scrollTop : $("#dtl-area").offset().top}, 100);	//상세정보로 스크롤 이동
}

/**
 * 시트 컬럼 flag에 따라 수정가능여부 변경
 * @param flag => C : 등록 / L : 불러오기모드 / U : 수정(시트 더블클릭)
 */
function setSheetEditable(flag) {
	var dsColSheet = window["dsColSheet"];
	//flag에 따라 하위 컬럼 수정방식 변경
	if ( flag == "C" ) {	//신규 생성일때 수정 가능
		dsColSheet.SetColEditable("srcColType", true);	//컬럼형식
		dsColSheet.SetColEditable("srcColSize", true);	//길이
		dsColSheet.SetColEditable("srcColScale",true);	//소수점
		dsColSheet.SetColEditable("pkYn", 		true);	//고유키
	} else {
		dsColSheet.SetColEditable("srcColType", false);
		// 수정일때 수정가능하도록 변경
		dsColSheet.SetColEditable("srcColSize", false);
		dsColSheet.SetColEditable("srcColScale",false);
		dsColSheet.SetColEditable("pkYn", 		false);
	}
}

/**
 * 버튼 컬럼 flag에 따라 초기화
 * @param flag => C : 등록 / L : 불러오기모드 / U : 수정(시트 더블클릭)
 */
function setBtnInit(flag) {
	var formObj = $("form[name=adminOpenDsDtl]");
	$(".buttons").show();	//버튼 div 영역 보여준다
	$(".buttons > a").each(function() {
		$(this).hide();
	});
	
	formObj.find("select[name=ownerCd] option").attr("disabled", false);
	
	//신규 생성일 때
	if ( flag == "C" ) {
		//등록, 컬럼추가, 데이터 자동승인 체크
		formObj.find("a[name=a_reg], button[name=dsColAdd], button[name=btn_dsDup]").show();
		formObj.find("a[name=a_modify], button[name=btn_import], button[name=dsSearch], tr[name=bcpTblTR]").hide();				//수정, 불러오기, 검색버튼, 백업테이블 숨기기	
		formObj.find("input[name=dsId]").removeClass("readonly").attr("readonly", false);	//데이터셋ID 활성화
		formObj.find("select[name=ownerCd]").val("")										//데이터셋 owner 비활성화
		formObj.find("#ibHeadDsColLabel").hide();	//항목정보 도움말 숨김
		formObj.find("input[name=dupChk]").val("");	//중복체크 초기화
	} 
	//불러오기
	else if ( flag == "L" ) {
		//초기화, 수정, 데이터셋정보, 컬럼불러오기, 데이터셋검색버튼 화면 표시
		//formObj.find("a[name=a_init], a[name=a_up], a[name=a_down], a[name=a_modify], a[name=a_del], a[name=a_dataSample], button[name=btn_import], button[name=dsSearch], tr[name=bcpTblTR]").show();
		formObj.find("a[name=a_init], a[name=a_reg], a[name=a_dataSample], button[name=btn_import], button[name=dsSearch], tr[name=bcpTblTR]").show();
		//수정, 컬럼추가, 데이터셋ID중복체크 숨김
		formObj.find("a[name=a_modify], button[name=dsColAdd], button[name=btn_dsDup]").hide();
		formObj.find("input[name=dsId]").val("").addClass("readonly").attr("readonly", true);	//데이터셋ID 비활성화
		formObj.find("#ibHeadDsColLabel").show();	//항목정보 도움말 표시
		formObj.find("input[name=dupChk]").val("Y");	//불러오기 할때는 중복체크 하지 않음
	} 
	else {
		//초기화, 수정, 위로이동, 아래로이동, 데이터셋정보, 컬럼불러오기, 데이터셋검색버튼, ID중복체크 화면 표시
		formObj.find("a[name=a_init], a[name=a_up], a[name=a_down], a[name=a_modify], a[name=a_del], a[name=a_dataSample], button[name=btn_import], button[name=dsSearch], tr[name=bcpTblTR]").show();
		//컬럼추가, 중복체크 숨김
		formObj.find("button[name=dsColAdd], button[name=btn_dsDup]").hide();
		formObj.find("input[name=dsId]").val("").addClass("readonly").attr("readonly", true);	//데이터셋ID 비활성화
		formObj.find("#ibHeadDsColLabel").show();	//항목정보 도움말 표시
		formObj.find("input[name=dupChk]").val("");	//중복체크 초기화
		setSheetEditable(false);	//시트 비활성화(컬럼형식, 길이 등)
	}
}

/**
 * 데이터셋 ID 중복체크(신규 등록일때)
 */
function chkDupDsId() {
	var formObj = $("form[name=adminOpenDsDtl]");
	var data = beforeCheckDupDsId();
	if ( data ) {
		$.ajax({
			url: com.wise.help.url("/admin/openinf/opends/dupDsId.do"),
			type: 'POST', 
			data: data,
			dataType: 'json',
			beforeSend: function(obj) {
			}, // 서버 요청 전 호출 되는 함수 return false; 일 경우 요청 중단
			success: function(res) {
				if ( res.resultCnt > 0 ) {
					alert("중복되는 ID가 있습니다.\n다른 데이터셋 ID를 선택하거나 입력해 주세요.");
					formObj.find("input[name=dsId]").focus();
					formObj.find("#dupChk").val("N");
				} else {
					alert("사용가능한 ID 입니다.");
					formObj.find("input[name=dsId]").attr("readonly", true).val(data.dsId);
					formObj.find("#dupChk").val("Y");
				}
			}, // 요청 완료 시
			error: function(request, status, error) {
				handleError(status, error);
			}, // 요청 실패.
			complete: function(jqXHR) {} // 요청의 실패, 성공과 상관 없이 완료 될 경우 호출
		});
	}
}

/**
 * 데이터셋 트랜잭션 처리(CUD)
 * @param action	I:등록 / U:수정 / D:삭제
 */
function transDataCUD(action) {
	var formObj = $("form[name=adminOpenDsDtl]");
	var url = "";
	if ( action == "I" ) {
		url = com.wise.help.url("/admin/openinf/opends/insertOpenDsAll.do");
	} else if ( action == "U" ) {
		url = com.wise.help.url("/admin/openinf/opends/saveOpenDsAll.do");
	} else if ( action == "D" ) {
		url = com.wise.help.url("/admin/openinf/opends/deleteOpenDsAll.do");
	}
	
	var datas = formObj.serialize();
	if ( action == "I" || action == "U"  ) {
		//입력/수정은 시트데이터도 읽어 감
		datas = datas
		+ "&ibsSaveJson=" + JSON.stringify(dsColSheet.GetSaveJson({AllSave:true}))
		+ "&ibsSaveJson2=" + JSON.stringify(usrSheet.GetSaveJson({AllSave:true}));
	}
	
	$.ajax({
	    url: url,
	    async: false, 
	    type: 'POST',
	    data: datas,
	    dataType: 'json',
	    beforeSend: function(obj) {
	    }, // 서버 요청 전 호출 되는 함수 return false; 일 경우 요청 중단
	    success: function(data, status, request) {
	    	if ( data.success ) {
	    		alert(data.message);
	    		if ( action == "D" || action == "I" ) {
	    			//삭제 성공, 입력 성공인 경우 페이지 새로 고침
	    			location.href = com.wise.help.url("/admin/openinf/opends/openDsPage.do")
	    		} else {
	    			$("#initTR").hide();			//초기설정방식 TABLE <TR> 숨김
	    			doDsColAction("searchDsCol");	//컬럼항목 재조회
	    			doDsColAction("searchDsUsr");	//인원정보 재조회
	    		}
	    	} else if ( data.error ) {
	    		alert( data.error.message);
	    	}
	    }, // 요청 완료 시
	    error: function(request, status, error) {
	    	handleError(status, error);
	    	alert("처리 도중 에러가 발생하였습니다.");
	    }, // 요청 실패.
	    complete: function(jqXHR) {} // 요청의 실패, 성공과 상관 없이 완료 될 경우 호출
	});
}

/**
 * 데이터셋 테이블이 실제 존재하는지 확인
 * @param owner		스키마
 * @param tableName	테이블명
 */
function existSrcDsId(owner, tableName) {
	var rtn = false;
	$.ajax({
		url: com.wise.help.url("/admin/openinf/opends/selectExistSrcDsId.do"),
		async : false,
		type: 'POST', 
		data: "&owner="+owner+"&tableName="+tableName,
		dataType: 'json',
		beforeSend: function(obj) {
		}, // 서버 요청 전 호출 되는 함수 return false; 일 경우 요청 중단
		success: function(res) {
			if ( res.existCnt == 0 ) {
				alert("신규 생성 데이터셋은 데이터 입력 전까지\n테이블이 생성되지 않아 불러오기 할 수 없습니다");
			} else {
				rtn = true;
			}
		}, // 요청 완료 시
		error: function(request, status, error) {
			handleError(status, error);
		}, // 요청 실패.
		complete: function(jqXHR) {
			return rtn;
		} // 요청의 실패, 성공과 상관 없이 완료 될 경우 호출
	});
	return rtn;
}

////////////////////////////////////////////////////////////////////////////////
// 전처리 함수
////////////////////////////////////////////////////////////////////////////////
function beforeCheckDupDsId() {
	var data = {};
	var formObj = $("form[name=adminOpenDsDtl]");
    $.each(formObj.serializeArray(), function(index, element) {
        switch (element.name) {
        	case "dsId":
            	data[element.name] = element.value.toUpperCase();
            	break;
        }
    });
    
    if ( data.dsId == "" ) {
        alert("데이터셋ID를 입력해 주세요.");
        return null;
    }
    return data;
}
////////////////////////////////////////////////////////////////////////////////
// 후처리 함수
////////////////////////////////////////////////////////////////////////////////
/**
 * 상세정보 콜백(폼에 데이터 입력)
 */
function dtlCallback(json){
	if(json.DATA != null){
		var formObj = $("form[name=adminOpenDsDtl]");
		$.each(json.DATA[0],function(key,state){
			if(key == "useYn"){
				formObj.find("input:radio[name=useYn][value="+state+"]").prop("checked", true);
			}else if(key == "ownerCd"){
				formObj.find("[name=ownerCd]").val(state);
				formObj.find("select[name=ownerCd] option:not([value="+state+"])").attr("disabled", true);				//데이터셋 owner 비활성화(수정불가)
			}else if(key == "dsCd"){
				formObj.find("input:radio[name=dsCd][value="+state+"]").prop("checked", true);
			}else if(key == "dtNm"){
				formObj.find("[name=dtNm]").attr("class","readonly");
				formObj.find("[name="+key+"]").val(state);
			}else if(key == "dsId"){
				formObj.find("[name=dsId]").attr("class","readonly");
				formObj.find("[name="+key+"]").val(state);
			}else if(key == "bcpDsId"){
				formObj.find("[name=bcpDsId]").attr("class","readonly");
				formObj.find("[name="+key+"]").val(state);
			}else if(key == "keyDbYn"){
				formObj.find("input:radio[name=keyDbYn][value="+state+"]").prop("checked","checked");
			}else if(key == "stddDsYn"){
				formObj.find("input:radio[name=stddDsYn][value="+state+"]").prop("checked","checked");
			}else if(key == "autoAccYn"){
				formObj.find("input[name=autoAccYn]").prop("checked", (state == "Y" ? true : false));
			}else if(key == "conntyCd"){
				formObj.find("[name="+key+"]").val(state);
				if ( state == "UI" ) {
					formObj.find("select[name=lddataCd], #autoAccYnSpan").show();	//연계방식이 사용자 직적입력일경우 데이터입력저장구분, 데이터 자동승인 표시
				} else {
					formObj.find("select[name=lddataCd], #autoAccYnSpan").hide();
				}
			}
			else{		
				formObj.find("[name="+key+"]").val(state);
			}
		});  
	}
}

////////////////////////////////////////////////////////////////////////////////
//시트 로드
////////////////////////////////////////////////////////////////////////////////
function loadSheet() {
	var gridTitle1 = "NO";
	gridTitle1 +="|OWNER";
	gridTitle1 +="|데이터셋ID";
	gridTitle1 +="|데이터셋명";
	gridTitle1 +="|보유데이터ID";
	gridTitle1 +="|보유데이터명";
	gridTitle1 +="|국가중점DB";
	gridTitle1 +="|행자부표준DB";
	gridTitle1 +="|사용여부";

	with(mySheet){
		var cfg = {SearchMode:3,Page:50,VScrollMode:1};                                
	    SetConfig(cfg);  
	    var headers = [                               
	                {Text:gridTitle1, Align:"Center"}                 
	            ];
	    var headerInfo = {Sort:1,ColMove:1,ColResize:1,HeaderCheck:0};
	    
	    InitHeaders(headers, headerInfo); 
	     
	    var cols = [          
					 {Type:"Seq",			SaveName:"seq",			Width:50,	Align:"Center",	Edit:false,	Sort:false}
					,{Type:"Text",			SaveName:"ownerCd",		Width:170,	Align:"Left",	Edit:false}
					,{Type:"Text",			SaveName:"dsId",		Width:200,	Align:"Left",	Edit:false}
					,{Type:"Text",			SaveName:"dsNm",		Width:280,	Align:"Left",	Edit:false}
					,{Type:"Text",			SaveName:"dtId",		Width:0,	Align:"Left",	Edit:false, Hidden:true}
					,{Type:"Text",			SaveName:"dtNm",		Width:280,	Align:"Left",	Edit:false}
					,{Type:"Combo",			SaveName:"keyDbYn",		Width:80,	Align:"Center",	Edit:false}
					,{Type:"Combo",			SaveName:"stddDsYn",	Width:80,	Align:"Center",	Edit:false}
					,{Type:"CheckBox",		SaveName:"useYn",		Width:50,	Align:"Center",	TrueValue:"Y", FalseValue:"N", Edit:false}
	            ];       
	                                  
	    InitColumns(cols);     
	    FitColWidth();
	    SetExtendLastCol(1);   
	    initSheetOptions("mySheet", 0, "keyDbYn", [{code:"Y",name:"예"}, {code:"N",name:"아니오"}]);
	    initSheetOptions("mySheet", 0, "stddDsYn", [{code:"Y",name:"예"}, {code:"N",name:"아니오"}]);
	}
    default_sheet(mySheet);
}

/**
 * 컬럼항목정보 시트 로드
 */
function loadDsColSheet(){
	createIBSheet2(document.getElementById("dsColSheet"),"dsColSheet", "100%", "300px");
	
	var gridTitle = "NO|상태|삭제|컬럼고유번호|순서";
		gridTitle += "|컬럼ID";
		gridTitle += "|컬럼명";
		//gridTitle += "|실제컬럼ID";
		gridTitle += "|컬럼형식";
		gridTitle += "|길이";
		gridTitle += "|소수점";
		gridTitle += "|데이터셋ID";
		gridTitle += "|컬럼검증유형";
		gridTitle += "|단위";
		gridTitle += "|컬럼유형";
		gridTitle += "|컬럼참조코드";
		gridTitle += "|고유키";
		gridTitle += "|필수\n입력";
		gridTitle += "|주석";
		gridTitle += "|사용\n여부";
	   
		with(dsColSheet){
	      
			var cfg = {SearchMode:2,Page:50,VScrollMode:1};                                
			SetConfig(cfg);  
			var headers = [                               
	                  {Text:gridTitle, Align:"Center"}                 
	              ];
			var headerInfo = {Sort:1,ColMove:1,ColResize:1,HeaderCheck:1};
	      
			InitHeaders(headers, headerInfo); 
			SetEditable(1); 
			
			var cols = [   
	                {Type:"Seq",		SaveName:"seq",				Width:40,	Align:"Center",		Edit:false,	Sort:false}  
	               ,{Type:"Status",   	SaveName:"status",			Width:30,   Align:"Center",     Edit:false}
	               ,{Type:"DelCheck",  	SaveName:"delChk",      	Width:40,   Align:"Center",     Edit:true}
	               ,{Type:"Text",      	SaveName:"colSeq",      	Width:40,  	Align:"Center",     Edit:false }
	               ,{Type:"Int",      	SaveName:"vOrder",      	Width:30,   Align:"Center",     Edit:false,	Hidden:false}
	               ,{Type:"Text",     	SaveName:"colId",       	Width:120,  Align:"Left",      	Edit:true, 	KeyField:1,	AcceptKeys:"N|E|[_]",	InputCaseSensitive:1, MaximumValue:4000} 
	               ,{Type:"Text",      	SaveName:"colNm",           Width:120,  Align:"Left",      	Edit:true, 	KeyField:1}
	               //,{Type:"Text",      	SaveName:"srcColId",    	Width:100,  Align:"Left",      Edit:false , KeyField:1}
	               ,{Type:"Combo",      SaveName:"srcColType",  	Width:80,  	Align:"Center",     Edit:false}
	               ,{Type:"Int",      	SaveName:"srcColSize",  	Width:40,   Align:"Right",     	Edit:true}
	               ,{Type:"Int",      	SaveName:"srcColScale", 	Width:40,   Align:"Right",     	Edit:true}
	               ,{Type:"Text",      	SaveName:"dsId",            Width:10,  	Align:"Center",     Edit:false, Hidden:true}
	               ,{Type:"Combo",      SaveName:"verifyId",        Width:70,   Align:"Center",     Edit:true}
	               ,{Type:"Combo",      SaveName:"unitCd",          Width:50,   Align:"Center",     Edit:true}
	               ,{Type:"Combo",      SaveName:"addrCd",          Width:60,   Align:"Center",     Edit:true}
	               ,{Type:"Combo",   SaveName:"colRefCd",         	Width:50,   Align:"Center",     Edit:true}
	               ,{Type:"CheckBox",   SaveName:"pkYn",         	Width:50,   Align:"Center",     TrueValue:"Y", FalseValue:"N", Edit:false}
	               ,{Type:"CheckBox",   SaveName:"needYn",         	Width:50,   Align:"Center",     TrueValue:"Y", FalseValue:"N", Edit:true}
	               ,{Type:"Text",       SaveName:"colExp",          Width:100,  Align:"Left",      	Edit:true} 
	               ,{Type:"CheckBox",   SaveName:"useYn",         	Width:50,   Align:"Center",     TrueValue:"Y", FalseValue:"N", Edit:true}
	              ];         
	                                    
			InitColumns(cols);                                                                           
			FitColWidth();                                                         
			SetExtendLastCol(1);   
			loadSheetOptions("dsColSheet", 0, "srcColType", "/admin/stat/ajaxOption.do", {grpCd:"D2006"});		//컬럼유형
			loadSheetOptionsAddDatas("dsColSheet", 0, "verifyId", "/admin/openinf/opends/selectOpenDscoltyCd.do", null, [{code:"", name:""}]);	//검증유형	
			loadSheetOptionsAddDatas("dsColSheet", 0, "colRefCd", "/admin/stat/ajaxOption.do", {grpCd:"D2009"}, [{code:"", name:""}]);			//컬럼참조코드
			loadSheetOptionsAddDatas("dsColSheet", 0, "unitCd", "/admin/stat/ajaxOption.do", {grpCd:"D1013"}, [{code:"", name:""}]);			//단위
			loadSheetOptionsAddDatas("dsColSheet", 0, "addrCd", "/admin/stat/ajaxOption.do", {grpCd:"D1103"}, [{code:"", name:""}]);			//컬럼유형
			
	   }
	   default_sheet(dsColSheet);
}

/**
 * 담당자정보 시트 로드
 */
function loadUsrSheet(){
	createIBSheet2(document.getElementById("usrSheet"),"usrSheet", "100%", "150px");
	
	var gridTitle ="NO";
	gridTitle +="|상태";
	gridTitle +="|삭제";
	gridTitle +="|통계표ID";
	gridTitle +="|조직코드";
	gridTitle +="|조직명";
	gridTitle +="|직원코드";
	gridTitle +="|직원명";
	gridTitle +="|업무권한";
	gridTitle +="|사용여부";
	   
		with(usrSheet){
	      
			var cfg = {SearchMode:2,Page:50,VScrollMode:1};                                
			SetConfig(cfg);  
			var headers = [                               
	                  {Text:gridTitle, Align:"Center"}                 
	              ];
			var headerInfo = {Sort:1,ColMove:1,ColResize:1,HeaderCheck:0};
	      
			InitHeaders(headers, headerInfo); 
			SetEditable(1); 
			
			var cols = [
		                 {Type:"Seq",		SaveName:"seq",				Width:30,	Align:"Center",		Edit:false}
		                ,{Type:"Status",	SaveName:"status",			Width:40,	Align:"Center",		Edit:false} 
		                ,{Type:"DelCheck",	SaveName:"del",				Width:30,	Align:"Center",		Edit:true}
						,{Type:"Text",		SaveName:"statblId",		Width:30,	Align:"Center",		Edit:true,	Hidden:true}
						,{Type:"Text",		SaveName:"orgCd",			Width:30,	Align:"Left",		Edit:true,	Hidden:true}
						,{Type:"Popup",		SaveName:"orgNm",			Width:100,	Align:"Left",		Edit:true}
						,{Type:"Text",		SaveName:"usrCd",			Width:50,	Align:"Left",		Edit:true,	Hidden:true}
						,{Type:"Popup",		SaveName:"usrNm",			Width:100,	Align:"Left",		Edit:true}
						,{Type:"Combo",		SaveName:"prssAccCd",		Width:80,	Align:"Center",		Edit:true}
						,{Type:"CheckBox",	SaveName:"useYn",			Width:30,   Align:"Center",		TrueValue:"Y", FalseValue:"N",Edit:true}
		            ];   
	                                    
			InitColumns(cols);                                                                           
			FitColWidth();                                                         
			SetExtendLastCol(1);   
			loadSheetOptions("usrSheet", 0, "prssAccCd", "/admin/stat/ajaxOption.do", {grpCd:"D2004"});	//업무권한
			
	   }
	   default_sheet(usrSheet);
}

/**
 * 시트에 combobox 추가
 * @param id
 * @param row
 * @param column
 * @param url
 * @param param
 * @param datas
 */
function loadSheetOptionsAddDatas(id, row, column, url, param, datas) {
    // 옵션을 검색한다.
    $.post(
        com.wise.help.url(url),
        param,
        function(data, status, request) {
            if (data.data) {
                // 시트 옵션을 초기화한다.
                initSheetOptions(id, row, column, datas.concat(data.data));
            }
        },
        "json"
    );
}

////////////////////////////////////////////////////////////////////////////////
//시트 서비스 함수
////////////////////////////////////////////////////////////////////////////////
function mySheet_OnDblClick(row, col, value, cellx, celly) {
	if(row < 1) return;
	
	$("#initTR").hide();	//초기설정방식 TABLE <TR> 숨김
	
	$("input[name=initSet][value=L]").prop("checked", true);	//초기설정방식 불러오기로 설정
	/* 버튼 초기화 */
	setBtnInit("U");	//불러오기모드로 버튼 셋(수정모드)
	
	$("button[name=dsSearch]").hide();	//ds id 검색 불가(수정모드)
	
	//폼 내용 조회
	var url = com.wise.help.url("/admin/openinf/opends/openDsDetail.do");
	var param = "dsId= " + mySheet.GetCellValue(row, "dsId");	//데이터셋 ID
	ajaxCallAdmin(url, param, dtlCallback);
	//데이터셋 항목정보 조회
	doDsColAction("searchDsCol");	
	//데이터셋 관리담당자 조회
	doDsColAction("searchDsUsr");	
	
	$('html, body').animate({scrollTop : $("#dtl-area").offset().top}, 100);	//상세정보로 스크롤 이동
}

/**
 * 담당자정보 팝업 클릭
 */
function usrSheet_OnPopupClick(Row, Col){
	var usrSheetNm = "usrSheet";
	var usrSheetObj = window[usrSheetNm];
	if ( usrSheetObj.ColSaveName(Col) == "orgNm" ) {	//조직명 클릭
		window.open(com.wise.help.url("/admin/basicinf/popup/commOrg_pop.do") + "?orgNmGb=7&sheetNm="+usrSheetNm+"", "list" ,"fullscreen=no, width=500, height=550"); 
	} else if ( usrSheetObj.GetCellValue(Row, "orgNm") != "" && usrSheetObj.ColSaveName(Col) == "usrNm" ) {
		window.open(com.wise.help.url("/admin/basicinf/popup/commUsrPos_pop.do") + "?usrGb=4&sheetNm="+usrSheetNm+"&orgCd="+usrSheetObj.GetCellValue(Row, "orgCd") ,"list", "fullscreen=no, width=600, height=550");
	} else {
		alert("먼저 조직명을 선택하세요.");
	}
}

/**
 * 담당자정보 시트 validation 
 */
function usrSheet_OnValidation(Row, Col, Value) {
	var usrSheetNm = "usrSheet";
	var usrSheetObj = window[usrSheetNm];
	
	switch(Col) {
		case usrSheetObj.SaveNameCol("orgCd") : 
			if ( usrSheetObj.GetCellValue(Row, Col) == "" ) {
				alert("조직을 선택하세요.");
				usrSheetObj.ValidateFail(1);
				usrSheetObj.SelectCell(Row, usrSheetObj.SaveNameCol("orgNm"));
			}
			break;
		/*	
		case usrSheetObj.SaveNameCol("usrCd") :
			if ( usrSheetObj.GetCellValue(Row, Col) == "" ) {
				alert("직원을 선택하세요.");
				usrSheetObj.ValidateFail(1);
				usrSheetObj.SelectCell(Row, usrSheetObj.SaveNameCol("usrNm"));
			}
			break;*/
	}
}
////////////////////////////////////////////////////////////////////////////////
//이벤트 함수
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
//Validation 함수
////////////////////////////////////////////////////////////////////////////////
/**
 * 등록/수정 validation 
 */
function saveValidation(sAction) {
	var formObj = $("form[name=adminOpenDsDtl]");
	var dsColSheet = window["dsColSheet"];
	var usrSheetObj = window["usrSheet"];

	if ( sAction == "I" && com.wise.util.isBlank(formObj.find("select[name=ownerCd]").val()) ) {
		alert("OWNER 코드를 선택하세요.");
		formObj.find("select[name=ownerCd]").focus();
		return false;
	}
	if ( com.wise.util.isNull(formObj.find("input[name=dsId]").val()) ) {
		alert("데이터셋 ID를 선택하세요");
		formObj.find("input[name=dsId]").focus();
		return false;
	} 
	if ( sAction == "I" && formObj.find("input[name=dupChk]").val() != "Y" ) {
		alert("데이터셋ID 중복체크 하세요.");
		formObj.find("input[name=dsId]").focus();
		return false;
	}
	if ( com.wise.util.isNull(formObj.find("input[name=dsNm]").val()) ) {
		alert("데이터셋명을 입력하세요");
		formObj.find("input[name=dsNm]").focus();
		return false;
	}
	if ( com.wise.util.isNull(formObj.find("input[name=dtNm]").val()) ) {
		alert("보유데이터명을 입력하세요");
		formObj.find("input[name=dtNm]").focus();
		return false;
	}
	if ( com.wise.util.isNull(formObj.find("select[name=conntyCd]").val()) ) {
		alert("연계방식을 선택하세요");
		formObj.find("select[name=conntyCd]").focus();
		return false;
	}
	if ( com.wise.util.isNull(formObj.find("select[name=loadCd]").val()) ) {
		alert("적재주기를 선택하세요");
		formObj.find("select[name=loadCd]").focus();
		return false;
	}
	if ( formObj.find("select[name=conntyCd]").val() == "UI" && com.wise.util.isBlank(formObj.find("select[name=lddataCd]").val()) ) {
		alert("연계방식이 사용자 직접입력일경우 데이터입력 저장구분을 선택해 주세요");
		formObj.find("select[name=lddataCd]").focus();
		return false;
	}
	if ( !com.wise.util.isBlank(formObj.find("input[name=bcpDsId]").val()) ) {
		//백업테이블명이 선택된 경우 오너 코드 입력되어야 함
		if ( com.wise.util.isBlank(formObj.find("select[name=bcpOwnerCd]").val()) ) {
			alert("백업테이블 OWNER코드를 선택하세요.");
			formObj.find("select[name=bcpOwnerCd]").focus();
			return false;
		}
	}
	
	// 항목정보 sheet validation
	if ( dsColSheet.RowCount() == 0 ) {
		alert("항목정보를 입력해 주세요.");
		return false;
	}
	
	//항목정보 주소컬럼 값 validation
	if ( !dsColSheetValidation(sAction) )	return false;
	
	// 인원정보 sheet validation(연계 방식이 데이터 입력일때 필수)
	if ( formObj.find("select[name=conntyCd]").val() == "UI" ) {
		if ( usrSheetObj.RowCount() == 0 ) {
			alert("인원정보를 입력해 주세요.");
			return false;
		}
	}
	
	if ( usrSheetObj.ColValueDup("usrCd") > 0 ) {
		alert("인원정보 시트에 중복되는 인원이 있습니다.");
		return false;
	}
	return true;
}

/**
 * 컬럼항목정보 주소컬럼 값 validation
 * @returns {Boolean} validation 성공 여부
 */
function dsColSheetValidation(sAction) {
	
	if ( !dsColSheetValidationByColType(sAction) ) 	return false;
	if ( !dsColSheetValidationByAddrCd() ) 		return false;
	if ( !dsUsrSheetValidation() ) 				return false;
	return true;
}

/**
 * 컬럼항목정보 필수값, 컬럼형식 및 컬럼길이 validation
 * @returns {Boolean} validation 성공 여부
 */
function dsColSheetValidationByColType(sAction) {
	var formObj = $("form[name=adminOpenDsDtl]");
	var dsColSheet = window["dsColSheet"];
	
	for ( var i=1; i<=dsColSheet.LastRow(); i++ ) {
		var colId = dsColSheet.GetCellValue(i, "colId");		//컬럼ID
		var colNm = dsColSheet.GetCellValue(i, "colNm");		//컬럼명
		var colType = dsColSheet.GetCellValue(i, "srcColType");								//컬럼형식
		var colSize = dsColSheet.GetCellValue(i, dsColSheet.SaveNameCol("srcColSize"));		//컬럼길이
		var colScale = dsColSheet.GetCellValue(i, dsColSheet.SaveNameCol("srcColScale"));	//컬럼길이(소수점)
		if ( com.wise.util.isBlank(colId) ) {
			alert("컬럼ID를 입력하세요.");
			dsColSheet.SelectCell(i, dsColSheet.SaveNameCol("colId"));
			return false;
		}
		if ( com.wise.util.isBlank(colNm) ) {
			alert("컬럼명을 입력하세요.");
			dsColSheet.SelectCell(i, dsColSheet.SaveNameCol("colNm"));
			return false;
		}
		
		//////////////////////// 등록이고 신규일때만 체크 -> 수정일때도 체크
//		if ( sAction == "I" && formObj.find("input[name=initSet]:checked").val() == "C"  ) {
			if ( !com.wise.util.isInteger(colSize) && ( colType == "VARCHAR" || colType == "CHAR" || colType == "NUMBER" ) ) {
				alert("길이를 입력하세요.");
				dsColSheet.SelectCell(i, dsColSheet.SaveNameCol("srcColSize"));
				return false;
			} 
			if ( colType == "VARCHAR" ) {
				if ( colSize > 4000 ) {
					alert("가변문자열의 길이는 4000자를 초과 할 수 없습니다.");
					dsColSheet.ValidateFail(1);
					dsColSheet.SelectCell(Row, dsColSheet.SaveNameCol("srcColSize"));
					return false;
				}
			} else if ( colType == "CHAR" ) {
				if ( colSize > 256 ) {
					alert("가변문자열의 길이는 256자를 초과 할 수 없습니다.");
					dsColSheet.ValidateFail(1);
					dsColSheet.SelectCell(Row, dsColSheet.SaveNameCol("srcColSize"));
					return false;
				}
			} else if ( colType == "NUMBER" ) {
				if ( colSize > 22 ) {
					alert("숫자인 경우 길이는 22자를 초과 할 수 없습니다.");
					dsColSheet.ValidateFail(1);
					dsColSheet.SelectCell(i, qdsColSheet.SaveNameCol("srcColSize"));
					return false;
				}
				if ( colScale > 22 ) {
					alert("숫자인 경우 소수점은 22자를 초과 할 수 없습니다.");
					dsColSheet.ValidateFail(1);
					dsColSheet.SelectCell(i, qdsColSheet.SaveNameCol("srcColSize"));
					return false;
				}
			} 
			if ( colType != "NUMBER" ) {
				if ( colScale != "" ) {
					alert("숫자인 경우만 소수점 입력하세요.");
					dsColSheet.ValidateFail(1);
					dsColSheet.SelectCell(i, dsColSheet.SaveNameCol("srcColScale"));
					return false;
				}
			}
//		}
		/////////////////////////
		if ( colType == "DATE" ) {
			var verifyTxt = dsColSheet.GetCellText(i, "verifyId");
			if ( verifyTxt.indexOf("[날짜]") == -1 ) {
				alert("날짜 컬럼형식일 경우 컬럼검증유형을 날짜형식으로 선택해 주세요");
				dsColSheet.SelectCell(i, dsColSheet.SaveNameCol("verifyId"));
				return false;
			}
		}
	}
	return true;
}

/**
 * 컬럼항목정보 주소컬럼 중복 체크
 * @returns {Boolean} validation 성공 여부
 */
function dsColSheetValidationByAddrCd() {
	var dsColSheet = window["dsColSheet"];
	var LOTN = 0;
	var ADDR = 0;
	var ROAD = 0;
	var ZIP5 = 0;
	var WGSO = 0;
	var WGSA = 0;
	var chkNo = 0;
	 
	for(var i=1; i<=dsColSheet.LastRow(); i++){
		var chk = dsColSheet.GetCellValue(i, "addrCd");
	 
		if(chk == "LOTN"){
			LOTN++;
			if(LOTN == 2){
				alert("지번주소코드를 중복으로 넣을 수 없습니다.")
				return false;
			}
		}
		if(chk == "ADDR"){
			ADDR++;
			if(ADDR == 2){
				alert("기본주소코드를 중복으로 넣을 수 없습니다.")
				return false;
			}
		 }
		 if(chk == "ROAD"){
			 ROAD++;
			 if(ROAD == 2){
				 alert("도로명주소코드를 중복으로 넣을 수 없습니다.")
				 return false;
			}
		 }
		 if(chk == "ZIP5"){
			 ZIP5++;
			 if(ZIP5 == 2){
				 alert("우편번호코드를 중복으로 넣을 수 없습니다.")
				 return false;
			 }
		 }
		 if(chk == "WGSO"){
			 WGSO++;
			 if(WGSO == 2){
				 alert("경도코드를 중복으로 넣을 수 없습니다.")
				 return false;
			 }
		 }
		 if(chk == "WGSA"){
			 WGSA++;
			 if(WGSA == 2){
				 alert("위도코드를 중복으로 넣을 수 없습니다.")
				 return false;
			 }
		 }
	}
	return true;
}

/**
 * 인원정보 sheet validation
 * @returns {Boolean} validation 성공 여부
 */
function dsUsrSheetValidation() {
	var dsUsrSheet = window["usrSheet"];
	var prssAccCd = "";
	for ( var i=1; i <= dsUsrSheet.RowCount(); i++ ) {
		if ( dsUsrSheet.GetCellValue(i, "prssAccCd") == "" ) {
			alert("업무권한을 선택하세요.");
			return false;
		}
	}
	return true;
}


