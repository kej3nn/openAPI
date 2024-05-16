/*
 * @(#)statPreview.js 1.0 2017/07/17
 */

/**
 * 관리자에서 통계표 미리보기 관련 스크립트 파일이다
 *
 * @author 김정호
 * @version 1.0 2017/07/17
 */
$(function() {
	
	var statblId = $("#statblId").val();
	if ( !com.wise.util.isBlank(statblId) ) {
		 doAction("searchFirst");
	} else {
		alert("정상적인 접근이 아닙니다.\n이전페이지로 이동합니다.");
		history.back();
	}
	
	/*
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
	*/
});

////////////////////////////////////////////////////////////////////////////////
// 글로벌 변수
////////////////////////////////////////////////////////////////////////////////
/* 최초 조회 여부(파라미터로 id 넘어와서 조회한 경우) */
var isFirst = true;
var dtadvsLoc = null;
////////////////////////////////////////////////////////////////////////////////
// 초기화 함수
////////////////////////////////////////////////////////////////////////////////
/**
 * 컴포넌트를 초기화한다.
 */
function initComp() {
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
	
	//메인버튼 이벤트를 바인딩한다.
	setMainButton();
	
	//주기 변경 이벤트
	$("#dtacycleCd").bind("change", function(e) {
		var options = new Array();
		
		if ( $(this).val() == "YY" ) {
			options.push({code:"00", name:"년도"});
		} else if ( $(this).val() == "HY" ) {
			options.push({code:"01", name:"상반기"});
			options.push({code:"02", name:"하반기"});
		} else if ( $(this).val() == "QY" ) {
			options = wrttimeOption(4, "분기");
		} else if ( $(this).val() == "MM" ) {
			options = wrttimeOption(12, "월");
		}
		
		initComboOptions("wrttimeStartQt", options, "");
		initComboOptions("wrttimeEndQt", options, "");
		
		$("#wrttimeMinQt").val($("select[name=wrttimeStartQt] option:first").val());		//기간 시점 최소값
		$("#wrttimeMaxQt").val($("select[name=wrttimeStartQt] option:last").val());			//기간 시점 최대값
	});
	
	//보기옵션 변경시
	$("form[name=statMainForm]").on("change", "input:radio[name=viewLocOpt]:checked", function() {
		if ( $(this).val() == "U" ) {	//사용자 설정일 경우
			$("#viewLocOptUsr-sect").show();
			$("#viewLocOpt-sect-th").attr("rowspan", 2);
		} else {
			$("#viewLocOptUsr-sect").hide();
			$("#viewLocOpt-sect-th").attr("rowspan", 1);
		}
	});
	
	statsItmTree();		//항목 선택 트리 로드
	statsClsTree();		//분류 선택 트리 로드
	statsGrpTree();		//그룹 선택 트리 로드
	
	//항목 선택 레이어 toggle
	$('#itmArticle').bind("click", function() {toggleItmArticle();});                          
	//분류 선택 레이어 toggle
	$('#clsArticle').bind("click", function() {toggleClsArticle();});
	//분류 선택 레이어 toggle
	$('#grpArticle').bind("click", function() {toggleGrpArticle();});
	//항목, 분류 레이어 닫기버튼
	$(".popup_close").bind("click", function() {
		if($('#itmTreePop').css("display") != "none"){       
			$('#itmTreePop').toggle();
		}
		if($('#clsTreePop').css("display") != "none"){       
			$('#clsTreePop').toggle();
		}
		if($('#grpTreePop').css("display") != "none"){       
			$('#grpTreePop').toggle();
		}
	});
	
	//항목
	$("a[name=itmAllChk]").bind("click", 		function(){treeNodeControl("treeItmData", "CHK")});		//전체선택
	$("a[name=itmAllUnChk]").bind("click", 		function(){treeNodeControl("treeItmData", "UN_CHK")});	//전체해제
	$("a[name=itmAllExpand]").bind("click", 	function(){treeNodeControl("treeItmData", "EXP")});		//펼침
	$("a[name=itmAllUnExpand]").bind("click", 	function(){treeNodeControl("treeItmData", "UN_EXP")});	//닫기
	//분류
	$("a[name=clsAllChk]").bind("click", 		function(){treeNodeControl("treeClsData", "CHK")});
	$("a[name=clsAllUnChk]").bind("click", 		function(){treeNodeControl("treeClsData", "UN_CHK")});
	$("a[name=clsAllExpand]").bind("click", 	function(){treeNodeControl("treeClsData", "EXP")});
	$("a[name=clsAllUnExpand]").bind("click", 	function(){treeNodeControl("treeClsData", "UN_EXP")});
	//그룹
	$("a[name=grpAllChk]").bind("click", 		function(){treeNodeControl("treeGrpData", "CHK")});
	$("a[name=grpAllUnChk]").bind("click", 		function(){treeNodeControl("treeGrpData", "UN_CHK")});
	$("a[name=grpAllExpand]").bind("click", 	function(){treeNodeControl("treeGrpData", "EXP")});
	$("a[name=grpAllUnExpand]").bind("click", 	function(){treeNodeControl("treeGrpData", "UN_EXP")});
	
	$("#itmApply").bind("click", function() {treeChkApply("treeItmData", "chkItms");});	//항목 선택 적용
	$("#clsApply").bind("click", function() {treeChkApply("treeClsData", "chkClss");});	//분류 선택 적용
	$("#grpApply").bind("click", function() {treeChkApply("treeGrpData", "chkGrps");});	//그룹 선택 적용
	
	$("#cmmtArticle").bind("click", function() {
		$('#cmmt-sect').slideToggle('slow', function(){
			if($('#cmmt-sect').css("display") != "none"){       
				$("#cmmtArticle").text("주석닫기").attr("title", "주석닫기");
			} else {
				$("#cmmtArticle").text("주석열기").attr("title", "주석열기");
			}
		});
	});
}

//메인버튼 이벤트
function setMainButton() {
	
	$("button[name=btn_inquiry]").bind("click", function(e) {
		doAction("search");
	});
	
	//조회 enter
	$("input[name=searchVal]").bind("keydown", function(event) {
        // 엔터키인 경우
        if (event.which == 13) {
            // 데이터 파일을 검색한다.
        	//doAction("search");
            return false;
        }
    });
	
	$("button[name=statMetaExp]").bind("click", function(e) {
		doAction("statMetaExpPop");
	});
}

/**
 * 옵션을 로드한다.
 */
function loadOptions() {
	//자료주기(통계표 관리에서 선택한 자료주기만 조회함)
	$.ajax({
		  type: 'POST',
		  url: com.wise.help.url("/admin/stat/statCheckedDtacycleList.do"),
		  data: {statblId:$("#statblId").val()},
		  success: function(data) {
			  initComboOptions("dtacycleCd", data.data, "");	//주기 세팅
			  
			  setOptionOptVal($("#dtacycleCd"), "DC");			//통계표에 설정한 검색자료주기 세팅
		  },
		  dataType: 'json',
		  async:false
		});
	
	//기간
	$.post(
	        com.wise.help.url("/admin/stat/statWrtTimeOption.do"),
	        //{statblId:$("#statblId").val(), dtacycleCd : "YY"},
	        {statblId:$("#statblId").val(), dtacycleCd : $("#dtacycleCd:selected").val()},
	        function(data, status, request) {
	            if (data.data) {
	                // 콤보 옵션을 초기화한다.
	            	initComboOptions("wrttimeStartYear", data.data, "");	//기간검색 시작
	            	initComboOptions("wrttimeEndYear", data.data, "");		//기간검색 종료
	                
	            	$("#wrttimeMinYear").val($("#wrttimeStartYear option:first").val());	//기간 년도 최소값
	            	$("#wrttimeMaxYear").val($("#wrttimeStartYear option:last").val());		//기간 년도 최대값
	            }
	        },
	        "json"
	    );

	//최근시점 갯수 세팅
	setOptionOptVal($("input[name=wrttimeLastestVal]"), "TN");
	
	//표두/표측(시계열)
	loadRadioOptions("optST-sect", "optST", "/admin/stat/ajaxOption.do", {grpCd:"S1106"}, "H", {});
	//표두/표측(그룹)
	loadRadioOptions("optSG-sect", "optSG", "/admin/stat/ajaxOption.do", {grpCd:"S1106"}, "L", {});
	//표두/표측(분류)
	loadRadioOptions("optSC-sect", "optSC", "/admin/stat/ajaxOption.do", {grpCd:"S1106"}, "L", {});
	//표두/표측(항목)
	loadRadioOptions("optSI-sect", "optSI", "/admin/stat/ajaxOption.do", {grpCd:"S1106"}, "H", {});
	//보기옵션
	loadRadioOptions("viewLocOpt-sect", "viewLocOpt", "/admin/stat/ajaxOption.do", {grpCd:"S1110"}, "B", {});
	
	//소수점변환
	loadComboOptionsDef("dmPointVal", "/admin/stat/ajaxOption.do", {grpCd:"S1109"}, "", "선택안함");
	
	//단위
	loadComboOptionsDef("uiChgVal", "/admin/stat/statTblUi.do", {statblId:$("#statblId").val()}, "", "선택안함");
	
	//통계표 옵션 조회(단위변환, 소수점단위, 통계자료 형태)
	getStatTblOption($("#statblId").val());
}

/**
 * 데이터를 로드한다.
 */
function loadData() {
}

////////////////////////////////////////////////////////////////////////////////
// 서비스 함수
////////////////////////////////////////////////////////////////////////////////
/**
 * 메인화면 액션
 */
function doAction(sAction) {
	var formObj = $("form[name=statMainForm");
	
	switch(sAction) {
		case "searchFirst" :
			loadPage(isFirst);
			ajaxBeforeSendAdmin(com.wise.help.url("/admin/ajaxBeforeSendAdmin.do")); //IbSheet 조회전 세션 체크
			var firParam = $("#firParam").val();
			var param = {PageParam: "ibpage", Param: "onepagerow=50"+"&"+firParam};
			sheet.DoSearchPaging(com.wise.help.url("/admin/stat/ststPreviewList.do"), param);
			break;
		case "search" :	//조회
			if ( searchValidation(formObj) ) {
				loadPage(isFirst);
				var param = formObj.serialize();
				ajaxBeforeSendAdmin(com.wise.help.url("/admin/ajaxBeforeSendAdmin.do")); //IbSheet 조회전 세션 체크
				var param = {PageParam: "ibpage", Param: "onepagerow=50"+"&"+param};
				sheet.DoSearchPaging(com.wise.help.url("/admin/stat/ststPreviewList.do"), param);
			}
			break;
		case "statMetaExpPop" :	//통계 설명 팝업
			window.open(com.wise.help.url("/admin/stat/popup/statMetaExpPopup.do") + "?statblId=" + $("#statblId").val() , "statMetaExpPopup", "fullscreen=no, width=800, height=700");
			break;
	}
}

//통계표 콤보박스 로드
function getStatTblOption(id) {
	//통계자료 콤보박스 로드
	$.ajax({
		  type: 'POST',
		  url: com.wise.help.url("/admin/stat/statTblDtadvs.do"),
		  data: {statblId:id},
		  success: function(res1) {
			  if (res1.data) {
	                // 콤보 옵션을 초기화한다.
	            	var data = res1.data;
	                var combobox = $("#dtadvsVal");
	                
	                combobox.find("option").each(function(index, element) {
	                    $(this).remove();
	                });
	                
	                for (var i = 0; i < data.length; i++) {
						var option = $("<option></option>");
						option.val(data[i].optCd);
						option.text(data[i].optNm);
						if ( data[i].optCd == "OD" || data[i].isChk == "true" ) {	//원자료 인 경우
							option.attr("selected", "selected");
						}
						combobox.append(option);
					}
	            	//multiple selectbox 처리
	                combobox.multipleSelect({
	                	selectAll : false,
	                	width: '150px'
	                });
	            }
		  },
		  dataType: 'json',
		  async:false
		});
}

/**
 * 주기에 따른 상세 시점 세팅(반기, 분기, 월)
 * @param end
 * @param wrtTxt
 * @returns {Array}
 */
function wrttimeOption(end, wrtTxt) {
	var options = new Array();
	var option = "";
	for ( var i=1; i <= end; i++ ) {
		if ( i < 10 ) {
			sCode = "0" + String(i);	//코드는 숫자 앞에 '0'이 필요
		} else {
			sCode = String(i);
			sName = String(i);
		}
		sName = String(i);
		options.push({code:sCode, name:sName + " " + wrtTxt});
	}
	return options;
}

/**
 * 통계표 옵션 값을 로드 후 세팅한다.
 * @param element	value값 입력할 element
 * @param optCd		통계표 옵션 코드
 */
function setOptionOptVal(element, optCd) {
	$.ajax({
		  type: 'POST',
		  url: com.wise.help.url("/admin/stat/statTblOptVal.do"),
		  data: {statblId:$("#statblId").val(), optCd : optCd},
		  success: function(data) {
			  if (data.data) {
				  element.val(data.data[0].optVal);
				  element.change();
			  }
	  },
	  dataType: 'json',
	  async:false
	});
}

/**
 * 콤보박스를 로드한다(코드 ""(공백) 추가)
 * @param id		element id
 * @param url		url
 * @param data		parameter
 * @param value		콤보박스에 선택될 값
 * @param txt		공백 코드일 경우 text값
 */
function loadComboOptionsDef(id, url, data, value, txt) {
    $.post(
        com.wise.help.url(url),
        data,
        function(data, status, request) {
            if (data.data) {
                // 콤보 옵션을 초기화한다.
                initComboOptions(id, [{
                    code:"",
                    name:txt
                }].concat(data.data), value);
            }
        },
        "json"
    );
}

////////////////////////////////////////////////////////////////////////////////
// 전처리 함수
////////////////////////////////////////////////////////////////////////////////
//항목 트리 전 처리함수
function beforeStatsItmTree(option) {
	var data = {
			statblId : $("#statblId").val(),
            itmTag : 'I'
        };
        
    return data;
}

//분류 트리 전 처리함수
function beforeStatsClsTree(option) {
	var data = {
			statblId : $("#statblId").val(),
			itmTag : 'C'
        };
        
    return data;
}

//그룹 트리 전 처리함수
function beforeStatsGrpTree(option) {
	var data = {
			statblId : $("#statblId").val(),
			itmTag : 'G'
        };
        
    return data;
}
////////////////////////////////////////////////////////////////////////////////
// 후처리 함수
////////////////////////////////////////////////////////////////////////////////
function afterStatsItmTree(data) {
	setAfterTree("treeItmData", data);
}

function afterStatsClsTree(data) {
	setAfterTree("treeClsData", data);
}

function afterStatsGrpTree(data) {
	setAfterTree("treeGrpData", data);
}
////////////////////////////////////////////////////////////////////////////////
//시트 로드
////////////////////////////////////////////////////////////////////////////////
/**
 * 시트 동적 로드
 * @param isFirst	시트 최초 조회 여부(파라미터 넘어와서 조회시)
 */
function loadPage(isFirst) {
	/*
	if ( sheet != null ) {
		sheet.Reset();
	}*/
	//createIBSheet2(document.getElementById("sheet"), "sheet", "100%", "400px");
	
	sheet.Reset();
	
	var gridArr = [];
	var iArr = null;
	var sheetCols = [];

	if (isFirst) {	//파라미터 넘어와서 처음 조회시
    	var params = JSON.parse('{"' + decodeURI($("#firParam").val().replace(/&/g, "\",\"").replace(/=/g,"\":\"")) + '"}');
    	
    } else {
    	var params = $("form[name=statMainForm").serializeObject()
    }

	$.ajax({
	    url: com.wise.help.url("/admin/stat/statTblItm.do"),
	    async: false, 
	    type: 'POST', 
	    data: params,
	    dataType: 'json',
	    beforeSend: function(obj) {
	    }, // 서버 요청 전 호출 되는 함수 return false; 일 경우 요청 중단
	    success: function(data) {
	    	var text = data.data.Text;	//헤더 컬럼 text 정보
	    	var cols = data.data.Cols;	//헤더 컬럼 속성정보
	    	var cmmtRowCol = data.data.cmmtRowCol;
	    	var loadDtadvsLoc = data.data.dtadvsLoc; 
	    	
	    	for ( var i=0; i < text.length; i++) {
	    		var tdata = text[i];
	    		iArr = new Array();
	    		for ( var t in tdata ) {	
	    			iArr.push(tdata[t]);
	    		}
	    		gridArr.push({Text:iArr.join("|"), Align:"Center"} );
	    	}
	    	
	    	for ( var c in cols ) {
	    		sheetCols.push({
	    			Type 		: cols[c].Type,
	    			SaveName 	: cols[c].SaveName,
	    			Width 		: cols[c].Width,
	    			Align 		: cols[c].Align,
	    			Edit 		: cols[c].Edit,
	    			Hidden 		: cols[c].Hidden,
	    			ColMerge	: cols[c].ColMerge
	    		});
	    	}
	    	
	    	with(sheet){
	    		var cfg = {SearchMode:2,	Page:50,	VScrollMode:1,	MergeSheet:7,	ColPage : 20};
	    		//var cfg = {SearchMode:2,	Page:50,	VScrollMode:1,	MergeSheet:0};
	    	    SetConfig(cfg);
	    	    var headerInfo = {Sort:0,ColMove:1,ColResize:1,HeaderCheck:0};
	    	    
	    	    InitHeaders(gridArr, headerInfo);
	    	                                      
	    	    InitColumns(sheetCols);
	    	    
	    	    //FitColWidth();
	    	    //SetExtendLastCol(1);
	    	}               
	    	default_sheet(sheet);  
	    	
	    	//헤더에 주석식별자 입력
	    	for ( var cmmt in cmmtRowCol ) {
	    		sheet.SetHtmlHeaderValue(cmmtRowCol[cmmt].row, cmmtRowCol[cmmt].col, cmmtRowCol[cmmt].cmmt);
	    	}
	    	
	    	//통계자료 행or열 숨김 처리(원자료만 있는 경우)
	    	if ( loadDtadvsLoc.LOC != "" ) {
	    		dtadvsLoc = loadDtadvsLoc
	    	}
	    	
	    }, // 요청 완료 시
	    error: function(request, status, error) {
	    	handleError(status, error);
	    }, // 요청 실패.
	    complete: function(jqXHR) {} // 요청의 실패, 성공과 상관 없이 완료 될 경우 호출
	});
}
////////////////////////////////////////////////////////////////////////////////
//시트 서비스 함수
////////////////////////////////////////////////////////////////////////////////
//시트 조회 후
function sheet_OnSearchEnd(code, message, statusCode, statusMessage) {
	//옵션 값 로드
	if ( isFirst ) {
		bindEvent();
		loadOptions();
		isFirst = false;
		$("#firParam").val("");
	}

	//통계자료 hidden 처리(원자료만 존재할 경우)
	if ( dtadvsLoc.LOC != "" ) {
		if ( dtadvsLoc.LOC == "HEAD" ) {
			sheet.SetRowHidden(dtadvsLoc.CNT, 1);
		} else if ( dtadvsLoc.LOC == "LEFT" ) {
			sheet.SetColHidden(dtadvsLoc.CNT, 1);
		}
	}
}
////////////////////////////////////////////////////////////////////////////////
//트리 관련 함수
////////////////////////////////////////////////////////////////////////////////
/* 항목 선택 트리 로드 */
function statsItmTree() {
	doSearch({
	    url: "/admin/stat/statTblItmJson.do",
	    before:beforeStatsItmTree,
		after:afterStatsItmTree
	});
}
/* 분류 선택 트리 로드 */
function statsClsTree() {
	doSearch({
	    url: "/admin/stat/statTblItmJson.do",
	    before:beforeStatsClsTree,
		after:afterStatsClsTree
	});
}

/* 그룹 선택 트리 로드 */
function statsGrpTree() {
	doSearch({
	    url: "/admin/stat/statTblItmJson.do",
	    before:beforeStatsGrpTree,
		after:afterStatsGrpTree
	});
}
//트리 후처리 함수 서비스(항목, 분류 공통 사용)
function setAfterTree(id, data) {
	//tree setting 값
	if ( data != null && data.length != 0 ) {
		var setting = {
				//체크 여부
				check:{	
					enable:true,
		            chkStyle: "checkbox",
		            chkboxType:{ Y:"", N:"" }
		        },
		        //데이터 타입 설정
		        data:{
		            key:{
		                name:"viewItmNm"
		            },
		            simpleData:{
		                enable:true,
		                idKey:"datano",
		                pIdKey:"parDatano"
		            }
		        }
			};
		//트리 로드
		$.fn.zTree.init($("#"+id), setting, data);
		
		if ( id.toUpperCase().indexOf("ITM") > 0 ) {
			$("#itmArticle").show();	//항목 선택 버튼 보여준다.
		} else if ( id.toUpperCase().indexOf("CLS") > 0 ) {
			$("#clsArticle").show();	//분류 선택 버튼 보여준다.
			$("[id^=optSC-").show();
		} else if ( id.toUpperCase().indexOf("GRP") > 0 ) {
			$("#grpArticle").show();	//그룹 선택 버튼 보여준다.
			$("[id^=optSG-").show();
		}
	} 
}

//항목선택 toggle
function toggleItmArticle() {
	if( $('#clsTreePop').css("display") != "none" )	$('#clsTreePop').toggle();
	if( $('#grpTreePop').css("display") != "none" )	$('#grpTreePop').toggle();
	$('#itmTreePop').toggle();
	//트리 팝업 top 위치 선택버튼 밑에 위치 하도록 변경
	$('#itmTreePop').css("top", $('#itmArticle').position().top).css("left", $('#itmArticle').position().left);
}
//분류선택 toggle
function toggleClsArticle() {
	if( $('#itmTreePop').css("display") != "none" )	$('#itmTreePop').toggle();
	if( $('#grpTreePop').css("display") != "none" )	$('#grpTreePop').toggle();
	$('#clsTreePop').toggle();
	//트리 팝업 top 위치 선택버튼 밑에 위치 하도록 변경
	$('#clsTreePop').css("top", $('#clsArticle').position().top).css("left", $('#clsArticle').position().left);
}

//그룹선택 toggle
function toggleGrpArticle() {
	if( $('#itmTreePop').css("display") != "none" )	$('#itmTreePop').toggle();
	if( $('#clsTreePop').css("display") != "none" )	$('#clsTreePop').toggle();
	$('#grpTreePop').toggle();
	//트리 팝업 top 위치 선택버튼 밑에 위치 하도록 변경
	$('#grpTreePop').css("top", $('#grpArticle').position().top).css("left", $('#grpArticle').position().left);
}

/**
 * 트리 노드 컨트롤 함수
 * @param id	tree가 담겨져 있는 <ul> id
 * @param func	
 * 	CHK 	: 전체 체크
 * 	UN_CHK 	: 전체 체크 해제
 * 	EXP 	: 트리 노드 전체 열기
 *  UN_EXP 	: 트리 노드 전체 닫기
 */
function treeNodeControl(id, func) {
	var zTree = $.fn.zTree.getZTreeObj(id);
	if (func == "CHK") {
		zTree.checkAllNodes(true);
	} else if (func == "UN_CHK") {
		zTree.checkAllNodes(false);
	} else if (func == "EXP") {
		zTree.expandAll(true);
	} else if (func == "UN_EXP") {
		zTree.expandAll(false);
	}
}

/**
 * 항목/분류 선택 적용
 * @param treeId
 * @param inputNm
 */
function treeChkApply(treeId, inputNm) {
	if ( $("input[name="+inputNm+"]").length > 0 ) {
		//이전에 선택한 값 제거
		$("input[name="+inputNm+"]").remove();
	}
	
	var treeObj = $.fn.zTree.getZTreeObj(treeId);
	var nodes = treeObj.getCheckedNodes();
	
	if ( nodes.length > 0 ) {
		//form에 input hidden 생성하여 추가
		for ( var n in nodes ) {
			$('<input>').attr({
			    type: 'hidden',
			    name: inputNm,
			    value: nodes[n].datano
			}).appendTo("form[name=statMainForm]");
		}
		//레이어 숨김
		if ( inputNm == "chkItms" ) {
			toggleItmArticle();
		} else if ( inputNm == "chkClss" ) {
			toggleClsArticle();
		}
		
		doAction("search");
	} else {
		alert("체크된 항목이 없습니다.");
	}
}
////////////////////////////////////////////////////////////////////////////////
//이벤트 함수
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
//Validation 함수
////////////////////////////////////////////////////////////////////////////////
//조회 validation
function searchValidation(formObj) {
	if ( formObj.find("input:radio[name=wrttimeType]:checked").val() == "L" ) {		
		//주기가 최근시점인 경우 필수값 체크
		if ( com.wise.util.isNull(formObj.find("input[name=wrttimeLastestVal]").val())
				|| !com.wise.util.isNumeric(formObj.find("input[name=wrttimeLastestVal]").val()) ) {
			alert("최근시점 값이 비어있거나 숫자형식이 아닙니다.");
			formObj.find("input[name=wrttimeLastestVal]").val("").focus();
			return false;
		}
	} 
	if ( formObj.find("input:radio[name=viewLocOpt]:checked").val() == "T" ) {
		//표로 보기 일 경우
		if ( formObj.find("select[name=dtacycleCd]").val() == "YY" ) {
			alert("보기옵션이 [표로보기]인 경우\n주기가 [년]이 올 수 없습니다.");
			formObj.find("select[name=dtacycleCd]:checked").focus();
			return false;
		}
	}
	return true;
}


