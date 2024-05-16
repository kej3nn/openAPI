/*
 * @(#)easyStatSchTree.js 1.0 2017/12/14
 * 
 * COPYRIGHT (C) 2013 WISEITECH CO., LTD. ALL RIGHTS RESERVED.
 */
/**
 * 간편통계 트리 관련 스크립트 파일이다.
 * 
 * @author 김정호
 * @version 1.0 2017/12/14
 */
/**
 * 트리 로드
 * @param id	트리 ID
 * @param data	로드 할 데이터
 */
////////////////////////////////////////////////////////////////////////////////
// 트리 로드
////////////////////////////////////////////////////////////////////////////////
/**
 * 메인화면 통계표 항목/분류 트리 세팅
 * @Param gubun :	I=항목, C=분류, G=그룹
 */
function statsMainTreeLoad(gubun) {
	var param = {
		statblId : $("#sId").val(),
		itmTag : gubun,
		langGb : $("#langGb").val()
	};
	if (gubun == "I") {
		param.itmNmsearchVal = $("#itmSearchVal").val();
	} else if (gubun == "C") {
		param.itmNmsearchVal = $("#clsSearchVal").val();
	} else if (gubun == "G") {
		param.itmNmsearchVal = $("#grpSearchVal").val();
	}
	$.ajax({
		url : com.wise.help.url("/portal/stat/statEasyItmJson.do"),
		async : false,
		type : 'POST',
		data : param,
		dataType : "json",
		beforeSend : function(obj) {
		}, // 서버 요청 전 호출 되는 함수 return false; 일 경우 요청 중단
		success : function(data) {
			var buildTree = buildTreeStructure(data.data);
			data.data = buildTree;
			if (gubun == "I") {
				itmData = data.data;
				setAfterTree("treeItmData", itmData);
			} else if (gubun == "C") {
				clsData = data.data;
				setAfterTree("treeClsData", clsData);
			} else if (gubun == "G") {
				grpData = data.data;
				setAfterTree("treeGrpData", grpData);
			}
		}, // 요청 완료 시
		error : function(request, status, error) {
			handleError(status, error);
		}, // 요청 실패.
		complete : function(jqXHR) {
		} // 요청의 실패, 성공과 상관 없이 완료 될 경우 호출
	});
	
	if (gubun == "G") sizeBoxDisplay(clsData.length, grpData.length)
}
/**
 * 메인화면 통계표 증감분석 트리 세팅
 * [2018.06.14 추가] Default 보기옵션 기능추가
 */
function statsDvsTreeLoad() {
	var sId = $("#sId").val();
	var langGb = $("#langGb").val();
	var dvsTreeNm = "treeDvsData";
		
	// 통계자료 체크박스 로드
	$.ajax({
		type : 'POST',
		url : com.wise.help.url("/portal/stat/statTblDtadvs.do"),
		data : {
			statblId : sId,
			langGb : langGb
		},
		success : function(res1) {

			if (res1.data) {
				// 콤보 옵션을 초기화한다.
				var data = res1.data;
				var treeData = new Array();

				for (var i = 0; i < data.length; i++) {
					var valName = new Object();

					valName.title = data[i].optNm;
					valName.key = data[i].optVal;
					valName.isFolder = false;	
					valName.children = "";

					if (data[i].optVal == "OD"){
						valName.select = true;
					}else{
						if(data[i].defaultCnt > 0){
							valName.select = true;
						}else{
							valName.select = false;
						}
					}

					treeData.push(valName);
				}

				setMakeTabTree(dvsTreeNm, treeData);
			}
		},
		dataType : 'json',
		async : false
	});
}
/**
 * 탭 안의 통계표 항목/분류 트리 세팅
 * @Param gubun :	I=항목, C=분류, G=그룹
 */
function statsTreeLoad(gubun) {
	var objTab = getTabShowObj();// 탭이 open된 객체가져옴
	var formObj = objTab.find("form[name=statsEasy-mst-form]");
	var statblId = formObj.find("input[name=statblId]").val();
	
	var param = {
		statblId : statblId,
		itmTag : gubun,
		langGb : $("#langGb").val()
	};
	if (gubun == "I") {
		param.itmNmsearchVal = $("#itmSearchVal").val();
	} else if (gubun == "C") {
		param.itmNmsearchVal = $("#clsSearchVal").val();
	} else if (gubun == "G") {
		param.grpNmsearchVal = $("#grpSearchVal").val();
	}
	$.ajax({
		url : com.wise.help.url("/portal/stat/statEasyItmJson.do"),
		async : false,
		type : 'POST',
		data : param,
		dataType : "json",
		beforeSend : function(obj) {
		}, // 서버 요청 전 호출 되는 함수 return false; 일 경우 요청 중단
		success : function(data) {
			var buildTree = buildTreeStructure(data.data);
			data.data = buildTree;
			
			if (gubun == "I") {
				afterStatsItmTree(data.data);
			} else if (gubun == "C") {
				afterStatsClsTree(data.data);
			} else if (gubun == "G") {
				afterStatsGrpTree(data.data);
			}
		}, // 요청 완료 시
		error : function(request, status, error) {
			handleError(status, error);
		}, // 요청 실패.
		complete : function(jqXHR) {
		} // 요청의 실패, 성공과 상관 없이 완료 될 경우 호출
	});
}
/**
 * 항목 트리 후 처리
 * 
 * @param data
 */
function afterStatsItmTree(data) {
	var objTab = getTabShowObj();// 탭이 open된 객체가져옴
	var formObj = objTab.find("form[name=statsEasy-mst-form]");

	// 항목 정보를 [통계검색]화면의 DIV에서 받아서 세팅한다.
	var itmIdNm = "itm" + formObj.find("input[name=statblId]").val();
	// 생성된 탭의 항목DIV ID를 변경한다.
	formObj.find("ul[id^='treeItmDataTab']").attr('id', itmIdNm);
	
	/* 탭 화면의 항목 부분 */
	itmData = data;
	
	/* 탭이동시 항목 선택정보 재설정*/
	itmData = treeSelectChkData(itmData);
	
	setAfterTree(itmIdNm, itmData);
}
/**
 * 분류 트리 후 처리
 */
function afterStatsClsTree(data) {
	var objTab = getTabShowObj();// 탭이 open된 객체가져옴
	var formObj = objTab.find("form[name=statsEasy-mst-form]");

	// 항목 정보를 [통계검색]화면의 DIV에서 받아서 세팅한다.
	var clsIdNm = "cls" + formObj.find("input[name=statblId]").val();
	// 생성된 탭의 항목DIV ID를 변경한다.
	formObj.find("ul[id^='treeClsDataTab']").attr('id', clsIdNm);
	var searchGb = $("#searchGb").val();
	if ( data.length > 0 ) {
		/* 탭 화면의 항목 부분 */
		clsData = data;
		
		/* 탭이동시 분류 선택정보 재설정*/
		clsData = treeSelectChkData(clsData);
		
		setAfterTree(clsIdNm, clsData);
	} else {
		formObj.find("span[class=spanCls]").hide(); // 데이터가 없으면 버튼을 보이지 않게
	}
	
}
/**
 * 그룹 트리 후 처리
 */
function afterStatsGrpTree(data) {
	var objTab = getTabShowObj();// 탭이 open된 객체가져옴
	var formObj = objTab.find("form[name=statsEasy-mst-form]");

	// 항목 정보를 [통계검색]화면의 DIV에서 받아서 세팅한다.
	var grpIdNm = "grp" + formObj.find("input[name=statblId]").val();
	// 생성된 탭의 항목DIV ID를 변경한다.
	formObj.find("ul[id^='treeGrpDataTab']").attr('id', grpIdNm);
	var searchGb = $("#searchGb").val();
	if ( data.length > 0 ) {
		formObj.find("span[class=spanGrp]").show(); // 데이터가 있으면 버튼을 보이게
		
		/* 탭 화면의 항목 부분 */
		grpData = data;
		
		/* 탭이동시 그룹 선택정보 재설정*/
		grpData = treeSelectChkData(grpData);
		
		setAfterTree(grpIdNm, grpData);
	} else {
		formObj.find("span[class=spanGrp]").hide(); // 데이터가 없으면 버튼을 보이지 않게
	}
	
}

/**
 * 트리 생성
 */
function setAfterTree(id, dynaData) {
	
	$("#"+id).dynatree({
		checkbox: true,
        selectMode: 3,
        children: dynaData, //사용자 조작이 필수적인 부분 ! 트리뷰 데이터 소스가 들어가야 하는 부분, JSON방식으로 넘어오기면 하면 된다.
        onSelect: function(select, node) {
            var selNodes = node.tree.getSelectedNodes();
            //웹접근성을 위해 추가
            $("#"+id).find(".dynatree-title").removeAttr("title");
            $("#"+id+" .dynatree-selected").find(".dynatree-title").attr("title","선택된 조건입니다");
        },
        onClick: function(node, event) {
            if( node.getEventTargetType(event) == "title" )
              node.toggleSelect();
        },
        onKeydown: function(node, event) {
            if( event.which == 32 ) {
              node.toggleSelect();
              return false;
            }
        },
        onRender: function(node, nodeSpan) {
    		var title = $(nodeSpan).find("a");
    		var text = title.text();
    		title.empty().append($('<em>'+ text +'</em>'));
        }
    });
	
	$("#"+id).dynatree("getTree").reload();
	//웹접근성을 위해 추가
    $("#"+id).find(".dynatree-title").removeAttr("title");
    $("#"+id+" .dynatree-selected").find(".dynatree-title").attr("title","선택된 조건입니다");

}

/**
 * 신규탭에서 호출되는 트리 노드 컨트롤 함수
 * @param id	tree가 담겨져 있는 <ul> id
 * @param func	CHK : 전체 체크 UN_CHK : 전체 체크 해제 EXP : 트리 노드 전체 열기 UN_EXP : 트리 노드 전체 닫기
 */
// 생성된 탭의 항목/분류에 적용되는 트리용
function setMakeTabTree(id, dynaData) {
	
	$("#"+id).dynatree({
		checkbox: true,
        selectMode: 3,
        children: dynaData, //사용자 조작이 필수적인 부분 ! 트리뷰 데이터 소스가 들어가야 하는 부분, JSON방식으로 넘어오기면 하면 된다.
        onSelect: function(select, node) {
            var selNodes = node.tree.getSelectedNodes();
            //웹접근성을 위해 추가
            $("#"+id).find(".dynatree-title").removeAttr("title");
            $("#"+id+" .dynatree-selected").find(".dynatree-title").attr("title","선택된 조건입니다");
        },
        onClick: function(node, event) {
            if( node.getEventTargetType(event) == "title" )
              node.toggleSelect();
        },
        onKeydown: function(node, event) {
            if( event.which == 32 ) {
              node.toggleSelect();
              return false;
            }
        },
        onActivate: function(node) {
        },
        onRender: function(node, nodeSpan) {
    		var title = $(nodeSpan).find("a");
    		var text = title.text();
    		title.empty().append($('<em>'+ text +'</em>'));
        }
    });
	
	$("#"+id).dynatree("getTree").reload();
	//웹접근성을 위해 추가
    $("#"+id).find(".dynatree-title").removeAttr("title");
    $("#"+id+" .dynatree-selected").find(".dynatree-title").attr("title","선택된 조건입니다");
	
	//메인 화면의 트리를 로드한 뒤 검색한 값이 있을경우 highlight 값 초기화
	//updateNodes(id, false, $.fn.zTree.getZTreeObj(id).getNodesByParamFuzzy("viewItmNm", ""));
}
////////////////////////////////////////////////////////////////////////////////
// 트리 전처리 함수
////////////////////////////////////////////////////////////////////////////////
//통계 트리 전 처리함수
function beforeStatsTree(option) {
	$("button[name=statAllExpand]").bind("click", function() {
		treeNodeControl("treeStatData", "EXP")
	}); // 펼침
	$("button[name=statAllUnExpand]").bind("click", function() {
		treeNodeControl("treeStatData", "UN_EXP")
	}); // 닫기
	
	var data = {
		statblId : $("#sId").val(),
		searchVal : $("#searchVal").val(),
		searchGubun : $("#searchGubun").val(),
		searchKeywordVal : $("#hdnKeywordVal").val(),
		mbSubject : $("#mbSubject").find("option:selected").val(),
		langGb : $("#langGb").val(),
		statGb : $("#statGb").val(),
		treeCateId : $("#treeCateId").val()		// 분류ID
	};
	
	return data;
}

//항목 트리 전 처리함수
function beforeStatsItmTree(option) {
	var data = {
		statblId : $("#sId").val(),
		itmNmsearchVal : $("#itmSearchVal").val(),
		itmTag : 'I'
	};

	return data;
}

// 분류 트리 전 처리함수
function beforeStatsClsTree(option) {
	var data = {
		statblId : $("#sId").val(),
		itmNmsearchVal : $("#clsSearchVal").val(),
		itmTag : 'C'
	};

	return data;
}

function beforeClick(treeId, treeNode, clickFlag) {
	$("#treeStatData").find("li").removeClass('curSelectedNode');
	$("#treeStatData").find("a").removeClass('curSelectedNode');
	
	var tId = treeNode.tId;
	$("#"+tId).addClass('curSelectedNode');
	
	if (treeNode.isParent) {
		// 폴더를 선택하면 항목선택/분류선택을 초기화한다.
		$("#treeItmData").empty();
		$("#treeClsData").empty();
		$("#treeGrpData").empty();
	} else {
		selStat(treeNode.statblId); // 항목선택/분류선택 리스트 호출
	}
}

function dynaStatClick(statblId, isFolder) {
	if (isFolder) {
		// 폴더를 선택하면 항목선택/분류선택을 초기화한다.
		$("#treeItmData").empty();
		$("#treeClsData").empty();
		$("#treeGrpData").empty();
	} else {
		selStat(statblId); // 항목선택/분류선택 리스트 호출
	}
}

function itmClick(treeId, treeNode, clickFlag) {
	$("#"+treeId).find("li").removeClass('curSelectedNode');
	$("#"+treeId).find("a").removeClass('curSelectedNode');
	
	var tId = treeNode.tId;
	$("#"+tId).addClass('curSelectedNode');
}
////////////////////////////////////////////////////////////////////////////////
//트리 후처리
////////////////////////////////////////////////////////////////////////////////
function setStatTree(id, data) {
	
	//var dynaData = dynaTreeStat(data);
	
	$("#"+id).dynatree({
        selectMode: 3,
        children: data, //사용자 조작이 필수적인 부분 ! 트리뷰 데이터 소스가 들어가야 하는 부분, JSON방식으로 넘어오기면 하면 된다.
        onClick: function (node, event) {
        	if(!node.data.isFolder)  {
            	showLoading();
           		setTimeout(function() {
           			dynaStatClick(node.data.key, node.data.isFolder);
           		}, 0);
        	}
       		setTimeout("moveScrollLeft(\""+id+"\")", 100);
        },
        onRender: function(node, nodeSpan) {
        	if(!node.data.isFolder){
        		if(node.data.mapSrvCd !="NONE"){
        			$(nodeSpan).find("a em").append("<img src=\"" + com.wise.help.url("/js/soportal/tree/skin/tree_icon_map.png") + "\" alt=\"맵이미지\" style=\"width:auto;height:auto;vertical-align:baseline;\" /> ");
        		}
        		if(node.data.ctsSrvCd =='N'){
        			$(nodeSpan).find("span.dynatree-icon").css("background-position", "-97px 1px");
        		}
        	}
        }
        
    });
	
	
	$("#"+id).dynatree("getTree").reload();
	
}

function moveScrollLeft(id){
	$("#"+id).scrollLeft(0);
}

////////////////////////////////////////////////////////////////////////////////
// 트리 사용자 정의 함수
////////////////////////////////////////////////////////////////////////////////
function ItemTree(jsonData, targetDiv) {
	var coldata;
	var cols = [];
	if (jsonData.length > 0) {

		var html = "";
		var parentKey1 = "";
		var parentKey2 = "";
		var fClose = "";
		var bfGubun = "";
		var bfParentId = "";
		for (var i = 0; i < jsonData.length; i++) {
			var chkData = JSON.stringify(jsonData[i]);
			var c = JSON.parse(chkData);

			if (c.Level == "1") {
				if (parentKey1 != "") {
					html += "</ul></li></ul></li>";
					fClose = " class='closed'";
				} else {
					html = "<ul>"
				}
				parentKey2 = "";
			} else if (c.Level == "2") {
				if (bfParentId == c.parDatano) {
					html += "</ul></li>";
				} else {
					if (parentKey2 != "" && parentKey2 != c.parDatano)
						html += "</ul></li>";
				}
			}

			html += "<li" + fClose + "><span> " + c.viewItmNm + "</span><ul>";

			if (c.Level == "1") {
				parentKey1 = c.datano;
			} else if (c.Level == "2") {
				parentKey2 = c.datano;
			}
			bfParentId = c.parDatano;
		}
		html += "</ul></li>";

		$("#" + targetDiv + "").append(html);

	}
}

/**
 * 그룹/항목/분류 선택 hidden만 생성
 * 
 * @param treeId
 * @param inputNm
 */
function makeItmTreeChk(treeId, inputNm) {
	var objTab = getTabShowObj();// 탭이 open된 객체가져옴
	var formObj = objTab.find("form[name=statsEasy-mst-form]");

	if ($("input[name=" + inputNm + "]").length > 0) {
		// 이전에 선택한 값 제거
		$("input[name=" + inputNm + "]").remove();
	}

	var treeObj = $("#"+treeId).dynatree("getSelectedNodes");
	
	if (treeObj.length > 0) {
		// form에 input hidden 생성하여 추가
		for ( var n in treeObj) {
			$('<input>').attr({
				type : 'hidden',
				name : inputNm,
				value : treeObj[n].data.key
			}).appendTo(formObj);
		}
		// 레이어 숨김
		if (inputNm == "chkItms") {
			formObj.find($(".layerPopup.itmPop")).hide();
		} else if (inputNm == "chkClss") {
			formObj.find($(".layerPopup.clsPop")).hide();
		} else if (inputNm == "chkGrps") {
			formObj.find($(".layerPopup.grpPop")).hide();
		}

	} else {
		jAlert(alertMsg00);
		return false;
	}
}

/**
 * 항목/분류 선택 적용
 * 
 * @param treeId
 * @param inputNm
 */
function treeChkApply(treeId, inputNm) {
	var objTab = getTabShowObj();// 탭이 open된 객체가져옴
	var formObj = objTab.find("form[name=statsEasy-mst-form]");
	
	showLoading();

	if ($("input[name=" + inputNm + "]").length > 0) {
		// 이전에 선택한 값 제거
		$("input[name=" + inputNm + "]").remove();
	}
	
	var treeDataLength = $("#"+treeId).find("li").children().length;	// 트리 데이터 갯수
	if( treeDataLength > 0 ) {
		var treeObj = $("#"+treeId).dynatree("getSelectedNodes");
		
		if (treeObj.length > 0) {
			// form에 input hidden 생성하여 추가
			for ( var n in treeObj) {
				
				$('<input>').attr({
					type : 'hidden',
					name : inputNm,
					value : treeObj[n].data.key
				}).appendTo(formObj);
			}
		}
	}
	// 레이어 숨김
	if (inputNm == "chkItms") {
		formObj.find($(".layerPopup.itmPop")).hide();
	} else if (inputNm == "chkClss") {
		formObj.find($(".layerPopup.clsPop")).hide();
	} else if (inputNm == "chkGrps") {
		formObj.find($(".layerPopup.grpPop")).hide();	
	} else if (inputNm == "dtadvsVal") {
		formObj.find($(".layerPopup.dvsPop")).hide();
	}
}

/**
 * 탭 안의 폼값의 트리에 체크된 항목이 있는지 확인
 * @param treeId	트리 ID
 * @returns {Boolean}
 */
function isTreeChk(treeId) {
	var treeObj = $("#"+treeId).dynatree("getSelectedNodes");
	
	if (treeObj.length > 0) {
		return true;
	}else{
		return false;
	}
}

/**
 * 전체선택 할경우 pass하고 전체 선택 안할경우 체크 제한갯수 확인
 * @param treeId
 * @returns {Boolean}
 */
function isTreeAllChk(treeId) {
	
	var len = 0;
	var selectLen = 0;
	var treeLen = $("#"+treeId).dynatree("getRoot").visit(function(node) {
		len++;
		if( node.bSelected ) {
			selectLen++;
		}
	});
	
	if ( len == selectLen) {
		// 전체 노트갯수와 체크노드 갯수가 같을경우 패스(조회조건에서 in절 제거)
		return true
	}
	else {
		// 트리 제한갯수 확인
		if ( selectLen < TREE_CHK_LIMIT_CNT ) {
			return true;
		} 
		else {
			return false;
		}
	}
}

/**
 * 탭 이동시 트리 관련 obj 재생성(이벤트가 사라져서...)
 * @param id
 */
function treeRefreshEvent(gubun) {
	var objTab = getTabShowObj();// 탭이 open된 객체가져옴
	var formObj = objTab.find("form[name=statsEasy-mst-form]");
	selectNode = "";
	if(gubun == "I") selectNode = formObj.find("input[name=chkItms]");
	if(gubun == "C") selectNode = formObj.find("input[name=chkClss]");
	if(gubun == "G") selectNode = formObj.find("input[name=chkGrps]");
	if(gubun == "D") selectNode = formObj.find("input[name=dtadvsVal]");
			
	if(gubun != "D") statsTreeLoad(gubun);
	else getStatTblOption();
	
	//광역변수 다시 초기화
	selectNode = "";
}


////////////////////////////////////////////////////////////////////////////////
// 트리 검색
////////////////////////////////////////////////////////////////////////////////
/**
 * 생성된 탭의 트리 검색용
 * @param treeId	트리의 ID
 * @param keyWord	검색어
 */
function searchNode(treeId, keyWord) {
	
    keyWord = (keyWord.replace(/ /g, '')).toUpperCase();
	//var liCnt = $("#"+treeId).find("li").length;//띄어쓰기, 대소문자 구문없이..
	var treeDataLength = $("#"+treeId).find("li").children().length;	// 트리 데이터 갯수
	if(treeDataLength > 0){
		var keyType = "title";
		updateNodes(treeId, keyType, keyWord);
	}
}
/**
 * 검색에 결과에 따른 트리명칭 CSS적용 
 */
function updateNodes(treeId, keyType, keyWord) {
		
	$("#"+treeId).find("li").each(function(event){
		var f_val = $(this).find("a").text();
		f_val = (f_val.replace(/ /g, '')).toUpperCase();//띄어쓰기, 대소문자 구문없이..

		if(keyWord == ""){
			$(this).find("span").removeClass("dynatree-active");
		}else{
			if(f_val.match(keyWord)){
				//$(this).find("a").css("background-color", "#95d8ff");
				$(this).find("span").addClass("dynatree-active");
			}else{
				$(this).find("span").removeClass("dynatree-active");
			}
		}

	});
}
/**
 * 트리명칭 CSS 함수(탭 안의 TREE)
 */
function getFontCss(treeId, treeNode) {
	return (!!treeNode.highlight) ? {
		color : "#083a61",
		"font-weight" : "bold"		
	} : {
		color : "#333333",
		"font-weight" : "normal"
	};
}

/**
 * 트리명칭 CSS 함수(메인 TREE)
 */
function getMainFontCss(treeId, treeNode) {
	return (!!treeNode.highlight) ? {
		color : "#083a61",
		"font-weight" : "bold"		
	} : {
		color : "#333333",
		"font-weight" : "normal"
	};
}

////////////////////////////////////////////////////////////////////////////////
//트리 이벤트
////////////////////////////////////////////////////////////////////////////////
/**
* 트리 노드 컨트롤 함수
* @param id	tree가 담겨져 있는 <ul> id
* @param func	CHK : 전체 체크 UN_CHK : 전체 체크 해제 EXP : 트리 노드 전체 열기 UN_EXP : 트리 노드 전체 닫기
*/
function treeNodeControl(id, func) {
	//var zTree = $.fn.zTree.getZTreeObj(id);

	if (func == "CHK") {
		$("#"+id).dynatree("getRoot").visit(function(dtnode){
            dtnode.select(true);
        });
        return false;
		//zTree.checkAllNodes(true);
	} else if (func == "UN_CHK") {
		$("#"+id).dynatree("getRoot").visit(function(dtnode){
            dtnode.select(false);
        });
        return false;
		//zTree.checkAllNodes(false);
	} else if (func == "EXP") {
		$("#"+id).dynatree("getRoot").visit(function(dtnode){
			dtnode.expand(true);
	    });
	    return false;
		//zTree.expandAll(true);
	} else if (func == "UN_EXP") {
		$("#"+id).dynatree("getRoot").visit(function(dtnode){
			dtnode.expand(false);
		});
		return false;
		zTree.expandAll(false);
	}
	
}

/**
 * 그룹, 분류 데이터 여부에 따른 화면 크기 조절
 */
function sizeBoxDisplay(clsCount, grpCount){
	var searchGb = $("#searchGb").val();
	var wHeight = $(window).height();
	var wWidth = $(window).width();

	if(grpCount == 0) { // 그룹선택이 없을 경우
		
		$(".box1s").hide();
		$("#treeGrpData").empty();
		grpData = "";
		
		if (clsCount == 0) { // 분류선택이 없을 경우 [항목선택 화면을 늘리고 분류선택 화면은 hidden 시킨다.]
			if (searchGb == "M") {
				$(".box2s").hide();
				if ($('body').hasClass('wide')) {
					$('.lSide .treeBox.size6').css("height", (wHeight - 177) + "px");
					$('#treeItmData').css("height", (wHeight - 177) + "px");
				} else {
					$('.lSide .treeBox.size6').css("height", "624px");
					$("#treeItmData").css('height', 624);
				}
			}
			$("#treeClsData").empty();
			$("#itmTitle").css('margin-top', 0);

			// 탭생성시 사용하기 위해 분류Data를 전역변수에 담아놓는다.
			// 비어있을 경우도 담는다.
			clsData = "";
			//기본화면 상태의 size를 등록해놓는다.
			centerDivH = 624;
			centerItmH = 624;
		} else {
			$("#clsTitle").css('margin-top', 0);
			$("#itmTitle").css('margin-top', 6);
			if (searchGb == "M") {
				$(".box2s").show();
				if ($('body').hasClass('wide')) {
					$('.lSide .treeBox.size6').css("height", (wHeight / 2 - 137) + "px");
					$('#treeItmData').css("height", (wHeight / 2 - 137) + "px");
					$('#treeClsData').css("height", (wHeight / 2 - 137) + "px");
				} else {
					$('.lSide .treeBox.size6').css("height", "264px");
					$("#treeItmData").css('height', 264);
					$("#treeClsData").css('height', 264);
				}
			}
			//기본화면 상태의 size를 등록해놓는다.
			centerDivH = 264;
			centerItmH = 264;
			centerClsH = 264;
		}
	} else {
		$(".box1s").show();
		$("#clsTitle").css('margin-top', 6);
		$("#itmTitle").css('margin-top', 6);
		
		if (clsCount == 0) { // 분류선택이 없을 경우 [항목선택 화면을 늘리고 분류선택 화면은 hidden 시킨다.]
			if (searchGb == "M") {
				$(".box2s").hide();
				if ($('body').hasClass('wide')) {
					$('.lSide .treeBox.size6').css("height", (wHeight / 2 - 137) + "px");
					$('#treeGrpData').css("height", (wHeight / 2 - 137) + "px");
					$('#treeItmData').css("height", (wHeight / 2 - 137) + "px");
				} else {
					$('.lSide .treeBox.size6').css("height", "264px");
					$("#treeGrpData").css('height', 264);
					$("#treeItmData").css('height', 264);
				}
			}
			$("#treeClsData").empty();

			// 탭생성시 사용하기 위해 분류Data를 전역변수에 담아놓는다.
			// 비어있을 경우도 담는다.
			clsData = "";
			//기본화면 상태의 size를 등록해놓는다.
			centerDivH = 264;
			centerItmH = 264;
			centerGrpH = 264;
		} else {
			if (searchGb == "M") {
				$(".box2s").show();
				if ($('body').hasClass('wide')) {
					$('.wide .lSide .treeBox.size6').css("height", (wHeight / 3 - 123) + "px");
					$('#treeGrpData').css("height", (wHeight / 3 - 123) + "px");
					$('#treeItmData').css("height", (wHeight / 3 - 123) + "px");
					$('#treeClsData').css("height", (wHeight / 3 - 123) + "px");
				} else {
					$('.lSide .treeBox.size6').css("height", "144px");
					$("#treeGrpData").css('height', 144);
					$("#treeItmData").css('height', 144);
					$("#treeClsData").css('height', 144);
				}
			}
			//기본화면 상태의 size를 등록해놓는다.
			centerDivH = 144;
			centerItmH = 144;
			centerClsH = 144;
			centerGrpH = 144;
		}		
	}

}

/**
 * 탭 이동시 트리 선택정보를 확인 재설정
 * @param id
 */
function treeSelectChkData(treeData) {
	treeUnChkData(treeData);
	
	if(selectNode != undefined && selectNode != "" && selectNode.length > 0){
		for(var z=0; z<treeData.length; z++){
			for(var i=0; i<selectNode.length; i++){
				if(treeData[z].key == selectNode[i].value) treeData[z].select = true;
			}
			if( !gfn_isNull(treeData[z].children) && treeData[z].children.length > 0){
				childSelectChkData(treeData[z].children);
			}
		}
	}

	function treeUnChkData(treeData) {
		if(selectNode != undefined && selectNode != "" && selectNode.length > 0){
			for(var x=0; x<treeData.length; x++){
				treeData[x].select = false;
				if(treeData[x].children != undefined){
					treeUnChkData(treeData[x].children);
				}
			}
		}
	}
	
	function childSelectChkData(childData){
		for(var y=0; y<childData.length; y++){
			for(var i=0; i<selectNode.length; i++){
				if(childData[y].key == selectNode[i].value) childData[y].select = true;
			}
		}
	}
	
	return treeData;
}
