/*
 * @(#)directStatSchTree.js 1.0 2018/06/25
 * 
 */
/**
 * 통계조회 트리 관련 스크립트 파일이다.
 * 
 * @author 김정호
 * @version 1.0 2018/06/25
 */
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
        }
    });
	
	$("#"+id).dynatree("getTree").reload();
	//웹접근성을 위해 추가
    $("#"+id).find(".dynatree-title").removeAttr("title");
    $("#"+id+" .dynatree-selected").find(".dynatree-title").attr("title","선택된 조건입니다");

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

function dynaStatClick(statblId, isFolder) {
	if (!isFolder) {
		selStat(statblId); // 항목선택/분류선택 리스트 호출
	}
}
////////////////////////////////////////////////////////////////////////////////
//트리 후처리
////////////////////////////////////////////////////////////////////////////////
function setStatTree(id, data) {
	
	$("#"+id).dynatree({
        selectMode: 3,
        children: data, //사용자 조작이 필수적인 부분 ! 트리뷰 데이터 소스가 들어가야 하는 부분, JSON방식으로 넘어오기면 하면 된다.

		onActivate : function(node) {
			if(!node.data.isFolder) {
        		showLoading();
        		setTimeout(function() {
        			dynaStatClick(node.data.key, node.data.isFolder);
        		}, 100);
        		
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
		//zTree.expandAll(false);
	}
	
}
