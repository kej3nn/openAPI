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
	$("button[name=btn_xlsDown]").bind("click", function(event) {
		//엑셀다운
		doAction("excel");
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
		case "excel":
			sheet.Down2Excel({FileName:'정보공개청구내역.xls',SheetName:'sheet'});
			break;	
	}
}


////////////////////////////////////////////////////////////////////////////////
// 후처리 함수
////////////////////////////////////////////////////////////////////////////////
//상세 탭 이벤트 후처리
function tabFunction(tab, data) {
	var formObj = getTabFormObj("writeAccount-dtl-form");
	
	var fileHtml = "";
	var file1Html = "";
	var file2Html = "";
	
	
	//청구내역 상세 데이터
	var dataDtl = data.DATA; 
	
	if(dataDtl != ""){
		
		//처리중 상태일때
		tab.ContentObj.find("span[name=rcpDtsNo]").text(com.wise.util.isNull(dataDtl.rcpDtsNo) ? "" : dataDtl.rcpDtsNo);
		
		tab.ContentObj.find("span[name=rcpDt]").text(com.wise.util.isNull(dataDtl.rcpDt) ? "" : parseDate(dataDtl.rcpDt)); //일자
		tab.ContentObj.find("span[name=dealDlnDt]").text(com.wise.util.isNull(dataDtl.dealDlnDt) ? "" : parseDate(dataDtl.dealDlnDt)); //처리기한
		tab.ContentObj.find("span[name=aplModSj]").text(dataDtl.aplModSj); //수정청구제목
		tab.ContentObj.find("pre[name=aplModDtsCn]").text(dataDtl.aplModDtsCn); //수정청구내용
		//청구대상기관
		tab.ContentObj.find("span[name=aplInstNm]").text(dataDtl.aplDealInstNm);
		
		//청구제목
		tab.ContentObj.find("span[name=aplSj]").text(com.wise.util.isNull(dataDtl.aplSj) ? "" : dataDtl.aplSj);
		//청구내용
		tab.ContentObj.find("pre[name=aplDtsCn]").text(com.wise.util.isNull(dataDtl.aplDtsCn) ? "" : dataDtl.aplDtsCn);
		//수령방법
		if(dataDtl.aplTakMth == "05"){ //기타일때
			tab.ContentObj.find("span[name=aplTakMthEtc]").text(dataDtl.aplTakMthNm + "," + (com.wise.util.isNull(dataDtl.aplTakMthEtc) ? "" :dataDtl.aplTakMthEtc));
		}else{
			tab.ContentObj.find("span[name=aplTakMthEtc]").text(dataDtl.aplTakMthNm);
		}
		
		//첨부문서 
		if(dataDtl.attchFlNm != null){
			tab.ContentObj.find("div[id=fileArea]").hide();
			fileHtml += "<a href=\"#\" style=\"text-decoration:none;\">";
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
			
		}
		
		//공개형태
		if(dataDtl.opbFomVal == "05"){ //기타일때 
			tab.ContentObj.find("span[name=opbFomEtc]").text(dataDtl.opbFomValNm + "," + (com.wise.util.isNull(dataDtl.opbFomEtc) ? "" :dataDtl.opbFomEtc));
		}else{
			tab.ContentObj.find("span[name=opbFomEtc]").text(dataDtl.opbFomValNm);
		}
		
		//결정통지 안내수신
		tab.ContentObj.find("span[name=dcsNtcRcvMthArea]").text(com.wise.util.isNull(dataDtl.dcsNtcRcvMthNm) ? "" : dataDtl.dcsNtcRcvMthNm);
		
		//수수료 감면 여부
		tab.ContentObj.find("span[name=feeRdtnNm]").text(dataDtl.feeRdtnNm);
		
		
		//감면여부 첨부문서
		if(dataDtl.rcpPrgStatCd == "08" && dataDtl.clsdRmk == null){
			tab.ContentObj.find("span[name=feeRdtnRson]").text("해당없음");
			tab.ContentObj.find("span[name=feeAttchFlNm]").text("해당없음");
		}else{
			formObj.find("span[name=feeRdtnRson]").text(com.wise.util.isNull(dataDtl.feeRdtnRson) ? "" : dataDtl.feeRdtnRson); //감면사유
			
			if(dataDtl.feeAttchFlNm != null){
				tab.ContentObj.find("div[id=file1Area]").hide();
				file1Html += "<a href=\"#\" style=\"text-decoration:none;\">";
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
		
		//공개여부 관련 
		if(dataDtl.opbYn != null) {
			tab.ContentObj.find("tbody[id=opnzDcsArea]").show();
			tab.ContentObj.find("span[name=opbYn]").text(dataDtl.opbYn); //공개여부
			
			//비공개사유
			if(dataDtl.rcpPrgStatCd == "08" && dataDtl.clsdRmk == null){
				tab.ContentObj.find("span[name=clsdRmk]").text("해당없음");
			}else{
				tab.ContentObj.find("span[name=clsdRmk]").text(com.wise.util.isNull(dataDtl.clsdRmk) ? "" : dataDtl.clsdRmk);
			}
			
			//비공개 첨부파일
			if(dataDtl.clsdAttchFlNm != null){
				tab.ContentObj.find("tr[id=clsdAttchFlArea]").show();
				var clsdfile = "";
				clsdfile += "<a href=\"#\" style=\"text-decoration:none;\">";
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
			
			opbFlNmHtml += "<a href=\"#\" style=\"text-decoration:none;\" name=\"opbFlNm\">";
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
				
				opbFlNm2Html += "<a href=\"#\" style=\"text-decoration:none;\" name=\"opbFlNm2\">";
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
				
				opbFlNm3Html += "<a href=\"#\" style=\"text-decoration:none;\" name=\"opbFlNm3\">";
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
			tab.ContentObj.find("tr[id=aplDealInstArea]").show();
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
				file2Html += "<a href=\"#\" style=\"text-decoration:none;\">";
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

//상세 탭 이벤트
function tabEvent(row){//탭 이벤트 실행  
	
	var title = sheet.GetCellValue(row, "aplSj");//탭 제목
	var id = sheet.GetCellValue(row, "aplNo");//탭 id(유일한key))
	openTab.SetTabData(sheet.GetRowJson(row));//db data 조회시 조건 data
	var url =  com.wise.help.url('/admin/expose/selectOpnApplyDtl.do'); // Controller 호출 url 
	openTab.addTab(id, title, url, tabCallBack); 	// 탭 추가 시작함
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
	
	with(sheet){
		                     
		var cfg = {SearchMode:3,Page:50,VScrollMode:1};
	    SetConfig(cfg);
	    var headers = [
	                {Text:gridTitle, Align:"Center"}
	            ];
	    var headerInfo = {Sort:0,ColMove:0,ColResize:1,HeaderCheck:1};
	    
	    InitHeaders(headers, headerInfo);
	   
	    var cols = [
	                 {Type:"Seq",		SaveName:"seq",			    Width:30,	Align:"Center",		Edit:false}
	                ,{Type:"Status",	SaveName:"status",		    Width:30,	Align:"Center",		Edit:false,	Hidden:true}
	                ,{Type:"Text",	    SaveName:"aplNo",		    Width:30,	Align:"Center",		Edit:false,	Hidden:true}
					,{Type:"Text",		SaveName:"rcpDtsNo",	    Width:50,	Align:"Center",		Edit:false}
					,{Type:"Text",		SaveName:"aplDt",	        Width:50,	Align:"Center",		Edit:false, Format:"Ymd"}
					,{Type:"Text",		SaveName:"aplSj",		    Width:200,	Align:"Left",		Edit:false}
					,{Type:"Text",		SaveName:"aplPn",		    Width:50,	Align:"Center",		Edit:false,	Hidden:true}
					,{Type:"Text",		SaveName:"aplInstCd",	    Width:90,	Align:"Center",		Edit:false,	Hidden:true}
					,{Type:"Text",		SaveName:"aplInstNm",	    Width:90,	Align:"Center",		Edit:false,	Hidden:true}
					,{Type:"Text",		SaveName:"aplDealInstCd",	Width:90,	Align:"Center",		Edit:false,	Hidden:true}
					,{Type:"Text",		SaveName:"aplDealInstNm",	Width:90,	Align:"Center",		Edit:false}
					,{Type:"Text",		SaveName:"prgStatCd",	    Width:90,	Align:"Center",		Edit:false,	Hidden:true}
					,{Type:"Text",		SaveName:"opbYnNm",	        Width:50,	Align:"Center",		Edit:false}
					,{Type:"Text",		SaveName:"prgStatNm",	    Width:90,	Align:"Center",		Edit:false}
					,{Type:"Text",		SaveName:"endNm",	        Width:50,	Align:"Center",		Edit:false}
					,{Type:"Text",		SaveName:"dcsNtcDt",	    Width:50,	Align:"Center",		Edit:false, Format:"Ymd"}
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

////////////////////////////////////////////////////////////////////////////////
//Validation 함수
////////////////////////////////////////////////////////////////////////////////

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
