
/**
 * @(#)infsList.js 1.0 2019/08/13
 * 
 * 활용 갤러리 목록 스크립트 파일이다.
 * 
 * @author JSSON
 * @version 1.0 2019/08/13
 */
////////////////////////////////////////////////////////////////////////////////
// GLOBAL VARIABLE
////////////////////////////////////////////////////////////////////////////////

// 템플릿 객체
var template = {
	item: 
		/*"<div class=\"list_box\">" +
		"	<div>" +
		"		<span class=\"m_list1SubCd m_cate\"></span>" +
		"	</div>" +
		"	<div class=\"box_content\">" +
		"		<div class=\"bchead\">" +
		"				<a href=\"javascript:;\">"+
		"			<span class=\"icon fileSeq\"></span>" +
		"				</a>"+
		"		</div>" +
		"		<div class=\"list_box_content\">" +
		"			<div class=\"list_box_head\">" +
		"				<a href=\"javascript:;\"><span class=\"tit bbsTit infaNm\"></span></a>" +
		"				<span class=\"name userNm\"></span>"    +               
        "				<span class=\"date userDttm\"></span>"  +
		"			</div>" +
		"			<div class=\"list_box_cont\">" +
		"				<span class=\"grade apprVal\"></span>"  +
		"			</div>" +
		"		</div>" +
		" 		<span class=\"list1SubCd cateNm\"></span>" +
		"	</div>" +
		"</div>",*/
		"<div class=\"list_box\">" +
		"	<div class=\"pf_gt\">" +
		"		<span class=\"m_cate\"></span>" +
		"		<span class=\"opentyTagNm ot01\"></span>" +
		"	</div>" +
		"	<div class=\"box_content\">" +
		"		<div class=\"bchead\">" +
		"			<span class=\"cateNm\"></span>" +
		"		</div>" +
		"		<div class=\"list_box_content\">" +
		"			<div class=\"list_box_head\">" +
		"				<a href=\"javascript:;\"><span class=\"title bbsTit infaNm\"></span></a>" +
		"				<div class=\"openYmd userDttm\"></div>" +
		"			</div>" +
		"			<div class=\"list_box_cont m_none\">" +
		"				<span class=\"grade apprVal\"></span>"  +
		"			</div>" +
		"		</div>" +
		"	</div>" +
		"</div>",
		none:
	        "<li class=\"noData\">해당 자료가 없습니다.</li>"
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
	
	loadGalleryList($("input[name=page]").val());
}

function loadGalleryList(page) {
	page = page || 1;
	
	gfn_showLoading();
	
	var loadSuccess = function() {
		var deferred = $.Deferred();
		try {
			searchGallery(page);
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
	var formData = $("#gallery-search-form").serializeObject();
	Object.keys(formData).map(function(key, idx) {
		if ( key.indexOf("schHdn") == 0 ) {
			var data = formData[key];

			switch (key) {
			case "schHdnUsedId":
				if ( data.length > 0 ) {
					$("#btnUsedAll").removeClass("on");
					$("#btnUsedAll").attr("aria-selected", false);
					if ( typeof data === 'object' ) {
						for ( var i in data ) {
							$("button[id^=btnUsedId][data-gubun="+data[i]+"]").addClass("on");
							$("button[id^=btnUsedId][data-gubun="+data[i]+"]").attr("aria-selected", true);
						} 
					} else if ( typeof data === 'string' ) {
						$("button[id^=btnUsedId][data-gubun="+data+"]").addClass("on");
						$("button[id^=btnUsedId][data-gubun="+data+"]").attr("aria-selected", true);
					}
					// 모바일 선택처리
					$("a[id^=btnMbUsed]").removeClass("on");
					$("button[id^=btnUsed]").each(function() {
						if ( $(this).hasClass("on") ) {
							$("a[id^=btnMbUsed][data-gubun="+$(this).attr("data-gubun")+"]").addClass("on");
						}
					});
				}
				break;
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
			}
		}
	});
	
}

/**
 * 활용갤러리 목록을 조회한다.
 * @param page	페이지
 * @returns
 */
function searchGallery(page) {
	page = page || 1;
	doSearch({
		url : "/portal/bbs/gallery/searchBulletin.do",
		page : page,
		before : beforeSelectGallery,
		after : afterSelectGallery,
		pager : "result-sect-pager",
		counter: {
			count:"result-count-sect",
            pages:"result-pages-sect"
		}
	});
}

/**
 * 활용갤러리 목록 조회 전처리
 */
function beforeSelectGallery(options) {
	var form = $("#gallery-search-form");
	
	if (com.wise.util.isEmpty(options.page)) {
		form.find("[name=page]").val("1");
	} else {
		form.find("[name=page]").val(options.page);
	}
	$("input[name=rows]").val($("#selRows").val());		// 조회행 수
	
	// 정렬 값이 없을경우 기본값으로 공개일자 처리
	if ( com.wise.util.isEmpty(form.find("input[name=schVOrder]").val()) ) {
		addInputHidden({
			formId: "gallery-search-form",
			objId: "schVOrder",
			val: "D"
		});
		form.find("#btnVOrderDate").addClass("on");
	}
	var data = form.serializeObject();
	return data;
}

/**
 * 활용갤러리 목록 조회 후처리
 * @param datas
 * @returns
 */
function afterSelectGallery(datas) {
	var item = "",
		data = null,
		list = $("#result-sect-list");
	
	list.empty();
	if ( datas.length > 0 ) {
		for ( var i in datas ) {
			data = datas[i];
			
			item = $(template.item);
			
			/*if (data.fileSeq) {
	            var url = com.wise.help.url("/portal/bbs/gallery/selectAttachFile.do") + "?fileSeq=" + data.fileSeq;
	            
	            item.find(".fileSeq").html("<div><img src=\"" + url + "\" alt=\"" + data.bbsTit + " thumbnail" + "\" /></div>");
	        }
	        else {
	            item.find(".fileSeq").html("<img alt=\"" + data.bbsTit + "\" />");
	        }*/
			
			// 아이콘 카테고리 ID에 따라 달라진다
			var cateIdIdx = "";
			if(data.cateId != null){
				cateIdIdx = data.cateId.substr(2, 1) || "1";
				if ( Number(cateIdIdx) > 5 ) {
					cateIdIdx = "99";
				}
			}else{
				cateIdIdx = "99"
			}
			
			item.find(".bchead").addClass("lb0" + cateIdIdx);
			item.find(".m_cate").text(!com.wise.util.isEmpty(data.cateNm) ? data.cateNm : "기타");
			item.find(".cateNm").text(!com.wise.util.isEmpty(data.cateNm) ? data.cateNm : "기타");
			
			item.find(".bbsTit").parent("a").attr("title", data.bbsTit);
			//item.find(".userNm").text(data.userNm);
			item.find(".infaExp").text(com.wise.util.ellipsis(data.infaExp, 40));
			item.find(".userDttm").text(data.userNm + " | " + data.userDttm);
			item.find(".apprVal").html(getAppraisal(data.apprVal));
			var usedGubun = ""; 
			if (data.listSubCd == "APP") {
				usedGubun = "앱";
			} else if (data.listSubCd == "INFO") {
				usedGubun ="인포그래픽";
			} else if (data.listSubCd == "WEB") {
				usedGubun = "웹사이트";
			}
			item.find(".opentyTagNm").text(usedGubun);
			//item.find(".list1SubCd").text(data.list1SubCd);
			item.find(".bbsTit").html(data.bbsTit)
				.bind("click", {
					bbsCd:data.bbsCd,
					seq: data.seq,
					noticeYn: data.noticeYn,
					lockTag:data.lockTag,
					cateId:data.cateId,
					cateNm:data.cateNm
					}, function(event) {
						selectGalleryDtl(event.data);
						return false;
					});
			
			item.find(".bbsTit").parent().bind("keydown", {
				bbsCd: data.bbsCd,
				seq: data.seq,
				noticeYn: data.noticeYn,
				lockTag:data.lockTag,
				cateId:data.cateId,
				cateNm:data.cateNm
				}, function(event) {
				if (event.which == 13) {
					selectGalleryDtl(event.data);
					return false;
				}
			});
			item.find(".bchead")
			.bind("click", {
				bbsCd:data.bbsCd,
				seq: data.seq,
				noticeYn: data.noticeYn,
				lockTag:data.lockTag
				}, function(event) {
					selectGalleryDtl(event.data);
					return false;
				});
			
			list.append(item);
		}
	}
	else {
		list.append("조회된 데이터가 없습니다.");
	}
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
function selectGalleryDtl(data) {
	// 데이터를 조회하는 화면으로 이동한다.
    goSelect({
        url:"/portal/bbs/gallery/selectBulletinPage.do",
        form:"gallery-search-form",
        data:[{
            name:"bbsCd",
            value:data.bbsCd
        }, {
            name:"seq",
            value:data.seq
        }, {
            name:"noticeYn",
            value:data.noticeYn
        }, {
            name:"isKeepSchParam",
            value: "Y"
        }, {
            name:"cateId",
            value:data.cateId
        }, {
            name:"cateNm",
            value:data.cateNm
        }]
    });
}



/**
 * 갤러리 활용사례 평가점수를 반환한다.
 * 
 * @param value {Object} 점수
 */
function getAppraisal(value) {
    if (value == 0.0) {
        return "<img src=\"" + com.wise.help.url("/img/ggportal/desktop/common/grade_0.png") + "\" class=\"icon_grade\" alt=\"총점 5점 중 평점 0점 아주 나쁨\" />";
    }
    else if (value > 0.0 && value <= 0.5) {
        return "<img src=\"" + com.wise.help.url("/img/ggportal/desktop/common/grade_1.png") + "\" class=\"icon_grade\" alt=\"총점 5점 중 평점 0.5점 아주 나쁨\" />";
    }
    else if (value > 0.5 && value <= 1.0) {
        return "<img src=\"" + com.wise.help.url("/img/ggportal/desktop/common/grade_2.png") + "\" class=\"icon_grade\" alt=\"총점 5점 중 평점 1점 아주 나쁨\" />";
    }
    else if (value > 1.0 && value <= 1.5) {
        return "<img src=\"" + com.wise.help.url("/img/ggportal/desktop/common/grade_3.png") + "\" class=\"icon_grade\" alt=\"총점 5점 중 평점 1.5점 아주 나쁨\" />";
    }
    else if (value > 1.5 && value <= 2.0) {
        return "<img src=\"" + com.wise.help.url("/img/ggportal/desktop/common/grade_4.png") + "\" class=\"icon_grade\" alt=\"총점 5점 중 평점 2점 나쁨\" />";
    }
    else if (value > 2.0 && value <= 2.5) {
        return "<img src=\"" + com.wise.help.url("/img/ggportal/desktop/common/grade_5.png") + "\" class=\"icon_grade\" alt=\"총점 5점 중 평점 2.5점 나쁨\" />";
    }
    else if (value > 2.5 && value <= 3.0) {
        return "<img src=\"" + com.wise.help.url("/img/ggportal/desktop/common/grade_6.png") + "\" class=\"icon_grade\" alt=\"총점 5점 중 평점 3점 보통\" />";
    }
    else if (value > 3.0 && value <= 3.5) {
        return "<img src=\"" + com.wise.help.url("/img/ggportal/desktop/common/grade_7.png") + "\" class=\"icon_grade\" alt=\"총점 5점 중 평점 3.5점 보통\" />";
    }
    else if (value > 3.5 && value <= 4.0) {
        return "<img src=\"" + com.wise.help.url("/img/ggportal/desktop/common/grade_8.png") + "\" class=\"icon_grade\" alt=\"총점 5점 중 평점 4점 좋음\" />";
    }
    else if (value > 4.0 && value <= 4.5) {
        return "<img src=\"" + com.wise.help.url("/img/ggportal/desktop/common/grade_9.png") + "\" class=\"icon_grade\" alt=\"총점 5점 중 평점 4.5점 좋음\" />";
    }
    else if (value > 4.5) {
        return "<img src=\"" + com.wise.help.url("/img/ggportal/desktop/common/grade_10.png") + "\" class=\"icon_grade\" alt=\"총점 5점 중 평점 5점 아주 좋음\" />";
    }
    else {
        return "<img src=\"" + com.wise.help.url("/img/ggportal/desktop/common/grade_0.png") + "\" class=\"icon_grade\" alt=\"총점 5점 중 평점 0점 아주 나쁨\" />";
    }
}
