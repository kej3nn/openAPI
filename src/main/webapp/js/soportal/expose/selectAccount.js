/*
 * @(#)selectAccount.js 1.0 2019/07/22
 */

/**
 * 정보공개 > 청구서 작성 내용을 조회하는 스크립트이다.
 *
 * @author SoftOn
 * @version 1.0 2018/04/19
 */
$(function() {
	
    // 컴포넌트를 초기화한다.
    initComp();
    
    // 이벤트를 바인딩한다.
    bindEvent();
});

////////////////////////////////////////////////////////////////////////////////
// 초기화 함수
////////////////////////////////////////////////////////////////////////////////
/**
 * 컴포넌트를 초기화한다.
 */
function initComp() {
    // Nothing to do.
}

/**
 * 이벤트를 바인딩한다.
 */
function bindEvent() {
	fn_clsdDiv();
}

/**
 * 옵션을 로드한다.
 */
function loadOptions() {
    // Nothing do do.
}

////////////////////////////////////////////////////////////////////////////////
//기존 JS 함수
////////////////////////////////////////////////////////////////////////////////
function fn_infoCancle(val){
	var frm = document.form;
	if(!(confirm('청구취하를 하시겠습니까?'))){
		return;
	}
	frm.apl_cancle.value = val;
	cancelData();
}

/**
 * 데이터 청구취하
 */
function cancelData() {
	var formObj = $("form[name=form]");
	formObj.ajaxSubmit({
		url : com.wise.help.url("/portal/expose/withdrawAccount.do")
		, async : false
		, type : 'post'
		, dataType: 'json' 
		, contentType : 'application/x-www-form-urlencoded;charset=UTF-8'
		, beforeSubmit : function() {
		}	
		, success : function(res, status) {
			if(res.data == "처리가 불가능한 청구서입니다."){
				alert(res.data);
			}
			doAjaxMsg(res, "");
			location.href = com.wise.help.url("/portal/expose/searchAccountPage.do");
		}
		, error: function(jqXHR, textStatus, errorThrown) {
			alert("처리 도중 에러가 발생하였습니다.");
		}
	});
}

function fn_fileDown(fileGb){
	var frm = document.form;
	if(fileGb == '1'){
		frm.fileName.value = frm.apl_attch_flnm.value;
		frm.filePath.value = frm.apl_attch_flph.value;
	}else if(fileGb == '2'){
		frm.fileName.value = frm.fee_rdtn_attch_flnm.value;
		frm.filePath.value = frm.fee_rdtn_attch_flph.value;
	}else if(fileGb == '3'){
		frm.fileName.value = frm.opb_flnm.value;
		frm.filePath.value = frm.opb_flph.value;
	}else if(fileGb == '4'){
		frm.fileName.value = frm.opb_flnm2.value;
		frm.filePath.value = frm.opb_flph2.value;
	}else if(fileGb == '5'){
		frm.fileName.value = frm.opb_flnm3.value;
		frm.filePath.value = frm.opb_flph3.value;
	}else if(fileGb == '6'){
		frm.fileName.value = frm.trsf_fl_nm.value;
		frm.filePath.value = frm.trsf_fl_ph.value;	
	}else if(fileGb == '7'){
		frm.fileName.value = frm.imd_fl_nm.value;
		frm.filePath.value = frm.imd_fl_ph.value;	
	}else if(fileGb == '8'){
		frm.fileName.value = frm.non_fl_nm.value;
		frm.filePath.value = frm.non_fl_ph.value;
	} else {
		frm.fileName.value = frm.clsd_attch_fl_nm.value;
		frm.filePath.value = frm.clsd_attch_fl_ph_nm.value;
	}
	frm.action = "/portal/expose/downloadOpnAplFile.do";
	frm.submit();
}
function fn_infoPrint(printDiv, cVersion){
	var frm = document.printForm;
	frm.mrdParam.value =  "/rp [" + document.form.apl_no.value + "]";
	
	if(printDiv == 'apl'){
		frm.width.value = "680";
		frm.height.value = "700";
		frm.title.value = "정보공개 청구서 출력";
		
		if(cVersion == 'V1'){	//2단계 개선사업 이전일 경우 이전 통지서를 호출한다.
			frm.action = "/portal/expose/reportingPage/printOpnapl.do";
		}else{	//2단계 개선사업 이후일 경우 신규 통지서를 호출한다.
			/* 청구내용 확인 로직 추가 > 정보공개 청구서의 청구내용에 맞지 않을 경우(초과) 별지참조 처리*/
			var tArea = document.form.printAplDtsCn.value; //청구내용 - 출력용
			var totLine = chkTotLine(tArea);
			if(totLine > 15){ //정보공개 청구서의 청구내용은 최대 15줄
				frm.action = "/portal/expose/reportingPage/printNewOpnaplRefer.do";
			}else{
				frm.action = "/portal/expose/reportingPage/printNewOpnapl.do";
			}
		}
	}else if(printDiv == 'rcp'){
		frm.width.value = "680";
		frm.height.value = "500";
		frm.title.value = "정보공개 접수증 출력";
		if(cVersion == 'V1'){	//2단계 개선사업 이전일 경우 이전 통지서를 호출한다.
			frm.action = "/portal/expose/reportingPage/printOpnrcp.do";
		}else{
			frm.action = "/portal/expose/reportingPage/printNewOpnrcp.do";
		}
	}else if(printDiv == 'ext'){
		frm.width.value = "680";
		frm.height.value = "700";
		frm.title.value = "정보공개 연장통지서 출력";

		if(cVersion == 'V1'){	//2단계 개선사업 이전일 경우 이전 통지서를 호출한다.
			frm.action = "/portal/expose/reportingPage/printOpnext.do";
		}else{	//2단계 개선사업 이후일 경우 신규 통지서를 호출한다.
			/* 청구내용 확인 로직 추가 > 공개 여부 결정기간 연장 통지서의 정보공개청구내용에 맞지 않을 경우(초과) 별지참조 처리*/
			var tArea = document.form.printAplDtsCn.value; //청구내용 - 출력용
			var totLine = chkTotLine(tArea);
			if(totLine > 8){ //공개 여부 결정기간 연장 통지서의 정보공개청구내용은 최대 8줄
				frm.action = "/portal/expose/reportingPage/printNewOpnextRefer.do";
			}else{
				frm.action = "/portal/expose/reportingPage/printNewOpnext.do";
			}
		}
	}else if(printDiv == 'dcs'){
		frm.width.value = "680";
		frm.height.value = "700";
		frm.title.value = "정보공개 결정통지서 출력";
		
		if(cVersion == 'V1'){	//2단계 개선사업 이전일 경우 이전 통지서를 호출한다.
			frm.action = "/portal/expose/reportingPage/printOpndcs.do";
		}else{	//2단계 개선사업 이후일 경우 신규 통지서를 호출한다.
			/* 청구내용 확인 로직 추가 > 결정통지서의 정보공개청구내용에 맞지 않을 경우(초과) 별지참조 처리*/
			var tArea = document.form.printAplDtsCn.value;  //청구내용 - 출력용
			var totLine = chkTotLine(tArea);
			/* 비공개 내용 및 사유 확인 로직 추가 > 결정통지서의 비공개 내용 및 사유에 맞지 않을 경우(초과) 별지참조 처리*/
			var tClsdArea = document.form.printClsdRmk.value; //비공개사유 - 출력용
			var totClsdLine = chkTotLine(tClsdArea);
			if(totLine > 8 && totClsdLine > 4){ //결정통지서의 정보공개청구내용은 최대 8줄, 비공개 내용 및 사유는 최대 4줄
				frm.action = "/portal/expose/reportingPage/printNewOpndcsRefer3.do";
			}else{
				if(totClsdLine > 4){
					frm.action = "/portal/expose/reportingPage/printNewOpndcsRefer2.do";
				}else if(totLine > 8){
					frm.action = "/portal/expose/reportingPage/printNewOpndcsRefer1.do";
				}else{
					frm.action = "/portal/expose/reportingPage/printNewOpndcs.do";
				}
			}
		}
	}else if(printDiv == 'trsf'){
		frm.width.value = "680";
		frm.height.value = "700";
		frm.title.value = "이송통지서 출력";

		if(cVersion == 'V1'){	//2단계 개선사업 이전일 경우 이전 통지서를 호출한다.
			frm.action = "/portal/expose/reportingPage/printOpntrn.do";
		}else{	//2단계 개선사업 이후일 경우 신규 통지서를 호출한다.
			/* 청구내용 확인 로직 추가 > 정보공개 청구서 기관이송 통지서의 청구정보내용에 맞지 않을 경우(초과) 별지참조 처리*/
			var tArea = document.form.printAplDtsCn.value; //청구내용 - 출력용
			var totLine = chkTotLine(tArea);
			if(totLine > 9){ //정보공개 청구서 기관이송 통지서의 청구정보내용은 최대 9줄
				frm.action = "/portal/expose/reportingPage/printNewOpntrnRefer.do";
			}else{
				frm.action = "/portal/expose/reportingPage/printNewOpntrn.do";
			}
		}
	}else if(printDiv == 'non'){
		frm.width.value = "680";
		frm.height.value = "700";
		frm.title.value = "부존재 등 통지서 출력";

		if(cVersion == 'V1'){	//2단계 개선사업 이전일 경우 이전 통지서를 호출한다.
			frm.action = "/portal/expose/reportingPage/printNonext.do";
		}else{	//2단계 개선사업 이후일 경우 신규 통지서를 호출한다.
			/* 청구내용 확인 로직 추가 > 정보 부존재 등 통지서의 정보공개청구내용에 맞지 않을 경우(초과) 별지참조 처리*/
			var tArea = document.form.printAplDtsCn.value; //청구내용 - 출력용
			var totLine = chkTotLine(tArea);
			if(totLine > 11){ //정보 부존재 등 통지서의 정보공개청구내용은 최대 11줄
				frm.action = "/portal/expose/reportingPage/printNewNonextRefer.do";
			}else{
				frm.action = "/portal/expose/reportingPage/printNewNonext.do";
			}			
		}
	}
	
	if(printDiv == 'rcp'){
		window.open("","popup","width=680, height=500, resizable=yes, location=no;");
	}else{
		window.open("","popup","width=680, height=700, resizable=yes, location=no;");
	}
	
	frm.target = "popup";
	frm.submit();
}

function fn_clsdDiv(){
	
	var frm = document.form;
	if('${opnAplDo.opb_yn }' == "공개"){
		
		fn_getId("clsdTr10").style.display  = 'none';      //비공개사유
		fn_getId("clsdTd101").style.display = 'none';      
		fn_getId("clsdTd102").style.display = 'none';    
		fn_getId("clsdTr11").style.display  = 'none';      //비공개 첨부파일
		fn_getId("clsdTd111").style.display = 'none';      
		fn_getId("clsdTd112").style.display = 'none';      
		fn_getId("clsdTr12").style.display  = '';      //결정통지안내수신
		fn_getId("clsdTd121").style.display = '';      
		fn_getId("clsdTd122").style.display = '';      
		fn_getId("clsdTr13").style.display  = '';      //결정통지 첨부파일
		fn_getId("clsdTd131").style.display = '';      
		fn_getId("clsdTd132").style.display = '';      
		fn_getId("clsdTr14").style.display  = '';      //타기과이송 
		fn_getId("clsdTd141").style.display = '';      
		fn_getId("clsdTd142").style.display = '';
		fn_getId("clsdTr143").style.display = '';
		fn_getId("clsdTr15").style.display  = '';      //특이사항
		fn_getId("clsdTd151").style.display = '';      
		fn_getId("clsdTd152").style.display = '';
		fn_getId("clsdTr16").style.display  = '';      //종결사유
		fn_getId("clsdTrNon1").style.display = 'none';      //부존재
		fn_getId("clsdTdNon1").style.display = 'none';      
		fn_getId("clsdTdNon2").style.display = 'none';
		fn_getId("clsdTrNon2").style.display = 'none';      //부존재
		fn_getId("clsdTdNon21").style.display = 'none';      
		fn_getId("clsdTdNon22").style.display = 'none';
		
	}else if('${opnAplDo.opb_yn }' == "부분공개"){

		fn_getId("clsdTr10").style.display  = '';      //비공개사유
		fn_getId("clsdTd101").style.display = '';      
		fn_getId("clsdTd102").style.display = '';    
		fn_getId("clsdTr11").style.display  = '';      //비공개 첨부파일
		fn_getId("clsdTd111").style.display = '';      
		fn_getId("clsdTd112").style.display = '';      
		fn_getId("clsdTr12").style.display  = '';      //결정통지안내수신
		fn_getId("clsdTd121").style.display = '';      
		fn_getId("clsdTd122").style.display = '';      
		fn_getId("clsdTr13").style.display  = '';      //결정통지 첨부파일
		fn_getId("clsdTd131").style.display = '';      
		fn_getId("clsdTd132").style.display = '';      
		fn_getId("clsdTr14").style.display  = '';      //타기과이송 
		fn_getId("clsdTd141").style.display = '';      
		fn_getId("clsdTd142").style.display = '';
		fn_getId("clsdTr143").style.display = '';
		fn_getId("clsdTr15").style.display  = '';      //특이사항
		fn_getId("clsdTd151").style.display = '';      
		fn_getId("clsdTd152").style.display = '';  
		fn_getId("clsdTr16").style.display  = '';      //종결사유
		fn_getId("clsdTrNon1").style.display = 'none';      //부존재
		fn_getId("clsdTdNon1").style.display = 'none';      
		fn_getId("clsdTdNon2").style.display = 'none';
		fn_getId("clsdTrNon2").style.display = 'none';      //부존재
		fn_getId("clsdTdNon21").style.display = 'none';      
		fn_getId("clsdTdNon22").style.display = 'none'; 
		
		
	}else if('${opnAplDo.opb_yn }' == "비공개"){

		fn_getId("clsdTr10").style.display  = '';      //비공개사유
		fn_getId("clsdTd101").style.display = '';      
		fn_getId("clsdTd102").style.display = '';    
		fn_getId("clsdTr11").style.display  = '';      //비공개 첨부파일
		fn_getId("clsdTd111").style.display = '';      
		fn_getId("clsdTd112").style.display = '';      
		fn_getId("clsdTr12").style.display  = '';      //결정통지안내수신
		fn_getId("clsdTd121").style.display = '';      
		fn_getId("clsdTd122").style.display = '';      
		fn_getId("clsdTr13").style.display  = '';      //결정통지 첨부파일
		fn_getId("clsdTd131").style.display = '';      
		fn_getId("clsdTd132").style.display = '';      
		fn_getId("clsdTr14").style.display  = '';      //타기과이송 
		fn_getId("clsdTd141").style.display = '';      
		fn_getId("clsdTd142").style.display = '';
		fn_getId("clsdTr143").style.display = '';
		fn_getId("clsdTr15").style.display  = '';      //특이사항
		fn_getId("clsdTd151").style.display = '';      
		fn_getId("clsdTd152").style.display = '';  
		fn_getId("clsdTr16").style.display  = '';      //종결사유
		fn_getId("clsdTrNon1").style.display = 'none';      //부존재
		fn_getId("clsdTdNon1").style.display = 'none';      
		fn_getId("clsdTdNon2").style.display = 'none'; 
		fn_getId("clsdTrNon2").style.display = 'none';      //부존재
		fn_getId("clsdTdNon21").style.display = 'none';      
		fn_getId("clsdTdNon22").style.display = 'none';
		
		
	}else if('${opnAplDo.opb_yn }' == "부존재 등"){

		fn_getId("clsdTr10").style.display  = 'none';      //비공개사유
		fn_getId("clsdTd101").style.display = 'none';      
		fn_getId("clsdTd102").style.display = 'none';    
		fn_getId("clsdTr11").style.display  = 'none';      //비공개 첨부파일
		fn_getId("clsdTd111").style.display = 'none';      
		fn_getId("clsdTd112").style.display = 'none';      
		fn_getId("clsdTr12").style.display  = 'none';      //결정통지안내수신
		fn_getId("clsdTd121").style.display = 'none';      
		fn_getId("clsdTd122").style.display = 'none';      
		fn_getId("clsdTr13").style.display  = 'none';      //결정통지 첨부파일
		fn_getId("clsdTd131").style.display = 'none';      
		fn_getId("clsdTd132").style.display = 'none';      
		fn_getId("clsdTr14").style.display  = 'none';      //타기과이송 
		fn_getId("clsdTd141").style.display = 'none';      
		fn_getId("clsdTd142").style.display = 'none';
		fn_getId("clsdTr143").style.display = 'none';
		fn_getId("clsdTr15").style.display  = 'none';      //특이사항
		fn_getId("clsdTd151").style.display = 'none';      
		fn_getId("clsdTd152").style.display = 'none';   
		fn_getId("clsdTr16").style.display  = 'none';      //종결사유
		fn_getId("clsdTrNon1").style.display = '';      //부존재
		fn_getId("clsdTdNon1").style.display = '';      
		fn_getId("clsdTdNon2").style.display = '';
		fn_getId("clsdTrNon2").style.display = '';      //부존재
		fn_getId("clsdTdNon21").style.display = '';      
		fn_getId("clsdTdNon22").style.display = '';
		 
	}
}

function winOpenManual(){
	window.open('/jsp/common/go_manual.jsp','pop','left=611,top=50');
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