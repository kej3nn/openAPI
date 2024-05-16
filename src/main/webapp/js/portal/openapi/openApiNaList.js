/**
 * @(#)openApiNaList.js 1.0 2019/10/11
 * 
 * Open API 목록 리스트 화면 스크립트(국회사무처)
 * 
 * @author JHKIM
 * @version 1.0 2019/10/11
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
		V: "<a href=\"javascript:;\"><span class=\"sv01\">시각화</span></a>",
		S: "<a href=\"javascript:;\"><span class=\"sv02\">표</span></a>",
		C: "<a href=\"javascript:;\"><span class=\"sv03\">차트</span></a>",
		M: "<a href=\"javascript:;\"><span class=\"sv04\">지도</span></a>",
		A: "<a href=\"javascript:;\"><span class=\"sv05\">API</span></a>",
		F: "<a href=\"javascript:;\"><span class=\"sv06\">파일</span></a>",
		L: "<a href=\"javascript:;\"><span class=\"sv07\">링크</span></a>"
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
					if ( typeof data === 'object' ) {
						for ( var i in data ) {
							$("button[id^=btnCateId][data-gubun="+data[i]+"]").addClass("on");
						}
					} else if ( typeof data === 'string' ) {
						$("button[id^=btnCateId][data-gubun="+data+"]").addClass("on");
					}
					var dataGubun = $("[id^=btnCate].on:eq(0)").attr("data-gubun");
					$("#selMbCateId").val(dataGubun);
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
		url : "/portal/openapi/selectInfsOpenApiListPaging.do",
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
    
    // 이전에 표시된 데이터를 초기화합니다.
    list.empty();
    
    if (datas.length > 0) {
        for (var i in datas) {
            data = datas[i];
            
            item = $(template.item);
            item.find(".opentyTagNm").text(data.opentyTagNm);
            
            var cateIdIdx = data.cateId.substr(2, 1) || "1";
            if (Number(cateIdIdx) > 5) {
                cateIdIdx = "1";
            }
            
            item.find(".bchead").addClass("lb0" + cateIdIdx);
            item.find(".cateNm").text(data.cateNm);
            item.find(".m_cate").text(data.cateNm);
            item.find(".infaNm").text(data.infaNm)
                .bind("click", {
                    infaId: data.infaId,
                    opentyTag: data.opentyTag,
                    openSrv: data.openSrv
                }, function(event) {
                    selectInfaDtl(event.data);
                });
            item.find(".infaExp").text(com.wise.util.ellipsis(data.infaExp, 47));
            item.find(".openYmd").text(data.openYmd);
            list.append(item);
        }
    } else {
        list.append("조회된 데이터가 없습니다.");
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
		
		if ( !com.wise.util.isEmpty(srv[0]) && cd == 'A' ) {
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
 * 서비스 상세화면으로 이동한다.
 */
function selectInfaDtl(data) {
	var srv = parseSrvCd(data.openSrv);
	
	if ( com.wise.util.isEmpty(data.infaId) )	return;
	
	// 이전에 선택했던 API에 대한 정보를 초기화합니다.
    $("#searchForm #infId").remove();
    $("#searchForm #infSeq").remove();
	
	addInputHidden({
		formId: "searchForm",
		objId: "infId",
		val: data.infaId
	});

    
	addInputHidden({
		formId: "searchForm",
		objId: "infSeq",
		val: srv.seq[0]
	});
	
	goSelect({
		url: "/portal/data/service/selectAPIServicePage.do/" + data.infaId,
        form:"searchForm",
        method: "post",
        data:[{
            name:"isKeepSchParam",
            value: "Y"
        }]
    });
}
