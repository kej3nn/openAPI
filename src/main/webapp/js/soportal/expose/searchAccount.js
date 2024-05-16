/*
 * @(#)searchAccount.js 1.0 2019/07/22
 * 
 * COPYRIGHT (C) 2013 WISEITECH CO., LTD. ALL RIGHTS RESERVED.
 */

/**
 * 정보공개 > 청구서처리현황 스크립트이다.
 *
 * @author SoftOn
 * @version 1.0 2018/04/19
 */
$(function() {
    // 컴포넌트를 초기화한다.
    initComp();
    
    // 이벤트를 바인딩한다.
    bindEvent();
    
    // 데이터를 로드한다.
    loadData();
});

////////////////////////////////////////////////////////////////////////////////
// 글로벌 변수
////////////////////////////////////////////////////////////////////////////////
/**
 * 템플릿
 */
var templates = {
    data:
        "<tr>"                                                                               							+
            "<td><span class=\"mq_tablet rowNum\"></span></td>"                              	+
            "<td><span class=\"aplDt\"></span></td>"                                 	+
            "<td class=\"area_tit\">"                                                        					+
                "<a href=\"#\" class=\"link tit ellipsis w_400 aplSj\"></a>"                			+
                "<strong class=\"btn_detail mq_mobile\"><a href=\"#\">상세보기</a></strong>"	+
            "</td>"                                                                          							+
            "<td><span class=\"aplInstNm\"></span></td>"                              	+
            "<td><span class=\"mq_tablet aplDealInstNm\"></span></td>"                 		+
            "<td><span class=\"prgStatNm\"></span></td>"                             	+
            "<td><span class=\"opbYnNm\"></span></td>"                             	+
            "<td><span class=\"mq_tablet prgStatCd\"></span></td>"                             	+
        "</tr>",
    none:
        "<tr>"                                                              											+
            "<td colspan=\"8\" class=\"noData\">청구서 자료가 없습니다.</td>" 							+
        "</tr>"
};

////////////////////////////////////////////////////////////////////////////////
// 초기화 함수
////////////////////////////////////////////////////////////////////////////////
var accountData = new Array();
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
	
	$("input[name=s_aplDtFrom], input[name=s_aplDtTo]").datepicker(com.wise.help.datepicker({
        buttonImage:com.wise.help.url("/images/admin/icon_calendar.png")
    }));
	//$("input[name=s_aplDtFrom], input[name=s_aplDtTo]").attr("readonly", true);
	$('input[name=s_aplDtFrom]').datepicker('option', 'onClose',  function( selectedDate ) {$("input[name=s_aplDtTo]").datepicker( "option", "minDate", selectedDate );});
	$('input[name=s_aplDtTo]').datepicker('option', 'onClose',  function( selectedDate ) {	$("input[name=s_aplDtFrom]").datepicker( "option", "maxDate", selectedDate );});
	
	fn_DefaultSelected('s_aplInst', 'h_aplInst');
	fn_DefaultSelected('s_prgState', 'h_prgState');
}

/**
 * 데이터를 로드한다.
 */
function loadData() {
	searchDataList($("#pForm [name=page]").val());
}

////////////////////////////////////////////////////////////////////////////////
// 서비스 함수
////////////////////////////////////////////////////////////////////////////////
/**
 * 데이터를 검색한다.
 * 
 * @param page {String} 페이지 번호
 */
function searchDataList(page) {
	
    // 데이터를 검색한다.
    doSearch({
        url:"/portal/expose/searchAccount.do",
        page:page ? page : "1",
        before:beforeSearchDataList,
        after:afterSearchDataList,
        pager:"pager-sect",
        counter:{
            count:"count-sect",
            pages:"pages-sect"
        }
    });
}

/**
 * 선택제목의 상세내용을 조회한다.
 * 
 * @param data {Object} 데이터  
 */
function selectDetailPage(data) {
	
	var frm = document.form;
	frm.apl_no.value = data.aplNo;
	
	var goUrl = "";
	if(data.prgStatCd=='01') goUrl = "/portal/expose/writeAccountPage.do"
	else goUrl = "/portal/expose/selectAccountPage.do"
	
    // 데이터를 조회하는 화면으로 이동한다.
    goSelect({
        url:goUrl,
        form:"form",
        data:[{name:"aplNo", value:data.aplNo},
              {name:"prgStatCd",value:data.prgStatCd}]
    });
}

////////////////////////////////////////////////////////////////////////////////
// 전처리 함수
////////////////////////////////////////////////////////////////////////////////
/**
 *  내용 검색 전처리를 실행한다.
 * 
 * @param options {Object} 옵션
 * @returns {Object} 데이터
 */
function beforeSearchDataList(options) {
    var data = {};
    var form = $("#pForm");
    
    if (com.wise.util.isBlank(options.page)) {
        form.find("[name=page]").val("1");
    }
    else {
        form.find("[name=page]").val(options.page);
    }
    
    $.each(form.serializeArray(), function(index, element) {
    	data[element.name] = element.value;
    });

    return data;
}

////////////////////////////////////////////////////////////////////////////////
// 후처리 함수
////////////////////////////////////////////////////////////////////////////////
/**
 * 내용 검색 후처리를 실행한다.
 * 
 * @param data {Array} 데이터
 */
function afterSearchDataList(data) {
    var table = $("#data-table");
    accountData = data;
    
    //세션이 중간에 끊어졌을 경우 실명인증 화면 재호출한다.
    if(data == "Login is required"){
    	location.href = "/portal/expose/opnLoginPage.do";
    	return false;
    }
    
    table.find("tr").each(function(index, element) {
        if (index > 0) {
            $(this).remove();
        }
    });
    
    for (var i = 0; i < data.length; i++) {
        var row = $(templates.data);

        row.find(".rowNum").text(getRowNumber($("#count-sect").text(), "" + data[i].rowNum));
        
        row.find(".aplSj").text(data[i].aplSj);
        
        var aplDt = data[i].aplDt;
        if(data[i].aplDt.length == 8) aplDt = data[i].aplDt.substring(0,4)+"-"+data[i].aplDt.substring(4,6)+"-"+data[i].aplDt.substring(6,8);
        
        row.find(".aplDt").text(aplDt);
        row.find(".aplDealInstNm").text(data[i].aplDealInstNm);
        row.find(".aplInstNm").text(data[i].aplInstNm);
        
        var prgStatCd = data[i].prgStatCd;
        var prgStatNm = data[i].prgStatNm;
        if(data[i].imdDealDiv == "1"){
        	row.find(".prgStatNm").text("즉시처리");
        }else{
            if(data[i].prgStatCd == "08"){
            	var prgStatNmArray = prgStatNm.split("(");
            	row.find(".prgStatNm").text(prgStatNmArray[0]);
            }else{
            	row.find(".prgStatNm").text(prgStatNm);
            }
        }
        row.find(".opbYnNm").text(data[i].opbYnNm);
        
        if(data[i].prgStatCd == "04" || data[i].prgStatCd == "08"){
            if(data[i].opbYn == "3"){
            	row.find(".prgStatCd").html("<img src=\"../../images/soportal/expose/icon_print.gif\" onclick=\"fn_NonPrint('"+data[i].aplNo+"', '"+data[i].callVersion+"');\" style='cursor:pointer;'/>");
            }else if(data[i].opbYn == "0" || data[i].opbYn == "1" || data[i].opbYn == "2"){
            	row.find(".prgStatCd").html("<img src=\"../../images/soportal/expose/icon_print.gif\" onclick=\"fn_infoPrint('"+data[i].aplNo+"', '"+data[i].imdDealDiv+"', '"+data[i].callVersion+"');\" style='cursor:pointer;'/>");
            }
        }else if(data[i].prgStatCd == "11"){
        	row.find(".prgStatCd").html("<img src=\"../../images/soportal/expose/icon_print.gif\" onclick=\"fn_TrsfPrint('"+data[i].aplNo+"', '"+data[i].callVersion+"');\" style='cursor:pointer;'/>");
        }

        row.find(".tit, .btn_detail").each(function(index, element) {
            //  제목 링크에 클릭 이벤트를 바인딩한다.
            $(this).bind("click", {
            	aplNo:data[i].aplNo,
            	prgStatCd:data[i].prgStatCd
            }, function(event) {
                // 내용을 조회한다.
            	selectDetailPage(event.data);
                return false;
            });
            
            //  제목 링크에 키다운 이벤트를 바인딩한다.
            $(this).bind("keydown", {
            	aplNo:data[i].aplNo,
            	prgStatCd:data[i].prgStatCd
            }, function(event) {
                if (event.which == 13) {
                    // 내용을 조회한다.
                	selectDetailPage(event.data);
                    return false;
                }
            });
        });
        
        table.append(row);
    }
    
    if (data.length == 0) {
        var row = $(templates.none);
        
        table.append(row);
    }
}

////////////////////////////////////////////////////////////////////////////////
// 검색
////////////////////////////////////////////////////////////////////////////////
function fn_goSearch(){
	var frm = document.form;
	var frm1 = document.pForm;

	frm1.aplInst.value = frm.s_aplInst.value;
	frm1.prgState.value = frm.s_prgState.value;
	frm1.aplDtFrom.value = frm.s_aplDtFrom.value;
	frm1.aplDtTo.value = frm.s_aplDtTo.value;
	frm1.opbYn.value = frm.s_opbYn.value;
	frm1.aplSj.value = frm.s_aplSj.value;

	if(frm.imd_deal_div.checked == true) {
		frm1.imd_deal_div.value = "1";
	} else {
		frm1.imd_deal_div.value = "";
	}
	
	//============================================
	// 조회시날짜 입력이 안되어 있을면, 현재 날짜로 자동 세팅한다.
	var date = new Date();
	var year = date.getFullYear()+'';
	var month = (date.getMonth()+1)+'';
	var day = date.getDate()+'';
	if(month.length == 1) month = '0'+month;
	if(day.length == 1) day = '0'+day;
	
	var sysdate = year + "-" + month + "-" + day;
	
	if(!frm.s_aplDtFrom.value == '') {
		if(frm.s_aplDtTo.value == '') frm.s_aplDtTo.value = sysdate;
	}
	//============================================
	
	searchDataList($("#pForm [name=page]").val());
}

function fn_subElement(){
	var frm = document.form;
	
	if(frm.s_prgState.value == '04') {	// 결정통지를 선택했을경우
		subElement.style.display = 'block';
	} else {
		subElement.style.display = 'none';
		$("#imd_deal_div").removeAttr("checked");	// 즉시처리건 조회 기본 체크 해제
	}
}

////////////////////////////////////////////////////////////////////////////////
//출력
////////////////////////////////////////////////////////////////////////////////
function fn_infoPrint(aplNo, pDiv, cVersion){
	var frm = document.printForm;

	if(cVersion == 'V1'){	//2단계 개선사업 이전일 경우 이전 통지서를 호출한다.
		frm.action = "/portal/expose/reportingPage/printOpndcs.do";
	}else{	//2단계 개선사업 이후일 경우 신규 통지서를 호출한다.
	    for (var i = 0; i < accountData.length; i++) { //청구정보내용 확인을 위해 추가
	    	if(accountData[i].aplNo == aplNo){
	    		$("#form").find("textarea[name=printAplDtsCn]").val(accountData[i].aplDtsCn); //청구정보내용
	    		$("#form").find("textarea[name=printClsdRmk]").val(accountData[i].newClsdRmk); //비공개사유
	    	}
	    }    

		/* 청구내용 확인 로직 추가 > 결정통지서의 정보공개청구내용에 맞지 않을 경우(초과) 별지참조 처리*/
		var tArea = $("#form").find("textarea[name=printAplDtsCn]").val();  //청구내용 - 출력용
		var totLine = chkTotLine(tArea);
		/* 비공개 내용 및 사유 확인 로직 추가 > 결정통지서의 비공개 내용 및 사유에 맞지 않을 경우(초과) 별지참조 처리*/
		var tClsdArea = $("#form").find("textarea[name=printClsdRmk]").val(); //비공개사유 - 출력용
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
	
	window.open("","popup","width=680, height=700, resizable=yes, location=no;");
	document.form.apl_no.value = aplNo;
	frm.width.value = "680";
	frm.height.value = "700";
	frm.mrdParam.value =  "/rp ["+document.form.apl_no.value+"]";
	if(pDiv == '1') {
		frm.title.value = "정보공개 즉시처리 출력";
	} else {
		frm.title.value = "정보공개 결정통지서 출력";
	}
	frm.target = "popup";
	frm.submit();
}

function fn_NonPrint(aplNo, cVersion){
	var frm = document.printForm;
	
	if(cVersion == 'V1'){	//2단계 개선사업 이전일 경우 이전 통지서를 호출한다.
		frm.action = "/portal/expose/reportingPage/printNonext.do";
	}else{	//2단계 개선사업 이후일 경우 신규 통지서를 호출한다.
	    for (var i = 0; i < accountData.length; i++) { //청구정보내용 확인을 위해 추가
	    	if(accountData[i].aplNo == aplNo){
	    		$("#form").find("textarea[name=printAplDtsCn]").val(accountData[i].aplDtsCn); //청구정보내용
	    	}
	    }    

	    /* 청구내용 확인 로직 추가 > 정보 부존재 등 통지서의 정보공개청구내용에 맞지 않을 경우(초과) 별지참조 처리*/
	    var tArea = $("#form").find("textarea[name=printAplDtsCn]").val(); //청구내용 - 출력용
	    var totLine = chkTotLine(tArea);
	    if(totLine > 11){ //정보 부존재 등 통지서의 정보공개청구내용은 최대 11줄
	    	frm.action = "/portal/expose/reportingPage/printNewNonextRefer.do";
	    }else{
	    	frm.action = "/portal/expose/reportingPage/printNewNonext.do";
	    }
	}
    
	window.open("","popup","width=680, height=700, resizable=yes, location=no;");
	document.form.apl_no.value = aplNo;
	frm.width.value = "680";
	frm.height.value = "700";
	frm.mrdParam.value =  "/rp ["+document.form.apl_no.value+"]";
	frm.title.value = "부존재 등 통지서 출력";
	frm.target = "popup";
	frm.submit();
}

function fn_TrsfPrint(aplNo, cVersion){
	var frm = document.printForm;
	
	if(cVersion == 'V1'){	//2단계 개선사업 이전일 경우 이전 통지서를 호출한다.
		frm.action = "/portal/expose/reportingPage/printOpntrn.do";
	}else{	//2단계 개선사업 이후일 경우 신규 통지서를 호출한다.
	    for (var i = 0; i < accountData.length; i++) { //청구정보내용 확인을 위해 추가
	    	if(accountData[i].aplNo == aplNo){
	    		$("#form").find("textarea[name=printAplDtsCn]").val(accountData[i].aplDtsCn); //청구정보내용
	    	}
	    }    

	    /* 청구내용 확인 로직 추가 > 정보공개 청구서 기관이송 통지서의 청구정보내용에 맞지 않을 경우(초과) 별지참조 처리*/
	    var tArea = $("#form").find("textarea[name=printAplDtsCn]").val(); //청구내용 - 출력용
	    var totLine = chkTotLine(tArea);
	    if(totLine > 9){ //정보공개 청구서 기관이송 통지서의 청구정보내용은 최대 9줄
	    	frm.action = "/portal/expose/reportingPage/printNewOpntrnRefer.do";
	    }else{
	    	frm.action = "/portal/expose/reportingPage/printNewOpntrn.do";
	    }
	}
	
	window.open("","popup","width=680, height=700, resizable=yes, location=no;");
	document.form.apl_no.value = aplNo;
	frm.width.value = "680";
	frm.height.value = "700";
	frm.mrdParam.value =  "/rp ["+document.form.apl_no.value+"]";
	frm.title.value = "이송통지서 출력";
	frm.target = "popup";
	frm.submit();
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

