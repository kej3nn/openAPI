// 현재 탭 idx
var nowTabIdx = 0;

$(function() {

	initComp();
	loadOptions();
	loadData();
	bindEvent();
});

function initComp() {

    // 데이터 파일 시트 그리드를 생성한다.
    initSheetGrid({
        ElementId:"dtfile-sheet-section",
        SheetId:"DtfileSheet",
        Height:"296px"
    }, {
        SearchMode:2
    }, {
        HeaderCheck:0
    }, [
        { Header:"업로드일자",             SaveName:"regDttm",   Hidden:0, Width:120, Align:"Center",   Sort:0, Type:"Text",  RadioIcon:1, Edit:0, Cursor:"Default", HoverUnderline:0 },
        { Header:"보유데이터명",             SaveName:"infNm",   Hidden:0, Width:210, Align:"Left",   Sort:0, Type:"Text",  RadioIcon:1, Edit:0, Cursor:"Default", HoverUnderline:0 },
        { Header:"보유데이터 테이블명",             SaveName:"dsId",   Hidden:0, Width:210, Align:"Left",   Sort:0, Type:"Text",  RadioIcon:1, Edit:0, Cursor:"Default", HoverUnderline:0 },
        { Header:"데이터셋명",           SaveName:"dsNm",    Hidden:0, Width:210, Align:"Left",   Sort:0, Type:"Text",  RadioIcon:1, Edit:0, Cursor:"Default", HoverUnderline:0 },
        { Header:"적재주기", SaveName:"loadNm",   Hidden:0, Width:80, Align:"Center",  Sort:0, Type:"Text",   RadioIcon:1, Edit:0, Cursor:"Default", HoverUnderline:0 },
        { Header:"승인 데이터수",           SaveName:"aprvDataCnt",    Hidden:0, Width:50, Align:"Center",   Sort:0, Type:"Text",  RadioIcon:1, Edit:0, Cursor:"Default", HoverUnderline:0 },
        { Header:"최근개인정보 비식별 오류",           SaveName:"endDtm",    Hidden:0, Width:120, Align:"Center",   Sort:0, Type:"Text",  RadioIcon:1, Edit:0, Cursor:"Default", HoverUnderline:0 },
    ], {
    });
    window["DtfileSheet"].FitColWidth();
}


function loadOptions() {
	// 적재주기 콤보 옵션을 초기화한다.
	loadComboOptions2("loadCd",
		"/admin/dtfile/ajaxCombo.do",
		{grpCd:"D1009"},
		"");
}

function loadData() {
    searchDsData();
}

function searchDsData() {
    // 데이터 파일 시트 데이터를 로드한다.
    loadSheetData({
        SheetId:"DtfileSheet",
        PageUrl:"/admin/dtfile/selectListDtAprvDsData.do",
        SearchMode:2
    }, {
        FormParam:"search-form"
    }, {
        // Nothing to do.
    });
}

/**
 * 조직명 팝업
 */
function poporgnm() {
	var url="/admin/basicinf/popup/commOrg_pop.do";
	var popup = OpenWindow(url,"orgPop","500","550","yes");
}

function bindEvent() {
    // 탭에 클릭 이벤트
	$('#tab_list').click(function() {
		$.each($('.tab li'), function(i, d) {
			if(i > 0) {
				$(this).removeClass("on");
				$('.container .content:eq('+i+')').hide();
			}
		});
		$('.container .content:eq(0)').show();
	});
	
    // 조회 버튼에 클릭 이벤트를 바인딩한다.
    $("#search-button").bind("click", function(event) {
        // 데이터 파일을 검색한다.
    	searchDsData();
        return false;
    });
    
    // 분류, 조직 검색팝업 및 초기화 버튼 이벤트를 바인딩한다.
    var formObj = $("form[name=search-form]");
    
    formObj.find("button[name=btn_search]").bind("click", function(e) { 
    	poporgnm();
		return false;               
	});
    
    formObj.find("button[name=btn_init]").bind("click", function(e) { 
		formObj.find("input[name=orgNm]").val("");
		formObj.find("input[name=orgCd]").val("");
		return false;               
	}); 
}

function DtfileSheet_OnRowSearchEnd(row) {
	var sheet = window["DtfileSheet"];
	var endDtm = sheet.GetCellValue(row, 6);
	if(endDtm != "") {
		sheet.SetRowBackColor(row, "#F8BBD0");
	}
}

function DtfileSheet_OnDblClick(row, col, value, cellX, cellY, cellW, cellH) {
	/*
	var sheet = window["DtfileSheet"];
	var dsId = sheet.GetCellValue(row, 2);
	var indvdlYn = "N";
	if(sheet.GetCellValue(row, 6) != "") {
		indvdlYn = "Y";
	}
	var selectForm = $("[name=select-form]");
	selectForm.attr(com.wise.help.url("/admin/dtfile/selectListDtAprvDsPage.do"));
	selectForm.find("[name=dsId]").val(dsId);
	selectForm.find("[name=indvdlYn]").val(indvdlYn);
	selectForm.submit();
	*/
	tabSet(row);
}

function tabSet(row) {
	var sheet = window["DtfileSheet"];
	var dsId = sheet.GetCellValue(row, 2);
	var indvdlYn = "N";
	if(sheet.GetCellValue(row, 6) != "") {
		indvdlYn = "Y";
	}
	
	var title = sheet.GetCellValue(row, 1);
	var tab_ul = $('.tab');
	$.each(tab_ul.find('li'), function(i, d) {
		if(i > 0) {
			$(this).remove();
			$('.container .content:eq('+i+')').remove();
		}
	});
	
	var tab_template = $('<li class="on"><a title="'+title+'">'+title+'</a> <a class="tab_close">x</a></li>');
	tab_template.find('a:eq(0)').click(function() {
		if(!tab_template.hasClass("on")) {
			tab_template.addClass("on");
		}
		$('.container .content:eq(0)').hide();
		$('.container .content:eq(1)').show();
	});
	tab_template.find('a:eq(1)').click(function() {
		$('.container .content:eq(0)').show();
		$('.container .content:eq(1)').remove();
		tab_template.remove();
	});
	tab_ul.append(tab_template);

	$('.container .content:eq(0)').hide();
	var cont_template = $('<div class="content"></div>');
	cont_template.load(com.wise.help.url("/admin/dtfile/selectListDtAprvDsDetail.do"), {dsId:dsId, indvdlYn:indvdlYn});
	cont_template.show();
	$('.container').append(cont_template);
	
	
}