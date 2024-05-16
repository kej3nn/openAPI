/*
 * @(#)easyStatSchPopEvent.js 1.0 2019/07/25
 */

/**
 * 간편통계 팝업 관련 이벤트 처리 스크립트 파일이다.
 * 
 * @author JHKIM
 * @version 1.0 2019/07/25
 */

function initEvent() {
	
	var formObj = $("form[name=statsEasy-mst-form]");
	
	// 검색주기 이벤트 처리
	wrtTimeEvent();
	
	// 항목 분류 이벤트 설정
	itmStatDivEvent();
	
	// 증감분석 버튼 이벤트 추가
	statTblEvent();
	
	//피봇설정 팝업 버튼이벤트 설정
	viewOptionStatEvent();
	
	// DIV 트리 이벤트 설정
	treeStatDivEvent();
	
	// 통계 버튼 이벤트 처리(시트/차트 탭, 조회, 열고정, 피봇이미지 등등)
	statOptionButtonEvent();
	
	// 차트 버튼 이벤트 처리
	loadChartEvent();
}

/**
 * 검색주기 이벤트 처리
 */
function wrtTimeEvent() {
	var formObj = $("form[name=statsEasy-mst-form]");
	
	// 검색주기 선택시 라디오 버튼 선택 변경
	formObj.find("select[name=wrttimeStartYear], select[name=wrttimeEndYear], select[name=wrttimeStartQt], select[name=wrttimeEndQt]").bind("click", function(event) {
		formObj.find("input[name=wrttimeType][value=B]").prop("checked", true);
	});
	// 검색주기 - 최근시점 개의 입력박스 선택시 라디오 버튼 선택 변경
	formObj.find("input[name=wrttimeLastestVal]").bind("click", function(event) {
		formObj.find("input[name=wrttimeType][value=L]").prop("checked", true);
	});
	// 검색주기 - 최근시점은 숫자만 입력
	formObj.find("input[name=wrttimeLastestVal]").keyup(function(e) {
		statComInputNumObj(formObj.find("input[name=wrttimeLastestVal]"));
		return false;
	});
	//최근시점 숫자만
	$("#wrttimeLastestVal").keyup(function(e) {
		statComInputNumObj($("#wrttimeLastestVal"));
		return false;
	});
	// 검색주기 선택
	formObj.find($('.viewBx .searchBx .cellbox .cell')).find("select[name=dtacycleCd]").change(function() {
		selectWrttimeVal(formObj, $(this).val());
	});
}

function treeStatDivEvent() {
	var formObj = $("form[name=statsEasy-mst-form]");
	
	// 그룹선택 버튼
	formObj.find("button[name=callPopGrp]").bind("click", function(event) {
		formObj.find($(".layerPopup.grpPop")).show();
		formObj.find($(".layerPopup.grpPop .PschBar input")).focus();	// 2018.04.24 김정호 - 레이어 팝업 오픈시 검색창에 focus를 준다.
	});	
	// 항목선택 버튼
	formObj.find("button[name=callPopItm]").bind("click", function(event) {
		formObj.find($(".layerPopup.itmPop")).show();
		formObj.find($(".layerPopup.itmPop .PschBar input")).focus();	// 2018.04.24 김정호 - 레이어 팝업 오픈시 검색창에 focus를 준다.
	});
	// 분류선택 버튼
	formObj.find("button[name=callPopCls]").bind("click", function(event) {
		formObj.find($(".layerPopup.clsPop")).show();
		formObj.find($(".layerPopup.clsPop .PschBar input")).focus();	// 2018.04.24 김정호 - 레이어 팝업 오픈시 검색창에 focus를 준다.
	});
	// 증감분석 버튼
	formObj.find("button[name=callPopDvs]").bind("click", function(event) {
		formObj.find($(".layerPopup.dvsPop")).show();
		formObj.find($(".layerPopup.dvsPop .PschBar input")).focus();	// 2018.04.24 김정호 - 레이어 팝업 오픈시 검색창에 focus를 준다.
	});
	// 보기옵션선택 버튼
	formObj.find("button[name=callPopOpt]").bind("click", function(event) {
		formObj.find($(".layerPopup.optPop")).show();
		formObj.find($(".layerPopup.optPop .list1 li input:eq(0)")).focus();	// 2018.04.24 김정호 - 레이어 팝업 오픈시 첫번째 radio에 focus를 준다.
	});
	// 항목/분류/증감분석/피봇설정 DIV 팝업 X버튼
	formObj.find(".layerPopup .popArea .close").bind("click", function(event) {
		var closeNm = $(this).attr("name").substring(0, 3);
		closeNm = initCap(closeNm);
		formObj.find($(".layerPopup.grpPop")).hide();
		formObj.find($(".layerPopup.itmPop")).hide();
		formObj.find($(".layerPopup.clsPop")).hide();
		formObj.find($(".layerPopup.optPop")).hide();
		formObj.find($(".layerPopup.dvsPop")).hide();
		formObj.find("button[name=callPop"+closeNm+"]").focus();	// 2018.04.24 김정호 - 레이어 팝업 닫을경우 레이어 버튼에 포커스를 준다.
	});
	// 그룹설정 팝업 닫기버튼
	formObj.find("a[name=grpClose], a[name=grpPopClose]").bind("click", function(event) {
		formObj.find($(".layerPopup.grpPop")).hide();
		formObj.find("button[name=callPopGrp]").focus();	// 2018.04.24 김정호 - 레이어 팝업 닫을경우 레이어 버튼에 포커스를 준다.
	});	
	// 항목설정 팝업 닫기버튼
	formObj.find("a[name=itmClose]").bind("click", function(event) {
		formObj.find($(".layerPopup.itmPop")).hide();
		formObj.find("button[name=callPopItm]").focus();	// 2018.04.24 김정호 - 레이어 팝업 닫을경우 레이어 버튼에 포커스를 준다.
	});
	// 분류설정 팝업 닫기버튼
	formObj.find("a[name=clsClose]").bind("click", function(event) {
		formObj.find($(".layerPopup.clsPop")).hide();
		formObj.find("button[name=callPopCls]").focus();	// 2018.04.24 김정호 - 레이어 팝업 닫을경우 레이어 버튼에 포커스를 준다.
	});
	// 증감분석 팝업 닫기버튼
	formObj.find("a[name=dvsClose]").bind("click", function(event) {
		formObj.find($(".layerPopup.dvsPop")).hide();
		formObj.find("button[name=callPopDvs]").focus();	// 2018.04.24 김정호 - 레이어 팝업 닫을경우 레이어 버튼에 포커스를 준다.
	});
	// 피봇설정 팝업 닫기버튼
	formObj.find("a[name=optClose], a[name=optPopClose]").bind("click", function(event) {
		formObj.find($(".layerPopup.optPop")).hide();
		formObj.find("button[name=callPopOpt]").focus();	// 2018.04.24 김정호 - 레이어 팝업 닫을경우 레이어 버튼에 포커스를 준다.
	});
	
	//분석기능(모바일)
	formObj.find(".schBtnTgl").bind("click", function() {
		var elem = formObj.find('.schBtnTglDv');
		if (!$(this).hasClass('on')) {
			$(this).addClass('on');
			elem.show();
		} else {
			$(this).removeClass('on');
			elem.hide();
		}
	});
}


/**
 * 항목 분류 이벤트 설정
 */
function itmStatDivEvent() {
	
	var formObj = $("form[name=statsEasy-mst-form]");
	var statblId = $("#statblId").val();
	
	// 그룹 DIV팝업 버튼 세팅
	formObj.find("button[name=tabGrpAllExpand]").bind("click", function() 	{treeNodeControl("grp" + statblId, "EXP")}); 	// 펼침
	formObj.find("button[name=tabGrpAllUnExpand]").bind("click", function() {treeNodeControl("grp" + statblId, "UN_EXP")}); // 닫기
	formObj.find("button[name=tabGrpAllChk]").bind("click", function() 		{treeNodeControl("grp" + statblId, "CHK")}); 	// 전체선택
	formObj.find("button[name=tabGrpAllUnChk]").bind("click", function() 	{treeNodeControl("grp" + statblId, "UN_CHK")}); // 전체해제
	// 항목 검색
	formObj.find("button[name=tabGrpSearch]").bind("click", function(event) {
		var grpKeyword = formObj.find("input[name=tabGrpKeyword]").val();
		grpKeyword = htmlTagFilter(grpKeyword);
		if(grpKeyword == false) {
			grpKeyword="";
			formObj.find("input[name=tabGrpKeyword]").val("");
		}
		searchNode("grp" + statblId, grpKeyword);
	});
	// 그룹검색창 enter
	formObj.find("input[name=tabGrpKeyword]").bind("keydown", function(event) {
		// 엔터키인 경우
		if (event.which == 13) {
			var grpTreeId = formObj.find($(".layerPopup.grpZtree")).find("ul").attr('id');
			var grpKeyword = formObj.find("input[name=tabGrpKeyword]").val();
			grpKeyword = htmlTagFilter(grpKeyword);
			if(grpKeyword == false) {
				grpKeyword="";
				formObj.find("input[name=tabGrpKeyword]").val("");
			}
			searchNode("grp" + statblId, grpKeyword);
			return false;
		}
	});
	
	// 항목 DIV팝업 버튼 세팅
	formObj.find("button[name=tabItmAllExpand]").bind("click", function() 	{treeNodeControl("itm" + statblId, "EXP")}); 	// 펼침
	formObj.find("button[name=tabItmAllUnExpand]").bind("click", function() {treeNodeControl("itm" + statblId, "UN_EXP")}); // 닫기
	formObj.find("button[name=tabItmAllChk]").bind("click", function() 		{treeNodeControl("itm" + statblId, "CHK")}); 	// 전체선택
	formObj.find("button[name=tabItmAllUnChk]").bind("click", function() 	{treeNodeControl("itm" + statblId, "UN_CHK")}); // 전체해제
	// 항목 검색
	formObj.find("button[name=tabItmSearch]").bind("click", function(event) {
		var itmKeyword = formObj.find("input[name=tabItmKeyword]").val();
		itmKeyword = htmlTagFilter(itmKeyword);
		if(itmKeyword == false) {
			itmKeyword="";
			formObj.find("input[name=tabItmKeyword]").val("");
		}
		searchNode("itm" + statblId, itmKeyword);
	});
	// 항목검색창 enter
	formObj.find("input[name=tabItmKeyword]").bind(
			"keydown",
			function(event) {
				// 엔터키인 경우
				if (event.which == 13) {
					var itmTreeId = formObj.find($(".layerPopup.itmZtree")).find("ul").attr('id');
					var itmKeyword = formObj.find("input[name=tabItmKeyword]").val();
					itmKeyword = htmlTagFilter(itmKeyword);
					if(itmKeyword == false) {
						itmKeyword="";
						formObj.find("input[name=tabItmKeyword]").val("");
					}
					searchNode("itm" + statblId, itmKeyword);
					return false;
				}
			});

	// 분류 DIV팝업 버튼 세팅
	formObj.find($("button[name=tabClsAllExpand]")).bind("click", function() 	{treeNodeControl("cls" + statblId, "EXP")}); 	// 펼침
	formObj.find($("button[name=tabClsAllUnExpand]")).bind("click", function() 	{treeNodeControl("cls" + statblId, "UN_EXP")}); // 닫기
	formObj.find($("button[name=tabClsAllChk]")).bind("click", function() 		{treeNodeControl("cls" + statblId, "CHK")}); 	// 전체선택
	formObj.find($("button[name=tabClsAllUnChk]")).bind("click", function() 	{treeNodeControl("cls" + statblId, "UN_CHK")}); // 전체해제
	// 분류 검색
	formObj.find("button[name=tabClsSearch]").bind("click", function(event) {
		var clsKeyword = formObj.find("input[name=tabClsKeyword]").val();
		clsKeyword = htmlTagFilter(clsKeyword);
		if(clsKeyword == false) {
			clsKeyword="";
			formObj.find("input[name=tabClsKeyword]").val("");
		}
		searchNode("cls" + statblId, clsKeyword);
	});
	// 분류검색창 enter
	formObj.find("input[name=tabClsKeyword]").bind("keydown", function(event) {
		// 엔터키인 경우
		if (event.which == 13) {
			var clsTreeId = formObj.find($(".layerPopup.clsZtree")).find("ul").attr('id');
			var clsKeyword = formObj.find("input[name=tabClsKeyword]").val();
			clsKeyword = htmlTagFilter(clsKeyword);
			if(clsKeyword == false) {
				clsKeyword="";
				formObj.find("input[name=tabClsKeyword]").val("");
			}
			searchNode("cls" + statblId, clsKeyword);
			return false;
		}
	});

	// 그룹 선택 적용
	formObj.find("a[name=grpApply]").bind("click", function(event) {
		if ( searchValidation() ) {
			treeChkApply("itm" + statblId, "chkItms");
			treeChkApply("cls" + statblId, "chkClss");
			treeChkApply("grp" + statblId, "chkGrps");
			treeChkApply(formObj.find($(".layerPopup.dvsPop")).find("ul").attr('id'), "dtadvsVal");
			
			if(formObj.find("a[title=Sheet]").parents("li").hasClass("on")){
				reCreateSheet();	//통계 시트 새로조회
			}else if(formObj.find("a[title=Chart]").parents("li").hasClass("on")){
				doLoadChart();		//통계  차트 새로조회
			}else{
				alert("Map 새로고침");
				return false;
			}
		}
	});
	
	// 항목 선택 적용
	formObj.find("a[name=itmApply]").bind("click", function(event) {
		if ( searchValidation() ) {
			treeChkApply("itm" + statblId, "chkItms");
			treeChkApply("cls" + statblId, "chkClss");
			treeChkApply("grp" + statblId, "chkGrps");
			treeChkApply(formObj.find($(".layerPopup.dvsPop")).find("ul").attr('id'), "dtadvsVal");
			
			if(formObj.find("a[title=Sheet]").parents("li").hasClass("on")){
				reCreateSheet();	//통계 시트 새로조회
			}else if(formObj.find("a[title=Chart]").parents("li").hasClass("on")){
				doLoadChart();		//통계  차트 새로조회
			}else{
				alert("Map 새로고침");
				return false;
			}
		}
	});
	
	// 분류 선택 적용
	formObj.find("a[name=clsApply]").bind("click", function(event) {
		if ( searchValidation() ) {
			treeChkApply("itm" + statblId, "chkItms");
			treeChkApply("cls" + statblId, "chkClss");
			treeChkApply("grp" + statblId, "chkGrps");
			treeChkApply(formObj.find($(".layerPopup.dvsPop")).find("ul").attr('id'), "dtadvsVal");
			
			if(formObj.find("a[title=Sheet]").parents("li").hasClass("on")){
				reCreateSheet();	//통계 시트 새로조회
			}else if(formObj.find("a[title=Chart]").parents("li").hasClass("on")){
				doLoadChart();		//통계  차트 새로조회
			}else{
				alert("Map 새로고침");
				return false;
			}
		}
	});
}

/**
 * 증감분석 버튼 이벤트 추가
 */
function statTblEvent() {
	var formObj = $("form[name=statsEasy-mst-form]");
	var dvsTreeNm = formObj.find($(".layerPopup.dvsPop")).find("ul").attr('id');
	
	formObj.find("button[name=tabDvsAllChk]").bind("click", function(event) {
		treeNodeControl(dvsTreeNm, "CHK")
	}); // 전체선택

	formObj.find("button[name=tabDvsAllUnChk]").bind("click", function(event) {
		treeNodeControl(dvsTreeNm, "UN_CHK")
	}); // 전체해제

	// 증감분석 검색
	formObj.find("button[name=tabDvsSearch]").bind("click", function(event) {
		var dvsKeyword = formObj.find("input[name=tabDvsKeyword]").val();
		searchNode(dvsTreeNm, dvsKeyword);
	});
	// 증감분석검색창 enter
	formObj.find("input[name=tabDvsKeyword]").bind("keydown", function(event) {
		// 엔터키인 경우
		if (event.which == 13) {
			var dvsTreeId = formObj.find($(".layerPopup.dvsZtree")).find("ul").attr('id');
			var dvsKeyword = formObj.find("input[name=tabDvsKeyword]").val();
			searchNode(dvsTreeNm, dvsKeyword);
			return false;
		}
	});

	// 증감분석 적용버튼
	formObj.find("a[name=dvsApply]").bind("click", function(event) {
		if ( searchValidation() ) {
			treeChkApply("itm" + formObj.find("input[name=statblId]").val(), "chkItms");
			treeChkApply("cls" + formObj.find("input[name=statblId]").val(), "chkClss");
			treeChkApply("grp" + formObj.find("input[name=statblId]").val(), "chkGrps");
			treeChkApply(formObj.find($(".layerPopup.dvsPop")).find("ul").attr('id'), "dtadvsVal");
			
			if(formObj.find("a[title=Sheet]").parents("li").hasClass("on")){
				reCreateSheet();	//통계 시트 새로조회
			}else if(formObj.find("a[title=Chart]").parents("li").hasClass("on")){
				doLoadChart();		//통계  차트 새로조회
			}else{
				alert("Map 새로고침");
				return false;
			}
		}
	});
}

/**
 * 피봇설정 팝업 버튼이벤트 설정
 */
function viewOptionStatEvent() {
	var formObj = $("form[name=statsEasy-mst-form]");
	
	// 사용자보기 자동선택
	formObj.find($("input[name=optST]")).click(function() { // 사용자보기 - 시계열
		var $radios = $('input:radio[name=viewLocOpt]');
		$radios.filter('[value=U]').prop('checked', true);
	});
	formObj.find($("input[name=optSI]")).click(function() { // 사용자보기 - 항목
		var $radios = $('input:radio[name=viewLocOpt]');
		$radios.filter('[value=U]').prop('checked', true);
	});
	formObj.find($("input[name=optSC]")).click(function() { // 사용자보기 - 분류
		var $radios = $('input:radio[name=viewLocOpt]');
		$radios.filter('[value=U]').prop('checked', true);
	});
	formObj.find($("input[name=optSG]")).click(function() { // 사용자보기 - 그룹
		var $radios = $('input:radio[name=viewLocOpt]');
		$radios.filter('[value=U]').prop('checked', true);
	});

	// 피봇설정 적용버튼
	formObj.find("a[name=optRefresh]").bind("click", function(event) {
		if (searchValidation()) {
			// 20180508/김정호 - validation 하고 팝업 닫도록 수정(년월 보기 focus 때문에)
			formObj.find($(".layerPopup.optPop")).hide();
			showLoading();
			
			reCreateSheet();	//통계 시트 새로조회
		}
	});
}

function statOptionButtonEvent() {
	var formObj = $("form[name=statsEasy-mst-form]");
	
	// Shee & Chart tab
	formObj.find($('.tabSt li')).on('click', function() {
		var id = $(this).find('a').attr('href');

		formObj.find($('.tabSt li')).removeClass('on');
		$(this).addClass('on');

		if (id == "#sheetTab") {
			formObj.find($(".tabCont.sheetTab")).show();
			formObj.find($(".tabCont.chartTab")).hide();
			formObj.find($(".tabCont.mapTab")).hide();
			formObj.find($(".remarkDv")).show();
			
			reCreateSheet();
		} else if(id == "#chartTab") {
			formObj.find($(".tabCont.sheetTab")).hide();
			formObj.find($(".tabCont.chartTab")).show();
			formObj.find($(".tabCont.mapTab")).hide();
			formObj.find($(".remarkDv")).hide();
			
			formObj.find("div[class=dropdown-content]").hide();
			doLoadChart();
		} else { //mapTab
			formObj.find($(".tabCont.sheetTab")).hide();
			formObj.find($(".tabCont.chartTab")).hide();
			formObj.find($(".tabCont.mapTab")).show();
			formObj.find($(".remarkDv")).hide();
			
			formObj.find("div[class=dropdown-content]").hide();
			loadMap(formObj.find($(".map.statEasyMap")).attr('id'), formObj.find("input[name=tabMapVal]").val(), "T");
		}

		return false;
	});
	
	// 조회 버튼
	formObj.find("button[name=easySearch]").bind("click", function(event) {
		if (searchValidation()) {
			var statblId = formObj.find("input[name=statblId]").val();
			treeChkApply(formObj.find($(".layerPopup.grpPop")).find("ul").attr('id'), "chkGrps");//그룹
			treeChkApply(formObj.find($(".layerPopup.itmPop")).find("ul").attr('id'), "chkItms");	//항목
			treeChkApply(formObj.find($(".layerPopup.clsPop")).find("ul").attr('id'), "chkClss");	//분류
			treeChkApply(formObj.find($(".layerPopup.dvsPop")).find("ul").attr('id'), "dtadvsVal");	//증감분석 트리 현재 상태대로 다시 읽음
			
			if(formObj.find("a[title=Sheet]").parents("li").hasClass("on")){
				reCreateSheet();	//통계 시트 새로조회
			}else if(formObj.find("a[title=Chart]").parents("li").hasClass("on")){
				formObj.find("input[name=chartType]").val(""); 		// 차트 : 선택타입 초기화
				formObj.find("input[name=chartStockType]").val("");	// 차트 : HISTORY/SCROLL 초기화
				formObj.find("input[name=chart23Type]").val("2D");	// 차트 : 2D/3D 초기화
				formObj.find("input[name=chartLegend]").val("");	// 차트 : 범례 초기화
				
				// 차트 버튼 이미지 초기화
				formObj.find(".chartMenu > button img").each(function(event) {
					var src = $(this).attr("src");
					$(this).attr("src", src.replace("on", ""));
				});
				
				doLoadChart();		//통계  차트 새로조회
			}else{
				loadMap(formObj.find($(".map.statEasyMap")).attr('id'), formObj.find("input[name=tabMapVal]").val(), "T");
				return false;
			}
		}
	});
	
	// 메타데이터 열기 버튼
	formObj.find("button[name=metaData]").bind("click", function(event) {

		if (formObj.find($(".metaData")).is(":hidden")) {
			formObj.find($(".metaData")).slideDown();
			//메타데이터 확인 로그 남김
			insertStatLogs("STAT", {
				statblId: formObj.find("input[name=statblId]").val(),
				statId: formObj.find("input[name=statId]").val()
			});
		} else {
			formObj.find($(".metaData")).slideUp();
		}
	});
	
	// 피봇이미지 버튼 이벤트 처리
	formObj.find(".pivot_icon img").each(function(imgPos) {
		$(this).bind("click", function() {
			var imgViewLocOpt = "B";
			if 		( imgPos == 0 ) { imgViewLocOpt = "B" }
			else if ( imgPos == 1 ) { imgViewLocOpt = "H" }
			else if ( imgPos == 2 ) { imgViewLocOpt = "V" }
			else if ( imgPos == 3 ) { imgViewLocOpt = "T" }
			else if ( imgPos == 4 ) { imgViewLocOpt = "U" }
			formObj.find("input[name=viewLocOpt][value="+imgViewLocOpt+"]").prop("checked", true);
			
			if ( imgViewLocOpt == "U" ) {
				// 사용자 보기일경우 팝업창 열기
				formObj.find("button[name=callPopOpt]").click();
			}
			else {
				formObj.find("a[name=optRefresh]").click();
			}
		})
	});
	
	// 시트 컬럼 열 고정/해제
	formObj.find("#chkFrozenCol").bind("change", function(event) {
		if ( statSheet.GetFrozenCol() > 0 ) {
			statSheet.SetFrozenCol(0);
		}
		else {
			for ( var i=0; i < statSheet.LastCol(); i++ ) {
				if ( statSheet.ColSaveName(i).indexOf("COL_") > -1 ) {
					statSheet.SetFrozenCol(i);
					break;
				}
			}
		}
		statSheet.SetHeaderRowHeight(23);	// 열고정시 시트 헤더 높이가 자기 맘대로 조절됨.ㅠㅠ 강제로 설정..
		return false;
	});
	
	// 다운로드[XLS] 버튼
	formObj.find("button[name=downXLS]").bind("click", function(event) {
		PortalDownFile("EXCEL", "excel");
	});
	
	// 다운로드[HWP] 버튼
	formObj.find("button[name=downHWP]").bind("click", function(event) {
		/*
		 * Sheet HWP 파일 다운로드
		 */
		var hwpColArray = new Array();
		
		for(var idx = 0; idx < statSheet.LastCol() + 1; idx++){
			if(!statSheet.GetColHidden(idx)){
				hwpColArray.push(idx);
			}
		}
		
		var docTitle = $(".sheetTitle").text();
		
		var params = {
   	           Title:{ Text:docTitle, Align:"Center"},
   	           DocOrientation:"Landscape",
   	           DownCols: hwpColArray.join("|"),
					FileName: docTitle
    	} ;
		
		//통계표 다운로드(HWP) 로그 남김
		insertStatLogs("HWP", {statMulti: "N", statblId: statblId});
		
		statSheet.Down2Hml(params);
		return false;
	});
	
	// 주석 열기 버튼
	formObj.find($('.remarkDv .btn')).on('click', function() {
		var remark = formObj.find($('.remarkDv .remark'));
		var remarkH = formObj.find($('.remarkDv .remark')).outerHeight();
		var obj = formObj.find($(".tabCont.sheetTab")).is(':hidden') ? formObj.find($(".tabCont.chartTab")).find($('.chart')) : formObj.find($(".tabCont.sheetTab")).find($('.grid'));
		var pat = formObj.find($(".tabCont.sheetTab")).is(':hidden') ? formObj.find($('.chartarea')): formObj.find($('.sheetarea'));
		if (remark.is(':hidden')) {
			gridH = obj.outerHeight();
			remark.slideDown(10);//0.01
			formObj.find($('.remarkDv .btn')).addClass('on');
			pat.animate({
				'padding-bottom' : remarkH
			});
			obj.animate({
				height : gridH - remarkH
			});
			
			formObj.find('.remarkDv .remark').attr("tabindex", -1).focus(); 
		} else {
			remark.slideUp(10);//0.01
			formObj.find($('.remarkDv .btn')).removeClass('on');
			pat.animate({
				'padding-bottom' : 0
			});
			obj.animate({
				height : gridH
			});
		}
	});
	
	//SNS 공유 버튼 이벤트 처리
	formObj.find("a[name=snsShare]").bind("click", function(event) {
		var statblId = formObj.find("input[name=statblId]").val();
		
		var _this = $(this);
		var snsType = _this.attr('data-service');
		var href = serverAddr+"/portal/stat/easyStatPage/"+statblId+".do";
		var title = "· NABOSTATS 국회예산정책처 재정경제통계시스템 제공"+"\n"+"· 통계표명 : " + formObj.find(".sheetTitle").text()+"\n";
		var loc = "";
		
		if( !snsType || !href || !title) return;
		
		if( snsType == "facebook" ) {
			loc = "https://www.facebook.com/sharer/sharer.php"+"?u="+href+"&t="+title;
		}else if ( snsType == "twitter" ) {
			loc = "https://twitter.com/intent/tweet?text="+encodeURIComponent(title)+"&url="+href;
		}else if ( snsType == 'kakaostory') {
			loc = "https://story.kakao.com/share?url="+encodeURIComponent(href);
		}
		
		window.open(loc);
		return false;
	});
}

function loadChartEvent() {
	/* 차트 버튼 이벤트 처리 START */
	
	var formObj = $("form[name=statsEasy-mst-form]");
	
	// 차트 범례 버튼
	formObj.find("button[name=remarkControl]").bind("click", function(event) {
		if (!formObj.find($('.chart')).hasClass('remark')) {
			formObj.find($('.chart')).addClass('remark');
			formObj.find($('.remark-content')).show();
		} else {
			formObj.find($('.chart')).removeClass('remark');
			formObj.find($('.remark-content')).hide();
		}
	});
	// 차트 범례 버튼 -> 범례보이기
	formObj.find("a[name=remarkShow]").bind("click", function(event) {
		for (var i = 0; i < hightChart.series.length-1; i++) {
			hightChart.series[i].update({
				showInLegend : true
			});
		}
		$(this).parents('li').hide();
		formObj.find("a[name=remarkHide]").parents('li').show();
	});
	// 차트 범례 버튼 -> 범례숨기기
	formObj.find("a[name=remarkHide]").bind("click", function(event) {
		for (var i = 0; i < hightChart.series.length-1; i++) {
			hightChart.series[i].update({
				showInLegend : false
			});
		}
		$(this).parents('li').hide();
		formObj.find("a[name=remarkShow]").parents('li').show();
	});
	// 차트 범례 버튼 -> 범례 전체선택
	formObj.find("a[name=legAllChk]").bind("click", function(event) {
        var series =  hightChart.series;
        for(i=0;i<series.length;i++) {
            series[i].show();
        }
	});
	// 차트 범례 버튼 -> 범례 전체선택해제
	formObj.find("a[name=legAllNon]").bind("click", function(event) {
        var series =  hightChart.series;
        for(i=0;i<series.length;i++) {
            series[i].hide();
        }
	});
	
	// 2D || 3D 버튼
	formObj.find("button[name=chartViewType]").bind("click", function(event) {
		var chartId = formObj.find($(".chart.statEasyChart")).attr('id');
		
		//기본 차트정보 호출
		var imgSrc = $(this).children("img").attr("src");
		if (imgSrc.indexOf("charbtn03.png") != -1) {
			$(this).children("img").attr("src", "/images/soportal/chart/charbtn03_.png");

			//3D로 옵션변경
			formObj.find("input[name=chart23Type]").val("3D");
			var chartType = formObj.find("input[name=chartType]").val();
			statChartCreate(chartType, chartId);
		}else{
			$(this).children("img").attr("src", "/images/soportal/chart/charbtn03.png");
			
			//2D로 옵션변경
			formObj.find("input[name=chart23Type]").val("2D");
			var chartType = formObj.find("input[name=chartType]").val();
			statChartCreate(chartType, chartId);
		}
	});
	
	// 기본차트
	formObj.find("button[name=chartBasic]").bind("click", function(event) {
		var chartId = formObj.find($(".chart.statEasyChart")).attr('id');
		statChartCreate("", chartId);
		formObj.find("input[name=chartType]").val("");
		formObj.find("input[name=chartStockType]").val("");
		formObj.find("input[name=chart23Type]").val("2D");
		chartButtonReset("charbtn19");
	});
	
	//버튼선택에 따른 초기화
	function chartButtonReset(selNum){
		formObj.find($(".chartMenu")).find("button").each(function(event){
			var imgSrc = $(this).children("img").attr("src");
			if (imgSrc.indexOf("on.png") != -1 && imgSrc.indexOf("01") == -1) {
				$(this).children("img").attr("src", imgSrc.replace("on", ""));
			}
			
			if (imgSrc.indexOf(selNum) != -1){
				$(this).children("img").attr("src", "/images/soportal/chart/"+selNum+"on.png");
			}
		});
	}
	
	// 곡선
	formObj.find("button[name=chartSpline]").bind("click", function(event) {
		var chartId = formObj.find($(".chart.statEasyChart")).attr('id');
		statChartCreate("spline", chartId);
		formObj.find("input[name=chartType]").val("spline");
		chartButtonReset("charbtn04");
	});
	// 꺽은선
	formObj.find("button[name=chartLine]").bind("click", function(event) {
		var chartId = formObj.find($(".chart.statEasyChart")).attr('id');
		statChartCreate("line", chartId);
		formObj.find("input[name=chartType]").val("line");
		chartButtonReset("charbtn05");
	});
	// 누적영역
	formObj.find("button[name=chartArea]").bind("click",	function(event) {
		var chartId = formObj.find($(".chart.statEasyChart")).attr('id');
		statChartCreate("area", chartId);
		formObj.find("input[name=chartType]").val("area");
		chartButtonReset("charbtn06");
	});
	// 막대
	formObj.find("button[name=chartHbar]").bind("click", function(event) {
		var chartId = formObj.find($(".chart.statEasyChart")).attr('id');
		statChartCreate("column", chartId);
		formObj.find("input[name=chartType]").val("column");
		chartButtonReset("charbtn07");
	});
	// 누적막대
	formObj.find("button[name=chartAccHbar]").bind("click", function(event) {
		var chartId = formObj.find($(".chart.statEasyChart")).attr('id');
		statChartCreate("accolumn", chartId);
		formObj.find("input[name=chartType]").val("accolumn");
		chartButtonReset("charbtn08");
	});
	// 퍼센트누적막대
	formObj.find("button[name=chartPAccHbar]").bind("click", function(event) {
		var chartId = formObj.find($(".chart.statEasyChart")).attr('id');
		statChartCreate("pccolumn", chartId);
		formObj.find("input[name=chartType]").val("pccolumn");
		chartButtonReset("charbtn09");
	});
	// 가로막대
	formObj.find("button[name=chartWbar]").bind("click", function(event) {
		var chartId = formObj.find($(".chart.statEasyChart")).attr('id');
		statChartCreate("bar", chartId);
		formObj.find("input[name=chartType]").val("bar");
		chartButtonReset("charbtn10");
	});
	// 가로누적막대
	formObj.find("button[name=chartAccWbar]").bind("click",	function(event) {
		var chartId = formObj.find($(".chart.statEasyChart")).attr('id');
		statChartCreate("acbar", chartId);
		formObj.find("input[name=chartType]").val("acbar");
		chartButtonReset("charbtn11");
	});
	// 퍼센트가로누적막대
	formObj.find("button[name=chartPAccWbar]").bind("click", function(event) {
		var chartId = formObj.find($(".chart.statEasyChart")).attr('id');
		statChartCreate("pcbar", chartId);
		formObj.find("input[name=chartType]").val("pcbar");
		chartButtonReset("charbtn12");
	});
	// 차트 파이
	formObj.find("button[name=chartPie]").bind("click", function(event) {
		var chartId = formObj.find($(".chart.statEasyChart")).attr('id');
		statChartCreate("pie", chartId);
		formObj.find("input[name=chartType]").val("pie");
		chartButtonReset("charbtn13");
	});
	// 차트 도넛
	formObj.find("button[name=chartDonut]").bind("click",function(event) {
		var chartId = formObj.find($(".chart.statEasyChart")).attr('id');
		statChartCreate("donut", chartId);
		formObj.find("input[name=chartType]").val("donut");
		chartButtonReset("charbtn14");
	});
	// 차트 TreeMap
	formObj.find("button[name=chartTreeMap]").bind("click",function(event) {
		var chartId = formObj.find($(".chart.statEasyChart")).attr('id');
		statChartCreate("treemap", chartId);
		formObj.find("input[name=chartType]").val("treemap");
		chartButtonReset("charbtn15");
	});
	// 차트 SpiderWeb
	formObj.find("button[name=chartSpiderWeb]").bind("click",function(event) {
		var chartId = formObj.find($(".chart.statEasyChart")).attr('id');
		statChartCreate("spiderweb", chartId);
		formObj.find("input[name=chartType]").val("spiderweb");
		chartButtonReset("charbtn16");
	});
	// 차트 Sunburst
	formObj.find("button[name=chartSunburst]").bind("click",function(event) {
		var chartId = formObj.find($(".chart.statEasyChart")).attr('id');
		statChartCreate("sunburst", chartId);
		formObj.find("input[name=chartType]").val("sunburst");
		chartButtonReset("charbtn17");
	});
	// 차트 다운로드 버튼
	formObj.find("button[name=chartDownload]").bind("click", function(event) {
		var chartId = formObj.find($(".chart.statEasyChart")).attr('id');
		if (!formObj.find($('.chart')).hasClass('down')) {
			formObj.find($('.chart')).addClass('down');
			formObj.find($('.dropdown-content')).show();
		} else {
			formObj.find($('.chart')).removeClass('down');
			formObj.find($('.dropdown-content')).hide();
		}
	});
	// 차트 다운로드 버튼 -> chartPrint
	formObj.find("a[name=chartPrint]").bind("click", function(event) {
		hightChart.print();
	});
	// 차트 다운로드 버튼 -> chartPng
	formObj.find("a[name=chartPng]").bind("click", function(event) {
		if ( formObj.find("select[name=chartChange]").val() == "pie" ) {
			jAlert("파이형 차트는 다운로드 기능을 지원하지 않습니다.");
			return false;
		}
		hightChart.exportChart({
			type : 'image/png',
			filename : 'nasna-png'
		});
	});
	// 차트 다운로드 버튼 -> chartJpeg
	formObj.find("a[name=chartJpeg]").bind("click", function(event) {
		if ( formObj.find("select[name=chartChange]").val() == "pie" ) {
			jAlert("파이형 차트는 다운로드 기능을 지원하지 않습니다.");
			return false;
		}
		hightChart.exportChart({
			type : 'image/jpeg',
			filename : 'nasna-jpeg'
		});
	});
	// 차트 다운로드 버튼 -> chartPdf
	formObj.find("a[name=chartPdf]").bind("click", function(event) {
		if ( formObj.find("select[name=chartChange]").val() == "pie" ) {
			jAlert("파이형 차트는 다운로드 기능을 지원하지 않습니다.");
			return false;
		}
		hightChart.exportChart({
			type : 'application/pdf',
			filename : 'nasna-pdf'
		});
	});
	// 차트 다운로드 버튼 -> chartSvg
	formObj.find("a[name=chartSvg]").bind("click", function(event) {
		if ( formObj.find("select[name=chartChange]").val() == "pie" ) {
			jAlert("파이형 차트는 다운로드 기능을 지원하지 않습니다.");
			return false;
		}
		hightChart.exportChart({
			type : 'image/svg+xml',
			filename : 'nasna-svg'
		});
	});

	/* 차트 버튼 이벤트 처리 END */
}

/**
 * sheet 상단에 피봇 값에 따라 설정한 값 이미지 표시 
 */
function showSheetPivotImg() {
	var viewLocOpt = $("input[name=viewLocOpt]:checked").val();
	var imgSrcUrl = "";
	var imgPos = 0;
	if 		( viewLocOpt == "B" ) {	imgPos = 0 }	//기본보기
	else if ( viewLocOpt == "H" ) {	imgPos = 1 }	//가로보기
	else if ( viewLocOpt == "V" ) {	imgPos = 2 }	//세로보기
	else if ( viewLocOpt == "T" ) {	imgPos = 3 }	//년월보기
	else if ( viewLocOpt == "U" ) {	imgPos = 4 }	//사용자보기
	
	$(".pivotLocImg").removeClass("on").eq(imgPos).addClass("on");
}