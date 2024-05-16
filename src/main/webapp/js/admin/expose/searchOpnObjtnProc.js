/*
 * @(#)searchOpnObjtnProc.js 1.0 2019/08/12
 * 
 * COPYRIGHT (C) 2013 WISEITECH CO., LTD. ALL RIGHTS RESERVED.
 */

/**
 * 이의신청내역 스크립트 파일이다
 *
 * @author Softon
 * @version 1.0 2019/08/12
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
		
		if(!frm.aplDtFrom.value == '') {
			if(frm.aplDtTo.value == '') frm.aplDtTo.value = sysdate;
		}
		
		if(!frm.startDcsNtcDt.value == '') {
			if(frm.endDcsNtcDt.value == '') frm.endDcsNtcDt.value = sysdate;
		}
		//============================================
		
		//조회
		doAction("search");
    });
	$("button[name=btn_xlsDown]").bind("click", function(event) {
		//엑셀다운
		doAction("excel");
    });
	$("button[name=btn_printSave]").bind("click", function(event) {
		//출력 및 저장
		fn_print();
    });
	
	//신청인 enter
	$("input[name=aplPn]").bind("keydown", function(event) {
        // 엔터키인 경우
        if (event.which == 13) {
        	doAction("search");
            return false;
        }
    });
	
	//청구제목 enter
	$("input[name=aplSj]").bind("keydown", function(event) {
        // 엔터키인 경우
        if (event.which == 13) {
        	doAction("search");
            return false;
        }
    });
	
	//신청내용 enter
	$("input[name=objtnRson]").bind("keydown", function(event) {
        // 엔터키인 경우
        if (event.which == 13) {
        	doAction("search");
            return false;
        }
    });
	
	//접수번호 enter
	$("input[name=rcpDtsNo]").bind("keydown", function(event) {
        // 엔터키인 경우
        if (event.which == 13) {
        	doAction("search");
            return false;
        }
    });
	
	//신청일자 초기화 
	$("button[name=aplDt_reset]").bind("click", function(e) {
		$("input[name=aplDtFrom], input[name=aplDtTo]").val("");
	});
	
	//통지일자 초기화 
	$("button[name=dcsNtcDt_reset]").bind("click", function(e) {
		$("input[name=startDcsNtcDt], input[name=endDcsNtcDt]").val("");
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
	var formObj = getTabFormObj("detail-form");
	var classObj = $("."+tabContentClass);
	var actObj = setTabForm(classObj); // 0: form data, 1: form 객체
	var sheet = window["sheet"];

	switch(sAction) {                       
		case "search":
			ajaxBeforeSendAdmin(com.wise.help.url("/admin/ajaxBeforeSendAdmin.do")); //IbSheet 조회전 세션 체크
			var param = {PageParam: "page", Param: "rows=50"+"&"+actObj[0]};
			sheet.DoSearchPaging(com.wise.help.url("/admin/expose/searchOpnObjtnProc.do"), param);
			break;
		case "receipt" :	//접수
			comData("R");
			break;
		case "cancle" :	//취하
			comData("C");
			break;
		case "save" :		//저장(결과등록)
			saveData("S");
			break;			
		case "objtnProd" : 	//이의신청 결정기한연장
			window.open(com.wise.help.url("/admin/expose/popup/opnObjtnProdPopup.do") + "?aplNo=" + formObj.find("input[name=aplNo]").val() + "&objSno=" + formObj.find("input[name=objtnSno]").val() , "list", "fullscreen=no, width=800, height=750, scrollbars=yes");
			break;
		case "open" :
			openData("O");
			break;			
		case "excel":
			sheet.Down2Excel({FileName:'정보공개_이의신청내역.xls',SheetName:'sheet'});
			break;			
	}
}

/**
 * 데이터 처리 > 단계 01
 * @param action	R:접수 / C:이의취하
 */
function comData(action) {
	var formObj = getTabFormObj("detail-form");
	var tVal = action == "R" ? "접수" : "이의취하";
	formObj.find("input[name=actionTy]").val(action);
	formObj.ajaxSubmit({
		url : com.wise.help.url("/admin/expose/comOpnObjtnProc.do")
		, async : false
		, type : 'post'
		, dataType: 'json' 
		, contentType : 'application/x-www-form-urlencoded;charset=UTF-8'
		, beforeSubmit : function() {
			//submit 전 validation 체크
			
			if ( comValidation(action) ) {
				if(action == "R"){
					if ( !confirm(tVal+" 하시겠습니까?") )	return false;
				}else{
					if ( !confirm("이의취하를 하면 해당 이의신청 대상의 이의신청이 불가합니다.\n\n이의신청을 취하 하시겠습니까?") )	return false;
				}
			} else {
				return false;
			}
		}	
		, success : function(res, status) {
			doAjaxMsg(res, "");
			afterTabRemove(res)
		}
		, error: function(jqXHR, textStatus, errorThrown) {
			alert("처리 도중 에러가 발생하였습니다.");
		}
	});
}

/**
 * 데이터 처리 > 단계 02
 * @param action	S:저장
 */
function saveData(action) {
	var formObj = getTabFormObj("detail-form");
	var tVal = action == "S" ? "이의신청 결과를 저장" : "";
	formObj.find("input[name=actionTy]").val(action);
	formObj.ajaxSubmit({
		url : com.wise.help.url("/admin/expose/saveOpnObjtnProc.do")
		, async : false
		, type : 'post'
		, dataType: 'json' 
		, contentType : 'application/x-www-form-urlencoded;charset=UTF-8'
		, beforeSubmit : function() {
			//submit 전 validation 체크
			
			if ( saveValidation(action) ) {
				if ( !confirm(tVal+" 하시겠습니까?") )	return false;
			} else {
				return false;
			}
		}	
		, success : function(res, status) {
			doAjaxMsg(res, "");
			afterTabRemove(res)
		}
		, error: function(jqXHR, textStatus, errorThrown) {
			alert("처리 도중 에러가 발생하였습니다.");
		}
	});
}

/**
 * 데이터 공개실시
 * @param action O 공개실시
 */
function openData(action) {
	var formObj = getTabFormObj("detail-form");
	formObj.ajaxSubmit({
		url : com.wise.help.url("/admin/expose/openStartOpnObjtn.do")
		, async : false
		, type : 'post'
		, dataType: 'json' 
		, contentType : 'application/x-www-form-urlencoded;charset=UTF-8'
		, beforeSubmit : function() {
			//submit 전 validation 체크
			
			if ( openValidation(action) ) {
				if ( !confirm("공개실시 하시겠습니까?") )	return false;
			} else {
				return false;
			}
		}	
		, success : function(res, status) {
			doAjaxMsg(res, "");
			afterTabRemove(res)
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
	var formObj = getTabFormObj("detail-form");
	var dataDtl = data.DATA;
	var objtnData = data.DATA2.objtnDealCodeList;//이의신청 결정
	var opbData = data.DATA2.opbFomCodeList;		//공개방법 > 공개형태
	var giveData = data.DATA2.giveMthCodeList; 	//공개방법 > 교부방법
	var clsdObjtnData = data.DATA2.OBJTN_CLSD_LIST; //이의신청 대상
	
	var objtnStatCd = data.DATA2.objtnStatCd;
	var nextRcpNo = data.DATA2.nextRcpNo;
	var rcpNo = data.DATA2.rcpNo; //접수번호
		
	//기본변수 데이터 할당
	tab.ContentObj.find("input[name=aplNo]").val(dataDtl.aplNo);
	tab.ContentObj.find("input[name=apl_no]").val(dataDtl.aplNo);
	tab.ContentObj.find("input[name=objtnSno]").val(dataDtl.objtnSno);
	tab.ContentObj.find("input[name=rcpDtm]").val(dataDtl.rcpDt);
	tab.ContentObj.find("input[name=objtnStatCd]").val(objtnStatCd);
	tab.ContentObj.find("input[name=rcpNo]").val(rcpNo);//접수번호
	tab.ContentObj.find("input[name=objtnDt]").val(dataDtl.objtnDt);
	
	tab.ContentObj.find("input[name=objtnRgDiv]").val(dataDtl.objtnRgDiv);
	tab.ContentObj.find("input[name=dcsNtcRcvmth]").val(dataDtl.dcsNtcRcvMthCd);
	tab.ContentObj.find("input[name=dcsNtcRcvmthSms]").val(dataDtl.dcsNtcRcvMthSms);
	tab.ContentObj.find("input[name=dcsNtcRcvmthMail]").val(dataDtl.dcsNtcRcvMthMail);
	tab.ContentObj.find("input[name=dcsNtcRcvmthTalk]").val(dataDtl.dcsNtcRcvMthTalk);
	tab.ContentObj.find("input[name=aplEmail]").val(dataDtl.aplEmailAddr);
	tab.ContentObj.find("input[name=aplDealInstcd]").val(dataDtl.aplDealInstcd);
	tab.ContentObj.find("input[name=aplMblPno]").val(dataDtl.aplMblPno);
	tab.ContentObj.find("input[name=aplPn]").val(dataDtl.aplPn);
	tab.ContentObj.find("input[name=objtnDR]").val(dataDtl.objtnDealRsltCd);
	tab.ContentObj.find("input[name=rcp_dts_no]").val(dataDtl.rcpDtsNo);
	tab.ContentObj.find("input[name=fee_rdtn_cd]").val(dataDtl.feeRdtnCd);
	tab.ContentObj.find("input[name=dcsProdEtYn]").val(dataDtl.dcsProdEtYn);
	
	tab.ContentObj.find("input[name=inst_pno]").val(dataDtl.instPno);
	tab.ContentObj.find("input[name=inst_fax_no]").val(dataDtl.instFaxNo);
	tab.ContentObj.find("input[name=inst_chrg_dept_nm]").val(dataDtl.instChrgDeptNm);
	tab.ContentObj.find("input[name=inst_chrg_cent_cgp_1_nm]").val(dataDtl.instChrgCentCgp1Nm);
	tab.ContentObj.find("input[name=inst_chrg_cent_cgp_2_nm]").val(dataDtl.instChrgCentCgp2Nm);
	tab.ContentObj.find("input[name=inst_chrg_cent_cgp_3_nm]").val(dataDtl.instChrgCentCgp3Nm);
	 
	tab.ContentObj.find("input[name=callVersion]").val(dataDtl.callVersion); //2단계 개선사업 - 반영 이전/이후 확인
	
	//상태값에 따른 화면 및 버튼 컨트롤
	if(objtnStatCd == "01"){ //신청
		tab.ContentObj.find("h3[class=text-title2]").text("이의신청 접수");
		tab.ContentObj.find("tr[name=comTr01]").show();
		
		//버튼노출 > 접수, 이의취하
		tab.ContentObj.find("a[name=btnReceipt]").show();	//접수
		tab.ContentObj.find("a[name=btnCancle]").show();	//이의취하
	}
	
	if(objtnStatCd == "02" || objtnStatCd == "04"){ //처리중, 기간연장
		tab.ContentObj.find("h3[class=text-title2]").text("이의신청 결과등록");
		tab.ContentObj.find("tr[name=comTr02]").show();
		tab.ContentObj.find("div[name=comDiv24]").show();
		
		if(dataDtl.dcsProdEtYn == "0") tab.ContentObj.find("tr[name=comTr04]").show(); //결정연장 정보가 있다면 노출
		tab.ContentObj.find("div[name=comDiv03]").hide();
		
		//버튼노출 > 저장
		tab.ContentObj.find("a[name=btnSave]").show();	//저장		
		if(dataDtl.dcsProdEtYn != "0") tab.ContentObj.find("a[name=btnObjtnProd]").show(); //결정기간연장
		if(objtnStatCd == "04") tab.ContentObj.find("a[name=btnObjtnExt]").show(); //연장통지서출력
	}
	
	if(objtnStatCd == "03"){ //통지완료
		tab.ContentObj.find("h3[class=text-title2]").text("이의신청 결과");
		tab.ContentObj.find("tr[name=comTr03]").show();
		tab.ContentObj.find("div[name=comDiv03]").show();
		
		if(dataDtl.dcsProdEtYn == "0") tab.ContentObj.find("tr[name=comTr04]").show(); //결정연장 정보가 있다면 노출
		tab.ContentObj.find("div[name=comDiv24]").hide();
		
		//버튼노출
		tab.ContentObj.find("a[name=btnObjtnDcs]").show();	//결정통지서출력
	}

	if(objtnStatCd == "05"){ //결정통지
		tab.ContentObj.find("h3[class=text-title2]").text("이의신청 결과");
		tab.ContentObj.find("tr[name=comTr03]").show();
		tab.ContentObj.find("div[name=comDiv03]").show();
		tab.ContentObj.find("div[name=comDiv05]").show(); //수수료 납부완료
		
		if(dataDtl.dcsProdEtYn == "0") tab.ContentObj.find("tr[name=comTr04]").show(); //결정연장 정보가 있다면 노출
		tab.ContentObj.find("div[name=comDiv24]").hide();
		
		//버튼노출
		tab.ContentObj.find("a[name=btnOpen]").show();		//공개실시
		tab.ContentObj.find("a[name=btnSwitch]").show();	//수정 > 화면전환
	}

	//처리상태이력 보이게
	tab.ContentObj.find("div[name=opnzHist]").css("display", "block");
	
	//***** 데이터를 화면에 노출한다. *****//
	
	//처리상태이력 텍스트 이의신청 상태 관계없이 강제 삽입 2020.04.06 김재한
	tab.ContentObj.find("div[name=opnzHist]").find("h3[class=text-title2]").text("처리상태이력");
	
	//처리상태이력 테이블 2020.04.06 김재한
	var histHtml = "";
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
	
	
	//이의신청번호
	if(dataDtl.rcpNo != null) tab.ContentObj.find("input[name=rcpNo]").val(dataDtl.rcpNo);
	//접수번호
	if(objtnStatCd == "01"){ //처리상태 - 신청
		tab.ContentObj.find("input[name=rcpDtsNo]").val(nextRcpNo);
	}else{
		tab.ContentObj.find("input[name=rcpDtsNo]").val(dataDtl.rcpDtsNo);
		tab.ContentObj.find("label[name=rcpDtsNo]").text(dataDtl.rcpDtsNo);
	}
	
	//신청일자
	if(dataDtl.objDt != null){
		tab.ContentObj.find("label[name=objDt]").text(dataDtl.objtnDt);
	}
	//접수일자
	if(dataDtl.rcpDt != null){
		tab.ContentObj.find("label[name=rcpDt]").text(dataDtl.rcpDt);
	}
	
	//신청인정보 > 이름
	if(dataDtl.aplPn != null){
		tab.ContentObj.find("label[name=aplPn]").text(dataDtl.aplPn);
	}

	//신청인정보 > 주민등록번호 앞자리
	if(dataDtl.aplRno1 != null){
		tab.ContentObj.find("label[name=aplRno1]").text(dataDtl.aplRno1);
	}
	
	//신청인정보 > 법인명 등 대표자
	if(dataDtl.aplCorpNm != null){
		tab.ContentObj.find("label[name=aplCorpNm]").text(dataDtl.aplCorpNm);
	}
	
	//신청인정보 > 사업자등록번호
	if(dataDtl.aplBno != null){
		tab.ContentObj.find("label[name=aplBno]").text(dataDtl.aplBno);
	}
	
	//신청인정보 > 주소
	if(dataDtl.aplZpno != null){
		tab.ContentObj.find("label[name=aplZpno]").text(dataDtl.aplZpno);
	}
	if(dataDtl.apl1Addr != null){
		tab.ContentObj.find("label[name=aplAddr1]").text(dataDtl.apl1Addr);
	}
	if(dataDtl.apl2Addr != null){
		tab.ContentObj.find("label[name=aplAddr2]").text(dataDtl.apl2Addr);
	}
	
	//신청인정보 > 전화번호
	if(dataDtl.aplPno != null){
		tab.ContentObj.find("label[name=aplPno]").text(dataDtl.aplPno);
	}

	//신청인정보 > 모사전송번호
	if(dataDtl.aplFaxNo != null){
		tab.ContentObj.find("label[name=aplFaxNo]").text(dataDtl.aplFaxNo);
	}
	
	//신청인정보 > 전자우편
	if(dataDtl.aplEmailAddr != null){
		tab.ContentObj.find("label[name=aplEmail]").text(dataDtl.aplEmailAddr);
	}	

	//신청인정보 > 휴대전화번호
	if(dataDtl.aplMblPno != null){
		tab.ContentObj.find("label[name=aplMblPno]").text(dataDtl.aplMblPno);
	}	
	
	if(dataDtl.callVersion == "V1"){
		//비공개대상
		if(dataDtl.clsdRmk != null){
			tab.ContentObj.find("label[name=clsdRmk]").html(com.wise.help.toHtmlBr(dataDtl.clsdRmk));
		}	
		
		//이의신청의 취지 및 이유
		if(dataDtl.objtnRson != null){
			tab.ContentObj.find("label[name=objtnRson]").html(com.wise.help.toHtmlBr(dataDtl.objtnRson));
		}
	} else {
		//비공개대상
		if(dataDtl.newClsdRmk != null){
			tab.ContentObj.find("label[name=clsdRmk]").html(com.wise.help.toHtmlBr(dataDtl.newClsdRmk));
		}	
		
		//이의신청의 취지 및 이유
		if(dataDtl.newObjtnRson != null){
			tab.ContentObj.find("label[name=objtnRson]").html(com.wise.help.toHtmlBr(dataDtl.newObjtnRson));
			
			tab.ContentObj.find("textarea[name=printObjtnRson]").val(dataDtl.newObjtnRson);
		}		
	}

	//통지서 수령유무
	if(dataDtl.objtnNtcsYn != null){
		var objtnNtcs = "";
		if(dataDtl.objtnNtcsYn == "0"){
			objtnNtcs += "정보(공개,부분공개,비공개)결정통지서를 "+dataDtl.dcsNtcDt+" 에 받았음.";
		}else{
			objtnNtcs += "정보(공개,부분공개,비공개)결정통지서를 받지 못했음. ";
			objtnNtcs += "(법 제11조제5항의 규정에 의하여 비공개 결정이 있는것으로 보는날은 "+dataDtl.dcsNtcDt+" 임.";
		}
		tab.ContentObj.find("label[name=objtnNtcs]").text(objtnNtcs);
	}	


	
	var fileHtml = "";
	//첨부문서
	if(dataDtl.objtnAplFlNm != null){
		fileHtml = "<a href=\"javascript:;\" style=\"text-decoration:none;\">";
		fileHtml += "<img src=\"/images/admin/icon_file.png\" style=\"padding-right:4px;\" alt=\"첨부파일\" >";
		fileHtml += "<span style=\"color:#666;\">"+dataDtl.objtnAplFlNm+"</span>";
		fileHtml += "</a>";
		var objtnAplFlNm = dataDtl.objtnAplFlNm;
		var objtnAplFlPh = dataDtl.objtnAplFlPh;
        
		tab.ContentObj.find("div[name=fileArea]").append(fileHtml);
		
		tab.ContentObj.find("div[name=fileArea] > a").bind("click", function(event) {
            // 파일을 다운로드한다.
            downloadFile(objtnAplFlNm, objtnAplFlPh);
            return false;
        });
		
	}else{
		tab.ContentObj.find("div[name=fileArea]").append("해당없음");
	}

	//처리기관
	if(dataDtl.aplDealInstNm != null){
		tab.ContentObj.find("label[name=aplDealInstNm]").text(dataDtl.aplDealInstNm);
	}
	
	//수수료 > 감면여부
	if(dataDtl.objtnStatCd != null){
		tab.ContentObj.find("label[name=objtnStatCd]").text(dataDtl.objtnStatCd);
	}
	if(dataDtl.feeRdtnCdNm != null){
		tab.ContentObj.find("label[name=feeRdtnCdNm]").text(dataDtl.feeRdtnCdNm);
	}
	
	//수수료 > 감면사유
	if(dataDtl.feeRdtnRson != null){
		tab.ContentObj.find("label[name=feeRdtnRson]").text(dataDtl.feeRdtnRson);
	}else{
		tab.ContentObj.find("label[name=feeRdtnRson]").text("해당없음");
	}

	//수수료 > 첨부문서
	if(dataDtl.feeAttchflNm != null){
		fileHtml = "";
		fileHtml += "<a href=\"javascript:;\" style=\"text-decoration:none;\">";
		fileHtml += "<img src=\"/images/admin/icon_file.png\" style=\"padding-right:4px;\" alt=\"첨부파일\" >";
		fileHtml += "<span style=\"color:#666;\">"+dataDtl.feeAttchflNm+"</span>";
		fileHtml += "</a>";
		
		var feeAttchflNm = dataDtl.feeAttchflNm;
		var feeAttchFlPh = dataDtl.feeAttchFlPh;
        
		tab.ContentObj.find("div[name=feeFileArea]").append(fileHtml);
		
		tab.ContentObj.find("div[name=feeFileArea] > a").bind("click", function(event) {
            // 파일을 다운로드한다.
            downloadFile(feeAttchflNm, feeAttchFlPh);
            return false;
        });
		
	}else{
		tab.ContentObj.find("div[name=feeFileArea]").append("해당없음");
	}

	//연장 > 연장사유
	if(dataDtl.dcsProdEtRson != null){
		tab.ContentObj.find("label[name=dcsProdEtRson]").text(dataDtl.dcsProdEtRson);
	}

	//연장 > 연장결정기한
	if(dataDtl.dcsProdEtDt != null){
		tab.ContentObj.find("label[name=dcsProdEtDt]").text(dataDtl.dcsProdEtDt);
	}

	//연장 > 그 밖의 안내사항
	if(dataDtl.dcsProdEtc != null){
		tab.ContentObj.find("label[name=dcsProdEtc]").text(dataDtl.dcsProdEtc);
	}
	
	//이의결정 문서번호
	if(dataDtl.dcsObjtnDocNo != null){
		tab.ContentObj.find("input[name=dcs_objtn_doc_no]").val(dataDtl.dcsObjtnDocNo);
		tab.ContentObj.find("label[name=dcsObjtnDocNo]").text(dataDtl.dcsObjtnDocNo);
	}
	
	//이의신청 결정
	tab.ContentObj.find("div[name=objtnDealRsltArea]").empty();
	$.each(objtnData, function(key, value){
		var rHtml = "<input type='radio' name='objtn_deal_rslt' value='"+value.baseCd+"' class='border_none' onclick=\"fn_objtnDiv();\"/>"+value.baseNm+"&nbsp;"
		tab.ContentObj.find("div[name=objtnDealRsltArea]").append(rHtml);
	});
	if(dataDtl.objtnDealRsltCd != null){
		tab.ContentObj.find("input:radio[name=objtn_deal_rslt]:input[value="+dataDtl.objtnDealRsltCd+"]").prop("checked", true);
	}
	if(dataDtl.objtnDealRsltNm != null){
		tab.ContentObj.find("label[name=objtnDealRsltNm]").text(dataDtl.objtnDealRsltNm);
		tab.ContentObj.find("input[name=objtnDealRsltNm]").val(dataDtl.objtnDealRsltNm);
	}
	
	//이의신청 내용
	if(dataDtl.objtnModRson != null){
		tab.ContentObj.find("textarea[name=objtn_mod_rson]").val(dataDtl.objtnModRson);
		tab.ContentObj.find("label[name=objtnModRson]").html(com.wise.help.toHtmlBr(dataDtl.objtnModRson));
	}
	
	//결정내용
	if(dataDtl.objtnAplRsltCn != null){
		tab.ContentObj.find("textarea[name=objtnAplRslt]").val(dataDtl.objtnAplRsltCn);
		tab.ContentObj.find("label[name=objtnAplRsltCn]").html(com.wise.help.toHtmlBr(dataDtl.objtnAplRsltCn));
	}
		
	//결정내용 첨부파일
	if(dataDtl.attchFlNm != null){
		fileHtml = "";
		fileHtml += "<a href=\"javascript:;\" style=\"text-decoration:none;\">";
		fileHtml += "<img src=\"/images/admin/icon_file.png\" style=\"padding-right:4px;\" alt=\"첨부파일\" >";
		fileHtml += "<span style=\"color:#666;\">"+dataDtl.attchFlNm+"</span>";
		fileHtml += "</a>";
		var attchFlNm = dataDtl.attchFlNm;
		var attchFlPhNm = dataDtl.attchFlPhNm;
        
		tab.ContentObj.find("div[name=attchfileArea]").append(fileHtml);
		
		tab.ContentObj.find("div[name=attchfileArea] > a").bind("click", function(event) {
            // 파일을 다운로드한다.
            downloadFile(attchFlNm, attchFlPhNm);
            return false;
        });
		
	}	
	
	//공개방법 > 공개형태
	tab.ContentObj.find("div[name=opbFomArea]").empty();
	$.each(opbData, function(key, value){
		//var rHtml = "<input type='radio' name='opb_fom_val' value='"+value.baseCd+"' class='border_none' onclick=\"fn_choice('0','"+value.baseCd+"');\"/>"+value.baseNm+"&nbsp;"
		var rHtml = "<input type='checkbox' name='opb_fom_"+value.baseCd+"_yn' value='Y' class='border_none' onclick=\"fn_choice('0','"+value.baseCd+"');\"/>"+value.baseNm+"&nbsp;"
		tab.ContentObj.find("div[name=opbFomArea]").append(rHtml);
	});
	var opbFomEtc = dataDtl.opbFomEtc;
	if(opbFomEtc == null || opbFomEtc == undefined) opbFomEtc = "";
	var etcHtml = "<input type='text' name='opb_fom_etc' maxlength='50' size='25' value='"+opbFomEtc+"' style='display:none;'/>";
	tab.ContentObj.find("div[name=opbFomArea]").append(etcHtml);
	
	if(dataDtl.opbFomNm1 != null || dataDtl.opbFomNm2 != null || dataDtl.opbFomNm3 != null || dataDtl.opbFomNm4 != null || dataDtl.opbFomNm5 != null){
		if(dataDtl.opbFomNm1 != null) tab.ContentObj.find("input:checkbox[name=opb_fom_01_yn]").prop("checked", true);
		if(dataDtl.opbFomNm2 != null) tab.ContentObj.find("input:checkbox[name=opb_fom_02_yn]").prop("checked", true);
		if(dataDtl.opbFomNm3 != null) tab.ContentObj.find("input:checkbox[name=opb_fom_03_yn]").prop("checked", true);
		if(dataDtl.opbFomNm4 != null) tab.ContentObj.find("input:checkbox[name=opb_fom_04_yn]").prop("checked", true);
		if(dataDtl.opbFomNm5 != null){
			tab.ContentObj.find("input:checkbox[name=opb_fom_05_yn]").prop("checked", true);
			tab.ContentObj.find("input[name=opb_fom_etc]").show();
		}
	}else{
		if(dataDtl.opbFomVal != null){
			tab.ContentObj.find("input:checkbox[name=opb_fom_"+dataDtl.opbFomVal+"_yn]").prop("checked", true);
			if(dataDtl.opbFomVal == "05") tab.ContentObj.find("input[name=opb_fom_etc]").show();
		}else{
			tab.ContentObj.find("input:checkbox[name=opb_fom_01_yn]").prop("checked", true);
		}
	}

	//if(dataDtl.opbFomValNm != null){
	//	tab.ContentObj.find("label[name=opbFomValNm]").text(dataDtl.opbFomValNm);
	//	tab.ContentObj.find("label[name=opbFomEtc]").text(" "+opbFomEtc);
	//}
	
	if(dataDtl.opbFomNm1 != null || dataDtl.opbFomNm2 != null || dataDtl.opbFomNm3 != null || dataDtl.opbFomNm4 != null || dataDtl.opbFomNm5 != null){
		//tab.ContentObj.find("label[name=opbFomNm]").text(dataDtl.opbFomNm);
		var opbFormNm = "";
		if(dataDtl.opbFomNm1 != null){
			opbFormNm = dataDtl.opbFomNm1;
		}
		if(dataDtl.opbFomNm2 != null){
			if(opbFormNm != "") opbFormNm += ", " + dataDtl.opbFomNm2;
			else opbFormNm = dataDtl.opbFomNm2;
		}
		if(dataDtl.opbFomNm3 != null){
			if(opbFormNm != "") opbFormNm += ", " + dataDtl.opbFomNm3;
			else opbFormNm = dataDtl.opbFomNm3;
		}
		if(dataDtl.opbFomNm4 != null){
			if(opbFormNm != "") opbFormNm += ", " + dataDtl.opbFomNm4;
			else opbFormNm = dataDtl.opbFomNm4;
		}
		if(dataDtl.opbFomNm5 != null){
			if(opbFormNm != "") opbFormNm += ", " + dataDtl.opbFomNm5;
			else opbFormNm = dataDtl.opbFomNm5;
			
			if(opbFomEtc != "")  opbFormNm += "(" + opbFomEtc + ")";
		}
		tab.ContentObj.find("label[name=opbFomValNm]").text(opbFormNm);
	}
	
	//공개방법 > 교부방법
	tab.ContentObj.find("div[name=giveMthArea]").empty();
	$.each(giveData, function(key, value){
		//var rHtml = "<input type='radio' name='give_mth' value='"+value.baseCd+"' class='border_none' onclick=\"fn_choice('1','"+value.baseCd+"');\"/>"+value.baseNm+"&nbsp;";
		var rHtml = "<input type='checkbox' name='give_mth_"+value.baseCd+"_yn' value='Y' class='border_none' onclick=\"fn_choice('1','"+value.baseCd+"');\"/>"+value.baseNm+"&nbsp;"
		tab.ContentObj.find("div[name=giveMthArea]").append(rHtml);
	});
	console.log(dataDtl);
	var giveMthEtc = dataDtl.giveMthEtc;
	if(giveMthEtc == null || giveMthEtc == undefined) giveMthEtc = "";	
	var etcHtml = "<input type='text' name='give_mth_etc' maxlength='50' size='25' value='"+giveMthEtc+"' style='display:none;'/>";
	tab.ContentObj.find("div[name=giveMthArea]").append(etcHtml);

	if(dataDtl.giveMthNm1 != null || dataDtl.giveMthNm2 != null || dataDtl.giveMthNm3 != null || dataDtl.giveMthNm4 != null || dataDtl.giveMthNm5 != null){
		if(dataDtl.giveMthNm1 != null) tab.ContentObj.find("input:checkbox[name=give_mth_01_yn]").prop("checked", true);
		if(dataDtl.giveMthNm2 != null) tab.ContentObj.find("input:checkbox[name=give_mth_02_yn]").prop("checked", true);
		if(dataDtl.giveMthNm3 != null) tab.ContentObj.find("input:checkbox[name=give_mth_03_yn]").prop("checked", true);
		if(dataDtl.giveMthNm4 != null) tab.ContentObj.find("input:checkbox[name=give_mth_04_yn]").prop("checked", true);
		if(dataDtl.giveMthNm5 != null){
			tab.ContentObj.find("input:checkbox[name=give_mth_05_yn]").prop("checked", true);
			tab.ContentObj.find("input[name=give_mth_etc]").show();
		}
	}else{
		if(dataDtl.giveMth != null){
			tab.ContentObj.find("input:checkbox[name=give_mth_"+dataDtl.giveMth+"_yn]").prop("checked", true);
			if(dataDtl.aplTakMth == "05") tab.ContentObj.find("input[name=give_mth_etc]").show();
		}else{
			tab.ContentObj.find("input:checkbox[name=give_mth_01_yn]").prop("checked", true);
		}
	}

	//if(dataDtl.giveMthNm != null){
	//	tab.ContentObj.find("label[name=giveMthNm]").text(dataDtl.giveMthNm);
	//	tab.ContentObj.find("label[name=giveMthEtc]").text(" "+opbFomEtc);
	//}

	if(dataDtl.giveMthNm1 != null || dataDtl.giveMthNm2 != null || dataDtl.giveMthNm3 != null || dataDtl.giveMthNm4 != null || dataDtl.giveMthNm5 != null){
		//tab.ContentObj.find("label[name=giveMthNm]").text(dataDtl.aplTakMthNm);
		var giveMthNm = "";
		if(dataDtl.giveMthNm1 != null){
			giveMthNm = dataDtl.giveMthNm1;
		}
		if(dataDtl.giveMthNm2 != null){
			if(opbFormNm != "") giveMthNm += ", " + dataDtl.giveMthNm2;
			else giveMthNm = dataDtl.giveMthNm2;
		}
		if(dataDtl.giveMthNm3 != null){
			if(giveMthNm != "") giveMthNm += ", " + dataDtl.giveMthNm3;
			else giveMthNm = dataDtl.giveMthNm3;
		}
		if(dataDtl.giveMthNm4 != null){
			if(giveMthNm != "") giveMthNm += ", " + dataDtl.giveMthNm4;
			else giveMthNm = dataDtl.giveMthNm4;
		}
		if(dataDtl.giveMthNm5 != null){
			if(giveMthNm != "") giveMthNm += ", " + dataDtl.giveMthNm5;
			else giveMthNm = dataDtl.giveMthNm5;
			
			if(giveMthEtc != "")  giveMthNm += "(" + giveMthEtc + ")";
		}
		tab.ContentObj.find("label[name=giveMthNm]").text(giveMthNm);		
	}
	
	//달력
	formObj.find("input[name=opb_dtm]").datepicker(setCalendarFormat('yymmdd'));
	//formObj.find("input[name=opb_dtm]").attr("readonly", true);
	//공개일자
	if(dataDtl.opbDtm != null){
		tab.ContentObj.find("input[name=opb_dtm]").val(dataDtl.opbDtm);
		tab.ContentObj.find("label[name=opbDtm]").text(dataDtl.opbDtm);
	}
	
	//공개장소
	if(dataDtl.opbPlcNm != null){
		tab.ContentObj.find("input[name=opb_plc_nm]").val(dataDtl.opbPlcNm);
		tab.ContentObj.find("label[name=opbPlcNm]").text(dataDtl.opbPlcNm);
	}

	//수수료(A)
	var feeSum = 0;
	if(dataDtl.fee != null){
		tab.ContentObj.find("input[name=fee]").val(dataDtl.fee);
		tab.ContentObj.find("label[name=fee]").text(dataDtl.fee);
		feeSum = dataDtl.fee;
	}
	
	//우송료(B)
	if(dataDtl.zipFar != null){
		tab.ContentObj.find("input[name=zip_far]").val(dataDtl.zipFar);
		tab.ContentObj.find("label[name=zipFar]").text(dataDtl.zipFar);
		feeSum = feeSum + dataDtl.zipFar;
	}
	
	//수수료 감면액(C)
	if(dataDtl.feeRdtnAmt != null){
		tab.ContentObj.find("input[name=fee_rdtn_amt]").val(dataDtl.feeRdtnAmt);
		tab.ContentObj.find("label[name=feeRdtnAmt]").text(dataDtl.feeRdtnAmt);
		feeSum = feeSum - dataDtl.feeRdtnAmt;
	}
	if(dataDtl.feePayYn != null){
		tab.ContentObj.find("input[name=fee_pay_yn]").val(dataDtl.feePayYn);
	}
	
	//계(A+B-C)
	tab.ContentObj.find("input[name=fee_sum]").val(feeSum);
	tab.ContentObj.find("label[name=feeSum]").text(feeSum);
	
	
	//수수료 산정내역
	if(dataDtl.feeEstCn != null){
		tab.ContentObj.find("input[name=fee_est_cn]").val(dataDtl.feeEstCn);
		tab.ContentObj.find("label[name=feeEstCn]").text(dataDtl.feeEstCn);
	}
	
	//수수료납입계좌
	var feePaidAcc = "";
	if(dataDtl.instBankNm != null){
		fileHtml = dataDtl.instBankNm;
		feePaidAcc = dataDtl.instBankNm;
	}	
	if(dataDtl.instAccNo != null){
		fileHtml += "&nbsp;" + dataDtl.instAccNo + "<br/>";
		if(feePaidAcc != "") feePaidAcc += "/"+dataDtl.instBankNm;
		else feePaidAcc = dataDtl.instBankNm;
	}	
	if(dataDtl.instAccNm != null) fileHtml += "예금주 : " + "&nbsp;" + dataDtl.instAccNm + "<br/>";
	tab.ContentObj.find("div[name=feeArea]").append(fileHtml);
	tab.ContentObj.find("input[name=fee_paid_acc_no]").val(feePaidAcc);
	
	//공개결정 첨부파일
	fileHtml = "";
	if(dataDtl.opbFlNm1 !=null){
		fileHtml = "<a href=\"javascript:;\" style=\"text-decoration:none;\" name=\"opbFlNm\">";
		fileHtml += "<img src=\"/images/admin/icon_file.png\" style=\"padding-right:4px;\" alt=\"첨부파일\" >";
		fileHtml +=  "<span style=\"color:#666;\">"+dataDtl.opbFlNm1+"</span>";
		fileHtml += "</a><br>";
		
		var opbFlNm1 = dataDtl.opbFlNm1;
		var opbFlPh1 = dataDtl.opbFlPh1;
		tab.ContentObj.find("label[name=opbFlNm]").append(fileHtml);
		
		tab.ContentObj.find("a[name=opbFlNm]").bind("click", function(event) {
            // 파일을 다운로드한다.
            downloadFile(opbFlNm1, opbFlPh1);
            return false;
        });
	}
	if(dataDtl.opbFlNm2 !=null){
		fileHtml = "<a href=\"javascript:;\" style=\"text-decoration:none;\" name=\"opbFlNm2\">";
		fileHtml += "<img src=\"/images/admin/icon_file.png\" style=\"padding-right:4px;\" alt=\"첨부파일\" >";
		fileHtml +=  "<span style=\"color:#666;\">"+dataDtl.opbFlNm2+"</span>";
		fileHtml += "</a><br>";
		
		var opbFlNm2 = dataDtl.opbFlNm2;
		var opbFlPh2 = dataDtl.opbFlPh2;
		
		tab.ContentObj.find("label[name=opbFlNm]").append(fileHtml);
		
		tab.ContentObj.find("a[name=opbFlNm2]").bind("click", function(event) {
            // 파일을 다운로드한다.
            downloadFile(opbFlNm2, opbFlPh2);
            return false;
        });
		
	}
	if(dataDtl.opbFlNm3 !=null){
		fileHtml = "<a href=\"javascript:;\" style=\"text-decoration:none;\" name=\"opbFlNm3\">";
		fileHtml += "<img src=\"/images/admin/icon_file.png\" style=\"padding-right:4px;\" alt=\"첨부파일\" >";
		fileHtml +=  "<span style=\"color:#666;\">"+dataDtl.opbFlNm3+"</span>";
		fileHtml += "</a>";
		
		var opbFlNm3 = dataDtl.opbFlNm3;
		var opbFlPh3 = dataDtl.opbFlPh3;
		
		tab.ContentObj.find("label[name=opbFlNm]").append(fileHtml);
		
		tab.ContentObj.find("a[name=opbFlNm3]").bind("click", function(event) {
            // 파일을 다운로드한다.
            downloadFile(opbFlNm3, opbFlPh3);
            return false;
        });
		
	}
	
	//특이사항
	if(dataDtl.opbPsbj !=null){
		tab.ContentObj.find("label[name=opbPsbj]").text(dataDtl.opbPsbj);
	}else{
		tab.ContentObj.find("label[name=opbPsbj]").text("해당없음");
	}
	
	dynamicTabButton(tab);		//탭 이벤트를 바인딩한다(동적생성 element들)
	
}

function doSwitch() { //수정 화면으로 노출처리
	var formObj = getTabFormObj("detail-form");
	
	//수정화면 및 버튼 컨트롤
	formObj.find("h3[class=text-title2]").text("이의신청 결과등록");
	formObj.find("tr[name=comTr02]").show();
	formObj.find("div[name=comDiv24]").show();
	
	if(formObj.find("input[name=dcsProdEtYn]").val() == "0") formObj.find("tr[name=comTr04]").show(); //결정연장 정보가 있다면 노출
	formObj.find("div[name=comDiv03]").hide();
	
	//노출되어있는 수수료 납부완료를 없앤다.
	formObj.find("div[name=comDiv05]").hide();//수수료 납부완료
	
	//이의신청 결정에 따라 노출화면이 다르다.
	fn_objtnDiv();
	
	//노출되어있는 버튼을 없앤다.
	formObj.find("a[name=btnOpen]").hide();	//공개실시	
	formObj.find("a[name=btnSwitch]").hide();//수정
	
	//버튼노출 > 저장
	formObj.find("a[name=btnSave]").show();	//저장		
	if(formObj.find("input[name=dcsProdEtYn]").val() != "0") formObj.find("a[name=btnObjtnProd]").show(); //결정기간연장
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
	var id = sheet.GetCellValue(row, "aplNo");//탭 id

	openTab.SetTabData(sheet.GetRowJson(row));//db data 조회시 조건 data
	var url =  com.wise.help.url('/admin/expose/detailOpnObjtnProc.do'); // Controller 호출 url
	openTab.addTab(id, title, url, tabCallBack); 	// 탭 추가 시작함
	
	//청구인정보 열람 로그
	insertLogAcsOpnzApl({aplNo: id, acsCd: "CS131", acsPrssCd: "PR101"});
} 

////////////////////////////////////////////////////////////////////////////////
//시트 로드
////////////////////////////////////////////////////////////////////////////////
function loadSheet() {
	
	createIBSheet2(document.getElementById("sheet"),"sheet", "100%", "300px");
	
	var gridTitle ="번호";
	gridTitle +="|이의신청번호";
	gridTitle +="|이의순번";
	gridTitle +="|접수번호";
	gridTitle +="|신청일자";
	gridTitle +="|청구제목";	
	gridTitle +="|처리기관코드";
	gridTitle +="|처리기관";	
	gridTitle +="|신청인";
	gridTitle +="|처리상태코드";
	gridTitle +="|처리상태";
	gridTitle +="|처리결과코드";
	gridTitle +="|처리결과";
	
	with(sheet){
		                     
		var cfg = {SearchMode:3,Page:50,VScrollMode:1};
	    SetConfig(cfg);
	    var headers = [
	                {Text:gridTitle, Align:"Center"}
	            ];
	    var headerInfo = {Sort:0,ColMove:0,ColResize:1,HeaderCheck:1};
	    
	    InitHeaders(headers, headerInfo);
	   
	    var cols = [
	                 {Type:"Seq",		SaveName:"seq",			   		Width:30,	Align:"Center",		Edit:false,  Hidden:true}
	                ,{Type:"Text",		SaveName:"aplNo",		   		Width:30,	Align:"Center",		Edit:false,  Hidden:true}
	                ,{Type:"Text",		SaveName:"objtnSno",	   		Width:30,	Align:"Center",		Edit:false,  Hidden:true}
	                ,{Type:"Text",	    SaveName:"rcpDtsNo",	    	Width:50,	Align:"Center",		Edit:false}
					,{Type:"Text",		SaveName:"objtnDt",	        	Width:50,	Align:"Center",		Edit:false, Format:"Ymd"}					
					,{Type:"Text",		SaveName:"aplSj",		    	Width:200,	Align:"Left",			Edit:false}
					,{Type:"Text",		SaveName:"instCd",				Width:90,	Align:"Center",		Edit:false,	Hidden:true}
					,{Type:"Text",		SaveName:"aplDealInstCd",	Width:90,	Align:"Center",		Edit:false}					
					,{Type:"Text",		SaveName:"aplPn",		    	Width:50,	Align:"Center",		Edit:false}					
					,{Type:"Text",		SaveName:"objtnStatCd",		Width:90,	Align:"Center",		Edit:false,	Hidden:true}
					,{Type:"Text",		SaveName:"objtnStatNm",		Width:50,	Align:"Center",		Edit:false}
					,{Type:"Text",		SaveName:"objtnDealRsltCd",	Width:90,	Align:"Center",		Edit:false,	Hidden:true}
					,{Type:"Text",		SaveName:"objtnDealRsltNm",	Width:50,	Align:"Center",		Edit:false}
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
}
////////////////////////////////////////////////////////////////////////////////
//이벤트 함수
////////////////////////////////////////////////////////////////////////////////
/**
 * 탭 이벤트를 바인딩한다.
 */
function setTabButton() {
	var formObj = getTabFormObj("detail-form");
	
	formObj.find("a[name=btnReceipt]").bind("click", function(event) {
		// 접수
		doAction("receipt");
    });
	
	formObj.find("a[name=btnCancle]").bind("click", function(event) {
		// 이의취하
		doAction("cancle");
    });
	
	formObj.find("a[name=btnSave]").bind("click", function(event) {
		// 저장
		doAction("save");
    });
	
	formObj.find("a[name=btnObjtnProd]").bind("click", function(event) {
		// 결정기간연장
		doAction("objtnProd");
    });

	formObj.find("a[name=btnOpen]").bind("click", function(event) {
		// 공개실시
		doAction("open");
    });
	
	formObj.find("a[name=btnSwitch]").bind("click", function(event) {
		// 수정화면으로 전환
		doSwitch();
    });

	formObj.find("a[name=btnUpdate]").bind("click", function(event) {
		// 수정
		doAction("update");
    });
	
	formObj.find("a[name=btnObjtn]").bind("click", function(event) {
		// 신청서출력
		fn_objtnPrint();
    });
	
	formObj.find("a[name=btnObjtnExt]").bind("click", function(event) {
		// 연장통지서출력
		fn_objtnExtPrint();
    });

	formObj.find("a[name=btnObjtnDcs]").bind("click", function(event) {
		// 결정통지서출력
		fn_objtnDcsPrint();
    });
	
	formObj.find("a[name=btnApplyDetail]").bind("click", function(event) {
		// 청구상세
		fn_directPage();
    });	
		
	//이의신청 내용
	formObj.find("textarea[name=objtn_mod_rson]").bind("keyup", function(event) {
		var obj = formObj.find("textarea[name=objtn_mod_rson]");
		textAreaLenChk(obj, 'len1', 1000);
	});
	
	//결정내용
	formObj.find("textarea[name=objtnAplRslt]").bind("keyup", function(event) {
		var obj = formObj.find("textarea[name=objtnAplRslt]");
		textAreaLenChk(obj, 'len2', 4000);
	});	
	
    //수수료 숫자만 입력
	formObj.find("input[name=fee], input[name=zip_far], input[name=fee_rdtn_amt]").keyup(function(event) {
		var name = $(this).attr("name");
		validNumOnly(formObj.find("input[name="+name+"]"));
		return false;
	});

	//수수료(A) 합계처리
	formObj.find("input[name=fee]").bind("keyup", function(event) {
		var val = formObj.find("input[name=fee]").val();
		feeSumAmt(val, "1");
	});
	
	//우송료(B) 합계처리
	formObj.find("input[name=zip_far]").bind("keyup", function(event) {
		var val = formObj.find("input[name=zip_far]").val();
		feeSumAmt(val, "2");
	});
	
	//수수료 감면액(C) 합계처리
	formObj.find("input[name=fee_rdtn_amt]").bind("keyup", function(event) {
		var val = formObj.find("input[name=fee_rdtn_amt]").val();
		feeSumAmt(val, "3");
	});
	
}

/**
 * 탭 이벤트를 바인딩한다.
 */
function dynamicTabFiled(tab) {
}
/**
 * 탭 이벤트를 바인딩한다.
 */
function dynamicTabButton(tab){
	var obj = tab.ContentObj.find("textarea[name=objtn_mod_rson]");
	var obj1 = tab.ContentObj.find("textarea[name=objtnAplRslt]");
	
	textAreaLenChk(obj, 'len1', 1000);
	textAreaLenChk(obj1, 'len2', 4000);
}
////////////////////////////////////////////////////////////////////////////////
//Validation 함수
////////////////////////////////////////////////////////////////////////////////
/**
 * 접수/이의취하 validation 
 */
function comValidation(action) {
	var objTab = getTabShowObj();//탭이 oepn된 객체가져옴
	var formObj = objTab.find("form[name=detail-form]");
	
	return true;
}

/**
 * 저장 validation 
 */
function saveValidation(action) {
	var objTab = getTabShowObj();//탭이 oepn된 객체가져옴
	var formObj = objTab.find("form[name=detail-form]");
	
	//이의신청 결정
	if ( formObj.find("input[name=objtn_deal_rslt]").is(":checked") == false ) {
		alert("이의신청 결정을 선택해주세요");
		return false;
	}

	//이의신청 결정
	if (com.wise.util.isNull(formObj.find("textarea[name=objtnAplRslt]").val())  ) {
		alert("결정내용을 입력해주세요.");
		formObj.find("textarea[name=objtnAplRslt]").focus();
		return false;
	}
	
	//결정내용 첨부파일
	if (!com.wise.util.isNull(formObj.find("input[name=attchfile]").val())  ) {
		var chk = fn_checkFile(formObj.find("input[name=attchfile]").val());
		if(chk){
			alert("해당 파일은 등록할 수 없습니다.");
			return false;
		}
	}
	
	return true;
}

/**
 * 공개실시 validation 
 */
function openValidation(action) {
	var objTab = getTabShowObj();//탭이 oepn된 객체가져옴
	var formObj = objTab.find("form[name=detail-form]");
	
	//수수료 납부완료
	if ( formObj.find("input[name=fee_yn]").is(":checked") == false ) {
		alert("수수료 납부완료를 체크해주세요");
		return false;
	}
	
	//공개결정 파일 1 첨부
	if (!com.wise.util.isNull(formObj.find("input[name=resultFile1]").val())  ) {
		var chk = fn_checkFile(formObj.find("input[name=resultFile1]").val());
		if(chk){
			alert("해당 파일은 등록할 수 없습니다.");
			return false;
		}
	}
	
	//공개결정 파일 2 첨부
	if (!com.wise.util.isNull(formObj.find("input[name=resultFile2]").val())  ) {
		var chk = fn_checkFile(formObj.find("input[name=resultFile2]").val());
		if(chk){
			alert("해당 파일은 등록할 수 없습니다.");
			return false;
		}
	}
	
	//공개결정 파일 3 부
	if (!com.wise.util.isNull(formObj.find("input[name=resultFile3]").val())  ) {
		var chk = fn_checkFile(formObj.find("input[name=resultFile3]").val());
		if(chk){
			alert("해당 파일은 등록할 수 없습니다.");
			return false;
		}
	}

	return true;
}

////////////////////////////////////////////////////////////////////////////////
//기타 함수
////////////////////////////////////////////////////////////////////////////////

//달력관련 함수
function datePickerInit() {
	var objTab = getTabShowObj();//탭이 oepn된 객체가져옴
	var formObj = objTab.find("form[name=statMainForm]");
	
	formObj.find("input[name=aplDtFrom],   input[name=aplDtTo]").datepicker(setCalendarFormat('yymmdd'));
	formObj.find("input[name=startDcsNtcDt],   input[name=endDcsNtcDt]").datepicker(setCalendarFormat('yymmdd'));
	
	datepickerTrigger(); 
	// 시작-종료 일자보다 이전으로 못가게 세팅
	formObj.find('input[name=aplDtFrom]').datepicker('option', 'onClose',  function( selectedDate ) {$("input[name=aplDtTo]").datepicker( "option", "minDate", selectedDate );});
	formObj.find('input[name=aplDtTo]').datepicker('option', 'onClose',  function( selectedDate ) {	$("input[name=aplDtFrom]").datepicker( "option", "maxDate", selectedDate );});
	
	
	// 시작-종료 일자보다 이전으로 못가게 세팅
	formObj.find('input[name=startDcsNtcDt]').datepicker('option', 'onClose',  function( selectedDate ) {$("input[name=endDcsNtcDt]").datepicker( "option", "minDate", selectedDate );});
	formObj.find('input[name=endDcsNtcDt]').datepicker('option', 'onClose',  function( selectedDate ) {	$("input[name=startDcsNtcDt]").datepicker( "option", "maxDate", selectedDate );});
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
	var formObj = objTab.find("form[name=detail-form]");
	
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
	formObj.find("input[name="+name+"]").val( ((cnt *2) + temp_str.length));
	return ((cnt *2) + temp_str.length);
}

//텍스트박스 글자수 체크
function textAreaLenChk(obj, name, len){
	rtn = byteCheck(obj.val(), name);
	if(rtn > len){
	  alert(len+'byte 이상 초과 할 수 없습니다.');
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

//수수료 합계처리
function feeSumAmt(obj, feeGb){
	var objTab = getTabShowObj();//탭이 oepn된 객체가져옴
	var formObj = objTab.find("form[name=detail-form]");
	
	if(feeGb==3){
		if(formObj.find("input[name=fee_rdtn_cd]").val() == '02'){
			alert('수수료 감면 대상이 아닙니다.');
			formObj.find("input[name=fee_rdtn_amt]").val("0");
			return;
		}
	}
	var fee = Number(formObj.find("input[name=fee]").val());
	var far = Number(formObj.find("input[name=zip_far]").val());
	var amt = Number(formObj.find("input[name=fee_rdtn_amt]").val());
	var sum = 0;
	sum = fee+far-amt;
	if(sum > 0) formObj.find("input[name=fee_sum]").val(sum);
	else  formObj.find("input[name=fee_sum]").val("")
}

function trim(str){
   str = str.replace(/(^\s*)|(\s*$)/g, "");
   return str;
}

//문자열 날짜형식으로 변환
function parseDate(str){
	var year = str.substr(0, 4);
    var month = str.substr(4, 2);
    var day = str.substr(6, 2);
    var hour = str.substr(8, 2);
    var min = str.substr(10, 2);
    
    var date = year + "-" + month + "-" + day + " " +  hour + ":"+min 
    
    return date
}

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

//이의신청 결정 선택에 따른 화면 Display
function fn_objtnDiv(){
	var objTab = getTabShowObj();//탭이 oepn된 객체가져옴
	var formObj = objTab.find("form[name=detail-form]");
	var val = formObj.find("input:radio[name=objtn_deal_rslt]:checked").val();
	if(val == "02" || val == "03"){ //** 이의신청 결정 ▶ 각하, 기각
		formObj.find("tr[name=dcsObjtnDocNo34]").hide();
	}else{
		formObj.find("tr[name=dcsObjtnDocNo34]").show();
	}
}

function fn_print() {
	var frm = document.statMainForm;
	var pfrm = document.printForm;

	pfrm.width.value = "975";
	pfrm.height.value  ="730";
	pfrm.title.value = "정보공개 이의신청 처리대장 출력";
	pfrm.mrdParam.value = "/rp [" + frm.objtnStatCd.value + "] [" + frm.aplInst.value + "] [" + frm.aplPn.value + "] [" + frm.aplDtFrom.value + "] [" + frm.aplDtTo.value + "]";
	window.open('', 'popup', 'width=975, height=730, resizable=yes, location=no;');
	pfrm.action = "/admin/expose/infoPrintPage/printNewObjtnPrc.do";
	pfrm.target = 'popup';
	pfrm.submit();
}

//신청서출력 
function fn_objtnPrint(){
	var pfrm = document.printForm;
	var objTab = getTabShowObj();//탭이 oepn된 객체가져옴
	var formObj = objTab.find("form[name=detail-form]");
	var id = formObj.find("input[name=apl_no]").val();
	var cVersion = formObj.find("input[name=callVersion]").val();
	
	//청구인정보 열람 로그
	insertLogAcsOpnzApl({aplNo: id, acsCd: "CS132", acsPrssCd: "PR101"});
	
	pfrm.width.value = "680";
	pfrm.height.value = "700";
	pfrm.title.value = "정보공개 이의신청서 출력";
	pfrm.mrdParam.value =  "/rp ["+formObj.find("input[name=apl_no]").val()+"] [" + formObj.find("input[name=objtnSno]").val() + "]" ;
	window.open("","popup","width=680, height=700, resizable=yes, location=no;");
	pfrm.target = "popup";

	if(cVersion == 'V1'){	//2단계 개선사업 이전일 경우 이전 통지서를 호출한다.
		pfrm.action = "/admin/expose/infoPrintPage/printObjtn.do";	// 이의신청서 출력
	}else{	//2단계 개선사업 이후일 경우 신규 통지서를 호출한다.
		/* 이의신청의 취지 및 이유 확인 로직 추가 > 이의신청서의 이의신청의 취지 및 이유에 맞지 않을 경우(초과) 별지참조 처리*/
		var tArea = formObj.find("textarea[name=printObjtnRson]").val(); //이의신청의 취지 및 이유 - 출력용
		var totLine = chkTotLine(tArea);
		if(totLine > 10){ //이의신청서의 이의신청의 취지 및 이유 최대 10줄
			pfrm.action = "/admin/expose/infoPrintPage/printNewObjtnRefer.do";	// 이의신청서 출력(별지 참조)
		}else{
			pfrm.action = "/admin/expose/infoPrintPage/printNewObjtn.do";	// 이의신청서 출력
		}
	}
	pfrm.submit();
}

//연장통지서출력
function fn_objtnExtPrint(){
	var pfrm = document.printForm;
	var objTab = getTabShowObj();//탭이 oepn된 객체가져옴
	var formObj = objTab.find("form[name=detail-form]");
	var cVersion = formObj.find("input[name=callVersion]").val();
	
	pfrm.width.value = "680";
	pfrm.height.value = "700";
	pfrm.title.value = "정보공개 이의신청 연장통지서 출력";
	pfrm.mrdParam.value =  "/rp ["+formObj.find("input[name=apl_no]").val()+"] [" + formObj.find("input[name=objtnSno]").val() + "]" ;
	window.open("","popup","width=680, height=700, resizable=yes, location=no;");
	pfrm.target = "popup";
	if(cVersion == 'V1'){	//2단계 개선사업 이전일 경우 이전 통지서를 호출한다.
		pfrm.action = "/admin/expose/infoPrintPage/printObjtnExt.do";
	}else{	//2단계 개선사업 이후일 경우 신규 통지서를 호출한다.
		pfrm.action = "/admin/expose/infoPrintPage/printNewObjtnExt.do";
	}
	pfrm.submit();
}

//결정통지서출력
function fn_objtnDcsPrint(){
	var pfrm = document.printForm;
	var objTab = getTabShowObj();//탭이 oepn된 객체가져옴
	var formObj = objTab.find("form[name=detail-form]");
	var cVersion = formObj.find("input[name=callVersion]").val();
	
	pfrm.width.value = "680";
	pfrm.height.value = "700";
	pfrm.title.value = "정보공개 이의신청 결정통지서 출력";
	pfrm.mrdParam.value =  "/rp ["+formObj.find("input[name=apl_no]").val()+"] ["+formObj.find("input[name=objtnSno]").val()+"]" ;
	window.open("","popup","width=680, height=700, resizable=yes, location=no;");
	pfrm.target = "popup";
	if(cVersion == 'V1'){	//2단계 개선사업 이전일 경우 이전 통지서를 호출한다.
		pfrm.action = "/admin/expose/infoPrintPage/printObjtnDcs.do";
	}else{	//2단계 개선사업 이후일 경우 신규 통지서를 호출한다.
		pfrm.action = "/admin/expose/infoPrintPage/printNewObjtnDcs.do";
	}
	pfrm.submit();
}

//선택파일 지우기
function fn_pathDelete1(elementName){
	var objTab = getTabShowObj();//탭이 oepn된 객체가져옴
	var formObj = objTab.find("form[name=detail-form]");

	formObj.find("input[name="+elementName+"]").val("");
}

//파일확장자 확인
function fn_checkFile(extVal) {   
	var chk = true;
	
	if( extVal.substr(extVal.length-3).toLowerCase() == 'txt') {chk = false; return chk;} 
      if( extVal.substr(extVal.length-3).toLowerCase() == 'hwp') {chk = false; return chk;}
      if( extVal.substr(extVal.length-3).toLowerCase() == 'doc') {chk = false; return chk;}
      if( extVal.substr(extVal.length-4).toLowerCase() == 'docx') {chk = false; return chk;}
      if( extVal.substr(extVal.length-3).toLowerCase() == 'xls') {chk = false; return chk;}
      if( extVal.substr(extVal.length-4).toLowerCase() == 'xlsx') {chk = false; return chk;}
      if( extVal.substr(extVal.length-3).toLowerCase() == 'ppt') {chk = false; return chk;}
      if( extVal.substr(extVal.length-4).toLowerCase() == 'pptx') {chk = false; return chk;}
      if( extVal.substr(extVal.length-3).toLowerCase() == 'pdf') {chk = false; return chk;}
      if( extVal.substr(extVal.length-3).toLowerCase() == 'zip') {chk = false; return chk;}
      if( extVal.substr(extVal.length-3).toLowerCase() == 'rar') {chk = false; return chk;}
	
	return chk;
}

//청구 상세화면으로 이동
function fn_directPage(){
	var objTab = getTabShowObj();//탭이 oepn된 객체가져옴
	var formObj = objTab.find("form[name=detail-form]");
	
	var aplNo = formObj.find("input[name=apl_no]").val();
//	var url = "offlineWriteAccountPage/"+aplNo+".do";
//	window.open(url, "_blank");  
	var params = "?aplNo=" + formObj.find("input[name=apl_no]").val();
	window.open(com.wise.help.url("/admin/expose/popup/viewOpnAplPopup.do") +  params , "list", "fullscreen=no, width=800, height=800, scrollbars=yes");
	
}

// 수수료 납부여부 체크 추가
function fn_FeeCheck(){
	var objTab = getTabShowObj();//탭이 oepn된 객체가져옴
	var formObj = objTab.find("form[name=detail-form]");
	
	//수수료 납부완료
	if ( formObj.find("input[name=fee_yn]").is(":checked") == true ) {
		formObj.find("tr[name=comTr05]").show(); 
	}else{
		formObj.find("tr[name=comTr05]").hide(); 
	}
}

//팝업닫기후 액션
function popUpCloseEvent(aplNo){
	
	var tabId = "tabs-"+aplNo; //탭 id
	$("#"+tabId).closest("li").remove(); // 현재탭 닫기	
	
	$("#tabs-main").click();

	doAction("search"); // 다시조회
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

//공개방법 > 공개형태 및 교부방법 선택에 따른 이벤트
function fn_choice(div, selVal){
	var objTab = getTabShowObj();//탭이 oepn된 객체가져옴
	var formObj = objTab.find("form[name=detail-form]");

	if(div == '0') {
		if(formObj.find("input[name=opb_fom_05_yn]").is(":checked") == true){
			formObj.find("input[name=opb_fom_etc]").show();
		} else {
			formObj.find("input[name=opb_fom_etc]").hide();
		}
	} else {
		if(formObj.find("input[name=give_mth_05_yn]").is(":checked") == true){
			formObj.find("input[name=give_mth_etc]").show();
		} else {
			formObj.find("input[name=give_mth_etc]").hide();
		}
	} 
}