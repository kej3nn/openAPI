// 저장시에 필요한 원본 데이터
var realData;

$(function() {
	initComp2();
	loadData2();
	bindEvent2();
});

function initComp2() {
	if(window["DtfileSheet2"]) {
		window["DtfileSheet2"].Reset();
	}
    // 데이터 파일 시트 그리드를 생성한다.
    initSheetGrid({
        ElementId:"dtfile-sheet-section2",
        SheetId:"DtfileSheet2",
        Height:"296px"
    }, {
        // Nothing do do.
    }, {
        HeaderCheck:0
    }, metaCol, {
    });

    window["DtfileSheet2"].FitColWidth();
    
    initSheetOptions("DtfileSheet2", 0, "aprv", [{
        code:"",
        name:"선택"
    },	{
        code:"Y",
        name:"승인"
    }, {
        code:"C",
        name:"반려"
    }]);
	
}

function loadData2() {
	loadRealData2();
    searchDsData2();
}

function loadRealData2() {
	$.getJSON(com.wise.help.url("/admin/dtfile/selectListDtAprvDsDetailData.do"), {dsId:dsId, noPaging:"Y"}, function(data) {
		realData = data.data;
	});
}

function searchDsData2() {
    // 데이터 파일 시트 데이터를 로드한다.
    loadSheetData({
        SheetId:"DtfileSheet2",
        PageUrl:"/admin/dtfile/selectListDtAprvDsDetailData.do"
    }, {
    	ObjectParam:{
    		dsId:dsId
    	},
        FormParam:"search-form2"
    }, {
        // Nothing to do.
    });
}

function bindEvent2() {
	
	$('[name=btn_all').bind('click', function() {
		getData2($('#allControl').val());
	});
	
	$('#aprv-save').bind('click', function() {
		saveData2();
	});
	
}

function getData2(flag) {
	var sheet = window["DtfileSheet2"];
	var length = sheet.RowCount();
	for(var i = 1 ; i <= length ; i ++) {
		sheet.SetCellValue(i, 0, flag);
	}
}

function saveData2() {
	var sheet = window["DtfileSheet2"];
	var length = sheet.RowCount();
	
	var paramData = new Array();
	for(var i = 1 ; i <= length ; i ++) {
		var rowData = sheet.GetRowJson(i);
//		console.log(rowData.aprv);
		if(rowData.aprv != "") {
			paramData.push({
							dsId:dsId
							, aprv:rowData.aprv
							, data:realData[i-1]
						});
		}
	}
	
	if(paramData.length == 0) {
		alert("승인 또는 반려로 선택된 데이터가 없습니다.");
		return;
	}
	
	if(confirm("정말 저장하시겠습니까?")) {
		$.post(com.wise.help.url("/admin/dtfile/saveAprvDs.do"), {data: JSON.stringify(paramData)}, function(result) {
			alert("저장되었습니다.");
			location.href = com.wise.help.url("/admin/dtfile/selectListDtAprvDsPage.do");
		});
	}
}