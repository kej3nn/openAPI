/**
 * @(#)naDataComm.js 1.0 2019/08/12
 * 
 * 국회보고서 스크립트 파일이다.
 * 
 * @author CSB
 * @version 1.0 2019/08/12
 */

////////////////////////////////////////////////////////////////////////////////
// SCRIPT INIT
////////////////////////////////////////////////////////////////////////////////
$(function() {
	
	bindEvent();
	
    // 데이터를 로드한다.
    loadData();
	
});

function bindEvent() {
	// 검색 이벤트
	$(".group_btn").bind("click", function(event) {
		searchNaComm("1");
		return false;
	});
	
    // 검색어 필드에 키다운 이벤트를 바인딩한다.
	$("#searchWord").bind("keydown", function(event) {
        // 엔터키인 경우
        if (event.which == 13) {
            // 데이터 파일을 검색한다.
        	searchNaComm("1");
            return false;
        }
    });
	
}

/**
 * 데이터를 로드한다.
 */
function loadData() {
    // 보고서&발간물 내용을 검색한다.
    searchNaComm($("#form [name=page]").val());
}

////////////////////////////////////////////////////////////////////////////////
//서비스 함수
////////////////////////////////////////////////////////////////////////////////
/**
* 보고서&발간물 내용을 검색한다.
* 
* @param page {String} 페이지 번호
*/
function searchNaComm(page) {
	
	// 데이터를 검색한다.
	doSearch({
		url:"/portal/nadata/catalog/searchNaDataComm.do",
		page:page ? page : "1",
		before:beforeSearchNaComm,
		after:afterSearchNaComm,
		pager : "result-pager-sect",
		counter:{
			count:"result-count-sect",
			pages:"result-pages-sect"
		}
	});
}

////////////////////////////////////////////////////////////////////////////////
//전처리 함수
////////////////////////////////////////////////////////////////////////////////
/**
*  보고서&발간물 내용 검색 전처리를 실행한다.
* 
* @param options {Object} 옵션
* @returns {Object} 데이터
*/
function beforeSearchNaComm(options) {
    var data = {
            // Nothing do do.
    };
        
    var form = $("#form");
        
    if (com.wise.util.isBlank(options.page)) {
    	form.find("[name=page]").val("1");
    } else {
    	form.find("[name=page]").val(options.page);
	}
        
    $.each(form.serializeArray(), function(index, element) {
    	data[element.name] = element.value;
    });
        
	return data;
}

////////////////////////////////////////////////////////////////////////////////
//후처리 함수
////////////////////////////////////////////////////////////////////////////////
/**
* 보고서&발간물 내용 검색 후처리를 실행한다.
* 
* @param data {Array} 데이터
*/
function afterSearchNaComm(data) {
	var rlbox = $(".rlbox>ul");
 
	rlbox.empty();
 
	for (var i = 0; i < data.length; i++) {
		
		var liHtml = "";
		liHtml += "<li>";
		liHtml += "<a id='"+data[i].infId+"' href='/portal/data/service/selectServicePage.do/"+ data[i].infId + "' target=_blank>";
		liHtml += "<img src='' alt='"+data[i].infNm+"' height='134' width='95'>";
		liHtml += "<span>"+ com.wise.util.ellipsis(data[i].infNm, 28) +"</span>";
		liHtml += "</a></li>";
		
		rlbox.append(liHtml);
		
		if(data[i].tmnlImgFile == null){
			$("#"+data[i].infId).find("img").attr("src", "/images/img0200.png");
		}else{
    		//이미지 표시
			$("#"+data[i].infId).find("img").attr("src", "/portal/nadata/catalog/selectNaDataCommThumbnail.do?srvCd="+data[i].srvCd+"&tmnlImgFile=" + data[i].tmnlImgFile);

		}
    }
	
	//이전, 이후 처리 > 페이지확인
	var resultPagesSet = $("#result-pages-sect").text().replace("(", "").replace(" page)","");
	var pageArr = resultPagesSet.split("/");
	var nowPage = Number(pageArr[0]);
	var totPage = Number(pageArr[1]);
	
	//이전버튼 활성화 여부 및 클릭이벤트
	if(nowPage == 1){
		$(".ra_left").hide();
	}else{
		$(".ra_left").show();
		$(".ra_left").bind("click", function(event) {
			searchNaComm(String(nowPage-1));
		});
	}
	
	//이후버튼 활성화 여부 및 클릭이벤트
	if(nowPage == totPage){
		$(".ra_right").hide();
	}else{
		$(".ra_right").show();
		$(".ra_right").bind("click", function(event) {
			searchNaComm(String(nowPage+1));
		});
	}
	
}
