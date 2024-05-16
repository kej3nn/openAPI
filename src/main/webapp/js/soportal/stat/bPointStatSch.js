/*
 * @(#)bPointStatSch.js 1.0 2019/05/01
 * 
 * COPYRIGHT (C) 2013 WISEITECH CO., LTD. ALL RIGHTS RESERVED.
 */

/**
 * 기준시점대비 변동분석 관련 스크립트 파일이다.
 * 
 * @author 김정호
 * @version 1.0 2019/05/01
 */
// //////////////////////////////////////////////////////////////////////////////
// 기준시점대비 변동분석 용 글로벌 변수
// //////////////////////////////////////////////////////////////////////////////
MULTI_STAT_TYPE = "BP";
	
// //////////////////////////////////////////////////////////////////////////////
// Script Init Loading...
// //////////////////////////////////////////////////////////////////////////////
$(function() {

	// GNB메뉴 바인딩한다.
	menuOn(1, 5);
	
	loadEvent();
});

function loadEvent() {
	
}

/**
 * 기준시점을 세팅한다. 
 */
function setDtaWrttime() {
	var objTab = getTabShowObj();
	var formSch = $("form[name=searchForm]");
	formSch.find("select#dtaWrttimeYear option").remove();
	formSch.find("select#wrttimeStartYear").find("option").clone().appendTo("form[name=searchForm] select#dtaWrttimeYear");
	formSch.find("select#dtaWrttimeQt option").remove();
	formSch.find("select#wrttimeStartQt").find("option").clone().appendTo("form[name=searchForm] select#dtaWrttimeQt");
}

/**
 * 기준시점 시트 조회후 선택한 기준시점 표시처리
 * @returns
 */
function sheetOnSearchEndBPoint() {
	var objTab = getTabShowObj();
	var sheetObj = window[getTabSheetName()];
	var colPrefix = "COL_";
	var rowPrefix = "ROW_";
	var dtaWrttimeYear = objTab.find("#dtaWrttimeYear").val();
	var dtaWrttimeQt = objTab.find("#dtaWrttimeQt").val();
	var viewLocOpt = objTab.find("input[name=viewLocOpt]:checked").val();
	var dtaCycleCd = objTab.find("select[name=dtacycleCd]").val();
	var startRow = sheetObj.GetDataFirstRow();
	
	if ( viewLocOpt == "H" ) {	// 기본(가로) 보기
		var paramDtaWrttime = dtaWrttimeYear + dtaWrttimeQt;
		var colIdx =  sheetObj.SaveNameCol(colPrefix + paramDtaWrttime);
		sheetObj.SetColFontBold(colIdx, 1);				// 컬럼 글자 굵게
		sheetObj.SetColBackColor(colIdx, IB_COLOR_DTA);	// 컬럼 배경색
	}
	else if ( viewLocOpt == "V" ) {	// 세로보기
		if ( dtaCycleCd == "YY" ) {
			var findRow = sheetObj.FindText("wrttimeId", dtaWrttimeYear, sheetObj.GetDataFirstRow(), 0);
			sheetObj.SetRowBackColor(findRow, IB_COLOR_DTA);	// 컬럼 배경색
		}
		else {
			var dtaRow = sheetObj.GetDataFirstRow();
			var dtaWrttimeUniq = dtaWrttimeYear + Number(dtaWrttimeQt);
			
			for ( var i=0; i < sheetObj.RowCount(); i++ ) {
				var idx = i + startRow;
				var wrttimeIdDesc = sheetObj.GetCellValue(idx, "wrttimeId");
				var wrttimeId = wrttimeIdDesc.replace(/[^0-9]/g, "");	// 시트에서 ROW는 구분자가 따로 없어서 시점에 문자를 제거한 데이터를 사용한다.

				if ( dtaWrttimeUniq == wrttimeId ) {
					dtaRow = idx;
					break;
				}
			}
			sheetObj.SetRowBackColor(dtaRow, IB_COLOR_DTA);	// 컬럼 배경색
		}
	}
	else if ( viewLocOpt == "T" ) {		// 년월보기
		// 쿼터는 컬럼에 있음
		var colIdx =  sheetObj.SaveNameCol(colPrefix + dtaWrttimeQt);	// ex) COL_02
		sheetObj.SetColFontBold(colIdx, 1);				// 컬럼 글자 굵게
		sheetObj.SetColBackColor(colIdx, IB_COLOR_DTA);	// 컬럼 배경색
		
		// 년 주기는 ROW에 있음
		var tsViewColIdx = sheetObj.SaveNameCol("tsViewCol");
		var arrWrttimeId = sheetObj.GetRangeValue(startRow, tsViewColIdx, sheetObj.RowCount(), tsViewColIdx).split("^");
		for ( var i=0; i < arrWrttimeId.length; i++ ) {
			if ( arrWrttimeId[i].indexOf(dtaWrttimeYear) > -1 ) {
				sheetObj.SetRowBackColor(i + startRow, IB_COLOR_DTA);	// 컬럼 배경색
			}
		}
	}
	else {
		return false;
	}
	
}