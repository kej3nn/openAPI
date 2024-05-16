/**
 * @(#)infsList.js 1.0 2019/08/13
 * 
 * 사전정보공개 목록 스크립트 파일이다.
 * 
 * @author JHKIM
 * @version 1.0 2019/08/13
 */
////////////////////////////////////////////////////////////////////////////////
// GLOBAL VARIABLE
////////////////////////////////////////////////////////////////////////////////

// 템플릿 객체
var template = {
	item: 
		"<div class=\"list_box\">" +
		"	<div>" +
		"		<span class=\"m_cate\"></span>" +
		"		<span class=\"opentyTagNm ot01\"></span>" +
		"	</div>" +
		"	<div class=\"box_content\">" +
		"		<div class=\"bchead\">" +
		"			<span class=\"cateNm\"></span>" +
		"		</div>" +
		"		<div class=\"list_box_content\">" +
		"			<div class=\"list_box_head\">" +
		"				<a href=\"javascript:;\"><span class=\"infaNm\"></span></a>" +
		"				<div class=\"openYmd\"></div>" +
		"			</div>" +
		"			<div class=\"list_box_cont m_none\">" +
		"				<div class=\"infaExp\"></div>" +
		"			</div>" +
		"		</div>" +
		"	</div>" +
		"</div>",
	srv: {
		V: "<a href=\"javascript:;\" title=\"시각화\"><span class=\"sv01\">시각화</span></a>",
		S: "<a href=\"javascript:;\" title=\"표\"><span class=\"sv02\">표</span></a>",
		C: "<a href=\"javascript:;\" title=\"차트\"><span class=\"sv03\">차트</span></a>",
		M: "<a href=\"javascript:;\" title=\"지도\"><span class=\"sv04\">지도</span></a>",
		A: "<a href=\"javascript:;\" title=\"API\"><span class=\"sv05\">API</span></a>",
		F: "<a href=\"javascript:;\" title=\"파일\"><span class=\"sv06\">파일</span></a>",
		L: "<a href=\"javascript:;\" title=\"링크\"><span class=\"sv07\">링크</span></a>"
	}
};

////////////////////////////////////////////////////////////////////////////////
// SCRIPT INIT
////////////////////////////////////////////////////////////////////////////////
$(function() {
	
	initComp();
	
	bindEvent();
});

////////////////////////////////////////////////////////////////////////////////
// 초기화 함수
////////////////////////////////////////////////////////////////////////////////
function initComp() {
	
	setSearchParamButton();	// 히든 파라미터에 따라 버튼 선택처리
	
	loadInfsList($("input[name=page]").val());
}

function loadInfsList(page) {
	page = page || 1;
	
	gfn_showLoading();
	
	var loadSuccess = function() {
		var deferred = $.Deferred();
		try {
			selectInfsList(page);
			deferred.resolve(true);
		} catch (err) {
			deferred.reject(false);
		}
		return deferred.promise();
	};
	
	loadSuccess().done(function(message) {
	}).always(function() {
		setTimeout(function() {
			gfn_hideLoading();
		}, 100);
	});
}

/**
 * 전달된 히든 파라미터에 따라 버튼 선택처리 
 */
function setSearchParamButton() {
	var formData = $("#searchForm").serializeObject();
	Object.keys(formData).map(function(key, idx) {
		if ( key.indexOf("schHdn") == 0 ) {
			var data = formData[key];

			switch (key) {
			case "schHdnCateId":
				if ( data.length > 0 ) {
					$("#btnCateAll").removeClass("on");
					$("#btnCateAll").attr("aria-selected", false);
					if ( typeof data === 'object' ) {
						for ( var i in data ) {
							$("button[id^=btnCateId][data-gubun="+data[i]+"]").addClass("on");
							$("button[id^=btnCateId][data-gubun="+data[i]+"]").attr("aria-selected", true);
						}
					} else if ( typeof data === 'string' ) {
						$("button[id^=btnCateId][data-gubun="+data+"]").addClass("on");
						$("button[id^=btnCateId][data-gubun="+data+"]").attr("aria-selected", true);
					}
					var dataGubun = $("[id^=btnCate].on:eq(0)").attr("data-gubun");
					$("#selMbCateId").val(dataGubun);
				}
				break;
			case "schHdnSrvCd":
				if ( data.length > 0 ) {
					$("#btnSrvAll").removeClass("on");
					$("#btnSrvAll").attr("aria-selected", false);
					for ( var i in data ) {
						$("button[id^=btnSrvId][data-gubun="+data[i]+"]").addClass("on");
						$("button[id^=btnSrvId][data-gubun="+data[i]+"]").attr("aria-selected", true);
					}
					
					// 모바일 선택처리
					$("a[id^=btnMbSrv]").removeClass("on");
					$("button[id^=btnSrv]").each(function() {
						if ( $(this).hasClass("on") ) {
							$("a[id^=btnMbSrv][data-gubun="+$(this).attr("data-gubun")+"]").addClass("on");
						}
					});
				}
				break;
			case "schHdnTag":
				if ( data.length > 0 ) {
					$("#btnTagAll").removeClass("on");
					$("#btnTagAll").attr("aria-selected", false);
					for ( var i in data ) {
						$("button[id^=btnTagId][data-gubun="+data[i]+"]").addClass("on");
					}
					
					// 모바일 선택처리
					$("a[id^=btnMbTag]").removeClass("on");
					$("button[id^=btnTag]").each(function() {
						if ( $(this).hasClass("on") ) {
							$("a[id^=btnMbTag][data-gubun="+$(this).attr("data-gubun")+"]").addClass("on");
							$("a[id^=btnMbTag][data-gubun="+$(this).attr("data-gubun")+"]").attr("aria-selected", true);
						}
					});
				}
				break;	
			}
		}
	});
	
}

/**
 * 정보공개 목록을 조회한다.
 * @param page	페이지
 * @returns
 */
function selectInfsList(page) {
	page = page || 1;
	doSearch({
		url : "/portal/infs/list/selectInfsListPaging.do",
		page : page,
		before : beforeSelectInfsList,
		after : afterSelectInfsList,
		pager : "result-sect-pager",
		counter: {
			count:"result-count-sect",
            pages:"result-pages-sect"
		}
	});
}

/**
 * 정보공개 목록 조회 전처리
 */
function beforeSelectInfsList(options) {
	var form = $("#searchForm");
	
	if (com.wise.util.isEmpty(options.page)) {
		form.find("[name=page]").val("1");
	} else {
		form.find("[name=page]").val(options.page);
	}
	$("input[name=rows]").val($("#selRows").val());		// 조회행 수
	
	// 정렬 값이 없을경우 기본값으로 공개일자 처리
	if ( com.wise.util.isEmpty(form.find("input[name=schVOrder]").val()) ) {
		addInputHidden({
			formId: "searchForm",
			objId: "schVOrder",
			val: "D"
		});
		form.find("#btnVOrderDate").addClass("on");
	}
	
	var data = form.serializeObject();
	
	return data;
}

/**
 * 정보공개 목록 조회 후처리
 * @param datas
 * @returns
 */
function afterSelectInfsList(datas) {
	var item = "",
		data = null,
		list = $("#result-sect-list");
	
	list.empty();
	if ( datas.length > 0 ) {
		for ( var i in datas ) {
			data = datas[i];
			
			item = $(template.item);
			item.find(".opentyTagNm").text(data.opentyTagNm);
			
			// 서비스 색 표시
			viewOpenSrv(item.find(".opentyTagNm").parent()
					, { infaId: data.infaId,
						opentyTag: data.opentyTag,
						openSrv: data.openSrv
					});
			
			// 아이콘 카테고리 ID에 따라 달라진다
			var cateIdIdx = data.cateId.substr(2, 1) || "1";
			if ( Number(cateIdIdx) > 5 ) {
				cateIdIdx = "1";
			}
			
			item.find(".bchead").addClass("lb0" + cateIdIdx);
			item.find(".m_cate").text(data.cateNm);
			item.find(".cateNm").text(data.cateNm);
			item.find(".infaNm").parent("a").attr("title", data.infaNm);
			item.find(".infaExp").text(com.wise.util.ellipsis(data.infaExp, 40));
			item.find(".openYmd").text(data.openYmd);
			item.find(".infaNm").text(data.infaNm)
				.bind("click", {
					infaId: data.infaId,
					opentyTag: data.opentyTag,
					openSrv: data.openSrv
					}, function(event) {
						selectInfaDtl(event.data);
						return false;
					});
			/*
			item.find(".infaNm").parent().bind("keydown", {
				infaId: data.infaId,
				opentyTag: data.opentyTag,
				openSrv: data.openSrv
			}, function(event) {
				if (event.which == 13) {
					selectInfaDtl(event.data);
					return false;
				}
			});*/
			item.find(".infaNm").parent().attr("href", "javascript: bindSelectInfaDtl('"+data.infaId+"', '"+data.opentyTag+"', '"+data.openSrv+"')");	// 2021.11.16 - 접근성처리
			
			list.append(item);
		}
	}
	else {
		list.append("조회된 데이터가 없습니다.");
	}
}

/**
 * 서비스 아이콘을 표시한다
 * @param item
 * @param openSrv
 * @returns
 */
function viewOpenSrv(item, options) {
	options = options || {};
	var srv = "", otData = {}, elmtSrv = null,
		arrSrv = parseSrvCd(options.openSrv);
	
	for ( var i in arrSrv.cd ) {
		
		srv = arrSrv.cd[i];
		seq = arrSrv.seq[i];
		elmtSrv = $(template.srv[srv]);
		
		// 2021.11.10 - 웹접근성 처리
		var eventData = {
				infaId: options.infaId,
				opentyTag: options.opentyTag,
				openSrv: options.openSrv,
				srvSeq: seq
			};
		elmtSrv.on("click", eventData, function(event) {
				selectInfaDtl(event.data);
				return false;
				
		}).attr("href", "javascript: bindSelectInfaDtl('"+options.infaId+"', '"+options.opentyTag+"', '"+options.openSrv+"', '"+seq+"')");	// 2021.11.16 - 접근성처리
		/*
		}).on("keydown", eventData, function(event) {
			if (event.which == 13) {
				selectInfaDtl(event.data);
				return false;
			}
		});*/
		
		item.append(elmtSrv);
	}
}

/**
 * 서비스 코드를 파싱한다
 * @param openSrv	DB에서 조회되는 서비스코드
 */
function parseSrvCd(openSrv) {
	openSrv = openSrv || "";
	
	var rtn = { cd: [], seq: [] },
		srv = null,
		arrSrv = openSrv.split(",");
	
	for ( var i in arrSrv ) {
		srv = arrSrv[i].split('-');
		cd = srv[0];
		seq = srv[1];
		
		if ( !com.wise.util.isEmpty(srv[0]) ) {
			rtn.cd.push(srv[0]);
			rtn.seq.push(srv[1]);
		}
	}
	return rtn;
}


/**
 * 폼에 히든파라미터 등록
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
 * 서비스 상세화면으로 이동한다.(바인딩함수, 접근성..)
 */
function bindSelectInfaDtl(infaId, opentyTag, openSrv, srvSeq) {
	srvSeq = srvSeq || 0;
	selectInfaDtl({
		infaId: infaId,
		opentyTag: opentyTag,
		openSrv: openSrv,
		srvSeq: srvSeq
	})
}

/**
 * 서비스 상세화면으로 이동한다.
 */
function selectInfaDtl(data) {
	data.srvSeq = data.srvSeq || 0;
	var $form = $("#searchForm");
	var obj = getOpentyTagData(data);
	var srv = parseSrvCd(data.openSrv);

	if ( com.wise.util.isBlank(obj.url) || com.wise.util.isEmpty(data.infaId) || com.wise.util.isEmpty(data.opentyTag) )	return;
	
	// 2021.11.16 - 파라미터 추가생성되는 버그 수정
	if ( $form.find("input[name="+obj.id+"]").length > 0 ) {
		$form.find("input[name="+obj.id+"]").val(data.infaId);
	}
	else {
		addInputHidden({
			formId: "searchForm",
			objId: obj.id,
			val: data.infaId
		});
	}
	
	if(gfn_isNull(obj.gubun)) {
		addInputHidden({
			formId: "searchForm",
			objId: obj.gubun,
			val: data.srvSeq == 0 ? srv.seq[0] : data.srvSeq
		});
	} else if ( $form.find("input[name="+obj.gubun+"]").length > 0 ) {
		$form.find("input[name="+obj.gubun+"]").val(data.srvSeq == 0 ? srv.seq[0] : data.srvSeq);
	}
	else {
		addInputHidden({
			formId: "searchForm",
			objId: obj.gubun,
			val: data.srvSeq == 0 ? srv.seq[0] : data.srvSeq
		});
	}
	
	goSelect({
		url: obj.url,
        form:"searchForm",
        method: "post",
        data:[{
            name:"isKeepSchParam",
            value: "Y"
        }]
    });
}

/**
 * 정보셋 구분 데이터 정보를 조회한다.
 */
function getOpentyTagData(data) {
	var obj = {};
	
	switch ( data.opentyTag ) {
	case "D":
		obj.url = "/portal/doc/docInfPage.do/" + data.infaId;
		obj.id = "docId";
		obj.gubun = "seq";
		break;
	case "O":
		obj.url = "/portal/data/service/selectServicePage.do/" + data.infaId;
		obj.id = "infId";
		obj.gubun = "infSeq";
		break;
	case "S":
		var callStatType = "S";
		if(data.srvSeq=="2") callStatType = "C";
		
		obj.url = "/portal/stat/selectServicePage.do/" + data.infaId+callStatType;
		obj.id = "statblId";
		obj.gubun = "";
		break;
	}
	return obj
}
