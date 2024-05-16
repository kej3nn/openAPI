/***
 * 마이페이지 > 청구기본정보수정 
 * @author 	csb
 * @since	2021/06/15
 */
////////////////////////////////////////////////////////////////////////////////
// 글로벌 변수
////////////////////////////////////////////////////////////////////////////////
/**
 * 템플릿
 */
var templates = {
    data:
        "<tr>"                                                                     +
            "<td><span class=\"mq_tablet rowNum\"></span></td>"                    +
            "<td><span class=\"aplDt\"></span></td>"                               +
            "<td class=\"area_tit\">"                                              +
            	"<input type=\"hidden\" name=\"aplNo\" class=\"aplNo\">"           +              
                "<sapn class=\"tit ellipsis w_400 aplSj\"></span>"                 +
            "</td>"                                                                +
            "<td><span class=\"aplInstNm\"></span></td>"                           +
        "</tr>",
    none:
        "<tr>"                                                              	   +
            "<td colspan=\"4\" class=\"noData\">청구서 자료가 없습니다.</td>" 			   +
        "</tr>"
};

$(function() {
	initComp();
    // 데이터를 로드한다.
    loadData();
    
    bindEvent();
    
    // 옵션을 로드한다.
    //loadOptions();
});

/**
 * 마스크를 바인딩한다.
 */
function initComp() {
}

function bindEvent() {
	
	$('#emailAgree').change(function() {
		if($(this).is(':checked')) {
    		$('[name=emailYn]').val('Y');
    	} else {
    		$('[name=emailYn]').val('N');
    	}
	});

    $("[name=userEmail3]").bind("change", function(event) {
        changeUserEmail($(this).val());
        return false;
    });
    
	$("#updateBtn").bind("click", function() {
		updateUserInfo();
		return false;
	});
	
	$("#findAddrBtn").bind("click", function() {
		fn_zipcode();
		return false;
	});
	
	
	$("#userTel").bind("change", function() {
		var val = $(this).val();
		if(val == '000'){
			$("#userTel2").val("");
			$("#userTel3").val("");
		}
		return false;
	});
	
	$("#userFaxTel").bind("change", function() {
		var val = $(this).val();
		if(val == '000'){
			$("#userFaxTel2").val("");
			$("#userFaxTel3").val("");
		}
		return false;
	});
	
	$("#userHp").bind("change", function() {
		var val = $(this).val();
		if(val == '000'){
			$("#userHp2").val("");
			$("#userHp3").val("");
		}
		return false;
	});
	
	$("#hpYn, #kakaoYn").bind("click", function(e) {
		if( $("input:checkbox[id='hpYn']").is(":checked") && $("input:checkbox[id='kakaoYn']").is(":checked") ) {
			alert("SMS와 카카오알림톡은 동시에 선택할 수 없습니다.");
			return false;
		}
	});
	
	//기존 청구서 불러오기 레이어 팝업 열기 
	$("#popOpnzAplBtn").bind("click", function() {
		// 초기화
		$("#count-sect").text("0");
		$("input[name=aplRno2]").val("");
		$("input[name=aplConnCd]").val("");
		afterSearchMyOpnzAplList("");
		// 팝업 열기
		$("body").addClass('fixed-body');
		$(".mask").fadeIn(300, function() {
			$(".layerpopup-wrapper").show();
		});
	});
	
	//기존 청구서 불러오기 레이어 팝업 닫기
	$(".btn-layerpopup-close").bind("click", function() {
		$(".layerpopup-wrapper").hide();
		
		$(".mask").fadeOut(300, function() {
			$("body").removeClass('fixed-body');
		});
	});
	
	// 라디오 체인지 이벤트
	$("input[name=searchType]").change(function() {
		var thisVal = $(this).val();
		
		if (thisVal == "aplRno2") { // 주민등록번호 뒷자리일 경우
			$("input[name=aplRno2]").attr("readonly", false);
			$("input[name=aplConnCd]").attr("readonly", true).val("");
			
		} else { // 신청연계코드일 경우
			$("input[name=aplRno2]").attr("readonly", true).val("");
			$("input[name=aplConnCd]").attr("readonly", false);
		}

	});
	
	// 기존 청구서 불러오기 
	$("#loadOpnzAplBtn").bind("click", function() {
		searchMyOpnzAplList($("input[name=page]").val());
	});
	
	// 기존 청구서 저장 
	$("#saveOpnzAplBtn").bind("click", function() {
		updateMyOpnzApl();
	})
	
}

/**
 * 옵션을 로드한다.
 */
function loadOptions() {
    
    loadComboOptions("eMail_3", "/portal/common/code/searchCommCode.do", {grpCd:"C1009"}, "na");
}


function loadData() {
	
	selectUserInfo();
}

////////////////////////////////////////////////////////////////////////////////
//서비스 함수
////////////////////////////////////////////////////////////////////////////////

function selectUserInfo() {
    doSelect({
        url:"/portal/myPage/exposeDefaultUpdInfo.do",
        before:function(){return{};},
        after:afterSelectUserInfo
    });
}

function updateUserInfo() {
	if(!confirm("저장 하시겠습니까?")) return false;
	
	doUpdate({
		form:"form",
	    url:"/portal/myPage/updateExposeDefaultUpd.do",
	    before:beforeUpdateUserInfo,
	    after:afterUpdateUserInfo
	});
}

/**
 * 기존 청구서 목록을 조회한다.
 * 
 * @param page {String} 페이지 번호
 */
function searchMyOpnzAplList(page) {
	
    // 데이터를 검색한다.
    doSearch({
        url:"/portal/myPage/searchMyOpnzAplList.do",
        page:page ? page : "1",
        before:beforeSearchMyOpnzAplList,
        after:afterSearchMyOpnzAplList,
        pager:"pager-sect",
        counter:{
            count:"count-sect",
            pages:"pages-sect"
        }
    });
}
/**
 * 기존 청구서 저장
 * @returns {Boolean}
 */
function updateMyOpnzApl() {
	if ( $("td").hasClass("noData") == true ) {
		alert("저장할 청구서가 없습니다.");
		return false;
	} 
	
	if(!confirm("저장 하시겠습니까?")) return false;
	
	doUpdate({
		form:"form",
	    url:"/portal/myPage/updateMyOpnzApl.do",
	    before:function(){return{};},
	    after: function() {
	    	$(".layerpopup-wrapper").hide();
			
			$(".mask").fadeOut(300, function() {
				$("body").removeClass('fixed-body');
			});
	    } 
	});
}


/////////////////////////////////////////////////////////////////////////////////
/////////////////////////// 전처리 함수 //////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
function beforeUpdateUserInfo() {
    var form = $("#form");
    
    if (form.find("[name=userEmail1]").length > 0) {
        if (com.wise.util.isBlank(form.find("[name=userEmail1]").val())) {
            alert("이메일을 입력하여 주십시오.");
            form.find("[name=userEmail1]").focus();
            return false;
        }
    }
    if (form.find("[name=userEmail2]").length > 0) {
        if (com.wise.util.isBlank(form.find("[name=userEmail2]").val())) {
            alert("이메일을 입력하여 주십시오.");
            form.find("[name=userEmail2]").focus();
            return false;
        }
    }
    if (form.find("[name=userEmail3]").length > 0) {
        var email = form.find("[name=userEmail1]").val() + "@" + form.find("[name=userEmail2]").val();
        
        if (email.length > 1 && !com.wise.util.isEmail(email)) {
            alert("이메일 헝식이 아닙니다.");
            form.find("[name=userEmail1]").focus();
            return false;
        }
    }
    
    if (form.find("[name=userZip]").length > 0) {
        
    	if (com.wise.util.isBlank(form.find("[name=user2Saddr]").val())) {
            alert("상세주소를 입력하여 주십시오.");
            form.find("[name=user2Saddr]").focus();
            return false;
        }
    }
	return true;	
}

/**
 *  기존청구서 목록 전처리를 실행한다.
 * 
 * @param options {Object} 옵션
 * @returns {Object} 데이터
 */
function beforeSearchMyOpnzAplList(options) {
    var data = {};
    var form = $("#form");
    var chkVal = $("input[name=searchType]:checked").val();
    
    if (chkVal == "aplRno2") { 
    	if (com.wise.util.isBlank(form.find("[name=aplRno2]").val())) {
            alert("주민등록번호 뒷자리를 입력하여 주십시오.");
            form.find("[name=aplRno2]").focus();
            return false;
        }
    } else {
    	if (com.wise.util.isBlank(form.find("[name=aplConnCd]").val())) {
            alert("신청연계 코드를 입력하여 주십시오.");
            form.find("[name=aplConnCd]").focus();
            return false;
        }
    }
    
    if (com.wise.util.isBlank(options.page)) {
        form.find("[name=page]").val("1");
    }
    else {
        form.find("[name=page]").val(options.page);
    }
    
    $.each(form.serializeArray(), function(index, element) {
    	data[element.name] = element.value;
    });

    return data;
}

/////////////////////////////////////////////////////////////////////////////////
/////////////////////////// 후처리 함수 //////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////


function afterSelectUserInfo(data) {
	var userNm = data.userNm;
	var userHp = data.userHp;
	var userFaxTel = data.userFaxTel;
	var userTel = data.userTel;
	var userEmail = data.userEmail;
	var emailYn = data.emailYn;
	var hpYn = data.hpYn;
	var kakaoYn = data.kakaoYn;
	var userZip = data.userZip;
	var user1Addr = data.user1Addr;
	var user2Saddr = data.user2Saddr;
	

	$("[name=userNm]").val(userNm);
	$("[name=userZip]").val(userZip);
	$("[name=user1Addr]").val(user1Addr);
	$("[name=user2Saddr]").val(user2Saddr);

	if(!com.wise.util.isBlank(userHp)) {
		var telObj = ["userHp","userHp2","userHp3"];
		var telArr = userHp.split('-');
		$.each(telArr, function(i, d) {
			$('#'+telObj[i]).val(d);
		});
	}
	
	if(!com.wise.util.isBlank(userTel)) {
		var telObj = ["userTel","userTel2","userTel3"];
		var telArr = userTel.split('-');
		$.each(telArr, function(i, d) {
			$('#'+telObj[i]).val(d);
		});
	}
	
	if(!com.wise.util.isBlank(userFaxTel)) {
		var telObj = ["userFaxTel","userFaxTel2","userFaxTel3"];
		var telArr = userFaxTel.split('-');
		$.each(telArr, function(i, d) {
			$('#'+telObj[i]).val(d);
		});
	}
	
	if(!com.wise.util.isBlank(userEmail)) {
		var emailObj = ["eMail", "eMail_2", "eMail_3"];
		var emailArr = userEmail.split('@');
		$.each(emailArr, function(i, d) {
			$('#'+emailObj[i]).val(d);
		});
	}
	
	if(emailYn == 'Y') {
		$('#emailYn').attr('checked', true);
	}
	if(hpYn == 'Y') {
		$('#hpYn').attr('checked', true);
	}
	if(kakaoYn == 'Y') {
		$('#kakaoYn').attr('checked', true);
	}
}

function afterUpdateUserInfo(data) {
	selectUserInfo();
}

/**
 * 기존청구서 목록 후처리를 실행한다.
 * 
 * @param data {Array} 데이터
 */
function afterSearchMyOpnzAplList(data) {
	var table = $("#data-table");
	var mbHtml = "";
	table.find("tr").each(function(index, element) {
        if (index > 0) {
            $(this).remove();
        }
    });
	$("#count-sect-mb").text($("#count-sect").text());
	
	for (var i = 0; i < data.length; i++) {
		var row = $(templates.data);
		
		row.find(".rowNum").text(getRowNumber($("#count-sect").text(), "" + data[i].ROW_NUM));
		row.find(".aplDt").text(data[i].aplDt);
		row.find(".aplNo").val(data[i].aplNo);
		row.find(".aplSj").text(data[i].aplSj);
        row.find(".aplInstNm").text(data[i].aplInstNm);
        
        mbHtml += "<div class=\"expo_box\">";
        mbHtml += "	<strong>"+data[i].aplSj+"</strong>";
        mbHtml += "	<ul>";
        mbHtml += "		<li>"+data[i].aplInstNm+"</li>";
        mbHtml += "		<li>"+data[i].aplDt+"</li>";
        mbHtml += "	</ul>";
        mbHtml += "</div>";
        
        table.append(row);
        
       $("#mbList").empty().append(mbHtml);
	}
	
	if (data.length == 0) {
        var row = $(templates.none);
       
        mbHtml += "<div class=\"expo_nodata\">청구서 자료가 없습니다.</div>";
        $("#mbList").empty().append(mbHtml);
        table.append(row);
    }
}
/////////////////////////////////////////////////////////////////////////////////
/////////////////////////// 기타 함수 //////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

function changeUserEmail(value) {
	   if (value == "na") {
	       $("[name=userEmail2]").prop("readonly", false);
	   }
	   else {
	       $("[name=userEmail2]").prop("readonly", true).val(value);
	   }
	}
//우편번호 팝업
function fn_zipcode(){
	var wname = "우편번호검색";

	var url = com.wise.help.url("/portal/expose/roadSearchAddrPage.do");
	var w = 500;
	var h = 720;
	var LP = (screen.width) ? (screen.width - w) / 2 : 100;
	var TP = (screen.height) ? (screen.height - h) / 3 : 100;
	var setting = "height=" + h + ", width=" + w + ", top=" + TP + ", left=" + LP;
 	window.open(url, wname, setting);
}
