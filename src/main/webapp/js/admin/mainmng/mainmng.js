$(document).ready(function() {
	
	init();
	
	/** 메인화면 관련 */
	LoadMainPage();
	doActionMain("search");
	
	/** 분류정보 관련 */
	//LoadCatePage();
	//doActionCate("search");
	
	/** 메타정보 관련 */
	//LoadMetaPage();
	//doActionMeta("search");
	
	bindEvent();
	
});

function init() {
	
	$.post(ctxPath+'/admin/stat/ajaxOption.do',{grpCd:"B1009"}, function(data) {
		var datas = JSON.parse(data);
		$.each(datas.data, function(i, d) {
			$('[name=homeTagCd]').append('<option value="'+d.code+'">'+d.name+'</option>');
		});
	});
	
	var form = $('#mainmng-insert-form');
	form.find("input[name=strtDttm]").datepicker(setCalendar());          
	form.find("input[name=endDttm]").datepicker(setCalendar());      
	datepickerTrigger();     
}

function bindEvent() {
	
	// 메인관리 검색 버튼
	$("button[name=btn_search]").bind("click", function() {
		doActionMain("search");
		return false;
	});
	
	// 달력 초기화
	$('#dttm-init-btn').bind("click", function() {
		$('[name=strtDttm],[name=endDttm]').val("");
		return false;
	});
	
	// 메인관리 초기화 버튼
	$('#mainmng-init-btn').bind("click", function() {
		initInputValues();
		return false;
	});
	// 메인관리 등록버튼
	$('#mainmng-save-btn').bind("click", function() {
		doActionMain("save");
		return false;
	});

	// 메인관리 삭제
	$('#main-btns a:eq(0)').bind("click", function() {
		doActionMain("remove");
		return false;
	});
	// 메인관리 위로
	$('#main-btns a:eq(1)').bind("click", function() {
		doActionMain("moveUp");
        return false;
	});
	// 메인관리 아래로
	$('#main-btns a:eq(2)').bind("click", function() {
		doActionMain("moveDown");
        return false;
	});
	// 메인관리 수정
	$('#main-btns a:eq(3)').bind("click", function() {
		doActionMain("modify");
        return false;
	});
	
	// 분류 코드 위로
	$('#cate-btns a:eq(0)').bind("click", function() {
		doActionCate("moveUp");
        return false;
	});
	// 분류 코드 아래로
	$('#cate-btns a:eq(1)').bind("click", function() {
		doActionCate("moveDown");
        return false;
	});
	// 분류 코드 수정
	$('#cate-btns a:eq(2)').bind("click", function() {
		doActionCate("modify");
        return false;
	});
	
	// 메타 순서 위로
	$('#meta-btns a:eq(0)').bind("click", function() {
		doActionMeta("moveUp");
        return false;
	});
	// 메타 순서 아래로
	$('#meta-btns a:eq(1)').bind("click", function() {
		doActionMeta("moveDown");
        return false;
	});
	// 메타 순서 수정
	$('#meta-btns a:eq(2)').bind("click", function() {
		doActionMeta("modify");
        return false;
	});
	// 메타 검색 버튼
	$('#meta-search-btn').bind("click", function() {
		doActionMeta("search");
        return false;
	});
	// 메타 검색 엔터
	$('#meta-search-word').bind("keydown", function(event) {
        if (event.which == 13) {
    		doActionMeta("search");
    		return false;
        }
    });
	// 컨텐츠 구분코드 변경 시
	$('#mainmng-insert-form select[name=homeTagCd]').change(function() {
		if($(this).val() == "FLINK") {
			$('.imgStar').hide();
			$('#flagLineDesc').show();
		} else {
			$('.imgStar').show();
			$('#flagLineDesc').hide();
		}
	});
}

// 메인화면관리 Sheet
function LoadMainPage() {
	var gridTitle = "NO"
				+ "|"
				+ "|서비스제목"
				+ "|"
				+ "|컨텐츠구분코드"
				+ "|시작일시"
				+ "|종료일시"
				+ "|연결URL"
				+ "|저장파일명"
				+ "|저장파일명(서브)"
				+ "|팝업여부"
				+ "|사용여부"
				+ "|출력순서"
				+ "|템플릿내용"
				+ "|"+label15;
    with(mainSheet){
    	                     
    	var cfg = {SearchMode:2,Page:50,VScrollMode:1};
        SetConfig(cfg);
        var headers = [
                    {Text:gridTitle, Align:"Center"}
                ];
        var headerInfo = {Sort:0,ColMove:1,ColResize:1,HeaderCheck:0};
        
        InitHeaders(headers, headerInfo);

        var cols = [
                     {Type:"Seq",		SaveName:"seq",				Width:70,	Align:"Center",		Edit:false}
					,{Type:"Text",		SaveName:"seqceNo",			Width:0,	Align:"Left",		Edit:false, Hidden:true}
					,{Type:"Text",		SaveName:"srvTit",			Width:400,	Align:"Left",		Edit:false}
					,{Type:"Text",		SaveName:"homeTagCd",			Width:0,	Align:"Center",		Edit:false, Hidden:true}
					,{Type:"Text",		SaveName:"homeTagNm",			Width:250,	Align:"Center",		Edit:false}
					,{Type:"Text",		SaveName:"strtDttm",			Width:150,	Align:"Center",		Edit:false}
					,{Type:"Text",		SaveName:"endDttm",			Width:150,	Align:"Center",		Edit:false}
					,{Type:"Text",		SaveName:"linkUrl",			Width:400,	Align:"Left",		Edit:false}
					,{Type:"Text",		SaveName:"saveFileNm",			Width:300,	Align:"Left",		Edit:false}
					,{Type:"Text",		SaveName:"subSaveFileNm",			Width:300,	Align:"Left",		Edit:false}
					,{Type:"Text",		SaveName:"popupYn",			Width:100,	Align:"Center",		Edit:false}
					,{Type:"Text",		SaveName:"useYn",			Width:100,	Align:"Center",		Edit:false}
					,{Type:"Text",		SaveName:"vOrder",			Width:0,	Align:"Left",		Edit:false, Hidden:true	}
					,{Type:"Text",		SaveName:"srvCont",			Width:0,	Align:"Left",		Edit:false, Hidden:true	}
                    ,{Type:"Status",	SaveName:"status",			Width:50,	Align:"Center"}
                ];                                          
        InitColumns(cols);
        FitColWidth();
        SetExtendLastCol(1);
    }
}
// 더블클릭
function mainSheet_OnDblClick(row, col, value, cellx, celly) {
	initInputValues();
	$('#mainmng-save-btn').text("수정");
	
	var data = mainSheet.GetRowJson(row);
	var form = $('#mainmng-insert-form');
	form.find('[name=seqceNo]').val(data.seqceNo);
	form.find('[name=srvTit]').val(data.srvTit);
	form.find('[name=homeTagCd]').val(data.homeTagCd);
	form.find('[name=strtDttm]').val(data.strtDttm);
	form.find('[name=endDttm]').val(data.endDttm);
	form.find('[name=linkUrl]').val(data.linkUrl);
	form.find('[name=saveFileNm]').val(data.saveFileNm);
	form.find('[name=subSaveFileNm]').val(data.subSaveFileNm);
	form.find('[name=file]').val("");
	form.find('[name=popupYn]').val(data.popupYn);
	form.find('[name=useYn]').val(data.useYn);
	form.find('[name=srvCont]').val(data.srvCont);
	
}


function doActionMain(sAction) {
	var classObj = $(".content"); //tab으로 인하여 form이 다건임
	var actObj = setTabForm(classObj); // 0: form data, 1: form 객체
	var formObj = $("form[name=admimMainMng]");
	
	switch(sAction) {                       
		case "save":
			
			if(validationChk()) {
				IBSpostJsonFile(
						$('#mainmng-insert-form')
						, ctxPath+"/admin/mainmng/saveMainMng.do"
						, function(data) {
							alert("저장되었습니다.");
							location.href = ctxPath + "/admin/mainmng/mainMngPage.do";
						}
				);
			}
			break;
		case "search":      //조회   
			ajaxBeforeSendAdmin(ctxPath+'/admin/ajaxBeforeSendAdmin.do');
			var param = {PageParam: "ibpage", Param: "onepagerow="+ibSheetPageNow+"&"+formObj.serialize()};
			console.log(param);
			mainSheet.DoSearchPaging(ctxPath+'/admin/mainmng/selectListMainMng.do', param);
			break;    
		case "modify":
			if ( !confirm("수정 하시겠습니까? ") ) {
				return;
  			}
			ibsSaveJson = mainSheet.GetSaveJson(0);                                          
			if(ibsSaveJson.data.length == 0) {
				alert("저장할 데이터가 없습니다.");  
				return;
			}
			var url = ctxPath + "/admin/mainmng/saveMainMngOrder.do";
			IBSpostJson(url, "", function() {
				alert("수정되었습니다.");
				location.href = ctxPath + "/admin/mainmng/mainMngPage.do";
			});/*
			$.post(url, {data: JSON.stringify(ibsSaveJson.data)}, function() {
				alert("수정되었습니다.");
				location.href = ctxPath + "/admin/mainmng/mainMngPage.do";
			});*/
			break;      
		case "moveUp":
			if(mainSheet.GetSelectRow() == -1){
				alert("항목을 선택하세요.")
			} else if(mainSheet.GetSelectRow() < 2){
				alert("첫 행입니다.");
			}  else {
				var selRow = mainSheet.GetSelectRow();	//선택된 Row 구하기
				mainSheet.DataMove(selRow-1, selRow);		//행 이동
				var selectedVOrder = mainSheet.GetRowJson(selRow).vOrder;
				var targetVOrder = mainSheet.GetRowJson(selRow-1).vOrder;
				mainSheet.SetCellValue(selRow, "vOrder", targetVOrder);
				mainSheet.SetCellValue(selRow-1, "vOrder", selectedVOrder);
			}
			break;
		case "moveDown":    
			if(mainSheet.GetSelectRow() == -1){
				alert("항목을 선택하세요.")
			} else if(mainSheet.GetSelectRow() >= mainSheet.RowCount()){
				alert("마지막 행입니다.");
			} else {
				var selRow = mainSheet.GetSelectRow();	//선택된 Row 구하기
				mainSheet.DataMove(selRow+2, selRow);		//행 이동
				var selectedVOrder = mainSheet.GetRowJson(selRow).vOrder;
				var targetVOrder = mainSheet.GetRowJson(selRow+1).vOrder;
				mainSheet.SetCellValue(selRow, "vOrder", targetVOrder);
				mainSheet.SetCellValue(selRow+1, "vOrder", selectedVOrder);
			}   
			break;
		case "remove":
			var data = mainSheet.GetRowJson(mainSheet.GetSelectRow());
			if(confirm("["+data.srvTit + "]을(를) 삭제하시겠습니까?")) {
				$.post("/admin/mainmng/deleteMainMng.do", {seqceNo : data.seqceNo}, function() {
					alert("삭제되었습니다.");
					location.href = ctxPath + "/admin/mainmng/mainMngPage.do";
				});
			}
			break;
	}
}
function validationChk() {
	var form = $('#mainmng-insert-form');
	if(form.find("[name=srvTit]").val() == "") {
		alert("서비스제목을 입력해주세요.");
		form.find("[name=srvTit]").focus();
		return false;
	}
	var strtDttm = form.find("[name=strtDttm]");
	var endDttm = form.find("[name=endDttm]");
	if(strtDttm.val() == "") {
		alert("시작일을 입력해주세요.");
		strtDttm.focus();
		return false;
	}
	if(endDttm.val() == "") {
		alert("종료일을 입력해주세요.");
		endDttm.focus();
		return false;
	}
	if(parseInt(strtDttm.val().replace(/-/gi, "")) > parseInt(endDttm.val().replace(/-/gi, ""))) {
		alert("시작일이 종료일보다 이후입니다.");
		strtDttm.focus();
		return false;
	}
	if(form.find("[name=linkUrl]").val() == "" && form.find("[name=homeTagCd]").val() != "FLINK") {
		alert("연결URL을 입력해주세요.");
		form.find("[name=linkUrl]").focus();
		return false;
	}
	
	var homeTagCd = form.find("[name=homeTagCd]").val();
	// 이미지는 화면 하단 링크가 아닐때만 등록 가능
	if(homeTagCd != "FLINK" && homeTagCd != "TEXTA" && homeTagCd != "TEXTB" && homeTagCd != "TLINKA" && homeTagCd != "TLINKB") {
		if(form.find("[name=saveFileNm]").val() == "") {
			alert("이미지를 첨부해주세요.");
			return false;
		}
		var fileExt = getFileExt(form.find("[name=file]").val());
		if(form.find("[name=file]").val() != "" && fileExt.toLowerCase() != "jpg" && fileExt.toLowerCase() != "jpeg" && fileExt.toLowerCase() != "gif" && fileExt.toLowerCase() != "png"){
			alert("이미지 파일[jpg/jpeg, gif, png]만 첨부가능 합니다.");
	        return false;
		}
		/*
		if(form.find("[name=subSaveFileNm]").val() == "") {
			alert("서브이미지를 첨부해주세요.");
			return false;
		}
		var fileExt = getFileExt(form.find("[name=file1]").val());
		if(form.find("[name=file1]").val() != "" && fileExt.toLowerCase() != "jpg" && fileExt.toLowerCase() != "jpeg" && fileExt.toLowerCase() != "gif" && fileExt.toLowerCase() != "png"){
			alert("이미지 파일[jpg/jpeg, gif, png]만 첨부가능 합니다.");
	        return false;
		}*/
	}
	
	return true;
}
function initInputValues() {
	$('#mainmng-save-btn').text("등록");
	
	var form = $('#mainmng-insert-form');
	form.find('[name=seqceNo]').val("");
	form.find('[name=srvTit]').val("");
	form.find('[name=homeTagCd]').val(form.find('[name=homeTagCd] option:eq(0)').val());
	form.find('[name=strtDttm]').val("");
	form.find('[name=endDttm]').val("");
	form.find('[name=linkUrl]').val("");
	form.find('[name=saveFileNm]').val("");
	form.find('[name=subSaveFileNm]').val("");
	form.find('[name=file]').val("");
	form.find('[name=file1]').val("");
	form.find('[name=popupYn]').val("N");
	form.find('[name=useYn]').val("Y");
	
}


// 분류관리 Sheet
function LoadCatePage() {
	var gridTitle ="NO";
		gridTitle +="|"+label00;
		gridTitle +="|"+label01;
		gridTitle +="|"+label02;
		gridTitle +="|"+label15;
		
    with(cateSheet){
    	                     
    	var cfg = {SearchMode:2,Page:50,VScrollMode:1};
        SetConfig(cfg);
        var headers = [
                    {Text:gridTitle, Align:"Center"}
                ];
        var headerInfo = {Sort:0,ColMove:1,ColResize:1,HeaderCheck:0};
        
        InitHeaders(headers, headerInfo);
       
        var cols = [
                     {Type:"Seq",		SaveName:"seq",				Width:30,	Align:"Center",		Edit:false}
					,{Type:"Text",		SaveName:"cateId",			Width:60,	Align:"Center",		Edit:false}
					,{Type:"Text",		SaveName:"cateNm",			Width:300,	Align:"Left",		Edit:false}
					,{Type:"Text",		SaveName:"vOrder",			Width:50,	Align:"Left",		Edit:false, Hidden:true	}
                    ,{Type:"Status",	SaveName:"status",			Width:50,	Align:"Center",		Hidden:false	}
                ];                                          
        InitColumns(cols);
        FitColWidth();
        SetExtendLastCol(1);
//        SetColProperty("niaId", niaId );    //InitColumns 이후에 셋팅
    }               
    default_sheet(cateSheet);                                         
    cateSheet.SetCountPosition(0);          	
    cateSheet.SetFocusAfterProcess(0);
}         

/*분류코드 Sheet 각종 처리*/
function doActionCate(sAction) {
	switch(sAction) {                       
		case "search":      //조회   
			ajaxBeforeSendAdmin(ctxPath+'/admin/ajaxBeforeSendAdmin.do'); //IbSheet 조회전 세션 체크
			var param = {PageParam: "ibpage", Param: "onepagerow="+ibSheetPageNow};
			cateSheet.DoSearchPaging(ctxPath+'/admin/mainmng/selectListCate.do', param);
			break;          
		case "modify":      // 수정 : 순서변경저장
			if ( !confirm("수정 하시겠습니까? ") ) {
				return;
  			}
			ibsSaveJson = cateSheet.GetSaveJson(0);                                          
			if(ibsSaveJson.data.length == 0) {
				alert("저장할 데이터가 없습니다.");  
				return;
			}
			var url = ctxPath + "/admin/mainmng/saveCateOrder.do";
			IBSpostJson(url, "", function() {
				alert("수정되었습니다.");
				location.href = ctxPath + "/admin/mainmng/mainMngPage.do";
			});
			break;
		case "moveUp":  
			if(cateSheet.GetSelectRow() == -1){
				alert("항목을 선택하세요.")
			} else if(cateSheet.GetSelectRow() < 2){
				alert("첫 행입니다.");
			}  else {
				var selRow = cateSheet.GetSelectRow();	//선택된 Row 구하기
				cateSheet.DataMove(selRow-1, selRow);		//행 이동
				var selectedVOrder = cateSheet.GetRowJson(selRow).vOrder;
				var targetVOrder = cateSheet.GetRowJson(selRow-1).vOrder;
				cateSheet.SetCellValue(selRow, "vOrder", targetVOrder);
				cateSheet.SetCellValue(selRow-1, "vOrder", selectedVOrder);
			}
			break;                 
		case "moveDown":         
			if(cateSheet.GetSelectRow() == -1){
				alert("항목을 선택하세요.")
			} else if(cateSheet.GetSelectRow() >= cateSheet.RowCount()){
				alert("마지막 행입니다.");
			} else {
				var selRow = cateSheet.GetSelectRow();	//선택된 Row 구하기
				cateSheet.DataMove(selRow+2, selRow);		//행 이동
				var selectedVOrder = cateSheet.GetRowJson(selRow).vOrder;
				var targetVOrder = cateSheet.GetRowJson(selRow+1).vOrder;
				cateSheet.SetCellValue(selRow, "vOrder", targetVOrder);
				cateSheet.SetCellValue(selRow+1, "vOrder", selectedVOrder);
			}   
			break;
	}           
}       

// 메타관리 Sheet
function LoadMetaPage() {
	//message-common_ko_KR.properties 선언 후 사용 or message-common_en_US.properties 선언 후 사용
	var gridTitle = "NO";
		gridTitle +="|"+label03;  
		gridTitle +="|"+label04;
		gridTitle +="|"+label05;
		gridTitle +="|"+label06;
		gridTitle +="|"+label07;
		gridTitle +="|"+label08;
		gridTitle +="|"+label09;
		gridTitle +="|"+label10;
		gridTitle +="|"+label11;
		gridTitle +="|"+label12;
		gridTitle +="|"+label13;
		gridTitle +="|"+label14;
		gridTitle +="|"+label15;
	
    with(metaSheet){
    	                      
    	var cfg = {SearchMode:2,Page:50,VScrollMode:1};                                 
        SetConfig(cfg);   
        var headers = [                                             
                    {Text:gridTitle, Align:"Center"}                 
                ];
        var headerInfo = {Sort:0,ColMove:1,ColResize:1,HeaderCheck:0};
        
        InitHeaders(headers, headerInfo); 
         
        var cols = [          
					 {Type:"Seq",		SaveName:"seq",				Width:70,	Align:"Center",		Edit:false,  Sort:false}
					,{Type:"Text",		SaveName:"infId",			Width:0,	Align:"Center",		Edit:false, Hidden:true}
					,{Type:"Text",		SaveName:"dtNm",			Width:0,	Align:"Left",		Edit:false, Hidden:true}
					,{Type:"Text",		SaveName:"infNm",			Width:550,	Align:"Left",		Edit:false}
					,{Type:"Text",		SaveName:"cclNm",			Width:0,	Align:"Left",		Edit:false, Hidden:true}
					,{Type:"Text",		SaveName:"fvtDataOrder",			Width:200,	Align:"Left",		Edit:true}
					,{Type:"Text",		SaveName:"vOrder",			Width:0,	Align:"Center",		Edit:false,Hidden:true}
					,{Type:"Text",		SaveName:"cateFullnm",	Width:0,	Align:"Left",		Edit:false, Hidden:true}
					,{Type:"Text",		SaveName:"useOrgCnt",			Width:00,	Align:"Center",		Edit:false, Hidden:true}
					,{Type:"Text",		SaveName:"openDttm",			Width:150,	Align:"Center",		Edit:false}
					,{Type:"Combo",		SaveName:"infState",			Width:0,	Align:"Left",		Edit:false, Hidden:true}
					,{Type:"Html",		SaveName:"openSrv",			Width:300,	Align:"Left",		Edit:false}
					,{Type:"Text",		SaveName:"aprvProcYn",			Width:0,	Align:"Left",		Edit:false, Hidden:true}
					, {Type:"Status",	SaveName:"status",				Width:15,	Align:"Center",		Edit:false}
                ];       
                                      
        InitColumns(cols);                                                                           
        SetExtendLastCol(1);   
    }               
    default_sheet(metaSheet); 
    metaSheet.SetCountPosition(0);
    metaSheet.SetFocusAfterProcess(0);
}

function doActionMeta(sAction)  {
	switch(sAction) {                    
		case "search":      //조회   
			ajaxBeforeSendAdmin(ctxPath+'/admin/ajaxBeforeSendAdmin.do'); //IbSheet 조회전 세션 체크
			var param = {PageParam: "ibpage", Param: "onepagerow="+ibSheetPageNow+"&searchWord="+$('#meta-search-word').val()};
			metaSheet.DoSearchPaging(ctxPath+'/admin/mainmng/openMetaOrderPageListAllMainTree.do', param);
			break;
		case "modify":      // 수정 : 순서변경저장
			if ( !confirm("수정 하시겠습니까? ") ) {   
				return;
  			}
			//setDsId();
			ibsSaveJson = metaSheet.GetSaveJson(0);    
			if(ibsSaveJson.data.length == 0) {
				alert("저장할 데이터가 없습니다.");  
				return;
			}
			var url = ctxPath+'/admin/mainmng/openMetaOrderBySave.do';
			IBSpostJson(url, "", function() {
				alert("수정되었습니다.");
				location.href = ctxPath + "/admin/mainmng/mainMngPage.do";
			});
			break;   
		case "moveUp":   
			if(metaSheet.GetSelectRow() == -1){
				alert("항목을 선택하세요.")
			} else if(metaSheet.GetSelectRow() < 2){
				alert("첫 행입니다.");
			} else {
				var selRow = metaSheet.GetSelectRow();	//선택된 Row 구하기
				metaSheet.DataMove(selRow-1, selRow);		//행 이동
				setOrder(metaSheet);	//순서 재설정
			}
			break;
		case "moveDown":
			if(metaSheet.GetSelectRow() == -1){
				alert("항목을 선택하세요.")
			} else if(metaSheet.GetSelectRow() >= metaSheet.RowCount()){
				alert("마지막 행입니다.");
			} else {
				var selRow = metaSheet.GetSelectRow();	//선택된 Row 구하기
				metaSheet.DataMove(selRow+2, selRow);		//행 이동
				setOrder(metaSheet);	//순서 재설정
			}
			break;
	}           
}       
function setOrder(objId){
	var order = 1;
	var tmpOrder = "";
	for(var i=1; i<=objId.LastRow(); i++){
		tmpOrder= "vOrder";
		objId.SetCellValue(i,tmpOrder, order);
		order++;
	};
}

function fncFileChange2() {
	var formObj = $("form[name=mainmng-insert-form]");
	val = formObj.find("input[id=file]").val().split("\\");
	fileName = val[val.length-1];
	f_name = fileName.substring(0, fileName.indexOf("."));
	s_name = fileName.substring(fileName.length-3, fileName.length);
	formObj.find("input[id=saveFileNm]").val(fileName);
}

function fncFileChange3() {
	var formObj = $("form[name=mainmng-insert-form]");
	val2 = formObj.find("input[id=file1]").val().split("\\");
	fileName2 = val2[val2.length-1];
	f_name2 = fileName2.substring(0, fileName2.indexOf("."));
	s_name2 = fileName2.substring(fileName2.length-3, fileName2.length);
	formObj.find("input[id=subSaveFileNm]").val(fileName2);
}
