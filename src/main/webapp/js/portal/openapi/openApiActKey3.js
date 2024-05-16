/*
 * COPYRIGHT (C) 2013 WISEITECH CO., LTD. ALL RIGHTS RESERVED.
 */

/**
 * 인증키 관련 스크립트이다.
 *
 * @author soft-on
 * @version 1.0 2018/02/08
 */
$(function() {
    // 컴포넌트를 초기화한다.
    initComp();
    
    // 이벤트를 바인딩한다.
    bindEvent();
    
});

////////////////////////////////////////////////////////////////////////////////
//글로벌 변수
////////////////////////////////////////////////////////////////////////////////
var pageTemplates = {};
var templates = {
		data : "<tr>"
				+" 	<td class=\"title left\"><p class=\"key actKey\"></p>"
				+"  <ul class=\"mobile-info\">"
				+"  	<li class=\"useNm\"></li>"
				+"  	<li class=\"regDttm\"></li>"
				+"  	<li class=\"callCnt\"></li>"
				+"  	<li class=\"keyState\"></li>"
				+" 	<td class=\"division useNm\"></td>"
				+" 	<td class=\"date regDttm\"></td>"
				+" 	<td class=\"counter callCnt\"></td>"
				+" 	<td class=\"counter keyState\"></td>"
				+" </tr>"
		, data_m : "<li>"
				+"	<strong class=\"tit\"></strong>"
				+"	<p class=\"cont\"></p>"
				+"	<dl>"
				+"	<dt class=\"hide\">발급일</dt>"
				+"	<dd class=\"ty_B first\"></dd>"
				+"	<dt>호출</dt>"
				+"	<dd></dd>"
				+"	<dt class=\"hide\">사용여부</dt>"
				+"	<dd class=\"ty_B\"></dd>"
				+"	</dl>"
				+"</li>"
		, none : "<tr><td colspan=\"5\">해당 자료가 없습니다.</td></tr>"
		, none_m : "<li class=\"noData\">해당 자료가 없습니다.</li>"
};
var openAPIListData = {};


////////////////////////////////////////////////////////////////////////////////
//초기화 함수
////////////////////////////////////////////////////////////////////////////////
function initComp() {
	
}

/**
 * 이벤트를 바인딩한다.
 */
function bindEvent() {
}

/**
 * 탭 선택 이벤트
 * @param tabIndex
 */
function selectTab(tabIndex) {
}

/**
 * 인증키 발급 내역 화면 이벤트 바인딩
 */
function bindContent_0() {
	bindActKeyBtn();
	bindDelActKeyBtn();
	searchActKey();
}
/**
 * 인증키 발급 화면 이벤트 바인딩
 */
function bindContent_1() {
	// 인증키 발급 요청 클릭 이벤트
	$('#create-actKey-btn').bind('click', function() {
		createActKey();
		return false;
	});
}
/**
 * Open API 테스트 화면 이벤트 바인딩
 */
function bindContent_2() {
	bindActKeyBtn();
	searchOpenAPI();
	// 검색 버튼 클릭
	$('#api-search-btn').bind('click', function() {
		searchOpenAPI();
		return false;
	});
	// 검색창에 엔터키 이벤트
	$('[name=infNm]').bind("keydown", function(event) {
	    if (event.which == 13) {
			searchOpenAPI();
	        return false;
	    }
	});
	
	// API 명 셀렉트박스 이벤트
	$('#APIname').bind("change", function() {
		$('#api-ep-url').text(openAPIListData[$(this).val()].uri);
	});
	
	// API 출력 버튼 이벤트
	$('#api-test-btn').bind("click", function() {
		outputOpenAPI($('#APIname').val());
	});
}

function bindContent_3() {
	bindActKeyBtn();
	searchActKey2();

	// API 명 셀렉트박스 이벤트
	$('#act-key-select-btn').bind("click", function() {
		var actKey = $('#actKeySelect').val();
		$('#actkey-use-list').empty();
		$('#actkey-use-list-mob').empty();
		$.post(getContextPath + "/portal/myPage/selectListUseActKey.do",{actKey : actKey}, function(data) {
			var json = jQuery.parseJSON(data);
			if(json.data.length > 0) {
				$.each(json.data, function(i, d) {
					var innerHTML = "<tr>"
								+ "<td>"+d.regDttm+"</td>"
								+ "<td>"+d.reqCnt+"</td>"
								+ "<td>"+d.rowCnt+"</td>"
								+ "<td>"+d.lendtime+"</td>"
								+ "<td>"+d.dbSize+"</td>";
					var innerHTML_M = "<li>"
								+"	<strong class=\"tit\">"+d.regDttm+"</strong>"
								+"	<dl>"
								+"	<dt>호출</dt>"
								+"	<dd>"+d.reqCnt+"</dd>"
								+"	<dt>데이터</dt>"
								+"	<dd>"+d.rowCnt+"</dd>"
								+"	<dt>평균응답속도(초)</dt>"
								+"	<dd>"+d.lendtime+"</dd>"
								+"	<dt>호출량(KB)</dt>"
								+"	<dd>"+d.dbSize+"</dd>"
								+"	</dl>"
								+"</li>";
					
					$('#actkey-use-list').append(innerHTML);
					$('#actkey-use-list-mob').append(innerHTML_M);
				});
			} else {
				$('#actkey-use-list').html("<tr><td colspan=\"5\" class=\"noData\">해당 자료가 없습니다.</td></tr>");
				$('#actkey-use-list-mob').html($(templates.none_m));
			}
		});
	});
	
}

/**
 * 인증키 발급 버튼
 */
function bindActKeyBtn() {
	$('.btn_AC').bind('click', function() {
		// 페이지 이동해야함
	});
}

/**
 * 인증키 폐기 버튼
 */
function bindDelActKeyBtn() {
	$('#delActKey-btn').bind('click', function() {
		deleteActKey();
	});
}

////////////////////////////////////////////////////////////////////////////////
//서비스 함수
////////////////////////////////////////////////////////////////////////////////
/**
 * 인증키 목록 조회
 */
function searchActKey() {
	doSearch({
        url:"/portal/myPage/searchActKey.do",
        before:function(){return {};},
        after:afterSearchActKey
	});
}
/**
 * 인증키 목록 조회
 */
function searchActKey2() {
	doSearch({
        url:"/portal/myPage/searchActKey.do",
        before:function(){return {};},
        after:afterSearchActKey2
	});
}

/**
 * 인증키 생성
 */
function createActKey() {
    doInsert({
        url:"/portal/myPage/insertActKey.do",
        form:"actkey-insert-form",
        before:beforeInsertActKey,
        after:afterInsertActKey
    });
}

/**
 * openAPI 검색
 */
function searchOpenAPI() {
	doSearch({
        url:"/portal/myPage/searchOpenAPI.do",
        before:beforeSearchOpenAPI,
        after:afterSearchOpenAPI
	});
}

/**
 * API 출력
 */
function outputOpenAPI(infId) {
	if (com.wise.util.isBlank(infId)) {
		alert("API를 선택하세요.");
		$('#APIname').focus();
		return false;
	}
	
	$("#apiSampleTest").html("");
	var sampleUrl = $("#api-ep-url").text();
	$.parseXmlPreview(sampleUrl, "xml", function(res){
		$("#apiSampleTest").html(res);
	});
	
	//$("#api-test-result").attr("src", openAPIListData[infId].uri);
}

/**
 * 인증키 폐기
 */
function deleteActKey() {
	doDelete({
		url:"/portal/myPage/deleteActKey.do",
        before:beforeDeleteActKey,
        after: function() {
        	searchActKey();
        }
	});
}

////////////////////////////////////////////////////////////////////////////////
//전처리 함수
////////////////////////////////////////////////////////////////////////////////
// 인증키 생성의 전처리 함수
function beforeInsertActKey() {
	var form = $('#actkey-insert-form');
	
	if (com.wise.util.isBlank(form.find("[name=useNm]").val())) {
		alert("활용 용도를 입력하여 주십시오.");
		form.find("[name=useNm]").focus();
		return false;
	}
	
	// if (!com.wise.util.isBytes(form.find("[name=useNm]").val(), 1, 200)) {
	// 	alert("활용 용도를 200바이트 이내로 입력하여 주십시오.");
	// 	form.find("[name=useNm]").focus();
	// 	return false;
	// }
	if (!com.wise.util.isLength(form.find("[name=useNm]").val(), 1, 40)) {
		alert("활용 용도를 40자 이내로 입력하여 주십시오.");
		form.find("[name=useNm]").focus();
		return false;
	}

	if (com.wise.util.isBlank(form.find("[name=useCont]").val())) {
		alert("내용을 입력하여 주십시오.");
		form.find("[name=useCont]").focus();
		return false;
	}
	
	// if (!com.wise.util.isBytes(form.find("[name=useCont]").val(), 1, 2000)) {
	// 	alert("내용를 2000바이트 이내로 입력하여 주십시오.");
	// 	form.find("[name=useCont]").focus();
	// 	return false;
	// }
	if (!com.wise.util.isLength(form.find("[name=useCont]").val(), 1, 400)) {
		alert("내용를 400자 이내로 입력하여 주십시오.");
		form.find("[name=useCont]").focus();
		return false;
	}
	
	return true;
}

/**
 * OpenAPI 검색 전 처리 함수
 */
function beforeSearchOpenAPI() {

//	if (com.wise.util.isBlank($("[name=infNm]").val())) {
//		alert("API검색명을 입력하여 주십시오.");
//		$("[name=infNm]").focus();
//		return false;
//	}
	
	return {infNm : $("[name=infNm]").val()};
	
}

/**
 * 인증키 폐기 전처리 함수
 * @returns
 */
function beforeDeleteActKey() {
	var data = {
		actKey : $("input[name=delActKey]:checked").val()
	};
    
    if (com.wise.util.isBlank(data.actKey)) {
        alert("폐기할 인증키를 선택해 주세요.");
        return null;
    }

    if ( !confirm("호출중인 프로그램(앱)이 있으면 더 이상 사용이 불가능 합니다.\n그래도 폐기 하시겠습니까?") )	return null;
    
    return data;
}


////////////////////////////////////////////////////////////////////////////////
//후처리 함수
////////////////////////////////////////////////////////////////////////////////
// 인증키 생성 후 처리함수
function afterInsertActKey(messages) {
	// 첫번째 탭을 보여줌
	selectTab(0);
}

// 인증키 목록 조회 후 처리함수
function afterSearchActKey(data) {
	$('#actkey-list').empty();
	
	if(data.length > 0) {
		$('.totalNum').text(data[0].totalCnt);
		$.each(data, function(i, d) {
			var row = $(templates.data);
			
			row.find(".title").prepend("<label class=\"blind\" for=\"delActKey"+i+"\"></label><input type='radio' id=\"delActKey"+i+"\" name='delActKey' value=\""+d.actKey+"\" />  ");  
			row.find(".actKey").text(d.actKey)
			row.find(".useNm").text(d.useNm);
			row.find(".regDttm").text(d.regDttm);
			row.find(".callCnt").text(d.callCnt);
			row.find(".keyState").text(d.keyState);
			

			$('#actkey-list').append(row);
		});
	} else {
		$('#actkey-list').empty().append($(templates.none));
	}
}

//인증키 목록 조회 후 처리함수2
function afterSearchActKey2(data) {
	if(data.length > 0) {
		$.each(data, function(i, d) {
			$('#actKeySelect').append("<option value=\""+d.actKey+"\">"+d.useNm+" ("+d.actKey+") ("+d.keyState+")</option>");
		});
	} else {
		$('#actKeySelect').html("<option value=\"\">인증키가 없습니다.</option>");
	}
}

// OpenAPI 검색 후 처리 함수
function afterSearchOpenAPI(data) {
	$.each($('#APIname option'), function(i, d) {
		if(i > 0) {
			$(this).remove();
		}
	});
	$.each(data, function(i, d) {
		openAPIListData[d.infId] = d;
		$('#APIname').append("<option value=\""+d.infId+"\">"+d.infNm+"</option>");
	});

	/*var pos = $('#APIname').offset();  // remember position
	  $('#APIname').css("position","absolute");
	  $('#APIname').offset(pos);   // reset position
	var selectSize = data.length+1;
	if(selectSize > 5) {
		selectSize = 5;
	}
	  $('#APIname').attr("size",selectSize); // open dropdown
*/}