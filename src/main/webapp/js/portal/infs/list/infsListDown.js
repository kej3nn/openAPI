/**
 * @(#)infsCont.js 1.0 2019/08/12
 * 
 * 사전정보공개 컨텐츠 스크립트 파일이다.
 * 
 * @author JHKIM
 * @version 1.0 2019/08/12
 */
////////////////////////////////////////////////////////////////////////////////
// GLOBAL VARIABLE
////////////////////////////////////////////////////////////////////////////////
var template = {
	exp: {
		title: "<a href=\"javascript:;\" title=\"\"></a>",
		cont: 
			"<div class=\"expCont\" style=\"display: none;\">" +
			"	<strong class=\"text_subheader\"></strong>" +
	   	 	"	<div class=\"infsDtlCont\"></div>" +
		 	"</div>"
	},
	list: {
		none: "<tr><td colspan=\"5\">조회된 데이터가 없습니다.</td></tr>",
		row:
			"<tr>" +
//			"	<td class=\"tscNum\"></td>" +
			"	<td class=\"chkItem m_none\">" +
			"		<input type=\"checkbox\" name=\"chkInfaId\" data-infaid=\"\">" +
			"	</td>" +
			"	<td class=\"tscBunya m_none\">" +
			"		<div class=\"bunyaB\">" +
//			"			<img src=\"/images/icon_bunyab01.png\">" +
			"			<span></span>" +
			"		</div>" +
			"	</td>" +
			"	<td class=\"tsubject_txt\">" +
//			"		<div class=\"bunya_list\">" +
//			"			<div class=\"bunyaT-m\">" +
//			"				<span class=\"m_cate\">분야별 공개</span>" +
//			"				<span class=\"ot01 infsTag\"></span>" +
//			"			</div>" +
//			"			<div class=\"bunyaT\">" +
			"				<strong class=\"infaNm\"></strong>" +
//			"				<span class=\"infaExp m_none\"></span>" +
//			"			</div>" +
			"			<span class=\"openYmd pc_none\"></span>" +
//			"		</div>" +
			"	</td>" +
//			"	<td class=\"tscSts m_none\"><span class=\"ot01 infsTag\"></span></td>" +
//			"	<td class=\"openYmd m_none\"></td>" +
			"</tr>"
	},
	choiceList: {
		none: "<tr><td colspan=\"3\">서비스를 선택해 주세요.</td></tr>",
		row:
			"<tr>" +
			"	<td class=\"chkItem m_none\">" +
			"		<input type=\"checkbox\" name=\"chkInfaId\" data-infaid=\"\">" +
			"	</td>" +
			"	<td class=\"tscNum\"></td>" +
			"	<td class=\"tsubject_txt\">" +
//			"		<div class=\"bunya_list\">" +
//			"			<div class=\"bunyaT\">" +
			"				<strong class=\"infaNm\"></strong>" +
//			"			</div>" +
//			"		</div>" +
			"	</td>" +
			"</tr>"
	},
	search: {
		item: "<li><a href=\"javascript:;\" name=\"\"><strong class=\"tit\"></strong></a></li>"
	}
};

////////////////////////////////////////////////////////////////////////////////
// SCRIPT INIT
////////////////////////////////////////////////////////////////////////////////
$(function() {
	// 컴포넌트 초기화
	initComp();
	
	bindEvent();
});

////////////////////////////////////////////////////////////////////////////////
// 초기화 함수
////////////////////////////////////////////////////////////////////////////////
function initComp() {
	// 트리 초기화
	initTree();
	
	// 초기 트리 사이즈 조절
	changeTreeAreaHeight();
}

/**
 * 트리를 초기화 한다.
 */
function initTree() {
	loadTree();	// 트리 로드
}

/**
 * 트리 로드
 */
function loadTree() {
	doAjax({
		url: "/portal/infs/cont/selectInfoCateTree.do",
		params: "cateDataGubun=" + $("input[name=cateDataGubun]").val(),
		callback: function(res) {
			var data = res.data;
			$("#treeObj").dynatree({
				//checkbox: true,
				selectMode: 3,
		        children: data,
		        onClick: function(node, event) {
					if ( !node.data.isFolder ) {

						//2023.01.02 웹접근성 처리
						$("#treeObj").find("a").each(function (e) {
							$(this).attr("title",$(this).attr("title").replace(" 선택됨",""));
						})
						$(node.li).find("a").attr("title",$(node.li).find("a").attr("title")+" 선택됨");
						//2023.01.02 웹접근성 처리

						selectInfsInfoRelList(node.data);
					}
				}
		    });
			
			$("#treeObj").dynatree("getTree").reload();
		}
	});
}

/**
 * 트리에 선택된 아이템을 확인한다.
 */
/*function bringCheckTreeItems() {
	var obj = [];
	var treeObj = $("#treeObj").dynatree("getSelectedNodes");
	
	if (treeObj.length > 0) {
		for ( var n in treeObj) {
			if( !treeObj[n].data.isFolder )  {
				obj.push(treeObj[n].data.key);
			}
		}
	}
	else {
		alert("분류를 선택해 주십시오.");
		return false;
	}
	return obj;
}*/

/**
 * 정보셋에 연결된 데이터들 조회
 * @param id	정보셋 ID
 * @returns
 */
function selectInfsInfoRelList(node) {
	//var arrCheckItems = _.uniqBy(bringCheckTreeItems()) || [];	// 체크된 항목 확인 후 중복제거
	//if ( arrCheckItems.length == 0 )	return false;

	doAjax({
		url: "/portal/infs/list/selectInfsInfoRelList.do",
		params: { paramInfaIds: [node.key] },
		callback: function(res) {
			
			// 초기 기본이미지 화면 숨김
			if ( $("#main-img-sect").css("display") == 'block' ) {
				$("#main-img-sect").hide();		// 기본이미지 숨기고
				$("#main-text-sect").show();	// 내용 표시
			}
			
			var data = res.data;
			afterInfsInfoRelList(data);
		}
	});

}

/**
 * 정보셋에 연결된 데이터 화면에 렌더링한다.(공공/통계)
 * @param data
 * @returns
 */
function afterInfsInfoRelList(datas) {
	var tbody = $("#result-list-sect");
	
	tbody.empty()
	
	if ( datas.length == 0 ) {
		$("div[id^=result-list-sect]").hide();
		tbody.append("<tr><td colspan=\"5\">조회된 데이터가 없습니다.</td></tr>");
		return false;
	}
	
	if ( datas.length > 0 ) {
		$("div[id^=result-list-sect]").show();
		
		for ( var i in datas ) {
			var data = datas[i];
			var row = $(template.list.row);
			
			row.find(".tscNum").text(Number(i)+1);
			row.find("input[name=chkInfaId]").attr("data-infaid", data.infaId);
			row.find("input[name=chkInfaId]").attr("title", data.infaNm + " 체크박스");
			row.find(".infaNm").text(data.infaNm);
			row.find(".bunyaB span").text(data.cateNm);
			row.find(".infsTag").text(data.opentyTagNm);
			row.find(".openYmd").text(data.openYmd);
			
			row.find(".chkItem").bind("click", function(event) {	// 전체선택 초기화
				if ( tbody.find("tr").length == tbody.find("input:checkbox:checked").length ) {
					$("#tbResultAllChk").prop("checked", true);
				}
				else {
					$("#tbResultAllChk").prop("checked", false);
				}
				
			});
			tbody.append(row);
		}

		// 전체선택 초기화
		$("#tbResultAllChk, #tbChoiceAllChk").attr("checked", false);
	}
}

/**
 * 다운로드받을항목으로 선택한 공개서비스를 목록에서 삭제한다.
 * @returns
 */
function deleteInfsInfoRelList() {
	var list = $("#choice-list-sect");
	var chkInputObj = $("#choice-list-sect input:checkbox:checked");
	
	if ( chkInputObj.length == 0 ) {
		alert("삭제할 행을 선택해 주십시오.");
		return false;
	}
	
	// 체크된 행 삭제
	for ( var i=0; i < chkInputObj.length; i++ ) {
		var infaId = $(chkInputObj[i]).attr("data-infaid");
		list.find("input[name=chkInfaId][data-infaid="+infaId+"]").closest("tr").remove();
	}
	
	// 번호 다시채번
	$("#choice-list-sect tr").each(function(i, o) {
		$(o).find(".tscNum").text(i+1);
	});
	
	$("#tbChoiceAllChk").attr("checked", false);
}

/**
 * 선택한 검색결과 서비스를 선택목록 리스트에 추가한다.
 * @returns
 */
function addChoiceItem() {
	var $items = $("#result-list-sect input[name=chkInfaId]:checked"),
		choiceItemArray = makeItemArray($items);
	
	if ( choiceItemArray.length == 0 ) {
		alert("서비스를 선택해 주세요.");
		return false;
	}
	
	// 선택한 검색결과와 이전에 추가시킨 데이터와 비교하여 중복체크(데이터 재정의)
	var filterArray = refineChoiceItem(choiceItemArray);
	
	// 데이터 표시
	renderChoiceItem(filterArray);
	
	// 선택한 검색결과의 체크박스 초기화
	$items.attr("checked", false);
	
	$("#tbResultAllChk").attr("checked", false);
}

/**
 * 검색결과 데이터의 선택된행을 목록데이로 생성한다.
 * @param $items  선택된 행 checkbox elements
 * @returns
 */
function makeItemArray($items) {
	var list = new Array();
	
	$items.each(function(i, input) {
        var $row = $(input).closest("tr");
        var infaId = $(input).attr("data-infaid");
        var infaNm = $row.find(".infaNm").text();
        list.push({
        	"infaId" : infaId,
        	"infaNm" : infaNm
        });
	});
	
	return list;
}

/**
 * 선택된 데이터를 재정의한다.(중복제거)
 * @param choiceList	선택된 데이터 목록
 * @returns
 */
function refineChoiceItem(choiceList) {
	var $items = $("#choice-list-sect input[name=chkInfaId]"),
		currentList = makeItemArray($items);
	
	return _.differenceBy(choiceList, currentList, "infaId");
}

/**
 * 데이터를 선택결과 리스트에 표시
 * @param datas
 * @returns
 */
function renderChoiceItem(datas) {
	var tbody = $("#choice-list-sect");
	
	if ( datas.length > 0 ) {
		
		var overAlert = false;
		for ( var i in datas ) {
			var data = datas[i];
			var row = $(template.choiceList.row);
			
			var dataCnt = tbody.find("tr").length;

			if(dataCnt < 10){ //다운로드 갯수 제한 10개까지..
				row.find(".tscNum").text(Number(i)+1);
				row.find("input[name=chkInfaId]").attr("data-infaid", data.infaId);
				row.find("input[name=chkInfaId]").attr("title", data.infaNm + " 선택박스");
				row.find(".infaNm").text(data.infaNm);
				
				row.find(".chkItem").bind("click", function(event) {	// 전체선택 초기화
					if ( tbody.find("tr").length == tbody.find("input:checkbox:checked").length ) {
						$("#tbChoiceAllChk").prop("checked", true);
					}
					else {
						$("#tbChoiceAllChk").prop("checked", false);
					}
					
				});
				tbody.append(row);
			}else{
				overAlert = true;
			}
		}
		
		// 번호 다시채번
		$("#choice-list-sect tr").each(function(i, o) {
			$(o).find(".tscNum").text(i+1);
		});
		
		// 10개이상일 경우 안내메세지
		if(overAlert){
			alert("일괄 다운로드 받는 목록이 초과 되었습니다.\n\n국회정보 일괄 다운로드는 10개까지 선택하실 수 있습니다.")
		}
	}
}

/**
 * 생성된 탭의 트리 검색용
 * @param keyWord	검색어
 */
function searchNode(keyWord) {
    keyWord = (keyWord.replace(/ /g, '')).toUpperCase();
	var liCnt = $("#treeObj").find("li").length;//띄어쓰기, 대소문자 구문없이..
	if(liCnt > 1){
		var keyType = "title";
		treeObjEvent("EXP");
		updateNodes(keyType, keyWord);
	}
}
/**
 * 검색에 결과에 따른 트리명칭 CSS적용 
 */
function updateNodes(keyType, keyWord) {
	$("#treeObj").find("li").each(function(event){
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
 * 초기 트리 사이즈 조절
 */
function changeTreeAreaHeight() {
	$(".content_tree").height($(".content_text").height());
	$("#treeObj").height($(".content_text").height() - 70);
}

/**
 * 파일을 다운로드 한다.
 */
function downloadFile() {
	try {
		var chkItems = $("#choice-list-sect input:checkbox[name=chkInfaId]:checked");
		
		if ( chkItems.length === 0 ) {
			alert("다운로드받을 서비스를 선택해 주십시오.");
			return false;
		}
		else if ( chkItems.length > 0 ) {
			chkItems.each(function(i, obj) {
				var element = $(obj);
				var infaId = element.attr("data-infaid") ;
				
				addInputHidden({
					formId: "form",
					objId: "schChkInfaId",
					val: infaId
				});
			});
			
			gfn_fileDownload({
		    	url: "/portal/infs/list/download.do",
		    	params: $("#form").serialize()
		    });
			
			$("input[name=schChkInfaId]").remove();
		}
		else {
			alert("다운로드받을 서비스를 체크해 주십시오.");
		}
	} catch(e) {
		$("input[name=schChkInfaId]").remove();
	}
}

/**
 * 파라미터를 추가한다(히든)
 * @param options
 * @returns
 */
function addInputHidden(options) {
	options.formId = options.formId || "";	// 폼 ID
	options.objId = options.objId || "";	// 오브젝트 ID
	
	if ( com.wise.util.isBlank(options.formId) || com.wise.util.isBlank(options.objId) )	return;
	
	var input = $("<input type=\"hidden\">");
	input.attr("id", options.objId).attr("name", options.objId).val(options.val);
	
	$("#" + options.formId).append(input);
}

/**
 * 이벤트를 바인딩한다.
 * @returns
 */
function bindEvent() {
	$("#btnAddGrid").bind("click", function(e) {
		addChoiceItem();
		return false;
	});
	
	$("#btnSelDelete").bind("click", function(e) {
		deleteInfsInfoRelList();
		return false;
	});
	
	$("#btnDownload").bind("click", function(e) {
		downloadFile();
		return false;
	});
	
	// 트리 전체열기
	$(".btn_open").bind("click", function(event) {
		treeObjEvent("EXP");
		return false;
	}).bind("keydown", function(event) {
		if (event.which == 13) {
			treeObjEvent("EXP");
			return false;
		}
	});
	// 트리 전체닫기
	$(".btn_close").bind("click", function(event) {
		treeObjEvent("UN_EXP");
		return false;
	}).bind("keydown", function(event) {
		if (event.which == 13) {
			treeObjEvent("UN_EXP");
			return false;
		}
	});
	
	// 검색결과 리스트에 추가된 항목 전체선택
	$("#tbResultAllChk").bind("click", function(event) {
		if ( $(this).is(":checked") ) {
			$("#result-list-sect input:checkbox").prop("checked", true);
		}
		else {
			$("#result-list-sect input:checkbox").prop("checked", false);
		}
	});
	// 선택리스트에 추가된 항목 전체 선택
	$("#tbChoiceAllChk").bind("click", function(event) {
		if ( $(this).is(":checked") ) {
			$("#choice-list-sect input:checkbox").prop("checked", true);
		}
		else {
			$("#choice-list-sect input:checkbox").prop("checked", false);
		}
	});
	
	// 검색
	$("input[name=txtSearchVal]").bind("keydown", function(event) {
		// 엔터키인 경우
		if (event.which == 13) {
			searchNode($(this).val());
			return false;
		}
	});
	
	$("#btnSearch").bind("click", function(event) {
		searchNode($("input[name=txtSearchVal]").val());
	});
	
}

/**
 * 분류 트리 열기/닫기 이벤트 처리
 * @param event
 * @returns
 */
function treeObjEvent(event) {
	switch (event) {
	case "EXP":
		$("#treeObj").dynatree("getRoot").visit(function(dtnode){
			dtnode.expand(true);
	    });
	    return false;
		break;
	case "UN_EXP":
		$("#treeObj").dynatree("getRoot").visit(function(dtnode){
			dtnode.expand(false);
		});
		break;
	
	}
}