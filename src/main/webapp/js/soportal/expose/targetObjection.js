/*
 * @(#)targetObjection.js 1.0 2019/07/22
 * 
 * COPYRIGHT (C) 2013 WISEITECH CO., LTD. ALL RIGHTS RESERVED.
 */

/**
 * 정보공개 > 이의신청서 대상 스크립트이다.
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
        "<tr>"                                                                               +
            "<td><span class=\"mq_tablet rowNum\"></span></td>"                              +
            "<td><span class=\"aplDt\"></span></td>"                                 +
            "<td class=\"area_tit\">"                                                        +
                "<a href=\"#\" class=\"link tit ellipsis w_400 aplSj\"></a>"                +
                "<strong class=\"btn_detail mq_mobile\"><a href=\"#\">상세보기</a></strong>" +
            "</td>"                                                                          +
            "<td><span class=\"aplInstNm\"></span></td>"                                 +
            "<td><span class=\"aplDealInstNm\"></span></td>"                 +
            "<td>" +
            "<div>" +
            "<span class=\"title_dcsNtcDt\">결정통지일자</span>" +
            "<span class=\"dcsNtcDt\"></span></td>"                             +
            "</div>"                             +
        "</tr>",
    none:
        "<tr>"                                                              +
            "<td colspan=\"6\" class=\"noData\">이의신청 대상 자료가 없습니다.</td>" +
        "</tr>"
};

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
	$("input[name=s_aplDtFrom], input[name=s_aplDtTo]").datepicker(com.wise.help.datepicker({
        buttonImage:com.wise.help.url("/images/admin/icon_calendar.png")
    }));
	//$("input[name=s_aplDtFrom], input[name=s_aplDtTo]").attr("readonly", true);
	$('input[name=s_aplDtFrom]').datepicker('option', 'onClose',  function( selectedDate ) {$("input[name=s_aplDtTo]").datepicker( "option", "minDate", selectedDate );});
	$('input[name=s_aplDtTo]').datepicker('option', 'onClose',  function( selectedDate ) {	$("input[name=s_aplDtFrom]").datepicker( "option", "maxDate", selectedDate );});

	//파일첨부 관련
	$("input[type=file]").change(function(){
		if($(this).val() != ""){
			//확장자 체크
			var ext = $(this).val().split(".").pop().toLowerCase();
			if($.inArray(ext, ["txt", "hwp", "doc", "docx", "xls", "xlsx", "ppt", "pptx", "pdf", "zip", "rar"]) == -1){
				alert("등록이 불가능한 파일입니다.\n\n파일을 다시 선택하시기 바랍니다.");
				$(this).val("");
				return;
			}
			//용량체크
			var fileSize = this.files[0].size;
			var maxSize = 10*1024*1000;
			if(fileSize > maxSize){
				alert("등록이 불가능한 파일입니다.\n\n파일을 다시 선택하시기 바랍니다.");
				$(this).val("");
				return;
			}
		}
	});
}

/**
 * 데이터를 로드한다.
 */
function loadData() {
	searchDataList($("#tgo-search-form [name=page]").val());
}

////////////////////////////////////////////////////////////////////////////////
// 서비스 함수
////////////////////////////////////////////////////////////////////////////////
/**
 * 이의신청 대상을 검색한다.
 * 
 * @param page {String} 페이지 번호
 */
function searchDataList(page) {
	
    // 데이터를 검색한다.
    doSearch({
        url:"/portal/expose/targetObjection.do",
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
 * 이의신청서 작성 화면을 호출한다.
 * 
 * @param data {Object} 데이터
 */
function selectObjection(data) {

    var statNo = data.prgStatCd;
	var frm = document.form;
	frm.apl_no.value = data.aplNo;
	
	var goUrl = "/portal/expose/writeObjectionPage.do";
	
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

        row.find(".rowNum").text(getRowNumber($("#acc-count-sect").text(), "" + data[i].rowNum));
        
        row.find(".aplSj").text(data[i].aplSj);
        
        var aplDt = data[i].aplDt;
        if(data[i].aplDt.length == 8) aplDt = data[i].aplDt.substring(0,4)+"-"+data[i].aplDt.substring(4,6)+"-"+data[i].aplDt.substring(6,8);
        
        row.find(".aplDt").text(aplDt);
        row.find(".aplDealInstNm").text(data[i].aplDealInstNm);
        row.find(".aplInstNm").text(data[i].aplInstNm);
        
        var dcsNtcDt = data[i].dcsNtcDt;
        if(data[i].dcsNtcDt.length == 8) aplDt = data[i].dcsNtcDt.substring(0,4)+"-"+data[i].dcsNtcDt.substring(4,6)+"-"+data[i].dcsNtcDt.substring(6,8);
        row.find(".dcsNtcDt").text(dcsNtcDt);
        
        row.find("a").each(function(index, element) {
            // 이의신청서 대상 제목 링크에 클릭 이벤트를 바인딩한다.
            $(this).bind("click", {
            	aplNo:data[i].aplNo,
            	prgStatCd:data[i].prgStatCd
            }, function(event) {
                // 이의신청서 작성 화면을 호출한다.
                selectObjection(event.data);
                return false;
            });
            
            // 이의신청서 대상 제목 링크에 키다운 이벤트를 바인딩한다.
            $(this).bind("keydown", {
            	aplNo:data[i].aplNo,
            	prgStatCd:data[i].prgStatCd
            }, function(event) {
                if (event.which == 13) {
                	// 이의신청서 작성 화면을 호출한다.
                	selectObjection(event.data);
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
//기존 JS 함수
////////////////////////////////////////////////////////////////////////////////
function fn_goSearch(){
	var frm = document.form;
	var frm1 = document.pForm;

	frm1.aplInst.value = frm.s_aplInst.value;
	frm1.aplDtFrom.value = frm.s_aplDtFrom.value;
	frm1.aplDtTo.value = frm.s_aplDtTo.value;

	//==================================================================
	// 조회시 s_aplDtTo 날짜 입력이 안돼어있을시. 현재 날짜로 자동 셋팅
	var date = new Date();
	var year = date.getYear()+'';
	var month = (date.getMonth()+1)+'';
	var day = date.getDate()+'';
	if(month.length == 1){
		month = '0'+month;
	} 
	if(day.length == 1){
		day = '0'+day;
	} 
	var sysdate = year + "-" + month + "-" + day;
	

	if(!frm.s_aplDtFrom.value == '') {
		if(frm.s_aplDtTo.value == '') {
			frm1.aplDtTo.value = sysdate;
		} else {
			frm1.aplDtTo.value = frm.s_aplDtTo.value;			
		}
	}
	//==================================================================

	searchDataList($("#pForm [name=page]").val());
}

////////////////////////////////////////////////////////////////////////////////
//출력
////////////////////////////////////////////////////////////////////////////////
function fn_infoPrint(aplNo, pDiv){
	var frm = document.printForm;
	
	window.open("","popup","width=680, height=700");
	document.form.apl_no.value = aplNo;

	frm.width.value = "680";
	frm.height.value = "700";
	
	frm.mrdParam.value =  "/rp ['"+document.form.apl_no.value+"']";

	if(pDiv == '1') {
		frm.title.value = "정보공개 즉시처리 출력";
		frm.action = "/opn/printOpndcs.do?print=dcs2";
	} else {
		frm.title.value = "정보공개 결정통지서 출력";
		frm.action = "/opn/printOpndcs.do";
	}
	
	frm.target = "popup";
	frm.submit();
}

function fn_NonPrint(aplNo){
	
	var frm = document.printForm;
	
	window.open("","popup","width=680, height=700");
	document.form.apl_no.value = aplNo;

	frm.width.value = "680";
	frm.height.value = "700";
	
	frm.mrdParam.value =  "/rp ['"+document.form.apl_no.value+"']";

	frm.title.value = "부존재 등 통지서 출력";
	frm.action = "/opn/printNonext.do?width=680&height=700&mrdParam=/rp [" + document.form.apl_no.value + "] [1]";

	frm.target = "popup";
	frm.submit();
}

function fn_TrsfPrint(aplNo){
	
	var frm = document.printForm;
	
	window.open("","popup","width=680, height=700");
	document.form.apl_no.value = aplNo;

	frm.width.value = "680";
	frm.height.value = "700";
	
	frm.mrdParam.value =  "/rp ['"+document.form.apl_no.value+"']";

	frm.title.value = "이송통지서 출력";
	frm.action = "/opn/printOpntrn.do";
	
	frm.target = "popup";
	frm.submit();
}
