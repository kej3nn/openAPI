/*
 * @(#)easyStatSchPopTree.js 1.0 2019/07/25
 */

/**
 * 간편통계 팝업 트리 관련 처리 스크립트 파일이다.
 * 
 * @author JHKIM
 * @version 1.0 2019/07/25
 */

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


function itmStatDivSet(statblId) {
	var formObj = $("form[name=statsEasy-mst-form]");
	var statblId = $("#statblId").val();

	// 그룹 정보를 [통계검색]화면의 DIV에서 받아서 세팅한다.
	var grpIdNm = "grp" + statblId;
	// 생성된 탭의 항목DIV ID를 변경한다. 
	formObj.find("ul[id^='treeGrpDataTab']").attr('id', grpIdNm);
	var treeGrpObj = $("#treeGrpData").dynatree("getTree");
	if ( gfn_isNull(treeGrpObj.tnRoot.childList) ) {	
		formObj.find("button[name=callPopGrp]").hide(); // 데이터가 없으면 버튼을 보이지 않게 한다.
	} else {
		var grpNodes = treeGrpObj.tnRoot.childList;
		var dynaData = new Array();
		
		$.each(grpNodes, function(key, value){
			var grpTreeData = new Object();
			grpTreeData.title = value.data.title;
			grpTreeData.key = value.data.key;
			grpTreeData.select = value.bSelected;
			grpTreeData.isFolder = value.data.isFolder;
			grpTreeData.expand = true;
			grpTreeData.children = childMake(value.childList);
			dynaData.push(grpTreeData);
		});
		setMakeTabTree(grpIdNm, dynaData);

		// 세팅된 트리에서 체크된 항목을 hidden으로 생성
		makeItmTreeChk(grpIdNm, "chkGrps");
	}
	
	// 항목 정보를 [통계검색]화면의 DIV에서 받아서 세팅한다.
	var itmIdNm = "itm" + statblId;
	// 생성된 탭의 항목DIV ID를 변경한다. 
	formObj.find("ul[id^='treeItmDataTab']").attr('id', itmIdNm);
	var treeItmObj = $("#treeItmData").dynatree("getTree");
	if ( gfn_isNull(treeItmObj.tnRoot.childList.length) ) {	
		formObj.find("button[name=callPopItm]").hide(); // 데이터가 없으면 버튼을 보이지 않게 한다.
	} else {
		var itmNodes = treeItmObj.tnRoot.childList;
		var dynaData = new Array();
		
		$.each(itmNodes, function(key, value){
			var itmTreeData = new Object();
			itmTreeData.title = value.data.title;
			itmTreeData.key = value.data.key;
			itmTreeData.select = value.bSelected;
			itmTreeData.isFolder = value.data.isFolder;
			itmTreeData.expand = true;
			itmTreeData.children = childMake(value.childList);
			dynaData.push(itmTreeData);
		});
		setMakeTabTree(itmIdNm, dynaData);

		// 세팅된 트리에서 체크된 항목을 hidden으로 생성
		makeItmTreeChk(itmIdNm, "chkItms");
	}

	// 분류 정보를 [통계검색]화면의 DIV에서 받아서 세팅한다.
	var clsIdNm = "cls" + statblId;
	// 생성된 탭의 분류DIV ID를 변경한다.
	formObj.find("ul[id^='treeClsDataTab']").attr('id', clsIdNm);
	var treeClsObj = $("#treeClsData").dynatree("getTree");
	if (gfn_isNull(treeClsObj.tnRoot.childList)) {	
		formObj.find("span[class=spanCls]").hide(); // 데이터가 없으면 버튼을 보이지 않게 한다.
	} else {
		var clsNodes = treeClsObj.tnRoot.childList;
		var dynaData = new Array();
		
		$.each(clsNodes, function(key, value){
			var clsTreeData = new Object();
			clsTreeData.title = value.data.title;
			clsTreeData.key = value.data.key;
			clsTreeData.select = value.bSelected;
			clsTreeData.isFolder = value.data.isFolder;
			clsTreeData.expand = true;
			clsTreeData.children = childMake(value.childList);
			dynaData.push(clsTreeData);
		});
		setMakeTabTree(clsIdNm, dynaData);

		// 세팅된 트리에서 체크된 항목을 hidden으로 생성
		makeItmTreeChk(clsIdNm, "chkClss");
	}

	/* 항목 분류 버튼 이벤트 설정 */
	//itmStatDivEvent();
	
	function childMake(data){
		var reData = new Array();
		if(data != undefined){
			$.each(data, function(key, value){
				var treeData = new Object();
				
				treeData.title = value.data.title;
				treeData.key = value.data.key;
				treeData.select = value.bSelected;
				treeData.isFolder = value.data.isFolder;
				treeData.expand = true;
				treeData.children = childMake(value.childList);
				
				reData.push(treeData);
			});
		}
		return reData;
	}
}

/**
 * 그룹/항목/분류 선택 hidden만 생성
 * 
 * @param treeId
 * @param inputNm
 */
function makeItmTreeChk(treeId, inputNm) {
	var formObj = $("form[name=statsEasy-mst-form]");

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
 * 탭 안의 통계표 항목/분류 트리 세팅
 * @Param gubun :	I=항목, C=분류, G=그룹
 */
function statsTreeLoad(gubun) {
	var formObj = $("form[name=statsEasy-mst-form]");
	var statblId = $("#statblId").val();
	
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
	var formObj = $("form[name=statsEasy-mst-form]");

	// 항목 정보를 [통계검색]화면의 DIV에서 받아서 세팅한다.
	var itmIdNm = "itm" + $("#statblId").val();
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
	var clsIdNm = "cls" + $("#statblId").val();
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
		formObj.find(".optSC-sect").closest("li").hide();	// 피봇설정 분류 숨김
	}
}
/**
 * 그룹 트리 후 처리
 */
function afterStatsGrpTree(data) {
	var objTab = getTabShowObj();// 탭이 open된 객체가져옴
	var formObj = objTab.find("form[name=statsEasy-mst-form]");

	// 항목 정보를 [통계검색]화면의 DIV에서 받아서 세팅한다.
	var grpIdNm = "grp" + $("#statblId").val();
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
		formObj.find(".optSG-sect").closest("li").hide();	// 피봇설정 그룹 숨김
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
	
	var liCnt = $("#"+treeId).find("li").length;
	if(liCnt > 1){
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

////////////////////////////////////////////////////////////////////////////////
//트리 검색
////////////////////////////////////////////////////////////////////////////////
/**
* 생성된 탭의 트리 검색용
* @param treeId	트리의 ID
* @param keyWord	검색어
*/
function searchNode(treeId, keyWord) {
	
 keyWord = (keyWord.replace(/ /g, '')).toUpperCase();
	var liCnt = $("#"+treeId).find("li").length;//띄어쓰기, 대소문자 구문없이..
	if(liCnt > 1){
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