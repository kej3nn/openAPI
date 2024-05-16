/*
 * @(#)searchOpnObjtn.js 1.0 2019/08/12
 * 
 * COPYRIGHT (C) 2013 WISEITECH CO., LTD. ALL RIGHTS RESERVED.
 */

/**
 * 오프라인이의신청 스크립트 파일이다
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
var clsdData = "";
var clsdUseCnt = 0;
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
	$("input[name=aplTitle]").bind("keydown", function(event) {
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
		$("input[name=aplDtFrom], input[name=aplDtTo]").val("");
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
			sheet.DoSearchPaging(com.wise.help.url("/admin/expose/searchOpnObjtn.do"), param);
			break;
		case "insert" :
			saveData("I");
			break;
		case "update" :
			saveData("U");
			break;	
		case "excel":
			sheet.Down2Excel({FileName:'정보공개_오프라인이의신청가능내역.xls',SheetName:'sheet'});
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
		url : com.wise.help.url("/admin/expose/saveOpnObjtn.do")
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
	clsdData = data.DATA2.clsdList;
	
	//기본변수 데이터 할당
	tab.ContentObj.find("input[name=aplNo]").val(dataDtl.aplNo);
	tab.ContentObj.find("input[name=objtnSno]").val(dataDtl.objtnSno);
	tab.ContentObj.find("input[name=dcsNtcRcvmth]").val(dataDtl.dcsNtcRcvMthCd);
	tab.ContentObj.find("input[name=dcsNtcRcvmthSms]").val(dataDtl.dcsNtcRcvMthSms);
	tab.ContentObj.find("input[name=dcsNtcRcvmthMail]").val(dataDtl.dcsNtcRcvMthMail);
	tab.ContentObj.find("input[name=dcsNtcRcvmthTalk]").val(dataDtl.dcsNtcRcvMthTalk);
	tab.ContentObj.find("input[name=aplEmail]").val(dataDtl.aplEmailAddr);
	tab.ContentObj.find("input[name=aplDealInstcd]").val(dataDtl.aplDealInstCd);
	
	tab.ContentObj.find("input[name=aplMblPno]").val(dataDtl.aplMblPno);
	tab.ContentObj.find("input[name=aplPn]").val(dataDtl.aplPn);
	
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
	
	//비공개사유
	/*if(dataDtl.clsdRmk != null){
		tab.ContentObj.find("label[name=clsdRmk]").text(dataDtl.clsdRmk);
	}*/	
	
	//공개 또는 비공개 내용
	/*if(dataDtl.opbCn != null){
		tab.ContentObj.find("textarea[name=opb_clsd_cn]").val(dataDtl.opbCn);
	}*/	
	
	//통지서 수령유무
	if(dataDtl.objtnNtcsYn != null){
		tab.ContentObj.find("input:radio[name=objtnNtcsYn]:input[value="+dataDtl.objtnNtcsYn+"]").prop("checked", true);
	}	
	if(dataDtl.dcsNtcDt != null){ //결정통지서 받은날짜
		tab.ContentObj.find("input[name=dcsNtcDt]").val(dataDtl.dcsNtcDt);
	}	
	if(dataDtl.firstDcsDt != null){ //비공개결정일
		tab.ContentObj.find("input[name=firstDcsDt]").val(dataDtl.firstDcsDt);
	}	

	//이의신청의 취지 및 이유
	/*if(dataDtl.objtnRson != null){
		tab.ContentObj.find("textarea[name=objtn_rson]").val(dataDtl.objtnRson);
	}*/
		
	var fileHtml = "";
	//즉시처리 첨부
	if(dataDtl.objtnAplFlnm != null){
		fileHtml = "<a href=\"#\">";
		fileHtml += "<img src=\"/images/soportal/board/icon_file@2x.png\" class=\"board-icon\" alt=\"첨부파일\" style=\"width:20px;\">";
		fileHtml += "<span>"+dataDtl.objtnAplFlnm+"</span>";
		fileHtml += "</a>";
		var attchFlNm = dataDtl.objtnAplFlnm;
        
		tab.ContentObj.find("div[id=fileArea]").append(fileHtml);
		
		tab.ContentObj.find("div[id=fileArea] > a").bind("click", {
            param : "?fileNm=" + attchFlNm 
        }, function(event) {
            // 파일을 다운로드한다.
            downloadFile(event.data.param);
            return false;
        });
		
		tab.ContentObj.find("input[name=objtn_apl_flnm]").val(dataDtl.objtnAplFlnm);
		tab.ContentObj.find("input[name=objtn_apl_flph]").val(dataDtl.objtnAplFlph);
	}
	
	//달력
	formObj.find("input[name=dcsNtcDt]").datepicker(setCalendarFormat('yy-mm-dd'));
	formObj.find("input[name=firstDcsDt]").datepicker(setCalendarFormat('yy-mm-dd'));
	formObj.find("input[name=dcsNtcDt]").attr("readonly", true);
	formObj.find("input[name=firstDcsDt]").attr("readonly", true);
	dynamicTabButton(tab);		//탭 이벤트를 바인딩한다(동적생성 element들)
	
	//처리상태이력 보이게
	tab.ContentObj.find("div[name=opnzHist]").css("display", "block");
	
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
	
	
	//이의신청 대상
	var clsdHtml = "";
	clsdUseCnt = 0;
	$.each(clsdData, function(i, value) {
		clsdRsonCdTxt = "";
		objtnTxt = "-";
		
		if(value.clsdRsonCd == "01") clsdRsonCdTxt = "1호 법령상의 비밀, 비공개";
		if(value.clsdRsonCd == "02") clsdRsonCdTxt = "2호 국방등 국익침해";
		if(value.clsdRsonCd == "03") clsdRsonCdTxt = "3호 국민의 생명등 공익침해";
		if(value.clsdRsonCd == "04") clsdRsonCdTxt = "4호 재판관련 정보등";
		if(value.clsdRsonCd == "05") clsdRsonCdTxt = "5호 공정한 업무수행 지장 등";
		if(value.clsdRsonCd == "06") clsdRsonCdTxt = "6호 개인사생활 침해";
		if(value.clsdRsonCd == "07") clsdRsonCdTxt = "7호 법인 등 영업상 비밀침해";
		if(value.clsdRsonCd == "08") clsdRsonCdTxt = "8호 특정인의 이익,불이익";
		if(value.clsdRsonCd == "09") clsdRsonCdTxt = "기타(부존재등) : "+value.clsdRson;
		
		if(value.objtnYn == "Y") objtnTxt = value.objtnRegDttm.substring(0,4)+"-"+value.objtnRegDttm.substring(4,6)+"-"+value.objtnRegDttm.substring(6,8) + " 이의신청";
		
		clsdHtml += "<tr>";
		clsdHtml += 	"<td style=\"text-align:center;\">";
		if(value.objtnYn == "N"){
		clsdHtml +=        "<input type=\"checkbox\" name=\"clsdChk\" value=\""+value.clsdNo+"\">";
		clsdUseCnt++;
		}
		clsdHtml +=     "</td>";
		clsdHtml += 	"<td>"+value.clsdRmk+"</td>";
		clsdHtml += 	"<td>"+clsdRsonCdTxt+"</td>";
		clsdHtml += 	"<td style=\"text-align:center;\">"+objtnTxt+"</td>";
		clsdHtml += "</tr>";
	});
	tab.ContentObj.find("table[name=clsdList]").append(clsdHtml);
	if(clsdUseCnt == 0) tab.ContentObj.find("div[name=clsdArea]").html("<font color='red'>이의신청 대상이 없습니다.(이미 비공개 목록에 대한 이의신청이 완료)</font>");
		
	tab.ContentObj.find('input:checkbox[name="clsdChk"]').on('click', function() {
		var objtnHtml = "";
		var clickVal = $(this).val();
		if($(this).is(":checked")){
			if(tab.ContentObj.find("div[name=clsdArea]").text() == "이의신청 대상을 선택하세요."){
				tab.ContentObj.find("div[name=clsdArea]").empty();
			}
			
			var  clsdRsonCdTxt = "";
			var clsdRmk = "";
			$.each(clsdData, function(x, cls) {
				if(clickVal == cls.clsdNo){
					if(cls.clsdRsonCd == "01") clsdRsonCdTxt = "1호 법령상의 비밀, 비공개";
					if(cls.clsdRsonCd == "02") clsdRsonCdTxt = "2호 국방등 국익침해";
					if(cls.clsdRsonCd == "03") clsdRsonCdTxt = "3호 국민의 생명등 공익침해";
					if(cls.clsdRsonCd == "04") clsdRsonCdTxt = "4호 재판관련 정보등";
					if(cls.clsdRsonCd == "05") clsdRsonCdTxt = "5호 공정한 업무수행 지장 등";
					if(cls.clsdRsonCd == "06") clsdRsonCdTxt = "6호 개인사생활 침해";
					if(cls.clsdRsonCd == "07") clsdRsonCdTxt = "7호 법인 등 영업상 비밀침해";
					if(cls.clsdRsonCd == "08") clsdRsonCdTxt = "8호 특정인의 이익,불이익";
					if(cls.clsdRsonCd == "09") clsdRsonCdTxt = "기타(부존재등) : "+cls.clsdRson;
					
					clsdRmk = cls.clsdRmk;
				}
			});
			
			objtnHtml += '<label name="clsd'+clickVal+'">';
			objtnHtml += '<input type="hidden" name="clsd_no" value="'+clickVal+'">';
			objtnHtml += '<table class="list02" style="width:800px;">';
			objtnHtml +=   '<colgroup>';
			objtnHtml +=   '<col style="width:100px;">';
			objtnHtml +=   '<col style="width:600px;">';
			objtnHtml +=   '</colgroup>';
			objtnHtml +=   '<tbody name="privateInfo">';
			objtnHtml +=   '<tr>';
			objtnHtml +=     '<td style="background:#FFFFD7;font-weight: bold;">비공개 내용</td>';
			objtnHtml +=     '<td>';
			objtnHtml +=       '<input type="text" name="clsd_rmk" size="90" value="'+clsdRmk+'" style="border-color:#C4B747;background:#F3F3F3;" readonly=readonly/>';
			objtnHtml +=     '</td>';
			objtnHtml +=   '</tr>';
			objtnHtml +=   '<tr>';
			objtnHtml +=     '<td style="background:#FFFFD7;font-weight: bold;">비공개 사유</td><td>';
			objtnHtml +=       '<input type="text" name="clsd_rson" size="90" value="'+clsdRsonCdTxt+'" style="border-color:#C4B747;background:#F3F3F3;" readonly=readonly/>';
			objtnHtml +=     '</td>';
			objtnHtml +=   '</tr>';
			objtnHtml +=   '<tr>';
			objtnHtml +=     '<td style="background:#FFFFD7;font-weight: bold;">이의신청의<br/>취지 및 이유</td>';
			objtnHtml +=     '<td>';
			objtnHtml +=       '<textarea name="objtn_rson" rows="3" cols="100" style="border-color:#C4B747;"></textarea><br />';
			objtnHtml +=       '<span class="byte_r"><input type="text" name="len2" style="width:30px; text-align:right;border: none;margin-bottom:3px;padding:1px;" value="0" readonly>/500 Byte</span>';
			objtnHtml +=     '</td>';
			objtnHtml +=   '</tr>';
			objtnHtml +=   '</tbody>';
			objtnHtml += '</table>';
			objtnHtml += '</label>';
			
			tab.ContentObj.find("div[name=clsdArea]").append(objtnHtml);
			
			//이의신청의 취지 및 이유
			formObj.find("label[name=clsd"+clickVal+"]").find("textarea[name=objtn_rson]").bind("keyup", function(event) {
				var obj = formObj.find("label[name=clsd"+clickVal+"]").find("textarea[name=objtn_rson]");
				textAreaLabelLenChk(obj, 'clsd'+clickVal, 'len2', 500);
			});
		}else{
			tab.ContentObj.find("label[name=clsd"+$(this).val()+"]").remove();
			
			if(tab.ContentObj.find("div[name=clsdArea]").text() == "") tab.ContentObj.find("div[name=clsdArea]").text("이의신청 대상을 선택하세요.")
		}
	 });
	
	
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
}

//상세 탭 이벤트
function tabEvent(row){//탭 이벤트 실행  
	var title = sheet.GetCellValue(row, "aplSj");//탭 제목
	var id = sheet.GetCellValue(row, "aplNo");//탭 id
		
	openTab.SetTabData(sheet.GetRowJson(row));//db data 조회시 조건 data
	var url =  com.wise.help.url('/admin/expose/writeOpnObjtn.do'); // Controller 호출 url
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
	gridTitle +="|신청번호";
	gridTitle +="|청구일자";
	gridTitle +="|청구제목";
	gridTitle +="|청구인";
	gridTitle +="|청구기관코드";
	gridTitle +="|청구기관";
	gridTitle +="|처리기관코드";
	gridTitle +="|처리기관";
	gridTitle +="|이의신청대상";
	gridTitle +="|이의신청대상";
	gridTitle +="|결정통지일자";
	
	var gridTitle1 ="번호";
	gridTitle1 +="|신청번호";
	gridTitle1 +="|청구일자";
	gridTitle1 +="|청구제목";
	gridTitle1 +="|청구인";
	gridTitle1 +="|청구기관코드";
	gridTitle1 +="|청구기관";
	gridTitle1 +="|처리기관코드";
	gridTitle1 +="|처리기관";
	gridTitle1 +="|비공개 건수";
	gridTitle1 +="|이의신청 건수";
	gridTitle1 +="|결정통지일자";

	with(sheet){
		                     
		var cfg = {SearchMode:3,Page:50,VScrollMode:1,MergeSheet :7}; //MergeSheet :7
	    SetConfig(cfg);
	    var headers = [
	                {Text:gridTitle, Align:"Center"},{Text:gridTitle1, Align:"Center"}
	            ];
	    var headerInfo = {Sort:0,ColMove:0,ColResize:1,HeaderCheck:1};
	    
	    InitHeaders(headers, headerInfo);
	   
	    var cols = [
	                 {Type:"Seq",		SaveName:"seq",			   		Width:30,	Align:"Center",		Edit:false}
	                ,{Type:"Text",	    SaveName:"aplNo",		    	Width:30,	Align:"Center",		Edit:false,	Hidden:true}
					,{Type:"Text",		SaveName:"aplDt",	        	Width:50,	Align:"Center",		Edit:false, Format:"Ymd"}
					,{Type:"Text",		SaveName:"aplSj",		    	Width:200,	Align:"Left",			Edit:false}
					,{Type:"Text",		SaveName:"aplPn",		    	Width:50,	Align:"Center",		Edit:false}
					,{Type:"Text",		SaveName:"aplInstCd",	    	Width:90,	Align:"Center",		Edit:false,	Hidden:true}
					,{Type:"Text",		SaveName:"aplInstNm",	    	Width:90,	Align:"Center",		Edit:false}
					,{Type:"Text",		SaveName:"aplDealInstCd",	Width:90,	Align:"Center",		Edit:false,	Hidden:true}
					,{Type:"Text",		SaveName:"aplDealInstNm",	Width:90,	Align:"Center",		Edit:false}
					,{Type:"Text",		SaveName:"clsdCnt",				Width:50,	Align:"Center",		Edit:false}
					,{Type:"Text",		SaveName:"objtnCnt",			Width:50,	Align:"Center",		Edit:false}
					,{Type:"Text",		SaveName:"dcsNtcDt",	    	Width:50,	Align:"Center",		Edit:false, Format:"Ymd"}
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
	
	formObj.find("a[name=btnInsert]").bind("click", function(event) {
		// 등록
		doAction("insert");
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
	
	formObj.find("a[name=btnApplyDetail]").bind("click", function(event) {
		// 청구상세
		fn_directPage();
    });	
	
	
	
	//공개 또는 비공개 내용
	/*formObj.find("textarea[name=opb_clsd_cn]").bind("keyup", function(event) {
		var obj = formObj.find("textarea[name=opb_clsd_cn]");
		textAreaLenChk(obj, 'len1', 500);
	});*/
	
	//이의신청의 취지 및 이유
	/*formObj.find("textarea[name=objtn_rson]").bind("keyup", function(event) {
		var obj = formObj.find("textarea[name=objtn_rson]");
		textAreaLenChk(obj, 'len2', 500);
	});*/
}

/**
 * 탭 이벤트를 바인딩한다.
 */
function dynamicTabButton(tab){
	//var obj = tab.ContentObj.find("textarea[name=opb_clsd_cn]");
	//var obj1 = tab.ContentObj.find("textarea[name=objtn_rson]");
	
	//textAreaLenChk(obj, 'len1', 500);
	//textAreaLenChk(obj1, 'len2', 500);
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
	
	if(clsdUseCnt == 0){
		alert("이의신청 대상이 없습니다.");
		return false;
	}
	
	/* 이의신청의 취지 및 이유 확인 시작 (START) */
	var cnt = 0;
	var eqIdx = "";
	var isDataChk = false;
	formObj.find("textarea[name=objtn_rson]").each(function() {
		if(!isDataChk && com.wise.util.isNull($(this).val())){
			eqIdx = cnt;
			isDataChk = true;
		}
		cnt++;
	});
	if(cnt == 0){
		alert("이의신청 대상을 선택해주세요.");
		return false;
	}
	if(isDataChk){ //이의신청의 취지 및 이유 내용이 없는게 있을 경우
		alert("이의신청의 취지 및 이유를 입력해주세요.");
		formObj.find("textarea[name=objtn_rson]").eq(eqIdx).focus();
		return false;
	}
	/* 이의신청의 취지 및 이유 확인 종료 (END) */
	
	
	//즉시처리가 아닐 경우..
	if ( formObj.find("input[name=objtnNtcsYn]").is(":checked") == false ) {
		alert("통지서 수령유무를 선택해주세요.");
		return false;
	}
	
	//첨부문서
	if (!com.wise.util.isNull(formObj.find("input[name=file]").val())  ) {
		var chk = fn_checkFile(formObj.find("input[name=file]").val());
		if(chk){
			alert("해당 파일은 등록할 수 없습니다.");
			return false;
		}
		formObj.find("input[name=objtnLength]").val("1");
	}
		
	return true;
}

////////////////////////////////////////////////////////////////////////////////
//기타 함수
////////////////////////////////////////////////////////////////////////////////

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

//달력관련 함수
function datePickerInit() {
	var objTab = getTabShowObj();//탭이 oepn된 객체가져옴
	var formObj = objTab.find("form[name=statMainForm]");
	
	formObj.find("input[name=aplDtFrom],   input[name=aplDtTo]").datepicker(setCalendarFormat('yymmdd'));
	
	datepickerTrigger(); 
	// 시작-종료 일자보다 이전으로 못가게 세팅
	formObj.find('input[name=aplDtFrom]').datepicker('option', 'onClose',  function( selectedDate ) {$("input[name=aplDtTo]").datepicker( "option", "minDate", selectedDate );});
	formObj.find('input[name=aplDtTo]').datepicker('option', 'onClose',  function( selectedDate ) {	$("input[name=aplDtFrom]").datepicker( "option", "maxDate", selectedDate );});
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

function trim(str){
   str = str.replace(/(^\s*)|(\s*$)/g, "");
   return str;
}

//파일을 다운로드 한다.
function downloadFile(params) {
	var objTab = getTabShowObj();//탭이 oepn된 객체가져옴
	var formObj = objTab.find("form[name=detail-form]");
	
	formObj.find("iframe[id=download-frame]").attr("src", com.wise.help.url("/admin/expose/downloadOpnAplFile.do") + params);
}

//선택파일 지우기
function fn_pathDelete1(elementName){
	var objTab = getTabShowObj();//탭이 oepn된 객체가져옴
	var formObj = objTab.find("form[name=detail-form]");

	formObj.find("input[name="+elementName+"]").val("");
	/*
	if($.browser.msie){    //IE version
		formObj.find("input[name="+elementName+"]").replaceWith( formObj.find("input[name="+elementName+"]").clone(true) );
	}else{    //other browser
		formObj.find("input[name="+elementName+"]").val("");
	}*/
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