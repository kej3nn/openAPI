
/*
 * @(#)instMgmt.js 1.0 2019/08/27
 */

/**
 * 기관관리 스크립트 파일이다
 *
 * @author 정인선
 * @version 1.0 2019/08/27
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


////////////////////////////////////////////////////////////////////////////////
// 초기화 함수
////////////////////////////////////////////////////////////////////////////////
/**
 * 컴포넌트를 초기화한다.
 */
function initComp() {
	   
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
	
	//초기화
	$("a[name=a_init]").bind("click", function(event) {
		doAction("init");
    });
	//저장
	$("a[name=a_reg]").bind("click", function(event){
		doAction("insert");
	});
}


/**
 * 옵션을 로드한다.
 */
function loadOptions() {
}

/**
 * 데이터를 로드한다.
 */
function loadData() {
	ajaxBeforeSendAdmin(com.wise.help.url("/admin/ajaxBeforeSendAdmin.do")); //IbSheet 조회전 세션 체크
	doAction("search");
}

////////////////////////////////////////////////////////////////////////////////
// 서비스 함수
////////////////////////////////////////////////////////////////////////////////

/**
 * 화면 액션
 */
function doAction(sAction) {
	var formObj = $("form[name=adminInstMgmtInfo]");
	switch(sAction) {                       
		case "search": //목록조회
			var param = {PageParam: "ibpage", Param: "onpagerow=50"+"&"+$("form[name=adminInstMgmtList]").serialize()};
			sheet.DoSearchPaging(com.wise.help.url("/admin/expose/instMgmtListTree.do"), param);
			break;
		case "insert": //신규등록
			saveData("I");
			break;
		case "init": //초기화
			var formObj = $("form[name=adminInstmgmtinfo]");
			
			$("input[name=instCd]").css({display:"none"});
			$("input[name=instNm]").css({display:"none"});
			$("span[name=instText]").html("위 기관을 더블클릭 하세요.");
			$("input[name=instRdt]").val("");
			$("input[name=instBankNm]").val("");
			$("input[name=instAccNm]").val("");
			$("input[name=instAccNo]").val("");
			$("input[name=instOrd]").val("");
			$("input[name=instPno]").val("");
			$("input[name=inscfNm]").val("");
			$("input[name=instChrgDeptNm]").val("");
			$("input[name=instChrgCentCgp1Nm]").val("");
			$("input[name=instChrgCentCgp2Nm]").val("");
			$("input[name=instChrgCentCgp3Nm]").val("");
			$("input[name=instFaxNo]").val("");
			$("input[name=instOfslFlNm]").val("");
			$("#instImg").removeAttr('src');
						
			break;
		}
	}
function saveData(action){
	
	var formObj = $("form[name=adminInstMgmtInfo]");
	formObj.ajaxSubmit({
		url : com.wise.help.url("/admin/expose/instMgmtReg.do")
		, async : false
		, type : 'post'
		, dataType : 'json'
		, contentType : 'application/x-www-form-urlencoded;charset=UTF-8'
		, beforeSubmit : function() {
			
			//submit 전 validation 체크
			if ( saveValidation(action) ) {
				if(!confirm("기관정보를 등록 하시겠습니까?")) return false;
			} else {
				return false;
			}
		}
		, success : function(res, status){
			doAjaxMsg(res, "");
			location.reload();
		}
		, error: function(jqXHR, textStatus, errorThrown){
			alert("처리 도중 에러가 발생하였습니다.");
		}
	});
}

////////////////////////////////////////////////////////////////////////////////
//시트 로드
////////////////////////////////////////////////////////////////////////////////
function loadSheet() {
	
	createIBSheet2(document.getElementById("sheet"),"sheet", "100%", "200px");
	
	var gridTitle ="NO";
	gridTitle +="|상태";
	gridTitle +="|기관코드";
	gridTitle +="|기관명";
	gridTitle +="|기관장명";
	gridTitle +="|전화번호";
	gridTitle +="|FAX 번호";
	gridTitle +="|담당부서";
	gridTitle +="|은행명";
	gridTitle +="|예금주";
	gridTitle +="|계좌번호";
	gridTitle +="|순서";
	
	
	with(sheet){
		                     
		var cfg = {SearchMode:2,Page:50,VScrollMode:1}; 
	    SetConfig(cfg);
	   var headers = [
	                {Text:gridTitle, Align:"Center"}
	            ];
	    var headerInfo = {Sort:1,ColMove:0,ColResize:1,HeaderCheck:1};
	    
	    InitHeaders(headers, headerInfo);
	   
	    var cols = [
	                 {Type:"Seq",		SaveName:"seq",					Width:20,	Align:"Center",		Edit:false}
	                ,{Type:"Status",	SaveName:"status",				Width:30,	Align:"Center",		Edit:false,	Hidden:true}
	                ,{Type:"Text",	    SaveName:"instCd",				Width:150,	Align:"Center",		Edit:false,	Hidden:false} 
	                ,{Type:"Text",		SaveName:"instNm",				Width:150,	Align:"Center",		Edit:false,	Hidden:false}
	                ,{Type:"Text",		SaveName:"inscfNm",			Width:150,	Align:"Center",		Edit:false,	Hidden:false}
	                ,{Type:"Text",		SaveName:"instPno",				Width:150,	Align:"Center",		Edit:false,	Hidden:false}
	                ,{Type:"Text",		SaveName:"instFaxNo",			Width:150,	Align:"Center",		Edit:false,	Hidden:false}
	                ,{Type:"Text",		SaveName:"instChrgDeptNm",	Width:150,	Align:"Center",		Edit:false,	Hidden:false}
	                ,{Type:"Text",		SaveName:"instBankNm",		Width:150,	Align:"Center",		Edit:false,	Hidden:false}
	                ,{Type:"Text",		SaveName:"instAccNm",			Width:150,	Align:"Center",		Edit:false,	Hidden:false}
	                ,{Type:"Text",		SaveName:"instAccNo",			Width:150,	Align:"Center",		Edit:false,	Hidden:false}
	                ,{Type:"Text",		SaveName:"instOrd",				Width:150,	Align:"Center",		Edit:false,	Hidden:true}
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
	
	doAction("init");
	   
	   $("input[name=instCd]").css({display:"block"});
	   $("input[name=instNm]").css({display:"block"});
	   $("input[name=instCd]").attr("readonly", true).addClass("readonly", true);
	   $("input[name=instNm]").attr("readonly", true).addClass("readonly", true);
	   $("span[name=instText]").html("");
	   
	   var formObj = $("form[name=adminInstMgmtInfo]");
	   
	   var param = "instCd="+sheet.GetCellValue(row, "instCd");
	   formObj.find("[name=instCd]").val(sheet.GetCellValue(row,"instCd")).change();
	   formObj.find("[name=instNm]").val(sheet.GetCellValue(row,"instNm")).change();
	   
	   $.ajax({
		    url: com.wise.help.url("/admin/expose/instMgmtRetr.do"),
		    async: false, 
		    type: 'POST', 
		    data: param,
		    dataType: 'json',
		    beforeSend: function(obj) {
		    }, // 서버 요청 전 호출 되는 함수 return false; 일 경우 요청 중단
		    success: function(data) {

		    	var isImage = false; // 직인이미지 등록 여부
		    	$.each(data.data, function(key,kData){
	    			if(key != 'instOfslFlPhNm'){
	    				formObj.find("[name="+ key + "]").val(kData).change();
	    			}else{
	    				if(kData != null)	isImage = true;
	    			}
		    	});
		    	
		    	if(isImage){
		    		//직인 이미지 표시
		    		formObj.find("#instImg").attr("src", "/admin/expose/selectInstMgmtThumbnail.do?" + "instCd=" + $("#instCd").val() + "&instOfslFlPhNm=" + $("#instOfslFlPhNm").val());
		    	}
				
				
		    }, // 요청 완료 시
		    error: function(request, status, error) {
		    	handleError(status, error);
		    }, // 요청 실패.
		    complete: function(jqXHR) {} // 요청의 실패, 성공과 상관 없이 완료 될 경우 호출
		});
	   
	   
}
function sheet_OnSearchEnd(code, message, statusCode, statusMessage) {
	
}

////////////////////////////////////////////////////////////////////////////////
//Validation 함수
////////////////////////////////////////////////////////////////////////////////
/**
* 등록/수정 validation 
*/
function saveValidation(action) {
		
	if ( com.wise.util.isNull($("#inscfNm").val()) ) {
		alert("기관장명을 입력하세요.");
		$("#inscfNm").focus();
		return false;
	}
	if ( com.wise.util.isNull($("#instPno").val()) ) {
		alert("전화번호를 입력하세요.");
		$("#instPno").focus();
		return false;
	}
	if ( com.wise.util.isNull($("#instFaxNo").val()) ) {
		alert("FAX번호를 입력하세요.");
		$("#instFaxNo").focus();
		return false;
	}
	if ( com.wise.util.isNull($("#instChrgDeptNm").val()) ) {
		alert("담당부서를 입력하세요.");
		$("#instChrgDeptNm").focus();
		return false;
	}
	if ( com.wise.util.isNull($("#instChrgCentCgp1Nm").val()) ) {
		alert("결재권자1을 입력하세요.");
		$("#instChrgCentCgp1Nm").focus();
		return false;
	}
	if ( !com.wise.util.isNull($("#instOfslFlPhNm").val()) ) {
		var ext = $("#instOfslFlPhNm").val().split('.').pop().toLowerCase();
		
		if($.inArray(ext, ['gif','png','jpg','jpeg', 'bmp']) == -1) {
			 alert('gif, png, jpg, jpeg, bmp 파일만 업로드 할수 있습니다.');
			 return false;
		}
	}
	
	return true;
}
