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
		"<tr>" + 
			"<td class=\"rowNum\">" +
			"</td>"+
			"<td class=\"orgNm\">" +
			"</td>"+
			"<td class=\"apiNm\">" +
			"</td>"+
			"<td class=\"apiTagNm\">" +
			"</td>"+
			"<td><a class=\"apiUrl\" target=\"_blank\" href= \"\">바로가기</a>" +
			"</td>"+
		"</tr>" 
		,
	none: 
		 "<tr>"                                                              +
         	"<td colspan=\"5\" class=\"noData\">해당 자료가 없습니다.</td>" +
         "</tr>"
	,
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
			selectSupplyList(page);
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
			case "schHdnOrgCd":
				if ( data.length > 0 ) {
					$("#btnOrgAll").removeClass("on");
					if ( typeof data === 'object' ) {
						for ( var i in data ) {
							$("button[id^=btnOrgCd][data-gubun="+data[i]+"]").addClass("on");
						}
					} else if ( typeof data === 'string' ) {
						$("button[id^=btnOrgCd][data-gubun="+data+"]").addClass("on");
					}
					var dataGubun = $("[id^=btnOrg].on:eq(0)").attr("data-gubun");
					$("#selMbOrgCd").val(dataGubun);
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
function selectSupplyList(page) {
	page = page || 1;
	doSearch({
		url : "/portal/openapi/selectOpenApiSupplyListPaging.do",
		page : page,
		before : beforeSelectSupplyList,
		after : afterSelectSupplyList,
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
function beforeSelectSupplyList(options) {
	var form = $("#searchForm");
	
	if (com.wise.util.isEmpty(options.page)) {
		form.find("[name=page]").val("1");
	} else {
		form.find("[name=page]").val(options.page);
	}
	$("input[name=rows]").val($("#selRows").val());		// 조회행 수
	
	var data = form.serializeObject();
	
	return data;
}

/**
 * 정보공개 목록 조회 후처리
 * @param datas
 * @returns
 */
function afterSelectSupplyList(datas) {
	var item = "",
		data = null,
		list = $("#result-sect-list");
	
	list.empty();
	if ( datas.length > 0 ) {
		for ( var i in datas ) {
			data = datas[i];
			
			item = $(template.item);
			item.find(".rowNum").text(data.ROW_NUM);
			item.find(".orgNm").text(data.orgNm);
			item.find(".apiNm").text(data.apiNm);
			item.find(".apiTagNm").text(data.apiTagNm);
			item.find(".apiUrl").attr("href",data.apiUrl);
			
			list.append(item);
		}
	}
	else {
		var row = $(template.none);
        
		list.append(row);
	}

	//생성 테이블 TR에 색지정
	$('#result-sect-list tr:even').css("backgroundColor","#fff");	// even 홀수
	$('#result-sect-list tr:odd').css("backgroundColor","#f5f5fc");	// odd 짝수
	
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
