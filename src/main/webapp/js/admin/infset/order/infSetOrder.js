/*
 * @(#)infSetOrder.js 1.0 2019/09/19
 */

/**
 * 관리자에서 정보셋 순서를 관리하는 스크립트
 *
 * @author JHKIM
 * @version 1.0 2019/09/19
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

////////////////////////////////////////////////////////////////////////////////
// 초기화 함수
////////////////////////////////////////////////////////////////////////////////
/**
 * 컴포넌트를 초기화한다.
 */
function initComp() {
	loadMainPage();
}

/**
 * 데이터를 로드한다.
 */
function loadData() {
	doAction("search");
}

/**
 * 메인페이지 로드
 * @returns
 */
function loadMainPage() {
	loadMainSheet();
}

/**
 * 메인 시트 로드
 */
function loadMainSheet() {
	createIBSheet2(document.getElementById("mainSheet"),"mainSheet", "100%", "400px");
	
	var gridTitle = "NO|상태|구분|부모분류ID|정보ID|분류>정보셋명|순서|담당부서|문서(건)|공공(건)|통계(건)|공개일|공개상태";
	
	with(mainSheet){
        
		var cfg = {SearchMode:2,Page:50,VScrollMode:1};
	    SetConfig(cfg);
	    var headers = [
	                {Text:gridTitle, Align:"Center"}
	            ];
	    var headerInfo = {Sort:0,ColMove:1,ColResize:1,HeaderCheck:0};
	    
	    InitHeaders(headers, headerInfo);
	   
	    var cols = [
	                 {Type:"Seq",		SaveName:"seq",				Width:30,	Align:"Center",	Edit:false}
	                ,{Type:"Status",	SaveName:"status",			Width:40,	Align:"Center",	Edit:false,	Hidden: false}  
	                ,{Type:"Text",		SaveName:"gubunTag",		Width:30,	Align:"Center",	Edit:false,	Hidden: true} 
	                ,{Type:"Text",		SaveName:"parInfsId",		Width:90,	Align:"Center",	Edit:false,	Hidden: true}
	                ,{Type:"Text",		SaveName:"infsId",			Width:90,	Align:"Center",	Edit:false, Hidden: true}
					,{Type:"Text",		SaveName:"infsNm",			Width:250,	Align:"Left",	Edit:false, TreeCol:1}
					,{Type:"Int",		SaveName:"vOrder",			Width:80,	Align:"Center",	Edit:false,	Hidden: true}
					,{Type:"Text",		SaveName:"orgNm",			Width:100,	Align:"Center",	Edit:false}
					,{Type:"Text",		SaveName:"docCnt",			Width:50,	Align:"Center",	Edit:false}
					,{Type:"Text",		SaveName:"infCnt",			Width:50,	Align:"Center",	Edit:false}
					,{Type:"Text",		SaveName:"statblCnt",		Width:50,	Align:"Center",	Edit:false}
					,{Type:"Text",		SaveName:"openDttm",		Width:90,	Align:"Center",	Edit:false,	Format:"Ymd"}
					,{Type:"Text",		SaveName:"openState",		Width:70,	Align:"Center",	Edit:false}
	            ];                                          
	    InitColumns(cols);
	    FitColWidth();
	    SetExtendLastCol(1);
	}               
	default_sheet(mainSheet);
}

/**
 * 데이터 저장 완료 후
 */
function mainSheet_OnLoadData(data) {
	var data = JSON.parse(data);
	if ( data.success != null) {
		//시트 분류명 저장이 성공적으로 완료된 경우
		alert(data.success.message);
		doAction("search");
	}
}

////////////////////////////////////////////////////////////////////////////////
// 화면 액션 함수들
////////////////////////////////////////////////////////////////////////////////
/**
 * 메인화면 관련 액션함수
 * @param sAction	액션명
 * @returns
 */
function doAction(sAction) {
	var formObj = $("form[name=mainForm]");
	switch(sAction) {                       
		case "search":
			var param = {PageParam: "ibpage", Param: "onepagerow=50"+"&"+formObj.serialize()};
			mainSheet.DoSearchPaging(com.wise.help.url("/admin/infs/order/selectInfSetOrderList.do"), param);
			break;
		case "save" :
			if ( !confirm("저장 하시겠습니까?") )	return false;
			
			saveSheetData({
                SheetId:"mainSheet",
                PageUrl:"/admin/infs/order/saveInfSetOrder.do"
            }, {
            }, {
                AllSave:0
            });
			break;	
		case "treeOpen":
			mainSheet.ShowTreeLevel(-1);
			break;	
		case "treeClose":
			mainSheet.ShowTreeLevel(0);
			break;
	}
}

function bindEvent() {
	// 조회
	$("button[name=btn_inquiry]").bind("click", function(event) {
		doAction("search");
		return false;
	});
	// 트리 위로
	$("a[name=a_treeUp]").bind("click", function(event) {
		fncTreeUp(mainSheet, "vOrder");
		return false;
	});
	// 트리 아래로
	$("a[name=a_treeDown]").bind("click", function(event) {
		fncTreeDown(mainSheet, "vOrder");
		return false;
	});
	// 저장
	$("a[name=a_vOrderSave]").bind("click", function(event) {
		doAction("save");
		return false;
	});
	// 트리열기
	$("#btn_treeOpen").bind("click", function(event) {
		doAction("treeOpen");
		return false;
	});
	// 트리닫기
	$("#btn_treeClose").bind("click", function(event) {
		doAction("treeClose");
		return false;
	});
}