/*
 * @(#)stfopeninf.js 1.0 2019/09/09
 */

/**
 * 관리자에서 정보 카달로그를 관리하는 스크립트
 *
 * @author 
 * @version 1.0 2019/07/29
 */
$(function() {
    // 컴포넌트를 초기화한다.
    initComp();
    
    // 마스크를 바인딩한다.
    //bindMask();
    
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
	tabSet();
	// 시트 그리드를 생성한다.
	loadSheet();
	
}

/**
 * 이벤트를 바인딩한다.
 */
function bindEvent() {
	
	
	$("button[name=btn_inquiry]").bind("click", function(e) {
		doAction("search");
    });
	
	//조회 enter
	$("input[name=searchVal]").bind("keydown", function(e) {
        // 엔터키인 경우
        if (e.which == 13) {
        	doAction("search");
            return false;
        }
    });
	
	
}

/**
 * 데이터를 로드한다.
 */
function loadData() {
	doAction("search");
}


/**
 * 옵션을 로드한다.
 */
function loadOptions() {
	
}

/**
 * 화면 액션
 */
function doAction(sAction) {
	var mainFormObj = $("form[name=stfopeninfMainForm]");
	var formObj = getTabFormObj("stfopeninf-dtl-form");
	var sheet = window["sheet"];

	switch(sAction) {                       
		case "search":
			ajaxBeforeSendAdmin(com.wise.help.url("/admin/ajaxBeforeSendAdmin.do")); //IbSheet 조회전 세션 체크
			var param = {PageParam: "page", Param: "rows=50"+"&"+mainFormObj.serialize()};
			sheet.DoSearchPaging(com.wise.help.url("/admin/openinf/selectSftOpenInfListPaging.do"), param);
			break;
		case "regForm" :
			var title = "신규등록"
			var id ="siteMapReg";
			openTab.addRegTab(id, title, tabCallRegBack);
			break;
		case "catePop" :
			var url = com.wise.help.url("/admin/openinf/popup/naSetCateSearchPop.do");
			var data = "?parentFormNm=stfopeninfMainForm";
			openIframeStatPop("iframePopUp", url+data, 660, 530);
			break;
		case "naSetCatePop" :
			var url = com.wise.help.url("/admin/openinf/popup/naSetCatePop.do");
			var data = "?parentFormNm=stfopeninf-dtl-form";
			wWidth ="660";                                                    
			wHeight ="530";   
			openIframeStatPop("iframePopUp", url+data, wWidth, wHeight)
			break;	
		case "dupChk" : 
			doPost({
                url:"/admin/openinf/stfopeninfDupChk.do",
                before : beforeNaDataSiteMapDupChk,
                after : afterNaDataSiteMapDupChk
            });
			break;
		case "update" :
			saveData("U");
			break;
		case "statPreviewPop" :	//통계표 미리보기 팝업
			window.open(com.wise.help.url("/portal/data/service/selectServicePage.do") + "?infId=" + formObj.find("input[name=infId]").val() , "list", "fullscreen=no, width=1152, height=768, scrollbars=yes");
			break;
	}
}

/**
 * 통계표 분류 데이터 저장
 * @param action	I:등록 / U:수정
 */
function saveData(action) {
	var formObj = getTabFormObj("stfopeninf-dtl-form");
	formObj.ajaxSubmit({
		url : com.wise.help.url("/admin/openinf/saveStfopeninf.do")
		, async : false
		, type : 'post'
		, dataType: 'json' 
		, contentType : 'application/x-www-form-urlencoded;charset=UTF-8'
		, beforeSubmit : function() {
			//submit 전 validation 체크
			if ( saveValidation(action) ) {
				if ( !confirm("저장 하시겠습니까?") )	return false;
			} else {
				return false;
			}
		}	
		, success : function(res, status) {
			doAjaxMsg(res, "");
			afterTabRemove(res)
		}
		, error: function(jqXHR, textStatus, errorThrown) {
			alert("처리 도중 에러가 발생하였습니다.");
		}
	});
}
////////////////////////////////////////////////////////////////////////////////
//전처리 함수
////////////////////////////////////////////////////////////////////////////////
/**
* 사이트맵ID 중복체크 전처리 함수
*/
function beforeNaDataSiteMapDupChk(options) {
	var formObj = getTabFormObj("stfopeninf-dtl-form");
	var infId = formObj.find("input[name=infId]").val().trim().toUpperCase();
 var data = {
     "infId" : infId
 };
 if ( com.wise.util.isBlank(data.infId) ) {
 	alert("서비스맵ID를 입력하세요.");
 	formObj.find("input[name=infId]").focus();
     return null;
 }
 
 formObj.find("input[name=infId]").val(infId);	//소문자로 입력되어있을경우 대문자로 변경해서 보여줌
 
 if ( !com.wise.util.isAlphaNumeric(data.infId) || !com.wise.util.isLength(data.infId, 1, 10) ) {
 	alert("영문, 숫자 10자리 이내로 입력하세요.");
 	formObj.find("input[name=infId]").val("").focus();
     return null;
 }
 
 return data;
}
////////////////////////////////////////////////////////////////////////////////
//후처리 함수
////////////////////////////////////////////////////////////////////////////////
//상세 탭 이벤트 후처리
function tabFunction(tab, data) {
	var formObj = getTabFormObj("stfopeninf-dtl-form");
	formObj.find("button[name=stfopeninfInfoId_dup]").hide();			//중복확인 버튼 숨김(수정못함)
	formObj.find("input[name=dupChk]").val("Y");				//중복체크 Y로
	formObj.find("input[name=infId]").attr("readonly", true);	//분류ID 수정 못하도록 변경
	
	//이미지 표시
	formObj.find("#tmnlImgFileImg").attr("src", "/admin/openinf/selectThumbnail.do?" + "infId=" + data.DATA.infId );

	var obj1 = formObj.find("input[name=infNm]");
	var obj2 = formObj.find("input[name=dataCondDttm]");
	var obj3 = formObj.find("input[name=infTag]");
	var obj4 = formObj.find("textarea[name=infExp]");
	textAreaLenChk(obj1, 'len1', 300);
	textAreaLenChk(obj2, 'len2', 100);
	textAreaLenChk(obj3, 'len3', 1000);
	textAreaLenChk(obj4, 'len4', 4000);
}

/**
* 데이터 저장 완료 후
*/
function sheet_OnLoadData(data) {
	var data = JSON.parse(data);
	if ( data.success != null) {
		//시트 분류명 저장이 성공적으로 완료된 경우
		alert(data.success.message);
		doAction("search");
	}
}


/**
* 사이트맵ID 중복체크 후처리
* @param data	return value
*/
function afterNaDataSiteMapDupChk(data) {
	var formObj = getTabFormObj("stfopeninf-dtl-form");
	if ( data.dupCnt > 0 ) {
		alert("중복되는 ID가 있습니다.\n다른 ID를 입력해 주세요.");
		formObj.find("input[name=infId]").focus();
		formObj.find("input[name=dupChk]").val("N");
	} else {
		alert("사용가능한 ID 입니다.");
		formObj.find("input[name=dupChk]").val("Y");
		formObj.find("input[name=infId]").attr("readonly", true);	//중복체크 완료 후 단위ID변경 불가
	}
}



////////////////////////////////////////////////////////////////////////////////
// 탭 관련 함수들
////////////////////////////////////////////////////////////////////////////////
function tabSet(){   
	openTab = new OpenTab(tabId,tabContentClass,tabBody); //headinclude.jsp 변수 있음
	openTab.TabObj = openTab;  
	openTab.addTabClickEvent();            
}

//탭 버튼 이벤트
function buttonEventAdd() {
	setTabButton();     
}
//등록 탭 이벤트
function regUserFunction() {
	var formObj = getTabFormObj("stfopeninf-dtl-form");
	formObj.find("input[name=infId]").attr("readonly", false).removeClass("readonly");
	formObj.find("input[name=useYn][value=Y]").prop("checked", true);
}
//상세 탭 이벤트
function tabEvent(row){//탭 이벤트 실행  
	var title = sheet.GetCellValue(row, "infNm");//탭 제목
	var id = sheet.GetCellValue(row, "infId");//탭 id(유일한key))
	openTab.SetTabData(sheet.GetRowJson(row));//db data 조회시 조건 data
	var url =  com.wise.help.url('/admin/openinf/stfopeninfDtl.do'); // Controller 호출 url 
	openTab.addTab(id, title, url, tabCallBack); 	// 탭 추가 시작함
} 



////////////////////////////////////////////////////////////////////////////////
//시트 서비스 함수
////////////////////////////////////////////////////////////////////////////////


function sheet_OnDblClick(row, col, value, cellx, celly) {
	if(row < 1) return;                                         
	    tabEvent(row);
}

function sheet_OnSearchEnd(code, message, statusCode, statusMessage) {
	//toggleShowHideOrderBtn("statMainForm");		//조회 후 순서관련 버튼 숨김
}

//바이트 체크
function byteCheck(val, name){
	var objTab = getTabShowObj();//탭이 oepn된 객체가져옴
	var formObj = objTab.find("form[name=stfopeninf-dtl-form]");
	
	var temp_estr = escape(val);
	var s_index = 0;
	var e_index = 0;
	var temp_str = "";
	var cnt = 0;
	while((e_index = temp_estr.indexOf("%u", s_index)) >=0){
		temp_str += temp_estr.substring(s_index, e_index);
		s_index = e_index + 6;
		cnt ++;;
	}
	temp_str += temp_estr.substring(s_index);
	temp_str = unescape(temp_str);
	formObj.find("input[name="+name+"]").val( ((cnt *2) + temp_str.length));
	return ((cnt *2) + temp_str.length);
}

//텍스트박스 글자수 체크
function textAreaLenChk(obj, name, len){
	rtn = byteCheck(obj.val(), name);
	if(rtn > len){
	  alert(len+'byte 이상 초과 할 수 없습니다.');
	  for(var i=rtn; i > len; i--){
		  obj.val(trim(obj.val()).substring(0, obj.val().length-1));
		  if(byteCheck(obj.val(), name) <= len){
		  	break;
		  }
	  }
		rtn = byteCheck(obj.val(), name);
	  return;
	}
}

////////////////////////////////////////////////////////////////////////////////
//이벤트 함수
////////////////////////////////////////////////////////////////////////////////
/**
* 탭 이벤트를 바인딩한다.
*/
function setTabButton() {
	var formObj = getTabFormObj("stfopeninf-dtl-form");
	
	formObj.find("a[name=a_reg]").bind("click", function(e) {
		// 등록
		doAction("insert");
  });
	formObj.find("a[name=a_modify]").bind("click", function(e) {
		// 수정
		doAction("update");
  });
	formObj.find("a[name=a_del]").bind("click", function(e) {
		// 삭제
		doAction("delete");
  });
	formObj.find("button[name=stfopeninfInfoId_dup]").bind("click", function() {
		//사이트맵ID 중복체크
		doAction("dupChk");
	});
	formObj.find("input[name=infId]").keypress(function(e) {
		  if(e.which == 13) {
			  doAction('dupChk');   
			  return false;        
		  }
	});
	//통계표 팝업
	formObj.find("button[name=statPreview_pop]").bind("click", function(e) {
		doAction("statPreviewPop");
	});
	
	formObj.find("button[name=naSetCate_pop]").bind("click", function() {
		//분류 팝업
		doAction("naSetCatePop");
	});
	
	formObj.find("select[name=cclCd]").bind("change", function() {
		//분류 팝업
		var html = "";
		if (this.value == 2001){
			
			html += "<img src=\"/images/copyright01.gif\" alt=\"공공누리-공공저작물 자유 이용허락 : 출처표시\">";
		} else if(this.value == 2002){
			html += "<img src=\"/images/copyright02.gif\" alt=\"공공누리-공공저작물 자유 이용허락 : 출처표시, 상업용금지\">";
		} else if(this.value == 2003){
			html += "<img src=\"/images/copyright03.gif\" alt=\"공공누리-공공저작물 자유 이용허락 : 출처표시, 변경금지\">";
		} else if(this.value == 2004){
			html += "<img src=\"/images/copyright04.gif\" alt=\"공공누리-공공저작물 자유 이용허락 : 출처표시, 상업용금지, 변경금지\">";
		}
		formObj.find("td[name=changeImg]").empty();
		formObj.find("td[name=changeImg]").append(html);
			
	});
	
	//공공데이터명
	formObj.find("input[name=infNm]").bind("keyup", function(event) {
		var obj = formObj.find("input[name=infNm]");
		textAreaLenChk(obj, 'len1', 300);
	});
	//공개시기
	formObj.find("input[name=dataCondDttm]").bind("keyup", function(event) {
		var obj = formObj.find("input[name=dataCondDttm]");
		textAreaLenChk(obj, 'len2', 100);
	});
	//검색태그
	formObj.find("input[name=infTag]").bind("keyup", function(event) {
		var obj = formObj.find("input[name=infTag]");
		textAreaLenChk(obj, 'len3', 1000);
	});
	//설명
	formObj.find("textarea[name=infExp]").bind("keyup", function(event) {
		var obj = formObj.find("textarea[name=infExp]");
		textAreaLenChk(obj, 'len4', 4000);
	});
	
	
}


////////////////////////////////////////////////////////////////////////////////
//시트 로드
////////////////////////////////////////////////////////////////////////////////
function loadSheet() {
	
createIBSheet2(document.getElementById("sheet"),"sheet", "100%", "350px");	// InfoSetMain Sheet
	
	var gridTitle = "NO|공공데이터ID|공공데이터명|분류|담당부서|이용허락조건|개방일";
	
	with(sheet){
        
		var cfg = {SearchMode:3,Page:50,VScrollMode:1};
	    SetConfig(cfg);
	    var headers = [
	                {Text:gridTitle, Align:"Center"}
	            ];
	    var headerInfo = {Sort:1,ColMove:1,ColResize:1,HeaderCheck:0};
	    
	    InitHeaders(headers, headerInfo);
	   
	    var cols = [
	                 {Type:"Seq",		SaveName:"seq",				Width:30,	Align:"Center",	 Edit:false}
	                ,{Type:"Text",		SaveName:"infId",			Width:50,	Align:"Center",	 Edit:false}
	                ,{Type:"Text",		SaveName:"infNm",			Width:200,	Align:"Left",	 Edit:false}
	                ,{Type:"Text",		SaveName:"cateFullnm",			Width:250,	Align:"Center",	 Edit:false}
	                ,{Type:"Text",		SaveName:"orgNm",			Width:180,	Align:"Center",	 Edit:false}
	                ,{Type:"Text",		SaveName:"cclNm",			Width:250,	Align:"Left",		Edit:false}
	                ,{Type:"Text",		SaveName:"openDttm",		Width:180,	Align:"Center",		Edit:false}
	            ];                                          
	    InitColumns(cols);
	    FitColWidth();
	    SetExtendLastCol(1);
	    
	    //initSheetOptions("sheet", 0, "useYn", [{code:"Y",name:"사용"}, {code:"N",name:"미사용"}]);
	}               
	default_sheet(sheet);
	
}

////////////////////////////////////////////////////////////////////////////////
//Validation 함수
////////////////////////////////////////////////////////////////////////////////

function saveValidation(action) {
	var objTab = getTabShowObj();//탭이 oepn된 객체가져옴
	var formObj = objTab.find("form[name=stfopeninf-dtl-form]");
	
	
	if ( com.wise.util.isNull(formObj.find("input[name=infNm]").val()) ) {
		alert("공공데이터명을 입력하세요.");
		formObj.find("input[name=infNm]").focus();
		return false;
	} else if ( !com.wise.util.isLength(formObj.find("input[name=infNm]").val(), 1, 150) ) {
		alert("150자 이내로 입력하세요.");
		formObj.find("input[name=infNm]").focus();
		return false;
	}
	
	
	return true;
}


