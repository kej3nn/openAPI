/*
 * @(#)searchOpnDcs.js 1.0 2019/08/12
 * 
 * COPYRIGHT (C) 2013 WISEITECH CO., LTD. ALL RIGHTS RESERVED.
 */

/**
 * 공개결정통보내역 스크립트 파일이다
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
var glbClsdData = "";

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
		$("input[name=aplNo]").val("");
		
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
	
	//청구제목 enter
	$("input[name=aplSj]").bind("keydown", function(event) {
        // 엔터키인 경우
        if (event.which == 13) {
        	doAction("search");
            return false;
        }
    });
	//청구내용 enter
	$("input[name=aplDtsCn]").bind("keydown", function(event) {
        // 엔터키인 경우
        if (event.which == 13) {
        	doAction("search");
            return false;
        }
    });
	//청구인 enter
	$("input[name=aplPn]").bind("keydown", function(event) {
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
			sheet.DoSearchPaging(com.wise.help.url("/admin/expose/searchOpnDcs.do"), param);
			break;
		case "insert" :
			saveData("I");
			break;
		case "open" :
			openData("O");
			break;			
		case "update" :
			saveData("U");
			break;	
		case "cancelDcs" : 	//결정통지취소
			window.open(com.wise.help.url("/admin/expose/popup/opnCancelPopup.do") + "?cType=DCS&aplNo=" + formObj.find("input[name=apl_no]").val() , "list", "fullscreen=no, width=800, height=400, scrollbars=yes");
			break;
		case "cancelEnd" : 	//통지완료취소
			window.open(com.wise.help.url("/admin/expose/popup/opnCancelPopup.do") + "?cType=END&aplNo=" + formObj.find("input[name=apl_no]").val() , "list", "fullscreen=no, width=800, height=400, scrollbars=yes");
			break;
		case "excel":
			sheet.Down2Excel({FileName:'공개결정통보내역.xls',SheetName:'sheet'});
			break;	
		case "aplDetail" :
			var params = "?aplNo=" + formObj.find("input[name=apl_no]").val();
			window.open(com.wise.help.url("/admin/expose/popup/viewOpnAplPopup.do") +  params , "list", "fullscreen=no, width=800, height=800, scrollbars=yes");
			break;
		case "fileUpdate" :
			openData("U");
			break;
	}
}

/**
 * 데이터 저장
 * @param action	I:등록 / U:수정
 */
function saveData(action) {
	var formObj = getTabFormObj("detail-form");
	var tVal = action == "I" ? "등록" : "수정";
	formObj.ajaxSubmit({
		url : com.wise.help.url("/admin/expose/saveOpnDcs.do")
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
	if(action === "U") {
		formObj.find("input[name=fileUpdateYn]").val("Y");
	}
	
	formObj.ajaxSubmit({
		url : com.wise.help.url("/admin/expose/openStartOpnDcs.do")
		, async : false
		, type : 'post'
		, dataType: 'json' 
		, contentType : 'application/x-www-form-urlencoded;charset=UTF-8'
		, beforeSubmit : function() {
			//submit 전 validation 체크
			
			if ( openValidation(action) ) {
				if(action === "O") {
					if ( !confirm("공개실시 하시겠습니까?") )	return false;
				} else {
					if ( !confirm("파일을 수정하시겠습니까?") )	return false;
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
	var clsdData = data.DATA2.clsdRsonCodeList; 	//비공개사유
	glbClsdData = data.DATA2.clsdRsonCodeList;
	var opbData = data.DATA2.opbFomCodeList; 	//공개방법 > 공개형태
	var giveData = data.DATA2.giveMthCodeList; 	//공개방법 > 교부방법
	var prgStatCd = data.DATA2.prgStatCd;
	
	var clsdList = data.DATA2.clsdList; 	//비공개 내용 정보
	
	var opnzhist = data.DATA2.OPNZ_HIST; 	//처리상태 정보
	
	//처리상태이력 보이게
	tab.ContentObj.find("div[name=opnzHist]").css("display", "block");
	
	//기본변수 데이터 할당
	tab.ContentObj.find("input[name=apl_no]").val(dataDtl.aplNo);
	tab.ContentObj.find("input[name=rcp_dt]").val(dataDtl.rcpDt);
	tab.ContentObj.find("input[name=rcp_no]").val(dataDtl.rcpNo);
	tab.ContentObj.find("input[name=apl_deal_instcd]").val(dataDtl.aplDealInstCd);
	tab.ContentObj.find("input[name=prgStatCd]").val(prgStatCd);
	
	tab.ContentObj.find("input[name=inst_pno]").val(dataDtl.instPno);
	tab.ContentObj.find("input[name=inst_fax_no]").val(dataDtl.instFaxNo);
	tab.ContentObj.find("input[name=inst_chrg_dept_nm]").val(dataDtl.instChrgDeptNm);
	tab.ContentObj.find("input[name=inst_chrg_cent_cgp_1_nm]").val(dataDtl.instChrgCentCgp1Nm);
	tab.ContentObj.find("input[name=inst_chrg_cent_cgp_2_nm]").val(dataDtl.instChrgCentCgp2Nm);
	tab.ContentObj.find("input[name=inst_chrg_cent_cgp_3_nm]").val(dataDtl.instChrgCentCgp3Nm);
	
	tab.ContentObj.find("input[name=callVersion]").val(dataDtl.callVersion); //2단계 개선사업 - 반영 이전/이후 확인
	
	var histHtml = "";
	
	//처리상태 이력 테이블
	$.each(opnzhist, function(i, value) {
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
	
	
	//상태값에 따른 화면 및 버튼 컨트롤
	if(prgStatCd == "03" || prgStatCd == "05"){
		tab.ContentObj.find("div[name=comWrite]").show();
		tab.ContentObj.find("div[name=comDetail]").hide();
	}else{
		tab.ContentObj.find("div[name=comWrite]").hide();
		tab.ContentObj.find("div[name=comDetail]").show();
		
		if(prgStatCd == "08"){
			tab.ContentObj.find("tr[name=prgStatCd08]").show();
			tab.ContentObj.find("a[name=btnFileUpdate]").show();
			tab.ContentObj.find("tr[name=trFileDiv]").show();
			tab.ContentObj.find("tr[name=trFileDiv2]").show();
			
			//버튼 노출
			if(dataDtl.opbYn == "3") tab.ContentObj.find("a[name=btnNonPrint]").show(); //부존재 등 통지서 > 버튼 노출
			else tab.ContentObj.find("a[name=btndcsPrint]").show(); //결정통지서 > 버튼 노출
			
			//슈퍼관리자일 경우 [통지완료취소] 버튼을 활성화 시킨다.
			if($("#loginAccCd").val() == "SYS" || $("#loginAccCd").val() == "OPA"){
				tab.ContentObj.find("a[name=btnCancelEnd]").show();
			}
		}else{
			tab.ContentObj.find("tr[name=prgStatCd08]").hide();

			if(dataDtl.imdDealDiv != "1"){ //즉시처리 가 아니면..
				tab.ContentObj.find("a[name=btnOpen]").show(); //공개실시 > 버튼 노출
				tab.ContentObj.find("tr[name=feeYnDetail]").show(); //수수료납부완료 화면 노출
			}
			//tab.ContentObj.find("a[name=btnSwitch]").show();
			
			//버튼 노출
			if(dataDtl.opbYn == "3") tab.ContentObj.find("a[name=btnNonPrint]").show(); //부존재 등 통지서 > 버튼 노출
			else tab.ContentObj.find("a[name=btndcsPrint]").show(); //결정통지서 > 버튼 노출	
			
			//슈퍼관리자일 경우 [결정통지취소] 버튼을 활성화 시킨다.
			if($("#loginAccCd").val() == "SYS" || $("#loginAccCd").val() == "OPA"){
				if(prgStatCd == "04") tab.ContentObj.find("a[name=btnCancelDcs]").show();
			}
		}

	}
	
	//문서번호
	if(dataDtl.dcsNtcsDocNo != null){
		tab.ContentObj.find("input[name=dcs_ntcs_doc_no]").val(dataDtl.dcsNtcsDocNo);
		tab.ContentObj.find("label[name=dcsNtcsDocNo]").text(dataDtl.dcsNtcsDocNo);
	}
	
	//정보공개 결정
	if(dataDtl.opbYn != null){
		tab.ContentObj.find("input:radio[name=opb_yn]:input[value="+dataDtl.opbYn+"]").prop("checked", true);
		var opbYnNm = "";
		if(dataDtl.opbYn == "0")  opbYnNm = "공개";
		if(dataDtl.opbYn == "1")  opbYnNm = "부분공개";
		if(dataDtl.opbYn == "2")  opbYnNm = "비공개";
		if(dataDtl.opbYn == "3")  opbYnNm = "부존재 등";
		tab.ContentObj.find("label[name=opbYnNm]").text(opbYnNm);
		fn_clsdDiv(dataDtl.opbYn);
	}else{
		fn_clsdDiv('0');
	}
	
	//청구내용
	tab.ContentObj.find("textarea[name=apl_dts_cn]").val(dataDtl.aplModDtsCn);
	
	tab.ContentObj.find("textarea[name=printAplModDtsCn]").val(dataDtl.aplModDtsCn); //청구내용 - 출력용
	
	//공개내용
	if(dataDtl.opbYn != null){
		tab.ContentObj.find("textarea[name=opb_cn]").val(dataDtl.opbCn);
		tab.ContentObj.find("label[name=opbCn]").html(com.wise.help.toHtmlBr(dataDtl.opbCn));
	}else{
		tab.ContentObj.find("label[name=opbCn]").text("해당없음");
	}
	
	var fileHtml = "";
	//즉시처리 첨부
	if(dataDtl.imdFlNm != null){
		fileHtml = "<a href=\"javascript:;\" style=\"text-decoration:none;\">";
		fileHtml += "<img src=\"/images/admin/icon_file.png\" style=\"padding-right:4px;\" alt=\"첨부파일\" >";
		fileHtml +=  "<span style=\"color:#666;\">"+dataDtl.imdFlNm+"</span>";
		fileHtml += "</a>";
		
		var imdFlNm = dataDtl.imdFlNm;
		var imdFlPh = dataDtl.imdFlPh; 
        
		tab.ContentObj.find("div[name=imdFileArea]").append(fileHtml);
		tab.ContentObj.find("label[name=imdflNm]").append(fileHtml);
		
		tab.ContentObj.find("div[name=imdFileArea] > a, label[name=imdflNm] > a").bind("click", function(event) {
            // 파일을 다운로드한다.
            downloadFile(imdFlNm, imdFlPh);
            return false;
        });
		
	}else{
		tab.ContentObj.find("label[name=imdflNm]").text("첨부없음");
	}
	
	//정보 부존재 등 정보공개청구에 따를 수 없는 사유
	if(dataDtl.nonExt != null){
		tab.ContentObj.find("textarea[name=non_ext]").val(dataDtl.nonExt);
		tab.ContentObj.find("label[name=nonExt]").html(com.wise.help.toHtmlBr(dataDtl.nonExt));
	}else{
		tab.ContentObj.find("label[name=nonExt]").text("해당없음");
	}

	//정보 부존재 등 정보공개청구에 따를 수 없는 사유 > 첨부
	if(dataDtl.nonFlNm != null){
		fileHtml = "<a href=\"javascript:;\" style=\"text-decoration:none;\">";
		fileHtml += "<img src=\"/images/admin/icon_file.png\" style=\"padding-right:4px;\" alt=\"첨부파일\" >";
		fileHtml +=  "<span style=\"color:#666;\">"+dataDtl.nonFlNm+"</span>";
		fileHtml += "</a>";
		var nonFlNm = dataDtl.nonFlNm;
		var nonFlPh = dataDtl.nonFlPh;
        
		tab.ContentObj.find("div[name=nonFileArea]").append(fileHtml);
		tab.ContentObj.find("label[name=nonFlNm]").append(fileHtml);
	
		tab.ContentObj.find("div[id=nonFileArea] > a, label[name=nonFlNm] > a").bind("click", function(event) {
            // 파일을 다운로드한다.
            downloadFile(nonFlNm, nonFlPh);
            return false;
        });
		
	}else{
		tab.ContentObj.find("label[name=nonFlNm]").text("첨부없음");
	}

	if(dataDtl.callVersion == "V1"){
		//비공개 (전부 또는 일부) 내용 및 사유 <- 이전
		if(dataDtl.clsdRmk != null){
			//비공개내용 및 사유 기능 수정
			tab.ContentObj.find("textarea[name=clsd_rmk]").val(dataDtl.clsdRmk);
			tab.ContentObj.find("label[name=clsdRmk]").html(com.wise.help.toHtmlBr(dataDtl.clsdRmk));
		}else{
			//비공개내용 및 사유 기능 수정
			tab.ContentObj.find("label[name=clsdRmk]").text("해당없음");
		}
	}else{
		//비공개 (전부 또는 일부) 내용 및 사유 <- 신규
		if(dataDtl.newClsdRmk != null){
			tab.ContentObj.find("label[name=clsdRmk]").html(com.wise.help.toHtmlBr(dataDtl.newClsdRmk));
			
			tab.ContentObj.find("textarea[name=printClsdRmk]").val(dataDtl.newClsdRmk); //비공개사유 - 출력용
		}
	}
	
	//비공개 (전부 또는 일부) 내용 및 사유 > 첨부
	if(dataDtl.clsdAttchFlNm != null){
		fileHtml = "<a href=\"javascript:;\" style=\"text-decoration:none;\">";
		fileHtml += "<img src=\"/images/admin/icon_file.png\" style=\"padding-right:4px;\" alt=\"첨부파일\" >";
		fileHtml +=  "<span style=\"color:#666;\">"+dataDtl.clsdAttchFlNm+"</span>";
		fileHtml += "</a>";
		var clsdAttchFlNm = dataDtl.clsdAttchFlNm;
		var clsdAttchFlPhNm = dataDtl.clsdAttchFlPhNm;
        
		tab.ContentObj.find("div[name=clsdFileArea]").append(fileHtml);
		tab.ContentObj.find("label[name=clsdAttchFlNm]").append(fileHtml);
	
		tab.ContentObj.find("div[name=clsdFileArea] > a, label[name=clsdAttchFlNm] > a").bind("click", function(event) {
            // 파일을 다운로드한다.
            downloadFile(clsdAttchFlNm, clsdAttchFlPhNm);
            return false;
        });
		
	}else{
		tab.ContentObj.find("label[name=clsdAttchFlNm]").text("첨부없음");
	}
	
	//비공개사유
	tab.ContentObj.find("select[name=clsd_rson_cd] option").remove();
	var option = $("<option value=''>비공개사유를 선택하세요</option>");
	tab.ContentObj.find("select[name=clsd_rson_cd]").append(option);
	$.each(clsdData, function(key, value){
		option = $("<option value='"+value.baseCd+"'>"+value.baseNm+"</option>");
		tab.ContentObj.find("select[name=clsd_rson_cd]").append(option);
	});
	if(dataDtl.clsdRsonCd != null){
		tab.ContentObj.find("select[name=clsd_rson_cd] > option[value='"+ dataDtl.clsdRsonCd +"']").attr("selected", "true");
	}
	if(dataDtl.clsdRsonNm != null){
		tab.ContentObj.find("label[name=clsdRsonNm]").text(dataDtl.clsdRsonNm);
	}

	//공개방법 > 공개형태
	tab.ContentObj.find("div[name=opbFomArea]").empty();
	$.each(opbData, function(key, value){
		//var rHtml = "<input type='radio' name='opb_fom' value='"+value.baseCd+"' class='border_none' onclick=\"fn_choice('0','"+value.baseCd+"');\"/>"+value.baseNm+"&nbsp;"
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
		if(dataDtl.opbFomNm5 != null) tab.ContentObj.find("input:checkbox[name=opb_fom_05_yn]").prop("checked", true);
	}else{
		if(dataDtl.opbFomVal != null){
			tab.ContentObj.find("input:checkbox[name=opb_fom_"+dataDtl.opbFomVal+"_yn]").prop("checked", true);
			if(dataDtl.opbFomVal == "05") tab.ContentObj.find("input[name=opb_fom_etc]").show();
		}else{
			tab.ContentObj.find("input:checkbox[name=opb_fom_01_yn]").prop("checked", true);
		}
	}
	
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
		tab.ContentObj.find("label[name=opbFomNm]").text(opbFormNm);
	}
		
	//공개방법 > 교부방법
	tab.ContentObj.find("div[name=giveMthArea]").empty();
	$.each(giveData, function(key, value){
		//var rHtml = "<input type='radio' name='give_mth' value='"+value.baseCd+"' class='border_none' onclick=\"fn_choice('1','"+value.baseCd+"');\"/>"+value.baseNm+"&nbsp;";
		var rHtml = "<input type='checkbox' name='give_mth_"+value.baseCd+"_yn' value='Y' class='border_none' onclick=\"fn_choice('1','"+value.baseCd+"');\"/>"+value.baseNm+"&nbsp;"
		tab.ContentObj.find("div[name=giveMthArea]").append(rHtml);
	});
	var giveMthEtc = dataDtl.giveMthEtc;
	if(giveMthEtc == null || giveMthEtc == undefined) giveMthEtc = "";	
	var etcHtml = "<input type='text' name='give_mth_etc' maxlength='50' size='25' value='"+giveMthEtc+"' style='display:none;'/>";
	tab.ContentObj.find("div[name=giveMthArea]").append(etcHtml);
	
	if(dataDtl.giveMthNm1 != null || dataDtl.giveMthNm2 != null || dataDtl.giveMthNm3 != null || dataDtl.giveMthNm4 != null || dataDtl.giveMthNm5 != null){
		if(dataDtl.giveMthNm1 != null) tab.ContentObj.find("input:checkbox[name=give_mth_01_yn]").prop("checked", true);
		if(dataDtl.giveMthNm2 != null) tab.ContentObj.find("input:checkbox[name=give_mth_02_yn]").prop("checked", true);
		if(dataDtl.giveMthNm3 != null) tab.ContentObj.find("input:checkbox[name=give_mth_03_yn]").prop("checked", true);
		if(dataDtl.giveMthNm4 != null) tab.ContentObj.find("input:checkbox[name=give_mth_04_yn]").prop("checked", true);
		if(dataDtl.giveMthNm5 != null) tab.ContentObj.find("input:checkbox[name=give_mth_05_yn]").prop("checked", true);
	}else{
		if(dataDtl.aplTakMth != null){
			tab.ContentObj.find("input:checkbox[name=give_mth_"+dataDtl.aplTakMth+"_yn]").prop("checked", true);
			if(dataDtl.aplTakMth == "05") tab.ContentObj.find("input[name=give_mth_etc]").show();
		}else{
			tab.ContentObj.find("input:checkbox[name=give_mth_01_yn]").prop("checked", true);
		}
	}

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
	
    var maxDate = new Date();
    // why?????? 주석처리 2020-01-14
    //var dd = maxDate.getDate() + 7;
    //maxDate.setDate(dd);
    
	//달력
    formObj.find("input[name=opb_dtm]").datepicker(com.wise.help.datepicker({
        buttonImage:com.wise.help.url("/images/admin/icon_calendar.png")
    }));
	formObj.find("input[name=opb_dtm]").datepicker( "option", "minDate", maxDate);
	//formObj.find("input[name=opb_dtm]").attr("readonly", true);
	//공개일자
	if(dataDtl.opbDtm != null){
		tab.ContentObj.find("input[name=opb_dtm]").val(dataDtl.opbDtm);
		tab.ContentObj.find("label[name=opbDtm]").text(com.wise.util.toDate(dataDtl.opbDtm));
	}
	
	//공개장소
	if(dataDtl.opbPlcNm != null){
		tab.ContentObj.find("input[name=opb_plc]").val(dataDtl.opbPlcNm);
		tab.ContentObj.find("label[name=opbPlc]").text(dataDtl.opbPlcNm);
	}
	
	//수수료(A)
	var feeSum = 0;
	if(dataDtl.fee != null){
		tab.ContentObj.find("input[name=fee]").val(dataDtl.fee);
		tab.ContentObj.find("label[name=feeVal]").text(dataDtl.fee);
		feeSum = dataDtl.fee;
	}
	
	//우송료(B)
	if(dataDtl.zipFar != null){
		tab.ContentObj.find("input[name=zip_far]").val(dataDtl.zipFar);
		tab.ContentObj.find("label[name=zipFarVal]").text(dataDtl.zipFar);
		feeSum = feeSum + dataDtl.zipFar;
	}
	
	//수수료 감면액(C)
	if(dataDtl.feeRdtnAmt != null){
		tab.ContentObj.find("input[name=fee_rdtn_amt]").val(dataDtl.feeRdtnAmt);
		tab.ContentObj.find("label[name=feeRdtnAmtVal]").text(dataDtl.feeRdtnAmt);
		feeSum = feeSum - dataDtl.feeRdtnAmt;
	}
	if(dataDtl.feeRdtnCd != null){
		tab.ContentObj.find("input[name=fee_rdtn_yn]").val(dataDtl.feeRdtnCd);
	}
	
	//계(A+B-C)
	tab.ContentObj.find("input[name=fee_sum]").val(feeSum);
	tab.ContentObj.find("label[name=feeSumVal]").text(feeSum);
	
	//수수료 산정내역
	if(dataDtl.feeEstCn != null){
		tab.ContentObj.find("input[name=fee_est_cn]").val(dataDtl.feeEstCn);
		tab.ContentObj.find("label[name=feeEstCnVal]").text(dataDtl.feeEstCn);
	}
	
	//수수료납입계좌
	var feePaidAcc = "";
	if(dataDtl.instBankNm != null){
		fileHtml = dataDtl.instBankNm;
		feePaidAcc = dataDtl.instBankNm;
	}	
	if(dataDtl.instAccNo != null){
		fileHtml += "&nbsp;" + dataDtl.instAccNo + "<br>";
		if(feePaidAcc != "") feePaidAcc += "/"+dataDtl.instBankNm;
		else feePaidAcc = dataDtl.instBankNm;
	}	
	if(dataDtl.instAccNm != null) fileHtml = "예금주 : " + "&nbsp;" + dataDtl.instAccNm + "<br>";
	tab.ContentObj.find("div[name=feeArea]").append(fileHtml);
	tab.ContentObj.find("input[name=fee_paid_acc]").val(feePaidAcc);
	tab.ContentObj.find("label[name=feeAreaVal]").html(fileHtml);
	 
	//제3자 의견 등록 첨부
	if(dataDtl.trdOpnFlNm != null){
		fileHtml = "<a href=\"javascript:;\" style=\"text-decoration:none;\">";
		fileHtml += "<img src=\"/images/admin/icon_file.png\" style=\"padding-right:4px;\" alt=\"첨부파일\" >";
		fileHtml +=  "<span style=\"color:#666;\">"+dataDtl.trdOpnFlNm+"</span>";
		fileHtml += "</a>";
		var trdOpnFlNm = dataDtl.trdOpnFlNm;
        var trdOpnFlPh = dataDtl.trdOpnFlPh;
		tab.ContentObj.find("div[name=fileArea]").append(fileHtml);
		tab.ContentObj.find("label[name=thirdOpnFlnm]").append(fileHtml);
		
		tab.ContentObj.find("div[name=fileArea] > a, label[name=thirdOpnFlnm] > a").bind("click", function(event) {
            // 파일을 다운로드한다.
            downloadFile(trdOpnFlNm, trdOpnFlPh);
            return false;
        });
		
	}else{
		tab.ContentObj.find("label[name=thirdOpnFlnm]").text("첨부없음");
	}
	
	//심의회 관리 첨부
	if(dataDtl.dbrtInstFlNm != null){
		fileHtml = "<a href=\"javascript:;\" style=\"text-decoration:none;\">";
		fileHtml += "<img src=\"/images/admin/icon_file.png\" style=\"padding-right:4px;\" alt=\"첨부파일\" >";
		fileHtml +=  "<span style=\"color:#666;\">"+dataDtl.dbrtInstFlNm+"</span>";
		fileHtml += "</a>";
		var dbrtInstFlNm = dataDtl.dbrtInstFlNm;
		var dbrtInstFlPh = dataDtl.dbrtInstFlPh;
        
		tab.ContentObj.find("div[name=file1Area]").append(fileHtml);
		tab.ContentObj.find("label[name=dbrtInstFlnm]").html(fileHtml);
		
		tab.ContentObj.find("div[name=file1Area] > a, label[name=dbrtInstFlnm] > a").bind("click", function(event) {
            // 파일을 다운로드한다.
            downloadFile(dbrtInstFlNm, dbrtInstFlPh);
            return false;
        });
	}else{
		tab.ContentObj.find("label[name=dbrtInstFlnm]").text("첨부없음");
	}
	
	//즉시처리 체크여부
	if(dataDtl.imdDealDiv == "1"){
		tab.ContentObj.find("label[name=imdDealDiv]").text("'즉시처리' 된 건 입니다.");
	}else{
		tab.ContentObj.find("label[name=imdDealDiv]").text("해당없음");
	}
	
	fileHtml = "";
	if(dataDtl.opbFlNm !=null){
		fileHtml = "<a href=\"javascript:;\" style=\"text-decoration:none;\" name=\"opbFlNm\">";
		fileHtml += "<img src=\"/images/admin/icon_file.png\" style=\"padding-right:4px;\" alt=\"첨부파일\" >";
		fileHtml +=  "<span style=\"color:#666;\">"+dataDtl.opbFlNm+"</span>";
		fileHtml += "</a><br>";
		
		var opbFlNm = dataDtl.opbFlNm;
		var opbFlPh = dataDtl.opbFlPh;
		tab.ContentObj.find("label[name=opbFlNm]").append(fileHtml);
		
		tab.ContentObj.find("a[name=opbFlNm]").bind("click", function(event) {
            // 파일을 다운로드한다.
            downloadFile(opbFlNm, opbFlPh);
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
	
	if(dataDtl.opbPsbj !=null){
		tab.ContentObj.find("label[name=opbPsbj]").text(dataDtl.opbPsbj);
	}else{
		tab.ContentObj.find("label[name=opbPsbj]").text("해당없음");
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
	
	//비공개사유 > 기타(부존재등) 선택 시 INPUT 박스 오픈
	formObj.find("select[name=clsd_rson_cd]").bind("change", function(event) {
		var val = $(this).val();
		if(val == "09"){
			formObj.find("label[name=clsd1]").find("input[name=clsd_rson]").show();
		}else{
			formObj.find("label[name=clsd1]").find("input[name=clsd_rson]").hide();
		}
	});
	
	dynamicTabButton(tab);		//탭 이벤트를 바인딩한다(동적생성 element들)
	
}

function doSwitch() {
	var formObj = getTabFormObj("detail-form");
	
	//수정화면 및 버튼 컨트롤
	formObj.find("div[name=comWrite]").show();
	formObj.find("div[name=comDetail]").hide();
	formObj.find("input:checkbox[name=fee_yn]").prop("checked", false);
	formObj.find("div[name=feeChkDetail]").hide();

	formObj.find("tr[name=feeYnDetail]").hide();
	
	formObj.find("a[name=btnInsert]").hide();
	formObj.find("a[name=btnUpdate]").show();	
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
	var url =  com.wise.help.url('/admin/expose/detailOpnDcs.do'); // Controller 호출 url
	openTab.addTab(id, title, url, tabCallBack); 	// 탭 추가 시작함
	
	//청구인정보 열람 로그
	insertLogAcsOpnzApl({aplNo: id, acsCd: "CS121", acsPrssCd: "PR101"});
} 

////////////////////////////////////////////////////////////////////////////////
//시트 로드
////////////////////////////////////////////////////////////////////////////////
function loadSheet() {
	
	createIBSheet2(document.getElementById("sheet"),"sheet", "100%", "300px");
	
	var gridTitle ="번호";
	gridTitle +="|상태";
	gridTitle +="|신청번호";
	gridTitle +="|접수번호";
	gridTitle +="|접수일자";
	gridTitle +="|청구제목";
	gridTitle +="|청구기관코드";
	gridTitle +="|청구기관";
	gridTitle +="|처리기관코드";
	gridTitle +="|처리기관";
	gridTitle +="|청구인";
	gridTitle +="|공개여부코드";
	gridTitle +="|공개여부";
	gridTitle +="|처리상태코드";
	gridTitle +="|처리상태";
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
	                 {Type:"Seq",		SaveName:"seq",			   		Width:30,	Align:"Center",		Edit:false}
	                ,{Type:"Status",	SaveName:"status",		    	Width:30,	Align:"Center",		Edit:false,	Hidden:true}
	                ,{Type:"Text",	    SaveName:"aplNo",		    	Width:30,	Align:"Center",		Edit:false,	Hidden:true}
					,{Type:"Text",		SaveName:"rcpDtsNo",	    	Width:50,	Align:"Center",		Edit:false}					
					,{Type:"Text",		SaveName:"rcpDt",	        	Width:50,	Align:"Center",		Edit:false, Format:"Ymd"}
					,{Type:"Text",		SaveName:"aplSj",		    	Width:200,	Align:"Left",			Edit:false}
					,{Type:"Text",		SaveName:"aplInstCd",	    	Width:90,	Align:"Center",		Edit:false,	Hidden:true}
					,{Type:"Text",		SaveName:"aplInstNm",	    	Width:90,	Align:"Center",		Edit:false,	Hidden:true}
					,{Type:"Text",		SaveName:"aplDealInstCd",	Width:90,	Align:"Center",		Edit:false,	Hidden:true}
					,{Type:"Text",		SaveName:"aplDealInstNm",	Width:90,	Align:"Center",		Edit:false}
					,{Type:"Text",		SaveName:"aplPn",		    	Width:50,	Align:"Center",		Edit:false}
					,{Type:"Text",		SaveName:"opbYn",				Width:90,	Align:"Center",		Edit:false,	Hidden:true}
					,{Type:"Text",		SaveName:"opbYnNm",		    Width:50,	Align:"Center",		Edit:false}
					,{Type:"Text",		SaveName:"prgStatCd",	    	Width:90,	Align:"Center",		Edit:false,	Hidden:true}
					,{Type:"Text",		SaveName:"imdDealDivNm",	Width:90,	Align:"Center",		Edit:false}
					,{Type:"Text",		SaveName:"endNm",	    		Width:50,	Align:"Center",		Edit:false}
					,{Type:"Text",		SaveName:"dcsNtcDt",	    	Width:50,	Align:"Center",		Edit:false, Format:"Ymd"}
					,{Type:"Text",	    SaveName:"srcAplNo",		  	Width:30,	Align:"Center",		Edit:false,	Hidden:true}
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
	var openRow = findSheetRow("sheet", openAplNo, "aplNo");
	if(openRow != null) tabEvent(openRow);	
}
////////////////////////////////////////////////////////////////////////////////
//이벤트 함수
////////////////////////////////////////////////////////////////////////////////
/**
 * 탭 이벤트를 바인딩한다.
 */
function setTabButton() {
	var formObj = getTabFormObj("detail-form");
	
	formObj.find("a[name=btnInsert]").bind("click", function(event) {
		// 등록
		doAction("insert");
    });
	
	formObj.find("a[name=btnFileUpdate]").bind("click", function(event) {
		// 등록
		doAction("fileUpdate");
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
	
	formObj.find("a[name=btnNonPrint]").bind("click", function(event) {
		// 부존재 등 통지서 출력
		fn_nonPrint();
    });
	
	formObj.find("a[name=btndcsPrint]").bind("click", function(event) {
		// 결정통지서 출력
		fn_dcsPrint();
    });
	
	formObj.find("a[name=btnCancelDcs]").bind("click", function(event) {
		// 결정통지취소
		doAction("cancelDcs");
    });
	
	formObj.find("a[name=btnCancelEnd]").bind("click", function(event) {
		// 통지완료취소
		doAction("cancelEnd");
    });
	
	formObj.find("a[name=btnApplyDetail]").bind("click", function(event) {
		// 청구상세
		//fn_directPage();
		doAction("aplDetail");
    });	
	
    //수수료 숫자만 입력
	formObj.find("input[name=fee], input[name=zip_far], input[name=fee_rdtn_yn]").keyup(function(event) {
		var name = $(this).attr("name");
		validNumOnly(formObj.find("input[name="+name+"]"));
		return false;
	});

	//청구내용
	formObj.find("textarea[name=apl_dts_cn]").bind("keyup", function(event) {
		var obj = formObj.find("textarea[name=apl_dts_cn]");
		textAreaLenChk(obj, 'len1', 2000);
	});
	
	//공개내용
	formObj.find("textarea[name=opb_cn]").bind("keyup", function(event) {
		var obj = formObj.find("textarea[name=opb_cn]");
		textAreaLenChk(obj, 'len2', 500);
	});
	
	//정보 부존재 등 정보공개청구에 따를 수 없는 사유
	formObj.find("textarea[name=non_ext]").bind("keyup", function(event) {
		var obj = formObj.find("textarea[name=non_ext]");
		textAreaLenChk(obj, 'len3', 500);
	});

	//비공개 (전부 또는 일부) 내용 및 사유
	formObj.find("label[name=clsd1]").find("textarea[name=clsd_rmk]").bind("keyup", function(event) {
		var obj = formObj.find("label[name=clsd1]").find("textarea[name=clsd_rmk]");
		textAreaLabelLenChk(obj, 'clsd1', 'len4', 500);
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
	//신규등록시 필요없는 필드 숨김
	tab.ContentObj.find("tr[id=rcpDtsNoArea]").hide();
	tab.ContentObj.find("tr[id=rcpDtArea]").hide();
	tab.ContentObj.find("tr[id=aplModSjArea]").hide();
	tab.ContentObj.find("tr[id=aplModDtsCnArea]").hide();
	tab.ContentObj.find("tr[id=aplDealInstArea]").hide();
	
	
	//신규등록시 버튼 숨김
	tab.ContentObj.find("a[name=infoPrintBtnA]").hide();
	tab.ContentObj.find("a[name=infoRcpBtnA]").hide();
	tab.ContentObj.find("a[name=infoTrsfBtnA]").hide();
	tab.ContentObj.find("a[name=infoCancelfBtnA]").hide();
	
	
}
/**
 * 탭 이벤트를 바인딩한다.
 */
function dynamicTabButton(tab){
	var obj = tab.ContentObj.find("textarea[name=apl_dts_cn]");
	var obj1 = tab.ContentObj.find("textarea[name=opb_cn]");
	var obj2 = tab.ContentObj.find("textarea[name=non_ext]");
	var obj3 = tab.ContentObj.find("textarea[name=clsd_rmk]");
	
	textAreaLenChk(obj, 'len1', 2000);
	textAreaLenChk(obj1, 'len2', 500);
	textAreaLenChk(obj2, 'len3', 500);
	textAreaLabelLenChk(obj3, 'clsd1', 'len4', 500);
	
}
////////////////////////////////////////////////////////////////////////////////
//Validation 함수
////////////////////////////////////////////////////////////////////////////////
/**
 * 등록/수정 validation 
 */
function saveValidation(action) {
	var objTab = getTabShowObj();//탭이 oepn된 객체가져옴
	var formObj = objTab.find("form[name=detail-form]");

	//즉시처리가 아닐 경우..
	if ( formObj.find("input[name=imd_deal_div]").is(":checked") == false ) {
		if ( com.wise.util.isNull(formObj.find("input[name=dcs_ntcs_doc_no]").val()) ) {
			alert("문서번호를 입력해주세요");
			formObj.find("input[name=dcs_ntcs_doc_no]").focus();
			return false;
		}
	}
	
	//정보공개 결정 구분 > 공개
	if ( formObj.find("input[name=opb_yn]:checked").val()=="0" ) {
		
		if (com.wise.util.isNull(formObj.find("textarea[name=opb_cn]").val())  ) {
			alert("공개내용을 입력해주세요.");
			formObj.find("textarea[name=opb_cn]").focus();
			return false;
		}
		formObj.find("select[name=clsd_rson_cd]").val("");
		formObj.find("input[name=clsd_content]").each(function(k,v) {
			$(this).val("");
        }); 
		formObj.find("input[name=clsd_reason]").each(function(k,v) {
			$(this).val("");
        });
	}
	//정보공개 결정 구분 > 부분공개 
	if ( formObj.find("input[name=opb_yn]:checked").val()=="1" ) {
		
		if (com.wise.util.isNull(formObj.find("textarea[name=opb_cn]").val())  ) {
			alert("공개내용을 입력해주세요.");
			formObj.find("textarea[name=opb_cn]").focus();
			return false;
		}
		
		/* 부분공개 시 비공개 내용 입력여부 확인 시작 (START) */
		var cnt = 0;
		var eqIdx = "";
		var isDataChk = false;
		formObj.find("textarea[name=clsd_rmk]").each(function() {
			if(!isDataChk && com.wise.util.isNull($(this).val())){
				eqIdx = cnt;
				isDataChk = true;
			}
			cnt++;
		});
		if(isDataChk){ //비공개 내용이 없는게 있을 경우
			if(eqIdx == 0){
				alert("부분공개 시 하나이상 비공개내용을 입력해주세요.\n비공개 내용이 없으면 [정보공개 결정]을 확인해주세요.");
			}else{
				alert("비공개내용을 입력해주세요.\n추가 내용이 없으면 [삭제] 처리해주세요.");
			}
			formObj.find("textarea[name=clsd_rmk]").eq(eqIdx).focus();
			return false;
		}
		/* 부분공개 시 비공개 내용 입력여부 확인 종료 (END) */
		
		/* 부분공개 시 비공개 사유 선택여부 확인 시작 (START) */
		cnt = 0;
		eqIdx = "";
		isDataChk = false;
		formObj.find("select[name=clsd_rson_cd]").each(function() {
			if(!isDataChk && com.wise.util.isNull($(this).val())){
				eqIdx = cnt;
				isDataChk = true;
			}
			cnt++;
		});		
		if(isDataChk){ //비공개 사유가 없는게 있을 경우
			alert("비공개 사유를 선택해주세요.");
			formObj.find("select[name=clsd_rson_cd]").eq(eqIdx).focus();
			return false;
		}
		/* 부분공개 시 비공개 사유 선택여부 확인 종료 (END) */
		
		/* 부분공개 시 비공개 사유 > 기타(부존재등) 일 경우 clsd_rson 입력여부 확인 시작 (START) */
		cnt = 0;
		eqIdx = "";
		isDataChk = false;
		formObj.find("select[name=clsd_rson_cd]").each(function() {
			if(!isDataChk && $(this).val() == "09" && formObj.find("input[name=clsd_rson]").eq(cnt).val() == ""){
				eqIdx = cnt;
				isDataChk = true;
			}
			cnt++;
		});		
		if(isDataChk){ //비공개 사유가 > 기타(부존재등) 일 경우  clsd_rson값이 없는게 있을 경우
			alert("기타(부존재등)의 내용을 입력해주세요.");
			formObj.find("input[name=clsd_rson]").eq(eqIdx).focus();
			return false;
		}
		/* 부분공개 시 비공개 사유 > 기타(부존재등) 일 경우 clsd_rson 입력여부 확인 종료 (END) */
		
		
	}
	//정보공개 결정 구분 > 비공개
	if ( formObj.find("input[name=opb_yn]:checked").val()=="2" ) {
		
		/* 비공개 시 비공개 내용 입력여부 확인 시작 (START) */
		var cnt = 0;
		var eqIdx = "";
		var isDataChk = false;
		formObj.find("textarea[name=clsd_rmk]").each(function() {
			if(!isDataChk && com.wise.util.isNull($(this).val())){
				eqIdx = cnt;
				isDataChk = true;
			}
			cnt++;
		});
		if(isDataChk){ //비공개 내용이 없는게 있을 경우
			if(eqIdx == 0){
				alert("비공개내용을 입력해주세요.\n비공개 내용이 없으면 [정보공개 결정]을 확인해주세요.");
			}else{
				alert("비공개내용을 입력해주세요.\n추가 내용이 없으면 [삭제] 처리해주세요.");
			}
			formObj.find("textarea[name=clsd_rmk]").eq(eqIdx).focus();
			return false;
		}
		/* 비공개 시 비공개 내용 입력여부 확인 종료 (END) */
		
		/* 비공개 시 비공개 사유 선택여부 확인 시작 (START) */
		cnt = 0;
		eqIdx = "";
		var isDataChk = false;
		formObj.find("select[name=clsd_rson_cd]").each(function() {
			if(!isDataChk && com.wise.util.isNull($(this).val())){
				eqIdx = cnt;
				isDataChk = true;
			}
			cnt++;
		});		
		if(isDataChk){ //비공개 사유가 없는게 있을 경우
			alert("비공개 사유를 선택해주세요.");
			formObj.find("select[name=clsd_rson_cd]").eq(eqIdx).focus();
			return false;
		}
		/* 비공개 시 비공개 사유 선택여부 확인 종료 (END) */
		
	}
	//정보공개 결정 구분 > 부존재 등
	if ( formObj.find("input[name=opb_yn]:checked").val()=="3" ) {
		if (com.wise.util.isNull(formObj.find("textarea[name=non_ext]").val())  ) {
			alert("정보 부존재 등 정보공개청구에 따를 수 없는 사유를 입력해주세요.");
			formObj.find("textarea[name=non_ext]").focus();
			return false;
		}
	}
	
	//제3자 의견 등록 첨부
	if (!com.wise.util.isNull(formObj.find("input[name=file1]").val())  ) {
		var chk = fn_checkFile(formObj.find("input[name=file1]").val());
		if(chk){
			alert("해당 파일은 등록할 수 없습니다.");
			return false;
		}
		formObj.find("input[name=dbrt_inst_length]").val("1");
	}
	
	//심의회 관리 첨부
	if (!com.wise.util.isNull(formObj.find("input[name=file]").val())  ) {
		var chk = fn_checkFile(formObj.find("input[name=file]").val());
		if(chk){
			alert("해당 파일은 등록할 수 없습니다.");
			return false;
		}
		formObj.find("input[name=third_opn_length]").val("2");
	}

	//비공개 (전부 또는 일부) 내용 및 사유 첨부
	if (!com.wise.util.isNull(formObj.find("input[name=clsdFile]").val())  ) {
		var chk = fn_checkFile(formObj.find("input[name=clsdFile]").val());
		if(chk){
			alert("해당 파일은 등록할 수 없습니다.");
			return false;
		}
		formObj.find("input[name=clsd_attch_length]").val("3");
	}

	//즉시처리 첨부
	if (!com.wise.util.isNull(formObj.find("input[name=imd_file]").val())  ) {
		var chk = fn_checkFile(formObj.find("input[name=imd_file]").val());
		if(chk){
			alert("해당 파일은 등록할 수 없습니다.");
			return false;
		}
		formObj.find("input[name=clsd_attch_length]").val("4");
		//즉시처리 체크여부
		var imdDealDiv =formObj.find("input:checkbox[name=imd_deal_div]").is(":checked");
		
		if(!imdDealDiv){
			alert("즉시처리인 경우만 즉시처리 첨부가 가능합니다.");
			return false;
		}
		
	}

	//정보 부존재 등 정보공개청구에 따를 수 없는 사유 첨부
	if (!com.wise.util.isNull(formObj.find("input[name=non_file]").val())  ) {
		var chk = fn_checkFile(formObj.find("input[name=non_file]").val());
		if(chk){
			alert("해당 파일은 등록할 수 없습니다.");
			return false;
		}
		formObj.find("input[name=non_fl_length]").val("5");
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
	if ( formObj.find("input[name=fee_yn]").is(":checked") == false && action != "U") {
		alert("수수료 납부완료를 체크해주세요");
		return false
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
	
	//교부방법 
	if ( formObj.find("input[name=give_mth]").val() == "01" ) {
		if ( formObj.find("input[name=fileYn]").is(":checked") == true ) {
		}else{
			if (com.wise.util.isNull(formObj.find("input[name=resultFile1]").val())  ) {
				alert("공개결정 파일을 등록해주세요.");
				formObj.find("input[name=resultFile1]").focus();
				return false;
			}
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
	var formObj = objTab.find("form[name=detail-form]");
	
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
	}else{
		strb = strb*1;
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
	formObj.find("input[name="+name+"]").val( numberWithCommas(((cnt *2) + temp_str.length)));
	return ((cnt *2) + temp_str.length);
}

//레이블 바이트 체크
function byteLabelCheck(val, label, name){
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
	formObj.find("label[name="+label+"]").find("input[name="+name+"]").val( numberWithCommas(((cnt *2) + temp_str.length)));
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

//레이블 텍스트박스 글자수 체크
function textAreaLabelLenChk(obj, label, name, len){
	rtn = byteLabelCheck(obj.val(), label, name);
	if(rtn > len){
	  alert(numberWithCommas(len)+'byte 이상 초과 할 수 없습니다.');
	  for(var i=rtn; i > len; i--){
		  obj.val(trim(obj.val()).substring(0, obj.val().length-1));
		  if(byteLabelCheck(obj.val(), label, name) <= len){
		  	break;
		  }
	  }
		rtn = byteLabelCheck(obj.val(), label, name);
	  return;
	}
}

//수수료 합계처리
function feeSumAmt(obj, feeGb){
	var objTab = getTabShowObj();//탭이 oepn된 객체가져옴
	var formObj = objTab.find("form[name=detail-form]");
	
	if(feeGb==3){
		if(formObj.find("input[name=fee_rdtn_yn]").val() == '02'){
			alert('수수료 감면 대상이 아닙니다.');
			formObj.find("input[name=fee_rdtn_amt]").val("");
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

// 정보공개 결정 선택에 따른 화면 Display
function fn_clsdDiv(val){
	var objTab = getTabShowObj();//탭이 oepn된 객체가져옴
	var formObj = objTab.find("form[name=detail-form]");
	
	if(val == "0"){ //** 정보공개 결정 ▶ 공개
		formObj.find("tr[name=clsdDiv3]").show();		//공개내용
		formObj.find("th[name=clsdTd5]").show();
		formObj.find("td[name=clsdTd6]").show();
		
		formObj.find("tr[name=clsdDiv1]").hide();      	//비공개 (전부 또는 일부) 내용 및 사유
		formObj.find("tr[name=clsdDiv2]").hide();      	//비공개 첨부
		
		formObj.find("tr[name=clsdDiv4]").show();      	//공개방법
		formObj.find("th[name=clsdTd7]").show();
		formObj.find("th[name=clsdTd8]").show();
		formObj.find("td[name=clsdTd9]").show();
		
		formObj.find("tr[name=clsdDiv5]").show();      	//교부방법
		formObj.find("th[name=clsdTd10]").show();
		formObj.find("td[name=clsdTd11]").show();

		formObj.find("tr[name=clsdDiv6]").hide();      	//부존재사유
		formObj.find("th[name=clsdTd61]").hide();
		formObj.find("td[name=clsdTd62]").hide();
		
		formObj.find("tr[name=clsdDiv21]").show();      	//공개일시
		formObj.find("th[name=clsdTd211]").show();
		formObj.find("td[name=clsdTd212]").show();
		formObj.find("th[name=clsdTd213]").show();
		formObj.find("td[name=clsdTd214]").show();
		
		formObj.find("tr[name=clsdDiv22]").show();      	//수수료
		formObj.find("th[name=clsdTd221]").show();
		formObj.find("td[name=clsdTd222]").show();
		formObj.find("th[name=clsdTd223]").show();
		formObj.find("td[name=clsdTd224]").show();
		
		formObj.find("tr[name=clsdDiv23]").show();      //수수료감면액
		formObj.find("th[name=clsdTd231]").show();
		formObj.find("td[name=clsdTd232]").show();
		formObj.find("th[name=clsdTd233]").show();
		formObj.find("td[name=clsdTd234]").show();
		
		formObj.find("tr[name=clsdDiv24]").show();      //수수료산정내역
		formObj.find("th[name=clsdTd241]").show();
		formObj.find("td[name=clsdTd242]").show();
		formObj.find("th[name=clsdTd243]").show();
		formObj.find("td[name=clsdTd244]").show();
		
		formObj.find("tr[name=clsdDiv25]").show();      	//제3자 의견 등록첨부 
		formObj.find("th[name=clsdTd251]").show();
		formObj.find("td[name=clsdTd252]").show();
		
		formObj.find("tr[name=clsdDiv26]").show();      	//심의회 관리 첨부 
		formObj.find("th[name=clsdTd261]").show();
		formObj.find("td[name=clsdTd262]").show();
		
		formObj.find("tr[name=clsdDiv27]").show();      	//즉시처리  
		formObj.find("th[name=clsdTd271]").show();
		formObj.find("td[name=clsdTd272]").show();
		
		formObj.find("tr[name=clsdDiv28]").show();      	//즉시처리첨부  
		formObj.find("th[name=clsdTd281]").show();
		formObj.find("td[name=clsdTd282]").show();
		
		formObj.find("select[name=clsd_rson_cd]").val("");	//비공개사유를 선택 초기화
		//formObj.find("textarea[name=clsd_rmk]").val("");	//비공개 (전부 또는 일부) 내용 및 사유 초기화
		formObj.find("input[name=fee]").val("");				//수수료(A) 초기화
		formObj.find("input[name=fee]").attr("readOnly", false);	//수수료(A) readonly 해제
		formObj.find("input[name=zip_far]").attr("readOnly", false);	//우송료(B) readonly 해제
		formObj.find("input[name=fee_rdtn_amt]").attr("readOnly", false);	//수수료 감면액(C) readonly 해제
	}else if(val == "1"){ //** 정보공개 결정 ▶ 부분공개
		formObj.find("tr[name=clsdDiv3]").show();		//공개내용
		formObj.find("th[name=clsdTd5]").show();
		formObj.find("td[name=clsdTd6]").show();
		
		formObj.find("tr[name=clsdDiv1]").show();      	//비공개 (전부 또는 일부) 내용 및 사유	
		formObj.find("tr[name=clsdDiv2]").show();      	//비공개 첨부
		
		formObj.find("tr[name=clsdDiv4]").show();      	//공개방법
		formObj.find("th[name=clsdTd7]").show();
		formObj.find("th[name=clsdTd8]").show();
		formObj.find("td[name=clsdTd9]").show();
		
		formObj.find("tr[name=clsdDiv5]").show();      	//교부방법
		formObj.find("th[name=clsdTd10]").show();
		formObj.find("td[name=clsdTd11]").show();

		formObj.find("tr[name=clsdDiv6]").hide();      	//부존재사유
		formObj.find("th[name=clsdTd61]").hide();
		formObj.find("td[name=clsdTd62]").hide();
		
		formObj.find("tr[name=clsdDiv21]").show();      	//공개일자
		formObj.find("th[name=clsdTd211]").show();
		formObj.find("td[name=clsdTd212]").show();
		formObj.find("th[name=clsdTd213]").show();
		formObj.find("td[name=clsdTd214]").show();
		
		formObj.find("tr[name=clsdDiv22]").show();      	//수수료
		formObj.find("th[name=clsdTd221]").show();
		formObj.find("td[name=clsdTd222]").show();
		formObj.find("th[name=clsdTd223]").show();
		formObj.find("td[name=clsdTd224]").show();
		
		formObj.find("tr[name=clsdDiv23]").show();      //수수료감면액
		formObj.find("th[name=clsdTd231]").show();
		formObj.find("td[name=clsdTd232]").show();
		formObj.find("th[name=clsdTd233]").show();
		formObj.find("td[name=clsdTd234]").show();
		
		formObj.find("tr[name=clsdDiv24]").show();      //수수료산정내역
		formObj.find("th[name=clsdTd241]").show();
		formObj.find("td[name=clsdTd242]").show();
		formObj.find("th[name=clsdTd243]").show();
		formObj.find("td[name=clsdTd244]").show();
		
		formObj.find("tr[name=clsdDiv25]").show();      	//제3자 의견 등록첨부 
		formObj.find("th[name=clsdTd251]").show();
		formObj.find("td[name=clsdTd252]").show();
		
		formObj.find("tr[name=clsdDiv26]").show();      	//심의회 관리 첨부 
		formObj.find("th[name=clsdTd261]").show();
		formObj.find("td[name=clsdTd262]").show();
		
		formObj.find("tr[name=clsdDiv27]").show();      	//즉시처리  
		formObj.find("th[name=clsdTd271]").show();
		formObj.find("td[name=clsdTd272]").show();
		
		formObj.find("tr[name=clsdDiv28]").show();      	//즉시처리첨부  
		formObj.find("th[name=clsdTd281]").show();
		formObj.find("td[name=clsdTd282]").show();
		
		formObj.find("input[name=fee]").attr("readOnly", false);	//수수료(A) readonly 해제
		formObj.find("input[name=zip_far]").attr("readOnly", false);	//우송료(B) readonly 해제
		formObj.find("input[name=fee_rdtn_amt]").attr("readOnly", false);	//수수료 감면액(C) readonly 해제
	}else if(val == "2"){ //** 정보공개 결정 ▶ 비공개
		formObj.find("tr[name=clsdDiv3]").hide();			//공개내용
		formObj.find("th[name=clsdTd5]").hide();
		formObj.find("td[name=clsdTd6]").hide();
		
		formObj.find("tr[name=clsdDiv1]").show();      	//비공개 (전부 또는 일부) 내용 및 사유
		formObj.find("tr[name=clsdDiv2]").show();      	//비공개 첨부
		
		formObj.find("tr[name=clsdDiv4]").hide();      	//공개방법
		formObj.find("th[name=clsdTd7]").hide();
		formObj.find("th[name=clsdTd8]").hide();
		formObj.find("td[name=clsdTd9]").hide();
		
		formObj.find("tr[name=clsdDiv5]").hide();      	//교부방법
		formObj.find("th[name=clsdTd10]").hide();
		formObj.find("td[name=clsdTd11]").hide();

		formObj.find("tr[name=clsdDiv6]").hide();      	//부존재사유
		formObj.find("th[name=clsdTd61]").hide();
		formObj.find("td[name=clsdTd62]").hide();
		
		formObj.find("tr[name=clsdDiv21]").show();      	//공개일자
		formObj.find("th[name=clsdTd211]").show();
		formObj.find("td[name=clsdTd212]").show();
		formObj.find("th[name=clsdTd213]").show();
		formObj.find("td[name=clsdTd214]").show();
		
		formObj.find("tr[name=clsdDiv22]").show();      	//수수료
		formObj.find("th[name=clsdTd221]").show();
		formObj.find("td[name=clsdTd222]").show();
		formObj.find("th[name=clsdTd223]").show();
		formObj.find("td[name=clsdTd224]").show();
		
		formObj.find("tr[name=clsdDiv23]").show();      //수수료감면액
		formObj.find("th[name=clsdTd231]").show();
		formObj.find("td[name=clsdTd232]").show();
		formObj.find("th[name=clsdTd233]").show();
		formObj.find("td[name=clsdTd234]").show();
		
		formObj.find("tr[name=clsdDiv24]").show();      //수수료산정내역
		formObj.find("th[name=clsdTd241]").show();
		formObj.find("td[name=clsdTd242]").show();
		formObj.find("th[name=clsdTd243]").show();
		formObj.find("td[name=clsdTd244]").show();
		
		formObj.find("tr[name=clsdDiv25]").show();      	//제3자 의견 등록첨부 
		formObj.find("th[name=clsdTd251]").show();
		formObj.find("td[name=clsdTd252]").show();
		
		formObj.find("tr[name=clsdDiv26]").show();      	//심의회 관리 첨부 
		formObj.find("th[name=clsdTd261]").show();
		formObj.find("td[name=clsdTd262]").show();
		
		formObj.find("tr[name=clsdDiv27]").show();      	//즉시처리  
		formObj.find("th[name=clsdTd271]").show();
		formObj.find("td[name=clsdTd272]").show();
		
		formObj.find("tr[name=clsdDiv28]").show();      	//즉시처리첨부  
		formObj.find("th[name=clsdTd281]").show();
		formObj.find("td[name=clsdTd282]").show();
		
		formObj.find("textarea[name=opb_cn]").val("");				//공개내용 초기화
		formObj.find("input[name=fee]").attr("readOnly", true);	//수수료(A) readonly 설정
		formObj.find("input[name=zip_far]").attr("readOnly", true);	//우송료(B) readonly 설정
		formObj.find("input[name=fee_rdtn_amt]").attr("readOnly", true);	//수수료 감면액(C) readonly 설정	
	}else if(val == "3"){ //** 정보공개 결정 ▶ 부존재 등
		formObj.find("tr[name=clsdDiv3]").hide();			//공개내용
		formObj.find("th[name=clsdTd5]").hide();
		formObj.find("td[name=clsdTd6]").hide();
		
		formObj.find("tr[name=clsdDiv1]").hide();      	//비공개 (전부 또는 일부) 내용 및 사유
		formObj.find("tr[name=clsdDiv2]").hide();      	//비공개 첨부
		
		formObj.find("tr[name=clsdDiv4]").hide();      	//공개방법
		formObj.find("th[name=clsdTd7]").hide();
		formObj.find("th[name=clsdTd8]").hide();
		formObj.find("td[name=clsdTd9]").hide();
		
		formObj.find("tr[name=clsdDiv5]").hide();      	//교부방법
		formObj.find("th[name=clsdTd10]").hide();
		formObj.find("td[name=clsdTd11]").hide();

		formObj.find("tr[name=clsdDiv6]").show();      	//부존재사유
		formObj.find("th[name=clsdTd61]").show();
		formObj.find("td[name=clsdTd62]").show();
		
		formObj.find("tr[name=clsdDiv21]").hide();      	//공개일자
		formObj.find("th[name=clsdTd211]").hide();
		formObj.find("td[name=clsdTd212]").hide();
		formObj.find("th[name=clsdTd213]").hide();
		formObj.find("td[name=clsdTd214]").hide();
		
		formObj.find("tr[name=clsdDiv22]").hide();      	//수수료
		formObj.find("th[name=clsdTd221]").hide();
		formObj.find("td[name=clsdTd222]").hide();
		formObj.find("th[name=clsdTd223]").hide();
		formObj.find("td[name=clsdTd224]").hide();
		
		formObj.find("tr[name=clsdDiv23]").hide();      //수수료감면액
		formObj.find("th[name=clsdTd231]").hide();
		formObj.find("td[name=clsdTd232]").hide();
		formObj.find("th[name=clsdTd233]").hide();
		formObj.find("td[name=clsdTd234]").hide();
		
		formObj.find("tr[name=clsdDiv24]").hide();      //수수료산정내역
		formObj.find("th[name=clsdTd241]").hide();
		formObj.find("td[name=clsdTd242]").hide();
		formObj.find("th[name=clsdTd243]").hide();
		formObj.find("td[name=clsdTd244]").hide();
		
		formObj.find("tr[name=clsdDiv25]").hide();      	//제3자 의견 등록첨부 
		formObj.find("th[name=clsdTd251]").hide();
		formObj.find("td[name=clsdTd252]").hide();
		
		formObj.find("tr[name=clsdDiv26]").hide();      	//심의회 관리 첨부 
		formObj.find("th[name=clsdTd261]").hide();
		formObj.find("td[name=clsdTd262]").hide();
		
		formObj.find("tr[name=clsdDiv27]").hide();      	//즉시처리  
		formObj.find("th[name=clsdTd271]").hide();
		formObj.find("td[name=clsdTd272]").hide();
		
		formObj.find("tr[name=clsdDiv28]").hide();      	//즉시처리첨부  
		formObj.find("th[name=clsdTd281]").hide();
		formObj.find("td[name=clsdTd282]").hide();
		
		formObj.find("select[name=clsd_rson_cd]").val("");	//비공개사유를 선택 초기화
		//formObj.find("textarea[name=clsd_rmk]").val("");	//비공개 (전부 또는 일부) 내용 및 사유 초기화
		formObj.find("input[name=fee]").attr("readOnly", false);	//수수료(A) readonly 설정
		formObj.find("input[name=zip_far]").attr("readOnly", false);	//우송료(B) readonly 해제
		formObj.find("input[name=fee_rdtn_amt]").attr("readOnly", false);	//수수료 감면액(C) readonly 해제
	}
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

//정보공개 처리대장 출력
function fn_print() {
	var frm = document.statMainForm;
	var pfrm = document.printForm;

	pfrm.width.value = "975";
	pfrm.height.value = "730";
	pfrm.title.value = "정보공개 처리대장 출력"; 

	var mrdParamVal = "/rp [";
	mrdParamVal += frm.aplDealInstCd.value;
	mrdParamVal += "] [";
	mrdParamVal += frm.prgStatCd.value;
	mrdParamVal += "] [";
	mrdParamVal += frm.aplSj.value;
	mrdParamVal += "] [";
	mrdParamVal += frm.aplDtsCn.value;
	mrdParamVal += "] [";
	mrdParamVal += frm.aplPn.value;
	mrdParamVal += "] [";
	mrdParamVal += frm.startAplDt.value.split('-').join('');
	mrdParamVal += "] [";
	mrdParamVal += frm.endAplDt.value.split('-').join('');
	mrdParamVal += "] [";
	mrdParamVal += frm.opbYn.value;
	mrdParamVal += "]";
	pfrm.mrdParam.value = mrdParamVal;
			
	window.open('', 'popup', 'width=975, height=730, resizable=yes, location=no;');
	pfrm.target = 'popup';
	pfrm.action = "/admin/expose/infoPrintPage/printNewOpnAplPrc.do";
	pfrm.submit();
}

//정보공개 결정통지서 출력
function fn_dcsPrint(){
	var pfrm = document.printForm;
	var objTab = getTabShowObj();//탭이 oepn된 객체가져옴
	var formObj = objTab.find("form[name=detail-form]");
	var cVersion = formObj.find("input[name=callVersion]").val();
	
	pfrm.width.value = "680";
	pfrm.height.value = "700";
	pfrm.title.value = "정보공개 결정통지서 출력";
	pfrm.mrdParam.value =  "/rp ["+formObj.find("input[name=apl_no]").val()+"] [1]" ;
	window.open("","popup","width=680, height=700, resizable=yes, location=no;");
	pfrm.target = "popup";
	if(cVersion == 'V1'){	//2단계 개선사업 이전일 경우 이전 통지서를 호출한다.
		pfrm.action = "/admin/expose/infoPrintPage/printOpndcs.do";
	}else{	//2단계 개선사업 이후일 경우 신규 통지서를 호출한다.
		/* 청구내용 확인 로직 추가 > 결정통지서의 정보공개청구내용에 맞지 않을 경우(초과) 별지참조 처리*/
		var tArea = formObj.find("textarea[name=printAplModDtsCn]").val(); //청구내용 - 출력용
		var totLine = chkTotLine(tArea);
		/* 비공개 내용 및 사유 확인 로직 추가 > 결정통지서의 비공개 내용 및 사유에 맞지 않을 경우(초과) 별지참조 처리*/
		var tClsdArea = formObj.find("textarea[name=printClsdRmk]").val(); //비공개사유 - 출력용
		var totClsdLine = chkTotLine(tClsdArea);
		if(totLine > 8 && totClsdLine > 4){ //결정통지서의 정보공개청구내용은 최대 8줄, 비공개 내용 및 사유는 최대 4줄
			pfrm.action = "/admin/expose/infoPrintPage/printNewOpndcsRefer3.do";
		}else{
			if(totClsdLine > 4){
				pfrm.action = "/admin/expose/infoPrintPage/printNewOpndcsRefer2.do";
			}else if(totLine > 8){
				pfrm.action = "/admin/expose/infoPrintPage/printNewOpndcsRefer1.do";
			}else{
				pfrm.action = "/admin/expose/infoPrintPage/printNewOpndcs.do";
			}
		}
	}
	pfrm.submit();
}

//정보 부존재 등 통지서 출력
function fn_nonPrint(){
	var pfrm = document.printForm;
	var objTab = getTabShowObj();//탭이 oepn된 객체가져옴
	var formObj = objTab.find("form[name=detail-form]");
	var cVersion = formObj.find("input[name=callVersion]").val();
	pfrm.width.value = "680";
	pfrm.height.value = "700";
	pfrm.title.value = "정보 부존재 등 통지서 출력";
	pfrm.mrdParam.value =  "/rp ["+formObj.find("input[name=apl_no]").val()+"] [1]" ;
	window.open("","popup","width=680, height=700, resizable=yes, location=no;");
	pfrm.target = "popup";

	if(cVersion == 'V1'){	//2단계 개선사업 이전일 경우 이전 통지서를 호출한다.
		pfrm.action = "/admin/expose/infoPrintPage/printNonext.do";
	}else{	//2단계 개선사업 이후일 경우 신규 통지서를 호출한다.
		/* 청구내용 확인 로직 추가 > 정보 부존재 등 통지서의 정보공개청구내용에 맞지 않을 경우(초과) 별지참조 처리*/
		var tArea = formObj.find("textarea[name=printAplModDtsCn]").val(); //청구내용 - 출력용
		var totLine = chkTotLine(tArea);
		if(totLine > 11){ //정보 부존재 등 통지서의 정보공개청구내용은 최대 11줄
			pfrm.action = "/admin/expose/infoPrintPage/printNewNonextRefer.do";
		}else{
			pfrm.action = "/admin/expose/infoPrintPage/printNewNonext.do";
		}
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

//수수료 납부여부 선택여부
function fn_FeeCheck(){
	var objTab = getTabShowObj();//탭이 oepn된 객체가져옴
	var formObj = objTab.find("form[name=detail-form]");

	if(formObj.find("input[name=fee_yn]").is(":checked") == true) {
		formObj.find("tr[name=trFileDiv]").show();
		formObj.find("tr[name=trFileDiv2]").show();
		
		formObj.find("div[name=feeChkDetail]").show();
	}else {
		formObj.find("tr[name=trFileDiv]").hide();
		formObj.find("tr[name=trFileDiv2]").hide();
		
		formObj.find("div[name=feeChkDetail]").hide();
	}
}

//청구 상세화면으로 이동
function fn_directPage(){
	var objTab = getTabShowObj();//탭이 oepn된 객체가져옴
	var formObj = objTab.find("form[name=detail-form]");
	var formApl = $("form[name=opnzAplForm]");
	
	var aplNo = formObj.find("input[name=apl_no]").val();
	
	formApl.find("input[name=aplNo]").val(aplNo) ;
	formApl.attr("action", com.wise.help.url("/admin/expose/offlineWriteAccountPage.do"));
	formApl.attr("target", "_blank");
	formApl.submit();
}

//리스트화면 [처리상태] select 선택에 따른 확인
function fn_subElement(){
	var objTab = getTabShowObj();//탭이 oepn된 객체가져옴
	var formObj = objTab.find("form[name=statMainForm]");
	
	if(formObj.find("select[name=prgStatCd]").val() == '04') {
		formObj.find("span[name=subElement]").show();
	} else {
		formObj.find("span[name=subElement]").hide();
	}
}

//팝업닫기후 액션
function popUpCloseEvent(aplNo){
	
	var tabId = "tabs-"+aplNo; //탭 id
	$("#"+tabId).closest("li").remove(); // 현재탭 닫기	
	
	$("#tabs-main").click();

	doAction("search"); // 다시조회
}

//비공개(전부 또는 일부) 내용 및 사유 추가
function fn_clsdAdd(){
	var objTab = getTabShowObj();//탭이 oepn된 객체가져옴
	var formObj = objTab.find("form[name=detail-form]");
	
	var nextClsdCnt = Number(formObj.find("input[name=clsdCnt]").val()) + 1;
	
	var clsdHtml = '<label name="clsd'+nextClsdCnt+'">';
	clsdHtml += '<table class="list02" style="width:800px;">';
	clsdHtml += '	<colgroup>';
	clsdHtml += '		<col style="width:100px;">';
	clsdHtml += '		<col style="width:600px;">';
	clsdHtml += '		<col style="width:100px;">';
	clsdHtml += '	</colgroup>';
	clsdHtml += '	<tbody name="privateInfo">';
	clsdHtml += '		<tr>';
	clsdHtml += '			<td style="background:#ECEBFF;font-weight: bold;">비공개내용</td>';
	clsdHtml += '			<td>';
	clsdHtml += '				<textarea name="clsd_rmk" rows="3" cols="75" style="border-color:#5F00FF;"></textarea><br />';
	clsdHtml += '				<span class="byte_r"><input type="text" name="len4" style="width:30px; text-align:right;border: none;margin-bottom:3px;padding:1px;" value="0" readonly>/500 Byte</span>';
	clsdHtml += '			</td>';
	clsdHtml += '			<td rowspan="2" style="border-right-color: #FFFFFF;border-top-color: #FFFFFF;border-bottom-color: #FFFFFF;vertical-align: top;"	>';
	clsdHtml += '					<button type="button" class="btn01" name="clsdDel" onclick="javascript:fn_clsdDel('+nextClsdCnt+');">삭제</button>';
	clsdHtml += '			</td>';
	clsdHtml += '		</tr>';
	clsdHtml += '		<tr>';
	clsdHtml += '			<td style="background:#ECEBFF;font-weight: bold;">비공개사유</td>';
	clsdHtml += '			<td>';
	clsdHtml += '				<select name="clsd_rson_cd" style="border-color:#5F00FF;">';
	clsdHtml += '					<option value="">비공개사유를 선택하세요</option>';
	$.each(glbClsdData, function(key, value){ 1
	clsdHtml += '					<option value="'+value.baseCd+'">'+value.baseNm+'</option>';
	});
	clsdHtml += '				</select>';
	clsdHtml += '               <input type="text" name="clsd_rson" size="53" value=""  style="border-color:#5F00FF;display: none;"/>';
	clsdHtml += '			</td>';
	clsdHtml += '		</tr>';
	clsdHtml += '	</tbody>';
	clsdHtml += '</table>';
	clsdHtml += '</label>';
	formObj.find("div[name=clsdArea]").append(clsdHtml);
	
	formObj.find("input[name=clsdCnt]").val(nextClsdCnt);
	
	
	//비공개사유 > 기타(부존재등) 선택 시 INPUT 박스 오픈
	formObj.find("label[name=clsd"+nextClsdCnt+"]").find("select[name=clsd_rson_cd]").bind("change", function(event) {
		var val = $(this).val();
		if(val == "09"){
			formObj.find("label[name=clsd"+nextClsdCnt+"]").find("input[name=clsd_rson]").show();
		}else{
			formObj.find("label[name=clsd"+nextClsdCnt+"]").find("input[name=clsd_rson]").hide();
		}
	});
	
	//비공개 (전부 또는 일부) 내용 및 사유
	formObj.find("label[name=clsd"+nextClsdCnt+"]").find("textarea[name=clsd_rmk]").bind("keyup", function(event) {
		var obj = formObj.find("label[name=clsd"+nextClsdCnt+"]").find("textarea[name=clsd_rmk]");
		textAreaLabelLenChk(obj, 'clsd'+nextClsdCnt, 'len4', 500);
	});
	
}

//비공개(전부 또는 일부) 내용 및 사유 삭제
function fn_clsdDel(delCnt){
	var objTab = getTabShowObj();//탭이 oepn된 객체가져옴
	var formObj = objTab.find("form[name=detail-form]");
	
	formObj.find("label[name=clsd"+delCnt+"]").remove();
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