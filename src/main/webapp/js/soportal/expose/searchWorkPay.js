/*
 * @(#)searchObjection.js 1.0 2019/07/22
 * 
 * COPYRIGHT (C) 2013 WISEITECH CO., LTD. ALL RIGHTS RESERVED.
 */

/**
 * 정보공개 > 이의신청서 처리현황 스크립트이다.
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
            "<td><span class=\"objtnDt\"></span></td>"                                 +
            "<td class=\"area_tit\">"                                                        					+
                "<a href=\"#\" class=\"link tit ellipsis w_400 aplSj\"></a>"                			+
                "<strong class=\"btn_detail mq_mobile\"><a href=\"#\">상세보기</a></strong>"	+
            "</td>"                                                                          							+
            "<td><span class=\"aplDealInstNm\"></span></td>"                        	+
            "<td><span class=\"mq_tablet aplDt\"></span></td>"                 					+
            "<td><span class=\"objtnStatCD\"></span></td>"                         	+
        "</tr>",
    none:
        "<tr>"                                                              											+
            "<td colspan=\"6\" class=\"noData\">이의신청서 처리현황 자료가 없습니다.</td>" 			+
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

	$("input[name=aplDtFrom], input[name=aplDtTo]").datepicker(com.wise.help.datepicker({
        buttonImage:com.wise.help.url("/images/admin/icon_calendar.png")
    }));
	$("input[name=aplDtFrom], input[name=aplDtTo]").attr("readonly", true);
	$('input[name=aplDtFrom]').datepicker('option', 'onClose',  function( selectedDate ) {$("input[name=aplDtTo]").datepicker( "option", "minDate", selectedDate );});
	$('input[name=aplDtTo]').datepicker('option', 'onClose',  function( selectedDate ) {	$("input[name=aplDtFrom]").datepicker( "option", "maxDate", selectedDate );});
}

/**
 * 데이터를 로드한다.
 */
function loadData() {
    searchDataList($("#objtnForm [name=page]").val());
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
        url:"/portal/expose/searchObjection.do",
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
	
	var frm = document.objtnForm;
	frm.apl_no.value = data.aplNo;
	frm.objtnSno.value = data.objtnSno;
	
	var goUrl = "/portal/expose/selectObjectionPage.do"
	
    // 데이터를 조회하는 화면으로 이동한다.
    goSelect({
        url:goUrl,
        form:"objtnForm",
        data:[{name:"aplNo", value:data.aplNo},
              {name:"objtnSno",value:data.objtnSno}]
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
    var form = $("#objtnForm");
    
    if (com.wise.util.isBlank(options.page)) {
        form.find("[name=page]").val("1");
    }else {
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
    
    table.find("tr").each(function(index, element) {
        if (index > 0) {
            $(this).remove();
        }
    });
    
    for (var i = 0; i < data.length; i++) {
        var row = $(templates.data);

        row.find(".rowNum").text(getRowNumber($("#count-sect").text(), "" + data[i].rowNum));
        
        row.find(".objtnDt").text(data[i].objtnDt);
        row.find(".aplSj").text(data[i].aplSj);
        row.find(".aplDealInstNm").text(data[i].aplDealInstNm);
        row.find(".aplDt").text(data[i].aplDt);
        row.find(".objtnStatCD").text(data[i].objtnStatCD);

        row.find("a").each(function(index, element) {
            // 제목 링크에 클릭 이벤트를 바인딩한다.
            $(this).bind("click", {
            	aplNo:data[i].aplNo,
            	objtnSno:data[i].objtnSno
            }, function(event) {
                // 내용을 조회한다.
            	selectDetailPage(event.data);
                return false;
            });
            
            // 제목 링크에 키다운 이벤트를 바인딩한다.
            $(this).bind("keydown", {
            	aplNo:data[i].aplNo,
            	objtnSno:data[i].objtnSno
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
function fn_goSearch() {
	var frm = document.objtnForm;
	
	//============================================
	// 조회시날짜 입력이 안되어 있을면, 현재 날짜로 자동 세팅한다.
	var date = new Date();
	var year = date.getFullYear()+'';
	var month = (date.getMonth()+1)+'';
	var day = date.getDate()+'';
	if(month.length == 1) month = '0'+month;
	if(day.length == 1) day = '0'+day;
	
	var sysdate = year + "-" + month + "-" + day;
	
	if(!frm.aplDtFrom.value == '') {
		if(frm.aplDtTo.value == '') frm.aplDtTo.value = sysdate;
	}
	//============================================
	
	searchDataList($("#objtnForm [name=page]").val());
}
