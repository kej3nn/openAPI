/*
 * @(#)offlineWriteAccount.js 1.0 2017/07/03
 * 
 * COPYRIGHT (C) 2013 WISEITECH CO., LTD. ALL RIGHTS RESERVED.
 */

/**
 * 오프라인 청구서관리 스크립트 파일이다
 *
 * @author 최성빈
 * @version 1.0 2019/07/30
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
var success = "";  //실명인증여부 

////////////////////////////////////////////////////////////////////////////////
// 초기화 함수
////////////////////////////////////////////////////////////////////////////////
/**
 * 컴포넌트를 초기화한다.
 */
function initComp() {
	tabSet();
	// 표준항목 분류정의 시트 그리드를 생성한다.
	loadSheet();
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
		//조회버튼 클릭시 초기화 
		$("#openAplNo").val("");
		
		var frm = document.statMainForm;
		//============================================
		// 조회시날짜 입력이 안되어 있을면, 현재 날짜로 자동 세팅한다.
		var date = new Date();
		var year = date.getFullYear()+'';
		var month = (date.getMonth()+1)+'';
		var day = date.getDate()+'';
		if(month.length == 1) month = '0'+month;
		if(day.length == 1) day = '0'+day;
		
		var sysdate = year + month + day;
		
		if(!frm.startAplDt.value == '') {
			if(frm.endAplDt.value == '') frm.endAplDt.value = sysdate;
		}
		if(!frm.startDcsNtcDt.value == '') {
			if(frm.endDcsNtcDt.value == '') frm.endDcsNtcDt.value = sysdate;
		}
		//============================================
		
		//조회
		doAction("search");
    });
	$("button[name=btn_reg]").bind("click", function(event) {
		// 신규등록 폼 탭을 추가한다.
		doAction("regForm");
    });
	$("button[name=btn_xlsDown]").bind("click", function(event) {
		//엑셀다운
		doAction("excel");
    });
	$("button[name=btn_printSave]").bind("click", function(event) {
		//출력 및 저장
		fn_print();
    });
	
	//조회 enter
	$("form[name=statMainForm ] input:text").bind("keydown", function(event) {
        // 엔터키인 경우
        if (event.which == 13) {
        	doAction("search");
            return false;
        }
    });
	
	//청구일자 초기화 
	$("button[name=aplDt_reset]").bind("click", function(e) {
		$("input[name=startAplDt], input[name=endAplDt]").val("");
	});
	
	//통지일자 초기화
	$("button[name=dcsNtcDt_reset]").bind("click", function(e) {
		$("input[name=startDcsNtcDt], input[name=endDcsNtcDt]").val("");
	});
	
	//즉시처리건 조회 체크박스 보이기/숨기기 
	$("select[name=prgStatCd]").bind("change", function(event) {
		var val = $(this).val();
		$("input[name=imdDealDiv]").prop("checked",false);   
		
		if(val == "04"){ //처리상태가 결정통지일때
			$("#imdDealDivArea").css("display", "block");
		}else{
			$("#imdDealDivArea").css("display", "none");
		}
	});
	
	
}


/**
 * 옵션을 로드한다.
 */
function loadOptions() {
	//캘린더 초기화
	datePickerInit()
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

/**
 * 화면 액션
 */
function doAction(sAction) {
	var formObj = getTabFormObj("writeAccount-dtl-form");
	var classObj = $("."+tabContentClass);
	var actObj = setTabForm(classObj); // 0: form data, 1: form 객체
	var sheet = window["sheet"];

	switch(sAction) {                       
		case "search":
			ajaxBeforeSendAdmin(com.wise.help.url("/admin/ajaxBeforeSendAdmin.do")); //IbSheet 조회전 세션 체크
			var param = {PageParam: "page", Param: "rows=50"+"&"+actObj[0]};
			sheet.DoSearchPaging(com.wise.help.url("/admin/expose/opnApplyList.do"), param);
			break;
		case "regForm" :
			var title = "신규등록"
			var id ="statReg";
			success = ""; //실명인증여부 초기화
			openTab.addRegTab(id, title, tabCallRegBack);
			break;
		case "insert" :
			saveData("I");
			break;
		case "updOpnApl" :
			var params = "?aplNo=" + formObj.find("input[name=aplNo]").val();
			window.open(com.wise.help.url("/admin/expose/popup/updateOpnAplPopup.do") + params , "list", "fullscreen=no, width=800, height=560, scrollbars=yes");
			break;	
		case "infoRcp" : //접수
			if ( infoRcpValidation() ) {
				if ( !confirm("접수 하시겠습니까?") )	return false;
				formObj.ajaxSubmit({
					url : com.wise.help.url("/admin/expose/insertInfoRcp.do")
					, async : false
					, type : 'post'
					, dataType: 'json' 
					, contentType : 'application/x-www-form-urlencoded;charset=UTF-8'
					, beforeSubmit : function() {
					}	
					, success : function(res, status) {
						doAjaxMsg(res, "");
						afterTabRemove(res)
					}
					, error: function(jqXHR, textStatus, errorThrown) {
						//alert("처리 도중 에러가 발생하였습니다.");
					}
				});					
			} 
			break;
		case "infoTrsf" : //이송
			window.open(com.wise.help.url("/admin/expose/popup/opnInfoTrsfPopup.do") + "?aplNo=" + formObj.find("input[name=aplNo]").val() , "list", "fullscreen=no, width=800, height=730, scrollbars=yes");
			/*if ( infoTrsValidation() ) {
				if ( !confirm("이송하시겠습니까?") )	return false;
				doAjax({
					url : "/admin/expose/insertTrsfOpnApl.do",
					params : formObj.serialize(),
					callback : afterTabRemove
				});
			} */
			break;
		case "infoCancel" : //청구취하
			if ( !confirm("청구취하를 하시겠습니까?") )	return false;
			formObj.ajaxSubmit({
				url : com.wise.help.url("/admin/expose/cancleOpnApl.do")
				, async : false
				, type : 'post'
				, dataType: 'json' 
				, contentType : 'application/x-www-form-urlencoded;charset=UTF-8'
				, beforeSubmit : function() {
				}	
				, success : function(res, status) {
					doAjaxMsg(res, "");
					afterTabRemove(res)
				}
				, error: function(jqXHR, textStatus, errorThrown) {
					//alert("처리 도중 에러가 발생하였습니다.");
				}
			});
			break;
			
		case "dcsProd" : //결정기한연장
			window.open(com.wise.help.url("/admin/expose/popup/opnDcsProdPopup.do") + "?aplNo=" + formObj.find("input[name=aplNo]").val() , "list", "fullscreen=no, width=800, height=730, scrollbars=yes");
			break;
			
		case "endInfo" : //종결
			var params = "?aplNo=" + formObj.find("input[name=aplNo]").val() + "&aplDealInstCd="+formObj.find("input[name=relAplInstCd]").val();
			window.open(com.wise.help.url("/admin/expose/popup/opnEndCnPopup.do") +  params , "list", "fullscreen=no, width=800, height=280, scrollbars=yes");
			break;
			
		case "trnWrite" : //이송통지
			var params = "?aplNo=" + formObj.find("input[name=aplNo]").val();
			window.open(com.wise.help.url("/admin/expose/popup/writeOpnTrnPopup.do") + params , "list", "fullscreen=no, width=800, height=800, scrollbars=yes");
			break;	
		case "dcsDetail" : //결정통보내역
			var params = "?aplNo=" + formObj.find("input[name=aplNo]").val();
			window.open(com.wise.help.url("/admin/expose/popup/viewOpnDcsPopup.do") +  params , "list", "fullscreen=no, width=800, height=800, scrollbars=yes");
			break;
		case "objTn" : //이의신청내역
			var params = "?objtnSno=" + formObj.find("input[name=objtnSno]").val()+"&aplNo="+ formObj.find("input[name=aplNo]").val();
			window.open(com.wise.help.url("/admin/expose/popup/viewOpnObjtnPopup.do") +  params , "list", "fullscreen=no, width=800, height=800, scrollbars=yes");
			break;	
		case "excel":
			sheet.Down2Excel({FileName:'정보공개청구내역.xls',SheetName:'sheet'});
			break;
		case "cancelDcs" : 	//결정통지취소
			window.open(com.wise.help.url("/admin/expose/popup/opnCancelPopup.do") + "?cType=DCS&aplNo=" + formObj.find("input[name=aplNo]").val() , "list", "fullscreen=no, width=800, height=400, scrollbars=yes");
			break;
		case "cancelEnd" : 	//통지완료취소
			window.open(com.wise.help.url("/admin/expose/popup/opnCancelPopup.do") + "?cType=END&aplNo=" + formObj.find("input[name=aplNo]").val() , "list", "fullscreen=no, width=800, height=400, scrollbars=yes");
			break;
		case "infoOrg" : 	//부서검색
			var url = com.wise.help.url("/admin/expose/popup/infoOrgPop.do");
			openIframeStatPop("iframePopUp", url+"?parentFormNm=writeAccount-dtl-form&aInstCd="+formObj.find("input[name=aInstCd]").val()+"&aplDeptCds="+formObj.find("input[name=aplDeptCds]").val()+"&aplNo="+formObj.find("input[name=aplNo]").val(), "660", "530")
			break;
			
		case "deptSave" : //담당기관 정보
			if (com.wise.util.isNull(formObj.find("input[name=aplDeptNm]").val())) {
				alert("담당기관 부서정보를 선택하세요.");
				return false;
			}
			if ( !confirm("담당기관 정보를 저장 하시겠습니까?") )	return false;
			formObj.ajaxSubmit({
				url : com.wise.help.url("/admin/expose/updateOpnAplDept.do")
				, async : false
				, type : 'post'
				, dataType: 'json' 
				, contentType : 'application/x-www-form-urlencoded;charset=UTF-8'
				, beforeSubmit : function() {
				}	
				, success : function(res, status) {
					doAjaxMsg(res, "");
					afterTabRemove(res)
				}
				, error: function(jqXHR, textStatus, errorThrown) {
					//alert("처리 도중 에러가 발생하였습니다.");
				}
			});
			break;
			
		case "aplConnCdSave" : //신청연계 코드 저장(수정)
			if ( !confirm("신청연계 코드를 저장 하시겠습니까?") )	return false;
			formObj.ajaxSubmit({
				url : com.wise.help.url("/admin/expose/updateAplConnCd.do")
				, async : false
				, type : 'post'
				, dataType: 'json' 
				, contentType : 'application/x-www-form-urlencoded;charset=UTF-8'
				, beforeSubmit : function() {
				}	
				, success : function(res, status) {
					doAjaxMsg(res, "");
					//afterTabRemove(res)
				}
				, error: function(jqXHR, textStatus, errorThrown) {
					//alert("처리 도중 에러가 발생하였습니다.");
				}
			});
			break;
	}
}

/**
 * 데이터 저장
 * @param action	I:등록 / U:수정
 */
function saveData(action) {
	var formObj = getTabFormObj("writeAccount-dtl-form");
	formObj.ajaxSubmit({
		url : com.wise.help.url("/admin/expose/insertOpnApply.do")
		, async : false
		, type : 'post'
		, dataType: 'json' 
		, contentType : 'application/x-www-form-urlencoded;charset=UTF-8'
		, beforeSubmit : function() {
			//submit 전 validation 체크
			if ( saveValidation(action) ) {
				// 실명인증 사용안함 20210615
				/*if ( success !="1" && !confirm("실명인증을 하지 않았습니다. 등록을 진행하시겠습니까?") ) return false;
				else if(success =="1" && !confirm("저장 하시겠습니까?")) return false;*/
				
				if ( !confirm("저장 하시겠습니까?") ) return false;
			} else {
				return false;
			}
		}	
		, success : function(res, status) {
			doAjaxMsg(res, "");
			afterTabRemove(res)
		}
		, error: function(jqXHR, textStatus, errorThrown) {
			//alert("처리 도중 에러가 발생하였습니다.");
		}
	});
}

//실명인증
function isReal() {
	var form = $("form[name=isRealform]");
	var formObj = getTabFormObj("writeAccount-dtl-form");
	
	if ( isRealValidation() ) {
		form.find("input[name=login_rno1]").val(formObj.find("input[name=aplRno1]").val());
		//form.find("input[name=login_rno2]").val(formObj.find("input[name=aplRno2]").val());
		form.find("input[name=login_name]").val(formObj.find("input[name=aplPn]").val());
	} else {
		return false;
	}
	
	form.ajaxSubmit({
		url : com.wise.help.url("/admin/expose/openLogin.do")
		, async : false
		, type : 'post'
		, dataType: 'json' 
		, contentType : 'application/x-www-form-urlencoded;charset=UTF-8'
		, success : function(res, status) {
			var result = res.data;	
			formObj.find("input[name=aplRno1]").prop("readonly", "true");
			//formObj.find("input[name=aplRno2]").prop("readonly", "true");
			formObj.find("input[name=aplPn]").prop("readonly", "true");
			
			alert(result.msg);
			
			success = result.result; //실명인증여부 체크 
		}
		, error: function(jqXHR, textStatus, errorThrown) {
			alert("처리 도중 에러가 발생하였습니다.");
		}
	});
}

////////////////////////////////////////////////////////////////////////////////
// 전처리 함수
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// 후처리 함수
////////////////////////////////////////////////////////////////////////////////
//상세 탭 이벤트 후처리
function tabFunction(tab, data) {
	var formObj = getTabFormObj("writeAccount-dtl-form");
	
    var maxDate = new Date();
    // 주석 2020-01-14
    //var dd = maxDate.getDate() + 7;
    //maxDate.setDate(dd);

	//달력
	formObj.find("input[name=dealDlnDt]").datepicker(setCalendarFormat('yymmdd'));
	formObj.find("input[name=dealDlnDt]").datepicker( "option", "minDate", maxDate);
	formObj.find("input[name=dealDlnDt]").attr("readonly", true);
	//처리상태이력 보이게
	tab.ContentObj.find("div[name=opnzHist]").css("display", "block");
	
	tab.ContentObj.find("tr[id=feeRdtnArea]").hide();
	
	tab.ContentObj.find("input[name=aplDeptNm]").val("");
	tab.ContentObj.find("input[name=aplDeptCds]").val("");
	tab.ContentObj.find("input[name=aplDeptCd]").val("");
	
	// 접수번호
	var rcpNo = data.DATA2.RCP_NO[0].rcpNo; 
	// 접수상세번호(국회사무처일때, 9710000 )
	var nextRcpNo = data.DATA2.NEXT_RCP_NO[0].nextRcpNo;
	// 접수상세번호 (나머지일때)
	var rcpDtsNo = data.DATA2.RCP_DTS_NO[0].rcpDtsNo;
	if(!com.wise.util.isNull(rcpDtsNo)){
		rcpDtsNo = rcpDtsNo.split("-");
		rcpDtsNo = rcpDtsNo[0] + "-" + (parseInt(rcpDtsNo[1])+1)
	}
	var histHtml = "";
	var fileHtml = "";
	var file1Html = "";
	var file2Html = "";
	var deptHtml = "";
	//처리상태 이력 테이블
	$.each(data.DATA2.OPNZ_HIST, function(i, value) {
		if(value.aplNo != null){
			histHtml += "<tr>";
			histHtml += 	"<td style=\"text-align:center;\">"+(i+1)+"</td>";
			histHtml += 	"<td>"+value.histDivNm+"</td>";
			histHtml += 	"<td style=\"text-align:center;\">"+parseDate(value.histDt)+"</td>";
			histHtml += 	"<td style=\"text-align:center;\">"+(com.wise.util.isNull(value.usrId) ? "" : value.usrId)+"</td>";
			histHtml += 	"<td>"+(com.wise.util.isNull(value.histCn) ? "" : value.histCn)+"</td>";
			histHtml += "</tr>";
		}
	});
	
	tab.ContentObj.find("tbody[id=opnzHistList]").empty().append(histHtml);
	
	if(data.DATA2.OPNZ_DEPT != "") {
		tab.ContentObj.find("div[id=deptTable]").css("display", "block");
	}else{
		tab.ContentObj.find("div[id=deptTable]").css("display", "none");
	}
	//담당부서 테이블
	$.each(data.DATA2.OPNZ_DEPT, function(i, value) {
		if(value.aplNo != null){
			deptHtml += "<tr>";
			deptHtml += 	"<td style=\"text-align:center;\">"+(i+1)+"</td>";
			deptHtml += 	"<td>"+value.deptNm+"</td>";
			deptHtml += "</tr>";
		}
	});
	
	tab.ContentObj.find("tbody[id=opnzDeptList]").empty().append(deptHtml);
	
	//청구내역 상세 데이터
	var dataDtl = data.DATA; 
	
	if(dataDtl != ""){
	
		tab.ContentObj.find("input[name=callVersion]").val(dataDtl.callVersion); //2단계 개선사업 - 반영 이전/이후 확인

		// 접수번호, 접수상세번호 (신청상태일때)
		if(com.wise.util.isNull(dataDtl.rcpDtsNo)){
			if(dataDtl.aplDealInstCd == "9710000"){ 
				tab.ContentObj.find("input[name=rcpDtsNo]").val(nextRcpNo); //국회사무처일때
			}else{
				tab.ContentObj.find("input[name=rcpDtsNo]").val(rcpDtsNo); //나머지(국회도서관, 국회예산정책처, 국회입법조사처)
			}
			tab.ContentObj.find("input[name=rcpNo]").val(rcpNo); //접수번호
			
			tab.ContentObj.find("textarea[name=printAplModDtsCn]").val(dataDtl.aplModDtsCn); //청구내용 - 출력용
		}else{
			//처리중 상태일때
			tab.ContentObj.find("input[name=rcpDtsNo]").hide();
			tab.ContentObj.find("span[name=rcpDtsNo]").text(dataDtl.rcpDtsNo); 
			tab.ContentObj.find("input[name=rcpNo]").val(dataDtl.rcpNo); //접수번호
			tab.ContentObj.find("span[name=rcpDt]").text(parseDate(dataDtl.rcpDt)); //일자
			tab.ContentObj.find("div[id=dealDlnDtArea]").hide(); 
			tab.ContentObj.find("span[name=dealDlnDt]").text(com.wise.util.isNull(dataDtl.dealDlnDt) ? "" : parseDate(dataDtl.dealDlnDt)); //처리기한
			tab.ContentObj.find("input[name=aplModSj]").hide();
			tab.ContentObj.find("span[name=aplModSj]").text(dataDtl.aplModSj); //수정청구제목
			
			tab.ContentObj.find("textarea[name=aplModDtsCn]").hide();
			tab.ContentObj.find("span[name=len2]").hide();
			tab.ContentObj.find("span[name=aplModDtsCn]").html(com.wise.help.toHtmlBr(dataDtl.aplModDtsCn)); //수정청구내용
			
			tab.ContentObj.find("textarea[name=printAplModDtsCn]").val(dataDtl.aplModDtsCn); //청구내용 - 출력용
		}
		if(!com.wise.util.isNull(dataDtl.objtnSno)){
			tab.ContentObj.find("input[name=objtnSno]").val(dataDtl.objtnSno);
		}
		//청구인 구분 숨김 
		tab.ContentObj.find("tr[id=aplNtfrDivArea]").hide();
		
		//청구대상기관 숨김
		tab.ContentObj.find("div[id=aplInstCdArea]").hide();
		tab.ContentObj.find("span[name=aplInstNm]").text(dataDtl.aplDealInstNm);
		
		
		//법인명이 없을시 필드 숨김(법인명, 사업자번호)
		if(com.wise.util.isNull(dataDtl.aplCorpNm)){
			tab.ContentObj.find("tr[id=aplCorpArea]").hide();
		}
		
		//이름
		tab.ContentObj.find("input[name=aplPn]").hide();
		tab.ContentObj.find("span[name=aplPn]").text(dataDtl.aplPn);
		
		//주민등록번호
		tab.ContentObj.find("div[id=aplRnoArea]").hide();
		/*tab.ContentObj.find("span[name=aplRno]").text(dataDtl.aplRno1 + "-" + (com.wise.util.isNull(dataDtl.aplRno2) ? "" :"*******"));*/
		tab.ContentObj.find("span[name=aplRno]").text(dataDtl.aplRno1);
		
		//휴대전화번호
		tab.ContentObj.find("div[id=aplMblPnoArea]").hide();
		tab.ContentObj.find("span[name=aplMblPno]").text(com.wise.util.isNull(dataDtl.aplMblPno) ? "" : dataDtl.aplMblPno);
		
		//전화번호
		tab.ContentObj.find("div[id=aplPnoArea]").hide();
		tab.ContentObj.find("span[name=aplPno]").text(com.wise.util.isNull(dataDtl.aplPno) ? "" : dataDtl.aplPno);
		
		//모사전송번호
		tab.ContentObj.find("div[id=aplFaxNoArea]").hide();
		tab.ContentObj.find("span[name=aplFaxNo]").text(com.wise.util.isNull(dataDtl.aplFaxNo) ? "" : dataDtl.aplFaxNo);
		
		//신청연계코드 20210615 추가
		//tab.ContentObj.find("div[id=aplConnCdArea]").hide();
		if (com.wise.util.isNull(dataDtl.aplConnCd)) {
			$("#aplConnCd_save").html("수정");
		} else {
			$("#aplConnCd_save").html("저장");
		}
		tab.ContentObj.find("[name=aplConnCd]").text(dataDtl.aplConnCd);
		
		//법인명
		tab.ContentObj.find("input[name=aplCorpNm]").hide();
		tab.ContentObj.find("span[name=aplCorpNm]").text(com.wise.util.isNull(dataDtl.aplCorpNm) ? "" : dataDtl.aplCorpNm);
		//사업자번호
		tab.ContentObj.find("div[id=aplBnoArea]").hide();
		tab.ContentObj.find("span[name=aplBno]").text(com.wise.util.isNull(dataDtl.aplBno) ? "" : dataDtl.aplBno);
		
		//정보통신망
		tab.ContentObj.find("div[id=aplEmailAddrArea]").hide();
		tab.ContentObj.find("span[name=aplEmailAddr]").text(com.wise.util.isNull(dataDtl.aplEmailAddr) ? "" : dataDtl.aplEmailAddr);
		
		//주소
		tab.ContentObj.find("div[id=aplAddrArea]").hide();
		tab.ContentObj.find("span[name=aplAddr]").text("("+dataDtl.aplZpno+") "+ dataDtl.apl1Addr + " " + (com.wise.util.isNull(dataDtl.apl2Addr) ? "" :dataDtl.apl2Addr));
		
		//청구제목
		tab.ContentObj.find("input[name=aplSj]").hide();
		tab.ContentObj.find("span[name=aplSj]").text(com.wise.util.isNull(dataDtl.aplSj) ? "" : dataDtl.aplSj);
		
		//청구내용
		tab.ContentObj.find("div[id=aplDtsCnArea]").hide();
		tab.ContentObj.find("span[name=aplDtsCn]").html(com.wise.util.isNull(dataDtl.aplDtsCn) ? "" : com.wise.help.toHtmlBr(dataDtl.aplDtsCn));
		
		//수령방법
		tab.ContentObj.find("div[id=aplTakMth]").hide();
		tab.ContentObj.find("span[name=aplTakMthEtc]").show();
		tab.ContentObj.find("input[name=aplTakMthEtc]").hide();
		if(dataDtl.aplTakMth == "05"){ //기타일때
			tab.ContentObj.find("span[name=aplTakMthEtc]").text(dataDtl.aplTakMthNm + "," + (com.wise.util.isNull(dataDtl.aplTakMthEtc) ? "" :dataDtl.aplTakMthEtc));
		}else{
			tab.ContentObj.find("span[name=aplTakMthEtc]").text(dataDtl.aplTakMthNm);
		}
		
		//첨부문서 
		if(dataDtl.attchFlNm != null){
			tab.ContentObj.find("div[id=fileArea]").hide();
			fileHtml += "<a href=\"javascript:;\" style=\"text-decoration:none;\">";
			fileHtml += "<img src=\"/images/admin/icon_file.png\" style=\"padding-right:4px;\" alt=\"첨부파일\" >";
			fileHtml += "<span style=\"color:#666;\">"+dataDtl.attchFlNm+"</span>";
			fileHtml += "</a>";
			
			var attchFlNm = dataDtl.attchFlNm;
			var attchFlPhNm = dataDtl.attchFlPhNm;
            
			tab.ContentObj.find("tr[id=attchFlArea] > td").append(fileHtml);
			
			tab.ContentObj.find("tr[id=attchFlArea] > td > a").bind("click", function(event) {
                // 파일을 다운로드한다.
                downloadFile(attchFlNm, attchFlPhNm);
                return false;
            });
			
		}else{
			tab.ContentObj.find("tr[id=attchFlArea]").hide();
		}
		
		
		//공개형태
		tab.ContentObj.find("div[id=opbFomVal]").hide();
		tab.ContentObj.find("span[name=opbFomEtc]").show();
		tab.ContentObj.find("input[name=opbFomEtc]").hide();
		if(dataDtl.opbFomVal == "05"){ //기타일때 
			tab.ContentObj.find("span[name=opbFomEtc]").text(dataDtl.opbFomValNm + "," + (com.wise.util.isNull(dataDtl.opbFomEtc) ? "" :dataDtl.opbFomEtc));
		}else{
			tab.ContentObj.find("span[name=opbFomEtc]").text(dataDtl.opbFomValNm);
		}
		
		//결정통지 안내수신
		tab.ContentObj.find("tr[id=dcsNtcRcvMthArea]").hide();
		tab.ContentObj.find("span[name=dcsNtcRcvMthArea]").text(com.wise.util.isNull(dataDtl.dcsNtcRcvMthNm) ? "" : dataDtl.dcsNtcRcvMthNm);
		
		
		//수수료 감면 여부
		tab.ContentObj.find("span[name=feeRdtnNm]").text(dataDtl.feeRdtnNm);
		
		
		//감면여부 첨부문서
		if(dataDtl.rcpPrgStatCd == "08" && dataDtl.newClsdRmk == null){
			tab.ContentObj.find("span[name=feeRdtnRson]").text("해당없음");
			tab.ContentObj.find("span[name=feeAttchFlNm]").text("해당없음");
		}else{
			formObj.find("span[name=feeRdtnRson]").text(com.wise.util.isNull(dataDtl.feeRdtnRson) ? "" : dataDtl.feeRdtnRson); //감면사유
			
			if(dataDtl.feeAttchFlNm != null){
				tab.ContentObj.find("div[id=file1Area]").hide();
				file1Html += "<a href=\"javascript:;\" style=\"text-decoration:none;\">";
				file1Html += "<img src=\"/images/admin/icon_file.png\" style=\"padding-right:4px;\" alt=\"첨부파일\" >";
				file1Html += "<span style=\"color:#666;\">"+dataDtl.feeAttchFlNm+"</span>";
				file1Html += "</a>";
				
				var feeAttchFlNm = dataDtl.feeAttchFlNm;
				var feeAttchFlPh = dataDtl.feeAttchFlPh;
				
				tab.ContentObj.find("td[name=feeAttchFile]").append(file1Html);
				
				tab.ContentObj.find("td[name=feeAttchFile] > a").bind("click", function(event) {
	                // 파일을 다운로드한다.
	                downloadFile(feeAttchFlNm, feeAttchFlPh);
	                return false;
	            });
			}
		}
		
		
		//처리기관
		tab.ContentObj.find("input[name=relAplInstCd]").val(dataDtl.aplDealInstCd);
		
		tab.ContentObj.find('input:checkbox[name="aplDealInstCd"]').each(function() {
		     if(this.value == dataDtl.aplDealInstCd){ //값 비교
		            this.checked = true; //checked 처리
		      }else{
		    	  this.checked = false; 
		      }

		 });
		
		tab.ContentObj.find("#accDM_aplDeptNm").text(dataDtl.aplDeptNm);	// DM 권한일경우 부서명
		
		//청구내역 수정 버튼
		if(dataDtl.prgStatCd == "03" ){ //세션유저기관 == dataDtl.aplDealInstcd 조건 추가 필요 !!~
			tab.ContentObj.find("img[name=updOpnApl]").show();
			
			tab.ContentObj.find("input[name=aplDealInstCd]").each(function() {
				if($(this).is(":checked") ==  true){
					$(this).attr("disabled", true);
				}
			 });
		}
		
		//공개여부 관련 ###################
		if(dataDtl.opbYn != null) {
			tab.ContentObj.find("tbody[id=opnzDcsArea]").show();
			tab.ContentObj.find("span[name=opbYn]").text(dataDtl.opbYn); //공개여부
			
			//비공개사유
			if(dataDtl.callVersion == "V1"){
				if(dataDtl.rcpPrgStatCd == "08" && dataDtl.clsdRmk == null){
					tab.ContentObj.find("span[name=clsdRmk]").text("해당없음");
				}else{
					tab.ContentObj.find("span[name=clsdRmk]").html(com.wise.util.isNull(dataDtl.clsdRmk) ? "" : com.wise.help.toHtmlBr(dataDtl.clsdRmk));
					
					tab.ContentObj.find("textarea[name=printClsdRmk]").val(dataDtl.clsdRmk); //비공개사유 - 출력용
				}
			}else{
				if(dataDtl.rcpPrgStatCd == "08" && dataDtl.newClsdRmk == null){
					tab.ContentObj.find("span[name=clsdRmk]").text("해당없음");
				}else{
					tab.ContentObj.find("span[name=clsdRmk]").html(com.wise.util.isNull(dataDtl.newClsdRmk) ? "" : com.wise.help.toHtmlBr(dataDtl.newClsdRmk));
					
					tab.ContentObj.find("textarea[name=printClsdRmk]").val(dataDtl.newClsdRmk); //비공개사유 - 출력용
				}
			}
			
			//비공개 첨부파일
			if(dataDtl.clsdAttchFlNm != null){
				tab.ContentObj.find("tr[id=clsdAttchFlArea]").show();
				var clsdfile = "";
				clsdfile += "<a href=\"javascript:;\" style=\"text-decoration:none;\">";
				clsdfile += "<img src=\"/images/admin/icon_file.png\" style=\"padding-right:4px;\" alt=\"첨부파일\" >";
				clsdfile += "<span style=\"color:#666;\">"+dataDtl.clsdAttchFlNm+"</span>";
				clsdfile += "</a>";
				
				var clsdAttchFlNm = dataDtl.clsdAttchFlNm;
				var clsdAttchFlPhNm = dataDtl.clsdAttchFlPhNm;
				
				tab.ContentObj.find("tr[id=clsdAttchFlArea] > td").append(clsdfile);
				
				tab.ContentObj.find("tr[id=clsdAttchFlArea] > td > a").bind("click", function(event) {
	                // 파일을 다운로드한다.
	                downloadFile(clsdAttchFlNm, clsdAttchFlPhNm);
	                return false;
	            });
			}
			
			if(dataDtl.opbYn == "부존재 등"){
				tab.ContentObj.find("span[name=nonExt]").text(com.wise.util.isNull(dataDtl.nonExt) ? "" : dataDtl.nonExt);
			}else{
				tab.ContentObj.find("span[name=nonExt]").text("해당없음");
			}
				
			//정보 부존재 등 정보공개청구에 따를 수 없는 사유 > 첨부
			if(dataDtl.nonFlNm != null){
				fileHtml = "<a href=\"javascript:;\" style=\"text-decoration:none;\">";
				fileHtml += "<img src=\"/images/admin/icon_file.png\" style=\"padding-right:4px;\" alt=\"첨부파일\" >";
				fileHtml +=  "<span style=\"color:#666;\">"+dataDtl.nonFlNm+"</span>";
				fileHtml += "</a>";
				var nonFlNm = dataDtl.nonFlNm;
				var nonFlPh = dataDtl.nonFlPh;
		        
				tab.ContentObj.find("span[name=nonFlNm]").append(fileHtml);
			
				tab.ContentObj.find("span[name=nonFlNm] > a").bind("click", function(event) {
		            // 파일을 다운로드한다.
		            downloadFile(nonFlNm, nonFlPh);
		            return false;
		        });
				
			}else{
				tab.ContentObj.find("span[name=nonFlNm]").text("첨부없음");
			}
		}
		
		//결정통지 첨부파일 영역
		if(dataDtl.opbFlNm != null){
			var ext = "";
			var ext1 = "";
			var ext2 = "";
			
			tab.ContentObj.find("tbody[id=opbFlnmArea]").show();
			
			//특이사항
			tab.ContentObj.find("span[name=opbPsbj]").text(com.wise.util.isNull(dataDtl.opbPsbj) ? "해당없음" : dataDtl.opbPsbj);
			
			
			var opbFlNmHtml = "";
			
			opbFlNmHtml += "<a href=\"javascript:;\" style=\"text-decoration:none;\" name=\"opbFlNm\">";
			opbFlNmHtml += "<img src=\"/images/admin/icon_file.png\" style=\"padding-right:4px;\" alt=\"첨부파일\" >";
			opbFlNmHtml += "<span style=\"color:#666;\">"+dataDtl.opbFlNm+"</span>";
			opbFlNmHtml += "</a><br>";
			
			var opbFlNm = dataDtl.opbFlNm;
			var opbFlPh = dataDtl.opbFlPh;
			
			ext = opbFlNm.substring(opbFlNm.lastIndexOf(".")+1);
			
			tab.ContentObj.find("div[name=opbFlNm]").append(opbFlNmHtml);
			
			tab.ContentObj.find("a[name=opbFlNm]").bind("click", function(event) {
                // 파일을 다운로드한다.
                downloadFile(opbFlNm, opbFlPh);
                return false;
            });
			if(dataDtl.opbFlNm2 != null) {
				var opbFlNm2Html = "";
				
				opbFlNm2Html += "<a href=\"javascript:;\" style=\"text-decoration:none;\" name=\"opbFlNm2\">";
				opbFlNm2Html += "<img src=\"/images/admin/icon_file.png\" style=\"padding-right:4px;\" alt=\"첨부파일\" >";
				opbFlNm2Html += "<span style=\"color:#666;\">"+dataDtl.opbFlNm2+"</span>";
				opbFlNm2Html += "</a><br>";
				
				var opbFlNm2 = dataDtl.opbFlNm2;
				var opbFlPh2 = dataDtl.opbFlPh2;
				
				ext1 = opbFlNm2.substring(opbFlNm2.lastIndexOf(".")+1);
				
				tab.ContentObj.find("div[name=opbFlNm]").append(opbFlNm2Html);
				
				tab.ContentObj.find("a[name=opbFlNm2]").bind("click", function(event) {
	                // 파일을 다운로드한다.
	                downloadFile(opbFlNm2, opbFlPh2);
	                return false;
	            });
			}
			
			if(dataDtl.opbFlNm3 != null) {
				var opbFlNm3Html = "";
				
				opbFlNm3Html += "<a href=\"javascript:;\" style=\"text-decoration:none;\" name=\"opbFlNm3\">";
				opbFlNm3Html += "<img src=\"/images/admin/icon_file.png\" style=\"padding-right:4px;\" alt=\"첨부파일\" >";
				opbFlNm3Html += "<span style=\"color:#666;\">"+dataDtl.opbFlNm3+"</span>";
				opbFlNm3Html += "</a><br>";
				
				var opbFlNm3 = dataDtl.opbFlNm3;
				var opbFlPh3 = dataDtl.opbFlPh3;
				
				ext2 = opbFlNm3.substring(opbFlNm3.lastIndexOf(".")+1);
				
				tab.ContentObj.find("div[name=opbFlNm]").append(opbFlNm3Html);
				
				tab.ContentObj.find("a[name=opbFlNm3]").bind("click", function(event) {
	                // 파일을 다운로드한다.
	                downloadFile(opbFlNm3, opbFlPh3);
	                return false;
	            });
			}
			
			//PDF 파일 포함시 진본확인 프로그램 다운로드 보이게
			if(ext == "pdf" || ext2 == "pdf" || ext2 == "pdf"){
				tab.ContentObj.find("div[id=attchEtcFile]").show();
			}
			
		}
		
		if(dataDtl.aplPrgStatCd == "01" || dataDtl.aplPrgStatCd == "03"){
			//tab.ContentObj.find("tr[id=aplDealInstArea]").show(); 팝업화면으로 변경
		}
		
		if(dataDtl.endCn != null) {
			tab.ContentObj.find("tr[id=endCnArea]").show();
			tab.ContentObj.find("span[name=endCn]").text(dataDtl.endCn);
		}
		
		if(dataDtl.prgStatCd == "11"){ //이송통지
			
			//이송통지 내역
			tab.ContentObj.find("div[name=opnzTrsf]").show();
			//이송기관명
			tab.ContentObj.find("span[name=trsfInstNm]").text(dataDtl.trsfInstNm);
			//이송일자
			tab.ContentObj.find("span[name=trsfDt]").text(parseDate(dataDtl.trsfDt));
			//문서번호
			tab.ContentObj.find("span[name=trsfDocNo]").text(dataDtl.trsfDocNo);
			//이송사유
			tab.ContentObj.find("span[name=trsfCn]").text(dataDtl.trsfCn);
			
			//그밖의 안내상항
			if(dataDtl.trsfEtcCn == null){
				tab.ContentObj.find("tr[id=trsfEtcCnArea]").hide();
			}else{
				tab.ContentObj.find("span[name=trsfEtcCn]").text(dataDtl.trsfEtcCn);
			}
			
			//이송첨부파일
			if(dataDtl.trsfFlNm != null){
				tab.ContentObj.find("div[id=file1Area]").hide();
				file2Html += "<a href=\"javascript:;\" style=\"text-decoration:none;\">";
				file2Html += "<img src=\"/images/admin/icon_file.png\" style=\"padding-right:4px;\" alt=\"첨부파일\" >";
				file2Html += "<span style=\"color:#666;\">"+dataDtl.trsfFlNm+"</span>";
				file2Html += "</a>";
				
				var trsfFlNm = dataDtl.trsfFlNm;
				var trsfFlPh = dataDtl.trsfFlPh;
				
				tab.ContentObj.find("div[id=trsfFlNmArea]").append(file2Html);
				
				tab.ContentObj.find("div[id=trsfFlNmArea] >  a").bind("click", function(event) {
	                // 파일을 다운로드한다.
	                downloadFile(trsfFlNm, trsfFlPh);
	                return false;
	            });
			}else{
				tab.ContentObj.find("tr[id=trsfFlArea]").hide();
			}
		}
		
		//tab.ContentObj.find("input[name=aplDeptNm]").val(dataDtl.aplDeptNm);
		//tab.ContentObj.find("input[name=aplDeptCd]").val(dataDtl.aplDeptCd);
		
		tab.ContentObj.find("input[name=aInstCd]").val(dataDtl.aplDealInstCd);
		
	}
		
	//이송 받은 정보 세팅
	if(data.DATA2.FROM_TRST.length > 0){
		tab.ContentObj.find("div[name=fromTrsfArea]").show();
		
		tab.ContentObj.find("tbody[name=fromTrsfInfo]").empty()
		var fromTrstHtml = "";
		$.each(data.DATA2.FROM_TRST, function(i, value) {
			tab.ContentObj.find("span[name=fromTrsfInstNm]").text(value.aplInstNm);
			
			fromTrstHtml += "<tr>";
		  if(dataDtl.aplDealInstCd == value.aplDealInstCd){
			fromTrstHtml += 	"<th style=\"text-align:center;background:#FFFFCE;font-weight: bold;color: red;\">"+value.aplDealInstNm+"<br />("+parseDate(value.trsfDt)+")</th>";	
		  }else{
			fromTrstHtml += 	"<th style=\"text-align:center;background:#FFFFCE;\">"+value.aplDealInstNm+"<br />("+parseDate(value.trsfDt)+")</th>";	
		  }
			fromTrstHtml += 	"<td>"+value.trsfCn+"</td>";
			fromTrstHtml += "</tr>";
		});
		tab.ContentObj.find("tbody[name=fromTrsfInfo]").append(fromTrstHtml);
	}
	
	//이송 보낸 정보 세팅
	if(data.DATA2.TO_TRST.length > 0){
		tab.ContentObj.find("div[name=toTrsfArea]").show();
		
		tab.ContentObj.find("tbody[name=toTrsfInfo]").empty()
		var toTrstHtml = "";
		$.each(data.DATA2.TO_TRST, function(i, value) {
			toTrstHtml += "<tr>";
			toTrstHtml += 	"<th style=\"text-align:center;background:#FFE6FF\">"+value.aplDealInstNm+"<br />("+parseDate(value.trsfDt)+")</th>";
			toTrstHtml += 	"<td>"+value.trsfCn+"</td>";
			toTrstHtml += "</tr>";
		});
		tab.ContentObj.find("tbody[name=toTrsfInfo]").append(toTrstHtml);
	}
	
	dynamicTabFunction(tab);		//탭 이벤트를 바인딩한다(동적생성 element들)
	
	dynamicTabButton(tab, dataDtl); //탭 이벤트 버튼 컨트롤
	
}



/**
 * 데이터 저장 완료 후
 */
function sheet_OnLoadData(data) {
	var data = JSON.parse(data);
	if ( data.success != null) {
		//시트 분류명 저장이 성공적으로 완료된 경우
		alert(data.success.message);
		doAction("search");
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
	dynamicTabFiled(tab);		//탭 이벤트를 바인딩한다(동적생성 element들)
}

//상세 탭 이벤트
function tabEvent(row){//탭 이벤트 실행  
	
	var title = sheet.GetCellValue(row, "aplSj");//탭 제목
	var id = sheet.GetCellValue(row, "aplNo");//탭 id(유일한key))
	openTab.SetTabData(sheet.GetRowJson(row));//db data 조회시 조건 data
	var url =  com.wise.help.url('/admin/expose/selectOpnApplyDtl.do'); // Controller 호출 url 
	openTab.addTab(id, title, url, tabCallBack); 	// 탭 추가 시작함
	//청구인정보 열람 로그
	insertLogAcsOpnzApl({aplNo: id, acsCd: "CS111", acsPrssCd: "PR101"});
} 

////////////////////////////////////////////////////////////////////////////////
//시트 로드
////////////////////////////////////////////////////////////////////////////////
function loadSheet() {
	
	createIBSheet2(document.getElementById("sheet"),"sheet", "100%", "300px");
	
	var gridTitle ="NO";
	gridTitle +="|상태";
	gridTitle +="|신청번호";
	gridTitle +="|접수번호";
	gridTitle +="|신청일자";
	gridTitle +="|청구제목";
	gridTitle +="|청구인";
	gridTitle +="|청구기관코드";
	gridTitle +="|청구기관";
	gridTitle +="|처리기관코드";
	gridTitle +="|처리기관";
	gridTitle +="|처리상태코드";
	gridTitle +="|공개여부";
	gridTitle +="|상태";
	gridTitle +="|종결여부";
	gridTitle +="|통지일자";
	gridTitle +="|이송원본신청번호";
	
	with(sheet){
		                     
		var cfg = {SearchMode:3,Page:50,VScrollMode:1};
	    SetConfig(cfg);
	    var headers = [
	                {Text:gridTitle, Align:"Center"}
	            ];
	    var headerInfo = {Sort:0,ColMove:0,ColResize:1,HeaderCheck:1};
	    
	    InitHeaders(headers, headerInfo);
	   
	    var cols = [
	                 {Type:"Seq",		SaveName:"seq",			    	Width:30,	Align:"Center",		Edit:false}
	                ,{Type:"Status",	SaveName:"status",		    	Width:30,	Align:"Center",		Edit:false,	Hidden:true}
	                ,{Type:"Text",	    SaveName:"aplNo",		    	Width:30,	Align:"Center",		Edit:false,	Hidden:true}
					,{Type:"Text",		SaveName:"rcpDtsNo",	    	Width:50,	Align:"Center",		Edit:false}
					,{Type:"Text",		SaveName:"aplDt",	        	Width:50,	Align:"Center",		Edit:false, Format:"Ymd"}
					,{Type:"Text",		SaveName:"aplSj",		    	Width:200,	Align:"Left",			Edit:false}
					,{Type:"Text",		SaveName:"aplPn",		    	Width:50,	Align:"Center",		Edit:false}
					,{Type:"Text",		SaveName:"aplInstCd",	    	Width:90,	Align:"Center",		Edit:false,	Hidden:true}
					,{Type:"Text",		SaveName:"aplInstNm",	    	Width:90,	Align:"Center",		Edit:false,	Hidden:true}
					,{Type:"Text",		SaveName:"aplDealInstCd",	Width:90,	Align:"Center",		Edit:false,	Hidden:true}
					,{Type:"Text",		SaveName:"aplDealInstNm",	Width:90,	Align:"Center",		Edit:false}
					,{Type:"Text",		SaveName:"prgStatCd",	    	Width:90,	Align:"Center",		Edit:false,	Hidden:true}
					,{Type:"Text",		SaveName:"opbYnNm",	        Width:50,	Align:"Center",		Edit:false}
					,{Type:"Text",		SaveName:"prgStatNm",	    Width:90,	Align:"Center",		Edit:false}
					,{Type:"Text",		SaveName:"endNm",	        	Width:50,	Align:"Center",		Edit:false}
					,{Type:"Text",		SaveName:"dcsNtcDt",	   		Width:50,	Align:"Center",		Edit:false, Format:"Ymd"}
					,{Type:"Text",	    SaveName:"srcAplNo",		  	Width:30,	Align:"Center",		Edit:false}
	            ];                                          
	    InitColumns(cols);
	    FitColWidth();
	    SetExtendLastCol(1);
	    

	}               
	default_sheet(sheet);   
	
}
////////////////////////////////////////////////////////////////////////////////
//시트 서비스 함수
////////////////////////////////////////////////////////////////////////////////
function sheet_OnDblClick(row, col, value, cellx, celly) {
	
	if(row < 1) return;
	    tabEvent(row);
}

function sheet_OnSearchEnd(code, message, statusCode, statusMessage) {
	//aplNo값이 전달되어 왔다면.. 해당 탭을 열기위하여 sheet데이터를 확인한다.
	var openAplNo = $("#openAplNo").val();
	
	if(!com.wise.util.isNull(openAplNo)){
		var openRow = findSheetRow("sheet", openAplNo, "aplNo");
		if(openRow != null) tabEvent(openRow);
	}
}
////////////////////////////////////////////////////////////////////////////////
//이벤트 함수
////////////////////////////////////////////////////////////////////////////////
/**
 * 탭 이벤트를 바인딩한다.
 */
function setTabButton() {
	var formObj = getTabFormObj("writeAccount-dtl-form");
	
	formObj.find("a[name=a_reg]").bind("click", function(event) {
		// 등록
		doAction("insert");
    });
	formObj.find("img[name=updOpnApl]").bind("click", function(event) {
		// 수정
		doAction("updOpnApl");
    });
	formObj.find("a[name=infoRcpBtnA]").bind("click", function(event) {
		// 접수
		doAction("infoRcp");
    });
    
    formObj.find("a[name=infoTrsfBtnA]").bind("click", function(event) {
		// 이송
		doAction("infoTrsf");
    });
    
    formObj.find("a[name=infoCancelfBtnA]").bind("click", function(event) {
		// 청구취하
		doAction("infoCancel");
    });
    
    formObj.find("a[name=dcsProdBtnA]").bind("click", function(event) {
		// 결정기한연장
		doAction("dcsProd");
    });
    
	formObj.find("button[name=btn_orgSearch]").bind("click", function(event) {
		// 부서검색
		doAction("infoOrg");
    });
    
    formObj.find("a[name=trnWriteBtnA]").bind("click", function(event) {
		// 이송통지
		doAction("trnWrite");
    });
    
    formObj.find("a[name=endInfoBtnA]").bind("click", function(event) {
		// 종결
		doAction("endInfo");
    });
    
    formObj.find("a[name=dcsWriteBtnA]").bind("click", function(event) {
		// 결정통지
    	fn_directPage();
    });
    
    formObj.find("a[name=dcsDetailBtnA]").bind("click", function(event) {
    	//결정통보내역
    	doAction("dcsDetail");
    });
    
    
    formObj.find("a[name=objTnBtnA]").bind("click", function(event) {
    	//이의신청내역
    	doAction("objTn");
    });
    
    formObj.find("button[name=isRealBtn]").bind("click", function(event) {
		// 실명인증
		isReal();
    });
    
	
	//우편번호 찾기 팝업
	formObj.find("button[name=zipcode_pop]").bind("click", function(event) {
		var url = com.wise.help.url("/portal/expose/roadSearchAddrPage.do");
		OpenWindow(url, "zipcodePop", "500", "720", "yes");
	});
	
	//사업자 번호 포커스 이동 
	formObj.find("input[name=aplBno1], input[name=aplBno2]").bind("keyup", function(event) {
		
		moveBnoFocus();
    });
	
	//감면여부 해당 화면 컨트롤
	formObj.find("input[name=feeRdtnCd]").bind("click", function(event) {
          var val = $(this).val();
          
          if(val == "01") {
        	  formObj.find("table[name=feeRdtnTr]").css("display", "block");
          }else{
        	  formObj.find("table[name=feeRdtnTr]").css("display", "none");
          }
    });
	
	//공개형태 기타 화면 컨트롤
	formObj.find("input[name=opbFomVal]").bind("click", function(event) {
        var val = $(this).val();
        if(val == "05") {
      	  formObj.find("span[name=opbFomEtc]").css("display", "block");
        }else{
      	  formObj.find("span[name=opbFomEtc]").css("display", "none");
        }
	});
	
	//수령방법 화면 컨트롤
	formObj.find("input[name=aplTakMth]").bind("click", function(event) {
        var val = $(this).val();
        if(val == "05") {
      	  formObj.find("span[name=aplTakMthEtc]").css("display", "block");
        }else{
      	  formObj.find("span[name=aplTakMthEtc]").css("display", "none");
        }
	});
	
	//이메일 선택시 컨트롤
	formObj.find("select[name=email]").bind("change", function(event) {
		var val = $(this).val();
		if(val == "1"){
			formObj.find("input[name=aplEmailAddr2]").removeAttr("readonly");
			formObj.find("input[name=aplEmailAddr2]").val("");
		}else{
			formObj.find("input[name=aplEmailAddr2]").prop("readonly", "true");
			formObj.find("input[name=aplEmailAddr2]").val(val);
		}
	});
	
	//주민등록번호 숫자만 입력
	formObj.find("input[name=aplRno1], input[name=aplRno2]").keyup(function(event) {
		var name = $(this).attr("name");
		validNumOnly(formObj.find("input[name="+name+"]"));
		return false;
	});
	
	//사업자번호 숫자만 입력
	formObj.find("input[name=aplBno1], input[name=aplBno2], input[name=aplBno3]").keyup(function(event) {
		var name = $(this).attr("name");
		validNumOnly(formObj.find("input[name="+name+"]"));
		return false;
	});
	
	//휴대전화번호 숫자만 입력
	formObj.find("input[name=aplMblPno2], input[name=aplMblPno3]").keyup(function(event) {
		var name = $(this).attr("name");
		validNumOnly(formObj.find("input[name="+name+"]"));
		return false;
	});
	
	//전화번호 숫자만 입력
	formObj.find("input[name=aplPno2], input[name=aplPno3]").keyup(function(event) {
		var name = $(this).attr("name");
		validNumOnly(formObj.find("input[name="+name+"]"));
		return false;
	});
	
	//모사전송번호 숫자만 입력
	formObj.find("input[name=aplFaxNo2], input[name=aplFaxNo3]").keyup(function(event) {
		var name = $(this).attr("name");
		validNumOnly(formObj.find("input[name="+name+"]"));
		return false;
	});
	//텍스트 박스 글자수 체크
	formObj.find("textarea[name=aplDtsCn]").bind("keyup", function(event) {
		var obj = formObj.find("textarea[name=aplDtsCn]");
		textAreaLenChk(obj, 'len1', 2000);
	});
	
	formObj.find("textarea[name=aplModDtsCn]").bind("keyup", function(event) {
		var obj = formObj.find("textarea[name=aplModDtsCn]");
		textAreaLenChk(obj, 'len2', 2000);
	});
	
	formObj.find("textarea[name=feeRdtnRson]").bind("keyup", function(event) {
		var obj = formObj.find("textarea[name=feeRdtnRson]");
		textAreaLenChk(obj, 'len3', 100);
	});
	
	//파일 필드 클리어
	formObj.find("button[name=pathDelete]").bind("click", function(event) {
		formObj.find("input[name=file]").val(""); 
	});
	
	formObj.find("button[name=pathDelete1]").bind("click", function(event) {
		formObj.find("input[name=file1]").val(""); 
	});
	
	//청구서 출력
	formObj.find("a[name=printAplBtnA]").bind("click", function(event) {
		infoPrint("apl");
	});
	
	//접수증 출력
	formObj.find("a[name=printRcpBtnA]").bind("click", function(event) {
		infoPrint("rcp");
	});
	
	//부존재 등 통지서 출력
	formObj.find("a[name=printNonBtnA]").bind("click", function(event) {
		infoPrint("non");
	});
	
	//결정통지서
	formObj.find("a[name=printDcsBtnA]").bind("click", function(event) {
		infoPrint("dcs"); 
	});
	
	//이송통지서
	formObj.find("a[name=printTrsfBtnA]").bind("click", function(event) {
		infoPrint("trsf");
	});
	
	//결정기한연장통지서
	formObj.find("a[name=printExtBtnA]").bind("click", function(event) {
		infoPrint("ext");
	});
	
	formObj.find("a[name=btnCancelDcs]").bind("click", function(event) {
		// 결정통지취소
		doAction("cancelDcs");
    });
	
	formObj.find("a[name=btnCancelEnd]").bind("click", function(event) {
		// 통지완료취소
		doAction("cancelEnd");
    });
	
	formObj.find("button[name=updateDeptBtnA]").bind("click", function(event) {
		// 담당자정보 저장
		doAction("deptSave");
    });
	
	// 결정통지 체크
	formObj.find("#dcs_ntc_rcvmth_sms, #dcs_ntc_rcvmth_talk").bind("click", function(e) {
		if( formObj.find("input:checkbox[id='dcs_ntc_rcvmth_sms']").is(":checked") && formObj.find("input:checkbox[id='dcs_ntc_rcvmth_talk']").is(":checked") ) {
			alert("SMS와 카카오알림톡은 동시에 선택할 수 없습니다.");
			return false;
		}
	});
	
	formObj.find("button[name=aplConnCd_save]").bind("click", function(event) {
		// 신청연계 코드 저장 
		doAction("aplConnCdSave");
    });
}

/**
 * 탭 이벤트를 바인딩한다.
 */
function dynamicTabFiled(tab) {
	//신규등록시 필요없는 필드 숨김
	tab.ContentObj.find("tr[id=rcpDtsNoArea]").hide();
	tab.ContentObj.find("tr[id=rcpDtArea]").hide();
	tab.ContentObj.find("tr[id=aplModSjArea]").hide();
	tab.ContentObj.find("tr[id=aplModDtsCnArea]").hide();
	tab.ContentObj.find("div[id=opnzDcs]").hide();
	tab.ContentObj.find("div[id=aplDeptArea]").hide();
	
	// 신청 연계 코드 버튼 숨김
	tab.ContentObj.find("button[id=aplConnCd_save]").hide();
	
	//신규등록시 버튼 숨김
	tab.ContentObj.find("a[name=printAplBtnA]").hide();
	
}
/**
 * 탭 이벤트를 바인딩한다.
 */
function dynamicTabFunction(tab){
	var obj = tab.ContentObj.find("textarea[name=aplDtsCn]");
	var obj1 = tab.ContentObj.find("textarea[name=aplModDtsCn]");
	var obj2 = tab.ContentObj.find("textarea[name=feeRdtnRson]");
	
	textAreaLenChk(obj, 'len1', 2000);
	textAreaLenChk(obj1, 'len2', 2000);
	textAreaLenChk(obj2, 'len3', 100);
	
}

/**
 * 탭 이벤트 버튼 컨트롤
 * @param tab
 * @param dataDtl
 */
function dynamicTabButton(tab, dataDtl){
	tab.ContentObj.find("a[name=printAplBtnA]").show(); //청구서출력
	
	if(dataDtl.prgStatCd != "01") tab.ContentObj.find("button[name=updateDeptBtnA]").show(); //담당기관 부서 정보
	else tab.ContentObj.find("button[name=updateDeptBtnA]").hide();
	
	if(dataDtl.rcpPrgStatCd == null && dataDtl.aplPrgStatCd !="99") {
		tab.ContentObj.find("a[name=infoRcpBtnA]").show(); //접수
		tab.ContentObj.find("a[name=infoTrsfBtnA]").show(); //이송
		tab.ContentObj.find("a[name=infoCancelfBtnA]").show(); //청구취하
		//tab.ContentObj.find("button[name=btn_orgSearch]").show(); //부서검색버튼
	}else if(dataDtl.rcpPrgStatCd =="03"){ //진행상황코드 처리중
		tab.ContentObj.find("a[name=printRcpBtnA]").show(); //접수증출력
		tab.ContentObj.find("a[name=dcsProdBtnA]").show(); //결정기한연장
		tab.ContentObj.find("a[name=dcsWriteBtnA]").show(); //결정통지
		tab.ContentObj.find("a[name=trnWriteBtnA]").show(); //이송통지
		tab.ContentObj.find("a[name=infoCancelfBtnA]").show(); //청구취하
		tab.ContentObj.find("a[name=infoTrsfBtnA]").show(); //이송
		tab.ContentObj.find("a[name=endInfoBtnA]").show(); //종결
	}else if(dataDtl.rcpPrgStatCd =="05"){ //진행상황코드 결정연장
		tab.ContentObj.find("a[name=printRcpBtnA]").show(); //접수증출력
		tab.ContentObj.find("a[name=printExtBtnA]").show(); //결정기한연장통지서
		tab.ContentObj.find("a[name=dcsWriteBtnA]").show(); //결정통지
		tab.ContentObj.find("a[name=trnWriteBtnA]").show(); //이송통지
		tab.ContentObj.find("a[name=infoCancelfBtnA]").show(); //청구취하
		tab.ContentObj.find("a[name=endInfoBtnA]").show(); //종결
	}else if(dataDtl.rcpPrgStatCd =="04"){ //진행상황코드 결정통지
		tab.ContentObj.find("a[name=printRcpBtnA]").show(); 
		if(dataDtl.opbYn == "부존재 등"){
			tab.ContentObj.find("a[name=printNonBtnA]").show(); //부존재 등 통지서 출력
		}else {
			tab.ContentObj.find("a[name=printDcsBtnA]").show(); //결정통지서출력
			//슈퍼관리자일 경우 [결정통지취소] 버튼을 활성화 시킨다.
			if($("#loginAccCd").val() == "SYS" || $("#loginAccCd").val() == "OPA"){
				tab.ContentObj.find("a[name=btnCancelDcs]").show(); //결정통지취소
			}
		}
		
		if(dataDtl.dcsProdEtYn == "0") tab.ContentObj.find("a[name=printExtBtnA]").show(); //결정기한연장통지서

		if(dataDtl.objtnSno != "NULL") tab.ContentObj.find("a[name=objTnBtnA]").show(); //이의신청내역
	}else {
		if(dataDtl.rcpPrgStatCd != null) {
			tab.ContentObj.find("a[name=printRcpBtnA]").show(); //접수
		}
		if(dataDtl.rcpPrgStatCd == "08" ||  dataDtl.rcpPrgStatCd == "04" ){
			if(dataDtl.endCn == null){ // 종결사유가 없을때, 즉. 강제종결이 아닐 때
				if(dataDtl.opbYn == "부존재 등") tab.ContentObj.find("a[name=printNonBtnA]").show(); //부존재 등 통지서 출력
				else tab.ContentObj.find("a[name=printDcsBtnA]").show(); //결정통지서출력
				tab.ContentObj.find("a[name=dcsDetailBtnA]").show(); //결정내역
				if(dataDtl.objtnSno != "NULL") tab.ContentObj.find("a[name=objTnBtnA]").show(); //이의신청내역
				
				//슈퍼관리자일 경우 [통지완료취소] 버튼을 활성화 시킨다.
				if($("#loginAccCd").val() == "SYS" || $("#loginAccCd").val() == "OPA"){
					if(dataDtl.rcpPrgStatCd == "08") tab.ContentObj.find("a[name=btnCancelEnd]").show();
				}
			}
		}
		if(dataDtl.dcsProdEtYn == "0") tab.ContentObj.find("a[name=printExtBtnA]").show(); //결정기한연장통지서
		if(dataDtl.rcpPrgStatCd == "11") tab.ContentObj.find("a[name=printTrsfBtnA]").show(); //이송통지일때
	}

	
}

////////////////////////////////////////////////////////////////////////////////
//Validation 함수
////////////////////////////////////////////////////////////////////////////////
/**
 * 등록/수정 validation 
 */
function saveValidation(action) {
	var objTab = getTabShowObj();//탭이 oepn된 객체가져옴
	var formObj = objTab.find("form[name=writeAccount-dtl-form]");
	
	if ( com.wise.util.isNull(formObj.find("input[name=aplPn]").val()) ) {
		alert("청구인 이름을 입력하세요");
		formObj.find("input[name=aplPn]").focus();
		return false;
	}
	if (com.wise.util.isNull(formObj.find("input[name=aplRno1]").val())  ) {
		alert("청구인 주민등록번호를 입력하세요.");
		formObj.find("input[name=aplRno1]").focus();
		return false;
	}
	if (formObj.find("select[name=aplMblPno1]").val() == '000' 
		&& formObj.find("select[name=aplPno1]").val() == '000'  ) {
		
		alert("전화번호, 핸드폰번호중 하나는 필수 입력입니다.");
		formObj.find("select[name=aplMblPno1]").focus();
		return false;
	}
	
	if (formObj.find("select[name=aplMblPno1]").val() == '000' 
		&& (com.wise.util.isNull(formObj.find("input[name=aplMblPno2]").val())
				||com.wise.util.isNull(formObj.find("input[name=aplMblPno3]").val()))) {
			
		alert("핸드폰번호를 입력하세요.");
		formObj.find("select[name=aplMblPno2]").focus();
		return false;
	}
	
	if (formObj.find("select[name=aplPno1]").val() == '000' 
		&& (com.wise.util.isNull(formObj.find("input[name=aplPno2]").val())
				||com.wise.util.isNull(formObj.find("input[name=aplPno3]").val()))) {
			
		alert("전화번호를 입력하시거나 \n없음으로 선택해 주세요.");
		formObj.find("select[name=aplPno2]").focus();
		return false;
	}
	//오프라인 신청연계 코드 추가 20210615
	if (com.wise.util.isNull(formObj.find("input[name=aplConnCd]").val())  ) {
		alert("신청연계 코드를 입력해주세요.");
		formObj.find("input[name=aplConnCd]").focus();
		return false;
	}
	if (com.wise.util.isNull(formObj.find("input[name=aplZpno]").val()) 
			&& com.wise.util.isNull(formObj.find("input[name=apl1Addr]").val())) {
		alert("우편번호를 입력하세요.");
		formObj.find("button[name=zipcode_pop]").focus();
		return false;
	}
	
	if (com.wise.util.isNull(formObj.find("input[name=apl2Addr]").val())) {
		alert("주소를 입력하세요.");
		formObj.find("input[name=apl2Addr]").focus();
		return false;
	}
	
	if (com.wise.util.isNull(formObj.find("input[name=aplSj]").val())) {
		alert("청구제목을 입력하세요.");
		formObj.find("input[name=aplSj]").focus();
		return false;
	}
	
	if (com.wise.util.isNull(formObj.find("textarea[name=aplDtsCn]").val())) {
		alert("청구내용을 입력하세요.");
		formObj.find("textarea[name=aplDtsCn]").focus();
		return false;
	}
	
	return true;
}

/*
 * 실명인증 관련 validation
 */
function isRealValidation() {
	var objTab = getTabShowObj();//탭이 oepn된 객체가져옴
	var formObj = objTab.find("form[name=writeAccount-dtl-form]");
	
	if ( com.wise.util.isNull(formObj.find("input[name=aplPn]").val()) ) {
		alert("청구인 이름을 입력하세요");
		formObj.find("input[name=aplPn]").focus();
		return false;
	}
	if (com.wise.util.isNull(formObj.find("input[name=aplRno1]").val())  ) {
		alert("청구인 주민등록번호를 입력하세요.");
		formObj.find("input[name=aplRno1]").focus();
		return false;
	}
	/*if (com.wise.util.isNull(formObj.find("input[name=aplRno2]").val())  ) {
		alert("청구인 주민등록번호를 입력하세요.");
		formObj.find("input[name=aplRno2]").focus();
		return false;
	}*/
	return true;
}
//접수관련 
function infoRcpValidation(){
	var objTab = getTabShowObj();//탭이 oepn된 객체가져옴
	var formObj = objTab.find("form[name=writeAccount-dtl-form]");
	
	if (com.wise.util.isNull(formObj.find("input[name=dealDlnDt]").val())) {
		alert("처리기한을 입력하세요.");
		formObj.find("input[name=dealDlnDt]").focus();
		return false;
	}
	
	/*if (com.wise.util.isNull(formObj.find("input[name=aplDeptNm]").val())) {
		alert("담당기관 부서정보를 선택하세요.");
		return false;
	}*/
	
	return true;
}

//이송처리
function infoTrsValidation(){
	var formObj = getTabFormObj("writeAccount-dtl-form");
	
	var relAplInstCd = formObj.find("input[name=relAplInstCd]").val();
	
	var value = "";
	
	formObj.find("input[name=aplDealInstCd]:checked").each(function() {
		value += $(this).val() + ",";
	});
	
	value = value.substr(0, value.length-1);
	
	//이송기관을 선택 안했을때 
	if(value.length == 0){
		alert("최소 한개의 기관을 선택하세요.");
		return;
	}
	
	//접수기관이 이송기관이랑 같을때
	
	if(value == relAplInstCd){
		alert("이송 할 대상이 없습니다.");
		return;
	}
	
	formObj.find("input[name=aplDealInstCdArr]").val(value);
	
	return true;
	
}

////////////////////////////////////////////////////////////////////////////////
//기타 함수
////////////////////////////////////////////////////////////////////////////////

//달력관련 함수
function datePickerInit() {
	var objTab = getTabShowObj();//탭이 oepn된 객체가져옴
	var formObj = objTab.find("form[name=statMainForm]");
	
	formObj.find("input[name=startAplDt],   input[name=endAplDt]").datepicker(setCalendarFormat('yymmdd'));
	formObj.find("input[name=startDcsNtcDt],   input[name=endDcsNtcDt]").datepicker(setCalendarFormat('yymmdd'));
	formObj.find("input[name=startAplDt],   input[name=endAplDt]").attr("readonly", true);
	formObj.find("input[name=startDcsNtcDt],   input[name=endDcsNtcDt]").attr("readonly", true);
	datepickerTrigger(); 
	// 시작-종료 일자보다 이전으로 못가게 세팅
	formObj.find('input[name=startAplDt]').datepicker('option', 'onClose',  function( selectedDate ) {$("input[name=endAplDt]").datepicker( "option", "minDate", selectedDate );});
	formObj.find('input[name=endAplDt]').datepicker('option', 'onClose',  function( selectedDate ) {	$("input[name=startAplDt]").datepicker( "option", "maxDate", selectedDate );});
	
	formObj.find('input[name=startDcsNtcDt]').datepicker('option', 'onClose',  function( selectedDate ) {$("input[name=endDcsNtcDt]").datepicker( "option", "minDate", selectedDate );});
	formObj.find('input[name=endDcsNtcDt]').datepicker('option', 'onClose',  function( selectedDate ) {	$("input[name=startDcsNtcDt]").datepicker( "option", "maxDate", selectedDate );});
}


//사업자 법호 입력 포거스 이동 
function moveBnoFocus() {
	
	var objTab = getTabShowObj();//탭이 oepn된 객체가져옴
	var formObj = objTab.find("form[name=writeAccount-dtl-form]");
	
 	if(formObj.find('input[name=aplBno1]').val().length == 3) {
 		if(event.keyCode == 16 || event.keyCode == 9) {
			return;
		} else {
			formObj.find('input[name=aplBno2]').focus();
		}
	}

	if(formObj.find('input[name=aplBno2]').val().length == 2) {
 		if(event.keyCode == 16 || event.keyCode == 9) {
			return;
		} else {
			formObj.find('input[name=aplBno3]').focus();
		}
	}
	
}

//숫자만 입력
function validNumOnly(obj) {
	
	strb = obj.val().toString();
	
	strb = strb.replace(/[^0-9]/g, 'ㄱ');
	
	if(/ㄱ/i.test(strb)){
		alert("숫자만 입력이 가능합니다."); 
		strb = strb.replace(/[^0-9]/g, ''); 
		obj.val(strb);  
	} 
}


//바이트 체크
function byteCheck(val, name){
	var objTab = getTabShowObj();//탭이 oepn된 객체가져옴
	var formObj = objTab.find("form[name=writeAccount-dtl-form]");
	
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
	formObj.find("input[name="+name+"]").val( numberWithCommas(((cnt *2) + temp_str.length)));
	return ((cnt *2) + temp_str.length);
}

//텍스트박스 글자수 체크
function textAreaLenChk(obj, name, len){
	rtn = byteCheck(obj.val(), name);
	if(rtn > len){
	  alert(numberWithCommas(len)+'byte 이상 초과 할 수 없습니다.');
	  for(var i=rtn; i > len; i--){
		  obj.val(trim(obj.val()).substring(0, obj.val().length-1));
		  if(byteCheck(obj.val(), name) <= len){
		  	break;
		  }
	  }
		rtn = byteCheck(obj.val(), name);
	  return;
	}
}


function trim(str){
   str = str.replace(/(^\s*)|(\s*$)/g, "");
   return str;
}

//문자열 날짜형식으로 변환
function parseDate(str){
	var date = "";
	var year = str.substr(0, 4);
    var month = str.substr(4, 2);
    var day = str.substr(6, 2);
    if(str.length == 12){
	    var hour = str.substr(8, 2);
	    var min = str.substr(10, 2);
	    date = year + "-" + month + "-" + day + " " +  hour + ":"+min 
    }else{
    	date = year + "-" + month + "-" + day
    }
    
    
    return date
}

//파일을 다운로드 한다.
/*function downloadFile(params) {
	var objTab = getTabShowObj();//탭이 oepn된 객체가져옴
	var formObj = objTab.find("form[name=writeAccount-dtl-form]");
	//파일명에 공백, 특수문자(#)일 경우
	params = params.replace(/\s/g, "nbsp");
	params = params.replace(/#/g, "sharp");
	console.log(params);
	formObj.find("iframe[id=download-frame]").attr("src", com.wise.help.url("/admin/expose/downloadOpnAplFile.do") + params);
}*/

//파일을 다운로드 한다.
function downloadFile(fileNm, filePath) {
	var form = $("form[name=file-download-form]");
	//파일명에 공백, 특수문자(#)일 경우
	fileNm = fileNm.replace(/\s/g, "nbsp");
	fileNm = fileNm.replace(/#/g, "sharp");
	
	form.find("input[name=fileNm]").val(fileNm) ;
	form.find("input[name=filePath]").val(filePath) ;
	form.attr("action",com.wise.help.url("/admin/expose/downloadOpnAplFile.do"));
	form.attr("target", "hidden-iframe");
	form.submit();
}

//공개결정통보내역 상세화면으로 이동
function fn_directPage(){
	var objTab = getTabShowObj();//탭이 oepn된 객체가져옴
	var formObj = objTab.find("form[name=writeAccount-dtl-form]");
	var form = $("form[name=opnzDcsForm]");
	
	var aplNo = formObj.find("input[name=aplNo]").val();
	
	form.find("input[name=aplNo]").val(aplNo) ;
	form.attr("action", com.wise.help.url("/admin/expose/searchOpnDcsPage.do"));
	form.attr("target", "_self");
	form.submit();
	
} 


//출력 및 저장
function fn_print() {
	var objTab = getTabShowObj();//탭이 oepn된 객체가져옴
	var formObj = objTab.find("form[name=statMainForm]");
	var formPrint = $("form[name=printForm]");
	 
	formPrint.find("input[name=width]").val("680");
	formPrint.find("input[name=height]").val("700");
	formPrint.find("input[name=title]").val("정보공개 청구서 목록 출력");
	
	var mrdParamVal = "/rp [";
	mrdParamVal += formObj.find("[name=aplDealInstCd]").val();
	mrdParamVal += "] [";
	mrdParamVal += formObj.find("select[name=prgStatCd]").val();
	mrdParamVal += "] [";
	mrdParamVal += formObj.find("input[name=aplSj]").val();
	mrdParamVal += "] [";
	mrdParamVal += formObj.find("input[name=aplDtsCn]").val();
	mrdParamVal += "] [";
	mrdParamVal += formObj.find("input[name=aplPn]").val();
	mrdParamVal += "] [";
	mrdParamVal += formObj.find("input[name=startAplDt]").val().split("-").join("");
	mrdParamVal += "] [";
	mrdParamVal += formObj.find("input[name=endAplDt]").val().split("-").join("");
	mrdParamVal += "] [";
	mrdParamVal += formObj.find("select[name=opbYn]").val();
	mrdParamVal += "] [";
	mrdParamVal += formObj.find("input[name=startDcsNtcDt]").val().split("-").join("");
	mrdParamVal += "] [";
	mrdParamVal += formObj.find("input[name=endDcsNtcDt]").val().split("-").join("");
	mrdParamVal += "] [";
	mrdParamVal += formObj.find("input[name=rcpDtsNo]").val();
	mrdParamVal += "]";
	
	formPrint.find("input[name=mrdParam]").val(mrdParamVal);
			
	window.open('', 'popup', 'width=680, height=700, resizable=yes, location=no;');
	
	formPrint.attr("action", com.wise.help.url("/admin/expose/infoPrintPage/printNewOpnSearch.do"));
	formPrint.attr("target", "popup");
	formPrint.submit();
}

//출력 및 저장 (상세페이지)
function infoPrint(div){
	var objTab = getTabShowObj();//탭이 oepn된 객체가져옴
	var formObj = objTab.find("form[name=writeAccount-dtl-form]");
	var formPrint = $("form[name=printForm]");
	
	var aplNo = formObj.find("input[name=aplNo]").val();
	var cVersion = formObj.find("input[name=callVersion]").val();
	
	formPrint.find("input[name=mrdParam]").val("/rp ["+aplNo+"]") ;
	
	if(div == "apl"){
		//청구인정보 열람 로그
		insertLogAcsOpnzApl({aplNo: aplNo, acsCd: "CS112", acsPrssCd: "PR101"});
		
		formPrint.find("input[name=width]").val("680");
		formPrint.find("input[name=height]").val("700");
		formPrint.find("input[name=title]").val("정보공개 청구서 출력");
		window.open("","popup","width=680, height=700, resizable=yes, location=no;");

		if(cVersion == 'V1'){	//2단계 개선사업 이전일 경우 이전 통지서를 호출한다.
			formPrint.attr("action", com.wise.help.url("/admin/expose/infoPrintPage/printOpnapl.do"));
		}else{	//2단계 개선사업 이후일 경우 신규 통지서를 호출한다.
			/* 청구내용 확인 로직 추가 > 정보공개 청구서의 청구내용에 맞지 않을 경우(초과) 별지참조 처리*/
			var tArea = formObj.find("textarea[name=printAplModDtsCn]").val(); //청구내용 - 출력용
			var totLine = chkTotLine(tArea);
			if(totLine > 15){ //정보공개 청구서의 청구내용은 최대 15줄
				formPrint.attr("action", com.wise.help.url("/admin/expose/infoPrintPage/printNewOpnaplRefer.do"));
			}else{
				formPrint.attr("action", com.wise.help.url("/admin/expose/infoPrintPage/printNewOpnapl.do"));
			}
		}
	}else if(div == "rcp"){
		//청구인정보 열람 로그
		insertLogAcsOpnzApl({aplNo: aplNo, acsCd: "CS113", acsPrssCd: "PR101"});
		
		formPrint.find("input[name=width]").val("680");
		formPrint.find("input[name=height]").val("500");
		formPrint.find("input[name=title]").val("접수증 출력");
		window.open("","popup","width=680, height=500, resizable=yes, location=no;");
		
		if(cVersion == 'V1'){	//2단계 개선사업 이전일 경우 이전 통지서를 호출한다.
			formPrint.attr("action", com.wise.help.url("/admin/expose/infoPrintPage/printOpnrcp.do"));
		}else{	//2단계 개선사업 이후일 경우 신규 통지서를 호출한다.
			formPrint.attr("action", com.wise.help.url("/admin/expose/infoPrintPage/printNewOpnrcp.do"));
		}
	}else if(div == "dcs"){
		formPrint.find("input[name=width]").val("680");
		formPrint.find("input[name=height]").val("700");
		formPrint.find("input[name=title]").val("정보공개 결정통지서 출력");
		window.open("","popup","width=680, height=700, resizable=yes, location=no;");
		
		if(cVersion == 'V1'){	//2단계 개선사업 이전일 경우 이전 통지서를 호출한다.
			formPrint.attr("action", com.wise.help.url("/admin/expose/infoPrintPage/printOpndcs.do"));
		}else{	//2단계 개선사업 이후일 경우 신규 통지서를 호출한다.
			/* 청구내용 확인 로직 추가 > 결정통지서의 정보공개청구내용에 맞지 않을 경우(초과) 별지참조 처리*/
			var tArea = formObj.find("textarea[name=printAplModDtsCn]").val(); //청구내용 - 출력용
			var totLine = chkTotLine(tArea);
			/* 비공개 내용 및 사유 확인 로직 추가 > 결정통지서의 비공개 내용 및 사유에 맞지 않을 경우(초과) 별지참조 처리*/
			var tClsdArea = formObj.find("textarea[name=printClsdRmk]").val(); //비공개사유 - 출력용
			var totClsdLine = chkTotLine(tClsdArea);
			if(totLine > 8 && totClsdLine > 4){ //결정통지서의 정보공개청구내용은 최대 8줄, 비공개 내용 및 사유는 최대 4줄
				formPrint.attr("action", com.wise.help.url("/admin/expose/infoPrintPage/printNewOpndcsRefer3.do"));
			}else{
				if(totClsdLine > 4){
					formPrint.attr("action", com.wise.help.url("/admin/expose/infoPrintPage/printNewOpndcsRefer2.do"));
				}else if(totLine > 8){
					formPrint.attr("action", com.wise.help.url("/admin/expose/infoPrintPage/printNewOpndcsRefer1.do"));
				}else{			
					formPrint.attr("action", com.wise.help.url("/admin/expose/infoPrintPage/printNewOpndcs.do"));
				}
			}
		}
	}else if(div == "trsf"){
		formPrint.find("input[name=width]").val("680");
		formPrint.find("input[name=height]").val("700");
		formPrint.find("input[name=title]").val("이송통지서 출력");
		window.open("","popup","width=680, height=700, resizable=yes, location=no;");

		if(cVersion == 'V1'){	//2단계 개선사업 이전일 경우 이전 통지서를 호출한다.
			formPrint.attr("action", com.wise.help.url("/admin/expose/infoPrintPage/printOpntrn.do"));
		}else{	//2단계 개선사업 이후일 경우 신규 통지서를 호출한다.
			/* 청구내용 확인 로직 추가 > 정보공개 청구서 기관이송 통지서의 청구정보내용에 맞지 않을 경우(초과) 별지참조 처리*/
			var tArea = formObj.find("textarea[name=printAplModDtsCn]").val(); //청구내용 - 출력용
			var totLine = chkTotLine(tArea);
			if(totLine > 9){ //정보공개 청구서 기관이송 통지서의 청구정보내용은 최대 9줄
				formPrint.attr("action", com.wise.help.url("/admin/expose/infoPrintPage/printNewOpntrnRefer.do"));
			}else{
				formPrint.attr("action", com.wise.help.url("/admin/expose/infoPrintPage/printNewOpntrn.do"));
			}
		}
	}else if(div == "non"){
		formPrint.find("input[name=width]").val("680");
		formPrint.find("input[name=height]").val("700");
		formPrint.find("input[name=title]").val("부존재 등 통지서 출력");
		window.open("","popup","width=680, height=700, resizable=yes, location=no;");

		if(cVersion == 'V1'){	//2단계 개선사업 이전일 경우 이전 통지서를 호출한다.
			formPrint.attr("action", com.wise.help.url("/admin/expose/infoPrintPage/printNonext.do"));
		}else{	//2단계 개선사업 이후일 경우 신규 통지서를 호출한다.
			/* 청구내용 확인 로직 추가 > 정보 부존재 등 통지서의 정보공개청구내용에 맞지 않을 경우(초과) 별지참조 처리*/
			var tArea = formObj.find("textarea[name=printAplModDtsCn]").val(); //청구내용 - 출력용
			var totLine = chkTotLine(tArea);
			if(totLine > 11){ //정보 부존재 등 통지서의 정보공개청구내용은 최대 11줄
				formPrint.attr("action", com.wise.help.url("/admin/expose/infoPrintPage/printNewNonextRefer.do"));
			}else{
				formPrint.attr("action", com.wise.help.url("/admin/expose/infoPrintPage/printNewNonext.do"));
			}
		}
	}else if(div == "ext"){
		formPrint.find("input[name=width]").val("680");
		formPrint.find("input[name=height]").val("700");
		formPrint.find("input[name=title]").val("정보공개 결정기간 연장통지서 출력");
		window.open("","popup","width=680, height=700, resizable=yes, location=no;");
		
		if(cVersion == 'V1'){	//2단계 개선사업 이전일 경우 이전 통지서를 호출한다.
			formPrint.attr("action", com.wise.help.url("/admin/expose/infoPrintPage/printOpnext.do"));
		}else{	//2단계 개선사업 이후일 경우 신규 통지서를 호출한다.
			/* 청구내용 확인 로직 추가 > 공개 여부 결정기간 연장 통지서의 정보공개청구내용에 맞지 않을 경우(초과) 별지참조 처리*/
			var tArea = formObj.find("textarea[name=printAplModDtsCn]").val(); //청구내용 - 출력용
			var totLine = chkTotLine(tArea);
			if(totLine > 8){ //공개 여부 결정기간 연장 통지서의 정보공개청구내용은 최대 8줄
				formPrint.attr("action", com.wise.help.url("/admin/expose/infoPrintPage/printNewOpnextRefer.do"));
			}else{
				formPrint.attr("action", com.wise.help.url("/admin/expose/infoPrintPage/printNewOpnext.do"));
			}
		}		
	}
	formPrint.attr("target", "popup");
	formPrint.submit();
}

//팝업닫기후 액션
function popUpCloseEvent(aplNo){
	
	var tabId = "tabs-"+aplNo; //탭 id
	$("#"+tabId).closest("li").remove(); // 현재탭 닫기	
	
	$("#tabs-main").click();

	doAction("search"); // 다시조회
}

//국회사무처 정보공개청구 양식파일 다운로드
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

/**
 * 청구인정보 열람 로그
 * @Param	type 액션타입 
 */
function insertLogAcsOpnzApl(param) {
	var url = "/admin/expose/insertLogAcsOpnzApl.do";
	
	if ( !gfn_isNull(url) ) {
		doAjax({url: url, params: param});
	}
}

/**
 * 숫자 천단위 콤마
 * @param str
 * @retruns
 */
function numberWithCommas(str) {
    return str.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
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
